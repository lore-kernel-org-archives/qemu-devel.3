Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28954C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEua-0003LX-Dm; Thu, 20 Mar 2025 08:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEuD-0003Am-E8
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:54 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1tvEu9-00061x-Vy
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:21:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so3826775a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 05:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742473302; x=1743078102;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVaXk+/VtDTofoI0QaCYnY4S5OMnyNtNcyhwJlA3VfU=;
 b=hrPIfC3pseqhFABALGxQYl+20ZsLQArJRVPIV81yU2h0A3bAMUou2D8SG9rtD0ynDE
 uDt6SSnfa9JE3he5maXCVmr44ulcZb1xujGoefVr3W/PffbpTH7dx2chA4SozWhu9mon
 rIzUAN6Cm5pxpJLVQc65YGBJN1Dq25NWOPQB2DRqcfjRNHuReoUNGwxguwXeC4U/HQoW
 sfI2knU0peB03ZeMchI4BJJGq2U1YkZqAb7KtS4fOFpYpiKrSLAbPYPpvoJwPfvhHzMQ
 trPQUTQZtGTda4Tti31tIiuUppGl11MKV4zDVf9Syi637xQrT52nTuTjU1Cxm3j62rgD
 RgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742473302; x=1743078102;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVaXk+/VtDTofoI0QaCYnY4S5OMnyNtNcyhwJlA3VfU=;
 b=GusunWYnTD4u5KrW0BV9s4PjYEnIwI+EIjvILBGdoyEZlg57BRl7ZC5FAYUGWA5TVY
 ePc2NLLTrNp6baP/dg3c/cn4EcjS2TjgWleS9/PwFlATfdtT+XjeqvSiIKS1Q3kq46Ba
 Ndhb3rS9f46n55El6GkUdCTSQlepUZtFHYmXKOtggBDkcLH4GgB+iJMHRucQvx7sCZLN
 hImyxtxm9XjDD7CcukDwt/BkYpz5E2Nr1nD4AlOwdc5GhzbqJSEaYqjbeu3oTScm0WE0
 a+dHBFqa5rlVNAgoXhTqmFepOUsAtiJuSaixLQY5rFcI+3fxMd3FcLFTlmJ+WlJAITDl
 ML2w==
X-Gm-Message-State: AOJu0YyZbgT4hXuY+RCVZZUUyymlI0uwU3Tk0lZiE+12MkkmALnI1d9Q
 T+Aqg65hOIgcymotvnmvUOaX0EmzYuRvEnW25wt4RaQl3A/5W7jQeYmiGwLdKNs=
X-Gm-Gg: ASbGncthhWr7yBQxi3EgeeJMdBnX6u3uMF6TfXO7YD6lSDPm+W0NrRdkHMBi9T0qajv
 L4UbAs0lISH6VfUF51iu8QzVXWOR9BXJ9H1yX78QfnE44EWycVM7145NWHZY/pWGqp278e+oko8
 1t+aPbrTQizx2Ygv7XvB1+vtTuyW4FtXwZlTaAx1FcTcdgc5vaEYijphhl2a/56WqH6EGguMMGN
 XSQUwpcMEXnVE+awI365YPSpiT5p1SypzA03HQC1mq2HUIl0XxiSHIPna5y4/DV31HUqgtNwniJ
 tVsrP48l2U/xwCrxA9dncJQDta8067RvHJhxLob8fw8X+whxS2ullnLAs8NGsIwyPEHwVi3zv3j
 x/JEUe6X+CMTCVGPaImbf/+KBOluIllQ4nm3s6uhYrnIKtvE=
X-Google-Smtp-Source: AGHT+IFpwCvsYXs33YsQk+zB7R+ssqaiVf8KD9vL9POQ+fIRLLSVvwj1UoMLPUVPz0t+SN8k+ntiCA==
X-Received: by 2002:a05:6a00:138f:b0:736:b400:b58f with SMTP id
 d2e1a72fcca58-73779f254ccmr5673509b3a.0.1742473302212; 
 Thu, 20 Mar 2025 05:21:42 -0700 (PDT)
Received: from smtpclient.apple (awork062100.netvigator.com. [203.198.28.100])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737113d71fbsm13577633b3a.0.2025.03.20.05.21.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 05:21:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2 2/3] vhost: return failure if stop virtqueue failed in
 vhost_dev_stop
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <ho2s47wmeqgeh6otsx4ttqdy3zudgehkokth2ccubsoywzvqhp@mv45e5do5rj7>
Date: Thu, 20 Mar 2025 20:21:25 +0800
Cc: qemu-devel@nongnu.org, Li Feng <fengli@smartx.com>, yuhua@smartx.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <780BAD55-0C1E-4DE6-92F8-C6203F6CC350@smartx.com>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-3-haoqian.he@smartx.com>
 <ho2s47wmeqgeh6otsx4ttqdy3zudgehkokth2ccubsoywzvqhp@mv45e5do5rj7>
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=haoqian.he@smartx.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> 2025=E5=B9=B43=E6=9C=8819=E6=97=A5 23:11=EF=BC=8CStefano Garzarella =
<sgarzare@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Mar 14, 2025 at 06:15:33AM -0400, Haoqian He wrote:
>> The backend maybe crash when vhost_dev_stop and GET_VRING_BASE
>> would fail, we can return failure to indicate the connection
>> with the backend is broken.
>>=20
>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>> ---
>> hw/virtio/vhost.c         | 27 +++++++++++++++------------
>> include/hw/virtio/vhost.h |  8 +++++---
>> 2 files changed, 20 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 6aa72fd434..c82bbbe4cc 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1368,23 +1368,23 @@ fail_alloc_desc:
>>    return r;
>> }
>>=20
>> -void vhost_virtqueue_stop(struct vhost_dev *dev,
>> -                          struct VirtIODevice *vdev,
>> -                          struct vhost_virtqueue *vq,
>> -                          unsigned idx)
>> +int vhost_virtqueue_stop(struct vhost_dev *dev,
>> +                         struct VirtIODevice *vdev,
>> +                         struct vhost_virtqueue *vq,
>> +                         unsigned idx)
>> {
>>    int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, =
idx);
>>    struct vhost_vring_state state =3D {
>>        .index =3D vhost_vq_index,
>>    };
>> -    int r;
>> +    int r =3D 0;
>>=20
>>    if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>>        /* Don't stop the virtqueue which might have not been started =
*/
>> -        return;
>> +        return 0;
>>    }
>>=20
>> -    r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
>> +    r |=3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
>=20
> We can avoid this and also initialize r to 0.

Here we need to do `vhost_virtqueue_stop` for each vq.

>=20
>>    if (r < 0) {
>>        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, =
r);
>>        /* Connection to the backend is broken, so let's sync internal
>> @@ -1412,6 +1412,7 @@ void vhost_virtqueue_stop(struct vhost_dev =
*dev,
>>                       0, virtio_queue_get_avail_size(vdev, idx));
>>    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, =
idx),
>>                       0, virtio_queue_get_desc_size(vdev, idx));
>> +    return r;
>> }
>>=20
>> static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev =
*dev,
>> @@ -2136,9 +2137,10 @@ fail_features:
>> }
>>=20
>> /* Host notifiers must be enabled at this point. */
>> -void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
vrings)
>> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
vrings)
>> {
>>    int i;
>> +    int rc =3D 0;
>>=20
>>    /* should only be called after backend is connected */
>>    assert(hdev->vhost_ops);
>> @@ -2157,10 +2159,10 @@ void vhost_dev_stop(struct vhost_dev *hdev, =
VirtIODevice *vdev, bool vrings)
>>        vhost_dev_set_vring_enable(hdev, false);
>>    }
>>    for (i =3D 0; i < hdev->nvqs; ++i) {
>> -        vhost_virtqueue_stop(hdev,
>> -                             vdev,
>> -                             hdev->vqs + i,
>> -                             hdev->vq_index + i);
>> +        rc |=3D vhost_virtqueue_stop(hdev,
>> +                                   vdev,
>> +                                   hdev->vqs + i,
>> +                                   hdev->vq_index + i);
>=20
> Also other function can fails, should we consider also them?
> (e.g. 	, vhost_dev_set_vring_enable, etc.)
>=20
> If not, why?

Since we only want to know the return value of callback when the =
stopping device
live migration, there is no need to catch the failure of =
`vhost_dev_start`.

We can also catch the failure of `vhost_dev_set_vring_enable`, because
`vhost_dev_set_vring_enable` will also fail if qemu lost connection with =
the
the backend, but I need to test it.


>=20
>>    }
>>    if (hdev->vhost_ops->vhost_reset_status) {
>>        hdev->vhost_ops->vhost_reset_status(hdev);
>> @@ -2177,6 +2179,7 @@ void vhost_dev_stop(struct vhost_dev *hdev, =
VirtIODevice *vdev, bool vrings)
>>    hdev->started =3D false;
>>    vdev->vhost_started =3D false;
>>    hdev->vdev =3D NULL;
>> +    return rc;
>> }
>>=20
>> int vhost_net_set_backend(struct vhost_dev *hdev,
>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>> index a9469d50bc..fd96ec9c39 100644
>> --- a/include/hw/virtio/vhost.h
>> +++ b/include/hw/virtio/vhost.h
>> @@ -232,8 +232,10 @@ int vhost_dev_start(struct vhost_dev *hdev, =
VirtIODevice *vdev, bool vrings);
>> * Stop the vhost device. After the device is stopped the notifiers
>> * can be disabled (@vhost_dev_disable_notifiers) and the device can
>> * be torn down (@vhost_dev_cleanup).
>> + *
>> + * Return: 0 on success, !=3D 0 on error when stopping dev.
>> */
>> -void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
vrings);
>> +int vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
vrings);
>>=20
>> /**
>> * DOC: vhost device configuration handling
>> @@ -333,8 +335,8 @@ int vhost_device_iotlb_miss(struct vhost_dev =
*dev, uint64_t iova, int write);
>>=20
>> int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice =
*vdev,
>>                          struct vhost_virtqueue *vq, unsigned idx);
>> -void vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice =
*vdev,
>> -                          struct vhost_virtqueue *vq, unsigned idx);
>> +int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice =
*vdev,
>> +                         struct vhost_virtqueue *vq, unsigned idx);
>>=20
>> void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>> void vhost_dev_free_inflight(struct vhost_inflight *inflight);
>> --=20
>> 2.48.1



