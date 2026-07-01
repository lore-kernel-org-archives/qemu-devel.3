Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDCCC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1F6-0001u6-R8; Wed, 01 Jul 2026 16:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weylC-0008AW-Fm; Wed, 01 Jul 2026 13:30:06 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weylA-0006Zo-EJ; Wed, 01 Jul 2026 13:30:06 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 590232003DD;
 Wed,  1 Jul 2026 19:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1782927002;
 bh=DEtgkVQYX15nwF8ayNXYbS7A97DKm065aENMYX/g1hI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=j8KEJczT+JrYOeZakxRqaxxbe5PphIqkZgHev23faeB4aSIUn06mjjL9jZjwJAyIr
 NcI9/+T48T9qiRAVvpb9fSvIwv6hz54UhQ0cZGpJpmimfYz8586dVTBNldySMgf62o
 mrtvWY4kiyiaTccsZFa3m0k78bGNyl/khFRZvhH25XGl0e472nXHW7mea6JqiugOVR
 m6E+Q9mzB1fcggDdfO2SCq+INymu+ItyRxU7BjCiNcMiDbH8IdpO331v1NPpUwhUNV
 WPeBQHkWTpRrZaWcOKdiC96v8NkzDcau0aLAFjVxc3lDuPmw6wke0ADtDdgdOUUYWG
 mo2qqqG+WshCg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Wed, 01 Jul 2026 19:28:33 +0200
Subject: [PATCH v5 3/8] tests/qtest: adc128d818: test voltage and
 temperature conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-i2c-adc128d818-anacapa-v5-3-fe8292d86b38@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782926919; l=8524;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=DEtgkVQYX15nwF8ayNXYbS7A97DKm065aENMYX/g1hI=;
 b=4H9ZovkzzRjBgq3zm6YYp2D/pyrVu4QNZ1wcGhEfW5J/L10qdwEnKvhcwXwPxab9kMshWR61u
 PYU0UJJqYwfB5aGXQuEjUzz+qzls28a2f9DqlmI9EcI+rkzb6ScIviL
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

Cover single-ended voltage conversion across all channels, voltage
and temperature boundary and clamping cases, and scaling against an
external voltage reference.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/adc128d818-test.c | 189 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
index 9a8811256f..891189f0bd 100644
--- a/tests/qtest/adc128d818-test.c
+++ b/tests/qtest/adc128d818-test.c
@@ -150,6 +150,186 @@ static void test_ain_property(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpint(value, ==, 37500);
 }
 
+/* Voltage conversion */
+static void test_voltage_conversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    qmp_adc128d818_set("ain0", 1280);
+    g_test_message("Injected ain0 = 1280 mV");
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    g_test_message("Read ch0: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain1", 2560);
+    g_test_message("Injected ain1 = 2560 mV");
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    g_test_message("Read ch1: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0xFFF0);
+
+    qmp_adc128d818_set("ain2", 0);
+    g_test_message("Injected ain2 = 0 mV");
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 2u);
+    g_test_message("Read ch2: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x0000);
+}
+
+/* Temperature conversion (mode 0, channel 7 = temperature) */
+static void
+test_temperature_conversion(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    qmp_adc128d818_set("temperature", 25000);
+    g_test_message("Injected temperature = 25000 mC (25.0 deg C)");
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("Read ch7: raw 0x%04x -> %d mC", reading,
+             (int16_t)(reading & 0xFF80u) * 500 / 128);
+    g_assert_cmphex(reading, ==, 0x1900);
+}
+
+/* Channels with distinct voltages */
+static void test_all_channels(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    static const uint16_t ain_mv[NUM_CHANNELS] = {
+        0, 320, 640, 960, 1280, 1920, 2240, 2560
+    };
+    static const uint16_t expect[NUM_CHANNELS] = {
+        0x0000, 0x2000, 0x4000, 0x6000, 0x8000, 0xC000, 0xE000, 0xFFF0
+    };
+    uint16_t reading;
+    unsigned ch;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_1);
+
+    for (ch = 0u; ch < NUM_CHANNELS; ch++) {
+        char name[8];
+        snprintf(name, sizeof(name), "ain%u", ch);
+        qmp_adc128d818_set(name, ain_mv[ch]);
+    }
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    for (ch = 0u; ch < NUM_CHANNELS; ch++) {
+        reading = i2c_get16(dev, REG_CH_READING_BASE + ch);
+        g_test_message("ch%u: ain %u mV -> raw 0x%04x (expect 0x%04x)",
+                 ch, ain_mv[ch], reading, expect[ch]);
+        g_assert_cmphex(reading, ==, expect[ch]);
+    }
+}
+
+/* Voltage conversion edge cases */
+static void test_voltage_edges(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_1);
+
+    qmp_adc128d818_set("ain0", 3000);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    g_test_message("Over-range 3000 mV: raw 0x%04x (expect 0xFFF0)", reading);
+    g_assert_cmphex(reading, ==, 0xFFF0);
+
+    qmp_adc128d818_set("ain1", 1);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    g_test_message("1 mV: raw 0x%04x (expect 0x0010)", reading);
+    g_assert_cmphex(reading, ==, 0x0010);
+
+    qmp_adc128d818_set("ain2", 640);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 2u);
+    g_test_message("640 mV (quarter): raw 0x%04x (expect 0x4000)", reading);
+    g_assert_cmphex(reading, ==, 0x4000);
+
+    qmp_adc128d818_set("ain3", 1920);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 3u);
+    g_test_message("1920 mV (3/4): raw 0x%04x (expect 0xC000)", reading);
+    g_assert_cmphex(reading, ==, 0xC000);
+}
+
+/* Temperature conversion edge cases */
+static void test_temperature_edges(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    qmp_adc128d818_set("temperature", 0);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("0 C: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    qmp_adc128d818_set("temperature", -25000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("-25 C: raw 0x%04x (expect 0xE700)", reading);
+    g_assert_cmphex(reading, ==, 0xE700);
+
+    qmp_adc128d818_set("temperature", 127500);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("+127.5 C: raw 0x%04x (expect 0x7F80)", reading);
+    g_assert_cmphex(reading, ==, 0x7F80);
+
+    qmp_adc128d818_set("temperature", -128000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("-128 C: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("temperature", 200000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("200 C (clamped): raw 0x%04x (expect 0x7F80)", reading);
+    g_assert_cmphex(reading, ==, 0x7F80);
+
+    qmp_adc128d818_set("temperature", -200000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    g_test_message("-200 C (clamped): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* External voltage reference */
+static void test_ext_vref(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_1);
+
+    qmp_adc128d818_set("ext-vref-mv", 4096);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_EXT_REF_EN | ADV_CONFIG_MODE_1);
+
+    qmp_adc128d818_set("ain0", 1000);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    g_test_message("1000 mV / 4096 mV VREF: raw 0x%04x (expect 0x3E80)",
+                   reading);
+    g_assert_cmphex(reading, ==, 0x3E80);
+
+    qmp_adc128d818_set("ain1", 2048);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    g_test_message("2048 mV / 4096 mV VREF: raw 0x%04x (expect 0x8000)",
+                   reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
 static void adc128d818_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -165,5 +345,14 @@ static void adc128d818_register_nodes(void)
     qos_add_test("defaults", "adc128d818", test_defaults, NULL);
     qos_add_test("soft-reset", "adc128d818", test_soft_reset, NULL);
     qos_add_test("ain-property", "adc128d818", test_ain_property, NULL);
+    qos_add_test("voltage-conversion", "adc128d818", test_voltage_conversion,
+                 NULL);
+    qos_add_test("temperature-conversion", "adc128d818",
+                 test_temperature_conversion, NULL);
+    qos_add_test("all-channels", "adc128d818", test_all_channels, NULL);
+    qos_add_test("voltage-edges", "adc128d818", test_voltage_edges, NULL);
+    qos_add_test("temperature-edges", "adc128d818", test_temperature_edges,
+                 NULL);
+    qos_add_test("ext-vref", "adc128d818", test_ext_vref, NULL);
 }
 libqos_init(adc128d818_register_nodes);

-- 
2.50.1


