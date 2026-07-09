Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDF7C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsg4-0002uJ-EK; Thu, 09 Jul 2026 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whsfo-0002qw-SJ; Thu, 09 Jul 2026 13:36:36 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whsfm-00056d-AD; Thu, 09 Jul 2026 13:36:32 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id E8FD92003CA;
 Thu,  9 Jul 2026 19:36:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783618587;
 bh=r4IiWSSGe6WBhfajnFqesOnQQ7ucG38L+b+DSx0TKOs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=F5ebd0t0+iftY/PQYbJFVGZ0GVz1oStBeTixQkAX42GUttv+sA+1W2r7WLSZeWF/m
 Geupnl17XoEfd73u6nkiX5o3vZI1kGlyU8CPB4Hh5DxIbCAx8BbPz6A3xzXSfU9Fr7
 gqvNag0/OMJk4/OvRdghcYj3jORrOQ+Cjjd/ZD5l64CDctJKhcPgDKKZ4V1YhIleiT
 G12GaqIMgGiCTIrCBSrY0mWiwod3mDAGYICcQZyLxBpZpTILunDONCT9G+GqHSIZ9k
 x86qxYKcsinLrrLgOzJL6Esp6G4xFstzkBirOnoeLXKxrfIwHmd0g1a1Zphw/3gDt7
 hj1nOAQPuhe3Q==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:05 +0200
Subject: [PATCH 13/29] tests/qtest: pca9555: test auto-increment and
 command wrapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-13-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=4098;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=r4IiWSSGe6WBhfajnFqesOnQQ7ucG38L+b+DSx0TKOs=;
 b=7qwSGsdgZu/Fj9Z5A6RvklU1lU+N+NZwTU0obd4maSQ2hktjSufHLKMeLY/gLWn60TcEN7LTn
 aflMN70x/wqBNoOwXiZ5RgWGXJfqcDCrTTJG9pJGtljRuJ47aDM6DUK
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add tests for the I2C command protocol of the GPIO variant: the
auto-increment that toggles bit 0 within a register pair on reads and
writes, and the 3-bit command wrapping that aliases out-of-range register
addresses back into the register window.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9555-test.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 2afa061bd2..84d771bcbb 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -139,6 +139,87 @@ static void test_polarity_with_output(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
 }
 
+/*
+ * The PCA9555 auto-increments by toggling bit 0 of the command pointer
+ * within a register pair. Reading two bytes from INPUT0 should yield
+ * INPUT0 then INPUT1.
+ */
+static void test_auto_increment_read(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
+
+    i2c_read_block(dev, PCA9535_INPUT0, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0xAA);
+    g_assert_cmphex(buf[1], ==, 0x55);
+
+    i2c_read_block(dev, PCA9535_OUTPUT0, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0xAA);
+    g_assert_cmphex(buf[1], ==, 0x55);
+}
+
+/*
+ * Auto-increment write: writing two data bytes after a command byte
+ * should write to port 0 then port 1 of the addressed register pair.
+ */
+static void test_auto_increment_write(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    buf[0] = 0x12;
+    buf[1] = 0x34;
+    i2c_write_block(dev, PCA9535_OUTPUT0, buf, 2);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x12);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0x34);
+
+    buf[0] = 0x0F;
+    buf[1] = 0xF0;
+    i2c_write_block(dev, PCA9535_CONFIG0, buf, 2);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG0), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xF0);
+}
+
+/*
+ * Auto-increment toggles within the pair: starting from port 1 should
+ * wrap back to port 0 (toggle bit 0).
+ */
+static void test_auto_increment_toggle(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
+
+    i2c_read_block(dev, PCA9535_OUTPUT1, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0x55);
+    g_assert_cmphex(buf[1], ==, 0xAA);
+}
+
+/*
+ * Verify the command byte wraps at 3 bits: register addresses
+ * beyond 7 should alias to the same register (bits [2:0] only).
+ */
+static void test_command_wrapping(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x42);
+
+    g_assert_cmphex(i2c_get8(dev, 0x0A), ==, 0x42);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -158,6 +239,13 @@ static void pca9555_register_nodes(void)
                  NULL);
     qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
                  NULL);
+    qos_add_test("auto-increment-read", "pca9555", test_auto_increment_read,
+                 NULL);
+    qos_add_test("auto-increment-write", "pca9555", test_auto_increment_write,
+                 NULL);
+    qos_add_test("auto-increment-toggle", "pca9555", test_auto_increment_toggle,
+                 NULL);
+    qos_add_test("command-wrapping", "pca9555", test_command_wrapping, NULL);
 }
 
 libqos_init(pca9555_register_nodes);

-- 
2.50.1


