Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBB1C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYs-0003PE-SM; Wed, 29 Jul 2026 19:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYo-00037K-Sd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYn-0008Fi-CE
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67WWBnFN4tlYKgPOBmTHpTwUwrzSTt9DuZyEdwHvf+I=;
 b=OPo5k4wyt15CjwJ4Rc6nAwH6M/hpHEFp9agetlsskcNva69VAhivKMAJeL2tJ122Rs1+fE
 IAejBNmpPG+pLKSFg8SOGZx4lGNZDwWLRtuBuJeNgiRP6J8vxr6JbENpByVlKTV2dxzXyS
 BqSLFtsse/B1EpoMRRJttueLsCPqlHo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-056JzQU3PYm8lXXVMxVFMA-1; Wed,
 29 Jul 2026 19:19:33 -0400
X-MC-Unique: 056JzQU3PYm8lXXVMxVFMA-1
X-Mimecast-MFC-AGG-ID: 056JzQU3PYm8lXXVMxVFMA_1785367172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 189C619560B2; Wed, 29 Jul 2026 23:19:32 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7A2230001A4; Wed, 29 Jul 2026 23:19:28 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 6/7] hw/scsi/virtio-scsi: harden virtio_scsi_load_request()
 against invalid stream
Date: Thu, 30 Jul 2026 01:19:03 +0200
Message-ID: <20260729231904.775331-7-lvivier@redhat.com>
In-Reply-To: <20260729231904.775331-1-lvivier@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Notes:
    v2: add error_setg() calls with descriptive error messages for
        all three error paths

 hw/scsi/virtio-scsi.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 10eee3a4cff8..8814b246048f 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -272,7 +272,12 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq,
     uint32_t n;
 
     qemu_get_be32s(f, &n);
-    assert(n < vs->conf.num_queues);
+    if (n >= vs->conf.num_queues) {
+        error_setg(errp, "Invalid queues number %u > %u", n,
+                   vs->conf.num_queues);
+        return NULL;
+    }
+
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
     if (!req) {
@@ -283,14 +288,20 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq,
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
                               sizeof(VirtIOSCSICmdResp) + vs->sense_size) < 0) {
-        error_report("invalid SCSI request migration data");
-        exit(1);
+        error_setg(errp, "invalid SCSI request migration data");
+        virtio_scsi_free_req(req);
+        return NULL;
     }
 
     scsi_req_ref(sreq);
     req->sreq = sreq;
-    if (req->sreq->cmd.mode != SCSI_XFER_NONE) {
-        assert(req->sreq->cmd.mode == req->mode);
+    if (req->sreq->cmd.mode != SCSI_XFER_NONE &&
+        req->sreq->cmd.mode != req->mode) {
+        error_setg(errp, "Invalid SCSI request mode %u",
+                   req->sreq->cmd.mode);
+        scsi_req_unref(sreq);
+        virtio_scsi_free_req(req);
+        return NULL;
     }
     return req;
 }
-- 
2.54.0


