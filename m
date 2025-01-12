Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23527E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Jt-0003pA-58; Sun, 12 Jan 2025 17:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JW-0002yH-NT
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JU-0006dF-Od
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:10 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso36069265e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720407; x=1737325207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14berGsIUi+LxFrCmkN7HjTFiZfCOUVRI5Z+rVUDf/Q=;
 b=UtAB7HYygHXqaDaZRTSE9ruCpDss3YYY8MlTTLsqXvZHTSZOzmVN16ZUpPuibQPSWy
 4UKNEb6S6BG+vgNelVN5JUeXJSC1nhfX1r7K/vbfaZjnnRcWeUTIKLVDeHhgbWjBregE
 ZkV8eKFnKSpGmh9o7etYPr3hHMJEdVqisNbeACIKhDScDoBYzEvQHR0wY9oPfth4/Ptj
 JuSs1x0gRrXcfyioO2MiAIZpfL6p6uwg1PHxVIWUEdPdX0iiJib4AHZAQL7sPVGRfcym
 dPEhGYOyJRVjfatMQ8cHFrnA9Fsg1Lb/FimRD5d6pqhVbVtrNo0cBO4obgpgNSPRUEa0
 TaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720407; x=1737325207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14berGsIUi+LxFrCmkN7HjTFiZfCOUVRI5Z+rVUDf/Q=;
 b=ujCgojSxgihiZn+74iyiF/hJp3/vefqcedFkJNht5H7np0vmKD41pUfTzDrdl+obNI
 VkySwHGe3kyfWOHdbdSvPUX1J2z2gkiuiNURIfmipO7BE7o7ClxK9Vq4U7ceOEKcdk09
 LfZPszln+HeUNMbpV3DjYaBfqUgFdyn2nCHF9hxlETUrCIh4dt/PU/2KvRrDbpmJQRha
 oCu3yXx0zcXW4NueqahlzjTNBJ6EqDNeP7wpOwMbbosGw11wOldQd6OKZRoNsFUu0d39
 rc9m+/Z15y7k/fa2EkEnJNVpHl8OailGWEBe7ltwGmZbpVpZkKNvFkct76n3+sYloEs3
 AyyQ==
X-Gm-Message-State: AOJu0YztNlREmqOVz2j+8W1V6TN5UZ/k6QCiey/oipNrvx/Y71OYAX9P
 v/YxYWQ4bhi+yKrL0LNVokuDzxF9LkG9IxcBw9E0UHknUqrlSt/HXOPoRdRruCu/RNya6bHm748
 seig=
X-Gm-Gg: ASbGncu/+QaTvvNtY7EzMw3LG75/RhbnSO6wo0opvsoh2pwem1H+ADyFQ4wcdT6G7Vl
 1Ve6ZwsyHQhh9BMWPCo/hYzAUeFyOYn++4mygIRr2RLYJiGzJ68i/RLt30r9/Z24uY08x7px3QT
 nh8hF5q+OxKjLRo7Y99lJRyoTkCaS0XEP0QkeL8qzZ6MndsXUQyZJnCo3uYdMSOu8KkjubNnPM5
 6M58KQvh+Ofs9wx8MX0wMDoNuI/wulp3YhgDoGrvEn1ltBysRFaOD/GYjixbAoV8Z1Y0e1H9D/h
 ia8YPNbL00Tcb0aj4b+yR6M6e/UX2GQ=
X-Google-Smtp-Source: AGHT+IEZB7Hcz7AkaHyBJSKfIiVHiyzucb8GX3DIfS1lWa36cpa8QOdvVYL+l4MqI4PULhSPjh9DDg==
X-Received: by 2002:a05:600c:3103:b0:434:a746:9c82 with SMTP id
 5b1f17b1804b1-436e26ae9b1mr182304575e9.5.1736720406807; 
 Sun, 12 Jan 2025 14:20:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f49sm121928255e9.19.2025.01.12.14.20.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/49] hw/char/imx_serial: Turn some DPRINTF() statements into
 trace events
Date: Sun, 12 Jan 2025 23:17:08 +0100
Message-ID: <20250112221726.30206-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250111183711.2338-9-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/imx_serial.c | 58 +++++++++++++++++++++++++++++---------------
 hw/char/trace-events |  5 ++++
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 12705a1337f..7c353fde509 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/fifo32.h"
+#include "trace.h"
 
 #ifndef DEBUG_IMX_UART
 #define DEBUG_IMX_UART 0
@@ -184,10 +185,10 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
                                 unsigned size)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
+    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     uint32_t c, rx_used;
     uint8_t rxtl = s->ufcr & TL_MASK;
-
-    DPRINTF("read(offset=0x%" HWADDR_PRIx ")\n", offset);
+    uint64_t value;
 
     switch (offset >> 2) {
     case 0x0: /* URXD */
@@ -208,49 +209,67 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
             imx_serial_rx_fifo_ageing_timer_restart(s);
             qemu_chr_fe_accept_input(&s->chr);
         }
-        return c;
+        value = c;
+        break;
 
     case 0x20: /* UCR1 */
-        return s->ucr1;
+        value = s->ucr1;
+        break;
 
     case 0x21: /* UCR2 */
-        return s->ucr2;
+        value = s->ucr2;
+        break;
 
     case 0x25: /* USR1 */
-        return s->usr1;
+        value = s->usr1;
+        break;
 
     case 0x26: /* USR2 */
-        return s->usr2;
+        value = s->usr2;
+        break;
 
     case 0x2A: /* BRM Modulator */
-        return s->ubmr;
+        value = s->ubmr;
+        break;
 
     case 0x2B: /* Baud Rate Count */
-        return s->ubrc;
+        value = s->ubrc;
+        break;
 
     case 0x2d: /* Test register */
-        return s->uts1;
+        value = s->uts1;
+        break;
 
     case 0x24: /* UFCR */
-        return s->ufcr;
+        value = s->ufcr;
+        break;
 
     case 0x2c:
-        return s->onems;
+        value = s->onems;
+        break;
 
     case 0x22: /* UCR3 */
-        return s->ucr3;
+        value = s->ucr3;
+        break;
 
     case 0x23: /* UCR4 */
-        return s->ucr4;
+        value = s->ucr4;
+        break;
 
     case 0x29: /* BRM Incremental */
-        return 0x0; /* TODO */
+        value = 0x0; /* TODO */
+        break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0x%"
                       HWADDR_PRIx "\n", TYPE_IMX_SERIAL, __func__, offset);
-        return 0;
+        value = 0;
+        break;
     }
+
+    trace_imx_serial_read(chr ? chr->label : "NODEV", offset, value);
+
+    return value;
 }
 
 static void imx_serial_write(void *opaque, hwaddr offset,
@@ -260,8 +279,7 @@ static void imx_serial_write(void *opaque, hwaddr offset,
     Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     unsigned char ch;
 
-    DPRINTF("write(offset=0x%" HWADDR_PRIx ", value = 0x%x) to %s\n",
-            offset, (unsigned int)value, chr ? chr->label : "NODEV");
+    trace_imx_serial_write(chr ? chr->label : "NODEV", offset, value);
 
     switch (offset >> 2) {
     case 0x10: /* UTXD */
@@ -373,9 +391,11 @@ static int imx_can_receive(void *opaque)
 static void imx_put_data(void *opaque, uint32_t value)
 {
     IMXSerialState *s = (IMXSerialState *)opaque;
+    Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     uint8_t rxtl = s->ufcr & TL_MASK;
 
-    DPRINTF("received char\n");
+    trace_imx_serial_put_data(chr ? chr->label : "NODEV", value);
+
     imx_serial_rx_fifo_push(s, value);
     if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
         s->usr1 |= USR1_RRDY;
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 140b994fd4d..3ee7cfcdff2 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -52,6 +52,11 @@ escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
 escc_kbd_command(int val) "Command %d"
 escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
 
+# imx_serial.c
+imx_serial_read(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] -> 0x%08" PRIx64
+imx_serial_write(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] <- 0x%08" PRIx64
+imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
+
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-- 
2.47.1


