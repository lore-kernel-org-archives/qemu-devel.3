Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C6EA7963
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 04:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnqdZ-00035Q-9R; Wed, 04 Feb 2026 23:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnqdT-00034z-3C
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 23:06:31 -0500
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnqdR-0000xh-4r
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 23:06:30 -0500
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2b729f4c154so775242eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 20:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770264387; x=1770869187; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=USTw0mKGA2VPqIAk81XWhkfH/gV/AfyfIWi3QierJYQ=;
 b=RIgOZnmSjZAUBuEZNM6SQWM1FjtbkG4f2D6y1GFc43ewyj0aqTWVE+cgq/pV/OLP6O
 tODfpFnOaytPFdwgv78ibQDn9Tk+RKhD/lS1XFuHsjrdhfMvxxNohEGhEAeYiU00R2cC
 yqNDxj6aCeugF5js3IKRaZ5ooaxJZnU4FejIgT/6OKsDQ3dCdZ6IamNW7X4gNUgDHZf5
 8v6+pMFLgZyc/wNzW04DwgDlt8irGUkAdGqWZwX6l3RTB1+7f+JFpEybs0x+gwJeZ8Dx
 vtaTOP2B8n69a4RNY8vvXGjOfhPq9YJBewvoVq5bdX5x/yJGpRnVU4FUpgumlGea+2zn
 t9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770264387; x=1770869187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USTw0mKGA2VPqIAk81XWhkfH/gV/AfyfIWi3QierJYQ=;
 b=ZCejcbrnF3Pzo7/d1kX52AaMQRTlJ5CR8/XZDvDAwcSEni/bBmq0oM8U3mqb0fkVIi
 kJoKmJbCjyJIcLgfL2NAoSYTfvEzT2kCmPOn0ANVgANoKsje9nzn3bNzQW9UvxYpHeAp
 /q62UHtyc4B7xgVllV3NgAzFQ04bDkhxduM2AU2FF/gtclI07EzlHkEKIszM71HrGg2o
 w8ObBeZdJRLC8OwSjy9LMWKWhoubpXmUYv/p66hQkEOteOtKdL/3oRdmZdNR3o0GHGXE
 +X+0ma2egCgAw4nu0WmduResEHz6YOHDZ1VeFL58muGatVtiXqwpH5FY4CLRErCwKkG/
 JorA==
X-Gm-Message-State: AOJu0YwskYgTeV7MR+gfosopkRc9GYGS7cvJ0vKsedgm9m1yQxtFL3uS
 YJ4YOgOSnb1m4l5Kae7J3GGDufyMG7XSet1L8iD/AEannfRLlJowIAO8JuoPIr7OfnU3RQ==
X-Gm-Gg: AZuq6aLNuJ0XX/pP9PIJCc+r7HJt6fgoE850keHK/W01PRll3Zp/V0C0EpMyR29i+87
 8iXyolMLanMBY9dmvMAFT9AFtqARKSR6PTpz5cUwLv5kJqG0knm4dtpmpufFlAPErrqUN/ztM/T
 RQkKJ6FqWDyw2wwKRGQ5isnk0+re683TjJnPS8d5WNV/Uz6bNE3shlRVn4hdHVW9l3vrUpbbT5z
 2v69B8CPIbRxVW9V+zyydWOJFA8z1f6kqcLERe9MiSky1XOQqgzM/B4TD452UWF4KWH7B8G1tcG
 B73Txy+uADjFky8NNq6ORKFd2Wrw7TiVVYtJNFbfvwYQ/hPawBLF55rbUBkVG+oNNwqdmdxjBxl
 TbtH1KFlQmVsya3L+SoHqb4l/h40GxbDQXKZCmkigx19P4yWl1TVoZbSHyVTOIKmMVdbzmdBiYf
 u8kN2VcE5X6JYQmPWdrUqPl7is0FYDpJ/VFbCvUto3kiNiAGGcJpbQJuVuGQdDSJZzLqeCicUnN
 rd2JciwX8IY1JoaBqc=
X-Received: by 2002:a05:7301:1686:b0:2b8:711:ae6d with SMTP id
 5a478bee46e88-2b83296f237mr2059500eec.5.1770264387085; 
 Wed, 04 Feb 2026 20:06:27 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b832e4d0b4sm2552864eec.9.2026.02.04.20.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 20:06:26 -0800 (PST)
Date: Thu, 5 Feb 2026 12:06:11 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 17/19] target/riscv: rvv: Add vfext.vf2 instruction
 for Zvfofp4min extension
Message-ID: <aYQW8Zm-agycDgqH@ZEVORN-PC.localdomain>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-18-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204051756.667397-18-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 04, 2026 at 01:17:53PM +0800, Max Chou wrote:
> The vfext.vf2 instruction converts a vector of OCP FP4 E2M1
> floating-point numbers to a vector of OFP FP8 E4M3 floating-points
> numbers.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                      |  3 ++
>  target/riscv/insn32.decode                 |  3 ++
>  target/riscv/insn_trans/trans_rvofp4.c.inc | 43 ++++++++++++++++++++++
>  target/riscv/translate.c                   |  1 +
>  target/riscv/vector_helper.c               | 33 +++++++++++++++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvofp4.c.inc
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 356c24d9fb..162303fb6c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1259,6 +1259,9 @@ DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
>  
> +/* OFP4 function */
> +DEF_HELPER_5(vfext_vf2, void, ptr, ptr, ptr, env, i32)
> +
>  /* Vector crypto functions */
>  DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f2b413c7d4..c58223ebd8 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -754,6 +754,9 @@ vsext_vf2       010010 . ..... 00111 010 ..... 1010111 @r2_vm
>  vsext_vf4       010010 . ..... 00101 010 ..... 1010111 @r2_vm
>  vsext_vf8       010010 . ..... 00011 010 ..... 1010111 @r2_vm
>  
> +# Zvfofp4min Extension
> +vfext_vf2       010010 . ..... 10110 010 ..... 1010111 @r2_vm
> +
>  vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm11
>  vsetivli        11 .......... ..... 111 ..... 1010111  @r2_zimm10
>  vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvofp4.c.inc b/target/riscv/insn_trans/trans_rvofp4.c.inc
> new file mode 100644
> index 0000000000..0fb5d7d534
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvofp4.c.inc
> @@ -0,0 +1,43 @@
> +/*
> + * RISC-V translation routines for the OFP4 Standard Extensions.
> + *
> + * Copyright (C) 2025 SiFive, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +static bool vext_zvfofp4min_check(DisasContext *s, arg_rmr *a)
> +{
> +    return s->cfg_ptr->ext_zvfofp4min &&
> +           (s->sew == MO_8) &&
> +           vext_check_altfmt(s, -1) &&
> +           (s->lmul >= -2) &&
> +           require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           (a->rd != a->rs2) &&
> +           require_align(a->rd, s->lmul) &&
> +           require_align(a->rs2, s->lmul - 1) &&
> +           require_vm(a->vm, a->rd) &&
> +           require_noover(a->rd, s->lmul, a->rs2, s->lmul - 1);
> +}
> +
> +static bool trans_vfext_vf2(DisasContext *s, arg_rmr *a)
> +{
> +    if (vext_zvfofp4min_check(s, a)) {
> +        uint32_t data = 0;
> +
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);
> +        data = FIELD_DP32(data, VDATA, VMA, s->vma);
> +        tcg_gen_gvec_3_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),
> +                           vreg_ofs(s, a->rs2), tcg_env,
> +                           s->cfg_ptr->vlenb, s->cfg_ptr->vlenb, data,
> +                           gen_helper_vfext_vf2);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        finalize_rvv_inst(s);
> +
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 137022d7fb..bf403785b5 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1220,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  #include "insn_trans/trans_svinval.c.inc"
>  #include "insn_trans/trans_rvbf16.c.inc"
>  #include "insn_trans/trans_rvofp8.c.inc"
> +#include "insn_trans/trans_rvofp4.c.inc"
>  #include "decode-xthead.c.inc"
>  #include "decode-xmips.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 418212973d..a87728f130 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5121,6 +5121,7 @@ RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
>  GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
>  GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
>  
> +/* Zvfofp4min: vfext.vf2 - OFP4 E2M1 to OFP8 E4M3 conversion */
>  /*
>   * Vector Reduction Operations
>   */
> @@ -5920,3 +5921,35 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
>  GEN_VEXT_INT_EXT(vsext_vf4_w, int32_t, int8_t,  H4, H1)
>  GEN_VEXT_INT_EXT(vsext_vf4_d, int64_t, int16_t, H8, H2)
>  GEN_VEXT_INT_EXT(vsext_vf8_d, int64_t, int8_t,  H8, H1)
> +
> +
> +void HELPER(vfext_vf2)(void *vd, void *v0, void *vs2, CPURISCVState *env,
> +                       uint32_t desc)
> +{
> +    float_status fp_status = env->fp_status;
> +    uint32_t vl = env->vl;
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t esz = sizeof(uint8_t);
> +    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
> +    uint32_t vta = vext_vta(desc);
> +    uint32_t vma = vext_vma(desc);
> +    uint32_t i;
> +
> +    VSTART_CHECK_EARLY_EXIT(env, vl);
> +
> +    for (i = env->vstart; i < vl; ++i) {
> +        if (!vm && !vext_elem_mask(v0, i)) {
> +            /* set masked-off elements to 1s */
> +            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);
> +            continue;
> +        }
> +
> +        uint8_t input = *((uint8_t *)vs2 + H1((i % 2 ? i - 1 : i) / 2));
> +        input = (i % 2) ? ((input >> 4) & 0xf) : (input & 0xf);
> +        *((uint8_t *)vd + H1(i)) = float4_e2m1_to_float8_e4m3(input,
> +                                                              &fp_status);
> +    }
> +    env->vstart = 0;
> +    /* set tail elements to 1s */
> +    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);
> +}
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

