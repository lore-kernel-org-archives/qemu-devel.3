Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8EDC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOH-0003v7-58; Tue, 11 Aug 2026 12:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOA-0003ax-Px
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpO9-0000s2-32
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/jKHWoHosk9MWohYc5Yj1kHRkMGUHa8KL6bWRx9B/NY=;
 b=JL8yR8KfZbU8UJ87PZPiDCcDMvt4/JO6wCQ/egKmU4UrPbrQJI/ZMiJR/OF0BadEb52nEU
 T5i7i3H0tThmuMWtCfFMNzo0b/6aZO/27tCFzgYu9X1c0ziUNFI3Kll1K7iSbCkCHIjz2N
 JiRPcvV6yclEG8Dhm69jefaHyOfg4f0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-F9M_9wmmPMG-ZjOSikqB-A-1; Tue,
 11 Aug 2026 12:31:32 -0400
X-MC-Unique: F9M_9wmmPMG-ZjOSikqB-A-1
X-Mimecast-MFC-AGG-ID: F9M_9wmmPMG-ZjOSikqB-A_1786465891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BA5F195609E; Tue, 11 Aug 2026 16:31:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97BBB195DF96; Tue, 11 Aug 2026 16:31:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 50/83] hw/gpio: pca9554: reflect push-pull outputs in the input
 register
Date: Tue, 11 Aug 2026 18:29:05 +0200
Message-ID: <20260811162938.1403216-51-clg@redhat.com>
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

pca9554_update_pin_input() derived the pin level from CONFIG | OUTPUT,
which treated an output driven high as Hi-Z and let ext_state pull it
low. The PCA9554/PCA9536 output stage is push-pull, so a pin configured
as an output drives the OUTPUT register level regardless of any external
agent. Reflect the output value directly for output pins and keep the
pull-up/ext_state behaviour for input pins, matching the PCA9555 GPIO
variant.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-17-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/pca9554.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index ed38fe102b18..d4746719f916 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -43,43 +43,32 @@ static void pca9554_update_pin_input(PCA9554State *s)
     int i;
     uint8_t config = s->regs[PCA9554_CONFIG];
     uint8_t output = s->regs[PCA9554_OUTPUT];
-    uint8_t internal_state = config | output;
 
     for (i = 0; i < pc->pin_count; i++) {
         uint8_t bit_mask = 1 << i;
-        uint8_t internal_pin_state = (internal_state >> i) & 0x1;
         uint8_t old_value = s->regs[PCA9554_INPUT] & bit_mask;
         uint8_t new_value;
 
-        switch (internal_pin_state) {
-        case PCA9554_PIN_LOW:
-            s->regs[PCA9554_INPUT] &= ~bit_mask;
-            break;
-        case PCA9554_PIN_HIZ:
+        if (config & bit_mask) {
             /*
-             * pullup sets it to a logical 1 unless
-             * external device drives it low.
+             * Input: the pin is Hi-Z with a pull-up, so it reads high
+             * unless an external device drives it low.
              */
             if (s->ext_state[i] == PCA9554_PIN_LOW) {
                 s->regs[PCA9554_INPUT] &= ~bit_mask;
             } else {
-                s->regs[PCA9554_INPUT] |=  bit_mask;
+                s->regs[PCA9554_INPUT] |= bit_mask;
             }
-            break;
-        default:
-            break;
+        } else {
+            /* Output: the push-pull stage drives the output register level. */
+            s->regs[PCA9554_INPUT] = (s->regs[PCA9554_INPUT] & ~bit_mask) |
+                                     (output & bit_mask);
         }
 
         /* drive the per-pin GPIO output only if the pin level changed */
         new_value = s->regs[PCA9554_INPUT] & bit_mask;
         if (new_value != old_value) {
-            if (new_value) {
-                /* changed from 0 to 1 */
-                qemu_set_irq(s->gpio_out[i], 1);
-            } else {
-                /* changed from 1 to 0 */
-                qemu_set_irq(s->gpio_out[i], 0);
-            }
+            qemu_set_irq(s->gpio_out[i], !!new_value);
         }
     }
 }
-- 
2.55.0


