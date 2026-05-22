Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F047CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXXo-0003Na-Kx; Fri, 22 May 2026 17:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXm-0003Lf-7K; Fri, 22 May 2026 17:36:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXk-00011T-10; Fri, 22 May 2026 17:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485633; bh=OXIPqZWpItYkzqBipJMaJJyw12b/+2Q3ZEi7oZGo5iQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZZ6Dz+6uiiOvF2H9KmFlkuvOuoZNQ+nEA0nBr5R+tPSSalHs9HPhONFlQYUUoD1lq
 TNFc8qOVAwZepyRhdI/wD69qnLz5aNjOm6hLfUvVX6Xm0iv5n1DpBNuTQ+57MEOKMX
 tQcMxPtucRy4+C6LRl99mVn+93kzq5/ds0Ugjqz3nMCs8x2aoHMyJ9eQvHGbyFQVtX
 cXGYkFKPaOsG5C25awjxi8AoKaRMJ8hrVYndmR6dASkXHfpfqT9NcHiN02ATQyJTGg
 59nMkXdcLa0lqvNEYJt/G4YeUHTg3ZLqeOVnP1okJkmQ2/M170zUzlroCJeH577CEB
 DyzYqSHaUplTw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F08E41AFAE4;
 Sat, 23 May 2026 00:33:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 20DA13B716A;
 Sat, 23 May 2026 00:33:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 85/94] ide: Clean up ide_trim_co_entry() to be
 idiomatic coroutine code
Date: Sat, 23 May 2026 00:33:42 +0300
Message-ID: <20260522213356.806058-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kevin Wolf <kwolf@redhat.com>

The previous commit did a minimal conversion of the callback based state
machine for TRIM to a coroutine in order to fix a bug. Refactor it to
actually look like normal coroutine based code, which improves its
readability.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-6-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit c1c71a7e167fdabaa9827d00c0be3aeafebdd921)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 48359c934c..f78b00220b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -420,18 +420,15 @@ typedef struct TrimAIOCB {
     QEMUBH *bh;
     int ret;
     QEMUIOVector *qiov;
-    int i, j;
+    bool canceled;
 } TrimAIOCB;
 
 static void trim_aio_cancel(BlockAIOCB *acb)
 {
     TrimAIOCB *iocb = container_of(acb, TrimAIOCB, common);
 
-    /* Exit the loop so ide_issue_trim_cb will not continue  */
-    iocb->j = iocb->qiov->niov - 1;
-    iocb->i = (iocb->qiov->iov[iocb->j].iov_len / 8) - 1;
-
-    iocb->ret = -ECANCELED;
+    /* Exit the loop so ide_trim_co_entry will not continue */
+    iocb->canceled = true;
 }
 
 static const AIOCBInfo trim_aiocb_info = {
@@ -458,60 +455,55 @@ static void coroutine_fn ide_trim_co_entry(void *opaque)
 {
     TrimAIOCB *iocb = opaque;
     IDEState *s = iocb->s;
-    int ret = 0;
+    int i, j;
+    int ret;
 
     /* Paired with blk_end_request in ide_trim_bh_cb() */
     blk_co_start_request(s->blk);
 
-loop:
-    if (iocb->i >= 0) {
-        if (ret >= 0) {
-            block_acct_done(blk_get_stats(s->blk), &s->acct);
-        } else {
-            block_acct_failed(blk_get_stats(s->blk), &s->acct);
-        }
-    }
+    for (j = 0; j < iocb->qiov->niov; j++) {
+        for (i = 0; i < iocb->qiov->iov[j].iov_len / 8; i++) {
+            uint64_t *buffer = iocb->qiov->iov[j].iov_base;
 
-    if (ret >= 0) {
-        while (iocb->j < iocb->qiov->niov) {
-            int j = iocb->j;
-            while (++iocb->i < iocb->qiov->iov[j].iov_len / 8) {
-                int i = iocb->i;
-                uint64_t *buffer = iocb->qiov->iov[j].iov_base;
+            /* 6-byte LBA + 2-byte range per entry */
+            uint64_t entry = le64_to_cpu(buffer[i]);
+            uint64_t sector = entry & 0x0000ffffffffffffULL;
+            uint16_t count = entry >> 48;
 
-                /* 6-byte LBA + 2-byte range per entry */
-                uint64_t entry = le64_to_cpu(buffer[i]);
-                uint64_t sector = entry & 0x0000ffffffffffffULL;
-                uint16_t count = entry >> 48;
+            if (count == 0) {
+                continue;
+            }
 
-                if (count == 0) {
-                    continue;
-                }
+            if (iocb->canceled) {
+                iocb->ret = -ECANCELED;
+                goto done;
+            }
 
-                if (!ide_sect_range_ok(s, sector, count)) {
-                    block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);
-                    iocb->ret = -EINVAL;
-                    goto done;
-                }
+            if (!ide_sect_range_ok(s, sector, count)) {
+                block_acct_invalid(blk_get_stats(s->blk), BLOCK_ACCT_UNMAP);
+                iocb->ret = -EINVAL;
+                goto done;
+            }
 
-                block_acct_start(blk_get_stats(s->blk), &s->acct,
-                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
+            block_acct_start(blk_get_stats(s->blk), &s->acct,
+                             count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
 
-                /* Got an entry! Submit and exit.  */
-                ret = blk_co_pdiscard(s->blk,
-                                      sector << BDRV_SECTOR_BITS,
-                                      count << BDRV_SECTOR_BITS,
-                                      BDRV_REQ_NO_QUEUE);
-                goto loop;
+            /* Got an entry! Submit and exit.  */
+            ret = blk_co_pdiscard(s->blk,
+                                  sector << BDRV_SECTOR_BITS,
+                                  count << BDRV_SECTOR_BITS,
+                                  BDRV_REQ_NO_QUEUE);
+            if (ret >= 0) {
+                block_acct_done(blk_get_stats(s->blk), &s->acct);
+            } else {
+                iocb->ret = ret;
+                block_acct_failed(blk_get_stats(s->blk), &s->acct);
+                goto done;
             }
-
-            iocb->j++;
-            iocb->i = -1;
         }
-    } else {
-        iocb->ret = ret;
     }
 
+    iocb->ret = 0;
 done:
     if (iocb->bh) {
         replay_bh_schedule_event(iocb->bh);
@@ -533,8 +525,7 @@ BlockAIOCB *ide_issue_trim(
                                    &DEVICE(dev)->mem_reentrancy_guard);
     iocb->ret = 0;
     iocb->qiov = qiov;
-    iocb->i = -1;
-    iocb->j = 0;
+    iocb->canceled = false;
 
     co = qemu_coroutine_create(ide_trim_co_entry, iocb);
     aio_co_enter(qemu_get_current_aio_context(), co);
-- 
2.47.3


