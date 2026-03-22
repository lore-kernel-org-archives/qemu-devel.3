Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565DFC72AD
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 14:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Jvv-0007Se-KD; Sun, 22 Mar 2026 10:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1w4Jvr-0007SD-PL
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 10:37:35 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihang.lin@gmail.com>)
 id 1w4Jvq-0007Ua-4f
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 10:37:35 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-94ac3958788so1988337241.0
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2026 07:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774190253; cv=none;
 d=google.com; s=arc-20240605;
 b=Pk365LrTTqv8ovIRK1g24SQvOs2ymT6UH5x/TiAYiDsgZA8wpJmAHf8bEuf9510u3y
 WPPTAb1KP2/tFYAP1RQiQkJfjI22QlRT4bsRtspTTQaLQv4Khqfp/O59BPVNCazKkVY5
 ht+sDDPqAdOpLC1vW2iF3suw5UhkfdBtIl3ceqRTHGfFCphasjM18Mf57JE2O3CZboeq
 0gcS6EuVsDa1xy9Qrefh5eHHMRC60ca1dPleHAhL90WpPQOyP4oLO81pD4kCa9mcMuiK
 ZXPM8q1Vn4sjcxpnrx3J7rWuyZATFEDyykO/hM5F1qFb+nMDA7ZSXYjz5z5X7jAmXPcr
 jbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6/XVdDNZBk7cNq/Pb8AUnE87Ytj3I7iQPvdwhXJiZ04=;
 fh=3GTBalfkKWi4/O/tERlh1Ni+3Fw39fwN9nrYjU8qlSo=;
 b=FdkFugdYuBjqptmDocJe/3xzuJrRCZJZRy4hGo08nOHJoIaX41/YBVM9sNUwYko+kU
 lvza7jlARSD+mvFM9Kpw/yM9xsl7EvkeuDRXZcl/4w5UQeku2uLdqRlqUkeRJIoHAY0n
 VJI3xsCOAZz0j3x73Xyv+SrvFyizbkt22AyhPwT+f/M+SmXgNItjuHHkedo4zPs3RaIb
 GHPENsU9o0xa22DqBqMnPgKL4U+2WLFL/SScOtf+LUSFT/XkXVx7SWSYAW/bNNe4/ESN
 uwj+0ZdSdzCeoG4ehQqmTv8vrXIbEU901g7EFEhCmMgAlRuMkWuqdh1Z5MQ6z8Iw2J4u
 b/7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774190253; x=1774795053; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6/XVdDNZBk7cNq/Pb8AUnE87Ytj3I7iQPvdwhXJiZ04=;
 b=g8xAFlylV2Wd/Fk5VBM7UKvN0PMGQ+ZN/CfjnF/n3AWS4109NKFurgpV95a0tYp5PQ
 5yOxcFr82gEPLlkPh5VLcO512zb7SRc5GlXd3pdYBzK4lGpzjOQ+Nk1DpX6Cf3ee+lrL
 sZRdtUpmp5xPcs81CZdf+smXmPezHDER9KbBPF8zUTyR9kQhubwSKuQ7TPggzsiAAiWA
 b+/wdTOvpVRwCW6mOpjcP0cINDnZy9oKrHh5JjmvVsWVgInlT2uNvTJF6oL59w/K1ial
 28ZFiclXLDVPCt6K5WotCdjvYcPMxBa1CHQNMQdba2txkhKy8tI92NQjOmPI7Cwn65cc
 njSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774190253; x=1774795053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6/XVdDNZBk7cNq/Pb8AUnE87Ytj3I7iQPvdwhXJiZ04=;
 b=K5umi10p3IHy7dRwOijhfPvpH2N9p9yOnNoqW4k1G5ohaEridHE6ywAQfnCGckf924
 XyC7XtRut5+N2rUD7s7hSaJv9vj3gfFVA/OUXGQvojUiUs0FLlEdAFAtojjK1j6mD7i1
 6H+/xalYEOujh/HHtfMuTHubONbwOyPx968i59+0RlNxQJbOt1JdaN4/5kpSLRsI3/6R
 voBere+7fviFkGBqYM8G3XKtlZk9FMKwEsZiSHcizscM71735h6wETmKk7knUfKYzQSl
 7TCDimi8G2FicqGGhS/jRTUmSnTVATCEWOYKGOpFylR9JHYKmxfSgY+bAOw9ZrF2AJMC
 8DwA==
X-Gm-Message-State: AOJu0YyDXrrTRayQTl1PTVz7xzxOPgIRfmYk6ZTdRngJTPS5bLJUz+3e
 V975QVNplqTWbIsemB6JjLKUXWX767Jzh71mO/V2cZAvfeG6u0u2pRTRILLUlEF9ZWznGLRfbhi
 5rxcNev08KNtBMXUN3yjp1er5+emWOOI=
X-Gm-Gg: ATEYQzyObh5bZQSPf4gE8o9QFLZMWc9XjBY4tA1h5cXKe4ko//48VV0u9KrlsznFAEv
 bkHDVtZDN25qNGziWgrtCnRNBgJbDX/kq9bmlwoKvUzBIrhnIhhA8VvrFlbAOEbmD1/UNsVLXtY
 2VKmPQUWf8QCvesXLzPpXCRFo4tw6YtAoD6g8/2tUweVyURkJyn6qiSaHSwdlWh1E9C2/C0/A1c
 ClfJyPQEmc6/xdAABAGBX2AhtJEBeP7cokSCnBq0Gz4UdPRDy3IO6e9k06ccvTXJ4oHRyputSCU
 yD1wPfD+
X-Received: by 2002:a05:6102:b14:b0:5fd:eacf:27df with SMTP id
 ada2fe7eead31-602af6caf4amr3608153137.10.1774190252645; Sun, 22 Mar 2026
 07:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251226064225.791454-1-lihang.lin@gmail.com>
 <35aa3161-0b34-4c0e-adee-975fb8cf24ba@tls.msk.ru>
In-Reply-To: <35aa3161-0b34-4c0e-adee-975fb8cf24ba@tls.msk.ru>
From: Lin Li-Hang <lihang.lin@gmail.com>
Date: Sun, 22 Mar 2026 22:37:21 +0800
X-Gm-Features: AQROBzA4_yStP-_TuZqy0Mf7iUodamu47m5Z5wEgIWQ5DsGMqFM8M8rKyXYgYgI
Message-ID: <CAPR+-WG1cDA0iqqKrxDpA0OB6h3iy1nxDCtoeFQmEOSqn9Yxmg@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/vfp_helper: Fix incorrect bit field
 deposition in rsqrte_f64
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c5e3f9064d9ddb9f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=lihang.lin@gmail.com; helo=mail-ua1-x92e.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000c5e3f9064d9ddb9f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi mjt,

After discussing with Peter, I did further debugging.
The original code is harmless even with the wrong bit position placement.
My patch is not perfect and Peter suggested refactoring those snippets.

Cheers


On Sun, Mar 22, 2026 at 2:20=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:

> On 26.12.2025 09:42, Li-Hang Lin wrote:
> > Fix an error in rsqrte_f64() where the sign bit was being
> > placed incorrectly. Specifically, ensure f64_sign is deposited
> > into bit 63.
> >
> > Additionally, update the comments regarding the exponent (exp) bit
> > width to reflect the correct double-precision specifications.
>
> Ping?  Or is this patch not needed anymore?
>
> Thanks,
>
> /mjt
>
> >   target/arm/tcg/vfp_helper.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
> > index e156e3774a..60188b2c7e 100644
> > --- a/target/arm/tcg/vfp_helper.c
> > +++ b/target/arm/tcg/vfp_helper.c
> > @@ -1078,8 +1078,8 @@ float64 HELPER(rsqrte_f64)(float64 input,
> float_status *s)
> >
> >       f64_frac =3D recip_sqrt_estimate(&f64_exp, 3068, f64_frac, false)=
;
> >
> > -    /* result =3D sign : result_exp<4:0> : estimate<7:0> : Zeros(44) *=
/
> > -    val =3D deposit64(0, 61, 1, f64_sign);
> > +    /* result =3D sign : result_exp<10:0> : estimate<7:0> : Zeros(44) =
*/
> > +    val =3D deposit64(0, 63, 1, f64_sign);
> >       val =3D deposit64(val, 52, 11, f64_exp);
> >       val =3D deposit64(val, 44, 8, extract64(f64_frac, 52 - 8, 8));
> >       return make_float64(val);
>
>

--000000000000c5e3f9064d9ddb9f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi mjt,</div><div><br></div><div>After discussing wit=
h Peter, I did further=C2=A0debugging.</div><div>The original code is harml=
ess even with the wrong bit position placement.</div><div>My patch is not p=
erfect and Peter suggested refactoring those snippets.</div><div><br></div>=
<div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr">Cheers<br></div></div></div><br></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Sun, Mar 22, 2026 at 2:20=E2=80=AFPM Michael Tokarev &lt;<a href=3D"=
mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 26.12.2025 09:42, Li-Hang Lin wrote=
:<br>
&gt; Fix an error in rsqrte_f64() where the sign bit was being<br>
&gt; placed incorrectly. Specifically, ensure f64_sign is deposited<br>
&gt; into bit 63.<br>
&gt; <br>
&gt; Additionally, update the comments regarding the exponent (exp) bit<br>
&gt; width to reflect the correct double-precision specifications.<br>
<br>
Ping?=C2=A0 Or is this patch not needed anymore?<br>
<br>
Thanks,<br>
<br>
/mjt<br>
<br>
&gt;=C2=A0 =C2=A0target/arm/tcg/vfp_helper.c | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c=
<br>
&gt; index e156e3774a..60188b2c7e 100644<br>
&gt; --- a/target/arm/tcg/vfp_helper.c<br>
&gt; +++ b/target/arm/tcg/vfp_helper.c<br>
&gt; @@ -1078,8 +1078,8 @@ float64 HELPER(rsqrte_f64)(float64 input, float_=
status *s)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0f64_frac =3D recip_sqrt_estimate(&amp;f64_ex=
p, 3068, f64_frac, false);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* result =3D sign : result_exp&lt;4:0&gt; : estimate&l=
t;7:0&gt; : Zeros(44) */<br>
&gt; -=C2=A0 =C2=A0 val =3D deposit64(0, 61, 1, f64_sign);<br>
&gt; +=C2=A0 =C2=A0 /* result =3D sign : result_exp&lt;10:0&gt; : estimate&=
lt;7:0&gt; : Zeros(44) */<br>
&gt; +=C2=A0 =C2=A0 val =3D deposit64(0, 63, 1, f64_sign);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D deposit64(val, 52, 11, f64_exp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D deposit64(val, 44, 8, extract64(f64_=
frac, 52 - 8, 8));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return make_float64(val);<br>
<br>
</blockquote></div>

--000000000000c5e3f9064d9ddb9f--

