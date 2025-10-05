Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Sg0-0000Fr-Mv; Sun, 05 Oct 2025 13:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfu-0000Cb-FV; Sun, 05 Oct 2025 13:37:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sfs-0004cU-OT; Sun, 05 Oct 2025 13:37:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E254E15AA88;
 Sun, 05 Oct 2025 20:37:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2B2A299735;
 Sun,  5 Oct 2025 20:37:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Frank Chang <frank.chang@sifive.com>,
 Emmanuel Blot <emmanuel.blot@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 46/58] hw/char: sifive_uart: Raise IRQ according to
 the Tx/Rx watermark thresholds
Date: Sun,  5 Oct 2025 20:36:55 +0300
Message-ID: <20251005173712.445160-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frank Chang <frank.chang@sifive.com>

Currently, the SiFive UART raises an IRQ whenever:

  1. ie.txwm is enabled.
  2. ie.rxwm is enabled and the Rx FIFO is not empty.

It does not check the watermark thresholds set by software. However,
since commit [1] changed the SiFive UART character printing from
synchronous to asynchronous, Tx overflows may occur, causing characters
to be dropped when running Linux because:

  1. The Linux SiFive UART driver sets the transmit watermark level to 1
     [2], meaning a transmit watermark interrupt is raised whenever a
     character is enqueued into the Tx FIFO.
  2. Upon receiving a transmit watermark interrupt, the Linux driver
     transfers up to a full Tx FIFO's worth of characters from the Linux
     serial transmit buffer [3], without checking the txdata.full flag
     before transferring multiple characters [4].

To fix this issue, we must honor the Tx/Rx watermark thresholds and
raise interrupts only when the Tx threshold is exceeded or the Rx
threshold is undercut.

[1] 53c1557b230986ab6320a58e1b2c26216ecd86d5
[2] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L1039
[3] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L538
[4] https://github.com/torvalds/linux/blob/master/drivers/tty/serial/sifive.c#L291

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250911160647.5710-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 191df346175283af013f414375f4be59fb850120)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index b45e6c098c..6da3401aa3 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -35,16 +35,17 @@
  */
 
 /* Returns the state of the IP (interrupt pending) register */
-static uint64_t sifive_uart_ip(SiFiveUARTState *s)
+static uint32_t sifive_uart_ip(SiFiveUARTState *s)
 {
-    uint64_t ret = 0;
+    uint32_t ret = 0;
 
-    uint64_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
-    uint64_t rxcnt = SIFIVE_UART_GET_RXCNT(s->rxctrl);
+    uint32_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
+    uint32_t rxcnt = SIFIVE_UART_GET_RXCNT(s->rxctrl);
 
-    if (txcnt != 0) {
+    if (fifo8_num_used(&s->tx_fifo) < txcnt) {
         ret |= SIFIVE_UART_IP_TXWM;
     }
+
     if (s->rx_fifo_len > rxcnt) {
         ret |= SIFIVE_UART_IP_RXWM;
     }
@@ -55,15 +56,14 @@ static uint64_t sifive_uart_ip(SiFiveUARTState *s)
 static void sifive_uart_update_irq(SiFiveUARTState *s)
 {
     int cond = 0;
-    if ((s->ie & SIFIVE_UART_IE_TXWM) ||
-        ((s->ie & SIFIVE_UART_IE_RXWM) && s->rx_fifo_len)) {
+    uint32_t ip = sifive_uart_ip(s);
+
+    if (((ip & SIFIVE_UART_IP_TXWM) && (s->ie & SIFIVE_UART_IE_TXWM)) ||
+        ((ip & SIFIVE_UART_IP_RXWM) && (s->ie & SIFIVE_UART_IE_RXWM))) {
         cond = 1;
     }
-    if (cond) {
-        qemu_irq_raise(s->irq);
-    } else {
-        qemu_irq_lower(s->irq);
-    }
+
+    qemu_set_irq(s->irq, cond);
 }
 
 static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
-- 
2.47.3


