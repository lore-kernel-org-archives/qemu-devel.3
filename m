Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D63C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Ph-0004aZ-OO; Wed, 31 Jan 2024 05:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7PM-0004Px-MF
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:30 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rV7PH-0008Lk-Jd
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706695283; x=1738231283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dqVAp/mlK/ZWsBxRXuBhw678ydijj1fK6M7bq7JhVtE=;
 b=IblzPJJZ1Ru8OeXzTDk7k7UIApG2Qzlmv7K5B4kSYx7lFdi3gjXekuI1
 sMbAaKTg16ZJ4d7owSad7kBGBNJn7B8aeI+RdhuJN488Y2wt3TQd+DYlR
 iIg/3xzFXD38DXVM6kopQvfz6An6NKPklxj3oJYNKwBzhwCcO0q9m+9t3
 I+2YOTRr1sLSOaslVrLsMx4lVUbKpvY8CWSE83GpcKZ6RgNsBcNO0FnWw
 12N3gCiFtA7xPCkb8FL0MAOywj+ZCG3uNhA1TBYaAloHIkAT7wfCzp9O5
 B6Bj/jcxJI3glax1IbJqbi2TCLssu57hfryZ3YvLjmJw8WnGEVJuE/8vo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25032812"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="25032812"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 02:01:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4036057"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Jan 2024 02:01:17 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v8 09/21] i386/cpu: Introduce bitmap to cache available CPU
 topology levels
Date: Wed, 31 Jan 2024 18:13:38 +0800
Message-Id: <20240131101350.109512-10-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, QEMU checks the specify number of topology domains to detect
if there's extended topology levels (e.g., checking nr_dies).

With this bitmap, the extended CPU topology (the levels other than SMT,
core and package) could be easier to detect without touching the
topology details.

This is also in preparation for the follow-up to decouple CPUID[0x1F]
subleaf with specific topology level.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v7:
 * New commit to response Xiaoyao's suggestion about the gloabl variable
   to cache topology levels. (Xiaoyao)
---
 hw/i386/x86.c              |  5 ++++-
 include/hw/i386/topology.h | 23 +++++++++++++++++++++++
 target/i386/cpu.c          | 18 +++++++++++++++---
 target/i386/cpu.h          |  4 ++++
 target/i386/kvm/kvm.c      |  3 ++-
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d5f..5a42e3757099 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -309,7 +309,10 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     init_topo_info(&topo_info, x86ms);
 
-    env->nr_dies = ms->smp.dies;
+    if (ms->smp.dies > 1) {
+        env->nr_dies = ms->smp.dies;
+        set_bit(CPU_TOPO_LEVEL_DIE, env->avail_cpu_topo);
+    }
 
     /*
      * If APIC ID is not set,
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index d4eeb7ab8290..befeb92b0b19 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -60,6 +60,21 @@ typedef struct X86CPUTopoInfo {
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
+/*
+ * CPUTopoLevel is the general i386 topology hierarchical representation,
+ * ordered by increasing hierarchical relationship.
+ * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
+ * or AMD (CPUID[0x80000026]).
+ */
+enum CPUTopoLevel {
+    CPU_TOPO_LEVEL_INVALID,
+    CPU_TOPO_LEVEL_SMT,
+    CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_DIE,
+    CPU_TOPO_LEVEL_PACKAGE,
+    CPU_TOPO_LEVEL_MAX,
+};
+
 /* Return the bit width needed for 'count' IDs */
 static unsigned apicid_bitwidth_for_count(unsigned count)
 {
@@ -168,4 +183,12 @@ static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
     return x86_apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
+/*
+ * Check whether there's extended topology level (die)?
+ */
+static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
+{
+    return test_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
+}
+
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b32833f65dd6..607d8eff017b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6281,7 +6281,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (topo_info.dies_per_pkg < 2) {
+        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
@@ -7107,7 +7107,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
          * cpu->vendor_cpuid_only has been unset for compatibility with older
          * machine types.
          */
-        if ((env->nr_dies > 1) &&
+        if (x86_has_extended_topo(env->avail_cpu_topo) &&
             (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
         }
@@ -7608,13 +7608,25 @@ static void x86_cpu_post_initfn(Object *obj)
     accel_cpu_instance_init(CPU(obj));
 }
 
+static void x86_cpu_init_default_topo(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    env->nr_dies = 1;
+
+    /* SMT, core and package levels are set by default. */
+    set_bit(CPU_TOPO_LEVEL_SMT, env->avail_cpu_topo);
+    set_bit(CPU_TOPO_LEVEL_CORE, env->avail_cpu_topo);
+    set_bit(CPU_TOPO_LEVEL_PACKAGE, env->avail_cpu_topo);
+}
+
 static void x86_cpu_initfn(Object *obj)
 {
     X86CPU *cpu = X86_CPU(obj);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(obj);
     CPUX86State *env = &cpu->env;
 
-    env->nr_dies = 1;
+    x86_cpu_init_default_topo(cpu);
 
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7f0786e8b98f..f341affd5a59 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
+#include "hw/i386/topology.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/cpu-float.h"
 #include "qemu/timer.h"
@@ -1885,6 +1886,9 @@ typedef struct CPUArchState {
 
     /* Number of dies within this CPU package. */
     unsigned nr_dies;
+
+    /* Bitmap of available CPU topology levels for this CPU. */
+    DECLARE_BITMAP(avail_cpu_topo, CPU_TOPO_LEVEL_MAX);
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 76a66246eb72..25d438e0b586 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -50,6 +50,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/i386/topology.h"
 #include "hw/i386/x86-iommu.h"
 #include "hw/i386/e820_memory_layout.h"
 
@@ -1913,7 +1914,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             break;
         }
         case 0x1f:
-            if (env->nr_dies < 2) {
+            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
                 break;
             }
             /* fallthrough */
-- 
2.34.1


