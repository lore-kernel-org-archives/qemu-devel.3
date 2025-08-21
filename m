Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zO-0002sD-As; Thu, 21 Aug 2025 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yx-00022s-Fp; Thu, 21 Aug 2025 09:05:34 -0400
Received: from mail-bn7nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4ym-0003D2-1e; Thu, 21 Aug 2025 09:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f62aGJP4nbBJ6/k41LrkPpNrjPFgeMg+uE1TdJwv6p2hnFw7vpa5L10VtUKsdLrZB08GRkmrt8bT1ZyvrkNWJe0IQZyRlEfKM1m16tpvd476TXUPHdno5Ua2VFRgAnudxbDa9XC8dtLZwurVf5vpREF2gUMPLf+7i8TOGT2eG4OgyMRUBJJlwdJ1TEn/m+o1gDTQ22prTjSYYXUgHkTLx3w2y4jFWFS8fYzFiJxZLNTEljI6PEAfNTSlBEqIQYzHuy90lOijVOBXBOR5w6/WA8HCEH8SA/kgB/41go8uXqCv8tzI9rJAUhesxdcscZdoqu8qpOiSqN3GKTTGB6syMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiRXw9IPIIoKIgFTHVVQMwtMiod3JQHTI9J52yorF2A=;
 b=kd8XhzjcLJ07TfuCr48X6uoVb1mY8j5w7E7mRL8SSIAS21rDCfNWUNPw917k64lWbmWRWHhqvXX77bC+2Ihle9RBlWq2S+ImmBNn7LUInogpEisAAFbY4SMTNiu9oKvLGe+vTy93ETz3JPsgxrszDF4PxNEKy11RYKRueKeVz0wO8WJUfewZiF+aSqSd4+/ZAxLVR5gxbHtHD/NoUjAVlmNVsXjU/pzPib2uzyKOZUe56z4wtyfh0x5k+73OCMYW4aelnBArhxqSIxT22GkbO3fygPmxx/WkRRencrwlJDKtflnjZrxsAjHK5urkmfr4rvvQb0HcQRJ8FVwlTFkd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiRXw9IPIIoKIgFTHVVQMwtMiod3JQHTI9J52yorF2A=;
 b=AxgwLLtisHKTTp7D/qUcd9pnXH26xJT2qgegDQ59udWBAA3ngny1fbfQNx+ZawxHdjT07zwQ1cGcMqf49+GqbwbEEpHjnLj0ZxlyUkfnixiSJknMBS/jU2uVrLek4fWIkKSWcLMYIXUA8jtdypKaM31Eco2/IaGGkg11PpRkuYM=
Received: from PH8P221CA0061.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::17)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:13 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:349:cafe::94) by PH8P221CA0061.outlook.office365.com
 (2603:10b6:510:349::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Thu, 21 Aug 2025 13:05:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:53 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:51 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 27/47] hw/arm/xlnx-versal: ocm: refactor creation
Date: Thu, 21 Aug 2025 15:03:26 +0200
Message-ID: <20250821130354.125971-28-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1acfa5-36cc-4394-f9ab-08dde0b35db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5aob8jqTMYKN9Up38KyISwtB5+eUDEKvyc4CNWIzesY3rYY/YnC9fpzh8a4f?=
 =?us-ascii?Q?Xd1F/4wqko+CZO5kgI3M4Z94ay2ivhLRUfnDhJg7zny/apeE/RIS2GpSKSdF?=
 =?us-ascii?Q?mY22nRd6YQidWThchhK8j6pGqpual6Zfltmt+cJyPrHh5XH3m74yToRkg0ip?=
 =?us-ascii?Q?dU+eXcHZd9snRI+v7NtJD3KjmefatJq9mIt7DoYZPNBMaL4ClVBwaQIwVgCH?=
 =?us-ascii?Q?CvcCrOa+h90ZF+OHGhMob9hsi7YFVO1J2dnX47gwoqz0dIroU1F5SixsJfL3?=
 =?us-ascii?Q?dBwevcl02zNPP8581l285sn+O5GRpJVuffrNR+9QTBOE1AR5WQve30eGVDUd?=
 =?us-ascii?Q?ne22ucWltrKstJoN+mkDP7BrJChMPaLS+gkRQ6tsruplIYx3X4MvwbPboYxG?=
 =?us-ascii?Q?7x+ozGCZs9BtYsmEc4CzkErYuWshnnxuX/WC09ewZmSsa7PncmOTYr3fMKdD?=
 =?us-ascii?Q?WZkKi85s5VEDNp+meEE+k7/HyxPw2N/glaxjyUU6EDcawgTPENw6BmH1TfPX?=
 =?us-ascii?Q?eQT0HzWQM9GwOrZNqNm1JVXNXHGFG0khiCeMNi0GEQY6yR/Pp4fJWfoytasX?=
 =?us-ascii?Q?iG1rFnbE/nYT7OzVYISwz2s9/TYmhz4N/iJs36Obowfwj13aPd2KsdAKDeVF?=
 =?us-ascii?Q?B9YYSiQUvI1oPTNEuMz7QG/hZz7j4JSqNWZNgpjNEiTLXQJ9GMCDRAqLRv8H?=
 =?us-ascii?Q?oe9GHhO8gsb/u5DvdneznyqtLm8XiMXJsvYXxVzQYe+Uae4cC0FoxkP1Zomt?=
 =?us-ascii?Q?2kXK0pVWLZHTQPec34YQXWEQfcVEcmxQVovarZK0NhtB095+63TVBwK4J3O1?=
 =?us-ascii?Q?Gin1uPFK5cfL11pcmyoVn8nv7j+rIRA/D6m35PHs8oh1FuCZdIAL7fAeCaqG?=
 =?us-ascii?Q?ClGUwWndytuLWSYR+wLgoihdfwbhFo3OQrzO55z8IGFKusN55xX1RtwyZk23?=
 =?us-ascii?Q?OO62Ra9M+TqIiHAyQuIEtp0okl8MG2nXifO9xA2NYUrD1td7nrp8zPQq/L1U?=
 =?us-ascii?Q?VDevQ+weli4Mu0KJ0ojIRHLlc4c37CVZywvDQuLOqOgGn8sz0N8l3dfRbKFw?=
 =?us-ascii?Q?sw4YcFypXfjnWCxS3OOX/flafXkfhxHQaGJ3trES8gMXSpDJnntVwhmknF+6?=
 =?us-ascii?Q?8d7hga44b/vSBf/LzvWkGpz0RJWHqSL2SyhsaORd2MH8TFIbKmQVkllSX78t?=
 =?us-ascii?Q?0rcO6FUohU/+d/hvetMW2/G0IbQGNxe7X6roNiMARkc0m+Z5v5UPaklDkVh+?=
 =?us-ascii?Q?Zm/4ZbxYBTC6qN0aY6lF2kvPtxrLfRjNCJRGTCtNlf3srZULdKcHnFn3QkhT?=
 =?us-ascii?Q?TtGRagakK6fnM0dpMA7aUox5DXOzGXHcHQjtzKuDBte+xmN7lgvJFh5ZRpnV?=
 =?us-ascii?Q?hVCkC64GIgzqFfYEy1ZnV3nVsnU8d79OXhOHE2f2rgPAPav11fVYUtSJpYOm?=
 =?us-ascii?Q?e+nfImCTCiSyx5wlyXtif64SMXYWPiOzpSZeiYUz4uGpkMPDnNpWqT7tPATB?=
 =?us-ascii?Q?LkKmoEFPn3SLoZw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:13.1175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1acfa5-36cc-4394-f9ab-08dde0b35db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
Received-SPF: permerror client-ip=2a01:111:f403:2009::60f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
index ed9449685be..367e6ba5458 100644
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
@@ -1600,10 +1612,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
 
 static void versal_realize(DeviceState *dev, Error **errp)
 {
     Versal *s = XLNX_VERSAL_BASE(dev);
     DeviceState *slcr, *ospi;
+    MemoryRegion *ocm;
     Object *container;
     const VersalMap *map = versal_get_map(s);
     size_t i;
 
     if (s->cfg.fdt == NULL) {
@@ -1673,14 +1686,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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


