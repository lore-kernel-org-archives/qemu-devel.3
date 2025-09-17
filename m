Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EADCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyh1t-0006Dq-BO; Tue, 16 Sep 2025 21:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1n-0006Bl-3F; Tue, 16 Sep 2025 21:32:11 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uyh1l-0006vf-1U; Tue, 16 Sep 2025 21:32:10 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 17 Sep
 2025 09:31:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 17 Sep 2025 09:31:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/6] hw/arm/aspeed: Add AST1700 IO expander
Date: Wed, 17 Sep 2025 09:31:38 +0800
Message-ID: <20250917013143.1600377-4-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
References: <20250917013143.1600377-1-kane_chen@aspeedtech.com>
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

AST27x0 machines can carry up to two AST1700-based IO expander boards.
This change introduces a lightweight AST1700 SoC container and maps two
separate LTPI IO windows for those expanders.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 20 ++++++++++++++++++--
 hw/arm/aspeed_ast27x0.c     | 17 ++++++++++++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 72eefb0327..648c8d5c00 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -52,6 +52,21 @@
 #define ASPEED_JTAG_NUM  2
 #define ASPEED_IOEXP_NUM 2
 
+typedef struct {
+    MemoryRegion *memory;
+    MemoryRegion container;
+    AddressSpace dram_as;
+
+    AspeedSMCState spi;
+    AspeedADCState adc;
+    AspeedSCUState scu;
+    AspeedGPIOState gpio;
+    AspeedI2CState i2c;
+    AspeedI3CState i3c;
+    SerialMM uart;
+    AspeedWDTState wdt[ASPEED_WDTS_NUM];
+} AspeedAST1700SoCState;
+
 struct AspeedSoCState {
     DeviceState parent;
 
@@ -102,10 +117,10 @@ struct AspeedSoCState {
     UnimplementedDeviceState espi;
     UnimplementedDeviceState udc;
     UnimplementedDeviceState sgpiom;
-    UnimplementedDeviceState ltpi;
     UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
+    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
     uint8_t ioexp_num;
 };
 
@@ -206,7 +221,8 @@ enum {
     ASPEED_DEV_IOMEM,
     ASPEED_DEV_IOMEM0,
     ASPEED_DEV_IOMEM1,
-    ASPEED_DEV_LTPI,
+    ASPEED_DEV_LTPI_IO0,
+    ASPEED_DEV_LTPI_IO1,
     ASPEED_DEV_UART0,
     ASPEED_DEV_UART1,
     ASPEED_DEV_UART2,
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 3f93554027..2e180c8cc5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -83,8 +83,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_LTPI_CTRL1] =  0x14C34000,
     [ASPEED_DEV_LTPI_CTRL2] =  0x14C35000,
     [ASPEED_DEV_WDT]       =  0x14C37000,
+    [ASPEED_DEV_LTPI_IO0]  =  0x30000000,
+    [ASPEED_DEV_LTPI_IO1]  =  0x50000000,
     [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
-    [ASPEED_DEV_LTPI]      =  0x300000000,
     [ASPEED_DEV_SDRAM]     =  0x400000000,
 };
 
@@ -523,7 +524,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "hace", &s->hace, typename);
     object_initialize_child(obj, "dpmcu", &s->dpmcu,
                             TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "ltpi", &s->ltpi,
+    object_initialize_child(obj, "ltpi0", &s->ioexp[0],
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    object_initialize_child(obj, "ltpi1", &s->ioexp[1],
                             TYPE_UNIMPLEMENTED_DEVICE);
     object_initialize_child(obj, "iomem", &s->iomem,
                             TYPE_UNIMPLEMENTED_DEVICE);
@@ -968,9 +971,13 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ltpi),
-                                  "aspeed.ltpi",
-                                  sc->memmap[ASPEED_DEV_LTPI],
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ioexp[0]),
+                                  "aspeed.ltpi.0",
+                                  sc->memmap[ASPEED_DEV_LTPI_IO0],
+                                  AST2700_SOC_LTPI_SIZE);
+    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ioexp[1]),
+                                  "aspeed.ltpi.1",
+                                  sc->memmap[ASPEED_DEV_LTPI_IO1],
                                   AST2700_SOC_LTPI_SIZE);
     aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem),
                                   "aspeed.io",
-- 
2.43.0


