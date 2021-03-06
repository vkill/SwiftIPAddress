//
// Copyright © Andrew Dunn, 2017
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
import IPAddress

class IPv4AddressTests: XCTestCase {
    
    /// Test unspecified address detection.
    func testIsUnspecified() {
        var address = IPv4Address(parts: 0,0,0,0)
        XCTAssertTrue(address.isUnspecified)
        address = IPv4Address(parts: 1,0,0,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 255,0,0,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,1,0,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,255,0,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,0,1,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,0,255,0)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,0,0,1)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 0,0,0,255)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 1,1,1,1)
        XCTAssertFalse(address.isUnspecified)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertFalse(address.isUnspecified)
    }
    
    /// Test the loopback address detection.
    func testIsLoopback() {
        var address = IPv4Address(parts: 127,0,0,0)
        XCTAssertTrue(address.isLoopback)
        address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isLoopback)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertFalse(address.isLoopback)
        address = IPv4Address(parts: 126,0,0,0)
        XCTAssertFalse(address.isLoopback)
        address = IPv4Address(parts: 128,0,0,0)
        XCTAssertFalse(address.isLoopback)
        address = IPv4Address(parts: 127,0,0,255)
        XCTAssertTrue(address.isLoopback)
        address = IPv4Address(parts: 127,0,255,255)
        XCTAssertTrue(address.isLoopback)
        address = IPv4Address(parts: 127,255,255,255)
        XCTAssertTrue(address.isLoopback)
    }
    
    /// Test for private address detection.
    func testIsPrivate() {
        // 10.0.0.0/8
        var address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 9,0,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 11,0,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 10,0,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,0,0,1)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,0,0,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,0,1,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,0,255,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,1,255,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 10,255,255,255)
        XCTAssertTrue(address.isPrivate)
        
        // 172.16.0.0/12
        address = IPv4Address(parts: 172,0,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 172,0x0F,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 172,0x20,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 171,0x10,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 173,0x10,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 172,0x10,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,0x11,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,0x1F,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,1,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,255,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,255,1)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,255,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,0,1)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,0,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 172,16,1,255)
        XCTAssertTrue(address.isPrivate)
        
        // 192.168.0.0/16
        address = IPv4Address(parts: 192,0,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 192,167,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 192,169,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 191,168,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 193,168,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 192,255,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 255,168,0,0)
        XCTAssertFalse(address.isPrivate)
        address = IPv4Address(parts: 192,168,0,0)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 192,168,0,1)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 192,168,0,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 192,168,1,255)
        XCTAssertTrue(address.isPrivate)
        address = IPv4Address(parts: 192,168,255,255)
        XCTAssertTrue(address.isPrivate)
    }
    
    /// Test for link-local address detection.
    func testIsLinkLocal() {
        var address = IPv4Address(parts: 169,0,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 169,253,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 169,255,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 168,254,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 170,254,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 255,254,0,0)
        XCTAssertFalse(address.isLinkLocal)
        address = IPv4Address(parts: 169,254,0,0)
        XCTAssertTrue(address.isLinkLocal)
        address = IPv4Address(parts: 169,254,0,1)
        XCTAssertTrue(address.isLinkLocal)
        address = IPv4Address(parts: 169,254,0,255)
        XCTAssertTrue(address.isLinkLocal)
        address = IPv4Address(parts: 169,254,1,255)
        XCTAssertTrue(address.isLinkLocal)
        address = IPv4Address(parts: 169,254,255,255)
        XCTAssertTrue(address.isLinkLocal)
    }
    
    /// Test for globally routable address detection.
    func testIsGlobal() {
        // Test that the unspecified address is not globally routable.
        //
        // 0.0.0.0/8
        var address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isGlobal)
        
        // Test that private addresses are not globally routable.
        //
        // 10.0.0.0/8
        address = IPv4Address(parts: 9,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 11,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 10,0,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,0,0,1)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,0,0,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,0,1,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,0,255,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,1,255,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 10,255,255,255)
        XCTAssertFalse(address.isGlobal)
        // 172.16.0.0/12
        address = IPv4Address(parts: 172,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 172,0x0F,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 172,0x20,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 171,0x10,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 173,0x10,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 172,0x10,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,0x11,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,0x1F,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,1,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,255,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,255,1)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,255,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,0,1)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,0,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 172,16,1,255)
        XCTAssertFalse(address.isGlobal)
        // 192.168.0.0/16
        address = IPv4Address(parts: 192,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,167,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,169,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 191,168,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 193,168,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,255,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,168,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,168,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 192,168,0,1)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 192,168,0,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 192,168,1,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 192,168,255,255)
        XCTAssertFalse(address.isGlobal)
        
        // Test that loopback addresses are not globally routable.
        //
        address = IPv4Address(parts: 127,0,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 126,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 128,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 127,0,0,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 127,0,255,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 127,255,255,255)
        XCTAssertFalse(address.isGlobal)
        
        // Test that link-local addresses are not globally routable.
        //
        address = IPv4Address(parts: 169,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 169,253,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 169,255,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 168,254,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 170,254,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,254,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 169,254,0,0)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 169,254,0,1)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 169,254,0,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 169,254,1,255)
        XCTAssertFalse(address.isGlobal)
        address = IPv4Address(parts: 169,254,255,255)
        XCTAssertFalse(address.isGlobal)
        
        // Test that the broadcast address is not globally routable.
        //
        address = IPv4Address(parts: 0,0,0,255)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 0,0,255,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 0,255,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,0,0,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,255,255,254)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,255,254,255)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,254,255,255)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 254,255,255,255)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertFalse(address.isGlobal)
        
        // Test that the IP-ranges reserved for documentation are not marked as
        // globally routable.
        //
        // TEST-NET-1 (192.0.2.0/24)
        address = IPv4Address(parts: 192,0,1,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,0,3,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,255,2,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,1,2,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 191,0,2,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 193,0,2,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 192,0,2,0)
        XCTAssertFalse(address.isGlobal)
        // TEST-NET-2 (198.51.100.0/24)
        address = IPv4Address(parts: 198,51,99,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 198,51,101,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 198,50,100,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 198,52,100,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 197,51,100,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 199,51,100,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 198,51,100,0)
        XCTAssertFalse(address.isGlobal)
        // TEST-NET-3 (203.0.113.0/24)
        address = IPv4Address(parts: 203,0,112,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 203,0,114,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 203,255,113,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 203,1,113,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 202,0,113,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 204,0,113,0)
        XCTAssertTrue(address.isGlobal)
        address = IPv4Address(parts: 203,0,113,0)
        XCTAssertFalse(address.isGlobal)
    }
    
    /// Test for multicast address detection.
    func testIsMulticast() {
        var address = IPv4Address(parts: 223,0,0,0)
        XCTAssertFalse(address.isMulticast)
        address = IPv4Address(parts: 240,0,0,0)
        XCTAssertFalse(address.isMulticast)
        address = IPv4Address(parts: 224,0,0,0)
        XCTAssertTrue(address.isMulticast)
        address = IPv4Address(parts: 239,0,0,0)
        XCTAssertTrue(address.isMulticast)
        address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isMulticast)
        address = IPv4Address(parts: 255,0,0,0)
        XCTAssertFalse(address.isMulticast)
        address = IPv4Address(parts: 224,255,255,255)
        XCTAssertTrue(address.isMulticast)
        address = IPv4Address(parts: 239,255,255,255)
        XCTAssertTrue(address.isMulticast)
    }
    
    /// Test for broadcast address detection.
    func testIsBroadcast() {
        var address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 0,0,0,255)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 0,0,255,0)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 0,255,0,0)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 255,0,0,0)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 255,255,255,254)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 255,255,254,255)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 255,254,255,255)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 254,255,255,255)
        XCTAssertFalse(address.isBroadcast)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertTrue(address.isBroadcast)
    }
    
    /// Test for IP Addresses that are reserved for documentation.
    func testIsDocumentation() {
        var address = IPv4Address(parts: 0,0,0,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertFalse(address.isDocumentation)
        
        // TEST-NET-1.
        //
        // 192.0.2.0/24
        address = IPv4Address(parts: 192,0,1,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 192,0,3,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 192,255,2,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 192,1,2,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 191,0,2,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 193,0,2,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 192,0,2,0)
        XCTAssertTrue(address.isDocumentation)
        
        // TEST-NET-2.
        //
        // 198.51.100.0/24
        address = IPv4Address(parts: 198,51,99,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 198,51,101,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 198,50,100,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 198,52,100,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 197,51,100,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 199,51,100,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 198,51,100,0)
        XCTAssertTrue(address.isDocumentation)
        
        // TEST-NET-3.
        //
        // 203.0.113.0/24
        address = IPv4Address(parts: 203,0,112,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 203,0,114,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 203,255,113,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 203,1,113,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 202,0,113,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 204,0,113,0)
        XCTAssertFalse(address.isDocumentation)
        address = IPv4Address(parts: 203,0,113,0)
        XCTAssertTrue(address.isDocumentation)
    }
    
    /// Test that predefined addresses are correct.
    func testStaticValues() {
        XCTAssertTrue(IPv4Address.any.isUnspecified)
        XCTAssertEqual(IPv4Address.any.octets, [0,0,0,0])
        XCTAssertTrue(IPv4Address.broadcast.isBroadcast)
        XCTAssertEqual(IPv4Address.broadcast.octets, [255,255,255,255])
        XCTAssertTrue(IPv4Address.loopback.isLoopback)
        XCTAssertEqual(IPv4Address.loopback.octets, [127,0,0,1])
    }
    
    /// Test that constructors set the value of the address properly.
    func testValue() {
        var address: IPv4Address
        address = IPv4Address()
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x00000000)
        address = IPv4Address(parts: 0,0,0,0)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x00000000)
        address = IPv4Address(fromOctets: [0,0,0,0])
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x00000000)
        address = IPv4Address(fromUInt32: 0x00000000)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x00000000)
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xFFFFFFFF)
        address = IPv4Address(fromOctets: [255,255,255,255])
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xFFFFFFFF)
        address = IPv4Address(fromUInt32: 0xFFFFFFFF)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xFFFFFFFF)
        address = IPv4Address(parts: 178,152,71,53)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x354798B2)
        address = IPv4Address(fromOctets: [178,152,71,53])
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x354798B2)
        address = IPv4Address(fromUInt32: 0x354798B2)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0x354798B2)
        address = IPv4Address(parts: 61,105,180,185)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xB9B4693D)
        address = IPv4Address(fromOctets: [61,105,180,185])
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xB9B4693D)
        address = IPv4Address(fromUInt32: 0xB9B4693D)
        XCTAssertEqual(UInt32(fromIPv4Address: address), 0xB9B4693D)
    }
    
    /// Test that the octet array extraction works as expected.
    func testOctets() {
        var address: IPv4Address
        address = IPv4Address(parts: 0,0,0,0)
        XCTAssertEqual(address.octets, [0,0,0,0])
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertEqual(address.octets, [255,255,255,255])
        address = IPv4Address(parts: 178,152,71,53)
        XCTAssertEqual(address.octets, [178,152,71,53])
        address = IPv4Address(parts: 61,105,180,185)
        XCTAssertEqual(address.octets, [61,105,180,185])
    }
    
    /// Test that IP Addresses can be converted to a string correctly.
    func testStringConversion() {
        var address: IPv4Address
        address = IPv4Address()
        XCTAssertEqual(address.description, "0.0.0.0")
        XCTAssertEqual("\(address)", "0.0.0.0")
        address = IPv4Address(parts: 255,255,255,255)
        XCTAssertEqual(address.description, "255.255.255.255")
        XCTAssertEqual("\(address)", "255.255.255.255")
        address = IPv4Address(parts: 178,152,71,53)
        XCTAssertEqual(address.description, "178.152.71.53")
        XCTAssertEqual("\(address)", "178.152.71.53")
    }
    
    /// Test that the equality/inequality operators work as expected.
    func testEqualityOperators() {
        var address1 = IPv4Address()
        var address2 = IPv4Address(parts: 0,0,0,0)
        XCTAssertTrue(address1 == address2)
        XCTAssertFalse(address1 != address2)
        XCTAssertEqual(address1, address2)
        address2 = IPv4Address(parts: 0,0,0,1)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 0,0,1,0)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 0,1,0,0)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 1,0,0,0)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address1 = IPv4Address(parts: 255,255,255,255)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 255,255,255,255)
        XCTAssertTrue(address1 == address2)
        XCTAssertFalse(address1 != address2)
        XCTAssertEqual(address1, address2)
        address2 = IPv4Address(parts: 255,255,255,254)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 255,255,254,255)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 255,254,255,255)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address2 = IPv4Address(parts: 254,255,255,255)
        XCTAssertFalse(address1 == address2)
        XCTAssertTrue(address1 != address2)
        XCTAssertNotEqual(address1, address2)
        address1 = IPv4Address(parts: 61,105,180,185)
        address2 = IPv4Address(fromOctets: [61,105,180,185])
        XCTAssertTrue(address1 == address2)
        XCTAssertFalse(address1 != address2)
        XCTAssertEqual(address1, address2)
    }
    
    /// Test that string representations of IP addresses are parsed correctly.
    func testStringConstructor() {
        var address1 = IPv4Address("61.105.180.185")
        var address2 = IPv4Address(parts: 61,105,180,185)
        XCTAssertNotNil(address1)
        XCTAssertEqual(address1!, address2)
        address1 = IPv4Address("0.0.0.0")
        address2 = IPv4Address(parts: 0,0,0,0)
        XCTAssertNotNil(address1)
        XCTAssertEqual(address1!, address2)
        address1 = IPv4Address("000.000.000.000")
        XCTAssertNotNil(address1)
        XCTAssertEqual(address1!, address2)
        address1 = IPv4Address("255.255.255.255")
        address2 = IPv4Address(parts: 255,255,255,255)
        XCTAssertNotNil(address1)
        XCTAssertEqual(address1!, address2)
        address1 = IPv4Address("0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0.0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0.0.0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0000.0.0.0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0.0000.0.0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0.0.0000.0")
        XCTAssertNil(address1)
        address1 = IPv4Address("0.0.0.0000")
        XCTAssertNil(address1)
        address1 = IPv4Address("256.255.255.255")
        XCTAssertNil(address1)
        address1 = IPv4Address("255.256.255.255")
        XCTAssertNil(address1)
        address1 = IPv4Address("255.255.256.255")
        XCTAssertNil(address1)
        address1 = IPv4Address("255.255.255.256")
        XCTAssertNil(address1)
        address1 = IPv4Address("255.255.255.255.")
        XCTAssertNil(address1)
        address1 = IPv4Address("192.168.0.")
        XCTAssertNil(address1)
        address1 = IPv4Address("127.0..1")
        XCTAssertNil(address1)
        address1 = IPv4Address("127..0.1")
        XCTAssertNil(address1)
        address1 = IPv4Address(".0.0.1")
        XCTAssertNil(address1)
    }
    
    /// Test that the swift version creates the same IP address as the C version.
    func testEqualToPton() {
        func cDecodeIPAddress(ipString: String) -> in_addr? {
            var addr: in_addr = in_addr()
            let result = ipString.withCString { (cString: UnsafePointer<Int8>) -> Int32 in
                return inet_pton(AF_INET, cString, &addr)
            }
            if result == 0 {
                return nil
            }
            return addr
        }
        
        func swiftDecodeIPAddress(ipString: String) -> in_addr? {
            let result = IPv4Address(ipString)
            if (result == nil) {
                return nil
            }
            return in_addr(
                s_addr: in_addr_t(
                    integerLiteral: UInt32(fromIPv4Address: result!)))
        }
        
        var ipAddressString = "61.105.180.185"
        XCTAssertNotNil(cDecodeIPAddress(ipString: ipAddressString))
        XCTAssertNotNil(swiftDecodeIPAddress(ipString: ipAddressString))
        XCTAssertEqual(cDecodeIPAddress(ipString: ipAddressString)!.s_addr,
                       swiftDecodeIPAddress(ipString: ipAddressString)!.s_addr)
        
        ipAddressString = "0.0.0.0"
        XCTAssertNotNil(cDecodeIPAddress(ipString: ipAddressString))
        XCTAssertNotNil(swiftDecodeIPAddress(ipString: ipAddressString))
        XCTAssertEqual(cDecodeIPAddress(ipString: ipAddressString)!.s_addr,
                       swiftDecodeIPAddress(ipString: ipAddressString)!.s_addr)
        
        ipAddressString = "255.255.255.255"
        XCTAssertNotNil(cDecodeIPAddress(ipString: ipAddressString))
        XCTAssertNotNil(swiftDecodeIPAddress(ipString: ipAddressString))
        XCTAssertEqual(cDecodeIPAddress(ipString: ipAddressString)!.s_addr,
                       swiftDecodeIPAddress(ipString: ipAddressString)!.s_addr)
    }
    
    // Test that IPv4 addresses only use 4 bytes of memory.
    func testPhysicalProperties() {
        XCTAssertEqual(MemoryLayout<IPv4Address>.size, 4)
    }

    static var allTests = [
        ("testIsUnspecified",      testIsUnspecified),
        ("testIsLoopback",         testIsLoopback),
        ("testIsPrivate",          testIsPrivate),
        ("testIsLinkLocal",        testIsLinkLocal),
        ("testIsGlobal",           testIsGlobal),
        ("testIsMulticast",        testIsMulticast),
        ("testIsBroadcast",        testIsBroadcast),
        ("testIsDocumentation",    testIsDocumentation),
        ("testStaticValues",       testStaticValues),
        ("testValue",              testValue),
        ("testOctets",             testOctets),
        ("testStringConversion",   testStringConversion),
        ("testEqualityOperators",  testEqualityOperators),
        ("testStringConstructor",  testStringConstructor),
        ("testEqualToPton",        testEqualToPton),
        ("testPhysicalProperties", testPhysicalProperties)
    ]
}
