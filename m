Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB36CFD2F3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 21:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMuqc-0000h0-Ja; Sat, 22 Nov 2025 16:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuqH-0000bp-00; Sat, 22 Nov 2025 16:08:28 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMuq8-00072v-F0; Sat, 22 Nov 2025 16:08:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1714216D309;
 Sun, 23 Nov 2025 00:03:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C36873223DD;
 Sun, 23 Nov 2025 00:03:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.22 15/25] qio: Add trace points to net_listener
Date: Sat, 22 Nov 2025 23:55:33 +0300
Message-ID: <20251122210344.48374-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
References: <qemu-stable-7.2.22-20251122235450@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eric Blake <eblake@redhat.com>

Upcoming patches will adjust how net_listener watches for new client
connections; adding trace points now makes it easier to debug that the
changes work as intended.  For example, adding
--trace='qio_net_listener*' to the qemu-storage-daemon command line
before --nbd-server will track when the server first starts listening
for clients.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251113011625.878876-17-eblake@redhat.com>
(cherry picked from commit 59506e59e0f0a773e892104b945d0f15623381a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/net-listener.c b/io/net-listener.c
index 1c984d69c6..99c3ef0fdb 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -23,6 +23,7 @@
 #include "io/dns-resolver.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 QIONetListener *qio_net_listener_new(void)
 {
@@ -50,6 +51,7 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
         return TRUE;
     }
 
+    trace_qio_net_listener_callback(listener, listener->io_func);
     if (listener->io_func) {
         listener->io_func(listener, sioc, listener->io_data);
     }
@@ -125,6 +127,7 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;
 
+    trace_qio_net_listener_watch(listener, listener->io_func, "add");
     if (listener->io_func != NULL) {
         object_ref(OBJECT(listener));
         listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
@@ -145,6 +148,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;
 
+    trace_qio_net_listener_unwatch(listener, listener->io_func,
+                                   "set_client_func");
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -160,6 +165,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
         }
     }
 
+    trace_qio_net_listener_watch(listener, listener->io_func,
+                                 "set_client_func");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
@@ -220,6 +227,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;
 
+    trace_qio_net_listener_unwatch(listener, listener->io_func, "wait_client");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -249,6 +257,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
 
+    trace_qio_net_listener_watch(listener, listener->io_func, "wait_client");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
@@ -270,6 +279,7 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }
 
+    trace_qio_net_listener_unwatch(listener, listener->io_func, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
diff --git a/io/trace-events b/io/trace-events
index d4c0f84a9a..263a8b82bd 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -67,3 +67,8 @@ qio_channel_command_new_pid(void *ioc, int writefd, int readfd, int pid) "Comman
 qio_channel_command_new_spawn(void *ioc, const char *binary, int flags) "Command new spawn ioc=%p binary=%s flags=%d"
 qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"
+
+# net-listener.c
+qio_net_listener_watch(void *listener, void *func, const char *extra) "Net listener=%p watch enabled func=%p by %s"
+qio_net_listener_unwatch(void *listener, void *func, const char *extra) "Net listener=%p watch disabled func=%p by %s"
+qio_net_listener_callback(void *listener, void *func) "Net listener=%p callback forwarding to func=%p"
-- 
2.47.3


