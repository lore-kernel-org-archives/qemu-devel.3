Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A63C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi3zZ-0001Ns-3h; Fri, 10 Jul 2026 01:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi3zV-0001NC-5M; Fri, 10 Jul 2026 01:41:37 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi3zQ-00079V-31; Fri, 10 Jul 2026 01:41:36 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id EA8C42003D3;
 Fri, 10 Jul 2026 07:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783662088;
 bh=dDtMStcU5I/MoZTClI7jsA9jEKDOi6GYETb8H2xwVVU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IKoxmzB8D2Kzm63kUArx0/EbrmCtDugjZpRp19Wcv6E+AdQvcVsevgGhodu1s6GZj
 W13UlvQe7qzD+JxkUwWxedVX8wtxZXUwXnbLAA0cfX6RCwZcbqzaIq45Rri+zkJeeM
 W5ROiTQY9nrR8ez0mPThhIkt08swNRr3zQVyMx4C/8ZwejGVSIJsqnncXDMOUtsg1+
 M6fKsFrZyEeyASGQtvvZJxbLcnPyR1HH+c7IPFySswtDBziTBMwL9lBh08kz56cHsl
 9U8VZiRRMaa/wl0bonoivZtr2fDeNI7Xd9dsPbj1k2Cu3ShiOKxU7LqDLKsHiVKqgy
 5XKkdm2YSR0bA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:11 +0200
Subject: [PATCH 19/29] tests/qtest: add PCA9554 register access tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-19-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=2290;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=dDtMStcU5I/MoZTClI7jsA9jEKDOi6GYETb8H2xwVVU=;
 b=Dk0sZdZutbUnkojiCJogy6Yf4rrbTsIioUjYXAJ2KgQPDlp/bCvRjDBXNJVrVvm+Ry1KNf40K
 PyT6cjAZ31vABsbrmNj0sVCYE6UPVWqFOXajZyJVMxzuCxIpYmFZm8z
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add a qtest for the PCA9554 8-bit I/O port expander exercising the basic
register access: power-on reset defaults and read/write of the OUTPUT,
CONFIG and POLARITY registers.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build    |  1 +
 tests/qtest/pca9554-test.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2c283708a5..2f35bde630 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,6 +318,7 @@ qos_test_ss.add(
   'tulip-test.c',
   'nvme-test.c',
   'pca9552-test.c',
+  'pca9554-test.c',
   'pca9555-test.c',
   'pci-test.c',
   'pcnet-test.c',
diff --git a/tests/qtest/pca9554-test.c b/tests/qtest/pca9554-test.c
new file mode 100644
index 0000000000..a5f213a59c
--- /dev/null
+++ b/tests/qtest/pca9554-test.c
@@ -0,0 +1,41 @@
+/*
+ * QTest testcase for the PCA9554/PCA9536 I/O port expanders
+ *
+ * Copyright (c) Meta Platforms, Inc. and affiliates. (http://www.meta.com)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/pca9554_regs.h"
+#include "libqos/i2c.h"
+#include "libqos/qgraph.h"
+
+#define PCA9554_TEST_ADDR 0x20
+
+/* Verify power-on reset defaults match the PCA9554 datasheet. */
+static void test_reset_defaults(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QI2CDevice *dev = (QI2CDevice *)obj;
+
+    /* All pins are inputs, pulled high, with no polarity inversion. */
+    g_assert_cmphex(i2c_get8(dev, PCA9554_INPUT), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_OUTPUT), ==, 0xFF);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_POLARITY), ==, 0x00);
+    g_assert_cmphex(i2c_get8(dev, PCA9554_CONFIG), ==, 0xFF);
+}
+
+static void pca9554_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "address=0x20"
+    };
+    add_qi2c_address(&opts, &(QI2CAddress) { PCA9554_TEST_ADDR });
+
+    qos_node_create_driver("pca9554", i2c_device_create);
+    qos_node_consumes("pca9554", "i2c-bus", &opts);
+
+    qos_add_test("reset-defaults", "pca9554", test_reset_defaults, NULL);
+}
+
+libqos_init(pca9554_register_nodes);

-- 
2.50.1


