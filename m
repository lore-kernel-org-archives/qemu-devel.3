Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF1FC7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 12:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV8Ua-0002JT-AE; Fri, 27 Jun 2025 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8UW-0002ID-SF
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uV8UQ-00018J-8H
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751028452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5REs8nmr1uWVKsw4tYdcLSCBd6/bg8lC3+XCV1C99Q=;
 b=S5Cs1BqD6F9Zh3LvDyqj2oCvKqzHB+t1LWfyexniZ4+7rH4t77AwI+/KM1Nf+zIeospcj6
 /9xtAxa9zEeM8pLsCKE8283E6Oiowxsq4t0MhOE3fVPSM5xeLhUS4h+J+tr3J3EkQ/rEAk
 g6oAyU2erE+WvE/3tBFMgiDEuZ888/Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-p1wUrN8OO2-fKNo_5V7O6A-1; Fri, 27 Jun 2025 08:47:31 -0400
X-MC-Unique: p1wUrN8OO2-fKNo_5V7O6A-1
X-Mimecast-MFC-AGG-ID: p1wUrN8OO2-fKNo_5V7O6A_1751028450
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23536f7c2d7so34045395ad.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 05:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751028450; x=1751633250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5REs8nmr1uWVKsw4tYdcLSCBd6/bg8lC3+XCV1C99Q=;
 b=kYYV73nj3WN+wRd6/sm9qg9Tmw5fadC+FLF/soYsGIgV0rH3B5z0Nr8eO/kaIKC1zg
 ArXU7rwOi10+HsxQ4FnVFxB9m+OZBKMsCEOMhnE96aJ7nLNstxRbvw06AbTS3mwf6l2P
 jXQ2XCiFgna6lsxk4KF2LWiDFr8dO6R3DN0RvN9osdxauX0B8udnWw61kbBbxrW1U00F
 Wv79O6Bh0dTfTwwnX7Co0zGU1CgXlr9gVlPYeOnDbzKRUzeTvOw7Ph4SH/fYQVEr6NgO
 AmyFZ1uhSiI0aZj/nKlcUmJZT2gF4SRTSWpjbgwBsujqVo3u4qPgn2MKdXluGOFhAmNs
 ALYw==
X-Gm-Message-State: AOJu0Yw3unZqkkr+uIfUjFZl3zH2tRi1/kccb6fWzEBc21Q9BUR6Gn4l
 g+IxKszWJaGfQ8lLgpyRm/6HlLCpziVY4J9AxzrG5vAusJ+uymn3lwAiZNVWTNymzKHsQ5GUUTj
 V5KYzA8s/hIY4J8k5PjQao7qOdZN07xv2fsnsIrn5LxkvmdCwf0doFnyQ
X-Gm-Gg: ASbGncuRmgVPuj5OEszeDqJyRTEqvN5exoaY2CRgj2tBaMICNvgXLEO5EfnqnXjNyFF
 3r60f1HeLI/8kpCW7hWdpCRWwWARVVisrarQNVQDUWsc1+Cv0kP/Hv67Kp0EEzm0hnJXEUpSLio
 RVCNzfq9oR+6Qr4jUaUOILYp6uzPA1qelOm7plKThCZvgbApYAPPbmSxrAs1Tf9UnYz29QUAiaJ
 CsSQTrWVepAkWBLF7xWjSf5Cts0BRW5hr+8C22DHXYzWRRJ51dwJK+EPD4iSTuuqGYTf1uFIiY+
 KxCPoFKQa2d4XSTBsVySlnEDew2sgook
X-Received: by 2002:a17:902:f64f:b0:223:619e:71da with SMTP id
 d9443c01a7336-23ac4880725mr46487285ad.49.1751028449617; 
 Fri, 27 Jun 2025 05:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTXX+bcD2TUpBYX/4F23qUSe8sF/a+RRwGlDJL9KrPX3yd1fW6VXoijdazgFYGViO/UC3HSQ==
X-Received: by 2002:a17:902:f64f:b0:223:619e:71da with SMTP id
 d9443c01a7336-23ac4880725mr46486715ad.49.1751028449086; 
 Fri, 27 Jun 2025 05:47:29 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb39bfcesm16731575ad.135.2025.06.27.05.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 05:47:28 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 27 Jun 2025 18:16:58 +0530
Subject: [PATCH v2 1/2] migration: Pass Error object errp into vm state
 loading functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-propagate_tpm_error-v2-1-85990c89da29@redhat.com>
References: <20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com>
In-Reply-To: <20250627-propagate_tpm_error-v2-0-85990c89da29@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=37982; i=armenon@redhat.com;
 h=from:subject:message-id; bh=eol3/2qASXq39//w4m7Qq7gshMRzylSLDOLg86mMQ6A=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0bcpEv3Drq+eLwqL/OH55p6E2Oe1lu5l6+UZ9UyK/3c8
 MLgDOuNjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABNJCGb4p/6kv8zl5GSd2RYx
 n1cva/54XDTy/fTdr0/MMpxccvfJdBFGhhPvzxj92DP9vorO98eVt8Kdk8ysd2xLi944azbDlVs
 GetwA
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

- This is an incremental step in converting vmstate loading
  code to report errors.
- Minimal changes to the signature and body of the following
  functions are done,
  - vmstate_load()
  - vmstate_load_state()
  - vmstate_subsection_load()
  - qemu_load_device_state()
  - qemu_loadvm_state()
  - qemu_loadvm_section_start_full()
  - qemu_loadvm_section_part_end()
  - qemu_loadvm_state_header()
  - qemu_loadvm_state_main()
- error_report() has been replaced with error_setg();
  and in places where error has been already set,
  error_prepend() is used to not lose information.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/display/virtio-gpu.c     |   2 +-
 hw/pci/pci.c                |   2 +-
 hw/s390x/virtio-ccw.c       |   2 +-
 hw/scsi/spapr_vscsi.c       |   2 +-
 hw/vfio/pci.c               |   2 +-
 hw/virtio/virtio-mmio.c     |   2 +-
 hw/virtio/virtio-pci.c      |   2 +-
 hw/virtio/virtio.c          |   4 +-
 include/migration/vmstate.h |   2 +-
 migration/colo.c            |  13 +++--
 migration/cpr.c             |   2 +-
 migration/migration.c       |  19 ++++--
 migration/savevm.c          | 137 +++++++++++++++++++++++++++-----------------
 migration/savevm.h          |   7 ++-
 migration/vmstate-types.c   |  10 ++--
 migration/vmstate.c         |  40 +++++++------
 tests/unit/test-vmstate.c   |  18 +++---
 17 files changed, 158 insertions(+), 108 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5d2ca8d8b864350133a674802d7316abd379591c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
+    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, NULL);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..2ab5d30bb3c319ac1c7bfc9a2acf6a2b38082066 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -934,7 +934,7 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
     int ret;
-    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
+    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id, NULL);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
     return ret;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..2f6feff2b0a22d7d7f6aecfd7e7870d8362f1a73 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
+    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, NULL);
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 20f70fb2729de78b9636a6b8c869695dab4f8902..573fdea668536b464bca11f001e9e0288e781493 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -648,7 +648,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(!req->active);
 
     memset(req, 0, sizeof(*req));
-    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
+    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, NULL);
     if (rc) {
         fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
         return NULL;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index fa25bded25c51f8efb6c5ad31bd90506cd69745c..87aee0a5701087f9a68ea435bb96e9d6b07b0c24 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2715,7 +2715,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
         old_addr[bar] = pdev->io_regions[bar].addr;
     }
 
-    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1, NULL);
     if (ret) {
         return ret;
     }
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..9058b1563462d4464dcba799643a583c93fb5683 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -619,7 +619,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, NULL);
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index fba2372c93bfd648736b07e4bc83e7097baa58cb..50a1f5701754b88e8a1ee062d6eeedfd848cb4f5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -160,7 +160,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, NULL);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d1c0427d55f7cb73398adfc94e678fe..66d5941f68a4b9e1e5390bb0aa45fc6cd34e2a1e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3317,14 +3317,14 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (vdc->vmsd) {
-        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
+        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, NULL);
         if (ret) {
             return ret;
         }
     }
 
     /* Subsections */
-    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
+    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, NULL);
     if (ret) {
         return ret;
     }
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..056781b1c21e737583f081594d9f88b32adfd674 100644
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
diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..808c980b4af3199968771cdc6cca3c2451a2f4a6 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -659,6 +659,7 @@ void migrate_start_colo_process(MigrationState *s)
 static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
                       QEMUFile *fb, QIOChannelBuffer *bioc, Error **errp)
 {
+    ERRP_GUARD();
     uint64_t total_size;
     uint64_t value;
     Error *local_err = NULL;
@@ -686,11 +687,13 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     bql_lock();
     cpu_synchronize_all_states();
-    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
+    ret = qemu_loadvm_state_main(mis->from_src_file, mis, &local_err);
     bql_unlock();
 
     if (ret < 0) {
-        error_setg(errp, "Load VM's live state (ram) error");
+        if (local_err != NULL) {
+            error_prepend(errp, "Load VM's live state (ram) error");
+        }
         return;
     }
 
@@ -729,9 +732,11 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, &local_err);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        if (*errp != NULL) {
+            error_prepend(errp, "COLO: load device state failed");
+        }
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/cpr.c b/migration/cpr.c
index a50a57edca754b50e68fa9c294b3c89791e62ba8..0fb9fadac905c83689eed2b1193b282da679b6ef 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -235,7 +235,7 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return -ENOTSUP;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
     if (ret) {
         error_setg(errp, "vmstate_load_state error %d", ret);
         qemu_fclose(f);
diff --git a/migration/migration.c b/migration/migration.c
index 4098870bce33ffdc57b5972fc5b106d88abb237e..ac06eb7b0195bfbcfe7662c91f109b2ff982146f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -876,7 +876,7 @@ process_incoming_migration_co(void *opaque)
                       MIGRATION_STATUS_ACTIVE);
 
     mis->loadvm_co = qemu_coroutine_self();
-    ret = qemu_loadvm_state(mis->from_src_file);
+    ret = qemu_loadvm_state(mis->from_src_file, &local_err);
     mis->loadvm_co = NULL;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
@@ -903,7 +903,10 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
+        if (local_err != NULL) {
+            error_prepend(&local_err, "load of migration failed: %s: ",
+                          strerror(-ret));
+        }
         goto fail;
     }
 
@@ -918,15 +921,19 @@ process_incoming_migration_co(void *opaque)
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
-    migrate_set_error(s, local_err);
-    error_free(local_err);
+    if (local_err) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    }
 
     migration_incoming_state_destroy();
 
     if (mis->exit_on_error) {
         WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
-            s->error = NULL;
+            if (s->error) {
+                error_report_err(s->error);
+                s->error = NULL;
+            }
         }
 
         exit(EXIT_FAILURE);
diff --git a/migration/savevm.c b/migration/savevm.c
index bb04a4520df9a443d90cf6cb52a383a5f053aaff..09329ba9a9f13e9bbed52def5245151c2c2ee803 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -963,13 +963,14 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
     }
 }
 
-static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
+static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
 {
     trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
+                              errp);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2071,6 +2072,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
+    Error *local_err = NULL;
     int load_res;
     MigrationState *migr = migrate_get_current();
 
@@ -2089,7 +2091,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2115,7 +2117,11 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            if (local_err != NULL) {
+                error_prepend(&local_err, "%s: loadvm failed: %d", __func__,
+                              load_res);
+                migrate_set_error(migr, local_err);
+            }
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }
@@ -2394,6 +2400,8 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
     int ret;
     size_t length;
     QIOChannelBuffer *bioc;
+    Error *local_error;
+    MigrationState *migr = migrate_get_current();
 
     length = qemu_get_be32(mis->from_src_file);
     trace_loadvm_handle_cmd_packaged(length);
@@ -2440,7 +2448,12 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
         qemu_coroutine_yield();
     } while (1);
 
-    ret = qemu_loadvm_state_main(packf, mis);
+    ret = qemu_loadvm_state_main(packf, mis, &local_error);
+    if (ret < 0 && local_error != NULL) {
+        error_prepend(&local_error, "%s: loadvm failed: %d", __func__,
+                      ret);
+        migrate_set_error(migr, local_error);
+    }
     trace_loadvm_handle_cmd_packaged_main(ret);
     qemu_fclose(packf);
     object_unref(OBJECT(bioc));
@@ -2674,8 +2687,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
 }
 
 static int
-qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
     uint32_t instance_id, version_id, section_id;
     int64_t start_ts, end_ts;
@@ -2686,8 +2700,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Read section start */
     section_id = qemu_get_be32(f);
     if (!qemu_get_counted_string(f, idstr)) {
-        error_report("Unable to read ID string for section %u",
-                     section_id);
+        error_setg(errp, "Unable to read ID string for section %u",
+                   section_id);
         return -EINVAL;
     }
     instance_id = qemu_get_be32(f);
@@ -2695,8 +2709,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read instance/version ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read instance/version ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2705,17 +2719,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
     /* Find savevm section */
     se = find_se(idstr, instance_id);
     if (se == NULL) {
-        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
-                     "Make sure that your current VM setup matches your "
-                     "saved VM setup, including any hotplugged devices",
-                     idstr, instance_id);
+        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
+                   "Make sure that your current VM setup matches your "
+                   "saved VM setup, including any hotplugged devices",
+                   idstr, instance_id);
         return -EINVAL;
     }
 
     /* Validate version */
     if (version_id > se->version_id) {
-        error_report("savevm: unsupported version %d for '%s' v%d",
-                     version_id, idstr, se->version_id);
+        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
+                   version_id, idstr, se->version_id);
         return -EINVAL;
     }
     se->load_version_id = version_id;
@@ -2723,7 +2737,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 
     /* Validate if it is a device's state */
     if (xen_enabled() && se->is_ram) {
-        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
+        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
         return -EINVAL;
     }
 
@@ -2731,10 +2745,13 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%"PRIx32" of"
-                     " device '%s'", instance_id, idstr);
+        if (*errp != NULL) {
+            error_prepend(errp, "error while loading state for "
+                          "instance 0x%"PRIx32" of"
+                          " device '%s'", instance_id, idstr);
+        }
         return ret;
     }
 
@@ -2752,8 +2769,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
+    ERRP_GUARD();
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
@@ -2764,8 +2782,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "%s: Failed to read section ID: %d",
+                   __func__, ret);
         return ret;
     }
 
@@ -2776,7 +2794,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown savevm section %d", section_id);
         return -EINVAL;
     }
 
@@ -2784,10 +2802,12 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report("error while loading state section id %d(%s)",
-                     section_id, se->idstr);
+        if (*errp != NULL) {
+            error_prepend(errp, "error while loading state section id %d(%s)",
+                          section_id, se->idstr);
+        }
         return ret;
     }
 
@@ -2804,33 +2824,38 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream magic %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp, "SaveVM v2 format is obsolete and don't work anymore");
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
 
         if (ret) {
             return ret;
@@ -3019,7 +3044,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     return true;
 }
 
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp)
 {
     uint8_t section_type;
     int ret = 0;
@@ -3037,14 +3063,14 @@ retry:
         switch (section_type) {
         case QEMU_VM_SECTION_START:
         case QEMU_VM_SECTION_FULL:
-            ret = qemu_loadvm_section_start_full(f, section_type);
+            ret = qemu_loadvm_section_start_full(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3060,7 +3086,7 @@ retry:
             /* This is the end of migration */
             goto out;
         default:
-            error_report("Unknown savevm section type %d", section_type);
+            error_setg(errp, "Unknown savevm section type %d", section_type);
             ret = -EINVAL;
             goto out;
         }
@@ -3094,7 +3120,7 @@ out:
     return ret;
 }
 
-int qemu_loadvm_state(QEMUFile *f)
+int qemu_loadvm_state(QEMUFile *f, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -3102,19 +3128,18 @@ int qemu_loadvm_state(QEMUFile *f)
     int ret;
 
     if (qemu_savevm_state_blocked(&local_err)) {
-        error_report_err(local_err);
+        error_propagate(errp, local_err);
         return -EINVAL;
     }
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, errp);
     if (ret) {
         return ret;
     }
 
-    if (qemu_loadvm_state_setup(f, &local_err) != 0) {
-        error_report_err(local_err);
+    if (qemu_loadvm_state_setup(f, errp) != 0) {
         return -EINVAL;
     }
 
@@ -3124,7 +3149,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
@@ -3192,15 +3217,18 @@ int qemu_loadvm_state(QEMUFile *f)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
+    ERRP_GUARD();
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        if (*errp != NULL) {
+            error_prepend(errp, "Failed to load device state: %d", ret);
+        }
         return ret;
     }
 
@@ -3408,6 +3436,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
 
 void qmp_xen_load_devices_state(const char *filename, Error **errp)
 {
+    ERRP_GUARD();
     QEMUFile *f;
     QIOChannelFile *ioc;
     int ret;
@@ -3429,10 +3458,10 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     f = qemu_file_new_input(QIO_CHANNEL(ioc));
     object_unref(OBJECT(ioc));
 
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     qemu_fclose(f);
-    if (ret < 0) {
-        error_setg(errp, "loading Xen device state failed");
+    if (ret < 0 && *errp != NULL) {
+        error_prepend(errp, "loading Xen device state failed: ");
     }
     migration_incoming_state_destroy();
 }
@@ -3440,6 +3469,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
 bool load_snapshot(const char *name, const char *vmstate,
                    bool has_devices, strList *devices, Error **errp)
 {
+    ERRP_GUARD();
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
     QEMUFile *f;
@@ -3503,16 +3533,17 @@ bool load_snapshot(const char *name, const char *vmstate,
         ret = -EINVAL;
         goto err_drain;
     }
-    ret = qemu_loadvm_state(f);
+    ret = qemu_loadvm_state(f, errp);
     migration_incoming_state_destroy();
 
     bdrv_drain_all_end();
 
     if (ret < 0) {
-        error_setg(errp, "Error %d while loading VM state", ret);
+        if (*errp != NULL) {
+            error_prepend(errp, "Error %d while loading VM state: ", ret);
+        }
         return false;
     }
-
     return true;
 
 err_drain:
diff --git a/migration/savevm.h b/migration/savevm.h
index 2d5e9c716686f06720325e82fe90c75335ced1de..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,10 +64,11 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
 void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
-int qemu_loadvm_state(QEMUFile *f);
+int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
-int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
+                           Error **errp);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 741a588b7e18c6d37724b08a0101edc8bc74a0a5..1c5b76e1dd198030847971bc35637867c9d54fc0 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -549,7 +549,7 @@ static int get_tmp(QEMUFile *f, void *pv, size_t size,
 
     /* Writes the parent field which is at the start of the tmp */
     *(void **)tmp = pv;
-    ret = vmstate_load_state(f, vmsd, tmp, version_id);
+    ret = vmstate_load_state(f, vmsd, tmp, version_id, NULL);
     g_free(tmp);
     return ret;
 }
@@ -649,7 +649,7 @@ static int get_qtailq(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, NULL);
         if (ret) {
             return ret;
         }
@@ -803,7 +803,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
             key = (void *)(uintptr_t)qemu_get_be64(f);
         } else {
             key = g_malloc0(key_size);
-            ret = vmstate_load_state(f, key_vmsd, key, version_id);
+            ret = vmstate_load_state(f, key_vmsd, key, version_id, NULL);
             if (ret) {
                 error_report("%s : failed to load %s (%d)",
                              field->name, key_vmsd->name, ret);
@@ -811,7 +811,7 @@ static int get_gtree(QEMUFile *f, void *pv, size_t unused_size,
             }
         }
         val = g_malloc0(val_size);
-        ret = vmstate_load_state(f, val_vmsd, val, version_id);
+        ret = vmstate_load_state(f, val_vmsd, val, version_id, NULL);
         if (ret) {
             error_report("%s : failed to load %s (%d)",
                          field->name, val_vmsd->name, ret);
@@ -892,7 +892,7 @@ static int get_qlist(QEMUFile *f, void *pv, size_t unused_size,
 
     while (qemu_get_byte(f)) {
         elm = g_malloc(size);
-        ret = vmstate_load_state(f, vmsd, elm, version_id);
+        ret = vmstate_load_state(f, vmsd, elm, version_id, NULL);
         if (ret) {
             error_report("%s: failed to load %s (%d)", field->name,
                          vmsd->name, ret);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..158dcc3fcddfe70ab268dc5ace6e4573fa1ccbab 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -132,23 +132,23 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
 }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, int version_id)
+                       void *opaque, int version_id, Error **errp)
 {
     const VMStateField *field = vmsd->fields;
     int ret = 0;
 
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
+                   "for local minimum version_id  %d",
+                   vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
         return -EINVAL;
     }
@@ -192,10 +192,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
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
@@ -211,23 +213,27 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 }
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    error_report("Failed to load %s:%s", vmsd->name,
-                                 field->name);
+                    error_setg(errp, "Failed to load %s:%s", vmsd->name,
+                               field->name);
                     trace_vmstate_load_field_error(field->name, ret);
                     return ret;
                 }
             }
         } else if (field->flags & VMS_MUST_EXIST) {
-            error_report("Input validation failed: %s/%s",
-                         vmsd->name, field->name);
+            error_setg(errp, "Input validation failed: %s/%s",
+                       vmsd->name, field->name);
             return -1;
         }
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
+        if (*errp == NULL) {
+            error_setg(errp, "Load of field %s/%s failed",
+                       vmsd->name, field->name);
+        }
         return ret;
     }
     if (vmsd->post_load) {
@@ -566,7 +572,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -605,7 +611,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
+        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
             return ret;
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 63f28f26f45691a70936d33e7341d16477a3471f..ca5e0ba1e3e5e2bb0a1ce39143a292f2c6f9420a 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -114,7 +114,7 @@ static int load_vmstate_one(const VMStateDescription *desc, void *obj,
     qemu_fclose(f);
 
     f = open_test_file(false);
-    ret = vmstate_load_state(f, desc, obj, version);
+    ret = vmstate_load_state(f, desc, obj, version, NULL);
     if (ret) {
         g_assert(qemu_file_get_error(f));
     } else{
@@ -365,7 +365,7 @@ static void test_load_v1(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .b = 200, .e = 500, .f = 600 };
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 1);
+    vmstate_load_state(loading, &vmstate_versioned, &obj, 1, NULL);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 200);
@@ -391,7 +391,7 @@ static void test_load_v2(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj;
-    vmstate_load_state(loading, &vmstate_versioned, &obj, 2);
+    vmstate_load_state(loading, &vmstate_versioned, &obj, 2, NULL);
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
     g_assert_cmpint(obj.c, ==, 30);
@@ -480,7 +480,7 @@ static void test_load_noskip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = false };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -504,7 +504,7 @@ static void test_load_skip(void)
 
     QEMUFile *loading = open_test_file(false);
     TestStruct obj = { .skip_c_e = true, .c = 300, .e = 500 };
-    vmstate_load_state(loading, &vmstate_skipping, &obj, 2);
+    vmstate_load_state(loading, &vmstate_skipping, &obj, 2, NULL);
     g_assert(!qemu_file_get_error(loading));
     g_assert_cmpint(obj.a, ==, 10);
     g_assert_cmpint(obj.b, ==, 20);
@@ -773,7 +773,7 @@ static void test_load_q(void)
     TestQtailq tgt;
 
     QTAILQ_INIT(&tgt.q);
-    vmstate_load_state(fload, &vmstate_q, &tgt, 1);
+    vmstate_load_state(fload, &vmstate_q, &tgt, 1, NULL);
     char eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(tgt.i16, ==, obj_q.i16);
@@ -1127,7 +1127,7 @@ static void test_gtree_load_domain(void)
 
     fload = open_test_file(false);
 
-    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1);
+    vmstate_load_state(fload, &vmstate_domain, dest_domain, 1, NULL);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_domain->id, ==, dest_domain->id);
@@ -1241,7 +1241,7 @@ static void test_gtree_load_iommu(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
+    vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, NULL);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_iommu->id, ==, dest_iommu->id);
@@ -1376,7 +1376,7 @@ static void test_load_qlist(void)
     qemu_fclose(fsave);
 
     fload = open_test_file(false);
-    vmstate_load_state(fload, &vmstate_container, dest_container, 1);
+    vmstate_load_state(fload, &vmstate_container, dest_container, 1, NULL);
     eof = qemu_get_byte(fload);
     g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(eof, ==, QEMU_VM_EOF);

-- 
2.49.0


