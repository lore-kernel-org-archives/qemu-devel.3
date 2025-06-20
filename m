Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A6C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 09:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXiR-00025e-9b; Fri, 20 Jun 2025 05:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXiI-0001df-BS
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:07:14 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXiF-0004zi-0p
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410427; x=1781946427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Iw37FKEpWcDr+1BzreJTzrwt1dWMwF0UEcgY0aS63YM=;
 b=QjcqMwFqvFsruCUpGeVALQZOLRBSTGwGQSJiHBw6ukAV97jNO/zpgdIt
 seJZLIEm27gRKBDFOt9osrwmAzJanNJGrcbPhZ0i0mTufZH9XN7VsoaIa
 jDPxhbotRVMDTTmcDIjF8FsohsPNv8a5H3bira6SvDYy6W7B94W3wyQ74
 0/CAiKQXfyqyYN9zIawRk9eWzVa4pSw9hEJ0/25d1ctuSKPxkowOTzinX
 g/7a2RHUHzlKrfqOkcJGveyZJtJvDpvMsHipSH+b4n0SSvNMF/w+4rWd0
 D0CRBYZkABYcD15bxjgKOPCdxO1/lrfA4yopuxkkHAmSrT51dvZheNsto w==;
X-CSE-ConnectionGUID: qBg5+ngcSSKnOXxrBY70Hg==
X-CSE-MsgGUID: UEklFkvvTRylFuZbiknvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466765"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466765"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:07:06 -0700
X-CSE-ConnectionGUID: NYqwPHlIS7OiZW8BfnWllQ==
X-CSE-MsgGUID: bZ66KRLcT2ivsJ8LYBo+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156670116"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:07:02 -0700
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
Subject: [PATCH 10/16] i386/cpu: Add legacy_amd_cache_info cache model
Date: Fri, 20 Jun 2025 17:27:28 +0800
Message-Id: <20250620092734.1576677-11-zhao1.liu@intel.com>
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

Based on legacy_l1d_cachei_amd, legacy_l1i_cache_amd, legacy_l2_cache_amd
and legacy_l3_cache, build a complete legacy AMD cache model, which can
clarify the purpose of these trivial legacy cache models, simplify the
initialization of cache info in X86CPUState, and make it easier to
handle compatibility later.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 112 ++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 59 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec229830c532..bf8d7a19c88d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -643,60 +643,58 @@ static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
  */
-static CPUCacheInfo legacy_l1d_cache_amd = {
-    .type = DATA_CACHE,
-    .level = 1,
-    .size = 64 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 2,
-    .sets = 512,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-static CPUCacheInfo legacy_l1i_cache_amd = {
-    .type = INSTRUCTION_CACHE,
-    .level = 1,
-    .size = 64 * KiB,
-    .self_init = 1,
-    .line_size = 64,
-    .associativity = 2,
-    .sets = 512,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .no_invd_sharing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-static CPUCacheInfo legacy_l2_cache_amd = {
-    .type = UNIFIED_CACHE,
-    .level = 2,
-    .size = 512 * KiB,
-    .line_size = 64,
-    .lines_per_tag = 1,
-    .associativity = 16,
-    .sets = 512,
-    .partitions = 1,
-    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
-};
-
-/* Level 3 unified cache: */
-static CPUCacheInfo legacy_l3_cache = {
-    .type = UNIFIED_CACHE,
-    .level = 3,
-    .size = 16 * MiB,
-    .line_size = 64,
-    .associativity = 16,
-    .sets = 16384,
-    .partitions = 1,
-    .lines_per_tag = 1,
-    .self_init = true,
-    .inclusive = true,
-    .complex_indexing = true,
-    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+static const CPUCaches legacy_amd_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 2,
+        .sets = 512,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .self_init = 1,
+        .line_size = 64,
+        .associativity = 2,
+        .sets = 512,
+        .partitions = 1,
+        .lines_per_tag = 1,
+        .no_invd_sharing = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .lines_per_tag = 1,
+        .associativity = 16,
+        .sets = 512,
+        .partitions = 1,
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
 };
 
 /*
@@ -8982,11 +8980,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
 
         env->cache_info_cpuid4 = legacy_intel_cache_info;
-
-        env->cache_info_amd.l1d_cache = &legacy_l1d_cache_amd;
-        env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
-        env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
-        env->cache_info_amd.l3_cache = &legacy_l3_cache;
+        env->cache_info_amd = legacy_amd_cache_info;
     }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


