Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C144C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 15:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpUb6-0005RT-2m; Tue, 04 Mar 2025 10:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1tpUas-0005L6-BO
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1tpUao-0003Qb-9Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 10:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741103641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WUsDQ4gd5JKDW1XYIWJv4ncLVtfSAQcwTOlC9O8ByYQ=;
 b=blkmkWM5Im7bdJga0plSTwx9jhOoBcLphFBRoIqNHRx5NNAbarsuuXA3V3w6CAuJdaMKk/
 C8Civi6fYH5upGkrRnKM0sf15oySiJH5VhAa1qM9P0CCV1kJtAlmRhV788EEkdblnHDoKQ
 d7gBU9fzzSID3nHE8TYMqYhrUXSRA0Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-EdQRlOLAMban69SzMb74Rg-1; Tue,
 04 Mar 2025 10:52:46 -0500
X-MC-Unique: EdQRlOLAMban69SzMb74Rg-1
X-Mimecast-MFC-AGG-ID: EdQRlOLAMban69SzMb74Rg_1741103566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA5B4180087A; Tue,  4 Mar 2025 15:52:45 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.225.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F40F71954B00; Tue,  4 Mar 2025 15:52:42 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH 2/2] scsi-disk: Add native FUA support
Date: Tue,  4 Mar 2025 15:52:32 +0000
Message-ID: <20250304155232.1325581-3-afaria@redhat.com>
In-Reply-To: <20250304155232.1325581-1-afaria@redhat.com>
References: <20250304155232.1325581-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avoid emulating FUA when the driver supports it natively. This should
provide better performance than a full flush after the write.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 hw/scsi/scsi-disk.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8cf50845ab..ce48e20ee6 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -43,6 +43,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "block/block_int-common.h"
 
 #ifdef __linux
 #include <scsi/sg.h>
@@ -75,7 +76,7 @@ struct SCSIDiskClass {
      */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
-    bool            (*need_fua_emulation)(SCSICommand *cmd);
+    bool            (*need_fua)(SCSICommand *cmd);
     void            (*update_sense)(SCSIRequest *r);
 };
 
@@ -86,6 +87,7 @@ typedef struct SCSIDiskReq {
     uint32_t sector_count;
     uint32_t buflen;
     bool started;
+    bool need_fua;
     bool need_fua_emulation;
     struct iovec iov;
     QEMUIOVector qiov;
@@ -553,7 +555,7 @@ static void scsi_read_data(SCSIRequest *req)
 
     first = !r->started;
     r->started = true;
-    if (first && r->need_fua_emulation) {
+    if (first && r->need_fua) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_do_read_cb, r);
@@ -2384,7 +2386,9 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
         return 0;
     }
-    r->need_fua_emulation = sdc->need_fua_emulation(&r->req.cmd);
+    r->need_fua = sdc->need_fua(&r->req.cmd);
+    r->need_fua_emulation = r->need_fua &&
+        (blk_bs(s->qdev.conf.blk)->supported_write_flags & BDRV_REQ_FUA) == 0;
     if (r->sector_count == 0) {
         scsi_req_complete(&r->req, GOOD);
     }
@@ -3134,7 +3138,8 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
 {
     SCSIDiskReq *r = opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
+    int flags = r->need_fua && !r->need_fua_emulation ? BDRV_REQ_FUA : 0;
+    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, flags, cb, cb_opaque);
 }
 
 static char *scsi_property_get_loadparm(Object *obj, Error **errp)
@@ -3183,7 +3188,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
     device_class_set_legacy_reset(dc, scsi_disk_reset);
     sdc->dma_readv = scsi_dma_readv;
     sdc->dma_writev = scsi_dma_writev;
-    sdc->need_fua_emulation = scsi_is_cmd_fua;
+    sdc->need_fua = scsi_is_cmd_fua;
 }
 
 static const TypeInfo scsi_disk_base_info = {
@@ -3335,7 +3340,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
     sdc->update_sense = scsi_block_update_sense;
-    sdc->need_fua_emulation = scsi_block_no_fua;
+    sdc->need_fua = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     device_class_set_props(dc, scsi_block_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
-- 
2.48.1


