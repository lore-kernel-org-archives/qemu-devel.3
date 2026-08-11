Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8FFC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO7-0003Ei-7Y; Tue, 11 Aug 2026 12:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO5-0002zX-0O
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO2-0000qc-Hp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nl7siUAYJUkETrxC5qHBDmjFm0OaBKfTudgse+i8hps=;
 b=XR/eG/8jkKjxC+Y70v//nPlnbRxCYrL/f1eoMtMOXlb3cEiFxBkBaOUwfJUZSL3iolWWhe
 Yl2D3FISArCjex4iMEg25CrnN6lKOwyfhyNZb9S6MBY8709zNtAFZr362Aqw6Jw4PKqQJI
 /+rvidRag5gs3O2vCyZr1NiXQOP7S5I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-X461XdRfOpKC7Zvf8lbKlg-1; Tue,
 11 Aug 2026 12:31:30 -0400
X-MC-Unique: X461XdRfOpKC7Zvf8lbKlg-1
X-Mimecast-MFC-AGG-ID: X461XdRfOpKC7Zvf8lbKlg_1786465889
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2861619560A6; Tue, 11 Aug 2026 16:31:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74030195DF98; Tue, 11 Aug 2026 16:31:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 49/83] hw/gpio: pca9554: add hw-dir property honoring the
 configured pin direction
Date: Tue, 11 Aug 2026 18:29:04 +0200
Message-ID: <20260811162938.1403216-50-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

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
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-16-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/pca9554.h |  1 +
 hw/gpio/pca9554.c         | 65 +++++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
index c09108e8b650..ac835371aaca 100644
--- a/include/hw/gpio/pca9554.h
+++ b/include/hw/gpio/pca9554.h
@@ -33,6 +33,7 @@ struct PCA9554State {
     qemu_irq gpio_out[PCA9554_PIN_COUNT];
     uint8_t ext_state[PCA9554_PIN_COUNT];
     char *description; /* For debugging purpose only */
+    bool hw_dir; /* Honor pin direction */
 };
 
 #endif
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index b44ec0d9991c..ed38fe102b18 100644
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
-- 
2.55.0


