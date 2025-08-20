Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C2FCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeBj-0000R0-Gf; Wed, 20 Aug 2025 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAT-0006wB-J7; Wed, 20 Aug 2025 04:27:37 -0400
Received: from mail-dm6nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2413::602]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAN-000162-9K; Wed, 20 Aug 2025 04:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqRAEvnrpt/9wS38PNmPUP7uDJnv0L9sHzUWxewtvutoPoY3U27j4BrFbVH+JXGRCrPgsFI6s9QHjMWmZNWLzUFrakWocVTTBQqUM9mb+efuhvlLIz/ApRdDlvyNqUckw0nFO4VxN+ntTbS1+ldjCAdJtcvmID6ueIJ0mHAg1ruBocvSNT/3MP4m+r00lgeltVmepl3au7zhx1dJJFE835Rloq7CK8KllxrVoU8eFc9QuU8VOYEkYq7nPA7rVj2lOxD5sBVkGFSnh8iYNkP9BngGHRBKr6hVhJukOVt24RJqB2YlFlnK9b1HAlxO8n+Ju/Fdr9npUOQMur0K9KT1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ljOx86SsWZfby83W4IrQGnjvJvHN7zm8d1gN4arqoo=;
 b=PWH8APwdd01Nkc+RYb0N+DMOCL/Bg25t5CceJ/RGQuX3a4bbooSDpPruzu78Vo/9VruaBq8OJs+i/ppzAPDPrExjK5UcLoM7dvKNX7tYQYLvyttTCo+6rsUIUmJnbZyqvSuMKGEV5AksIjtZE8hcFQBDMVyvnrqkedxOqcwOcH018VK7mdqNC2h+9g4WJg7Vtb9Rd/lD8cttliAnRNQvADXRhUMpOlVdP3/YT5aOHfpdI1h7B2IrtbpArGGvz48/oDiWtN7v5GwmExoA3zsfuz8hjOEv53bFvApitt3fI33stqvzv9U8gIzcxscHdcNVch/R7E2F3N/oWQ4KOVyMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ljOx86SsWZfby83W4IrQGnjvJvHN7zm8d1gN4arqoo=;
 b=ekkljOYk5X0MJLg3Wuexq40tntO5Pr/XCSPZ0CVbpaCtttAV+dFVFzFD98d6yAJ5ZXeay5Y2BAA0WipQoO5WOvitBEUlmLd21rVXSyXqcAxOkaqLVcEosELRjElLt8+av54SDvx1DTmIb7M8axze0OzSq3oMEPBHkcBT0Vo6dbE=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:21 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::98) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:15 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:13 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 34/47] hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ
 indices
Date: Wed, 20 Aug 2025 10:25:33 +0200
Message-ID: <20250820082549.69724-35-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 10af26fd-615d-44f8-4de4-08dddfc36239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0lGVLjhisbxykHI9P3UR9uwHSYpoFr4zVOgJc90e+A2W3hq91qRoUY01QCrW?=
 =?us-ascii?Q?v1H9cKBcJtUIRfqtXYotV1SMTbjEX8iQHSNdHvoYcM596IrW0sQ9bXnULHQ3?=
 =?us-ascii?Q?WY3K6WjOuDcYAHmw8lqWlz5rwrPlH+W9aX79zBmjKiGaGPCHZa8xt6TeCYN6?=
 =?us-ascii?Q?Gw6Lr3WkCGsC7e8ChyUas3eazMe/D9sCbs/X0Olq7xDqvjLjC9j5lg3AcZpX?=
 =?us-ascii?Q?ZFXw4F0SYd9zAf+AeDd+mdbl6FPb4SVJbdnaFZiWD/QYExBpXtcFFe3L9tIP?=
 =?us-ascii?Q?VN/RwxPZBjO+tEF6ySJuTtmJ7l/EXRxIwxAlxKXjaGgsuI8DkNkay2XwcJIV?=
 =?us-ascii?Q?NdFcc5X8+FTA2jx2KfL50qgR4TXnei5JoAplso7IYYbe8xNrwNzLF6uWr4nX?=
 =?us-ascii?Q?ptp5RfLChnz5UN23QiISp8VmEke5G0UdxQGs5c8puW57E76og0cPRgRljqU6?=
 =?us-ascii?Q?5uA5rIrlWGbrxp6NhXstx+20qmUder853YFbyR9rWh54ouRluUhUICnCdTW5?=
 =?us-ascii?Q?E7Wps7Gm7lwFICN80BO3EWuXPTb8BgVxdl0c8EGOR5Dgr3uuNPmd0u0FEpu1?=
 =?us-ascii?Q?bvoMGPlFHkfDrMvF9C33zYCzC0I7gk19/xO7cGcjKIBBcCML9l2D2aIoVqXV?=
 =?us-ascii?Q?CTChAfpISZFdLYkQ5P8LU4xzceVceagCUImPZP3OcLNObuxESHfFbeAepNPI?=
 =?us-ascii?Q?gH4l285AOKhdRk4476i56vx8nTR3FzYDVP/0giLXidQW+w/NLwjCbVueEzqy?=
 =?us-ascii?Q?QTX6ceGEAldhmescjwvm/S/lEj/x51ZbUm+BUdSefdz2oxlBkdBxN4P/7C6V?=
 =?us-ascii?Q?lianpHxc3fkh4Mm5aw/5oXQf8rMpHPZ6BX0FDxHL2OeOfqF294PynUqA6esI?=
 =?us-ascii?Q?5XSs0gKiAL/WztOBLoLnJjAG+SFwdMW10WJQefEXXvtwBP2scazEQr0kRL68?=
 =?us-ascii?Q?rNZu2YCp1Py/Ie+MG33hrS9+vmzWn4Qel5U0hIxOl9iZaxSyQxxz5KDvz8Ge?=
 =?us-ascii?Q?UkHp7w4YUIqUHtoKwhwPDBGgV67ecol976tF8KcCQWL8jW6VgPkrjVYBYFWs?=
 =?us-ascii?Q?Gm7yi4rzTLGognMlQlOb8S6pdRUhVyMxEuSGhwtBl63g9Bnlo0P0zPRUJECY?=
 =?us-ascii?Q?L+zsys0dy8xTPZ5cK1oPqy0mX3mcasZ2YRVBBNipVgtTuG6icUdDdos1PKuo?=
 =?us-ascii?Q?fKUm/rHSBxHjmUmV5fOnI16UlkvMcnX7MTKqXIK0bVV9Uy3sNz7rQC1AsZNu?=
 =?us-ascii?Q?yjgiVi0NjGCgYK0dk47VukkffV38InjTsPHLF5FEdKhTeUbuStMQpXohQlWS?=
 =?us-ascii?Q?gFYaxj0/qtio8aYwpnxFeT561vs5CLCVHm3VJkBP7I8GT+/D3EZLjtq57QYU?=
 =?us-ascii?Q?B63mNk/46gtglc9lteS18SHsAgv4asBvC/hmKCOOKCICE/R7aHzJ0BhfSIIZ?=
 =?us-ascii?Q?HgntOd2Voyfs/p/3pG0/U4llzDpSHspSftwU0LpIwwSNAtil4LBl7rtI7SUX?=
 =?us-ascii?Q?Oy1zU+eU/5th4PAm9FbfEe/PWL/+Dj17SPan?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:21.4675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10af26fd-615d-44f8-4de4-08dddfc36239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
Received-SPF: permerror client-ip=2a01:111:f403:2413::602;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
2.50.1


