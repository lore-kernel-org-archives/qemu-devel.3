Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFF4C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 10:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt25D-0005o0-5Z; Fri, 14 Mar 2025 06:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt258-0005nI-Iq
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:16:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tt254-00032R-53
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 06:15:56 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so32695115ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741947351; x=1742552151;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4KdS/98hGZswd1uYVRRtaOB5eJ4bk9Cy+EJDEqdJonE=;
 b=tRrUbHHJ4MMGOWbso/irG6LNYzr410M6aMlPh2WnxcR6daQ2ACQRZ309DYiixsxow9
 UlNMk3VXjZFcCYwZab+qSm3iaRzTxjsEvZwW0LWcnHjXrbholc0GqyRLYHanGPgSwie4
 zzpZ0F0W2Zvyw7QYJJZ2mWS69iCjhvu9eJg8Ych2+Zyp3kcB3/qBfj821SJ+hKb6l6tB
 MSIkSKvJ8BsnONR0oz5iyLZL0fZqXHYkhdvL7pd3tuLpSDu7HMbeVNdp41rdww+INYrG
 EnUkxYm9Iy5cJQyy6XXMf6z8IvusW/f0McdrLMnwmFbA8WbBQeErkd2XkzBymFb3iq1c
 N8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741947351; x=1742552151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KdS/98hGZswd1uYVRRtaOB5eJ4bk9Cy+EJDEqdJonE=;
 b=YgTqJYjpIIenA3Dmn3XEWLb2iAZSs17CNf53njqe2SYwDLNXrtaL543tiQcXWCreO/
 mXt6y5ou0dSaNmJ5AEo5pIvCaHBo1rY/SWVCDksrMG1OjvA+6hQqj7HEzw7G7Uo+gMqi
 1YgeLWrBnp/WoBnsyYkn2qrBXbJWm6aScWuZZP+9OdCpM8M+zY8wHfguU4tK3zO+9Pvh
 NoGY4o+Sso1aUkknYciyRHg96YBZeWHuuA8dv7R8CuNvAS2JfWmWC50ejpd1X0/Y+dlQ
 AgwiczvAcz6RksWYVVpLZ8kSph9PX1ogolsYXbwW4sSx9m8YNx9bVcBvJeKv187DR0XR
 SbFw==
X-Gm-Message-State: AOJu0YxuAIClRBam7JNFt7HVQ9n4Rul3Akg0+yrQXop0n0VvcUy9GtVw
 AbTI6JVZxVfxKkC4ysX5Xm3caYiW0W2SpcNI60VMr7ufve1dl4mTZOQxl9rs0qF6jfcVTZe/tg+
 m5fHr9Fzumgc=
X-Gm-Gg: ASbGnct7KRXnmlr4WtbVPCFMVgNYGUYrds/v5GowEG7gYBuomMDLxDpRWMUTbQ+TnnS
 ORZ3Dr7AEGLKDyvVuL+/KV5Y3Buvsjq65Zmm/ucZ5J+xyOW/OaV0lqCcY8Fyxq2V2EUmqNUOKjo
 gLPxO+ZH+zW58UCzfUuVRHRXYeyAveGvLznqkkIswDpH7VIWmhDtJuOigLSjo9d8T7MaSqpW/0Q
 c37nZ/6dKjIRj5sSUvP4+RGWmODhpl6ck3DZNU/kaHT1etbr1Eky7HR8/Ix5yZ4oKBwWKmZDgpS
 iKKFo1Ap2aIHCoF7DgM9EGXK8WaPgq59zUf32wqk4bjBae+yQQTw
X-Google-Smtp-Source: AGHT+IGmepXfcZ4nBrBOjmHvRGh4wMau5kDJjK76XFCNPlfuW73sOOjOxqX0EGcS3QnIOEar2NyQvA==
X-Received: by 2002:a05:6a00:3cc3:b0:736:ab21:6f37 with SMTP id
 d2e1a72fcca58-7372223f0bcmr2534560b3a.0.1741947351362; 
 Fri, 14 Mar 2025 03:15:51 -0700 (PDT)
Received: from fedora.smartx.com ([103.85.74.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371169549fsm2698898b3a.131.2025.03.14.03.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 03:15:51 -0700 (PDT)
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
Subject: [PATCH v2 1/3] virtio: add VM state change cb with return value
Date: Fri, 14 Mar 2025 06:15:32 -0400
Message-ID: <20250314101535.1059308-2-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250314101535.1059308-1-haoqian.he@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 5135b4d8f1..4a48a16790 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1928,7 +1928,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
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
index 416643ddd6..f531db83ea 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1015,7 +1015,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
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
index 2cc5f887ab..6e1cf5720f 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -299,14 +299,14 @@ static int do_vm_stop(RunState state, bool send_stop)
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


