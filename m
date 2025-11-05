Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609ADCCFA04
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 04:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGUfz-0007To-Ti; Tue, 04 Nov 2025 22:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUfy-0007Sv-L0; Tue, 04 Nov 2025 22:59:14 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vGUfx-0006sZ-1l; Tue, 04 Nov 2025 22:59:14 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 5 Nov
 2025 11:59:00 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 5 Nov 2025 11:59:00 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v2 02/17] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
Date: Wed, 5 Nov 2025 11:58:40 +0800
Message-ID: <20251105035859.3709907-3-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Connect the LTPI controller device (representing the AST1700 I/O
expander) to the AST27X0 SoC model. This patch sets up the memory
mapping and device registration according to the AST2700 SoC design,
where the LTPI controller is exposed at fixed MMIO regions.

This change only handles device instantiation and integration,
without implementing the controller's internal logic.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  5 +++++
 hw/arm/aspeed_ast27x0.c     | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4b8e599f1a..bae60d85ea 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -42,6 +42,7 @@
 #include "hw/fsi/aspeed_apb2opb.h"
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/misc/aspeed_ltpi.h"
 
 #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
 
@@ -53,6 +54,7 @@
 #define ASPEED_UARTS_NUM 13
 #define ASPEED_JTAG_NUM  2
 #define ASPEED_PCIE_NUM  3
+#define ASPEED_IOEXP_NUM 2
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -110,6 +112,7 @@ struct AspeedSoCState {
     UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
+    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
 };
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -275,6 +278,8 @@ enum {
     ASPEED_GIC_REDIST,
     ASPEED_DEV_IPC0,
     ASPEED_DEV_IPC1,
+    ASPEED_DEV_LTPI_CTRL1,
+    ASPEED_DEV_LTPI_CTRL2,
 };
 
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index c484bcd4e2..c0d8639bde 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -86,6 +86,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_UART10]    =  0x14C33900,
     [ASPEED_DEV_UART11]    =  0x14C33A00,
     [ASPEED_DEV_UART12]    =  0x14C33B00,
+    [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
+    [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
     [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
     [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
@@ -543,6 +545,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
         object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abort);
     }
 
+    for (i = 0; i < ASPEED_IOEXP_NUM; i++) {
+        object_initialize_child(obj, "ltpi-ctrl[*]",
+                                &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
+    }
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "ltpi", &s->ltpi,
@@ -688,6 +694,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     g_autofree char *name = NULL;
     qemu_irq irq;
     int uart;
+    AspeedLTPIState *ltpi_ctrl;
+    hwaddr ltpi_base;
 
     /* Default boot region (SPI memory or ROMs) */
     memory_region_init(&s->spi_boot_container, OBJECT(s),
@@ -1021,6 +1029,16 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* LTPI controller */
+    for (i = 0; i < ASPEED_IOEXP_NUM; i++) {
+        ltpi_ctrl = ASPEED_LTPI(&s->ltpi_ctrl[i]);
+        ltpi_base = sc->memmap[ASPEED_DEV_LTPI_CTRL1 + i];
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
+            return;
+        }
+        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_base);
+    }
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
-- 
2.43.0


