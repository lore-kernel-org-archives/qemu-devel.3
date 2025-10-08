Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6634CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Kl1-0001mV-M1; Tue, 07 Oct 2025 23:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl0-0001mI-Ce; Tue, 07 Oct 2025 23:22:26 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kky-0000T8-GO; Tue, 07 Oct 2025 23:22:26 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:08 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 03/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_soc_uart_set_chr() API
Date: Wed, 8 Oct 2025 11:21:48 +0800
Message-ID: <20251008032207.593353-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
References: <20251008032207.593353-1-jamin_lin@aspeedtech.com>
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

Refactor the aspeed_soc_uart_set_chr() helper to remove its dependency
on AspeedSoCState and make the UART character device binding more
generic.

The function now takes SerialMM *uart, uarts_base, and uarts_num
as arguments instead of relying on AspeedSoCState. All affected call
sites in aspeed.c, aspeed_ast27x0-fc.c, and fby35.c are updated
to use the new parameter format.

This improves API flexibility and enables reuse across different Aspeed
SoC variants without requiring access to internal SoC state.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed.c             |  6 ++++--
 hw/arm/aspeed_ast27x0-fc.c  | 13 ++++++++++---
 hw/arm/aspeed_soc_common.c  | 10 +++++-----
 hw/arm/fby35.c              | 10 ++++++++--
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 0162738f88..c870bf5586 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -306,7 +306,8 @@ enum {
 
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
-void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr);
+void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
+                             int uarts_num, Chardev *chr);
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
 void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr);
 void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 19944ea026..cbd9a0932b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -299,12 +299,14 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
 
-    aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
+    aspeed_soc_uart_set_chr(s->uart, uart_chosen, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     for (int i = 1, uart = sc->uarts_base; i < sc->uarts_num; uart++) {
         if (uart == uart_chosen) {
             continue;
         }
-        aspeed_soc_uart_set_chr(s, uart, serial_hd(i++));
+        aspeed_soc_uart_set_chr(s->uart, uart, sc->uarts_base, sc->uarts_num,
+                                serial_hd(i++));
     }
 }
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 2e16a0340a..e598f57ca2 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -91,7 +91,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
                             AST2700FC_HW_STRAP1, &error_abort);
     object_property_set_int(OBJECT(&s->ca35), "hw-strap2",
                             AST2700FC_HW_STRAP2, &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART12, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART12, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return false;
     }
@@ -115,6 +116,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
@@ -128,7 +130,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
                              OBJECT(&s->ssp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->ssp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART4, serial_hd(1));
+    sc = ASPEED_SOC_GET_CLASS(soc);
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
+                            sc->uarts_num, serial_hd(1));
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
@@ -139,6 +143,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
@@ -152,7 +157,9 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
                              OBJECT(&s->tsp_memory), &error_abort);
 
     soc = ASPEED_SOC(&s->tsp);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART7, serial_hd(2));
+    sc = ASPEED_SOC_GET_CLASS(soc);
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
+                            sc->uarts_num, serial_hd(2));
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a4e74acdce..ddcbba0020 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -59,15 +59,15 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
     return true;
 }
 
-void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
+void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
+                             int uarts_num, Chardev *chr)
 {
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int uart_first = aspeed_uart_first(sc->uarts_base);
+    int uart_first = aspeed_uart_first(uarts_base);
     int uart_index = aspeed_uart_index(dev);
     int i = uart_index - uart_first;
 
-    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
-    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+    g_assert(0 <= i && i < ASPEED_UARTS_NUM && i < uarts_num);
+    qdev_prop_set_chr(DEVICE(&uart[i]), "chardev", chr);
 }
 
 /*
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c14fc2efe9..5a94c847d3 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -71,9 +71,11 @@ static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, MemoryRegion *mr,
 static void fby35_bmc_init(Fby35State *s)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
 
     object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3");
     soc = ASPEED_SOC(&s->bmc);
+    sc = ASPEED_SOC_GET_CLASS(soc);
 
     memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
                        UINT64_MAX);
@@ -91,7 +93,8 @@ static void fby35_bmc_init(Fby35State *s)
                             &error_abort);
     object_property_set_int(OBJECT(&s->bmc), "hw-strap2", 0x00000003,
                             &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART5, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
+                            sc->uarts_num, serial_hd(0));
     qdev_realize(DEVICE(&s->bmc), NULL, &error_abort);
 
     aspeed_board_init_flashes(&soc->fmc, "n25q00", 2, 0);
@@ -118,12 +121,14 @@ static void fby35_bmc_init(Fby35State *s)
 static void fby35_bic_init(Fby35State *s)
 {
     AspeedSoCState *soc;
+    AspeedSoCClass *sc;
 
     s->bic_sysclk = clock_new(OBJECT(s), "SYSCLK");
     clock_set_hz(s->bic_sysclk, 200000000ULL);
 
     object_initialize_child(OBJECT(s), "bic", &s->bic, "ast1030-a1");
     soc = ASPEED_SOC(&s->bic);
+    sc = ASPEED_SOC_GET_CLASS(soc);
 
     memory_region_init(&s->bic_memory, OBJECT(&s->bic), "bic-memory",
                        UINT64_MAX);
@@ -131,7 +136,8 @@ static void fby35_bic_init(Fby35State *s)
     qdev_connect_clock_in(DEVICE(&s->bic), "sysclk", s->bic_sysclk);
     object_property_set_link(OBJECT(&s->bic), "memory", OBJECT(&s->bic_memory),
                              &error_abort);
-    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART5, serial_hd(1));
+    aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART5, sc->uarts_base,
+                            sc->uarts_num, serial_hd(1));
     qdev_realize(DEVICE(&s->bic), NULL, &error_abort);
 
     aspeed_board_init_flashes(&soc->fmc, "sst25vf032b", 2, 2);
-- 
2.43.0


