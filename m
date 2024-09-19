Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07340CDD566
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr6AK-0002Yn-TD; Wed, 18 Sep 2024 21:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AC-0001xG-5d; Wed, 18 Sep 2024 21:40:56 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AA-00058t-2C; Wed, 18 Sep 2024 21:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710054; x=1758246054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0niF0vf3jvEyp2QjdR6nFcp3M1J547cnSvpKpCorKyw=;
 b=m6sSuQKwo81FBEOn+fWUI1uJvZrjwWZxCrjw0p/vqoUaTRWDq1FvkRM6
 IZrV5n7Mye4UrNVWA6gCI5sLmeZTrhh0HbA5Hnl2KXsyAp1uFNTMtOe8Y
 QP6kfbVqvd/lqe48Cmgyf6duHzfGZhao7BrpdI7/spqCwT7ux2nyTocbp
 hVAzKOIP+fB7nAQSRJjiI2UhjaZmk4BNeVlAFGVN+REF4RRVuODsifi3A
 /juzozPN1SqcEJt4dboJ0p6TuoTF2kQl5xQhD/fy/s+ViFSk31+iM0xlb
 3uOSPl8D9iSRGOfiAQwiawA+cxrm3Y5hgCa1nsyVEKj0MWvAKiu4v88B5 w==;
X-CSE-ConnectionGUID: B829nPk0SvSTbR90pivhng==
X-CSE-MsgGUID: Abr6DWOsSa2REyST/WQ4vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25798002"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25798002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:52 -0700
X-CSE-ConnectionGUID: sCN0Ehe4SeiW9m26BTN/FA==
X-CSE-MsgGUID: e7DxLiX3SxWuG72VcaXdmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058928"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:45 -0700
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
Subject: [RFC v2 10/15] hw/machine: Build smp topology tree from -smp
Date: Thu, 19 Sep 2024 09:55:28 +0800
Message-Id: <20240919015533.766754-11-zhao1.liu@intel.com>
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

For architectures supports QOM topology (indicated by the MachineClass.
topo_tree_supported field), implement smp QOM topology tree from
MachineState.smp.

The topology tree is created before MachineClass.init(), where arch
will initialize CPUs or cores, corresponding to the
MachineState.possible_cpus[].

To avoid conflicts with CPU/core generation in the arch machine,
create_smp_topo_children() will only create topology levels which
are higher than the granularity of possible_cpus[]. The remaining
topology parts will be completed by the arch machine during machine
init().

There's a new field, arch_id_topo_level, to indicate the granularity of
possible_cpus[]. While this field is set, CPU slot can create the
topology tree level by level. Without this field, any topology device
will be collect at the CPU bus of the CPU slot and will not be organized
into a tree structure.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c         |   5 ++
 hw/cpu/cpu-slot.c         | 153 ++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h       |   2 +
 include/hw/cpu/cpu-slot.h |   5 ++
 include/qemu/bitops.h     |   5 ++
 5 files changed, 170 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b6258d95b1e8..076bd365197b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1638,6 +1638,11 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
                                    "on", false);
     }
 
+    if (machine_class->smp_props.topo_tree_supported &&
+        !machine_create_topo_tree(machine, errp)) {
+        return;
+    }
+
     accel_init_interfaces(ACCEL_GET_CLASS(machine->accelerator));
     machine_class->init(machine);
     phase_advance(PHASE_MACHINE_INITIALIZED);
diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
index 4dbd5b7b7e00..1cc3b32ed675 100644
--- a/hw/cpu/cpu-slot.c
+++ b/hw/cpu/cpu-slot.c
@@ -12,8 +12,12 @@
 #include "qemu/osdep.h"
 
 #include "hw/boards.h"
+#include "hw/cpu/core.h"
 #include "hw/cpu/cpu-slot.h"
 #include "hw/cpu/cpu-topology.h"
+#include "hw/cpu/die.h"
+#include "hw/cpu/module.h"
+#include "hw/cpu/socket.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -172,3 +176,152 @@ void machine_plug_cpu_slot(MachineState *ms)
         qbus_set_hotplug_handler(BUS(&slot->bus), OBJECT(ms));
     }
 }
+
+static int get_smp_info_by_level(const CpuTopology *smp_info,
+                                 CpuTopologyLevel child_level)
+{
+    switch (child_level) {
+    case CPU_TOPOLOGY_LEVEL_THREAD:
+        return smp_info->threads;
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return smp_info->cores;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return smp_info->modules;
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return smp_info->dies;
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        return smp_info->sockets;
+    default:
+        /* TODO: Add support for other levels. */
+        g_assert_not_reached();
+    }
+
+    return 0;
+}
+
+static const char *get_topo_typename_by_level(CpuTopologyLevel level)
+{
+    switch (level) {
+    case CPU_TOPOLOGY_LEVEL_CORE:
+        return TYPE_CPU_CORE;
+    case CPU_TOPOLOGY_LEVEL_MODULE:
+        return TYPE_CPU_MODULE;
+    case CPU_TOPOLOGY_LEVEL_DIE:
+        return TYPE_CPU_DIE;
+    case CPU_TOPOLOGY_LEVEL_SOCKET:
+        return TYPE_CPU_SOCKET;
+    default:
+        /* TODO: Add support for other levels. */
+        g_assert_not_reached();
+    }
+
+    return NULL;
+}
+
+typedef struct SMPBuildCbData {
+    DECLARE_BITMAP(create_levels, CPU_TOPOLOGY_LEVEL__MAX);
+    const CpuTopology *smp_info;
+    CPUTopoStat *stat;
+    Error **errp;
+} SMPBuildCbData;
+
+static int create_smp_topo_children(DeviceState *dev, void *opaque)
+{
+    Object *parent = OBJECT(dev);
+    CpuTopologyLevel child_level;
+    SMPBuildCbData *cb = opaque;
+    CPUTopoState *topo = NULL;
+    BusState *qbus;
+    CPUBusState *cbus;
+    Error **errp = cb->errp;
+    int max_children;
+
+    if (object_dynamic_cast(parent, TYPE_CPU_TOPO)) {
+        topo = CPU_TOPO(parent);
+        CpuTopologyLevel parent_level;
+
+        parent_level = GET_CPU_TOPO_LEVEL(topo);
+        child_level = find_last_bit(cb->create_levels, parent_level);
+
+        if (child_level == parent_level) {
+            return TOPO_FOREACH_CONTINUE;
+        }
+
+        cbus = topo->bus;
+    } else if (object_dynamic_cast(parent, TYPE_CPU_SLOT)) {
+        child_level = find_last_bit(cb->create_levels, CPU_TOPOLOGY_LEVEL__MAX);
+        cbus = &CPU_SLOT(parent)->bus;
+    } else {
+        return TOPO_FOREACH_ERR;
+    }
+
+    qbus = BUS(cbus);
+    max_children = get_smp_info_by_level(cb->smp_info, child_level);
+    for (int i = 0; i < max_children; i++) {
+        DeviceState *child;
+
+        child = qdev_new(get_topo_typename_by_level(child_level));
+
+        /*
+         * Bus inserts child device at head (QTAILQ_INSERT_HEAD_RCU), This
+         * could result in the device IDs in the created topology having a
+         * zig-zag arrangement.
+         *
+         * TODO: Remove obstacles preventing the use of QTAILQ_INSERT_HEAD_RCU
+         * for bus to insert kid device.
+         */
+        child->id = g_strdup_printf("%s[%d]",
+            CpuTopologyLevel_str(child_level),
+            cb->stat->entries[child_level].total_instances);
+
+        if (!qdev_realize_and_unref(child, qbus, errp)) {
+            return TOPO_FOREACH_ERR;
+        }
+    }
+
+    return TOPO_FOREACH_CONTINUE;
+}
+
+bool machine_create_topo_tree(MachineState *ms, Error **errp)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    CPUSlot *slot = ms->topo;
+    CpuTopologyLevel level;
+    SMPBuildCbData cb;
+
+    if (!slot) {
+        error_setg(errp, "Invalid machine: "
+                   "the cpu-slot of machine is not initialized.");
+        return false;
+    }
+
+    /*
+     * Don't support full topology tree.
+     * Just use slot to collect topology device.
+     */
+    if (!mc->smp_props.arch_id_topo_level) {
+        return true;
+    }
+
+    bitmap_copy(cb.create_levels, slot->supported_levels,
+                CPU_TOPOLOGY_LEVEL__MAX);
+    cb.smp_info = &ms->smp;
+    cb.stat = &slot->stat;
+    cb.errp = errp;
+
+    /*
+     * Topology objects at arch_id_topo_level and lower levels will be
+     * created by MachineClass.possible_cpu_arch_ids().
+     */
+    FOR_EACH_SET_BIT(level, slot->supported_levels,
+                     mc->smp_props.arch_id_topo_level + 1) {
+        clear_bit(level, cb.create_levels);
+    }
+
+    if (qdev_walk_children(DEVICE(slot), create_smp_topo_children,
+                           NULL, NULL, NULL, &cb) < 0) {
+        return false;
+    }
+
+    return true;
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index eeb4e7e2ce9f..a49677466ef6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -155,6 +155,7 @@ typedef struct {
  *                    supported by the machine
  * @topo_tree_supported - whether QOM topology tree is supported by the
  *                        machine
+ * @arch_id_topo_level - topology granularity for possible_cpus[]
  */
 typedef struct {
     bool prefer_sockets;
@@ -166,6 +167,7 @@ typedef struct {
     bool modules_supported;
     bool cache_supported[CACHE_LEVEL_AND_TYPE__MAX];
     bool topo_tree_supported;
+    CpuTopologyLevel arch_id_topo_level;
 } SMPCompatProps;
 
 /**
diff --git a/include/hw/cpu/cpu-slot.h b/include/hw/cpu/cpu-slot.h
index 24e122013bf7..1838e8c0c3f9 100644
--- a/include/hw/cpu/cpu-slot.h
+++ b/include/hw/cpu/cpu-slot.h
@@ -69,6 +69,11 @@ struct CPUSlot {
     DeviceListener listener;
 };
 
+#define TOPO_FOREACH_END             1
+#define TOPO_FOREACH_CONTINUE        0
+#define TOPO_FOREACH_ERR             -1
+
 void machine_plug_cpu_slot(MachineState *ms);
+bool machine_create_topo_tree(MachineState *ms, Error **errp);
 
 #endif /* CPU_SLOT_H */
diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 2c0a2fe7512d..d1c0e52219de 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -631,4 +631,9 @@ static inline uint64_t half_unshuffle64(uint64_t x)
     return x;
 }
 
+#define FOR_EACH_SET_BIT(bit, addr, size)               \
+    for ((bit) = find_first_bit((addr), (size));        \
+         (bit) < (size);                                \
+         (bit) = find_next_bit((addr), (size), (bit) + 1))
+
 #endif
-- 
2.34.1


