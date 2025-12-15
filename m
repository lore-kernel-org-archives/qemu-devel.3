Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEEAD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2le-00036q-9k; Mon, 15 Dec 2025 02:13:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lb-00034J-Bq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:11 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lZ-0008DF-9u
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782790; x=1797318790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sh3Fg+ZYPcyL2OzkRyiBIJ95xMydGUhZTJlNihUC5Zw=;
 b=KFkIw3i8gON6z8Eeq3tjdOu02zY0e1BtAwb312YBsEEMczdmTktXWqda
 NoT0m8ROeTl/REIzVHheLefqNEZNtPhcKlrBlJIrM5KQ+zYBzxy46/37I
 kuOOfYIC8wV5RFotQ4nEQA3AxWGs0cLaFCL9ZaIn9QgRKWW+kfRj2/Ii2
 cWKtNP+bvT6WCGB7RB8YATQIftZ9N9IXeVx8IQccnD80FZoJzCy3rEfW5
 fmsCHQi0UuP1QNWSD/3Zzw2TYl5ae7bzKqfBo7S0m6aBcFBSG6guBUzA0
 8riq13DEFpqUzjFA9eUlBZP6CI6WRNfw89ElXoWHtJmS1kCvLAnFHuOw1 g==;
X-CSE-ConnectionGUID: rut8+5XjQDCE505ZG3KUZQ==
X-CSE-MsgGUID: 0/LpYvP7T8+Rz/hMx0wNMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332240"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:07 -0800
X-CSE-ConnectionGUID: tiHuj6yCQZygyuC845n+Gw==
X-CSE-MsgGUID: YuAKVo5dTZaBaQlZbhc6CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265940"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:05 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 03/11] i386/cpu: Add support for AVX10_VNNI_INT in CPUID
 enumeration
Date: Mon, 15 Dec 2025 15:37:35 +0800
Message-Id: <20251215073743.4055227-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251215073743.4055227-1-zhao1.liu@intel.com>
References: <20251215073743.4055227-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

AVX10_VNNI_INT (0x24.0x1.ECX[bit 2]) is a discrete feature bit
introduced on Intel Diamond Rapids, which enumerates the support for
EVEX VPDP* instructions for INT8/INT16 [*].

Although Intel AVX10.2 has already included new VPDP* INT8/INT16 VNNI
instructions, a bit - AVX10_VNNI_INT - is still be separated. Relevant
new instructions can be checked by either CPUID AVX10.2 OR
AVX10_VNNI_INT (e.g., VPDPBSSD).

Support CPUID 0x24.0x1 subleaf with AVX10_VNNI_INT enumeration for
Guest.

[*]: Intel Advanced Vector Extensions 10.2 Architecture Specification
     (rev 5.0).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Reference link: https://cdrdv2.intel.com/v1/dl/getContent/856721
---
 target/i386/cpu.c | 29 ++++++++++++++++++++++++++++-
 target/i386/cpu.h |  4 ++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7cff00a1b160..068e00a8d466 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1038,6 +1038,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_24_0_EBX_FEATURES 0
 #define TCG_29_0_EBX_FEATURES 0
 #define TCG_1E_1_EAX_FEATURES 0
+#define TCG_24_1_ECX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1385,6 +1386,18 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_29_0_EBX_FEATURES,
     },
+    [FEAT_24_1_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            [2] = "avx10-vnni-int",
+        },
+        .cpuid = {
+            .eax = 0x24,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_ECX,
+        },
+        .tcg_features = TCG_24_1_ECX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -2041,6 +2054,11 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_APXF },
         .to = { FEAT_29_0_EBX,              ~0ull },
     },
+
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
+        .to = { FEAT_24_1_ECX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -8456,8 +8474,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
-        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+
+        if (!(env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10)) {
+            break;
+        }
+        if (count == 0) {
+            uint32_t unused;
+            x86_cpu_get_supported_cpuid(0x1E, 0, eax, &unused,
+                                        &unused, &unused);
             *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        } else if (count == 1) {
+            *ecx = env->features[FEAT_24_1_ECX];
         }
         break;
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dd18a33c6275..749ac8455e18 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -714,6 +714,7 @@ typedef enum FeatureWord {
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
     FEAT_1E_1_EAX,      /* CPUID[EAX=0x1E,ECX=1].EAX */
+    FEAT_24_1_ECX,      /* CPUID[EAX=0x24,ECX=0].ECX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1115,6 +1116,9 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                          CPUID_24_0_EBX_AVX10_256 | \
                                          CPUID_24_0_EBX_AVX10_512)
 
+/* AVX10_VNNI_INT instruction */
+#define CPUID_24_1_ECX_AVX10_VNNI_INT         (1U << 2)
+
 /*
  * New Conditional Instructions (NCIs), explicit New Data Destination (NDD)
  * controls, and explicit Flags Suppression (NF) controls for select sets of
-- 
2.34.1


