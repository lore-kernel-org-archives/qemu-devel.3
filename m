Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1526CC021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 00:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlze7-0006af-3r; Sat, 22 Feb 2025 19:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tlze4-0006aH-EU; Sat, 22 Feb 2025 19:14:56 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tlze2-0000zA-7W; Sat, 22 Feb 2025 19:14:56 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE4894E6005;
 Sun, 23 Feb 2025 01:14:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0wvAjC_z8FHO; Sun, 23 Feb 2025 01:14:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D21104E603E; Sun, 23 Feb 2025 01:14:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/misc/macio/gpio.c: Add defines for register bits
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20250223001445.D21104E603E@zero.eik.bme.hu>
Date: Sun, 23 Feb 2025 01:14:45 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Add named constants for register bit values that should make it easier
to understand what these mean.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/misc/macio/gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 4364afc84a..06be5a4f98 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -34,6 +34,9 @@
 #include "qemu/module.h"
 #include "trace.h"
 
+#define OUT_DATA   1
+#define IN_DATA    2
+#define OUT_ENABLE 4
 
 void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 {
@@ -41,14 +44,14 @@ void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 
     trace_macio_set_gpio(gpio, state);
 
-    if (s->gpio_regs[gpio] & 4) {
+    if (s->gpio_regs[gpio] & OUT_ENABLE) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "GPIO: Setting GPIO %d while it's an output\n", gpio);
     }
 
-    new_reg = s->gpio_regs[gpio] & ~2;
+    new_reg = s->gpio_regs[gpio] & ~IN_DATA;
     if (state) {
-        new_reg |= 2;
+        new_reg |= IN_DATA;
     }
 
     if (new_reg == s->gpio_regs[gpio]) {
@@ -107,12 +110,12 @@ static void macio_gpio_write(void *opaque, hwaddr addr, uint64_t value,
 
     addr -= 8;
     if (addr < 36) {
-        value &= ~2;
+        value &= ~IN_DATA;
 
-        if (value & 4) {
-            ibit = (value & 1) << 1;
+        if (value & OUT_ENABLE) {
+            ibit = (value & OUT_DATA) << 1;
         } else {
-            ibit = s->gpio_regs[addr] & 2;
+            ibit = s->gpio_regs[addr] & IN_DATA;
         }
 
         s->gpio_regs[addr] = value | ibit;
-- 
2.30.9


