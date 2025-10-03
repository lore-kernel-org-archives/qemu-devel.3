Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82ACCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hug-0005GR-4J; Fri, 03 Oct 2025 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huF-0004wY-J6
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htg-0007gY-IF
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbdaztdpk7964Zy5VmtVo29Nkcd2q80Jq3K/CzqhHYM=;
 b=bdADZoWcQRogNK56XsmuYf9WPxlzjxE4l0sqxm6ZfTyCYyB16Vcv8Nrh4XvTDpNnXBey82
 N0U5zkRLWZiCzUmR5QrXLIBI7Hh2AG39NHMopgIXm5d3naXWvRn97G6EYBRagjPsLYUFrj
 9HmVnPBIjYkJIQPpf8iA9Jv9tmgSITQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-_VeqaCnuPuWp7N1z01AQag-1; Fri, 03 Oct 2025 11:40:29 -0400
X-MC-Unique: _VeqaCnuPuWp7N1z01AQag-1
X-Mimecast-MFC-AGG-ID: _VeqaCnuPuWp7N1z01AQag_1759506028
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e30eaca8eso74438166d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506028; x=1760110828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbdaztdpk7964Zy5VmtVo29Nkcd2q80Jq3K/CzqhHYM=;
 b=VmCd19+myIqRzvU614V9bAzHxzUvgo3ewKgvzHko2DszsqddxjHvUSTOV198Pf1TBC
 qnojjhujGUgRLKPdVUrnQ0TxsmJr7xzDnjsz+EJA3JDxlJybXUQbZnTw83O+niUSqoVe
 vz3zNGODuemepeB+cRvHk0sa1RdKbVcro8HnLGNkHsfNKyOOFkxZCCD3OVACmaeRfRjP
 xNBWd08ppUzw+b/WO3mcNSrYpWguXKHOG143/DPen3h7K8063h6BemkQ9Tn2WUYYrd+a
 Aqn9FdqAO+yxtrzmKLs2+h1wgL2i4sVgV9LUFc3JBPZW8Kv9h4L9ks2dqRaif8053TvO
 B3kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdTQKE0WnctTEH9liukmCbSgiX65VWwClTOeN1X8a0GsSZ5EFBa8jD/aaDsGIiWc6+0HX/4eANE6X5@nongnu.org
X-Gm-Message-State: AOJu0Yxn9FZOhpj7wNlXxWEPtRIg/nSUbeD5X11ogZYSGAQwDIzLB6Pe
 6r/G+f+4v+ZHPsqcbgqk6DhY2w5/mtH25L5Ezq5dR1mARV9pvNa8t46QOYTvZLvFmwR2ACpNXXu
 uB2NPrdL4GGXyoIgjhNJCoTHI+kmux5qmoHs9HM9XksUzp2IlmPPU7tNg
X-Gm-Gg: ASbGncvN0mFT2obihESMSCMoJpl516LhVE2bLRJ+87uxJfnyOgfbAz7YvrTBwnX+XTH
 EMY26HiDdTNUrSt6YEsnS+V3ZUTHacICmGxnPFTqPdzXUB/D8emnGVRVraJkYzmnI/BGQsnEYiN
 5JKcS5RkWGdHJyyzw8gFNkenmPJRUevDguo4rp3saNu9wavUGOV97NzxYpya3KunMhBybc2ubV1
 CiqGYFjfiQbGY8r5LmpHbReOPyTMHwnQbVi/1eQYzT0+sqRz515dW07rl7XNKnMaauqJu1sIEVk
 9Vo/gkczeYGuwtZ8nX5u9F0j9dfGUy67vlomZg==
X-Received: by 2002:ad4:5d4c:0:b0:7fb:ed4f:588 with SMTP id
 6a1803df08f44-879dc7a189dmr52325116d6.18.1759506028068; 
 Fri, 03 Oct 2025 08:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/SZGGQ2t0TlkIJW8Eftk3AtyROEF8IUhsIE13dG+BVM1UAyauTtzcrthHp8p5i+20IXug3A==
X-Received: by 2002:ad4:5d4c:0:b0:7fb:ed4f:588 with SMTP id
 6a1803df08f44-879dc7a189dmr52324586d6.18.1759506027422; 
 Fri, 03 Oct 2025 08:40:27 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 24/45] migration: Remove error variant of vmstate_save_state()
 function
Date: Fri,  3 Oct 2025 11:39:27 -0400
Message-ID: <20251003153948.1304776-25-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit removes the redundant vmstate_save_state_with_err()
function.

Previously, commit 969298f9d7 introduced vmstate_save_state_with_err()
to handle error propagation, while vmstate_save_state() existed for
non-error scenarios.
This is because there were code paths where vmstate_save_state_v()
(called internally by vmstate_save_state) did not explicitly set
errors on failure.

This change unifies error handling by
 - updating vmstate_save_state() to accept an Error **errp argument.
 - vmstate_save_state_v() ensures errors are set directly within the errp
   object, eliminating the need for two separate functions.

All calls to vmstate_save_state_with_err() are replaced with
vmstate_save_state(). This simplifies the API and improves code
maintainability.

vmstate_save_state() that only calls vmstate_save_state_v(),
by inference, also has errors set in errp in case of failure.
The errors are reported using error_report_err().
If we want the function to exit on error, then &error_fatal is
passed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-24-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/vmstate.h |  2 --
 hw/display/virtio-gpu.c     |  3 ++-
 hw/pci/pci.c                |  2 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  2 +-
 hw/vfio/pci.c               |  4 ++--
 hw/virtio/virtio-mmio.c     |  2 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  6 ++++--
 migration/cpr.c             |  3 +--
 migration/savevm.c          | 11 ++++++++---
 migration/vmstate-types.c   | 25 ++++++++++++++++++-------
 migration/vmstate.c         | 10 ++--------
 tests/unit/test-vmstate.c   | 20 +++++++++++++++++---
 ui/vdagent.c                |  3 ++-
 15 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c2..5fe9bbf390 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1198,8 +1198,6 @@ extern const VMStateInfo vmstate_info_qlist;
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc);
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e61585aa61..3a555125be 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1248,7 +1248,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
+                              &error_fatal);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 17715ca1b3..5e2c3c6fc2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -926,7 +926,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    vmstate_save_state(f, &vmstate_pci_device, s, NULL);
+    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
 }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 6a9641a03d..4cb1ced001 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1130,7 +1130,7 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
+    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index da173f4867..f0a7dd2b88 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -630,7 +630,7 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
     vscsi_req *req = sreq->hba_private;
     assert(req->active);
 
-    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL);
+    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &error_fatal);
 
     trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
                                    req->cur_desc_offset);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a5df4685d4..06b06afc2b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2821,8 +2821,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
-                                       errp);
+    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
+                              errp);
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0a688909fc..fb58c36452 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -613,7 +613,7 @@ static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_fatal);
 }
 
 static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b04faa1e5c..d2595fbd55 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -154,7 +154,7 @@ static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL);
+    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_fatal);
 }
 
 static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 018803c80d..0a68f1b6f1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2992,6 +2992,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
+    Error *local_err = NULL;
 
     if (k->save_config) {
         k->save_config(qbus->parent, f);
@@ -3035,14 +3036,15 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL);
+        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
 
     /* Subsections */
-    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL);
+    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fatal);
 }
 
 /* A wrapper for use as a VMState .put function */
diff --git a/migration/cpr.c b/migration/cpr.c
index 6b0e19651a..e0b47df222 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -183,9 +183,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
     qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
     qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
 
-    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
+    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0, errp);
     if (ret) {
-        error_setg(errp, "vmstate_save_state error %d", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index 996673b679..7b35ec4dd0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1056,8 +1056,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc,
-                                          errp);
+        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -1285,6 +1285,7 @@ void qemu_savevm_state_header(QEMUFile *f)
 {
     MigrationState *s = migrate_get_current();
     JSONWriter *vmdesc = s->vmdesc;
+    Error *local_err = NULL;
 
     trace_savevm_state_header();
     qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
@@ -1303,7 +1304,11 @@ void qemu_savevm_state_header(QEMUFile *f)
             json_writer_start_object(vmdesc, "configuration");
         }
 
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state, vmdesc);
+        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
+                           vmdesc, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
 
         if (vmdesc) {
             json_writer_end_object(vmdesc);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index c5cfd861e3..a1cd7a95fa 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -565,10 +565,14 @@ static int put_tmp(QEMUFile *f, void *pv, size_t size,
     const VMStateDescription *vmsd = field->vmsd;
     void *tmp = g_malloc(size);
     int ret;
+    Error *local_err = NULL;
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_save_state(f, vmsd, tmp, vmdesc);
+    ret = vmstate_save_state(f, vmsd, tmp, vmdesc, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
     g_free(tmp);
 
     return ret;
@@ -676,13 +680,15 @@ static int put_qtailq(QEMUFile *f, void *pv, size_t unused_size,
     size_t entry_offset = field->start;
     void *elm;
     int ret;
+    Error *local_err = NULL;
 
     trace_put_qtailq(vmsd->name, vmsd->version_id);
 
     QTAILQ_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -711,6 +717,7 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     struct put_gtree_data *capsule = (struct put_gtree_data *)data;
     QEMUFile *f = capsule->f;
     int ret;
+    Error *local_err = NULL;
 
     qemu_put_byte(f, true);
 
@@ -718,16 +725,20 @@ static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
     if (!capsule->key_vmsd) {
         qemu_put_be64(f, (uint64_t)(uintptr_t)(key)); /* direct key */
     } else {
-        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
+        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc,
+                                 &local_err);
         if (ret) {
+            error_report_err(local_err);
             capsule->ret = ret;
             return true;
         }
     }
 
     /* put the data */
-    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
+    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc,
+                             &local_err);
     if (ret) {
+        error_report_err(local_err);
         capsule->ret = ret;
         return true;
     }
@@ -857,14 +868,14 @@ static int put_qlist(QEMUFile *f, void *pv, size_t unused_size,
     size_t entry_offset = field->start;
     void *elm;
     int ret;
+    Error *local_err = NULL;
 
     trace_put_qlist(field->name, vmsd->name, vmsd->version_id);
     QLIST_RAW_FOREACH(elm, pv, entry_offset) {
         qemu_put_byte(f, true);
-        ret = vmstate_save_state(f, vmsd, elm, vmdesc);
+        ret = vmstate_save_state(f, vmsd, elm, vmdesc, &local_err);
         if (ret) {
-            error_report("%s: failed to save %s (%d)", field->name,
-                         vmsd->name, ret);
+            error_report_err(local_err);
             return ret;
         }
     }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 8d1e9eb62b..ad8e5b71ae 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -406,12 +406,6 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
 
 
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
-}
-
-int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id, Error **errp)
 {
     return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
@@ -512,7 +506,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop);
+                                             curr_elem, vmdesc_loop, errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, inner_field->vmsd,
                                                curr_elem, vmdesc_loop,
@@ -674,7 +668,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
+            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
             if (ret) {
                 return ret;
             }
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 4ff0ab632f..cadbab3c5e 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -67,9 +67,13 @@ static QEMUFile *open_test_file(bool write)
 static void save_vmstate(const VMStateDescription *desc, void *obj)
 {
     QEMUFile *f = open_test_file(true);
+    Error *local_err = NULL;
 
     /* Save file with vmstate */
-    int ret = vmstate_save_state(f, desc, obj, NULL);
+    int ret = vmstate_save_state(f, desc, obj, NULL, &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
     g_assert(!ret);
     qemu_put_byte(f, QEMU_VM_EOF);
     g_assert(!qemu_file_get_error(f));
@@ -438,10 +442,15 @@ static const VMStateDescription vmstate_skipping = {
 
 static void test_save_noskip(void)
 {
+    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = false };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
@@ -460,10 +469,15 @@ static void test_save_noskip(void)
 
 static void test_save_skip(void)
 {
+    Error *local_err = NULL;
     QEMUFile *fsave = open_test_file(true);
     TestStruct obj = { .a = 1, .b = 2, .c = 3, .d = 4, .e = 5, .f = 6,
                        .skip_c_e = true };
-    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL);
+    int ret = vmstate_save_state(fsave, &vmstate_skipping, &obj, NULL,
+                                 &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
     g_assert(!ret);
     g_assert(!qemu_file_get_error(fsave));
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bc3c77f013..ddb91e75c6 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -992,7 +992,8 @@ static int put_cbinfo(QEMUFile *f, void *pv, size_t size,
         }
     }
 
-    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc);
+    return vmstate_save_state(f, &vmstate_cbinfo_array, &cbinfo, vmdesc,
+                              &error_fatal);
 }
 
 static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
-- 
2.50.1


