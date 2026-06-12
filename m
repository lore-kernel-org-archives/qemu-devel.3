Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6FCD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY53q-0007hf-GB; Fri, 12 Jun 2026 12:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53o-0007gj-Kc; Fri, 12 Jun 2026 12:48:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4623e61353=eblot@meta.com>)
 id 1wY53k-0007n8-TA; Fri, 12 Jun 2026 12:48:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65C5xnXj1867365; Fri, 12 Jun 2026 09:48:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=fecuNYpO3jgkeAr5YgJRz4sKV9sQ8BBxOXSBkur0UwA=; b=DZabqYVHLP4u
 Ehf4A/JYO3NY5QzPaEeUKPUhYa+ZxzHBh5RnceN7SnsfFotSyGC4aauD/8QBRcpO
 gZS7up2P+4/shz03yPGkgiogyhKOnzZHBovqYwpl0qKtGQ2rUCLg3xw286Vk4oWr
 btEt2qFG6WMMUG4F5nmH+Y0tQXpu5ND+qm91is5x66jrysyl+nIj1oSmcCY43gr2
 jcWVVIHvrpc8pkqmD76QJzl7qIriUjPGrx6x3gXx1icjVqj6IMFIM7w/HYOd0orI
 vm4waD+olZoMttRYjwKK/H0KarkHcqub7dqRajdRHQOHeaTP639Azs7dk14Cuubc
 5lVFngFhRA==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ercf034qp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 12 Jun 2026 09:48:07 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::4) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 12 Jun
 2026 16:48:06 +0000
From: Emmanuel Blot <eblot@meta.com>
Date: Fri, 12 Jun 2026 18:47:01 +0200
Subject: [PATCH 2/4] tests/qtest: adc128d818: add test suite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260612-i2c-adc128d818-anacapa-v1-2-9e4640cd164b@meta.com>
References: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
In-Reply-To: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 "Jamin Lin" <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, <qemu-arm@nongnu.org>,
 Emmanuel Blot <eblot@meta.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781282877; l=33954;
 i=eblot@meta.com; s=20260602; h=from:subject:message-id;
 bh=O4Qz7agWjSKnPKCMX1TJlQVikrhT8O+vTz3HZIfdxLg=;
 b=eAYvPqx2KDdgCfjcbG/43o/a6Rl6AxJNOM8PUDXufwV6iQE6giL+VYoN5t2GuXPWuAY5bgyVR
 f7Cpf1vZ6KlAOzzyA7ITzBpp86IydQgddwl1MQg/xkhiKin0fO9I7Ke
X-Developer-Key: i=eblot@meta.com; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
X-Originating-IP: [2620:10d:c085:108::4]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfX2w8p1IkvUqJi
 od58DUMZTG6Eei9nfwUS655byyJhkatcjlfyamDL/eyQdCzq/8h43WQnoC5HYSBz+SQxfFJQ4gt
 AQQOn0yxnWV3E18dyrNEh4QUwHQr6oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDE1NSBTYWx0ZWRfXwWdy+vXsoihH
 nDD4zMWEhREtO3sPdRWJB8Pv2nnG4rTJVcv1vMTI5aaUrbdTOnLvaaLCuvdGSafL0WL5q8lVjy/
 W5TwLR0AMnqhvkwihm0JNkdchW4aCHMyyzawZjg3UK0qB57a6YkRJNWX/ajdlqwLNwlN7GhAOlr
 u/d6Zx06KTBAhz+uzXL7pEDULFG7AZLH4iYI59R15gFUNYmT7V9KLhCOOhtkyUqIJu6k3lg0OKG
 LtBtgfRllltFVJr1xbGQ9+SrWx0AonA59KLmAyFVDxkYXlH5UStxDLr74ApSruUh8sdnkvuHABo
 0tBSKa9/vHJHJ6O9BGhQr5zgC3Cj4QSuo+tXAWi1po/Li0Jgrzxv6xMiAbZLuMgRU3Se/fsGYV1
 s0sd9xQYcnuPPH4w1/S4RSQpuLyt02qrNwt2QkVMQuPllMgQOReQZa6Ng4wBNE5We6vBEOmtkAr
 kDewg8ZNnZGlTcAPLzg==
X-Proofpoint-ORIG-GUID: MU1_BkCuIcQrxhDBX3NhsO6e6eI5VuDB
X-Authority-Analysis: v=2.4 cv=QYhWeMbv c=1 sm=1 tr=0 ts=6a2c3847 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8
 a=6gxeLL3OCge1nV_BnqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: MU1_BkCuIcQrxhDBX3NhsO6e6eI5VuDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_02,2026-06-12_03,2025-10-01_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4623e61353=eblot@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add QOS-based QTest coverage for the ADC128D818:

 - manufacturer and revision ID registers
 - power-on-reset defaults
 - software reset
 - voltage conversion and edge cases
 - all channels with distinct values simultaneously
 - temperature conversion and edge cases
 - external voltage reference
 - per-channel interrupt status
 - INT_CLEAR bit suppresses interrupt assertion
 - channel disable prevents conversion
 - one-shot conversion in shutdown mode
 - deep shutdown blocks conversion
 - BUSY_STATUS NOT_READY flag lifecycle
 - operating mode selection
 - mode 2 pseudo-differential pairs
 - mode 3 mixed single-ended and differential
 - mode-change reset of readings and interrupt status
 - QOM-triggered reconversion

Signed-off-by: Emmanuel Blot <eblot@meta.com>
---
 tests/qtest/adc128d818-test.c | 855 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 2 files changed, 856 insertions(+)

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
new file mode 100644
index 0000000000..f9b54b33d0
--- /dev/null
+++ b/tests/qtest/adc128d818-test.c
@@ -0,0 +1,855 @@
+/*
+ * QTest testcase for the ADC128D818 ADC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqos/i2c.h"
+#include "libqos/qgraph.h"
+#include "libqtest-single.h"
+#include "qobject/qdict.h"
+
+/* clang-format off */
+#define ADC128D818_TEST_ID      "adc128d818-test"
+#define ADC128D818_TEST_ADDR    0x1F
+
+/* Register addresses */
+#define REG_CONFIG              0x00u
+#define REG_INT_STATUS          0x01u
+#define REG_INT_MASK            0x03u
+#define REG_CONV_RATE           0x07u
+#define REG_CH_DISABLE          0x08u
+#define REG_ONE_SHOT            0x09u
+#define REG_DEEP_SHUTDOWN       0x0Au
+#define REG_ADV_CONFIG          0x0Bu
+#define REG_BUSY_STATUS         0x0Cu
+
+/* Channel Reading Registers (16-bit, read-only) */
+#define REG_CH_READING_BASE     0x20u
+
+/* Limit Registers (8-bit, read/write) */
+#define REG_LIMIT_BASE          0x2Au
+
+/* ID Registers (read-only) */
+#define REG_MANUFACTURER_ID     0x3Eu
+#define REG_REVISION_ID         0x3Fu
+
+/* Configuration Register (0x00) bitfields */
+#define CONFIG_START            BIT(0)
+#define CONFIG_INT_ENABLE       BIT(1)
+#define CONFIG_INT_CLEAR        BIT(3)
+#define CONFIG_INITIALIZATION   BIT(7)
+
+/* Advanced Configuration Register (0x0B) bitfields */
+#define ADV_CONFIG_EXT_REF_EN   BIT(0)
+#define ADV_CONFIG_MODE_1       (1u << 1u)
+#define ADV_CONFIG_MODE_2       (2u << 1u)
+#define ADV_CONFIG_MODE_3       (3u << 1u)
+
+/* Number of channels */
+#define NUM_CHANNELS            8u
+
+/* Internal VREF in mV */
+#define INTERNAL_VREF_MV        2560u
+
+/* TAP-compatible diagnostic output (g_test_message is silent in TAP mode) */
+#define test_log(fmt, ...) \
+    fprintf(stderr, "# " fmt "\n", ## __VA_ARGS__)
+/* clang-format on */
+
+/* QMP helpers for setting device properties */
+
+static void qmp_adc128d818_set(const char *property, int value)
+{
+    QDict *resp;
+
+    resp = qmp("{ 'execute': 'qom-set', 'arguments':"
+               " { 'path': %s, 'property': %s, 'value': %d } }",
+               ADC128D818_TEST_ID, property, value);
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+}
+
+static int qmp_adc128d818_get(const char *property)
+{
+    QDict *resp;
+    int ret;
+
+    resp = qmp("{ 'execute': 'qom-get', 'arguments':"
+               " { 'path': %s, 'property': %s } }",
+               ADC128D818_TEST_ID, property);
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_int(resp, "return");
+    qobject_unref(resp);
+    return ret;
+}
+
+/* Manufacturer and Revision ID registers */
+static void test_id_registers(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, REG_MANUFACTURER_ID), ==, 0x01);
+    g_assert_cmphex(i2c_get8(dev, REG_REVISION_ID), ==, 0x09);
+}
+
+/* Power-on-reset default values */
+static void test_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    unsigned ch;
+
+    g_assert_cmphex(i2c_get8(dev, REG_CONFIG), ==, 0x08);
+    g_assert_cmphex(i2c_get8(dev, REG_INT_STATUS), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_INT_MASK), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_CONV_RATE), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_CH_DISABLE), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_DEEP_SHUTDOWN), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_ADV_CONFIG), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_BUSY_STATUS), ==, 0x02);
+
+    for (ch = 0u; ch < NUM_CHANNELS; ch++) {
+        g_assert_cmphex(i2c_get8(dev, REG_LIMIT_BASE + ch * 2u), ==, 0xFF);
+        g_assert_cmphex(i2c_get8(dev, REG_LIMIT_BASE + ch * 2u + 1u), ==, 0x00);
+    }
+}
+
+/* Software reset via INITIALIZATION bit */
+static void test_soft_reset(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, REG_INT_MASK, 0xAA);
+    i2c_set8(dev, REG_CH_DISABLE, 0x55);
+    i2c_set8(dev, REG_LIMIT_BASE, 0x42);
+
+    g_assert_cmphex(i2c_get8(dev, REG_INT_MASK), ==, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, REG_CH_DISABLE), ==, 0x55);
+    g_assert_cmphex(i2c_get8(dev, REG_LIMIT_BASE), ==, 0x42);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    g_assert_cmphex(i2c_get8(dev, REG_CONFIG), ==, 0x08);
+    g_assert_cmphex(i2c_get8(dev, REG_INT_MASK), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_CH_DISABLE), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, REG_LIMIT_BASE), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, REG_BUSY_STATUS), ==, 0x02);
+}
+
+/* Voltage conversion */
+static void test_voltage_conversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    qmp_adc128d818_set("ain0", 1280);
+    test_log("Injected ain0 = 1280 mV");
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Read ch0: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain1", 2560);
+    test_log("Injected ain1 = 2560 mV");
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("Read ch1: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0xFFF0);
+
+    qmp_adc128d818_set("ain2", 0);
+    test_log("Injected ain2 = 0 mV");
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 2u);
+    test_log("Read ch2: raw 0x%04x -> %u mV", reading,
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
+    test_log("Injected temperature = 25000 mC (25.0 deg C)");
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("Read ch7: raw 0x%04x -> %d mC", reading,
+             (int16_t)(reading & 0xFF80u) * 500 / 128);
+    g_assert_cmphex(reading, ==, 0x1900);
+}
+
+/* Interrupt status set on limit violation; persists while fault remains */
+static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t status;
+
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    test_log("Set ch0 high limit = 0x10");
+
+    qmp_adc128d818_set("ain0", 2560);
+    test_log("Injected ain0 = 2560 mV (exceeds limit)");
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("INT_STATUS = 0x%02x (expect bit 0 set)", status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("INT_STATUS after re-read = 0x%02x (expect bit 0 still set)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+
+    qmp_adc128d818_set("ain0", 80);
+    test_log("Injected ain0 = 80 mV (within limit)");
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("INT_STATUS after fault cleared = 0x%02x (expect bit 0 clear)",
+             status);
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
+    test_log("INT_STATUS with INT_CLEAR set = 0x%02x (expect 0x00)", status);
+    g_assert_cmphex(status, ==, 0x00);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("INT_STATUS after INT_CLEAR cleared = 0x%02x (expect bit 0)",
+             status);
+    g_assert_cmphex(status & 0x01u, ==, 0x01);
+}
+
+/* Channel disable prevents conversion */
+static void test_channel_disable(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CH_DISABLE, 0x01);
+    test_log("Disabled channel 0");
+
+    qmp_adc128d818_set("ain0", 1280);
+    test_log("Injected ain0 = 1280 mV (disabled)");
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Read ch0 (disabled): raw 0x%04x", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    qmp_adc128d818_set("ain1", 1280);
+    test_log("Injected ain1 = 1280 mV (enabled)");
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("Read ch1 (enabled): raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* One-shot conversion in shutdown mode */
+static void test_one_shot(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    qmp_adc128d818_set("ain0", 1280);
+    test_log("Injected ain0 = 1280 mV (device stopped)");
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Read ch0 before one-shot: raw 0x%04x", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    g_assert_cmphex(i2c_get8(dev, REG_ONE_SHOT), ==, 0x00);
+
+    i2c_set8(dev, REG_ONE_SHOT, 0x00);
+    test_log("Triggered one-shot conversion with value 0x00");
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Read ch0 after one-shot: raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* Mode 1 makes channel 7 a voltage input instead of temperature */
+static void test_mode_selection(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_1);
+    test_log("Set mode 1 (all voltage channels)");
+
+    qmp_adc128d818_set("ain7", 1280);
+    qmp_adc128d818_set("temperature", 50000);
+    test_log("Injected ain7 = 1280 mV, temperature = 50000 mC");
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("Read ch7 (mode 1): raw 0x%04x -> %u mV", reading,
+             (reading >> 4u) * INTERNAL_VREF_MV / 4096u);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* Mode 2 — 4 pseudo-differential pairs */
+static void test_mode2_diff(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_2);
+    test_log("Set mode 2 (4 pseudo-differential pairs)");
+
+    qmp_adc128d818_set("ain0", 2000);
+    qmp_adc128d818_set("ain1", 720);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Pair 0 (IN0-IN1): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain3", 1920);
+    qmp_adc128d818_set("ain2", 640);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("Pair 1 (IN3-IN2): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain4", 1500);
+    qmp_adc128d818_set("ain5", 220);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 2u);
+    test_log("Pair 2 (IN4-IN5): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain7", 2560);
+    qmp_adc128d818_set("ain6", 1280);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 3u);
+    test_log("Pair 3 (IN7-IN6): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 4u);
+    test_log("Reserved ch4: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    qmp_adc128d818_set("ain0", 500);
+    qmp_adc128d818_set("ain1", 1000);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Pair 0 negative ΔV: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+}
+
+/* Mode 3 — 4 single-ended + 2 pseudo-differential pairs */
+static void test_mode3_mixed(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_3);
+    test_log("Set mode 3 (4 single-ended + 2 differential)");
+
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Ch0 single-ended: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain4", 1500);
+    qmp_adc128d818_set("ain5", 220);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 4u);
+    test_log("Ch4 diff (IN4-IN5): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain7", 2560);
+    qmp_adc128d818_set("ain6", 1280);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 5u);
+    test_log("Ch5 diff (IN7-IN6): raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 6u);
+    test_log("Reserved ch6: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    qmp_adc128d818_set("temperature", 25000);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("Ch7 temperature: raw 0x%04x (expect 0x1900)", reading);
+    g_assert_cmphex(reading, ==, 0x1900);
+}
+
+/* Mode change resets channel readings and interrupt status */
+static void test_mode_change_reset(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+    uint8_t status;
+
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Before mode change, ch0: raw 0x%04x", reading);
+    g_assert_cmphex(reading, !=, 0x0000);
+
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    i2c_set8(dev, REG_LIMIT_BASE, 0x10);
+    qmp_adc128d818_set("ain0", 2560);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_2);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After mode change, ch0: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("After mode change, INT_STATUS: 0x%02x (expect 0x00)", status);
+    g_assert_cmphex(status, ==, 0x00);
+
+    g_assert_cmphex(i2c_get8(dev, REG_LIMIT_BASE), ==, 0x10);
+    test_log("Limit register preserved after mode change");
+}
+
+/* QOM property changes trigger correct differential conversion */
+static void test_diff_qom_trigger(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_MODE_2);
+
+    qmp_adc128d818_set("ain0", 0);
+    qmp_adc128d818_set("ain1", 0);
+    qmp_adc128d818_set("ain2", 0);
+    qmp_adc128d818_set("ain3", 0);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    qmp_adc128d818_set("ain0", 2000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After ain0=2000, ain1=0: pair0 = 0x%04x (expect 0xC800)",
+             reading);
+    g_assert_cmphex(reading, ==, 0xC800);
+
+    qmp_adc128d818_set("ain1", 720);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After ain1=720: pair0 = 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("ain3", 1920);
+    qmp_adc128d818_set("ain2", 640);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("Pair 1 (IN3-IN2) via QOM: 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* Channels with distinct voltages */
+static void test_all_channels(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    /* clang-format off */
+    static const uint16_t ain_mv[NUM_CHANNELS] = {
+        0, 320, 640, 960, 1280, 1920, 2240, 2560
+    };
+    static const uint16_t expect[NUM_CHANNELS] = {
+        0x0000, 0x2000, 0x4000, 0x6000, 0x8000, 0xC000, 0xE000, 0xFFF0
+    };
+    /* clang-format on */
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
+        test_log("ch%u: ain %u mV -> raw 0x%04x (expect 0x%04x)",
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
+    test_log("Over-range 3000 mV: raw 0x%04x (expect 0xFFF0)", reading);
+    g_assert_cmphex(reading, ==, 0xFFF0);
+
+    qmp_adc128d818_set("ain1", 1);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("1 mV: raw 0x%04x (expect 0x0010)", reading);
+    g_assert_cmphex(reading, ==, 0x0010);
+
+    qmp_adc128d818_set("ain2", 640);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 2u);
+    test_log("640 mV (quarter): raw 0x%04x (expect 0x4000)", reading);
+    g_assert_cmphex(reading, ==, 0x4000);
+
+    qmp_adc128d818_set("ain3", 1920);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 3u);
+    test_log("1920 mV (3/4): raw 0x%04x (expect 0xC000)", reading);
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
+    test_log("0 C: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    qmp_adc128d818_set("temperature", -25000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("-25 C: raw 0x%04x (expect 0xE700)", reading);
+    g_assert_cmphex(reading, ==, 0xE700);
+
+    qmp_adc128d818_set("temperature", 127500);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("+127.5 C: raw 0x%04x (expect 0x7F80)", reading);
+    g_assert_cmphex(reading, ==, 0x7F80);
+
+    qmp_adc128d818_set("temperature", -128000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("-128 C: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    qmp_adc128d818_set("temperature", 200000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("200 C (clamped): raw 0x%04x (expect 0x7F80)", reading);
+    g_assert_cmphex(reading, ==, 0x7F80);
+
+    qmp_adc128d818_set("temperature", -200000);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 7u);
+    test_log("-200 C (clamped): raw 0x%04x (expect 0x8000)", reading);
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
+    test_log("1000 mV / 4096 mV VREF: raw 0x%04x (expect 0x3E80)", reading);
+    g_assert_cmphex(reading, ==, 0x3E80);
+
+    qmp_adc128d818_set("ain1", 2048);
+    reading = i2c_get16(dev, REG_CH_READING_BASE + 1u);
+    test_log("2048 mV / 4096 mV VREF: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* One-shot conversion works in deep shutdown */
+static void test_deep_shutdown(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    i2c_set8(dev, REG_DEEP_SHUTDOWN, 0x01);
+    test_log("DEEP_SHUTDOWN write while running rejected");
+    g_assert_cmphex(i2c_get8(dev, REG_DEEP_SHUTDOWN), ==, 0x00);
+
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    i2c_set8(dev, REG_DEEP_SHUTDOWN, 0x01);
+    qmp_adc128d818_set("ain0", 0);
+
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Deep shutdown, no one-shot: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+
+    i2c_set8(dev, REG_ONE_SHOT, 0x01);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("Deep shutdown one-shot: raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    g_assert_cmphex(i2c_get8(dev, REG_DEEP_SHUTDOWN), ==, 0x01);
+
+    i2c_set8(dev, REG_DEEP_SHUTDOWN, 0x00);
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_ONE_SHOT, 0x01);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After exit shutdown: raw 0x%04x (expect 0x8000)", reading);
+    g_assert_cmphex(reading, ==, 0x8000);
+}
+
+/* BUSY_STATUS NOT_READY clears after first conversion */
+static void test_busy_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    g_assert_cmphex(i2c_get8(dev, REG_BUSY_STATUS) & 0x02, ==, 0x02);
+    test_log("After reset: BUSY_STATUS = 0x%02x (NOT_READY set)",
+             i2c_get8(dev, REG_BUSY_STATUS));
+
+    qmp_adc128d818_set("ain0", 0);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+
+    g_assert_cmphex(i2c_get8(dev, REG_BUSY_STATUS) & 0x02, ==, 0x00);
+    test_log("After conversion: BUSY_STATUS = 0x%02x (NOT_READY cleared)",
+             i2c_get8(dev, REG_BUSY_STATUS));
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
+    test_log("Set ch1 low limit = 0x80");
+
+    i2c_set8(dev, REG_LIMIT_BASE + 5u, 0x80);
+    test_log("Set ch2 low limit = 0x80");
+
+    qmp_adc128d818_set("ain1", 640);
+    qmp_adc128d818_set("ain2", 1280);
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START | CONFIG_INT_ENABLE);
+
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("INT_STATUS = 0x%02x (expect bits 1 and 2 set)", status);
+    g_assert_cmphex(status & 0x02u, ==, 0x02);
+    g_assert_cmphex(status & 0x04u, ==, 0x04);
+
+    g_assert_cmphex(status & 0x01u, ==, 0x00);
+}
+
+/* Verify ain property readback via QMP */
+static void test_ain_property(void *obj, void *data, QGuestAllocator *alloc)
+{
+    int value;
+
+    qmp_adc128d818_set("ain3", 1500);
+    value = qmp_adc128d818_get("ain3");
+    test_log("Set ain3 = 1500 mV, readback = %d mV", value);
+    g_assert_cmpint(value, ==, 1500);
+
+    qmp_adc128d818_set("temperature", 37500);
+    value = qmp_adc128d818_get("temperature");
+    test_log("Set temperature = 37500 mC, readback = %d mC", value);
+    g_assert_cmpint(value, ==, 37500);
+}
+
+/* Programming Channel Disable resets channel readings */
+static void test_chan_disable_clears(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    g_assert_cmphex(i2c_get16(dev, REG_CH_READING_BASE), ==, 0x8000);
+
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    i2c_set8(dev, REG_CH_DISABLE, 0x02);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After CH_DISABLE write: ch0 raw 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+}
+
+/* Programming Advanced Configuration always resets channel readings */
+static void test_adv_config_clears(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint16_t reading;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    qmp_adc128d818_set("ain0", 1280);
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    g_assert_cmphex(i2c_get16(dev, REG_CH_READING_BASE), ==, 0x8000);
+
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    i2c_set8(dev, REG_ADV_CONFIG, 0x00);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After same-mode ADV_CONFIG: ch0 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    g_assert_cmphex(i2c_get16(dev, REG_CH_READING_BASE), ==, 0x8000);
+    i2c_set8(dev, REG_CONFIG, 0x00);
+    qmp_adc128d818_set("ext-vref-mv", 4096);
+    i2c_set8(dev, REG_ADV_CONFIG, ADV_CONFIG_EXT_REF_EN);
+    reading = i2c_get16(dev, REG_CH_READING_BASE);
+    test_log("After ext-vref toggle: ch0 0x%04x (expect 0x0000)", reading);
+    g_assert_cmphex(reading, ==, 0x0000);
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
+    test_log("25 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+
+    qmp_adc128d818_set("temperature", 55000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("55 C: INT_STATUS = 0x%02x (temp bit expect set)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 45000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("45 C (hysteresis): INT_STATUS = 0x%02x (temp bit expect set)",
+             status);
+    g_assert_cmphex(status & 0x80u, ==, 0x80);
+
+    qmp_adc128d818_set("temperature", 35000);
+    status = i2c_get8(dev, REG_INT_STATUS);
+    test_log("35 C: INT_STATUS = 0x%02x (temp bit expect clear)", status);
+    g_assert_cmphex(status & 0x80u, ==, 0x00);
+}
+
+/* Conversion Rate register may only be programmed while in shutdown */
+static void test_conv_rate(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_INITIALIZATION);
+
+    i2c_set8(dev, REG_CONV_RATE, 0x01);
+    g_assert_cmphex(i2c_get8(dev, REG_CONV_RATE), ==, 0x01);
+
+    i2c_set8(dev, REG_CONFIG, CONFIG_START);
+    i2c_set8(dev, REG_CONV_RATE, 0x00);
+    test_log("CONV_RATE while running: 0x%02x (expect unchanged 0x01)",
+             i2c_get8(dev, REG_CONV_RATE));
+    g_assert_cmphex(i2c_get8(dev, REG_CONV_RATE), ==, 0x01);
+}
+
+static void adc128d818_register_nodes(void)
+{
+    /* clang-format off */
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" ADC128D818_TEST_ID
+                             ",address=0x1f"
+    };
+    /* clang-format on */
+    add_qi2c_address(&opts, &(QI2CAddress) { ADC128D818_TEST_ADDR });
+
+    qos_node_create_driver("adc128d818", i2c_device_create);
+    qos_node_consumes("adc128d818", "i2c-bus", &opts);
+
+    qos_add_test("id-registers", "adc128d818", test_id_registers, NULL);
+    qos_add_test("defaults", "adc128d818", test_defaults, NULL);
+    qos_add_test("soft-reset", "adc128d818", test_soft_reset, NULL);
+    qos_add_test("voltage-conversion", "adc128d818", test_voltage_conversion,
+                 NULL);
+    qos_add_test("temperature-conversion", "adc128d818",
+                 test_temperature_conversion, NULL);
+    qos_add_test("interrupt-status", "adc128d818", test_interrupt_status, NULL);
+    qos_add_test("int-clear", "adc128d818", test_int_clear, NULL);
+    qos_add_test("channel-disable", "adc128d818", test_channel_disable, NULL);
+    qos_add_test("one-shot", "adc128d818", test_one_shot, NULL);
+    qos_add_test("mode-selection", "adc128d818", test_mode_selection, NULL);
+    qos_add_test("mode2-diff", "adc128d818", test_mode2_diff, NULL);
+    qos_add_test("mode3-mixed", "adc128d818", test_mode3_mixed, NULL);
+    qos_add_test("mode-change-reset", "adc128d818", test_mode_change_reset,
+                 NULL);
+    qos_add_test("diff-qom-trigger", "adc128d818", test_diff_qom_trigger,
+                 NULL);
+    qos_add_test("all-channels", "adc128d818", test_all_channels, NULL);
+    qos_add_test("voltage-edges", "adc128d818", test_voltage_edges, NULL);
+    qos_add_test("temperature-edges", "adc128d818", test_temperature_edges,
+                 NULL);
+    qos_add_test("ext-vref", "adc128d818", test_ext_vref, NULL);
+    qos_add_test("deep-shutdown", "adc128d818", test_deep_shutdown, NULL);
+    qos_add_test("busy-status", "adc128d818", test_busy_status, NULL);
+    qos_add_test("low-limit", "adc128d818", test_low_limit, NULL);
+    qos_add_test("chan-disable-clears", "adc128d818", test_chan_disable_clears,
+                 NULL);
+    qos_add_test("adv-config-clears", "adc128d818", test_adv_config_clears,
+                 NULL);
+    qos_add_test("temp-hysteresis", "adc128d818", test_temp_hysteresis, NULL);
+    qos_add_test("conv-rate", "adc128d818", test_conv_rate, NULL);
+    qos_add_test("ain-property", "adc128d818", test_ain_property, NULL);
+}
+libqos_init(adc128d818_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 45ea497fa5..defa0d9941 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -296,6 +296,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
+  'adc128d818-test.c',
   'adm1272-test.c',
   'adm1266-test.c',
   'ds1338-test.c',

-- 
2.50.1


