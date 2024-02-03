Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6325C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWC9Z-0006EK-LN; Sat, 03 Feb 2024 04:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9X-0006DU-3L
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:35 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rWC9V-0001VV-7C
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706951853; x=1738487853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z/gHOWUxcMMP/K6p2By1JSy8BtlD3n84UcB8hXvdztQ=;
 b=Ps6whB0IhfkTsJR3HN4wjejCKeF/OXiktBuDrC7Xj8p8wEIfBndQmo9O
 TMEbT7aRE7/7IvTvrpY/3Kclcy0Nzu0w4FM5vAT0KXSHg9oFKOjy2XjZF
 sYGLeyUcslmUIOCMb+A5uScjsKlXTSSVNbsAFJLnZnSt9psFKBdKjVRuO
 zrk85KBHZfbsw4dxK6g0qxT46yKNXYzSQqN9Pgx9dg6ALbaSq6LNovtEF
 FjITxpKkvoXhmNa/d8B+7w8H+dRjFjKNuXBX3IJ3r+tncAPw9KK8sSy9L
 xBsOVOHE5QUM3o13suGbKNyeN2VZBlHkl97nkjF0ozQJGHXgX62Fq8l3N w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="216359"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="216359"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2024 01:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; d="scan'208";a="31378988"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 03 Feb 2024 01:17:29 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yanting Jiang <yanting.jiang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 2/6] target/i386: Add support for Package Thermal Management
 feature
Date: Sat,  3 Feb 2024 17:30:50 +0800
Message-Id: <20240203093054.412135-3-zhao1.liu@linux.intel.com>
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

PTS feature (Package Thermal Management) is a dependency of ITD.

PTS provides 2 package level MSRs: MSR_IA32_PACKAGE_THERM_STATUS and
MSR_IA32_PACKAGE_THERM_INTERRUPT.

They're emulated in KVM, but currently KVM hasn't supported msr
topology.

Thus the emulation of these 2 package-level MSRs are only supported at
the whole VM-level, and all vCPUs share these two MSRs, so that the
emulation of these two MSRs does not distinguish between the different
virtual-packages.

In order to avoid potential contention problems caused by multiple
virtual-packages, add the following restrictions to the PTS feature bit:

1. Mark PTS as no_autoenable_flags and it won't be enabled by default.
2. PTS can't be enabled for the case with multiple packages.
3. PTS can't be enabled if ITD is not set for Guest, since currently PTS
   is only used to help enable ITD in virtualization scenario.

Additionally, add save/load support for 2 PTS related MSRs.

Tested-by: Yanting Jiang <yanting.jiang@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c     | 22 +++++++++++++++++++++-
 target/i386/cpu.h     | 13 +++++++++++++
 target/i386/kvm/kvm.c | 24 ++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 03822d9ba8ee..e772d35d9403 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1114,7 +1114,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, NULL, "arat", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "pts", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1124,6 +1124,11 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
+        /*
+         * PTS shouldn't be enabled by default since it has
+         * requirement for cpu topology.
+         */
+        .no_autoenable_flags = CPUID_6_EAX_PTS,
     },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
@@ -7424,6 +7429,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             goto out;
         }
     }
+
+    if (env->features[FEAT_6_EAX] & CPUID_6_EAX_PTS && ms->smp.sockets > 1) {
+        error_setg(errp,
+                   "PTS currently only supports 1 package, "
+                   "please set by \"-smp ...,sockets=1\"");
+        return;
+    }
+
+    if (env->features[FEAT_6_EAX] & CPUID_6_EAX_PTS &&
+        !(env->features[FEAT_6_EAX] & CPUID_6_EAX_ITD)) {
+        error_setg(errp,
+                   "In the absence of ITD, Guest does "
+                   "not need PTS");
+        return;
+    }
 #endif
 
     mce_init(cpu);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e453b3f010e2..a8c247b2ef89 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -530,6 +530,9 @@ typedef enum X86Seg {
 #define MSR_IA32_THERM_INTERRUPT        0x0000019b
 #define MSR_IA32_THERM_STATUS           0x0000019c
 
+#define MSR_IA32_PACKAGE_THERM_STATUS    0x000001b1
+#define MSR_IA32_PACKAGE_THERM_INTERRUPT 0x000001b2
+
 #define MSR_IA32_VMX_BASIC              0x00000480
 #define MSR_IA32_VMX_PINBASED_CTLS      0x00000481
 #define MSR_IA32_VMX_PROCBASED_CTLS     0x00000482
@@ -982,6 +985,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_XSAVE_XSAVES     (1U << 3)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
+#define CPUID_6_EAX_PTS        (1U << 6)
+#define CPUID_6_EAX_ITD        (1U << 23)
 
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
@@ -1767,6 +1772,14 @@ typedef struct CPUArchState {
     uint64_t therm_interrupt;
     uint64_t therm_status;
 
+    /*
+     * Although these are package level MSRs, for the PTS feature, we
+     * temporarily limit it to be enabled for only 1 package, so the value
+     * of each vCPU is same and it's enough to support the save/load.
+     */
+    uint64_t pkg_therm_interrupt;
+    uint64_t pkg_therm_status;
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 3bf57b35bfcd..258591535fd5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -139,6 +139,7 @@ static bool has_msr_vmx_procbased_ctls2;
 static bool has_msr_perf_capabs;
 static bool has_msr_pkrs;
 static bool has_msr_therm;
+static bool has_msr_pkg_therm;
 
 static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
@@ -2461,6 +2462,10 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_THERM_STATUS:
                 has_msr_therm = true;
                 break;
+            case MSR_IA32_PACKAGE_THERM_STATUS:
+            case MSR_IA32_PACKAGE_THERM_INTERRUPT:
+                has_msr_pkg_therm = true;
+                break;
             }
         }
     }
@@ -3313,6 +3318,15 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         kvm_msr_entry_add(cpu, MSR_IA32_THERM_INTERRUPT, env->therm_interrupt);
         kvm_msr_entry_add(cpu, MSR_IA32_THERM_STATUS, env->therm_status);
     }
+    /* Only sync package level MSRs to KVM on the first cpu */
+    if (current_cpu == first_cpu) {
+        if (has_msr_pkg_therm) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_STATUS,
+                              env->therm_control);
+            kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+                              env->therm_interrupt);
+        }
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -3790,6 +3804,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         kvm_msr_entry_add(cpu, MSR_IA32_THERM_INTERRUPT, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_THERM_STATUS, 0);
     }
+    if (has_msr_pkg_therm) {
+        kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_STATUS, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, 0);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -4280,6 +4298,12 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_THERM_STATUS:
             env->therm_status = msrs[i].data;
             break;
+        case MSR_IA32_PACKAGE_THERM_STATUS:
+            env->pkg_therm_status = msrs[i].data;
+            break;
+        case MSR_IA32_PACKAGE_THERM_INTERRUPT:
+            env->pkg_therm_interrupt = msrs[i].data;
+            break;
         }
     }
 
-- 
2.34.1


