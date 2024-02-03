Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A38C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9l-0006Fn-Bk; Sat, 03 Feb 2024 04:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9k-0006Fa-DO
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:48 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9i-0001Wo-JW
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951867; x=1738487867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LHXTdjtZ2r3RyYP7b3t0ffj/yUzzPpSDCGrT79qcd+k=;
 b=MpJJN5o8PR+lZUi5IeSOOqtsfIsX084nIF81QOTBa9zcHN6FXC623Y3R
 qH/Pbh5ITEiSoBwgriOxBsiAi/yiK2+sXMYDvykc0E57bRhuKL/IGBv3K
 15ZW+VEpA8hQ2j6JvkSdTh8QjDo3a6TjjP26q27SJSw6aOgcn3WA1B8Bv
 8X8yYZEromnqtG+DkE76z0570fsMwJuJCYKntwcRZ+PsfiyqG8kFzAQ8d
 bHXOhWYaBMYrK3rwBPeCDBQOTUBTS3rmRbH1C2FYGyzn6f6FTstLmZJTf
 eylATb/XqYOtikA8BULtysp6pTK87n6ush9DKxkR6NDp/rsZJXRpOhEyw A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216383"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216383"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31379019"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:36 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 5/6] target/i386: Add support for HRESET feature
Date: Sat,  3 Feb 2024 17:30:53 +0800
Message-Id: <20240203093054.412135-6-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
References: <20240203093054.412135-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

HRESET provides an HRESET instruction to reset the ITD related history
accumulated on the current logical processor it is executing on [1].

HRESET feature not only needs to have the feature bit of 0x07.0x01.eax
[bit 22] in the CPUID, but also the associated 0x20 leaf, thus, we also
fill HRESET related info provided by KVM into Guest's 0x20 leaf.

Because currently HRESET is only used to reset ITD's history and ITD has
been marked as no_autoenable_flags, mark the HRESET feature bit as
no_autoenable_flags, too.

Additionally, add MSR_IA32_HW_HRESET_ENABLE save/load support since it's
emulated in KVM. This MSR is used to control the enabling of ITD's
history reset.

[1]: SDM, vol. 3B, section 15.6.11 Logical Processor Scope History

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c     | 28 +++++++++++++++++++++++++++-
 target/i386/cpu.h     |  6 ++++++
 target/i386/kvm/kvm.c | 14 ++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 55287d0a3e73..3b26b471b861 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -966,7 +966,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, "amx-fp16", NULL, "avx-ifma",
+            NULL, "amx-fp16", "hreset", "avx-ifma",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
@@ -976,6 +976,11 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .reg = R_EAX,
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
+        /*
+         * Currently HRESET is only used for ITD history reset. ITD is not
+         * autoenable, so also don't enable HRESET by default.
+         */
+        .no_autoenable_flags = CPUID_7_1_EAX_HRESET,
     },
     [FEAT_7_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -6502,6 +6507,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x20: {
+        /* Processor History Reset */
+        if (kvm_enabled() &&
+            env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_HRESET) {
+            *eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x20,
+                                                count, R_EAX);
+            *ebx = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x20,
+                                                count, R_EBX);
+        } else {
+            *eax = 0;
+            *ebx = 0;
+        }
+        *ecx = 0;
+        *edx = 0;
+        break;
+    }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -7147,6 +7168,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x12);
         }
+
+        /* HRESET requires CPUID[0x20] */
+        if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_HRESET) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x20);
+        }
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b54a2ccd6a6e..a68c9d8a8660 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -535,6 +535,7 @@ typedef enum X86Seg {
 
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x000017d0
 #define MSR_IA32_HW_FEEDBACK_PTR        0x000017d1
+#define MSR_IA32_HW_HRESET_ENABLE       0x000017da
 
 #define MSR_IA32_VMX_BASIC              0x00000480
 #define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
@@ -933,6 +934,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_FSRC              (1U << 12)
 /* Support Tile Computational Operations on FP16 Numbers */
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
+/* HISTORY RESET */
+#define CPUID_7_1_EAX_HRESET            (1U << 22)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
 
@@ -1786,6 +1789,9 @@ typedef struct CPUArchState {
     uint64_t hfi_config;
     uint64_t hfi_ptr;
 
+    /* Per-VCPU HRESET MSR */
+    uint64_t hreset_enable;
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 694aa20afc67..e490126f23ca 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -141,6 +141,7 @@ static bool has_msr_pkrs;
 static bool has_msr_therm;
 static bool has_msr_pkg_therm;
 static bool has_msr_hfi;
+static bool has_msr_hreset;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2471,6 +2472,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_HW_FEEDBACK_PTR:
                 has_msr_hfi = true;
                 break;
+            case MSR_IA32_HW_HRESET_ENABLE:
+                has_msr_hreset = true;
+                break;
             }
         }
     }
@@ -3337,6 +3341,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_PTR,
                               env->hfi_ptr);
         }
+        if (has_msr_hreset) {
+            kvm_msr_entry_add(cpu, MSR_IA32_HW_HRESET_ENABLE,
+                              env->hreset_enable);
+        }
     }
 
 #ifdef TARGET_X86_64
@@ -3823,6 +3831,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_CONFIG, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_PTR, 0);
     }
+    if (has_msr_hreset) {
+        kvm_msr_entry_add(cpu, MSR_IA32_HW_HRESET_ENABLE, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4325,6 +4336,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_HW_FEEDBACK_PTR:
             env->hfi_ptr = msrs[i].data;
             break;
+        case MSR_IA32_HW_HRESET_ENABLE:
+            env->hreset_enable = msrs[i].data;
+            break;
         }
     }
 
-- 
2.34.1


