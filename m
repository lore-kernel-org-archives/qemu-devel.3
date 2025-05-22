Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9804AC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAho-0005nR-Uz; Thu, 22 May 2025 14:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhZ-0005lX-Ls
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uIAhR-0000MP-FU
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747938684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIIUmeq3SsuUrR0s6flEjVPGyKgwiNYPLT8pE4mayd0=;
 b=O2wSIJdQM3X4ijz8TpecgLW1GS8z5e92pTnOfxdGc9H51RYsdBjXxyf2tlAg66hXJfXmTf
 m8T26VH/f/fKklQhwjteOY8kTfcd0sbiFhe0ZWeI3c6gbz6F7LPtN8j4bPDEoHNBepC1mr
 DnYJXmnU5clTdcw5UmNPjf9gr/4/Zks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-yus4JLCVPJuVJN73w8GvvQ-1; Thu,
 22 May 2025 14:31:22 -0400
X-MC-Unique: yus4JLCVPJuVJN73w8GvvQ-1
X-Mimecast-MFC-AGG-ID: yus4JLCVPJuVJN73w8GvvQ_1747938681
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 643B91956080; Thu, 22 May 2025 18:31:21 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 208CB1944DFF; Thu, 22 May 2025 18:31:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 1/5] scsi-disk: Add native FUA write support
Date: Thu, 22 May 2025 20:31:11 +0200
Message-ID: <20250522183115.246746-2-kwolf@redhat.com>
In-Reply-To: <20250522183115.246746-1-kwolf@redhat.com>
References: <20250522183115.246746-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alberto Faria <afaria@redhat.com>

Simply propagate the FUA flag on write requests to the driver. The block
layer will emulate it if necessary.

Signed-off-by: Alberto Faria <afaria@redhat.com>
Message-ID: <20250502121115.3613717-2-afaria@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 53 +++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index cb4af1b715..738d8df8ec 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -74,7 +74,7 @@ struct SCSIDiskClass {
      */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
-    bool            (*need_fua_emulation)(SCSICommand *cmd);
+    bool            (*need_fua)(SCSICommand *cmd);
     void            (*update_sense)(SCSIRequest *r);
 };
 
@@ -85,7 +85,7 @@ typedef struct SCSIDiskReq {
     uint32_t sector_count;
     uint32_t buflen;
     bool started;
-    bool need_fua_emulation;
+    bool need_fua;
     struct iovec iov;
     QEMUIOVector qiov;
     BlockAcctCookie acct;
@@ -389,24 +389,6 @@ static bool scsi_is_cmd_fua(SCSICommand *cmd)
     }
 }
 
-static void scsi_write_do_fua(SCSIDiskReq *r)
-{
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-
-    assert(r->req.aiocb == NULL);
-    assert(!r->req.io_canceled);
-
-    if (r->need_fua_emulation) {
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r);
-        return;
-    }
-
-    scsi_req_complete(&r->req, GOOD);
-    scsi_req_unref(&r->req);
-}
-
 static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
 {
     assert(r->req.aiocb == NULL);
@@ -416,12 +398,7 @@ static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
 
     r->sector += r->sector_count;
     r->sector_count = 0;
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        scsi_write_do_fua(r);
-        return;
-    } else {
-        scsi_req_complete(&r->req, GOOD);
-    }
+    scsi_req_complete(&r->req, GOOD);
 
 done:
     scsi_req_unref(&r->req);
@@ -564,7 +541,7 @@ static void scsi_read_data(SCSIRequest *req)
 
     first = !r->started;
     r->started = true;
-    if (first && r->need_fua_emulation) {
+    if (first && r->need_fua) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_do_read_cb, r);
@@ -589,8 +566,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
     r->sector += n;
     r->sector_count -= n;
     if (r->sector_count == 0) {
-        scsi_write_do_fua(r);
-        return;
+        scsi_req_complete(&r->req, GOOD);
     } else {
         scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
         trace_scsi_disk_write_complete_noio(r->req.tag, r->qiov.size);
@@ -623,6 +599,7 @@ static void scsi_write_data(SCSIRequest *req)
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    BlockCompletionFunc *cb;
 
     /* No data transfer may already be in progress */
     assert(r->req.aiocb == NULL);
@@ -648,11 +625,10 @@ static void scsi_write_data(SCSIRequest *req)
 
     if (r->req.cmd.buf[0] == VERIFY_10 || r->req.cmd.buf[0] == VERIFY_12 ||
         r->req.cmd.buf[0] == VERIFY_16) {
-        if (r->req.sg) {
-            scsi_dma_complete_noio(r, 0);
-        } else {
-            scsi_write_complete_noio(r, 0);
-        }
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+                         BLOCK_ACCT_FLUSH);
+        cb = r->req.sg ? scsi_dma_complete : scsi_write_complete;
+        r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, cb, r);
         return;
     }
 
@@ -2391,7 +2367,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
         return 0;
     }
-    r->need_fua_emulation = sdc->need_fua_emulation(&r->req.cmd);
+    r->need_fua = sdc->need_fua(&r->req.cmd);
     if (r->sector_count == 0) {
         scsi_req_complete(&r->req, GOOD);
     }
@@ -3137,7 +3113,8 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
 {
     SCSIDiskReq *r = opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
+    int flags = r->need_fua ? BDRV_REQ_FUA : 0;
+    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, flags, cb, cb_opaque);
 }
 
 static char *scsi_property_get_loadparm(Object *obj, Error **errp)
@@ -3186,7 +3163,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, scsi_disk_reset);
     sdc->dma_readv = scsi_dma_readv;
     sdc->dma_writev = scsi_dma_writev;
-    sdc->need_fua_emulation = scsi_is_cmd_fua;
+    sdc->need_fua  = scsi_is_cmd_fua;
 }
 
 static const TypeInfo scsi_disk_base_info = {
@@ -3338,7 +3315,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, const void *data)
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
     sdc->update_sense = scsi_block_update_sense;
-    sdc->need_fua_emulation = scsi_block_no_fua;
+    sdc->need_fua    = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     device_class_set_props(dc, scsi_block_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
-- 
2.49.0


