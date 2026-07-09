Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5834EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqeU-0003Dr-GF; Thu, 09 Jul 2026 11:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqeP-00031g-Ni; Thu, 09 Jul 2026 11:26:58 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqeN-0000qX-NQ; Thu, 09 Jul 2026 11:26:57 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 73F5B2003E3;
 Thu,  9 Jul 2026 17:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610813;
 bh=nTPKO9sBrN0leDBoGALQ4/xdAwz0yN4V8CDZkVDqDzQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iiObnCzJkyo2Y6JYMOeJ1Y7fR5EyEccHx6h9kfz6DcCSdTDbdwhxqukYr6TEzo63p
 LRvqhMM7vP3IX10uZOWZEthe4Y+tTY//K35Vic2x2kzQdRsI0iVJRZhnsaXt5nsrTu
 35QjF0YDH6yYmwTOpzAUmI4/gbipHYjMaPnNdsZ1Gw7mPQLVB7x0MAeNkkGHt7vK6T
 uwsvCy/YeudXwclCQbammA2acE8tmsRxSu7CGyrpXnqmwNH4vO3Kr/P0WGGE4dbeCd
 O2Ma4lKAipLQns4yWBFz2/Vbudzt8EI38SzyeGniulw5WvgWBKFLDjq3rfXdFaZPWG
 xT1qwYafBTcdw==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:46 +0200
Subject: [PATCH 08/29] hw/gpio: pca9552: conform GPIO command handling to
 the datasheet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-8-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=3521;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=nTPKO9sBrN0leDBoGALQ4/xdAwz0yN4V8CDZkVDqDzQ=;
 b=ntsEG//L/jcgGXvjOSqEr+ulnNAn80mpaRV3TOkaJdVzLrr2QyTKKHahCFdlJsD1wM7eVNoLG
 FrV8QCzOVPxCInpv+7c3ez9NhK1Qcdl+uWTF7+FplTV2vtnFX6GNOBy
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The PCA9535/PCA9555 GPIO expanders share the PCA955X command dispatch
path with the PCA9552 LED blinker, but their register access differs from
the LED variant:

  - Auto-increment happens on every access and toggles bit 0 so the
    pointer stays within the addressed register pair (input, output,
    polarity, config); there is no AI enable bit.

  - The command byte only decodes 3 bits, so addresses beyond the last
    register alias back into the 8-register window instead of faulting.

Branch the auto-increment and command-decode logic on has_led_support so
the GPIO variants follow their datasheet while the PCA9552 behaviour is
left untouched.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 24f6465415..54a5945d92 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -259,14 +259,26 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 }
 
 /*
- * When Auto-Increment is on, the register address is incremented
- * after each byte is sent to or received by the device. The index
- * rollovers to 0 when the maximum register address is reached.
+ * Advance the command pointer after each byte sent to or received from the
+ * device.
+ *
+ * The LED variant auto-increments only when the AI bit (bit 4) is set in the
+ * command byte, rolling over to 0 once the maximum register address is
+ * reached.
+ *
+ * The GPIO variants auto-increment on every access, toggling bit 0 so the
+ * pointer stays within the addressed register pair
+ * (input/output/polarity/config), as specified by their datasheet.
  */
 static void pca955x_autoinc(PCA955xState *s)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(s);
 
+    if (!k->has_led_support) {
+        s->pointer ^= 0x1;
+        return;
+    }
+
     if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
         uint8_t reg = s->pointer & 0xf;
 
@@ -275,12 +287,25 @@ static void pca955x_autoinc(PCA955xState *s)
     }
 }
 
+/*
+ * The LED variant addresses its registers with a 4-bit command field, while
+ * the GPIO variants only decode 3 bits (the command wraps into the 8-register
+ * window).
+ */
+static inline uint8_t pca955x_cmd_reg(PCA955xState *s)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    return s->pointer & (k->has_led_support ? 0xf : 0x7);
+}
+
 static uint8_t pca955x_recv(I2CSlave *i2c)
 {
     PCA955xState *s = PCA955X(i2c);
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
     uint8_t ret;
 
-    ret = pca955x_read(s, s->pointer & 0xf);
+    ret = pca955x_read(s, pca955x_cmd_reg(s));
 
     /*
      * From the Specs:
@@ -292,7 +317,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)
      * I don't know what should be done in this case, so throw an
      * error.
      */
-    if (s->pointer == PCA9552_AUTOINC) {
+    if (k->has_led_support && s->pointer == PCA9552_AUTOINC) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Autoincrement read starting with register 0\n",
                       __func__);
@@ -312,7 +337,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t data)
         s->pointer = data;
         s->len++;
     } else {
-        pca955x_write(s, s->pointer & 0xf, data);
+        pca955x_write(s, pca955x_cmd_reg(s), data);
 
         pca955x_autoinc(s);
     }

-- 
2.50.1


