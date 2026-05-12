Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFD1CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuDW-0006Z9-JF; Tue, 12 May 2026 17:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCs-0003c4-BW; Tue, 12 May 2026 16:59:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCn-0005HT-C0; Tue, 12 May 2026 16:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=iSPboxQuGL2s0tBdLX2T+plxIBfc1ed31OajkLjth/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZWuShUs1g9BWz/19APdBNSR+xm5MS4f1PvGt3Ox5MudPi3HJecIKGS9f7s75ILsEa
 8nZw/hFMlpi6pzCxTxbfynv4gyE8WuKOsa6IrZCUi7m3w3MabvFYqIp5QJVkLsbY9J
 UU/Hl77pIESvoWy6udIftANrkakcCPz4+uGcFdJm1fDZZlvKlTXMiospIKB7hFH1X4
 JgPx3K03sbebEN7oOtW8MSZUz7x90C4jt5WMOPyXBzIA+i2rfc0xxH0+rNw+fATrKE
 CeQ/QfoeONqcPwf4T3KIVqReNzyTWB3oamR7bYbkBRQ5TMrZ1ur6mMUz+Muqwro8yH
 KWXzTxTciHTpg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E1B81AA300;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A964C3ABC71;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jihe Wang <wangjihe.mail@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 052/107] virtio-scsi: pass the same cdb_size to
 virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare
Date: Tue, 12 May 2026 23:53:39 +0300
Message-ID: <20260512205437.360850-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index 383521495f..ffa85fa25a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -231,16 +231,16 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
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
@@ -686,7 +686,7 @@ static void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
 
-    while ((req = virtio_scsi_pop_req(s, vq, &s->ctrl_lock))) {
+    while ((req = virtio_scsi_pop_req(s, vq, 0, &s->ctrl_lock))) {
         virtio_scsi_handle_ctrl_req(s, req);
     }
 }
@@ -854,13 +854,14 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
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
@@ -882,7 +883,7 @@ static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
     req->sreq = scsi_req_new(d, req->req.cmd.tag,
                              virtio_scsi_get_lun(req->req.cmd.lun),
-                             req->req.cmd.cdb, vs->cdb_size, req);
+                             req->req.cmd.cdb, cdb_size, req);
 
     if (req->sreq->cmd.mode != SCSI_XFER_NONE
         && (req->sreq->cmd.mode != req->mode ||
@@ -917,12 +918,15 @@ static void virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq)
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
@@ -993,7 +997,7 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
     }
 
     vs->sense_size = virtio_ldl_p(vdev, &scsiconf->sense_size);
-    vs->cdb_size = virtio_ldl_p(vdev, &scsiconf->cdb_size);
+    qatomic_set(&vs->cdb_size, virtio_ldl_p(vdev, &scsiconf->cdb_size));
 }
 
 static uint64_t virtio_scsi_get_features(VirtIODevice *vdev,
@@ -1054,7 +1058,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
         return;
     }
 
-    req = virtio_scsi_pop_req(s, vs->event_vq, &s->event_lock);
+    req = virtio_scsi_pop_req(s, vs->event_vq, 0, &s->event_lock);
     WITH_QEMU_LOCK_GUARD(&s->event_lock) {
         if (!req) {
             s->events_dropped = true;
-- 
2.47.3


