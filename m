Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387D6D1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DHE-0006X3-92; Tue, 05 Nov 2024 01:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DF6-0003Xb-Vn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:50 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DF2-0001vd-FF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788840; x=1762324840;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R3qGJveZ2fmuHjYuT93ENGzexAuyNwuq1EZaJ0+cqc0=;
 b=V2xxfs4KNBt4H4q0DTX+Xu8OKd1kmXgIfF0s5a27QWiJZNP4fm0iTrql
 u9RbcRpjKmYh+NjrbTzo7Dj3T4UrXxwjLGNGfbqtRHNDrfGcrnwYQMQEa
 ea8RnIr28gjGPRMhlWmh3HhrvAwjbzkayR8/A9ZTxTj2UNXzqaV8JLw+I
 vRTlZuwWueCota1pSWvXNRFFx7T1IUQyUvyGKShry8ki51Fl9HSK6nsf7
 zPsx4vUUpXA28S6TVKwxVpu+R/VFePyVIYTNDd3uZWhI8x1TVMYkm88Ze
 bXvnCL12rc/nj4eZBb5ThzHNhm+BZb9sNAJFd7N30537++UdqA3tnh9pv A==;
X-CSE-ConnectionGUID: B9a/kTtuSYWSRguMoZGYVA==
X-CSE-MsgGUID: ySkMU0xyS4WIdddt8Ewd/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689917"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689917"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:40:18 -0800
X-CSE-ConnectionGUID: cCHE70fzS4uPY/tjfHAGjA==
X-CSE-MsgGUID: 4cVcz/YWTguoW1CHzdYfFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83990026"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:40:14 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 55/60] i386/tdx: Fetch and validate CPUID of TD guest
Date: Tue,  5 Nov 2024 01:24:03 -0500
Message-Id: <20241105062408.3533704-56-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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
 target/i386/kvm/tdx.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index e7e0f073dfc9..9cb099e160e4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -673,6 +673,86 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
     return value;
 }
 
+
+static void tdx_fetch_cpuid(CPUState *cpu, struct kvm_cpuid2 *fetch_cpuid)
+{
+    int r;
+
+    r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid);
+    if (r) {
+        error_report("KVM_TDX_GET_CPUID failed %s", strerror(-r));
+        exit(1);
+    }
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
+    fetch_cpuid = g_malloc0(sizeof(*fetch_cpuid) +
+                    sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
+    tdx_fetch_cpuid(cs, fetch_cpuid);
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
@@ -1019,4 +1099,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->cpu_realizefn = tdx_cpu_realizefn;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
+    x86_klass->check_features = tdx_check_features;
 }
-- 
2.34.1


