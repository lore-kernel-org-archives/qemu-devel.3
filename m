Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9F7C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Qn-0007I4-QU; Fri, 01 Mar 2024 12:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QY-000768-8l; Fri, 01 Mar 2024 12:12:07 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg6QU-0003LR-9I; Fri, 01 Mar 2024 12:12:04 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:621c:0:640:f00b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E27B360B51;
 Fri,  1 Mar 2024 20:11:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jBfRBH2IW0U0-k24Lkh2s; Fri, 01 Mar 2024 20:11:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709313119;
 bh=7f+NO+rX7m3+IqziJ767LzCRP4K+0DRcg4Y+95WX1U8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nekjqRdxvNgACSFGNZ6P53ZawQmmVJEkk+s3a5TwbTeeW8QA71BDR4BkFSSO+80kv
 JoH7fAjC9+VeW/XJiBEUWLttDTTAJjYYQwPdWXevPe6ZF/tWCssdBSqWC0ThKd0Ly5
 cXHdmQypUwlDCrTmFqJi7qHSJh/Wn+XX923PaAgI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org,
 armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 4/6] qapi: introduce device-sync-config
Date: Fri,  1 Mar 2024 20:11:41 +0300
Message-Id: <20240301171143.809835-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301171143.809835-1-vsementsov@yandex-team.ru>
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add command to sync config from vhost-user backend to the device. It
may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
triggered interrupt to the guest or just not available (not supported
by vhost-user server).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/block/vhost-user-blk.c | 27 ++++++++++++++++++++-------
 hw/virtio/virtio-pci.c    |  9 +++++++++
 include/hw/qdev-core.h    |  3 +++
 qapi/qdev.json            | 17 +++++++++++++++++
 system/qdev-monitor.c     | 23 +++++++++++++++++++++++
 5 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 9e6bbc6950..2f301f380c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -88,27 +88,39 @@ static void vhost_user_blk_set_config(VirtIODevice *vdev, const uint8_t *config)
     s->blkcfg.wce = blkcfg->wce;
 }
 
+static int vhost_user_blk_sync_config(DeviceState *dev, Error **errp)
+{
+    int ret;
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
+
+    ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                               vdev->config_len, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    memcpy(vdev->config, &s->blkcfg, vdev->config_len);
+    virtio_notify_config(vdev);
+
+    return 0;
+}
+
 static int vhost_user_blk_handle_config_change(struct vhost_dev *dev)
 {
     int ret;
-    VirtIODevice *vdev = dev->vdev;
-    VHostUserBlk *s = VHOST_USER_BLK(dev->vdev);
     Error *local_err = NULL;
 
     if (!dev->started) {
         return 0;
     }
 
-    ret = vhost_dev_get_config(dev, (uint8_t *)&s->blkcfg,
-                               vdev->config_len, &local_err);
+    ret = vhost_user_blk_sync_config(DEVICE(dev->vdev), &local_err);
     if (ret < 0) {
         error_report_err(local_err);
         return ret;
     }
 
-    memcpy(dev->vdev->config, &s->blkcfg, vdev->config_len);
-    virtio_notify_config(dev->vdev);
-
     return 0;
 }
 
@@ -576,6 +588,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
 
     device_class_set_props(dc, vhost_user_blk_properties);
     dc->vmsd = &vmstate_vhost_user_blk;
+    dc->sync_config = vhost_user_blk_sync_config;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = vhost_user_blk_device_realize;
     vdc->unrealize = vhost_user_blk_device_unrealize;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..1197341a3c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2318,6 +2318,14 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     vpciklass->parent_dc_realize(qdev, errp);
 }
 
+static int virtio_pci_sync_config(DeviceState *dev, Error **errp)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    return qdev_sync_config(DEVICE(vdev), errp);
+}
+
 static void virtio_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2334,6 +2342,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     device_class_set_parent_realize(dc, virtio_pci_dc_realize,
                                     &vpciklass->parent_dc_realize);
     rc->phases.hold = virtio_pci_bus_reset_hold;
+    dc->sync_config = virtio_pci_sync_config;
 }
 
 static const TypeInfo virtio_pci_info = {
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87..87135bdcdf 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
+typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 
 /**
  * struct DeviceClass - The base class for all devices.
@@ -162,6 +163,7 @@ struct DeviceClass {
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    DeviceSyncConfig sync_config;
 
     /**
      * @vmsd: device state serialisation description for
@@ -546,6 +548,7 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
  */
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
 void qdev_unplug(DeviceState *dev, Error **errp);
+int qdev_sync_config(DeviceState *dev, Error **errp);
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp);
 void qdev_machine_creation_done(void);
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 32ffaee644..6ece164172 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -162,3 +162,20 @@
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
+
+##
+# @device-sync-config:
+#
+# Synchronize config from backend to the guest.
+#
+# @id: the device's ID or QOM path
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
+# Since: 9.0
+##
+{ 'command': 'device-sync-config',
+  'features': [ 'unstable' ],
+  'data': {'id': 'str'} }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index cf7481e416..e3107a12d7 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -968,6 +968,29 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+int qdev_sync_config(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->sync_config) {
+        error_setg(errp, "device-sync-config is not supported for '%s'",
+                   object_get_typename(OBJECT(dev)));
+        return -ENOTSUP;
+    }
+
+    return dc->sync_config(dev, errp);
+}
+
+void qmp_device_sync_config(const char *id, Error **errp)
+{
+    DeviceState *dev = find_device_state(id, true, errp);
+    if (!dev) {
+        return;
+    }
+
+    qdev_sync_config(dev, errp);
+}
+
 void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-- 
2.34.1


