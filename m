Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13715606A32D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzCSx0GT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHkh-00053z-HF; Fri, 06 Nov 2026 06:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHke-00050u-UB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkZ-0007jn-Rl
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGafzS2BHueKCMO/ulA3n123TD+59lND+6DUEqJCaZA=;
 b=YzCSx0GTanzuFXrrQO//FACTIR+Wgyp3hCN9+HE3lFfTjJj8n/MbloXAJdxcYfDpxfjUX2
 SpBAsGau9kawGoJ7zFiN1JbEnTqLmqt/scnEBi7m5NB7e9fCclOK3yPGYUxdC1v0pQn1Fq
 wy1/V23QHtkcX+jD7rSmsZt3vQIPxN8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-6lpL72acMjKQORggFZGT7A-1; Fri,
 06 Nov 2026 06:04:47 -0500
X-MC-Unique: 6lpL72acMjKQORggFZGT7A-1
X-Mimecast-MFC-AGG-ID: 6lpL72acMjKQORggFZGT7A_1793963086
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9B33180054E; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DF36195608A; Fri,  6 Nov 2026 11:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1E2021E6887; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 8/8] hw/gpio/pca955x: Simplify pin and led getters and setters
Date: Fri,  6 Nov 2026 12:04:40 +0100
Message-ID: <20261106110440.3552588-9-armbru@redhat.com>
In-Reply-To: <20261106110440.3552588-1-armbru@redhat.com>
References: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass the index via object_class_property_add() parameter @opaque
instead extracting it from the property name.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/gpio/pca9552.c | 60 ++++++++++++++---------------------------------
 hw/gpio/pca9554.c | 30 +++++++-----------------
 2 files changed, 25 insertions(+), 65 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index f97ad6d083..c8d0e9a16d 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -360,18 +360,12 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
-    int led, rc, reg;
+    uintptr_t led = (uintptr_t)opaque;
+    int reg;
     Pca9552LedState state;
 
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
+    assert(led < k->pin_count);
+
     /*
      * Get the LSx register as the qom interface should expose the device
      * state, not the modeled 'input line' behaviour which would come from
@@ -397,21 +391,15 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
-    int led, rc, reg, val;
+    uintptr_t led = (uintptr_t)opaque;
+    int reg, val;
     Pca9552LedState state;
 
+    assert(led < k->pin_count);
+
     if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
         return;
     }
-    rc = sscanf(name, "led%2d", &led);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (led < 0 || led >= k->pin_count) {
-        error_setg(errp, "%s: invalid led %s", __func__, name);
-        return;
-    }
 
     reg = PCA9552_LS0 + led / 4;
     val = pca955x_read(s, reg);
@@ -426,19 +414,11 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
-    int pin, rc;
+    uintptr_t pin = (uintptr_t)opaque;
     uint8_t input_reg;
     GpioPinState state;
 
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
+    assert(pin < k->pin_count);
 
     /*
      * Report the raw pin logic level; polarity inversion is a read-time
@@ -454,28 +434,22 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
-    int pin, rc;
+    uintptr_t pin = (uintptr_t)opaque;
     GpioPinState state;
     uint8_t config_reg;
 
+    assert(pin < k->pin_count);
+
     if (!visit_type_GpioPinState(v, name, &state, errp)) {
         return;
     }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= k->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
 
     /* Only input-configured pins can be driven by an external device. */
     config_reg = PCA9535_CONFIG0 + (pin / 8);
     if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
         qemu_log_mask(LOG_UNIMP,
-                      "%s: pin %d is configured as output, ignoring set\n",
+                      "%s: pin %" PRIdPTR " is configured as output, "
+                      "ignoring set\n",
                       s->description, pin);
         return;
     }
@@ -549,14 +523,14 @@ static void pca955x_pin_init(PCA955xClass *k)
             object_class_property_add(OBJECT_CLASS(k), name,
                                       "str", &Pca9552LedState_type_info,
                                       pca955x_get_led, pca955x_set_led,
-                                      NULL, NULL);
+                                      NULL, (void *)(uintptr_t)ix);
         } else {
             /* GPIO variant: expose the pin logic level as pin%d. */
             name = g_strdup_printf("pin%d", ix);
             object_class_property_add(OBJECT_CLASS(k), name,
                                       "str", &GpioPinState_type_info,
                                       pca955x_get_pin, pca955x_set_pin,
-                                      NULL, NULL);
+                                      NULL, (void *)(uintptr_t)ix);
         }
         g_free(name);
     }
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index e2d481866f..d987b16cd0 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -173,18 +173,10 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     PCA9554State *s = PCA9554_BASE(obj);
-    int pin, rc;
+    uintptr_t pin = (uintptr_t)opaque;
     GpioPinState state;
 
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
+    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
 
     /*
      * Report the physical pin level. The input register is kept in sync by
@@ -200,28 +192,22 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     PCA9554State *s = PCA9554_BASE(obj);
-    int pin, rc, val;
+    uintptr_t pin = (uintptr_t)opaque;
+    int val;
     uint8_t mask;
     GpioPinState state;
 
+    assert(pin < PCA9554_BASE_GET_CLASS(s)->pin_count);
+
     if (!visit_type_GpioPinState(v, name, &state, errp)) {
         return;
     }
-    rc = sscanf(name, "pin%2d", &pin);
-    if (rc != 1) {
-        error_setg(errp, "%s: error reading %s", __func__, name);
-        return;
-    }
-    if (pin < 0 || pin >= PCA9554_BASE_GET_CLASS(s)->pin_count) {
-        error_setg(errp, "%s invalid pin %s", __func__, name);
-        return;
-    }
 
     if (s->hw_dir) {
         /* Warn and ignore if the guest has configured this pin as output */
         if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
             qemu_log_mask(LOG_UNIMP,
-                          "%s: pin %d is configured as output, "
+                          "%s: pin %" PRIdPTR " is configured as output, "
                           "ignoring external set\n",
                           s->description, pin);
             return;
@@ -290,7 +276,7 @@ static void pca9554_pin_init(PCA9554Class *pc)
         object_class_property_add(OBJECT_CLASS(pc), name,
                                   "str", &GpioPinState_type_info,
                                   pca9554_get_pin, pca9554_set_pin,
-                                  NULL, NULL);
+                                  NULL, (void *)(uintptr_t)pin);
         g_free(name);
     }
 }
-- 
2.55.0


