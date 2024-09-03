Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D9FCD3420
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 08:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slP8x-00012i-H0; Tue, 03 Sep 2024 04:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slP8v-0000w0-QM
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slP8s-0000VS-BR
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 04:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725353041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NWGRnSdaKzAnbzb4vBNahdh2YcKCKRUprcYNlaOWHts=;
 b=GWiOtRH0/cYLiGtgYumxB7MhNG9GiQ7VW7NcZrvKUJendSxEE1UqUeT9SRm+g5SyhXJRns
 wvKh12xOkMikC+2XgoVTkE9+9MFMvXsoGMSFAZUbDGnwfDtuJaw2PdwwyiGWJhgVps0bUB
 3uoxiT4wpTnDtq8wMt6BpWVLN7iDIkY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-L_qQAKQTMCS2xcB2t4JRIg-1; Tue, 03 Sep 2024 04:42:47 -0400
X-MC-Unique: L_qQAKQTMCS2xcB2t4JRIg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d8a1e91afaso2082027a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 01:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352966; x=1725957766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NWGRnSdaKzAnbzb4vBNahdh2YcKCKRUprcYNlaOWHts=;
 b=dOnURXeei/2J0/WYDy3r16Dcok0t1R9qij4WBNwHFDMlPPQanOJlvHSym3sLiJrK6k
 G7J4bk4gY07qlHqk0nxwSM5rUQVVjfbNe/TLZOcXgo86x1Aefiy9o2endGGiPH7E2OiO
 0u2ay8nCvs6yET+SoZDg98rQ+gRKRQLkebwKPnfqjE96RvJPqEC0FnWq3otBD9FB2X1Z
 cp8Nlg+8bBa7TkE5XSr8qUDzJ0yK2DhiL3APRduOpaRXOWqil+38kfUFpUXAX0IYrm9a
 ntO0Giet7OTx8s1ycHkKBSKkZ6YR/DyO3r4DgQpaeDLNnhrJ00Gx/+cfBKJ7+jgwHWl6
 fSXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuZ01IXa6w6ylesAz4jkLhyyALWkWauD0nFZB1CW68rBE/AiOhH2f8IeNC9ANYvZBQA6DliOSrwZSc@nongnu.org
X-Gm-Message-State: AOJu0YykerKH/VWE6DwbMYVyZyTvy3aem6ArZwVZNtvgHCwk7Zuz3I3O
 e3cPQ2f4Bd087gSP0WFP4aV06Mqb7HNIILGshMy8OPIEXlPPegzNrlL6qh80diHpHR28ipXPh9u
 W1ftrrrEGzmdwRqbaw8hTn6pZMT+dnX/aK4v4CyQGlSlTztD2k7FkFu2nP1j4cnGaKGCS1Eog8S
 QN/VmeqIEBqhScgHOQJ6nOnhyM6kk=
X-Received: by 2002:a17:90a:d70f:b0:2d3:dacd:d94f with SMTP id
 98e67ed59e1d1-2d8904ed6cbmr8344413a91.13.1725352966299; 
 Tue, 03 Sep 2024 01:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHvuo7IYyazkj08hFJENWry1F5z0DgF/1hH+JiTi5ymnZFLRqxCcqcbOmEnTZmDeBaUsYhcCniZ5GKz5GYjrM=
X-Received: by 2002:a17:90a:d70f:b0:2d3:dacd:d94f with SMTP id
 98e67ed59e1d1-2d8904ed6cbmr8344393a91.13.1725352965796; Tue, 03 Sep 2024
 01:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
In-Reply-To: <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 3 Sep 2024 10:42:34 +0200
Message-ID: <CADSE00K=8SCghVxbP+7Awy6tGHtP3JyYy-5MAAMjrpv+bVC=6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: David Stevens <stevensd@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 qemu-devel@nongnu.org, 
 jasowang@redhat.com, david@redhat.com, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a38d210621330a70"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000a38d210621330a70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

Sorry, I have been a bit disconnected from this thread as I was on
vacations and then had to switch tasks for a while.

I will try to go through all comments and address them for the first
non-RFC drop of this patch series.

But I was discussing with some colleagues on this. So turns out rust-vmm's
vhost-user-gpu will potentially use
this soon, and a rust-vmm/vhost patch have been already posted:
https://github.com/rust-vmm/vhost/pull/251.
So I think it may make sense to:
1. Split the vhost-user documentation patch once settled. Since it is taken
as the official spec,
    having it upstreamed independently of the implementation will benefit
other projects to
    work/integrate their own code.
2. Split READ_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.
    If I remember correctly, this addresses a virtio-fs specific issue,
that will not
    impact either virtio-gpu nor virtio-media, or any other. So it may make
sense
    to separate them so that one does not stall the other. I will try to
have both
    integrated in the mid term.

WDYT?

BR,
Albert.

On Tue, Jul 16, 2024 at 3:21=E2=80=AFAM David Stevens <stevensd@chromium.or=
g> wrote:

> On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wr=
ote:
> > > >
> > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > > > crosvm a couple of years ago.
> > > >
> > > > David, I'd be particularly interested for your thoughts on the
> MEM_READ
> > > > and MEM_WRITE commands, since as far as I know crosvm doesn't
> implement
> > > > anything like that.  The discussion leading to those being added
> starts
> > > > here:
> > > >
> > > >
> https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.c=
om/
> > > >
> > > > It would be great if this could be standardised between QEMU and
> crosvm
> > > > (and therefore have a clearer path toward being implemented in othe=
r
> VMMs)!
> > >
> > > Setting aside vhost-user for a moment, the DAX example given by Stefa=
n
> > > won't work in crosvm today.
> > >
> > > Is universal access to virtio shared memory regions actually mandated
> > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > seems reasonable enough, but what about virtio-pmem to virtio-blk?
> > > What about screenshotting a framebuffer in virtio-gpu shared memory t=
o
> > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable in =
a
> > > virtualized environment. But what about when you have real hardware
> > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > doesn't seem like that would be easy to solve.
> >
> > Yes, it can work for physical devices if allowed by host configuration.
> > E.g. VFIO supports that I think. Don't think VDPA does.
>
> I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> rather than a MUST.
>
> > > For what it's worth, my interpretation of the target scenario:
> > >
> > > > Other backends don't see these mappings. If the guest submits a vri=
ng
> > > > descriptor referencing a mapping to another backend, then that
> backend
> > > > won't be able to access this memory
> > >
> > > is that it's omitting how the implementation is reconciled with
> > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > >
> > > > References into shared memory regions are represented as offsets fr=
om
> > > > the beginning of the region instead of absolute memory addresses.
> Offsets
> > > > are used both for references between structures stored within share=
d
> > > > memory and for requests placed in virtqueues that refer to shared
> memory.
> > >
> > > My interpretation of that statement is that putting raw guest physica=
l
> > > addresses corresponding to virtio shared memory regions into a vring
> > > is a driver spec violation.
> > >
> > > -David
> >
> > This really applies within device I think. Should be clarified ...
>
> You mean that a virtio device can use absolute memory addresses for
> other devices' shared memory regions, but it can't use absolute memory
> addresses for its own shared memory regions? That's a rather strange
> requirement. Or is the statement simply giving an addressing strategy
> that device type specifications are free to ignore?
>
> -David
>
>

--000000000000a38d210621330a70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div>Hello all,</div><div><br></div><div>Sorry, I =
have been a bit disconnected from this thread as I was on vacations and the=
n had to switch tasks for a while.</div><div><br></div><div>I will try to g=
o through all comments and address them for the first non-RFC drop of this =
patch series.</div><div><br></div><div>But I was discussing with some colle=
agues on this. So turns out rust-vmm&#39;s vhost-user-gpu will potentially =
use</div><div>this soon, and a rust-vmm/vhost patch have been already poste=
d:=C2=A0<a href=3D"https://github.com/rust-vmm/vhost/pull/251">https://gith=
ub.com/rust-vmm/vhost/pull/251</a>.</div><div>So I think it may make sense =
to:</div><div>1. Split the vhost-user documentation patch once settled. Sin=
ce it is taken as the official spec,</div><div>=C2=A0 =C2=A0 having it upst=
reamed independently of the implementation will benefit other projects to</=
div><div>=C2=A0 =C2=A0 work/integrate their own code.</div><div>2. Split RE=
AD_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.</div><div>=C2=A0 =C2=
=A0 If I remember correctly, this addresses a virtio-fs specific issue, tha=
t will not</div><div>=C2=A0 =C2=A0 impact either virtio-gpu nor virtio-medi=
a, or any other. So it may make sense</div><div>=C2=A0 =C2=A0 to separate t=
hem so that one does not stall the other. I will try to have both</div><div=
>=C2=A0 =C2=A0 integrated in the mid term.</div><div><br></div><div>WDYT?</=
div></div></div><br><div>BR,</div><div>Albert.</div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 16, 2024 at=
 3:21=E2=80=AFAM David Stevens &lt;<a href=3D"mailto:stevensd@chromium.org"=
>stevensd@chromium.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Ts=
irkin &lt;<a href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:<br>
&gt; &gt; On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross &lt;<a href=
=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UN=
MAP in<br>
&gt; &gt; &gt; crosvm a couple of years ago.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; David, I&#39;d be particularly interested for your thoughts =
on the MEM_READ<br>
&gt; &gt; &gt; and MEM_WRITE commands, since as far as I know crosvm doesn&=
#39;t implement<br>
&gt; &gt; &gt; anything like that.=C2=A0 The discussion leading to those be=
ing added starts<br>
&gt; &gt; &gt; here:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"https://lore.kernel.org/qemu-devel/20240604185416=
.GB90471@fedora.redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://l=
ore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.com/</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It would be great if this could be standardised between QEMU=
 and crosvm<br>
&gt; &gt; &gt; (and therefore have a clearer path toward being implemented =
in other VMMs)!<br>
&gt; &gt;<br>
&gt; &gt; Setting aside vhost-user for a moment, the DAX example given by S=
tefan<br>
&gt; &gt; won&#39;t work in crosvm today.<br>
&gt; &gt;<br>
&gt; &gt; Is universal access to virtio shared memory regions actually mand=
ated<br>
&gt; &gt; by the virtio spec? Copying from virtiofs DAX to virtiofs sharing=
<br>
&gt; &gt; seems reasonable enough, but what about virtio-pmem to virtio-blk=
?<br>
&gt; &gt; What about screenshotting a framebuffer in virtio-gpu shared memo=
ry to<br>
&gt; &gt; virtio-scsi? I guess with some plumbing in the VMM, it&#39;s solv=
able in a<br>
&gt; &gt; virtualized environment. But what about when you have real hardwa=
re<br>
&gt; &gt; that speaks virtio involved? That&#39;s outside my wheelhouse, bu=
t it<br>
&gt; &gt; doesn&#39;t seem like that would be easy to solve.<br>
&gt;<br>
&gt; Yes, it can work for physical devices if allowed by host configuration=
.<br>
&gt; E.g. VFIO supports that I think. Don&#39;t think VDPA does.<br>
<br>
I&#39;m sure it can work, but that sounds more like a SHOULD (MAY?),<br>
rather than a MUST.<br>
<br>
&gt; &gt; For what it&#39;s worth, my interpretation of the target scenario=
:<br>
&gt; &gt;<br>
&gt; &gt; &gt; Other backends don&#39;t see these mappings. If the guest su=
bmits a vring<br>
&gt; &gt; &gt; descriptor referencing a mapping to another backend, then th=
at backend<br>
&gt; &gt; &gt; won&#39;t be able to access this memory<br>
&gt; &gt;<br>
&gt; &gt; is that it&#39;s omitting how the implementation is reconciled wi=
th<br>
&gt; &gt; section 2.10.1 of v1.3 of the virtio spec, which states that:<br>
&gt; &gt;<br>
&gt; &gt; &gt; References into shared memory regions are represented as off=
sets from<br>
&gt; &gt; &gt; the beginning of the region instead of absolute memory addre=
sses. Offsets<br>
&gt; &gt; &gt; are used both for references between structures stored withi=
n shared<br>
&gt; &gt; &gt; memory and for requests placed in virtqueues that refer to s=
hared memory.<br>
&gt; &gt;<br>
&gt; &gt; My interpretation of that statement is that putting raw guest phy=
sical<br>
&gt; &gt; addresses corresponding to virtio shared memory regions into a vr=
ing<br>
&gt; &gt; is a driver spec violation.<br>
&gt; &gt;<br>
&gt; &gt; -David<br>
&gt;<br>
&gt; This really applies within device I think. Should be clarified ...<br>
<br>
You mean that a virtio device can use absolute memory addresses for<br>
other devices&#39; shared memory regions, but it can&#39;t use absolute mem=
ory<br>
addresses for its own shared memory regions? That&#39;s a rather strange<br=
>
requirement. Or is the statement simply giving an addressing strategy<br>
that device type specifications are free to ignore?<br>
<br>
-David<br>
<br>
</blockquote></div>

--000000000000a38d210621330a70--


