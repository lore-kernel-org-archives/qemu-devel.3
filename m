Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782EBC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4ly-0005eM-Hj; Fri, 28 Feb 2025 13:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4lw-0005dT-MV
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:40 -0500
Received: from mail-mw2nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61b]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1to4lt-0002PT-Jr
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:07:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2bLbYq48ub/cKbqoSntUQyhf91Hqk+eKwdGXZ79Tmc5HeKyiKKNwcykjM5z2DnqhaER2crLI9izhFj4B50paQFq8l2CbfPitaUFDUpMTDU/qOWQTuXIld2vLsgTcXplz2YXRZOBFSZMQl2didPhzd6k4EOXPssq1ajF4GVtwd6CMvGKy4QTMcQuXh14LtOF3Yz95MwsLkXEAJmJNGgVKikT4Z86bVBzsS4kV9aLGq07mshBw2VJSiScbhSyYWG1fwvH/NIlObnDMQV2XJdE2d5gJHbsltBo6BEbWXdJjUZ0Gsn1yb/JlcZyXwb8+ti0spelkANM3bnJ9GU+MYTxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRdZ3ktvIeY5uC3j64ry4xRSsWv1xvh05cTkux3ZZwI=;
 b=oJjlEZQ/TfzVO6PXA6AZ3ruQgl9MJvK1xQd/3desq7oZmH0V03Cge4VI/uJs9Y60ix+cr2exvZMg7E9UAMT6M+HLWjKckT3DZTDm1aX+Pl1Tg2U0KUKHuPnqEuhAT/RdKma+0NS7qkCGPZ6a1coWjSeu3PvChLak4rr/gML8vjHRiILD+TM79Of3ep08W7KmX33V5MA8vC5aO3fc2A0J+JytYY/8oD5+pUVl67Z5kFwqyjd5DgZss9+om05CK2SaraDOCKkMMUGPfWAsHBcwr/t8IvecCv+nI0NecBT8ZINNakhXYWFAl/X5erR/m4U4vJ0dWQuWSUgXGerYkEoUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRdZ3ktvIeY5uC3j64ry4xRSsWv1xvh05cTkux3ZZwI=;
 b=sTeLmgXSqxBOdPdK1sbEt39o6HSwNcLlHu9AOGxniZheGacR5MfrgBJ85hOiEUuvvFYR0ijw1huOubQpnTyxMdS7oZvnOVWBvpUhfq5LAsFbSXJNsI+vp5gUxqWClvVmRJFo55i1vn7K3crjPC9QPPyZqqbNTxknmFEZhGjPFhM=
Received: from PH8PR20CA0013.namprd20.prod.outlook.com (2603:10b6:510:23c::27)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 18:07:29 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::a7) by PH8PR20CA0013.outlook.office365.com
 (2603:10b6:510:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 18:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:07:29 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:07:27 -0600
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <zhao1.liu@intel.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>,
 <davydov-max@yandex-team.ru>
Subject: [PATCH v6 2/6] target/i386: Update EPYC-Rome CPU model for Cache
 property, RAS, SVM feature bits
Date: Fri, 28 Feb 2025 12:07:02 -0600
Message-ID: <96d40128682225b75e0f3c62c025b72c93ac8d1e.1740766026.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740766026.git.babu.moger@amd.com>
References: <cover.1740766026.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: c16c9771-7def-4961-1c56-08dd5822c3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kcqj3MhoHs5U+Fbk2Q8SbR6pHyzfFAiGQOiB8UdvoLyITyHvWn6iYYujRgvC?=
 =?us-ascii?Q?dtJyl6kPv2wqdiJ4dGldF5B8zWO80n/6p7GuG+6UoEmrrDgiU3Yx5ENh9kTz?=
 =?us-ascii?Q?Smesd+/yv79dQKxdCzAoUvIxIIP1Pfs6Py0MK5Ni7Ykg9iOet31OUwqXDFtI?=
 =?us-ascii?Q?9TjkLlrWNg12/GDV8avPeGFXCmqLFRI+qLVV31PWXLCKYgJ/WpxSKJvZ1LAa?=
 =?us-ascii?Q?zvJ//03MS1UDBWnBlvFIDjNiC/ZCCeCDeE7Avwnc6ucNMZ2Hu9KuiH94jQxd?=
 =?us-ascii?Q?Yo9fLcXbwibI/QlrM8QKdT3aZd2g2uvd7yIQL3cUQ61ry2ZJVZfyjWjW9vLD?=
 =?us-ascii?Q?pZEVfADuvAi4+jJMgO8Pesh4lTWWJ9qu9aYqAh94gE01Y5UMNiqMGIPlqOp6?=
 =?us-ascii?Q?9GKj+E9iKZBd7h22EtjnEj00QYT2+Sz3mTzY70V+0CofH3bKO2DLLhNi4ntW?=
 =?us-ascii?Q?Any1euOitY6dEWXHGqUiQCIHo0k36m8xhOAN+lIrregEns+RsAuLAKQ8rYfv?=
 =?us-ascii?Q?Y6ubMRe60H/xNPTzEZIMqO8ftyICH2Kc7cwYIMHV7x3TM8fCRHHGDo+qeZQN?=
 =?us-ascii?Q?D5mTSomAIne12cs4SMlLrojfCJm7ElluZ6E91Ff/OQL52KfbYmNkIr4As1Ff?=
 =?us-ascii?Q?o4u5s00+e9IX4Isst/igHeveESN+eup1XWL7bfftfqzR0+kUO9U5KXfp7aND?=
 =?us-ascii?Q?bYfTOJyW+D5hV4OEeNIqXRaegtrka7C3AedJJYynG8tKzwWal+GyIxiVxeVI?=
 =?us-ascii?Q?0QscaLxxnB6KVoKZEn6Ru0GUl8L7FJ3d9QNmkkXzCWAIiuNBLZcA/DG06NT9?=
 =?us-ascii?Q?lenydRhN+TQ8FN51Bp2UPX7sP8iNg4bxS5pv7/niV353j+JdhlUHnSaRMciJ?=
 =?us-ascii?Q?LhU9F1S5IUSt3NQHYlO9ZTzWc2TIlDmYvBOKKly4BRrJ46g0KcDo4fmKo2Wr?=
 =?us-ascii?Q?8LrgJ0NSjO7YS7jmJnqBcJUSbiaT29OGx6TX1ylXLZaHWjtS2PLJtRvcpLW/?=
 =?us-ascii?Q?b+UsTEmIhvwaXpPLbP5P9wPJDGYp1CzNddIDEqdqnFfi4kVwpp4jjd7WF/Tr?=
 =?us-ascii?Q?blkX7lQPWXaahb3mtMpdXqJgijgSOqSYCQbxNBucf+msAyedpqEaDYhZVA9R?=
 =?us-ascii?Q?B/PWcn4ZiIMxdjKGethcTxKAZ11xvAIKo2Fa6mp+LIqx9wPEVYWWWiTPF/GF?=
 =?us-ascii?Q?Yaze9HajdCzYjyw468FwKg+6Mymz/vsY8b4kq4cB3CYjm4CkIFDINPNLOXIp?=
 =?us-ascii?Q?YtQjBm1S0OV8j7lSflLgmdcFctPZFAFGqUysNbFN8kiopIyR1OmsblXw1n62?=
 =?us-ascii?Q?dXh3TxzxJO8QqgGppVvFzisumlf4SqdNM35IS2py3v2Ley+p72xGDt3QO+k4?=
 =?us-ascii?Q?KQt6oTDDCuYgbWXxaH44v93O++/bGwNjgxTAZV5sdqJIr2ns0qzuJryImwYE?=
 =?us-ascii?Q?h32chLDsMpZbKqBFqFoD6vXXNwAhl53ezofGvdszhN716dlGg/Lb/9hAzo7i?=
 =?us-ascii?Q?Ut8QH8unS06xuFw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:07:29.0933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16c9771-7def-4961-1c56-08dd5822c3bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
Received-SPF: permerror client-ip=2a01:111:f403:2412::61b;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Also add the missing RAS and SVM features bits on AMD EPYC-Rome. The SVM
feature bits are used in nested guests.

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
index 7908b90b77..be8dcf9739 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2342,6 +2342,60 @@ static const CPUCaches epyc_rome_v3_cache_info = {
     },
 };
 
+static const CPUCaches epyc_rome_v5_cache_info = {
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
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
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
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 16384,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 static const CPUCaches epyc_milan_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -5418,6 +5472,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { /* end of list */ }
                 },
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
+                      "AMD EPYC-Rome-v5 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_rome_v5_cache_info
+            },
             { /* end of list */ }
         }
     },
-- 
2.34.1


