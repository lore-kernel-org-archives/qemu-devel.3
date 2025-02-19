Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFB8C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 16:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tknA5-0002WY-FZ; Wed, 19 Feb 2025 11:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1tkn9x-0002Vw-9u
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:42:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slongfield@google.com>)
 id 1tkn9v-00024w-5H
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 11:42:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220e0575f5bso692175ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739983369; x=1740588169; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TU0I9J0jidzPVVoWheFpg+KdNX0tSra3PV377t0eSZA=;
 b=MCXFSuZKol20BC4l1LugHBek65Z1DJ8D//VVnrcXXYkk56WW3Jm8wKfXzVWro5PiKR
 ZxP+EerP8Dr84wUTsQkorC0P/22INRpLZbOxoqR7g0Nus+UXO9Jif8ndJxGGTTBgeuPQ
 YGERf4EMz84D2iLBrsSjCuSI6PuDlDPJTFtsd/gkjaBiQ1DMPdXGJzlWXKZ1fuSRPKka
 HdlCoFTSqRFaFqTfz15OF2ZTBMweI5Os4GTVWZQJTN3uBHMoMpP3fQnWFMCK0NsarW40
 V6hOk//h3m8oAuYppjaM7cApbCTl44Qxbo27qzuaKHVw3C0M2D9dYiMSdMTtOHyLPWS1
 /E5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739983369; x=1740588169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TU0I9J0jidzPVVoWheFpg+KdNX0tSra3PV377t0eSZA=;
 b=RbseBnnaNLEY5pjDOvpCIk2lj18SizxNmjZX7xTcrPDyDz3MWKhDPCB3Ff0IZBjZwo
 eirV90ed0YMP6B/jTaXr7VwYWQ+rVyhH5q4mij02rYKL5VYIN8lMdOBOaD+pzLNoM/gP
 YUrdgH4RnVSNDAXz84B8EeGzvFMlo4wySq9Qn0BCGMRf1fXrtlqlSghzQSXl2b4yzN6H
 WOs6a9dfRePXCPh7n4H8yxR/dqZA0zJ7+iRet8Z4zV/P3GJW+LB8GI/BIdO+dAFon0tK
 3xEY2E3iVI/LWJtaMUiQzbyaN1HIotwtGpBgtd2sXyskeddvXQQLxqq3J7Q1ampKzz8C
 iWdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUZfUmcuOlKiVdSnY3pqrgLi/pKxNV7/3CO34mejJ7N5jNUA2OztwUOSx1yT61Vw+PFfCLEzUqfdET@nongnu.org
X-Gm-Message-State: AOJu0YwHpW4LA6SgWWUeo6DGV363un2HvgQ7+lvp7T6/0pa3RVy47kPQ
 Fy9MPe1ekiVGGxehVZjDULNc7VjkKOEuHMIkrgUuheHHr+62/FigS0bEBilfcYpKGHH4yfcPGV6
 Owr1Qw25lb/TN1nDmLqtj8JhHyaHLQadXxmMd
X-Gm-Gg: ASbGnctFrTpfvhipdYAVfC8c+BoeYLBQL/XML6lzYssVvUlU5rTJrEoxIo+4KyXApa2
 No+rRvw5vTY1bJuHwoh5Me3GOBGESe0peK7mn20wF9DAuFcpKeQbFnKMITn1GvV1o6BnN86bNKL
 zcbuDE9HNj0fPPDtTccyxvsEOQBe0=
X-Google-Smtp-Source: AGHT+IHPLPpZhNt+9+UvvHjAmqUMC74X/XSCYGz7Xf6nJGcDOxW/NDPdKybxbQ9hNabg+4+Ss1VqXVEgan/J6EGeTnY=
X-Received: by 2002:a17:902:fc4d:b0:216:48d4:b3a8 with SMTP id
 d9443c01a7336-221742144damr3220505ad.16.1739983368624; Wed, 19 Feb 2025
 08:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20250218222211.1092072-1-slongfield@google.com>
 <CAFEAcA8yrLnyc-CHtiKeXa817qReW0yoJF--Dx=aA-+e0_8Y+g@mail.gmail.com>
In-Reply-To: <CAFEAcA8yrLnyc-CHtiKeXa817qReW0yoJF--Dx=aA-+e0_8Y+g@mail.gmail.com>
From: Stephen Longfield <slongfield@google.com>
Date: Wed, 19 Feb 2025 08:42:35 -0800
X-Gm-Features: AWEUYZkWZVWa2MkjOPZbV2mkCdzOSSnSqelmTggnF8kEyVZHNlFKRNTYn5QVdx0
Message-ID: <CAK_0=F+dmzaZjdHRzR_aOT6ZWyPxiynrHCDOCwVSoPsC3gxv-w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix signed integer overflow undefined
 behavior.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, roqueh@google.com
Content-Type: multipart/alternative; boundary="0000000000009ad035062e81722e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=slongfield@google.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000009ad035062e81722e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:26=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Tue, 18 Feb 2025 at 22:22, Stephen Longfield <slongfield@google.com>
> wrote:
> >
> > The problem is internal to t32_expandimm_imm, the imm intermediate
> > immediate value. This value is sourced from x, which always comes from
> > the return of a deposit32 call, which returns uint32_t already.
> >
> > It's extracted via: int imm =3D extract32(x, 0, 8);, so the value will =
be
> > between 0-255
> >
> > It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,
> > or 0x80.
> >
> > Values between 128-255 multiplied by 0x01000100 or 0x01010101 will caus=
e
> > the upper bit to get set, which is a signed integer overflow. From
> > Chapter 6.5, paragraph 5 of the C11 spec:
> > https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf this is
> > undefined behavior.
>
> QEMU always compiles with -fwrapv. This means that this integer
> overflow is not undefined behaviour in our dialect of C.
>
> > Though this is a minor undefined behavior, I'd like to see this fixed,
> > since the error is showing up when I enable clang's sanitizers while
> > looking for other issues.
>
> If clang's sanitizer reports the overflow as UB when built with
> -fwrapv, that is a bug in the sanitizer and you should get
> it fixed in clang.
> We use and rely on 2s complement handling of signed integers
> in a lot of places, so if you try to find and fix them
> all you're going to be playing a pointless game of whackamole.
>

Yeah, I was running with `-ftrapv` instead of `-fwrapv` looking for errors
in other code.
This was the only place that got flagged, but sounds like that's likely
just an artifact
of the test I was running. (Though, there is a vanishingly small amount of
math
done on `int`s in target/arm/tcg/translate.c, which also probably helps.)


> > Signed-off-by: Stephen Longfield <slongfield@google.com>
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > ---
> >  target/arm/tcg/translate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> > index 68ac393415..8770f0ce1c 100644
> > --- a/target/arm/tcg/translate.c
> > +++ b/target/arm/tcg/translate.c
> > @@ -3508,9 +3508,9 @@ static int t32_expandimm_rot(DisasContext *s, int
> x)
> >  }
> >
> >  /* Return the unrotated immediate from T32ExpandImm.  */
> > -static int t32_expandimm_imm(DisasContext *s, int x)
> > +static uint32_t t32_expandimm_imm(DisasContext *s, uint32_t x)
>
> This function is following the API for decodetree !function
> filters, which return 'int', not 'uint32_t'.
>
> >  {
> > -    int imm =3D extract32(x, 0, 8);
> > +    uint32_t imm =3D extract32(x, 0, 8);
>
> Given what we're doing in the function, it is reasonable
> to make this a uint32_t, though.
>

Changing this to uint32_t is sufficient for me.

I'll send out a v2 of the patch.


> >
> >      switch (extract32(x, 8, 4)) {
> >      case 0: /* XY */
>
> thanks
> -- PMM
>

Thank you for your comprehensive and quick feedback!

--Stephen

--0000000000009ad035062e81722e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Feb 19, 2025 at 7:26=E2=80=AFAM P=
eter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@=
linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 18 Feb 2025 =
at 22:22, Stephen Longfield &lt;<a href=3D"mailto:slongfield@google.com" ta=
rget=3D"_blank">slongfield@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The problem is internal to t32_expandimm_imm, the imm intermediate<br>
&gt; immediate value. This value is sourced from x, which always comes from=
<br>
&gt; the return of a deposit32 call, which returns uint32_t already.<br>
&gt;<br>
&gt; It&#39;s extracted via: int imm =3D extract32(x, 0, 8);, so the value =
will be<br>
&gt; between 0-255<br>
&gt;<br>
&gt; It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,=
<br>
&gt; or 0x80.<br>
&gt;<br>
&gt; Values between 128-255 multiplied by 0x01000100 or 0x01010101 will cau=
se<br>
&gt; the upper bit to get set, which is a signed integer overflow. From<br>
&gt; Chapter 6.5, paragraph 5 of the C11 spec:<br>
&gt; <a href=3D"https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf"=
 rel=3D"noreferrer" target=3D"_blank">https://www.open-std.org/jtc1/sc22/wg=
14/www/docs/n1548.pdf</a> this is<br>
&gt; undefined behavior.<br>
<br>
QEMU always compiles with -fwrapv. This means that this integer<br>
overflow is not undefined behaviour in our dialect of C.<br>
<br>
&gt; Though this is a minor undefined behavior, I&#39;d like to see this fi=
xed,<br>
&gt; since the error is showing up when I enable clang&#39;s sanitizers whi=
le<br>
&gt; looking for other issues.<br>
<br>
If clang&#39;s sanitizer reports the overflow as UB when built with<br>
-fwrapv, that is a bug in the sanitizer and you should get<br>
it fixed in clang.<br>
We use and rely on 2s complement handling of signed integers<br>
in a lot of places, so if you try to find and fix them<br>
all you&#39;re going to be playing a pointless game of whackamole.<br></blo=
ckquote><div><br></div><div>Yeah, I was running with `-ftrapv` instead of `=
-fwrapv` looking for errors in other code.</div><div>This was the only plac=
e that got flagged, but sounds like that&#39;s likely just an artifact</div=
><div>of the test I was running. (Though, there is a vanishingly small amou=
nt of math</div><div>done on `int`s in target/arm/tcg/translate.c, which al=
so probably helps.)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
&gt; Signed-off-by: Stephen Longfield &lt;<a href=3D"mailto:slongfield@goog=
le.com" target=3D"_blank">slongfield@google.com</a>&gt;<br>
&gt; Signed-off-by: Roque Arcudia Hernandez &lt;<a href=3D"mailto:roqueh@go=
ogle.com" target=3D"_blank">roqueh@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 target/arm/tcg/translate.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c<b=
r>
&gt; index 68ac393415..8770f0ce1c 100644<br>
&gt; --- a/target/arm/tcg/translate.c<br>
&gt; +++ b/target/arm/tcg/translate.c<br>
&gt; @@ -3508,9 +3508,9 @@ static int t32_expandimm_rot(DisasContext *s, in=
t x)<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 /* Return the unrotated immediate from T32ExpandImm.=C2=A0 */<br=
>
&gt; -static int t32_expandimm_imm(DisasContext *s, int x)<br>
&gt; +static uint32_t t32_expandimm_imm(DisasContext *s, uint32_t x)<br>
<br>
This function is following the API for decodetree !function<br>
filters, which return &#39;int&#39;, not &#39;uint32_t&#39;.<br>
<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 int imm =3D extract32(x, 0, 8);<br>
&gt; +=C2=A0 =C2=A0 uint32_t imm =3D extract32(x, 0, 8);<br>
<br>
Given what we&#39;re doing in the function, it is reasonable<br>
to make this a uint32_t, though.<br></blockquote><div><br></div><div>Changi=
ng this to uint32_t is sufficient for me.</div><div><br></div><div>I&#39;ll=
 send out a v2 of the patch.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 switch (extract32(x, 8, 4)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case 0: /* XY */<br>
<br>
thanks<br>
-- PMM<br></blockquote><div><br></div><div>Thank you for your comprehensive=
 and quick feedback!</div><div><br></div><div>--Stephen=C2=A0</div></div></=
div>

--0000000000009ad035062e81722e--

