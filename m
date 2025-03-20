Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0365C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEub-0003MM-VO; Thu, 20 Mar 2025 08:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEuE-0003Az-IQ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEuC-00062C-37
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso9019535ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742473305; x=1743078105;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f06Kk4xT5KcYRZAP+knc2XeAoGAzI8KdoZk6IcoUUBk=;
 b=KbwoVmMwfdkWru/I4cLmUb4WeoZODZH2Bdw6ycIHJ+r7rDjAWSbni/alloW5lqMpr1
 4CqQtvp5vRF+tEJ/VUkNd3juN3gGhTZI4UJyZb9QsnRBvLIdcn5JjSIDWpB0lQVfOC4a
 AiFpRDeZTSPzIcEiwFZeDrQbSuOx3w8umANEsHlp2XVYEFAAsxxar4Rp2AAKoJQTtU88
 GYcs22s67oVWCCzKRQl8E3gWMPpN7iySa6qvJPY3TTyFRnN+Y9cpzJOOl+jkRyBJBzc1
 oNfHGfNUL08tLucEeGEPgoycA9DXPgkMAutCDAQ7GzOA56c7CR48N6AXwU3uao0ZBv37
 mGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742473305; x=1743078105;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f06Kk4xT5KcYRZAP+knc2XeAoGAzI8KdoZk6IcoUUBk=;
 b=DdEnPM12pR6RxLUhVPWqBPAxiFpINJurVzdLCmTJA/irjH+a5ClvVaAC0ANuHXO3Vz
 0PC3/D/I+++OK6i5+VQTXP+NmIIpKmSX6BIL4qmvDLQnLv1UdcWz3BT5m9BKM5OP5+kc
 tyrJVhNWRq2vZhuX0xsW2yxmNWGOHd7uwG1SdUQqqNxDeGdFxWSkR495DrLr1qGG52ZE
 YnLyirD+FvXPTSt3BKQ82fRkAk301nwU+S9yZuXKQe8uHnM4a5jMrv7tQ9qJV+Ea3Tfh
 sBLxV0hppKv6FwokwXvsV7hnLjna0txmo2TjMBuPhsmRSTU4DThuAN3XnWgE+aayfClj
 hGFQ==
X-Gm-Message-State: AOJu0YwGFpXqiNI/yhpwVKCZUBWwyxDzGTysFp8ZUERUxaWZy5D1jgZ2
 osSvMmErDK6Nzmc7i+JJknb5rGm62VpWaxJdWIcGOHlwN/c8axmOm0jn8+8GCrY=
X-Gm-Gg: ASbGncvaLt9erHdhIHEA5+mnRMduPRsiW3Az4lRy4AabEFNYZjr+Eelx4SreMqz0ix2
 yR1av29+jqPED8WQ4Lk8i7D6ybVeNC9R5QyMxR6/xQ3fHXSp1h08O30b5TQR5RnW9E0YJ8yMgFZ
 WW2tnmxd5v5arbVtL+qj0jQGz+qo3USGJhJ8zFeHaInkw37cff9BTNYE06gT0HRJbBChuoxlAAg
 K8EHxsPbt+VEhiGMUEfw/6jlDBxif53qlq5cOdhMUDFwoGQo39IZmfcIAzO/sCWy7+VyZ6LRYnR
 pDrS2KRTnUkfZdaMWvwgxBJR7DS/pNzWrCxUuNjmWnWfJyOG7PTwDPeM76MAOweXzhpdo9fpzNC
 RkKOnzImRdceiOrBlxkCrUveVPW6HL2qpUrDPw7/3JsND2l4=
X-Google-Smtp-Source: AGHT+IGOLgowy//013za9b1QVysNNNwSGRrn+7xZbJMxYuJXaZZ4oHkgJiegN/Wc84gG84m3EfFdzQ==
X-Received: by 2002:a05:6a00:2e99:b0:736:9e40:13b1 with SMTP id
 d2e1a72fcca58-7376d6fae4emr8970463b3a.23.1742473304780; 
 Thu, 20 Mar 2025 05:21:44 -0700 (PDT)
Received: from smtpclient.apple (awork062100.netvigator.com. [203.198.28.100])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695b1fsm13518702b3a.127.2025.03.20.05.21.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 05:21:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
Date: Thu, 20 Mar 2025 20:21:30 +0800
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
Message-Id: <C1643EB1-EBA7-4627-A1E9-BB4F8CC688A2@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
 <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62e.google.com
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



> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 23:20=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>> Live migration should be terminated if the backend crashes before
>> the migration completes.
>>=20
>> Since the vhost device will be stopped when VM is stopped before
>> the end of the live migration, current implementation if vhost
>> backend died, vhost device's set_status() will not return failure,
>> live migration won't perceive the disconnection between qemu and
>> vhost backend, inflight io would be submitted in migration target
>> host, leading to IO error.
>>=20
>> To fix this issue:
>> 1. Add set_status_ext() which has return value for
>> VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.
>>=20
>> 2. In set_status_ext(), return failure if the flag `connected`
>> is false or vhost_dev_stop return failure, which means qemu lost
>> connection with backend.
>>=20
>> Hence migration_completion() will process failure, terminate
>> migration and restore VM.
>>=20
>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c             | 29 =
+++++++++++++++------------
>> hw/scsi/vhost-scsi-common.c           | 13 ++++++------
>> hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
>> hw/virtio/virtio.c                    | 20 +++++++++++++-----
>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>> include/hw/virtio/virtio.h            |  1 +
>> 6 files changed, 52 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index ae42327cf8..4865786c54 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -204,7 +204,7 @@ err_host_notifiers:
>>    return ret;
>> }
>>=20
>> -static void vhost_user_blk_stop(VirtIODevice *vdev)
>> +static int vhost_user_blk_stop(VirtIODevice *vdev)
>> {
>>    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>> @@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice =
*vdev)
>>    int ret;
>>=20
>>    if (!s->started_vu) {
>> -        return;
>> +        return 0;
>>    }
>>    s->started_vu =3D false;
>>=20
>>    if (!k->set_guest_notifiers) {
>> -        return;
>> +        return 0;
>>    }
>>=20
>> -    vhost_dev_stop(&s->dev, vdev, true);
>> +    ret =3D vhost_dev_stop(&s->dev, vdev, true);
>>=20
>> -    ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, =
false);
>> -    if (ret < 0) {
>> +    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < =
0) {
>>        error_report("vhost guest notifier cleanup failed: %d", ret);
>> -        return;
>> +        return -1;
>>    }
>>=20
>>    vhost_dev_disable_notifiers(&s->dev, vdev);
>> +    return ret;
>> }
>>=20
>> -static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
>> +static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>    bool should_start =3D virtio_device_should_start(vdev, status);
>> @@ -239,11 +239,11 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>    int ret;
>>=20
>>    if (!s->connected) {
>> -        return;
>> +        return -1;
>>    }
>>=20
>>    if (vhost_dev_is_started(&s->dev) =3D=3D should_start) {
>> -        return;
>> +        return 0;
>>    }
>>=20
>>    if (should_start) {
>> @@ -253,9 +253,12 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>            qemu_chr_fe_disconnect(&s->chardev);
>>        }
>>    } else {
>> -        vhost_user_blk_stop(vdev);
>> +        ret =3D vhost_user_blk_stop(vdev);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>    }
>> -
>> +    return 0;
>> }
>>=20
>> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>> @@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass =
*klass, void *data)
>>    vdc->get_config =3D vhost_user_blk_update_config;
>>    vdc->set_config =3D vhost_user_blk_set_config;
>>    vdc->get_features =3D vhost_user_blk_get_features;
>> -    vdc->set_status =3D vhost_user_blk_set_status;
>> +    vdc->set_status_ext =3D vhost_user_blk_set_status;
>>    vdc->reset =3D vhost_user_blk_reset;
>>    vdc->get_vhost =3D vhost_user_blk_get_vhost;
>> }
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index 4c8637045d..43525ba46d 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -101,24 +101,25 @@ err_host_notifiers:
>>    return ret;
>> }
>>=20
>> -void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>> +int vhost_scsi_common_stop(VHostSCSICommon *vsc)
>> {
>>    VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>>    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>>    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>>    int ret =3D 0;
>>=20
>> -    vhost_dev_stop(&vsc->dev, vdev, true);
>> +    ret =3D vhost_dev_stop(&vsc->dev, vdev, true);
>>=20
>>    if (k->set_guest_notifiers) {
>> -        ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, =
false);
>> -        if (ret < 0) {
>> -                error_report("vhost guest notifier cleanup failed: =
%d", ret);
>> +        int r =3D k->set_guest_notifiers(qbus->parent, =
vsc->dev.nvqs, false);
>> +        if (r < 0) {
>> +            error_report("vhost guest notifier cleanup failed: %d", =
ret);
>=20
> The variable `ret` in the error_report() seems wrong.

Ohh, thanks, I will fix it later.

>=20
>> +            return r;
>>        }
>>    }
>> -    assert(ret >=3D 0);
>>=20
>>    vhost_dev_disable_notifiers(&vsc->dev, vdev);
>> +    return ret;
>> }
>>=20
>> uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t =
features,
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index adb41b9816..8e7efc38f2 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI =
*s, Error **errp)
>>    return ret;
>> }
>>=20
>> -static void vhost_user_scsi_stop(VHostUserSCSI *s)
>> +static int vhost_user_scsi_stop(VHostUserSCSI *s)
>> {
>>    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>=20
>>    if (!s->started_vu) {
>> -        return;
>> +        return 0;
>>    }
>>    s->started_vu =3D false;
>>=20
>> -    vhost_scsi_common_stop(vsc);
>> +    return vhost_scsi_common_stop(vsc);
>> }
>>=20
>> -static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
>> +static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>    VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>>    DeviceState *dev =3D DEVICE(vdev);
>> @@ -75,11 +75,11 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>    int ret;
>>=20
>>    if (!s->connected) {
>> -        return;
>> +        return -1;
>>    }
>>=20
>>    if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
>> -        return;
>> +        return 0;
>>    }
>>=20
>>    if (should_start) {
>> @@ -91,8 +91,12 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>            qemu_chr_fe_disconnect(&vs->conf.chardev);
>>        }
>>    } else {
>> -        vhost_user_scsi_stop(s);
>> +        ret =3D vhost_user_scsi_stop(s);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>    }
>> +    return 0;
>> }
>>=20
>> static void vhost_user_scsi_handle_output(VirtIODevice *vdev, =
VirtQueue *vq)
>> @@ -399,7 +403,7 @@ static void =
vhost_user_scsi_class_init(ObjectClass *klass, void *data)
>>    vdc->unrealize =3D vhost_user_scsi_unrealize;
>>    vdc->get_features =3D vhost_scsi_common_get_features;
>>    vdc->set_config =3D vhost_scsi_common_set_config;
>> -    vdc->set_status =3D vhost_user_scsi_set_status;
>> +    vdc->set_status_ext =3D vhost_user_scsi_set_status;
>>    fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
>>    vdc->reset =3D vhost_user_scsi_reset;
>>    vdc->get_vhost =3D vhost_user_scsi_get_vhost;
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 5e8d4cab53..fff7cdb35d 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
>> {
>>    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>    trace_virtio_set_status(vdev, val);
>> +    int ret =3D 0;
>>=20
>>    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>>        if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>>            val & VIRTIO_CONFIG_S_FEATURES_OK) {
>> -            int ret =3D virtio_validate_features(vdev);
>> -
>> +            ret =3D virtio_validate_features(vdev);
>>            if (ret) {
>>                return ret;
>>            }
>> @@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
>>        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>>    }
>>=20
>> -    if (k->set_status) {
>> +    if (k->set_status_ext) {
>> +        ret =3D k->set_status_ext(vdev, val);
>> +        if (ret) {
>> +            qemu_log("set %s status to %d failed, old status: %d\n",
>> +                     vdev->name, val, vdev->status);
>> +        }
>> +    } else if (k->set_status) {
>>        k->set_status(vdev, val);
>>    }
>>    vdev->status =3D val;
>>=20
>> -    return 0;
>> +    return ret;
>> }
>>=20
>> static enum virtio_device_endian virtio_default_endian(void)
>> @@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, =
bool running, RunState state)
>>    }
>>=20
>>    if (!backend_run) {
>> -        virtio_set_status(vdev, vdev->status);
>> +        // the return value was used for stopping VM during =
migration
>=20
> Can you elaborate a bit this comment?

This comment is to explain that the return value is used to indicate =
that
the live migration of the stop vhost-user device failed cuz the lost
connection with backend.

>=20
>> +        int ret =3D virtio_set_status(vdev, vdev->status);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>    }
>>    return 0;
>> }
>> diff --git a/include/hw/virtio/vhost-scsi-common.h =
b/include/hw/virtio/vhost-scsi-common.h
>> index c5d2c09455..d54d9c916f 100644
>> --- a/include/hw/virtio/vhost-scsi-common.h
>> +++ b/include/hw/virtio/vhost-scsi-common.h
>> @@ -40,7 +40,7 @@ struct VHostSCSICommon {
>> };
>>=20
>> int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>> -void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>> +int vhost_scsi_common_stop(VHostSCSICommon *vsc);
>> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState =
*bus,
>>                                        DeviceState *dev);
>> void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t =
*config);
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 6386910280..c99d56f519 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>    void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>    void (*reset)(VirtIODevice *vdev);
>>    void (*set_status)(VirtIODevice *vdev, uint8_t val);
>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>=20
> Why we need a new callback instead having `set_status` returning int ?

Because there are other devices such as virtio-net, virtio-ballon, etc.,
we only focus on vhost-user-blk/scsi when live migration.

>=20
> Thanks,
> Stefano
>=20
>>    /* Device must validate queue_index.  */
>>    void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
>>    /* Device must validate queue_index.  */
>> --=20
>> 2.48.1



