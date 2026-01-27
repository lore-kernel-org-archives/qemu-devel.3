Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36035D25929
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 03:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkZgZ-0004Ii-AK; Mon, 26 Jan 2026 22:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgX-0004I9-CQ; Mon, 26 Jan 2026 22:24:09 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkZgW-0003Z2-2Q; Mon, 26 Jan 2026 22:24:09 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 11:23:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 11:23:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 4/7] hw/arm/aspeed_ast2600: Expand RC_H PCIe MMIO window to
 0x60000000 - 0x80000000
Date: Tue, 27 Jan 2026 11:23:40 +0800
Message-ID: <20260127032348.2238527-5-jamin_lin@aspeedtech.com>
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

Historically, the ASPEED PCIe driver supported both RC_L and RC_H, with RC_L
using MMIO window 0x60000000 - 0x70000000 and RC_H using 0x70000000 - 0x80000000.

Mainline Linux has dropped RC_L support and now supports RC_H only, updating
RC_H to use a single combined MMIO window 0x60000000 - 0x80000000.

Update the AST2600 QEMU model accordingly by moving PCIE_MMIO1 base to
0x60000000 and increasing the aliased MMIO size to 0x20000000.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast2600.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 4c5a42ea17..efb1d8c063 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -81,7 +81,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_FSI1]      = 0x1E79B000,
     [ASPEED_DEV_FSI2]      = 0x1E79B100,
     [ASPEED_DEV_I3C]       = 0x1E7A0000,
-    [ASPEED_DEV_PCIE_MMIO1] = 0x70000000,
+    [ASPEED_DEV_PCIE_MMIO1] = 0x60000000,
     [ASPEED_DEV_SDRAM]     = 0x80000000,
 };
 
@@ -303,14 +303,14 @@ static uint64_t aspeed_calc_affinity(int cpu)
  *
  * Model scope / limitations:
  *   - Firmware supports RC_H only; this QEMU model does not support RC_L.
- *   - RC_H uses PHY1 and the MMIO window [0x70000000, 0x80000000]
+ *   - RC_H uses PHY1 and the MMIO window [0x60000000, 0x80000000]
  *     (aka MMIO1).
  *
  * Indexing convention (this model):
  *   - Expose a single logical instance at index 0.
  *   - pcie[0] -> hardware RC_H (PCIe1)
  *   - phy[0]  -> hardware PHY1
- *   - mmio.0 -> guest address range MMIO1: 0x70000000-0x80000000
+ *   - mmio.0 -> guest address range MMIO1: 0x60000000-0x80000000
  *   - RC_L / PCIe0 is not created and mapped.
  */
 static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
@@ -346,7 +346,7 @@ static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
     memory_region_init_alias(&s->pcie_mmio_alias[0], OBJECT(&s->pcie[0].rc),
                              "aspeed.pcie-mmio", mmio_mr,
                              sc->memmap[ASPEED_DEV_PCIE_MMIO1],
-                             0x10000000);
+                             0x20000000);
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_PCIE_MMIO1],
                                 &s->pcie_mmio_alias[0]);
-- 
2.43.0


