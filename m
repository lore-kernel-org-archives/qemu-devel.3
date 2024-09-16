Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36353C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFjI-0006pE-1C; Mon, 16 Sep 2024 13:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFj9-0006Vl-0g
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:41:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFj6-0003zI-KN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:41:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sYy0fgGz6L6qT;
 Tue, 17 Sep 2024 01:37:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B1ED140A77;
 Tue, 17 Sep 2024 01:41:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:41:23 +0200
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v6 10/15] hw/acpi: Generic Port Affinity Structure support
Date: Mon, 16 Sep 2024 18:41:22 +0100
Message-ID: <20240916174122.1843197-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

These are very similar to the recently added Generic Initiators
but instead of representing an initiator of memory traffic they
represent an edge point beyond which may lie either targets or
initiators.  Here we add these ports such that they may
be targets of hmat_lb records to describe the latency and
bandwidth from host side initiators to the port.  A discoverable
mechanism such as UEFI CDAT read from CXL devices and switches
is used to discover the remainder of the path, and the OS can build
up full latency and bandwidth numbers as need for work and data
placement decisions.

Acked-by: Markus Armbruster <armbru@redhat.com>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v6: ACPI node parameters as uint32_t rather than int.
    Add very brief description of object_class properties.
    Add some more explanation to the node parameter. This is proving
    challenging to describe.
---
 qapi/qom.json                       |  41 ++++++++++
 include/hw/acpi/aml-build.h         |   3 +
 include/hw/acpi/pci.h               |   2 +-
 include/hw/pci/pci_bridge.h         |   1 +
 hw/acpi/aml-build.c                 |  39 ++++++++++
 hw/acpi/pci.c                       | 116 +++++++++++++++++++++++++++-
 hw/arm/virt-acpi-build.c            |   2 +-
 hw/i386/acpi-build.c                |   2 +-
 hw/pci-bridge/pci_expander_bridge.c |   1 -
 9 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 321ccd708a..a8beeabf1f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -844,6 +844,45 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
+##
+# @AcpiGenericPortProperties:
+#
+# Properties for acpi-generic-port objects.
+#
+# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
+#     this SRAT Generic Port Affinity Structure.  This is the same as
+#     the bus parameter for the root ports attached to this host
+#     bridge.  The resulting SRAT Generic Port Affinity Structure will
+#     refer to the ACPI object in DSDT that represents the host bridge
+#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
+#     5.2.16.7 for more information.
+#
+# @node: Similar to a NUMA node ID, but instead of providing a
+#     reference point used for defining NUMA distances and access
+#     characteristics to memory or from an initiator (e.g. CPU), this
+#     node defines the boundary point between non-discoverable system
+#     buses which must be described by firmware, and a discoverable
+#     bus.  NUMA distances and access characteristics are defined to
+#     and from that point.  For system software to establish full
+#     initiator to target characteristics this information must be
+#     combined with information retrieved from the discoverable part
+#     of the path.  An example would use CDAT (see UEFI.org)
+#     information read from devices and switches in conjunction with
+#     link characteristics read from PCIe Configuration space.
+#     To get the full path latency from CPU to CXL attached DRAM
+#     CXL device:  Add the latency from CPU to Generic Port (from
+#     HMAT indexed via the the node ID in this SRAT structure) to
+#     that for CXL bus links, the latency across intermediate switches
+#     and from the EP port to the actual memory.  Bandwidth is more
+#     complex as there may be interleaving across multiple devices
+#     and shared links in the path.
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
@@ -1043,6 +1082,7 @@
 { 'enum': 'ObjectType',
   'data': [
     'acpi-generic-initiator',
+    'acpi-generic-port',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -1118,6 +1158,7 @@
   'discriminator': 'qom-type',
   'data': {
       'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'acpi-generic-port':          'AcpiGenericPortProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 33eef85791..47a4692a7d 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -490,6 +490,9 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn);
 
+void build_srat_acpi_generic_port(GArray *table_data, uint32_t node,
+                                  const char *hid, uint32_t uid);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 3015a8171c..6359d574fd 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -41,6 +41,6 @@ Aml *aml_pci_device_dsm(void);
 void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 
-void build_srat_generic_pci_initiator(GArray *table_data);
+void build_srat_generic_affinity_structures(GArray *table_data);
 
 #endif
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
 
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 968b654e58..4aa4debf44 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1955,6 +1955,19 @@ static void build_append_srat_pci_device_handle(GArray *table_data,
     build_append_int_noprefix(table_data, 0, 12);
 }
 
+static void build_append_srat_acpi_device_handle(GArray *table_data,
+                                                 const char *hid,
+                                                 uint32_t uid)
+{
+    assert(strlen(hid) == 8);
+    /* Device Handle - ACPI */
+    for (int i = 0; i < sizeof(hid); i++) {
+        build_append_int_noprefix(table_data, hid[i], 1);
+    }
+    build_append_int_noprefix(table_data, uid, 4);
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.16.6 Generic Initiator Affinity Structure
@@ -1982,6 +1995,32 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
     build_append_int_noprefix(table_data, 0, 4);
 }
 
+/*
+ * ACPI spec, Revision 6.5
+ * 5.2.16.7 Generic Port Affinity Structure
+ *   With ACPI Device Handle.
+ */
+void build_srat_acpi_generic_port(GArray *table_data, uint32_t node,
+                                  const char *hid, uint32_t uid)
+{
+    /* Type */
+    build_append_int_noprefix(table_data, 6, 1);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Device Handle Type: ACPI */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Device Handle */
+    build_append_srat_acpi_device_handle(table_data, hid, uid);
+    /* Flags - GP Enabled */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 3e1db161cc..d7a0e91f01 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -30,6 +30,7 @@
 #include "hw/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
 
@@ -177,9 +178,122 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     return 0;
 }
 
-void build_srat_generic_pci_initiator(GArray *table_data)
+typedef struct AcpiGenericPort {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_bus;
+    uint32_t node;
+} AcpiGenericPort;
+
+typedef struct AcpiGenericPortClass {
+    ObjectClass parent_class;
+} AcpiGenericPortClass;
+
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
+static void acpi_generic_port_init(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->node = MAX_NODES;
+    gp->pci_bus = NULL;
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    g_free(gp->pci_bus);
+}
+
+static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
+                                          Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->pci_bus = g_strdup(val);
+}
+
+static void acpi_generic_port_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
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
+    gp->node = value;
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_port_set_pci_bus);
+    object_class_property_set_description(oc, "pci-bus",
+       "PCI Bus of the host bridge associated with this GP affinity structure");
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_port_set_node, NULL, NULL);
+    object_class_property_set_description(oc, "node",
+       "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");
+}
+
+static int build_acpi_generic_port(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const char *hid = "ACPI0016";
+    GArray *table_data = opaque;
+    AcpiGenericPort *gp;
+    uint32_t uid;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
+        return 0;
+    }
+
+    gp = ACPI_GENERIC_PORT(obj);
+
+    if (gp->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_PORT, gp->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
+    if (!o) {
+        error_printf("%s: device must be a CXL host bridge.\n",
+                     TYPE_ACPI_GENERIC_PORT);
+       exit(1);
+    }
+
+    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
+    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
+
+    return 0;
+}
+
+void build_srat_generic_affinity_structures(GArray *table_data)
 {
     object_child_foreach_recursive(object_get_root(),
                                    build_acpi_generic_initiator,
                                    table_data);
+    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
+                                   table_data);
 }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b5973c9148..620992c92c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -510,7 +510,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    build_srat_generic_pci_initiator(table_data);
+    build_srat_generic_affinity_structures(table_data);
 
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 88227e343e..d01e704162 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1973,7 +1973,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
     }
 
-    build_srat_generic_pci_initiator(table_data);
+    build_srat_generic_affinity_structures(table_data);
 
     /*
      * Entry is required for Windows to enable memory hotplug in OS
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3d52ea5867..4578e03024 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
-- 
2.43.0


