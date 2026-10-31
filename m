Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LzCoEJHN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN35U-0006NA-Cu; Sat, 31 Oct 2026 03:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN344-0003G0-UM
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xN340-0002vv-PR
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 02:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793429978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5w/V70z7v3JyXxRxGVsN8o1ELdr6hdSsQY+zyVSluU=;
 b=LzCoEJHNclPYQ1G7iIpW/3tc8jCJXSXFu6KwBIGxeng4NF2LEiA/oye125J7s82U6hydJn
 sQC8Bf39eYplfqs90Al4J89nVjzkiPLiI/IXQlG+NmtNF0VF+saykSnmMvfsLFl/fxzdjZ
 J1VV2YwmtqNjQDwlU+l2h8ZyBUJeS/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-jWoz49etNZ-puTGbPselEA-1; Sat,
 31 Oct 2026 02:59:34 -0400
X-MC-Unique: jWoz49etNZ-puTGbPselEA-1
X-Mimecast-MFC-AGG-ID: jWoz49etNZ-puTGbPselEA_1793429973
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7B918007F2; Sat, 31 Oct 2026 06:59:33 +0000 (UTC)
Received: from circe.redhat.com (unknown [10.44.32.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED6AE1800677; Sat, 31 Oct 2026 06:59:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/34] tests/qtest: pca9545: add mux test
Date: Sat, 31 Oct 2026 07:58:18 +0100
Message-ID: <20261031065823.191966-30-clg@redhat.com>
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
References: <20261031065823.191966-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Emmanuel Blot <emmanuel.blot@free.fr>

Exercise the PCA9545 4-channel I2C mux: channel selection through the
control byte, upper-nibble read-back, and interrupt logic.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20261015-bmc-minerva-v3-7-7d50c8a108e5@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pca9545-test.c | 116 +++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build    |   1 +
 2 files changed, 117 insertions(+)
 create mode 100644 tests/qtest/pca9545-test.c

diff --git a/tests/qtest/pca9545-test.c b/tests/qtest/pca9545-test.c
new file mode 100644
index 000000000000..91f56db92fe1
--- /dev/null
+++ b/tests/qtest/pca9545-test.c
@@ -0,0 +1,116 @@
+/*
+ * QTest testcase for the PCA9545 4-channel I2C switch with interrupt logic
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "libqos/qgraph.h"
+#include "libqos/i2c.h"
+
+#define PCA9545_TEST_ID   "pca9545-test"
+#define PCA9545_TEST_ADDR 0x70
+#define PCA9545_TEST_PATH "/machine/peripheral/" PCA9545_TEST_ID
+
+/* INTn and INT are active low: level 0 is asserted. */
+#define INT_ASSERTED   0
+#define INT_RELEASED   1
+
+/* The mux has no register pointer: a read/write moves a single control byte. */
+static uint8_t pca9545_get(QI2CDevice *dev)
+{
+    uint8_t val;
+
+    qi2c_recv(dev, &val, 1);
+    return val;
+}
+
+static void pca9545_set(QI2CDevice *dev, uint8_t val)
+{
+    qi2c_send(dev, &val, 1);
+}
+
+static void pca9545_set_int(unsigned chan, int level)
+{
+    qtest_set_irq_in(global_qtest, PCA9545_TEST_PATH, "interrupt", chan, level);
+}
+
+/* Channel selection is the lower nibble; the upper nibble reads back 0. */
+static void test_channel_select(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
+
+    pca9545_set(dev, 0x05); /* channels 0 and 2 */
+    g_assert_cmphex(pca9545_get(dev), ==, 0x05);
+
+    pca9545_set(dev, 0x0f); /* all channels */
+    g_assert_cmphex(pca9545_get(dev), ==, 0x0f);
+
+    pca9545_set(dev, 0x00);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
+}
+
+/*
+ * The interrupt status is reported in the upper nibble (INT3..INT0) and is
+ * latched regardless of which channels are selected (PCA9545A Table 5).
+ */
+static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    pca9545_set_int(1, INT_ASSERTED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x20);
+
+    pca9545_set(dev, 0x01);
+    pca9545_set_int(3, INT_ASSERTED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0xa1); /* INT3 | INT1 | channel 0 */
+
+    pca9545_set_int(1, INT_RELEASED);
+    g_assert_cmphex(pca9545_get(dev), ==, 0x81); /* INT3 | channel 0 */
+}
+
+/* The INT output is pulled low while any channel interrupt is active. */
+static void test_interrupt_output(void *obj, void *data, QGuestAllocator *alloc)
+{
+    qtest_irq_intercept_out_named(global_qtest, PCA9545_TEST_PATH,
+                                  "interrupt-out");
+
+    /*
+     * Interception starts with no recorded level, so drive an idle input
+     * first to make the mux publish the released state of its output.
+     */
+    pca9545_set_int(0, INT_RELEASED);
+    g_assert_true(get_irq(0));
+
+    pca9545_set_int(0, INT_ASSERTED);
+    g_assert_false(get_irq(0));
+
+    pca9545_set_int(2, INT_ASSERTED);
+    g_assert_false(get_irq(0));
+
+    pca9545_set_int(0, INT_RELEASED);
+    g_assert_false(get_irq(0));
+    pca9545_set_int(2, INT_RELEASED);
+    g_assert_true(get_irq(0));
+}
+
+static void pca9545_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "id=" PCA9545_TEST_ID ",address=0x70"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { PCA9545_TEST_ADDR });
+
+    qos_node_create_driver("pca9545", i2c_device_create);
+    qos_node_consumes("pca9545", "i2c-bus", &opts);
+
+    qos_add_test("channel-select", "pca9545", test_channel_select, NULL);
+    qos_add_test("interrupt-status", "pca9545", test_interrupt_status, NULL);
+    qos_add_test("interrupt-output", "pca9545", test_interrupt_output, NULL);
+}
+libqos_init(pca9545_register_nodes);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46d4fc1d2b03..c461d2a4a104 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -342,6 +342,7 @@ qos_test_ss.add(
   'ne2000-test.c',
   'tulip-test.c',
   'nvme-test.c',
+  'pca9545-test.c',
   'pca9552-test.c',
   'pca9554-test.c',
   'pca9555-test.c',
-- 
2.56.0


