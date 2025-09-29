Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9CDCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H9C-00062Q-W6; Mon, 29 Sep 2025 12:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H82-0003A4-0h
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7r-0002rY-Kn
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KarvY258CO+qGbZYaxLcYYSSCKfsUT69pn/0zKHdWyE=;
 b=bkz1nBxCsaNSGXyqfyhOQxkz9zv14DWxDf25VRpjpV/xl9JZBmeTyzFvnIv/InWiPDt6q2
 KWOXpzzPyQBFkjFOrPf5DuZrVp478l9K6/3bB/ck0EooaYdRn+/PrHF5K3JI2taz1voxlT
 Fr8nts8eU/hPY/KvCA8bIS6Ryzd31VM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-qg4d_hfCPoOq-lAEhaemyg-1; Mon,
 29 Sep 2025 12:53:20 -0400
X-MC-Unique: qg4d_hfCPoOq-lAEhaemyg-1
X-Mimecast-MFC-AGG-ID: qg4d_hfCPoOq-lAEhaemyg_1759164799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7681A1800350; Mon, 29 Sep 2025 16:53:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D33A61800452; Mon, 29 Sep 2025 16:53:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/32] hw/pci-host/aspeed: Add MSI support and per-RC IOMMU
 address space
Date: Mon, 29 Sep 2025 18:52:17 +0200
Message-ID: <20250929165230.797471-20-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |  10 +++
 hw/pci-host/aspeed_pcie.c         | 132 ++++++++++++++++++++++++++++++
 hw/pci-host/trace-events          |   3 +
 3 files changed, 145 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 5346c15c8101..5e60cba07b66 100644
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
index dafffbde61b9..8be55b962fc7 100644
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
index 2584ea56e2cc..a6fd88c2c466 100644
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
2.51.0


