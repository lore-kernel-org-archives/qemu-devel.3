Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D8D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgac-0007bx-Nf; Thu, 14 Nov 2024 15:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBgaR-0007Wq-OE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:37:09 -0500
Received: from mail-sn1nam02on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2406::611]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBgaO-0001m6-Am
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:37:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJbiAadD1YgxpfN904GHsb8O4iHjB2sVd9J4FeklsTuN0mX3elGBn2Ln0Jt1FiUN8J5DkspN5WEc76KpnQD7ytjshqXK/k/5ToaaixwMv5cCd++UH728MbhY2QYg74apj9ZMLJz8hTX3ml9sCML49kyvY4JkmsUzmDL7nHqkm+vIBlzMwc0KWMRyxHAYmsFX3nI/kq6R575dQd263q1R3KvH1ORheryNbVLce5CgPkYqrQ5T0rnY2Jjk6XKCp8hPD8wFbiqHtCKe6xpyqAK/jldvQ017TmiosBa18Sy9//lYThWCYu0GibtO69CrysR4hypgWzEIT1nf+dKiT7Hr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEcinZ9flLyZTr//gLMdTQcANxNQX3YMcAMHPxvaAMc=;
 b=NAoLgiIDOYxgfVNkVI78P/5mxusAl1a5SJTm8B2dn/DN8QsdKvTSxYX5eudlns5tdInvWpmB/78+r+N8NZUpjBcWWvhPQiQMvDB/cA0BmAacb4scTRwR8G9peIDSXT+OCswza112G/d8hLFF9s0yEJ7lnxcpVc1kSxwqWKii5HCvpYy59LhGdwFjzRUJPnPvnH2nqopIGjvDokozIHvFzo4U2Pz+FAGnUVAJp5ctFiSwHz9qxVUzqv3CXXpOPb7gbls2mYXVexTYnoINCyCBP4UZR7en9g1UHEIlIzPv87O8ia2IfxTn4dbcLgns1kkR7lB9xu/a/rn6j0mEydetDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEcinZ9flLyZTr//gLMdTQcANxNQX3YMcAMHPxvaAMc=;
 b=nfHKm2z4qUtlURLubE0VT6b1eNjRWuAG6EYmgZgdVPvYxecLRh0SN6irFFIPpAuhkBl6SfAXdnffcYjQBI5ec9K4RK1/PPj4oy+RR0T7m2QkFmP1YQaJ5Pwu3dyNomUzKg8tda+2/jSydNxR8o7dB1yS2kMj6X7lPN9VyyVNG8g=
Received: from BL1PR13CA0161.namprd13.prod.outlook.com (2603:10b6:208:2bd::16)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 20:36:59 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:2bd:cafe::53) by BL1PR13CA0161.outlook.office365.com
 (2603:10b6:208:2bd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 20:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 20:36:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 14:36:58 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <davydov-max@yandex-team.ru>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>
Subject: [PATCH v4 3/5] target/i386: Update EPYC-Milan CPU model for Cache
 property, RAS, SVM feature bits
Date: Thu, 14 Nov 2024 14:36:30 -0600
Message-ID: <dd94f3911697dde1cb17a9ac959ef4e972556611.1731616198.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731616198.git.babu.moger@amd.com>
References: <cover.1731616198.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7adeea-09f5-479e-9778-08dd04ec164d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JjX3zUVbWIjy7bNGa1MuLChMJ1yF7gm+/5TiG3oyKiAPm+EKcVwM9oYudLfQ?=
 =?us-ascii?Q?V0mJyASaInBI+YNMNJRyjKVEYVcnxSoD8tMj65DxZesNaoa3/JaSypN8VR/B?=
 =?us-ascii?Q?r7B1wG5UbdgHGeM4dWVXLbHOf+qkLi79fWgOGKf6EijpigPq9JtLJ9pWJvMo?=
 =?us-ascii?Q?Kg1hXn0LBg+hr+tIHdYaGgm56bt/BaC98cne832BczYFK1BFbgWnWEcFBdcW?=
 =?us-ascii?Q?aqy14hYbqrKlXWnhsETYYR1R6w4EI8KO0VGvpknb3tUDST/bosutITlALunV?=
 =?us-ascii?Q?foZoOoHaBdGkk9X+oVfNk55KSix25sYkysWYIIW6dGt6lydyrT2pQqI1Xqqt?=
 =?us-ascii?Q?k/56v5SsvKt3lHFl1e2aGepYvv6D1saznniW30gNq3yt7xb7bTqH4yXaddds?=
 =?us-ascii?Q?n4HPwgn4a5Th5uTHv6MK+zDqfBft1c3zW2C4x6lAwJ/PYJJqzUmNJCUVwQV3?=
 =?us-ascii?Q?R9/rypkEVUVpjMeVG7ZJa4sk1M7vmL26HPnH0ovLVjmHSAbl/mrA4GzEJw9J?=
 =?us-ascii?Q?cF8FkO+Hx82zLcIJ6NOBorxEZRd5kt8/Aie4csGUs8Rk6uy2Lr9d8h1XB7Lf?=
 =?us-ascii?Q?P+qaGy47Xc+NZu18B6lWGJA3NxeCO3wKlX31QruDLzFOrHtlP7DPvjoMn5B7?=
 =?us-ascii?Q?6fK4K2tm8UHnFrA3D4vMt+4ZJw/iOYzt9ZLZO3/0teavgWRb9s9M8AvJvoys?=
 =?us-ascii?Q?It3Vfu6kmK8PyqeJuB+E51OYLdqn7FsqnIWD+otUsKQD1urIltMFCO2Vl1cT?=
 =?us-ascii?Q?1IMO2VVNUxc0POT0ezVfJeMJm/Kf9HBRW3gZYqde+TZtrmTzJVtdlOLIbv1N?=
 =?us-ascii?Q?B6vXm++HKwC0NwbUxP4mzYCYjGhKDPliG4vaKBUMGfKgaWYAHOHWZSXbZzHP?=
 =?us-ascii?Q?pWgdTFm09fVDMibrRX0AaQ/+bIqOFiAB1Nmq8TVuWEYKTV8OYP0Eo4WvttHD?=
 =?us-ascii?Q?EOLIqQpmpQuXrFbMCYO3nO/1cKadtH19TQMMj7Ik+92YUFaKkXgBtweo2BQc?=
 =?us-ascii?Q?aOFEObJB+GIHUmrh699WUIub5R1BN77kQerHUs4rKfaT1C8nOOGy9Z1IXDIr?=
 =?us-ascii?Q?Djpk6NsIkSAmjDxOsM3xqN7iXrv/6lXnT2iz/LbVO/Nk0/NLyK+m5hVZ4lhR?=
 =?us-ascii?Q?xqH5kQ+HVGvvtdHWNfMRz3TnDolA5bI6+P/PNvuPyYeWlac0zSv9hcwMzwZc?=
 =?us-ascii?Q?nXwXyaA8S1Cq20HjiCyHfBme/cg4p/L3Sokbg8xXmdZ6TQligG54vduD2tQ7?=
 =?us-ascii?Q?wfgryj30/x0sco9/QsS2ViIoGNR+nelp4+C6mROhwT2vXksPtz9BO8kWxZvY?=
 =?us-ascii?Q?FW3Ve0FuMPPe5El9bGXanQHw8oGXwQLGoR0scfCaCYNtIBqVP0MnfrTAuK86?=
 =?us-ascii?Q?HcRBKbIA9u72AjboQNP3UDObtLmp5E9hvsih+GgwnhAwrRTLaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:36:58.8785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7adeea-09f5-479e-9778-08dd04ec164d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286
Received-SPF: permerror client-ip=2a01:111:f403:2406::611;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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

Fix these cache properties.

Also add the missing RAS and SVM features bits on AMD EPYC-Milan model.
The SVM feature bits are used in nested guests.

succor          : Software uncorrectable error containment and recovery capability.
overflow-recov  : MCA overflow recovery support.
lbrv            : LBR virtualization
tsc-scale       : MSR based TSC rate control
vmcb-clean      : VMCB clean bits
flushbyasid     : Flush by ASID
pause-filter    : Pause intercept filter
pfthreshold     : PAUSE filter threshold
v-vmsave-vmload : Virtualized VMLOAD and VMSAVE
vgif            : Virtualized GIF

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c21b232e75..4a4e9b81d8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2505,6 +2505,60 @@ static const CPUCaches epyc_milan_v2_cache_info = {
     },
 };
 
+static const CPUCaches epyc_milan_v3_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
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
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_genoa_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5412,6 +5466,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v2_cache_info
             },
+            {
+                .version = 3,
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
+                      "AMD EPYC-Milan-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v3_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


