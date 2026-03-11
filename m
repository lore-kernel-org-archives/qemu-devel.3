Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0BD112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LD7-0003Xy-64; Wed, 11 Mar 2026 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBl-0001JM-PU; Wed, 11 Mar 2026 11:09:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LBj-0005lW-NL; Wed, 11 Mar 2026 11:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241483; bh=CYzXWLGQoPXvgockatRsrujnVIM9hpdoLe9ML5C28m0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qd25xpnejlajLhxFTaR5+KcQr07MekyJxH/+6OHuZzlxuB9g87VvRMmF5mPLL3mSR
 PgIBw1ZpB+MsgMklJROS3/bCYT8PB7kS9qVF8dgMN0HDTJP4Kn/n4YcO9J1BQwvARq
 g6rhExcrq5obGigfHnip+bEAXlOABfJjYR+1W5RNRIdIR4cYAbITsZYXQDSXoqX7zO
 hgQYGQFMYhzelP9AyBJ+EcP5buuCfc5tDyv3RPIfhxNn4fHO9G2WBzscKbocJw7hlJ
 aPZ5TLLhN5BEe8w7EAa1JXhk9AVhTmEE1G+Y3Evj4qkcP3nwI5SwzoeYhkCV7Otg3j
 f+nONhxpc58vQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 165C7191EA0;
 Wed, 11 Mar 2026 18:04:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0491037C2E1;
 Wed, 11 Mar 2026 18:05:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 29/46] io: fix cleanup for TLS I/O source data on
 cancellation
Date: Wed, 11 Mar 2026 18:03:05 +0300
Message-ID: <20260311150327.1084669-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
(cherry picked from commit d39d0f3acdd7c1bb275db7e97b511f98254ecd9f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-tls.c b/io/channel-tls.c
index ce4ee6bb98..a686ee2058 100644
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
@@ -252,14 +269,16 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                         func, opaque, destroy);
 
     trace_qio_channel_tls_handshake_start(ioc);
-    qio_channel_tls_handshake_task(ioc, task, context);
+    if (qio_channel_tls_handshake_task(ioc, task, context)) {
+        qio_task_free(task);
+    }
 }
 
 static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
                                        gpointer user_data);
 
-static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
-                                     GMainContext *context)
+static gboolean qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
+                                         GMainContext *context)
 {
     GIOCondition condition;
     QIOChannelTLSData *data;
@@ -272,14 +291,12 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
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
@@ -299,7 +316,10 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
     trace_qio_channel_tls_bye_pending(ioc, status);
     ioc->bye_ioc_tag = qio_channel_add_watch_full(ioc->master, condition,
                                                   qio_channel_tls_bye_io,
-                                                  data, NULL, context);
+                                                  data,
+                                                  qio_channel_tls_io_data_free,
+                                                  context);
+    return FALSE;
 }
 
 
@@ -312,11 +332,9 @@ static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
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
2.47.3


