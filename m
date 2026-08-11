Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F5EC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNv-00026Q-VM; Tue, 11 Aug 2026 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNr-0001st-7e
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpNo-0000nQ-VC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrJ+2OfQv+KByRO7sKLKGfL+OVLjZ4JAkfZsy88ftpA=;
 b=LUZxXAFgpGyXrJ3AXYRjlM3mukqH6TKInwwtnYtBqL+2akctFwn9XoTXxwOomNDT3jHLoP
 A1Y9l7Im9JJH3AF+6ZbuADy0b6EJaDLq8wbR3g7u+DlwOhRHYc4dwhpQSrTMQSvWoItdVS
 HIK3sv1YrRjkO/96txCg8PQeWz5eoew=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-RxQvZBJWPSyDJHMViCI8OQ-1; Tue,
 11 Aug 2026 12:31:17 -0400
X-MC-Unique: RxQvZBJWPSyDJHMViCI8OQ-1
X-Mimecast-MFC-AGG-ID: RxQvZBJWPSyDJHMViCI8OQ_1786465876
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 077F418009C0; Tue, 11 Aug 2026 16:31:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53994195DF91; Tue, 11 Aug 2026 16:31:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 43/83] tests/qtest: add PCA9555 register access tests
Date: Tue, 11 Aug 2026 18:28:58 +0200
Message-ID: <20260811162938.1403216-44-clg@redhat.com>
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

Introduce a qtest for the PCA9555 16-bit I/O port expander.

This first set covers the power-on reset defaults and the read/write
behaviour of the OUTPUT, CONFIG and POLARITY register pairs.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260709-catalina-upgrade-v1-10-814575bc076b@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build    |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 tests/qtest/pca9555-test.c

diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
new file mode 100644
index 000000000000..5945c3441e92
--- /dev/null
+++ b/tests/qtest/pca9555-test.c
@@ -0,0 +1,44 @@
+/*
+ * QTest testcase for the PCA9555 16-bit I/O port expander
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/pca9552_regs.h"
+#include "libqos/i2c.h"
+#include "libqos/qgraph.h"
+
+#define PCA9555_TEST_ADDR 0x20
+
+/* Verify power-on reset defaults match the PCA9555 datasheet. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_INPUT1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_OUTPUT1), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_POLARITY0), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_POLARITY1), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG0), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9535_CONFIG1), ==, 0xFF);
+}
+
+static void pca9555_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "address=0x20"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { PCA9555_TEST_ADDR });
+
+    qos_node_create_driver("pca9555", i2c_device_create);
+    qos_node_consumes("pca9555", "i2c-bus", &opts);
+
+    qos_add_test("reset-defaults", "pca9555", test_reset_defaults, NULL);
+}
+
+libqos_init(pca9555_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e1fc597e6d1..e92130bd04dd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -319,6 +319,7 @@ qos_test_ss.add(
   'tulip-test.c',
   'nvme-test.c',
   'pca9552-test.c',
+  'pca9555-test.c',
   'pci-test.c',
   'pcnet-test.c',
   'rs5c372-test.c',
-- 
2.55.0


