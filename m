Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5622EF8FF3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnvg-00043R-JJ; Wed, 04 Mar 2026 10:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnve-00042W-8P
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:14:26 -0500
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnvc-0003Wq-CZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:14:26 -0500
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-128b9b7e3edso17237c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772637263; x=1773242063; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yTysp7r3brZdkiF2SlT5TWkLBv5dl+SWdDPqgLCEBp8=;
 b=jDx7mqT3hNB/YLrEUS008Dfet+qkIbCo8zHYJuH7fdnoc3u6iidcFmwQnRidbcPniR
 D/aqU0nL32uVgAGkgDt0HRCRM9N6QKSn+2QFxZW2ZcD00Kfx+tHM9GKhP3Aj5xUjlqeg
 h7IT3O3gP+S7I19oGZvHt3B99ipZWTOHNG2WZyiiGP1fFB+UAAYZHeqW1TD9LSB9XaBN
 5rOTJv/6Kufk/OvAmKp1fwkE9LGLb3otGjmku9Fl4lWNhxPrk+znf7rB0l42NlqAQEhQ
 vFoVK2vrjPRNPrxHGzNCm1i7VIQBBfx6iTmhM1FI0iIbua8emTcKXv/8t//GvkY4aLN9
 SQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772637263; x=1773242063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTysp7r3brZdkiF2SlT5TWkLBv5dl+SWdDPqgLCEBp8=;
 b=mXAj2Lq1cPBgau2XOHmyAqVtiuHj6XjD6pCf03leuKDyjqn8VzsaJ0CXBDkhtwgj0E
 Tdi2zCmmI8TFEIprEPSFQjWPyd34h75qdlMJPzPN9uAVGBnbNN+S4+SimKy5pYiSYEZs
 rABvu9IZ/mIrn2410JvTvYu1/yXB1fjZ2C1deU+bC9euhoqCW3N2E2H9ZK41lmR/IKGD
 +hD5vxr21lShp/gYJmTCrGBt9jREZ7LTixAmFWo4RtUsqEhWuTKBZmmUL3PTG9dJ6SDh
 5JJzm9zhSqlWoMe+fluICo5T30daN96DxKVUuSZroETqu0+rVhT97+5a7OUynyfgNQpK
 +MNg==
X-Gm-Message-State: AOJu0YyHmEqqcyVGN94In24fbjgadHaTlN3hNjCoxe4yCLOdermnLUqp
 jC5zoEOfPhGN+YMIlJrAwqkVTme74efZgby7770taekAl1GkCFBCPgyr
X-Gm-Gg: ATEYQzwIiM2TLuJihL1zAEiCw7Fh8R1IheXr0mkMO34GFzJ+cuaOEqRd5WrmegBKsQ/
 w3098rJB6TEoSDoJgGgwDVegC+U4fetW8halAuL/LJ0Pbfm1jHIG9w4QEf9e6upLILCR7qUR3z/
 vmwful2cGuopROlc8cmC4p1uNB0qokRj/0mZGZu6N2WzB7bPRnlNngaSDI2b2lzE/8bGGlvKfPN
 KvqryOcZaAB4ErlxY+I0hQMGHYfLC4kPQeuUwgffX+O3bkucAJPwUTr8qhVTRB7J4HG+vKWfePD
 Tae2WM3/W4KSaVvLGN8XZMmyF0LKRLLXlh5f+UXRjk0tO7j5a4HZvZIv5qfXLk7/taPiRPhNTpZ
 eZqvgS8VorZ1YlcrXQzZHY23bIUSY1O+xoi6bVu+UhlV84sS56SGBEPuc2rDXYWTWmovh64vVtM
 ruARdp6aNfMPTWQ3Vi89Eddhvbt6R4gsrBSUhXEGtVDj+ghSy6odP9LuUgNOQqdkdZxmnhEBNTI
 HNPu50xnKhUdyxBQiFkvQjkvN5drNk=
X-Received: by 2002:a05:7022:6b98:b0:127:3480:7ca1 with SMTP id
 a92af1059eb24-128b70735c9mr914047c88.1.1772637262683; 
 Wed, 04 Mar 2026 07:14:22 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32863sm18122170c88.10.2026.03.04.07.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:14:22 -0800 (PST)
Date: Wed, 4 Mar 2026 23:13:57 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 12/14] target/riscv: rvv: Add vfext.vf2 instruction
 for Zvfofp4min extension
Message-ID: <aahK0egnN_1lEWnH@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-13-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-13-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1242.google.com
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

On Wed, Mar 04, 2026 at 09:40:04PM +0800, Max Chou wrote:
> The vfext.vf2 instruction converts a vector of OCP FP4 E2M1
> floating-point numbers to a vector of OFP FP8 E4M3 floating-points
> numbers.
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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
Missing REQUIRE_FPU here.

All other FP vector instruction translation functions
in this series (trans_vfncvtbf16_sat_f_f_w, trans_vfncvt_f_f_q,
trans_vfncvt_sat_f_f_q, trans_vfwcvtbf16_f_f_v,
trans_vfncvtbf16_f_f_w) have REQUIRE_FPU at the top.

Without it, this instruction could execute even when FPU
is disabled.


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
the explicit tcg_gen_movi_tl(cpu_vstart, 0)
is redundant since HELPER(vfext_vf2) already sets
env->vstart = 0 at the end.

I noticed the other trans functions in this series don't have
this extra line. It's not a bug, just inconsistent.

Thanks,
Chao
> +
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 0c546a3aff..4311b388cb 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1221,6 +1221,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
>  #include "insn_trans/trans_svinval.c.inc"
>  #include "insn_trans/trans_rvbf16.c.inc"
>  #include "insn_trans/trans_rvofp8.c.inc"
> +#include "insn_trans/trans_rvofp4.c.inc"
>  #include "decode-xthead.c.inc"
>  #include "decode-xmips.c.inc"
>  #include "insn_trans/trans_xthead.c.inc"
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index e7b187a57d..86a174ed9d 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5131,6 +5131,7 @@ RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
>  GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
>  GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
>  
> +/* Zvfofp4min: vfext.vf2 - OFP4 E2M1 to OFP8 E4M3 conversion */
>  /*
>   * Vector Reduction Operations
>   */
> @@ -5930,3 +5931,35 @@ GEN_VEXT_INT_EXT(vsext_vf2_d, int64_t, int32_t, H8, H4)
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

