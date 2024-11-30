Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F1D73605
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 12:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHMuZ-0001t4-CK; Sat, 30 Nov 2024 07:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tHMuV-0001sn-DD
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 07:49:22 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tHMuR-00064p-Ku
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 07:49:17 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e398484b60bso1500124276.1
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 04:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732970953; x=1733575753; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QQvv4UVdk4i78gOtbFUdxLqjFieG9PK4nXAck+NJ1QI=;
 b=TLAI1W2hE1SbfsDxtsl7a5ijATQaCmNc6a2pmfhYkxHfTK18zMr1hf81Olr3yLklHM
 rNfA37tBtcGPo+xXqIprb1vPfKW1iyaApoG6aMDLwIffPvzS8gZUb8UYKUZ3EYIbYf/e
 C7tMxdUil4SI78NXX35oYBmcr+KOes1+9UzolbNtDut70RQKPa+Bf92KbIkoYMFVFw4Q
 KiKzKKcrk5MKRtfOhDclb5uimKlTrDIZXWaAzfuTZjYKCOkYHXHNImXCZM+K6Peun8Ai
 BOx5pEtr1ncdHhCQeQAriqlCc6UsyegzzlYjf9Bd1+bfY5fUpGCxgmZ7IH7C7Rm3cKtQ
 3/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732970953; x=1733575753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQvv4UVdk4i78gOtbFUdxLqjFieG9PK4nXAck+NJ1QI=;
 b=Z6VO2S6k6v1YpNMHecWdL3VVXuarcOUl7EHMB+iinAsP+4WNxQkZx3llrxR24kPJN7
 /5pKj3Ysu7Em8PbVORm6b6qgr9XRbUaW7EaqVhcEAi4Ft0CYIxJx00/hXoFz8TNvGOfC
 GTi7T+C5ndtmriNEK1RkXVf1qbohttWN1VeouNUf4YJBRJq3gMn5RpM8xx25sqOOqkag
 H0A5MnqOQ85aLZMn38Gfx6cR11FMQNgKHOcRzJwSyL/e9i/eI5O8fVm79IYV51mIQ72v
 IDiECxYBkye17rP92nf53iOVGjYEIhSmiRr9tZrN337vcHg3G5IO7Vof6Gy5fDU/uAKG
 uJCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUZVSOHZc6JQ0LknFF1ZWl3R625/MioirfB62W0yU/cFXaHJ3pUpv5NgTfh0UpEuDT0L9Wo1Udgue9@nongnu.org
X-Gm-Message-State: AOJu0YzQxMwfWVTfd9XjnV2NrxRC34xPjq10BYS9n7gGJaBfh711yWKD
 GWthIdZtq13Trnan3BVrHQgwigdjmDvlFJLd8oa+/qnY6ZmmEgYB8cWYMb65YJePgrm8tqy9Q4G
 bVXxvQU4XVN7iZKxPM8+04xVlLbY=
X-Gm-Gg: ASbGncsy67b96eWsrDdby91+SCDHECbUzsEXt6HXdrHD7Mcx48Z7xczmNS3QOZPHbZD
 djzyF1y/fQCIdLV468BaljjmKuuOpzM3N
X-Google-Smtp-Source: AGHT+IFmK7qugSlPtl0YhWuofSHgjYuhTzyT2QtHbKRG8zlRDkaXXUEt1ge6LBMvhacEiFI+yJWiX5/4o3o2ju7JHC8=
X-Received: by 2002:a05:6902:2b07:b0:e2b:e0ba:d50 with SMTP id
 3f1490d57ef6-e395b870e93mr14067696276.5.1732970953637; Sat, 30 Nov 2024
 04:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
 <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
 <CAD-9bcdm+gupZQ91Q-JMjuPikVmfVhCdJuwq=ptfaipL7Peevg@mail.gmail.com>
 <a140606e-5f86-4e8b-a818-2db2493ab8a6@redhat.com>
In-Reply-To: <a140606e-5f86-4e8b-a818-2db2493ab8a6@redhat.com>
From: Wei Chen <weichenforschung@gmail.com>
Date: Sat, 30 Nov 2024 20:48:58 +0800
Message-ID: <CALOevrNCBHRKYOKcBftssHPOtoY1HVy3xz4DFfYZ4_e99hLrHg@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: David Hildenbrand <david@redhat.com>
Cc: zhi zhang <zzhangphd@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 yuval.yarom@rub.de, genkin@gatech.edu
Content-Type: multipart/alternative; boundary="000000000000190b0d062820be1c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=weichenforschung@gmail.com; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000190b0d062820be1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That doesn't explain the full story about MIGRATE_UNMOVABLE. I assume
> one precondition is missing in your explanation.

I have double-checked the source code. My initial description of the
process seems somewhat imprecise. vIOMMU does not convert pages to
UNMOVABLE during pinning, it is that pinning causes page faults, and the
fault handler allocates UNMOVABLE pages. (vaddr_get_pfns() calls
__gup_longterm_locked(), who then calls memalloc_pin_save(), and it
implicitly removes the __GFP_MOVABLE flag.)

Therefore, there is no requirement of ZONE_MOVABLE and MIGRATE_CMA.


Best regards,
Wei Chen

On Wed, Nov 27, 2024 at 5:37=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:

> On 27.11.24 03:00, zhi zhang wrote:
> >
> >
> > On Tue, Nov 26, 2024 at 11:52=E2=80=AFPM David Hildenbrand <david@redha=
t.com
> > <mailto:david@redhat.com>> wrote:
> >
> >     On 26.11.24 16:31, Wei Chen wrote:
> >      >   > How can you be sure (IOW trigger) that the system will store
> >      >   > "important data" like EPTs?
> >      >
> >      > We cannot, but we have designed the attack (see below) to improv=
e
> the
> >      > possibility.
> >      >
> >      >   > So is one magic bit really that for your experiments, one
> needs a
> >      >   > viommu?
> >      >
> >      > Admittedly the way we accomplish a VM escape is a bit arcane.
> >
> >     That's what I imagined :)
> >
> >      >
> >      > We require device passthrough because it pins the VM's memory
> >     down and
> >      > converts them to MIGRATE_UNMOVABLE.
> >
> >     Interesting, that's news to me. Can you share where GUP in the kern=
el
> >     would do that?
> >
> >
> > In /drivers/vfio/vfio_iommu_type1.c, there is a function called
> > vfio_iommu_type1_pin_pages where VM's memory is pinned down.
>
> That doesn't explain the full story about MIGRATE_UNMOVABLE. I assume
> one precondition is missing in your explanation.
>
> VFIO will call pin_user_pages_remote(FOLL_LONGTERM). Two cases:
>
> a) Memory is already allocated (which would mostly be MIGRATE_MOVABLE,
> because it's ordinary user memory). We'll simply longterm pin the memory
> without changing the migratetype.
>
> b) Memory is not allocated yet. We'll call
> faultin_page()->handle_mm_fault(). There is no FOLL_LONGTERM
> special-casing, so you'll mostly get MIGRATE_MOVABLE.
>
>
> Now, there is one corner case: we disallow longterm pinning on
> ZONE_MOVABLE and MIGRATE_CMA. In case our user space allocation ended up
> on there, check_and_migrate_movable_pages() would detect that the memory
> resides on ZONE_MOVABLE or MIGRATE_CMA, and allocate a destination page
> in migrate_longterm_unpinnable_folios() using "GFP_USER | __GFP_NOWARN".
>
> So I assume one precondition is that your hypervisor has at least some
> ZONE_MOVABLE or CMA memory? Otherwise I don't see how you would reliably
> get MIGRATE_UNMOVABLE.
>
> >
> >
> >      > Hotplugged memory will also be
> >      > converted to MIGRATE_UNMOVABLE.
> >
> >     But that's in the VM? Because we don't hotplug memory in the
> hypervisor.
> >
> >
> > Yes, the virtio-mem driver in the VM is modified to actively release
> > memory vulnerable to Rowhammer.
>
> I think I now understand that statement: Memory to-be-hotplugged to the
> VM will be migrated to MIGRATE_UNMOVABLE during longterm pinning, if it
> resides on ZONE_MOVABLE or MIGRATE_CMA.
>
> > For more details, would you be interested in reading our paper? It was
> > recently submitted to ASPLOS for publication and we are happy to share
> > it with you.
>
> Yes, absolutely! Please send a private mail :)
>
> --
> Cheers,
>
> David / dhildenb
>
>

--000000000000190b0d062820be1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; That doesn&#39;t explain the full st=
ory about MIGRATE_UNMOVABLE. I assume<br>&gt; one precondition is missing i=
n your explanation.<br><br>I have double-checked the source code. My initia=
l description of the<br>process seems somewhat imprecise. vIOMMU does not c=
onvert pages to<br>UNMOVABLE during pinning, it is that pinning causes page=
 faults, and the<br>fault handler allocates UNMOVABLE pages. (vaddr_get_pfn=
s() calls<br>__gup_longterm_locked(), who then calls memalloc_pin_save(), a=
nd it<br>implicitly removes the __GFP_MOVABLE flag.)<br><br>Therefore, ther=
e is no requirement of ZONE_MOVABLE and MIGRATE_CMA.</div><div dir=3D"ltr">=
<br></div><div dir=3D"ltr"><br></div><div>Best regards,</div><div>Wei Chen<=
br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Nov 27, 2024 at 5:37=E2=80=AFPM David Hild=
enbrand &lt;<a href=3D"mailto:david@redhat.com">david@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 27.11.24=
 03:00, zhi zhang wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Tue, Nov 26, 2024 at 11:52=E2=80=AFPM David Hildenbrand &lt;<a href=
=3D"mailto:david@redhat.com" target=3D"_blank">david@redhat.com</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:david@redhat.com" target=3D"_blank">david=
@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 26.11.24 16:31, Wei Chen wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0&gt; How can you be sure (IOW tri=
gger) that the system will store<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0&gt; &quot;important data&quot; l=
ike EPTs?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; We cannot, but we have designed the attack (s=
ee below) to improve the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; possibility.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0&gt; So is one magic bit really t=
hat for your experiments, one needs a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0&gt; viommu?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Admittedly the way we accomplish a VM escape =
is a bit arcane.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0That&#39;s what I imagined :)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; We require device passthrough because it pins=
 the VM&#39;s memory<br>
&gt;=C2=A0 =C2=A0 =C2=A0down and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; converts them to MIGRATE_UNMOVABLE.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Interesting, that&#39;s news to me. Can you share w=
here GUP in the kernel<br>
&gt;=C2=A0 =C2=A0 =C2=A0would do that?<br>
&gt; <br>
&gt; <br>
&gt; In /drivers/vfio/vfio_iommu_type1.c, there is a function called <br>
&gt; vfio_iommu_type1_pin_pages where VM&#39;s memory is pinned down.<br>
<br>
That doesn&#39;t explain the full story about MIGRATE_UNMOVABLE. I assume <=
br>
one precondition is missing in your explanation.<br>
<br>
VFIO will call pin_user_pages_remote(FOLL_LONGTERM). Two cases:<br>
<br>
a) Memory is already allocated (which would mostly be MIGRATE_MOVABLE, <br>
because it&#39;s ordinary user memory). We&#39;ll simply longterm pin the m=
emory <br>
without changing the migratetype.<br>
<br>
b) Memory is not allocated yet. We&#39;ll call <br>
faultin_page()-&gt;handle_mm_fault(). There is no FOLL_LONGTERM <br>
special-casing, so you&#39;ll mostly get MIGRATE_MOVABLE.<br>
<br>
<br>
Now, there is one corner case: we disallow longterm pinning on <br>
ZONE_MOVABLE and MIGRATE_CMA. In case our user space allocation ended up <b=
r>
on there, check_and_migrate_movable_pages() would detect that the memory <b=
r>
resides on ZONE_MOVABLE or MIGRATE_CMA, and allocate a destination page <br=
>
in migrate_longterm_unpinnable_folios() using &quot;GFP_USER | __GFP_NOWARN=
&quot;.<br>
<br>
So I assume one precondition is that your hypervisor has at least some <br>
ZONE_MOVABLE or CMA memory? Otherwise I don&#39;t see how you would reliabl=
y <br>
get MIGRATE_UNMOVABLE.<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Hotplugged memory will also be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; converted to MIGRATE_UNMOVABLE.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0But that&#39;s in the VM? Because we don&#39;t hotp=
lug memory in the hypervisor.<br>
&gt; <br>
&gt; <br>
&gt; Yes, the virtio-mem driver in the VM is modified to actively release <=
br>
&gt; memory vulnerable to Rowhammer.<br>
<br>
I think I now understand that statement: Memory to-be-hotplugged to the <br=
>
VM will be migrated to MIGRATE_UNMOVABLE during longterm pinning, if it <br=
>
resides on ZONE_MOVABLE or MIGRATE_CMA.<br>
<br>
&gt; For more details, would you be interested in reading our paper? It was=
 <br>
&gt; recently submitted to ASPLOS for publication and we are happy to share=
 <br>
&gt; it with you.<br>
<br>
Yes, absolutely! Please send a private mail :)<br>
<br>
-- <br>
Cheers,<br>
<br>
David / dhildenb<br>
<br>
</blockquote></div></div>

--000000000000190b0d062820be1c--

