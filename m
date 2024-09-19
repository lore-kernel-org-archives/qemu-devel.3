Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C060ACDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69m-0007ct-6g; Wed, 18 Sep 2024 21:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69k-0007W2-IV; Wed, 18 Sep 2024 21:40:28 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69i-0004sM-MC; Wed, 18 Sep 2024 21:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710027; x=1758246027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+kEYgTEqzxM7Ze52eMLk4clqkl8mXjIJEkgs/jlv98A=;
 b=aoTvQuqzlGB+gLshVG9VdheVjivcHitEXumqlF2YakQH72/y8WniVm2t
 mDci4wZSHyi2IVtF7ds7jHvuJDh4syLTAkNF9Y2YKJdMFp6z2mNmmWl6B
 0QNoCHS7acnQ14trSsqXFSirzjPTETIUgtjKpQvEVI7W8OeuYGozWbr8t
 MJmDS/dY4da860Q6jHGUbpW6SlK/k6AtFwxoYZJVRgKcxpsbFaNBuFXQg
 KoyPGDb9lazO5+P4J4DBLwnl5o/cID5wyhzOtLj0SvQjJZHApJLKSiO29
 jlZ2COEw3Xwvbne3ruZf8ZNJIOTCdFYfEma2zsjfLq4WsAW55vEHzoVV9 A==;
X-CSE-ConnectionGUID: uf15sLY/SgSd4z5suOI6MQ==
X-CSE-MsgGUID: BEWXfLGrSmyi9WG+16ilwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797879"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:25 -0700
X-CSE-ConnectionGUID: /WO5kkQtTAmAANN0ooMDVw==
X-CSE-MsgGUID: Z1ZnLU9xQpuscAGPUNlugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058743"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:19 -0700
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
Subject: [RFC v2 06/15] hw/core: Create CPU slot in MachineState to manage CPU
 topology tree
Date: Thu, 19 Sep 2024 09:55:24 +0800
Message-Id: <20240919015533.766754-7-zhao1.liu@intel.com>
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

With CPU slot support, the machine can manage the CPU topology tree. To
enable hot-plug support for topology devices, use the machine as the
hotplug handler for the CPU bus.

Additionally, since not all machines support the topology tree from the
start, add a "topo_tree_supported" flag to indicate whether a machine
supports the topology tree. And create the CPU slot as the topology root
only for machines that support it.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c         |  2 ++
 hw/cpu/cpu-slot.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/boards.h       |  9 +++++++++
 include/hw/cpu/cpu-slot.h |  2 ++
 system/vl.c               |  4 ++++
 5 files changed, 51 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 518beb9f883a..b6258d95b1e8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1239,6 +1239,8 @@ static void machine_initfn(Object *obj)
         ms->smp_cache.props[i].topology = CPU_TOPOLOGY_LEVEL_DEFAULT;
     }
 
+    ms->topo = NULL;
+
     machine_copy_boot_config(ms, &(BootConfiguration){ 0 });
 }
 
diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
index 66ef8d9faa97..4dbd5b7b7e00 100644
--- a/hw/cpu/cpu-slot.c
+++ b/hw/cpu/cpu-slot.c
@@ -138,3 +138,37 @@ static void cpu_slot_register_types(void)
 }
 
 type_init(cpu_slot_register_types)
+
+void machine_plug_cpu_slot(MachineState *ms)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    CPUSlot *slot;
+
+    slot = CPU_SLOT(qdev_new(TYPE_CPU_SLOT));
+    set_bit(CPU_TOPOLOGY_LEVEL_THREAD, slot->supported_levels);
+    set_bit(CPU_TOPOLOGY_LEVEL_CORE, slot->supported_levels);
+    set_bit(CPU_TOPOLOGY_LEVEL_SOCKET, slot->supported_levels);
+
+    /*
+     * Now just consider the levels that x86 supports.
+     * TODO: Supports other levels.
+     */
+    if (mc->smp_props.modules_supported) {
+        set_bit(CPU_TOPOLOGY_LEVEL_MODULE, slot->supported_levels);
+    }
+
+    if (mc->smp_props.dies_supported) {
+        set_bit(CPU_TOPOLOGY_LEVEL_DIE, slot->supported_levels);
+    }
+
+    ms->topo = slot;
+    object_property_add_child(container_get(OBJECT(ms), "/peripheral"),
+                              "cpu-slot", OBJECT(ms->topo));
+    DEVICE(ms->topo)->id = g_strdup_printf("%s", "cpu-slot");
+
+    sysbus_realize(SYS_BUS_DEVICE(slot), &error_abort);
+
+    if (mc->get_hotplug_handler) {
+        qbus_set_hotplug_handler(BUS(&slot->bus), OBJECT(ms));
+    }
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2dd8decf640a..eeb4e7e2ce9f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -10,6 +10,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "hw/cpu/cpu-slot.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
@@ -152,6 +153,8 @@ typedef struct {
  * @modules_supported - whether modules are supported by the machine
  * @cache_supported - whether cache topologies (l1d, l1i, l2 and l3) are
  *                    supported by the machine
+ * @topo_tree_supported - whether QOM topology tree is supported by the
+ *                        machine
  */
 typedef struct {
     bool prefer_sockets;
@@ -162,6 +165,7 @@ typedef struct {
     bool drawers_supported;
     bool modules_supported;
     bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
+    bool topo_tree_supported;
 } SMPCompatProps;
 
 /**
@@ -431,6 +435,11 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
     SmpCache smp_cache;
+    /*
+     * TODO: get rid of "smp" and merge it into "topo" when all arches
+     * support QOM topology.
+     */
+    CPUSlot *topo;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
diff --git a/include/hw/cpu/cpu-slot.h b/include/hw/cpu/cpu-slot.h
index 9d02d5de578e..24e122013bf7 100644
--- a/include/hw/cpu/cpu-slot.h
+++ b/include/hw/cpu/cpu-slot.h
@@ -69,4 +69,6 @@ struct CPUSlot {
     DeviceListener listener;
 };
 
+void machine_plug_cpu_slot(MachineState *ms);
+
 #endif /* CPU_SLOT_H */
diff --git a/system/vl.c b/system/vl.c
index fe547ca47c27..193e7049ccbe 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2151,6 +2151,10 @@ static void qemu_create_machine(QDict *qdict)
                                           false, &error_abort);
         qobject_unref(default_opts);
     }
+
+    if (machine_class->smp_props.topo_tree_supported) {
+        machine_plug_cpu_slot(current_machine);
+    }
 }
 
 static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
-- 
2.34.1


