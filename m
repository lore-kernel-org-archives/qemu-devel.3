Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3607AC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 03:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdiO4-0001yQ-2Q; Mon, 12 Aug 2024 23:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sdiO0-0001xl-4A
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 23:39:53 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sdiNw-0000ZH-Qr
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 23:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723520389; x=1755056389;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OBAONuNqvQYhCaOXbw/iLBnNxa9cMzajvRwKBdHrc9M=;
 b=N94uu9yaK4+oCBAjcXN8pNPeVKHmw7568JtzM2/La2wt1UOQhriXyUA/
 tkIOKwORlmAZuga79fbWqBPi9upMk4YQSD/3ma8yHDUoNC2UOQRDg9lvR
 SBnlqk/13TIWjt9Q1Ykh+mUXxxc8y+B17VlJ9EMCMJCvDTBWnSPON0vb1
 PMu1LYlrD4Msv/J2uWNuobY0Zn2ZPXluHl97/Jfx3evXddlKjtMgeYQPl
 CDVGQdFnd/3ICAArI0Z5NgAzj0N3AMsF+wmJHJUiHqRNbjJAzKQ/pFKeG
 zYc6pamVCFC6TNiAeoypE+UzFmEYz9tcvvcZxrD8TJZ4cBZkA+HtuqPwM w==;
X-CSE-ConnectionGUID: d8dV3IGrRtqDjl1uaFiO+w==
X-CSE-MsgGUID: pJiab5+SQB+dh0WLW5+p5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="25524078"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="25524078"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 20:39:44 -0700
X-CSE-ConnectionGUID: 0kN57fCGSlaWqo6bXkV+MQ==
X-CSE-MsgGUID: fBGhjv7EQ9GnAODwV3LbxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="89185400"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa002.jf.intel.com with ESMTP; 12 Aug 2024 20:39:42 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com,
 John Levon <john.levon@nutanix.com>, Manish <manish.mishra@nutanix.com>,
 xiaoyao.li@intel.com
Subject: [PATCH v2] i386/cpu: Introduce enable_cpuid_0x1f to force exposing
 CPUID 0x1f
Date: Mon, 12 Aug 2024 23:31:45 -0400
Message-Id: <20240813033145.279307-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

However, 1) TDX architecture forces to require CPUID 0x1f to configure CPU
topology. and 2) There is a bug in Windows that Windows 10/11 expects valid
0x1f leafs when the maximum basic leaf > 0x1f[1].

Introduce a bool flag, enable_cpuid_0x1f, in CPU for the cases that
require CPUID leaf 0x1f to be exposed to guest. For case 2), introduce
a user settable property, "x-cpuid-0x1f" ,as well, which provides an opt-in
interface for people to run the buggy Windows as a workaround. The default
value of the property is set to false, thus making no effect on existing
setup.

Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
to enable cpuid leaf 0x1f for the guest.

[1] https://lore.kernel.org/qemu-devel/20240724075226.212882-1-manish.mishra@nutanix.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
changes in v2:
 - Add more details in commit message;
 - introduce a separate function x86_has_cpuid_0x1f() instead of
   modifying x86_has_extended_topo();
---
 target/i386/cpu.c     | 5 +++--
 target/i386/cpu.h     | 9 +++++++++
 target/i386/kvm/kvm.c | 2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04e..1e8653c6b051 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6649,7 +6649,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_cpuid_0x1f(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7462,7 +7462,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if (x86_has_cpuid_0x1f(cpu) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
@@ -8328,6 +8328,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("x-cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3d8..085272d4c74a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2110,6 +2110,9 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Force to enable cpuid 0x1f */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -2369,6 +2372,12 @@ void host_cpuid(uint32_t function, uint32_t count,
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
index 31f149c9902c..8af43cb48101 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1835,7 +1835,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
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


