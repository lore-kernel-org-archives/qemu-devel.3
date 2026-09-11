Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41355C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54IX-00063o-I7; Fri, 11 Sep 2026 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54IV-000637-O7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54IT-00075G-C6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qREL4rLqmsKjsuOlLljdIaMwFLp75inzgflxtWc4AuE=;
 b=TPmraRv4M2btl2nl4o3PTHgYb+MoKkIW+gyYk1X5Luv4kGgJxXvsOvb4uc7ellkQLi9i7K
 v2HK2IdFyZwc6tfuFCEZ+KUqf7WpktJrvabxhqRry96Bssp0nm0Rkduewzogb7KyVT1xdk
 hJW/MJi+bc4E06676dViMam+AeCAFqU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-xtYC3ZgsOLaPOSqdnjGWhA-1; Fri,
 11 Sep 2026 12:40:13 -0400
X-MC-Unique: xtYC3ZgsOLaPOSqdnjGWhA-1
X-Mimecast-MFC-AGG-ID: xtYC3ZgsOLaPOSqdnjGWhA_1789144811
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C6651800598; Fri, 11 Sep 2026 16:40:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5987F433; Fri, 11 Sep 2026 16:40:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:18 +0400
Subject: [PATCH v5 44/62] hw/gpio/pca955x: use QAPI enums for led and pin
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-44-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=14925;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XlkmyZuB8ML4Dwyx9HhUYqfHoTK+rV9hfdym0B0GJhw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27VEDDC38DbjceUdTE7G7+7g5wlD3oscrjR
 CQ5Y8+JjhKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5ZJ7D/4vV6WQCkK8QpmEBawbSTdzjiZImI+qHyD/15zFG84yvtE1JRd+3GRRHUJjcu0pGvte1LX
 5BEdNejrG4RP2KP9Rux61vWHMNL0pfdZipjIVOJPEZVgWPkCvDNmxkOwV8PATAlxJA+ApyjhLRr
 sbF+07tJv4j5XbCQDtmHDkhqgDTVoDt2JHlcnhCp04l743dOVlaKbXP+Ypm+LluWyHfi+yxyohz
 XO5BXHwqx+hPM7LNlUXuy74xLpbRmhBaEdziP4CXDj6cIU+VKYu8WaSlDr8XZEaJ+OOrEE23UxC
 X3IBYvQ2mTxYPbc4AxTQBhj0AeQFsbm4XXcioNWziy0YP+msXXJoWYnJuYnUFcOtG3KWZf56Zjv
 Qxk9rlhg2uAO8pNSADYrHwegfuaCwNj/2dmgIkTxjb/Po07GktQZgHVf0n8rIPC64YM5mnrRp1S
 Atwua3WKMtWI20N3RTq2o8QtqLExmuEEI0/JP8BWW60X18RrCWVVQLgRupRiVHCPGq3gZHGnQvO
 +q+zZQ3eibkXvSTeAW5YbXApdyicFAH4ESzwV9BWR9WIj5kFHRn1pxzIeMM1AII82a5ziQ/rFud
 qy7FWPS4umlU2oAoVNpHVMPeTZtb2AUspqanp86a2+EGM0PxlYsjT9ZfUpbDPy9J/aeqc2s2edr
 34l9gdRSJ/I4n1A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Replace hand-rolled string lookup tables with QAPI enums
Pca9552LedState and Pca955{2,4}PinState for the led%d and pin%d QOM
properties. This fixes the incorrect property type ("bool" for LEDs,
"str" for pins) and lets QAPI handle string-to-enum conversion in the
visitor, removing the manual string matching in the setters.

Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
stay in sync with the hardware register encoding.

I kept Pca9552PinState & @Pca9554PinState separate types, because I
don't know if they could diverge. We could eventually merge those.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/gpio/pca9552.c | 82 +++++++++++++++++++++----------------------------------
 hw/gpio/pca9554.c | 39 ++++++++++----------------
 qapi/machine.json | 46 +++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 75 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 719149b7174b..16741c22dea3 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -23,7 +23,8 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
-#include "qapi/visitor.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -59,16 +60,15 @@ struct PCA955xClass {
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
+QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_HIGH != 0x1);
 
 static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 {
@@ -142,24 +142,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
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
+                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
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
@@ -176,7 +176,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
              */
             if (s->regs[config_reg] & bit_mask) {
                 /* Input mode - reflect external state */
-                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
                     s->regs[input_reg] &= ~bit_mask;
                 } else {
                     s->regs[input_reg] |= bit_mask;
@@ -360,7 +360,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int led, rc, reg;
-    uint8_t state;
+    Pca9552LedState state;
 
     rc = sscanf(name, "led%2d", &led);
     if (rc != 1) {
@@ -378,7 +378,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
      */
     reg = PCA9552_LS0 + led / 4;
     state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
-    visit_type_str(v, name, (char **)&led_state[state], errp);
+    visit_type_Pca9552LedState(v, name, &state, errp);
 }
 
 /*
@@ -397,10 +397,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
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
@@ -413,16 +412,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
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
@@ -437,7 +426,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t input_reg, state;
+    uint8_t input_reg;
+    Pca9552PinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -455,7 +445,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
      */
     input_reg = PCA9535_INPUT0 + (pin / 8);
     state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_Pca9552PinState(v, name, &state, errp);
 }
 
 static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
@@ -464,10 +454,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
     int pin, rc;
-    uint8_t state, config_reg;
-    g_autofree char *state_str = NULL;
+    Pca9552PinState state;
+    uint8_t config_reg;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -480,16 +470,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
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
@@ -499,7 +479,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
+    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
 }
 
 static const VMStateDescription pca9552_vmstate = {
@@ -529,7 +509,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9552_LS2] = 0x55;
     s->regs[PCA9552_LS3] = 0x55;
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -549,7 +529,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
     s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
 
-    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
     pca955x_update_pin_input(s);
 
     s->pointer = 0xFF;
@@ -567,12 +547,12 @@ static void pca955x_initfn(Object *obj)
         if (k->has_led_support) {
             /* LED variant: expose the LED selector state as led%d. */
             name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "bool",
+            object_property_add(obj, name, "Pca9552LedState",
                                 pca955x_get_led, pca955x_set_led, NULL, NULL);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "str",
+            object_property_add(obj, name, "Pca9552PinState",
                                 pca955x_get_pin, pca955x_set_pin, NULL, NULL);
         }
         g_free(name);
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 904698cdce85..e4eddc829ef7 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -16,6 +16,8 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -32,10 +34,8 @@ typedef struct PCA9554Class PCA9554Class;
 DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
                        TYPE_PCA9554)
 
-#define PCA9554_PIN_LOW  0x0
-#define PCA9554_PIN_HIZ  0x1
-
-static const char *pin_state[] = {"low", "high"};
+QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_LOW != 0x0);
+QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_HIGH != 0x1);
 
 static void pca9554_update_pin_input(PCA9554State *s)
 {
@@ -54,7 +54,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
              * Input: the pin is Hi-Z with a pull-up, so it reads high
              * unless an external device drives it low.
              */
-            if (s->ext_state[i] == PCA9554_PIN_LOW) {
+            if (s->ext_state[i] == PCA9554_PIN_STATE_LOW) {
                 s->regs[PCA9554_INPUT] &= ~bit_mask;
             } else {
                 s->regs[PCA9554_INPUT] |= bit_mask;
@@ -156,7 +156,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554(obj);
     int pin, rc;
-    uint8_t state;
+    Pca9554PinState state;
 
     rc = sscanf(name, "pin%2d", &pin);
     if (rc != 1) {
@@ -175,7 +175,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
      * holds the wire level regardless of the configured direction.
      */
     state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
-    visit_type_str(v, name, (char **)&pin_state[state], errp);
+    visit_type_Pca9554PinState(v, name, &state, errp);
 }
 
 static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
@@ -183,10 +183,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA9554State *s = PCA9554(obj);
     int pin, rc, val;
-    uint8_t state, mask;
-    g_autofree char *state_str = NULL;
+    uint8_t mask;
+    Pca9554PinState state;
 
-    if (!visit_type_str(v, name, &state_str, errp)) {
+    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
         return;
     }
     rc = sscanf(name, "pin%2d", &pin);
@@ -199,16 +199,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
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
@@ -219,13 +209,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
             return;
         }
         /* Drive the external input level */
-        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
+        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
     } else {
         /* Legacy behavior: force output mode and drive */
         /* First, modify the output register bit */
         val = pca9554_read(s, PCA9554_OUTPUT);
         mask = 0x1 << pin;
-        if (state == PCA9554_PIN_LOW) {
+        if (state == PCA9554_PIN_STATE_LOW) {
             val &= ~(mask);
         } else {
             val |= mask;
@@ -264,7 +254,7 @@ static void pca9554_reset(DeviceState *dev)
     s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
     s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
 
-    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
+    memset(s->ext_state, PCA9554_PIN_STATE_HIGH, pc->pin_count);
     pca9554_update_pin_input(s);
 
     s->pointer = 0x0;
@@ -280,7 +270,8 @@ static void pca9554_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
+        object_property_add(obj, name, "Pca9554PinState",
+                            pca9554_get_pin, pca9554_set_pin,
                             NULL, NULL);
         g_free(name);
     }
diff --git a/qapi/machine.json b/qapi/machine.json
index d418b34a8643..0e0d85d0a76d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -429,6 +429,52 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'slew' ] }
 
+##
+# @Pca9552LedState:
+#
+# LED state for PCA9552.
+#
+# @on: LED on
+#
+# @off: LED off
+#
+# @pwm0: LED controlled by PWM0
+#
+# @pwm1: LED controlled by PWM1
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9552LedState',
+  'data': ['on', 'off', 'pwm0', 'pwm1'] }
+
+##
+# @Pca9552PinState:
+#
+# Pin state for PCA9552.
+#
+# @low: Pin low
+#
+# @high: Pin high
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9552PinState',
+  'data': ['low', 'high'] }
+
+##
+# @Pca9554PinState:
+#
+# Pin state for PCA9554.
+#
+# @low: Pin low
+#
+# @high: Pin high
+#
+# Since: 11.2
+##
+{ 'enum': 'Pca9554PinState',
+  'data': ['low', 'high'] }
+
 ##
 # @inject-nmi:
 #

-- 
2.55.0.543.g5ebe2ebe4ea8


