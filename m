Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D197C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 04:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqOt4-00084K-Gw; Thu, 06 Mar 2025 23:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOt1-0007ze-2f; Thu, 06 Mar 2025 23:00:35 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqOsz-0004jN-Fb; Thu, 06 Mar 2025 23:00:34 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 7 Mar
 2025 11:59:50 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 7 Mar 2025 11:59:50 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 12/29] hw/intc/aspeed: Add support for multiple output pins
 in INTC
Date: Fri, 7 Mar 2025 11:59:21 +0800
Message-ID: <20250307035945.3698802-13-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
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

Added support for multiple output pins in the INTC controller to
accommodate the AST2700 A1.

Introduced "num_outpins" to represent the number of output pins. Updated the
IRQ handling logic to initialize and connect output pins separately from input
pins. Modified the "aspeed_soc_ast2700_realize" function to connect source
orgates to INTC and INTC to GIC128 - GIC136. Updated the "aspeed_intc_realize"
function to initialize output pins.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h | 5 +++--
 hw/arm/aspeed_ast27x0.c       | 6 +++++-
 hw/intc/aspeed_intc.c         | 4 ++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 58be5b3e13..2a22e30846 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,8 +16,8 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_INTS 9
 #define ASPEED_INTC_MAX_INPINS 9
+#define ASPEED_INTC_MAX_OUTPINS 9
 
 struct AspeedINTCState {
     /*< private >*/
@@ -29,7 +29,7 @@ struct AspeedINTCState {
 
     uint32_t *regs;
     OrIRQState orgates[ASPEED_INTC_MAX_INPINS];
-    qemu_irq output_pins[ASPEED_INTC_NR_INTS];
+    qemu_irq output_pins[ASPEED_INTC_MAX_OUTPINS];
 
     uint32_t enable[ASPEED_INTC_MAX_INPINS];
     uint32_t mask[ASPEED_INTC_MAX_INPINS];
@@ -41,6 +41,7 @@ struct AspeedINTCClass {
 
     uint32_t num_lines;
     uint32_t num_inpins;
+    uint32_t num_outpins;
     uint64_t mem_size;
     uint64_t nr_regs;
     uint64_t reg_offset;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 01a8e1d6b4..2d24361daa 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -530,10 +530,14 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
                     sc->memmap[ASPEED_DEV_INTC]);
 
-    /* GICINT orgates -> INTC -> GIC */
+    /* source orgates -> INTC */
     for (i = 0; i < ic->num_inpins; i++) {
         qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
                                 qdev_get_gpio_in(DEVICE(&a->intc), i));
+    }
+
+    /* INTC -> GIC128 - GIC136 */
+    for (i = 0; i < ic->num_outpins; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
                                 aspeed_soc_ast2700_gic_intcmap[i].irq));
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 217fda6fe0..6f37afc17e 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -347,6 +347,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
         if (!qdev_realize(DEVICE(&s->orgates[i]), NULL, errp)) {
             return;
         }
+    }
+
+    for (i = 0; i < aic->num_outpins; i++) {
         sysbus_init_irq(sbd, &s->output_pins[i]);
     }
 }
@@ -391,6 +394,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
     aic->num_inpins = 9;
+    aic->num_outpins = 9;
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x808 >> 2;
     aic->reg_offset = 0x1000;
-- 
2.43.0


