Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13283E69E96
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 21:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDmv-0006AQ-9Y; Mon, 02 Dec 2024 16:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIDmt-00069Z-0Y
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:16:59 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tIDmp-0008H5-Sh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 16:16:58 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-724f1004c79so3217649b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733174214; x=1733779014;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5PfGf3UKcCeCiIS2uNqnjij3/BwAv0otxIP8T2ec+zI=;
 b=nW58TIVa/aT6s2i4SaOzGKqAKMNhurrzG6ipjLq+fAGWn2yzKaqpuq62zjvNm/KVxE
 Rou/Oa80vf139bCcncTWCA/8bPvaQ+KpDF7YADk5fDVEgEXg9re0tCULJM2VzLm+mE47
 blbXOYO96BIQLlhev4aFtf5nWq3cuT6Kvv/IH9ebh9JXh3cifJu6M15KbKz8Ihs1jPts
 3ICYvhSHC9DPbG3R3mOEWdWevLvBFnkMiqFCa6Y2sD3IchNtLFk+V4LCxh7HJ6QDjgxC
 cSEk53LAw/eUFlBG3Fl4F29rtS4JrDLRUT/Pm+U7Gt1ITXEMkAgEd60LbNzeeRTaOc6Y
 jE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733174214; x=1733779014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5PfGf3UKcCeCiIS2uNqnjij3/BwAv0otxIP8T2ec+zI=;
 b=fXD1sItFlaRUtYwlG63HHHieQpWfKGkXnGqgntq6Pv3ruR8TWmo7Rixbwf97CycUQn
 lpMXbGG813mtgnApjBo9Lzpfanl3hv+xF84TTuAYSyZxunpgRCoNn/VWa5TfW2Buxd2I
 3K6qyE2HggW0oIESDwDXz/s7wF40ztBC/yuFxZOX/X6bpWIO7wRQf5nb7qjpuvZ10zBE
 Z5Fo7UrNot6RzTdOCXJT7Q8m1YO0TYRkiIruKqCmllPkdPCBChnQBdFkl/GOx9LN9lvZ
 gAhtpNGT8kXYigb37DoaV5u7usc5nEKjsD6SZ5Jok7cYY8d4221M8DfaBfnAVByP/bmm
 Ud5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnRp+wtyw6N5hRaOx7bGzJ0n/n5zGxCIObattL0VyjRAU86fuquW9Mj53S1hFVxSIhexJbTWzyBami@nongnu.org
X-Gm-Message-State: AOJu0YybxcZ3PyRvX/SNoYUls7BEdOEdvwTuahOzB2YGekm6/lWBhtF1
 DE5i5s2/zpuhoWQmUyEmSPlpoBSpp1oEdaSVMJj281v4b+Oaeejm2p6irh/a2DTwwktUSGxCeaz
 yhCH2g4XhbLZZIGokOe0VlOnkHNK4j18YmHgokv0YQ13g7QxW
X-Gm-Gg: ASbGncs9ePxCC3nqctW5K8MYLNeCbhq7W/llLwqjehnrdz/bzDLLVVJAb0oF0DW4eKf
 b4uVAnKhUifeEI17d386Q7bPP33Yoiw==
X-Google-Smtp-Source: AGHT+IGY9OdfxnJ7J/saKkgYeHFhSOdrDJTxnnehwOaC81nOgyg7psPJ9s+B9cJ8MGcrxO3zj7A8RprFLZCl8kh6cUw=
X-Received: by 2002:a05:6a00:1bc4:b0:725:30f3:67d8 with SMTP id
 d2e1a72fcca58-72530f368d6mr29295126b3a.0.1733174214269; Mon, 02 Dec 2024
 13:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
 <20241117-counter_delegation-v3-4-476d6f36e3c8@rivosinc.com>
 <3db7857b-0987-49f4-b39e-0cf69c3888b0@ventanamicro.com>
In-Reply-To: <3db7857b-0987-49f4-b39e-0cf69c3888b0@ventanamicro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 2 Dec 2024 13:16:43 -0800
Message-ID: <CAHBxVyHue+6aPNnbmYK_CT2fHbhF+Bs4ekMp6+G85i+PXESYAw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] target/riscv: Support generic CSR indirect access
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, kaiwenxue1@gmail.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42b.google.com
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

On Thu, Nov 28, 2024 at 3:52=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 11/17/24 10:15 PM, Atish Patra wrote:
> > From: Kaiwen Xue <kaiwenx@rivosinc.com>
> >
> > This adds the indirect access registers required by sscsrind/smcsrind
> > and the operations on them. Note that xiselect and xireg are used for
> > both AIA and sxcsrind, and the behavior of accessing them depends on
> > whether each extension is enabled and the value stored in xiselect.
> >
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> > ---
> >   target/riscv/cpu_bits.h |  28 ++++++++-
> >   target/riscv/csr.c      | 149 +++++++++++++++++++++++++++++++++++++++=
+++++++--
> >   2 files changed, 171 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 385a2c67c24b..e13c5420a251 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -173,6 +173,13 @@
> >   #define CSR_MISELECT        0x350
> >   #define CSR_MIREG           0x351
> >
> > +/* Machine Indirect Register Alias */
> > +#define CSR_MIREG2          0x352
> > +#define CSR_MIREG3          0x353
> > +#define CSR_MIREG4          0x355
> > +#define CSR_MIREG5          0x356
> > +#define CSR_MIREG6          0x357
> > +
> >   /* Machine-Level Interrupts (AIA) */
> >   #define CSR_MTOPEI          0x35c
> >   #define CSR_MTOPI           0xfb0
> > @@ -222,6 +229,13 @@
> >   #define CSR_SISELECT        0x150
> >   #define CSR_SIREG           0x151
> >
> > +/* Supervisor Indirect Register Alias */
> > +#define CSR_SIREG2          0x152
> > +#define CSR_SIREG3          0x153
> > +#define CSR_SIREG4          0x155
> > +#define CSR_SIREG5          0x156
> > +#define CSR_SIREG6          0x157
> > +
> >   /* Supervisor-Level Interrupts (AIA) */
> >   #define CSR_STOPEI          0x15c
> >   #define CSR_STOPI           0xdb0
> > @@ -288,6 +302,13 @@
> >   #define CSR_VSISELECT       0x250
> >   #define CSR_VSIREG          0x251
> >
> > +/* Virtual Supervisor Indirect Alias */
> > +#define CSR_VSIREG2         0x252
> > +#define CSR_VSIREG3         0x253
> > +#define CSR_VSIREG4         0x255
> > +#define CSR_VSIREG5         0x256
> > +#define CSR_VSIREG6         0x257
> > +
> >   /* VS-Level Interrupts (H-extension with AIA) */
> >   #define CSR_VSTOPEI         0x25c
> >   #define CSR_VSTOPI          0xeb0
> > @@ -863,10 +884,13 @@ typedef enum RISCVException {
> >   #define ISELECT_IMSIC_EIE63                0xff
> >   #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
> >   #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
> > -#define ISELECT_MASK                       0x1ff
> > +#define ISELECT_MASK_AIA                   0x1ff
> > +
> > +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> > +#define ISELECT_MASK_SXCSRIND              0xfff
> >
> >   /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> > -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
> > +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
> >
> >   /* IMSIC bits (AIA) */
> >   #define IMSIC_TOPEI_IID_SHIFT              16
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index c91a26a52ef6..57e9c9e25f02 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -306,6 +306,17 @@ static RISCVException aia_any32(CPURISCVState *env=
, int csrno)
> >       return any32(env, csrno);
> >   }
> >
> > +static RISCVException csrind_any(CPURISCVState *env, int csrno)
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
>
> It is desirable to avoid env_archcpu() calls because it's a bit costly. I=
f you're
> doing something else with the RISCVCPU pointer then it is what it is, but=
 if you
> want it just to access cpu_cfg you can use riscv_cpu_cfg(env). This is be=
ing done
> in patch 2:
>

Yeah. This one slipped from the original patch. Thanks for noticing it. Fix=
ed.

>
> +    if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
>
>
> In fact this is also being done in rmw_xiselect down below.
>
> > +
> > +    if (!cpu->cfg.ext_smcsrind) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static RISCVException csrind_or_aia_any(CPURISCVState *env, int csrno=
)
> >   {
> >       if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_sm=
csrind) {
> > @@ -389,6 +400,15 @@ static bool csrind_or_aia_extensions_present(CPURI=
SCVState *env)
> >       return csrind_extensions_present(env) || aia_extensions_present(e=
nv);
> >   }
> >
> > +static RISCVException csrind_smode(CPURISCVState *env, int csrno)
> > +{
> > +    if (!csrind_extensions_present(env)) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return smode(env, csrno);
> > +}
> > +
> >   static RISCVException csrind_or_aia_smode(CPURISCVState *env, int csr=
no)
> >   {
> >       if (!csrind_or_aia_extensions_present(env)) {
> > @@ -417,6 +437,15 @@ static RISCVException hmode32(CPURISCVState *env, =
int csrno)
> >
> >   }
> >
> > +static RISCVException csrind_hmode(CPURISCVState *env, int csrno)
> > +{
> > +    if (!csrind_extensions_present(env)) {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> > +    }
> > +
> > +    return hmode(env, csrno);
> > +}
> > +
> >   static RISCVException csrind_or_aia_hmode(CPURISCVState *env, int csr=
no)
> >   {
> >       if (!csrind_or_aia_extensions_present(env)) {
> > @@ -2065,7 +2094,12 @@ static int csrind_xlate_vs_csrno(CPURISCVState *=
env, int csrno)
> >       case CSR_SISELECT:
> >           return CSR_VSISELECT;
> >       case CSR_SIREG:
> > -        return CSR_VSIREG;
> > +    case CSR_SIREG2:
> > +    case CSR_SIREG3:
> > +    case CSR_SIREG4:
> > +    case CSR_SIREG5:
> > +    case CSR_SIREG6:
> > +        return CSR_VSIREG + (csrno - CSR_SIREG);
> >       default:
> >           return csrno;
> >       };
> > @@ -2105,7 +2139,12 @@ static RISCVException rmw_xiselect(CPURISCVState=
 *env, int csrno,
> >           *val =3D *iselect;
> >       }
> >
> > -    wr_mask &=3D ISELECT_MASK;
> > +    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_ss=
csrind) {
> > +        wr_mask &=3D ISELECT_MASK_SXCSRIND;
> > +    } else {
> > +        wr_mask &=3D ISELECT_MASK_AIA;
> > +    }
> > +
> >       if (wr_mask) {
> >           *iselect =3D (*iselect & ~wr_mask) | (new_val & wr_mask);
> >       }
> > @@ -2244,6 +2283,59 @@ done:
> >       return RISCV_EXCP_NONE;
> >   }
> >
> > +/*
> > + * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg=
6
> > + *
> > + * Perform indirect access to xireg and xireg2-xireg6.
> > + * This is a generic interface for all xireg CSRs. Apart from AIA, all=
 other
> > + * extension using csrind should be implemented here.
> > + */
> > +static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
> > +                              target_ulong isel, target_ulong *val,
> > +                              target_ulong new_val, target_ulong wr_ma=
sk)
> > +{
> > +    return -EINVAL;
> > +}
> > +
> > +static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val=
,
> > +                      target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    bool virt =3D false;
> > +    int ret =3D -EINVAL;
> > +    target_ulong isel;
> > +
> > +    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
> > +
> > +    /* Translate CSR number for VS-mode */
> > +    csrno =3D csrind_xlate_vs_csrno(env, csrno);
> > +
> > +    if (CSR_MIREG <=3D csrno && csrno <=3D CSR_MIREG6 &&
> > +        csrno !=3D CSR_MIREG4 - 1) {
> > +        isel =3D env->miselect;
> > +    } else if (CSR_SIREG <=3D csrno && csrno <=3D CSR_SIREG6 &&
> > +               csrno !=3D CSR_SIREG4 - 1) {
> > +        isel =3D env->siselect;
> > +    } else if (CSR_VSIREG <=3D csrno && csrno <=3D CSR_VSIREG6 &&
> > +               csrno !=3D CSR_VSIREG4 - 1) {
> > +        isel =3D env->vsiselect;
> > +        virt =3D true;
> > +    } else {
> > +        goto done;
> > +    }
> > +
> > +    return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
> > +
> > +done:
> > +    if (ret) {
>
> Do you need this check? Up there you're doing:
>
> > +    if (ret !=3D RISCV_EXCP_NONE) {
> > +        return ret;
> > +    }
>
>
> And 'ret' is not changed afterwards, meaning it's guaranteed to be RISCV_=
EXCP_NONE and
> "if (ret)" will always be true.
>
>

Yeah. I have removed it. Thanks!

> Thanks,
>
> Daniel
>
>
> > +        return (env->virt_enabled && virt) ?
> > +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_=
INST;
> > +    }
> > +    return RISCV_EXCP_NONE;
> > +}
> > +
> >   static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> >                                   target_ulong *val, target_ulong new_v=
al,
> >                                   target_ulong wr_mask)
> > @@ -2276,8 +2368,21 @@ static RISCVException rmw_xireg(CPURISCVState *e=
nv, int csrno,
> >            goto done;
> >       };
> >
> > +    /*
> > +     * Use the xiselect range to determine actual op on xireg.
> > +     *
> > +     * Since we only checked the existence of AIA or Indirect Access i=
n the
> > +     * predicate, we should check the existence of the exact extension=
 when
> > +     * we get to a specific range and return illegal instruction excep=
tion even
> > +     * in VS-mode.
> > +     */
> >       if (xiselect_aia_range(isel)) {
> >           return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask)=
;
> > +    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
> > +               riscv_cpu_cfg(env)->ext_sscsrind) {
> > +        return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mas=
k);
> > +    } else {
> > +        return RISCV_EXCP_ILLEGAL_INST;
> >       }
> >
> >   done:
> > @@ -2735,7 +2840,7 @@ static RISCVException write_mstateen0(CPURISCVSta=
te *env, int csrno,
> >           wr_mask |=3D SMSTATEEN0_P1P13;
> >       }
> >
> > -    if (riscv_cpu_cfg(env)->ext_smaia) {
> > +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsr=
ind) {
> >           wr_mask |=3D SMSTATEEN0_SVSLCT;
> >       }
> >
> > @@ -2828,7 +2933,7 @@ static RISCVException write_hstateen0(CPURISCVSta=
te *env, int csrno,
> >           wr_mask |=3D SMSTATEEN0_FCSR;
> >       }
> >
> > -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> > +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsr=
ind) {
> >           wr_mask |=3D SMSTATEEN0_SVSLCT;
> >       }
> >
> > @@ -5261,6 +5366,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_MIREG]    =3D { "mireg",    csrind_or_aia_any,   NULL, NULL,
> >                          rmw_xireg                                     =
  },
> >
> > +    /* Machine Indirect Register Alias */
> > +    [CSR_MIREG2]   =3D { "mireg2", csrind_any, NULL, NULL, rmw_xiregi,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG3]   =3D { "mireg3", csrind_any, NULL, NULL, rmw_xiregi,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG4]   =3D { "mireg4", csrind_any, NULL, NULL, rmw_xiregi,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG5]   =3D { "mireg5", csrind_any, NULL, NULL, rmw_xiregi,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +    [CSR_MIREG6]   =3D { "mireg6", csrind_any, NULL, NULL, rmw_xiregi,
> > +                       .min_priv_ver =3D PRIV_VERSION_1_12_0          =
},
> > +
> >       /* Machine-Level Interrupts (AIA) */
> >       [CSR_MTOPEI]   =3D { "mtopei",   aia_any, NULL, NULL, rmw_xtopei =
},
> >       [CSR_MTOPI]    =3D { "mtopi",    aia_any, read_mtopi },
> > @@ -5382,6 +5499,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_SIREG]      =3D { "sireg",      csrind_or_aia_smode, NULL, N=
ULL,
> >                            rmw_xireg                                   =
       },
> >
> > +    /* Supervisor Indirect Register Alias */
> > +    [CSR_SIREG2]      =3D { "sireg2", csrind_smode, NULL, NULL, rmw_xi=
regi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG3]      =3D { "sireg3", csrind_smode, NULL, NULL, rmw_xi=
regi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG4]      =3D { "sireg4", csrind_smode, NULL, NULL, rmw_xi=
regi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG5]      =3D { "sireg5", csrind_smode, NULL, NULL, rmw_xi=
regi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_SIREG6]      =3D { "sireg6", csrind_smode, NULL, NULL, rmw_xi=
regi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +
> >       /* Supervisor-Level Interrupts (AIA) */
> >       [CSR_STOPEI]     =3D { "stopei",     aia_smode, NULL, NULL, rmw_x=
topei },
> >       [CSR_STOPI]      =3D { "stopi",      aia_smode, read_stopi },
> > @@ -5464,6 +5593,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D=
 {
> >       [CSR_VSIREG]      =3D { "vsireg",      csrind_or_aia_hmode, NULL,=
 NULL,
> >                             rmw_xireg                                  =
       },
> >
> > +    /* Virtual Supervisor Indirect Alias */
> > +    [CSR_VSIREG2]     =3D { "vsireg2", csrind_hmode, NULL, NULL, rmw_x=
iregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG3]     =3D { "vsireg3", csrind_hmode, NULL, NULL, rmw_x=
iregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG4]     =3D { "vsireg4", csrind_hmode, NULL, NULL, rmw_x=
iregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG5]     =3D { "vsireg5", csrind_hmode, NULL, NULL, rmw_x=
iregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +    [CSR_VSIREG6]     =3D { "vsireg6", csrind_hmode, NULL, NULL, rmw_x=
iregi,
> > +                          .min_priv_ver =3D PRIV_VERSION_1_12_0       =
         },
> > +
> >       /* VS-Level Interrupts (H-extension with AIA) */
> >       [CSR_VSTOPEI]     =3D { "vstopei",     aia_hmode, NULL, NULL, rmw=
_xtopei },
> >       [CSR_VSTOPI]      =3D { "vstopi",      aia_hmode, read_vstopi },
> >
>

