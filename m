Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F78E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 11:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOEVp-0004ac-7R; Thu, 19 Dec 2024 06:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVm-0004ZH-TE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:11 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tOEVk-0005H9-M8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734606969; x=1766142969;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tRxETGQlqjIQxxsWh7jh7u56GFx7gaGULz5y7HZ7JNo=;
 b=Wy3SRm9lHdKeDWYtN9yH1AuKk7YCDuredn6qPH7/wJxo3Zb+OqrtMLGV
 NabObyiKuKfcG1y5b6dRxKxDwqwvH2a98HEK0KOGMs9iPFARLX7iTyJ0k
 mTaTuYQ6w2UYGoUFmyUY9bIjpkLH/js6MeVYk/k3ECJyKxQ3wBnhKGK2x
 sbzGiWtz4c5RG+AABmP+hMtIrFKgBD/VNkQJnDQd3gl4AETmLZfyh+wtn
 xySGVXaQ3xNkwmqUxBjyVRDv08eSY8ALxS627fHp2Z8GFvPUK+h2ALOK0
 74DgHh+e0s6oql7XHKvaSr+UJ9B9w+EThNlEo8xDuXMISZMsemPzRYvID w==;
X-CSE-ConnectionGUID: MACcXBliQvCP+rtfrRCPPg==
X-CSE-MsgGUID: EQXJykWSQwmUIGRRzLE5JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="34994965"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="34994965"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2024 03:16:09 -0800
X-CSE-ConnectionGUID: f7EkjQ3NSrSqlly8mCt2yw==
X-CSE-MsgGUID: HgPUkl7/QqOp3t6AFBLTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="97956171"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 19 Dec 2024 03:16:05 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, xiaoyao.li@intel.com
Subject: [PATCH v2 06/10] i386/cpu: Track a X86CPUTopoInfo directly in
 CPUX86State
Date: Thu, 19 Dec 2024 06:01:21 -0500
Message-Id: <20241219110125.1266461-7-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219110125.1266461-1-xiaoyao.li@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

The name of nr_modules/nr_dies are ambiguous and they mislead people.

The purpose of them is to record and form the topology information. So
just maintain a X86CPUTopoInfo member in CPUX86State instead. Then
nr_modules and nr_dies can be dropped.

As the benefit, x86 can switch to use information in
CPUX86State::topo_info and get rid of the nr_cores and nr_threads in
CPUState. This helps remove the dependency on qemu_init_vcpu() so that
x86 can get and use topology info earlier in x86_cpu_realizefn().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c     | 12 ++++------
 target/i386/cpu-sysemu.c |  6 ++---
 target/i386/cpu.c        | 51 ++++++++++++++++------------------------
 target/i386/cpu.h        |  6 +----
 4 files changed, 29 insertions(+), 46 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 32a8d7a9db87..26c3e3169cd4 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -248,7 +248,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    X86CPUTopoInfo topo_info;
+    X86CPUTopoInfo *topo_info = &env->topo_info;
 
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -267,15 +267,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         }
     }
 
-    init_topo_info(&topo_info, x86ms);
+    init_topo_info(topo_info, x86ms);
 
     if (ms->smp.modules > 1) {
-        env->nr_modules = ms->smp.modules;
         set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
-        env->nr_dies = ms->smp.dies;
         set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
     }
 
@@ -346,12 +344,12 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.module_id = cpu->module_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(topo_info, &topo_ids);
     }
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
 
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, module: %u, core: %u, thread: %u]"
@@ -374,7 +372,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 4e9df0bc0156..31b37c63252c 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -312,11 +312,11 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
 
 uint64_t cpu_x86_get_msr_core_thread_count(X86CPU *cpu)
 {
-    CPUState *cs = CPU(cpu);
+    CPUX86State *env = &cpu->env;
     uint64_t val;
 
-    val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
-    val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+    val = x86_threads_per_pkg(&env->topo_info);  /* thread count, bits 15..0 */
+    val |= x86_cores_per_pkg(&env->topo_info) << 16; /* core count, bits 31..16 */
 
     return val;
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f11b5d401a77..d41768648ab9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6495,15 +6495,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     CPUState *cs = env_cpu(env);
     uint32_t limit;
     uint32_t signature[3];
-    X86CPUTopoInfo topo_info;
+    X86CPUTopoInfo *topo_info = &env->topo_info;
     uint32_t threads_per_pkg;
 
-    topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.modules_per_die = env->nr_modules;
-    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
-    topo_info.threads_per_core = cs->nr_threads;
-
-    threads_per_pkg = x86_threads_per_pkg(&topo_info);
+    threads_per_pkg = x86_threads_per_pkg(topo_info);
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
@@ -6580,12 +6575,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 *eax &= ~0xFC000000;
-                *eax |= max_core_ids_in_package(&topo_info) << 26;
+                *eax |= max_core_ids_in_package(topo_info) << 26;
                 if (host_vcpus_per_cache > threads_per_pkg) {
                     *eax &= ~0x3FFC000;
 
                     /* Share the cache at package level. */
-                    *eax |= max_thread_ids_for_cache(&topo_info,
+                    *eax |= max_thread_ids_for_cache(topo_info,
                                 CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
                 }
             }
@@ -6597,7 +6592,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             switch (count) {
             case 0: /* L1 dcache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
@@ -6605,7 +6600,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 break;
             case 1: /* L1 icache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 if (!cpu->l1_cache_per_core) {
                     *eax &= ~MAKE_64BIT_MASK(14, 12);
@@ -6613,13 +6608,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 break;
             case 2: /* L2 cache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    &topo_info,
+                                    topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        &topo_info,
+                                        topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
@@ -6702,12 +6697,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(&topo_info);
-            *ebx = topo_info.threads_per_core;
+            *eax = apicid_core_offset(topo_info);
+            *ebx = topo_info->threads_per_core;
             *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = apicid_pkg_offset(topo_info);
             *ebx = threads_per_pkg;
             *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
             break;
@@ -6733,7 +6728,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
 
-        encode_topo_cpuid1f(env, count, &topo_info, eax, ebx, ecx, edx);
+        encode_topo_cpuid1f(env, count, topo_info, eax, ebx, ecx, edx);
         break;
     case 0xD: {
         /* Processor Extended State */
@@ -7036,7 +7031,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              * thread ID within a package".
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
-            *ecx = (apicid_pkg_offset(&topo_info) << 12) |
+            *ecx = (apicid_pkg_offset(topo_info) << 12) |
                    (threads_per_pkg - 1);
         } else {
             *ecx = 0;
@@ -7065,19 +7060,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+                                       topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -7089,7 +7084,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         if (cpu->core_id <= 255) {
-            encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
+            encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
             *ebx = 0;
@@ -7994,17 +7989,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
      * based on inputs (sockets,cores,threads), it is still better to give
      * users a warning.
-     *
-     * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
-     * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
     if (IS_AMD_CPU(env) &&
         !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        cs->nr_threads > 1) {
+        env->topo_info.threads_per_core > 1) {
             warn_report_once("This family of AMD CPU doesn't support "
                              "hyperthreading(%d). Please configure -smp "
                              "options properly or try enabling topoext "
-                             "feature.", cs->nr_threads);
+                             "feature.", env->topo_info.threads_per_core);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -8165,9 +8157,6 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
-    env->nr_modules = 1;
-    env->nr_dies = 1;
-
     /* thread, core and socket levels are set by default. */
     set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);
     set_bit(CPU_TOPOLOGY_LEVEL_CORE, env->avail_cpu_topo);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5e1beca94a62..bcdebdf48f7c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2045,11 +2045,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
-    /* Number of dies within this CPU package. */
-    unsigned nr_dies;
-
-    /* Number of modules within one die. */
-    unsigned nr_modules;
+    X86CPUTopoInfo topo_info;
 
     /* Bitmap of available CPU topology levels for this CPU. */
     DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
-- 
2.34.1


