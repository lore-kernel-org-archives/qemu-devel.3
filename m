Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E850C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683m-0002qK-54; Mon, 14 Sep 2026 10:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683S-0002eU-Mt
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:12 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683O-0005nR-Nn
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:09 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso4683445e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397582; x=1790002382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=XFwGbNXfZM3R44knpr4kPAcU0hDUPr2+nnGhVPVDolwO05t4VauWvLkHD+VRDsdweA
 lkJppfJYkkuSFWodgXKEDWpTr5QmfA9dwZ8phYXPJXqeqMC7sSsf+pqLsY8R1234brTX
 GaPI1BeJL1v6POEfq9K+0mDpnpc7i5mHMiLJq+YnixLoKUmd2UtHQXoH+R2KH9TG0m/G
 MGlgPwuTcQu9iinByfpC3ngC89fBrmRYjk0AdDFWFJsQq6bSeLsUeJS1oYOeEpDxpmde
 Ktzzf87RQo4SkbsYYPsqgJMp7rK8BYxVQjUlCz79K1J9NU/jKwxXOM7of6J25dyIaio7
 KroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397582; x=1790002382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=Dp7uwI9wnb9UouW+1Yw/h3xK7BOp5M7VcNXj6YcJlqdlBgRNJEzlmiEYfEgV8vyL4A
 7WtZwBavtGYp2NnYkPP8SWg9eWcXVrL/zjjoG5EdMEcvzTTTvKzP6zs63bDvpuQNQ5Ec
 DUoVHU3eYULiRpHAJ8y+8EGCmNtDFvOKtInMqtL0EbrNqjfp5fTeoQpWaHXKcH31Xd+Q
 NpIBUqLnOJwqdpe0l2IPnsIvcaQxbXawBu/bps9wv9cS1l/2JLoBG3zHuHm5xho2r8nY
 jqDNRY0KcePfyYl1rpTQEaP/Qjv0tQnv5D6tnPWzX7U61MAiQxDIsEKtjNjDPxuAFXPF
 ajAg==
X-Gm-Message-State: AFuF++k6JY5mZysRdefe9H30OPQgY4SF/6dI42yST0eHQDGN/22ywQ+c
 aiwO3GadxvDO0pJbd9fcdrOiWwyUlGX/bXlJksOHtUcJaxtviVZOReJDQwqwR331cbMQzKc2S/p
 bEl6r
X-Gm-Gg: AYBFou3qNmImiNAX6TudCfMNACKNXWLabTsEIXQtYnr8jFlQwkPjFPI0Pbn6ubd0a42
 grgNX+BHllhAy2obFYK/ZWLs7CKJtmZV3EW7DLltzisrnmfPze3WktHorsTtfLa5oNSLVqxj4AU
 xM7mRFpZ1oAsEJr0V3GOSUM//uze6gSVGDnmYrCdSvKW9n16lSDqLMP42PZcAT+gVuxdUqNiafb
 mPkIoPoif7gCdUeKubymLsgEuaAu63pu/ZwuOY2IG/t3igBXtgz+QUe8v7oI/FEZC8vRmNzjktf
 7/LS64OhrOQHYk3gMslOZv2qc7OvBPsewz0zMKJP23AtUaJHgQ0GhIodf8Bi6f56w8POB0kAJPV
 pl3M4bo13eHXbTZ2kxcSuLVBHMzJV8zUq/GCQ0/yHxifyC3QLBNs95tIFNQwj5Ja7GQBrrhefIQ
 90030sCbfAuHKrGIdgyabkYvkCDV1b9HadJB2rTNhQUhlPK04ZPxtnrLuxhNbBnPhLZvasHcB8/
 peyE/8=
X-Received: by 2002:a05:600c:4745:b0:49e:799e:c1c3 with SMTP id
 5b1f17b1804b1-49e7a6868a8mr33804605e9.17.1789397582064; 
 Mon, 14 Sep 2026 07:53:02 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:53:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 6/9] block/block-copy: extract block_copy_set_task_method()
Date: Mon, 14 Sep 2026 16:52:47 +0200
Message-ID: <20260914145250.2792879-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


