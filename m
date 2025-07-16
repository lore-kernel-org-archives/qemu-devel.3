Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33590C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubytS-0007du-Sk; Wed, 16 Jul 2025 05:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysE-0002B8-LR; Wed, 16 Jul 2025 05:56:34 -0400
Received: from mail-bn8nam12on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2418::617]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysA-0006lc-U3; Wed, 16 Jul 2025 05:56:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3jkNrg7EI7W4iWxy+PHbacPaIkU9ZtOYqHkHDfW77Kf6gdrmF51cCNqEbxEeXSb68rdOaFfUoGpzqGVWCz1kJx8kURCYoUtwouycEGysuhu8VdAIuQm7YL8P4oxL8FN9FRHWAPtNoRtXuIiK6PGHtPqdiqc7kjw/WzveGKVgJSS0DitQYUifUbIKIs6tGbE06POZRWVjHv3YWDU+4tMktLIqX8PNoKDVS0rnDQO+AVtW1XvFCCs/kWiUvE459TeSVJiFLQj9fzuwfwvoK2dO0Ekd09voympz+vUf8ANWoCiAfF3u6bH2gXLEL5n0EY2bB98V9NBUPjxmmIh6pdpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yI3QeG1Px5za4gXQ+OWuZhtzYN79v3tuQUAsIwZO0Y=;
 b=xDdRzrCf4SOooqaWo/CiaU770LKP+KxEqHtBWrPWVNQot3BQaEBh4uzRiIA7AnN7o7avn9gXImZmfCMZoLcM1cAd2FUJOxH30d4Z3lvIBE4bR+OJ4j4Ay0IbHnwauQNU/xrliBY3Ms5sS7G0EcyWeBPL9q8SmyIAJPaGdvfxWcwID9vVf8wXHozNX1iVPyeylrwbAiBCG/aKw49XWbW5k/xZ4kvKyaHcR+ebRVu5lJhLrxCt99XTawzoyY7gRDcbJ54jLP9K6qhBxOQRN1Fsfs6x00HsHUV1vqNqWOlV7R1v8PCOCHaz/BGq+DiePL0d8FUAA7tI1bR0CouxGf1Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yI3QeG1Px5za4gXQ+OWuZhtzYN79v3tuQUAsIwZO0Y=;
 b=eeElLi5iC/TL4GoeJZ5m1ROWdE0Thglx4smm3QvMa+LgwX66ckt/1W+X+nWDtK0q79SAq8RCH63svCoxNwAh6ccHEH+koBLj0waPk5ws24Sl/Rn6tLG1rNGJwKPE5NYRlnPxJadfbNZptjS2LFucsqDbtpWijogp/RVBHoItxL8=
Received: from DS7PR03CA0247.namprd03.prod.outlook.com (2603:10b6:5:3b3::12)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 09:56:17 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::11) by DS7PR03CA0247.outlook.office365.com
 (2603:10b6:5:3b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 09:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:15 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:13 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 38/48] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Wed, 16 Jul 2025 11:54:20 +0200
Message-ID: <20250716095432.81923-39-luc.michel@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7c8a99-5abb-4e1d-ab7c-08ddc44f01eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1uhDbKPVGX5/v6thnOzrLjhlCnviPkU3LtEhZ2d/2WHMQ1Sthe+F7V//QDhI?=
 =?us-ascii?Q?wH6kIU1x//CiW4ydvpGgFqrocfL2WSP7NtJtAkrdie+COx0DkAJ5tXv0D/4u?=
 =?us-ascii?Q?PMAg3TDKqY/s4NdaWm0vMXwfsR+GWtVpWwBsoAxJXR0yDJnzYY7wdQgyLqsg?=
 =?us-ascii?Q?zAmynUkx0DiJCZtZxr7+JZo6dBoACSvY9osw3fBLaTrJWXBdPadBvDN8bAjm?=
 =?us-ascii?Q?6JNtdeDC+CV3A0lsrE9sZyXb4YoN5f9+1guNJYQLNfab4rE2oJE2Rrm6M6Jh?=
 =?us-ascii?Q?17mK53SkqpyxPA6z9pWBZaDumiI7PzE0E0X4fqlLh+IIFg6avNSqkb2wFfoB?=
 =?us-ascii?Q?kYypwETWmK8DtuPdJRFOVVGO+uBfST+O+9Ox7Yt5I4rxreUsNBkEwXE5OOMz?=
 =?us-ascii?Q?sGIDBT2qYQ41u6yiyU5aH00MB922T10OUqdpGzm7AoosIfmTHTSKcAuX8XSK?=
 =?us-ascii?Q?VWuAMMX9oqOTg1SZQdxqKgY8v0aZByWnASMCOqy1qs1GD9i69nRC/flIA56R?=
 =?us-ascii?Q?dpgEMh3hGf/QK2U2Gm5MR6hj3OOR2eSsEDGXaEOhxoL1GrEH85fHa6y4Ika3?=
 =?us-ascii?Q?uOwp8AErSsxVPQsJYrlgFF87wZXsZW0VmknCTBuNGDyj91kyJBlOEng5JJWP?=
 =?us-ascii?Q?QZnCT3sl4oi4dWhpOWZ7LGsk30sG5kke9Kd1uJIQadY9LoMNlYMyX+RwPcKO?=
 =?us-ascii?Q?kd700zd3aODa/pYVSVyRL0dkpSlwIp4TEHrl02T2UYBYr1s4zcLC0w8t40SU?=
 =?us-ascii?Q?KkjbXExsjmxIfbMmweJRI3S4neTSmLT4X5u0UW7/Z/++SAPqtuNIcc49021V?=
 =?us-ascii?Q?2Ys6IR0BeQsSa49lwnzyBsy3rhMPBeXsvZzPxh1cQJacug/Xt8eBXZEaXcue?=
 =?us-ascii?Q?X9WArySyfD0+NygT2pZ5VaPtt4hyycy+p+YLe0FNOLI/oXlgKclZA2foDWeq?=
 =?us-ascii?Q?Iy204znaFdRRuZZk1Cd3TuRXc8mz/VH4h2CITqcmwPyhhVHFf7qafb/Dteb3?=
 =?us-ascii?Q?9uWcu+Jw8Gpyy1GrHyjqxF/TmrmBxbNJNiU1iwZTR/zmQ51mEw2UPEpOeKC+?=
 =?us-ascii?Q?ng3OumC0V+vAksFJsUZc6K6o9YY/vGNkENjYvGunZ6kH6cIi9fayFg5xjTYN?=
 =?us-ascii?Q?dC/JkrCZrrARejZBWytfo9hNfOTLeXKItDG9jnITG7CXUCZGn8gNBzTCtVFu?=
 =?us-ascii?Q?I5EfuisR+pIn9UPxVlwS2zjFCmapv3D0ENNMHNdGY0d3EYr0Q2ZCZ1+S+MbZ?=
 =?us-ascii?Q?RxOGLMfT1UhYQ447dr3gPXOxbmEDtffelLOPrL0cdHz0UkVFOJJZpYz8FmCi?=
 =?us-ascii?Q?lo7KJZSwjju9NKxiSGFTf0royuRz2xwawEAwaVU5fj0QlvTEda4k6mbMHeZU?=
 =?us-ascii?Q?6kRrBLW8A9bOpuvnzvtZzZYSUHINb8L+wk/1iDqmqr0coyCrTmGJ+Pcb1j4n?=
 =?us-ascii?Q?lT7QaLe519vNIJtCUymiyn4PCiUFZwSA4nwV9P4MUK4kTuo3M4imlQ+Ro9jw?=
 =?us-ascii?Q?Co/vFeG7vDpYQV+0pv8MYyP5nEBBYiN2uZC4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:16.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7c8a99-5abb-4e1d-ab7c-08ddc44f01eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
Received-SPF: permerror client-ip=2a01:111:f403:2418::617;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
When set, this indicates that a GIC instance should by created
per-cluster instead of globaly for the whole RPU or APU. This is in
preparation for versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 hw/arm/xlnx-versal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index aef53876f26..9d900fe3127 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -86,10 +86,15 @@ enum StartPoweredOffMode {
     SPO_ALL,
 };
 
 typedef struct VersalCpuClusterMap {
     VersalGicMap gic;
+    /*
+     * true: one GIC per cluster.
+     * false: one GIC for all CPUs
+     */
+    bool per_cluster_gic;
 
     const char *name;
     const char *cpu_model;
     size_t num_core;
     size_t num_cluster;
@@ -828,16 +833,22 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
             DeviceState *cpu = versal_create_cpu(s, map, cluster, mr, i, j);
 
             cpus[i * map->num_core + j] = cpu;
         }
 
+        if (map->per_cluster_gic) {
+            versal_create_and_connect_gic(s, map, mr, &cpus[i * map->num_core],
+                                          map->num_core);
+        }
     }
 
     qdev_realize_and_unref(cluster, NULL, &error_fatal);
 
-    versal_create_and_connect_gic(s, map, mr, cpus,
-                                  map->num_cluster * map->num_core);
+    if (!map->per_cluster_gic) {
+        versal_create_and_connect_gic(s, map, mr, cpus,
+                                      map->num_cluster * map->num_core);
+    }
 
     has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
     if (map->dtb_expose && has_gtimer) {
         qemu_fdt_add_subnode(s->cfg.fdt, "/timer");
         qemu_fdt_setprop_cells(s->cfg.fdt, "/timer", "interrupts",
-- 
2.50.0


