Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F30C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6ak-0005fd-8d; Fri, 10 Jul 2026 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi6ah-0005fL-Sq; Fri, 10 Jul 2026 04:28:11 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi6ag-0008C7-0f; Fri, 10 Jul 2026 04:28:11 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 072462003D0;
 Fri, 10 Jul 2026 10:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783672087;
 bh=hyBmI2Vm393pvvYJAsZ7U8knPDlelq2X+4zSmoussIM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZCK27AYowhMS5QnlYAOWyvFFpIHx6QCI8ZOatv/mVbCN0XKDxNSkvWyqrjtxNR7Zq
 T8XS51l12aH6NSRjruC7N/0MXwO3F6MH736CE0gtvzHVI6DlG370sM+FplWUslpm1K
 yIlKwO9IzhwkIuLbj43ve1tUb0Ehd9urUyE5Ox3PjZH4eL1cnzFT0vLtv6u2wVvz0O
 v99lr1dWAh/KuWbn+CijcDy9mRyayzYxvFeZoH64Cp0bF42Cx8qf3e7e/WbyWELPyW
 5MvbPdwF4VHLkHd50URxzi+Ts5BjhQBuWg5MDNJVL0UWgedC4v/cZqbV0tOZ39AHGH
 uks0ovvxInv2g==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:21 +0200
Subject: [PATCH 29/29] test/functional: catalina: test PCA9554 IO expander
 via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-29-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610581; l=1727;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=hyBmI2Vm393pvvYJAsZ7U8knPDlelq2X+4zSmoussIM=;
 b=5KwcCBGm8H+8Wjjvy4SWEPoR/MhilYC419xnrqox0pz8rFbPnvF5DaTcICuTcHoPe927SsCN5
 zFbHVOGBE3zC4cnRTmXDa36SttEDL2MUTm/e/XAcoA/uKyywKTKXWY/
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
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

Cover io_expander5 (pca9554@27, behind pca9548@70 channel 6 on i2c1), an
8-bit expander reached through the pca9548 mux.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index cf8a59bd2a..17391164c3 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -22,6 +22,11 @@ class CatalinaMachine(AspeedTest):
     # io_expander0: pca9555@20 on i2c2, a 16-bit expander directly on the bus.
     IOEXP0_QOM = "/machine/soc/i2c/bus[2]/aspeed.i2c.bus.2/0x20"
     IOEXP0_GPIODETECT = r"\[2-0020\]"
+    # io_expander5: pca9554@27 behind pca9548@70 channel 6 on i2c1, an 8-bit
+    # expander. Another expander sits at address 0x27 (pca9555@27 on i2c2), so
+    # it is matched on both its address and its line count.
+    IOEXP5_QOM = "/machine/soc/i2c/bus[1]/aspeed.i2c.bus.1/0x70/i2c.6/0x27"
+    IOEXP5_GPIODETECT = r"-0027] \(8 lines\)"
 
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
@@ -35,6 +40,8 @@ def test_arm_ast2600_catalina_openbmc(self):
 
         # pca9555@20 spans two 8-bit ports (pins 0-7 and 8-15).
         self.check_ioexp(self.IOEXP0_QOM, self.IOEXP0_GPIODETECT, (0, 7, 8, 15))
+        # pca9554@27 is a single 8-bit port.
+        self.check_ioexp(self.IOEXP5_QOM, self.IOEXP5_GPIODETECT, (0, 3, 7))
 
     def check_ioexp(self, qom, gpiodetect, pins):
         # The guest uses these expander lines as inputs (with pull-ups), so

-- 
2.50.1


