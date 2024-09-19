Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5090ACDD566
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69e-0006y8-7r; Wed, 18 Sep 2024 21:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69X-0006VA-HX; Wed, 18 Sep 2024 21:40:15 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69V-0004sM-HX; Wed, 18 Sep 2024 21:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710014; x=1758246014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F7jWrurI1XVWfEeDSjk70sFPKqku+j5BACGGdK6zY9w=;
 b=ZPX7dzyq5jw7trgy7ycKP+tucFWEGqXZ2m/AVheA/CXOJauTIni63/J/
 mgOCektyCbJOMoCa01aEQbltw9ODZMXz+hTyN05oBAfzFijMrcKQuFmpZ
 irMQoi6385scApVA9NpDmVggSkfnbO1r6632fnNBXWakHGxGON4tPtvZe
 YLkQaxXwUN0cNbh9nGkJcHrpNXvF+zW7XfOZFpjjd6vtP4bjAM4PtVLLm
 aQBbiT4MIQcaNShbZhX+vMJCBCSAM2dEnLQRiexKnUaagd6jv2Xw0aTHf
 1oXg06H9bNTtMvtPxHcmmYorevHIwe+98NMDcnV4IkuolkltCKjucQOjy w==;
X-CSE-ConnectionGUID: FXmAoYI2Sh+Wo2oUmCiC3A==
X-CSE-MsgGUID: zYtSrsS0Q26Hr850g5lJ9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797856"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797856"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:12 -0700
X-CSE-ConnectionGUID: VQKFuNgeQburcx//Eizfqw==
X-CSE-MsgGUID: 5cDjh2NdT+qSFPCfiK9wyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058644"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:40:05 -0700
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
Subject: [RFC v2 04/15] hw/cpu: Introduce CPU slot to manage CPU topology
Date: Thu, 19 Sep 2024 09:55:22 +0800
Message-Id: <20240919015533.766754-5-zhao1.liu@intel.com>
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

When there's a CPU topology tree, original MachineState.smp (CpuTopology
structure) is not enough to dynamically monitor changes of the tree or
update topology information in time.

To address this, introduce the CPU slot, as the root of CPU topology
tree, which is used to update and maintain global topological statistics
by listening any changes of topology device (realize() and unrealize()).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS               |   2 +
 hw/cpu/cpu-slot.c         | 140 ++++++++++++++++++++++++++++++++++++++
 hw/cpu/meson.build        |   1 +
 include/hw/cpu/cpu-slot.h |  72 ++++++++++++++++++++
 4 files changed, 215 insertions(+)
 create mode 100644 hw/cpu/cpu-slot.c
 create mode 100644 include/hw/cpu/cpu-slot.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 230267597b5f..8e5b2cd91dca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1884,6 +1884,7 @@ F: hw/core/machine-smp.c
 F: hw/core/null-machine.c
 F: hw/core/numa.c
 F: hw/cpu/cluster.c
+F: hw/cpu/cpu-slot.c
 F: hw/cpu/cpu-topology.c
 F: qapi/machine.json
 F: qapi/machine-common.json
@@ -1891,6 +1892,7 @@ F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
+F: include/hw/cpu/cpu-slot.h
 F: include/hw/cpu/cpu-topology.h
 F: include/sysemu/numa.h
 F: tests/functional/test_cpu_queries.py
diff --git a/hw/cpu/cpu-slot.c b/hw/cpu/cpu-slot.c
new file mode 100644
index 000000000000..66ef8d9faa97
--- /dev/null
+++ b/hw/cpu/cpu-slot.c
@@ -0,0 +1,140 @@
+/*
+ * CPU slot abstraction - manage CPU topology
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/boards.h"
+#include "hw/cpu/cpu-slot.h"
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
+static void cpu_slot_add_topo_info(CPUSlot *slot, CPUTopoState *topo)
+{
+    CpuTopologyLevel level = GET_CPU_TOPO_LEVEL(topo);
+    CPUTopoStatEntry *entry;
+    int instances_num;
+
+    entry = &slot->stat.entries[level];
+    entry->total_instances++;
+
+    instances_num = cpu_topo_get_instances_num(topo);
+    if (instances_num > entry->max_instances) {
+        entry->max_instances = instances_num;
+    }
+
+    set_bit(level, slot->stat.curr_levels);
+
+    return;
+}
+
+static void cpu_slot_device_realize(DeviceListener *listener,
+                                    DeviceState *dev)
+{
+    CPUSlot *slot = container_of(listener, CPUSlot, listener);
+    CPUTopoState *topo;
+
+    if (!object_dynamic_cast(OBJECT(dev), TYPE_CPU_TOPO)) {
+        return;
+    }
+
+    topo = CPU_TOPO(dev);
+    cpu_slot_add_topo_info(slot, topo);
+}
+
+static void cpu_slot_del_topo_info(CPUSlot *slot, CPUTopoState *topo)
+{
+    CpuTopologyLevel level = GET_CPU_TOPO_LEVEL(topo);
+    CPUTopoStatEntry *entry;
+
+    entry = &slot->stat.entries[level];
+    entry->total_instances--;
+
+    return;
+}
+
+static void cpu_slot_device_unrealize(DeviceListener *listener,
+                                      DeviceState *dev)
+{
+    CPUSlot *slot = container_of(listener, CPUSlot, listener);
+    CPUTopoState *topo;
+
+    if (!object_dynamic_cast(OBJECT(dev), TYPE_CPU_TOPO)) {
+        return;
+    }
+
+    topo = CPU_TOPO(dev);
+    cpu_slot_del_topo_info(slot, topo);
+}
+
+DeviceListener cpu_slot_device_listener = {
+    .realize = cpu_slot_device_realize,
+    .unrealize = cpu_slot_device_unrealize,
+};
+
+static bool slot_bus_check_topology(CPUBusState *cbus,
+                                    CPUTopoState *topo,
+                                    Error **errp)
+{
+    CPUSlot *slot = CPU_SLOT(BUS(cbus)->parent);
+    CpuTopologyLevel level = GET_CPU_TOPO_LEVEL(topo);
+
+    if (!test_bit(level, slot->supported_levels)) {
+        error_setg(errp, "cpu topo: level %s is not supported",
+                   CpuTopologyLevel_str(level));
+        return false;
+    }
+    return true;
+}
+
+static void cpu_slot_realize(DeviceState *dev, Error **errp)
+{
+    CPUSlot *slot = CPU_SLOT(dev);
+
+    slot->listener = cpu_slot_device_listener;
+    device_listener_register(&slot->listener);
+
+    qbus_init(&slot->bus, sizeof(CPUBusState),
+              TYPE_CPU_BUS, dev, "cpu-slot");
+    slot->bus.check_topology = slot_bus_check_topology;
+}
+
+static void cpu_slot_unrealize(DeviceState *dev)
+{
+    CPUSlot *slot = CPU_SLOT(dev);
+
+    device_listener_unregister(&slot->listener);
+}
+
+static void cpu_slot_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->realize = cpu_slot_realize;
+    dc->unrealize = cpu_slot_unrealize;
+}
+
+static const TypeInfo cpu_slot_type_info = {
+    .name = TYPE_CPU_SLOT,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .class_init = cpu_slot_class_init,
+    .instance_size = sizeof(CPUSlot),
+};
+
+static void cpu_slot_register_types(void)
+{
+    type_register_static(&cpu_slot_type_info);
+}
+
+type_init(cpu_slot_register_types)
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 6c6546646608..358e2b3960fa 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -1,6 +1,7 @@
 common_ss.add(files('cpu-topology.c'))
 
 system_ss.add(files('core.c'))
+system_ss.add(files('cpu-slot.c'))
 system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
 
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
diff --git a/include/hw/cpu/cpu-slot.h b/include/hw/cpu/cpu-slot.h
new file mode 100644
index 000000000000..9d02d5de578e
--- /dev/null
+++ b/include/hw/cpu/cpu-slot.h
@@ -0,0 +1,72 @@
+/*
+ * CPU slot abstraction header
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef CPU_SLOT_H
+#define CPU_SLOT_H
+
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "qapi/qapi-types-machine-common.h"
+#include "qom/object.h"
+
+/**
+ * CPUTopoStatEntry:
+ * @total_instances: Total number of topological instances at the same level
+ *                   that are currently inserted in CPU slot
+ * @max_instances: Maximum number of topological instances at the same level
+ *                 under the parent topological container
+ */
+typedef struct CPUTopoStatEntry {
+    int total_instances;
+    int max_instances;
+} CPUTopoStatEntry;
+
+/**
+ * CPUTopoStat:
+ * @entries: Detail count information for valid topology levels under
+ *           CPU slot
+ * @curr_levels: Current CPU topology levels inserted in CPU slot
+ */
+typedef struct CPUTopoStat {
+    /* TODO: Exclude invalid and default levels. */
+    CPUTopoStatEntry entries[CPU_TOPOLOGY_LEVEL__MAX];
+    DECLARE_BITMAP(curr_levels, CPU_TOPOLOGY_LEVEL__MAX);
+} CPUTopoStat;
+
+#define TYPE_CPU_SLOT "cpu-slot"
+OBJECT_DECLARE_SIMPLE_TYPE(CPUSlot, CPU_SLOT)
+
+/**
+ * CPUSlot:
+ * @cores: Queue consisting of all the cores in the topology tree
+ *     where the cpu-slot is the root. cpu-slot can maintain similar
+ *     queues for other topology levels to facilitate traversal
+ *     when necessary.
+ * @stat: Topological statistics for topology tree.
+ * @bus: CPU bus to add the children topology device.
+ * @supported_levels: Supported topology levels for topology tree.
+ * @listener: Hooks to listen realize() and unrealize() of topology
+ *            device.
+ */
+struct CPUSlot {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    CPUBusState bus;
+    CPUTopoStat stat;
+    DECLARE_BITMAP(supported_levels, CPU_TOPOLOGY_LEVEL__MAX);
+
+    DeviceListener listener;
+};
+
+#endif /* CPU_SLOT_H */
-- 
2.34.1


