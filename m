Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D664CA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7b-0005zU-Qn; Tue, 29 Sep 2026 11:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7P-0005rk-9T
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:47 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7L-0001Sq-Nt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:46 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso26859695e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697102; x=1791301902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=thMNzpR9hfmP2UrqepCGOnSZLkYfUI9v4LXa+JCQASs=;
 b=Z7o/kaXfRVDtVTHp9uI6wc2e9+OXCfnR+6ClFTHQeuC1kO+KRrd2cJHLFm6OS5Umnc
 W4vHnGs53WeRFi7t8byVdB5kqvXGGqHu2jqAmdp9c/fxPQzfrnS00jjanMfnGXR95sc7
 Qs9rrp1Cd15+/M58AO0tUZo9EixSFXzr5JVkjINYz907GJWgVcfXYEvnCCsjuB7K4jAY
 IYXUiFXuXvIRSGHdBjiWOY9AlXQaIZ0ofPUe2pDQIFuod9WN9S3iAUeitLQXTYfwPfV5
 HvpTmA4yUURcTlnML8lAdY9yydMhfeg+JGSUhFRoT5ERQ08uV7QgcacwpJdK/WQV26x8
 jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697102; x=1791301902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=thMNzpR9hfmP2UrqepCGOnSZLkYfUI9v4LXa+JCQASs=;
 b=IektVC8OCcGrA3hGLp+3dYVYvZsd/QzP+/1/7NQZh/8AyHw3dbIpubta2py6uumwJB
 1uXDV4HQJIOJSjhMKyCjy4BjnV9tJ3ujk1CqMUc6pYNS0a58blxhDHImgmbYAKHqAV8l
 Hc3+iKF9wyiVc3qK3sBDiYhD1KhUSovBglKygabWmhGN/Vif4YaD6ZWkvrKRj/ijwb1V
 BRvNE9mQ2M7zsQPvidYku6AjkVyQSp6TrHe/bJy1Z9HOzOxMrIwn9GiNGWaJT6Sbj85s
 i0NVXsPhaC+BaiZO54kJ3aYLkcKGK1P7A4WF3P/+BnVWzDf+cWJBfZtGUvNggaO3MVY+
 Um+Q==
X-Gm-Message-State: AFuF++merkWsXqPcFluJ3cbL02dHzQMLY+bwPyoCNl1pI+nICRZPYYGb
 0JlaQ/f1bKyn2T8h5lVu3J1goZIRJ1MIptlQJepWCOEWm3+adUQrvLcO2AT4XLVGaaJtPeSunE2
 JP9OK
X-Gm-Gg: AYBFou1P+R+ki6p0POYYmbLFytP0RQkI5xA5rQWzxw6z5m6mTygdVrS/n29/A/b2ZlO
 HYPNKD+4/tBDsu+sbEHQ/ZUm7c4d41WknPgswGMWShTdhKbzM6QVEla/o3Xg7I26a4leEtyQyML
 ooDTfrUN86ncSPWWGa1/+ldKsmYvOOjRTd7I1BbyVyo/XpglzawyqNwDZkhHiN8siF8gG0pV9l+
 xXVkjVXntk2MsR9UcyDeYk+jESIPnFCV2gPknQiIgjBfGc+/6zXn0gbv5xXXY0K6k8/JDyjd/XJ
 fvkaoNNH6a7gE6300W4N6XQyTtRnlQ1SbsUh6/9bxa2G+fSfHlXOSSgvyn7Z/DPnh5+3M1DG7yg
 26A3WdztvK5nji7Dv58+gP79g2h53oejcPLUaFvD/1LW3phOduFAEZ39TxcvZJB3RiolFgdEms/
 S5VwLuw8Ko/3ZcfHVMg7Qh9g4He/0zhecv3vfiqpEb0XrV8gLHUJorr5lCBH+ppNEyKeDC
X-Received: by 2002:a05:600c:4f42:b0:49f:bd3c:bc1b with SMTP id
 5b1f17b1804b1-49fe66f5ddemr369021675e9.22.1790697102317; 
 Tue, 29 Sep 2026 08:51:42 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 8/9] block/backup: pre-fill zero_bitmap for full/bitmap
Date: Tue, 29 Sep 2026 17:51:24 +0200
Message-ID: <20260929155125.3151111-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

Only sync=top runs an up-front scan, so the previous patch did nothing
for the other modes. FULL and BITMAP know their complete copy_bitmap
before copying starts, and the same copy-before-write guarantee holds:
a cluster still dirty when the copy loop reaches it has not been written
since the scan.

Add block_copy_calculate_zero_bitmap(), driven one query at a time from
backup_scan_source() so the graph rdlock and the pause point are taken
per query, and query each confirmed span once however many dirty areas
it covers. The scan only fills zero_bitmap and never clears copy_bitmap,
so sync=full still writes zeroes for clusters the source never
allocated; it just stops re-querying to find that out. Unlike the
per-task queries it replaces the scan is serial, so a sparsely dirtied
job against a slow source may spend more time here than it saves. The
sync=top loop had the same shape, so both fold into
backup_scan_source().

sync=none keeps the per-task query. Its bitmap says "anything may be
copied", not "this will be copied", and it only ever copies what the
guest writes during the fleecing window, so scanning the whole image at
attach is the wrong trade.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/backup.c             | 94 ++++++++++++++++++++++++--------------
 block/block-copy.c         | 41 +++++++++++++++++
 include/block/block-copy.h |  4 ++
 3 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 11d70243e2..38b0838d69 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -247,59 +247,85 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
     job_progress_set_remaining(&job->common.job, estimate);
 }
 
-static int coroutine_fn backup_run(Job *job, Error **errp)
+/*
+ * Walk the source before copying starts: fill zero_bitmap and, for sync=top,
+ * drop the clusters that are not allocated above the backing.
+ */
+static int coroutine_fn backup_scan_source(BackupBlockJob *s)
 {
-    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    int ret;
-
-    backup_init_bcs_bitmap(s);
-
-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
-        int64_t offset = 0;
-        int64_t count;
+    Job *job = &s->common.job;
+    bool top = s->sync_mode == MIRROR_SYNC_MODE_TOP;
+    int64_t offset, cached_end = 0, count;
+    int ret = 0;
 
-        for (offset = 0; offset < s->len; ) {
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
+    for (offset = 0; offset < s->len; offset += count) {
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
 
-            job_pause_point(job);
+        job_pause_point(job);
 
-            if (job_is_cancelled(job)) {
-                return -ECANCELED;
-            }
+        if (job_is_cancelled(job)) {
+            return -ECANCELED;
+        }
 
-            /* rdlock protects the subsequent call to bdrv_is_allocated() */
-            bdrv_graph_co_rdlock();
+        /* rdlock protects the block-status queries below */
+        bdrv_graph_co_rdlock();
+        if (top) {
             ret = block_copy_reset_unallocated(s->bcs, offset, &count);
-            bdrv_graph_co_rdunlock();
-            if (ret < 0) {
-                return ret;
-            }
+        } else {
+            block_copy_calculate_zero_bitmap(s->bcs, offset, &cached_end,
+                                             &count);
+        }
+        bdrv_graph_co_rdunlock();
 
-            offset += count;
+        if (ret < 0) {
+            return ret;
         }
+    }
+
+    if (top) {
         block_copy_set_skip_unallocated(s->bcs, false);
-        block_copy_set_zero_bitmap_valid(s->bcs);
     }
+    block_copy_set_zero_bitmap_valid(s->bcs);
 
-    if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
+    return 0;
+}
+
+static int coroutine_fn backup_run(Job *job, Error **errp)
+{
+    BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
+    int ret;
+
+    backup_init_bcs_bitmap(s);
+
+    switch (s->sync_mode) {
+    case MIRROR_SYNC_MODE_TOP:
+    case MIRROR_SYNC_MODE_FULL:
+    case MIRROR_SYNC_MODE_BITMAP:
+        ret = backup_scan_source(s);
+        if (ret < 0) {
+            return ret;
+        }
+        break;
+
+    case MIRROR_SYNC_MODE_NONE:
         /*
          * All bits are set in bcs bitmap to allow any cluster to be copied.
-         * This does not actually require them to be copied.
+         * This does not actually require them to be copied. Yield until the
+         * job is cancelled and let the before_write notify callback service
+         * CoW requests.
          */
         while (!job_is_cancelled(job)) {
-            /*
-             * Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests.
-             */
             job_yield(job);
         }
-    } else {
-        return backup_loop(s);
+        return 0;
+
+    default:
+        g_assert_not_reached();
     }
 
-    return 0;
+    return backup_loop(s);
 }
 
 static void coroutine_fn backup_pause(Job *job)
diff --git a/block/block-copy.c b/block/block-copy.c
index 94d4f3dd69..c0a3359938 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -813,6 +813,47 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
+/*
+ * One scan step, like block_copy_reset_unallocated(); @cached_end
+ * tracks progress across calls, @count how far @offset should move.
+ */
+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count)
+{
+    int64_t dirty_offset, dirty_bytes, dirty_end;
+    bool found;
+
+    /* CBW mutates copy_bitmap from its own AioContext meanwhile. */
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        found = bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap, offset,
+                                                  s->len, INT64_MAX,
+                                                  &dirty_offset, &dirty_bytes);
+    }
+
+    if (!found) {
+        *count = s->len - offset;
+        return;
+    }
+    dirty_end = dirty_offset + dirty_bytes;
+
+    if (*cached_end < dirty_end) {
+        int64_t clusters;
+        int64_t query_offset = MAX(dirty_offset, *cached_end);
+        int ret = block_copy_is_cluster_allocated(s, query_offset, &clusters);
+
+        if (ret >= 0) {
+            *cached_end = query_offset + clusters * s->cluster_size;
+        } else {
+            /* Best-effort: leave this area unmarked; it copies as data. */
+            *cached_end = dirty_end;
+        }
+    }
+
+    /* 0 if the query above didn't yet reach dirty_end: try again next call. */
+    *count = *cached_end >= dirty_end ? dirty_end - offset : 0;
+}
+
 /*
  * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
  * shrink @task. Returns false if @task is to be skipped (already ended,
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index e4e5b56753..3a61066b55 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -44,6 +44,10 @@ void block_copy_reset(BlockCopyState *s, int64_t offset, int64_t bytes);
 int64_t coroutine_fn GRAPH_RDLOCK
 block_copy_reset_unallocated(BlockCopyState *s, int64_t offset, int64_t *count);
 
+void coroutine_fn GRAPH_RDLOCK
+block_copy_calculate_zero_bitmap(BlockCopyState *s, int64_t offset,
+                                 int64_t *cached_end, int64_t *count);
+
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool ignore_ratelimit, uint64_t timeout_ns,
                             BlockCopyAsyncCallbackFunc cb,
-- 
2.53.0


