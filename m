Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A5C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXujp-0006E7-Bv; Wed, 07 Feb 2024 22:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujk-0006Cs-1M
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuji-0004Ls-Ez
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOxM34KtLIN0cPcBEfxMbZlDBqVqASX9xZ8Un2UI8a4=;
 b=e6OxU3FrvygcTirN2NbBivQ08Q98fEEMiYk8uh+cQR7+QhM1vAxrpaHz8Xlpl/aMV5ryp6
 7jnIP1ciok/dIeJjEosi0E0ZK04Vyqgh/HAB57zFQljdOsxR61iySDC3qookSqJakK8Z18
 ij8lT8ahsR1ONqSSqqHIJOUtR9jceSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-zGiJ5iBoMm-RCvuNs_LyVA-1; Wed, 07 Feb 2024 22:05:58 -0500
X-MC-Unique: zGiJ5iBoMm-RCvuNs_LyVA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34D52845E62;
 Thu,  8 Feb 2024 03:05:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0140492BC7;
 Thu,  8 Feb 2024 03:05:55 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 08/34] migration/multifd: Simplify locking in sender thread
Date: Thu,  8 Feb 2024 11:05:02 +0800
Message-ID: <20240208030528.368214-9-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

The sender thread will yield the p->mutex before IO starts, trying to not
block the requester thread.  This may be unnecessary lock optimizations,
because the requester can already read pending_job safely even without the
lock, because the requester is currently the only one who can assign a
task.

Drop that lock complication on both sides:

  (1) in the sender thread, always take the mutex until job done
  (2) in the requester thread, check pending_job clear lockless

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-8-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index ea25bbe6bd..4d5a01ed93 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -429,7 +429,9 @@ static int multifd_send_pages(void)
         return -1;
     }
 
+    /* We wait here, until at least one channel is ready */
     qemu_sem_wait(&multifd_send_state->channels_ready);
+
     /*
      * next_channel can remain from a previous migration that was
      * using more channels, so ensure it doesn't overflow if the
@@ -441,17 +443,26 @@ static int multifd_send_pages(void)
             return -1;
         }
         p = &multifd_send_state->params[i];
-        qemu_mutex_lock(&p->mutex);
+        /*
+         * Lockless read to p->pending_job is safe, because only multifd
+         * sender thread can clear it.
+         */
         if (qatomic_read(&p->pending_job) == false) {
-            qatomic_set(&p->pending_job, true);
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
-        qemu_mutex_unlock(&p->mutex);
     }
+
+    qemu_mutex_lock(&p->mutex);
     assert(!p->pages->num);
     assert(!p->pages->block);
-
+    /*
+     * Double check on pending_job==false with the lock.  In the future if
+     * we can have >1 requester thread, we can replace this with a "goto
+     * retry", but that is for later.
+     */
+    assert(qatomic_read(&p->pending_job) == false);
+    qatomic_set(&p->pending_job, true);
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
@@ -709,8 +720,6 @@ static void *multifd_send_thread(void *opaque)
             multifd_send_fill_packet(p);
             p->num_packets++;
             p->total_normal_pages += pages->num;
-            qemu_mutex_unlock(&p->mutex);
-
             trace_multifd_send(p->id, packet_num, pages->num, p->flags,
                                p->next_packet_size);
 
@@ -730,6 +739,7 @@ static void *multifd_send_thread(void *opaque)
             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                               0, p->write_flags, &local_err);
             if (ret != 0) {
+                qemu_mutex_unlock(&p->mutex);
                 break;
             }
 
@@ -738,7 +748,6 @@ static void *multifd_send_thread(void *opaque)
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
-            qemu_mutex_lock(&p->mutex);
             qatomic_set(&p->pending_job, false);
             qemu_mutex_unlock(&p->mutex);
         } else if (qatomic_read(&p->pending_sync)) {
-- 
2.43.0


