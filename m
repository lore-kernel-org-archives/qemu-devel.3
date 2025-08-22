Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144E8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTVY-0007YE-3z; Fri, 22 Aug 2025 11:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVW-0007Xf-9X; Fri, 22 Aug 2025 11:16:46 -0400
Received: from mail-bn7nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2009::623]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTVP-00076c-P4; Fri, 22 Aug 2025 11:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1zOT1FlOYbSa9IfLImia7JcSBjsr/UsIXp3uxTK1JaJigD/k0ktJIVdIx/YNpq+Fm7ZlhopNeLBUynDJIMd2I6Kg0MFU7bF0QKVhi1vjuZPmmvNB/hKZ99ISZWW/ZbyZlUXBGidbXNRnLqFuS5NS4iBlYiZkHfROOlP8bFX0MwT8ChZIOOcn99Ly1hYbzG9r32cWM6kKhd+oWc7SDzupLU1Gnl0WtpcaKvbPBb513G0qvPXH3LabdRcr34h4nTjxVJTuROf5qNNA2k91SDZhfifexAh/GiQWhcI3bHcFAkQ1udlUEX7LggMHSIRW/qkkR5dQBNKAf6DNXCIkDa2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYvNBM/DwxwpoC4xaE9QNyZjkWBpI1oBvjKeVAQfV+s=;
 b=Rxogi9YpXawAOz6GtqN95w5livlDJISZ/WjGmK/cTni/YT75fgBerhRFTT1JglsNBG94k0ZdXL49+E13z4rjB2SvmylMTgbOTz1kOCH7CqmwWHev8h93DVqpojfEAh2+ILObwmdgPtMZiO+jpo3kFaZhN5pYPX5xb1/+lJmWFoMa6cLFZMnvl5liwCfYEGAcAo55D9Ui3zukwmykQB6K2F5j6RkOyFRcljiqFilqXBBKXeKFvW4NFxP0/owQOV0mEtip3qetdyrReHIeIzq3jFOiyoIxybRtHCIInZrKJyN7RxmcGriENZWBZwdWgKtQN9z5t7Cj02QqH0KqNXgq4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYvNBM/DwxwpoC4xaE9QNyZjkWBpI1oBvjKeVAQfV+s=;
 b=FizYg9fICafiTnoDA6Wb/+vsCVCTzcOXozbpIqxZTCJvwx4jro31Ek/0suOlEuifVwU8ckuuzFLXkTWwHSgv6VMCVu7PnHlj635WPDZFesrzYR5mpywVrSMucViXj2paqmajHDGXD5XV68jUimrueRSA7/h4o5XB9UEtuJuiGF0=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 15:16:29 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::2c) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 15:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:16:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:16:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 22 Aug
 2025 08:16:28 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:16:26 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Date: Fri, 22 Aug 2025 17:15:27 +0200
Message-ID: <20250822151614.187856-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: a09f568a-5008-4d9e-643d-08dde18ede9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eetCa+5tCNRTz+/8WIfI1kAWp0qfg16vZmxE2zSDXT9He/iC4ff9T/jq+A+R?=
 =?us-ascii?Q?6W7nwYlkehCSSPE/TmWrkUcl3iCiCv7vrWzCGTuORILTZnkjrMXqTEBUfgka?=
 =?us-ascii?Q?mEBOoc1NBemuZ6qcryUIW283oqaG8Evu9avNAZBUvxy4ria/attqKqgxlf15?=
 =?us-ascii?Q?k06JircO+7PCYO8ESJMhuhyCGsTb0I9jK2CnyrPQqULerOiCn2Ez/SXfEQ1n?=
 =?us-ascii?Q?pO54Wo2WpMn9+7X7z+yZ/M1qGp2ycIQUOw9/dFY9u8vYUfr8LhErLNRpl1tc?=
 =?us-ascii?Q?Zgm4Q6Qn11i3YSA+TqmNppiriHL3xEsftMdTVE5VQjEWp0kDjyvA1WpxvYTp?=
 =?us-ascii?Q?XyWo3CBUewb1io2zl7IxSFLvmYCJ1szVfUyc328K35tUoaC/XaLXcbzYZwGW?=
 =?us-ascii?Q?Im2LqMv5QV8aZ+0mkE4cAUap6vNzuVqk0SofMxMMFd6VV+S9cqmRmIPYAsal?=
 =?us-ascii?Q?T2VbiE8+VZdlzB6/Mgoe3YEZV6riQA8ih5FDgTHinsaZlVDf+hBScxGUJkvR?=
 =?us-ascii?Q?sOvOB8IQX05sI6jloBhRnxdgebLeFqMXHMXLfgfwlN2kBpxv6H1bfvvCcn1p?=
 =?us-ascii?Q?NeuXnDk1+EL1izjhgZHj8VxTGKJf5ke+0JGpd/4pY1hhOgnZxBNIGPIkYlzt?=
 =?us-ascii?Q?5Fv4KtjfhRYbxLvkBQCFeuOVSRjhm8PHDAQNeKEYhevzRwEO13pWOplQR90m?=
 =?us-ascii?Q?aSUWxEQk1MHHFgPrmdEdBh4cDpMZ1mlumG7UJOBIfTjTN/7Y0W+4yQ62Bt7U?=
 =?us-ascii?Q?FTlYwWIzT09nx6buJy2m9RAQEUEqzCLJ9T71GdLz4vDhE65cvqH4W/Yb82aQ?=
 =?us-ascii?Q?1cap0u2aFb/3Hk4hn87dYW9wdu6/NB6sP4VwLAk2LFxN2CaYfD/YUoErNdb1?=
 =?us-ascii?Q?ra4AtWb3Q5Bqm3atZKgnjyAeFJDvc5Tl6f2QxLg6bOnFVFQEodj2OTRLHrPr?=
 =?us-ascii?Q?uxPRWsHPJ6AuzSW/wxgRDlG1JSshnz1/vy88YhFOgFFBKdgqY/ZRXRBJ2tjC?=
 =?us-ascii?Q?mASNPesfVFFUpanyDYIuajZUvWmKySZj1BtKQU4a6caEN9hZL5IGY4cPe3vA?=
 =?us-ascii?Q?IjOsxugTfqFZni4sf1hxldqjx64wDr4BVRW3M1iFK4fSTJUQVaOrESJ3bwpX?=
 =?us-ascii?Q?wL8pOroHKdnwg80E4+1EH2m0i+WMOoE2nrlJKK+Jt02kmTmHIsrfvoy7evmd?=
 =?us-ascii?Q?nmLAy3Whj3CeEEw2Bue4WNoCX0Wp3eGl+SfYwe2z/5WbNMnH2C3h+j33i16G?=
 =?us-ascii?Q?xJqBlNoALw2CeDXCzc1F74h+Ms67kLCkULbSneg+yQNyPuGMYPSi+4XCTVwW?=
 =?us-ascii?Q?wTBlWHnkx14qGZms+KJBqlBjUexynqw49O47a5yyN/w00EpivvhL1IDaQFwN?=
 =?us-ascii?Q?XM9qLP3e/1ocIUxNBx9Dxhwk6c6UsW8zbY6BLsTZN1+L//9q0Xz5kKkEXBiX?=
 =?us-ascii?Q?NvDpSrQxPJYXiQIljtX6EQ2Y8kbI9iF+abkEnn7/W0fQbJEjkvI98pv8zcIw?=
 =?us-ascii?Q?nr7ddI+GqesLuJfHZ/6ogN2csASCPOjCd0VU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:16:29.2130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a09f568a-5008-4d9e-643d-08dde18ede9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
Received-SPF: permerror client-ip=2a01:111:f403:2009::623;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 hw/arm/xlnx-versal-virt.c    |  9 ++++++---
 hw/arm/xlnx-versal.c         | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

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
index adadbb72902..d1c65afa2ac 100644
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
@@ -695,14 +696,16 @@ static void versal_virt_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus0", OBJECT(s->canbus[0]),
                              &error_abort);
     object_property_set_link(OBJECT(&s->soc), "canbus1", OBJECT(s->canbus[1]),
                              &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
+    versal_set_fdt(&s->soc, s->fdt);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
+
     fdt_add_gem_nodes(s);
     fdt_add_uart_nodes(s);
     fdt_add_canfd_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
@@ -712,12 +715,12 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
-    fdt_add_clk_node(s, "/clk125", 125000000, s->phandle.clk_125Mhz);
-    fdt_add_clk_node(s, "/clk25", 25000000, s->phandle.clk_25Mhz);
+    fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
+    fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
 
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of multiple address-spaces.  */
     memory_region_add_subregion_overlap(get_system_memory(),
                                         0, &s->soc.fpd.apu.mr, 0);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 4da656318f6..fda8fdf786a 100644
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
 
@@ -917,15 +919,41 @@ static void versal_unimp(Versal *s)
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
 
+    if (s->cfg.fdt == NULL) {
+        int fdt_size;
+
+        s->cfg.fdt = create_device_tree(&fdt_size);
+    }
+
+    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
+    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
+
     versal_create_apu_cpus(s);
     versal_create_apu_gic(s, pic);
     versal_create_rpu_cpus(s);
     versal_create_uarts(s, pic);
     versal_create_canfds(s, pic);
-- 
2.50.1


