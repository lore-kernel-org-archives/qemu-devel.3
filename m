Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83F2CD4F37
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJLx6-0002Zs-8G; Wed, 12 Nov 2025 20:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLx3-0002We-EN
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vJLx1-0005mJ-MC
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762996599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpRI1c6EDNJpHpfEbBOT8rOD4oEtGvZ19PXT0RXLvSo=;
 b=VFXKiwehOMDX5pUIZk1ZqYe1cFwH7R0DvnipZ8d4PYS/fBdnTFlRd4s9uHhm23T3AKHQaq
 eMSXvo78VKkU3pmPsiYyW50XC9qtB27CUCkLSvpdnBVtJDn/2FF5kN/pqIWl8K9Izb/nFx
 NONl23XN5TC/7n19en+IlujlhCXEPF4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-wa8H2oZ9Oyef6qGFrjZ7Yw-1; Wed,
 12 Nov 2025 20:16:36 -0500
X-MC-Unique: wa8H2oZ9Oyef6qGFrjZ7Yw-1
X-Mimecast-MFC-AGG-ID: wa8H2oZ9Oyef6qGFrjZ7Yw_1762996595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3951956080; Thu, 13 Nov 2025 01:16:35 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 056CE18002B6; Thu, 13 Nov 2025 01:16:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.com,
	berrange@redhat.com
Subject: [PATCH v3 02/13] qio: Add trace points to net_listener
Date: Wed, 12 Nov 2025 19:11:27 -0600
Message-ID: <20251113011625.878876-17-eblake@redhat.com>
In-Reply-To: <20251113011625.878876-15-eblake@redhat.com>
References: <20251113011625.878876-15-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

Upcoming patches will adjust how net_listener watches for new client
connections; adding trace points now makes it easier to debug that the
changes work as intended.  For example, adding
--trace='qio_net_listener*' to the qemu-storage-daemon command line
before --nbd-server will track when the server first starts listening
for clients.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v2: Make tracepoints unconditional, rename to match later refactoring
patch, document io_func in unwatch
---
 io/net-listener.c | 10 ++++++++++
 io/trace-events   |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 47405965a66..007acbd5b18 100644
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
@@ -123,6 +125,7 @@ void qio_net_listener_add(QIONetListener *listener,
     object_ref(OBJECT(sioc));
     listener->connected = true;

+    trace_qio_net_listener_watch(listener, listener->io_func, "add");
     if (listener->io_func != NULL) {
         object_ref(OBJECT(listener));
         listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
@@ -143,6 +146,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;

+    trace_qio_net_listener_unwatch(listener, listener->io_func,
+                                   "set_client_func");
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -158,6 +163,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
         }
     }

+    trace_qio_net_listener_watch(listener, listener->io_func,
+                                 "set_client_func");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
@@ -218,6 +225,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;

+    trace_qio_net_listener_unwatch(listener, listener->io_func, "wait_client");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -247,6 +255,7 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);

+    trace_qio_net_listener_watch(listener, listener->io_func, "wait_client");
     if (listener->io_func != NULL) {
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
@@ -268,6 +277,7 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }

+    trace_qio_net_listener_unwatch(listener, listener->io_func, "disconnect");
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
diff --git a/io/trace-events b/io/trace-events
index dc3a63ba1fb..10976eca5fe 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -72,3 +72,8 @@ qio_channel_command_new_pid(void *ioc, int writefd, int readfd, int pid) "Comman
 qio_channel_command_new_spawn(void *ioc, const char *binary, int flags) "Command new spawn ioc=%p binary=%s flags=%d"
 qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"
+
+# net-listener.c
+qio_net_listener_watch(void *listener, void *func, const char *extra) "Net listener=%p watch enabled func=%p by %s"
+qio_net_listener_unwatch(void *listener, void *func, const char *extra) "Net listener=%p watch disabled func=%p by %s"
+qio_net_listener_callback(void *listener, void *func) "Net listener=%p callback forwarding to func=%p"
-- 
2.51.1


