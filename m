Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10829C83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 14:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYmpE-0004yg-23; Mon, 07 Jul 2025 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYmh7-0006yv-Nu
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:19:47 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uYmh5-00032E-0A
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751897983; x=1783433983;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xI4PP1tk09L1yhkF678CvUQDelQfTgTcp8WEY37RQKY=;
 b=Z+N9NHgaQWy89fseTlZwYdHpJsIz/6MeDb8fGVFBo2XOF0BBuecDs6un
 z5sxfWSLLlCNsmgjhTSWxAlyBDPrIQLO0bmggmm1Masbj11TTVAY19D6Q
 6pz5+ZusbDe9mdyG2xU85+rk5R7mPP+Yx6k94Zxe/0sWXjbXX6RyBgusm
 MklErHTBMz6vIXCRQm567uAAvQGoZJHAUOSriweityIbpJXbkIiJbekJ3
 YN/wjN8jd74NDt01FfzWsSBAPZqZcFdWxyy4Hew+gK4IIkpIVmr/CYHYY
 pIpYf7XhniXk2Q7luElIS6fLWJvT0uEwaI0tfZwYDE2AbAOD8YnxLcqDZ Q==;
X-CSE-ConnectionGUID: POimwU/GTv2Vbcm0KtDAsg==
X-CSE-MsgGUID: 5Tw1ecuxQLmc4lj9PTfmiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53333853"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="53333853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 07:19:38 -0700
X-CSE-ConnectionGUID: B7k0nryBS/KchrKKdoqMmw==
X-CSE-MsgGUID: TDXMYJ2eRbSqCvVa6ZmX9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="186174646"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa001.fm.intel.com with ESMTP; 07 Jul 2025 07:19:36 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, tao1.su@intel.com,
 chenyi.qiang@intel.com, xiaoyao.li@intel.com
Subject: [PATCH v2] i386/cpu: Remove FEAT_24_0_EBX for AVX10
Date: Mon,  7 Jul 2025 22:11:51 +0800
Message-ID: <20250707141151.4187798-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It turns out that all the Intel processors enumerating the support of
Intel AVX10 support all vector widths. It's documented in the latest
SDM, vol 1, Chapter 16 "programming with Intel AVX10".

(Note that AVX10.1 spec stops update since AVX10 is subsumed into SDM
 while AVX10.2 spec stays update for the future extension of AVX10)

Now SDM [1] marks the bit 16-18 of CPUID.0x24_0.EBX as reserved and they
are reserved at 1. The purpose of Intel is to remove the semantic of
vector length enumeration from these bits since all the 128/256/512 bit
length are supported and no need for enumeration. But Intel has to keep
them reserved at 1 to make it compatible with the software written based
on earlier avx10 spec that checks the bits to query of the support of each
vector length.

For QEMU, it makes no sense to allow the configurability of the bits
anymore. Remove the leaf FEAT_24_0_EBX and related stuff. Just hardcore
the bits to all 1 when AVX10 is exposed to guest, to comply with the SDM
and stop trying to associate them with the enumeration of vector length.

[1] https://cdrdv2.intel.com/v1/dl/getContent/671200 (rev 088)

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v2:
 - refine the commit message to reference update from SDM instead of
   AVX10 spec;
 - call out explicitly the purpose of disassociating the enumeration of
   vector length from the CPUID bits.
---
 target/i386/cpu.c | 37 ++-----------------------------------
 target/i386/cpu.h | 12 ------------
 2 files changed, 2 insertions(+), 47 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d35e95430fe..1b50fd4e397d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -912,7 +912,6 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EAX_FEATURES 0
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
-#define TCG_24_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1208,20 +1207,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
-    [FEAT_24_0_EBX] = {
-        .type = CPUID_FEATURE_WORD,
-        .feat_names = {
-            [16] = "avx10-128",
-            [17] = "avx10-256",
-            [18] = "avx10-512",
-        },
-        .cpuid = {
-            .eax = 0x24,
-            .needs_ecx = true, .ecx = 0,
-            .reg = R_EBX,
-        },
-        .tcg_features = TCG_24_0_EBX_FEATURES,
-    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1839,22 +1824,6 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_0_EBX,             CPUID_7_0_EBX_SGX },
         .to = { FEAT_SGX_12_1_EAX,          ~0ull },
     },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_128 },
-        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_256 },
-    },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_256 },
-        .to = { FEAT_24_0_EBX,              CPUID_24_0_EBX_AVX10_512 },
-    },
-    {
-        .from = { FEAT_24_0_EBX,            CPUID_24_0_EBX_AVX10_VL_MASK },
-        .to = { FEAT_7_1_EDX,               CPUID_7_1_EDX_AVX10 },
-    },
-    {
-        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
-        .to = { FEAT_24_0_EBX,              ~0ull },
-    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -4732,9 +4701,6 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                     { "movdiri", "on" },
                     { "movdir64b", "on" },
                     { "avx10", "on" },
-                    { "avx10-128", "on" },
-                    { "avx10-256", "on" },
-                    { "avx10-512", "on" },
                     { "avx10-version", "1" },
                     { "stepping", "1" },
                     { /* end of list */ }
@@ -7720,7 +7686,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
-            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+            /* bit 16-18 are reserved at 1 */
+            *ebx = (0x7U << 16) | env->avx10_version;
         }
         break;
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..7856a882f014 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -671,7 +671,6 @@ typedef enum FeatureWord {
     FEAT_7_1_ECX,       /* CPUID[EAX=7,ECX=1].ECX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
-    FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1037,17 +1036,6 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
-/* AVX10 128-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_128        (1U << 16)
-/* AVX10 256-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_256        (1U << 17)
-/* AVX10 512-bit vector support is present */
-#define CPUID_24_0_EBX_AVX10_512        (1U << 18)
-/* AVX10 vector length support mask */
-#define CPUID_24_0_EBX_AVX10_VL_MASK    (CPUID_24_0_EBX_AVX10_128 | \
-                                         CPUID_24_0_EBX_AVX10_256 | \
-                                         CPUID_24_0_EBX_AVX10_512)
-
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
-- 
2.43.0


