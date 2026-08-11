Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EBFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPQ-00063C-Jq; Tue, 11 Aug 2026 12:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOo-0005NO-6L
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOm-00011A-Ee
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zEKEUBOfHGvnR0GIKmV/19amwhRg8zg07zwtwRx1aE=;
 b=Xhp+PkUDK+V7aDgWxVVHQOt+jfFXtL+/v/jo41DeZP+4g0s58uDCviw9CJUh3Wdt+SkRwR
 Otuzj28T+Z3kdIZsuQREeInKqvOfjhGtNwJHX6t9g2cIkM31+Yl3j06N3/AeQ3cvqMC/ja
 TgIXXV6NLcqAMn7eOEr4xwUaE26JbLo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-Kibh0y2FOC-5xthVfd_QJA-1; Tue,
 11 Aug 2026 12:31:13 -0400
X-MC-Unique: Kibh0y2FOC-5xthVfd_QJA-1
X-Mimecast-MFC-AGG-ID: Kibh0y2FOC-5xthVfd_QJA_1786465871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B599F195608A; Tue, 11 Aug 2026 16:31:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06361195DF91; Tue, 11 Aug 2026 16:31:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 41/83] hw/gpio: pca9552: conform GPIO command handling to the
 datasheet
Date: Tue, 11 Aug 2026 18:28:56 +0200
Message-ID: <20260811162938.1403216-42-clg@redhat.com>
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

The PCA9535/PCA9555 GPIO expanders share the PCA955X command dispatch
path with the PCA9552 LED blinker, but their register access differs from
the LED variant:

  - Auto-increment happens on every access and toggles bit 0 so the
    pointer stays within the addressed register pair (input, output,
    polarity, config); there is no AI enable bit.

  - The command byte only decodes 3 bits, so addresses beyond the last
    register alias back into the 8-register window instead of faulting.

Branch the auto-increment and command-decode logic on has_led_support so
the GPIO variants follow their datasheet while the PCA9552 behaviour is
left untouched.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-8-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 24f646541582..54a5945d9252 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -259,14 +259,26 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 }
 
 /*
- * When Auto-Increment is on, the register address is incremented
- * after each byte is sent to or received by the device. The index
- * rollovers to 0 when the maximum register address is reached.
+ * Advance the command pointer after each byte sent to or received from the
+ * device.
+ *
+ * The LED variant auto-increments only when the AI bit (bit 4) is set in the
+ * command byte, rolling over to 0 once the maximum register address is
+ * reached.
+ *
+ * The GPIO variants auto-increment on every access, toggling bit 0 so the
+ * pointer stays within the addressed register pair
+ * (input/output/polarity/config), as specified by their datasheet.
  */
 static void pca955x_autoinc(PCA955xState *s)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(s);
 
+    if (!k->has_led_support) {
+        s->pointer ^= 0x1;
+        return;
+    }
+
     if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
         uint8_t reg = s->pointer & 0xf;
 
@@ -275,12 +287,25 @@ static void pca955x_autoinc(PCA955xState *s)
     }
 }
 
+/*
+ * The LED variant addresses its registers with a 4-bit command field, while
+ * the GPIO variants only decode 3 bits (the command wraps into the 8-register
+ * window).
+ */
+static inline uint8_t pca955x_cmd_reg(PCA955xState *s)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+
+    return s->pointer & (k->has_led_support ? 0xf : 0x7);
+}
+
 static uint8_t pca955x_recv(I2CSlave *i2c)
 {
     PCA955xState *s = PCA955X(i2c);
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
     uint8_t ret;
 
-    ret = pca955x_read(s, s->pointer & 0xf);
+    ret = pca955x_read(s, pca955x_cmd_reg(s));
 
     /*
      * From the Specs:
@@ -292,7 +317,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)
      * I don't know what should be done in this case, so throw an
      * error.
      */
-    if (s->pointer == PCA9552_AUTOINC) {
+    if (k->has_led_support && s->pointer == PCA9552_AUTOINC) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Autoincrement read starting with register 0\n",
                       __func__);
@@ -312,7 +337,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t data)
         s->pointer = data;
         s->len++;
     } else {
-        pca955x_write(s, s->pointer & 0xf, data);
+        pca955x_write(s, pca955x_cmd_reg(s), data);
 
         pca955x_autoinc(s);
     }
-- 
2.55.0


