Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BACC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:07:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXi1-000198-Qe; Fri, 20 Jun 2025 05:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXi0-00015R-16
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:52 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXhw-0004zi-V6
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410409; x=1781946409;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HrN3V1+xBd1HD2hJfjrsWV527UXP+zi/OnmT0oMwQxE=;
 b=hn6qLdzzNxzDjtcqnMeWrL3TOfTK4ZJs027bneq97VRepyed7K/cRNDv
 YKVdLv1VLED65pKv8Y/QZrYwwQjaEfuL92m7jITLqJJCSI9yMORwo4jc9
 zkDhWbcsnSJHldW+trNpKL2lqDXJBxpLfv1OnyER42VWhSPHVglYnSl/e
 RWmOq54RzGRmtoxE7PiKqmNaib9NKchpBgo55DHTMat0SGjI43ssHGO2d
 ySlIQXRdk35oW6voLbjg/vy2bYQxoIC9dqYHa6hWQ3pOb2L26GGjoEql6
 a7v6bn4q8OTs7feTzfIiUmP2S6KVKiFUgIvwXHFk05ljmBwxlWlLvhbkl Q==;
X-CSE-ConnectionGUID: bA+ArSz4QQ+j1R7DFUyAZw==
X-CSE-MsgGUID: gDuHpLA6Tli8BfpkmZ64pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466649"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:06:48 -0700
X-CSE-ConnectionGUID: hR7dCHsQSM6ShvN2uk7M5A==
X-CSE-MsgGUID: XFSPibD4Qhuuu5QY8k+VvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156670000"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:06:44 -0700
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
Subject: [PATCH 06/16] i386/cpu: Drop CPUID 0x2 specific cache info in
 X86CPUState
Date: Fri, 20 Jun 2025 17:27:24 +0800
Message-Id: <20250620092734.1576677-7-zhao1.liu@intel.com>
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

With the pre-defined cache model legacy_intel_cpuid2_cache_info,
for X86CPUState there's no need to cache special cache information
for CPUID 0x2 leaf.

Drop the cache_info_cpuid2 field of X86CPUState and use the
legacy_intel_cpuid2_cache_info directly.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 31 +++++++++++--------------------
 target/i386/cpu.h |  3 ++-
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a06aa1d629dc..8f174fb971b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -244,19 +244,27 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache, bool *unmacthed)
     return CACHE_DESCRIPTOR_UNAVAILABLE;
 }
 
+static const CPUCaches legacy_intel_cpuid2_cache_info;
+
 /* Encode cache info for CPUID[4] */
 static void encode_cache_cpuid2(X86CPU *cpu,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     CPUX86State *env = &cpu->env;
-    CPUCaches *caches = &env->cache_info_cpuid2;
+    const CPUCaches *caches;
     int l1d, l1i, l2, l3;
     bool unmatched = false;
 
     *eax = 1; /* Number of CPUID[EAX=2] calls required */
     *ebx = *ecx = *edx = 0;
 
+    if (env->enable_legacy_cpuid2_cache) {
+        caches = &legacy_intel_cpuid2_cache_info;
+    } else {
+        caches = &env->cache_info_cpuid4;
+    }
+
     l1d = cpuid2_cache_descriptor(caches->l1d_cache, &unmatched);
     l1i = cpuid2_cache_descriptor(caches->l1i_cache, &unmatched);
     l2 = cpuid2_cache_descriptor(caches->l2_cache, &unmatched);
@@ -705,17 +713,6 @@ static CPUCacheInfo legacy_l2_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
-static CPUCacheInfo legacy_l2_cache_cpuid2 = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 2 * MiB,
-    .line_size = 64,
-    .associativity = 8,
-    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
-};
-
-
 /*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
@@ -8951,18 +8948,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        "CPU model '%s' doesn't support legacy-cache=off", name);
             return;
         }
-        env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
-            *cache_info;
+        env->cache_info_cpuid4 = env->cache_info_amd = *cache_info;
     } else {
         /* Build legacy cache information */
-        env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
         if (!cpu->consistent_cache) {
-            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
-        } else {
-            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
+            env->enable_legacy_cpuid2_cache = true;
         }
-        env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
 
         env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
         env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3c7e59ffb12a..8d3ce8a2b678 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2076,7 +2076,8 @@ typedef struct CPUArchState {
      * on each CPUID leaf will be different, because we keep compatibility
      * with old QEMU versions.
      */
-    CPUCaches cache_info_cpuid2, cache_info_cpuid4, cache_info_amd;
+    CPUCaches cache_info_cpuid4, cache_info_amd;
+    bool enable_legacy_cpuid2_cache;
 
     /* MTRRs */
     uint64_t mtrr_fixed[11];
-- 
2.34.1


