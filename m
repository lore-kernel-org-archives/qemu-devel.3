Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB7ECA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0co-00078a-Qy; Fri, 12 Sep 2025 06:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0ce-0006cP-3G; Fri, 12 Sep 2025 06:03:16 -0400
Received: from mail-dm3nam02on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2405::630]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cT-0001Ju-U3; Fri, 12 Sep 2025 06:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ob8LLYeyeyb+uT+MZNABdLRq+b+NocLQ86tmePzsGJ308DE9cnMkN4R/xGB5PR2fXc+b+xs5RlYQrBrU7VXH0NjQiwD+cIb2TTap69tyy3LDdJVzqM+MOQEN6zO4wZJJqbkTb9IcuvXpxUgYk65Q+RJ7OLIm5q/kAz5QB6UKFLsk/wGPYEpDGea/NC0Q5b2rx7TZreswTG5BHEk591vXGjWsjIucm8/PpCP5vJI70UKFXugnWycLY1ewbY1SeLB2XqRHQJkJpqsQB5YuTHHGLsADABsA8vRLgyhYGF4u+HRGfqpQ58viy8AidKQYuHYoYbtJ2g9W4qFRONTc8uDA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds7h21BEEGXM/4NSZSC59n64L+9wPH8mU1Sq/POlW2w=;
 b=jefxkHhw07DuAdhznOvrXQ2gpg/P1qI3r7bedCYaxZTC7jCWX02YQJJqQNuvM39sZWPAB6Y61edMLG0nf9Xt6eqdqxG5/tildmV6eaPJy4nC/RAbQYs3t8euioDw+Ai3lA+mQjJWvwnnnxxLKIZBJ7OU93SdHQzO+NjaxDG5hX2r4rOGzCmyNLSS+gi7KsvmgsqGMPPJPU8OmGC4U8XIve9XnEfdZD8u8BJ83NJ0yrSbWq2DjHeIp14mbnoW6YqgQN/vbIb2SE69Dv8NDbG2YncdLDbFWCfvvXQlITxaRYNxOfBV5vUBNQE7vHJGhcEQcIV1ZFRJIeEiSxx3rCXY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds7h21BEEGXM/4NSZSC59n64L+9wPH8mU1Sq/POlW2w=;
 b=KELsGmdyoIpjxW/hLBY7IyzGAhZ4flooRpr1jx3RQ+K/Lof6PjIEQ9PHx7t1/Mobs/0cWmMu5PlPnRRu3GvDMZAO9WrxaWFvEhFt4S5bRz0QJfpvRItgkqu21c0KNCjv0cmgAy4BxQDj4w2EYbd1jXDJ59YNyODxjHiU9ayOs2o=
Received: from DM6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:100::41)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:02:54 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::a8) by DM6PR03CA0064.outlook.office365.com
 (2603:10b6:5:100::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Fri,
 12 Sep 2025 10:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:02:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:01:55 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:01:54 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 19/47] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Fri, 12 Sep 2025 12:00:28 +0200
Message-ID: <20250912100059.103997-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf08da5-ab55-43ef-d450-08ddf1e38aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YJi+HnsSwvd7Gdk1WrOJU+JKSsg3BAQmwGHhF//ubWvi+xYKxHRE7G3T9qaR?=
 =?us-ascii?Q?vMvC5+kq9leks7YIdS3fG/0wrUydq9pIbZKNTgtxtUoumpkqyqHa1MUpgh0y?=
 =?us-ascii?Q?jMG/fRrd6/OJaaUwmiNdDiuwR36zroAWG2L2ne/0w2VjfGFXhELiueExy6wU?=
 =?us-ascii?Q?X3QwQWtlk43dzjLyh8Wu4ENpicef2a7Yqkg6dHJjMPP5fPcVP7kL+jTP7RBG?=
 =?us-ascii?Q?jf5UF6kx9oGsEG1BAFpR9NpNf9mNlh+Tg5XRtguq9ZtlKNcRpp2WvmCByZjB?=
 =?us-ascii?Q?1sstg2LA/LI8n4PnkswLn5oFdxmfR4li5k9JRUZ8Nuzguoxg4/1L2hBA1o31?=
 =?us-ascii?Q?XJov1iWcUevW4aKDNYxreI80yl/2n1N35aYgWe8VAP/Jm/h0IEz3QZjQNZZD?=
 =?us-ascii?Q?DcY9nSYtSBy14f5yK5uLhVwLyOzc5LqfQzguScy0u/IYnecD7aGwFLg4QR5d?=
 =?us-ascii?Q?cu4kLna+jCyqwDM92VvqLoUvV2vsBiBe5wbuPfGW0ZTxlGFOEp1ctnHC0xf5?=
 =?us-ascii?Q?b+d9/Yc1ccGiTQRNTGGGVcYZ5ptUeBVXJBZgX8PVqx7b3gdeSCXl4/HKcSA1?=
 =?us-ascii?Q?YoKQGkxN9WiF9tE9Xa1QnN7V8M0/O888/1NWrRToj6YPpxOJeKhcE3+UFRHR?=
 =?us-ascii?Q?V580rnv+OoBsmVmGN4RoxaykzhKEBFzg+swGJ79a2k0eJppHtsoQ3tKcgLO6?=
 =?us-ascii?Q?r9R/8xvimkT+MynoL1cdODbT3ly2kiTNrfAaokXUmTNNVCtjBkn0WI0u6iwu?=
 =?us-ascii?Q?btXKC1OIexi6NPh5eeqKFf4zGxTLoWGz0/Op5D1MRhmIKUM3bmOK84RIqLU0?=
 =?us-ascii?Q?jC+z8uB8bhGrAapeMS9g99n53PEGYgTNGAzXZO2VRnflqrUCH+9jX9LG/bby?=
 =?us-ascii?Q?n233BMnGsxL5F0bSNI6lkA0tGCxIXiE5EhS4o/LsoR+g49S9KILZ/lVMkKN5?=
 =?us-ascii?Q?eZWXvZmpCl2F7yrqOEAKLzP/nLSnpJnGZWA70qt+BpeqSQb858NmdaRswQyD?=
 =?us-ascii?Q?A7R5aw9rXAs6fO/rJfw20Qp/BiaynkLz0UhiMh9Ro58fox0EtA4ZYmot5weI?=
 =?us-ascii?Q?Ls1bOE8f/2EzxdziV0ccmNiPO0f4LrMFIl5/v6i8U30rrJRTXeYUy9CdWvTl?=
 =?us-ascii?Q?NA0oK8UAJxTMS/m3vHFTSQxmzXYXltScxtxUD4kbTHF+0j33A2ytgwrhOiA/?=
 =?us-ascii?Q?M/uLsod7JdY77TekvWCmavbbs57ItqolDGeOnnnV9Ggpyq3nmyqCOPK4gFyu?=
 =?us-ascii?Q?arVVJqIIllxYCtaKPX7g8kJWyNOHHzyy5Y3jIdbNeGHHuPxZSlb8aM4kgI+z?=
 =?us-ascii?Q?DH05TQOtcWXIv+4zL3KmH2QbeHolY+cM9qF7ntEtYQYcxCvu1rOniFm8nlMu?=
 =?us-ascii?Q?VEaFAQ0OuPWiAsYNrMPIP/HPQVG40izXS78qbEt8t3wPoHJStOWPGxMre8xR?=
 =?us-ascii?Q?Yl1YlqXQJJOeNg5cqh20Bvn16H0uxDMtRnBtGs+yIYocUAym3RJm+qIviGau?=
 =?us-ascii?Q?fS8RGIi9sl6rp2ZvEeD214Kikwhy2Z1rvSq/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:02:54.7576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf08da5-ab55-43ef-d450-08ddf1e38aff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556
Received-SPF: permerror client-ip=2a01:111:f403:2405::630;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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

Refactor the creation of virtio devices. Use the accessors provided by
the Versal SoC to retrieve the reserved MMIO and IRQ space. Those are
defined in the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  3 +++
 hw/arm/xlnx-versal-virt.c    | 31 ++++++++++++-------------------
 hw/arm/xlnx-versal.c         | 26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index d3ce13e69de..af47acb288f 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -100,10 +100,13 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
                               BlockBackend *blk);
 
+qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
+hwaddr versal_get_reserved_mmio_addr(Versal *s);
+
 int versal_get_num_can(VersalVersion version);
 int versal_get_num_sdhci(VersalVersion version);
 
 /* Memory-map and IRQ definitions. Copied a subset from
  * auto-generated files.  */
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index d96f3433929..b981d012558 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -269,41 +269,34 @@ static void create_virtio_regions(VersalVirt *s)
 {
     int virtio_mmio_size = 0x200;
     int i;
 
     for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        char *name = g_strdup_printf("virtio%d", i);
-        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_IRQ_FIRST + i;
+        hwaddr base = versal_get_reserved_mmio_addr(&s->soc)
+            + i * virtio_mmio_size;
+        g_autofree char *node = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
+        int dtb_irq;
         MemoryRegion *mr;
         DeviceState *dev;
         qemu_irq pic_irq;
 
-        pic_irq = qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
+        pic_irq = versal_get_reserved_irq(&s->soc, i, &dtb_irq);
         dev = qdev_new("virtio-mmio");
-        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
+        object_property_add_child(OBJECT(s), "virtio-mmio[*]", OBJECT(dev));
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
         memory_region_add_subregion(&s->soc.mr_ps, base, mr);
-        g_free(name);
-    }
 
-    for (i = 0; i < NUM_VIRTIO_TRANSPORT; i++) {
-        hwaddr base = MM_TOP_RSVD + i * virtio_mmio_size;
-        int irq = VERSAL_RSVD_IRQ_FIRST + i;
-        char *name = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-
-        qemu_fdt_add_subnode(s->fdt, name);
-        qemu_fdt_setprop(s->fdt, name, "dma-coherent", NULL, 0);
-        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
-                               GIC_FDT_IRQ_TYPE_SPI, irq,
+        qemu_fdt_add_subnode(s->fdt, node);
+        qemu_fdt_setprop(s->fdt, node, "dma-coherent", NULL, 0);
+        qemu_fdt_setprop_cells(s->fdt, node, "interrupts",
+                               GIC_FDT_IRQ_TYPE_SPI, dtb_irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
+        qemu_fdt_setprop_sized_cells(s->fdt, node, "reg",
                                      2, base, 2, virtio_mmio_size);
-        qemu_fdt_setprop_string(s->fdt, name, "compatible", "virtio,mmio");
-        g_free(name);
+        qemu_fdt_setprop_string(s->fdt, node, "compatible", "virtio,mmio");
     }
 }
 
 static void bbram_attach_drive(VersalVirt *s)
 {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index e1f93dbb09c..1e4229c7670 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -152,10 +152,17 @@ typedef struct VersalMap {
             uint32_t blktype_frames[7];
         } cframe_cfg[15];
     } cfu;
 
     VersalSimplePeriphMap crl;
+
+    /* reserved MMIO/IRQ space that can safely be used for virtio devices */
+    struct VersalReserved {
+        uint64_t mmio_start;
+        int irq_start;
+        int irq_num;
+    } reserved;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
     .uart[0] = { 0xff000000, 18 },
     .uart[1] = { 0xff010000, 19 },
@@ -218,10 +225,12 @@ static const VersalMap VERSAL_MAP = {
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
         },
     },
 
     .crl = { 0xff5e0000, 10 },
+
+    .reserved = { 0xa0000000, 111, 8 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
     [VERSAL_VER_VERSAL] = &VERSAL_MAP,
 };
@@ -1424,10 +1433,27 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
 
     sysbus_connect_irq(SYS_BUS_DEVICE(ospi),
                        flash_idx + 1, cs_line);
 }
 
+qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx)
+{
+    const VersalMap *map = versal_get_map(s);
+
+    g_assert(idx < map->reserved.irq_num);
+
+    *dtb_idx = map->reserved.irq_start + idx;
+    return versal_get_irq(s, *dtb_idx);
+}
+
+hwaddr versal_get_reserved_mmio_addr(Versal *s)
+{
+    const VersalMap *map = versal_get_map(s);
+
+    return map->reserved.mmio_start;
+}
+
 int versal_get_num_can(VersalVersion version)
 {
     const VersalMap *map = VERSION_TO_MAP[version];
 
     return map->num_canfd;
-- 
2.50.1


