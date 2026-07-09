Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F098C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsoD-0006XB-AC; Thu, 09 Jul 2026 13:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whso9-0006Ws-EU; Thu, 09 Jul 2026 13:45:09 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whso6-0006zP-TM; Thu, 09 Jul 2026 13:45:09 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 3EF5D20039E;
 Thu,  9 Jul 2026 19:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783619103;
 bh=Vo3yKldZbhsukEB6vokF4cP035jiACvQjrkOM/NbWkA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XOSpvj1lWWWddEwq6Dz2ZXRQRsNcuMTYvg8DRkfSVBCpksfwxUPpll9FolaUle9oZ
 M+3hkGvo+Lk9sB6tDG8HXXOBoNf1I6m9YJ6v/s81mm0ZnjNcHJcpUqhlG2z3LCG964
 NEZlqokW82oxr388kONG+PurQc1IyzXWpaOzrXCocnbqilEjo1KmSUHbQ4MZ2qnjzF
 MF/bQSMTdwCb/OtEkiZoqWxIcosIJ7aw2rWJ8jsZc2R+pAjoUAFTpkeFvg5Z4RrGZ2
 bUv4bqhxtNCd/VCgHpEw5mVnjabGGf4UlkPJeZq25QhmQ+rzhVkWmqWNFf34zSelqO
 TGlpnI31sykOg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:07 +0200
Subject: [PATCH 15/29] hw/gpio: pca9554: add PCA9536 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-15-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=7809;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Vo3yKldZbhsukEB6vokF4cP035jiACvQjrkOM/NbWkA=;
 b=nHDuS6gCuze7Zk+bOv6pKzKFq818zSVKL6Cl2O+lUWeDjgMzjXL65atS6SbUlKmjP/68B/eA7
 8bAv4ipHup8D0mFQLtv9eZKkXZYyfRtMxgPlquccMOxzJwMJ7CvvM0X
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PCA9536 is a 4-bit I/O expander that's register-compatible with the
PCA9554 but only has 4 pins.  Rather than duplicating the whole driver,
make the existing PCA9554 model parameterizable and register PCA9536 as
a subtype.

Introduce a PCA9554Class with a pin_count property, and replace every
hard-coded PCA9554_PIN_COUNT reference in the driver with the class
value.  The reset function now computes the correct pin mask from
pin_count instead of assuming 0xFF.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9554.c         | 79 +++++++++++++++++++++++++++++++----------------
 include/hw/gpio/pca9554.h |  2 ++
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 8427e01e9b2..b44ec0d9991 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -24,6 +24,8 @@ struct PCA9554Class {
     /*< private >*/
     I2CSlaveClass parent_class;
     /*< public >*/
+
+    uint8_t pin_count;
 };
 typedef struct PCA9554Class PCA9554Class;
 
@@ -37,12 +39,13 @@ static const char *pin_state[] = {"low", "high"};
 
 static void pca9554_update_pin_input(PCA9554State *s)
 {
+    PCA9554Class *pc = PCA9554_GET_CLASS(s);
     int i;
     uint8_t config = s->regs[PCA9554_CONFIG];
     uint8_t output = s->regs[PCA9554_OUTPUT];
     uint8_t internal_state = config | output;
 
-    for (i = 0; i < PCA9554_PIN_COUNT; i++) {
+    for (i = 0; i < pc->pin_count; i++) {
         uint8_t bit_mask = 1 << i;
         uint8_t internal_pin_state = (internal_state >> i) & 0x1;
         uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
@@ -67,7 +70,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
             break;
         }
 
-        /* update irq state only if pin state changed */
+        /* drive the per-pin GPIO output only if the pin level changed */
         new_value = s->regs[PCA9554_INPUT] & bit_mask;
         if (new_value != old_value) {
             if (new_value) {
@@ -99,6 +102,12 @@ static uint8_t pca9554_read(PCA9554State *s, uint8_t reg)
 
 static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
 {
+    PCA9554Class *pc = PCA9554_GET_CLASS(s);
+    uint8_t pin_mask = (1 << pc->pin_count) - 1;
+
+    /* Variants narrower than 8 bits ignore the unimplemented upper pins. */
+    data &= pin_mask;
+
     switch (reg) {
     case PCA9554_OUTPUT:
     case PCA9554_CONFIG:
@@ -157,7 +166,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
@@ -184,7 +193,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
@@ -232,13 +241,15 @@ static const VMStateDescription pca9554_vmstate = {
 static void pca9554_reset(DeviceState *dev)
 {
     PCA9554State *s = PCA9554(dev);
+    PCA9554Class *pc = PCA9554_GET_CLASS(s);
+    uint8_t pin_mask = (1 << pc->pin_count) - 1;
 
-    s->regs[PCA9554_INPUT] = 0xFF;
-    s->regs[PCA9554_OUTPUT] = 0xFF;
+    s->regs[PCA9554_INPUT] = pin_mask;
+    s->regs[PCA9554_OUTPUT] = pin_mask;
     s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
-    s->regs[PCA9554_CONFIG] = 0xFF; /* All pins are inputs */
+    s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
 
-    memset(s->ext_state, PCA9554_PIN_HIZ, PCA9554_PIN_COUNT);
+    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
     pca9554_update_pin_input(s);
 
     s->pointer = 0x0;
@@ -247,9 +258,10 @@ static void pca9554_reset(DeviceState *dev)
 
 static void pca9554_initfn(Object *obj)
 {
+    PCA9554Class *pc = PCA9554_GET_CLASS(obj);
     int pin;
 
-    for (pin = 0; pin < PCA9554_PIN_COUNT; pin++) {
+    for (pin = 0; pin < pc->pin_count; pin++) {
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
@@ -269,23 +281,24 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
 
 static void pca9554_gpio_in_handler(void *opaque, int pin, int level)
 {
-
     PCA9554State *s = PCA9554(opaque);
+    PCA9554Class *pc = PCA9554_GET_CLASS(s);
 
-    assert((pin >= 0) && (pin < PCA9554_PIN_COUNT));
+    assert((pin >= 0) && (pin < pc->pin_count));
     pca9554_set_ext_state(s, pin, level);
 }
 
 static void pca9554_realize(DeviceState *dev, Error **errp)
 {
     PCA9554State *s = PCA9554(dev);
+    PCA9554Class *pc = PCA9554_GET_CLASS(s);
 
     if (!s->description) {
-        s->description = g_strdup("pca9554");
+        s->description = g_strdup(object_get_typename(OBJECT(dev)));
     }
 
-    qdev_init_gpio_out(dev, s->gpio_out, PCA9554_PIN_COUNT);
-    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, PCA9554_PIN_COUNT);
+    qdev_init_gpio_out(dev, s->gpio_out, pc->pin_count);
+    qdev_init_gpio_in(dev, pca9554_gpio_in_handler, pc->pin_count);
 }
 
 static const Property pca9554_properties[] = {
@@ -296,6 +309,7 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    PCA9554Class *pc = PCA9554_CLASS(klass);
 
     k->event = pca9554_event;
     k->recv = pca9554_recv;
@@ -304,21 +318,32 @@ static void pca9554_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, pca9554_reset);
     dc->vmsd = &pca9554_vmstate;
     device_class_set_props(dc, pca9554_properties);
+
+    pc->pin_count = PCA9554_PIN_COUNT;
 }
 
-static const TypeInfo pca9554_info = {
-    .name          = TYPE_PCA9554,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca9554_initfn,
-    .instance_size = sizeof(PCA9554State),
-    .class_init    = pca9554_class_init,
-    .class_size    = sizeof(PCA9554Class),
-    .abstract      = false,
-};
-
-static void pca9554_register_types(void)
+static void pca9536_class_init(ObjectClass *klass, const void *data)
 {
-    type_register_static(&pca9554_info);
+    PCA9554Class *pc = PCA9554_CLASS(klass);
+
+    pc->pin_count = PCA9536_PIN_COUNT;
 }
 
-type_init(pca9554_register_types)
+static const TypeInfo pca9554_types[] = {
+    {
+        .name          = TYPE_PCA9554,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_init = pca9554_initfn,
+        .instance_size = sizeof(PCA9554State),
+        .class_init    = pca9554_class_init,
+        .class_size    = sizeof(PCA9554Class),
+        .abstract      = false,
+    },
+    {
+        .name          = TYPE_PCA9536,
+        .parent        = TYPE_PCA9554,
+        .class_init    = pca9536_class_init,
+    }
+};
+
+DEFINE_TYPES(pca9554_types);
diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
index 54bfc4c4c7a..c09108e8b65 100644
--- a/include/hw/gpio/pca9554.h
+++ b/include/hw/gpio/pca9554.h
@@ -12,12 +12,14 @@
 #include "qom/object.h"
 
 #define TYPE_PCA9554 "pca9554"
+#define TYPE_PCA9536 "pca9536"
 typedef struct PCA9554State PCA9554State;
 DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
                          TYPE_PCA9554)
 
 #define PCA9554_NR_REGS 4
 #define PCA9554_PIN_COUNT 8
+#define PCA9536_PIN_COUNT 4
 
 struct PCA9554State {
     /*< private >*/

-- 
2.50.1


