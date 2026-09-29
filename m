Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6645CCA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7P-0005rK-BK; Tue, 29 Sep 2026 11:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7H-0005mT-JE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:40 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7F-0001RF-0h
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:38 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso2751109f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697095; x=1791301895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lFAcWnrWi60JYEjwn6l8H/drw/Jr0F8dV3g2fTSKPqM=;
 b=hIc6WSSC8x6U2V/ozGyjq8NHrca3JSiuM/FutMg2EXrVMTovfbrrDl1/JBmGejHEnt
 u9LfEgJojLiD6dmKr4q0YhRq4siY5G39MeJOZQDGrfdEKjl6GSToKS9Ugbv9mBsJOQZX
 hFWibaawN4KBIW51ioo+GczDfZXoF8PUpXA6ZYmvqNDJLbcqJhlyjCao4EProim4hFX+
 ms4F+5tLvDnouvGT5m4DeNU20u2j9SEnxv/8LKUza3DPTXInN0XouASb60ofoPcDAM5l
 NpEQa2wrPqYMQrKVAUEhH467r6Yuxo3fVXUGK/ka7D/P9Ytv2JB52m6ZhEmXqEEci48G
 vJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697095; x=1791301895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lFAcWnrWi60JYEjwn6l8H/drw/Jr0F8dV3g2fTSKPqM=;
 b=y8i9Ac7+mSgd4CgATFXpHqDZUsun3PRAXrAkMO5R/AsDYwatFALdLLTLlVdO3/vcwV
 E8VCY3+uVQ6IhdJaEw385sUJq9yF4mtnx3uQhaEmsmVsHQ4UgyxXPelUXDNU8+WlwREs
 pXLgRVXGP4qipPkU/AHD/WNblCCB0tW3Y9VdZsVz2/Fj2xuDQAZWDZ9NjfuDAENnZCG8
 KeglzxL+cOKd2llNIjvLSK/KcI/p+gtS69kDaDOYfVXjqcloyOb7oGaKUxYfqj2I4y0L
 YzotGQZDL6GMC0601yMhCqdE9oB1D1dBkX9KfTanVWopBmhvaAesIDyF0g6A+594dN8W
 Jrdw==
X-Gm-Message-State: AFq9FYLru+r+FgZW5bamQunyTCtxNnyxPCP/s4TN/CW95bRKvSWXDumv
 cL+9wc1vEQx9zvmLlJDkr8SR+/UIY8VMjZcBqxt/59pSiQhjyZtagRcv1x6U3YjSPFNfS9M9cKf
 kzOHE
X-Gm-Gg: AYBFou2JFOkQHk//Ap/QBGhoCfuwV/r+PxrNI/rn2uM3cddQMQqn31PnM0YJkNbZUs4
 /mbTxjnsjQ0qB4Sn9IgzLlScsLoZe40kEMWrAL6BzXIZN4yqU7ddUmie8Mz0iNyp5sPD+YEQhbd
 EeLp6KNk8861D/eaEreu8CKsP0OrOxTKZPMcVceF4Rcm3dmq0NPkwyVFQULhme/ff7n7Eql5Rg/
 /31byMA5tBzSPlVLIggWS5ipaR9KGBjquCmRRAlLTpmqIe0YttpHevTm2jhEpxZKVUYa6M1OZ6g
 M7iW+JR2c0vTf16Eiyu4FElQYv5jk5niJn0zoxhOx8kuW89YLRsOcoCE09Z+Q/MyRE+sznqKvrR
 gQkk4+9qbWgDb3cTN3ctvX8/SPdUeKObFkUcAKfPwoIgaPcr5SLAYe9Eo6sSEjE1ZQ3Nt3dxx/q
 Z7RMTiyM7GcWnPF2fH/drixxXaPpJqmQ0MvJdectcPui+Bt3KUAf9LeZZWXw==
X-Received: by 2002:a05:6000:4a04:b0:487:aa6:c90d with SMTP id
 ffacd0b85a97d-4887d9fa6e6mr23686461f8f.1.1790697095528; 
 Tue, 29 Sep 2026 08:51:35 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 3/9] block/commit: batch block-status queries
Date: Tue, 29 Sep 2026 17:51:19 +0200
Message-ID: <20260929155125.3151111-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f; envelope-from=den@openvz.org;
 helo=mail-wr2-x0f.google.com
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
CommitStatus owned by commit_run(). No device or export writes top
above base_overlay while the job runs: they ask for
BLK_PERM_CONSISTENT_READ along with BLK_PERM_WRITE, and the job
withholds CONSISTENT_READ there, having to share WRITE or it would
block its own writes to base through the backing chain. A job target
asks for WRITE alone and is refused by the op blocker instead. From
filtered_base downwards CONSISTENT_READ is shared again, and there only
the job writes.

Copying is still bounded by the read buffer. Zeroes need no buffer, so
COMMIT_ZERO_CHUNK bounds them, keeping a cancel from waiting on a huge
write-zeroes, and an unallocated span is crossed in one step.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
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


