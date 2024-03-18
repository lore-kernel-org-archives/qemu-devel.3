Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC913C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCcg-0002Sn-K5; Mon, 18 Mar 2024 09:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcS-0002Oa-8Y
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcL-0007eS-Ii
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReNmBLEe/G35l3tlnKmgGtREauwHmcX2xc1FDhyZGWg=;
 b=QXHJMP2D3nkpU5705XQlJ3p3ci3InbDVPDBHqvUwNMdNx0OHrgAqoenaXnkFlu72zLTcWz
 i7FBZWVU38v0ZUaTEWLkfQkH1fd/p5zt/ogT/L+dZVEHPQjq2Wy2iw7xaY/Zx2dG1krZws
 nBtc1QTMlvFqDapftpOHYI6V5c5yf1s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-hYPZwLYsMYSKZh2egWM6Bw-1; Mon,
 18 Mar 2024 09:01:27 -0400
X-MC-Unique: hYPZwLYsMYSKZh2egWM6Bw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9E522801E6B;
 Mon, 18 Mar 2024 13:01:26 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BF372166B33;
 Mon, 18 Mar 2024 13:01:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/15] mirror: Don't call job_pause_point() under graph lock
Date: Mon, 18 Mar 2024 14:01:04 +0100
Message-ID: <20240318130118.358920-2-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
References: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Fixes: 004915a96a7a ("block: Protect bs->backing with graph_lock")
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240313153000.33121-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


