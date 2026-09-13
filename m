Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFD9C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nwt-0003JZ-F4; Sun, 13 Sep 2026 13:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nUO-00009X-Js; Sun, 13 Sep 2026 12:55:36 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nU3-000585-G0; Sun, 13 Sep 2026 12:55:36 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE0B443206;
 Sun, 13 Sep 2026 16:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F5E1F000FF;
 Sun, 13 Sep 2026 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318505;
 bh=5NyVIXNG3+KNNQU0msAuaxe/FwKciiptg8/fqS8RKxg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S/9vEqYmUNqhSm+kgQwB0Z348+0vvDKjsYFmeT9+kPVtLSdodklxY6HQLeKD49HP2
 mnkKP4/arGU8wgK997abA7TBcH0QZp4QfxqSuGI8z0y2kyrt4LUwFJ36hbqvmh2xgV
 BvVJAUhgAL/qJnlVJiT05K05MaiXbjFjNB83Ij3aCXnMSrpNn5ckZx0Ww59zVaHbmA
 2KZhNJC8G9BBHXr6ieats975KPisoc6FAMZ8eEfdUJdrYvtONVLjx+MFTB6uPfxyxD
 yJYcVRVRvkuCP+g4C3jAmfvS39LDaBgj8ZN3lbAZ8jJqtkR8z9vewDb3rDto5/Z85z
 hhPF+mbkdeOBQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Sun, 13 Sep 2026 18:54:52 +0200
Subject: [PATCH 2/4] hw/pci: Add PCIe Endpoint Function device
 (pcie-ep-generic)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pcie-ep-emulation-v1-2-b8e8f74a5842@kernel.org>
References: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
In-Reply-To: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14146; i=mani@kernel.org;
 h=from:subject:message-id; bh=I53d1G4GXWlUzGEeJ8C77L2YAMKyb9xnDeAutxGDkM8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqptVg9/1zQ3mYw1fpvNLZFnBJRT9vYzcAfTECA
 mpKAsAtz4uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqbVYAAKCRBVnxHm/pHO
 9YjjB/9EFe/RwFnCATGfh8MMzuPXSLz/YwKNJNFsB+5cRXSQ/gq5PO9B6rVYVZyyK8tsSMQTczg
 s0TvQuAOx9WEyG6YXwUGfOYQ8ws5RMepsUVM196WWhN2+Q5axZy2piyLN5yLDtsEEiQxOPAwB6G
 JIN1zhEu7w7+eBXleOxg9ASqYt4mhv2+hQHOcHr7Y6KSAWYWBUQ/lxaGQnzodyJQYYYdv6DMxKi
 50gHAyUqgslZBQJo9jL8LlthSV3tbCt5biBWVp/K/cEkuyKtafpJtm4bUBw/moH4YDKkwDQOt5W
 018bC4qUiPLSGU2rRcl/gAkte+CTP+V1dZuZ6NgWmfO8+y1S
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mani@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 13:24:48 -0400
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add the PCIe Endpoint Function device driven by the pcie-ep-ctrl
Endpoint Controller.

The device is created programmatically by the controller and hotplugged
onto a PCIe Root Port when the Link comes up. It is not instantiable
with -device.

Its PCI identity, BAR layout and interrupt capabilities all come from
the controller, which programs them from the register writes issued by
the pci-ep-generic Linux EPC driver.

Each enabled BAR is a memory region alias onto guest RAM at the address
the controller was given. This way, the Endpoint Function and the host
share the same backing memory without any copying.

Interrupts raised by the controller are delivered to the host through
msi_notify(), msix_notify() or a legacy INTx toggle.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS                      |   2 +
 hw/pci/Kconfig                   |   4 +
 hw/pci/meson.build               |   1 +
 hw/pci/pcie-ep-generic.c         | 255 +++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie-ep-generic.h |  71 +++++++++++
 5 files changed, 333 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e241f206bc..498569bfe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2174,6 +2174,8 @@ PCIe Endpoint Emulation
 M: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
 S: Maintained
 F: docs/system/devices/pcie-ep.rst
+F: hw/pci/pcie-ep-generic.c
+F: include/hw/pci/pcie-ep-generic.h
 
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
index fe70902cd8..c5719ec937 100644
--- a/hw/pci/Kconfig
+++ b/hw/pci/Kconfig
@@ -11,6 +11,10 @@ config PCI_DEVICES
 config PCIE_DEVICES
     bool
 
+config PCIE_EP_GENERIC
+    bool
+    select PCI_EXPRESS
+
 config MSI_NONBROKEN
     # selected by interrupt controllers that do not support MSI,
     # or support it and have a good implementation. See commit
diff --git a/hw/pci/meson.build b/hw/pci/meson.build
index a6cbd89c0a..e1c1081c98 100644
--- a/hw/pci/meson.build
+++ b/hw/pci/meson.build
@@ -17,6 +17,7 @@ pci_ss.add(files(
 pci_ss.add(files('pcie.c', 'pcie_aer.c'))
 pci_ss.add(files('pcie_doe.c'))
 system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c', 'pcie_host.c'))
+system_ss.add(when: 'CONFIG_PCIE_EP_GENERIC', if_true: files('pcie-ep-generic.c'))
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
 
 stub_ss.add(files('pci-stub.c'))
diff --git a/hw/pci/pcie-ep-generic.c b/hw/pci/pcie-ep-generic.c
new file mode 100644
index 0000000000..5a1929486c
--- /dev/null
+++ b/hw/pci/pcie-ep-generic.c
@@ -0,0 +1,255 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Endpoint Function device (pcie-ep-generic).
+ *
+ * Created programmatically by pcie-ep-ctrl and hotplugged onto a PCIe Root
+ * Port when the EP driver brings the Link up. Its PCI identity, BAR layout
+ * and interrupt capabilities come from a PCIeEPConfig handed over
+ * before realize. Because it is realised after machine initialisation,
+ * dev->hotplugged is true and pcie_cap_slot_plug_cb() fires the PDC interrupt
+ * so pciehp on the RC guest enumerates it.
+ *
+ * Each BAR aliases normal guest RAM at the address the Endpoint Controller
+ * programmed (the Function's dma_alloc_coherent buffer), so the RC host and
+ * the Endpoint Function share one address space with no copying. The BAR is
+ * a small container holding a low-priority RAM alias, which lets msix_init()
+ * overlay its table and PBA on top for the MSI-X BAR.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pcie-ep-generic.h"
+#include "system/address-spaces.h"
+#include "migration/vmstate.h"
+
+/* PCIe / MSI capability offsets in the Endpoint's Configuration Space. */
+#define EP_PCIE_CAP_OFFSET  0x80
+#define EP_MSI_CAP_OFFSET   0x60
+
+OBJECT_DECLARE_SIMPLE_TYPE(PCIeEPState, PCIE_EP_ENDPOINT)
+
+struct PCIeEPState {
+    PCIDevice parent_obj;
+
+    PCIeEPConfig cfg;
+
+    /*
+     * Each BAR is a container holding a RAM alias (and, on the MSI-X BAR, the
+     * msix table/PBA subregions added by msix_init()).
+     */
+    MemoryRegion bar_mr[PCI_STD_NUM_BARS];
+    MemoryRegion bar_alias[PCI_STD_NUM_BARS];
+};
+
+void pcie_ep_endpoint_set_config(DeviceState *dev,
+                                 const PCIeEPConfig *cfg)
+{
+    PCIeEPState *ep = PCIE_EP_ENDPOINT(dev);
+
+    ep->cfg = *cfg;
+}
+
+void pcie_ep_endpoint_raise_irq(DeviceState *dev, uint32_t irq_type,
+                                uint32_t irq_num)
+{
+    PCIDevice *pdev = PCI_DEVICE(dev);
+    unsigned vector = irq_num ? irq_num - 1 : 0;
+
+    switch (irq_type) {
+    case PCIE_EP_IRQ_INTX:
+        pci_set_irq(pdev, 1);
+        pci_set_irq(pdev, 0);
+        break;
+    case PCIE_EP_IRQ_MSI:
+        if (msi_enabled(pdev)) {
+            msi_notify(pdev, vector);
+        }
+        break;
+    case PCIE_EP_IRQ_MSIX:
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, vector);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pcie-ep-generic: unknown IRQ type %u\n", irq_type);
+        break;
+    }
+}
+
+void pcie_ep_endpoint_get_msi_state(DeviceState *dev, PCIeEPMsiState *out)
+{
+    PCIDevice *pdev = PCI_DEVICE(dev);
+
+    memset(out, 0, sizeof(*out));
+
+    if (msi_enabled(pdev) && pdev->msi_cap) {
+        uint16_t ctl = pci_get_word(pdev->config + pdev->msi_cap +
+                                    PCI_MSI_FLAGS);
+        uint8_t mme = (ctl & PCI_MSI_FLAGS_QSIZE) >> 4;
+        MSIMessage m = msi_get_message(pdev, 0);
+
+        out->msi_vectors = 1u << mme;
+        out->msi_addr_lo = (uint32_t)m.address;
+        out->msi_addr_hi = (uint32_t)(m.address >> 32);
+        out->msi_data = m.data;
+    }
+
+    if (msix_enabled(pdev)) {
+        out->msix_vectors = pdev->msix_entries_nr;
+    }
+}
+
+static void pcie_ep_endpoint_realize(PCIDevice *pdev, Error **errp)
+{
+    PCIeEPState *ep = PCIE_EP_ENDPOINT(pdev);
+    PCIeEPConfig *cfg = &ep->cfg;
+    int i;
+
+    /* Apply PCI identity from the staged Header. */
+    pci_config_set_vendor_id(pdev->config, cfg->vendor_id);
+    pci_config_set_device_id(pdev->config, cfg->device_id);
+    pci_config_set_revision(pdev->config, cfg->rev_id);
+    pci_config_set_class(pdev->config, (uint16_t)(cfg->base_class << 8) |
+                                                   cfg->sub_class);
+    pci_config_set_prog_interface(pdev->config, cfg->progif);
+    pci_set_word(pdev->config + PCI_SUBSYSTEM_VENDOR_ID, cfg->subsys_vendor_id);
+    pci_set_word(pdev->config + PCI_SUBSYSTEM_ID, cfg->subsys_id);
+    pci_config_set_interrupt_pin(pdev->config,
+                                 cfg->interrupt_pin ? cfg->interrupt_pin : 1);
+
+    if (pcie_endpoint_cap_init(pdev, EP_PCIE_CAP_OFFSET) < 0) {
+        error_setg(errp, "pcie-ep-generic: failed to init PCIe capability");
+        return;
+    }
+
+    if (cfg->num_msi > 0) {
+        if (msi_init(pdev, EP_MSI_CAP_OFFSET, cfg->num_msi,
+                     true, false, errp) < 0) {
+            goto err_pcie_cap;
+        }
+    }
+
+    /*
+     * BARs alias guest RAM at the controller-programmed address. Use a
+     * container with the RAM alias at low priority so msix_init() can overlay
+     * the MSI-X table and PBA on the designated BAR.
+     */
+    for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+        char name[32];
+
+        if (!cfg->bar[i].enabled || cfg->bar[i].size == 0) {
+            continue;
+        }
+
+        snprintf(name, sizeof(name), "pcie-ep-bar%d", i);
+        memory_region_init(&ep->bar_mr[i], OBJECT(ep), name, cfg->bar[i].size);
+
+        snprintf(name, sizeof(name), "pcie-ep-bar%d-ram", i);
+        memory_region_init_alias(&ep->bar_alias[i], OBJECT(ep), name,
+                                 get_system_memory(), cfg->bar[i].phys,
+                                 cfg->bar[i].size);
+        memory_region_add_subregion_overlap(&ep->bar_mr[i], 0,
+                                            &ep->bar_alias[i], -1);
+
+        pci_register_bar(pdev, i,
+                         cfg->bar[i].flags & (PCI_BASE_ADDRESS_MEM_TYPE_64  |
+                                              PCI_BASE_ADDRESS_MEM_PREFETCH |
+                                              PCI_BASE_ADDRESS_SPACE),
+                         &ep->bar_mr[i]);
+    }
+
+    /* MSI-X Capability, table lives in the designated BAR */
+    if (cfg->num_msix > 0 && cfg->msix_bar < PCI_STD_NUM_BARS
+        && cfg->bar[cfg->msix_bar].enabled) {
+        uint32_t pba_offset = cfg->msix_offset +
+                              cfg->num_msix * PCI_MSIX_ENTRY_SIZE;
+        if (msix_init(pdev, cfg->num_msix,
+                      &ep->bar_mr[cfg->msix_bar], cfg->msix_bar,
+                      cfg->msix_offset,
+                      &ep->bar_mr[cfg->msix_bar], cfg->msix_bar,
+                      pba_offset, 0, errp) < 0) {
+            goto err_msi;
+        }
+    }
+
+    return;
+
+    /*
+     * QEMU does not call ->exit on realize failure, so undo the capabilities
+     * here. BAR regions are owned by this object and freed on finalise.
+     */
+err_msi:
+    msi_uninit(pdev);
+err_pcie_cap:
+    pcie_cap_exit(pdev);
+}
+
+static void pcie_ep_endpoint_exit(PCIDevice *pdev)
+{
+    PCIeEPState *ep = PCIE_EP_ENDPOINT(pdev);
+    PCIeEPConfig *cfg = &ep->cfg;
+
+    if (cfg->num_msix > 0 && cfg->msix_bar < PCI_STD_NUM_BARS
+        && cfg->bar[cfg->msix_bar].enabled) {
+        msix_uninit(pdev,
+                    &ep->bar_mr[cfg->msix_bar],
+                    &ep->bar_mr[cfg->msix_bar]);
+    }
+    msi_uninit(pdev);
+    pcie_cap_exit(pdev);
+}
+
+/*
+ * The Endpoint is created programmatically at runtime and mirrors live EP
+ * state, so it is not migratable.
+ */
+static const VMStateDescription vmstate_pcie_ep_endpoint = {
+    .name = "pcie-ep-generic",
+    .unmigratable = 1,
+};
+
+static void pcie_ep_endpoint_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
+
+    k->realize = pcie_ep_endpoint_realize;
+    k->exit = pcie_ep_endpoint_exit;
+    /* Placeholder identity, overwritten in realize() from staged config */
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = 0x0001;
+    k->class_id = PCI_CLASS_OTHERS;
+
+    dc->desc = "PCIe Endpoint Function (dynamically configured)";
+    dc->vmsd = &vmstate_pcie_ep_endpoint;
+    /*
+     * Created programmatically by pcie-ep-ctrl at link-up, not via -device:
+     * its PCI identity and BAR layout are only known at runtime.
+     */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo pcie_ep_endpoint_info = {
+    .name = TYPE_PCIE_EP_ENDPOINT,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PCIeEPState),
+    .class_init = pcie_ep_endpoint_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void pcie_ep_generic_register_types(void)
+{
+    type_register_static(&pcie_ep_endpoint_info);
+}
+type_init(pcie_ep_generic_register_types)
diff --git a/include/hw/pci/pcie-ep-generic.h b/include/hw/pci/pcie-ep-generic.h
new file mode 100644
index 0000000000..4560852080
--- /dev/null
+++ b/include/hw/pci/pcie-ep-generic.h
@@ -0,0 +1,71 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * PCIe Endpoint Function device definitions.
+ */
+
+#ifndef HW_PCI_PCIE_EP_GENERIC_H
+#define HW_PCI_PCIE_EP_GENERIC_H
+
+#include "hw/pci/pci.h"
+#include "hw/core/qdev.h"
+
+#define TYPE_PCIE_EP_ENDPOINT "pcie-ep-generic"
+
+/*
+ * IRQ type codes written by the EP driver to the controller's IRQ_TYPE
+ * register. They match PCI_IRQ_INTX / _MSI / _MSIX in include/linux/pci.h.
+ */
+#define PCIE_EP_IRQ_INTX    1
+#define PCIE_EP_IRQ_MSI     2
+#define PCIE_EP_IRQ_MSIX    4
+
+/* Per-BAR description handed to the Endpoint at creation. */
+typedef struct PCIeEPBarConfig {
+    bool enabled;
+    uint64_t phys; /* guest-RAM address the BAR aliases */
+    uint64_t size;
+    uint32_t flags; /* PCI_BASE_ADDRESS_* flags */
+} PCIeEPBarConfig;
+
+/* Full Endpoint identity and resources, populated by pcie-ep-ctrl. */
+typedef struct PCIeEPConfig {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t subsys_vendor_id;
+    uint16_t subsys_id;
+    uint8_t base_class;
+    uint8_t sub_class;
+    uint8_t progif;
+    uint8_t rev_id;
+    uint8_t interrupt_pin;
+
+    PCIeEPBarConfig bar[PCI_STD_NUM_BARS];
+
+    uint8_t num_msi;
+    uint16_t num_msix;
+    uint8_t msix_bar;
+    uint32_t msix_offset;
+} PCIeEPConfig;
+
+/* Live MSI/MSI-X negotiation state read back from the RC. */
+typedef struct PCIeEPMsiState {
+    uint32_t msi_vectors;    /* 0 if MSI not enabled by the RC */
+    uint32_t msix_vectors;   /* 0 if MSI-X not enabled by the RC */
+    uint32_t msi_addr_lo;
+    uint32_t msi_addr_hi;
+    uint32_t msi_data;
+} PCIeEPMsiState;
+
+/* Hand staged config to a freshly created Endpoint before realize. */
+void pcie_ep_endpoint_set_config(DeviceState *dev,
+                                 const PCIeEPConfig *cfg);
+
+/* Deliver an interrupt (type = PCIE_EP_IRQ_*) from the Function to the RC. */
+void pcie_ep_endpoint_raise_irq(DeviceState *dev, uint32_t irq_type,
+                                uint32_t irq_num);
+
+/* Read the live MSI/MSI-X negotiation state for the readback registers. */
+void pcie_ep_endpoint_get_msi_state(DeviceState *dev, PCIeEPMsiState *out);
+
+#endif /* HW_PCI_PCIE_EP_GENERIC_H */

-- 
2.43.0


