Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2833109192D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Cq7-0007Z3-1F; Tue, 24 Mar 2026 21:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w5Cq4-0007WZ-Nw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:15:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w5Cq2-00043t-S0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:15:16 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so34453615ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774401313; cv=none;
 d=google.com; s=arc-20240605;
 b=N7nn7EBdzPOqV6ekN212KLDLnvC75nBsGoqx0r/2ZTzHoTCQAoeDjl2x7mqlIlRidO
 DJzHf1rg+ubeD5vEI2d7wFeHNt9kDte5LklOhejPUCoV33E4TzIOf5wLXmIYIZMyQykc
 qLjdmFKINh/iJGoK+N6DNLidwYaVDOc6tdYEVd7pWTvd62z44GbJsMWme9h4yQOo3SWr
 xGD50AgyTL58YFa5CaFm8Z/uzS5evtp+TPhjxTmTweWbeT+x/2B8QMcVRt3Z8gu4EcIA
 vQi3EaOJ8XRrJVCnZK8VBI+L8OkB1nvc7vQZqTV3vDI58VzIkiEdvhS+xrHZ+/QOP6+g
 3rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ubW0pXOIDHxwrPjJS2lJ2HY1rNVZKZBHw2aWGjwnMKI=;
 fh=fJqGvtWqLDKIzOXW1wAsc3/gnAi5Otjc7uqp16gUscQ=;
 b=eVYNZK/aI0WWopr9XQBhRhUpS9+Q6gRbDh3cVI090d03hSA4Snt9fqwTGS9jtTtra5
 N2EORovEVYMUTv/YSCKs/To9tCJTtcCJzL22Q0lfRJyRVMO++ndR/hAaLYJueTNNeUTD
 cP42/T8wOLzCIDrQuaul6wWfYw7SkU998zSsJhLpMHBaifZg8F1/8flokOHYRBiwRfm0
 pmQWQWWkuIyPzOUVC4sXYeOTMVS+uDxIjP4y5bdNE61SwrIQ+uZKlv7bv+21qoGiKvRy
 pT/OWkl5P2TThcjbpTNxdAgiruO2tHr9aF1f9nzn5HuLFYrmQW7hzVhOXL4AyU8dM/ID
 xJMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774401313; x=1775006113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ubW0pXOIDHxwrPjJS2lJ2HY1rNVZKZBHw2aWGjwnMKI=;
 b=ssWtaLnmFmAr22kZaxyNpaln0VYEAk6cwGA+ru1UlYlX/t4stXCgiscXvymOe544q9
 y9IZJAlz3CBT3nJtKLx2T6uDYzyHQMQpZxnDsGTIN2gcdA6DfaLF7XtqkpWLfIbUmiWM
 umDqxyV3JC02MvFrDnmUB84t1wXUEZZFxEkB569g+Qq3UCG+NsYZ45xxHuvu64YQMptQ
 rjB+DrocZtf/ZXjxmHR0JkidSBIsjnv/nH7ZWAOdXhqUmR7gWy6NKJWTpXTHIoE7/cPg
 xm2VsTrUvm1zPfgWPQIdwfHBJCqBqV/+A/lcRo1zglLrOqTxo0gzBjKkMf1hSBABnhbK
 wVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774401313; x=1775006113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubW0pXOIDHxwrPjJS2lJ2HY1rNVZKZBHw2aWGjwnMKI=;
 b=md63Vx6jUFyiiRRVIqRZJHfnvN+D4sz4EUo3yPOVIZIP9OTyTXSU1YxmDZKlfAsODL
 pLucXFV6erEfKtZTy4ysb6uT3CSh6LB6bp18/6hjb3Ow0xGqhwenU7CDyWfU0a5JITNb
 OEmBAPVIaf8eoXd/tDhY96bGdI3AYT+X42rICMrohZYmPL0jIYyKnpuh4VrdawIeLB6H
 a+NIJCar/A+Ljmrd60dAuNOLTyzwgPkrVdAEb3ktRPdgnVUpUeCjIQPAi1o+hal0JIDE
 BFAPEKmbk+QBgGzVGApDc0zLAsaXq/RTc2M85FEC/43PZNY6Cd5lFU6jI+ZzSTU+jPNT
 boEA==
X-Gm-Message-State: AOJu0YzwS4EYFDMiw16imedK5g6VZskAfdElUFLN/OFRWoJIl33dOElS
 FaEV2QVMMe3MZXWTnA7t5x29RfIahwtGdLm6RSEXpjm7twGBUYj84v35yMmUDlXpSf7eNiar7eV
 HfMU2OMOSLTGtjZCwuRKvILM1dBmTeyc=
X-Gm-Gg: ATEYQzwxYrcNl4aUlvy/kHrI3P5TRED7hMNmhLqkDosf1j8azfkqSdVOnsqNYR2xhDC
 Dchgq2KwsjkE/KKLiqVcmw7Lvn0tNzFz06Y47VJe7OBdmRV78lryDaRp0sT790bIzUb8OiyTcwR
 HkpbaIQcMKfzBaWtEj4oYFZxKGgKM6kTQPNkfMgwLXAhPiLLHgMnJ3+TcTGcEGvEOlDPiHkBRHO
 l47vg6okPGRdawHORPq22VAZhYtWejwM6TdA7OsbkOe0Rp2qIA9gvg3ll1waOs0ZbDw/oa4WsmI
 ofaJaxLTlJsjPGgaOxRoEeVOMZb/U201lDYmDKmJ/zqDhpZpBg==
X-Received: by 2002:a17:903:2c0c:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2b0b09a7cc6mr17436235ad.5.1774401313221; Tue, 24 Mar 2026
 18:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <b648b6b7ce4b4c1ab3bc00016d9233a5ede3563b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3Np8aWjb8PyoupVpWCWc8thTLghWn974OVC7M_-opqSrSQ@mail.gmail.com>
 <CABrGZ+GO+G2MrnP1W69vsSCrX_QcEsJw5Zhkd5yd_uhdoegpFQ@mail.gmail.com>
In-Reply-To: <CABrGZ+GO+G2MrnP1W69vsSCrX_QcEsJw5Zhkd5yd_uhdoegpFQ@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Tue, 24 Mar 2026 19:15:00 -0600
X-Gm-Features: AaiRm50EfpfaHG57M0L7EXWlwLjLy61CIl18WfOWgwW3Upmc0vwFdvBU7A9Fki4
Message-ID: <CAATN3Nq__JjhqFYGG84AkP5Jx5HDjM89ZDGee0QownsRh2sTew@mail.gmail.com>
Subject: Re: [PATCH 07/13] target/hexagon: add v68 HVX IEEE float conversion
 insns
To: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000f6b05a064dceff84"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x636.google.com
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

--000000000000f6b05a064dceff84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 3:04=E2=80=AFPM Matheus Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> On Mon, Mar 23, 2026 at 6:26=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gm=
ail.com>
> wrote:
> >
> >
> >
> > On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com> wrote:
> >>
> >>
> >> diff --git a/target/hexagon/mmvec/kvx_ieee.c
> b/target/hexagon/mmvec/kvx_ieee.c
> >> index 33621a15f3..bbeec09707 100644
> >> --- a/target/hexagon/mmvec/kvx_ieee.c
> >> +++ b/target/hexagon/mmvec/kvx_ieee.c
> >> @@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2,
> float_status *fp_status)
> >>      if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a1;
> >>      return fp_min_hf(a1, a2, fp_status);
> >>  }
> >> +
> >> +uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)
> >> +{
> >> +    return float16_to_uint16_scalbn(make_float16(op1),
> >> +                                    float_round_nearest_even,
> >
> >
> > Does HVX always use this rounding mode?  The scalar core uses the
> rounding mode in USR.
>
> Yeah, almost always this mode, with the exception of some
> instructions. It's not configurable via USR (or anything else).
>

You can set that in the hvx_fp_status, and the softfloat lib will handle it
from there.


>
> >> +
> >> +int32_t conv_w_sf(uint32_t a, float_status *fp_status)
> >> +{
> >> +    float_status scratch_fpst =3D {};
> >> +    const float32 W_MAX =3D int32_to_float32(INT32_MAX, &scratch_fpst=
);
> >> +    const float32 W_MIN =3D int32_to_float32(INT32_MIN, &scratch_fpst=
);
> >> +    float32 f1 =3D make_float32(a);
> >> +
> >> +    if (float32_is_any_nan(f1) || float32_is_infinity(f1) ||
> >> +        float32_le_quiet(W_MAX, f1, fp_status) ||
> >> +        float32_le_quiet(f1, W_MIN, fp_status)) {
> >> +        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
> >> +    }
> >
> >
> > Does float32_to_int32 handle these checks?
>
> Hmm, I don't think they are exactly the same. For example,
> float32_to_int32 will return INT32_MAX for any NAN. But the hexagon
> implementation here returns INT32_MIN for negative NAN.
>

Look around in the softfloat code - especially fields in float_status.  Ths
scalar core has a few exceptions, but not alot.

--000000000000f6b05a064dceff84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24,=
 2026 at 3:04=E2=80=AFPM Matheus Bernardino &lt;<a href=3D"mailto:matheus.b=
ernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar =
23, 2026 at 6:26=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsim=
pson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt; wrote:<b=
r>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt=
;<a href=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">m=
atheus.bernardino@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmve=
c/kvx_ieee.c<br>
&gt;&gt; index 33621a15f3..bbeec09707 100644<br>
&gt;&gt; --- a/target/hexagon/mmvec/kvx_ieee.c<br>
&gt;&gt; +++ b/target/hexagon/mmvec/kvx_ieee.c<br>
&gt;&gt; @@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2,=
 float_status *fp_status)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (float16_is_pos_nan(f2) || float16_is_neg_n=
an(f1)) return a1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return fp_min_hf(a1, a2, fp_status);<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 return float16_to_uint16_scalbn(make_float16(op1),<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_round_=
nearest_even,<br>
&gt;<br>
&gt;<br>
&gt; Does HVX always use this rounding mode?=C2=A0 The scalar core uses the=
 rounding mode in USR.<br>
<br>
Yeah, almost always this mode, with the exception of some<br>
instructions. It&#39;s not configurable via USR (or anything else).<br></bl=
ockquote><div><br></div><div>You can set that in the hvx_fp_status, and the=
 softfloat lib=C2=A0will handle=C2=A0it from there.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; +<br>
&gt;&gt; +int32_t conv_w_sf(uint32_t a, float_status *fp_status)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 float_status scratch_fpst =3D {};<br>
&gt;&gt; +=C2=A0 =C2=A0 const float32 W_MAX =3D int32_to_float32(INT32_MAX,=
 &amp;scratch_fpst);<br>
&gt;&gt; +=C2=A0 =C2=A0 const float32 W_MIN =3D int32_to_float32(INT32_MIN,=
 &amp;scratch_fpst);<br>
&gt;&gt; +=C2=A0 =C2=A0 float32 f1 =3D make_float32(a);<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (float32_is_any_nan(f1) || float32_is_infinity(f=
1) ||<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float32_le_quiet(W_MAX, f1, fp_status=
) ||<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 float32_le_quiet(f1, W_MIN, fp_status=
)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return float32_is_neg(f1) ? INT32_MIN=
 : INT32_MAX;<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;<br>
&gt; Does float32_to_int32 handle these checks?<br>
<br>
Hmm, I don&#39;t think they are exactly the same. For example,<br>
float32_to_int32 will return INT32_MAX for any NAN. But the hexagon<br>
implementation here returns INT32_MIN for negative NAN.<br></blockquote><di=
v><br></div><div>Look around in the softfloat code - especially fields in f=
loat_status.=C2=A0 Ths scalar core has a few exceptions, but not alot.</div=
><div>=C2=A0</div></div></div>

--000000000000f6b05a064dceff84--

