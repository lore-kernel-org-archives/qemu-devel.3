Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498E9CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WSs-00070k-7b; Thu, 02 Oct 2025 23:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSq-0006za-7J
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WSk-0001C5-De
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:28:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781010ff051so1353158b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462078; x=1760066878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93uzLakLUkrq45soCsmN9r7xZFQg+5pzlt4I7pgvPUY=;
 b=VsAPqjjC6mXvGpH5p9tnbgbcWy/+1/WBhjKjLbtTBXL9Se5VKjbtDvvbprZFCNPNUe
 ai+hfyGmnpIN2sew0YM3EykQ71kDnpz4q9xfccLc2BU/8/12AdpXIWzs1LWSoI1ldufP
 Ae4rfVp2zok2a3C+W9MRHPJ4nxne9uYsvJCxdlyk14PYZZL0G5z/CwqMTHw4j65TuVb8
 aYR8wvIz6MX2CfNRt5QSToP5Ma8p9POgOx0WoAuHtjyOkBQkPFnIo+mOOWjaIfwOISbd
 JNKLtqtqo2VNCMnCTRmj0GuO/Z6ZTk43o1SkJOua3pra0qNi1SU40Re0TDZXo9CmogEM
 i2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462078; x=1760066878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93uzLakLUkrq45soCsmN9r7xZFQg+5pzlt4I7pgvPUY=;
 b=W1qoYuccxdCUm+OWScuil2nSZaOJlCdojxefM2PbPgicDpxN/DILipcdrjT7lPv2Bo
 x8LBDP/6QxDWyb1QnSvWERKMRSR4DV/R0AEuUESH6xlkscl/VRBpHAKrdwXX3vuT4y2d
 55syiMmEQ2dy3vx8HZHapgxccnLmLfL1s/k5thYh593X/BN3aGBHmlOqKezUMyzYIrMN
 v6hccxu77u3EGw0/KgRf+skrCHoK+sbTWil1IziV3fBp9brpdWPqPkAqv6fJucQeJsez
 Hj/Fiw8JdR4mNsF7onxjwG9dokDvelFlUXf6w4lm5PrNTONJp/Bytc5XUOAdugFD9yKs
 26Ew==
X-Gm-Message-State: AOJu0YxdryPRkv2zNk5OuYOEh47CFeYEvdjYi4s8jBYBATlZ/J3V/kDL
 oaCCLFAhUMhWiMGSeOd8Iy9B9iIpGbUUNQoueRcTjX7Ju7UL8MWV5r/L+IQbHw==
X-Gm-Gg: ASbGncuW7rsJn2+X5o4ED78d8yf8+ct5deZfDZIUXAFpf8NyBaOzcmshzFGZ0i67MRz
 TJn4VpheGi9n39HBuF9gl6xNNjJy/vzR7rUJKxbck9lzw2LMVK0fyds22hp0sLU4YV3zLwexMeG
 wliF5MBV0Rqnb/8XmDJrXC4k91hTME78U+qn8hJItfCYxL4S1d2FXb50TSYBlWbgclvBTOfbSVd
 WTXE9xHeyYhInMFKZH3kw27DDtYWcJMlRq+z2yll+J4zAi1jtqLdr89MXgYS45mCdD3w4CNAfyd
 NU9l2Ae0sFWx4yhmISNJ/t6QWp0UHCs39qWhwBmBeKxBmewIHwsN6ZCNyV3/xnvqBPrqwp2gqNR
 dMLk9RW0CZFxfmYN7L2A4Cgt7K6Sl9bXySmIJVuVdxJD/GolP7D6Fpu+QBf/BPsbjVg9HiHrizg
 40tU3MIzyQbqbTWby4ptqZ8hsMH2rULAAwCQpKFkxtjIHsyB5VQ9UF
X-Google-Smtp-Source: AGHT+IE1794/i8P9Nl5/JnEZoTmT483+ZE//dyCfsw9DLXKkX4x3GXKOlWcWhzTBHVnreVWsOIPFyw==
X-Received: by 2002:a05:6a20:bfc7:b0:32b:727f:5fbb with SMTP id
 adf61e73a8af0-32b727f60b9mr271982637.20.1759462077912; 
 Thu, 02 Oct 2025 20:27:57 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:27:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Frank Chang <frank.chang@sifive.com>,
 Emmanuel Blot <emmanuel.blot@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/26] hw/char: sifive_uart: Raise IRQ according to the Tx/Rx
 watermark thresholds
Date: Fri,  3 Oct 2025 13:26:58 +1000
Message-ID: <20251003032718.1324734-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/char/sifive_uart.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 9bc697a67b..138c31fcab 100644
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
2.51.0


