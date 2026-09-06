Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9575C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPC-00048a-S1; Sun, 06 Sep 2026 13:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPA-00042f-Ug
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP8-0000IR-V7
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejaNlsfuqiQ5txCozc0FdpNb+CS3CGFTF26qsu3Itv4=;
 b=MaUTgkN15x42jrNDWAHhdPgJ6H9+cR8e4rOyIo7LPUNJe703xSM0rK8L1ep8hYaimpak+K
 V/9xneF3WSsVdsBUprT9/VfFQKM3Ihzi4tIHYP0LoDAglKe0a8w/vXhnaCCNurkSFc8HVc
 AQ+erDTWnq0eIYWx5a0FgMLDcpP32w8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-81eNwnAjPsGxuVOdwe6uHg-1; Sun,
 06 Sep 2026 13:11:38 -0400
X-MC-Unique: 81eNwnAjPsGxuVOdwe6uHg-1
X-Mimecast-MFC-AGG-ID: 81eNwnAjPsGxuVOdwe6uHg_1788714698
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA551802648; Sun,  6 Sep 2026 17:11:37 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77F9E1955F06; Sun,  6 Sep 2026 17:11:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/40] tests/qtest: tmp105: cover one-shot and fault-queue
 write immunity
Date: Sun,  6 Sep 2026 19:10:15 +0200
Message-ID: <20260906171021.26568-35-clg@redhat.com>
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

Verify that the one-shot (OS) bit triggers a conversion only in shutdown
mode and is ignored in continuous mode, and that
configuration/limit-register writes never advance the fault queue — only
real conversions do.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-10-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/tmp105-test.c | 102 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index ea6803715a39..e586a634d8fb 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -33,6 +33,8 @@
 #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
 #define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
 #define TMP105_CONFIG_FQ(f) ((f) << 3) /* raw F1:F0 fault-queue field value */
+#define TMP105_CONFIG_SD    (1 << 0)   /* shutdown mode */
+#define TMP105_CONFIG_OS    (1 << 7)   /* one-shot conversion */
 
 static int qmp_tmp105_get_temperature(const char *id)
 {
@@ -200,6 +202,102 @@ static void check_fault_queue(QI2CDevice *i2cdev, const char *id,
     g_assert_true(get_irq(0));
 }
 
+/*
+ * The one-shot (OS) bit starts a conversion only in shutdown mode. In
+ * continuous mode it is ignored, so writing it must not advance the fault
+ * queue; in shutdown each OS write performs one conversion that does.
+ */
+static void test_one_shot(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 8; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG,
+                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_OS);
+        g_assert_false(get_irq(0));
+    }
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD);
+    for (i = 0; i < 2; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
+                 TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
+        g_assert_false(get_irq(0));
+    }
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
+             TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
+    g_assert_true(get_irq(0));
+}
+
+/*
+ * Configuration and limit-register writes are not conversions and must not
+ * advance the fault queue.
+ */
+static void test_fault_queue_ignores_writes(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    g_assert_false(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 8; i++) {
+        i2c_set8(i2cdev, TMP105_REG_CONFIG,
+                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+        i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x5000);
+        i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x4b00);
+        g_assert_false(get_irq(0));
+    }
+
+    for (i = 0; i < 2; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+}
+
+/*
+ * Leaving shutdown (SD 1->0) resumes continuous conversion, which must
+ * re-evaluate the current temperature against the limits.
+ */
+static void test_wake_from_shutdown(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
+    g_assert_false(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1 | TMP105_CONFIG_SD);
+    g_assert_true(get_irq(0));
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
+    g_assert_false(get_irq(0));
+}
+
 /* The TMP75 maps F1:F0 = 10b to 3 consecutive faults. */
 static void test_tmp75_fault_queue(void *obj, void *data,
                                    QGuestAllocator *alloc)
@@ -282,6 +380,10 @@ static void tmp105_register_nodes(void)
     qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
     qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
     qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
+    qos_add_test("fault-queue-ignores-writes", "tmp105",
+                 test_fault_queue_ignores_writes, NULL);
+    qos_add_test("one-shot", "tmp105", test_one_shot, NULL);
+    qos_add_test("wake-from-shutdown", "tmp105", test_wake_from_shutdown, NULL);
 
     /* TMP75: register-compatible, but with a 1/2/3/4 fault queue. */
     QOSGraphEdgeOptions tmp75_opts = {
-- 
2.55.0


