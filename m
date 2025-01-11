Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7692BE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMc-0007E6-3p; Sat, 11 Jan 2025 13:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMZ-00078E-Ib; Sat, 11 Jan 2025 13:37:35 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMX-0003w5-Sz; Sat, 11 Jan 2025 13:37:35 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso502398966b.3; 
 Sat, 11 Jan 2025 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620651; x=1737225451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0GVvSvysjxJEz2UaynSqQCCG8fvIEfWJUlnUTYHgNk=;
 b=ZG/IPvgmeVf9GnCGekV+Ope75sUrtHn2CpaHkfVrSNStTZokbizrnKsyJO+G9xgNbG
 KqRB6qTZisvdbFTe3bIxSn88QAI91WuvYBD8gwb9OeHuC4zjWYaYdaJ/ejmxMpflC6Eb
 mzPJV7BAZ+iZwidGZ0sFebjHdRqS27tsmUqsN2/xmzO4qCqH40vRBa4JMRZYm+CWqyQT
 2dnJIpnuit7QZbeAdgoP1D42FRsJ+rNaYmixZ2hp4V9w6xklA/WqP16wDdmftNsUUL7g
 Zqz8w63iPUTkIk9X7lBJ0+6J+SADHu5vBVS2TdAO2Ls4RVUoMNoSjT7/NQcb0ahr2VBX
 Fp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620651; x=1737225451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0GVvSvysjxJEz2UaynSqQCCG8fvIEfWJUlnUTYHgNk=;
 b=ShcCuHUcLODRMebSzrvfCX+y6Pqx1sxnaV2Wpb2E4qcgzG1bLpYxCYTmI5Ldy0+Ayo
 iPftsrzGuBMjs2ATy5BBopxIWpCSrnWVHGBWC0Pw99Zi1NSZysKrvW96ZKCqI1eUVM6v
 BjhDW8P6loPvLsFkWZ9eBWG1MdVXYGSPNrwL14m9XSK7zLKfT/VFM945bIQxf8EtgogP
 rqcrE2x+C3Awu+WN020SemtNpHv/9MzdsTDEx8Ti14ZbRiKcxuWfyNOnTTaQRoi9q/Xb
 XMZ3aqVvNM8oLmmoI6H/oJcTQ38wZdSzOJtE2afHkP3yYHLGky8YNQiuYVU1WsBOEOrf
 xdPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxWb95oGJm1Pie3nGpIuWHDo8QmiR1BBH10iFQDg0jroTMp1ySWhwPtmyGGOom5lWAb7n4B/rv3Q==@nongnu.org,
 AJvYcCXyb+oCYdbtXR3l5FIQJOJ+85sDt/8xheLVC645aU6t0OoAjVGX1mVpVG5tdJirKc74Cm4quGXKlw6W6w==@nongnu.org
X-Gm-Message-State: AOJu0Yzk+QCB7+lu+wYGjtv5AcdcRKgqTVGoCsvsIm0sbMeOGpfyLzNw
 P9+/GFnu1GQZKlZQN4zeT1V+4bL9b5B4WYVEa1v2myJCq4zwIg9o/7P30Q==
X-Gm-Gg: ASbGncsqkyGMW+Yysne2xchXyVj0xOCPExLpFCdKH1+Zz3H4jrISihh7dU4cCXzf+Sa
 idtsyPheeQjd3K20eYbrrFFMWCRONvSPO6OTw00jki2MdamenxxtQ7NmcsOotDGka3a6E4iu/Gx
 0tgl2dutEUPn6NmYd3I0dszUot2J+xq67h3C72NXVYSHSpl/5V7FDMI/X9m7u24sgMii2RXKVO8
 1Xqa4lrB6FP6FgQn0rgjwnVp1ospvJrgXdQYEdmfBXB3F20/wJYFl+N/uHLQ3o7bb4z4E8+qSf/
 AIx5XEUR84akrHiEXqrRkil0Ip63Mw2BXUbS3FBX7Hc=
X-Google-Smtp-Source: AGHT+IF160m7OYBbGTdXlf15ijGg9ZC3ovcJvKxBMkO3tlzK2arN+zdPOzuJljboJ3qBL4Ks++FtcA==
X-Received: by 2002:a17:907:6d01:b0:aab:d8de:64ed with SMTP id
 a640c23a62f3a-ab2ab6fcf85mr1487594966b.25.1736620650618; 
 Sat, 11 Jan 2025 10:37:30 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:29 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 08/13] hw/char/imx_serial: Turn some DPRINTF() statements
 into trace events
Date: Sat, 11 Jan 2025 19:37:06 +0100
Message-ID: <20250111183711.2338-9-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/imx_serial.c | 58 +++++++++++++++++++++++++++++---------------
 hw/char/trace-events |  5 ++++
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index be06f39a4d..38b4865157 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -27,6 +27,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/fifo32.h"
+#include "trace.h"
 
 #ifndef DEBUG_IMX_UART
 #define DEBUG_IMX_UART 0
@@ -185,10 +186,10 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
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
@@ -209,49 +210,67 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
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
@@ -261,8 +280,7 @@ static void imx_serial_write(void *opaque, hwaddr offset,
     Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     unsigned char ch;
 
-    DPRINTF("write(offset=0x%" HWADDR_PRIx ", value = 0x%x) to %s\n",
-            offset, (unsigned int)value, chr ? chr->label : "NODEV");
+    trace_imx_serial_write(chr ? chr->label : "NODEV", offset, value);
 
     switch (offset >> 2) {
     case 0x10: /* UTXD */
@@ -374,9 +392,11 @@ static int imx_can_receive(void *opaque)
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
index 59e1f734a7..92e002da7a 100644
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
2.48.0


