Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AD0C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683l-0002pg-3g; Mon, 14 Sep 2026 10:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683J-0002cn-8D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:02 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683H-0005lw-DU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:00 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso20701955e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397577; x=1790002377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oWqwUVggYdA0tHiKmfstsBnPcdY+RLvUV4CZMwRpffs=;
 b=rfOPj7Ik0Wu38sL33b0d4+XgldJ0/qj6CzdZvdqgY6abTt+Y8Li4y768LcYNNMVmPL
 7ET53kdST9iOc1FWvz5OaR9+XBqW1VYMNKA4Cr+Y0GbCr3tv1D/AkF+Uxdc+chNbtRmr
 Gz1PZQ5VtxbRNTjLwpYxdcqk4ovhk/mVZSzcYi6W+Id+zxsIMC8edC+dlzhEzTpr0X+M
 il5nTKwGuzBI33ZZDlobpaozj41eP7r4azhRPsOdjzmMTx69cptc0/cQhUEW5orZiYqu
 38ye02P4nf2XBEl5N3kZVqX1cIYe01XZEoOvNcY1FCFYR89uMrKCBVzTiMwVOfcpmBx8
 yfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397578; x=1790002378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oWqwUVggYdA0tHiKmfstsBnPcdY+RLvUV4CZMwRpffs=;
 b=KZ9CdAgrDina8aR1/6kVoi4JX1sLvY3X+nABwXK6KqIHehzf3HRXUxJWsHGIBt4f11
 gbXsp7XWEzFWFchdAZZol3LdoQOZfax+v+EWFQ+6uMnEbL4xn8hZw9thnCcgNdLVlACe
 A8owmch343qg6f5hRVm97siw4yiNh+lU0+xLx09y0capjIrsW4gBTZz3sTQ6qK4jrgwU
 m5VG35oUvRw2DNduCu2IDcdMebp4UmIv5Y7ka2sdz9hNryPvFXhPI6sRrfR1Y6LAqh80
 YM2loLyWKrOv6bRufwPTUWtR94Aj1RUxJboycCg8r+UTy8ulnfrejpYrUwCdhY1oc0X0
 ZcXw==
X-Gm-Message-State: AFuF++k66qqC86l3A3ZCJ2yVf07Wuc6JbZN58VT02H3f72KQ7D2Rz6pA
 D8gXLHVeqfQR32tw0l2znNYYppSZhz0xJkY/5jWNZDBVkeb41aI+vEK7hw8a2z85M8wYrn1somc
 Onc5i
X-Gm-Gg: AYBFou1wW2Ad8YgqI1AhVEbxzwYTmvVoDNnDMLN/9rFjJ2SgHWVyMwVlz00wqOyGHny
 lMTbHkpHYJAGFA9foGZLG2cCLIkhnHrf64o9kxcY0onub7FwnSnACKfQ5RbPoL+xDyFlPenKB32
 YFe42gs95+MZshT0i2/8JaFCvqtBJ1MTgNGglYlx4ZHwl6aYc3WLMM92fCIdEfFTynTVgUdrnes
 /FrHbzYyno5NZgeBEJsCLU9dy0BFc4lZn3QGL89E3QQ5HrugR+P5Tjr2mLTc2jQfOkC+KJWPE5x
 S571Rkc9zZ3ijb5TXsSrir1aOYcqopf4XAHVh86o2jjPT2VpqN/Tq5hnerQ3s8QMXI6Jqp25lMT
 hg6VW5TcQ7R9Ik49+vIETlo6sByviJ0RVfitIcb6ctUrQ9NMJRuI3EKa+18696cStQtVWE0CcwK
 zLyoVJZzHHvWKRwXFOHAOQIJCC28kjGsctBJJa6RsomiKA6YfE8fQawcF25b6TRVwzRyiK
X-Received: by 2002:a05:600c:3ba7:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49e7a68698bmr45580575e9.16.1789397577617; 
 Mon, 14 Sep 2026 07:52:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:52:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 3/9] block/commit: batch block-status queries
Date: Mon, 14 Sep 2026 16:52:44 +0200
Message-ID: <20260914145250.2792879-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
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

commit_iteration() asks for block status COMMIT_BUFFER_SIZE (512K) at a
time, so a long run above base pays one query per 512K for an answer
the whole run shares.

Query the remainder of the image instead and keep the answer in a
CommitStatus owned by commit_run(). Nothing can write top above
base_overlay while the job runs: BLK_PERM_CONSISTENT_READ is shared
only from filtered_base downwards, and the job writes below
base_overlay.

Copying is still bounded by the read buffer. Zeroes need no buffer, so
COMMIT_ZERO_CHUNK bounds them, keeping a cancel from waiting on a huge
write-zeroes, and an unallocated span is crossed in one step.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/commit.c | 58 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4e0b0f9029..e8ddd46053 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -31,8 +31,23 @@ enum {
      * contiguous regions of the image is efficient.
      */
     COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
+
+    /*
+     * Zeroes need no buffer, so they are bounded by this instead. It stays
+     * well under BDRV_REQUEST_MAX_BYTES and keeps a cancel from waiting on
+     * a multi-gigabyte write.
+     */
+    COMMIT_ZERO_CHUNK = 256 * 1024 * 1024, /* in bytes */
 };
 
+/* Last block-status answer, covering [offset, end). Empty when equal. */
+typedef struct CommitStatus {
+    int64_t len;
+    int64_t offset;
+    int64_t end;
+    int ret;
+} CommitStatus;
+
 typedef struct CommitBlockJob {
     BlockJob common;
     BlockDriverState *commit_top_bs;
@@ -130,26 +145,45 @@ static void commit_clean(Job *job)
 
 static int coroutine_fn
 commit_iteration(CommitBlockJob *s, int64_t offset,
-                 int64_t *requested_bytes, void *buf)
+                 int64_t *requested_bytes, void *buf, CommitStatus *st)
 {
     BlockErrorAction action;
-    int64_t bytes = *requested_bytes;
+    int64_t bytes;
     int ret = 0;
     bool error_in_source = true;
 
-    /* Copy if allocated above the base */
-    WITH_GRAPH_RDLOCK_GUARD() {
-        ret = bdrv_co_common_block_status_above(blk_bs(s->top),
-            s->base_overlay, true, BDRV_WANT_PRECISE, offset,
-            COMMIT_BUFFER_SIZE, &bytes, NULL, NULL, NULL);
+    assert(offset >= st->offset);
+
+    if (offset >= st->end) {
+        /* Copy if allocated above the base */
+        WITH_GRAPH_RDLOCK_GUARD() {
+            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
+                s->base_overlay, true, BDRV_WANT_PRECISE, offset,
+                st->len - offset, &bytes, NULL, NULL, NULL);
+        }
+
+        if (ret < 0) {
+            trace_commit_one_iteration(s, offset, 0, ret);
+            goto fail;
+        }
+
+        st->offset = offset;
+        st->end = offset + bytes;
+        st->ret = ret;
     }
 
-    trace_commit_one_iteration(s, offset, bytes, ret);
+    ret = st->ret;
+    bytes = st->end - offset;
 
-    if (ret < 0) {
-        goto fail;
+    /* An unallocated span costs no I/O, so it is crossed in one step. */
+    if (ret & BDRV_BLOCK_ZERO) {
+        bytes = MIN(bytes, COMMIT_ZERO_CHUNK);
+    } else if (ret & BDRV_BLOCK_ALLOCATED) {
+        bytes = MIN(bytes, COMMIT_BUFFER_SIZE);
     }
 
+    trace_commit_one_iteration(s, offset, bytes, ret);
+
     if (ret & BDRV_BLOCK_ALLOCATED) {
         if (ret & BDRV_BLOCK_ZERO) {
             /*
@@ -215,6 +249,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
     int64_t len, base_len;
+    CommitStatus st = { 0 };
 
     len = blk_co_getlength(s->top);
     if (len < 0) {
@@ -235,6 +270,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     }
 
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
+    st.len = len;
 
     for (offset = 0; offset < len; offset += n) {
         /* Note that even when no rate limit is applied we need to yield
@@ -245,7 +281,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
 
-        ret = commit_iteration(s, offset, &n, buf);
+        ret = commit_iteration(s, offset, &n, buf, &st);
 
         if (ret < 0) {
             return ret;
-- 
2.53.0


