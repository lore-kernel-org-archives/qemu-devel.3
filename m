Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ACCCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 05:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcws-0002LK-0B; Fri, 21 Nov 2025 21:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMc1P-0001eb-6j; Fri, 21 Nov 2025 20:02:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbzL-0002GI-Dw; Fri, 21 Nov 2025 20:02:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EFC1E16CA77;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AEFC4321CB3;
 Fri, 21 Nov 2025 21:44:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 60/81] block: refactor error handling of
 commit_iteration
Date: Fri, 21 Nov 2025 21:43:59 +0300
Message-ID: <20251121184424.1137669-60-mjt@tls.msk.ru>
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
Message-Id: <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
[vsementsov]: move action declaration to the top of the function
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 0648c76ad198e91515771fbbeaac3a3807669a4a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/commit.c b/block/commit.c
index 3ee0ade7df..5c6596a52e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -129,51 +129,60 @@ static void commit_clean(Job *job)
 }
 
 static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *n, void *buf)
+                            int64_t *requested_bytes, void *buf)
 {
+    BlockErrorAction action;
+    int64_t bytes = *requested_bytes;
     int ret = 0;
-    bool copy;
     bool error_in_source = true;
 
     /* Copy if allocated above the base */
     WITH_GRAPH_RDLOCK_GUARD() {
         ret = bdrv_co_common_block_status_above(blk_bs(s->top),
             s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-            n, NULL, NULL, NULL);
+            &bytes, NULL, NULL, NULL);
     }
 
-    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
-    trace_commit_one_iteration(s, offset, *n, ret);
-    if (copy) {
-        assert(*n < SIZE_MAX);
+    trace_commit_one_iteration(s, offset, bytes, ret);
 
-        ret = blk_co_pread(s->top, offset, *n, buf, 0);
-        if (ret >= 0) {
-            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
-            if (ret < 0) {
-                error_in_source = false;
-            }
-        }
-    }
     if (ret < 0) {
-        BlockErrorAction action = block_job_error_action(&s->common,
-                                                         s->on_error,
-                                                         error_in_source,
-                                                         -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT) {
-            return ret;
-        } else {
-            *n = 0;
-            return 0;
+        goto fail;
+    }
+
+    if (ret & BDRV_BLOCK_ALLOCATED) {
+        assert(bytes < SIZE_MAX);
+
+        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
+        if (ret < 0) {
+            goto fail;
         }
+
+        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
+        if (ret < 0) {
+            error_in_source = false;
+            goto fail;
+        }
+
+        block_job_ratelimit_processed_bytes(&s->common, bytes);
     }
+
     /* Publish progress */
-    job_progress_update(&s->common.job, *n);
 
-    if (copy) {
-        block_job_ratelimit_processed_bytes(&s->common, *n);
+    job_progress_update(&s->common.job, bytes);
+
+    *requested_bytes = bytes;
+
+    return 0;
+
+fail:
+    action = block_job_error_action(&s->common, s->on_error,
+                                    error_in_source, -ret);
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return ret;
     }
 
+    *requested_bytes = 0;
+
     return 0;
 }
 
-- 
2.47.3


