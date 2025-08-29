Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A285FCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNfT-0006VI-Gg; Sat, 30 Aug 2025 11:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5OE-0006fq-Az
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5OC-0005J9-1k
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756498079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Fm5+NKWTXNmbcMVUNijv6+ysMm9REmdd9pZ77LGmk=;
 b=OOfjKHyQiPnVqcRNekwG6ACoHEbyYTzzMsQOr5ykO6umDDUWSuSxdgtONwx013DCtMV8g5
 LWjU+2vRMaX6Ms8TlY8y5E7KLxL84O+rcWFB+T99rrjBH97dEF9vUAEt52t3JpSK8ialq2
 2UsGsd9rg5GFzxZgEfBxeoaJ+qRzM6c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-6wn0r6gqNPO9fqRX0dgNDA-1; Fri, 29 Aug 2025 16:07:58 -0400
X-MC-Unique: 6wn0r6gqNPO9fqRX0dgNDA-1
X-Mimecast-MFC-AGG-ID: 6wn0r6gqNPO9fqRX0dgNDA_1756498077
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-325e31cece1so3633068a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756498077; x=1757102877;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2Fm5+NKWTXNmbcMVUNijv6+ysMm9REmdd9pZ77LGmk=;
 b=O5CYYNI1LTT6sCLM3oTMVIb0HotzcNCd53CJMGCJF/5fdQOv4v6U1YGMdeQHFqlTUV
 PCjBvZkwIDA4lai8eWfm5olr+8JEEe3ChkKpVHxBLY1h4+8Qzk+XVKKyM2t8TZogxG43
 hyOZIDRXfu0BoTIy7p8GZyPRcoxS+y03amoZ12CZR/skKXXkkdTIWjNqBR3CSsWGHOra
 kPHl/cKoCUDV87XWbqetCfLI1ctI5qqIdBomd4JgFKOPM8FHVJaFrrSvUczYqBw0nxcH
 fqky5rwaqMf3YU9m7rN+ENPFJA9AqUwmtO04PBJxZGPkhhpikpcr+wh26ATRJXz7bdN4
 UzWw==
X-Gm-Message-State: AOJu0YwH3XZfjjZKqLiKeyxHBx8BF1Q4oD7ZwNdemLQ+SDx8nhbu1Jp6
 0PKRGVgSdaKQHKk9l3TSBCOv2KOYgxkrYPBDqKuLCcbBSL8PWIrcHK9tNGcucOVjM9TWam6ztLM
 5tFBbwIaRL1BmFvD/Ke/OPlE9X8+BDui26xraxGY5qq2UBLXnLuTb9kef
X-Gm-Gg: ASbGncsw1lKCp2sU/9WAuBlVrr+4kKnI4RIa7juMYb+nAtF7/tqyg/n4drRX1QMK0b5
 DbFzDUjC1qLbzJ4G/J0cDqlsrY8kWC8kW5QpE0DwiwQK8lwcPk0BG23Qf5hjv+NViRmg+SQ2eXP
 IzKULE9StB47HnDtSmgq14F/LNFuTy4l13p4JRxWASgJmQKcKWXPNJ55gtUqVFP5tUGbQ64HZ54
 ezfBWvjEc/Y+nIJLl7P5sBTtxmJcMW/owJPQLWhGoMjr8iH0TdOTFyA4tG3Wc6rwSMg+QPTpa66
 pY4fP8SxO2i9eMHTHNNbGnuWSbD2Uy2vshVySs6oVGo6fMowXBh2IA==
X-Received: by 2002:a17:90b:2e4d:b0:31e:b77c:1f09 with SMTP id
 98e67ed59e1d1-3251774b61dmr39677304a91.19.1756498074254; 
 Fri, 29 Aug 2025 13:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBpY2vjGIkl3mZJ3ALCGw3W7zmfq2ZrqVIEI1rdX9aWjbXQx3UegocbzhliExdBEQBCsmFkw==
X-Received: by 2002:a17:90b:2e4d:b0:31e:b77c:1f09 with SMTP id
 98e67ed59e1d1-3251774b61dmr39677164a91.19.1756498071636; 
 Fri, 29 Aug 2025 13:07:51 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:07:51 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:32:04 +0530
Subject: [PATCH v13 24/27] migration: Remove error variant of
 vmstate_save_state() function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-propagate_tpm_error-v13-24-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=18020; i=armenon@redhat.com;
 h=from:subject:message-id; bh=1hkl0TuxMtTDC0XdBgCz3faKw7v6xH3wc1VTiv0ES74=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdj+j2FVucTn9UpxrQnYfF2Jzm3Rkxs9zW188U1rP8
 7Hr7Z3IjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNx1mJkmLrpuJG6P9Mv3p+X
 22bphaXe3BlbGc6ksCicTyQyOcR+GyPD+rrTy8z8P0lYfw4L+Z3V8e2WRWfdnMnLD8drVm+amWT
 CCgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/display/virtio-gpu.c     |  3 ++-
 hw/pci/pci.c                |  2 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  2 +-
 hw/vfio/pci.c               |  4 ++--
 hw/virtio/virtio-mmio.c     |  2 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  6 ++++--
 include/migration/vmstate.h |  2 --
 migration/cpr.c             |  3 +--
 migration/savevm.c          | 11 ++++++++---
 migration/vmstate-types.c   | 25 ++++++++++++++++++-------
 migration/vmstate.c         | 10 ++--------
 tests/unit/test-vmstate.c   | 20 +++++++++++++++++---
 ui/vdagent.c                |  3 ++-
 15 files changed, 61 insertions(+), 36 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 5dc31bc6bfb0272e29a4364ab10de2595a4bedf7..477ec700a130d77ad93346c264bb7eaa8bca76d5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1246,7 +1246,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL);
+    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
+                              &error_fatal);
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6be932d3bb67ff0c4808707db2a7b6378a90e82b..e53fd270118293ca82f40d45d8f97f62612736a1 100644
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
index 6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff..4cb1ced001ae241c53c503ebfd7c90e336799c37 100644
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
index da173f48676395cc02bd00cb3efa248afed4581b..f0a7dd2b882a13deec4a4c6d2eb4aae6d2fdbeb9 100644
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
index 1ecf150ed8218e8815655d3665f14ebac4382cf9..7c41687e4bab9e35b382bfceff66e82f68abaf56 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2789,8 +2789,8 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
-    return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
-                                       errp);
+    return vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL,
+                              errp);
 }
 
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0a688909fc606a3c9fde933667ae8c309ab527d0..fb58c36452730cfc92a0d26ff13e01e2d6654960 100644
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
index b04faa1e5c91b5cef40e54ec41d92422d16bfc13..d2595fbd55151aba2579bb01a59577c1a40b71e0 100644
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
index 018803c80d13107eb4e5e63914f9c1f837ab1b19..0a68f1b6f1ddb97a968c9c03ed4f37a38484d2f9 100644
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
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 056781b1c21e737583f081594d9f88b32adfd674..5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a 100644
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
diff --git a/migration/cpr.c b/migration/cpr.c
index 8abb6db76d2474157f804ece4c35ebfc8c22d21a..038f48f810aceb66d7988852240e2e5d9840ad1a 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -182,9 +182,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
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
index 71f4d8399349934134c2c02609d3ede6f61754f8..2c05b763148295d7e2095027aa143f45bc4c4676 100644
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
index c5cfd861e3aa5391245ef46bec9c90106c467e6e..a1cd7a95fa0148858dd883acf9a707b2b076d89e 100644
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
index 8d1e9eb62bb9a7506604016b0ed858855e685776..ad8e5b71ae2ce78e66a6426602e5c20405ec57c0 100644
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
index 4ff0ab632f7e08b922dfcf565f31b0e63c17f59e..cadbab3c5e2609e217e436d470d00356704f2c8f 100644
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
index bc3c77f01332a4b594cba00f3f9f9a5bca4d739a..ddb91e75c64a2af09d3f01e1b4900bd253513dd7 100644
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
2.51.0


