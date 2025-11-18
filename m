Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09913CEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6z-00007y-L2; Tue, 18 Nov 2025 12:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6y-00006K-4o
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6w-0004kq-Jo
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHOyMeTMkv0bBJ7VSOAkT9JMHYRF2luZGQ4T+T0m6SY=;
 b=D1Rz6z6akwLqWIO4KDG5cADmJIsXgnI3hDLhs1nCgI5eTFEffDVuW5HF/lkNIyVWiQWbHk
 vSBaqLMWyjle5BemUfcTKJ4GlMx01zOnckOcMcp0nVaPefEdz1PIEi84wemjEfptBpWRwx
 +jpj/VY6+ZVMAVdoKZF3pGkC2ucBxDg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-5LYtJk0vMsC6Bd4J59DI1Q-1; Tue,
 18 Nov 2025 12:03:18 -0500
X-MC-Unique: 5LYtJk0vMsC6Bd4J59DI1Q-1
X-Mimecast-MFC-AGG-ID: 5LYtJk0vMsC6Bd4J59DI1Q_1763485397
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB7A9191B4C5; Tue, 18 Nov 2025 17:03:17 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C1D9300A88D; Tue, 18 Nov 2025 17:03:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/19] gluster: Do not move coroutine into BDS context
Date: Tue, 18 Nov 2025 18:02:43 +0100
Message-ID: <20251118170256.272087-7-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

The request coroutine may not run in the BDS AioContext.  We should wake
it in its own context, not move it.

With that, we can remove GlusterAIOCB.aio_context.

Also add a comment why aio_co_schedule() is safe to use in this way.

**Note:** Due to a lack of a gluster set-up, I have not tested this
commit.  It seemed safe enough to send anyway, just maybe not to
qemu-stable.  To be clear, I don’t know of any user-visible bugs that
would arise from the state without this patch; the request coroutine is
moved into the main BDS AioContext, so guest device completion code will
run in a different context than where the request started, which can’t
be good, but I haven’t actually confirmed any bugs (due to not being
able to test it).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-7-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 89abd40f31..4fb25b2c6d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -56,7 +56,6 @@ typedef struct GlusterAIOCB {
     int64_t size;
     int ret;
     Coroutine *coroutine;
-    AioContext *aio_context;
 } GlusterAIOCB;
 
 typedef struct BDRVGlusterState {
@@ -743,7 +742,17 @@ static void gluster_finish_aiocb(struct glfs_fd *fd, ssize_t ret,
         acb->ret = -EIO; /* Partial read/write - fail it */
     }
 
-    aio_co_schedule(acb->aio_context, acb->coroutine);
+    /*
+     * Safe to call: The coroutine will yield exactly once awaiting this
+     * scheduling, and the context is its own context, so it will be scheduled
+     * once it does yield.
+     *
+     * (aio_co_wake() would call qemu_get_current_aio_context() to check whether
+     * we are in the same context, but we are not in a qemu thread, so we cannot
+     * do that.  Use aio_co_schedule() directly.)
+     */
+    aio_co_schedule(qemu_coroutine_get_aio_context(acb->coroutine),
+                    acb->coroutine);
 }
 
 static void qemu_gluster_parse_flags(int bdrv_flags, int *open_flags)
@@ -1006,7 +1015,6 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
     acb.size = bytes;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_zerofill_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
@@ -1184,7 +1192,6 @@ static coroutine_fn int qemu_gluster_co_rw(BlockDriverState *bs,
     acb.size = size;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     if (write) {
         ret = glfs_pwritev_async(s->fd, qiov->iov, qiov->niov, offset, 0,
@@ -1251,7 +1258,6 @@ static coroutine_fn int qemu_gluster_co_flush_to_disk(BlockDriverState *bs)
     acb.size = 0;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_fsync_async(s->fd, gluster_finish_aiocb, &acb);
     if (ret < 0) {
@@ -1299,7 +1305,6 @@ static coroutine_fn int qemu_gluster_co_pdiscard(BlockDriverState *bs,
     acb.size = 0;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
-    acb.aio_context = bdrv_get_aio_context(bs);
 
     ret = glfs_discard_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
-- 
2.51.1


