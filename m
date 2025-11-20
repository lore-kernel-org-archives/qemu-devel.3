Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E921CF8548
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTQ-0005L1-RL; Thu, 20 Nov 2025 01:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT2-00056N-W2
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLySw-0005rC-S1
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621307; x=1795157307;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eeDf9LhA0ENb0Ck4QYJNLODepqE4U4YnhvEQeAx5r/4=;
 b=c/NVLSNahUdXJrHf600+Ffw1VoXNrHzOTXvYZz36vToSjj92bHIwZVxw
 1w6HLoTQQ/AiaGVObZX6jejuEMrw8KUeq25TXJi3tEXMtv//RmnMxLohs
 xEXnfdvlJGwQOg5mVOdua/QJ/Hn3ACwduRVTJ18TQQMbwVywObf7GR5/1
 t6fGw7ucdVZfP22wbPfuFqJJeW/kU32YYVTB1rYv5vGh0HnXiKLWfKIMl
 a4/+r21f+fECPKHyXw3eFUKEQEK1HjrZskQSqZq0z/U0fmGyRypKGqKh5
 iaoltzkqwyrmtV8tni1qkTsjOCH+aQSFy5nbzxIBsGeTjsVdmPBHO8mcN g==;
X-CSE-ConnectionGUID: WM6j47jcTl+7YvQ58jY+/A==
X-CSE-MsgGUID: Qx9Z/t/yRoGbaIblsy7Zew==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572531"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572531"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:21 -0800
X-CSE-ConnectionGUID: KKShmVRgRn6cwME4DDP9Kw==
X-CSE-MsgGUID: dcf9iL9wRwiLkNuWDh5hdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296111"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:19 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/10] i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX
 instructions
Date: Thu, 20 Nov 2025 15:10:22 +0800
Message-Id: <20251120071030.961230-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120071030.961230-1-zhao1.liu@intel.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

Intel Diamond Rapids adds new AMX instructions to support new formats
and memory operations [*]. And it introduces the CPUID subleaf 0x1E.0x1
to centralize the discrete AMX feature bits within EAX.

For new feature bits (CPUID 0x1E.0x1.EAX[bits 4,6-8]), it's
straightforward to add their enurmeration support.

In addition to the new features, CPUID 0x1E.0x1.EAX[bits 0-3] are
mirrored positions of existing AMX feature bits distributing across
the 0x7 leaves. It's not flexible to make these mirror bits have the
same names as existing ones, because QEMU would try to set both original
bit and mirror bit which would cause warning if host doesn't support
0x1E.0x1 subleaf. Thus, name these mirror bits with "*-mirror" suffix.

[*]: Intel Architecture Instruction Set Extensions and Future Features
     (rev.059).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Reference link: https://cdrdv2.intel.com/v1/dl/getContent/865891
---
 target/i386/cpu.c | 25 +++++++++++++++++++++++++
 target/i386/cpu.h | 18 ++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1aae9cba13af..1985a6b3b835 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1037,6 +1037,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
 #define TCG_29_0_EBX_FEATURES 0
+#define TCG_1E_1_EAX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1332,6 +1333,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
+    [FEAT_1E_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "amx-int8-mirror", "amx-bf16-mirror", "amx-complex-mirror", "amx-fp16-mirror",
+            "amx-fp8", NULL, "amx-tf32", "amx-avx512",
+            "amx-movrs", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x1e,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_1E_1_EAX_FEATURES,
+    },
     [FEAT_24_0_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -8413,8 +8433,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
 
         if (count == 0) {
+            uint32_t unused;
+            x86_cpu_get_supported_cpuid(0x1E, 0, eax, &unused,
+                                        &unused, &unused);
             /* Highest numbered palette subleaf */
             *ebx = INTEL_AMX_TMUL_MAX_K | (INTEL_AMX_TMUL_MAX_N << 8);
+        } else if (count == 1) {
+            *eax = env->features[FEAT_1E_1_EAX];
         }
         break;
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7b50c0c04f6e..df57b41567eb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -698,6 +698,7 @@ typedef enum FeatureWord {
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
+    FEAT_1E_1_EAX,      /* CPUID[EAX=0x1E,ECX=1].EAX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1071,6 +1072,23 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* AMX_INT8 instruction (mirror of CPUID_7_0_EDX_AMX_INT8) */
+#define CPUID_1E_1_EAX_AMX_INT8_MIRROR      (1U << 0)
+/* AMX_BF16 instruction (mirror of CPUID_7_0_EDX_AMX_BF16) */
+#define CPUID_1E_1_EAX_AMX_BF16_MIRROR      (1U << 1)
+/* AMX_COMPLEX instruction (mirror of CPUID_7_1_EDX_AMX_COMPLEX) */
+#define CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR   (1U << 2)
+/* AMX_FP16 instruction (mirror of CPUID_7_1_EAX_AMX_FP16) */
+#define CPUID_1E_1_EAX_AMX_FP16_MIRROR      (1U << 3)
+/* AMX_FP8 instruction */
+#define CPUID_1E_1_EAX_AMX_FP8              (1U << 4)
+/* AMX_TF32 instruction */
+#define CPUID_1E_1_EAX_AMX_TF32             (1U << 6)
+/* AMX_AVX512 instruction */
+#define CPUID_1E_1_EAX_AMX_AVX512           (1U << 7)
+/* AMX_MOVRS instruction */
+#define CPUID_1E_1_EAX_AMX_MOVRS            (1U << 8)
+
 /* AVX10 128-bit vector support is present */
 #define CPUID_24_0_EBX_AVX10_128        (1U << 16)
 /* AVX10 256-bit vector support is present */
-- 
2.34.1


