Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E50EE49A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJx-0003HW-Hz; Wed, 11 Sep 2024 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJe-00007y-DL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJY-0007ff-Co
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so19095175e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057148; x=1726661948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lV/LOMkmfQJU8lrIgcTMiAbokrH3R6CPj+LdM89/t8c=;
 b=kGRIl4cbGTgexEQ/3FsP4rGD6iPO6LCJyQZgLmAKvbOcGwRDTIpSfcNxf48GeTIh4u
 HO1M72e3zM2ss+SvgNRWOEZGTpXrITMyjSl9iA3HJCJ7AXCLRIhGLxY81zzCnC0WqAFn
 A38eRgu4y6GRjGmW5AetVzOActUsq4iucsWxIYNItj/ALYzwP9iuo+L+noI0aNw6W3Zl
 p6srI2EgSKX0Jch6WrvakZCEOoUdZarbgjgk8UN6Cm4REObcaAdpdtdQVmCO3urkDMUb
 bx2Twt2onkZFf/CUke1fe3WMzb2brdoJxMtsEQC34E0v7Di3rvG0GvH1zEVxmxjLn6oY
 N7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057148; x=1726661948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lV/LOMkmfQJU8lrIgcTMiAbokrH3R6CPj+LdM89/t8c=;
 b=k+kPUni+Cu3ZT12WRJKC45TE6F8NYZ8Zo6K6NWNoton6UB5tZDVSJFbHI2O7+q/hgW
 ydM7er9pEyxW2SLa1t3p07oEJPO6Q0hOn69s/HiHt2KrjBjcNs8KVZZ2+Mcx2BvIue0m
 ItVauyz3yOBiVDXHkww7TTi1UGdSzLFpw3gfxl6SAdc9ocZskbWRj5cMDQ67mUOh4xac
 C9cnQH8W1EZJUbQ+dBa5nY/Eb9/FG7n9+9jfrbofUSRn/jZHiE3wJbBlcAccKuKuqNCK
 xf6ik33vsPaGkoyIyTTJhLO06a9EIRUWMhzM6ul1Q5H0k/f9N426jyG9rL59MpY2BSG5
 vjJw==
X-Gm-Message-State: AOJu0YwpANZelAolwY7JrtG5SEjq2TR4Ij3JuX2x6WM9xMvgEfOZfTt2
 2j8jDKRuaixGAgKaIenlDp+BxPOnDGfftrbCKKju8pwKQJFwqZ1/y4ba+gsInqtY3xd8GXbeIM6
 d
X-Google-Smtp-Source: AGHT+IFMfCr5X8uhNaN4Mf/CiOh3XxyKRH8HFk0RpoAeqTONIlx4oQ3D0CgZAyawDrQzrvssAatswQ==
X-Received: by 2002:a05:600c:1d07:b0:42c:bb41:a077 with SMTP id
 5b1f17b1804b1-42ccd35b38dmr19747375e9.23.1726057147657; 
 Wed, 11 Sep 2024 05:19:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb58d815esm111139285e9.31.2024.09.11.05.19.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/56] tests/unit: add test-fifo unit test
Date: Wed, 11 Sep 2024 14:14:05 +0200
Message-ID: <20240911121422.52585-41-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This tests the Fifo8 implementation basic operations as well as
testing the *_bufptr() in-place buffer functions and the newer
*_buf() functions that also handle wraparound of the internal
FIFO buffer.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Octavian Purdila <tavip@google.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 256 +++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |   1 +
 2 files changed, 257 insertions(+)
 create mode 100644 tests/unit/test-fifo.c

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
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 972d792883..21d101301b 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -47,6 +47,7 @@ tests = {
   'test-logging': [],
   'test-qapi-util': [],
   'test-interval-tree': [],
+  'test-fifo': [],
 }
 
 if have_system or have_tools
-- 
2.45.2


