Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0558FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtn2-0004YB-VL; Thu, 09 Jul 2026 14:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtn0-0004Wq-Tn; Thu, 09 Jul 2026 14:48:02 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whtmy-0000Wl-40; Thu, 09 Jul 2026 14:48:02 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 298B720039C;
 Thu,  9 Jul 2026 20:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783622874;
 bh=C3nHcAmj9A3YNaJ7DdouWS3LUMsrvhh0ZmF5sgyLU58=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PmSEFDoZ8RVWFSLm2G1apEPP/K5FHZBxTxFyo6llxwn5f8NvdQ7rIv0TGh1Fi2USV
 FbozL7kBoXbZn2yIxarZFF6PFHRwj2Eyb8a7xfzmq1Mo/dqo8AGaeZq7fzkjNLQul5
 2qKiScRRILjJvEpR0N5CxgdY6ByqGTDRMzGT11o0Jfk95Sh7Szr6zgA/WK06w1snFB
 IyXzCQlspgKCohAQV5qvNMRFG8xywui26wsQJ9kzUGLJz9yCzIi65xnsu5byI8Wp3n
 s10/aum8m66twH36tisfSmTrboOp9DtGb9lKqCWG8FbseBOKS+lr0zXZpHXwWzN6ew
 lAi7kncN4o3Kw==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:09 +0200
Subject: [PATCH 17/29] hw/gpio: pca9554: reflect push-pull outputs in the
 input register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-17-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2813;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=C3nHcAmj9A3YNaJ7DdouWS3LUMsrvhh0ZmF5sgyLU58=;
 b=3vmnIuMkbeoPJSqkz919rsJPgIxSgX2plfPHUr+Bh9rPX1F2S5VdW3bgiUwcalD5uIFyJNbKB
 LAevQdliOe3AsvukvZlyPSIUu0wCF9QKGEnj6Rk/9s8odSpe4djSgoh
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

pca9554_update_pin_input() derived the pin level from CONFIG | OUTPUT,
which treated an output driven high as Hi-Z and let ext_state pull it
low. The PCA9554/PCA9536 output stage is push-pull, so a pin configured
as an output drives the OUTPUT register level regardless of any external
agent. Reflect the output value directly for output pins and keep the
pull-up/ext_state behaviour for input pins, matching the PCA9555 GPIO
variant.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9554.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index ed38fe102b..d4746719f9 100644
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
2.50.1


