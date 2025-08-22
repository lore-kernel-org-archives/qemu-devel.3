Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF8ECA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTWv-0008Op-Ci; Fri, 22 Aug 2025 11:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWF-0007us-Fb; Fri, 22 Aug 2025 11:17:31 -0400
Received: from mail-bn8nam12on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2418::610]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTW6-0007C3-Be; Fri, 22 Aug 2025 11:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnBMiXlmhS9Zsxl2gj3fdKeYL7MDcOWGGzeGe5PEUZ0fEg/TMiPxgnnbuUakAbM30DUBwu3dvKYnlzpU1M/JHh95eS4AQUG9IePp4pU4H5OCDDQYGLSzHDRr/+rSwdacfHPXU40MTg6RXs7WWfl2euoS021aK0tunY+9ToqRpMKl6+walqs+X01Ycsa3W2L5b7/B4nZ3PQEBlmvsHhy3Lfiz6ezoGMg7vpPLith3HYici/7tRQb7DZWIRXbhsAfaTd1825M2G1Kwr49082SeAsAv68UiQkYQQhKqEAP+dDpkKLGK2uZsrHroK2PhWBzeLA3CyvC84Oy5j87qL3ulrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKpfELzEaoVpwt2c/lxPOlBSBpbofApPvkQ2y/TZEFw=;
 b=W/0aNy2Y1g7hM4INvLR3GksmMi76l792FWmhAGdwKb/mrwJP3A+K7iRPPhqE+psBjj1lBaVkmaKgLCyX6wOEO7IM18EjCzP/cOlHJW4bBHz2hCLUXoYAmYZrCIdjD2SGj5CRJF4RWqTBb2beCE5Fv5KhqNpUTUG7Cwfwsri0YrnENmdTmfX4ylrFdtYd6kCGp4WmplgfC3XEM/uIKXIMHUV0TWeNRABC4Py9xW4TNENyKD43Nbd1nQ7H7/7AftKLICjfyPyyEDGY2ZfMOSsfoUIYok9k8Yf5Tf1ze/MOpCD5qaSq69d8SYuio1Jx+q5VZQubd18Kia6AwiCG37/gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKpfELzEaoVpwt2c/lxPOlBSBpbofApPvkQ2y/TZEFw=;
 b=kZ9X6BzjqVgtoFyWxPfCQDBdX2BHAXQrk9L7Yh95vfBZDBNfo8hVc/lFCtAOdHs+14dymIM0MeD4kAAcXNgV72eLe2PuPPwXz2NeGJbjvZyCzc7S30kOExY9zqF8EtJQjeHIGO0nglNxm9siiAoTejYWZ3rX/EPvjI5+3e4WGVM=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 15:17:11 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::26) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 15:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:02 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:00 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 19/47] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Fri, 22 Aug 2025 17:15:44 +0200
Message-ID: <20250822151614.187856-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d3beb9-e4be-4ebf-458c-08dde18ef7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uja6a/0lST7HqH5O/A/jv9IOUdDEeQoUnVlyoC9c/MIN1Iu1/k9I9Qm3AS1f?=
 =?us-ascii?Q?jTaOewrSAgkmMWWGk5JzL4TXjDFERNdfTGB52WiKo/wuCtwTLCjabeC/6KMI?=
 =?us-ascii?Q?fuJNoOWpKYARZZCsMr6nehMr9PXgUMt8vGwRn0zhreFKD7dK4/i2vxc1BM8o?=
 =?us-ascii?Q?YsMcaY3tmv6UVcH/0spCJEGHec1wpcRrxD8fKQFBi4gF0NLOKNZtQauFiR7W?=
 =?us-ascii?Q?DDu0O/pz5rMgBXzSRwwrDSI0z45tTXWpgm22m1mFdZKCM2ClEjHBFf+VBXV1?=
 =?us-ascii?Q?hqiuQjKcthQDcW4F7ZvcGk3myJ9IRpeQxbKt76s0aBAUYWns3fa511kgW7QN?=
 =?us-ascii?Q?1G5U8zZ/9+FbDH8dbIQQ6uI8s6GG5HdxIv660XrQ2tp0sfPncKD4/KTImkrr?=
 =?us-ascii?Q?FhrofCaqvCSMhVsJMSF/I2Z44DUEH78rtFa5q/R4hIb+ORQKpJJRbvo29sgU?=
 =?us-ascii?Q?tnzId3d5HNNBgxWoXJO6s1vwXk75ayp3SLNVm0rnE1F/niYVhYuDMQjXz0u2?=
 =?us-ascii?Q?YdBwbeWMQhpmpxrEI2ZRpuf3F9Dgg/VOrCztxYx4XIpD6WCJY3lfO0yHT+of?=
 =?us-ascii?Q?f9fxuTFxVzm70hX0cBlPpF2CUhd2F1WrLDdFXi0EN1fj7fOmMPxV/Pc07bic?=
 =?us-ascii?Q?KZ28SzOiH1j+qW2+WhArip0FmlKRmQGmLv5qkDE7mT3eC9COg5PmkZEcqKVY?=
 =?us-ascii?Q?XL0ZpYruxheDaAFS3LbpGCRAXDtHn3vCSxXYY20qpXAnW2j3tPjMLOUwbAK3?=
 =?us-ascii?Q?iwoeuvT8aHA79y1PAL25iCiZYHvcT8QAVWzfdfX1tLMCl/YlEWCUMq7QiSIw?=
 =?us-ascii?Q?e1JNDI665jKwVgMP+zphIP52EOaIzss/nzokbTxlnWJ6TM/tqHQAM3YswqnG?=
 =?us-ascii?Q?iKo4SCqDqBb/GEVaKK/RAVA+VikvCpNJOxumE2NP3bfgTvQXDsrvwm4E1tN5?=
 =?us-ascii?Q?CAMc7tlpnS2tDci+Cao/pbBfWwnhMWYPlslNW9BBgBGwauWSn8bafDNQFUjy?=
 =?us-ascii?Q?hnLgPa0t987oX1hOF1yfRfX2AyJXwuHoyUXZiEv7+BMNWvBsyxpSyptSiReY?=
 =?us-ascii?Q?xgaBLRB5vNWIJu/48LSbKEPxg544D36PO+KX7TjOeEKthLbHeCJCRyGbshJT?=
 =?us-ascii?Q?Ew/NWrN4wszzKPLdbW2C+YRqO1IqgLAVSl/gMNnIvGHYhjVgyQ479Zpz4Tli?=
 =?us-ascii?Q?13VdtAy0f3JjJ5qoNbJj+wNHGdthfnRPZMMeDTN2kSckH45FRozXYgn1Vpn/?=
 =?us-ascii?Q?nAHmrJuCkDkX0UCB6BNDSMq/n2yHUmch3xO7QGQSQ0TGmoW3tZvFhH93wcVP?=
 =?us-ascii?Q?dzbsQsb3nr3xkSaDYUkRSFepAJLAn65Efd0rG/lx4pGytNsZp8IEuR3QFzbo?=
 =?us-ascii?Q?ZGINsSIIbjPaYd3aootMnNUoDn3Uwlkl0HyUAby8jhGGMOJ5xuGxYy+GsokC?=
 =?us-ascii?Q?c4S+mmXlC3WxHs/erGQyv1oJXDnm+6nFSRpZirmKao3Fqfrf5/R6f9JFS6Sy?=
 =?us-ascii?Q?Txs/LYMy1y2QjhAp5ZRUwCMNfyfQzNY82rgk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:11.2310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d3beb9-e4be-4ebf-458c-08dde18ef7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
Received-SPF: permerror client-ip=2a01:111:f403:2418::610;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 1ef12de4c8f..30e7e2be8db 100644
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


