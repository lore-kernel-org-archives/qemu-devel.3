Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F4CCCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1BD-00045x-Hi; Mon, 03 Nov 2025 15:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1B1-0003pY-H8
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ay-0007im-7O
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3665WET8n0BkmnE742sRFIUJjlw+28NAK/J1/BwZ0Q=;
 b=GTO1pb3/5sSHTHcwJXFKZ+uua6TljUiHAtHbMGvQ2ZiEmkG6zP4ECCI82H5KfzDftjrzBZ
 H2SLVqsZA7D0qTpzTw7pEEQliLNNCAscB2Y49Ssy2UtvYSyzeCvLBENhfWCgZkzyEqHlhG
 /HSXyn5Y2Ojvz7vkxGfTIC5CtLUp744=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-VfCG1JpzOAKahxO5yO9Sdg-1; Mon,
 03 Nov 2025 15:29:12 -0500
X-MC-Unique: VfCG1JpzOAKahxO5yO9Sdg-1
X-Mimecast-MFC-AGG-ID: VfCG1JpzOAKahxO5yO9Sdg_1762201751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC2E1944D3A; Mon,  3 Nov 2025 20:29:07 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53B6130001A1; Mon,  3 Nov 2025 20:29:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 7/8] qio: Use AioContext for default-context QIONetListener
Date: Mon,  3 Nov 2025 14:10:58 -0600
Message-ID: <20251103202849.3687643-17-eblake@redhat.com>
In-Reply-To: <20251103202849.3687643-10-eblake@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The user "John Doe" reported a deadlock when attempting to use
qemu-storage-daemon to serve both a base file over NBD, and a qcow2
file with that NBD export as its backing file, from the same process,
even though it worked just fine when there were two q-s-d processes.
The bulk of the NBD server code properly uses coroutines to make
progress in an event-driven manner, but the code for spawning a new
coroutine at the point when listen(2) detects a new client was
hard-coded to use the global GMainContext; in other words, the
callback that triggers nbd_client_new to let the server start the
negotiation sequence with the client requires the main loop to be
making progress.  However, the code for bdrv_open of a qcow2 image
with an NBD backing file uses an AIO_WAIT_WHILE nested event loop to
ensure that the entire qcow2 backing chain is either fully loaded or
rejected, without any side effects from the main loop causing unwanted
changes to the disk being loaded (in short, an AioContext represents
the set of actions that are known to be safe while handling block
layer I/O, while excluding any other pending actions in the global
main loop with potentially larger risk of unwanted side effects).

This creates a classic case of deadlock: the server can't progress to
the point of accept(2)ing the client to write to the NBD socket
because the main loop is being starved until the AIO_WAIT_WHILE
completes the bdrv_open, but the AIO_WAIT_WHILE can't progress because
it is blocked on the client coroutine stuck in a read() of the
expected magic number from the server side of the socket.

Fortunately, the way that AioContext is set up, any callback that is
registered to the global AioContext will also be serviced by the main
loop.  So the fix for the deadlock is to alter QIONetListener so that
if it is not being used in an explicit alternative GMainContext, then
it should perform its polling via the global AioContext (which
indirectly still progresses in the default GMainContext) rather than
directly in the default GMainContext.  This has no change in behavior
to any prior use that did not starve the main loop, but has the
additional benefit that in the bdrv_open case of a nested AioContext
loop, the server's listen/accept handler is no longer starved because
it is now part of the same AioContext loop.  From there, since NBD
already uses coroutines for both server and client code, the nested
AioContext loop finishes quickly and opening the qcow2 backing chain
no longer deadlocks.

The next patch will add a unit test (kept separate to make it easier
to rearrange the series to demonstrate the deadlock without this
patch).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 io/net-listener.c | 53 ++++++++++++++++++++++++++++++++++++++---------
 io/trace-events   |  4 ++--
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index ce29bf3c993..9f4e3c0be0c 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -23,6 +23,7 @@
 #include "io/dns-resolver.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/main-loop.h"
 #include "trace.h"

 QIONetListener *qio_net_listener_new(void)
@@ -62,6 +63,15 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
 }


+static void qio_net_listener_aio_func(void *opaque)
+{
+    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(opaque);
+
+    qio_net_listener_channel_func(QIO_CHANNEL(sioc), G_IO_IN,
+                                  sioc->listener);
+}
+
+
 int qio_net_listener_open_sync(QIONetListener *listener,
                                SocketAddress *addr,
                                int num,
@@ -117,15 +127,33 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
         return;
     }

-    trace_qio_net_listener_watch_enabled(listener, listener->io_func, caller);
+    trace_qio_net_listener_watch_enabled(listener, listener->io_func,
+                                         listener->context, caller);
     if (i == 0) {
         object_ref(OBJECT(listener));
     }
     for ( ; i < listener->nsioc; i++) {
-        listener->io_source[i] = qio_channel_add_watch_source(
-            QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, NULL, listener->context);
+        if (listener->context) {
+            /*
+             * The user passed a GMainContext with the async callback;
+             * they plan on running their own g_main_loop.
+             */
+            listener->io_source[i] = qio_channel_add_watch_source(
+                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
+                qio_net_listener_channel_func,
+                listener, NULL, listener->context);
+        } else {
+            /*
+             * The user is fine with the default context. But by doing
+             * it in the main thread's AioContext rather than
+             * specifically in a GMainContext, we can remain
+             * responsive even if another AioContext depends on
+             * connecting to this server.
+             */
+            aio_set_fd_handler(qemu_get_aio_context(), listener->sioc[i]->fd,
+                               qio_net_listener_aio_func, NULL, NULL, NULL,
+                               listener->sioc[i]);
+        }
     }
 }

@@ -138,12 +166,17 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
         return;
     }

-    trace_qio_net_listener_watch_disabled(listener, caller);
+    trace_qio_net_listener_watch_disabled(listener, listener->context, caller);
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
+        if (listener->context) {
+            if (listener->io_source[i]) {
+                g_source_destroy(listener->io_source[i]);
+                g_source_unref(listener->io_source[i]);
+                listener->io_source[i] = NULL;
+            }
+        } else {
+            aio_set_fd_handler(qemu_get_aio_context(), listener->sioc[i]->fd,
+                               NULL, NULL, NULL, NULL, NULL);
         }
     }
     object_unref(OBJECT(listener));
diff --git a/io/trace-events b/io/trace-events
index 8cc4cae3a5d..1b01b2d51e6 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -74,6 +74,6 @@ qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"

 # net-listener.c
-qio_net_listener_watch_enabled(void *listener, void *func, const char *extra) "Net listener=%p watch enabled func=%p by %s"
-qio_net_listener_watch_disabled(void *listener, const char *extra) "Net listener=%p watch disabled by %s"
+qio_net_listener_watch_enabled(void *listener, void *func, void *ctx, const char *extra) "Net listener=%p watch enabled func=%p ctx=%p by %s"
+qio_net_listener_watch_disabled(void *listener, void *ctx, const char *extra) "Net listener=%p watch disabled ctx=%p by %s"
 qio_net_listener_callback(void *listener, void *func) "Net listener=%p callback forwarding to func=%p"
-- 
2.51.1


