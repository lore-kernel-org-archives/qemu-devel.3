Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC14CC44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whlem-0005GT-9l; Thu, 09 Jul 2026 06:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whlek-0005Cm-Ga
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whleg-0003hD-9I
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783591612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EEPfUffLyiCczr+0f4C8m/x6y6IhzudNuvSeKa4CCYE=;
 b=Ir3dmmynPpQgOU8kX8haW1yIOWPTz8FMBVG/HfrgCNCsaO1YDoBPIVLm7c1Ep6nv5j5H53
 +oYbjme/ZAJJGDcIe3giGmsH1IaQ38axCTnm0zad4qG3zR9jp97YqyezRTR7su4sVUXCgi
 raUZOZibgIHhN6TcLEY6e2itphxhhaM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-iM1BZif9PDO0zoeaza4SKg-1; Thu,
 09 Jul 2026 06:06:51 -0400
X-MC-Unique: iM1BZif9PDO0zoeaza4SKg-1
X-Mimecast-MFC-AGG-ID: iM1BZif9PDO0zoeaza4SKg_1783591610
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B4311800581; Thu,  9 Jul 2026 10:06:50 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 573F43000C34; Thu,  9 Jul 2026 10:06:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Amit Shah <amit@kernel.org>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] hw/virtio: return NULL from qemu_get_virtqueue_element() on
 invalid state
Date: Thu,  9 Jul 2026 12:06:44 +0200
Message-ID: <20260709100644.1878369-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu_get_virtqueue_element() uses assert() to check that the in_num
and out_num fields deserialized from the migration stream do not
exceed VIRTQUEUE_MAX_SIZE. A crafted migration stream can set these
fields to invalid values, hitting the assertion and aborting the
destination QEMU process.

Replace the assertions with a bounds check that returns NULL on
failure. Update all callers (virtio-serial-bus, virtio-blk,
virtio-scsi) to handle the NULL return and fail the migration
gracefully.

Cc: qemu-stable@nongnu.org
Fixes: 6bdc21c050a2 ("virtio: fix up max size checks")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3802
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/block/virtio-blk.c       |  4 ++++
 hw/char/virtio-serial-bus.c |  3 +++
 hw/scsi/virtio-scsi.c       |  4 ++++
 hw/virtio/virtio.c          | 11 ++++-------
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff4c..42c0f2553f18 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
         }
 
         req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
+        if (!req) {
+            return -EINVAL;
+        }
+
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
 
         WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248fc..879df158608a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -763,6 +763,9 @@ static int fetch_active_ports_list(QEMUFile *f,
 
             port->elem =
                 qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
+            if (!port->elem) {
+                return -EINVAL;
+            }
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6c7376801190..8dd0b88a30c4 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(n < vs->conf.num_queues);
     req = qemu_get_virtqueue_element(vdev, f,
                                      sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    if (!req) {
+        return NULL;
+    }
+
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a365530..7bccfdde33e7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2167,13 +2167,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
 
     qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 
-    /* TODO: teach all callers that this can fail, and return failure instead
-     * of asserting here.
-     * This is just one thing (there are probably more) that must be
-     * fixed before we can allow NDEBUG compilation.
-     */
-    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
-    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
+    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
+        data.out_num > ARRAY_SIZE(data.out_addr)) {
+        return NULL;
+    }
 
     elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
     elem->index = data.index;
-- 
2.54.0


