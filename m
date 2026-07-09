Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7C3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrFW-00081q-LR; Thu, 09 Jul 2026 12:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whrFU-0007wU-EY
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:05:16 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whrFQ-0005JU-Ic
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:05:15 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 54A7620039E
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2026 18:05:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783613110;
 bh=OnsmkUn5MF+iN15cD+qVI7EFy2XS1sFgY52LuhiYnok=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FVqBFciDFbFWADIkJA70CeM9yydr3O3qwmVJ13/v4rw0ZVxQQ2WjqWK5DJamybPOq
 6zxD0r+xIRh/rqBecGwEYzX5L13Dm272It2jSru/9fHjE/OW0rtbeX0CXNxG4UZemR
 DqFF5uOGWaTU0y+ywjD7eSmD+PvwQRqOd+HJYpQJ9sxcdnC3kxAOUnV/xmxw4F7KJM
 bdXL00ed4KbGXR0q8SgOS0JGKtPzcoW1RrwGu5mTJETd6Jkhu6LG2JSXAKsoUktIxQ
 zByxvyOI0mit6CPENXfSss51NPXAzWwjiJPqGZ2dt+kINRxiDZb7A++dYNBkWfjE6/
 tJ/yD1QqZlg3w==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:04 +0200
Subject: [PATCH 12/29] tests/qtest: pca9555: test polarity inversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-12-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=2701;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=OnsmkUn5MF+iN15cD+qVI7EFy2XS1sFgY52LuhiYnok=;
 b=V10WlXWlT58Se5mRTVubpMa0xD4Kv/J4kSwyGaoKkRQGflY+V8wsTG4d7Wmv/OK8Gx0T9WVww
 T8YFWtwBjFMAzlmw+75xjfWTicfyZXyhnnV+1lOhRDPUHWEoq0MYKPa
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

Add tests for the polarity inversion register: the inversion is applied
when reading the INPUT register, both for input pins (pull-up) and for
output-driven pins, and it does not affect the OUTPUT register readback.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 6b085702c3..2afa061bd2 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -99,6 +99,46 @@ static void test_port_independence(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
 }
 
+/*
+ * Polarity inversion: reading INPUT with polarity bits set should
+ * return the XOR of the actual input state and the polarity register.
+ */
+static void test_polarity_inversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xF0);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_POLARITY1, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0x55);
+}
+
+/* Polarity inversion combined with output-driven pins. */
+static void test_polarity_with_output(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xA5);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xA5);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x5A);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -114,6 +154,10 @@ static void pca9555_register_nodes(void)
                  NULL);
     qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
     qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
+    qos_add_test("polarity-inversion", "pca9555", test_polarity_inversion,
+                 NULL);
+    qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
+                 NULL);
 }
 
 libqos_init(pca9555_register_nodes);

-- 
2.50.1


