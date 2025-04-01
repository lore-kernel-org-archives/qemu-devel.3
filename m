Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D3AC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbuh-0000pE-Od; Tue, 01 Apr 2025 09:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtp-0000Po-Pe
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:35 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtk-0006XQ-HW
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515004; x=1775051004;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tFJxc0hPGYbpGryweTt7b9HNFUSwGfkJnzzXKhIIBxQ=;
 b=GfcI5b++b2uABryzGpV5akBDDHvSxku87J/XT55T0pQnmR7rKLMUT/ZE
 fu7ynYPKp2EKjYb7cgCAuisj9/eVzSPPTQ/dpChQyq0geGtm41twHB2UC
 ZEhQzR0YUfTCA6+OwF50Rzf/DvCxdI43blgnoY50JBKHTAFDF6nzGavCT
 JVWvEIUmyizjSe7bWElL4I21goMuq9wPY/8ECHog7tnUhiANOEO6xj5NC
 JlMy9dfL1J/SFXONYLzZ+kayu3UX6fOtF3JCO/xq95Ksw3S/h8n8YbfsA
 0xrDfw4d7803dAiQIsJOyg1rKnIuPp++YWJ+XHhYyaRswatGbunBA+PB+ Q==;
X-CSE-ConnectionGUID: Yf57CIOdQv+RF8KxDRAAIw==
X-CSE-MsgGUID: kdnkS+0sRBafJGKUlKCO5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433444"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:35 -0700
X-CSE-ConnectionGUID: 79LCMqYaRSqf1SZ299nHkg==
X-CSE-MsgGUID: NrzSPPumTFKE8piPTEdf0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640114"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:33 -0700
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
Subject: [PATCH v8 33/55] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Date: Tue,  1 Apr 2025 09:01:43 -0400
Message-Id: <20250401130205.2198253-34-xiaoyao.li@intel.com>
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

Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
when topology level that cannot be enumerated by leaf 0xB, e.g., die or
module level, are configured for the guest, e.g., -smp xx,dies=2.

However, TDX architecture forces to require CPUID 0x1f to configure CPU
topology.

Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
requires CPUID leaf 0x1f to be exposed to guest.

Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
to enable cpuid leaf 0x1f for the guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.c     | 4 ++--
 target/i386/cpu.h     | 9 +++++++++
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5c69d1489365..f219961b62cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7006,7 +7006,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_cpuid_0x1f(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7870,7 +7870,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if (x86_has_cpuid_0x1f(cpu) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55d..3910b488f775 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2251,6 +2251,9 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Force to enable cpuid 0x1f */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -2513,6 +2516,12 @@ void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
 
+static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
+{
+    return cpu->enable_cpuid_0x1f ||
+           x86_has_extended_topo(cpu->env.avail_cpu_topo);
+}
+
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a76f34537908..741b50181ed9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1871,7 +1871,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
                 cpuid_i--;
                 break;
             }
-- 
2.34.1


