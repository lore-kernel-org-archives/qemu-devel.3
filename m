Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D276FC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFIm-0000u4-4O; Mon, 16 Sep 2024 13:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFIT-0008QP-S9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:13:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFIR-00011w-I1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:13:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6ry84KrSz6LD7N;
 Tue, 17 Sep 2024 01:10:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 90E87140AB8;
 Tue, 17 Sep 2024 01:13:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:13:50 +0200
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v6 06/15] acpi/pci: Move Generic Initiator object handling
 into acpi/pci.*
Date: Mon, 16 Sep 2024 18:10:11 +0100
Message-ID: <20240916171017.1841767-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.048, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Whilst ACPI SRAT Generic Initiator Afinity Structures are able to refer to
both PCI and ACPI Device Handles, the QEMU implementation only implements
the PCI Device Handle case.  For now move the code into the existing
hw/acpi/pci.c file and header.  If support for ACPI Device Handles is
added in the future, perhaps this will be moved again.

Also push the struct AcpiGenericInitiator down into the c file as not
used outside pci.c.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/acpi_generic_initiator.h |  24 -----
 include/hw/acpi/pci.h                    |   3 +
 hw/acpi/acpi_generic_initiator.c         | 120 ----------------------
 hw/acpi/pci.c                            | 124 +++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |   1 -
 hw/i386/acpi-build.c                     |   1 -
 hw/acpi/meson.build                      |   1 -
 7 files changed, 127 insertions(+), 147 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
deleted file mode 100644
index 7b98676713..0000000000
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
- */
-
-#ifndef ACPI_GENERIC_INITIATOR_H
-#define ACPI_GENERIC_INITIATOR_H
-
-#include "qom/object_interfaces.h"
-
-#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
-
-typedef struct AcpiGenericInitiator {
-    /* private */
-    Object parent;
-
-    /* public */
-    char *pci_dev;
-    uint16_t node;
-} AcpiGenericInitiator;
-
-void build_srat_generic_pci_initiator(GArray *table_data);
-
-#endif
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 467a99461c..3015a8171c 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -40,4 +40,7 @@ Aml *aml_pci_device_dsm(void);
 
 void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
deleted file mode 100644
index 365feb527f..0000000000
--- a/hw/acpi/acpi_generic_initiator.c
+++ /dev/null
@@ -1,120 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
- */
-
-#include "qemu/osdep.h"
-#include "hw/acpi/acpi_generic_initiator.h"
-#include "hw/acpi/aml-build.h"
-#include "hw/boards.h"
-#include "hw/pci/pci_device.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
-
-typedef struct AcpiGenericInitiatorClass {
-    ObjectClass parent_class;
-} AcpiGenericInitiatorClass;
-
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
-
-OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
-
-static void acpi_generic_initiator_init(Object *obj)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    gi->node = MAX_NODES;
-    gi->pci_dev = NULL;
-}
-
-static void acpi_generic_initiator_finalize(Object *obj)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    g_free(gi->pci_dev);
-}
-
-static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
-                                                  Error **errp)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    gi->pci_dev = g_strdup(val);
-}
-
-static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-    MachineState *ms = MACHINE(qdev_get_machine());
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    if (value >= MAX_NODES) {
-        error_printf("%s: Invalid NUMA node specified\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    gi->node = value;
-    ms->numa_state->nodes[gi->node].has_gi = true;
-}
-
-static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
-{
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_initiator_set_pci_device);
-    object_class_property_add(oc, "node", "int", NULL,
-        acpi_generic_initiator_set_node, NULL, NULL);
-}
-
-static int build_acpi_generic_initiator(Object *obj, void *opaque)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    AcpiGenericInitiator *gi;
-    GArray *table_data = opaque;
-    int32_t devfn;
-    uint8_t bus;
-    Object *o;
-
-    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
-        return 0;
-    }
-
-    gi = ACPI_GENERIC_INITIATOR(obj);
-    if (gi->node >= ms->numa_state->num_nodes) {
-        error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
-        exit(1);
-    }
-
-    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
-    if (!o) {
-        error_printf("%s: Specified device must be a PCI device.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    bus = object_property_get_uint(o, "busnr", &error_fatal);
-    devfn = object_property_get_int(o, "addr", &error_fatal);
-    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
-    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
-
-    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
-
-    return 0;
-}
-
-void build_srat_generic_pci_initiator(GArray *table_data)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   build_acpi_generic_initiator,
-                                   table_data);
-}
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 20b70dcd81..3e1db161cc 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -24,8 +24,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qom/object_interfaces.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
+#include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
 
 /*
@@ -59,3 +64,122 @@ void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
 
     acpi_table_end(linker, &table);
 }
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_dev;
+    uint16_t node;
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+    ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
+
+static void acpi_generic_initiator_init(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->node = MAX_NODES;
+    gi->pci_dev = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->pci_dev);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->pci_dev = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= MAX_NODES) {
+        error_printf("%s: Invalid NUMA node specified\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    gi->node = value;
+    ms->numa_state->nodes[gi->node].has_gi = true;
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_initiator_set_node, NULL, NULL);
+}
+
+static int build_acpi_generic_initiator(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    AcpiGenericInitiator *gi;
+    GArray *table_data = opaque;
+    int32_t devfn;
+    uint8_t bus;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        return 0;
+    }
+
+    gi = ACPI_GENERIC_INITIATOR(obj);
+    if (gi->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: Specified node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    if (!o) {
+        error_printf("%s: Specified device must be a PCI device.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    bus = object_property_get_uint(o, "busnr", &error_fatal);
+    devfn = object_property_get_uint(o, "addr", &error_fatal);
+    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
+    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
+
+    return 0;
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   build_acpi_generic_initiator,
+                                   table_data);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f76fb117ad..b5973c9148 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -57,7 +57,6 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
-#include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4967aa7459..afb2fa2edc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,7 +68,6 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
-#include "hw/acpi/acpi_generic_initiator.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 7f8ccc9b7a..c8854f4d48 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,6 +1,5 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
-  'acpi_generic_initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
-- 
2.43.0


