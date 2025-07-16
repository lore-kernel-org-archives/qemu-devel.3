Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C037FC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytF-0006WP-7C; Wed, 16 Jul 2025 05:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys6-00022a-3P; Wed, 16 Jul 2025 05:56:18 -0400
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys3-0006jl-Pd; Wed, 16 Jul 2025 05:56:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXV6fg1CKFbF/hIyEuRwSvRLySbshBvJ7LEb170VzmTfn42Vd9Xni9AG/u6SzUPJj1OlMU/+p6PlH4ZrQQ+S62pCJCUIX+rNevH42HOjoTKMRDTQWloS3qGo/xgZPZO6p/YW+A/ZDmB9uADzy6XPqCP1VFhrUeUZzwAgXu9b3tKdn8yCt0jG11jC+bXk1YxjM4Sh0d1JrNznjhUh0CvNXh10rrPh1U+22oBtNmpCQ9hxvtWNuZ6mC8MO+iLdcRtACeJlmqUbidBM/MWk5MZxfoJVwwx08rANzRGmLgxGF+KcuNucZDnZHTffBFTOCgZnQmhlvJOpMX1aCLN9Uh0zWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv7yGDXFfD0S8l1vjlI/l9phd1aVecqjoclXDiaSNPg=;
 b=R9WbUUWrTJP4n7mwCoLsz5b/ykw5IL4kcpE5L2hKE1ZWsn4Ab5O9glspQugLAT7BhT91G5hC4TMJwGSbz2Xm5287uUYUn6Vz6feZwR/CM6uWyi/BPfJC+7mhm/DiQGigbhspNdCz/X7O+nkUzdWFLJKQzf7SBYokrqd1U42bF60IxLoJZbvSaEV2B+8qumu5Ybrn9dGtwJjpikTRP7kS5VI5IQP2lyqeIOFHIHTnBNMkM0+tkaCnf4S3Pi6Q3lY8vP0WOBIM0EQ4xa8MAOsEnOAvW/8jqtF72ApJAUymCbZVXn83Rth8ILrnoj7DEtkwRiP5HVsqArHNKL31Ya4P3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv7yGDXFfD0S8l1vjlI/l9phd1aVecqjoclXDiaSNPg=;
 b=iqZTJgm4mTxsz3wXS2+zrMkcVl5kMP9sDTHL1VJn62oaukfWNVt/MssDJcesHoxqUA9Z9GrLqBP1bDmUIWqYMsnVnarH5Yo5k2VLUNn/nIvr+I21cIC2x36rJXaK79iUKrQudTTDL1TR95On/wZZ1sBMpWndl0EVOCkLSLq6oQg=
Received: from BYAPR07CA0095.namprd07.prod.outlook.com (2603:10b6:a03:12b::36)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Wed, 16 Jul
 2025 09:56:10 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::12) by BYAPR07CA0095.outlook.office365.com
 (2603:10b6:a03:12b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:09 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:07 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 35/48] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Wed, 16 Jul 2025 11:54:17 +0200
Message-ID: <20250716095432.81923-36-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e36212-1a99-4e39-6290-08ddc44efe19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aajSjcmRRVfehUixmNFhq5evV60b1HaYL/y6x9hgPbLUVvci3IUk3wObRyo4?=
 =?us-ascii?Q?sgHLCyPOrIUEPxRPmhBmB3J+gKU8uLhd8OztJkIhzUlH2qzsrHiFGPzJII75?=
 =?us-ascii?Q?DNDyOIM0dD7geTa7EQtPpkUPfD9bDb0KelZQdMoXgUYHS5LYoGwAwUck3rHn?=
 =?us-ascii?Q?y7aD5akRVCQJ/LtyLhOIkaxMnoCiAPCQZFbPRqdP0hZvpjQwhmn8oAvXAyiz?=
 =?us-ascii?Q?S49vlBI0nzBn0DVxyDDa9kbt79EaXK0EiJlvxua+dI9l4FrrywkeNd1a+8N3?=
 =?us-ascii?Q?nr6t8Ybjf0XwkUtx9WB1rq349F52ehNcEUU7sqFTVkHOGmTC52vD0J8EAEeE?=
 =?us-ascii?Q?ecZmTOaq2Up8HBqqtkQ6S4Hu+4aHn4y5kcMZ5n+ijG87hASumAeoZOXLqRlv?=
 =?us-ascii?Q?nM7qqFEu8Fq2rWR4nxO/tTaP6rGsd+iUQLRS0k5wzQJJO4q7v5OxRuNV6xpn?=
 =?us-ascii?Q?BNtCtmsVAZcWkjdGLTVuFs10cT80AvbflSfonLzFLJzRiBjX8GSBlfXBLF+e?=
 =?us-ascii?Q?IcgSiRDrBieyRxozF2i2Ywr8n1j6ThSoodLpV5l5xIdkTR2Vp2vpUjhdUN+x?=
 =?us-ascii?Q?bdV1nMnz1t3KwnrDtKucQOwfpZk8eBTZDOOLBGW1wuHs5/O86ghoOtJaZwlH?=
 =?us-ascii?Q?z+OMVPPrDch0mN3QC6X73UgoRoMmTTew79sZFan1NtQ1biSAEkqInRhJUZ9F?=
 =?us-ascii?Q?5bb4qt/mMi6+8VIsql7cMm3RsgDQRC0RMo0IF/fnc0iUcw5uUTO/Hvm3eTU1?=
 =?us-ascii?Q?oGjg0D8l1L7EGofqTWA7gu93wHT6ltywh39/JyWqPaSdfrw+DTiixRv1zdV6?=
 =?us-ascii?Q?2Y1FaeaO0Kx4W9mY6Q/US0KuAXOEiZZizJwlCmjxTdaUOdI1XuUHnbiMxCr8?=
 =?us-ascii?Q?jWrqoQnHSMtTWK4PTM3GPyjwsZn12ekUpqQBaWiy8DWKHoH1vtWOH/yr/0wX?=
 =?us-ascii?Q?kyerCUC0PAGUcBvP9nsi441elfQNAh2m9cCp4FNelJsBC5P28AiakuCEUxCD?=
 =?us-ascii?Q?8F5dinR1VAMxnr+AaKySGafWX4hrWjGNNlrxVTKC2ok/f1ItmHCk7y1mMpBN?=
 =?us-ascii?Q?/rSm04PVh/1+dWtmg/g61CCNUAIQoJ27DTfNJVVtppTJ0t8ZHHuSFmrPGKZa?=
 =?us-ascii?Q?8UeHuXSJ7Upk0YZncnV9oQ8b/XbWk7KswPnsSIENFo+7Y5dmycU+0kaWDQ8C?=
 =?us-ascii?Q?Axa6w/3HCpohW32G3wLqTgQyAy8NhpFVXM075XpQ61/sKj8Q1KNXLD6JQv4r?=
 =?us-ascii?Q?oMq9bw8n2hCVXCcZ6tXWlfaHIXR6zN0rW9qd/hsolvDbCyl+gugVkJhr20sB?=
 =?us-ascii?Q?bOpOhaNnQg2WmrDP5yARxmfJYyxi+qhN6qsB642OR+a41Wr5qwUQdNmipI3q?=
 =?us-ascii?Q?MJzGqWsnmuNcXBFOKqy496+I0ewoI8MU4QdLZ8RJ0rYLSQWUWUAbT63r8c/U?=
 =?us-ascii?Q?kkPN/c0m3hDMQVkage6/H0bRI1oD/ojiK4/aNGhoBZ8ga49GXzp+5YpwoLjb?=
 =?us-ascii?Q?w5n21o5HZ5Q9VK4Lv+Zx/7gPDnjTGArabYtJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:10.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e36212-1a99-4e39-6290-08ddc44efe19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132
Received-SPF: permerror client-ip=2a01:111:f403:2415::601;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the bsa.h header for ARM timer and maintainance IRQ indices instead
of redefining our owns.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/arm/xlnx-versal.h |  6 ------
 hw/arm/xlnx-versal.c         | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index ffa7801b30f..3be9f0a5550 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -84,16 +84,10 @@ int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
-#define VERSAL_GIC_MAINT_IRQ        9
-#define VERSAL_TIMER_VIRT_IRQ       11
-#define VERSAL_TIMER_S_EL1_IRQ      13
-#define VERSAL_TIMER_NS_EL1_IRQ     14
-#define VERSAL_TIMER_NS_EL2_IRQ     10
-
 #define VERSAL_CRL_IRQ             10
 #define VERSAL_UART0_IRQ_0         18
 #define VERSAL_UART1_IRQ_0         19
 #define VERSAL_CANFD0_IRQ_0        20
 #define VERSAL_CANFD1_IRQ_0        21
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 796b4911a02..c513d28c8d4 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -47,10 +47,11 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/core/split-irq.h"
 #include "target/arm/cpu.h"
 #include "hw/cpu/cluster.h"
+#include "hw/arm/bsa.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -674,11 +675,12 @@ static DeviceState *versal_create_gic(Versal *s,
         }
 
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
         qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
         qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_GIC_MAINT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
     }
 
     versal_create_gic_its(s, map, dev, mr, node);
@@ -699,14 +701,14 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
     /*
      * Mapping from the output timer irq lines from the CPU to the
      * GIC PPI inputs.
      */
     const int timer_irq[] = {
-        [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
-        [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
-        [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
-        [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+        [GTIMER_PHYS] = INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
+        [GTIMER_VIRT] = INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
+        [GTIMER_HYP]  = INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
+        [GTIMER_SEC]  = INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
     };
 
     has_gtimer = arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_GENERIC_TIMER);
 
     if (has_gtimer) {
@@ -717,13 +719,13 @@ static void connect_gic_to_cpu(const VersalCpuClusterMap *map,
         }
     }
 
     if (map->gic.version == 3) {
         qemu_irq maint_irq;
+        int maint_idx = ppibase + INTID_TO_PPI(ARCH_GIC_MAINT_IRQ);
 
-        maint_irq = qdev_get_gpio_in(gic,
-                                     ppibase + VERSAL_GIC_MAINT_IRQ);
+        maint_irq = qdev_get_gpio_in(gic, maint_idx);
         qdev_connect_gpio_out_named(cpu, "gicv3-maintenance-interrupt",
                                     0, maint_irq);
     }
 
     sysbus_connect_irq(sbd, idx, qdev_get_gpio_in(cpu, ARM_CPU_IRQ));
@@ -845,17 +847,21 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
 
     has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
     if (map->dtb_expose && has_gtimer) {
         qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
         qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_S_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_S_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL1_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL1_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_VIRT_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_VIRT_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI,
-                               GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ,
+                               GIC_FDT_IRQ_TYPE_PPI,
+                               INTID_TO_PPI(ARCH_TIMER_NS_EL2_IRQ),
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         qemu_fdt_setprop(s->cfg.fdt, "/timer", "compatible",
                          compatible, sizeof(compatible));
     }
 }
-- 
2.50.0


