Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B187E8FDD9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxJ-0003wb-RG; Sat, 27 Dec 2025 04:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxI-0003vv-Nb
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxG-0007Tx-T6
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10lokxWFZGMcqdpqlElNknUBRptLojUTP6HtAnxwNgg=;
 b=UORLUJEhHIOqgcYhQXdaYlO+F4wIrlfZmxrr5tZqPD9QFAOAov7IGEU+QqZVexDO1KOeFj
 AsEbHnSULmrjRSJgnsA0sQf/wuGWKN9/lhg6Qi05I/XJT589+ot3tkx5OTOPwCQQs8tufT
 YR3RCrT0/OdnmmKHmDVfniP+x+3zes4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-z4HL9WSRPASGhQ_jvH8-vg-1; Sat, 27 Dec 2025 04:51:19 -0500
X-MC-Unique: z4HL9WSRPASGhQ_jvH8-vg-1
X-Mimecast-MFC-AGG-ID: z4HL9WSRPASGhQ_jvH8-vg_1766829078
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54955855e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829076; x=1767433876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10lokxWFZGMcqdpqlElNknUBRptLojUTP6HtAnxwNgg=;
 b=D87gBlQodmF1/NxDw6n8wftdHjM3aYI6Dm75VChpW0SP3gVji2DpUK68XnHPe+XjG9
 y+EPf0VwaIA9N8yxnHdlKrbCyaxNfhTM1NMX3GTq03kT+BdITWWOe0Ii03126TyztDKb
 WSeX0EIc78u9dDgUTbqC4x+bDe6U5qfuh3YaBGBJLMk7FdpgBR0UZwM0fbV8xjJhLDrT
 CsWYFF7ZGQabC9uguc6tKoveb+KwdV/slBCKeqNbpP6gC3l2r1PYisoXM8ZNYpZpg80J
 AmaGN8ZM0+yuWKaWcozu7rUMM5D4ZblYOhIQtmfuWf0wLxM5u0A4zKRB+71UetMCBgNS
 1YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829076; x=1767433876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=10lokxWFZGMcqdpqlElNknUBRptLojUTP6HtAnxwNgg=;
 b=N4P1oJ9u/pG7dz0aS45datgXNluh8mZ9NpShU5Bw80nZdc3Aq4UFvPLOv1kBh5L6BA
 eoQcQBl13OzNvoixbfVxedZLFXmdv47RGnIGOvvhyhpZcyLM1ryqi3oWSMK8KLrsxB4b
 tfrJSHQYqLWf8OnNMMptnjzBAojcOp1BMhvUsCtrBrEBaevJ0+LtC7HB5LRtWbGZbOwe
 3St5lDSuJ1/WaU7HCH6Do3VsmWgxCkpJnNv4tXQwqbAQVXWX1qQYRo8WcdfLNcabfMF3
 XEKPfN88fzes8QQHQZHLX0W4l/JL45o6cnmVJGIcfkWN+uJ6EiIpadJKm6iOtO6hf5TE
 vzIQ==
X-Gm-Message-State: AOJu0YyCaOIFJT9rtbybQ0QeGA9n4gbZ/AY0bTQkSJBV/UdxKfULF5Oo
 pbNZKFu+PGdyD/PeN3KTXjuuTdK1VQSdRtkbynD/j1NWF+mn+FVp4/Zlu0jBtKN++64Xa3qJkUk
 mIbZ1y4tFxty6E2fokdE1gxcB4D6fAVc199O+gAnkKLxNAvvEDTkSgSUr8iWoLyIFdRVzLaaDr/
 ph6uqPKBS3V7/g68nQrdC/svYamguozwlNQSJZsRdf
X-Gm-Gg: AY/fxX5GC64mZcsG8pK5RqAMrggs58B3C4hReONrCC7Y6vvyq/n4JSjwW8kz3ELCXiR
 5xr9gBwndZaq5yKZDSoClP5CeMM1FLG/OcglIHPI5keKjSNsV7879khMLtAhu/Xp1n+BC+cSwfH
 mzb42Pv79jYInNWpff7WwxGqAnXV+qLPrtxwRNu3Ba+wuvrvhl1qCZ969iLww6fUskjztwPLv6U
 kyNu4PZO8iTyqv25c0K8IB9oX4TfyoGAQqx8EguxsA9hp19/REIVZo5jA0O7bZNtwZHdJBVElp2
 2P8Mbt8xFD34inm1Ab3QqH+gaQUIq5gAbjcjCAOri+jWuGtSy+GIIT7KKqgsSJulmeQslgWUVlE
 efntFc4fkDTawU/+ncdUGzt2wsDII4h6WaGnXYIGyG2UOdsHR5xdJD/HCUZ0L0pghwjMyNOSm//
 JQachYdO97Q/80/qY=
X-Received: by 2002:a05:600c:1c13:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-47d195893d6mr275423165e9.25.1766829076577; 
 Sat, 27 Dec 2025 01:51:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk+IxJ9khSoPgVmJLFyilGLqqG/nBetPJDxN6bL0VSQZ54fG1CFC4Zo7hWQ3PluJ4gkB2DHA==
X-Received: by 2002:a05:600c:1c13:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-47d195893d6mr275422935e9.25.1766829076129; 
 Sat, 27 Dec 2025 01:51:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm50899132f8f.30.2025.12.27.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 139/153] i386/cpu: Support AVX10.2 with AVX10 feature models
Date: Sat, 27 Dec 2025 10:47:44 +0100
Message-ID: <20251227094759.35658-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

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
Link: https://lore.kernel.org/r/20251215073743.4055227-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |   2 +
 target/i386/cpu.c | 120 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 653f14e516c..a4a8bc61a99 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2211,6 +2211,8 @@ typedef struct CPUArchState {
     FeatureWordArray features;
     /* AVX10 version */
     uint8_t avx10_version;
+    /* AVX10 (CPUID 0x24) maximum supported sub-leaf. */
+    uint8_t avx10_max_subleaf;
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0d75d170fa..9c81e4e1f5a 100644
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
-- 
2.52.0


