Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EA6C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyuB-0001Gt-0y; Wed, 16 Jul 2025 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrr-0001bu-GT; Wed, 16 Jul 2025 05:56:06 -0400
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2412::604]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrl-0006cK-Kz; Wed, 16 Jul 2025 05:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtPBYIlcgZmJ0uSV9X14s9348Id2Ej3/dLmiuN3PL8KzqQgCp2mN5kBiLXaruZgcEvgyIwwTEw7hA6U1bhAG36JIFSLDnnIbXUgXazQboakEkCg6i7wKxRgEH7JnR6Ek4iZOG3SeTQJlbBJ6y37xAzSqa+YK+QmnnEVvbjSSTbSs93E6Rfpa32GleLalAYT7zQ6Ho3nGdhW2RphMenqqPIg+HXIR6vGrjUBZuEgQ8k5C+gGhnyns2kyTI5A8h+Ggt+bOYTITCfHdkxuB2vy41APE5ylw3Sh++l00fXZDIPmXHhsCxW32/NaNNKZ5WWYxD2Z1B9XiCEQqJCuEEcsd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5AFuVtxLj2ZGEHVsOabWn8dkwcfaMm0Pv3XqhbJB+M=;
 b=PzU5mfPyvpDYyCTT9s1LhJUmONOAaReBOjTnFzAzId4gJtJ7JdDRXKvjeB7Ch6sIkDthymczI8RobWW+jRTno4Mb71aGnj+CFHYr2Sq8r4CVTTFIKIudZrsfXhbx+xiACSP+SOWR8tbmq/BJnIChEA+97rIyZEb+sOB++RAZ8HDKRPn/OQeryPMeQkeM/5+gWLx7GtFlWdh7kHF3AJvscporE0j9Url2kMtbxfQMkrU52KqIg/HbsOpcqzWNtZbpvjEWf+AK/c20pmK0PxBqfgG4hhHmyuJ9TfSYlWbyVfW0Nm/YObO298LEcG1wUK9Hsao/kMngH7kjz8VzAaDq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5AFuVtxLj2ZGEHVsOabWn8dkwcfaMm0Pv3XqhbJB+M=;
 b=0vngNYo5EhDYF1qUYPEc6ECdW0p/D5y0Wg5Z4aLBg/OTX4a7nqkyY8BlkJrmVwnuaRG3Vjz1eOd0G9Z5LG1emvXc+RFZkYrRE0mAXR2g9tG/SO3StE3kpRH8/JulQ2ZlF2T5dW5qyoLdUnDZeGX40r9l2x1ZnLGZTUDYSpze6C8=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 09:55:39 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::7d) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 09:55:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:38 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:36 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 20/48] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Wed, 16 Jul 2025 11:54:02 +0200
Message-ID: <20250716095432.81923-21-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: be9ccbd0-9cea-4b78-2396-08ddc44eeb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqspka5YDPzcJ+NRhXnW5oEIgYcWXtJhGXLsTd/GM05QFHK9VFkJQsxhVU88?=
 =?us-ascii?Q?tBM1sG1+AErfrIrM2W2Pd+PN9KClDZ48y0z9Ltn1NO2OeN7mPkrqoXGsasWz?=
 =?us-ascii?Q?6+cvF5P1Mta3TZv5/hlp5qUqWCjxluJ3nMY8Sxp+3bmaaGTrt/7HZKHPPZiZ?=
 =?us-ascii?Q?9tHOd17ygWkdSTK54H6iRysaaNyfPMB50O0GQxMU/sQm0CjY6QkwxZgg3EzV?=
 =?us-ascii?Q?7ouqIuzTqnpn4q6us4YaQKzyCZiL+dbT3bog5EiE0NYtRTqOTSadUnCaVinX?=
 =?us-ascii?Q?rj/756sp7WtuOvSb6x/Re3o212VDi3S6kdkiAdPRqSq01yD6eLSaAHdDpgRD?=
 =?us-ascii?Q?+HRrLsFYwh+N7jF1aqBaV4mi8RzUWzGZmB7lPV5kkl6/zvT0BkkqF+cT6SSL?=
 =?us-ascii?Q?8bmOAcTle27JPjcx6DlZQr5QrwnGIymyBhaXPSYBYr/YeNBfHf5HfzAbHCoy?=
 =?us-ascii?Q?t1tneKsSsNOFz3ySgAOY3iFcWaTmE7LyjLHvSO+J3x8ngr/US0ZxV5GEGW5K?=
 =?us-ascii?Q?FpMoL8YKFQRB2GnN6ZGT/NuG/dwMxsUYvCM7TImBx/6uGfLEJba9wyolaATg?=
 =?us-ascii?Q?JaugWbHlAJPY/Y/LDrJekv0WUBKV4E1cFZSdVFl+oxQKgybqVpQaMq4wtsrO?=
 =?us-ascii?Q?qVL2BP8298DCCdDJ/1glSOmUg3Q2HPtA56B2TqHmhifjxcg95JP45X2KDZf+?=
 =?us-ascii?Q?lK1df4PIC7+DIuP6RI8yjWa5amWKte0vfYR34+oKRcnmIGDPgi72BvCfMCWe?=
 =?us-ascii?Q?FtZ86WCVBY3m1CGuOdVhXD1WQ4ChYyrpJ8FJmRCqkG745NnDzgdK5nQ0BaDq?=
 =?us-ascii?Q?5J11y72sjhyv0sNLfaBbDPKulyto2cTy36G3fCLxrJP4P9D5Jw9jA9PZqoFA?=
 =?us-ascii?Q?U4dNKv/MEOjSdW4wXAjoObpOAcezveOhDRcl2Iq00HVwJxOq+u+DlVr9YYev?=
 =?us-ascii?Q?VEBEaGF9MaglXuoKNhSMSiC5XQ2dyTBISdUj5SoTt2YsxBxEO0smmibOIo1M?=
 =?us-ascii?Q?uqTd3tJKTnMfeyaUSLb2d3Dc0UgPgRqYbYs/8a7t2rWNoGgRs7eWbS8br8e2?=
 =?us-ascii?Q?JZE7b/wHltRjpS2Kcaf9rY7gLkycE6NQ/zGYXPFGY/IN4EbQcSKlz2a/XzwJ?=
 =?us-ascii?Q?lyWBOKlUOj5u6ahi9K25xLRm7lxXWo0hBcDRTj7AI4IIK8wA7bPLlSu8HK05?=
 =?us-ascii?Q?Gwg4tOqSXP72B/vdHXi9zKMlgJCJldm9144W7ze3aYuYLwkLikOlO0AAyW00?=
 =?us-ascii?Q?f4zKwSqWb1iWjxAliA0aUyiGqKkstcpeTx6kATXzdWxi+cg+RixdM7cTJoUV?=
 =?us-ascii?Q?gUyXZOVxO3l4J3CWdBtvwmIBvWhtFv6nQa0/3dc0B//Q/IGnT7LhIL+0vdww?=
 =?us-ascii?Q?UspbjP7/57SEhLwx7EljiqM/6JSdcReenpggIkQY1wOXO+7Aqm+qjBt8oMt2?=
 =?us-ascii?Q?k0mcMTocnO3EEpjQetU5fQCDEjOSgi3Oq0pXROq6k6EAHOoQNosFDA7X0RYx?=
 =?us-ascii?Q?owab+dJwhgV1PDZdQo1y45CsS/GDLEt1B5PB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:39.0530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ccbd0-9cea-4b78-2396-08ddc44eeb57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
Received-SPF: permerror client-ip=2a01:111:f403:2412::604;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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
index 01c230491df..a776ee87088 100644
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
2.50.0


