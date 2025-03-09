Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C646C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 09:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCdV-0004fv-FK; Sun, 09 Mar 2025 05:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trCd9-0004Z7-SL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:07:36 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1trCd6-0002WW-LL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 05:07:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2234e4b079cso56328725ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741511247; x=1742116047;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJuyh3JjTvuxYUGjDGeDYwF67SEbhykfSBmn8PrwmG4=;
 b=j/9gWcOcsh0AUte7rVCW044GGnfBpnNT4Z5hl18pJ456ydjtaw9eikL5jBVmfCwlFZ
 IrzUfg0femEIWIx0e5GjPeIEAKsrsAQ+CHtWbdQzLq/zVVcuAip2AKlTc7gkwzY7IcDC
 2Ix9+2rE+f0Avib7wAEX8YNV0CdsGgvsxClsjWUUIz4mufeybcV5BZySS6LNEHU7gEFX
 POwIRqLnX/dCfzdX9HGBhOB0YO/p/IKuycQV62abdsge4Tq59wzLud1peOCAJi+aGf/v
 xYiZ+DGtK549GAdILZIc67422d437zDr7SaYx6Czv8YBk6KXGvEgPZpSFNqtUDciYdfF
 faew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741511247; x=1742116047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJuyh3JjTvuxYUGjDGeDYwF67SEbhykfSBmn8PrwmG4=;
 b=S9q0vzpd4AK48A/gBCGTnKHHjV3J/FI2o2QSaBQv5DxTGR8ugrpluoj/miQDdBUQe9
 N8aaWcnVdKZDCoxgGvJ6sy62GoQNvJGqeKTsnbUoIHnntc5mP4E8ZkMk4ng3b3pp2QC5
 nXvpBvEiUSdSqVaoMgE30kfiHc+wrtrn1VVfz3d+Ox7u0gC2wAG1JMm0RG5cB833/rfN
 5U3qXk3CJBctugsznK60VgGnoJ5qbmyzNBdufjnRbOmIKithfkyY74vLLAA2fztWzB7Y
 16EVH5iiIPZ6IXWq6fG3SGj4dbCl5POxVSKX6C4xLjoY43uVoLpqJUWbhx4hWxSp1nCb
 dMug==
X-Gm-Message-State: AOJu0Yxm+liPaZvJnMo8CF2H+3gj9kIR9QZLkfD+VrAHgzj3KF0DnTIF
 8McBnFANmt1/qP9k6h3XzXSmQ0WudBd83zBOAX6vzpfejjIRtKvCAZ8wfzSZyIxOHIVVsAzFXth
 /WMCdpuIU
X-Gm-Gg: ASbGncujHpT96E7PwJ+z+h47HXedDXZFVzKuAQj5mjiLhJCBAVnAsBIPvHGUNbPpz9L
 S4ZWRrZN0CfgIpu4FJRwmpHN9g2r2GbtWQavW241hPALeFPnjP5nICdWcFNR0L60zcAvz3g9eeU
 NCfS5XLt5SeLLImDDNVMKE97xV81tyPZaKFFQUIi2f7LyCbcZeBx/cJ2wv7OJQUYUSpRGPt6oZ8
 gUezbqva80h5XnKDh9vtX088cOfxHs/wlBBpje71gViX4w9sbJjc6vsdKYYyszuklcyHY/31ygx
 IQtRfTKHAwdNxr9L1qQzkaot27v68vZ4tSXXqQ3HxPdctllWinuctK4b9w==
X-Google-Smtp-Source: AGHT+IHybcbujbLli1Bipp+FLDz4PAsWzrNbfccr6WO2udHgxTk7geWOFCwZoebWCGhssbj9Oa3nSw==
X-Received: by 2002:a05:6a21:497:b0:1ee:ced0:f0a4 with SMTP id
 adf61e73a8af0-1f544c377b2mr19003198637.34.1741511246742; 
 Sun, 09 Mar 2025 01:07:26 -0800 (PST)
Received: from 9950x.taila029d.ts.net ([1.202.18.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736b82f2663sm3435654b3a.130.2025.03.09.01.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 01:07:26 -0800 (PST)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org
Cc: fengli@smartx.com, yuhua@smartx.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 1/3] virtio: add VM state change cb with return value
Date: Sun,  9 Mar 2025 17:07:05 +0800
Message-ID: <20250309090708.3928953-2-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309090708.3928953-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch contains two changes:

1. Add VM state change cb type VMChangeStateHandlerExt which has return
value for virtio devices VMChangeStateEntry. When VM state changes,
virtio device will call the _Ext version.

2. Add return value for vm_state_notify().

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
---
 hw/block/virtio-blk.c             |  2 +-
 hw/core/vm-change-state-handler.c | 14 ++++++++------
 hw/scsi/scsi-bus.c                |  2 +-
 hw/vfio/migration.c               |  2 +-
 hw/virtio/virtio.c                |  5 +++--
 include/system/runstate.h         | 11 ++++++++---
 system/cpus.c                     |  4 ++--
 system/runstate.c                 | 25 ++++++++++++++++++++-----
 8 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a1829e3abd..4d6c3c9a54 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1918,7 +1918,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
      * called after ->start_ioeventfd() has already set blk's AioContext.
      */
     s->change =
-        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
+        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, NULL, s);
 
     blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
     blk_set_dev_ops(s->blk, &virtio_block_ops, s);
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 7064995578..d5045b17c1 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  * qdev_add_vm_change_state_handler:
  * @dev: the device that owns this handler
  * @cb: the callback function to be invoked
+ * @cb_ext: the callback function with return value to be invoked
  * @opaque: user data passed to the callback function
  *
  * This function works like qemu_add_vm_change_state_handler() except callbacks
@@ -54,21 +55,22 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerExt *cb_ext,
                                                      void *opaque)
 {
-    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
+    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ext, opaque);
 }
 
 /*
  * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
- * argument too.
+ * and the cb_ext arguments too.
  */
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque)
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerExt *cb_ext, void *opaque)
 {
     int depth = qdev_get_dev_tree_depth(dev);
 
-    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
-                                                      depth);
+    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ext,
+                                                      opaque, depth);
 }
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7d4546800f..ec098f5f0a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -356,7 +356,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         return;
     }
     dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
-            scsi_dma_restart_cb, dev);
+            scsi_dma_restart_cb, NULL, dev);
 }
 
 static void scsi_qdev_unrealize(DeviceState *qdev)
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index adfa752db5..52bb9a3845 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -976,7 +976,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
                      vfio_vmstate_change_prepare :
                      NULL;
     migration->vm_state = qdev_add_vm_change_state_handler_full(
-        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
+        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
     migration_add_notifier(&migration->migration_state,
                            vfio_migration_state_notifier);
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce37..5e8d4cab53 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3419,7 +3419,7 @@ void virtio_cleanup(VirtIODevice *vdev)
     qemu_del_vm_change_state_handler(vdev->vmstate);
 }
 
-static void virtio_vmstate_change(void *opaque, bool running, RunState state)
+static int virtio_vmstate_change(void *opaque, bool running, RunState state)
 {
     VirtIODevice *vdev = opaque;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
@@ -3438,6 +3438,7 @@ static void virtio_vmstate_change(void *opaque, bool running, RunState state)
     if (!backend_run) {
         virtio_set_status(vdev, vdev->status);
     }
+    return 0;
 }
 
 void virtio_instance_init_common(Object *proxy_obj, void *data,
@@ -3489,7 +3490,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
         vdev->config = NULL;
     }
     vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            virtio_vmstate_change, vdev);
+            NULL, virtio_vmstate_change, vdev);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
 }
diff --git a/include/system/runstate.h b/include/system/runstate.h
index bffc3719d4..af33ea92b6 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
 void runstate_replay_enable(void);
 
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
+typedef int VMChangeStateHandlerExt(void *opaque, bool running, RunState state);
 
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
@@ -20,21 +21,25 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerExt *cb_ext,
                                            void *opaque, int priority);
 VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
                                                      VMChangeStateHandler *cb,
+                                                     VMChangeStateHandlerExt *cb_ext,
                                                      void *opaque);
 VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
-    DeviceState *dev, VMChangeStateHandler *cb,
-    VMChangeStateHandler *prepare_cb, void *opaque);
+    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
+    VMChangeStateHandlerExt *cb_ext, void *opaque);
 void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
 /**
  * vm_state_notify: Notify the state of the VM
  *
  * @running: whether the VM is running or not.
  * @state: the #RunState of the VM.
+ *
+ * Return the result of the callback which has return value.
  */
-void vm_state_notify(bool running, RunState state);
+int vm_state_notify(bool running, RunState state);
 
 static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 {
diff --git a/system/cpus.c b/system/cpus.c
index 37e5892c24..f07f72621e 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -298,14 +298,14 @@ static int do_vm_stop(RunState state, bool send_stop)
         if (oldstate == RUN_STATE_RUNNING) {
             pause_all_vcpus();
         }
-        vm_state_notify(0, state);
+        ret = vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
         }
     }
 
     bdrv_drain_all();
-    ret = bdrv_flush_all();
+    ret |= bdrv_flush_all();
     trace_vm_stop_flush_all(ret);
 
     return ret;
diff --git a/system/runstate.c b/system/runstate.c
index 272801d307..2219cec409 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
 struct VMChangeStateEntry {
     VMChangeStateHandler *cb;
     VMChangeStateHandler *prepare_cb;
+    VMChangeStateHandlerExt *cb_ext;
     void *opaque;
     QTAILQ_ENTRY(VMChangeStateEntry) entries;
     int priority;
@@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
         VMChangeStateHandler *cb, void *opaque, int priority)
 {
-    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
-                                                      priority);
+    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
+                                                      opaque, priority);
 }
 
 /**
  * qemu_add_vm_change_state_handler_prio_full:
  * @cb: the main callback to invoke
  * @prepare_cb: a callback to invoke before the main callback
+ * @cb_ext: the main callback to invoke with return value
  * @opaque: user data passed to the callbacks
  * @priority: low priorities execute first when the vm runs and the reverse is
  *            true when the vm stops
@@ -344,6 +346,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
 VMChangeStateEntry *
 qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
                                            VMChangeStateHandler *prepare_cb,
+                                           VMChangeStateHandlerExt *cb_ext,
                                            void *opaque, int priority)
 {
     VMChangeStateEntry *e;
@@ -352,6 +355,7 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
     e = g_malloc0(sizeof(*e));
     e->cb = cb;
     e->prepare_cb = prepare_cb;
+    e->cb_ext = cb_ext;
     e->opaque = opaque;
     e->priority = priority;
 
@@ -379,9 +383,10 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
     g_free(e);
 }
 
-void vm_state_notify(bool running, RunState state)
+int vm_state_notify(bool running, RunState state)
 {
     VMChangeStateEntry *e, *next;
+    int ret = 0;
 
     trace_vm_state_notify(running, state, RunState_str(state));
 
@@ -393,7 +398,12 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ext) {
+                // no need to process the result when starting VM
+                e->cb_ext(e->opaque, running, state);
+            }
         }
     } else {
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
@@ -403,9 +413,14 @@ void vm_state_notify(bool running, RunState state)
         }
 
         QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ext) {
+                ret |= e->cb_ext(e->opaque, running, state);
+            }
         }
     }
+    return ret;
 }
 
 static ShutdownCause reset_requested;
-- 
2.48.1


