Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29312C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0yqO-0003dZ-QA; Mon, 31 Aug 2026 06:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yqG-0003bR-E7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:21 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x0yqE-0001jX-FF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 06:02:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so1462229f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788170533; x=1788775333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=23CFRW4wlT4KTlZB9/d9F3Ig9fE0VudgUIy5XUnsxBQ=;
 b=iCc7EWy/YNCZmUBcKUJVj+AifO11EFRMUQt6Qzi0Swng6tMokNaH7r/GWBQflNbSsf
 Fsjpwxu28ki5de1Rmamoeo7fkOAP454xNS/fnFLJZjISnhdcgivBT5HQhq4R0Md9zs+H
 uMSq23mgVZYQdVaoKRVOFzfGMNjI/oosdtDzTeVbYfgyyWysHVRghB7GeP6Yu6nl3VqI
 uKR3xw4FQ8WK0TumD03IjWvBAFxuW3hXvzhh8Mz/2FO5pRTZAy+/Mw9aG1jLc12pI8K/
 JCBOyE0LVV67PuwLXbFZOr9YGDWZv0Aqzf4Csd7nudUGt15HHT3ghSqWerJ2gBfjabSn
 IQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788170533; x=1788775333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23CFRW4wlT4KTlZB9/d9F3Ig9fE0VudgUIy5XUnsxBQ=;
 b=YJAd90DSbpmFHTJQXnOeIM5ZMazP+pcqIChgOiX3R9HZH+zv13dcPQ0Dy7WwZGeigA
 6jK1Ti7Ch3pboP5jHoLELuMqPAkM2ZL9lK3svYVRa35Yri0QtMcgDxgUywYWuI94MbP0
 6NrDZyovfSqGeu+lAX8wPkwl6Y3TIkU7ZEF6HqqJHsmOsWTTepw5friUdSewgZfD+pbO
 Bj9KFIP8l8NbSvZZnatUreY+Uf2tNeqpMh1BFVQCmojFtD3mvRBll0ttxx33LLaJtJGI
 N6Flr9eIha8zIqMVDynozLC2LgsY2nOUxbLzvqHncvyRX/X3fdJUYBwbwzFG46Ny1SgU
 Zgfg==
X-Gm-Message-State: AFuF++mrQxIjwegXmLlXANBMbCKSESJ46PRfV8obXzimZc23e3PYwkbW
 9xqMeEN1LvF46DuMkgb1BABDpCR+v0UOgewb4jfRFxfEvJqCCtPh1m3JuuLYNbiI/TGNMTFAfIo
 LswUu
X-Gm-Gg: AYBFou2mXIcdhTi8qaf3YwCVxd2m3/UZwGd9b/f+2ykMThPB8PRAEK76KLUTpeyJtDo
 uofAESyC71tIfNYruZvyJmcuXhCcSvDioYFyaRhn7ig8ZAeXUWx6YLhLpREphlsfnLmIODuerVq
 cYcSdAyuoJbY/KqkLO+WA1ZOJxhnK4LmMzgZp+6vw220iY/Hz14skue6YGMHyalEbQAUYEiHOYe
 uMfIHFQZxr8UQIe3pJPaBoiYcm+iw/4m2B0MLTeSxgU3r8V5Fim/zuIbfHj+KdY9JePCB6n6zaL
 OFlokGxm8G8/DdRAdCvnaDqBQGhdDIxybpKU1J68wWqpwKTqJLMjD1Ifa/1gAx2Z6X5vVQbMoED
 S6ASACcGXiC9d73YH98LdYQvYFMgRptgoCRLObX48nX1c6Ila4mf1j1ndQibFz20Vf+CXtjLd2P
 2OhtA9s5cDJhLCMAPfD6fsGf/J1Lie+HtUPhWrVK7NegYkKvSghXqXY0/7
X-Received: by 2002:a05:6000:4917:b0:482:9dc6:16c4 with SMTP id
 ffacd0b85a97d-4843f894ce9mr2039089f8f.1.1788170520472; 
 Mon, 31 Aug 2026 03:02:00 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3bc1:c53b:30b:203e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb33070sm22362383f8f.36.2026.08.31.03.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 03:02:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 6/6] tests/unit: cover blocked IO during the websock handshake
Date: Mon, 31 Aug 2026 12:01:51 +0200
Message-ID: <20260831100151.914178-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831100151.914178-1-den@openvz.org>
References: <20260831100151.914178-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
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

Add a channel which reports QIO_CHANNEL_ERR_BLOCK on demand, the way a
TLS channel does when a record arrives split across segments or when
the socket cannot take the whole reply at once, and drive the server
handshake through it in both directions. Without the fixes each
direction dereferences a NULL Error and the test dies on SIGSEGV.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/unit/test-io-channel-websock.c | 150 ++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

diff --git a/tests/unit/test-io-channel-websock.c b/tests/unit/test-io-channel-websock.c
index 2a55a4bcdf..88da24f993 100644
--- a/tests/unit/test-io-channel-websock.c
+++ b/tests/unit/test-io-channel-websock.c
@@ -12,6 +12,123 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
+#include "qom/object.h"
+
+#define TYPE_QIO_CHANNEL_STALL "qio-channel-stall"
+OBJECT_DECLARE_SIMPLE_TYPE(QIOChannelStall, QIO_CHANNEL_STALL)
+
+/*
+ * Reports QIO_CHANNEL_ERR_BLOCK for the first @rstalls reads and @wstalls
+ * writes, the way a TLS channel does when a record arrives split across TCP
+ * segments or the socket cannot take the whole reply at once.
+ */
+struct QIOChannelStall {
+    QIOChannel parent;
+    QIOChannel *master;
+    unsigned rstalls;
+    unsigned wstalls;
+};
+
+static ssize_t qio_channel_stall_readv(QIOChannel *ioc,
+                                       const struct iovec *iov,
+                                       size_t niov,
+                                       int **fds,
+                                       size_t *nfds,
+                                       int flags,
+                                       Error **errp)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(ioc);
+
+    if (sioc->rstalls) {
+        sioc->rstalls--;
+        return QIO_CHANNEL_ERR_BLOCK;
+    }
+    return qio_channel_readv_full(sioc->master, iov, niov, fds, nfds,
+                                  flags, errp);
+}
+
+static ssize_t qio_channel_stall_writev(QIOChannel *ioc,
+                                        const struct iovec *iov,
+                                        size_t niov,
+                                        int *fds,
+                                        size_t nfds,
+                                        int flags,
+                                        Error **errp)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(ioc);
+
+    if (sioc->wstalls) {
+        sioc->wstalls--;
+        return QIO_CHANNEL_ERR_BLOCK;
+    }
+    return qio_channel_writev_full(sioc->master, iov, niov, fds, nfds,
+                                   flags, errp);
+}
+
+static int qio_channel_stall_set_blocking(QIOChannel *ioc, bool enabled,
+                                          Error **errp)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(ioc);
+
+    return qio_channel_set_blocking(sioc->master, enabled, errp) ? 0 : -1;
+}
+
+static int qio_channel_stall_close(QIOChannel *ioc, Error **errp)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(ioc);
+
+    return qio_channel_close(sioc->master, errp);
+}
+
+static GSource *qio_channel_stall_create_watch(QIOChannel *ioc,
+                                               GIOCondition condition)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(ioc);
+
+    return qio_channel_create_watch(sioc->master, condition);
+}
+
+static void qio_channel_stall_finalize(Object *obj)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(obj);
+
+    object_unref(OBJECT(sioc->master));
+}
+
+static void qio_channel_stall_class_init(ObjectClass *klass,
+                                         const void *class_data G_GNUC_UNUSED)
+{
+    QIOChannelClass *ioc_klass = QIO_CHANNEL_CLASS(klass);
+
+    ioc_klass->io_writev = qio_channel_stall_writev;
+    ioc_klass->io_readv = qio_channel_stall_readv;
+    ioc_klass->io_set_blocking = qio_channel_stall_set_blocking;
+    ioc_klass->io_close = qio_channel_stall_close;
+    ioc_klass->io_create_watch = qio_channel_stall_create_watch;
+}
+
+static const TypeInfo qio_channel_stall_info = {
+    .parent = TYPE_QIO_CHANNEL,
+    .name = TYPE_QIO_CHANNEL_STALL,
+    .instance_size = sizeof(QIOChannelStall),
+    .instance_finalize = qio_channel_stall_finalize,
+    .class_init = qio_channel_stall_class_init,
+};
+
+static QIOChannelStall *qio_channel_stall_new(QIOChannel *master,
+                                              unsigned rstalls,
+                                              unsigned wstalls)
+{
+    QIOChannelStall *sioc = QIO_CHANNEL_STALL(
+        object_new(TYPE_QIO_CHANNEL_STALL));
+
+    object_ref(OBJECT(master));
+    sioc->master = master;
+    sioc->rstalls = rstalls;
+    sioc->wstalls = wstalls;
+
+    return sioc;
+}
 
 typedef struct {
     bool finished;
@@ -31,10 +148,12 @@ static void test_websock_handshake_done(QIOTask *task, gpointer opaque)
  * the server wrote back, NUL terminated. The handshake is expected to
  * fail; the point of the test is the HTTP response that goes with it.
  */
-static char *test_websock_handshake_reply(const char *request)
+static char *test_websock_handshake_reply(const char *request,
+                                          unsigned rstalls, unsigned wstalls)
 {
     QIOChannelWebsockHandshake res = { false, false };
     QIOChannelSocket *cli, *srv;
+    QIOChannelStall *stall;
     QIOChannelWebsock *wioc;
     GMainContext *mainloop;
     int channel[2];
@@ -48,7 +167,8 @@ static char *test_websock_handshake_reply(const char *request)
     qio_channel_set_blocking(QIO_CHANNEL(srv), false, &error_abort);
     qio_channel_set_blocking(QIO_CHANNEL(cli), false, &error_abort);
 
-    wioc = qio_channel_websock_new_server(QIO_CHANNEL(srv));
+    stall = qio_channel_stall_new(QIO_CHANNEL(srv), rstalls, wstalls);
+    wioc = qio_channel_websock_new_server(QIO_CHANNEL(stall));
     qio_channel_websock_handshake(wioc, test_websock_handshake_done,
                                   &res, NULL);
 
@@ -68,6 +188,7 @@ static char *test_websock_handshake_reply(const char *request)
     }
 
     object_unref(OBJECT(wioc));
+    object_unref(OBJECT(stall));
     object_unref(OBJECT(srv));
     object_unref(OBJECT(cli));
 
@@ -77,7 +198,23 @@ static char *test_websock_handshake_reply(const char *request)
 static void test_websock_bad_request(const void *opaque)
 {
     const char *request = opaque;
-    g_autofree char *reply = test_websock_handshake_reply(request);
+    g_autofree char *reply = test_websock_handshake_reply(request, 0, 0);
+
+    g_assert_true(g_str_has_prefix(reply, "HTTP/1.1 400 Bad Request\r\n"));
+}
+
+static void test_websock_stalled_read(const void *opaque)
+{
+    const char *request = opaque;
+    g_autofree char *reply = test_websock_handshake_reply(request, 1, 0);
+
+    g_assert_true(g_str_has_prefix(reply, "HTTP/1.1 400 Bad Request\r\n"));
+}
+
+static void test_websock_stalled_write(const void *opaque)
+{
+    const char *request = opaque;
+    g_autofree char *reply = test_websock_handshake_reply(request, 0, 1);
 
     g_assert_true(g_str_has_prefix(reply, "HTTP/1.1 400 Bad Request\r\n"));
 }
@@ -85,6 +222,7 @@ static void test_websock_bad_request(const void *opaque)
 int main(int argc, char **argv)
 {
     module_call_init(MODULE_INIT_QOM);
+    type_register_static(&qio_channel_stall_info);
     g_test_init(&argc, &argv, NULL);
 
 #define TEST_BAD_REQUEST(name, request)                         \
@@ -101,5 +239,11 @@ int main(int argc, char **argv)
     TEST_BAD_REQUEST("bad-method", "POST / HTTP/1.1\r\nx: y\r\n\r\n");
     TEST_BAD_REQUEST("bad-version", "GET / HTTP/1.0\r\nx: y\r\n\r\n");
 
+    /* A read which blocks before any header arrives is not a fatal error. */
+    g_test_add_data_func("/io/channel/websock/stalled-read",
+                         "stats\r\nx\r\n\r\n", test_websock_stalled_read);
+    g_test_add_data_func("/io/channel/websock/stalled-write",
+                         "stats\r\nx\r\n\r\n", test_websock_stalled_write);
+
     return g_test_run();
 }
-- 
2.53.0


