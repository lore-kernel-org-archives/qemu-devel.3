Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595BECE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smT13-0000Vd-M3; Fri, 06 Sep 2024 03:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1smT0x-0008Iz-Ua
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1smT0v-0004gK-57
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725606249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x5RTK1huD43fN5baFLwza8FggnO+af1rUC5T79L8KGA=;
 b=JKYzJRKDZ6Ch4n6CoAbzNlmJVTq+HV9AEJ5rAx5KtkYY7blG4Jdq76cpTfi3Lm6uUjIeh0
 mljK2k6Nykj3T/xBbGgQOKOzCl7bhYuQQ/TrC0IRG9G9HGcbEGAeq4XPAjidMgD0C4zkpk
 3ThT1C9XhYA31g8MjrF5CORaJo59t9k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-tBRmshYsMiG_t9jNIMIdGQ-1; Fri, 06 Sep 2024 03:04:08 -0400
X-MC-Unique: tBRmshYsMiG_t9jNIMIdGQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3dee94f0dcdso1815036b6e.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725606247; x=1726211047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5RTK1huD43fN5baFLwza8FggnO+af1rUC5T79L8KGA=;
 b=Hn8TQH+K8TY7G05wx7XrtXBMiKUCVbwZ5wGK8EAGCrHEPcOL5pELDJL55JnXKZGDPY
 /WQ5DSqmwltBkRmr76GJI+2w7Qv/XEioJMqA1UVCNKwG4efTenyWe1p8CKyD6fPn/7DP
 P+oNJ1dtwY4lZz8A7Ma4dOrrB81oYaQNGR8sKa7dSEPmN/fLhim4oHTwQsEfHUiB1d0O
 eAex3LyZkGuLPaUg95KHtEJFam6PTBCEkerGr9Y+5JJfrK4cvGL6IvcLwcqV2Z4V+J5P
 lESyxrIy424yywHIBy8en0T3RurWFczrGOf9gu/aMpEOwk5PoFb+7yWTNzD8RPMk2r64
 h+0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKHanhhmBL3MzUTUZHXsn3Zzcr7oTybjjKPogy+wOudIQroofP+0+nXbn55OTNfQVyrvtXORlj0WM/@nongnu.org
X-Gm-Message-State: AOJu0Yxpwna7uNd46INUS8YKyjyVG8U82aSDLhvMzjpRZYeLDkKUbKl6
 gcuckTVEosctmlP260XaYUZE/1whalYm3SS7Mwk+jI2QQFuMC0WZH0sXeNpU+fyTUg5F4715dKE
 2SzNfLRlDH3ch8HraZGfg09P6GKCEN6bcWzpTMOMwUCHx8qOdpx3bPeeoOL2DMI9euc42MjSefZ
 Nn4ZQj472NqXr4cjXOqKdnfJXCiKQ=
X-Received: by 2002:a05:6870:b411:b0:260:3bdb:93a8 with SMTP id
 586e51a60fabf-27790319b9emr27075458fac.41.1725606247597; 
 Fri, 06 Sep 2024 00:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd3QIHhRAPeDYz32L99flJm8Zy7FGJH/MBhohshwgZuHH+kfHlNppmscnKAKxa3sUJtE+XTbPbT+TbC+eiWN4=
X-Received: by 2002:a05:6870:b411:b0:260:3bdb:93a8 with SMTP id
 586e51a60fabf-27790319b9emr27075429fac.41.1725606247048; Fri, 06 Sep 2024
 00:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
 <20240712014407-mutt-send-email-mst@kernel.org>
 <CAD=HUj7iDbwnojq5a68s6B3S8z4vtpCa=B=9+ZBVYZV50zG+5g@mail.gmail.com>
 <CADSE00K=8SCghVxbP+7Awy6tGHtP3JyYy-5MAAMjrpv+bVC=6Q@mail.gmail.com>
 <20240905163937.GE1922502@fedora>
In-Reply-To: <20240905163937.GE1922502@fedora>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Sep 2024 09:03:55 +0200
Message-ID: <CADSE00KZF7hOLouH0b4NX9frCmsM7ZBjn70LEbh_HyrKcHF-5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Stevens <stevensd@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alyssa Ross <hi@alyssa.is>, 
 qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, slp@redhat.com, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000060bdf806216e03fb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000060bdf806216e03fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:39=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:

> On Tue, Sep 03, 2024 at 10:42:34AM +0200, Albert Esteve wrote:
> > Hello all,
> >
> > Sorry, I have been a bit disconnected from this thread as I was on
> > vacations and then had to switch tasks for a while.
> >
> > I will try to go through all comments and address them for the first
> > non-RFC drop of this patch series.
> >
> > But I was discussing with some colleagues on this. So turns out
> rust-vmm's
> > vhost-user-gpu will potentially use
> > this soon, and a rust-vmm/vhost patch have been already posted:
> > https://github.com/rust-vmm/vhost/pull/251.
> > So I think it may make sense to:
> > 1. Split the vhost-user documentation patch once settled. Since it is
> taken
> > as the official spec,
> >     having it upstreamed independently of the implementation will benef=
it
> > other projects to
> >     work/integrate their own code.
> > 2. Split READ_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.
> >     If I remember correctly, this addresses a virtio-fs specific issue,
> > that will not
> >     impact either virtio-gpu nor virtio-media, or any other.
>
> This is an architectural issue that arises from exposing VIRTIO Shared
> Memory Regions in vhost-user. It was first seen with Linux virtiofs but
> it could happen with other devices and/or guest operating systems.
>
> Any VIRTIO Shared Memory Region that can be mmapped into Linux userspace
> may trigger this issue. Userspace may write(2) to an O_DIRECT file with
> the mmap as the source. The vhost-user-blk device will not be able to
> access the source device's VIRTIO Shared Memory Region and will fail.
>
> > So it may make
> > sense
> >     to separate them so that one does not stall the other. I will try t=
o
> > have both
> >     integrated in the mid term.
>
> If READ_/WRITE_MEM is a pain to implement (I think it is in the
> vhost-user back-end, even though I've been a proponent of it), then
> another way to deal with this issue is to specify that upon receiving
> MAP/UNMAP messages, the vhost-user front-end must update the vhost-user
> memory tables of all other vhost-user devices. That way vhost-user
> devices will be able to access VIRTIO Shared Memory Regions mapped by
> other devices.
>
> Implementing this in QEMU should be much easier than implementing
> READ_/WRITE_MEM support in device back-ends.
>
> This will be slow and scale poorly but performance is only a problem for
> devices that frequently MAP/UNMAP like virtiofs. Will virtio-gpu and
> virtio-media use MAP/UNMAP often at runtime? They might be able to get
> away with this simple solution.
>
> I'd be happy with that. If someone wants to make virtiofs DAX faster,
> they can implement READ/WRITE_MEM or another solution later, but let's
> at least make things correct from the start.
>

I agree. I want it to be correct first. If you agree on splitting the spec
bits from this
patch I'm already happy. I suggested splitting READ_/WRITE_MEM messages
because I thought that it was a virtiofs-specific issue.

The alternative that you proposed is interesting. I'll take it into
account. But I
feel I prefer to go for the better solution, and if I get too entangled,
then switch
to the easier implementation.

I think we could do this in 2 patches:
1. Split the documentation bits for SHMEM_MAP/_UNMAP. The
    implementation for these messages will go into the second patch.
2. The implementation patch: keep going for the time being with
     READ_/WRITE_MEM support. And the documentation for that
    is kept it within this patch. This way if we switch to the frontend
    updating vhost-user memory table, we weren't set in any specific
    solution if patch 1 has been already merged.

BR,
Albert.


>
> Stefan
>
> >
> > WDYT?
> >
> > BR,
> > Albert.
> >
> > On Tue, Jul 16, 2024 at 3:21=E2=80=AFAM David Stevens <stevensd@chromiu=
m.org>
> wrote:
> >
> > > On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com>
> wrote:
> > > >
> > > > On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> > > > > On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross <hi@alyssa.is=
> wrote:
> > > > > >
> > > > > > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP
> in
> > > > > > crosvm a couple of years ago.
> > > > > >
> > > > > > David, I'd be particularly interested for your thoughts on the
> > > MEM_READ
> > > > > > and MEM_WRITE commands, since as far as I know crosvm doesn't
> > > implement
> > > > > > anything like that.  The discussion leading to those being adde=
d
> > > starts
> > > > > > here:
> > > > > >
> > > > > >
> > >
> https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.c=
om/
> > > > > >
> > > > > > It would be great if this could be standardised between QEMU an=
d
> > > crosvm
> > > > > > (and therefore have a clearer path toward being implemented in
> other
> > > VMMs)!
> > > > >
> > > > > Setting aside vhost-user for a moment, the DAX example given by
> Stefan
> > > > > won't work in crosvm today.
> > > > >
> > > > > Is universal access to virtio shared memory regions actually
> mandated
> > > > > by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> > > > > seems reasonable enough, but what about virtio-pmem to virtio-blk=
?
> > > > > What about screenshotting a framebuffer in virtio-gpu shared
> memory to
> > > > > virtio-scsi? I guess with some plumbing in the VMM, it's solvable
> in a
> > > > > virtualized environment. But what about when you have real hardwa=
re
> > > > > that speaks virtio involved? That's outside my wheelhouse, but it
> > > > > doesn't seem like that would be easy to solve.
> > > >
> > > > Yes, it can work for physical devices if allowed by host
> configuration.
> > > > E.g. VFIO supports that I think. Don't think VDPA does.
> > >
> > > I'm sure it can work, but that sounds more like a SHOULD (MAY?),
> > > rather than a MUST.
> > >
> > > > > For what it's worth, my interpretation of the target scenario:
> > > > >
> > > > > > Other backends don't see these mappings. If the guest submits a
> vring
> > > > > > descriptor referencing a mapping to another backend, then that
> > > backend
> > > > > > won't be able to access this memory
> > > > >
> > > > > is that it's omitting how the implementation is reconciled with
> > > > > section 2.10.1 of v1.3 of the virtio spec, which states that:
> > > > >
> > > > > > References into shared memory regions are represented as offset=
s
> from
> > > > > > the beginning of the region instead of absolute memory addresse=
s.
> > > Offsets
> > > > > > are used both for references between structures stored within
> shared
> > > > > > memory and for requests placed in virtqueues that refer to shar=
ed
> > > memory.
> > > > >
> > > > > My interpretation of that statement is that putting raw guest
> physical
> > > > > addresses corresponding to virtio shared memory regions into a
> vring
> > > > > is a driver spec violation.
> > > > >
> > > > > -David
> > > >
> > > > This really applies within device I think. Should be clarified ...
> > >
> > > You mean that a virtio device can use absolute memory addresses for
> > > other devices' shared memory regions, but it can't use absolute memor=
y
> > > addresses for its own shared memory regions? That's a rather strange
> > > requirement. Or is the statement simply giving an addressing strategy
> > > that device type specifications are free to ignore?
> > >
> > > -David
> > >
> > >
>

--00000000000060bdf806216e03fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 5, 2024 at 6:39=
=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stef=
anha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On Tue, Sep 03, 2024 at 10:42:34AM +0200, Albert Esteve wrot=
e:<br>
&gt; Hello all,<br>
&gt; <br>
&gt; Sorry, I have been a bit disconnected from this thread as I was on<br>
&gt; vacations and then had to switch tasks for a while.<br>
&gt; <br>
&gt; I will try to go through all comments and address them for the first<b=
r>
&gt; non-RFC drop of this patch series.<br>
&gt; <br>
&gt; But I was discussing with some colleagues on this. So turns out rust-v=
mm&#39;s<br>
&gt; vhost-user-gpu will potentially use<br>
&gt; this soon, and a rust-vmm/vhost patch have been already posted:<br>
&gt; <a href=3D"https://github.com/rust-vmm/vhost/pull/251" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/rust-vmm/vhost/pull/251</a>.<br>
&gt; So I think it may make sense to:<br>
&gt; 1. Split the vhost-user documentation patch once settled. Since it is =
taken<br>
&gt; as the official spec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0having it upstreamed independently of the implement=
ation will benefit<br>
&gt; other projects to<br>
&gt;=C2=A0 =C2=A0 =C2=A0work/integrate their own code.<br>
&gt; 2. Split READ_/WRITE_MEM messages from SHMEM_MAP/_UNMAP patches.<br>
&gt;=C2=A0 =C2=A0 =C2=A0If I remember correctly, this addresses a virtio-fs=
 specific issue,<br>
&gt; that will not<br>
&gt;=C2=A0 =C2=A0 =C2=A0impact either virtio-gpu nor virtio-media, or any o=
ther.<br>
<br>
This is an architectural issue that arises from exposing VIRTIO Shared<br>
Memory Regions in vhost-user. It was first seen with Linux virtiofs but<br>
it could happen with other devices and/or guest operating systems.<br>
<br>
Any VIRTIO Shared Memory Region that can be mmapped into Linux userspace<br=
>
may trigger this issue. Userspace may write(2) to an O_DIRECT file with<br>
the mmap as the source. The vhost-user-blk device will not be able to<br>
access the source device&#39;s VIRTIO Shared Memory Region and will fail.<b=
r>
<br>
&gt; So it may make<br>
&gt; sense<br>
&gt;=C2=A0 =C2=A0 =C2=A0to separate them so that one does not stall the oth=
er. I will try to<br>
&gt; have both<br>
&gt;=C2=A0 =C2=A0 =C2=A0integrated in the mid term.<br>
<br>
If READ_/WRITE_MEM is a pain to implement (I think it is in the<br>
vhost-user back-end, even though I&#39;ve been a proponent of it), then<br>
another way to deal with this issue is to specify that upon receiving<br>
MAP/UNMAP messages, the vhost-user front-end must update the vhost-user<br>
memory tables of all other vhost-user devices. That way vhost-user<br>
devices will be able to access VIRTIO Shared Memory Regions mapped by<br>
other devices.<br>
<br>
Implementing this in QEMU should be much easier than implementing<br>
READ_/WRITE_MEM support in device back-ends.<br>
<br>
This will be slow and scale poorly but performance is only a problem for<br=
>
devices that frequently MAP/UNMAP like virtiofs. Will virtio-gpu and<br>
virtio-media use MAP/UNMAP often at runtime? They might be able to get<br>
away with this simple solution.<br>
<br>
I&#39;d be happy with that. If someone wants to make virtiofs DAX faster,<b=
r>
they can implement READ/WRITE_MEM or another solution later, but let&#39;s<=
br>
at least make things correct from the start.<br></blockquote><div><br></div=
><div>I agree. I want it to be correct first. If you agree on splitting the=
 spec bits from this</div><div>patch I&#39;m already happy. I suggested spl=
itting READ_/WRITE_MEM messages</div><div>because I thought that it was a v=
irtiofs-specific=C2=A0issue.</div><div><br></div><div>The alternative that =
you proposed is interesting. I&#39;ll take it into account. But I</div><div=
>feel I prefer to go for the better solution, and if I get too entangled, t=
hen switch</div><div>to the easier implementation.</div><div><br></div><div=
>I think we could do this in 2 patches:</div><div>1. Split the documentatio=
n bits for SHMEM_MAP/_UNMAP. The</div><div>=C2=A0 =C2=A0 implementation for=
 these messages will go into the second patch.</div><div>2. The implementat=
ion patch:=C2=A0keep going for the time being with</div><div>=C2=A0 =C2=A0 =
=C2=A0READ_/WRITE_MEM support. And the documentation for that</div><div>=C2=
=A0 =C2=A0 is kept it within this patch. This way if we switch to the front=
end</div><div>=C2=A0 =C2=A0 updating vhost-user memory table, we weren&#39;=
t set in any specific</div><div>=C2=A0 =C2=A0 solution if patch 1 has been =
already merged.</div><div><br></div><div>BR,</div><div>Albert.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Stefan<br>
<br>
&gt; <br>
&gt; WDYT?<br>
&gt; <br>
&gt; BR,<br>
&gt; Albert.<br>
&gt; <br>
&gt; On Tue, Jul 16, 2024 at 3:21=E2=80=AFAM David Stevens &lt;<a href=3D"m=
ailto:stevensd@chromium.org" target=3D"_blank">stevensd@chromium.org</a>&gt=
; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, Jul 12, 2024 at 2:47=E2=80=AFPM Michael S. Tsirkin &lt;<a=
 href=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wr=
ote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrot=
e:<br>
&gt; &gt; &gt; &gt; On Thu, Jul 11, 2024 at 7:56=E2=80=AFPM Alyssa Ross &lt=
;<a href=3D"mailto:hi@alyssa.is" target=3D"_blank">hi@alyssa.is</a>&gt; wro=
te:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Adding David Stevens, who implemented SHMEM_MAP an=
d SHMEM_UNMAP in<br>
&gt; &gt; &gt; &gt; &gt; crosvm a couple of years ago.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; David, I&#39;d be particularly interested for your=
 thoughts on the<br>
&gt; &gt; MEM_READ<br>
&gt; &gt; &gt; &gt; &gt; and MEM_WRITE commands, since as far as I know cro=
svm doesn&#39;t<br>
&gt; &gt; implement<br>
&gt; &gt; &gt; &gt; &gt; anything like that.=C2=A0 The discussion leading t=
o those being added<br>
&gt; &gt; starts<br>
&gt; &gt; &gt; &gt; &gt; here:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; <a href=3D"https://lore.kernel.org/qemu-devel/20240604185416.GB90=
471@fedora.redhat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.com/</a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; It would be great if this could be standardised be=
tween QEMU and<br>
&gt; &gt; crosvm<br>
&gt; &gt; &gt; &gt; &gt; (and therefore have a clearer path toward being im=
plemented in other<br>
&gt; &gt; VMMs)!<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Setting aside vhost-user for a moment, the DAX example =
given by Stefan<br>
&gt; &gt; &gt; &gt; won&#39;t work in crosvm today.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Is universal access to virtio shared memory regions act=
ually mandated<br>
&gt; &gt; &gt; &gt; by the virtio spec? Copying from virtiofs DAX to virtio=
fs sharing<br>
&gt; &gt; &gt; &gt; seems reasonable enough, but what about virtio-pmem to =
virtio-blk?<br>
&gt; &gt; &gt; &gt; What about screenshotting a framebuffer in virtio-gpu s=
hared memory to<br>
&gt; &gt; &gt; &gt; virtio-scsi? I guess with some plumbing in the VMM, it&=
#39;s solvable in a<br>
&gt; &gt; &gt; &gt; virtualized environment. But what about when you have r=
eal hardware<br>
&gt; &gt; &gt; &gt; that speaks virtio involved? That&#39;s outside my whee=
lhouse, but it<br>
&gt; &gt; &gt; &gt; doesn&#39;t seem like that would be easy to solve.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Yes, it can work for physical devices if allowed by host con=
figuration.<br>
&gt; &gt; &gt; E.g. VFIO supports that I think. Don&#39;t think VDPA does.<=
br>
&gt; &gt;<br>
&gt; &gt; I&#39;m sure it can work, but that sounds more like a SHOULD (MAY=
?),<br>
&gt; &gt; rather than a MUST.<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; For what it&#39;s worth, my interpretation of the targe=
t scenario:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Other backends don&#39;t see these mappings. If th=
e guest submits a vring<br>
&gt; &gt; &gt; &gt; &gt; descriptor referencing a mapping to another backen=
d, then that<br>
&gt; &gt; backend<br>
&gt; &gt; &gt; &gt; &gt; won&#39;t be able to access this memory<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; is that it&#39;s omitting how the implementation is rec=
onciled with<br>
&gt; &gt; &gt; &gt; section 2.10.1 of v1.3 of the virtio spec, which states=
 that:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; References into shared memory regions are represen=
ted as offsets from<br>
&gt; &gt; &gt; &gt; &gt; the beginning of the region instead of absolute me=
mory addresses.<br>
&gt; &gt; Offsets<br>
&gt; &gt; &gt; &gt; &gt; are used both for references between structures st=
ored within shared<br>
&gt; &gt; &gt; &gt; &gt; memory and for requests placed in virtqueues that =
refer to shared<br>
&gt; &gt; memory.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; My interpretation of that statement is that putting raw=
 guest physical<br>
&gt; &gt; &gt; &gt; addresses corresponding to virtio shared memory regions=
 into a vring<br>
&gt; &gt; &gt; &gt; is a driver spec violation.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -David<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This really applies within device I think. Should be clarifi=
ed ...<br>
&gt; &gt;<br>
&gt; &gt; You mean that a virtio device can use absolute memory addresses f=
or<br>
&gt; &gt; other devices&#39; shared memory regions, but it can&#39;t use ab=
solute memory<br>
&gt; &gt; addresses for its own shared memory regions? That&#39;s a rather =
strange<br>
&gt; &gt; requirement. Or is the statement simply giving an addressing stra=
tegy<br>
&gt; &gt; that device type specifications are free to ignore?<br>
&gt; &gt;<br>
&gt; &gt; -David<br>
&gt; &gt;<br>
&gt; &gt;<br>
</blockquote></div></div>

--00000000000060bdf806216e03fb--


