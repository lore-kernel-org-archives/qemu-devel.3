Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87A8CD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXv5N-0005ks-3N; Fri, 12 Jun 2026 02:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wXv5L-0005ke-ET
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:09:43 -0400
Received: from va-2-113.ptr.blmpb.com ([209.127.231.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wXv5H-0005YW-S1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 02:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781244562; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=GVLDVYrQ6lycqF2TQkcMPAW26Qay9w9PpgAERu5/nvY=;
 b=HpeBXaqMPc2T//ESV2xMPXg7hJ2R/2STwkg2eXwv5d/DOkBF49dRA+1mXOEkRJSqUCeEmR
 CUbQfbi9lH4vAdkFZD7zJ3qmPKBknVwDd3bUyByyVqv0HFPv6Fr9iK4rPXhKzRVNSXGO2U
 uYpSeJ+V82BfCeqfnsnEpGuDZpFV+a2ar6UacSSfAtvJDRDekJ/x5f7dRfjEqsfg90VqcA
 iklkGNpNm5bRdkvWesbHFhEVQowSK4KvWNGifJuYTuE1y3qu8imBa5jKAvCsCKyTrjtiTA
 izbv25YtaYi5IbyUJ4fF35C/MWXYXwh9mlHhDEj/e5ZssYjmJmlenIQ8dNXevg==
Date: Fri, 12 Jun 2026 14:08:57 +0800
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Message-Id: <20260612060857.1842819-1-zhangjian.3032@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.20.1
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "Steven Lee" <steven_lee@aspeedtech.com>, "Troy Lee" <leetroy@gmail.com>, 
 "Jamin Lin" <jamin_lin@aspeedtech.com>, 
 "Kane Chen" <kane_chen@aspeedtech.com>, 
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, 
 "Joel Stanley" <joel@jms.id.au>, <qemu-arm@nongnu.org>, 
 <qemu-devel@nongnu.org>
Subject: [PATCH] hw/intc/aspeed: Drop stale pending interrupts
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a2ba290+667def+nongnu.org+zhangjian.3032@bytedance.com>
Received-SPF: pass client-ip=209.127.231.113;
 envelope-from=zhangjian.3032@bytedance.com; helo=va-2-113.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Aspeed INTC records an interrupt source in the pending bitmap when
the source is masked or another status bit is still being handled.  When
the guest later clears the status register, the model promotes all saved
pending bits back to status unconditionally.

This is not correct for level-triggered sources.  A source can deassert
while another source connected to the same OR gate keeps the aggregated
INTC line asserted.  Promoting the stale bit later makes the guest demux
a child interrupt whose device status has already been cleared.

This is visible on AST2700 I2C, where the I2C buses are aggregated
through INTCIO GICINT194 before reaching the GIC.  A stale I2C source bit
can be promoted back to the INTCIO status register, causing Linux to run
the corresponding I2C ISR with an empty I2C interrupt status register.
For example, the Linux aspeed-i2c debug ring shows a transfer that first
receives a valid status interrupt, then receives a spurious ISR with both
isr and raw status equal to zero.  The zero-status ISR clears the saved
command error and the transfer completes with ret=0:

  event=start isr=0x00000000 raw=0x00000000 cmd_err=0 msgs_idx=0
  event=isr   isr=0x00010011 raw=0x00010011 cmd_err=0 msgs_idx=0
  event=isr   isr=0x00000000 raw=0x00000000 cmd_err=1 msgs_idx=1
  event=complete ret=0 cmd_err=0 msgs_idx=1

A normal command can then be reported as zero transferred messages, which
is converted to -EIO by Linux i2c_smbus_xfer_emulated().  The race is
more likely when multiple I2C buses are accessed concurrently.

Drop pending bits that no longer correspond to an asserted and enabled
source before they can be promoted back to status.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 hw/intc/aspeed_intc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 5a36fff5204..ab80c239bc1 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -107,6 +107,27 @@ static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
     g_assert_not_reached();
 }
 
+static uint32_t aspeed_intc_orgate_levels(AspeedINTCState *s, int inpin_idx)
+{
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    uint32_t levels = 0;
+    int i;
+
+    for (i = 0; i < aic->num_lines && i < 32; i++) {
+        if (s->orgates[inpin_idx].levels[i]) {
+            levels |= BIT(i);
+        }
+    }
+
+    return levels;
+}
+
+static void aspeed_intc_drop_stale_pending(AspeedINTCState *s, int inpin_idx)
+{
+    s->pending[inpin_idx] &= aspeed_intc_orgate_levels(s, inpin_idx) &
+                             s->enable[inpin_idx];
+}
+
 /*
  * Update the state of an interrupt controller pin by setting
  * the specified output pin to the given level.
@@ -231,6 +252,8 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     trace_aspeed_intc_set_irq(name, inpin_idx, level);
     enable = s->enable[inpin_idx];
 
+    aspeed_intc_drop_stale_pending(s, inpin_idx);
+
     if (!level) {
         return;
     }
@@ -343,6 +366,7 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
     /* All source ISR execution are done */
     if (!s->regs[reg]) {
         trace_aspeed_intc_all_isr_done(name, inpin_idx);
+        aspeed_intc_drop_stale_pending(s, inpin_idx);
         if (s->pending[inpin_idx]) {
             /*
              * handle pending source interrupt
@@ -402,6 +426,7 @@ static void aspeed_intc_status_handler_multi_outpins(AspeedINTCState *s,
         /* All source ISR executions are done from a specific bit */
         if (data & BIT(i)) {
             trace_aspeed_intc_all_isr_done_bit(name, inpin_idx, i);
+            aspeed_intc_drop_stale_pending(s, inpin_idx);
             if (s->pending[inpin_idx] & BIT(i)) {
                 /*
                  * Handle pending source interrupt.
-- 
2.20.1

