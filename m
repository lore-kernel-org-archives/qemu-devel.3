Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4139BCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zv-0003GQ-NJ; Thu, 21 Aug 2025 09:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z0-00025Q-9J; Thu, 21 Aug 2025 09:05:36 -0400
Received: from mail-mw2nam10on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2412::602]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yr-0003DN-7b; Thu, 21 Aug 2025 09:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7rAeOpIO9a0UgpcOZr5Y9y0h+IU4SmKd3rv3Nq3fqK+HC2LiOiGGJt4kh6DxWveD545IzpL6FTxPETgGqYuPUkWN2ObD1TTJfsqEYyAjFF0E87mvoWre3YduxjTGTC2NKZp6plom8xFwKUQYFaEW+ykIA73K6TLQSfxMcI/6jgkjWhxZYjtXzm6ZvT2KuUIBalwo9Q7vvxSk0eisIkrSDMS9MaCZS1nOTyqH9Q220QANaj8TWmnBnjqKER7OuGSatkdQwO05Pzfv9SNU1kzcqjjDzEE31l6V3FisVP288LZ766vgh0U7Z5HI5sKQUxoi4rcGQpojr+hRjDXfClTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+JIbt3HqtDcatv5sKsOyQzbaUFBEe1ELOCySLRv3J4=;
 b=OBt07gw8a6uZUwKCuxI8IzuYveJzHNK+rr4CkV7d7F4q3DvCh/50wZ5e/Jk0G4/Q80CRn7gn+yH+DRAqcj83rWQPptY9Hl+XraFPOpbiPd98i/VwoiUPdNGaoVJawVe/lNp2XIi+6lD0Qn7/MwOEw6q2pJhns0G3VFhK8hIPnowmE9+28fEh5vmnolBVXJpEWSxvKjWjqmD5YKJ02ev8d/IytV/ymlvDXt9ZgoInNQATVLzAh8X30FJUUmoYV8u2KqUyZYxBPMx9D6+/ZFn2f9UwcYjcncotoRKWoGwGNQ7VfRv7G8OVEqGNGqQPjWO3kSjRcyiZ7vml9a5NgajgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+JIbt3HqtDcatv5sKsOyQzbaUFBEe1ELOCySLRv3J4=;
 b=EbhWh5CmadkMblV9Z61I79xRlPL9vrMWoDua4XWydPN8vvtX0YwXuhI9DByvoGHgEjH1w8TA362tCcHkC+mtoVybe/ZDWU32TA8OW/VbhDxSGsC/NwbGUOkRyLoJ6B4OkbzsI2MN4/FAPsZkC1ceOOXMQ61lU1+JbLL75KSpQsQ=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 13:05:16 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::f1) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:55 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:53 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 28/47] hw/arm/xlnx-versal: ddr: refactor creation
Date: Thu, 21 Aug 2025 15:03:27 +0200
Message-ID: <20250821130354.125971-29-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 022e971c-f3fe-42dc-60c3-08dde0b35f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?57xuWx7zoZpKz6lybu6jvWK3FKFCK7J1XUT8U8b6LvSD8cRvDhxqKMWsMbiT?=
 =?us-ascii?Q?2MBFM8EgqAccZjT28XSxXJYii18WPtm+A3vVMcUTPdQbWYqIx7uMi+BShdjO?=
 =?us-ascii?Q?ARoWKE/mI2belbkHZy8Xu3G6nm/zlBonFw36PKW8p1F9VAjHGAVK5j+k60mo?=
 =?us-ascii?Q?OPodIqEdmch0a/wSpRqZt9fnvU6jxDFmjgLKPKK+k5KY/0fcSbqgWPN19e0g?=
 =?us-ascii?Q?57BlimqK1NqwQ8RNLAfysr+5attFN3bQDVoBlW5A3Wj5K/dNXonRigWRTp7T?=
 =?us-ascii?Q?Z7HMouqez0sy7glyKnS5s1ccrteqUMDnAsyn3MOn4fQ3ixAWQ3xnWNyFYq+0?=
 =?us-ascii?Q?iL5xasDFQTbw4FQeoS7jmMasBgjnzvLuO0fJ4a6exOzpDD11cKl43MFhrzfW?=
 =?us-ascii?Q?0lNefTQDLuzTBaf/8Q3nTBBR7cdL7y/V9TUP48eJdDI2KTAzE0UhVQq6hpdX?=
 =?us-ascii?Q?Kn02m5DJDyVM+gDkmDTK6pqtDD6g7WoV2HvFkk4zz4kQdUr6sPvoM0WZ5QPL?=
 =?us-ascii?Q?nRO0Eb+Q5rRF9tFqz9APKYUHnDX67+GR7Msw69DpY8EiVFJF49sQEKdoU8FE?=
 =?us-ascii?Q?PAOf7KxhGnMihAk/Eo/Tg26Z/KPXOEwmEc/C93NPlNnR4+e2Yk0zboAfXzTd?=
 =?us-ascii?Q?fRbt4uQ4TVk3bSNz+ypI24cch86TwW8Bly0wicRFPE9YPvGMG5HMT07PfaYh?=
 =?us-ascii?Q?X4/OKKNLTZw43yhyB5XftBJWnRxCGHRCS5WEZeUeJ3Q2mRJMehZO5dl/XR0g?=
 =?us-ascii?Q?qJQ1hroCZLuDZy2eloopxE3uE76YINYEGELLYwKOTkMoP8kVPvmQI9MwutWA?=
 =?us-ascii?Q?lfnqcotEaGsznv9cUymHcEmAwKwC5RzOxw1xIV5XA3xro1mPuqajm/lvdUx1?=
 =?us-ascii?Q?ZLaCVGSFIE1B0TNaTcl6B0xI6OP+SzotLmylTjcZD+xSeWKJ/N51J2szajEy?=
 =?us-ascii?Q?OG2a6Qo6YXWcJ9TU+Eb08W1Rr9AJtVEHl7L3isOBdqvGQigNkXPBJ0R798eC?=
 =?us-ascii?Q?Fsmsn2ZTBYTZyUj+SiE4jAfGW0+YHTemnUPCkUl43xYY6sYhg4ufkLFklSJq?=
 =?us-ascii?Q?ChoV4G0Dr0p1Web/xBqCN20s7qa6sndOqkMol+bpS3PtJN00aX9RRSEiFp0D?=
 =?us-ascii?Q?k/A9hCEf+Bx8X/C/BAlKMxFOYVdMvtrd0U9ci7ig27l9uTaE7HEgkVb21z6v?=
 =?us-ascii?Q?cd7EF7oNcwF2RftXMVwmHkubXJBdGGalXsAF+4cyTJgocBNsc0oSCTGX6fyV?=
 =?us-ascii?Q?rUzAvxYcyHJEG7vz+l89gt7LJU3tqcxiNe5wIq0AYTfhiZ2TPnUvm2u2zXAG?=
 =?us-ascii?Q?I576rIB+OyZXjMBVHdp0jWqEyGWtykydFrdlm6Lt7xPMIYZSUcD60++/14c7?=
 =?us-ascii?Q?pYG1xImoEJFQqRW5IoMKa5fb+WQvZVnbLgmIQye+zHw1RXDN9QaA16WiZSxC?=
 =?us-ascii?Q?PdJvNKCebUVEL5ePM6YoPiilFpNeBUz+5iHpBmzJKot99oFPtfZMLn6O3Str?=
 =?us-ascii?Q?FRC2QbY7tSnoKUtyyfIy52OG2ufZp4fn6yu1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:16.3316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022e971c-f3fe-42dc-60c3-08dde0b35f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
Received-SPF: permerror client-ip=2a01:111:f403:2412::602;
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

Refactor the DDR aperture regions creation using the VersalMap
structure. Device creation and FDT node creation are split into two
functions because the later must happen during ARM virtual bootloader
modify_dtb callback.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  7 +---
 hw/arm/xlnx-versal-virt.c    | 79 +-----------------------------------
 hw/arm/xlnx-versal.c         | 73 ++++++++++++++++++++++-----------
 3 files changed, 53 insertions(+), 106 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index e1d6e545495..39bc414c85c 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -41,15 +41,10 @@ struct Versal {
 
     /*< public >*/
     GArray *intc;
     MemoryRegion mr_ps;
 
-    struct {
-        /* 4 ranges to access DDR.  */
-        MemoryRegion mr_ddr_ranges[4];
-    } noc;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
         uint32_t gic;
     } phandle;
@@ -71,10 +66,12 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
 {
     g_assert(!qdev_is_realized(DEVICE(s)));
     s->cfg.fdt = fdt;
 }
 
+void versal_fdt_add_memory_nodes(Versal *s, uint64_t ram_size);
+
 DeviceState *versal_get_boot_cpu(Versal *s);
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
 void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
 void versal_bbram_attach_drive(Versal *s, BlockBackend *blk);
 void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index a3945625014..9490c625816 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -104,92 +104,17 @@ static void fdt_nop_memory_nodes(void *fdt, Error **errp)
         n++;
     }
     g_strfreev(node_path);
 }
 
-static void fdt_add_memory_nodes(VersalVirt *s, void *fdt, uint64_t ram_size)
-{
-    /* Describes the various split DDR access regions.  */
-    static const struct {
-        uint64_t base;
-        uint64_t size;
-    } addr_ranges[] = {
-        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
-        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
-        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
-        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
-    };
-    uint64_t mem_reg_prop[8] = {0};
-    uint64_t size = ram_size;
-    Error *err = NULL;
-    char *name;
-    int i;
-
-    fdt_nop_memory_nodes(fdt, &err);
-    if (err) {
-        error_report_err(err);
-        return;
-    }
-
-    name = g_strdup_printf("/memory@%x", MM_TOP_DDR);
-    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
-        uint64_t mapsize;
-
-        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
-
-        mem_reg_prop[i * 2] = addr_ranges[i].base;
-        mem_reg_prop[i * 2 + 1] = mapsize;
-        size -= mapsize;
-    }
-    qemu_fdt_add_subnode(fdt, name);
-    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
-
-    switch (i) {
-    case 1:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1]);
-        break;
-    case 2:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3]);
-        break;
-    case 3:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3],
-                                     2, mem_reg_prop[4],
-                                     2, mem_reg_prop[5]);
-        break;
-    case 4:
-        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
-                                     2, mem_reg_prop[0],
-                                     2, mem_reg_prop[1],
-                                     2, mem_reg_prop[2],
-                                     2, mem_reg_prop[3],
-                                     2, mem_reg_prop[4],
-                                     2, mem_reg_prop[5],
-                                     2, mem_reg_prop[6],
-                                     2, mem_reg_prop[7]);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    g_free(name);
-}
-
 static void versal_virt_modify_dtb(const struct arm_boot_info *binfo,
                                     void *fdt)
 {
     VersalVirt *s = container_of(binfo, VersalVirt, binfo);
 
-    fdt_add_memory_nodes(s, fdt, binfo->ram_size);
+    fdt_nop_memory_nodes(s->fdt, &error_abort);
+    versal_fdt_add_memory_nodes(&s->soc, binfo->ram_size);
 }
 
 static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
                                   int *fdt_size)
 {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 367e6ba5458..00cea784442 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -113,10 +113,15 @@ typedef struct VersalCpuClusterMap {
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
     VersalMemMap ocm;
 
+    struct VersalDDRMap {
+        VersalMemMap chan[4];
+        size_t num_chan;
+    } ddr;
+
     VersalCpuClusterMap apu;
     VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
@@ -217,10 +222,18 @@ static const VersalMap VERSAL_MAP = {
     .ocm = {
         .addr = 0xfffc0000,
         .size = 0x40000,
     },
 
+    .ddr = {
+        .chan[0] = { .addr = 0x0, .size = 2 * GiB },
+        .chan[1] = { .addr = 0x800000000ull, .size = 32 * GiB },
+        .chan[2] = { .addr = 0xc00000000ull, .size = 256 * GiB },
+        .chan[3] = { .addr = 0x10000000000ull, .size = 734 * GiB },
+        .num_chan = 4,
+    },
+
     .apu = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
         .num_cluster = 1,
         .num_core = 2,
@@ -1475,50 +1488,62 @@ static inline void versal_create_crl(Versal *s)
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
     versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
-/* This takes the board allocated linear DDR memory and creates aliases
+/*
+ * This takes the board allocated linear DDR memory and creates aliases
  * for each split DDR range/aperture on the Versal address map.
  */
-static void versal_map_ddr(Versal *s)
+static void versal_map_ddr(Versal *s, const struct VersalDDRMap *map)
 {
     uint64_t size = memory_region_size(s->cfg.mr_ddr);
-    /* Describes the various split DDR access regions.  */
-    static const struct {
-        uint64_t base;
-        uint64_t size;
-    } addr_ranges[] = {
-        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
-        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
-        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
-        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
-    };
     uint64_t offset = 0;
     int i;
 
-    assert(ARRAY_SIZE(addr_ranges) == ARRAY_SIZE(s->noc.mr_ddr_ranges));
-    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
-        char *name;
+    for (i = 0; i < map->num_chan && size; i++) {
         uint64_t mapsize;
+        MemoryRegion *alias;
+
+        mapsize = MIN(size, map->chan[i].size);
 
-        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
-        name = g_strdup_printf("noc-ddr-range%d", i);
         /* Create the MR alias.  */
-        memory_region_init_alias(&s->noc.mr_ddr_ranges[i], OBJECT(s),
-                                 name, s->cfg.mr_ddr,
-                                 offset, mapsize);
+        alias = g_new(MemoryRegion, 1);
+        memory_region_init_alias(alias, OBJECT(s), "noc-ddr-range",
+                                 s->cfg.mr_ddr, offset, mapsize);
 
         /* Map it onto the NoC MR.  */
-        memory_region_add_subregion(&s->mr_ps, addr_ranges[i].base,
-                                    &s->noc.mr_ddr_ranges[i]);
+        memory_region_add_subregion(&s->mr_ps, map->chan[i].addr, alias);
         offset += mapsize;
         size -= mapsize;
-        g_free(name);
     }
 }
 
+void versal_fdt_add_memory_nodes(Versal *s, uint64_t size)
+{
+    const struct VersalDDRMap *map = &versal_get_map(s)->ddr;
+    g_autofree char *node;
+    g_autofree uint64_t *reg;
+    int i;
+
+    reg = g_new(uint64_t, map->num_chan * 2);
+
+    for (i = 0; i < map->num_chan && size; i++) {
+        uint64_t mapsize;
+
+        mapsize = MIN(size, map->chan[i].size);
+
+        reg[i * 2] = cpu_to_be64(map->chan[i].addr);
+        reg[i * 2 + 1] = cpu_to_be64(mapsize);
+
+        size -= mapsize;
+    }
+
+    node = versal_fdt_add_subnode(s, "/memory", 0, "memory", sizeof("memory"));
+    qemu_fdt_setprop(s->cfg.fdt, node, "reg", reg, sizeof(uint64_t) * i * 2);
+}
+
 static void versal_unimp_area(Versal *s, const char *name,
                                 MemoryRegion *mr,
                                 hwaddr base, hwaddr size)
 {
     DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
@@ -1682,11 +1707,11 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
     versal_create_crl(s);
 
-    versal_map_ddr(s);
+    versal_map_ddr(s, &map->ddr);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
     ocm = g_new(MemoryRegion, 1);
     memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
-- 
2.50.1


