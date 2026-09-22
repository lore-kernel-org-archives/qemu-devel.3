Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ABFC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wmQ-0001Dn-GZ; Tue, 22 Sep 2026 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wmM-0001DW-LH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x8wmI-0005El-ES
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790069223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DCxVDpBYW+1w3cI9eQ0cOvmI1vSM+gmdrrfYB+sVUmw=;
 b=Y5A89X6xIUn7dVqZu+KSUc1sn13VLWLIhatpI9hKETYPq2UJdADZ+w4KPjCoFKNOwWvDCN
 1XlAXcGMYaZR5K5+drL0UCpCR8tj+SBH0a8gxo8CiJg+uYnf+JyxoJ6Me17U+PUhfFOUEN
 lOYmzf4BKt9gHfNx310Bst92id1+RJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-14-BMKBvPGuFs37-qbrNxA-1; Tue, 22 Sep 2026 05:26:58 -0400
X-MC-Unique: 14-BMKBvPGuFs37-qbrNxA-1
X-Mimecast-MFC-AGG-ID: 14-BMKBvPGuFs37-qbrNxA_1790069215
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-487041c4c82so1194769f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790069215; x=1790674015; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DCxVDpBYW+1w3cI9eQ0cOvmI1vSM+gmdrrfYB+sVUmw=;
 b=JY+RYgHItHRLCES1GRrhyFTeNL2SE0m/RFuG34221ZT51AAcGgHVZFbqilheCH1Jq5
 kfjU49fGOdmp/HTH0kBLjY5ZsqUIydz41kBiBdjlEsIaD7/74FCDsWPGsQiT5cFnse+B
 8DYx84DOp8AkY2JF9e/Bj0pveqmvqUz1B67mFyh9KbOlMEDkClhwahc/TtJQNs1hY5Fh
 6NikAmyBOpBEwMnFmJfsO4cbRS9SXvLdH9AGvjt0RWErF4HAMI+WwQIwOG2naox5/vvi
 38vwXZ/iwppvWRuImebL8qxONaruwCL+vMx1S/QMawk7U3llZncGc6U4iXGBhIthc2b1
 2d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790069215; x=1790674015;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DCxVDpBYW+1w3cI9eQ0cOvmI1vSM+gmdrrfYB+sVUmw=;
 b=twWsDSDWOn6TOgNBulrOJc/KqNc6kkI7OdXpZRBFksRdo/gqxw8xElAirxAamT8n6X
 y8HdM2hiXid8OAxCOp67ttxxoxkktYWLMuBjo743fmgIKGpyS/cmEK7OcCeMsZ5HoRWY
 XRo3NQAnaIYO/vt3HGtup2fM29h1u4AOvgEysHrJTC2h2vAVOhuRUEO2GTDxKmvOPEht
 Sv9TkqOIwWYEwwcUm6e+ZZtE7dTNv38fLPp3EWIpuymnYbe1PsUozlP+0yFbCUnWEJCt
 6j6w5G1z1NLp9LXV4gPrErOxTRJpo+HbcJRH/BOYhoAfEkIt/1sDP64CqC2+VjL0mcdI
 71SA==
X-Gm-Message-State: AFuF++kfceXzqKY4X96hLRjTHJ1A9wDYtvU90m6vesmRqUNuH9kWCTJ0
 eTyj7mbic6Gs/RQUrYYxluntnffTBYNOSPhbMYHhr+bCHOFpQa/aKJE8fgv3TA/frrhMw7KcZiS
 /L7leOWszK/MVg9UZW4QgF5CfSxLQ8a5ZuXwwaiUNwvmNCwFktCe8elCT
X-Gm-Gg: AYBFou1E9KnmKCxR48iUUfcKCKkOaar0Rnu4ODOVzT6DX+1w6OjVdr6mmMVHMAO5MFI
 dAac85IE4V6g0CvcxFk0+pOzDJsCBZw0xsxgXNnFzyls3UiTMoBELeM0URzKAtN+uSJgFcdVu46
 Z8IyS/3YAmbwxHYqpyh8h19ncdKKfE0+MEJ+sBVB/C+flzEYqSqQQxbtXjRjY2oPXtKzRmyYnEa
 s+oSnYkWSTxtoKjmhGiR/19kZGPc6YlCbunbF1/7wVtfre1bh7OC9IzO53wR3X8SMv1QDtfL6sW
 bvJ16F+BnQo9cfnGvwpV5Vs2Hvrc+vgWPy9i2WfZx0IBzZdrxsTI3C/gOOok3itjrnBcs9oi5Oi
 gQPCMdmtXPas69qZdkbCK0e8TLUlziJTDb7rl6Qm/CjlOL3db7Pg=
X-Received: by 2002:a05:6000:4381:b0:487:c3f:5750 with SMTP id
 ffacd0b85a97d-4871e3a9c43mr19136386f8f.40.1790069215157; 
 Tue, 22 Sep 2026 02:26:55 -0700 (PDT)
X-Received: by 2002:a05:6000:4381:b0:487:c3f:5750 with SMTP id
 ffacd0b85a97d-4871e3a9c43mr19136333f8f.40.1790069214664; 
 Tue, 22 Sep 2026 02:26:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it.
 [82.53.134.131]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862795232sm3642385f8f.32.2026.09.22.02.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 02:26:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:26:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com, 
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, peterx@redhat.com, den@openvz.org
Subject: Re: [PATCH v7 14/16] vhost-vsock: hand off device ownership across CPR
Message-ID: <arJGNRq8UC-XSEpW@sgarzare-redhat>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-14-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-14-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Fri, Sep 18, 2026 at 04:47:05PM +0300, Andrey Drobyshev wrote:
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
>With the handoff in place, lift the CPR blocker.
>
>Note: this requires kernel side support of VHOST_RESET_OWNER operation
>for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
> include/hw/virtio/vhost-vsock.h |   2 +-
> 2 files changed, 128 insertions(+), 31 deletions(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index 6e89007b2ce..65ba573da4d 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -21,7 +21,6 @@
> #include "hw/virtio/vhost-vsock.h"
> #include "monitor/monitor.h"
> #include "migration/cpr.h"
>-#include "migration/blocker.h"
> #include "migration/misc.h"
>
> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
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
>@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
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
>+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
>+        !vsock->owner_reset) {
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
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
>+    Error *local_err = NULL;
>+    int vhostfd, ret;
>+
>     /*
>      * Only reset vsock connections for non-CPR migration.  For CPR the
>      * guest cid is unchanged, and the cid-change reset would otherwise
>@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
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

Why we need to set the CID? Isn't it preserved?

That said, I don't think it is wrong, it seems just superfluous, but 
maybe there is a reason.

The rest LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


