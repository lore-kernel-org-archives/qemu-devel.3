Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782CCA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:26:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9L-000468-GT; Wed, 20 Aug 2025 04:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9H-00044i-Qx; Wed, 20 Aug 2025 04:26:23 -0400
Received: from mail-co1nam11on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2416::617]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9F-0000qw-KZ; Wed, 20 Aug 2025 04:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xde0lqBq2eEYQxBJw/jTK8SgiY16vCSLrnShjNXKYfAj/CLyd45shtaWKB0QGB8B6oZxBtV6k+5aroKMUTsZyJlCIxul9fYxrE9Ym/NOunkbAAgmoFvPsG/bm0zJlHf1BZoy6UAo4s31foCeg+2rw6AKc5ZoktgIQQ/wANUEdIjSJYL+GCBDbkYhvcy3g12jGJatn3ghbIiG7pLuVKe/3xP/4bZ/qQsYUqKiKTyE4WTZIOiys1Ell89e+fD8thmF7xFPOa7ZRxuoYiM0ZegDBwarQZa6+rv9i6J7jJSlJss2yrlzsd8H60BexnEZAgkEI6BfS1nA4Fad/AUqXaseTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz8M5qTFudXHRs/ULOE39YdZWOGfKBKNi+3wM0VWDs4=;
 b=tUHxKvs5L3dkWxehKjY54sy2p3y1nCNU4fY1QlBZs9nYz/pLd7h6rykRu7k3eUKRuVhirtqaeAVgAr2+Sk4Tfzq88hzj25JVHI0O/Vvo9mAaOuU6ul9ogCRFoMXY8y1fztt+YuqAkGCbi+977BRIGKyuO3Z4DVTfCOdRqZJkBhX9v47ydzAhxASECSilFdcoopsqmGwi1mSBjz9IkAS4CykKumBqHG3rTqp1ILTG9C9QxC+XS/x7p14gjnRQ3Mxmstuum/MkfVERV4P1b1Khm12ab0EohnlfaMA5j2yG928pvHMU8wB2mEp6jhbKR/uA+POn1Raa2HIjmSikSEnRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz8M5qTFudXHRs/ULOE39YdZWOGfKBKNi+3wM0VWDs4=;
 b=s8FertyfWZW1Ojk88BfTBsMWISETN7rcSjb0Oec8xmsBrLnatjq8x40nK7v1SPu16gtiDED8+Smvk9S+890kO2rF9A65vDCZeVKuZvo+yb84j2VrbWdnGNpVm4SlZ5U32qi4jk1clnmHQbJgmgKJDeKnDJ1Czcnbcx2d350DmxI=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by SA1PR12MB6704.namprd12.prod.outlook.com (2603:10b6:806:254::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:26:14 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::d3) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:13 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:11 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Date: Wed, 20 Aug 2025 10:25:01 +0200
Message-ID: <20250820082549.69724-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA1PR12MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 859f2b3f-4545-4cf5-ed13-08dddfc33a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RZbvpN8Xxb78+KBowTzXBuPONUGb+p6p0WhYvymTPLs7tsYcQ5zYfldGJuXR?=
 =?us-ascii?Q?jF+orzS45wjRLnkLPAXs/SDoOiEnmGhmt7LysY6CjbTZbTJfsR4cVBwrb08K?=
 =?us-ascii?Q?9fWljBVeFJDaRY+ShNRpVR43/Kebp5W5rwG8J4F2/K/RX9WyBewE0MGFI+Q2?=
 =?us-ascii?Q?omn0llS8qOutnUUCoSJala5xWoK3qIsqZ9RKCnHzOiZ8ZvO1FuFinqQrMxsG?=
 =?us-ascii?Q?jI33IH+rRw5NyXiPgMV7Z2tsyL6H5lmq76LSqmzidkR6eNK6WLm4sLHGF9l2?=
 =?us-ascii?Q?2DydEofoUM00GzN3Sg1Dr3BH6NVuHLEDbkWvhzLOcK/GcPLQrJejAtEm5RAN?=
 =?us-ascii?Q?OWwn5AXTwcccy8RIRIX9MBzDitO8XOxp8uBKszskBpqe1N6ZE8F5RJId76b6?=
 =?us-ascii?Q?0dJKgl/RLklOwsy5OV8C8JCt+l/B36HBylkX5cses9qIGDO/sdFIAGVpkOyX?=
 =?us-ascii?Q?kZKOEFdukrbd3srCn6GNnMHWycfWVQ6sn8pKZ3FZmm22oqmaiytyCBdTNUC4?=
 =?us-ascii?Q?QN5sYUPmdX3qxfeWcl4CSl8q7g67ky+CGIsgjvjPqdpG92H19UxSNoKmP2gz?=
 =?us-ascii?Q?hN8iweVGkc09rKcjzNr8JSurlgyCbAAo6Xq0kHiuBaLhXnnoTEo5JDhHm8DU?=
 =?us-ascii?Q?MB0SbiM/ktJZGqRnWKfHsm2SajqT+6YtnijEpzakXeHJbL36v0engivjqC5Z?=
 =?us-ascii?Q?1G6WEPhEqDtAMvrY2QEHKX7I4pY/AfP2QElIYvD2OEGqhhZQYue3H2qqrtir?=
 =?us-ascii?Q?ByMVKbYNw+9CXAiJsSHCZ3+fhUkTUzMMpAYLajnJJPYLpG4KwQslnhOOE8EY?=
 =?us-ascii?Q?qWdcI4Z+l9wjG6bqy/XLRCpV0uwbbLpTjPBfQgpXDI6E2cnWHy88a26RghPi?=
 =?us-ascii?Q?+aS/Q0L9NaeeOSlKQtc0UOXUnQhJTG9JZzkglv8AbLxJ+o/lyXzS6TS1Pafi?=
 =?us-ascii?Q?wEa+ImOuVnYRtijy3rutubFYqXeAufgOejlEuw/uIbXj1adFkf6ww13W3R+9?=
 =?us-ascii?Q?v6CelswmEZT5baFTdRuk0SBETbzl0pV3wU9HAedDSPHgp811qVJ9e80hRE8G?=
 =?us-ascii?Q?+JCpjzA0hAtJGorvpBABDIGJZ2bqZTrnfD+4009A8Ib3m0RtVdQMm87iK/HL?=
 =?us-ascii?Q?j4TAG8BqDHHGe9x4dovKVmrixZUCVevz/ndCL3DKlDF310EUcI/vO049/bQC?=
 =?us-ascii?Q?U9OaZYXWIzgB3ytmN83AQnZFFg9aJtDEUiDRcsrK+a1GDrECnVcFlBcs4KbQ?=
 =?us-ascii?Q?rSFszoHWt3xMOooYbxdsLEKW+tOnkNgxyLw5ITaCrrTORV+Sruc5Nt9t4KwS?=
 =?us-ascii?Q?k0IaNi8n2minjLA0+Tfmj6kC0omfBliQInKi6T6z6SsCYRbBTRMTAo8GRBBv?=
 =?us-ascii?Q?gl7t6T0EVGlWLAhHeU2Hw/0gxGFipXOUGMYsY2g8kVh0x28aQAq/HIGqe6oc?=
 =?us-ascii?Q?k7XkqKmBoWj1WtQ4sVvohV/hmt2z9GwKVxaWZiicY3uGFx81WMVhWq42+MgI?=
 =?us-ascii?Q?96S9DCBM7+isA3zMDdcFd4IdiICD5OKHd97a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:14.1127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 859f2b3f-4545-4cf5-ed13-08dddfc33a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6704
Received-SPF: permerror client-ip=2a01:111:f403:2416::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

The following commits will move FDT creation logic from the
xlnx-versal-virt machine to the xlnx-versal SoC itself. Prepare this by
passing the FDT handle to the SoC before it is realized. If no FDT is
passed, a dummy one is created internally as a stub to the fdt function
calls.

For now the SoC only creates the two clock nodes. The ones from the
xlnx-versal virt machine are renamed with a `old-' prefix and will be
removed once they are not referenced anymore.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h | 12 ++++++++++++
 hw/arm/xlnx-versal-virt.c    | 11 +++++++----
 hw/arm/xlnx-versal.c         | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1f92e314d6c..f2a62b43552 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -134,21 +134,33 @@ struct Versal {
         XlnxVersalCFrameBcastReg cframe_bcast;
 
         OrIRQState apb_irq_orgate;
     } pmc;
 
+    struct {
+        uint32_t clk_25mhz;
+        uint32_t clk_125mhz;
+    } phandle;
+
     struct {
         MemoryRegion *mr_ddr;
+        void *fdt;
     } cfg;
 };
 
 struct VersalClass {
     SysBusDeviceClass parent;
 
     VersalVersion version;
 };
 
+static inline void versal_set_fdt(Versal *s, void *fdt)
+{
+    g_assert(!qdev_is_realized(DEVICE(s)));
+    s->cfg.fdt = fdt;
+}
+
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
 #define VERSAL_TIMER_VIRT_IRQ       11
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index adadbb72902..69f3bb401b9 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -1,9 +1,10 @@
 /*
  * Xilinx Versal Virtual board.
  *
  * Copyright (c) 2018 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * Written by Edgar E. Iglesias
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 or
  * (at your option) any later version.
@@ -695,14 +696,13 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
-    create_virtio_regions(s);
+    versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
@@ -712,12 +712,15 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
-    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
+    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
+    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
+
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
+    create_virtio_regions(s);
 
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of multiple address-spaces.  */
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4da656318f6..7bb55751e5c 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -22,10 +22,12 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "system/device_tree.h"
+#include "hw/arm/fdt.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -917,14 +919,42 @@ static void versal_unimp(Versal *s)
     qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
                                 SYSBUS_DEVICE_GPIO_IRQ, 0,
                                 gpio_in);
 }
 
+static uint32_t fdt_add_clk_node(Versal *s, const char *name,
+                                 unsigned int freq_hz)
+{
+    uint32_t phandle;
+
+    phandle = qemu_fdt_alloc_phandle(s->cfg.fdt);
+
+    qemu_fdt_add_subnode(s->cfg.fdt, name);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "phandle", phandle);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "clock-frequency", freq_hz);
+    qemu_fdt_setprop_cell(s->cfg.fdt, name, "#clock-cells", 0x0);
+    qemu_fdt_setprop_string(s->cfg.fdt, name, "compatible", "fixed-clock");
+    qemu_fdt_setprop(s->cfg.fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
+
+    return phandle;
+}
+
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+    const VersalMap *map = versal_get_map(s);
+    size_t i;
+
+    if (s->cfg.fdt == NULL) {
+        int fdt_size;
+
+        s->cfg.fdt = create_device_tree(&fdt_size);
+    }
+
+    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
+    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
 
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
-- 
2.50.1


