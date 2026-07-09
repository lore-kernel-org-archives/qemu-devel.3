Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C07C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whun8-0004q8-9y; Thu, 09 Jul 2026 15:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whun5-0004pS-T9; Thu, 09 Jul 2026 15:52:11 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whun3-0006zx-Oy; Thu, 09 Jul 2026 15:52:11 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id DB1E22003D0;
 Thu,  9 Jul 2026 21:51:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783626726;
 bh=zj2qZ0WihFT8F4GCJiG8hQHSvDqkt/mlbObPRyNVzgM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=obBz7E/GlOievvP/Rx+5Pya9aNDdWX5fIrKm4MGnlt7cWAMRDHz5noXQFv52w5lPK
 vB2ak+ENuwfZOVPlmZXuhlggWPQj8nx1XdPvG23HiNo87HN0OKyiv/2B50ovYDxiR1
 X+p0X4TIi79EEFyYDFWmcjCfPD4NO3cTAN3Bma6hSbLutbT6f8pY4yfQF6C0wwqXOV
 YWEybsxwDBLq+xmo+tHgdACE+gNVjG3OLVwdpyL2ZZBLTLP0nDNz0GQXtFY8uxmxFH
 cvtF4RBLXtsVMW6IwZALp6RXFXSQN5ymmLR9qq/eenFhwse+KQooRbIhLYt+JAlt+P
 fxekv5Sr65rwQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:13 +0200
Subject: [PATCH 21/29] tests/qtest: pca9554: test polarity inversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-21-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2529;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=zj2qZ0WihFT8F4GCJiG8hQHSvDqkt/mlbObPRyNVzgM=;
 b=/3uVLwFx49BRgP7QMvMrvoruqwxSHGXCBARNeetVSbbd7YWBqp+bp5FpUjVRFz++W8LcYempW
 AunNMU3Ugc7DPaemPTIltdqDtxQQBU47LUbP/NvmZiVnL+MgiDBlMI+
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

Verify that the polarity register inverts the value read back from the
INPUT register, both on pulled-up inputs and on output-driven pins, while
leaving the OUTPUT register itself unchanged.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9554-test.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index ce6e90f3f8..74237df611 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -67,6 +67,41 @@ static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
 }
 
+/*
+ * Polarity inversion: reading INPUT returns the XOR of the pin levels and the
+ * polarity register.
+ */
+static void test_polarity_inversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xF0);
+}
+
+/* Polarity inversion combined with output-driven pins. */
+static void test_polarity_with_output(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    i2c_set8(dev, PCA9554_OUTPUT, 0xA5);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xA5);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x5A);
+
+    /* Inversion only affects the INPUT read, not the OUTPUT register. */
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xA5);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -81,6 +116,10 @@ static void pca9554_register_nodes(void)
     qos_add_test("output-drives-input", "pca9554", test_output_drives_input,
                  NULL);
     qos_add_test("input-pullup", "pca9554", test_input_pullup, NULL);
+    qos_add_test("polarity-inversion", "pca9554", test_polarity_inversion,
+                 NULL);
+    qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
+                 NULL);
 }
 
 libqos_init(pca9554_register_nodes);

-- 
2.50.1


