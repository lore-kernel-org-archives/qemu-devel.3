Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA6FE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 07:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN5vn-0004Up-Lp; Mon, 16 Dec 2024 02:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tN5vl-0004U8-Qe; Mon, 16 Dec 2024 02:54:17 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tN5ve-000791-3g; Mon, 16 Dec 2024 02:54:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 16 Dec
 2024 15:53:54 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 16 Dec 2024 15:53:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region ops
Date: Mon, 16 Dec 2024 15:53:50 +0800
Message-ID: <20241216075353.1308043-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
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

It set "aspeed_timer_ops" struct which containing read and write callbacks
to be used when I/O is performed on the TIMER region.

Besides, in the previous design of ASPEED SOCs, the timer registers address
space are contiguous.

ex: TMC00-TMC0C are used for TIMER0.
ex: TMC10-TMC1C are used for TIMER1.
ex: TMC80-TMC8C are used for TIMER7.

The TMC30 is a control register and TMC34 is an interrupt status register for
TIMER0-TIMER7.

However, the register set have a significant change in AST2700. The TMC00-TMC3C
are used for TIMER0 and TMC40-TMC7C are used for TIMER1. In additional,
TMC20-TMC3C and TMC60-TMC7C are reserved registers for TIMER0 and TIMER1,
respectively.

Besides, each TIMER has their own control and interrupt status register.
In other words, users are able to set control and interrupt status for TIMER0
in one register. Both aspeed_timer_read and aspeed_timer_write callback
functions are not compatible AST2700.

Introduce a new "const MemoryRegionOps *" attribute in AspeedTIMERClass and use
it in aspeed_timer_realize function.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/timer/aspeed_timer.c         | 7 ++++++-
 include/hw/timer/aspeed_timer.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 149f7cc5a6..970bf1d79d 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -606,6 +606,7 @@ static void aspeed_timer_realize(DeviceState *dev, Error **errp)
     int i;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedTimerCtrlState *s = ASPEED_TIMER(dev);
+    AspeedTimerClass *atc = ASPEED_TIMER_GET_CLASS(s);
 
     assert(s->scu);
 
@@ -613,7 +614,7 @@ static void aspeed_timer_realize(DeviceState *dev, Error **errp)
         aspeed_init_one_timer(s, i);
         sysbus_init_irq(sbd, &s->timers[i].irq);
     }
-    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_timer_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(s), atc->reg_ops, s,
                           TYPE_ASPEED_TIMER, 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
 }
@@ -708,6 +709,7 @@ static void aspeed_2400_timer_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2400 Timer";
     awc->read = aspeed_2400_timer_read;
     awc->write = aspeed_2400_timer_write;
+    awc->reg_ops = &aspeed_timer_ops;
 }
 
 static const TypeInfo aspeed_2400_timer_info = {
@@ -724,6 +726,7 @@ static void aspeed_2500_timer_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2500 Timer";
     awc->read = aspeed_2500_timer_read;
     awc->write = aspeed_2500_timer_write;
+    awc->reg_ops = &aspeed_timer_ops;
 }
 
 static const TypeInfo aspeed_2500_timer_info = {
@@ -740,6 +743,7 @@ static void aspeed_2600_timer_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2600 Timer";
     awc->read = aspeed_2600_timer_read;
     awc->write = aspeed_2600_timer_write;
+    awc->reg_ops = &aspeed_timer_ops;
 }
 
 static const TypeInfo aspeed_2600_timer_info = {
@@ -756,6 +760,7 @@ static void aspeed_1030_timer_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 1030 Timer";
     awc->read = aspeed_2600_timer_read;
     awc->write = aspeed_2600_timer_write;
+    awc->reg_ops = &aspeed_timer_ops;
 }
 
 static const TypeInfo aspeed_1030_timer_info = {
diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 07dc6b6f2c..8d0b15f055 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -73,6 +73,7 @@ struct AspeedTimerClass {
 
     uint64_t (*read)(AspeedTimerCtrlState *s, hwaddr offset);
     void (*write)(AspeedTimerCtrlState *s, hwaddr offset, uint64_t value);
+    const MemoryRegionOps *reg_ops;
 };
 
 #endif /* ASPEED_TIMER_H */
-- 
2.25.1


