Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2FDCA5FCE
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 03:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCU2H-0007ar-3g; Thu, 01 Oct 2026 23:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCU2E-0007ab-Uc
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:34:10 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xCU2A-0006JL-9K
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 23:34:10 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6923XdQi024225
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 2 Oct 2026 12:33:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S98OeaeYoLt9VxTWmv0rfllCDisW68XX6M3NxFpTe5M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790912019; v=1;
 b=IYeUSfKD3vReXEXj2pKP1SYHQ24jEkYYeNLN2iMV6GT9oCOW/yyDodwTRI+ahBM4
 PXXUT8vyfDcypig/ZeufAhIPs2lzKp7hyDpDP9Ezht2US/AX7EDAraUjMT3nWnW1
 nR5+i1GtxwVJCRMExg51nOj6JH7I73L8/4NFYaUVTBmgBfrDVUtKkNirhM2HUHAS
 0UotTokW3mLbf4s9gAxuLSu6MkdHDuCPjsN+wt/jDV7RReM5fxOIEbvteT3EQJm6
 NB2CI+gdMywGMulKHQsRu25WQVAFzf/ec09kFv9hRhZV9LuYjF2WPeFpGuEN3b49
 9r0U1L1s7XXEdla1/Otn9g==
Message-ID: <8599ac70-7443-4dc9-975c-ee59166354ac@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 2 Oct 2026 12:33:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/18] vhost-vsock: hand off device ownership across
 CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, dwmw2@infradead.org, peterx@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, vsementsov@yandex-team.ru, farosas@suse.de,
 mark.kanda@oracle.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 bchaney@akamai.com, clg@redhat.com
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
 <20261001-up-vsock-vhost-v5-v10-16-8c094843e98b@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-16-8c094843e98b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/01 17:25, Andrey Drobyshev wrote:
> The previous patches reuse the source vhost FD on the destination,
> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
> in realize().  For cpr-transfer the destination realizes while the source
> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
> handed over explicitly.
> 
> Do this through the device's CPR vmstate hooks.  Namely, release device
> ownership in pre_save, reclaim in post_load, re-acquire on restart:
> 
>    - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>      the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>      cpr-exec).
> 
>    - .realize(), for an incoming CPR, only sets up the virtio device and
>      queries the backend features by calling vhost_dev_init_backend().
>      It doesn't take device ownership and doesn't touch the VQs which
>      still-running source might use.  The full init is deferred to
>      .post_load().
> 
>    - .post_load() reclaims it on the destination: the full vhost_dev_init()
>      (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>      the device is started at vm_start.
> 
>    - .set_status() refuses to start a device whose init hasn't completed
>      yet (incoming CPR before post_load).
> 
>    - .set_status() re-acquires ownership before starting the device if
>      pre_save released it and this QEMU is about to run the guest again:
>      the migration failed, or it completed and the management resumed the
>      source (e.g. cpr-transfer target died).
> 
> With the handoff in place, lift the CPR blocker.
> 
> Note: this requires kernel side support of VHOST_RESET_OWNER operation
> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
> 
> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>   include/hw/virtio/vhost-vsock.h |   2 +-
>   2 files changed, 128 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index 6e89007b2ce..65ba573da4d 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -21,7 +21,6 @@
>   #include "hw/virtio/vhost-vsock.h"
>   #include "monitor/monitor.h"
>   #include "migration/cpr.h"
> -#include "migration/blocker.h"
>   #include "migration/misc.h"
>   
>   static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>   static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>   {
>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>       bool should_start = virtio_device_should_start(vdev, status);
>       int ret;
>   
> +    /*
> +     * During CPR, on target the full vhost_dev_init() is deferred to
> +     * post_load.  Refuse to start a half-initialised device rather than
> +     * issue vhost ioctls on it.
> +     */
> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
> +        error_report("vhost-vsock: refusing to start, device init incomplete");
> +        return 0;
> +    }
> +
>       if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>           return 0;
>       }
>   
>       if (should_start) {
> +        /*
> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
> +         * source, after a successful RESET_OWNER op.  If we end up here
> +         * with this flag set - that means that either CPR migration failed,
> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
> +         * target died).  In either case, we need to re-acquire device
> +         * ownership.

I'm not requesting changes to this patch, but there is a case where
the source cannot reacquire ownership:

1. The destination successfully completes vhost_vsock_post_load().

2. A subsequent load error, such as a truncated VMState section
    footer, causes the destination to call exit() without reaching
    vhost_dev_cleanup().

3. The source still holds an FD for the same open file, so closing
    the destination's FD does not destroy the kernel backend or
    release its retained owner.

4. Resuming the source with cont calls VHOST_SET_OWNER, which fails
    with -EBUSY. Repeated attempts do not resolve the stale ownership.

An atexit() hook could cover this exit() path, but would not run after 
SIGKILL or abort(). This appears to be a broader limitation of the 
kernel vhost UAPI when sharing an open file between processes: recovery 
cannot rely solely on the destination releasing ownership before it exits.

Regards,
Akihiko Odaki

> +         *
> +         * On failure leave the device stopped.  The next start attempt
> +         * (guest driver reset, VM stop/cont) retries.
> +         */
> +        if (vsock->owner_reset) {
> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
> +            if (ret < 0) {
> +                error_report("vhost-vsock: cannot re-acquire device "
> +                             "ownership: %s", strerror(-ret));
> +                return 0;
> +            }
> +            vsock->owner_reset = false;
> +        }
> +
>           ret = vhost_vsock_common_start(vdev);
>           if (ret < 0) {
>               return 0;
> @@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>       return vhost_vsock_common_get_features(vdev, requested_features, errp);
>   }
>   
> +static int vhost_vsock_pre_save(void *opaque)
> +{
> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
> +    int ret;
> +
> +    ret = vhost_vsock_common_pre_save(opaque);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Release the device ownership now for CPR migration.  The device is
> +     * already stopped at pre_save, and destination reclaims it by calling
> +     * VHOST_SET_OWNER in post_load.
> +     */
> +    if (cpr_incoming_needed(NULL) && migration_is_running() &&
> +        !vsock->owner_reset) {
> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
> +        if (ret < 0) {
> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
> +                         strerror(-ret));
> +            return ret;
> +        }
> +        vsock->owner_reset = true;
> +    }
> +
> +    return 0;
> +}
> +
>   static int vhost_vsock_post_load(void *opaque, int version_id)
>   {
> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
> +    Error *local_err = NULL;
> +    int vhostfd, ret;
> +
>       /*
>        * Only reset vsock connections for non-CPR migration.  For CPR the
>        * guest cid is unchanged, and the cid-change reset would otherwise
> @@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>           return vhost_vsock_common_post_load(opaque, version_id);
>       }
>   
> +    /*
> +     * CPR restore case.  The source released device ownership in its
> +     * pre_save.  Complete the handoff here, before the device is started
> +     * at vm_start.  Init vhost device on preserved FD, issue
> +     * VHOST_SET_OWNER on it, and restore the guest cid.
> +     */
> +    vhostfd = cpr_find_fd(cpr_name, 0);
> +    if (vhostfd < 0) {
> +        error_report("vhost-vsock: could not find restored vhost FD");
> +        return -1;
> +    }
> +
> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +        cpr_delete_fd(cpr_name, 0);
> +        return ret;
> +    }
> +
> +    ret = vhost_vsock_set_guest_cid(vdev);
> +    if (ret < 0) {
> +        error_report("vhost-vsock: unable to set guest cid: %s",
> +                     strerror(-ret));
> +        vhost_dev_cleanup(&vvc->vhost_dev);
> +        cpr_delete_fd(cpr_name, 0);
> +        return ret;
> +    }
> +
>       return 0;
>   }
>   
> @@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>           VMSTATE_VIRTIO_DEVICE,
>           VMSTATE_END_OF_LIST()
>       },
> -    .pre_save = vhost_vsock_common_pre_save,
> +    .pre_save = vhost_vsock_pre_save,
>       .post_load = vhost_vsock_post_load,
>   };
>   
> @@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    /*
> -     * CPR migration of a vhost-vsock device is not supported yet: the
> -     * device ownership is not handed over, so the target fails to set
> -     * up its device.  Fail the migration early and gracefully instead.
> -     */
> -    error_setg(&vsock->migration_blocker,
> -               "vhost-vsock: CPR migration is not supported");
> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
> -        return;
> -    }
> -
>       if (cpr_incoming) {
>           /* Reuse the fd handed over from the source QEMU */
>           vhostfd = cpr_find_fd(cpr_name, 0);
>           if (vhostfd < 0) {
>               error_setg(errp, "vhost-vsock: could not find restored vhost FD");
> -            goto err_blocker;
> +            return;
>           }
>       } else if (vsock->conf.vhostfd) {
>           vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>           if (vhostfd == -1) {
>               error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
> -            goto err_blocker;
> +            return;
>           }
>       } else {
>           vhostfd = open("/dev/vhost-vsock", O_RDWR);
>           if (vhostfd < 0) {
>               error_setg_file_open(errp, errno, "/dev/vhost-vsock");
> -            goto err_blocker;
> +            return;
>           }
>       }
>   
> @@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>           if (cpr_incoming) {
>               cpr_delete_fd(cpr_name, 0);
>           }
> -        goto err_blocker;
> +        return;
>       }
>   
>       vhost_vsock_common_realize(vdev);
>   
> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
> -    if (ret < 0) {
> +    if (!cpr_incoming) {
> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
> +        if (ret < 0) {
> +            /*
> +             * vhostfd is closed by vhost_dev_cleanup, which is called
> +             * by vhost_dev_init on initialization error.
> +             */
> +            goto err_virtio;
> +        }
> +    } else {
>           /*
> -         * vhostfd is closed by vhost_dev_cleanup, which is called
> -         * by vhost_dev_init on initialization error.
> +         * CPR restore case: only learn the backend feature set now, but
> +         * defer taking ownership or touching VQs (the still-running source
> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
> +         * is done later in post_load.
>            */
> -        goto err_virtio;
> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
> +                                     (void *)(uintptr_t)vhostfd,
> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
> +        if (ret < 0) {
> +            /* vhost_dev_init_backend() does not close the fd on error */
> +            goto err_vhost_dev;
> +        }
> +
> +        return;
>       }
>   
>       ret = vhost_vsock_set_guest_cid(vdev);
> @@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>       }
>   
>       /* Register the fd for a future CPR after a fully successful realize */
> -    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
> +    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>           goto err_vhost_dev;
>       }
>   
> @@ -247,22 +348,18 @@ err_vhost_dev:
>       }
>   err_virtio:
>       vhost_vsock_common_unrealize(vdev);
> -err_blocker:
> -    migrate_del_blocker(&vsock->migration_blocker);
>   }
>   
>   static void vhost_vsock_device_unrealize(DeviceState *dev)
>   {
>       VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VHostVSock *vsock = VHOST_VSOCK(dev);
>       g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>   
>       /* This will stop vhost backend if appropriate. */
>       vhost_vsock_set_status(vdev, 0);
>   
>       cpr_delete_fd(cpr_name, 0);
> -    migrate_del_blocker(&vsock->migration_blocker);
>       vhost_dev_cleanup(&vvc->vhost_dev);
>       vhost_vsock_common_unrealize(vdev);
>   }
> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
> index a964d57e1bc..6e1c39383ef 100644
> --- a/include/hw/virtio/vhost-vsock.h
> +++ b/include/hw/virtio/vhost-vsock.h
> @@ -29,7 +29,7 @@ struct VHostVSock {
>       /*< private >*/
>       VHostVSockCommon parent;
>       VHostVSockConf conf;
> -    Error *migration_blocker;   /* CPR migration is not supported */
> +    bool owner_reset;           /* CPR released ownership; needs re-acquire */
>   
>       /*< public >*/
>   };
> 


