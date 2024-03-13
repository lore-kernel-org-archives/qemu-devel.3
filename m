Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DED5C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQYg-0005jZ-AO; Wed, 13 Mar 2024 11:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkQYe-0005dU-0P
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkQYb-0003Ix-Ia
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710343816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=941wLQydJrw3JvZFUUM+a9c306su5cAf9kTwy06M9t0=;
 b=RWWUxqhmbDGebiH944HOED5fjWavJ+fXsQZi75wsx8F+U/a4cDP8wqf1i7Jdb8zC3ahpgv
 q8EllpHA2+SHNLIw3wkTCEuoQT6DwD3m4EPJN7pDHo+AKUmVifXTYmQRS5E1D9EGeHmyAe
 q/mY6hQ9qiwZwU5TD8FpqTjsQtuPaIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-f0_X1vmfMbW0QS0XuEi_sQ-1; Wed, 13 Mar 2024 11:30:14 -0400
X-MC-Unique: f0_X1vmfMbW0QS0XuEi_sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD0A8FA223;
 Wed, 13 Mar 2024 15:30:14 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E498C2022C1F;
 Wed, 13 Mar 2024 15:30:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, aliang@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH for-9.0] mirror: Don't call job_pause_point() under graph lock
Date: Wed, 13 Mar 2024 16:30:00 +0100
Message-ID: <20240313153000.33121-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Calling job_pause_point() while holding the graph reader lock
potentially results in a deadlock: bdrv_graph_wrlock() first drains
everything, including the mirror job, which pauses it. The job is only
unpaused at the end of the drain section, which is when the graph writer
lock has been successfully taken. However, if the job happens to be
paused at a pause point where it still holds the reader lock, the writer
lock can't be taken as long as the job is still paused.

Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.

Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-28125
Fixes: 004915a96a7a40e942ac85e6d22518cbcd283506
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h |  2 +-
 block/mirror.c     | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 9ea98b5927..2b873f2576 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -483,7 +483,7 @@ void job_enter(Job *job);
  *
  * Called with job_mutex *not* held.
  */
-void coroutine_fn job_pause_point(Job *job);
+void coroutine_fn GRAPH_UNLOCKED job_pause_point(Job *job);
 
 /**
  * @job: The job that calls the function.
diff --git a/block/mirror.c b/block/mirror.c
index 5145eb53e1..1bdce3b657 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -479,9 +479,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
     return bytes_handled;
 }
 
-static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
+static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = s->mirror_top_bs->backing->bs;
+    BlockDriverState *source;
     MirrorOp *pseudo_op;
     int64_t offset;
     /* At least the first dirty chunk is mirrored in one iteration. */
@@ -489,6 +489,10 @@ static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
 
+    bdrv_graph_co_rdlock();
+    source = s->mirror_top_bs->backing->bs;
+    bdrv_graph_co_rdunlock();
+
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     offset = bdrv_dirty_iter_next(s->dbi);
     if (offset < 0) {
@@ -1066,9 +1070,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                 mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt != 0) {
-                bdrv_graph_co_rdlock();
                 mirror_iteration(s);
-                bdrv_graph_co_rdunlock();
             }
         }
 
-- 
2.44.0


