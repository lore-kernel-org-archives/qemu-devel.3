Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8D1CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXN-00010O-74; Fri, 22 Aug 2025 11:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWX-00087r-FF; Fri, 22 Aug 2025 11:18:02 -0400
Received: from mail-co1nam11on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2416::631]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWH-0007DO-NV; Fri, 22 Aug 2025 11:17:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ+BDpHxlniymzTa5pz7Dkr1MpQkYi86BPI5dLgX1Kvy0FG1U9hpnSeuV/QTHSYF8Ng7TUK68oUwBD3ug+e6LUT/zLfLdd3mrzQ7PaCM6kznNRWPem69ZEi/k5S+13+1Tkks/WNOFpvx/hCm164dTPd01TLevqSGRWOaTiph3KmqhQI2doy0S+toBO4SWgC64ZZd2v5oEW9KVjcfJSbquivXba/IbfziLI96FRvf996xrJ7M9JMQNOC2G7qKytRJJrgUwjm1OaSTP1NSDCN2aHGqzbNC3IL4K/Zm+K7sd2IKzldXgyuODTLAgXoOdqtKiP9Aa0fY3btD3eC24sMYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2+pIIGgZBX8/uEu7/iRvfupHXqcKqzBFWJzJLrfANo=;
 b=jhXjBZ1I1nPKi75kUdohI9TuKfRLAASEeFe0Fn1hYDpy+LOQRvAM1C7qkIo0SQudJO6lpleZqkq6cedz+r+BuR7wqAiLVrrwCYHnrCAbnG6n4Lh+UHtKtvzji3QAhldn5usX7zmmCbBCP75T/4dAuaXcch65T/hJ9U5pSoPWmcCHfvgX3kXp4cUFL1TbHwuxFnzZzS+H0oBDreh3oHZY4Ca2gi1cgvdAS2fHiyZiGXlSIKkCDFnX9JSjDzQoWABZfXIeWIz0Wv9JjBeVd8jGymSXVRSYpldtJj/QWE3cENEa/A0m8lNW2yaAngC5mDFrBVouWePwBCE6IJg7gkkAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2+pIIGgZBX8/uEu7/iRvfupHXqcKqzBFWJzJLrfANo=;
 b=wIbS3K/j6hZIF8H2NEQVGZW46vlKW/hXf2GRWgpcudbon8uS9HJaDSJfkbOigzAwFG8Y/Ak3UWmaBrA+vdnE7gx3BCbp/WjeXnakqga0aCyLZKxVTxuFLNh/rbG6flUdjPZy6IDWWRz1S4ibwkjCxZ7ScksoooS1JZbzEHclv3Y=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by IA4PR12MB9764.namprd12.prod.outlook.com (2603:10b6:208:5d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:24 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::2c) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:18 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:17 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 27/47] hw/arm/xlnx-versal: ocm: refactor creation
Date: Fri, 22 Aug 2025 17:15:52 +0200
Message-ID: <20250822151614.187856-28-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|IA4PR12MB9764:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ed3aae-f3b6-4ee3-b76d-08dde18eff53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OVOMKftq7ho5cHZHPoQjZOH8FZcxWS8/j6A3Ip8zPUNrZZFfj+8VsPeYkR73?=
 =?us-ascii?Q?U7sun3KXD/Gf2L7kw2ZsiV+qTzz+OTm106ucAq2NaUgxjRSxMr60RGZim/X/?=
 =?us-ascii?Q?xlWnMxecEpfQgtAXCnUnKzAxzv0Hfx0t84UiCt0K6dAaKM3ns8lj58B4n0AZ?=
 =?us-ascii?Q?tWFCkAWeC2HESHslmnxzVteWaIwuj7Aku9cF09+pHMyLRZMYHu6KHR1BaQhH?=
 =?us-ascii?Q?FfNXyXG3d/ZW8kAnBf6mjojdb3JrtzQGiinz2PmIFV4JSOt/Vp843yEWWxfl?=
 =?us-ascii?Q?MYulXp2PCxqdsmAQ1k1KHfGq6prAwMsfXodDojog4jK77wClM0hXDSlgF8g2?=
 =?us-ascii?Q?Pjest3R/P5kI17QulVCDFkHJ8OIApKP9N/VbWB9rMeKclMzIiDeaXS45qBaC?=
 =?us-ascii?Q?p68TnFFUxNqd3/YEogKeh15hO4EAbjUfjaZeggxp48IdCQzlLc9pDNF50cGH?=
 =?us-ascii?Q?TrRtBgC7ObR6gfBQ3TvWEv2FpxBPZamRRIoFdJ5ur9v9LSX5Mhp1GSiyobfF?=
 =?us-ascii?Q?kE8z7tmW8qgrzticgGFsC3jeahV8G2aA18Vxta4QYnndsde/uofTqRjcFsBw?=
 =?us-ascii?Q?ZTsze1lLsW/vMDNHfSB4oaaC14KNcoAFiAkbweELAceezJKNMgXi3onRsIWY?=
 =?us-ascii?Q?H+/cHjey3gQg3c+wcWKuyeeHpVeCgI/1IoyeKsBA3DMBGBnsnoVwwzdz206K?=
 =?us-ascii?Q?IBtUAaNzsYmUCBuvJVSwOa1vGYX03hQ6RxG+bbhF8m7uQhzaegyiTqNKiKiY?=
 =?us-ascii?Q?vp5ilcASgV6eukyF60pxnPYbdaYYrfJJgkiVfzq107jwJjokQEK+F9QheBof?=
 =?us-ascii?Q?zQ/rk9fQzEHN/D0arTZJ06zTxhAncPMkXwa0VumVpkz+tgYbGxckKG+cVNpr?=
 =?us-ascii?Q?Ihg7CI79manF52V+fN9+SRh7+vY0lUviSAfDq10/cly/ektvEHlWXhjifLHI?=
 =?us-ascii?Q?wH5YYwCOi6x1JqZZyb1zVXHf69iNfAJ3y/X5bDXyF8j78UHQHXQYxBH1cjdQ?=
 =?us-ascii?Q?ZSpm7DKu5wsfiAeOjI9wRRpI9eBXgO10U0Ubih0iGu/PUap7qNuR0/8WechJ?=
 =?us-ascii?Q?9JqhC6KGBY9ftf+XBf9D9TV7dU2y5BhveKaPNX2OTWTdykUq6OBjlJCitpCg?=
 =?us-ascii?Q?kOJ98EN+hxxIpLYTAsEUT0XfDeKvUK4tikla4oIfrj3AfeaNtcZqkP4nFFCm?=
 =?us-ascii?Q?lz+95SJRBx09LNoToiZ8eCJ2AUr3Edd94E049f4fxmhaoCLiGoy0jiDJmPnE?=
 =?us-ascii?Q?Vlux7Aqf32ULcgu7YZbypqT4UnKEQW5JJUvL9nLf9bLR7maW+qSWzFfbYzr4?=
 =?us-ascii?Q?+JIZ0NJgolP6tk/0BTI6FhQb2bMmcMJE24W4OK6DqmMw2IHPhEZJjZJLL2ZL?=
 =?us-ascii?Q?j5IlmRM7rXEg+ubUXWZ46sIC4zSqB6qS2IgK9RNd2sdFzulFmjnCcvFtrdC6?=
 =?us-ascii?Q?N/Qv/6ASdSRw2nyf7e3c5CuKmbXfPv8w0Jk0dFphBs4zYvIk8C/cxmYGuWHv?=
 =?us-ascii?Q?kvG0ShBijGX1NyaE/hqdjv6aNaBQ+pbFYkKc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:24.0408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ed3aae-f3b6-4ee3-b76d-08dde18eff53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9764
Received-SPF: permerror client-ip=2a01:111:f403:2416::631;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 0a91ec7ae36..e1d6e545495 100644
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
index 2f0b4c845a6..72b40d7b920 100644
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
@@ -106,10 +111,12 @@ typedef struct VersalCpuClusterMap {
 
     enum StartPoweredOffMode start_powered_off;
 } VersalCpuClusterMap;
 
 typedef struct VersalMap {
+    VersalMemMap ocm;
+
     VersalCpuClusterMap apu;
     VersalCpuClusterMap rpu;
 
     VersalSimplePeriphMap uart[2];
     size_t num_uart;
@@ -205,10 +212,15 @@ typedef struct VersalMap {
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
@@ -1606,10 +1618,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
+    MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
@@ -1685,14 +1698,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
 
 DeviceState *versal_get_boot_cpu(Versal *s)
 {
     return DEVICE(versal_get_child_idx(s, "apu-cluster/apu", 0));
-- 
2.50.1


