Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68131D58CBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4mmx-0000j3-M1; Mon, 23 Mar 2026 17:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mmt-0000il-JT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:26:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4mmr-0006bE-Ct
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 17:26:15 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b04b4974abso5998795ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 14:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774301172; cv=none;
 d=google.com; s=arc-20240605;
 b=EkLHf8GNHcKL4905C/e4bRd5LuIesuAsPkThBphqbWZKXL0+V8PPCJfu+LXhiVOrCW
 vHhk25EknsFlLN5xsf/HznQ60NzC3jmp7hO8KLRtajnvcToSEzV0xks7PHJIl7JMCVPL
 Dldm9py/aMxDlLD4i6Ly3LOQ5Xut7JENwx5+JY6VMWt0Mr5pMig5FXDknB7cet/Jo2TG
 rIM8umua0OGF3AmVADtkBOGGYOVrNvAMtjb6NgDDuCO2FgYtaUpQJ7t4h21FhhzUYue1
 tI/gxJKvjNqXX9fIGCAOx6JUFwIyLl7VtogtRUjfRVOc8fP4QdBjn6nT4zMuEqtBc+oX
 vbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GsParKunbz7fZi/ork2mancNGVXqg3hAlcXfghm0kN4=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=NvBHLwi6dlMCwLXb/iyRCLitxCiwz8LbNyoTTQde8c9YQtrEWgavhwGn3UHlrv0C8c
 mChEQxEPsBJ8mMCdTKV6g+uN9cr1ARoq5TxUHbHQartYMVTWzD5m17EaNDuTSoGLC4y9
 gsMZeh5kQJjlV/0g+YTzTTav2X5rNT4m1sZkBp+gyDzJwpn7oqM2+umZ26JiwQBHbIQC
 GNwX5XQB6vkkU9CqHS7I49Tf8Bkr6stBH5fQGRwluKFNnU7clGqy8pPOJSJMAu+LWxhY
 +bduF/JhuOil0i4sDbYcpiQ+NmBV51Z8KyvMYrEwgJIv/ZngVEKZQaJNYkLMuQZV3RfK
 Fbhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774301172; x=1774905972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GsParKunbz7fZi/ork2mancNGVXqg3hAlcXfghm0kN4=;
 b=oi3Hev5RUnx9iLlzoAUVazRynO/kdZ+0/IZXY9sIL7+jnHwbHB6AhB9ZQu5W2Y0zON
 9rKFgZqD1xgl8RVE1+Vkq4mx+SEfMqogBHp1hV3GYk2HNw8yZ4wVRI27JetPgR7Bi6cK
 E/B23MPh73ZstlQ+cjcja17BZN85hTiyk3Bw69TZQ3EtmUk0pZtMXX4+9eTrl81GXe15
 8N5G+dw/Q9lRwmnPF2d3nYSnuX6aLqWAbj2dT0ERatGvR80luBaNvVIY/EL7tmgTMOOz
 ZB0503DrHdrvCzzPoYMdcpoZ2j5PZKkhdsw7Cvm0fJN6v4Pjl+Rv45h1awv6P7A0gKo5
 FFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301172; x=1774905972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsParKunbz7fZi/ork2mancNGVXqg3hAlcXfghm0kN4=;
 b=g3rYlxu8rg8v4wgj9/hJiZ5ovFk1+b0zdgaFmd93MGUcOFMPqTLopkM06l9psoWsEO
 X9eX6+6bHLUVSe/i5U8a8PRjc+JJwjlrZbLYMhtjyWoGiT4BMJwzXkdU3boh+XX+cG90
 SmJNuZ26f2f8iQojlqk1XxCWBjbK6KKChGETpn1ovIXbEvWwPoLJLMoPMQ8nvcVQnBIH
 ymJITJ6W/W+SSbCI1WXdP+Z4hKdsL59gprR3wxGFOvShxAqGuwTuOsUsJAnpGJQrsZS7
 jhBNXvzAnV49hoaMfOT+hnJcOJG1bKfDiEp6XV5bYoFuoaHnfNo1za57rEt36LpFPtQv
 mkew==
X-Gm-Message-State: AOJu0Yyxq4IBibyGmXK7frf1rCh32ebO00Q2CiujAqvasxH9YDqJS13k
 ZJGW6TAuq3rc+cIWm3PmYrAvpve7Y8PG3JJ5qM9UianqUzgukejBphAAi/n7OGnf7B0C3HtvSUb
 7zcXcwckbkx3HYg0+6VfbAlWf9968Aas=
X-Gm-Gg: ATEYQzz5LkVxDXYnEhh/YM6W60MBhLFcMl5gr0QH78/k/HNbaEZCdC52TFcf97sKOVc
 1ixJ9i9wWARLReXIKsbzHM0/d6nGkZd7e1jReE+LhxLTTrkZyIAZGqm++atLNDsdviQFWQHXtyw
 bqhga1ub7YTtbQkSl4c8MotmHMupXUw7+Yq4QHl0ag1cRwahjmrQOHy/qSuOsgqUer0j0QB9OrQ
 NJSNqMj0lci0pdiyX/ekic6L7WmBIWb313ZnCHPAdLxsAqYtGGpEucxd0UNIo91Td2guzhvNiG4
 4+F0BDORyB7BFzvNm/QeF7ql4IEPvfoplsBuV6U=
X-Received: by 2002:a17:903:283:b0:2b0:5bfc:8af4 with SMTP id
 d9443c01a7336-2b0827a4001mr128167385ad.34.1774301171827; Mon, 23 Mar 2026
 14:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <b648b6b7ce4b4c1ab3bc00016d9233a5ede3563b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <b648b6b7ce4b4c1ab3bc00016d9233a5ede3563b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 15:25:59 -0600
X-Gm-Features: AaiRm52ZYF830kFAiMr_v6x-WKPRA88D_sYZLQ07yjggUtFhyPlAkqErgvBbfro
Message-ID: <CAATN3Np8aWjb8PyoupVpWCWc8thTLghWn974OVC7M_-opqSrSQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] target/hexagon: add v68 HVX IEEE float conversion
 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000012485f064db7afc6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62b.google.com
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

--00000000000012485f064db7afc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point conversion instructions:
> - vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations
> - vcvt_hf_sf, vcvt_sf_hf: float <-> half float conversions
> - vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float
> - vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/kvx_ieee.h              | 21 +++++
>  target/hexagon/mmvec/kvx_ieee.c              | 98 ++++++++++++++++++++
>  target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 97 +++++++++++++++++++
>  4 files changed, 234 insertions(+)
>
> diff --git a/target/hexagon/mmvec/kvx_ieee.c
> b/target/hexagon/mmvec/kvx_ieee.c
> index 33621a15f3..bbeec09707 100644
> --- a/target/hexagon/mmvec/kvx_ieee.c
> +++ b/target/hexagon/mmvec/kvx_ieee.c
> @@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2,
> float_status *fp_status)
>      if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a1;
>      return fp_min_hf(a1, a2, fp_status);
>  }
> +
> +uint16_t f32_to_f16(uint32_t a, float_status *fp_status)
> +{
> +    return float16_val(float32_to_float16(make_float32(a), true,
> fp_status));
> +}
> +
> +uint32_t f16_to_f32(uint16_t a, float_status *fp_status)
> +{
> +    return float32_val(float16_to_float32(make_float16(a), true,
> fp_status));
> +}
> +
> +uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)
> +{
> +    return float16_to_uint16_scalbn(make_float16(op1),
> +                                    float_round_nearest_even,
>

Does HVX always use this rounding mode?  The scalar core uses the rounding
mode in USR.

There are several more instances below.


> +                                    0, fp_status);
> +}
> +
> +int16_t f16_to_h(uint16_t op1, float_status *fp_status)
> +{
> +    return float16_to_int16_scalbn(make_float16(op1),
> +                                   float_round_nearest_even,

+                                   0, fp_status);
> +}
> +
> +uint8_t f16_to_ub(uint16_t op1, float_status *fp_status)
> +{
> +    return float16_to_uint8_scalbn(make_float16(op1),
> +                                   float_round_nearest_even,

+                                   0, fp_status);
> +}
> +
> +int8_t f16_to_b(uint16_t op1, float_status *fp_status)
> +{
> +    return float16_to_int8_scalbn(make_float16(op1),
> +                                   float_round_nearest_even,

+                                   0, fp_status);
> +}
> +
> +uint16_t uh_to_f16(uint16_t op1)
> +{
> +    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
> +}
> +
> +uint16_t h_to_f16(int16_t op1)
> +{
> +    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
> +}
> +
> +uint16_t ub_to_f16(uint8_t op1)
> +{
> +    return uint64_to_float16_scalbn(op1, float_round_nearest_even, 0);
> +}
> +
> +uint16_t b_to_f16(int8_t op1)
> +{
> +    return int64_to_float16_scalbn(op1, float_round_nearest_even, 0);
> +}
> +
> +int32_t conv_sf_w(int32_t a, float_status *fp_status)
> +{
> +    return float32_val(int32_to_float32(a, fp_status));
> +}
> +
> +int16_t conv_hf_h(int16_t a, float_status *fp_status)
> +{
> +    return float16_val(int16_to_float16(a, fp_status));
> +}
> +
> +int32_t conv_w_sf(uint32_t a, float_status *fp_status)
> +{
> +    float_status scratch_fpst =3D {};
> +    const float32 W_MAX =3D int32_to_float32(INT32_MAX, &scratch_fpst);
> +    const float32 W_MIN =3D int32_to_float32(INT32_MIN, &scratch_fpst);
> +    float32 f1 =3D make_float32(a);
> +
> +    if (float32_is_any_nan(f1) || float32_is_infinity(f1) ||
> +        float32_le_quiet(W_MAX, f1, fp_status) ||
> +        float32_le_quiet(f1, W_MIN, fp_status)) {
> +        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
> +    }
>

Does float32_to_int32 handle these checks?


> +    return float32_to_int32_round_to_zero(f1, fp_status);
>

Rounding mode?


> +}
> +
> +int16_t conv_h_hf(uint16_t a, float_status *fp_status)
> +{/
> +    float_status scratch_fpst =3D {};
> +    const float16 H_MAX =3D int16_to_float16(INT16_MAX, &scratch_fpst);
> +    const float16 H_MIN =3D int16_to_float16(INT16_MIN, &scratch_fpst);
> +    float16 f1 =3D make_float16(a);
> +
> +    if (float16_is_any_nan(f1) || float16_is_infinity(f1) ||
> +        float16_le_quiet(H_MAX, f1, fp_status) ||
> +        float16_le_quiet(f1, H_MIN, fp_status)) {
> +        return float16_is_neg(f1) ? INT16_MIN : INT16_MAX;
> +    }
> +    return float16_to_int16_round_to_zero(f1, fp_status);
> +}
>

Ditto

Thanks,
Taylor

--00000000000012485f064db7afc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point conversion instructions:<br>
- vconv_hf_h, vconv_h_hf, vconv_sf_w, vconv_w_sf: vconv operations<br>
- vcvt_hf_sf, vcvt_sf_hf: float &lt;-&gt; half float conversions<br>
- vcvt_hf_b, vcvt_hf_h, vcvt_hf_ub, vcvt_hf_uh: int to half float<br>
- vcvt_b_hf, vcvt_h_hf, vcvt_ub_hf, vcvt_uh_hf: half float to int<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 21 +++++<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 98 ++++++++++++++++++++<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 18 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 97=
 +++++++++++++++++++<br>
=C2=A04 files changed, 234 insertions(+)<br>
<br>diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx=
_ieee.c<br>
index 33621a15f3..bbeec09707 100644<br>
--- a/target/hexagon/mmvec/kvx_ieee.c<br>
+++ b/target/hexagon/mmvec/kvx_ieee.c<br>
@@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_st=
atus *fp_status)<br>
=C2=A0 =C2=A0 =C2=A0if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) r=
eturn a1;<br>
=C2=A0 =C2=A0 =C2=A0return fp_min_hf(a1, a2, fp_status);<br>
=C2=A0}<br>
+<br>
+uint16_t f32_to_f16(uint32_t a, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_val(float32_to_float16(make_float32(a), true,=
 fp_status));<br>
+}<br>
+<br>
+uint32_t f16_to_f32(uint16_t a, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float32_val(float16_to_float32(make_float16(a), true,=
 fp_status));<br>
+}<br>
+<br>
+uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_to_uint16_scalbn(make_float16(op1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_round_nearest_ev=
en,<br></blockquote><div><br></div><div>Does HVX always use this rounding m=
ode?=C2=A0 The scalar core uses the rounding mode in USR.</div><div><br></d=
iv><div>There are several more instances below.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, fp_status);<br>
+}<br>
+<br>
+int16_t f16_to_h(uint16_t op1, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_to_int16_scalbn(make_float16(op1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_round_nearest_eve=
n,=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, fp_status);<br>
+}<br>
+<br>
+uint8_t f16_to_ub(uint16_t op1, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_to_uint8_scalbn(make_float16(op1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_round_nearest_eve=
n,</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, fp_status);<br>
+}<br>
+<br>
+int8_t f16_to_b(uint16_t op1, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_to_int8_scalbn(make_float16(op1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_round_nearest_eve=
n,</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, fp_status);<br>
+}<br>
+<br>
+uint16_t uh_to_f16(uint16_t op1)<br>
+{<br>
+=C2=A0 =C2=A0 return uint64_to_float16_scalbn(op1, float_round_nearest_eve=
n, 0);<br>
+}<br>
+<br>
+uint16_t h_to_f16(int16_t op1)<br>
+{<br>
+=C2=A0 =C2=A0 return int64_to_float16_scalbn(op1, float_round_nearest_even=
, 0);<br>
+}<br>
+<br>
+uint16_t ub_to_f16(uint8_t op1)<br>
+{<br>
+=C2=A0 =C2=A0 return uint64_to_float16_scalbn(op1, float_round_nearest_eve=
n, 0);<br>
+}<br>
+<br>
+uint16_t b_to_f16(int8_t op1)<br>
+{<br>
+=C2=A0 =C2=A0 return int64_to_float16_scalbn(op1, float_round_nearest_even=
, 0);<br>
+}<br>
+<br>
+int32_t conv_sf_w(int32_t a, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float32_val(int32_to_float32(a, fp_status));<br>
+}<br>
+<br>
+int16_t conv_hf_h(int16_t a, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 return float16_val(int16_to_float16(a, fp_status));<br>
+}<br>
+<br>
+int32_t conv_w_sf(uint32_t a, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 float_status scratch_fpst =3D {};<br>
+=C2=A0 =C2=A0 const float32 W_MAX =3D int32_to_float32(INT32_MAX, &amp;scr=
atch_fpst);<br>
+=C2=A0 =C2=A0 const float32 W_MIN =3D int32_to_float32(INT32_MIN, &amp;scr=
atch_fpst);<br>
+=C2=A0 =C2=A0 float32 f1 =3D make_float32(a);<br>
+<br>
+=C2=A0 =C2=A0 if (float32_is_any_nan(f1) || float32_is_infinity(f1) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float32_le_quiet(W_MAX, f1, fp_status) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float32_le_quiet(f1, W_MIN, fp_status)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return float32_is_neg(f1) ? INT32_MIN : INT32_=
MAX;<br>
+=C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Does float32_to_int32 =
handle these checks?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+=C2=A0 =C2=A0 return float32_to_int32_round_to_zero(f1, fp_status);<br></b=
lockquote><div><br></div><div>Rounding mode?</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+}<br>
+<br>
+int16_t conv_h_hf(uint16_t a, float_status *fp_status)<br>
+{/<br>
+=C2=A0 =C2=A0 float_status scratch_fpst =3D {};<br>
+=C2=A0 =C2=A0 const float16 H_MAX =3D int16_to_float16(INT16_MAX, &amp;scr=
atch_fpst);<br>
+=C2=A0 =C2=A0 const float16 H_MIN =3D int16_to_float16(INT16_MIN, &amp;scr=
atch_fpst);<br>
+=C2=A0 =C2=A0 float16 f1 =3D make_float16(a);<br>
+<br>
+=C2=A0 =C2=A0 if (float16_is_any_nan(f1) || float16_is_infinity(f1) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float16_le_quiet(H_MAX, f1, fp_status) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float16_le_quiet(f1, H_MIN, fp_status)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return float16_is_neg(f1) ? INT16_MIN : INT16_=
MAX;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return float16_to_int16_round_to_zero(f1, fp_status);<br>
+}<br></blockquote><div><br></div><div>Ditto</div><div>=C2=A0</div><div>Tha=
nks,</div><div>Taylor</div><div><br></div></div></div>

--00000000000012485f064db7afc6--

