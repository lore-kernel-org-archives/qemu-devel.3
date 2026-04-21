Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E9F8FA94
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDiV-0001a0-9D; Tue, 21 Apr 2026 12:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDi4-0001PZ-80
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wFDi1-0000Jn-5a
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776787940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4dsw4jNX6Z6/lLNoJG/cG5lUqCzWJZiyxEpvX7UznA=;
 b=Ff+Fik/0YGPrpTxaqOJFnb8nrbjrvwx0fHcapBWoZwnd3mYknjIYFA/G+fiMokDu5l4FbG
 irkwdLkNS4cVGYE1kGE1d1mcmwgatm8htETLrM6ax8+aTeeoSo/xwD5L4h/dT+vrqXox89
 vUXLMehYO6jhyUbLJqsgC6d1A+QIKAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-owI0DaL8O9yGDJy5QFwhYA-1; Tue,
 21 Apr 2026 12:12:15 -0400
X-MC-Unique: owI0DaL8O9yGDJy5QFwhYA-1
X-Mimecast-MFC-AGG-ID: owI0DaL8O9yGDJy5QFwhYA_1776787934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9301800473; Tue, 21 Apr 2026 16:12:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.173])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A0211800351; Tue, 21 Apr 2026 16:12:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 5/7] ide: Clean up ide_trim_co_entry() to be idiomatic
 coroutine code
Date: Tue, 21 Apr 2026 18:11:30 +0200
Message-ID: <20260421161132.99878-6-kwolf@redhat.com>
In-Reply-To: <20260421161132.99878-1-kwolf@redhat.com>
References: <20260421161132.99878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous commit did a minimal conversion of the callback based state
machine for TRIM to a coroutine in order to fix a bug. Refactor it to
actually look like normal coroutine based code, which improves its
readability.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/ide/core.c | 87 +++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 48359c934c1..f78b00220b8 100644
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
2.53.0


