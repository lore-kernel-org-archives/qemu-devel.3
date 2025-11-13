Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A38CDB462
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEO-0006oq-Od; Thu, 13 Nov 2025 17:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEL-0006mc-IC
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEJ-0000mJ-MQ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7A/pDxj9Zg7LMPMNXAf7r4z7n91w0v7vbbTecq2olM=;
 b=E+Iy3T2XDLKfQLDrgOuYPjAciXewoq9ZM03/QD4kHJFdOSgf0mnILLh5jIwttvqQlMl6RK
 iIsawK+96QA55XLZC1ODAXVIyakdZ6M5fASDttsrwD/+N4EFSxGfjcNVXyysbLamXf0g8e
 i0mGMKxQose415KnmSCV97kQ9oXvDpA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-isRpmRzDMce_wzPvPiq8tg-1; Thu,
 13 Nov 2025 17:55:48 -0500
X-MC-Unique: isRpmRzDMce_wzPvPiq8tg-1
X-Mimecast-MFC-AGG-ID: isRpmRzDMce_wzPvPiq8tg_1763074547
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CACFB195606E
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:55:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31EA019540E6; Thu, 13 Nov 2025 22:55:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/15] qio: Prepare NetListener to use AioContext
Date: Thu, 13 Nov 2025 16:55:06 -0600
Message-ID: <20251113225531.1077484-27-eblake@redhat.com>
In-Reply-To: <20251113225531.1077484-17-eblake@redhat.com>
References: <20251113225531.1077484-17-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

For ease of review, this patch adds an AioContext pointer to the
QIONetListener struct, the code to trace it, and refactors
listener->io_source to instead be an array of utility structs; but the
aio_context pointer is always NULL until the next patch adds an API to
set it.  There should be no semantic change in this patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113011625.878876-25-eblake@redhat.com>
---
 include/io/net-listener.h |   6 ++-
 io/net-listener.c         | 105 ++++++++++++++++++++++++++------------
 io/trace-events           |   6 +--
 3 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 95bc7407d66..93608f7fe89 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -28,6 +28,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(QIONetListener,
                            QIO_NET_LISTENER)

+typedef struct QIONetListenerSource QIONetListenerSource;

 typedef void (*QIONetListenerClientFunc)(QIONetListener *listener,
                                          QIOChannelSocket *sioc,
@@ -47,10 +48,11 @@ struct QIONetListener {
     Object parent;

     char *name;
-    QIOChannelSocket **sioc;
-    GSource **io_source;
+    QIONetListenerSource **source;
     size_t nsioc;
+    /* At most one of context or aio_context will be set */
     GMainContext *context;
+    AioContext *aio_context;

     bool connected;

diff --git a/io/net-listener.c b/io/net-listener.c
index 9ffbc141a76..49399ec926a 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -24,8 +24,15 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/lockable.h"
+#include "qemu/main-loop.h"
 #include "trace.h"

+struct QIONetListenerSource {
+    QIOChannelSocket *sioc;
+    GSource *io_source;
+    QIONetListener *listener;
+};
+
 QIONetListener *qio_net_listener_new(void)
 {
     QIONetListener *listener;
@@ -52,6 +59,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
     QIONetListenerClientFunc io_func;
     gpointer io_data;
     GMainContext *context;
+    AioContext *aio_context;

     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
                                      NULL);
@@ -63,9 +71,10 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
         io_func = listener->io_func;
         io_data = listener->io_data;
         context = listener->context;
+        aio_context = listener->aio_context;
     }

-    trace_qio_net_listener_callback(listener, io_func, context);
+    trace_qio_net_listener_callback(listener, io_func, context, aio_context);
     if (io_func) {
         io_func(listener, sioc, io_data);
     }
@@ -134,13 +143,23 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
     }

     trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, caller);
+                                 listener->context, listener->aio_context,
+                                 caller);
     for ( ; i < listener->nsioc; i++) {
-        object_ref(OBJECT(listener));
-        listener->io_source[i] = qio_channel_add_watch_source(
-            QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, listener->context);
+        if (!listener->aio_context) {
+            /*
+             * The user passed a GMainContext with the async callback;
+             * they plan on running the default or their own g_main_loop.
+             */
+            object_ref(OBJECT(listener));
+            listener->source[i]->io_source = qio_channel_add_watch_source(
+                QIO_CHANNEL(listener->source[i]->sioc), G_IO_IN,
+                qio_net_listener_channel_func,
+                listener, (GDestroyNotify)object_unref, listener->context);
+        } else {
+            /* The user passed an AioContext. Not supported yet. */
+            g_assert_not_reached();
+        }
     }
 }

@@ -155,12 +174,17 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
     }

     trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   listener->context, caller);
+                                   listener->context, listener->aio_context,
+                                   caller);
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
+        if (!listener->aio_context) {
+            if (listener->source[i]->io_source) {
+                g_source_destroy(listener->source[i]->io_source);
+                g_source_unref(listener->source[i]->io_source);
+                listener->source[i]->io_source = NULL;
+            }
+        } else {
+            g_assert_not_reached();
         }
     }
 }
@@ -172,13 +196,12 @@ void qio_net_listener_add(QIONetListener *listener,
         qio_channel_set_name(QIO_CHANNEL(sioc), listener->name);
     }

-    listener->sioc = g_renew(QIOChannelSocket *, listener->sioc,
-                             listener->nsioc + 1);
-    listener->io_source = g_renew(typeof(listener->io_source[0]),
-                                  listener->io_source,
-                                  listener->nsioc + 1);
-    listener->sioc[listener->nsioc] = sioc;
-    listener->io_source[listener->nsioc] = NULL;
+    listener->source = g_renew(typeof(listener->source[0]),
+                               listener->source,
+                               listener->nsioc + 1);
+    listener->source[listener->nsioc] = g_new0(QIONetListenerSource, 1);
+    listener->source[listener->nsioc]->sioc = sioc;
+    listener->source[listener->nsioc]->listener = listener;

     object_ref(OBJECT(sioc));
     listener->connected = true;
@@ -189,15 +212,18 @@ void qio_net_listener_add(QIONetListener *listener,
 }


-void qio_net_listener_set_client_func_full(QIONetListener *listener,
-                                           QIONetListenerClientFunc func,
-                                           gpointer data,
-                                           GDestroyNotify notify,
-                                           GMainContext *context)
+static void
+qio_net_listener_set_client_func_internal(QIONetListener *listener,
+                                          QIONetListenerClientFunc func,
+                                          gpointer data,
+                                          GDestroyNotify notify,
+                                          GMainContext *context,
+                                          AioContext *aio_context)
 {
     QEMU_LOCK_GUARD(&listener->lock);
     if (listener->io_func == func && listener->io_data == data &&
-        listener->io_notify == notify && listener->context == context) {
+        listener->io_notify == notify && listener->context == context &&
+        listener->aio_context == aio_context) {
         return;
     }

@@ -209,17 +235,28 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     listener->io_data = data;
     listener->io_notify = notify;
     listener->context = context;
+    listener->aio_context = aio_context;

     qio_net_listener_watch(listener, 0, "set_client_func");
 }

+void qio_net_listener_set_client_func_full(QIONetListener *listener,
+                                           QIONetListenerClientFunc func,
+                                           gpointer data,
+                                           GDestroyNotify notify,
+                                           GMainContext *context)
+{
+    qio_net_listener_set_client_func_internal(listener, func, data,
+                                              notify, context, NULL);
+}
+
 void qio_net_listener_set_client_func(QIONetListener *listener,
                                       QIONetListenerClientFunc func,
                                       gpointer data,
                                       GDestroyNotify notify)
 {
-    qio_net_listener_set_client_func_full(listener, func, data,
-                                          notify, NULL);
+    qio_net_listener_set_client_func_internal(listener, func, data,
+                                              notify, NULL, NULL);
 }

 struct QIONetListenerClientWaitData {
@@ -268,8 +305,8 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)

     sources = g_new0(GSource *, listener->nsioc);
     for (i = 0; i < listener->nsioc; i++) {
-        sources[i] = qio_channel_create_watch(QIO_CHANNEL(listener->sioc[i]),
-                                              G_IO_IN);
+        sources[i] = qio_channel_create_watch(
+            QIO_CHANNEL(listener->source[i]->sioc), G_IO_IN);

         g_source_set_callback(sources[i],
                               (GSourceFunc)qio_net_listener_wait_client_func,
@@ -305,7 +342,7 @@ void qio_net_listener_disconnect(QIONetListener *listener)
     QEMU_LOCK_GUARD(&listener->lock);
     qio_net_listener_unwatch(listener, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
-        qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
+        qio_channel_close(QIO_CHANNEL(listener->source[i]->sioc), NULL);
     }
     listener->connected = false;
 }
@@ -326,7 +363,7 @@ QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n)
     if (n >= listener->nsioc) {
         return NULL;
     }
-    return listener->sioc[n];
+    return listener->source[n]->sioc;
 }

 SocketAddress *
@@ -354,10 +391,10 @@ static void qio_net_listener_finalize(Object *obj)
     }

     for (i = 0; i < listener->nsioc; i++) {
-        object_unref(OBJECT(listener->sioc[i]));
+        object_unref(OBJECT(listener->source[i]->sioc));
+        g_free(listener->source[i]);
     }
-    g_free(listener->io_source);
-    g_free(listener->sioc);
+    g_free(listener->source);
     g_free(listener->name);
     qemu_mutex_destroy(&listener->lock);
 }
diff --git a/io/trace-events b/io/trace-events
index 0cb77d579b6..ec91453335a 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -74,6 +74,6 @@ qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"

 # net-listener.c
-qio_net_listener_watch(void *listener, void *func, void *ctx, const char *extra) "Net listener=%p watch enabled func=%p ctx=%p by %s"
-qio_net_listener_unwatch(void *listener, void *func, void *ctx, const char *extra) "Net listener=%p watch disabled func=%p ctx=%p by %s"
-qio_net_listener_callback(void *listener, void *func, void *ctx) "Net listener=%p callback forwarding to func=%p ctx=%p"
+qio_net_listener_watch(void *listener, void *func, void *gctx, void *actx, const char *extra) "Net listener=%p watch enabled func=%p ctx=%p/%p by %s"
+qio_net_listener_unwatch(void *listener, void *func, void *gctx, void *actx, const char *extra) "Net listener=%p watch disabled func=%p ctx=%p/%p by %s"
+qio_net_listener_callback(void *listener, void *func, void *gctx, void *actx) "Net listener=%p callback forwarding to func=%p ctx=%p/%p"
-- 
2.51.1


