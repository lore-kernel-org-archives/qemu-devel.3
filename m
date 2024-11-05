Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F34FD3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLU-0005pW-55; Tue, 05 Nov 2024 17:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLS-0005f6-1H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLO-0004CQ-E1
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so49040405e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846892; x=1731451692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fC2meymonsPAl4AmZymD/ZwCthjmuT2Cvq7jZhN+fuo=;
 b=T1n0ri6OyNl+0up80xlxu1QKg6ba2sMYXvifg9WW9o2dBnuM6Y9K4prGQycXX4epH6
 5KtkO34q6tAQA66TfcpWyf8yWviLIcoUzqX1eweVVZ78xnPdiyqvt7EcCb0cZ7qFRQbA
 4tRUlmF/pRdjem3ELQpO8xSmgyPdKiz4fPwigtraBlR/EZXh/5H47AzASDu1SDmIykWC
 cXtU9839+5Reou1+4T8agYkd9db77gl4FloBwHDowwGUydvjw/sfMqrgDQ8FgW0yb7gv
 vL/EsOpbGs2Q5BG7KYEfYlyDa7Z70R1mRcykYXWG7koUCKMQgeZTr852IADXoxWFoICt
 8xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846892; x=1731451692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fC2meymonsPAl4AmZymD/ZwCthjmuT2Cvq7jZhN+fuo=;
 b=cpeuuZQa+6gCGK7pBnzKj38NPRY63pXJYosBt+9PEE/5UWjh6tRvwlISNgm2A9elIy
 1kjqr7S8nt+xhuvLxWdTH0OVbiN1tuzbMdemg7ck0/W/Ir5Cn0zvF6UVUxcWmLa1Ztov
 j/3FgCo8BXw5cu4Q5ape9afG19migaBYFMfVZqaye3IxY481W/bAQd9eWJ3I18AktuQC
 NxbmwE65SGrX6mRc+r7pfR84jnHYzi6yOxYwy3baRUI5oK2VQwdv4HohK1FRPBk0vfHA
 ua3yp1lX1nCa+Ar+1z9Z1ljR1Bz/o+w4eo/XTXwq3EvW5V52wj+HExuxNEeJJgLJp94w
 8PsQ==
X-Gm-Message-State: AOJu0YwHL1EeKaX3G1n62R56mRscWmaCSAooOwH9JR2tw+eWud4x0svN
 FVTeHYsxzpdCariO5TjcN2pk3iPyPfULkm82N7Em1AAhEKcAxWWROIxXPGBmiYAEyULgC+DEe9M
 NW9uOPA==
X-Google-Smtp-Source: AGHT+IFOyYBEeBAPb+nVpFbOUDcVqJbFf8kIcwuI/liIZltdBiDhPzRP4MApU+J9RF/7iJ1a4CRNYA==
X-Received: by 2002:a05:600c:1911:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-4319acb2a0bmr333425765e9.19.1730846892396; 
 Tue, 05 Nov 2024 14:48:12 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fc9sm1100265e9.3.2024.11.05.14.48.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/29] hw/core: Make CPU topology enumeration arch-agnostic
Date: Tue,  5 Nov 2024 22:47:06 +0000
Message-ID: <20241105224727.53059-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

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
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241101083331.340178-3-zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine-common.json   |  44 +++++++++++-
 include/hw/i386/topology.h |  23 ++----
 target/i386/cpu.h          |   4 +-
 hw/i386/x86-common.c       |   4 +-
 target/i386/cpu.c          | 144 ++++++++++++++++++-------------------
 5 files changed, 123 insertions(+), 96 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index b64e4895cfd..1a5687fb99f 100644
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
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 48b43edc5a9..b2c8bf2de15 100644
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 59959b8b7a4..00b23bc5d1f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1716,7 +1716,7 @@ typedef struct CPUCacheInfo {
      * Used to encode CPUID[4].EAX[bits 25:14] or
      * CPUID[0x8000001D].EAX[bits 25:14].
      */
-    enum CPUTopoLevel share_level;
+    CpuTopologyLevel share_level;
 } CPUCacheInfo;
 
 
@@ -2051,7 +2051,7 @@ typedef struct CPUArchState {
     unsigned nr_modules;
 
     /* Bitmap of available CPU topology levels for this CPU. */
-    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPOLOGY_LEVEL__MAX);
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b86c38212ea..bc360a9ea44 100644
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ca13cf66a78..d46710a4030 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -238,23 +238,23 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
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
@@ -303,19 +303,19 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
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
@@ -325,18 +325,18 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
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
@@ -344,18 +344,18 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
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
@@ -373,17 +373,17 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
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
@@ -391,20 +391,20 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
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
@@ -580,7 +580,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -595,7 +595,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -609,7 +609,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -624,7 +624,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -638,7 +638,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -648,7 +648,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
-    .share_level = CPU_TOPO_LEVEL_INVALID,
+    .share_level = CPU_TOPOLOGY_LEVEL_INVALID,
 };
 
 
@@ -662,7 +662,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
-    .share_level = CPU_TOPO_LEVEL_CORE,
+    .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -678,7 +678,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
-    .share_level = CPU_TOPO_LEVEL_DIE,
+    .share_level = CPU_TOPOLOGY_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -2085,7 +2085,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2098,7 +2098,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2109,7 +2109,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2123,7 +2123,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2139,7 +2139,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2152,7 +2152,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2163,7 +2163,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2177,7 +2177,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2193,7 +2193,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2206,7 +2206,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2217,7 +2217,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2231,7 +2231,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2247,7 +2247,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2260,7 +2260,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2271,7 +2271,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2285,7 +2285,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2301,7 +2301,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2314,7 +2314,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2325,7 +2325,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2339,7 +2339,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2355,7 +2355,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2368,7 +2368,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2379,7 +2379,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2393,7 +2393,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -2409,7 +2409,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2422,7 +2422,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2433,7 +2433,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
-        .share_level = CPU_TOPO_LEVEL_CORE,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2447,7 +2447,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
-        .share_level = CPU_TOPO_LEVEL_DIE,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
 
@@ -6591,7 +6591,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
                     /* Share the cache at package level. */
                     *eax |= max_thread_ids_for_cache(&topo_info,
-                                CPU_TOPO_LEVEL_PACKAGE) << 14;
+                                CPU_TOPOLOGY_LEVEL_SOCKET) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
@@ -8169,10 +8169,10 @@ static void x86_cpu_init_default_topo(X86CPU *cpu)
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
-- 
2.45.2


