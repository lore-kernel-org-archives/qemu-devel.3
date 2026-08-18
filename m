Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07723C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ34-0002Mr-QY; Tue, 18 Aug 2026 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ34-0002MO-0j
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ31-0006ws-Mq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787056566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+7N6lQaNJ3+ymbHkk8ge+yyGgvBETdQK+dHzHp83lE=;
 b=EaF7Jnwkk2Nh0+x8IyTW+Zg+qwHNL2rTQXfiLSuIsG4M0lDQnzIqFoqP+QaY7KofkzFDyy
 gaB4XR0dulAadA78I1FY8GB3ae3FVwpWQSl6HsR+x2HnqPamVyqdZBIh2JWg+6wvx9QQ0A
 dXfdUoX9Ss0NkGXBdeZXnjNS0D0aV4M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-bfWz4WejOYGDr-p4rKeYhg-1; Tue,
 18 Aug 2026 08:36:05 -0400
X-MC-Unique: bfWz4WejOYGDr-p4rKeYhg-1
X-Mimecast-MFC-AGG-ID: bfWz4WejOYGDr-p4rKeYhg_1787056564
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7816119560AF; Tue, 18 Aug 2026 12:36:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E87D5422; Tue, 18 Aug 2026 12:36:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 16:36:36 +0400
Subject: [PATCH v3 57/74] hw/gpio/pca955x: convert pin/led property to
 QAPI-aware enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-57-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=18122;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jaJ89zwuq2tH/Z6pbH2n/emoNfh0O7+7mD66hHhyAJk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhFGnTh5GJ2UR42bx03fo3PUOUiQ7E2kaHl8jg
 8NCLfftTwaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRRpwAKCRDa6OEJdZac
 5VfBD/oCD4BVkXInpbxcN+rlTmU1uXoVuH0rWYUr6WAPHCXXoqgM62e+Zwuo3vLlnYnSjDMglJw
 FV4cdyTksNIU1Yb6q4aRIZS3jpxT7rsB8sYM0/aX8k2nr5S+YwpB+pRAMEBQnu41P58Q7XdIlKa
 JVpGsGB4Kq68ZKueAgImZBFQJdMMFerBIR0RxJ3KZHRwQ4jKJ+ehmK2QJ6vZKLdYJS5FKunAqWY
 ltRlA4T6CuHHfZOt0DPzh8i9tDoym5fQjTYIj+d1TFtDs/Rywr6quDQJ+PM1hMm839RyLWjJQy6
 BYNBSWy9ytMkWYFo0XZT74ghfSSPTrZKdMGVKV5J+7ET3p871vRlolAHdKdoAGirhgwVKnNZzkQ
 P33tcQEc1fbLCoCEaJsv4NPwUHEtKhC9W72RNbpDiqFYhfWL9/3BeWM4FC++wuXXsBLig4YeGJc
 vNqoYRAbHAb81oVySXeUKUZng50LpgBCv+kNYHt0Jyv5aHFraydH/yLAj7Sx8njPA23FECq1FuI
 luuv6HpoB13zO2bxsvbDcnPDrE6E2hTeD9EI2RLYSyN3I20cZaZ6E9wn0bqiTDLAV7dbRk+amaP
 bwr66eBUgeo1QmYUMNnfUS4Gfqi1U4gzFk5NCiMbd14U1QSOcGDEjvUkwBQ2tv1OiqRf6efsY32
 ePaa5wiwdAMcMjg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Replaces the runtime-parsed visitor-based QOM property accessors with
compile-time per-pin/per-LED accessor functions using QEMU_REPEAT.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/gpio/pca9552.c | 205 +++++++++++++++++++++---------------------------------
 hw/gpio/pca9554.c | 136 ++++++++++++++----------------------
 2 files changed, 131 insertions(+), 210 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 16741c22dea3..b743a30d80ff 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -25,6 +25,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -354,33 +355,6 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int led, rc, reg;
-    Pca9552LedState state;
-
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
-    /*
-     * Get the LSx register as the qom interface should expose the device
-     * state, not the modeled 'input line' behaviour which would come from
-     * reading the INPUTx reg
-     */
-    reg = PCA9552_LS0 + led / 4;
-    state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
-    visit_type_Pca9552LedState(v, name, &state, errp);
-}
-
 /*
  * Return an LED selector register value based on an existing one, with
  * the appropriate 2-bit state value set for the given LED number (0-3).
@@ -391,97 +365,8 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
                 ((state & 0x3) << (led_num << 1));
 }
 
-static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int led, rc, reg, val;
-    Pca9552LedState state;
-
-    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
-
-    reg = PCA9552_LS0 + led / 4;
-    val = pca955x_read(s, reg);
-    val = pca955x_ledsel(val, led % 4, state);
-    pca955x_write(s, reg, val);
-}
-
 static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
 
-static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int pin, rc;
-    uint8_t input_reg;
-    Pca9552PinState state;
-
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /*
-     * Report the raw pin logic level; polarity inversion is a read-time
-     * transform applied to the INPUT register, not to the pin state itself.
-     */
-    input_reg = PCA9535_INPUT0 + (pin / 8);
-    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
-    visit_type_Pca9552PinState(v, name, &state, errp);
-}
-
-static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    PCA955xState *s = PCA955X(obj);
-    int pin, rc;
-    Pca9552PinState state;
-    uint8_t config_reg;
-
-    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /* Only input-configured pins can be driven by an external device. */
-    config_reg = PCA9535_CONFIG0 + (pin / 8);
-    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: pin %d is configured as output, ignoring set\n",
-                      s->description, pin);
-        return;
-    }
-
-    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
-}
-
 static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
@@ -536,26 +421,92 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
     s->len = 0;
 }
 
+/*
+ * Get the LSx register as the qom interface should expose the device
+ * state, not the modeled 'input line' behaviour which would come from
+ * reading the INPUTx reg
+ */
+#define DEFINE_LED_ACCESSORS(n)                                              \
+static int prop_get_led##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
+    return (pca955x_read(s, reg) >> (((n) % 4) * 2)) & 0x3;                  \
+}                                                                            \
+static void prop_set_led##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
+    uint8_t old = pca955x_read(s, reg);                                      \
+    pca955x_write(s, reg, pca955x_ledsel(old, (n) % 4, val));                \
+}
+
+QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_LED_ACCESSORS)
+
+#define LED_ENUM_PROP(n) {                                              \
+    .name = "led" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9552LedState_type_info,                            \
+    .get = prop_get_led##n,                                             \
+    .set = prop_set_led##n,                                             \
+},
+
+static const QapiEnumProp led_enum_props[] = {
+    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, LED_ENUM_PROP)
+};
+
+/*
+ * Report the raw pin logic level; polarity inversion is a read-time
+ * transform applied to the INPUT register, not to the pin state
+ * itself.
+ */
+#define DEFINE_PIN_ACCESSORS(n)                                              \
+static int prop_get_pin##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t input_reg = PCA9535_INPUT0 + (n) / 8;                            \
+    return (s->regs[input_reg] >> ((n) % 8)) & 0x1;                          \
+}                                                                            \
+static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA955xState *s = PCA955X(obj);                                          \
+    uint8_t config_reg = PCA9535_CONFIG0 + (n) / 8;                          \
+    /* Only input-configured pins can be driven by an external device */     \
+    if (!((s->regs[config_reg] >> ((n) % 8)) & 0x1)) {                       \
+        qemu_log_mask(LOG_UNIMP,                                             \
+                      "%s: pin %d configured as output, ignoring set\n",     \
+                      s->description, (n));                                  \
+        return;                                                              \
+    }                                                                        \
+    pca955x_set_ext_state(s, (n), val != PCA9552_PIN_STATE_LOW);             \
+}
+
+QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_PIN_ACCESSORS)
+
+#define PIN_ENUM_PROP(n) {                                              \
+    .name = "pin" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9552PinState_type_info,                            \
+    .get = prop_get_pin##n,                                             \
+    .set = prop_set_pin##n,                                             \
+},
+
+static const QapiEnumProp pin_enum_props[] = {
+    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, PIN_ENUM_PROP)
+};
+
 static void pca955x_initfn(Object *obj)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
 
     assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
+    /* use array/list instead of individual QAPI enum properties */
     for (int ix = 0; ix < k->pin_count; ix++) {
-        char *name;
-
         if (k->has_led_support) {
-            /* LED variant: expose the LED selector state as led%d. */
-            name = g_strdup_printf("led%d", ix);
-            object_property_add(obj, name, "Pca9552LedState",
-                                pca955x_get_led, pca955x_set_led, NULL, NULL);
+            object_property_add_qapi_enum(obj, &led_enum_props[ix]);
         } else {
-            /* GPIO variant: expose the pin logic level as pin%d. */
-            name = g_strdup_printf("pin%d", ix);
-            object_property_add(obj, name, "Pca9552PinState",
-                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
+            object_property_add_qapi_enum(obj, &pin_enum_props[ix]);
         }
-        g_free(name);
     }
 }
 
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index e4eddc829ef7..f2a5b94a36d8 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -18,7 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/visitor.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "trace.h"
 #include "qom/object.h"
 
@@ -151,83 +151,60 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
     }
 }
 
-static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA9554State *s = PCA9554(obj);
-    int pin, rc;
-    Pca9554PinState state;
-
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
-
-    /*
-     * Report the physical pin level. The input register is kept in sync by
-     * pca9554_update_pin_input(): output pins mirror the OUTPUT register and
-     * input pins reflect the externally driven (or pulled-up) level, so it
-     * holds the wire level regardless of the configured direction.
-     */
-    state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
-    visit_type_Pca9554PinState(v, name, &state, errp);
+/*
+ * Report the physical pin level. The input register is kept in sync
+ * by pca9554_update_pin_input(): output pins mirror the OUTPUT
+ * register and input pins reflect the externally driven (or
+ * pulled-up) level, so it holds the wire level regardless of the
+ * configured direction.
+ */
+#define DEFINE_PIN_ACCESSORS(n)                                              \
+static int prop_get_pin##n(Object *obj, Error **errp)                        \
+{                                                                            \
+    PCA9554State *s = PCA9554(obj);                                          \
+    return (s->regs[PCA9554_INPUT] >> (n)) & 0x1;                            \
+}                                                                            \
+static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
+{                                                                            \
+    PCA9554State *s = PCA9554(obj);                                          \
+    if (s->hw_dir) {                                                         \
+        if (!((s->regs[PCA9554_CONFIG] >> (n)) & 0x1)) {                     \
+            qemu_log_mask(LOG_UNIMP,                                         \
+                          "%s: pin %d configured as output,"                 \
+                          " ignoring set\n",                                 \
+                          s->description, (n));                              \
+            return;                                                          \
+        }                                                                    \
+        pca9554_set_ext_state(s, (n), val != PCA9554_PIN_STATE_LOW);         \
+    } else {                                                                 \
+        /* Legacy behavior: force output mode and drive */                   \
+        uint8_t mask = 0x1 << (n);                                           \
+        int v = pca9554_read(s, PCA9554_OUTPUT);                             \
+        if (val == PCA9554_PIN_STATE_LOW) {                                  \
+            v &= ~mask;                                                      \
+        } else {                                                             \
+            v |= mask;                                                       \
+        }                                                                    \
+        pca9554_write(s, PCA9554_OUTPUT, v);                                 \
+        v = pca9554_read(s, PCA9554_CONFIG);                                 \
+        v &= ~mask;                                                          \
+        pca9554_write(s, PCA9554_CONFIG, v);                                 \
+    }                                                                        \
 }
 
-static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
-                            void *opaque, Error **errp)
-{
-    PCA9554State *s = PCA9554(obj);
-    int pin, rc, val;
-    uint8_t mask;
-    Pca9554PinState state;
+QEMU_REPEAT(PCA9554_PIN_COUNT, DEFINE_PIN_ACCESSORS)
 
-    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
-        return;
-    }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
+#define PIN_ENUM_PROP(n) {                                              \
+    .name = "pin" #n,                                                   \
+    .default_value = -1,                                                \
+    .qapi_type = &Pca9554PinState_type_info,                            \
+    .get = prop_get_pin##n,                                             \
+    .set = prop_set_pin##n,                                             \
+},
 
-    if (s->hw_dir) {
-        /* Warn and ignore if the guest has configured this pin as output */
-        if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
-            qemu_log_mask(LOG_UNIMP,
-                          "%s: pin %d is configured as output, "
-                          "ignoring external set\n",
-                          s->description, pin);
-            return;
-        }
-        /* Drive the external input level */
-        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
-    } else {
-        /* Legacy behavior: force output mode and drive */
-        /* First, modify the output register bit */
-        val = pca9554_read(s, PCA9554_OUTPUT);
-        mask = 0x1 << pin;
-        if (state == PCA9554_PIN_STATE_LOW) {
-            val &= ~(mask);
-        } else {
-            val |= mask;
-        }
-        pca9554_write(s, PCA9554_OUTPUT, val);
-
-        /* Then, clear the config register bit for output mode */
-        val = pca9554_read(s, PCA9554_CONFIG);
-        val &= ~mask;
-        pca9554_write(s, PCA9554_CONFIG, val);
-    }
-}
+static const QapiEnumProp pin_enum_props[] = {
+    QEMU_REPEAT(PCA9554_PIN_COUNT, PIN_ENUM_PROP)
+};
 
 static const VMStateDescription pca9554_vmstate = {
     .name = "PCA9554",
@@ -264,16 +241,9 @@ static void pca9554_reset(DeviceState *dev)
 static void pca9554_initfn(Object *obj)
 {
     PCA9554Class *pc = PCA9554_GET_CLASS(obj);
-    int pin;
 
-    for (pin = 0; pin < pc->pin_count; pin++) {
-        char *name;
-
-        name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "Pca9554PinState",
-                            pca9554_get_pin, pca9554_set_pin,
-                            NULL, NULL);
-        g_free(name);
+    for (int pin = 0; pin < pc->pin_count; pin++) {
+        object_property_add_qapi_enum(obj, &pin_enum_props[pin]);
     }
 }
 

-- 
2.55.0.543.g5ebe2ebe4ea8


