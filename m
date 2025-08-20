Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DCECA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeA3-00050X-FD; Wed, 20 Aug 2025 04:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeA1-0004ps-00; Wed, 20 Aug 2025 04:27:09 -0400
Received: from mail-bn8nam04on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2408::60e]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoe9y-00014q-Nu; Wed, 20 Aug 2025 04:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToEXj4jPzT4sWZfr1AQYk9Ptymy+vFjJ+kMoviY4YSYTwtvHSUmJyy4YYpGX7Mif7aRYyhDk1b1Coyw7bZn+9ggBLDZeQ7DI5VPENF1xzdlQqlNvyhIz3C6+tsJ0FtZjCDXGBK25aE4UIaDL8iJUOcx8qsxPsH+kFuKKiCRtsYzI2r5et6jw4PIIzGlxASopFvAuAzEqoEGDiwsGq0MCW4wRZZUurJepl75wgUZ4Km3tbDGbXztRWAZSbGwSi7VUVtft35yFu5NW/ahVnyauKtgBOL36IWubNws48SHkozxVEEwfCahQRmlOqntwRrQUc/75dGQaO+OpiB/ZsKwMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv2UYWDpHyav3RMUVeKs/q/GqkzaCxpLVPBwFpd2L10=;
 b=QKbEFuAfGbZyy+nQgnHFNuT3P1RvYpL/KSNj5ZxaqA46Yi60c6jygqCkyOSKE1C2RxYv73UtbMd3b1+8soxdCqGaZl1EqkEkgqyI1BVLTqjypAt8QhFpkJ9YnAAvxgh1BxtYe1ld4bjG71hiIUT0QI/376xSjQo/5L//yUmKJBFOYV+OCk1oYV89cxXz3En1r/61oKu0bBF2ddCO3U/Hsw/RaQZxuJhuUapgBit08bRkE0//Ho3LJyOzr3LYmnfFPWT3DZTX85BWa0FngNmxl6OjDq7QZt7VSStLtLnpJoqqXcz5xDwflmn+o4XGEBGn8KTQ94IpgWGj6LIJXmXQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv2UYWDpHyav3RMUVeKs/q/GqkzaCxpLVPBwFpd2L10=;
 b=dkC20Hi4nHnLcDwgkBTg3H1sEG2Db0/c5QaMq51PQQq2Cili8gmVERKSA6zgF4DU5o4Inwx64zr9jz0jHXzEXDEw9D8hr6RiMKtqLZhUs+pciWz5BJfMWF7nw1k+Amq9sYMFAH6Fk3icomqcX/yD4qSrkXMWf47KuNHJ71gw9Uo=
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:02 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::a5) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:00 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:26:59 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 27/47] hw/arm/xlnx-versal: ocm: refactor creation
Date: Wed, 20 Aug 2025 10:25:26 +0200
Message-ID: <20250820082549.69724-28-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: a8684141-7909-4f2a-4c28-08dddfc35681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oT+ukvE9iw1zLrGsPhoPrtqKy9JKCFoZvKbKfUVlaamI099kgkTitaJ+IGvT?=
 =?us-ascii?Q?Po4Fk5PLgrU/crs7XeiF9hKYfZMRC4Cz4QHUd2jh5nvvgKfXkAtfLNzd68ob?=
 =?us-ascii?Q?/YCnyQmE5UDZk3EHZXYq94RKwB1w8Avmqheyt0fE6MI8Db9QTGokzwsDErQr?=
 =?us-ascii?Q?3cGUmv0MM6o1Z8+VbOYnEoEgSPRh0xgXlPfKnbW4HDsa2fnFC3jksaDq4zmT?=
 =?us-ascii?Q?MUfYc4V3krVPT37OvVa2eAGyMzLNTB6A21tjI8Pr4DJ4WCLzVCB7qOo8gJ6D?=
 =?us-ascii?Q?HuhuR9VVBvo5ULvY2hssUxmB4GCZUipk/PLFNZ0fpnzI3LjwlyPmONQsg6nr?=
 =?us-ascii?Q?81IFS/0ontqWPUU64yESihRhAq5y0GJAZGRbjTAC6R1KGKemiFWiJqcX6lad?=
 =?us-ascii?Q?ziqF6SjiVcmeWjOaeKeNHLK/vJoPc9jUOZC1wotEnscOh/UI+tHskK/E6oqQ?=
 =?us-ascii?Q?NHYxCMyTMEMSq9337DT9vfdu4nNiEw+Mw8DOzAhDkADPahoM1PXS9j55YwFH?=
 =?us-ascii?Q?yOv7XU0194C3Qu3us98He5ODK9sw1JryPUBhny+Ms0J4JDuI0Lko5q8B/PIl?=
 =?us-ascii?Q?jcxfwHn9girWJ8fqfkP/mn70kMET4wvDCjC9G7vn995PrPZwihwZV/SMl8KJ?=
 =?us-ascii?Q?Ed3SJQcqUXlm3NvkzcR3eLorS63p7/2JDCEeI3yf4LHiZrvOC2LsxhCViiYB?=
 =?us-ascii?Q?9TEiYDRaBXm4VDRGvESNwFcIN9ylFR7GYQg4PFLMxilmwFXh09IpgaF5JM0Y?=
 =?us-ascii?Q?Kto0jld6+EsNmPrPcZYFkbKr7OMBMpFag1WXJs2A0rTaIJjZQsFImYRLfg0i?=
 =?us-ascii?Q?Fem1oqicKK8qcXfZ9fNivsDPwfyGu27wE6h4cMuVthvG7fNihcbKGSMsNFUk?=
 =?us-ascii?Q?3cn3+vET4eI/YQjbL8eATFRe1eF5QzSFGGhtyvQLWUeuIwQ63Xbec6wgKKp2?=
 =?us-ascii?Q?UWuM6DdwPm5ye7V3z5+mWfQmurdz8H2C01jPtIwEP1phuBkqL/QSkN8T3rk1?=
 =?us-ascii?Q?JTBWpGEeTHoNeFB2MhsBnJpNP3PR1eVbox1FersIcpl2bT0S+L3OdVBiCzfm?=
 =?us-ascii?Q?FEMK9dFabwoPMVBabeiioOcThm+Eyw/XQ8ytFOiv6XvrM+EUL6pCr4c2yMeD?=
 =?us-ascii?Q?xAYvhQHNg8sewwSQCClqy83ZFtpo7Bw8UaJi19buIIrWqRWLimJEUgQ6nNgp?=
 =?us-ascii?Q?q9BcEu/JPscN9trNhE3SFq1TT2JUMXxrqcDXhz+xmvoDeypC0j0WK0/eYDLg?=
 =?us-ascii?Q?BMLZFDu7p3snJcYr5unQGDplPQwv2ScdvDgY5qhpve11DofDWuKtI0tvIPO4?=
 =?us-ascii?Q?rbmGZ1dcrSNQJfsLMEZr/tulaDoZYedAlSdAWcf5wLEgceeG6pBOAdVtLFQP?=
 =?us-ascii?Q?IUbxO0Z8UKZhZ9yWMDRjXR8V93czss+8C8qDT4Oq3uG3OUbqOmgF6hAwZcNV?=
 =?us-ascii?Q?4X8pqouzykZciD45t0dstHKTumXiJakmiQ0pJWHicQT7OptQKJxrGoDuwRND?=
 =?us-ascii?Q?eh3hB00DdhGK2HCZTKKabYqyHC5lR9qx2Oyz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:01.8062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8684141-7909-4f2a-4c28-08dddfc35681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
Received-SPF: permerror client-ip=2a01:111:f403:2408::60e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
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

Refactor the OCM creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 include/hw/arm/xlnx-versal.h |  4 ----
 hw/arm/xlnx-versal.c         | 20 ++++++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 62b8d234ecb..7be5a6ccf4d 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -46,14 +46,10 @@ struct Versal {
     struct {
         /* 4 ranges to access DDR.  */
         MemoryRegion mr_ddr_ranges[4];
     } noc;
 
-    struct {
-        MemoryRegion mr_ocm;
-    } lpd;
-
     struct {
         uint32_t clk_25mhz;
         uint32_t clk_125mhz;
         uint32_t gic;
     } phandle;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3905549b32e..f46c73ac8e7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -71,10 +71,15 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
 typedef struct VersalSimplePeriphMap {
     uint64_t addr;
     int irq;
 } VersalSimplePeriphMap;
 
+typedef struct VersalMemMap {
+    uint64_t addr;
+    uint64_t size;
+} VersalMemMap;
+
 typedef struct VersalGicMap {
     int version;
     uint64_t dist;
     uint64_t redist;
     uint64_t cpu_iface;
@@ -108,10 +113,12 @@ typedef struct VersalCpuClusterMap {
 
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
+    VersalMemMap ocm;
+
     VersalCpuClusterMap apu;
     VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
@@ -207,10 +214,15 @@ typedef struct VersalMap {
         int irq_num;
     } reserved;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
+    .ocm = {
+        .addr = 0xfffc0000,
+        .size = 0x40000,
+    },
+
     .apu = {
         .name = "apu",
         .cpu_model = ARM_CPU_TYPE_NAME("cortex-a72"),
         .num_cluster = 1,
         .num_core = 2,
@@ -1605,10 +1617,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
+    MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
@@ -1678,14 +1691,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
     versal_map_ddr(s);
     versal_unimp(s);
 
     /* Create the On Chip Memory (OCM).  */
-    memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
-                           MM_OCM_SIZE, &error_fatal);
-
-    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
+    ocm = g_new(MemoryRegion, 1);
+    memory_region_init_ram(ocm, OBJECT(s), "ocm", map->ocm.size, &error_fatal);
+    memory_region_add_subregion_overlap(&s->mr_ps, map->ocm.addr, ocm, 0);
 }
 
 void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
 {
     DeviceState *sdhci, *card;
-- 
2.50.1


