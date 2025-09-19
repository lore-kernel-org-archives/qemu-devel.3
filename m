Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC60CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXSl-0003yB-Ve; Fri, 19 Sep 2025 05:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSY-0003tK-1B; Fri, 19 Sep 2025 05:31:20 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXSQ-0001GX-Fe; Fri, 19 Sep 2025 05:31:14 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 19 Sep
 2025 17:30:20 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 19 Sep 2025 17:30:20 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 06/14] hw/pci-host/aspeed: Add MSI support and per-RC IOMMU
 address space
Date: Fri, 19 Sep 2025 17:30:05 +0800
Message-ID: <20250919093017.338309-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add MSI support to the ASPEED PCIe RC/Config model and introduce a per-RC
"IOMMU root" address space to correctly route MSI writes.

On AST2700 all RCs use the same MSI address, and the MSI target is PCI
system memory (not normal DRAM). If the MSI window were mapped into real
system RAM, an endpoint's write could be observed by other RCs and
spuriously trigger their interrupts. To avoid this, each RC now owns an
isolated IOMMU root AddressSpace that contains a small MSI window and a
DRAM alias region for normal DMA.

The MSI window captures writes and asserts the RC IRQ. MSI status bits
are tracked in new H2X RC_H registers (R_H2X_RC_H_MSI_EN{0,1} and
R_H2X_RC_H_MSI_STS{0,1}). Clearing all status bits drops the IRQ. The
default MSI address is set to 0x1e77005c and can be overridden via the
msi-addr property.

This keeps MSI traffic contained within each RC while preserving normal
DMA to system DRAM. It enables correct MSI/MSI-X interrupt delivery when
multiple RCs use the same MSI target address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |  10 +++
 hw/pci-host/aspeed_pcie.c         | 132 ++++++++++++++++++++++++++++++
 hw/pci-host/trace-events          |   3 +
 3 files changed, 145 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 5346c15c81..5e60cba07b 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -35,6 +35,8 @@ typedef struct AspeedPCIECfgTxDesc {
 typedef struct AspeedPCIERcRegs {
     uint32_t int_en_reg;
     uint32_t int_sts_reg;
+    uint32_t msi_sts0_reg;
+    uint32_t msi_sts1_reg;
 } AspeedPCIERcRegs;
 
 typedef struct AspeedPCIERegMap {
@@ -61,11 +63,18 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
 struct AspeedPCIERcState {
     PCIExpressHost parent_obj;
 
+    MemoryRegion iommu_root;
+    AddressSpace iommu_as;
+    MemoryRegion dram_alias;
+    MemoryRegion *dram_mr;
     MemoryRegion mmio_window;
+    MemoryRegion msi_window;
     MemoryRegion io_window;
     MemoryRegion mmio;
     MemoryRegion io;
 
+    uint64_t dram_base;
+    uint32_t msi_addr;
     uint32_t rp_addr;
     uint32_t bus_nr;
     char name[16];
@@ -97,6 +106,7 @@ struct AspeedPCIECfgClass {
     const AspeedPCIERegMap *reg_map;
     const MemoryRegionOps *reg_ops;
 
+    uint32_t rc_msi_addr;
     uint32_t rc_rp_addr;
     uint64_t rc_bus_nr;
     uint64_t nr_regs;
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index dafffbde61..8be55b962f 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -94,6 +94,8 @@ static const TypeInfo aspeed_pcie_root_port_info = {
  * PCIe Root Complex (RC)
  */
 
+#define ASPEED_PCIE_CFG_RC_MAX_MSI 64
+
 static void aspeed_pcie_rc_set_irq(void *opaque, int irq, int level)
 {
     AspeedPCIERcState *rc = (AspeedPCIERcState *) opaque;
@@ -120,6 +122,58 @@ static int aspeed_pcie_rc_map_irq(PCIDevice *pci_dev, int irq_num)
     return irq_num % PCI_NUM_PINS;
 }
 
+static void aspeed_pcie_rc_msi_notify(AspeedPCIERcState *rc, uint64_t data)
+{
+    AspeedPCIECfgState *cfg =
+           container_of(rc, AspeedPCIECfgState, rc);
+    uint32_t reg;
+
+    /* Written data is the HW IRQ number */
+    assert(data < ASPEED_PCIE_CFG_RC_MAX_MSI);
+
+    reg = (data < 32) ?
+            cfg->rc_regs->msi_sts0_reg : cfg->rc_regs->msi_sts1_reg;
+    cfg->regs[reg] |= BIT(data % 32);
+
+    trace_aspeed_pcie_rc_msi_set_irq(cfg->id, data, 1);
+    qemu_set_irq(rc->irq, 1);
+}
+
+static void aspeed_pcie_rc_msi_write(void *opaque, hwaddr addr, uint64_t data,
+                                     unsigned int size)
+{
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(opaque);
+    AspeedPCIECfgState *cfg =
+           container_of(rc, AspeedPCIECfgState, rc);
+
+    trace_aspeed_pcie_rc_msi_notify(cfg->id, addr + rc->msi_addr, data);
+    aspeed_pcie_rc_msi_notify(rc, data);
+}
+
+static const MemoryRegionOps aspeed_pcie_rc_msi_ops = {
+    .write = aspeed_pcie_rc_msi_write,
+    .read = NULL,
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
+static AddressSpace *aspeed_pcie_rc_get_as(PCIBus *bus, void *opaque, int devfn)
+{
+    AspeedPCIERcState *rc = ASPEED_PCIE_RC(opaque);
+    return &rc->iommu_as;
+}
+
+static const PCIIOMMUOps aspeed_pcie_rc_iommu_ops = {
+    .get_address_space = aspeed_pcie_rc_get_as,
+};
+
 static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
 {
     PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
@@ -130,6 +184,8 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     g_autofree char *ioport_window_name = NULL;
     g_autofree char *mmio_window_name = NULL;
+    g_autofree char *iommu_root_name = NULL;
+    g_autofree char *dram_alias_name = NULL;
     g_autofree char *root_bus_name = NULL;
 
     /* PCI configuration space */
@@ -160,6 +216,43 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
                                      &rc->io, 0, 4, TYPE_PCIE_BUS);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 
+   /*
+    * PCIe memory view setup
+    *
+    * Background:
+    * - On AST2700, all Root Complexes use the same MSI address. This MSI
+    *   address is not normal system RAM - it is a PCI system memory address.
+    *   If we map the MSI/MSI-X window into real system memory, a write from
+    *   one EP can be seen by all RCs and wrongly trigger interrupts on them.
+    *
+    * Design:
+    * - MSI/MSI-X here is just a placeholder address so RC and EP can talk.
+    *   We make a separate MMIO space (iommu_root) for the MSI window so the
+    *   writes stay local to each RC.
+    *
+    * DMA:
+    * - EPs still need access to real system memory for DMA. We add a DRAM
+    *   alias in the PCI space so DMA works as expected.
+    */
+    iommu_root_name = g_strdup_printf("pcie.%d.iommu_root", cfg->id);
+    memory_region_init(&rc->iommu_root, OBJECT(rc), iommu_root_name,
+                       UINT64_MAX);
+    address_space_init(&rc->iommu_as, &rc->iommu_root, iommu_root_name);
+    /* setup MSI */
+    memory_region_init_io(&rc->msi_window, OBJECT(rc),
+                          &aspeed_pcie_rc_msi_ops, rc,
+                          "msi_window", 4);
+    memory_region_add_subregion(&rc->iommu_root, rc->msi_addr,
+                                &rc->msi_window);
+    /* setup DRAM for DMA */
+    assert(rc->dram_mr != NULL);
+    dram_alias_name = g_strdup_printf("pcie.%d.dram_alias", cfg->id);
+    memory_region_init_alias(&rc->dram_alias, OBJECT(rc), dram_alias_name,
+                             rc->dram_mr, 0, memory_region_size(rc->dram_mr));
+    memory_region_add_subregion(&rc->iommu_root, rc->dram_base,
+                                &rc->dram_alias);
+    pci_setup_iommu(pci->bus, &aspeed_pcie_rc_iommu_ops, rc);
+
     /* setup root device */
     if (rc->has_rd) {
         object_initialize_child(OBJECT(rc), "root_device", &rc->root_device,
@@ -205,6 +298,10 @@ static const Property aspeed_pcie_rc_props[] = {
     DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
     DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
     DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
+    DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
+    DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
+    DEFINE_PROP_LINK("dram", AspeedPCIERcState, dram_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
 };
 
 static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
@@ -265,6 +362,10 @@ REG32(H2X_RC_H_INT_STS,     0xC8)
     SHARED_FIELD(H2X_RC_INT_INTDONE, 4, 1)
     SHARED_FIELD(H2X_RC_INT_INTX, 0, 4)
 REG32(H2X_RC_H_RDATA,       0xCC)
+REG32(H2X_RC_H_MSI_EN0,     0xE0)
+REG32(H2X_RC_H_MSI_EN1,     0xE4)
+REG32(H2X_RC_H_MSI_STS0,    0xE8)
+REG32(H2X_RC_H_MSI_STS1,    0xEC)
 
 #define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
 #define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
@@ -278,6 +379,8 @@ static const AspeedPCIERegMap aspeed_regmap = {
     .rc = {
         .int_en_reg     = R_H2X_RC_H_INT_EN,
         .int_sts_reg    = R_H2X_RC_H_INT_STS,
+        .msi_sts0_reg   = R_H2X_RC_H_MSI_STS0,
+        .msi_sts1_reg   = R_H2X_RC_H_MSI_STS1,
     },
 };
 
@@ -447,6 +550,29 @@ static void aspeed_pcie_cfg_write(void *opaque, hwaddr addr, uint64_t data,
         }
         s->regs[reg] &= ~data | H2X_RC_INT_INTX_MASK;
         break;
+    /*
+     * These status registers are used for notify sources ISR are executed.
+     * If one source ISR is executed, it will clear one bit.
+     * If it clear all bits, it means to initialize this register status
+     * rather than sources ISR are executed.
+     */
+    case R_H2X_RC_H_MSI_STS0:
+    case R_H2X_RC_H_MSI_STS1:
+        if (data == 0) {
+            return ;
+        }
+
+        s->regs[reg] &= ~data;
+        if (data == 0xffffffff) {
+            return;
+        }
+
+        if (!s->regs[R_H2X_RC_H_MSI_STS0] &&
+            !s->regs[R_H2X_RC_H_MSI_STS1]) {
+            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);
+            qemu_set_irq(s->rc.irq, 0);
+        }
+        break;
     default:
         s->regs[reg] = data;
         break;
@@ -468,6 +594,8 @@ static void aspeed_pcie_cfg_instance_init(Object *obj)
     AspeedPCIECfgState *s = ASPEED_PCIE_CFG(obj);
 
     object_initialize_child(obj, "rc", &s->rc, TYPE_ASPEED_PCIE_RC);
+    object_property_add_alias(obj, "dram", OBJECT(&s->rc), "dram");
+    object_property_add_alias(obj, "dram-base", OBJECT(&s->rc), "dram-base");
 
     return;
 }
@@ -503,6 +631,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->rc), "rp-addr",
                             apc->rc_rp_addr,
                             &error_abort);
+    object_property_set_int(OBJECT(&s->rc), "msi-addr",
+                            apc->rc_msi_addr,
+                            &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
         return;
     }
@@ -534,6 +665,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->reg_ops = &aspeed_pcie_cfg_ops;
     apc->reg_map = &aspeed_regmap;
     apc->nr_regs = 0x100 >> 2;
+    apc->rc_msi_addr = 0x1e77005C;
     apc->rc_bus_nr = 0x80;
     apc->rc_has_rd = true;
     apc->rc_rp_addr = PCI_DEVFN(8, 0);
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 2584ea56e2..a6fd88c2c4 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -2,6 +2,9 @@
 
 # aspeed_pcie.c
 aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: num %d set IRQ leve %d"
+aspeed_pcie_rc_msi_notify(uint32_t id, uint64_t addr, uint64_t data) "%d: 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_pcie_rc_msi_set_irq(uint32_t id, uint64_t unm, int level) "%d: num 0x%" PRIx64 " set IRQ level %d"
+aspeed_pcie_rc_msi_clear_irq(uint32_t id, int level) "%d: clear IRQ level %d"
 aspeed_pcie_cfg_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
 aspeed_pcie_cfg_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
 aspeed_pcie_cfg_rw(uint32_t id, const char *dir, uint8_t bus, uint8_t devfn, uint64_t addr, uint64_t data) "%d: %s bus:0x%x devfn:0x%x addr 0x%" PRIx64 " data 0x%" PRIx64
-- 
2.43.0


