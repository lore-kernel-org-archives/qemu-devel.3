Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CBBC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXjB-0003Zk-5M; Fri, 20 Jun 2025 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXix-0003Ho-Sm
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:08:00 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXiq-00055r-MG
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410465; x=1781946465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TObZAbEWJ2CPPP3wgEr0dN5obTobFnYleyBjpYYTALU=;
 b=JwRILnbgdzf6vR0z5/MksS5y/kfD5KktxQAcMOnxz99tTJxZIpVxP0ym
 OVaZPbPXcQXg8nCBzWZK9y1SVexXkSPyBKCCRkeiMTowrDlmIVzjLo54I
 adol5KzKCFMfn9lErcq9pP4LVhVcG3YvlrhKq5HSBmM3/G0BXuk3Vm/mJ
 Ow+qMLEBlKjOXqssWGJYOLMFZvadaSqdMdCI+F4F6SJ25VSNBYC1QZAA8
 dbBpwP4jOX/cq9eju7SM18AoLezfCOH47SneM5z2RzeQZLqUqnwU5QREz
 rVvtFpbgvoBc9Em1E5S61tdj+2xniH6mX/CTgke2bdcjj20n0Vb6NhHYN A==;
X-CSE-ConnectionGUID: 3IZ8j0/CRMiiXacSjuxWnw==
X-CSE-MsgGUID: 0P0coZWVSIyyyiHj+edr7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466860"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:07:34 -0700
X-CSE-ConnectionGUID: wm8HKNloTsWHheErUKlKqg==
X-CSE-MsgGUID: wPYRgqVVSm6SMs4Z/8d5ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156670210"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:07:30 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 16/16] i386/cpu: Use a unified cache_info in X86CPUState
Date: Fri, 20 Jun 2025 17:27:34 +0800
Message-Id: <20250620092734.1576677-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620092734.1576677-1-zhao1.liu@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At present, all cases using the cache model (CPUID 0x2, 0x4, 0x80000005,
0x80000006 and 0x8000001D leaves) have been verified to be able to
select either cache_info_intel or cache_info_amd based on the vendor.

Therefore, further merge cache_info_intel and cache_info_amd into a
unified cache_info in X86CPUState, and during its initialization, set
different legacy cache models based on the vendor.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 150 ++++++++--------------------------------------
 target/i386/cpu.h |   5 +-
 2 files changed, 27 insertions(+), 128 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4e9ac37850c0..c1d1289ee9de 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7484,27 +7484,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         } else if (env->enable_legacy_vendor_cache) {
             caches = &legacy_intel_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't use legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
-             *    CPU will use cache_info_amd. But this doesn't matter for AMD
-             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
-             *    model is.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -7523,27 +7503,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_intel_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't use legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. Non-AMD CPUs use cache_info_cpuid4 like before and AMD
-             *    CPU will use cache_info_amd. But this doesn't matter for AMD
-             *    CPU, because this leaf encodes all-0 for AMD whatever its cache
-             *    model is.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         /* cache info: needed for Core compatibility */
@@ -7951,27 +7911,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_amd_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't uses legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. AMD CPUs use cache_info_amd like before and non-AMD
-             *    CPU will use cache_info_cpuid4. But this doesn't matter,
-             *    because for Intel CPU, it will get all-0 leaf, and Zhaoxin CPU
-             *    will get correct cache info. Both are expected.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -7998,25 +7938,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         if (env->enable_legacy_vendor_cache) {
             caches = &legacy_amd_cache_info;
         } else {
-            /*
-             * FIXME: Temporarily select cache info model here based on
-             * vendor, and merge these 2 cache info models later.
-             *
-             * This condition covers the following cases (with
-             * enable_legacy_vendor_cache=false):
-             *  - When CPU model has its own cache model and doesn't uses legacy
-             *    cache model (legacy_model=off). Then cache_info_amd and
-             *    cache_info_cpuid4 are the same.
-             *
-             *  - For v10.1 and newer machines, when CPU model uses legacy cache
-             *    model. AMD CPUs use cache_info_amd like before and non-AMD
-             *    CPU (Intel & Zhaoxin) will use cache_info_cpuid4 as expected.
-             */
-            if (IS_AMD_CPU(env)) {
-                caches = &env->cache_info_amd;
-            } else {
-                caches = &env->cache_info_cpuid4;
-            }
+            caches = &env->cache_info;
         }
 
         if (cpu->cache_info_passthrough) {
@@ -8089,22 +8011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
-    case 0x8000001D: {
-        const CPUCaches *caches;
-
-        /*
-         * FIXME: Temporarily select cache info model here based on
-         * vendor, and merge these 2 cache info models later.
-         *
-         * Intel doesn't support this leaf so that Intel Guests don't
-         * have this leaf. This change is harmless to Intel CPUs.
-         */
-        if (IS_AMD_CPU(env)) {
-            caches = &env->cache_info_amd;
-        } else {
-            caches = &env->cache_info_cpuid4;
-        }
-
+    case 0x8000001D:
         *eax = 0;
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
@@ -8112,19 +8019,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(caches->l1d_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l1d_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(caches->l1i_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l1i_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(caches->l2_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l2_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(caches->l3_cache,
+            encode_cache_cpuid8000001d(env->cache_info.l3_cache,
                                        topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
@@ -8135,7 +8042,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx &= CACHE_NO_INVD_SHARING | CACHE_INCLUSIVE;
         }
         break;
-    }
     case 0x8000001E:
         if (cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
@@ -8825,46 +8731,34 @@ static bool x86_cpu_update_smp_cache_topo(MachineState *ms, X86CPU *cpu,
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l1d_cache->share_level = level;
-        env->cache_info_amd.l1d_cache->share_level = level;
+        env->cache_info.l1d_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
-            env->cache_info_cpuid4.l1d_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1D,
-            env->cache_info_amd.l1d_cache->share_level);
+            env->cache_info.l1d_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l1i_cache->share_level = level;
-        env->cache_info_amd.l1i_cache->share_level = level;
+        env->cache_info.l1i_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
-            env->cache_info_cpuid4.l1i_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L1I,
-            env->cache_info_amd.l1i_cache->share_level);
+            env->cache_info.l1i_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l2_cache->share_level = level;
-        env->cache_info_amd.l2_cache->share_level = level;
+        env->cache_info.l2_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
-            env->cache_info_cpuid4.l2_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2,
-            env->cache_info_amd.l2_cache->share_level);
+            env->cache_info.l2_cache->share_level);
     }
 
     level = machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3);
     if (level != CPU_TOPOLOGY_LEVEL_DEFAULT) {
-        env->cache_info_cpuid4.l3_cache->share_level = level;
-        env->cache_info_amd.l3_cache->share_level = level;
+        env->cache_info.l3_cache->share_level = level;
     } else {
         machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
-            env->cache_info_cpuid4.l3_cache->share_level);
-        machine_set_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3,
-            env->cache_info_amd.l3_cache->share_level);
+            env->cache_info.l3_cache->share_level);
     }
 
     if (!machine_check_smp_cache(ms, errp)) {
@@ -9091,7 +8985,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             return;
         }
-        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
+        env->cache_info = *cache_info;
     } else {
         /* Build legacy cache information */
         if (!cpu->consistent_cache) {
@@ -9101,8 +8995,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         if (!cpu->vendor_cpuid_only_v2) {
             env->enable_legacy_vendor_cache = true;
         }
-        env->cache_info_cpuid4 = legacy_intel_cache_info;
-        env->cache_info_amd = legacy_amd_cache_info;
+
+        if (IS_AMD_CPU(env)) {
+            env->cache_info = legacy_amd_cache_info;
+        } else {
+            env->cache_info = legacy_intel_cache_info;
+        }
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 243383efd602..3f79db679888 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2072,11 +2072,12 @@ typedef struct CPUArchState {
     /* Features that were explicitly enabled/disabled */
     FeatureWordArray user_features;
     uint32_t cpuid_model[12];
-    /* Cache information for CPUID.  When legacy-cache=on, the cache data
+    /*
+     * Cache information for CPUID.  When legacy-cache=on, the cache data
      * on each CPUID leaf will be different, because we keep compatibility
      * with old QEMU versions.
      */
-    CPUCaches cache_info_cpuid4, cache_info_amd;
+    CPUCaches cache_info;
     bool enable_legacy_cpuid2_cache;
     bool enable_legacy_vendor_cache;
 
-- 
2.34.1


