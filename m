Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E0BCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd3b-0002Bq-GL; Fri, 21 Nov 2025 21:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcQP-0006qR-Rr; Fri, 21 Nov 2025 20:28:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcON-0000BT-AX; Fri, 21 Nov 2025 20:28:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF3B016CA76;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9E478321CB2;
 Fri, 21 Nov 2025 21:44:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 59/81] block: move commit_run loop to separate function
Date: Fri, 21 Nov 2025 21:43:58 +0300
Message-ID: <20251121184424.1137669-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241026163010.2865002-3-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 23743ab282af4fbb80fdc049bff2c93668c73c83)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/commit.c b/block/commit.c
index ba0ba59316..3ee0ade7df 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -128,6 +128,55 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
+static int commit_iteration(CommitBlockJob *s, int64_t offset,
+                            int64_t *n, void *buf)
+{
+    int ret = 0;
+    bool copy;
+    bool error_in_source = true;
+
+    /* Copy if allocated above the base */
+    WITH_GRAPH_RDLOCK_GUARD() {
+        ret = bdrv_co_common_block_status_above(blk_bs(s->top),
+            s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
+            n, NULL, NULL, NULL);
+    }
+
+    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
+    trace_commit_one_iteration(s, offset, *n, ret);
+    if (copy) {
+        assert(*n < SIZE_MAX);
+
+        ret = blk_co_pread(s->top, offset, *n, buf, 0);
+        if (ret >= 0) {
+            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
+            if (ret < 0) {
+                error_in_source = false;
+            }
+        }
+    }
+    if (ret < 0) {
+        BlockErrorAction action = block_job_error_action(&s->common,
+                                                         s->on_error,
+                                                         error_in_source,
+                                                         -ret);
+        if (action == BLOCK_ERROR_ACTION_REPORT) {
+            return ret;
+        } else {
+            *n = 0;
+            return 0;
+        }
+    }
+    /* Publish progress */
+    job_progress_update(&s->common.job, *n);
+
+    if (copy) {
+        block_job_ratelimit_processed_bytes(&s->common, *n);
+    }
+
+    return 0;
+}
+
 static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
@@ -158,9 +207,6 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
 
     for (offset = 0; offset < len; offset += n) {
-        bool copy;
-        bool error_in_source = true;
-
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
@@ -168,42 +214,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
-        /* Copy if allocated above the base */
-        WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
-                s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-                &n, NULL, NULL, NULL);
-        }
 
-        copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
-        trace_commit_one_iteration(s, offset, n, ret);
-        if (copy) {
-            assert(n < SIZE_MAX);
-
-            ret = blk_co_pread(s->top, offset, n, buf, 0);
-            if (ret >= 0) {
-                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
-                if (ret < 0) {
-                    error_in_source = false;
-                }
-            }
-        }
-        if (ret < 0) {
-            BlockErrorAction action =
-                block_job_error_action(&s->common, s->on_error,
-                                       error_in_source, -ret);
-            if (action == BLOCK_ERROR_ACTION_REPORT) {
-                return ret;
-            } else {
-                n = 0;
-                continue;
-            }
-        }
-        /* Publish progress */
-        job_progress_update(&s->common.job, n);
+        ret = commit_iteration(s, offset, &n, buf);
 
-        if (copy) {
-            block_job_ratelimit_processed_bytes(&s->common, n);
+        if (ret < 0) {
+            return ret;
         }
     }
 
-- 
2.47.3


