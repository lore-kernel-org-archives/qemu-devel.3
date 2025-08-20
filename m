Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B76CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9O-00047j-7x; Wed, 20 Aug 2025 04:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9M-00047G-RU; Wed, 20 Aug 2025 04:26:28 -0400
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9J-0000rV-Qb; Wed, 20 Aug 2025 04:26:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dL6uGor6VQq7bFO7m5Q/hRhKfipFy9N6HAznRmaNBPvfCPbfVdpmCrH7SqZivAFXZNDOiutnZo2/ONdjV78uMxqcl6zyjvDp9LRGjmAilnROgAXPqHkagDtyMxJGIdlbTbY7jDXaSLloutXvZIzeFSXDbtlWY7DkfXXddpyvCMRrCePV5jP1LUCw5ueSKFgsowsiHSa4pB3t6M4FivKcaVEy7lHXBFeSF1zO6nYoAyIrGPnF333T6KUuLDDizUtL0lsmaBikMgekzhZ2pc0KE+VppOQhQDdjchnTckEtfY0aBeCu/YFAhgtc+NvoNW61mH9/m7y9KxJ7zwMSHWav+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBAu8FTDoy66TpA64t8cBM3tQ9SeBzAH/Yys4hg/DMc=;
 b=GZPAIcptGK9h5SGsXLH5NHzp3QYHp9N2RgmuVcBhcTXbKazTKs4opQKvrrOFmKBfJe1mkNIA6LNtqy8bnWg3kiY7FLiRcZ4k5p2bMN0kbdCOPs2csvLazNdhiyoEfU6Z4JYHQLdBM9fagDdG6kr+wqaOdLirRuiMX0neJgse4w3hfhIeL8h0pU/vBQGVBXl1ovvLAiDoHEYUs7/RzsF4Z5fVi4ctskr1lLGlarREhPTTM/j2AL5ledPjOsEd5QP0S6+f6Tu5b7VET5p7ffc+HBwZjcsV8gRa666k9/oYnrVJSobvx3PEFprs9Pol8FCXIze1EZSt1orKz+bWfDLBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBAu8FTDoy66TpA64t8cBM3tQ9SeBzAH/Yys4hg/DMc=;
 b=XXlEMoq+lfnWnvJApKA5KgrhUetFlB0t8N81HIRAsbdfs1TcLeUF9Q5+quYIUSbqrRvtF8N47Aryqe05MS9pFG5I87qY45ehaAvJFOJ7S8PALmX+gbrWkl+LesfSKxRniOd+e45dL9rJHCzCr0//yfELCrIbe5eHZx5WLpJM+eY=
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:26:20 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::9a) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.24 via Frontend Transport; Wed,
 20 Aug 2025 08:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:18 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:17 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 05/47] hw/arm/xlnx-versal: sdhci: refactor creation
Date: Wed, 20 Aug 2025 10:25:04 +0200
Message-ID: <20250820082549.69724-6-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c84a9da-9949-4fb5-4d6e-08dddfc33d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m6pIhNPsA+dnl23L+3sDxDun1ccMysNkhqpXgFEMUS1ICGtklthVZZCtClhw?=
 =?us-ascii?Q?M3C55w0b9qnO0NoEYs6p1Erjb1JnT1Dp12praYM4iZPICWwUxcBrK6baF742?=
 =?us-ascii?Q?cEryr9rCH7TjR1l0XKAZiO25G0OHbfDsY+kY+g2X3yFNiGUl9Xx1fo/XrEBL?=
 =?us-ascii?Q?FOkQopYL1Sa+F9Y+QDBYC55J6eGPuC7p4lkczGJ5pbHzcgsVH7gqOIbeVpvQ?=
 =?us-ascii?Q?4Nx9w9qU1c59+S7/g8eLLS1xz7IHA41wgczrS6m/ZGatbyyL6yE0X+qBeLU4?=
 =?us-ascii?Q?vAJEue80MhpIitTCV82t2qH2dLMkuHD65W3luOsxrUg56hnvEI8HVJkL6SXa?=
 =?us-ascii?Q?uJEywKB8QwUQbvfWU/TbLHkd/rf9qEugChqsZBfW14gnrgspXomWJYYgHLow?=
 =?us-ascii?Q?7JK3deJ3iPtBuR1pOx0Z4jXXsDE8XKkSDxKk0OLxNFoxwLgckJ3zWCR9UrcW?=
 =?us-ascii?Q?3GSDXWZq4Owt6zFKuWZM+VgmmV4OHJbGZdqS5Yk1vFXRqfHHNMaU+Bj4b50k?=
 =?us-ascii?Q?OL6/QIAq9o5+f1uKMxltnMQGB20kqk4/9hHYhOUlFk/CoMsAJK5dk1Tfhfvz?=
 =?us-ascii?Q?FrP4/RmXKW5mUwdBWUMFmvjawx/Wci/MPD0F8PyhMgFw8LvV4EJiLrdr0RU0?=
 =?us-ascii?Q?p2h3EMiUejeTcGnr/gPV9UZnaPKCXiArJtLruSyGhBqgARjV0HnncJJntHys?=
 =?us-ascii?Q?xU67fOIGf8Perz/9wm1IJpZty1Ibw5c/RoBKCRb16jESd0Z+42qmtW3J8/lK?=
 =?us-ascii?Q?kPqf7Czz7j4aIqpdvF5bwL1e3HmUlAo4hegMOMsnUY6ydu/b4I2QNHGh9Kug?=
 =?us-ascii?Q?YHsnr3kIKxbFebTO/vosDzoIQJae1r+8rNUZPXgoR7sFGAWtyAuNkB009pGI?=
 =?us-ascii?Q?/yV2U9ukMLJyajjE5V5aCcnV4TlTw+vwqPHnWi8HEIAY7m4t8bdNwxf2yokq?=
 =?us-ascii?Q?Hmb6d8pGOmPn2/CJRUPFAAZKwKPCYFdL/Alqr4rw7vACE4zPT3dU3W7R+BN9?=
 =?us-ascii?Q?tpfWebJpaLHdWxNxQoWmTyzoeOiD71oNjRFl7YZibeKuNTTdJ6iZ0RxdSosl?=
 =?us-ascii?Q?08IczgsQ0lJza9MRO3u09h5HabxTz/DNFOMivQ/h8wFOjGbBaHAXkKn6sgSd?=
 =?us-ascii?Q?4xt/jXsv6eUELEaphD+JNwru5tiyG0Vft9ku7vv/onqL529NqZYLhVKU9Mfp?=
 =?us-ascii?Q?6ZmtNLrYpRKq41O50kRE6zQW4qXs9mvZdM0wl9gRChqVnyOG5/WalmwIvYiV?=
 =?us-ascii?Q?zruBAJZcCzCkcqYWYxz127GCBxQzDFXv/E/kS5+Qdh+LxPiCDkmO/4i0nIXW?=
 =?us-ascii?Q?CUx3QE+BhuDb9nKotOPZYB8MmodHTriV65iGvF5XBHe60IMcVOnwSID6XUl/?=
 =?us-ascii?Q?5/OUuJmbGmvypaKjIW/F/WRhxi/I20As43lGFPuRrsxemKxhbnw2Hhcz7vSU?=
 =?us-ascii?Q?A3pvtIrzLZqrS4Puy9xx2eMP4aI4WKyQ2QlCm0Zu20peY2Vn+u0yAcE+GXcc?=
 =?us-ascii?Q?0F9sUl2N2UcyMExurRpMKKYO+VSTGR0k/LJI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:19.7383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c84a9da-9949-4fb5-4d6e-08dddfc33d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
Received-SPF: permerror client-ip=2a01:111:f403:200a::60d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

Refactor the SDHCI controllers creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  5 +-
 hw/arm/xlnx-versal-virt.c    | 43 ++--------------
 hw/arm/xlnx-versal.c         | 96 ++++++++++++++++++++++++++++--------
 3 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 007c91b596e..4a7a2d85aac 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -14,11 +14,10 @@
 #define XLNX_VERSAL_H
 
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/or-irq.h"
-#include "hw/sd/sdhci.h"
 #include "hw/intc/arm_gicv3.h"
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "qom/object.h"
@@ -103,11 +102,10 @@ struct Versal {
     } lpd;
 
     /* The Platform Management Controller subsystem.  */
     struct {
         struct {
-            SDHCIState sd[XLNX_VERSAL_NR_SDS];
             XlnxVersalPmcIouSlcr slcr;
 
             struct {
                 XlnxVersalOspi ospi;
                 XlnxCSUDMA dma_src;
@@ -154,11 +152,14 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
+
 int versal_get_num_can(VersalVersion version);
+int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
 
 #define VERSAL_GIC_MAINT_IRQ        9
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e189800a5a8..f546ec10f6f 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -282,36 +282,10 @@ static void fdt_add_zdma_nodes(VersalVirt *s)
         qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
         g_free(name);
     }
 }
 
-static void fdt_add_sd_nodes(VersalVirt *s)
-{
-    const char clocknames[] = "clk_xin\0clk_ahb";
-    const char compat[] = "arasan,sdhci-8.9a";
-    int i;
-
-    for (i = ARRAY_SIZE(s->soc.pmc.iou.sd) - 1; i >= 0; i--) {
-        uint64_t addr = MM_PMC_SD0 + MM_PMC_SD0_SIZE * i;
-        char *name = g_strdup_printf("/sdhci@%" PRIx64, addr);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-
-        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
-                               s->phandle.clk_25Mhz, s->phandle.clk_25Mhz);
-        qemu_fdt_setprop(s->fdt, name, "clock-names",
-                         clocknames, sizeof(clocknames));
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, VERSAL_SD0_IRQ_0 + i * 2,
-                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
-                                     2, addr, 2, MM_PMC_SD0_SIZE);
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
@@ -562,20 +536,15 @@ static void efuse_attach_drive(XlnxEFuse *dev)
     if (blk) {
         qdev_prop_set_drive(DEVICE(dev), "drive", blk);
     }
 }
 
-static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
+static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
 {
     BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    DeviceState *card;
 
-    card = qdev_new(TYPE_SD_CARD);
-    object_property_add_child(OBJECT(sd), "card[*]", OBJECT(card));
-    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sd), "sd-bus"),
-                           &error_fatal);
+    versal_sdhci_plug_card(&s->soc, idx, blk);
 }
 
 static char *versal_get_ospi_model(Object *obj, Error **errp)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
@@ -643,11 +612,10 @@ static void versal_virt_init(MachineState *machine)
     fdt_add_gem_nodes(s);
     fdt_add_gic_nodes(s);
     fdt_add_timer_nodes(s);
     fdt_add_zdma_nodes(s);
     fdt_add_usb_xhci_nodes(s);
-    fdt_add_sd_nodes(s);
     fdt_add_rtc_node(s);
     fdt_add_bbram_node(s);
     fdt_add_efuse_ctrl_node(s);
     fdt_add_efuse_cache_node(s);
     fdt_add_cpu_nodes(s, psci_conduit);
@@ -666,14 +634,13 @@ static void versal_virt_init(MachineState *machine)
     bbram_attach_drive(&s->soc.pmc.bbram);
 
     /* Attach efuse backend, if given */
     efuse_attach_drive(&s->soc.pmc.efuse);
 
-    /* Plugin SD cards.  */
-    for (i = 0; i < ARRAY_SIZE(s->soc.pmc.iou.sd); i++) {
-        sd_plugin_card(&s->soc.pmc.iou.sd[i],
-                       drive_get(IF_SD, 0, i));
+    /* Plug SD cards */
+    for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
+        sd_plug_card(s, i, drive_get(IF_SD, 0, i));
     }
 
     s->binfo.ram_size = machine->ram_size;
     s->binfo.loader_start = 0x0;
     s->binfo.get_dtb = versal_virt_get_dtb;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 5dccf231942..b963a05935b 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -26,10 +26,11 @@
 #include "target/arm/gtimer.h"
 #include "system/device_tree.h"
 #include "hw/arm/fdt.h"
 #include "hw/char/pl011.h"
 #include "hw/net/xlnx-versal-canfd.h"
+#include "hw/sd/sdhci.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
 #define GEM_REVISION        0x40070106
 
@@ -45,20 +46,27 @@ typedef struct VersalMap {
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
 
     VersalSimplePeriphMap canfd[4];
     size_t num_canfd;
+
+    VersalSimplePeriphMap sdhci[2];
+    size_t num_sdhci;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
     .num_uart = 2,
 
     .canfd[0] = { 0xff060000, 20 },
     .canfd[1] = { 0xff070000, 21 },
     .num_canfd = 2,
+
+    .sdhci[0] = { 0xf1040000, 126 },
+    .sdhci[1] = { 0xf1050000, 128 },
+    .num_sdhci = 2,
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -71,10 +79,22 @@ static inline VersalVersion versal_get_version(Versal *s)
 static inline const VersalMap *versal_get_map(Versal *s)
 {
     return VERSION_TO_MAP[versal_get_version(s)];
 }
 
+static inline Object *versal_get_child(Versal *s, const char *child)
+{
+    return object_resolve_path_at(OBJECT(s), child);
+}
+
+static inline Object *versal_get_child_idx(Versal *s, const char *child,
+                                           size_t idx)
+{
+    g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
+
+    return versal_get_child(s, n);
+}
 
 static qemu_irq versal_get_irq(Versal *s, int irq_idx)
 {
     return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
 }
@@ -422,36 +442,43 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
         g_free(name);
     }
 }
 
 #define SDHCI_CAPABILITIES  0x280737ec6481 /* Same as on ZynqMP.  */
-static void versal_create_sds(Versal *s, qemu_irq *pic)
+static void versal_create_sdhci(Versal *s,
+                                const VersalSimplePeriphMap *map)
 {
-    int i;
+    DeviceState *dev;
+    MemoryRegion *mr;
+    g_autofree char *node;
+    const char compatible[] = "arasan,sdhci-8.9a";
+    const char clocknames[] = "clk_xin\0clk_ahb";
 
-    for (i = 0; i < ARRAY_SIZE(s->pmc.iou.sd); i++) {
-        DeviceState *dev;
-        MemoryRegion *mr;
+    dev = qdev_new(TYPE_SYSBUS_SDHCI);
+    object_property_add_child(OBJECT(s), "sdhci[*]", OBJECT(dev));
 
-        object_initialize_child(OBJECT(s), "sd[*]", &s->pmc.iou.sd[i],
-                                TYPE_SYSBUS_SDHCI);
-        dev = DEVICE(&s->pmc.iou.sd[i]);
+    object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-        object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
-                                 &error_fatal);
-        object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
-        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
 
-        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
-        memory_region_add_subregion(&s->mr_ps,
-                                    MM_PMC_SD0 + i * MM_PMC_SD0_SIZE, mr);
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
 
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                           pic[VERSAL_SD0_IRQ_0 + i * 2]);
-    }
+    node = versal_fdt_add_simple_subnode(s, "/sdhci", map->addr, 0x10000,
+                                         compatible, sizeof(compatible));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
+                           s->phandle.clk_25mhz, s->phandle.clk_25mhz);
+    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names",
+                     clocknames, sizeof(clocknames));
+    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
+                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
+                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
 }
 
 static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
 {
     DeviceState *orgate;
@@ -1064,14 +1091,17 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < map->num_canfd; i++) {
         versal_create_canfd(s, &map->canfd[i], s->cfg.canbus[i]);
     }
 
+    for (i = 0; i < map->num_sdhci; i++) {
+        versal_create_sdhci(s, &map->sdhci[i]);
+    }
+
     versal_create_usbs(s, pic);
     versal_create_gems(s, pic);
     versal_create_admas(s, pic);
-    versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
     versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
@@ -1091,17 +1121,41 @@ static void versal_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
     memory_region_add_subregion_overlap(&s->lpd.rpu.mr, 0,
                                         &s->lpd.rpu.mr_ps_alias, 0);
 }
 
+void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
+{
+    DeviceState *sdhci, *card;
+
+    sdhci = DEVICE(versal_get_child_idx(s, "sdhci", sd_idx));
+
+    if (sdhci == NULL) {
+        return;
+    }
+
+    card = qdev_new(TYPE_SD_CARD);
+    object_property_add_child(OBJECT(sdhci), "card[*]", OBJECT(card));
+    qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
+                           &error_fatal);
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
 }
 
+int versal_get_num_sdhci(VersalVersion version)
+{
+    const VersalMap *map = VERSION_TO_MAP[version];
+
+    return map->num_sdhci;
+}
+
 static void versal_base_init(Object *obj)
 {
     Versal *s = XLNX_VERSAL_BASE(obj);
     size_t i, num_can;
 
-- 
2.50.1


