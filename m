Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BEEB363E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKJ-0006SE-V3; Tue, 03 Mar 2026 10:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKI-0006Ri-GU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKG-000237-TU
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgYJTTA7n6lwKY5yKJ5rJETpb7L/l65/rCrUKeRfMlE=;
 b=KtnF1WexRma7YcJVWvWeHKLcXN7ks7734NX6A2XIqA174WBq80/XNyadwTxV5PNTcQoreb
 ndhw7rtZIveV/HipF6MA8Z0fxX+vttfs1YbEdthQ8K64p8N/h2t9btNGYg6d/iZP2yhlZZ
 ZDsTsdKBdI9uQ5totd6++9nqzc3rZdY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-sZ3-ClYZPbe-VbiLkpv_zw-1; Tue,
 03 Mar 2026 10:06:16 -0500
X-MC-Unique: sZ3-ClYZPbe-VbiLkpv_zw-1
X-Mimecast-MFC-AGG-ID: sZ3-ClYZPbe-VbiLkpv_zw_1772550375
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D39EA19560A1
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 15:06:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A5A61800348; Tue,  3 Mar 2026 15:06:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/27] io: fix cleanup for TLS I/O source data on cancellation
Date: Tue,  3 Mar 2026 15:05:40 +0000
Message-ID: <20260303150604.2402872-4-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The TLS code will create a GSource for tracking completion of the
handshake process, passing a QIOChannelTLSData struct that contains
various data items. The data struct is freed by the callback when
it completes, which means when a source is cancelled, nothing is
free'ing the data struct or its contents.

Switch to provide a data free callback to the GSource, which ensures
the QIOChannelTLSData struct is always freed even when the main event
callback never fires.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-tls.c | 64 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 07274c12df..8b70e95a4b 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -153,13 +153,32 @@ struct QIOChannelTLSData {
 };
 typedef struct QIOChannelTLSData QIOChannelTLSData;
 
+static void qio_channel_tls_io_data_free(gpointer user_data)
+{
+    QIOChannelTLSData *data = user_data;
+    /*
+     * Usually 'task' will be NULL since the GSource
+     * callback will either complete the task or pass
+     * it on to a new GSource. We'll see a non-NULL
+     * task here only if the GSource was released before
+     * its callback triggers
+     */
+    if (data->task) {
+        qio_task_free(data->task);
+    }
+    if (data->context) {
+        g_main_context_unref(data->context);
+    }
+    g_free(data);
+}
+
 static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer user_data);
 
-static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
-                                           QIOTask *task,
-                                           GMainContext *context)
+static gboolean qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
+                                               QIOTask *task,
+                                               GMainContext *context)
 {
     Error *err = NULL;
     int status;
@@ -170,8 +189,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         trace_qio_channel_tls_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
-        return;
+        return TRUE;
     }
 
     if (status == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
@@ -184,7 +202,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
             trace_qio_channel_tls_credentials_allow(ioc);
         }
         qio_task_complete(task);
-        qio_task_free(task);
+        return TRUE;
     } else {
         GIOCondition condition;
         QIOChannelTLSData *data = g_new0(typeof(*data), 1);
@@ -208,8 +226,9 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
                                        condition,
                                        qio_channel_tls_handshake_io,
                                        data,
-                                       NULL,
+                                       qio_channel_tls_io_data_free,
                                        context);
+        return FALSE;
     }
 }
 
@@ -225,11 +244,9 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
         qio_task_get_source(task));
 
     tioc->hs_ioc_tag = 0;
-    g_free(data);
-    qio_channel_tls_handshake_task(tioc, task, context);
-
-    if (context) {
-        g_main_context_unref(context);
+    if (!qio_channel_tls_handshake_task(tioc, task, context)) {
+        /* task is kept by new GSource so must not be released yet */
+        data->task = NULL;
     }
 
     return FALSE;
@@ -258,8 +275,8 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
 static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
                                        gpointer user_data);
 
-static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
-                                     GMainContext *context)
+static gboolean qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
+                                         GMainContext *context)
 {
     GIOCondition condition;
     QIOChannelTLSData *data;
@@ -272,14 +289,12 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
         trace_qio_channel_tls_bye_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
-        return;
+        return TRUE;
     }
 
     if (status == QCRYPTO_TLS_BYE_COMPLETE) {
         qio_task_complete(task);
-        qio_task_free(task);
-        return;
+        return TRUE;
     }
 
     data = g_new0(typeof(*data), 1);
@@ -299,7 +314,10 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
     trace_qio_channel_tls_bye_pending(ioc, status);
     ioc->bye_ioc_tag = qio_channel_add_watch_full(ioc->master, condition,
                                                   qio_channel_tls_bye_io,
-                                                  data, NULL, context);
+                                                  data,
+                                                  qio_channel_tls_io_data_free,
+                                                  context);
+    return FALSE;
 }
 
 
@@ -312,11 +330,9 @@ static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(qio_task_get_source(task));
 
     tioc->bye_ioc_tag = 0;
-    g_free(data);
-    qio_channel_tls_bye_task(tioc, task, context);
-
-    if (context) {
-        g_main_context_unref(context);
+    if (!qio_channel_tls_bye_task(tioc, task, context)) {
+        /* task is kept by new GSource so must not be released yet */
+        data->task = NULL;
     }
 
     return FALSE;
-- 
2.53.0


