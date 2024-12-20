Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E8FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 08:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOYel-0004pY-Vw; Fri, 20 Dec 2024 03:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1tOYeh-0004om-Nz; Fri, 20 Dec 2024 03:46:44 -0500
Received: from forward103d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1tOYef-0000nS-1O; Fri, 20 Dec 2024 03:46:43 -0500
Received: from mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:4f43:0:640:673c:0])
 by forward103d.mail.yandex.net (Yandex) with ESMTPS id 839216001C;
 Fri, 20 Dec 2024 11:46:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id LkOX0FeOoKo0-GTl7G6FW; 
 Fri, 20 Dec 2024 11:46:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1734684382; bh=DEWLsEBJEXh8+7vMojttx0v1UhjFc3wSl+wOs7T9sjg=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=RITAACjjkJPFzXzzQeWZGsFOlXZCtLrbBI3AgH/NDuPcmUq1wHIB658Bejm+dh8R8
 42hCEpMo3nGDCyMSPr2FcHpQvRbJsTTizmdBY8aGZL32yYNeKx8Q314hKyTzX8WWvb
 WEcbHkeDxDiRNAqIL6t5jCr2iaOzCE3oevAfflOU=
Authentication-Results: mail-nwsmtp-smtp-production-main-24.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>,
 Nikita Shubin <n.shubin@yadro.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/char: stm32f2xx_usart: replace print with trace
Date: Fri, 20 Dec 2024 11:46:23 +0300
Message-ID: <20241220084623.1889-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d103;
 envelope-from=nikita.shubin@maquefel.me; helo=forward103d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
---
 hw/char/stm32f2xx_usart.c | 47 ++++++++++++++++++---------------------
 hw/char/trace-events      |  6 +++++
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 17b5b1f15f..ca878d0cd6 100644
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
+    trace_stm32f2xx_usart_recieve(d->id, *buf);
 }
 
 static void stm32f2xx_usart_reset(DeviceState *dev)
@@ -101,49 +92,55 @@ static uint64_t stm32f2xx_usart_read(void *opaque, hwaddr addr,
                                        unsigned int size)
 {
     STM32F2XXUsartState *s = opaque;
+    DeviceState *d = DEVICE(s);
     uint64_t retvalue;
 
-    DB_PRINT("Read 0x%"HWADDR_PRIx"\n", addr);
-
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
index 59e1f734a7..e0a567194c 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -125,3 +125,9 @@ xen_console_unrealize(unsigned int idx) "idx %u"
 xen_console_realize(unsigned int idx, const char *chrdev) "idx %u chrdev %s"
 xen_console_device_create(unsigned int idx) "idx %u"
 xen_console_device_destroy(unsigned int idx) "idx %u"
+
+# stm32f2xx_usart.c
+stm32f2xx_usart_read(char *id, unsigned size, uint64_t offs, uint64_t val) " %s size %d offs 0x%02" PRIx64 " -> 0x%02" PRIx64
+stm32f2xx_usart_write(char *id, unsigned size, uint64_t offs, uint64_t val) "%s size %d offs 0x%02" PRIx64 " <- 0x%02" PRIx64
+stm32f2xx_usart_drop(char *id) " %s dropping the chars"
+stm32f2xx_usart_recieve(char *id, uint8_t chr) " %s receiving %c"
-- 
2.45.2


