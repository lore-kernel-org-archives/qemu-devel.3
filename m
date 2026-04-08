Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5633210FC456
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAcGS-0003Wx-TI; Wed, 08 Apr 2026 19:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcGI-0003WE-Gc
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:24:45 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAcGG-0007Rq-JE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 19:24:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so225891a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 16:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775690678; cv=none;
 d=google.com; s=arc-20240605;
 b=Opuj0d35F1i8W9HYxTsoI1c5EtF9QpRS//xBIh454j4FxGOzt91NcwriXBe4lKPhmK
 Dlj48r0oI2GwnNbj/1ulYXQmBuy9/MVcjjfDavB0sdNFYxfGfklVT7eonHp+AcTO7aGL
 V9Wkl0qDQ7ijcFWjaVaRXKGzAPZ8qyBCMscu53Ia0aPZqyMONgUARD9agMVjn340Fgko
 wluDC+qBkfH5xxqi9iifW7zjj1/aKMivd5uvg/uzo2IjtG9WV8QDUb+MX1aXEPfsr4rQ
 4yQwN++uS6FcF1EyRQXh9KT2OSlq9gkZPD0+4rbZuu2ce8H0cAjl30bKAyPqkQcXNA29
 gLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lwts0fTOcfq70fpki1O/21ompUjW4ySjfMTqwilPc1k=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=SzvV0OdUBucAvJ2ccZboFUXvJZbXDnVuFbHyV3fsjPQ7bcZRNnE9sOeGJr1uofo9y/
 AT79yPr0Y1Dy/x7EtY5zBxgvLqgZC4idAGe6mkpvk/uV+b+5Y642xBRwVLAtJNmS/LhQ
 8ec4DQS/P63+Ik7N2sEL5D9ZfVNAWYR1WADLCPGyI56hKXR/rUl30jaScR839dPmgFPD
 Cn14h5DORDLKFt7q11IV1A/S/T2Qg8pj9ChSGBWJ1ieO6TDNcgKBajqydHJaY8rlbH+s
 gSoOHjVn29ovII3F/u3HnznJ8bVRGCYDLDpwUzCoIc9aOLh18GtdOc/XEfB0pqcTRNAW
 qvZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775690678; x=1776295478; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lwts0fTOcfq70fpki1O/21ompUjW4ySjfMTqwilPc1k=;
 b=hsFVFYa62b2Ep0UcH6KnJfLPMEIVNW2ENpGWGFSx7Eou4lVfh4xUQzdhwqyf3t5M91
 zYBi0EPzh+A9TiflMXQQn9L2t3yypzWcsAocQ7gz1UDFJPrIBepLpo9uCiCpXfYo+laX
 n85pkUYzf3OcgkdbDWVVhrtsLwmu3rFJjQjMR1n8Qk7VcRAtAXt2e1VGiS2z67PGea6t
 /D21H/qGF3hI5TKLJD65HcK7UkpyAmL0FsEH9DP9HUUPGynYMC+oQNk+zqnko3lVjkzw
 ju5YjlhA6f9nFZsVT4jhNxUubNzuHN7mmY5xrRH9D5uAtxcClKB/tREXf8lqoZ/8w/Vj
 A/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775690678; x=1776295478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lwts0fTOcfq70fpki1O/21ompUjW4ySjfMTqwilPc1k=;
 b=p1mZ2QR4U9EzPbyFQkGtweap51LuZd73LUQTM7EossNsabkYxit8AZGtn9cDjDLHxG
 5Nb4xLIpuEF9Z6Lw2VrYbCMwe4KLL3R+3KGxLZWwbEkxk8RaWC8ViXYlxybbqxCTp1h0
 XJdIuzMT9ujSJ/m5nms7AL0e+RV66zGmCyhePa66ILaXc0LLgMkHiq8YX6NEgvMw2F/I
 G/1Usr7TUDotH5VVw34tfpb5coIDS10asO+PFcPJyAOZCACwFwL5LlONQSQRD0g0JhgU
 +AE3qt0vshvNw0v/0YVImTt7xnBDsC+EcNWr/aCOke7mRKMUZT/wbubFd200kdMBp4B4
 50BQ==
X-Gm-Message-State: AOJu0YxC/2r11GXjmDCYWsOqxeu0Dj48W0AfcwK2xGWZyQZUuhDDELgp
 6KiOUCrIzEgJp0xLrvkcvI1X0zyvZ9RYpXJzn2JbK4fA8M7hMLoLfqmGHmf+Fud3RhI23EmkSMB
 fqS7bVsnS/nfCHKKpHut4C+56Oskpxuw=
X-Gm-Gg: AeBDietWF+9+05cm3pUHHPBcMEe9z9LRgRYL2nAy5OBaS5dlOuKjJj5aGPMnVgxNphW
 LzIwASG2vXLRO5dsRoW8ssLVzSHNJt4z7zu01CVwMnvDm4YLgAYVlBR/4RRu4MtSlBsnJ5acgmw
 XEQhHxjnLn2mpHhFa4ICYTMI2sPqv6KnEaLMt3GYpac8ga3OKdNRFds0IhK+LSix06lcy15qufl
 9XT4rM/2KCFysbVlajuIQIryaFsdRNXnYo/x0vBH5ITApfcI4pQzb6MGbofCSS5yKA9zmjdFDq+
 Ie0FqB1f1hyCs7qgT5pbg/85I7bKz0/0dh7vheg=
X-Received: by 2002:a17:90b:384b:b0:35b:a760:1a54 with SMTP id
 98e67ed59e1d1-35e358437bamr1187482a91.18.1775690678093; Wed, 08 Apr 2026
 16:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <01040724683b0329a732666a2b839afade5d72e1.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <01040724683b0329a732666a2b839afade5d72e1.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 17:24:26 -0600
X-Gm-Features: AQROBzCKCUkt25yr9hX9YYVxE0I_a5L4nLys0seOPuPeX8QWNhr1h-HGtl0Op_I
Message-ID: <CAATN3NpzM+pd9DRV0W9ahVSMOMcPKd=zFHRY67vF=Xcn6R7eBA@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] target/hexagon: add v68 HVX IEEE float min/max
 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000194ade064efb3466"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pj1-x102f.google.com
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

--000000000000194ade064efb3466
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point min/max instructions:
> - vfmin_hf, vfmin_sf: IEEE floating-point minimum
> - vfmax_hf, vfmax_sf: IEEE floating-point maximum
> - vmax_hf, vmax_sf: qfloat IEEE maximum
> - vmin_hf, vmin_sf: qfloat IEEE minimum
>
> The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
> handle NaN slightly differently. See comment on hvx_ieee_fp.h
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  6 +++
>  target/hexagon/attribs_def.h.inc             |  2 +
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 49 ++++++++++++++++++++
>  target/hexagon/hex_common.py                 |  1 +
>  target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 36 +++++++++++++-
>  6 files changed, 103 insertions(+), 1 deletion(-)
>
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h
> b/target/hexagon/mmvec/hvx_ieee_fp.h
> index 75008deb3b..ed8e4f2da9 100644
> --- a/target/hexagon/mmvec/hvx_ieee_fp.h
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.h
> @@ -15,4 +15,10 @@ float32 fp_mult_sf_hf(float16 a1, float16 a2,
> float_status *fp_status);
>  float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,
>                   float_status *fp_status);
>
> +/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller
> than -INF */
> +uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
> +uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
> +uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>

Use float32/float16 instead of uint32_t/uint16_t.  That's what the
implementations below have.


> +
>  #endif
> diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c
> b/target/hexagon/mmvec/hvx_ieee_fp.c
> index 3367226998..868c0c5b18 100644
> --- a/target/hexagon/mmvec/hvx_ieee_fp.c
> +++ b/target/hexagon/mmvec/hvx_ieee_fp.c
> @@ -19,3 +19,52 @@ float32 fp_vdmpy(float16 a1, float16 a2, float16 a3,
> float16 a4,
>      return float32_add(fp_mult_sf_hf(a1, a3, fp_status),
>                         fp_mult_sf_hf(a2, a4, fp_status), fp_status);
>  }
> +
> +#define float32_is_pos_nan(X) (float32_is_any_nan(X) &&
> !float32_is_neg(X))
> +#define float32_is_neg_nan(X) (float32_is_any_nan(X) && float32_is_neg(X=
))
> +#define float16_is_pos_nan(X) (float16_is_any_nan(X) &&
> !float16_is_neg(X))
> +#define float16_is_neg_nan(X) (float16_is_any_nan(X) && float16_is_neg(X=
))
> +
>

I would go ahead and repeat the comment here
/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than
-INF */


> +float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status)
> +{
> +    if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {
> +        return a1;
> +    }
> +    if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {
> +        return a2;
> +    }
> +    return float32_max(a1, a2, fp_status);
> +}
>

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

--000000000000194ade064efb3466
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point min/max instructions:<br>
- vfmin_hf, vfmin_sf: IEEE floating-point minimum<br>
- vfmax_hf, vfmax_sf: IEEE floating-point maximum<br>
- vmax_hf, vmax_sf: qfloat IEEE maximum<br>
- vmin_hf, vmin_sf: qfloat IEEE minimum<br>
<br>
The Hexagon qfloat variants are similar to the IEEE-754 ones, but they<br>
handle NaN slightly differently. See comment on hvx_ieee_fp.h<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 +++<br>
=C2=A0target/hexagon/attribs_def.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0target/hexagon/mmvec/hvx_ieee_fp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 49 ++++++++++++++++++++<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 10 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 36=
 +++++++++++++-<br>
=C2=A06 files changed, 103 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_=
ieee_fp.h<br>
index 75008deb3b..ed8e4f2da9 100644<br>
--- a/target/hexagon/mmvec/hvx_ieee_fp.h<br>
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h<br>
@@ -15,4 +15,10 @@ float32 fp_mult_sf_hf(float16 a1, float16 a2, float_stat=
us *fp_status);<br>
=C2=A0float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, float16 a4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_status=
 *fp_status);<br>
<br>
+/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller than=
 -INF */<br>
+uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<br>
+uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>
+uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<br>=
</blockquote><div><br></div><div>Use float32/float16 instead of uint32_t/ui=
nt16_t.=C2=A0 That&#39;s what the implementations below have.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#endif<br>diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/he=
xagon/mmvec/hvx_ieee_fp.c<br>
index 3367226998..868c0c5b18 100644<br>
--- a/target/hexagon/mmvec/hvx_ieee_fp.c<br>
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c<br>
@@ -19,3 +19,52 @@ float32 fp_vdmpy(float16 a1, float16 a2, float16 a3, flo=
at16 a4,<br>
=C2=A0 =C2=A0 =C2=A0return float32_add(fp_mult_sf_hf(a1, a3, fp_status),<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fp_mult_sf_hf(a2, a4, fp_status), fp_status);<br>
=C2=A0}<br>
+<br>
+#define float32_is_pos_nan(X) (float32_is_any_nan(X) &amp;&amp; !float32_i=
s_neg(X))<br>
+#define float32_is_neg_nan(X) (float32_is_any_nan(X) &amp;&amp; float32_is=
_neg(X))<br>
+#define float16_is_pos_nan(X) (float16_is_any_nan(X) &amp;&amp; !float16_i=
s_neg(X))<br>
+#define float16_is_neg_nan(X) (float16_is_any_nan(X) &amp;&amp; float16_is=
_neg(X))<br>
+<br></blockquote><div><br></div><div>I would go ahead and repeat the comme=
nt here</div><div>/* Qfloat min/max treat +NaN as greater than +INF and -Na=
N as smaller than -INF */</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+float32 qf_max_sf(float32 a1, float32 a2, float_status *fp_status)<br>
+{<br>
+=C2=A0 =C2=A0 if (float32_is_pos_nan(a1) || float32_is_neg_nan(a2)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return a1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (float32_is_pos_nan(a2) || float32_is_neg_nan(a1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return a2;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return float32_max(a1, a2, fp_status);<br>
+}<br></blockquote><div><br></div><div>Otherwise</div><div>Reviewed-by: Tay=
lor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.com">ltaylorsimpson@=
gmail.com</a>&gt;</div><div>=C2=A0</div></div></div>

--000000000000194ade064efb3466--

