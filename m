Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41C6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 15:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzegs-0007ny-Ge; Wed, 24 Apr 2024 11:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzegq-0007cF-MZ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:44 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzego-0005hB-8P
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 11:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713973062; x=1745509062;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ahHhtcUEN153MtV29xLy7++pZm8UAiFhzdkoG2N6yQI=;
 b=H5M+2V9LuDdsy5gtDx20RT2uBZ1M5DxpeBKUC6WWKcHvwbCDksG0espA
 fEWok5AWdr4MDvztB86rUJZMVi/SepckpzqHrVECASlocbnTI9Vuztt0G
 nohvS5NWTkE32gYvloy3+YJ/V8nMvkm/rX6WfXJXs3U6BzEv5FB7tiMPq
 ZZ88I3d8v1iX30KvJP/7YxAmyDyJdPcUmziU9FbAWaCL6PCWjtWYYbggM
 T8u0+HUqWktMUIYDMwz/W4ZBRCt8OhdfsyI5QRcZvdEskdt6LC4XMROcv
 a1s46WIBgi9hzWb7UaeuL8ybO9GmwSdTZlX5zeSdIhvMkLwiaDHhLJ1RA Q==;
X-CSE-ConnectionGUID: x6Vmo/TZSGW7tXkRXF8tmQ==
X-CSE-MsgGUID: hYt/ijtsSauEZw2u/8ltJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="12545837"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="12545837"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 08:37:30 -0700
X-CSE-ConnectionGUID: 2+aiATJJT9qxAnkeE1ZOPw==
X-CSE-MsgGUID: 6MVvuF1VR6KQHN9q5c7doQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; d="scan'208";a="25363344"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 24 Apr 2024 08:37:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v11 19/21] i386: Add cache topology info in CPUCacheInfo
Date: Wed, 24 Apr 2024 23:49:27 +0800
Message-Id: <20240424154929.1487382-20-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424154929.1487382-1-zhao1.liu@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Currently, by default, the cache topology is encoded as:
1. i/d cache is shared in one core.
2. L2 cache is shared in one core.
3. L3 cache is shared in one die.

This default general setting has caused a misunderstanding, that is, the
cache topology is completely equated with a specific cpu topology, such
as the connection between L2 cache and core level, and the connection
between L3 cache and die level.

In fact, the settings of these topologies depend on the specific
platform and are not static. For example, on Alder Lake-P, every
four Atom cores share the same L2 cache.

Thus, we should explicitly define the corresponding cache topology for
different cache models to increase scalability.

Except legacy_l2_cache_cpuid2 (its default topo level is
CPU_TOPO_LEVEL_UNKNOW), explicitly set the corresponding topology level
for all other cache models. In order to be compatible with the existing
cache topology, set the CPU_TOPO_LEVEL_CORE level for the i/d cache, set
the CPU_TOPO_LEVEL_CORE level for L2 cache, and set the
CPU_TOPO_LEVEL_DIE level for L3 cache.

The field for CPUID[4].EAX[bits 25:14] or CPUID[0x8000001D].EAX[bits
25:14] will be set based on CPUCacheInfo.share_level.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * Fixed cache topology uninitialization bugs for some AMD CPUs. (Babu)
 * Moved the CPUTopoLevel enumeration definition to the previous 0x1f
   rework patch.

Changes since v1:
 * Added the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
   (Yanan)
 * (Revert, pls refer "i386: Decouple CPUID[0x1F] subleaf with specific
   topology level") Renamed the "INVALID" level to CPU_TOPO_LEVEL_UNKNOW.
   (Yanan)
---
 target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 76085ec007fa..5ba44c57666d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -551,6 +551,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -565,6 +566,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -578,6 +580,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -592,6 +595,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -605,6 +609,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -614,6 +619,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
+    .share_level = CPU_TOPO_LEVEL_INVALID,
 };
 
 
@@ -627,6 +633,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -642,6 +649,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
+    .share_level = CPU_TOPO_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -1940,6 +1948,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1952,6 +1961,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1962,6 +1972,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1975,6 +1986,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -1990,6 +2002,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2002,6 +2015,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2012,6 +2026,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2025,6 +2040,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2040,6 +2056,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2052,6 +2069,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2062,6 +2080,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2075,6 +2094,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2090,6 +2110,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2102,6 +2123,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2112,6 +2134,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2125,6 +2148,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2140,6 +2164,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2152,6 +2177,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2162,6 +2188,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2175,6 +2202,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2190,6 +2218,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2202,6 +2231,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2212,6 +2242,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2225,6 +2256,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2240,6 +2272,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2252,6 +2285,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2262,6 +2296,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2275,6 +2310,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 042eec417d0f..a28ba33365b4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1590,6 +1590,13 @@ typedef struct CPUCacheInfo {
      * address bits.  CPUID[4].EDX[bit 2].
      */
     bool complex_indexing;
+
+    /*
+     * Cache Topology. The level that cache is shared in.
+     * Used to encode CPUID[4].EAX[bits 25:14] or
+     * CPUID[0x8000001D].EAX[bits 25:14].
+     */
+    enum CPUTopoLevel share_level;
 } CPUCacheInfo;
 
 
-- 
2.34.1


