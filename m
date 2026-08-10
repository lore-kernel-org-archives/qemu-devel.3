Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4EDC5AD4E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLqe-0007yg-KP; Mon, 10 Aug 2026 04:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtLqa-0007yI-Mr
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtLqY-000874-FX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786352341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6/8JuMwcDe0q3ABPZrcZFUDeFBExgJ+4IHelzfROwI=;
 b=NKVRdMWkCONi5AkmPlem4Ugwc0EoPf4zCUyWT1xSXOqtF8OzNZ/sjKkArO2p1qbNJwFbhx
 PrtAbbA3RIH49STyHjsrsc5sMullJS5kg9K2usuKIp5PyWAiyx/YT8UQYQkQnWmdG3GFzt
 bwZqutt4PpCviCwJFv3zOB3aP7b0dHg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-cxMGHd8GOeObiYu0p-qRAA-1; Mon, 10 Aug 2026 04:58:57 -0400
X-MC-Unique: cxMGHd8GOeObiYu0p-qRAA-1
X-Mimecast-MFC-AGG-ID: cxMGHd8GOeObiYu0p-qRAA_1786352337
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso20593791cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 01:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786352337; cv=none;
 d=google.com; s=arc-20260327;
 b=Vy3BfbkW8gL6PToDMBKuo6HsX2vCYyzc0DnkV5R2w0SShLaj2JCAcApeszNfMjqutG
 6Vm0VA6Ll+e1mee0IMpkHH6+Lv3tJD5tncUG/0qdtn1EDXBWmCCdc/1DFlXX3fBHT/PH
 lhlsf5fLGcsG9CitAVtYXr2bK7osj71oLp+Jsja1R5HaQGzH4ePZPuICKt9qSUkGZdjR
 qDjXN6OO0omTHAV5JMDVzt3/CxWX7qwqFHzNFyMCdV3bXNNSY4vkRekSnLfq2ig1FRBw
 KIYzdxB2IbcDkDaDfNFh/W3+zx5vDdlL6grkGY/xA2xUyCfvu1xnt7Ts1Fv2/s+bT+xw
 J+6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n6/8JuMwcDe0q3ABPZrcZFUDeFBExgJ+4IHelzfROwI=;
 fh=OwFIzYdtUjyPqIZIP//c7AZfbrKAIFwOgW5AKkNHUsk=;
 b=dUV2+0e9sjY/fvGiuwP3xzI9gN5FuCRhP5zMi9/cJoVueD1uDpXjXp71S7HWcsBmcr
 ssUIqZbku6eJJV2IY2eUYHWOIi0nrGFv6R+20lyKHbodG/z4oSHaepz+60vs45Bdwh6O
 yoywb4knpV4gGjqqgZCC3uBR9Xd1WjU8Ec9YE5QY/uJiE5t3mlFSIhEnWjjWxL3vm/zv
 d/SW/D7P99Rf58wV0jjRjpoPTeX71LRoG/vZ68VXeSgUONiBuQphfDwf6ygbuGM8xAyC
 f9zF7NaJvDO+WOjOMeSKR7zikKu2IQ+2VZNJqwMXlSAXebpHsCBi42JZtf1pyU9a+m51
 JwMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786352337; x=1786957137; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n6/8JuMwcDe0q3ABPZrcZFUDeFBExgJ+4IHelzfROwI=;
 b=eUKjvyQ437MqrKhD7FFKcBzZquvAkG2WITW9puhTkRgvJtwFLaHGKuy/JqWcz+xuFQ
 QdbKf9n4xMQ/8cVKxv5uK5WVY98L73Oa/MYxyN2shMhlZkYcJ8Ii6eaKeNXXtdXw7KL+
 CvGZl0dW+gSHikURSEydoUMYKbwHecf9oO1u3FgGA/KJI4vuZepqimEoprX++gi/Y0C5
 1+eTciQJGFx/4++nXCc/qBJJiOuYh5zxt+ZIzch9lXtpeD0DVezjX4ffgl+2yjl0G6Tf
 4VpRQrEaU89zL7d3HSmeUv1AgTXYuY+6Mcpgt1h0+ZTT7VXcZS/teEh04QaMDkZdfxdu
 Zp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786352337; x=1786957137;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=n6/8JuMwcDe0q3ABPZrcZFUDeFBExgJ+4IHelzfROwI=;
 b=S19iYX+5xETpnUHhjuZJ62un5+K9grNPcLdu9xdLqA65L2sL0IFYIB4Cbs36VCUhW6
 jKLD40/N2dSKbk+zdocdBjIA0v46sYnGM2dYJ25ht0Cq/Su7cuLIEthFNuSkgT1fE196
 C8Qe8ecbwPLlAFCBgcd5CIcVgPdi+/VVx2tUrJbB2aD3ZCDkqAoSyqsjmvDVdebwP87m
 NCN99hd+LFXSU5LJI3Gh3ahTRftaN/SQ+9Zd74/DzWfJhtKQPdE1KwsBYxKOFJqdqB8K
 Waafy0y9hTjWuAd0KzNxGg5evYhfAdGy4y0R9nLFVZIv33vhC5R6V+rFPu79J++hAd1B
 NU3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR0QRPeMyLXvTqChuOLuGznJqYnQq314W8AJjirFeV2ij//LirDRIZTJeV5JQ5hstKvCsBeC7vzDb8@nongnu.org
X-Gm-Message-State: AOJu0YxWo2fSli12pvE9TEJHSFrDxUPQ1tA+PNLirv4SH8Ybw+W6tIg0
 zJH8Z5khhv+Py9Jq6cNAfisKxK27z68OgWDWarAU2SQeohlcsciblVY0f/qOyTKk3qLiZGrmuii
 Fv4X5pncSV2LPWJuxwe2RTm0mZuebMUCTyr5edb21DwDUDC/oPaFAMcAoshiSuRiZnKkJxI/Tyo
 QTtrJvPptXFsSaIMQCD7krpR/OTb9vYuw=
X-Gm-Gg: AR+sD13AXxOCVXi2J5NZbLsBAAiihTPlUlgUvJbNBIloHfNi4g3udW9eFz45+WzhbzZ
 CFhyfnShWpOqy191AErMBzhkO/OckVzK/vz7mJsY0/unyi4P6inPykm5jxICdK0LitWjamAM/rb
 aAih11aOdS3wqzN88+NVqac2HddikvFK6bp9DMl+CfQNdkPjsFbIDiRCMgLSg=
X-Received: by 2002:a05:622a:587:b0:528:38b1:b54b with SMTP id
 d75a77b69052e-52ce61016ebmr405920921cf.20.1786352337025; 
 Mon, 10 Aug 2026 01:58:57 -0700 (PDT)
X-Received: by 2002:a05:622a:587:b0:528:38b1:b54b with SMTP id
 d75a77b69052e-52ce61016ebmr405920621cf.20.1786352336523; Mon, 10 Aug 2026
 01:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
 <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
 <anmJvO2PUDM0xa7l@redhat.com>
 <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
 <anmR9aKJcdtL_xTL@redhat.com>
In-Reply-To: <anmR9aKJcdtL_xTL@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 11:58:44 +0300
X-Gm-Features: AUfX_mzSfE4pp_ihX2Tm9grMPwZNKfks9seLDwcaWYj0g_eHy5SntmqcpJAkNts
Message-ID: <CAPMcbCouxjFScnj54ETuBCbw6_rVx=kurAyWiFEPANMjM_QSHg@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Valentino Paulon <valentino.paulon88@gmail.com>, qemu-devel@nongnu.org, 
 yvugenfi@redhat.com, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000007666180658ad9054"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000007666180658ad9054
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrote:
> > On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
> >
> > wrote:
> >
> > > On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrote:
> > > > Hi Valentino,
> > > >
> > > > Sorry for the long delay.
> > > > I have a question for you
> > > >
> > > > On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon <
> > > > valentino.paulon88@gmail.com> wrote:
> > > >
> > > > > > > So, you propose to call seteuid/setegid before any I/O
> operation?
> > > > > >
> > > > > > Yes, specifically for the SSH commands, because they're unusual
> in
> > > > > > that we're doing stuff on behalf of an unprivileged user.
> > > > >
> > > > > +1 on the euid/egid direction -- as the reporter that's the
> outcome I
> > > > > was hoping for. It confines every step (read, mkdir, create,
> rename,
> > > > > chown) to what the target user could already do himself, which
> removes
> > > > > the whole TOCTOU class instead of chasing one instance of it.
> > > > >
> > > > > A few implementation details that tend to bite with this pattern,
> in
> > > > > case they save a round-trip:
> > > > >
> > > > > - drop the supplementary groups too, not just egid: initgroups()
> (or
> > > > > setgroups() with the user's list) while still root, otherwise the
> > > > > agent's effective access won't match the user's in either directi=
on
> > > > >
> > > >
> > > > Technically, there is no limitation to running QGA in unprivileged
> mode.
> > > > Normally, it is a system daemon, but this is not mandatory.
> > > > In this case, we can not call initgroups because the caller must
> > > > have CAP_SETGID.
> > > > We can call initgroups only when QGA runs as root. What do you thin=
k?
> > >
> > > In any practical sense it is a system daemon given the set of command=
s
> > > it is exposing. Thus, IMHO, deploying as an unprivileged user should
> > > be considered a broken deployment. We could make that explicit by
> > > refusing to launch.
> > >
> >
> > Makes sense, but we have one more issue with QGA unit tests in this cas=
e.
> > They are called by an unprivileged user (build user), and initgroups
> broke
> > it.
> > Is it possible to enter the namespace automatically by the test engine?
>
> We can't assume that is possible todo in all build/test environments.
>
> Doing things as different user accounts feels pretty dubious for the
> scope of a unit test too - that is really functional or integration
> testing.
>
> Can we somehow restructure the tests and/or agent code to avoid the
> changing groups stuff in unit tests.
>

There are two possible options:
1. add #ifdef QGA_BUILD_UNIT_TEST into qmp_guest_ssh_* functions
2. check the current uid and skip initgroups if it is zero (my initial
question)


>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000007666180658ad9054
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Aug 10, 2026 at 11:55=E2=80=AFAM Daniel P=
. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, Aug 10, 2026 at 11:37:34AM +0300, Kostiantyn Kostiuk wrote:<br>
&gt; On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<=
a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com=
</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; Hi Valentino,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Sorry for the long delay.<br>
&gt; &gt; &gt; I have a question for you<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon &lt=
;<br>
&gt; &gt; &gt; <a href=3D"mailto:valentino.paulon88@gmail.com" target=3D"_b=
lank">valentino.paulon88@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; So, you propose to call seteuid/setegid befor=
e any I/O operation?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Yes, specifically for the SSH commands, because th=
ey&#39;re unusual in<br>
&gt; &gt; &gt; &gt; &gt; that we&#39;re doing stuff on behalf of an unprivi=
leged user.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; +1 on the euid/egid direction -- as the reporter that&#=
39;s the outcome I<br>
&gt; &gt; &gt; &gt; was hoping for. It confines every step (read, mkdir, cr=
eate, rename,<br>
&gt; &gt; &gt; &gt; chown) to what the target user could already do himself=
, which removes<br>
&gt; &gt; &gt; &gt; the whole TOCTOU class instead of chasing one instance =
of it.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; A few implementation details that tend to bite with thi=
s pattern, in<br>
&gt; &gt; &gt; &gt; case they save a round-trip:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; - drop the supplementary groups too, not just egid: ini=
tgroups() (or<br>
&gt; &gt; &gt; &gt; setgroups() with the user&#39;s list) while still root,=
 otherwise the<br>
&gt; &gt; &gt; &gt; agent&#39;s effective access won&#39;t match the user&#=
39;s in either direction<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Technically, there is no limitation to running QGA in unpriv=
ileged mode.<br>
&gt; &gt; &gt; Normally, it is a system daemon, but this is not mandatory.<=
br>
&gt; &gt; &gt; In this case, we can not call initgroups because the caller =
must<br>
&gt; &gt; &gt; have CAP_SETGID.<br>
&gt; &gt; &gt; We can call initgroups only when QGA runs as root. What do y=
ou think?<br>
&gt; &gt;<br>
&gt; &gt; In any practical sense it is a system daemon given the set of com=
mands<br>
&gt; &gt; it is exposing. Thus, IMHO, deploying as an unprivileged user sho=
uld<br>
&gt; &gt; be considered a broken deployment. We could make that explicit by=
<br>
&gt; &gt; refusing to launch.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Makes sense, but we have one more issue with QGA unit tests in this ca=
se.<br>
&gt; They are called by an unprivileged user (build user), and initgroups b=
roke<br>
&gt; it.<br>
&gt; Is it possible to enter the namespace automatically by the test engine=
?<br>
<br>
We can&#39;t assume that is possible todo in all build/test environments.<b=
r>
<br>
Doing things as different user accounts feels pretty dubious for the<br>
scope of a unit test too - that is really functional or integration<br>
testing.<br>
<br>
Can we somehow restructure the tests and/or agent code to avoid the<br>
changing groups stuff in unit tests.<br></blockquote><div><br></div><div>Th=
ere are two possible options:</div><div>1. add=C2=A0#ifdef QGA_BUILD_UNIT_T=
EST into=C2=A0qmp_guest_ssh_* functions<br></div><div>2. <span class=3D"Q6i=
bn ng" style=3D"border-style:none;background:none">check</span> the current=
 uid and skip=C2=A0initgroups if it is zero (my initial question)=C2=A0</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--0000000000007666180658ad9054--


