Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9DACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4y3-0001K2-T6; Thu, 21 Aug 2025 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xt-0001HB-Uj; Thu, 21 Aug 2025 09:04:26 -0400
Received: from mail-bn7nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2009::627]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4xp-0002sV-Hn; Thu, 21 Aug 2025 09:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpav1tkWGCXVclyrkns8/Pql7dH1yq71PBG2uGwO5czvfFAyDbCoNPITt+SrRxoKYe4rsbeuzcBOIS1xQXVvGauLh5QuDA6k+hqgS0P+TcRRiuzt6j+mujbNtDkvv+7Cw3jE6PVYFXcgCHJmMbyy9auqwbd4erwsr5bncaYsDwoDvkzCy+hKCAguBde5C2DPunZ86fqOVCHlrCM4twC5U3wj0ZgOBkFVgUWLpUlaIIJi4ICQ9algTUMwsbw6oUswYYBL9K15vsGzeA/krVvizzcHzq0FrAKsux+atxhs3dPwCu9cape8uzfyLlQo0gn8UgOLKowkfVH3UoWp27KfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hz8M5qTFudXHRs/ULOE39YdZWOGfKBKNi+3wM0VWDs4=;
 b=AxZ9TgKlgy3nKLKvubRLvPyJrynDNgYgQUKD8wj7GLtR86NJmv8oVeBNtSHK9DihCBFLZH19bSfM21q3nFqL11BRY5DRivjfR3aGP/80SZlgpTSabMC9KOcl47fNdppPiJlpibT2BJmzsoosrYj1Xu4PI5DIk+khgq3GkdQzbXzL+MLIE6jEt0uxGkxFAzkNmNvd92jLBzFYggjLa+YVFtrupOpdBHTqqDMQTFFYNJvcdI4kkvDeaDbYd1FprYW01HEtFRZ5MgV7Jmqfxgcd70+IVGOYyE4B4NB+3L7bcRyiOCMvMcdKDYnC6nI25iLvwbGJf3F7sY2HWY0uliBY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hz8M5qTFudXHRs/ULOE39YdZWOGfKBKNi+3wM0VWDs4=;
 b=g53QItl+HAmdr3CfomwQQWZvUYcpQvW46f8XPHoHZr80e1ApAASbVP8YhOepB4VhZSpyKhoAw02YCm/HnwUdGiv11VDWhpV0bGBtQ5JnXpz5NSvpzBqXAJ1V3O+6vbir0op7NEW1DaCNG6MpfjymCkcie67uRYoacsHrcmNvFVE=
Received: from SA1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:2d3::16)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 21 Aug
 2025 13:04:10 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::f) by SA1PR03CA0007.outlook.office365.com
 (2603:10b6:806:2d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:06 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:05 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Date: Thu, 21 Aug 2025 15:03:01 +0200
Message-ID: <20250821130354.125971-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 037bf804-cbcb-480d-861d-08dde0b33872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EoSUxZrfZMChpvOEhDi5rgE0CKyMce2JyoZutVet7s/Qymlb64wcSkGRng+F?=
 =?us-ascii?Q?kLZIB96mRbnR5cG86X5PhS/rkBIuPe1AUazleR8PZ1hKBAC2JqodvVKKpABW?=
 =?us-ascii?Q?o9SRtGD+zd0wD4n3x1R/fvSPl7hJ/7cP9K0YcdMYqaSR8qeUe8Uf6/ly5GoS?=
 =?us-ascii?Q?lnEAfOJ42LIOFS6YVlws/RLR0GgcoU9u0x0WZv4l3d3u6MxpeQIMvGyZLGnv?=
 =?us-ascii?Q?heCMk7aBqAPglj9ME5qGEUisBJREw7QyjOJJl2E/GLlQv6Qaa0Qk/y8im4m8?=
 =?us-ascii?Q?xZF3r0CZA8Flf1gy3bEAN6xIAcym564Bd8GuMB0+hbWhB3O6/ewi4ihhkVbd?=
 =?us-ascii?Q?CmL+U1iWMFNshF1KG2RCnb92JUnAg1gl/RX8AJ96Hb9/fLKcleI4Ti2zM8RA?=
 =?us-ascii?Q?oP0VN6eLzx0oJn8yUQJUtSBE1hn4B1OrPEg19PdFhwMnPCIPGTJ+6Cdne7vm?=
 =?us-ascii?Q?jZaa9xTu6a+XR/Cmfw8r+8tHfd1G42KJdahleXknKHiozSBBek7nQMndZjcY?=
 =?us-ascii?Q?7eqiGfIqvP+D0jxtlb0AM2dN1tpC9wz3+d/bZtend4G+4BZoP5GZr6BiA493?=
 =?us-ascii?Q?TEv/nVxTpHpUgHkbarB5Uv3qictqrlJaU4mZpPY1Ok7kQFJTpuO1E0C3yNhY?=
 =?us-ascii?Q?Z+cFZvnZiYjlhAAKqAsNMtSNdxV/B57VaSWlqrrng2LEIbfvh+YSb8ar3ay9?=
 =?us-ascii?Q?g8QYgHftI9dHmH70W11FkaMF8avOUgpQXXLs7LWhuuhSa1kEriCEQXCsbVdw?=
 =?us-ascii?Q?6tw5WSBIu7Xqb+ociDcNtrb1Le4OiXoDuLXQl0LB1jy1kPHzMu3AFtVBQcmv?=
 =?us-ascii?Q?hgXZ64inBjYHwpnTw6O5h8hgyrraZNLp1LP8lrvSjDBGCMpamM3vx+TsVxzq?=
 =?us-ascii?Q?u7bQf9dvndZgmythbWCuwfat07AGlpUQ7umCwdGB+6o6Qbph6NeEu7qs9nUv?=
 =?us-ascii?Q?Y0f+eTtORKTSZBJx3c9YyNK7ykVOXWGGfH41aJfxqqtWfnztiH6pZzQWF1IW?=
 =?us-ascii?Q?kgknEV8xNMX6zKk+i5p77KATxvt21h8ftgaExbTEbT90QCmJcOT9XXxVKkwb?=
 =?us-ascii?Q?dyt/dW/2rQBlMSweyGI+0CjHJdCZZEnFUKZjOw5Z7gKj/dBle44oZ5I1Rbke?=
 =?us-ascii?Q?Zgi/dkbsDERDmgrHPqzBE2I62Icsem6IehruWMGKoSCkigXuqLhvdpADUI6p?=
 =?us-ascii?Q?8+aH1Y6Y/CKKa4y7poSbefyGhbAhZf7QAsqnbRoW4QsN/+CVfPgIWMNasH9/?=
 =?us-ascii?Q?+v1AsKcLZHjBrZweHKdjkbfItlziVT+IGbTo7qMOUX49bkp/L2Vh7hhluqzd?=
 =?us-ascii?Q?lgayGTMeS6kpv5GrBEn10f2OrJP9oVMl5WLFKFUVCKSJfpDI/95qzRiDxORx?=
 =?us-ascii?Q?706vqV1VOZX+Dsz5AMlJN7P0OhMrxcEEl+LMEiffTdNIHwonHO2v9FQidx/8?=
 =?us-ascii?Q?oexG3sOAT+gNI8mIVnaodgUOf8NntGlauKWWRysV9/7+sEGV8sQDEdaDCiQk?=
 =?us-ascii?Q?pEQvrYay3Cno2LnfUUFPzbSEM0YeOqx4otAG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:10.6517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037bf804-cbcb-480d-861d-08dde0b33872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
Received-SPF: permerror client-ip=2a01:111:f403:2009::627;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


