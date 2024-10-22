Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52352D2C551
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3F3k-0005mY-J0; Tue, 22 Oct 2024 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3d-0005cZ-SH; Tue, 22 Oct 2024 09:36:21 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3F3a-0000Ai-JF; Tue, 22 Oct 2024 09:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729604178; x=1761140178;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CXEnu+acIaMUIG1n6iHnGCDN/IL7pMz2PY+de6Mno7g=;
 b=Tw4lXpnFS/EeFrhAspetA61kQCjGV5nR+Wgxv+q/XauU+QLzZ6xv31hu
 7xjYrnjYnIzb7JHlUXjDS1Q8S6pUljdZVUZWfEDeQXzuNQp+o8zNEF3nJ
 tk6Kmt9XszCYSaLMwehgsAAaKh0OzJNoRBRT3YzxeooOgIMPzNkndBocx
 PiRHhe22u41jPDLeRqulbetr4qx5FTGO5LNZQRRgUJKFaNyQt23PPyoXE
 7B5DO1WYb4/kSz7RKv/KsBGgUKXdNpgXW2P7NUd4VtCokzHSL0I4NMTI2
 qowlMLwyDFtky5IlAkz2eQlRgNVGQnfcGKGCWAiPESRK/ZHmaSGjsKtrD A==;
X-CSE-ConnectionGUID: qh0nK6WHTBmw5vVC5ct3bw==
X-CSE-MsgGUID: D2yDTHNpSJaiLisxlHJPNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46603639"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46603639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:36:16 -0700
X-CSE-ConnectionGUID: oNl6Bm++SPm6iZAJ/n88cA==
X-CSE-MsgGUID: g2AJMVwtSWCxNJn9BzLwHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79782271"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 22 Oct 2024 06:36:10 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v4 2/9] hw/core: Make CPU topology enumeration arch-agnostic
Date: Tue, 22 Oct 2024 21:51:44 +0800
Message-Id: <20241022135151.2052198-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022135151.2052198-1-zhao1.liu@intel.com>
References: <20241022135151.2052198-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

Cache topology needs to be defined based on CPU topology levels. Thus,
define CPU topology enumeration in qapi/machine.json to make it generic
for all architectures.

To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
socket.

Also, enumerate additional topology levels for non-i386 arches, and add
a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
with compatibility requirement of arch-specific cache topology models.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since Patch v3:
 * Dropped "invalid" level to avoid an unsettable option. (Daniel)
---
 hw/i386/x86-common.c       |   4 +-
 include/hw/i386/topology.h |  23 ++----
 qapi/machine-common.json   |  44 +++++++++++-
 target/i386/cpu.c          | 144 ++++++++++++++++++-------------------
 target/i386/cpu.h          |   4 +-
 5 files changed, 123 insertions(+), 96 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b86c38212eab..bc360a9ea44b 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -273,12 +273,12 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     if (ms->smp.modules > 1) {
         env->nr_modules = ms->smp.modules;
-        set_bit(CPU_TOPO_LEVEL_MODULE, env->avail_cpu_topo);
+        set_bit(CPU_TOPOLOGY_LEVEL_MODULE, env->avail_cpu_topo);
     }
 
     if (ms->smp.dies > 1) {
         env->nr_dies = ms->smp.dies;
-        set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
+        set_bit(CPU_TOPOLOGY_LEVEL_DIE, env->avail_cpu_topo);
     }
 
     /*
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 48b43edc5a90..b2c8bf2de158 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -39,7 +39,7 @@
  *  CPUID Fn8000_0008_ECX[ApicIdCoreIdSize[3:0]] is set to apicid_core_width().
  */
 
-
+#include "qapi/qapi-types-machine-common.h"
 #include "qemu/bitops.h"
 
 /*
@@ -62,22 +62,7 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
-#define CPU_TOPO_LEVEL_INVALID CPU_TOPO_LEVEL_MAX
-
-/*
- * CPUTopoLevel is the general i386 topology hierarchical representation,
- * ordered by increasing hierarchical relationship.
- * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
- * or AMD (CPUID[0x80000026]).
- */
-enum CPUTopoLevel {
-    CPU_TOPO_LEVEL_SMT,
-    CPU_TOPO_LEVEL_CORE,
-    CPU_TOPO_LEVEL_MODULE,
-    CPU_TOPO_LEVEL_DIE,
-    CPU_TOPO_LEVEL_PACKAGE,
-    CPU_TOPO_LEVEL_MAX,
-};
+#define CPU_TOPOLOGY_LEVEL_INVALID CPU_TOPOLOGY_LEVEL__MAX
 
 /* Return the bit width needed for 'count' IDs */
 static unsigned apicid_bitwidth_for_count(unsigned count)
@@ -213,8 +198,8 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
  */
 static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
 {
-    return test_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap) ||
-           test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+    return test_bit(CPU_TOPOLOGY_LEVEL_MODULE, topo_bitmap) ||
+           test_bit(CPU_TOPOLOGY_LEVEL_DIE, topo_bitmap);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index b64e4895cfd7..1a5687fb99fc 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Machines S390 data types
+# = Common machine types
 ##
 
 ##
@@ -18,3 +18,45 @@
 ##
 { 'enum': 'S390CpuEntitlement',
   'data': [ 'auto', 'low', 'medium', 'high' ] }
+
+##
+# @CpuTopologyLevel:
+#
+# An enumeration of CPU topology levels.
+#
+# @thread: thread level, which would also be called SMT level or
+#     logical processor level.  The @threads option in
+#     SMPConfiguration is used to configure the topology of this
+#     level.
+#
+# @core: core level.  The @cores option in SMPConfiguration is used
+#     to configure the topology of this level.
+#
+# @module: module level.  The @modules option in SMPConfiguration is
+#     used to configure the topology of this level.
+#
+# @cluster: cluster level.  The @clusters option in SMPConfiguration
+#     is used to configure the topology of this level.
+#
+# @die: die level.  The @dies option in SMPConfiguration is used to
+#     configure the topology of this level.
+#
+# @socket: socket level, which would also be called package level.
+#     The @sockets option in SMPConfiguration is used to configure
+#     the topology of this level.
+#
+# @book: book level.  The @books option in SMPConfiguration is used
+#     to configure the topology of this level.
+#
+# @drawer: drawer level.  The @drawers option in SMPConfiguration is
+#     used to configure the topology of this level.
+#
+# @default: default level.  Some architectures will have default
+#     topology settings (e.g., cache topology), and this special
+#     level means following the architecture-specific settings.
+#
+# Since: 9.2
+##
+{ 'enum': 'CpuTopologyLevel',
+  'data': [ 'thread', 'core', 'module', 'cluster', 'die',
+            'socket', 'book', 'drawer', 'default' ] }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 638de9c29c4c..f1cbcaf9f4ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -235,23 +235,23 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
                        0 /* Invalid value */)
 
 static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
-                                         enum CPUTopoLevel share_level)
+                                         enum CpuTopologyLevel share_level)
 {
     uint32_t num_ids = 0;
 
     switch (share_level) {
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         num_ids = 1 << apicid_core_offset(topo_info);
         break;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         num_ids = 1 << apicid_die_offset(topo_info);
         break;
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         num_ids = 1 << apicid_pkg_offset(topo_info);
         break;
     default:
         /*
-         * Currently there is no use case for SMT and MODULE, so use
+         * Currently there is no use case for THREAD and MODULE, so use
          * assert directly to facilitate debugging.
          */
         g_assert_not_reached();
@@ -300,19 +300,19 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
 }
 
 static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
-                                          enum CPUTopoLevel topo_level)
+                                          enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return 1;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return topo_info->threads_per_core;
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return topo_info->threads_per_core * topo_info->cores_per_module;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die * topo_info->dies_per_pkg;
     default:
@@ -322,18 +322,18 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
 }
 
 static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
-                                            enum CPUTopoLevel topo_level)
+                                            enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return 0;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return apicid_core_offset(topo_info);
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return apicid_module_offset(topo_info);
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return apicid_die_offset(topo_info);
-    case CPU_TOPO_LEVEL_PACKAGE:
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
         return apicid_pkg_offset(topo_info);
     default:
         g_assert_not_reached();
@@ -341,18 +341,18 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
     return 0;
 }
 
-static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
+static uint32_t cpuid1f_topo_type(enum CpuTopologyLevel topo_level)
 {
     switch (topo_level) {
-    case CPU_TOPO_LEVEL_INVALID:
+    case CPU_TOPOLOGY_LEVEL_INVALID:
         return CPUID_1F_ECX_TOPO_LEVEL_INVALID;
-    case CPU_TOPO_LEVEL_SMT:
+    case CPU_TOPOLOGY_LEVEL_THREAD:
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
-    case CPU_TOPO_LEVEL_CORE:
+    case CPU_TOPOLOGY_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
-    case CPU_TOPO_LEVEL_MODULE:
+    case CPU_TOPOLOGY_LEVEL_MODULE:
         return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
-    case CPU_TOPO_LEVEL_DIE:
+    case CPU_TOPOLOGY_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
         /* Other types are not supported in QEMU. */
@@ -370,17 +370,17 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
     unsigned long level, base_level, next_level;
     uint32_t num_threads_next_level, offset_next_level;
 
-    assert(count <= CPU_TOPO_LEVEL_PACKAGE);
+    assert(count <= CPU_TOPOLOGY_LEVEL_SOCKET);
 
     /*
      * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
-     * The search starts from bit 0 (CPU_TOPO_LEVEL_SMT).
+     * The search starts from bit 0 (CPU_TOPOLOGY_LEVEL_THREAD).
      */
-    level = CPU_TOPO_LEVEL_SMT;
+    level = CPU_TOPOLOGY_LEVEL_THREAD;
     base_level = level;
     for (int i = 0; i <= count; i++) {
         level = find_next_bit(env->avail_cpu_topo,
-                              CPU_TOPO_LEVEL_PACKAGE,
+                              CPU_TOPOLOGY_LEVEL_SOCKET,
                               base_level);
 
         /*
@@ -388,20 +388,20 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
          * and it just encodes the invalid level (all fields are 0)
          * into the last subleaf of 0x1f.
          */
-        if (level == CPU_TOPO_LEVEL_PACKAGE) {
-            level = CPU_TOPO_LEVEL_INVALID;
+        if (level == CPU_TOPOLOGY_LEVEL_SOCKET) {
+            level = CPU_TOPOLOGY_LEVEL_INVALID;
             break;
         }
         /* Search the next level. */
         base_level = level + 1;
     }
 
-    if (level == CPU_TOPO_LEVEL_INVALID) {
+    if (level == CPU_TOPOLOGY_LEVEL_INVALID) {
         num_threads_next_level = 0;
         offset_next_level = 0;
     } else {
         next_level = find_next_bit(env->avail_cpu_topo,
-                                   CPU_TOPO_LEVEL_PACKAGE,
+                                   CPU_TOPOLOGY_LEVEL_SOCKET,
                                    level + 1);
         num_threads_next_level = num_threads_by_topo_level(topo_info,
                                                            next_level);
@@ -577,7 +577,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -592,7 +592,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -606,7 +606,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -621,7 +621,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -635,7 +635,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -645,7 +645,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
-    .share_level = CPU_TOPO_LEVEL_INVALID,
+    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
 };
 
 
@@ -659,7 +659,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -675,7 +675,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
-    .share_level = CPU_TOPO_LEVEL_DIE,
+    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -2026,7 +2026,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2039,7 +2039,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2050,7 +2050,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2064,7 +2064,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2080,7 +2080,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2093,7 +2093,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2104,7 +2104,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2118,7 +2118,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2134,7 +2134,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2147,7 +2147,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2158,7 +2158,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2172,7 +2172,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2188,7 +2188,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2201,7 +2201,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2212,7 +2212,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2226,7 +2226,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2242,7 +2242,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2255,7 +2255,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2266,7 +2266,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2280,7 +2280,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2296,7 +2296,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2309,7 +2309,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2320,7 +2320,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2334,7 +2334,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2350,7 +2350,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2363,7 +2363,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2374,7 +2374,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2388,7 +2388,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -6512,7 +6512,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
                     /* Share the cache at package level. */
                     *eax |= max_thread_ids_for_cache(&topo_info,
-                                CPU_TOPO_LEVEL_PACKAGE) << 14;
+                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
@@ -7998,10 +7998,10 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
     env->nr_modules = 1;
     env->nr_dies = 1;
 
-    /* SMT, core and package levels are set by default. */
-    set_bit(CPU_TOPO_LEVEL_SMT, env->avail_cpu_topo);
-    set_bit(CPU_TOPO_LEVEL_CORE, env->avail_cpu_topo);
-    set_bit(CPU_TOPO_LEVEL_PACKAGE, env->avail_cpu_topo);
+    /* thread, core and socket levels are set by default. */
+    set_bit(CPU_TOPOLOGY_LEVEL_THREAD, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_CORE, env->avail_cpu_topo);
+    set_bit(CPU_TOPOLOGY_LEVEL_SOCKET, env->avail_cpu_topo);
 }
 
 static void x86_cpu_initfn(Object *obj)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580f4..abb75019ca61 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1666,7 +1666,7 @@ typedef struct CPUCacheInfo {
      * Used to encode CPUID[4].EAX[bits 25:14] or
      * CPUID[0x8000001D].EAX[bits 25:14].
      */
-    enum CPUTopoLevel share_level;
+    CpuTopologyLevel share_level;
 } CPUCacheInfo;
 
 
@@ -1999,7 +1999,7 @@ typedef struct CPUArchState {
     unsigned nr_modules;
 
     /* Bitmap of available CPU topology levels for this CPU. */
-    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
 } CPUX86State;
 
 struct kvm_msrs;
-- 
2.34.1


