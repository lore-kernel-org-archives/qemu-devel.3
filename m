Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D8EC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twifO-0000mF-0K; Mon, 24 Mar 2025 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twifM-0000ll-4c
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twifG-0007Ch-Ul
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742826029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7a94kB+If0ZphfMYq3U19vtu/1bgvniqOv/sjZyD2rQ=;
 b=POVDJ63JMVIMj0cm+Ap2LYdtqlJdDZ2uW3WChSnbn2Ii8Avb439Yq6kbNOPRWhebG3vww8
 HEMhGsz3yE76DsUVSHZi3gueRIwxVxEqfswmvH1f6M0nhkURGp2Mymdh9BnwYgd4JCeVW+
 MEm1LemYRTFhHLy5QX9c0aUS5OEi0bc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-7emH_oKVOSmA4JnzpNvsSQ-1; Mon, 24 Mar 2025 10:20:26 -0400
X-MC-Unique: 7emH_oKVOSmA4JnzpNvsSQ-1
X-Mimecast-MFC-AGG-ID: 7emH_oKVOSmA4JnzpNvsSQ_1742826025
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so2341397f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742826022; x=1743430822;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7a94kB+If0ZphfMYq3U19vtu/1bgvniqOv/sjZyD2rQ=;
 b=e5IPCfk9GJ2iGvJiV5G46dZBHEYKyl95YzaPWvOhZ+uYQivl5H8mkHX5pVma4H8aAj
 lW4WKPrestwY/zI9o4mYWVlW+vI/kX/ntfA7tu8rY+eVdtZH62ILM3GLgnnzk/4zAf4p
 3Qz1Byi4JRDRXpsq5Sdq1pPZemR/SAaw97C9gnUzVpBXx3rnSODucaKjgNqvCjdLO/kL
 YTzXqnThSAw3y0EXMZhq4DotsA8PqTDEJYFyW8jJDy/3Zk+knjYfD9DF4eWV9ZTWTWOM
 OXVJYUH45RbTwm+uw2jU9CDnnDahTdVO0uvnGinrxfEb8gdmySe73okgmfygRAc+tqlO
 hhjw==
X-Gm-Message-State: AOJu0YwxHgJj0lCU03Izr2LNoKCunlujjXikkt17X52yj6PdHkSXNW5T
 APHhcqXpfifnhUF6XMDV0nX1GQyRGvNKOU3ZVNbIYoTE2qLXBRePiJOjqpt+Z6jWi8MnuLgcQ2Z
 wJx2XWuDu2+5ptCi/p2dK3phzWf7aO/kQTMQwKhGUgnhjUNxQcs/O
X-Gm-Gg: ASbGncuTMNjpqI3m+ZJrmp7G7ncWABtm7hdk2dyMuPr0na02aCSneOF5TW5Grutz5Mn
 AqueSkINRetdCuTnS/7AP62HSZg4aPtAJ9rPbUmNifW4kPDhtfqOsWzqj4GCxkxR3vWOlZpRZ8Q
 QkAimMc09VpyX9NGr3iWf/zi5OdxaDCVomh4iCNTxDCl6wG4N1P5XvwgGY+QAXAGzPZXAchqCC4
 I8MrszfIh3B1hSOP5m7cKASDTE4qBR4lGGMGFE5EYdn4lU7IiNJVQcJXAtiI0td3etjhjyqaOtW
 eM/k6sZF5RgUbcBrMjK6+eDW/KPjmjJUz/MKYaIWMzb6xCRv4p06T9EHWiNwqJId
X-Received: by 2002:a05:6000:2cd:b0:391:412b:e22b with SMTP id
 ffacd0b85a97d-3997f903a95mr11584895f8f.18.1742826021711; 
 Mon, 24 Mar 2025 07:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKEycCHTUsXu44UAXw4NcPgr1ikPc+oM9+ZP7BXIqWyWa9l4mjYTND82K7nlVSy1E9fl/HyA==
X-Received: by 2002:a05:6000:2cd:b0:391:412b:e22b with SMTP id
 ffacd0b85a97d-3997f903a95mr11584826f8f.18.1742826020843; 
 Mon, 24 Mar 2025 07:20:20 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it.
 [87.12.25.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9ec29sm121287475e9.30.2025.03.24.07.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:20:20 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:20:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/3] virtio: add VM state change cb with return value
Message-ID: <ar7uvjzyjfxje5u5gzslgsbkcwrzkkfq5lsdieo7lfhjx2oc2h@4tbovkdmj4eg>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-2-haoqian.he@smartx.com>
 <2t3b6ckqr5wrfl7neutvazjegafl4la4cifndbh3hefyqc7crs@yhlsmtkzytqg>
 <110C78D2-6B93-412C-9CC7-418AE18D3966@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <110C78D2-6B93-412C-9CC7-418AE18D3966@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 20, 2025 at 08:21:18PM +0800, Haoqian He wrote:
>
>> 2025年3月19日 22:50，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>
>> On Fri, Mar 14, 2025 at 06:15:32AM -0400, Haoqian He wrote:
>>> This patch contains two changes:
>>>
>>> 1. Add VM state change cb type VMChangeStateHandlerExt which has return
>>> value for virtio devices VMChangeStateEntry. When VM state changes,
>>> virtio device will call the _Ext version.
>>>
>>> 2. Add return value for vm_state_notify().
>>
>> Can you explain why these changes are needed?
>
>[1] The first and second patches are both pre-patch of the third patch, and the reason
>for these changes is in the email cover and the third patch commit message.
>I will briefly explain it in the commit message of the pre-patch.

Yes, please, it's not so much for me, but for the future, a good commit 
message should explain the reason for the changes.

>
>>
>>>
>>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>>> ---
>>> hw/block/virtio-blk.c             |  2 +-
>>> hw/core/vm-change-state-handler.c | 14 ++++++++------
>>> hw/scsi/scsi-bus.c                |  2 +-
>>> hw/vfio/migration.c               |  2 +-
>>> hw/virtio/virtio.c                |  5 +++--
>>> include/system/runstate.h         | 11 ++++++++---
>>> system/cpus.c                     |  4 ++--
>>> system/runstate.c                 | 25 ++++++++++++++++++++-----
>>> 8 files changed, 44 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>> index 5135b4d8f1..4a48a16790 100644
>>> --- a/hw/block/virtio-blk.c
>>> +++ b/hw/block/virtio-blk.c
>>> @@ -1928,7 +1928,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>>>     * called after ->start_ioeventfd() has already set blk's AioContext.
>>>     */
>>>    s->change =
>>> -        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
>>> +        qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, NULL, s);
>>>
>>>    blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
>>>    blk_set_dev_ops(s->blk, &virtio_block_ops, s);
>>> diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
>>> index 7064995578..d5045b17c1 100644
>>> --- a/hw/core/vm-change-state-handler.c
>>> +++ b/hw/core/vm-change-state-handler.c
>>> @@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
>>> * qdev_add_vm_change_state_handler:
>>> * @dev: the device that owns this handler
>>> * @cb: the callback function to be invoked
>>> + * @cb_ext: the callback function with return value to be invoked
>>
>> I think we need to document what happens if both `cb` and `cb_ext` are specified.
>
>Indeed, it's best if `cb` and `cb_ext` are mutually exclusive, what about adding an
>assert to ensure this.

Yep, documenation + assert should be fine.

>
>> Also `cb_ext` is very cryptic, I'm not good with names, but what about something like `cb_ret`?
>
>Acked.
>
>>
>>> * @opaque: user data passed to the callback function
>>> *
>>> * This function works like qemu_add_vm_change_state_handler() except callbacks
>>> @@ -54,21 +55,22 @@ static int qdev_get_dev_tree_depth(DeviceState *dev)
>>> */
>>> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>>>                                                     VMChangeStateHandler *cb,
>>> +                                                     VMChangeStateHandlerExt *cb_ext,
>>>                                                     void *opaque)
>>> {
>>> -    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, opaque);
>>> +    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, cb_ext, opaque);
>>> }
>>>
>>> /*
>>> * Exactly like qdev_add_vm_change_state_handler() but passes a prepare_cb
>>> - * argument too.
>>> + * and the cb_ext arguments too.
>>> */
>>> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>>> -    DeviceState *dev, VMChangeStateHandler *cb,
>>> -    VMChangeStateHandler *prepare_cb, void *opaque)
>>> +    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
>>> +    VMChangeStateHandlerExt *cb_ext, void *opaque)
>>
>>> {
>>>    int depth = qdev_get_dev_tree_depth(dev);
>>>
>>> -    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, opaque,
>>> -                                                      depth);
>>> +    return qemu_add_vm_change_state_handler_prio_full(cb, prepare_cb, cb_ext,
>>> +                                                      opaque, depth);
>>> }
>>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>>> index 7d4546800f..ec098f5f0a 100644
>>> --- a/hw/scsi/scsi-bus.c
>>> +++ b/hw/scsi/scsi-bus.c
>>> @@ -356,7 +356,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
>>>        return;
>>>    }
>>>    dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
>>> -            scsi_dma_restart_cb, dev);
>>> +            scsi_dma_restart_cb, NULL, dev);
>>> }
>>>
>>> static void scsi_qdev_unrealize(DeviceState *qdev)
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 416643ddd6..f531db83ea 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -1015,7 +1015,7 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>>>                     vfio_vmstate_change_prepare :
>>>                     NULL;
>>>    migration->vm_state = qdev_add_vm_change_state_handler_full(
>>> -        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
>>> +        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, vbasedev);
>>>    migration_add_notifier(&migration->migration_state,
>>>                           vfio_migration_state_notifier);
>>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 85110bce37..5e8d4cab53 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -3419,7 +3419,7 @@ void virtio_cleanup(VirtIODevice *vdev)
>>>    qemu_del_vm_change_state_handler(vdev->vmstate);
>>> }
>>>
>>> -static void virtio_vmstate_change(void *opaque, bool running, RunState state)
>>> +static int virtio_vmstate_change(void *opaque, bool running, RunState state)
>>> {
>>>    VirtIODevice *vdev = opaque;
>>>    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>>> @@ -3438,6 +3438,7 @@ static void virtio_vmstate_change(void *opaque, bool running, RunState state)
>>>    if (!backend_run) {
>>>        virtio_set_status(vdev, vdev->status);
>>>    }
>>> +    return 0;
>>> }
>>>
>>> void virtio_instance_init_common(Object *proxy_obj, void *data,
>>> @@ -3489,7 +3490,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
>>>        vdev->config = NULL;
>>>    }
>>>    vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
>>> -            virtio_vmstate_change, vdev);
>>> +            NULL, virtio_vmstate_change, vdev);
>>
>> IIUC virtio_vmstate_change now returns always 0, so what is the point of
>> this change?
>>
>> I'd also do this change in a separate commit if it's really needed.
>
>According to [1], the pre-patch just adds a return value for vm_state_notify,
>and the next patches returns an error in the virtio and vhost-user code.

Why not changing this in the next patch where it can return an error?

>
>>
>>>    vdev->device_endian = virtio_default_endian();
>>>    vdev->use_guest_notifier_mask = true;
>>> }
>>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>>> index bffc3719d4..af33ea92b6 100644
>>> --- a/include/system/runstate.h
>>> +++ b/include/system/runstate.h
>>> @@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
>>> void runstate_replay_enable(void);
>>>
>>> typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>>> +typedef int VMChangeStateHandlerExt(void *opaque, bool running, RunState state);
>>
>> Ditto about "Ext"
>>
>>>
>>> VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>>>                                                     void *opaque);
>>> @@ -20,21 +21,25 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>> VMChangeStateEntry *
>>> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>>                                           VMChangeStateHandler *prepare_cb,
>>> +                                           VMChangeStateHandlerExt *cb_ext,
>>>                                           void *opaque, int priority);
>>> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState *dev,
>>>                                                     VMChangeStateHandler *cb,
>>> +                                                     VMChangeStateHandlerExt *cb_ext,
>>>                                                     void *opaque);
>>> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>>> -    DeviceState *dev, VMChangeStateHandler *cb,
>>> -    VMChangeStateHandler *prepare_cb, void *opaque);
>>> +    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler *prepare_cb,
>>> +    VMChangeStateHandlerExt *cb_ext, void *opaque);
>>> void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>>> /**
>>> * vm_state_notify: Notify the state of the VM
>>> *
>>> * @running: whether the VM is running or not.
>>> * @state: the #RunState of the VM.
>>> + *
>>> + * Return the result of the callback which has return value.
>>
>> What if the callback has no return value?
>
>vm_state_notify must have a return value. If all cb have no return value, it
>will return 0 and the upper layer will do no additional processing as before.

Please, add that to the documentation.

>
>>
>>> */
>>> -void vm_state_notify(bool running, RunState state);
>>> +int vm_state_notify(bool running, RunState state);
>>>
>>> static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>> {
>>> diff --git a/system/cpus.c b/system/cpus.c
>>> index 2cc5f887ab..6e1cf5720f 100644
>>> --- a/system/cpus.c
>>> +++ b/system/cpus.c
>>> @@ -299,14 +299,14 @@ static int do_vm_stop(RunState state, bool send_stop)
>>>        if (oldstate == RUN_STATE_RUNNING) {
>>>            pause_all_vcpus();
>>>        }
>>> -        vm_state_notify(0, state);
>>> +        ret = vm_state_notify(0, state);
>>>        if (send_stop) {
>>>            qapi_event_send_stop();
>>>        }
>>>    }
>>>
>>>    bdrv_drain_all();
>>> -    ret = bdrv_flush_all();
>>> +    ret |= bdrv_flush_all();
>>
>> Are we sure this is the right thing to do?
>> If vm_state_notify() failed, shouldn't we go out first, and then why put them in or?
>>
>> I think it should be explained in the commit or in a comment here.
>
>Even if vm_state_notify() failed, it might be better to flush as 
>before.

Got it, please add a comment.

>
>>
>>>    trace_vm_stop_flush_all(ret);
>>>
>>>    return ret;
>>> diff --git a/system/runstate.c b/system/runstate.c
>>> index 272801d307..2219cec409 100644
>>> --- a/system/runstate.c
>>> +++ b/system/runstate.c
>>> @@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
>>> struct VMChangeStateEntry {
>>>    VMChangeStateHandler *cb;
>>>    VMChangeStateHandler *prepare_cb;
>>> +    VMChangeStateHandlerExt *cb_ext;
>>>    void *opaque;
>>>    QTAILQ_ENTRY(VMChangeStateEntry) entries;
>>>    int priority;
>>> @@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) vm_change_state_head =
>>> VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>>        VMChangeStateHandler *cb, void *opaque, int priority)
>>> {
>>> -    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, opaque,
>>> -                                                      priority);
>>> +    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, NULL,
>>> +                                                      opaque, priority);
>>> }
>>>
>>> /**
>>> * qemu_add_vm_change_state_handler_prio_full:
>>> * @cb: the main callback to invoke
>>> * @prepare_cb: a callback to invoke before the main callback
>>> + * @cb_ext: the main callback to invoke with return value
>>> * @opaque: user data passed to the callbacks
>>> * @priority: low priorities execute first when the vm runs and the reverse is
>>> *            true when the vm stops
>>> @@ -344,6 +346,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>> VMChangeStateEntry *
>>> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>>                                           VMChangeStateHandler *prepare_cb,
>>> +                                           VMChangeStateHandlerExt *cb_ext,
>>>                                           void *opaque, int priority)
>>> {
>>>    VMChangeStateEntry *e;
>>> @@ -352,6 +355,7 @@ qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>>    e = g_malloc0(sizeof(*e));
>>>    e->cb = cb;
>>>    e->prepare_cb = prepare_cb;
>>> +    e->cb_ext = cb_ext;
>>>    e->opaque = opaque;
>>>    e->priority = priority;
>>>
>>> @@ -379,9 +383,10 @@ void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
>>>    g_free(e);
>>> }
>>>
>>> -void vm_state_notify(bool running, RunState state)
>>> +int vm_state_notify(bool running, RunState state)
>>> {
>>>    VMChangeStateEntry *e, *next;
>>> +    int ret = 0;
>>>
>>>    trace_vm_state_notify(running, state, RunState_str(state));
>>>
>>> @@ -393,7 +398,12 @@ void vm_state_notify(bool running, RunState state)
>>>        }
>>>
>>>        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>>> -            e->cb(e->opaque, running, state);
>>> +            if (e->cb) {
>>> +                e->cb(e->opaque, running, state);
>>> +            } else if (e->cb_ext) {
>>> +                // no need to process the result when starting VM
>>
>> Why?
>>
>> (a good comment should explain more why than what we're doing which is pretty clear)
>
>Acked.
>Since we only want to know the return value of callback when the stopping device
>live migration.
>
>>
>>> +                e->cb_ext(e->opaque, running, state);
>>> +            }
>>>        }
>>>    } else {
>>>        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>>> @@ -403,9 +413,14 @@ void vm_state_notify(bool running, RunState state)
>>>        }
>>>
>>>        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, next) {
>>> -            e->cb(e->opaque, running, state);
>>> +            if (e->cb) {
>>> +                e->cb(e->opaque, running, state);
>>> +            } else if (e->cb_ext) {
>>> +                ret |= e->cb_ext(e->opaque, running, state);
>>
>> I think putting them in or should be documented or at least explained somewhere. It's not clear to me, but it's true that I don't know this code.
>
>Let's add some comment here.

Yep!

Thanks,
Stefano

>
>>
>>> +            }
>>>        }
>>>    }
>>> +    return ret;
>>> }
>>>
>>> static ShutdownCause reset_requested;
>>> --
>>> 2.48.1
>
>


