Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5FC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO3-0002rP-QG; Tue, 11 Aug 2026 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNm-0001lt-2f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNj-0000mC-1H
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2KWhrg4dHeMM3Jv9F381uV+KY2ER12qVcMpRP64pVQ=;
 b=eSS330msAZVYARCEtqe4t5AyGgL7oGqQc3bX2Xij0t6IK8WdfM0lJ+TacrE+TzHuOXR8dR
 VlsK++k5oP0u699YJcCynMPouitH3w+GKmAXSHaZf/W0r0XRZ74Yr4dmANeS8pXaQqRcju
 oGNiAMFP0qR/Rrago4zVUwk2rk/M0+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-1__h0j2wMKKpNfiKwHy_jQ-1; Tue,
 11 Aug 2026 12:31:10 -0400
X-MC-Unique: 1__h0j2wMKKpNfiKwHy_jQ-1
X-Mimecast-MFC-AGG-ID: 1__h0j2wMKKpNfiKwHy_jQ_1786465869
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AFE01956080; Tue, 11 Aug 2026 16:31:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5F82195DF91; Tue, 11 Aug 2026 16:31:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 40/83] hw/gpio: pca9552: apply input polarity inversion on read
Date: Tue, 11 Aug 2026 18:28:55 +0200
Message-ID: <20260811162938.1403216-41-clg@redhat.com>
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

The PCA9535 polarity inversion register inverts the value read back from
the input port for every pin, regardless of its direction, and does not
affect the output drive or the physical pin level.

Store the raw pin level in the input register and apply the polarity
inversion when the input port is read, instead of XORing it into the
stored value of output-configured pins only. The interrupt output now
reflects the raw pin level, matching the datasheet.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-7-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9552.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 66f699bf6a0b..24f646541582 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -167,9 +167,12 @@ static void pca955x_update_pin_input(PCA955xState *s)
             /* PCA9535: Simple GPIO behavior */
             uint8_t config_reg = PCA9535_CONFIG0 + (i / 8);
             uint8_t output_reg = PCA9535_OUTPUT0 + (i / 8);
-            uint8_t polarity_reg = PCA9535_POLARITY0 + (i / 8);
 
-            /* Check if pin is configured as input */
+            /*
+             * The input register holds the raw pin logic level; the
+             * polarity inversion register is only applied when the input
+             * port is read (see pca955x_read()).
+             */
             if (s->regs[config_reg] & bit_mask) {
                 /* Input mode - reflect external state */
                 if (s->ext_state[i] == PCA9552_PIN_LOW) {
@@ -179,12 +182,8 @@ static void pca955x_update_pin_input(PCA955xState *s)
                 }
             } else {
                 /* Output mode - reflect output register value */
-                uint8_t output_bit = s->regs[output_reg] & bit_mask;
-                uint8_t polarity_bit = s->regs[polarity_reg] & bit_mask;
-
-                /* Apply polarity inversion if set */
                 s->regs[input_reg] = (s->regs[input_reg] & ~bit_mask) |
-                                    ((output_bit ^ polarity_bit) & bit_mask);
+                                     (s->regs[output_reg] & bit_mask);
             }
         }
 
@@ -206,6 +205,18 @@ static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
         return 0xFF;
     }
 
+    /*
+     * On the GPIO variants, reading an input port returns the raw pin
+     * levels XORed with the polarity inversion register, as specified by
+     * the datasheet.
+     */
+    if (!k->has_led_support &&
+        (reg == PCA9535_INPUT0 || reg == PCA9535_INPUT1)) {
+        uint8_t polarity_reg = PCA9535_POLARITY0 + (reg - PCA9535_INPUT0);
+
+        return s->regs[reg] ^ s->regs[polarity_reg];
+    }
+
     return s->regs[reg];
 }
 
-- 
2.55.0


