Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD6CA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBt6H-0008R2-DO; Wed, 30 Sep 2026 08:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBt6A-0008QT-5X
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:07:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBt66-0000RL-Mr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:07:45 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68UC7NWh000928
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Sep 2026 21:07:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=H1fmLGKxjdg6GJHqTzvHyicVX2ERwhBwxdCELJF1IfQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790770043; v=1;
 b=ZVXm7DOidu0Wml2gUBirbP3apdRUVsd8HrbOe15rSbHqFKlxXjpZbpOwMzyn2bAw
 30MRK8WKuDNDVUzxyLXIx971MaoqIBys53zIzvoYrFc5QYNnxP6yzsqr/MfCZNmc
 Ka+Hrg0UskxGVyoU7AfDji7GgeLGNHp/E4jGejR54MTlEXOa/zkjXNt0a4k+IQko
 qyScFCLXL7KsZaAAZUIY46yce0812rnTHXCLy4EHiX+t2jGJd5dQCOBlTGd9B1ax
 V1+vys9RExcDLkQdBIKHNkE/jyz4bw/EdSAxWENV9SFdty4LoEnBL6qdhde3XHa2
 2IMY9O3mqtCikslh2y84sg==
Message-ID: <399aa91d-e135-4ff2-a087-02cfc18d2e66@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 30 Sep 2026 21:07:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/17] vhost-vsock: hand off device ownership across CPR
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com,
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-15-12bcf1c0b84a@virtuozzo.com>
 <85a83a6a-a697-4fda-86d1-1a2a0796f5d8@rsg.ci.i.u-tokyo.ac.jp>
 <8a6aa38c-8fe6-477f-8faa-e7a17a41b4c3@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8a6aa38c-8fe6-477f-8faa-e7a17a41b4c3@virtuozzo.com>
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

On 2026/09/30 18:14, Andrey Drobyshev wrote:
> On 9/30/26 8:55 AM, Akihiko Odaki wrote:
>> On 2026/09/30 2:23, Andrey Drobyshev wrote:
>>> The previous patches reuse the source vhost FD on the destination,
>>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>>> in realize().  For cpr-transfer the destination realizes while the source
>>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>>> handed over explicitly.
>>>
>>> Do this through the device's CPR vmstate hooks.  Namely, release device
>>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>>
>>>     - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>>       the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>>       cpr-exec).
>>>
>>>     - .realize(), for an incoming CPR, only sets up the virtio device and
>>>       queries the backend features by calling vhost_dev_init_backend().
>>>       It doesn't take device ownership and doesn't touch the VQs which
>>>       still-running source might use.  The full init is deferred to
>>>       .post_load().
>>>
>>>     - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>>       (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>>       the device is started at vm_start.
>>>
>>>     - .set_status() refuses to start a device whose init hasn't completed
>>>       yet (incoming CPR before post_load).
>>>
>>>     - .set_status() re-acquires ownership before starting the device if
>>>       pre_save released it and this QEMU is about to run the guest again:
>>>       the migration failed, or it completed and the management resumed the
>>>       source (e.g. cpr-transfer target died).
>>>
>>> With the handoff in place, lift the CPR blocker.
>>>
>>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>>
>>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>    hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
>>>    include/hw/virtio/vhost-vsock.h |   2 +-
>>>    2 files changed, 128 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>> index 6e89007b2ce..65ba573da4d 100644
>>> --- a/hw/virtio/vhost-vsock.c
>>> +++ b/hw/virtio/vhost-vsock.c
>>> @@ -21,7 +21,6 @@
>>>    #include "hw/virtio/vhost-vsock.h"
>>>    #include "monitor/monitor.h"
>>>    #include "migration/cpr.h"
>>> -#include "migration/blocker.h"
>>>    #include "migration/misc.h"
>>>    
>>>    static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>>> @@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
>>>    static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>>    {
>>>        VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>>        bool should_start = virtio_device_should_start(vdev, status);
>>>        int ret;
>>>    
>>> +    /*
>>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>>> +     * post_load.  Refuse to start a half-initialised device rather than
>>> +     * issue vhost ioctls on it.
>>> +     */
>>> +    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
>>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>>> +        return 0;
>>> +    }
>>> +
>>>        if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>>            return 0;
>>>        }
>>>    
>>>        if (should_start) {
>>> +        /*
>>> +         * vsock->owner_reset is only set in .pre_save() on CPR migration
>>> +         * source, after a successful RESET_OWNER op.  If we end up here
>>> +         * with this flag set - that means that either CPR migration failed,
>>> +         * or we got 'cont' cmd from the management (e.g. cpr-transfer
>>> +         * target died).  In either case, we need to re-acquire device
>>> +         * ownership.
>>> +         *
>>> +         * On failure leave the device stopped.  The next start attempt
>>> +         * (guest driver reset, VM stop/cont) retries.
>>> +         */
>>> +        if (vsock->owner_reset) {
>>> +            ret = vhost_dev_set_owner(&vvc->vhost_dev);
>>> +            if (ret < 0) {
>>> +                error_report("vhost-vsock: cannot re-acquire device "
>>> +                             "ownership: %s", strerror(-ret));
>>> +                return 0;
>>> +            }
>>> +            vsock->owner_reset = false;
>>> +        }
>>> +
>>>            ret = vhost_vsock_common_start(vdev);
>>>            if (ret < 0) {
>>>                return 0;
>>> @@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>        return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>    }
>>>    
>>> +static int vhost_vsock_pre_save(void *opaque)
>>> +{
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>> +    int ret;
>>> +
>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    /*
>>> +     * Release the device ownership now for CPR migration.  The device is
>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>> +     * VHOST_SET_OWNER in post_load.
>>> +     */
>>> +    if (cpr_incoming_needed(NULL) && migration_is_running() &&
>>> +        !vsock->owner_reset) {
>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>> +        if (ret < 0) {
>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %s",
>>> +                         strerror(-ret));
>>> +            return ret;
>>> +        }
>>> +        vsock->owner_reset = true;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static int vhost_vsock_post_load(void *opaque, int version_id)
>>>    {
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>> +    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
>>> +    Error *local_err = NULL;
>>> +    int vhostfd, ret;
>>> +
>>>        /*
>>>         * Only reset vsock connections for non-CPR migration.  For CPR the
>>>         * guest cid is unchanged, and the cid-change reset would otherwise
>>> @@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>>            return vhost_vsock_common_post_load(opaque, version_id);
>>>        }
>>>    
>>> +    /*
>>> +     * CPR restore case.  The source released device ownership in its
>>> +     * pre_save.  Complete the handoff here, before the device is started
>>> +     * at vm_start.  Init vhost device on preserved FD, issue
>>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>>> +     */
>>> +    vhostfd = cpr_find_fd(cpr_name, 0);
>>> +    if (vhostfd < 0) {
>>> +        error_report("vhost-vsock: could not find restored vhost FD");
>>> +        return -1;
>>> +    }
>>> +
>>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>
>> vhost_dev_init() can successfully issue SET_OWNER and then fail during
>> virtqueue initialization or memory-slot validation. Its cleanup only
>> closes the destination FD; the source still holds the same underlying
>> file, so the kernel retains the destination owner. Resuming the source
>> then makes vhost_vsock_set_status() repeatedly fail SET_OWNER with
>> EBUSY, leaving vsock unusable.
> 
> That's indeed a real bug.  I suppose the fix should be calling
> RESET_OWNER from vhost_dev_init() on the cleanup path.  And it deserves
> a separate commit predating this one.  Thanks for noticing!

Sounds good regarding a separate commit for the cleanup path.

> 
>> I also suggest using GINT_TO_POINTER().
> 
> I'd prefer sticking to plain cast here - only for the sake of
> consistency.  GINT_TO_POINTER() can be done later in a separate commit
> for all such occurrences.

Fair point. I hadn't noticed the other plain casts when I made the 
suggestion.

Regards,
Akihiko Odaki

