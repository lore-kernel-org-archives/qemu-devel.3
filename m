Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFD8C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZX-0003eL-GT; Fri, 11 Jul 2025 06:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZC-00037Z-EO
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:18 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAZA-0005KY-9w
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228076; x=1783764076;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2YgiqgBwgQ2xRniG9fxBQVr1kcJH4e6UNHL2Y40Boa4=;
 b=V689nWexp4fzUl7GTaGIn2Eheuac/UW2C220lVPW7b1I+fBkDodlABi1
 Zb5vUhZtLcOSKILV2fUj3RSINnz+xXo6yYr4/ZysvXloaFHyil9xm4F49
 x5Tn4R5mezefYKhf23DU6kJ8cZFTlCchQJoZvV9YfxEoyZcY3Ve0Cgynt
 r62/ILaxYeEeZqfNJWsgR6pry1Q9i17rNyWSonGQNR9BxkVRIIIiPNX40
 2Ko4p/rCs9gJp1CYWzZGX2pQKu0pBD2EWGIOb09H8eeUFqLPmFHXrtBGs
 anBbHos45rz6TbaIxk1UPd6ecKJn7nRLpLrMYwvhWUsRxd0+Isd110F/d A==;
X-CSE-ConnectionGUID: u3lGWztHSqKqgRu3STLDRA==
X-CSE-MsgGUID: 6zGMIw2mRUOxASYHJkGOWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496359"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:01:15 -0700
X-CSE-ConnectionGUID: EY0bXHd+ToO+CXcvqFBxmg==
X-CSE-MsgGUID: /HPSHUnrRP+Axi4IeiDikw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662089"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:01:10 -0700
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
Subject: [PATCH v2 11/18] i386/cpu: Add legacy_intel_cache_info cache model
Date: Fri, 11 Jul 2025 18:21:36 +0800
Message-Id: <20250711102143.1622339-12-zhao1.liu@intel.com>
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

Based on legacy_l1d_cache, legacy_l1i_cache, legacy_l2_cache and
legacy_l3_cache, build a complete legacy intel cache model, which can
clarify the purpose of these trivial legacy cache models, simplify the
initialization of cache info in X86CPUState, and make it easier to
handle compatibility later.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 101 +++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 47 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 609efb10ddb5..6cd942f95779 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -638,21 +638,6 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
  */
-
-/* L1 data cache: */
-static CPUCacheInfo legacy_l1d_cache = {
-    .type = DATA_CACHE,
-    .level = 1,
-    .size = 32 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 8,
-    .sets = 64,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l1d_cache_amd = {
     .type = DATA_CACHE,
     .level = 1,
@@ -667,20 +652,6 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/* L1 instruction cache: */
-static CPUCacheInfo legacy_l1i_cache = {
-    .type = INSTRUCTION_CACHE,
-    .level = 1,
-    .size = 32 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 8,
-    .sets = 64,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l1i_cache_amd = {
     .type = INSTRUCTION_CACHE,
     .level = 1,
@@ -695,20 +666,6 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/* Level 2 unified cache: */
-static CPUCacheInfo legacy_l2_cache = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 4 * MiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 16,
-    .sets = 4096,
-    .partitions = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
@@ -798,6 +755,59 @@ static const CPUCaches legacy_intel_cpuid2_cache_info = {
     },
 };
 
+static const CPUCaches legacy_intel_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 64,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 4 * MiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 16,
+        .sets = 4096,
+        .partitions = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 16 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .sets = 16384,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* TLB definitions: */
 
 #define L1_DTLB_2M_ASSOC       1
@@ -8980,10 +8990,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             env->enable_legacy_cpuid2_cache = true;
         }
 
-        env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
-        env->cache_info_cpuid4.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid4.l2_cache = &legacy_l2_cache;
-        env->cache_info_cpuid4.l3_cache = &legacy_l3_cache;
+        env->cache_info_cpuid4 = legacy_intel_cache_info;
 
         env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
         env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
-- 
2.34.1


