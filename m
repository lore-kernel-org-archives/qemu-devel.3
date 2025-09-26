Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A2CCAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22eM-0004Fd-Ga; Fri, 26 Sep 2025 03:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22dR-0002j5-5e; Fri, 26 Sep 2025 03:12:53 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22d9-0007KR-7Z; Fri, 26 Sep 2025 03:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld9kDYw0qLzga0DTIlIbrX0E7IV1Ey2kkUvqWANfAVM+oc1Xe5BXCOr4RgmreiEERf/UfVHhSZrp1mmtYVrsGFhuBkUx4j0oPVQDEQk/CDO8vtWPDsTQo25G6xrwbKaFOeFJec30mBdDqsOUE9HG6JOORCwyd/PnCI48c8VZhwAOpObJpfXwtm2oblzCEmD42RpWFJIaBCl6lVpjuRtdhQnB1I/wZOVg3a3yJdSsEI3eJggLdGapI7tG9IoLfqsowWENzYw+TAqkKyN43CQF7RBHndm37zvhr3AYwMg83iWaZptLgR7M7r2Xu42yYY7aPkOIMEevoKRTqnepVdRK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMjbIQ2JjVUxDajSeAwPmbq1ASothP0zuHmve/xe+CM=;
 b=wcimxvngeH4a2/8iV0pOY5rI+TpP978eah0jU49xioZfQ90YrZEy2hiAuG3l01161js5U0bngfr1UZysx5W6MrzPbKnL2sOY+NWW8AzpdqEwtnaXslVEHIVnVNtKYX4HNzHI1aZy1hrIZw9DbEQkYTsx392+oZKPMIyttYTJxwSCHcrD+Cjg3/3+OsHQaVlDa3+/pmtrUoNWK7DE1aEILhZDAQB3AWrpW0vlezTqJE0E0AUc50TAF0CrWVsXWgZ9eCj0HbN1GCyaFIyimY9C76V1AoF7BXAc9QwmI2CxC5lezmu6YyGInFWympXGuDVt5SoSWZxn+7Ofp5BrRkVMQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMjbIQ2JjVUxDajSeAwPmbq1ASothP0zuHmve/xe+CM=;
 b=r0TUcPImSa2/EFjtFV4MgcyVvFuQsw4gfCVqiPM7qbEKKjSJ6Op1OGtzn+ReNHg/zqSOUV8Pd9iuuEuFoF7ygTaVMdejUdwGuJ51s/WTOw7HLnB2lsXZwp946V9bhvwvtX1JU6Fu5MEXkKOM5AbQqJlE2WiWXnbcgbY/o6mnWQg=
Received: from PH8PR21CA0021.namprd21.prod.outlook.com (2603:10b6:510:2ce::15)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 07:09:17 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d9) by PH8PR21CA0021.outlook.office365.com
 (2603:10b6:510:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Fri,
 26 Sep 2025 07:09:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:01 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:00 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:08:59 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 27/47] hw/arm/xlnx-versal: ocm: refactor creation
Date: Fri, 26 Sep 2025 09:07:45 +0200
Message-ID: <20250926070806.292065-28-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f68d6f-3557-4695-3e34-08ddfccb9b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1iu+px/lVqtdRLfqX8Zpma6md2ZLA8t8xMobVLY94usJWjAZlg3KAaL2Sp7P?=
 =?us-ascii?Q?JNvRoIJufOKwdiS2JkmYcV0KIeazFGgn1tKhEW7SGtZ0/PnQW5BTEMiLcnhZ?=
 =?us-ascii?Q?P4MUKI2/eDrIawkHvxTPMcGFxnicHNM2TFDNIjW5Wn3h22q3hbTotFBKoE5X?=
 =?us-ascii?Q?bVF8OS1TiUhjeXJhYMa3E9X2fpWZAWVZUt/1OmmfB8ppijghDJTL3pqGG1mn?=
 =?us-ascii?Q?q5SS0Eg6vPeQAh7DFXJwyMb5gl/V9oaAKnlt60IB+Lkq7m956Ae2HvESmGlS?=
 =?us-ascii?Q?HFSEJ6kymMw6Uh5aAk1MM3p6LMpfte+Pu5jOR5VoMCMdAG4MDZ8+cKxYrmG1?=
 =?us-ascii?Q?X0ClVApTayxxUDPOmJ9i8PuHRL70pSefAKohb8cHnh3nfQPpzOj0NQ0lG+f/?=
 =?us-ascii?Q?Qz56enoIa5rL1PTZwLhF6azsB2tH7m2+bnFrxESIOSPR58eBBvuv/PrjaTc4?=
 =?us-ascii?Q?gU9M9t1NWQs4eqGcJcPg05TMcsMCOzst9FvYkvR97SCWe2WGORVA0M7ruB/1?=
 =?us-ascii?Q?HMiXZpcL99g5sG8u/7tp0PNGAkMw4+6ptVo0P8R2DGl7OoNKa1SrgvBOpiDo?=
 =?us-ascii?Q?+fZhuJI3taudq1Du67Atqgkc9YytX80g+eQ4ojaBW24z0uHjSRqohD831rd8?=
 =?us-ascii?Q?caY69BY47j5LSK9gpRWjzVeOWgQM6aLIfB/A2gjRYawWmznKzECHMYO3hL4A?=
 =?us-ascii?Q?AayOG05XQb7i4/JLuXCwaRkCnYvrcVaUeDLQekO7BxP8t8guNIa+2/Zs36sc?=
 =?us-ascii?Q?+3mzBjLQsUxSr8uC4vik6JIstLk6kVg210x1uu3FThpLuSUeXzFwBlSkes++?=
 =?us-ascii?Q?2M0pNxcl6rxI40V6CUloIVNNxe6CUpa/AHMsAMho3XG2FN25S2+Evv+Wq69P?=
 =?us-ascii?Q?fhseWvyZdQRW3PxxiCW+9TRR+tgNoN06bwQWHolOt/Ml95ceZWPU44qVmmlv?=
 =?us-ascii?Q?EWzgEcRDkJxLL275jRXJS6EzelF7mBCZS1pzVrMaz0+fYp42u4YPq6OAbBLk?=
 =?us-ascii?Q?xtBzGOX5z1K9rL+0idzepmMxm9zAZEeec52gTQvQzOHpQCnrx9QhwNfCRXLQ?=
 =?us-ascii?Q?ZGLrWZhMyBvdI23dq64RRZqr/4Qt60ASBhUStgB9Ctdh9llFlQpuSJe/y4CD?=
 =?us-ascii?Q?NGABY1jUa6C7Xm0BgbrmtU0HH49srWVmPeCWqoQcgE+41iXnTTiW+PWB7du6?=
 =?us-ascii?Q?U0pmx2QZV8YltpvXMFdeiZWefJYDQHQV+h+oKaStuRSvAeez5sSulMsUzHHB?=
 =?us-ascii?Q?DlUIFMGU5adKCeINFBG9dxddeLrW6EbrCwlJ4z1a9v9JvXhDep2tpwlZ7Zq2?=
 =?us-ascii?Q?I+cR6pcdLeNsplfHuf3GKmYozfZKYMiC8EGVlzFHWlagIK4GbH/pycQ1FqKm?=
 =?us-ascii?Q?1UGosN3pYFAExnoC02cZsjzCmYjK8o6t1dBpimS2dWePjmdyuyZt7taQy4+x?=
 =?us-ascii?Q?IrJOu1NpoJ7KupdnUiTPzG22QkXUccOf0Um+rILhYU+89m+r+m0udOEgnxBT?=
 =?us-ascii?Q?U/W3fbLW83BlqUNSa+YeH/NQidsUBnhUzpUuT0PZ6O5t8wcAWeS2G2JlbXjW?=
 =?us-ascii?Q?JmV1UblbPPI/GztczzE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:17.1472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f68d6f-3557-4695-3e34-08ddfccb9b64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Luc.Michel@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
index e89c66313c1..8aa82ceb839 100644
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
 
     g_assert(s->cfg.fdt != NULL);
@@ -1681,14 +1694,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
 
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
2.51.0


