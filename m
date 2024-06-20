Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DBDC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFF4-0002d2-4V; Thu, 20 Jun 2024 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFF0-0002Y7-0R; Thu, 20 Jun 2024 06:42:06 -0400
Received: from mail-bn8nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2418::606]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKFEy-0005YO-6D; Thu, 20 Jun 2024 06:42:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3SLZu4vFN+cfAE2mQ/k2Ly7VXHwAoEO0LbY3bUhV6bCeZu8DkKhRcCGdCUE7uKvQvaqQX9wZfTpmEm+ZBduH6z7PYJqzEaAHmobXKONSKJ/EsGHIbO8/qfLienAJndei3vxn0YZuyWypXlSjwkEjWTFV4pD1eo1yIVBNzL/Cs12Ls6DMDEcOl9QTElgI0p/8TNW7w2/mdYoRHX1EW6zFE5eXalY9z3tce+p4dSvWTimL+wwAvgjVoOzwjU1nZfuTGVXkVujfF6xa5e/gYlyoMy/wD83m94T7Dxl66ZfAY0FYno2NndFH8hVtqa5X+eA+CEmmlJWmN9MFnlandiFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QtWRXaVYHO3xyKxfaWo0PfJ4Cs0EXokrOGNp/Ejot4=;
 b=kS/fpq6E18NqVOp5BGkV8zJZh3wQi6tgOWybzwDwNOpub/c4m1xjbJG9zMpSBwZE9Tsx9YrjueJn66IRpRV00mDO8zDYERZPAhmZ9LhEPT4y5V+sFGTTl/gyhHCXxgtm3D3iHtXc24tcjDUbqtUsIfGOA3eDoT936vlDOF12AV2I8SF0Maj8+5ZsKLtMspcjedIAqdSHJ0xcliQSL9NTf1e5qVlPWumW+r+pmkMcSLDLgzwJGYhICoHehkHuh/wvPbHX7pDEfIyUx+uP2TVwZWCa8iQ6Z9YAXklSACuZVLe//eWh4grzotczI6do1NHAASPOX12YbaEfvJCRKo+TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QtWRXaVYHO3xyKxfaWo0PfJ4Cs0EXokrOGNp/Ejot4=;
 b=rjYA4eLcH7+g68Gu0zeqCEA8Gz6tZyyA5culPAEn72FHSsX/RLs5b4miPdfpCk0cnnhcamfLmw2C0Sg9/I+wd6Z00B5pFUPz9VeSRVxCQP6Z998ZReD2KnnSefEBPs4HwLwxFeRQS2gkALvTDHltSbq6ioYkHFhY+bdcrEZllDY=
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 10:41:57 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::bd) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 10:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 10:41:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 05:41:56 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 20 Jun 2024 05:41:54 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>, "Edgar E .
 Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 3/3] docs/system/arm: Add a doc for zynq board
Date: Thu, 20 Jun 2024 16:11:39 +0530
Message-ID: <20240620104139.217908-4-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2a3e08-fb60-4fef-fa8d-08dc91159bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wNy9OX/l6as0nmkAvxtro7HDCE1eoSUG2G8bkF2PaL2kjFw1AnYOpZrgZMQ8?=
 =?us-ascii?Q?r3C2k9QTifalryK6rAypYFdO43nVqr08N670N3kJfgbZ6LfoA4+cjup/OQno?=
 =?us-ascii?Q?btccHpg7NHY6kuvnWau65V3WQYPeqFLZ+AhGKPfY7Fu642RbfqA+gn1kLBy/?=
 =?us-ascii?Q?wwCz545rO/+rXxYrtKW3CwUqp9hkBE8/kUv3m7Ibf6nNnhcS1M0epjj/OgpO?=
 =?us-ascii?Q?nkA1tjrcbGA2qCq9KU/WF9047JNvt5NMA59TgfxoWU94VQvz6VF916rfZTB1?=
 =?us-ascii?Q?OETy5YE3eoJ9m5dk1JGV7DRml5pdJCCL09ZsQUFdVHTXPJ60DpaQQSki4vZM?=
 =?us-ascii?Q?Z9X6HAYBbxW/s5ND9RFHigIkjqq5msm+u9drEVzUj4XgbndgvGXAU2WMA0wC?=
 =?us-ascii?Q?1ia250MHZ55UsjOOmLG5OUohXKyJ945P69EBtGgGWoR1xivRrlXrwEKB4AWL?=
 =?us-ascii?Q?eiCRdafumHIb6WtS+p+8Pu5zxL8Ybnu1LMQw2S5eAJ1juvAR+spy3g1g1YjJ?=
 =?us-ascii?Q?FsuzuUVxwWheRayVGcgamYEd49vghUCHZvl8JY8Gbu0RLmQi0gqbvvEMIdhl?=
 =?us-ascii?Q?sP6mekZf0A8aqwBtdJ/XYKMHPjITxNyKhgj5gmEg2u0LrSmri49Z1IvIGE9R?=
 =?us-ascii?Q?44/lF2sF1VMmDolUyTFQDwWCgTe20UPhINNq454Zo8Co2jq2N2aXKH0T/4jZ?=
 =?us-ascii?Q?FxHrwUvlc6QIO/bbQwGRyWfYilzB8f3NcTPURjHjZKIKmKoi4fvinzcM51og?=
 =?us-ascii?Q?6qutWzzVTu/jnh6uSS5dVrOwOWtp7c+oOqL5tMpO04hAjbokqVYIWkdd2ipZ?=
 =?us-ascii?Q?1qOBU3YbSA9/4ftAOKg6OczZkGHT/wDk5nxSd3Mxryy5FKeEr4bmbWur6Muy?=
 =?us-ascii?Q?27k5msZJ9mFRoBx87MfBz0kXV/aeSAdeZK4y1cmeJxU3UnVX/1I4EYTJzeZj?=
 =?us-ascii?Q?50IT/2Vi5jNfTUYSSS8Nyu4mcAeUCLikawdCC/q716BXoaY+sIIh8faJo2zL?=
 =?us-ascii?Q?0Xjeo5UDT1h5CW+gq7R3nDIbKx/wtyQm1+7pXacv6Y+Szx71ynnAQiAUYBr+?=
 =?us-ascii?Q?PO8kswneBfGGly+duPhGUPPISQo4oTe1Q1v2XaS57EushJsjncmnG9LKrQcC?=
 =?us-ascii?Q?n8lOgZwjrH3bgVezkC5t6Ez+Hl8+SYyNdOGFh5WJQlCtAtpsC1NbZGENkZRm?=
 =?us-ascii?Q?xEHHWa5DmaK1D6zmDKVMxNYkPwBO8Vvx3Uf3fiErlrMm7hOUnmYlkuyVevL3?=
 =?us-ascii?Q?MyF6mmeKBgdxwOt8cFfY3sGkc01dKJmVMsmphprDyand3jVi2hTYbekj7tfZ?=
 =?us-ascii?Q?9Cxl5eLmykM/NtA/Qu/MTysptS/CqXjDkYnkz+X2WngxW0NC8bI0lmoSEjeB?=
 =?us-ascii?Q?7V6/254=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:41:57.2402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2a3e08-fb60-4fef-fa8d-08dc91159bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
Received-SPF: permerror client-ip=2a01:111:f403:2418::606;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Added the supported device list and an example command.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 MAINTAINERS                   |  1 +
 docs/system/arm/xlnx-zynq.rst | 47 +++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst    |  1 +
 3 files changed, 49 insertions(+)
 create mode 100644 docs/system/arm/xlnx-zynq.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 951556224a1..2f06febc676 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1033,6 +1033,7 @@ F: hw/adc/zynq-xadc.c
 F: include/hw/misc/zynq_slcr.h
 F: include/hw/adc/zynq-xadc.h
 X: hw/ssi/xilinx_*
+F: docs/system/arm/xlnx-zynq.rst
 
 Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
new file mode 100644
index 00000000000..ade18a3fe13
--- /dev/null
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -0,0 +1,47 @@
+Xilinx Zynq board (``xilinx-zynq-a9``)
+======================================
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+
+More details here:
+https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
+
+QEMU xilinx-zynq-a9 board supports following devices:
+    - A9 MPCORE
+        - cortex-a9
+        - GIC v1
+        - Generic timer
+        - wdt
+    - OCM 256KB
+    - SMC SRAM@0xe2000000 64MB
+    - Zynq SLCR
+    - SPI x2
+    - QSPI
+    - UART
+    - TTC x2
+    - Gigabit Ethernet Controller x2
+    - SD Controller x2
+    - XADC
+    - Arm PrimeCell DMA Controller
+    - DDR Memory
+    - USB 2.0 x2
+
+Running
+"""""""
+Direct Linux boot of a generic ARM upstream Linux kernel:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xilinx-zynq-a9 \
+        -dtb zynq-zc702.dtb  -serial null -serial mon:stdio \
+        -display none  -m 1024 \
+        -initrd rootfs.cpio.gz -kernel zImage
+
+For configuring the boot-mode provide the following on the command line:
+
+.. code-block:: bash
+
+   -machine boot-mode=qspi
+
+Supported values are jtag, sd, qspi, nor.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 870d30e3502..7b992722846 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -109,6 +109,7 @@ undocumented; you can get a complete list by running
    arm/virt
    arm/xenpvh
    arm/xlnx-versal-virt
+   arm/xlnx-zynq
 
 Emulated CPU architecture support
 =================================
-- 
2.34.1


