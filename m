Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AFFE69E97
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDm9-0005aj-9u; Mon, 02 Dec 2024 16:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIDm7-0005a4-3v
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:16:11 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIDm3-00082a-Lt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:16:10 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7253bc4d25eso3173135b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733174165; x=1733778965;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Qxuv04uUCGi1okB3n+An/wyyKZuAfyD3LlgGXcUHm8=;
 b=OmgJqG+r4ObN10afqB2RAHbm7WKzvhcxLfFw2+nZ5CJvl0+qMuygS0tuJxg6yxFXO7
 SyJglJZfgkjOZTi/asEc9Q7zxdIqO7NwDQKGxosB9UE4+Udbz99Xks/HUrm5cY5VcTg5
 BIau5MIfifkHBlUFfHqv0Pro2WEs5RbLFg0hJchgCb6YqiZn73DSL8M6yacDZdihWPwo
 tC6Of0xDlpKdQqkdb3tBW7r6uyQsDjnM6924jy66D2eltiRwfW3H5hZZpFW8oDwfQyRA
 wXsCG/houtxzJqv8dcvEvR9sapGD8uHjRJI24+i+3BcuGPByENWSlkhYYG7ToowaC05x
 phqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733174165; x=1733778965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Qxuv04uUCGi1okB3n+An/wyyKZuAfyD3LlgGXcUHm8=;
 b=Thbs8k2DgTXg53Sgl24xHLDR0M5l50uxsQV4LrIoG5KyDwMphIowAEPJZqXqtMXzva
 xptQSVMzh1dBvyfcZqLdOYCqws+Md0HU0FhmmHAljjRNR/15vhGNiETWYdhelQWWf+Wy
 DMM8toV9Gk8zfIcGDecqqyMCuTKv8BEYqH3LRTRaG/50Ru7VNYRIsGvnRm38OJ4su4dO
 Hw3o5BBybd2ywbDESYQQD7kfuYLHTshgn88dvo7RnEFuVG7gfwKFPcwil3zkXB/RjHFA
 b78mTD35tr1puMshAMQydwM/H3ssD34sUcup6lpDNd326CWGK0fYLod/F+GpepZm45aU
 wDNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAB78b7oHzwGBy1JK1Mq3e8hfvsGvaX4uhrMQc4B/e/BI5PAex5XYVhp54Txps3Sl4XO/upouOd3Gv@nongnu.org
X-Gm-Message-State: AOJu0YzLPzeSZzfXu57Cccp88BwAHQ1jAw1etQS8rhyBECG4ZJz8u2SI
 WczMCtAgSHcOPRS4HOwD0ils0c6hdpGkET51PGq53qXRgP1OfkCZtR1L5NLPr+pxiLkBREKOAHh
 c5JMGHp0vFn+5tsxM+vlhIFSR2GlM6bkgj/MnFg==
X-Gm-Gg: ASbGnct3d4QHwWRDhMDDrucD4VizSnWLH1bvkuqujovZ4Q4eOfNH8HVRlk0zwXC+pLj
 qwhta6ngo75zvc8wLP4aNxAtvoGxlug==
X-Google-Smtp-Source: AGHT+IHgqiJF2Ur+214fHm96GmxAhjFiUAwzKlK8suROMVlP8kdvHAke00ft0CgonyoCQj2vqhAdrBy2HDHTN8ECqK8=
X-Received: by 2002:a05:6a00:22d3:b0:724:ea71:a53d with SMTP id
 d2e1a72fcca58-7253f3b2c81mr29195804b3a.9.1733174165177; Mon, 02 Dec 2024
 13:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-8-476d6f36e3c8@rivosinc.com>
 <ac472499-b9af-4e40-8796-fdea9ef2b69c@ventanamicro.com>
In-Reply-To: <ac472499-b9af-4e40-8796-fdea9ef2b69c@ventanamicro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 2 Dec 2024 13:15:54 -0800
Message-ID: <CAHBxVyF4A8byvg51SgjF_XhUp7TDsc0ZVYm3u+y9M3oN_EN06Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] target/riscv: Add counter
 delegation/configuration support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x434.google.com
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

On Thu, Nov 28, 2024 at 4:53=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 11/17/24 10:15 PM, Atish Patra wrote:
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > The Smcdeleg/Ssccfg adds the support for counter delegation via
> > S*indcsr and Ssccfg.
> >
> > It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE=
)
> > to enable this extension and scountovf virtualization.
> >
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   target/riscv/csr.c | 300 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++--
> >   1 file changed, 289 insertions(+), 11 deletions(-)
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 97cc8059ad37..31ea8b8ec20d 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -385,6 +385,21 @@ static RISCVException aia_smode32(CPURISCVState *e=
nv, int csrno)
> >       return smode32(env, csrno);
> >   }
> >
> > +static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno=
)
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
> > +
> > +    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    if (env->virt_enabled) {
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> > +    return smode(env, csrno);
> > +}
> > +
> >   static bool csrind_extensions_present(CPURISCVState *env)
> >   {
> >       return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ex=
t_sscsrind;
> > @@ -1222,10 +1237,9 @@ done:
> >       return result;
> >   }
> >
> > -static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> > -                                        target_ulong val)
> > +static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_u=
long val,
> > +                                          uint32_t ctr_idx)
> >   {
> > -    int ctr_idx =3D csrno - CSR_MCYCLE;
> >       PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> >       uint64_t mhpmctr_val =3D val;
> >
> > @@ -1250,10 +1264,9 @@ static RISCVException write_mhpmcounter(CPURISCV=
State *env, int csrno,
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > -static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno=
,
> > -                                         target_ulong val)
> > +static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_=
ulong val,
> > +                                          uint32_t ctr_idx)
> >   {
> > -    int ctr_idx =3D csrno - CSR_MCYCLEH;
> >       PMUCTRState *counter =3D &env->pmu_ctrs[ctr_idx];
> >       uint64_t mhpmctr_val =3D counter->mhpmcounter_val;
> >       uint64_t mhpmctrh_val =3D val;
> > @@ -1275,6 +1288,20 @@ static RISCVException write_mhpmcounterh(CPURISC=
VState *env, int csrno,
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulo=
ng val)
> > +{
> > +    int ctr_idx =3D csrno - CSR_MCYCLE;
> > +
> > +    return riscv_pmu_write_ctr(env, val, ctr_idx);
> > +}
> > +
> > +static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ul=
ong val)
> > +{
> > +    int ctr_idx =3D csrno - CSR_MCYCLEH;
> > +
> > +    return riscv_pmu_write_ctrh(env, val, ctr_idx);
> > +}
> > +
> >   RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *v=
al,
> >                                            bool upper_half, uint32_t ct=
r_idx)
> >   {
> > @@ -1340,6 +1367,167 @@ static RISCVException read_hpmcounterh(CPURISCV=
State *env, int csrno,
> >       return riscv_pmu_read_ctr(env, val, true, ctr_index);
> >   }
> >
> > +static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
> > +                              target_ulong *val, target_ulong new_val,
> > +                              target_ulong wr_mask)
> > +{
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        riscv_pmu_read_ctr(env, val, false, ctr_idx);
> > +    } else if (wr_mask) {
> > +        riscv_pmu_write_ctr(env, new_val, ctr_idx);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
> > +                               target_ulong *val, target_ulong new_val=
,
> > +                               target_ulong wr_mask)
> > +{
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        riscv_pmu_read_ctr(env, val, true, ctr_idx);
> > +    } else if (wr_mask) {
> > +        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
> > +                            target_ulong *val, target_ulong new_val,
> > +                            target_ulong wr_mask)
> > +{
> > +    uint64_t mhpmevt_val =3D new_val;
> > +
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        *val =3D env->mhpmevent_val[evt_index];
> > +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> > +            *val &=3D ~MHPMEVENT_BIT_MINH;
> > +        }
> > +    } else if (wr_mask) {
> > +        wr_mask &=3D ~MHPMEVENT_BIT_MINH;
> > +        mhpmevt_val =3D (new_val & wr_mask) |
> > +                      (env->mhpmevent_val[evt_index] & ~wr_mask);
> > +        if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > +            mhpmevt_val =3D mhpmevt_val |
> > +                          ((uint64_t)env->mhpmeventh_val[evt_index] <<=
 32);
> > +        }
> > +        env->mhpmevent_val[evt_index] =3D mhpmevt_val;
> > +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
> > +                             target_ulong *val, target_ulong new_val,
> > +                             target_ulong wr_mask)
> > +{
> > +    uint64_t mhpmevth_val;
> > +    uint64_t mhpmevt_val =3D env->mhpmevent_val[evt_index];
> > +
> > +    if (wr_mask !=3D 0 && wr_mask !=3D -1) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!wr_mask && val) {
> > +        *val =3D env->mhpmeventh_val[evt_index];
> > +        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
> > +            *val &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +    } else if (wr_mask) {
> > +        wr_mask &=3D ~MHPMEVENTH_BIT_MINH;
> > +        env->mhpmeventh_val[evt_index] =3D
> > +            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~w=
r_mask);
> > +        mhpmevth_val =3D env->mhpmeventh_val[evt_index];
> > +        mhpmevt_val =3D mhpmevt_val | (mhpmevth_val << 32);
> > +        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
> > +    } else {
> > +        return -EINVAL;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ul=
ong *val,
> > +                            target_ulong new_val, target_ulong wr_mask=
)
> > +{
> > +    switch (cfg_index) {
> > +    case 0:             /* CYCLECFG */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MCYCLECFG_BIT_MINH;
> > +            env->mcyclecfg =3D (new_val & wr_mask) | (env->mcyclecfg &=
 ~wr_mask);
> > +        } else {
> > +            *val =3D env->mcyclecfg &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +        break;
> > +    case 2:             /* INSTRETCFG */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MINSTRETCFG_BIT_MINH;
> > +            env->minstretcfg =3D (new_val & wr_mask) |
> > +                               (env->minstretcfg & ~wr_mask);
> > +        } else {
> > +            *val =3D env->minstretcfg &=3D ~MHPMEVENTH_BIT_MINH;
> > +        }
> > +        break;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_u=
long *val,
> > +                            target_ulong new_val, target_ulong wr_mask=
)
> > +{
> > +
> > +    if (riscv_cpu_mxl(env) !=3D MXL_RV32) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    switch (cfg_index) {
> > +    case 0:         /* CYCLECFGH */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MCYCLECFGH_BIT_MINH;
> > +            env->mcyclecfgh =3D (new_val & wr_mask) |
> > +                              (env->mcyclecfgh & ~wr_mask);
> > +        } else {
> > +            *val =3D env->mcyclecfgh;
> > +        }
> > +        break;
> > +    case 2:          /* INSTRETCFGH */
> > +        if (wr_mask) {
> > +            wr_mask &=3D ~MINSTRETCFGH_BIT_MINH;
> > +            env->minstretcfgh =3D (new_val & wr_mask) |
> > +                                (env->minstretcfgh & ~wr_mask);
> > +        } else {
> > +            *val =3D env->minstretcfgh;
> > +        }
> > +        break;
> > +    default:
> > +        return -EINVAL;
> > +    }
> > +    return 0;
> > +}
> > +
> > +
> >   static RISCVException read_scountovf(CPURISCVState *env, int csrno,
> >                                        target_ulong *val)
> >   {
> > @@ -1349,6 +1537,14 @@ static RISCVException read_scountovf(CPURISCVSta=
te *env, int csrno,
> >       target_ulong *mhpm_evt_val;
> >       uint64_t of_bit_mask;
> >
> > +    /* Virtualize scountovf for counter delegation */
> > +    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> > +        riscv_cpu_cfg(env)->ext_ssccfg &&
> > +        get_field(env->menvcfg, MENVCFG_CDE) &&
> > +        env->virt_enabled) {
> > +        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
> > +    }
> > +
> >       if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >           mhpm_evt_val =3D env->mhpmeventh_val;
> >           of_bit_mask =3D MHPMEVENTH_BIT_OF;
> > @@ -2292,11 +2488,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int=
 csrno,
> >                           target_ulong isel, target_ulong *val,
> >                           target_ulong new_val, target_ulong wr_mask)
> >   {
> > -    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
> > +    int ret =3D -EINVAL;
>
> It seems like both 'ret' and the 'done' label are being used as shortcuts=
 to do
> 'return ret', and every time 'ret' is assigned to something else can be r=
eplaced
> by an early 'return' exit.
>
> I would remove 'ret' and the 'done' label and:
>
>
>
> > +    int ctr_index =3D isel - ISELECT_CD_FIRST;
> > +    int isel_hpm_start =3D ISELECT_CD_FIRST + 3;
> > +
> > +    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_=
ssccfg) {
> >           return RISCV_EXCP_ILLEGAL_INST;
> >       }
> > -    /* TODO: Implement the functionality later */
> > -    return RISCV_EXCP_NONE;
> > +
> > +    /* Invalid siselect value for reserved */
> > +    if (ctr_index =3D=3D 1) {
> > +        goto done;
>
>             return -EINVAL;
> > +    }
> > +
> > +    /* sireg4 and sireg5 provides access RV32 only CSRs */
> > +    if (((csrno =3D=3D CSR_SIREG5) || (csrno =3D=3D CSR_SIREG4)) &&
> > +        (riscv_cpu_mxl(env) !=3D MXL_RV32)) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    /* Check Sscofpmf dependancy */
> > +    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno =3D=3D CSR_SIREG5 &=
&
> > +        (isel_hpm_start <=3D isel && isel <=3D ISELECT_CD_LAST)) {
> > +        goto done;
>
>             return -EINVAL;
>
> > +    }
> > +
> > +    /* Check smcntrpmf dependancy */
> > +    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
> > +        (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_SIREG5) &&
> > +        (ISELECT_CD_FIRST <=3D isel && isel < isel_hpm_start)) {
> > +        goto done;
>
>             return -EINVAL;
>
> > +    }
> > +
> > +    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
> > +        !get_field(env->menvcfg, MENVCFG_CDE)) {
> > +        goto done;
>
>             return -EINVAL;
>
> > +    }
> > +
> > +    switch (csrno) {
> > +    case CSR_SIREG:
> > +        ret =3D rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_ma=
sk);
>
>             return  rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_m=
ask);
> > +        break;
> > +    case CSR_SIREG4:
> > +        ret =3D rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_m=
ask);
>
>             return rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_m=
ask);
> > +        break;
> > +    case CSR_SIREG2:
> > +        if (ctr_index <=3D 2) {
> > +            ret =3D rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_ma=
sk);
>
>                 return rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_ma=
sk);
> > +        } else {
> > +            ret =3D rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_=
mask);
>
>                 return rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_=
mask);
>
> > +        }
> > +        break;
> > +    case CSR_SIREG5:
> > +        if (ctr_index <=3D 2) {
> > +            ret =3D rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_m=
ask);
>
>                 return rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_m=
ask);
>
> > +        } else {
> > +            ret =3D rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr=
_mask);
>
>                 return rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr=
_mask);
>
> > +        }
> > +        break;
> > +    default:
> > +        goto done;
>
>             return -EINVAL;
>
> > +    }
> > +
> > +done:
> > +    return ret;
>
> And remove this last 'return' since we're doing all possible returns alre=
ady.
>

Personally, I prefer a single return in a switch case block. That's
why I have the jump label.
If you feel too strongly about that, I can change as per your suggestion th=
ough.

>
> Thanks,
>
> Daniel
>
> >   }
> >
> >   /*
> > @@ -2578,6 +2833,21 @@ static RISCVException write_mcountinhibit(CPURIS=
CVState *env, int csrno,
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +static RISCVException read_scountinhibit(CPURISCVState *env, int csrno=
,
> > +                                         target_ulong *val)
> > +{
> > +    /* S-mode can only access the bits delegated by M-mode */
> > +    *val =3D env->mcountinhibit & env->mcounteren;
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> > +static RISCVException write_scountinhibit(CPURISCVState *env, int csrn=
o,
> > +                                          target_ulong val)
> > +{
> > +    write_mcountinhibit(env, csrno, val & env->mcounteren);
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
> >                                         target_ulong *val)
> >   {
> > @@ -2680,11 +2950,13 @@ static RISCVException write_menvcfg(CPURISCVSta=
te *env, int csrno,
> >                                       target_ulong val)
> >   {
> >       const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > -    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | ME=
NVCFG_CBZE;
> > +    uint64_t mask =3D MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
> > +                    MENVCFG_CBZE | MENVCFG_CDE;
> >
> >       if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >           mask |=3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> >                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> > +                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
> >                   (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> >
> >           if (env_archcpu(env)->cfg.ext_zicfilp) {
> > @@ -2713,7 +2985,8 @@ static RISCVException write_menvcfgh(CPURISCVStat=
e *env, int csrno,
> >       const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> >       uint64_t mask =3D (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
> >                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> > -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> > +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> > +                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
> >       uint64_t valh =3D (uint64_t)val << 32;
> >
> >       env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> > @@ -5498,6 +5771,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >                           write_sstateen_1_3,
> >                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> >
> > +    /* Supervisor Counter Delegation */
> > +    [CSR_SCOUNTINHIBIT] =3D {"scountinhibit", scountinhibit_pred,
> > +                            read_scountinhibit, write_scountinhibit,
> > +                           .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> > +
> >       /* Supervisor Trap Setup */
> >       [CSR_SSTATUS]    =3D { "sstatus",    smode, read_sstatus,    writ=
e_sstatus,
> >                            NULL,                read_sstatus_i128      =
        },
> >
>

