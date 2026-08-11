Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92F7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOP-0004Ow-Un; Tue, 11 Aug 2026 12:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOK-0004CK-2S
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOI-0000uJ-8N
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4QBAtD9TgPXiwEI/+x/fZeybIwbyp83dTnbW70H9Wcg=;
 b=Ol8oUCqU4IE3xYiwCeEIe9IueYGvNKQNlfkMudfpikCzluoYLL5DhRqAjary/n8Lw3PMIp
 ueLIffG/EdwVgpFpegb4V20073uTTrz5ZV6n0aUNy7vdyO651Pp9IW86JeFAG6JSbDxXVH
 ACkNGT32cLFpkxRfOlaayVNtVXtVgeA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-FxiFl2aGMrKT-RRqMoI-MA-1; Tue,
 11 Aug 2026 12:31:46 -0400
X-MC-Unique: FxiFl2aGMrKT-RRqMoI-MA-1
X-Mimecast-MFC-AGG-ID: FxiFl2aGMrKT-RRqMoI-MA_1786465904
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B87391954B1F; Tue, 11 Aug 2026 16:31:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10FEE195DF91; Tue, 11 Aug 2026 16:31:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 56/83] tests/qtest: pca9554: test the PCA9536 4-bit variant
Date: Tue, 11 Aug 2026 18:29:11 +0200
Message-ID: <20260811162938.1403216-57-clg@redhat.com>
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

The PCA9536 shares the PCA9554 register map and code path but exposes
only four pins. Add a pca9536 node and check its reset defaults and
output-to-input reflection are masked to the low nibble.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-23-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9554-test.c | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index 0da1f3304b9d..5366e719845c 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -129,6 +129,66 @@ static void test_no_autoincrement(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x33);
 }
 
+/*
+ * The PCA9536 shares the PCA9554 register map but only has four pins, so its
+ * reset defaults and pin logic are masked to the low nibble.
+ */
+static void test_pca9536_reset_defaults(void *obj, void *data,
+                                        QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x0F);
+}
+
+/* Only the four low pins are driven; the upper nibble stays low. */
+static void test_pca9536_output_drives_input(void *obj, void *data,
+                                             QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0x0A);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0A);
+
+    i2c_set8(dev, PCA9554_OUTPUT, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+}
+
+/*
+ * The four upper bits address pins that do not exist on the PCA9536, so writes
+ * to the register map discard them: the writable registers read back with bits
+ * [7:4] cleared, and driving them onto the pins never surfaces in INPUT.
+ */
+static void test_pca9536_ignores_upper_bits(void *obj, void *data,
+                                            QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* Bits [7:4] are dropped on write; bits [3:0] survive. */
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFA);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0x0A);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xF5);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x05);
+
+    i2c_set8(dev, PCA9554_CONFIG, 0xF3);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0x03);
+
+    /*
+     * With all four pins as outputs, driving 0xFF only affects the low
+     * nibble.
+     */
+    i2c_set8(dev, PCA9554_POLARITY, 0x00);
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    i2c_set8(dev, PCA9554_OUTPUT, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x0F);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -148,6 +208,16 @@ static void pca9554_register_nodes(void)
     qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
                  NULL);
     qos_add_test("no-autoincrement", "pca9554", test_no_autoincrement, NULL);
+
+    qos_node_create_driver("pca9536", i2c_device_create);
+    qos_node_consumes("pca9536", "i2c-bus", &opts);
+
+    qos_add_test("reset-defaults", "pca9536", test_pca9536_reset_defaults,
+                 NULL);
+    qos_add_test("output-drives-input", "pca9536",
+                 test_pca9536_output_drives_input, NULL);
+    qos_add_test("ignores-upper-bits", "pca9536",
+                 test_pca9536_ignores_upper_bits, NULL);
 }
 
 libqos_init(pca9554_register_nodes);
-- 
2.55.0


