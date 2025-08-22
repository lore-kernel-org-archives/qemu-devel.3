Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8843BCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXi-0001jY-7o; Fri, 22 Aug 2025 11:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXD-0000Q0-31; Fri, 22 Aug 2025 11:18:31 -0400
Received: from mail-mw2nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:200a::631]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWo-0007Fn-Jb; Fri, 22 Aug 2025 11:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPqF4ZLZgtkO/zJHxVcR57JG/5hoUek3VJDkX4kd2XynUxF9ke4YNR6BzNyJhBLhVDeRjyJgXmDLwb5fSmAF+yJtyo+7eY2oFliqGxTnkzT7mu6YM3svjWxZ9xQzXIwFcA5rVAUF9iwFgVQqOv1rpCEFPNTettR73Mu12pv2P9sAF0pTEjQ0BuGIrcUkfebIRu8QfpZrYKA76m3pEXPXz+qB94fcEJVLdNvbt+ILRKoqGVgRytsdN/MpDdBZJUYblflNZ3tXpYLasaVFdRMnzUeGZpdfv0C4wthaSALDnavbKG7Y6tNIftxw9AzuKXxX265DQtoGey6aUO+XA/Nmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iFn33CEh0ZzIUrBgNHYezFlMkZbHZPBLBqBoefrvY8=;
 b=LxdVQPItiSpkLEG8kpM7wCe12remgX8k4Q+QdEMVGpl5NOokcvgc33/mUZuNQ3O4MaHVhUT/dEf7eK3mHB+PKo2pTOtRd20s4k4VQvycOu0a+SFxfYKuGjgo00mJYlrWO10GCwGpu6PGhaeKNNfkQNA693z7zLtc4Ubk0urNOjiwJwPkb7jNCFIvF8ygUMlEyEKLA2ycC3eAXeT/nZewy8gnESRlJfyg3B4c7Q2Ja1/WhzzKarEapurNUsvEK923mIld2BjRAey8EdwAZlSOdo4TzJ9YvXLo5vsnBvUHgNV1fHLgYKIBt85keJrQ8AOJVv8kPAuTMO2d5oUTq1pEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iFn33CEh0ZzIUrBgNHYezFlMkZbHZPBLBqBoefrvY8=;
 b=EdvadgiT3/DhLea3MICQNK2V85WLjrHxYg+GhoqfaiWXiWcVqTV+f3Uu2u846qA2xHOyLgYtndX25FHQIjJcRazo2KCgWfX5hsXFWJMkB9BMEiy8xQxmKrDA21hgrwqYt+WemKdSbZUKq9RTOmOn5CBVo9dGXU0mwMy9WkHF3oo=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 15:17:40 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::47) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 15:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:17:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:39 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:37 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Fri, 22 Aug 2025 17:16:02 +0200
Message-ID: <20250822151614.187856-38-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 83058863-f0c2-4164-56b2-08dde18f08ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uUyaenmmOWZWEj7lOooGi38/WtphgE0nkTJMo17l2PlZS/VuI4T7a1HaDoD6?=
 =?us-ascii?Q?MiYzK3BM6E52cy55/9Zoe1PM84u6UINbK2IxIATyHluNmaf91qWQaALdldMY?=
 =?us-ascii?Q?bDr1eKNUHkgfAeR25cuZ/3ucmqLX8C0i7P/eEkZctkM63pXxgp9iHmDNRe+n?=
 =?us-ascii?Q?+BeJJfY+AKvNqipUdqysBQ817MfmE10dzZfFelddzUhI0P8vm3jYQnEkpdHE?=
 =?us-ascii?Q?D+TLhsDxu+tGrymSFJQorNMuaptQumQPvb9gu85XQ6GmoUU4w3ksD2767dxO?=
 =?us-ascii?Q?FQt8kMvy9tQCIITGEPXZvtxOF5pWuAWNDiAgLXWCz3b4+J/g0ARLL8EeUzpu?=
 =?us-ascii?Q?LonVXTKnVXtceVTwwMNfhG06/UrNvUzKGppoc1qMzg3dghYm7E7/t6SB0BrD?=
 =?us-ascii?Q?leRqH2wFiM0QtkHoKrO3gy6awtjuCGTbqEYZusoyU2IdHCXYSO5B+3AF71Z8?=
 =?us-ascii?Q?ONiHEzJupmKFqHHw2xXgEz1fVgSVApuhwQI/yzA9Old9AQmF8IYkZlcJwaY2?=
 =?us-ascii?Q?jGKc/A6eadY+KtFPuc4NKheOvLpZHzW4WTGm+vElf9oBEO5UPabVAFZlf/5z?=
 =?us-ascii?Q?EcSlgnZMw8nYG6/bZVzJzfd7hpnk2VPk96O5JY8qmlYew/Gry6boypcFKwQR?=
 =?us-ascii?Q?1rEj4KyUCe2JK6e7DVFBt0MpoakzF0XfnPwj2yPRyJ0pYek0ZePqRgG9mUjf?=
 =?us-ascii?Q?U/WcAeywoUSZ0uX/49Rs5IlY3JHgau4staXTlswMYbnAe5t5EUNxv1FL3H5O?=
 =?us-ascii?Q?y5tjUoJZxc5BMRE05HakFtWOnsUyiwME89cgw8Ez+Ovi4NATLXft7BCEwUBr?=
 =?us-ascii?Q?G4ICEWCwNtKmJMPn3tLU8hQiEU3kUW6stzyekb5d/HiDwaP/nRA6Qrd/R4xi?=
 =?us-ascii?Q?1tjOLCM+l6aiBpsywJDC8gysK4Dt1aADXAtBiOg8zPAIQVvBKaUj1qNz7XF5?=
 =?us-ascii?Q?1DfAVCI6iE03sB5i26wwcAqEqfZMo7QUTJkgDyF/evvazFymMbQtZ1WgwHv4?=
 =?us-ascii?Q?eZXHgrgXT0NdwsFQiSOu00G0zCGSToL8zJUUkptA38+SrjqdTZXvNP4TNoJw?=
 =?us-ascii?Q?JHbZ/e7zrXuDXLlA70oRhj9zd0egeypRifdcM4XIS1vz/IIijd4tKzdjdnEW?=
 =?us-ascii?Q?+pCsRvArwIl2ng/Vv8jR81PV6u84p4Yz1BrLcbwUKPx4BGk4bQpEvCXs3r8n?=
 =?us-ascii?Q?ypHHimFTssLGeBdUm8Ya5x/XFoEAi0rMX41tmmr6UrsopDDXI9gnC7qNhQIO?=
 =?us-ascii?Q?KhyLYtK5auayNbZH8XXuLvqiCeOStiTPlR4CEm2Hr+IAFqhrt9iyS58hYGrw?=
 =?us-ascii?Q?PvjV+40SWJ7kPRCxzPtMeU8W2qCaBzb1gwZnSLM2HWCYJ9ekwEKY3qhEUSHu?=
 =?us-ascii?Q?Yg+cEsj86TkKZnBI1IkDQCVkn81/aqhBUOCBofmfnPCaTkPRn2jFqGY73+Qg?=
 =?us-ascii?Q?LH7nVsXAWLiBSYMLN5Y0BatSC/i5m3va0sZLN9KvtSRbJGphlJ7MWhIql5gh?=
 =?us-ascii?Q?bNSIQlbQ2JUzV5r+B1u9oQkyl7jJtRBI9qg6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:17:40.1260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83058863-f0c2-4164-56b2-08dde18f08ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
Received-SPF: permerror client-ip=2a01:111:f403:200a::631;
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

Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
When set, this indicates that a GIC instance should by created
per-cluster instead of globally for the whole RPU or APU. This is in
preparation for versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/arm/xlnx-versal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index bd22962341e..81732a80c6f 100644
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
@@ -823,16 +828,22 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
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
2.50.1


