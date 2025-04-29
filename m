Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC69C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDm-00072P-4s; Tue, 29 Apr 2025 07:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDg-0006sd-5V; Tue, 29 Apr 2025 07:33:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDd-0008F6-9P; Tue, 29 Apr 2025 07:33:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 94774613CD;
 Tue, 29 Apr 2025 14:33:40 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-S9PIonOc; Tue, 29 Apr 2025 14:33:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926420;
 bh=XKka9WznzaFH71i9QUb+uGa+QdEj4xDm/kPV4IEvdII=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SU16yhvdzlYnQLXOJcWWoDDJbL/IH7ARdSgk5a5ZBOw7N0xWQFKA0mdrkoPI7c9I1
 xcYMFaFSWU1RTiTlkz8HbV2YiPBIDPL+F27Hgq5g/gef5WOaItYmwZ5UvA3ybEhsWZ
 Jwz0gP8NnjpeJJkxdb9npV4AYQvXDbtZQUMdxH0U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Vincent Vanlaer <libvirt-e6954efa@volkihar.be>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 2/8] block: move commit_run loop to separate function
Date: Tue, 29 Apr 2025 14:33:26 +0300
Message-ID: <20250429113335.423535-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241026163010.2865002-3-libvirt-e6954efa@volkihar.be>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 89 +++++++++++++++++++++++++++++---------------------
 1 file changed, 52 insertions(+), 37 deletions(-)

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
2.48.1


