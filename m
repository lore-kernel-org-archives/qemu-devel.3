Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0032CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeAd-0007Yg-Ba; Wed, 20 Aug 2025 04:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAV-00071P-08; Wed, 20 Aug 2025 04:27:39 -0400
Received: from mail-dm6nam12on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2417::61d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAO-00015v-R6; Wed, 20 Aug 2025 04:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j73larIkKSarLLdb5g7DyGNIF1DGsb/wQs0VGhj2Cudrf6fJL7Rf29ozH90hjMz6DHRxSRj+seBpRFw7rQkl44i2hvSrAMphLdDJ8PhR95ENEbDris2gVFQlaNikxvgiXPYfBLnVkGdvgDkO5swr05MpNa45n7TO/yv4tgoDb5Qk8jGKG+4UI3h11H4oD4icRzBRdqbnDfDESCnsbUI62AuW84S8a8LQ1DROg7K6PhZYKS/OzATUJEQpC6hjtjLuQhvM/6GrUe2lzm93W5AIaxpzsoRgZFx89e+bLrmIJnO7uFnQmoTQWl5IcwXZ+mRSnonsfQSXueSevMAi0dCiyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06l9CVG+Cw0/+sTLfiY/QH8V2pYwubqAUjU9qq8WdbI=;
 b=je37M1YkT2YAywy63v0essb/VKEtuTB9K+0IP1Ktm59mD2TRjQEB1Cfq9Vq9UO3ZzpjDDGS30PhzZaFRxDZPkPRBr9ZUp7XekoZ1jYSCNLp17rxoHyhw6t7DiRSnoD24srMAV9/vNuARaHR17Q4G5zIrmPL2UU4LN2ey/b17hU5Hgip4uWor10vAj/MpKdRcR2XsqjW21zQNLFieu6crJRTBc6iDoO4tR7W000cjgdHEUQ7HvkDZFSJ4Cbzlyj1B4344ACULcTEPG6+k99tgE3Op46jb8X9rnLqIpQPpXDGcUySGyPdO/x1pzXyr7N/1WYsGTV3ISXHcf6vZh4JPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06l9CVG+Cw0/+sTLfiY/QH8V2pYwubqAUjU9qq8WdbI=;
 b=Yd6oU1RLkWc3p91zGeHvdTDRK8IZcExlrAoSt8Pz7hCcxPysfxlIodI4kq+5NmkLr8JTM+JPttc83df/P3/XmTFmnfa+OB7mY9/IMeyuCF7MVYy5uJnC+FCEEH6drna5lS8jPCoHcS6c9brUFlAQJ8wyW1UR4NY6G0Z/WNpgElA=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 08:27:22 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::3d) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:21 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:19 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 37/47] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Wed, 20 Aug 2025 10:25:36 +0200
Message-ID: <20250820082549.69724-38-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 999590b8-208c-4191-849c-08dddfc3629e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vustJWXEQ1rDHGr1eI3lMyPKxiRAMakPkHg2fx0KfCnkF8PMdwFGGLoFfyCH?=
 =?us-ascii?Q?F7Ewwx1m7q7h4xjtTNtr0HTuM4idrEXwAdZjkDK4Gh7YJm1BSqxrqtPAJ9/o?=
 =?us-ascii?Q?8mczeX0k82oaOOBotwGZtdaWOhB03U/pxroi0kkq9wp97035wBLCA4e6B0Zi?=
 =?us-ascii?Q?JsYM40J/csE5Aaakzn6d2bUktyRbOwMAbnuFRcmFdj8vfgHpn5Qf83e8yX92?=
 =?us-ascii?Q?pnEA9wAWoB6RRcmg28CRF+lWPB0wzK+iRK7DezjyCBqHQ1Rv5A04H5sfzkXv?=
 =?us-ascii?Q?HtD9FcEnlUmrmlluZ+ipXNNUnIGwqAxmUBT0PzEi2BKduVNolDkoGfegqSeD?=
 =?us-ascii?Q?FVWXib5dNuoXjW3G5RtMf7lyqyhz2fP6vy2etIbSVfwXxNImhP2BFejHVRv4?=
 =?us-ascii?Q?oy2E5Q0KFaDYcX7ii/cpxZBYCTHI+YCVhFtWT16ewvkpR02aDbnrJOMezR+v?=
 =?us-ascii?Q?TmYlartJoFHk+514CgbMZ0FcdfcoNlylYRIKf67BRXeJuQFZkFJtK/1esCJW?=
 =?us-ascii?Q?2jOvFjc3+Yas9lPFkX5DASMXnh+MqtX7Zmweozg7n5xp2lSss2CyCn0p9Qx+?=
 =?us-ascii?Q?GjH3gBgathyJ6SiOOfrc5tygCeFT3IvvOOYXiubU4+3SQz+7/wiGcj3Xqwei?=
 =?us-ascii?Q?KyWpsjC4nv+qoSuojyZ558NraIbLTsElae3JzI+2XteWchV8pqX5ml5fzOnT?=
 =?us-ascii?Q?RFJjEy2vKfw22b6Yf7V92/M9E8lxMf/Ld557xdABJ5NVMkQc7jaZZikUzt8I?=
 =?us-ascii?Q?GhtATaYEgwi4QnmYZ9Paudbyt4o47xa7/p4qcUinDYBxAH5N280VvlXiSyyI?=
 =?us-ascii?Q?UUuS52uUADt8jSiOYdVkVD1OKXy86YXmEw+lrHS5hZrPAAYGtjk4BTI76s6X?=
 =?us-ascii?Q?WNYgYzWNDPsKgjGjdkxcfWCH0eYPK1B9gHvw0ZVxaG7bll285TxnBbYaBrcg?=
 =?us-ascii?Q?aSlLtecPQ1RsCjHCxvVRNSVcsEDGSb5/YIK8R+pEofEgvaHqgAHuNjvvG951?=
 =?us-ascii?Q?zndahKSCF/PaxewevSiaBsxhxw8ufpvND2AawvCONaBqj8XahmDe0k9nY8hA?=
 =?us-ascii?Q?f0nJW5ZuR4bONqyz00FHLlZM+F7RcarIDMBR1H+YT/G5fBrUGwPb7SuPeC5j?=
 =?us-ascii?Q?EEAvboiinpxnJsh1I/c1FWgdpeRJDYFRjyZIrdaIHknOc8g9KRd/CMlpRF4q?=
 =?us-ascii?Q?ZR4yL12YJrm2zLiriWB0sbo9/wFF2zhIoWMtDGiDbZTjKC4tPNGuWPPwkwVH?=
 =?us-ascii?Q?LjCDcHAAD7UxtGjcNBPLCsVXltdKB804EO5lHl4iiWEmL9MhoNPoqQEFkplO?=
 =?us-ascii?Q?8qnVE5gGerYnFeUpIic3ZDOBCQ6I5tSOFiPGgMWvvVZmR8Sm4y0T083xrYan?=
 =?us-ascii?Q?elsCUv/mCwsUnrQJxUdAHAc0ao62ir42huc3dmRZz1uIonyLDQ1YlxCi1PeX?=
 =?us-ascii?Q?SqTFt7uN8dXXr2uIUm7Q7Zogufn2vql5fud8Zhshs7Kg2CoMmyRMl+yLxyl6?=
 =?us-ascii?Q?2aHgdjLld8vGYqwLsAFwINl2TjXvk4l90L2a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:22.1305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999590b8-208c-4191-849c-08dddfc3629e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812
Received-SPF: permerror client-ip=2a01:111:f403:2417::61d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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
2.50.1


