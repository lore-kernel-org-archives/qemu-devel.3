Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515ADC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFGn-0007Uu-VT; Mon, 16 Sep 2024 13:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFGm-0007H0-0x
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:12:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sqFGj-0000uS-M4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:12:11 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6rw712Kkz6LD7N;
 Tue, 17 Sep 2024 01:08:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 21E4B140B39;
 Tue, 17 Sep 2024 01:12:08 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:12:04 +0200
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: [PATCH v6 03/15] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Date: Mon, 16 Sep 2024 18:10:08 +0100
Message-ID: <20240916171017.1841767-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Rather than attempting to create a generic function with mess of the two
different device handle types, use a PCI handle specific variant.  If the
ACPI handle form is needed then that can be introduced alongside this
with little duplicated code.

Drop the PCIDeviceHandle in favor of just passing the bus, devfn
and segment directly.  devfn kept as a single byte because ARI means
that in this case it is just an 8 bit function number.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/acpi_generic_initiator.h | 23 -------------
 include/hw/acpi/aml-build.h              |  4 +++
 hw/acpi/acpi_generic_initiator.c         | 39 ++-------------------
 hw/acpi/aml-build.c                      | 44 ++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..7b98676713 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -19,29 +19,6 @@ typedef struct AcpiGenericInitiator {
     uint16_t node;
 } AcpiGenericInitiator;
 
-/*
- * ACPI 6.3:
- * Table 5-81 Flags – Generic Initiator Affinity Structure
- */
-typedef enum {
-    /*
-     * If clear, the OSPM ignores the contents of the Generic
-     * Initiator/Port Affinity Structure. This allows system firmware
-     * to populate the SRAT with a static number of structures, but only
-     * enable them as necessary.
-     */
-    GEN_AFFINITY_ENABLED = (1 << 0),
-} GenericAffinityFlags;
-
-/*
- * ACPI 6.3:
- * Table 5-80 Device Handle - PCI
- */
-typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
-} PCIDeviceHandle;
-
 void build_srat_generic_pci_initiator(GArray *table_data);
 
 #endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index a3784155cb..33eef85791 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,6 +486,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 4a02c19468..7665b16107 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -74,40 +74,11 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
         acpi_generic_initiator_set_node, NULL, NULL);
 }
 
-/*
- * ACPI 6.3:
- * Table 5-78 Generic Initiator Affinity Structure
- */
-static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
-{
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
-    build_append_int_noprefix(table_data, 32, 1); /* Length */
-    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
-    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
-
-    /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
-    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
-    }
-
-    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
-    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
-}
-
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDeviceHandle dev_handle;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -130,13 +101,9 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     }
 
     pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
-
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+    build_srat_pci_generic_initiator(table_data, gi->node, 0,
+                                     pci_bus_num(pci_get_bus(pci_dev)),
+                                     pci_dev->devfn);
 
     return 0;
 }
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..968b654e58 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1938,6 +1938,50 @@ void build_srat_memory(GArray *table_data, uint64_t base,
     build_append_int_noprefix(table_data, 0, 8); /* Reserved */
 }
 
+/*
+ * ACPI Spec Revision 6.3
+ * Table 5-80 Device Handle - PCI
+ */
+static void build_append_srat_pci_device_handle(GArray *table_data,
+                                                uint16_t segment,
+                                                uint8_t bus, uint8_t devfn)
+{
+    /* PCI segment number */
+    build_append_int_noprefix(table_data, segment, 2);
+    /* PCI Bus Device Function */
+    build_append_int_noprefix(table_data, bus, 1);
+    build_append_int_noprefix(table_data, devfn, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 12);
+}
+
+/*
+ * ACPI spec, Revision 6.3
+ * 5.2.16.6 Generic Initiator Affinity Structure
+ *    With PCI Device Handle.
+ */
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn)
+{
+    /* Type */
+    build_append_int_noprefix(table_data, 5, 1);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, 1, 1);
+    /* Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Device Handle */
+    build_append_srat_pci_device_handle(table_data, segment, bus, devfn);
+    /* Flags - GI Enabled */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
-- 
2.43.0


