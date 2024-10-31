Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE557E6895E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6R0k-0000ji-9Z; Thu, 31 Oct 2024 04:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0i-0000jB-Bv
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:32 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t6R0g-0003DC-8j
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730365110; x=1761901110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UZyMMsRXa4iSyGY5eUFRZzJg2dephFzFFBTZxRIx7WU=;
 b=O/zzXcdZFzc9TqGXY9e4AqZp5eMR1gKxNdEghSV8kLD8UVY8PV+3sash
 QeZG84W+Gk45w98k8EfJzHrxWu4/+v9YUXYSnNNW3fBcfgcotGG/WR+Ho
 LQIlCshqwyAaE/R0lB5AgbuSCrZ779IqlC8QpxwpE6Q9cZ6ET5nWyGYMS
 LnzCeKdoYKk0M9QNwpsGnLppFvh3kguq8dpg46Qr/MV3SmksrMkRHl1c2
 TzbUq8Da8XezMtKCBsRiEFxR9ZRu4eHlGXHtv54YYyUpXLVl0r0gsncXc
 LQrjP42ZCU9h1zUfFWoWZemHMhNT3fHzsg56MyNzzkk3z4kS64kwzOCAw Q==;
X-CSE-ConnectionGUID: CFHZlx8BQyq1WYlXjsZE9w==
X-CSE-MsgGUID: cc+S5JNvT3+s0fA6fGsvNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="55492682"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="55492682"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 01:58:29 -0700
X-CSE-ConnectionGUID: eaUpzwv2TPSgW/M56Ak/hg==
X-CSE-MsgGUID: 1BFyTnwgS1iRaFkRYgfW6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="82489519"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa010.jf.intel.com with ESMTP; 31 Oct 2024 01:58:27 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 zhao1.liu@intel.com, xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH v3 4/8] target/i386: add AVX10 feature and AVX10 version
 property
Date: Thu, 31 Oct 2024 16:52:29 +0800
Message-Id: <20241031085233.425388-5-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031085233.425388-1-tao1.su@linux.intel.com>
References: <20241031085233.425388-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When AVX10 enable bit is set, the 0x24 leaf will be present as "AVX10
Converged Vector ISA leaf" containing fields for the version number and
the supported vector bit lengths.

Introduce avx10-version property so that avx10 version can be controlled
by user and cpu model. Per spec, avx10 version can never be 0, the default
value of avx10-version is set to 0 to determine whether it is specified by
user.  The default can come from the device model or, for the max model,
from KVM's reported value.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Xuelian Guo <xuelian.guo@intel.com>
---
 target/i386/cpu.c     | 64 ++++++++++++++++++++++++++++++++++++++-----
 target/i386/cpu.h     |  4 +++
 target/i386/kvm/kvm.c |  3 +-
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8fbbf1fd9e..284ff062df 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -46,6 +46,9 @@
 #include "cpu-internal.h"
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
+static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
+                                        uint32_t *eax, uint32_t *ebx,
+                                        uint32_t *ecx, uint32_t *edx);
 
 /* Helpers for building CPUID[2] descriptors: */
 
@@ -1132,7 +1135,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni-int8", "avx-ne-convert", NULL, NULL,
             "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "avx10",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1967,6 +1970,7 @@ typedef struct X86CPUDefinition {
     int family;
     int model;
     int stepping;
+    uint8_t avx10_version;
     FeatureWordArray features;
     const char *model_id;
     const CPUCaches *const cache_info;
@@ -6309,6 +6313,9 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
      */
     object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
 
+    object_property_set_uint(OBJECT(cpu), "avx10-version", def->avx10_version,
+                             &error_abort);
+
     x86_cpu_apply_version_props(cpu, model);
 
     /*
@@ -6837,6 +6844,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x24: {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && count == 0) {
+            *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
+        }
+        break;
+    }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -7417,6 +7434,12 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
                 ~env->user_features[w] &
                 ~feature_word_info[w].no_autoenable_flags;
         }
+
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
+            uint32_t eax, ebx, ecx, edx;
+            x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
+            env->avx10_version = ebx & 0xff;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
@@ -7480,6 +7503,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
 
+        /* Advanced Vector Extensions 10 (AVX10) requires CPUID[0x24] */
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
@@ -7530,6 +7558,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     CPUX86State *env = &cpu->env;
     FeatureWord w;
     const char *prefix = NULL;
+    bool have_filtered_features;
+
+    uint32_t eax_0, ebx_0, ecx_0, edx_0;
+    uint32_t eax_1, ebx_1, ecx_1, edx_1;
 
     if (verbose) {
         prefix = accel_uses_host_cpuid()
@@ -7551,13 +7583,10 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
      */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
         kvm_enabled()) {
-        uint32_t eax_0, ebx_0, ecx_0, edx_0_unused;
-        uint32_t eax_1, ebx_1, ecx_1_unused, edx_1_unused;
-
         x86_cpu_get_supported_cpuid(0x14, 0,
-                                    &eax_0, &ebx_0, &ecx_0, &edx_0_unused);
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
         x86_cpu_get_supported_cpuid(0x14, 1,
-                                    &eax_1, &ebx_1, &ecx_1_unused, &edx_1_unused);
+                                    &eax_1, &ebx_1, &ecx_1, &edx_1);
 
         if (!eax_0 ||
            ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
@@ -7578,7 +7607,27 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         }
     }
 
-    return x86_cpu_have_filtered_features(cpu);
+    have_filtered_features = x86_cpu_have_filtered_features(cpu);
+
+    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+        x86_cpu_get_supported_cpuid(0x24, 0,
+                                    &eax_0, &ebx_0, &ecx_0, &edx_0);
+        uint8_t version = ebx_0 & 0xff;
+
+        if (version < env->avx10_version) {
+            if (prefix) {
+                warn_report("%s: avx10.%d. Adjust to avx10.%d",
+                            prefix, env->avx10_version, version);
+            }
+            env->avx10_version = version;
+            have_filtered_features = true;
+        }
+    } else if (env->avx10_version && prefix) {
+        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        have_filtered_features = true;
+    }
+
+    return have_filtered_features;
 }
 
 static void x86_cpu_hyperv_realize(X86CPU *cpu)
@@ -8362,6 +8411,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
+    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580..d845384dcd 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -972,6 +972,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Support for Advanced Vector Extensions 10 */
+#define CPUID_7_1_EDX_AVX10             (1U << 19)
 /* Flexible return and event delivery (FRED) */
 #define CPUID_7_1_EAX_FRED              (1U << 17)
 /* Load into IA32_KERNEL_GS_BASE (LKGS) */
@@ -1918,6 +1920,8 @@ typedef struct CPUArchState {
     uint32_t cpuid_vendor3;
     uint32_t cpuid_version;
     FeatureWordArray features;
+    /* AVX10 version */
+    uint8_t avx10_version;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index fd9f198892..8e17942c3b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1923,7 +1923,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
         case 0x7:
         case 0x14:
         case 0x1d:
-        case 0x1e: {
+        case 0x1e:
+        case 0x24: {
             uint32_t times;
 
             c->function = i;
-- 
2.34.1


