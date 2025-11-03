Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30461CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 20:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1B5-0003tY-Ju; Mon, 03 Nov 2025 15:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1As-0003gi-BU
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vG1Ak-0007e0-5L
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 15:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762201738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sKETWfJjHc4CXcUbADX9wTUC00+MGTXyf9La3ddVEY=;
 b=gRhyk4OH+RH4rhBsc+jeW5y9sXugwzSzz3FUWQodNmRAAgxSYkgMl2aDNsSumWBjQXMgcB
 RSx9IxXVnANIWehTXpeOaG5rBCrLH1lSi5v2zHL9NgxkPzUhAsEMTPn/dXKATze61Mkq+Y
 KRCaTYcKzHdI/IaGPqPgsdvFrDGpO4Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-g6zC2akXNiKPQ2F4Z54xrA-1; Mon,
 03 Nov 2025 15:28:57 -0500
X-MC-Unique: g6zC2akXNiKPQ2F4Z54xrA-1
X-Mimecast-MFC-AGG-ID: g6zC2akXNiKPQ2F4Z54xrA_1762201736
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78D871956063; Mon,  3 Nov 2025 20:28:56 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.131])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6224030001A1; Mon,  3 Nov 2025 20:28:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	berrange@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 1/8] qio: Add trace points to net_listener
Date: Mon,  3 Nov 2025 14:10:52 -0600
Message-ID: <20251103202849.3687643-11-eblake@redhat.com>
In-Reply-To: <20251103202849.3687643-10-eblake@redhat.com>
References: <20251103202849.3687643-10-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 io/net-listener.c | 17 +++++++++++++++++
 io/trace-events   |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 47405965a66..0adbc409cf2 100644
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
@@ -124,6 +126,8 @@ void qio_net_listener_add(QIONetListener *listener,
     listener->connected = true;

     if (listener->io_func != NULL) {
+        trace_qio_net_listener_watch_enabled(listener, listener->io_func,
+                                             "add");
         object_ref(OBJECT(listener));
         listener->io_source[listener->nsioc] = qio_channel_add_watch_source(
             QIO_CHANNEL(listener->sioc[listener->nsioc]), G_IO_IN,
@@ -143,6 +147,9 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;

+    if (listener->io_func) {
+        trace_qio_net_listener_watch_disabled(listener, "set_client_func");
+    }
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -159,6 +166,8 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
     }

     if (listener->io_func != NULL) {
+        trace_qio_net_listener_watch_enabled(listener, listener->io_func,
+                                             "set_client_func");
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
             listener->io_source[i] = qio_channel_add_watch_source(
@@ -218,6 +227,9 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     };
     size_t i;

+    if (listener->io_func) {
+        trace_qio_net_listener_watch_disabled(listener, "wait_client");
+    }
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
@@ -248,6 +260,8 @@ QIOChannelSocket *qio_net_listener_wait_client(QIONetListener *listener)
     g_main_context_unref(ctxt);

     if (listener->io_func != NULL) {
+        trace_qio_net_listener_watch_enabled(listener, listener->io_func,
+                                             "wait_client");
         for (i = 0; i < listener->nsioc; i++) {
             object_ref(OBJECT(listener));
             listener->io_source[i] = qio_channel_add_watch_source(
@@ -268,6 +282,9 @@ void qio_net_listener_disconnect(QIONetListener *listener)
         return;
     }

+    if (listener->io_func) {
+        trace_qio_net_listener_watch_disabled(listener, "disconnect");
+    }
     for (i = 0; i < listener->nsioc; i++) {
         if (listener->io_source[i]) {
             g_source_destroy(listener->io_source[i]);
diff --git a/io/trace-events b/io/trace-events
index dc3a63ba1fb..8cc4cae3a5d 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -72,3 +72,8 @@ qio_channel_command_new_pid(void *ioc, int writefd, int readfd, int pid) "Comman
 qio_channel_command_new_spawn(void *ioc, const char *binary, int flags) "Command new spawn ioc=%p binary=%s flags=%d"
 qio_channel_command_abort(void *ioc, int pid) "Command abort ioc=%p pid=%d"
 qio_channel_command_wait(void *ioc, int pid, int ret, int status) "Command abort ioc=%p pid=%d ret=%d status=%d"
+
+# net-listener.c
+qio_net_listener_watch_enabled(void *listener, void *func, const char *extra) "Net listener=%p watch enabled func=%p by %s"
+qio_net_listener_watch_disabled(void *listener, const char *extra) "Net listener=%p watch disabled by %s"
+qio_net_listener_callback(void *listener, void *func) "Net listener=%p callback forwarding to func=%p"
-- 
2.51.1


