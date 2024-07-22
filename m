Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6DAC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVsuX-0000Jg-S7; Mon, 22 Jul 2024 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuN-0008Vy-BB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuL-0007e6-81
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721654212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guRvBffAhsbbUjQ1k/UDvhEJy6iEFeJUVzuqZZ2Mzgc=;
 b=Uzxw3HqePtHbYZow7HqLWIp2NUC1dbW+xoYj/frIz0v1Aqg6WIF8JYLFfVsLf1AUWYuoZG
 5f5PxvUKJgWYYgDfZQtEsxG5L7wh8A+bQ5MwAsJwrrRWrIbr5gHeo+S4sxbdS2alwfrzKL
 GKDSSJW9hEFw45FrTRkFiovJZ9tFyKc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-PrC1fhuMPn2I_apZDkZREg-1; Mon,
 22 Jul 2024 09:16:48 -0400
X-MC-Unique: PrC1fhuMPn2I_apZDkZREg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EA761915334; Mon, 22 Jul 2024 13:16:41 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DB6D196B09E; Mon, 22 Jul 2024 13:16:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] chardev: add tracing of socket error conditions
Date: Mon, 22 Jul 2024 14:16:08 +0100
Message-ID: <20240722131611.2820041-3-berrange@redhat.com>
In-Reply-To: <20240722131611.2820041-1-berrange@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds trace points to every error scenario in the chardev socket
backend that can lead to termination of the connection.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c | 34 +++++++++++++++++++++-------------
 chardev/trace-events  | 10 ++++++++++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 812d7aa38a..582b88e6d8 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -33,6 +33,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/yank.h"
+#include "trace.h"
 
 #include "chardev/char-io.h"
 #include "chardev/char-socket.h"
@@ -126,6 +127,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
                 /* Perform disconnect and return error. */
+                trace_chr_socket_poll_err(chr, chr->label);
                 tcp_chr_disconnect_locked(chr);
             } /* else let the read handler finish it properly */
         }
@@ -279,15 +281,16 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
     size_t i;
     int *msgfds = NULL;
     size_t msgfds_num = 0;
+    g_autoptr(Error) err = NULL;
 
     if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS)) {
         ret = qio_channel_readv_full(s->ioc, &iov, 1,
                                      &msgfds, &msgfds_num,
-                                     0, NULL);
+                                     0, &err);
     } else {
         ret = qio_channel_readv_full(s->ioc, &iov, 1,
                                      NULL, NULL,
-                                     0, NULL);
+                                     0, &err);
     }
 
     if (msgfds_num) {
@@ -322,7 +325,10 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
         errno = EAGAIN;
         ret = -1;
     } else if (ret == -1) {
+        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
         errno = EIO;
+    } else if (ret == 0) {
+        trace_chr_socket_recv_eof(chr, chr->label);
     }
 
     return ret;
@@ -463,6 +469,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     SocketChardev *s = SOCKET_CHARDEV(chr);
     bool emit_close = s->state == TCP_CHARDEV_STATE_CONNECTED;
 
+    trace_chr_socket_disconnect(chr, chr->label);
     tcp_chr_free_connection(chr);
 
     if (s->listener) {
@@ -521,6 +528,7 @@ static gboolean tcp_chr_hup(QIOChannel *channel,
                                void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
+    trace_chr_socket_hangup(chr, chr->label);
     tcp_chr_disconnect(chr);
     return G_SOURCE_REMOVE;
 }
@@ -672,15 +680,17 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
     SocketChardev *s = user_data;
     Chardev *chr = CHARDEV(s);
     TCPChardevTelnetInit *init = s->telnet_init;
+    g_autoptr(Error) err = NULL;
     ssize_t ret;
 
     assert(init);
 
-    ret = qio_channel_write(ioc, init->buf, init->buflen, NULL);
+    ret = qio_channel_write(ioc, init->buf, init->buflen, &err);
     if (ret < 0) {
         if (ret == QIO_CHANNEL_ERR_BLOCK) {
             ret = 0;
         } else {
+            trace_chr_socket_write_err(chr, chr->label, error_get_pretty(err));
             tcp_chr_disconnect(chr);
             goto end;
         }
@@ -762,12 +772,10 @@ static void tcp_chr_websock_handshake(QIOTask *task, gpointer user_data)
 {
     Chardev *chr = user_data;
     SocketChardev *s = user_data;
-    Error *err = NULL;
+    g_autoptr(Error) err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        error_reportf_err(err,
-                          "websock handshake of character device %s failed: ",
-                          chr->label);
+        trace_chr_socket_ws_handshake_err(chr, chr->label, error_get_pretty(err));
         tcp_chr_disconnect(chr);
     } else {
         if (s->do_telnetopt) {
@@ -802,12 +810,10 @@ static void tcp_chr_tls_handshake(QIOTask *task,
 {
     Chardev *chr = user_data;
     SocketChardev *s = user_data;
-    Error *err = NULL;
+    g_autoptr(Error) err = NULL;
 
     if (qio_task_propagate_error(task, &err)) {
-        error_reportf_err(err,
-                          "TLS handshake of character device %s failed: ",
-                          chr->label);
+        trace_chr_socket_tls_handshake_err(chr, chr->label, error_get_pretty(err));
         tcp_chr_disconnect(chr);
     } else {
         if (s->is_websock) {
@@ -826,19 +832,21 @@ static void tcp_chr_tls_init(Chardev *chr)
     SocketChardev *s = SOCKET_CHARDEV(chr);
     QIOChannelTLS *tioc;
     gchar *name;
+    g_autoptr(Error) err = NULL;
 
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
             s->tls_authz,
-            NULL);
+            &err);
     } else {
         tioc = qio_channel_tls_new_client(
             s->ioc, s->tls_creds,
             s->addr->u.inet.host,
-            NULL);
+            &err);
     }
     if (tioc == NULL) {
+        trace_chr_socket_tls_init_err(chr, chr->label, error_get_pretty(err));
         tcp_chr_disconnect(chr);
         return;
     }
diff --git a/chardev/trace-events b/chardev/trace-events
index 027107b0c1..7e97b8a988 100644
--- a/chardev/trace-events
+++ b/chardev/trace-events
@@ -17,3 +17,13 @@ spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
 spice_vmc_event(int event) "spice vmc event %d"
 
+# char-socket.c
+chr_socket_poll_err(void *chrdev, const char *label) "chardev socket poll error %p (%s)"
+chr_socket_recv_err(void *chrdev, const char *label, const char *err) "chardev socket recv error %p (%s): %s"
+chr_socket_recv_eof(void *chrdev, const char *label) "chardev socket recv end-of-file %p (%s)"
+chr_socket_write_err(void *chrdev, const char *label, const char *err) "chardev socket write error %p (%s): %s"
+chr_socket_disconnect(void *chrdev, const char *label) "chardev socket disconnect %p (%s)"
+chr_socket_hangup(void *chrdev, const char *label) "chardev socket hangup %p (%s)"
+chr_socket_ws_handshake_err(void *chrdev, const char *label, const char *err) "chardev socket websock handshake error %p (%s): %s"
+chr_socket_tls_handshake_err(void *chrdev, const char *label, const char *err) "chardev socket TLS handshake error %p (%s): %s"
+chr_socket_tls_init_err(void *chrdev, const char *label, const char *err) "chardev socket TLS init error %p (%s): %s"
-- 
2.45.2


