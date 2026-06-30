Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB6C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaZZ-00038R-Od; Tue, 30 Jun 2026 11:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaT0-0002C2-M5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:44 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSy-0007mW-Mn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4ybM2Y/jo9G2X9x+wnBRep9tudouWKMwO9bbwa1H01OIUiMPTN1aeIemdYytIwNRZoZqdZCaHn06megyYZrPaqfOyp5DfNpazk9imZyGCXScx82FhU8BK2tFXZyzrChvi7W7pf5FwZQDtJn0ObXqTm/cgF3PYh0ougXXBK5epCZz6oBoZhnCkmomu+QlAcw0QDQqjgEBc64fzHxEIZh4nh9LWQNGO0iwwmo31Ms2y3A7HDW4VxQ15qrl0/o2obW/bQHlB2Ow84BH2j6juo9gxp0cRKOyvoxdRBn9ty07VEChttyi6xz8gApHifrev+1Z2EZyrlilAfUljt5qXmWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5XmsXNTmfxFsgTQ+68ckYzVpThdL0ln2J3P8GTUhnw=;
 b=BNknws4i0ed6TV9DljrkI3NiQcmrFJOIBiPewOdvbeoAFRdxpZSdsK/KupooB/wrCAU9nkE9rz5lckJgVHHFXn9T0e0fCsrynWQLeXi2zOM3FiUYh89P8s05+dFxvuQZPCsp80XRUjQwDE3ak/kJ1xe1qPi6r8zHRuSRTdUmQaww11DawZzOrcaXksEh/C5S8ylJEi4J6c7u0ifid161LGGYO/1PU8vB1xLlFQnRN85jFNbm7J/TBj6QCjwq/FdfC745/Wkl5VBlgQsf91FUR77oFnfpovYcpmR17qpEUyL5uLtXXbcC/713qi6hnoGJppZygNxwVl7fdd7uVlxLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5XmsXNTmfxFsgTQ+68ckYzVpThdL0ln2J3P8GTUhnw=;
 b=F+ZzOl8vuFpbMwNJf7XElS8s5zOXmrviacxhwvM/rnj+ZtG193c8vHapu5RMASAJkUtamJuBRLVz0W007MSXvJFtuzDJRfI2ICVtuCa0EbLJZJIHw3ZYUex/1HDkjxQ45l5WDv2V1z8VrxoGhgc4DgxHbPMzi/UsAhg+NNsmgLU=
Received: from CH2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:610:51::17)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:33:34 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::8c) by CH2PR15CA0007.outlook.office365.com
 (2603:10b6:610:51::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 15:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:33:34 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 10:33:32 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 4/4] target/i386: Add EPYC-Venice CPU model
Date: Tue, 30 Jun 2026 10:33:15 -0500
Message-ID: <20260630153315.1585-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fba107-6946-4fd0-1807-08ded6bcf253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2+ZckHD4x6VSQl8wV8OEkHNQPG1Gua04+jOhfmfuov3yZX2x62pN8ia4Q6WL1t+U2ocxDh8Fz+5wnkoEnFnxKWvoZo6DqEg9oxsnwwpM2BkAYeg294nJlUxmZ4CXIFJzzuIKevc9N0BtQLlVhW2oyNbpqhKCORN+Mt1gyyY4i9kOzndbyB3R/yq482/OJi3oSZ5BLqUDL3Li9q/yzZ5Zby8vGOu/nBDeZjH0UCUiWyXJQPMVF8v1/z5bgjLgBj+aUQUSkRb55+3wpUWdG4aOdnK9r1JvHImq3H5gwarJJ6fQOzlCB29Fne8MsDFpMpJqq5hNB1O4qmcJQeFNkJ+EbrNFbD0wq87bR7dyw3HG2Y0QvjnDCaaAhCx5qahG29B6+0jace3GSeI6sUcVgiWiAg34meOmEq73+nF56pGk8MHCGyfKFlqyVyExlY8eCp9wYcN81nw1/fSAO5Ezh3Xrl3NNkg9617cbWrZUvoRC8k5d1nXazTQHQ7uEfMhIno2ddWPcQzv9S+y+OMQipn3qR2mzuE4ELmO6RWLVCpAKGoJimuEId3VjVIIKgt7DCFE5/n+mXlUCM+Xg5b/0fwezxcXkl9N9aQtIgtYCMiDf78/EOm4qhjILD9tzsCeXk6GzFfBFC62WUZQxljNB6iLGB4dcz7IHQqlY0dqWXsK0FrwOk4gPO0xVjPHpgOBMVrCMN6f3nYojU172BWB7vC7pjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BZDH0azkA3ZCEYpeOF9udgXHOeJB6kFyf5Rut2asuXmwlc6ZnRyRRlmiEc4xtu2iBBN7t9RrIfXlYcbBT+HbpzUTjAB/hGSmb+XKbjQysx6JfsBjYJZtXkcsTYgENZcPZIPIuYqwmWzTIv4VB92UvJWONmBL8qxWHwe+8XKZhCw0Sr9Bq8pN0DX+EsJ2YXoRh34z9EhUcQQjCt1TRmeQ8/GDRMzOjMzIQ4SYo7le9C711Rq21ckyls6KvGr7dLBKySRGoZugDajhl/SVxYX07IVM9F32X3kKNaGx4nk53HIeYDTg69zgxJAKXiwbKS6ZJAxf4jpFnQAR+3gTBpdX40BLMGQtlUywSdeGJo0sheMas2gsVm6SOmGXDFM1GlSWXwOzLZJdl8ZYOhqY6UP/vDnDhNXcZEGy7ivOOP7r21vv7eKxhPxUZHKbVtNgsT6U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:33:34.0352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fba107-6946-4fd0-1807-08ded6bcf253
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:40:28 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add support for AMD EPYC Zen 6 processors (EPYC-Venice). Add the
following new feature bits on top of the feature bits from the previous
generation EPYC model (Turin):

avx512_fp16		: AVX512 FP16 instructions support
avx_ifma		: AVX512 Integer Fused Mul-Add instructions support
avx_ne_convert	: AVX NE-CONVERT instructions support
avx_vnni_int8	: AVX VNNI INT8 instruction
avx512_bmm		: AVX512 Bit Matrix Multiply instruction
eraps			: Enhanced Return Address Prediction Security support
				  (see also: rapsize)
tsc_adjust		: Time Stamp Counter Adjustment support
cet_ss			: Shadow Stack support
srso_no			: Not susceptible to Speculative Return Stack Overflow

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9342cc3ca4c6..e6f9f3dd3355 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3048,6 +3048,59 @@ static const CPUCaches epyc_turin_cache_info = {
     }
 };
 
+static const CPUCaches epyc_venice_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 48 * KiB,
+        .line_size = 64,
+        .associativity = 12,
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
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 16,
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
+        .size = 64 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 65536,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    }
+};
 static const CPUCaches xeon_spr_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         /* CPUID 0x4.0x0.EAX */
@@ -7309,6 +7362,95 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
+    {
+        .name = "EPYC-Venice",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 26,
+        .model = 80,
+        .stepping = 0,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_PCID | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
+            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_CET_SHSTK |
+            CPUID_7_0_ECX_GFNI | CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_MOVDIRI |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_AVX512_VP2INTERSECT |
+            CPUID_7_0_EDX_AVX512_FP16,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX512_BF16 | CPUID_7_1_EAX_AVX_IFMA,
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0007_EBX] =
+            CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
+            CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
+        .features[FEAT_8000_0021_EAX] =
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_FS_GS_BASE_NS |
+            CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
+            CPUID_8000_0021_EAX_AUTO_IBRS | CPUID_8000_0021_EAX_PREFETCHI |
+            CPUID_8000_0021_EAX_AVX512_BMM | CPUID_8000_0021_EAX_ERAPS |
+            CPUID_8000_0021_EAX_SBPB | CPUID_8000_0021_EAX_IBPB_BRTYPE |
+            CPUID_8000_0021_EAX_SRSO_NO |
+            CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO,
+        .features[FEAT_8000_0022_EAX] =
+            CPUID_8000_0022_EAX_PERFMON_V2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_LBRV | CPUID_SVM_NRIPSAVE |
+            CPUID_SVM_TSCSCALE | CPUID_SVM_VMCBCLEAN | CPUID_SVM_FLUSHASID |
+            CPUID_SVM_PAUSEFILTER | CPUID_SVM_PFTHRESHOLD |
+            CPUID_SVM_V_VMSAVE_VMLOAD | CPUID_SVM_VGIF |
+            CPUID_SVM_VNMI | CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x80000022,
+        .model_id = "AMD EPYC-Venice Processor",
+        .cache_info = &epyc_venice_cache_info,
+    },
 };
 
 /*
-- 
2.53.0


