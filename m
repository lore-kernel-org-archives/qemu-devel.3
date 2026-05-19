Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2CBCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrA-00080f-P9; Tue, 19 May 2026 13:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr7-0007yb-CI
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr3-0004De-Sg
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YoBzQot0sIcD2pxlSnw/1cyTfsK6JfUvPYD6dpUYLPY=;
 b=guxbeTc/cLLWhCkPYk5gtn/EyyWBeCzjgz6mSGKqEBjJJmbUPn5QzdQtvXR99t6JzHwVYi
 DJQQs6nfb7iAct6RQhlIID4d7mPXJUig/a5vX4x2nX1itW3/lINaFbsiFp3Yc2LmQKYePq
 9dLZBim8MfGTuZg00/EGqda0zdcgz0s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-yUXzXlhIOaGYexewPeBzqw-1; Tue,
 19 May 2026 13:03:36 -0400
X-MC-Unique: yUXzXlhIOaGYexewPeBzqw-1
X-Mimecast-MFC-AGG-ID: yUXzXlhIOaGYexewPeBzqw_1779210215
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A849018002C7; Tue, 19 May 2026 17:03:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57FC91681; Tue, 19 May 2026 17:03:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/18] ide: Minimal fix for deadlock between TRIM and drain
Date: Tue, 19 May 2026 19:03:03 +0200
Message-ID: <20260519170317.345032-5-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/ide/core.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 7a15d6cac9b..48359c934c1 100644
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
2.54.0


