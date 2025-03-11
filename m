Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6927EC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts27S-0001BY-1Z; Tue, 11 Mar 2025 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22K-0004Fi-UB
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22G-0005kD-Cv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCCNj0NZUm4NtjFxz2ZnD0eWZpqRsgge4WXRpitU6js=;
 b=NOIU3DA0hHPMLuzwePpL8FqzzGqKAtfud5VBYaI751/DNCNwSzEjusOaxokj142Gg38yzi
 TIJYrKt1ikRRDI0FgZ/RL3wWMrEKX/w7lhiUM+Uaf9EJYvAPE2un+aEVe6VwS7waN0GE0F
 gDUEUGv9P2jcayki7GaKQ4wXh72vuNU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-p2PV28-eNliYa3O_Ohxksg-1; Tue,
 11 Mar 2025 12:00:50 -0400
X-MC-Unique: p2PV28-eNliYa3O_Ohxksg-1
X-Mimecast-MFC-AGG-ID: p2PV28-eNliYa3O_Ohxksg_1741708849
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 040EB180AF68; Tue, 11 Mar 2025 16:00:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D86818001E9; Tue, 11 Mar 2025 16:00:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/22] dma: use current AioContext for dma_blk_io()
Date: Tue, 11 Mar 2025 17:00:10 +0100
Message-ID: <20250311160021.349761-12-kwolf@redhat.com>
In-Reply-To: <20250311160021.349761-1-kwolf@redhat.com>
References: <20250311160021.349761-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

In the past a single AioContext was used for block I/O and it was
fetched using blk_get_aio_context(). Nowadays the block layer supports
running I/O from any AioContext and multiple AioContexts at the same
time. Remove the dma_blk_io() AioContext argument and use the current
AioContext instead.

This makes calling the function easier and enables multiple IOThreads to
use dma_blk_io() concurrently for the same block device.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250311132616.1049687-3-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/dma.h | 3 +--
 hw/ide/core.c        | 3 +--
 hw/ide/macio.c       | 3 +--
 hw/scsi/scsi-disk.c  | 6 ++----
 system/dma-helpers.c | 8 ++++----
 5 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/system/dma.h b/include/system/dma.h
index 5a49a30628..e142f7efa6 100644
--- a/include/system/dma.h
+++ b/include/system/dma.h
@@ -290,8 +290,7 @@ typedef BlockAIOCB *DMAIOFunc(int64_t offset, QEMUIOVector *iov,
                               BlockCompletionFunc *cb, void *cb_opaque,
                               void *opaque);
 
-BlockAIOCB *dma_blk_io(AioContext *ctx,
-                       QEMUSGList *sg, uint64_t offset, uint32_t align,
+BlockAIOCB *dma_blk_io(QEMUSGList *sg, uint64_t offset, uint32_t align,
                        DMAIOFunc *io_func, void *io_func_opaque,
                        BlockCompletionFunc *cb, void *opaque, DMADirection dir);
 BlockAIOCB *dma_blk_read(BlockBackend *blk,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index f9baba59e9..b14983ec54 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -968,8 +968,7 @@ static void ide_dma_cb(void *opaque, int ret)
                                            BDRV_SECTOR_SIZE, ide_dma_cb, s);
         break;
     case IDE_DMA_TRIM:
-        s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk),
-                                        &s->sg, offset, BDRV_SECTOR_SIZE,
+        s->bus->dma->aiocb = dma_blk_io(&s->sg, offset, BDRV_SECTOR_SIZE,
                                         ide_issue_trim, s, ide_dma_cb, s,
                                         DMA_DIRECTION_TO_DEVICE);
         break;
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 5fe764b49b..c8e8e44cc9 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -187,8 +187,7 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
                                            pmac_ide_transfer_cb, io);
         break;
     case IDE_DMA_TRIM:
-        s->bus->dma->aiocb = dma_blk_io(blk_get_aio_context(s->blk), &s->sg,
-                                        offset, 0x1, ide_issue_trim, s,
+        s->bus->dma->aiocb = dma_blk_io(&s->sg, offset, 0x1, ide_issue_trim, s,
                                         pmac_ide_transfer_cb, io,
                                         DMA_DIRECTION_TO_DEVICE);
         break;
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index caf6c1437f..f049a20275 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -487,8 +487,7 @@ static void scsi_do_read(SCSIDiskReq *r, int ret)
     if (r->req.sg) {
         dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACCT_READ);
         r->req.residual -= r->req.sg->size;
-        r->req.aiocb = dma_blk_io(blk_get_aio_context(s->qdev.conf.blk),
-                                  r->req.sg, r->sector << BDRV_SECTOR_BITS,
+        r->req.aiocb = dma_blk_io(r->req.sg, r->sector << BDRV_SECTOR_BITS,
                                   BDRV_SECTOR_SIZE,
                                   sdc->dma_readv, r, scsi_dma_complete, r,
                                   DMA_DIRECTION_FROM_DEVICE);
@@ -650,8 +649,7 @@ static void scsi_write_data(SCSIRequest *req)
     if (r->req.sg) {
         dma_acct_start(s->qdev.conf.blk, &r->acct, r->req.sg, BLOCK_ACCT_WRITE);
         r->req.residual -= r->req.sg->size;
-        r->req.aiocb = dma_blk_io(blk_get_aio_context(s->qdev.conf.blk),
-                                  r->req.sg, r->sector << BDRV_SECTOR_BITS,
+        r->req.aiocb = dma_blk_io(r->req.sg, r->sector << BDRV_SECTOR_BITS,
                                   BDRV_SECTOR_SIZE,
                                   sdc->dma_writev, r, scsi_dma_complete, r,
                                   DMA_DIRECTION_TO_DEVICE);
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index f6403242f5..6bad75876f 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -211,7 +211,7 @@ static const AIOCBInfo dma_aiocb_info = {
     .cancel_async       = dma_aio_cancel,
 };
 
-BlockAIOCB *dma_blk_io(AioContext *ctx,
+BlockAIOCB *dma_blk_io(
     QEMUSGList *sg, uint64_t offset, uint32_t align,
     DMAIOFunc *io_func, void *io_func_opaque,
     BlockCompletionFunc *cb,
@@ -223,7 +223,7 @@ BlockAIOCB *dma_blk_io(AioContext *ctx,
 
     dbs->acb = NULL;
     dbs->sg = sg;
-    dbs->ctx = ctx;
+    dbs->ctx = qemu_get_current_aio_context();
     dbs->offset = offset;
     dbs->align = align;
     dbs->sg_cur_index = 0;
@@ -251,7 +251,7 @@ BlockAIOCB *dma_blk_read(BlockBackend *blk,
                          QEMUSGList *sg, uint64_t offset, uint32_t align,
                          void (*cb)(void *opaque, int ret), void *opaque)
 {
-    return dma_blk_io(blk_get_aio_context(blk), sg, offset, align,
+    return dma_blk_io(sg, offset, align,
                       dma_blk_read_io_func, blk, cb, opaque,
                       DMA_DIRECTION_FROM_DEVICE);
 }
@@ -269,7 +269,7 @@ BlockAIOCB *dma_blk_write(BlockBackend *blk,
                           QEMUSGList *sg, uint64_t offset, uint32_t align,
                           void (*cb)(void *opaque, int ret), void *opaque)
 {
-    return dma_blk_io(blk_get_aio_context(blk), sg, offset, align,
+    return dma_blk_io(sg, offset, align,
                       dma_blk_write_io_func, blk, cb, opaque,
                       DMA_DIRECTION_TO_DEVICE);
 }
-- 
2.48.1


