Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC0EC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqo2-0008Bh-EA; Fri, 02 Feb 2024 05:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqo1-0008BW-Kz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqnz-0001be-WE
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXT70xPEWyLM/ia39YTlc0qBsOBdM9SVlb+O5t0RHEk=;
 b=TbgbSo3EAo+Xd2BUSFf2yZihDWTaagPBfcKENXE1rhRtNttelqfyiqqPQ2RAmowxvBJYMa
 Hy7SuhzCuDMTR0AE5ruM+uEan+Of8e0eUj9XX7zjxUO2ZLSuLULl9/dbfdbE+u4kfl6OBY
 fubRoov/BrevNln2bDSxpxHmgRJp2V4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-BgaFOXgvNS2I6-yCA-dWYA-1; Fri,
 02 Feb 2024 05:29:51 -0500
X-MC-Unique: BgaFOXgvNS2I6-yCA-dWYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F36551C04B69;
 Fri,  2 Feb 2024 10:29:50 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D734340C95AD;
 Fri,  2 Feb 2024 10:29:46 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 06/23] migration/multifd: Separate SYNC request with normal
 jobs
Date: Fri,  2 Feb 2024 18:28:40 +0800
Message-ID: <20240202102857.110210-7-peterx@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Multifd provide a threaded model for processing jobs.  On sender side,
there can be two kinds of job: (1) a list of pages to send, or (2) a sync
request.

The sync request is a very special kind of job.  It never contains a page
array, but only a multifd packet telling the dest side to synchronize with
sent pages.

Before this patch, both requests use the pending_job field, no matter what
the request is, it will boost pending_job, while multifd sender thread will
decrement it after it finishes one job.

However this should be racy, because SYNC is special in that it needs to
set p->flags with MULTIFD_FLAG_SYNC, showing that this is a sync request.
Consider a sequence of operations where:

  - migration thread enqueue a job to send some pages, pending_job++ (0->1)

  - [...before the selected multifd sender thread wakes up...]

  - migration thread enqueue another job to sync, pending_job++ (1->2),
    setup p->flags=MULTIFD_FLAG_SYNC

  - multifd sender thread wakes up, found pending_job==2
    - send the 1st packet with MULTIFD_FLAG_SYNC and list of pages
    - send the 2nd packet with flags==0 and no pages

This is not expected, because MULTIFD_FLAG_SYNC should hopefully be done
after all the pages are received.  Meanwhile, the 2nd packet will be
completely useless, which contains zero information.

I didn't verify above, but I think this issue is still benign in that at
least on the recv side we always receive pages before handling
MULTIFD_FLAG_SYNC.  However that's not always guaranteed and just tricky.

One other reason I want to separate it is using p->flags to communicate
between the two threads is also not clearly defined, it's very hard to read
and understand why accessing p->flags is always safe; see the current impl
of multifd_send_thread() where we tried to cache only p->flags.  It doesn't
need to be that complicated.

This patch introduces pending_sync, a separate flag just to show that the
requester needs a sync.  Alongside, we remove the tricky caching of
p->flags now because after this patch p->flags should only be used by
multifd sender thread now, which will be crystal clear.  So it is always
thread safe to access p->flags.

With that, we can also safely convert the pending_job into a boolean,
because we don't support >1 pending jobs anyway.

Always use atomic ops to access both flags to make sure no cache effect.
When at it, drop the initial setting of "pending_job = 0" because it's
always allocated using g_new0().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 13 +++++++++++--
 migration/multifd.c | 39 +++++++++++++++++++++++++--------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 3920bdbcf1..08f26ef3fe 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -99,8 +99,17 @@ typedef struct {
     uint32_t flags;
     /* global number of generated multifd packets */
     uint64_t packet_num;
-    /* thread has work to do */
-    int pending_job;
+    /*
+     * The sender thread has work to do if either of below boolean is set.
+     *
+     * @pending_job:  a job is pending
+     * @pending_sync: a sync request is pending
+     *
+     * For both of these fields, they're only set by the requesters, and
+     * cleared by the multifd sender threads.
+     */
+    bool pending_job;
+    bool pending_sync;
     /* array of pages to sent.
      * The owner of 'pages' depends of 'pending_job' value:
      * pending_job == 0 -> migration_thread can use it.
diff --git a/migration/multifd.c b/migration/multifd.c
index 8bb1fd95cf..ea25bbe6bd 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -442,8 +442,8 @@ static int multifd_send_pages(void)
         }
         p = &multifd_send_state->params[i];
         qemu_mutex_lock(&p->mutex);
-        if (!p->pending_job) {
-            p->pending_job++;
+        if (qatomic_read(&p->pending_job) == false) {
+            qatomic_set(&p->pending_job, true);
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
@@ -631,8 +631,12 @@ int multifd_send_sync_main(void)
 
         qemu_mutex_lock(&p->mutex);
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
+        /*
+         * We should be the only user so far, so not possible to be set by
+         * others concurrently.
+         */
+        assert(qatomic_read(&p->pending_sync) == false);
+        qatomic_set(&p->pending_sync, true);
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -685,10 +689,9 @@ static void *multifd_send_thread(void *opaque)
         }
         qemu_mutex_lock(&p->mutex);
 
-        if (p->pending_job) {
+        if (qatomic_read(&p->pending_job)) {
             uint64_t packet_num = p->packet_num;
             MultiFDPages_t *pages = p->pages;
-            uint32_t flags;
 
             if (use_zero_copy_send) {
                 p->iovs_num = 0;
@@ -704,13 +707,11 @@ static void *multifd_send_thread(void *opaque)
                 }
             }
             multifd_send_fill_packet(p);
-            flags = p->flags;
-            p->flags = 0;
             p->num_packets++;
             p->total_normal_pages += pages->num;
             qemu_mutex_unlock(&p->mutex);
 
-            trace_multifd_send(p->id, packet_num, pages->num, flags,
+            trace_multifd_send(p->id, packet_num, pages->num, p->flags,
                                p->next_packet_size);
 
             if (use_zero_copy_send) {
@@ -738,12 +739,23 @@ static void *multifd_send_thread(void *opaque)
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
-            p->pending_job--;
+            qatomic_set(&p->pending_job, false);
             qemu_mutex_unlock(&p->mutex);
-
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&p->sem_sync);
+        } else if (qatomic_read(&p->pending_sync)) {
+            p->flags = MULTIFD_FLAG_SYNC;
+            multifd_send_fill_packet(p);
+            ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, &local_err);
+            if (ret != 0) {
+                qemu_mutex_unlock(&p->mutex);
+                break;
             }
+            /* p->next_packet_size will always be zero for a SYNC packet */
+            stat64_add(&mig_stats.multifd_bytes, p->packet_len);
+            p->flags = 0;
+            qatomic_set(&p->pending_sync, false);
+            qemu_mutex_unlock(&p->mutex);
+            qemu_sem_post(&p->sem_sync);
         } else {
             qemu_mutex_unlock(&p->mutex);
             /* sometimes there are spurious wakeups */
@@ -907,7 +919,6 @@ int multifd_save_setup(Error **errp)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.43.0


