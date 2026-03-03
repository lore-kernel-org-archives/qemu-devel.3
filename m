Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C35EDA680
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRKH-0006RQ-TR; Tue, 03 Mar 2026 10:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKG-0006Og-50
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxRKE-00022w-AY
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772550377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x5dOLupVL+hjV4GsiegMaAvA6L4zY0/YDT1LJKlaPI=;
 b=ijAL4c/uvnPS8kfsbhmYedX2fvX7dXByGGm/IPUWnuK/bknRMH0/fcwwqGBr+X7LBJv9Qw
 XwdksmUFCs8C/1pJ3Wp8l+y45q4vu7Cxw3aasnjg4O8AG8qbOnfH0nr764rJdbVbpguqgS
 rAN0ZDPBVY7qU3+QQJJ/Tyb1tyaqt/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-CbaMKYYAMSyw1z1EXn7YHA-1; Tue,
 03 Mar 2026 10:06:16 -0500
X-MC-Unique: CbaMKYYAMSyw1z1EXn7YHA-1
X-Mimecast-MFC-AGG-ID: CbaMKYYAMSyw1z1EXn7YHA_1772550375
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88599180AED6
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 15:06:15 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.185])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5610A1800348; Tue,  3 Mar 2026 15:06:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/27] io: fix cleanup for websock I/O source data on
 cancellation
Date: Tue,  3 Mar 2026 15:05:41 +0000
Message-ID: <20260303150604.2402872-5-berrange@redhat.com>
In-Reply-To: <20260303150604.2402872-1-berrange@redhat.com>
References: <20260303150604.2402872-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

The websock code will create a GSource for tracking completion of the
handshake process, passing a QIOTask which is freed by the callback
when it completes, which means when a source is cancelled, nothing is
free'ing the task.

Switch to provide a data free callback to the GSource, which ensures
the QIOTask is always freed even when the main event callback never
fires.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 49 +++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 100faba6b3..9902b014f7 100644
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
2.53.0


