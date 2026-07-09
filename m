Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47883C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whr8Z-00041U-5s; Thu, 09 Jul 2026 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whr8X-00041L-FH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:58:05 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whr8V-0002VM-AM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:58:05 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0A87220039C
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2026 17:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783612681;
 bh=5Z31IGvHoQJpOOVUEtYuqMr4o0UKYDZH+6sdNVkwanU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hrzxIuRa3M6nQt/DJ7eF6zcmUnWq3QegwueBfealuOI8eRLk81kP/T3HGwGogpWhy
 5nemmZJuJwiNbkilfr4lY0RlWjsZl46EqZBwbHtcT/l96UvQXlmk6mxvuw8RCajmJQ
 YKM3MU8QmkRJVW6TNlEi83c++v4yFY0rlY31kz4TXD9RNZxdklD+3jwNLh2iZKJajr
 FniQAibUGDmJ+2FwHyuaPNlYpF1LVKR/h2psOAcqjLy0IqiaXhvYvuwCnmBJHquFcY
 ERBULsoDvSYSx9sd0cgKu1a1rqX8HQEBhXI5iIBSqGDYWA1ADUoijq1cs1iKNEaRwh
 RBoUHLfTsmNYQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:03 +0200
Subject: [PATCH 11/29] tests/qtest: pca9555: test output-to-input
 reflection and pull-ups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=3988;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=5Z31IGvHoQJpOOVUEtYuqMr4o0UKYDZH+6sdNVkwanU=;
 b=5QLWQXaK+nrzCuL1diD0o7j1Kf/37bBcB+SHcAxAEFpHct+V6wChdTVXBc7CbeWq/6BxssqHa
 VwNRWyp8BoeDadGn8eJpPYyo/QnG9FCrRyF1EkqyYpsP5lAtunkjoP+
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add tests covering the pin I/O semantics of the expander: output-driven
pins reflected in the input register, the pull-up seen on input-configured
pins, and the independence of the two 8-bit ports.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9555-test.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 5945c3441e..6b085702c3 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -28,6 +28,77 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
 }
 
+/*
+ * When a pin is configured as output and driven low (output=0, config=0),
+ * the input register should reflect 0 for that pin.
+ * When driven high (output=1, config=0), input should reflect 1.
+ * When configured as input (config=1), PCA5555 pull-up makes it read 1.
+ */
+static void test_output_drives_input(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0xF0);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+}
+
+/*
+ * When all pins are inputs (config=0xFF) and no external driver,
+ * PCA9555 pull-ups should make the input register read all ones.
+ * Switching a pin to output mode with output=0 should drive it low.
+ */
+static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+}
+
+/*
+ * Test that both ports are independent: changing port 0 registers
+ * should not affect port 1 and vice versa.
+ */
+static void test_port_independence(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0xAA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -39,6 +110,10 @@ static void pca9555_register_nodes(void)
     qos_node_consumes("pca9555", "i2c-bus", &opts);
 
     qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
+    qos_add_test("output-drives-input", "pca9555", test_output_drives_input,
+                 NULL);
+    qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
+    qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
 }
 
 libqos_init(pca9555_register_nodes);

-- 
2.50.1


