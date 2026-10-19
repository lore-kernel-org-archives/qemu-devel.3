Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C6FCCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoFx-0005R9-FU; Mon, 19 Oct 2026 10:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDa-0002Mj-Qp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDT-0005gS-Px
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgiidPrwN5K/mDaZe/838AMwgYDT7+OedrphbwONt5I=;
 b=QceyA3ZOun92S8elPoNO5p/RqC1T6lwqHvenlqIi7el3pi5wNnGqs2Cmddeyb3d0gcFk5O
 1nwwbtRU760N3ugCUPiYyoWgpBFyUzurAAT2AN1UHSvcQdGvAgAiQaciOpPNsOIBlxuRE/
 TfYNeW25cCpP6iEXmkNzOgyqtmn/dNU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-vCBGDAd6OueotmPYRZd6VQ-1; Mon,
 19 Oct 2026 14:19:42 +0000
X-MC-Unique: vCBGDAd6OueotmPYRZd6VQ-1
X-Mimecast-MFC-AGG-ID: vCBGDAd6OueotmPYRZd6VQ_1792419581
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740A718005A5; Mon, 19 Oct 2026 14:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E02197D8; Mon, 19 Oct 2026 14:19:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A04021E683C; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 48/65] hw/gpio/pca955x: use QAPI enums for led and pin
 properties
Date: Mon, 19 Oct 2026 16:19:12 +0200
Message-ID: <20261019141929.1594337-49-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 46 ++++++++++++++++++++++++++
 hw/gpio/pca9552.c | 82 ++++++++++++++++++-----------------------------
 hw/gpio/pca9554.c | 39 +++++++++-------------
 3 files changed, 92 insertions(+), 75 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 34be315627..46b6935ab0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -416,6 +416,52 @@
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
 #     Injects a Non-Maskable Interrupt (machine specific: for example
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 719149b717..16741c22de 100644
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
index 904698cdce..e4eddc829e 100644
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
-- 
2.55.0


