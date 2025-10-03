Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1CDCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4htY-0004ip-TH; Fri, 03 Oct 2025 11:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htH-0004gs-Gv
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4ht4-0007MD-E3
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759505998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSUm3WYnKhi6iJm6BweRi94d7E7W7vo8WWDzmnBDw90=;
 b=Xc20mTHpkD7SUR7BDbyKGeABEunlXI9DcTuridH/7kMN9Car+/EhqN1isd216Z1c9PgTbC
 Vg4DCq+IPJXggAL+5wu4Nq+QWTgt8t+LrNty0MQ1SI5KeOnliphMOxOr5kNTr+2YIt3jBQ
 bwg/phgzX9IKrHypce1sevVcwh2gq5E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-v9dxvVxGPZKbymwAu2z1fQ-1; Fri, 03 Oct 2025 11:39:56 -0400
X-MC-Unique: v9dxvVxGPZKbymwAu2z1fQ-1
X-Mimecast-MFC-AGG-ID: v9dxvVxGPZKbymwAu2z1fQ_1759505996
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso74416176d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759505996; x=1760110796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSUm3WYnKhi6iJm6BweRi94d7E7W7vo8WWDzmnBDw90=;
 b=p+lfW6zhANy0es0PKg+/tfXbQ2zpmgDwtjArmMM69YdefNCOFegPSizfrbI09x1TT1
 m/M6JOQ+4XZW4JSrhgEDd1BqThGcs1fQpc4qpm6RPBGKWlp8b+FhyhKTcTUMNdp19vmf
 aS6MNehcpJ3y/544PFyR1zsLFWZ/AXjO4qU908u4TLiBau4LIe8fu4rMo3aj0xbqwiNq
 qAEhzUkSk9nig3sZ/bCt+k/f5aSMl++AE7xrkE3mo5o3zdH25TZCfP5wT3wtV6w7wnln
 fw5wL7KWnUydvINSGB/82pxME2T80WmnivjpocXN+FXw7S/6vT/XI+5RRkNNe9TKTc3a
 8z0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX3nhOzAQUGyac0hBTaWQs4eMtELmpYIXs4BZTVQ0dTtu9ce64FF8EicJzqC+KVVwUKR/+6GorqWaA@nongnu.org
X-Gm-Message-State: AOJu0YxdjR9FDP4UqoDzb96gmUlj7Mf6oKkJVn9eHuyim3/KMT2fd9yE
 3/udXAlhugvh3C7B19ySm711xga/q+kRH20CVlUMD4O1lj59ve+J8Xd+cb/7KK1HpM9S6HVZjhV
 VKTtYD6g9MFx7gTe7MUWuOCXl7Nkm1qJ6zjx/dV3UfxKjqVXuxo0mT0Fe
X-Gm-Gg: ASbGnctzA8umfwrCZJHHlu/RHMp+6eV91Jx3L5IQpH4ejv/98yizvEnZNDRPP0MlORR
 ey3PsA1p/qt6RRO8+YJdGUhO9QJdYo8bCDTsqdXTDLaWvZfOfQx0V0zriW/2avknzboTQuSLDWE
 bsV0Zeq61DKFrZGYI7VFShrPYCOCAVjN5KfBd/v86gg6TUvtjeUj1NFtXgmTEHek0nAxwQv4CTz
 iNiD1IXGq8vINxEIE5pk+fPkQiqZm1PP0m5cn9yoHPEb/xRzveIHMiY9pocGeoHWhnS6cvcZ0dK
 4m0dwGDY7YIJ98CkrqK0dxu0bCF3m91ET0gvlQ==
X-Received: by 2002:a05:6214:e8e:b0:806:7173:3af5 with SMTP id
 6a1803df08f44-879dc84a9b5mr47894966d6.55.1759505995556; 
 Fri, 03 Oct 2025 08:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYw0R7S5ZkSCy5sfKaiJQjYZe1PkfSh9c/HB0eiSSAZL3zCcUUCJ9GaZiwQZvoIG7F+RarNQ==
X-Received: by 2002:a05:6214:e8e:b0:806:7173:3af5 with SMTP id
 6a1803df08f44-879dc84a9b5mr47894326d6.55.1759505994906; 
 Fri, 03 Oct 2025 08:39:54 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:39:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 02/45] migration: push Error **errp into vmstate_load_state()
Date: Fri,  3 Oct 2025 11:39:05 -0400
Message-ID: <20251003153948.1304776-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_load_state() must report an error
in errp, in case of failure.

The errors are temporarily reported using error_report_err().
This is removed in the subsequent patches in this series,
when we are actually able to propagate the error to the calling
function using errp. Whereas, if we want the function to exit on
error, then error_fatal is passed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-2-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  2 +-
 hw/display/virtio-gpu.c     |  2 +-
 hw/pci/pci.c                |  3 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  4 ++-
 hw/vfio/pci.c               |  5 ++-
 hw/virtio/virtio-mmio.c     |  3 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  7 +++--
 migration/cpr.c             |  3 +-
 migration/savevm.c          |  8 +++--
 migration/vmstate-types.c   | 28 ++++++++++-------
 migration/vmstate.c         | 61 +++++++++++++++++++++++------------
 tests/unit/test-vmstate.c   | 63 +++++++++++++++++++++++++++++++------
 ui/vdagent.c                |  5 ++-
 15 files changed, 143 insertions(+), 55 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac4..056781b1c2 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1196,7 +1196,7 @@ extern const VMStateInfo vmstate_info_qlist;
     }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id);
+                       void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc);
 int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index de35902213..e61585aa61 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1347,7 +1347,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
+    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c3df9d6656..17715ca1b3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
     int ret;
-    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
+    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
+                             &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
     return ret;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d2f85b39f3..6a9641a03d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
+    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 20f70fb272..da173f4867 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -642,15 +642,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
     vscsi_req *req;
     int rc;
+    Error *local_err = NULL;
 
     assert(sreq->tag < VSCSI_REQ_LIMIT);
     req = &s->reqs[sreq->tag];
     assert(!req->active);
 
     memset(req, 0, sizeof(*req));
-    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
+    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
     if (rc) {
         fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
+        error_report_err(local_err);
         return NULL;
     }
     assert(req->active);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5b022da19e..a5df4685d4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2831,13 +2831,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     PCIDevice *pdev = PCI_DEVICE(vdev);
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
     int bar, ret;
+    Error *local_err = NULL;
 
     for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
         old_addr[bar] = pdev->io_regions[bar].addr;
     }
 
-    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
+                             &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 532c67107b..0a688909fc 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -34,6 +34,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
 {
@@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..b04faa1e5c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..018803c80d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3235,6 +3235,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    Error *local_err = NULL;
 
     /*
      * We poison the endianness to ensure it does not get used before
@@ -3327,15 +3328,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (vdc->vmsd) {
-        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
+        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
 
     /* Subsections */
-    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
diff --git a/migration/cpr.c b/migration/cpr.c
index 9848a21ea6..6b0e19651a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -234,9 +234,8 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return -ENOTSUP;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
     if (ret) {
-        error_setg(errp, "vmstate_load_state error %d", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index abe0547f9b..55c99e0902 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
+                              &error_fatal);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2817,6 +2818,7 @@ static int qemu_loadvm_state_header(QEMUFile *f)
 {
     unsigned int v;
     int ret;
+    Error *local_err = NULL;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -2839,9 +2841,11 @@ static int qemu_loadvm_state_header(QEMUFile *f)
             error_report("Configuration section missing");
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 &local_err);
 
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588b7e..c5cfd861e3 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "trace.h"
+#include "qapi/error.h"
 
 /* bool */
 
@@ -543,13 +544,17 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
                    const VMStateField *field)
 {
     int ret;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     int version_id = field->version_id;
     void *tmp = g_malloc(size);
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_load_state(f, vmsd, tmp, version_id);
+    ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     g_free(tmp);
     return ret;
 }
@@ -626,6 +631,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
                       const VMStateField *field)
 {
     int ret = 0;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QTAILQ element */
     size_t size = field->size;
@@ -649,8 +655,9 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
         QTAILQ_RAW_INSERT_TAIL(pv, elm, entry_offset);
@@ -772,6 +779,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
     GTree *tree = *pval;
     void *key, *val;
     int ret = 0;
+    Error *local_err = NULL;
 
     /* in case of direct key, the key vmsd can be {}, ie. check fields */
     if (!direct_key && version_id > key_vmsd->version_id) {
@@ -803,18 +811,16 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
             key = (void *)(uintptr_t)qemu_get_be64(f);
         } else {
             key = g_malloc0(key_size);
-            ret = vmstate_load_state(f, key_vmsd, key, version_id);
+            ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
             if (ret) {
-                error_report("%s : failed to load %s (%d)",
-                             field->name, key_vmsd->name, ret);
+                error_report_err(local_err);
                 goto key_error;
             }
         }
         val = g_malloc0(val_size);
-        ret = vmstate_load_state(f, val_vmsd, val, version_id);
+        ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
         if (ret) {
-            error_report("%s : failed to load %s (%d)",
-                         field->name, val_vmsd->name, ret);
+            error_report_err(local_err);
             goto val_error;
         }
         g_tree_insert(tree, key, val);
@@ -872,6 +878,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
                      const VMStateField *field)
 {
     int ret = 0;
+    Error *local_err = NULL;
     const VMStateDescription *vmsd = field->vmsd;
     /* size of a QLIST element */
     size_t size = field->size;
@@ -892,10 +899,9 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
         if (ret) {
-            error_report("%s: failed to load %s (%d)", field->name,
-                         vmsd->name, ret);
+            error_report_err(local_err);
             g_free(elm);
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 08f2b562e3..8d1e9eb62b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -132,30 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
 }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id)
+                       void *opaque, int version_id, Error **errp)
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
-    Error *local_err = NULL;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
-        error_report("%s: incoming version_id %d is too new "
-                     "for local version_id %d",
-                     vmsd->name, version_id, vmsd->version_id);
+        error_setg(errp, "%s: incoming version_id %d is too new "
+                   "for local version_id %d",
+                   vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
         return -EINVAL;
     }
     if  (version_id < vmsd->minimum_version_id) {
-        error_report("%s: incoming version_id %d is too old "
-                     "for local minimum version_id  %d",
-                     vmsd->name, version_id, vmsd->minimum_version_id);
+        error_setg(errp, "%s: incoming version_id %d is too old "
+                   "for local minimum version_id %d",
+                   vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
     if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
+            error_setg(errp, "pre load hook failed for: '%s', "
+                       "version_id: %d, minimum version_id: %d, ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
             return ret;
         }
     }
@@ -193,13 +196,21 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id);
+                                             inner_field->vmsd->version_id,
+                                             errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
                     ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id);
+                                             inner_field->struct_version_id,
+                                             errp);
                 } else {
                     ret = inner_field->info->get(f, curr_elem, size,
                                                  inner_field);
+                    if (ret < 0) {
+                        error_setg(errp,
+                                   "Failed to load element of type %s for %s: "
+                                   "%d", inner_field->info->name,
+                                   inner_field->name, ret);
+                    }
                 }
 
                 /* If we used a fake temp field.. free it now */
@@ -209,31 +220,40 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
+                    if (ret < 0) {
+                        error_setg(errp,
+                                   "Failed to load %s state: stream error: %d",
+                                   vmsd->name, ret);
+                    }
                 }
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    error_report("Failed to load %s:%s", vmsd->name,
-                                 field->name);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
                 }
             }
         } else if (field->flags & VMS_MUST_EXIST) {
-            error_report("Input validation failed: %s/%s",
-                         vmsd->name, field->name);
+            error_setg(errp, "Input validation failed: %s/%s version_id: %d",
+                       vmsd->name, field->name, vmsd->version_id);
             return -1;
         }
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque, &local_err);
+    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
-        error_report_err(local_err);
         return ret;
     }
     if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
+        if (ret < 0) {
+            error_setg(errp,
+                       "post load hook failed for: %s, version_id: %d, "
+                       "minimum_version: %d, ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
+        }
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);
     return ret;
@@ -570,6 +590,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp)
 {
+    ERRP_GUARD();
     trace_vmstate_subsection_load(vmsd->name);
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
@@ -609,12 +630,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
+        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
-            error_setg(errp,
-                       "Loading VM subsection '%s' in '%s' failed: %d",
-                       idstr, vmsd->name, ret);
+            error_prepend(errp,
+                          "Loading VM subsection '%s' in '%s' failed: %d: ",
+                          idstr, vmsd->name, ret);
             return ret;
         }
     }
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 63f28f26f4..4ff0ab632f 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -30,6 +30,7 @@
 #include "../migration/savevm.h"
 #include "qemu/module.h"
 #include "io/channel-file.h"
+#include "qapi/error.h"
 
 static int temp_fd;
 
@@ -108,14 +109,16 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
 {
     QEMUFile *f;
     int ret;
+    Error *local_err = NULL;
 
     f = open_test_file(true);
     qemu_put_buffer(f, wire, size);
     qemu_fclose(f);
 
     f = open_test_file(false);
-    ret = vmstate_load_state(f, desc, obj, version);
+    ret = vmstate_load_state(f, desc, obj, version, &local_err);
     if (ret) {
+        error_report_err(local_err);
         g_assert(qemu_file_get_error(f));
     } else{
         g_assert(!qemu_file_get_error(f));
@@ -355,6 +358,8 @@ static const VMStateDescription vmstate_versioned = {
 
 static void test_load_v1(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 30,             /* c */
@@ -365,7 +370,10 @@ static void test_load_v1(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .b = 200, .e = 500, .f = 600 };
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
+    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 200);
@@ -378,6 +386,8 @@ static void test_load_v1(void)
 
 static void test_load_v2(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -391,7 +401,10 @@ static void test_load_v2(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj;
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
     g_assert_cmpint(obj.c, ==, 30);
@@ -467,6 +480,8 @@ static void test_save_skip(void)
 
 static void test_load_noskip(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -480,7 +495,10 @@ static void test_load_noskip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = false };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -493,6 +511,8 @@ static void test_load_noskip(void)
 
 static void test_load_skip(void)
 {
+    Error *local_err = NULL;
+    int ret;
     uint8_t buf[] = {
         0, 0, 0, 10,             /* a */
         0, 0, 0, 20,             /* b */
@@ -504,7 +524,10 @@ static void test_load_skip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -744,6 +767,8 @@ static void test_save_q(void)
 
 static void test_load_q(void)
 {
+    int ret;
+    Error *local_err = NULL;
     TestQtailq obj_q = {
         .i16 = -512,
         .i32 = 70000,
@@ -773,7 +798,10 @@ static void test_load_q(void)
     TestQtailq tgt;
 
     QTAILQ_INIT(&tgt.q);
-    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
+    ret = vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     char eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(tgt.i16, ==, obj_q.i16);
@@ -1115,6 +1143,8 @@ static void diff_iommu(TestGTreeIOMMU *iommu1, TestGTreeIOMMU *iommu2)
 
 static void test_gtree_load_domain(void)
 {
+    Error *local_err = NULL;
+    int ret;
     TestGTreeDomain *dest_domain = g_new0(TestGTreeDomain, 1);
     TestGTreeDomain *orig_domain = create_first_domain();
     QEMUFile *fload, *fsave;
@@ -1127,7 +1157,11 @@ static void test_gtree_load_domain(void)
 
     fload = open_test_file(false);
 
-    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
+    ret = vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
+                             &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
@@ -1230,6 +1264,8 @@ static void test_gtree_save_iommu(void)
 
 static void test_gtree_load_iommu(void)
 {
+    Error *local_err = NULL;
+    int ret;
     TestGTreeIOMMU *dest_iommu = g_new0(TestGTreeIOMMU, 1);
     TestGTreeIOMMU *orig_iommu = create_iommu();
     QEMUFile *fsave, *fload;
@@ -1241,7 +1277,10 @@ static void test_gtree_load_iommu(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
+    ret = vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
@@ -1363,6 +1402,8 @@ static void test_save_qlist(void)
 
 static void test_load_qlist(void)
 {
+    Error *local_err = NULL;
+    int ret;
     QEMUFile *fsave, *fload;
     TestQListContainer *orig_container = alloc_container();
     TestQListContainer *dest_container = g_new0(TestQListContainer, 1);
@@ -1376,7 +1417,11 @@ static void test_load_qlist(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
+    ret = vmstate_load_state(fload, &vmstate_container, dest_container, 1,
+                             &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(eof, ==, QEMU_VM_EOF);
diff --git a/ui/vdagent.c b/ui/vdagent.c
index c0746fe5b1..bc3c77f013 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -1001,6 +1001,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(pv);
     struct CBInfoArray cbinfo = {};
     int i, ret;
+    Error *local_err = NULL;
 
     if (!have_clipboard(vd)) {
         return 0;
@@ -1008,8 +1009,10 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
 
     vdagent_clipboard_peer_register(vd);
 
-    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
+    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
+                             &local_err);
     if (ret) {
+        error_report_err(local_err);
         return ret;
     }
 
-- 
2.50.1


