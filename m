Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B988CD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTuQ-0006yr-Sk; Sun, 08 Sep 2024 22:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuQ-0006xz-3I; Sun, 08 Sep 2024 22:13:42 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuO-0001NH-3b; Sun, 08 Sep 2024 22:13:41 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso3045559a12.2; 
 Sun, 08 Sep 2024 19:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725848018; x=1726452818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7d2pKU/b/laqA6UDAi2cfTpZBwJfK0bU7UCihSBw02Q=;
 b=fs4yqPzecAbJ9oqowkM6UYmXPdXjgigvPgIQURLZXIBkvqgQwB/B/ImsWf3xjJo4nF
 Ac9Zu/OKGsgAmclJO1IfI1iUOqnjLeMGA2IP9Fr5q+FTfrN7Hxf6n5RPYlePM2gvhRQ+
 0mXMiSNszh9prX1BYPtmb6qS2YjoXo1/gqelf1bmCDgEJmj0agint5oCk9yKLqE5jYG3
 /S6t8bLv45XzIqJoAtk8SqDv2sDVik6t5O8laLSMyar6acHP6al+dliPJeg1OaIBdAOX
 Am2uRAEgscj0iCsgc9hFlWTMg2tKnk6wk8xddulyL99M/8vXKEIeV86XHwbAGs5ePpcq
 HALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725848018; x=1726452818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7d2pKU/b/laqA6UDAi2cfTpZBwJfK0bU7UCihSBw02Q=;
 b=QkCUulibzFzcoXtU9zF1bKcMH+01gg74G5j9LfXCv2Oouiq53Qnz/nEhzWje4TcfME
 2u1h0mnB4MrVA3lN5Y2uYUH8rzIHBgH9h0NNVz6FQQ/VjyaKECQAAO6rK+pluVNcYbAv
 xgLyjL1k3EGwk6K1RVPqI2urex16K7n0HwwzWmyRVvuoMJWiiXoeBjCdJj2Vc8iwcMuk
 DxuSXprh3YnLW5ve/KaLL9GxIeQrgaWnaBX7KDTm81blOFRrKdYnYt7BkZpUGzSdH4ZJ
 /C+IqcuBVm9FiOr/6hDBWsiBGpQyGfS494ORrCzLU3zQVDdx9V92Ns2G1Qn+reyRSEch
 a8FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEnbACzqu779WZ+BXIYla5lIeUWk1s/ZewEDJocG4Uj2QQm7OrgpTUT8SiUPHdkBbZogh++3RxwhJK@nongnu.org,
 AJvYcCWrjTRuscT9stU/H0mdLdI01BH5LFydDed28CzV1H3DWkjfe5247wbM8WXqwWP2kVisQ/x3Gch5k01fPA==@nongnu.org
X-Gm-Message-State: AOJu0YwseRC0/oQPzZkyPDJ+G1FTbs4xjv+/1XHJl+Kfw5GsOSDHxCnv
 hiDhNJDGRNthDCJX3GiMffkK+bqNLYwnCexIrgTSJ4XiC/Q0vD/E
X-Google-Smtp-Source: AGHT+IFqqsVVw8FYwbpFCiotNvA0Kd9BFDW1qfKJAcc4IIv7Jd5s9Kuw/JjiLE1KwMgR7Rk0grCeBQ==
X-Received: by 2002:a05:6a21:58b:b0:1cf:2a85:722d with SMTP id
 adf61e73a8af0-1cf2a8573cdmr9342997637.3.1725848018223; 
 Sun, 08 Sep 2024 19:13:38 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58c68d3sm2528155b3a.84.2024.09.08.19.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 19:13:37 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, Alistair Francis <alistair.francis@wdc.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 2/2] hw/char: sifive_uart: Print uart characters async
Date: Mon,  9 Sep 2024 12:13:17 +1000
Message-ID: <20240909021317.58192-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909021317.58192-1-alistair.francis@wdc.com>
References: <20240909021317.58192-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

The current approach of using qemu_chr_fe_write() and ignoring the
return values results in dropped characters [1].

Let's update the SiFive UART to use a async sifive_uart_xmit() function
to transmit the characters and apply back pressure to the guest with
the SIFIVE_UART_TXFIFO_FULL status.

This should avoid dropped characters and more realisticly model the
hardware.

1: https://gitlab.com/qemu-project/qemu/-/issues/2114

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/char/sifive_uart.h | 17 ++++++-
 hw/char/sifive_uart.c         | 88 +++++++++++++++++++++++++++++++++--
 2 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/include/hw/char/sifive_uart.h b/include/hw/char/sifive_uart.h
index 7f6c79f8bd..b43109bb8b 100644
--- a/include/hw/char/sifive_uart.h
+++ b/include/hw/char/sifive_uart.h
@@ -24,6 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "qemu/fifo8.h"
 
 enum {
     SIFIVE_UART_TXFIFO        = 0,
@@ -48,9 +49,13 @@ enum {
     SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
 };
 
+#define SIFIVE_UART_TXFIFO_FULL    0x80000000
+
 #define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
 #define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
+
 #define SIFIVE_UART_RX_FIFO_SIZE 8
+#define SIFIVE_UART_TX_FIFO_SIZE 8
 
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
 OBJECT_DECLARE_SIMPLE_TYPE(SiFiveUARTState, SIFIVE_UART)
@@ -63,13 +68,21 @@ struct SiFiveUARTState {
     qemu_irq irq;
     MemoryRegion mmio;
     CharBackend chr;
-    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
-    uint8_t rx_fifo_len;
+
+    uint32_t txfifo;
     uint32_t ie;
     uint32_t ip;
     uint32_t txctrl;
     uint32_t rxctrl;
     uint32_t div;
+
+    uint8_t rx_fifo[SIFIVE_UART_RX_FIFO_SIZE];
+    uint8_t rx_fifo_len;
+
+    Fifo8 tx_fifo;
+
+    QEMUTimer *fifo_trigger_handle;
+    uint64_t char_tx_time;
 };
 
 SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 7fc6787f69..ab899b60d6 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -64,6 +64,72 @@ static void sifive_uart_update_irq(SiFiveUARTState *s)
     }
 }
 
+static gboolean sifive_uart_xmit(void *do_not_use, GIOCondition cond,
+                                 void *opaque)
+{
+    SiFiveUARTState *s = opaque;
+    int ret;
+    const uint8_t *charecters;
+    uint32_t numptr = 0;
+
+    /* instant drain the fifo when there's no back-end */
+    if (!qemu_chr_fe_backend_connected(&s->chr)) {
+        fifo8_reset(&s->tx_fifo);
+        return G_SOURCE_REMOVE;
+    }
+
+    if (fifo8_is_empty(&s->tx_fifo)) {
+        return G_SOURCE_REMOVE;
+    }
+
+    /* Don't pop the FIFO in case the write fails */
+    charecters = fifo8_peek_bufptr(&s->tx_fifo,
+                                   fifo8_num_used(&s->tx_fifo), &numptr);
+    ret = qemu_chr_fe_write(&s->chr, charecters, numptr);
+
+    if (ret >= 0) {
+        /* We wrote the data, actually pop the fifo */
+        fifo8_pop_bufptr(&s->tx_fifo, ret, NULL);
+    }
+
+    if (!fifo8_is_empty(&s->tx_fifo)) {
+        guint r = qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HUP,
+                                        sifive_uart_xmit, s);
+        if (!r) {
+            fifo8_reset(&s->tx_fifo);
+            return G_SOURCE_REMOVE;
+        }
+    }
+
+    /* Clear the TX Full bit */
+    if (!fifo8_is_full(&s->tx_fifo)) {
+        s->txfifo &= ~SIFIVE_UART_TXFIFO_FULL;
+    }
+
+    sifive_uart_update_irq(s);
+    return G_SOURCE_REMOVE;
+}
+
+static void sifive_uart_write_tx_fifo(SiFiveUARTState *s, const uint8_t *buf,
+                                      int size)
+{
+    uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if (size > fifo8_num_free(&s->tx_fifo)) {
+        size = fifo8_num_free(&s->tx_fifo);
+        qemu_log_mask(LOG_GUEST_ERROR, "sifive_uart: TX FIFO overflow");
+    }
+
+    fifo8_push_all(&s->tx_fifo, buf, size);
+
+    if (fifo8_is_full(&s->tx_fifo)) {
+        s->txfifo |= SIFIVE_UART_TXFIFO_FULL;
+    }
+
+    timer_mod(s->fifo_trigger_handle, current_time +
+              (s->char_tx_time * 4));
+}
+
 static uint64_t
 sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -82,7 +148,7 @@ sifive_uart_read(void *opaque, hwaddr addr, unsigned int size)
         return 0x80000000;
 
     case SIFIVE_UART_TXFIFO:
-        return 0; /* Should check tx fifo */
+        return s->txfifo;
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
@@ -106,12 +172,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
 {
     SiFiveUARTState *s = opaque;
     uint32_t value = val64;
-    unsigned char ch = value;
 
     switch (addr) {
     case SIFIVE_UART_TXFIFO:
-        qemu_chr_fe_write(&s->chr, &ch, 1);
-        sifive_uart_update_irq(s);
+        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
         return;
     case SIFIVE_UART_IE:
         s->ie = val64;
@@ -131,6 +195,13 @@ sifive_uart_write(void *opaque, hwaddr addr,
                   __func__, (int)addr, (int)value);
 }
 
+static void fifo_trigger_update(void *opaque)
+{
+    SiFiveUARTState *s = opaque;
+
+    sifive_uart_xmit(NULL, G_IO_OUT, s);
+}
+
 static const MemoryRegionOps sifive_uart_ops = {
     .read = sifive_uart_read,
     .write = sifive_uart_write,
@@ -197,6 +268,9 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUARTState *s = SIFIVE_UART(dev);
 
+    s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                          fifo_trigger_update, s);
+
     qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
                              sifive_uart_event, sifive_uart_be_change, s,
                              NULL, true);
@@ -206,12 +280,18 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 static void sifive_uart_reset_enter(Object *obj, ResetType type)
 {
     SiFiveUARTState *s = SIFIVE_UART(obj);
+
+    s->txfifo = 0;
     s->ie = 0;
     s->ip = 0;
     s->txctrl = 0;
     s->rxctrl = 0;
     s->div = 0;
+
     s->rx_fifo_len = 0;
+
+    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
+    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
 }
 
 static void sifive_uart_reset_hold(Object *obj, ResetType type)
-- 
2.46.0


