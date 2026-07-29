Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9083C55162
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYf-0002us-EG; Wed, 29 Jul 2026 19:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYd-0002sx-CT
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYa-0008Ci-Gm
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2U04ygb5A0LYjIKGN2pPN05EfGJxWffpsepBkk0yBCc=;
 b=YWbo8XIECTl/N36FmS/6OHKndcwAagwHPS037BvYXgSWG1brI9N0GMQSDt5kIVAKHyWFGV
 8/zy53TxQ8UZKhbOJRGvZU25/soLVO1Vx+qzse7Qh7Z3A7ZtyshX0W/4pPSnZpc/2WRChE
 phNVHrmrfGFaSQW2AHOLntFVpvtFI4Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-n5CbBHkdM-at4ycylzcpuQ-1; Wed,
 29 Jul 2026 19:19:15 -0400
X-MC-Unique: n5CbBHkdM-at4ycylzcpuQ-1
X-Mimecast-MFC-AGG-ID: n5CbBHkdM-at4ycylzcpuQ_1785367154
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AC661956043; Wed, 29 Jul 2026 23:19:13 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE7BA30001A4; Wed, 29 Jul 2026 23:19:09 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 1/7] VirtioDeviceClass: Add an Error parameter to vmstate
 load member
Date: Thu, 30 Jul 2026 01:18:58 +0200
Message-ID: <20260729231904.775331-2-lvivier@redhat.com>
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

Replace error_report() by error_setg() when it's possible.

In scsi-bus, check if error has been set by load_request, and propagate
it to caller.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3888
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: new patch to propagate errors properly through the load_request chain
        includes changes made by Michael S. Tsirkin in
        https://lore.kernel.org/qemu-devel/3777347521a12252e228e4a6243c75250bf76626.1784898250.git.mst@redhat.com

 hw/block/virtio-blk.c       |  7 ++++---
 hw/char/virtio-serial-bus.c | 20 +++++++++++---------
 hw/scsi/esp.c               |  2 +-
 hw/scsi/mptsas.c            |  2 +-
 hw/scsi/scsi-bus.c          | 18 ++++++++++++++++--
 hw/scsi/scsi-disk.c         |  7 ++++---
 hw/scsi/scsi-generic.c      |  3 ++-
 hw/scsi/spapr_vscsi.c       |  7 ++++---
 hw/scsi/virtio-scsi.c       |  3 ++-
 hw/usb/dev-storage.c        |  2 +-
 hw/virtio/virtio.c          |  5 +++--
 include/hw/scsi/scsi.h      |  4 ++--
 include/hw/usb/msd.h        |  2 +-
 include/hw/virtio/virtio.h  |  2 +-
 14 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff4c..352b897c4ae5 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1364,7 +1364,7 @@ static void virtio_blk_save_device(VirtIODevice *vdev, QEMUFile *f)
 }
 
 static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
-                                  int version_id)
+                                  int version_id, Error **errp)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
@@ -1377,8 +1377,9 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
             vq_idx = qemu_get_be32(f);
 
             if (vq_idx >= nvqs) {
-                error_report("Invalid virtqueue index in request list: %#x",
-                             vq_idx);
+                error_setg(errp,
+                           "Invalid virtqueue index in request list: 0x%x",
+                           vq_idx);
                 return -EINVAL;
             }
         }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248fc..87bfe51b6e93 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -725,8 +725,8 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
     s->post_load = NULL;
 }
 
-static int fetch_active_ports_list(QEMUFile *f,
-                                   VirtIOSerial *s, uint32_t nr_active_ports)
+static int fetch_active_ports_list(QEMUFile *f, VirtIOSerial *s,
+                                   uint32_t nr_active_ports, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     uint32_t i;
@@ -749,6 +749,7 @@ static int fetch_active_ports_list(QEMUFile *f,
         id = qemu_get_be32(f);
         port = find_port_by_id(s, id);
         if (!port) {
+            error_setg(errp, "Invalid port id %u", id);
             return -EINVAL;
         }
 
@@ -776,7 +777,7 @@ static int fetch_active_ports_list(QEMUFile *f,
 }
 
 static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
-                                     int version_id)
+                                     int version_id, Error **errp)
 {
     VirtIOSerial *s = VIRTIO_SERIAL(vdev);
     uint32_t max_nr_ports, nr_active_ports, ports_map;
@@ -794,10 +795,8 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
         qemu_get_be32s(f, &ports_map);
 
         if (ports_map != s->ports_map[i]) {
-            /*
-             * Ports active on source and destination don't
-             * match. Fail migration.
-             */
+            error_setg(errp, "Ports active on source (%u) and destination (%u)"
+                       " don't match", ports_map, s->ports_map[i]);
             return -EINVAL;
         }
     }
@@ -805,8 +804,11 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
     qemu_get_be32s(f, &nr_active_ports);
 
     if (nr_active_ports) {
-        ret = fetch_active_ports_list(f, s, nr_active_ports);
-        if (ret) {
+        Error *local_err = NULL;
+
+        ret = fetch_active_ports_list(f, s, nr_active_ports, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
             return ret;
         }
     }
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 933271431ba0..a99bfe8e9428 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1539,7 +1539,7 @@ static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
     return val;
 }
 
-static void *esp_load_request(QEMUFile *f, SCSIRequest *req)
+static void *esp_load_request(QEMUFile *f, SCSIRequest *req, Error **errp)
 {
     ESPState *s = container_of(req->bus, ESPState, bus);
 
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 5df124c0ce50..45638af0afc3 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1230,7 +1230,7 @@ static void mptsas_save_request(QEMUFile *f, SCSIRequest *sreq)
     }
 }
 
-static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq)
+static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
 {
     SCSIBus *bus = sreq->bus;
     MPTSASState *s = container_of(bus, MPTSASState, bus);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index deb43d5560e3..9e9bb977bee3 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1921,10 +1921,24 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
         req = scsi_req_new(s, tag, lun, buf, sizeof(buf), NULL);
         req->retry = (sbyte == 1);
         if (bus->info->load_request) {
-            req->hba_private = bus->info->load_request(f, req);
+            Error *local_err = NULL;
+
+            req->hba_private = bus->info->load_request(f, req, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                scsi_req_unref(req);
+                return -1;
+            }
         }
         if (req->ops->load_request) {
-            req->ops->load_request(f, req);
+            Error *local_err = NULL;
+
+            req->ops->load_request(f, req, &local_err);
+            if (local_err) {
+                error_report_err(local_err);
+                scsi_req_unref(req);
+                return -1;
+            }
         }
 
         /* Just restart it later.  */
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c5e..00f12439d1b6 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -181,7 +181,7 @@ static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)
     }
 }
 
-static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
+static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req, Error **errp)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
 
@@ -204,12 +204,13 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
-static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)
+static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req,
+                                           Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
 
     if (s->migrate_emulated_scsi_request) {
-        scsi_disk_load_request(f, req);
+        scsi_disk_load_request(f, req, errp);
     }
 }
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8999f3b72006..20deb9a21250 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -53,7 +53,8 @@ static void scsi_generic_save_request(QEMUFile *f, SCSIRequest *req)
     }
 }
 
-static void scsi_generic_load_request(QEMUFile *f, SCSIRequest *req)
+static void scsi_generic_load_request(QEMUFile *f, SCSIRequest *req,
+                                      Error **errp)
 {
     SCSIGenericReq *r = DO_UPCAST(SCSIGenericReq, req, req);
 
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22ad..7768ec0bdd49 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -642,7 +642,7 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
                                    req->cur_desc_offset);
 }
 
-static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
+static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
 {
     SCSIBus *bus = sreq->bus;
     VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
@@ -657,8 +657,9 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     memset(req, 0, sizeof(*req));
     rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
     if (rc) {
-        fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
-        error_report_err(local_err);
+        error_propagate_prepend(errp, local_err,
+                                "VSCSI: failed loading request tag#%u: ",
+                                sreq->tag);
         return NULL;
     }
     assert(req->active);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a81..54667dc4f51d 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -261,7 +261,8 @@ static void virtio_scsi_save_request(QEMUFile *f, SCSIRequest *sreq)
     qemu_put_virtqueue_element(vdev, f, &req->elem);
 }
 
-static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
+static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq,
+                                      Error **errp)
 {
     SCSIBus *bus = sreq->bus;
     VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 040cf1505181..d74aa087de66 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -556,7 +556,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
     }
 }
 
-void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req)
+void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req, Error **errp)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607338c9..64d780b1336e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3610,8 +3610,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 
     if (vdc->load != NULL) {
-        ret = vdc->load(vdev, f, version_id);
-        if (ret) {
+        ret = vdc->load(vdev, f, version_id, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
             return ret;
         }
     }
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index c60c6e8810ea..51ccd02951c6 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -134,7 +134,7 @@ struct SCSIReqOps {
     uint8_t *(*get_buf)(SCSIRequest *req);
 
     void (*save_request)(QEMUFile *f, SCSIRequest *req);
-    void (*load_request)(QEMUFile *f, SCSIRequest *req);
+    void (*load_request)(QEMUFile *f, SCSIRequest *req, Error **errp);
 };
 
 struct SCSIBusInfo {
@@ -150,7 +150,7 @@ struct SCSIBusInfo {
     QEMUSGList *(*get_sg_list)(SCSIRequest *req);
 
     void (*save_request)(QEMUFile *f, SCSIRequest *req);
-    void *(*load_request)(QEMUFile *f, SCSIRequest *req);
+    void *(*load_request)(QEMUFile *f, SCSIRequest *req, Error **errp);
     void (*free_request)(SCSIBus *bus, void *priv);
 
     /*
diff --git a/include/hw/usb/msd.h b/include/hw/usb/msd.h
index 125d2c218f6d..167e7d3f2fe0 100644
--- a/include/hw/usb/msd.h
+++ b/include/hw/usb/msd.h
@@ -51,5 +51,5 @@ DECLARE_INSTANCE_CHECKER(MSDState, USB_STORAGE_DEV,
 void usb_msd_transfer_data(SCSIRequest *req, uint32_t len);
 void usb_msd_command_complete(SCSIRequest *req, size_t resid);
 void usb_msd_request_cancelled(SCSIRequest *req);
-void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req);
+void *usb_msd_load_request(QEMUFile *f, SCSIRequest *req, Error **errp);
 void usb_msd_handle_reset(USBDevice *dev);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d8865..bcb03154e243 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -268,7 +268,7 @@ struct VirtioDeviceClass {
      * use vmsd for new devices.
      */
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
-    int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
+    int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id, Error **errp);
     /* Post load hook in vmsd is called early while device is processed, and
      * when VirtIODevice isn't fully initialized.  Devices should use this instead,
      * unless they specifically want to verify the migration stream as it's
-- 
2.54.0


