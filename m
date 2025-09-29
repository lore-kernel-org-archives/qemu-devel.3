Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594C2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H91-0005R2-8M; Mon, 29 Sep 2025 12:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H81-00039s-E7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7p-0002qh-1U
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LtExMK0D2H5qPhWhXGV91raqPCKDDj+ndgDwVFN0Jw=;
 b=hk40+UJjvqOISSEEN139iiwxKVbBSzwnPTUbqWLHwWF8ee2FM8vjykVRSIq9Vi4mgwEv6w
 6rVTtJXLDcRRZ3iqJZYaJXJFITYjoC6Bebrg1qX9dI3B0xKzSZj0ZNgWcfkmnjnEwjIYq+
 9o1MHr3ddhVJX32DCTzex3l+xqZoYKQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-fim0_i39O2yHd33fzPJntw-1; Mon,
 29 Sep 2025 12:53:14 -0400
X-MC-Unique: fim0_i39O2yHd33fzPJntw-1
X-Mimecast-MFC-AGG-ID: fim0_i39O2yHd33fzPJntw_1759164793
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B1218002C3; Mon, 29 Sep 2025 16:53:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CA3E1800446; Mon, 29 Sep 2025 16:53:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/32] hw/pci-host/aspeed: Add AST2600 PCIe config space and
 host bridge
Date: Mon, 29 Sep 2025 18:52:14 +0200
Message-ID: <20250929165230.797471-17-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce PCIe config and host bridge model for the AST2600 platform.

This patch adds support for the H2X (AHB to PCIe Bus Bridge) controller
with a 0x100 byte register space. The register layout is shared between
two root complexes: 0x00–0x7f is common, 0x80–0xbf for RC_L, and 0xc0–0xff
for RC_H. Only RC_H is modeled in this implementation.

The RC_H bus uses bus numbers in the 0x80–0xff range instead of the
standard root bus 0x00. To allow the PCI subsystem to discover devices,
the host bridge logic remaps the root bus number back to 0x00 whenever the
configured bus number matches the "bus-nr" property.

New MMIO callbacks are added for the H2X config space:
- aspeed_pcie_cfg_read() and aspeed_pcie_cfg_write() handle register
  accesses.
- aspeed_pcie_cfg_readwrite() provides configuration read/write support.
- aspeed_pcie_cfg_translate_write() handles PCIe byte-enable semantics for
  write operations.

The reset handler initializes the H2X register block with default values
as defined in the AST2600 datasheet.

Additional changes:
- Implement ASPEED PCIe root complex (TYPE_ASPEED_PCIE_RC).
- Wire up interrupt propagation via aspeed_pcie_rc_set_irq().
- Add tracepoints for config read/write and INTx handling.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |  59 +++++
 hw/pci-host/aspeed_pcie.c         | 421 ++++++++++++++++++++++++++++++
 hw/pci-host/trace-events          |   4 +
 3 files changed, 484 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index d9fb829048a0..850d579189eb 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -22,6 +22,65 @@
 #include "hw/pci/pcie_host.h"
 #include "qom/object.h"
 
+typedef struct AspeedPCIECfgTxDesc {
+    uint32_t desc0;
+    uint32_t desc1;
+    uint32_t desc2;
+    uint32_t desc3;
+    uint32_t wdata;
+    uint32_t rdata_reg;
+} AspeedPCIECfgTxDesc;
+
+typedef struct AspeedPCIERcRegs {
+    uint32_t int_en_reg;
+    uint32_t int_sts_reg;
+} AspeedPCIERcRegs;
+
+typedef struct AspeedPCIERegMap {
+    AspeedPCIERcRegs rc;
+} AspeedPCIERegMap;
+
+#define TYPE_ASPEED_PCIE_RC "aspeed.pcie-rc"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
+
+struct AspeedPCIERcState {
+    PCIExpressHost parent_obj;
+
+    MemoryRegion mmio_window;
+    MemoryRegion io_window;
+    MemoryRegion mmio;
+    MemoryRegion io;
+
+    uint32_t bus_nr;
+    char name[16];
+    qemu_irq irq;
+};
+
+/* Bridge between AHB bus and PCIe RC. */
+#define TYPE_ASPEED_PCIE_CFG "aspeed.pcie-cfg"
+OBJECT_DECLARE_TYPE(AspeedPCIECfgState, AspeedPCIECfgClass, ASPEED_PCIE_CFG);
+
+struct AspeedPCIECfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t *regs;
+    uint32_t id;
+
+    const AspeedPCIERcRegs *rc_regs;
+    AspeedPCIERcState rc;
+};
+
+struct AspeedPCIECfgClass {
+    SysBusDeviceClass parent_class;
+
+    const AspeedPCIERegMap *reg_map;
+    const MemoryRegionOps *reg_ops;
+
+    uint64_t rc_bus_nr;
+    uint64_t nr_regs;
+};
+
 #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
 OBJECT_DECLARE_TYPE(AspeedPCIEPhyState, AspeedPCIEPhyClass, ASPEED_PCIE_PHY);
 
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 4c74520052a4..c3e92ee44926 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -25,6 +25,425 @@
 #include "hw/pci/msi.h"
 #include "trace.h"
 
+/*
+ * PCIe Root Complex (RC)
+ */
+
+static void aspeed_pcie_rc_set_irq(void *opaque, int irq, int level)
+{
+    AspeedPCIERcState *rc = (AspeedPCIERcState *) opaque;
+    AspeedPCIECfgState *cfg =
+        container_of(rc, AspeedPCIECfgState, rc);
+    bool intx;
+
+    assert(irq < PCI_NUM_PINS);
+
+    if (level) {
+        cfg->regs[cfg->rc_regs->int_sts_reg] |= BIT(irq);
+    } else {
+        cfg->regs[cfg->rc_regs->int_sts_reg] &= ~BIT(irq);
+    }
+
+    intx = !!(cfg->regs[cfg->rc_regs->int_sts_reg] &
+              cfg->regs[cfg->rc_regs->int_en_reg]);
+    trace_aspeed_pcie_rc_intx_set_irq(cfg->id, irq, intx);
+    qemu_set_irq(rc->irq, intx);
+}
+
+static int aspeed_pcie_rc_map_irq(PCIDevice *pci_dev, int irq_num)
+{
+    return irq_num % PCI_NUM_PINS;
+}
+
+static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
+{
+    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(dev);
+    AspeedPCIECfgState *cfg =
+           container_of(rc, AspeedPCIECfgState, rc);
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    g_autofree char *ioport_window_name = NULL;
+    g_autofree char *mmio_window_name = NULL;
+    g_autofree char *root_bus_name = NULL;
+
+    /* PCI configuration space */
+    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
+    sysbus_init_mmio(sbd, &pex->mmio);
+
+    /* MMIO and IO region */
+    memory_region_init(&rc->mmio, OBJECT(rc), "mmio", UINT64_MAX);
+    memory_region_init(&rc->io, OBJECT(rc), "io", 0x10000);
+
+    mmio_window_name = g_strdup_printf("pcie.%d.mmio_window", cfg->id);
+    memory_region_init_io(&rc->mmio_window, OBJECT(rc), &unassigned_io_ops,
+                          OBJECT(rc), mmio_window_name, UINT64_MAX);
+    ioport_window_name = g_strdup_printf("pcie.%d.ioport_window", cfg->id);
+    memory_region_init_io(&rc->io_window, OBJECT(rc), &unassigned_io_ops,
+                          OBJECT(rc), ioport_window_name, 0x10000);
+
+    memory_region_add_subregion(&rc->mmio_window, 0, &rc->mmio);
+    memory_region_add_subregion(&rc->io_window, 0, &rc->io);
+    sysbus_init_mmio(sbd, &rc->mmio_window);
+    sysbus_init_mmio(sbd, &rc->io_window);
+
+    sysbus_init_irq(sbd, &rc->irq);
+    root_bus_name = g_strdup_printf("pcie.rc%d", cfg->id);
+    pci->bus = pci_register_root_bus(dev, root_bus_name,
+                                     aspeed_pcie_rc_set_irq,
+                                     aspeed_pcie_rc_map_irq, rc, &rc->mmio,
+                                     &rc->io, 0, 4, TYPE_PCIE_BUS);
+    pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
+}
+
+static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
+                                                PCIBus *rootbus)
+{
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(host_bridge);
+    AspeedPCIECfgState *cfg =
+           container_of(rc, AspeedPCIECfgState, rc);
+
+    snprintf(rc->name, sizeof(rc->name), "%04x:%02x", cfg->id, rc->bus_nr);
+
+    return rc->name;
+}
+
+static const Property aspeed_pcie_rc_props[] = {
+    DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
+};
+
+static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
+{
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "ASPEED PCIe RC";
+    dc->realize = aspeed_pcie_rc_realize;
+    dc->fw_name = "pci";
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+
+    hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
+    device_class_set_props(dc, aspeed_pcie_rc_props);
+
+    msi_nonbroken = true;
+}
+
+static const TypeInfo aspeed_pcie_rc_info = {
+    .name = TYPE_ASPEED_PCIE_RC,
+    .parent = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(AspeedPCIERcState),
+    .class_init = aspeed_pcie_rc_class_init,
+};
+
+/*
+ * PCIe Config
+ *
+ * AHB to PCIe Bus Bridge (H2X)
+ *
+ * On the AST2600:
+ * NOTE: rc_l is not supported by this model.
+ * - Registers 0x00 - 0x7F are shared by both PCIe0 (rc_l) and PCIe1 (rc_h).
+ * - Registers 0x80 - 0xBF are specific to PCIe0.
+ * - Registers 0xC0 - 0xFF are specific to PCIe1.
+ */
+
+/* AST2600 */
+REG32(H2X_CTRL,             0x00)
+    FIELD(H2X_CTRL, CLEAR_RX, 4, 1)
+REG32(H2X_TX_CLEAR,         0x08)
+    FIELD(H2X_TX_CLEAR, IDLE, 0, 1)
+REG32(H2X_RDATA,            0x0C)
+REG32(H2X_TX_DESC0,         0x10)
+REG32(H2X_TX_DESC1,         0x14)
+REG32(H2X_TX_DESC2,         0x18)
+REG32(H2X_TX_DESC3,         0x1C)
+REG32(H2X_TX_DATA,          0x20)
+REG32(H2X_TX_STS,           0x24)
+    FIELD(H2X_TX_STS, IDLE, 31, 1)
+    FIELD(H2X_TX_STS, RC_L_TX_COMP, 24, 1)
+    FIELD(H2X_TX_STS, RC_H_TX_COMP, 25, 1)
+    FIELD(H2X_TX_STS, TRIG, 0, 1)
+REG32(H2X_RC_H_CTRL,        0xC0)
+REG32(H2X_RC_H_INT_EN,      0xC4)
+REG32(H2X_RC_H_INT_STS,     0xC8)
+    SHARED_FIELD(H2X_RC_INT_INTDONE, 4, 1)
+    SHARED_FIELD(H2X_RC_INT_INTX, 0, 4)
+REG32(H2X_RC_H_RDATA,       0xCC)
+
+#define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
+#define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
+#define TLP_FMTTYPE_CFGRD1  0x05 /* Configuration Read  Type 1 */
+#define TLP_FMTTYPE_CFGWR1  0x45 /* Configuration Write Type 1 */
+
+#define PCIE_CFG_FMTTYPE_MASK(x) (((x) >> 24) & 0xff)
+#define PCIE_CFG_BYTE_EN(x) ((x) & 0xf)
+
+static const AspeedPCIERegMap aspeed_regmap = {
+    .rc = {
+        .int_en_reg     = R_H2X_RC_H_INT_EN,
+        .int_sts_reg    = R_H2X_RC_H_INT_STS,
+    },
+};
+
+static uint64_t aspeed_pcie_cfg_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
+    uint32_t reg = addr >> 2;
+    uint32_t value = 0;
+
+    value = s->regs[reg];
+
+    trace_aspeed_pcie_cfg_read(s->id, addr, value);
+
+    return value;
+}
+
+static void aspeed_pcie_cfg_translate_write(uint8_t byte_en, uint32_t *addr,
+                                            uint64_t *val, int *len)
+{
+    uint64_t packed_val = 0;
+    int first_bit = -1;
+    int index = 0;
+    int i;
+
+    *len = ctpop8(byte_en);
+
+    if (*len == 0 || *len > 4) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid byte enable: 0x%x\n",
+                      __func__, byte_en);
+        return;
+    }
+
+    /* Special case: full 4-byte write must be 4-byte aligned */
+    if (byte_en == 0x0f) {
+        if ((*addr & 0x3) != 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: 4-byte write not 4-byte aligned: addr=0x%x\n",
+                          __func__, *addr);
+            return;
+        }
+        *val &= 0xffffffffULL;
+        return;
+    }
+
+    for (i = 0; i < 4; i++) {
+        if (byte_en & (1 << i)) {
+            if (first_bit < 0) {
+                first_bit = i;
+            }
+            packed_val |= ((*val >> (i * 8)) & 0xff) << (index * 8);
+            index++;
+        }
+    }
+
+    *addr += first_bit;
+    *val = packed_val;
+}
+
+static void aspeed_pcie_cfg_readwrite(AspeedPCIECfgState *s,
+                                      const AspeedPCIECfgTxDesc *desc)
+{
+    AspeedPCIERcState *rc = &s->rc;
+    PCIHostState *pci = NULL;
+    PCIDevice *pdev = NULL;
+    uint32_t cfg_addr;
+    uint32_t offset;
+    uint8_t byte_en;
+    bool is_write;
+    uint8_t devfn;
+    uint64_t val;
+    uint8_t bus;
+    int len;
+
+    val = ~0;
+    is_write = !!(desc->desc0 & BIT(30));
+    cfg_addr = desc->desc2;
+
+    bus = (cfg_addr >> 24) & 0xff;
+    devfn  = (cfg_addr >> 16) & 0xff;
+    offset = cfg_addr & 0xffc;
+
+    pci = PCI_HOST_BRIDGE(rc);
+
+    /*
+     * On the AST2600, the RC_H bus number range from 0x80 to 0xFF, with the
+     * root device and root port assigned to bus 0x80 instead of the standard
+     * 0x00. To allow the PCI subsystem to correctly discover devices on the
+     * root bus, bus 0x80 is remapped to 0x00.
+     */
+    if (bus == rc->bus_nr) {
+        bus = 0;
+    }
+
+    pdev = pci_find_device(pci->bus, bus, devfn);
+    if (!pdev) {
+        s->regs[desc->rdata_reg] = ~0;
+        goto out;
+    }
+
+    switch (PCIE_CFG_FMTTYPE_MASK(desc->desc0)) {
+    case TLP_FMTTYPE_CFGWR0:
+    case TLP_FMTTYPE_CFGWR1:
+        byte_en = PCIE_CFG_BYTE_EN(desc->desc1);
+        val = desc->wdata;
+        aspeed_pcie_cfg_translate_write(byte_en, &offset, &val, &len);
+        pci_host_config_write_common(pdev, offset, pci_config_size(pdev),
+                                     val, len);
+        break;
+    case TLP_FMTTYPE_CFGRD0:
+    case TLP_FMTTYPE_CFGRD1:
+        val = pci_host_config_read_common(pdev, offset,
+                                          pci_config_size(pdev), 4);
+        s->regs[desc->rdata_reg] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid CFG type. DESC0=0x%x\n",
+                      __func__, desc->desc0);
+    }
+
+out:
+    trace_aspeed_pcie_cfg_rw(s->id, is_write ?  "write" : "read", bus, devfn,
+                             cfg_addr, val);
+}
+
+static void aspeed_pcie_cfg_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned int size)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
+    AspeedPCIECfgTxDesc desc;
+    uint32_t reg = addr >> 2;
+    uint32_t rc_reg;
+
+    trace_aspeed_pcie_cfg_write(s->id, addr, data);
+
+    switch (reg) {
+    case R_H2X_CTRL:
+        if (data & R_H2X_CTRL_CLEAR_RX_MASK) {
+            s->regs[R_H2X_RDATA] = ~0;
+        }
+        break;
+    case R_H2X_TX_CLEAR:
+        if (data & R_H2X_TX_CLEAR_IDLE_MASK) {
+            s->regs[R_H2X_TX_STS] &= ~R_H2X_TX_STS_IDLE_MASK;
+        }
+        break;
+    case R_H2X_TX_STS:
+        if (data & R_H2X_TX_STS_TRIG_MASK) {
+            desc.desc0 = s->regs[R_H2X_TX_DESC0];
+            desc.desc1 = s->regs[R_H2X_TX_DESC1];
+            desc.desc2 = s->regs[R_H2X_TX_DESC2];
+            desc.desc3 = s->regs[R_H2X_TX_DESC3];
+            desc.wdata = s->regs[R_H2X_TX_DATA];
+            desc.rdata_reg = R_H2X_RC_H_RDATA;
+            aspeed_pcie_cfg_readwrite(s, &desc);
+            rc_reg = s->rc_regs->int_sts_reg;
+            s->regs[rc_reg] |= H2X_RC_INT_INTDONE_MASK;
+            s->regs[R_H2X_TX_STS] |=
+                BIT(R_H2X_TX_STS_RC_H_TX_COMP_SHIFT);
+            s->regs[R_H2X_TX_STS] |= R_H2X_TX_STS_IDLE_MASK;
+        }
+        break;
+    /* preserve INTx status */
+    case R_H2X_RC_H_INT_STS:
+        if (data & H2X_RC_INT_INTDONE_MASK) {
+            s->regs[R_H2X_TX_STS] &= ~R_H2X_TX_STS_RC_H_TX_COMP_MASK;
+        }
+        s->regs[reg] &= ~data | H2X_RC_INT_INTX_MASK;
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_pcie_cfg_ops = {
+    .read = aspeed_pcie_cfg_read,
+    .write = aspeed_pcie_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_pcie_cfg_instance_init(Object *obj)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(obj);
+
+    object_initialize_child(obj, "rc", &s->rc, TYPE_ASPEED_PCIE_RC);
+
+    return;
+}
+
+static void aspeed_pcie_cfg_reset(DeviceState *dev)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
+    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
+
+    memset(s->regs, 0, apc->nr_regs << 2);
+}
+
+static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
+    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
+    g_autofree char *name = NULL;
+
+    s->rc_regs = &apc->reg_map->rc;
+    s->regs = g_new(uint32_t, apc->nr_regs);
+    name = g_strdup_printf(TYPE_ASPEED_PCIE_CFG ".regs.%d", s->id);
+    memory_region_init_io(&s->mmio, OBJECT(s), apc->reg_ops, s, name,
+                          apc->nr_regs << 2);
+    sysbus_init_mmio(sbd, &s->mmio);
+
+    object_property_set_int(OBJECT(&s->rc), "bus-nr",
+                            apc->rc_bus_nr,
+                            &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
+        return;
+    }
+}
+
+static void aspeed_pcie_cfg_unrealize(DeviceState *dev)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
+
+    g_free(s->regs);
+    s->regs = NULL;
+}
+
+static const Property aspeed_pcie_cfg_props[] = {
+    DEFINE_PROP_UINT32("id", AspeedPCIECfgState, id, 0),
+};
+
+static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
+
+    dc->desc = "ASPEED PCIe Config";
+    dc->realize = aspeed_pcie_cfg_realize;
+    dc->unrealize = aspeed_pcie_cfg_unrealize;
+    device_class_set_legacy_reset(dc, aspeed_pcie_cfg_reset);
+    device_class_set_props(dc, aspeed_pcie_cfg_props);
+
+    apc->reg_ops = &aspeed_pcie_cfg_ops;
+    apc->reg_map = &aspeed_regmap;
+    apc->nr_regs = 0x100 >> 2;
+    apc->rc_bus_nr = 0x80;
+}
+
+static const TypeInfo aspeed_pcie_cfg_info = {
+    .name       = TYPE_ASPEED_PCIE_CFG,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_init = aspeed_pcie_cfg_instance_init,
+    .instance_size = sizeof(AspeedPCIECfgState),
+    .class_init = aspeed_pcie_cfg_class_init,
+    .class_size = sizeof(AspeedPCIECfgClass),
+};
+
 /*
  * PCIe PHY
  *
@@ -150,6 +569,8 @@ static const TypeInfo aspeed_pcie_phy_info = {
 
 static void aspeed_pcie_register_types(void)
 {
+    type_register_static(&aspeed_pcie_rc_info);
+    type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
 }
 
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 3438516756db..2584ea56e2cc 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -1,6 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
 # aspeed_pcie.c
+aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: num %d set IRQ leve %d"
+aspeed_pcie_cfg_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
+aspeed_pcie_cfg_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
+aspeed_pcie_cfg_rw(uint32_t id, const char *dir, uint8_t bus, uint8_t devfn, uint64_t addr, uint64_t data) "%d: %s bus:0x%x devfn:0x%x addr 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_pcie_phy_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
 aspeed_pcie_phy_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
 
-- 
2.51.0


