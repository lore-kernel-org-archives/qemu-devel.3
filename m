Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D476C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublSS-0008Ay-D0; Tue, 15 Jul 2025 15:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxI-0004AI-KP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxG-0001QK-Ni
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwt5Mohty/49Ops6zWjl3ddGYpwcfvV3jj65uyvQ3wQ=;
 b=c4j9g7z4ECbH41oKZpGVN15x6+gCSnQVlr4XSSeNmgILGvZZPfS9Ez4GGhlBi51WQOJmWD
 v5veAi+87N4XazSCaogpaD7QVEyqNGfF4ZiEeOCrudnre3gxqdrfhwyZkgMN5X9satyvUC
 ASaPRrySNnjOGI6IB8jkN8ZLLv7stSc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-91uSZhf0N5-xU644URNtvQ-1; Tue,
 15 Jul 2025 15:04:39 -0400
X-MC-Unique: 91uSZhf0N5-xU644URNtvQ-1
X-Mimecast-MFC-AGG-ID: 91uSZhf0N5-xU644URNtvQ_1752606279
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB54D19560B2; Tue, 15 Jul 2025 19:04:38 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35C7C197702B; Tue, 15 Jul 2025 19:04:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 29/57] file-posix: Fix aio=threads performance regression after
 enablign FUA
Date: Tue, 15 Jul 2025 21:03:02 +0200
Message-ID: <20250715190330.378764-30-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For aio=threads, we're currently not implementing REQ_FUA in any useful
way, but just do a separate raw_co_flush_to_disk() call. This changes
behaviour compared to the old state, which used bdrv_co_flush() with its
optimisations. As a quick fix, call bdrv_co_flush() again like before.
Eventually, we can use pwritev2() to make use of RWF_DSYNC if available,
but we'll still have to keep this code path as a fallback, so this fix
is required either way.

While the fix itself is a one-liner, some new graph locking annotations
are needed to convince TSA that the locking is correct.

Cc: qemu-stable@nongnu.org
Fixes: 984a32f17e8d ("file-posix: Support FUA writes")
Buglink: https://issues.redhat.com/browse/RHEL-96854
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250625085019.27735-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9b5f08ccb2..8c738674ce 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2564,9 +2564,9 @@ static inline bool raw_check_linux_aio(BDRVRawState *s)
 }
 #endif
 
-static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
-                                   uint64_t bytes, QEMUIOVector *qiov, int type,
-                                   int flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
+           QEMUIOVector *qiov, int type, int flags)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
@@ -2625,7 +2625,7 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
     if (ret == 0 && (flags & BDRV_REQ_FUA)) {
         /* TODO Use pwritev2() instead if it's available */
-        ret = raw_co_flush_to_disk(bs);
+        ret = bdrv_co_flush(bs);
     }
     goto out; /* Avoid the compiler err of unused label */
 
@@ -2660,16 +2660,16 @@ out:
     return ret;
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
-                                      int64_t bytes, QEMUIOVector *qiov,
-                                      BdrvRequestFlags flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ, flags);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
-                                       int64_t bytes, QEMUIOVector *qiov,
-                                       BdrvRequestFlags flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE, flags);
 }
@@ -3606,10 +3606,11 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
 #endif
 
 #if defined(CONFIG_BLKZONED)
-static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
-                                           int64_t *offset,
-                                           QEMUIOVector *qiov,
-                                           BdrvRequestFlags flags) {
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_zone_append(BlockDriverState *bs,
+                   int64_t *offset,
+                   QEMUIOVector *qiov,
+                   BdrvRequestFlags flags) {
     assert(flags == 0);
     int64_t zone_size_mask = bs->bl.zone_size - 1;
     int64_t iov_len = 0;
-- 
2.50.1


