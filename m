Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4423CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 17:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H97-0005qJ-4g; Mon, 29 Sep 2025 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H89-0003Ih-P8
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H82-0002te-Tu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2U6rWp19NFzdr3JTPFFps2VKf4sWWNfyJ3udzJHNYw=;
 b=jOhCvvK7nIlA5/JW+ebLx3vWyh3r1ZpZiuXRdOi018k8ox5zYeiHwyY/9eX/CpxS+9OrbM
 gIzzJcIDQFZROCLwgpZeiY0TVNwZpmqXPTSaJt0i9uCMrNazpH4qEytc0+RJXQP5oBU8/E
 SwhGWPljquG0DgaIgL5PKubxCXFeOo0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-jRcVitJJMhCr4nh57_NqHw-1; Mon,
 29 Sep 2025 12:53:29 -0400
X-MC-Unique: jRcVitJJMhCr4nh57_NqHw-1
X-Mimecast-MFC-AGG-ID: jRcVitJJMhCr4nh57_NqHw_1759164808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B75019560B6; Mon, 29 Sep 2025 16:53:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 880311800446; Mon, 29 Sep 2025 16:53:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/32] hw/pci-host/aspeed: Add AST2700 PCIe config with
 dedicated H2X blocks
Date: Mon, 29 Sep 2025 18:52:21 +0200
Message-ID: <20250929165230.797471-24-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce PCIe config (H2X) support for the AST2700 SoC.

Unlike the AST2600, the AST2700 provides three independent Root Complexes,
each with its own H2X (AHB to PCIe bridge) register block of size 0x100.
All RCs use the same MSI address (0x000000F0). The H2X block includes
two different access paths:

1. CFGI (internal bridge): used to access the host bridge itself, always
   with BDF=0. The AST2700 controller simplifies the design by exposing
   only one register (H2X_CFGI_TLP) with fields for ADDR[15:0], BEN[19:16],
   and WR[20]. This is not a full TLP descriptor as in the external case.
   For QEMU readability and code reuse, the model converts H2X_CFGI_TLP
   into a standard TLP TX descriptor with BDF forced to 0 and then calls
   the existing helpers aspeed_pcie_cfg_readwrite() and
   aspeed_pcie_cfg_translate_write().

2. CFGE (external EP access): used to access external endpoints. The
   AST2700 design provides H2X_CFGE_TLP1 and a small FIFO at H2X_CFGE_TLPN.
   For reads, TX DESC0 is stored in TLP1 and DESC1/DESC2 in TLPN FIFO
   slots. For writes, TX DESC0 is stored in TLP1, DESC1/DESC2 in TLPN
   FIFO[0..1], and TX write data in TLPN FIFO[2].

The implementation extends AspeedPCIECfgState with a small FIFO and index,
wires up new register definitions for AST2700, and adds a specific ops
table and class (TYPE_ASPEED_2700_PCIE_CFG). The reset handler clears the
FIFO state. Interrupt and MSI status registers are also supported.

This provides enough modeling for firmware and drivers to use any of the
three PCIe RCs on AST2700 with their own dedicated H2X config window,
while reusing existing TLP decode helpers in QEMU.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250919093017.338309-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci-host/aspeed_pcie.h |   3 +
 hw/pci-host/aspeed_pcie.c         | 158 ++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 5806505f30ef..be53ea96b907 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -87,6 +87,7 @@ struct AspeedPCIERcState {
 
 /* Bridge between AHB bus and PCIe RC. */
 #define TYPE_ASPEED_PCIE_CFG "aspeed.pcie-cfg"
+#define TYPE_ASPEED_2700_PCIE_CFG TYPE_ASPEED_PCIE_CFG "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedPCIECfgState, AspeedPCIECfgClass, ASPEED_PCIE_CFG);
 
 struct AspeedPCIECfgState {
@@ -98,6 +99,8 @@ struct AspeedPCIECfgState {
 
     const AspeedPCIERcRegs *rc_regs;
     AspeedPCIERcState rc;
+    uint32_t tlpn_fifo[3];
+    uint32_t tlpn_idx;
 };
 
 struct AspeedPCIECfgClass {
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 788160d5325c..a757fd7ec850 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -338,6 +338,11 @@ static const TypeInfo aspeed_pcie_rc_info = {
  * - Registers 0x00 - 0x7F are shared by both PCIe0 (rc_l) and PCIe1 (rc_h).
  * - Registers 0x80 - 0xBF are specific to PCIe0.
  * - Registers 0xC0 - 0xFF are specific to PCIe1.
+ *
+ * On the AST2700:
+ * - The register range 0x00 - 0xFF is assigned to a single PCIe configuration.
+ * - There are three PCIe Root Complexes (RCs), each with its own dedicated H2X
+ *   register set of size 0x100 (covering offsets 0x00 to 0xFF).
  */
 
 /* AST2600 */
@@ -367,6 +372,31 @@ REG32(H2X_RC_H_MSI_EN1,     0xE4)
 REG32(H2X_RC_H_MSI_STS0,    0xE8)
 REG32(H2X_RC_H_MSI_STS1,    0xEC)
 
+/* AST2700 */
+REG32(H2X_CFGE_INT_STS,         0x08)
+    FIELD(H2X_CFGE_INT_STS, TX_IDEL, 0, 1)
+    FIELD(H2X_CFGE_INT_STS, RX_BUSY, 1, 1)
+REG32(H2X_CFGI_TLP,         0x20)
+    FIELD(H2X_CFGI_TLP, ADDR, 0, 16)
+    FIELD(H2X_CFGI_TLP, BEN, 16, 4)
+    FIELD(H2X_CFGI_TLP, WR, 20, 1)
+REG32(H2X_CFGI_WDATA,       0x24)
+REG32(H2X_CFGI_CTRL,        0x28)
+    FIELD(H2X_CFGI_CTRL, FIRE, 0, 1)
+REG32(H2X_CFGI_RDATA,       0x2C)
+REG32(H2X_CFGE_TLP1,        0x30)
+REG32(H2X_CFGE_TLPN,        0x34)
+REG32(H2X_CFGE_CTRL,        0x38)
+    FIELD(H2X_CFGE_CTRL, FIRE, 0, 1)
+REG32(H2X_CFGE_RDATA,       0x3C)
+REG32(H2X_INT_EN,          0x40)
+REG32(H2X_INT_STS,         0x48)
+    FIELD(H2X_INT_STS, INTX, 0, 4)
+REG32(H2X_MSI_EN0,          0x50)
+REG32(H2X_MSI_EN1,          0x54)
+REG32(H2X_MSI_STS0,         0x58)
+REG32(H2X_MSI_STS1,         0x5C)
+
 #define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
 #define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
 #define TLP_FMTTYPE_CFGRD1  0x05 /* Configuration Read  Type 1 */
@@ -384,6 +414,15 @@ static const AspeedPCIERegMap aspeed_regmap = {
     },
 };
 
+static const AspeedPCIERegMap aspeed_2700_regmap = {
+    .rc = {
+        .int_en_reg     = R_H2X_INT_EN,
+        .int_sts_reg    = R_H2X_INT_STS,
+        .msi_sts0_reg   = R_H2X_MSI_STS0,
+        .msi_sts1_reg   = R_H2X_MSI_STS1,
+    },
+};
+
 static uint64_t aspeed_pcie_cfg_read(void *opaque, hwaddr addr,
                                      unsigned int size)
 {
@@ -606,6 +645,8 @@ static void aspeed_pcie_cfg_reset(DeviceState *dev)
     AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
 
     memset(s->regs, 0, apc->nr_regs << 2);
+    memset(s->tlpn_fifo, 0, sizeof(s->tlpn_fifo));
+    s->tlpn_idx = 0;
 }
 
 static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
@@ -680,6 +721,122 @@ static const TypeInfo aspeed_pcie_cfg_info = {
     .class_size = sizeof(AspeedPCIECfgClass),
 };
 
+static void aspeed_2700_pcie_cfg_write(void *opaque, hwaddr addr,
+                                       uint64_t data, unsigned int size)
+{
+    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
+    AspeedPCIECfgTxDesc desc;
+    uint32_t reg = addr >> 2;
+
+    trace_aspeed_pcie_cfg_write(s->id, addr, data);
+
+    switch (reg) {
+    case R_H2X_CFGE_INT_STS:
+        if (data & R_H2X_CFGE_INT_STS_TX_IDEL_MASK) {
+            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
+        }
+
+        if (data & R_H2X_CFGE_INT_STS_RX_BUSY_MASK) {
+            s->regs[R_H2X_CFGE_INT_STS] &= ~R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
+        }
+        break;
+    case R_H2X_CFGI_CTRL:
+        if (data & R_H2X_CFGI_CTRL_FIRE_MASK) {
+            /*
+             * Internal access to bridge
+             * Type and BDF are 0
+             */
+            desc.desc0 = 0x04000001 |
+                (ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, WR) << 30);
+            desc.desc1 = 0x00401000 |
+                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, BEN);
+            desc.desc2 = 0x00000000 |
+                ARRAY_FIELD_EX32(s->regs, H2X_CFGI_TLP, ADDR);
+            desc.wdata = s->regs[R_H2X_CFGI_WDATA];
+            desc.rdata_reg = R_H2X_CFGI_RDATA;
+            aspeed_pcie_cfg_readwrite(s, &desc);
+        }
+        break;
+    case R_H2X_CFGE_TLPN:
+        s->tlpn_fifo[s->tlpn_idx] = data;
+        s->tlpn_idx = (s->tlpn_idx + 1) % ARRAY_SIZE(s->tlpn_fifo);
+        break;
+    case R_H2X_CFGE_CTRL:
+        if (data & R_H2X_CFGE_CTRL_FIRE_MASK) {
+            desc.desc0 = s->regs[R_H2X_CFGE_TLP1];
+            desc.desc1 = s->tlpn_fifo[0];
+            desc.desc2 = s->tlpn_fifo[1];
+            desc.wdata = s->tlpn_fifo[2];
+            desc.rdata_reg = R_H2X_CFGE_RDATA;
+            aspeed_pcie_cfg_readwrite(s, &desc);
+            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_TX_IDEL_MASK;
+            s->regs[R_H2X_CFGE_INT_STS] |= R_H2X_CFGE_INT_STS_RX_BUSY_MASK;
+            s->tlpn_idx = 0;
+        }
+        break;
+
+    case R_H2X_INT_STS:
+        s->regs[reg] &= ~data | R_H2X_INT_STS_INTX_MASK;
+        break;
+    /*
+     * These status registers are used for notify sources ISR are executed.
+     * If one source ISR is executed, it will clear one bit.
+     * If it clear all bits, it means to initialize this register status
+     * rather than sources ISR are executed.
+     */
+    case R_H2X_MSI_STS0:
+    case R_H2X_MSI_STS1:
+        if (data == 0) {
+            return ;
+        }
+
+        s->regs[reg] &= ~data;
+        if (data == 0xffffffff) {
+            return;
+        }
+
+        if (!s->regs[R_H2X_MSI_STS0] &&
+            !s->regs[R_H2X_MSI_STS1]) {
+            trace_aspeed_pcie_rc_msi_clear_irq(s->id, 0);
+            qemu_set_irq(s->rc.irq, 0);
+        }
+        break;
+    default:
+        s->regs[reg] = data;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_2700_pcie_cfg_ops = {
+    .read = aspeed_pcie_cfg_read,
+    .write = aspeed_2700_pcie_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 PCIe Config";
+    apc->reg_ops = &aspeed_2700_pcie_cfg_ops;
+    apc->reg_map = &aspeed_2700_regmap;
+    apc->nr_regs = 0x100 >> 2;
+    apc->rc_msi_addr = 0x000000F0;
+    apc->rc_bus_nr = 0;
+}
+
+static const TypeInfo aspeed_2700_pcie_cfg_info = {
+    .name = TYPE_ASPEED_2700_PCIE_CFG,
+    .parent = TYPE_ASPEED_PCIE_CFG,
+    .class_init = aspeed_2700_pcie_cfg_class_init,
+};
+
 /*
  * PCIe PHY
  *
@@ -847,6 +1004,7 @@ static void aspeed_pcie_register_types(void)
     type_register_static(&aspeed_pcie_root_device_info);
     type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
+    type_register_static(&aspeed_2700_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
     type_register_static(&aspeed_2700_pcie_phy_info);
 }
-- 
2.51.0


