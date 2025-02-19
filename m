Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA667C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 16:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkmgq-0002Fg-40; Wed, 19 Feb 2025 11:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tkmgo-0002FM-NK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:12:46 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tkmgl-0003fP-PE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:12:46 -0500
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id 5AD7D407851F;
 Wed, 19 Feb 2025 16:12:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5AD7D407851F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1739981557;
 bh=uqIoSnKH103eFzVm2nfh1pMTVXziDfv19fsVMIGilXQ=;
 h=From:To:Cc:Subject:Date:From;
 b=UPAlDjJakiEEFgEXjYuy8ZtEbU08zS/PhO0hvheqlXaFsNfoAPg5RR0Wgs2gei0Am
 3CnlPnBGGrvWytaU3uQbBMtk+fGAPriQH/6jFUbwdfKLJoLW2XcW6tFp7KHHSIG+ip
 JraDfmRRht0b2/+SmYTl4sMeQdWAcKBcWnVEBHSw=
From: Vitalii Mordan <mordan@ispras.ru>
To: Thomas Huth <thuth@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Fix data race with the state Field of ThreadPoolElement
Date: Wed, 19 Feb 2025 19:12:23 +0300
Message-Id: <20250219161223.3340431-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TSAN reports a potential data race on the state field of
ThreadPoolElement. This is fixed by using atomic access to the field.

Fixes: d354c7eccf ("aio: add generic thread-pool facility")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2822
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 util/thread-pool.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e85..6c5f4d085b 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -111,9 +111,8 @@ static void *worker_thread(void *opaque)
         ret = req->func(req->arg);
 
         req->ret = ret;
-        /* Write ret before state.  */
-        smp_wmb();
-        req->state = THREAD_DONE;
+        /* Atomically update state after setting ret.  */
+        qatomic_store_release(&req->state, THREAD_DONE);
 
         qemu_bh_schedule(pool->completion_bh);
         qemu_mutex_lock(&pool->lock);
@@ -180,7 +179,7 @@ static void thread_pool_completion_bh(void *opaque)
 
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
-        if (elem->state != THREAD_DONE) {
+        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
             continue;
         }
 
@@ -223,12 +222,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     trace_thread_pool_cancel(elem, elem->common.opaque);
 
     QEMU_LOCK_GUARD(&pool->lock);
-    if (elem->state == THREAD_QUEUED) {
+    if (qatomic_load_acquire(&elem->state) == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
         qemu_bh_schedule(pool->completion_bh);
 
-        elem->state = THREAD_DONE;
         elem->ret = -ECANCELED;
+        qatomic_store_release(&elem->state, THREAD_DONE);
     }
 
 }
@@ -251,8 +250,8 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
     req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
     req->func = func;
     req->arg = arg;
-    req->state = THREAD_QUEUED;
     req->pool = pool;
+    qatomic_store_release(&req->state, THREAD_QUEUED);
 
     QLIST_INSERT_HEAD(&pool->head, req, all);
 
-- 
2.34.1


