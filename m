Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B2AE95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaB9-0000U5-Fr; Wed, 04 Feb 2026 05:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAx-0000Pm-JX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaAv-0003xd-Kf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOoJB/7nq9dc4eOGZ7pJSfBnOc+mf5g+fTVM6Zr8/KI=;
 b=bPFRM2c/SCof7IA4UMfE7O2BNRano3XXe8FJWFaV2lYQqlsadfufOh0AZZYRWquXiiJIUO
 cyAx7V/Nz/MO4oIJJyIYF2/kXk42VhNBrGpW/KmaY4CcqUZN1ppLBa15dwyNZ4h0STlk2e
 HKF9SMB6D2n068djOvWJC97uRrcCuYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-6qt7CW7PMpuLrrCTGWvnPA-1; Wed,
 04 Feb 2026 05:31:55 -0500
X-MC-Unique: 6qt7CW7PMpuLrrCTGWvnPA-1
X-Mimecast-MFC-AGG-ID: 6qt7CW7PMpuLrrCTGWvnPA_1770201114
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C85B41955DDB; Wed,  4 Feb 2026 10:31:53 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E6A718003F6; Wed,  4 Feb 2026 10:31:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Patrick Williams <patrick@stwcx.xyz>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/45] hw/gpio/pca9552: add pca9535 support
Date: Wed,  4 Feb 2026 11:30:57 +0100
Message-ID: <20260204103136.1795455-7-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Patrick Williams <patrick@stwcx.xyz>

Extend the 16-bit PCA9552 model to support non-LED devices such as
the PCA9535[1].

[1]: https://www.ti.com/lit/ds/symlink/pca9535.pdf

Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260121-pca9535-v1-1-164640e622ff@stwcx.xyz
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/pca9552.h      |   1 +
 include/hw/gpio/pca9552_regs.h |  10 ++
 hw/gpio/pca9552.c              | 176 +++++++++++++++++++++++----------
 3 files changed, 133 insertions(+), 54 deletions(-)

diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index c36525f0c3f6..43b175235d2f 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -14,6 +14,7 @@
 
 #define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA955X "pca955x"
+#define TYPE_PCA9535 "pca9535"
 typedef struct PCA955xState PCA955xState;
 DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
                          TYPE_PCA955X)
diff --git a/include/hw/gpio/pca9552_regs.h b/include/hw/gpio/pca9552_regs.h
index d8051cfbd69b..5a6bb03396fb 100644
--- a/include/hw/gpio/pca9552_regs.h
+++ b/include/hw/gpio/pca9552_regs.h
@@ -29,4 +29,14 @@
  */
 #define PCA9552_AUTOINC  (1 << 4)
 
+/* PCA9535 Registers (same addresses, different semantics) */
+#define PCA9535_INPUT0      0 /* read only input register 0 */
+#define PCA9535_INPUT1      1 /* read only input register 1  */
+#define PCA9535_OUTPUT0     2 /* read/write output register 0 */
+#define PCA9535_OUTPUT1     3 /* read/write output register 1 */
+#define PCA9535_POLARITY0   4 /* read/write polarity inversion register 0 */
+#define PCA9535_POLARITY1   5 /* read/write polarity inversion register 1 */
+#define PCA9535_CONFIG0     6 /* read/write configuration register 0 */
+#define PCA9535_CONFIG1     7 /* read/write configuration register 1 */
+
 #endif
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index dd3c795e49aa..dd3f1536b65e 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -31,6 +31,7 @@ struct PCA955xClass {
 
     uint8_t pin_count;
     uint8_t max_reg;
+    bool has_led_support;
 };
 typedef struct PCA955xClass PCA955xClass;
 
@@ -113,32 +114,59 @@ static void pca955x_update_pin_input(PCA955xState *s)
     for (i = 0; i < k->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t bit_mask = 1 << (i % 8);
-        uint8_t config = pca955x_pin_get_config(s, i);
         uint8_t old_value = s->regs[input_reg] & bit_mask;
         uint8_t new_value;
 
-        switch (config) {
-        case PCA9552_LED_ON:
-            /* Pin is set to 0V to turn on LED */
-            s->regs[input_reg] &= ~bit_mask;
-            break;
-        case PCA9552_LED_OFF:
-            /*
-             * Pin is set to Hi-Z to turn off LED and
-             * pullup sets it to a logical 1 unless
-             * external device drives it low.
-             */
-            if (s->ext_state[i] == PCA9552_PIN_LOW) {
+        if (k->has_led_support) {
+            /* PCA9552: LED control behavior */
+            uint8_t config = pca955x_pin_get_config(s, i);
+
+            switch (config) {
+            case PCA9552_LED_ON:
+                /* Pin is set to 0V to turn on LED */
                 s->regs[input_reg] &= ~bit_mask;
+                break;
+            case PCA9552_LED_OFF:
+                /*
+                 * Pin is set to Hi-Z to turn off LED and
+                 * pullup sets it to a logical 1 unless
+                 * external device drives it low.
+                 */
+                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                    s->regs[input_reg] &= ~bit_mask;
+                } else {
+                    s->regs[input_reg] |=  bit_mask;
+                }
+                break;
+            case PCA9552_LED_PWM0:
+            case PCA9552_LED_PWM1:
+                /* TODO */
+            default:
+                break;
+            }
+        } else {
+            /* PCA9535: Simple GPIO behavior */
+            uint8_t config_reg = PCA9535_CONFIG0 + (i / 8);
+            uint8_t output_reg = PCA9535_OUTPUT0 + (i / 8);
+            uint8_t polarity_reg = PCA9535_POLARITY0 + (i / 8);
+
+            /* Check if pin is configured as input */
+            if (s->regs[config_reg] & bit_mask) {
+                /* Input mode - reflect external state */
+                if (s->ext_state[i] == PCA9552_PIN_LOW) {
+                    s->regs[input_reg] &= ~bit_mask;
+                } else {
+                    s->regs[input_reg] |= bit_mask;
+                }
             } else {
-                s->regs[input_reg] |=  bit_mask;
+                /* Output mode - reflect output register value */
+                uint8_t output_bit = s->regs[output_reg] & bit_mask;
+                uint8_t polarity_bit = s->regs[polarity_reg] & bit_mask;
+
+                /* Apply polarity inversion if set */
+                s->regs[input_reg] = (s->regs[input_reg] & ~bit_mask) |
+                                    ((output_bit ^ polarity_bit) & bit_mask);
             }
-            break;
-        case PCA9552_LED_PWM0:
-        case PCA9552_LED_PWM1:
-            /* TODO */
-        default:
-            break;
         }
 
         /* update irq state only if pin state changed */
@@ -151,52 +179,52 @@ static void pca955x_update_pin_input(PCA955xState *s)
 
 static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
 {
-    switch (reg) {
-    case PCA9552_INPUT0:
-    case PCA9552_INPUT1:
-    case PCA9552_PSC0:
-    case PCA9552_PWM0:
-    case PCA9552_PSC1:
-    case PCA9552_PWM1:
-    case PCA9552_LS0:
-    case PCA9552_LS1:
-    case PCA9552_LS2:
-    case PCA9552_LS3:
-        return s->regs[reg];
-    default:
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    if (reg > k->max_reg) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected read to register %d\n",
                       __func__, reg);
         return 0xFF;
     }
+
+    return s->regs[reg];
 }
 
 static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 {
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
     uint16_t pins_status;
 
-    switch (reg) {
-    case PCA9552_PSC0:
-    case PCA9552_PWM0:
-    case PCA9552_PSC1:
-    case PCA9552_PWM1:
-        s->regs[reg] = data;
-        break;
-
-    case PCA9552_LS0:
-    case PCA9552_LS1:
-    case PCA9552_LS2:
-    case PCA9552_LS3:
-        pins_status = pca955x_pins_get_status(s);
-        s->regs[reg] = data;
-        pca955x_update_pin_input(s);
-        pca955x_display_pins_status(s, pins_status);
-        break;
-
-    case PCA9552_INPUT0:
-    case PCA9552_INPUT1:
-    default:
+    if (reg > k->max_reg) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: unexpected write to register %d\n",
                       __func__, reg);
+        return;
+    }
+
+    /* Handle read-only registers */
+    if (reg == PCA9552_INPUT0 || reg == PCA9552_INPUT1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: unexpected write to read-only register %d\n",
+                      __func__, reg);
+        return;
+    }
+
+    pins_status = pca955x_pins_get_status(s);
+    s->regs[reg] = data;
+
+    /* Update GPIO state if this register affects outputs */
+    if (k->has_led_support) {
+        /* PCA9552: Update on LED selector register writes */
+        if (reg >= PCA9552_LS0 && reg <= PCA9552_LS3) {
+            pca955x_update_pin_input(s);
+            pca955x_display_pins_status(s, pins_status);
+        }
+    } else {
+        /* PCA9535: Update on OUTPUT, POLARITY, or CONFIG register writes */
+        if (reg >= PCA9535_OUTPUT0 && reg <= PCA9535_CONFIG1) {
+            pca955x_update_pin_input(s);
+            pca955x_display_pins_status(s, pins_status);
+        }
     }
 }
 
@@ -379,6 +407,26 @@ static void pca9552_reset(DeviceState *dev)
     s->len = 0;
 }
 
+static void pca9535_reset(DeviceState *dev)
+{
+    PCA955xState *s = PCA955X(dev);
+
+    s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
+    s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
+    s->regs[PCA9535_OUTPUT0] = 0xFF;  /* All outputs high */
+    s->regs[PCA9535_OUTPUT1] = 0xFF;  /* All outputs high */
+    s->regs[PCA9535_POLARITY0] = 0x00; /* No polarity inversion */
+    s->regs[PCA9535_POLARITY1] = 0x00; /* No polarity inversion */
+    s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
+    s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
+
+    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
+    pca955x_update_pin_input(s);
+
+    s->pointer = 0xFF;
+    s->len = 0;
+}
+
 static void pca955x_initfn(Object *obj)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
@@ -463,6 +511,19 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
     dc->vmsd = &pca9552_vmstate;
     pc->max_reg = PCA9552_LS3;
     pc->pin_count = 16;
+    pc->has_led_support = true;
+}
+
+static void pca9535_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCA955xClass *pc = PCA955X_CLASS(oc);
+
+    device_class_set_legacy_reset(dc, pca9535_reset);
+    dc->vmsd = &pca9552_vmstate;
+    pc->max_reg = PCA9535_CONFIG1;
+    pc->pin_count = 16;
+    pc->has_led_support = false;
 }
 
 static const TypeInfo pca9552_info = {
@@ -471,10 +532,17 @@ static const TypeInfo pca9552_info = {
     .class_init    = pca9552_class_init,
 };
 
+static const TypeInfo pca9535_info = {
+    .name          = TYPE_PCA9535,
+    .parent        = TYPE_PCA955X,
+    .class_init    = pca9535_class_init,
+};
+
 static void pca955x_register_types(void)
 {
     type_register_static(&pca955x_info);
     type_register_static(&pca9552_info);
+    type_register_static(&pca9535_info);
 }
 
 type_init(pca955x_register_types)
-- 
2.52.0


