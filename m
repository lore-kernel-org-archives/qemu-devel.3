Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F586E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Jx-00044U-KL; Sun, 12 Jan 2025 17:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JB-0002KY-Oe
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6J9-0006aA-Rs
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so2192640f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720386; x=1737325186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypXBSvYmGiFDPRAAmIeWBvHigmsiA58P6W0SM1nQp5o=;
 b=rOPnAVPW3T1SQ/j1ySJxovZlf0ilzN3/16aiJeNB/SCgzZNN4yP2+Jxq7nC0dfea1w
 Q17y7SxzATIA4mpRuekgMxtAhTIGLp+vK9jy5nEGk3z9wMxnwoIt1vzQIbSH7mL7Mkgx
 oV+7QkLNCTrOp+fpMW+6Jdj2W5PJIxfaGcR0RVvv2uJFbJlhXdqb38pHnCdCfKFdUH6S
 5LRyouAzx7ArJsmK/1eXfsdxUMIP58HS1IrfybT0eXMI6Fau0NGQWE4uVpqFh9g+09mN
 RUpKMd1Xxmg4+Mx6fyvOQXnjdOA/bOP1YFb/Gc+xmAGUIrlWVHJig3UCBRFXpBO/fyyV
 eFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720386; x=1737325186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypXBSvYmGiFDPRAAmIeWBvHigmsiA58P6W0SM1nQp5o=;
 b=pNAS9VFy92n4xWeFZfQz5BlCjWnnTKZRZxgy+sDJbqrSQL1Ne5EKo0ermHlrtIzE71
 ISH87SPGzlifmdDH4OvauxCeSd63jNAsQM/DZE1My3kISARydcYjlDq3K/90EN+vMgO3
 Zk8jLVDSSRyTD6vVj8k92jiQtOIKWkObcqmiZHsdpAG7LDco+rumgj1EHVxHy4XQcaNN
 LSGJYy/oMXy7KoTt9ZQ7OdcAU1baDHX26gqvEPPNzfb/I/Zr2h3LrQWA5y0jW5dvNzxo
 6WDnB7obI4QjqsWONYlJKNPbUgcXG7FilKrmD2zSoFwxnTB0mr3vql3JEEVdoq5fR51a
 MCqg==
X-Gm-Message-State: AOJu0YxKD2a/Nn23pctKQZaEtrxPb0u/93ncTEeFOYv+hsS05g3ll0O8
 e4GuuapZW3hDSw5lo6Yf9IHdDXrNo0S94msBekgBE/Hz1tWo+t7iFXwYK/Mrfl5HY0ZepOS6WSn
 F3a0=
X-Gm-Gg: ASbGnct4niknzBqcJyPY3Z1GcfaqfVcDMg/+pFKEz1S40Dd9jP0+4UYe9abqP3++GTl
 EXNiVrgGo4kL4ha7VXgPTP894crqmoXrOxx2HHwug7zKH1mxVzo5nvBmvs1bTSJu/u2hUpoZohG
 n+YCaSiC/Jm8Rp4IvSXvKpsmBQ5h5V7FpVAmSC17FDLX10wwqDsfYmp96GecRCeJ35jPUvakFwG
 xjkzxMFzj02fE5i0WlakKtb8BnnpD/4wWkILQz1YM/tY0O+3NdxjQHLn2du/UPaM/j+7RUYMNcA
 8IE1yRnNL/Kl1mMhSyTQ90aK7AUOno8=
X-Google-Smtp-Source: AGHT+IFJNx2Q6MB6KdGYWgWcXq8LGB1PIP8uGQY9XRjM+IxvLdGlB0LwamHGCb/tD9s1X7EvqIgAmA==
X-Received: by 2002:a05:6000:1aca:b0:386:3bde:9849 with SMTP id
 ffacd0b85a97d-38a8b0caa82mr12288534f8f.12.1736720385950; 
 Sun, 12 Jan 2025 14:19:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2df2faesm158881605e9.26.2025.01.12.14.19.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nikita Shubin <nshubin@yadro.com>, Nikita Shubin <n.shubin@yadro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/49] hw/char/stm32f2xx_usart: replace print with trace
Date: Sun, 12 Jan 2025 23:17:04 +0100
Message-ID: <20250112221726.30206-29-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Nikita Shubin <nshubin@yadro.com>

Drop debug printing macros and replace them with according trace
functions.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241220111756.16511-1-nikita.shubin@maquefel.me>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/stm32f2xx_usart.c | 49 ++++++++++++++++++---------------------
 hw/char/trace-events      |  6 +++++
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index ebcc510f4ea..87882daa715 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -30,17 +30,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
-#ifndef STM_USART_ERR_DEBUG
-#define STM_USART_ERR_DEBUG 0
-#endif
-
-#define DB_PRINT_L(lvl, fmt, args...) do { \
-    if (STM_USART_ERR_DEBUG >= lvl) { \
-        qemu_log("%s: " fmt, __func__, ## args); \
-    } \
-} while (0)
-
-#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+#include "trace.h"
 
 static int stm32f2xx_usart_can_receive(void *opaque)
 {
@@ -67,10 +57,11 @@ static void stm32f2xx_update_irq(STM32F2XXUsartState *s)
 static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
 {
     STM32F2XXUsartState *s = opaque;
+    DeviceState *d = DEVICE(s);
 
     if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
         /* USART not enabled - drop the chars */
-        DB_PRINT("Dropping the chars\n");
+        trace_stm32f2xx_usart_drop(d->id);
         return;
     }
 
@@ -79,7 +70,7 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
 
     stm32f2xx_update_irq(s);
 
-    DB_PRINT("Receiving: %c\n", s->usart_dr);
+    trace_stm32f2xx_usart_receive(d->id, *buf);
 }
 
 static void stm32f2xx_usart_reset(DeviceState *dev)
@@ -101,49 +92,55 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
                                        unsigned int size)
 {
     STM32F2XXUsartState *s = opaque;
-    uint64_t retvalue;
-
-    DB_PRINT("Read 0x%"HWADDR_PRIx"\n", addr);
+    DeviceState *d = DEVICE(s);
+    uint64_t retvalue = 0;
 
     switch (addr) {
     case USART_SR:
         retvalue = s->usart_sr;
         qemu_chr_fe_accept_input(&s->chr);
-        return retvalue;
+        break;
     case USART_DR:
-        DB_PRINT("Value: 0x%" PRIx32 ", %c\n", s->usart_dr, (char) s->usart_dr);
         retvalue = s->usart_dr & 0x3FF;
         s->usart_sr &= ~USART_SR_RXNE;
         qemu_chr_fe_accept_input(&s->chr);
         stm32f2xx_update_irq(s);
-        return retvalue;
+        break;
     case USART_BRR:
-        return s->usart_brr;
+        retvalue = s->usart_brr;
+        break;
     case USART_CR1:
-        return s->usart_cr1;
+        retvalue = s->usart_cr1;
+        break;
     case USART_CR2:
-        return s->usart_cr2;
+        retvalue = s->usart_cr2;
+        break;
     case USART_CR3:
-        return s->usart_cr3;
+        retvalue = s->usart_cr3;
+        break;
     case USART_GTPR:
-        return s->usart_gtpr;
+        retvalue = s->usart_gtpr;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
         return 0;
     }
 
-    return 0;
+    trace_stm32f2xx_usart_read(d->id, size, addr, retvalue);
+
+    return retvalue;
 }
 
 static void stm32f2xx_usart_write(void *opaque, hwaddr addr,
                                   uint64_t val64, unsigned int size)
 {
     STM32F2XXUsartState *s = opaque;
+    DeviceState *d = DEVICE(s);
     uint32_t value = val64;
     unsigned char ch;
 
-    DB_PRINT("Write 0x%" PRIx32 ", 0x%"HWADDR_PRIx"\n", value, addr);
+    trace_stm32f2xx_usart_write(d->id, size, addr, val64);
 
     switch (addr) {
     case USART_SR:
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 59e1f734a7d..140b994fd4d 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -125,3 +125,9 @@ xen_console_unrealize(unsigned int idx) "idx %u"
 xen_console_realize(unsigned int idx, const char *chrdev) "idx %u chrdev %s"
 xen_console_device_create(unsigned int idx) "idx %u"
 xen_console_device_destroy(unsigned int idx) "idx %u"
+
+# stm32f2xx_usart.c
+stm32f2xx_usart_read(char *id, unsigned size, uint64_t ofs, uint64_t val) " %s size %d ofs 0x%02" PRIx64 " -> 0x%02" PRIx64
+stm32f2xx_usart_write(char *id, unsigned size, uint64_t ofs, uint64_t val) "%s size %d ofs 0x%02" PRIx64 " <- 0x%02" PRIx64
+stm32f2xx_usart_drop(char *id) " %s dropping the chars"
+stm32f2xx_usart_receive(char *id, uint8_t chr) " %s receiving '%c'"
-- 
2.47.1


