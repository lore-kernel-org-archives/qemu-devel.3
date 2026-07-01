Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467EEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1F6-0001ts-Ni; Wed, 01 Jul 2026 16:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weylX-0008Kj-Q2; Wed, 01 Jul 2026 13:30:29 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weylW-0006wb-2m; Wed, 01 Jul 2026 13:30:27 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 60B662003CA;
 Wed,  1 Jul 2026 19:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1782927023;
 bh=rtgoa2ZXcKYJ0bC3r8HA9NmSZpy9z/77OldWyHbsVvE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZQumOsZax7vdWPvRJ32hhSg0xDG9QXmhY1S2eKemUOxuZN42JfEGA060eoDhKiB7N
 G4BvMli+FqC6dK6rFUlNYQZi1Jp6FqFz6DGjOXrFqHk6slUICI1PcqeOT2LHvwREJS
 2J0o1IpT1AYDAsY5QlvcZ4YUjlpIh2uQM0aZWK6IBYfuHNUjZJRVL26tyQ5SEyO7AF
 Tf7JbdMWva2FxnSwn9ySwynamVf1A1teWucRzzmHOtfRx+HKvAwH1pA/juFAGBPuJI
 6FoJGJ3W2YHG2t+QcUSYINucgjzAhRwB0Fuvnu2xq8Lj5gHfe78/u1TOzJH0mRG1fx
 HENQKhShMqzYA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Wed, 01 Jul 2026 19:28:34 +0200
Subject: [PATCH v5 4/8] tests/qtest: adc128d818: test limit interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-i2c-adc128d818-anacapa-v5-4-fe8292d86b38@free.fr>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, 
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Corey Minyard <cminyard@mvista.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782926919; l=5773;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rtgoa2ZXcKYJ0bC3r8HA9NmSZpy9z/77OldWyHbsVvE=;
 b=bY6T7JWadDl4YiQ/uUPuGHUY6ebWgYtN8SLw3fy3YctIltLEFO9o1CtmmHsjwjiMEa67fiNjv
 ecpKxoF9Nj7AZKiaNoSq0RaYXtycGHvaFa5JrJmpHL+Sf6ineaSvvai
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
X-Mailman-Approved-At: Wed, 01 Jul 2026 16:09:06 -0400
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

Cover per-channel high- and low-limit interrupt status, the
INT_CLEAR bit gating the monitoring loop, and the temperature
high-limit alarm with hysteresis.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/adc128d818-test.c | 121 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
index 891189f0bd..3e3fabb8d9 100644
--- a/tests/qtest/adc128d818-test.c
+++ b/tests/qtest/adc128d818-test.c
@@ -330,6 +330,123 @@ static void test_ext_vref(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(reading, ==, 0x8000);
 }
 
+/* Interrupt status set on limit violation; persists while fault remains */
+static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    g_test_message("Set ch0 high limit = 0x10");
+
+    qmp_adc128d818_set("ain0", 2560);
+    g_test_message("Injected ain0 = 2560 mV (exceeds limit)");
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS = 0x%02x (expect bit 0 set)", status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after re-read = 0x%02x (expect bit 0 still set)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    qmp_adc128d818_set("ain0", 80);
+    g_test_message("Injected ain0 = 80 mV (within limit)");
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after fault cleared = 0x%02x "
+                   "(expect bit 0 clear)", status);
+    g_assert_cmphex(status & 0x01u, ==, 0x00);
+}
+
+/* INT_CLEAR stops the round-robin monitoring loop */
+static void test_int_clear(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    qmp_adc128d818_set("ain0", 2560);
+
+    i2c_set8(dev, REG_CONFIG,
+             CONFIG_START | CONFIG_INT_ENABLE | CONFIG_INT_CLEAR);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS with INT_CLEAR set = 0x%02x (expect 0x00)",
+                   status);
+    g_assert_cmphex(status, ==, 0x00);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS after INT_CLEAR cleared = 0x%02x (expect bit 0)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+}
+
+/* Low-limit interrupt triggers correctly */
+static void test_low_limit(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    i2c_set8(dev, REG_LIMIT_BASE + 3u, 0x80);
+    g_test_message("Set ch1 low limit = 0x80");
+
+    i2c_set8(dev, REG_LIMIT_BASE + 5u, 0x80);
+    g_test_message("Set ch2 low limit = 0x80");
+
+    qmp_adc128d818_set("ain1", 640);
+    qmp_adc128d818_set("ain2", 1280);
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("INT_STATUS = 0x%02x (expect bits 1 and 2 set)", status);
+    g_assert_cmphex(status & 0x02u, ==, 0x02);
+    g_assert_cmphex(status & 0x04u, ==, 0x04);
+
+    g_assert_cmphex(status & 0x01u, ==, 0x00);
+}
+
+/* Temperature high-limit interrupt with hysteresis */
+static void test_temp_hysteresis(void *obj, void *data,
+                                 QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    i2c_set8(dev, REG_LIMIT_BASE + 7u * 2u, 0x32);
+    i2c_set8(dev, REG_LIMIT_BASE + 7u * 2u + 1u, 0x28);
+
+    qmp_adc128d818_set("temperature", 25000);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("25 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+
+    qmp_adc128d818_set("temperature", 55000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("55 C: INT_STATUS = 0x%02x (temp bit expect set)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 45000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("45 C (hysteresis): INT_STATUS = 0x%02x "
+                   "(temp bit expect set)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 35000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    g_test_message("35 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+}
+
 static void adc128d818_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -354,5 +471,9 @@ static void adc128d818_register_nodes(void)
     qos_add_test("temperature-edges", "adc128d818", test_temperature_edges,
                  NULL);
     qos_add_test("ext-vref", "adc128d818", test_ext_vref, NULL);
+    qos_add_test("interrupt-status", "adc128d818", test_interrupt_status, NULL);
+    qos_add_test("int-clear", "adc128d818", test_int_clear, NULL);
+    qos_add_test("low-limit", "adc128d818", test_low_limit, NULL);
+    qos_add_test("temp-hysteresis", "adc128d818", test_temp_hysteresis, NULL);
 }
 libqos_init(adc128d818_register_nodes);

-- 
2.50.1


