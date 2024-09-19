Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B126CDD566
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 01:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr6AZ-0004NK-UW; Wed, 18 Sep 2024 21:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AV-0003iS-Af; Wed, 18 Sep 2024 21:41:15 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sr6AT-00059t-8A; Wed, 18 Sep 2024 21:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726710073; x=1758246073;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XSgqmMkHJizZc4N1izUEEkjh5Xf8Kwzu+lddFS/lH2U=;
 b=Db7YQTNOUIU6AmzSsUNm/5oC2/8UCfsM2bGJLo6WNzNkkzo9VHYCuFVb
 lrZ43eFyPQg4B9HkUbW//RxIpWnnWsMXPgXBoyu1Hu49On8mb5UI2CeG8
 fydX8/aWNyfkmPbXHp6NE0wXb1AGalUqpI2M4yz+m/GPElJN/KXpzee0L
 nSos6bBEOEhNkEl18h3/XNG3MaAC1nGJn/jjopyFLqpgjOx8hGjJhK7vh
 tX2j2dxTrSIYF33Yji62J5rNqCbVHcVz38pyWz2Q/Z3/zCDCyUPLN3YBE
 YhQksHZI7ilZnUSG89RdwPOAD4+h6GiZht6wVndcDCWQbNOnBuFz9AoYX A==;
X-CSE-ConnectionGUID: /9QvFR2yTc2/o4cfzoJsFA==
X-CSE-MsgGUID: /B7TbkIhS1Sgd5oIIFzIAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25798078"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25798078"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 18:41:11 -0700
X-CSE-ConnectionGUID: S1ZKAEwsS6+xTFUMRz/CIg==
X-CSE-MsgGUID: 8BpNMzORS9K4jxsU5BqXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70058972"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 18 Sep 2024 18:41:05 -0700
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
Subject: [RFC v2 13/15] system/qdev-monitor: Introduce bus-finder interface
 for compatibility with bus-less plug behavior
Date: Thu, 19 Sep 2024 09:55:31 +0800
Message-Id: <20240919015533.766754-14-zhao1.liu@intel.com>
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

Currently, cpu and core is located by topology IDs when plugging.

On a topology tree, each topology device will has a CPU bus. Once cpu
and core specify the bus_type, it's necessary to find accurate buses
for them based on topology IDs (if bus=* is not set in -device).

Therefore, we need a way to use traditional topology IDs for locating
specific bus in the topology tree. This is the bus-finder interface.

With bus-finder, qdev-monitor can locate the bus based on device
properties when "bus=*" is not specified.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 MAINTAINERS                  |  2 ++
 include/monitor/bus-finder.h | 41 ++++++++++++++++++++++++++++++++
 system/bus-finder.c          | 46 ++++++++++++++++++++++++++++++++++++
 system/meson.build           |  1 +
 system/qdev-monitor.c        | 41 ++++++++++++++++++++++++++++----
 5 files changed, 126 insertions(+), 5 deletions(-)
 create mode 100644 include/monitor/bus-finder.h
 create mode 100644 system/bus-finder.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 03c1a13de074..4608c3c6db8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3281,12 +3281,14 @@ F: hw/core/qdev*
 F: hw/core/bus.c
 F: hw/core/sysbus.c
 F: include/hw/qdev*
+F: include/monitor/bus-finder.h
 F: include/monitor/qdev.h
 F: include/qom/
 F: qapi/qom.json
 F: qapi/qdev.json
 F: scripts/coccinelle/qom-parent-type.cocci
 F: scripts/qom-cast-macro-clean-cocci-gen.py
+F: system/bus-finder.c
 F: system/qdev-monitor.c
 F: stubs/qdev.c
 F: qom/
diff --git a/include/monitor/bus-finder.h b/include/monitor/bus-finder.h
new file mode 100644
index 000000000000..56f1e4791b66
--- /dev/null
+++ b/include/monitor/bus-finder.h
@@ -0,0 +1,41 @@
+/*
+ * Bus finder interface header
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Author: Zhao Liu <zhao1.liu@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef BUS_FINDER_H
+#define BUS_FINDER_H
+
+#include "hw/qdev-core.h"
+#include "qom/object.h"
+
+#define TYPE_BUS_FINDER "bus-finder"
+
+typedef struct BusFinderClass BusFinderClass;
+DECLARE_CLASS_CHECKERS(BusFinderClass, BUS_FINDER, TYPE_BUS_FINDER)
+#define BUS_FINDER(obj) INTERFACE_CHECK(BusFinder, (obj), TYPE_BUS_FINDER)
+
+typedef struct BusFinder BusFinder;
+
+/**
+ * BusFinderClass:
+ * @find_bus: Method to find bus.
+ */
+struct BusFinderClass {
+    /* <private> */
+    InterfaceClass parent_class;
+
+    /* <public> */
+    BusState *(*find_bus)(DeviceState *dev);
+};
+
+bool is_bus_finder_type(DeviceClass *dc);
+BusState *bus_finder_select_bus(DeviceState *dev);
+
+#endif /* BUS_FINDER_H */
diff --git a/system/bus-finder.c b/system/bus-finder.c
new file mode 100644
index 000000000000..097291a96bf3
--- /dev/null
+++ b/system/bus-finder.c
@@ -0,0 +1,46 @@
+/*
+ * Bus finder interface
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
+#include "hw/qdev-core.h"
+#include "monitor/bus-finder.h"
+#include "qom/object.h"
+
+bool is_bus_finder_type(DeviceClass *dc)
+{
+    return !!object_class_dynamic_cast(OBJECT_CLASS(dc), TYPE_BUS_FINDER);
+}
+
+BusState *bus_finder_select_bus(DeviceState *dev)
+{
+    BusFinder *bf = BUS_FINDER(dev);
+    BusFinderClass *bfc = BUS_FINDER_GET_CLASS(bf);
+
+    if (bfc->find_bus) {
+        return bfc->find_bus(dev);
+    }
+
+    return NULL;
+}
+
+static const TypeInfo bus_finder_interface_info = {
+    .name          = TYPE_BUS_FINDER,
+    .parent        = TYPE_INTERFACE,
+    .class_size = sizeof(BusFinderClass),
+};
+
+static void bus_finder_register_types(void)
+{
+    type_register_static(&bus_finder_interface_info);
+}
+
+type_init(bus_finder_register_types)
diff --git a/system/meson.build b/system/meson.build
index a296270cb005..090716b81abd 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -9,6 +9,7 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
 system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
+  'bus-finder.c',
   'cpus.c',
   'cpu-throttle.c',
   'cpu-timers.c',
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e160..457dfd05115e 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "monitor/bus-finder.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
@@ -589,6 +590,16 @@ static BusState *qbus_find(const char *path, Error **errp)
     return bus;
 }
 
+static inline bool qdev_post_find_bus(DeviceClass *dc)
+{
+    return is_bus_finder_type(dc);
+}
+
+static inline BusState *qdev_find_bus_post_device(DeviceState *dev)
+{
+    return bus_finder_select_bus(dev);
+}
+
 /* Takes ownership of @id, will be freed when deleting the device */
 const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
 {
@@ -630,6 +641,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     char *id;
     DeviceState *dev = NULL;
     BusState *bus = NULL;
+    bool post_bus = false;
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
@@ -656,11 +668,15 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
             return NULL;
         }
     } else if (dc->bus_type != NULL) {
-        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
-        if (!bus || qbus_is_full(bus)) {
-            error_setg(errp, "No '%s' bus found for device '%s'",
-                       dc->bus_type, driver);
-            return NULL;
+        if (qdev_post_find_bus(dc)) {
+            post_bus = true;             /* Wait for bus-finder to arbitrate. */
+        } else {
+            bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
+            if (!bus || qbus_is_full(bus)) {
+                error_setg(errp, "No '%s' bus found for device '%s'",
+                           dc->bus_type, driver);
+                return NULL;
+            }
         }
     }
 
@@ -722,6 +738,21 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         goto err_del_dev;
     }
 
+    if (post_bus) {
+        bus = qdev_find_bus_post_device(dev);
+        if (!bus) {
+            error_setg(errp, "No proper '%s' bus found for device '%s'",
+                       dc->bus_type, driver);
+            goto err_del_dev;
+        }
+
+        if (phase_check(PHASE_MACHINE_READY) && !qbus_is_hotpluggable(bus)) {
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
+            goto err_del_dev;
+        }
+    }
+
     if (!qdev_realize(dev, bus, errp)) {
         goto err_del_dev;
     }
-- 
2.34.1


