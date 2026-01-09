Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1DFD232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve68Q-0004uE-1i; Fri, 09 Jan 2026 01:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve68M-0004lp-4Z
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:38:06 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1ve68K-0007Z5-2y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:38:05 -0500
Received: by mail-lf1-x141.google.com with SMTP id
 2adb3069b0e04-59b6f04cae6so2438900e87.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767940682; x=1768545482; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nv0jSueXet6SCoUtjIzJ8Cj09RY0Tq5pif65vOELk+E=;
 b=M8Kw41u8zS54+s5p2BkZRaN61o01d6psAhFLYrzfcnL6i6u6TnvhJw0kLmizqXOKVY
 cvthuqiRtpc9SGlZMtePOtj4CoOJ9xOoQoUILPwiIXQkLfEWcUWS6yYu0efuLRg7GpGE
 DIZHFJOtlu6/OMBzVSuctMZigc9onPFGrMqEuunaCobMzYkYjfJd+yWYvu95q+XRPy70
 UEbydf9gzEgMc0wLkJzYz/9/r1QS4GjBrExmMpzJ6BCBkbYLrDL635p9lN7aGf1RuPNF
 KTSBPCnOJBAquQTuYDoQ3CPg9snO91e+hWy1c+Z/PHrPuUXfjccirqIFTmPC+aIn+DgA
 AyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767940682; x=1768545482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv0jSueXet6SCoUtjIzJ8Cj09RY0Tq5pif65vOELk+E=;
 b=aA8ZrifdDzsHHJ5EY4Eu76ZUXheY4il8ywqI7ZknHT9pZhACIT4LE9rCb1e6S2ReQH
 geWArswGntGDUw1B6XfamKmMJmdUsabJJYBh0ifGIZnzIp+jIzDIs+B6sVMA2AtjfIil
 THSJRbdOrsfYQQUg/NVumhQd+VJDVimXiDQ9AQJvvqClb8uH7B7817nqQ69RS5t8VItL
 fsQBHx8vQ2cfUIsG2h4iPlzP29WHX8gwk8p/Ec/OtDhyax0ynHpI7o8wf1kOuxyM5spR
 /i2vhXbrjTa+0YeR4fy0Dlm7m3cjTm/RtSXNOsMVKR6IurR8eylXDwoNT+CkBLQuKZg9
 FUKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJXgpgRtW1HEPPE6J3ZCJhpOClu/EmVq56nq7K3BFZNl4c09TGYbfwF4iIrVdl9EoHFRivRCVY3vZ@nongnu.org
X-Gm-Message-State: AOJu0YwKoVa1Yde33YGV91Noj2vIlsK1wf0RVNSesUpr54VBnDJvdotN
 uoh1RgkQk4M1MZ85o3A/FZbjYIWjchJXHcLv6/V9mgvMWSBTFLqZ4K8GGZn6AZO65wyDMIUXV2Z
 OJOgqESpIznUJPOdvTK4DVQ9j8HLjCUY=
X-Gm-Gg: AY/fxX76aeIA9Ko7Jtyy1YGBuxjVOebkpOKOHQR/sqYC7ITEfJMZR7YejymxHD6yvZI
 96kIkXtXU0dGTwqrfXNKSLOjvD2g6Ubvw6tCCBKh+zKDdZx+FPzT8SM4La/xVXhtPJOg8RtWIYG
 bazK/vHvv0en/WWcufmoWh0REu1cbz6FKdgmqqozuJ8F3OUDnJWUBk7XUkPEKhVloZlkeS+gl77
 RcAzPVOaIApCzowpEY1cNanjdjvRMRqSTNF8gYpcYzeqfDhhEdhsTiyURgnxhs0DaGrdhA2IqLA
 p8Yb2b6DdXu5Z12mcTKLjlhtI16oVH8w9JKhYQ==
X-Google-Smtp-Source: AGHT+IFG3ImVWOowKWMktGnmd5ER/4ouj2n7QRK0c44uucrL8Wopgmj6EzuJzXMMeuoT3rvDXiObvuJDrJJloSSQyII=
X-Received: by 2002:a05:6512:4010:b0:59b:7e2b:33db with SMTP id
 2adb3069b0e04-59b7e2b4a4dmr486113e87.28.1767940681440; Thu, 08 Jan 2026
 22:38:01 -0800 (PST)
MIME-Version: 1.0
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-12-max.chou@sifive.com>
In-Reply-To: <20260108151650.16329-12-max.chou@sifive.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
Date: Fri, 9 Jan 2026 14:37:49 +0800
X-Gm-Features: AQt7F2pHzwK9V8z-q7Lr10pLUZnuPZ6dN9jUbwn5GKVK2k-sd0IkcLygy3t_wCI
Message-ID: <CAGL8uCVTFrcW=b+Du4inUtjzND=P-UNPYvfhhSWBfYR22sdq+A@mail.gmail.com>
Subject: Re: [PATCH 11/18] target/riscv: rvv: Add vfncvt.f.f.q and
 vfncvt.sat.f.f.q instructions for Zvfofp8min extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-lf1-x141.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Max:

On 1/8/2026 11:16 PM, Max Chou wrote:
> The vfncvt.f.f.q and vfncvt.sat.f.f.q instructions convert a vector of
> FP32 elements to a vector of OFP8 elements. The vfncvt.sat.f.fq instruction
> converts a vector of FP32 elements to a vector of OFP8 elements with saturation.
> The VTYPE.altfmt field is used to select the OFP8 format.
> * altfmt = 0: FP32 to OFP8.e4m3
> * altfmt = 1: FP32 to OFP8.e5m2
>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/insn32.decode                 |  2 +
>  target/riscv/insn_trans/trans_rvofp8.c.inc | 62 ++++++++++++++++++++++
>  target/riscv/insn_trans/trans_rvv.c.inc    | 39 ++++++++++++++
>  3 files changed, 103 insertions(+)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 49201c0c20..f2b413c7d4 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -974,6 +974,8 @@ vfwmaccbf16_vv    111011 . ..... ..... 001 ..... 1010111 @r_vm
>  vfwmaccbf16_vf    111011 . ..... ..... 101 ..... 1010111 @r_vm
>
>  # *** Zvfofp8min Extension ***
> +vfncvt_f_f_q          010010 . ..... 11001 001 ..... 1010111 @r2_vm
> +vfncvt_sat_f_f_q      010010 . ..... 11011 001 ..... 1010111 @r2_vm
>  vfncvtbf16_sat_f_f_w  010010 . ..... 11111 001 ..... 1010111 @r2_vm
>
>  # *** Zvbc vector crypto extension ***
> diff --git a/target/riscv/insn_trans/trans_rvofp8.c.inc b/target/riscv/insn_trans/trans_rvofp8.c.inc
> index 70a22616dc..4b44417c47 100644
> --- a/target/riscv/insn_trans/trans_rvofp8.c.inc
> +++ b/target/riscv/insn_trans/trans_rvofp8.c.inc
> @@ -22,6 +22,13 @@
>      } \
>  } while (0)
>
> +static bool zvfofp8min_narrow_quad_check(DisasContext *s, arg_rmr *a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           vext_check_sq(s, a->rd, a->rs2, a->vm) &&
> +           (s->sew == MO_8);
> +}
>
>  static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
>  {
> @@ -51,3 +58,58 @@ static bool trans_vfncvtbf16_sat_f_f_w(DisasContext *ctx, arg_rmr *a)
>      return false;
>  }
>
> +static bool trans_vfncvt_f_f_q(DisasContext *ctx, arg_rmr *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_ZVFOFP8MIN(ctx);
> +
> +    if (zvfofp8min_narrow_quad_check(ctx, a)) {
> +        gen_helper_gvec_3_ptr *fn;
> +        uint32_t data = 0;
> +
> +        fn = ctx->altfmt ? gen_helper_vfncvt_f_f_q_ofp8e5m2 :
> +                           gen_helper_vfncvt_f_f_q_ofp8e4m3;
> +
> +        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
> +        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
> +        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
> +                           vreg_ofs(ctx, a->rs2), tcg_env,
> +                           ctx->cfg_ptr->vlenb,
> +                           ctx->cfg_ptr->vlenb, data, fn);
> +        finalize_rvv_inst(ctx);
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static bool trans_vfncvt_sat_f_f_q(DisasContext *ctx, arg_rmr *a)
> +{
> +    REQUIRE_FPU;
> +    REQUIRE_ZVFOFP8MIN(ctx);
> +
> +    if (zvfofp8min_narrow_quad_check(ctx, a)) {
> +        gen_helper_gvec_3_ptr *fn;
> +        uint32_t data = 0;
> +
> +        fn = ctx->altfmt ? gen_helper_vfncvt_sat_f_f_q_ofp8e5m2 :
> +                           gen_helper_vfncvt_sat_f_f_q_ofp8e4m3;
> +
> +        gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, ctx->vta);
> +        data = FIELD_DP32(data, VDATA, VMA, ctx->vma);
> +        tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
> +                           vreg_ofs(ctx, a->rs2), tcg_env,
> +                           ctx->cfg_ptr->vlenb,
> +                           ctx->cfg_ptr->vlenb, data, fn);
> +        finalize_rvv_inst(ctx);
> +        return true;
> +    }
> +    return false;
> +}
Missing the trailing blank line.

Thanks,
Chao


> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index bcd45b0aa3..93c0761171 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -621,6 +621,45 @@ static bool vext_check_sds(DisasContext *s, int vd, int vs1, int vs2, int vm)
>             require_align(vs1, s->lmul);
>  }
>
> +/*
> + * Common check function for vector narrowing instructions
> + * of single-width result (SEW) and quad-width source (4*SEW).
> + *
> + * Rules to be checked here:
> + *   1. The largest vector register group used by an instruction
> + *      can not be greater than 8 vector registers
> + *      (Section 31.5.2)
> + *   2. Quad-width SEW cannot greater than ELEN.
> + *      (Section 31.2)
> + *   3. Source vector register number is multiples of 4 * LMUL.
> + *      (Section 31.3.4.2)
> + *   4. Destination vector register number is multiples of LMUL.
> + *      (Section 31.3.4.2)
> + *   5. Destination vector register group for a masked vector
> + *      instruction cannot overlap the source mask register (v0).
> + *      (Section 31.5.3)
> + * risc-v unprivileged spec
> + */
> +static bool vext_quad_narrow_check_common(DisasContext *s, int vd, int vs2,
> +                                          int vm)
> +{
> +    return (s->lmul <= 1) &&
> +           (s->sew < MO_32) &&
> +           ((s->sew + 2) <= (s->cfg_ptr->elen >> 4)) &&
> +           require_align(vs2, s->lmul + 2) &&
> +           require_align(vd, s->lmul) &&
> +           require_vm(vm, vd);
> +}
> +
> +static bool vext_check_sq(DisasContext *s, int vd, int vs, int vm)
> +{
> +    bool ret = vext_quad_narrow_check_common(s, vd, vs, vm);
> +    if (vd != vs) {
> +        ret &= require_noover(vd, s->lmul, vs, s->lmul + 2);
> +    }
> +    return ret;
> +}
> +
>  /*
>   * Check function for vector reduction instructions.
>   *

