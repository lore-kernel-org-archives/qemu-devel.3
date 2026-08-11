Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BD6C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO5-00035D-Pr; Tue, 11 Aug 2026 12:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNy-0002Mu-4P
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNw-0000p4-4s
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tujp5TDOtqGhFmE2T0xtEIYvf18hEA30nkC3YqSoPeI=;
 b=BIGh9zU/1yzcZqpOLLup4AeCd1BO7OcMf9ZYDXXl6dze5CkG+pPIxlBTyOatJV40iYOWtW
 Qp4MzQ7c820V7YgCYXLWxOtgUqLSEtUjsbowWLdnJ9QRIdLeFsppGnpV57bix54626Jnk0
 occcw90v+IaQmisUp4MYrCIZnbMi4iA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-oKfMCGvENP6rOfpt7XhRWA-1; Tue,
 11 Aug 2026 12:31:19 -0400
X-MC-Unique: oKfMCGvENP6rOfpt7XhRWA-1
X-Mimecast-MFC-AGG-ID: oKfMCGvENP6rOfpt7XhRWA_1786465878
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EE2F1800149; Tue, 11 Aug 2026 16:31:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7819D195DF91; Tue, 11 Aug 2026 16:31:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/83] tests/qtest: pca9555: test output-to-input reflection
 and pull-ups
Date: Tue, 11 Aug 2026 18:28:59 +0200
Message-ID: <20260811162938.1403216-45-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add tests covering the pin I/O semantics of the expander: output-driven
pins reflected in the input register, the pull-up seen on input-configured
pins, and the independence of the two 8-bit ports.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-11-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9555-test.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 5945c3441e92..6b085702c3c8 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -28,6 +28,77 @@ static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
 }
 
+/*
+ * When a pin is configured as output and driven low (output=0, config=0),
+ * the input register should reflect 0 for that pin.
+ * When driven high (output=1, config=0), input should reflect 1.
+ * When configured as input (config=1), PCA5555 pull-up makes it read 1.
+ */
+static void test_output_drives_input(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0xF0);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+}
+
+/*
+ * When all pins are inputs (config=0xFF) and no external driver,
+ * PCA9555 pull-ups should make the input register read all ones.
+ * Switching a pin to output mode with output=0 should drive it low.
+ */
+static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+}
+
+/*
+ * Test that both ports are independent: changing port 0 registers
+ * should not affect port 1 and vice versa.
+ */
+static void test_port_independence(void *obj, void *data,
+                                   QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x00);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0xAA);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -39,6 +110,10 @@ static void pca9555_register_nodes(void)
     qos_node_consumes("pca9555", "i2c-bus", &opts);
 
     qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
+    qos_add_test("output-drives-input", "pca9555", test_output_drives_input,
+                 NULL);
+    qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
+    qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
 }
 
 libqos_init(pca9555_register_nodes);
-- 
2.55.0


