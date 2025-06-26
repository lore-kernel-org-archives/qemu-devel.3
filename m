Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF89C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 07:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhBA-0002qZ-V9; Thu, 26 Jun 2025 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uUhB8-0002qM-Ud
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1uUhB6-0008Go-3S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 03:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750923465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSKuvqB7mWTkt/+jK/99JOKGjffVHFgCnc1sXQaEoeA=;
 b=iSFKcRAEEyKYYRqZzS7MIGcSYIVS/hpMFHez7EAPblP2HfIZNBYyvL+BVsBJIw6yTM7J6J
 563mNpVybRQ7MuWP85enu4oSOOsEvHCCWQPLehANjyM/KuEW8jWdX37stH4RZQ8LPMOnDe
 awQO4PLxD52vk0mF/Ej1iYRwxo3iTgY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-uta6IU3kN3-e5SXCmQIRaA-1; Thu, 26 Jun 2025 03:37:41 -0400
X-MC-Unique: uta6IU3kN3-e5SXCmQIRaA-1
X-Mimecast-MFC-AGG-ID: uta6IU3kN3-e5SXCmQIRaA_1750923460
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso717856a91.1
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 00:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750923460; x=1751528260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSKuvqB7mWTkt/+jK/99JOKGjffVHFgCnc1sXQaEoeA=;
 b=SXCSwofw1S9rvHTX2LYsCcjtlt/dMz+6LiVFEhQO/skKc3iuukvVt8QiLbXcNAsfha
 2Sdj2+iHuDMmjSbcAZb6cayhRCwqJgE9mDyUnXgD5xqV0Ca/10snxAVzTccJjEDEYBtL
 +3EPHHptxjdVXdE9SRpdHubTzbrXGiGi06wvl+9mlQMtUGXtevb75C7ZOPq/7+XUXydi
 SxBJETd3t2ZumiT0Yc4xqbV8O7xCexALBO5AYLcC3hwZjycoJFgU8met485KWTVyN9Ht
 hWERrPROo3wzawG7woYi1/nvynJzAboJHAQLqPqwg2MWWLo0P9ITKobKK+SKGt0zpP40
 l8Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWeAEnit7JacYjoeu5vO3ajL4o0qI5tD+odXRXSL5CKjKbG3zEuf3konjhsmJtnb1WIf0u7qCv86Gh@nongnu.org
X-Gm-Message-State: AOJu0YzD4pW8UJZfQx0U5d26reyJZD126hxO/UF9ogapNmh7mtVpQ4FW
 U5YYe5kHpEMtAPvNZcg8eJrwNvde7xEhEzrb1qzWF4ky6efcgKqTqXuFoU9xQxKxl0WvXLKj327
 SA6nj7VhvKQe1odIgggz+vvmT2dhBZmrQGMTyuHltcyiI0aCAu+gzkXx3PjNDRxjIdWGtECoaP4
 +yp55+GBxkg5uzTHxFADYEQ5yugCohF64=
X-Gm-Gg: ASbGnctPHtdoVLQloYT4CGz8vs8pT5fzLWZp8RS568E1ss0w6ZCcW24RQNUBi9V/mt5
 wCMnbswlV9l/OGrH0GNIuohS7T/EnRWrCtURVgurQ1fW8pvLXClwZ2AliwGEjhas7T/Ak7plcca
 BF4Q==
X-Received: by 2002:a17:90b:5484:b0:311:ad7f:3299 with SMTP id
 98e67ed59e1d1-315f268aa55mr7260940a91.25.1750923460311; 
 Thu, 26 Jun 2025 00:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDgoNbc6h72SgS09BiYB6PDuktOoBxJntnhUdBYbXCqZx8JehiaiAb51PLKdLsfoCF7KApIyd+IFkcq1aukAM=
X-Received: by 2002:a17:90b:5484:b0:311:ad7f:3299 with SMTP id
 98e67ed59e1d1-315f268aa55mr7260908a91.25.1750923459847; Thu, 26 Jun 2025
 00:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250324135929.74945-1-sahilcdq@proton.me>
 <CAJaqyWdXat-ugJHEcZyB5dbTuwGgvrO2+DdDd9YneS0=j-99NA@mail.gmail.com>
 <f1354888-74fb-44d8-8b48-c6a6a13db1a7@gmail.com>
 <CAJaqyWd=ssa5fkmV7Z=tzJvFeciC1P2U2pYheaSrZ2PZCaejHg@mail.gmail.com>
 <9a7c409f-cd7e-4906-812b-c8a4d77cfc4d@gmail.com>
 <CAJaqyWdme4GSTQr-mbGiWvV5Wu0Mnjc467ptWFoX2i3zHygf3g@mail.gmail.com>
 <97eafb50-492a-4571-92de-503fbc0d06fd@gmail.com>
In-Reply-To: <97eafb50-492a-4571-92de-503fbc0d06fd@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Jun 2025 09:37:02 +0200
X-Gm-Features: Ac12FXw7OHfPUqmtjQ_9W4XePqKQNmRz82r7e8pE15lQUVXLcRs8DVmjFCqchAg
Message-ID: <CAJaqyWeG2n=BhjNhQzMagjh5t-dgno6q-esVjzqrw8z3_sUrHA@mail.gmail.com>
Subject: Re: [RFC v5 0/7] Add packed format to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 sahilcdq@proton.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 26, 2025 at 7:16=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> It's been a while since I sent an email. I thought I would send an update
> to keep you in the loop.
>
> I have been comparing svq's mechanism for split and packed vqs hoping to
> find something that might lead to the source of the issue.
>
> One thing worth noting is that when I use kernel version 6.8.5 for testin=
g,
> the crashes are far more frequent. In kernel version 6.15.0-rc3+, it's mu=
ch
> harder to reproduce.
>
> On 5/15/25 11:49 AM, Eugenio Perez Martin wrote:
> > On Wed, May 14, 2025 at 8:22=E2=80=AFAM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> On 4/16/25 12:50 PM, Eugenio Perez Martin wrote:
> >>> On Mon, Apr 14, 2025 at 11:20=E2=80=AFAM Sahil Siddiq <icegambit91@gm=
ail.com> wrote:
> >>>> On 3/26/25 1:05 PM, Eugenio Perez Martin wrote:
> >>>>> On Mon, Mar 24, 2025 at 2:59=E2=80=AFPM Sahil Siddiq <icegambit91@g=
mail.com> wrote:
> >>>>>> I managed to fix a few issues while testing this patch series.
> >>>>>> There is still one issue that I am unable to resolve. I thought
> >>>>>> I would send this patch series for review in case I have missed
> >>>>>> something.
> >>>>>>
> >>>>>> The issue is that this patch series does not work every time. I
> >>>>>> am able to ping L0 from L2 and vice versa via packed SVQ when it
> >>>>>> works.
> >>>>>>
> >>>>>> When this doesn't work, both VMs throw a "Destination Host
> >>>>>> Unreachable" error. This is sometimes (not always) accompanied
> >>>>>> by the following kernel error (thrown by L2-kernel):
> >>>>>>
> >>>>>> virtio_net virtio1: output.0:id 1 is not a head!
> >>>>>>
> >>
> >> The TX queue seems to be problematic. More on this below.
>
> Sometimes RX also results in this crash, but it seems to be less frequent=
.
>
> >>>> This was filled while L2
> >>>> was booting. In the case when the ctrl vq is disabled, I am not sure
> >>>> what is responsible for filling the vqs in the data plane during
> >>>> booting.
> >>>>
> >>> The nested guest's driver fills the rx queue at startup. After that,
> >>> that nested guest kicks and SVQ receives the descriptors. It copies
> >>> the descriptors to the shadow virtqueue and then kicks L0 QEMU.
> >>
> >> Understood.
> >>
> >>>> The other vq (vq_idx=3D1) is not filled completely before the issue =
is
> >>>> hit.
> >>>> I have been noting down the numbers and here is an example:
> >>>>
> >>>> 295 descriptors were added individually to the queues i.e., there we=
re no chains (vhost_svq_add_packed)
> >>>> |_ 256 additions in vq_idx =3D 0, all with unique ids
> >>>>        |---- 27 descriptors (ids 0 through 26) were received later f=
rom the device (vhost_svq_get_buf_packed)
> >>>> |_ 39 additions in vq_idx =3D 1
> >>>>        |_ 13 descriptors had id =3D 0
> >>>>        |_ 26 descriptors had id =3D 1
> >>>>        |---- All descriptors were received at some point from the de=
vice (vhost_svq_get_buf_packed)
> >>>>
> >>>> There was one case in which vq_idx=3D0 had wrapped around. I verifie=
d
> >>>> that flags were set appropriately during the wrap (avail and used fl=
ags
> >>>> were flipped as expected).
> >>>>
> >>>
> >>> Ok sounds like you're able to reach it before filling the queue. I'd
> >>> go for debugging notifications for this one then. More on this below.
> >>>
> >>>> =3D=3D=3D=3D=3D
> >>>> The next common situation where this issue is hit is during startup.
> >>>> Before L2 can finish booting successfully, this error is thrown:
> >>>>
> >>>> virtio_net virtio1: output.0:id 0 is not a head!
> >>>>
> >>>> 258 descriptors were added individually to the queues during startup=
 (there were no chains) (vhost_svq_add_packed)
> >>>> |_ 256 additions in vq_idx =3D 0, all with unique ids
> >>>>       |---- None of them were received by the device (vhost_svq_get_=
buf_packed)
> >>>> |_ 2 additions in vq_idx =3D 1
> >>>>       |_ id =3D 0 in index 0
> >>>>       |_ id =3D 1 in index 1
> >>>>       |---- Both descriptors were received at some point during star=
tup from the device (vhost_svq_get_buf_packed)
> >>>>
> >>>> =3D=3D=3D=3D=3D
> >>>> Another case is after several seconds of pinging L0 from L2.
> >>>>
> >>>> [   99.034114] virtio_net virtio1: output.0:id 0 is not a head!
> >>>>
> >>>
> >>> So the L2 guest sees a descriptor it has not made available
> >>> previously. This can be caused because SVQ returns the same descripto=
r
> >>> twice, or it doesn't fill the id or flags properly. It can also be
> >>> caused because we're not protecting the write ordering in the ring,
> >>> but I don't see anything obviously wrong by looking at the code.
> >>>
> >>>> 366 descriptors were added individually to the queues i.e., there we=
re no chains (vhost_svq_add_packed)
> >>>> |_ 289 additions in vq_idx =3D 0, wrap-around was observed with avai=
l and used flags inverted for 33 descriptors
> >>>> |   |---- 40 descriptors (ids 0 through 39) were received from the d=
evice (vhost_svq_get_buf_packed)
> >>>> |_ 77 additions in vq_idx =3D 1
> >>>>        |_ 76 descriptors had id =3D 0
> >>>>        |_ 1 descriptor had id =3D 1
> >>>>        |---- all 77 descriptors were received at some point from the=
 device (vhost_svq_get_buf_packed)
> >>>>
> >>>>
> >>>> "id is not a head" is being thrown because vq->packed.desc_state[id]=
.data
> >>>> doesn't exist for the corresponding id in Linux [1]. But QEMU seems =
to have
> >>>> stored some data for this id via vhost_svq_add() [2]. Linux sets the=
 value
> >>>> of vq->packed.desc_state[id].data in its version of virtqueue_add_pa=
cked() [3].
> >>>>
> >>>
> >>> Let's keep debugging further. Can you trace the ids that the L2 kerne=
l
> >>> makes available, and then the ones that it uses? At the same time, ca=
n
> >>> you trace the ids that the svq sees in vhost_svq_get_buf and the ones
> >>> that flushes? This allows us to check the set of available descriptor=
s
> >>> at any given time.
> >>>
> >> In the linux kernel, I am printing which descriptor is received in whi=
ch
> >> queue in drivers/virtio/virtio_ring.c:virtqueue_get_buf_ctx_packed() [=
1].
> >> I see the following lines getting printed for the TX queue:
> >>
> >> [  192.101591] output.0 -> id: 0
> >> [  213.737417] output.0 -> id: 0
> >> [  213.738714] output.0 -> id: 1
> >> [  213.740093] output.0 -> id: 0
> >> [  213.741521] virtio_net virtio1: output.0:id 0 is not a head!
> >>
> >
> > I find it particular that it is the first descriptor with id 1. Do you
> > have any other descriptor with id 1 previously? Does it fail
> > consistently with id 1?
>
> Yes, the descriptor with id 1 was used previously in TX. It varies betwee=
n
> test runs. It has failed with other ids as well during some test runs. In
> one test run, it failed with id 17. I think there's an off-by-one bug her=
e.
> It crashes when it receives id 'x - 1' instead of 'x'.
> > You should have descriptors with id 1 and more in the rx queue and the
> > code should not be able to tell the difference, so it seems weird it
> > fails with tx. But who knows :).
> Oh, I thought it would be able to differentiate between them since it kno=
ws
> which vq->idx it's coming from.
>
> I think there's something off in the way "free_head", "last_used_idx" and
> "desc_next" values are calculated in vhost_svq_get_buf_packed() [1].
>
> In the latest test run, QEMU sent ids 0 through 28 to L2. L2 started rece=
iving
> them in order till id 8. At this point it received id 7 again for some re=
ason
> and then crashed.
>
> L2:
>
> [ 1641.129218] (prepare_packed) output.0 -> needs_kick: 1
> [ 1641.130621] (notify) output.0 -> function will return true
> [ 1641.132022] output.0 -> id: 0
> [ 1739.502358] input.0 -> id: 0
> [ 1739.503003] input.0 -> id: 1
> [ 1739.562024] input.0 -> id: 2
> [ 1739.578682] input.0 -> id: 3
> [ 1739.661913] input.0 -> id: 4
> [ 1739.828796] input.0 -> id: 5
> [ 1739.829789] input.0 -> id: 6
> [ 1740.078757] input.0 -> id: 7
> [ 1740.079749] input.0 -> id: 8
> [ 1740.080382] input.0 -> id: 7    <----Received 7 again
> [ 1740.081614] virtio_net virtio1: input.0:id 7 is not a head!
>
> QEMU logs (vhost_svq_get_buf_packed):
> ------
> size              : svq->vring.num
> len               : svq->vring_packed.vring.desc[last_used].len
> id                : svq->vring_packed.vring.desc[last_used].id
> num               : svq->desc_state[id].ndescs
> last_used_chain   : Result of vhost_svq_last_desc_of_chain(svq, num, id) =
[2]
> free_head         : svq->free_head
> last_used         : (last_used_idx & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR=
)) + num
> used_wrap_counter : !!(last_used_idx & (1 << VRING_PACKED_EVENT_F_WRAP_CT=
R))
> ------
>
> size: 256, len: 102, id: 0, vq idx: 0
> id: 0, last_used_chain: 0, free_head: 0, vq idx: 0
> num: 1, free_head: 0, id: 0, last_used: 1, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 74, id: 1, vq idx: 0
> id: 1, last_used_chain: 1, free_head: 0, vq idx: 0
> num: 1, free_head: 1, id: 1, last_used: 2, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 102, id: 2, vq idx: 0
> id: 2, last_used_chain: 2, free_head: 1, vq idx: 0
> num: 1, free_head: 2, id: 2, last_used: 3, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 82, id: 3, vq idx: 0
> id: 3, last_used_chain: 3, free_head: 2, vq idx: 0
> num: 1, free_head: 3, id: 3, last_used: 4, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 74, id: 4, vq idx: 0
> id: 4, last_used_chain: 4, free_head: 3, vq idx: 0
> num: 1, free_head: 4, id: 4, last_used: 5, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 82, id: 5, vq idx: 0
> id: 5, last_used_chain: 5, free_head: 4, vq idx: 0
> num: 1, free_head: 5, id: 5, last_used: 6, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 104, id: 6, vq idx: 0
> id: 6, last_used_chain: 6, free_head: 5, vq idx: 0
> num: 1, free_head: 6, id: 6, last_used: 7, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 82, id: 7, vq idx: 0
> id: 7, last_used_chain: 7, free_head: 6, vq idx: 0
> num: 1, free_head: 7, id: 7, last_used: 8, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 104, id: 8, vq idx: 0
> id: 8, last_used_chain: 8, free_head: 7, vq idx: 0
> num: 1, free_head: 8, id: 8, last_used: 9, used_wrap_counter: 1, vq idx: =
0
> ------
> size: 256, len: 98, id: 9, vq idx: 0
> id: 9, last_used_chain: 9, free_head: 8, vq idx: 0
> num: 1, free_head: 9, id: 9, last_used: 10, used_wrap_counter: 1, vq idx:=
 0
> ------
> size: 256, len: 104, id: 10, vq idx: 0
> id: 10, last_used_chain: 10, free_head: 9, vq idx: 0
> num: 1, free_head: 10, id: 10, last_used: 11, used_wrap_counter: 1, vq id=
x: 0
>
> I have a few more ideas of what to do. I'll let you know if I find someth=
ing
> else.
>

I cannot find anything just by inspection. What about printing all the
desc_state and all desc_next to check for incoherencies in each
svq_add and get_buf?


