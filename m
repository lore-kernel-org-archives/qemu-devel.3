Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EBEC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqp4-0001VD-Q2; Fri, 02 Feb 2024 05:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqp1-0001Cz-3V
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoy-00021A-M6
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVnRs6jVq1WYjkMyJMr1yedgY17NJRMJkVJ6DINU1rc=;
 b=bV5AhrejiM5ie6sA/AkxsXv5SvG1z7soLlzIGYTxg9wkZlXvJcKGT1+lG23Yj1bIHWnFuC
 UsMH8KqiMBblBqzOeLl0lWdS5aXvx0dvt7HjPv57byRRX77C2nDNMMrLUDWFCVaPQY16CN
 bI/BvIDxxPHFCO7jr5Hhro4yk37bNTw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-E-G0JIS-MyW-baiX_lViog-1; Fri,
 02 Feb 2024 05:30:54 -0500
X-MC-Unique: E-G0JIS-MyW-baiX_lViog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4480E3C0BE50;
 Fri,  2 Feb 2024 10:30:54 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 291D640C9444;
 Fri,  2 Feb 2024 10:30:49 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 19/23] migration/multifd: Cleanup multifd_save_cleanup()
Date: Fri,  2 Feb 2024 18:28:53 +0800
Message-ID: <20240202102857.110210-20-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Shrink the function by moving relevant works into helpers: move the thread
join()s into multifd_send_terminate_threads(), then create two more helpers
to cover channel/state cleanups.

Add a TODO entry for the thread terminate process because p->running is
still buggy.  We need to fix it at some point but not yet covered.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 91 +++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4ab8e6eff2..4cb0d2cc17 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -593,6 +593,11 @@ static void multifd_send_terminate_threads(void)
      * always set it.
      */
     qatomic_set(&multifd_send_state->exiting, 1);
+
+    /*
+     * Firstly, kick all threads out; no matter whether they are just idle,
+     * or blocked in an IO system call.
+     */
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -601,6 +606,21 @@ static void multifd_send_terminate_threads(void)
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
     }
+
+    /*
+     * Finally recycle all the threads.
+     *
+     * TODO: p->running is still buggy, e.g. we can reach here without the
+     * corresponding multifd_new_send_channel_async() get invoked yet,
+     * then a new thread can even be created after this function returns.
+     */
+    for (i = 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        if (p->running) {
+            qemu_thread_join(&p->thread);
+        }
+    }
 }
 
 static int multifd_send_channel_destroy(QIOChannel *send)
@@ -608,6 +628,41 @@ static int multifd_send_channel_destroy(QIOChannel *send)
     return socket_send_channel_destroy(send);
 }
 
+static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
+{
+    if (p->registered_yank) {
+        migration_ioc_unregister_yank(p->c);
+    }
+    multifd_send_channel_destroy(p->c);
+    p->c = NULL;
+    qemu_mutex_destroy(&p->mutex);
+    qemu_sem_destroy(&p->sem);
+    qemu_sem_destroy(&p->sem_sync);
+    g_free(p->name);
+    p->name = NULL;
+    multifd_pages_clear(p->pages);
+    p->pages = NULL;
+    p->packet_len = 0;
+    g_free(p->packet);
+    p->packet = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
+    multifd_send_state->ops->send_cleanup(p, errp);
+
+    return *errp == NULL;
+}
+
+static void multifd_send_cleanup_state(void)
+{
+    qemu_sem_destroy(&multifd_send_state->channels_ready);
+    g_free(multifd_send_state->params);
+    multifd_send_state->params = NULL;
+    multifd_pages_clear(multifd_send_state->pages);
+    multifd_send_state->pages = NULL;
+    g_free(multifd_send_state);
+    multifd_send_state = NULL;
+}
+
 void multifd_save_cleanup(void)
 {
     int i;
@@ -615,48 +670,20 @@ void multifd_save_cleanup(void)
     if (!migrate_multifd()) {
         return;
     }
+
     multifd_send_terminate_threads();
-    for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        if (p->running) {
-            qemu_thread_join(&p->thread);
-        }
-    }
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
         Error *local_err = NULL;
 
-        if (p->registered_yank) {
-            migration_ioc_unregister_yank(p->c);
-        }
-        multifd_send_channel_destroy(p->c);
-        p->c = NULL;
-        qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem);
-        qemu_sem_destroy(&p->sem_sync);
-        g_free(p->name);
-        p->name = NULL;
-        multifd_pages_clear(p->pages);
-        p->pages = NULL;
-        p->packet_len = 0;
-        g_free(p->packet);
-        p->packet = NULL;
-        g_free(p->iov);
-        p->iov = NULL;
-        multifd_send_state->ops->send_cleanup(p, &local_err);
-        if (local_err) {
+        if (!multifd_send_cleanup_channel(p, &local_err)) {
             migrate_set_error(migrate_get_current(), local_err);
             error_free(local_err);
         }
     }
-    qemu_sem_destroy(&multifd_send_state->channels_ready);
-    g_free(multifd_send_state->params);
-    multifd_send_state->params = NULL;
-    multifd_pages_clear(multifd_send_state->pages);
-    multifd_send_state->pages = NULL;
-    g_free(multifd_send_state);
-    multifd_send_state = NULL;
+
+    multifd_send_cleanup_state();
 }
 
 static int multifd_zero_copy_flush(QIOChannel *c)
-- 
2.43.0


