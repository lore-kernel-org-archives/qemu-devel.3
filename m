Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B99CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdPU-0002nG-IZ; Fri, 21 Nov 2025 21:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdPR-0002iB-22; Fri, 21 Nov 2025 21:31:33 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdOj-0007yE-SI; Fri, 21 Nov 2025 21:31:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B6A816C719;
 Fri, 21 Nov 2025 16:51:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4A973219B5;
 Fri, 21 Nov 2025 16:52:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 64/76] =?UTF-8?q?nfs:=20Run=20co=20BH=20CB=20in=20?=
 =?UTF-8?q?the=20coroutine=E2=80=99s=20AioContext?=
Date: Fri, 21 Nov 2025 16:51:42 +0300
Message-ID: <20251121135201.1114964-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
(cherry picked from commit deb35c129b859b9bec70fd42f856a0b7c1dc6e61)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


