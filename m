Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D8EC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyt6-00062u-9d; Wed, 16 Jul 2025 05:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubys3-0001uQ-CS; Wed, 16 Jul 2025 05:56:16 -0400
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubyrr-0006gL-PH; Wed, 16 Jul 2025 05:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH7SVvr+QiNFkQExS/CVFixBgIyBgRao9ay4H3P0djkmaC791P0n++rCtipxcShs6iVdlNBHy88Z4Ua+cZ2tWSBopeEg/YxeH8LCd5M5/dfrL90iy4OMzSY9LulFC9WYSqCrq2ge1hPDh8/KmxX0MfupS6W6fmPCk9aE6l37kT7yINdp9cbo6+z4adjxwUXiU0O3scTpLJ/3yvMGqQo2XDbEiO1tksGEj1i8PliEFwqFJGoS+tKZcyGn2ctVWyM93dxtfexRpDt3UbCKzPweDqpbVkCJa6VdR2tzxunIb+1ShO8ejc31CvShboF1QB7vje6FeRxHPXKmPrKNgHe6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x75o8FBJYIRH27LfqYCoeqU9S6GRfNFgKMUYTzlYDmk=;
 b=ZIRe8ULfq90tkt4qA/c+Iqj1+EpeqVjl2kkF2lauEL3JrKMG8JxuWJ0r4rwgTZyRh4Ld7kMd784f5OsfWiZZxLkr99yNJTuEbDiE5YWkmqezP9718NJDGDATYF+ZayS4IBuxY2gQVNjkjOG5gzH5HiYEMZ0hdN8pjJPTzHbN9Y33SUrDbXgahRTu1GtwnJkQvWI0O4+Fu6gIFsIpu+kekMz6GH+rEQzBx+Xu8bQ0ZJbQYbQs3PUu/EH+6v+zDe+NrT5w9mfVirCAKhQNAurLtLbFJ12Po3E0/ZxtK78IUT4mckuzqvssrqK8uUiybLrXxG7P4WgE5P71x3NJIxgr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x75o8FBJYIRH27LfqYCoeqU9S6GRfNFgKMUYTzlYDmk=;
 b=eM48A6vbVHinxHyzKW/402QOWU3DPuEntqRZBuVpDoRXn1Fq9+weE+qCfjll+3p22AstKsoUOKUqaezuiFvNmyAHF8VA2G+RNZl9hBaOyqwZU+KUOhqJzJfaJouKFUX0sb6PCEPG/8C5cQMwkkbFFkT+WxmcH+OCN2e8ZxdVBEk=
Received: from DM5PR08CA0040.namprd08.prod.outlook.com (2603:10b6:4:60::29) by
 PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.27; Wed, 16 Jul 2025 09:55:55 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::bc) by DM5PR08CA0040.outlook.office365.com
 (2603:10b6:4:60::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 09:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:55:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:55:54 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:55:53 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 28/48] hw/arm/xlnx-versal: ocm: refactor creation
Date: Wed, 16 Jul 2025 11:54:10 +0200
Message-ID: <20250716095432.81923-29-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a51739-611a-4f29-3716-08ddc44ef525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZhyKOjoXQosMbWysNfgDiSvMHen3a3WhOXwX4LXtglYHUGbxHfDT3DwQE2cV?=
 =?us-ascii?Q?DZakP3lNe9WHE2sa0mF7ZCRJDRMD78024PfdasJgdYluO1yrGzuCi/8SLliN?=
 =?us-ascii?Q?hmJiUsu7kLa96k1bNCNu/yW3KhxwdwSygNQZIRCjY1jqlQlMd/GvdbMTQn1l?=
 =?us-ascii?Q?SVe94g+vkym3o1yQ833NohpoPrcC/m2AHBKXMEyd91a2r0PkSbdGMqwS7sb9?=
 =?us-ascii?Q?838XHxKZn5TePPc9tnL9wmu+dmpCgy7wBy8Tzx7RUXsR02zpjJrjAtkcRDWw?=
 =?us-ascii?Q?+vuAmc/CVaYPuZ8n3lHajICP90M2nmptmCD/4fMegBu7c8plWf/CnxtjO3OR?=
 =?us-ascii?Q?QUkeHIqmPEQMB81RxAwPd4IgLzhK6rBzCoHAMmgN20KWMyXo3ijzUErpSBnb?=
 =?us-ascii?Q?sv1VIYoB0XuDunLvdEnkIGg7WSYFrSE9t1BSV3bGIzlgKDeAsMf76gx7F9sz?=
 =?us-ascii?Q?aoIM8LbfftESbUXb2CWem3al3MtvnNrHo5Mg+yY5xlITzhlM97PbxGy8wuNZ?=
 =?us-ascii?Q?iwAYXVsVaXgDcywMMw8456/8/X+mrWwS4G9iamx7yIygek18CHyt5NlPx/Fd?=
 =?us-ascii?Q?47wF9tXfn+anB76b7HakKppCAokC7qYKQTF4RvIn6ZzX+b7XOy1TtG1wNH/I?=
 =?us-ascii?Q?ZVw0yDsNCkzyKKeZ/NT1Rtp6rlwhHisyq16sUD5m3i8akMNLoVQ4lUeAUNyo?=
 =?us-ascii?Q?a/+Gi0st0ZWBR29sChcmql2X78eWG7FH7twoBPKIOFuxFhatdZfuuyku5aAr?=
 =?us-ascii?Q?9P7ioOfe0CyUFwtBBCAhtTwZyHXByfZ1ToTWa9gfX1jNqutxdSXBZkgcshBT?=
 =?us-ascii?Q?aGuaS+n7QmOn+Cmgm/xM8r/kPeBeFlzKdiv40pPqIvuXI1GXLCp2E4MxOLqC?=
 =?us-ascii?Q?jFjtwPTUQnIEZ9uaAYG/gaNUpTu9EwX+xFHzO4wdqsHR7yMd/kmE3d2bGwwT?=
 =?us-ascii?Q?P6mXt1psUl9B5AS0hcE1oeuNjJCMQmCou6biXWNpoOpdXnX4ruo14uoGiDP+?=
 =?us-ascii?Q?xtFx71Cz7G2cEClILj1vj06grigNF85eDXXPLKzgpDr5NLV7vDKMD0Rq5ug8?=
 =?us-ascii?Q?1QIYSXvnM5r2+AurRHstwraXcVCiBul+Mw2SqQqeBBRozciBojUCmf0WGYF8?=
 =?us-ascii?Q?2CJo9DX4FAxc4vauVa+9Np6SDdyh9L/V/4oHE17vOSmeJQo8L05dyF5Wh1gd?=
 =?us-ascii?Q?GivImGSeunxN3qYyLzCyoGZF1Os7DmmnxjZIYfwz+sGh9SXKvUbhJt5/Gl1J?=
 =?us-ascii?Q?MzOplrxTbO1AJac3Qzq2Hai2tuwtYxJGcjoSS1kbr7Ma6Fc4Ty2kTdt9aBlV?=
 =?us-ascii?Q?In/Yu/x0G13pcPTyOozE1rlKQhPIuUdrZ5UGnsgZWqFF247kprHB++SeOH57?=
 =?us-ascii?Q?cIfBUl9LdtgdhByUkL3/3aDcUOkIL5esKkeCx+felsltgzcUDzd/6+dPA8D/?=
 =?us-ascii?Q?B6IWTXJZmuEIweJ33+6wOjnUlyXoEoGvNAJVpKAKvl6c/v/TCau0qJlhPYL3?=
 =?us-ascii?Q?wUYgbVUTAb9CwPM/3mPyqVJk9Bj3M073zAJc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:55:55.5076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a51739-611a-4f29-3716-08ddc44ef525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
Received-SPF: permerror client-ip=2a01:111:f403:200a::60b;
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

Refactor the OCM creation using the VersalMap structure.

Signed-off-by: Luc Michel <luc.michel@amd.com>
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
2.50.0


