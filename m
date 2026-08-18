Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9599C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLm4-0004A2-CD; Tue, 18 Aug 2026 11:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLm2-00049l-Hh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLm0-0000K5-42
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787067043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=THR12VopdbYrG4Gh2Dlc42AeJk+dfzSQJc5Dlue+ME8=;
 b=H0viV+p2ncOnw4o04xPINAbj5QvEr4KSn+jDYtJivrMenRKD0xPEPnMGFgMTmhcKgCtePG
 WM1aVc9FEtxt2Vc7L7+6ODukNIu8lKixGnj+f9aPANEjKxZMEqEIC8+Zx/v5XT4suB/iWJ
 bCBsETnr4usQ99Bq/5Gh66sobx8754U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-ceJOF5JfNWatrsr_EPjKwQ-1; Tue, 18 Aug 2026 11:30:41 -0400
X-MC-Unique: ceJOF5JfNWatrsr_EPjKwQ-1
X-Mimecast-MFC-AGG-ID: ceJOF5JfNWatrsr_EPjKwQ_1787067040
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so2919056f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787067040; x=1787671840; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=THR12VopdbYrG4Gh2Dlc42AeJk+dfzSQJc5Dlue+ME8=;
 b=EjaF0S6r3deE2J9xY2KgGMcKwzT+X4ZTKa7rjjY9mGKJnq/ju2RyUJbGjYlBcxkFrk
 NQpzhAXcBUOBr6sxTj9o2WmuaF0zXb0o7s50T2toYNPyUQAAgmUmd4pqPzFx5TCOqBz9
 Df6W8qnoYdUcYSM/or3RHAZkhCW/LCdqATTuatAaVq+0HMfKsiBepr6Xz3WLdQqULJ2M
 iOqjUfKe+1hSJdzcmst1kLIE+HI2A3bwCWeybkE2YByEgrdrjRa9SkyvZtt971yPmNyg
 kshe+3cb9IntcMwOh3SCNMptMAJRf9iaAXY6evNtk8m74XbOZ3oDTJK4Qug8nFZWFerF
 yg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787067040; x=1787671840;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=THR12VopdbYrG4Gh2Dlc42AeJk+dfzSQJc5Dlue+ME8=;
 b=mQuwVGZaHST4o13DS1nEAOAJZTtxegVhJ+RPIpsX1Kir7TYlA7Eu5YeOs7aWJcSo5n
 4sw0oyTsi65tRtN6iXS7uJvQFplPvfe9hTVv/jay5DJacPXBgYCdzaryi7T8mb7c69Tl
 xpQF2zireWj7I+uUAx5QFubDbtoKafKEo4b4NON68tjBgG862yUEY4y3m4oT7xQCqpYn
 bBVrXSrSa/gySswyL78BpKKSjtqE03HMcUUFVkXOSphvL7wUpbh3difnyCs2rsCtY4B/
 BuPrCTXTn4gB3VlfXt5genOAYuPMUy15VYPiqt/nKeSLZlbrsc+OR7eVwxbt70ihORgq
 m8kA==
X-Gm-Message-State: AOJu0YxvgvAoBiYdlGuuaVcjX36EuK8wcKlkOjyeSfC9mZf3GLgr/aFK
 beeErIRdtTgfkBumbCeodvkPzbDZGgC86+5fdNGJ/UVBmsrtv66r+Ne6KaVHwqLHrmGyW1MPGaD
 sHtjuw4XLTrR5YcUvAH5aK6rhk/ZB9PEngoy5NFdeankZzd0kghXfZ02T
X-Gm-Gg: AR+sD13pDzb8g8JGpe0jKaOV/PvzFax+qT7HxTTfDxh/VzV7vzlt17auwRKeXqL+1jN
 3uO7CZYm6yJ/1rF6ByXkqAxcQmTLI+pupSLKA/Lt2/zfCEnqjBGZDCbiYG86CULIvCIP+v6suBf
 pgj3hPKWDsoakdM4E2tsrgWH1I5OR/tEwyP/ewqc1qVnmW8kJwXc+EC0TJlPcs/AUSRFzVOg+y8
 S1tTMUZiWwIc3wyNl0BSCM74kvPKHhhnWOoF7Z0Wn3TtMv2aVVAWZsoKI3CqTZe0mAkOLwGnN7M
 x8SMDt/mu9WETsyIHA3U61x0gK4tJtjimnafz4+vHbZLVrzQXWOeIY+WeZyZneohLs0FiHwru4q
 RGENSo6NSPSGGy1jbVirH7tsl6mzk2wUy8CJid5Quc/LgqVPAzpm2
X-Received: by 2002:a05:6000:2483:b0:47f:9ac6:ca60 with SMTP id
 ffacd0b85a97d-482a8fd684bmr15473423f8f.0.1787067039712; 
 Tue, 18 Aug 2026 08:30:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2483:b0:47f:9ac6:ca60 with SMTP id
 ffacd0b85a97d-482a8fd684bmr15473276f8f.0.1787067039144; 
 Tue, 18 Aug 2026 08:30:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c5e7sm12301663f8f.24.2026.08.18.08.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:30:38 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:30:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v3 7/7] vhost-vsock: hand off device ownership across CPR
Message-ID: <aoR0_7FBFAyFw_b5@sgarzare-redhat>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-8-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260626164643.2526-8-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Fri, Jun 26, 2026 at 07:46:43PM +0300, Andrey Drobyshev wrote:
>The previous patches reuse the source vhost FD on the destination,
>however both source and targe still call vhost_dev_init() (VHOST_SET_OWNER)
>in realize().  For cpr-transfer the destination realizes while the source
>still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>handed over explicitly.
>
>Do this through the device's CPR vmstate hooks.  Namely, release device
>ownership in pre_save, reclaim in post_load, re-acquire on failure:
>
>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>    cpr-exec).
>
>  - .realize(), for an incoming CPR, only sets up the virtio device and
>    queries the backend features by calling vhost_dev_init_backend().
>    It doesn't take device ownership and doesn't touch the VQs which
>    still-running source might use.  The full init is deferred to
>    .post_load().
>
>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>    the device is started at vm_start.
>
>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>    fails after pre_save released it and the source VM is resumed.
>
>Also harden vhost_virtqueue_cleanup() against a NULL vq->dev which can
>now happen if an incoming CPR is aborted after realize set up the backend
>but before post_load initialised the VQs.
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 147 +++++++++++++++++++++++++++++---
> hw/virtio/vhost.c               |   2 +-
> include/hw/virtio/vhost-vsock.h |   3 +
> 3 files changed, 140 insertions(+), 12 deletions(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index 7eacb608d07..b02b3f9cc03 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -76,6 +76,17 @@ static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>     bool should_start = virtio_device_should_start(vdev, status);
>     int ret;
>
>+    /*
>+     * On an incoming CPR the full vhost_dev_init() is deferred to post_load
>+     * (realize only ran vhost_dev_init_backend()).  hdev->mem is set only by
>+     * the full init, so refuse to start a device whose handoff never
>+     * completed rather than dereference a half-initialised vhost_dev.
>+     */
>+    if (should_start && !vvc->vhost_dev.mem) {

Should we also check `vsock->owner_reset`?
IIUC it can be left set if for example vhost_dev_set_owner() failed.

About using `vvc->vhost_dev.mem`, I'm a bit worried if it can be a bit 
fragile for future changes.  What about adding a new field (e.g.  
`initialized`) set by vhost_dev_init() when everything is fine?

>+        error_report("vhost-vsock: refusing to start, device init incomplete");
>+        return 0;
>+    }
>+
>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>         return 0;
>     }
>@@ -111,18 +122,102 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
> }
>
>+/*
>+ * Re-acquire device ownership if a CPR migration that released it (in
>+ * vhost_vsock_cpr_pre_save()) failed and the source VM is about to resume.
>+ * This runs before vm_start(), so the device is owned again before it is
>+ * restarted.
>+ */
>+static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>+                                    MigrationEvent *e, Error **errp)
>+{
>+    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>+    int ret;
>+
>+    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
>+        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>+        if (ret < 0) {
>+            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
>+        } else {
>+            vsock->owner_reset = false;
>+        }
>+    }
>+
>+    return 0;
>+}
>+
>+static int vhost_vsock_pre_save(void *opaque)
>+{
>+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>+    VHostVSock *vsock = VHOST_VSOCK(opaque);
>+    int ret;
>+
>+    ret = vhost_vsock_common_pre_save(opaque);
>+    if (ret) {
>+        return ret;
>+    }
>+
>+    /*
>+     * Release the device ownership now for CPR migration.  The device is
>+     * already stopped at pre_save, and destination reclaims it by calling
>+     * VHOST_SET_OWNER in post_load.
>+     */
>+    if (cpr_incoming_needed(NULL)) {
>+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>+        if (ret < 0) {
>+            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
>+            return ret;
>+        }
>+        vsock->owner_reset = true;
>+    }
>+
>+    return 0;
>+}
>+
> static int vhost_vsock_post_load(void *opaque, int version_id)
> {
>+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>+    Error *local_err = NULL;
>+    int vhostfd, ret;
>+
>     /*
>      * Only reset vsock connections for non-CPR migration.  For CPR the
>      * guest cid is unchanged, and the cid-change reset would otherwise
>      * tear the vsock connections down.
>      */
>-    if (cpr_is_incoming()) {
>-        return 0;
>+    if (!cpr_is_incoming()) {
>+        return vhost_vsock_common_post_load(opaque, version_id);
>+    }

nit: maybe we can do this in the patch where we introduced it.

>+
>+    /*
>+     * CPR restore case.  The source released device ownership in its
>+     * pre_save.  Complete the handoff here, before the device is started
>+     * at vm_start.  Init vhost device on preserved FD, issue
>+     * VHOST_SET_OWNER on it, and restore the guest cid.
>+     */
>+    vhostfd = cpr_find_fd(proxy->id, 0);
>+    if (vhostfd < 0) {
>+        error_report("vhost-vsock: could not find restored vhost FD");
>+        return -1;
>     }
>
>-    return vhost_vsock_common_post_load(opaque, version_id);
>+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>+    if (ret < 0) {
>+        error_report_err(local_err);
>+        return ret;
>+    }
>+
>+    ret = vhost_vsock_set_guest_cid(vdev);
>+    if (ret < 0) {

Should we call vhost_dev_cleanup() here?

>+        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>+        return ret;
>+    }
>+
>+    return 0;
> }
>
> static const VMStateDescription vmstate_virtio_vhost_vsock = {
>@@ -133,7 +228,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>         VMSTATE_VIRTIO_DEVICE,
>         VMSTATE_END_OF_LIST()
>     },
>-    .pre_save = vhost_vsock_common_pre_save,
>+    .pre_save = vhost_vsock_pre_save,
>     .post_load = vhost_vsock_post_load,
> };
>
>@@ -144,6 +239,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>+    bool cpr_incoming = cpr_is_incoming();
>     int vhostfd;
>     int ret;
>
>@@ -172,7 +268,16 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         }
>     }
>
>-    if (cpr_is_incoming()) {
>+    /*
>+     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
>+     * then fails.
>+     */
>+    migration_add_notifier_modes(&vsock->cpr_notifier,
>+                                 vhost_vsock_cpr_notifier,
>+                                 BIT(MIG_MODE_CPR_TRANSFER) |
>+                                 BIT(MIG_MODE_CPR_EXEC));
>+
>+    if (cpr_incoming) {
>         /* Reuse the fd handed over from the source QEMU. */
>         if (!proxy->id) {
>             error_setg(errp, "vhost-vsock: device ID is required for "
>@@ -205,14 +310,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>
>     vhost_vsock_common_realize(vdev);
>
>-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>-    if (ret < 0) {
>+    if (!cpr_incoming) {
>+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>+        if (ret < 0) {
>+            /*
>+             * vhostfd is closed by vhost_dev_cleanup, which is called
>+             * by vhost_dev_init on initialization error.
>+             */
>+            goto err_virtio;
>+        }
>+    } else {
>         /*
>-         * vhostfd is closed by vhost_dev_cleanup, which is called
>-         * by vhost_dev_init on initialization error.
>+         * CPR restore case: only learn the backend feature set now, but
>+         * defer taking ownership or touching VQs (the still-running source
>+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>+         * is done later in post_load.
>          */
>-        goto err_virtio;
>+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>+                                     (void *)(uintptr_t)vhostfd,
>+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>+        if (ret < 0) {
>+            /* vhost_dev_init_backend() does not close the fd on error */
>+            goto err_vhost_dev;
>+        }
>+
>+        return;
>     }
>
>     ret = vhost_vsock_set_guest_cid(vdev);
>@@ -234,6 +357,7 @@ err_vhost_dev:
> err_virtio:
>     vhost_vsock_common_unrealize(vdev);
> err_blocker:
>+    migration_remove_notifier(&vsock->cpr_notifier);
>     migrate_del_blocker(&vsock->migration_blocker);
> }
>
>@@ -250,6 +374,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>     if (proxy->id) {
>         cpr_delete_fd(proxy->id, 0);
>     }
>+    migration_remove_notifier(&vsock->cpr_notifier);
>     migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 7ae2abe33cd..3734e3f20b5 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1647,7 +1647,7 @@ fail_call:
> static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
> {
>     event_notifier_cleanup(&vq->masked_notifier);
>-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
>+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {

Is this change related?

Oh yeah, I saw your comment in the commit description, thanks for that.
I'm just thinking if it makes sense to move to a preparation patch in 
this series.

Thanks,
Stefano

>         event_notifier_set_handler(&vq->error_notifier, NULL);
>         event_notifier_cleanup(&vq->error_notifier);
>     }
>diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>index 5ebc63afc5a..6d0cff4fb93 100644
>--- a/include/hw/virtio/vhost-vsock.h
>+++ b/include/hw/virtio/vhost-vsock.h
>@@ -15,6 +15,7 @@
> #define QEMU_VHOST_VSOCK_H
>
> #include "hw/virtio/vhost-vsock-common.h"
>+#include "qemu/notify.h"
> #include "qom/object.h"
>
> #define TYPE_VHOST_VSOCK "vhost-vsock-device"
>@@ -30,6 +31,8 @@ struct VHostVSock {
>     VHostVSockCommon parent;
>     VHostVSockConf conf;
>     Error *migration_blocker;   /* set when the device has no ID */
>+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>+    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
>
>     /*< public >*/
> };
>-- 
>2.47.1
>


