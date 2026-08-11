Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1732BC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpOJ-00048w-KC; Tue, 11 Aug 2026 12:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOI-000413-EZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOD-0000t5-J5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DcNtCdhOtUXzKs5m7nZGGn0QrTG3rSX15l8MtYktaM=;
 b=EBqV2n+ccg4tl7ZUSqKxwMkBXQid2EEOfQf9fgR6z+tVLjCpyEyx9+uD7wbg71OCyqbpMJ
 OJQxZcepAvMfMQMzAuYWGJGHlJAzdevnriWZkmozmWPnWMZBEIfOVe3Cj96rDe6BMdW/mz
 kU6UWmgFuCEcqf2EDhhcwfgtOk/9OGU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-AfR-b-xuNi-1iDEl1yJl3Q-1; Tue,
 11 Aug 2026 12:31:41 -0400
X-MC-Unique: AfR-b-xuNi-1iDEl1yJl3Q-1
X-Mimecast-MFC-AGG-ID: AfR-b-xuNi-1iDEl1yJl3Q_1786465900
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A531800646; Tue, 11 Aug 2026 16:31:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A196195DF91; Tue, 11 Aug 2026 16:31:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 54/83] tests/qtest: pca9554: test polarity inversion
Date: Tue, 11 Aug 2026 18:29:09 +0200
Message-ID: <20260811162938.1403216-55-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Verify that the polarity register inverts the value read back from the
INPUT register, both on pulled-up inputs and on output-driven pins, while
leaving the OUTPUT register itself unchanged.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-21-82a63fead90c@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9554-test.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
index ce6e90f3f881..74237df611ea 100644
--- a/tests/qtest/pca9554-test.c
+++ b/tests/qtest/pca9554-test.c
@@ -67,6 +67,41 @@ static void test_input_pullup(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
 }
 
+/*
+ * Polarity inversion: reading INPUT returns the XOR of the pin levels and the
+ * polarity register.
+ */
+static void test_polarity_inversion(void *obj, void *data,
+                                    QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x00);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0x0F);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xF0);
+}
+
+/* Polarity inversion combined with output-driven pins. */
+static void test_polarity_with_output(void *obj, void *data,
+                                      QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    i2c_set8(dev, PCA9554_CONFIG, 0x00);
+    i2c_set8(dev, PCA9554_OUTPUT, 0xA5);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xA5);
+
+    i2c_set8(dev, PCA9554_POLARITY, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0x5A);
+
+    /* Inversion only affects the INPUT read, not the OUTPUT register. */
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xA5);
+}
+
 static void pca9554_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
@@ -81,6 +116,10 @@ static void pca9554_register_nodes(void)
     qos_add_test("output-drives-input", "pca9554", test_output_drives_input,
                  NULL);
     qos_add_test("input-pullup", "pca9554", test_input_pullup, NULL);
+    qos_add_test("polarity-inversion", "pca9554", test_polarity_inversion,
+                 NULL);
+    qos_add_test("polarity-with-output", "pca9554", test_polarity_with_output,
+                 NULL);
 }
 
 libqos_init(pca9554_register_nodes);
-- 
2.55.0


