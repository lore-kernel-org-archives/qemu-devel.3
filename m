Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB27FC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62fB-0007FO-D6; Mon, 14 Sep 2026 05:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x62f7-0007FC-5c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x62f4-0004CC-BF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789376857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZX7ZwxyLL11+GNL3zOgiWYlQ2jGwOWlOYkpor/SFeY=;
 b=jOL0Jsq62LwvixYTVb04lYRv+Ubqtf0VKF+QRT9dMtIgH0RvJS9+KUzOVStdLu9E3JrKYe
 NckWEInk4w8M/atrYCWmKLyPisE7A+xBYka3y/KkHM3ZLUhpmR4GKoXN4RPSE2SZp1rqao
 nUDDF/0UDSGLCXEwtGYR9w4nouudf4Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-0BRe1SXuMPip3Sn9UqS7-w-1; Mon, 14 Sep 2026 05:07:35 -0400
X-MC-Unique: 0BRe1SXuMPip3Sn9UqS7-w-1
X-Mimecast-MFC-AGG-ID: 0BRe1SXuMPip3Sn9UqS7-w_1789376854
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so32599275e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789376854; x=1789981654; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YZX7ZwxyLL11+GNL3zOgiWYlQ2jGwOWlOYkpor/SFeY=;
 b=aLoP2WZOopbkaMOoYGVEh2BuQawSLggfNxB3ga0STJmdErP3N6h+NdhYbAhdeRRr5l
 q5momMLCyZrTOICKlyiLn4Z5s4XFe1plkFsT4ObgL/CAjqT6VUlmBjCqbmM/UNOhhvN6
 OODQSWsXtXLK3pZbmtJFDyUUO6mDK0SWLw55Lr1WbCeIt5+mjxSQkxr33AJho142tmYX
 iCYXrVmfvpRdlMNeE3U7UNzrAW5gKkT7+poNjGGn3DBVngaCZE7cZBoANmmkgVz/qEis
 UxIP9FR75kcfOEY+AVCkuV2w8NhKu9PTq/OLhkYYvXh1w2M6bhqseS6DfzLa5Pw7xFNf
 xoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376854; x=1789981654;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZX7ZwxyLL11+GNL3zOgiWYlQ2jGwOWlOYkpor/SFeY=;
 b=ExeVYbenvwgfZEmzTA+saMdqDjtnQsmU6K+lP89ZYxsUwSGLxDzuMCwBlu/cmqy95a
 tfKrel1x5vpC+V2ObkpZn++snJ50T/piT1kihF6RNl8y8/W9aORB3FbaRadG7VqtJOMA
 tW7nSIA7NfOjukc+PEPtPuTVy1RFUXUBZeFMhS78TvpL9l3w6k/btJmLJNMmcR7fXxIc
 FafotB8OYcb6mErbs3xLC5XUlAIpnX3kAVTfv4Shz78Xl/jwnUONM1BjzgZc/OskPyji
 Fh117zZcVbyoq77mzyjICPDsBqzRcgNKHt9CwWiXBSBpx+OArpc67CJPpSJ6w2PUG+i1
 e6ng==
X-Gm-Message-State: AFuF++kMPg/uWvm9h4dbpoMj0RrdcDK84SquvB7utpzyJpYw7HccMuD3
 alghvcPX56hgyfP9O7ArmCjoSq+00LLM0ySELwVDfiM2ovGKkvMsqNFyE3C1N2bW1VHLOlgN8Vc
 XL68KxPVeZVV1tPuIbxDQkv1WuiHlDvNoZy0CuELteJdy2LfTKoUVqQNQ
X-Gm-Gg: AYBFou2F06AAGX4jiyx709TGeKkxF1P2zREjqi2un6LpAC5sMa4nGTZOGHRXhstX50g
 pSACeLFgwySWEjjhPpUMm+ZgFT/SccEWvSMfO74OWLMV7ZJvYEJqiTwvKUB7AYamp67nCfErOGq
 eeJQdDUuSPy+bGi6t6skA4q7fsQ6oaTBMmIBOvFF7EPhljTHmAqn4+vmTcKTo//lKRYOdg92/sG
 Oisg7mM9Gd+XWJhnnE7G7CTCZzXbWVsjqIYTAz6w/g4xR3Kd132GGBG2YjVp2+FRijMu2sZJdWX
 ku+5lxjhJNU1aDA9NJjq0lJebA3OoH4KLcrY4//zA8a9Ad3AjkQfGtz1JXTO5V5ZFK4sY8QSX21
 iKOg/VR5UqpHxpl7CZ7x/BHZd3q2S1J1mvIKSdsUOc75TKw==
X-Received: by 2002:a05:600c:4e11:b0:49e:6c9b:4e94 with SMTP id
 5b1f17b1804b1-49e7a6933eamr17011055e9.28.1789376853944; 
 Mon, 14 Sep 2026 02:07:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4e11:b0:49e:6c9b:4e94 with SMTP id
 5b1f17b1804b1-49e7a6933eamr17010185e9.28.1789376853104; 
 Mon, 14 Sep 2026 02:07:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6fe9d3e3sm122409315e9.0.2026.09.14.02.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:07:32 -0700 (PDT)
Date: Mon, 14 Sep 2026 11:07:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 10/10] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqe5DuWYMUz2Urwm@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-11-andrey.drobyshev@virtuozzo.com>
 <ap7Lma3zpbr6QDb0@sgarzare-redhat>
 <6e1b82d9-b2c8-4c10-bebd-9d500c14b1de@virtuozzo.com>
 <aqOv_Cmxjlk4lQVe@sgarzare-redhat>
 <62183555-7b0a-4c80-8f73-5b489d8d37f3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <62183555-7b0a-4c80-8f73-5b489d8d37f3@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Sep 11, 2026 at 07:35:43PM +0300, Andrey Drobyshev wrote:
>On 9/11/26 10:45 AM, Stefano Garzarella wrote:
>> On Wed, Sep 09, 2026 at 08:45:22PM +0300, Andrey Drobyshev wrote:
>>> On 9/7/26 6:13 PM, Stefano Garzarella wrote:
>>>> On Thu, Aug 20, 2026 at 02:39:55PM +0300, Andrey Drobyshev wrote:
>>>>> The previous patches reuse the source vhost FD on the destination,
>>>>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>>>>> in realize().  For cpr-transfer the destination realizes while the source
>>>>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>>>>> handed over explicitly.
>>>>>
>>>>> Do this through the device's CPR vmstate hooks.  Namely, release device
>>>>> ownership in pre_save, reclaim in post_load, re-acquire on failure:
>>>>>
>>>>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>>>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>>>>    cpr-exec).
>>>>>
>>>>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>>>>    queries the backend features by calling vhost_dev_init_backend().
>>>>>    It doesn't take device ownership and doesn't touch the VQs which
>>>>>    still-running source might use.  The full init is deferred to
>>>>>    .post_load().
>>>>>
>>>>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>>>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>>>>    the device is started at vm_start.
>>>>>
>>>>>  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
>>>>>    fails after pre_save released it and the source VM is resumed.
>>>>>
>>>>>  - .set_status() refuses to start a device whose handoff hasn't
>>>>>    completed: not fully initialized yet, or left ownerless after a
>>>>>    failed CPR.
>>>>>
>>>>> With the handoff in place, lift the CPR blocker: only ID-less devices,
>>>>> which can't preserve their FDs, remain blocked.
>>>>>
>>>>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> hw/virtio/vhost-vsock.c         | 165 ++++++++++++++++++++++++++++----
>>>>> include/hw/virtio/vhost-vsock.h |   5 +-
>>>>> 2 files changed, 152 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>>>> index cec2c31f0ca..e25e5350905 100644
>>>>> --- a/hw/virtio/vhost-vsock.c
>>>>> +++ b/hw/virtio/vhost-vsock.c
>>>>> @@ -73,9 +73,23 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>>>>> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
>>>>> {
>>>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
>>>>> +    VHostVSock *vsock = VHOST_VSOCK(vdev);
>>>>>     bool should_start = virtio_device_should_start(vdev, status);
>>>>> +    bool initialized = vhost_dev_is_initialized(&vvc->vhost_dev);
>>>>>     int ret;
>>>>>
>>>>> +    /*
>>>>> +     * During CPR, on target the full vhost_dev_init() is deferred to
>>>>> +     * post_load.  On source the device is left without an owner if a
>>>>> +     * failed CPR couldn't re-acquire it.  Refuse to start in both cases
>>>>> +     * rather than issue vhost ioctls on a half-initialised or ownerless
>>>>> +     * device.
>>>>> +     */
>>>>> +    if (should_start && (!initialized || vsock->owner_reset)) {
>>>>> +        error_report("vhost-vsock: refusing to start, device init incomplete");
>>>>> +        return 0;
>>>>
>>>> Why returning 0?
>>>
>>> That's just what every other error path does here, because return value
>>> for vhost_vsock_set_status() goes nowhere.  The only thing it'd
>>> influence is having one more line in the QEMU log when we're called from
>>> virtio_set_status().
>>
>> Ah okay, thanks for pointing out :-)
>>
>>>>> +    }
>>>>> +
>>>>>     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
>>>>>         return 0;
>>>>>     }
>>>>> @@ -111,8 +125,67 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
>>>>>     return vhost_vsock_common_get_features(vdev, requested_features, errp);
>>>>> }
>>>>>
>>>>> +/*
>>>>> + * Re-acquire device ownership if a CPR migration that released it (in
>>>>> + * vhost_vsock_pre_save()) failed and the source VM is about to resume.
>>>>> + * This runs before vm_start(), so the device is owned again before it is
>>>>> + * restarted.
>>>>> + */
>>>>> +static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
>>>>> +                                    MigrationEvent *e, Error **errp)
>>>>> +{
>>>>> +    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
>>>>> +    int ret;
>>>>> +
>>>>> +    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
>>>>
>>>> IIUC MIG_EVENT_FAILED only covers the source failing. If the source
>>>> completes it successfully and something goes wrong afterwards (e.g. in
>>>> the destination), what will happen?
>>>
>>> Hmm that indeed might be a problem for cpr-transfer.  E.g. target fails,
>>> management (libvirt) sends qmp-cont to source, and we bail out with
>>> error in vhost_vsock_set_status().
>>>> Thinking if we can try to call vhost_dev_set_owner() in
>>>> vhost_vsock_set_status(), expecting also -EBUSY, instead of relying on
>>>> `vsock->owner_reset`.
>>>
>>> Moving .set_owner() to .set_status() actually looks promising, I'll try
>>> it out and see how that works.  Although I'd still keep the flag and
>>> restrain from tolerating -EBUSY - we shouldn't proceed to realize the
>>> device if we don't own it.
>>
>> Yeah, agree.
>>
>>>
>>>
>>>>> +        ret = vhost_dev_set_owner(&vvc->vhost_dev);
>>>>> +        if (ret < 0) {
>>>>> +            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
>>>>
>>>> Is it okay to return 0 also in this case?
>>>
>>> As of now it's mandatory cause migration_call_notifiers() asserts on
>>> type == MIG_EVENT_SETUP whenever notifier returns non-null.
>>
>> I see, thanks.
>>
>>>>> +        } else {
>>>>> +            vsock->owner_reset = false;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int vhost_vsock_pre_save(void *opaque)
>>>>> +{
>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>> +    VHostVSock *vsock = VHOST_VSOCK(opaque);
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = vhost_vsock_common_pre_save(opaque);
>>>>> +    if (ret) {
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * Release the device ownership now for CPR migration.  The device is
>>>>> +     * already stopped at pre_save, and destination reclaims it by calling
>>>>> +     * VHOST_SET_OWNER in post_load.
>>>>> +     */
>>>>> +    if (cpr_incoming_needed(NULL)) {
>>>>
>>>> Am I missing something that keeps pre_save from running outside an
>>>> actual CPR migration (savevm, or any save path taken while mode is still
>>>> set from an earlier attempt), or should the condition be tied to a CPR
>>>> migration actually being in flight rather than to the mode parameter
>>>> alone?
>>>
>>> You're right, that's a real bug.  Should probably guard it with
>>> cpr_incoming_needed(NULL) && migration_is_running().
>>
>> Yeah, that looks better to me too.
>
>Actually I checked, and this is not enough:
>
>  qemu_savevm_state() ->
>    migrate_init() ->
>      migrate_set_state(MIGRATION_STATUS_SETUP)
>
>And migration_is_running() returns true when in MIGRATION_STATUS_SETUP.
>So on savevm we still encounter the same bug.
>
>Now, the savevm/loadvm operation doesn't make any sense at all in
>cpr-exec or cpr-transfer mode.  That's because savevm/loadvm suggests
>saving VM state, which implies saving its RAM entirely.  And the whole
>point ot CPR is avoiding saving entire RAM (see migrate_ram_is_ignored()
>in migration/ram.c).
>
>So I'm guessing the proper fix would be patching migrate_can_snapshot(),
>which guards 'save/load-snapshot' and 'savevm'/'loadvm' commands, to
>make sure they can never fire with any of CPR modes set.  I'll add this
>as a separate patch.
>
>migration_is_running() should probably be kept here to guard from things
>like qemu_save_device_state().

Makes sense to me!

>>>>> +        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
>>>>> +        if (ret < 0) {
>>>>> +            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
>>>>
>>>> vhost-vsock devices that don't support `reset_owner` will fail here,
>>>> right? Is that what we expect?
>>>
>>> Which devices you mean?  No other vhost-vsock devices should ever end up
>>> here, e.g. vhost-user-vsock has .unmigratable = 1 set, so .pre_save() is
>>> never run for it.  If you mean the kernels which don't support
>>> RESET_OWNER - then yes, we'll fail here.
>>
>> Yep, I meant the kernel.
>>
>> I'd like to better understand what happens when we perform CPR with a
>> vhost-vsock device and a kernel that doesn't support RESET_OWNER. Both
>> before and after this series.
>
>Before the series obviously nobody was issuing RESET_OWNER.  And without
>the RESET_OWNER, AFAICT, cpr-transfer fails on the target at
>SET_GUEST_CID with EADDRINUSE because the source still holds the CID.
>
>After the series, whenever RESET_OWNER operation fails, and it fails on
>the migration source in .pre_save(), we get:
>
>  - 'migrate' command itself returns success;
>  - 'query-migrate' reports status=failed with "pre-save failed...";
>  - QEMU's stderr ot log contains "vhost-vsock: vhost_reset_owner
>    failed: %d".
>
>That's what happens on source.  If it's cpr-transfer - target dies
>reading a truncated stream.

Thanks for clarifying!

>>>>> +            return ret;
>>>>> +        }
>>>>> +        vsock->owner_reset = true;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> static int vhost_vsock_post_load(void *opaque, int version_id)
>>>>> {
>>>>> +    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
>>>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
>>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
>>>>> +    Error *local_err = NULL;
>>>>> +    int vhostfd, ret;
>>>>> +
>>>>>     /*
>>>>>      * Only reset vsock connections for non-CPR migration.  For CPR the
>>>>>      * guest cid is unchanged, and the cid-change reset would otherwise
>>>>> @@ -122,6 +195,32 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
>>>>>         return vhost_vsock_common_post_load(opaque, version_id);
>>>>>     }
>>>>>
>>>>> +    /*
>>>>> +     * CPR restore case.  The source released device ownership in its
>>>>> +     * pre_save.  Complete the handoff here, before the device is started
>>>>> +     * at vm_start.  Init vhost device on preserved FD, issue
>>>>> +     * VHOST_SET_OWNER on it, and restore the guest cid.
>>>>> +     */
>>>>> +    vhostfd = cpr_find_fd(proxy->id, 0);
>>>>> +    if (vhostfd < 0) {
>>>>> +        error_report("vhost-vsock: could not find restored vhost FD");
>>>>> +        return -1;
>>>>> +    }
>>>>> +
>>>>> +    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>>> +                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
>>>>> +    if (ret < 0) {
>>>>> +        error_report_err(local_err);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    ret = vhost_vsock_set_guest_cid(vdev);
>>>>> +    if (ret < 0) {
>>>>> +        error_report("vhost-vsock: unable to set guest cid: %d", ret);
>>>>> +        vhost_dev_cleanup(&vvc->vhost_dev);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>>     return 0;
>>>>> }
>>>>>
>>>>> @@ -133,7 +232,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
>>>>>         VMSTATE_VIRTIO_DEVICE,
>>>>>         VMSTATE_END_OF_LIST()
>>>>>     },
>>>>> -    .pre_save = vhost_vsock_common_pre_save,
>>>>> +    .pre_save = vhost_vsock_pre_save,
>>>>>     .post_load = vhost_vsock_post_load,
>>>>> };
>>>>>
>>>>> @@ -144,6 +243,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>>>>     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>>>> +    bool cpr_incoming = cpr_is_incoming();
>>>>>     int vhostfd;
>>>>>     int ret;
>>>>>
>>>>> @@ -159,19 +259,30 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>>     }
>>>>>
>>>>>     /*
>>>>> -     * CPR migration of a vhost-vsock device is not supported yet: the
>>>>> -     * device ownership is not handed over, so the target fails to set
>>>>> -     * up its device.  Fail the migration early and gracefully instead.
>>>>> +     * With the ownership handoff in place CPR migration is now supported.
>>>>> +     * Having a unique ID is mandatory for FD preservation during it, thus
>>>>> +     * we only keep the migration blocker for the ID-less case.
>>>>>      */
>>>>> -    error_setg(&vsock->migration_blocker,
>>>>> -               "vhost-vsock: CPR migration is not supported");
>>>>> -    if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>> -                                  BIT(MIG_MODE_CPR_TRANSFER) |
>>>>> -                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>> -        return;
>>>>> +    if (!proxy->id) {
>>>>> +        error_setg(&vsock->migration_blocker,
>>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>>> +            return;
>>>>> +        }
>>>>>     }
>>>>>
>>>>> -    if (cpr_is_incoming()) {
>>>>> +    /*
>>>>> +     * Re-acquire ownership if a CPR migration releases it (in
>>>>> pre_save) but
>>>>> +     * then fails.
>>>>> +     */
>>>>> +    migration_add_notifier_modes(&vsock->cpr_notifier,
>>>>> +                                 vhost_vsock_cpr_notifier,
>>>>> +                                 BIT(MIG_MODE_CPR_TRANSFER) |
>>>>> +                                 BIT(MIG_MODE_CPR_EXEC));
>>>>> +
>>>>> +    if (cpr_incoming) {
>>>>>         /* Reuse the fd handed over from the source QEMU. */
>>>>>         if (!proxy->id) {
>>>>>             error_setg(errp, "vhost-vsock: device ID is required for "
>>>>> @@ -204,14 +315,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>>
>>>>>     vhost_vsock_common_realize(vdev);
>>>>>
>>>>> -    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>>> -                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>>>> -    if (ret < 0) {
>>>>> +    if (!cpr_incoming) {
>>>>> +        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
>>>>> +                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
>>>>> +        if (ret < 0) {
>>>>> +            /*
>>>>> +             * vhostfd is closed by vhost_dev_cleanup, which is called
>>>>> +             * by vhost_dev_init on initialization error.
>>>>> +             */
>>>>> +            goto err_virtio;
>>>>> +        }
>>>>> +    } else {
>>>>>         /*
>>>>> -         * vhostfd is closed by vhost_dev_cleanup, which is called
>>>>> -         * by vhost_dev_init on initialization error.
>>>>> +         * CPR restore case: only learn the backend feature set now, but
>>>>> +         * defer taking ownership or touching VQs (the still-running source
>>>>> +         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
>>>>> +         * is done later in post_load.
>>>>>          */
>>>>> -        goto err_virtio;
>>>>> +        ret = vhost_dev_init_backend(&vvc->vhost_dev,
>>>>> +                                     (void *)(uintptr_t)vhostfd,
>>>>> +                                     VHOST_BACKEND_TYPE_KERNEL, errp);
>>>>> +        if (ret < 0) {
>>>>> +            /* vhost_dev_init_backend() does not close the fd on error */
>>>>
>>>> Okay, but IIUC this is returned by cpr_find_fd(), is that funtion
>>>> passing the ownership of the fd, even that the fd is not removed from
>>>> the hash table?
>>>>
>>>> Should we call cpr_delete_fd() when we take it?
>>>
>>> You're right, that should be a proper cleanup.  Every path that closes
>>> the fd after a successful cpr_find_fd() should also drop the entry.
>>> Will add this.
>>
>> I don't know how CPR works, but if we don't close the FD here, will it
>> be closed later? I mean, if we leave it on the map, will someone else
>> close it?
>
>CPR code doesn't close any FDs on its own.  Those FDs are owned by the
>devices and we only account them so that they stay opened and their
>numbers get transfered to the CPR target - that's it.  If the caller
>doesn't close them on a failed .realize(), they get leaked.  Or, if we
>close them but keep the entry in CPR registry - target gets a stale FD
>number.
>> That way, we don't have a different situation here.
>>
>> That said, I'm fine also with your solution.
>
>Yes, closing fds on the caller side still looks ultimately better.

Ack!

Thanks,
Stefano


