//
//  ContentView.swift
//  GestureLib
//
//  Created by Tyson Lupul on 2023-06-05.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var textColor: Color = .primary
       
    let motionManager = CMMotionManager()
    
    var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                    .foregroundColor(textColor)
            }
            .padding()
            .onAppear {
                startBumpGestureDetection()
            }
            .onDisappear {
                stopBumpGestureDetection()
            }
        }
    
        func startBumpGestureDetection() {
            if motionManager.isAccelerometerAvailable {
                motionManager.accelerometerUpdateInterval = 0.1
                
                motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                    guard let acceleration = data?.acceleration else { return }
                    
                    let magnitude = sqrt(pow(acceleration.x, 2) + pow(acceleration.y, 2) + pow(acceleration.z, 2))
                    if magnitude > 2.0 {
                        DispatchQueue.main.async {
                            self.handleBumpGesture()
                        }
                    }
                }
            }
        }

    
        func stopBumpGestureDetection() {
            motionManager.stopAccelerometerUpdates()
        }
        
        func handleBumpGesture() {
            textColor = .blue
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
