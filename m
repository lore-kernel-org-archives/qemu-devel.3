Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1ACC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqeC-0002V7-Rr; Thu, 09 Jul 2026 11:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqe9-0002Mb-PR; Thu, 09 Jul 2026 11:26:41 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqe5-0000na-OU; Thu, 09 Jul 2026 11:26:41 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8AC0A2003B4;
 Thu,  9 Jul 2026 17:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610796;
 bh=Cs/cpJkcwVWL+K7NraoBVOBmQF4a5TCwGsyZOgRyaVw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=calB6dEMNpVi02yeSa5k35xx+YVTcyzjNyF6T8is2gu0ETqA4h7B1UZhWtbXIqbD3
 44sXCh6TID+/env95z833HLEz8SfKikmZZeNQ5Z5pvC5Rh/GxV69q3C1fZ0KKv0TZo
 cGq3Vk6OoncOKMDnrKbP1ur+CbtvCKzIv5BJ/akDQeaanWC1N8R/SVCS4dE3TK0xEQ
 nILRVhjM0gryFXS5dyac0OnYer6d4QwGF3M0BPPgU369UfWJ78XT0Pye13NGgKGBVI
 tMqRCXXfPYvzxwFZN/GjE7AORonPnU4KkUMkD7hy2tidinJ75izmZjiqHw4ZIyL0t2
 /Srnmjgo+4rdQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:45 +0200
Subject: [PATCH 07/29] hw/gpio: pca9552: apply input polarity inversion on read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-7-814575bc076b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=2796;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Cs/cpJkcwVWL+K7NraoBVOBmQF4a5TCwGsyZOgRyaVw=;
 b=eW4fJi1wIQKqkwCeiYDR6dpymvE4IENIAC/zVDIJj1FNHIICgSe7vzpJcoNqX3VNbMNI9CPUw
 VTvsG3e2JaZD+HX1dD+macSKsul3YLP4MyN0nOe0w6ULWIWcjxTEpK8
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

The PCA9535 polarity inversion register inverts the value read back from
the input port for every pin, regardless of its direction, and does not
affect the output drive or the physical pin level.

Store the raw pin level in the input register and apply the polarity
inversion when the input port is read, instead of XORing it into the
stored value of output-configured pins only. The interrupt output now
reflects the raw pin level, matching the datasheet.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 66f699bf6a..24f6465415 100644
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
2.50.1


