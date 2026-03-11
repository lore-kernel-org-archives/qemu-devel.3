Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2051112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNT-0004XH-If; Wed, 11 Mar 2026 15:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNR-0004Va-K7; Wed, 11 Mar 2026 15:37:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNP-0000Ue-Qg; Wed, 11 Mar 2026 15:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=UieJ/jT2rH8oFQdAVtltbswdEUQ7QiFpJvjfuHuSucg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u2hotqksFuHHKGknHOuUWEeoN0i35q2KXhB5sUAzEPwi/Ld28Y8PYATGCpiDV1IJW
 SaKL+aADuVG0I1b9+u3kbhcLYZry/k0ErnpdJ1Y6C6pov9mfPLoYPlm6eSp0d4SRc7
 sOK1X+m7DdlWl+RaByNixvcIOjPxohjO0paxCjeUJtESGiScGGV5rb17jbWBBrolJj
 Z5M19zxsmTP5gOCwiG4hxa9fgOr0OEWRhQF+oYcP/oWS+BhwNU93OFzlJ+Xgz4ej+9
 BnxjG7HfJuhvk7hxqB0M3ojopf5odgVZS3QeY2cQSBdfYH9lB4W9b7wfv6Dc4HIzwd
 d0/y2cQzN2wHg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD163192109;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0CD8A37C46E;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 33/53] io: fix cleanup for websock I/O source data on
 cancellation
Date: Wed, 11 Mar 2026 22:34:26 +0300
Message-ID: <20260311193449.1096110-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
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

The websock code will create a GSource for tracking completion of the
handshake process, passing a QIOTask which is freed by the callback
when it completes, which means when a source is cancelled, nothing is
free'ing the task.

Switch to provide a data free callback to the GSource, which ensures
the QIOTask is always freed even when the main event callback never
fires.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 9545c059f77e3f814fcbaba83203572ea655c50e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/io/channel-websock.c b/io/channel-websock.c
index b4f96a0af4..bb10bc4f7f 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -526,11 +526,32 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
     return 1;
 }
 
+typedef struct QIOChannelWebsockData {
+    QIOTask *task;
+} QIOChannelWebsockData;
+
+static void qio_channel_websock_data_free(gpointer user_data)
+{
+    QIOChannelWebsockData *data = user_data;
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
+    g_free(data);
+}
+
 static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
                                                    GIOCondition condition,
                                                    gpointer user_data)
 {
-    QIOTask *task = user_data;
+    QIOChannelWebsockData *data = user_data;
+    QIOTask *task = data->task;
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(
         qio_task_get_source(task));
     Error *err = NULL;
@@ -545,7 +566,6 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -562,7 +582,6 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
             trace_qio_channel_websock_handshake_complete(ioc);
             qio_task_complete(task);
         }
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -574,7 +593,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
                                                  GIOCondition condition,
                                                  gpointer user_data)
 {
-    QIOTask *task = user_data;
+    QIOChannelWebsockData *data = user_data, *newdata = NULL;
+    QIOTask *task = data->task;
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(
         qio_task_get_source(task));
     Error *err = NULL;
@@ -590,7 +610,6 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -603,12 +622,14 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
     error_propagate(&wioc->io_err, err);
 
     trace_qio_channel_websock_handshake_reply(ioc);
+    newdata = g_new0(QIOChannelWebsockData, 1);
+    newdata->task = g_steal_pointer(&data->task);
     wioc->hs_io_tag = qio_channel_add_watch(
         wioc->master,
         G_IO_OUT,
         qio_channel_websock_handshake_send,
-        task,
-        NULL);
+        newdata,
+        qio_channel_websock_data_free);
     return FALSE;
 }
 
@@ -904,12 +925,12 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
                                    gpointer opaque,
                                    GDestroyNotify destroy)
 {
-    QIOTask *task;
+    QIOChannelWebsockData *data = g_new0(QIOChannelWebsockData, 1);
 
-    task = qio_task_new(OBJECT(ioc),
-                        func,
-                        opaque,
-                        destroy);
+    data->task = qio_task_new(OBJECT(ioc),
+                              func,
+                              opaque,
+                              destroy);
 
     trace_qio_channel_websock_handshake_start(ioc);
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
@@ -917,8 +938,8 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
         ioc->master,
         G_IO_IN,
         qio_channel_websock_handshake_io,
-        task,
-        NULL);
+        data,
+        qio_channel_websock_data_free);
 }
 
 
-- 
2.47.3


