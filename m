Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E814EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKm-0004Cg-3g; Wed, 08 Jan 2025 04:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKF-0003xl-Du; Wed, 08 Jan 2025 04:26:10 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSKC-0004oH-7g; Wed, 08 Jan 2025 04:26:07 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso29736822a12.3; 
 Wed, 08 Jan 2025 01:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328362; x=1736933162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMIpdFO0N7wGBeNJgw4ik62IVdc9YLqNPL4DIkZzaYo=;
 b=EctkDglTzH6uvHBNnQrqNyVp7zLyVigORgTAxDiOtHfuinY4vSECv3mTMwFjxEpCYh
 y0CqjrYNtJYFSNd2eF67sBx6TjJpX+oMRxCsgjgZBrtC+V7JN/shdsf46TLIfrI5VDCC
 SFtILgKtGqVFkYIjtcS7xr51YLV5jZQ3HCN9VV3tkXBNO61/vP6yCjNomYalu0q32Fvo
 iAZqe8Mzn9E6Bw598nLk/0V9ErMARsbC9kGzZrZrDcJWiiYeZbNEgcIA75LkKRgA931L
 qihXUc6Y4+qpynq+9dJjZD9v1o2e7PHa3QXG64CgXHNVMGtLreapgdMskFP/CqRw0HIP
 Kaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328362; x=1736933162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vMIpdFO0N7wGBeNJgw4ik62IVdc9YLqNPL4DIkZzaYo=;
 b=hoYjcuM0vLcWq9tRWdvYsS4WBxdQs39UCrSOPMpaB1ito4bQ0tNToP3OJvbFQgDaBq
 6wNmNZNMN6LMlib9Y12x+eDhR6Lf4tTrd9QmYjG+9oRHV6Cn/DdYOjkzkkInsupyXKC/
 PPIvKMPZbVVz1YRbQ1ahHSP3HnkM6rsE4dQWDtchKhx/TPf6TL0R1vfJyB0GAy8uPvbt
 E3TZHxi4Ohug+4bl/W37JyOZjXuC2P35Vav9HHv6Eh+TzKiePk+UNPR7qMEx0tBD9tBz
 8ajknWe6CvhWHEFd2515ZWNR5HFg5WmPcrTbeqEne8IovyCPPRo1FjPRIu+A7zru0eDo
 mGDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuq4kfmpeu0Ef9MkLnm8SJrCnA9os+nvUEh4fraOl2oNCwx5jxHquXsGDoDrZkWK2xzjmLLTqBcudfNg==@nongnu.org,
 AJvYcCX3LchvoIeHxRR7+sNLJ1EJ3+DAw2xKeEJQVVu1xfcxMUsvWEqxgG9MDxmYt1GRYtdNBaA8OQ0gCQ==@nongnu.org
X-Gm-Message-State: AOJu0YyJDUm/K5OfoABZsWxk5wXGNXSWieEh4CSA4WWhO7MutQvgVEcX
 ffOzWsxfiA6vGEaoVIy31MFunO49OOPLm5j3hwKiFwFPsEOi3ZB8NtRs36uK
X-Gm-Gg: ASbGncvOGq5Vzo0RP+RRecuZY0Zrv7ii0Ko2oXBnPAenVKeVhGdwW3Nn+QzKI7lTIaY
 5YTZxou/2wKM/QOTt2LVmetC7u0Y1jelprALLvd6fsDodn7euLPWP+B/rWzf2K6h/xMOgJLh/ct
 0+3/9tUjAXVuz+esTATeEnU2M7g8XvV8vYhVSCXohMSTfWVFnB8o9d2fqFlSPkBYjCdX4UPw6B1
 6L8iq1DgEgsEwfyES7+/kkh78LfKzuAGFGGn05VE0pWJLhirNemK1WAIeQnWWWz3qvSYk/+N0/X
 cyS2HAc9YiCaF0DfQ7yEU1kqSrQGX1lBtEcLJLuOnVqsbek=
X-Google-Smtp-Source: AGHT+IHFQrFh6c57c1Coios4cW/pdrw9Wvf4lb/JVTP2PZXx04NVCsBCCfngWDORLJUGAI+7FR3yzw==
X-Received: by 2002:a05:6402:5288:b0:5d0:b7c5:c409 with SMTP id
 4fb4d7f45d1cf-5d972e0abe4mr1669542a12.14.1736328361615; 
 Wed, 08 Jan 2025 01:26:01 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:26:00 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 09/14] hw/char/imx_serial: Turn some DPRINTF() statements into
 trace events
Date: Wed,  8 Jan 2025 10:25:33 +0100
Message-ID: <20250108092538.11474-10-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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
index 59e1f734a7..4c6d401b4b 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -52,6 +52,11 @@ escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
 escc_kbd_command(int val) "Command %d"
 escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
 
+# imx_serial.c
+imx_serial_read(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] -> 0x%08" PRIu64
+imx_serial_write(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03" PRIu64 "] <- 0x%08" PRIu64
+imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIu32
+
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-- 
2.47.1


