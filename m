Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E81AC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vxM-00072P-6m; Fri, 11 Sep 2026 03:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vxH-00072B-O8
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vxE-00024L-G7
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789112747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JxJRQ5ElSGybEDhTsAX7gOAb/EuBuQ64nGx3K1WuvQ=;
 b=FpYP9jI3R9Lk82+TgVePhBckf1xBIB6PVQJWzHQR68rR/sg1Apf6zxYRefFBf4N7Rd5YZH
 k5damxh5Yx31rvIc7qcKPD4q/49jtcWLoxypwByZus0Dk9tiW+2Mz/zuBH2KTxu9D3OVW9
 2L7G/7qoly2HGtmYqGnqhERA6N94XSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-NecsxSYtN02S_XR_1vQ2uA-1; Fri, 11 Sep 2026 03:45:44 -0400
X-MC-Unique: NecsxSYtN02S_XR_1vQ2uA-1
X-Mimecast-MFC-AGG-ID: NecsxSYtN02S_XR_1vQ2uA_1789112743
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e65f2f1baso1108215e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789112743; x=1789717543; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1JxJRQ5ElSGybEDhTsAX7gOAb/EuBuQ64nGx3K1WuvQ=;
 b=SgEr9x3uU7GoeMBlRwojXL/mqcjA8hfj3FpqSR1SeAZZm12jUHLcSGmHbCzrd9Nsgs
 mjTeC06I8YbgqeqG8D88cuPtGQxrZL1Y5CsW1Vszr3xmfcpxmg75q1JR27oCdZkQF+fA
 uF6G/DV2HmdmrwU04kvRbaDeTLW3NvGbbUvVYpS28x1O2g9hVE58a9G4uvDIk3AS18B8
 6TRhJMR9hmbpvjRr+nAKENjlq1wnIhlgGS9PmUcvPQiE5YKyzOgH96I/0qqd6hQeTfX1
 /oKb7S3043OYNiOBfyqDfcHJ4dPHNENsHsP1pA53Wf2jRXFDJO0TmxlYbYi9E05RFUXq
 q30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789112743; x=1789717543;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JxJRQ5ElSGybEDhTsAX7gOAb/EuBuQ64nGx3K1WuvQ=;
 b=b/VoylrZH5hzPYmY7STX9dZsyV5kbWQw9xxqx3enmmJmvaMEd0QRl2eiiznmPxSof0
 3vZAlseRRsDPmYx1ZeVFOarZnlU+CvxyfSBGOwSpJuFUjAiWMtwhA8oxrJlylxa4fnQr
 +DuUZKE8NM4GbZcv1iXpmzn5YKACmnIXEEjo4AO7fQc+N2OJkaWgIuVzeEn3EsYzxI7O
 ak7qnhp6mdgFNuHUFMucBkBe9j46G0F/AQ58XS/cfhTpMuScPoyPXOVymAxEMycbx69a
 8hmCXvs76yDK+pIdBsuUy8wN+uSdR/+s2IgjrxTHDFvnD4jADqVzJnHg/J/ULe3AKrhf
 5a9A==
X-Gm-Message-State: AFuF++nte8G0be/YYlIr/TeUkDQNNUGu/XLeXmd/Ift92IHG9KI5iOPv
 +XKNLhb3r1daMC6QVdvie+Ru60wQBYDDDOKrTXK2VHpWLt3f4kAq0dpPefNh9owpl4rOcciWA8f
 Z0QI8gllYOibJ4kjoJ1dzMuloQEAPYKKalygkUq/npebzQy3L1ghx0LWa
X-Gm-Gg: AYBFou3KHlgvLKv7XI1jLk/ne9UOAHLC7o/iM9avp8huAmWR4EJi1zP6sUVB7F2e8LF
 fP/z7TDpnR9pAXNNrNXcaWD/4u8geYdV88hzcOWqWPvKRdzYaJd9ViiyueuvYqXMUwexA848two
 t4rTDW1xKoVRoKy8Fd300m3QIuglfTuUpILqHQaDCeBUQaDmiHWJi5/BQJz6wwhomzlcVS8yRhG
 2kMNAzmd3j6AB1p0oXfHHJVUPhKbfRW9ihRTL3fccegMsjLcOCKQlSniOCJxZzv06hUhVlNzZik
 C2doDEXEZWYZPAIRYoRUoO6/5aRZ1yCElv8gqaAKozfOo9ZUGjitD1jv9OZmVX/5tGcqLGdpYaR
 bmaeLEnUXf9d98Wy/Auhv4HjwYJVltCgHIU5PisLlsFQ7Nw==
X-Received: by 2002:a05:600c:3ba3:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49e645e26d2mr20001005e9.5.1789112743258; 
 Fri, 11 Sep 2026 00:45:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba3:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49e645e26d2mr20000365e9.5.1789112742764; 
 Fri, 11 Sep 2026 00:45:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm50386745e9.13.2026.09.11.00.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 00:45:42 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:45:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqOv_Cmxjlk4lQVe@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
 <ap7Lma3zpbr6QDb0@sgarzare-redhat>
 <6e1b82d9-b2c8-4c10-bebd-9d500c14b1de@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6e1b82d9-b2c8-4c10-bebd-9d500c14b1de@virtuozzo.com>
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

On Wed, Sep 09, 2026 at 08:45:22PM +0300, Andrey Drobyshev wrote:
>On 9/7/26 6:13 PM, Stefano Garzarella wrote:
>> On Thu, Aug 20, 2026 at 02:39:55PM +0300, Andrey Drobyshev wrote:
>>> The previous patches reuse the source vhost FD on the destination,
>>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>>> in realize().  For cpr-transfer the destination realizes while the source
>>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>>> handed over explicitly.
>>>
>>> Do this through the device's CPR vmstate hooks.  Namely, release device
>>> ownership in pre_save, reclaim in post_load, re-acquire on failure:
>>>
>>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>>    cpr-exec).
>>>
>>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>>    queries the backend features by calling vhost_dev_init_backend().
>>>    It doesn't take device ownership and doesn't touch the VQs which
>>>    still-running source might use.  The full init is deferred to
>>>    .post_load().
>>>
>>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>>    the device is started at vm_start.
>>>
>>>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>>>    fails after pre_save released it and the source VM is resumed.
>>>
>>>  - .set_status() refuses to start a device whose handoff hasn't
>>>    completed: not fully initialized yet, or left ownerless after a
>>>    failed CPR.
>>>
>>> With the handoff in place, lift the CPR blocker: only ID-less devices,
>>> which can't preserve their FDs, remain blocked.
>>>
>>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
>>> include/hw/virtio/vhost-vsock.h |   5 +-
>>> 2 files changed, 152 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>> index cec2c31f0ca..e25e5350905 100644
>>> --- a/hw/virtio/vhost-vsock.c
>>> +++ b/hw/virtio/vhost-vsock.c
>>> @@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>> {
>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>>     bool should_start = virtio_device_should_start(vdev, status);
>>> +    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
>>>     int ret;
>>>
>>> +    /*
>>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>>> +     * post_load.  On source the device is left without an owner if a
>>> +     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
>>> +     * rather than issue vhost ioctls on a half-initialised or ownerless
>>> +     * device.
>>> +     */
>>> +    if (should_start && (!initialized || vsock->owner_reset)) {
>>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>>> +        return 0;
>>
>> Why returning 0?
>
>That's just what every other error path does here, because return value
>for vhost_vsock_set_status() goes nowhere.  The only thing it'd
>influence is having one more line in the QEMU log when we're called from
>virtio_set_status().

Ah okay, thanks for pointing out :-)

>>> +    }
>>> +
>>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>>         return 0;
>>>     }
>>> @@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>> }
>>>
>>> +/*
>>> + * Re-acquire device ownership if a CPR migration that released it (in
>>> + * vhost_vsock_pre_save()) failed and the source VM is about to resume.
>>> + * This runs before vm_start(), so the device is owned again before it is
>>> + * restarted.
>>> + */
>>> +static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>>> +                                    MigrationEvent *e, Error **errp)
>>> +{
>>> +    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>>> +    int ret;
>>> +
>>> +    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
>>
>> IIUC MIG_EVENT_FAILED only covers the source failing. If the source
>> completes it successfully and something goes wrong afterwards (e.g. in
>> the destination), what will happen?
>
>Hmm that indeed might be a problem for cpr-transfer.  E.g. target fails,
>management (libvirt) sends qmp-cont to source, and we bail out with
>error in vhost_vsock_set_status().
>> Thinking if we can try to call vhost_dev_set_owner() in
>> vhost_vsock_set_status(), expecting also -EBUSY, instead of relying on
>> `vsock->owner_reset`.
>
>Moving .set_owner() to .set_status() actually looks promising, I'll try
>it out and see how that works.  Although I'd still keep the flag and
>restrain from tolerating -EBUSY - we shouldn't proceed to realize the
>device if we don't own it.

Yeah, agree.

>
>
>>> +        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>>> +        if (ret < 0) {
>>> +            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
>>
>> Is it okay to return 0 also in this case?
>
>As of now it's mandatory cause migration_call_notifiers() asserts on
>type == MIG_EVENT_SETUP whenever notifier returns non-null.

I see, thanks.

>>> +        } else {
>>> +            vsock->owner_reset = false;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
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
>>> +    if (cpr_incoming_needed(NULL)) {
>>
>> Am I missing something that keeps pre_save from running outside an
>> actual CPR migration (savevm, or any save path taken while mode is still
>> set from an earlier attempt), or should the condition be tied to a CPR
>> migration actually being in flight rather than to the mode parameter
>> alone?
>
>You're right, that's a real bug.  Should probably guard it with
>cpr_incoming_needed(NULL) && migration_is_running().

Yeah, that looks better to me too.

>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>> +        if (ret < 0) {
>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
>>
>> vhost-vsock devices that don't support `reset_owner` will fail here,
>> right? Is that what we expect?
>
>Which devices you mean?  No other vhost-vsock devices should ever end up
>here, e.g. vhost-user-vsock has .unmigratable = 1 set, so .pre_save() is
>never run for it.  If you mean the kernels which don't support
>RESET_OWNER - then yes, we'll fail here.

Yep, I meant the kernel.

I'd like to better understand what happens when we perform CPR with a 
vhost-vsock device and a kernel that doesn't support RESET_OWNER. Both 
before and after this series.

>>> +            return ret;
>>> +        }
>>> +        vsock->owner_reset = true;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>> {
>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>> +    Error *local_err = NULL;
>>> +    int vhostfd, ret;
>>> +
>>>     /*
>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>> @@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>>         return vhost_vsock_common_post_load(opaque, version_id);
>>>     }
>>>
>>> +    /*
>>> +     * CPR restore case.  The source released device ownership in its
>>> +     * pre_save.  Complete the handoff here, before the device is started
>>> +     * at vm_start.  Init vhost device on preserved FD, issue
>>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>>> +     */
>>> +    vhostfd = cpr_find_fd(proxy->id, 0);
>>> +    if (vhostfd < 0) {
>>> +        error_report("vhost-vsock: could not find restored vhost FD");
>>> +        return -1;
>>> +    }
>>> +
>>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>>> +    if (ret < 0) {
>>> +        error_report_err(local_err);
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = vhost_vsock_set_guest_cid(vdev);
>>> +    if (ret < 0) {
>>> +        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>>> +        vhost_dev_cleanup(&vvc->vhost_dev);
>>> +        return ret;
>>> +    }
>>> +
>>>     return 0;
>>> }
>>>
>>> @@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>>         VMSTATE_VIRTIO_DEVICE,
>>>         VMSTATE_END_OF_LIST()
>>>     },
>>> -    .pre_save = vhost_vsock_common_pre_save,
>>> +    .pre_save = vhost_vsock_pre_save,
>>>     .post_load = vhost_vsock_post_load,
>>> };
>>>
>>> @@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>> +    bool cpr_incoming = cpr_is_incoming();
>>>     int vhostfd;
>>>     int ret;
>>>
>>> @@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>     }
>>>
>>>     /*
>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>> -     * device ownership is not handed over, so the target fails to set
>>> -     * up its device.  Fail the migration early and gracefully instead.
>>> +     * With the ownership handoff in place CPR migration is now supported.
>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>> +     * we only keep the migration blocker for the ID-less case.
>>>      */
>>> -    error_setg(&vsock->migration_blocker,
>>> -               "vhost-vsock: CPR migration is not supported");
>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>> -        return;
>>> +    if (!proxy->id) {
>>> +        error_setg(&vsock->migration_blocker,
>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>> +            return;
>>> +        }
>>>     }
>>>
>>> -    if (cpr_is_incoming()) {
>>> +    /*
>>> +     * Re-acquire ownership if a CPR migration releases it (in 
>>> pre_save) but
>>> +     * then fails.
>>> +     */
>>> +    migration_add_notifier_modes(&vsock->cpr_notifier,
>>> +                                 vhost_vsock_cpr_notifier,
>>> +                                 BIT(MIG_MODE_CPR_TRANSFER) |
>>> +                                 BIT(MIG_MODE_CPR_EXEC));
>>> +
>>> +    if (cpr_incoming) {
>>>         /* Reuse the fd handed over from the source QEMU. */
>>>         if (!proxy->id) {
>>>             error_setg(errp, "vhost-vsock: device ID is required for "
>>> @@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>
>>>     vhost_vsock_common_realize(vdev);
>>>
>>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>> -    if (ret < 0) {
>>> +    if (!cpr_incoming) {
>>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>> +        if (ret < 0) {
>>> +            /*
>>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>>> +             * by vhost_dev_init on initialization error.
>>> +             */
>>> +            goto err_virtio;
>>> +        }
>>> +    } else {
>>>         /*
>>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>>> -         * by vhost_dev_init on initialization error.
>>> +         * CPR restore case: only learn the backend feature set now, but
>>> +         * defer taking ownership or touching VQs (the still-running source
>>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>>> +         * is done later in post_load.
>>>          */
>>> -        goto err_virtio;
>>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>>> +                                     (void *)(uintptr_t)vhostfd,
>>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>>> +        if (ret < 0) {
>>> +            /* vhost_dev_init_backend() does not close the fd on error */
>>
>> Okay, but IIUC this is returned by cpr_find_fd(), is that funtion
>> passing the ownership of the fd, even that the fd is not removed from
>> the hash table?
>>
>> Should we call cpr_delete_fd() when we take it?
>
>You're right, that should be a proper cleanup.  Every path that closes
>the fd after a successful cpr_find_fd() should also drop the entry.
>Will add this.

I don't know how CPR works, but if we don't close the FD here, will it 
be closed later? I mean, if we leave it on the map, will someone else 
close it?

That way, we don't have a different situation here.

That said, I'm fine also with your solution.

Thanks,
Stefano


