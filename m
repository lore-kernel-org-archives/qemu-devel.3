Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B79CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4yY-0001cH-3W; Thu, 21 Aug 2025 09:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yK-0001Sj-Tn; Thu, 21 Aug 2025 09:04:52 -0400
Received: from mail-co1nam11on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2416::608]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yD-0002wc-NW; Thu, 21 Aug 2025 09:04:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqhVTjC9fIG7IAvNAAiy9jEGR/9Zzsz3Yv1sBrjr1EfXhyjvVj8Rqj1hscNAUL3gsYmhttNHYsg+740aoI4vfzPaJzQgNfByp7C5twKLwb/YoSTcIRysTvlK9rmouZIkaVHtnELVPADCKA4cCgU+1cKDVh+X0KhoW073WTP3xbus+7bYsQbB3gaUMPF8U57nt6AhsAhEC2crh17HpPDhK63gBinejHjX0QweDGN0r0pUlKjpJKcKTw4dSw3sRj9W+8F8DUS5zSuHbLVIn3P6qHZyJSHUhqm3Py1B4NgtTtwVjiKCdJnyeD4E6VK52PMTt/3HHjwG6PxnADDLnSxIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpdjZZi9VTLXObmaaviKdWAu/R7acEodB58/tH/cu68=;
 b=BaSQbaP5HwA17jp13fSR0K4M0lJE+8TlCh3u8c56V2fa4hLFnCVpHwuMnvYvDymAjjJgpK6kJodz13RhMEv/768HMM4RgMCBr1pid9qUDWF8/DU+n265JDCIWLaK4qHgolYfxS8sgygxx70ROBGupGvrOSljRCaVMEvuqy0CLXkAezBMgn+Ye51N8NIuySLSTjtua0VW5u6WLuZCW0Ckq4skyVO4rxzA4QegKnhZ27o6j7fgdUBcSnEhXF09rPgTBcJBym9ccInXWZ91NnkqZN6lISrQxrSbjOvNURaBb4rVocPiT7JNbTKEiM/3DGEzrgmfyYXLiDSY8RAWAxpq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpdjZZi9VTLXObmaaviKdWAu/R7acEodB58/tH/cu68=;
 b=gWtXIIvd4eicUQq3BXlfuM9dbZWfG5qzJORHyNyz/tGAjqfG2HRNZUiEi+ut1zmo7hy0LUgWmXwFYSDmcl5Rp+33Rj+WcEzt2RzyXzpMJ1xHwsHr+C6rL1ss4losg9W0+Aan5O9Am8pDfInQPXUscD2URxsWcyEiXmjMEENspNk=
Received: from SN7P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::11)
 by CY1PR12MB9560.namprd12.prod.outlook.com (2603:10b6:930:fd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:04:39 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::a7) by SN7P220CA0006.outlook.office365.com
 (2603:10b6:806:123::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:04:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:38 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:36 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 19/47] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Thu, 21 Aug 2025 15:03:18 +0200
Message-ID: <20250821130354.125971-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CY1PR12MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: ed48e445-6d37-4212-c33c-08dde0b3490f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3AfKgDfuaPnlALCG5MHYcJ0lEp+LQ0iq/Xp57OEZdxbzu+1fztCHlO6+ztpY?=
 =?us-ascii?Q?SL5jbeFfZNn3pcUfDZ9nlB0ejvc4tk7j5AdduRnN+rp25ySSiYLtOhw1YKbA?=
 =?us-ascii?Q?1iSCqK1S2OTyH0GacPVM1fmgj5LeCD62jFO1rVIJEa9rnPqGRQYCMoLWoUlq?=
 =?us-ascii?Q?793sOhy2Qm/NtbgHMS9j2OIyryBehnbPIT7RhfwWNjgV2Mg7nLvGJn1Lgzt6?=
 =?us-ascii?Q?BlFG8xRX4VUygU9jQq0mgaZ2o53r6mqWPkfts9hhrkGpW0l4ytpb2wBJj61F?=
 =?us-ascii?Q?mLZA4cgoAz/dXLJvBs5twavDKSI8amB16zr3jH1GQP0gzzLQ2skqB2XYRzJf?=
 =?us-ascii?Q?sWaJsjOe8RoIpwFg2IhZuLan6fERpt2nIR1SVnzeBUd++Cug0KDtCqFbie4O?=
 =?us-ascii?Q?0pxRZ5uZue2/sZefqgON/nfwrsTYOv8BxalNVMCSCrKRSUhXQEG8jIlTzSCM?=
 =?us-ascii?Q?cukGyh1f5tTJgHrslZ6nPkVbL/S/6pfNiorj3OVciu39dYvrtyKlz2G9ilQv?=
 =?us-ascii?Q?6834n1wC0h7GlgdtBCay7D+N6mphzrf6B8xEWpDR7PUVZ3x3IXTdcSuwICEI?=
 =?us-ascii?Q?I5LEdO2rAbYlKo+EyHB79kRct64kWjL/jLITZ8QsgAMSlQTyauTi2pxr3hZc?=
 =?us-ascii?Q?5hKwmvtsXJvOdMt+Tm1pBcfMPeA8Dm6aQKePeyWCYbFhO+xbKDwb6qQceqLq?=
 =?us-ascii?Q?vgMwTRK4oimBaU65gqgu/JAGfca41MjGn9V3gMYIOaCEFyZ5JFVHmK/bQLXq?=
 =?us-ascii?Q?40wd1U8OwVCP0x3krGGWtMZFKuXVOIQ//V94H1+iYGnQvzoJJGOotW2AmMfh?=
 =?us-ascii?Q?ns8rsFca41Gae4Sc3r5LbgsIu6X1AYqRstwHn58IH1cSMovz4+k3mr1z+/5t?=
 =?us-ascii?Q?hasqyB+i2HNOwjK3M6boW/Lu/NEYqzaLhU5WlmGhbo8wSGalFNMBlyA5btf3?=
 =?us-ascii?Q?YonWV+1EPzs7vNfswNiB6CGPfi71xhLKljv9SNVaggQCtM3kQSOSlo1VYUSe?=
 =?us-ascii?Q?dI/agX0UoONLV80S+cYoT7tealxAE1tCqOz1JXtNLCVZUTDYuBI4du+PcCNs?=
 =?us-ascii?Q?xVLTNFyEsLfNXjUozEUR2CAlL/b2wNuaArelICIiH5uEwJixqSdLyVfQznlM?=
 =?us-ascii?Q?6CG1nA+MtJvQ2UTNUljyfQIYy8wldaIsWbpG614HylthQpYeyB+BR8U2AE8S?=
 =?us-ascii?Q?gIOhloX/57pS/FTVwLx66DUEoyJ+ez1mwMON0SY/FP2jPxdS0M6FFX1s8zxA?=
 =?us-ascii?Q?rtteQ5ONLUV4zv0NsGauRcx35+D2TislH+GGepoGDs+KCCJEDOubZuf0v5dN?=
 =?us-ascii?Q?y3vMRkL/MU7RjY8mnygrzTmXcp9yxumicS3rECLSrk424SHmPpPY/hW8+4zA?=
 =?us-ascii?Q?a/RUThTRznnkpie4zH8eEeNWdjkKN+mBsI5DWVJ7J7EMlEB1f1BqHYTwIIbS?=
 =?us-ascii?Q?k4AJnrpIrWTikovh0rjZRu0/DhCASHJTsCslfIn6XXGUhMwKED0snz0jX23s?=
 =?us-ascii?Q?m5AsKvq+u0uEu8j6j016p86LHW1JREcEglHi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:04:38.5377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed48e445-6d37-4212-c33c-08dde0b3490f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9560
Received-SPF: permerror client-ip=2a01:111:f403:2416::608;
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


