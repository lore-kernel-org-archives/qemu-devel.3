Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBB2C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyrI-0001F4-FJ; Wed, 16 Jul 2025 05:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrG-0001D0-V2; Wed, 16 Jul 2025 05:55:26 -0400
Received: from mail-bn8nam12on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2418::603]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrE-0006XX-EI; Wed, 16 Jul 2025 05:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vvzxbh7c7EYrundxFTop8HhqFUJsDGHsjnwJXwrFx8McfhdALYA3ee8sJxwUGNOPuL5AVkPTbrJlStZ530hqn6qeECIV8PT0fat6ADrXgrYJmNatnpkWqV4hmluKdMwO/GWaV47U/bxNzUnGfRHV5XGWCl0FbSHODtS7C8a5f7eTATgSIvidGOQI//s9kuYRFO5rk+eAtvIDT2lEXPUEm5eSzhy9OkHEjh20LZ/uPAYOvTM1n1XSHGr6jkkQGacTKSKiFZP7a9ZOoOIf1qSxcx82gv7Q8QhCKwO8Xr5NpN/7gUxIG4VeqnJl3eNSkjOePg+UVJ6gUDeOUTkWFlM7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzrODNfxj6+MOaVfI8DX1RGuLynE3qq0FTxM5kscqFU=;
 b=C3+H9RJymQZ/JyL3S1oYUQEKYnLqKSFloFo8FEln5O1p5GUp47mXpwhR2sunK4C+BG4UuZ5IX5t6KsdLKDruDrQWj8Ju5dI5DKyWOx6UFKxqRE4yvb+NRyOiIbok+jwaYYSjAHxOra6G/Cz/jYp8sZCqQ7oj0vfT00X9TgOCfEA9DpXb2YabgPzZ5+hWzcTuz0lqWW+c5fjxrDR8fw+taDKYVYdpeFYqy4hkXdcjlu+1nl4hp9/JDIGuzKweOOY+X/8RXSyOhC6dw0c5liRaCav74N+qIFjSRqZ3XejdLnCxG1/b12BrPsCo7Cn1bV9xMR6j7uuJviJ1eGROG9H6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzrODNfxj6+MOaVfI8DX1RGuLynE3qq0FTxM5kscqFU=;
 b=VwPIvgxNrmnXIGcrQZ6iZpPLo1nG8KpU+7YT/Nn+f22Da7EC+LJNu0ItMvkaDu60KesrGML5TEh4R7sMocKrrDMQLCBqPK9rD4NZCv8t/RgKmjhSytSOe7S8tj+TWafkAqsN+1UsDXi6cZT/ce6a719/vDAJqGOJ3arARCdNbBQ=
Received: from MW2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:907::39) by
 DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.27; Wed, 16 Jul 2025 09:55:16 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::ac) by MW2PR16CA0026.outlook.office365.com
 (2603:10b6:907::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:13 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:11 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 08/48] hw/arm/xlnx-versal: adma: refactor creation
Date: Wed, 16 Jul 2025 11:53:50 +0200
Message-ID: <20250716095432.81923-9-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b393cdc-b658-4f5b-ac00-08ddc44eddbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qZDrrpWdVP7B+kFjKNpggXtDQWzPirYYP2teLnJM71UsWvzOLqisdbJceoWK?=
 =?us-ascii?Q?v4XsKGmCeArH+T8unVH9nfd3xED/qkBw+2mWId1vLNfXCTgVV75QfhEFubII?=
 =?us-ascii?Q?fJ5KfTx/YP0ZmbkiSmTX+VpzqZbJptQ9mEfheZN1tUpoTOt1Us1pEfvNWmUa?=
 =?us-ascii?Q?1CVOED8F+JIcxIP6WLtDyXbtNwNoHRjJFuZieVjgpPrTR0b7ehaOAIUSluK7?=
 =?us-ascii?Q?hoEkjnIhpk3zQzkxzazPwm2GksHsrv08bIzETrswCxeyQ0oblcQHm/xzqc/N?=
 =?us-ascii?Q?ydcvOw40fAGwwdM+izuph5YGL+n6UYwk4KFyGOADN8ZKaBvKTyugRKW2dI8b?=
 =?us-ascii?Q?anP7YMQaTFUEuHh95q00oGVBxj3hlDv6LJNO17ZveVTVLwpth3uDtVoVX8kM?=
 =?us-ascii?Q?s6ngC7KG3raSSx7XnC/V45C2W2xE/qkWLfmTxaZSXj4Frt+EnFOF9b3IbPJC?=
 =?us-ascii?Q?jepUxnvCQNjinSFcctIAbasOWLtpV4+XbG7jipma+ufeyLeZnc8sQad0ZWgG?=
 =?us-ascii?Q?n3vQ2hLOjWjVj74t3AZfrQncpDUpg6AezaHevTaBQyTi1RT0KR+m92dLsqeM?=
 =?us-ascii?Q?RvuraC+7xcPOgXvNM6locNk+u7bto2Wp1mvC7YkoyxUHAD+FPMNoc2fJfdiZ?=
 =?us-ascii?Q?UrgVk2EZMW3ezGIAsVaT2lgWHdxpjd8qjhwKlKNsGz5/vaS1f2uSAxfJORGg?=
 =?us-ascii?Q?7TJRW/rorncy3mtaOUFGkIXLsrPzE4CRfCP8wV51SdPZ81BwsSI1RNooHSJo?=
 =?us-ascii?Q?YEkHASU9jb1HqfgGL0WWi56mSVov2zIeF5nyEWjhHqfLDi7FSWvwKlir7ABF?=
 =?us-ascii?Q?TqGE4Hkvp4EgVgKfacNAoHvcAIbTwNV3sPOWA3IctLwtXplubkDRhNm3pQpe?=
 =?us-ascii?Q?Aqv7srgGurfRNsiNSIRneI+a3ZtLSTEz3+8JZojLGO/iYC31xKTqynhck9E+?=
 =?us-ascii?Q?HchDVc3xn4BmqSM5qx5PXeQTn7S+LV++8hFKZWOsrMK7KzQJoQ75M3gdOKJi?=
 =?us-ascii?Q?I5snw/tpYqGNdD59lHHGgImNOCsBkloOHGk7XDd4slv64D8w+beuftiRCAbd?=
 =?us-ascii?Q?y0OPgNbe89OBe3QlQrHy1vCegwtH9lYpY3sKF4oALRYkvqHSZqI81leQR578?=
 =?us-ascii?Q?91eCXKQ93NHp1I9yDUxTHH8GS/nrx7dYAKY06Dg+cDNURSSdLXQLuCMDNdgD?=
 =?us-ascii?Q?cK6XeNzJ6VoEq2u+CkQs2v/rcmHhONlE3eV6zJquDbczgHF70FlziKY+cw3X?=
 =?us-ascii?Q?ffWRMHMkBxC/iIWKDSPsU1mzBu2TrSvRWDQIAGWA/LHRaPzGLsTHmwf2ZdeE?=
 =?us-ascii?Q?DTCa/hx78e+SlqxZHC5D58oDxMqTMiEfu8P3VnsDDNmLr7lXE0rjgkJ7xhTe?=
 =?us-ascii?Q?vDmhy2lqDs05XQ94MRlV+wntwWltohOHMBoXukGwb9I/M6Y5pZD2jmPN38RB?=
 =?us-ascii?Q?oRSz7yp6+3vl+U/DiMgAYhZMcg1j/YyMvht3gvDJsVffPZguSVCjxxUgTYrF?=
 =?us-ascii?Q?wU2n841+zjnGS/sZvEDji+oO81WQGO/BXf+N?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:16.2240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b393cdc-b658-4f5b-ac00-08ddc44eddbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
Received-SPF: permerror client-ip=2a01:111:f403:2418::603;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
index 09f87dc76dd..1922a90019c 100644
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
2.50.0


