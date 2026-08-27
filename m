Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BF3C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZWy-0007Zo-Gr; Thu, 27 Aug 2026 08:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzZWx-0007Yy-28
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:48:31 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wzZWu-0008HP-VE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:48:30 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b28d965adcso1546810b6e.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787834907; cv=none;
 d=google.com; s=arc-20260327;
 b=UR7372IfHx3eepqwn/Jho0yCOBMDc6pAlmQ0hJPOtF8z68QDKegb7Ce6yPDbyOwVOT
 729YgaK4Nbbi63m4C+II/BRSfEMODVJOpwsABy24Q0nNiyhxqCdgfm7v1kUKFszejaoc
 fWYmyFggTXtMEZqJGTAOfEQv8mRXkD0ZAejo+vAjjDGtqpi1sP0Mi6/7Z4K7S2oIimQx
 lSOYJeYbqpcagsasXaEaEEj6A63iclkqKIdRR2sgQ1x1pDEgirw85/IdkrXEsFn6uNRN
 2xpLPYYqpTAMCFb0OGxciDFL76vnieabOn4PV19VdY04rifNLit1Pi4Sx6Xh2WXBdARJ
 E0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=geSUZE4b7Xq8/aGY/ZpawkJaRUqcr64DoBQBgM2wBmo=;
 fh=lKCELDgH1vF00A8szBSZO3zkcmksqL2fR1xLK6pBQB4=;
 b=Ek+P1yA/oiXbWJsNRLTwFMXmaW/J8CS0AcnawmZld+Gzh/UXKn78QPo0N3Caz/zWBu
 oI85u9DfcI2yWUUp/HonjdSQI1u1tTheHM8cowoDWGg8H96XFkGrmhj02AooDZl0CxTG
 1ckUmF/HBR6cFM9/CvXLY2sxLkTAbb94vrjcAg+IAFt9qBKUkwvY8+Aug47KUQ+LYq+P
 ZsKyr0+kxx4qY+0+CsjcXAnc4aNgjlqj/xDBPq3y/bi+5gov0f2aGDHL/H91LCA6TytL
 JsAxZ6AFa8WM/ZtdhczIuJPgv/ID2U+9W0UvelhBwpYUuNbAAPTbepKd5GE1i/jkJeDG
 jr0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1787834907; x=1788439707; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=geSUZE4b7Xq8/aGY/ZpawkJaRUqcr64DoBQBgM2wBmo=;
 b=CGgbKrCJfiEFZp5IjNHsC6GkPi1F+hqsfpXPj7cyaKr39/GDdgQUdoZH9zo7njjqfv
 s/byEEuhh3Cjch3/uytHT7E03VIuY4TlVjUk0u2IPPkDCBOOnGI/+nQleM1zEk76317u
 xAo+XduA5G8wSY/ciad5lCCn6JRF6uCgvoJmdUZNqmAv0snG7Dr7rVNf0XMw2aqgpFbp
 6HcR2L8BopE8Mz8TKdiBl8cbKZBELkF/lV3LB5eR/k/+ridRSafBY4ulaJ8odHDg0/qH
 ng6ug5XT42LNwOJmi0IzdwaJN5QX5LUUqE2Bt6g+AMVaS4y2/Ln8UY7sRXt040NFAQi3
 Il1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834907; x=1788439707;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=geSUZE4b7Xq8/aGY/ZpawkJaRUqcr64DoBQBgM2wBmo=;
 b=Lo6heL8q/414VVhsufLAipih2nOpGfXn0sI9OFC8jx8CSf0IhgQ1ZZVpXrpPPMLSvj
 gceNIB3yBnlIzJ2vErwNohlbOXE3+T9Ddh93YwmtuqmevxQHACEDogJJh0Ms1CdgftbR
 NZHSjVndWEemqGn+8snKzi4vzmBWiDthChn6QALay8kWDDfJYtRNE0E47oqYn2jmLIXh
 InIzb0oqHLsCmNzHkna9mzQKvMQvzhXBnrJKp1ipmkhBRhWx/nOdMl6XfoB9VVlSh5yj
 VI5ix7woZkHiW73ha81u4f2RXYQKX56+MSxALhaboF0qlNEy/OQUuSc1G5j+A1S00fyg
 mR3A==
X-Gm-Message-State: AFuF++mzKb5P+TAi/kXFrY+9wivwQkmX9k8I2xO6Zd6AkcF56mk28f0D
 qqxRiNmXTUg2ty+8P+ZLIVNo+ST2RWj5rNeZgjOcaG4HstBprg56CMCNlbc7LXY8aUK14Ceo4jC
 ceNoWAlRpcz5hLhE8rlbDzhESue+rd7bY7YylcK7bOQ==
X-Gm-Gg: AR+sD12hU+M+z5thzslyzfmaC5uvEjiUve71SXkGejZUM+yPYpFGP8/0cwPUkEeA2Vb
 kY6BeUJXs6oy9DJJsV2W4eS+lq8zPGmuN+v7n+CcEfv8j6N59Xulun97Q/EyhdQt0ahY1knl0md
 bQ6jDMX/95X5wVGjiiR9whetYbq1+FpQry7OA2834NBbgOU5tQD+Jevy062HgaVVZfiVk2smqQj
 ukhIUw8HW9bpkyrjE/ACNofAlb88/1cKTbev2i7l9vU+CzZIotiTKSZmatqB+NFRbpGSkb7QabW
 ReZGNqd+6XB3dd/I3nN87vDcvGdT7LMJJ04cnlBtU/BsPbnrXUkcsnpVCWBsCcOhv9335myEsT2
 3DazM4QzPVHiVom6mKfmB9l+oxhDk4t4M6EI=
X-Received: by 2002:a05:6808:2383:b0:486:45c7:34c5 with SMTP id
 5614622812f47-4b366b29476mr14216059b6e.17.1787834907348; Thu, 27 Aug 2026
 05:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-12-richard.henderson@linaro.org>
 <ao3JcPyrC7cZaCgp@sifive.com>
 <2db8ac0a-1b37-450d-8c11-2c5da46ca97a@linaro.org>
 <ao8wupCB3A-7-4-K@sifive.com>
 <0dd6b0e8-be0e-423d-8e9f-733682514451@linaro.org>
In-Reply-To: <0dd6b0e8-be0e-423d-8e9f-733682514451@linaro.org>
From: Max Chou <max.chou@sifive.com>
Date: Thu, 27 Aug 2026 20:48:15 +0800
X-Gm-Features: AcwNN1Vh6gEf11JYdX9Ob1simiW30vetkgNOsdfcm3dF2Ft7TkT1cHXs04W9c-M
Message-ID: <CANiaA1swNafzXUVe_4Z4S5p+XS96DcBWPGQ3ZrdR52pW0dBtmA@mail.gmail.com>
Subject: Re: [PATCH 11/23] target/riscv: Rewrite vext_ldff
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000091e3ba065a06c098"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=max.chou@sifive.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000091e3ba065a06c098
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 27, 2026 at 05:33 Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/26/26 11:40, Max Chou wrote:
> > Sorry, my previous example was unclear. It does not need a 1-byte PMP
> > region: RISC-V PMP definition allows the minimum 4-byte PMP region,
> > which exactly matches one e32 element.
> >
> > For example, with vl=3, vstart=0, e32, and v0.mask = [1, 0, 1],
> > configure locked PMP entries as follows:
> >
> >    PMP0: NA4   [base + 4, base + 7], L, ---    # element 1, no read
> >    PMP1: NAPOT target page,          L, R      # lower-priority page
> allow
> >
> >    bytes:       base       base + 4     base + 8
> >                 +-----+    +-----+      +-----+
> >    element:       0          1            2
> >    mask:          1          0            1
> >    access:     active      inactive      active
> >    PMP:        PMP1 R      PMP0 ---      PMP1 R
> >
> > The RISC-V spec defines that masked vector loads access memory and raise
> > exceptions only for active elements.
> > Therefore this situation has reads only for elements 0 and 2; PMP0 must
> > not create an access-fault condition for this instruction.
> >
> > My concern is that the page probe may be unsafe in some situations
> > because PMP permissions can change at 4-byte granularity inside a
> > target page, while the probe includes bytes which are not part of
> > active vector memory operations.
> >
> > Maybe we could use the page probe only when it returns flags == 0,
> > and otherwise fall back to checking only active elements or active
> > runs?
>
> Ok, thanks for the clear example.  flags == 0 does not help with this case.
>
> What we want is to probe the first active element, with
> probe_access_full.  For this particular case, where a PMP rule matches
> something smaller than the page, we will have set lg_page_size <
> TARGET_PAGE_BITS.  So we get the fault (or not) for the first element
> exactly, and can then tell via flags and lg_page_size whether the rest
> of the page can use the fast or slow paths.
>
> > I'm trying to create masked fauly-only-first + PMP test for this.
>
> Thanks, that would be helpful.  Similarly for masked not-first-fault,
> please?
>

I am glad to help with this. I will send the test cases for both the fault
at the first element and the no-fault at the first element scenarios for
masked vector fault-only-first instructions to this list.

rnax



>
> r~
>
>

--00000000000091e3ba065a06c098
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div dir=3D"auto"><div dir=3D"auto">On Thu, Aug 27, 2026 at 05:33 Rich=
ard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.h=
enderson@linaro.org</a>&gt; wrote:<div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex" dir=3D"auto">On 8=
/26/26 11:40, Max Chou wrote:<br>
&gt; Sorry, my previous example was unclear. It does not need a 1-byte PMP<=
br>
&gt; region: RISC-V PMP definition allows the minimum 4-byte PMP region,<br=
>
&gt; which exactly matches one e32 element.<br>
&gt;<br>
&gt; For example, with vl=3D3, vstart=3D0, e32, and v0.mask =3D [1, 0, 1],<=
br>
&gt; configure locked PMP entries as follows:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 PMP0: NA4=C2=A0 =C2=A0[base + 4, base + 7], L, ---=C2=A0 =
=C2=A0 # element 1, no read<br>
&gt;=C2=A0 =C2=A0 PMP1: NAPOT target page,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 L, R=C2=A0 =C2=A0 =C2=A0 # lower-priority page allow<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 bytes:=C2=A0 =C2=A0 =C2=A0 =C2=A0base=C2=A0 =C2=A0 =C2=A0=
 =C2=A0base + 4=C2=A0 =C2=A0 =C2=A0base + 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-----+=
=C2=A0 =C2=A0 +-----+=C2=A0 =C2=A0 =C2=A0 +-----+<br>
&gt;=C2=A0 =C2=A0 element:=C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt;=C2=A0 =C2=A0 mask:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0 access:=C2=A0 =C2=A0 =C2=A0active=C2=A0 =C2=A0 =C2=A0 ina=
ctive=C2=A0 =C2=A0 =C2=A0 active<br>
&gt;=C2=A0 =C2=A0 PMP:=C2=A0 =C2=A0 =C2=A0 =C2=A0 PMP1 R=C2=A0 =C2=A0 =C2=
=A0 PMP0 ---=C2=A0 =C2=A0 =C2=A0 PMP1 R<br>
&gt;<br>
&gt; The RISC-V spec defines that masked vector loads access memory and rai=
se<br>
&gt; exceptions only for active elements.<br>
&gt; Therefore this situation has reads only for elements 0 and 2; PMP0 mus=
t<br>
&gt; not create an access-fault condition for this instruction.<br>
&gt;<br>
&gt; My concern is that the page probe may be unsafe in some situations<br>
&gt; because PMP permissions can change at 4-byte granularity inside a<br>
&gt; target page, while the probe includes bytes which are not part of<br>
&gt; active vector memory operations.<br>
&gt;<br>
&gt; Maybe we could use the page probe only when it returns flags =3D=3D 0,=
<br>
&gt; and otherwise fall back to checking only active elements or active<br>
&gt; runs?<br>
<br>
Ok, thanks for the clear example.=C2=A0 flags =3D=3D 0 does not help with t=
his case.<br>
<br>
What we want is to probe the first active element, with <br>
probe_access_full.=C2=A0 For this particular case, where a PMP rule matches=
 <br>
something smaller than the page, we will have set lg_page_size &lt; <br>
TARGET_PAGE_BITS.=C2=A0 So we get the fault (or not) for the first element =
<br>
exactly, and can then tell via flags and lg_page_size whether the rest <br>
of the page can use the fast or slow paths.<br>
<br>
&gt; I&#39;m trying to create masked fauly-only-first + PMP test for this.<=
br>
<br>
Thanks, that would be helpful.=C2=A0 Similarly for masked not-first-fault, =
<br>
please?<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto"><div style=3D"fo=
nt-size:inherit" dir=3D"auto"><span style=3D"font-size:inherit;font-style:n=
ormal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;text-decoration:none;float:none;di=
splay:inline!important;background-color:rgba(0,0,0,0);border-color:rgb(0,0,=
0);color:rgb(0,0,0)"></span><div style=3D"font-size:inherit" dir=3D"auto"><=
span style=3D"font-size:inherit;font-style:normal;font-weight:400;letter-sp=
acing:normal;text-indent:0px;text-transform:none;white-space:normal;word-sp=
acing:0px;text-decoration:none;float:none;display:inline!important;backgrou=
nd-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">I am glad =
to help with this. I will send the test cases for both the fault at the fir=
st element and the no-fault at the first element scenarios for masked vecto=
r fault-only-first instructions to this list.</span><br style=3D"color:rgb(=
255,255,255);font-family:-apple-system,&quot;sans-serif&quot;;font-size:inh=
erit;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:n=
one"><br style=3D"color:rgb(255,255,255);font-family:-apple-system,&quot;sa=
ns-serif&quot;;font-size:inherit;font-style:normal;font-weight:400;letter-s=
pacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none"><span style=3D"font-size:inherit;font-styl=
e:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;text-decoration:none;float:none=
;display:inline!important;background-color:rgba(0,0,0,0);border-color:rgb(0=
,0,0);color:rgb(0,0,0)">rnax</span></div><span style=3D"font-size:inherit;f=
ont-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text=
-transform:none;white-space:normal;word-spacing:0px;text-decoration:none;fl=
oat:none;display:inline!important;background-color:rgba(0,0,0,0);border-col=
or:rgb(0,0,0);color:rgb(0,0,0)"></span><br style=3D"color:rgb(255,255,255);=
font-family:-apple-system,&quot;sans-serif&quot;;font-size:inherit;font-sty=
le:normal;font-weight:400;letter-spacing:normal;text-indent:0px;text-transf=
orm:none;white-space:normal;word-spacing:0px;text-decoration:none"><br></di=
v></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
r~<br>
<br>
</blockquote></div></div></div></div>

--00000000000091e3ba065a06c098--

