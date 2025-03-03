Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91283C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toval-0004uF-Sq; Sun, 02 Mar 2025 21:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tovaf-0004tN-IZ; Sun, 02 Mar 2025 21:31:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tovac-0006MK-Sb; Sun, 02 Mar 2025 21:31:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223594b3c6dso63748155ad.2; 
 Sun, 02 Mar 2025 18:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740969089; x=1741573889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NtQA4vUtzQxFaZWzTgzuMaNqAouvy4FZdmMng798yX8=;
 b=CAHlKtZhN060D2LXzpcXNddZbNbwCwqDhOZ3r947WM3wPsK2UddUYTqWw2C6dFN/dN
 ++LC6eO9PWdwpv2rcJ6qJaKrY/9JEWzn9cQsit7mvjv3s40vD/nagf+69PyNa+hqhGkS
 n3f0rHi/b21ISv4qWbwUir4w2yVYE6e1lvgUd8rXujhVZV4ZZv4JkM4Wz3OeIK0BkV0t
 Op/KybbOl45kTpLcG2gHgKc5DTsddS2Tm8PimzXCYiyrEE2D9uf61Z9YgCVKZQ/JXEpq
 mh/Hdms3v7zRH6elb8HmJYRD8Hwq35/plt+7KRFx1qGM/kMR5x4cF4bgsiaIwJNunnmq
 rw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740969089; x=1741573889;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NtQA4vUtzQxFaZWzTgzuMaNqAouvy4FZdmMng798yX8=;
 b=uS7SPCkV8d0jLq0PFUlXsNp/gkhJRS1ky7i/KPhWTDOeE5q5S22P88ASsuPYYlAYG/
 TcMKjoallWqsBFyxD6nENW8tVR7ttyepWTW290X5X4asgpaU2mJL0frY2JQnscNcBLoS
 X2q67N+wWEedp1KTPIS5gUAChAvsla3e38V3Na2sqSuSv2TUfQhnKKvxOEHhVyDl27b7
 03EUtR4K8pJwiwvL0l+kg6aUkGqGDtCcilakYkiz7af6RoEdHz8AuAsDAW/BZeqUTOsD
 yBJkIP3Pw+TRix7dsO9VYLj03vmiVGp3KbaE0MBs2/H4VJ28pMZC3KurpXE3Vt1dvJvc
 bfmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAlwg0OkepkzPFwmgSNvDFkvD2wapukY7VPEyE/YSQp6dFw3sLU6nkXiAPqKj3AKp4eiSJXVVQefh1@nongnu.org
X-Gm-Message-State: AOJu0YzbW3Th0BaYhOdc3Fcw1cFrbdaz9tqJdJjq5SYrxaUfiENmLOdi
 a2ksxiywmGbJ+RSGaj5CKKy9gvkR6HnqeL2aelKJU6vcN9GsKlHz
X-Gm-Gg: ASbGncshzmYpM8x9ys0Ssbs3sIulVEIpwx7bbPaCIRNXffRtS5lvjh3SpYyfyQ7SH+7
 GBPsZFbTcmwBapfddU9msQX/p3iDWUoEOwLwgPUiRu8x9bl2xQufJRBFMg7XKeTvBHu3otabtsk
 MbwgQ+S2kNI6RYTxvdgT8aWed4Sm/+68gSGrKjopYBUEXtzEPS3D4afP4htbP95mh1K/a7y416O
 0iYH5DzvohlyNqTIeo0ETFlNxkRm5lvC5ZEmAHcV+v0WPjH2C5lO6yo7Hgor3JomwFwASLfIBhi
 Isy5UrgD0WWi20GGbylQr584p8yd97JMajUBLmlZiYbTebOR1imEqpsrZD3r2GBmPMPgSKmS46e
 ijUAdU+Tx0WDAfYY/V0xeDBXbaSrlT2Bp+rcWSzXMJ5TP0YXuSa4=
X-Google-Smtp-Source: AGHT+IEoDVTyjJlK/+pdgfsyAFag8T/IN4Htoef+Ixir7iZD4ohxjTLbb1ASfXRuNqj6XyvKOv4oEA==
X-Received: by 2002:a17:902:e803:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22368fbafa9mr181243725ad.22.1740969088806; 
 Sun, 02 Mar 2025 18:31:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2adcasm7899191b3a.17.2025.03.02.18.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Mar 2025 18:31:28 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, philmd@linaro.org,
 chigot@adacore.com
Cc: qemu-devel@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] hw/char: sifive_uart: Free fifo on unrealize
Date: Mon,  3 Mar 2025 12:31:20 +1000
Message-ID: <20250303023120.157221-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

We previously allocate the fifo on reset and never free it, which means
we are leaking memory.

Instead let's allocate on realize and free on unrealize.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/char/sifive_uart.c | 44 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 4bc5767284..b45e6c098c 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -251,6 +251,23 @@ static int sifive_uart_be_change(void *opaque)
     return 0;
 }
 
+static void sifive_uart_reset_enter(Object *obj, ResetType type)
+{
+    SiFiveUARTState *s = SIFIVE_UART(obj);
+
+    s->txfifo = 0;
+    s->ie = 0;
+    s->ip = 0;
+    s->txctrl = 0;
+    s->rxctrl = 0;
+    s->div = 0;
+
+    s->rx_fifo_len = 0;
+
+    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
+    fifo8_reset(&s->tx_fifo);
+}
+
 static const Property sifive_uart_properties[] = {
     DEFINE_PROP_CHR("chardev", SiFiveUARTState, chr),
 };
@@ -270,30 +287,24 @@ static void sifive_uart_realize(DeviceState *dev, Error **errp)
 {
     SiFiveUARTState *s = SIFIVE_UART(dev);
 
+    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
+
     s->fifo_trigger_handle = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                           fifo_trigger_update, s);
 
-    qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
-                             sifive_uart_event, sifive_uart_be_change, s,
-                             NULL, true);
+    if (qemu_chr_fe_backend_connected(&s->chr)) {
+        qemu_chr_fe_set_handlers(&s->chr, sifive_uart_can_rx, sifive_uart_rx,
+                                 sifive_uart_event, sifive_uart_be_change, s,
+                                 NULL, true);
+    }
 
 }
 
-static void sifive_uart_reset_enter(Object *obj, ResetType type)
+static void sifive_uart_unrealize(DeviceState *dev)
 {
-    SiFiveUARTState *s = SIFIVE_UART(obj);
-
-    s->txfifo = 0;
-    s->ie = 0;
-    s->ip = 0;
-    s->txctrl = 0;
-    s->rxctrl = 0;
-    s->div = 0;
-
-    s->rx_fifo_len = 0;
+    SiFiveUARTState *s = SIFIVE_UART(dev);
 
-    memset(s->rx_fifo, 0, SIFIVE_UART_RX_FIFO_SIZE);
-    fifo8_create(&s->tx_fifo, SIFIVE_UART_TX_FIFO_SIZE);
+    fifo8_destroy(&s->tx_fifo);
 }
 
 static void sifive_uart_reset_hold(Object *obj, ResetType type)
@@ -329,6 +340,7 @@ static void sifive_uart_class_init(ObjectClass *oc, void *data)
     ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     dc->realize = sifive_uart_realize;
+    dc->unrealize = sifive_uart_unrealize;
     dc->vmsd = &vmstate_sifive_uart;
     rc->phases.enter = sifive_uart_reset_enter;
     rc->phases.hold  = sifive_uart_reset_hold;
-- 
2.48.1


