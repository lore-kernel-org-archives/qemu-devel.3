Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD58CDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69t-00088Q-CO; Wed, 18 Sep 2024 21:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69r-00081X-M3; Wed, 18 Sep 2024 21:40:35 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69p-0004sM-EQ; Wed, 18 Sep 2024 21:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710033; x=1758246033;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GsWICJ5+g1+q1v0KglBy1lWu3UY61FHqayyy9q2Rqsk=;
 b=jAyV+GElpZchTCz5wRtKmy0OsD6ubtEHOR0nP0GcrejOhlUHCC/OUfM0
 CZg/cST3+j6OdHF1YrXUVKuy+j/vE9N+G/BExbyxK9fisknKYGP1q6vAW
 z70BVpyR6jUyqMXdWBZR/gVZ5i0PzWdoo9QMbEKpLiKKRq4OicbxvQMYn
 oNwXnSlO7enMB6VLNccMmYPc0Lk0Jc11MzRBluxgBmN7ZoMRsw6kl1/P4
 26QkN4CJUDPvZmj0wwrxFVZztyAM93VwDPl4JbxclWuiF6VtDJLVxLnvW
 quNxjU66fW9RgajXxB4Q2jCbRP69o5TqnGDKghjJCbeSgxaGy7WYo/CNk w==;
X-CSE-ConnectionGUID: EHJo3F9DRB6yibNL+QNGvA==
X-CSE-MsgGUID: xpjv6+AaQ3e7g9UD1fuOWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797904"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797904"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:32 -0700
X-CSE-ConnectionGUID: BVbtC0uyT5+cD6+BxlQqYA==
X-CSE-MsgGUID: ZRQq89eASbGRoUgWB8SFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058791"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:25 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 07/15] hw/core/cpu: Convert CPU from general device to
 topology device
Date: Thu, 19 Sep 2024 09:55:25 +0800
Message-Id: <20240919015533.766754-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919015533.766754-1-zhao1.liu@intel.com>
References: <20240919015533.766754-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Convert CPU to topology device then it can be added into topology tree.

Because CPU then inherits properties and settings of topology device,
make the following changes to take into account the special case for CPU:

 * Omit setting category since topology device has already set.

 * Make realize() of topology device as the parent realize().

 * Clean up some cases that assume parent obj is DeviceState and access
   parent_obj directly.

 * Set CPU's topology level as thread.

 * And one complex change: mask bus_type as NULL.

    - This is because for the arches don't support topology tree,
      there's no CPU bus bridge so that CPUs of these arches can't be
      created. So, only the CPU with arch supporting topology tree
      should override the bus_type field.

 * Further, support cpu_create() for the CPU with bus_type.

    - This is a corner case, some arch CPUs may set bus_type, and
      cpu_create() would be called in system emulation case (e.g., none
      machine). To handle such case, try to find the machine's CPU bus
      in cpu_create().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 accel/kvm/kvm-all.c   |  4 ++--
 hw/core/cpu-common.c  | 42 +++++++++++++++++++++++++++++++++++++-----
 include/hw/core/cpu.h |  7 +++++--
 target/ppc/kvm.c      |  2 +-
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index beb1988d12cf..48c040f6861d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4173,7 +4173,7 @@ static void query_stats(StatsResultList **result, StatsTarget target,
         break;
     case STATS_TARGET_VCPU:
         add_stats_entry(result, STATS_PROVIDER_KVM,
-                        cpu->parent_obj.canonical_path,
+                        DEVICE(cpu)->canonical_path,
                         stats_list);
         break;
     default:
@@ -4265,7 +4265,7 @@ static void query_stats_cb(StatsResultList **result, StatsTarget target,
         stats_args.names = names;
         stats_args.errp = errp;
         CPU_FOREACH(cpu) {
-            if (!apply_str_list_filter(cpu->parent_obj.canonical_path, targets)) {
+            if (!apply_str_list_filter(DEVICE(cpu)->canonical_path, targets)) {
                 continue;
             }
             query_stats_vcpu(cpu, &stats_args);
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 7982ecd39a53..08f2d536ff6d 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -57,7 +57,19 @@ CPUState *cpu_create(const char *typename)
 {
     Error *err = NULL;
     CPUState *cpu = CPU(object_new(typename));
-    if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
+    BusState *bus = NULL;
+
+    if (DEVICE_GET_CLASS(cpu)->bus_type) {
+        MachineState *ms;
+
+        ms = (MachineState *)object_dynamic_cast(qdev_get_machine(),
+                                                 TYPE_MACHINE);
+        if (ms) {
+            bus = BUS(&ms->topo->bus);
+        }
+    }
+
+    if (!qdev_realize(DEVICE(cpu), bus, &err)) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
         exit(EXIT_FAILURE);
@@ -196,6 +208,12 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
     Object *machine = qdev_get_machine();
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    cc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
 
     /* qdev_get_machine() can return something that's not TYPE_MACHINE
      * if this is one of the user-only emulators; in that case there's
@@ -302,6 +320,7 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    CPUTopoClass *tc = CPU_TOPO_CLASS(klass);
     CPUClass *k = CPU_CLASS(klass);
 
     k->parse_features = cpu_common_parse_features;
@@ -309,9 +328,6 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
     k->has_work = cpu_common_has_work;
     k->gdb_read_register = cpu_common_gdb_read_register;
     k->gdb_write_register = cpu_common_gdb_write_register;
-    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    dc->realize = cpu_common_realizefn;
-    dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     cpu_class_init_props(dc);
     /*
@@ -319,11 +335,27 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
      * IRQs, adding reset handlers, halting non-first CPUs, ...
      */
     dc->user_creatable = false;
+    /*
+     * CPU is the minimum granularity for hotplug in most case, and
+     * often its hotplug handler is ultimately decided by the machine.
+     * For generality, set this flag to avoid blocking possible hotplug
+     * support.
+     */
+    dc->hotpluggable = true;
+    device_class_set_parent_realize(dc, cpu_common_realizefn,
+                                    &k->parent_realize);
+    dc->unrealize = cpu_common_unrealizefn;
+    /*
+     * Avoid archs that do not support topology device trees from
+     * encountering error when creating CPUs.
+     */
+    dc->bus_type = NULL;
+    tc->level = CPU_TOPOLOGY_LEVEL_THREAD;
 }
 
 static const TypeInfo cpu_type_info = {
     .name = TYPE_CPU,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_CPU_TOPO,
     .instance_size = sizeof(CPUState),
     .instance_init = cpu_common_initfn,
     .instance_finalize = cpu_common_finalize,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1c9c775df658..d7268bcb48cb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -20,6 +20,7 @@
 #ifndef QEMU_CPU_H
 #define QEMU_CPU_H
 
+#include "hw/cpu/cpu-topology.h"
 #include "hw/qdev-core.h"
 #include "disas/dis-asm.h"
 #include "exec/breakpoint.h"
@@ -144,7 +145,7 @@ struct SysemuCPUOps;
  */
 struct CPUClass {
     /*< private >*/
-    DeviceClass parent_class;
+    CPUTopoClass parent_class;
     /*< public >*/
 
     ObjectClass *(*class_by_name)(const char *cpu_model);
@@ -189,6 +190,8 @@ struct CPUClass {
     int reset_dump_flags;
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
+
+    DeviceRealize parent_realize;
 };
 
 /*
@@ -456,7 +459,7 @@ struct qemu_work_item;
  */
 struct CPUState {
     /*< private >*/
-    DeviceState parent_obj;
+    CPUTopoState parent_obj;
     /* cache to avoid expensive CPU_GET_CLASS */
     CPUClass *cc;
     /*< public >*/
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 907dba60d1b5..b3cc42e545af 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2351,7 +2351,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
 static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
 {
     int ret;
-    const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
+    const char *vcpu_str = (DEVICE(cs)->hotplugged == true) ?
                            "hotplug" : "create";
     cs->cpu_index = cpu_get_free_index();
 
-- 
2.34.1


