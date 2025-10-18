Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9B2CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 20:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vADzG-00086q-Kf; Sat, 18 Oct 2025 16:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz6-00080S-QG; Sat, 18 Oct 2025 16:57:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vADz5-0004y9-4P; Sat, 18 Oct 2025 16:57:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D6B2915F87D;
 Sat, 18 Oct 2025 23:56:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C138F2F0686;
 Sat, 18 Oct 2025 23:56:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 20/23] async: access bottom half flags with
 qatomic_read
Date: Sat, 18 Oct 2025 23:56:38 +0300
Message-ID: <20251018205644.1185050-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251018221314@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Running test-aio-multithread under TSAN reveals data races on bh->flags.
Because bottom halves may be scheduled or canceled asynchronously,
without taking a lock, adjust aio_compute_bh_timeout() and aio_ctx_check()
to use a relaxed read to access the flags.

Use an acquire load to ensure that anything that was written prior to
qemu_bh_schedule() is visible.

Closes: https://gitlab.com/qemu-project/qemu/-/issues/2749
Closes: https://gitlab.com/qemu-project/qemu/-/issues/851
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5142397c79330aab9bef3230991c8ac0c251110f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/async.c b/util/async.c
index 863416dee9..c3ddb1c79b 100644
--- a/util/async.c
+++ b/util/async.c
@@ -256,8 +256,9 @@ static int64_t aio_compute_bh_timeout(BHList *head, int timeout)
     QEMUBH *bh;
 
     QSLIST_FOREACH_RCU(bh, head, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
-            if (bh->flags & BH_IDLE) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            if (flags & BH_IDLE) {
                 /* idle bottom halves will be polled at least
                  * every 10ms */
                 timeout = 10000000;
@@ -335,14 +336,16 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
 
     QSLIST_FOREACH_RCU(bh, &ctx->bh_list, next) {
-        if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+        int flags = qatomic_load_acquire(&bh->flags);
+        if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
             return true;
         }
     }
 
     QSIMPLEQ_FOREACH(s, &ctx->bh_slice_list, next) {
         QSLIST_FOREACH_RCU(bh, &s->bh_list, next) {
-            if ((bh->flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
+            int flags = qatomic_load_acquire(&bh->flags);
+            if ((flags & (BH_SCHEDULED | BH_DELETED)) == BH_SCHEDULED) {
                 return true;
             }
         }
-- 
2.47.3


