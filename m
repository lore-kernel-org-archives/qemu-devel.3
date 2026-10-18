Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D30CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3q-0002Sd-98; Sun, 18 Oct 2026 09:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3b-0002F2-BB
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:11 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3Y-0002Fj-Q0
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:11 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-93f2b8cf037so94538085a.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330568; x=1792935368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aWlPxQZ4Q7l7dj0GpCZDZOFPtTvHErIPZsbdUn/ZBAA=;
 b=OtT+qeaIGf0cKe2VdXLQ0s4c5XBMJKprdGyag0uU5NzJzAFaL4BMcbZxuKgtdvYCPI
 +JLGUWPYmddNwatPsKr6XFfEBhCF/U/xBfPYZ33fdzHaXZixdE1SP8cqP2+OXclfTPWL
 PsTg2wudMnM2S+yqTekt9LSFZZPfsiVMN0Zdmnb5vVR6cK9s/8l+KfunENws8p9hBJjN
 0XR16ddRwaOOQmt3NfSKkIYRQge1t6O+wNgVtjH60yg76GXtm9LNnFN97Zjz8tdJmEqO
 Wqr1KzR1E1bX6W5yBppDtxx6ycKenOUfckPdQpmOrZpI1kXpjmNg5M2d9OEtt8/fY9E6
 nUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330568; x=1792935368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aWlPxQZ4Q7l7dj0GpCZDZOFPtTvHErIPZsbdUn/ZBAA=;
 b=QvHJWlJ4g5WmyE+PUUJfzyymlFXK4oF+ezhtF+QZhRxkIcV+ZCnjl/pBY+UiOHSHqA
 /ZZGLJTOFZ3B6YyBdrdvEOgtlfeSOeg+hiyOAN5atxrecVmALFMWeu4PsE0dx01vtsoa
 hYU9sWbEmmEzZMQqsA5BVxrH8OgYJiX9ha8a8pLzzZVi2e3VHrrW6QniHR203dHLpFr3
 n/KE3E56fdEzOtl0VXGLZK+rrpvNNxT5mU/lQ5aSaZUGCZJGQxwpVcUEziG1hItmqOZa
 qvm5t9lrBCjgldV5Qe5YjTiv9njNQefl2swHEGmxC2t3BYTc2Yw8IIpOKHvzjfyQMdFv
 OW4A==
X-Gm-Message-State: AFq9FYK2l91zid3KNXUeH9mLIDH7zs8lLfT7P1oWZOWkbKsz8fL+d6qR
 lWm0k+Z+k9z+1SEPFP3JTOEubn//i2Fs1jVoOZJl8SInuBfyDpfZMdgoHKrbcLOG
X-Gm-Gg: AYBFou0CN3wDcHURkV+8rBIrcxMNVd6DfIsfmhl1dZujvozP5DqQvF8wYGH7y7Zff+s
 eBn5utfhyvTabHloOIRpWLtKbzr5DPHxhWkPdTT+6iGV9fHPntuPG9y1Ozym0bgDOq2DOWdgvua
 ovyhztUo69RnerURU8o9AWHmXF5VAI71kDsNj+twe9+F/2xwIdWjBMDU1lQo3EZ1Iw2dLMULl3w
 5S3tjZtj5waO7o6rbjc6+suiqBC3ffnbJ75Ce5deBesSxggSYIV3rAozbFSeWt52T3F6qnUpv6B
 dW5YUenYdQo6P5Ed2tk8vRRqu0ng6WHIwhN+Fzs5alW/WDnrHwnOtcUgLdFPx8vrFDAGlMU6hN5
 c9UO3uBtevcnjqp448bbZKQRyOOLrX883CzVQIlku0qGw+aPXnWKYA4+Af6Xp5ebPsXNDhoBk0V
 fZkgIA/ZcFjJsE4c4WQZ7NZqKQ3BOHcCZ3162gNsVVAUqbbRbxZnK1V2LUgjeRel5CsDtJVYKG3
 rftt+F+f2Ylb/XXjTJ79PmFbIStNRplIOxhoPYCVI71zMixGcT2MD/REv6p7zk9MXtfIlOl7OmX
 Hq5XYw==
X-Received: by 2002:a05:620a:4109:b0:93f:35fc:5266 with SMTP id
 af79cd13be357-93f35fc586emr421985285a.44.1792330567644; 
 Sun, 18 Oct 2026 06:36:07 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:07 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v4 02/17] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
Date: Sun, 18 Oct 2026 09:35:48 -0400
Message-ID: <20261018133603.64323-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the BCM2838 PCIe host bridge model: config space, MMIO window,
and register access for the root port.

Per Peter Maydell's review of a later follow-up series, fold in what
was originally a separate bugfix here, since this device isn't in
upstream git yet and the bug was in code this patch itself introduces.
Four defects fixed, all on the enumeration path (none of this was
exercised until a later patch actually attaches a PCI device):

1. bcm2838_pcie_host_read/write computed
   "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
   underflows for every offset below 4KB. The root port's own config
   space -- including vendor/device ID at offset 0 -- therefore always
   fell into the out-of-range branch and read back as all-ones, i.e.
   "no device present", so the guest stopped scanning immediately.

2. pcie_host_mmcfg_init() was never called, yet both accessors
   dereference pcie_hb->mmio.ops to service EXT_CFG_DATA. Once (1) was
   fixed and the guest actually reached that path, it touched an
   uninitialised MemoryRegion.

3. The root port overrode PCIDeviceClass::config_read/config_write with
   plain pci_default_*_config(). That bypasses rp_write_config() ->
   pci_bridge_write_config(), so programming the bridge's memory window
   never updated the bridge's address space and BARs behind the root
   port stayed unreachable. Drop the overrides and dispatch through
   pci_host_config_{read,write}_common() so the device's real handlers
   run.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838_pcie.c         | 208 ++++++++++++++++++++++++++++++++++
 hw/arm/trace-events           |   4 +
 include/hw/arm/bcm2838_pcie.h |  19 ++++
 3 files changed, 231 insertions(+)

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index 1ebb05657b..04d976f1d0 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "hw/core/irq.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci/pci_host.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
@@ -19,6 +20,212 @@
 #include "hw/arm/bcm2838_pcie.h"
 #include "trace.h"
 
+/*
+ * The register bytes in root_port.regs[] are little-endian whatever the host
+ * is, so access them with the ld*_le_p()/st*_le_p() helpers.
+ */
+static uint32_t bcm2838_pcie_ext_cfg_index(const uint8_t *root_regs)
+{
+    return ldl_le_p(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                    - PCIE_CONFIG_SPACE_SIZE);
+}
+
+static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
+                                       unsigned size) {
+    hwaddr mmcfg_addr;
+    uint64_t value = ~0;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    uint8_t *root_regs = s->root_port.regs;
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /*
+         * The first 4KB of the window is the root port's own PCI config
+         * space (vendor/device ID, BARs, capabilities). Serve it from the
+         * real PCIDevice, not from the raw regs[] shadow buffer, which is
+         * only backing store for the controller registers above 4KB.
+         */
+        value = pci_host_config_read_common(PCI_DEVICE(&s->root_port),
+                                            offset, PCIE_CONFIG_SPACE_SIZE,
+                                            size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = bcm2838_pcie_ext_cfg_index(root_regs)
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);
+            break;
+        default:
+            value = ldn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+
+    trace_bcm2838_pcie_host_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size) {
+    hwaddr mmcfg_addr;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    uint8_t *root_regs = s->root_port.regs;
+
+    trace_bcm2838_pcie_host_write(size, offset, value);
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        /* Root port's own PCI config space -- see read path above */
+        pci_host_config_write_common(PCI_DEVICE(&s->root_port), offset,
+                                     PCIE_CONFIG_SPACE_SIZE, value, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = bcm2838_pcie_ext_cfg_index(root_regs)
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            pcie_hb->mmio.ops->write(opaque, mmcfg_addr, value, size);
+            break;
+        default:
+            stn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size, value);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+}
+
+static const MemoryRegionOps bcm2838_pcie_host_ops = {
+    .read = bcm2838_pcie_host_read,
+    .write = bcm2838_pcie_host_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {.max_access_size = sizeof(uint64_t)},
+};
+
+static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
+{
+    BCM2838PcieHostState *s = opaque;
+
+    qemu_set_irq(s->irq[irq_num], level);
+}
+
+static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
+{
+    return pin;
+}
+
+static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+
+    int i;
+
+    /*
+     * Initialise the ECAM config-space window. The BCM2838 does not expose
+     * it to the guest directly; config accesses are made indirectly through
+     * the EXT_CFG_INDEX/EXT_CFG_DATA register pair, which dispatch into
+     * pex->mmio. Without this the ops pointer is never set up.
+     */
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+
+    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
+                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->cfg_regs);
+
+    /*
+     * The MemoryRegions io_mmio and io_ioport that we pass to
+     * pci_register_root_bus() are not the same as the MemoryRegions
+     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
+     * The difference is in the behavior of accesses to addresses where no PCI
+     * device has been mapped.
+     *
+     * io_mmio and io_ioport are the underlying PCI view of the PCI address
+     * space, and when a PCI device does a bus master access to a bad address
+     * this is reported back to it as a transaction failure.
+     *
+     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
+     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
+     * not mandated properly by the PCI spec but expected by the majority of
+     * PCI-using guest software, including Linux.
+     *
+     * We implement it in the PCIe host controller, by providing the *_window
+     * MRs, which are containers with io ops that implement the 'background'
+     * behavior and which hold the real PCI MRs as sub-regions.
+     */
+    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
+    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
+                       64 * 1024);
+
+    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
+                            &unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_mmio_window", UINT64_MAX);
+    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
+                            &unassigned_io_ops, OBJECT(s),
+                            "bcm2838_pcie_ioport_window", 64 * 1024);
+
+    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
+    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
+    sysbus_init_mmio(sbd, &s->io_mmio_window);
+    sysbus_init_mmio(sbd, &s->io_ioport_window);
+
+    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+
+    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
+                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
+                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
+                                     TYPE_PCIE_BUS);
+    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
+}
+
+static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
+                                                   PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void bcm2838_pcie_host_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = bcm2838_pcie_host_root_bus_path;
+    dc->realize = bcm2838_pcie_host_realize;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+}
+
+static void bcm2838_pcie_host_initfn(Object *obj)
+{
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
+    BCM2838PcieRootState *root = &s->root_port;
+
+    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
+}
+
+static const TypeInfo bcm2838_pcie_host_info = {
+    .name       = TYPE_BCM2838_PCIE_HOST,
+    .parent     = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(BCM2838PcieHostState),
+    .instance_init = bcm2838_pcie_host_initfn,
+    .class_init = bcm2838_pcie_host_class_init,
+};
+
 /*
  * RC root part (D0:F0)
  */
@@ -98,6 +305,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
 static void bcm2838_pcie_register(void)
 {
     type_register_static(&bcm2838_pcie_root_info);
+    type_register_static(&bcm2838_pcie_host_info);
 }
 
 type_init(bcm2838_pcie_register)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 1b16f710fe..579d4b12c2 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -96,3 +96,7 @@ z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
 
 # bcm2838.c
 bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
+
+# bcm2838_pcie.c
+bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
index cb95c65331..2cbea3062e 100644
--- a/include/hw/arm/bcm2838_pcie.h
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -16,6 +16,9 @@
 #include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
+#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
+
 #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
 OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
                     BCM2838_PCIE_ROOT)
@@ -51,4 +54,20 @@ struct BCM2838PcieRootClass {
 };
 
 
+struct BCM2838PcieHostState {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+
+    /*< public >*/
+    BCM2838PcieRootState root_port;
+
+    MemoryRegion cfg_regs;
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+
+    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
+};
+
 #endif /* BCM2838_PCIE_H */
-- 
2.55.0


