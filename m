Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B61E112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0POL-0006fo-NZ; Wed, 11 Mar 2026 15:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POJ-0006S8-8H; Wed, 11 Mar 2026 15:38:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POH-0000aM-25; Wed, 11 Mar 2026 15:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257669; bh=xvgjrtvfJYd0ggRcn57FNea3wevtXiKb9K1bOQPoMLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hhpMhW5a1BIPPyyr1r4pu7S9i8HTDkE26BDBRb/p51LaU3I25cystDekPoilhXI5X
 yDMa621sb/QLWpChqiiOrViqy+aNoRa3L37+OrXbGOf9DemO4bgTFC79R8BK+5yBNL
 /HUCIM/TYix+p6HgalTsEnytIRx9waQqu3BPwyQL1E8Tn/tZWHIIvHEA7U/zHpV4wX
 EioXDu3/BIJMq/c1aIbujYvyqwdF7D/0ocUW7oPLYbBJTqxPzC4+h/giXj1R/0TPop
 cSmQItVdKAzQTmnP0uCWpQJ820XSxMccGyl4JEln7js4sZnyj+3k9OsNKxcGIypa7g
 In5bqmgtr11XQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8035E192110;
 Wed, 11 Mar 2026 22:34:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2A9C37C475;
 Wed, 11 Mar 2026 22:35:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 40/53] block/nfs: Do not enter coroutine from CB
Date: Wed, 11 Mar 2026 22:34:33 +0300
Message-ID: <20260311193449.1096110-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

The reasoning I gave for why it would be safe to call aio_co_wake()
despite holding the mutex was wrong: It is true that the current request
will not re-acquire the mutex, but a subsequent request in the same
coroutine can.  Because the mutex is a non-coroutine mutex, this will
result in a deadlock.

Therefore, we must either not enter the coroutine here (only scheduling
it), or release the mutex around aio_co_wake().  I opt for the former,
as it is the behavior prior to the offending commit, and so seems safe
to do.

Fixes: deb35c129b859b9bec70fd42f856a0b7c1dc6e61
       ("nfs: Run co BH CB in the coroutine’s AioContext")
Buglink: https://gitlab.com/qemu-project/qemu/-/issues/2622#note_2965097035
Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260102153246.154207-1-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 1d6610099bd7fc159626a38e60a3c84343ff67f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nfs.c b/block/nfs.c
index 1d3a34a30c..b78f4f86e8 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -249,14 +249,15 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     }
 
     /*
-     * Safe to call: nfs_service(), which called us, is only run from the FD
-     * handlers, never from the request coroutine.  The request coroutine in
-     * turn will yield unconditionally.
-     * No need to release the lock, even if we directly enter the coroutine, as
-     * the lock is never re-taken after yielding.  (Note: If we do enter the
-     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
+     * Using aio_co_wake() here could re-enter the coroutine directly, while we
+     * still hold the mutex.  The current request will not attempt to re-take
+     * the mutex, so that is fine; but if the same coroutine then goes on to
+     * submit another request, that new request will try to re-take the mutex,
+     * resulting in a deadlock.
+     * To prevent that, only schedule the coroutine so it will be entered later,
+     * with the mutex released.
      */
-    aio_co_wake(task->co);
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -716,8 +717,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    /* Safe to call, see nfs_co_generic_cb() */
-    aio_co_wake(task->co);
+    /* Must not use aio_co_wake(), see nfs_co_generic_cb() */
+    aio_co_schedule(qemu_coroutine_get_aio_context(task->co), task->co);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
-- 
2.47.3


