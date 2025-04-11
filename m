Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C774C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cca-00016I-Hp; Fri, 11 Apr 2025 07:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1u3CcD-00012O-2L
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1u3Cc8-000761-An
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkE9WLn/DQdTxRCCLaOCNUXMjYjH2D5XhobGx//eCOM=;
 b=DbVNqdXnfsR2a60FxuTyOrYHF0YjZVMOv2RwEjnYR+qkb4L7PqutdRh3KpRqLG0tIkurct
 B7qNYozYB2cZI3XseFAT/HJ71OYLXC1M8a2yOFxoY3EblfSSqcyKhdDuKf2WfbOjkPet6A
 Zi6HEsOYWy1W5OhUSNV6rvM2ceEINaQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-lH1fruSLPVuOlKt0tsWVqA-1; Fri,
 11 Apr 2025 07:30:50 -0400
X-MC-Unique: lH1fruSLPVuOlKt0tsWVqA-1
X-Mimecast-MFC-AGG-ID: lH1fruSLPVuOlKt0tsWVqA_1744371049
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD02195609F; Fri, 11 Apr 2025 11:30:47 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.225.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9678F1801A69; Fri, 11 Apr 2025 11:30:43 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH v2 1/2] scsi-disk: Add native FUA write support
Date: Fri, 11 Apr 2025 12:30:35 +0100
Message-ID: <20250411113036.786841-2-afaria@redhat.com>
In-Reply-To: <20250411113036.786841-1-afaria@redhat.com>
References: <20250411113036.786841-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Simply propagate the FUA flag on write requests to the driver. The block
layer will emulate it if necessary.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 hw/scsi/scsi-disk.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e59632e9b1..f62dcded64 100644
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
@@ -3186,7 +3163,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
     device_class_set_legacy_reset(dc, scsi_disk_reset);
     sdc->dma_readv = scsi_dma_readv;
     sdc->dma_writev = scsi_dma_writev;
-    sdc->need_fua_emulation = scsi_is_cmd_fua;
+    sdc->need_fua  = scsi_is_cmd_fua;
 }
 
 static const TypeInfo scsi_disk_base_info = {
@@ -3338,7 +3315,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
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


