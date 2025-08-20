Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA184CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9X-0004E4-DV; Wed, 20 Aug 2025 04:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9V-0004Cj-AM; Wed, 20 Aug 2025 04:26:37 -0400
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2417::619]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9S-0000sQ-MF; Wed, 20 Aug 2025 04:26:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgWAaKTsK30/2hNVoQqkPjeikAl/4/nf+kOJpTIaE13SDPkxriA9n2U3l/Tbpi4TuirlG340U66p5RW/7eJo+QXcJmcSp+D/pM5QQuS5vQ9DLc7dozzfy96D+L+eJ7bnF31qca4bMfJTf2DLeBZdIntjSGai4bjh3Enk63qTVNEQNbUj1y1nXDmyj7fwRmG4cPQPKspNCtrJ14auinLcGN4QGkL+Z3ta7AMU2EGcuYHVXEAr8Py3vxiA3pZQz+NWjdntp6uzHgQuLfxE/q+5rTz7YhnkM4r8lJr42Z5l1C78Oekp8KGAG6lZhvrAuc0gvP8Zv6fB7CDiXh5cdhoscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rie5PpwZZWcwGk/BsXnhbEkGUFaPZSqiAsg5BRRJtJQ=;
 b=si4zvxV4cq8wab6hK4xY9jBL6EaLtyaUWXsEwJKjlMW+LEFmgI80IYsPfA/TAV4Scc37L8yd/17uma60kB60SajRttuNUP2ZRyb4mnu5gljELg9YGNPi7Y5Uu6CHEIIvhxo/KQb6lfG7ZI1l+FxOCEG+gERBbLRUoepp8V4rXE61zAkdcfV+VE7viEiTYffD7k/egdfa00LuLuPc06O/3rUTn5zVNWyCQDIiInRoCXmLOMpiWrnP2n8G/eWzAT7eOSgnrKLtfilvqy3O+Fgy8vJinpQvzKwkeadwou6a35zjUBOPqN+fTVfBQS0GZAISG94Ud4+c5ab1o0XaoiqDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rie5PpwZZWcwGk/BsXnhbEkGUFaPZSqiAsg5BRRJtJQ=;
 b=Ry/ybLi8ik6AFNVk6BQ6CAJdkIyyYZ/vRwUxIEGr91eKLA85qgJxuaahTOJ44x9L06LObN87l07+Nr/0dHfLPmFz9NvnBQBKs/I9l6WWEZw1M7rJWT04c+xsXtKkNmnfkpi08D+E7gOwd8lc8VpY+Nbex/MMU3PY5O2zVY3Na9E=
Received: from MW4PR04CA0340.namprd04.prod.outlook.com (2603:10b6:303:8a::15)
 by IA0PPF002462CFE.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.35; Wed, 20 Aug
 2025 08:26:24 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::cb) by MW4PR04CA0340.outlook.office365.com
 (2603:10b6:303:8a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:26:22 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:20 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 07/47] hw/arm/xlnx-versal: adma: refactor creation
Date: Wed, 20 Aug 2025 10:25:06 +0200
Message-ID: <20250820082549.69724-8-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6dab45-623a-4947-7851-08dddfc33fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yIUpJhSelhqHFVSQZ1JzLe/FvdeGhIUJiJ78IkWDk+yYjvSCYQhoq/VSsMrj?=
 =?us-ascii?Q?RMfEhJxYqA0DoLm0wRvPxhCbdpuMLC1dssFrii9fz8hh17cLunaCTvfVc8Rs?=
 =?us-ascii?Q?/nEX+v4TJPQDbnhUU8wCmTHK3zjjmhjDWo3HCDXog6qVBwNkVb6XPOSM5hzT?=
 =?us-ascii?Q?rwJnJhoJ4Oa9ljTvcBpiGq7Y3dakVBSPa9Hmtsk2zXSd4hwKtyVJ2W1A5T00?=
 =?us-ascii?Q?INNmDtssQ7e5CfAFsVsoShYQrCaHI+1nRE2Wo+TJA5gnPIoa2H7kDUWIvdyn?=
 =?us-ascii?Q?hPkbvKmmX6fYCe5unnLK1eUhuXSkCK+/9umB0jR8WaFy1g5/uUqc00vugEK5?=
 =?us-ascii?Q?1fRKIPJY/BfCwihIAk3wpUwe8yKeYdLnRGwLDuarcFQxEu8VlFjxg+N4d0FO?=
 =?us-ascii?Q?agt1hbPlgk6b6g5Pm25wUAVjsOBugdmufME4N5WXNd2A5+CsXtu7lXb4ZNA7?=
 =?us-ascii?Q?KKTnRTuVtoT4jm68cfUEmrWDM/j5+nS6QYUpn04MZpsQnvZXYcNFhe2DVSxz?=
 =?us-ascii?Q?IpU4GKPR8A78FidtDkFTy8U96iEUTG8rgaVgsHzWc/dEx0cfM2q63QC2A2YB?=
 =?us-ascii?Q?ZebpaKXFRYsWT/KW1vRaK8Fu/D7RLQpAwHVY4EBX+U5XlT5QsF9xqWXIdQgC?=
 =?us-ascii?Q?HHsTCJdZyusK5s3WTzSQE90x4oZcDt9qotp2LU46/KLIqZx65Jlg1jYZFXpT?=
 =?us-ascii?Q?Qu43CguE7+PIGA5EbAjlu/jikoBZA3hyn73xDpWbVD4GvKoIDcXdHR4tbqn5?=
 =?us-ascii?Q?j+I3dSqHgAjFKsAUfuiuAfg3pRr+4roVNoGRzMD89YtOp2CjwnUj/FJJ0QcR?=
 =?us-ascii?Q?w6Bvkd9B0S9NGihUgdwM6vzPVuNTr9EotjLdmtVnXaooJexeFhkjf6Uq+WKE?=
 =?us-ascii?Q?e1cd4FliN6io3xMdbxjOP6I01LyzEeXJZ7/ektNhM6+Uq/ZSIcUpAC2GHSVA?=
 =?us-ascii?Q?7Y51v5Y3/XZ4c8Xj5AKrrxRe6HP3y1F8S/j1Zb0uAyhpqkAgbg+6fKfkl8Ig?=
 =?us-ascii?Q?Yf7t3qo3RhC67A7oseEHJY7Yhx1WVu6XK9eXCADJ8KMQhAvpmKwcefqwKgjx?=
 =?us-ascii?Q?1n+/Ez1EfPArPnCYjZZefChAhbANNntk8Yfmwev5DO+pkzH+MOL9PbwTbOvs?=
 =?us-ascii?Q?VRoiNcTYoNZajYNskkXB/6XKck+NRSrr1H2frcgwd9eqeYo2tbEsMaVX/ELw?=
 =?us-ascii?Q?emTovzQjIXpmx48/hZLyXoXffxRh4XRqxJfvEyyk05vabHNItxdmdMtL80gn?=
 =?us-ascii?Q?2KE/+L4xFzh4TevrUwDKjbxN/LL8cjNVcOBEYfZw8xZf16MKu7uaeAMZ7kRD?=
 =?us-ascii?Q?vRyrrcw+Op4E+ZkwBWPz363pqvCKbutdjefbIQ22rT1iA/eddw/tsEl8YZ+t?=
 =?us-ascii?Q?22QesZGW/dsCiQWMOTCNbksyhxaaQJK33NODLVERrtczP8wk+HXVnOn4DFR7?=
 =?us-ascii?Q?L8jlaxrs7iuC+8dvmZb5Qh0swYUjFdO4gqSost9iHeyQpnDSiohKTzsBdzu6?=
 =?us-ascii?Q?GbxCVUhEgtnotsM6naGWoWeDfffMhoB4JvM+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:23.4677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6dab45-623a-4947-7851-08dddfc33fa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE
Received-SPF: permerror client-ip=2a01:111:f403:2417::619;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

Refactor the ADMA creation using the VersalMap structure.

Note that the connection to the CRL is removed for now and will be
re-added by next commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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
index fa2d875f0ae..f0fb5694b94 100644
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
@@ -556,11 +529,10 @@ static void versal_virt_init(MachineState *machine)
 
     fdt_create(s);
     versal_set_fdt(&s->soc, s->fdt);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
-    fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 062f9a91a6c..97cd991be10 100644
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
@@ -484,34 +498,49 @@ static void versal_create_gem(Versal *s,
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
@@ -970,18 +999,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
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
@@ -1161,12 +1182,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_gem; i++) {
         versal_create_gem(s, &map->gem[i]);
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
2.50.1


