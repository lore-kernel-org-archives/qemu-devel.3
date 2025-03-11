Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AC2C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2AM-0003s1-4p; Tue, 11 Mar 2025 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22P-0004HA-Tq
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts22K-0005ke-19
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741708853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rskunDLsR4f93hBQb/w9k2yQjqC7TOYCWk+W/zKfZaQ=;
 b=MJ5TM4Jdj8JZMrGAP2TAi1gIDFx5+H508ER6coeX0YcexQ8bMi3tRuhvJpOq9C4JGmym0c
 D6xNo5yiPXIdKxzcVawrXEPVnsug6DzXVC74n7X84wZfKeoZMo7uq6Gk5GEFHdPHmadmdd
 hh5NHcb7KiTk/Ff6rmNTP5QnWq2sn3g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-peeSZBZRM-mMgwAGMI7akw-1; Tue,
 11 Mar 2025 12:00:51 -0400
X-MC-Unique: peeSZBZRM-mMgwAGMI7akw-1
X-Mimecast-MFC-AGG-ID: peeSZBZRM-mMgwAGMI7akw_1741708851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F5E8195609E; Tue, 11 Mar 2025 16:00:51 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AF9C1800373; Tue, 11 Mar 2025 16:00:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/22] scsi: track per-SCSIRequest AioContext
Date: Tue, 11 Mar 2025 17:00:11 +0100
Message-ID: <20250311160021.349761-13-kwolf@redhat.com>
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

Until now, a SCSIDevice's I/O requests have run in a single AioContext.
In order to support multiple IOThreads it will be necessary to move to
the concept of a per-SCSIRequest AioContext.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250311132616.1049687-4-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/scsi/scsi-bus.c     |  1 +
 hw/scsi/scsi-disk.c    | 17 ++++++-----------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index c3d5e17e38..ffc48203f9 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -24,6 +24,7 @@ struct SCSIRequest {
     SCSIBus           *bus;
     SCSIDevice        *dev;
     const SCSIReqOps  *ops;
+    AioContext        *ctx;
     uint32_t          refcount;
     uint32_t          tag;
     uint32_t          lun;
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7d4546800f..846bbbf0ec 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -868,6 +868,7 @@ invalid_opcode:
         }
     }
 
+    req->ctx = qemu_get_current_aio_context();
     req->cmd = cmd;
     req->residual = req->cmd.xfer;
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f049a20275..7cf8c31b98 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -328,9 +328,8 @@ static void scsi_aio_complete(void *opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    /* The request must only run in the BlockBackend's AioContext */
-    assert(blk_get_aio_context(s->qdev.conf.blk) ==
-           qemu_get_current_aio_context());
+    /* The request must run in its AioContext */
+    assert(r->req.ctx == qemu_get_current_aio_context());
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
@@ -430,12 +429,10 @@ static void scsi_dma_complete(void *opaque, int ret)
 
 static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint32_t n;
 
-    /* The request must only run in the BlockBackend's AioContext */
-    assert(blk_get_aio_context(s->qdev.conf.blk) ==
-           qemu_get_current_aio_context());
+    /* The request must run in its AioContext */
+    assert(r->req.ctx == qemu_get_current_aio_context());
 
     assert(r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, ret > 0)) {
@@ -562,12 +559,10 @@ static void scsi_read_data(SCSIRequest *req)
 
 static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
 {
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint32_t n;
 
-    /* The request must only run in the BlockBackend's AioContext */
-    assert(blk_get_aio_context(s->qdev.conf.blk) ==
-           qemu_get_current_aio_context());
+    /* The request must run in its AioContext */
+    assert(r->req.ctx == qemu_get_current_aio_context());
 
     assert (r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, ret > 0)) {
-- 
2.48.1


