Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63356EA3C3C
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmhP-00019D-Bx; Thu, 09 Apr 2026 06:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAmhN-00018l-Tp
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAmhL-00009C-7t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775730797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6wVzzxEUdru13XNf+9PuoXL/B9TF0wuj0LinPwBVT4=;
 b=XoLOGds/gbKs6otu4FCAEnPFGCEPndOALLcUCtNMupJKj9HTluW7gR6R7sO+ztz3Mv2Tai
 eFVgxadHjfV9jduYVYCSmdYq5m18ykSzKsn3QlcX64+/ElXc6ynvh811o7KtuF7yPOKyhF
 DVk1NXi3GL0k+3R/om+6itQ5QqlxV5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ppFr4BtKPbGkmnyQTzf2ag-1; Thu, 09 Apr 2026 06:33:15 -0400
X-MC-Unique: ppFr4BtKPbGkmnyQTzf2ag-1
X-Mimecast-MFC-AGG-ID: ppFr4BtKPbGkmnyQTzf2ag_1775730794
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cff5bc312so694200f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775730793; x=1776335593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6wVzzxEUdru13XNf+9PuoXL/B9TF0wuj0LinPwBVT4=;
 b=N29H4NAvPyYPjTxjdQiHlPxxfc8/jJZMgQU0G+efNSOZAVGGuGlxcqM5OtwWkAcgiM
 sHCIsMUMzJ6/p4CEAXhSlMwQj05o1C5gnvKLUMhKGclKNdFWVzq2HK672wOI2XXUtccr
 P7B4SbiMsv44/h98r2CZMD9DUmNIWc8TKOzYT/aPglQUMBYYJL06csT6uGQ1Yx1DlO0t
 yPEd/rHuDt/mIbUts3/nBSYGcFUZUVdwv0Snp3n/XPXjC4LX8gW7RxGPP4iTQ3QHqXrV
 sEbBrnViHm+iCp1nlLKGhv6h2wA/HAS2QoflH9Qt0EnZmwtIqQxTjK6ISGKqhEhFTO5R
 /aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775730793; x=1776335593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6wVzzxEUdru13XNf+9PuoXL/B9TF0wuj0LinPwBVT4=;
 b=fqOwX9f2u4/2YbsYCsSlYtJr5jKqhoDHCWMpT+hZ2KogwroPwgd4F/8gkZ35h1UJ/m
 ix74NzD7see4EeDRmYhx+STRP0FS8fKavFOfxh0bSP+zWnVqsLWMc4Gc2SAMCsTWQt40
 xJOgQLat4oyAMWWFtrwgZy9cgH2qe0I6alMMnReb5T9y4mBsJCTJaBe3dvedlkzCNtPd
 +/HRhJW8DFHJKUGnbCNOTClHRyj9WcGGqfxtyWZdfQt1GcAoXviBtuCjbnFXoXJcsuCI
 W0uBfc9ndcKqSBpnph2CIhatWZeK4VfgIAd4EF5NSYI4t607wNE7SaqCbjjlWmo0wEgo
 b6Cw==
X-Gm-Message-State: AOJu0Yx1+8a9CcOMlKG65IrAjQzh087sOxxQLLvSVIwEK+WYChNrapFJ
 f46obLy/UnEanUsFyqf3KNA22xVMUN3AdO4udxGyxZa+3a9dEMebA3To44Hw/CMQCcU+jjtxEbf
 MZBmNdzFQT0ErgTGfZMd9Lio1f0NtHk2Sh2lOBUGJj5P5JB/OAbGSqoBmSBtJOKNpp3w26YYXn6
 31AYLVnWPpkaYJmBqBdVnSlmU5uvac46RCdL5jsh7P
X-Gm-Gg: AeBDieskMTLz3dchhgBFJlSoTYk+n0IcrkUYISoj7lzDv4Lv8co4566PoZOmb6qIf2K
 fuhGF/n+Bulkx8gG5IpH1SVI+nXwRJwnvRQFGbH7ARBDcdR3D1GIkuY91lrOsMsTeJCb+as5eO5
 1M3HNipWbWvOgbjMmEIJiGr0vfT5aDL2vgNgPDsyyQb9SeZqXe1X278d9jXMFWhftkVdPfGFjhJ
 l94N/TyIqLGknQkncM+U54KwssM0gTnKgJcAvZcGXd3/TP2Nb/pMlbwpHUl3YoaDskwMhnhaqEB
 9yfryChdcsp3gefsPQ9UMPjawTcv0H4NK+IQWDF6aSKM6yD/kNujJV/9Va6cReWnzH/SisdLj+Q
 lsyDt0GvdrpXkvPYS5Xg688bezWZmkc4Y2mS426G4FDfg+DfnYJcNK3SiuQnzWDdgb1NRZ4P8sB
 6YLGMn4nL/m+L41lCPmgIM4J/v
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488bc6a538bmr150325595e9.30.1775730793115; 
 Thu, 09 Apr 2026 03:33:13 -0700 (PDT)
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488bc6a538bmr150324965e9.30.1775730792543; 
 Thu, 09 Apr 2026 03:33:12 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd23058dsm64871575e9.13.2026.04.09.03.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 03:33:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jihe Wang <wangjihe.mail@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/1] virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req
 and virtio_scsi_handle_cmd_req_prepare
Date: Thu,  9 Apr 2026 12:33:09 +0200
Message-ID: <20260409103310.1884968-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409103310.1884968-1-pbonzini@redhat.com>
References: <20260409103310.1884968-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ensure that there is no allocation/usage mismatch when requests
are processed in virtio_scsi_handle_cmd_vq.  To do this,
retrieve the value once and pass it to both functions.

For other calls to virtio_scsi_pop_req the extra size
can be 0, because control and event requests fit
entirely in VirtIOSCSIReq.

Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Tested-by: Jihe Wang <wangjihe.mail@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 774968d8c70..6c737680119 100644
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
2.53.0


