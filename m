Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FBED6A22E
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgaM-0007SB-KR; Thu, 14 Nov 2024 15:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBgaL-0007RR-9l
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:37:01 -0500
Received: from mail-dm3nam02on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2405::614]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tBgaJ-0001Xs-9z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxNHDkeJEXKzPqZvrHRZ8WX+zZnxlLrWRpLNX9mCJcKhZZK5FAKEo0B+FQrgcUoJee9/+32JleLbY96spNKh3QE3CJDi/Y91a4qgjbD5Cdv5v6JM7P6ugj/FoELf4o3umM8prqAs0ZJ3NFFC81ANPmsS53QAPTK/5/+yF81nCT9DESrjk/s/db0hjetXqRdS2nve7Wm859W4YOJCcwOYtFv9ZVBQS27wr8E7DmylcgkJpfRb3S5jHTWE7WtvmEWjSm1RQu/RWMeiKSvBrvx0LdMo6zDxhOvR5wfaeyn/fA5rJ4LUr5HXacyn/eqCU3UDy9TPShPrAFk76N5QjBt2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+X/vBEGWBm37xJRg8XgisVKKEk1HfiD7C/rN/hd+0w=;
 b=sQxnfD/aMGKso1oOlVd5fRDkbyIENv5muvWArg5FC5QwP1PPJG0njIoHyX3OkOHqTZ2LTvI7E9Y2t7GchfmShIcz4o8GmosM6Jq1U0B8mY6Qk6rhfEuZHS5HBA+a9L02UargorN/5AC8LHCIVawY+LAl7wGmGH7ijJxlA/WNkYP8KgTtki+ZMSTnzMCz6HFnRHX0EkvqflRCLnZzPWk97rJVKG+vQ2rbgYu/nMXsmKi9yWTCcbVZ4dQ4GOHRkByH3apF7dFsfkA7r9Csv1WqA2WEcWK0BZyBcWxqToAELrhaMTbs+7R5FYqRUzPU/YLMAB8x1sEa3DlppCMQvoTqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+X/vBEGWBm37xJRg8XgisVKKEk1HfiD7C/rN/hd+0w=;
 b=va15nKHMguFSXz8ytLFMNhNRJhnfhqffCWqXD7w90gTou00tPaGOuycb2VDnYUAqNK37HRyuf59VG69UvMlbZuOnHK1fVe8ZSBlWhfI/NLCor36+/USq/hI5V0r4TT3RBU5osIiXO2NLwPOA15oomKlrqz0agRlmO/tjrMTdzpI=
Received: from MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::26)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 20:36:45 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::8a) by MN0P221CA0002.outlook.office365.com
 (2603:10b6:208:52a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 20:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Thu, 14 Nov 2024 20:36:45 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 14:36:44 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <davydov-max@yandex-team.ru>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>
Subject: [PATCH v4 1/5] target/i386: Update EPYC CPU model for Cache property,
 RAS, SVM feature bits
Date: Thu, 14 Nov 2024 14:36:28 -0600
Message-ID: <6528e2424b99948b165c2938b5ade9f32e1f0aa8.1731616198.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2a3dcc-3820-4040-cb89-08dd04ec0e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8GuHGqh+TqH4Ao8Y9ZRjuIpNMWxfO3PGmcVKxhfiw7lBkEV611Xqp02vhIHc?=
 =?us-ascii?Q?8zIgNVS9resx0518ylhEYL7w11DADyYV2G2aOOrFij9rcZbX/MxCjsAciayt?=
 =?us-ascii?Q?ubmq+zPLFA0YllywD7uEhh3UsyOSEIQ9kox/GGPMqwSM7Ag9X9B/PPolJ3Rt?=
 =?us-ascii?Q?2FAfYl9xDWxh5sS3bw3AnTUs942JYA50VULOT78cVTE9BVSHM9AP2xyeZ1eO?=
 =?us-ascii?Q?fz6+2wiZhIVZ8ey2rkyzuHdv+j+TP/nNpdwFpLBH1dW9uM4o4YgtRJM0VWCL?=
 =?us-ascii?Q?un5M8yq4kpuAd/M4Ba37dNRIEv0a5KhYMnm0akMP4kq8eMWwdt0VD6FSg+6F?=
 =?us-ascii?Q?NCqWwgpOT3WZDwOI7ygN+TDrFpeHqjJEtjZ4rUKp0FqrtAj0obsvWKsxpRDx?=
 =?us-ascii?Q?aHBJ3t7whahKvLah8cvV/ZAYYuBkk8LB/Usv6ETT5TByHPyKCmmh4TsCMJ/W?=
 =?us-ascii?Q?CXX7lZwYaI52oKsvQynWUJh9v7J+GdVT+vuUVtWYMwIkvTmlNKf0+vLOeNHt?=
 =?us-ascii?Q?NFgqgTsJOIm5d9IPhUxIyCZDOboRGCYm5zUJO/zBDqXI5mZlSxPLI29RKxgG?=
 =?us-ascii?Q?PodI1HZCuBpohFHzY+3ymeuVrk3HsBnmoZgN1cIladrVOP6MSHsM/FX8Q/mV?=
 =?us-ascii?Q?k8woK0BGbcoKI7nLjb0Uzc1j89IPsHnsTTPVonBxS62+VVIEscHXyxwKSrdt?=
 =?us-ascii?Q?WEuLOfrJ2xvObidcItSz/OcKxupSOAE/N+azMkr7RFbRs08ZwG+K5v5L7OPk?=
 =?us-ascii?Q?/9EIpKazB2LeF526CaRbMxMSwQW8eES5jhVV1hjZX7E5p/XJZPRG7hBTdEek?=
 =?us-ascii?Q?d4aJvfWL/nYHPO1Jq5K5vEkF2FAeOncsoF74jxI0X6X32vWaogvRDgjW8Ftl?=
 =?us-ascii?Q?MtsPCtkFd1eRE0t1/vqwJZMb20JHhI5WMbU0t8lMLheQCudPrSUXvcTXqh7V?=
 =?us-ascii?Q?nnG27ZXq2kq/IQtnsD1kIkhbiw01AUCfRcz5xEs9s9LwDVWDqmgb4VtihalP?=
 =?us-ascii?Q?zAbHb9U3mgH+U+a/17ZdwDrFuXtzbx3cNBCkWdGq805ELdlR3vvb2oCUfkwy?=
 =?us-ascii?Q?bb1/AhRebB6mGyWd7VRrMCg3JtvfHIablYhyimzr1BWvKRk1hmPppDR6K+RB?=
 =?us-ascii?Q?s5MWf7TmXpAT4QyTAByYxt/btTJCXBBvwjbOrCbwgaXApX38AW0LTj9EONxb?=
 =?us-ascii?Q?ZMCAwG4eEbwL1LTuNSnSXp4V8LUgEh9KAI+iXdz1PmxLPd1V+36PBVKfWI4m?=
 =?us-ascii?Q?3oVyMj1CsYK74rtTVy8jV3tVVwGO9j6xAPOK5ewMPiiy2+O84d9WZ8c3RvFP?=
 =?us-ascii?Q?0PUKbtbr9BuiXVJ1JLXO5kAtWSUa62fd3qp7eDP/+k5O8MJaIvf++q0xMGHD?=
 =?us-ascii?Q?1df44oM4jX4Vm+4lsvNpO2q4smI4HYk5MVJQ7QzsFUdu1U5TOA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:36:45.1251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2a3dcc-3820-4040-cb89-08dd04ec0e1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Received-SPF: permerror client-ip=2a01:111:f403:2405::614;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
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
---
 target/i386/cpu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 58c96eafea..a632c8030c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2181,6 +2181,60 @@ static CPUCaches epyc_v4_cache_info = {
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
+        .self_init = 1,
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
@@ -5053,6 +5107,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
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


