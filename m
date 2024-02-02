Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD077C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqnm-00088n-R7; Fri, 02 Feb 2024 05:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqnk-00088D-UW
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqni-0001Z2-UL
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9GwF5wr+IkbZjgGSvzhOPqUroVN/4alXq1fUUQ0DrU=;
 b=CO2tB6z/k9knrfFr8anRyHtB5Tnin0MKm2alxJZ2AOsKwblgtGmdEJzr5h3Lpx1fGlQPXC
 6Nmao8Llr1JILpzKBgTdtXF8FchTaViopsTk9lGsHlLjq4gDqFNSXWTbNqq9qQy3DHDNFK
 5oyvMtOjy3+uPoI6QNhvlCdSlqLlhaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-XaYXVdYaNnOyobl4aROsxQ-1; Fri, 02 Feb 2024 05:29:37 -0500
X-MC-Unique: XaYXVdYaNnOyobl4aROsxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B28C585A58C;
 Fri,  2 Feb 2024 10:29:36 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7691640C1231;
 Fri,  2 Feb 2024 10:29:33 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 03/23] migration/multifd: Drop MultiFDSendParams.quit,
 cleanup error paths
Date: Fri,  2 Feb 2024 18:28:37 +0800
Message-ID: <20240202102857.110210-4-peterx@redhat.com>
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

Multifd send side has two fields to indicate error quits:

  - MultiFDSendParams.quit
  - &multifd_send_state->exiting

Merge them into the global one.  The replacement is done by changing all
p->quit checks into the global var check.  The global check doesn't need
any lock.

A few more things done on top of this altogether:

  - multifd_send_terminate_threads()

    Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
    the tracepoint, migrate_set_error() and migrate_set_state().

  - multifd_send_sync_main()

    In the 2nd loop, add one more check over the global var to make sure we
    don't keep the looping if QEMU already decided to quit.

  - multifd_tls_outgoing_handshake()

    Use multifd_send_terminate_threads() to set the error state.  That has
    a benefit of updating MigrationState.error to that error too, so we can
    persist that 1st error we hit in that specific channel.

  - multifd_new_send_channel_async()

    Take similar approach like above, drop the migrate_set_error() because
    multifd_send_terminate_threads() already covers that.  Unwrap the helper
    multifd_new_send_channel_cleanup() along the way; not really needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  2 --
 migration/multifd.c | 85 ++++++++++++++++++---------------------------
 2 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 35d11f103c..7c040cb85a 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -95,8 +95,6 @@ typedef struct {
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
-    /* should this thread finish */
-    bool quit;
     /* multifd flags for each packet */
     uint32_t flags;
     /* global number of generated multifd packets */
diff --git a/migration/multifd.c b/migration/multifd.c
index b8d2c96533..2c98023d67 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -372,6 +372,11 @@ struct {
     MultiFDMethods *ops;
 } *multifd_send_state;
 
+static bool multifd_send_should_exit(void)
+{
+    return qatomic_read(&multifd_send_state->exiting);
+}
+
 /*
  * The migration thread can wait on either of the two semaphores.  This
  * function can be used to kick the main thread out of waiting on either of
@@ -409,7 +414,7 @@ static int multifd_send_pages(void)
     MultiFDSendParams *p = NULL; /* make happy gcc */
     MultiFDPages_t *pages = multifd_send_state->pages;
 
-    if (qatomic_read(&multifd_send_state->exiting)) {
+    if (multifd_send_should_exit()) {
         return -1;
     }
 
@@ -421,14 +426,11 @@ static int multifd_send_pages(void)
      */
     next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
-        p = &multifd_send_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            error_report("%s: channel %d has already quit!", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
+        if (multifd_send_should_exit()) {
             return -1;
         }
+        p = &multifd_send_state->params[i];
+        qemu_mutex_lock(&p->mutex);
         if (!p->pending_job) {
             p->pending_job++;
             next_channel = (i + 1) % migrate_multifd_channels();
@@ -483,6 +485,16 @@ static void multifd_send_terminate_threads(Error *err)
 {
     int i;
 
+    /*
+     * We don't want to exit each threads twice.  Depending on where
+     * we get the error, or if there are two independent errors in two
+     * threads at the same time, we can end calling this function
+     * twice.
+     */
+    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
+        return;
+    }
+
     trace_multifd_send_terminate_threads(err != NULL);
 
     if (err) {
@@ -497,26 +509,13 @@ static void multifd_send_terminate_threads(Error *err)
         }
     }
 
-    /*
-     * We don't want to exit each threads twice.  Depending on where
-     * we get the error, or if there are two independent errors in two
-     * threads at the same time, we can end calling this function
-     * twice.
-     */
-    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
-        return;
-    }
-
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        p->quit = true;
         qemu_sem_post(&p->sem);
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
-        qemu_mutex_unlock(&p->mutex);
     }
 }
 
@@ -615,16 +614,13 @@ int multifd_send_sync_main(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        trace_multifd_send_sync_main_signal(p->id);
-
-        qemu_mutex_lock(&p->mutex);
-
-        if (p->quit) {
-            error_report("%s: channel %d has already quit", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
+        if (multifd_send_should_exit()) {
             return -1;
         }
 
+        trace_multifd_send_sync_main_signal(p->id);
+
+        qemu_mutex_lock(&p->mutex);
         p->packet_num = multifd_send_state->packet_num++;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
@@ -634,6 +630,10 @@ int multifd_send_sync_main(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (multifd_send_should_exit()) {
+            return -1;
+        }
+
         qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
@@ -671,7 +671,7 @@ static void *multifd_send_thread(void *opaque)
         qemu_sem_post(&multifd_send_state->channels_ready);
         qemu_sem_wait(&p->sem);
 
-        if (qatomic_read(&multifd_send_state->exiting)) {
+        if (multifd_send_should_exit()) {
             break;
         }
         qemu_mutex_lock(&p->mutex);
@@ -786,12 +786,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
-    migrate_set_error(migrate_get_current(), err);
-    /*
-     * Error happen, mark multifd_send_thread status as 'quit' although it
-     * is not created, and then tell who pay attention to me.
-     */
-    p->quit = true;
+    multifd_send_terminate_threads(err);
     multifd_send_kick_main(p);
     error_free(err);
 }
@@ -857,22 +852,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
-static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
-                                             QIOChannel *ioc, Error *err)
-{
-     migrate_set_error(migrate_get_current(), err);
-     /* Error happen, we need to tell who pay attention to me */
-     multifd_send_kick_main(p);
-     /*
-      * Although multifd_send_thread is not created, but main migration
-      * thread need to judge whether it is running, so we need to mark
-      * its status.
-      */
-     p->quit = true;
-     object_unref(OBJECT(ioc));
-     error_free(err);
-}
-
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
@@ -889,7 +868,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_new_send_channel_cleanup(p, ioc, local_err);
+    multifd_send_terminate_threads(local_err);
+    multifd_send_kick_main(p);
+    object_unref(OBJECT(ioc));
+    error_free(local_err);
 }
 
 static void multifd_new_send_channel_create(gpointer opaque)
@@ -921,7 +903,6 @@ int multifd_save_setup(Error **errp)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
-- 
2.43.0


