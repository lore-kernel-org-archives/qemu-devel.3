Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36BC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oSU-0002E2-OU; Thu, 10 Sep 2026 19:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lS8-0005Is-6Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lRl-0002Xk-7d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RD4dlmLlkNeM/6QiFlWXI6gFoCY42PMOKXH1p326AOs=;
 b=ddTVKjS9ObPxLoaGvzljAH0acTLJy1N2B5bDRT0ckU4KOx9WMXc3IyPEFfI/Ey0iT8ktZl
 zXkmC2MO9bcQ3LEcewp7kDmKxJNgOgKxG9tYKXXo4Vr+lsSrFcIkgf3eXOjSwL988K1zqK
 vz2W7feLAe51gKspbnVjFajAsnhhkxA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-SZRbGP6hPyWJ4zDZfok0mA-1; Thu, 10 Sep 2026 16:11:57 -0400
X-MC-Unique: SZRbGP6hPyWJ4zDZfok0mA-1
X-Mimecast-MFC-AGG-ID: SZRbGP6hPyWJ4zDZfok0mA_1789071117
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso1983435e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071117; x=1789675917; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RD4dlmLlkNeM/6QiFlWXI6gFoCY42PMOKXH1p326AOs=;
 b=nsFx08Nbb4Dnq3590yrabTedAeyzShx/GzK84IcSg7TDeTYS/2g2th13mslXjX9s2p
 kaR9ny8XgUmbm5ht0RPvUEov2aFQCkUcy14r0M3Chieoz0VfxHcb6TD7PKiZRzFkJo7c
 FVo2DvqlD0PMx3W0ZkT3a/W/PVDKpN64VwuYRxAitZfGlm4GLtb9EMlaUAf1+akpi3xF
 WAA1z24u8suy55q8CKAWqkY3GDdKbdy1y3ZZD0DXbbCgQwHEtOBfaQTSPodACsT4SKqa
 G0NgsJftc5HZjKz5sRggJMRefTsKSI406Li+Su1vIvbsO4LWK5H75kFq1VckYTKLLq6j
 UHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071117; x=1789675917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RD4dlmLlkNeM/6QiFlWXI6gFoCY42PMOKXH1p326AOs=;
 b=sMM1ttDLn5ODvjj2caN4UpPn4HP2CHuhpoxsBimoNpoIhr92lV2PWaY5AOG4Qdrtt9
 BIvRhPRYojVK0zeZ4sHj3V2ZSIkkHvMdcBWM9KzuUFfvTDAKqlpaUQzGtwR72u0Jz10t
 LQEbpAqWZWkGlwd7rvZHT2Fp9siNr3qkbV+JrjH/pFaSsJBvwZSGaIZbkyo+ueZVCoXt
 mHxYAftvOXQUSF5oxn068FnBfFasnmzpCUFJ+R3LDhLLxvW7Fvd022xjt6v72+Mo2k2Q
 rYTtoRidDs8BKK9yHj146daDCuhMAX3tYgaVipLoEo0bM6w+ljZsDjVEwClJYVnFLk6f
 ihXw==
X-Gm-Message-State: AFuF++kPAw+ZTtoAsKP8t32H7Y9wOJ9VidRFHrNc2UTWiCLql4L78An1
 Hv+Whdglqg79i73yEPuA0TNsLEvxy8z2Df+YsEHxgc4UBNLssVxRvXyEkhBR251DaFFHV40FMf6
 WGXInTaIcR8TRXri4zGOFai92Nic2jc+ZeBIqAGm1WURbkd/wWWMKQajq8+vpOvBlhCLFoArsz6
 g1oYvuDwuThciyQCtP63ZbpNfOxBiV6zKiNw==
X-Gm-Gg: AYBFou3G9gBghM0HY2taiDOhO/kH3mBcQBHflnvEpvupBTT+9NWWqMkZFdX4xPy5ceE
 V1RDVrSIe7mCZIDzP6cIORetbaC1X//tZOGah0NBk8yPI9FFCgajwMY941cI7vMH+3gqOzaA9gM
 /Mv9tg+UEyJFJW3lxLbkg55unBUii8a6Vgj8yI2jUNuSQm5iKCNEjtCoTDSk+gA3WehvoOtAWfl
 L0GtLvYN33GTKOw30XqNoUWKN66nf+2tz6wZpIpOMFhVc1zon+/t4McnhXJGD6jt32Cb6af8Cic
 3Mu4lyeaqu7ydpVZ3ITGda4KvvWwwy4Pejpu0fhzHtBLnwQB8qbX73xkwP30oNkLbMhjaE2j9Dq
 LlZDwwB8TnUn2WZgztl/TsLA=
X-Received: by 2002:a05:600c:1d08:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49e619c4d64mr8159755e9.24.1789071116431; 
 Thu, 10 Sep 2026 13:11:56 -0700 (PDT)
X-Received: by 2002:a05:600c:1d08:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49e619c4d64mr8159335e9.24.1789071115833; 
 Thu, 10 Sep 2026 13:11:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62225628sm1025855e9.3.2026.09.10.13.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:55 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 14/90] vhost-vsock: hand off device ownership across CPR
Message-ID: <fa846b0dc5097bc29020c0022e3e987c2e47ba6e.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on failure:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
    fails after pre_save released it and the source VM is resumed.

  - .set_status() refuses to start a device whose handoff hasn't
    completed: not fully initialized yet, or left ownerless after a
    failed CPR.

With the handoff in place, lift the CPR blocker: only ID-less devices,
which can't preserve their FDs, remain blocked.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
---
 include/hw/virtio/vhost-vsock.h |   5 +-
 hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
 2 files changed, 152 insertions(+), 18 deletions(-)

diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1b..6d0cff4fb9 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -15,6 +15,7 @@
 #define QEMU_VHOST_VSOCK_H
 
 #include "hw/virtio/vhost-vsock-common.h"
+#include "qemu/notify.h"
 #include "qom/object.h"
 
 #define TYPE_VHOST_VSOCK "vhost-vsock-device"
@@ -29,7 +30,9 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    Error *migration_blocker;   /* set when the device has no ID */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
+    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
 
     /*< public >*/
 };
diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index cec2c31f0c..e25e535090 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
+    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  On source the device is left without an owner if a
+     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
+     * rather than issue vhost ioctls on a half-initialised or ownerless
+     * device.
+     */
+    if (should_start && (!initialized || vsock->owner_reset)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
@@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+/*
+ * Re-acquire device ownership if a CPR migration that released it (in
+ * vhost_vsock_pre_save()) failed and the source VM is about to resume.
+ * This runs before vm_start(), so the device is owned again before it is
+ * restarted.
+ */
+static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
+    int ret;
+
+    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
+        ret = vhost_dev_set_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
+        } else {
+            vsock->owner_reset = false;
+        }
+    }
+
+    return 0;
+}
+
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL)) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(proxy->id, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %d", ret);
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
+     * With the ownership handoff in place CPR migration is now supported.
+     * Having a unique ID is mandatory for FD preservation during it, thus
+     * we only keep the migration blocker for the ID-less case.
      */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
+    if (!proxy->id) {
+        error_setg(&vsock->migration_blocker,
+                   "vhost-vsock: device ID is required for CPR migration");
+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                      BIT(MIG_MODE_CPR_TRANSFER) |
+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+            return;
+        }
     }
 
-    if (cpr_is_incoming()) {
+    /*
+     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
+     * then fails.
+     */
+    migration_add_notifier_modes(&vsock->cpr_notifier,
+                                 vhost_vsock_cpr_notifier,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
+
+    if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU. */
         if (!proxy->id) {
             error_setg(errp, "vhost-vsock: device ID is required for "
@@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -233,6 +362,7 @@ err_vhost_dev:
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
 }
 
@@ -249,6 +379,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     if (proxy->id) {
         cpr_delete_fd(proxy->id, 0);
     }
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
-- 
MST


