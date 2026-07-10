Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BCFC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Ty-0006Jp-KZ; Fri, 10 Jul 2026 06:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tx-0006Ic-Ey
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tv-0003zK-BY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783679358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCG9HAyi1whBiC4OnqxMq1aPNT1mXuU+57B+pSBea3g=;
 b=eBpRJYMdNDqCEt4wfL82h0huxZxHVZBwpVO+2iBoc3zUnv7EPC5Md1p4uAIs/e85uZabH0
 3CJrorr+Q6LQVfQ2+U4X6Tk1bY7/XTMyYRp8WLSJ0l2ixdF89otjqfRG1VEb2Sgq8ZumAh
 VB5668O4+8uHM7zGsQaFBh3WtfzUagI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-zxZodgI0NzCwXSgfi3aT7A-1; Fri,
 10 Jul 2026 06:29:16 -0400
X-MC-Unique: zxZodgI0NzCwXSgfi3aT7A-1
X-Mimecast-MFC-AGG-ID: zxZodgI0NzCwXSgfi3aT7A_1783679355
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA8CA1956041; Fri, 10 Jul 2026 10:29:15 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7830180056E; Fri, 10 Jul 2026 10:29:11 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, qemu-stable@nongnu.org
Subject: [PATCH 3/3] hw/scsi/virtio-scsi: harden virtio_scsi_load_request()
 against invalid stream
Date: Fri, 10 Jul 2026 12:28:59 +0200
Message-ID: <20260710102859.1967551-4-lvivier@redhat.com>
In-Reply-To: <20260710102859.1967551-1-lvivier@redhat.com>
References: <20260710102859.1967551-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio_scsi_load_request() uses assert() and exit(1) for conditions
that can be triggered by a crafted migration stream: an out-of-range
queue index, a malformed SCSI request, or a command mode mismatch.

Replace these with proper error returns so the migration fails
gracefully instead of aborting the destination QEMU process.

Cc: qemu-stable@nongnu.org
Fixes: 5db1764cc1f6 ("virtio-scsi: add migration support")
Fixes: d2ad7dd46e72 ("virtio-scsi: add multiqueue capability")
Fixes: 36b15c79aa1b ("virtio-scsi: start preparing for any_layout")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/scsi/virtio-scsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 8dd0b88a30c4..b34cda8fd85a 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -271,7 +271,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     uint32_t n;
 
     qemu_get_be32s(f, &n);
-    assert(n < vs->conf.num_queues);
+    if (n >= vs->conf.num_queues) {
+        return NULL;
+    }
+
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
     if (!req) {
@@ -283,14 +286,19 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
                               sizeof(VirtIOSCSICmdResp) + vs->sense_size) < 0) {
         error_report("invalid SCSI request migration data");
-        exit(1);
+        virtio_scsi_free_req(req);
+        return NULL;
     }
 
     scsi_req_ref(sreq);
     req->sreq = sreq;
-    if (req->sreq->cmd.mode != SCSI_XFER_NONE) {
-        assert(req->sreq->cmd.mode == req->mode);
+    if (req->sreq->cmd.mode != SCSI_XFER_NONE &&
+        req->sreq->cmd.mode != req->mode) {
+        scsi_req_unref(sreq);
+        virtio_scsi_free_req(req);
+        return NULL;
     }
+
     return req;
 }
 
-- 
2.54.0


