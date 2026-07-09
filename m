Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4843C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi58D-0008EW-0s; Fri, 10 Jul 2026 02:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi58A-0008Dv-V7; Fri, 10 Jul 2026 02:54:38 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi588-0001QM-Ns; Fri, 10 Jul 2026 02:54:38 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id E36922003CA;
 Fri, 10 Jul 2026 08:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783666473;
 bh=ToGYoeQq6hYz/IP1kPqkClccSwvZPQbTO/IYBcwXWv4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=paKyMSu55luiY5d8DyywUgvJ9UKfGysGA1YO85fIjQEAmCsDrVMp07COK7gp7efOe
 4IJ80XtcvnoV6vYIivt/4DbPw139T5shc3Vxcb6qvbQ4c4ypK3yHtJ9gFzFEAXofQX
 XefW5i8SWAWv5EeMHUi+Z1r1w6hQLedO3LTB8xXbT+Fh5GQg+FiCAfOxtRRjqvBBM2
 hszV5IPlruA/Y5xxnR1yqRUlghYNCdknuqkawp2e9iY6jFfZYNMrX7j9hFDzcrsmkJ
 G9jt74KjY22Yz7LHgDXjJaN2ERX9UXtrrHdgK9EI3BHTH0hwkgpuksIJLoMLS4L3qq
 NO7EgMpE0MnkQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:15 +0200
Subject: [PATCH 23/29] tests/qtest: pca9554: test the PCA9536 4-bit variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-23-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=3824;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=ToGYoeQq6hYz/IP1kPqkClccSwvZPQbTO/IYBcwXWv4=;
 b=EdnSyM14ah+fr5x+uLTcqdZauPe0qFxLQvWdgwDYzZZCuCC3yIhtMvYLNYHcjWJrxoJW79A4j
 jrigj7P6jrAA4qOLWkwCBnbdNajwx2cjRolPhi+FRaPPLo7PfZYe7aH
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

The PCA9536 shares the PCA9554 register map and code path but exposes
only four pins. Add a pca9536 node and check its reset defaults and
output-to-input reflection are masked to the low nibble.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9554-test.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index 0da1f3304b..5366e71984 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -129,6 +129,66 @@ static void test_no_autoincrement(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x33);
 }
 
+/*
+ * The PCA9536 shares the PCA9554 register map but only has four pins, so its
+ * reset defaults and pin logic are masked to the low nibble.
+ */
+static void test_pca9536_reset_defaults(void *obj, void *data,
+                                        QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x0F);
+}
+
+/* Only the four low pins are driven; the upper nibble stays low. */
+static void test_pca9536_output_drives_input(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0x0A);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0A);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+}
+
+/*
+ * The four upper bits address pins that do not exist on the PCA9536, so writes
+ * to the register map discard them: the writable registers read back with bits
+ * [7:4] cleared, and driving them onto the pins never surfaces in INPUT.
+ */
+static void test_pca9536_ignores_upper_bits(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* Bits [7:4] are dropped on write; bits [3:0] survive. */
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFA);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0A);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xF5);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x05);
+
+    i2c_set8(dev, PCA9554_CONFIG, 0xF3);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x03);
+
+    /*
+     * With all four pins as outputs, driving 0xFF only affects the low
+     * nibble.
+     */
+    i2c_set8(dev, PCA9554_POLARITY, 0x00);
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -148,6 +208,16 @@ static void pca9554_register_nodes(void)
     qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
                  NULL);
     qos_add_test("no-autoincrement", "pca9554", test_no_autoincrement, NULL);
+
+    qos_node_create_driver("pca9536", i2c_device_create);
+    qos_node_consumes("pca9536", "i2c-bus", &opts);
+
+    qos_add_test("reset-defaults", "pca9536", test_pca9536_reset_defaults,
+                 NULL);
+    qos_add_test("output-drives-input", "pca9536",
+                 test_pca9536_output_drives_input, NULL);
+    qos_add_test("ignores-upper-bits", "pca9536",
+                 test_pca9536_ignores_upper_bits, NULL);
 }
 
 libqos_init(pca9554_register_nodes);

-- 
2.50.1


