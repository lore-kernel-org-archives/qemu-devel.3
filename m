Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3416D5B16C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2lc-00035W-Mt; Mon, 15 Dec 2025 02:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2la-00033w-Mp
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:10 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vV2lX-0008DW-0i
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765782787; x=1797318787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vit3CDGKgADTcvTJz3NSHDWQVkt2LabKgxDAyaoeYJ4=;
 b=cf3BD4VgghGlD9mmbotMApbm+jrojzDzNFFRqfQhwO5Sgm00j23FOHEq
 8DTC2W4C0WuzbjNymyH5jUQV0GxGKmxx5FnVrTfM3yqu06FD8jQ1hIAgz
 Z+WJ8utA/sydehouvJX0abHFWdMJxtdvzKqZV0vjsJY5ZmS9lxpK3Ti+X
 xxmKmjeYUm2mgboylb+/TdvS7K2qRXPevBlHg+HeE1S/2Fe4tjCzFMtTq
 u5sr7EHvrDrfkRmNC+Gk7bbRHSy0qVCaCfDJpRat9nd2NrS0IUPIjgRmN
 Sa09xJQV1w5/AXaurTVPrGErv3Isgz5DVF5vhjxvRCyFmVJakOjCoagOc A==;
X-CSE-ConnectionGUID: G/qnI6sTTQC0ByfGlyk0gQ==
X-CSE-MsgGUID: pStmCdhxRR68DvO/AJrgcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90332238"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="90332238"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 23:13:06 -0800
X-CSE-ConnectionGUID: NRKxrr7JQhiU1UKzHzKXMQ==
X-CSE-MsgGUID: e2bXRFQ/Tye/jVk0vwdDrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197265933"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 14 Dec 2025 23:13:04 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 02/11] i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX
 instructions
Date: Mon, 15 Dec 2025 15:37:34 +0800
Message-Id: <20251215073743.4055227-3-zhao1.liu@intel.com>
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
index 7efb628e17a7..7cff00a1b160 100644
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
@@ -8412,8 +8432,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
index 0edba739c4e2..dd18a33c6275 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -713,6 +713,7 @@ typedef enum FeatureWord {
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
+    FEAT_1E_1_EAX,      /* CPUID[EAX=0x1E,ECX=1].EAX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1086,6 +1087,23 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
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


