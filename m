Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BE8CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEgY-0003Lp-0m; Wed, 13 Aug 2025 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEg1-000345-90; Wed, 13 Aug 2025 12:50:13 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfp-0007tv-PX; Wed, 13 Aug 2025 12:50:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DC96381304;
 Wed, 13 Aug 2025 19:49:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-0i988P68; Wed, 13 Aug 2025 19:49:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103766;
 bh=CfSnNSlxRpA2aJcGzzhON1DJQHG5UHMfQuoe5LBYTDw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VOMtBMSTuo8/z0FgWvMdYjiFSW0nadwyp3Un89099B+eYa1CPE8vJQ3Ouw7pHUHwG
 2s8uohLkyYvWmmquagElzuXQ0n602luuExLsyfITu5TWCuDLgQcWAOSKBqbQTcwtfp
 Yin2me2cMDByChTf4Fh15Iiup3vQAOkqSYbgOlU8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 30/33] virtio: support vhost backend migration
Date: Wed, 13 Aug 2025 19:48:51 +0300
Message-ID: <20250813164856.950363-31-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add logic to transfer virtio notifiers through migration channel
for vhost backend migration case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-bus.c     |  2 +-
 hw/virtio/virtio.c         | 74 ++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h |  2 ++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index c7e3941b1e..c1848144a2 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -286,7 +286,7 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
         return -ENOSYS;
     }
 
-    if (assign) {
+    if (assign && !virtio_is_vhost_migrating_backend(vdev)) {
         r = event_notifier_init(notifier, 1);
         if (r < 0) {
             error_report("%s: unable to init event notifier: %s (%d)",
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 10891f0e0c..87c243edad 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "migration/qemu-file-types.h"
+#include "migration/qemu-file.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
@@ -2992,6 +2993,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
+    bool migrating_backend = virtio_is_vhost_migrating_backend(vdev);
 
     if (k->save_config) {
         k->save_config(qbus->parent, f);
@@ -3025,11 +3027,23 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
          */
         qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
+
+        if (migrating_backend) {
+            qemu_file_put_fd(f,
+                             event_notifier_get_fd(&vdev->vq[i].host_notifier));
+            qemu_file_put_fd(
+                f, event_notifier_get_fd(&vdev->vq[i].guest_notifier));
+        }
+
         if (k->save_queue) {
             k->save_queue(qbus->parent, i, f);
         }
     }
 
+    if (migrating_backend) {
+        qemu_file_put_fd(f, event_notifier_get_fd(&vdev->config_notifier));
+    }
+
     if (vdc->save != NULL) {
         vdc->save(vdev, f);
     }
@@ -3235,6 +3249,8 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    Error *local_err = NULL;
+    bool migrating_backend = virtio_is_vhost_migrating_backend(vdev);
 
     /*
      * We poison the endianness to ensure it does not get used before
@@ -3304,6 +3320,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
 
+        if (migrating_backend) {
+            event_notifier_init_fd(&vdev->vq[i].host_notifier,
+                                   qemu_file_get_fd(f));
+            event_notifier_init_fd(&vdev->vq[i].guest_notifier,
+                                   qemu_file_get_fd(f));
+        }
+
         if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) {
             error_report("VQ %d address 0x0 "
                          "inconsistent with Host index 0x%x",
@@ -3317,6 +3340,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (migrating_backend) {
+        event_notifier_init_fd(&vdev->config_notifier   , qemu_file_get_fd(f));
+    }
+
     virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 
     if (vdc->load != NULL) {
@@ -3333,6 +3360,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (migrating_backend) {
+        /*
+         * On vhost backend migration, device do load host_features from
+         * migration stream. So update host_features.
+         */
+        vdev->host_features = vdc->get_features(vdev, vdev->host_features,
+                                                &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+    }
+
     /* Subsections */
     ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1);
     if (ret) {
@@ -3394,6 +3434,18 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
+            if (migrating_backend) {
+                /*
+                 * Indices are not synced prior backend migration (as we don't
+                 * stop vrings by GET_VRING_BASE). No reason to sync them now,
+                 * and do any checks.
+                 */
+                vdev->vq[i].used_idx = 0;
+                vdev->vq[i].shadow_avail_idx = 0;
+                vdev->vq[i].inuse = 0;
+                continue;
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
@@ -3762,8 +3814,9 @@ int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
     EventNotifierHandler *read_fn = is_config ?
         virtio_config_guest_notifier_read :
         virtio_queue_guest_notifier_read;
+    bool migrating_backend = virtio_is_vhost_migrating_backend(vdev);
 
-    if (assign) {
+    if (assign && !migrating_backend) {
         int r = event_notifier_init(notifier, 0);
         if (r < 0) {
             return r;
@@ -3773,7 +3826,7 @@ int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
     event_notifier_set_handler(notifier,
                                (assign && !with_irqfd) ? read_fn : NULL);
 
-    if (!assign) {
+    if (!assign && !migrating_backend) {
         /* Test and clear notifier before closing it,*/
         /* in case poll callback didn't have time to run. */
         read_fn(notifier);
@@ -4392,6 +4445,23 @@ done:
     return element;
 }
 
+bool virtio_is_vhost_migrating_backend(VirtIODevice *vdev)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    struct vhost_dev *hdev;
+
+    if (!vdc->get_vhost) {
+        return false;
+    }
+
+    hdev = vdc->get_vhost(vdev);
+    if (!hdev) {
+        return false;
+    }
+
+    return hdev->migrating_backend;
+}
+
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9a4a0a94aa..f94a7e5895 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -238,6 +238,8 @@ struct VirtioDeviceClass {
     bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
 };
 
+bool virtio_is_vhost_migrating_backend(VirtIODevice *vdev);
+
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name);
 
-- 
2.48.1


