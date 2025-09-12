Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0CCCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0bD-0004xA-D4; Fri, 12 Sep 2025 06:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0b3-0004vF-Cf; Fri, 12 Sep 2025 06:01:37 -0400
Received: from mail-bn1nam02on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2407::60f]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0at-000113-6U; Fri, 12 Sep 2025 06:01:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x04I6+Ubr7tM9RulqwQHGuRnzbcx7S92xguN0Vp5oRs4dh2hu5QFSd9K7hb9GttexfLuwMjephgWaCdcwlZs/h+4b1LjIN1gK/RGf1LJG+ml+JnY8V09J2iGJvwmL+kOTxrTR8H7ElwlUcK19ThUlWaL5ctwphrY3LKJgs4JbyIGcqpC03MejIfAcFqhlpd7jyqwnK+dzXp6oX3wVBYYy2XfiuAjqkPjioYt+DC8vIgADgZFA+XW5iib0NM5H432jMo6D5F3irP7U5DgGLGpYUDtCwTQ/cO0HIiA19ahvhxMCBqWtl5JGh80mw6tGZPnG84u7Mqph2tC13nFlSEWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYvNBM/DwxwpoC4xaE9QNyZjkWBpI1oBvjKeVAQfV+s=;
 b=uErhdBFrgPrZTVbxQVr60jIJ9ScngD6oAqPOXcF9pswbOdrkuUbnqNnGP+PYm/yyad64AdI5oebf4LNXcMgIdSZ1WNkI8c7UmY5q0r9EPBGjAlNWJmemABG/vdsm6Oy4rFJ4jt1j4hWEsFy0UFMX4OlHrolELefYf97Jpaz/9bMQzpZBCP+/xXnfJwPBVHRkk7pz60WtWX/VyZq+uW4NKNQqtX/Vqt/hLf+Kv8WtLWb1DT0Gms9z2pKDV/6UUO2btjOuVopAT4bBnL1TijZSpJhGYubg4n8TCnFSnNBBZAhEo66Q46vQtLSzsm6vjG8zVRO4Bjs0WmF9czV0ADjW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYvNBM/DwxwpoC4xaE9QNyZjkWBpI1oBvjKeVAQfV+s=;
 b=qRsVYMikDw3V98HhdDIxKCgEzAUJA0jA2xKz9cO/BVb2Z1D+evBQcqmAqBMib3gLmpf4bBfgC6HfuHjj8tKMRFAIurp/+dI+A8cbsJCtc4Gn3fDodIypERlcDc2eokL4nO4C/Qw1ADZe+BS6FvB5Ocd0urruefxACoP7GKcRwdc=
Received: from DM6PR02CA0123.namprd02.prod.outlook.com (2603:10b6:5:1b4::25)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 10:01:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::87) by DM6PR02CA0123.outlook.office365.com
 (2603:10b6:5:1b4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:01:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:18 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:17 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:16 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Date: Fri, 12 Sep 2025 12:00:11 +0200
Message-ID: <20250912100059.103997-3-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: f2719e88-961b-4f58-9e57-08ddf1e35181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kyhxAqZY1scY6/HQTP8kvvEoxv+P9ycWw28pkp629lv5b8h7Osa4+K9Hd/mk?=
 =?us-ascii?Q?h6TFYI38vAwhyFrH/tbuLRmuDjqTI0AoDVjR8stKgWbYpzEcXLO3LnVMKIPe?=
 =?us-ascii?Q?6sRiTwIk1odr9o4wJT5X20Itf4gzF80ChlhTrjIywqT5/TmiGbCkabYGjpIs?=
 =?us-ascii?Q?PnejYrJXcv3eJxdPlDMbUZo766qF2DuRSOhwnOXUSL2LxcyEagov0UHJWX6t?=
 =?us-ascii?Q?LEXW9/N/EuCnBpOiujrGgMvigcesYaMJ2Mn4Gn2EOedon8Flq81loIfZeJCa?=
 =?us-ascii?Q?/y/hwqSuFW9D3O4Oq4EeO66lsFORvLZPPWeeXBOos6xRal3Ihpph+dHrHklL?=
 =?us-ascii?Q?x1y78rDOpGN0TWJuBMI026LojhAOfkOrrajIZI6KGLPJAR04Yl3TkpfEY81H?=
 =?us-ascii?Q?P2yuGPraYEx0t9sICjLRrpH3ZkgwUPFBuwRKjJpQ3hEETzumaEANN8Zt3IgL?=
 =?us-ascii?Q?RrUBANaZdAbGwL45QehznjC52Vt9hyL3/m2FC9bsljc/20iTotagi1Cygw+g?=
 =?us-ascii?Q?plo2gubwsfURXXAWWb2YNGpWUtKRzNCFuU9gP+bNI8ejLplLX4SgjtZmHdrj?=
 =?us-ascii?Q?IKJDe3pz4bZdGP3NQ7hjK/u/UiQ7Gy/cUhq/6PToFGVHCuEF2c6mQFFyn9o1?=
 =?us-ascii?Q?lPWMBbWROgarHlG5PZShdJd6TzjpNRj5eJDvRkq2xIPGMtINuTJ2i3CrMNfQ?=
 =?us-ascii?Q?6l6RkA7fxpCcMUi/IJLxjkYXtxjXbszJbhL6CekI+th1i8hYwrEsGqm3NWy4?=
 =?us-ascii?Q?NREStgW6pb5k0U8xFhUEld+AsTIq8u6KdtEE0aTmTq0RnJnLhY5PEaO5IBvB?=
 =?us-ascii?Q?K2pQnPsrDNsUW8XX0miAm2zw+aOzNEhworJWJ8iX2ViZe1WydCzuGyyG1p3z?=
 =?us-ascii?Q?ZRrER1YQaJrr1x1dEV9/mcJtTf2WUFLQIKoCM2Fg8hK1tQ9QrFiD+FcfRW7m?=
 =?us-ascii?Q?OF4FfP3N63UJonnRgEYddaDZlNt5VhuTlBkk2VDEYsH9sUR72kkQ1QCNk1tG?=
 =?us-ascii?Q?yJ0zXHzG6SaIoNxvLLRljRLMyUyKiP0uuFsW2VEVb/1RHMsSKPqQZyGwREiJ?=
 =?us-ascii?Q?kMU4BbHolECBIbd1obZHTeZACsFoDuMvWZKdrUPh9aZlCtpAhScNs1Xme0VG?=
 =?us-ascii?Q?bhDMQ6/Ogm1joV/OnyUhpv4pGm4obdOp3UoiQAnolJQbklMewHMGYzLmn87U?=
 =?us-ascii?Q?a13YhmCEGjE1l7P0n2m03uBXRAENlz71E9sERLHeC8CBsAWdW3yfZsib2Jvm?=
 =?us-ascii?Q?JyFNqagEmc+Yys10YBEh2wS2H5dIrpyVp7z/Wbizvm+dqkET97nXK88Ocu0z?=
 =?us-ascii?Q?j8Nh9Q+l7h1+M8a9y3DyqSjjK4qB17EaYvXQkru/jNQ8suSwsuHfilRtcC2e?=
 =?us-ascii?Q?YTalmHAkinT13uiKcMaHpi9sT+Zf7cpc/585VR/tsnZsAfQUKSz1sDVkFbih?=
 =?us-ascii?Q?ubzBOZ9SdD6ziQsOEjg1/+jn3c9oiuLeL0aNCa2hoHML81LCBfvlCnUnYKho?=
 =?us-ascii?Q?DSBcvx6oY6kK02bEZvFqL5C+kmSpKve6ICTZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:01:18.2996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2719e88-961b-4f58-9e57-08ddf1e35181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957
Received-SPF: permerror client-ip=2a01:111:f403:2407::60f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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


