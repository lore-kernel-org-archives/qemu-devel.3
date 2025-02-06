Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6984DC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg7ZD-0004GE-Mx; Thu, 06 Feb 2025 14:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tg7ZC-0004G0-3R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:29:38 -0500
Received: from mail-sn1nam02on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2406::609]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tg7Z9-00025Z-U3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:29:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjGBlUrH+Fwpc4n/bALvSiCSMHJcCxZrcLEfH/GHDEjjoceW1e9oWFtQrdhT7wr8QhEGZOeeSkZ6dfpgegtkP8TLyrRYWx/dv+PYr2B0s790Ft64u6Z+kyjnJFjs2jKPQx9+VdjJwMit8ammbQCH1TKzjn8CuUPCOF+WqheNf4R6FDveEfVr38fBgpOu6nGkSmK4wLKss/AvTHP0MuWxCviXoSjC3a0bEhmbPu2S1FRazF3EzOxxygm7BnCDfIRqCrsyyqvSInkPculb8+TkVmkxoPs3uffX9CDPrE+snnwF98PMrZwHEiHqM5MwoTNHr8ZWdUBpWJ9DReMfR4XBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOl9pJQKj1xLroWgKY6o1/b9r970ubPp5ZKcJUFcQyM=;
 b=MGH720SD4r3EBjl1GgsuOxMGsso2LQBHsufh8Ur8CYjHiB79Zalf1YB4Njq9yqht/MhLZD/kt8jhXGxDv+/2K9g4zh3Y3q0EQZerkgO8j6d6PqlgwZymNfU/AoKiTEKL7SL8B2/qTP/BI4OccwqFCUbiwwboYWPrjn0TXhxkwKvwnzb2qKcT7JyIJFLBeJe3e1lQmsfuDVliu2/d5Q4QKAF7qW0iZ1ukMZHlKENU/HJwtnXfI0wK4njXnbzXG4LztFHTexEdghw40DU3F0/0Zzh0fcUCq53Riap6PaYuxicokYu2SBUC6oBw4xHh0j9SN3g/AoXnMCrrot6aE6dJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOl9pJQKj1xLroWgKY6o1/b9r970ubPp5ZKcJUFcQyM=;
 b=tH7tX9Ca3y83Fbvp9Jw700m6PEc22fLhhYbwUXJsVlGtJ8vOGKsiAqMVhnVwnLRCd+RWw/H2a0M0tDzqqSynfrPl1jZ4vd4bFqSGBG3WilVXEipmv/EAND7HB32sWGbmzuHcXCrHpSDToh2IiFvyCwyzQqS/SQKTVUcYBIg0yUY=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 19:29:25 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:bc:cafe::e) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Thu,
 6 Feb 2025 19:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 19:29:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 13:29:23 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v5 5/6] target/i386: Update EPYC-Genoa for Cache property,
 perfmon-v2, RAS and SVM feature bits
Date: Thu, 6 Feb 2025 13:28:38 -0600
Message-ID: <ded4e65f9c9109f0863d1a00888b1ba48fab1549.1738869208.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738869208.git.babu.moger@amd.com>
References: <cover.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 07144e46-5106-4fa2-096b-08dd46e49061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FiIYFu6bVa24cmL5HBOgZ1u1+cG1/phEFAIaP79fuMoj5GhrXGV2w3cs0QjW?=
 =?us-ascii?Q?1/CwlKXJojtC0EAAXluhkT+0qTB3JDz6wU6Edx+aBEptpo5EAKwSqEpjVnn+?=
 =?us-ascii?Q?Kqz86XxrrpTVx0mBPTGiXEGWMBIk5YInxqq5+in8lg8LmRzAnuWwi6CcuyTS?=
 =?us-ascii?Q?/yZUAI+cmsPtQdGoOzTSWDZQTzFZSwSuCb0K/et1+lMLblbRJHkHj/K3iMuP?=
 =?us-ascii?Q?Ve9HPoo6I8RBr7M+5HA6Vp5zNN5EMKA5rucL1QSU+SKsFmX938XixndFYbsg?=
 =?us-ascii?Q?fRLdx8ZfOzV10625FYgIfJot6DsJc/QclGHqW/4HUfSyQ9yvlUFY7cdRrS0K?=
 =?us-ascii?Q?zvoCMgcAzckRvzOur51oJN6MOysfX9o0q7DVHx0gXFvh1Xyd9S8UPXoEnpzC?=
 =?us-ascii?Q?Ab8wREAw3B8bk6aR8g3f+ZDW/Ee8gO/LGODD7HheBcEnEp1G+DRclaX2A7R/?=
 =?us-ascii?Q?Xal94KIfwTDIg06GnHQmvKNeZccmyJxRGZB4dYdXcP2B0yUvABi1ymGmkH1O?=
 =?us-ascii?Q?9+oLOFEvX74wNs7UW95m98Zlx9OcrhMdVLMyLCqZBRcc9VwhkZwHSSfFGEv0?=
 =?us-ascii?Q?AfjBySbuv3BVYThqclpjHJ0PmCda+k/CdbWUKTBI6mntieA0Ly2usHQznUhB?=
 =?us-ascii?Q?MGIBYdrVwlRVpql2OJ7Tdmu6YyMt2GOYMhvFR2qxbMA+wNRNpsBqSFgzQkL2?=
 =?us-ascii?Q?PfKK3hq4dtWI9t7iELbP9t4B4FCOXw6DAJD0i/jSIXSdIEfKUJPNtNgUnlq4?=
 =?us-ascii?Q?KjnLL8IJ2sHLTtsVxSsKGaGiw1YQJOZ69wOZ4SJu5MSmhtjATGfqtJUYzlp8?=
 =?us-ascii?Q?/MLyc4avnxM1qdQKXIKedUcr4qiI++dVu3K0htgF2929EKqGoznp/myofSuB?=
 =?us-ascii?Q?yNgHVle7RQSuRdQymY9jjnidufwfb102KizErkjFR+ExNeD77VTsqCxQPHhW?=
 =?us-ascii?Q?nE8r+TdHitoGbMwzBGz/dBcNF+Gic2kADD21b+EtcPGQCp9hnXCb62hW9j3l?=
 =?us-ascii?Q?XEHScTuz0bYg+iTDG+Z4Km2rj//qEbxgp8bQmHzECK8iru+DRvrq9YFICsah?=
 =?us-ascii?Q?iGTJ5NND+8ys9Nch/QBSwJLUZoOKVU/faWRLLYajnSz+ZxOUyLET90iLqCWH?=
 =?us-ascii?Q?SlIMs9WDRZpYJVGELNI7lh/VCsmEFmfLKhVkP9eYPRMOdptAr2nJ7y6IYGbu?=
 =?us-ascii?Q?PPFV4lg+uIvO5cGgAbnPZRP37bbPjMfXHjkrUYHud8rFLd5DS4PY06g5TfSa?=
 =?us-ascii?Q?Lyg8xQeHb4D3X3hli1HQABMfDtmIBGOzLfR4qUphHAylEFv7Glfero1bHy6d?=
 =?us-ascii?Q?GAqw361ld3NvV0CZl7Adxg4fqOAbx4BxKCzTPyL5Meix8zGIP00g5W6oF0N1?=
 =?us-ascii?Q?2yu+mKYcm7sHj46AFUo5Oz4hUPqDnCWX8tLYZ/7VSivMwoIat0nEodhM0Tz8?=
 =?us-ascii?Q?CUspixkm53s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:29:24.4307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07144e46-5106-4fa2-096b-08dd46e49061
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
Received-SPF: permerror client-ip=2a01:111:f403:2406::609;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

Found that some of the cache properties are not set correctly for EPYC models.
l1d_cache.no_invd_sharing should not be true.
l1i_cache.no_invd_sharing should not be true.

L2.self_init should be true.
L2.inclusive should be true.

L3.inclusive should not be true.
L3.no_invd_sharing should be true.

Fix these cache properties.

Also add the missing RAS and SVM features bits on AMD EPYC-Genoa model.
The SVM feature bits are used in nested guests.

perfmon-v2     : Allow guests to make use of the PerfMonV2 features.
succor         : Software uncorrectable error containment and recovery capability.
overflow-recov : MCA overflow recovery support.
lbrv           : LBR virtualization
tsc-scale      : MSR based TSC rate control
vmcb-clean     : VMCB clean bits
flushbyasid    : Flush by ASID
pause-filter   : Pause intercept filter
pfthreshold    : PAUSE filter threshold
v-vmsave-vmload: Virtualized VMLOAD and VMSAVE
vgif           : Virtualized GIF
fs-gs-base-ns  : WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing

The feature details are available in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 target/i386/cpu.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 710b862eec..3b6a630b65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2612,6 +2612,59 @@ static const CPUCaches epyc_genoa_cache_info = {
     },
 };
 
+static const CPUCaches epyc_genoa_v2_cache_info = {
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
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 2048,
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
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -5713,6 +5766,31 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Genoa Processor",
         .cache_info = &epyc_genoa_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
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
+                    { "fs-gs-base-ns", "on" },
+                    { "perfmon-v2", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v2 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.34.1


