Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68712CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1la-000104-Vg; Mon, 03 Nov 2025 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lY-0000zV-OG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lR-0005Kl-66
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj+0pxI4lX/qhV1OXSMqDypY0kD1YjJGi5U/LX9aV1k=;
 b=boBZXOR0322DlNOROylGQ6ANZHsjNrHqj0x6P+4QpuhKKi51xhEMuVHXrT3jpokrPZPJMJ
 gh0/YwbY6Vv+ULC5k+SrBNgRPllWvWJNhHs4o7cjCEbSUu/jbw9Uj13XdD/PxN8kwvJH9B
 XXzPZoBB3BE16HFLQvG7xirh6alKv30=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-OrjJIMkNMXm8gUAt4vi5KA-1; Mon, 03 Nov 2025 16:06:53 -0500
X-MC-Unique: OrjJIMkNMXm8gUAt4vi5KA-1
X-Mimecast-MFC-AGG-ID: OrjJIMkNMXm8gUAt4vi5KA_1762204013
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-89fcdd9f931so557702385a.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204012; x=1762808812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sj+0pxI4lX/qhV1OXSMqDypY0kD1YjJGi5U/LX9aV1k=;
 b=CG6H96OQzGe8Gfh+8aW9QN+nGql68qpOd8uzNehknBAv9Hg2/vjpaXPayK7LsLP/6w
 id/eIdqBJ5vvvpIKoR+Zw4FoWAQnORKn+WFLEnoygGiooxN1QNiXHbDUpRbU0Ne/2UWh
 qams3NyeBvzbVmJuvRMl8wZNWxsZbmvHtK1Z04oCZods76+co9wbwL14gKvNi5JoO0PA
 NLiECrjsddf69IbDD7AQgn7Viuwfa/kkOzOuJljJOJjOseeNdrnzTvB6q7M7SNmIkkpr
 ZMPRGcuEV2G7mp2iv6/aErMyUWn6IB+n7LUvwM8V8BwJwKws1j5Nn+BmnZL0aODIloSR
 jg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204012; x=1762808812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sj+0pxI4lX/qhV1OXSMqDypY0kD1YjJGi5U/LX9aV1k=;
 b=sDjNIobIeofKsPt6OEt+jdckSyYNxEheUu2wKQ540zKEtGxKvGKOXGdYfHjTfiLNNk
 thoaLiDzfb/0/KbEzi3OoqyUUVXRp+aR5alR0dYYFiJKu+HZrpbUX79N+jy4iOkIYewg
 1jy/0jgSoEjai1i++07LGL9x9Pa089Vtc5l+jTYhbYqDm1vuC6osVNpYRsNhW5WyU6gn
 5TpySliEloGFqfIrfaaD9Xrskm9DX2J1OQ62eGVRUFgyNjELOhxMxkVMhLC3mrJlNDsN
 GoTba8VhL0vggS/r6ss0/3LRoZBI+G+tIPRwt3E9oRrjxXftFOkJ9bUyx8XmwnJcTITd
 yIqA==
X-Gm-Message-State: AOJu0YwZm3NCm4T2x+iuvHCYVbXQskCyyybXa8tgC4mq9TAeI1T+JFnQ
 HqAC6mdHPuXgZh5l1+7L/y6UrwfugOib7NLBBN8zYT7j2NUIEP8tl/dobs6yUfs1f6OKSiLIkl4
 0ls7loQs9LsltvJw59PjjXKE1axGN8Xw8/6AI9iaiv5is0lkeECVbKJokCJriZvtnOW9XOHurDe
 CSIToMxGRvZd7HUWapXe2IUrt3gtBLJWv8QiQVoQ==
X-Gm-Gg: ASbGncsP8r7yko9i4q0pAQGFQBkMahS4r8V0ETJnI3CG33fl5qMnY0FBB8plNdF6RM8
 ed+yLA3f6Pz6Lqb3oGmpI0PXp8vd3AkUNhbnTs+5ysnVeARZ1GilbMA67tU5fhd31jSE6q0PlOL
 6fFbwAFe26ZwvPAdFb3IrsL4ycIESYEN0/8rC6hwVGqe8Pq96bpf9mkOS6iPVaKjfH7qGJ9yFfy
 aLjxfe+2gVQ3QzPPMJkgHrJpyxyc1n4AlPmf5tSmMrs5gsAEs1Q8BWZw2YEfcb5KhiyE4E4SEL5
 OqCYSDZVfEwojpVmwInXoCMyKJOrWrjjHwLJ+/xzBjuWGZafH3iHqwGgX0ni6XeC
X-Received: by 2002:a05:620a:4507:b0:890:2e24:a543 with SMTP id
 af79cd13be357-8ab99a6f2bfmr1787408985a.34.1762204012221; 
 Mon, 03 Nov 2025 13:06:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOx5yJ2YmfNZuMuRCgZWHBwG/GZANG0P5yBZzUGv/9e6w2lRh2A45usAsHoHSKDRoooI7wJA==
X-Received: by 2002:a05:620a:4507:b0:890:2e24:a543 with SMTP id
 af79cd13be357-8ab99a6f2bfmr1787402385a.34.1762204011558; 
 Mon, 03 Nov 2025 13:06:51 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 16/36] migration: Fix regression of passing error_fatal into
 vmstate_load_state()
Date: Mon,  3 Nov 2025 16:06:05 -0500
Message-ID: <20251103210625.3689448-17-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

error_fatal is passed to vmstate_load_state() and vmstate_save_state()
functions. This was introduced in commit c632ffbd74. This would exit(1)
on error, and therefore does not allow to propagate the error back to
the caller.

To maintain consistency with prior error handling i.e. either propagating
the error to the caller or reporting it, we must set the error within a
local Error object instead of using error_fatal.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20251028-solve_error_fatal_regression-v2-1-dab24c808a28@redhat.com
[peterx: always uninit var ret, per Akihiko]
[peterx: touchups on line ordering, spacings etc.]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/display/virtio-gpu.c | 21 ++++++++++++++-------
 hw/pci/pci.c            | 15 +++++++++++++--
 hw/s390x/virtio-ccw.c   | 17 +++++++++++++++--
 hw/scsi/spapr_vscsi.c   | 10 ++++++++--
 hw/virtio/virtio-mmio.c | 15 +++++++++++++--
 hw/virtio/virtio-pci.c  | 15 +++++++++++++--
 hw/virtio/virtio.c      | 10 +++++++---
 7 files changed, 83 insertions(+), 20 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3a555125be..43e88a4daf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1225,7 +1225,8 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
 {
     VirtIOGPU *g = opaque;
     struct virtio_gpu_simple_resource *res;
-    int i;
+    Error *err = NULL;
+    int i, ret;
 
     /* in 2d mode we should never find unprocessed commands here */
     assert(QTAILQ_EMPTY(&g->cmdq));
@@ -1248,8 +1249,12 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     }
     qemu_put_be32(f, 0); /* end of list */
 
-    return vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
-                              &error_fatal);
+    ret = vmstate_save_state(f, &vmstate_virtio_gpu_scanouts, g, NULL,
+                             &err);
+    if (ret < 0) {
+        error_report_err(err);
+    }
+    return ret;
 }
 
 static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
@@ -1288,7 +1293,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     Error *err = NULL;
     struct virtio_gpu_simple_resource *res;
     uint32_t resource_id, pformat;
-    int i;
+    int i, ret;
 
     g->hostmem = 0;
 
@@ -1348,9 +1353,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     }
 
     /* load & apply scanout state */
-    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
-
-    return 0;
+    ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
+    if (ret < 0) {
+        error_report_err(err);
+    }
+    return ret;
 }
 
 static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 738b0c41ae..b1eba348e0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -921,21 +921,32 @@ const VMStateDescription vmstate_pci_device = {
 
 void pci_device_save(PCIDevice *s, QEMUFile *f)
 {
+    Error *local_err = NULL;
+    int ret;
+
     /* Clear interrupt status bit: it is implicit
      * in irq_state which we are saving.
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
+    ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
 }
 
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
+    Error *local_err = NULL;
     int ret;
+
     ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
-                             &error_fatal);
+                             &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
     return ret;
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4cb1ced001..4a3ffb84f8 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1130,13 +1130,26 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
 static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &error_fatal);
+    Error *local_err = NULL;
+    int ret;
+
+    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
 }
 
 static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
-    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
+    Error *local_err = NULL;
+    int ret;
+
+    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index f0a7dd2b88..a6591319db 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -628,10 +628,16 @@ static const VMStateDescription vmstate_spapr_vscsi_req = {
 static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
 {
     vscsi_req *req = sreq->hba_private;
-    assert(req->active);
+    Error *local_err = NULL;
+    int rc;
 
-    vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &error_fatal);
+    assert(req->active);
 
+    rc = vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &local_err);
+    if (rc < 0) {
+        error_report_err(local_err);
+        return;
+    }
     trace_spapr_vscsi_save_request(req->qtag, req->cur_desc_num,
                                    req->cur_desc_offset);
 }
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index fb58c36452..c05c00bcd4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -612,15 +612,26 @@ static const VMStateDescription vmstate_virtio_mmio = {
 static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
+    Error *local_err = NULL;
+    int ret;
 
-    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_fatal);
+    ret = vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
 }
 
 static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
+    Error *local_err = NULL;
+    int ret;
 
-    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
+    ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 937e22f08a..99cb30fe59 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -187,15 +187,26 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
+    Error *local_err = NULL;
+    int ret;
 
-    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_fatal);
+    ret = vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
 }
 
 static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
+    Error *local_err = NULL;
+    int ret;
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
+    ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 153ee0a0cf..257cda506a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3030,7 +3030,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
-    int i;
+    int i, ret;
     Error *local_err = NULL;
 
     if (k->save_config) {
@@ -3075,7 +3075,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
+        ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
         if (ret) {
             error_report_err(local_err);
             return ret;
@@ -3083,7 +3083,11 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     /* Subsections */
-    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fatal);
+    ret = vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 /* A wrapper for use as a VMState .put function */
-- 
2.50.1


