Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F794C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 16:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLPfO-00059y-6n; Sun, 23 Jun 2024 12:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLPfL-00056d-Kz
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:02:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLPfJ-0001GC-Fy
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 12:02:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fa244db0b2so4067625ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719158523; x=1719763323;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUZKQrFV2m5LnMmVYprbU+daxAkB8Wr2RFpFt813tQE=;
 b=LvNWuNWtw6LjGwkT5geGLUY70Bncc3sucaNZT4Ymc7lg2zb2jOqQ9B0yq/Dii39J8R
 AdoxTojvmaTcpmTsvr2yRV5PJMz1DV1HkPNWxvyoUImvu3cLgxsjIZ3VarxZp1hn4isa
 LhUaKKP3rZNiSC7aStFAtDJ9URnpoeveo6UxTrqVzqFBrzZu0E5b7AraSb6WTRnUL961
 O/Hpr7nf0N3+8cyfPgC+HE4aW/ct66pBsHjBmBQDZRURKo9uPt2pA5tdzomj5snc93Z1
 REsp+4PHakjWEPr/P7VqpiUs6/U5yMuJ8AH5dBQSghkX2hGXLN7vX0N3EuAtqUQUAr/X
 XV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719158523; x=1719763323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUZKQrFV2m5LnMmVYprbU+daxAkB8Wr2RFpFt813tQE=;
 b=r8Q0IV+QSsem+JnoLigJxX1oeYrSp6+5o5pg0GTzb1WLhs75MiCixy9tKsgI1L+Nvb
 9SzaqBiW6e/ulwFjy0ns9pnTyp0O/BcoeV7Ic6UFbuTK6ECKBfaTGq/dXdCdHAK1B+P7
 7f5tHMHbE6m3k0m43D6XGmQ+51v0J161GjOyOCbCJqEL74m++uzwqzaSiReBgQkubWno
 skMEhCqEIV63eXQTVQvFUiwqGZkkkq1XyIpOvzZgYAWWZ8x98luhS8yYUgQmhNhYw33c
 zNYj+VEB79Jg2dET7RZ8qgVDuIssQNBLg1G22iHTUu1pMZKJPrUY83w5DowU6hd9scYg
 P9ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc9E69fvehRg8Lw0GJ43Xmc6o7tYHC/p/HU8Dz8n+x5Vd2FMi1VhHKmf2Q922aKyB678tXHKhsLbzn88Bw5dPPvCP0t/g=
X-Gm-Message-State: AOJu0YxTUjWf3Ou3TKFEh3EOv9CVxSZvarF8vjn7gk3gPtK9DTO1a339
 E/SfJpRMJyi3UlamVATYXkSmPt7A2eIx41On9AS4H/IVjazuOFYZiT76qb7ed3HincZuRNusHH6
 O56HvS17cmdRNwVxde0FFJ9m7oo0SJgzcIvgXrQ==
X-Google-Smtp-Source: AGHT+IGqqb4rA1Rj5G5j6piAn46JeBzR/sRSIV3sixZie6/2SAAit4Wfc+t8qi9vHOfhJGWdhwpD2EcOU2XOYuwZNEE=
X-Received: by 2002:a17:90b:1bd0:b0:2c7:dd1a:da52 with SMTP id
 98e67ed59e1d1-2c85051a060mr1881790a91.25.1719158523022; Sun, 23 Jun 2024
 09:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-24-itachis@FreeBSD.org>
 <60ca952d-35c8-43dc-aba7-1b077867a7aa@linaro.org>
In-Reply-To: <60ca952d-35c8-43dc-aba7-1b077867a7aa@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 23 Jun 2024 10:01:52 -0600
Message-ID: <CANCZdfpwrPtYSg3bS4At8=xQVQr_xDJ7jcrWy_HOMvBR5hnyjQ@mail.gmail.com>
Subject: Re: [PATCH 23/23] Add get_ucontext_sigreturn function
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000013f08b061b90c921"
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62e.google.com
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

--00000000000013f08b061b90c921
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:56=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:58, Ajeet Singh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Function checks the processor state to ensure that the current
> > execution mode is EL0 and no flags indicating interrupts or
> > exceptions are set
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > ---
> >   bsd-user/aarch64/signal.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> > index 13faac8ce6..ad81531ec5 100644
> > --- a/bsd-user/aarch64/signal.c
> > +++ b/bsd-user/aarch64/signal.c
> > @@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs,
> target_mcontext_t *mcp, int srflag)
> >
> >       return err;
> >   }
> > +
> > +/* Compare to sys_sigreturn() in  arm64/arm64/machdep.c */
>

This is now in exec_machdep.c and the most relevant bits are set_mcontext()
and sys_sigreturn().


> > +abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_sf=
,
> > +                                abi_ulong *target_uc)
> > +{
> > +    uint32_t pstate =3D pstate_read(regs);
> > +
> > +    *target_uc =3D 0;
> > +
> > +    if ((pstate & PSTATE_M) !=3D PSTATE_MODE_EL0t  ||
> > +        (pstate & (PSTATE_F | PSTATE_I | PSTATE_A | PSTATE_D)) !=3D 0)=
 {
> > +        return -TARGET_EINVAL;
> > +    }
> > +
> > +    *target_uc =3D target_sf;
>
> Why delay this store?  I don't see why you're assigning 0 above.
>

I'm not sure I understand this either....  We don't store anything when
there's an error in the pstate, at least in the kernel code.

Warner

--00000000000013f08b061b90c921
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 18, 2024 at 4:56=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 6/17/24 11:58, Ajeet Singh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Function checks the processor state to ensure that the current<br>
&gt; execution mode is EL0 and no flags indicating interrupts or<br>
&gt; exceptions are set<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/signal.c | 18 ++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 18 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c<br>
&gt; index 13faac8ce6..ad81531ec5 100644<br>
&gt; --- a/bsd-user/aarch64/signal.c<br>
&gt; +++ b/bsd-user/aarch64/signal.c<br>
&gt; @@ -117,3 +117,21 @@ abi_long set_mcontext(CPUARMState *regs, target_m=
context_t *mcp, int srflag)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return err;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +/* Compare to sys_sigreturn() in=C2=A0 arm64/arm64/machdep.c */<br></=
blockquote><div><br></div><div>This is now in exec_machdep.c and the most r=
elevant bits are set_mcontext() and sys_sigreturn().<br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +abi_long get_ucontext_sigreturn(CPUARMState *regs, abi_ulong target_s=
f,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_ulong *target_uc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t pstate =3D pstate_read(regs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *target_uc =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if ((pstate &amp; PSTATE_M) !=3D PSTATE_MODE_EL0t=C2=A0=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (pstate &amp; (PSTATE_F | PSTATE_I | PSTA=
TE_A | PSTATE_D)) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EINVAL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *target_uc =3D target_sf;<br>
<br>
Why delay this store?=C2=A0 I don&#39;t see why you&#39;re assigning 0 abov=
e.<br></blockquote><div><br></div><div>I&#39;m not sure I understand this e=
ither....=C2=A0 We don&#39;t store anything when there&#39;s an error in th=
e pstate, at least in the kernel code.<br></div><div><br></div><div>Warner<=
br></div></div></div>

--00000000000013f08b061b90c921--

