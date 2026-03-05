Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06165F47CA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCoY-0002I3-8g; Thu, 05 Mar 2026 12:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCo5-000231-PR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCo3-00028M-PO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXAIQNZS/pqtB1qCR+7+99G/XLOIU4CQgEazJnNGEso=;
 b=HoBoCdTSvTcqSxlaN2Ezykh6YiWP6doEHtKtODFYuoc5uMSka/cTmLT2kK8u4dcAE5yW3D
 P84ZP/3zhMtEgRF0wyvQzq506s+OB7YXxgUtm/TJ7HyQq7Z35IrSXKQQGUq5F8a+XPpB2e
 E1vs0oGTJf60GocedBopganj7PZNtJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-M0PJpy_oMpyu5aFR4gbQkw-1; Thu,
 05 Mar 2026 12:48:11 -0500
X-MC-Unique: M0PJpy_oMpyu5aFR4gbQkw-1
X-Mimecast-MFC-AGG-ID: M0PJpy_oMpyu5aFR4gbQkw_1772732889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FF551956063; Thu,  5 Mar 2026 17:48:09 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 717A91955D71; Thu,  5 Mar 2026 17:48:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL 03/27] io: fix cleanup for TLS I/O source data on cancellation
Date: Thu,  5 Mar 2026 17:47:19 +0000
Message-ID: <20260305174743.3084606-4-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 io/channel-tls.c | 68 ++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/io/channel-tls.c b/io/channel-tls.c
index 07274c12df..940fc3c6d1 100644
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
2.53.0


