Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B401CC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yqG-0003aw-0e; Mon, 31 Aug 2026 06:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yq1-0003XA-Rz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0ypz-0001i8-Ux
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:01 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2923688f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170518; x=1788775318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oCneUgH+VCGYg++9em8cPDWbXKgq959i6BrsDRTpNpA=;
 b=jK73X1CrMBQK0Kfgy3M7pzXh6ZAJEctpCtaWghFmQs2Z8kNfxvrSXL5W6nrF9skLhl
 LKjvouie57I4xRXKD9SMzJX0vVua75rkKKVTXnqme5TC8Ur/sH9L34h+bMEclUUQpPsU
 Tu09zUpC82rSO1s6FnpMqoeHYUzQg0O9AOfO9fTJeQ7rvIqPsB1xrTjj4qHw0TrHl5sQ
 qVvGS50Ty1bTRZVLErUXZzOS0fmm7Ij0Qlu+UpaEjUuVP0A/vDZX+1ip0OBZDi17RGNH
 P/qS660Rew80XiObuGOiRX45OYHP/azKwVmkbO24A8RPWOjZS0mDlmP1jUmK61ujMlYa
 Ktbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170518; x=1788775318;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oCneUgH+VCGYg++9em8cPDWbXKgq959i6BrsDRTpNpA=;
 b=WJEM9c5v2ScJkbr0M9hP9vxT8MB87XseQ48yIXzr+573MHr8gLkVkl2oZdUciPjxwj
 icxOhPqbJGG2x6rutrZIk284TamIfp3GVa3GfMSyIxrtIvE7USTIaaNk6QTd0I4d7bGU
 76lm5jUan0Q1dLAfCvmuD/a5gaVDBdvETeiUO9w6YtHOSZf28G7xjt2ibpk23xL0oMCF
 KGZt7xSOs0+FOanWNKCp0icK01HE1Ff26FEz6DIg1UZHJiBD7QW2QkYQtC6NX5U4F4bY
 0SNzVqLJw72uwrq/RmpJ5yNRtqB+3s47rnWd1CRi/uoP50wt9USaTGu2CQCqLIv7uA5u
 XF3g==
X-Gm-Message-State: AFuF++nzadgiVsm8PV1a+jz4+5GnoNQD6ji9EPrDdRwoUgJuH1ZGPtwX
 qzH7v3YBLMBV4jxUXETDIBiw0o7hRP8MrYwXY2GA7QZpxeiQZ2RrKJxqYoOukmSw2AebiRZPms/
 fyKpw
X-Gm-Gg: AYBFou1xNGWf6IiFA1q2tHF9Y303IHQbpSL8bV9X1ZRGtOQLNWulfxRxPLaIww0BEk4
 AsX/dBFNR/yn9qy2cKMK0uReDEqXP1ySq0Ia2BAswnBC3aNfkcm2YoQYr9WUfDJWSKaZ3la4i+L
 tDQot/QHrhQ9gL4duFTAQmJ2zI9FulIIhE8Dhm4KwQqmZxknHyWWApwqARY/9gPeZ/x/1YQVvJ+
 H61sDXv390Kc3F6eFyGzCm5PXCi0SLswv3BfjWInYIn/2UUOUyfwKU/8hKJN5pqgSe3WFUQwnZ/
 uqru+gh+lbeRCvtSthlf8A6AijB51zXuuFkaZSmvC8DiJbRI+vk6gQV5TDKRiOUBLi7gAjjczVA
 VDa/DBnLlQx6O8Vx8lNl+3qejFpBeHdkE1E/U/0hY7O5M4RyFDeiK6Hw2eTCSvHZu2HOrgSgrf0
 n9FomyHzC2vfIzWIXAPZgvHlcu0UioppEMR25Yi1hUyLiBw8NpMKELzP8g
X-Received: by 2002:a05:6000:1449:b0:47f:fb2e:f63d with SMTP id
 ffacd0b85a97d-482f79859b9mr34002720f8f.9.1788170518482; 
 Mon, 31 Aug 2026 03:01:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:01:58 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/6] tests/unit: add websock handshake test
Date: Mon, 31 Aug 2026 12:01:49 +0200
Message-ID: <20260831100151.914178-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

From: Denis V. Lunev <den@openvz.org>

Check that malformed HTTP greetings are answered with an HTTP 400
rather than an empty response. The no-space case is the one which used
to leave the response buffer empty.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/unit/meson.build               |   1 +
 tests/unit/test-io-channel-websock.c | 105 +++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tests/unit/test-io-channel-websock.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 3a9866c1f2..6a11f07112 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -93,6 +93,7 @@ if have_block
     'test-io-channel-command': ['io-channel-helpers.c', io],
     'test-io-channel-buffer': ['io-channel-helpers.c', io],
     'test-io-channel-null': [io],
+    'test-io-channel-websock': [io],
     'test-crypto-ivgen': [io],
     'test-crypto-afsplit': [io],
     'test-crypto-block': [io],
diff --git a/tests/unit/test-io-channel-websock.c b/tests/unit/test-io-channel-websock.c
new file mode 100644
index 0000000000..2a55a4bcdf
--- /dev/null
+++ b/tests/unit/test-io-channel-websock.c
@@ -0,0 +1,105 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU I/O channel websock test
+ *
+ * Copyright (c) 2026 Virtuozzo International GmbH
+ */
+
+#include "qemu/osdep.h"
+#include "io/channel-websock.h"
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/sockets.h"
+
+typedef struct {
+    bool finished;
+    bool failed;
+} QIOChannelWebsockHandshake;
+
+static void test_websock_handshake_done(QIOTask *task, gpointer opaque)
+{
+    QIOChannelWebsockHandshake *res = opaque;
+
+    res->finished = true;
+    res->failed = qio_task_propagate_error(task, NULL);
+}
+
+/*
+ * Drives a server-side handshake against @request and returns whatever
+ * the server wrote back, NUL terminated. The handshake is expected to
+ * fail; the point of the test is the HTTP response that goes with it.
+ */
+static char *test_websock_handshake_reply(const char *request)
+{
+    QIOChannelWebsockHandshake res = { false, false };
+    QIOChannelSocket *cli, *srv;
+    QIOChannelWebsock *wioc;
+    GMainContext *mainloop;
+    int channel[2];
+    char *reply;
+    ssize_t got;
+
+    g_assert(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, channel) == 0);
+
+    cli = qio_channel_socket_new_fd(channel[0], &error_abort);
+    srv = qio_channel_socket_new_fd(channel[1], &error_abort);
+    qio_channel_set_blocking(QIO_CHANNEL(srv), false, &error_abort);
+    qio_channel_set_blocking(QIO_CHANNEL(cli), false, &error_abort);
+
+    wioc = qio_channel_websock_new_server(QIO_CHANNEL(srv));
+    qio_channel_websock_handshake(wioc, test_websock_handshake_done,
+                                  &res, NULL);
+
+    qio_channel_write_all(QIO_CHANNEL(cli), request, strlen(request),
+                          &error_abort);
+
+    mainloop = g_main_context_default();
+    while (!res.finished) {
+        g_main_context_iteration(mainloop, TRUE);
+    }
+    g_assert(res.failed);
+
+    reply = g_malloc0(1024);
+    got = qio_channel_read(QIO_CHANNEL(cli), reply, 1023, &error_abort);
+    if (got > 0) {
+        reply[got] = '\0';
+    }
+
+    object_unref(OBJECT(wioc));
+    object_unref(OBJECT(srv));
+    object_unref(OBJECT(cli));
+
+    return reply;
+}
+
+static void test_websock_bad_request(const void *opaque)
+{
+    const char *request = opaque;
+    g_autofree char *reply = test_websock_handshake_reply(request);
+
+    g_assert_true(g_str_has_prefix(reply, "HTTP/1.1 400 Bad Request\r\n"));
+}
+
+int main(int argc, char **argv)
+{
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+#define TEST_BAD_REQUEST(name, request)                         \
+    g_test_add_data_func("/io/channel/websock/bad-request/" name, \
+                         request, test_websock_bad_request)
+
+    /*
+     * A greeting with no space at all used to leave the response buffer
+     * empty, which drove the handshake into a zero length write.
+     */
+    TEST_BAD_REQUEST("no-space", "stats\r\nx\r\n\r\n");
+    TEST_BAD_REQUEST("method-only", "GET\r\nx\r\n\r\n");
+    TEST_BAD_REQUEST("no-version", "GET /\r\nx\r\n\r\n");
+    TEST_BAD_REQUEST("bad-method", "POST / HTTP/1.1\r\nx: y\r\n\r\n");
+    TEST_BAD_REQUEST("bad-version", "GET / HTTP/1.0\r\nx: y\r\n\r\n");
+
+    return g_test_run();
+}
-- 
2.53.0


