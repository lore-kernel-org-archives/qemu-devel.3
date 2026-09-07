Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54043C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3b2m-0007Z1-AK; Mon, 07 Sep 2026 11:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3b2k-0007Yp-Tg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3b2i-00043o-63
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788794034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKacX8EWkspKQAnzXJ+H1uO75hVzpFxblHRetE75k3I=;
 b=DFjJ3eElk6+G4MAQhjp1CnBIALNwLE+1RwScXFIl+Z9YGNLsVhnpusl1iF+TXWM+E9cDsw
 qwnETEjn48xsU3YMsIdOCB5ZDUja+F4/scaNmDnn0/JZhA9NkVGcyYWFKypxEYDuKu8OFY
 AOapZHKq2wQ7qaYOf4qH+pA3gjYlPAw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221--HD4WvkVOMi0-TuBOQXuBg-1; Mon, 07 Sep 2026 11:13:53 -0400
X-MC-Unique: -HD4WvkVOMi0-TuBOQXuBg-1
X-Mimecast-MFC-AGG-ID: -HD4WvkVOMi0-TuBOQXuBg_1788794032
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-482e538ad9fso3336484f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788794032; x=1789398832; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LKacX8EWkspKQAnzXJ+H1uO75hVzpFxblHRetE75k3I=;
 b=DOkrmJ/JVACEdFhSEnQQcTmn+rJtcAVUGwEk+GnJVJPYkuXp9ijyEHWuhCZsbN/mq2
 DzmBl9NuKpkCLKptEpckHEQ/U0LhROMaGN1IopE5k/Ix3NYEATDXvphZkr62vwk/jvsL
 +F1vFnQjHeWnJUJdME++G4PAPTnGy2D1A9V7S/9Bo1ajWFJCw4Rt68evR6Ya7ky09pfB
 2SXwOB5BqxXQPjQngI1rWWygRWBQCUghppL7G+/0y8j6/xk8VAK8K4We2paOUCVm4Mn4
 Sw4bhAcX88zhITdSf1H5vPorpseFHu5GhLveAPTwCcv2jNn+XAssvbhP/Xrlx5Mpkk48
 BB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788794032; x=1789398832;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LKacX8EWkspKQAnzXJ+H1uO75hVzpFxblHRetE75k3I=;
 b=JuTjNLa4+BwfhAyHkLfwvIFPSv/CxF5hcWBCv50PTMVHw1Yxj+sEHiC0OTFohyvggo
 7PLuZX7kKMg17k4fliLKSLY7maPX83I3RVVQB6iQi1Jllu2Z5yOc/Wy5K5TBou3dNZYz
 u7kFetYQ0qp6vVLGS2NomzT1+1va3OhTuC3ndEI3WF8edE3zbmG14bwa/Wz3UmL10up5
 Z36yEN38+hv8jODbR9jBhS74tn8VBt90y+jghfzAVlrBxMs4ITahMsuZNTNZ/WKEmpmL
 BEiC2QsEuQ4tA7tekJ/HQzvd6quetAAMVtVzUxMOm9uKxGh2jwoMQ0vJIhRfQgHBNPk0
 9XfA==
X-Gm-Message-State: AFuF++kk0ggDQdRTpz0gNV17HS78Fea14sMP7hYjNBsu8H01qiCHo/CW
 LjhmVUYrb+PtG+2sNf1a4G9tCXHwMpTLjyhyzZxYR0uI69CCHR3dpmsHRz8FbOBo+zj1dRAQQ/L
 Zyf8PDKgu+XvecUQdh37nzY4fwypGn2wX8Bm2vse6d5sZvGSH/7Mfe1u1
X-Gm-Gg: AYBFou1Z6aSGOHDOkJMmRpRbGAy9qLE0ZlplQqcTYK62lRYzD2SmvtYTZfloSMrVWXL
 g15pgdI3vtYJgQr7YdC/fkIuMZVW0NE9EnInrstXZvG5+CAnfV+YNWeVIAJY+oAseHUvFMMLq4T
 g7Di7HUwtXcgmaUa/EjmxZH84XVzNY2bZItLqVcf3nJby3dGl00ZpA0d+g+XxnaKd1CU6uLu9ec
 6XCb3qumxUVtitKyJ/RfLW4aKCrNLxnjVZ4FVwSbPuxFhLeidxv9rRCMQzmherwvgGK83VquW/v
 3iJsx2tnqR7p+vQTgmEL5O9yqfEtYetHjH2EwaY1znYbz5FyxgCG6ATCrudvODSLYYbIUNcbarU
 NVp/+AGiqI0R22V4cC+Sya6NileyG+gOJ97vNa4j1IGoY9w==
X-Received: by 2002:a05:6000:4694:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-4858703f92dmr20261292f8f.4.1788794031701; 
 Mon, 07 Sep 2026 08:13:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4694:b0:47f:9266:9bde with SMTP id
 ffacd0b85a97d-4858703f92dmr20261244f8f.4.1788794031044; 
 Mon, 07 Sep 2026 08:13:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588390e30sm28921944f8f.7.2026.09.07.08.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:13:50 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:13:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
Message-ID: <ap7Lma3zpbr6QDb0@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 20, 2026 at 02:39:55PM +0300, Andrey Drobyshev wrote:
>The previous patches reuse the source vhost FD on the destination,
>however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
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
>  - .set_status() refuses to start a device whose handoff hasn't
>    completed: not fully initialized yet, or left ownerless after a
>    failed CPR.
>
>With the handoff in place, lift the CPR blocker: only ID-less devices,
>which can't preserve their FDs, remain blocked.
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
> include/hw/virtio/vhost-vsock.h |   5 +-
> 2 files changed, 152 insertions(+), 18 deletions(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index cec2c31f0ca..e25e5350905 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>+    VHostVSock *vsock = VHOST_VSOCK(vdev);
>     bool should_start = virtio_device_should_start(vdev, status);
>+    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
>     int ret;
>
>+    /*
>+     * During CPR, on target the full vhost_dev_init() is deferred to
>+     * post_load.  On source the device is left without an owner if a
>+     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
>+     * rather than issue vhost ioctls on a half-initialised or ownerless
>+     * device.
>+     */
>+    if (should_start && (!initialized || vsock->owner_reset)) {
>+        error_report("vhost-vsock: refusing to start, device init incomplete");
>+        return 0;

Why returning 0?

>+    }
>+
>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>         return 0;
>     }
>@@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
> }
>
>+/*
>+ * Re-acquire device ownership if a CPR migration that released it (in
>+ * vhost_vsock_pre_save()) failed and the source VM is about to resume.
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

IIUC MIG_EVENT_FAILED only covers the source failing. If the source 
completes it successfully and something goes wrong afterwards (e.g. in 
the destination), what will happen?

Thinking if we can try to call vhost_dev_set_owner() in 
vhost_vsock_set_status(), expecting also -EBUSY, instead of relying on 
`vsock->owner_reset`.

>+        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>+        if (ret < 0) {
>+            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);

Is it okay to return 0 also in this case?

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

Am I missing something that keeps pre_save from running outside an 
actual CPR migration (savevm, or any save path taken while mode is still 
set from an earlier attempt), or should the condition be tied to a CPR 
migration actually being in flight rather than to the mode parameter 
alone?

>+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>+        if (ret < 0) {
>+            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);

vhost-vsock devices that don't support `reset_owner` will fail here, 
right? Is that what we expect?

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
>@@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>         return vhost_vsock_common_post_load(opaque, version_id);
>     }
>
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
>+    }
>+
>+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>+    if (ret < 0) {
>+        error_report_err(local_err);
>+        return ret;
>+    }
>+
>+    ret = vhost_vsock_set_guest_cid(vdev);
>+    if (ret < 0) {
>+        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>+        vhost_dev_cleanup(&vvc->vhost_dev);
>+        return ret;
>+    }
>+
>     return 0;
> }
>
>@@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>         VMSTATE_VIRTIO_DEVICE,
>         VMSTATE_END_OF_LIST()
>     },
>-    .pre_save = vhost_vsock_common_pre_save,
>+    .pre_save = vhost_vsock_pre_save,
>     .post_load = vhost_vsock_post_load,
> };
>
>@@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>+    bool cpr_incoming = cpr_is_incoming();
>     int vhostfd;
>     int ret;
>
>@@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     }
>
>     /*
>-     * CPR migration of a vhost-vsock device is not supported yet: the
>-     * device ownership is not handed over, so the target fails to set
>-     * up its device.  Fail the migration early and gracefully instead.
>+     * With the ownership handoff in place CPR migration is now supported.
>+     * Having a unique ID is mandatory for FD preservation during it, thus
>+     * we only keep the migration blocker for the ID-less case.
>      */
>-    error_setg(&vsock->migration_blocker,
>-               "vhost-vsock: CPR migration is not supported");
>-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>-                                  BIT(MIG_MODE_CPR_TRANSFER) |
>-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>-        return;
>+    if (!proxy->id) {
>+        error_setg(&vsock->migration_blocker,
>+                   "vhost-vsock: device ID is required for CPR migration");
>+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>+                                      BIT(MIG_MODE_CPR_TRANSFER) |
>+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>+            return;
>+        }
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
>@@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
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

Okay, but IIUC this is returned by cpr_find_fd(), is that funtion 
passing the ownership of the fd, even that the fd is not removed from 
the hash table?

Should we call cpr_delete_fd() when we take it?

Thanks,
Stefano

>+            goto err_vhost_dev;
>+        }
>+
>+        return;
>     }
>
>     ret = vhost_vsock_set_guest_cid(vdev);
>@@ -233,6 +362,7 @@ err_vhost_dev:
> err_virtio:
>     vhost_vsock_common_unrealize(vdev);
> err_blocker:
>+    migration_remove_notifier(&vsock->cpr_notifier);
>     migrate_del_blocker(&vsock->migration_blocker);
> }
>
>@@ -249,6 +379,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>     if (proxy->id) {
>         cpr_delete_fd(proxy->id, 0);
>     }
>+    migration_remove_notifier(&vsock->cpr_notifier);
>     migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
>diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>index a964d57e1bc..6d0cff4fb93 100644
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
>@@ -29,7 +30,9 @@ struct VHostVSock {
>     /*< private >*/
>     VHostVSockCommon parent;
>     VHostVSockConf conf;
>-    Error *migration_blocker;   /* CPR migration is not supported */
>+    Error *migration_blocker;   /* set when the device has no ID */
>+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>+    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
>
>     /*< public >*/
> };
>-- 
>2.47.1
>


