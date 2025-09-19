Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BA3CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXS1-0003Pk-58; Fri, 19 Sep 2025 05:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXRy-0003PF-EK; Fri, 19 Sep 2025 05:30:42 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXRr-0001De-W1; Fri, 19 Sep 2025 05:30:42 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 17:30:18 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 17:30:17 +0800
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
Subject: [PATCH v5 00/14] Support PCIe RC to AST2600 and AST2700
Date: Fri, 19 Sep 2025 17:29:59 +0800
Message-ID: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v2:
  1. Introduce a new root port device.
  2. For AST2600 RC_H, add the root device at 80:00.0 and a root port at 80.08.0 
     to match the real hardware topology, allowing users to attach PCIe devices 
     at the root port.
  3. For AST2700, add a root port at 00.00.0 for each PCIe root complex to match
     the real hardware topology, allowing users to attach PCIe devices at the
     root port.

v3:
  1. Fix review issues.
  2. update functional test for the e1000e network card.
  3. update license header
  4. Adding "Based on previous work from Cedric Le Goater, with Jamin's summary
     implementation.

v4:
  1. Initialize pointers to NULL when declaring them.
  2. Use distinct variable names to resolve memory leak issues.
  3. Update functional tests to verify assigned IP addresses from
     Intel NIC Ethernet interfaces.
  4. Introduce pcie_mmio_alias in AspeedSoCState instead of dynamically
     allocating memory.

v5:
  1. fix memory leak issue. Replace g_autofree with array.

Dependencies

Based on https://github.com/legoater/qemu at the aspeed-next branch.

Testing the PCIe Root Complex model with the e1000e PCIe device

AST2600 test environment
Test image: ASPEED SDK v09.07
Download
https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz

When booted, lspci should show one root device at 80:00.0 and a root
port at 80:08.0, matching the expected hardware topology:

```
root@ast2600-default:~# lspci
80:00.0 Host bridge: ASPEED Technology, Inc. Device 2600
80:08.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
```

The e1000e driver is included in this image. Attach the e1000e device on
bus pcie.0 with the following command line:

```
 -device e1000e,netdev=net0,bus=pcie.0 \
 -netdev user,id=net0,hostfwd=:127.0.0.1:3222-:22,hostname=qemu0 \
```

After boot, lspci should show the e1000e device enumerated at 81:00.0:

```
root@ast2600-default:~# lspci
80:00.0 Host bridge: ASPEED Technology, Inc. Device 2600
80:08.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
81:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
```

The e1000e driver should probe successfully, and a new Ethernet interface
should appear:

```
root@ast2600-default:~# ifconfig
eth4      Link encap:Ethernet  HWaddr 52:54:00:12:34:5A
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::5054:ff:fe12:345a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:25 errors:0 dropped:0 overruns:0 frame:0
          TX packets:57 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5524 (5.3 KiB)  TX bytes:8488 (8.2 KiB)
          Interrupt:81 Memory:70040000-70060000
```
          
AST2700 test environment
Test image: ASPEED SDK v09.07
Download
https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2700-default-obmc.tar.gz

By default, the ASPEED SDK only enables PCIe root complex 2 (RC2). If you
want to test all three PCIe root complexes, please use the customized
image provided here:
 https://github.com/jamin-aspeed/openbmc/releases/download/qemu-test-0907/ast2700-default-pcie-qemu.tar.xz

When booted, lspci should show one root port at 00:00.0 on the
pcie.2 bus. The domain for PCIe RC2 is 0002, which matches the
expected hardware topology:

```
root@ast2700-default:~# lspci
0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
```

The e1000e driver is included in this image. Attach the e1000e device to
bus pcie.2 using the following command line:

```
 -device e1000e,netdev=net0,bus=pcie.2 \
 -netdev user,id=net0,hostfwd=:127.0.0.1:3222-:22,hostname=qemu0 \
```

After boot, lspci should show the e1000e device enumerated at
0002:01:00.0:

```
root@ast2700-default:~# lspci
0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
```

The e1000e driver should probe successfully, and a new Ethernet interface
should appear:

```
root@ast2700-default:~# ifconfig
eth2      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::5054:ff:fe12:3456/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:21 errors:0 dropped:0 overruns:0 frame:0
          TX packets:48 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5388 (5.2 KiB)  TX bytes:8244 (8.0 KiB)
          Interrupt:42 Memory:a0040000-a0060000
```          

Jamin Lin (14):
  hw/pci/pci_ids: Add PCI vendor ID for ASPEED
  hw/pci-host/aspeed: Add AST2600 PCIe PHY model
  hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge
  hw/pci-host/aspeed: Add AST2600 PCIe Root Device support
  hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address
    configurable
  hw/pci-host/aspeed: Add MSI support and per-RC IOMMU address space
  hw/arm/aspeed: Wire up PCIe devices in SoC model
  hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H only)
  hw/pci-host/aspeed: Add AST2700 PCIe PHY
  hw/pci-host/aspeed: Add AST2700 PCIe config with dedicated H2X blocks
  hw/pci-host/aspeed: Disable Root Device and place Root Port at 00:00.0
    to AST2700
  hw/arm/aspeed_ast27x0: Introduce 3 PCIe RCs for AST2700
  tests/functional/arm/test_aspeed_ast2600: Add PCIe and network test
  tests/functional/aarch64/aspeed_ast2700: Add PCIe and network tests

 include/hw/arm/aspeed_soc.h                   |   15 +
 include/hw/pci-host/aspeed_pcie.h             |  137 +++
 include/hw/pci/pci_ids.h                      |    2 +
 hw/arm/aspeed_ast2600.c                       |   74 ++
 hw/arm/aspeed_ast27x0.c                       |   74 ++
 hw/pci-host/aspeed_pcie.c                     | 1015 +++++++++++++++++
 hw/arm/Kconfig                                |    3 +
 hw/pci-host/Kconfig                           |    4 +
 hw/pci-host/meson.build                       |    1 +
 hw/pci-host/trace-events                      |   11 +
 .../functional/aarch64/test_aspeed_ast2700.py |   21 +
 .../aarch64/test_aspeed_ast2700fc.py          |   13 +
 tests/functional/arm/test_aspeed_ast2600.py   |   21 +
 13 files changed, 1391 insertions(+)
 create mode 100644 include/hw/pci-host/aspeed_pcie.h
 create mode 100644 hw/pci-host/aspeed_pcie.c

-- 
2.43.0


