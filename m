Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4B2CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITrs-0000N5-Kz; Thu, 30 Apr 2026 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITrH-0007Vv-Bx; Thu, 30 Apr 2026 12:03:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1wITr9-00078P-Cr; Thu, 30 Apr 2026 12:03:20 -0400
DKIM-Signature: a=rsa-sha256; bh=V52m1Fb2l3IIihP5FiYiKI6ZXzE5ABAlbcP+z2Dgx7c=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1777564992; v=1;
 b=JlQ7jFDTl4B/KYDUGl1Xlt5oSk4RBChHpLBajkHOKo768LkTjLvfHUs1E2CWZ1+EYRkqpt1P
 byMYZKRRm4LGnraZJ84I+N5UtDh0R5Iwi+3Pwletx2xSBKdFVLm3WZNkGyKex9rrpbj/HUCGdZ6
 znjtebgWRfpIcNJxT5XdQLZjxVH5ZqkRYd4R4EGzCTCZrU48TXH0pP8Z2ij9pr+COrFQPOTOZS+
 RdCr+9nMBM1pdAz47HX06JkneRzrdZD4THs4yEf3hrdE8DVgCX8tl878PggoUSGXRLFVoOBu6kD
 iBpXK5HPxRrAUIRmpbFhX02fcu9IbYFBMTQrFH19MT2FA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 2020320C19;
 Thu, 30 Apr 2026 16:03:12 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 07 Apr 2026 13:44:36 +0100
Subject: [PATCH qemu v4 3/9] ot_uart: update register defs, switch to Fifo8
 for tx/rx buffers
Message-ID: <177756498815.8917.12449488721849651971-3@git.sr.ht>
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

The register definitions for the UART device need to be updated to match
the documentation at https://opentitan.org/book/hw/ip/uart/doc/registers.html

This commit does that, and also switches to using Fifo8 for managing the
transmit and receive buffers.

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 hw/char/ot_uart.c         | 338 ++++++++++++++++++++++----------------
 include/hw/char/ot_uart.h |  18 +-
 2 files changed, 201 insertions(+), 155 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index 9478af40f9..3fe7c5efe5 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -27,6 +27,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/char/ot_uart.h"
+#include "qemu/fifo8.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
@@ -37,16 +38,22 @@
 #include "qemu/module.h"
=20
 REG32(INTR_STATE, 0x00)
-    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
-    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
-    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
-    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
+    SHARED_FIELD(INTR_TX_WATERMARK, 0, 1)
+    SHARED_FIELD(INTR_RX_WATERMARK, 1, 1)
+    SHARED_FIELD(INTR_TX_DONE, 2, 1)
+    SHARED_FIELD(INTR_RX_OVERFLOW, 3, 1)
+    SHARED_FIELD(INTR_RX_FRAME_ERR, 4, 1)
+    SHARED_FIELD(INTR_RX_BREAK_ERR, 5, 1)
+    SHARED_FIELD(INTR_RX_TIMEOUT, 6, 1)
+    SHARED_FIELD(INTR_RX_PARITY_ERR, 7, 1)
+    SHARED_FIELD(INTR_TX_EMPTY, 8, 1)
 REG32(INTR_ENABLE, 0x04)
 REG32(INTR_TEST, 0x08)
 REG32(ALERT_TEST, 0x0C)
+    FIELD(ALERT_TEST, FATAL_FAULT, 0, 1)
 REG32(CTRL, 0x10)
-    FIELD(CTRL, TX_ENABLE, 0, 1)
-    FIELD(CTRL, RX_ENABLE, 1, 1)
+    FIELD(CTRL, TX, 0, 1)
+    FIELD(CTRL, RX, 1, 1)
     FIELD(CTRL, NF, 2, 1)
     FIELD(CTRL, SLPBK, 4, 1)
     FIELD(CTRL, LLPBK, 5, 1)
@@ -58,43 +65,74 @@ REG32(STATUS, 0x14)
     FIELD(STATUS, TXFULL, 0, 1)
     FIELD(STATUS, RXFULL, 1, 1)
     FIELD(STATUS, TXEMPTY, 2, 1)
+    FIELD(STATUS, TXIDLE, 3, 1)
     FIELD(STATUS, RXIDLE, 4, 1)
     FIELD(STATUS, RXEMPTY, 5, 1)
 REG32(RDATA, 0x18)
+    FIELD(RDATA, RDATA, 0, 8)
 REG32(WDATA, 0x1C)
+    FIELD(WDATA, WDATA, 0, 8)
 REG32(FIFO_CTRL, 0x20)
     FIELD(FIFO_CTRL, RXRST, 0, 1)
     FIELD(FIFO_CTRL, TXRST, 1, 1)
     FIELD(FIFO_CTRL, RXILVL, 2, 3)
-    FIELD(FIFO_CTRL, TXILVL, 5, 2)
+    FIELD(FIFO_CTRL, TXILVL, 5, 3)
 REG32(FIFO_STATUS, 0x24)
-    FIELD(FIFO_STATUS, TXLVL, 0, 5)
-    FIELD(FIFO_STATUS, RXLVL, 16, 5)
+    FIELD(FIFO_STATUS, TXLVL, 0, 8)
+    FIELD(FIFO_STATUS, RXLVL, 16, 8)
 REG32(OVRD, 0x28)
+    FIELD(OVRD, TXEN, 0, 1)
+    FIELD(OVRD, TXVAL, 1, 1)
 REG32(VAL, 0x2C)
+    FIELD(VAL, RX, 0, 16)
 REG32(TIMEOUT_CTRL, 0x30)
+    FIELD(TIMEOUT_CTRL, VAL, 0, 24)
+    FIELD(TIMEOUT_CTRL, EN, 31, 1)
+
+#define INTR_MASK \
+    (INTR_TX_WATERMARK_MASK | INTR_RX_WATERMARK_MASK | INTR_TX_DONE_MASK | \
+     INTR_RX_OVERFLOW_MASK | INTR_RX_FRAME_ERR_MASK | INTR_RX_BREAK_ERR_MASK=
 | \
+     INTR_RX_TIMEOUT_MASK | INTR_RX_PARITY_ERR_MASK | INTR_TX_EMPTY_MASK)
+
+#define CTRL_MASK \
+    (R_CTRL_TX_MASK | R_CTRL_RX_MASK | R_CTRL_NF_MASK | R_CTRL_SLPBK_MASK | \
+     R_CTRL_LLPBK_MASK | R_CTRL_PARITY_EN_MASK | R_CTRL_PARITY_ODD_MASK | \
+     R_CTRL_RXBLVL_MASK | R_CTRL_NCO_MASK)
+
+#define OT_UART_NCO_BITS     16
+#define OT_UART_TX_FIFO_SIZE 128
+#define OT_UART_RX_FIFO_SIZE 128
+
+#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
+
+#define R_LAST_REG (R_TIMEOUT_CTRL)
+#define REGS_COUNT (R_LAST_REG + 1u)
+#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
=20
 static void ot_uart_update_irqs(OtUARTState *s)
 {
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATERMARK=
_MASK) {
+    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
+        & INTR_TX_WATERMARK_MASK) {
         qemu_set_irq(s->tx_watermark, 1);
     } else {
         qemu_set_irq(s->tx_watermark, 0);
     }
=20
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_WATERMARK=
_MASK) {
+    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
+        & INTR_RX_WATERMARK_MASK) {
         qemu_set_irq(s->rx_watermark, 1);
     } else {
         qemu_set_irq(s->rx_watermark, 0);
     }
=20
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_EMPTY_MAS=
K) {
+    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE] & INTR_TX_EMPTY_MASK)=
 {
         qemu_set_irq(s->tx_empty, 1);
     } else {
         qemu_set_irq(s->tx_empty, 0);
     }
=20
-    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_OVERFLOW_=
MASK) {
+    if (s->regs[R_INTR_STATE] & s->regs[R_INTR_ENABLE]
+        & INTR_RX_OVERFLOW_MASK) {
         qemu_set_irq(s->rx_overflow, 1);
     } else {
         qemu_set_irq(s->rx_overflow, 0);
@@ -105,122 +143,133 @@ static int ot_uart_can_receive(void *opaque)
 {
     OtUARTState *s =3D opaque;
=20
-    if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK)
-           && !(s->uart_status & R_STATUS_RXFULL_MASK)) {
-        return 1;
+    if (s->regs[R_CTRL] & R_CTRL_RX_MASK) {
+        return (int)fifo8_num_free(&s->rx_fifo);
     }
=20
     return 0;
 }
=20
+static uint32_t ot_uart_get_rx_watermark_level(const OtUARTState *s)
+{
+    uint32_t rx_ilvl =3D FIELD_EX32(s->regs[R_FIFO_CTRL], FIFO_CTRL, RXILVL);
+
+    return rx_ilvl < 7 ? (1 << rx_ilvl) : 126;
+}
+
 static void ot_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     OtUARTState *s =3D opaque;
-    uint8_t rx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MASK)
-                            >> R_FIFO_CTRL_RXILVL_SHIFT;
-
-    s->uart_rdata =3D *buf;
+    uint32_t rx_watermark_level;
+    size_t count =3D MIN(fifo8_num_free(&s->rx_fifo), (size_t)size);
=20
-    s->uart_status &=3D ~R_STATUS_RXIDLE_MASK;
-    s->uart_status &=3D ~R_STATUS_RXEMPTY_MASK;
-    /* The RXFULL is set after receiving a single byte
-     * as the FIFO buffers are not yet implemented.
-     */
-    s->uart_status |=3D R_STATUS_RXFULL_MASK;
-    s->rx_level +=3D 1;
+    for (int index =3D 0; index < size; index++) {
+        fifo8_push(&s->rx_fifo, buf[index]);
+    }
=20
-    if (size > rx_fifo_level) {
-        s->uart_intr_state |=3D R_INTR_STATE_RX_WATERMARK_MASK;
+    /* update INTR_STATE */
+    if (count !=3D size) {
+        s->regs[R_INTR_STATE] |=3D INTR_RX_OVERFLOW_MASK;
+    }
+    rx_watermark_level =3D ot_uart_get_rx_watermark_level(s);
+    if (rx_watermark_level && size >=3D rx_watermark_level) {
+        s->regs[R_INTR_STATE] |=3D INTR_RX_WATERMARK_MASK;
     }
=20
     ot_uart_update_irqs(s);
 }
=20
-static gboolean ot_uart_xmit(void *do_not_use, GIOCondition cond,
-                             void *opaque)
+static void ot_uart_reset_tx_fifo(OtUARTState *s)
 {
-    OtUARTState *s =3D opaque;
-    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
-                            >> R_FIFO_CTRL_TXILVL_SHIFT;
-    int ret;
-
-    /* instant drain the fifo when there's no back-end */
-    if (!qemu_chr_fe_backend_connected(&s->chr)) {
-        s->tx_level =3D 0;
-        return G_SOURCE_REMOVE;
+    fifo8_reset(&s->tx_fifo);
+    s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
+    s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
+    if (s->tx_watermark_level) {
+        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
+        s->tx_watermark_level =3D 0;
     }
+}
=20
-    if (!s->tx_level) {
-        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
-        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
-        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
-        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
-        ot_uart_update_irqs(s);
-        return G_SOURCE_REMOVE;
+static void ot_uart_reset_rx_fifo(OtUARTState *s)
+{
+    fifo8_reset(&s->rx_fifo);
+    s->regs[R_INTR_STATE] &=3D ~INTR_RX_WATERMARK_MASK;
+    s->regs[R_INTR_STATE] &=3D ~INTR_RX_OVERFLOW_MASK;
+    if (FIELD_EX32(s->regs[R_CTRL], CTRL, RX)) {
+        qemu_chr_fe_accept_input(&s->chr);
     }
+}
=20
-    ret =3D qemu_chr_fe_write(&s->chr, s->tx_fifo, s->tx_level);
+static uint32_t ot_uart_get_tx_watermark_level(const OtUARTState *s)
+{
+    uint32_t tx_ilvl =3D FIELD_EX32(s->regs[R_FIFO_CTRL], FIFO_CTRL, TXILVL);
=20
-    if (ret >=3D 0) {
-        s->tx_level -=3D ret;
-        memmove(s->tx_fifo, s->tx_fifo + ret, s->tx_level);
-    }
+    return tx_ilvl < 7 ? (1 << tx_ilvl) : 64;
+}
=20
-    if (s->tx_level) {
-        guint r =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
-                                        ot_uart_xmit, s);
-        if (!r) {
-            s->tx_level =3D 0;
-            return G_SOURCE_REMOVE;
-        }
+static void ot_uart_xmit(OtUARTState *s)
+{
+    const uint8_t *buf;
+    uint32_t size;
+    int ret;
+
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        return;
     }
=20
-    /* Clear the TX Full bit */
-    if (s->tx_level !=3D OT_UART_TX_FIFO_SIZE) {
-        s->uart_status &=3D ~R_STATUS_TXFULL_MASK;
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        ot_uart_reset_tx_fifo(s);
+        ot_uart_update_irqs(s);
+        return;
     }
=20
-    /* Disable the TX_WATERMARK IRQ */
-    if (s->tx_level < tx_fifo_level) {
-        s->uart_intr_state &=3D ~R_INTR_STATE_TX_WATERMARK_MASK;
+    /* get a continuous buffer from the FIFO */
+    buf =3D
+        fifo8_peek_bufptr(&s->tx_fifo, fifo8_num_used(&s->tx_fifo), &size);
+    /* send as much as possible */
+    ret =3D qemu_chr_fe_write(&s->chr, buf, (int)size);
+    /* if some characters where sent, remove them from the FIFO */
+    if (ret >=3D 0) {
+        fifo8_drop(&s->tx_fifo, ret);
     }
=20
-    /* Set TX empty */
-    if (s->tx_level =3D=3D 0) {
-        s->uart_status |=3D R_STATUS_TXEMPTY_MASK;
-        s->uart_intr_state |=3D R_INTR_STATE_TX_EMPTY_MASK;
+    /* update INTR_STATE */
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        s->regs[R_INTR_STATE] |=3D INTR_TX_EMPTY_MASK;
+        s->regs[R_INTR_STATE] |=3D INTR_TX_DONE_MASK;
+    }
+    if (s->tx_watermark_level &&
+        fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
+        s->regs[R_INTR_STATE] |=3D INTR_TX_WATERMARK_MASK;
+        s->tx_watermark_level =3D 0;
     }
=20
     ot_uart_update_irqs(s);
-    return G_SOURCE_REMOVE;
 }
=20
-static void uart_write_tx_fifo(OtUARTState *s, const uint8_t *buf,
-                               int size)
+static void uart_write_tx_fifo(OtUARTState *s, uint8_t val)
 {
     uint64_t current_time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    uint8_t tx_fifo_level =3D (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
-                            >> R_FIFO_CTRL_TXILVL_SHIFT;
-
-    if (size > OT_UART_TX_FIFO_SIZE - s->tx_level) {
-        size =3D OT_UART_TX_FIFO_SIZE - s->tx_level;
+    if (fifo8_is_full(&s->tx_fifo)) {
         qemu_log_mask(LOG_GUEST_ERROR, "ot_uart: TX FIFO overflow");
+        return;
     }
=20
-    memcpy(s->tx_fifo + s->tx_level, buf, size);
-    s->tx_level +=3D size;
+    fifo8_push(&s->tx_fifo, val);
=20
-    if (s->tx_level > 0) {
-        s->uart_status &=3D ~R_STATUS_TXEMPTY_MASK;
+    s->tx_watermark_level =3D ot_uart_get_tx_watermark_level(s);
+    if (fifo8_num_used(&s->tx_fifo) < s->tx_watermark_level) {
+        /*
+         * TX watermark interrupt is raised when FIFO depth goes from above
+         * watermark to below. If we haven't reached watermark, reset cached
+         * watermark level
+         */
+        s->tx_watermark_level =3D 0;
     }
=20
-    if (s->tx_level >=3D tx_fifo_level) {
-        s->uart_intr_state |=3D R_INTR_STATE_TX_WATERMARK_MASK;
-        ot_uart_update_irqs(s);
-    }
-
-    if (s->tx_level =3D=3D OT_UART_TX_FIFO_SIZE) {
-        s->uart_status |=3D R_STATUS_TXFULL_MASK;
+    if (FIELD_EX32(s->regs[R_CTRL], CTRL, TX)) {
+        ot_uart_xmit(s);
     }
=20
     timer_mod(s->fifo_trigger_handle, current_time +
@@ -236,17 +285,13 @@ static void ot_uart_reset_enter(Object *obj, ResetType =
type)
         c->parent_phases.enter(obj, type);
     }
=20
-    s->uart_intr_state =3D 0x00000000;
-    s->uart_intr_state =3D 0x00000000;
-    s->uart_intr_enable =3D 0x00000000;
-    s->uart_ctrl =3D 0x00000000;
-    s->uart_status =3D 0x0000003c;
-    s->uart_rdata =3D 0x00000000;
-    s->uart_fifo_ctrl =3D 0x00000000;
-    s->uart_fifo_status =3D 0x00000000;
-    s->uart_ovrd =3D 0x00000000;
-    s->uart_val =3D 0x00000000;
-    s->uart_timeout_ctrl =3D 0x00000000;
+    memset(&s->regs[0], 0, sizeof(s->regs));
+
+    s->regs[R_STATUS] =3D 0x0000003c;
+
+    s->tx_watermark_level =3D 0;
+    ot_uart_reset_tx_fifo(s);
+    ot_uart_reset_rx_fifo(s);
=20
     s->tx_level =3D 0;
     s->rx_level =3D 0;
@@ -260,7 +305,7 @@ static uint64_t ot_uart_get_baud(OtUARTState *s)
 {
     uint64_t baud;
=20
-    baud =3D ((s->uart_ctrl & R_CTRL_NCO_MASK) >> 16);
+    baud =3D ((s->regs[R_CTRL] & R_CTRL_NCO_MASK) >> 16);
     baud *=3D clock_get_hz(s->f_clk);
     baud >>=3D 20;
=20
@@ -274,10 +319,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
=20
     switch (addr >> 2) {
     case R_INTR_STATE:
-        retvalue =3D s->uart_intr_state;
+        retvalue =3D s->regs[R_INTR_STATE];
         break;
     case R_INTR_ENABLE:
-        retvalue =3D s->uart_intr_enable;
+        retvalue =3D s->regs[R_INTR_ENABLE];
         break;
     case R_INTR_TEST:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -285,22 +330,22 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
         break;
=20
     case R_CTRL:
-        retvalue =3D s->uart_ctrl;
+        retvalue =3D s->regs[R_CTRL];
         break;
     case R_STATUS:
-        retvalue =3D s->uart_status;
+        retvalue =3D s->regs[R_STATUS];
         break;
=20
     case R_RDATA:
-        retvalue =3D s->uart_rdata;
-        if ((s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) && (s->rx_level > 0)) {
+        retvalue =3D s->regs[R_RDATA];
+        if ((s->regs[R_CTRL] & R_CTRL_RX_MASK) && (s->rx_level > 0)) {
             qemu_chr_fe_accept_input(&s->chr);
=20
             s->rx_level -=3D 1;
-            s->uart_status &=3D ~R_STATUS_RXFULL_MASK;
+            s->regs[R_STATUS] &=3D ~R_STATUS_RXFULL_MASK;
             if (s->rx_level =3D=3D 0) {
-                s->uart_status |=3D R_STATUS_RXIDLE_MASK;
-                s->uart_status |=3D R_STATUS_RXEMPTY_MASK;
+                s->regs[R_STATUS] |=3D R_STATUS_RXIDLE_MASK;
+                s->regs[R_STATUS] |=3D R_STATUS_RXEMPTY_MASK;
             }
         }
         break;
@@ -310,10 +355,10 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
         break;
=20
     case R_FIFO_CTRL:
-        retvalue =3D s->uart_fifo_ctrl;
+        retvalue =3D s->regs[R_FIFO_CTRL];
         break;
     case R_FIFO_STATUS:
-        retvalue =3D s->uart_fifo_status;
+        retvalue =3D s->regs[R_FIFO_STATUS];
=20
         retvalue |=3D (s->rx_level & 0x1F) << R_FIFO_STATUS_RXLVL_SHIFT;
         retvalue |=3D (s->tx_level & 0x1F) << R_FIFO_STATUS_TXLVL_SHIFT;
@@ -323,17 +368,17 @@ static uint64_t ot_uart_read(void *opaque, hwaddr addr,=
 unsigned int size)
         break;
=20
     case R_OVRD:
-        retvalue =3D s->uart_ovrd;
+        retvalue =3D s->regs[R_OVRD];
         qemu_log_mask(LOG_UNIMP,
                       "%s: ovrd is not supported\n", __func__);
         break;
     case R_VAL:
-        retvalue =3D s->uart_val;
+        retvalue =3D s->regs[R_VAL];
         qemu_log_mask(LOG_UNIMP,
                       "%s: val is not supported\n", __func__);
         break;
     case R_TIMEOUT_CTRL:
-        retvalue =3D s->uart_timeout_ctrl;
+        retvalue =3D s->regs[R_TIMEOUT_CTRL];
         qemu_log_mask(LOG_UNIMP,
                       "%s: timeout_ctrl is not supported\n", __func__);
         break;
@@ -355,20 +400,23 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
     switch (addr >> 2) {
     case R_INTR_STATE:
         /* Write 1 clear */
-        s->uart_intr_state &=3D ~value;
+        value &=3D INTR_MASK;
+        s->regs[R_INTR_STATE] &=3D ~value;
         ot_uart_update_irqs(s);
         break;
     case R_INTR_ENABLE:
-        s->uart_intr_enable =3D value;
+        value &=3D INTR_MASK;
+        s->regs[R_INTR_ENABLE] =3D value;
         ot_uart_update_irqs(s);
         break;
     case R_INTR_TEST:
-        s->uart_intr_state |=3D value;
+        value &=3D INTR_MASK;
+        s->regs[R_INTR_STATE] |=3D value;
         ot_uart_update_irqs(s);
         break;
=20
     case R_CTRL:
-        s->uart_ctrl =3D value;
+        s->regs[R_CTRL] =3D value;
=20
         if (value & R_CTRL_NF_MASK) {
             qemu_log_mask(LOG_UNIMP,
@@ -412,11 +460,11 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
                       "%s: rdata is read only\n", __func__);
         break;
     case R_WDATA:
-        uart_write_tx_fifo(s, (uint8_t *) &value, 1);
+        uart_write_tx_fifo(s, value);
         break;
=20
     case R_FIFO_CTRL:
-        s->uart_fifo_ctrl =3D value;
+        s->regs[R_FIFO_CTRL] =3D value;
=20
         if (value & R_FIFO_CTRL_RXRST_MASK) {
             s->rx_level =3D 0;
@@ -431,18 +479,20 @@ static void ot_uart_write(void *opaque, hwaddr addr, ui=
nt64_t val64,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: fifo_status is read only\n", __func__);
         break;
-
     case R_OVRD:
-        s->uart_ovrd =3D value;
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: ovrd is not supported\n", __func__);
+        if (value & R_OVRD_TXEN_MASK) {
+            qemu_log_mask(LOG_UNIMP, "%s: OVRD.TXEN is not supported\n",
+                          __func__);
+        }
+        s->regs[R_OVRD] =3D value & R_OVRD_TXVAL_MASK;
         break;
     case R_VAL:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: val is read only\n", __func__);
         break;
     case R_TIMEOUT_CTRL:
-        s->uart_timeout_ctrl =3D value;
+        s->regs[R_TIMEOUT_CTRL] =3D
+            value & (R_TIMEOUT_CTRL_EN_MASK | R_TIMEOUT_CTRL_VAL_MASK);
         qemu_log_mask(LOG_UNIMP,
                       "%s: timeout_ctrl is not supported\n", __func__);
         break;
@@ -466,8 +516,8 @@ static void fifo_trigger_update(void *opaque)
 {
     OtUARTState *s =3D opaque;
=20
-    if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
-        ot_uart_xmit(NULL, G_IO_OUT, s);
+    if (s->regs[R_CTRL] & R_CTRL_TX_MASK) {
+        ot_uart_xmit(s);
     }
 }
=20
@@ -489,25 +539,17 @@ static int ot_uart_post_load(void *opaque, int version_=
id)
=20
 static const VMStateDescription vmstate_ot_uart =3D {
     .name =3D TYPE_OT_UART,
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
+    .version_id =3D 2,
+    .minimum_version_id =3D 2,
     .post_load =3D ot_uart_post_load,
     .fields =3D (const VMStateField[]) {
-        VMSTATE_UINT8_ARRAY(tx_fifo, OtUARTState,
-                            OT_UART_TX_FIFO_SIZE),
+        VMSTATE_STRUCT(tx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
+        VMSTATE_STRUCT(rx_fifo, OtUARTState, 1, vmstate_fifo8, Fifo8),
         VMSTATE_UINT32(tx_level, OtUARTState),
         VMSTATE_UINT64(char_tx_time, OtUARTState),
         VMSTATE_TIMER_PTR(fifo_trigger_handle, OtUARTState),
-        VMSTATE_UINT32(uart_intr_state, OtUARTState),
-        VMSTATE_UINT32(uart_intr_enable, OtUARTState),
-        VMSTATE_UINT32(uart_ctrl, OtUARTState),
-        VMSTATE_UINT32(uart_status, OtUARTState),
-        VMSTATE_UINT32(uart_rdata, OtUARTState),
-        VMSTATE_UINT32(uart_fifo_ctrl, OtUARTState),
-        VMSTATE_UINT32(uart_fifo_status, OtUARTState),
-        VMSTATE_UINT32(uart_ovrd, OtUARTState),
-        VMSTATE_UINT32(uart_val, OtUARTState),
-        VMSTATE_UINT32(uart_timeout_ctrl, OtUARTState),
+        VMSTATE_ARRAY(regs, OtUARTState, REGS_COUNT, 1, vmstate_info_uint32,
+                      uint32_t),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -529,9 +571,16 @@ static void ot_uart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_overflow);
=20
-    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s,
-                          TYPE_OT_UART, 0x400);
+    memory_region_init_io(&s->mmio, obj, &ot_uart_ops, s, TYPE_OT_UART,
+                          REGS_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    /*
+     * This array has a fixed size in the header. This assertion is used to
+     * check that it is consistent with the definition in this file. This is
+     * ostensibly a runtime check, but may be optimised away by the compiler.
+     */
+    assert(REGS_SIZE =3D=3D sizeof(s->regs));
 }
=20
 static void ot_uart_realize(DeviceState *dev, Error **errp)
@@ -541,6 +590,9 @@ static void ot_uart_realize(DeviceState *dev, Error **err=
p)
     s->fifo_trigger_handle =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           fifo_trigger_update, s);
=20
+    fifo8_create(&s->tx_fifo, OT_UART_TX_FIFO_SIZE);
+    fifo8_create(&s->rx_fifo, OT_UART_RX_FIFO_SIZE);
+
     qemu_chr_fe_set_handlers(&s->chr, ot_uart_can_receive,
                              ot_uart_receive, NULL, NULL,
                              s, NULL, true);
diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index fee2128f90..f489612700 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -26,11 +26,11 @@
 #define HW_OT_UART_H
=20
 #include "hw/core/sysbus.h"
+#include "qemu/fifo8.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 #include "qom/object.h"
=20
-#define OT_UART_TX_FIFO_SIZE 16
 #define OT_UART_CLOCK 50000000 /* 50MHz clock */
=20
 #define TYPE_OT_UART "ot-uart"
@@ -43,7 +43,6 @@ struct OtUARTState {
     /* <public> */
     MemoryRegion mmio;
=20
-    uint8_t tx_fifo[OT_UART_TX_FIFO_SIZE];
     uint32_t tx_level;
=20
     uint32_t rx_level;
@@ -51,16 +50,11 @@ struct OtUARTState {
     QEMUTimer *fifo_trigger_handle;
     uint64_t char_tx_time;
=20
-    uint32_t uart_intr_state;
-    uint32_t uart_intr_enable;
-    uint32_t uart_ctrl;
-    uint32_t uart_status;
-    uint32_t uart_rdata;
-    uint32_t uart_fifo_ctrl;
-    uint32_t uart_fifo_status;
-    uint32_t uart_ovrd;
-    uint32_t uart_val;
-    uint32_t uart_timeout_ctrl;
+    uint32_t regs[13]; /* Length must be updated if regs added or removed */
+
+    Fifo8 tx_fifo;
+    Fifo8 rx_fifo;
+    uint32_t tx_watermark_level;
=20
     Clock *f_clk;
=20
--=20
2.49.1


