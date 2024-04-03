Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1693CCD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxtd-0004pt-Ic; Wed, 03 Apr 2024 06:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxta-0004ZZ-OH
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:31:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxtW-00045I-6m
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:31:06 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8gwk6SDTz6GBrL;
 Wed,  3 Apr 2024 18:29:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5C34C1400CA;
 Wed,  3 Apr 2024 18:30:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:30:58 +0100
To: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
Date: Wed, 3 Apr 2024 11:29:24 +0100
Message-ID: <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

These are very similar to the recently added Generic Initiators
but instead of representing an initiator of memory traffic they
represent an edge point beyond which may lie either targets or
initiators.  Here we add these ports such that they may
be targets of hmat_lb records to describe the latency and
bandwidth from host side initiators to the port.  A descoverable
mechanism such as UEFI CDAT read from CXL devices and switches
is used to discover the remainder fo the path and the OS can build
up full latency and bandwidth numbers as need for work and data
placement decisions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/qom.json                            |  18 +++
 include/hw/acpi/acpi_generic_initiator.h |  18 ++-
 include/hw/pci/pci_bridge.h              |   1 +
 hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
 hw/pci-bridge/pci_expander_bridge.c      |   1 -
 5 files changed, 141 insertions(+), 38 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 85e6b4f84a..5480d9ca24 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -826,6 +826,22 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
+
+##
+# @AcpiGenericPortProperties:
+#
+# Properties for acpi-generic-port objects.
+#
+# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry
+#
+# @node: numa node associated with the PCI device
+#
+# Since: 9.1
+##
+{ 'struct': 'AcpiGenericPortProperties',
+  'data': { 'pci-bus': 'str',
+            'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -944,6 +960,7 @@
 { 'enum': 'ObjectType',
   'data': [
     'acpi-generic-initiator',
+    'acpi-generic-port',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -1016,6 +1033,7 @@
   'discriminator': 'qom-type',
   'data': {
       'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'acpi-generic-port':          'AcpiGenericPortProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index 26e2bd92d4..49ac448034 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -30,6 +30,12 @@ typedef struct AcpiGenericInitiator {
     AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
+
+typedef struct AcpiGenericPort {
+    AcpiGenericInitiator parent;
+} AcpiGenericPort;
+
 /*
  * ACPI 6.3:
  * Table 5-81 Flags – Generic Initiator Affinity Structure
@@ -49,8 +55,16 @@ typedef enum {
  * Table 5-80 Device Handle - PCI
  */
 typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
+    union {
+        struct {
+            uint16_t segment;
+            uint16_t bdf;
+        };
+        struct {
+            uint64_t hid;
+            uint32_t uid;
+        };
+    };
 } PCIDeviceHandle;
 
 void build_srat_generic_pci_initiator(GArray *table_data);
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..5456e24883 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index c054e0e27d..85191e90ab 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -7,6 +7,7 @@
 #include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
@@ -18,6 +19,10 @@ typedef struct AcpiGenericInitiatorClass {
      AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+typedef struct AcpiGenericPortClass {
+    AcpiGenericInitiatorClass parent;
+} AcpiGenericPortClass;
+
 OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
                             ACPI_GENERIC_NODE, OBJECT)
 
@@ -30,6 +35,13 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, ACPI_GENERIC_NODE,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
 static void acpi_generic_node_init(Object *obj)
 {
     AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
@@ -53,6 +65,14 @@ static void acpi_generic_initiator_finalize(Object *obj)
 {
 }
 
+static void acpi_generic_port_init(Object *obj)
+{
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+}
+
 static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
                                              Error **errp)
 {
@@ -79,42 +99,61 @@ static void acpi_generic_node_set_node(Object *obj, Visitor *v,
     }
 
     gn->node = value;
-    ms->numa_state->nodes[gn->node].has_gi = true;
+    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        ms->numa_state->nodes[gn->node].has_gi = true;
+    }
 }
 
 static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
 {
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_node_set_pci_device);
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_node_set_node, NULL, NULL);
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_node_set_pci_device);
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    /*
+     * Despite the ID representing a root bridge bus, same storage
+     * can be used.
+     */
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_node_set_pci_device);
 }
 
 /*
  * ACPI 6.3:
  * Table 5-78 Generic Initiator Affinity Structure
+ * ACPI 6.5:
+ * Table 5-67 Generic Port Affinity Structure
  */
 static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
+build_srat_generic_node_affinity(GArray *table_data, int node,
+                                 PCIDeviceHandle *handle, bool gp, bool pci)
 {
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, gp ? 6 : 5, 1);  /* Type */
     build_append_int_noprefix(table_data, 32, 1); /* Length */
     build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    /* Device Handle Type: PCI / ACPI */
+    build_append_int_noprefix(table_data, pci ? 1 : 0, 1);
     build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
 
     /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, handle->bdf, 2);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
+    if (pci) {
+        /* Device Handle - PCI */
+        build_append_int_noprefix(table_data, handle->segment, 2);
+        build_append_int_noprefix(table_data, handle->bdf, 2);
+        build_append_int_noprefix(table_data, 0, 12);
+    } else {
+        /* Device Handle - ACPI */
+        build_append_int_noprefix(table_data, handle->hid, 8);
+        build_append_int_noprefix(table_data, handle->uid, 4);
+        build_append_int_noprefix(table_data, 0, 4);
     }
 
     build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
@@ -127,37 +166,69 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
     AcpiGenericNode *gn;
-    PCIDevice *pci_dev;
     Object *o;
 
-    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_NODE)) {
         return 0;
     }
 
     gn = ACPI_GENERIC_NODE(obj);
-    if (gn->node >= ms->numa_state->num_nodes) {
-        error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
-        exit(1);
-    }
 
-    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
-    if (!o) {
-        error_printf("%s: Specified device must be a PCI device.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
+    if (object_dynamic_cast(OBJECT(gn), TYPE_ACPI_GENERIC_INITIATOR)) {
+        PCIDevice *pci_dev;
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: Specified node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
+        if (!o) {
+            error_printf("%s: Specified device must be a PCI device.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR);
+            exit(1);
+        }
+        pci_dev = PCI_DEVICE(o);
+
+        dev_handle.segment = 0;
+        dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                       pci_dev->devfn);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, false, true);
 
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gn->node, &dev_handle);
+        return 0;
+    } else { /* TYPE_ACPI_GENERIC_PORT */
+        PCIBus *bus;
+        const char *hid = "ACPI0016";
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: Specified node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_PORT, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_BUS, NULL);
+        if (!o) {
+            error_printf("%s: Specified device must be a PCI Host Bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        bus = PCI_BUS(o);
+        /* Need to know if this is a PXB Bus so below an expander bridge */
+        if (!object_dynamic_cast(OBJECT(bus), TYPE_PXB_CXL_BUS)) {
+            error_printf("%s: Specified device is not a bus below a host bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        /* Copy without trailing NULL */
+        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
+        dev_handle.uid = pci_bus_num(bus);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, true, false);
 
-    return 0;
+        return 0;
+    }
 }
 
 void build_srat_generic_pci_initiator(GArray *table_data)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..f5431443b9 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
-- 
2.39.2


