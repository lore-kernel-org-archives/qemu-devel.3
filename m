Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3C3C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPB-00045K-Ez; Sun, 06 Sep 2026 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP8-000404-Uy
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP7-0000Hk-4B
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OK5E+zA4WUHe8AgmMdrTqXgnpPqhIkWuYAN868sE2nE=;
 b=d7IARs4OZRiwSt1BYYHCbOfFTvMRIynZmgt3PDO4XPasTSJsWW5ofAIKEp7in20045IiWC
 tcifHaSycMDMxRsqote5E84DfSkvmGVi2kGGw+RQdyponZSmRkS+iNlp7TwNiUsP4j9pSD
 cYoee8vK68ZY1kchY7dBRsvlN8G3D00=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-lsL9dg8kNiiE8RRJriqRbw-1; Sun,
 06 Sep 2026 13:11:37 -0400
X-MC-Unique: lsL9dg8kNiiE8RRJriqRbw-1
X-Mimecast-MFC-AGG-ID: lsL9dg8kNiiE8RRJriqRbw_1788714696
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C4B71800846; Sun,  6 Sep 2026 17:11:36 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E2AD1955F06; Sun,  6 Sep 2026 17:11:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/40] tests/qtest: tmp105: cover the TMP75,
 TMP175 and LM75B variants
Date: Sun,  6 Sep 2026 19:10:14 +0200
Message-ID: <20260906171021.26568-34-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Exercise the per-variant differences added to the model: the TMP75 and
TMP175 fault-queue depths, the TMP75 alert-clear on thermostat-mode
change, and the LM75B's reserved config bits and fixed set-point and
temperature resolutions.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-9-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/tmp105-test.c | 138 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 29a031fb7bfe..ea6803715a39 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -19,9 +19,20 @@
 #define TMP105_TEST_ADDR 0x49
 #define TMP105_TEST_PATH "/machine/peripheral/" TMP105_TEST_ID
 
+#define TMP75_TEST_ID    "tmp75-test"
+#define TMP75_TEST_PATH  "/machine/peripheral/" TMP75_TEST_ID
+
+#define TMP175_TEST_ID   "tmp175-test"
+#define TMP175_TEST_PATH "/machine/peripheral/" TMP175_TEST_ID
+
+#define LM75B_TEST_ID    "lm75b-test"
+#define LM75B_TEST_PATH  "/machine/peripheral/" LM75B_TEST_ID
+
 #define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
+#define TMP105_CONFIG_TM    (1 << 1)   /* interrupt (thermostat) mode */
 #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
 #define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
+#define TMP105_CONFIG_FQ(f) ((f) << 3) /* raw F1:F0 fault-queue field value */
 
 static int qmp_tmp105_get_temperature(const char *id)
 {
@@ -166,6 +177,98 @@ static void test_fault_queue(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_false(get_irq(0));
 }
 
+/*
+ * Drive @need consecutive over-limit conversions and check that the ALERT pin
+ * only asserts on the last one. This exercises the fault-queue length.
+ */
+static void check_fault_queue(QI2CDevice *i2cdev, const char *id,
+                              const char *path, uint8_t fq_field, int need)
+{
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, path);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(fq_field));
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < need - 1; i++) {
+        qmp_tmp105_set_temperature(id, 85000);
+        g_assert_false(get_irq(0));
+    }
+    qmp_tmp105_set_temperature(id, 85000);
+    g_assert_true(get_irq(0));
+}
+
+/* The TMP75 maps F1:F0 = 10b to 3 consecutive faults. */
+static void test_tmp75_fault_queue(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    check_fault_queue(obj, TMP75_TEST_ID, TMP75_TEST_PATH, 2, 3);
+}
+
+/* The TMP175 keeps the TMP105 mapping: F1:F0 = 10b means 4 faults. */
+static void test_tmp175_fault_queue(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    check_fault_queue(obj, TMP175_TEST_ID, TMP175_TEST_PATH, 2, 4);
+}
+
+/*
+ * Toggling the thermostat mode (TM) bit clears any active alert on the TMP75.
+ */
+static void test_tmp75_tm_clears_alert(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP75_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3));
+    for (i = 0; i < 4; i++) {
+        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
+    }
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3) | TMP105_CONFIG_TM);
+    g_assert_false(get_irq(0));
+}
+
+/*
+ * The LM75B has a fixed 11-bit (0.125 C) converter: the resolution and one-shot
+ * Config bits are reserved (read/write as zero) and the temperature register is
+ * always masked to 11 bits regardless of what is written to Config.
+ */
+static void test_lm75b_resolution(void *obj, void *data,
+                                  QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    uint16_t value;
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
+    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x00);
+
+    qmp_tmp105_set_temperature(LM75B_TEST_ID, 20938);
+    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
+    g_assert_cmphex(value, ==, 0x14e0);
+}
+
+/* The LM75B set-point registers store only 9 bits. */
+static void test_lm75b_limits(void *obj, void *data,
+                              QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x4231);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4200);
+
+    i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x12b4);
+    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1280);
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -179,5 +282,40 @@ static void tmp105_register_nodes(void)
     qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
     qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
     qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
+
+    /* TMP75: register-compatible, but with a 1/2/3/4 fault queue. */
+    QOSGraphEdgeOptions tmp75_opts = {
+        .extra_device_opts = "id=" TMP75_TEST_ID ",address=0x48"
+    };
+    add_qi2c_address(&tmp75_opts, &(QI2CAddress) { 0x48 });
+
+    qos_node_create_driver("tmp75", i2c_device_create);
+    qos_node_consumes("tmp75", "i2c-bus", &tmp75_opts);
+
+    qos_add_test("fault-queue", "tmp75", test_tmp75_fault_queue, NULL);
+    qos_add_test("tm-clears-alert", "tmp75", test_tmp75_tm_clears_alert, NULL);
+
+    /* TMP175: like the TMP105, with a 1/2/4/6 fault queue. */
+    QOSGraphEdgeOptions tmp175_opts = {
+        .extra_device_opts = "id=" TMP175_TEST_ID ",address=0x4a"
+    };
+    add_qi2c_address(&tmp175_opts, &(QI2CAddress) { 0x4a });
+
+    qos_node_create_driver("tmp175", i2c_device_create);
+    qos_node_consumes("tmp175", "i2c-bus", &tmp175_opts);
+
+    qos_add_test("fault-queue", "tmp175", test_tmp175_fault_queue, NULL);
+
+    /* LM75B: fixed 11-bit conversion and 9-bit set-point registers. */
+    QOSGraphEdgeOptions lm75b_opts = {
+        .extra_device_opts = "id=" LM75B_TEST_ID ",address=0x4c"
+    };
+    add_qi2c_address(&lm75b_opts, &(QI2CAddress) { 0x4c });
+
+    qos_node_create_driver("lm75b", i2c_device_create);
+    qos_node_consumes("lm75b", "i2c-bus", &lm75b_opts);
+
+    qos_add_test("resolution", "lm75b", test_lm75b_resolution, NULL);
+    qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
 }
 libqos_init(tmp105_register_nodes);
-- 
2.55.0


