Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9FAC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 17:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yTp-0002aQ-1T; Sat, 19 Sep 2026 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDv-0002fn-7R; Sat, 19 Sep 2026 12:47:36 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1x7yDr-0007z6-AI; Sat, 19 Sep 2026 12:47:34 -0400
DKIM-Signature: a=rsa-sha256; bh=IfCqFNjN/Dd2uXBzGYxSYHGbyOrNnpc/hbRaIw2Ar0k=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1789836443; v=1;
 b=Ff3Ddn7q7Cyza5vUbT0EYVoa5Kl2eFloZ4yxR+PVAamYcKz7CIhY/RKnfNZyovNbCGJ8XM+3
 7vlxKTFQisY9xje+AK/fWZIFgthYNOCo1G0JLVdQnMYJjZiIbzphIogbTpzx6hX4crzmIbDbYu6
 Yo145/tvt5uSF6lLNjRFUwBr7ZxmlSpb7kLfhaBLtR0UqTQIIDNSi668oLyMvVhWrctWcacN4OG
 GOW+9CZM8Aczfsgb/3jXBhdbK20DoP+xwuauYQo5O9jhmY94cbi80eggu4bXWWjmxyFYR0MDQop
 YHXzq41c/bn3fz3+w2bM5iCyQPhtPlflh/rf2ssN4K7xw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id A69FC224AA;
 Sat, 19 Sep 2026 16:47:23 +0000 (UTC)
From: ~jprx <jprx@git.sr.ht>
Date: Sat, 19 Sep 2026 10:37:52 -0400
Subject: [PATCH qemu 2/2] hw/char/exynos4210_uart: fix fifo overflow
Message-ID: <178983644340.22135.11298603231632238119-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <178983644340.22135.11298603231632238119-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Joseph Ravichandran <jravi@mit.edu>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2026 13:03:56 -0400
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
Reply-To: ~jprx <jravi@mit.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: jprx <jravi@mit.edu>

The Exynos 4210 UART FIFO implementation uses a circular buffer with a
store and retrieve pointer. When implemented this way, a circular
buffer's capacity is 1 less than the size of the backing buffer, because
there is no way to disambiguate the empty and full states (when the
store pointer =3D=3D retrieve pointer).

When exynos4210_uart_can_receive is called, it may report that the
entire is buffer is available for receiving data, as
fifo_empty_elements_number may incorrectly report that the FIFO capacity
is equal to the entire buffer size (rather than 1 less than the size).

If this happens, a full FIFO buffer's worth of data will be read into
the circular buffer, the store pointer will wrap around back to its
starting value, and the FIFO will reset back to the empty state. The
next time exynos4210_uart_can_receive is called, it will report the
entire buffer is empty instead of full, and promptly allow the data to
be overwritten before the guest has received it.

The consequence is that if a message is sent into the UART (eg. via a
chardev) longer than the FIFO's buffer length, the first part of the
message will be lost due to this overflowing behavior, and only the last
part of the message will be received.

This patch fixes this bug by refactoring the Exynos 4210 UART to make
use of the fifo8 implementation, which is implemented via a head pointer
and length field, and therefore has capacity equal to the buffer length
and is immune to this behavior.

The Exynos 4210 UART FIFO test now passes instead of timing out.

Signed-off-by: Joseph Ravichandran <jravi@mit.edu>

---

One thing I wasn't sure about is whether we need to save rx_capacity and
tx_capacity in the vmstate description. Since these are linked to the
rx-size and tx-size properties respectively I wasn't sure if they need
to be saved explicitly or not, so I didn't include them.

The only place either field gets used after the UART is realized is when
rx_capacity is read for a call to trace_exynos_uart_rxsize, but
otherwise the capacity info gets baked into the fifo8s after they are
created and should be covered by the VMSTATE_FIFO8.
---
 hw/char/exynos4210_uart.c | 107 ++++++++++----------------------------
 1 file changed, 27 insertions(+), 80 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 46fc4e31b8..8446d2f9b9 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
+#include "qemu/fifo8.h"
=20
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
@@ -133,12 +134,6 @@ static const Exynos4210UartReg exynos4210_uart_regs[] =
=3D {
 #define UERSTAT_FRAME    0x4
 #define UERSTAT_BREAK    0x8
=20
-typedef struct {
-    uint8_t    *data;
-    uint32_t    sp, rp; /* store and retrieve pointers */
-    uint32_t    size;
-} Exynos4210UartFIFO;
-
 #define TYPE_EXYNOS4210_UART "exynos4210.uart"
 OBJECT_DECLARE_SIMPLE_TYPE(Exynos4210UartState, EXYNOS4210_UART)
=20
@@ -148,8 +143,10 @@ struct Exynos4210UartState {
     MemoryRegion iomem;
=20
     uint32_t             reg[EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t=
)];
-    Exynos4210UartFIFO   rx;
-    Exynos4210UartFIFO   tx;
+    Fifo8                rx;
+    Fifo8                tx;
+    uint32_t             rx_capacity;
+    uint32_t             tx_capacity;
=20
     QEMUTimer *fifo_timeout_timer;
     uint64_t wordtime;        /* word time in ns */
@@ -178,45 +175,6 @@ static const char *exynos4210_uart_regname(hwaddr  offse=
t)
     return NULL;
 }
=20
-
-static void fifo_store(Exynos4210UartFIFO *q, uint8_t ch)
-{
-    q->data[q->sp] =3D ch;
-    q->sp =3D (q->sp + 1) % q->size;
-}
-
-static uint8_t fifo_retrieve(Exynos4210UartFIFO *q)
-{
-    uint8_t ret =3D q->data[q->rp];
-    q->rp =3D (q->rp + 1) % q->size;
-    return  ret;
-}
-
-static int fifo_elements_number(const Exynos4210UartFIFO *q)
-{
-    if (q->sp < q->rp) {
-        return q->size - q->rp + q->sp;
-    }
-
-    return q->sp - q->rp;
-}
-
-static int fifo_empty_elements_number(const Exynos4210UartFIFO *q)
-{
-    return q->size - fifo_elements_number(q);
-}
-
-static void fifo_reset(Exynos4210UartFIFO *q)
-{
-    g_free(q->data);
-    q->data =3D NULL;
-
-    q->data =3D g_malloc0(q->size);
-
-    q->sp =3D 0;
-    q->rp =3D 0;
-}
-
 static uint32_t exynos4210_uart_FIFO_trigger_level(uint32_t channel,
                                                    uint32_t reg)
 {
@@ -271,7 +229,7 @@ exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210Uar=
tState *s)
 static void exynos4210_uart_update_dmabusy(Exynos4210UartState *s)
 {
     bool rx_dma_enabled =3D (s->reg[I_(UCON)] & 0x03) =3D=3D 0x02;
-    uint32_t count =3D fifo_elements_number(&s->rx);
+    uint32_t count =3D fifo8_num_used(&s->rx);
=20
     if (rx_dma_enabled && !count) {
         qemu_irq_raise(s->dmairq);
@@ -300,7 +258,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartStat=
e *s)
          * Rx interrupt if trigger level is reached or if rx timeout
          * interrupt is disabled and there is data in the receive buffer
          */
-        count =3D fifo_elements_number(&s->rx);
+        count =3D fifo8_num_used(&s->rx);
         if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
             count >=3D exynos4210_uart_Rx_FIFO_trigger_level(s)) {
             exynos4210_uart_update_dmabusy(s);
@@ -416,12 +374,12 @@ static void exynos4210_uart_write(void *opaque, hwaddr =
offset,
     case UFCON:
         s->reg[I_(UFCON)] =3D val;
         if (val & UFCON_Rx_FIFO_RESET) {
-            fifo_reset(&s->rx);
+            fifo8_reset(&s->rx);
             s->reg[I_(UFCON)] &=3D ~UFCON_Rx_FIFO_RESET;
             trace_exynos_uart_rx_fifo_reset(s->channel);
         }
         if (val & UFCON_Tx_FIFO_RESET) {
-            fifo_reset(&s->tx);
+            fifo8_reset(&s->tx);
             s->reg[I_(UFCON)] &=3D ~UFCON_Tx_FIFO_RESET;
             trace_exynos_uart_tx_fifo_reset(s->channel);
         }
@@ -490,8 +448,8 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr=
 offset,
                                exynos4210_uart_regname(offset), res);
         return res;
     case UFSTAT: /* Read Only */
-        s->reg[I_(UFSTAT)] =3D fifo_elements_number(&s->rx) & 0xff;
-        if (fifo_empty_elements_number(&s->rx) =3D=3D 0) {
+        s->reg[I_(UFSTAT)] =3D fifo8_num_used(&s->rx) & 0xff;
+        if (fifo8_num_free(&s->rx) =3D=3D 0) {
             s->reg[I_(UFSTAT)] |=3D UFSTAT_Rx_FIFO_FULL;
             s->reg[I_(UFSTAT)] &=3D ~0xff;
         }
@@ -501,10 +459,10 @@ static uint64_t exynos4210_uart_read(void *opaque, hwad=
dr offset,
         return s->reg[I_(UFSTAT)];
     case URXH:
         if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-            if (fifo_elements_number(&s->rx)) {
-                res =3D fifo_retrieve(&s->rx);
+            if (fifo8_num_used(&s->rx)) {
+                res =3D fifo8_pop(&s->rx);
                 trace_exynos_uart_rx(s->channel, res);
-                if (!fifo_elements_number(&s->rx)) {
+                if (!fifo8_num_used(&s->rx)) {
                     s->reg[I_(UTRSTAT)] &=3D ~UTRSTAT_Rx_BUFFER_DATA_READY;
                 } else {
                     s->reg[I_(UTRSTAT)] |=3D UTRSTAT_Rx_BUFFER_DATA_READY;
@@ -555,7 +513,7 @@ static int exynos4210_uart_can_receive(void *opaque)
     Exynos4210UartState *s =3D (Exynos4210UartState *)opaque;
=20
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-        return fifo_empty_elements_number(&s->rx);
+        return fifo8_num_free(&s->rx);
     } else {
         return !(s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY);
     }
@@ -567,12 +525,12 @@ static void exynos4210_uart_receive(void *opaque, const=
 uint8_t *buf, int size)
     int i;
=20
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-        if (fifo_empty_elements_number(&s->rx) < size) {
-            size =3D fifo_empty_elements_number(&s->rx);
+        if (fifo8_num_free(&s->rx) < size) {
+            size =3D fifo8_num_free(&s->rx);
             s->reg[I_(UINTSP)] |=3D UINTSP_ERROR;
         }
         for (i =3D 0; i < size; i++) {
-            fifo_store(&s->rx, buf[i]);
+            fifo8_push(&s->rx, buf[i]);
         }
         exynos4210_uart_rx_timeout_set(s);
     } else {
@@ -591,7 +549,7 @@ static void exynos4210_uart_event(void *opaque, QEMUChrEv=
ent event)
     if (event =3D=3D CHR_EVENT_BREAK) {
         /* When the RxDn is held in logic 0, then a null byte is pushed into=
 the
          * fifo */
-        fifo_store(&s->rx, '\0');
+        fifo8_push(&s->rx, '\0');
         s->reg[I_(UERSTAT)] |=3D UERSTAT_BREAK;
         exynos4210_uart_update_irq(s);
     }
@@ -608,10 +566,10 @@ static void exynos4210_uart_reset(DeviceState *dev)
                 exynos4210_uart_regs[i].reset_value;
     }
=20
-    fifo_reset(&s->rx);
-    fifo_reset(&s->tx);
+    fifo8_reset(&s->rx);
+    fifo8_reset(&s->tx);
=20
-    trace_exynos_uart_rxsize(s->channel, s->rx.size);
+    trace_exynos_uart_rxsize(s->channel, s->rx_capacity);
 }
=20
 static int exynos4210_uart_post_load(void *opaque, int version_id)
@@ -624,26 +582,13 @@ static int exynos4210_uart_post_load(void *opaque, int =
version_id)
     return 0;
 }
=20
-static const VMStateDescription vmstate_exynos4210_uart_fifo =3D {
-    .name =3D "exynos4210.uart.fifo",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .fields =3D (const VMStateField[]) {
-        VMSTATE_UINT32(sp, Exynos4210UartFIFO),
-        VMSTATE_UINT32(rp, Exynos4210UartFIFO),
-        VMSTATE_VBUFFER_UINT32(data, Exynos4210UartFIFO, 1, NULL, size),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_exynos4210_uart =3D {
     .name =3D "exynos4210.uart",
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .post_load =3D exynos4210_uart_post_load,
     .fields =3D (const VMStateField[]) {
-        VMSTATE_STRUCT(rx, Exynos4210UartState, 1,
-                       vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
+        VMSTATE_FIFO8(rx, Exynos4210UartState),
         VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
                              EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t=
)),
         VMSTATE_END_OF_LIST()
@@ -699,6 +644,8 @@ static void exynos4210_uart_realize(DeviceState *dev, Err=
or **errp)
     s->fifo_timeout_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                          exynos4210_uart_timeout_int, s);
=20
+    fifo8_create(&s->rx, s->rx_capacity);
+    fifo8_create(&s->tx, s->tx_capacity);
     qemu_chr_fe_set_handlers(&s->chr, exynos4210_uart_can_receive,
                              exynos4210_uart_receive, exynos4210_uart_event,
                              NULL, s, NULL, true);
@@ -707,8 +654,8 @@ static void exynos4210_uart_realize(DeviceState *dev, Err=
or **errp)
 static const Property exynos4210_uart_properties[] =3D {
     DEFINE_PROP_CHR("chardev", Exynos4210UartState, chr),
     DEFINE_PROP_UINT32("channel", Exynos4210UartState, channel, 0),
-    DEFINE_PROP_UINT32("rx-size", Exynos4210UartState, rx.size, 16),
-    DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx.size, 16),
+    DEFINE_PROP_UINT32("rx-size", Exynos4210UartState, rx_capacity, 16),
+    DEFINE_PROP_UINT32("tx-size", Exynos4210UartState, tx_capacity, 16),
 };
=20
 static void exynos4210_uart_class_init(ObjectClass *klass, const void *data)
--=20
2.49.1

