Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3995CD1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQho7-0002mb-L2; Wed, 03 Dec 2025 03:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhnx-0002XK-E1; Wed, 03 Dec 2025 03:01:44 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhns-00073u-Vk; Wed, 03 Dec 2025 03:01:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 96A50170775;
 Wed, 03 Dec 2025 10:59:23 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6460832B49C;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 104/116] hw/arm/aspeed: Fix missing SPI IRQ connection
 causing DMA interrupt failure
Date: Wed,  3 Dec 2025 10:59:24 +0300
Message-ID: <20251203075939.2366131-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It did not connect SPI IRQ to the Interrupt Controller, so even the SPI
model raised the IRQ, the interrupt was not received. The CPU therefore
did not trigger an interrupt via the controller, and the firmware never
received the interrupt.

Fixes: 356b230ed13889e09d087a96498887de695df17e ("aspeed/soc: Add AST1030 support")
Fixes: f25c0ae1079dc0b9de02676eb3e3949a09df9f41 ("aspeed/soc: Add AST2600 support")
Fixes: 5dd883ab0635c9f715c77cc32622e458a0724581 ("aspeed/soc: Add AST2700 support")
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251106084925.1253704-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 510d5c61ad3eb1690b61c804d38c984527a5ea62)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index ec329f4991..98905a077a 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -357,6 +357,8 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
         aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast1030_get_irq(s, ASPEED_DEV_SPI1 + i));
     }
 
     /* Secure Boot Controller */
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1f994ba26c..3528ad3b50 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -467,6 +467,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI1 + i]);
         aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 + i));
     }
 
     /* EHCI */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index b810891b16..2d6e6245b7 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -709,6 +709,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                         sc->memmap[ASPEED_DEV_SPI0 + i]);
         aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->spi[i]), 1,
                         ASPEED_SMC_GET_CLASS(&s->spi[i])->flash_window_base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
+                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_SPI0 + i));
     }
 
     /*
-- 
2.47.3


