Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0743ECFA470
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 04:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMISM-0002Aa-Bv; Thu, 20 Nov 2025 23:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vMISH-00029g-Vw; Thu, 20 Nov 2025 23:09:06 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vMISG-0006w9-Ga; Thu, 20 Nov 2025 23:09:05 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 21 Nov
 2025 12:08:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 21 Nov 2025 12:08:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <nabihestefan@google.com>
Subject: [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port
 capabilities and enable MSI to support hotplug
Date: Fri, 21 Nov 2025 12:08:49 +0800
Message-ID: <20251121040849.3287437-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121040849.3287437-1-jamin_lin@aspeedtech.com>
References: <20251121040849.3287437-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch updates the ASPEED PCIe Root Port capability layout and interrupt
handling to match the hardware-defined capability structure as documented in
the PCI Express Controller (PCIE) chapter of the ASPEED SoC datasheet.

The following capability offsets and fields are now aligned with the actual
hardware implementation (validated using EVB config-space dumps via
'lspci -s <bdf> -vvv'):

- Added MSI capability at offset 0x50 and enabled 1-vector MSI support
- Added PCI Express Capability structure at offset 0x80
- Added Secondary Subsystem Vendor ID (SSVID) at offset 0xC0
- Added AER capability at offset 0x100
- Implemented aer_vector() callback and MSI init/uninit hooks
- Updated Root Port SSID to 0x1150 to reflect the platform default

Enabling MSI is required for proper PCIe Hotplug event signaling. This change
improves correctness and ensures QEMU Root Port behavior matches the behavior
of ASPEED hardware and downstream kernel expectations.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index f7593444fc..1fc2c61772 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -68,6 +68,38 @@ static const TypeInfo aspeed_pcie_root_device_info = {
  * PCIe Root Port
  */
 
+#define ASPEED_PCIE_ROOT_PORT_MSI_OFFSET        0x50
+#define ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR     1
+#define ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET      0xC0
+#define ASPEED_PCIE_ROOT_PORT_EXP_OFFSET        0x80
+#define ASPEED_PCIE_ROOT_PORT_AER_OFFSET        0x100
+
+static uint8_t aspeed_pcie_root_port_aer_vector(const PCIDevice *d)
+{
+    return 0;
+}
+
+static int aspeed_pcie_root_port_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msi_init(d, ASPEED_PCIE_ROOT_PORT_MSI_OFFSET,
+                  ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR,
+                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_64BIT,
+                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    }
+
+    return rc;
+}
+
+static void aspeed_pcie_root_port_interrupts_uninit(PCIDevice *d)
+{
+    msi_uninit(d);
+}
+
 static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
                                              const void *data)
 {
@@ -80,7 +112,13 @@ static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
     k->device_id = 0x1150;
     dc->user_creatable = true;
 
-    rpc->aer_offset = 0x100;
+    rpc->aer_vector = aspeed_pcie_root_port_aer_vector;
+    rpc->interrupts_init = aspeed_pcie_root_port_interrupts_init;
+    rpc->interrupts_uninit = aspeed_pcie_root_port_interrupts_uninit;
+    rpc->exp_offset = ASPEED_PCIE_ROOT_PORT_EXP_OFFSET;
+    rpc->aer_offset = ASPEED_PCIE_ROOT_PORT_AER_OFFSET;
+    rpc->ssvid_offset = ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET;
+    rpc->ssid = 0x1150;
 }
 
 static const TypeInfo aspeed_pcie_root_port_info = {
-- 
2.43.0


