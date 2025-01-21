Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E358BC02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8Jw-0006mT-9d; Tue, 21 Jan 2025 02:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8Ju-0006kh-8b; Tue, 21 Jan 2025 02:05:06 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8Js-0001Q8-8F; Tue, 21 Jan 2025 02:05:05 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:27 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:27 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 07/18] hw/intc/aspeed: Introduce IRQ handler function to
 reduce code duplication
Date: Tue, 21 Jan 2025 15:04:13 +0800
Message-ID: <20250121070424.2465942-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
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

The behavior of the INTC set IRQ is almost identical between INTC0 and INTC1.
To reduce duplicated code, introduce the `aspeed_intc_set_irq_handler` function
to handle both INTC0 and INTC1 IRQ behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c | 56 +++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 45f1c59a4b..8684d41ef6 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -91,11 +91,36 @@ static void aspeed_intc_update(AspeedINTCState *s, int inpin_idx,
     qemu_set_irq(s->output_pins[outpin_idx], level);
 }
 
+static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
+                            const AspeedINTCIRQ *irq, uint32_t select)
+{
+    if (s->mask[irq->inpin_idx] || s->regs[irq->status_addr]) {
+        /*
+         * a. mask is not 0 means in ISR mode
+         * sources interrupt routine are executing.
+         * b. status register value is not 0 means previous
+         * source interrupt does not be executed, yet.
+         *
+         * save source interrupt to pending variable.
+         */
+        s->pending[irq->inpin_idx] |= select;
+        trace_aspeed_intc_pending_irq(irq->inpin_idx,
+                                      s->pending[irq->inpin_idx]);
+    } else {
+        /*
+         * notify firmware which source interrupt are coming
+         * by setting status register
+         */
+        s->regs[irq->status_addr] = select;
+        trace_aspeed_intc_trigger_irq(irq->inpin_idx, irq->outpin_idx,
+                                      s->regs[irq->status_addr]);
+        aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx, 1);
+    }
+}
+
 /*
- * The address of GICINT128 to GICINT136 are from 0x1000 to 0x1804.
- * Utilize "address & 0x0f00" to get the irq and irq output pin index
- * The value of irq should be 0 to num_ints.
- * The irq 0 indicates GICINT128, irq 1 indicates GICINT129 and so on.
+ * GICINT128 to GICINT136 map 1:1 to input and output IRQs 0 to 8.
+ * The value of input IRQ should be between 0 and the number of inputs.
  */
 static void aspeed_intc_set_irq(void *opaque, int irq_idx, int level)
 {
@@ -136,28 +161,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq_idx, int level)
 
     trace_aspeed_intc_select(select);
 
-    if (s->mask[irq->inpin_idx] || s->regs[irq->status_addr]) {
-        /*
-         * a. mask is not 0 means in ISR mode
-         * sources interrupt routine are executing.
-         * b. status register value is not 0 means previous
-         * source interrupt does not be executed, yet.
-         *
-         * save source interrupt to pending variable.
-         */
-        s->pending[irq->inpin_idx] |= select;
-        trace_aspeed_intc_pending_irq(irq->inpin_idx,
-                                      s->pending[irq->inpin_idx]);
-    } else {
-        /*
-         * notify firmware which source interrupt are coming
-         * by setting status register
-         */
-        s->regs[irq->status_addr] = select;
-        trace_aspeed_intc_trigger_irq(irq->inpin_idx, irq->outpin_idx,
-                                      s->regs[irq->status_addr]);
-        aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx, 1);
-    }
+    aspeed_intc_set_irq_handler(s, irq, select);
 }
 
 static void aspeed_2700_intc_enable_handler(AspeedINTCState *s, uint32_t addr,
-- 
2.34.1


