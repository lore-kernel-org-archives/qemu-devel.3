Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B019CCFA13
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0I-0005cd-8b; Sat, 08 Nov 2025 18:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs07-0005Ov-Iy
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs05-0001fG-JJ
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpXc3S2Q3NrPCkGXSUoupnhbTvu0TcNTPyx71+k/Gxw=;
 b=grL3H4VdfvZocareeZJQeXy3kBr058YEmB1PWr+ouiKBNeGm1SS2a01dPTCyho2oGygYhe
 cugEnGOiyTXbjCRL1BBZH7MNmVrkCMDjb3MKjdn+gWpqekutzk73JyEQs7IUjeKT9o3NmJ
 uy1jzg7a/FaopKWUM1HHlTYZHIdYPDQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-FOCQtf0HPKKJ8mPuSzrzeQ-1; Sat,
 08 Nov 2025 18:05:39 -0500
X-MC-Unique: FOCQtf0HPKKJ8mPuSzrzeQ-1
X-Mimecast-MFC-AGG-ID: FOCQtf0HPKKJ8mPuSzrzeQ_1762643138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17385195605F; Sat,  8 Nov 2025 23:05:38 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCF2419560A7; Sat,  8 Nov 2025 23:05:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH v2 04/12] qio: Remember context of
 qio_net_listener_set_client_func_full
Date: Sat,  8 Nov 2025 16:59:25 -0600
Message-ID: <20251108230525.3169174-18-eblake@redhat.com>
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

io/net-listener.c has two modes of use: asynchronous (the user calls
qio_net_listener_set_client_func to wake up the callback via the
global GMainContext, or qio_net_listener_set_client_func_full to wake
up the callback via the caller's own alternative GMainContext), and
synchronous (the user calls qio_net_listener_wait_client which creates
its own GMainContext and waits for the first client connection before
returning, with no need for a user's callback).  But commit 938c8b79
has a latent logic flaw: when qio_net_listener_wait_client finishes on
its temporary context, it reverts all of the siocs back to the global
GMainContext rather than the potentially non-NULL context they might
have been originally registered with.  Similarly, if the user creates
a net-listener, adds initial addresses, registers an async callback
with a non-default context (which ties to all siocs for the initial
addresses), then adds more addresses with qio_net_listener_add, the
siocs for later addresses are blindly placed in the global context,
rather than sharing the context of the earlier ones.

In practice, I don't think this has caused issues.  As pointed out by
the original commit, all async callers prior to that commit were
already okay with the NULL default context; and the typical usage
pattern is to first add ALL the addresses the listener will pay
attention to before ever setting the async callback.  Likewise, if a
file uses only qio_net_listener_set_client_func instead of
qio_net_listener_set_client_func_full, then it is never using a custom
context, so later assignments of async callbacks will still be to the
same global context as earlier ones.  Meanwhile, any callers that want
to do the sync operation to grab the first client are unlikely to
register an async callback; altogether bypassing the question of
whether later assignments of a GSource are being tied to a different
context over time.

I do note that chardev/char-socket.c is the only file that calls both
qio_net_listener_wait_client (sync for a single client in
tcp_chr_accept_server_sync), and qio_net_listener_set_client_func_full
(several places, all with chr->gcontext, but sometimes with a NULL
callback function during teardown).  But as far as I can tell, the two
uses are mutually exclusive, based on the is_waitconnect parameter to
qmp_chardev_open_socket_server.

That said, it is more robust to remember when an async callback
function is tied to a non-default context, and have both the sync wait
and any late address additions honor that same context.  That way, the
code will be robust even if a later user performs a sync wait for a
specific client in the middle of servicing a longer-lived
QIONetListener that has an async callback for all other clients.

CC: qemu-stable@nongnu.org
Fixes: 938c8b79 ("qio: store gsources for net listeners", v2.12.0)
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: move earlier in series, trace context
---
 include/io/net-listener.h |  1 +
 io/net-listener.c         | 25 ++++++++++++++++---------
 io/trace-events           |  6 +++---
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/io/net-listener.h b/include/io/net-listener.h
index ab9f291ed62..42fbfab5467 100644
--- a/include/io/net-listener.h
+++ b/include/io/net-listener.h
@@ -50,6 +50,7 @@ struct QIONetListener {
     QIOChannelSocket **sioc;
     GSource **io_source;
     size_t nsioc;
+    GMainContext *context;

     bool connected;

diff --git a/io/net-listener.c b/io/net-listener.c
index d71b65270e0..0f16b78fbbd 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -51,7 +51,8 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
         return TRUE;
     }

-    trace_qio_net_listener_callback(listener, listener->io_func);
+    trace_qio_net_listener_callback(listener, listener->io_func,
+                                    listener->context);
     if (listener->io_func) {
         listener->io_func(listener, sioc, listener->io_data);
     }
@@ -125,13 +126,14 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;

-    trace_qio_net_listener_watch(listener, listener->io_func, "add");
+    trace_qio_net_listener_watch(listener, listener->io_func,
+                                 listener->context, "add");
     if (listener->io_func != NULL) {
         object_ref(OBJECT(listener));
         listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
             QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
             qio_net_listener_channel_func,
-            listener, (GDestroyNotify)object_unref, NULL);
+            listener, (GDestroyNotify)object_unref, listener->context);
     }

     listener->nsioc++;
@@ -147,7 +149,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     size_t i;

     trace_qio_net_listener_unwatch(listener, listener->io_func,
-                                   "set_client_func");
+                                   listener->context, "set_client_func");
+
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -162,9 +165,10 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     listener->io_func = func;
     listener->io_data = data;
     listener->io_notify = notify;
+    listener->context = context;

     trace_qio_net_listener_watch(listener, listener->io_func,
-                                 "set_client_func");
+                                 listener->context, "set_client_func");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
@@ -225,7 +229,8 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;

-    trace_qio_net_listener_unwatch(listener, listener->io_func, "wait_client");
+    trace_qio_net_listener_unwatch(listener, listener->io_func,
+                                   listener->context, "wait_client");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -255,14 +260,15 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);

-    trace_qio_net_listener_watch(listener, listener->io_func, "wait_client");
+    trace_qio_net_listener_watch(listener, listener->io_func,
+                                 listener->context, "wait_client");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
             listener->io_source[i] = qio_channel_add_watch_source(
                 QIO_CHANNEL(listener->sioc[i]), G_IO_IN,
                 qio_net_listener_channel_func,
-                listener, (GDestroyNotify)object_unref, NULL);
+                listener, (GDestroyNotify)object_unref, listener->context);
         }
     }

@@ -277,7 +283,8 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }

-    trace_qio_net_listener_unwatch(listener, listener->io_func, "disconnect");
+    trace_qio_net_listener_unwatch(listener, listener->io_func,
+                                   listener->context, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
diff --git a/io/trace-events b/io/trace-events
index 10976eca5fe..0cb77d579b6 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -74,6 +74,6 @@ qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"

 # net-listener.c
-qio_net_listener_watch(void *listener, void *func, const char *extra) "Net listener=%p watch enabled func=%p by %s"
-qio_net_listener_unwatch(void *listener, void *func, const char *extra) "Net listener=%p watch disabled func=%p by %s"
-qio_net_listener_callback(void *listener, void *func) "Net listener=%p callback forwarding to func=%p"
+qio_net_listener_watch(void *listener, void *func, void *ctx, const char *extra) "Net listener=%p watch enabled func=%p ctx=%p by %s"
+qio_net_listener_unwatch(void *listener, void *func, void *ctx, const char *extra) "Net listener=%p watch disabled func=%p ctx=%p by %s"
+qio_net_listener_callback(void *listener, void *func, void *ctx) "Net listener=%p callback forwarding to func=%p ctx=%p"
-- 
2.51.1


