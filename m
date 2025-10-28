Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0612DCCF9F2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstW-0002yT-AI; Tue, 28 Oct 2025 19:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstT-0002we-Uu
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:24 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstL-00017L-2v
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:23 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4887F81765;
 Wed, 29 Oct 2025 02:14:00 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-CMWkYUWR; Wed, 29 Oct 2025 02:13:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693239;
 bh=p+nRtrNPovY55BdLG50N9jkuwP8uMv1quoi1fFi1LL4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RKL/BrIqwq6WUN4kJdnyWEOkzi2suqmvqAo22/xkimWjBgbq8GTp7yHY6r4Tj2b6g
 j/emSDPUlsFf2J3tY8HXnZOpqDrp2geqT3WgUE5iQurLCFh4okIbiEPL3PoB1QEp2x
 OxlpC3EBHm+OQ0S1s8xjR+kIh/aJbjRbw4waZ/9o=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 12/22] hw/virtio: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:36 +0300
Message-ID: <20251028231347.194844-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user-fs.c      | 65 ++++++++++++++--------------
 hw/virtio/virtio-mmio.c        | 10 +++--
 hw/virtio/virtio-pci.c         | 10 +++--
 hw/virtio/virtio.c             | 78 ++++++++++++++++++++--------------
 include/hw/virtio/virtio-bus.h |  4 +-
 include/hw/virtio/virtio.h     |  2 -
 6 files changed, 94 insertions(+), 75 deletions(-)

diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index e77c69eb12..84a7663ea8 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -306,9 +306,11 @@ static struct vhost_dev *vuf_get_vhost(VirtIODevice *vdev)
 /**
  * Fetch the internal state from virtiofsd and save it to `f`.
  */
-static int vuf_save_state(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field, JSONWriter *vmdesc)
+static bool vuf_save_state(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, JSONWriter *vmdesc,
+                           Error **errp)
 {
+    ERRP_GUARD();
     VirtIODevice *vdev = pv;
     VHostUserFS *fs = VHOST_USER_FS(vdev);
     Error *local_error = NULL;
@@ -316,39 +318,39 @@ static int vuf_save_state(QEMUFile *f, void *pv, size_t size,
 
     ret = vhost_save_backend_state(&fs->vhost_dev, f, &local_error);
     if (ret < 0) {
-        error_reportf_err(local_error,
-                          "Error saving back-end state of %s device %s "
-                          "(tag: \"%s\"): ",
-                          vdev->name, vdev->parent_obj.canonical_path,
-                          fs->conf.tag ?: "<none>");
-        return ret;
+        error_prepend(errp,
+                      "Error saving back-end state of %s device %s "
+                      "(tag: \"%s\"): ",
+                      vdev->name, vdev->parent_obj.canonical_path,
+                      fs->conf.tag ?: "<none>");
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 /**
  * Load virtiofsd's internal state from `f` and send it over to virtiofsd.
  */
-static int vuf_load_state(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field)
+static bool vuf_load_state(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, Error **errp)
 {
+    ERRP_GUARD();
     VirtIODevice *vdev = pv;
     VHostUserFS *fs = VHOST_USER_FS(vdev);
-    Error *local_error = NULL;
     int ret;
 
-    ret = vhost_load_backend_state(&fs->vhost_dev, f, &local_error);
+    ret = vhost_load_backend_state(&fs->vhost_dev, f, errp);
     if (ret < 0) {
-        error_reportf_err(local_error,
-                          "Error loading back-end state of %s device %s "
-                          "(tag: \"%s\"): ",
-                          vdev->name, vdev->parent_obj.canonical_path,
-                          fs->conf.tag ?: "<none>");
-        return ret;
+        error_prepend(errp,
+                      "Error loading back-end state of %s device %s "
+                      "(tag: \"%s\"): ",
+                      vdev->name, vdev->parent_obj.canonical_path,
+                      fs->conf.tag ?: "<none>");
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static bool vuf_is_internal_migration(void *opaque)
@@ -357,20 +359,21 @@ static bool vuf_is_internal_migration(void *opaque)
     return true;
 }
 
-static int vuf_check_migration_support(void *opaque)
+static bool vuf_check_migration_support(void *opaque, Error **errp)
 {
     VirtIODevice *vdev = opaque;
     VHostUserFS *fs = VHOST_USER_FS(vdev);
 
     if (!vhost_supports_device_state(&fs->vhost_dev)) {
-        error_report("Back-end of %s device %s (tag: \"%s\") does not support "
-                     "migration through qemu",
-                     vdev->name, vdev->parent_obj.canonical_path,
-                     fs->conf.tag ?: "<none>");
-        return -ENOTSUP;
+        error_setg(errp,
+                   "Back-end of %s device %s (tag: \"%s\") does not support "
+                   "migration through qemu",
+                   vdev->name, vdev->parent_obj.canonical_path,
+                   fs->conf.tag ?: "<none>");
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateDescription vuf_backend_vmstate;
@@ -392,15 +395,15 @@ static const VMStateDescription vuf_backend_vmstate = {
     .name = "vhost-user-fs-backend",
     .version_id = 0,
     .needed = vuf_is_internal_migration,
-    .pre_load = vuf_check_migration_support,
-    .pre_save = vuf_check_migration_support,
+    .pre_load_errp = vuf_check_migration_support,
+    .pre_save_errp = vuf_check_migration_support,
     .fields = (const VMStateField[]) {
         {
             .name = "back-end",
             .info = &(const VMStateInfo) {
                 .name = "virtio-fs back-end state",
-                .get = vuf_load_state,
-                .put = vuf_save_state,
+                .load = vuf_load_state,
+                .save = vuf_save_state,
             },
         },
         VMSTATE_END_OF_LIST()
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index fb58c36452..9d37ee029b 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -609,18 +609,20 @@ static const VMStateDescription vmstate_virtio_mmio = {
     }
 };
 
-static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f,
+                                         Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &error_fatal);
+    return vmstate_save_vmsd(f, &vmstate_virtio_mmio, proxy, NULL, errp);
 }
 
-static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f,
+                                         Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
 
-    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
+    return vmstate_load_vmsd(f, &vmstate_virtio_mmio, proxy, 1, errp);
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 937e22f08a..95faa84a58 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -184,18 +184,20 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
     return true;
 }
 
-static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f,
+                                        Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &error_fatal);
+    return vmstate_save_vmsd(f, &vmstate_virtio_pci, proxy, NULL, errp);
 }
 
-static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f,
+                                        Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
 
-    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
+    return vmstate_load_vmsd(f, &vmstate_virtio_pci, proxy, 1, errp);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 153ee0a0cf..36e0493344 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2873,35 +2873,37 @@ static const VMStateDescription vmstate_virtio_ringsize = {
     }
 };
 
-static int get_extra_state(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field)
+static bool load_extra_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field,
+                             Error **errp)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     if (!k->load_extra_state) {
-        return -1;
+        error_setg(errp, "extra state is unsupported");
+        return false;
     } else {
-        return k->load_extra_state(qbus->parent, f);
+        return k->load_extra_state(qbus->parent, f, errp);
     }
 }
 
-static int put_extra_state(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field, JSONWriter *vmdesc)
+static bool save_extra_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field, JSONWriter *vmdesc,
+                             Error **errp)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
-    k->save_extra_state(qbus->parent, f);
-    return 0;
+    return k->save_extra_state(qbus->parent, f, errp);
 }
 
 static const VMStateInfo vmstate_info_extra_state = {
     .name = "virtqueue_extra_state",
-    .get = get_extra_state,
-    .put = put_extra_state,
+    .load = load_extra_state,
+    .save = save_extra_state,
 };
 
 static const VMStateDescription vmstate_virtio_extra_state = {
@@ -3024,14 +3026,13 @@ static const VMStateDescription vmstate_virtio = {
     }
 };
 
-int virtio_save(VirtIODevice *vdev, QEMUFile *f)
+static bool virtio_save(VirtIODevice *vdev, QEMUFile *f, Error **errp)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
-    Error *local_err = NULL;
 
     if (k->save_config) {
         k->save_config(qbus->parent, f);
@@ -3075,39 +3076,54 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     }
 
     if (vdc->vmsd) {
-        int ret = vmstate_save_state(f, vdc->vmsd, vdev, NULL, &local_err);
-        if (ret) {
-            error_report_err(local_err);
-            return ret;
+        if (!vmstate_save_vmsd(f, vdc->vmsd, vdev, NULL, errp)) {
+            return false;
         }
     }
 
     /* Subsections */
-    return vmstate_save_state(f, &vmstate_virtio, vdev, NULL, &error_fatal);
+    return vmstate_save_vmsd(f, &vmstate_virtio, vdev, NULL, &error_fatal);
 }
 
 /* A wrapper for use as a VMState .put function */
-static int virtio_device_put(QEMUFile *f, void *opaque, size_t size,
-                              const VMStateField *field, JSONWriter *vmdesc)
+static bool virtio_device_save(QEMUFile *f, void *opaque, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               Error **errp)
 {
-    return virtio_save(VIRTIO_DEVICE(opaque), f);
+    return virtio_save(VIRTIO_DEVICE(opaque), f, errp);
 }
 
 /* A wrapper for use as a VMState .get function */
-static int coroutine_mixed_fn
-virtio_device_get(QEMUFile *f, void *opaque, size_t size,
-                  const VMStateField *field)
+static bool coroutine_mixed_fn
+virtio_device_load(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
     DeviceClass *dc = DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
 
-    return virtio_load(vdev, f, dc->vmsd->version_id);
+    /* TODO: update virtio_load() to set errp and return bool */
+    int ret = virtio_load(vdev, f, dc->vmsd->version_id);
+
+    if (ret < 0) {
+        /*
+         * Using error_setg_errn or strerror would be incorrect,
+         * because virtio_load may mix simple -1 with -errno
+         * values on different paths.
+         *
+         * TODO: update virtio_load and all related callbacks
+         * to "errp + boolean return value" API.
+         */
+        error_setg(errp, "virtio_load failed: %d", ret);
+        return false;
+    }
+
+    return true;
 }
 
 const VMStateInfo  virtio_vmstate_info = {
     .name = "virtio",
-    .get = virtio_device_get,
-    .put = virtio_device_put,
+    .load = virtio_device_load,
+    .save = virtio_device_save,
 };
 
 static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
@@ -3387,18 +3403,16 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (vdc->vmsd) {
-        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
-        if (ret) {
+        if (!vmstate_load_vmsd(f, vdc->vmsd, vdev, version_id, &local_err)) {
             error_report_err(local_err);
-            return ret;
+            return -EINVAL;
         }
     }
 
     /* Subsections */
-    ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
-    if (ret) {
+    if (!vmstate_load_vmsd(f, &vmstate_virtio, vdev, 1, &local_err)) {
         error_report_err(local_err);
-        return ret;
+        return -EINVAL;
     }
 
     if (vdev->device_endian == VIRTIO_DEVICE_ENDIAN_UNKNOWN) {
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 7ab8c9dab0..31bf2cd607 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -42,11 +42,11 @@ struct VirtioBusClass {
     void (*notify)(DeviceState *d, uint16_t vector);
     void (*save_config)(DeviceState *d, QEMUFile *f);
     void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
-    void (*save_extra_state)(DeviceState *d, QEMUFile *f);
+    bool (*save_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
     int (*load_config)(DeviceState *d, QEMUFile *f);
     int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
     int (*load_done)(DeviceState *d, QEMUFile *f);
-    int (*load_extra_state)(DeviceState *d, QEMUFile *f);
+    bool (*load_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
     bool (*has_extra_state)(DeviceState *d);
     bool (*query_guest_notifiers)(DeviceState *d);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d97529c3f1..d729502eca 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -296,8 +296,6 @@ int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
-int virtio_save(VirtIODevice *vdev, QEMUFile *f);
-
 extern const VMStateInfo virtio_vmstate_info;
 
 #define VMSTATE_VIRTIO_DEVICE \
-- 
2.48.1


