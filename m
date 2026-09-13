Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B543C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 17:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5nx1-0003KY-Tv; Sun, 13 Sep 2026 13:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nUJ-00008h-QO; Sun, 13 Sep 2026 12:55:31 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mani@kernel.org>)
 id 1x5nTy-00058z-JZ; Sun, 13 Sep 2026 12:55:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A71EA60E83;
 Sun, 13 Sep 2026 16:55:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469C61F000FF;
 Sun, 13 Sep 2026 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789318508;
 bh=/f8fJN8D/L2bVeRYiiTfC0o/SyyYyO/TPZro9450q1w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kps9P8HZiIvg5FKXJyvFV8pwP6WuMIRWkxkSNncQvdXAvgW6JURbOL/cXRc+LmSev
 zBDjhCHUjFLwAx1xkF/aZ4GhPc64wbTTDxDYnaOQdt2m9Rr15/1v4tjtYCl7qT/+yb
 7X6IzMIL+jfD7YRpy4JMf+UKHFFrd7s6ivNlGIfj4dVE6lCfkTNYp9wIG6io58b0bm
 9MK37PapHrUAfykIH8ipUD56kXcscU3KU+iFS0iiAdt7lnL3Z2rpuNpZSXVaUhUu7A
 SmLJ86ooAHkKSxvZUYlnAwsMQAOjrFsTHz+mZoA96oG4VE92EZkbWC5OL19HQXWtse
 KlhhXCd2LYsIQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Date: Sun, 13 Sep 2026 18:54:53 +0200
Subject: [PATCH 3/4] hw/misc: Add PCIe Endpoint Controller emulation
 (pcie-ep-ctrl)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-pcie-ep-emulation-v1-3-b8e8f74a5842@kernel.org>
References: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
In-Reply-To: <20260913-pcie-ep-emulation-v1-0-b8e8f74a5842@kernel.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27273; i=mani@kernel.org;
 h=from:subject:message-id; bh=TCB97PZx7M6wYpJUrwTEDqBLQ2VW59yu7HFjkeAXRFY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqptVgPpWvg1slQhmJsbEZv48kGfgOxnyQ2ao7n
 AwPky2CfpuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaqbVYAAKCRBVnxHm/pHO
 9esiCACg0V4QSqg5pPdVwJLl1ibc1fbg9+JEbbSiKjD0PToNaXiTRgU23U7+GZPrfXiSjgfh7ZC
 gwhVv9oJWSWOYJ7vTR+7zcW9jI/kq0hFSVYtJhwXMvgZPiCBivEWUzvy2VRABT71p9myk1vzcXd
 OHBehbmCfV23y2wt2no47Bkan4n3s/fRTSAiyM7lbjQM73AoIesVORh8bbDp+0Ybz5zv28QOGV3
 lTq7z85EXRhotnaRzC0MvkCKD0m5ixyxtfmtsdL1ZjpVinzlr5ZbXJ9Feg7D5502SHPDszEUZeS
 B40DnJRwm3x6uBVg6dOCjkKzynGuMkEFU9PDjTKN2j8bIxEl
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
Received-SPF: pass client-ip=172.105.4.254; envelope-from=mani@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 13:24:47 -0400
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

Add a SysBus platform device that emulates a PCIe Endpoint Controller
(EPC) for use with the Linux PCI Endpoint framework.

It exposes an MMIO register interface compatible with the
pci-ep-generic Linux EPC driver. The register file is a plain
scratchpad. A command register at offset 0xf0 accepts opcodes
(WRITE_HEADER, SET_BAR, CLEAR_BAR, MAP, UNMAP, SET_MSI, SET_MSIX,
RAISE_IRQ, START, STOP) and the controller only acts when the driver
writes an opcode to it. The driver stages every field it needs and
issues one command write to commit. A small set of read-only registers
(CAPS, MAX_FUNC, LINKUP, MSI/MSI-X readback and MSI address/data)
reports firmware-configured or live-negotiated state.

The controller also acts as the orchestrator for the Endpoint Function.
On CMD_START it builds a pcie-ep-generic Function from the staged
registers and hotplugs it onto the Root Port named by the target-bus
property. CMD_STOP unplugs it again. Because qdev_realize must not run
inline from an MMIO write handler, the hotplug work is deferred to a
bottom half.

Everything runs inside a single QEMU instance. The controller drives
the Endpoint with direct in-process calls instead of any inter-process
protocol. Outbound address maps are memory region aliases onto guest
RAM. Interrupts are raised straight on the Endpoint Function. This
allows one guest kernel to act as both the Endpoint Controller and the
PCI host that enumerates the resulting Function.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS                    |   2 +
 hw/misc/Kconfig                |   4 +
 hw/misc/meson.build            |   1 +
 hw/misc/pcie-ep-ctrl.c         | 662 +++++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pcie-ep-ctrl.h |  68 +++++
 5 files changed, 737 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 498569bfe1..eb0fe6b0a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2176,6 +2176,8 @@ S: Maintained
 F: docs/system/devices/pcie-ep.rst
 F: hw/pci/pcie-ep-generic.c
 F: include/hw/pci/pcie-ep-generic.h
+F: hw/misc/pcie-ep-ctrl.c
+F: include/hw/misc/pcie-ep-ctrl.h
 
 ARM PCI Hotplug
 M: Gustavo Romero <gustavo.romero@linaro.org>
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..b80c81281e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -224,6 +224,10 @@ config SIFIVE_U_PRCI
 config VIRT_CTRL
     bool
 
+config PCIE_EP_CTRL
+    bool
+    select PCIE_EP_GENERIC
+
 config LASI
     bool
     select LASI_82596
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 23265f6035..428d51fd90 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -26,6 +26,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
 # virt devices
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
+system_ss.add(when: 'CONFIG_PCIE_EP_CTRL', if_true: files('pcie-ep-ctrl.c'))
 
 # RISC-V devices
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
diff --git a/hw/misc/pcie-ep-ctrl.c b/hw/misc/pcie-ep-ctrl.c
new file mode 100644
index 0000000000..d0b5a78cb4
--- /dev/null
+++ b/hw/misc/pcie-ep-ctrl.c
@@ -0,0 +1,662 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU PCIe Endpoint Controller device.
+ *
+ * Platform device that gives the guest an MMIO register interface for an
+ * Endpoint Controller. The Linux pci-ep-generic.c EPC driver binds to it and
+ * drives the usual Endpoint framework flow. It writes the PCI Header, sizes
+ * the BARs, programs MSI/MSI-X and finally brings the Link up.
+ *
+ * Everything happens inside a single QEMU instance. When the driver brings
+ * the Link up this controller creates a pcie-ep-generic PCI Function and
+ * hotplugs it onto a Root Port named by the "target-bus" property, so the same
+ * guest that runs the controller also enumerates the Endpoint as a host. The
+ * Endpoint BARs and the outbound DMA window are plain aliases into guest RAM,
+ * so both sides share one address space with no copying and no IPC.
+ *
+ * Register layout matches the PCI_EPC_GEN_* offsets in
+ * drivers/pci/controller/pci-ep-generic.c.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "qemu/main-loop.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/pcie-ep-ctrl.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie-ep-generic.h"
+#include "hw/core/hotplug.h"
+#include "system/address-spaces.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+
+/*
+ * Register offsets (must match PCI_EPC_GEN_* in pci-ep-generic.c)
+ *
+ * The register file is a plain scratchpad. Nothing happens until the driver
+ * writes an opcode to EPCTRL_CMD, at which point the controller acts on the
+ * staged values. Ordering between staging writes does not matter.
+ */
+
+/* Firmware-initialised, read-only from the driver's perspective */
+#define EPCTRL_CAPS         0x00
+#define   EPCTRL_CAP_MSI                (1u << 1)
+#define   EPCTRL_CAP_MSIX               (1u << 2)
+#define   EPCTRL_CAP_DYN_INBOUND_MAP    (1u << 4)
+#define   EPCTRL_CAP_SUBRANGE           (1u << 5)
+#define EPCTRL_MAX_FUNC     0x04
+
+/* Link state, read-only status reflecting the last CMD_START / CMD_STOP */
+#define EPCTRL_LINKUP       0x10
+
+/* Scratchpad registers staged by the driver */
+#define EPCTRL_FUNC_NO      0x18
+#define EPCTRL_BAR_NO       0x1c
+#define EPCTRL_IRQ_TYPE     0x20
+#define EPCTRL_IRQ_NUM      0x24
+#define EPCTRL_HDR_VID      0x30
+#define EPCTRL_HDR_DID      0x34
+#define EPCTRL_HDR_SVID     0x38
+#define EPCTRL_HDR_SSID     0x3c
+#define EPCTRL_HDR_CLASS    0x40  /* [23:16] base, [15:8] sub, [7:0] progif */
+#define EPCTRL_HDR_REV      0x44
+#define EPCTRL_HDR_INTPIN   0x48
+#define EPCTRL_BAR_PHYS_LO  0x50
+#define EPCTRL_BAR_PHYS_HI  0x54
+#define EPCTRL_BAR_SIZE_LO  0x58
+#define EPCTRL_BAR_SIZE_HI  0x5c
+#define EPCTRL_BAR_FLAGS    0x60
+#define EPCTRL_MAP_PHYS_LO  0x70
+#define EPCTRL_MAP_PHYS_HI  0x74
+#define EPCTRL_MAP_PCI_LO   0x78
+#define EPCTRL_MAP_PCI_HI   0x7c
+#define EPCTRL_MAP_SIZE_LO  0x80
+#define EPCTRL_MAP_SIZE_HI  0x84
+#define EPCTRL_MSI_COUNT    0x90
+#define EPCTRL_MSIX_BAR     0x94
+#define EPCTRL_MSIX_OFFSET  0x98
+/* Negotiated values reported back to the driver, computed live on read */
+#define EPCTRL_MSI_READBACK     0xa0
+#define EPCTRL_MSIX_READBACK    0xa4
+#define EPCTRL_MSI_ADDR_LO      0xb0
+#define EPCTRL_MSI_ADDR_HI      0xb4
+#define EPCTRL_MSI_DATA         0xb8
+
+/* Command register: the driver writes an opcode here to commit staged state */
+#define EPCTRL_CMD              0xf0
+#define   EPCTRL_CMD_WRITE_HEADER   0x01
+#define   EPCTRL_CMD_SET_BAR        0x02
+#define   EPCTRL_CMD_CLEAR_BAR      0x03
+#define   EPCTRL_CMD_MAP            0x04
+#define   EPCTRL_CMD_UNMAP          0x05
+#define   EPCTRL_CMD_SET_MSI        0x06
+#define   EPCTRL_CMD_SET_MSIX       0x07
+#define   EPCTRL_CMD_RAISE_IRQ      0x08
+#define   EPCTRL_CMD_START          0x09
+#define   EPCTRL_CMD_STOP           0x0a
+
+#define EPCTRL_CTRL_SIZE    0x1000  /* 4 KB register file */
+
+/* Capabilities advertised to the driver */
+#define EPCTRL_CAPS_ALL  (EPCTRL_CAP_MSI | \
+                          EPCTRL_CAP_MSIX | \
+                          EPCTRL_CAP_DYN_INBOUND_MAP | EPCTRL_CAP_SUBRANGE)
+
+static inline uint32_t epctrl_reg_read(PCIeEPCtrlState *s, unsigned off)
+{
+    return s->regs[off / 4];
+}
+
+static inline void epctrl_reg_write(PCIeEPCtrlState *s, unsigned off,
+                                     uint32_t val)
+{
+    s->regs[off / 4] = val;
+}
+
+static void epctrl_ob_unmap_slot(PCIeEPCtrlState *s, int slot)
+{
+    MemoryRegion *alias = s->ob_map[slot].alias;
+
+    if (!alias) {
+        return;
+    }
+
+    memory_region_del_subregion(&s->ob_mr, alias);
+    object_unparent(OBJECT(alias));
+    g_free(alias);
+    s->ob_map[slot].alias = NULL;
+    s->ob_map[slot].win_off = 0;
+}
+
+static void epctrl_ob_map(PCIeEPCtrlState *s, uint64_t win_off,
+                          uint64_t pci_addr, uint64_t size)
+{
+    MemoryRegion *alias;
+    char *name;
+    int slot = -1;
+    int i;
+
+    /* Reuse a slot already mapping this window offset, replacing its alias. */
+    for (i = 0; i < EPCTRL_OB_MAP_MAX; i++) {
+        if (s->ob_map[i].alias && s->ob_map[i].win_off == win_off) {
+            epctrl_ob_unmap_slot(s, i);
+            slot = i;
+            break;
+        }
+    }
+    /* Otherwise take the first free slot. */
+    if (slot < 0) {
+        for (i = 0; i < EPCTRL_OB_MAP_MAX; i++) {
+            if (!s->ob_map[i].alias) {
+                slot = i;
+                break;
+            }
+        }
+    }
+    if (slot < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pcie-ep-ctrl: outbound map table full\n");
+        return;
+    }
+
+    alias = g_new0(MemoryRegion, 1);
+    name = g_strdup_printf("pcie-ep-ob-map%d", slot);
+    memory_region_init_alias(alias, OBJECT(s), name, get_system_memory(),
+                             pci_addr, size);
+    g_free(name);
+    memory_region_add_subregion(&s->ob_mr, win_off, alias);
+
+    s->ob_map[slot].alias = alias;
+    s->ob_map[slot].win_off = win_off;
+}
+
+static void epctrl_ob_unmap(PCIeEPCtrlState *s, uint64_t win_off)
+{
+    int i;
+
+    for (i = 0; i < EPCTRL_OB_MAP_MAX; i++) {
+        if (s->ob_map[i].alias && s->ob_map[i].win_off == win_off) {
+            epctrl_ob_unmap_slot(s, i);
+            return;
+        }
+    }
+}
+
+static void epctrl_ob_unmap_all(PCIeEPCtrlState *s)
+{
+    int i;
+
+    for (i = 0; i < EPCTRL_OB_MAP_MAX; i++) {
+        epctrl_ob_unmap_slot(s, i);
+    }
+}
+
+static PCIBus *epctrl_find_bus(const char *id, Error **errp)
+{
+    PCIDevice *pdev;
+
+    if (pci_qdev_find_device(id, &pdev) < 0) {
+        error_setg(errp, "pcie-ep-ctrl: target-bus '%s' not found", id);
+        return NULL;
+    }
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
+        error_setg(errp, "pcie-ep-ctrl: target-bus '%s' is not a PCI bridge",
+                   id);
+        return NULL;
+    }
+    return pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
+}
+
+static void epctrl_build_config(PCIeEPCtrlState *s, PCIeEPConfig *cfg)
+{
+    uint32_t cls = epctrl_reg_read(s, EPCTRL_HDR_CLASS);
+    uint32_t msi = epctrl_reg_read(s, EPCTRL_MSI_COUNT);
+    int i;
+
+    memset(cfg, 0, sizeof(*cfg));
+
+    cfg->vendor_id = epctrl_reg_read(s, EPCTRL_HDR_VID);
+    cfg->device_id = epctrl_reg_read(s, EPCTRL_HDR_DID);
+    cfg->subsys_vendor_id = epctrl_reg_read(s, EPCTRL_HDR_SVID);
+    cfg->subsys_id = epctrl_reg_read(s, EPCTRL_HDR_SSID);
+    cfg->rev_id = epctrl_reg_read(s, EPCTRL_HDR_REV);
+    cfg->interrupt_pin = epctrl_reg_read(s, EPCTRL_HDR_INTPIN);
+
+    cfg->base_class = (cls >> 16) & 0xff;
+    cfg->sub_class = (cls >> 8) & 0xff;
+    cfg->progif = cls & 0xff;
+
+    for (i = 0; i < EPCTRL_MAX_BARS && i < PCI_STD_NUM_BARS; i++) {
+        if (s->bar_size[i] == 0) {
+            continue;
+        }
+        cfg->bar[i].enabled = true;
+        cfg->bar[i].phys = s->bar_phys[i];
+        cfg->bar[i].size = s->bar_size[i];
+        cfg->bar[i].flags = s->bar_flags[i];
+    }
+
+    /*
+     * The driver writes both counts through MSI_COUNT (see
+     * pci_ep_generic_set_msi and pci_ep_generic_set_msix), so the same value
+     * seeds MSI and MSI-X.
+     */
+    cfg->num_msi = msi & 0xff;
+    cfg->num_msix = msi & 0xffff;
+    cfg->msix_bar = epctrl_reg_read(s, EPCTRL_MSIX_BAR) & 0xff;
+    cfg->msix_offset = epctrl_reg_read(s, EPCTRL_MSIX_OFFSET);
+}
+
+static void epctrl_do_hotplug(PCIeEPCtrlState *s)
+{
+    PCIeEPConfig cfg;
+    Error *local_err = NULL;
+    DeviceState *dev;
+    PCIBus *bus;
+
+    if (s->endpoint) {
+        return;
+    }
+
+    bus = epctrl_find_bus(s->target_bus, &local_err);
+    if (!bus) {
+        error_report_err(local_err);
+        return;
+    }
+
+    epctrl_build_config(s, &cfg);
+
+    dev = qdev_new(TYPE_PCIE_EP_ENDPOINT);
+    dev->hotplugged = true;
+    pcie_ep_endpoint_set_config(dev, &cfg);
+
+    if (!qdev_realize_and_unref(dev, &bus->qbus, &local_err)) {
+        error_reportf_err(local_err,
+                          "pcie-ep-ctrl: endpoint realize failed: ");
+        return;
+    }
+
+    s->endpoint = dev;
+}
+
+static void epctrl_do_unplug(PCIeEPCtrlState *s)
+{
+    HotplugHandler *hp;
+    Error *local_err = NULL;
+
+    if (!s->endpoint) {
+        return;
+    }
+
+    hp = qdev_get_hotplug_handler(s->endpoint);
+    if (hp) {
+        hotplug_handler_unplug_request(hp, s->endpoint, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err,
+                              "pcie-ep-ctrl: endpoint unplug failed: ");
+        }
+    }
+
+    s->endpoint = NULL;
+    epctrl_ob_unmap_all(s);
+}
+
+/*
+ * Link up/down runs qdev_realize, which must not happen inline from the MMIO
+ * write handler, so CMD_START / CMD_STOP schedule this bottom half instead.
+ */
+static void epctrl_link_bh(void *opaque)
+{
+    PCIeEPCtrlState *s = opaque;
+
+    if (s->started && !s->endpoint) {
+        epctrl_do_hotplug(s);
+    } else if (!s->started && s->endpoint) {
+        epctrl_do_unplug(s);
+    }
+
+    /* Reflect live link state in the read-only LINKUP register */
+    epctrl_reg_write(s, EPCTRL_LINKUP, s->endpoint ? 1 : 0);
+}
+
+static void epctrl_dispatch_cmd(PCIeEPCtrlState *s, uint32_t cmd)
+{
+    switch (cmd) {
+    case EPCTRL_CMD_WRITE_HEADER:
+        /*
+         * Header fields are consumed from the register file when the
+         * Endpoint is materialised at CMD_START. Nothing to do here.
+         */
+        break;
+
+    case EPCTRL_CMD_SET_BAR: {
+        uint32_t bar_no = epctrl_reg_read(s, EPCTRL_BAR_NO);
+
+        if (bar_no >= EPCTRL_MAX_BARS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: CMD_SET_BAR bad bar_no %u\n", bar_no);
+            break;
+        }
+        s->bar_phys[bar_no] =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_BAR_PHYS_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_BAR_PHYS_LO);
+        s->bar_size[bar_no] =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_BAR_SIZE_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_BAR_SIZE_LO);
+        s->bar_flags[bar_no] = epctrl_reg_read(s, EPCTRL_BAR_FLAGS);
+        break;
+    }
+
+    case EPCTRL_CMD_CLEAR_BAR: {
+        uint32_t bar_no = epctrl_reg_read(s, EPCTRL_BAR_NO);
+
+        if (bar_no >= EPCTRL_MAX_BARS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: CMD_CLEAR_BAR bad bar_no %u\n",
+                          bar_no);
+            break;
+        }
+        s->bar_phys[bar_no]  = 0;
+        s->bar_size[bar_no]  = 0;
+        s->bar_flags[bar_no] = 0;
+        break;
+    }
+
+    case EPCTRL_CMD_MAP: {
+        uint64_t local_phys =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_MAP_PHYS_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_MAP_PHYS_LO);
+        uint64_t pci_addr =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_MAP_PCI_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_MAP_PCI_LO);
+        uint64_t map_size =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_MAP_SIZE_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_MAP_SIZE_LO);
+        uint64_t win_off;
+
+        if (map_size == 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: CMD_MAP with zero size\n");
+            break;
+        }
+        if (local_phys < s->ob_base ||
+            local_phys >= s->ob_base + s->ob_size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: outbound map addr 0x%" PRIx64
+                          " outside window [0x%" PRIx64 "+0x%" PRIx64 "]\n",
+                          local_phys, s->ob_base, s->ob_size);
+            break;
+        }
+        win_off = local_phys - s->ob_base;
+        if (map_size > s->ob_size - win_off) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: outbound map [0x%" PRIx64 "+0x%"
+                          PRIx64 "] exceeds window [0x%" PRIx64 "+0x%"
+                          PRIx64 "]\n",
+                          local_phys, map_size, s->ob_base, s->ob_size);
+            break;
+        }
+        epctrl_ob_map(s, win_off, pci_addr, map_size);
+        break;
+    }
+
+    case EPCTRL_CMD_UNMAP: {
+        uint64_t local_phys =
+            (uint64_t)epctrl_reg_read(s, EPCTRL_MAP_PHYS_HI) << 32 |
+                       epctrl_reg_read(s, EPCTRL_MAP_PHYS_LO);
+        uint64_t win_off;
+
+        if (local_phys < s->ob_base ||
+            local_phys >= s->ob_base + s->ob_size) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "pcie-ep-ctrl: outbound unmap addr 0x%" PRIx64
+                          " outside window [0x%" PRIx64 "+0x%" PRIx64 "]\n",
+                          local_phys, s->ob_base, s->ob_size);
+            break;
+        }
+        win_off = local_phys - s->ob_base;
+        epctrl_ob_unmap(s, win_off);
+        break;
+    }
+
+    case EPCTRL_CMD_SET_MSI:
+    case EPCTRL_CMD_SET_MSIX: {
+        /*
+         * MSI and MSI-X counts are consumed at CMD_START. Seed the readback
+         * so an early get_msi() before the RC enables MSI still returns a
+         * plausible count. Once the Endpoint exists, the read handler
+         * overrides this with the live negotiated value.
+         */
+        uint32_t n = epctrl_reg_read(s, EPCTRL_MSI_COUNT);
+
+        epctrl_reg_write(s, EPCTRL_MSI_READBACK, n);
+        epctrl_reg_write(s, EPCTRL_MSIX_READBACK, n);
+        break;
+    }
+
+    case EPCTRL_CMD_RAISE_IRQ:
+        if (s->endpoint) {
+            pcie_ep_endpoint_raise_irq(s->endpoint,
+                                       epctrl_reg_read(s, EPCTRL_IRQ_TYPE),
+                                       epctrl_reg_read(s, EPCTRL_IRQ_NUM));
+        }
+        break;
+
+    case EPCTRL_CMD_START:
+        s->started = true;
+        qemu_bh_schedule(s->link_bh);
+        break;
+
+    case EPCTRL_CMD_STOP:
+        s->started = false;
+        qemu_bh_schedule(s->link_bh);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "pcie-ep-ctrl: unknown command 0x%"PRIx32"\n", cmd);
+        break;
+    }
+}
+
+static uint64_t pcie_ep_ctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PCIeEPCtrlState *s = opaque;
+    PCIeEPMsiState st;
+
+    if ((addr & 3) || addr / 4 >= EPCTRL_REG_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return 0;
+    }
+
+    /*
+     * MSI/MSI-X negotiation state is owned by the Endpoint's Configuration
+     * Space, so compute it live from the Endpoint when it exists. Before the
+     * Endpoint is created (or if the RC has not enabled MSI yet), fall through
+     * to the value the MSI_COUNT write seeded.
+     */
+    if (s->endpoint) {
+        pcie_ep_endpoint_get_msi_state(s->endpoint, &st);
+
+        switch (addr) {
+        case EPCTRL_MSI_READBACK:
+            if (st.msi_vectors) {
+                return st.msi_vectors;
+            }
+            break;
+        case EPCTRL_MSIX_READBACK:
+            if (st.msix_vectors) {
+                return st.msix_vectors;
+            }
+            break;
+        case EPCTRL_MSI_ADDR_LO:
+            if (st.msi_vectors) {
+                return st.msi_addr_lo;
+            }
+            break;
+        case EPCTRL_MSI_ADDR_HI:
+            if (st.msi_vectors) {
+                return st.msi_addr_hi;
+            }
+            break;
+        case EPCTRL_MSI_DATA:
+            if (st.msi_vectors) {
+                return st.msi_data;
+            }
+            break;
+        default:
+            break;
+        }
+    }
+
+    return epctrl_reg_read(s, addr);
+}
+
+static void pcie_ep_ctrl_write(void *opaque, hwaddr addr, uint64_t value,
+                                unsigned size)
+{
+    PCIeEPCtrlState *s = opaque;
+
+    if ((addr & 3) || addr / 4 >= EPCTRL_REG_COUNT) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
+    /* Read-only registers */
+    switch (addr) {
+    case EPCTRL_CAPS:
+    case EPCTRL_MAX_FUNC:
+    case EPCTRL_LINKUP:
+    case EPCTRL_MSI_READBACK:
+    case EPCTRL_MSIX_READBACK:
+    case EPCTRL_MSI_ADDR_LO:
+    case EPCTRL_MSI_ADDR_HI:
+    case EPCTRL_MSI_DATA:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to read-only register 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
+        return;
+    }
+
+    if (addr == EPCTRL_CMD) {
+        epctrl_dispatch_cmd(s, (uint32_t)value);
+        return;
+    }
+
+    /* Everything else is plain scratchpad, consumed at CMD_* dispatch time */
+    epctrl_reg_write(s, addr, (uint32_t)value);
+}
+
+static const MemoryRegionOps pcie_ep_ctrl_ops = {
+    .read  = pcie_ep_ctrl_read,
+    .write = pcie_ep_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void pcie_ep_ctrl_reset(DeviceState *dev)
+{
+    PCIeEPCtrlState *s = PCIE_EP_CTRL(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    epctrl_reg_write(s, EPCTRL_CAPS, EPCTRL_CAPS_ALL);
+    epctrl_reg_write(s, EPCTRL_MAX_FUNC, 1);
+}
+
+static void pcie_ep_ctrl_realize(DeviceState *dev, Error **errp)
+{
+    PCIeEPCtrlState *s = PCIE_EP_CTRL(dev);
+
+    if (!s->target_bus) {
+        error_setg(errp, "pcie-ep-ctrl: 'target-bus' property is required");
+        return;
+    }
+
+    memory_region_init_io(&s->ctrl_mr, OBJECT(s), &pcie_ep_ctrl_ops, s,
+                          "pcie-ep-ctrl", EPCTRL_CTRL_SIZE);
+
+    memory_region_init(&s->ob_mr, OBJECT(s), "pcie-ep-ob", s->ob_size);
+
+    epctrl_reg_write(s, EPCTRL_CAPS, EPCTRL_CAPS_ALL);
+    epctrl_reg_write(s, EPCTRL_MAX_FUNC, 1);
+
+    s->link_bh = qemu_bh_new_guarded(epctrl_link_bh, s,
+                                     &dev->mem_reentrancy_guard);
+}
+
+static void pcie_ep_ctrl_unrealize(DeviceState *dev)
+{
+    PCIeEPCtrlState *s = PCIE_EP_CTRL(dev);
+
+    epctrl_ob_unmap_all(s);
+    if (s->link_bh) {
+        qemu_bh_delete(s->link_bh);
+        s->link_bh = NULL;
+    }
+}
+
+static void pcie_ep_ctrl_instance_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    PCIeEPCtrlState *s = PCIE_EP_CTRL(obj);
+
+    sysbus_init_mmio(sbd, &s->ctrl_mr);
+    sysbus_init_mmio(sbd, &s->ob_mr);
+}
+
+/*
+ * The controller mirrors live Endpoint state that is built at runtime, so it
+ * is not migratable.
+ */
+static const VMStateDescription vmstate_pcie_ep_ctrl = {
+    .name = "pcie-ep-ctrl",
+    .unmigratable = 1,
+};
+
+static const Property pcie_ep_ctrl_props[] = {
+    DEFINE_PROP_UINT64("outbound-size", PCIeEPCtrlState, ob_size, 16 * MiB),
+    DEFINE_PROP_STRING("target-bus", PCIeEPCtrlState, target_bus),
+};
+
+static void pcie_ep_ctrl_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->realize = pcie_ep_ctrl_realize;
+    dc->unrealize = pcie_ep_ctrl_unrealize;
+    dc->vmsd = &vmstate_pcie_ep_ctrl;
+    dc->user_creatable = true;
+    device_class_set_legacy_reset(dc, pcie_ep_ctrl_reset);
+    device_class_set_props(dc, pcie_ep_ctrl_props);
+}
+
+static const TypeInfo pcie_ep_ctrl_info = {
+    .name = TYPE_PCIE_EP_CTRL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PCIeEPCtrlState),
+    .instance_init = pcie_ep_ctrl_instance_init,
+    .class_init = pcie_ep_ctrl_class_init,
+};
+
+static void pcie_ep_ctrl_register_types(void)
+{
+    type_register_static(&pcie_ep_ctrl_info);
+}
+type_init(pcie_ep_ctrl_register_types)
diff --git a/include/hw/misc/pcie-ep-ctrl.h b/include/hw/misc/pcie-ep-ctrl.h
new file mode 100644
index 0000000000..de7f370ffc
--- /dev/null
+++ b/include/hw/misc/pcie-ep-ctrl.h
@@ -0,0 +1,68 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU PCIe Endpoint Controller device
+ */
+
+#ifndef HW_MISC_PCIE_EP_CTRL_H
+#define HW_MISC_PCIE_EP_CTRL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+/* Maximum number of standard BARs on a PCI Function */
+#define EPCTRL_MAX_BARS 6
+
+/* Number of 32-bit registers in the ctrl MMIO region */
+#define EPCTRL_REG_COUNT (0x100 / 4)
+
+/* Maximum number of concurrent outbound mappings */
+#define EPCTRL_OB_MAP_MAX 16
+
+#define TYPE_PCIE_EP_CTRL   "pcie-ep-ctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(PCIeEPCtrlState, PCIE_EP_CTRL)
+
+/* One active outbound mapping: an alias into system RAM added to ob_mr. */
+typedef struct EPCtrlObMap {
+    MemoryRegion *alias; /* NULL when the slot is free */
+    uint64_t win_off; /* byte offset within the outbound window */
+} EPCtrlObMap;
+
+struct PCIeEPCtrlState {
+    SysBusDevice parent_obj;
+
+    /* ctrl MMIO register file */
+    MemoryRegion ctrl_mr;
+    /* outbound DMA window (container of per-mapping aliases) */
+    MemoryRegion ob_mr;
+
+    /* Properties */
+    uint64_t ob_size;
+    char    *target_bus;   /* id of the RC Root Port to hotplug the EP onto */
+
+    /*
+     * Absolute CPU address where the machine mapped the outbound window.
+     * Set after placement (the arm virt platform bus assigns it), used to
+     * translate guest-programmed addresses into window offsets.
+     */
+    uint64_t ob_base;
+
+    /* Active outbound mappings */
+    EPCtrlObMap ob_map[EPCTRL_OB_MAP_MAX];
+
+    /* The hotplugged PCI Endpoint, NULL until CMD_START */
+    DeviceState *endpoint;
+    QEMUBH      *link_bh;
+
+    /* BAR configuration tracked as the EP driver programs it */
+    uint64_t bar_phys[EPCTRL_MAX_BARS];
+    uint64_t bar_size[EPCTRL_MAX_BARS];
+    uint32_t bar_flags[EPCTRL_MAX_BARS];
+
+    bool started; /* set when CMD_START has been issued (not migrated) */
+
+    /* Register state */
+    uint32_t regs[EPCTRL_REG_COUNT];
+};
+
+#endif /* HW_MISC_PCIE_EP_CTRL_H */

-- 
2.43.0


