Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F22C36002
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEuV-0003E1-D5; Thu, 20 Mar 2025 08:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEuA-0003AW-7B
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEu3-00060e-0h
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:44 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22548a28d0cso16197785ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742473296; x=1743078096;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvrgSKgMB8t25gMTcOAabVwE42jA9M3c7tM5DyvFIfM=;
 b=2uSl18mJ1jWOyDT2AlPRDgPC9V8wRVoRjHw9sB3QLdp8q1c/VDqiabi+5o6DMLUwfB
 BAIikww8M8NHQ91o8oSq3lrZ6nF5ZN+wvnwpqAE1HLxc0kegzMU0WU3GsXyEXUaG4qXU
 J1PZfh6JSZcUDyjMZD0e0ExkNcBDmQ+GEDEfzfLnrat9G1kS0q6y/CdjKlTSbgRv5IB3
 vhbki/Sf5S0+pAPkqJqZwr9dFLfMwbohJnNkZr0f5m5XS0lHtdQP90Nlgx/aZJ+MLwED
 9o/smN4t3Ocu9dH4brSFlft0FYjB/wlR+VSzs4ZTeo3pWK1pRCKkCLGS+Rj+v6ohuyFK
 mTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742473296; x=1743078096;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvrgSKgMB8t25gMTcOAabVwE42jA9M3c7tM5DyvFIfM=;
 b=wwKMKzUIwzCMyLW+5QWnFBJ+l/QwLPvfF9WwTkuUBpjGSdvDGsYFmgU4j5jlLs2mVD
 ovSiIylmIP0/CrbCBczVHV6X+rVR3vZFQw95ebMtglOeVCJ7MMbovdeyYA8vvhAqWSor
 snfyM5iCfZKrqBAcp0LCDe8fOnxyxfPN+NF08ZelN+4YjxcL8C3zgxTplAdB7+dzjY8F
 nUMO98Q1OlnYlojnsayQMHr0K8UTtQCRYoc4KIkRwYoSMDqhCn+VX3EZG0BDT3swm4Pv
 DT+xyclrTtWIrgmPec8zrOfGru2zPaGCp7/r++1PZ7fj73iethPnLJSfW76Kam2TusoP
 Oi1A==
X-Gm-Message-State: AOJu0YxIt6kJbpIxNIfLTJEANkVK5Ojd3kmhkWv/IS6Iab8mJdXQnNhS
 VIlq7dFugMxu+KNbM4b3ovJiB8RLoGo36Otn3QBtAZ3P3YIi7ygtoe4lgEcmaRM=
X-Gm-Gg: ASbGncsAgf3LR1I1SHWDR0cojjwswcVIltRAk0QHqGsMHQDSZ0htxQ7UpGzqOSecrBO
 CNs1/QLiR/Cd7g5ahWL7ggAYe41urBwcZcupKYQoQhmwxt6/QIgky8aVi/hQtoIEFPkWFCxfcu4
 EQSDzYqv2SufVSkjApd2MDq0ri/X++OXhG1oO8bw90hhdWjDs9nncMLBQX+8Ce2arBDXs88X3yG
 YMrm1DRBBmlCVg6FNwfRP+0FqPnRDtuRhyJpIshvcVIsJ89UYi88tTExMwbQNLiD1USqO9hzDzy
 2mma1HqSpbUSsW5Tc9xEgiBbLcdviQBLup8LSicFQYEkcIf8hgxXM2YDTLIPPt//86WfITWKOXu
 pDRqNgBVkgPcDkQn73MAF3IB41TPU75yzjRn+7n9zI7fA3ok=
X-Google-Smtp-Source: AGHT+IHy9wvPoln4arfZwDCUCBNnH4obJiMmhB37qmR3C9lZVAtdE5HpeUz85WbUnz0AvRUFpDMgkg==
X-Received: by 2002:a05:6a20:914b:b0:1f5:8eb1:d5d2 with SMTP id
 adf61e73a8af0-1fd117fd115mr5248704637.13.1742473295515; 
 Thu, 20 Mar 2025 05:21:35 -0700 (PDT)
Received: from smtpclient.apple (awork062100.netvigator.com. [203.198.28.100])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b1fsm13518702b3a.127.2025.03.20.05.21.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 05:21:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 1/3] virtio: add VM state change cb with return value
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <2t3b6ckqr5wrfl7neutvazjegafl4la4cifndbh3hefyqc7crs@yhlsmtkzytqg>
Date: Thu, 20 Mar 2025 20:21:18 +0800
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <110C78D2-6B93-412C-9CC7-418AE18D3966@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-2-haoqian.he@smartx.com>
 <2t3b6ckqr5wrfl7neutvazjegafl4la4cifndbh3hefyqc7crs@yhlsmtkzytqg>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 22:50=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Mar 14, 2025 at 06:15:32AM -0400, Haoqian He wrote:
>> This patch contains two changes:
>>=20
>> 1. Add VM state change cb type VMChangeStateHandlerExt which has =
return
>> value for virtio devices VMChangeStateEntry. When VM state changes,
>> virtio device will call the _Ext version.
>>=20
>> 2. Add return value for vm_state_notify().
>=20
> Can you explain why these changes are needed?

[1] The first and second patches are both pre-patch of the third patch, =
and the reason
for these changes is in the email cover and the third patch commit =
message.
I will briefly explain it in the commit message of the pre-patch.

>=20
>>=20
>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>> ---
>> hw/block/virtio-blk.c             |  2 +-
>> hw/core/vm-change-state-handler.c | 14 ++++++++------
>> hw/scsi/scsi-bus.c                |  2 +-
>> hw/vfio/migration.c               |  2 +-
>> hw/virtio/virtio.c                |  5 +++--
>> include/system/runstate.h         | 11 ++++++++---
>> system/cpus.c                     |  4 ++--
>> system/runstate.c                 | 25 ++++++++++++++++++++-----
>> 8 files changed, 44 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 5135b4d8f1..4a48a16790 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -1928,7 +1928,7 @@ static void =
virtio_blk_device_realize(DeviceState *dev, Error **errp)
>>     * called after ->start_ioeventfd() has already set blk's =
AioContext.
>>     */
>>    s->change =3D
>> -        qdev_add_vm_change_state_handler(dev, =
virtio_blk_dma_restart_cb, s);
>> +        qdev_add_vm_change_state_handler(dev, =
virtio_blk_dma_restart_cb, NULL, s);
>>=20
>>    blk_ram_registrar_init(&s->blk_ram_registrar, s->blk);
>>    blk_set_dev_ops(s->blk, &virtio_block_ops, s);
>> diff --git a/hw/core/vm-change-state-handler.c =
b/hw/core/vm-change-state-handler.c
>> index 7064995578..d5045b17c1 100644
>> --- a/hw/core/vm-change-state-handler.c
>> +++ b/hw/core/vm-change-state-handler.c
>> @@ -40,6 +40,7 @@ static int qdev_get_dev_tree_depth(DeviceState =
*dev)
>> * qdev_add_vm_change_state_handler:
>> * @dev: the device that owns this handler
>> * @cb: the callback function to be invoked
>> + * @cb_ext: the callback function with return value to be invoked
>=20
> I think we need to document what happens if both `cb` and `cb_ext` are =
specified.

Indeed, it's best if `cb` and `cb_ext` are mutually exclusive, what =
about adding an
assert to ensure this.

> Also `cb_ext` is very cryptic, I'm not good with names, but what about =
something like `cb_ret`?

Acked.

>=20
>> * @opaque: user data passed to the callback function
>> *
>> * This function works like qemu_add_vm_change_state_handler() except =
callbacks
>> @@ -54,21 +55,22 @@ static int qdev_get_dev_tree_depth(DeviceState =
*dev)
>> */
>> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState =
*dev,
>>                                                     =
VMChangeStateHandler *cb,
>> +                                                     =
VMChangeStateHandlerExt *cb_ext,
>>                                                     void *opaque)
>> {
>> -    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, =
opaque);
>> +    return qdev_add_vm_change_state_handler_full(dev, cb, NULL, =
cb_ext, opaque);
>> }
>>=20
>> /*
>> * Exactly like qdev_add_vm_change_state_handler() but passes a =
prepare_cb
>> - * argument too.
>> + * and the cb_ext arguments too.
>> */
>> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>> -    DeviceState *dev, VMChangeStateHandler *cb,
>> -    VMChangeStateHandler *prepare_cb, void *opaque)
>> +    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler =
*prepare_cb,
>> +    VMChangeStateHandlerExt *cb_ext, void *opaque)
>=20
>> {
>>    int depth =3D qdev_get_dev_tree_depth(dev);
>>=20
>> -    return qemu_add_vm_change_state_handler_prio_full(cb, =
prepare_cb, opaque,
>> -                                                      depth);
>> +    return qemu_add_vm_change_state_handler_prio_full(cb, =
prepare_cb, cb_ext,
>> +                                                      opaque, =
depth);
>> }
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index 7d4546800f..ec098f5f0a 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -356,7 +356,7 @@ static void scsi_qdev_realize(DeviceState *qdev, =
Error **errp)
>>        return;
>>    }
>>    dev->vmsentry =3D qdev_add_vm_change_state_handler(DEVICE(dev),
>> -            scsi_dma_restart_cb, dev);
>> +            scsi_dma_restart_cb, NULL, dev);
>> }
>>=20
>> static void scsi_qdev_unrealize(DeviceState *qdev)
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 416643ddd6..f531db83ea 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1015,7 +1015,7 @@ static int vfio_migration_init(VFIODevice =
*vbasedev)
>>                     vfio_vmstate_change_prepare :
>>                     NULL;
>>    migration->vm_state =3D qdev_add_vm_change_state_handler_full(
>> -        vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
>> +        vbasedev->dev, vfio_vmstate_change, prepare_cb, NULL, =
vbasedev);
>>    migration_add_notifier(&migration->migration_state,
>>                           vfio_migration_state_notifier);
>>=20
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce37..5e8d4cab53 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3419,7 +3419,7 @@ void virtio_cleanup(VirtIODevice *vdev)
>>    qemu_del_vm_change_state_handler(vdev->vmstate);
>> }
>>=20
>> -static void virtio_vmstate_change(void *opaque, bool running, =
RunState state)
>> +static int virtio_vmstate_change(void *opaque, bool running, =
RunState state)
>> {
>>    VirtIODevice *vdev =3D opaque;
>>    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
>> @@ -3438,6 +3438,7 @@ static void virtio_vmstate_change(void *opaque, =
bool running, RunState state)
>>    if (!backend_run) {
>>        virtio_set_status(vdev, vdev->status);
>>    }
>> +    return 0;
>> }
>>=20
>> void virtio_instance_init_common(Object *proxy_obj, void *data,
>> @@ -3489,7 +3490,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t =
device_id, size_t config_size)
>>        vdev->config =3D NULL;
>>    }
>>    vdev->vmstate =3D qdev_add_vm_change_state_handler(DEVICE(vdev),
>> -            virtio_vmstate_change, vdev);
>> +            NULL, virtio_vmstate_change, vdev);
>=20
> IIUC virtio_vmstate_change now returns always 0, so what is the point =
of
> this change?
>=20
> I'd also do this change in a separate commit if it's really needed.

According to [1], the pre-patch just adds a return value for =
vm_state_notify,
and the next patches returns an error in the virtio and vhost-user code.

>=20
>>    vdev->device_endian =3D virtio_default_endian();
>>    vdev->use_guest_notifier_mask =3D true;
>> }
>> diff --git a/include/system/runstate.h b/include/system/runstate.h
>> index bffc3719d4..af33ea92b6 100644
>> --- a/include/system/runstate.h
>> +++ b/include/system/runstate.h
>> @@ -12,6 +12,7 @@ bool runstate_needs_reset(void);
>> void runstate_replay_enable(void);
>>=20
>> typedef void VMChangeStateHandler(void *opaque, bool running, =
RunState state);
>> +typedef int VMChangeStateHandlerExt(void *opaque, bool running, =
RunState state);
>=20
> Ditto about "Ext"
>=20
>>=20
>> VMChangeStateEntry =
*qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
>>                                                     void *opaque);
>> @@ -20,21 +21,25 @@ VMChangeStateEntry =
*qemu_add_vm_change_state_handler_prio(
>> VMChangeStateEntry *
>> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>                                           VMChangeStateHandler =
*prepare_cb,
>> +                                           VMChangeStateHandlerExt =
*cb_ext,
>>                                           void *opaque, int =
priority);
>> VMChangeStateEntry *qdev_add_vm_change_state_handler(DeviceState =
*dev,
>>                                                     =
VMChangeStateHandler *cb,
>> +                                                     =
VMChangeStateHandlerExt *cb_ext,
>>                                                     void *opaque);
>> VMChangeStateEntry *qdev_add_vm_change_state_handler_full(
>> -    DeviceState *dev, VMChangeStateHandler *cb,
>> -    VMChangeStateHandler *prepare_cb, void *opaque);
>> +    DeviceState *dev, VMChangeStateHandler *cb, VMChangeStateHandler =
*prepare_cb,
>> +    VMChangeStateHandlerExt *cb_ext, void *opaque);
>> void qemu_del_vm_change_state_handler(VMChangeStateEntry *e);
>> /**
>> * vm_state_notify: Notify the state of the VM
>> *
>> * @running: whether the VM is running or not.
>> * @state: the #RunState of the VM.
>> + *
>> + * Return the result of the callback which has return value.
>=20
> What if the callback has no return value?

vm_state_notify must have a return value. If all cb have no return =
value, it
will return 0 and the upper layer will do no additional processing as =
before.

>=20
>> */
>> -void vm_state_notify(bool running, RunState state);
>> +int vm_state_notify(bool running, RunState state);
>>=20
>> static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>> {
>> diff --git a/system/cpus.c b/system/cpus.c
>> index 2cc5f887ab..6e1cf5720f 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -299,14 +299,14 @@ static int do_vm_stop(RunState state, bool =
send_stop)
>>        if (oldstate =3D=3D RUN_STATE_RUNNING) {
>>            pause_all_vcpus();
>>        }
>> -        vm_state_notify(0, state);
>> +        ret =3D vm_state_notify(0, state);
>>        if (send_stop) {
>>            qapi_event_send_stop();
>>        }
>>    }
>>=20
>>    bdrv_drain_all();
>> -    ret =3D bdrv_flush_all();
>> +    ret |=3D bdrv_flush_all();
>=20
> Are we sure this is the right thing to do?
> If vm_state_notify() failed, shouldn't we go out first, and then why =
put them in or?
>=20
> I think it should be explained in the commit or in a comment here.

Even if vm_state_notify() failed, it might be better to flush as before.

>=20
>>    trace_vm_stop_flush_all(ret);
>>=20
>>    return ret;
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 272801d307..2219cec409 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -297,6 +297,7 @@ void qemu_system_vmstop_request(RunState state)
>> struct VMChangeStateEntry {
>>    VMChangeStateHandler *cb;
>>    VMChangeStateHandler *prepare_cb;
>> +    VMChangeStateHandlerExt *cb_ext;
>>    void *opaque;
>>    QTAILQ_ENTRY(VMChangeStateEntry) entries;
>>    int priority;
>> @@ -320,14 +321,15 @@ static QTAILQ_HEAD(, VMChangeStateEntry) =
vm_change_state_head =3D
>> VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
>>        VMChangeStateHandler *cb, void *opaque, int priority)
>> {
>> -    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, =
opaque,
>> -                                                      priority);
>> +    return qemu_add_vm_change_state_handler_prio_full(cb, NULL, =
NULL,
>> +                                                      opaque, =
priority);
>> }
>>=20
>> /**
>> * qemu_add_vm_change_state_handler_prio_full:
>> * @cb: the main callback to invoke
>> * @prepare_cb: a callback to invoke before the main callback
>> + * @cb_ext: the main callback to invoke with return value
>> * @opaque: user data passed to the callbacks
>> * @priority: low priorities execute first when the vm runs and the =
reverse is
>> *            true when the vm stops
>> @@ -344,6 +346,7 @@ VMChangeStateEntry =
*qemu_add_vm_change_state_handler_prio(
>> VMChangeStateEntry *
>> qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>                                           VMChangeStateHandler =
*prepare_cb,
>> +                                           VMChangeStateHandlerExt =
*cb_ext,
>>                                           void *opaque, int priority)
>> {
>>    VMChangeStateEntry *e;
>> @@ -352,6 +355,7 @@ =
qemu_add_vm_change_state_handler_prio_full(VMChangeStateHandler *cb,
>>    e =3D g_malloc0(sizeof(*e));
>>    e->cb =3D cb;
>>    e->prepare_cb =3D prepare_cb;
>> +    e->cb_ext =3D cb_ext;
>>    e->opaque =3D opaque;
>>    e->priority =3D priority;
>>=20
>> @@ -379,9 +383,10 @@ void =
qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
>>    g_free(e);
>> }
>>=20
>> -void vm_state_notify(bool running, RunState state)
>> +int vm_state_notify(bool running, RunState state)
>> {
>>    VMChangeStateEntry *e, *next;
>> +    int ret =3D 0;
>>=20
>>    trace_vm_state_notify(running, state, RunState_str(state));
>>=20
>> @@ -393,7 +398,12 @@ void vm_state_notify(bool running, RunState =
state)
>>        }
>>=20
>>        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
>> -            e->cb(e->opaque, running, state);
>> +            if (e->cb) {
>> +                e->cb(e->opaque, running, state);
>> +            } else if (e->cb_ext) {
>> +                // no need to process the result when starting VM
>=20
> Why?
>=20
> (a good comment should explain more why than what we're doing which is =
pretty clear)

Acked.
Since we only want to know the return value of callback when the =
stopping device
live migration.

>=20
>> +                e->cb_ext(e->opaque, running, state);
>> +            }
>>        }
>>    } else {
>>        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, =
next) {
>> @@ -403,9 +413,14 @@ void vm_state_notify(bool running, RunState =
state)
>>        }
>>=20
>>        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, =
next) {
>> -            e->cb(e->opaque, running, state);
>> +            if (e->cb) {
>> +                e->cb(e->opaque, running, state);
>> +            } else if (e->cb_ext) {
>> +                ret |=3D e->cb_ext(e->opaque, running, state);
>=20
> I think putting them in or should be documented or at least explained =
somewhere. It's not clear to me, but it's true that I don't know this =
code.

Let's add some comment here.

>=20
>> +            }
>>        }
>>    }
>> +    return ret;
>> }
>>=20
>> static ShutdownCause reset_requested;
>> --=20
>> 2.48.1



