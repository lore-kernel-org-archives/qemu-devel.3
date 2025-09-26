Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB04ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22aA-0006RR-74; Fri, 26 Sep 2025 03:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22a1-0006Le-QK; Fri, 26 Sep 2025 03:09:23 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22Zu-0006bf-5r; Fri, 26 Sep 2025 03:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsOps720Att9NEEXhWtGjL624DoRlWxPV/me3MoEM0G8xXBlygUxyFBZB9HDouUL0r7eHrrSsaqYzsSSsrWdvovpFSPt19Cu3ff2L01GGEs8PRLZOZ/35YcHOp3L85HP83Z1QUrZG1EbQdBpSfdPKYXnpaflliM9uz9uJaM0ZJfMRwLnT1LShE7OGqqqMhGlegX1FFvJoHgqNnufJw9sv82wpoJ1Mu654m362TMjK8gAk+Z8DzwooOgKtPyezZRle6w2zo7zsstnAYbPm9eHyrfgSllMzHsHSLmeBWPcw6tpkysoqqLOe/VmbPC5l86X44kfTWl9CvYW9f2XC+XIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gadKaeJ/f7w4JPTOyWky6OIoIq4ZZqOmtIve2XdLdI=;
 b=TAZ3XL8Zn6po8GZStaMmnk/tjAWFN4gD8qOxnjEt+H8Inj54lIoa95BUtajOz8If4WWODf7xsEwNgkp+TUZBYWJt5G6RHlEZbizFxq/UBuOcEeor3pdKdsydcua5tol/dSx1SrLAZ1kdnhvHEJho3OtWn7mgX7Uztw1H/iO4803hpAXc5BcbSqgfsCXBUwfbgT4Qh4Oq6HMTfz6D3H3ArcWcoSIglSpy3lNDrEGYZpQ3xsHTj5/O4nypEJ7zWlUc0JuTWtl5PNqW2mPMhFFa+RdZf5qjxCOUCQX1r87Ng5FYnt4Jsm66sFUuXFJMCwH+NtFPVtALSiAmQpkP2LBLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gadKaeJ/f7w4JPTOyWky6OIoIq4ZZqOmtIve2XdLdI=;
 b=R/UJO9c966MT7wknVW/cc8Ha+IuCkqOMvL7TYXbUIN15sIQ1KXRmyinykhc3pRtHVrhvHxFBtxtO7/uGL/amq/US1r2ZkTfw+z43FbKJW42SebdXhtaO09O6VQyYORtXOmx05jRK4/JIjdIOKQ+L7ksQQxGcXFipdd8aI/HO9MU=
Received: from SN6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:805:66::31)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:08:58 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:66:cafe::fa) by SN6PR08CA0018.outlook.office365.com
 (2603:10b6:805:66::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 07:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:08:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:08:47 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:08:46 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:45 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 19/47] hw/arm/xlnx-versal-virt: virtio: refactor creation
Date: Fri, 26 Sep 2025 09:07:37 +0200
Message-ID: <20250926070806.292065-20-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc7017b-66fe-4d22-330e-08ddfccb902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O0r3QvR2oIgyNbiwDsl8pvtC2AEkoN3jc5MWVALaGoue4373KU5P+R2OaYSe?=
 =?us-ascii?Q?RcDSBihLD6xaRZmwmfttGYYrGYPvIUDiGiYWOmPkX7sX7wbpsJnvJg+e+CV1?=
 =?us-ascii?Q?/zrhg8sNt0Om546Y0jJFq+jJXm56S0NUuWam4IUmcZTRLeefYr85PS0foNC3?=
 =?us-ascii?Q?ak92tcrsK87iDJ96YrD34vHO+0pZC+V4G3Mu/P6YAwNYyPJQJ3etbcUpvGas?=
 =?us-ascii?Q?A1jbftD1AGtjJRs9lwF/uJl4449F7or5Ru1V1y8ht7HnGMfBtHvAZ3aa0uqN?=
 =?us-ascii?Q?Ic96bCOUumVFxcfGAPiLlT7KVckMaqkkCLdFxRal4vl0LdQB/wY7vUf4AnUH?=
 =?us-ascii?Q?HPWbWg85vvKedGbDCC0N5ON87A6KaOOIGCVjHUrDON6jyk+fc/u4jg/WkiCT?=
 =?us-ascii?Q?n4A6b98NC1qsTnPDjpJ5ofJwGhJPUD4/zIx9RVnZEeigWOS/i4wMa+RpGnhd?=
 =?us-ascii?Q?CLVateuxNjFyYkauOKa+NVPRIMXKjO0ZvTuKCO9Ay6EDf18hQNeNtOx0pgWP?=
 =?us-ascii?Q?nAfqnRMzIKYQAslAuZxbnVt/a5udr/1hsqk3G8A9rbeqHvjiKVsb22Yr0ItU?=
 =?us-ascii?Q?HajgDMNLwl6j3JM1lA3/LdOREbKrYqdYrT5DjGd4tYO2HqZe6tTVRYQRavP5?=
 =?us-ascii?Q?QrScMyjoOAm0gmPIttcf34QfX22qQhg0/Ucv5z8amqfzL5c0o+LPk4P6ni69?=
 =?us-ascii?Q?zFYqr+cUoYccu67mKlBvyd9ymebKtJqBhXDQfVJdG0RSdLrDJ9OAa8Nz3vx9?=
 =?us-ascii?Q?tmoNhbdPHSfbSXUyCvkCUCma3OYjaXfR/O02yjKEFlND1EbDS8MWxISIXpvE?=
 =?us-ascii?Q?IGhLEMufz41kLwDxDqkUZLxNH1xfNuG/6k4Mty3zh/PWQuXj8r28QnWe4Y6A?=
 =?us-ascii?Q?ymRjd5Rtl8wLqSF8mhGWlOmpto4Tvho+w1/TIDknvWaqx/dUBjwkWVPRcefn?=
 =?us-ascii?Q?CxrhvpjnxRBIvxOS5sl6pdMqlFU/yA55nNSmFJMUfI0Pz/KLoJWAo0od8AJp?=
 =?us-ascii?Q?7Lbgj7TRZjG8UHSzrcpYJNeFL/qwFaKLCFcZotvWdloi1nehS+c6JqhAFp7Q?=
 =?us-ascii?Q?2KzPCP/KBYe74PZICVHjEw2KDoz9aKlyhWSMtpSxr/MaedLcsJI7dBfd1nuq?=
 =?us-ascii?Q?7y0s6eCvyhsWutRdwv0diRfagg7VM/W0cdEBNSrC9SW69bOdhtqBiFJZnLii?=
 =?us-ascii?Q?Gjf1AcO4NfEU2MpueuhL4cFu9uZYVXwcicgAyLTzH8DEnChjB0+ukwhEsNKT?=
 =?us-ascii?Q?IqkIk4FE0UTh6tcfzugkCPr+0+YkefXeoPISmmhs0fvl3bgIATuslFgJECyG?=
 =?us-ascii?Q?YHP/QYG9VIVE76YTm0li48PJ2VJW+NnH7fx6s3hgaAbBubqlNpNShZrYZzNW?=
 =?us-ascii?Q?Tj81ljJG3HyhuXqZmxGGCePGYadXAkoP9P+9R8Gb7LEunPbonLNAadIjXuHx?=
 =?us-ascii?Q?IUwhCh6rGhyPFlueFo/z1MQQqruXEC3E8/5p1mryrzYdZ6M33OUgQ4HJlE9K?=
 =?us-ascii?Q?kTtd/ZOZRDgXC7VZBK81++9ZXldQaCLPZR3f+Pr07ZSGUFxv7eg3pfMWz1Pl?=
 =?us-ascii?Q?Fcm8oc+pSX4PfqvIs5E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:08:58.3329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc7017b-66fe-4d22-330e-08ddfccb902e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Luc.Michel@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index f5f98a3030d..23aac709dc4 100644
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
@@ -1420,10 +1429,27 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
 
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
2.51.0


