Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A1C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqN-0002jB-3h; Fri, 28 Aug 2026 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqK-0002hv-UN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqJ-0000ga-27
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so7781015e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928365; x=1788533165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=JQiWw7NbiUearP3EXq27THpEbI7ce9HFIBKLl4oQS7BWLbCxx48vAfIVx7QmD05xL7
 I45NaaCEwVJrdqLKe6U50maSBdp3c4eV6VlUGU+hP963TYtiAopBjZr7s7/2nn+a2QAL
 Se0PLX1XliVRd1mPdP8EabwFXVmtm5s69mUp2ezr6gfOI0e9bptQymao7F20+oMKZC1o
 1I8cos8ogMJTCvBulluqfZn0aDcxQd/wKhReRUnsik0ZmbU/vfzmlVP6dwPHdyOF6rLB
 JEWHlGAqrEta6en+YEARmwzT7vGVIQ9oTgJ89rWV9wqo79cQY+Wn3SyWeM4w9EVlcmZV
 yH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928365; x=1788533165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K0kBd+JRwRmYuSzj9Gu1odey8tK1kya/yjE5FN2wYZ8=;
 b=gIfiHyxIByzp8AifPrxJHbld0KkGEV3YQgNwzIow23vLuyZG0jAacDHltvaeAFWW4J
 RtPhRzJJswSs1ofnlaEc/pmCaG5T7F6n+/kNhUnENRMuy1FanL8DHXfIQuF+1OWzjkYP
 tOWzHRBx6OEYKncnTQVQfPiJkQrQ9wFMOMSXEeGbqFiBD5bxvR+cQ9XdzmtE9G3cjrw7
 n6XOdvoBnqyMA10DWwUKWA+VUNIWQSEKEvSjHLTpgUkkZPJ49OrQDWjv/WwZqJznH+cj
 gqqvYzjwucC5q0mo4evz3Zht9UzzgWgL/R3yZQjJMzILQrWNt7dMK+e4UKWiJCog/T12
 HFOA==
X-Gm-Message-State: AFuF++mgffIbIUqAHK/z04+NLxVEdDGkTnF3MJWJYSkrfc3AuPZwJ2mY
 bWccB5AYFPkCo6vAhfO2gXQ1UpNs33jclIM2kb1BXi5xPwvrFWeLXCFABYPe+Oqn6Z0GXLzYFNb
 Xo/fh
X-Gm-Gg: AR+sD13pG377rYBIwKM9gGdoPz4FQp8HJ1oyENif5b90pRnAHRbkVT5QxkdA6Du5bw1
 ntbbYoBykOe/RgnD3ZLPlcO6PGlWk3E1fFGvQZS8hX8XMqdhhbTicCXv7vUqSmMqrbafiespbd8
 lyvIRAgcd5C5FQs1t06IJhbBh6v6M16s4GYyli0JGE2NhOVNgNXPt3xiYoy0qEiff0WlvfQKLgD
 HN6DlCWkGbpEUJuzjdkf67pKb/A5PClR1lm27e2dSwbZwPW2vQNL7w5aUNua31H30cwyOV4yA1D
 /KNMJ+zBobD/YMNXBSaqnNp48tr0nHiMdAxZBm7MBR3vhox16dN+SzEGaO4LRhIu0mWXoT8as0m
 y9BwBc2JeY627HPa5RS4tNoYm+R8uQfUguX34MMDeHWA/1uk76uA0Y45MYtl2tiYSVmusQMRZBi
 ceVD79niHX4zW3HJQf8kKOfBZ1vvbEeOT/DXIOoKaYDz22NysFWkt0i25VHQ==
X-Received: by 2002:a05:600c:19c8:b0:49b:c8e:a211 with SMTP id
 5b1f17b1804b1-49b91c20bfamr118453945e9.5.1787928365565; 
 Fri, 28 Aug 2026 07:46:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:04 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 6/9] block/block-copy: extract block_copy_set_task_method()
Date: Fri, 28 Aug 2026 16:45:51 +0200
Message-ID: <20260828144554.1741910-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
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


