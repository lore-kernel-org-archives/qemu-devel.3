Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64836C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbz5-0006YU-8Q; Tue, 01 Apr 2025 09:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbvB-0001aj-Ii
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:56 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbv9-0006XQ-Ju
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515091; x=1775051091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AcHHhoVG9se9MbdT2EDS9uPRBBoFYbEBeDYXAlLrBrg=;
 b=cKXNLKALVHC0KeDh5xsYzAyPtGOC+yTmCZ3BF4P3ddnvV3Us60w/cTri
 MQSyGpvd+gQDatBK3u2SSYLD7t2vZoA2ZSlcZOy5latU1Tg21wFedGbAj
 UIXtzT1uM13O5TzOGK+Jfo+hqbGb0ymq1sAWDouvWD/v/irHnZuX0YBq5
 Dqm9m77b8oalyFWMqedb+XayQNPnTubgsAv0jnz4NLdFLtGx0Qkciy1bD
 TrNhuuvISysXjcV9aT2TMGfpDQyhwitdT2jXpQkUGLby7TnlYq3Ds1P5B
 v88pqNKB66c8yzF1jAMdUXkitfcDiSIHqlRDUXMFNdIkzb0SfzVDnjI6k w==;
X-CSE-ConnectionGUID: OWqSvCoXT4iCcJmM5sBQWA==
X-CSE-MsgGUID: RyNb2gLlSnGizx4QgUP3BA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433583"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:20 -0700
X-CSE-ConnectionGUID: bLObRQfcSHK7Jyt7ZjG1hw==
X-CSE-MsgGUID: VqFJBFAkT+2Fz68AuMw+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640277"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:17 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 51/55] i386/tdx: Fetch and validate CPUID of TD guest
Date: Tue,  1 Apr 2025 09:02:01 -0400
Message-Id: <20250401130205.2198253-52-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use KVM_TDX_GET_CPUID to get the CPUIDs that are managed and enfored
by TDX module for TD guest. Check QEMU's configuration against the
fetched data.

Print wanring  message when 1. a feature is not supported but requested
by QEMU or 2. QEMU doesn't want to expose a feature while it is enforced
enabled.

- If cpu->enforced_cpuid is not set, prints the warning message of both
1) and 2) and tweak QEMU's configuration.

- If cpu->enforced_cpuid is set, quit if any case of 1) or 2).

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     | 33 ++++++++++++++-
 target/i386/cpu.h     |  7 +++
 target/i386/kvm/tdx.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f09a1caac071..41407c8a7248 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5772,8 +5772,8 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
-                                      const char *verbose_prefix)
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix)
 {
     CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
@@ -5800,6 +5800,35 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
     }
 }
 
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *f = &feature_word_info[w];
+    int i;
+
+    if (!cpu->force_features) {
+        env->features[w] |= mask;
+    }
+
+    cpu->forced_on_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
+            g_autofree char *feat_word_str = feature_word_description(f);
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
+                        feat_word_str,
+                        f->feat_names[i] ? "." : "",
+                        f->feat_names[i] ? f->feat_names[i] : "", i);
+        }
+    }
+}
+
 static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a223e09a25c4..1600e826f372 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2227,6 +2227,9 @@ struct ArchCPU {
     /* Features that were filtered out because of missing host capabilities */
     FeatureWordArray filtered_features;
 
+    /* Features that are forced enabled by underlying hypervisor, e.g., TDX */
+    FeatureWordArray forced_on_features;
+
     /* Enable PMU CPUID bits. This can't be enabled by default yet because
      * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
      * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
@@ -2539,6 +2542,10 @@ void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
 bool is_feature_word_cpuid(uint32_t feature, uint32_t index, int reg);
+void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                               const char *verbose_prefix);
+void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
+                             const char *verbose_prefix);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 7382b53fcc51..58797470ba7e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -764,6 +764,104 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     return value;
 }
 
+static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu)
+{
+    struct kvm_cpuid2 *fetch_cpuid;
+    int size = KVM_MAX_CPUID_ENTRIES;
+    Error *local_err = NULL;
+    int r;
+
+    do {
+        error_free(local_err);
+        local_err = NULL;
+
+        fetch_cpuid = g_malloc0(sizeof(*fetch_cpuid) +
+                                sizeof(struct kvm_cpuid_entry2) * size);
+        fetch_cpuid->nent = size;
+        r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
+        if (r == -E2BIG) {
+            g_free(fetch_cpuid);
+            size = fetch_cpuid->nent;
+        }
+    } while (r == -E2BIG);
+
+    if (r < 0) {
+        error_report_err(local_err);
+        return NULL;
+    }
+
+    return fetch_cpuid;
+}
+
+static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
+{
+    uint64_t actual, requested, unavailable, forced_on;
+    g_autofree struct kvm_cpuid2 *fetch_cpuid;
+    const char *forced_on_prefix = NULL;
+    const char *unav_prefix = NULL;
+    struct kvm_cpuid_entry2 *entry;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    FeatureWordInfo *wi;
+    FeatureWord w;
+    bool mismatch = false;
+
+    fetch_cpuid = tdx_fetch_cpuid(cs);
+    if (!fetch_cpuid) {
+        return -1;
+    }
+
+    if (cpu->check_cpuid || cpu->enforce_cpuid) {
+        unav_prefix = "TDX doesn't support requested feature";
+        forced_on_prefix = "TDX forcibly sets the feature";
+    }
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        wi = &feature_word_info[w];
+        actual = 0;
+
+        switch (wi->type) {
+        case CPUID_FEATURE_WORD:
+            entry = cpuid_find_entry(fetch_cpuid, wi->cpuid.eax, wi->cpuid.ecx);
+            if (!entry) {
+                /*
+                 * If KVM doesn't report it means it's totally configurable
+                 * by QEMU
+                 */
+                continue;
+            }
+
+            actual = cpuid_entry_get_reg(entry, wi->cpuid.reg);
+            break;
+        case MSR_FEATURE_WORD:
+            /*
+             * TODO:
+             * validate MSR features when KVM has interface report them.
+             */
+            continue;
+        }
+
+        requested = env->features[w];
+        unavailable = requested & ~actual;
+        mark_unavailable_features(cpu, w, unavailable, unav_prefix);
+        if (unavailable) {
+            mismatch = true;
+        }
+
+        forced_on = actual & ~requested;
+        mark_forced_on_features(cpu, w, forced_on, forced_on_prefix);
+        if (forced_on) {
+            mismatch = true;
+        }
+    }
+
+    if (cpu->enforce_cpuid && mismatch) {
+        return -1;
+    }
+
+    return 0;
+}
+
 static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
 {
     if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
@@ -1147,4 +1245,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
+    x86_klass->check_features = tdx_check_features;
 }
-- 
2.34.1


