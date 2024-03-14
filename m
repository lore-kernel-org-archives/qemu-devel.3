Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500B5C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqPe-0006E9-J1; Thu, 14 Mar 2024 15:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkqPT-0006CX-A3
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rkqPQ-0002Cf-GE
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710443190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjirL1/LjRJi2Fqm5GZDwwtcfSDmr/yBx4cC7oZq5g0=;
 b=J9vrr5KlODxwWlBnEUCAJHWhoPsk6l5DXZMM44fmOyHIL+aM5k4+2jk5c499gfEvX/oBAW
 wKLqqkVya8Ag7XCmT5/8UBdychh3DqTrYsdIlBFhaHQpFdI7J2/e+eU6L9nDFoMtQuQxDr
 Sx25E3G6LxUyL9lX9PsspOl8EepSM5o=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-ehj-IuIwP4S2PPgGPYxM-Q-1; Thu, 14 Mar 2024 15:06:28 -0400
X-MC-Unique: ehj-IuIwP4S2PPgGPYxM-Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a54004e9fso25366397b3.3
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710443188; x=1711047988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjirL1/LjRJi2Fqm5GZDwwtcfSDmr/yBx4cC7oZq5g0=;
 b=cjEkZRuG1tgHyqgJZ1xKjfX75Ij5gChPkE/KTIhJ0vR4DpEejP6Z2c5FNjc3iUBQxh
 7KgTvxWFeMSOmoV093f1kb1AzW65LQLDEfGymFbSHO97U73A7Zke84yhsYCNffMc20lp
 cO26PGXwrVlu5MvMiLSjPJ1ySJZ3IMvd7u6wVRvPedwfLbomT3LVOKni8YMIosY81VjP
 BbIVG3/Uouich/NIYufbPBnvaE93Dg/ryK0CirtN23759DSoJfFtFqpIpoF2AdjK1D9T
 /34UDLyl5VUQOyc7H6dFEdmAVYf4la2z1JmJV6S+TM73Qy4VfLp7Sd5xsh+q+WUf/YZZ
 diwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSM+M/MWR7KXSdRIj9P/TX8VAJEouYP0166voP9UdoGnNi9HonFQpfeq2kgcE9YySqlRE6M9jXVZsXDsKcD1xrX9HBV1c=
X-Gm-Message-State: AOJu0YzpOyzkT3ShrWcnWTrOICJe7UeCOB9JtnwbVOY57KLNCDRX5AOC
 sIOCOYT8ybPBln5ulfP00txdLM8bKiiNPloL7Sa3DGCm/SjuUzQuJJeReGF1Cg8bxiSU3DIQaZ/
 VfLPgDxnstVH55zBIA56BRbnEkFFINUeH7jlw3zPmxzBeQWCvtsBh8FflGFN53E2G3sH+YZDd4f
 3bjY7T186Qjzw2sf+vtoT9Ctx9xpE=
X-Received: by 2002:a81:9c53:0:b0:60a:a73:9516 with SMTP id
 n19-20020a819c53000000b0060a0a739516mr2388718ywa.47.1710443188038; 
 Thu, 14 Mar 2024 12:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGylYrFCxeZlV3nrP6xZzh4yZUM+eQbBH7v9bTyUxXA5rBJhh3olPEO845D6EGxADRMTO6Kj92yx9pgthzBLKw=
X-Received: by 2002:a81:9c53:0:b0:60a:a73:9516 with SMTP id
 n19-20020a819c53000000b0060a0a739516mr2388706ywa.47.1710443187726; Thu, 14
 Mar 2024 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-2-jonah.palmer@oracle.com>
 <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
 <b0e4a124-cced-4cbc-9f89-b8967f5a0b2c@oracle.com>
 <CAJaqyWcmzuY5R8hC-zwp_mEK40sYgwHU0vhewKziQLsY2EnpLg@mail.gmail.com>
 <f173f397-965f-43f9-9ce0-b417e86d6935@oracle.com>
In-Reply-To: <f173f397-965f-43f9-9ce0-b417e86d6935@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Mar 2024 20:05:51 +0100
Message-ID: <CAJaqyWfspBXGw0WE2=HBuZiBJjyWTrMm2jyB4e0mP9UkixS4Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] virtio/virtio-pci: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com, 
 borntraeger@linux.ibm.com, farman@linux.ibm.com, thuth@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com, 
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, 
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, leiyang@redhat.com, 
 schalla@marvell.com, vattunuru@marvell.com, jerinj@marvell.com, 
 dtatulea@nvidia.com, virtio-fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 14, 2024 at 5:06=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/14/24 10:55 AM, Eugenio Perez Martin wrote:
> > On Thu, Mar 14, 2024 at 1:16=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 3/13/24 11:01 PM, Jason Wang wrote:
> >>> On Wed, Mar 13, 2024 at 7:55=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>> Add support to virtio-pci devices for handling the extra data sent
> >>>> from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
> >>>> transport feature has been negotiated.
> >>>>
> >>>> The extra data that's passed to the virtio-pci device when this
> >>>> feature is enabled varies depending on the device's virtqueue
> >>>> layout.
> >>>>
> >>>> In a split virtqueue layout, this data includes:
> >>>>    - upper 16 bits: shadow_avail_idx
> >>>>    - lower 16 bits: virtqueue index
> >>>>
> >>>> In a packed virtqueue layout, this data includes:
> >>>>    - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> >>>>    - lower 16 bits: virtqueue index
> >>>>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>> ---
> >>>>    hw/virtio/virtio-pci.c     | 10 +++++++---
> >>>>    hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>>>    include/hw/virtio/virtio.h |  1 +
> >>>>    3 files changed, 26 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >>>> index cb6940fc0e..0f5c3c3b2f 100644
> >>>> --- a/hw/virtio/virtio-pci.c
> >>>> +++ b/hw/virtio/virtio-pci.c
> >>>> @@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, ui=
nt32_t addr, uint32_t val)
> >>>>    {
> >>>>        VirtIOPCIProxy *proxy =3D opaque;
> >>>>        VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >>>> -    uint16_t vector;
> >>>> +    uint16_t vector, vq_idx;
> >>>>        hwaddr pa;
> >>>>
> >>>>        switch (addr) {
> >>>> @@ -408,8 +408,12 @@ static void virtio_ioport_write(void *opaque, u=
int32_t addr, uint32_t val)
> >>>>                vdev->queue_sel =3D val;
> >>>>            break;
> >>>>        case VIRTIO_PCI_QUEUE_NOTIFY:
> >>>> -        if (val < VIRTIO_QUEUE_MAX) {
> >>>> -            virtio_queue_notify(vdev, val);
> >>>> +        vq_idx =3D val;
> >>>> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> >>>> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION=
_DATA)) {
> >>>> +                virtio_queue_set_shadow_avail_data(vdev, val);
> >>>> +            }
> >>>> +            virtio_queue_notify(vdev, vq_idx);
> >>>>            }
> >>>>            break;
> >>>>        case VIRTIO_PCI_STATUS:
> >>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>> index d229755eae..bcb9e09df0 100644
> >>>> --- a/hw/virtio/virtio.c
> >>>> +++ b/hw/virtio/virtio.c
> >>>> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *vde=
v, int n, int align)
> >>>>        }
> >>>>    }
> >>>>
> >>>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_=
t data)
> >
> > Maybe I didn't explain well, but I think it is better to pass directly
> > idx to a VirtQueue *. That way only the caller needs to check for a
> > valid vq idx, and (my understanding is) the virtio.c interface is
> > migrating to VirtQueue * use anyway.
> >
>
> Oh, are you saying to just pass in a VirtQueue *vq instead of
> VirtIODevice *vdev and get rid of the vq->vring.desc check in the functio=
n?
>

No, that needs to be kept. I meant the access to vdev->vq[i] without
checking for a valid i.

You can get the VirtQueue in the caller with virtio_get_queue. Which
also does not check for a valid index, but that way is clearer the
caller needs to check it.

As a side note, the check for desc !=3D 0 is widespread in QEMU but the
driver may use 0 address for desc, so it's not 100% valid. But to
change that now requires a deeper change out of the scope of this
series, so let's keep it for now :).

Thanks!

> >>>> +{
> >>>> +    /* Lower 16 bits is the virtqueue index */
> >>>> +    uint16_t i =3D data;
> >>>> +    VirtQueue *vq =3D &vdev->vq[i];
> >>>> +
> >>>> +    if (!vq->vring.desc) {
> >>>> +        return;
> >>>> +    }
> >>>> +
> >>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >>>> +        vq->shadow_avail_wrap_counter =3D (data >> 31) & 0x1;
> >>>> +        vq->shadow_avail_idx =3D (data >> 16) & 0x7FFF;
> >>>> +    } else {
> >>>> +        vq->shadow_avail_idx =3D (data >> 16);
> >>>
> >>> Do we need to do a sanity check for this value?
> >>>
> >>> Thanks
> >>>
> >>
> >> It can't hurt, right? What kind of check did you have in mind?
> >>
> >> if (vq->shadow_avail_idx >=3D vq->vring.num)
> >>
> >
> > I'm a little bit lost too. shadow_avail_idx can take all uint16_t
> > values. Maybe you meant checking for a valid vq index, Jason?
> >
> > Thanks!
> >
> >> Or something else?
> >>
> >>>> +    }
> >>>> +}
> >>>> +
> >>>>    static void virtio_queue_notify_vq(VirtQueue *vq)
> >>>>    {
> >>>>        if (vq->vring.desc && vq->handle_output) {
> >>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >>>> index c8f72850bc..53915947a7 100644
> >>>> --- a/include/hw/virtio/virtio.h
> >>>> +++ b/include/hw/virtio/virtio.h
> >>>> @@ -335,6 +335,7 @@ void virtio_queue_update_rings(VirtIODevice *vde=
v, int n);
> >>>>    void virtio_init_region_cache(VirtIODevice *vdev, int n);
> >>>>    void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)=
;
> >>>>    void virtio_queue_notify(VirtIODevice *vdev, int n);
> >>>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint32_=
t data);
> >>>>    uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
> >>>>    void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t =
vector);
> >>>>    int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
> >>>> --
> >>>> 2.39.3
> >>>>
> >>>
> >>
> >
>


