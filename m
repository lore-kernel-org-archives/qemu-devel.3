Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B3CCEE342
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6x-00005b-6h; Tue, 18 Nov 2025 12:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6u-0008Ut-Vs
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6t-0004j7-Aw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BoVAI3DNADf87T1Nn/o5IlvAFQmrRR/j4uz+LlarMK8=;
 b=FejO6JO9E4Wt5X1X1ewXnANxGPkFIKQwpazMYbTXGQ8ABQ5I9tS7YDGJyhgkMt9rAfZxed
 P0eNidK1lTKMDIp1jfL/mevrQsxM4JRRO9f7aDuoQqp6NINIMZ/VgAWZf+9jVlctkGJc/K
 jrlP5Cc/5ZTjGcvr4yTgMgt/R8EMo40=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-U1WFyAmUNKWCCISDpaKiSg-1; Tue,
 18 Nov 2025 12:03:14 -0500
X-MC-Unique: U1WFyAmUNKWCCISDpaKiSg-1
X-Mimecast-MFC-AGG-ID: U1WFyAmUNKWCCISDpaKiSg_1763485393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B295191B4C1; Tue, 18 Nov 2025 17:03:13 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01CC8300A88D; Tue, 18 Nov 2025 17:03:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/19] =?UTF-8?q?nfs:=20Run=20co=20BH=20CB=20in=20the=20cor?=
 =?UTF-8?q?outine=E2=80=99s=20AioContext?=
Date: Tue, 18 Nov 2025 18:02:41 +0100
Message-ID: <20251118170256.272087-5-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Like in “rbd: Run co BH CB in the coroutine’s AioContext”, drop the
completion flag, yield exactly once, and run the BH in the coroutine’s
AioContext.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (!task.complete)` loops.)

Like in “iscsi: Run co BH CB in the coroutine’s AioContext”, this makes
nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
calling aio_co_wake() directly.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-5-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nfs.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0a7d38db09..1d3a34a30c 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -69,7 +69,6 @@ typedef struct NFSClient {
 typedef struct NFSRPC {
     BlockDriverState *bs;
     int ret;
-    int complete;
     QEMUIOVector *iov;
     struct stat *st;
     Coroutine *co;
@@ -230,14 +229,6 @@ static void coroutine_fn nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
     };
 }
 
-static void nfs_co_generic_bh_cb(void *opaque)
-{
-    NFSRPC *task = opaque;
-
-    task->complete = 1;
-    aio_co_wake(task->co);
-}
-
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
@@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+
+    /*
+     * Safe to call: nfs_service(), which called us, is only run from the FD
+     * handlers, never from the request coroutine.  The request coroutine in
+     * turn will yield unconditionally.
+     * No need to release the lock, even if we directly enter the coroutine, as
+     * the lock is never re-taken after yielding.  (Note: If we do enter the
+     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
+     */
+    aio_co_wake(task->co);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -278,9 +277,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (task.ret < 0) {
         return task.ret;
@@ -328,9 +325,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (my_buffer) {
         g_free(buf);
@@ -358,9 +353,7 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return task.ret;
 }
@@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+    /* Safe to call, see nfs_co_generic_cb() */
+    aio_co_wake(task->co);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
@@ -748,9 +741,7 @@ static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
-- 
2.51.1


