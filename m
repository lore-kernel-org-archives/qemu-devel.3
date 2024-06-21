Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B76C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdrb-00013b-QW; Fri, 21 Jun 2024 08:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrZ-00012v-Mv; Fri, 21 Jun 2024 08:59:33 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1sKdrX-00013Q-B2; Fri, 21 Jun 2024 08:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW+dEkFKzQDI9a4/W7CgxfjwiQHMc0BbYSrxvIUvWaqanFd0djwIg7C5FOAs5MfOb5zxr58nTcyjvbK7D/RyY/Wt1RPasLF1VWFJrA9+7NgrifSkN6j/7Nz2r5LHYuUNRi45+j8ZnCLiuHe0/TMbAGMdPvMXjDjg0KsvTJhhp/kScOuqPI+Mw4nuMjZmbXEh/+SuF78989wUxA/nBv3kCc1Eyv/8rBzION+g3EkLkA5vH37SCB9opWQdFmlP8gxTKXcNveIp8jlAkQgNVa5ZziGY03eCal2uoXV1KBr6iDc0u6m+iPvz21Gz33AMBkNAILQRK/Jtb5vlx5KJdmMSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsbUIP9Ok9jpGdpzLD4Xs/YbIUf6TMu4/snoy+PHiAU=;
 b=QInP9dmClIph4pXjy/cXWHL67iigi6taIqvi01KYzHPXyPR+3AXaAcCICEGNSbfnNJcWfbt7scCQRutL0hGwqdDfNtOjceg719fYBFPpERzQicJ6E0EiswmFZUt3ex49zD2nrs4gnNhwM8J7mlKXcqZ+5RZvvoOiZMTBzCINtIEnGrcMsFcDhe59AZmWM0PJmmjeYhXvx90xNikD5czd/972YyfK3d3dI5sS4aBZl/zoHHgb4phIs68MLpxwcro87/2gmDjBn60vITp0YleGu0+Bd/CLh7nRnOnJ7zhkNG+ZglUFa7BXWe2kgQGXt3gE5lswzE9lZ+xb5PVcxFZWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsbUIP9Ok9jpGdpzLD4Xs/YbIUf6TMu4/snoy+PHiAU=;
 b=3quZJ9gS1WS5M4XPL3Cb2TjMdw9RaF1Yl92+K0dplEn7xvUdyNy+7k21sMR0nNeE3UjvNC/p97nCH0LH+4fM36n4dUn5vOHSR8PAT3IyjBfcYgpkYVzh9HvrHE0s+n59mSlL/faUdxsUSbPiqvv3OGoPStdDJxTknoKWyTGe5aY=
Received: from BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 12:59:26 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::ca) by BYAPR08CA0038.outlook.office365.com
 (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 12:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 12:59:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 07:59:24 -0500
Received: from xhdsaipava41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Fri, 21 Jun 2024 07:59:22 -0500
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, <francisco.iglesias@amd.com>,
 <sai.pavan.boddu@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v4 3/3] docs/system/arm: Add a doc for zynq board
Date: Fri, 21 Jun 2024 18:29:06 +0530
Message-ID: <20240621125906.1300995-4-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
References: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sai.pavan.boddu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: ec10487c-c1ba-4e30-da7e-08dc91f1fac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|376011|1800799021|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BRzPN5sBgjZmX5EDYtyy+N79JK8/A+Vt+4dUyVvJedPx878vcxQLin5jbRAc?=
 =?us-ascii?Q?I2QDN4Jl7/Ma3b9RyEb+G35+z1oNSCyB5FfCNwvbr1xbuZXPBp0oNqOkyadl?=
 =?us-ascii?Q?1AwcaCEW19oY+zZDndOjIGIYntSkHCjYG58GeYuTJmyogan0uiQbfwLV0mn0?=
 =?us-ascii?Q?OOcnhjaRD7Bj3jrUfn/x6PbcVKADYCXhK0tb35Lr9YhD5BxhVNmaBrUFeQsL?=
 =?us-ascii?Q?O6G6xnAZ8zL4jmpU75JiCEXJrsv3qjucb7Y1RF63VQDcwjjDwAQg5yZFtkCw?=
 =?us-ascii?Q?sCjvTUSAbCYYphYfsrmSPVuh7D4ljm3A/6rzIFZZMzSsFJSr4yo0rqULUnvr?=
 =?us-ascii?Q?UoDtan/plD9w0bm/pdwwk+qOBzfDp9KyxlTQ8Tu5VozJQU/3IukjS8yqyLt2?=
 =?us-ascii?Q?qTP8BlxeEw4e5bQTVvaaaOpsSL7t0mdpFebJTSfV5N5Ng4y5kET2KgHq33Pz?=
 =?us-ascii?Q?bOe7SjUC6RV0GvtR7EsIDOfFHTFlFk0aOJRZCqlJkKmvTTsfY7+Ip2Ob2Lli?=
 =?us-ascii?Q?mwRrtIoTXH3i1Ok0kgBSUUSWAtI1m7U8JhU4mMWzwTJwVI0i85N/XiF7C6R9?=
 =?us-ascii?Q?DuiK5iXoylKZLr90WOq9yh9UM++ouzJQKpauz1uPnwcmUvPfnLxl4Uxgm7c6?=
 =?us-ascii?Q?/QgAmWgxcda4LJzY+gL12w36pW1i40q4FD4LUNa3/A02lU3SVaeX4d0rabsT?=
 =?us-ascii?Q?KDMEZ+X/D3o5dPG2TjlZNygaLqAxtWKxPVt1XZZkHYpAHCBBGXk6KoJC85l2?=
 =?us-ascii?Q?sMnb9rzlQDRIiZV9FQa/pDWMMVobahYvT/34OYJ6R/+U22tmP8KPE9yyTUdt?=
 =?us-ascii?Q?d90CKNIa1O3ePVhd7gUNM6VtR8xaYhKgwwGQT8g2qjX4y1ntLZ6b1Dbl39CA?=
 =?us-ascii?Q?yhTNAclRMea5PLphREiPWQCLxYHQ02FZ1GHvP/YD68v187dy8sa7Yx1sRA4A?=
 =?us-ascii?Q?8xruQFSfwCypJ6xtvvBcm+hAp7YsIPJUHxPqBHQYmENKogoZPQAfbvOwJAxb?=
 =?us-ascii?Q?gyeVZ1bSJaUKuCoqXuAwQ2ZrPcAM/TRTw4m/ZmQnFM9jGaN7xVgQLsK7FW5b?=
 =?us-ascii?Q?cDkKPffWPilAT5nxwLnAa+ymlvPrutdPT6NVyfE2/SztQMMyAuYUTuPiP31C?=
 =?us-ascii?Q?KjtHJSI/3eN1x64FhzVn+HYeZ7gjfGYt7w31pHf5C4cNFVHwGEU0jQ/n8jFP?=
 =?us-ascii?Q?2ESDY0kc0PzTVHlxwcwGN5atOVowA4xuMLmsNzkQpxen4tbsmg9tG7WUtZTG?=
 =?us-ascii?Q?NDLjVpRjrVooQVwXYBO12D/rX33a7ivgjf9tWNGOZz+fbElBf7OuSZy0hsBU?=
 =?us-ascii?Q?FaS3LIDh+Se3GfmZX0Lw39Ij9BzNyV5N3avVzpC++s89vTP1HLZmRYf6vAvw?=
 =?us-ascii?Q?aeSBerc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:59:25.8974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec10487c-c1ba-4e30-da7e-08dc91f1fac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
Received-SPF: permerror client-ip=2a01:111:f403:2416::600;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Added the supported device list and an example command.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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


