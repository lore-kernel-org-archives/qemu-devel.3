Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C815C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPB-00045C-BN; Sun, 06 Sep 2026 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP5-0003wV-BT
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP3-0000H4-PG
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0cvcOMMXMIWk3qCx8ZaI/3Azr4XHQliMOdrysHZcf4=;
 b=Km8hlx/P/DvYTaAMf509/bcgd2ckIxZ1dLrsZRP+DzPrFo3MtkSYMx+OfylLMGIPLn7eUz
 c5dGeTXZ75j1IIwJvaAh+Chpo75X2CTpJTQwFQUOrLhBno2fWbh+ZWKrw2A6ohEomjyne3
 /yi8PT0GvDYHpcHCHgpzyRYg09vfPoo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-KStbx4f2M6u96Ib1wxZAkw-1; Sun,
 06 Sep 2026 13:11:35 -0400
X-MC-Unique: KStbx4f2M6u96Ib1wxZAkw-1
X-Mimecast-MFC-AGG-ID: KStbx4f2M6u96Ib1wxZAkw_1788714694
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32F7D1805A2B; Sun,  6 Sep 2026 17:11:34 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 966941955F06; Sun,  6 Sep 2026 17:11:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/40] tests/qtest: tmp105: cover the ALERT fault queue
Date: Sun,  6 Sep 2026 19:10:13 +0200
Message-ID: <20260906171021.26568-33-clg@redhat.com>
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

Add two qgraph tests exercising the ALERT pin, the only way the TMP105
exposes its alarm state. One checks the default single-fault behaviour;
the other checks a deeper fault queue, including the running-count reset
on an in-range conversion and its effect on both asserting and releasing
the alarm.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-8-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/tmp105-test.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
index 3b114a50f550..29a031fb7bfe 100644
--- a/tests/qtest/tmp105-test.c
+++ b/tests/qtest/tmp105-test.c
@@ -17,6 +17,11 @@
 
 #define TMP105_TEST_ID   "tmp105-test"
 #define TMP105_TEST_ADDR 0x49
+#define TMP105_TEST_PATH "/machine/peripheral/" TMP105_TEST_ID
+
+#define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
+#define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
+#define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
 
 static int qmp_tmp105_get_temperature(const char *id)
 {
@@ -105,6 +110,62 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4230);
 }
 
+/*
+ * The TMP105 exposes its alarm state only through the ALERT pin.
+ */
+static void test_alert_single_fault(void *obj, void *data,
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
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_false(get_irq(0));
+}
+
+static void test_fault_queue(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *i2cdev = (QI2CDevice *)obj;
+    int i;
+
+    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
+
+    /* Comparator mode, active-high ALERT, fault queue of four. */
+    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 25000);
+    g_assert_false(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+        g_assert_false(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
+    g_assert_true(get_irq(0));
+
+    for (i = 0; i < 3; i++) {
+        qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+        g_assert_true(get_irq(0));
+    }
+
+    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
+    g_assert_false(get_irq(0));
+}
+
 static void tmp105_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -116,5 +177,7 @@ static void tmp105_register_nodes(void)
     qos_node_consumes("tmp105", "i2c-bus", &opts);
 
     qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
+    qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
+    qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
 }
 libqos_init(tmp105_register_nodes);
-- 
2.55.0


