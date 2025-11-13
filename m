Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3649CDB462
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 22:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJgEL-0006mt-UY; Thu, 13 Nov 2025 17:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEI-0006jC-F5
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJgEG-0000lZ-HZ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 17:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763074547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SU7yP76Uvd8w6yurXye0Qc5eRGbwH1FcGzyJeA2HzW4=;
 b=DqBSOWR7T7gRXkVPeN/ce6AOsSDP7ywzYhOPqjrqsoaVyMROjta3B7O1/EjNPR9jTJezh0
 cmytFlbfmbO6kFx6vi8OeBW417T9+CNH+ZYfvThuDVqOB6jN9vherlz01wVcaWCMpe33cg
 Mz9vHYPvc6jUgO6aULO7ZRKhev1wtpQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-9BhDptGCMxGKFP3W5M54gQ-1; Thu,
 13 Nov 2025 17:55:44 -0500
X-MC-Unique: 9BhDptGCMxGKFP3W5M54gQ-1
X-Mimecast-MFC-AGG-ID: 9BhDptGCMxGKFP3W5M54gQ_1763074543
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64018195608E
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:55:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A82FF19540DF; Thu, 13 Nov 2025 22:55:42 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/15] qio: Factor out helpers qio_net_listener_[un]watch
Date: Thu, 13 Nov 2025 16:55:03 -0600
Message-ID: <20251113225531.1077484-24-eblake@redhat.com>
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

The code had three similar repetitions of an iteration over one or all
of nsiocs to set up a GSource, and likewise for teardown.  Since an
upcoming patch wants to tweak whether GSource or AioContext is used,
it's better to consolidate that into one helper function for fewer
places to edit later.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251113011625.878876-22-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/net-listener.c | 122 ++++++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 70 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index 93100a2d253..9a94b153279 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -120,13 +120,54 @@ int qio_net_listener_open_sync(QIONetListener *listener,
     }
 }

+/*
+ * i == 0 to set watch on entire array, non-zero to only set watch on
+ * recent additions when earlier entries are already watched.
+ *
+ * listener->lock must be held by caller.
+ */
+static void
+qio_net_listener_watch(QIONetListener *listener, size_t i, const char *caller)
+{
+    if (!listener->io_func) {
+        return;
+    }
+
+    trace_qio_net_listener_watch(listener, listener->io_func,
+                                 listener->context, caller);
+    for ( ; i < listener->nsioc; i++) {
+        object_ref(OBJECT(listener));
+        listener->io_source[i] = qio_channel_add_watch_source(
+            QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
+            qio_net_listener_channel_func,
+            listener, (GDestroyNotify)object_unref, listener->context);
+    }
+}
+
+/* listener->lock must be held by caller. */
+static void
+qio_net_listener_unwatch(QIONetListener *listener, const char *caller)
+{
+    size_t i;
+
+    if (!listener->io_func) {
+        return;
+    }
+
+    trace_qio_net_listener_unwatch(listener, listener->io_func,
+                                   listener->context, caller);
+    for (i = 0; i < listener->nsioc; i++) {
+        if (listener->io_source[i]) {
+            g_source_destroy(listener->io_source[i]);
+            g_source_unref(listener->io_source[i]);
+            listener->io_source[i] = NULL;
+        }
+    }
+}

 void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc)
 {
-    QIONetListenerClientFunc io_func;
-    GMainContext *context;
-
     if (listener->name) {
         qio_channel_set_name(QIO_CHANNEL(sioc), listener->name);
     }
@@ -142,21 +183,9 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;

-    WITH_QEMU_LOCK_GUARD(&listener->lock) {
-        io_func = listener->io_func;
-        context = listener->context;
-    }
-
-    trace_qio_net_listener_watch(listener, io_func, context, "add");
-    if (io_func) {
-        object_ref(OBJECT(listener));
-        listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
-            QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, context);
-    }
-
+    QEMU_LOCK_GUARD(&listener->lock);
     listener->nsioc++;
+    qio_net_listener_watch(listener, listener->nsioc - 1, "add");
 }


@@ -166,25 +195,13 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
                                            GDestroyNotify notify,
                                            GMainContext *context)
 {
-    size_t i;
-
     QEMU_LOCK_GUARD(&listener->lock);
     if (listener->io_func == func && listener->io_data == data &&
         listener->io_notify == notify && listener->context == context) {
         return;
     }

-    trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   listener->context, "set_client_func");
-
-    for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
-        }
-    }
-
+    qio_net_listener_unwatch(listener, "set_client_func");
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -193,17 +210,7 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     listener->io_notify = notify;
     listener->context = context;

-    trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, "set_client_func");
-    if (listener->io_func != NULL) {
-        for (i = 0; i < listener->nsioc; i++) {
-            object_ref(OBJECT(listener));
-            listener->io_source[i] = qio_channel_add_watch_source(
-                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-                qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref, context);
-        }
-    }
+    qio_net_listener_watch(listener, 0, "set_client_func");
 }

 void qio_net_listener_set_client_func(QIONetListener *listener,
@@ -254,21 +261,9 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
         .loop = loop
     };
     size_t i;
-    QIONetListenerClientFunc io_func;
-    GMainContext *context;

     WITH_QEMU_LOCK_GUARD(&listener->lock) {
-        io_func = listener->io_func;
-        context = listener->context;
-    }
-
-    trace_qio_net_listener_unwatch(listener, io_func, context, "wait_client");
-    for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
-        }
+        qio_net_listener_unwatch(listener, "wait_client");
     }

     sources = g_new0(GSource *, listener->nsioc);
@@ -292,15 +287,8 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);

-    trace_qio_net_listener_watch(listener, io_func, context, "wait_client");
-    if (io_func != NULL) {
-        for (i = 0; i < listener->nsioc; i++) {
-            object_ref(OBJECT(listener));
-            listener->io_source[i] = qio_channel_add_watch_source(
-                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-                qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref, context);
-        }
+    WITH_QEMU_LOCK_GUARD(&listener->lock) {
+        qio_net_listener_watch(listener, 0, "wait_client");
     }

     return data.sioc;
@@ -315,14 +303,8 @@ void qio_net_listener_disconnect(QIONetListener *listener)
     }

     QEMU_LOCK_GUARD(&listener->lock);
-    trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   listener->context, "disconnect");
+    qio_net_listener_unwatch(listener, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
-        }
         qio_channel_close(QIO_CHANNEL(listener->sioc[i]), NULL);
     }
     listener->connected = false;
-- 
2.51.1


