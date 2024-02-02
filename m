Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0444FC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqpq-0003nv-SR; Fri, 02 Feb 2024 05:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqpU-0003GI-VY
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqpJ-00022p-1C
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbWhraHYG7bp+m3rSnby9URLY7zcB1qtBbP2QwE9kHI=;
 b=f4BF8SghhyKtx7dPdBKxGxcAI8ojue6PRSTi7WfFZayGMjz67yhZINyqTcG1AflMciepO0
 Q4a3fTSQ2Mz/b5tvRS3SUW1kXZ4GibBg9okFEjnd41fC/7sXrHBx+FWN4h252pFfIqOIaf
 DZcgpwOXZu4ZTq1qffzTl/I3FBLfhqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-kOOOh0iGMpGsbeVmteh_wQ-1; Fri, 02 Feb 2024 05:31:14 -0500
X-MC-Unique: kOOOh0iGMpGsbeVmteh_wQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D151185A780;
 Fri,  2 Feb 2024 10:31:13 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 985A7400D783;
 Fri,  2 Feb 2024 10:31:09 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 23/23] migration/multifd: Optimize sender side to be
 lockless
Date: Fri,  2 Feb 2024 18:28:57 +0800
Message-ID: <20240202102857.110210-24-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When reviewing my attempt to refactor send_prepare(), Fabiano suggested we
try out with dropping the mutex in multifd code [1].

I thought about that before but I never tried to change the code.  Now
maybe it's time to give it a stab.  This only optimizes the sender side.

The trick here is multifd has a clear provider/consumer model, that the
migration main thread publishes requests (either pending_job/pending_sync),
while the multifd sender threads are consumers.  Here we don't have a lot
of comlicated data sharing, and the jobs can logically be submitted lockless.

Arm the code with atomic weapons.  Two things worth mentioning:

  - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
  to find a free channel, but that's expensive if we attach one ACQUIRE per
  channel.  Instead, make it atomic_read() on the pending_job flag, but
  merge the ACQUIRE into one single smp_mb_acquire() later.

  - For pending_sync: it doesn't have any extra data required since now
  p->flags are never touched, it should be safe to not use memory barrier.
  That's different from pending_sync.

Provide rich comments for all the lockless operations to state how they are
paired.  With that, we can remove the mutex.

[1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  2 --
 migration/multifd.c | 51 +++++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 98876ff94a..78a2317263 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -91,8 +91,6 @@ typedef struct {
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
 
-    /* this mutex protects the following parameters */
-    QemuMutex mutex;
     /* is this channel thread running */
     bool running;
     /* multifd flags for each packet */
diff --git a/migration/multifd.c b/migration/multifd.c
index b317d57d61..ef13e2e781 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -501,19 +501,19 @@ static bool multifd_send_pages(void)
         }
     }
 
-    qemu_mutex_lock(&p->mutex);
-    assert(!p->pages->num);
-    assert(!p->pages->block);
     /*
-     * Double check on pending_job==false with the lock.  In the future if
-     * we can have >1 requester thread, we can replace this with a "goto
-     * retry", but that is for later.
+     * Make sure we read p->pending_job before all the rest.  Pairs with
+     * qatomic_store_release() in multifd_send_thread().
      */
-    assert(qatomic_read(&p->pending_job) == false);
-    qatomic_set(&p->pending_job, true);
+    smp_mb_acquire();
+    assert(!p->pages->num);
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-    qemu_mutex_unlock(&p->mutex);
+    /*
+     * Making sure p->pages is setup before marking pending_job=true. Pairs
+     * with the qatomic_load_acquire() in multifd_send_thread().
+     */
+    qatomic_store_release(&p->pending_job, true);
     qemu_sem_post(&p->sem);
 
     return true;
@@ -648,7 +648,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     }
     multifd_send_channel_destroy(p->c);
     p->c = NULL;
-    qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem);
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
@@ -742,14 +741,12 @@ int multifd_send_sync_main(void)
 
         trace_multifd_send_sync_main_signal(p->id);
 
-        qemu_mutex_lock(&p->mutex);
         /*
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
          */
         assert(qatomic_read(&p->pending_sync) == false);
         qatomic_set(&p->pending_sync, true);
-        qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -796,9 +793,12 @@ static void *multifd_send_thread(void *opaque)
         if (multifd_send_should_exit()) {
             break;
         }
-        qemu_mutex_lock(&p->mutex);
 
-        if (qatomic_read(&p->pending_job)) {
+        /*
+         * Read pending_job flag before p->pages.  Pairs with the
+         * qatomic_store_release() in multifd_send_pages().
+         */
+        if (qatomic_load_acquire(&p->pending_job)) {
             MultiFDPages_t *pages = p->pages;
 
             p->iovs_num = 0;
@@ -806,14 +806,12 @@ static void *multifd_send_thread(void *opaque)
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
 
             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                               0, p->write_flags, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
 
@@ -822,24 +820,31 @@ static void *multifd_send_thread(void *opaque)
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
-            qatomic_set(&p->pending_job, false);
-            qemu_mutex_unlock(&p->mutex);
+
+            /*
+             * Making sure p->pages is published before saying "we're
+             * free".  Pairs with the qatomic_load_acquire() in
+             * multifd_send_pages().
+             */
+            qatomic_store_release(&p->pending_job, false);
         } else {
-            /* If not a normal job, must be a sync request */
+            /*
+             * If not a normal job, must be a sync request.  Note that
+             * pending_sync is a standalone flag (unlike pending_job), so
+             * it doesn't require explicit memory barriers.
+             */
             assert(qatomic_read(&p->pending_sync));
             p->flags = MULTIFD_FLAG_SYNC;
             multifd_send_fill_packet(p);
             ret = qio_channel_write_all(p->c, (void *)p->packet,
                                         p->packet_len, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
             /* p->next_packet_size will always be zero for a SYNC packet */
             stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             p->flags = 0;
             qatomic_set(&p->pending_sync, false);
-            qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->sem_sync);
         }
     }
@@ -853,10 +858,7 @@ out:
         error_free(local_err);
     }
 
-    qemu_mutex_lock(&p->mutex);
     p->running = false;
-    qemu_mutex_unlock(&p->mutex);
-
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
@@ -998,7 +1000,6 @@ int multifd_send_setup(Error **errp)
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-- 
2.43.0


