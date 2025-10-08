Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4105CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 03:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6KlC-0001qI-By; Tue, 07 Oct 2025 23:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6KlA-0001ps-L0; Tue, 07 Oct 2025 23:22:36 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6Kl8-0000T8-Ll; Tue, 07 Oct 2025 23:22:36 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 8 Oct
 2025 11:22:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 8 Oct 2025 11:22:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 06/16] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_mmio_map_unimplemented() API
Date: Wed, 8 Oct 2025 11:21:51 +0800
Message-ID: <20251008032207.593353-7-jamin_lin@aspeedtech.com>
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

Refactor aspeed_mmio_map_unimplemented() to take MemoryRegion *
instead of AspeedSoCState *, removing its dependency on SoC state and
aligning it with the updated aspeed_mmio_map() interface.

All related call sites are updated to explicitly pass s->memory.
Affected files include headers, aspeed_soc_common.c, and SoC realize
functions in AST10x0, AST2400, AST2600, AST27x0 (SSP/TSP), and AST2700.

This change simplifies the MMIO mapping helpers, improves API
consistency, and reduces coupling between SoC logic and memory
operations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 +-
 hw/arm/aspeed_ast10x0.c     | 24 ++++++++++++++++--------
 hw/arm/aspeed_ast2400.c     |  6 ++++--
 hw/arm/aspeed_ast2600.c     | 12 ++++++++----
 hw/arm/aspeed_ast27x0-ssp.c |  8 ++++----
 hw/arm/aspeed_ast27x0-tsp.c |  8 ++++----
 hw/arm/aspeed_ast27x0.c     | 10 +++++-----
 hw/arm/aspeed_soc_common.c  |  4 ++--
 8 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 606cf6bb61..957362b88d 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -310,7 +310,7 @@ void aspeed_soc_uart_set_chr(SerialMM *uart, int dev, int uarts_base,
 bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp);
 void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
                      hwaddr addr);
-void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
+void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                    const char *name, hwaddr addr,
                                    uint64_t size);
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index caa9feb667..e861b6dad6 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -201,10 +201,12 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* General I/O memory space to catch all unimplemented device */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->sbc_unimplemented),
+    aspeed_mmio_map_unimplemented(s->memory,
+                                  SYS_BUS_DEVICE(&s->sbc_unimplemented),
                                   "aspeed.sbc", sc->memmap[ASPEED_DEV_SBC],
                                   0x40000);
 
@@ -406,20 +408,26 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->pwm), "aspeed.pwm",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),
+                                  "aspeed.pwm",
                                   sc->memmap[ASPEED_DEV_PWM], 0x100);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->espi), "aspeed.espi",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->espi),
+                                  "aspeed.espi",
                                   sc->memmap[ASPEED_DEV_ESPI], 0x800);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->udc), "aspeed.udc",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->udc),
+                                  "aspeed.udc",
                                   sc->memmap[ASPEED_DEV_UDC], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->sgpiom), "aspeed.sgpiom",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
+                                  "aspeed.sgpiom",
                                   sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->jtag[0]), "aspeed.jtag",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
+                                  "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG0], 0x20);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->jtag[1]), "aspeed.jtag",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[1]),
+                                  "aspeed.jtag",
                                   sc->memmap[ASPEED_DEV_JTAG1], 0x20);
 }
 
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 6690752215..e0604851a5 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -259,12 +259,14 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
                                 &s->spi_boot_container);
 
     /* IO space */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->video), "aspeed.video",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
+                                  "aspeed.video",
                                   sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
 
     /* CPU */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index bf0ecde051..ed0985a16e 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -370,16 +370,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 &s->spi_boot_container);
 
     /* IO space */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem), "aspeed.io",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
+                                  "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   ASPEED_SOC_IOMEM_SIZE);
 
     /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->video), "aspeed.video",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
+                                  "aspeed.video",
                                   sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
 
     /* eMMC Boot Controller stub */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->emmc_boot_controller),
+    aspeed_mmio_map_unimplemented(s->memory,
+                                  SYS_BUS_DEVICE(&s->emmc_boot_controller),
                                   "aspeed.emmc-boot-controller",
                                   sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);
 
@@ -441,7 +444,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_DEV_SRAM], &s->sram);
 
     /* DPMCU */
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu), "aspeed.dpmcu",
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
+                                  "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   ASPEED_SOC_DPMCU_SIZE);
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 83cf3c14b6..99a3de15b5 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -241,16 +241,16 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
                                   "aspeed.ipc0",
                                   sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
                                   "aspeed.scuio",
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 86aa565608..568d7555e2 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -241,16 +241,16 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->timerctrl),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl),
                                   "aspeed.timerctrl",
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[0]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[0]),
                                   "aspeed.ipc0",
                                   sc->memmap[ASPEED_DEV_IPC0], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->ipc[1]),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->ipc[1]),
                                   "aspeed.ipc1",
                                   sc->memmap[ASPEED_DEV_IPC1], 0x1000);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&a->scuio),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->scuio),
                                   "aspeed.scuio",
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 8db67dc806..9b645c6c55 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -1014,23 +1014,23 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
                                   "aspeed.dpmcu",
                                   sc->memmap[ASPEED_DEV_DPMCU],
                                   AST2700_SOC_DPMCU_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->ltpi),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
                                   "aspeed.ltpi",
                                   sc->memmap[ASPEED_DEV_LTPI],
                                   AST2700_SOC_LTPI_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
                                   "aspeed.io",
                                   sc->memmap[ASPEED_DEV_IOMEM],
                                   AST2700_SOC_IO_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem0),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem0),
                                   "aspeed.iomem0",
                                   sc->memmap[ASPEED_DEV_IOMEM0],
                                   AST2700_SOC_IOMEM_SIZE);
-    aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->iomem1),
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem1),
                                   "aspeed.iomem1",
                                   sc->memmap[ASPEED_DEV_IOMEM1],
                                   AST2700_SOC_IOMEM_SIZE);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index ca4e589dce..e7d0a9c290 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -117,14 +117,14 @@ void aspeed_mmio_map(MemoryRegion *memory, SysBusDevice *dev, int n,
     memory_region_add_subregion(memory, addr, sysbus_mmio_get_region(dev, n));
 }
 
-void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
+void aspeed_mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                    const char *name, hwaddr addr, uint64_t size)
 {
     qdev_prop_set_string(DEVICE(dev), "name", name);
     qdev_prop_set_uint64(DEVICE(dev), "size", size);
     sysbus_realize(dev, &error_abort);
 
-    memory_region_add_subregion_overlap(s->memory, addr,
+    memory_region_add_subregion_overlap(memory, addr,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
-- 
2.43.0


