Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D3BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 19:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ8ix-0004Ix-Kk; Thu, 21 May 2026 15:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wQ8iv-0004Il-4H
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:06:25 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wQ8it-0007PM-8f
 for qemu-devel@nongnu.org; Thu, 21 May 2026 15:06:24 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wQ8ij-000000020qc-0fRN; Thu, 21 May 2026 21:06:13 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] thread-pool: Allow at least 1 thread in
 thread_pool_adjust_max_threads_to_work()
Date: Thu, 21 May 2026 21:06:07 +0200
Message-ID: <b76c763f576b0fb8a35960a8e3c3da59701d2a74.1779390317.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

thread_pool_adjust_max_threads_to_work() is supposed to give each task its
own thread by setting the pool max thread count limit accordingly.

However, if there aren't any tasks currently in the pool the pool max
thread count will be set to 0, which will trigger an assertion failure
in thread_pool_set_max_threads() - because setting this value would
completely block the pool by not allowing it to process any submitted
tasks.

This also can happen if a task is submitted via
thread_pool_submit_immediate() to an empty pool but the task completes so
quickly that by the time this function calls
thread_pool_adjust_max_threads_to_work() the pool again has no unfinished
tasks in it.

Fix this by making sure that the pool is allowed to create at least 1
thread.

Fixes: b5aa74968b27 ("thread-pool: Implement generic (non-AIO) pool support")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 util/thread-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 8f8cb38d5ce0..4e75191c983e 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -493,5 +493,5 @@ bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
 {
     QEMU_LOCK_GUARD(&pool->cur_work_lock);
 
-    return thread_pool_set_max_threads(pool, pool->cur_work);
+    return thread_pool_set_max_threads(pool, MAX(pool->cur_work, 1));
 }

