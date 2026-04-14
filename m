Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6EFF9D0EB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChSL-0005xE-SG; Tue, 14 Apr 2026 13:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSE-0005sW-92; Tue, 14 Apr 2026 13:21:40 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wChSB-0007Kn-Hd; Tue, 14 Apr 2026 13:21:37 -0400
DKIM-Signature: a=rsa-sha256; bh=xYiqsFO1CpF379rzC+qC6atuSvv1f1B7+qpGDOgv7VA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1776187286; v=1;
 b=Dy7/DM9qouTfnwasfx6eBwfuAUQ3FuVmcT5+X2jUAPbJlTSI3fxcOw1PkhLMHpZagCgr2gX9
 jxYeHBip3456eXTdEcgyWb7xRHfGLk/w5pvQy/k3PQvLUxIEDz+6w1EsfpETwPdwDzVvIrc/oAx
 rrpuIIDZDA/CtZAasiGjsR5iYdR5ovWqlddPY7grlNGW6aZVNFmQL1FZN1/cDuhKCIH1sQF1X7i
 9dJB7zZ9wSsymM1mhXgY+QGv5Al8BCs9R8FpDL0hAbzDTpokLUJWK0ZOi5L26HWyRBIbrYf1RGE
 V1qlgFGHP+Nr+fybeRFacXf6Lpog+rU7O7HIbg+GANA+Q==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 6F99420A3B;
 Tue, 14 Apr 2026 17:21:26 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 14 Apr 2026 13:45:41 +0100
Subject: [PATCH qemu v3 07/10] ot_uart: handle break condition
Message-ID: <177618728515.4917.14466194789826252277-7@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177618728515.4917.14466194789826252277-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Lex Bailey <lex.bailey@lowrisc.org>

This adds a handler for the UART break event, and logic to emulate a break
when oversampling is enabled and there is a break event.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 92 +++++++++++++++++++++++++++++++++++++--
 include/hw/char/ot_uart.h |  4 ++
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 3511a42fbe..cdf02da62b 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -179,6 +179,11 @@ static void ot_uart_receive(void *opaque, const uint8_t =
*buf, int size)
     uint32_t rx_watermark_level;
     size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
=20
+    if (size && !s->toggle_break) {
+        /* no longer breaking, so emulate idle in oversampled VAL register */
+        s->in_break =3D false;
+    }
+
     for (int index =3D 0; index < size; index++) {
         fifo8_push(&s->rx_fifo, buf[index]);
     }
@@ -331,9 +336,40 @@ static void ot_uart_reset_enter(Object *obj, ResetType t=
ype)
=20
     s->char_tx_time =3D (NANOSECONDS_PER_SECOND / 230400) * 10;
=20
+    /*
+     * do not reset `s->in_break`, as that tracks whether we are currently
+     * receiving a break condition over UART RX from some device talking
+     * to OpenTitan, which should survive resets. The QEMU CharDev only
+     * supports transient break events and not the notion of holding the
+     * UART in break, so remembering breaks like this is required to
+     * support mocking of break conditions in the oversampled `VAL` reg.
+     */
+    if (s->in_break) {
+        /* ignore CTRL.RXBLVL as we have no notion of break "time" */
+        s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
+    }
+
     ot_uart_update_irqs(s);
 }
=20
+static void ot_uart_event_handler(void *opaque, QEMUChrEvent event)
+{
+    OtUARTState *s =3D opaque;
+
+    if (event =3D=3D CHR_EVENT_BREAK) {
+        if (!s->in_break || !s->oversample_break) {
+            /* ignore CTRL.RXBLVL as we have no notion of break "time" */
+            s->regs[R_INTR_STATE] |=3D INTR_RX_BREAK_ERR_MASK;
+            ot_uart_update_irqs(s);
+            /* emulate break in the oversampled VAL register */
+            s->in_break =3D true;
+        } else if (s->toggle_break) {
+            /* emulate toggling break off in the oversampled VAL register */
+            s->in_break =3D false;
+        }
+    }
+}
+
 static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
 {
     uint8_t val;
@@ -355,6 +391,17 @@ static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
     return val;
 }
=20
+static gboolean ot_uart_watch_cb(void *do_not_use, GIOCondition cond,
+                                 void *opaque)
+{
+    OtUARTState *s =3D opaque;
+
+    s->watch_tag =3D 0;
+    ot_uart_xmit(s);
+
+    return FALSE;
+}
+
 static uint64_t ot_uart_get_baud(OtUARTState *s)
 {
     uint64_t baud;
@@ -424,6 +471,26 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr, =
unsigned int size)
         break;
=20
     case R_VAL:
+        /*
+         * This is not trivially implemented due to the QEMU UART
+         * interface. There is no way to reliably sample or oversample
+         * given our emulated interface, but some software might poll the
+         * value of this register to determine break conditions.
+         *
+         * As such, default to reporting 16 of the last sample received
+         * instead. This defaults to 16 idle high samples (as a stop bit is
+         * always the last received), except for when the `oversample-break`
+         * property is set and a break condition is received over UART RX,
+         * where we then show 16 low samples until the next valid UART
+         * transmission is received (or break is toggled off with the
+         * `toggle-break` property enabled). This will not be accurate, but
+         * should be sufficient to support basic software flows that
+         * essentially use UART break as a strapping mechanism.
+         */
+        retvalue =3D (s->in_break && s->oversample_break) ? 0u : UINT16_MAX;
+        qemu_log_mask(LOG_UNIMP, "%s: VAL only shows idle%s\n", __func__,
+                      (s->oversample_break ? "/break" : ""));
+        break;
     case R_OVRD:
     case R_TIMEOUT_CTRL:
         retvalue =3D s->regs[reg];
@@ -607,8 +674,27 @@ static const VMStateDescription vmstate_ot_uart =3D {
=20
 static const Property ot_uart_properties[] =3D {
     DEFINE_PROP_CHR("chardev", OtUARTState, chr),
+    DEFINE_PROP_BOOL("oversample-break", OtUARTState, oversample_break, fals=
e),
+    DEFINE_PROP_BOOL("toggle-break", OtUARTState, toggle_break, false),
 };
=20
+static int ot_uart_fe_change(void *opaque)
+{
+    OtUARTState *s =3D opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_receive,
+                             ot_uart_event_handler, ot_uart_fe_change, s, NU=
LL,
+                             true);
+
+    if (s->watch_tag > 0) {
+        g_source_remove(s->watch_tag);
+        s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                             ot_uart_watch_cb, s);
+    }
+
+    return 0;
+}
+
 static void ot_uart_init(Object *obj)
 {
     OtUARTState *s =3D OT_UART(obj);
@@ -644,9 +730,9 @@ static void ot_uart_realize(DeviceState *dev, Error **err=
p)
     fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
     fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
=20
-    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
-                             ot_uart_receive, NULL, NULL,
-                             s, NULL, true);
+    qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive, ot_uart_receive,
+                             ot_uart_event_handler, ot_uart_fe_change, s, NU=
LL,
+                             true);
 }
=20
 static void ot_uart_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index a2c5ff8b33..997bf2f367 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -56,10 +56,14 @@ struct OtUARTState {
     Fifo8 tx_fifo;
     Fifo8 rx_fifo;
     uint32_t tx_watermark_level;
+    bool in_break;
+    guint watch_tag;
=20
     Clock *f_clk;
=20
     CharFrontend chr;
+    bool oversample_break; /* Should mock break in the oversampled VAL reg? =
*/
+    bool toggle_break; /* Are incoming breaks temporary or toggled? */
 };
=20
 struct OtUARTClass {
--=20
2.49.1


