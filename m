Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7995C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOE-0003c1-82; Tue, 11 Aug 2026 12:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNp-0001rR-Q7
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNo-0000nG-02
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kc13nXUTSuMz/0eFM/NUTUDuVKo3/6LbmmwdzhwHkIc=;
 b=L+R/kkbl0B1mNuzQgcYVUOloABsA4zDrVJ6JmUyt/UotvJ781iurGGECUs60jwm1RIb/14
 zliqLHZC00b3B7lzZWotUTBnLWBQgkdDC2h68rgH/80Ee4k1vfx1itV9x+b2atnd1bZmIm
 AD8sgxLm+JN4KswkVasbOqqfUaBRA4U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-t3AtJtoPMuuHEwT0X-QGqg-1; Tue,
 11 Aug 2026 12:31:16 -0400
X-MC-Unique: t3AtJtoPMuuHEwT0X-QGqg-1
X-Mimecast-MFC-AGG-ID: t3AtJtoPMuuHEwT0X-QGqg_1786465875
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79BE1800D8D; Tue, 11 Aug 2026 16:31:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FD91195DF91; Tue, 11 Aug 2026 16:31:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 42/83] hw/gpio: pca9552: expose GPIO pins as pin%d QOM
 properties
Date: Tue, 11 Aug 2026 18:28:57 +0200
Message-ID: <20260811162938.1403216-43-clg@redhat.com>
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The PCA9552 exposes its LED channels as led%d QOM string properties, but
the GPIO variants (PCA9535/PCA9555) inherited the same led%d interface,
which drives the LED selector registers and is meaningless for a plain
I/O expander.

Add pin%d string properties ("low"/"high") for the GPIO variants,
mirroring the standalone pca9555 model:

  - reading returns the raw pin logic level from the INPUT register;
  - writing drives the external input level, but only for pins the guest
    has configured as inputs (writes to output pins are ignored with a
    LOG_UNIMP message).

The LED variant keeps its led%d properties.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-9-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 91 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 54a5945d9252..719149b7174b 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -68,6 +68,7 @@ struct PCA955xClass {
 #define PCA9552_PIN_HIZ  0x1
 
 static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
+static const char *pin_state[] = {"low", "high"};
 
 static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
 {
@@ -428,6 +429,79 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
     pca955x_write(s, reg, val);
 }
 
+static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
+
+static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(obj);
+    PCA955xState *s = PCA955X(obj);
+    int pin, rc;
+    uint8_t input_reg, state;
+
+    rc = sscanf(name, "pin%2d", &pin);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (pin < 0 || pin >= k->pin_count) {
+        error_setg(errp, "%s invalid pin %s", __func__, name);
+        return;
+    }
+
+    /*
+     * Report the raw pin logic level; polarity inversion is a read-time
+     * transform applied to the INPUT register, not to the pin state itself.
+     */
+    input_reg = PCA9535_INPUT0 + (pin / 8);
+    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
+    visit_type_str(v, name, (char **)&pin_state[state], errp);
+}
+
+static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(obj);
+    PCA955xState *s = PCA955X(obj);
+    int pin, rc;
+    uint8_t state, config_reg;
+    g_autofree char *state_str = NULL;
+
+    if (!visit_type_str(v, name, &state_str, errp)) {
+        return;
+    }
+    rc = sscanf(name, "pin%2d", &pin);
+    if (rc != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    if (pin < 0 || pin >= k->pin_count) {
+        error_setg(errp, "%s invalid pin %s", __func__, name);
+        return;
+    }
+
+    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
+        if (!strcmp(state_str, pin_state[state])) {
+            break;
+        }
+    }
+    if (state >= ARRAY_SIZE(pin_state)) {
+        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
+        return;
+    }
+
+    /* Only input-configured pins can be driven by an external device. */
+    config_reg = PCA9535_CONFIG0 + (pin / 8);
+    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: pin %d is configured as output, ignoring set\n",
+                      s->description, pin);
+        return;
+    }
+
+    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
+}
+
 static const VMStateDescription pca9552_vmstate = {
     .name = "PCA9552",
     .version_id = 0,
@@ -485,15 +559,22 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
 static void pca955x_initfn(Object *obj)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
-    int led;
 
     assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
-    for (led = 0; led < k->pin_count; led++) {
+    for (int ix = 0; ix < k->pin_count; ix++) {
         char *name;
 
-        name = g_strdup_printf("led%d", led);
-        object_property_add(obj, name, "bool", pca955x_get_led, pca955x_set_led,
-                            NULL, NULL);
+        if (k->has_led_support) {
+            /* LED variant: expose the LED selector state as led%d. */
+            name = g_strdup_printf("led%d", ix);
+            object_property_add(obj, name, "bool",
+                                pca955x_get_led, pca955x_set_led, NULL, NULL);
+        } else {
+            /* GPIO variant: expose the pin logic level as pin%d. */
+            name = g_strdup_printf("pin%d", ix);
+            object_property_add(obj, name, "str",
+                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
+        }
         g_free(name);
     }
 }
-- 
2.55.0


