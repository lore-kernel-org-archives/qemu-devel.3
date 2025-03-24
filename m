Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B69C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiqY-0003yQ-8I; Mon, 24 Mar 2025 10:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twiq7-0003x9-J4
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1twiq4-0001Na-KU
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742826699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq+r86KLZp8tGHcXIr9jJjCvyKplRndtkIB5uf8b2tE=;
 b=PKZZNSK9m6z7D9oDI6kN5WTH5dLMfeMvG6PIMlMmZ4r6ZcduPj+Y1Ouk9s/WALdPZxKu7g
 fF9QlbWDIpGfj63aYmXbpuhvrwMI5dpj32+t2iRA407zXmYRheFgCxGYX28itPemNzOjk+
 tfp/vYCRogJIgKwb32Cw7egeLtNgO2g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-zbKqhv4MOFKQf2AFeQm-5Q-1; Mon, 24 Mar 2025 10:31:37 -0400
X-MC-Unique: zbKqhv4MOFKQf2AFeQm-5Q-1
X-Mimecast-MFC-AGG-ID: zbKqhv4MOFKQf2AFeQm-5Q_1742826696
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso30812885e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742826696; x=1743431496;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wq+r86KLZp8tGHcXIr9jJjCvyKplRndtkIB5uf8b2tE=;
 b=bGyT3aGSP5kh37282j+7naqGTgRxN+JCrdCu4gLYMI5IEo82TBYfUdhheULPtx2pxK
 BaGhsTyaJsaQudLIy8BWWO2oimkIOpC7STCuFfhR+w81eEdnb0TQnvIx7421zpqOYTVN
 c3HZW2Bbk3bkFZ3VsAAR4J4iaG73mIYtS2mwqWUK2wIwvONoUqdRIXne/dg8Eubos5o2
 7wmhIV+NS7gqcZIknX5PkCt8e7Cj7XLHh4I3Hj1V5RAC3LJ6UIMqGOkC4zJuqleR1Wj+
 Q4WjRqjwJRnJZlVYRF9eQCPunjjajARkIc1Ic5Tafganny8opC88IVuGmW4VlmoMOihx
 vPEQ==
X-Gm-Message-State: AOJu0Yxfm1yWqVDF7uaUEHNcmV4Osf++v68CeCTwx/9w7uJc/0hBiIrF
 kvcsfLf416ZWzL6vbYTndfXJ8rDKwbL/XevRut6QTI9GdNcZix4SXVUIpe6U4wdO5vQx/qgG88W
 EYim/FvUZPZfgAeYjmrgOvIQ13qK4h3DOTX4a2IoHdKqWS4k0io6Z
X-Gm-Gg: ASbGncuNhhcFFHSE98DvxCaaItKPIO+U7jlGxjy176DSw1ro9+fQzUJtAWpHc2TlWjy
 OvTd3LmXZyZ5zVWDTBZoFCpdOkSlNKlC0dj+CYYyWXNj6mTHGE3hBl3fhLDfOfLZYwqnk/3gcag
 dapZysVshHscgK2BPNZcMK9yPwy7+mfw53PBLXu5TJgH7v/ZDQCNsv+YBy4fgus9fosNBqWOJ+4
 PFUgcDNsMPYdR/NNoTZgp7w0FufdLlU5lwPOnfx/QICvVeuwA08vItaAIRPsB0QVYrkJoC9qQ/Y
 c6O9+xTTJPEPLH5+AttfHpKTY+45PwE1uAIBuUElJgplD0Geg7rg5BUakHFw0sad
X-Received: by 2002:a05:6000:21c3:b0:391:45e9:face with SMTP id
 ffacd0b85a97d-3997f94166bmr7715953f8f.54.1742826696055; 
 Mon, 24 Mar 2025 07:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1lhEdyIa7sb3gPEbP+25k0AqBso1K8NvOtAp4xwOwzNOwp0dROAFhWkEAwhswGX4L7Q+f/Q==
X-Received: by 2002:a05:6000:21c3:b0:391:45e9:face with SMTP id
 ffacd0b85a97d-3997f94166bmr7715903f8f.54.1742826695329; 
 Mon, 24 Mar 2025 07:31:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-55.business.telecomitalia.it.
 [87.12.25.55]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55c3dsm173641835e9.23.2025.03.24.07.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:31:34 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:31:30 +0100
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
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
Message-ID: <scj244d5eifrvxe7qgz4aszeg7wbjxzhh6tdccuzxkj5k3jxvi@ujonxzfmd3tb>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
 <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 20, 2025 at 08:21:30PM +0800, Haoqian He wrote:
>
>
>> 2025年3月19日 23:20，Stefano Garzarella <sgarzare@redhat.com> 写道：
>>
>> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>>> Live migration should be terminated if the backend crashes before
>>> the migration completes.
>>>
>>> Since the vhost device will be stopped when VM is stopped before
>>> the end of the live migration, current implementation if vhost
>>> backend died, vhost device's set_status() will not return failure,
>>> live migration won't perceive the disconnection between qemu and
>>> vhost backend, inflight io would be submitted in migration target
>>> host, leading to IO error.
>>>
>>> To fix this issue:
>>> 1. Add set_status_ext() which has return value for
>>> VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.
>>>
>>> 2. In set_status_ext(), return failure if the flag `connected`
>>> is false or vhost_dev_stop return failure, which means qemu lost
>>> connection with backend.
>>>
>>> Hence migration_completion() will process failure, terminate
>>> migration and restore VM.
>>>
>>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>>> ---
>>> hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
>>> hw/scsi/vhost-scsi-common.c           | 13 ++++++------
>>> hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
>>> hw/virtio/virtio.c                    | 20 +++++++++++++-----
>>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>>> include/hw/virtio/virtio.h            |  1 +
>>> 6 files changed, 52 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>>> index ae42327cf8..4865786c54 100644
>>> --- a/hw/block/vhost-user-blk.c
>>> +++ b/hw/block/vhost-user-blk.c
>>> @@ -204,7 +204,7 @@ err_host_notifiers:
>>>    return ret;
>>> }
>>>
>>> -static void vhost_user_blk_stop(VirtIODevice *vdev)
>>> +static int vhost_user_blk_stop(VirtIODevice *vdev)
>>> {
>>>    VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>>    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>>> @@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>>>    int ret;
>>>
>>>    if (!s->started_vu) {
>>> -        return;
>>> +        return 0;
>>>    }
>>>    s->started_vu = false;
>>>
>>>    if (!k->set_guest_notifiers) {
>>> -        return;
>>> +        return 0;
>>>    }
>>>
>>> -    vhost_dev_stop(&s->dev, vdev, true);
>>> +    ret = vhost_dev_stop(&s->dev, vdev, true);
>>>
>>> -    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>>> -    if (ret < 0) {
>>> +    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>>>        error_report("vhost guest notifier cleanup failed: %d", ret);
>>> -        return;
>>> +        return -1;
>>>    }
>>>
>>>    vhost_dev_disable_notifiers(&s->dev, vdev);
>>> +    return ret;
>>> }
>>>
>>> -static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>> +static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>> {
>>>    VHostUserBlk *s = VHOST_USER_BLK(vdev);
>>>    bool should_start = virtio_device_should_start(vdev, status);
>>> @@ -239,11 +239,11 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>>    int ret;
>>>
>>>    if (!s->connected) {
>>> -        return;
>>> +        return -1;
>>>    }
>>>
>>>    if (vhost_dev_is_started(&s->dev) == should_start) {
>>> -        return;
>>> +        return 0;
>>>    }
>>>
>>>    if (should_start) {
>>> @@ -253,9 +253,12 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>>            qemu_chr_fe_disconnect(&s->chardev);
>>>        }
>>>    } else {
>>> -        vhost_user_blk_stop(vdev);
>>> +        ret = vhost_user_blk_stop(vdev);
>>> +        if (ret < 0) {
>>> +            return ret;
>>> +        }
>>>    }
>>> -
>>> +    return 0;
>>> }
>>>
>>> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>>> @@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
>>>    vdc->get_config = vhost_user_blk_update_config;
>>>    vdc->set_config = vhost_user_blk_set_config;
>>>    vdc->get_features = vhost_user_blk_get_features;
>>> -    vdc->set_status = vhost_user_blk_set_status;
>>> +    vdc->set_status_ext = vhost_user_blk_set_status;
>>>    vdc->reset = vhost_user_blk_reset;
>>>    vdc->get_vhost = vhost_user_blk_get_vhost;
>>> }
>>> diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
>>> index 4c8637045d..43525ba46d 100644
>>> --- a/hw/scsi/vhost-scsi-common.c
>>> +++ b/hw/scsi/vhost-scsi-common.c
>>> @@ -101,24 +101,25 @@ err_host_notifiers:
>>>    return ret;
>>> }
>>>
>>> -void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>>> +int vhost_scsi_common_stop(VHostSCSICommon *vsc)
>>> {
>>>    VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
>>>    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>>>    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>>>    int ret = 0;
>>>
>>> -    vhost_dev_stop(&vsc->dev, vdev, true);
>>> +    ret = vhost_dev_stop(&vsc->dev, vdev, true);
>>>
>>>    if (k->set_guest_notifiers) {
>>> -        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>>> -        if (ret < 0) {
>>> -                error_report("vhost guest notifier cleanup failed: %d", ret);
>>> +        int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>>> +        if (r < 0) {
>>> +            error_report("vhost guest notifier cleanup failed: %d", ret);
>>
>> The variable `ret` in the error_report() seems wrong.
>
>Ohh, thanks, I will fix it later.
>
>>
>>> +            return r;
>>>        }
>>>    }
>>> -    assert(ret >= 0);
>>>
>>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>>> +    return ret;
>>> }
>>>
>>> uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
>>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>>> index adb41b9816..8e7efc38f2 100644
>>> --- a/hw/scsi/vhost-user-scsi.c
>>> +++ b/hw/scsi/vhost-user-scsi.c
>>> @@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>>>    return ret;
>>> }
>>>
>>> -static void vhost_user_scsi_stop(VHostUserSCSI *s)
>>> +static int vhost_user_scsi_stop(VHostUserSCSI *s)
>>> {
>>>    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>>>
>>>    if (!s->started_vu) {
>>> -        return;
>>> +        return 0;
>>>    }
>>>    s->started_vu = false;
>>>
>>> -    vhost_scsi_common_stop(vsc);
>>> +    return vhost_scsi_common_stop(vsc);
>>> }
>>>
>>> -static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>> +static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>> {
>>>    VHostUserSCSI *s = (VHostUserSCSI *)vdev;
>>>    DeviceState *dev = DEVICE(vdev);
>>> @@ -75,11 +75,11 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>>    int ret;
>>>
>>>    if (!s->connected) {
>>> -        return;
>>> +        return -1;
>>>    }
>>>
>>>    if (vhost_dev_is_started(&vsc->dev) == should_start) {
>>> -        return;
>>> +        return 0;
>>>    }
>>>
>>>    if (should_start) {
>>> @@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>>            qemu_chr_fe_disconnect(&vs->conf.chardev);
>>>        }
>>>    } else {
>>> -        vhost_user_scsi_stop(s);
>>> +        ret = vhost_user_scsi_stop(s);
>>> +        if (ret) {
>>> +            return ret;
>>> +        }
>>>    }
>>> +    return 0;
>>> }
>>>
>>> static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>>> @@ -399,7 +403,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
>>>    vdc->unrealize = vhost_user_scsi_unrealize;
>>>    vdc->get_features = vhost_scsi_common_get_features;
>>>    vdc->set_config = vhost_scsi_common_set_config;
>>> -    vdc->set_status = vhost_user_scsi_set_status;
>>> +    vdc->set_status_ext = vhost_user_scsi_set_status;
>>>    fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
>>>    vdc->reset = vhost_user_scsi_reset;
>>>    vdc->get_vhost = vhost_user_scsi_get_vhost;
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 5e8d4cab53..fff7cdb35d 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>>> {
>>>    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>>>    trace_virtio_set_status(vdev, val);
>>> +    int ret = 0;
>>>
>>>    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>>>        if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>>>            val & VIRTIO_CONFIG_S_FEATURES_OK) {
>>> -            int ret = virtio_validate_features(vdev);
>>> -
>>> +            ret = virtio_validate_features(vdev);
>>>            if (ret) {
>>>                return ret;
>>>            }
>>> @@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>>>        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>>>    }
>>>
>>> -    if (k->set_status) {
>>> +    if (k->set_status_ext) {
>>> +        ret = k->set_status_ext(vdev, val);
>>> +        if (ret) {
>>> +            qemu_log("set %s status to %d failed, old status: %d\n",
>>> +                     vdev->name, val, vdev->status);
>>> +        }
>>> +    } else if (k->set_status) {
>>>        k->set_status(vdev, val);
>>>    }
>>>    vdev->status = val;
>>>
>>> -    return 0;
>>> +    return ret;
>>> }
>>>
>>> static enum virtio_device_endian virtio_default_endian(void)
>>> @@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, bool running, RunState state)
>>>    }
>>>
>>>    if (!backend_run) {
>>> -        virtio_set_status(vdev, vdev->status);
>>> +        // the return value was used for stopping VM during migration
>>
>> Can you elaborate a bit this comment?
>
>This comment is to explain that the return value is used to indicate that
>the live migration of the stop vhost-user device failed cuz the lost
>connection with backend.
>
>>
>>> +        int ret = virtio_set_status(vdev, vdev->status);
>>> +        if (ret) {
>>> +            return ret;
>>> +        }
>>>    }
>>>    return 0;
>>> }
>>> diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
>>> index c5d2c09455..d54d9c916f 100644
>>> --- a/include/hw/virtio/vhost-scsi-common.h
>>> +++ b/include/hw/virtio/vhost-scsi-common.h
>>> @@ -40,7 +40,7 @@ struct VHostSCSICommon {
>>> };
>>>
>>> int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>>> -void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>>> +int vhost_scsi_common_stop(VHostSCSICommon *vsc);
>>> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>>>                                        DeviceState *dev);
>>> void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config);
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index 6386910280..c99d56f519 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>>    void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>>    void (*reset)(VirtIODevice *vdev);
>>>    void (*set_status)(VirtIODevice *vdev, uint8_t val);
>>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>
>> Why we need a new callback instead having `set_status` returning int ?
>
>Because there are other devices such as virtio-net, virtio-ballon, etc.,
>we only focus on vhost-user-blk/scsi when live migration.

Why only them?

What I mean, is why in devices where it's not important, don't we just 
return 0?
It seems more complicated to maintain and confusing for new devices to 
have 2 callbacks for the same thing.

Stefano


