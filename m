Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF130CA0EFA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoe9q-0004bf-7k; Wed, 20 Aug 2025 04:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9n-0004Vw-UR; Wed, 20 Aug 2025 04:26:55 -0400
Received: from mail-bn8nam11on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60b]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9l-0000yJ-Kg; Wed, 20 Aug 2025 04:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvWO2zpUMkWaQFjJ4hNbpgSJbd6i2K0NXDVKiYt90Yyzh7c9MNItunfupaV15Uk4MEq5vZ8ZTBmwPFGTnS7XDKfmy3w+kHxIwmO2FaYRcQVr2GbJ41fUz4JdeNrWBqAiJBYNFlecXcn4O6zvC5AS1zTC436S3hvQm6pEh5GwdQ/Y8saVd9w6G/ftZPzSTIIQINExbnOO64M6sHyAcskhVJUnS2+p4id2hVedMOPhgFU+wl9PCTcwfvyUvVO5sKM8EyjLLcIfdclHNAMI3nDH9J8u6jqR3HXsOqGwAHpq29CJhf41ejfLS6u+lQNDlZu07vPir56kFiNWu1sXNRigcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpdjZZi9VTLXObmaaviKdWAu/R7acEodB58/tH/cu68=;
 b=ExxrA1DnaZwphpwlZXp4DvKurcvLs/QQSbNA8l8BtzBfsB9mqYXnfUclVDjbVqt2cZvydyqYbAhGpFtszESWgmrl2mo6FIibvAr464kEA+xH/QdbZ12IH8i51+XBMbAp1FuL2yOZdVKajbU70WLt8khPFUoJvvDi5oHLw88+uWzmI74gkMZwdl6DmTxWiHbhYfyXVNYJIYUK3egMf4BD+9n7YhbPTPJIPbeN/WqBj0XXO0xxEbiiidGVv71xTQ8wA8SDNxCLe/fUQook81YBH3WVH/MFXNEbEaIdhRovPMLqdN4l/yYfmDflbzkRgQLPfnpc/ZGcLLkzKZkXJcsPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpdjZZi9VTLXObmaaviKdWAu/R7acEodB58/tH/cu68=;
 b=aBGpE4bpp6sg4TkW1yVoTrNoyvaKwwzAuD025NtJvEVRbwSWeRwHNkHttLd7LhbhU2QL51RTGNfUlm5CJqVVh87EBo3sM0ea5gYhN/ZOy0MiJ3gQj7jfGxLxXIry5Y7GkX/0ScQrtTRLaAX6jpueIZIWRAPNL8V/kY76gTRKRQM=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 20 Aug
 2025 08:26:46 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::9a) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Wed,
 20 Aug 2025 08:26:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:26:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:26:45 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:43 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 19/47] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Wed, 20 Aug 2025 10:25:18 +0200
Message-ID: <20250820082549.69724-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4295bb2b-c016-4132-3dc3-08dddfc34d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qJjBR+3EHg6P9X+o8g9pgStsf2U50DK3kgDzV7FPJBaL/yqdnjowtphrd5og?=
 =?us-ascii?Q?w8MrvIzEWXTV2tC4l3oQs5YIAV9YPMdNAXIPrj3vIVANPKIB3HQIkSJYJkcg?=
 =?us-ascii?Q?AL6chf+oQkYcr79X3hwM9S19OCyWiPxCU1uAW/zW9B3p2M9ea/4W3HyByhW0?=
 =?us-ascii?Q?FvzOFdcYVCuuvNXLdBmgdjR2bHdrWrO814FCzktrgKwr42xo3XvxwUT0rxIv?=
 =?us-ascii?Q?j0yHX/JUjeUtgl8vtmvwWdxrEBUARfQLebr7zzYyX/sfaxhsCbRJLvT4LoKg?=
 =?us-ascii?Q?qGU+eIDYOF2zVUxp87BZCkP4ck1mjdLd4tRVLK1EKY0Dhw9szdLtX3X2MRUm?=
 =?us-ascii?Q?xa6OAM7ASBq+mCI9iqR3qbspkomtixokcdHxzkuD/ZExFaQ3iQhGrVDC979W?=
 =?us-ascii?Q?3XD9pqem/VlBfpNKCC4VQeZ687HvI1xMThjx/Z7oKoXKRxNmuMKgNI9GAwjB?=
 =?us-ascii?Q?idXSotu/5+NH1PFM6wfSkbi7SxDE2UsGqCt5W33C0GZW9LvarpcncjDB6Skc?=
 =?us-ascii?Q?jRdf2zfu2sgxVkQmMr4Vb3fvacYGOCyoITvNP8dIkmDXMgO+POXgrZtvmPzu?=
 =?us-ascii?Q?iNduzNjgkw1MoW/zmmdb5/w/zqgyAyUbmdO0kp/EHDo7alwtrT+Oa/tlDFoZ?=
 =?us-ascii?Q?57rjyMyKC2xETh32xXL4WyjDkAXBDCjASnwtrVUG+1qWa0YPI2LBmDuUETyb?=
 =?us-ascii?Q?ulBEI5hyH5ljiaY4WHJV/5aa7ZpCs8Kbw6sF9mBThv2xNxxNQ/ftj0bnJ2kE?=
 =?us-ascii?Q?iuDUWljKOCpMu8Tr6iyz7aRM59VM4kj4ChLP6EPMy2xFO6F7beVBFYPVI2b4?=
 =?us-ascii?Q?9VXLMEeX5JUDVQkZra2UnYRIh73zKFNgu3t9P/lagBVCy1eaG45HzyieZSBn?=
 =?us-ascii?Q?SSqiqbr7u6JCSGtxd/AVKvt8xMa7b9w+yE+9ecNxZT9avBPKGzoPJHqZUaQf?=
 =?us-ascii?Q?XWjuSGtGXcFKW8t4RzO6qVpcNGQJAwnpdyupWdyYCJWY1QayM+S+nIoGBv8S?=
 =?us-ascii?Q?f6mR9En6Oh1e+l2fNjB8MrNiw+AW24/CUP5hGFzKWQvHYFJfZYjOT6jgmffP?=
 =?us-ascii?Q?T7Ln967+6PAMLmKuPyydRh14cYp3Y7XRnjZiazNgOD6Qyrc4L2R+zkr+VzwY?=
 =?us-ascii?Q?2+NApnIt4+tVhHmvlne80I0dtWtBk9lOmkA7w4CSLSGJIyWtVUWEDPmU4TEP?=
 =?us-ascii?Q?+Xqy0OKaDFG/wchtvYMnZofI072dk+OEUdSbMCWiFZDoTXxKYgTDWunJ80xE?=
 =?us-ascii?Q?hEegUark9HlubdOLD6Ol12WpLa5uJhBotIjva2BKZv0uj09uZiI3eHbwf1SN?=
 =?us-ascii?Q?nlgTZ7E/BQSi0MpBjAcdmSsiHg4uZLWUQHTjVkBB7xpQE6iw5vbIbq8o+eE1?=
 =?us-ascii?Q?uMAWw8Adislfj9JQ6N6kudoaTPbvf7vIwBfiQzvHHQTAhQ2CBSvQqtdnxKc0?=
 =?us-ascii?Q?PFmoYsn5GKsjlSKIIi1pdWikymMIdMtVijulbj2sroWlkMsp9MAvm9BUoEBZ?=
 =?us-ascii?Q?A6iZ1KsjZKnqWY0FrmxZqRJ01A3/1bwVEF/m?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:26:46.0255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295bb2b-c016-4132-3dc3-08dddfc34d19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
Received-SPF: permerror client-ip=2a01:111:f403:2414::60b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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
index 467efb92936..fc17bf300ef 100644
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
index ff55ec62301..fe2c789a557 100644
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
@@ -1411,10 +1420,27 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
 
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


