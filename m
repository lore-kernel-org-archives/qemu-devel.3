Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E426CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zO-0002sB-Ag; Thu, 21 Aug 2025 09:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z8-0002On-Nq; Thu, 21 Aug 2025 09:05:42 -0400
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2415::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yz-0003F9-Vp; Thu, 21 Aug 2025 09:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb9tRR4L3Ytp/t51zdPnYemXbnw1vqC0f0tyhR1f2zMNccYS6dOevYjR24+dCpP0cDtmn6SS3oLlMEZJO5qCzfLF/xeFulIx0nN/mQldG3lM8dtpAbpRlTJy//EVdrvAs/ZD/YigAgmaZrVQIt/gRTZySe+YQmRRD85cznzWRmYfKx247PiuztFXFn0zD7MTVBAV1jLvMqCy5eqDEBCaywT/ly5L2CPsilUz3t8IadEUqjfT0NdEYK1wXAoSu7HbX+ZbRGL2Uwe6dskJn57/tRHGJfv+pRyNoKlyhoNpQxpK5utY2/ExqfHiy5cMtBdz2MKZyG5sQSLBRdJ6cbZTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Znag83p5eIKriq4cmGWzoBnCUlJS0Or5OndSZuqHwCQ=;
 b=B/n7FfVQY9x6vZEexWkHrwzcIbGWsQ7QcOV2d8IooK49IHL8XbCZLEvdsFCPTEnwan07n2p1fp9fLUwIcGmkiYYdtRyTm/O4Co+nG1ckaRiISss9P8FpR8Y6d73uVhTG4EPQ6PjlkM7WQ5NvQVvWtZVHxJkwOzoQf+EqmCaSqfraZhg2PtFj3mDfUqjSRK1kYssXjJIas9VMK1IdIIeOy5wCcFPLdMXs2DqxmKxTwHAVmUUaW1TPvIpGyWg5qp78f1UhiLauLBOTvdNxKU7F+AsvDBx/sNay6XtwRT9XTfFahlxc0XBadkRIrYncUrYznDHCvWBmvjK7fPib/PTS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znag83p5eIKriq4cmGWzoBnCUlJS0Or5OndSZuqHwCQ=;
 b=vvT44WtX0UvW1dYYT3Y+zEm8JL/f2JmoiHoU+LQeiR7wkwYLqD7xUFINFKb3MsWNXUxJCSnklWR8cAtHHo9Ib5qw+Bnn1nnoSVGUxfDxwjlAWQGnkJMTjohBu2MThmKe1nDsMRsOTeugu1PvNpTi+p8ivxbQ42xFMJqYiPyOPeo=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 13:05:25 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::bc) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 13:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:13 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:11 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Thu, 21 Aug 2025 15:03:36 +0200
Message-ID: <20250821130354.125971-38-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2cced1-d2b6-4a6e-2495-08dde0b364d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OShCO4aSNZ8Sg95x/DFRSbX78ve3g7F+Dt10E1JzdPetbOAze0OFoQpo8yy/?=
 =?us-ascii?Q?F59iaojUkHNdO1K3KOqKwQnxCueW3tpZadjx8WMWNWuuR2vQ9M6Ae+nt96wX?=
 =?us-ascii?Q?ZQH3w69wt679NZuNdLa/tGtxisw+cEqQf+n8DR6orBeChOalz4VyVSxg7Y7m?=
 =?us-ascii?Q?eJKpmhRmvwSzFWs/MXzEv0gXJQw4IeBjOc9k0zk32E5HFT1VmYvPZlUOvYNH?=
 =?us-ascii?Q?U+uYioyiKYzk8n/HNw52YOdOOXSFWQVM07wMtY+50Dv39hTow4F7jlAPnM3g?=
 =?us-ascii?Q?WSoSQOZJsclxHI9Cr1hCGjUat5fPjLyg/7ViOuqYzfs51za8onVgSsSnXsxO?=
 =?us-ascii?Q?uinlfYtofj/EAx7S9JHeBd90m6mS+ef9sBKCry/25NfhgQ51yU8SeljfUofv?=
 =?us-ascii?Q?SuKs64Jb1jzwjbEsStwqUilmY1hET3+dEOyoCG6sgsH+0vT3vcSfM/+Ac+sS?=
 =?us-ascii?Q?XnOfmdO4/vB+aWz+pX7RoavI3eIaDrJFXt8jpIP71m0Ve8zchI4zeMq6oGa3?=
 =?us-ascii?Q?5lPW7cx7MWRH39NUEuzaf/oxFSD2yyaqM4ExwIjHVWkUuo16VNmLn6PS/N97?=
 =?us-ascii?Q?EgZtTSim2RiWKR+MpOALjavPzU/JeClWJNNxhKN08Ez0BLTLpxjcpdm5tW0s?=
 =?us-ascii?Q?5R2pFpxyU0OlHrXiUI5GmUgM3qTDw3I85/GaYE+JYvLarEinnOhOvUaz2AmG?=
 =?us-ascii?Q?xYXRpXz+MinwFf2AHl0NAKOnEdN02SmATwtHTJueBR4wYELR7rN05p+Bq+Si?=
 =?us-ascii?Q?sgKPWg+HG+ohh7T8H/g2ZwrvnVFKWCWxLihp+9A9wz7+PPUvMu/lqIAsdMw0?=
 =?us-ascii?Q?2WOsTSPGJwdcxZFZyrAIkaDNA19pYEhLeQr0SBNTFvu5prpmehjtsBXBJheu?=
 =?us-ascii?Q?YS266rDPRZ5Rj/Ht857gjYBe8D9sJuZhalmgIKV4fxrx1BpQUpSE8PnH0/LL?=
 =?us-ascii?Q?mXo/bA2YfwBamr2SdZMuQf0zg7OW+RF34JM7tmDV9tovSNWdDsgXLl6mUY2c?=
 =?us-ascii?Q?b0dI0lLKY3CL6unj/QqNAjYFe3Jhs5Ju70Xx+LF0Z7A/rIWj40l4j3fRS683?=
 =?us-ascii?Q?8Jvv8wVcE1PL6IcaHJwLYquiMieDhthga77i0qcVKoPkAq5H0842ueZHudBC?=
 =?us-ascii?Q?KXmJZdH9Z4akGKAxkmwmYquj73V/tm8ysGqLxoHJvFdMcPPlwSZlXMIU5LUR?=
 =?us-ascii?Q?AUiXUrjqIm1Nu+vU1mNbANRp1IVV1fDUXYhuLpDODyGldROEFzYLoT/V04Zh?=
 =?us-ascii?Q?LHL1LPW0YiYifWqSbY22tuxz7DSvnlKlEtjr7pXI4xec3iQmne1AePyXy1UR?=
 =?us-ascii?Q?VbV+cet7hRuq+Hc9QM5xdFbcLA4bLXc3NgVVNPpp3SAdPSmmGKNe5VIVwx/l?=
 =?us-ascii?Q?ZdeAGowv1tJ6cYVnFnTCldimswRhVdC0QeFvkwp3vZZpqvpc44p7KCJtyZ6f?=
 =?us-ascii?Q?qp4lPs2DXPWDElkcvZ+oAj0rVRqVIeq4EzIJJFkxisUdAkxQxPWxSOTVM5CP?=
 =?us-ascii?Q?2qZoY6wUQGRR6yoVPWcgBWNZM/SUoo9VVylA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:25.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2cced1-d2b6-4a6e-2495-08dde0b364d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
Received-SPF: permerror client-ip=2a01:111:f403:2415::623;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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
index a5e6b1a9019..2eb0fa77515 100644
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


