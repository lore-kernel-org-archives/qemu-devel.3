Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4797ECD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrw-0000VT-VQ; Thu, 30 Apr 2026 12:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrK-0007c9-SY; Thu, 30 Apr 2026 12:03:30 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrC-00078y-9J; Thu, 30 Apr 2026 12:03:24 -0400
DKIM-Signature: a=rsa-sha256; bh=4eJ+HnMcX8p6InMQPVwB32zKkriVDrfCwoCMifz9Wxk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564993; v=1;
 b=nYqM86HtlOBZzXGHMW9tDfq7lBL57+bN7udMVIx2jyngpa7jHAIG/VgVc52ABW2HLjr78nRE
 Oam/zhAOX6XXERoh/ROy362SJOiHMuSsV7uf3r0p6b89QuQiSntyDpt0+mPkl63MmNGDVV6zhev
 PxgReGM5TPlBSJ2O77lTZO91nQOyaPU8RV9GTImebp/MecNVqvuQDKPT0GYK37KkPQvI1df845u
 IAWvjsO5zIfqOMykUfS8BwCYARRLqL6tDSmjzWJlGUvTxTJsP8M4du7yt8JBJA1gnwIY2Q5Of8F
 lX8ofz4/NnSc9J83PJCU+rNoWv+b/V52LWNXaaZdka7nw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 6D13920C7D;
 Thu, 30 Apr 2026 16:03:13 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Mon, 13 Apr 2026 19:01:26 +0100
Subject: [PATCH qemu v4 6/9] ot_uart: implement RX fifo and loopback
Message-ID: <177756498815.8917.12449488721849651971-6@git.sr.ht>
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

The STATUS register value is now generated on every read instead of being
tracked in memory since it has such a dynamic value. the receive fifo is now
implemented, and the system loopback mode. (line loopback is not supported)

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c | 160 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 112 insertions(+), 48 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 2247db7110..3511a42fbe 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -140,6 +140,21 @@ static void ot_uart_update_irqs(OtUARTState *s)
     }
 }
=20
+static bool ot_uart_is_sys_loopack_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s->regs[R_CTRL], CTRL, SLPBK);
+}
+
+static bool ot_uart_is_tx_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s->regs[R_CTRL], CTRL, TX);
+}
+
+static bool ot_uart_is_rx_enabled(const OtUARTState *s)
+{
+    return FIELD_EX32(s->regs[R_CTRL], CTRL, RX);
+}
+
 static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
@@ -196,7 +211,7 @@ static void ot_uart_reset_rx_fifo(OtUARTState *s)
     fifo8_reset(&s->rx_fifo);
     s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
     s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
-    if (FIELD_EX32(s->regs[R_CTRL], CTRL, RX)) {
+    if (ot_uart_is_rx_enabled(s)) {
         qemu_chr_fe_accept_input(&s->chr);
     }
 }
@@ -218,21 +233,37 @@ static void ot_uart_xmit(OtUARTState *s)
         return;
     }
=20
-    /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_backend_connected(&s->chr)) {
-        ot_uart_reset_tx_fifo(s);
-        ot_uart_update_irqs(s);
-        return;
-    }
+    if (ot_uart_is_sys_loopack_enabled(s)) {
+        /* system loopback mode, just forward to RX FIFO */
+        uint32_t count =3D fifo8_num_used(&s->tx_fifo);
+        buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
+        ot_uart_receive(s, buf, (int)size);
+        count -=3D size;
+        /*
+         * there may be more data to send if data wraps around the end of TX
+         * FIFO
+         */
+        if (count) {
+            buf =3D fifo8_pop_bufptr(&s->tx_fifo, count, &size);
+            ot_uart_receive(s, buf, (int)size);
+        }
+    } else {
+        /* instant drain the fifo when there's no back-end */
+        if (!qemu_chr_fe_backend_connected(&s->chr)) {
+            ot_uart_reset_tx_fifo(s);
+            ot_uart_update_irqs(s);
+            return;
+        }
=20
-    /* get a continuous buffer from the FIFO */
-    buf =3D
-        fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &size);
-    /* send as much as possible */
-    ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
-    /* if some characters where sent, remove them from the FIFO */
-    if (ret >=3D 0) {
-        fifo8_drop(&s->tx_fifo, ret);
+        /* get a continuous buffer from the FIFO */
+        buf =3D
+            fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &siz=
e);
+        /* send as much as possible */
+        ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
+        /* if some characters where sent, remove them from the FIFO */
+        if (ret >=3D 0) {
+            fifo8_drop(&s->tx_fifo, ret);
+        }
     }
=20
     /* update INTR_STATE */
@@ -269,7 +300,7 @@ static void uart_write_tx_fifo(OtUARTState *s, uint8_t va=
l)
         s->tx_watermark_level =3D 0;
     }
=20
-    if (FIELD_EX32(s->regs[R_CTRL], CTRL, TX)) {
+    if (ot_uart_is_tx_enabled(s)) {
         ot_uart_xmit(s);
     }
=20
@@ -288,8 +319,6 @@ static void ot_uart_reset_enter(Object *obj, ResetType ty=
pe)
=20
     memset(&s->regs[0], 0, sizeof(s->regs));
=20
-    s->regs[R_STATUS] =3D 0x0000003c;
-
     s->tx_watermark_level =3D 0;
     for (unsigned index =3D 0; index < ARRAY_SIZE(s->irqs); index++) {
         qemu_set_irq(s->irqs[index], 0);
@@ -305,6 +334,27 @@ static void ot_uart_reset_enter(Object *obj, ResetType t=
ype)
     ot_uart_update_irqs(s);
 }
=20
+static uint8_t ot_uart_read_rx_fifo(OtUARTState *s)
+{
+    uint8_t val;
+
+    if (!(s->regs[R_CTRL] & R_CTRL_RX_MASK)) {
+        return 0;
+    }
+
+    if (fifo8_is_empty(&s->rx_fifo)) {
+        return 0;
+    }
+
+    val =3D fifo8_pop(&s->rx_fifo);
+
+    if (ot_uart_is_rx_enabled(s) && !ot_uart_is_sys_loopack_enabled(s)) {
+        qemu_chr_fe_accept_input(&s->chr);
+    }
+
+    return val;
+}
+
 static uint64_t ot_uart_get_baud(OtUARTState *s)
 {
     uint64_t baud;
@@ -327,32 +377,50 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
     case R_INTR_ENABLE:
     case R_CTRL:
     case R_FIFO_CTRL:
-    case R_STATUS:
         retvalue =3D s->regs[reg];
         break;
+    case R_STATUS:
+        /* assume that UART always report RXIDLE */
+        retvalue =3D R_STATUS_RXIDLE_MASK;
+        /* report RXEMPTY or RXFULL */
+        switch (fifo8_num_used(&s->rx_fifo)) {
+        case 0:
+            retvalue |=3D R_STATUS_RXEMPTY_MASK;
+            break;
+        case OT_UART_RX_FIFO_SIZE:
+            retvalue |=3D R_STATUS_RXFULL_MASK;
+            break;
+        default:
+            break;
+        }
+        /* report TXEMPTY+TXIDLE or TXFULL */
+        switch (fifo8_num_used(&s->tx_fifo)) {
+        case 0:
+            retvalue |=3D R_STATUS_TXEMPTY_MASK | R_STATUS_TXIDLE_MASK;
+            break;
+        case OT_UART_TX_FIFO_SIZE:
+            retvalue |=3D R_STATUS_TXFULL_MASK;
+            break;
+        default:
+            break;
+        }
+        if (!ot_uart_is_tx_enabled(s)) {
+            retvalue |=3D R_STATUS_TXIDLE_MASK;
+        }
+        if (!ot_uart_is_rx_enabled(s)) {
+            retvalue |=3D R_STATUS_RXIDLE_MASK;
+        }
+        break;
=20
     case R_RDATA:
-        retvalue =3D s->regs[R_RDATA];
-        if ((s->regs[R_CTRL] & R_CTRL_RX_MASK) && (s->rx_level > 0)) {
-            qemu_chr_fe_accept_input(&s->chr);
-
-            s->rx_level -=3D 1;
-            s->regs[R_STATUS] &=3D ~R_STATUS_RXFULL_MASK;
-            if (s->rx_level =3D=3D 0) {
-                s->regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
-                s->regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
-            }
-        }
+        retvalue =3D (uint32_t)ot_uart_read_rx_fifo(s);
         break;
=20
     case R_FIFO_STATUS:
-        retvalue =3D s->regs[R_FIFO_STATUS];
-
-        retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
-        retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
-
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: RX fifos are not supported\n", __func__);
+        retvalue =3D
+            (fifo8_num_used(&s->rx_fifo) & 0xffu) << R_FIFO_STATUS_RXLVL_SHI=
FT;
+        retvalue |=3D
+            (fifo8_num_used(&s->tx_fifo) & 0xffu) << R_FIFO_STATUS_TXLVL_SHI=
FT;
         break;
=20
     case R_VAL:
@@ -416,10 +484,6 @@ static void ot_uart_write(void *opaque, hwaddr addr, uin=
t64_t val64,
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_NF is not supported\n", __func__);
         }
-        if (value & R_CTRL_SLPBK_MASK) {
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: UART_CTRL_SLPBK is not supported\n", __func__=
);
-        }
         if (value & R_CTRL_LLPBK_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_LLPBK is not supported\n", __func__=
);
@@ -445,19 +509,19 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
         }
         break;
     case R_WDATA:
-        uart_write_tx_fifo(s, value);
+        uart_write_tx_fifo(s, (uint8_t)(value & R_WDATA_WDATA_MASK));
         break;
=20
     case R_FIFO_CTRL:
-        s->regs[R_FIFO_CTRL] =3D value;
-
+        s->regs[R_FIFO_CTRL] =3D
+            value & (R_FIFO_CTRL_RXILVL_MASK | R_FIFO_CTRL_TXILVL_MASK);
         if (value & R_FIFO_CTRL_RXRST_MASK) {
-            s->rx_level =3D 0;
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: RX fifos are not supported\n", __func__);
+            ot_uart_reset_rx_fifo(s);
+            ot_uart_update_irqs(s);
         }
         if (value & R_FIFO_CTRL_TXRST_MASK) {
-            s->tx_level =3D 0;
+            ot_uart_reset_tx_fifo(s);
+            ot_uart_update_irqs(s);
         }
         break;
     case R_OVRD:
--=20
2.49.1


