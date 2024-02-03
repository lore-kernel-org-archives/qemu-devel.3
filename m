Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8913C48297
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9c-0006F0-8S; Sat, 03 Feb 2024 04:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9Y-0006E7-W6
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:37 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9X-0001Vy-07
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951855; x=1738487855;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UyIppaYlMKCeYNOfMLCrY6Qljm+AMerAyC7gI0Br97s=;
 b=ULhSAS7tCHKqWcVvRmPYzb3yIZOTJVgBctU9gcbRS/a/X0QzKlFHOEh2
 c2UjBLXm8yZQL7m2q1bVzYDN0ESjJDJ03Li5OoYMDhYr/Jl8C8pH4zqAd
 hV1We9/R9ads6HnmhzI09HRvt2g2KNqeWcMwBwhnRC4E6S+jC4pqUQb2c
 ZubSBmBcmzKri8rItldAIJmt9PS2nOlJHssVayCDnlAHqQf25HQ1lyO3R
 NdHK/vaaoWW9kYe+fR1fhFLmKkrMwpgYg8bgypFSjxjdk9zcopgxwb8AG
 F4kOC1hSIrA+Pu+WmdQD4rgT/K8zQwSaoSY1hAvAiBrceihnUtoe3FhTP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216363"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31378997"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:31 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 3/6] target/i386: Add support for Hardware Feedback Interface
 feature
Date: Sat,  3 Feb 2024 17:30:51 +0800
Message-Id: <20240203093054.412135-4-zhao1.liu@linux.intel.com>
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

Hardware Feedback Interface (HFI) is a basic dependency of ITD.

HFI is the feature to allow hardware to provide guidance to the
Operating System (OS) scheduler to perform optimal workload scheduling
through a hardware feedback interface structure in memory [1]. Currently
in virtualization scenario it is used to help enable ITD.

HFI feature provides the basic HFI information in CPUID.0x06:
* 0x06.eax[bit 19]: HFI feature bit
* 0x06.ecx[bits 08-15]: Number of HFI/ITD supported classes
* 0x06.edx[bits 00-07]: Bitmap of supported HFI capabilities
* 0x06.edx[bits 08-11]: Enumerates the size of the HFI table in number
                        of 4 KB pages
* 0x06.edx[bits 16-31]: HFI table index of processor

Here the basic information is generated by KVM based on the virtual HFI
table that can be emulated, and QEMU needs to specify the HFI table
index for each vCPU.

HFI feature also provides 2 package level MSRs:
MSR_IA32_HW_FEEDBACK_CONFIG and MSR_IA32_HW_FEEDBACK_PTR.

They're emulated in KVM, but currently KVM hasn't supported msr
topology.

Thus, like PTS MSRs, the emulation of these 2 package-level HFI MSRs are
only supported at the whole VM-level, and all vCPUs share these two
MSRs, so that the emulation of these two MSRs does not distinguish
between the different virtual-packages.

And HFI driver maintains per die HFI instances, so this can also cause
problems with access to HFI MSRs when multiple virtual-dies exist.

In order to avoid potential contention problems caused by multiple
virtual-packages/dies, add the following restrictions to the HFI feature
bit:

1. Mark HFI as no_autoenable_flags and it won't be enabled by default.
2. HFI can't be enabled for the case with multiple packages/dies.
3. HFI can't be enabled if ITD is not set for Guest, since currently HFI
   is only used to help enable ITD in virtualization scenario.

HFI feature depends on ACPI, TM and PTS, also add their dependencies.

Additionally, add save/load support for 2 HFI related MSRs.

[1]: SDM, vol. 3B, section 15.6 HARDWARE FEEDBACK INTERFACE AND INTEL
     THREAD DIRECTOR

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c     | 49 ++++++++++++++++++++++++++++++++++++++-----
 target/i386/cpu.h     |  8 ++++++-
 target/i386/kvm/kvm.c | 21 +++++++++++++++++++
 3 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e772d35d9403..e3eb361436c9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1117,7 +1117,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, "pts", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "hfi",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1125,10 +1125,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
         /*
-         * PTS shouldn't be enabled by default since it has
+         * PTS and HFI shouldn't be enabled by default since they have
          * requirement for cpu topology.
          */
-        .no_autoenable_flags = CPUID_6_EAX_PTS,
+        .no_autoenable_flags = CPUID_6_EAX_PTS | CPUID_6_EAX_HFI,
     },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
@@ -1557,6 +1557,18 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
     },
+    {
+        .from = { FEAT_1_EDX,               CPUID_ACPI },
+        .to = { FEAT_6_EAX,                 CPUID_6_EAX_HFI },
+    },
+    {
+        .from = { FEAT_1_EDX,               CPUID_TM },
+        .to = { FEAT_6_EAX,                 CPUID_6_EAX_HFI },
+    },
+    {
+        .from = { FEAT_6_EAX,               CPUID_6_EAX_PTS },
+        .to = { FEAT_6_EAX,                 CPUID_6_EAX_HFI },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -6158,6 +6170,25 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
+        /*
+         * KVM only supports HFI virtualization with ITD, so
+         * set the HFI information only if the ITD is enabled.
+         */
+        if (*eax & CPUID_6_EAX_ITD) {
+            if (kvm_enabled()) {
+                *ecx = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x6,
+                                                    count, R_ECX);
+                /*
+                 * No need to adjust the number of pages since the default
+                 * 1 4KB page is enough to hold the HFI entries of max_cpus
+                 * (1024) supported by i386 machine (q35).
+                 */
+                *edx = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x6,
+                                                    count, R_EDX);
+                /* Set HFI table index as CPU index. */
+                *edx |= cs->cpu_index << 16;
+            }
+        }
         break;
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
@@ -7437,11 +7468,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (env->features[FEAT_6_EAX] & CPUID_6_EAX_PTS &&
+    if (env->features[FEAT_6_EAX] & CPUID_6_EAX_HFI &&
+        (ms->smp.dies > 1 || ms->smp.sockets > 1)) {
+        error_setg(errp,
+                   "HFI currently only supports die/package, "
+                   "please set by \"-smp ...,sockets=1,dies=1\"");
+        return;
+    }
+
+    if (env->features[FEAT_6_EAX] & (CPUID_6_EAX_PTS | CPUID_6_EAX_HFI) &&
         !(env->features[FEAT_6_EAX] & CPUID_6_EAX_ITD)) {
         error_setg(errp,
                    "In the absence of ITD, Guest does "
-                   "not need PTS");
+                   "not need PTS/HFI");
         return;
     }
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a8c247b2ef89..b54a2ccd6a6e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -533,6 +533,9 @@ typedef enum X86Seg {
 #define MSR_IA32_PACKAGE_THERM_STATUS    0x000001b1
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT 0x000001b2
 
+#define MSR_IA32_HW_FEEDBACK_CONFIG     0x000017d0
+#define MSR_IA32_HW_FEEDBACK_PTR        0x000017d1
+
 #define MSR_IA32_VMX_BASIC              0x00000480
 #define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
 #define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
@@ -986,6 +989,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
 #define CPUID_6_EAX_PTS        (1U << 6)
+#define CPUID_6_EAX_HFI        (1U << 19)
 #define CPUID_6_EAX_ITD        (1U << 23)
 
 /* CPUID[0x80000007].EDX flags: */
@@ -1773,12 +1777,14 @@ typedef struct CPUArchState {
     uint64_t therm_status;
 
     /*
-     * Although these are package level MSRs, for the PTS feature, we
+     * Although these are package level MSRs, for the PTS/HFI feature, we
      * temporarily limit it to be enabled for only 1 package, so the value
      * of each vCPU is same and it's enough to support the save/load.
      */
     uint64_t pkg_therm_interrupt;
     uint64_t pkg_therm_status;
+    uint64_t hfi_config;
+    uint64_t hfi_ptr;
 
     /* exception/interrupt handling */
     int error_code;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 258591535fd5..694aa20afc67 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -140,6 +140,7 @@ static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
 static bool has_msr_therm;
 static bool has_msr_pkg_therm;
+static bool has_msr_hfi;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2466,6 +2467,10 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_PACKAGE_THERM_INTERRUPT:
                 has_msr_pkg_therm = true;
                 break;
+            case MSR_IA32_HW_FEEDBACK_CONFIG:
+            case MSR_IA32_HW_FEEDBACK_PTR:
+                has_msr_hfi = true;
+                break;
             }
         }
     }
@@ -3326,6 +3331,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
                               env->therm_interrupt);
         }
+        if (has_msr_hfi) {
+            kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_CONFIG,
+                              env->hfi_config);
+            kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_PTR,
+                              env->hfi_ptr);
+        }
     }
 
 #ifdef TARGET_X86_64
@@ -3808,6 +3819,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_STATUS, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, 0);
     }
+    if (has_msr_hfi) {
+        kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_CONFIG, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_HW_FEEDBACK_PTR, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4304,6 +4319,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_PACKAGE_THERM_INTERRUPT:
             env->pkg_therm_interrupt = msrs[i].data;
             break;
+        case MSR_IA32_HW_FEEDBACK_CONFIG:
+            env->hfi_config = msrs[i].data;
+            break;
+        case MSR_IA32_HW_FEEDBACK_PTR:
+            env->hfi_ptr = msrs[i].data;
+            break;
         }
     }
 
-- 
2.34.1


