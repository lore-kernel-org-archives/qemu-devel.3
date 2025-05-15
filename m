Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F206DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRxB-00057T-FJ; Thu, 15 May 2025 02:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFRx7-00057B-P6
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uFRx3-0004rL-EU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 02:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747290015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2xmYv3z3UaoGCp9yXll/TGIYGDrCH4HhTigQeBcYRU=;
 b=c0RYRKJ+P09ujBP8Asp6u9d2+Foyl3v70UVDOZSH985f3I4ogIKxQcrAO0wAgZFU3Uxrn3
 yQsMy1AuBt5NPx9ff08UzNzetLjEhcep4U1diJabYWBLoGnbNbfDjTjOYY9s3J4DQRFHWw
 1qVWvbr0/MUbRLx1MtFmIIfAoo/tgQU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-eTHpfHG0Mh6OCc6beIz9nA-1; Thu, 15 May 2025 02:20:12 -0400
X-MC-Unique: eTHpfHG0Mh6OCc6beIz9nA-1
X-Mimecast-MFC-AGG-ID: eTHpfHG0Mh6OCc6beIz9nA_1747290012
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-30a80fe759bso986960a91.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 23:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747290011; x=1747894811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2xmYv3z3UaoGCp9yXll/TGIYGDrCH4HhTigQeBcYRU=;
 b=RRrYJkJGupiWtoNidEmIl/xxJvIUrf1V8pfLshZdK69h/fkFVCnM8ngNZi/J1ODqFA
 y5ciDkAQJeLRh2acl+ZDssuS0pEgWgbnoHeODoVfXRwGwlXrEIKU8AGto+TfrvERqX05
 vR36OD71lVYuFyV7craSCxXmkk0AoU1sgbW6QJWdN1XC00DoXnI2JwrdOJz54KcjA4cR
 d75uV2Sbk4zu/I6RcmYdRqLpzu/rdx0cCoVyuOMBeWzymOk/Twhs0l5KBH15YZT5fkao
 G65/0szSENTQ8GGmxppn0IYAQ45VAEL0I+YSzzt+YG8UPsW6GpsnTgrt2Xlqi6PNadbe
 INfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ZetCMOR6OzJvqob/L+8TofyATDhJmDAjMHK41MqoeAcGl2NIcIgRcsfZcSNKXD3ONH7mfix3Op1U@nongnu.org
X-Gm-Message-State: AOJu0YyhAtGThNq2kVZTn2EEXJCviLjB6auAZOCptNgNEpKk+cYZQ1+D
 8Qt6P3L8FNLGWCigDQai7uP5E5YBwaF0JhxO19XeC1oyJhZ1xgNMewYtFUOstdLVkYey6YDzx2P
 Kf3i846GjsQrXeRsDHnMHiwlS24iWqVvWO9oz8lSKLMh6HT82d4L03IVG+gzGJUYZj4sGBFHY/Z
 4M0elktGJ+zGR8Q38DCNOJ0UEyItQ=
X-Gm-Gg: ASbGncuo2a+/RSY3/0u5vQLGc0bONSmc+DMiNtbSPcOsbyTome1gKvAYbOuNMz56pG/
 bNHsxB9hJSgoUjp15K17/GWlbA+YwdqTY53IBpjnzOKA6pMTOlUsvEoDg4U6Gvk3w+8vo
X-Received: by 2002:a17:90a:d650:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-30e5178abaemr2558327a91.17.1747290011461; 
 Wed, 14 May 2025 23:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+CPktLBN5MuT56E9OwbfislfSiHW+W6PUKRSiHY5Qhxfyj90vyeGHoVwc6Tv2G8FNxOSUw/lqS1JT3WoGXFc=
X-Received: by 2002:a17:90a:d650:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-30e5178abaemr2558283a91.17.1747290010908; Wed, 14 May 2025
 23:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
 <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
In-Reply-To: <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 May 2025 08:19:34 +0200
X-Gm-Features: AX0GCFu3HthfabTp9d5O7RT6lPnGcjKy4ze-XJg4KmzgqKhB6FVvXnKhDjs7yvM
Message-ID: <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On Wed, May 14, 2025 at 8:22=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> Apologies, I haven't been in touch for a while. I have an update that
> I would like to give.
>
> On 4/16/25 12:50 PM, Eugenio Perez Martin wrote:
> > On Mon, Apr 14, 2025 at 11:20=E2=80=AFAM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> >>
> >> Hi,
> >>
> >> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
> >>> On Mon, Mar 24, 2025 at 2:59=E2=80=AFPM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> >>>> I managed to fix a few issues while testing this patch series.
> >>>> There is still one issue that I am unable to resolve. I thought
> >>>> I would send this patch series for review in case I have missed
> >>>> something.
> >>>>
> >>>> The issue is that this patch series does not work every time. I
> >>>> am able to ping L0 from L2 and vice versa via packed SVQ when it
> >>>> works.
> >>>
> >>> So we're on a very good track then!
> >>>
> >>>> When this doesn't work, both VMs throw a "Destination Host
> >>>> Unreachable" error. This is sometimes (not always) accompanied
> >>>> by the following kernel error (thrown by L2-kernel):
> >>>>
> >>>> virtio_net virtio1: output.0:id 1 is not a head!
> >>>>
> >>>
> >>> How many packets have been sent or received before hitting this? If
> >>> the answer to that is "the vq size", maybe there is a bug in the code
> >>> that handles the wraparound of the packed vq, as the used and avail
> >>> flags need to be twisted. You can count them in the SVQ code.
> >>
> >> I did a lot more testing. This issue is quite unpredictable in terms
> >> of the time at which it appears after booting L2. So far, it almost
> >> always appears after booting L2. Even when pinging works, this issue
> >> appears after several seconds of pinging.
> >>
> >
> > Maybe you can speed it up with ping -f?
>
> Thank you, I was able to run tests much faster with the -f option. So
> far I have noticed that the RX queue does not give problems. When all
> the descriptors are used it is able to wrap around without issues.
>
> >> The total number of svq descriptors varied in every test run. But in
> >> every case, all 256 indices were filled in the descriptor region for
> >> vq with vq_idx =3D 0. This is the RX vq, right?
> >
> > Right!
>
> The TX queue seems to be problematic. More on this below.
>
> >> This was filled while L2
> >> was booting. In the case when the ctrl vq is disabled, I am not sure
> >> what is responsible for filling the vqs in the data plane during
> >> booting.
> >>
> > The nested guest's driver fills the rx queue at startup. After that,
> > that nested guest kicks and SVQ receives the descriptors. It copies
> > the descriptors to the shadow virtqueue and then kicks L0 QEMU.
>
> Understood.
>
> >> =3D=3D=3D=3D=3D
> >> The issue is hit most frequently when the following command is run
> >> in L0:
> >> $ ip addr add 111.1.1.1/24 dev tap0
> >> $ ip link set tap0 up
> >>
> >> or, running the following in L2:
> >> # ip addr add 111.1.1.2/24 dev eth0
> >>
> >
> > I guess those are able to start the network, aren't they?
>
> Yes, that's correct.
>
> >> The other vq (vq_idx=3D1) is not filled completely before the issue is
> >> hit.
> >> I have been noting down the numbers and here is an example:
> >>
> >> 295 descriptors were added individually to the queues i.e., there were=
 no chains (vhost_svq_add_packed)
> >> |_ 256 additions in vq_idx =3D 0, all with unique ids
> >>       |---- 27 descriptors (ids 0 through 26) were received later from=
 the device (vhost_svq_get_buf_packed)
> >> |_ 39 additions in vq_idx =3D 1
> >>       |_ 13 descriptors had id =3D 0
> >>       |_ 26 descriptors had id =3D 1
> >>       |---- All descriptors were received at some point from the devic=
e (vhost_svq_get_buf_packed)
> >>
> >> There was one case in which vq_idx=3D0 had wrapped around. I verified
> >> that flags were set appropriately during the wrap (avail and used flag=
s
> >> were flipped as expected).
> >>
> >
> > Ok sounds like you're able to reach it before filling the queue. I'd
> > go for debugging notifications for this one then. More on this below.
> >
> >> =3D=3D=3D=3D=3D
> >> The next common situation where this issue is hit is during startup.
> >> Before L2 can finish booting successfully, this error is thrown:
> >>
> >> virtio_net virtio1: output.0:id 0 is not a head!
> >>
> >> 258 descriptors were added individually to the queues during startup (=
there were no chains) (vhost_svq_add_packed)
> >> |_ 256 additions in vq_idx =3D 0, all with unique ids
> >>      |---- None of them were received by the device (vhost_svq_get_buf=
_packed)
> >> |_ 2 additions in vq_idx =3D 1
> >>      |_ id =3D 0 in index 0
> >>      |_ id =3D 1 in index 1
> >>      |---- Both descriptors were received at some point during startup=
 from the device (vhost_svq_get_buf_packed)
> >>
> >> =3D=3D=3D=3D=3D
> >> Another case is after several seconds of pinging L0 from L2.
> >>
> >> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
> >>
> >
> > So the L2 guest sees a descriptor it has not made available
> > previously. This can be caused because SVQ returns the same descriptor
> > twice, or it doesn't fill the id or flags properly. It can also be
> > caused because we're not protecting the write ordering in the ring,
> > but I don't see anything obviously wrong by looking at the code.
> >
> >> 366 descriptors were added individually to the queues i.e., there were=
 no chains (vhost_svq_add_packed)
> >> |_ 289 additions in vq_idx =3D 0, wrap-around was observed with avail =
and used flags inverted for 33 descriptors
> >> |   |---- 40 descriptors (ids 0 through 39) were received from the dev=
ice (vhost_svq_get_buf_packed)
> >> |_ 77 additions in vq_idx =3D 1
> >>       |_ 76 descriptors had id =3D 0
> >>       |_ 1 descriptor had id =3D 1
> >>       |---- all 77 descriptors were received at some point from the de=
vice (vhost_svq_get_buf_packed)
> >>
> >> I am not entirely sure now if there's an issue in the packed vq
> >> implementation in QEMU or if this is being caused due to some sort
> >> of race condition in linux.
> >>
> >> "id is not a head" is being thrown because vq->packed.desc_state[id].d=
ata
> >> doesn't exist for the corresponding id in Linux [1]. But QEMU seems to=
 have
> >> stored some data for this id via vhost_svq_add() [2]. Linux sets the v=
alue
> >> of vq->packed.desc_state[id].data in its version of virtqueue_add_pack=
ed() [3].
> >>
> >
> > Let's keep debugging further. Can you trace the ids that the L2 kernel
> > makes available, and then the ones that it uses? At the same time, can
> > you trace the ids that the svq sees in vhost_svq_get_buf and the ones
> > that flushes? This allows us to check the set of available descriptors
> > at any given time.
> >
> In the linux kernel, I am printing which descriptor is received in which
> queue in drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_packed() [1].
> I see the following lines getting printed for the TX queue:
>
> [  192.101591] output.0 -> id: 0
> [  213.737417] output.0 -> id: 0
> [  213.738714] output.0 -> id: 1
> [  213.740093] output.0 -> id: 0
> [  213.741521] virtio_net virtio1: output.0:id 0 is not a head!
>

I find it particular that it is the first descriptor with id 1. Do you
have any other descriptor with id 1 previously? Does it fail
consistently with id 1?

You should have descriptors with id 1 and more in the rx queue and the
code should not be able to tell the difference, so it seems weird it
fails with tx. But who knows :).

> In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_add_packed(), I am
> printing the head_idx, id, len, flags and vq_idx. Just before the crash,
> the following lines are printed:
>
> head_idx: 157, id: 0, len: 122, flags: 32768, vq idx: 1
> head_idx: 158, id: 0, len: 122, flags: 32768, vq idx: 1
> head_idx: 159, id: 0, len: 66, flags: 32768, vq idx: 1
> head_idx: 160, id: 1, len: 102, flags: 32768, vq idx: 1
>
> In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf_packed(), =
I
> am printing the id, last_used index, used wrap counter and vq_idx. These
> are the lines just before the crash:
>
> id: 0, last_used: 158, used_wrap_counter: 0, vq idx: 1
> id: 0, last_used: 159, used_wrap_counter: 0, vq idx: 1
> id: 0, last_used: 160, used_wrap_counter: 0, vq idx: 1
> id: 1, last_used: 161, used_wrap_counter: 0, vq idx: 1
>
> In QEMU's hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush() [2], I am =
tracking
> the values of i and vq_idx in the outer do..while() loop as well as in th=
e inner
> while(true) loop. The value of i is used as the "idx" in virtqueue_fill()=
 [3] and
> as "count" in virtqueue_flush() [4]. Lines printed in each iteration of t=
he outer
> do...while loop are enclosed between "=3D=3D=3D" lines. These are the lin=
es just before
> the crash:
>

I'd print VirtQueueElement members too.

It seems you're super close to fix it :).

Thanks!

> =3D=3D=3D
> in_loop: i: 0, vq idx: 1
> in_loop: i: 1, vq idx: 1
> out_loop: i: 1, vq idx: 1
> =3D=3D=3D
> in_loop: i: 0, vq idx: 1
> in_loop: i: 1, vq idx: 1
> out_loop: i: 1, vq idx: 1
> =3D=3D=3D
> in_loop: i: 0, vq idx: 1
> in_loop: i: 1, vq idx: 1
> in_loop: i: 2, vq idx: 1
> out_loop: i: 2, vq idx: 1
> =3D=3D=3D
> in_loop: i: 0, vq idx: 1
> out_loop: i: 0, vq idx: 1
>
> I have only investigated which descriptors the kernel uses. I'll also che=
ck
> which descriptors are made available by the kernel. I'll let you know wha=
t I
> find.
>
> Thanks,
> Sahil
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1727
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-sh=
adow-virtqueue.c#L499
> [3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c=
#L1008
> [4] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/virtio.c=
#L1147
>


