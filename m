Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDC5C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpO4-0002tc-Hj; Tue, 11 Aug 2026 12:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNt-0001zL-Dz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNr-0000o4-Jl
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXAWtw7Em+ptZ30dAYgIonsq2wUGiEIUYdNgiY4wFrE=;
 b=RqUO+qzIif7u1wQexksTDpChrgD1KayXqERBnB6RZe4FvQf8X2JUqG0Hvg0gPE/LO0XbSm
 LKI+dFzyNs+Ucj/B4dmjEZYQp2CTtN3AfYDMFBkyFvylKupRaEuqbElNyZqV+i+GILh2Lw
 XX4F6oPsRitftVd/OQ9Zxeth9i/n3YU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-c6G47kS3PNWQXM34-T5Gbg-1; Tue,
 11 Aug 2026 12:31:21 -0400
X-MC-Unique: c6G47kS3PNWQXM34-T5Gbg-1
X-Mimecast-MFC-AGG-ID: c6G47kS3PNWQXM34-T5Gbg_1786465880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DC5C1800878; Tue, 11 Aug 2026 16:31:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B27D195DF9A; Tue, 11 Aug 2026 16:31:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 45/83] tests/qtest: pca9555: test polarity inversion
Date: Tue, 11 Aug 2026 18:29:00 +0200
Message-ID: <20260811162938.1403216-46-clg@redhat.com>
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

Add tests for the polarity inversion register: the inversion is applied
when reading the INPUT register, both for input pins (pull-up) and for
output-driven pins, and it does not affect the OUTPUT register readback.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-12-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
index 6b085702c3c8..2afa061bd2e0 100644
--- a/tests/qtest/pca9555-test.c
+++ b/tests/qtest/pca9555-test.c
@@ -99,6 +99,46 @@ static void test_port_independence(void *obj, void *data,
     g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xAA);
 }
 
+/*
+ * Polarity inversion: reading INPUT with polarity bits set should
+ * return the XOR of the actual input state and the polarity register.
+ */
+static void test_polarity_inversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x00);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xF0);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+
+    i2c_set8(dev, PCA9535_POLARITY1, 0xAA);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0x55);
+}
+
+/* Polarity inversion combined with output-driven pins. */
+static void test_polarity_with_output(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9535_CONFIG0, 0x00);
+    i2c_set8(dev, PCA9535_OUTPUT0, 0xA5);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xA5);
+
+    i2c_set8(dev, PCA9535_POLARITY0, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0x5A);
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xA5);
+}
+
 static void pca9555_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -114,6 +154,10 @@ static void pca9555_register_nodes(void)
                  NULL);
     qos_add_test("input-pullup", "pca9555", test_input_pullup, NULL);
     qos_add_test("port-independence", "pca9555", test_port_independence, NULL);
+    qos_add_test("polarity-inversion", "pca9555", test_polarity_inversion,
+                 NULL);
+    qos_add_test("polarity-with-output", "pca9555", test_polarity_with_output,
+                 NULL);
 }
 
 libqos_init(pca9555_register_nodes);
-- 
2.55.0


