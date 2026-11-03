Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC46606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R/LDRDbJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cV-0006Ri-38; Mon, 02 Nov 2026 22:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cS-0006Q8-5B
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cQ-0000bd-FS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbDOZMrnoovdgvZbU+ME7GmL1tQpLGQ3Ex+2H8vLRJ4=;
 b=R/LDRDbJuGGXTwksgYuoQhFP3BsEGBIwpegCW3kUM0hE8wfBnbTJTbzIcm3cFiP1IiIl87
 IFe0HX+7eSJhXFkLmZyggzK2bJ61l98fiG477u6O1AxqJFRmQoog2c4asXkwvecPRSaiIT
 nDWn8JqI+JMl8EjMBCzuF/K7FScALmo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-6uKHZtofMLCWNr2ZV2eC3g-1; Mon,
 02 Nov 2026 22:55:26 -0500
X-MC-Unique: 6uKHZtofMLCWNr2ZV2eC3g-1
X-Mimecast-MFC-AGG-ID: 6uKHZtofMLCWNr2ZV2eC3g_1793678125
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45E9A195605A; Tue,  3 Nov 2026 03:55:25 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7B3F7E2; Tue,  3 Nov 2026 03:55:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 07/16] block/commit: batch block-status queries
Date: Mon,  2 Nov 2026 21:54:18 -0600
Message-ID: <20261103035506.2688772-25-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-4-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/commit.c | 60 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 4e0b0f9029b..e8ddd460534 100644
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
+    }
+
+    ret = st->ret;
+    bytes = st->end - offset;
+
+    /* An unallocated span costs no I/O, so it is crossed in one step. */
+    if (ret & BDRV_BLOCK_ZERO) {
+        bytes = MIN(bytes, COMMIT_ZERO_CHUNK);
+    } else if (ret & BDRV_BLOCK_ALLOCATED) {
+        bytes = MIN(bytes, COMMIT_BUFFER_SIZE);
     }

     trace_commit_one_iteration(s, offset, bytes, ret);

-    if (ret < 0) {
-        goto fail;
-    }
-
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
2.56.0


