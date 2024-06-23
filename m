Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F11C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLW0V-0001XD-FT; Sun, 23 Jun 2024 18:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLW0T-0001Wt-4s
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:48:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLW0R-0004zV-DE
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:48:20 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c7bf925764so2985121a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719182897; x=1719787697;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iUJoioPiobzLe2rLce+Fw4IBzvZqDUIO0ms5sJvPcR0=;
 b=2VprXBs0UOYEOWRNv3zlSyNDQC5wxETDl/vPr2RBtoWlPAQorwpfg0IGZPLBJgCYaF
 j1YKWu6BnW3pbXAs4Lb7dNMkqgSVTzwP1UVhIXWbvO5zJOD5ClYHXngsnbEjgWG6rpB6
 JYM5zEgAw+ne+Wo7tc3ehmP0sz4qLWVGvU8L+N+TCZl+Of19qQfa1U0q/+gEN1T/F03j
 XRX/wTNq1/fwfUbUTdd8W9miSx+OFu/uS9NLhTdN0rxME2XO5bM0/Husu1hT4o2GyoJh
 TgxzVehPbAbzty/F7DGQp4N4OVvsYeA2fyTui0iHyO2vEJ64pbzIXIAwagSlRvW50d5s
 CG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719182897; x=1719787697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUJoioPiobzLe2rLce+Fw4IBzvZqDUIO0ms5sJvPcR0=;
 b=MBcJw03me8u/JpDVlcUOQQddAo2Fxhhc9u00ytKG03HkUSTUY6zFyMX2jPdMtWR4a0
 cKnIYW5nSWJgqvPO2CoCVrJUNFCOPjXfrOJQKbFFUs469e5KnFibAEwX6tkUKFuRONtz
 Venqcyj5ycU6pdJ2vYibXPsceYgeEX2HcqZBji8JIgh6b0B2c3vBfvwXlcoRIxZCl6iX
 Jk7Ui4goCWzH27UoptMtWgFO2n1M8rXp3fRDBLMbX8d9uvbjLcwKqaBizs0SYfNkXd76
 sbdBcyqbc2ovDmyhPJzcE4T6ACaSIqvLIVjlQVT2Zaue7d4/w7KK+IcKUJB+lMRwsSAl
 WKuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/PrjXH4veT0THIkX7kgncDtlHAX7iUSWgHjRUkjqd+qy0kb/FgQPM7lRKScuQxb6aRT/slIn84jvsO/JePTwE38DBAJ0=
X-Gm-Message-State: AOJu0Yx7elp5Wt6rNeKDX4filvYWwZs0H3EbkoMPoHhF100NQu8qE3Zn
 KzOZ+5WUUjrDdtzw6hPA4QZxpaF2reiCXbtk/cL4mFNGdEDwC011QRpRWkeNG7TtkDVAj/b6n6n
 ausJBiSDylma1xqqHWtNIAC3t7262fHXwFt1ak4zu//GiBQwUc7c=
X-Google-Smtp-Source: AGHT+IFP+PsikjsJKyIW/R6IUo/rKl9sM8urQRzIrr48Jnfh4HWp8brO9oHp4YwsDav6p4+DrkZoRg4vvSvsny/bgLc=
X-Received: by 2002:a17:90b:1884:b0:2c2:f6a2:a5f7 with SMTP id
 98e67ed59e1d1-2c86124708amr2102466a91.13.1719182897216; Sun, 23 Jun 2024
 15:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-13-itachis@FreeBSD.org>
 <0c5af289-7ff6-4217-8cbf-b9119fe6c587@linaro.org>
In-Reply-To: <0c5af289-7ff6-4217-8cbf-b9119fe6c587@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 23 Jun 2024 16:48:05 -0600
Message-ID: <CANCZdfpwtCKdZMnxui-EU2eJtRE81wxhejH2Ha=Sr2-z5_NV7w@mail.gmail.com>
Subject: Re: [PATCH 12/23] Add ability to get rval2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e49a1d061b9675cc"
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1036.google.com
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

--000000000000e49a1d061b9675cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:17=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:57, Ajeet Singh wrote:
> > From: Warner Losh <imp@bsdimp.com>
> >
> > Function accesses the x1 register which holds the value
> >
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > ---
> >   bsd-user/aarch64/target_arch_vmparam.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/bsd-user/aarch64/target_arch_vmparam.h
> b/bsd-user/aarch64/target_arch_vmparam.h
> > index dc66e1289b..0c35491970 100644
> > --- a/bsd-user/aarch64/target_arch_vmparam.h
> > +++ b/bsd-user/aarch64/target_arch_vmparam.h
> > @@ -65,4 +65,10 @@ static inline void set_second_rval(CPUARMState
> *state, abi_ulong retval2)
> >   {
> >       state->xregs[1] =3D retval2; /* XXX not really used on 64-bit arc=
h */
> >   }
> > +
> > +static inline abi_ulong get_second_rval(CPUARMState *state)
> > +{
> > +    return state->xregs[1];
> > +}
>
> The other two ports only define set_second_rval, and this one only define=
s
> get?  This
> doesn't seem right...
>

The other two ports need to have this added. Upstream, there's some code
that uses this in the system call tracing path.

Warner

--000000000000e49a1d061b9675cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 18, 2024 at 4:17=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 6/17/24 11:57, Ajeet Singh wrote:<br>
&gt; From: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_bla=
nk">imp@bsdimp.com</a>&gt;<br>
&gt; <br>
&gt; Function accesses the x1 register which holds the value<br>
&gt; <br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/target_arch_vmparam.h | 6 ++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64=
/target_arch_vmparam.h<br>
&gt; index dc66e1289b..0c35491970 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_vmparam.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_vmparam.h<br>
&gt; @@ -65,4 +65,10 @@ static inline void set_second_rval(CPUARMState *sta=
te, abi_ulong retval2)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0state-&gt;xregs[1] =3D retval2; /* XXX not r=
eally used on 64-bit arch */<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +static inline abi_ulong get_second_rval(CPUARMState *state)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return state-&gt;xregs[1];<br>
&gt; +}<br>
<br>
The other two ports only define set_second_rval, and this one only defines =
get?=C2=A0 This <br>
doesn&#39;t seem right...<br></blockquote><div><br></div><div>The other two=
 ports need to have this added. Upstream, there&#39;s some code that uses t=
his in the system call tracing path.</div><div><br></div><div>Warner</div><=
div>=C2=A0</div></div></div>

--000000000000e49a1d061b9675cc--

