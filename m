Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836F7C79F8B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 13:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vckBC-0006mu-OS; Mon, 05 Jan 2026 07:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck9B-0004M7-EG
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck99-000863-Dv
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WywNb9c2fzJnvtKkFHYliMsQCyp82+NRD4M44Nd+htY=;
 b=c9cXtf/1IZ/drOIRlFR9USWeK9DQAg3RUkZy6UVfFtCeOZ4uWDr0LgR5ZXLYEpF7D5GXDv
 8OuCiRRpeeUE7qb/Wmr4VeDVapXM2nTT3a1Ar1N9yKLuTSCBC8bOYhVUV+MHYwz5DWMnGr
 55xq/WUj2hleb6p/xY8MrRK55O4B+KM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-_SqLYMxOMraM71N3DFSSZg-1; Mon,
 05 Jan 2026 07:57:16 -0500
X-MC-Unique: _SqLYMxOMraM71N3DFSSZg-1
X-Mimecast-MFC-AGG-ID: _SqLYMxOMraM71N3DFSSZg_1767617835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FDDE19560A6; Mon,  5 Jan 2026 12:57:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9554019560A7; Mon,  5 Jan 2026 12:57:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yubin Zou <yubinz@google.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/36] test/qtest: Add Unit test for Aspeed SGPIO
Date: Mon,  5 Jan 2026 13:56:05 +0100
Message-ID: <20260105125613.622667-29-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yubin Zou <yubinz@google.com>

This commit introduces a new qtest for the Aspeed SGPIO controller
The test covers the following:
  - Setting and clearing SGPIO output pins and verifying the pin state.
  - Setting and clearing SGPIO input pins and verifying the pin state.
  - Verifying that level-high interrupts are correctly triggered and cleared.

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251219-aspeed-sgpio-v5-6-fd5593178144@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/ast2700-sgpio-test.c | 165 +++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |   1 +
 2 files changed, 166 insertions(+)
 create mode 100644 tests/qtest/ast2700-sgpio-test.c

diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
new file mode 100644
index 000000000000..56c54cca9b63
--- /dev/null
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -0,0 +1,165 @@
+/*
+ * QTest testcase for the ASPEED AST2700 SGPIO Controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 Google LLC.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qobject/qdict.h"
+#include "libqtest-single.h"
+#include "hw/core/registerfields.h"
+#include "hw/gpio/aspeed_sgpio.h"
+
+#define AST2700_SGPIO0_BASE 0x14C0C000
+#define AST2700_SGPIO1_BASE 0x14C0D000
+
+static void test_output_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Odd index is output port */
+        sprintf(name, "sgpio%03d", i * 2 + 1);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+        /* set serial output */
+        qtest_writel(s, offset, 0x00000001);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 1);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial output */
+        qtest_writel(s, offset, 0x00000000);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_OUT_VAL), ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_input_pins(const char *machine, const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%03d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+        /* set serial input */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, true);
+
+        /* clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
+        g_assert_cmphex(qtest_qom_get_bool(s, qom_path, name), ==, false);
+    }
+    qtest_quit(s);
+}
+
+static void test_irq_level_high(const char *machine,
+                                const uint32_t base, int idx)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    char qom_path[64];
+    uint32_t ctrl_offset = 0;
+    uint32_t int_offset = 0;
+    uint32_t int_reg_idx = 0;
+    uint32_t int_bit_idx = 0;
+    uint32_t value = 0;
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
+        /* Even index is input port */
+        sprintf(name, "sgpio%03d", i * 2);
+        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        int_reg_idx = i / 32;
+        int_bit_idx = i % 32;
+        int_offset = base + (R_SGPIO_INT_STATUS_0 + int_reg_idx) * 4;
+        ctrl_offset = base + (R_SGPIO_0_CONTROL + i) * 4;
+
+        /* Enable the interrupt */
+        value = SHARED_FIELD_DP32(value, SGPIO_INT_EN, 1);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set the interrupt type to level-high trigger */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_TYPE, 3);
+        qtest_writel(s, ctrl_offset, value);
+
+        /* Set serial input high */
+        qtest_qom_set_bool(s, qom_path, name, true);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 1);
+
+        /* Interrupt status is set */
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 1);
+
+        /* Clear Interrupt */
+        value = SHARED_FIELD_DP32(qtest_readl(s, ctrl_offset),
+                                              SGPIO_INT_STATUS, 1);
+        qtest_writel(s, ctrl_offset, value);
+        value = qtest_readl(s, int_offset);
+        g_assert_cmphex(extract32(value, int_bit_idx, 1), ==, 0);
+
+        /* Clear serial input */
+        qtest_qom_set_bool(s, qom_path, name, false);
+        value = qtest_readl(s, ctrl_offset);
+        g_assert_cmphex(SHARED_FIELD_EX32(value, SGPIO_SERIAL_IN_VAL), ==, 0);
+    }
+    qtest_quit(s);
+}
+
+static void test_ast_2700_sgpio_input(void)
+{
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+static void test_ast_2700_sgpio_output(void)
+{
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_output_pins("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+static void test_ast_2700_sgpio_irq(void)
+{
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO0_BASE, 0);
+    test_irq_level_high("-machine ast2700-evb",
+                    AST2700_SGPIO1_BASE, 1);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_input",
+                   test_ast_2700_sgpio_input);
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_output",
+                   test_ast_2700_sgpio_output);
+    qtest_add_func("/ast2700/sgpio/ast_2700_sgpio_irq",
+                   test_ast_2700_sgpio_irq);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 08fba9695b98..0f053fb56de5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -221,6 +221,7 @@ qtests_aspeed = \
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
    'ast2700-hace-test',
+   'ast2700-sgpio-test',
    'ast2700-smc-test']
 
 qtests_stm32l4x5 = \
-- 
2.52.0


