Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B4AC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 09:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl3o6-000621-21; Fri, 15 Mar 2024 05:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rl3o5-00061k-15
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rl3no-0002Em-Oz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 05:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710494674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWzTJtK5+qwiIRrpV+ZanjEQ9IkwPbwutzuOE5g2BG0=;
 b=aruVsjWAi25i8lZWlRNrRTUf0XwVmomaNUjytORVSiZMg6OauoKZTY9GrzEbYyJY5Qs0OL
 +JKnk8jwpLhlugUq62w4plyozHA5nrvjPWZqAONt7MUkNMzbB1G/95XSzdtXk7O4iUQ+og
 5URaG+z8HMWDmxm+p0uxE4J/XlbZ+I8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-Mj5JkPziNOak4G3wsxr5xQ-1; Fri, 15 Mar 2024 05:24:32 -0400
X-MC-Unique: Mj5JkPziNOak4G3wsxr5xQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dc74ac7d015so2092708276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 02:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710494672; x=1711099472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWzTJtK5+qwiIRrpV+ZanjEQ9IkwPbwutzuOE5g2BG0=;
 b=mZ2mOi/5WFlyBPVZxUw1BSm4F0cHVbdB1r0swkrBXQl1cMHd+CBXUjfCdfNJmL6O1o
 vIjDa/kcbaqR81blaTwdwIUHG3DxizXsoA6oUIKr4AcTeVlkqMWsHAILEFE2RzJshO/F
 Tof8getGJbH4po5oPJ4xOC7eGw43F7HDi9MT/uTIcTmT5Ta/MN22zBIYi9L4Ydw6C3Jf
 BJmDIO8RJEKmv+7PtMCjDCSevf4mUuUUWYtHQy31XYY/BZkcalE9D69JSNYsW7reJq0+
 H+w5NzaRvPhjM1VI96ivCF1OvmsFBHk9yvGHANLItXj7ydd5VXo8E/4Wj+pA5jeOg14w
 4sKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs4nVxpr0UctBHp1EWy4qkZkLBso32doaZ6W9QHZp7tSIm4BmaMnfN1OuNrlrpbdDz87lu519mXoZP/wExU9x04+LebeE=
X-Gm-Message-State: AOJu0YybU1Zb13PDQrODSmtl48rflj2b4ez3Uanz+n+xRKKBAhFkK/LP
 m4o49e+oQmVRRMBT5cv/zTKMkc5eaD37JFc/yh+1PqyLGKfRsF1EJrYlPcW5MD7SioISjDHNKU5
 hnKgcT1E3pqGchJMPzGd6a/wVCju8lRvBJsvKxdYU3RSlT+y4Ss8SXHVnkrPaFIDQDviAbeVN1C
 XBBLYp4KlUZRoCLknBmNTR0P3rfLA=
X-Received: by 2002:a25:eb07:0:b0:dcc:623d:e475 with SMTP id
 d7-20020a25eb07000000b00dcc623de475mr3744504ybs.30.1710494672200; 
 Fri, 15 Mar 2024 02:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMFLYeYRO6dzL578Qnc5UDUuZtDFEe6QCt4Jg5JydcsCCCJqhcPyRq/IswfdyKddF3Sl7XTZbhMNwEPCDfPQ=
X-Received: by 2002:a25:eb07:0:b0:dcc:623d:e475 with SMTP id
 d7-20020a25eb07000000b00dcc623de475mr3744481ybs.30.1710494671889; Fri, 15 Mar
 2024 02:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240313115412.3334962-1-jonah.palmer@oracle.com>
 <20240313115412.3334962-2-jonah.palmer@oracle.com>
 <CACGkMEv6bRgrV_nvZK5Tb89CvTP5Kpyj4+na4Q9F=xBOJ6=8sw@mail.gmail.com>
 <b0e4a124-cced-4cbc-9f89-b8967f5a0b2c@oracle.com>
 <CAJaqyWcmzuY5R8hC-zwp_mEK40sYgwHU0vhewKziQLsY2EnpLg@mail.gmail.com>
 <f173f397-965f-43f9-9ce0-b417e86d6935@oracle.com>
 <CAJaqyWfspBXGw0WE2=HBuZiBJjyWTrMm2jyB4e0mP9UkixS4Mg@mail.gmail.com>
 <8b87682b-f22f-461e-bca7-1c80a6b9c760@oracle.com>
In-Reply-To: <8b87682b-f22f-461e-bca7-1c80a6b9c760@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 15 Mar 2024 10:23:55 +0100
Message-ID: <CAJaqyWdcnoTLrpEXeq8HxwbxxNxNvF2_Db9PwkaixdTU6tNcBQ@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 14, 2024 at 9:24=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/14/24 3:05 PM, Eugenio Perez Martin wrote:
> > On Thu, Mar 14, 2024 at 5:06=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >>
> >>
> >> On 3/14/24 10:55 AM, Eugenio Perez Martin wrote:
> >>> On Thu, Mar 14, 2024 at 1:16=E2=80=AFPM Jonah Palmer <jonah.palmer@or=
acle.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 3/13/24 11:01 PM, Jason Wang wrote:
> >>>>> On Wed, Mar 13, 2024 at 7:55=E2=80=AFPM Jonah Palmer <jonah.palmer@=
oracle.com> wrote:
> >>>>>>
> >>>>>> Add support to virtio-pci devices for handling the extra data sent
> >>>>>> from the driver to the device when the VIRTIO_F_NOTIFICATION_DATA
> >>>>>> transport feature has been negotiated.
> >>>>>>
> >>>>>> The extra data that's passed to the virtio-pci device when this
> >>>>>> feature is enabled varies depending on the device's virtqueue
> >>>>>> layout.
> >>>>>>
> >>>>>> In a split virtqueue layout, this data includes:
> >>>>>>     - upper 16 bits: shadow_avail_idx
> >>>>>>     - lower 16 bits: virtqueue index
> >>>>>>
> >>>>>> In a packed virtqueue layout, this data includes:
> >>>>>>     - upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
> >>>>>>     - lower 16 bits: virtqueue index
> >>>>>>
> >>>>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>>>> Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >>>>>> ---
> >>>>>>     hw/virtio/virtio-pci.c     | 10 +++++++---
> >>>>>>     hw/virtio/virtio.c         | 18 ++++++++++++++++++
> >>>>>>     include/hw/virtio/virtio.h |  1 +
> >>>>>>     3 files changed, 26 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >>>>>> index cb6940fc0e..0f5c3c3b2f 100644
> >>>>>> --- a/hw/virtio/virtio-pci.c
> >>>>>> +++ b/hw/virtio/virtio-pci.c
> >>>>>> @@ -384,7 +384,7 @@ static void virtio_ioport_write(void *opaque, =
uint32_t addr, uint32_t val)
> >>>>>>     {
> >>>>>>         VirtIOPCIProxy *proxy =3D opaque;
> >>>>>>         VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >>>>>> -    uint16_t vector;
> >>>>>> +    uint16_t vector, vq_idx;
> >>>>>>         hwaddr pa;
> >>>>>>
> >>>>>>         switch (addr) {
> >>>>>> @@ -408,8 +408,12 @@ static void virtio_ioport_write(void *opaque,=
 uint32_t addr, uint32_t val)
> >>>>>>                 vdev->queue_sel =3D val;
> >>>>>>             break;
> >>>>>>         case VIRTIO_PCI_QUEUE_NOTIFY:
> >>>>>> -        if (val < VIRTIO_QUEUE_MAX) {
> >>>>>> -            virtio_queue_notify(vdev, val);
> >>>>>> +        vq_idx =3D val;
> >>>>>> +        if (vq_idx < VIRTIO_QUEUE_MAX) {
> >>>>>> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATI=
ON_DATA)) {
> >>>>>> +                virtio_queue_set_shadow_avail_data(vdev, val);
> >>>>>> +            }
> >>>>>> +            virtio_queue_notify(vdev, vq_idx);
> >>>>>>             }
> >>>>>>             break;
> >>>>>>         case VIRTIO_PCI_STATUS:
> >>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>>>> index d229755eae..bcb9e09df0 100644
> >>>>>> --- a/hw/virtio/virtio.c
> >>>>>> +++ b/hw/virtio/virtio.c
> >>>>>> @@ -2255,6 +2255,24 @@ void virtio_queue_set_align(VirtIODevice *v=
dev, int n, int align)
> >>>>>>         }
> >>>>>>     }
> >>>>>>
> >>>>>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint3=
2_t data)
> >>>
> >>> Maybe I didn't explain well, but I think it is better to pass directl=
y
> >>> idx to a VirtQueue *. That way only the caller needs to check for a
> >>> valid vq idx, and (my understanding is) the virtio.c interface is
> >>> migrating to VirtQueue * use anyway.
> >>>
> >>
> >> Oh, are you saying to just pass in a VirtQueue *vq instead of
> >> VirtIODevice *vdev and get rid of the vq->vring.desc check in the func=
tion?
> >>
> >
> > No, that needs to be kept. I meant the access to vdev->vq[i] without
> > checking for a valid i.
> >
>
> Ahh okay I see what you mean. But I thought the following was checking
> for a valid VQ index:
>
> if (vq_idx < VIRTIO_QUEUE_MAX)
>

Right, but then the (potentially multiple) callers are responsible to
check for that. If we accept a VirtQueue *, it is assumed it is valid
already.

> Of course the virtio device may not have up to VIRTIO_QUEUE_MAX
> virtqueues, so maybe we should be checking for validity like this?
>
> if (vdev->vq[i].vring.num =3D=3D 0)
>

Actually yes, if you're going to send a new version I think checking
against num is better. Good find!

> Or was there something else you had in mind? Apologies for the confusion.
>

No worries, virtio.c is full of checks like that :).

Thanks!

> > You can get the VirtQueue in the caller with virtio_get_queue. Which
> > also does not check for a valid index, but that way is clearer the
> > caller needs to check it.
> >
>
> Roger, I'll use this instead for clarity.
>
> > As a side note, the check for desc !=3D 0 is widespread in QEMU but the
> > driver may use 0 address for desc, so it's not 100% valid. But to
> > change that now requires a deeper change out of the scope of this
> > series, so let's keep it for now :).
> >
> > Thanks! >
>
> I'll add it to the todo list =3D]
>
> >>>>>> +{
> >>>>>> +    /* Lower 16 bits is the virtqueue index */
> >>>>>> +    uint16_t i =3D data;
> >>>>>> +    VirtQueue *vq =3D &vdev->vq[i];
> >>>>>> +
> >>>>>> +    if (!vq->vring.desc) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>>> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >>>>>> +        vq->shadow_avail_wrap_counter =3D (data >> 31) & 0x1;
> >>>>>> +        vq->shadow_avail_idx =3D (data >> 16) & 0x7FFF;
> >>>>>> +    } else {
> >>>>>> +        vq->shadow_avail_idx =3D (data >> 16);
> >>>>>
> >>>>> Do we need to do a sanity check for this value?
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>> It can't hurt, right? What kind of check did you have in mind?
> >>>>
> >>>> if (vq->shadow_avail_idx >=3D vq->vring.num)
> >>>>
> >>>
> >>> I'm a little bit lost too. shadow_avail_idx can take all uint16_t
> >>> values. Maybe you meant checking for a valid vq index, Jason?
> >>>
> >>> Thanks!
> >>>
> >>>> Or something else?
> >>>>
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>>     static void virtio_queue_notify_vq(VirtQueue *vq)
> >>>>>>     {
> >>>>>>         if (vq->vring.desc && vq->handle_output) {
> >>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio=
.h
> >>>>>> index c8f72850bc..53915947a7 100644
> >>>>>> --- a/include/hw/virtio/virtio.h
> >>>>>> +++ b/include/hw/virtio/virtio.h
> >>>>>> @@ -335,6 +335,7 @@ void virtio_queue_update_rings(VirtIODevice *v=
dev, int n);
> >>>>>>     void virtio_init_region_cache(VirtIODevice *vdev, int n);
> >>>>>>     void virtio_queue_set_align(VirtIODevice *vdev, int n, int ali=
gn);
> >>>>>>     void virtio_queue_notify(VirtIODevice *vdev, int n);
> >>>>>> +void virtio_queue_set_shadow_avail_data(VirtIODevice *vdev, uint3=
2_t data);
> >>>>>>     uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
> >>>>>>     void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16=
_t vector);
> >>>>>>     int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int =
n,
> >>>>>> --
> >>>>>> 2.39.3
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


