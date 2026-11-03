Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43619606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OW+xuzii
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cW-0006SK-2s; Mon, 02 Nov 2026 22:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cT-0006RC-QU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cS-0000c3-15
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncwx/OzxZmxb0/5gzr8OFxCr+ZcPkRp5UOQTMmNAzHw=;
 b=OW+xuziicYYXee+du4yMTs1NO+Gbc68TSSdJCvGcLc2TpZahn29ROqx719xHqAUN0x5mTX
 V97bkNYfJ3FGdvOEJkd38EwTsS3eG9f0qprhjzisie1CjvMz1pSTKkMEKGmNn9RhQAmNVt
 j5vZzjAGeUa6oZzRZiZanTXipXlHTd4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-Lm9XEGnyN6CCEnO87SrT8w-1; Mon,
 02 Nov 2026 22:55:30 -0500
X-MC-Unique: Lm9XEGnyN6CCEnO87SrT8w-1
X-Mimecast-MFC-AGG-ID: Lm9XEGnyN6CCEnO87SrT8w_1793678129
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 110C718007EB; Tue,  3 Nov 2026 03:55:29 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 89F6E7E2; Tue,  3 Nov 2026 03:55:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 09/16] block/block-copy: extract block_copy_set_task_method()
Date: Mon,  2 Nov 2026 21:54:20 -0600
Message-ID: <20261103035506.2688772-27-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the per-task block-status query and its skip_unallocated and
BDRV_BLOCK_ZERO handling out of block_copy_dirty_clusters() into
block_copy_set_task_method(). No behavior change. The next patch
changes that decision, and having it in one place keeps that change to
just the new logic.

The block-status result no longer lands in the caller's @ret, so drop
the note saying @ret may be positive at the out: label.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-6-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/block-copy.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 1826c2e1c7b..33c43cdf929 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -736,6 +736,35 @@ int64_t coroutine_fn block_copy_reset_unallocated(BlockCopyState *s,
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
@@ -768,7 +797,6 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
     while (bytes && aio_task_pool_status(aio) == 0 &&
            !qatomic_read(&call_state->cancelled)) {
         BlockCopyTask *task;
-        int64_t status_bytes;

         task = block_copy_task_create(s, call_state, offset, bytes);
         if (!task) {
@@ -782,24 +810,12 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)

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
@@ -840,8 +856,6 @@ out:
          * block_copy_task_run. If it fails, it means some task already failed
          * for real reason, let's return first failure.
          * Still, assert that we don't rewrite failure by success.
-         *
-         * Note: ret may be positive here because of block-status result.
          */
         assert(ret >= 0 || aio_task_pool_status(aio) < 0);
         ret = aio_task_pool_status(aio);
-- 
2.56.0


