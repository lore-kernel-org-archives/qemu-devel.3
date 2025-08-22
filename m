Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3FCCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXo-0001qF-OJ; Fri, 22 Aug 2025 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXJ-0000q8-Fy; Fri, 22 Aug 2025 11:18:37 -0400
Received: from mail-co1nam11on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2416::611]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWr-0007IH-35; Fri, 22 Aug 2025 11:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZRTs3V9Uj2bDNmw/c/wFBvhJJ7SmQQJkGqpZRMoAKOZh3XBYBx2uLOnhA4GORpvdhjYfBt/6wH/DVYv11zYjcFUiYZJnKBb9N9t1fINjJcNQjaWGtilePPOXiJGH3Xxiz0YXzz+3hcQf9Gk6ywUQ8G470E7oMbF56uu+aHbGbARkI757VQpyOnlk3Bvryl0o6bGd/BiITNhT1npgAJgLpiF/xJEW+wJdUmKcUuI5I6ssJG1NpKGtgt1pPh1oLmMWaXICNaHpBZpwbxbwgzTNSPEXxP5rUG8KfTEmZXuz7Lw9l5/AmJDp2esUOKmWbkp75hi7fBKYi65Cltub3Q/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu5j4p6dJPRM6/eTqsWw1L1DWeJN7S2OWIRl2H+MZDw=;
 b=qekCIVmL9OhPcoljnbfQvhTwryJeXcOIcv5O1GMA5ZiOMGvLa3WeiLiwWGLfWhyDqtX8r4lzZRcDJIVHcqHOnikxpedO87TSLFuglv10IKS5uNHMLZzeFygcQHKK9mzQyr+bN7bdasi4R8pnH+EC1HPwLaQBK4kL6LsRLW5bzHq/uSMdiHo3KfUR3reAlEnjumhRnMlfjxet+Zyp8Iib6gWuLr+8WdKOTYUTVTT0m3uTPDB4MP1/mfUtcf0LL1ilm2nIp5ZBRqVWkaHpD9LbvMizxBuV72QCbfIY8UyHcHK+vX+9VB84L8kASWvI5964efEmKNR0U2Xadg19tJuWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu5j4p6dJPRM6/eTqsWw1L1DWeJN7S2OWIRl2H+MZDw=;
 b=ggZHGz9FT3vwEUP/laJ9mv/ftweXCgiDWn35MCOus9K5R2MxzA4e7TtmOFp7ObB/zEvRgyAuUgti0VnFiKSRFM0T5NA/TYfsnMEaKbjGRx0p5GqCrXcJNBqMbAnPOlUP+/AYl9/4ALh17vtasWvjpZqgME1kgVKgiS4fXSs46yM=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:58 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:1c0:cafe::ec) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 15:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:17:57 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:56 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 46/47] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Fri, 22 Aug 2025 17:16:11 +0200
Message-ID: <20250822151614.187856-47-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: c3428509-28cf-40ae-8eb4-08dde18f13d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?srIArr5xgy+XGr8FAD+WzYSy06aI1+K5PR15DkK9St4gM5Roitij6lL0wKCU?=
 =?us-ascii?Q?6yU12Mo7YJ/LTNSCLc4MCmZmd73r6/ZMAtNAVMIiYQEY3Ev12fp0qjk6V2gf?=
 =?us-ascii?Q?8shnbywACgTK8nb27IUGcXU4HnqfYWDAA83XKQDfwJCD7aZl1OosZ1Qsw9/k?=
 =?us-ascii?Q?HEtRCnT74NS2iWA+HXjBAZCaHG8bvblihwYJAAzY8O47qcuMbxo5rSvjEq+w?=
 =?us-ascii?Q?/mnLHLE/Gs5NpHXmWR1cmIc3G8/lrjCYBi908wHD3XrNTrSLjNnmIjJVovIC?=
 =?us-ascii?Q?F+IwyGdB6hi3YzwjhaYT70sYAZwWeabUM6IkQQSwG3Y9qtb0hb6C86LQICIv?=
 =?us-ascii?Q?ujGMlegaXphM1sDdQrkiTZPiMvs04uQlq2QHDtfXY2Q0dpXOOx6tOnIUJVhY?=
 =?us-ascii?Q?N8cM714/518gmyqv+xu3rMoW5ZAbrafNMYFWbVW6XLzgshrlyyS4YtrSuI67?=
 =?us-ascii?Q?LymKDYTFbJGht4jle+VbMQrUANfxpnhaXKgxraTkc8nr57WCzj6qlOlys5hs?=
 =?us-ascii?Q?k8avs6DJIMoq5uqOWVMZLIB5rcftZH6bRj53E+nUMeVbcOotQfP+8B4PjGKN?=
 =?us-ascii?Q?g2ijL6tkGLbOuDjHOPWVJZY+P7F+XryrPDUmsy0Zq5aOrubWx8SMizx7a2fx?=
 =?us-ascii?Q?opOeCb6o6ddjbr+11qXR2io7DAJhm8SFnlynoVI4aPWyQ4x6BunoMTAVpciN?=
 =?us-ascii?Q?7P86Exvsj0NSoUcRRwdh2DmjIzJT63ZpHkWoBGea5RobKSycS6fied5DLBkJ?=
 =?us-ascii?Q?YTuLwa/HgmpWH8uLU8vBNs2c8l7sZ87uX4a3zwlPPR2h5b2QAEESHWr2ah94?=
 =?us-ascii?Q?pru/+ap7Ho9sP0Qq9QJ0ouU04GtLPAGUy3sUsYmQbGhFXMTMv10L6GfajZcw?=
 =?us-ascii?Q?Lz7/z38GjOmEuXs3iR0Ym+UT8glpSRJqEGfwWrso8YF4BBlrzQwH9hBKNg3c?=
 =?us-ascii?Q?DAPjhwqxijWGTVpTWR9ChYgmZBlTufr2YEGC7etE2D09q4cZOYr0DaVZArxJ?=
 =?us-ascii?Q?6wH0Hvp11B2f6ISFf+ZPgC25nWhQo+sW72JbtrRw7d4oEZcpbqh1PzhHndtS?=
 =?us-ascii?Q?wzi+BZP56/2l9zvA+LWvph6AjjhnxzcrE5U71bszRMKLg4cdFzjloKSmBBWC?=
 =?us-ascii?Q?rGcEwV6oZRwXz3uPWHVsek7MxQKTaPpY6gh+TaB6WjyMj04FYAFpPYDFh1Jy?=
 =?us-ascii?Q?caprE4wnMOw1I26pqdfpmJVXKM/jjjhFpwAoO6PHnNeQgsv/gCjYYnxa255i?=
 =?us-ascii?Q?ATSDu0tyxUt5NOrIdvtu7ZS1vYGOVSOvin0NGB0ALJnwYAa9He0tu28tJ2nM?=
 =?us-ascii?Q?Xva6+4lHo/9YU2jTlAlWV2iruENx1NWJxyXYEs5TnDBpPQk2Y5UdAZ2kTnyR?=
 =?us-ascii?Q?0bm5GkKinprQh5KOGit6fEGxLoHdVy3pJhbND7jfjmdof9qVx8t0h/rFvGsx?=
 =?us-ascii?Q?Fb0xYmL74O7BnyS9TZWnKJRc6/aSpqN2jG88IBH6Na4CJ+96ZYyFng/W7+Nv?=
 =?us-ascii?Q?6JwbWRVjxtIgNvgExaeQ3Jlcw1fsqGw5TeRG6D6v8bLt+0TJ6fTwb4sUaA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:58.5275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3428509-28cf-40ae-8eb4-08dde18f13d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
Received-SPF: permerror client-ip=2a01:111:f403:2416::611;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the Versal Gen 2 Virtual development machine embedding a
versal2 SoC. This machine follows the same principle than the
xlnx-versal-virt machine. It creates its own DTB and feeds it to the
software payload. This way only implemented devices are exposed to the
guest and the user does not need to provide a DTB.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 49 ++++++++++++++++++++++++----
 hw/arm/xlnx-versal-virt.c            | 37 +++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 5d7fa18592b..640cc07f808 100644
--- a/docs/system/arm/xlnx-versal-virt.rst
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -1,16 +1,18 @@
-AMD Versal Virt (``amd-versal-virt``)
-=====================================
+AMD Versal Virt (``amd-versal-virt``, ``amd-versal2-virt``)
+===========================================================
 
 AMD Versal is a family of heterogeneous multi-core SoCs
 (System on Chip) that combine traditional hardened CPUs and I/O
 peripherals in a Processing System (PS) with runtime programmable
 FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
 
-QEMU implements the Versal Series variant of Versal SoCs, with the
-``amd-versal-virt`` machine. The alias ``xlnx-versal-virt`` is kept for
-backward compatibility.
+QEMU implements the following Versal SoCs variants:
+
+- Versal (the ``amd-versal-virt`` machine, the alias ``xlnx-versal-virt`` is
+  kept for backward compatibility)
+- Versal Gen 2 (the ``amd-versal2-virt`` machine)
 
 More details here:
 https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
 
 The family of Versal SoCs share a single architecture but come in
@@ -19,10 +21,12 @@ other differences.
 
 The AMD Versal Virt board in QEMU is a model of a virtual board
 (does not exist in reality) with a virtual Versal SoC without I/O
 limitations. Currently, we support the following cores and devices:
 
+Versal
+""""""
 Implemented CPU cores:
 
 - 2 ACPUs (ARM Cortex-A72) with their GICv3 and ITS
 - 2 RCPUs (ARM Cortex-R5F) with their GICv2
 
@@ -41,20 +45,42 @@ Implemented devices:
 - 2 CANFDs
 - USB controller
 - OSPI controller
 - TRNG controller
 
+Versal Gen 2
+""""""""""""
+Implemented CPU cores:
+
+- 8 ACPUs (ARM Cortex-A78AE) with their GICv3 and ITS
+- 10 RCPUs (ARM Cortex-R52) with their GICv3 (one per cluster)
+
+Implemented devices:
+
+- 2 UARTs (ARM PL011)
+- An RTC (Versal built-in)
+- 3 GEMs (Cadence MACB Ethernet MACs)
+- 8 ADMA (Xilinx zDMA) channels
+- 2 SD Controllers
+- OCM (256KB of On Chip Memory)
+- DDR memory
+- BBRAM (36 bytes of Battery-backed RAM)
+- 2 CANFDs
+- 2 USB controllers
+- OSPI controller
+- TRNG controller
+
 QEMU does not yet model any other devices, including the PL and the AI Engine.
 
 Other differences between the hardware and the QEMU model:
 
 - QEMU allows the amount of DDR memory provided to be specified with the
   ``-m`` argument. If a DTB is provided on the command line then QEMU will
   edit it to include suitable entries describing the Versal DDR memory ranges.
 
-- QEMU provides 8 virtio-mmio virtio transports; these start at
-  address ``0xa0000000`` and have IRQs from 111 and upwards.
+- QEMU provides 8 virtio-mmio virtio transports. They use reserved memory
+  regions and IRQ pins to avoid conflicts with real SoC peripherals.
 
 Running
 """""""
 If the user provides an Operating System to be loaded, we expect users
 to use the ``-kernel`` command line option.
@@ -212,10 +238,15 @@ To use a different index value, N, from default of 0, add:
 
   -global driver=xlnx.bbram-ctrl,property=drive-index,value=N
 
 eFUSE File Backend
 """"""""""""""""""
+
+.. note::
+   The eFUSE device is not implemented in the Versal Gen 2 QEMU model
+   yet.
+
 eFUSE can have an optional file backend, which must be a seekable
 binary file with a size of 3072 bytes or larger. A file with all
 binary 0s is a 'blank'.
 
 To add a file-backend for the eFUSE:
@@ -269,5 +300,9 @@ To connect CANFD0 and CANFD1 to host machine's CAN interface can0:
 
 .. code-block:: bash
 
     -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus
     -object can-host-socketcan,id=canhost0,if=can0,canbus=canbus
+
+.. note::
+   Versal Gen 2 has 4 CAN controllers. ``canbus0`` to ``canbus3`` can
+   be specified on the command line.
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 14c2d5cc924..149b448546e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,7 +1,7 @@
 /*
- * AMD/Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal family Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
@@ -27,10 +27,11 @@
 #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
     MACHINE_TYPE_NAME("amd-versal-virt-base")
 OBJECT_DECLARE_TYPE(VersalVirt, VersalVirtClass, XLNX_VERSAL_VIRT_BASE_MACHINE)
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal-virt")
+#define TYPE_XLNX_VERSAL2_VIRT_MACHINE MACHINE_TYPE_NAME("amd-versal2-virt")
 
 #define XLNX_VERSAL_NUM_OSPI_FLASH 4
 
 struct VersalVirt {
     MachineState parent_obj;
@@ -55,11 +56,13 @@ struct VersalVirtClass {
 };
 
 static void fdt_create(VersalVirt *s)
 {
     MachineClass *mc = MACHINE_GET_CLASS(s);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_GET_CLASS(s);
     const char versal_compat[] = "amd-versal-virt\0xlnx-versal-virt";
+    const char versal2_compat[] = "amd-versal2-virt";
 
     s->fdt = create_device_tree(&s->fdt_size);
     if (!s->fdt) {
         error_report("create_device_tree() failed");
         exit(1);
@@ -69,12 +72,22 @@ static void fdt_create(VersalVirt *s)
     qemu_fdt_add_subnode(s->fdt, "/chosen");
     qemu_fdt_add_subnode(s->fdt, "/aliases");
 
     /* Header */
     qemu_fdt_setprop_string(s->fdt, "/", "model", mc->desc);
-    qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
-                     sizeof(versal_compat));
+
+    switch (vvc->version) {
+    case VERSAL_VER_VERSAL:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal_compat,
+                         sizeof(versal_compat));
+        break;
+
+    case VERSAL_VER_VERSAL2:
+        qemu_fdt_setprop(s->fdt, "/", "compatible", versal2_compat,
+                         sizeof(versal2_compat));
+        break;
+    }
 }
 
 static void fdt_nop_memory_nodes(void *fdt, Error **errp)
 {
     Error *err = NULL;
@@ -361,10 +374,21 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
     vvc->version = VERSAL_VER_VERSAL;
 
     versal_virt_machine_class_init_common(oc);
 }
 
+static void versal2_virt_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
+
+    mc->desc = "AMD Versal Gen 2 Virtual development board";
+    vvc->version = VERSAL_VER_VERSAL2;
+
+    versal_virt_machine_class_init_common(oc);
+}
+
 static const TypeInfo versal_virt_base_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .parent     = TYPE_MACHINE,
     .class_size = sizeof(VersalVirtClass),
     .instance_init = versal_virt_machine_instance_init,
@@ -377,12 +401,19 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
 };
 
+static const TypeInfo versal2_virt_machine_init_typeinfo = {
+    .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
+    .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
+    .class_init = versal2_virt_machine_class_init,
+};
+
 static void versal_virt_machine_init_register_types(void)
 {
     type_register_static(&versal_virt_base_machine_init_typeinfo);
     type_register_static(&versal_virt_machine_init_typeinfo);
+    type_register_static(&versal2_virt_machine_init_typeinfo);
 }
 
 type_init(versal_virt_machine_init_register_types)
-- 
2.50.1


