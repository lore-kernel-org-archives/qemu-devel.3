Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50505CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVx0-0005KV-FU; Tue, 16 Sep 2025 09:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1uyVwx-0005Jd-13; Tue, 16 Sep 2025 09:42:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1uyVwp-0001Na-Gg; Tue, 16 Sep 2025 09:42:26 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cR34s6623z27jQy;
 Tue, 16 Sep 2025 21:43:09 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
 by mail.maildlp.com (Postfix) with ESMTPS id A943A1A0188;
 Tue, 16 Sep 2025 21:41:59 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 21:41:58 +0800
To: <qemu-devel@nongnu.org>
CC: <marcandre.lureau@redhat.com>, <berrange@redhat.com>,
 <alex.chen@huawei.com>, <chenjianfei3@huawei.com>, <eric.fangyi@huawei.com>,
 <luolongmin@huawei.com>, <mujinsheng@huawei.com>, <qemu-block@nongnu.org>,
 <qemu-stable@nongnu.org>, <renxuming@huawei.com>, <suxiaodong1@huawei.com>,
 <wangjian161@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <yangming73@huawei.com>, <zhuyangyang14@huawei.com>, <zoudongjie@huawei.com>
Subject: [PATCH] vnc: Fix memory leak during VNC tls authentication
Date: Tue, 16 Sep 2025 21:41:53 +0800
Message-ID: <20250916134153.974692-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200001.china.huawei.com (7.202.181.227)
Received-SPF: pass client-ip=45.249.212.32; envelope-from=zoudongjie@huawei.com;
 helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When qemu is performing a TLS handshake for VNC, it will monitor vs->sioc
in the qio_channel_tls_handshake_task. If the number of concurrent VNC
connections exceeds the maximum number allowed by qemu, vnc_connect will
traverse all connection requests in share mode VNC_SHARE_MODE_CONNECTING
and disconnect the first one.

If the disconnected request has not yet entered qio_channel_tls_handshake_io,
it will cause the data pointer allocated in qio_channel_tls_handshake_task
to leak directly, leading to an indirect leak of the task and its associated
pointers.

The connection count verification and disconnection logic in vnc_connect
comes from this commit:
https://github.com/qemu/qemu/commit/e5f34cdd2da54f28d90889a3afd15fad2d6105ff

Its description states that the purpose of this modification is to prohibit
new connections when the number of concurrent connections reaches the limit,
but the code actually disconnects other connections, which indirectly led
to this memory leak.

I tried removing the QTAILQ_FOREACH, disconnecting only the current connection
when the connection limit is reached. It seems that memory leaks will no longer
be triggered, but this introduces a new problem: if a VNC_SHARE_MODE_CONNECTING
state client disconnects abnormally, it will lead to a persistent residual
invalid connection. QEMU will no longer have the opportunity to release that
invalid connection afterwards. If such connections continue to accumulate, it
will prevent normal VNC clients from connecting to the QEMU virtual machine.

I attempted to extend QIOChannelTLS by saving the task and context directly into
the ioc, and processing them in qio_channel_tls_close to avoid leaks caused by
requesting new pointers. However, I am concerned that the related interfaces are
quite general and may introduce new issues. Therefore, I only implemented special
handling for the VNC TLS connection scenario, but I'm not sure if it will introduce
any hidden problems. Is there a more reasonable modification plan for this type
of problem scenario?

Reported by: jiangyegen@h-partners.com

Signed-off-by: zoudongjie <zoudongjie@huawei.com>
---
 include/io/channel-tls.h |  3 ++
 include/io/task.h        |  8 ++++
 io/channel-tls.c         | 83 +++++++++++++++++++++++++++++++++++-----
 io/task.c                |  2 +-
 4 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 7e9023570d..fae7cd9a98 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -50,6 +50,9 @@ struct QIOChannelTLS {
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
     guint bye_ioc_tag;
+
+    QIOTask *hs_task;
+    GMainContext *hs_context;
 };
 
 /**
diff --git a/include/io/task.h b/include/io/task.h
index 0b5342ee84..213b69e60e 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -218,6 +218,14 @@ QIOTask *qio_task_new(Object *source,
                       gpointer opaque,
                       GDestroyNotify destroy);
 
+/**
+ * qio_task_free:
+ * @task: the task struct
+ *
+ * free the memory of the task.
+ */
+void qio_task_free(QIOTask *task);
+
 /**
  * qio_task_run_in_thread:
  * @task: the task struct
diff --git a/io/channel-tls.c b/io/channel-tls.c
index a8248a9216..76d77299b7 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -157,12 +157,25 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
                                              GIOCondition condition,
                                              gpointer user_data);
 
+static gboolean qio_channel_tls_handshake_io_vnc(QIOChannel *ioc,
+                                                 GIOCondition condition,
+                                                 gpointer user_data);
+
+static bool qio_channel_tls_for_vnc(QIOChannelTLS *ioc)
+{
+    if (!QIO_CHANNEL(ioc)->name) {
+        return false;
+    }
+    return (!strcmp(QIO_CHANNEL(ioc)->name, "vnc-server-tls"));
+}
+
 static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
                                            QIOTask *task,
                                            GMainContext *context)
 {
     Error *err = NULL;
     int status;
+    QIOChannelTLSData *data = NULL;
 
     status = qcrypto_tls_session_handshake(ioc->session, &err);
 
@@ -185,10 +198,15 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         qio_task_complete(task);
     } else {
         GIOCondition condition;
-        QIOChannelTLSData *data = g_new0(typeof(*data), 1);
 
-        data->task = task;
-        data->context = context;
+        if (qio_channel_tls_for_vnc(ioc)) {
+            ioc->hs_task = task;
+            ioc->hs_context = context;
+        } else {
+            data = g_new0(typeof(*data), 1);
+            data->task = task;
+            data->context = context;
+        }
 
         if (context) {
             g_main_context_ref(context);
@@ -201,13 +219,23 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         }
 
         trace_qio_channel_tls_handshake_pending(ioc, status);
-        ioc->hs_ioc_tag =
-            qio_channel_add_watch_full(ioc->master,
-                                       condition,
-                                       qio_channel_tls_handshake_io,
-                                       data,
-                                       NULL,
-                                       context);
+        if (data) {
+            ioc->hs_ioc_tag =
+                qio_channel_add_watch_full(ioc->master,
+                    condition,
+                    qio_channel_tls_handshake_io,
+                    data,
+                    NULL,
+                    context);
+        } else {
+            ioc->hs_ioc_tag =
+                qio_channel_add_watch_full(ioc->master,
+                    condition,
+                    qio_channel_tls_handshake_io_vnc,
+                    ioc,
+                    NULL,
+                    context);
+        }
     }
 }
 
@@ -233,6 +261,31 @@ static gboolean qio_channel_tls_handshake_io(QIOChannel *ioc,
     return FALSE;
 }
 
+static gboolean qio_channel_tls_handshake_io_vnc(QIOChannel *ioc,
+                                                 GIOCondition condition,
+                                                 gpointer user_data)
+{
+    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(user_data);
+
+    if (!tioc || tioc->hs_task == NULL) {
+        return FALSE;
+    }
+
+    QIOTask *task = tioc->hs_task;
+    GMainContext *context = tioc->hs_context;
+
+    tioc->hs_ioc_tag = 0;
+    tioc->hs_task = NULL;
+    tioc->hs_context = NULL;
+    qio_channel_tls_handshake_task(tioc, task, context);
+
+    if (context) {
+        g_main_context_unref(context);
+    }
+
+    return FALSE;
+}
+
 void qio_channel_tls_handshake(QIOChannelTLS *ioc,
                                QIOTaskFunc func,
                                gpointer opaque,
@@ -470,6 +523,16 @@ static int qio_channel_tls_close(QIOChannel *ioc,
         g_clear_handle_id(&tioc->bye_ioc_tag, g_source_remove);
     }
 
+    if (tioc->hs_context) {
+        g_main_context_unref(tioc->hs_context);
+        tioc->hs_context = NULL;
+    }
+
+    if (tioc->hs_task) {
+        qio_task_free(tioc->hs_task);
+        tioc->hs_task = NULL;
+    }
+
     return qio_channel_close(tioc->master, errp);
 }
 
diff --git a/io/task.c b/io/task.c
index 451f26f8b4..561a373590 100644
--- a/io/task.c
+++ b/io/task.c
@@ -70,7 +70,7 @@ QIOTask *qio_task_new(Object *source,
     return task;
 }
 
-static void qio_task_free(QIOTask *task)
+void qio_task_free(QIOTask *task)
 {
     qemu_mutex_lock(&task->thread_lock);
     if (task->thread) {
-- 
2.33.0


