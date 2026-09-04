Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C88C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WS2-0004i8-LS; Fri, 04 Sep 2026 12:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRq-0004Ek-5R
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRl-0006g7-9a
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788538031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEq322J/epNoMJg2yxOKARaqU+03ZEl9jNI/Z3JgdVE=;
 b=XKV/5srPzm6NPnJfES8CvD4qoerpthD4QMmYZmARae+Ax9LsLH02K9qt9ZZ2dxtq7GYfZY
 2xMw1ijEdgEtPLntYlfOpMJDYTTYXsOMs9gxNkKkbq0r6bRLp7oS4y3bz8MAUe0JJDxq5W
 HrJx+cwi0rtGvFLr8HPy9yJUBvHm9Ls=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-cgTClRW3Me69zOkWj6BIGg-1; Fri,
 04 Sep 2026 12:07:06 -0400
X-MC-Unique: cgTClRW3Me69zOkWj6BIGg-1
X-Mimecast-MFC-AGG-ID: cgTClRW3Me69zOkWj6BIGg_1788538025
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AE2919540CF; Fri,  4 Sep 2026 16:07:05 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA2C13001D37; Fri,  4 Sep 2026 16:07:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PULL v2 07/13] tests/unit: add websock handshake test
Date: Fri,  4 Sep 2026 17:06:37 +0100
Message-ID: <20260904160643.353833-8-berrange@redhat.com>
In-Reply-To: <20260904160643.353833-1-berrange@redhat.com>
References: <20260904160643.353833-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Denis V. Lunev <den@openvz.org>

Check that malformed HTTP greetings are answered with an HTTP 400
rather than an empty response. The no-space case is the one which used
to leave the response buffer empty.

Fixes: CVE-2026-84788
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
[DB: exclude test from Windows since it depends on AF_UNIX
 which is not universally available]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/meson.build               |   1 +
 tests/unit/test-io-channel-websock.c | 105 +++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 tests/unit/test-io-channel-websock.c

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 3a9866c1f2..e47bc7225a 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -115,6 +115,7 @@ if have_block
   endif
   if host_os != 'windows'
     tests += {
+      'test-io-channel-websock': [io],
       'test-image-locking': [testblock],
       'test-nested-aio-poll': [],
     }
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
2.55.0


