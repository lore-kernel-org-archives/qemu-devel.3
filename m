Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0DFD3E18D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2mm4-0001Ss-N8; Mon, 21 Oct 2024 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2mm0-0001S3-O4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1t2mlw-0005a3-PX
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729495448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz3XoRA8CiUnPT5/iG27c6zwGEIIYU1oIqe/xKjzWe8=;
 b=J5ren0D7r0vL9OFpVWa+YkzxUJ/p3QWAYmyiANnBPWuuJs9woCc7+P35UVKR/xgk/OWOFU
 IFcUrUkylxHRf+p61zp+AUIErkApy3x0z1DBJCEY92xLTz1/LtesAkFRfcZQepEdW41jLZ
 H61Fi5P8ffPfD4Yr2L4bo5YAytRFJFw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-KlFNKLnwOo6EfLhs5asDBQ-1; Mon, 21 Oct 2024 03:24:06 -0400
X-MC-Unique: KlFNKLnwOo6EfLhs5asDBQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-71e6d31b3bdso4748563b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 00:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729495445; x=1730100245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz3XoRA8CiUnPT5/iG27c6zwGEIIYU1oIqe/xKjzWe8=;
 b=QdOtyHoGlNbVjqEfCE3Lu9rZHwpp3UGn0/Y8AuOw/ECzAzQJgMJz73aGJ7fppPO8ov
 PAZoLiE3pW+o2N0lSHXL7xqAIwx22eXubJOX31rJ5IVZDZURnnfOA8maBSrmW4lCsa5p
 cifMnb6oLiI7XlrhdK2g9Xh4Y6597CbRDJlDBOJ5QDMgAo7Spjwpi2GMB3Ej5pNW0PEC
 LcopaqNUNQ28noJUWdJPRqx6EU20Ycwlra1rGCOOtFwexYO3CtwZHyCfSgjKBO0YqlfJ
 4o6w0TuAz0x1rd4RR0SaLkwiDEOTWLEOWPEpZLEcMBibs3B3x7c4aAMILzvT+lBVN2is
 HJ2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKro/VLF9RDoQAnwNpd29e50dewmfd/BNUkqLkN8tCLDvzFU1N0cLM3BjycmZzg03ODmLgS5UrP7Dz@nongnu.org
X-Gm-Message-State: AOJu0Yx94UUUQXjgIBJZuRpRqlD7aX+t49Zjy/bftfG144vODx9ZC/hs
 yQSp0Qq/nW4xJbD7yb6/VHBCrhCWOaIjnXmzQ5nSrwBgy0nZ3bDB+8/Wu+OJ8Z1fWXRO9XV+Ozm
 lRy8KPV2FesGr1dt6UilLef+MGsJqnJ/9OqxDp5hjGEB44oQ+U4RAQMtKfHCbHdHsJkvr89S8Eq
 GeTSYOyFD2N2kImX/7z+hL5/27ioo=
X-Received: by 2002:a05:6a00:2314:b0:71d:f4ef:6b57 with SMTP id
 d2e1a72fcca58-71ea31e4c2emr14437915b3a.18.1729495445256; 
 Mon, 21 Oct 2024 00:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBA5molIgGFvoCDQS/6rEosg9fEcLzaQIJs6wMlbG2gVEN/ONE79eAPfk4fMvKbqJrBiJxy6WQFEnpZf9skMg=
X-Received: by 2002:a05:6a00:2314:b0:71d:f4ef:6b57 with SMTP id
 d2e1a72fcca58-71ea31e4c2emr14437891b3a.18.1729495444714; Mon, 21 Oct 2024
 00:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240604073755.1859-1-jasowang@redhat.com>
 <20240604073755.1859-9-jasowang@redhat.com>
 <a46a895a-4961-43fa-99d8-3bda7612bb9a@redhat.com>
 <14bcc2cf-f934-4aa3-8cab-21803a930adc@redhat.com>
 <CACGkMEs5P=Gmo4xTbwH1SPTjwjMoeAcK+fiVXQE0BRrRh-hAwg@mail.gmail.com>
 <d186fb3c-a036-4a20-a4e7-33119bd8b4b9@redhat.com>
 <60169858-3930-4490-b42d-d04117ab9abd@daynix.com>
 <bc493771-e507-4027-af76-f9a95e99b81d@redhat.com>
 <002f53e8-501e-4b4d-b1fc-67ec51e3a94f@daynix.com>
 <CACGkMEvfXDbYPX=itXWoNCzAR9tjYKf9DPNyuqsA_VQeXo9DXA@mail.gmail.com>
 <c4b14b61-8853-486c-9ac2-4b5728ecdf4c@daynix.com>
In-Reply-To: <c4b14b61-8853-486c-9ac2-4b5728ecdf4c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Oct 2024 15:23:52 +0800
Message-ID: <CACGkMEvQ8KtU6J6=SqR-t9T+sKMRPBeznGV96KqaV0P5n8MKMA@mail.gmail.com>
Subject: Re: [PULL 08/20] virtio-net: Add only one queue pair when realizing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Oct 19, 2024 at 8:38=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/18 13:50, Jason Wang wrote:
> > On Thu, Oct 17, 2024 at 5:42=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2024/10/17 18:17, Laurent Vivier wrote:
> >>> On 17/10/2024 11:07, Akihiko Odaki wrote:
> >>>> On 2024/10/17 16:32, Laurent Vivier wrote:
> >>>>> On 17/10/2024 08:59, Jason Wang wrote:
> >>>>>> On Mon, Oct 14, 2024 at 11:16=E2=80=AFPM Laurent Vivier <lvivier@r=
edhat.com>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 14/10/2024 10:30, Laurent Vivier wrote:
> >>>>>>>> Hi Akihiko,
> >>>>>>>>
> >>>>>>>> On 04/06/2024 09:37, Jason Wang wrote:
> >>>>>>>>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>>
> >>>>>>>>> Multiqueue usage is not negotiated yet when realizing. If more =
than
> >>>>>>>>> one queue is added and the guest never requests to enable
> >>>>>>>>> multiqueue,
> >>>>>>>>> the extra queues will not be deleted when unrealizing and leak.
> >>>>>>>>>
> >>>>>>>>> Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the
> >>>>>>>>> guest doesn't support
> >>>>>>>>> multiqueue")
> >>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>     hw/net/virtio-net.c | 4 +---
> >>>>>>>>>     1 file changed, 1 insertion(+), 3 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>>>>>>> index 3cee2ef3ac..a8db8bfd9c 100644
> >>>>>>>>> --- a/hw/net/virtio-net.c
> >>>>>>>>> +++ b/hw/net/virtio-net.c
> >>>>>>>>> @@ -3743,9 +3743,7 @@ static void
> >>>>>>>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >>>>>>>>>         n->net_conf.tx_queue_size =3D
> >>>>>>>>> MIN(virtio_net_max_tx_queue_size(n),
> >>>>>>>>>                                         n->net_conf.tx_queue_si=
ze);
> >>>>>>>>> -    for (i =3D 0; i < n->max_queue_pairs; i++) {
> >>>>>>>>> -        virtio_net_add_queue(n, i);
> >>>>>>>>> -    }
> >>>>>>>>> +    virtio_net_add_queue(n, 0);
> >>>>>>>>>         n->ctrl_vq =3D virtio_add_queue(vdev, 64,
> >>>>>>>>> virtio_net_handle_ctrl);
> >>>>>>>>>         qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> >>>>>>>>
> >>>>>>>> This change breaks virtio net migration when multiqueue is enabl=
ed.
> >>>>>>>>
> >>>>>>>> I think this is because virtqueues are half initialized after
> >>>>>>>> migration : they are
> >>>>>>>> initialized on guest side (kernel is using them) but not on QEMU
> >>>>>>>> side (realized has only
> >>>>>>>> initialized one). After migration, they are not initialized by t=
he
> >>>>>>>> call to
> >>>>>>>> virtio_net_set_multiqueue() from virtio_net_set_features() becau=
se
> >>>>>>>> virtio_get_num_queues()
> >>>>>>>> reports already n->max_queue_pairs as this value is coming from
> >>>>>>>> the source guest memory.
> >>>>>>>>
> >>>>>>>> I don't think we have a way to half-initialize a virtqueue (to
> >>>>>>>> initialize them only on
> >>>>>>>> QEMU side as they are already initialized on kernel side).
> >>>>>>>>
> >>>>>>>> I think this change should be reverted to fix the migration issu=
e.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Moreover, if I look in the code of virtio_load() and
> >>>>>>> virtio_add_queue() we can guess it's
> >>>>>>> not correct to migrate a virtqueue that is not initialized on the
> >>>>>>> destination side because
> >>>>>>> fields like 'vdev->vq[i].handle_output' or 'vdev->vq[i].used_elem=
s'
> >>>>>>> cannot be initialized
> >>>>>>> by virtio_load() and neither by virtio_add_queue() after
> >>>>>>> virtio_load() as fields like
> >>>>>>> 'vring.num' are already initialized by virtio_load().
> >>>>>>>
> >>>>>>> For instance, in virtio_load() we set:
> >>>>>>>
> >>>>>>>        for (i =3D 0; i < num; i++) {
> >>>>>>>            vdev->vq[i].vring.num =3D qemu_get_be32(f);
> >>>>>>>
> >>>>>>> and in virtio_add_queue() we search for the firt available queue =
to
> >>>>>>> add with:
> >>>>>>>
> >>>>>>>        for (i =3D 0; i < VIRTIO_QUEUE_MAX; i++) {
> >>>>>>>            if (vdev->vq[i].vring.num =3D=3D 0)
> >>>>>>>                break;
> >>>>>>>        }
> >>>>>>>
> >>>>>>> So virtio_add_queue() cannot be used to set:
> >>>>>>>
> >>>>>>>        vdev->vq[i].handle_output =3D handle_output;
> >>>>>>>        vdev->vq[i].used_elems =3D g_new0(VirtQueueElement, queue_=
size);
> >>>>>>>
> >>>>>>> Moreover it would overwrite fields already set by virtio_load():
> >>>>>>>
> >>>>>>>        vdev->vq[i].vring.num =3D queue_size;
> >>>>>>>        vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> >>>>>>>
> >>>>>>> It also explains why virtio_net_change_num_queue_pairs()
> >>>>>>> (indirectly called by
> >>>>>>> virtio_net_set_features()) doesn't update the queue pair numbers:
> >>>>>>> vring.num is already set
> >>>>>>> so it thinks there is no more queues to add.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> LAurent
> >>>>>>>
> >>>>>>
> >>>>>> I agree.
> >>>>>>
> >>>>>> Laurent, would you like to send a patch to revert this?
> >>>>>>
> >>>>>
> >>>>> Yes. I will also try to fix the leak in unrealize that the patch
> >>>>> wanted to fix initially.
> >>>>
> >>>> I wrote a fix so I will submit it once internal testing is done. You
> >>>> can see the change at:
> >>>> https://gitlab.com/akihiko.odaki/qemu-kvm/-/
> >>>> commit/22161221aa2d2031d7ad1be7701852083aa9109a
> >>>
> >>> It works fine for me but I don't know if it's a good idea to add queu=
es
> >>> while the state is loading.
> >>
> >> I couldn't come up with other options. The problem is that the number =
of
> >> queues added during realization does not match with the loaded state. =
We
> >> need to add queues after knowing the negotiated feature set and before
> >> loading the queue states to fix this problem.
> >>
> >> Reverting will add queues that are used when the multiqueue feature is
> >> negotiated so it will fix migration for such cases, but will also brea=
k
> >> the other cases (i.e., the multiqueue feature is not negotiated) as it
> >> adds too many queues.
> >>
> >> Regards,
> >> Akihiko Odaki
> >
> > I wonder if the following is much more simpler:
> >
> > 1) introducing booleans whether the queue has been deleted
> > 2) in unrelize, deleted only the queue that has not been deleted
>
> The memory leak problem is trivial to solve, but the problem with queue
> state loading is not. We need to ensure the number of queues are
> consistent with the number of loaded queues.
>
> We currently have too few queues if the multiqueue feature is
> negotiated, which results in queues partially initialized with the
> loaded state. Reverting will leave too many queues for the cases where
> the multiqueue feature is not negotiated, which is also problematic
> because virtio-net will reconfigure queues to reduce the number of
> queues and dispose loaded states.

I'm not sure I would get here, if those queues were not visible to
drivers. Why do we care?

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > ?
> >
> > Thanks
> >
> >>
> >>>
> >>> Jason, let me know which solution you prefer (revert or pre_load_queu=
es
> >>> helper).
> >>>
> >>> CC'ing MST
> >>>
> >>> Thanks,
> >>> Laurent
> >>>
> >>
> >
>


