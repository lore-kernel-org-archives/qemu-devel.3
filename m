Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA740C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 12:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tryou-00057m-Ip; Tue, 11 Mar 2025 08:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tryor-00056z-KH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:34:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tryoo-0003F3-9i
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 08:34:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22548a28d0cso9906685ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741696483; x=1742301283;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6c4UjoyqZ5FL3EzmGV2y48nmkchuEBn23f3zeaXUzwA=;
 b=D21q1zqXqUbfcorIipZad9tyiWgmVk/HLxabXIoLM3u39TSRvqShvYhc3LbJfsoLBD
 ZUfXTzobE2TPdqbDRs+MvNLRvu3S+aiCbPq1LyItRltglMJWgaXX9NjUkEoub0v/408+
 nyUzFH5c0DGQLljj6LqMd5emIajUE6QiMt9HcwdjqxvGoJuQ9at0AHNyELTPaSxemHXz
 dkKU0knpWR6ie6ZWRyuDHSGaCkOqz/ihmFVt8xVl3Bkwx+0OLWL23ztzotHtqYjp08MN
 wU7ikun/fgcDBR9Ylhr8Ox1um8KjZX+F2U6tT5kkg4+JAVgqAZ8f+bBbyIDuHUL+oWnG
 AWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741696483; x=1742301283;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6c4UjoyqZ5FL3EzmGV2y48nmkchuEBn23f3zeaXUzwA=;
 b=Dxgr2ETXPUNOe2DfXZIEqWhx1hYszk2z/k14pGKIePJiYI7mDUivgY8SbDBX0pklh4
 oU5anODri5VtYA9c3xOg5mJhGffGKgVE4M0hrVsx250MsA9n+nhs+YayMn7EPSUmOukd
 Gg1fTyp++u0MRSpUAo7HfNZQNUnLgDtsFLcZAUaes1sNmltcVDiYmy7tNdSHaTxx0xvW
 3jEnY1FhfNK8iXqXttpkQcNCQP6W51eLlNWI8ueRY8pnzQ0fRmdDvyAzKb5R89GPW3pU
 gT31xjF5AJxcRZGR/xfcp3ekU2vQUH8rH+3EKgvg+pNPpzjIcMkqDivdeCcPsNMlgvpd
 CBPg==
X-Gm-Message-State: AOJu0Yw88pCiyngMWUT1SGcaBcgrfbJ2HmZd/dCCS8mSvrDqHszsP48T
 skj9T0V3ZZkc2kJz1SshdlrPsnUY4HqvHbit8RS+2UJvKEuBL4mb6/2ohHvKq+8=
X-Gm-Gg: ASbGncuro/2T0StzBtWRv2VxUGqvfexC4FnMsxh6IENeuwY/N858jgulqEeAaCLCfmV
 U8fmc/5FNSGM7dQStxUWJ9YBlrPMYsj2HIfha1IDv6DBU39uWJSbdo5oiJZUqFeT50kd2R805+q
 mhaitgZy5ukTyNClxXH5fNZKfQPO5BPOSxCW9DB9Rk2P1Bxus8/otLL30decihA6ELb5wkaCu3x
 RL535M4HJYFFQLkN4xx2HfSx7V0SrJsfjcUEufdixeAWfO5uTcsi7NMwRk+pj9L07uCJRwmh+97
 F9V1v1fLQRfAlfsM/qXA8TixTD5KxyrkXcEqShrGry91w+DYAg==
X-Google-Smtp-Source: AGHT+IEa8qI1o4NIy7Bote6Y99fIi+CpJHsBJrToDw0s3bZPZ4PcuJEju6lqNRud2ZUKOLznrmcrww==
X-Received: by 2002:a05:6a21:31c8:b0:1f5:58b9:6d97 with SMTP id
 adf61e73a8af0-1f558b97929mr18993613637.35.1741696482712; 
 Tue, 11 Mar 2025 05:34:42 -0700 (PDT)
Received: from smtpclient.apple ([23.163.8.28])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2810c1d24sm9420565a12.41.2025.03.11.05.34.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 05:34:42 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 3/3] vhost-user: return failure if backend crash when live
 migration
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <CAMDpr=eb7+PRmHC_VyyYPZ=kz5E53KTKG7fq0AnuHv=VCLVPHg@mail.gmail.com>
Date: Tue, 11 Mar 2025 20:34:20 +0800
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B611335F-1C2D-4130-8384-FE454384F889@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250309094051.3655292-1-haoqian.he@smartx.com>
 <20250309094051.3655292-2-haoqian.he@smartx.com>
 <CAMDpr=eb7+PRmHC_VyyYPZ=kz5E53KTKG7fq0AnuHv=VCLVPHg@mail.gmail.com>
To: Raphael Norwitz <raphael@enfabrica.net>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62c.google.com
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


Thanks for reviewing, I will fix this grammar issue in the next version.
>=20
>=20
> 2025=E5=B9=B43=E6=9C=8810=E6=97=A5 00:30=EF=BC=8CRaphael Norwitz =
<raphael@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> I'll let others chime in on higher level device model changes you're
> making. For the vhost-user-blk and vhost-user-scsi bits:
>=20
> On Sun, Mar 9, 2025 at 11:41=E2=80=AFAM Haoqian He =
<haoqian.he@smartx.com> wrote:
>>=20
>> Live migration should be terminated if backend crash.
>=20
> nit: "...if the backend crashes before the migration completes."
>=20
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
>=20
> I have some concerns with [2]. See my later responses.
>=20
>>=20
>> Hence migration_completion() will process failure, terminate
>> migration and restore VM.
>>=20
>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c             | 29 =
+++++++++++++++------------
>> hw/scsi/vhost-scsi-common.c           | 11 +++++-----
>> hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
>> hw/virtio/virtio.c                    | 20 +++++++++++++-----
>> include/hw/virtio/vhost-scsi-common.h |  2 +-
>> include/hw/virtio/virtio.h            |  1 +
>> 6 files changed, 51 insertions(+), 32 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index ae42327cf8..4865786c54 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -204,7 +204,7 @@ err_host_notifiers:
>>     return ret;
>> }
>>=20
>> -static void vhost_user_blk_stop(VirtIODevice *vdev)
>> +static int vhost_user_blk_stop(VirtIODevice *vdev)
>> {
>>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>> @@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice =
*vdev)
>>     int ret;
>>=20
>>     if (!s->started_vu) {
>> -        return;
>> +        return 0;
>>     }
>>     s->started_vu =3D false;
>>=20
>>     if (!k->set_guest_notifiers) {
>> -        return;
>> +        return 0;
>>     }
>>=20
>> -    vhost_dev_stop(&s->dev, vdev, true);
>> +    ret =3D vhost_dev_stop(&s->dev, vdev, true);
>>=20
>> -    ret =3D k->set_guest_notifiers(qbus->parent, s->dev.nvqs, =
false);
>> -    if (ret < 0) {
>> +    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < =
0) {
>>         error_report("vhost guest notifier cleanup failed: %d", ret);
>> -        return;
>> +        return -1;
>>     }
>>=20
>>     vhost_dev_disable_notifiers(&s->dev, vdev);
>> +    return ret;
>> }
>>=20
>> -static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
>> +static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t =
status)
>> {
>>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>     bool should_start =3D virtio_device_should_start(vdev, status);
>> @@ -239,11 +239,11 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>     int ret;
>>=20
>=20

The series of patches will not impact power-on if the backend is =
temporarily
down. The first patch ([PATCH 1/3] virtio: add VM state change cb with =
return
value) ignores the return value of VMChangeStateHandlerExt, which is
vhost_user_blk_set_status:

@@ -393,7 +398,12 @@ void vm_state_notify(bool running, RunState state)
        }

        QTAILQ_FOREACH_SAFE(e, &vm_change_state_head, entries, next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ext) {
+                // no need to process the result when starting VM
+                e->cb_ext(e->opaque, running, state);
+            }
        }
    } else {
        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, =
next) {
@@ -403,9 +413,14 @@ void vm_state_notify(bool running, RunState state)
        }

        QTAILQ_FOREACH_REVERSE_SAFE(e, &vm_change_state_head, entries, =
next) {
-            e->cb(e->opaque, running, state);
+            if (e->cb) {
+                e->cb(e->opaque, running, state);
+            } else if (e->cb_ext) {
+                ret |=3D e->cb_ext(e->opaque, running, state);
+            }
        }
    }
+    return ret;
}
>=20
>=20
> Do we want to fail out in all cases where vhost_user_blk_set_status()
> and the device is not connected? Could this impact power-on if the
> backend is temporarily down?
>=20
>>     if (!s->connected) {
>> -        return;
>> +        return -1;
>>     }
>>=20
>>     if (vhost_dev_is_started(&s->dev) =3D=3D should_start) {
>> -        return;
>> +        return 0;
>>     }
>>=20
>>     if (should_start) {
>> @@ -253,9 +253,12 @@ static void =
vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>>             qemu_chr_fe_disconnect(&s->chardev);
>>         }
>>     } else {
>> -        vhost_user_blk_stop(vdev);
>> +        ret =3D vhost_user_blk_stop(vdev);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>     }
>> -
>> +    return 0;
>> }
>>=20
>> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>> @@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass =
*klass, void *data)
>>     vdc->get_config =3D vhost_user_blk_update_config;
>>     vdc->set_config =3D vhost_user_blk_set_config;
>>     vdc->get_features =3D vhost_user_blk_get_features;
>> -    vdc->set_status =3D vhost_user_blk_set_status;
>> +    vdc->set_status_ext =3D vhost_user_blk_set_status;
>>     vdc->reset =3D vhost_user_blk_reset;
>>     vdc->get_vhost =3D vhost_user_blk_get_vhost;
>> }
>> diff --git a/hw/scsi/vhost-scsi-common.c =
b/hw/scsi/vhost-scsi-common.c
>> index 4c8637045d..bfeed0cb1b 100644
>> --- a/hw/scsi/vhost-scsi-common.c
>> +++ b/hw/scsi/vhost-scsi-common.c
>> @@ -101,24 +101,25 @@ err_host_notifiers:
>>     return ret;
>> }
>>=20
>> -void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>> +int vhost_scsi_common_stop(VHostSCSICommon *vsc)
>> {
>>     VirtIODevice *vdev =3D VIRTIO_DEVICE(vsc);
>>     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
>>     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>>     int ret =3D 0;
>>=20
>> -    vhost_dev_stop(&vsc->dev, vdev, true);
>> +    ret =3D vhost_dev_stop(&vsc->dev, vdev, true);
>>=20
>>     if (k->set_guest_notifiers) {
>> -        ret =3D k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, =
false);
>> -        if (ret < 0) {
>> +        int r =3D k->set_guest_notifiers(qbus->parent, =
vsc->dev.nvqs, false);
>> +        if (r < 0) {
>>                 error_report("vhost guest notifier cleanup failed: =
%d", ret);
>>         }
>=20

Yes, we can remove the assert here and return the return value, which =
will
also be modified in the next version.
> Now that we return back a value the assert here should probably be =
dropped?
>=20
>> +        assert(r >=3D 0);
>>     }
>> -    assert(ret >=3D 0);
>>=20
>>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
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
>>     return ret;
>> }
>>=20
>> -static void vhost_user_scsi_stop(VHostUserSCSI *s)
>> +static int vhost_user_scsi_stop(VHostUserSCSI *s)
>> {
>>     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
>>=20
>>     if (!s->started_vu) {
>> -        return;
>> +        return 0;
>>     }
>>     s->started_vu =3D false;
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
>>     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
>>     DeviceState *dev =3D DEVICE(vdev);
>> @@ -75,11 +75,11 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>     int ret;
>>=20
>>     if (!s->connected) {
>> -        return;
>> +        return -1;
>>     }
>>=20
>>     if (vhost_dev_is_started(&vsc->dev) =3D=3D should_start) {
>> -        return;
>> +        return 0;
>>     }
>>=20
>>     if (should_start) {
>> @@ -91,8 +91,12 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>>         }
>>     } else {
>> -        vhost_user_scsi_stop(s);
>> +        ret =3D vhost_user_scsi_stop(s);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>     }
>> +    return 0;
>> }
>>=20
>> static void vhost_user_scsi_handle_output(VirtIODevice *vdev, =
VirtQueue *vq)
>> @@ -399,7 +403,7 @@ static void =
vhost_user_scsi_class_init(ObjectClass *klass, void *data)
>>     vdc->unrealize =3D vhost_user_scsi_unrealize;
>>     vdc->get_features =3D vhost_scsi_common_get_features;
>>     vdc->set_config =3D vhost_scsi_common_set_config;
>> -    vdc->set_status =3D vhost_user_scsi_set_status;
>> +    vdc->set_status_ext =3D vhost_user_scsi_set_status;
>>     fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
>>     vdc->reset =3D vhost_user_scsi_reset;
>>     vdc->get_vhost =3D vhost_user_scsi_get_vhost;
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 5e8d4cab53..fff7cdb35d 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
>> {
>>     VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>>     trace_virtio_set_status(vdev, val);
>> +    int ret =3D 0;
>>=20
>>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>>         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>>             val & VIRTIO_CONFIG_S_FEATURES_OK) {
>> -            int ret =3D virtio_validate_features(vdev);
>> -
>> +            ret =3D virtio_validate_features(vdev);
>>             if (ret) {
>>                 return ret;
>>             }
>> @@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, =
uint8_t val)
>>         virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>>     }
>>=20
>> -    if (k->set_status) {
>> +    if (k->set_status_ext) {
>> +        ret =3D k->set_status_ext(vdev, val);
>> +        if (ret) {
>> +            qemu_log("set %s status to %d failed, old status: %d\n",
>> +                     vdev->name, val, vdev->status);
>> +        }
>> +    } else if (k->set_status) {
>>         k->set_status(vdev, val);
>>     }
>>     vdev->status =3D val;
>>=20
>> -    return 0;
>> +    return ret;
>> }
>>=20
>> static enum virtio_device_endian virtio_default_endian(void)
>> @@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, =
bool running, RunState state)
>>     }
>>=20
>>     if (!backend_run) {
>> -        virtio_set_status(vdev, vdev->status);
>> +        // the return value was used for stopping VM during =
migration
>> +        int ret =3D virtio_set_status(vdev, vdev->status);
>> +        if (ret) {
>> +            return ret;
>> +        }
>>     }
>>     return 0;
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
>>                                         DeviceState *dev);
>> void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t =
*config);
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 6386910280..c99d56f519 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>>     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>>     void (*reset)(VirtIODevice *vdev);
>>     void (*set_status)(VirtIODevice *vdev, uint8_t val);
>> +    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);
>>     /* Device must validate queue_index.  */
>>     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
>>     /* Device must validate queue_index.  */
>> --
>> 2.48.1


Thanks

--
Haoqian


