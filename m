Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3F3D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OX0-0000Em-2T; Thu, 17 Oct 2024 07:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t1OWx-0000DF-7f
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:18:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t1OWu-0003rz-UB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:18:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so548940f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729163934; x=1729768734;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwQGeKGdc9B5gHSGirsmxRp2PmCgVDi1PT7o+t/SJz0=;
 b=pMXOcWA0yjShuajdk4u7Jz05rB6MPLgVXco+CmFl1j6bDG65KRWajiei6ZjMEbTexZ
 NB13amuwXHwV4Vx+szp4VvvaGXBWDo5XYZXgC+V28HCUYz0C+yIRjiM2ruVN1y7cx9mK
 3/0apnnFljhRNvJNiYpZlCjBDBHjiFI0g/qs/XawKcrclkNogpYhwJ5btwsZcJ5s7GQx
 Zb8BbFZq7hYVMZF74bJ4OD0ezwREsOpVuEyDnJ6lKoJvjnufD8mUzQHznwBTyQJCNlam
 PuReXyUzDDlCDkndm8J9ZEEnGVbWFVKJN5uzV/Qlx709TyzTRpuPsm2IpDTw6PGrjSPH
 wuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729163934; x=1729768734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwQGeKGdc9B5gHSGirsmxRp2PmCgVDi1PT7o+t/SJz0=;
 b=PaDCtjNf9Z/apvBn2tTKuqjY5UB01+sVebUy13c1x85y9YxxAoSxdly3eEDMJo0m89
 0xnvfalAWSJMYTXHl2J1dTutKZM0jaCSxOZL54JqSkd6MbLEdv5eqWMhYXuLKng/7cZ8
 uDEEOPSSfJssukhc1r0pppyYNz0TvH5NDX7T7y9KFEOhybaZzGgZsV1rbFOcGA+zXnHV
 2FEj1RAr4so1ni/8R2djTeWAWsRlKmYrvA8Ye6FdKSP6+6KaNvYLJa4ZvIEwu63Pxp4C
 KkHRHgs8gja4IpG2hysyseiXrRWCvRxNWfOKHoSoH4ogBIPFoIRTTyZmnlVN4LE+Wxa9
 vSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ZknYrbJ497SSlmAhkEgNrVvtEHuwrAmZojh4uaeaQjkLcSip+/0vYGfZ8Dk5th/gM/MSyDGz9Zr7@nongnu.org
X-Gm-Message-State: AOJu0Yx0Xuf+NO1lGpL25HCy4a8SgtwDgqZJ1Y91IW+sTq4VfhfBjq0S
 kcA8qAlPnyvLftAskZW2bq0aGgvbPs4ytoESpmmjr+DFhjMYoRqGaQzgjMr1i9nj5Yd/dg9PA4g
 m82WDfhRXHMCY0RNRU2OUULXZ/wC/mB6Haz30YA==
X-Google-Smtp-Source: AGHT+IEwWY4RDJobWM7wH8c8/cBqZTzfGOrjf1XRhgOhd/C8ngat2KJaU0bmhojWWyOqGYeocWW8FLdPV/nKJdqdC9w=
X-Received: by 2002:a5d:5590:0:b0:37d:4cef:538b with SMTP id
 ffacd0b85a97d-37d86c02a86mr4601798f8f.26.1729163933985; Thu, 17 Oct 2024
 04:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-4-rkanwal@rivosinc.com>
 <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
In-Reply-To: <CANzO1D33XPxXAJ8kxBz0oa1R8pb5et3BQV5EELiEvdhSjj3S1Q@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Thu, 17 Oct 2024 12:18:43 +0100
Message-ID: <CAECbVCuQ-tWFrskOZ3FcG+nziamTb8fHV8iA5VOUfhFa4AvAMA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/riscv: Add support for Control Transfer
 Records extension CSRs.
To: Frank Chang <frank.chang@sifive.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org, 
 jason.chien@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 27, 2024 at 10:28=E2=80=AFAM Frank Chang <frank.chang@sifive.co=
m> wrote:
>
> Rajnesh Kanwal <rkanwal@rivosinc.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=8819=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
> > sctrdepth CSRs handling.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  target/riscv/cpu.h     |   5 ++
> >  target/riscv/cpu_cfg.h |   2 +
> >  target/riscv/csr.c     | 128 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 135 insertions(+)
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
>
> Base on: https://github.com/riscv/riscv-control-transfer-records/pull/29
> Smctr and Ssctr depend on both S-mode and Sscsrind.
> We should add the implied rules for Smctr and Ssctr.
>
> Regards,
> Frank Chang

Hi Frank,

Are you referring to the checks in riscv_cpu_validate_set_extensions()?
These checks are already present in the last patch.

https://lore.kernel.org/qemu-riscv/20240619152708.135991-7-rkanwal@rivosinc=
.com/


>
>
> >      bool ext_sscofpmf;
> >      bool ext_smepmp;
> >      bool rvv_ta_all_1s;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 2f92e4b717..0b5bf4d050 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -621,6 +621,48 @@ static RISCVException pointer_masking(CPURISCVStat=
e *env, int csrno)
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
> > + * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entry r=
ange.
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
> > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > +
> > +    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    RISCVException ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
> > +    if (ret =3D=3D RISCV_EXCP_NONE && csrno =3D=3D CSR_SCTRDEPTH &&
> > +        env->virt_enabled) {
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  static RISCVException aia_hmode(CPURISCVState *env, int csrno)
> >  {
> >      int ret;
> > @@ -3835,6 +3877,86 @@ static RISCVException write_satp(CPURISCVState *=
env, int csrno,
> >      return RISCV_EXCP_NONE;
> >  }
> >
> > +static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong=
 wr_mask)
> > +{
> > +    uint64_t mask =3D wr_mask & SCTRDEPTH_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->sctrdepth;
> > +    }
> > +
> > +    env->sctrdepth =3D (env->sctrdepth & ~mask) | (new_val & mask);
> > +
> > +    /* Correct depth. */
> > +    if (wr_mask & SCTRDEPTH_MASK) {
> > +        uint64_t depth =3D get_field(env->sctrdepth, SCTRDEPTH_MASK);
> > +
> > +        if (depth > SCTRDEPTH_MAX) {
> > +            depth =3D SCTRDEPTH_MAX;
> > +            env->sctrdepth =3D set_field(env->sctrdepth, SCTRDEPTH_MAS=
K, depth);
> > +        }
> > +
> > +        /* Update sctrstatus.WRPTR with a legal value */
> > +        depth =3D 16 << depth;
> > +        env->sctrstatus =3D
> > +            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
> > +    }
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
> > +                                     target_ulong *ret_val,
> > +                                     target_ulong new_val, target_ulon=
g wr_mask)
> > +{
> > +    uint32_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK)=
;
> > +    uint32_t mask =3D wr_mask & SCTRSTATUS_MASK;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D env->sctrstatus;
> > +    }
> > +
> > +    env->sctrstatus =3D (env->sctrstatus & ~mask) | (new_val & mask);
> > +
> > +    /* Update sctrstatus.WRPTR with a legal value */
> > +    env->sctrstatus =3D env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (d=
epth - 1));
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
> > +                                    target_ulong *ret_val,
> > +                                    target_ulong new_val, target_ulong=
 wr_mask)
> > +{
> > +    uint64_t csr_mask, mask =3D wr_mask;
> > +    uint64_t *ctl_ptr =3D &env->mctrctl;
> > +
> > +    if (csrno =3D=3D CSR_MCTRCTL) {
> > +        csr_mask =3D MCTRCTL_MASK;
> > +    } else if (csrno =3D=3D CSR_SCTRCTL && !env->virt_enabled) {
> > +        csr_mask =3D SCTRCTL_MASK;
> > +    } else {
> > +        /*
> > +         * This is for csrno =3D=3D CSR_SCTRCTL and env->virt_enabled =
=3D=3D true
> > +         * or csrno =3D=3D CSR_VSCTRCTL.
> > +         */
> > +        csr_mask =3D VSCTRCTL_MASK;
> > +        ctl_ptr =3D &env->vsctrctl;
> > +    }
> > +
> > +    mask &=3D csr_mask;
> > +
> > +    if (ret_val) {
> > +        *ret_val =3D *ctl_ptr & csr_mask;
> > +    }
> > +
> > +    *ctl_ptr =3D (*ctl_ptr & ~mask) | (new_val & mask);
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >  static RISCVException read_vstopi(CPURISCVState *env, int csrno,
> >                                    target_ulong *val)
> >  {
> > @@ -5771,6 +5893,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >      [CSR_SPMBASE] =3D    { "spmbase", pointer_masking, read_spmbase,
> >                           write_spmbase                                =
      },
> >
> > +    [CSR_MCTRCTL]    =3D { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_x=
ctrctl },
> > +    [CSR_SCTRCTL]    =3D { "sctrctl",    ctr_smode,  NULL, NULL, rmw_x=
ctrctl },
> > +    [CSR_VSCTRCTL]   =3D { "vsctrctl",   ctr_smode,  NULL, NULL, rmw_x=
ctrctl },
> > +    [CSR_SCTRDEPTH]  =3D { "sctrdepth",  ctr_smode,  NULL, NULL, rmw_s=
ctrdepth },
> > +    [CSR_SCTRSTATUS] =3D { "sctrstatus", ctr_smode,  NULL, NULL, rmw_s=
ctrstatus },
> > +
> >      /* Performance Counters */
> >      [CSR_HPMCOUNTER3]    =3D { "hpmcounter3",    ctr,    read_hpmcount=
er },
> >      [CSR_HPMCOUNTER4]    =3D { "hpmcounter4",    ctr,    read_hpmcount=
er },
> > --
> > 2.34.1
> >
> >

