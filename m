Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2062CFC519
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcuG-0008RT-Ny; Fri, 21 Nov 2025 20:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbtN-0005PF-EH; Fri, 21 Nov 2025 19:54:21 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbrL-0000in-Ry; Fri, 21 Nov 2025 19:54:18 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8570516CA6D;
 Fri, 21 Nov 2025 21:44:26 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 41EC0321CA9;
 Fri, 21 Nov 2025 21:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 50/81] qio: Protect NetListener callback with mutex
Date: Fri, 21 Nov 2025 21:43:49 +0300
Message-ID: <20251121184424.1137669-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Eric Blake <eblake@redhat.com>

Without a mutex, NetListener can run into this data race between a
thread changing the async callback callback function to use when a
client connects, and the thread servicing polling of the listening
sockets:

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f1, ...);
           => foreach sock: socket
               => object_ref(lstnr)
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);

  Thread 2:
       poll()
          => event POLLIN on socket
               => ref(GSourceCallback)
               => if (lstnr->io_func) // while lstnr->io_func is f1
                    ...interrupt..

  Thread 1:
       qio_net_listener_set_client_func(lstnr, f2, ...);
          => foreach sock: socket
               => g_source_unref(sock_src)
          => foreach sock: socket
               => object_ref(lstnr)
               => sock_src = qio_channel_socket_add_watch_source(sock, ...., lstnr, object_unref);

  Thread 2:
               => call lstnr->io_func(lstnr->io_data) // now sees f2
               => return dispatch(sock)
               => unref(GSourceCallback)
                  => destroy-notify
                     => object_unref

Found by inspection; I did not spend the time trying to add sleeps or
execute under gdb to try and actually trigger the race in practice.
This is a SEGFAULT waiting to happen if f2 can become NULL because
thread 1 deregisters the user's callback while thread 2 is trying to
service the callback.  Other messes are also theoretically possible,
such as running callback f1 with an opaque pointer that should only be
passed to f2 (if the client code were to use more than just a binary
choice between a single async function or NULL).

Mitigating factor: if the code that modifies the QIONetListener can
only be reached by the same thread that is executing the polling and
async callbacks, then we are not in a two-thread race documented above
(even though poll can see two clients trying to connect in the same
window of time, any changes made to the listener by the first async
callback will be completed before the thread moves on to the second
client).  However, QEMU is complex enough that this is hard to
generically analyze.  If QMP commands (like nbd-server-stop) are run
in the main loop and the listener uses the main loop, things should be
okay.  But when a client uses an alternative GMainContext, or if
servicing a QMP command hands off to a coroutine to avoid blocking, I
am unable to state with certainty whether a given net listener can be
modified by a thread different from the polling thread running
callbacks.

At any rate, it is worth having the API be robust.  To ensure that
modifying a NetListener can be safely done from any thread, add a
mutex that guarantees atomicity to all members of a listener object
related to callbacks.  This problem has been present since
QIONetListener was introduced.

Note that this does NOT prevent the case of a second round of the
user's old async callback being invoked with the old opaque data, even
when the user has already tried to change the async callback during
the first async callback; it is only about ensuring that there is no
sharding (the eventual io_func(io_data) call that does get made will
correspond to a particular combination that the user had requested at
some point in time, and not be sharded to a combination that never
existed in practice).  In other words, this patch maintains the status
quo that a user's async callback function already needs to be robust
to parallel clients landing in the same window of poll servicing, even
when only one client is desired, if that particular listener can be
amended in a thread other than the one doing the polling.

CC: qemu-stable@nongnu.org
Fixes: 53047392 ("io: introduce a network socket listener API", v2.12.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20251113011625.878876-20-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[eblake: minor commit message wording improvements]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 9d86181874ab7b0e95ae988f6f80715943c618c6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index 42fbfab546..c2165dc166 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -54,6 +54,7 @@ struct QIONetListener {
 
     bool connected;
 
+    QemuMutex lock; /* Protects remaining fields */
     QIONetListenerClientFunc io_func;
     gpointer io_data;
     GDestroyNotify io_notify;
diff --git a/io/net-listener.c b/io/net-listener.c
index 0f16b78fbb..f70acdfc5c 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -23,11 +23,16 @@
 #include "io/dns-resolver.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/lockable.h"
 #include "trace.h"
 
 QIONetListener *qio_net_listener_new(void)
 {
-    return QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
+    QIONetListener *listener;
+
+    listener = QIO_NET_LISTENER(object_new(TYPE_QIO_NET_LISTENER));
+    qemu_mutex_init(&listener->lock);
+    return listener;
 }
 
 void qio_net_listener_set_name(QIONetListener *listener,
@@ -44,6 +49,9 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
 {
     QIONetListener *listener = QIO_NET_LISTENER(opaque);
     QIOChannelSocket *sioc;
+    QIONetListenerClientFunc io_func;
+    gpointer io_data;
+    GMainContext *context;
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
                                      NULL);
@@ -51,10 +59,15 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
         return TRUE;
     }
 
-    trace_qio_net_listener_callback(listener, listener->io_func,
-                                    listener->context);
-    if (listener->io_func) {
-        listener->io_func(listener, sioc, listener->io_data);
+    WITH_QEMU_LOCK_GUARD(&listener->lock) {
+        io_func = listener->io_func;
+        io_data = listener->io_data;
+        context = listener->context;
+    }
+
+    trace_qio_net_listener_callback(listener, io_func, context);
+    if (io_func) {
+        io_func(listener, sioc, io_data);
     }
 
     object_unref(OBJECT(sioc));
@@ -111,6 +124,9 @@ int qio_net_listener_open_sync(QIONetListener *listener,
 void qio_net_listener_add(QIONetListener *listener,
                           QIOChannelSocket *sioc)
 {
+    QIONetListenerClientFunc io_func;
+    GMainContext *context;
+
     if (listener->name) {
         qio_channel_set_name(QIO_CHANNEL(sioc), listener->name);
     }
@@ -126,14 +142,18 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;
 
-    trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, "add");
-    if (listener->io_func != NULL) {
+    WITH_QEMU_LOCK_GUARD(&listener->lock) {
+        io_func = listener->io_func;
+        context = listener->context;
+    }
+
+    trace_qio_net_listener_watch(listener, io_func, context, "add");
+    if (io_func) {
         object_ref(OBJECT(listener));
         listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
             QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
             qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, listener->context);
+            listener, (GDestroyNotify)object_unref, context);
     }
 
     listener->nsioc++;
@@ -148,6 +168,7 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;
 
+    QEMU_LOCK_GUARD(&listener->lock);
     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    listener->context, "set_client_func");
 
@@ -228,9 +249,15 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
         .loop = loop
     };
     size_t i;
+    QIONetListenerClientFunc io_func;
+    GMainContext *context;
 
-    trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   listener->context, "wait_client");
+    WITH_QEMU_LOCK_GUARD(&listener->lock) {
+        io_func = listener->io_func;
+        context = listener->context;
+    }
+
+    trace_qio_net_listener_unwatch(listener, io_func, context, "wait_client");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -260,15 +287,14 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
 
-    trace_qio_net_listener_watch(listener, listener->io_func,
-                                 listener->context, "wait_client");
-    if (listener->io_func != NULL) {
+    trace_qio_net_listener_watch(listener, io_func, context, "wait_client");
+    if (io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
             listener->io_source[i] = qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref, listener->context);
+                listener, (GDestroyNotify)object_unref, context);
         }
     }
 
@@ -283,6 +309,7 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }
 
+    QEMU_LOCK_GUARD(&listener->lock);
     trace_qio_net_listener_unwatch(listener, listener->io_func,
                                    listener->context, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
@@ -318,6 +345,7 @@ static void qio_net_listener_finalize(Object *obj)
     g_free(listener->io_source);
     g_free(listener->sioc);
     g_free(listener->name);
+    qemu_mutex_destroy(&listener->lock);
 }
 
 static const TypeInfo qio_net_listener_info = {
-- 
2.47.3


