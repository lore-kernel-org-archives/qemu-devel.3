Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8062CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOliX-0000Zm-U2; Sun, 17 May 2026 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOliW-0000ZJ-1x
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:20:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOliT-0008EJ-Ma
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:20:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so3744523a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779063616; cv=none;
 d=google.com; s=arc-20240605;
 b=Gfd6Leii/ksfGlEmO0Ww2kwRdjMiByawPVaYAKvl/rahG8j7Ntbh+6eKtZrGyvS3Dz
 /fTBQBQji3sNwe4obc7m5QPFWkKOaq6yKqc5qd3tqgmoWdv9iK+1mfwL/e977aW9iBCk
 T3Wc0N+1Ma+wwYuBasQ24Yk+JRT0yhjfD4KPtHqBXkAGRGOmTV3SUuqrWVrflaQw1qiG
 9Te5YTLOCJR3gQ8reIoxQx8i5m2xcLEWhLAHW7NVLATwtdDEVFPEGg5ROZ5lToYlpZzp
 44IjoskvOwH+RDVWo47SL/oUlttRDZSq4R0oRDLZSo8C1sNAB2U/EQ77i5uDEQiUTPak
 5naA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 fh=XKyku5Xx6zjImdtWbj6QnSB087RkKM8hC3fNz7oa6Bc=;
 b=CbDtD1GwOQJlZtNx4u+bPJfXmSk5MA8L4TZr+EzQd4UZaIxKOWhkKH0kt9WwATxcBV
 BbM4P93divKxGHJsYcSd6usj+lX3kXSu1oKAs6wj9TJuxpKAAq6zAcwsSsfDFYYEttkV
 hTxzd6lkmDly3fIjRGxW3J13k4xmv7sz2cfBVjR2Ve+QXvQrcj40j8udJgU3tvcykG1y
 WliusDe9qQ1XzURlKkNDcMMFoazraGN4DJqkQWtska4pzwfWR76H+cVQiUsO+lbEJcUB
 th2a9wjyLBiUYJRGb0Vi3oM7IoRU/d3W2PTB+Z+gUI69xmjpWW0+hyN8bliboUAwu4YC
 XXPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779063616; x=1779668416; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 b=iczJAXDSlePc4uPw0+bWgj1LJ4KjxC+MIhHyxAUojEqa5VbPIH9na6rUb/GUr9AJv0
 r8SoYMlcXNDgoHH0zDEuxUyxltUO0dOZmSgbzAWFdMXQ3i34rTw3ZX0VxSTLguBHOrYn
 P6kBJajYSRXFu+x6qwvplPvV3vC7vhNdSxlsEbmMaNgo/Nx6Uu0vBet3pvqwcnsdD7uf
 Mxkx7NGMwTh4X8vLbbEDzInNKMzDcdm6mrQpgXKJ8k53c2tK3ErF2a49asoSZAI4m9wP
 SqLO4qgnL4A/1g8wbhcH/2xGIOWibydUj35Jz3a7PkzjkqoIDEoamwev1u38NpbFfjM6
 aJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779063616; x=1779668416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 b=lWdwqWjYrxtESKTIeQ0MmSMLFGjRBOcLveRP6smGJOUqkFLVcjaIe78IjzTvb+BNu0
 YY6EpAgFEiNBJ3vs6AnP+ZhwETMzaAXtmA5wbiGc2EGqSfgZ/xnrBOXRLIfeM7X2xWcS
 JxOUUm+byBdhlRu9F+vWEGN6JIQF2n9I25QJt2lkBcssMzYpyvQNV3hEneDo9qOJy5MP
 lLZxsie5nUkZ0lbH8SpGJ66facOOXf7CK2I1RsNbQY7JPKYzeDh5FgUydAYASHkHi9FR
 FnWVzk5U3A3jdWDaDU/y2JqXxZ2TxZzAF1nbysFwhPE8YVMOdiD/9vmS6PZdKGtQQgbj
 9lJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PAO52qpfa1NzeCqqeNwpDi9USHyQmjINlUSK5Vs7ZuReDQAwuS4CzcC6sfN9JiHg67NpoU56w7oC1@nongnu.org
X-Gm-Message-State: AOJu0Yw0dBdlUE7OfK1ynIlVLR1vN/brpCZGf21ZFn/pPlQVetoNSHTx
 l1hFgjZ4B+Khs7iFpLujADVCqpxxU9BC5DI7zx3vxQ8ABtejpDcu4UHgM9pJDC9LaDDaqNx+wIk
 k67PMfQTWp4jcVBf62syETGZbmqHokmI=
X-Gm-Gg: Acq92OFWvrlB5KpAiAbGCF/6LO2hmrumCtVBH1GnVrHGL4A/oCH/i+FSE+glFwmtA8y
 2kFZXf1EGAPlx05e1cCg3OOBq4O/58iAzmWgKHv+W1tGoMDzIgw0vrQ0J8u252EUlJ9iEeUn2qD
 g4/W/LuXf0eweuuW7of5fGzaPAskuDeHBre52bSwgE1LdDJCkHXaM0pvrsPsn8VIqxII4fp9v7f
 t+Y6uhNUU0GjKo2+okNyrVORaeR9L0raLUdShpiF+Cezqb+Me5magLG32VS1ZKk4V8DsPEFoXCr
 Ks6iwizSaWeMzVvs+Ma8HXnaOFzaeoIwaZZVu4kyVyJ/zW75
X-Received: by 2002:a17:907:fdcb:b0:bd5:7c2:42bd with SMTP id
 a640c23a62f3a-bd517ade87dmr575149566b.47.1779063615589; Sun, 17 May 2026
 17:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
In-Reply-To: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:19:46 +1000
X-Gm-Features: AVHnY4JIDwa32oI9nrkJ6RvI8IgaCwhYKSunI8iK_8kf2YDwLp3x8gI_K-QCDbI
Message-ID: <CAKmqyKPGCGn-z6xJXkzGHUOKnmovX=AUYPPSwrJhFZmRfV1+TQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f
To: chen.zhongyao@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 6, 2026 at 10:48=E2=80=AFPM <chen.zhongyao@zte.com.cn> wrote:
>
> The risc-v vector spec defines vmv.s.x and vfmv.s.f as writing
> element 0 of the destination register while the remaining destination
> elements follow the current tail policy. When QEMU runs with
> rvv_ta_all_1s enabled, those elements must therefore become all 1s.
>
> QEMU handled both instructions as translation-time special cases that
> directly wrote vd[0] and skipped the usual tail processing. As a result,
> vmv.s.x and vfmv.s.f left the remaining destination elements unchanged
> instead of applying the configured tail policy.
>
> Fix this by routing both instructions through a helper that writes
> vd[0] and then treats the rest of the destination register as tail,
> reusing the existing agnostic-element fill logic.
>
> Signed-off-by: Zhongyao Chen <chen.zhongyao@zte.com.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/helper.h                   |  4 +++
>  target/riscv/insn_trans/trans_rvv.c.inc | 44 ++++++++-----------------
>  target/riscv/vector_helper.c            | 18 ++++++++++
>  3 files changed, 36 insertions(+), 30 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index b785456ee0..5a7f043edb 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -660,6 +660,10 @@ DEF_HELPER_4(vmv_v_x_b, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_h, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_w, void, ptr, i64, env, i32)
>  DEF_HELPER_4(vmv_v_x_d, void, ptr, i64, env, i32)
> +DEF_HELPER_4(vset_velem0_b, void, ptr, i64, env, i32)
> +DEF_HELPER_4(vset_velem0_h, void, ptr, i64, env, i32)
> +DEF_HELPER_4(vset_velem0_w, void, ptr, i64, env, i32)
> +DEF_HELPER_4(vset_velem0_d, void, ptr, i64, env, i32)
>
>  DEF_HELPER_6(vsaddu_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vsaddu_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_=
trans/trans_rvv.c.inc
> index 4df9a40b44..6a966c35c3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3381,37 +3381,21 @@ static void vec_element_loadi(DisasContext *s, TC=
Gv_i64 dest,
>      load_element(dest, tcg_env, endian_ofs(s, vreg, idx), s->sew, sign);
>  }
>
> -/* Integer Scalar Move Instruction */
> +typedef void gen_helper_vset_velem0(TCGv_ptr, TCGv_i64, TCGv_env, TCGv_i=
32);
>
> -static void store_element(TCGv_i64 val, TCGv_ptr base,
> -                          int ofs, int sew)
> +static void vec_element_storei_tail(DisasContext *s, int vreg, TCGv_i64 =
val)
>  {
> -    switch (sew) {
> -    case MO_8:
> -        tcg_gen_st8_i64(val, base, ofs);
> -        break;
> -    case MO_16:
> -        tcg_gen_st16_i64(val, base, ofs);
> -        break;
> -    case MO_32:
> -        tcg_gen_st32_i64(val, base, ofs);
> -        break;
> -    case MO_64:
> -        tcg_gen_st_i64(val, base, ofs);
> -        break;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> +    static gen_helper_vset_velem0 * const fns[4] =3D {
> +        gen_helper_vset_velem0_b, gen_helper_vset_velem0_h,
> +        gen_helper_vset_velem0_w, gen_helper_vset_velem0_d,
> +    };
> +    TCGv_ptr dest =3D tcg_temp_new_ptr();
> +    uint32_t data =3D FIELD_DP32(0, VDATA, VTA, s->vta);
> +    TCGv_i32 desc =3D tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> +                                              s->cfg_ptr->vlenb, data));
>
> -/*
> - * Store vreg[idx] =3D val.
> - * The index must be in range of VLMAX.
> - */
> -static void vec_element_storei(DisasContext *s, int vreg,
> -                               int idx, TCGv_i64 val)
> -{
> -    store_element(val, tcg_env, endian_ofs(s, vreg, idx), s->sew);
> +    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vreg));
> +    fns[s->sew](dest, val, tcg_env, desc);
>  }
>
>  /* vmv.x.s rd, vs2 # x[rd] =3D vs2[0] */
> @@ -3458,7 +3442,7 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_=
s_x *a)
>           */
>          s1 =3D get_gpr(s, a->rs1, EXT_NONE);
>          tcg_gen_ext_tl_i64(t1, s1);
> -        vec_element_storei(s, a->rd, 0, t1);
> +        vec_element_storei_tail(s, a->rd, t1);
>          gen_set_label(over);
>          tcg_gen_movi_tl(cpu_vstart, 0);
>          finalize_rvv_inst(s);
> @@ -3514,7 +3498,7 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfm=
v_s_f *a)
>          t1 =3D tcg_temp_new_i64();
>          do_nanbox(s, t1, cpu_fpr[a->rs1]);
>
> -        vec_element_storei(s, a->rd, 0, t1);
> +        vec_element_storei_tail(s, a->rd, t1);
>
>          gen_set_label(over);
>          tcg_gen_movi_tl(cpu_vstart, 0);
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 83dd26314d..6c7af25d82 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -2112,6 +2112,24 @@ GEN_VEXT_VMV_VX(vmv_v_x_h, int16_t, H2)
>  GEN_VEXT_VMV_VX(vmv_v_x_w, int32_t, H4)
>  GEN_VEXT_VMV_VX(vmv_v_x_d, int64_t, H8)
>
> +#define GEN_VEXT_SET_VELEM0(NAME, ETYPE, H)                             =
\
> +void HELPER(NAME)(void *vd, uint64_t s1, CPURISCVState *env,            =
\
> +                  uint32_t desc)                                        =
\
> +{                                                                       =
\
> +    uint32_t esz =3D sizeof(ETYPE);                                     =
  \
> +    uint32_t vlenb =3D riscv_cpu_cfg(env)->vlenb;                       =
  \
> +    uint32_t vta =3D vext_vta(desc);                                    =
  \
> +                                                                        =
\
> +    *((ETYPE *)vd + H(0)) =3D (ETYPE)s1;                                =
  \
> +    /* Treat every element past vd[0] as tail for scalar-to-vector moves=
. */ \
> +    vext_set_elems_1s(vd, vta, esz, vlenb);                             =
\
> +}
> +
> +GEN_VEXT_SET_VELEM0(vset_velem0_b, int8_t,  H1)
> +GEN_VEXT_SET_VELEM0(vset_velem0_h, int16_t, H2)
> +GEN_VEXT_SET_VELEM0(vset_velem0_w, int32_t, H4)
> +GEN_VEXT_SET_VELEM0(vset_velem0_d, int64_t, H8)
> +
>  #define GEN_VEXT_VMERGE_VV(NAME, ETYPE, H)                           \
>  void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,          \
>                    CPURISCVState *env, uint32_t desc)                 \
> --
> 2.43.0
>

