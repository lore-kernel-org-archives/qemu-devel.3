Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D664CCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0L-0005gV-8u; Sat, 08 Nov 2025 18:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0A-0005TT-N5
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs08-0001gL-Nj
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yO3pUiCIfNOPPL+f28s/uQabQqNRwayP/PJkeGgpLX0=;
 b=XjWvVrpYUcrpXI3r05bgN5HgwJzrSPuD6Hd46wdN33Vmi6fenOA2vuqmld7ahC6EuPagbC
 boOesGeHJim8CCU58Hi4JPwpoZHtvboAswpkxolMMIzs4KRiKzs9R3ASxPBmfNasAx6uol
 k11gzud5mwiyYC9h2rvx58aA88Edvgc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-cxYgnvlrMhCVahOc9_FtjA-1; Sat,
 08 Nov 2025 18:05:41 -0500
X-MC-Unique: cxYgnvlrMhCVahOc9_FtjA-1
X-Mimecast-MFC-AGG-ID: cxYgnvlrMhCVahOc9_FtjA_1762643141
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F12F1800250; Sat,  8 Nov 2025 23:05:41 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F149219560A7; Sat,  8 Nov 2025 23:05:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH v2 06/12] qio: Factor out helpers qio_net_listener_[un]watch
Date: Sat,  8 Nov 2025 16:59:27 -0600
Message-ID: <20251108230525.3169174-20-eblake@redhat.com>
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

The code had three similar repetitions of an iteration over one or all
of nsiocs to set up a GSource, and likewise for teardown.  Since an
upcoming patch wants to tweak whether GSource or AioContext is used,
its better to consolidate that into one helper function for fewer
places to edit later.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to changes on the tracepoints earlier in series
---
 io/net-listener.c | 108 ++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 61 deletions(-)

diff --git a/io/net-listener.c b/io/net-listener.c
index a9da8e4e069..ad097175eba 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -107,6 +107,47 @@ int qio_net_listener_open_sync(QIONetListener *listener,
     }
 }

+/*
+ * i == 0 to set watch on entire array, non-zero to only set watch on
+ * recent additions when earlier entries are already watched.
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
@@ -126,17 +167,8 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;

-    trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, "add");
-    if (listener->io_func != NULL) {
-        object_ref(OBJECT(listener));
-        listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
-            QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
-            qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, listener->context);
-    }
-
     listener->nsioc++;
+    qio_net_listener_watch(listener, listener->nsioc - 1, "add");
 }


@@ -146,24 +178,12 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
                                            GDestroyNotify notify,
                                            GMainContext *context)
 {
-    size_t i;
-
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
@@ -172,17 +192,7 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
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
@@ -234,15 +244,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;

-    trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   listener->context, "wait_client");
-    for (i = 0; i < listener->nsioc; i++) {
-        if (listener->io_source[i]) {
-            g_source_destroy(listener->io_source[i]);
-            g_source_unref(listener->io_source[i]);
-            listener->io_source[i] = NULL;
-        }
-    }
+    qio_net_listener_unwatch(listener, "wait_client");

     sources = g_new0(GSource *, listener->nsioc);
     for (i = 0; i < listener->nsioc; i++) {
@@ -265,17 +267,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);

-    trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, "wait_client");
-    if (listener->io_func != NULL) {
-        for (i = 0; i < listener->nsioc; i++) {
-            object_ref(OBJECT(listener));
-            listener->io_source[i] = qio_channel_add_watch_source(
-                QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
-                qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref, listener->context);
-        }
-    }
+    qio_net_listener_watch(listener, 0, "wait_client");

     return data.sioc;
 }
@@ -288,14 +280,8 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }

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


