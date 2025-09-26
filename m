Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B039CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22dY-0002vu-Nf; Fri, 26 Sep 2025 03:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22bR-0008Hj-1l; Fri, 26 Sep 2025 03:10:57 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22bC-000778-OY; Fri, 26 Sep 2025 03:10:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpgp9cWdWfu970R5tNdfT+lupS9/R/j8litHCK0rBn1/S/rSJj/zzv/e+VgQ3S1SZLHw1umnNmKe+WnBKb7VBC7rDHMx4sxDfbbiJ34LBIXYEOb1illX+Hy9Y81ffaORxQHVl66Aucz0vCk/qRGgYEBZ1RgOb39tbXFWKvxr6nXi3mib7cq8WiqkuqH1NEWuRQ7oJPhDivYcDOmtJjwKe5thNfB6pD8Mot/TkUZpT12vizIFhpKM94JIgmT0aagtQ0JEOJkUBwl35NYbzV41Fp9Skz5LYo/tTQpF4IteIHSERasHqXuk/ktbaA+yEmp6YbyTyLApRqdo5M96p4p55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVNbeUiqaBDweXX4Hnwf8PPGWUUwwdbU6FHtaadlF7g=;
 b=JcQ3H/gc/glb3gw15h0APfz2FQzfWrR1c51gCgbBR441wOetUHauBtzc9i/3mubQpGnY76RslsN3+hvFXqX2hj6ZrMLSScR3p+yqvwNz9+OJiQ2tqTPDBth+i1rHEIhWy9PUNb60J3ET6FbZMcTULsQst+lMldtqwjV0IfgKDlqXCAJRC9TJZj9/IkW8W2iMTCr6ganowuY9PEVDBmBIYKb3vmEz/gkPvstCv+zmQg4AfM+5fv3O9h3mcsm1QR8DnCpiu76ZWQwsVp0Oy2g4sSbzlGFARcs5M0FgUDZBodQp4tMwwWAnB0MalU5S5kALICGDqS974bw+iIB8WN3A4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVNbeUiqaBDweXX4Hnwf8PPGWUUwwdbU6FHtaadlF7g=;
 b=uvcOFUU17hD2GZXeRRYqVywGqxEvBDXGOt129dBsmsUdwIah9kGaPDIWH7hHkUHxKnclvE4tlccFhQKLaFbiDctFKvUtX0ko5m4l6MyIIDiZ7095/tUTQAixgRtIb2L4ciyEpYwAqCuHUSPHI4yp9ulYOHKRYBSlMveR4BYP8zY=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 07:08:37 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::82) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:26 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:25 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:24 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 07/47] hw/arm/xlnx-versal: adma: refactor creation
Date: Fri, 26 Sep 2025 09:07:25 +0200
Message-ID: <20250926070806.292065-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: de5f7af5-226f-4a59-845b-08ddfccb839a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yxWQwUTCu3M7m/wDVgxTT1qkbymQqP2E2rVZfdZGb9HTsun+98m/qqcqAAcU?=
 =?us-ascii?Q?UiokJedAwKlvLzC2NEE/Lt3Hi5zNeJUuEytyeGwfJuINQwrIk4FcCUsdx9P5?=
 =?us-ascii?Q?V2N0GAiDCUD9VjvHTLpzLM1JWmjjRq2gwWbqq0mjbQ2PYBjLKiuMbXH/nSj3?=
 =?us-ascii?Q?FO0Va26gbPPzyvfeHLQLGzJEyHTr+YDKXQg/idOXbNEkTVrMfW7JO8RiWsOs?=
 =?us-ascii?Q?RKMMzTgL62F1h3A1S4a0xuC9o1LVY3blu9DiADgUvPQCkSVY4WrmvJRfRgVH?=
 =?us-ascii?Q?o2MAmkMzY/5aDpJeqql3Uu6iwuBaK5yzwGMWsB8lwdJVROuB5Mn59IUKGRDS?=
 =?us-ascii?Q?ESEMsQSVTtTtkTw/dm8kaDsKFmtR2O7ixCdHBjYTKoBBdAd2OxFHz60cPzaw?=
 =?us-ascii?Q?Ulq+uEQoU9FfD1PmZMQVQKYu3M7dsiSSs/SxCiK8ri6qzCvHmKSjRIoY5zKz?=
 =?us-ascii?Q?GEH76/AkRwPzISeu3YGgVSm/5OM9KdH+kLsFvbeQHi4UB4fW++fghhZAF7h+?=
 =?us-ascii?Q?s+ZZ6hpPLQZQ7VwezFAMdU56vJCHlK7jceFKhvYmukiB+sKUU0kuysxfcLT/?=
 =?us-ascii?Q?3eBMpUzbq4e1bSQG57IYLjizXUEr1Z5hSRGKpd0UAFa4SvnUpx/6Dn+FPdho?=
 =?us-ascii?Q?iOCQGDK4YS90hzsBPN1TSPeVsvvget54Di9FCenXQy3BBLlCxviOu7pE8xGx?=
 =?us-ascii?Q?e9sKNQfFc/stMCbd0c+fHS1ITLGBx++qIx5Pcr9DLK8ApFVuMHFA3+Zje/Su?=
 =?us-ascii?Q?lSsQa60BspA7zUBrI31ChTZKZ7RdJTDMnUka3izNs3mAuw5L85kAtM2aqFt6?=
 =?us-ascii?Q?gsA5NC2KDI1j0pm8TNAhilRlH4tiO9SD1VLO8Jgpm2VI/TJmE5INO1XoNt1f?=
 =?us-ascii?Q?KbQAr2kRvVZFmdCC/pzC7OBqM8/ThetrdzDc9suKWKOQaVgMLbNKuiq1mZWd?=
 =?us-ascii?Q?XlhGstQtBCvTgK+z8b1VWeuYEnE3iWBMb77BSXPzM2KsjjOwn95Cskz001DM?=
 =?us-ascii?Q?WCt47B2QvtDhhW3w7IL/1t93gR939t38FJ3ITie/aplQLI3EPsi5PExVp54A?=
 =?us-ascii?Q?+/6ad8s8TYdIDLbdNGKNtTxQDMAgw3HZ17BKN/W0FK72PgdlxecZGeBYhnBW?=
 =?us-ascii?Q?y+CcIu64diUT8H6lgJumuBCUVKsQyJeGKnnqWvLJJrlb37BJ4QtzxzCPKK04?=
 =?us-ascii?Q?Qaw6Om1UvSnpbDOMpfe/B+Z/Uw+7YP1WLoseJzcUe/vWMCj+P9/Vgb606uVL?=
 =?us-ascii?Q?Y8HPPx3gX3OUpmo4vIRt3H53YMncqdS/phcI1NUnHjVSMgF6HU2jUjrE9MqW?=
 =?us-ascii?Q?o4yB19avZn4CNXiHxjkgUh8aHjQmJWugJNrFrWNX7LMR0bJ3W6m2JQRgRukY?=
 =?us-ascii?Q?Gc3EyuziNp2xm/xGQ1wV4O5fwbmSbWaypzLiYhHs3PluXtDU8kHdDKkJwEEH?=
 =?us-ascii?Q?MEAICthLy8cZbJGewwPOus6ioqM7NfHnFwQ/FiVk1G73ylYWtGoa5Zon9pY+?=
 =?us-ascii?Q?YVUrAJg+qqNeh7jUP4TvSHF9uCuDaPzJrKt6nk//ghe+TkB1/ISPJ8Mu/Jpe?=
 =?us-ascii?Q?BbREtSr2yuiImSPZadE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:37.2172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de5f7af5-226f-4a59-845b-08ddfccb839a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Luc.Michel@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Refactor the ADMA creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  2 -
 hw/arm/xlnx-versal-virt.c    | 28 --------------
 hw/arm/xlnx-versal.c         | 72 ++++++++++++++++++++++++------------
 3 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 1fcc2b623da..4eeea98ff34 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -15,11 +15,10 @@
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
 #include "hw/intc/arm_gicv3.h"
-#include "hw/dma/xlnx-zdma.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
 #include "hw/usb/xlnx-usb-subsystem.h"
 #include "hw/misc/xlnx-versal-xramc.h"
 #include "hw/nvram/xlnx-bbram.h"
@@ -75,11 +74,10 @@ struct Versal {
 
     struct {
         MemoryRegion mr_ocm;
 
         struct {
-            XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
             VersalUsb2 usb;
         } iou;
 
         /* Real-time Processing Unit.  */
         struct {
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0634cc90eac..418e4c6e983 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -202,37 +202,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
     qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
     qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
     g_free(name);
 }
 
-static void fdt_add_zdma_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_main\0clk_apb";
-    const char compat[] = "xlnx,zynqmp-dma-1.0";
-    int i;
-
-    for (i = XLNX_VERSAL_NR_ADMAS - 1; i >= 0; i--) {
-        uint64_t addr = MM_ADMA_CH0 + MM_ADMA_CH0_SIZE * i;
-        char *name = g_strdup_printf("/dma@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cell(s->fdt, name, "xlnx,bus-width", 64);
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_ADMA_IRQ_0 + i,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, 0x1000);
-        qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
-        g_free(name);
-    }
-}
-
 static void fdt_add_rtc_node(VersalVirt *s)
 {
     const char compat[] = "xlnx,zynqmp-rtc";
     const char interrupt_names[] = "alarm\0sec";
     char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
@@ -559,11 +532,10 @@ static void versal_virt_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
     create_virtio_regions(s);
 
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 7c53bc82a20..5c2bd4be1f7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -28,10 +28,11 @@
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/sd/sdhci.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/dma/xlnx-zdma.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -58,10 +59,20 @@ typedef struct VersalMap {
         size_t num_prio_queue;
         const char *phy_mode;
         const uint32_t speed;
     } gem[3];
     size_t num_gem;
+
+    struct VersalZDMAMap {
+        const char *name;
+        VersalSimplePeriphMap map;
+        size_t num_chan;
+        uint64_t chan_stride;
+        int irq_stride;
+    } zdma[2];
+    size_t num_zdma;
+
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -76,10 +87,13 @@ static const VersalMap VERSAL_MAP = {
     .num_sdhci = 2,
 
     .gem[0] = { { 0xff0c0000, 56 }, 2, "rgmii-id", 1000 },
     .gem[1] = { { 0xff0d0000, 58 }, 2, "rgmii-id", 1000 },
     .num_gem = 2,
+
+    .zdma[0] = { "adma", { 0xffa80000, 60 }, 8, 0x10000, 1 },
+    .num_zdma = 1,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -490,34 +504,49 @@ static void versal_create_gem_fdt(Versal *s,
     }
     qemu_fdt_setprop(s->cfg.fdt, node, "interrupts", irq_prop,
                      sizeof(uint32_t) * map->num_prio_queue * 3);
 }
 
-
-static void versal_create_admas(Versal *s, qemu_irq *pic)
+static void versal_create_zdma(Versal *s,
+                               const struct VersalZDMAMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *name;
+    const char compatible[] = "xlnx,zynqmp-dma-1.0";
+    const char clocknames[] = "clk_main\0clk_apb";
+    size_t i;
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        char *name = g_strdup_printf("adma%d", i);
-        DeviceState *dev;
-        MemoryRegion *mr;
+    name = g_strdup_printf("%s[*]", map->name);
 
-        object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
-                                TYPE_XLNX_ZDMA);
-        dev = DEVICE(&s->lpd.iou.adma[i]);
+    for (i = 0; i < map->num_chan; i++) {
+        uint64_t addr = map->map.addr + map->chan_stride * i;
+        int irq = map->map.irq + map->irq_stride * i;
+        g_autofree char *node;
+
+        dev = qdev_new(TYPE_XLNX_ZDMA);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         object_property_set_link(OBJECT(dev), "dma",
                                  OBJECT(get_system_memory()), &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE, mr);
+        memory_region_add_subregion(&s->mr_ps, addr, mr);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[VERSAL_ADMA_IRQ_0 + i]);
-        g_free(name);
+        versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, irq);
+
+        node = versal_fdt_add_simple_subnode(s, "/dma", addr, 0x1000,
+                                             compatible, sizeof(compatible));
+        qemu_fdt_setprop_cell(s->cfg.fdt, node, "xlnx,bus-width", 64);
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                               s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+        qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                         clocknames, sizeof(clocknames));
+        qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, irq,
+                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
     }
 }
 
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
 static void versal_create_sdhci(Versal *s,
@@ -976,18 +1005,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
         object_property_set_link(OBJECT(&s->lpd.crl),
                                  name, OBJECT(&s->lpd.rpu.cpu[i]),
                                  &error_abort);
     }
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
-        g_autofree gchar *name = g_strdup_printf("adma[%d]", i);
-
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.iou.adma[i]),
-                                 &error_abort);
-    }
-
     object_property_set_link(OBJECT(&s->lpd.crl),
                              "usb", OBJECT(&s->lpd.iou.usb),
                              &error_abort);
 
     sysbus_realize(sbd, &error_fatal);
@@ -1169,12 +1190,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
          * interface naming order when persistent naming scheme is not in use.
          */
         versal_create_gem_fdt(s, &map->gem[map->num_gem - 1 - i]);
     }
 
+    for (i = 0; i < map->num_zdma; i++) {
+        versal_create_zdma(s, &map->zdma[i]);
+    }
+
     versal_create_usbs(s, pic);
-    versal_create_admas(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
-- 
2.51.0


