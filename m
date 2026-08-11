Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C46C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNj-0001Vv-C7; Tue, 11 Aug 2026 12:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNY-0000ls-3f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNV-0000ih-IZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkdZc03du87MF3PAd6gQIEeat4ZGb7Na+PJYyCJ7Smg=;
 b=cJzaDWEIy9YT33S592AhUH9Vy2Bio0DZPzoQNiDLFk84GpVtdzCBam5tEEHEaIv8kcwbZB
 WmmoduvT1fCEMG09hpfqHC7/baODbzGd60KKeoFAjL44L3ma2N1EVJAr+MerlDfDDrMY3e
 6bqLY8tbYoI9CplG/FQ/axf/GSM/nwI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-gbKuJfb6P4ucW9glFcRgig-1; Tue,
 11 Aug 2026 12:30:47 -0400
X-MC-Unique: gbKuJfb6P4ucW9glFcRgig-1
X-Mimecast-MFC-AGG-ID: gbKuJfb6P4ucW9glFcRgig_1786465846
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FD871954B07; Tue, 11 Aug 2026 16:30:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C65F9195DF91; Tue, 11 Aug 2026 16:30:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/83] tests/qtest: adc128d818: test voltage and temperature
 conversion
Date: Tue, 11 Aug 2026 18:28:44 +0200
Message-ID: <20260811162938.1403216-30-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Cover single-ended voltage conversion across all channels, voltage
and temperature boundary and clamping cases, and scaling against an
external voltage reference.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707091609.97759-4-emmanuel.blot@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/adc128d818-test.c | 189 ++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
index 9a8811256f66..891189f0bd8c 100644
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
2.55.0


