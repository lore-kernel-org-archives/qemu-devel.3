Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19BFCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuP2-0004TH-Uj; Tue, 12 May 2026 17:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOf-0003xl-7C; Tue, 12 May 2026 17:12:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOd-0004l0-De; Tue, 12 May 2026 17:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=h0xXB4I5Ov6ATUIOIB+zE9jJbDn2PhZNsiGbdDvWU3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HkR5zRFbQASJ9yqXUO3vQ/9pOB02eYfpyEj/goCbfV71Goe20VZD5Jy6qO6Ba1TAL
 tPMYC06uDdWK5ZIs4w7w/IiJMYYd1ll/YAwXnWbPvvZKSeq1CRPEpd2Az4vYKDyxjE
 0vfxcyYTrV8QbgHgvy86konxrwnW513wdYBwVWaDuQbsYIvpZEPLLRZUD/k/1t/OGR
 xWAvXDAF1T2QdI2L8tIqR8+v6fBLM7R9oTfqSjBNO8PYAcEGMjPFr5oRqDR8iXF/BX
 I5fWeQrnwNiH0FKCa2hwwwSvEW328DEGxT9mjNaFzrlFVAikar9du3PHwJ0KHbxfRe
 kMIaXm5rtr6Ig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE57A1AA37C;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D99F83ABCEB;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jihe Wang <wangjihe.mail@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 062/117] virtio-scsi: pass the same cdb_size to
 virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
Date: Tue, 12 May 2026 23:54:04 +0300
Message-ID: <20260512205503.361097-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Ensure that there is no allocation/usage mismatch when requests
are processed in virtio_scsi_handle_cmd_vq.  To do this,
retrieve the value once and pass it to both functions.

For other calls to virtio_scsi_pop_req the extra size
can be 0, because control and event requests fit
entirely in VirtIOSCSIReq.

Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Tested-by: Jihe Wang <wangjihe.mail@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: CVE-2026-5763
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 79971302935472232a68073faddb085177e3ca54)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 93e87c459c..24ece74e2b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -227,16 +227,16 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
     return 0;
 }
 
-static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq, QemuMutex *vq_lock)
+static VirtIOSCSIReq *virtio_scsi_pop_req(VirtIOSCSI *s, VirtQueue *vq, size_t extra_req_size,
+                                          QemuMutex *vq_lock)
 {
-    VirtIOSCSICommon *vs = (VirtIOSCSICommon *)s;
     VirtIOSCSIReq *req;
 
     if (vq_lock) {
         qemu_mutex_lock(vq_lock);
     }
 
-    req = virtqueue_pop(vq, sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    req = virtqueue_pop(vq, sizeof(VirtIOSCSIReq) + extra_req_size);
 
     if (vq_lock) {
         qemu_mutex_unlock(vq_lock);
@@ -682,7 +682,7 @@ static void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
 
-    while ((req = virtio_scsi_pop_req(s, vq, &s->ctrl_lock))) {
+    while ((req = virtio_scsi_pop_req(s, vq, 0, &s->ctrl_lock))) {
         virtio_scsi_handle_ctrl_req(s, req);
     }
 }
@@ -850,13 +850,14 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
     virtio_scsi_complete_cmd_req(req);
 }
 
-static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
+static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req,
+                                              size_t cdb_size)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     SCSIDevice *d;
     int rc;
 
-    rc = virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
+    rc = virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + cdb_size,
                                sizeof(VirtIOSCSICmdResp) + vs->sense_size);
     if (rc < 0) {
         if (rc == -ENOTSUP) {
@@ -878,7 +879,7 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
     req->sreq = scsi_req_new(d, req->req.cmd.tag,
                              virtio_scsi_get_lun(req->req.cmd.lun),
-                             req->req.cmd.cdb, vs->cdb_size, req);
+                             req->req.cmd.cdb, cdb_size, req);
 
     if (req->sreq->cmd.mode != SCSI_XFER_NONE
         && (req->sreq->cmd.mode != req->mode ||
@@ -913,12 +914,15 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
     QTAILQ_HEAD(, VirtIOSCSIReq) reqs = QTAILQ_HEAD_INITIALIZER(reqs);
 
     do {
+        VirtIOSCSICommon *vs = (VirtIOSCSICommon *)s;
+        size_t cdb_size = qatomic_read(&vs->cdb_size);
+
         if (suppress_notifications) {
             virtio_queue_set_notification(vq, 0);
         }
 
-        while ((req = virtio_scsi_pop_req(s, vq, NULL))) {
-            ret = virtio_scsi_handle_cmd_req_prepare(s, req);
+        while ((req = virtio_scsi_pop_req(s, vq, cdb_size, NULL))) {
+            ret = virtio_scsi_handle_cmd_req_prepare(s, req, cdb_size);
             if (!ret) {
                 QTAILQ_INSERT_TAIL(&reqs, req, next);
             } else if (ret == -EINVAL) {
@@ -989,7 +993,7 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
     }
 
     vs->sense_size = virtio_ldl_p(vdev, &scsiconf->sense_size);
-    vs->cdb_size = virtio_ldl_p(vdev, &scsiconf->cdb_size);
+    qatomic_set(&vs->cdb_size, virtio_ldl_p(vdev, &scsiconf->cdb_size));
 }
 
 static uint64_t virtio_scsi_get_features(VirtIODevice *vdev,
@@ -1050,7 +1054,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
         return;
     }
 
-    req = virtio_scsi_pop_req(s, vs->event_vq, &s->event_lock);
+    req = virtio_scsi_pop_req(s, vs->event_vq, 0, &s->event_lock);
     WITH_QEMU_LOCK_GUARD(&s->event_lock) {
         if (!req) {
             s->events_dropped = true;
-- 
2.47.3


