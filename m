Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660BAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqf1-00046W-Mo; Thu, 09 Jul 2026 11:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqf0-000454-1n; Thu, 09 Jul 2026 11:27:34 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqex-0000yw-EX; Thu, 09 Jul 2026 11:27:33 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 475A52003C1;
 Thu,  9 Jul 2026 17:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610849;
 bh=6C6R6L/HzmschTunAg/gYTBr73faxfTgYnk1vNesInI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=G2q6gH7jO9/2bhiJevavw2eUyZZhaGdYLyCSf01i57DpEcCQkkc8gmWQhYvsBYn3/
 V3S9FUStntK6qhGdTsvDJ6HqnvxUxR8fbEsAnexx+xoVfMJMm7uojG5DtKy443ggAS
 rn0fnU5X9W7hTQta9d51UHF8iaq7ADFRi/rvLwvqa4xXd0lL9ElPuahlaPz+c4e+Wr
 BH1B8UT2sZIUMjmDrklV0mjgd/Y0+sKfoormaazaRAfs784gSyXzXV5k88qSnT29RE
 JMLXqWa8fPzKLLHwEI0lM8NRLtk2L9+xR0zV5NlsuV63M9JnA1kie5oXMZ3FFBKskb
 99FrOPwdYM1fA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:48 +0200
Subject: [PATCH 10/29] tests/qtest: add PCA9555 register access tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-10-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=2477;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=6C6R6L/HzmschTunAg/gYTBr73faxfTgYnk1vNesInI=;
 b=7p00nBpLNMz8k1pIlrYPsC8NUmjTRPiqnC9GazduLodlxYvn+fWnYE0yvh3X6morFZngcPtXl
 gXqbWc6M6zcAdugryE9AEHWiayNS8HCkLtA6wwe6W+dmZuFmjR/PF6S
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Introduce a qtest for the PCA9555 16-bit I/O port expander.

This first set covers the power-on reset defaults and the read/write
behaviour of the OUTPUT, CONFIG and POLARITY register pairs.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/qtest/meson.build    |  1 +
 tests/qtest/pca9555-test.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..2c283708a5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,6 +318,7 @@ qos_test_ss.add(
   'tulip-test.c',
   'nvme-test.c',
   'pca9552-test.c',
+  'pca9555-test.c',
   'pci-test.c',
   'pcnet-test.c',
   'rs5c372-test.c',
diff --git a/tests/qtest/pca9555-test.c b/tests/qtest/pca9555-test.c
new file mode 100644
index 0000000000..5945c3441e
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

-- 
2.50.1


