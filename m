Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA349C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO3-0002jT-Lz; Tue, 11 Aug 2026 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNz-0002Ud-Kg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNx-0000pN-OK
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIKwRvIk8UFULuloL3p9vNU9/hBxiTwlrZk1ohv1ib4=;
 b=NHDVMl4zh858yVcPTx8CgJ8WGKQNh6h6VKACroGjweRndHVgi8R3SV66pw3OjNvLuHKhUQ
 FL7MRBiurmA1elR6wrh9As0LgDogvYPu4Z/CS5i/ciewTfN0CNz15ySKhsg6LJUFQevB3c
 QJcd9Pv7C2ezaOL1nYPjcRPRtI3S8zE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-_PmuFVC6OP6aDuaQLkHj4w-1; Tue,
 11 Aug 2026 12:31:23 -0400
X-MC-Unique: _PmuFVC6OP6aDuaQLkHj4w-1
X-Mimecast-MFC-AGG-ID: _PmuFVC6OP6aDuaQLkHj4w_1786465882
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F9EB1800637; Tue, 11 Aug 2026 16:31:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD1EF195DF9A; Tue, 11 Aug 2026 16:31:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 46/83] tests/qtest: pca9555: test auto-increment and command
 wrapping
Date: Tue, 11 Aug 2026 18:29:01 +0200
Message-ID: <20260811162938.1403216-47-clg@redhat.com>
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

Add tests for the I2C command protocol of the GPIO variant: the
auto-increment that toggles bit 0 within a register pair on reads and
writes, and the 3-bit command wrapping that aliases out-of-range register
addresses back into the register window.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-13-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9555-test.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 2afa061bd2e0..84d771bcbb81 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -139,6 +139,87 @@ static void test_polarity_with_output(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
 }
 
+/*
+ * The PCA9555 auto-increments by toggling bit 0 of the command pointer
+ * within a register pair. Reading two bytes from INPUT0 should yield
+ * INPUT0 then INPUT1.
+ */
+static void test_auto_increment_read(void *obj, void *data,
+                                     QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_CONFIG1, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
+
+    i2c_read_block(dev, PCA9535_INPUT0, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0xAA);
+    g_assert_cmphex(buf[1], ==, 0x55);
+
+    i2c_read_block(dev, PCA9535_OUTPUT0, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0xAA);
+    g_assert_cmphex(buf[1], ==, 0x55);
+}
+
+/*
+ * Auto-increment write: writing two data bytes after a command byte
+ * should write to port 0 then port 1 of the addressed register pair.
+ */
+static void test_auto_increment_write(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    buf[0] = 0x12;
+    buf[1] = 0x34;
+    i2c_write_block(dev, PCA9535_OUTPUT0, buf, 2);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0x12);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0x34);
+
+    buf[0] = 0x0F;
+    buf[1] = 0xF0;
+    i2c_write_block(dev, PCA9535_CONFIG0, buf, 2);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG0), ==, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xF0);
+}
+
+/*
+ * Auto-increment toggles within the pair: starting from port 1 should
+ * wrap back to port 0 (toggle bit 0).
+ */
+static void test_auto_increment_toggle(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+    uint8_t buf[2];
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xAA);
+    i2c_set8(dev, PCA9535_OUTPUT1, 0x55);
+
+    i2c_read_block(dev, PCA9535_OUTPUT1, buf, 2);
+    g_assert_cmphex(buf[0], ==, 0x55);
+    g_assert_cmphex(buf[1], ==, 0xAA);
+}
+
+/*
+ * Verify the command byte wraps at 3 bits: register addresses
+ * beyond 7 should alias to the same register (bits [2:0] only).
+ */
+static void test_command_wrapping(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_OUTPUT0, 0x42);
+
+    g_assert_cmphex(i2c_get8(dev, 0x0A), ==, 0x42);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -158,6 +239,13 @@ static void pca9555_register_nodes(void)
                  NULL);
     qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
                  NULL);
+    qos_add_test("auto-increment-read", "pca9555", test_auto_increment_read,
+                 NULL);
+    qos_add_test("auto-increment-write", "pca9555", test_auto_increment_write,
+                 NULL);
+    qos_add_test("auto-increment-toggle", "pca9555", test_auto_increment_toggle,
+                 NULL);
+    qos_add_test("command-wrapping", "pca9555", test_command_wrapping, NULL);
 }
 
 libqos_init(pca9555_register_nodes);
-- 
2.55.0


