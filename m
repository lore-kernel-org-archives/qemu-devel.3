Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE6ED25929
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgW-0004Hp-Jo; Mon, 26 Jan 2026 22:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgV-0004Gn-2m; Mon, 26 Jan 2026 22:24:07 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgT-0003Z2-Lp; Mon, 26 Jan 2026 22:24:06 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 11:23:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 11:23:49 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/7] hw/pci-host/aspeed_pcie: Drop AST2600 RC_H root-bus
 remap and bus-nr property
Date: Tue, 27 Jan 2026 11:23:39 +0800
Message-ID: <20260127032348.2238527-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
References: <20260127032348.2238527-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The original AST2600 PCIe design supported both RC_L and RC_H, using root bus
number 0 for RC_L and 0x80 for RC_H. In that model, the root port appeared as
80:08.0 and QEMU carried a "bus-nr" property plus a config-space bus remap to
translate bus 0x80 to bus 0x00 for PCI enumeration.

Linux mainline has since dropped RC_L support and updated the RC_H root bus
number to start at 0. The root port is now enumerated as 00:08.0, matching the
default QEMU PCIe subsystem root bus numbering.

Remove the bus number setting and the AST2600 bus remap logic, and drop the
corresponding "bus-nr"/rc_bus_nr fields and property plumbing. QEMU now relies
on the default root bus 0 behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/pci-host/aspeed_pcie.h |  2 --
 hw/pci-host/aspeed_pcie.c         | 19 +------------------
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index fde5816ea3..143b356591 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -69,7 +69,6 @@ struct AspeedPCIERcState {
     uint64_t dram_base;
     uint32_t msi_addr;
     uint32_t rp_addr;
-    uint32_t bus_nr;
     char name[16];
     qemu_irq irq;
 
@@ -102,7 +101,6 @@ struct AspeedPCIECfgClass {
 
     uint32_t rc_msi_addr;
     uint32_t rc_rp_addr;
-    uint64_t rc_bus_nr;
     uint64_t nr_regs;
     bool rc_has_rd;
 };
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 4fdda95939..4f896f855c 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -268,7 +268,7 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
     AspeedPCIECfgState *cfg =
            container_of(rc, AspeedPCIECfgState, rc);
 
-    snprintf(rc->name, sizeof(rc->name), "%04x:%02x", cfg->id, rc->bus_nr);
+    snprintf(rc->name, sizeof(rc->name), "%04x:00", cfg->id);
 
     return rc->name;
 }
@@ -283,7 +283,6 @@ static void aspeed_pcie_rc_instance_init(Object *obj)
 }
 
 static const Property aspeed_pcie_rc_props[] = {
-    DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
     DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
     DEFINE_PROP_UINT32("msi-addr", AspeedPCIERcState, msi_addr, 0),
     DEFINE_PROP_UINT64("dram-base", AspeedPCIERcState, dram_base, 0),
@@ -490,17 +489,6 @@ static void aspeed_pcie_cfg_readwrite(AspeedPCIECfgState *s,
     offset = cfg_addr & 0xffc;
 
     pci = PCI_HOST_BRIDGE(rc);
-
-    /*
-     * On the AST2600, the RC_H bus number range from 0x80 to 0xFF, with the
-     * root device and root port assigned to bus 0x80 instead of the standard
-     * 0x00. To allow the PCI subsystem to correctly discover devices on the
-     * root bus, bus 0x80 is remapped to 0x00.
-     */
-    if (bus == rc->bus_nr) {
-        bus = 0;
-    }
-
     pdev = pci_find_device(pci->bus, bus, devfn);
     if (!pdev) {
         s->regs[desc->rdata_reg] = ~0;
@@ -650,9 +638,6 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
                           apc->nr_regs << 2);
     sysbus_init_mmio(sbd, &s->mmio);
 
-    object_property_set_int(OBJECT(&s->rc), "bus-nr",
-                            apc->rc_bus_nr,
-                            &error_abort);
     object_property_set_int(OBJECT(&s->rc), "rp-addr",
                             apc->rc_rp_addr,
                             &error_abort);
@@ -691,7 +676,6 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
     apc->reg_map = &aspeed_regmap;
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x1e77005C;
-    apc->rc_bus_nr = 0x80;
     apc->rc_rp_addr = PCI_DEVFN(8, 0);
 }
 
@@ -811,7 +795,6 @@ static void aspeed_2700_pcie_cfg_class_init(ObjectClass *klass,
     apc->reg_map = &aspeed_2700_regmap;
     apc->nr_regs = 0x100 >> 2;
     apc->rc_msi_addr = 0x000000F0;
-    apc->rc_bus_nr = 0;
     apc->rc_rp_addr = PCI_DEVFN(0, 0);
 }
 
-- 
2.43.0


