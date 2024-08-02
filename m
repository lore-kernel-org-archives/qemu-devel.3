Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D74C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZmld-0004sF-09; Fri, 02 Aug 2024 03:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZmlb-0004qq-95
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:31:59 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZmlY-0005QG-HF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722583916; x=1754119916;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7D9m1Vwty0leOO0yNxbulFSsgnMu6gZlwL31j+W/bsM=;
 b=Zxey3BZMEK1uQnBzEkucjyszCicaL5WHcDZrXHJcEtWlAYEzE54U05bR
 dALv9uRwnELuC5LnNFk6/ywsMWBD2KorR7t6hRg5ROUu2CPpYICPzIkVa
 4jk2fOwlNsSdgi06p/Ykr+1J6z9MggEokBXJ3poDcWZCSJYzLuwm9vYVq
 uo9gCWz+h0aB9ONvq8hhFLg01W4XlwGyXPlfmYPWw0U6RyF9pM9nmTDVH
 fVrtv5n2CqgZzfIrFlGZiM8QKAkOqe+gOMGWaSp22XK+iBr5bAx73KCkC
 LmG40LpU9KcONsjIob6UvzIPVAfSX0OvuP0FNqjCy/m5N4GqCzMdwM4W4 A==;
X-CSE-ConnectionGUID: gNKRXEONSnSKesEqjxwVtQ==
X-CSE-MsgGUID: NddrGtyETtCFp0ebNOwB3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20760861"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="20760861"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 00:31:53 -0700
X-CSE-ConnectionGUID: kYXpqQzTTEmvYdDzebwAiQ==
X-CSE-MsgGUID: /PnYbwGdQ72DNF0bJmo2Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; d="scan'208";a="55915131"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 02 Aug 2024 00:31:50 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Manish <manish.mishra@nutanix.com>, John Levon <john.levon@nutanix.com>,
 zhao1.liu@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] i386/cpu: Introduce enable_cpuid_0x1f to force exposing CPUID
 0x1f
Date: Fri,  2 Aug 2024 03:24:26 -0400
Message-Id: <20240802072426.4016194-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
module level, are configured for the guest.

However, 1) TDX architecture forces to require CPUID 0x1f to configure CPU
topology. and 2) There is a bug in Windows that Windows expects valid
0x1f leafs when the maximum basic leaf > 0x1f[1].

Introduce a bool flag enable_cpuid_0x1f in CPU for the cases that
requires CPUID leaf 0x1f to be exposed to guest. For case 2), introduce
a user settable property as well, which provides an opt-in interface
for people to run the buggy Windows as a workaround. The default value
of the property is set to false, thus making no effect on existing
setup.

Opportunistically rename x86_has_extended_topo() to
x86_has_v2_extended_topo() because per Intel SDM, leaf 0xb is for extended
topology enumeration leaf and leaf 0x1f is v2 extended topology enumration
leaf.

[1] https://lore.kernel.org/qemu-devel/21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 include/hw/i386/topology.h |  9 ---------
 target/i386/cpu.c          | 18 ++++++++++++++++--
 target/i386/cpu.h          |  4 ++++
 target/i386/kvm/kvm.c      |  2 +-
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index dff49fce1154..b63bce2f4c82 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -207,13 +207,4 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
     return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
-/*
- * Check whether there's extended topology level (module or die)?
- */
-static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
-{
-    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
-           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
-}
-
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2d9..b5b7ac96c272 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -300,6 +300,19 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+/*
+ * Check whether there's v2 extended topology level (module or die)?
+ */
+bool x86_has_v2_extended_topo(X86CPU *cpu)
+{
+    if (cpu->enable_cpuid_0x1f) {
+        return true;
+    }
+
+    return test_bit(CPU_TOPO_LEVEL_MODULE, cpu->env.avail_cpu_topo) ||
+           test_bit(CPU_TOPO_LEVEL_DIE, cpu->env.avail_cpu_topo);
+}
+
 static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
                                           enum CPUTopoLevel topo_level)
 {
@@ -6637,7 +6650,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+        if (!x86_has_v2_extended_topo(cpu)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7450,7 +7463,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if (x86_has_extended_topo(env->avail_cpu_topo) &&
+        if (x86_has_v2_extended_topo(cpu) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
@@ -8316,6 +8329,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, false),
     DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
     DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3d8..211a42ffbfa6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2110,6 +2110,9 @@ struct ArchCPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* Force to expose cpuid 0x1f */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
@@ -2368,6 +2371,7 @@ void cpu_set_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 bool cpu_has_x2apic_feature(CPUX86State *env);
+bool x86_has_v2_extended_topo(X86CPU *cpu);
 
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b4aab9a410b5..d43c1fa26746 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1835,7 +1835,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
             break;
         }
         case 0x1f:
-            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
+            if (!x86_has_v2_extended_topo(env_archcpu(env))) {
                 cpuid_i--;
                 break;
             }
-- 
2.34.1


