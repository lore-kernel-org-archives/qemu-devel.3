Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E7BCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0eE-0000tP-Bm; Fri, 12 Sep 2025 06:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cz-0007Pe-61; Fri, 12 Sep 2025 06:03:37 -0400
Received: from mail-bn8nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0cb-0001Ls-SR; Fri, 12 Sep 2025 06:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBnun2BLi+mdRf1I0mJdQjUJSa/HabWylKNp3OGg2AKy3OuGcTxgrivo6tb9qBFCknvzVjpo78NfxAJNajqVAT47rVBwHNf9JY4ToYFbD1f4vYzZX7yuB+K8tO2KU5ULBMS61cKeafLFyk5qb0UnTGvBgWCLG2U8P+7dTTik8+CJiCQjPhTAi/YijijlsqL0Zu7c2+v54Ju9cyAStTyes0HyOEZPqcBjuzojHsc9+IaRp8WpG8s4VEO5FNh1iKjfzb44rBWA5Ei0EzjU/PtpQj20/EZThB6bpNhVxnRHEGFcyiN3syAgrOXvgr65y+YK9ZAV73bURJPJYYh+p6+P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcnibzl2Qkc+1gDz1LWowSgx5cfNpsozcpjReNmWX2A=;
 b=OOaXrmTne4Jmx2vRyd9gt1IKZMg9XwY1XcwAeAKRoieC5hOGPWALAueLaUiOdcWYukTNm1t9HePncW8lVONWp3h4OQz/a31/XLe3YlzBJHHMiMAseY34DTGwg9mvZIqubBo4kOpGWxtl/3wtH3DBcQ8VmA7NlAoVvFfpQicjk9IekKTOBbmSlGGIQvKHNxoz5kOtnJ5tdhcqbEUbBIMBkTlRTo1eprE7ho1MVcvEMmPLUIY0YJz7KFpjPeRnWfw22RQehHe+OPLQUOBt3Dea53VJQB7E/g5TS/Da8z8sHqEPpBdiN4lQhOmp2zioQbKuA+n/Ivt5SOL3XO5suwTyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcnibzl2Qkc+1gDz1LWowSgx5cfNpsozcpjReNmWX2A=;
 b=ReTPGmffPJ3a7naWg4dqB15Wa7L0gZRqXzRXj/SukKpnlsXlCjQKo6saMIPTSI3WQ3i2skzD6LDWZMj4NsN4tAv0VhzgcCO5qJriEigAy/3rs0azFXujCLVLeePVzLtqpHBbiZVXX6jYNhOTb4/o73oPWnkhz0gEzpushz22sOg=
Received: from DS7P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::14) by
 DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.18; Fri, 12 Sep 2025 10:03:04 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::c) by DS7P220CA0007.outlook.office365.com
 (2603:10b6:8:1ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 10:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:10 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:09 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:08 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 27/47] hw/arm/xlnx-versal: ocm: refactor creation
Date: Fri, 12 Sep 2025 12:00:36 +0200
Message-ID: <20250912100059.103997-28-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: febaca07-0ced-4b8d-c5ef-08ddf1e390a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZsZoNDFaTmDdWLUsG9xxj2uvsQcv/49D/CpBOYVPaToLggWHI82+5kMdBknh?=
 =?us-ascii?Q?f0ClVe2BSjHvH5iwb/Mf+yz6S4tH9mh3Re80/Tbp7XzcHaKyEX+scRU6/zd0?=
 =?us-ascii?Q?vt+faOb3SpB4RWJxr46PGVH7/whPZ54651ghukuXD7mB76Kvm3rdWeqpP/nv?=
 =?us-ascii?Q?e84anpdikdkM6BpojvyhLd1CaGOq6vh5NqaW34l9q6NbkMahqx1aAi6NG5ZF?=
 =?us-ascii?Q?rFQZIdw0xNu8Xp/FeTBNMOvvTTxCALRMNlHBQdLa7L0qzGVd/yJoKw3D24pw?=
 =?us-ascii?Q?Z+jxglIkMdcIhMnU6HCJXqK5QdMZEbFdI9loheHC5hZcc5o5uECkLlodopsC?=
 =?us-ascii?Q?pOtLvEr1048qhGfBpx3VoxVKjXq492yveWngXkCKe7xiGWRclJLShPahoXDl?=
 =?us-ascii?Q?kApOjrVllbKAViJcRuZD7QtODDzz6ObXHYkEukoa0yL5MUuSnP0mNj5PmUYa?=
 =?us-ascii?Q?JSkjzbk4mZrXghbApA5sSi5yXs+dA7iu6lxKTVTHtUKrgB7qCmBm/3V2VjUa?=
 =?us-ascii?Q?S3HsjOS6S14kfYTEKxKeJJkz8BK90CwrM8LSgd77o7TXhZGd5jrQy4qQGAOx?=
 =?us-ascii?Q?XuLkWUJtTM6rQLnrNBs6SXeL5XgNKbIB3WF34cY4vEDC4DEv8/0nXCMSn5Ns?=
 =?us-ascii?Q?IQRWTQg2MjrZ1dUOHygl40hksKM7APYSHtV6+NXkdttOqMJhbxsNStDk254W?=
 =?us-ascii?Q?09AmWjho1YEk8ukpu/rhmBuFHMv18FELcIL/zsMU/YEbiXE4nFQ7alR7E5yF?=
 =?us-ascii?Q?wvb/HZxWwwTzXcICbPEtw62CiSMe/n8rBSl8KROIPFLKRqawhHpPzshvqKlS?=
 =?us-ascii?Q?VS47jS5m4k6soxsjAgAZgfD+BdOSU8Mw7cFSJaci0noeSbfyx7WidEtdCTHg?=
 =?us-ascii?Q?udL1X0KU9pB+2IpGyct6NBqr7n4NYUENaMI5CZxFFgxlviw8uVINas4Ulpi4?=
 =?us-ascii?Q?FeqPb4fLTK9oINsg72BJNCCD+xIUSlFJXWiQPRrq8bUUPtdYJfrbni7fGZ/x?=
 =?us-ascii?Q?v8uU/5kfVyvssiLKM49+BWziamhcaZDqo9znFXp5m4Q49cx/7xPdAgoix4hW?=
 =?us-ascii?Q?15y29jaKRaK+SA3pxafEYivK8umZLam69WMYvU5k9PuddvXOo3w2I0LVUvzw?=
 =?us-ascii?Q?8BIamN2UAnviX0ZEigqOqjlFpkd5i4y21Y97gZpqmAdzVCHtoDnQsUf984Yd?=
 =?us-ascii?Q?sUhqtFbngvuDoBvj6n/EXxf34rDOo2RqLfwAY82SIux1OSD8+Vj6PICp4r69?=
 =?us-ascii?Q?atvWRpoB15oVrmX+jakkMosOejd9mTftdtgJo28eShrSlr2gHpNUOhAhAcjr?=
 =?us-ascii?Q?1W08UjIRc/d5B2J46ME1CI1glF2FdbMaErIuE4BfkRwvOHfqf2bragvNZT7z?=
 =?us-ascii?Q?eQ0RaGLO1Lgu03w/eXU9PWZH9O7XcLzD0UOS2+FceYxB+NWqC3pxqcg+PERd?=
 =?us-ascii?Q?5DlvZOeoRo2mxnz9PbsmEP5UkiOpk0bZQpNDW7EDZ80Ba3y8bYUJY/wiDwuy?=
 =?us-ascii?Q?J3YVV5PVG461h+p3qBOuUQnBdGmTu7b8IZpi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:04.2382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febaca07-0ced-4b8d-c5ef-08ddf1e390a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
Received-SPF: permerror client-ip=2a01:111:f403:2414::60e;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 54d4b28c7b7..207d55c062a 100644
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


