Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D16CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB86e-0000XX-TL; Mon, 28 Sep 2026 05:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB86d-0000X6-Hv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB86a-00009w-Rm
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790589424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exX1zsK/mhQx+Jvfd/Qj5mA7V/LpOI3/0XJa9RPhC8k=;
 b=IYR/afskP1OokQhj1KAjLmhX9j38eQ4DgIl5v1RdCBPQiulE6D3nY9ajdEVmstUGEG8xVC
 wajXRKmDanTwzGLM057RUwjyqvyvscdPb+2dbNy0hTeWBZAFcQUgj5Hjh6QoMEGjSoPECK
 tsipBG8Hs1vfLuJN14lYJ21aI4mkXF4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-Rw9tR4cwOF2kJJvfrcMRBw-1; Mon,
 28 Sep 2026 05:56:58 -0400
X-MC-Unique: Rw9tR4cwOF2kJJvfrcMRBw-1
X-Mimecast-MFC-AGG-ID: Rw9tR4cwOF2kJJvfrcMRBw_1790589417
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E3C318512F9; Mon, 28 Sep 2026 09:56:57 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D99791956087; Mon, 28 Sep 2026 09:56:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/2] hw/pci-bridge: split CXL PXB into separate file
Date: Mon, 28 Sep 2026 10:56:46 +0100
Message-ID: <20260928095646.3555447-3-berrange@redhat.com>
In-Reply-To: <20260928095646.3555447-1-berrange@redhat.com>
References: <20260928095646.3555447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If CONFIG_CXL=n is added to the Kconfig, the build fails to link
the PXB device:

/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
/usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
/home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'

We cannot use CONFIG_CXL in pci_expander_bridge.c because the
identifier is poisoned. Instead the CXL pieces must be split
off into a separate source file which can be conditionally
built.

With this change, the stubs file is no longer required, since
the code referencing the stub was already protected by CONFIG_CXL.

Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/cxl/cxl-host.c                             |   2 +-
 hw/pci-bridge/meson.build                     |   4 +-
 hw/pci-bridge/pci_expander_bridge.c           | 194 +----------------
 hw/pci-bridge/pci_expander_bridge_common.h    |  29 +++
 hw/pci-bridge/pci_expander_bridge_cxl.c       | 201 ++++++++++++++++++
 hw/pci-bridge/pci_expander_bridge_stubs.c     |  14 --
 ...der_bridge.h => pci_expander_bridge_cxl.h} |   0
 7 files changed, 242 insertions(+), 202 deletions(-)
 create mode 100644 hw/pci-bridge/pci_expander_bridge_common.h
 create mode 100644 hw/pci-bridge/pci_expander_bridge_cxl.c
 delete mode 100644 hw/pci-bridge/pci_expander_bridge_stubs.c
 rename include/hw/pci-bridge/{pci_expander_bridge.h => pci_expander_bridge_cxl.h} (100%)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index e279ce5fe3a..cda4dfed50d 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -20,7 +20,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
 
 static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
                                            int index, Error **errp)
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index 2e0eb0d2332..aaeef64caaa 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -4,8 +4,8 @@ pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
-pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'),
-                               if_false: files('pci_expander_bridge_stubs.c'))
+pci_ss.add(when: 'CONFIG_PXB', if_true: files('pci_expander_bridge.c'))
+pci_ss.add(when: 'CONFIG_CXL', if_true: files('pci_expander_bridge_cxl.c'))
 pci_ss.add(when: 'CONFIG_XIO3130', if_true: files('xio3130_upstream.c', 'xio3130_downstream.c'))
 pci_ss.add(when: 'CONFIG_CXL', if_true: files('cxl_root_port.c', 'cxl_upstream.c', 'cxl_downstream.c'))
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e082..2498df480bd 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -18,57 +18,29 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
-
-enum BusType { PCI, PCIE, CXL };
+#include "pci_expander_bridge_common.h"
 
 #define TYPE_PXB_BUS "pxb-bus"
-typedef struct PXBBus PXBBus;
+
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
                          TYPE_PXB_BUS)
 
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
-                         TYPE_PXB_CXL_BUS)
-
-struct PXBBus {
-    /*< private >*/
-    PCIBus parent_obj;
-    /*< public >*/
-
-    char bus_path[8];
-};
-
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
 
 #define TYPE_PXB_HOST "pxb-host"
 
-CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return &host->cxl_cstate;
-}
-
-bool cxl_get_hb_passthrough(PCIHostState *hb)
-{
-    CXLHost *host = PXB_CXL_HOST(hb);
-
-    return host->passthrough;
-}
-
-static int pxb_bus_num(PCIBus *bus)
+int pxb_bus_num(PCIBus *bus)
 {
     PXBDev *pxb = PXB_DEV(bus->parent_dev);
 
@@ -96,7 +68,7 @@ static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &uid, errp);
 }
 
-static void pxb_bus_class_init(ObjectClass *class, const void *data)
+void pxb_bus_class_init(ObjectClass *class, const void *data)
 {
     PCIBusClass *pbc = PCI_BUS_CLASS(class);
 
@@ -123,20 +95,11 @@ static const TypeInfo pxb_pcie_bus_info = {
     .class_init    = pxb_bus_class_init,
 };
 
-static const TypeInfo pxb_cxl_bus_info = {
-    .name          = TYPE_PXB_CXL_BUS,
-    .parent        = TYPE_CXL_BUS,
-    .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
-};
-
 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
 {
-    PXBBus *bus = pci_bus_is_cxl(rootbus) ?
-                      PXB_CXL_BUS(rootbus) :
-                      pci_bus_is_express(rootbus) ? PXB_PCIE_BUS(rootbus) :
-                                                    PXB_BUS(rootbus);
+    PXBBus *bus = pci_bus_is_express(rootbus) ?
+        PXB_PCIE_BUS(rootbus) : PXB_BUS(rootbus);
 
     snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
     return bus->bus_path;
@@ -192,64 +155,6 @@ static const TypeInfo pxb_host_info = {
     .class_init    = pxb_host_class_init,
 };
 
-static void pxb_cxl_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    CXLHost *cxl = PXB_CXL_HOST(dev);
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-
-    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
-                                      TYPE_PXB_CXL_HOST);
-    sysbus_init_mmio(sbd, mr);
-}
-
-/*
- * Host bridge realization has no means of knowning state associated
- * with a particular machine. As such, it is nececssary to delay
- * final setup of the host bridge register space until later in the
- * machine bring up.
- */
-void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
-{
-    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
-    CXLHost *cxl = pxb->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
-    hwaddr offset;
-
-    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
-    if (offset > memory_region_size(&cxl_state->host_mr)) {
-        error_setg(errp, "Insufficient space for pxb cxl host register space");
-        return;
-    }
-
-    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
-    cxl_state->next_mr_idx++;
-}
-
-static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(class);
-    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
-
-    hc->root_bus_path = pxb_host_root_bus_path;
-    dc->fw_name = "cxl";
-    dc->realize = pxb_cxl_realize;
-    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
-    dc->user_creatable = false;
-}
-
-/*
- * This is a device to handle the MMIO for a CXL host bridge. It does nothing
- * else.
- */
-static const TypeInfo cxl_host_info = {
-    .name          = TYPE_PXB_CXL_HOST,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(CXLHost),
-    .class_init    = pxb_cxl_host_class_init,
-};
 
 /*
  * Registers the PXB bus as a child of pci host root bus.
@@ -297,34 +202,6 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
     return pin - PCI_SLOT(pxb->devfn);
 }
 
-static void pxb_cxl_dev_reset(DeviceState *dev)
-{
-    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
-    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
-    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
-    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
-    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
-    int dsp_count = 0;
-
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
-    /*
-     * The CXL specification allows for host bridges with no HDM decoders
-     * if they only have a single root port.
-     */
-    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
-        dsp_count = pcie_count_ds_ports(hb->bus);
-    }
-    /* Initial reset will have 0 dsp so wait until > 0 */
-    if (dsp_count == 1) {
-        cxl->passthrough = true;
-        /* Set Capability ID in header to NONE */
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
-    } else {
-        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
-                         8);
-    }
-}
-
 static gint pxb_compare(gconstpointer a, gconstpointer b)
 {
     const PXBDev *pxb_a = a, *pxb_b = b;
@@ -334,8 +211,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
-                                   Error **errp)
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
     DeviceState *ds, *bds = NULL;
@@ -417,7 +294,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
     pxb_dev_realize_common(dev, PCI, errp);
 }
 
-static void pxb_dev_exitfn(PCIDevice *pci_dev)
+void pxb_dev_exitfn(PCIDevice *pci_dev)
 {
     PXBDev *pxb = PXB_DEV(pci_dev);
 
@@ -496,67 +373,14 @@ static const TypeInfo pxb_pcie_dev_info = {
     },
 };
 
-static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
-{
-    /* A CXL PXB's parent bus is still PCIe */
-    if (!pci_bus_is_express(pci_get_bus(dev))) {
-        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
-        return;
-    }
-
-    if (!pxb_dev_realize_common(dev, CXL, errp)) {
-        return;
-    }
-    pxb_cxl_dev_reset(DEVICE(dev));
-}
-
-static const Property pxb_cxl_dev_properties[] = {
-    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
-};
-
-static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc   = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize             = pxb_cxl_dev_realize;
-    k->exit                = pxb_dev_exitfn;
-    /*
-     * XXX: These types of bridges don't actually show up in the hierarchy so
-     * vendor, device, class, etc. ids are intentionally left out.
-     */
-
-    dc->desc = "CXL Host Bridge";
-    device_class_set_props(dc, pxb_cxl_dev_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-
-    /* Host bridges aren't hotpluggable. FIXME: spec reference */
-    dc->hotpluggable = false;
-    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
-}
-
-static const TypeInfo pxb_cxl_dev_info = {
-    .name          = TYPE_PXB_CXL_DEV,
-    .parent        = TYPE_PXB_PCIE_DEV,
-    .instance_size = sizeof(PXBCXLDev),
-    .class_init    = pxb_cxl_dev_class_init,
-    .interfaces =
-        (const InterfaceInfo[]){
-            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-            {},
-        },
-};
 
 static void pxb_register_types(void)
 {
     type_register_static(&pxb_bus_info);
     type_register_static(&pxb_pcie_bus_info);
-    type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
-    type_register_static(&pxb_cxl_dev_info);
 }
 
 type_init(pxb_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_common.h b/hw/pci-bridge/pci_expander_bridge_common.h
new file mode 100644
index 00000000000..fc5d1ac8691
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_common.h
@@ -0,0 +1,29 @@
+/*
+ * PCI Expander Bridge Device Emulation Common Code
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+enum BusType { PCI, PCIE, CXL };
+
+typedef struct PXBBus PXBBus;
+
+struct PXBBus {
+    /*< private >*/
+    PCIBus parent_obj;
+    /*< public >*/
+
+    char bus_path[8];
+};
+
+int pxb_bus_num(PCIBus *bus);
+void pxb_bus_class_init(ObjectClass *class, const void *data);
+bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                            Error **errp);
+void pxb_dev_exitfn(PCIDevice *pci_dev);
diff --git a/hw/pci-bridge/pci_expander_bridge_cxl.c b/hw/pci-bridge/pci_expander_bridge_cxl.c
new file mode 100644
index 00000000000..3294baeaf99
--- /dev/null
+++ b/hw/pci-bridge/pci_expander_bridge_cxl.c
@@ -0,0 +1,201 @@
+/*
+ * CXL PCI Expander Bridge Device Emulation
+ *
+ * Copyright (C) 2015 Red Hat Inc
+ *
+ * Authors:
+ *   Marcel Apfelbaum <marcel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/pci-bridge/pci_expander_bridge_cxl.h"
+#include "qom/object.h"
+#include "pci_expander_bridge_common.h"
+
+DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
+                         TYPE_PXB_CXL_BUS)
+
+CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return &host->cxl_cstate;
+}
+
+bool cxl_get_hb_passthrough(PCIHostState *hb)
+{
+    CXLHost *host = PXB_CXL_HOST(hb);
+
+    return host->passthrough;
+}
+
+static const char *pxb_cxl_host_root_bus_path(PCIHostState *host_bridge,
+                                              PCIBus *rootbus)
+{
+    PXBBus *bus = PXB_CXL_BUS(rootbus);
+    snprintf(bus->bus_path, 8, "0000:%02x", pxb_bus_num(rootbus));
+    return bus->bus_path;
+}
+
+
+static const TypeInfo pxb_cxl_bus_info = {
+    .name          = TYPE_PXB_CXL_BUS,
+    .parent        = TYPE_CXL_BUS,
+    .instance_size = sizeof(PXBBus),
+    .class_init    = pxb_bus_class_init,
+};
+
+static void pxb_cxl_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CXLHost *cxl = PXB_CXL_HOST(dev);
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+
+    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
+                                      TYPE_PXB_CXL_HOST);
+    sysbus_init_mmio(sbd, mr);
+}
+
+/*
+ * Host bridge realization has no means of knowning state associated
+ * with a particular machine. As such, it is nececssary to delay
+ * final setup of the host bridge register space until later in the
+ * machine bring up.
+ */
+void pxb_cxl_hook_up_registers(CXLState *cxl_state, PCIBus *bus, Error **errp)
+{
+    PXBCXLDev *pxb =  PXB_CXL_DEV(pci_bridge_get_device(bus));
+    CXLHost *cxl = pxb->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
+    hwaddr offset;
+
+    offset = memory_region_size(mr) * cxl_state->next_mr_idx;
+    if (offset > memory_region_size(&cxl_state->host_mr)) {
+        error_setg(errp, "Insufficient space for pxb cxl host register space");
+        return;
+    }
+
+    memory_region_add_subregion(&cxl_state->host_mr, offset, mr);
+    cxl_state->next_mr_idx++;
+}
+
+static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = pxb_cxl_host_root_bus_path;
+    dc->fw_name = "cxl";
+    dc->realize = pxb_cxl_realize;
+    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
+    dc->user_creatable = false;
+}
+
+/*
+ * This is a device to handle the MMIO for a CXL host bridge. It does nothing
+ * else.
+ */
+static const TypeInfo cxl_host_info = {
+    .name          = TYPE_PXB_CXL_HOST,
+    .parent        = TYPE_PCI_HOST_BRIDGE,
+    .instance_size = sizeof(CXLHost),
+    .class_init    = pxb_cxl_host_class_init,
+};
+
+static void pxb_cxl_dev_reset(DeviceState *dev)
+{
+    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
+    PCIHostState *hb = PCI_HOST_BRIDGE(cxl);
+    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
+    uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
+    int dsp_count = 0;
+
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC, false);
+    /*
+     * The CXL specification allows for host bridges with no HDM decoders
+     * if they only have a single root port.
+     */
+    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
+        dsp_count = pcie_count_ds_ports(hb->bus);
+    }
+    /* Initial reset will have 0 dsp so wait until > 0 */
+    if (dsp_count == 1) {
+        cxl->passthrough = true;
+        /* Set Capability ID in header to NONE */
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
+    } else {
+        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT,
+                         8);
+    }
+}
+
+static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
+{
+    /* A CXL PXB's parent bus is still PCIe */
+    if (!pci_bus_is_express(pci_get_bus(dev))) {
+        error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
+        return;
+    }
+
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
+    pxb_cxl_dev_reset(DEVICE(dev));
+}
+
+static const Property pxb_cxl_dev_properties[] = {
+    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBCXLDev, hdm_for_passthrough, false),
+};
+
+static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc   = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize             = pxb_cxl_dev_realize;
+    k->exit                = pxb_dev_exitfn;
+    /*
+     * XXX: These types of bridges don't actually show up in the hierarchy so
+     * vendor, device, class, etc. ids are intentionally left out.
+     */
+
+    dc->desc = "CXL Host Bridge";
+    device_class_set_props(dc, pxb_cxl_dev_properties);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+
+    /* Host bridges aren't hotpluggable. FIXME: spec reference */
+    dc->hotpluggable = false;
+    device_class_set_legacy_reset(dc, pxb_cxl_dev_reset);
+}
+
+static const TypeInfo pxb_cxl_dev_info = {
+    .name          = TYPE_PXB_CXL_DEV,
+    .parent        = TYPE_PXB_PCIE_DEV,
+    .instance_size = sizeof(PXBCXLDev),
+    .class_init    = pxb_cxl_dev_class_init,
+    .interfaces =
+        (const InterfaceInfo[]){
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            {},
+        },
+};
+
+static void pxb_cxl_register_types(void)
+{
+    type_register_static(&pxb_cxl_bus_info);
+    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_dev_info);
+}
+
+type_init(pxb_cxl_register_types)
diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
deleted file mode 100644
index b35180311f6..00000000000
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * Stubs for calls made from machines to handle the case where CONFIG_PXB
- * is not enabled.
- */
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/pci/pci.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
-#include "hw/cxl/cxl.h"
-
-void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge_cxl.h
similarity index 100%
rename from include/hw/pci-bridge/pci_expander_bridge.h
rename to include/hw/pci-bridge/pci_expander_bridge_cxl.h
-- 
2.55.0


