Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40786C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9iQ-0000qF-U4; Mon, 28 Sep 2026 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9iP-0000lJ-0V
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:40:13 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB9iM-0002nx-Li
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:40:12 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaea178c96so3304718a12.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790595609; cv=none;
 d=google.com; s=arc-20260327;
 b=hQrg/k12xsv68TAozsuVrmFUtRh17eLQmK9LkYj8oe43qGMfb5I9iivc43yxopPN4Q
 NtI0Yrf78OpDp6F1bmjv9Y3HigRTiSWZ4LoixUlN6gDJiKC7xi3l+aiFX5byrHDIUXvh
 tzoVtCcLoG08gs8w0rF48REy6wSKpzv7EyiGgqf5mqEDurrSrgra8lT18QbALAHS6jLy
 YDRUxZfdMvb3NkAZV6G9fzbLO2UCCiTTplQHJy9sjJkWh3FqWnrzqF4PHZ4MlyufU0HT
 eEV4UuM+ilezbuFiDVjKs1JHCEz7I/WtiL7GBciQILkgL5WO+vaA5Rde/Lb0taqQUr0m
 YJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Yd/I30uUe5qAFtDpR8Z+AeNJbut6NgZQLv+o2x3iuR4=;
 fh=hF49N+ICRdOtWOQfOf/ycWZja/uQlZjka9gRDSILrMg=;
 b=QsFO0nlzA+U1aLANjPT8EG6SFt7flwoNjAUFqLdnLh2p4GxYiKHB8xkwYeS0kCakmR
 2BwTCBUM3WN9h3yGLL9qoBhIkHYW40TLfo4k8CfX1ZwSIYSIBH7QgM70vDNV2R+ThnKH
 k7vdBRp9VX08tNWrG0d46TUtjaJVI9byfio+62Od8YKg5yCuUdlniPVc5/lfyTP7Rl84
 eh1nxJO3o/KvHQSWfKdrDFHWD5kLEdnUT/8hq9CW3j10dMEd+n0tM3fnU2AeQPG5us0c
 BrKPOcrhbPgJ3iTFX5H8g6fjBDjYQfNMSzR12XKyigPejVPr8CKowDrWgcfvJ7FW7z+S
 Fh+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790595609; x=1791200409; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yd/I30uUe5qAFtDpR8Z+AeNJbut6NgZQLv+o2x3iuR4=;
 b=EjgaxtIvAZMRC1fVed1lzhnTVFg5f2cFQt1r6c/r8YU/yuwt9JYSn1x4SwlwzEwKsr
 D6ILIifNOHnSNfvRw9PG0mxQtajaAVwEwDhOKXtKyRsVYp9XMUTN0l+OsqJ5evdl9Y62
 CKR70C+WPEYFHLrdeF4kJPMp913GMUK66Nnbs3W1c0i1eUI8g5nhf91rLwhDjsTrNvok
 eRWSNXZ/opEBryA4p/pgnh5Yvh8cZNiucC0pBG02ih2xVmWlliT47fSBuTU6uFD5li0r
 eiWMp9dDCXT4NAWm2I9yjCVCzV+CEGlDod7D9nBQL8dtEdxl3w0TCx0MnoZ97t8FOPY9
 XpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595609; x=1791200409;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yd/I30uUe5qAFtDpR8Z+AeNJbut6NgZQLv+o2x3iuR4=;
 b=m/F8SEHz+mlZ3dgtOzaRVak/Pdy4pk6SQenNFTOiCHsFkQhFqqP5qIzDcbzVtc9es/
 34jw8mRQ25MK0IVtfLYHblL6VysL73++vBlrr+yXoqYWFiKBRvUna3BCk6QE++KvAe68
 JoRQBbzv7d/e4jqi+FSbPRPtVSRLXmh1doJfo8KRwRigtCB6z+dmA7kPD46pwVpCxGt9
 I1qK12yo0NIEI8Bl7ZYBidZIoEbCX5ZL4i7Y8EaZpg4//70jUAC5jl+61F4NBXQuxdCH
 jkS7kjuMy4n6JHzVKEoAxdlAyQUi4fjKpxyCGAQR7zGOMo2ixUlPn++/DmRjlrkdXns1
 z3GQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgQOhLwSoi4p40x6iCGHyfSA2Hy0k5REUeKP8VtdmfENtLmKvySwHkEfpf+o56iTvCGKQYqBveuXEr@nongnu.org
X-Gm-Message-State: AFq9FYKwsWHsd1OeTJStnzgQtFFjF7FI7A618SPRSve+PKjPyt3ADRjN
 9ORG2cnonwWpwsNLJiuZIpH/fftICXMFWCBXeNbDIwrBgeZyl4OQSK8RQNz+lXBTfWB5mZy9+IM
 /utQtTVrpWmPSq61umf42H1+KkIeeGFU=
X-Gm-Gg: AYBFou1L99W6IvDoXYPX6VNF1GblgPMzXqrx+eNVV+qYLgaE+G7wLjZpNX7XuFioKik
 QPJ7Kk5VWzVusI4sIo9zIeHmNcb9GN/ggLDK5Mvl4S7hCqAuKR3Y5xs5TyzQiTtRlS2qb45TNbh
 8XRYd59kmxZFiTGOErfoU3AQ5723HX3F6m8DdQ1gZOekhmRysVvU1L4O546Z6xQhI1V7MtrWWBE
 Mm//xDr3NWRTrGQfsvHqvGuu2J0bwWZqxCwNH4CupPXyIHAiKxcfaDR4rcrU1iL0uEmmU5dNn4g
 6lF29GWRZ0Kf14uDzPLOkKXg94R2ryYU72KLenFYvv0KmBNLKj5bVnY=
X-Received: by 2002:a05:6402:4409:b0:6aa:f77e:594e with SMTP id
 4fb4d7f45d1cf-6aaf77e5effmr6280536a12.23.1790595608892; Mon, 28 Sep 2026
 04:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE9qsZZ+AnfGQ797SQj5yXP8SDOZyxYoKP=oh57UPFqq0Q@mail.gmail.com>
 <arpH_2anGV-JU12e@redhat.com>
 <4da49cb4-6044-418e-b003-81c4ec6d6ed6@oss.qualcomm.com>
 <arpRR7cH6nBN5FwD@redhat.com>
In-Reply-To: <arpRR7cH6nBN5FwD@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 19:39:55 +0800
X-Gm-Features: AclHuK9vkqzvcduTgmC_8lFwawSzwQ4X2k_htIPV_FkKvX4khGcKbxI_oPkXE4I
Message-ID: <CAE2XoE9GZ01dysW_pPhrkZ20qzoQiTcKuQEAVuss4HTN6pTsdA@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003458e3065c898710"
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000003458e3065c898710
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:
>
> On Mon, Sep 28, 2026 at 01:29:26PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 28/9/26 12:57, Daniel P. Berrang=C3=83=C2=A9 wrote:
> > > On Mon, Sep 28, 2026 at 06:51:41PM +0800, Yonggang Luo wrote:
> > > > On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9=
 <
> > > > philmd@oss.qualcomm.com> wrote:
> > > > >
> > > > > On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> > > > > > On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> > > > > > > query-targets lists each linked target, including none, with
its
> > > > > > > arch, endianness, and the machines that target accepts.
> > > > > > >
> > > > > > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > > > > > ---
> > > > > > >    hw/core/machine-qmp-cmds.c | 30
++++++++++++++++++++++++++++++
> > > > > > >    qapi/machine.json          | 35
+++++++++++++++++++++++++++++++++++
> > > > > > >    2 files changed, 65 insertions(+)
> > > > > >
> > > > > >
> > > > > > > diff --git a/qapi/machine.json b/qapi/machine.json
> > > > > > > index 6aaa2af709a..d8cdea6203e 100644
> > > > > > > --- a/qapi/machine.json
> > > > > > > +++ b/qapi/machine.json
> > > > > > > @@ -307,6 +307,41 @@
> > > > > > >    ##
> > > > > > >    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> > > > > > >
> > > > > > > +##
> > > > > > > +# @TargetMachines:
> > > > > > > +#
> > > > > > > +# One registered system target and the machines that can run
on it.
> > > > > > > +#
> > > > > > > +# @arch: the target architecture
> > > > > > > +#
> > > > > > > +# @endianness: the target endianness
> > > > > > > +#
> > > > > > > +# @machines: machine type names, not aliases
> > > > > > > +#
> > > > > > > +# Since: 11.2
> > > > > > > +##
> > > > > > > +{ 'struct': 'TargetMachines',
> > > > > > > +  'data': { 'arch': 'SysEmuTarget',
> > > > > > > +            'endianness': 'EndianMode',
> > > > > > > +            'machines': ['str'] } }
> > > > > >
> > > > > > We already have  'QemuTargetInfo' struct which is used
> > > > > > with 'query-target', that should also be used with the
> > > > > > new 'query-targets' command.
> > > > > >
> > > > > > We need to add the 'endianness' field to QemuTargetInfo.
> > > > >
> > > > > Why do we want to expose endianness, and what endianness to
> > > > > expose? Endianness is a runtime bit state of CPUs. Sometime
> > > > > this bit is hardwired but that is an implementation detail.
> > > >
> > > > For some targets it's, but for some targets it's not. for example
> > > >
> > > > mips-softmmu.mak
> > > > mipsel-softmmu.mak
> > > > mips64el-softmmu.mak
> > > > mips64-softmmu.mak
> > > >
> > > >
> > > > mips64el-softmmu.mak
> > > > mips64-softmmu.mak
> > > > only differ the endianless
> > >
> > > "EndianMode" is a tri-state including 'unspecified' as a value,
> > > so we can cope with both scenarios - the targets where endianness
> > > is runtime switchable in the CPU can use 'unspecified' as the
> > > EndianMode. That behaviour should be documented in the QAPI
> > > docs for QemuTargetInfo
> >
> > OK but still I don't understand the usefulness of exposing that
> > at the machine level, since this is a CPU property.
>
> True, and exposing this does not look like a pre-requisite for
> having a single binary. It will be better if we can focus on
> just what is neccessary to get the basics working initially.


Yeap, for these two targets, the endianness is not needed yet. I'll try to
strip it.

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003458e3065c898710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 7:36=E2=80=AFPM Daniel P. =
Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.co=
m</a>&gt; wrote:<br>&gt;<br>&gt; On Mon, Sep 28, 2026 at 01:29:26PM +0200, =
Philippe Mathieu-Daud=C3=A9 wrote:<br>&gt; &gt; On 28/9/26 12:57, Daniel P.=
 Berrang=C3=83=C2=A9 wrote:<br>&gt; &gt; &gt; On Mon, Sep 28, 2026 at 06:51=
:41PM +0800, Yonggang Luo wrote:<br>&gt; &gt; &gt; &gt; On Mon, Sep 28, 202=
6 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<br>&gt; &gt; &gt; &gt=
; <a href=3D"mailto:philmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt=
; wrote:<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; On 28/9/26=
 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:<br>&gt; &gt; &gt; &gt; &gt; &g=
t; On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:<br>&gt; &g=
t; &gt; &gt; &gt; &gt; &gt; query-targets lists each linked target, includi=
ng none, with its<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; arch, endianness, a=
nd the machines that target accepts.<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt;<=
br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; Signed-off-by: Yonggang Luo &lt;<a hr=
ef=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &=
gt; &gt; &gt; &gt; &gt; &gt; ---<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; =C2=
=A0 =C2=A0hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++<br=
>&gt; &gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0qapi/machine.json =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 +++++++++++++++++++++++++++++++++++<br>&gt;=
 &gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A02 files changed, 65 insertions(=
+)<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt=
; &gt; &gt; &gt; &gt; &gt; &gt; diff --git a/qapi/machine.json b/qapi/machi=
ne.json<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; index 6aaa2af709a..d8cdea6203=
e 100644<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; --- a/qapi/machine.json<br>&=
gt; &gt; &gt; &gt; &gt; &gt; &gt; +++ b/qapi/machine.json<br>&gt; &gt; &gt;=
 &gt; &gt; &gt; &gt; @@ -307,6 +307,41 @@<br>&gt; &gt; &gt; &gt; &gt; &gt; =
&gt; =C2=A0 =C2=A0##<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; =C2=A0 =C2=A0{ &=
#39;command&#39;: &#39;query-target&#39;, &#39;returns&#39;: &#39;QemuTarge=
tInfo&#39; }<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &=
gt; &gt; &gt; +##<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +# @TargetMachines:=
<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +#<br>&gt; &gt; &gt; &gt; &gt; &gt; =
&gt; +# One registered system target and the machines that can run on it.<b=
r>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +#<br>&gt; &gt; &gt; &gt; &gt; &gt; &g=
t; +# @arch: the target architecture<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; =
+#<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +# @endianness: the target endiann=
ess<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +#<br>&gt; &gt; &gt; &gt; &gt; &g=
t; &gt; +# @machines: machine type names, not aliases<br>&gt; &gt; &gt; &gt=
; &gt; &gt; &gt; +#<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +# Since: 11.2<br=
>&gt; &gt; &gt; &gt; &gt; &gt; &gt; +##<br>&gt; &gt; &gt; &gt; &gt; &gt; &g=
t; +{ &#39;struct&#39;: &#39;TargetMachines&#39;,<br>&gt; &gt; &gt; &gt; &g=
t; &gt; &gt; + =C2=A0&#39;data&#39;: { &#39;arch&#39;: &#39;SysEmuTarget&#3=
9;,<br>&gt; &gt; &gt; &gt; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;endianness&#39;: &#39;EndianMode&#39;,<br>&gt; &gt; &gt; &gt=
; &gt; &gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;machines&#=
39;: [&#39;str&#39;] } }<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt;=
 &gt; &gt; &gt; We already have =C2=A0&#39;QemuTargetInfo&#39; struct which=
 is used<br>&gt; &gt; &gt; &gt; &gt; &gt; with &#39;query-target&#39;, that=
 should also be used with the<br>&gt; &gt; &gt; &gt; &gt; &gt; new &#39;que=
ry-targets&#39; command.<br>&gt; &gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt;=
 &gt; &gt; &gt; We need to add the &#39;endianness&#39; field to QemuTarget=
Info.<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; Why do we wan=
t to expose endianness, and what endianness to<br>&gt; &gt; &gt; &gt; &gt; =
expose? Endianness is a runtime bit state of CPUs. Sometime<br>&gt; &gt; &g=
t; &gt; &gt; this bit is hardwired but that is an implementation detail.<br=
>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; For some targets it&#39;s, but =
for some targets it&#39;s not. for example<br>&gt; &gt; &gt; &gt;<br>&gt; &=
gt; &gt; &gt; mips-softmmu.mak<br>&gt; &gt; &gt; &gt; mipsel-softmmu.mak<br=
>&gt; &gt; &gt; &gt; mips64el-softmmu.mak<br>&gt; &gt; &gt; &gt; mips64-sof=
tmmu.mak<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &g=
t; mips64el-softmmu.mak<br>&gt; &gt; &gt; &gt; mips64-softmmu.mak<br>&gt; &=
gt; &gt; &gt; only differ the endianless<br>&gt; &gt; &gt;<br>&gt; &gt; &gt=
; &quot;EndianMode&quot; is a tri-state including &#39;unspecified&#39; as =
a value,<br>&gt; &gt; &gt; so we can cope with both scenarios - the targets=
 where endianness<br>&gt; &gt; &gt; is runtime switchable in the CPU can us=
e &#39;unspecified&#39; as the<br>&gt; &gt; &gt; EndianMode. That behaviour=
 should be documented in the QAPI<br>&gt; &gt; &gt; docs for QemuTargetInfo=
<br>&gt; &gt;<br>&gt; &gt; OK but still I don&#39;t understand the usefulne=
ss of exposing that<br>&gt; &gt; at the machine level, since this is a CPU =
property.<br>&gt;<br>&gt; True, and exposing this does not look like a pre-=
requisite for<br>&gt; having a single binary. It will be better if we can f=
ocus on<br>&gt; just what is neccessary to get the basics working initially=
.<br><br><br>Yeap, for these two targets, the endianness is not needed yet.=
 I&#39;ll try to strip it.<br><br>&gt;<br>&gt;<br>&gt; With regards,<br>&gt=
; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://berrange.com">https://ber=
range.com</a> =C2=A0 =C2=A0 =C2=A0 ~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D=
"https://hachyderm.io/@berrange">https://hachyderm.io/@berrange</a> :|<br>&=
gt; |: <a href=3D"https://libvirt.org">https://libvirt.org</a> =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"htt=
ps://entangle-photo.org">https://entangle-photo.org</a> :|<br>&gt; |: <a hr=
ef=3D"https://pixelfed.art/berrange">https://pixelfed.art/berrange</a> =C2=
=A0 ~~ =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop=
138.berrange.com</a> :|<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--0000000000003458e3065c898710--

