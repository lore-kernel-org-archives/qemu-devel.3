Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F238CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 09:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoIEL-0005SP-KR; Tue, 19 Aug 2025 05:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uoIE5-0005Ng-Tu; Tue, 19 Aug 2025 05:01:55 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uoIE2-0003YB-GY; Tue, 19 Aug 2025 05:01:53 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 19 Aug
 2025 17:01:41 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 19 Aug 2025 17:01:41 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v1 00/11] Support PCIe RC to AST2600 and AST2700
Date: Tue, 19 Aug 2025 17:01:21 +0800
Message-ID: <20250819090141.3949136-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1:
 1. Add PCIe PHY, CFG, and MMIO window support for AST2600.
    Note: Only supports RC_H.
 2. Add PCIe PHY, CFG, and MMIO window support for AST2700.
    Note: Supports 3 RCs.

Testing PCIe RC model with e1000e PCIe device model

AST2600

The AST2600/ASPEED PCIe driver treats root bus 0x80 specially:
Only two device addresses are usable on the root bus:
addr 0: ASPEED host bridge
addr 8: usable for attaching a PCIe root port

To attach endpoints without driver changes, the test places a QEMU PCIe root
port at 0x80:08.0 and attaches an e1000e NIC behind it.
The endpoint then enumerates on bus 0x81.

QEMU command line additions
-device pcie-root-port,id=root_port0,slot=1,addr=8,bus=pcie.0
-device e1000e,netdev=net0,bus=root_port0
-netdev user,id=net0

Verification with lspci:
0001:80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0001:80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
0001:81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
Connection

This is a temporary solution that allows attaching multiple PCIe
devices while the ASPEED drivers does not support placing endpoints directly
on bus numbers 0x80.

Reference:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/drivers/pci/controller/pcie-aspeed.c#L309

Test Image: ASPEED SDK v09.07. It okay to use ASPEED SDK v09.06.
https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz

The e1000e driver is built into this image.
After booting, users should see the e1000e Ethernet interface.
With this setup, RC_H on AST2600 can be tested using e1000e endpoints in QEMU.

Example system output:
root@ast2600-default:~# lspci
80:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
80:08.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
root@ast2600-default:~# ifconfig eth4
eth4      Link encap:Ethernet  HWaddr 52:54:00:12:34:5A
          inet addr:169.254.160.167  Bcast:169.254.255.255  Mask:255.255.0.0
          inet6 addr: fe80::5054:ff:fe12:345a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19 errors:0 dropped:0 overruns:0 frame:0
          TX packets:54 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4896 (4.7 KiB)  TX bytes:8079 (7.8 KiB)
          Interrupt:81 Memory:70040000-70060000

root@ast2600-default:~# dmesg | grep "e1000e"
[    2.901955] e1000e: Intel(R) PRO/1000 Network Driver
[    2.902346] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   15.366727] e1000e 0000:81:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   15.431884] e1000e 0000:81:00.0 0000:81:00.0 (uninitialized): registered PHC clock
[   15.508477] e1000e 0000:81:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:5a
[   15.509301] e1000e 0000:81:00.0 eth4: Intel(R) PRO/1000 Network Connection
[   15.510768] e1000e 0000:81:00.0 eth4: MAC: 3, PHY: 8, PBA No: 000000-000
[   49.781217] e1000e 0000:81:00.0 eth4: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx


AST2700:

The ASPEED PCIe driver only supports bus 0 with a single device at slot 0,
which is reserved for the internal bridge. All endpoint devices must therefore
reside on bus 1 to be discovered.
See the ASPEED PCIe driver implementation here:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/drivers/pci/controller/pcie-aspeed.c#L512

By default, the ASPEED SDK enables only PCIe RC2, so initial testing covers RC2 only.

To attach e1000e devices and test all three RCs, I created a new test image
with driver modifications. This is a temporary solution. A better approach is
still needed to allow placing e1000e directly under bus 1.

Test release: https://github.com/jamin-aspeed/openbmc/releases/tag/qemu-test-0907
Image download: https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/ast2700-default-pcie-qemu.tar.xz
This image includes the following changes:
Kernel patch (AST2700 RC mode + PCIe driver updates):
https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/0001-PCI-aspeed-Enable-AST2700-RC-mode-support-and-adjust.patch

OpenBMC patch (installs e1000e modules into rootfs for testing):
https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/0001-packagegroup-aspeed-Add-Intel-e1000-e1000e-kernel-mo.patch

QEMU Test Command

Each PCIe RC bus adds a pcie-root-port with an e1000e NIC behind it:

 -device pcie-root-port,id=root_port0,multifunction=on,slot=0,addr=1,bus=pcie.0 \
 -device e1000e,netdev=net0,bus=root_port0 \
 -netdev user,id=net0,hostfwd=:127.0.0.1:3222-:22,hostname=qemu0 \
 -device pcie-root-port,id=root_port1,slot=1,addr=2,bus=pcie.1 \
 -device e1000e,netdev=net1,bus=root_port1 \
 -netdev user,id=net1,hostfwd=:127.0.0.1:4222-:22,hostname=qemu1 \
 -device pcie-root-port,id=root_port2,slot=2,addr=3,bus=pcie.2 \
 -device e1000e,netdev=net2,bus=root_port2 \
 -netdev user,id=net2,hostfwd=:127.0.0.1:5222-:22,hostname=qemu2 \

Expected Results

With lspci, each RC should show the internal bridge, root port, and e1000e endpoint:

root@ast2700-default:~# lspci
0000:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0000:00:01.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
0000:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
0001:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0001:00:02.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
0001:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
0002:00:00.0 Host bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0002:00:03.0 PCI bridge: Red Hat, Inc. QEMU PCIe Root port
0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection

Load the e1000e driver:
Kernel logs confirm device initialization and link-up at 1 Gbps Full Duplex on eth2/eth3/eth4.
root@ast2700-default:~# modprobe e1000e
[   59.181623] e1000e: Intel(R) PRO/1000 Network Driver
[   59.181926] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   59.183508] e1000e 0000:01:00.0: enabling device (0000 -> 0002)
[   59.188808] e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   59.252590] e1000e 0000:01:00.0 0000:01:00.0 (uninitialized): registered PHC clock
[   59.330877] e1000e 0000:01:00.0 eth2: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:56
[   59.331990] e1000e 0000:01:00.0 eth2: Intel(R) PRO/1000 Network Connection
[   59.333211] e1000e 0000:01:00.0 eth2: MAC: 3, PHY: 8, PBA No: 000000-000
[   59.334881] e1000e 0001:01:00.0: enabling device (0000 -> 0002)
[   59.341616] e1000e 0001:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   59.394712] e1000e 0001:01:00.0 0001:01:00.0 (uninitialized): registered PHC clock
[   59.456674] e1000e 0001:01:00.0 eth3: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:57
[   59.457487] e1000e 0001:01:00.0 eth3: Intel(R) PRO/1000 Network Connection
[   59.458033] e1000e 0001:01:00.0 eth3: MAC: 3, PHY: 8, PBA No: 000000-000
[   59.460037] e1000e 0002:01:00.0: enabling device (0000 -> 0002)
[   59.466403] e1000e 0002:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   59.533361] e1000e 0002:01:00.0 0002:01:00.0 (uninitialized): registered PHC clock
[   59.654491] 8021q: adding VLAN 0 to HW filter on device eth2
[   59.662100] e1000e 0002:01:00.0 eth4: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:58
[   59.662966] e1000e 0002:01:00.0 eth4: Intel(R) PRO/1000 Network Connection
[   59.663527] e1000e 0002:01:00.0 eth4: MAC: 3, PHY: 8, PBA No: 000000-000
root@ast2700-default:~# [   59.814984] 8021q: adding VLAN 0 to HW filter on device eth3
[   59.938859] 8021q: adding VLAN 0 to HW filter on device eth4
[   59.954690] e1000e 0000:01:00.0 eth2: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   60.116790] e1000e 0001:01:00.0 eth3: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   60.237622] e1000e 0002:01:00.0 eth4: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

After loading, users should see:
eth2: PCIe0
eth3: PCIe1
eth4: PCIe2

Example ifconfig output shows all interfaces (eth0-eth4) active, with eth2-eth4 bound to the e1000e NICs.
With this setup, all three PCIe RCs on AST2700 can be tested using e1000e endpoints in QEMU.

root@ast2700-default:~# ifconfig
eth2      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
          inet addr:169.254.120.135  Bcast:169.254.255.255  Mask:255.255.0.0
          inet6 addr: fe80::5054:ff:fe12:3456/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:19 errors:0 dropped:0 overruns:0 frame:0
          TX packets:51 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5227 (5.1 KiB)  TX bytes:8551 (8.3 KiB)
          Interrupt:42 Memory:60040000-60060000

eth3      Link encap:Ethernet  HWaddr 52:54:00:12:34:57
          inet addr:169.254.237.52  Bcast:169.254.255.255  Mask:255.255.0.0
          inet6 addr: fe80::5054:ff:fe12:3457/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:47 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4786 (4.6 KiB)  TX bytes:8175 (7.9 KiB)
          Interrupt:45 Memory:80040000-80060000

eth4      Link encap:Ethernet  HWaddr 52:54:00:12:34:58
          inet addr:169.254.84.173  Bcast:169.254.255.255  Mask:255.255.0.0
          inet6 addr: fe80::5054:ff:fe12:3458/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:16 errors:0 dropped:0 overruns:0 frame:0
          TX packets:47 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4786 (4.6 KiB)  TX bytes:8191 (7.9 KiB)
          Interrupt:48 Memory:a0040000-a0060000

Jamin Lin (11):
  hw/pci/pci_ids Add PCI vendor ID for ASPEED
  hw/pci-host/aspeed: Add AST2600 PCIe PHY model
  hw/pci-host/aspeed: Add AST2600 PCIe config and host bridge
  hw/pci-host/aspeed: Add MSI support and per-RC IOMMU address space
  hw/arm/aspeed: Wire up PCIe devices in SoC model
  hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H only)
  tests/functional/test_arm_aspeed_ast2600: Add PCIe test via root port
    and e1000e
  hw/pci-host/aspeed: Add AST2700 PCIe PHY
  hw/pci-host/aspeed: Add AST2700 PCIe config with dedicated H2X blocks
  hw/arm/aspeed_ast27x0: Introduce 3 PCIe RCs for AST2700
  tests/functional: Add PCIe presence test for AST2700

 include/hw/arm/aspeed_soc.h                   |  14 +
 include/hw/pci-host/aspeed_pcie.h             | 125 +++
 include/hw/pci/pci_ids.h                      |   2 +
 hw/arm/aspeed_ast2600.c                       |  69 +-
 hw/arm/aspeed_ast27x0.c                       |  61 ++
 hw/pci-host/aspeed_pcie.c                     | 955 ++++++++++++++++++
 hw/arm/Kconfig                                |   3 +
 hw/pci-host/Kconfig                           |   4 +
 hw/pci-host/meson.build                       |   1 +
 hw/pci-host/trace-events                      |  11 +
 .../functional/test_aarch64_aspeed_ast2700.py |   7 +
 .../test_aarch64_aspeed_ast2700fc.py          |   6 +
 tests/functional/test_arm_aspeed_ast2600.py   |  14 +
 13 files changed, 1269 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/pci-host/aspeed_pcie.h
 create mode 100644 hw/pci-host/aspeed_pcie.c

-- 
2.43.0


