Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E3AC54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHiL-0007n8-VK; Wed, 28 Aug 2024 08:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHiJ-0007iH-9t
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHiH-0001Da-CM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yqZV3N3qjRopbwCand9K9Y8Kskn89ms5iiMIBgf6KxM=; b=P3eK36dYFvJBh/5LIi0wV2Ep/B
 o67g5AWhbBVTguWJHRela/K1Nw1DcfGTHFmx0GjitWOD/Ej7icfcjApXclrUvDqCc0hoyKWTcXSNS
 GU9pwl7/EA4i0dMmqUnTeE7+H1zK8V5UHJD1lvqwoXfs3/0cgAqrojE3UAujXgV5EAT5cPo/AHQTE
 h0hz1FIYBeLQIdKn+0MFi8WMXyL7YDM6WynC+4eIOkmSSlVTv0S04O2264ZbZMPsqfHiIfscKLUJv
 V6Nog9HitmTApykIm17zj+lG99VwSezFFppyVyOGT9LdYZw3gKOQIaXAvpSqUplC1+bH86W81odml
 nUhJLYihiDXDRbI45QsjyMzAHqy1jvYLPGcKeik4nzvw18KLXCL5u1qnWQLg528r+AtNBBzQMbjDY
 x4nnjChi2VihK33AJrMIW7ol7GXs+6g630MnteoP62Q+CuEqWSyj0Fvs2Rhjq15Y72Nkovrj7dJaJ
 bjFlWTURoEiJ+/XmilKLtjochwg+wI/xn+zZKRsKA4hokd3aQfIBffVGeLne/RQTh1qmYxwpMccTy
 ukN3nfv2H9wmH7J9qsw8tQ0DlTF4byP5WM/zLnJyCxYHOdd3f3GxlA5MzqTsdgN1Mw3nKX15sAOpe
 31ArbmVfyFhFim5oBCkGLIu/AadhXvqHJxwuXdDaQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhz-000B8d-6b; Wed, 28 Aug 2024 13:23:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:58 +0100
Message-Id: <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 9/9] tests/unit: add test-fifo unit test
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This tests the Fifo8 implementation for basic operations as well as testing for
the correct *_bufptr() including handling wraparound of the internal FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tests/unit/meson.build |   1 +
 tests/unit/test-fifo.c | 256 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 tests/unit/test-fifo.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 490ab8182d..89f9633cd6 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -47,6 +47,7 @@ tests = {
   'test-logging': [],
   'test-qapi-util': [],
   'test-interval-tree': [],
+  'test-fifo': [],
 }
 
 if have_system or have_tools
diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
new file mode 100644
index 0000000000..1e54cde871
--- /dev/null
+++ b/tests/unit/test-fifo.c
@@ -0,0 +1,256 @@
+/*
+ * Fifo8 tests
+ *
+ * Copyright 2024 Mark Cave-Ayland
+ *
+ * Authors:
+ *  Mark Cave-Ayland    <mark.cave-ayland@ilande.co.uk>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "qemu/fifo8.h"
+
+const VMStateInfo vmstate_info_uint32;
+const VMStateInfo vmstate_info_buffer;
+
+
+static void test_fifo8_pop_bufptr_wrap(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    const uint8_t *buf;
+    uint32_t count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    g_assert(count == 2);
+    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
+
+    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    buf = fifo8_pop_bufptr(&fifo, 8, &count);
+    g_assert(count == 6);
+    g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
+             buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
+
+    g_assert(fifo8_num_used(&fifo) == 2);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_pop_bufptr(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
+    const uint8_t *buf;
+    uint32_t count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    g_assert(count == 2);
+    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
+
+    g_assert(fifo8_num_used(&fifo) == 2);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_peek_bufptr_wrap(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    const uint8_t *buf;
+    uint32_t count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    buf = fifo8_peek_bufptr(&fifo, 2, &count);
+    g_assert(count == 2);
+    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
+
+    buf = fifo8_pop_bufptr(&fifo, 2, &count);
+    g_assert(count == 2);
+    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
+    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+
+    buf = fifo8_peek_bufptr(&fifo, 8, &count);
+    g_assert(count == 6);
+    g_assert(buf[0] == 0x3 && buf[1] == 0x4 && buf[2] == 0x5 &&
+             buf[3] == 0x6 && buf[4] == 0x7 && buf[5] == 0x8);
+
+    g_assert(fifo8_num_used(&fifo) == 8);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_peek_bufptr(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
+    const uint8_t *buf;
+    uint32_t count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    buf = fifo8_peek_bufptr(&fifo, 2, &count);
+    g_assert(count == 2);
+    g_assert(buf[0] == 0x1 && buf[1] == 0x2);
+
+    g_assert(fifo8_num_used(&fifo) == 4);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_pop_buf_wrap(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_out[4];
+    int count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    fifo8_pop_buf(&fifo, NULL, 4);
+
+    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    count = fifo8_pop_buf(&fifo, NULL, 4);
+    g_assert(count == 4);
+    count = fifo8_pop_buf(&fifo, data_out, 4);
+    g_assert(count == 4);
+    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
+             data_out[2] == 0x3 && data_out[3] == 0x4);
+
+    g_assert(fifo8_num_used(&fifo) == 0);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_pop_buf(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8 };
+    uint8_t data_out[] = { 0xff, 0xff, 0xff, 0xff };
+    int count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    count = fifo8_pop_buf(&fifo, NULL, 4);
+    g_assert(count == 4);
+    count = fifo8_pop_buf(&fifo, data_out, 4);
+    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
+             data_out[2] == 0x7 && data_out[3] == 0x8);
+
+    g_assert(fifo8_num_used(&fifo) == 0);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_peek_buf_wrap(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_out[4];
+    int count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in1, sizeof(data_in1));
+    fifo8_pop_buf(&fifo, NULL, 4);
+
+    fifo8_push_all(&fifo, data_in2, sizeof(data_in2));
+    count = fifo8_peek_buf(&fifo, NULL, 4);
+    g_assert(count == 4);
+    count = fifo8_peek_buf(&fifo, data_out, 4);
+    g_assert(count == 4);
+    g_assert(data_out[0] == 0x5 && data_out[1] == 0x6 &&
+             data_out[2] == 0x7 && data_out[3] == 0x8);
+
+    g_assert(fifo8_num_used(&fifo) == 8);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_peek_buf(void)
+{
+    Fifo8 fifo;
+    uint8_t data_in[] = { 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_out[] = { 0xff, 0xff, 0xff, 0xff };
+    int count;
+
+    fifo8_create(&fifo, 8);
+
+    fifo8_push_all(&fifo, data_in, sizeof(data_in));
+    count = fifo8_peek_buf(&fifo, NULL, 4);
+    g_assert(count == 4);
+    g_assert(data_out[0] == 0xff && data_out[1] == 0xff &&
+             data_out[2] == 0xff && data_out[3] == 0xff);
+
+    count = fifo8_peek_buf(&fifo, data_out, 4);
+    g_assert(count == 4);
+    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
+             data_out[2] == 0x3 && data_out[3] == 0x4);
+
+    g_assert(fifo8_num_used(&fifo) == 4);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_peek(void)
+{
+    Fifo8 fifo;
+    uint8_t c;
+
+    fifo8_create(&fifo, 8);
+    fifo8_push(&fifo, 0x1);
+    fifo8_push(&fifo, 0x2);
+
+    c = fifo8_peek(&fifo);
+    g_assert(c == 0x1);
+    fifo8_pop(&fifo);
+    c = fifo8_peek(&fifo);
+    g_assert(c == 0x2);
+
+    g_assert(fifo8_num_used(&fifo) == 1);
+    fifo8_destroy(&fifo);
+}
+
+static void test_fifo8_pushpop(void)
+{
+    Fifo8 fifo;
+    uint8_t c;
+
+    fifo8_create(&fifo, 8);
+    fifo8_push(&fifo, 0x1);
+    fifo8_push(&fifo, 0x2);
+
+    c = fifo8_pop(&fifo);
+    g_assert(c == 0x1);
+    c = fifo8_pop(&fifo);
+    g_assert(c == 0x2);
+
+    g_assert(fifo8_num_used(&fifo) == 0);
+    fifo8_destroy(&fifo);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/fifo8/pushpop", test_fifo8_pushpop);
+    g_test_add_func("/fifo8/peek", test_fifo8_peek);
+    g_test_add_func("/fifo8/peek_buf", test_fifo8_peek_buf);
+    g_test_add_func("/fifo8/peek_buf_wrap", test_fifo8_peek_buf_wrap);
+    g_test_add_func("/fifo8/pop_buf", test_fifo8_pop_buf);
+    g_test_add_func("/fifo8/pop_buf_wrap", test_fifo8_pop_buf_wrap);
+    g_test_add_func("/fifo8/peek_bufptr", test_fifo8_peek_bufptr);
+    g_test_add_func("/fifo8/peek_bufptr_wrap", test_fifo8_peek_bufptr_wrap);
+    g_test_add_func("/fifo8/pop_bufptr", test_fifo8_pop_bufptr);
+    g_test_add_func("/fifo8/pop_bufptr_wrap", test_fifo8_pop_bufptr_wrap);
+    return g_test_run();
+}
-- 
2.39.2


