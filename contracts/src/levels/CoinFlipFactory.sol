// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./base/Level.sol";
import "./CoinFlip.sol";

contract CoinFlipFactory is Level {
    function createInstance(address _player) public payable override returns (address) {
        _player;
        return address(new CoinFlip());
    }

    function validateInstance(address payable _instance, address) public view override returns (bool) {
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}

constructor() {
    // deploy the four core contracts
    ethernaut = new Ethernaut();
    proxyAdmin = new ProxyAdmin();
    implementation = new Statistics();
    proxyStats = new ProxyStats(address(implementation), address(proxyAdmin), address(ethernaut));
    // initialise the ethernaut contract with the proxystats method
    ethernaut.setStatistics(address(proxyStats));
    // here is where statistics seats behind the proxy
    implementation = Statistics(address(proxyStats));
}
