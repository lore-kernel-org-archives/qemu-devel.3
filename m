Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707CAC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4i2-0005mi-8l; Fri, 10 Jul 2026 02:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi4i1-0005lu-4I; Fri, 10 Jul 2026 02:27:37 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi4hx-0006C6-PR; Fri, 10 Jul 2026 02:27:36 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 430C12003D6;
 Fri, 10 Jul 2026 08:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783664850;
 bh=3FG9kKyoZTVeTCjPeTckm75zaMnjd5I57x1/8cmrneY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=n+4gqvjW3peSCkTfhTgGQPKLAo/499PmexQfj16wQbh0XQGr8Olu+f4wBcMys4h4W
 lK44WkICqBH2OhchtgV5q2m7EOQzj8S2bcgVVmeY8O///LmrsnS54eiZsE6Tb0TvdH
 UXw/IghTZcS8y0597zY0KOiiIuKbSMeOkAeRF92mhjI0Cr5s2S8pdpZR8HLWzK5M71
 guKGKjuC/A7VqIGy/XKpeOcaqcpRic8IgNfLCtDW7T3+DrCo5kdNco4hDNlWoQlbfB
 fHtNOt+zhnR4eOYiybagSAMyQH3bQpPATfYkQnuSfGNeVxwbPFLuN62u/ovhWCcwkh
 Y0BXRToFCFdAQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:14 +0200
Subject: [PATCH 22/29] tests/qtest: pca9554: test absence of command
 auto-increment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-22-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2350;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=3FG9kKyoZTVeTCjPeTckm75zaMnjd5I57x1/8cmrneY=;
 b=NP2hZ7G+v5K1fQrla4PdQQHQYz2QxruqE1eexpvnp4cGa9evcKXNKTC62LwzGKu1yUI91rSNi
 G2w7mq8UQIDDJHXXWjmI72ZAlJfd2pz+9Pwooqn8gb44jbtjfQevv8T
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The PCA9554 selects one of its four registers with a single command byte
and does not auto-increment the register pointer, so a multi-byte I2C
transfer keeps addressing the register chosen by the command byte instead
of walking through the register map.

Add a test covering this: a two-byte read returns the addressed register
twice, and a two-byte write updates only that register, leaving its
neighbour untouched.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/pca9554-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index 74237df611..0da1f3304b 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -102,6 +102,33 @@ static void test_polarity_with_output(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xA5);
 }
 
+/*
+ * The PCA9554 has no auto-increment: the command pointer never advances, so
+ * multi-byte reads and writes all target the addressed register.
+ */
+static void test_no_autoincrement(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    /* Distinct values in adjacent registers. */
+    i2c_set8(dev, PCA9554_OUTPUT, 0xAA);
+    i2c_set8(dev, PCA9554_POLARITY, 0x33);
+
+    /* Two reads from OUTPUT return OUTPUT twice, not OUTPUT then POLARITY. */
+    i2c_read_block(dev, PCA9554_OUTPUT, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0xAA);
+    g_assert_cmphex(buf[1], ==, 0xAA);
+
+    /* The second written byte overwrites OUTPUT; POLARITY is untouched. */
+    buf[0] = 0x12;
+    buf[1] = 0x34;
+    i2c_write_block(dev, PCA9554_OUTPUT, buf, 2);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x34);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x33);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -120,6 +147,7 @@ static void pca9554_register_nodes(void)
                  NULL);
     qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
                  NULL);
+    qos_add_test("no-autoincrement", "pca9554", test_no_autoincrement, NULL);
 }
 
 libqos_init(pca9554_register_nodes);

-- 
2.50.1


