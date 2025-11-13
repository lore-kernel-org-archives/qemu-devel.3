Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC2BCD98FD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEd-00076C-Be; Thu, 13 Nov 2025 17:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEN-0006oX-5V
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEL-0000mS-3K
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zl1tSx7oXhDkawNx+wgnYKG9RpQxNVhYdnaOmKnwjw=;
 b=DYbhLVWi76qWfpS9dS046DdJ0gbw4XE5ng2Lg0TCz7ICd/sotHgy6XiAaIJlLZ7qWltJ+B
 ixM/tCADLIMOJIur6DzaqPcwPlmd+Ca+9OI7qhuMF4unlOjinHOTz/yuqPa+ElGjmpQDNX
 RSGmjmY3OHjaUlTw5vyzWYq01wSqdJQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-swmR0szGNqCQnuvWUC4L6g-1; Thu,
 13 Nov 2025 17:55:50 -0500
X-MC-Unique: swmR0szGNqCQnuvWUC4L6g-1
X-Mimecast-MFC-AGG-ID: swmR0szGNqCQnuvWUC4L6g_1763074548
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8EB018AB40A
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:55:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3034719540DF; Thu, 13 Nov 2025 22:55:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/15] qio: Add QIONetListener API for using AioContext
Date: Thu, 13 Nov 2025 16:55:07 -0600
Message-ID: <20251113225531.1077484-28-eblake@redhat.com>
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
References: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The user calling himself "John Doe" reported a deadlock when
attempting to use qemu-storage-daemon to serve both a base file over
NBD, and a qcow2 file with that NBD export as its backing file, from
the same process, even though it worked just fine when there were two
q-s-d processes.  The bulk of the NBD server code properly uses
coroutines to make progress in an event-driven manner, but the code
for spawning a new coroutine at the point when listen(2) detects a new
client was hard-coded to use the global GMainContext; in other words,
the callback that triggers nbd_client_new to let the server start the
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

This patch adds a new API to allow clients to opt in to listening via
an AioContext rather than a GMainContext.  This will allow NBD to fix
the deadlock by performing all actions during bdrv_open in the main
loop AioContext.

Technical debt warning: I would have loved to utilize a notify
function with AioContext to guarantee that we don't finalize listener
due to an object_unref if there is any callback still running (the way
GSource does), but wiring up notify functions into AioContext is a
bigger task that will be deferred to a later QEMU release.  But for
solving the NBD deadlock, it is sufficient to note that the QMP
commands for enabling and disabling the NBD server are really the only
points where we want to change the listener's callback.  Furthermore,
those commands are serviced in the main loop, which is the same
AioContext that is also listening for connections.  Since a thread
cannot interrupt itself, we are ensured that at the point where we are
changing the watch, there are no callbacks active.  This is NOT as
powerful as the GSource cross-thread safety, but sufficient for the
needs of today.

An upcoming patch will then add a unit test (kept separate to make it
easier to rearrange the series to demonstrate the deadlock without
this patch).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251113011625.878876-26-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/net-listener.h | 21 +++++++++++++
 io/net-listener.c         | 66 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 93608f7fe89..fdc5f1c81ad 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -152,6 +152,27 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
                                       gpointer data,
                                       GDestroyNotify notify);

+/**
+ * qio_net_listener_set_client_aio_func:
+ * @listener: the network listener object
+ * @func: the callback function
+ * @data: opaque data to pass to @func
+ * @context: AioContext that @func will be bound to; if NULL, this will
+ *           will use qemu_get_aio_context().
+ *
+ * Similar to qio_net_listener_set_client_func_full(), except that the polling
+ * will be done by an AioContext rather than a GMainContext.
+ *
+ * Because AioContext does not (yet) support a clean way to deregister
+ * a callback from one thread while another thread might be in that
+ * callback, this function is only safe to call from the thread
+ * currently associated with @context.
+ */
+void qio_net_listener_set_client_aio_func(QIONetListener *listener,
+                                          QIONetListenerClientFunc func,
+                                          void *data,
+                                          AioContext *context);
+
 /**
  * qio_net_listener_wait_client:
  * @listener: the network listener object
diff --git a/io/net-listener.c b/io/net-listener.c
index 49399ec926a..9410d72da9c 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -85,6 +85,17 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
 }


+static void qio_net_listener_aio_func(void *opaque)
+{
+    QIONetListenerSource *data = opaque;
+
+    assert(data->io_source == NULL);
+    assert(data->listener->aio_context != NULL);
+    qio_net_listener_channel_func(QIO_CHANNEL(data->sioc), G_IO_IN,
+                                  data->listener);
+}
+
+
 int qio_net_listener_open_sync(QIONetListener *listener,
                                SocketAddress *addr,
                                int num,
@@ -157,8 +168,26 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
                 qio_net_listener_channel_func,
                 listener, (GDestroyNotify)object_unref, listener->context);
         } else {
-            /* The user passed an AioContext. Not supported yet. */
-            g_assert_not_reached();
+            /*
+             * The user passed an AioContext.  At this point,
+             * AioContext lacks a clean way to call a notify function
+             * to release a final reference after any callback is
+             * complete.  But we asserted earlier that the async
+             * callback is changed only from the thread associated
+             * with aio_context, which means no other thread is in the
+             * middle of running the callback when we are changing the
+             * refcount on listener here.  Therefore, a single
+             * reference here is sufficient to ensure listener is not
+             * finalized during the callback.
+             */
+            assert(listener->context == NULL);
+            if (i == 0) {
+                object_ref(OBJECT(listener));
+            }
+            qio_channel_set_aio_fd_handler(
+                QIO_CHANNEL(listener->source[i]->sioc),
+                listener->aio_context, qio_net_listener_aio_func,
+                NULL, NULL, listener->source[i]);
         }
     }
 }
@@ -184,7 +213,13 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
                 listener->source[i]->io_source = NULL;
             }
         } else {
-            g_assert_not_reached();
+            assert(listener->context == NULL);
+            qio_channel_set_aio_fd_handler(
+                QIO_CHANNEL(listener->source[i]->sioc),
+                listener->aio_context, NULL, NULL, NULL, NULL);
+            if (i == listener->nsioc - 1) {
+                object_unref(OBJECT(listener));
+            }
         }
     }
 }
@@ -259,6 +294,31 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
                                               notify, NULL, NULL);
 }

+void qio_net_listener_set_client_aio_func(QIONetListener *listener,
+                                          QIONetListenerClientFunc func,
+                                          void *data,
+                                          AioContext *context)
+{
+    if (!context) {
+        assert(qemu_in_main_thread());
+        context = qemu_get_aio_context();
+    } else {
+        /*
+         * TODO: The API was intentionally designed to allow a caller
+         * to pass an alternative AioContext for future expansion;
+         * however, actually implementating that is not possible
+         * without notify callbacks wired into AioContext similar to
+         * how they work in GSource.  So for now, this code hard-codes
+         * the knowledge that the only client needing AioContext is
+         * the NBD server, which uses the global context and does not
+         * suffer from cross-thread safety issues.
+         */
+        g_assert_not_reached();
+    }
+    qio_net_listener_set_client_func_internal(listener, func, data,
+                                              NULL, NULL, context);
+}
+
 struct QIONetListenerClientWaitData {
     QIOChannelSocket *sioc;
     GMainLoop *loop;
-- 
2.51.1


