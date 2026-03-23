Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D00F483F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4nMo-0000QQ-BI; Mon, 23 Mar 2026 18:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4nMm-0000Q4-Kh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:03:20 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4nMk-0006Ud-Nu
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:03:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c741bd1ad11so252765a12.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 15:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774303397; cv=none;
 d=google.com; s=arc-20240605;
 b=AI9dzfHouItgO1F9oWEY8LNyk/0kvzCmKvLPhL6GAhUms3pL8xi7eYLmmrpi9u655U
 JvQz22bpHU2T6AZDc+9eULrbc6mNLQfwgUU8Ubd3s9P+uQrJN5a/ojxFseL3pLZChXlq
 X6JvKk4Nvga+JXKNIWgw8pKUG5/e8XAzXSRFqbKoyDnTYs+8CPPSjlqb6FWvmyKKU7i5
 gWVgs+1KrfOfngm4abbGd9M3jmR7mnHyRu0mfhUg/OH3aJGdUkwBJBfdXNAs5/QryxhZ
 hFUQBWJPLwSTO+jU5YmJvYimPPZsIG143xsoh2RS9wB0rUpQXTrzOYznTXz7p8doi4tJ
 +iRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KHq0bTEP1x5NA286VR2q18a4G2aXDazslox/F6zh5eY=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=WMZzVvlqPp6/5bb5ZDWrtFtcMuxtVW8yW3qyJksBHBJI+HJyEGGnwDw3DD+aEwHiuR
 Men7xU2dqmylkpJOpqtYLdLs313/acu+sH6MhnXmzhvDLhWebouptp3WD0IssizUX3Wq
 JpgXnJvsPPmDeZOptbui9vjVGhtOnA4FzRkU9CMmuoR0x4gpWsUwp6uJGpuSxPVNfDsh
 HCpjRFvBP9ctFwZW+foBZHmi28AJnyv2XMyCKZ1Lyb3+YdE3r8leWJ8zHJ5UhU76pC5p
 mT3bvvO0pvQaHJo51aOTIMMZVrrrjW+Pe8hMC/zbZl68QNXxvDap+CmrZgECzm8NIai0
 ZvtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774303397; x=1774908197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KHq0bTEP1x5NA286VR2q18a4G2aXDazslox/F6zh5eY=;
 b=eleACGi/2BB/8Ic5T/9/stack35lri/dTG5OG3EPBrsEB8hmlyk7xm9Qjnwtl4QBOl
 Jm3zJh+JRfEssHRvP07U+JT8h112FVRWIBCCCo1z8Wye2gD/HTbBGKnvzScyxtZbmQil
 iJbukEzetqvF/O7/8e/8nnHqg4l4OYd4r86l68oFsB5CqInAIZGYQT5893yHNmvMbo+9
 b5zAPAmfsIrAPEnDt7uoakbpXSrDSkmAOItQ9smjZWb9ypXc9OFxPh+PkFM2P+a/Vcm3
 1+KZw1FjEuMYMef6amL2mj6DN1X3TrocwIAZ4gtEiQrHJvWEWGSSUqjTmJW4VGQ0fqA0
 QAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774303397; x=1774908197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHq0bTEP1x5NA286VR2q18a4G2aXDazslox/F6zh5eY=;
 b=oAQdFrkHCPc+mT0gwd/5epwGopcuSqvAY9aDkmA2aLpNf8pKpGRhEQ8BYF7TAyesR2
 mySOlvwKDvMvi9ylspvkZ43mnEqbqq8Vw2b2O9t722nGyydkHhS1oxWr0x+vB4lApofW
 HgAGZXkHMFV4KNQuC+WY7MEZDkhdSKEV0VQoQIsfc9KIsiRH5WXg/kn1K6ifOXmIGjHs
 cMLL1udR5rq5WgvI+b3zs1BKmw6wzy4aq8rlHtsm2WUwHxZ55Q96L7AMu8wtT4ZKiQxE
 tqfkkQ89fdbjxmizg+exDLIl9+OuVnlDqgRZXRAhocV5qGe8jvLVTgfVQM4WQdiZHsPx
 VONw==
X-Gm-Message-State: AOJu0YzMrXO4IFzNfHChQ/X0miWsxawFjaVCq2b+SRzTIXW7wdD2ItOz
 dbyOu+peFWXgAgzS3WqOQ9OvpLFl0eoTO8FZfWI1QmETaahjf5aw+A0PNVECr58Y7eZpgHsm35x
 XqIxRBuwgCmyVmd4Ky1mwi5AosH70vKY=
X-Gm-Gg: ATEYQzyH17LqngX2h2Xd3tTjd2UIRY/R1T55F82KxgBN9Akg5sW5FySzTSXQY3O0mlv
 VtYf42/bhKHtIikgzjxWJjZ4Q65uQTU/pUGbAyQ6cAyTzwW90l3EIXXuiqm1KlibQk5q3XRiTm+
 F87yzrTYUJu64Gd7rGAioQ8nzQtu6jMA/dRrSnqo+QWcjioSaLpxG8S6KM+sm8s/Y84Xxcd+CBe
 ir3A9iUbBOCO/w3h7ajiZYRlAignebfvT+zBRZoLMQioHQXVI9s8yISiYVAXyLR3C1a2Kwj+xE4
 GX4knP6YpZtU2QFiVot/mVqTxke2mdnW4oSzHNI=
X-Received: by 2002:a17:903:2408:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2b08272dd67mr121743785ad.21.1774303397025; Mon, 23 Mar 2026
 15:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <003328f47c0b5e286ef06ba55cc9734e7bba4af8.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <003328f47c0b5e286ef06ba55cc9734e7bba4af8.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 16:03:05 -0600
X-Gm-Features: AaiRm53BCrIlKvdfJs6O2y4bs98CHHYyAWTxBfNwlEj0IjhEeathpS3b3Bufj2w
Message-ID: <CAATN3NqVcXGf+ND8KAhR_e78YD8nRJy1_ZL9y-0QBkkQ5rweVw@mail.gmail.com>
Subject: Re: [PATCH 09/13] target/hexagon: add v73 HVX IEEE bfloat16 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000b418ab064db83357"
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x532.google.com
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

--000000000000b418ab064db83357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE bfloat16 (bf16) instructions:
>
> Arithmetic operations:
> - V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output
> - V6_vmpy_sf_bf: multiply bf16 widening to sf output
> - V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output
>
> Min/Max operations:
> - V6_vmin_bf, V6_vmax_bf: bf16 min/max
>
> Comparison operations:
> - V6_vgtbf: greater-than compare
> - V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants
>
> Conversion operations:
> - V6_vcvt_bf_sf: convert sf to bf16
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/kvx_ieee.h              | 36 +++++++++++
>  target/hexagon/mmvec/macros.h                |  5 ++
>  target/hexagon/mmvec/mmvec.h                 |  1 +
>  target/hexagon/mmvec/kvx_ieee.c              |  3 +
>  target/hexagon/imported/mmvec/encode_ext.def | 15 +++++
>  target/hexagon/imported/mmvec/ext.idef       | 64 ++++++++++++++++++++
>  6 files changed, 124 insertions(+)
>
> diff --git a/target/hexagon/mmvec/kvx_ieee.h
> b/target/hexagon/mmvec/kvx_ieee.h
> index 8a6816f6b3..eb670d4ec3 100644
> --- a/target/hexagon/mmvec/kvx_ieee.h
> +++ b/target/hexagon/mmvec/kvx_ieee.h
> @@ -80,4 +80,40 @@ int16_t conv_hf_h(int16_t a, float_status *fp_status);
>  int32_t conv_w_sf(uint32_t a, float_status *fp_status);
>  int16_t conv_h_hf(uint16_t a, float_status *fp_status);
>
> +/* IEEE BFloat instructions */
> +
> +#define fp_mult_sf_bf(A, B) \
> +    fp_mult_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16,
> &env->fp_status)
> +#define fp_add_sf_bf(A, B) \
> +    fp_add_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16,
> &env->fp_status)
> +#define fp_sub_sf_bf(A, B) \
> +    fp_sub_sf_sf(((uint32_t)(A)) << 16, ((uint32_t)(B)) << 16,
> &env->fp_status)
>

Can we use softfloat routine bfloat16_to_float32 instead of shifting by 16?


> +
> +uint32_t fp_mult_sf_bf_acc(uint16_t op1, uint16_t op2, uint32_t acc,
> +                           float_status *fp_status);
> +
> +#define bf_to_sf(A) (((uint32_t)(A)) << 16)
>

Ditto


> +
> +#define fp_min_bf(A, B) ({ \
> +    uint32_t _bf_res =3D fp_min_sf(bf_to_sf(A), bf_to_sf(B),
> &env->fp_status); \
> +    (uint16_t)((_bf_res >> 16) & 0xffff); \
>

float32_to_bfloat16


> +})
> +
> +#define fp_max_bf(A, B) ({ \
> +    uint32_t _bf_res =3D fp_max_sf(bf_to_sf(A), bf_to_sf(B),
> &env->fp_status); \
> +    (uint16_t)((_bf_res >> 16) & 0xffff); \
>

Ditto


> +})
> +
> +static inline uint16_t sf_to_bf(int32_t A)
> +{
> +    uint32_t rslt =3D A;
> +    if ((rslt & 0x1FFFF) =3D=3D 0x08000) {
> +        /* do not round up if exactly .5 and even already */
> +    } else if ((rslt & 0x8000) =3D=3D 0x8000) {
> +        rslt +=3D 0x8000; /* rounding to nearest number */
> +    }
> +    rslt =3D float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;
> +    return rslt >> 16;
> +}
>

float32_to_bfloat16


> +
>  #endif
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.=
h
> index c342507d1a..b70996578e 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -25,6 +25,9 @@
>  #include "accel/tcg/probe.h"
>  #include "mmvec/kvx_ieee.h"
>
> +#define fBFLOAT()
> +#define fCVI_VX_NO_TMP_LD()
> +
>  #ifndef QEMU_GENERATE
>  #define VdV      (*(MMVector *restrict)(VdV_void))
>  #define VsV      (*(MMVector *restrict)(VsV_void))
> @@ -366,4 +369,6 @@
>      (int16_t)(A) > (int16_t)(B) : \
>      float16_compare((A), (B), &env->fp_status) =3D=3D float_relation_gre=
ater)
>
> +#define fCMPGT_BF(A, B) fCMPGT_SF(((int)A) << 16, ((int)B) << 16)
>

bfloat16_to_float32


> +
>  #endif
> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
> index eaedfe0d6d..9d8d57c7c6 100644
> --- a/target/hexagon/mmvec/mmvec.h
> +++ b/target/hexagon/mmvec/mmvec.h
> @@ -40,6 +40,7 @@ typedef union {
>      int8_t    b[MAX_VEC_SIZE_BYTES / 1];
>      int32_t  sf[MAX_VEC_SIZE_BYTES / 4];   /* single float (32-bit) */
>      int16_t  hf[MAX_VEC_SIZE_BYTES / 2];   /* half float (16-bit) */
> +    uint16_t bf[MAX_VEC_SIZE_BYTES / 2];   /* bfloat16 */
>

Consider using bfloat16

Also float32 for sf and float16 for hf.


>  } MMVector;


 Thanks,
Taylor

--000000000000b418ab064db83357
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE bfloat16 (bf16) instructions:<br>
<br>
Arithmetic operations:<br>
- V6_vadd_sf_bf, V6_vsub_sf_bf: add/sub bf16 widening to sf output<br>
- V6_vmpy_sf_bf: multiply bf16 widening to sf output<br>
- V6_vmpy_sf_bf_acc: multiply-accumulate bf16 widening to sf output<br>
<br>
Min/Max operations:<br>
- V6_vmin_bf, V6_vmax_bf: bf16 min/max<br>
<br>
Comparison operations:<br>
- V6_vgtbf: greater-than compare<br>
- V6_vgtbf_and, V6_vgtbf_or, V6_vgtbf_xor: predicate variants<br>
<br>
Conversion operations:<br>
- V6_vcvt_bf_sf: convert sf to bf16<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 36 +++++++++++<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++<br>
=C2=A0target/hexagon/mmvec/mmvec.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 15 +++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 64=
 ++++++++++++++++++++<br>
=C2=A06 files changed, 124 insertions(+)<br>
<br>
diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_iee=
e.h<br>
index 8a6816f6b3..eb670d4ec3 100644<br>
--- a/target/hexagon/mmvec/kvx_ieee.h<br>
+++ b/target/hexagon/mmvec/kvx_ieee.h<br>
@@ -80,4 +80,40 @@ int16_t conv_hf_h(int16_t a, float_status *fp_status);<b=
r>
=C2=A0int32_t conv_w_sf(uint32_t a, float_status *fp_status);<br>
=C2=A0int16_t conv_h_hf(uint16_t a, float_status *fp_status);<br>
<br>
+/* IEEE BFloat instructions */<br>
+<br>
+#define fp_mult_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 fp_mult_sf_sf(((uint32_t)(A)) &lt;&lt; 16, ((uint32_t)(B)) &=
lt;&lt; 16, &amp;env-&gt;fp_status)<br>
+#define fp_add_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 fp_add_sf_sf(((uint32_t)(A)) &lt;&lt; 16, ((uint32_t)(B)) &l=
t;&lt; 16, &amp;env-&gt;fp_status)<br>
+#define fp_sub_sf_bf(A, B) \<br>
+=C2=A0 =C2=A0 fp_sub_sf_sf(((uint32_t)(A)) &lt;&lt; 16, ((uint32_t)(B)) &l=
t;&lt; 16, &amp;env-&gt;fp_status)<br></blockquote><div><br></div><div>Can =
we use softfloat routine bfloat16_to_float32 instead of shifting by 16?</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+uint32_t fp_mult_sf_bf_acc(uint16_t op1, uint16_t op2, uint32_t acc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0float_status *fp_status);<br>
+<br>
+#define bf_to_sf(A) (((uint32_t)(A)) &lt;&lt; 16)<br></blockquote><div><br=
></div><div>Ditto</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+<br>
+#define fp_min_bf(A, B) ({ \<br>
+=C2=A0 =C2=A0 uint32_t _bf_res =3D fp_min_sf(bf_to_sf(A), bf_to_sf(B), &am=
p;env-&gt;fp_status); \<br>
+=C2=A0 =C2=A0 (uint16_t)((_bf_res &gt;&gt; 16) &amp; 0xffff); \<br></block=
quote><div><br></div><div>float32_to_bfloat16</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+})<br>
+<br>
+#define fp_max_bf(A, B) ({ \<br>
+=C2=A0 =C2=A0 uint32_t _bf_res =3D fp_max_sf(bf_to_sf(A), bf_to_sf(B), &am=
p;env-&gt;fp_status); \<br>
+=C2=A0 =C2=A0 (uint16_t)((_bf_res &gt;&gt; 16) &amp; 0xffff); \<br></block=
quote><div><br></div><div>Ditto</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+})<br>
+<br>
+static inline uint16_t sf_to_bf(int32_t A)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t rslt =3D A;<br>
+=C2=A0 =C2=A0 if ((rslt &amp; 0x1FFFF) =3D=3D 0x08000) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do not round up if exactly .5 and even alre=
ady */<br>
+=C2=A0 =C2=A0 } else if ((rslt &amp; 0x8000) =3D=3D 0x8000) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rslt +=3D 0x8000; /* rounding to nearest numbe=
r */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 rslt =3D float32_is_any_nan(A) ? FP32_DEF_NAN : rslt;<br>
+=C2=A0 =C2=A0 return rslt &gt;&gt; 16;<br>
+}<br></blockquote><div><br></div><div>float32_to_bfloat16</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#endif<br>
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h<=
br>
index c342507d1a..b70996578e 100644<br>
--- a/target/hexagon/mmvec/macros.h<br>
+++ b/target/hexagon/mmvec/macros.h<br>
@@ -25,6 +25,9 @@<br>
=C2=A0#include &quot;accel/tcg/probe.h&quot;<br>
=C2=A0#include &quot;mmvec/kvx_ieee.h&quot;<br>
<br>
+#define fBFLOAT()<br>
+#define fCVI_VX_NO_TMP_LD()<br>
+<br>
=C2=A0#ifndef QEMU_GENERATE<br>
=C2=A0#define VdV=C2=A0 =C2=A0 =C2=A0 (*(MMVector *restrict)(VdV_void))<br>
=C2=A0#define VsV=C2=A0 =C2=A0 =C2=A0 (*(MMVector *restrict)(VsV_void))<br>
@@ -366,4 +369,6 @@<br>
=C2=A0 =C2=A0 =C2=A0(int16_t)(A) &gt; (int16_t)(B) : \<br>
=C2=A0 =C2=A0 =C2=A0float16_compare((A), (B), &amp;env-&gt;fp_status) =3D=
=3D float_relation_greater)<br>
<br>
+#define fCMPGT_BF(A, B) fCMPGT_SF(((int)A) &lt;&lt; 16, ((int)B) &lt;&lt; =
16)<br></blockquote><div><br></div><div>bfloat16_to_float32</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0#endif<br>
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h<br=
>
index eaedfe0d6d..9d8d57c7c6 100644<br>
--- a/target/hexagon/mmvec/mmvec.h<br>
+++ b/target/hexagon/mmvec/mmvec.h<br>
@@ -40,6 +40,7 @@ typedef union {<br>
=C2=A0 =C2=A0 =C2=A0int8_t=C2=A0 =C2=A0 b[MAX_VEC_SIZE_BYTES / 1];<br>
=C2=A0 =C2=A0 =C2=A0int32_t=C2=A0 sf[MAX_VEC_SIZE_BYTES / 4];=C2=A0 =C2=A0/=
* single float (32-bit) */<br>
=C2=A0 =C2=A0 =C2=A0int16_t=C2=A0 hf[MAX_VEC_SIZE_BYTES / 2];=C2=A0 =C2=A0/=
* half float (16-bit) */<br>
+=C2=A0 =C2=A0 uint16_t bf[MAX_VEC_SIZE_BYTES / 2];=C2=A0 =C2=A0/* bfloat16=
 */<br></blockquote><div><br></div><div>Consider using bfloat16</div><div><=
br></div><div>Also float32 for sf and float16 for hf.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0} MMVector;</blockquote><div><br></div><div>=C2=A0Thanks,</div><div>T=
aylor=C2=A0</div></div></div>

--000000000000b418ab064db83357--

