Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744B7C79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ReP-0004bP-ES; Fri, 04 Sep 2026 07:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2ReN-0004b4-VE
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2ReL-0007dV-RQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788519601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmeywneEt7+8x5kfLx9jyfan/B1X/zkeAiDGoB6OxEs=;
 b=Uej8deWgKFofQONM0xmeYkUe+tGMJ29tO1a+o4VMGyVRk0gkvkabXUdCR/JwI3Dj5mjfSE
 6jMQWkAPe+iNF8cpce2SrzQ36w+ph8GFjru4J/JdwuQhizB4eON6Q43ziBxHnfBMjckfaB
 QSw4LXpnImyYw1X+k5+qPM59VM36dg8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-37iMja32MfS0kxFDOK-9Lw-1; Fri,
 04 Sep 2026 06:59:56 -0400
X-MC-Unique: 37iMja32MfS0kxFDOK-9Lw-1
X-Mimecast-MFC-AGG-ID: 37iMja32MfS0kxFDOK-9Lw_1788519595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97AAC18002F8; Fri,  4 Sep 2026 10:59:55 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE7061800609; Fri,  4 Sep 2026 10:59:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PULL 09/13] tests/unit: cover blocked IO during the websock handshake
Date: Fri,  4 Sep 2026 11:59:25 +0100
Message-ID: <20260904105929.3450663-10-berrange@redhat.com>
In-Reply-To: <20260904105929.3450663-1-berrange@redhat.com>
References: <20260904105929.3450663-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.55.0


