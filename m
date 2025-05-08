Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA9CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7O4-0007bl-7m; Thu, 08 May 2025 15:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uD7O0-0007bI-TV
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:58:29 -0400
Received: from mail-dm3nam02on20603.outbound.protection.outlook.com
 ([2a01:111:f403:2405::603]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1uD7Ny-00028v-T8
 for qemu-devel@nongnu.org; Thu, 08 May 2025 15:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CshZ9QxBsKXJrZsUtEQ0XkTeIDwoshs4U5XWAB5/rAJjHlKjtoWvV6SJGsYyPGeFQO4lJztbk5UtMrYPNv+k5YFgO2PcYGltwtsBVLQgiCE3uITLVBzGwaUWBsc6E77+AMuIeCSkSatOMnxg5TSsu5PMXKzdwEcJrLh8CX7JTgm3X6eePvvyc4KnMjtAJZ+f2ZE9mqornGtqr9jReaq5ZhbtgDkQQK3CqWYzcZuBV9OGSqYCkLEDsicA+eIztTXIedwnyUQImEhAbA4Gq83mIcfxB5a8Bc/sKokaIUTCD7mMBuLsIZlBiFqTghiym3+H+fmvF4UPBHrYTQ0XnTaQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28XVI3MvKz6Uje75BfTagEnGU1nb1TBSS6AcascaVo8=;
 b=eVcatrzqeEb0SoOp3t/7ZjjYzR+9qmcftR5xnp8GoiA37f4qEcUyPP8w/tps4cQyWXsy9xJedkoQkhPYjfTecK/3WoryJSwfE4F+TlzZgy5c/PFEVNmBXIBE/gZqO1znoAhocDeEJdCooBcD43fPxQIiPacIuNNe9LElzfCsohmvBZ2KxEWNKkmIVFgMsiFgwByseVSVWfzQUc7C7+PnMV/3LOtHCqArWN91zucxpm/u4jLfW6hxMvL0Oq1dKGI8UEtJE+NUFZD95UAZrqG1uGtPlXw8no+YBx4SwoeFA8VK1GgYaS412T/VFYf8gANuInxuA/7TMn1b13DMAEjykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28XVI3MvKz6Uje75BfTagEnGU1nb1TBSS6AcascaVo8=;
 b=WZ2Uz9ztoYci12p7MYrAtfCdTxREz+1xA9V9UI5lcq50V4dUlp7FIE3dx50dv92Ow+7pxfZbav4fDnkag87fzWiGABTYkuJLGAhSlPhcxKwfzJk2RkGVEWv7j5uYO1NU1GXdIBF2pNYLYBWTkDuXCokq4TMKF7B7e5ZH3vtWr9M=
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 8 May
 2025 19:58:18 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::3c) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Thu,
 8 May 2025 19:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 19:58:18 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 14:58:16 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v7 1/6] target/i386: Update EPYC CPU model for Cache property,
 RAS, SVM feature bits
Date: Thu, 8 May 2025 14:57:59 -0500
Message-ID: <515941861700d7066186c9600bc5d96a1741ef0c.1746734284.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746734284.git.babu.moger@amd.com>
References: <cover.1746734284.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: f36f8fa7-1e6c-4439-26af-08dd8e6aad77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLk2NMHsWYT/B5IZ4VRQfPxEe/lfk0RzALSYTMzsqZ4yRppjYJ8Zbu+VOfpk?=
 =?us-ascii?Q?wll/vXD09FMU3NC2ZPyohy0XfHDbMkr0c70rHWpmk/4u5f3kZA1Evm8u+SRR?=
 =?us-ascii?Q?oIQO7B5frdXmYoEMosbW205KivgTw8SrrthF0/tHzNe/JkS3Ao3jXnDMwIrA?=
 =?us-ascii?Q?HOnZyrTUA5dtwhNh/5jgOMGu1asYeongj7LfyCbPFUvCt93HMIIQVecaKLDv?=
 =?us-ascii?Q?+nZw88vCh0oxPOTk6Cxv0ETsHAB5ahyi4CK3tzskHnF453dZ/58PuI1NS8lY?=
 =?us-ascii?Q?7uIk1ungXwNZCmtN8bcGamsYm6MZfh7PkC0KmLnF02+BARXnLNAPunjeskSI?=
 =?us-ascii?Q?IUo+GjTO+QCnxhYb/XIqfe7C6CO80eqXZV28iEhP2IUDfywnGoEF0HYGyqS4?=
 =?us-ascii?Q?srOvqqKOAHFI6o/eYOmvMYypfLjul8cQ+YL3Rqsz+umdWSWn08uRbEIQ1Z+T?=
 =?us-ascii?Q?WESyPGE+ebY4sSjEB+hXWSF7ZIl2gzElK1FdGIlkfUSXU0xhuRYCcAM3bhKQ?=
 =?us-ascii?Q?0fhpOvLfyU28Z7WOq78F1bgu7N5RBlIiNalOaSv0AbC258MwesueJWohtCKs?=
 =?us-ascii?Q?AnHtbRKH3X9r6RXLdcHSmc84l+1L5u9muW9gbM2WrdyuNTyk9BLyVFjHmV/8?=
 =?us-ascii?Q?l5jGjcQShygFaVqyrjs/EZybU65PCqmLA+YidUb49hs5gZUYJi7bERxKIj5r?=
 =?us-ascii?Q?TmohcRSmFpGsodMea23RCdHlIo+r+XoEhSlXNysSGOWi6XoROVyIPHOw+MIC?=
 =?us-ascii?Q?JHq+R/1oosM6YSfpbFGxRhH9T+g0XmUFfyZKp7hc11LP1n6uSogshd/ur+M5?=
 =?us-ascii?Q?q7kh5+NiPZctQoSHMhueEs0SiEkXbKjBgLUjVl6uOANEcpBnjnTDlPGAytpH?=
 =?us-ascii?Q?Z11rY+jFmR/lLcpgzYOea2WLGaQeEglf9WBhnp3TIV09jvX6c1SOSAb7wZDn?=
 =?us-ascii?Q?tCbIITlGRQ4rjCF2nAl3ku2oPqON+t9upDgzj4Js+eF58mkiOz9tLu5UuA+R?=
 =?us-ascii?Q?Hc16hQOce+L1RaKE9e5D9AGHd6G61WTeDGoxSoHQvVA9p6icjk25qEWRm6q8?=
 =?us-ascii?Q?O6BedYKF4SbOSP8X0q0PXHLENdGfkYX/dFNa9eESXZ0OR+I1cQ9i1mDqNZ8M?=
 =?us-ascii?Q?Ue0MlhljBrw8k6bvg+STW10IQq9DZYhTl+bwNk2ePvHlGS3KiLBzBQWwbn2R?=
 =?us-ascii?Q?I/os6nOLlK8BoImxbl8Gdp3P24JeUupWnGe6bIKNnjUbND/nEjt4WKCPP/Fo?=
 =?us-ascii?Q?NCU/KNbq+X9sldAbmHQcxKFV2Qm85Na2ZD4/r3IPETgaF4rjE4vXeoNL/n9W?=
 =?us-ascii?Q?VT5jMsXpwjYvCfCyl9oVp97xzelmMfDJVXhPe+IZ0ndUyPaFgICYjjPXkjri?=
 =?us-ascii?Q?E6G2b4XRBdPwaRLja1WHYRpFZuMr8jH5BmUWso8AaY9dNwJrIWqCrtNrvqV7?=
 =?us-ascii?Q?0LFdfRJ2y+qy1fCMYAjoAdjWV2Wssuw7xk3TUqEkGxWd9fTZ1NttOSguDx47?=
 =?us-ascii?Q?a0TNJdniPgb+Jp++O5t5okFfKlQLCb9CufkB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 19:58:18.3603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36f8fa7-1e6c-4439-26af-08dd8e6aad77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998
Received-SPF: permerror client-ip=2a01:111:f403:2405::603;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

Found that some of the cache properties are not set correctly for EPYC models.

l1d_cache.no_invd_sharing should not be true.
l1i_cache.no_invd_sharing should not be true.

L2.self_init should be true.
L2.inclusive should be true.

L3.inclusive should not be true.
L3.no_invd_sharing should be true.

Fix the cache properties.

Also add the missing RAS and SVM features bits on AMD
EPYC CPU models. The SVM feature bits are used in nested guests.

succor		: Software uncorrectable error containment and recovery capability.
overflow-recov	: MCA overflow recovery support.
lbrv		: LBR virtualization
tsc-scale	: MSR based TSC rate control
vmcb-clean	: VMCB clean bits
flushbyasid	: Flush by ASID
pause-filter	: Pause intercept filter
pfthreshold	: PAUSE filter threshold
v-vmsave-vmload	: Virtualized VMLOAD and VMSAVE
vgif		: Virtualized GIF

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21d5ed22..49d3ae8aac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2185,6 +2185,60 @@ static CPUCaches epyc_v4_cache_info = {
     },
 };
 
+static CPUCaches epyc_v5_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_rome_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5212,6 +5266,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_v4_cache_info
             },
+            {
+                .version = 5,
+                .props = (PropValue[]) {
+                    { "overflow-recov", "on" },
+                    { "succor", "on" },
+                    { "lbrv", "on" },
+                    { "tsc-scale", "on" },
+                    { "vmcb-clean", "on" },
+                    { "flushbyasid", "on" },
+                    { "pause-filter", "on" },
+                    { "pfthreshold", "on" },
+                    { "v-vmsave-vmload", "on" },
+                    { "vgif", "on" },
+                    { "model-id",
+                      "AMD EPYC-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_v5_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


