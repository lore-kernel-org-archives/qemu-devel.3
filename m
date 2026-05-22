Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AAACD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXbp-0003vm-Bt; Fri, 22 May 2026 17:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbT-0003kU-UD; Fri, 22 May 2026 17:40:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbR-0004VO-Nd; Fri, 22 May 2026 17:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485683; bh=0nnSSVXZOKkYsXF2mD7PXRD00F0+1IUBjameM9QTHrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u+fc3xed1bjyRO6RcjngRF0Uean6LwaTfT9cr9JJx10KITTFslNc2QwUlfIoS1F4/
 G1p+jJJRcUESGyrmwlasFVmwlIo/Dysw7+x/IYR0awak2lcMqoZq8rb6fulpu7gh10
 6KNiB/sjsd+1NPnRGk5fUqBs9Oc4qBX72nqyxKREK/yVHvNJkW9vXOjPyCCIrnNIdz
 5FnMLTsDCaJ6Zw8ahwFw80R6Vi+B0uCYRXcofzo2ai0llR7TBPrQU0J8CFc1AK+WWN
 6gcqqaSN3f1NEbUY7cx5U3W6jGuuGFaGhgogEiBp3BhzmScszVIrIxYppJS9sbEfU1
 vu5b+2UHZdhaw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1B571AFB10;
 Sat, 23 May 2026 00:34:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 026393B7190;
 Sat, 23 May 2026 00:34:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 127/136] ide: Minimal fix for deadlock between TRIM
 and drain
Date: Sat, 23 May 2026 00:34:35 +0300
Message-ID: <20260522213446.806182-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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

The implementation of TRIM in IDE can chain multiple discard requests
and uses blk_inc/dec_in_flight() to make sure that the whole TRIM
operation has completed when the device needs to be quiescent (e.g. for
the drain when performing an IDE reset, it would be bad if an IDE
request like TRIM were still in flight).

The problem is that each drain request calls blk_wait_while_drained()
and when draining, it waits until the drained section ends. At the same
time, drain_begin can only return if the whole TRIM operation has
completed. This is a classic deadlock.

Use blk_co_start/end_request() and BDRV_REQ_NO_QUEUE to avoid the
problem. This requires moving the TRIM state machine to a coroutine.
This commit does the minimal conversion so that we do have a coroutine
that works for the fix, but it still looks much like a callback-based
implementation. This will be cleaned up in the next patch.

Cc: qemu-stable@nongnu.org
Fixes: 7e5cdb345f77 ('ide: Increment BB in-flight counter for TRIM BH')
Buglink: https://redhat.atlassian.net/browse/RHEL-121686
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-5-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 095c08a7ba68cabaa6e0ce7a8a0804a949542c4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9ca480f72e..672238aef8 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -420,7 +420,6 @@ typedef struct TrimAIOCB {
     QEMUBH *bh;
     int ret;
     QEMUIOVector *qiov;
-    BlockAIOCB *aiocb;
     int i, j;
 } TrimAIOCB;
 
@@ -433,11 +432,6 @@ static void trim_aio_cancel(BlockAIOCB *acb)
     iocb->i = (iocb->qiov->iov[iocb->j].iov_len / 8) - 1;
 
     iocb->ret = -ECANCELED;
-
-    if (iocb->aiocb) {
-        blk_aio_cancel_async(iocb->aiocb);
-        iocb->aiocb = NULL;
-    }
 }
 
 static const AIOCBInfo trim_aiocb_info = {
@@ -456,15 +450,20 @@ static void ide_trim_bh_cb(void *opaque)
     iocb->bh = NULL;
     qemu_aio_unref(iocb);
 
-    /* Paired with an increment in ide_issue_trim() */
-    blk_dec_in_flight(blk);
+    /* Paired with blk_co_start_request in ide_trim_co_entry() */
+    blk_end_request(blk);
 }
 
-static void ide_issue_trim_cb(void *opaque, int ret)
+static void coroutine_fn ide_trim_co_entry(void *opaque)
 {
     TrimAIOCB *iocb = opaque;
     IDEState *s = iocb->s;
+    int ret = 0;
+
+    /* Paired with blk_end_request in ide_trim_bh_cb() */
+    blk_co_start_request(s->blk);
 
+loop:
     if (iocb->i >= 0) {
         if (ret >= 0) {
             block_acct_done(blk_get_stats(s->blk), &s->acct);
@@ -499,11 +498,11 @@ static void ide_issue_trim_cb(void *opaque, int ret)
                                  count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
 
                 /* Got an entry! Submit and exit.  */
-                iocb->aiocb = blk_aio_pdiscard(s->blk,
-                                               sector << BDRV_SECTOR_BITS,
-                                               count << BDRV_SECTOR_BITS,
-                                               ide_issue_trim_cb, opaque);
-                return;
+                ret = blk_co_pdiscard(s->blk,
+                                      sector << BDRV_SECTOR_BITS,
+                                      count << BDRV_SECTOR_BITS,
+                                      BDRV_REQ_NO_QUEUE);
+                goto loop;
             }
 
             iocb->j++;
@@ -514,7 +513,6 @@ static void ide_issue_trim_cb(void *opaque, int ret)
     }
 
 done:
-    iocb->aiocb = NULL;
     if (iocb->bh) {
         replay_bh_schedule_event(iocb->bh);
     }
@@ -527,9 +525,7 @@ BlockAIOCB *ide_issue_trim(
     IDEState *s = opaque;
     IDEDevice *dev = s->unit ? s->bus->slave : s->bus->master;
     TrimAIOCB *iocb;
-
-    /* Paired with a decrement in ide_trim_bh_cb() */
-    blk_inc_in_flight(s->blk);
+    Coroutine *co;
 
     iocb = blk_aio_get(&trim_aiocb_info, s->blk, cb, cb_opaque);
     iocb->s = s;
@@ -539,7 +535,10 @@ BlockAIOCB *ide_issue_trim(
     iocb->qiov = qiov;
     iocb->i = -1;
     iocb->j = 0;
-    ide_issue_trim_cb(iocb, 0);
+
+    co = qemu_coroutine_create(ide_trim_co_entry, iocb);
+    aio_co_enter(qemu_get_current_aio_context(), co);
+
     return &iocb->common;
 }
 
-- 
2.47.3


