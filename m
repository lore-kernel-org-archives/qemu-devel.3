Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8149C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUq-000320-LJ; Tue, 04 Mar 2025 20:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUh-0002g6-0s
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:19 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUf-0007Dl-AU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso5299899f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137855; x=1741742655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qqjRyLJXA943FvFgC6O1oaicZbTpbgR9SXUAwOPgKM=;
 b=yGSEADqTL008eLG6S5OtMwHWaNS5Jv0QsxJRCztptOZ9CfbSq59aUfqUQ5F5YuTShK
 N7t51v7Wytk2EYKh0+zvrXlXmYEmLYqXX77RmFWhEf1IkajMs2Mg3GANpQ+TZITkBV3k
 XIeHQQyidSRZI1mIhsCkmQ6yNHUD8HyH9R6LB9FnlSBZglottM+KpMrVmLAz3TPpxUQt
 D5+/UIrFLCd6f+re/KH23EtIafbihiZD9NdEh0E8wvXLESTzpAdegFEUEayLVO27Fl/s
 C/SVY16QsFHoekcRxC2nDL8aHCCLQTB7UpnjUFwNLUEm27Bcuqf9epUa2CbEMQT4+teD
 wFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137855; x=1741742655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qqjRyLJXA943FvFgC6O1oaicZbTpbgR9SXUAwOPgKM=;
 b=Y5hzl5x6dWAP3taqyx+7p0Xc+vbPWMpmAQGEpBS3MumJ/OJGwQmz9Tu7jSBRXI5Lh4
 ky2Mc3PDdhfKW848R87Cb7Xz6UiEd6SGpa+nWQzo5erXHBjeywAGPjTDGKbNJFPm5JVG
 YWDRLBPDj+epFxIQgi8Be2B/YMzO/PXVLO3BHquVc8phyRHpHftmmNdTx6/K7W8nmmJc
 2NEDpLj6J25uDkPWo/GypHnlyJfc195iKrUGzglwQ6AagXpbyVKUV6DvXA4eSt8PgAs6
 lgm3v+a6PBxbWCEGOiG1M51qhifiYnqYSuOMhz++Kfw8PrbpJbHhveOEyfs7zlq8sAbg
 3xWw==
X-Gm-Message-State: AOJu0YzOKYBSZosDc5XaF//u8t8DjLuNvd3Wmqtgl15mulmeb1bafXo5
 5bhyiVcPzwAakeEOraSTI14wwQVs4vRESAqpuvGuowD8rabNb5FreZHtnqm0MBQg4AqZL8ZBm44
 JbUE=
X-Gm-Gg: ASbGnctzstu2B9x5NLiBFcxSkRIBx8jrkdDhGV8la37rg3Iz0OJJ61DPUFXHYZpXHm5
 tkj+OMykj4+X/l0VZ2xv4BPbfZer2RPbf90EIA0AUjNkoPBC79hWuwgykvttLQTnWxsjtZvNRc1
 4QIBfaxpXpy4sWujDMZOo0fuHS8gr3iCaDXaNTeGiD+/DC/ArHjFroi8zn4p71Bell54nkgeS0b
 h56O+eEcT5IwSqt9wxPQvew2flACPecMY1UFKAILsqDAvB+3gbw0w/bFcmxknvQMsuMHH78dLN2
 z8UWjmSEADD5URVKNKYBMIdrVfvOTVPUL1wnikxr2/idXkaPbEsNw39SYhSk/acANyAQnSqNrjt
 Ntpl07BgYczq9fWp9rjY=
X-Google-Smtp-Source: AGHT+IHEnSfe15n9kkeZo+PEMl+EdPMJ2MLBnSq4QrPDPYtKySnpCUirv2IunIYIF/e35wMoHAHsZg==
X-Received: by 2002:a05:6000:2b06:b0:391:4f9:a047 with SMTP id
 ffacd0b85a97d-3911f741393mr383577f8f.17.1741137855549; 
 Tue, 04 Mar 2025 17:24:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47965ddsm19712111f8f.18.2025.03.04.17.24.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PULL 28/41] hw/char/sifive_uart: Free fifo on unrealize
Date: Wed,  5 Mar 2025 02:21:43 +0100
Message-ID: <20250305012157.96463-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alistair Francis <alistair23@gmail.com>

We previously allocate the fifo on reset and never free it, which means
we are leaking memory.

Instead let's allocate on realize and free on unrealize.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Tested-by: Clément Chigot <chigot@adacore.com>
Message-ID: <20250303023120.157221-1-alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/sifive_uart.c | 44 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 4bc5767284b..b45e6c098c4 100644
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
+    SiFiveUARTState *s = SIFIVE_UART(dev);
 
-    s->txfifo = 0;
-    s->ie = 0;
-    s->ip = 0;
-    s->txctrl = 0;
-    s->rxctrl = 0;
-    s->div = 0;
-
-    s->rx_fifo_len = 0;
-
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
2.47.1


