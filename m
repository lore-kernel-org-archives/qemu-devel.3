Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFE3CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 01:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmRF-0002bg-Nx; Thu, 28 May 2026 21:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSmRE-0002bV-2t
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:55:04 -0400
Received: from [115.124.30.119] (helo=out30-119.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSmR6-0005uI-Ii
 for qemu-devel@nongnu.org; Thu, 28 May 2026 21:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780019666; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=IGnRlquDckY+vILeeivpNQ/AOtX8lfZBlLU5G6d3wDw=;
 b=pjFYWMZyH38KxhsDa5tZMOnpUc3IqVYCYqxaZy04UL02T1fBn1WUMJX/9Le57WlJYKonMJ0zXYyCagI6EXrdYMsCZGnH000tto81nKASZrlH69Q+eRR1LXxZZaOKV9MPz36Do6mpSL6KNT6uhAmriFi4+eqj2HZWD3KmkbihVAE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X3nuvYX_1780019664; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3nuvYX_1780019664 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 29 May 2026 09:54:25 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	kwolf@redhat.com
Subject: [PATCH] util/qemu-coroutine: skip global pool lock when pool is empty
Date: Fri, 29 May 2026 09:54:23 +0800
Message-ID: <20260529015423.49688-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.119 (deferred)
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
X-Spam_score_int: -88
X-Spam_score: -8.9
X-Spam_bar: --------
X-Spam_report: (-8.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

coroutine_pool_refill_local() acquires global_pool_lock on every
call even when the global pool is empty (global_pool_size == 0).
Under high I/O concurrency many threads simultaneously attempt to
refill from an empty global pool, causing unnecessary mutex
contention.

Add a fast-path check: read global_pool_size with qatomic_read()
before acquiring the mutex.  If zero, the global pool is empty and
we return immediately.  This is a racy read but correctness is
preserved: the only consequence of a stale read is a missed refill
opportunity, which will be retried on the next coroutine allocation.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 util/qemu-coroutine.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index d17135f585..0f8c3a23eb 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -138,6 +138,15 @@ static void coroutine_pool_refill_local(void)
     CoroutinePool *local_pool = get_ptr_local_pool();
     CoroutinePoolBatch *batch = NULL;
 
+    /*
+     * Fast path: skip the lock when the global pool is obviously empty.
+     * The read is racy but harmless -- worst case we miss a concurrent
+     * put and retry on the next allocation.
+     */
+    if (qatomic_read(&global_pool_size) == 0) {
+        return;
+    }
+
     WITH_QEMU_LOCK_GUARD(&global_pool_lock) {
         batch = QSLIST_FIRST(&global_pool);
 
-- 
2.50.1 (Apple Git-155)


