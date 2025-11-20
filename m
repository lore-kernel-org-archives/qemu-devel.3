Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867EDCF8548
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 06:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLyTE-0005Ef-Ln; Thu, 20 Nov 2025 01:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT3-00056g-3V
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:36 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLyT0-0005r2-Hp
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763621310; x=1795157310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i5vENy5xcihQBdFm1zq0FPKrc6pgzj2qJbONT4P3B6E=;
 b=BUBpRdabTaSTdOHWVhIBkwH3dZjp8sLgQgqy5OGIBvlKeE8XerW1cvjC
 XQ70mLjtiJ8Nz8UIZ/swdDDAwfHZP1gyVqPzTPs9+rekpcxR1eBgIlRDO
 jXbO7h1rmvs3bf8E/dWkyzOvSx4EcWNAoWzSM58lgZvAK3+eTg61UjANO
 Smzl0oAzdR9pmqlmRifyFvYjcaV8qyOhLB4IyIB0WDTGuSa2ecubRPukq
 IQG5j55pUqCiYlv00E530iD3zxU8sDCz6uJasg80u7azuw935w6WkiqBy
 8G1GGY2c7YabFGlebkuGqXIEYH9JhnHF9olZlerkZJxhl7ytJNXTwriti w==;
X-CSE-ConnectionGUID: 1STM4eRJT36u7GGa3U9i8w==
X-CSE-MsgGUID: WjFpMZp5TZG5H2T1H5II+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65572544"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="65572544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 22:48:25 -0800
X-CSE-ConnectionGUID: 4SBcD9WZQmiA3owTRWQQ0g==
X-CSE-MsgGUID: 6ekqIX3LREqRVj+32zQ97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; d="scan'208";a="191296120"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 19 Nov 2025 22:48:23 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xudong Hao <xudong.hao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/10] i386/cpu: Support AVX10.2 with AVX10 feature models
Date: Thu, 20 Nov 2025 15:10:24 +0800
Message-Id: <20251120071030.961230-5-zhao1.liu@intel.com>
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

Intel AVX10 Version 2 (Intel AVX10.2) includes a suite of new
instructions delivering new AI features and performance, accelerated
media processing, expanded Web Assembly, and Cryptography support, along
with enhancements to existing legacy instructions for completeness and
efficiency, and it is enumerated as version 2 in CPUID 0x24.0x0.EBX[bits
0-7] [*].

Considerring "Intel CPUs which support Intel AVX10.2 will include an
enumeration for AVX10_VNNI_INT (CPUID.24H.01H:ECX.AVX10_VNNI_INT[2])"
[*] and EVEX VPDP* instructions for INT8/INT16 (AVX10_VNNI_INT) are
detected by either AVX10.2 OR AVX10_VNNI_INT, AVX10_VNNI_INT is part of
AVX10.2, so any Intel AVX10.2 implementation lacking the AVX10_VNNI_INT
enumeration should be considered buggy hardware.

Therefore, it's necessary to set AVX10_VNNI_INT enumeration for Guest
when the user specifies AVX10 version 2. For this, introduce AVX10
models to explicitly define the feature bits included in different AVX10
versions.

[*]: Intel Advanced Vector Extensions 10.2 Architecture Specification
     (rev 5.0).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Reference link: https://cdrdv2.intel.com/v1/dl/getContent/856721
---
 target/i386/cpu.c | 120 +++++++++++++++++++++++++++++++++++++++++++---
 target/i386/cpu.h |   2 +
 2 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a6bb9ec21c5..f0ed575dce59 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2382,6 +2382,40 @@ x86_cpu_def_get_versions(const X86CPUDefinition *def)
     return def->versions ?: default_version_list;
 }
 
+/* CPUID 0x24.0x0 (EAX, EBX, ECX, EDX) and 0x24.0x1 (EAX, EBX, ECX, EDX) */
+#define AVX10_FEATURE_WORDS 8
+
+typedef struct AVX10VersionDefinition {
+    const char *name;
+    /* AVX10 version */
+    uint8_t version;
+    /* AVX10 (CPUID 0x24) maximum supported sub-leaf. */
+    uint8_t max_subleaf;
+    FeatureMask *features;
+} AVX10VersionDefinition;
+
+static const AVX10VersionDefinition builtin_avx10_defs[] = {
+    {
+        .name = "avx10.1",
+        .version = 1,
+        .max_subleaf = 0,
+        .features = (FeatureMask[]) {
+            { FEAT_7_1_EDX,         CPUID_7_1_EDX_AVX10 },
+            { FEAT_24_0_EBX,        CPUID_24_0_EBX_AVX10_VL_MASK },
+            { /* end of list */ }
+        }
+    },
+    {
+        .name = "avx10.2",
+        .version = 2,
+        .max_subleaf = 1,
+        .features = (FeatureMask[]) {
+            { FEAT_24_1_ECX,         CPUID_24_1_ECX_AVX10_VNNI_INT },
+            { /* end of list */ }
+        }
+    },
+};
+
 static const CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
@@ -7242,6 +7276,65 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
     cpu->env.tsc_khz = cpu->env.user_tsc_khz = value / 1000;
 }
 
+static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    uint8_t value;
+
+    value = cpu->env.avx10_version;
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
+                                         Error **errp)
+{
+    const AVX10VersionDefinition *def;
+    CPUX86State *env = &cpu->env;
+
+    if (!version) {
+        env->avx10_version = 0;
+        env->avx10_max_subleaf = 0;
+        return true;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(builtin_avx10_defs); i++) {
+        FeatureMask *f;
+
+        def = &builtin_avx10_defs[i];
+        for (f = def->features; f && f->mask; f++) {
+            env->features[f->index] |= f->mask;
+        }
+
+        if (def->version == version) {
+            env->avx10_version = version;
+            env->avx10_max_subleaf = def->max_subleaf;
+            break;
+        }
+    }
+
+    if (def->version < version) {
+        error_setg(errp, "avx10-version can be at most %d", def->version);
+        return false;
+    }
+    return true;
+}
+
+static void x86_cpuid_set_avx10_version(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    X86CPU *cpu = X86_CPU(obj);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+
+    x86_cpu_apply_avx10_features(cpu, value, errp);
+}
+
 /* Generic getter for "feature-words" and "filtered-features" properties */
 static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
@@ -7932,8 +8025,10 @@ static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
      */
     object_property_set_str(OBJECT(cpu), "vendor", def->vendor, &error_abort);
 
-    object_property_set_uint(OBJECT(cpu), "avx10-version", def->avx10_version,
-                             &error_abort);
+    if (def->avx10_version) {
+        object_property_set_uint(OBJECT(cpu), "avx10-version",
+                                 def->avx10_version, &error_abort);
+    }
 
     x86_cpu_apply_version_props(cpu, model);
 
@@ -8480,9 +8575,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
         if (count == 0) {
-            uint32_t unused;
-            x86_cpu_get_supported_cpuid(0x1E, 0, eax, &unused,
-                                        &unused, &unused);
+            *eax = env->avx10_max_subleaf;
             *ebx = env->features[FEAT_24_0_EBX] | env->avx10_version;
         } else if (count == 1) {
             *ecx = env->features[FEAT_24_1_ECX];
@@ -9164,7 +9257,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) && !env->avx10_version) {
             uint32_t eax, ebx, ecx, edx;
             x86_cpu_get_supported_cpuid(0x24, 0, &eax, &ebx, &ecx, &edx);
-            env->avx10_version = ebx & 0xff;
+
+            if (!object_property_set_uint(OBJECT(cpu), "avx10-version",
+                                          ebx & 0xff, errp)) {
+                return;
+            }
         }
     }
 
@@ -9393,6 +9490,11 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
                 warn_report("%s: avx10.%d. Adjust to avx10.%d",
                             prefix, env->avx10_version, version);
             }
+            /*
+             * Discrete feature bits have been checked and filtered based on
+             * host support. So it's safe to change version without reverting
+             * other feature bits.
+             */
             env->avx10_version = version;
             have_filtered_features = true;
         }
@@ -10229,7 +10331,6 @@ static const Property x86_cpu_properties[] = {
     DEFINE_PROP_UINT32("min-level", X86CPU, env.cpuid_min_level, 0),
     DEFINE_PROP_UINT32("min-xlevel", X86CPU, env.cpuid_min_xlevel, 0),
     DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
-    DEFINE_PROP_UINT8("avx10-version", X86CPU, env.avx10_version, 0),
     DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
@@ -10371,6 +10472,11 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 
+    object_class_property_add(oc, "avx10-version",  "uint8",
+                              x86_cpuid_get_avx10_version,
+                              x86_cpuid_set_avx10_version,
+                              NULL, NULL);
+
 #if !defined(CONFIG_USER_ONLY)
     object_class_property_add(oc, "crash-information", "GuestPanicInformation",
                               x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 970a4d03a560..a0b8a59f6c98 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2185,6 +2185,8 @@ typedef struct CPUArchState {
     FeatureWordArray features;
     /* AVX10 version */
     uint8_t avx10_version;
+    /* AVX10 (CPUID 0x24) maximum supported sub-leaf. */
+    uint8_t avx10_max_subleaf;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-- 
2.34.1


