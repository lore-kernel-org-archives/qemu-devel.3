Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F360BF483F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ltd-00047C-HM; Mon, 23 Mar 2026 16:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4ltZ-00046j-2S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:29:06 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w4ltW-0003s5-Gn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 16:29:04 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c741db5d610so1322324a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 13:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774297740; cv=none;
 d=google.com; s=arc-20240605;
 b=cP951il9cg9w1SQh2mJrSqL8EC8gv98ZX4LUGbDvAFsQ0Gt1yvJCXmZZMrPapsoF9/
 Z6QBA/BTwFvDGgxNyPkRfIjB8FFalq8suQljd7916x5lSD5/Ql7Fg6dxAKonPghwjPKV
 wuV7oWI+7YLn/6gaJuiJ80/zXgCF6IdfYZBvqh2jtOPFPFFcCnpvAyzWfcNVmAiOpbht
 B4MPxtKH/muN2n9ZaZRrL/KWTDSjSBjr5Q46Q2TYjtPQfLJUTPsHScabF1YOIh//MMji
 Lr1xnT0gYG+BtKwZLnghq/3Hg9UhPb0L4sv9hU4O9DJ4kNvnRnN5WPiFiNuQTA/xlM4j
 YnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TskLC0xPkAbGzYxFafunlFhvT4pz/sGBw4UZwgAKp4Q=;
 fh=uv1tA9xklsQ23QRRVuZ5ICrQzjqlbIWk8lB36BxPINw=;
 b=lxfosYLspValYq0Krh+r1Fe2t1Fd/S791cvy9mLO6VwhoQAvnmfYSLlin/v6yBJ+Gb
 bGTzTDadX0S01AEhF8OmjsBWz6iNDlAm1tA3mjeYIsg4qwgCYeZ9hUF/wSyebmb5MInS
 WkjF3MNDHu0ZOv58mAad/Qz4XL5+Ect5njhNdz/QjVE7My8WD695pqf9tXIRlDSpGqlS
 5t0h4Uv82euuEQDoYOp4tYDdLQyrqff496NzdAoePtHUmRdKw8GnXTcbnvSB2mP+TFAT
 ZqGHcf3JTQ32mjZ7atQ2y20FJxtcYPT1+bHJ3RxJ/PnVYgoio6M6xX5aIpdpqvS836UL
 py+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774297740; x=1774902540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TskLC0xPkAbGzYxFafunlFhvT4pz/sGBw4UZwgAKp4Q=;
 b=czVdoHBwlJonVzJKp+c+4KnCYaKYMM7v6/QPjKmpExySUIBbIhMt0t9r+WkXJyL3Oh
 aFLcPhS8Sqbue57uT9sMlu3b+ieF/rXJ5dXG3orotf3qIoHVM5BO8rxwRsCGxljMvvUP
 NRGRt1GXfZyvm9zn2RUKI0V3HjN5KxsjP9sIHCK42Heul1LzM6B8dH6beX3pUaoaZMD8
 MnQFTGPSnAyKGtismb79n67NR6nRGEtHi8Kakfhejph3jRQd3d1CjWcu7tyYMrge8xoN
 JchkjXexyQAhe65hg3fAwCdmoxwP2uMez+7HkU+X1rANNOteZHLOjeQXqVVK3TJdk/EU
 ExAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297740; x=1774902540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TskLC0xPkAbGzYxFafunlFhvT4pz/sGBw4UZwgAKp4Q=;
 b=afNGaFvr5qc1iMpsFM6hECeUnDCfnekMl+Xji3YfhuGy6aGYVGShDlivIX7w3hfrZ3
 yM0AS5XDwlzfK0P9GYnZKz6K6LZz0sng2MILBeH5deKedTJNzcGspVBrOeddvqfySLjz
 TyJOEK8fNv3Q4ZlX4BxdGfPN96I7dxnfitNgvvGtLrVIlFRFRmMJLodBh7Q8LSiG96aP
 2sGzc1UpqCWZ7ynltX6ytnooT6gGxk158ZGqNFT9iVKigwlqO36o7TtwIapUrr8i0Ytz
 LKRzwgmtdFkfHQErWwNx0eho8pKN3Z5bvXxkC4qv5bff/BDYl5C8hFqA6XXwrebVgI9n
 93OQ==
X-Gm-Message-State: AOJu0YxiHIKsVJfR697OFF7J54KPRrh/dI6faeKXBPHfJFYzUnZcS3pC
 6RsfwyIj4dZPom9hJqhheYtExxesy+4C54zijT0lT82pGOlHAb2DSNg3tRvVINnqmeqA/oXSZcI
 lKaMB/r3CsHUWNryPQ6eu0G24BhBHEB0=
X-Gm-Gg: ATEYQzw0yREt41IhXkzt9K43u7fR4TztggEmg3V1xmYDS7yFsB7c2DRXB4qL8qstwPg
 g9ryAdXjUNblt4+5rwYJw76T/SinzPcrI2M+pDCJJj00xDMc9D03UAOOxMIG3uqFRFmwibe+7la
 MNG1xt3JkhHRyfShkcivifequWHeCnvJJTmRvQ3RuDjPsVGSOX3MTQSG8eZRmFNNHg0ur2egGQj
 R5+pH9i5GtI4eU6oMqiNZ0crK2ZCTcU4qGesaG3jr4uQ7a8sCtNbIdmWJWWe/VNEqmBvHXzVETG
 SuwMIOPMNtIQ4Fh9WIXnL2JXl+Qs35+t9MYVZsg=
X-Received: by 2002:a17:902:f605:b0:2b0:7d6f:4627 with SMTP id
 d9443c01a7336-2b0827d63c4mr119822945ad.37.1774297739910; Mon, 23 Mar 2026
 13:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <831949008a7266559a6f313f99a394cd68cc9846.1774271525.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 23 Mar 2026 14:28:48 -0600
X-Gm-Features: AaiRm52AZ16jFio0aekc6_Jk34kOyKRINmh60iZ_PVfxtpKBeJUpJCaIwiKpmXE
Message-ID: <CAATN3NrZVn6W0pAyshZ7mhYVcY+gtRk9tJwz5WLLzxoPTDupwA@mail.gmail.com>
Subject: Re: [PATCH 04/13] target/hexagon: add v68 HVX IEEE float arithmetic
 insns
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000836147064db6e2b5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52f.google.com
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

--000000000000836147064db6e2b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> Add HVX IEEE floating-point arithmetic instructions:
> - vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations
> - vdmpy_sf_hf: dot-product multiply
> - vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate
> - vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output
> - vadd_hf_hf, vsub_hf_hf: add/sub with hf output
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/kvx_ieee.h              | 47 ++++++++++
>  target/hexagon/mmvec/macros.h                |  1 +
>  target/hexagon/mmvec/mmvec.h                 |  2 +
>  target/hexagon/attribs_def.h.inc             |  4 +
>  target/hexagon/mmvec/kvx_ieee.c              | 87 ++++++++++++++++++
>  target/hexagon/hex_common.py                 |  1 +
>  target/hexagon/imported/mmvec/encode_ext.def | 18 ++++
>  target/hexagon/imported/mmvec/ext.idef       | 93 ++++++++++++++++++++
>  target/hexagon/meson.build                   |  1 +
>  9 files changed, 254 insertions(+)
>  create mode 100644 target/hexagon/mmvec/kvx_ieee.h
>  create mode 100644 target/hexagon/mmvec/kvx_ieee.c
>

I'm curious why the prefix is kvx instead of hvx.


>
> diff --git a/target/hexagon/mmvec/kvx_ieee.h
> b/target/hexagon/mmvec/kvx_ieee.h
> new file mode 100644
> index 0000000000..e92ddebeb9
> --- /dev/null
> +++ b/target/hexagon/mmvec/kvx_ieee.h
> @@ -0,0 +1,47 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HEXAGON_KVX_IEEE_H
> +#define HEXAGON_KVX_IEEE_H
> +
> +#include "fpu/softfloat.h"
> +
> +/* Hexagon canonical NaN */
> +#define FP32_DEF_NAN      0x7FFFFFFF
> +#define FP16_DEF_NAN      0x7FFF
>

These are the same as the scalar core, right?  If so, there's already a
call to set_float_default_nan_pattern in hexagon_cpu_reset_hold.

If the patterns are different, you'll need to call
set_float_default_nan_pattern before each scalar FP instruction and before
each HVX FP instruction.


> +
> +/*
> + * IEEE - FP ADD/SUB/MPY instructionsFP
> + */
> +uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status=
);
> +uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status)=
;
> +uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status)=
;
> +
> +uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
> +uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status)=
;
> +uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status)=
;
> +
> +uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status=
);
> +uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status)=
;
> +uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status)=
;
> +
> +/*
> + * IEEE - FP Accumulate instructions
> + */
> +uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,
> +                           float_status *fp_status);
> +uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,
> +                           float_status *fp_status);
> +
> +/*
> + * IEEE - FP Reduce instructions
> + */
> +uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,
> +                  float_status *fp_status);
> +uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a=
3,
> +                      uint16_t a4, float_status *fp_status);
> +
>

Consider using macros similar to the ones in the .c file to create these
protos.


> +#endif
> diff --git a/target/hexagon/mmvec/kvx_ieee.c
> b/target/hexagon/mmvec/kvx_ieee.c
> new file mode 100644
> index 0000000000..b763899aa3
> --- /dev/null
> +++ b/target/hexagon/mmvec/kvx_ieee.c
> @@ -0,0 +1,87 @@
> +/*
> + *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + *  SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "kvx_ieee.h"
> +
> +#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \
> +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> +                           float_status *fp_status) { \
> +        float##a1t f1 =3D make_float##a1t(a1); \
> +        float##a2t f2 =3D make_float##a2t(a2); \
> +        \
> +        if (float##a1t##_is_any_nan(f1) || float##a2t##_is_any_nan(f2)) =
{
> \
> +            return FP##rt##_DEF_NAN; \
> +        } \
>

These nan checks shouldn't be needed if you're using QEMU softfloat
properly.


> +        float##rt result =3D op; \
> +        \
> +        if (float##rt##_is_any_nan(result)) { \
> +            return FP##rt##_DEF_NAN; \
> +        } \
>

Ditto


> +        return result; \
> +    }
> +
> +#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \
> +    uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \
> +                           uint##a3t##_t a3, float_status *fp_status) { =
\
> +        float##a1t f1 =3D make_float##a1t(a1); \
> +        float##a2t f2 =3D make_float##a2t(a2); \
> +        float##a3t f3 =3D make_float##a3t(a3); \
> +        \
> +        if (float##a1t##_is_any_nan(f1) || float##a2t##_is_any_nan(f2) |=
|
> \
> +            float##a3t##_is_any_nan(f3)) \
> +            return FP##rt##_DEF_NAN; \
>

Ditto


> +        \
> +        float##rt result =3D op; \
> +        \
> +        if (float##rt##_is_any_nan(result)) \
> +            return FP##rt##_DEF_NAN; \
>

Ditto


> +        return result; \
> +    }
> +
> diff --git a/target/hexagon/imported/mmvec/ext.idef
> b/target/hexagon/imported/mmvec/ext.idef
> index 03d31f6181..3f0d8e366e 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -2895,9 +2895,102 @@ EXTINSN(V6_vprefixqw,"Vd32.w=3Dprefixsum(Qv4)",
>  ATTRIBS(A_EXTENSION,A_CVI,A_CVI_
>      }
>      } )
>
> +/* KVX - IEEE FP Instructions */
>
> +/* Single pipe, 32-bit output */
> +#define ITERATOR_INSN_IEEE_FP_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_32), =
\
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>
> +/* Single pipe, 16-bit output */
> +#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), =
\
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
>
> +/* Two pipes: P2 & P3, single output: P2, 32-bit output */
> +#define
> ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32=
),
> \
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
> +
> +/* Two pipes: P2 & P3, two outputs, 32-bit output */
> +#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32=
),
> \
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
> +
> +/*
> + * single pipe, accumulate instruction, produces 16-bit output, requires
> 16-bit
> + * accumulate input
> + */
> +#define ITERATOR_INSN_IEEE_FP_ACC_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX=
_IEEE_FP_OUT_16,A_CVI_VX_NO_TMP_LD),
> \
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
> +
> +/*
> + * single pipe, accumulate instruction, produces 32-bit output, requires
> 32-bit
> + * accumulate input
> + */
> +#define ITERATOR_INSN_IEEE_FP_ACC_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \
> +EXTINSN(V6_##TAG, SYNTAX, \
> +ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX=
_IEEE_FP_OUT_32,A_CVI_VX_NO_TMP_LD),
> \
> +DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))
> +
> +/* IEEE FP multiply instructions */
> +ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,
> +    "Vd32.sf=3Dvmpy(Vu32.sf,Vv32.sf)", "Vector IEEE mul: sf",
> +    VdV.sf[i] =3D fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &env->fp_status))
>

Do these instructions interact with the FP bits in USR (e.g., rounding
mode, FP exceptions)?

If so, you'll need something similar to arch_fpop_start/arch_fpop_end at
the start/end of each helper.  This can be done in gen_helper_funcs.py.

Thanks,
Taylor

--000000000000836147064db6e2b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 23,=
 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add =
HVX IEEE floating-point arithmetic instructions:<br>
- vmpy_sf_sf, vmpy_sf_hf, vmpy_hf_hf: multiply operations<br>
- vdmpy_sf_hf: dot-product multiply<br>
- vmpy_sf_hf_acc, vmpy_hf_hf_acc, vdmpy_sf_hf_acc: multiply-accumulate<br>
- vadd_sf_sf, vsub_sf_sf, vadd_sf_hf, vsub_sf_hf: add/sub with sf output<br=
>
- vadd_hf_hf, vsub_hf_hf: add/sub with hf output<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 47 ++++++++++<br>
=C2=A0target/hexagon/mmvec/macros.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0target/hexagon/mmvec/mmvec.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0target/hexagon/attribs_def.h.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 4 +<br>
=C2=A0target/hexagon/mmvec/kvx_ieee.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 87 ++++++++++++++++++<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/imported/mmvec/encode_ext.def | 18 ++++<br>
=C2=A0target/hexagon/imported/mmvec/ext.idef=C2=A0 =C2=A0 =C2=A0 =C2=A0| 93=
 ++++++++++++++++++++<br>
=C2=A0target/hexagon/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A09 files changed, 254 insertions(+)<br>
=C2=A0create mode 100644 target/hexagon/mmvec/kvx_ieee.h<br>
=C2=A0create mode 100644 target/hexagon/mmvec/kvx_ieee.c<br></blockquote><d=
iv><br></div><div>I&#39;m curious why the prefix is kvx instead of hvx.</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_iee=
e.h<br>
new file mode 100644<br>
index 0000000000..e92ddebeb9<br>
--- /dev/null<br>
+++ b/target/hexagon/mmvec/kvx_ieee.h<br>
@@ -0,0 +1,47 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HEXAGON_KVX_IEEE_H<br>
+#define HEXAGON_KVX_IEEE_H<br>
+<br>
+#include &quot;fpu/softfloat.h&quot;<br>
+<br>
+/* Hexagon canonical NaN */<br>
+#define FP32_DEF_NAN=C2=A0 =C2=A0 =C2=A0 0x7FFFFFFF<br>
+#define FP16_DEF_NAN=C2=A0 =C2=A0 =C2=A0 0x7FFF<br></blockquote><div><br><=
/div><div>These are the same as the scalar core, right?=C2=A0 If so, there&=
#39;s already a call to set_float_default_nan_pattern in hexagon_cpu_reset_=
hold.</div><div><br></div><div>If the patterns are different, you&#39;ll ne=
ed to call set_float_default_nan_pattern before each scalar FP instruction =
and before each HVX FP instruction.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+<br>
+/*<br>
+ * IEEE - FP ADD/SUB/MPY instructionsFP<br>
+ */<br>
+uint32_t fp_mult_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);=
<br>
+uint32_t fp_add_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<=
br>
+uint32_t fp_sub_sf_sf(uint32_t a1, uint32_t a2, float_status *fp_status);<=
br>
+<br>
+uint16_t fp_mult_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);=
<br>
+uint16_t fp_add_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<=
br>
+uint16_t fp_sub_hf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<=
br>
+<br>
+uint32_t fp_mult_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);=
<br>
+uint32_t fp_add_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<=
br>
+uint32_t fp_sub_sf_hf(uint16_t a1, uint16_t a2, float_status *fp_status);<=
br>
+<br>
+/*<br>
+ * IEEE - FP Accumulate instructions<br>
+ */<br>
+uint16_t fp_mult_hf_hf_acc(uint16_t a1, uint16_t a2, uint16_t acc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0float_status *fp_status);<br>
+uint32_t fp_mult_sf_hf_acc(uint16_t a1, uint16_t a2, uint32_t acc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0float_status *fp_status);<br>
+<br>
+/*<br>
+ * IEEE - FP Reduce instructions<br>
+ */<br>
+uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t a3, uint16_t a4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float_statu=
s *fp_status);<br>
+uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t a3,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint16_t a4, float_status *fp_status);<br>
+<br></blockquote><div><br></div><div>Consider using macros similar to the =
ones in the .c file to create these protos.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+#endif<br>diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mm=
vec/kvx_ieee.c<br>
new file mode 100644<br>
index 0000000000..b763899aa3<br>
--- /dev/null<br>
+++ b/target/hexagon/mmvec/kvx_ieee.c<br>
@@ -0,0 +1,87 @@<br>
+/*<br>
+ *=C2=A0 Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries=
.<br>
+ *<br>
+ *=C2=A0 SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;kvx_ieee.h&quot;<br>
+<br>
+#define DEF_FP_INSN_2(name, rt, a1t, a2t, op) \<br>
+=C2=A0 =C2=A0 uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0float_status *fp_status) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a1t f1 =3D make_float##a1t(a1); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a2t f2 =3D make_float##a2t(a2); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (float##a1t##_is_any_nan(f1) || float##a2t#=
#_is_any_nan(f2)) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FP##rt##_DEF_NAN; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br></blockquote><div><br></div><div>These =
nan checks shouldn&#39;t be needed if you&#39;re using QEMU softfloat prope=
rly.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##rt result =3D op; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (float##rt##_is_any_nan(result)) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FP##rt##_DEF_NAN; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } \<br></blockquote><div><br></div><div>Ditto<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result; \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#define DEF_FP_INSN_3(name, rt, a1t, a2t, a3t, op) \<br>
+=C2=A0 =C2=A0 uint##rt##_t fp_##name(uint##a1t##_t a1, uint##a2t##_t a2, \=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint##a3t##_t a3, float_status *fp_status) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a1t f1 =3D make_float##a1t(a1); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a2t f2 =3D make_float##a2t(a2); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a3t f3 =3D make_float##a3t(a3); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (float##a1t##_is_any_nan(f1) || float##a2t#=
#_is_any_nan(f2) || \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 float##a3t##_is_any_nan(f3)) \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FP##rt##_DEF_NAN; \<br></=
blockquote><div><br></div><div>Ditto</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 float##rt result =3D op; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (float##rt##_is_any_nan(result)) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return FP##rt##_DEF_NAN; \<br></=
blockquote><div><br></div><div>Ditto</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result; \<br>
+=C2=A0 =C2=A0 }<br>
+<br>diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/i=
mported/mmvec/ext.idef<br>
index 03d31f6181..3f0d8e366e 100644<br>
--- a/target/hexagon/imported/mmvec/ext.idef<br>
+++ b/target/hexagon/imported/mmvec/ext.idef<br>
@@ -2895,9 +2895,102 @@ EXTINSN(V6_vprefixqw,&quot;Vd32.w=3Dprefixsum(Qv4)&=
quot;,=C2=A0 =C2=A0ATTRIBS(A_EXTENSION,A_CVI,A_CVI_<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} )<br>
<br>
+/* KVX - IEEE FP Instructions */<br>
<br>
+/* Single pipe, 32-bit output */<br>
+#define ITERATOR_INSN_IEEE_FP_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_32), \<=
br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
<br>
+/* Single pipe, 16-bit output */<br>
+#define ITERATOR_INSN_IEEE_FP_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_OUT_16), \<=
br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
<br>
+/* Two pipes: P2 &amp; P3, single output: P2, 32-bit output */<br>
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE=
) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32),=
 \<br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
+<br>
+/* Two pipes: P2 &amp; P3, two outputs, 32-bit output */<br>
+#define ITERATOR_INSN_IEEE_FP_DOUBLE_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX_DV,A_HVX_IEEE_FP_OUT_32),=
 \<br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
+<br>
+/*<br>
+ * single pipe, accumulate instruction, produces 16-bit output, requires 1=
6-bit<br>
+ * accumulate input<br>
+ */<br>
+#define ITERATOR_INSN_IEEE_FP_ACC_16(WIDTH,TAG,SYNTAX,DESCR,CODE) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_I=
EEE_FP_OUT_16,A_CVI_VX_NO_TMP_LD), \<br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
+<br>
+/*<br>
+ * single pipe, accumulate instruction, produces 32-bit output, requires 3=
2-bit<br>
+ * accumulate input<br>
+ */<br>
+#define ITERATOR_INSN_IEEE_FP_ACC_32(WIDTH,TAG,SYNTAX,DESCR,CODE) \<br>
+EXTINSN(V6_##TAG, SYNTAX, \<br>
+ATTRIBS(A_EXTENSION,A_HVX_IEEE_FP,A_CVI,A_CVI_VX,A_HVX_IEEE_FP_ACC,A_HVX_I=
EEE_FP_OUT_32,A_CVI_VX_NO_TMP_LD), \<br>
+DESCR, DO_FOR_EACH_CODE(WIDTH, CODE))<br>
+<br>
+/* IEEE FP multiply instructions */<br>
+ITERATOR_INSN_IEEE_FP_DOUBLE_SINGLE_32(32, vmpy_sf_sf,<br>
+=C2=A0 =C2=A0 &quot;Vd32.sf=3Dvmpy(Vu32.sf,Vv32.sf)&quot;, &quot;Vector IE=
EE mul: sf&quot;,<br>
+=C2=A0 =C2=A0 VdV.sf[i] =3D fp_mult_sf_sf(VuV.sf[i], VvV.sf[i], &amp;env-&=
gt;fp_status))<br></blockquote><div><br></div><div>Do these instructions in=
teract with the FP bits in USR (e.g., rounding mode, FP exceptions)?</div><=
div><br></div><div>If so, you&#39;ll need something similar to arch_fpop_st=
art/arch_fpop_end at the start/end of each helper.=C2=A0 This can be done i=
n gen_helper_funcs.py.</div><div><br></div><div>Thanks,</div><div>Taylor</d=
iv><div><br></div></div></div>

--000000000000836147064db6e2b5--

