Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC4606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OS37wW9v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHki-000552-Jx; Fri, 06 Nov 2026 06:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkf-00052J-NH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkZ-0007jt-VS
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLmHl0i6l1o00R46wiIXsmzHEjWMyiu8ChInFUFLDFU=;
 b=OS37wW9vyngC+A5nB/k/nUwwvwwPScPlvxQhTwWW9j6ncgE78vHydDEeKnGj3pmJcDoVjg
 m5IPCkfHXkJN2fyZ08IrEsi2HmP5sAzy6eg7QZ7AyYVR6irpaIjyA/eyS1+7U1PqAy/ccK
 V0H9pNbmxotaXBskQ/jf0upAhnIaH6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-Q-lTLeyXMwOzLzr_3-bueA-1; Fri,
 06 Nov 2026 06:04:47 -0500
X-MC-Unique: Q-lTLeyXMwOzLzr_3-bueA-1
X-Mimecast-MFC-AGG-ID: Q-lTLeyXMwOzLzr_3-bueA_1793963086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F7E31955F11; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 184D81956089; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C979621E6885; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 6/8] hw/gpio/pca955x: use QAPI enums for led and pin properties
Date: Fri,  6 Nov 2026 12:04:38 +0100
Message-ID: <20261106110440.3552588-7-armbru@redhat.com>
In-Reply-To: <20261106110440.3552588-1-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace hand-rolled string lookup tables with QAPI enums
Pca9552LedState and GpioPinState for the led%d and pin%d QOM
properties. This lets QAPI handle string-to-enum conversion in the
visitor, removing the manual string matching in the setters.

Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
stay in sync with the hardware register encoding.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json | 29 ++++++++++++++++++
 hw/gpio/pca9552.c | 76 +++++++++++++++++------------------------------
 hw/gpio/pca9554.c | 35 ++++++++--------------
 3 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 18d9dce849..c4c8720909 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -416,6 +416,35 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
 
+##
+# @GpioPinState:
+#
+# @low: Pin low
+#
+# @high: Pin high
+#
+# Since: 12.0
+##
+{ 'enum': 'GpioPinState',
+  'data': ['low', 'high'] }
+
+##
+# @Pca9552LedState:
+#     LED state for PCA9552.
+#
+# @on: LED on
+#
+# @off: LED off
+#
+# @pwm0: LED controlled by PWM0
+#
+# @pwm1: LED controlled by PWM1
+#
+# Since: 12.0
+##
+{ 'enum': 'Pca9552LedState',
+  'data': ['on', 'off', 'pwm0', 'pwm1'] }
+
 ##
 # @PCSouthBridgeOption:
 #     South bridge chipset option for PC i440FX machines.
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 65a718ef31..99c4e0c0e2 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -60,16 +61,15 @@ struct PCA955xClass {
 /*
  * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
  *        chips are the reverse of the PCA953X family of chips.
+ *
+ * The QAPI enums must match the hardware register values.
  */
-#define PCA9552_LED_ON   0x0
-#define PCA9552_LED_OFF  0x1
-#define PCA9552_LED_PWM0 0x2
-#define PCA9552_LED_PWM1 0x3
-#define PCA9552_PIN_LOW  0x0
-#define PCA9552_PIN_HIZ  0x1
-
-static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
-static const char *pin_state[] = {"low", "high"};
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_ON != 0x0);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_OFF != 0x1);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM0 != 0x2);
+QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM1 != 0x3);
+QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
 
 static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 {
@@ -143,24 +143,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
             uint8_t config = pca955x_pin_get_config(s, i);
 
             switch (config) {
-            case PCA9552_LED_ON:
+            case PCA9552_LED_STATE_ON:
                 /* Pin is set to 0V to turn on LED */
                 s->regs[input_reg] &= ~bit_mask;
                 break;
-            case PCA9552_LED_OFF:
+            case PCA9552_LED_STATE_OFF:
                 /*
                  * Pin is set to Hi-Z to turn off LED and
                  * pullup sets it to a logical 1 unless
                  * external device drives it low.
                  */
-                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
                     s->regs[input_reg] &= ~bit_mask;
                 } else {
                     s->regs[input_reg] |=  bit_mask;
                 }
                 break;
-            case PCA9552_LED_PWM0:
-            case PCA9552_LED_PWM1:
+            case PCA9552_LED_STATE_PWM0:
+            case PCA9552_LED_STATE_PWM1:
                 /* TODO */
             default:
                 break;
@@ -177,7 +177,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
              */
             if (s->regs[config_reg] & bit_mask) {
                 /* Input mode - reflect external state */
-                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
                     s->regs[input_reg] &= ~bit_mask;
                 } else {
                     s->regs[input_reg] |= bit_mask;
@@ -361,7 +361,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg;
-    uint8_t state;
+    Pca9552LedState state;
 
     rc = sscanf(name, "led%2d", &led);
     if (rc != 1) {
@@ -379,7 +379,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
      */
     reg = PCA9552_LS0 + led / 4;
     state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
-    visit_type_str(v, name, (char **)&led_state[state], errp);
+    visit_type_Pca9552LedState(v, name, &state, errp);
 }
 
 /*
@@ -398,10 +398,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg, val;
-    uint8_t state;
-    g_autofree char *state_str = NULL;
+    Pca9552LedState state;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "led%2d", &led);
@@ -414,16 +413,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
-        if (!strcmp(state_str, led_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(led_state)) {
-        error_setg(errp, "%s invalid led state %s", __func__, state_str);
-        return;
-    }
-
     reg = PCA9552_LS0 + led / 4;
     val = pca955x_read(s, reg);
     val = pca955x_ledsel(val, led % 4, state);
@@ -438,7 +427,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t input_reg, state;
+    uint8_t input_reg;
+    GpioPinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -456,7 +446,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
      */
     input_reg = PCA9535_INPUT0 + (pin / 8);
     state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_GpioPinState(v, name, &state, errp);
 }
 
 static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
@@ -465,10 +455,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t state, config_reg;
-    g_autofree char *state_str = NULL;
+    GpioPinState state;
+    uint8_t config_reg;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_GpioPinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -481,16 +471,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
-        if (!strcmp(state_str, pin_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(pin_state)) {
-        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
-        return;
-    }
-
     /* Only input-configured pins can be driven by an external device. */
     config_reg = PCA9535_CONFIG0 + (pin / 8);
     if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
@@ -500,7 +480,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
+    pca955x_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
 }
 
 static const VMStateDescription pca9552_vmstate = {
@@ -530,7 +510,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -550,7 +530,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
     s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, GPIO_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index ed304e4639..7bbfd5ed5f 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -18,6 +18,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -51,10 +52,8 @@ struct PCA9554Class {
     uint8_t pin_count;
 };
 
-#define PCA9554_PIN_LOW  0x0
-#define PCA9554_PIN_HIZ  0x1
-
-static const char *pin_state[] = {"low", "high"};
+QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(GPIO_PIN_STATE_HIGH != 0x1);
 
 static void pca9554_update_pin_input(PCA9554State *s)
 {
@@ -73,7 +72,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
              * Input: the pin is Hi-Z with a pull-up, so it reads high
              * unless an external device drives it low.
              */
-            if (s->ext_state[i] == PCA9554_PIN_LOW) {
+            if (s->ext_state[i] == GPIO_PIN_STATE_LOW) {
                 s->regs[PCA9554_INPUT] &= ~bit_mask;
             } else {
                 s->regs[PCA9554_INPUT] |= bit_mask;
@@ -175,7 +174,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554_BASE(obj);
     int pin, rc;
-    uint8_t state;
+    GpioPinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -194,7 +193,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
      * holds the wire level regardless of the configured direction.
      */
     state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_GpioPinState(v, name, &state, errp);
 }
 
 static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
@@ -202,10 +201,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554_BASE(obj);
     int pin, rc, val;
-    uint8_t state, mask;
-    g_autofree char *state_str = NULL;
+    uint8_t mask;
+    GpioPinState state;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_GpioPinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -218,16 +217,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
-        if (!strcmp(state_str, pin_state[state])) {
-            break;
-        }
-    }
-    if (state >= ARRAY_SIZE(pin_state)) {
-        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
-        return;
-    }
-
     if (s->hw_dir) {
         /* Warn and ignore if the guest has configured this pin as output */
         if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
@@ -238,13 +227,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
             return;
         }
         /* Drive the external input level */
-        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
+        pca9554_set_ext_state(s, pin, state != GPIO_PIN_STATE_LOW);
     } else {
         /* Legacy behavior: force output mode and drive */
         /* First, modify the output register bit */
         val = pca9554_read(s, PCA9554_OUTPUT);
         mask = 0x1 << pin;
-        if (state == PCA9554_PIN_LOW) {
+        if (state == GPIO_PIN_STATE_LOW) {
             val &= ~(mask);
         } else {
             val |= mask;
@@ -283,7 +272,7 @@ static void pca9554_reset(DeviceState *dev)
     s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
     s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
 
-    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
+    memset(s->ext_state, GPIO_PIN_STATE_HIGH, pc->pin_count);
     pca9554_update_pin_input(s);
 
     s->pointer = 0x0;
-- 
2.55.0


