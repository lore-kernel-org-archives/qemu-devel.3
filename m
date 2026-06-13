Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D311BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUPD-00014c-QA; Sat, 13 Jun 2026 15:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOS-0000hj-HX; Sat, 13 Jun 2026 15:51:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUOQ-0003Su-PS; Sat, 13 Jun 2026 15:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380258; bh=jL3Sl70exSH7G5xeGK3CC+IHQDNidsmUOqIu95etxZY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cl4R4MuNkPuW1cc3G7FwO7JvbF2k4t3bSu9FmvjOx6Jcb/AS17qL1twExjyFZZnJF
 2Nqu1fiHMwkkfHzCuG/7kEsxSTRyrHNVN+rTkb+vYXBg8C4GYnU7FEhGxii7Mi1eYi
 fygDrLmhAQZz5Nxaj73vc+BcBV/E3Fy35HrW8brPpXuqBaOrz97Xehq8GwFG8/KBdB
 A1ipLrqIB2Ag1aU3ZlYG87GH18b3ik6ds0pa7kqd1GGr1R6qn3PXZkX3Q7//IARW1L
 4TOQJcfhzo3e8CLxXnKVmNePR1SAxbzbXJi6ERBYHjCN3I/FMTazxeXdCGyOU6dtnk
 /AZU4Yx/K890Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 459A11B6E15;
 Sat, 13 Jun 2026 22:50:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9E5DA3CE88F;
 Sat, 13 Jun 2026 22:51:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 06/56] hw/char: sifive_uart: Implement txctrl.txen
 and rxctrl.rxen
Date: Sat, 13 Jun 2026 22:50:20 +0300
Message-ID: <20260613195116.1807273-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Frank Chang <frank.chang@sifive.com>

Implement txctrl.txen and rxctrl.rxen as follows:

* txctrl.txen
  The txen bit controls whether the Tx channel is active. When cleared,
  transmission of Tx FIFO contents is suppressed, and the txd pin is
  driven high.

* rxctrl.rxen:
  The rxen bit controls whether the Rx channel is active. When cleared,
  the state of the rxd pin is ignored, and no characters will be
  enqueued into the Rx FIFO.

Therefore, the Tx FIFO should not be dequeued when txctrl.txen is
cleared, and the Rx FIFO should not be enqueued when rxctrl.rxen is
cleared.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260312033201.1619554-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit e6051fa61b9f6fe9c40d8392b6da1f33e9d88332)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index c4258c2ebf..2efe0e02bd 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -84,6 +84,11 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
         return G_SOURCE_REMOVE;
     }
 
+    /* Don't pop the FIFO if transmit is disabled. */
+    if (!SIFIVE_UART_TXEN(s->txctrl)) {
+        return G_SOURCE_REMOVE;
+    }
+
     /* Don't pop the FIFO in case the write fails */
     characters = fifo8_peek_bufptr(&s->tx_fifo,
                                    fifo8_num_used(&s->tx_fifo), &numptr);
@@ -112,11 +117,19 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
     return G_SOURCE_REMOVE;
 }
 
-static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
-                                      int size)
+static void sifive_uart_trigger_tx_fifo(SiFiveUARTState *s)
 {
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
+    if (!timer_pending(s->fifo_trigger_handle)) {
+        timer_mod(s->fifo_trigger_handle, current_time +
+            TX_INTERRUPT_TRIGGER_DELAY_NS);
+    }
+}
+
+static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
+                                      int size)
+{
     if (size > fifo8_num_free(&s->tx_fifo)) {
         size = fifo8_num_free(&s->tx_fifo);
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
@@ -128,10 +141,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    if (!timer_pending(s->fifo_trigger_handle)) {
-        timer_mod(s->fifo_trigger_handle, current_time +
-                      TX_INTERRUPT_TRIGGER_DELAY_NS);
-    }
+    sifive_uart_trigger_tx_fifo(s);
 }
 
 static uint64_t
@@ -188,6 +198,9 @@ sifive_uart_write(void *opaque, hwaddr addr,
         return;
     case SIFIVE_UART_TXCTRL:
         s->txctrl = val64;
+        if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
+            sifive_uart_trigger_tx_fifo(s);
+        }
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
@@ -235,7 +248,7 @@ static int sifive_uart_can_rx(void *opaque)
 {
     SiFiveUARTState *s = opaque;
 
-    return s->rx_fifo_len < sizeof(s->rx_fifo);
+    return SIFIVE_UART_RXEN(s->rxctrl) && (s->rx_fifo_len < sizeof(s->rx_fifo));
 }
 
 static void sifive_uart_event(void *opaque, QEMUChrEvent event)
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 0846cf6218..33bb03b03b 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -51,6 +51,8 @@ enum {
 
 #define SIFIVE_UART_TXFIFO_FULL    0x80000000
 
+#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
+#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
 
-- 
2.47.3


