Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7E4C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 05:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjXfm-00087H-5P; Sun, 16 Feb 2025 00:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1tjVk1-0003o8-An; Sat, 15 Feb 2025 22:54:49 -0500
Received: from mail.csclub.uwaterloo.ca ([129.97.134.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <s23adhik@csclub.uwaterloo.ca>)
 id 1tjVjz-000340-3j; Sat, 15 Feb 2025 22:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=csc; t=1739678083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JmtHLnlzelDiMG/aaAhaae/vF1+y41ZDzU76AdNWZlM=;
 b=tqJopBqybRmYP3sSVvS/W4ny0Z/5LJpT9w8GxjOit1iN4v93RaVnoAJvr2iiONPhn0A+w0
 +pzbfC6HoxwICHlQF5JSlxs7OaIJFOfIKqvM6qregBnqFjtOCJ7EtIn4cYXDjn6byOUJBS
 IdZ3zKmedoKaMYsdo4O4T+kk/omwBjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=csclub.uwaterloo.ca;
 s=202502e; t=1739678083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JmtHLnlzelDiMG/aaAhaae/vF1+y41ZDzU76AdNWZlM=;
 b=XGNIuT/chy/ms9JubnMhf+jaY3Sy8Maib76ovN+NH9p17ebODeaaH7lgGFpZi6utvLtoaw
 6c0VcoI35tT7aHBQ==
Message-ID: <3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca>
Date: Sat, 15 Feb 2025 22:54:42 -0500
MIME-Version: 1.0
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
Cc: peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH] bcm2838: Add GIC-400 timer interupt connections
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=129.97.134.52;
 envelope-from=s23adhik@csclub.uwaterloo.ca; helo=mail.csclub.uwaterloo.ca
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 16 Feb 2025 00:58:33 -0500
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

Hello everyone,

This patch adds support for the system timer interrupts
in QEMU's BCM2838 model. It defines a new constant
called GIC400_TIMER_INT, and connects 4 timer interupts
to the GIC-400.
Previously timer interupts were not being routed to the
interupt controller, causing scheduling, and some other
stuff to have issues (me and a few friends bumped into
this, and that's why this was written lol).

Signed-off-by: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
---
  hw/arm/bcm2838.c | 11 +++++++++++
  1 file changed, 11 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index ddb7c5f..0a4179f 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -21,6 +21,8 @@
  #define GIC400_TIMER_S_EL1_IRQ      13
  #define GIC400_TIMER_NS_EL1_IRQ     14
  #define GIC400_LEGACY_IRQ           15
+#define GIC400_TIMER_INT            (96 - 32)
+

  /* Number of external interrupt lines to configure the GIC with */
  #define GIC_NUM_IRQS                192
@@ -176,6 +178,15 @@ static void bcm2838_realize(DeviceState *dev, Error 
**errp)
                      qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
      }

+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 0,
+        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT + 
INTERRUPT_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 1,
+        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT + 
INTERRUPT_TIMER1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 2,
+        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT + 
INTERRUPT_TIMER2));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->systmr), 3,
+        qdev_get_gpio_in(DEVICE(&s->gic), GIC400_TIMER_INT + 
INTERRUPT_TIMER3));
+
      /* Connect UART0 to the interrupt controller */
      sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->uart0), 0,
                         qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_UART0));
-- 
2.48.1


