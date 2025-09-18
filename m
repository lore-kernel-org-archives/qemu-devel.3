Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822BCCAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 03:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz56d-00069E-D1; Wed, 17 Sep 2025 23:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uz56I-0005st-K3; Wed, 17 Sep 2025 23:14:28 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uz56G-0005cU-T1; Wed, 17 Sep 2025 23:14:26 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 18 Sep
 2025 11:13:52 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 11:13:52 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>, <wuhaotsh@google.com>, <titusr@google.com>
Subject: [PATCH v3 09/14] hw/pci-host/aspeed: Add AST2700 PCIe PHY
Date: Thu, 18 Sep 2025 11:13:38 +0800
Message-ID: <20250918031348.3991681-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918031348.3991681-1-jamin_lin@aspeedtech.com>
References: <20250918031348.3991681-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Introduce a PCIe Host Controller PHY model for AST2700. This adds an
AST2700 specific PHY type (TYPE_ASPEED_2700_PCIE_PHY) with a 0x800 byte
register space and link-status bits compatible with the firmware’s
expectations.

AST2700 provides three PCIe RCs; PCIe0 and PCIe1 are GEN4, PCIe2 is
GEN2. The PHY exposes:
PEHR_2700_LINK_GEN2 at 0x344, bit 18 indicates GEN2 link up
PEHR_2700_LINK_GEN4 at 0x358, bit 8 indicates GEN4 link up

In real hardware these GEN2/GEN4 link bits are mutually exclusive.
QEMU does not model GEN2 vs GEN4 signaling differences, so the reset
handler sets both bits to 1. This keeps the model simple and lets
firmware see the link as up; firmware will read the appropriate
register per RC port to infer the intended mode.

The header gains TYPE_ASPEED_2700_PCIE_PHY; the new class derives from
TYPE_ASPEED_PCIE_PHY, sets nr_regs to 0x800 >> 2, and installs an
AST2700 reset routine that programs the class code (0x06040011) and the
GEN2/GEN4 status bits.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/pci-host/aspeed_pcie.h |  1 +
 hw/pci-host/aspeed_pcie.c         | 39 +++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
index 5e60cba07b..5806505f30 100644
--- a/include/hw/pci-host/aspeed_pcie.h
+++ b/include/hw/pci-host/aspeed_pcie.h
@@ -114,6 +114,7 @@ struct AspeedPCIECfgClass {
 };
 
 #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
+#define TYPE_ASPEED_2700_PCIE_PHY TYPE_ASPEED_PCIE_PHY "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedPCIEPhyState, AspeedPCIEPhyClass, ASPEED_PCIE_PHY);
 
 struct AspeedPCIEPhyState {
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index bff01ac85a..266fe6e7b0 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -690,6 +690,12 @@ REG32(PEHR_PROTECT,     0x7C)
 REG32(PEHR_LINK,        0xC0)
     FIELD(PEHR_LINK, STS, 5, 1)
 
+/* AST2700 */
+REG32(PEHR_2700_LINK_GEN2,  0x344)
+    FIELD(PEHR_2700_LINK_GEN2, STS, 18, 1)
+REG32(PEHR_2700_LINK_GEN4,  0x358)
+    FIELD(PEHR_2700_LINK_GEN4, STS, 8, 1)
+
 #define ASPEED_PCIE_PHY_UNLOCK  0xA8
 
 static uint64_t aspeed_pcie_phy_read(void *opaque, hwaddr addr,
@@ -797,6 +803,38 @@ static const TypeInfo aspeed_pcie_phy_info = {
     .class_size = sizeof(AspeedPCIEPhyClass),
 };
 
+static void aspeed_2700_pcie_phy_reset(DeviceState *dev)
+{
+    AspeedPCIEPhyState *s = ASPEED_PCIE_PHY(dev);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_GET_CLASS(s);
+
+    memset(s->regs, 0, apc->nr_regs << 2);
+
+    s->regs[R_PEHR_ID] =
+        (0x1150 << R_PEHR_ID_DEV_SHIFT) | PCI_VENDOR_ID_ASPEED;
+    s->regs[R_PEHR_CLASS_CODE] = 0x06040011;
+    s->regs[R_PEHR_2700_LINK_GEN2] = R_PEHR_2700_LINK_GEN2_STS_MASK;
+    s->regs[R_PEHR_2700_LINK_GEN4] = R_PEHR_2700_LINK_GEN4_STS_MASK;
+}
+
+static void aspeed_2700_pcie_phy_class_init(ObjectClass *klass,
+                                            const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedPCIEPhyClass *apc = ASPEED_PCIE_PHY_CLASS(klass);
+
+    dc->desc = "ASPEED AST2700 PCIe Phy";
+    device_class_set_legacy_reset(dc, aspeed_2700_pcie_phy_reset);
+
+    apc->nr_regs = 0x800 >> 2;
+}
+
+static const TypeInfo aspeed_2700_pcie_phy_info = {
+    .name       = TYPE_ASPEED_2700_PCIE_PHY,
+    .parent     = TYPE_ASPEED_PCIE_PHY,
+    .class_init = aspeed_2700_pcie_phy_class_init,
+};
+
 static void aspeed_pcie_register_types(void)
 {
     type_register_static(&aspeed_pcie_rc_info);
@@ -804,6 +842,7 @@ static void aspeed_pcie_register_types(void)
     type_register_static(&aspeed_pcie_root_port_info);
     type_register_static(&aspeed_pcie_cfg_info);
     type_register_static(&aspeed_pcie_phy_info);
+    type_register_static(&aspeed_2700_pcie_phy_info);
 }
 
 type_init(aspeed_pcie_register_types);
-- 
2.43.0


