Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FBCE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJAA8-0003dQ-FD; Thu, 05 Dec 2024 06:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJAA5-0003cK-AO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:36:50 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJAA2-0001vU-Ku
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:36:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382610c7116so469569f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733398605; x=1734003405;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kl7RPC7uXFaDdUNDhkmVGK5VQXLVVvB6stq7MTl/lxY=;
 b=c5pvuzcVGZPae5ccn6x+/ArkNMPtTyEN6uq2hETIvAfmj/7k5xYr9Rt3CcCikdZD/S
 jrmRWRDPzeY6O7f7uVXIqL0aF/q0UUZ+aDcuit5HGzm9UQm0FmFKjtJx7WFmlAfYqP3f
 xmM8sS70hlBnaqbAlFxq7q+439envxQ6V4E4NwPgo/RJiNi03PBAZ+OfUqtUfyNnqcWg
 fASmSgWFKlxNMlppTh0h8VPO4mRbNZnTLMndB1RWk+WpjIbHjELE9pZu1Mg35Lt0MFI8
 HBlH56wamPvmqLlX03id/klLm+d1bbF9IIqpkKTs/nwi7ZpnjlJCCyjpTQs1jVdqzHRy
 tCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733398605; x=1734003405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kl7RPC7uXFaDdUNDhkmVGK5VQXLVVvB6stq7MTl/lxY=;
 b=KxuKmZMbzo4Uff0xW/J9lgt22mOTqfw1M30m6n3MsJRkCCbpb0Zgm+US2t+f8vkfSA
 OjOQg3k/xr281eVB0OH4TlPps7zHGh+XL8riozxl5RhHWJcaB6x3W7rWIAmMVZBBD9FL
 1ukEnE1AiGSHGANQQS8sFKzDTtbgDSxMKzasVKOb1BoLyHci1i1JqwYrRYCEX6OusBjb
 G+ZFjoO33hBOnrTDVIY6nFB9m54PuWphr++pL63Vi6viktewkByTwl8x1niCJFwBDuSz
 tnbZxLI8bdgnzSZaLPiixyjs4qL5Aq8hcnJatNWhwPCTfr1PhWjv6Pv0QU+zGUFnnQU9
 cu+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Qaz441VvCkU+P5HWLAqHEJQEV+nlBbLKspxvflNxDp06Z9fcwy/9zYPVUzSym5Ul5VM95x4NUjkT@nongnu.org
X-Gm-Message-State: AOJu0YySwzL/cV/B4pbrjC+lyVOBNZ19CM/HOS7Pa5Uxq2IQLcXuP+j+
 yKhGOXDzsRctK+qDKh1WfVPThcXhTraSI196mc6D3VuMawDM3vYMrQk9TGdVqhFqCTSiTTZ0W13
 NOw0fbOZcZQyr59ui+N6k04wQxt+bvx0Oph0Wjw==
X-Gm-Gg: ASbGncvGyMU5aWpVkBaD2u8e22QV5LSv4iuAPxC8Q5p2KD/hvr8KZgKgquQwKh2M3aP
 yF1lX8epBTt4smsLbhA1TOJveK4BMsY4=
X-Google-Smtp-Source: AGHT+IHM/mDW/zq4hP1u3CzM1fVVnaHCUQM1sqmFz3RxUrj20rFOcIv5ygkgWkFZKam8a+Wh/RUmz954cfENFrLMuVI=
X-Received: by 2002:a5d:6487:0:b0:385:edb7:69ba with SMTP id
 ffacd0b85a97d-385fd3ce954mr8009002f8f.1.1733398604842; Thu, 05 Dec 2024
 03:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
 <20241204-b4-ctr_upstream_v3-v4-4-d3ce6bef9432@rivosinc.com>
 <625bbb08-aac1-42c7-84b1-572fe48093d6@linaro.org>
In-Reply-To: <625bbb08-aac1-42c7-84b1-572fe48093d6@linaro.org>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Thu, 5 Dec 2024 16:36:34 +0500
Message-ID: <CAECbVCtYJztnxMqiBc0eYc6AD69E6+V7qmX4nXCYSrf-MRk9qQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] target/riscv: Add support to record CTR entries.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com, frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks Richard. I have incorporated your feedback in v5.

-Rajnesh

On Wed, Dec 4, 2024 at 7:30=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/4/24 06:56, Rajnesh Kanwal wrote:
> > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/ri=
scv/insn_trans/trans_privileged.c.inc
> > index 0bdfa9a0ed3313223ce9032fb24484c3887cddf9..a5c2410cfa0779b1a928e7b=
89bd2ee5bb24216e4 100644
> > --- a/target/riscv/insn_trans/trans_privileged.c.inc
> > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> > @@ -78,9 +78,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *=
a)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> >       if (has_ext(ctx, RVS)) {
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> This is incorrect.
> You need to use gen_pc_plus_diff(src, ctx, 0).
>
> Alternately, for here in sret and mret, instead of adding an extra parame=
ter, use
> gen_update_pc(ctx, 0) to update env->pc
>
>
>
> > @@ -95,9 +96,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *=
a)
> >   static bool trans_mret(DisasContext *ctx, arg_mret *a)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> Likewise.
>
>
> > diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/ins=
n_trans/trans_rvi.c.inc
> > index 96c218a9d7875c6419287ac3aa9746251be3f442..fc182e7b18a289e13ad212f=
10a3233aca25fae41 100644
> > --- a/target/riscv/insn_trans/trans_rvi.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> > @@ -93,6 +93,50 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
> >       return true;
> >   }
> >
> > +#ifndef CONFIG_USER_ONLY
> > +/*
> > + * Indirect calls
> > + * - jalr x1, rs where rs !=3D x5;
> > + * - jalr x5, rs where rs !=3D x1;
> > + * - c.jalr rs1 where rs1 !=3D x5;
> > + *
> > + * Indirect jumps
> > + * - jalr x0, rs where rs !=3D x1 and rs !=3D x5;
> > + * - c.jr rs1 where rs1 !=3D x1 and rs1 !=3D x5.
> > + *
> > + * Returns
> > + * - jalr rd, rs where (rs =3D=3D x1 or rs =3D=3D x5) and rd !=3D x1 a=
nd rd !=3D x5;
> > + * - c.jr rs1 where rs1 =3D=3D x1 or rs1 =3D=3D x5.
> > + *
> > + * Co-routine swap
> > + * - jalr x1, x5;
> > + * - jalr x5, x1;
> > + * - c.jalr x5.
> > + *
> > + * Other indirect jumps
> > + * - jalr rd, rs where rs !=3D x1, rs !=3D x5, rd !=3D x0, rd !=3D x1 =
and rd !=3D x5.
> > + */
> > +static void helper_ctr_jalr(DisasContext *ctx, arg_jalr *a)
>
> Generally "helper_*" are out-of-line functions, whereas this is generatin=
g inline code.
> Better as "gen_ctr_jalr".
>
> > +{
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> gen_pc_plus_diff
>
> > @@ -219,6 +269,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a,=
 TCGCond cond)
> >       TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_SIGN);
> >       TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_SIGN);
> >       target_ulong orig_pc_save =3D ctx->pc_save;
> > +#ifndef CONFIG_USER_ONLY
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
> > +#endif
>
> gen_pc_plus_diff, though perhaps delay until used.
>
> >
> >       if (get_xl(ctx) =3D=3D MXL_RV128) {
> >           TCGv src1h =3D get_gprh(ctx, a->rs1);
> > @@ -231,6 +284,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a=
, TCGCond cond)
> >       } else {
> >           tcg_gen_brcond_tl(cond, src1, src2, l);
> >       }
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_NONTAKEN_BRANCH);
> > +        TCGv dest =3D tcg_constant_tl(ctx->base.pc_next + ctx->cur_ins=
n_len);
>
> gen_pc_plus_diff
>
> > +        gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> > +    }
> > +#endif
> > +
> >       gen_goto_tb(ctx, 1, ctx->cur_insn_len);
> >       ctx->pc_save =3D orig_pc_save;
> >
> > @@ -243,6 +305,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a=
, TCGCond cond)
> >           gen_pc_plus_diff(target_pc, ctx, a->imm);
> >           gen_exception_inst_addr_mis(ctx, target_pc);
> >       } else {
> > +#ifndef CONFIG_USER_ONLY
> > +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +            TCGv type =3D tcg_constant_tl(CTRDATA_TYPE_TAKEN_BRANCH);
> > +            TCGv dest =3D tcg_constant_tl(ctx->base.pc_next + a->imm);
>
> gen_pc_plus_diff.
>
> > diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/i=
nsn_trans/trans_rvzce.c.inc
> > index cd234ad960724c936b92afb6fd1f3c7c2a37cb80..07b51d9f4d847c4411165b4=
22a843fea65c86d45 100644
> > --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> > +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> > @@ -204,6 +204,13 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a=
, bool ret, bool ret_val)
> >       if (ret) {
> >           TCGv ret_addr =3D get_gpr(ctx, xRA, EXT_SIGN);
> >           tcg_gen_mov_tl(cpu_pc, ret_addr);
> > +#ifndef CONFIG_USER_ONLY
> > +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +            TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> gen_pc_plus_diff, and it will need to be done *before* the assignment to =
cpu_pc.
>
> > @@ -309,6 +316,21 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_c=
m_jalt *a)
> >           gen_set_gpr(ctx, xRA, succ_pc);
> >       }
> >
> > +#ifndef CONFIG_USER_ONLY
> > +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> > +        TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> Here, we have updated cpu_pc to current (see the start of the function), =
so you can just
> use that instead of src.
>
> > +void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
> > +                          target_ulong dest, target_ulong type)
> > +{
> > +    riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
> > +                            env->priv, env->virt_enabled);
>
> Indent to line up after (.
>
> > +static void helper_ctr_jal(DisasContext *ctx, int rd, target_ulong imm=
)
>
> gen_ctr_jal.
>
> > +{
> > +    TCGv dest =3D tcg_constant_tl(ctx->base.pc_next + imm);
> > +    TCGv src =3D tcg_constant_tl(ctx->base.pc_next);
>
> gen_pc_plus_diff.
>
>
> r~

