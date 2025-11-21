Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1147CFA471
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJHL-0004It-IZ; Fri, 21 Nov 2025 00:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vMJGo-0003yn-VZ; Fri, 21 Nov 2025 00:01:25 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vMJGm-0006BY-5W; Fri, 21 Nov 2025 00:01:18 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 21 Nov
 2025 13:01:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 21 Nov 2025 13:01:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v1 0/1] (RESEND) Update ASPEED PCIe Root Port capabilities and
 enable MSI to support hotplug
Date: Fri, 21 Nov 2025 13:01:07 +0800
Message-ID: <20251121050108.3407445-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
  1.  Update ASPEED PCIe Root Port capabilities and enable MSI to support hotplug

How to test it:

Firmware Requirements
 
Before testing, please make sure the Linux kernel has the following configuration enabled:
Reference defconfig:
https://github.com/AspeedTech-BMC/linux/blob/aspeed-master-v6.6/arch/arm64/configs/aspeed_g7_defconfig

CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

QEMU Testing Procedure
1. Boot Linux and verify the root port

root@ast2700-a1-spl:~# lspci
0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge

2. Add an e1000e device dynamically (Hot-plug)

In QEMU monitor:
(qemu) device_add e1000e,bus=pcie.2,id=mye1000e
[  103.919703] pcieport 0002:00:00.0: pciehp: Slot(0): Button press: will power on in 5 sec
[  103.921921] pcieport 0002:00:00.0: pciehp: Slot(0): Card present
[  103.922557] pcieport 0002:00:00.0: pciehp: Slot(0): Link Up
[  105.047374] pci 0002:01:00.0: [8086:10d3] type 00 class 0x020000
[  105.048859] pci 0002:01:00.0: reg 0x10: [mem 0x00000000-0x0001ffff]
[  105.049786] pci 0002:01:00.0: reg 0x14: [mem 0x00000000-0x0001ffff]
[  105.050453] pci 0002:01:00.0: reg 0x18: [io  0x0000-0x001f]
[  105.051049] pci 0002:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff]
[  105.051904] pci 0002:01:00.0: reg 0x30: [mem 0x00000000-0x0003ffff pref]
[  105.052880] pci 0002:01:00.0: enabling Extended Tags
[  105.063878] pci 0002:01:00.0: BAR 6: assigned [mem 0xa0000000-0xa003ffff pref]
[  105.064889] pci 0002:01:00.0: BAR 0: assigned [mem 0xa0040000-0xa005ffff]
[  105.066104] pci 0002:01:00.0: BAR 1: assigned [mem 0xa0060000-0xa007ffff]
[  105.066881] pci 0002:01:00.0: BAR 3: assigned [mem 0xa0080000-0xa0083fff]
[  105.067637] pci 0002:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[  105.068360] pcieport 0002:00:00.0: PCI bridge to [bus 01]
[  105.068828] pcieport 0002:00:00.0:   bridge window [io  0x1000-0x1fff]
[  105.072140] pcieport 0002:00:00.0:   bridge window [mem 0xa0000000-0xa01fffff]
[  105.075017] pcieport 0002:00:00.0:   bridge window [mem 0xa0200000-0xa03fffff 64bit pref]
[  105.081561] pcieport 0002:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
[  105.082733] pci 0002:01:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
[  105.089597] e1000e 0002:01:00.0: enabling device (0000 -> 0002)
[  105.098995] e1000e 0002:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[  105.160515] e1000e 0002:01:00.0 0002:01:00.0 (uninitialized): registered PHC clock
[  105.231396] e1000e 0002:01:00.0 eth2: (PCI Express:2.5GT/s:Width x1) 52:54:00:12:34:56
[  105.232279] e1000e 0002:01:00.0 eth2: Intel(R) PRO/1000 Network Connection
[  105.233696] e1000e 0002:01:00.0 eth2: MAC: 3, PHY: 8, PBA No: 000000-000
[  105.489627] 8021q: adding VLAN 0 to HW filter on device eth2
[  105.788193] e1000e 0002:01:00.0 eth2: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

Leave QEMU monitor mode and lspci now lists the device:

root@ast2700-a1-spl:~# lspci
0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
0002:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection

3. Remove the device dynamically (Hot-unplug)  

In QEMU monitor:
(qemu) device_del mye1000e
[  203.354941] pcieport 0002:00:00.0: pciehp: Slot(0): Button press: will power off in 5 sec
[  208.411558] e1000e 0002:01:00.0 eth2: removed PHC
[  208.486799] e1000e 0002:01:00.0 eth2: NIC Link is Down

Leave QEMU monitor mode and lspci again shows only the root port:
root@ast2700-a1-spl:~# lspci
0002:00:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge

Jamin Lin (1):
  hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilities and
    enable MSI to support hotplug

 hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

-- 
2.43.0


