Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDE1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNu-0007og-7H; Thu, 16 Oct 2025 07:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MNG-0007Gv-TY; Thu, 16 Oct 2025 07:42:30 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MN6-0003WF-KC; Thu, 16 Oct 2025 07:42:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B63BCC01E6;
 Thu, 16 Oct 2025 14:41:39 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-CYxTHhxP; Thu, 16 Oct 2025 14:41:39 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614899;
 bh=hT0GBLbghZ3ll8GWVsJhqMckxe5KaPEjWuD5dmK6b50=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XIgYMJoEfrRleGq7aCD+ipU8x+gSWcNSYiI8zHJ+boaDVQeNfd71eEuHndW8BX6gY
 q0POpnJD909qm1788FxEg6f97cwZCXIJgMyBq2X7CUJLodUUt1EP8VhQsPHvgo89sf
 T/Qzocpzorrn6zjNjEndafojUrYURZL+cqD3LfMk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 21/25] virtio: support vhost backend migration
Date: Thu, 16 Oct 2025 14:40:58 +0300
Message-ID: <20251016114104.1384675-22-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
 hw/virtio/virtio.c         | 73 ++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio.h |  2 ++
 3 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 9b545acda3..577693b6c9 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -291,7 +291,7 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
         return -ENOSYS;
     }
 
-    if (assign) {
+    if (assign && !virtio_is_vhost_backend_transfer(vdev)) {
         r = event_notifier_init(notifier, 1);
         if (r < 0) {
             error_report("%s: unable to init event notifier: %s (%d)",
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4184aff75c..bf361811d0 100644
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
@@ -3032,6 +3033,7 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
     uint32_t guest_features_lo = (vdev->guest_features & 0xffffffff);
     int i;
     Error *local_err = NULL;
+    bool migrating_backend = virtio_is_vhost_backend_transfer(vdev);
 
     if (k->save_config) {
         k->save_config(qbus->parent, f);
@@ -3065,11 +3067,23 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
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
@@ -3295,6 +3309,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
     Error *local_err = NULL;
+    bool migrating_backend = virtio_is_vhost_backend_transfer(vdev);
 
     /*
      * We poison the endianness to ensure it does not get used before
@@ -3364,6 +3379,13 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
@@ -3377,6 +3399,10 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
     }
 
+    if (migrating_backend) {
+        event_notifier_init_fd(&vdev->config_notifier, qemu_file_get_fd(f));
+    }
+
     virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 
     if (vdc->load != NULL) {
@@ -3394,6 +3420,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
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
     ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
     if (ret) {
@@ -3447,6 +3486,18 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 continue;
             }
 
+            if (migrating_backend) {
+                /*
+                 * Indices are not synced prior to backend migration (as we
+                 * don't stop vrings by GET_VRING_BASE). No reason to sync them
+                 * now, and do any checks.
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
@@ -3815,8 +3866,9 @@ int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
     EventNotifierHandler *read_fn = is_config ?
         virtio_config_guest_notifier_read :
         virtio_queue_guest_notifier_read;
+    bool migrating_backend = virtio_is_vhost_backend_transfer(vdev);
 
-    if (assign) {
+    if (assign && !migrating_backend) {
         int r = event_notifier_init(notifier, 0);
         if (r < 0) {
             return r;
@@ -3826,7 +3878,7 @@ int virtio_queue_set_guest_notifier(VirtIODevice *vdev, int n, bool assign,
     event_notifier_set_handler(notifier,
                                (assign && !with_irqfd) ? read_fn : NULL);
 
-    if (!assign) {
+    if (!assign && !migrating_backend) {
         /* Test and clear notifier before closing it,*/
         /* in case poll callback didn't have time to run. */
         read_fn(notifier);
@@ -4445,6 +4497,23 @@ done:
     return element;
 }
 
+bool virtio_is_vhost_backend_transfer(VirtIODevice *vdev)
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
+    return hdev->backend_transfer;
+}
+
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 620ee4e389..8e2d3019cd 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -242,6 +242,8 @@ struct VirtioDeviceClass {
     bool (*skip_vhost_migration_log)(VirtIODevice *vdev);
 };
 
+bool virtio_is_vhost_backend_transfer(VirtIODevice *vdev);
+
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name);
 
-- 
2.48.1


