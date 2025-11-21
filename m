Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEAACFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdcR-00073H-JH; Fri, 21 Nov 2025 21:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdZw-0004p2-S0; Fri, 21 Nov 2025 21:42:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdYs-0002z1-JE; Fri, 21 Nov 2025 21:42:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B228916C71D;
 Fri, 21 Nov 2025 16:51:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 153EB3219B9;
 Fri, 21 Nov 2025 16:52:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 68/76] block/io: Take reqs_lock for tracked_requests
Date: Fri, 21 Nov 2025 16:51:46 +0300
Message-ID: <20251121135201.1114964-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
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

bdrv_co_get_self_request() does not take a lock around iterating through
bs->tracked_requests.  With multiqueue, it may thus iterate over a list
that is in the process of being modified, producing an assertion
failure:

../block/file-posix.c:3702: raw_do_pwrite_zeroes: Assertion `req' failed.

[0] abort() at /lib64/libc.so.6
[1] __assert_fail_base.cold() at /lib64/libc.so.6
[2] raw_do_pwrite_zeroes() at ../block/file-posix.c:3702
[3] bdrv_co_do_pwrite_zeroes() at ../block/io.c:1910
[4] bdrv_aligned_pwritev() at ../block/io.c:2109
[5] bdrv_co_do_zero_pwritev() at ../block/io.c:2192
[6] bdrv_co_pwritev_part() at ../block/io.c:2292
[7] bdrv_co_pwritev() at ../block/io.c:2225
[8] handle_alloc_space() at ../block/qcow2.c:2573
[9] qcow2_co_pwritev_task() at ../block/qcow2.c:2625

Fix this by taking reqs_lock.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-11-hreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 9b9ee60c07f52009f9bb659f54c42afae95c1d94)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index 9bd8ba8431..37df1e0253 100644
--- a/block/io.c
+++ b/block/io.c
@@ -721,11 +721,14 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
     Coroutine *self = qemu_coroutine_self();
     IO_CODE();
 
+    qemu_mutex_lock(&bs->reqs_lock);
     QLIST_FOREACH(req, &bs->tracked_requests, list) {
         if (req->co == self) {
+            qemu_mutex_unlock(&bs->reqs_lock);
             return req;
         }
     }
+    qemu_mutex_unlock(&bs->reqs_lock);
 
     return NULL;
 }
-- 
2.47.3


