Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49DC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqJ-0002gP-57; Fri, 28 Aug 2026 10:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqH-0002ec-1d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqF-0000eW-7h
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so9526075e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928362; x=1788533162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JAXlrjXZ6Fm9mPDZhDxHdudSyY1vaCDPY6fIxYTWzCs=;
 b=ZOaLYiITwSh0X94h/00WWPm+F3MhEcLxsj1DpOlP+w/5typzvFJOnmbJbUo2SfXebr
 ZCN3fYy7EUzHIIhXcJzvcgAV5qPzhA1mv65U4AYA5HDZ0uW5t8+M5FHFwWGNDx5ei/iu
 gwzXJtV+NdLS3CUui9hIH5X9b6F5iY7Nyyc012X8hepsJYtp5lH5rCjlnGkX6YxF4pSw
 h/KDQ0ugc0dOmwLfT2AUyjF+UlwZfozwfgl+4BPg3QwqzZuhwAEAdLmJgOzy/WOmPaDA
 vbaW8WZgTsAQWCP4wPJVTgsijr9z+F74bi5rjIpu393Un7Dyh0XUFxxxnZtgWq+HU2Jf
 aODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928362; x=1788533162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JAXlrjXZ6Fm9mPDZhDxHdudSyY1vaCDPY6fIxYTWzCs=;
 b=SNlkv4QI08VHvoI879jHlj9gK87jYXIq7D5L2AvdM5Oeq3Q7Gt0GYbdiaZAZtnYvT+
 uRSQ91sLvzXrvzjPbTYr0GXnUYMgF2ykQXTe0aRqHK8cEi5sa4CWxDB6jp+ub5Fxq56J
 kBc4eRWp30AnWeXHSIx7YrlTd0rhyW5jtal3G+VVZq/VbgeiIenZVeNpYbxF87AJBTkU
 OojMCUzV/j0uYllBcXIRe9AgqCj5lEaaiz85ni+qEnB0B+Di4fw0t23cPNe7NjKNxjJH
 0frvD47qfFT1tA3ZK3+vECXtLQrkJ9BLoIYRddZpny5WIHZf5Ntzw6dAhu7d1z7zEzHE
 DV1g==
X-Gm-Message-State: AFuF++nPicO+sEqCYOxAQ93jhFmaCXWzmvQ9Eic2SnHT+3tViit7rggv
 sVzKIlL4Oy0DOvxUtAmwdyiCWOPKkGDsJ6I+I+wR991G/o8BHDRUNCTYk103Nb36g5s3zRLky85
 6JBkW
X-Gm-Gg: AR+sD12qzny3yXKu7bD7vEPRjzEd6pCc63mnqyOk8/Z501THa6uaujUojsSSeay0jgD
 idnvUw8snt2h14TZHq68wVsFrTxB1ANHefSKBw/Ayp5fxG58M5J4XzQNXHPoMWxCMWdYNkyiSU2
 bQ2fnCM+RobJ9BEvlngE0ukCFkqfYONdEeSt9BCGfsj/DXge8JphcCGbsjUXE9w7sVTFhquWx1j
 etVJhSBnIQwTzOqdMbwrzXR5Nhb3PhRWDaKmA5nFZajlY5ghK/iEKRp/B3Y9aEYAunjAXiZrMSQ
 odNblgNUxkrF8dUPJ0g8MbT77KygmEFmmVJb/myeyja4whQrzIg1cpnsVcFqm0WCL7Li8Uk59+x
 ivO6psl6v9kLBBhNx/A1TGRITQ3T9ezS1d2rqdqbeQs66MldyZWICjfXpUEctujpZUmI3byzp4Y
 xCtKtVaQd4l1JtscHIt09+cIjdhhcCIw9AbWBV7kseYCU4mfR4OxFpWwM2+A==
X-Received: by 2002:a05:600c:a48:b0:499:9eb8:a1d7 with SMTP id
 5b1f17b1804b1-49b91c3b7b6mr93831295e9.9.1787928361703; 
 Fri, 28 Aug 2026 07:46:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 3/9] block/commit: batch block-status queries
Date: Fri, 28 Aug 2026 16:45:48 +0200
Message-ID: <20260828144554.1741910-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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
 block/commit.c | 50 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4e0b0f9029..5aa3df31e1 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -31,8 +31,17 @@ enum {
      * contiguous regions of the image is efficient.
      */
     COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
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
@@ -130,26 +139,43 @@ static void commit_clean(Job *job)
 
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
+    if (offset < st->offset || offset >= st->end) {
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
@@ -215,6 +241,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
     int64_t len, base_len;
+    CommitStatus st = { 0 };
 
     len = blk_co_getlength(s->top);
     if (len < 0) {
@@ -235,6 +262,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     }
 
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
+    st.len = len;
 
     for (offset = 0; offset < len; offset += n) {
         /* Note that even when no rate limit is applied we need to yield
@@ -245,7 +273,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
 
-        ret = commit_iteration(s, offset, &n, buf);
+        ret = commit_iteration(s, offset, &n, buf, &st);
 
         if (ret < 0) {
             return ret;
-- 
2.53.0


