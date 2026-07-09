Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3533C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsgs-0004CY-Nr; Thu, 09 Jul 2026 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whsgr-0004C8-K6; Thu, 09 Jul 2026 13:37:37 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whsgp-0005Lr-LD; Thu, 09 Jul 2026 13:37:37 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 49A9A2003CC;
 Thu,  9 Jul 2026 19:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783618652;
 bh=hWPmQbsMGQSCYqdLzbiz6Ewys/hHwu+W2BoVRSNmgdk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Da00rlUvY4JATi9UJwwaRK4PwlZ+rVJ9okB3d4zdIVJ22u1o5Y+QhnwFYAcZVpFGW
 2Z568VUdfg2aztO2CoiNp1DyJgctpCy6DLMxNNLqZTTvJ/WErRZMmQ1NY85QUrjlLi
 b9YU+7ahwHgpTtjfB1V3k3WOTmE1II0GO1s/QGweSJ7P86Y+U3FWeX0MfksGErXpJG
 U7K26TqUR4wC30PH5o+mWpW38sAhxxXDZJZxZ9IGgAcm3JcpnbvgB54q6a9vv3RI5b
 lgMdvvSx7tVcYBxiu9gBarC3KCv9GNieZq7EujQQ/w6uDztjk5BFYc8A+m6SQIfAmw
 X90FYGXUoXjJQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:06 +0200
Subject: [PATCH 14/29] tests/qtest: pca9552: test behaviour specific to the
 LED variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-14-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610579; l=4547;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=hWPmQbsMGQSCYqdLzbiz6Ewys/hHwu+W2BoVRSNmgdk=;
 b=7wa9FfIqAtOFagoeTTQbxYvPIaYEgEUswuEKrHE/QEOpQL1aPVIPzkClI93uZP0OQl/evXZMW
 8k7X4PTK1BCDHaN255HDpMVmRDHIfub+XDZ3bj6Hzz+xloxpkcUKqzH
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

The PCA9552 shares its device model with the PCA9535/PCA9555 GPIO
expanders but decodes registers differently. Add tests for the behaviour
that is specific to the LED variant and diverges from the PCA9555:

  - the power-on reset defaults of the prescaler, PWM and LED-selector
    registers;
  - the prescaler/PWM registers (2-5), which are OUTPUT/POLARITY on the
    PCA9555, as plain read/write storage;
  - the auto-increment, which only advances when the AI command bit is set
    and wraps modulo the full 10-register map (rather than toggling bit 0
    within a register pair);
  - the 4-bit command decode, where an out-of-range register reads back
    0xFF instead of aliasing into the register window.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9552-test.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index 74749576923..3718dfbd227 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -77,6 +77,76 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(value, ==, 0xEF);
 }
 
+/* Verify the power-on reset defaults. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    /* Prescalers, PWM duty cycles and LED selectors (all LEDs off) */
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM0), ==, 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PSC1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_PWM1), ==, 0x80);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS0), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS1), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS2), ==, 0x55);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_LS3), ==, 0x55);
+
+    /* All LEDs off, so every pin floats high through its pull-up */
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(i2cdev, PCA9552_INPUT1), ==, 0xFF);
+}
+
+/*
+ * The PCA9552 only advances the command pointer when the AI bit is set, and
+ * it wraps modulo the full 10-register map.
+ */
+static void test_autoinc_requires_ai_bit(void *obj, void *data,
+                                         QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint8_t reg;
+    uint8_t resp;
+
+    /*
+     * With the AI bit, reading from LS3 (register 9) rolls over to INPUT0
+     * (register 0), not to a sibling in a register pair. All LEDs are off
+     * after reset so the input ports read 0xFF.
+     */
+    reg = PCA9552_LS3 | PCA9552_AUTOINC;
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, &resp, 1); /* LS3 */
+    g_assert_cmphex(resp, ==, 0x55);
+    qi2c_recv(i2cdev, &resp, 1); /* wraps to INPUT0 */
+    g_assert_cmphex(resp, ==, 0xFF);
+    qi2c_recv(i2cdev, &resp, 1); /* INPUT1 */
+    g_assert_cmphex(resp, ==, 0xFF);
+
+    /*
+     * Without the AI bit the pointer must not advance: repeated reads keep
+     * returning the same register.
+     */
+    i2c_set8(i2cdev, PCA9552_LS0, 0x54);
+    reg = PCA9552_LS0;
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, &resp, 1);
+    g_assert_cmphex(resp, ==, 0x54);
+    qi2c_recv(i2cdev, &resp, 1);
+    g_assert_cmphex(resp, ==, 0x54);
+}
+
+/*
+ * The PCA9552 decodes a 4-bit command and has no register past LS3 (9), so
+ * addressing register 0x0A reads back 0xFF.
+ */
+static void test_command_out_of_range(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(i2cdev, 0x0A), ==, 0xFF);
+}
+
 static void pca9552_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -89,5 +159,11 @@ static void pca9552_register_nodes(void)
 
     qos_add_test("tx-rx", "pca9552", send_and_receive, NULL);
     qos_add_test("rx-autoinc", "pca9552", receive_autoinc, NULL);
+    qos_add_test("reset-defaults", "pca9552", test_reset_defaults, NULL);
+    qos_add_test("autoinc-requires-ai-bit", "pca9552",
+                 test_autoinc_requires_ai_bit, NULL);
+    qos_add_test("command-out-of-range", "pca9552", test_command_out_of_range,
+                 NULL);
 }
+
 libqos_init(pca9552_register_nodes);

-- 
2.50.1


