Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84087C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udoiZ-0007nf-GZ; Mon, 21 Jul 2025 07:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiS-0007Fl-Fy
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoiP-0000dS-9u
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vv0w9CkGP2nw6HZu433doUIyOohVLJnA3g0FfFETVnI=;
 b=RFwi1w9mf70qM4miEJ2gwMKt3AaaGpgbL+meZHKcfLn5N6kR7RcsXG20CHy/DnqDbq6oTz
 B/f7zcv2fKshlK7lOJX6H1dkliE/J4x8Rxyf4jqoa058R+OaAU5fr2oknvbHV1DjoCaWfv
 MbC8TQVImvIJm2O2zFw8X8iX4E18KGs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-UtSNGATHMmq2NSzzAMTK3A-1; Mon, 21 Jul 2025 07:29:50 -0400
X-MC-Unique: UtSNGATHMmq2NSzzAMTK3A-1
X-Mimecast-MFC-AGG-ID: UtSNGATHMmq2NSzzAMTK3A_1753097389
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2354ba59eb6so60314775ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097389; x=1753702189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vv0w9CkGP2nw6HZu433doUIyOohVLJnA3g0FfFETVnI=;
 b=EijY+K7vWIJSqHYB3AZQaV0v1ofrjIT0LXY37a0XO8bZEWS0OVWJKwCbPzr92jLQd/
 6NosmKaXjYFMKOcdmDqs+Ja2HdHqpnZihKvFO0xqxgOWXropHtkLnF8nQfNSOHkjDf8h
 +vHMD7frO8UzUMN3qm7CA/sovYpuU8C5s5Akma3zScG1QLbjg8hUwOLqi9lQKBZ7hfRB
 qFAdrDYJCu7kOs3eKlk5f/FW8n2eGvbIGd28y8G+bkvP2/CjdDtHMrpzDpA8VWGhwzI7
 ohq9/c6jrhZJOApXv74U1CGfD6BBAnolvQSnsJNDHBxkRGKUyxzA+9PSonSWv39o27BF
 FZrg==
X-Gm-Message-State: AOJu0YzCi6K84n+5Yc/1bP3dO6gbMRRbyY06nQCEl1Wt0KFnDpNQtcwe
 newiBgcx/ZadkTzhoZ5Xd93o8LXbbFxJOaqV4A0kfih23zWhKixJYqIfkQbmw9p7+3uctPv4uI9
 krLGIf2kXM7/mrhRzvHwrsv5jyw7lF7T4qpuKgnRljVm5NxUNvXdirrJA
X-Gm-Gg: ASbGnctgB6C1VNIIdqg1a44ZtnDIpWo+J3QHWpCqjyZzYS5/Uj7+qdeZm++Rkix2mfs
 8rwxjdNbLv6YP8Rew2sj813PMQJ8gRS18HNxLaZIvL9zvqildXp2kAOIygFbZKzpHutxT24oLZx
 /Z3dpU++rW+dvyH/5WXiHqUyOfDOPz6Nu4CQwbFPfyorblzvclp8Ffw49BoW2P2GehArOqhgpiz
 oq5u3JxD7d/Icl0wXdZq4cstvNew1VuhBtNouGAS6YUpOl09NqgHZJk7pYoiTTrzBCXC9Q13Pf3
 RbEuliU7J0JhPmFGIyRnCfOZzOUL+KHrnI/0t/G9w4LfKmERGSr7
X-Received: by 2002:a17:902:f551:b0:235:ef67:b595 with SMTP id
 d9443c01a7336-23e2573e3ccmr273132475ad.35.1753097389168; 
 Mon, 21 Jul 2025 04:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFENJtILwxJf9YvrHZWVxYQ6XHIN/0eRWiCez8xxRN87KfYkmEbr+yGvMVbwBsZIsb+1+8XRg==
X-Received: by 2002:a17:902:f551:b0:235:ef67:b595 with SMTP id
 d9443c01a7336-23e2573e3ccmr273132035ad.35.1753097388595; 
 Mon, 21 Jul 2025 04:29:48 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:29:48 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:07 +0530
Subject: [PATCH v6 02/24] migration: push Error **errp into
 vmstate_load_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-propagate_tpm_error-v6-2-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20279; i=armenon@redhat.com;
 h=from:subject:message-id; bh=8UJMPfGRyMja7uGuP2a5dFDnIgQW9zljV+DnCV0RZC4=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adyoRezstiujurXT03sWqaCv9hWv9BYrE+z5TjfKf5P
 1xqm7eso5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwEQOH2f4p9Aovn5Bz8mHx+1K
 vlSdvrZkxpzTc/MVrb4+6O0TV4vaUsHwz9jCTJN3Ru5XR/2XbBWOya+Zc+vbVgTkhl1If/RxU1I
 lBwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that vmstate_load_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/display/virtio-gpu.c     |  2 +-
 hw/pci/pci.c                |  2 +-
 hw/s390x/virtio-ccw.c       |  2 +-
 hw/scsi/spapr_vscsi.c       |  2 +-
 hw/vfio/pci.c               |  2 +-
 hw/virtio/virtio-mmio.c     |  2 +-
 hw/virtio/virtio-pci.c      |  2 +-
 hw/virtio/virtio.c          |  4 ++--
 include/migration/vmstate.h |  2 +-
 migration/cpr.c             |  4 ++--
 migration/savevm.c          |  6 ++++--
 migration/vmstate-types.c   | 10 +++++-----
 migration/vmstate.c         | 45 ++++++++++++++++++++++++++++-----------------
 tests/unit/test-vmstate.c   | 18 +++++++++---------
 ui/vdagent.c                |  2 +-
 15 files changed, 59 insertions(+), 46 deletions(-)

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
index be05002b9819fafa45cf2fb4d2a0acdc475c558c..f8ce4a40dbe4c070a0d6c111051051ee97542719 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2797,7 +2797,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
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
index 767216d795998708f5716a23ae16c79cd90ff489..f8b52a611e56c22d844fd4cae3619da4f2686d03 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
+    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, NULL);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2ab1d20769495ea39445b87e3673b076ad172510..d5698b062a1e95437f6113f41136e90ae06f1974 100644
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
diff --git a/migration/cpr.c b/migration/cpr.c
index 42ad0b0d500e5de57faf0c6517e216b2d1c0cacf..74fac9521717ec568d14dabcbcb574b19fc1da67 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -233,9 +233,9 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
         return -ENOTSUP;
     }
 
-    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
+    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
     if (ret) {
-        error_setg(errp, "vmstate_load_state error %d", ret);
+        error_prepend(errp, "vmstate_load_state error %d ", ret);
         qemu_fclose(f);
         return ret;
     }
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296ae987d0c06ba6dafda63720205fecfd..ab947620f724874f325fb9fb59bef50b7c16fb51 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -969,7 +969,8 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
     if (!se->vmsd) {         /* Old style */
         return se->ops->load_state(f, se->opaque, se->load_version_id);
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id);
+    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
+                              NULL);
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -2839,7 +2840,8 @@ static int qemu_loadvm_state_header(QEMUFile *f)
             error_report("Configuration section missing");
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0);
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 NULL);
 
         if (ret) {
             return ret;
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
index 129b19d7603a0ddf8ab6e946e41c1c4d773d1fa8..288b57e1ed778cce21247b64d5e97dfef41ad586 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -132,29 +132,33 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
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
     if (vmsd->pre_load) {
         ret = vmsd->pre_load(opaque);
         if (ret) {
+            error_setg(errp, "VM pre load failed for: '%s', "
+                       "version_id: '%d', minimum version_id: '%d', ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
             return ret;
         }
     }
@@ -192,10 +196,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
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
@@ -211,27 +217,32 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 }
                 if (ret < 0) {
                     qemu_file_set_error(f, ret);
-                    error_report("Failed to load %s:%s", vmsd->name,
-                                 field->name);
+                    error_prepend(errp, "Failed to load %s:%s version_id: %d ",
+                                  vmsd->name, field->name, vmsd->version_id);
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
-    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
+    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
         return ret;
     }
     if (vmsd->post_load) {
         ret = vmsd->post_load(opaque, version_id);
+        if (ret < 0) {
+            error_setg(errp, "VM Post load failed for: %s, version_id: %d,"
+                       "minimum_version: %d, ret: %d", vmsd->name,
+                       vmsd->version_id, vmsd->minimum_version_id, ret);
+        }
     }
     trace_vmstate_load_state_end(vmsd->name, "end", ret);
     return ret;
@@ -607,11 +618,11 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
+        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
-            error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d",
-                       idstr, vmsd->name, ret);
+            error_prepend(errp, "Loading VM subsection '%s'"
+                          "in '%s' failed : %d ", idstr, vmsd->name, ret);
             return ret;
         }
     }
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
diff --git a/ui/vdagent.c b/ui/vdagent.c
index c0746fe5b168fdc7aeb4866de2ba0c3387566649..83457dee0767433ad0778b37b41b9c673a0e1860 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -1008,7 +1008,7 @@ static int get_cbinfo(QEMUFile *f, void *pv, size_t size,
 
     vdagent_clipboard_peer_register(vd);
 
-    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0);
+    ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0, NULL);
     if (ret) {
         return ret;
     }

-- 
2.50.0


