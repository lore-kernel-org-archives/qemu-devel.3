Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F0CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22eF-00044a-S7; Fri, 26 Sep 2025 03:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22cW-00018o-Uh; Fri, 26 Sep 2025 03:11:57 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22cI-0007Fr-1B; Fri, 26 Sep 2025 03:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCgX4uE1z/QTtxXzXik5JlgGNgGEOTrcgDOEXmMMKL/S0S6LHV9iIB8zlVVHzwjxN6yIiYcFPrAWxQlyuRIgoXEzj7Cbrc3uszc2/E45rwBH3t4gt3TzN9bgHm0SsxTduI1RH6zACdDN/U4ykimugVBOPtyOAud5lxgCmWs2KLb4NkwqnvUplxzzjcpJYGV3LNpGfumbnY5czLisrv6B0oaihkzlVK/KPbLRJMnnqIsUP2/fMgxnvfkr6lAPybLxc7p+RMhAs1Cms17QU4/DjePLQtON06r2fx954HJOopkbR03CtHliPnLPjUpeMx2gUsMHY+oiDH+totniv0m9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3cVHGh/EYB743zmsItceTgQA4CaMgRmXLxsBRCclc4=;
 b=STflS60wiqqM/Y3O5hbzsBvFqHSzN/VJk5F5eD6+MJw086kEffU0a4xu62RG2JEQ4IZEtTXsR+XqHWY1szZuYpIwdjLU06QQsUE8tHsaDFm42/9YlvrjydJmHPjas8qDXxeHNHq1tey346ByDryBWWleZ6qDsnkvkKyU1Yk1z5FriOPn/b+LgiT4tmDCPCY05SlI6hCmVZyAhUkqWW0PtVmO2VNI5s7SyZ5V2WoncaR7HD1DfSM9CQSgAddscv4L4raq9Ngmt//CJl36sEW/shwNQLX/IUNcG3H9QXbK3CgXpoA6qF/QvJKzFouPbrNkeb3ZPttcMcHz4tMiaGePwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3cVHGh/EYB743zmsItceTgQA4CaMgRmXLxsBRCclc4=;
 b=o45anOSOZCVMeMUJRPLmxOhAsKh+bLRWbQSx29BTgyTv2PfHNzRTP0YjO2IGjrWvGkqDZnZj7V/XHgmO3j0nzKuHolI2yldCsIl3CfOHT4Gse3YunCJOf1N7eLi0sTbVKJh80KTSDwbXvaCh9l3L0bEjOIIRXio/i1rRBvsb4xw=
Received: from SA0PR11CA0159.namprd11.prod.outlook.com (2603:10b6:806:1bb::14)
 by IA1PR12MB6020.namprd12.prod.outlook.com (2603:10b6:208:3d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:09:46 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::6e) by SA0PR11CA0159.outlook.office365.com
 (2603:10b6:806:1bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 07:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:34 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:34 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:33 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 46/47] hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt
 machine
Date: Fri, 26 Sep 2025 09:08:04 +0200
Message-ID: <20250926070806.292065-47-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|IA1PR12MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: dbafbd35-4810-419a-228c-08ddfccbacfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wjSyqwh4FRFqd6FFy483iewA84PXWpqBBfw9UwCq5edML95woFrJdFJ4Vky2?=
 =?us-ascii?Q?+DY3URnOSls3JmZ3du3ATPEmniR1NU0aXa4C0GQiPRy/XtO4YM5RaRIQNc9j?=
 =?us-ascii?Q?tXHNtL6smma/P7HO7e1ws5JL0szJQUzgNO0dvxCxELOB+Iz+F6UvDToKmYAY?=
 =?us-ascii?Q?iRGtXvF59zvbnBCRC6/tV03NQ/bEk8n/I5oMlFbfooGeMwZhFCJee62B9BOo?=
 =?us-ascii?Q?8/NPN97YATnxh+XtGvyNRc4d0nNyffhtQPTRnPZhHKq5x+UHv3f7dP5HeEkf?=
 =?us-ascii?Q?Q3gAZzuJ/WwBdeQaShOibs4SoZ2d3LsAi8ni9oEvK2quOLXGnL3Tmj/p+nNx?=
 =?us-ascii?Q?RLShbLO3v0C82KFRgzdr8IJkqLPnijDh/dyE/630GR2ufYH9XBv0zXu5NvDH?=
 =?us-ascii?Q?dKiVlWLNKFVskoPGnL51KmcMdCWdD28EjVGla+/WSx2kvuGx2smW7H7yJYYr?=
 =?us-ascii?Q?62thN3OTWwsgGoolFNVMbRPmykH+uJve9YvZ3mHeYEgmN+BXwtq7ldtVzUtn?=
 =?us-ascii?Q?1s2ITBYrRL4TwR0wyp+v8IPDBbnkNcoAy6nl7PmON7i9VwqaqgtbAbh7oZIM?=
 =?us-ascii?Q?0jv5XlFflxVrVpMnCI5rx0WPjfgYxe9sUeR6vJ9cui8kwAeR/ePFQRvk5pkd?=
 =?us-ascii?Q?NXHCBw7ZHjGhbZkp/kNrBQO1ayx2v/OhO6cCQPngkaCLX3JgR9rm50J47CSg?=
 =?us-ascii?Q?Gu1jOrOBvyff0Cg6opt9EoMwInpnbHLDsWsedxEA3fko6TvshePjh2tT6+Bv?=
 =?us-ascii?Q?R3GiMGDSj+BY8PhWhFTV6bZ3TvGW+9CFQoe5j8WSjLTQkrPO5dqO3Tb9FGgj?=
 =?us-ascii?Q?CCjHhsq6JUiFU+b5VrTK4uKohCchvazY4xaYvb/DRpqEUfis4EUzAjhhcHxq?=
 =?us-ascii?Q?DSiWFM4Dc/g6zNko+bFzQsFyA9tMyXtOoCRjRxxmTrJVvdO634k5pDSd0wbc?=
 =?us-ascii?Q?X/xFkNzZF1LUTSs3GYuRrlY9i+SfQdM/UmTSzw5f0pyRlsRfE8Xd+v6kZksY?=
 =?us-ascii?Q?FRh191pD/cUnA9BQXXHqLtbp4N4ionC+pTNV/JS0FWSOzPc4gUmndVAshTsv?=
 =?us-ascii?Q?P6M4EYY54EMYrM/k+XbIdIgUjAhPbzwpaiQNZnLZEhprsf2ktlp726ZdRI2H?=
 =?us-ascii?Q?J20IXZ270iYBFJYD5zHD6yB9NKkXinTWJhSBLbc1TtXC5/HMoAoLyEOSokZN?=
 =?us-ascii?Q?JdMvRExnZSi4md3NDYawLdAeioxXb8ykvnHN7R1uhwcuoQMlC6jDZFgVHPf1?=
 =?us-ascii?Q?axluwe88+oHdLyIy4Vjv3rtWOFymqJmJ7Ol+cGkZHuIETgzJazH7sndTBsoq?=
 =?us-ascii?Q?ebd1gmLauwufu8DUo+C5Pz8Tht8pp/CrleV8L6nwLXXoLNqvP1gtDEVwFcnH?=
 =?us-ascii?Q?RmuWLLdwKJ9mf0v1RQ5MQ2jB4P+GvmZJALzItdavebgSfZrcSawD5lTCEfyU?=
 =?us-ascii?Q?OzDwlX2c8DlEhh2ys3uM4Gdjv5ZJpLbshfXmUd+4YJoyXu6HjkJtLXR8cPKD?=
 =?us-ascii?Q?D4E6U3UKbE1g0qFuOeRdZryBqN1opSdezHn6exnQ3O9EqzuPBMWP0AQgMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:46.6485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbafbd35-4810-419a-228c-08ddfccbacfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6020
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


