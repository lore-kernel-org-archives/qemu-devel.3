Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469B5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtcw-0000sl-1H; Thu, 09 Jul 2026 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtcM-0000Ko-L6; Thu, 09 Jul 2026 14:37:03 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtcJ-0006xw-VA; Thu, 09 Jul 2026 14:37:02 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id E85C92003C3;
 Thu,  9 Jul 2026 20:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783622215;
 bh=/xhDYqX32sp5AONV22mgTb0it3HYU+t4cXJ3+D/dOPM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UWch1zpWiXFqCdq5rYzKPvwQFP5s90WYsqW7rYi3O/FRgfY/kEL1lLbl0hBB/8/E/
 hB0mQUw9SyAYsFetQU2uHvcOSh5EAJTtHfOCkP1eaWbIQABgTFoCrl5rFmsZvMd7bk
 eehtE2J0hfm8T9vOodClULlQr0lz7J3XygY0g/ns43vkuVOr9r4Bv1OjyIVIH+auxK
 3ELI/I1o/RQk19xTqIy5I8iP+Nck0xDdjVeJd8ocNa+feQuROwRtzd4p3frSX3+v0s
 15o8howo6pkG5pt69+HRTvcMjY7sy9hgdW8SdYt6f3dT3U+GHH3IpAANp3Su2IzBLH
 1pvf9lblFmJlQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:08 +0200
Subject: [PATCH 16/29] hw/gpio: pca9554: add hw-dir property honoring the
 configured pin direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-16-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=5836;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=/xhDYqX32sp5AONV22mgTb0it3HYU+t4cXJ3+D/dOPM=;
 b=X+gAoJxXpbIPOlNG9LyZdRPPufVJhUr6v+E50Gw0oHcbs1gLNUslsqjpx/J2upuWUDsG8rKOe
 T0vpwV/jCM6CyLo/kCe15JCumZnFp4IBodfzlT8d5YuAv2rs0lqU8Aa
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The pinN QOM accessors are meant to let external agents observe and
stimulate the expander's pins, but their default behaviour does not
match real hardware:

 - to "drive" a pin, set_pin writes the OUTPUT register and then clears
   the pin's Configuration bit to force it into output mode. On a real
   device the pin direction is owned solely by the host (programmed
   through the Configuration register over I2C); an external agent can
   neither flip a pin's direction nor impose a level on a pin the host
   drives as an output -- the latter is a voltage conflict, not a legal
   operation.
 - get_pin returns a CONFIG|OUTPUT composite, i.e. the guest's intent,
   rather than the level actually sampled on the pin.

The PCA9555 GPIO variant (hw/gpio/pca9552.c) already models this
correctly and unconditionally: only input-configured pins can be driven
from outside, and reads return the sampled INPUT register.

Add a "hw-dir" property to bring the pca9554 pin accessors in line with
the hardware (and with the PCA9555 model), without changing the
behaviour seen by existing users:

 - hw-dir=true: set_pin only drives pins the guest has configured as
   inputs; a set on an output pin is refused with a LOG_UNIMP warning.
   get_pin returns the sampled INPUT register.
 - hw-dir=false (default): keeps the legacy, non-conformant behaviour
   for backward compatibility.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9554.c         | 65 ++++++++++++++++++++++++++++++-----------------
 include/hw/gpio/pca9554.h |  1 +
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index b44ec0d999..ed38fe102b 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -154,6 +154,14 @@ static int pca9554_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
+static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
+{
+    if (s->ext_state[pin] != level) {
+        s->ext_state[pin] = level;
+        pca9554_update_pin_input(s);
+    }
+}
+
 static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -171,9 +179,13 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    state = pca9554_read(s, PCA9554_CONFIG);
-    state |= pca9554_read(s, PCA9554_OUTPUT);
-    state = (state >> pin) & 0x1;
+    /*
+     * Report the physical pin level. The input register is kept in sync by
+     * pca9554_update_pin_input(): output pins mirror the OUTPUT register and
+     * input pins reflect the externally driven (or pulled-up) level, so it
+     * holds the wire level regardless of the configured direction.
+     */
+    state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
     visit_type_str(v, name, (char **)&pin_state[state], errp);
 }
 
@@ -208,20 +220,34 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    /* First, modify the output register bit */
-    val = pca9554_read(s, PCA9554_OUTPUT);
-    mask = 0x1 << pin;
-    if (state == PCA9554_PIN_LOW) {
-        val &= ~(mask);
+    if (s->hw_dir) {
+        /* Warn and ignore if the guest has configured this pin as output */
+        if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: pin %d is configured as output, "
+                          "ignoring external set\n",
+                          s->description, pin);
+            return;
+        }
+        /* Drive the external input level */
+        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
     } else {
-        val |= mask;
-    }
-    pca9554_write(s, PCA9554_OUTPUT, val);
+        /* Legacy behavior: force output mode and drive */
+        /* First, modify the output register bit */
+        val = pca9554_read(s, PCA9554_OUTPUT);
+        mask = 0x1 << pin;
+        if (state == PCA9554_PIN_LOW) {
+            val &= ~(mask);
+        } else {
+            val |= mask;
+        }
+        pca9554_write(s, PCA9554_OUTPUT, val);
 
-    /* Then, clear the config register bit for output mode */
-    val = pca9554_read(s, PCA9554_CONFIG);
-    val &= ~mask;
-    pca9554_write(s, PCA9554_CONFIG, val);
+        /* Then, clear the config register bit for output mode */
+        val = pca9554_read(s, PCA9554_CONFIG);
+        val &= ~mask;
+        pca9554_write(s, PCA9554_CONFIG, val);
+    }
 }
 
 static const VMStateDescription pca9554_vmstate = {
@@ -271,14 +297,6 @@ static void pca9554_initfn(Object *obj)
     }
 }
 
-static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
-{
-    if (s->ext_state[pin] != level) {
-        s->ext_state[pin] = level;
-        pca9554_update_pin_input(s);
-    }
-}
-
 static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
 {
     PCA9554State *s = PCA9554(opaque);
@@ -303,6 +321,7 @@ static void pca9554_realize(DeviceState *dev, Error **errp)
 
 static const Property pca9554_properties[] = {
     DEFINE_PROP_STRING("description", PCA9554State, description),
+    DEFINE_PROP_BOOL("hw-dir", PCA9554State, hw_dir, false),
 };
 
 static void pca9554_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
index c09108e8b6..ac835371aa 100644
--- a/include/hw/gpio/pca9554.h
+++ b/include/hw/gpio/pca9554.h
@@ -33,6 +33,7 @@ struct PCA9554State {
     qemu_irq gpio_out[PCA9554_PIN_COUNT];
     uint8_t ext_state[PCA9554_PIN_COUNT];
     char *description; /* For debugging purpose only */
+    bool hw_dir; /* Honor pin direction */
 };
 
 #endif

-- 
2.50.1


