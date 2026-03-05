Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42957F47CA9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyD4W-0005Ou-66; Thu, 05 Mar 2026 13:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyD4L-0004uk-EX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:05:09 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vyD4H-00051c-7N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 13:05:03 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3597df496f6so3152930a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 10:05:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772733899; cv=none;
 d=google.com; s=arc-20240605;
 b=UiTpnTuBChf/ch9F8yREP6+wc1jNXPexFM3uswEB6woaxeczYunAuCORFlpukMZ6s7
 ydjSOROch2bnIbvvWYaj84+j/f1O0ZNNy/KNez9QQtW88XIxJgPZdYmSIJhmqE/dahN7
 4vR0MpxoTw+9HnIWkZtKgrkIeSaYu2JrRmyIME8RfHZZ5hmtcIXniQjRXlwSBBHqcoMP
 RgnNffsW7izBsPo23zXfIxuYIQwwdMsmQYAiy4kx+h/bBqB45glB200rJkL2WYYBUSXz
 oJ8D/OhAhxL8BxUIuFKi0iTDix31pzFlKl2FnDyXX0sgDlyZqp1L7o0e2tVA2AWDLuFU
 c2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CTyngj74SbjkVffn/ji0A5cOzvMI8zlL1QsWmm4ze8A=;
 fh=xrT7rtabSEar05lXMHZT1fPOd4mm/8he4Ifn02eeX5c=;
 b=M2OR+eF5Nu0a5hF7LejfBdoRB2G7nVu4aFZ50BysVQR9B1Ib/5KHqjdOsZfd1pWH5f
 n7P8vP1nD9BPIG3qodsy1VacSxq1RxV/A9jnmAZu5oVDtMoNQow0yXDK8HBY4AZsc6WA
 9onUy/zEnMOOHTLp0VfEPQforhZiCk5mntJsmeAaLUTLU1p9DL0RcZXizVC+CwCl4cjf
 gDvUcMI92cJOsHKyG3tOnfhztP2rgMKYS+MvjrQz3kwW22aM/DJQD7rcusGa8Xr4TMzd
 ijPJzpA8SJnDqGJOgFK/2eYsVaEeFuxEBBVMIyHGOIJYxi92sYgmGi+OXerC8+Bti7bF
 PJgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772733899; x=1773338699;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CTyngj74SbjkVffn/ji0A5cOzvMI8zlL1QsWmm4ze8A=;
 b=FhczwVeG1J/HrzWMS0fxi4CSL2PXxPaqskrUcVbp6q4vZJyv69C0Mzr9xbQPktl+bF
 vuCW/bReVDJsDLMn/bpvAKIF6FgiByOO9md/z6nEepvAtUlHRyD2brLQQ6j8Ui7Bybdz
 V9YL0P/5DroetMhSqpIw/fj15wGDakRcDIWUNwzgKXS96SNRa+W00wjuYlDFQdg1rN19
 w6JBnURU3ywdiDFVUnOwGJN+N3K7lhFE6DaqDa9Ro6GM66PQ+2GdwnvPwPZKgKw3f1+A
 MUxikPKMt95VO/GCtq9E/wRYXJnq1ZdDI9KTcWWxfzzmpsfmsItukQmCQgweDEIC4pAF
 xl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733899; x=1773338699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTyngj74SbjkVffn/ji0A5cOzvMI8zlL1QsWmm4ze8A=;
 b=imoOTJWAIU+bkjEgfuAOp4MheFKOFRWzZGM2nuS67eJiwM2NTRn/cw9z593dV/PMLK
 LjT/g6mdsPmsNGTspwf7Mq56N2ntMQSCcUByRVmFlOC9uuq31xeTup2j7ac7nx2yWJQx
 4BTmGPR/NU5KR+UjC+lkGKEfLntHG3rpzP0Hs8EqzAy9h8Sq972J+uUYc2fw6vFzM8yC
 mKT8PSa8T2oar+sKLpzfNwhL8Ks6NA7cjnsEz7FVNlC/8LcSq7eQOe8L4EeU+vD7RN2S
 FTIs0WMylFIUe78b2H0mSGgxLJNq/+iV/a6+mFpp0Ejk/jR5jaxakPTbOp5fvVxFNr2q
 h5hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJq9VyGox9iitTRrRFiAxzlpD2GN7Km44GH5App5RmSB48Fw0OH2LfqIZYSDXCp1mVYGFhZHOh0ZPr@nongnu.org
X-Gm-Message-State: AOJu0YwalloqIrb+R6EsAe004kbh2D9MzOMRbZMMb5FZQS84I2NdWKKm
 JrBfo5bsyZTrPhuk+4N5z7+IsIu6BMgF1ksghoRaHC/qThZswuOwBX9h3l/qJRtZeVusH3DSbLF
 IIjqlO0pFJv2Wp2siDCGIXERD4FkYxNP5D/GBEk3WHw==
X-Gm-Gg: ATEYQzw+JqfC/iNZkwY/YkgODMIg9ym4hmc/yaI9bNrzk0NDZCRKR5O3FMow8uUpHVu
 +PoWtBPMSqiUbY0VN2a4IES+YsJMNvMVCKQnOGVT6MxMdMUTyeDegyCaDGXfTbsa/RxRf7Dg2qP
 vW66zFTnjEsurZgWf4OC/VFrXtRxjR+upIBfO1o7qZFB6bhSc2OYj0yjZ8AQ4KW1BbcujIfcYiT
 T4dQ5hfTmw6Ra2x7NnfOBmws2H6w82n5wZ5sZZrghXUtjb9BdEM7VT2DfutZs2Hymmt9l8Ti1G2
 zKNr3xo=
X-Received: by 2002:a17:90b:2691:b0:356:9405:759d with SMTP id
 98e67ed59e1d1-359a69c2238mr5638644a91.9.1772733898882; Thu, 05 Mar 2026
 10:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
 <aaahAbpycKhDzfbL@redhat.com>
 <CANCZdfoxESrbaUbXWo9g2jfaqsgaWbpNxg5CGd3xgf0MRMDMcw@mail.gmail.com>
 <aabZkCD-MkApTpD4@redhat.com>
 <CANCZdfrgcpVN+MzNCCkVTFa8-Y2G-ajwqJHk4K0OuKvzot=Qeg@mail.gmail.com>
 <87342e94xd.fsf@pond.sub.org>
In-Reply-To: <87342e94xd.fsf@pond.sub.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 5 Mar 2026 11:04:47 -0700
X-Gm-Features: AaiRm50JZn4uBPeP_-cKk5-JhVcTwou3gTfOGGvlUNoDyzv_Zuz0_3btwY2cYEI
Message-ID: <CANCZdfp-d7Joi3ZYyEwPgxahy7q=Bhjbh5YQu2tekUo_Cb4Q4Q@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Switch to SPDX-License-Expression
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000530e43064c4ac6e2"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1033.google.com
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

--000000000000530e43064c4ac6e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 11:20=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Warner Losh <imp@bsdimp.com> writes:
>
> [...]
>
> > I'm trying to not let my irritation show through too much, but I'm only
> 10k
> > lines into 40k of upstreaming and these side trips are slowing things
> down
> > too much. I appreciate the reviews that have found bugs in the code, bu=
t
> > I'm struggling with requests like this. I really need to limit the scop=
e
> of
> > what I take on because there's a lot left to do and I'm doing it in my
> > spare time.
> >
> > So does that sound like a good plan? Or what should I do?
> >
> > Warner
> >
> > P.S. Sorry if my frustration is showing through too much...
>
> I don't see a reason for apologies here.
>
> Cooperation gets frustrating at times.  We may hide our frustration,
> stew in it until it becomes unbearable, then explode, or give up and go
> away.  All undesirable outcomes.  It's better to be open about it early,
> in a respectful manner.  This is what you did, and it's alright.
>
> It's okay to say "no, because" to reviewer requests.  We can then try to
> work out a path forward together.
>

I agree completely. My preemptive apology was because I wasn't sure if
my tone was becoming too sharp to maintain the necessary respect to
find that path forward together. I'm still learning the boundries for this
community with respect to pushback.

Warner

--000000000000530e43064c4ac6e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 4, =
2026 at 11:20=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
 target=3D"_blank">imp@bsdimp.com</a>&gt; writes:<br>
<br>
[...]<br>
<br>
&gt; I&#39;m trying to not let my irritation show through too much, but I&#=
39;m only 10k<br>
&gt; lines into 40k of upstreaming and these side trips are slowing things =
down<br>
&gt; too much. I appreciate the reviews that have found bugs in the code, b=
ut<br>
&gt; I&#39;m struggling with requests like this. I really need to limit the=
 scope of<br>
&gt; what I take on because there&#39;s a lot left to do and I&#39;m doing =
it in my<br>
&gt; spare time.<br>
&gt; <br>
&gt; So does that sound like a good plan? Or what should I do?<br>
&gt; <br>
&gt; Warner<br>
&gt; <br>
&gt; P.S. Sorry if my frustration is showing through too much...<br>
<br>
I don&#39;t see a reason for apologies here.<br>
<br>
Cooperation gets frustrating at times.=C2=A0 We may hide our frustration,<b=
r>
stew in it until it becomes unbearable, then explode, or give up and go<br>
away.=C2=A0 All undesirable outcomes.=C2=A0 It&#39;s better to be open abou=
t it early,<br>
in a respectful manner.=C2=A0 This is what you did, and it&#39;s alright.<b=
r>
<br>
It&#39;s okay to say &quot;no, because&quot; to reviewer requests.=C2=A0 We=
 can then try to<br>
work out a path forward together.<br></blockquote><div><br></div><div>I agr=
ee completely. My preemptive apology was because I wasn&#39;t sure if</div>=
<div>my tone was becoming too sharp to maintain the necessary respect to</d=
iv><div>find that path forward together. I&#39;m still learning the boundri=
es for this</div><div>community with respect to pushback.</div><div><br></d=
iv><div>Warner</div></div></div>

--000000000000530e43064c4ac6e2--

