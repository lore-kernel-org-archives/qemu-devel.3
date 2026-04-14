Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE80FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrS-0007qB-R6; Thu, 30 Apr 2026 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrK-0007cA-TJ; Thu, 30 Apr 2026 12:03:30 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrG-00079Y-7Q; Thu, 30 Apr 2026 12:03:26 -0400
DKIM-Signature: a=rsa-sha256; bh=5CJSSplXBWzwOKftMniqF9csQcjNBZIZr2WVOB8vGes=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564993; v=1;
 b=mzAFVgt/+mLoRP9qs4hGPiYrWfzmWTn3uw3rBa0O9M7xxXAqJiTAyCxjFuvskJTlMP4j6PGs
 qe6ZUBHobGeKIc01aSVTY8JnxXaIWXbtLjjbDidaOLIjhGqy1AWhdxuYP2WW1DNigE8/5JRC+fB
 uOqLfddhXvrqmzMFuYYbb+8J7XTPQin5kZiljGiYAs/lbBNmvzB0oEJdFapTtSI6Eg/0xbZdWXN
 EdUMGGsyFDWEADdfhdW9CKLscN8/4tZ4C1LXP9lMZHLX8+pxlhRrOELZULTO3fRQuoIEXF2KHyz
 zMlI9lz3uVMiDJ70sjMLjCK7PAUMsNAEqiZKRnogRJ0dg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 83EF020C81;
 Thu, 30 Apr 2026 16:03:13 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 14 Apr 2026 13:45:41 +0100
Subject: [PATCH qemu v4 7/9] ot_uart: handle break condition
Message-ID: <177756498815.8917.12449488721849651971-7@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177756498815.8917.12449488721849651971-0@git.sr.ht>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

What is a break event:
Normally, a UART wire is held high by the transmitting device any time the
communication channel is idle (nothing to transmit). If a receiver does not s=
ee
that its receive line is high, this means one of two things:
    1. there is a transmission happening now
    2. there is no transmitter connected, and the line is floating or pulled
       low, or the transmitting device is in a bad state or reset state and so
       it has not yet asserted its TX output.

In case 1, the line will go high again very soon.
In case 2, it is sometimes useful to detect that this is the case and signal =
to
the software that this has happened (normally by means of an interrupt)

The ot_uart device does exactly this in case 2. It detects that this is
happening by detecting when the RX pin stays low for an extended period. This
period can be configured to be 2, 4, 8, or 16 times a character period. The
character period itself depends on the configuration of the device (baud rate,
and parity bit)

for more details about how this works, there is documentation about the UART
break detection on this page:
https://opentitan.org/book/hw/ip/uart/doc/theory_of_operation.html#rx_break_e=
rr

This commit adds a handler for the UART break event, and logic to emulate a
break when oversampling is enabled and there is a break event.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 docs/system/riscv/opentitan-uart.rst | 43 +++++++++++++
 hw/char/ot_uart.c                    | 92 +++++++++++++++++++++++++++-
 include/hw/char/ot_uart.h            |  4 ++
 3 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 docs/system/riscv/opentitan-uart.rst

diff --git a/docs/system/riscv/opentitan-uart.rst b/docs/system/riscv/opentit=
an-uart.rst
new file mode 100644
index 0000000000..7ca596712d
--- /dev/null
+++ b/docs/system/riscv/opentitan-uart.rst
@@ -0,0 +1,43 @@
+# OpenTitan UART Support
+
+## Connecting to the UART
+
+* `-serial mon:stdio`, used as the first `-serial` option, redirects the vir=
tual UART0 to the
+  current console/shell.
+
+* `-chardev socket,id=3Dserial1,host=3Dlocalhost,port=3D8001,server=3Don,wai=
t=3Doff` and
+  `-serial chardev:serial1` can be used to redirect UART1 (in this example) =
to a TCP socket. These
+  options are not specific to OpenTitan emulation, but are useful to communi=
cate over a UART.
+  Note that QEMU offers many `chardev` backends, please check QEMU documenta=
tion for details.
+
+## Sending Break Conditions
+
+Break conditions can be sent to the UART on select supported CharDev backend=
s (telnet, mux)
+or by sending the `chardev-send-break` command with the CharDev ID via the Q=
EMU Monitor.
+Break conditions are treated as transient events and the length of time of a=
 break condition
+is not considered.
+
+## Oversampling
+
+OpenTitan's UART has a `VAL` register which oversamples the RX pin 16 times =
per bit.
+This cannot be emulated by QEMU which uses a CharDev backend and does not ha=
ve a notion of
+accurate sampling times.
+
+If software wishes to poll the `VAL` register to determine break conditions,=
 there are
+some properties available to help with emulating this use case:
+
+* `-global ot-uart.oversample-break=3Dtrue` is used to enable UART break ove=
rsampling.
+  This will attempt to display 16 samples of the last bit received in the `V=
AL` register,
+  which will be 16 high bits after any UART frame is transmitted (as these e=
nd with a stop
+  bit, which is high), or 16 low bits if the UART previously received a brea=
k condition
+  and has not received any frames since. That is, enabling this property ass=
umes that
+  transmitted break conditions are "held" until the next UART transfer in te=
rms of what
+  is being shown in the oversampled `VAL` register.
+
+* `-global ot-uart.toggle-break=3Dtrue` is used to provide more control over=
 "holding"
+  the UART RX break condition like a GPIO strap, and changes the behavior of=
 a UART
+  such that received break condition events now *toggle* the break condition=
 state
+  rather than keeping it asserted until the next transfer. This allows any d=
evice talking
+  to OpenTitan via UART to have more precise control over when the UART VAL =
register
+  displays idle and when it displays a break condition, as it can precisely =
toggle the
+  break condition on or off like a GPIO strapping being held down.
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


