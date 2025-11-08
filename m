Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C605FCCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0P-0005nD-Eh; Sat, 08 Nov 2025 18:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0I-0005dE-L5
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0F-0001jr-PG
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYCfZAH2P4JWJ/fPjO7E2/nMVRBEkEBOTpeY5IMD+Kk=;
 b=CIhL2u5r21EgWV75F8tZ5MoVAIkie35rS0PDolm8uxdiCF/LtLn0X0yR9UGaSGIlpaVqh5
 UodyLH+suXym4ThfIhxyjE7x7CXk1BXIs9LXN9x+4AC4iHBmy0W2EK7bF3/3oJfGl3Gq6z
 ssPgMqmeuKYk83Mk1BTlE1ema/esdXE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-LCp15DMhNISCGmbZrNUSCA-1; Sat,
 08 Nov 2025 18:05:47 -0500
X-MC-Unique: LCp15DMhNISCGmbZrNUSCA-1
X-Mimecast-MFC-AGG-ID: LCp15DMhNISCGmbZrNUSCA_1762643147
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E19D5195608F; Sat,  8 Nov 2025 23:05:46 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B6A6819560B0; Sat,  8 Nov 2025 23:05:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 09/12] qio: Prepare NetListener to use AioContext
Date: Sat,  8 Nov 2025 16:59:30 -0600
Message-ID: <20251108230525.3169174-23-eblake@redhat.com>
In-Reply-To: <20251108230525.3169174-14-eblake@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

---
v2: new patch, replacing the earlier "qio: Let listening sockets remember
their owning QIONetListener"
---
 include/io/net-listener.h |   6 ++-
 io/net-listener.c         | 102 ++++++++++++++++++++++++++------------
 io/trace-events           |   6 +--
 3 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 2605d6aae1e..7188721cb34 100644
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
index 83c977ecca2..ebc61f81ed6 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -23,8 +23,15 @@
 #include "io/dns-resolver.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
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
     return QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
@@ -52,7 +59,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
     }

     trace_qio_net_listener_callback(listener, listener->io_func,
-                                    listener->context);
+                                    listener->context, listener->aio_context);
     if (listener->io_func) {
         object_ref(OBJECT(listener));
         listener->io_func(listener, sioc, listener->io_data);
@@ -121,15 +128,25 @@ qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
     }

     trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, caller);
+                                 listener->context, listener->aio_context,
+                                 caller);
     if (i == 0) {
         object_ref(OBJECT(listener));
     }
     for ( ; i < listener->nsioc; i++) {
-        listener->io_source[i] = qio_channel_add_watch_source(
-            QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, NULL, listener->context);
+        if (!listener->aio_context) {
+            /*
+             * The user passed a GMainContext with the async callback;
+             * they plan on running the default or their own g_main_loop.
+             */
+            listener->source[i]->io_source = qio_channel_add_watch_source(
+                QIO_CHANNEL(listener->source[i]->sioc), G_IO_IN,
+                qio_net_listener_channel_func,
+                listener, NULL, listener->context);
+        } else {
+            /* The user passed an AioContext. Not supported yet. */
+            g_assert_not_reached();
+        }
     }
 }

@@ -143,12 +160,17 @@ qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
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
     object_unref(OBJECT(listener));
@@ -161,13 +183,12 @@ void qio_net_listener_add(QIONetListener *listener,
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
@@ -177,14 +198,17 @@ void qio_net_listener_add(QIONetListener *listener,
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
     if (listener->io_func == func && listener->io_data == data &&
-        listener->io_notify == notify && listener->context == context) {
+        listener->io_notify == notify && listener->context == context &&
+        listener->aio_context == aio_context) {
         return;
     }

@@ -196,17 +220,28 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
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
@@ -253,8 +288,8 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)

     sources = g_new0(GSource *, listener->nsioc);
     for (i = 0; i < listener->nsioc; i++) {
-        sources[i] = qio_channel_create_watch(QIO_CHANNEL(listener->sioc[i]),
-                                              G_IO_IN);
+        sources[i] = qio_channel_create_watch(
+            QIO_CHANNEL(listener->source[i]->sioc), G_IO_IN);

         g_source_set_callback(sources[i],
                               (GSourceFunc)qio_net_listener_wait_client_func,
@@ -287,7 +322,7 @@ void qio_net_listener_disconnect(QIONetListener *listener)

     qio_net_listener_unwatch(listener, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
-        qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
+        qio_channel_close(QIO_CHANNEL(listener->source[i]->sioc), NULL);
     }
     listener->connected = false;
 }
@@ -308,8 +343,9 @@ QIOChannelSocket *qio_net_listener_sioc(QIONetListener *listener, size_t n)
     if (n > listener->nsioc) {
         return NULL;
     }
-    return listener->sioc[n];
+    return listener->source[n]->sioc;
 }
+
 static void qio_net_listener_finalize(Object *obj)
 {
     QIONetListener *listener = QIO_NET_LISTENER(obj);
@@ -321,10 +357,10 @@ static void qio_net_listener_finalize(Object *obj)
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


