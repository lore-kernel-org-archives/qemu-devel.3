Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE08CCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0O-0005mj-Ls; Sat, 08 Nov 2025 18:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0I-0005dG-Lo
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0F-0001je-DC
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MYwiU7nYP0+sR8jZh/WC9zAz8Ea5t7r6LXo4wsBhCwI=;
 b=TvhA4CEWxA0tVM+m74JGTJAMzuF4/UTwxlhpVdu577eULZR+6A55T95d9Fzo7f+wrHFaG0
 opDXTC8uJQHNnMzuKqx8HTFDaiQLPVFjxrmZYm6JI2CRl+9IcCBJy41DC696DER3LE4lKW
 tF0nhafwEgScxynjswwITFc5eiY+AZM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-U1fST1ySNdGB_2Ig-kOhlA-1; Sat,
 08 Nov 2025 18:05:49 -0500
X-MC-Unique: U1fST1ySNdGB_2Ig-kOhlA-1
X-Mimecast-MFC-AGG-ID: U1fST1ySNdGB_2Ig-kOhlA_1762643148
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61B14180047F; Sat,  8 Nov 2025 23:05:48 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FC0519560A7; Sat,  8 Nov 2025 23:05:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 10/12] qio: Add QIONetListener API for using AioContext
Date: Sat,  8 Nov 2025 16:59:31 -0600
Message-ID: <20251108230525.3169174-24-eblake@redhat.com>
In-Reply-To: <20251108230525.3169174-14-eblake@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

This patch adds a new API to allow clients to opt in to listening via
an AioContext rather than a GMainContext.  This will allow NBD to fix
the deadlock by performing all actions during bdrv_open in the main
loop AioContext.

An upcoming patch will then add a unit test (kept separate to make it
easier to rearrange the series to demonstrate the deadlock without
this patch).

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Retitle and add new API rather than changing semantics of
existing qio_net_listener_set_client_func; use qio accessor rather
than direct access to the sioc fd and a lower-level aio call
---
 include/io/net-listener.h | 16 ++++++++++++++++
 io/net-listener.c         | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 7188721cb34..e93efd5d96a 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -151,6 +151,22 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
                                       gpointer data,
                                       GDestroyNotify notify);

+/**
+ * qio_net_listener_set_client_aio_func:
+ * @listener: the network listener object
+ * @func: the callback function
+ * @data: opaque data to pass to @func
+ * @context: AioContext that @func will be bound to; if #NULL, this will
+ *           will use qemu_get_aio_context().
+ *
+ * Similar to qio_net_listener_set_client_func_full(), except that the polling
+ * will be done by an AioContext rather than a GMainContext.
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
index ebc61f81ed6..53f2e7091d7 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -72,6 +72,17 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
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
@@ -144,8 +155,12 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
                 qio_net_listener_channel_func,
                 listener, NULL, listener->context);
         } else {
-            /* The user passed an AioContext. Not supported yet. */
-            g_assert_not_reached();
+            /* The user passed an AioContext. */
+            assert(listener->context == NULL);
+            qio_channel_set_aio_fd_handler(
+                QIO_CHANNEL(listener->source[i]->sioc),
+                listener->aio_context, qio_net_listener_aio_func,
+                NULL, NULL, listener->source[i]);
         }
     }
 }
@@ -170,7 +185,10 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
                 listener->source[i]->io_source = NULL;
             }
         } else {
-            g_assert_not_reached();
+            assert(listener->context == NULL);
+            qio_channel_set_aio_fd_handler(
+                QIO_CHANNEL(listener->source[i]->sioc),
+                NULL, NULL, NULL, NULL, NULL);
         }
     }
     object_unref(OBJECT(listener));
@@ -244,6 +262,18 @@ void qio_net_listener_set_client_func(QIONetListener *listener,
                                               notify, NULL, NULL);
 }

+void qio_net_listener_set_client_aio_func(QIONetListener *listener,
+                                          QIONetListenerClientFunc func,
+                                          void *data,
+                                          AioContext *context)
+{
+    if (!context) {
+        context = qemu_get_aio_context();
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


