Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64734C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59q-0006Yy-0r; Tue, 07 Jul 2026 08:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59e-0006WK-Dv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59c-0005D2-Mz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7VbtoVtcB7Pklk2f0NaiOmxoo9lNE/C+tCZPnK01jY=;
 b=J1OCVcjRboxPveBI6AKr+VGFiTbDnTruttpXDEFlP3lj33YgwoR/4KqEFUG2kIiDFnpf9U
 flyZijHjflLwwhE3SCT0gZ5VfRN8J4a4HAk8KUQ63TF326Wlgg/ZmO+tKrY4UTRnAW3m9D
 z3S3OiwoijX5ijM0KRgZAdUZvCyIlGA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-_9od1ohVO-mwoTTYQmXtBw-1; Tue,
 07 Jul 2026 08:43:56 -0400
X-MC-Unique: _9od1ohVO-mwoTTYQmXtBw-1
X-Mimecast-MFC-AGG-ID: _9od1ohVO-mwoTTYQmXtBw_1783428235
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C2C61953994; Tue,  7 Jul 2026 12:43:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CD1036924; Tue,  7 Jul 2026 12:43:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jian Zhang <zhangjian.3032@bytedance.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/8] hw/intc/aspeed: Drop stale pending interrupts
Date: Tue,  7 Jul 2026 14:43:42 +0200
Message-ID: <20260707124349.662198-2-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jian Zhang <zhangjian.3032@bytedance.com>

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
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260612060857.1842819-1-zhangjian.3032@bytedance.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/aspeed_intc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 5a36fff52040..ab80c239bc15 100644
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
2.54.0


