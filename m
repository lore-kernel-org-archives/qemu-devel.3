Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D79C27C78
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 03:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHEQq-0001N3-Sm; Tue, 11 Jun 2024 23:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sHEQp-0001Mk-4N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 23:13:51 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sHEQl-0003va-Or
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 23:13:50 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ead2c6b50bso68110651fa.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 20:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1718162025; x=1718766825; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/GGHIC59WLRW0IYL0ukNap7UA0nqYN/ZP0WOlZdgphE=;
 b=kZfwaxfoUABCTS3kjZpmZaLuN5T1hHUPidfvAYshiHsDNvEQr2DtU7zGptwDynypeu
 dUUmMHMNziYgBLhi/oWSt1GLDFTIKzXQUHLh3IpkpqjM5zTxzF94qgjKWgvRXs8hIUNh
 bJiSXLGk55dN0yQ+2UIn4Bo1kyu+mSxbr/Q3gkYWmOsKzlQPAwMZvrbZ0+lLekluQI58
 OqZkftzAF/alrmIN1dBoSCUx4vIU755WRbWGFBTSu9RtL0u0rQlIRjpK76wcMK1cen7e
 mEMFfm1F97lhaevFyMwlWoNQK3LT1mFEbCqvEw+wyGRjXi5prkv/A0ilSVc2eh8CG/T/
 q1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718162025; x=1718766825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/GGHIC59WLRW0IYL0ukNap7UA0nqYN/ZP0WOlZdgphE=;
 b=wqQZI2yFMIcAb3GaS2viGUdXmq8vclIADEOBAhMQp2p4Y28hBTFu6e/Qp4qim8YRZ+
 e58UILLFlnTEw+P3YXoI4kChDdHTl5RhYfiqr6HR7vW6h/1F9lyPV8UeWJSK/qJpQtrK
 7ztWScrKHZChcPUFWVlPBp6QoT1co0FsXSD/ZQ43Rtr2qOwIVlbTtrHEUhONgYxOQ7Jq
 XCoAL+DuOOa1QU70IdKBUR0RDgPuJ8SsrjbIl45zPBSH32rh8X5+BnKDYc36KvrUMEHy
 CoepTGF4x8OpdKbbIXcO9KCGeFPTS8B1Cg/fB6B2KqiM489rgFkM8cs3NR6y/vaEerxQ
 3RXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5UwSUfedhomf3rIrJqjBMXoO3o4cOKaPPGH+6FFCRzdD2mrTmr/zkaDMBGlq3QjxEKxhPCTWmC6tzqt8ozWm24J74GEc=
X-Gm-Message-State: AOJu0YwZGfy44nTdiZ5j1j16xRADYRER/s8e+Nps5vq8bvOwAguSJGcI
 QVVvQAdB+wg8hQlyW9qJsnLOYxlBBBtWM4hM9Magl5d1AbjII0QFwPgcY4ucQeJJiiexGukj558
 wQm1rz19iLGYY63SX/IKWoJaLV9oSfANtX/QVgw==
X-Google-Smtp-Source: AGHT+IF8QUHcb6oyBqVoSaUqvWyinN4P7MuJgG3eUky9bJchr9FwP5wknDEAYGq8b1rn3+3Ny3ZW53wSoAxSMEPFBVk=
X-Received: by 2002:a2e:b00c:0:b0:2eb:eb23:6cda with SMTP id
 38308e7fff4ca-2ebfc964bd6mr2454441fa.49.1718162025324; Tue, 11 Jun 2024
 20:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-4-rkanwal@rivosinc.com>
 <3f3cc0f1-0a56-452a-a934-b3f770056570@sifive.com>
 <CAECbVCucQK3PF3vrgzVQbvsidPF_o9TgkjV6PxA3KN-4wt_+eA@mail.gmail.com>
In-Reply-To: <CAECbVCucQK3PF3vrgzVQbvsidPF_o9TgkjV6PxA3KN-4wt_+eA@mail.gmail.com>
From: Jason Chien <jason.chien@sifive.com>
Date: Wed, 12 Jun 2024 11:13:33 +0800
Message-ID: <CADr__8rjNYqoDcA5Wm+2PuB9L0isBeS=f2_uUWJ=bjqzFPaKow@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Content-Type: multipart/alternative; boundary="0000000000002fba00061aa8c56b"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=jason.chien@sifive.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000002fba00061aa8c56b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It makes sense. Thank you for the explanation.

Rajnesh Kanwal <rkanwal@rivosinc.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=
=BC=9A

>
> Thanks Jason for your review.
>
> On Tue, Jun 4, 2024 at 11:14=E2=80=AFAM Jason Chien <jason.chien@sifive.c=
om>
> wrote:
> >
> >
> > Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=B8=8A=E5=8D=88 12:09 =E5=AF=AB=
=E9=81=93:
> >
> > This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> > sctrdepth CSRs handling.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  target/riscv/cpu.h     |   5 ++
> >  target/riscv/cpu_cfg.h |   2 +
> >  target/riscv/csr.c     | 159 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 166 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index a185e2d494..3d4d5172b8 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -263,6 +263,11 @@ struct CPUArchState {
> >      target_ulong mcause;
> >      target_ulong mtval;  /* since: priv-1.10.0 */
> >
> > +    uint64_t mctrctl;
> > +    uint32_t sctrdepth;
> > +    uint32_t sctrstatus;
> > +    uint64_t vsctrctl;
> > +
> >      /* Machine and Supervisor interrupt priorities */
> >      uint8_t miprio[64];
> >      uint8_t siprio[64];
> > diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> > index d9354dc80a..d329a65811 100644
> > --- a/target/riscv/cpu_cfg.h
> > +++ b/target/riscv/cpu_cfg.h
> > @@ -123,6 +123,8 @@ struct RISCVCPUConfig {
> >      bool ext_zvfhmin;
> >      bool ext_smaia;
> >      bool ext_ssaia;
> > +    bool ext_smctr;
> > +    bool ext_ssctr;
> >      bool ext_sscofpmf;
> >      bool ext_smepmp;
> >      bool rvv_ta_all_1s;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 2f92e4b717..888084d8e5 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -621,6 +621,61 @@ static RISCVException pointer_masking(CPURISCVStat=
e
> *env, int csrno)
> >      return RISCV_EXCP_ILLEGAL_INST;
> >  }
> >
> > +/*
> > + * M-mode:
> > + * Without ext_smctr raise illegal inst excep.
> > + * Otherwise everything is accessible to m-mode.
> > + *
> > + * S-mode:
> > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> > + * Otherwise everything other than mctrctl is accessible.
> > + *
> > + * VS-mode:
> > + * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
> > + * Without hstateen.ctr raise virtual illegal inst excep.
> > + * Otherwise allow vsctrctl, sctrstatus, 0x200-0x2ff entry range.
> > + * Always raise illegal instruction exception for sctrdepth.
> > + */
> > +static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
> > +{
> > +    /* Check if smctr-ext is present */
> > +    if (riscv_cpu_cfg(env)->ext_smctr) {
> > +        return RISCV_EXCP_NONE;
> > +    }
> > +
> > +    return RISCV_EXCP_ILLEGAL_INST;
> > +}
> > +
> > +static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> > +{
> > +    if ((env->priv =3D=3D PRV_M && riscv_cpu_cfg(env)->ext_smctr) ||
> > +        (env->priv =3D=3D PRV_S && !env->virt_enabled &&
> > +         riscv_cpu_cfg(env)->ext_ssctr)) {
> > +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> > +    }
> > +
> > +    if (env->priv =3D=3D PRV_S && env->virt_enabled &&
> > +        riscv_cpu_cfg(env)->ext_ssctr) {
> > +        if (csrno =3D=3D CSR_SCTRSTATUS) {
> >
> > missing sctrctl?
> >
> > +            return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> > +        }
> > +
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> > +    return RISCV_EXCP_ILLEGAL_INST;
> > +}
> >
> > I think there is no need to bind M-mode with ext_smctr, S-mode with
> ext_ssctr and VS-mode with ext_ssctr, since this predicate function is fo=
r
> S-mode CSRs, which are defined in both smctr and ssctr, we just need to
> check at least one of ext_ssctr or ext_smctr is true.
> >
> > The spec states that:
> > Attempts to access sctrdepth from VS-mode or VU-mode raise a
> virtual-instruction exception, unless CTR state enable access restriction=
s
> apply.
> >
> > In my understanding, we should check the presence of smstateen extensio=
n
> first, and
> >
> > if smstateen is implemented:
> >
> > for sctrctl and sctrstatus, call smstateen_acc_ok()
> > for sctrdepth, call smstateen_acc_ok(), and if there is any exception
> returned, always report virtual-instruction exception.
>
> For sctrdepth, we are supposed to always return a virt-inst exception in
> case of
> VS-VU mode unless CTR state enable access restrictions apply.
>
> So for sctrdepth, call smstateen_acc_ok(), and if there is no exception
> returned
> (mstateen.CTR=3D1 and hstateen.CTR=3D1 for virt mode), check if we are in
> virtual
> mode and return virtual-instruction exception otherwise return
> RISCV_EXCP_NONE.
> Note that if hstateen.CTR=3D0, smstateen_acc_ok() will return
> virtual-instruction
> exception which means regardless of the hstateen.CTR state, we will alway=
s
> return virtual-instruction exception for VS/VU mode access to sctrdepth.
>
> Basically this covers following rules for sctrdepth:
>
> if mstateen.ctr =3D=3D 0
>     return RISCV_EXCP_ILLEGAL_INST; // For all modes lower than M-mode.
> else if in virt-mode // regardless of the state of hstateen.CTR
>     return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> else
>     return RISCV_EXCP_NONE
>
> >
> > If smstateen is not implemented:
> >
> > for sctrctl and sctrstatus, there is no check.
> > for sctrdepth, I think the spec is ambiguous. What does "CTR state
> enable access restrictions apply" mean when smstateen is not implemented?
>
> As per my understanding, this means if mstateen.CTR=3D0 then we return an
> illegal instruction exception regardless if it's virtual mode or not. Thi=
s
> is
> the only effect of CTR state enable on sctrdepth CSR. If mstateen.CTR=3D1=
,
> sctrdepth access from VS-mode results in virtual-instruction exception
> regardless of hstateen.CTR.
>
> Based on this, we have following model for predicate checks:
>
> if smstateen is implemented:
>
> for sctrctl and sctrstatus, call smstateen_acc_ok()
> for sctrdepth, call smstateen_acc_ok(), and if there is no exception,
>     check if we are in virtual mode and return virtual-instruction
> exception
>     otherwise return RISCV_EXCP_NONE.
>
> If smstateen is not implemented:
>
> for sctrctl and sctrstatus, there is no check.
> for sctrdepth, if in VS/VU mode return virtual-instruction exception
> otherwise
>     no check.
>
> Here is the code to better understand this.
>
> static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> {
>     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>
>     if (!cfg->ext_ssctr && !cfg->ext_smctr) {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>
>     if (riscv_cpu_cfg(env)->ext_smstateen) {
>         RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
>         if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
> env->virt_enabled) {
>             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>         }
>         return ret;
>     } else {
>         if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
>             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>         }
>     }
>
>     return RISCV_EXCP_NONE;
> }
>
> Given smstateen_acc_ok() returns RISCV_EXCP_NONE in case if ext_smstateen
> is not
> implemented, this can be further simplified to:
>
> static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> {
>     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
>
>     if (!cfg->ext_ssctr && !cfg->ext_smctr) {
>         return RISCV_EXCP_ILLEGAL_INST;
>     }
>
>     RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
>     if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
> env->virt_enabled) {
>         return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>     }
>     return ret;
> }
>
> >
> > Here is the code to better understand my description.
> >
> > static RISCVException ctr_smode(CPURISCVState *env, int csrno)
> > {
> >     const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >
> >     if (!cfg->ext_ssctr && !cfg->ext_smctr) {
> >         return RISCV_EXCP_ILLEGAL_INST;
> >     }
> >
> >     if (riscv_cpu_cfg(env)->ext_smstateen) {
> >         RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR)=
;
> >         if (ret !=3D RISCV_EXCP_NONE) {
> >             if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
> >                 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> >             }
> >
> >             return ret;
> >         }
> >     } else {
> >         /* The spec is ambiguous. */
> >         if (csrno =3D=3D CSR_SCTRDEPTH && env->virt_enabled) {
> >             return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> >         }
> >     }
> >
> >     return RISCV_EXCP_NONE;
> > }
> >
> > +
> > +static RISCVException ctr_vsmode(CPURISCVState *env, int csrno)
> > +{
> > +    if (env->priv =3D=3D PRV_S && env->virt_enabled &&
> > +        riscv_cpu_cfg(env)->ext_ssctr) {
> > +        return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> >
> > In riscv_csrrw_check(), an virtual-instruction exception is always
> reported no matter what. Do we need this check?
> >
> > +    }
> > +
> > +    return ctr_smode(env, csrno);
> > +}
> > +
> >  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
> >  {
> >      int ret;
> > @@ -3835,6 +3890,100 @@ static RISCVException write_satp(CPURISCVState
> *env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong
> wr_mask)
> > +{
> > +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->sctrdepth & SCTRDEPTH_MASK;
> >
> > We don't need to do bitwise and with SCTRDEPTH_MASK on read accesses
> when we always do bitwise and with SCTRDEPTH_MASK on write accesses.
> >
> > +    }
> > +
> > +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
> > +
> > +    /* Correct depth. */
> > +    if (wr_mask & SCTRDEPTH_MASK) {
> > +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK);
> > +
> > +        if (depth > SCTRDEPTH_MAX) {
> > +            env->sctrdepth =3D
> > +                set_field(env->sctrdepth, SCTRDEPTH_MASK,
> SCTRDEPTH_MAX);
> > +        }
> > +
> > +        /* Update sctrstatus.WRPTR with a legal value */
> > +        depth =3D 16 << depth;
> >
> > The "depth" on the right side may exceed SCTRDEPTH_MAX.
> >
> > +        env->sctrstatus =3D
> > +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> > +    }
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException rmw_mctrctl(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong
> wr_mask)
> > +{
> > +    uint64_t mask =3D wr_mask & MCTRCTL_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->mctrctl & MCTRCTL_MASK;
> >
> > There is no need to do bitwise and with the mask on read accesses when
> we always do bitwise and with the mask on write accesses.
> >
> > +    }
> > +
> > +    env->mctrctl =3D (env->mctrctl & ~mask) | (new_val & mask);
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException rmw_sctrctl(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong
> wr_mask)
> > +{
> > +    uint64_t mask =3D wr_mask & SCTRCTL_MASK;
> > +    RISCVException ret;
> > +
> > +    ret =3D rmw_mctrctl(env, csrno, ret_val, new_val, mask);
> >
> > When V=3D1, vsctrctl substitutes for sctrctl.
> >
> > +    if (ret_val) {
> > +        *ret_val &=3D SCTRCTL_MASK;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> > +                                     target_ulong *ret_val,
> > +                                     target_ulong new_val, target_ulon=
g
> wr_mask)
> > +{
> > +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK)=
;
> > +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->sctrstatus & SCTRSTATUS_MASK;
> >
> > There is no need to do bitwise and with the mask on read accesses when
> we always do bitwise and with the mask on write accesses.
> >
> > +    }
> > +
> > +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask);
> > +
> > +    /* Update sctrstatus.WRPTR with a legal value */
> > +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK |
> (depth - 1));
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException rmw_vsctrctl(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong
> wr_mask)
> > +{
> > +    uint64_t mask =3D wr_mask & VSCTRCTL_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->vsctrctl & VSCTRCTL_MASK;
> >
> > There is no need to do bitwise and with the mask on read accesses when
> we always do bitwise and with the mask on write accesses.
> >
> > +    }
> > +
> > +    env->vsctrctl =3D (env->vsctrctl & ~mask) | (new_val & mask);
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> >
> > Is it possible to define rmw_xctrctl() instead of three individual rmw
> functions and use a switch case to select the mask and the CSR for the
> purpose of reducing code size?
> >
> > +
> >  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
> >                                    target_ulong *val)
> >  {
> > @@ -5771,6 +5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
> >                           write_spmbase
>      },
> >
> > +    [CSR_MCTRCTL]       =3D { "mctrctl",       ctr_mmode, NULL, NULL,
> > +                                rmw_mctrctl },
> >
> > I think this can be one line.
> >
> > +    [CSR_SCTRCTL]       =3D { "sctrctl",       ctr_smode, NULL, NULL,
> > +                                rmw_sctrctl },
> >
> > same here
> >
> > +    [CSR_SCTRDEPTH]       =3D { "sctrdepth",       ctr_smode, NULL, NU=
LL,
> > +                                rmw_sctrdepth },
> >
> > same here
> >
> > +    [CSR_SCTRSTATUS]       =3D { "sctrstatus",       ctr_smode, NULL,
> NULL,
> > +                                rmw_sctrstatus },
> >
> > same here
> >
> > +    [CSR_VSCTRCTL]      =3D { "vsctrctl",      ctr_vsmode, NULL, NULL,
> > +                                rmw_vsctrctl },
> >
> > same here
> >
> >      /* Performance Counters */
> >      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmcount=
er
> },
> >      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmcount=
er
> },
>

--0000000000002fba00061aa8c56b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It makes sense. Thank you for the explanation.</div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Rajnesh Kanw=
al &lt;<a href=3D"mailto:rkanwal@rivosinc.com">rkanwal@rivosinc.com</a>&gt;=
 =E6=96=BC 2024=E5=B9=B46=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=
=E5=8D=8810:12=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><br>Thanks Jason for your review=
.<br><br>On Tue, Jun 4, 2024 at 11:14=E2=80=AFAM Jason Chien &lt;<a href=3D=
"mailto:jason.chien@sifive.com" target=3D"_blank">jason.chien@sifive.com</a=
>&gt; wrote:<br>&gt;<br>&gt;<br>&gt; Rajnesh Kanwal =E6=96=BC 2024/5/30 =E4=
=B8=8A=E5=8D=88 12:09 =E5=AF=AB=E9=81=93:<br>&gt;<br>&gt; This commit adds =
support for [m|s|vs]ctrcontrol, sctrstatus and<br>&gt; sctrdepth CSRs handl=
ing.<br>&gt;<br>&gt; Signed-off-by: Rajnesh Kanwal &lt;<a href=3D"mailto:rk=
anwal@rivosinc.com" target=3D"_blank">rkanwal@rivosinc.com</a>&gt;<br>&gt; =
---<br>&gt; =C2=A0target/riscv/cpu.h =C2=A0 =C2=A0 | =C2=A0 5 ++<br>&gt; =
=C2=A0target/riscv/cpu_cfg.h | =C2=A0 2 +<br>&gt; =C2=A0target/riscv/csr.c =
=C2=A0 =C2=A0 | 159 +++++++++++++++++++++++++++++++++++++++++<br>&gt; =C2=
=A03 files changed, 166 insertions(+)<br>&gt;<br>&gt; diff --git a/target/r=
iscv/cpu.h b/target/riscv/cpu.h<br>&gt; index a185e2d494..3d4d5172b8 100644=
<br>&gt; --- a/target/riscv/cpu.h<br>&gt; +++ b/target/riscv/cpu.h<br>&gt; =
@@ -263,6 +263,11 @@ struct CPUArchState {<br>&gt; =C2=A0 =C2=A0 =C2=A0targ=
et_ulong mcause;<br>&gt; =C2=A0 =C2=A0 =C2=A0target_ulong mtval; =C2=A0/* s=
ince: priv-1.10.0 */<br>&gt; =C2=A0<br>&gt; + =C2=A0 =C2=A0uint64_t mctrctl=
;<br>&gt; + =C2=A0 =C2=A0uint32_t sctrdepth;<br>&gt; + =C2=A0 =C2=A0uint32_=
t sctrstatus;<br>&gt; + =C2=A0 =C2=A0uint64_t vsctrctl;<br>&gt; +<br>&gt; =
=C2=A0 =C2=A0 =C2=A0/* Machine and Supervisor interrupt priorities */<br>&g=
t; =C2=A0 =C2=A0 =C2=A0uint8_t miprio[64];<br>&gt; =C2=A0 =C2=A0 =C2=A0uint=
8_t siprio[64];<br>&gt; diff --git a/target/riscv/cpu_cfg.h b/target/riscv/=
cpu_cfg.h<br>&gt; index d9354dc80a..d329a65811 100644<br>&gt; --- a/target/=
riscv/cpu_cfg.h<br>&gt; +++ b/target/riscv/cpu_cfg.h<br>&gt; @@ -123,6 +123=
,8 @@ struct RISCVCPUConfig {<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_zvfhmin;=
<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_smaia;<br>&gt; =C2=A0 =C2=A0 =C2=A0bo=
ol ext_ssaia;<br>&gt; + =C2=A0 =C2=A0bool ext_smctr;<br>&gt; + =C2=A0 =C2=
=A0bool ext_ssctr;<br>&gt; =C2=A0 =C2=A0 =C2=A0bool ext_sscofpmf;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0bool ext_smepmp;<br>&gt; =C2=A0 =C2=A0 =C2=A0bool rvv_t=
a_all_1s;<br>&gt; diff --git a/target/riscv/csr.c b/target/riscv/csr.c<br>&=
gt; index 2f92e4b717..888084d8e5 100644<br>&gt; --- a/target/riscv/csr.c<br=
>&gt; +++ b/target/riscv/csr.c<br>&gt; @@ -621,6 +621,61 @@ static RISCVExc=
eption pointer_masking(CPURISCVState *env, int csrno)<br>&gt; =C2=A0 =C2=A0=
 =C2=A0return RISCV_EXCP_ILLEGAL_INST;<br>&gt; =C2=A0}<br>&gt; =C2=A0<br>&g=
t; +/*<br>&gt; + * M-mode:<br>&gt; + * Without ext_smctr raise illegal inst=
 excep.<br>&gt; + * Otherwise everything is accessible to m-mode.<br>&gt; +=
 *<br>&gt; + * S-mode:<br>&gt; + * Without ext_ssctr or mstateen.ctr raise =
illegal inst excep.<br>&gt; + * Otherwise everything other than mctrctl is =
accessible.<br>&gt; + *<br>&gt; + * VS-mode:<br>&gt; + * Without ext_ssctr =
or mstateen.ctr raise illegal inst excep.<br>&gt; + * Without hstateen.ctr =
raise virtual illegal inst excep.<br>&gt; + * Otherwise allow vsctrctl, sct=
rstatus, 0x200-0x2ff entry range.<br>&gt; + * Always raise illegal instruct=
ion exception for sctrdepth.<br>&gt; + */<br>&gt; +static RISCVException ct=
r_mmode(CPURISCVState *env, int csrno)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0/*=
 Check if smctr-ext is present */<br>&gt; + =C2=A0 =C2=A0if (riscv_cpu_cfg(=
env)-&gt;ext_smctr) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXC=
P_NONE;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RI=
SCV_EXCP_ILLEGAL_INST;<br>&gt; +}<br>&gt; +<br>&gt; +static RISCVException =
ctr_smode(CPURISCVState *env, int csrno)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0=
if ((env-&gt;priv =3D=3D PRV_M &amp;&amp; riscv_cpu_cfg(env)-&gt;ext_smctr)=
 ||<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0(env-&gt;priv =3D=3D PRV_S &amp;&a=
mp; !env-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
riscv_cpu_cfg(env)-&gt;ext_ssctr)) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt; + =C2=A0 =C2=A0}<br=
>&gt; +<br>&gt; + =C2=A0 =C2=A0if (env-&gt;priv =3D=3D PRV_S &amp;&amp; env=
-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_cpu=
_cfg(env)-&gt;ext_ssctr) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (csrno =
=3D=3D CSR_SCTRSTATUS) {<br>&gt;<br>&gt; missing sctrctl?<br>&gt;<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return smstateen_acc_ok(env, 0, S=
MSTATEEN0_CTR);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>&gt=
; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_ILLEG=
AL_INST;<br>&gt; +}<br>&gt;<br>&gt; I think there is no need to bind M-mode=
 with ext_smctr, S-mode with ext_ssctr and VS-mode with ext_ssctr, since th=
is predicate function is for S-mode CSRs, which are defined in both smctr a=
nd ssctr, we just need to check at least one of ext_ssctr or ext_smctr is t=
rue.<br>&gt;<br>&gt; The spec states that:<br>&gt; Attempts to access sctrd=
epth from VS-mode or VU-mode raise a virtual-instruction exception, unless =
CTR state enable access restrictions apply.<br>&gt;<br>&gt; In my understan=
ding, we should check the presence of smstateen extension first, and<br>&gt=
;<br>&gt; if smstateen is implemented:<br>&gt;<br>&gt; for sctrctl and sctr=
status, call smstateen_acc_ok()<br>&gt; for sctrdepth, call smstateen_acc_o=
k(), and if there is any exception returned, always report virtual-instruct=
ion exception.<br><br>For sctrdepth, we are supposed to always return a vir=
t-inst exception in case of<br>VS-VU mode unless CTR state enable access re=
strictions apply.<br><br>So for sctrdepth, call smstateen_acc_ok(), and if =
there is no exception returned<br>(mstateen.CTR=3D1 and hstateen.CTR=3D1 fo=
r virt mode), check if we are in virtual<br><div>mode and return virtual-in=
struction exception otherwise return RISCV_EXCP_NONE.</div><div>Note that i=
f hstateen.CTR=3D0, smstateen_acc_ok() will return virtual-instruction</div=
><div>exception which means regardless of the hstateen.CTR state, we will a=
lways</div><div>return virtual-instruction exception for VS/VU mode access =
to sctrdepth.<br></div><br>Basically this covers following rules for sctrde=
pth:<br><br>if mstateen.ctr =3D=3D 0<br>=C2=A0 =C2=A0 return RISCV_EXCP_ILL=
EGAL_INST; // For all modes lower than M-mode.<br>else if in virt-mode // r=
egardless of the state of hstateen.CTR<br>=C2=A0 =C2=A0 return RISCV_EXCP_V=
IRT_INSTRUCTION_FAULT;<br>else<br>=C2=A0 =C2=A0 return RISCV_EXCP_NONE<br><=
br>&gt;<br>&gt; If smstateen is not implemented:<br>&gt;<br>&gt; for sctrct=
l and sctrstatus, there is no check.<br>&gt; for sctrdepth, I think the spe=
c is ambiguous. What does &quot;CTR state enable access restrictions apply&=
quot; mean when smstateen is not implemented?<br><br>As per my understandin=
g, this means if mstateen.CTR=3D0 then we return an<br>illegal instruction =
exception regardless if it&#39;s virtual mode or not. This is<br>the only e=
ffect of CTR state enable on sctrdepth CSR. If mstateen.CTR=3D1,<br>sctrdep=
th access from VS-mode results in virtual-instruction exception<br>regardle=
ss of hstateen.CTR.<br><br>Based on this, we have following model for predi=
cate checks:<br><br>if smstateen is implemented:<br><br>for sctrctl and sct=
rstatus, call smstateen_acc_ok()<br>for sctrdepth, call smstateen_acc_ok(),=
 and if there is no exception,<br>=C2=A0 =C2=A0 check if we are in virtual =
mode and return virtual-instruction exception<br>=C2=A0 =C2=A0 otherwise re=
turn RISCV_EXCP_NONE.<br><br>If smstateen is not implemented:<br><br>for sc=
trctl and sctrstatus, there is no check.<br>for sctrdepth, if in VS/VU mode=
 return virtual-instruction exception otherwise<br>=C2=A0 =C2=A0 no check.<=
br><br>Here is the code to better understand this.<br><br>static RISCVExcep=
tion ctr_smode(CPURISCVState *env, int csrno)<br>{<br>=C2=A0 =C2=A0 const R=
ISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<br><br>=C2=A0 =C2=A0 if (!cfg-&g=
t;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return RISCV_EXCP_ILLEGAL_INST;<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 if=
 (riscv_cpu_cfg(env)-&gt;ext_smstateen) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RI=
SCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D RISCV_EXCP_NONE &amp;&amp; csrno =3D=3D=
 CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>=C2=A0=
 =C2=A0 } else {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrno =3D=3D CSR_SCTRDE=
PTH &amp;&amp; env-&gt;virt_enabled) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 return RISCV_EXCP_NONE=
;<br>}<br><br>Given smstateen_acc_ok() returns RISCV_EXCP_NONE in case if e=
xt_smstateen is not<br>implemented, this can be further simplified to:<br><=
br>static RISCVException ctr_smode(CPURISCVState *env, int csrno)<br>{<br>=
=C2=A0 =C2=A0 const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<br><br>=C2=
=A0 =C2=A0 if (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>=C2=A0 =C2=A0 }=
<br><br>=C2=A0 =C2=A0 RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTA=
TEEN0_CTR);<br>=C2=A0 =C2=A0 if (ret =3D=3D RISCV_EXCP_NONE &amp;&amp; csrn=
o =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;<br>=C2=A0 =C2=A0 }<=
br>=C2=A0 =C2=A0 return ret;<br>}<br><br>&gt;<br>&gt; Here is the code to b=
etter understand my description.<br>&gt;<br>&gt; static RISCVException ctr_=
smode(CPURISCVState *env, int csrno)<br>&gt; {<br>&gt; =C2=A0 =C2=A0 const =
RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);<br>&gt;<br>&gt; =C2=A0 =C2=A0 i=
f (!cfg-&gt;ext_ssctr &amp;&amp; !cfg-&gt;ext_smctr) {<br>&gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 return RISCV_EXCP_ILLEGAL_INST;<br>&gt; =C2=A0 =C2=A0 }<b=
r>&gt;<br>&gt; =C2=A0 =C2=A0 if (riscv_cpu_cfg(env)-&gt;ext_smstateen) {<br=
>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCVException ret =3D smstateen_acc_ok(e=
nv, 0, SMSTATEEN0_CTR);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret !=3D RI=
SCV_EXCP_NONE) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (csrn=
o =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) {<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_INS=
TRUCTION_FAULT;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt;=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=A0 } else {<br>&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* The spec is ambiguous. */<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (csrno =3D=3D CSR_SCTRDEPTH &amp;&amp; env-&gt;virt_enabled) =
{<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return RISCV_EXCP_VIRT_=
INSTRUCTION_FAULT;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =C2=
=A0 }<br>&gt;<br>&gt; =C2=A0 =C2=A0 return RISCV_EXCP_NONE;<br>&gt; }<br>&g=
t;<br>&gt; +<br>&gt; +static RISCVException ctr_vsmode(CPURISCVState *env, =
int csrno)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0if (env-&gt;priv =3D=3D PRV_S =
&amp;&amp; env-&gt;virt_enabled &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0riscv_cpu_cfg(env)-&gt;ext_ssctr) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);<br>&gt;<br>&gt; In r=
iscv_csrrw_check(), an virtual-instruction exception is always reported no =
matter what. Do we need this check?<br>&gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt=
; +<br>&gt; + =C2=A0 =C2=A0return ctr_smode(env, csrno);<br>&gt; +}<br>&gt;=
 +<br>&gt; =C2=A0static RISCVException aia_hmode(CPURISCVState *env, int cs=
rno)<br>&gt; =C2=A0{<br>&gt; =C2=A0 =C2=A0 =C2=A0int ret;<br>&gt; @@ -3835,=
6 +3890,100 @@ static RISCVException write_satp(CPURISCVState *env, int csr=
no,<br>&gt; =C2=A0 =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; =C2=A0}<br>=
&gt; =C2=A0<br>&gt; +static RISCVException rmw_sctrdepth(CPURISCVState *env=
, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ta=
rget_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0target_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br>&gt; + =
=C2=A0 =C2=A0uint64_t mask =3D wr_mask &amp; SCTRDEPTH_MASK;<br>&gt; +<br>&=
gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret=
_val =3D env-&gt;sctrdepth &amp; SCTRDEPTH_MASK;<br>&gt;<br>&gt; We don&#39=
;t need to do bitwise and with SCTRDEPTH_MASK on read accesses when we alwa=
ys do bitwise and with SCTRDEPTH_MASK on write accesses.<br>&gt;<br>&gt; + =
=C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-&gt;sctrdepth =3D (env-=
&gt;sctrdepth &amp; ~mask) | (new_val &amp; mask);<br>&gt; +<br>&gt; + =C2=
=A0 =C2=A0/* Correct depth. */<br>&gt; + =C2=A0 =C2=A0if (wr_mask &amp; SCT=
RDEPTH_MASK) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t depth =3D get_=
field(env-&gt;sctrdepth, SCTRDEPTH_MASK);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (depth &gt; SCTRDEPTH_MAX) {<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrdepth =3D<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_field(env-&gt;sctrdepth, SCTRDEPT=
H_MASK, SCTRDEPTH_MAX);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; +<br=
>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Update sctrstatus.WRPTR with a legal =
value */<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0depth =3D 16 &lt;&lt; depth;<=
br>&gt;<br>&gt; The &quot;depth&quot; on the right side may exceed SCTRDEPT=
H_MAX.<br>&gt;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrstatus =3D<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;sctrstatus &amp;=
 (~SCTRSTATUS_WRPTR_MASK | (depth - 1));<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +=
<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; +}<br>&gt; +<br>&gt=
; +static RISCVException rmw_mctrctl(CPURISCVState *env, int csrno,<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong *ret_va=
l,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong=
 new_val, target_ulong wr_mask)<br>&gt; +{<br>&gt; + =C2=A0 =C2=A0uint64_t =
mask =3D wr_mask &amp; MCTRCTL_MASK;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (r=
et_val) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val =3D env-&gt;mctrctl=
 &amp; MCTRCTL_MASK;<br>&gt;<br>&gt; There is no need to do bitwise and wit=
h the mask on read accesses when we always do bitwise and with the mask on =
write accesses.<br>&gt;<br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0=
 =C2=A0env-&gt;mctrctl =3D (env-&gt;mctrctl &amp; ~mask) | (new_val &amp; m=
ask);<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; +}<b=
r>&gt; +<br>&gt; +static RISCVException rmw_sctrctl(CPURISCVState *env, int=
 csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=
_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0target_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br>&gt; + =C2=A0 =
=C2=A0uint64_t mask =3D wr_mask &amp; SCTRCTL_MASK;<br>&gt; + =C2=A0 =C2=A0=
RISCVException ret;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0ret =3D rmw_mctrctl(en=
v, csrno, ret_val, new_val, mask);<br>&gt;<br>&gt; When V=3D1, vsctrctl sub=
stitutes for sctrctl.<br>&gt;<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0*ret_val &amp;=3D SCTRCTL_MASK;<br>&gt; + =C2=
=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return ret;<br>&gt; +}<br>&gt;=
 +<br>&gt; +static RISCVException rmw_sctrstatus(CPURISCVState *env, int cs=
rno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_u=
long *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 target_ulong new_val, target_ulong wr_mask)<br>&gt; +{<br>&gt; + =C2=A0=
 =C2=A0uint32_t depth =3D 16 &lt;&lt; get_field(env-&gt;sctrdepth, SCTRDEPT=
H_MASK);<br>&gt; + =C2=A0 =C2=A0uint32_t mask =3D wr_mask &amp; SCTRSTATUS_=
MASK;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*ret_val =3D env-&gt;sctrstatus &amp; SCTRSTATUS_MASK;<br>=
&gt;<br>&gt; There is no need to do bitwise and with the mask on read acces=
ses when we always do bitwise and with the mask on write accesses.<br>&gt;<=
br>&gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-&gt;sctrstatu=
s =3D (env-&gt;sctrstatus &amp; ~mask) | (new_val &amp; mask);<br>&gt; +<br=
>&gt; + =C2=A0 =C2=A0/* Update sctrstatus.WRPTR with a legal value */<br>&g=
t; + =C2=A0 =C2=A0env-&gt;sctrstatus =3D env-&gt;sctrstatus &amp; (~SCTRSTA=
TUS_WRPTR_MASK | (depth - 1));<br>&gt; +<br>&gt; + =C2=A0 =C2=A0return RISC=
V_EXCP_NONE;<br>&gt; +}<br>&gt; +<br>&gt; +static RISCVException rmw_vsctrc=
tl(CPURISCVState *env, int csrno,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0target_ulong *ret_val,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong new_val, target_ulong wr_mask)<=
br>&gt; +{<br>&gt; + =C2=A0 =C2=A0uint64_t mask =3D wr_mask &amp; VSCTRCTL_=
MASK;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0if (ret_val) {<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*ret_val =3D env-&gt;vsctrctl &amp; VSCTRCTL_MASK;<br>&gt;=
<br>&gt; There is no need to do bitwise and with the mask on read accesses =
when we always do bitwise and with the mask on write accesses.<br>&gt;<br>&=
gt; + =C2=A0 =C2=A0}<br>&gt; +<br>&gt; + =C2=A0 =C2=A0env-&gt;vsctrctl =3D =
(env-&gt;vsctrctl &amp; ~mask) | (new_val &amp; mask);<br>&gt; +<br>&gt; + =
=C2=A0 =C2=A0return RISCV_EXCP_NONE;<br>&gt; +}<br>&gt;<br>&gt; Is it possi=
ble to define rmw_xctrctl() instead of three individual rmw functions and u=
se a switch case to select the mask and the CSR for the purpose of reducing=
 code size?<br>&gt;<br>&gt; +<br>&gt; =C2=A0static RISCVException read_vsto=
pi(CPURISCVState *env, int csrno,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0target_ulong *val)<br>&gt; =C2=A0{<br>&gt; @@ -5771,6 +=
5920,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {<br>&gt; =C2=
=A0 =C2=A0 =C2=A0[CSR_SPMBASE] =3D =C2=A0 =C2=A0{ &quot;spmbase&quot;, poin=
ter_masking, read_spmbase,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_spmbase =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>&gt; =C2=A0<br>&g=
t; + =C2=A0 =C2=A0[CSR_MCTRCTL] =C2=A0 =C2=A0 =C2=A0 =3D { &quot;mctrctl&qu=
ot;, =C2=A0 =C2=A0 =C2=A0 ctr_mmode, NULL, NULL,<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0rmw_mctrctl },<br>&gt;<br>&gt; I think this can be =
one line.<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRCTL] =C2=A0 =C2=A0 =C2=A0=
 =3D { &quot;sctrctl&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_smode, NULL, NULL,<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrctl },<br>&gt;<br>&gt;=
 same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRDEPTH] =C2=A0 =C2=A0 =C2=
=A0 =3D { &quot;sctrdepth&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_smode, NULL, NULL=
,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrdepth },<br>&gt;<br=
>&gt; same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_SCTRSTATUS] =C2=A0 =C2=
=A0 =C2=A0 =3D { &quot;sctrstatus&quot;, =C2=A0 =C2=A0 =C2=A0 ctr_smode, NU=
LL, NULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_sctrstatus },<b=
r>&gt;<br>&gt; same here<br>&gt;<br>&gt; + =C2=A0 =C2=A0[CSR_VSCTRCTL] =C2=
=A0 =C2=A0 =C2=A0=3D { &quot;vsctrctl&quot;, =C2=A0 =C2=A0 =C2=A0ctr_vsmode=
, NULL, NULL,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmw_vsctrctl =
},<br>&gt;<br>&gt; same here<br>&gt;<br>&gt; =C2=A0 =C2=A0 =C2=A0/* Perform=
ance Counters */<br>&gt; =C2=A0 =C2=A0 =C2=A0[CSR_HPMCOUNTER3] =C2=A0 =C2=
=A0=3D { &quot;hpmcounter3&quot;, =C2=A0 =C2=A0ctr, =C2=A0 =C2=A0read_hpmco=
unter },<br>&gt; =C2=A0 =C2=A0 =C2=A0[CSR_HPMCOUNTER4] =C2=A0 =C2=A0=3D { &=
quot;hpmcounter4&quot;, =C2=A0 =C2=A0ctr, =C2=A0 =C2=A0read_hpmcounter },</=
div>
</blockquote></div>

--0000000000002fba00061aa8c56b--

