Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B70C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68jO-0003Ml-Dw; Mon, 14 Sep 2026 11:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68jL-0003KY-UT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:36:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68jJ-0000lW-9W
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789400183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HCiE+ra+Ak8bU9MYmrUUkFfcywicM5h0RnQPmG9qVs4=;
 b=CwAXDNZYyp2epMjVNI5FnNuOiwAgG+skxu4pA5uHMUawG77Kjz72sgjsGoNcRcVQOk49bi
 /pU4d6C+dU/VlWh7xQx7LFC6peX6ctI5aTbiOB3vymXX6rppNihCnAPIKe4GpeR47/R4yq
 TSoY11rrdkHibTr1Lv2XfOimAeyHqRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-0B2fR1UPPGa8xVF3muqxRQ-1; Mon, 14 Sep 2026 11:36:22 -0400
X-MC-Unique: 0B2fR1UPPGa8xVF3muqxRQ-1
X-Mimecast-MFC-AGG-ID: 0B2fR1UPPGa8xVF3muqxRQ_1789400181
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e65ecd557so21284455e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789400181; x=1790004981; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HCiE+ra+Ak8bU9MYmrUUkFfcywicM5h0RnQPmG9qVs4=;
 b=in7CZgM8vyee0vJvWNpXC4yKEqhKAcib9hMr7/xi0oJUzlVgqjvfxK4X64CJw2w8bn
 51jCp3NNVgij+oab6lTa9esENDqUvVlXv4lXVsnz+RZT7hkc4qqZQ9un/rz5pJMzhuYq
 pQb4DYNLD3aCliBtrLKl2BKavqkiKpsfMgMo0D5NJsKx/EQ8Wm6TsbMryI+QXISQ0Cay
 g6sCE+CZiBTyLUDnxVfSIZ45kHw81qczd5mwR1+NZXwG+NLrLJSjMG0Dg8bDMqpvrSrj
 vqxrcafOZRq9KCSQVyN9DAa5dSD8/IIqZ1D/DF9vq17+Uuy1M90MWArCkkR5BTvd2UuX
 XvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789400181; x=1790004981;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HCiE+ra+Ak8bU9MYmrUUkFfcywicM5h0RnQPmG9qVs4=;
 b=VJhpTxKeUtiN5UXfLWwB/FRK2Sid1Mk9eevo6EqVuJE3g8QTobuZehzejWZVgGk4z2
 z8/lc5AgSb3iX9NHrQZTtTUvskdyZ/bQc33CaK1C9VrudPW9rC/i50HErsS/Zf/2Wikm
 5sacPWnZ0Q7G2wpXlgiqw8N0bQIRk3GJqQPgD5hp9HU0VBM8pHkvVrKC+jbE0skJYFuL
 wKNltN1CSSXvRZrj/nT5XBQq9MO27pbgWgf/tJU4lubCZD8DQw3KQt75H/40AcpgXxtU
 +DGpyTBpbTq70v9Usx33Tkx4R9kNLKXYchmYfXWyCcZ31xSY89QXpOv2rRx1T5i6Sa05
 pAbg==
X-Gm-Message-State: AFuF++lcr4fTmeoDaFTaIZkKcHOt6qZQu0owR1wrBdCjSii1/9m1nWMb
 3t8s7sFBFoCpWFmJebkR8Ztxx7Vbcvv2q8BjavyaR1P1la/E0FjJ7GCwEHrnV9VOTYZ2Nvsdboi
 Etx8hpL23tuXGQ61mjgoWx0ndzZ8H3BsiVOFWIMJinyyg4LOqysMKaGeK
X-Gm-Gg: AYBFou2KpkSIyDAjAAbc7woGOKcqgp4NukRjVvaAtd/LZVTBqJDqGoaD1TUdIAYVE7g
 VdYO8HKH2YzhplT2DwGFFH+PvHuKlCpsF1Ehp9e3rnHNKrHjAbcPa4dcY5QZ/Smu2gyFI/+uVNk
 pH+wWmu2v5zxuXGU+asekuiv5B0cv6iJFpKpVRP4wBl3RG8GNX7kPaz/bmM6TJc0LiHJiNfc9QF
 P4LW6OjzECLhgoY5jII4r28EbeqQ2KGn641ijrd1IYY3jYNasBgdSO0rt6V1HaS+Lq7V7mTCQFY
 /zhJnVI1zr7Xr3yT/cT3tAyO2sPvHgRBXDSapPzeg46y/+2p3WADNwjLPnj2Xf8t1YbhWc78MqN
 le2hyQXSwj2YNvGOjQMPy2v+gmoRa47mEoGhjkJRZOpcs9Q==
X-Received: by 2002:a05:600c:8b65:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49e7a677411mr40494045e9.23.1789400181050; 
 Mon, 14 Sep 2026 08:36:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8b65:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49e7a677411mr40493185e9.23.1789400180559; 
 Mon, 14 Sep 2026 08:36:20 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d675a50sm525495e9.9.2026.09.14.08.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:36:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:36:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 14/14] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqgQYmbLk6O1Af7I@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-14-d17423589f48@virtuozzo.com>
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

On Mon, Sep 14, 2026 at 11:37:45AM +0300, Andrey Drobyshev wrote:
>The previous patches reuse the source vhost FD on the destination,
>however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>in realize().  For cpr-transfer the destination realizes while the source
>still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>handed over explicitly.
>
>Do this through the device's CPR vmstate hooks.  Namely, release device
>ownership in pre_save, reclaim in post_load, re-acquire on restart:
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
>  - .set_status() refuses to start a device whose init hasn't completed
>    yet (incoming CPR before post_load).
>
>  - .set_status() re-acquires ownership before starting the device if
>    pre_save released it and this QEMU is about to run the guest again:
>    the migration failed, or it completed and the management resumed the
>    source (e.g. cpr-transfer target died).
>
>With the handoff in place, lift the CPR blocker: only ID-less devices,
>which can't preserve their FDs, remain blocked.
>
>Note: this requires kernel side support of VHOST_RESET_OWNER operation
>for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 159 +++++++++++++++++++++++++++++++++++-----
> include/hw/virtio/vhost-vsock.h |   3 +-
> 2 files changed, 144 insertions(+), 18 deletions(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index 203055354ae..e3d83815ed3 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -77,14 +77,46 @@ static char *vhost_vsock_cpr_name(DeviceState *proxy)
> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>+    VHostVSock *vsock = VHOST_VSOCK(vdev);
>     bool should_start = virtio_device_should_start(vdev, status);
>     int ret;
>
>+    /*
>+     * During CPR, on target the full vhost_dev_init() is deferred to
>+     * post_load.  Refuse to start a half-initialised device rather than
>+     * issue vhost ioctls on it.
>+     */
>+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>+        error_report("vhost-vsock: refusing to start, device init incomplete");
>+        return 0;
>+    }
>+
>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>         return 0;
>     }
>
>     if (should_start) {
>+        /*
>+         * vsock->owner_reset is only set in .pre_save() on CPR migration
>+         * source, after a successful RESET_OWNER op.  If we end up here
>+         * with this flag set - that means that either CPR migration failed,
>+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>+         * target died).  In either case, we need to re-acquire device
>+         * ownership.
>+         *
>+         * On failure leave the device stopped.  The next start attempt
>+         * (guest driver reset, VM stop/cont) retries.
>+         */
>+        if (vsock->owner_reset) {
>+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>+            if (ret < 0) {
>+                error_report("vhost-vsock: cannot re-acquire device "
>+                             "ownership: %s", strerror(-ret));
>+                return 0;
>+            }
>+            vsock->owner_reset = false;
>+        }
>+
>         ret = vhost_vsock_common_start(vdev);
>         if (ret < 0) {
>             return 0;
>@@ -115,8 +147,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
> }
>
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
>+    if (cpr_incoming_needed(NULL) && migration_is_running()) {

Should we also check if vsock->owner_reset is already true?
Or it can never happen?

>+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>+        if (ret < 0) {
>+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>+                         strerror(-ret));
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
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>+    Error *local_err = NULL;
>+    int vhostfd, ret;
>+
>     /*
>      * Only reset vsock connections for non-CPR migration.  For CPR the
>      * guest cid is unchanged, and the cid-change reset would otherwise
>@@ -126,6 +194,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>         return vhost_vsock_common_post_load(opaque, version_id);
>     }
>
>+    /*
>+     * CPR restore case.  The source released device ownership in its
>+     * pre_save.  Complete the handoff here, before the device is started
>+     * at vm_start.  Init vhost device on preserved FD, issue
>+     * VHOST_SET_OWNER on it, and restore the guest cid.
>+     */
>+    vhostfd = cpr_find_fd(cpr_name, 0);
>+    if (vhostfd < 0) {
>+        error_report("vhost-vsock: could not find restored vhost FD");
>+        return -1;
>+    }
>+
>+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>+    if (ret < 0) {
>+        error_report_err(local_err);
>+        cpr_delete_fd(cpr_name, 0);
>+        return ret;
>+    }
>+
>+    ret = vhost_vsock_set_guest_cid(vdev);
>+    if (ret < 0) {
>+        error_report("vhost-vsock: unable to set guest cid: %s",
>+                     strerror(-ret));
>+        vhost_dev_cleanup(&vvc->vhost_dev);
>+        cpr_delete_fd(cpr_name, 0);
>+        return ret;
>+    }
>+
>     return 0;
> }
>
>@@ -137,7 +234,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>         VMSTATE_VIRTIO_DEVICE,
>         VMSTATE_END_OF_LIST()
>     },
>-    .pre_save = vhost_vsock_common_pre_save,
>+    .pre_save = vhost_vsock_pre_save,
>     .post_load = vhost_vsock_post_load,
> };
>
>@@ -149,6 +246,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>     g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>+    bool cpr_incoming = cpr_is_incoming();

nit: maybe this can be introduced by "vhost-vsock: preserve vhost FD 
during CPR" commit.

>     int vhostfd;
>     int ret;
>
>@@ -164,19 +262,21 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
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

Ditto about using `cpr_name` here.

The rest LGTM!

Thanks,
Stefano


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
>+    if (cpr_incoming) {
>         /* Reuse the fd handed over from the source QEMU. */
>         if (!proxy->id) {
>             error_setg(errp, "vhost-vsock: device ID is required for "
>@@ -204,19 +304,40 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>
>     if (!qemu_set_blocking(vhostfd, false, errp)) {
>         close(vhostfd);
>+        if (cpr_incoming) {
>+            cpr_delete_fd(cpr_name, 0);
>+        }
>         goto err_blocker;
>     }
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
>@@ -235,6 +356,10 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
> err_vhost_dev:
>     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
>     vhost_dev_cleanup(&vvc->vhost_dev);
>+    if (cpr_incoming) {
>+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
>+        cpr_delete_fd(cpr_name, 0);
>+    }
> err_virtio:
>     vhost_vsock_common_unrealize(vdev);
> err_blocker:
>diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>index a964d57e1bc..c5b9a488f3b 100644
>--- a/include/hw/virtio/vhost-vsock.h
>+++ b/include/hw/virtio/vhost-vsock.h
>@@ -29,7 +29,8 @@ struct VHostVSock {
>     /*< private >*/
>     VHostVSockCommon parent;
>     VHostVSockConf conf;
>-    Error *migration_blocker;   /* CPR migration is not supported */
>+    Error *migration_blocker;   /* set when the device has no ID */
>+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>
>     /*< public >*/
> };
>
>-- 
>2.47.1
>


