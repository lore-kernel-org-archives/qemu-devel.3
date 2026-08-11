Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEF0C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNl-0001gd-30; Tue, 11 Aug 2026 12:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNL-0000Bn-S0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNJ-0000fD-Ec
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+HMW26/ei06rBWnF54T4lDecyffI8NgFMPCAOe03zLA=;
 b=ePdQGNRRXnVxmmB23HaREZcoGsO9qb84RFRMDMXxlQJxEJvdmoWsIBtC1LsTp6FSPN6aK2
 Q/d5iT2soBX+LfroYB6p4bN1/cPfxvIyvK5Hb+IxLYOFzxzSOuHDUp3YkThtjaAodVeJa9
 917oFmW8lPPQ69LwfrC6azqq9fm+c/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-n2pVXOHwPluIMmvDi63d3Q-1; Tue,
 11 Aug 2026 12:30:45 -0400
X-MC-Unique: n2pVXOHwPluIMmvDi63d3Q-1
X-Mimecast-MFC-AGG-ID: n2pVXOHwPluIMmvDi63d3Q_1786465844
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 570C619560AB; Tue, 11 Aug 2026 16:30:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD384195DF91; Tue, 11 Aug 2026 16:30:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/83] tests/qtest: adc128d818: add test harness and register
 access
Date: Tue, 11 Aug 2026 18:28:43 +0200
Message-ID: <20260811162938.1403216-29-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce the QOS test node and QMP property helpers for the
ADC128D818, and cover basic register access: manufacturer and
revision IDs, power-on-reset defaults, software reset, and the
ain and temperature property readback.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707091609.97759-3-emmanuel.blot@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/adc128d818-test.c | 169 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 2 files changed, 170 insertions(+)
 create mode 100644 tests/qtest/adc128d818-test.c

diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
new file mode 100644
index 000000000000..9a8811256f66
--- /dev/null
+++ b/tests/qtest/adc128d818-test.c
@@ -0,0 +1,169 @@
+/*
+ * QTest testcase for the ADC128D818 ADC
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
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
+#define ADC128D818_TEST_ID      "adc128d818-test"
+#define ADC128D818_TEST_ADDR    0x1f
+
+/* Register addresses */
+#define REG_CONFIG              0x00
+#define REG_INT_STATUS          0x01
+#define REG_INT_MASK            0x03
+#define REG_CONV_RATE           0x07
+#define REG_CH_DISABLE          0x08
+#define REG_ONE_SHOT            0x09
+#define REG_DEEP_SHUTDOWN       0x0a
+#define REG_ADV_CONFIG          0x0b
+#define REG_BUSY_STATUS         0x0c
+
+/* Channel Reading Registers (16-bit, read-only) */
+#define REG_CH_READING_BASE     0x20
+
+/* Limit Registers (8-bit, read/write) */
+#define REG_LIMIT_BASE          0x2a
+
+/* ID Registers (read-only) */
+#define REG_MANUFACTURER_ID     0x3e
+#define REG_REVISION_ID         0x3f
+
+/* Configuration Register (0x00) bitfields */
+#define CONFIG_START            BIT(0)
+#define CONFIG_INT_ENABLE       BIT(1)
+#define CONFIG_INT_CLEAR        BIT(3)
+#define CONFIG_INITIALIZATION   BIT(7)
+
+/* Advanced Configuration Register (0x0b) bitfields */
+#define ADV_CONFIG_EXT_REF_EN   BIT(0)
+#define ADV_CONFIG_MODE_1       (1 << 1)
+#define ADV_CONFIG_MODE_2       (2 << 1)
+#define ADV_CONFIG_MODE_3       (3 << 1)
+
+/* Number of channels */
+#define NUM_CHANNELS            8
+
+/* Internal VREF in mV */
+#define INTERNAL_VREF_MV        2560
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
+/* Verify ain property readback via QMP */
+static void test_ain_property(void *obj, void *data, QGuestAllocator *alloc)
+{
+    int value;
+
+    qmp_adc128d818_set("ain3", 1500);
+    value = qmp_adc128d818_get("ain3");
+    g_test_message("Set ain3 = 1500 mV, readback = %d mV", value);
+    g_assert_cmpint(value, ==, 1500);
+
+    qmp_adc128d818_set("temperature", 37500);
+    value = qmp_adc128d818_get("temperature");
+    g_test_message("Set temperature = 37500 mC, readback = %d mC", value);
+    g_assert_cmpint(value, ==, 37500);
+}
+
+static void adc128d818_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" ADC128D818_TEST_ID
+                             ",address=0x1f"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { ADC128D818_TEST_ADDR });
+
+    qos_node_create_driver("adc128d818", i2c_device_create);
+    qos_node_consumes("adc128d818", "i2c-bus", &opts);
+
+    qos_add_test("id-registers", "adc128d818", test_id_registers, NULL);
+    qos_add_test("defaults", "adc128d818", test_defaults, NULL);
+    qos_add_test("soft-reset", "adc128d818", test_soft_reset, NULL);
+    qos_add_test("ain-property", "adc128d818", test_ain_property, NULL);
+}
+libqos_init(adc128d818_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e216c..5e1fc597e6d1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -304,6 +304,7 @@ qtests_hexagon = ['boot-serial-test']
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
+  'adc128d818-test.c',
   'adm1272-test.c',
   'adm1266-test.c',
   'ds1338-test.c',
-- 
2.55.0


