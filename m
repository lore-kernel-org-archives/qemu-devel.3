Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278EB112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PNQ-0004Rd-07; Wed, 11 Mar 2026 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNO-0004Jj-BH; Wed, 11 Mar 2026 15:37:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PNM-0000Qu-8Z; Wed, 11 Mar 2026 15:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=Kuiy3URY4TNTc3h601eE7YSgbxD72vo5uTPcTKrTHaw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ebPXC0OKblK8YWXzPJOYarZ4/mgZNH4qW1SWC921VTJWceIkzsyZGlLmRz1J0cz4R
 E8z6JBrMgU5ATse77kfpvVo0Wj0tJTyjGA3xEqysdUspmiP0FOuVU5zoWFSEVI35iJ
 Lg3yrG2mUPKLQRkSysZKKJOT78GnsyqXPQTuLuQAQvsACaX5tsW+blshdY253VCOPv
 0PP+VsMuYYlJs/75F0zJSd6xpCeB7Tou0dzb5FwwUQD2XDKiH//BSTHWWd52aVjB4Q
 +SCQ1lcZJVk8DPUnIm1B3OyxIXAl6tvYBm8KzJYFaomGDJWn4AOth01k1vHPiG/2YG
 6hTKyv9dDjfog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E5B8192107;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E12FF37C46C;
 Wed, 11 Mar 2026 22:35:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 31/53] io: separate freeing of tasks from marking them
 as complete
Date: Wed, 11 Mar 2026 22:34:24 +0300
Message-ID: <20260311193449.1096110-31-mjt@tls.msk.ru>
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

The original design of QIOTask was intended to simplify lifecycle
management by automatically freeing it when the task was marked as
complete. This overlooked the fact that when a QIOTask is used in
combination with a GSource, there may be times when the source
callback is never invoked. This is typically when a GSource is
released before any I/O event arrives. In such cases it is not
desirable to mark a QIOTask as complete, but it still needs to be
freed. To satisfy this, the task must be released manually.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 163cd0ae1182e67509b271f244a73dfd938337b9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/io/task.h b/include/io/task.h
index 0b5342ee84..98847f5994 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -96,7 +96,7 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  *                         1000,
  *                         myobject_operation_timer,
  *                         task,
- *                         NULL);
+ *                         qio_task_free);
  *    }
  *   </programlisting>
  * </example>
@@ -138,9 +138,8 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  * the callback func 'myobject_operation_notify' shown
  * earlier to deal with the results.
  *
- * Once this function returns false, object_unref will be called
- * automatically on the task causing it to be released and the
- * ref on QMyObject dropped too.
+ * Once this function returns FALSE, the task will be freed,
+ * causing it release the ref on QMyObject too.
  *
  * The QIOTask module can also be used to perform operations
  * in a background thread context, while still reporting the
@@ -208,8 +207,8 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
  * 'err' attribute in the task object to determine if
  * the operation was successful or not.
  *
- * The returned task will be released when qio_task_complete()
- * is invoked.
+ * The returned task must be released by calling
+ * qio_task_free() when no longer required.
  *
  * Returns: the task struct
  */
@@ -218,6 +217,19 @@ QIOTask *qio_task_new(Object *source,
                       gpointer opaque,
                       GDestroyNotify destroy);
 
+/**
+ * qio_task_free:
+ * task: the task object to free
+ *
+ * Free the resources associated with the task. Typically
+ * the qio_task_complete() method will be called immediately
+ * before this to trigger the task callback, however, it is
+ * permissible to free the task in the case of cancellation.
+ * The destroy callback will be used to release the opaque
+ * data provided to qio_task_new().
+ */
+void qio_task_free(QIOTask *task);
+
 /**
  * qio_task_run_in_thread:
  * @task: the task struct
@@ -268,8 +280,9 @@ void qio_task_wait_thread(QIOTask *task);
  * qio_task_complete:
  * @task: the task struct
  *
- * Invoke the completion callback for @task and
- * then free its memory.
+ * Invoke the completion callback for @task. This should typically
+ * only be invoked once on a task, and then qio_task_free() used
+ * to free it.
  */
 void qio_task_complete(QIOTask *task);
 
diff --git a/io/channel-tls.c b/io/channel-tls.c
index b0cec27cb9..07274c12df 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -170,6 +170,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
         trace_qio_channel_tls_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        qio_task_free(task);
         return;
     }
 
@@ -183,6 +184,7 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
             trace_qio_channel_tls_credentials_allow(ioc);
         }
         qio_task_complete(task);
+        qio_task_free(task);
     } else {
         GIOCondition condition;
         QIOChannelTLSData *data = g_new0(typeof(*data), 1);
@@ -270,11 +272,13 @@ static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
         trace_qio_channel_tls_bye_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        qio_task_free(task);
         return;
     }
 
     if (status == QCRYPTO_TLS_BYE_COMPLETE) {
         qio_task_complete(task);
+        qio_task_free(task);
         return;
     }
 
diff --git a/io/channel-websock.c b/io/channel-websock.c
index cb4dafdebb..b4f96a0af4 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -545,6 +545,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -561,6 +562,7 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
             trace_qio_channel_websock_handshake_complete(ioc);
             qio_task_complete(task);
         }
+        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -588,6 +590,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
+        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
diff --git a/io/task.c b/io/task.c
index 451f26f8b4..331febd4e1 100644
--- a/io/task.c
+++ b/io/task.c
@@ -70,8 +70,12 @@ QIOTask *qio_task_new(Object *source,
     return task;
 }
 
-static void qio_task_free(QIOTask *task)
+void qio_task_free(QIOTask *task)
 {
+    if (!task) {
+        return;
+    }
+
     qemu_mutex_lock(&task->thread_lock);
     if (task->thread) {
         if (task->thread->destroy) {
@@ -110,6 +114,7 @@ static gboolean qio_task_thread_result(gpointer opaque)
 
     trace_qio_task_thread_result(task);
     qio_task_complete(task);
+    qio_task_free(task);
 
     return FALSE;
 }
@@ -196,7 +201,6 @@ void qio_task_complete(QIOTask *task)
 {
     task->func(task, task->opaque);
     trace_qio_task_complete(task);
-    qio_task_free(task);
 }
 
 
diff --git a/tests/unit/test-io-task.c b/tests/unit/test-io-task.c
index 115dba8970..b1c8ecb7ab 100644
--- a/tests/unit/test-io-task.c
+++ b/tests/unit/test-io-task.c
@@ -73,6 +73,7 @@ static void test_task_complete(void)
     src = qio_task_get_source(task);
 
     qio_task_complete(task);
+    qio_task_free(task);
 
     g_assert(obj == src);
 
@@ -84,6 +85,28 @@ static void test_task_complete(void)
 }
 
 
+static void test_task_cancel(void)
+{
+    QIOTask *task;
+    Object *obj = object_new(TYPE_DUMMY);
+    Object *src;
+    struct TestTaskData data = { NULL, NULL, false };
+
+    task = qio_task_new(obj, task_callback, &data, NULL);
+    src = qio_task_get_source(task);
+
+    qio_task_free(task);
+
+    g_assert(obj == src);
+
+    object_unref(obj);
+
+    g_assert(data.source == NULL);
+    g_assert(data.err == NULL);
+    g_assert(data.freed == false);
+}
+
+
 static void task_data_free(gpointer opaque)
 {
     struct TestTaskData *data = opaque;
@@ -101,6 +124,7 @@ static void test_task_data_free(void)
     task = qio_task_new(obj, task_callback, &data, task_data_free);
 
     qio_task_complete(task);
+    qio_task_free(task);
 
     object_unref(obj);
 
@@ -123,6 +147,7 @@ static void test_task_failure(void)
 
     qio_task_set_error(task, err);
     qio_task_complete(task);
+    qio_task_free(task);
 
     object_unref(obj);
 
@@ -260,6 +285,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&dummy_info);
     g_test_add_func("/crypto/task/complete", test_task_complete);
+    g_test_add_func("/crypto/task/cancel", test_task_cancel);
     g_test_add_func("/crypto/task/datafree", test_task_data_free);
     g_test_add_func("/crypto/task/failure", test_task_failure);
     g_test_add_func("/crypto/task/thread_complete", test_task_thread_complete);
-- 
2.47.3


