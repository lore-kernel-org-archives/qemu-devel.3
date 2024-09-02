Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973D8CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 03:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skxXJ-0006Fs-En; Sun, 01 Sep 2024 23:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1skxXH-0006E7-GD
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 23:15:23 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1skxXF-0004z1-8h
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 23:15:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374ba78f192so1461104f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Sep 2024 20:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725246919; x=1725851719; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bx5JSSz7jW+5+lo/2gxxn6Z1kj4oERA3GvcGJXYaOyI=;
 b=XZoIEN27yRIS/18kMaxwcORCDdC/Wi1FpxeVA4cMufK3ozTJuhuolm1O2YPpOUVUJu
 qnZVnxBaWrI2hVofiHcwrtnneZaiGGi+IwbR5g0ZmHfM7DmH72BoFM7wA4shW5B7PcqJ
 Qw5J+WoSglAmBJv2Mpl8uZxC+GcyugPMv9as4BPTdlZe4+nbr/+FqxRh6OOqlllrDmwz
 qu9N43P6HRKbV3jvMPCw94qo46NAFRR3Isn5CmRHjxn37h2liGe70DD4bMW+gsPXdYhn
 whQs8NrPj4jFauYDcgnN6v0r4IQsB5WHpMVNgfhntRp1VqNE74hc8R7dGlj02NkRvmDq
 qd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725246919; x=1725851719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx5JSSz7jW+5+lo/2gxxn6Z1kj4oERA3GvcGJXYaOyI=;
 b=MsPY7eDULTwM2I2HBgwlZpGOnfykxf0HCZbUljjktVz0+uJmNQeIfEWohYGRI+MNfR
 N5TI4gXNG2T6Aze36qzGr7P29BCH92Qq4rkss7wONJry1vH3usWNRqyuZih/ZfKo+mpW
 XCQftNW6ozlfO0ioJjh+8P4lzCNMucfJ1xw4pwGsoaC12qzMpCuZiqxF4iruxAZVuAtm
 ESdZs2Y0uvstHeF4sN8Jy+L876tFPxAtzCDhVqgNmeZ1UmeBa4DDGIzYnD1uXVnrowtX
 aFI9vd/O9VslXX8r5/NCoAIsLkwSRi7V5zs6Z6+DvYMeobPgnugZqbwURzHoO/gpT2IR
 wLUw==
X-Gm-Message-State: AOJu0YySTZDKR6PIXR+ZMF7HyZnsbHzEPEX4FEWYcNpwMysZI0Nm8PEU
 D9LXQdRs3F0JFH9zFMv2IA9FLE3KVWoGUv6nJX14UtFPJldx9oI0Gq4BXhEdAbi83FJfEkf/lzd
 XslmUdLr7a8hJTdzN0zcApLBcaGA/SigqVXU1Bhr0NlH6X/r/
X-Google-Smtp-Source: AGHT+IH9ANQU22v2LDOAwCSliFx5rguhd+FUAjwLH8lShFuktV1SixEE6nIhf2g/8qcQCfEWEQbSdxFh0D3foincioo=
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df6e with SMTP id
 ffacd0b85a97d-374c269e094mr3569915f8f.25.1725246918879; Sun, 01 Sep 2024
 20:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
 <20240809081227.1588508-5-tommy.wu@sifive.com>
 <CAKmqyKPfn8P4Ky977N=DNSDuf2BK5Cv9bX8B=XwSYvptNYMoEw@mail.gmail.com>
 <CANj3q_kUhx=aPvf2P+nvuUp-rKK+FvyF+UErbPcbYRO7JFQqWw@mail.gmail.com>
 <CAKmqyKPYjcE45rW6b=o2rDeSrRHjsByVCYwF=CjK=pawoJF5Tw@mail.gmail.com>
In-Reply-To: <CAKmqyKPYjcE45rW6b=o2rDeSrRHjsByVCYwF=CjK=pawoJF5Tw@mail.gmail.com>
From: Tommy Wu <tommy.wu@sifive.com>
Date: Mon, 2 Sep 2024 11:15:11 +0800
Message-ID: <CANj3q_mP29UMJFKqcQsj4EyvBDSf9aMkg+kt6Bqp-3fUV4Sw3w@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] target/riscv: Add Smrnmi mnret instruction.
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=tommy.wu@sifive.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 30, 2024 at 7:42=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Fri, Aug 30, 2024 at 2:12=E2=80=AFAM Tommy Wu <tommy.wu@sifive.com> wr=
ote:
> >
> > On Mon, Aug 19, 2024 at 11:49=E2=80=AFAM Alistair Francis <alistair23@g=
mail.com> wrote:
> > >
> > > On Fri, Aug 9, 2024 at 6:12=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com>=
 wrote:
> > > >
> > > > This patch adds a new instruction `mnret`. `mnret` is an M-mode-onl=
y
> > > > instruction that uses the values in `mnepc` and `mnstatus` to retur=
n to the
> > > > program counter, privilege mode, and virtualization mode of the
> > > > interrupted context.
> > > >
> > > > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > > > Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> > > > ---
> > > >  target/riscv/helper.h                         |  1 +
> > > >  target/riscv/insn32.decode                    |  3 ++
> > > >  .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
> > > >  target/riscv/op_helper.c                      | 46 +++++++++++++++=
++++
> > > >  4 files changed, 62 insertions(+)
> > > >
> > > > diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> > > > index 451261ce5a..16ea240d26 100644
> > > > --- a/target/riscv/helper.h
> > > > +++ b/target/riscv/helper.h
> > > > @@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, =
tl, tl)
> > > >  #ifndef CONFIG_USER_ONLY
> > > >  DEF_HELPER_1(sret, tl, env)
> > > >  DEF_HELPER_1(mret, tl, env)
> > > > +DEF_HELPER_1(mnret, tl, env)
> > > >  DEF_HELPER_1(wfi, void, env)
> > > >  DEF_HELPER_1(wrs_nto, void, env)
> > > >  DEF_HELPER_1(tlb_flush, void, env)
> > > > diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decod=
e
> > > > index c45b8fa1d8..d320631e8c 100644
> > > > --- a/target/riscv/insn32.decode
> > > > +++ b/target/riscv/insn32.decode
> > > > @@ -121,6 +121,9 @@ wfi         0001000    00101 00000 000 00000 11=
10011
> > > >  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> > > >  sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
> > > >
> > > > +# *** NMI ***
> > > > +mnret       0111000    00010 00000 000 00000 1110011
> > > > +
> > > >  # *** RV32I Base Instruction Set ***
> > > >  lui      ....................       ..... 0110111 @u
> > > >  auipc    ....................       ..... 0010111 @u
> > > > diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/targe=
t/riscv/insn_trans/trans_privileged.c.inc
> > > > index bc5263a4e0..06bc20dda4 100644
> > > > --- a/target/riscv/insn_trans/trans_privileged.c.inc
> > > > +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> > > > @@ -106,6 +106,18 @@ static bool trans_mret(DisasContext *ctx, arg_=
mret *a)
> > > >  #endif
> > > >  }
> > > >
> > > > +static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
> > > > +{
> > > > +#ifndef CONFIG_USER_ONLY
> > > > +    gen_helper_mnret(cpu_pc, tcg_env);
> > > > +    tcg_gen_exit_tb(NULL, 0); /* no chaining */
> > > > +    ctx->base.is_jmp =3D DISAS_NORETURN;
> > > > +    return true;
> > > > +#else
> > > > +    return false;
> > > > +#endif
> > > > +}
> > > > +
> > > >  static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
> > > >  {
> > > >  #ifndef CONFIG_USER_ONLY
> > > > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > > > index 25a5263573..3e26392e65 100644
> > > > --- a/target/riscv/op_helper.c
> > > > +++ b/target/riscv/op_helper.c
> > > > @@ -353,6 +353,52 @@ target_ulong helper_mret(CPURISCVState *env)
> > > >      return retpc;
> > > >  }
> > > >
> > > > +target_ulong helper_mnret(CPURISCVState *env)
> > > > +{
> > > > +    if (!riscv_cpu_cfg(env)->ext_smrnmi) {
> > > > +        /* RNMI feature is not presented. */
> > > > +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
> > > > +    }
> > > > +
> > > > +    if (!(env->priv >=3D PRV_M)) {
> > >
> > > This should just be (env->priv !=3D PRV_M)
> > >
> >
> > Thanks for the suggestion. You=E2=80=99re right.
> > The reason that we write the code is that we want to do the same
> > checks that `helper_mret` does.[1]
> >
> > Maybe we can send another patchset to fix both `helper_mret` and `helpe=
r_mnret`.
> >
> > [1]  https://github.com/qemu/qemu/commit/0c3e702aca76ca6ebf2aac4451870e=
fc9d52a7a3
> >
> > > > +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
> > > > +    }
> > > > +
> > > > +    /* Get return PC from mnepc CSR. */
> > > > +    target_ulong retpc =3D env->mnepc;
> > > > +    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> > >
> > > What is the purpose of this check? The low bits should be zero,
> > > unrelated to the compressed instructions
> > >
> >
> > This is also the same check that `helper_mret` does.[1]
> > Maybe we can send another patchset to fix both `helper_mret` and `helpe=
r_mnret`.
>
> Ah, ok. It's probably worth splitting the shared helper_mret() code
> into a helper function then
>
> Alistair
>

Thanks for the suggestion, I'll split the shared code into
a helper function in the v6 patchset.

Best Regards,
Tommy Wu

> >
> > [1]  https://github.com/qemu/qemu/commit/0c3e702aca76ca6ebf2aac4451870e=
fc9d52a7a3
> >
> > > > +        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC=
());
> > > > +    }
> > > > +
> > > > +    /* Get previous privilege level from mnstatus CSR. */
> > > > +    target_ulong prev_priv =3D get_field(env->mnstatus, MNSTATUS_M=
NPP);
> > > > +
> > > > +    if (riscv_cpu_cfg(env)->pmp &&
> > > > +        !pmp_get_num_rules(env) && (prev_priv !=3D PRV_M)) {
> > >
> > > I don't see this mentioned in:
> > >
> > > https://github.com/riscv/riscv-isa-manual/blob/a4382e9c8e285360a88d80=
56c1253e1525552393/src/rnmi.adoc
> > >
> > > Alistair
> > >
> >
> > This is also the same check that `helper_mret` does.[2]
> > It seems that this part is mentioned in the `riscv-privileged`
> > specification, `Priority and Matching Logic` section.
> >
> > [2] https://github.com/qemu/qemu/commit/0fbb5d2d3c9ded9fbd3f6f993974cc5=
e88e28912
> >
> > Thanks for all the suggestions and code review.
> >
> > Best Regards,
> > Tommy Wu.
> >
> > > > +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
> > > > +    }
> > > > +
> > > > +    target_ulong prev_virt =3D get_field(env->mnstatus, MNSTATUS_M=
NPV) &&
> > > > +                             (prev_priv !=3D PRV_M);
> > > > +    env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, true=
);
> > > > +
> > > > +    /*
> > > > +     * If MNRET changes the privilege mode to a mode
> > > > +     * less privileged than M, it also sets mstatus.MPRV to 0.
> > > > +     */
> > > > +    if (prev_priv < PRV_M) {
> > > > +        env->mstatus =3D set_field(env->mstatus, MSTATUS_MPRV, fal=
se);
> > > > +    }
> > > > +
> > > > +    if (riscv_has_ext(env, RVH) && prev_virt) {
> > > > +        riscv_cpu_swap_hypervisor_regs(env);
> > > > +    }
> > > > +
> > > > +    riscv_cpu_set_mode(env, prev_priv, prev_virt);
> > > > +
> > > > +    return retpc;
> > > > +}
> > > > +
> > > >  void helper_wfi(CPURISCVState *env)
> > > >  {
> > > >      CPUState *cs =3D env_cpu(env);
> > > > --
> > > > 2.39.3
> > > >

