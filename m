Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B42CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eu-0002xG-AC; Fri, 12 Sep 2025 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0dD-0007jU-MO; Fri, 12 Sep 2025 06:03:59 -0400
Received: from mail-dm3nam02on20621.outbound.protection.outlook.com
 ([2a01:111:f403:2405::621]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d1-0001Qa-SA; Fri, 12 Sep 2025 06:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhA/e7OVo7WtOZdAahzepxUiyof2uaB+vsTuwX9CDP1443tq6vN/t6zaaFCfs5YnaCo6/1pBUQw8l86gbSP8Ybe/TL3e3zos0BqxrcnQ3kDWJ9DPmaSgZCq22JRfbuxi3zqPBa/yN4fX2rfdXosjMe8Y8BKgsoWvU9hhrqelXx81G8h79Zlj4GOhYS7gYImDNcjPbb9olsRXsqxxT6gomRd+n5BA7bUdmc9LhWTIT1p0/XyNTBVy557/R0lHZZhEfmnQ841ZaeTO6MGFd4CLq11G7JpwXHeDyPJmDjYvE/ov6FL85RjWArPFwkfFPn2T58lo/veSeKI3H/XjLqrtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu5j4p6dJPRM6/eTqsWw1L1DWeJN7S2OWIRl2H+MZDw=;
 b=lLEaayEUrDcX+Cp0DxDhOROMOalcj82mceLy3MKwtOC8U4FVn6t7o73MoEMNpoaymPEe7RznDrpLMg/E1OWqvthay4ZgNQeOgr2kRkB4Ggc7BuKL584i/U53LVKjIbPkkBu3RvIKMY2kIBsquc0EGzcPowSkW/9Ms14JdQs13bPnJoDF5NnWoHu5+lNl4HNgyPbsYMINJrfY+fBP119F5M5Ih0VMGC+y3+tZsSLmyGAkozgc3yzx/o01IbbCUz9Yv537FujtKneHdUz4hrFet545pMZZV//nKBp2bXzBNrbPH8xs4TLR9xaZ6dbXl5kTwaZCd7gBypXtVfS+MNEj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu5j4p6dJPRM6/eTqsWw1L1DWeJN7S2OWIRl2H+MZDw=;
 b=4WRLX27qQEn861YrIIoMbisRE7+Gb4stDx/ESan2Fb5ZlUAAZ5R//eaCIM4OCfHQC2kvw1vm2JKFuL2k6aNopNhyhRuhG/29yJoFr8Oi4gsYcXgN9Kw1HhNcpVPiDvjJdIl8o+7P26ynA0fMuZ12K0/6Gywe3VeusLxwRPb6x6E=
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:19 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d4) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:43 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:43 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:41 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 46/47] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Fri, 12 Sep 2025 12:00:55 +0200
Message-ID: <20250912100059.103997-47-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a43ea5-9902-4c00-af5c-08ddf1e399af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5KyuBsejxPlkdzkyGnzhjtBQOIFwHAdacLl68VV4jrgpabAAiMtHKzyEnX7c?=
 =?us-ascii?Q?kKbXmrTJZ3/uGFnS/qqB7hN9WDGJGq7ayOQ/52fC07qROtEE/ab4Hm6vUwPe?=
 =?us-ascii?Q?OXr5JOLUMERPRXRf2V1L4lN/GiscNXfqK579WeaySV2ZSpbOavUGlu1jwTqx?=
 =?us-ascii?Q?ZPBXR2x979zcDH5HZMHjv8V1R7qwWYmdVvUh0pMXFROxx0/WG2MoBDU6m85u?=
 =?us-ascii?Q?A4K1fyOF/8EIEu2skKm17Luqe7Sha6z80NUQhhBmIw+/KBhohAUsW6Aky/oP?=
 =?us-ascii?Q?A/Hq6T6WKGiKBISdCDRcmOOVbZENnbG5xePnl5m/ZtnWcGFks2UvAmhUpgjN?=
 =?us-ascii?Q?i0iZU9e5tjKArlZyZXPGU7JE3nLjhD+/BgNmlOFZDspk5AY338QP++EZS4s3?=
 =?us-ascii?Q?BfK4DgqE6U34JfEO8BTJFW0ouDvGr0zCd3FvSiLkx0ABdW0pfJNKTJfdWeBE?=
 =?us-ascii?Q?TLacV36wz5ytL2Q+5PVVkrfpNrzujGGtyoesJoZADMtUTiY1bUjJYHWHx+CH?=
 =?us-ascii?Q?nER5jG8ckQMRfQe0PftfnNuaxArVLTbQo23aXlb8LbgPrYJjvEPZyAs+iyEx?=
 =?us-ascii?Q?VFRN/BzcxefXrHe68bCltz+HFwhNlTIR736d3MZNFs/aUEnZMKJh/I7e4RwJ?=
 =?us-ascii?Q?ThYM3zM4e59Qvu3LBZzUQjjjVTeJ3JzTzs4bRTyF8pqzE/bMT569apIHHmdF?=
 =?us-ascii?Q?AmaPP1HnUY69KTBC9InlDM36+umKJoB2qqJpirz6vCVVjwBsxOG3B/d22WGj?=
 =?us-ascii?Q?ikVkM8rgGtNWGeDpNEs4GVGawnSlQm8VXZmivt1He/UPqwfUN7CVd76UHQq2?=
 =?us-ascii?Q?Viz/No/lE/Erh6U6g58UeoFmI2bh9XQot2o5UgN1jaaIZlwuBPmdLzWOY1m2?=
 =?us-ascii?Q?CAgZ8LxNtd8AHxg6FKqtB3jbWHzbcaLAsgKSgitSC/SFaVGk+ZgUrJo98Q6x?=
 =?us-ascii?Q?uBZRJDMPN6Fw2UiDXxHcbhRAHyqlUpL1WZoKzm8nogzfz8EH7FnOdFc9JqaG?=
 =?us-ascii?Q?xrEdX1mY9Np3CqzdHiClQu2Xr1deetcqmdihNpabkhZ7VRApRnjn4Tqik6pQ?=
 =?us-ascii?Q?VFbFJhDP6Ju7MsFhxv1Lxdy8XOiR5dCfZlsYdny5QRtVxejn/TA/bCFZ7LmX?=
 =?us-ascii?Q?xsjnlBllPtCWxBJTlzf18bvYg741qh+F651Ut53xMa+DYvBvtV6eOACTXagX?=
 =?us-ascii?Q?ZX8xMQ1qacgPvFrdcGyT6m7XYLhQk3ugEsATBtC08ZVJR8Ow0+MXKJeqeWIh?=
 =?us-ascii?Q?KjvrWYESlaaPPm74QJUTasnOll++hbRLLz70yNqLXEqzKdWnGSYedwjwOM8H?=
 =?us-ascii?Q?hyJjqY33QvX+mSWHYSiQCOn4jYYTijFwJ41rEXBEskvpnAgSzJ4eJ6JCQneY?=
 =?us-ascii?Q?Y6PccBlC1K6L9wLOR9VsBilYNoCoH0v2kYisxDE+Pw8i+TGVssu1KzgKPo1k?=
 =?us-ascii?Q?7S3UFMgoqmP1nvjaC8U5RHJvW9hwx/bXUWIll6YPd96OwzP7qX6gXBQ/aBQF?=
 =?us-ascii?Q?HUBgGBe7kSDBSoCng1N1wMD51AwFE7KpK0nBaALGPjRVyD6Q6V7ovj1t0w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:19.3969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a43ea5-9902-4c00-af5c-08ddf1e399af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
Received-SPF: permerror client-ip=2a01:111:f403:2405::621;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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


