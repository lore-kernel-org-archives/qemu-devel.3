Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0748EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyux-00038q-FW; Wed, 16 Jul 2025 05:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysV-0002dZ-6Q; Wed, 16 Jul 2025 05:56:43 -0400
Received: from mail-mw2nam12on20622.outbound.protection.outlook.com
 ([2a01:111:f403:200a::622]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysS-0006pA-EG; Wed, 16 Jul 2025 05:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV5APcPNGz6/O0YGx9IMqZPOplSYkzfQpTweuCm093Gi8ZdAbYrMRidVe3AOzrPEUmc1aFkNHag7G7Ouz+WyhU5xrHGX+ybMhWkIrx7kJQ0xgu6i+uMWuYdnD4Z0f33QNOwSym/JOIw5gQNnr9/K2oqONFZbtzyhhHE2JLM/TNvXkP/seSFiHnZFoDFQhybCa+zJvJlA+Cd8wMi8UOTCraXthMQbJaBkX1aVH5QC4T70Of+iDUec44J0oYxHMnqtc/esVoMYcbI4pjKqzNQe5XDfm6cMEojWDUuGx7HUIe46TBlW9/nDWiXrzr/b/SB1+E9ekl2Df/5zdfDbOeHvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1l0XszJXHHyIPUwIEC+yBa7eb+A9g6cG+owZiptKYw=;
 b=r6hl2ZxPIIJzbFplqs4JZTUseFWMASz2C8tEGij3E0pTS0EvV1T2he87Ok0QNZDNWT35mc0T4H4XfaMLa5G66CL9A+AsG6VP7NJVixaZEoKhKavmsp+rFDiCIRtdDgN8wLJI8KBcRjePY/cMBMW6sR4UxmXEdobO3lqkRPrVwbXBcpiiHYt/4O7M4cazH6lqK6A0CjmQimICY8ZlnvsCJZnji/cXqm7DddvFP+jjKQtpqfdGEu6O4IuddNRNE4kSDceax4McgHXk1JimomtoeuBEDZRRvzl7sPW5GjcdyAg3LmbEZKQKlUsM5BN43zz08p+qsUfc8sf/sbtXdwLr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1l0XszJXHHyIPUwIEC+yBa7eb+A9g6cG+owZiptKYw=;
 b=YWT3v7KFuhC8Fu/JjbbISZoajjKzDyzA7LBhU2NUd0j4+INVX/fihkW5B4COR10BjuiZjdXH2FnQrqZVYvip5DrCK3WquFAXNtY6T4hXmPKO6/DgbRo3j6EueJFpVF2ftLiDJ344aFoCUgSk7lwV5lLoqyNXozGvlkS0SR5ov3o=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bda) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Wed, 16 Jul
 2025 09:56:34 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::d6) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:33 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:32 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 47/48] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Wed, 16 Jul 2025 11:54:29 +0200
Message-ID: <20250716095432.81923-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|IA0PPF8FC6E1236:EE_
X-MS-Office365-Filtering-Correlation-Id: bacecc5f-aafc-4501-0fa4-08ddc44f0c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Up90Tph8KcqKe5CGscynKuLEI63+NiusC/W137t1zEQAodMmOt2XBWEnBDk6?=
 =?us-ascii?Q?xdwUGvVX1xyaq2CMx5j7iTfeo/QnrYPxTtsQVmzzRJzDxZcdHmlecewAFZ4J?=
 =?us-ascii?Q?wGK35zxe80LzzBl6K5mCO3WvHH7M+KqKkFiZQWf9O2nhGo5hN+udDqHs7JVp?=
 =?us-ascii?Q?V7CNfMEQBGXYloPhTfiKmh8fn6PKcoBnd2cGqn1Y5kKMBRtHLr1VahkbLFKJ?=
 =?us-ascii?Q?db2KnOiVrz0/dFptinwhaquhTtFQCP30DVzopz7jSD3nD1z+qpxRuquac7sI?=
 =?us-ascii?Q?0hel02AZafJ7U7K8LzrWW5SEVU2NVNnL1qSUvfPBu+nIrZjgATs1oWb2nah+?=
 =?us-ascii?Q?RG4EDc7u22xS64Yzopc1czFQWFeTj+nQWxDlJqZtkBVhMr8cjxG4NlM/9KkG?=
 =?us-ascii?Q?actf/D25+8boGP6fwuesexNuooaZVWRI1y3wgsWcdQ6eQomsa69yu6OC24cj?=
 =?us-ascii?Q?F+aME3It5XfGztgEkNyami9e8LoMIVoy3iZYZtQ04ER668+FPX35kqOSGfq+?=
 =?us-ascii?Q?H0iaHRUDcpunfpWAP/ipExeNw2N7h1H4y1ERyPMCrvoLQoFQOAEhnRrGVZpR?=
 =?us-ascii?Q?071vZS7qYHV89mY1kbDUKXnd42nwLQz28ficf1PSxChdf71vzTj+Wd2Sy9XL?=
 =?us-ascii?Q?80IvhLViftJCRs3xtr5nb6x5O1KL1lSEK0rm5e893b2CBQPUipB4pVBz6y5l?=
 =?us-ascii?Q?Fou76WgT49ZeCv/SRG2Rb/BTb2/K1Xocta3siIbHDNFMWGvHU7gB27JdPKYa?=
 =?us-ascii?Q?1ZPReeh5QvKUz3Yc3WRu75IUONkC1lJkKBZDzewTZPWJQwX8EVHlZZGOstXh?=
 =?us-ascii?Q?6vELWSnkaoQM9cK2r0bBtoH3xcurOrQxEGo7pGN5cptw+GcVF2eeiVtcr2y9?=
 =?us-ascii?Q?x16tPmUF/BNDQBx46UZ8L1GqLTX+kB85Hl8jFTmtvUI3EIdiMCWSzFsZeXMW?=
 =?us-ascii?Q?SSyB5m8NpEPCLIfhSxxxy8rBOlKufL3AjduPNi+u+s9MMeYX7sFDYLXtCd+J?=
 =?us-ascii?Q?CUvGCVQUWQkTLQ1jv1VuuFpKrDyR3Z6xchGX4wvXBUGNsdzftqqqcDolWwYK?=
 =?us-ascii?Q?wxNNo5yFSWLDkeQJibWnNLm2yBtyGd6JnzoVstXNG8AQgQ5DqDdOn0zQaoUH?=
 =?us-ascii?Q?428K6cymt5hb3pgddBGOHpqKCgBoLHhcsw6WpQ1FZDJ+4Nd1SO1FIY4r01+/?=
 =?us-ascii?Q?Seolpw0rtofwq/aRWphRI86GWBwCOjUe0S5XIitJr/rBvzmDUjZlhKjAI5L3?=
 =?us-ascii?Q?t94ofZYKHifzvYmENs7bzw/AdvFC8BEbXBKpVx03t5SXsjh9VXWVXQkJWVx+?=
 =?us-ascii?Q?VGetH/iYYOJEELNaZZy6wuDVpU0FUWc3MfZlfpQBUu+xPmx8s7c3QCE0dOW4?=
 =?us-ascii?Q?tw6C5DFoATFnl11FNN6gO/uV4+VtgAZE3r+DwGabS302sPYinRKznTdDf/WX?=
 =?us-ascii?Q?brNSgx56NZrVd+mwsf8EQnzgashWFNqhGr0cvYpdNK1dFioRhLUOtftc+3L7?=
 =?us-ascii?Q?iCpH1VQJ8KLSEG5hs90XaFeE6oVy0HebqCQ3kUIJDrPjf7W3ygF/3wNXcg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:34.4774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bacecc5f-aafc-4501-0fa4-08ddc44f0c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
Received-SPF: permerror client-ip=2a01:111:f403:200a::622;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
---
 docs/system/arm/xlnx-versal-virt.rst | 49 ++++++++++++++++++++++++----
 hw/arm/xlnx-versal-virt.c            | 37 +++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
index 5d7fa18592b..af56b275413 100644
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
+QEMU implements two variants of Versal SoCs:
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
index 154ed7332c3..8cfb7d0c380 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,7 +1,7 @@
 /*
- * AMD/Xilinx Versal Virtual board.
+ * AMD/Xilinx Versal family Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
  * Copyright (c) 2025, Advanced Micro Devices, Inc.
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
@@ -362,10 +375,21 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
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
@@ -378,12 +402,19 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
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
2.50.0


