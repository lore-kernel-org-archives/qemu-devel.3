Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D6C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOE-0003go-PZ; Tue, 11 Aug 2026 12:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO8-0003O8-DK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO5-0000rH-HT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV9W5JhxEWZj3Tbt/uYnvHurVf63gLwmR/czAfJZIxE=;
 b=V7O3MHViTFTkplYVTCy7BMdp7yvAZ3WLadpEY/brxLfvEfCaWL2wYjLEbIleLff4Jo2Ncd
 slYA68vrzWvTTx/VvPZ3sSNLmaWi6wSfMiZ5RSkXKa11cp6p2LQXg5Lwgk6C9qAIhs3NHx
 XUpK+LDicab4TQJFVbx1PiKm0e0JO3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-GTBkhn8hO1So6AfZ06KO1g-1; Tue,
 11 Aug 2026 12:31:28 -0400
X-MC-Unique: GTBkhn8hO1So6AfZ06KO1g-1
X-Mimecast-MFC-AGG-ID: GTBkhn8hO1So6AfZ06KO1g_1786465887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03FC1180034F; Tue, 11 Aug 2026 16:31:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 500D9195DF98; Tue, 11 Aug 2026 16:31:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 48/83] hw/gpio: pca9554: add PCA9536 support
Date: Tue, 11 Aug 2026 18:29:03 +0200
Message-ID: <20260811162938.1403216-49-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The PCA9536 is a 4-bit I/O expander that's register-compatible with the
PCA9554 but only has 4 pins.  Rather than duplicating the whole driver,
make the existing PCA9554 model parameterizable and register PCA9536 as
a subtype.

Introduce a PCA9554Class with a pin_count property, and replace every
hard-coded PCA9554_PIN_COUNT reference in the driver with the class
value.  The reset function now computes the correct pin mask from
pin_count instead of assuming 0xFF.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-15-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/pca9554.h |  2 +
 hw/gpio/pca9554.c         | 79 ++++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
index 54bfc4c4c7a0..c09108e8b650 100644
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
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 8427e01e9b23..b44ec0d9991c 100644
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
-}
 
-static const TypeInfo pca9554_info = {
-    .name          = TYPE_PCA9554,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca9554_initfn,
-    .instance_size = sizeof(PCA9554State),
-    .class_init    = pca9554_class_init,
-    .class_size    = sizeof(PCA9554Class),
-    .abstract      = false,
-};
+    pc->pin_count = PCA9554_PIN_COUNT;
+}
 
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
-- 
2.55.0


