Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED123C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytyr-0002Ga-Rs; Tue, 25 Aug 2026 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytyq-0002GR-AX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:32 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytyo-0000x5-Bx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fA1/xdySNNG+Dsupywu1wpV/78bhbH3sirvGLtT54+H765Oc6fOUQHcyg7xDQfLtJPfmRBnNQY1lWhaFDpXrdDX8rflpMQdfJULRB3CB7MhTejs6JjBBJR8HPu/CPDBqIRKdjr9L5np9ErZH+QMMuYrBfILk3NrdUF4bAGIURzCCXV0h1jL5YJUelL7rxfu+01sCsIW/QqUg5fNBzTNgHHxbGNZVpQJXo+FRW0Y71ybSuFH5qqV0I3AqfuDz1Y+aGyhYP33KeecFhOHypzHT2bdIIME1dkIf5oMdswdRTKGF6F9eqfXMAO9EVBdbw6BLP7QmK4KAAHCww+QEpz60Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qGeIxUdTClhKZwMOgIj7CqzAimDBNurYrQ8DRVSqoE=;
 b=ZO02hcMWftwkbw0IrIM8GIgoj+t2HHmxBHMVcWwQ5Hmmk2fg8neYM83bMjnbL5U2/EwVToXcRwF1jE3Q3oWtp6Nza24LY0G2agt824XbkX7XoBOjI+zeLnbxZFC/CAK+JchhK+krWEefZwZXawKgKmuIr+vbK/WJKhSizVoTw/2huXMfHJjT+ewJI166xvmDFaDC287He1o6H/OdacCxtxwP11Cie+IuMcrm38R550Y753CNCS3qXe5hVoDrlVe+YU6mLXk/XWRd4SIhnehHPoaw5GiUSw1HXRYKGIp25LqeW5AmFLSCr50mY1JEb9vzO7mbryH/CWIWGpNgnucqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qGeIxUdTClhKZwMOgIj7CqzAimDBNurYrQ8DRVSqoE=;
 b=wrBdj6+hGqzreQo1dmB8cflhsjEtj/H8u3DkUbx4XQjo2NXPkoPP88gxF9avLKpMPi6T/0DbbPAIjZZ6SN/8oYgoDdZJ1YmuoRI9PqM5m7qpu89fvvBEzyqmr0aEOp75WFs7MjNFuwhNLG822ze1oE9NhZUvzCLU1WAzLrWMSVg=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by SAWPR12MB999318.namprd12.prod.outlook.com (2603:10b6:806:55a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:26:24 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::18) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 16:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:26:23 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:26:21 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>
Subject: [PATCH v2 4/4] target/i386: Add EPYC-Venice CPU model
Date: Tue, 25 Aug 2026 11:25:44 -0500
Message-ID: <20260825162544.18633-5-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
References: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SAWPR12MB999318:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f43c4a5-6856-4a3e-1ab3-08df02c59ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: A+aptgIP8N4MFHOK7G3T/EdcURLvwMkA8p8CSmrFuicIzSFss/p+5apU3fnkO4L3wfZAAV/c8Kc2YzcHAk6dA3ktzo/M7f+Zyk858p4F1cRy1YQvtZgfQfcejsWstzRzi5M7iR90zq01NPUCnR+YhcaLEdk3px5Wt0YHEh86VkngdIQdQyIRprAlZd41NO7khb5P0m8l1xg0ikPfAuT7x5rgBbQqV0zIKIO0zL9FhQiOkiZb2ZeNm5WcP9FH8mmVwRjRay8bWHM7hsf7Oaq1RL/im1DOS83RkdL8pkT5DSmzxGysYkVjzfZRQyq1H3ib7FOs6RnJRkQTzMs/yMBtBvGFKZlK3WKX1FkMjyeE8pdTPAOr/hY0GlSv4WSrxrAarnCq+SBb5TxYqkZccFMHQKSTtE9ccMaj4q7+uDxyipORmwdoOF0b86IsDj1jJP2rOB50o8bkOqdkrUsRMWZSGu0/pqwRgAeAmbXs/Vvk0LaRF9fXEdzdENZnj9QWmsEZZ7GEQMO/8kEBc3vBjITAdfkdpXNVpBogmU0ucjl6YobgoeAkTn7IM7eEyCMyHdY0EALRebU7/rLUIejraEJ68iL7HM0mkuYl5/JEJJjdp8NU8N+nzUwROoPL1twieClmv+vZFyU1uQ+pTKZVN1CBWYptG8L/DonMlkPaCnDJ6gTZqTkVC25o5ZjX8bGCcNIfF3dKKxzB6NTpz2AFw1AW+w==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cp8KFyG1nq98hL1b7fS88YAqDUI/L+Qrm+TzKdVdQMBbrRRa4uVCIteBl2Mfs9WjV9ctrPrLc05EctNwYJA7fd0SUVg8/HmZ4Qf+CnoKT3TMcB/mbVOvq7eW1MwA/J6yUUtDPWatFWL7+ti9wHptGy4Y3Yj0X19iZkuPlqtMhDNFYJs9SMbKEqkLtSlm3RvyMki3MB3TeyWobfqsbgdOBJQHaQ8wA5ooD2xePeTeXSmjn80pFAlawIKk+8aQ/gBbHR/m4gyY/Ht+u2nmo/axvPeyt0qqi0jjujMiRATdaJp1JYkAXbnUtJIWCT+/GPlBSe1Y6wKt9/yHnWJB7szpo70gUntX14Z7OEK4uurIbk+z7mAwj3rC8+exPUCBgxpiI0+Z8N3YOghzlEIzyQplWZA/IIPbk+Jlg0YiYoCJ4E944Xfco5QFB9UndaiuZQ1o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:26:23.9423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f43c4a5-6856-4a3e-1ab3-08df02c59ae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999318
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8805657f01de..21a1560ca055 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3049,6 +3049,59 @@ static const CPUCaches epyc_turin_cache_info = {
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
@@ -7310,6 +7363,94 @@ static const X86CPUDefinition builtin_x86_defs[] = {
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


