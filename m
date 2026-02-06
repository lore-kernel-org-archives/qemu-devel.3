Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA006EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voPsj-0007Rz-Hn; Fri, 06 Feb 2026 12:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPsd-0007RA-Od
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:44:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1voPsb-0004gU-4C
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 12:44:31 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8230f2140beso1977409b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 09:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770399866; cv=none;
 d=google.com; s=arc-20240605;
 b=FnIoJIvaCPVkVpWqSBnK/rqX+8rgdMrPqSGBBiAT8BVtP5vlg/GlKblg9q8PK3sVat
 QJ/mDvJmlxUU3sXW3fPQPIRBd+TjMVsq8TdvYYClSm9bihb3GGKik2QMQ2U2blvIo5n+
 Vn1VFRGZWc8SrEeXDDd6AFUpp2Kyb3yiHSBToOmiKuMWm2C2AaYTXa4UvBV8Rmqt2x9H
 ZVPZv4KsXlKUPcrrEpMcpR9zSEZVL+CB8A7tU1ZLT2Y2zO+fSdIIJLM6z/OxXBGRC3l1
 AfWeVcSTH7BXvuwykSR5nc0Mej0sZFi4exqzU9fms3neAvfxmLy7CXBVDsUFzLcmcDZM
 zDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K8kIve0Fu/k50TyD18KRPYviJMtAVkW7EvBiMFTbE84=;
 fh=KZjezXCSrxx39dO31pbOeDiyxGEGLz3PIZWBEAGptp8=;
 b=kJSpo992gFw7xYULSqTxu+45EYqyjonHi0Mvfr5NEnSKCKO5r5vtm+5CPi65/izioz
 zQftIqb1t47bNs3XFDzgItMEwoB2T+xeW7ZPO5ZeZai09TrMz+9YsGRbNq/mNxvXqpD5
 qHf9yt+HTIN92auPIZc9XRh5ax0scVUnGPhE6VLJThrVqCA8diCLXkE6boxr58gqr0TL
 pqlfLZa3MUwUBKnF4jSLEPS+3k+672FElmOJ+7eks4DC+EdToUt+8+jPiAm5isksB1gn
 4c6R42wMwQLesHQjjS85CJHsFRN5pMNH5eNRThtZeRfOGRj4pcivN/iPYmt54h0vACwj
 audw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770399866; x=1771004666;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K8kIve0Fu/k50TyD18KRPYviJMtAVkW7EvBiMFTbE84=;
 b=akaqk+dGteRF51fK/pA1gmiE/h6spjhkDc5QI23Sm9Bew6gkTun1+qnQKIp+bxNfi2
 8hSRPtsEMCY8fzhnFgYjkT99vA8Ufh/PV1auhGESZ8kRCxpIV3TX8FO1EOETkOVbHNAp
 wkISdLbIJYNCY6UnXwUcTZtN0iNqgg0Pt73+hx+0XCoUU8sV2txe/mTitC2u/pLnkAVJ
 xsrs2gpkMta3S+qVFmQg44k+iWyq1rlXRBDG6edEejJ6KFvogya4ZfvWLUj4YSUEx81o
 A63Wo7vmW9I4t/H34lN59c2TZdgAbio22TYfyBxwFHN5pko6M5DluhyhazRTGmNX+fgR
 cXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770399866; x=1771004666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8kIve0Fu/k50TyD18KRPYviJMtAVkW7EvBiMFTbE84=;
 b=ovBxIEfwMWNNVzODyDBkwnUp/rBtEqEgsi0JNdawooavw5WF5nWkoyf7Ihw1fHsQJM
 6QB4wYlx+2Ag+i6648sdO2csq54Fv4BwOtiwdlpdgGTYKRuhHge0yJK4BTjOsMioZYkb
 zZQJp78ulgIceHb/KooGC5+QWwKICk5aT714+3gDazn9KD43v2IQetEeHLf3zK8bRN5a
 FWcBdaDwkSDzz03sR28pdjnH2rRmAd16xXNu6uDjfrnOpL99QcSTulAHZCugUiExj1X1
 6T74VbYxZG7KsIHTopS8CBuAlRyDNHWat1l0q9E0MFC3KtI29LDrycYPT+0/w2+Q+2M1
 Qtkg==
X-Gm-Message-State: AOJu0YyIAP3lVkmB53WcISUUiCySlDUXFOAKqUg0yy/tCBUfAkqhPJys
 C6qg83Z4+EWtQVZiJ9BvbcLsw2AASSXkZnVFdhIx13GhHOGRnsv0frhJ36e0ZllmgHxLJIx+nbH
 j+EV04KK+lLoBm37CgWJya98Aa6Uz1+nU4sPy4jjphqCUWKQOW2OFvm8=
X-Gm-Gg: AZuq6aISHd+t/I1Homo9dagSuU1IB2mWrjNBneVxFjrwuSgbgvkxauHIQ3ba3EAMQ9l
 GqOBCeYH4F7wExCUwNLRU2EDxx3gENDv0P09Lc6/z8l2FemE0PyhakVe60IyQq8AkI+XYmkN7Jy
 6D1+oKZkOb7MIj4Q+f7X68CkLCaxGbJbtumA/lK/IFevJsnBzWmU09HzAZ3lP6tMSwsiolBZ7ak
 z4ZXfrZnBJNv69uGf9ireG7oymynHWUZeYatk/MjnOrSQU3T6W4o0LB+qp7/JcgPw7seFw=
X-Received: by 2002:a17:90b:50cb:b0:340:29a3:800f with SMTP id
 98e67ed59e1d1-3549bc1482emr6294508a91.15.1770399866545; Fri, 06 Feb 2026
 09:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-14-8d8ff0035372@bsdimp.com>
 <56609d1e-4d71-41cb-bbcc-2cea4e8544c3@linaro.org>
In-Reply-To: <56609d1e-4d71-41cb-bbcc-2cea4e8544c3@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Feb 2026 10:44:14 -0700
X-Gm-Features: AZwV_Qj7rpmTlhBVUqalbv52JMeyHkWH3c-eFn_1wAvlrh0TZDSNCjut1I73diU
Message-ID: <CANCZdfooet0hr-SkPf1r8NUNM_eXQga_5Gt0TzUkYa13vCeEJw@mail.gmail.com>
Subject: Re: [PATCH 14/24] bsd-user: Add do_bsd_quotactl,
 do_bsd_reboot and do_bsd_getdtablesize
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000027f775064a2b572a"
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000027f775064a2b572a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 7:56=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 2/6/26 03:26, Warner Losh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Add some trivial misc system calls: stub implementations for quotactl(2=
)
> > and reboot(2) syscall; a trivial do_bsd_getdtablesize that calls
> > getdtablesize(2).
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/bsd-misc.h | 52
> ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 52 insertions(+)
> >
> > diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> > new file mode 100644
> > index 0000000000..d81b4fbaef
> > --- /dev/null
> > +++ b/bsd-user/bsd-misc.h
> > @@ -0,0 +1,52 @@
> > +/*
> > + *  miscellaneous BSD system call shims
> > + *
> > + *  Copyright (c) 2013 Stacey D. Son
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + */
>
> We now want SPDX-License-Identifier on all new files, and to *not* includ=
e
> the
> boilerplate.  Should be diagnosed by checkpatch.pl now too.
>

I had noted this in my cover letter. I cannot change the copyright and
license grant for code I do not own. I've asked Stacey to give me the OK
(and to do it globally so I can fix it everywhere). He's usually
responsive. Both here and in bsd-misc.c. So I'll fix this in v2 if I hear
back in time.

Warner


> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>

--00000000000027f775064a2b572a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 5, =
2026 at 7:56=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/6/26 03:26, Warner Losh=
 wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Add some trivial misc system calls: stub implementations for quotactl(=
2)<br>
&gt; and reboot(2) syscall; a trivial do_bsd_getdtablesize that calls<br>
&gt; getdtablesize(2).<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/bsd-misc.h | 52 +++++++++++++++++++++++++++++++++=
+++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 52 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..d81b4fbaef<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/bsd-misc.h<br>
&gt; @@ -0,0 +1,52 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 miscellaneous BSD system call shims<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; + *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; + *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; + *=C2=A0 (at your option) any later version.<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; + *=C2=A0 GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; + *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
<br>
We now want SPDX-License-Identifier on all new files, and to *not* include =
the <br>
boilerplate.=C2=A0 Should be diagnosed by <a href=3D"http://checkpatch.pl" =
rel=3D"noreferrer" target=3D"_blank">checkpatch.pl</a> now too.<br></blockq=
uote><div><br></div><div>I had noted this in my cover letter. I cannot chan=
ge the copyright and license grant for code I do not own. I&#39;ve asked St=
acey to give me the OK (and to do it globally so I can fix it everywhere). =
He&#39;s usually responsive. Both here and in bsd-misc.c. So I&#39;ll fix t=
his in v2 if I hear back in time.</div><div><br></div><div>Warner</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
<br>
r~<br>
</blockquote></div></div>

--00000000000027f775064a2b572a--

