Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F94ECA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7W-0005wX-LY; Tue, 29 Sep 2026 11:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7L-0005o1-6A
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:43 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7J-0001S9-1L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:42 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so2707932f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697099; x=1791301899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=C5P6sCfyqR4wgql5NBy3AFaT90De2tp2yB3kZlelu8hSXtA8K+XVp4PHmZMVUayxLq
 9j0HN9qJtns1ppUUWWg/K8kSRdCvPBA3j2or406rd96vDAdaxHyzcIDWkCpqwjoNrHoq
 B0wt4rUhbxFAlGtd+W4ARj4f7sHQt0Pt5G7TSYEdIpEMXAjfRDdcuQ9LzDpaR+n3vC2h
 oRt8SrWlyWk2Jpt5rkoC19hJQGbW8081bl4UhqL/RCWHqcR5PGOLSsR3mOxzsakl8KOz
 yQs2WzM6DuGK02k6zoBhdh8rXak2WtxS8pBFMs2aBpd5MJCXAKJDsGk7pmglZ7bWPKWn
 7hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697099; x=1791301899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=dAMYuJbx0fGN2LkNI/99Pzjo64J0UxgcvtBc0jHuBMPQu3YKgA6wLM13L7NAtrnZxX
 9+Awh7v/rCpkmRYD2fX/l1GSgP05bmyQfHpJxMOHJSfUj9fjJhKUE/KwLHvpcW2Ecsow
 eF8fdAp1tfA4DOrkKQsMl5bf44qwk1pWcdllbVJ+780AfsLgHBM6Y0KP+GhwGUYz3t5f
 K26K+HXyIH/1fjUCKYcq9gBsBNRDPwb2kcvlybpAJ6zovXlwPaOPzwc41bvb+7NzeSly
 GRlXSkXGVXiH3bFBNJPoADOkhvXzDsXoNWVo0Ja8ZERAPALMngKiGj+CJlBBMo75BPkl
 +Bag==
X-Gm-Message-State: AFq9FYJiwXJ5FU88IMRe2m9sprqWBjwMybuDWi8Id9TBksDgkzximKFx
 fGTR7X2GR3CBjwyKZVz12a/0R2TDCFtGWN7TkIfFwE3XsaO+M+BeqyTnJwCn2E5D49buZBjjqvq
 xPk23
X-Gm-Gg: AYBFou2It4MHVSTfjkf83SE3qvVSKAbu91O+nKA9P2adoW5S/VXwdGEE4usd9x7y5fw
 AiqrwQPcOFqE4K2LgIuI5LScAoPyOkMTySGol+hWjW4cvhSxcUE5vrGXGBTxzUpo83NLCZfK/XB
 N/Fb3qT7yfkPqaBaQdGayj0u9hME/xZBwnxhTwIdxF+TJcpSbcGJmyNUSqZBqvZsZf4779xwFDK
 BmQAgQFiC8lUg9LSXnccBCm63FSEfC4aqw4R80mn9L5hp+YbRFx46xBoloMd7BCKx1Q7lykL11A
 fwC5eQCTv7CUXM9lM95u/fDSqyf3/G3XMpyAFPb6CEblv9Yh1GTA5YIr15TEeRDPfohjQXB3ooI
 8bZZKqdR/4gC7Ywjm0sLWgVWMjb/HRjrsMN/8GmSQ5aHYA099SLy6ZTp7tBnzZI95Q2luckIiJ4
 6rHAer7QiDGeYX87IncE3+bc7RgzEEy15S2vyj8FeG4kpzPkgs4RbwK580Rw==
X-Received: by 2002:a05:6000:2885:b0:48a:f073:336b with SMTP id
 ffacd0b85a97d-48af0733452mr5980594f8f.23.1790697099594; 
 Tue, 29 Sep 2026 08:51:39 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 6/9] block/block-copy: extract block_copy_set_task_method()
Date: Tue, 29 Sep 2026 17:51:22 +0200
Message-ID: <20260929155125.3151111-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

Move the per-task block-status query and its skip_unallocated and
BDRV_BLOCK_ZERO handling out of block_copy_dirty_clusters() into
block_copy_set_task_method(). No behavior change. The next patch
changes that decision, and having it in one place keeps that change to
just the new logic.

The block-status result no longer lands in the caller's @ret, so drop
the note saying @ret may be positive at the out: label.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 21ebe8aec2..d71d070dbd 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -741,6 +741,35 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
     return ret;
 }
 
+/*
+ * Decide how @task is copied: COPY_WRITE_ZEROES if it reads as zero. May
+ * shrink @task. Returns false if @task is to be skipped (already ended,
+ * not freed).
+ */
+static bool coroutine_fn GRAPH_RDLOCK
+block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
+{
+    int ret;
+    int64_t status_bytes;
+
+    ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
+                                  &status_bytes);
+    assert(ret >= 0); /* never fail */
+    if (status_bytes < task->req.bytes) {
+        block_copy_task_shrink(task, status_bytes);
+    }
+    if (qatomic_read(&s->skip_unallocated) && !(ret & BDRV_BLOCK_ALLOCATED)) {
+        block_copy_task_end(task, 0);
+        trace_block_copy_skip_range(s, task->req.offset, task->req.bytes);
+        return false;
+    }
+    if (ret & BDRV_BLOCK_ZERO) {
+        task->method = COPY_WRITE_ZEROES;
+    }
+
+    return true;
+}
+
 /*
  * block_copy_dirty_clusters
  *
@@ -773,7 +802,6 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     while (bytes && aio_task_pool_status(aio) == 0 &&
            !qatomic_read(&call_state->cancelled)) {
         BlockCopyTask *task;
-        int64_t status_bytes;
 
         task = block_copy_task_create(s, call_state, offset, bytes);
         if (!task) {
@@ -787,24 +815,12 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
 
         found_dirty = true;
 
-        ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
-                                      &status_bytes);
-        assert(ret >= 0); /* never fail */
-        if (status_bytes < task->req.bytes) {
-            block_copy_task_shrink(task, status_bytes);
-        }
-        if (qatomic_read(&s->skip_unallocated) &&
-            !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(task, 0);
-            trace_block_copy_skip_range(s, task->req.offset, task->req.bytes);
+        if (!block_copy_set_task_method(s, task)) {
             offset = task_end(task);
             bytes = end - offset;
             g_free(task);
             continue;
         }
-        if (ret & BDRV_BLOCK_ZERO) {
-            task->method = COPY_WRITE_ZEROES;
-        }
 
         if (!call_state->ignore_ratelimit) {
             uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
@@ -845,8 +861,6 @@ out:
          * block_copy_task_run. If it fails, it means some task already failed
          * for real reason, let's return first failure.
          * Still, assert that we don't rewrite failure by success.
-         *
-         * Note: ret may be positive here because of block-status result.
          */
         assert(ret >= 0 || aio_task_pool_status(aio) < 0);
         ret = aio_task_pool_status(aio);
-- 
2.53.0


