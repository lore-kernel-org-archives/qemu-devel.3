Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A5FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4EK-0004HU-SX; Fri, 10 Jul 2026 01:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi4EG-0004H8-96; Fri, 10 Jul 2026 01:56:52 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi4EE-0003kq-BO; Fri, 10 Jul 2026 01:56:52 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 80E3A20039E;
 Fri, 10 Jul 2026 07:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783663006;
 bh=1FWudNwoWordeWSZyvfW98X4SA6Mgp1WBnV3LvHWGGU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=R6eelTkMfQHmM/6abc+B6yHq8MfmBUq/j6ase7egatgb/xZODH8XP/PSCF+Vd5qxZ
 wV64vMXQT4vnfw5mFaiYtp/Af25pn1UaDArofuL+DhPrSo+WBqP3JUK+D8ft5aQnnU
 awvX5Wtqvs5xYEhkpyzXj3VpxN7GK7cX2RcQ8CHFPHZWc/2KUvcj2EGSceN5/LknWK
 qkIjjksT6Ms6HM9CjMDgh7GfXDh0oHV2xeckBtcyKWJJH2V4hnG1pGVPByR4+ord6l
 pM3kKK7lc5ip0/IUACNeu9DaMSc8BOb9qyBHhMr/9q0K2sXbRiPRs0Z1mGVr3SArwl
 pd18qON3X59EQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:12 +0200
Subject: [PATCH 20/29] tests/qtest: pca9554: test output-to-input
 reflection and pull-ups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-20-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2785;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=1FWudNwoWordeWSZyvfW98X4SA6Mgp1WBnV3LvHWGGU=;
 b=AdTfLXXP7xCX+e9XJbCilO0/GWvLUwE/gqvt1N40UL1atpAYjSCCkjm/m7XU7teETDwNRgF/D
 iNL9b8IzEIjBrgMVPnHVW4IqjkW/glP9eGpsDziDstov4GygHeFfFXQ
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

Check that a pin configured as output drives its OUTPUT register level
onto the pin (push-pull) as reflected by the INPUT register, and that a
pin configured as input floats high through its pull-up.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9554-test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index a5f213a59c..ce6e90f3f8 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -25,6 +25,48 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0xFF);
 }
 
+/*
+ * A pin configured as output (config=0) drives its OUTPUT register level onto
+ * the pin (push-pull), which the INPUT register reflects. A pin configured as
+ * input (config=1) floats high through its pull-up.
+ */
+static void test_output_drives_input(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* Low nibble output, high nibble input (pull-up). */
+    i2c_set8(dev, PCA9554_CONFIG, 0xF0);
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFA);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFA);
+
+    /* All outputs, driven low then high. */
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+}
+
+/*
+ * With all pins configured as inputs the pull-ups make the INPUT register read
+ * all ones regardless of the OUTPUT register; switching a pin to output with
+ * output=0 drives it low.
+ */
+static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -36,6 +78,9 @@ static void pca9554_register_nodes(void)
     qos_node_consumes("pca9554", "i2c-bus", &opts);
 
     qos_add_test("reset-defaults", "pca9554", test_reset_defaults, NULL);
+    qos_add_test("output-drives-input", "pca9554", test_output_drives_input,
+                 NULL);
+    qos_add_test("input-pullup", "pca9554", test_input_pullup, NULL);
 }
 
 libqos_init(pca9554_register_nodes);

-- 
2.50.1


