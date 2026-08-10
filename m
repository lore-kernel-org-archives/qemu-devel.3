Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BE9C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLWQ-0005IY-N4; Mon, 10 Aug 2026 04:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtLWF-0005Hu-6j
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtLWD-0005wl-26
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786351079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GsUtEmroy8cbs8DQRu1RunqhTytSNfgbnxnM9bhRBO8=;
 b=ZDlbDS15OUS3k3l4ECr5AuXQLFSKA3anfpxB9AFbmKiZYQgYBkjAHDqLtCW5F+WxGjcR5A
 ZV/zlQ3Uago/eCXy018GltTsCdq6NPdUc1Ven+wR5OjyGvx00jzz+O7SFVWaWVKm7oNKky
 9SImKPKF+DLWzQILYE8QF/zbGqsM/2M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-CcmAsrGjNJaXIGtA5_4QNQ-1; Mon, 10 Aug 2026 04:37:47 -0400
X-MC-Unique: CcmAsrGjNJaXIGtA5_4QNQ-1
X-Mimecast-MFC-AGG-ID: CcmAsrGjNJaXIGtA5_4QNQ_1786351067
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ef8249f871so16168136d6.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 01:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786351067; cv=none;
 d=google.com; s=arc-20260327;
 b=PE9xYdRun8bWrH2YDojvVnDyBy3QmsDy8s+OZvMlhkJPpEsc1ruw0cHnqULq0HMFk+
 m71j9FuafhEccsG/+/ZF4dhcrroLi9ENx6lFoXWPHBarMKq45YnQKUZW1IT8mL5WvSDk
 lRZmg32gXwDv4ZVMxPjp1+pPBurewecsy8z15zZsUh5EASS1xxFX1J4iTbaeo7AK961a
 m/KYSekkmUeTdNX9Ilutl7xmCkdSYakPe/q/qbOGcn3WwMc+gao4eB7jHk8dhYjoVXKV
 FMFB+gFZ1t02EBCsucjwOLXKTTpzK7dvCX9ycGwpHKbsrBLwEUC9YMyuoz0ySX1GFZvl
 mjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GsUtEmroy8cbs8DQRu1RunqhTytSNfgbnxnM9bhRBO8=;
 fh=5K2g4NcwJcdNqiYSRKm55cA+Dm8uqr/uG11xZd/3Jb8=;
 b=Y0PaAb0bwwUURb14a6UXDcH2yUsTDt0UXcUOG7mQ7ifMxlZkavVv8vtD0znha9vBD7
 C6Tmh7wbz1uuMrFHxTKrxyb5yU9p4/6wma75GX3iW6mzEwmcROrkeQXCq7XcKw/oGfxx
 Ov7BNOjP2I16UrXTwo2bHBvNUYZ2Pr9MToafkVLZvQjRM8Eltn4uK1U1hMbCg8UambdA
 6lJ5OVz+GxMg3GbvcuNdg6h54DotaZJI81Od6DlP3aGzaqpNei3fzH3fZFrwp6Rx5sWA
 j4MYnIWyJKJf6aDgy1kkrmTbFbe7Zb0kSz8YMGq9o/3blMLLtblKiz+OIbzLuPSZcPfN
 ToYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786351067; x=1786955867; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GsUtEmroy8cbs8DQRu1RunqhTytSNfgbnxnM9bhRBO8=;
 b=EXu4hNBtkuu3LFhytpYsRicSVwOuYuy5MLODkfLjXVs3934KbMPhunoVtgHZjz0W6f
 UQbdGtvOdH56ZlihDa9CeeFeLpz2GBYmJ6j2tVq6AJuRq+NfrZhkD+qB8sISOJfGJlg0
 argD6QeFt7tKYYs1D5r3sljYDol57gOCLZp4QsvsEChvNo7ogDZybLiOzLORbOQW9INc
 16XLdCnRjOQIMop3aqvUT8pJKePuaV0zTt5hw2/XymA/urtyl1kyyH9jyXHY37J0x3/d
 hFMT5VuUdDMP6su5DMW90yYVisWmj9Vh0BpqAXNMWsjCJiPwAtBxKPxkBgXblZiYVSEf
 aotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786351067; x=1786955867;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GsUtEmroy8cbs8DQRu1RunqhTytSNfgbnxnM9bhRBO8=;
 b=Upypl0scl5MRbVrRbCIUyi8qjccQfx4sjtraoGG4EaxWh36pCQaLbKu/R3UAIovOTs
 JdUR2YLPqmgRQZrJ/gZEyAH2ZwfLygdvlpz88U+OuQLEwPXsXVRjmWiEktLYclTAv9/L
 JQmwi37mP2SotLs9gEVxRcQ1F8RE4sVQcAZ5g3Auk7SRcWCYpX32ar4aREMfPCzzMxfB
 f9iGe2S9ibOxtikRVaEpg7MkvurDXXmfuYlS9qDnuiRezagZ21LuDhfFg+JG7zNkpsjN
 qJzPBPuR4NPDp+uJDgcN2m3sjgfhuxKIKnWfx0/eW7LkZImtus6f1qaBOHitZKz2Y90J
 RwiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpySXCa8MUBMNGC0FODJsE0w+iO7UBCy2MRUT2vEQ5C2a+hfqr5aQVAGSHdwnMp9fMQq4AZNuMyBVAl@nongnu.org
X-Gm-Message-State: AOJu0YwZZtgoN61AWDd/y78I+S7UrgpVOBEMx1T7zZ12wJqpJEK9MUPV
 U1Sj5wrWWBpB0Lcrt5tMm2f9vYQf/LrqIHYIJhyxsOg3nDZL8gEfZT365M4KpAFw89S8igUpD0h
 R3aGdGwvqhrPs+b24T4QUkmrBgCSu0v2SqVWzMxSAVNfZPel/ZsiUs7hRDS8SMr7ELKUcobA4Do
 NHmmusKa16t8GGfHJxRLwnY/UlAz/u41I=
X-Gm-Gg: AR+sD125UtA8q4WoyBbSOcx7mxS1g581Jn3BpcHbf0ELyfU2rPZaMJMNv7caexVWLXu
 9rVrKwaDlX6z6Tc1AbMjLvV41+yzu9IqpOvrmxPVgZQBhxWHV/kRoSXDt3Kknr6KJrcwbce7dQ1
 CSWWv1Dz8oTgwA2x6NDSNhaDWBeufs/o0szRo8rE/mEnjJxt6CRzzre0Zdl7k=
X-Received: by 2002:a05:6214:4343:b0:908:3e1c:647f with SMTP id
 6a1803df08f44-908813903e8mr522951626d6.32.1786351066843; 
 Mon, 10 Aug 2026 01:37:46 -0700 (PDT)
X-Received: by 2002:a05:6214:4343:b0:908:3e1c:647f with SMTP id
 6a1803df08f44-908813903e8mr522951196d6.32.1786351066350; Mon, 10 Aug 2026
 01:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
 <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
 <anmJvO2PUDM0xa7l@redhat.com>
In-Reply-To: <anmJvO2PUDM0xa7l@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 11:37:34 +0300
X-Gm-Features: AUfX_myml-_Ii-cFZqbFE_cqU_VFEayqHAB9u08XwdcWNq3GNHRAodjwAHiRAew
Message-ID: <CAPMcbCoKduRuKdt8P6ULrc43uX_2z=hBp_N87yi8F4GHdVqPeA@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Valentino Paulon <valentino.paulon88@gmail.com>, qemu-devel@nongnu.org, 
 yvugenfi@redhat.com, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000c119d20658ad4460"
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

--000000000000c119d20658ad4460
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrote:
> > Hi Valentino,
> >
> > Sorry for the long delay.
> > I have a question for you
> >
> > On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon <
> > valentino.paulon88@gmail.com> wrote:
> >
> > > > > So, you propose to call seteuid/setegid before any I/O operation?
> > > >
> > > > Yes, specifically for the SSH commands, because they're unusual in
> > > > that we're doing stuff on behalf of an unprivileged user.
> > >
> > > +1 on the euid/egid direction -- as the reporter that's the outcome I
> > > was hoping for. It confines every step (read, mkdir, create, rename,
> > > chown) to what the target user could already do himself, which remove=
s
> > > the whole TOCTOU class instead of chasing one instance of it.
> > >
> > > A few implementation details that tend to bite with this pattern, in
> > > case they save a round-trip:
> > >
> > > - drop the supplementary groups too, not just egid: initgroups() (or
> > > setgroups() with the user's list) while still root, otherwise the
> > > agent's effective access won't match the user's in either direction
> > >
> >
> > Technically, there is no limitation to running QGA in unprivileged mode=
.
> > Normally, it is a system daemon, but this is not mandatory.
> > In this case, we can not call initgroups because the caller must
> > have CAP_SETGID.
> > We can call initgroups only when QGA runs as root. What do you think?
>
> In any practical sense it is a system daemon given the set of commands
> it is exposing. Thus, IMHO, deploying as an unprivileged user should
> be considered a broken deployment. We could make that explicit by
> refusing to launch.
>

Makes sense, but we have one more issue with QGA unit tests in this case.
They are called by an unprivileged user (build user), and initgroups broke
it.
Is it possible to enter the namespace automatically by the test engine?


> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000c119d20658ad4460
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Aug 10, 2026 at 11:20=E2=80=AFAM Daniel P=
. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Mon, Aug 10, 2026 at 11:06:27AM +0300, Kostiantyn Kostiuk wrote:<br>
&gt; Hi Valentino,<br>
&gt; <br>
&gt; Sorry for the long delay.<br>
&gt; I have a question for you<br>
&gt; <br>
&gt; On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon &lt;<br>
&gt; <a href=3D"mailto:valentino.paulon88@gmail.com" target=3D"_blank">vale=
ntino.paulon88@gmail.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; &gt; &gt; So, you propose to call seteuid/setegid before any I/O =
operation?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Yes, specifically for the SSH commands, because they&#39;re =
unusual in<br>
&gt; &gt; &gt; that we&#39;re doing stuff on behalf of an unprivileged user=
.<br>
&gt; &gt;<br>
&gt; &gt; +1 on the euid/egid direction -- as the reporter that&#39;s the o=
utcome I<br>
&gt; &gt; was hoping for. It confines every step (read, mkdir, create, rena=
me,<br>
&gt; &gt; chown) to what the target user could already do himself, which re=
moves<br>
&gt; &gt; the whole TOCTOU class instead of chasing one instance of it.<br>
&gt; &gt;<br>
&gt; &gt; A few implementation details that tend to bite with this pattern,=
 in<br>
&gt; &gt; case they save a round-trip:<br>
&gt; &gt;<br>
&gt; &gt; - drop the supplementary groups too, not just egid: initgroups() =
(or<br>
&gt; &gt; setgroups() with the user&#39;s list) while still root, otherwise=
 the<br>
&gt; &gt; agent&#39;s effective access won&#39;t match the user&#39;s in ei=
ther direction<br>
&gt; &gt;<br>
&gt; <br>
&gt; Technically, there is no limitation to running QGA in unprivileged mod=
e.<br>
&gt; Normally, it is a system daemon, but this is not mandatory.<br>
&gt; In this case, we can not call initgroups because the caller must<br>
&gt; have CAP_SETGID.<br>
&gt; We can call initgroups only when QGA runs as root. What do you think?<=
br>
<br>
In any practical sense it is a system daemon given the set of commands<br>
it is exposing. Thus, IMHO, deploying as an unprivileged user should<br>
be considered a broken deployment. We could make that explicit by<br>
refusing to launch.<br></blockquote><div><br></div><div>Makes sense, but we=
 have one more issue with QGA unit tests in this case.</div><div>They are c=
alled by an unprivileged user <span class=3D"Asgive ng" style=3D"border-sty=
le:none;background:none">(build</span> user), and=C2=A0<span class=3D"gmail=
-im">initgroups broke <span class=3D"Asgive ng" style=3D"border-style:none;=
background:none">it.</span></span></div><div>Is it possible <span class=3D"=
Asgive ng" style=3D"border-style:none;background:none">to enter the namespa=
ce automatically by the test engine?</span>=C2=A0</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
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

--000000000000c119d20658ad4460--


