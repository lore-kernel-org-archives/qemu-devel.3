Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB550CD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxtA-0003Lf-7Q; Wed, 03 Apr 2024 06:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxt4-0003IB-H5
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:30:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rrxt2-00040V-9H
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:30:34 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8gw8623wz6G9MD;
 Wed,  3 Apr 2024 18:29:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id E2E32140D1D;
 Wed,  3 Apr 2024 18:30:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 11:30:28 +0100
To: <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>,
 <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 2/6] hw/acpi: Insert an acpi-generic-node base under
 acpi-generic-initiator
Date: Wed, 3 Apr 2024 11:29:23 +0100
Message-ID: <20240403102927.31263-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This will simplify reuse when adding acpi-generic-port.
Note that some error_printf() messages will now print acpi-generic-node
whereas others will move to type specific cases in next patch so
are left alone for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/acpi_generic_initiator.h | 15 ++++-
 hw/acpi/acpi_generic_initiator.c         | 78 +++++++++++++++---------
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..26e2bd92d4 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -8,15 +8,26 @@
 
 #include "qom/object_interfaces.h"
 
-#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+/*
+ * Abstract type to be used as base for
+ * - acpi-generic-initator
+ * - acpi-generic-port
+ */
+#define TYPE_ACPI_GENERIC_NODE "acpi-generic-node"
 
-typedef struct AcpiGenericInitiator {
+typedef struct AcpiGenericNode {
     /* private */
     Object parent;
 
     /* public */
     char *pci_dev;
     uint16_t node;
+} AcpiGenericNode;
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
 /*
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 18a939b0e5..c054e0e27d 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -10,45 +10,61 @@
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
-typedef struct AcpiGenericInitiatorClass {
+typedef struct AcpiGenericNodeClass {
     ObjectClass parent_class;
+} AcpiGenericNodeClass;
+
+typedef struct AcpiGenericInitiatorClass {
+     AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
+                            ACPI_GENERIC_NODE, OBJECT)
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericNode, ACPI_GENERIC_NODE)
+
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   ACPI_GENERIC_INITIATOR, ACPI_GENERIC_NODE,
                    { TYPE_USER_CREATABLE },
                    { NULL })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+static void acpi_generic_node_init(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
+
+    gn->node = MAX_NODES;
+    gn->pci_dev = NULL;
+}
+
 static void acpi_generic_initiator_init(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+}
+
+static void acpi_generic_node_finalize(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
 
-    gi->node = MAX_NODES;
-    gi->pci_dev = NULL;
+    g_free(gn->pci_dev);
 }
 
 static void acpi_generic_initiator_finalize(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    g_free(gi->pci_dev);
 }
 
-static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
-                                                  Error **errp)
+static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
+                                             Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
 
-    gi->pci_dev = g_strdup(val);
+    gn->pci_dev = g_strdup(val);
 }
-
-static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
+static void acpi_generic_node_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
     MachineState *ms = MACHINE(qdev_get_machine());
     uint32_t value;
 
@@ -58,20 +74,24 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
 
     if (value >= MAX_NODES) {
         error_printf("%s: Invalid NUMA node specified\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
+                     TYPE_ACPI_GENERIC_NODE);
         exit(1);
     }
 
-    gi->node = value;
-    ms->numa_state->nodes[gi->node].has_gi = true;
+    gn->node = value;
+    ms->numa_state->nodes[gn->node].has_gi = true;
 }
 
-static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_initiator_set_pci_device);
+        acpi_generic_node_set_pci_device);
     object_class_property_add(oc, "node", "int", NULL,
-        acpi_generic_initiator_set_node, NULL, NULL);
+        acpi_generic_node_set_node, NULL, NULL);
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
 }
 
 /*
@@ -104,9 +124,9 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
+    AcpiGenericNode *gn;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -114,14 +134,14 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
         return 0;
     }
 
-    gi = ACPI_GENERIC_INITIATOR(obj);
-    if (gi->node >= ms->numa_state->num_nodes) {
+    gn = ACPI_GENERIC_NODE(obj);
+    if (gn->node >= ms->numa_state->num_nodes) {
         error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
         exit(1);
     }
 
-    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
     if (!o) {
         error_printf("%s: Specified device must be a PCI device.\n",
                      TYPE_ACPI_GENERIC_INITIATOR);
@@ -135,7 +155,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
                                    pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+                                              gn->node, &dev_handle);
 
     return 0;
 }
-- 
2.39.2


