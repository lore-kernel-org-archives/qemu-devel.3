Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B450D3E799
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 06:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTaQz-0001wK-Lo; Thu, 11 Dec 2025 01:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQp-0001ll-Mv
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:47 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vTaQk-00067P-2f
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 01:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765435539; x=1796971539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SoPUW7s8m7Zbb2AHKcPy4PtSaPvg6j8vtL8RcooJABk=;
 b=V2Qh7KjCvCWUq9KsGY6yd64Q5/1ojpdLz4TNpwsKnfLvV9mmRBn9gWhi
 LWFTDD8RxByt/hwihXfEXjvGklXcyj6R+cpCy8yUzeUxd79/a3COiRyBn
 2crawg0tIK/ct0vGaEyD6+NJoQphp2GU5WzgfT+tonNwmzujPIF2hPKl2
 Y67MFVZ88qU10xcyQCH+87ySpi9TvWUBkUwzIQ17U2vS0M2c3nVvhaWo6
 z573cbqV6gsiRSoJ2OTHNeZkYvD5YUwY1RmLWBINmpuMFJY6bNUUng6jr
 qeKgigPV/GYlXU9zZE0Vx6UfdOhYHbHSeGl8xZerNK31WQoofPX4eBEzY g==;
X-CSE-ConnectionGUID: BSu9x62mSMW2x+oJlxV9hQ==
X-CSE-MsgGUID: W9BDYIrhQL+RqJWGzCPucg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67584495"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67584495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 22:45:36 -0800
X-CSE-ConnectionGUID: Oid8Gc01TX6KT8JnEglytg==
X-CSE-MsgGUID: errF4pMnTDGXhTGpe7wuWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="196495029"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Dec 2025 22:45:32 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Fang <peter.fang@intel.com>
Subject: [PATCH v2 8/9] i386/cpu: Support APX CPUIDs
Date: Thu, 11 Dec 2025 15:09:41 +0800
Message-Id: <20251211070942.3612547-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251211070942.3612547-1-zhao1.liu@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

APX is enumerated by CPUID.(EAX=0x7, ECX=1).EDX[21]. And this feature
bit also indicates the existence of dedicated CPUID leaf 0x29, called
the Intel APX Advanced Performance Extensions Leaf.

This new CPUID leaf now is populated with enumerations for a select
set of Intel APX sub-features.

CPUID.(EAX=0x29, ECX=0)
 - EAX
   * Maximum Subleaf CPUID.(EAX=0x29, ECX=0).EAX[31:0] = 0
 - EBX
   * Reserved CPUID.(EAX=0x29, ECX=0).EBX[31:1] = 0
   * APX_NCI_NDD_NF CPUID.(EAX=0x29, ECX=0).EBX[0:0] = 1, which
     enumerates the presence of New Conditional Instructions (NCIs),
     explicit New Data Destination (NDD) controls, and explicit Flags
     Suppression (NF) controls for select sets of EVEX-encoded Intel
     APX instructions (present in EVEX map=4, and EVEX map=2 0x0F38).
 - ECX
   * Reserved CPUID.(EAX=0x29, ECX=0).ECX[31:0] = 0
 - EDX
   * Reserved CPUID.(EAX=0x29, ECX=0).EDX[31:0] = 0

Note, APX_NCI_NDD_NF is documented as always enabled for Intel
processors since APX spec (revision v7.0). Now any Intel processor
that enumerates support for APX_F (CPUID.(EAX=0x7, ECX=1).EDX[21])
will also enumerate support for APX_NCI_NDD_NF.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 40 +++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  8 ++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 16bc4b18266c..9cc553a86442 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1036,6 +1036,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
+#define TCG_29_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1301,7 +1302,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, "avx10",
-            NULL, NULL, NULL, NULL,
+            NULL, "apx", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
@@ -1345,6 +1346,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_24_0_EBX_FEATURES,
     },
+    [FEAT_29_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "apx-nci-ndd-nf", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x29,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_29_0_EBX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1996,6 +2016,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_0_EBX,              ~0ull },
     },
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_APX },
+        .to = { FEAT_29_0_EBX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -8411,6 +8435,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x29:
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APX) && count == 0) {
+            *ebx = env->features[FEAT_29_0_EBX];
+        }
+        break;
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -9190,6 +9223,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
         }
 
+        /* Advanced Performance Extensions (APX) requires CPUID[0x29] */
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APX) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x29);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index edc18e4b3da8..08216b343afa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -710,6 +710,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1092,6 +1093,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                          CPUID_24_0_EBX_AVX10_256 | \
                                          CPUID_24_0_EBX_AVX10_512)
 
+/*
+ * New Conditional Instructions (NCIs), explicit New Data Destination (NDD)
+ * controls, and explicit Flags Suppression (NF) controls for select sets of
+ * EVEX-encoded Intel APX instructions
+ */
+#define CPUID_29_0_EBX_APX_NCI_NDD_NF         (1U << 0)
+
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
-- 
2.34.1


