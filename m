Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FD5CDD569
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr69Z-0006b2-8h; Wed, 18 Sep 2024 21:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69T-0006Mj-39; Wed, 18 Sep 2024 21:40:12 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr69O-0004sM-Tf; Wed, 18 Sep 2024 21:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710007; x=1758246007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pjDCYfWGmtcfHCeQzycylmOPTR/6NQwIB6dWf4c73R0=;
 b=c6C7PWmS8ISxG+CKi6FNNG9l2nZy98ivxl/B/sUSvcaLndqs+g2qt8GP
 0/PzkYh3IOgmAl1N4vphSsm1+lgvWlwYKda58s8/WF6iuNvyXkVyQJqFQ
 6YO2f5xsFo0a8md4owGajA9JlA1eEGSW3TYoPM/sJU6vPqh89Z8c2BMFb
 ztForJ9nTCPQHZv3pv3z0/UXjRaQdUOD1N1ssmk8WtJ4ZThh1ZT3sQfqu
 cLWDwwyM95Lt+zp1GuejeJHaQeIyrXibMz3DZ9yb8RpHr1X6AoTpMCKb1
 sEbDe0gnJAqqltrWJMlHYpViNen5O85dsWIe+ImbbdUgfKPSm45belTS6 Q==;
X-CSE-ConnectionGUID: 69DW9Xg4Qv28+c6A3UZTFQ==
X-CSE-MsgGUID: ddffMdBqSF6MBLdY5q45jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25797841"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25797841"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:40:05 -0700
X-CSE-ConnectionGUID: XUKsPmtXTHeJZs8nwwQdZA==
X-CSE-MsgGUID: 3BLglI8fRXKMxyszbBq4aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058586"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:39:58 -0700
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
Subject: [RFC v2 03/15] hw/cpu: Introduce CPU topology device and CPU bus
Date: Thu, 19 Sep 2024 09:55:21 +0800
Message-Id: <20240919015533.766754-4-zhao1.liu@intel.com>
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

Hybrid (or heterogeneous) CPU topology needs to be expressed as
a topology tree, which requires to abstract all the CPU topology
level as the objects.

At present, QEMU already has the CPU device, core device and cluster
device (for TCG), so that it's natual to introduce more topology
related devices instead of abstractong native QEMU objects.

To make it easier to deal with topological relationships, introduce
the general and abstract CPU topology device, and also introduce the
CPU bus to connect such CPU topology devices.

With the underlying CPU topology device abstraction, all the CPU
topology levels could be derived from it as subclasses. Then the
specific devices, such as CPU, core, or future module/die/socket devices
etc, don't have to care about topology relationship, and the underlying
CPU topology abstraction and CPU bus will take care of everything and
build the topology tree.

Note, for the user created topology devices, they are specified the
default object parent (one of the peripheral containers: "/peripheral"
or "/peripheral-anon"). It's necessary to fixup their parent object
to correct topology parent, so that it can make their canonical path
in qtree match the actual topological hierarchies relationship. This
is done by cpu_topo_set_parent() when topology device realizes.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS                   |   2 +
 hw/cpu/cpu-topology.c         | 179 ++++++++++++++++++++++++++++++++++
 hw/cpu/meson.build            |   2 +
 include/hw/cpu/cpu-topology.h |  68 +++++++++++++
 include/qemu/typedefs.h       |   2 +
 stubs/hotplug-stubs.c         |   5 +
 6 files changed, 258 insertions(+)
 create mode 100644 hw/cpu/cpu-topology.c
 create mode 100644 include/hw/cpu/cpu-topology.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ffacd60f4075..230267597b5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1884,12 +1884,14 @@ F: hw/core/machine-smp.c
 F: hw/core/null-machine.c
 F: hw/core/numa.c
 F: hw/cpu/cluster.c
+F: hw/cpu/cpu-topology.c
 F: qapi/machine.json
 F: qapi/machine-common.json
 F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
+F: include/hw/cpu/cpu-topology.h
 F: include/sysemu/numa.h
 F: tests/functional/test_cpu_queries.py
 F: tests/functional/test_empty_cpu_model.py
diff --git a/hw/cpu/cpu-topology.c b/hw/cpu/cpu-topology.c
new file mode 100644
index 000000000000..e68c06132e7d
--- /dev/null
+++ b/hw/cpu/cpu-topology.c
@@ -0,0 +1,179 @@
+/*
+ * General CPU topology device abstraction
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
+#include "hw/cpu/cpu-topology.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "qapi/error.h"
+
+/* Roll up until topology root to check. */
+static bool cpu_parent_check_topology(DeviceState *parent,
+                                      DeviceState *dev,
+                                      Error **errp)
+{
+    BusClass *bc;
+
+    if (!parent || !parent->parent_bus ||
+        object_dynamic_cast(OBJECT(parent->parent_bus), TYPE_CPU_BUS)) {
+        return true;
+    }
+
+    bc = BUS_GET_CLASS(parent->parent_bus);
+    if (bc->check_address) {
+        return bc->check_address(parent->parent_bus, dev, errp);
+    }
+
+    return true;
+}
+
+static bool cpu_bus_check_address(BusState *bus, DeviceState *dev,
+                                  Error **errp)
+{
+    CPUBusState *cbus = CPU_BUS(bus);
+
+    if (cbus->check_topology) {
+        return cbus->check_topology(CPU_BUS(bus), CPU_TOPO(dev), errp);
+    }
+
+    return cpu_parent_check_topology(bus->parent, dev, errp);
+}
+
+static void cpu_bus_class_init(ObjectClass *oc, void *data)
+{
+    BusClass *bc = BUS_CLASS(oc);
+
+    bc->check_address = cpu_bus_check_address;
+}
+
+static const TypeInfo cpu_bus_type_info = {
+    .name = TYPE_CPU_BUS,
+    .parent = TYPE_BUS,
+    .class_init = cpu_bus_class_init,
+    .instance_size = sizeof(CPUBusState),
+};
+
+static bool cpu_topo_set_parent(CPUTopoState *topo, Error **errp)
+{
+    DeviceState *dev = DEVICE(topo);
+    BusState *bus = dev->parent_bus;
+    CPUTopoState *parent_topo = NULL;
+    Object *parent;
+
+    if (!bus || !bus->parent) {
+        return true;
+    }
+
+    if (topo->parent) {
+        error_setg(errp, "cpu topo: %s already have the parent?",
+                   object_get_typename(OBJECT(topo)));
+        return false;
+    }
+
+    parent = OBJECT(bus->parent);
+    if (object_dynamic_cast(parent, TYPE_CPU_TOPO)) {
+        parent_topo = CPU_TOPO(parent);
+
+        if (GET_CPU_TOPO_LEVEL(topo) >= GET_CPU_TOPO_LEVEL(parent_topo)) {
+            error_setg(errp, "cpu topo: current level (%s) should be "
+                       "lower than parent (%s) level",
+                       object_get_typename(OBJECT(topo)),
+                       object_get_typename(parent));
+            return false;
+        }
+    }
+
+    if (dev->id) {
+        /*
+         * Reparent topology device to make child<> match topological
+         * relationship.
+         */
+        if (!qdev_set_parent(dev, bus, parent, NULL, errp)) {
+            return false;
+        }
+    }
+
+    topo->parent = parent_topo;
+    return true;
+}
+
+static void cpu_topo_realize(DeviceState *dev, Error **errp)
+{
+    CPUTopoState *topo = CPU_TOPO(dev);
+    CPUTopoClass *tc = CPU_TOPO_GET_CLASS(topo);
+    HotplugHandler *hotplug_handler;
+
+    if (tc->level == CPU_TOPOLOGY_LEVEL_INVALID) {
+        error_setg(errp, "cpu topo: no level specified type: %s",
+                   object_get_typename(OBJECT(dev)));
+        return;
+    }
+
+    if (!cpu_topo_set_parent(topo, errp)) {
+        return;
+    }
+
+    topo->bus = CPU_BUS(qbus_new(TYPE_CPU_BUS, dev, dev->id));
+    hotplug_handler = qdev_get_bus_hotplug_handler(dev);
+    if (hotplug_handler) {
+        qbus_set_hotplug_handler(BUS(topo->bus), OBJECT(hotplug_handler));
+    }
+}
+
+static void cpu_topo_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CPUTopoClass *tc = CPU_TOPO_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+    dc->realize = cpu_topo_realize;
+
+    /*
+     * If people doesn't want a topology tree, it's necessary to
+     * derive a child class and override this as NULL.
+     */
+    dc->bus_type = TYPE_CPU_BUS;
+
+    /*
+     * The general topo device is not hotpluggable by default.
+     * If any topo device needs hotplug support, this flag must be
+     * overridden.
+     */
+    dc->hotpluggable = false;
+
+    tc->level = CPU_TOPOLOGY_LEVEL_INVALID;
+}
+
+static const TypeInfo cpu_topo_type_info = {
+    .name = TYPE_CPU_TOPO,
+    .parent = TYPE_DEVICE,
+    .abstract = true,
+    .class_size = sizeof(CPUTopoClass),
+    .class_init = cpu_topo_class_init,
+    .instance_size = sizeof(CPUTopoState),
+};
+
+static void cpu_topo_register_types(void)
+{
+    type_register_static(&cpu_bus_type_info);
+    type_register_static(&cpu_topo_type_info);
+}
+
+type_init(cpu_topo_register_types)
+
+int cpu_topo_get_instances_num(CPUTopoState *topo)
+{
+    BusState *bus = DEVICE(topo)->parent_bus;
+
+    return bus ? bus->num_children : 1;
+}
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 9d36bf8ae2c1..6c6546646608 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -1,3 +1,5 @@
+common_ss.add(files('cpu-topology.c'))
+
 system_ss.add(files('core.c'))
 system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('cluster.c'))
 
diff --git a/include/hw/cpu/cpu-topology.h b/include/hw/cpu/cpu-topology.h
new file mode 100644
index 000000000000..7a447ad16ee7
--- /dev/null
+++ b/include/hw/cpu/cpu-topology.h
@@ -0,0 +1,68 @@
+/*
+ * General CPU topology device abstraction
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef CPU_TOPO_H
+#define CPU_TOPO_H
+
+#include "hw/qdev-core.h"
+#include "qapi/qapi-types-machine-common.h"
+#include "qom/object.h"
+
+#define TYPE_CPU_BUS "cpu-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(CPUBusState, CPU_BUS)
+
+/**
+ * CPUBusState:
+ * @check_topology: Method to check if @topo is supported by @cbus.
+ */
+struct CPUBusState {
+    /*< private >*/
+    BusState parent_obj;
+
+    /*< public >*/
+    bool (*check_topology)(CPUBusState *cbus, CPUTopoState *topo,
+                           Error **errp);
+};
+
+#define TYPE_CPU_TOPO "cpu-topo"
+OBJECT_DECLARE_TYPE(CPUTopoState, CPUTopoClass, CPU_TOPO)
+
+/**
+ * CPUTopoClass:
+ * @level: Topology level for this CPUTopoClass.
+ */
+struct CPUTopoClass {
+    /*< private >*/
+    DeviceClass parent_class;
+
+    /*< public >*/
+    CpuTopologyLevel level;
+};
+
+/**
+ * CPUTopoState:
+ * @parent: Topology parent of this topology device.
+ * @bus: The CPU bus to add the children device.
+ */
+struct CPUTopoState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    struct CPUTopoState *parent;
+    CPUBusState *bus;
+};
+
+#define GET_CPU_TOPO_LEVEL(topo)    (CPU_TOPO_GET_CLASS(topo)->level)
+
+int cpu_topo_get_instances_num(CPUTopoState *topo);
+
+#endif /* CPU_TOPO_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index aef41c4e67ce..d62d8687403f 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -39,8 +39,10 @@ typedef struct Chardev Chardev;
 typedef struct Clock Clock;
 typedef struct ConfidentialGuestSupport ConfidentialGuestSupport;
 typedef struct CPUArchState CPUArchState;
+typedef struct CPUBusState CPUBusState;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
+typedef struct CPUTopoState CPUTopoState;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
 typedef struct DisasContextBase DisasContextBase;
diff --git a/stubs/hotplug-stubs.c b/stubs/hotplug-stubs.c
index 7aadaa29bd57..791fae079d6d 100644
--- a/stubs/hotplug-stubs.c
+++ b/stubs/hotplug-stubs.c
@@ -19,6 +19,11 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
+{
+    return NULL;
+}
+
 void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp)
-- 
2.34.1


