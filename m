Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7B410F9318
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 02:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7lmS-0004x0-VK; Tue, 31 Mar 2026 22:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w7lmQ-0004ws-3u
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w7lmM-0000Cs-HL
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775012279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=asxeo19H1qBD4/4Q0Gh14DbH0MXP4IhFQPwWnAfNNow=;
 b=H1nZGoDxXfw1EnDaLYXslwtMvpI6o3HTBJ7C+0SzEyCfnBqMJHPwEBumZc1BnwZjp1VyIL
 aThoehukHg5zj81cZcZnX/eIryao9oq0vDh3OoiCc/zBxTwpjPNtkl/mFiTgS2iC4P9isb
 k6scNMcWUIATRytzZ5KW8d1JzCV+wII=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-cDEcBjNbPDS-LYPURzooiA-1; Tue, 31 Mar 2026 22:57:57 -0400
X-MC-Unique: cDEcBjNbPDS-LYPURzooiA-1
X-Mimecast-MFC-AGG-ID: cDEcBjNbPDS-LYPURzooiA_1775012277
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94ad0ada31bso821543241.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 19:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775012277; cv=none;
 d=google.com; s=arc-20240605;
 b=ei+j74DPJxTS6Y/koyWc/c3SkskmTtEi5cxQfBiEZaAUXTF3Ot/LJf5fCODrh7tWdQ
 9GgpPVn7xyFF0RuPRWAmDiPNyLAV7ASnjIwy0320EX0Uqfqd72pQApI8gYKHWaqwSZ6S
 5JxNvRLLV0mQB2D5lH0KQBJlUBJeu6cHn7QBGn3IMQf3aytoaY2NjbDLkybHWcKuTrFw
 Njfjcxp8XqoxNDIc9RtlRUKBiL3Qc2IqD8khdjCLGKqo2riAv0G5MszgUFu14Sy/uIYQ
 fooIQIv8/StjuPegxQj66CxTKPwS8VgO6HWU5TQcRHMiRr3h/68kV4Sj7S/b+ABHGeT/
 sqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=asxeo19H1qBD4/4Q0Gh14DbH0MXP4IhFQPwWnAfNNow=;
 fh=kncqmOg+2mOgRAHPbQqwLcriEDSiO9ivGv8H7CV5uXc=;
 b=cpUxcPqxFQVhbHICYU/lgoZTbGxk0VcNC5nrJwVE6+vLAFpMeF45NBGvi8Vzir+upn
 szDuGy1I525/I1vqQKqWWJyK8sxjl6R9Fr9KMrqw+tMBR9P70+eH3SZFFLs5rejiItHp
 pzpb3X9SlR54UHU3FoK0OizvqKVIJquEAl7W9Zri4bEIESa2UeNwpGa/cvuod0HvqT5Z
 sCLcDJbT55RKSNXMQ3djvCQ54/GFTnlv+ybSb6k6cWNKXom4TsgEg9pimiWLwIHsD3iw
 v72A5G3CunI0/pz7CfdwdZQBv7v5SbsNCibgllUt56Eo25/5cc53Eu4ZudvhIzGZLkd2
 kodg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775012277; x=1775617077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=asxeo19H1qBD4/4Q0Gh14DbH0MXP4IhFQPwWnAfNNow=;
 b=N9kuAK0USNG+6ySzWe5tEK65J9GQyOk1pcEs7mQKTS2oPjmrNVLJbGQC+cvVY5CQUY
 jBy8Us+CfvU3FJ10NGUe6EGjKYn4j/NLlnHt0GQlYTKLrQoyyCapbEkXHk1KqlA5OVQT
 AU5oE5dtooXFGaQmBGe0o1X4ZQkqJ5t0iMWqfxwWFCBnsJsBxnotOs10f3GnNd8uqUrL
 9mNGDGpskAOnkrusXFbBI8nqyq01SHaW+TacOP3Lj/DIAyE504LRnPcrJ3IqPi9OKx7b
 IAbMc8es3DIPrD4WbELm4OZbWH6+f16SvWOMhU+/0K0QtSBhEo2BSTQ6HsN2YmyOXmjM
 c03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775012277; x=1775617077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asxeo19H1qBD4/4Q0Gh14DbH0MXP4IhFQPwWnAfNNow=;
 b=Tm9zwnLrJdMJ2qyhmuTKzqF+WgQQi7Qx/Yp6VANqm9hrgr1iEaTsibR4Rnv9OsreL3
 CqBZ7FuiCh2jegORrqSojwGq0YWcmNvYtgffmw9n1+hdmXhr6pyl5e3bXRG4CsOwSg7f
 u1J+SvBPuGVfuGt6QUTCtyDpxFxGUqHzLPuPPKTfylhI2MOcu3Hro1CR41p30OiDjPfO
 SHMPaupwWSRHyYDWBoUDyRb1NXXoIUBqUxZVqg0uvMLCjSCczXsXxCpibhZUDge4UCR2
 tAIRCoByak0zk3kDt6VdrPvEKZGydKg314jrEC1RTxYDCxTlceiVrwDxxdDERUNiM8HJ
 Tu9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoGRSdk2crC4+Og2zDBwM5seB0nCJErVrKJS9u4RtQ4A5gMKteep+oE07MRUOURgQ9nfblQbHv+hUM@nongnu.org
X-Gm-Message-State: AOJu0YwY2ySv3Y2LlBCgVKSMQfiUJHWErXSvRm98RLT6wFdXhg2QI2UK
 hqh2vbUukcEh+O3Jbz8kNjoM/LUGOLcXxOKOd9AcY8TI6pehOJ9beXW1K93LIBEjeUSqufrteQv
 K7ffcZkb4deNqrsndb3pTmJjOc6BkbeDU18+MRizdCCzWv5WJoU3KQB3NRoHdLpdb6r8s8hNOcA
 B8WSkFbqjX44P4xZwvh0ctYkMaYwwCW08=
X-Gm-Gg: ATEYQzyOb/3V8eQg6113WZxGiaM0kZ63mf3+qby2cS9QEc1UOM5jnlYaajqZtlUQ3mn
 bPeCHzY0E7o0DjPF7MXzr9ypXxNdYQGdByI1sy/wRV9FxGQYtLqb8F/nGyx+zcjeVa13/fvE1U4
 DXbRiN8m900bEgv4vznlIEoKRhrNso5sIMheW5Kq4L5EVHP2MYzzrI8SNjUjx68GqaFOyHGLhwk
 cVPgVM=
X-Received: by 2002:a05:6102:f07:b0:600:1547:967c with SMTP id
 ada2fe7eead31-6054fefb5famr2284742137.16.1775012276974; 
 Tue, 31 Mar 2026 19:57:56 -0700 (PDT)
X-Received: by 2002:a05:6102:f07:b0:600:1547:967c with SMTP id
 ada2fe7eead31-6054fefb5famr2284738137.16.1775012276595; Tue, 31 Mar 2026
 19:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260330090944.1008027-1-lulu@redhat.com>
 <CACGkMEvAVEYzw29h8BZLz3BD859pKmCkYG8xdowdpUrNv05gQQ@mail.gmail.com>
In-Reply-To: <CACGkMEvAVEYzw29h8BZLz3BD859pKmCkYG8xdowdpUrNv05gQQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 1 Apr 2026 10:57:07 +0800
X-Gm-Features: AQROBzAvt4DfYjGG17y3x4o_G2sTEKNaPUpcey_p-j48uEQjNdiqoAYNG6dRidU
Message-ID: <CACLfguXV_rrtgsJqoaAWvEo4gWw-UT0xmGm-8k=TGTN2Yi=jsA@mail.gmail.com>
Subject: Re: [RFC v3 0/7] net/filter: Add AF_PACKET support for vhost-net
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, zhangckid@gmail.com, lizhijian@fujitsu.com, 
 jmarcin@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000038070e064e5d40ec"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000038070e064e5d40ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 10:16=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:

> On Mon, Mar 30, 2026 at 5:09=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Hi, All
> >
> > This series adds AF_PACKET-based capture and injection datapath
> > support for the vhost TAP device in filter
> >
> > Example Usage(not change with exist upstream code)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Primary VM (mirror incoming packets to secondary via chardev socket):
> >
> >   -netdev tap,id=3Dnet0,vhost=3Don,...
> >   -chardev socket,id=3Dmirror0,host=3D...,port=3D...,server=3Don,wait=
=3Doff
> >   -object filter-redirector,id=3Dvm1redir,netdev=3Dnet0,outdev=3Dmirror=
0...
> >
> > Secondary VM (receive mirrored packets):
> >
> >   -netdev tap,id=3Dnet0,vhost=3Don,...
> >   -chardev socket,id=3Dred0,host=3D...,port=3D...,reconnect-ms=3D..
>
> Is this for packet socket?
>
> this is connect to the  -chardev
socket,id=3Dred0,host=3D127.0.0.1,port=3D9003,reconnect-ms=3D1000 \ in the =
Primary
VM to mirror the packet. should I also change this into    packet socket ?
I didn't change the inside filter process in this code and only change the
capture and inject
Thanks
cindy

> >   -object
> filter-buffer,id=3Dswbuf,netdev=3Dnet0,queue=3Dtx,interval=3D1000000,stat=
us=3Doff.....
> >   -object
> filter-redirector,id=3Dr1,netdev=3Dnet0,queue=3Dtx,indev=3Dred0,status=3D=
off,enable_when
> >   _stopped=3Dtrue.... \
> >
> > changset
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > change in v2:
> > 1. add support for filter-buffer
> > 2. remove the in_netdev and out_netdev for AF_PACKET bind port, now onl=
y
> use netdev
> > when the vhost=3Don start use AF_PACKET to capture and inject, when use
> vhost=3Doff will use
> > the existing code
> > 3. add CAP_NET_RAW check
> > 4. address the comment
> >
> > change in v3:
> > 1. reuse the exist Capture/inject process
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > - Tested with vhost=3Don/off TAP device on x86_64
> >
> > known issue:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. compilation should be disabled on non-Linux platforms.will fix in
> next version.
> > 2. Sometimes the secondary VM receives duplicate packets. will fix this
> in next version.
> >
> >
> > Cindy Lu (7):
> >   net/filter-mirror: keep mirroring while stopped
> >   virtio-net: keep tap read polling disabled while vhost owns RX
> >   net/filter-redirector: add AF_PACKET netdev setup helpers
> >   net/filter-redirector: add AF_PACKET capture path
> >   net/filter-redirector: add AF_PACKET inject path
> >   net/filter: allow filters on vhost TAP backends
> >   net/filter-redirector: check CAP_NET_RAW before creating AF_PACKET
> >
> >  hw/net/virtio-net.c  |  12 +-
> >  include/net/filter.h |   6 +
> >  include/net/net.h    |   6 +
> >  net/filter-mirror.c  | 379 ++++++++++++++++++++++++++++++++++++++++++-
> >  net/filter.c         |  17 +-
> >  net/net.c            |  10 +-
> >  6 files changed, 417 insertions(+), 13 deletions(-)
> >
> > --
> > 2.52.0
> >
>
> Thanks
>
>

--00000000000038070e064e5d40ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 1, =
2026 at 10:16=E2=80=AFAM Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.c=
om">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Mon, Mar 30, 2026 at 5:09=E2=80=AFPM Cindy Lu &lt=
;<a href=3D"mailto:lulu@redhat.com" target=3D"_blank">lulu@redhat.com</a>&g=
t; wrote:<br>
&gt;<br>
&gt; Hi, All<br>
&gt;<br>
&gt; This series adds AF_PACKET-based capture and injection datapath<br>
&gt; support for the vhost TAP device in filter<br>
&gt;<br>
&gt; Example Usage(not change with exist upstream code)<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; Primary VM (mirror incoming packets to secondary via chardev socket):<=
br>
&gt;<br>
&gt;=C2=A0 =C2=A0-netdev tap,id=3Dnet0,vhost=3Don,...<br>
&gt;=C2=A0 =C2=A0-chardev socket,id=3Dmirror0,host=3D...,port=3D...,server=
=3Don,wait=3Doff<br>
&gt;=C2=A0 =C2=A0-object filter-redirector,id=3Dvm1redir,netdev=3Dnet0,outd=
ev=3Dmirror0...<br>
&gt;<br>
&gt; Secondary VM (receive mirrored packets):<br>
&gt;<br>
&gt;=C2=A0 =C2=A0-netdev tap,id=3Dnet0,vhost=3Don,...<br>
&gt;=C2=A0 =C2=A0-chardev socket,id=3Dred0,host=3D...,port=3D...,reconnect-=
ms=3D..<br>
<br>
Is this for packet socket?<br>
<br></blockquote><div>this is connect to the=C2=A0 -chardev socket,id=3Dred=
0,host=3D127.0.0.1,port=3D9003,reconnect-ms=3D1000 \ in the=C2=A0Primary VM=
 to mirror the packet. should I also change this into=C2=A0 =C2=A0=C2=A0pac=
ket socket ?=C2=A0</div><div>I didn&#39;t change the inside filter process =
in this code and only change the capture and inject</div><div>Thanks</div><=
div>cindy</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0-object filter-buffer,id=3Dswbuf,netdev=3Dnet0,queue=3Dtx,=
interval=3D1000000,status=3Doff.....<br>
&gt;=C2=A0 =C2=A0-object filter-redirector,id=3Dr1,netdev=3Dnet0,queue=3Dtx=
,indev=3Dred0,status=3Doff,enable_when<br>
&gt;=C2=A0 =C2=A0_stopped=3Dtrue.... \<br>
&gt;<br>
&gt; changset<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; change in v2:<br>
&gt; 1. add support for filter-buffer<br>
&gt; 2. remove the in_netdev and out_netdev for AF_PACKET bind port, now on=
ly use netdev<br>
&gt; when the vhost=3Don start use AF_PACKET to capture and inject, when us=
e vhost=3Doff will use<br>
&gt; the existing code<br>
&gt; 3. add CAP_NET_RAW check<br>
&gt; 4. address the comment<br>
&gt;<br>
&gt; change in v3:<br>
&gt; 1. reuse the exist Capture/inject process<br>
&gt;<br>
&gt; Testing<br>
&gt; =3D=3D=3D=3D=3D=3D=3D<br>
&gt; - Tested with vhost=3Don/off TAP device on x86_64<br>
&gt;<br>
&gt; known issue:<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; 1. compilation should be disabled on non-Linux platforms.will fix in n=
ext version.<br>
&gt; 2. Sometimes the secondary VM receives duplicate packets. will fix thi=
s in next version.<br>
&gt;<br>
&gt;<br>
&gt; Cindy Lu (7):<br>
&gt;=C2=A0 =C2=A0net/filter-mirror: keep mirroring while stopped<br>
&gt;=C2=A0 =C2=A0virtio-net: keep tap read polling disabled while vhost own=
s RX<br>
&gt;=C2=A0 =C2=A0net/filter-redirector: add AF_PACKET netdev setup helpers<=
br>
&gt;=C2=A0 =C2=A0net/filter-redirector: add AF_PACKET capture path<br>
&gt;=C2=A0 =C2=A0net/filter-redirector: add AF_PACKET inject path<br>
&gt;=C2=A0 =C2=A0net/filter: allow filters on vhost TAP backends<br>
&gt;=C2=A0 =C2=A0net/filter-redirector: check CAP_NET_RAW before creating A=
F_PACKET<br>
&gt;<br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 |=C2=A0 12 +-<br>
&gt;=C2=A0 include/net/filter.h |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 include/net/net.h=C2=A0 =C2=A0 |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 net/filter-mirror.c=C2=A0 | 379 ++++++++++++++++++++++++++++++++=
++++++++++-<br>
&gt;=C2=A0 net/filter.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
&gt;=C2=A0 net/net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +-=
<br>
&gt;=C2=A0 6 files changed, 417 insertions(+), 13 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.52.0<br>
&gt;<br>
<br>
Thanks<br>
<br>
</blockquote></div></div>

--00000000000038070e064e5d40ec--


