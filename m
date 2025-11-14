Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B265CCDE03C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 08:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJpPT-0001Hj-4X; Fri, 14 Nov 2025 03:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpPO-0001E9-CU
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:43:55 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpPM-0007om-KQ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:43:54 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so1124192b3a.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 00:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763109830; x=1763714630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lF2fu4z2XG02l76l/IsUrBTfEhGWyD0UfOXyu3FKewU=;
 b=bQiMPY8K6nwdJfvQyVTlW1VXE0yp9ryBiiaUI0BrvpY61noLrykzQaMq2j4nHqQ7BZ
 hzTgWBjey4oE+y9G9PL9mAfP/Pa9aCastva45tu/miYi1mpgsCfj+6EbPwSF1SG9u6dq
 xY2Y9KrbOJxlIHAqUex07yU3s7iAFQPaNp/sa4lrQpQmO5n4zCsNBZ1tEoBwuvN7PRLh
 //Yk35zX7RtSP5C39J+Fbp1S0r5yw0qkMCy9Tq7tdKN2dQTOLHlvbd+EDl7Td+ptjUND
 irHh8SdG5QGU1+PTaovvLGQ5jnnczQoTwjQXpS/inR5gJKTj5+0ijGwSMefXc/STZKgH
 MB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763109830; x=1763714630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lF2fu4z2XG02l76l/IsUrBTfEhGWyD0UfOXyu3FKewU=;
 b=OuNFB7iNWg6fYw2TLG47FdIhMf3UBXQhhDf1feKzb1nN21U9ve3rLGwhkvAiE/jdOf
 4m18sBv98/QGbDjEWWTLNgPsAjmHY+a7s+9cyc98UPXjwZkwqeBGqE6C+XQd2yiyrwi1
 Sn2OR7vs/OpJHwm8R+jYPplKLbO9fG5ScCmWXqBBcxuGQnHgrbVc6hD6DDbcfRg6BzBc
 GTmKgiOUI76iADs2sIz0/hlQUg4PezL45jkfrITFuyRZU053mQ5mSVlU/19T2u19yF0W
 tmjb+OqlL4msuuM9lXREY71egipIDXynxSK9H4ZjKBCHGU2/3qF6q+Avcu/Pvq21WwgN
 RShA==
X-Gm-Message-State: AOJu0YxmdjFmlnzb69wAvN+r6YJagEpxHJqQLYpLKs0hY3n42Xg0NERt
 YPVPmlmTAoftLei0AMsZU3/W8DUlWQ3qfpE3qRSsF4mtjZVKmYxPs35j5nLbYUZPigy/JFTQBwM
 ocDc3ixUUqf82RP+K88Qe0h/+KlzMl+JCtClyPFzCn5u4YoCMU5Hj+nMIXNjI2yuUQrASuVA0hc
 NGzqf64K9/WNyK9r3KgEhHiOxNlOAk49DZUlbssyBOAnQ=
X-Gm-Gg: ASbGncut2PVO12w3Q7t/QMPRzCkCM3Ehq2nH+o+HToPo8PYp6XxUH11AJCmkf+of5ok
 WmnjtfV0sGNJEFGYLU4e/+BD/sFFucHw2UvZ9Dqct220IukgaWVgpdnN1DAC0cKA1TSgOwuZBhg
 L3aVXlfSte1u7Xlt/QR3AXRfINCAD9YvSsekm0w2pGCExlEST2d+UM6CuYotNvXePNXxpF50zq2
 dipqHXf2QmRquLIlUp8xprvqzNDNVu6bkP/jnXOwzGdSFdYbeMGI2iWnM3df97+EGl3IeG3Zzan
 Nex5YLoyy6LRSUOFi6Q4B5+cW7N3Mmqa1EwP+0Kv3UBLIy75p+y+/zYRY8FHWTLtmb3Mf5coESr
 FP8x8I3aLSvmn044F5iOJXR4bB6RFG08BlR6tGGXLTpXxqpOiV9atllUda207XokgvjKw3VnFxh
 zwUoTQZGLTwGBEi3RmagC3DBvRFcUdZCZIfpc8NA==
X-Google-Smtp-Source: AGHT+IEXfGmvQiv0Bx97VzNlUmzGDSMLI0mIPlKC5fnDI06Z7P8Qm2KeytEYu//sZDx2JzVRM7J9ZQ==
X-Received: by 2002:a05:7022:689e:b0:119:e56b:98be with SMTP id
 a92af1059eb24-11b41505914mr789172c88.37.1763109829659; 
 Fri, 14 Nov 2025 00:43:49 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885e3sm7994657c88.0.2025.11.14.00.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 00:43:49 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] hw/char: sifive_uart: Implement txctrl.txen and rxctrl.rxen
Date: Fri, 14 Nov 2025 16:43:43 +0800
Message-ID: <20251114084343.1094486-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/char/sifive_uart.c         | 27 ++++++++++++++++++++-------
 include/hw/char/sifive_uart.h |  2 ++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index e7357d585a1..4a54dd52a1e 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -78,6 +78,11 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
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
@@ -106,11 +111,19 @@ static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
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
         qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow.\n");
@@ -124,10 +137,7 @@ static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
         s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
     }
 
-    if (!timer_pending(s->fifo_trigger_handle)) {
-        timer_mod(s->fifo_trigger_handle, current_time +
-                      TX_INTERRUPT_TRIGGER_DELAY_NS);
-    }
+    sifive_uart_trigger_tx_fifo(s);
 }
 
 static uint64_t
@@ -184,6 +194,9 @@ sifive_uart_write(void *opaque, hwaddr addr,
         return;
     case SIFIVE_UART_TXCTRL:
         s->txctrl = val64;
+        if (SIFIVE_UART_TXEN(s->txctrl) && !fifo8_is_empty(&s->tx_fifo)) {
+            sifive_uart_trigger_tx_fifo(s);
+        }
         return;
     case SIFIVE_UART_RXCTRL:
         s->rxctrl = val64;
@@ -231,7 +244,7 @@ static int sifive_uart_can_rx(void *opaque)
 {
     SiFiveUARTState *s = opaque;
 
-    return s->rx_fifo_len < sizeof(s->rx_fifo);
+    return SIFIVE_UART_RXEN(s->rxctrl) && (s->rx_fifo_len < sizeof(s->rx_fifo));
 }
 
 static void sifive_uart_event(void *opaque, QEMUChrEvent event)
diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 6486c3f4a5d..e216cacf693 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -51,6 +51,8 @@ enum {
 
 #define SIFIVE_UART_TXFIFO_FULL    0x80000000
 
+#define SIFIVE_UART_TXEN(txctrl)        (txctrl & 0x1)
+#define SIFIVE_UART_RXEN(rxctrl)        (rxctrl & 0x1)
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
 
-- 
2.43.0


