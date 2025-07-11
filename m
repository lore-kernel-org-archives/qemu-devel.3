Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58941C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAaI-0005hc-4D; Fri, 11 Jul 2025 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZq-00047C-Pl
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:59 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZk-0005gb-OJ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228113; x=1783764113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2otHjRjWFXMpNbrnGgfOTh3c1Qw0xqo7w+y00sXBUEI=;
 b=PdZXBzjKw0u+iaWKLz38sitc9f5IU6xr6d5Cza8REtIswz165qwF/5ca
 r/eE+TIHdagaFDg7HMZuT3WirrckbxGPGHRBVZ3luXL5mwV3qwINMax8d
 wCFsG1hzBYW/Vx8zzbTQI5gSJ7MUeFENk4ZVPEqWJTuVQaTbzbbfuGsqG
 CbHyYHnBgG9QTkRbkP/YG0qe3ZwOhxWi9Y0aj0I9u26DaaTq1to40lhr0
 t8HWJdUXiGQJ73eZknqo5eR1lUJxr0NIfzYzp0u4it87MHZPE1L+wPex6
 aEvWW0IbTGGUj8kMICQEWm8d0zA4m96HUUpVvZqvbB0t1MtvVxCUacsXg A==;
X-CSE-ConnectionGUID: foWwodNbSt6Q8V7X8KDV6g==
X-CSE-MsgGUID: lEX6nL8mTXmbpeWYRkV3WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496464"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496464"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:50 -0700
X-CSE-ConnectionGUID: qYYYD/I+QluSm8oJY8FfVA==
X-CSE-MsgGUID: xxeM9sLLSjyWseOo+Fo72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662165"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:01:45 -0700
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
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v2 18/18] i386/cpu: Use a unified cache_info in X86CPUState
Date: Fri, 11 Jul 2025 18:21:43 +0800
Message-Id: <20250711102143.1622339-19-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 150 ++++++++--------------------------------------
 target/i386/cpu.h |   5 +-
 2 files changed, 27 insertions(+), 128 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index df13dbc63a3f..7f88fe0c8697 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7476,27 +7476,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -7515,27 +7495,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -7944,27 +7904,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -7991,25 +7931,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -8082,22 +8004,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -8105,19 +8012,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -8128,7 +8035,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -9101,7 +8995,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             return;
         }
-        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
+        env->cache_info = *cache_info;
     } else {
         /* Build legacy cache information */
         if (!cpu->consistent_cache) {
@@ -9111,8 +9005,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
index bb474e65c4f7..3eecee3721b8 100644
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


