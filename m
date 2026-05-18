Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E70CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlmg-0001EV-1s; Sun, 17 May 2026 20:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlme-0001EF-Va
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:24:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlmd-00017O-4e
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:24:36 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so3748143a12.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779063873; cv=none;
 d=google.com; s=arc-20240605;
 b=h1IoMAwSb4Tkfu+aTJU0nsHcjaCcFqXeLRau7M+yNUB+ADACGTFzx+MM6OrVVrQqgy
 1x1C9o6yiPz8JZEfiyiLy95uhfBM7/VfPNcc3mtew49oOk1aIdXEQ5nfGCHjKj9zxins
 jKCDoBExhfxQXRibCRmdOQ8HSiEUXoOcxYwGo6DGCNHs0pb+l5NTBl68jG487AlTQ44z
 g5Athm7frPgSjH6Ev9xxa+3Srex8eh8pq2202OWgUtdwfhqt1DDxlgxod5Kot/rmmhLq
 +hOS/l5B0pRVMaqH2PBTludCQFOcsSXonZNfIGR3pX098azNXm0lb69d6GSJhqvaK4oR
 aDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 fh=CtzDHzEGPwzIyyJNs32woL8TQp4Wf51MFKHpvXrjGLM=;
 b=KAPurJHf25reU6uJCso/FiazFMbg9tOFGvIku4BEadMPeRp8lURCLOTTkgGO3wp1ug
 r6G+J1cyWzFqbc/OzEAryUDaOvnDJrg1V+x9QvQeKoKvp/RqtGMsuQPMZxZ4b7IFD4au
 VNwF7vYL+QZ6fnpZah9DRp4tbEsJaTN8K2uj6pWPRWoiNkpL9jm6dEKKdsKGG/y/rjKk
 8EsKseOqcgbw43rngUEokyQPaer+mdv+NCCYYPRhPXYWi4wYURth9nbBnkVrU2sxUVqW
 WS1EiwoEok75bAPPy9VD4WyjAnn94yqxcLbyd0xclBTgHmJJ64TFSqhUin07+eBQS4iS
 D2NA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779063873; x=1779668673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 b=n1BybtrAGAp3XEtRa/45LbduUKsd8akSyWciJ9ErmChBMtuwv682t5twA2FabETBEN
 Sc32euV56JlXYT/qbIRrCaX7qLHoQHDYRm39PEUbznbovKv9A8Pg9j3T+eKFldaWrTOb
 1uCucjUzyEhQOcwX+9Oa052gTpIet381x0VIu6upSQ+jQOgu2kG2FwDq5S7/EthN36lb
 Ltk0VTdvZDy0wbzv0hFCxj2TSdgtn59N1MMqyaM+M7ffcct4MlKUOWqkuGDWBISIEZ7p
 gV8cj5F+5xv7baYPF/Z+lDrlKWLRaH2JFempDkRXgN3hRNFo41S4iF2F0OaQGbuBUg3V
 Nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779063873; x=1779668673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/zwEdS9SLT2HbgocJWHB4GcBIZfzn4qfc/P2RTi98y0=;
 b=OZzT7R12XsbQdiLKjlnkTleimXxiSUvtsXI/0bWVNagqbrDGCbNhpIOlnHRdm+SLTG
 H+Uz0nE5MEzW8PaUaubLtDCFq9isCDneoklIGGP0iJaJK8HtfO583FSFDafVczWpIaLI
 GByBEOMPkdSJPbWcHouHvvXaoQjXCAa0WnCY1rjUfudE4Qtxyme44V4Bl5/P/+k+vQeh
 l65ZTTqlkMQKq13lhRRnkBlIhTdZC3lBBr/iI46/3/ilJqE8SaN4TN5b4DXDR36ZS/f/
 i+o4xciU+E34/j6i1SKEAA5MQnhVpWMNolJUa9P8npekR/0VSz+b4Y1NOnWq0Og4XwG0
 ePtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qdSkgD0qJKqpM5stzwvWCvAmG8MlnD7MRe61NC+Bi6PPdWn1Mv93w+8aISfQ9gzLpWNxYLwY0V768@nongnu.org
X-Gm-Message-State: AOJu0YwO21l8QzMIHCAvOwSzU9AZpelh7N4W4wwAoosbcdaKjNgcnyvk
 9mi7TN1FDO2/AOxekKru38f1YjIOKioz3LiC+9NCI/H96+OPptzsoc65e97MvM5iR1MBkeN8Ll2
 p9TsfQcHpfKDLQblS39H7BQGV+0uq5tY=
X-Gm-Gg: Acq92OH5zy2HO3kLZ/lzJAYdn2juqLzjo7iyQYkGEsOQzTw35d5RtaW6K2cEVL11XTP
 Brx6DTCfSqSfij/0zUWfS7zofAHu8YHTrA1AzlAmYo/t4rFKWcesZd+Q+TNe3XQj/UzWwJJ2H1/
 pGbE46QbxXx5VaO8mtx/JoR89VS4ulwhH+Gva0RagJhlkezRyVoweklJ9DuIDuXSP3AB/4u4NJP
 hvmExUljGd7+qNH686t+rNznKZxSvlV25jcQzQuMvT6svWTII4JGgePYOAEr7EdWYtrg2pNAjyB
 BeZdkYpu+SDzAH2VuiZrpObITKuMPOBJfe9OFA==
X-Received: by 2002:a17:907:960a:b0:bc6:502e:6d68 with SMTP id
 a640c23a62f3a-bd517acc9cbmr632931766b.40.1779063873444; Sun, 17 May 2026
 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
In-Reply-To: <202605061005.646A537u037157@mse-fl1.zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:24:07 +1000
X-Gm-Features: AVHnY4IpbK70lkilURPmIH8GlBqu8z7gUEyFtU7z7F1UN3PihKYWB8LCkJuvK4w
Message-ID: <CAKmqyKNV98bOEaYvHD0i4Y7hQ-q894Z+4Yh-huzEacyr4kejCg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f
To: chen.zhongyao@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

