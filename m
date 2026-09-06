Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167AFC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPE-0004G9-0g; Sun, 06 Sep 2026 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPC-00046w-CA
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPA-0000Jy-N9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q69pms8gaMdr2ik+KlGi2WEEWgq1+PbIKAL1Y/+akQM=;
 b=OuMbA5Ht2EWjg59w/DCoFfXFJ/yuRbmCxlxLk2+UPSZmIoRhPjgjKzhEGqecjNvBuaSunt
 44ppRFynVmupsoNBeJDlOMDJfJ+zF1Ue4+Up1Rw1nkKt52N6+z2yYosixj6o72NeyxnlmM
 i2zuzdhV4FNmP7Qw5KPPZhU3qGWGNVY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-pWanUZ-SPzWPBY2aMTgq1g-1; Sun,
 06 Sep 2026 13:11:40 -0400
X-MC-Unique: pWanUZ-SPzWPBY2aMTgq1g-1
X-Mimecast-MFC-AGG-ID: pWanUZ-SPzWPBY2aMTgq1g_1788714699
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDEBB1954235; Sun,  6 Sep 2026 17:11:39 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 539A61955F06; Sun,  6 Sep 2026 17:11:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/40] tests/qtest: tmp105: cover shutdown clearing the ALERT
 across variants
Date: Sun,  6 Sep 2026 19:10:16 +0200
Message-ID: <20260906171021.26568-36-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Verify that entering shutdown clears the ALERT/OS output in interrupt
mode but leaves it asserted in comparator mode, for both the TMP75 and
the LM75B.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-11-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/tmp105-test.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index e586a634d8fb..504f6b720224 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -335,6 +335,41 @@ static void test_tmp75_tm_clears_alert(void *obj, void *data,
     g_assert_false(get_irq(0));
 }
 
+/*
+ * Entering shutdown clears the ALERT in interrupt mode but leaves it asserted
+ * in comparator mode.
+ */
+static void test_tmp75_shutdown_clears_alert(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP75_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3));
+    for (i = 0; i < 4; i++) {
+        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
+    }
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3) |
+             TMP105_CONFIG_SD);
+    g_assert_false(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3));
+    for (i = 0; i < 4; i++) {
+        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
+    }
+    g_assert_true(get_irq(0));
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3) | TMP105_CONFIG_SD);
+    g_assert_true(get_irq(0));
+}
+
 /*
  * The LM75B has a fixed 11-bit (0.125 C) converter: the resolution and one-shot
  * Config bits are reserved (read/write as zero) and the temperature register is
@@ -367,6 +402,23 @@ static void test_lm75b_limits(void *obj, void *data,
     g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1280);
 }
 
+/* The LM75B likewise resets its OS output on shutdown in interrupt mode. */
+static void test_lm75b_shutdown_clears_alert(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+
+    qtest_irq_intercept_out(global_qtest, LM75B_TEST_PATH);
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_TM);
+    qmp_tmp105_set_temperature(LM75B_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    i2c_set8(i2cdev, TMP105_REG_CONFIG,
+             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_SD);
+    g_assert_false(get_irq(0));
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -396,6 +448,8 @@ static void tmp105_register_nodes(void)
 
     qos_add_test("fault-queue", "tmp75", test_tmp75_fault_queue, NULL);
     qos_add_test("tm-clears-alert", "tmp75", test_tmp75_tm_clears_alert, NULL);
+    qos_add_test("shutdown-clears-alert", "tmp75",
+                 test_tmp75_shutdown_clears_alert, NULL);
 
     /* TMP175: like the TMP105, with a 1/2/4/6 fault queue. */
     QOSGraphEdgeOptions tmp175_opts = {
@@ -419,5 +473,7 @@ static void tmp105_register_nodes(void)
 
     qos_add_test("resolution", "lm75b", test_lm75b_resolution, NULL);
     qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
+    qos_add_test("shutdown-clears-alert", "lm75b",
+                 test_lm75b_shutdown_clears_alert, NULL);
 }
 libqos_init(tmp105_register_nodes);
-- 
2.55.0


