Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70243C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqeo-0003jl-Ai; Thu, 09 Jul 2026 11:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqeh-0003iU-IW; Thu, 09 Jul 2026 11:27:15 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqef-0000u4-Kv; Thu, 09 Jul 2026 11:27:15 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 5B2022003C6;
 Thu,  9 Jul 2026 17:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610831;
 bh=phSVqXjlW6fKdjD3q/8lu3y0rl6dzThOv7UqOyJ81oU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=i4uOU8nlwJi/7SXQJQ5fk/1c2YMSAT7lkZj9ILnsr8fPvE9R99NevrAssGVKfwank
 BDTZhZlfdmDuq9Rz3QTZ1LtfnMOgg6gOpBC7c35zTAXCuRKwYd8DcHsc3cWzanharH
 5JpS9X8K0GrRaRFNl/kuOUY8z/8OomeRoWg/+Uo79ghvHV+HN7ncTIfheM6SGJrUFD
 Mj4j9h2VAZJ1LGEJoBDevrc3oMs2a1WnrAr28Kz7co6C2Yfj9x3zuhC1lLzvuAiis3
 fEoYIT7BRUFAxISeuR5dR0ilHjFjQuYTJMI9/ABvPugn0MfFhnHiHku693wmimdpms
 uZjFhl3ubOp8Q==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:47 +0200
Subject: [PATCH 09/29] hw/gpio: pca9552: expose GPIO pins as pin%d QOM
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-9-814575bc076b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=5079;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=phSVqXjlW6fKdjD3q/8lu3y0rl6dzThOv7UqOyJ81oU=;
 b=vhWnw+CmnSIxW35ah7ZHNRpe55Uf6IIoL/YqWZ35waxp7/H0qnauAvezeGQwYiT2wgWS53Igc
 zEz7mhW16I4AlDN1s7+srS/CJOMmi4zg/3WD2Tvh8wQ0/RBRI3Rindn
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
---
 hw/gpio/pca9552.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 54a5945d92..719149b717 100644
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
2.50.1


