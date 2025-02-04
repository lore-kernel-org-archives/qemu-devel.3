Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E7C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJKs-0000YE-0l; Tue, 04 Feb 2025 08:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfJKo-0000Ua-RX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:51:26 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfJKm-0004GU-9w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:51:26 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2854598f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738677082; x=1739281882;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYuS6BmXZEPlW1ULOGKppbdUZpAeXwnOdJVyx7xjgZo=;
 b=21I09eEONtdAeVGxNS5w8I3rbdMQzRf8Y6ljA7/9cKkopxFhtot4IroqGwwZGZJDSI
 dzV7BQmPxWcV8EsrOJnga/M1nJl8g0qQKOKPDfUZIDJeEGy5dTGAh63wtr2DnhxwRO2I
 TV5iz3yAsadthhAKYt2S51FM1yL0qlYCcT53A6DcZMBYWEFSzM2QCmhV8I/AkVg+iwbx
 VpaEU0m6t3chB5d+NfB7YOCCM+oju7M7Wqh2P0Bb4/jHNmbl8PxjB6Ik8jjVU8oBDPRU
 j9WNcRN2tH3oW2QULUYIvKubCjkiG59IKG/4uPv86Pn+6K7QlvZ8vdsGSFQtDon47Qja
 CqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738677082; x=1739281882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYuS6BmXZEPlW1ULOGKppbdUZpAeXwnOdJVyx7xjgZo=;
 b=cZTYNG0hQ/TxWJaqdEbT4OJck+v38ewBqiCFvkjrrk2ufXIyFDkbA/QH8l3eKbBin+
 iDSlMe6vEg5cqRmmq1DgO61tZMO4PC4NaB8V2CQQ6m1JV10WVzP9qyecTucbRV2/DH0w
 dyYPJRo9MHYfTV1YZrp5a3bUaTICS2WHAATdW4rowuaI97bAHld9S9FpJKYk7ShNnHHF
 J0/LuaUaxI7wjN2tP5lQal0z5mG2UR2A68duVApcHHpy5jeXqLiO5i8NHf+oPKjz6LY4
 drmDkobwDSLYZ/K6lo9w+OUzrDSqzjN+qXDkCkPPFk5XFhbOEcmv8sTCqz1ja4MkxdH+
 7TLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfSt3Scg9HIU9CmkLXl3XbCGBsaA/U5k52PB+hHY77ZzmhrvfWQzIpZWrZpuR6dHyzftzm6A3cbk0i@nongnu.org
X-Gm-Message-State: AOJu0YzPg7fC5WhM+eM9iFsD+5VeNbUy/DZ7SlyJDztUDZuAczfD7LzX
 UBsjbHigg1ueiAIEvjdM6eGQspLVyCX8E0RO+KiyNtz4itclibMYKnyYYfvloawwNyeHolaxQNH
 XmMAc5BO1QR+fpliTQsJlp8pPrOEIMmUJHy8ZDA==
X-Gm-Gg: ASbGncugEgF4kDNS9/gLKB+DWnszVKU7GzOAlPaNI4bxKw0hHUtqxr9WbgWimrM6abD
 vk4AfMnRKxVvsNDcgHq3sFcAsYv6IYlkbbOTUTsHjotTk5oX6SIxQ3vHoaikTA9AIyj59OnCmW8
 copG0CUnX5LCG+kNptfXhnCFkNqxm1MQ==
X-Google-Smtp-Source: AGHT+IFKnI1wYl4xOWVx/ijy8VpHwT0zxM8MkVmBD62lV1QAPtadcWXefLXBnc9gMx3kAclOqkx6h7JzdWIDAEX/AB0=
X-Received: by 2002:a05:6000:2ac:b0:38c:5cd0:ecd4 with SMTP id
 ffacd0b85a97d-38c5cd0f0f5mr16236727f8f.6.1738677081981; Tue, 04 Feb 2025
 05:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
 <20241205-b4-ctr_upstream_v3-v5-6-60b993aa567d@rivosinc.com>
 <CAKmqyKM1hnbUhVwZeKa6Qrsk0tQdF5=D50gsDMk9TUNjJJUHkg@mail.gmail.com>
In-Reply-To: <CAKmqyKM1hnbUhVwZeKa6Qrsk0tQdF5=D50gsDMk9TUNjJJUHkg@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Tue, 4 Feb 2025 13:51:08 +0000
X-Gm-Features: AWEUYZlpPy8vRMb4s6B7gI6BNO2ia-OOnbzcr8YfMLbiLzjlDqoofnyNnBawSj0
Message-ID: <CAECbVCvdSAnuL2YDZ2kPGCaEVTvxcATfHM=PtmovVWYkS5Hk5Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x433.google.com
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

On Mon, Feb 3, 2025 at 2:58=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Thu, Dec 5, 2024 at 9:36=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.c=
om> wrote:
> >
> > CTR entries are accessed using ctrsource, ctrtarget and ctrdata
> > registers using smcsrind/sscsrind extension. This commits extends
> > the csrind extension to support CTR registers.
> >
> > ctrsource is accessible through xireg CSR, ctrtarget is accessible
> > through xireg1 and ctrdata is accessible through xireg2 CSR.
> >
> > CTR supports maximum depth of 256 entries which are accessed using
> > xiselect range 0x200 to 0x2ff.
> >
> > This commits also adds properties to enable CTR extension. CTR can be
> > enabled using smctr=3Dtrue and ssctr=3Dtrue now.
> >
> > Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> > ---
> >  target/riscv/cpu.c         |  26 +++++++-
> >  target/riscv/csr.c         | 150 +++++++++++++++++++++++++++++++++++++=
+++++++-
> >  target/riscv/tcg/tcg-cpu.c |  11 ++++
> >  3 files changed, 185 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 2a4f285a974ffc62e7f3e938691dbffe376a7e46..751029e924d4690aaa5de65=
456fd5a5ec25b916a 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -199,6 +199,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> >      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> >      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> > +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> > +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
> >      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> >      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> >      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> > @@ -1481,6 +1483,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
> >      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> >      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
> >      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> > +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> > +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>
> This should be the very last patch (once everything is supported)
>
> Otherwise
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair

I am sending v6 as I will have to rebase this series on the latest
riscv-to-apply.for-upstream. I will fix the order of patches in that.

Thanks
Rajnesh

>
> >      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> >      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
> >      MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> > @@ -2656,6 +2660,26 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED =3D=
 {
> >      },
> >  };
> >
> > +static RISCVCPUImpliedExtsRule SMCTR_IMPLIED =3D {
> > +    .ext =3D CPU_CFG_OFFSET(ext_smctr),
> > +    .implied_misa_exts =3D RVS,
> > +    .implied_multi_exts =3D {
> > +        CPU_CFG_OFFSET(ext_sscsrind),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> > +static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
> > +    .ext =3D CPU_CFG_OFFSET(ext_ssctr),
> > +    .implied_misa_exts =3D RVS,
> > +    .implied_multi_exts =3D {
> > +        CPU_CFG_OFFSET(ext_sscsrind),
> > +
> > +        RISCV_IMPLIED_EXTS_RULE_END
> > +    },
> > +};
> > +
> >  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
> >      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> >      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> > @@ -2674,7 +2698,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_=
rules[] =3D {
> >      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> >      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> >      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> > -    NULL
> > +    &SMCTR_IMPLIED, &SSCTR_IMPLIED, NULL
> >  };
> >
> >  static Property riscv_cpu_properties[] =3D {
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index a399d55740c7259cd1c1d893687541e23ea3ce52..d7b520099563d3a680c5b75=
dc987881caab95407 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -2399,6 +2399,13 @@ static bool xiselect_cd_range(target_ulong isel)
> >      return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);
> >  }
> >
> > +static bool xiselect_ctr_range(int csrno, target_ulong isel)
> > +{
> > +    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
> > +    return CTR_ENTRIES_FIRST <=3D isel && isel <=3D CTR_ENTRIES_LAST &=
&
> > +           csrno < CSR_MIREG;
> > +}
> > +
> >  static int rmw_iprio(target_ulong xlen,
> >                       target_ulong iselect, uint8_t *iprio,
> >                       target_ulong *val, target_ulong new_val,
> > @@ -2444,6 +2451,124 @@ static int rmw_iprio(target_ulong xlen,
> >      return 0;
> >  }
> >
> > +static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *v=
al,
> > +                          target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    /*
> > +     * CTR arrays are treated as circular buffers and TOS always point=
s to next
> > +     * empty slot, keeping TOS - 1 always pointing to latest entry. Gi=
ven entry
> > +     * 0 is always the latest one, traversal is a bit different here. =
See the
> > +     * below example.
> > +     *
> > +     * Depth =3D 16.
> > +     *
> > +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] =
[E] [F]
> > +     * TOS                                 H
> > +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9  =
 8   7
> > +     */
> > +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> > +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH=
_MASK);
> > +    uint64_t idx;
> > +
> > +    /* Entry greater than depth-1 is read-only zero */
> > +    if (entry >=3D depth) {
> > +        if (val) {
> > +            *val =3D 0;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> > +    idx =3D (idx - entry - 1) & (depth - 1);
> > +
> > +    if (val) {
> > +        *val =3D env->ctr_src[idx];
> > +    }
> > +
> > +    env->ctr_src[idx] =3D (env->ctr_src[idx] & ~wr_mask) | (new_val & =
wr_mask);
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *v=
al,
> > +                          target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    /*
> > +     * CTR arrays are treated as circular buffers and TOS always point=
s to next
> > +     * empty slot, keeping TOS - 1 always pointing to latest entry. Gi=
ven entry
> > +     * 0 is always the latest one, traversal is a bit different here. =
See the
> > +     * below example.
> > +     *
> > +     * Depth =3D 16.
> > +     *
> > +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] =
[E] [F]
> > +     * head                                H
> > +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9  =
 8   7
> > +     */
> > +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> > +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH=
_MASK);
> > +    uint64_t idx;
> > +
> > +    /* Entry greater than depth-1 is read-only zero */
> > +    if (entry >=3D depth) {
> > +        if (val) {
> > +            *val =3D 0;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> > +    idx =3D (idx - entry - 1) & (depth - 1);
> > +
> > +    if (val) {
> > +        *val =3D env->ctr_dst[idx];
> > +    }
> > +
> > +    env->ctr_dst[idx] =3D (env->ctr_dst[idx] & ~wr_mask) | (new_val & =
wr_mask);
> > +
> > +    return 0;
> > +}
> > +
> > +static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val=
,
> > +                        target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    /*
> > +     * CTR arrays are treated as circular buffers and TOS always point=
s to next
> > +     * empty slot, keeping TOS - 1 always pointing to latest entry. Gi=
ven entry
> > +     * 0 is always the latest one, traversal is a bit different here. =
See the
> > +     * below example.
> > +     *
> > +     * Depth =3D 16.
> > +     *
> > +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] =
[E] [F]
> > +     * head                                H
> > +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9  =
 8   7
> > +     */
> > +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> > +    const uint64_t mask =3D wr_mask & CTRDATA_MASK;
> > +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH=
_MASK);
> > +    uint64_t idx;
> > +
> > +    /* Entry greater than depth-1 is read-only zero */
> > +    if (entry >=3D depth) {
> > +        if (val) {
> > +            *val =3D 0;
> > +        }
> > +        return 0;
> > +    }
> > +
> > +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> > +    idx =3D (idx - entry - 1) & (depth - 1);
> > +
> > +    if (val) {
> > +        *val =3D env->ctr_data[idx];
> > +    }
> > +
> > +    env->ctr_data[idx] =3D (env->ctr_data[idx] & ~mask) | (new_val & m=
ask);
> > +
> > +    return 0;
> > +}
> > +
> >  static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
> >                           target_ulong isel, target_ulong *val,
> >                           target_ulong new_val, target_ulong wr_mask)
> > @@ -2596,6 +2721,27 @@ done:
> >      return ret;
> >  }
> >
> > +static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> > +                        target_ulong isel, target_ulong *val,
> > +                        target_ulong new_val, target_ulong wr_mask)
> > +{
> > +    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssc=
tr) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (csrno =3D=3D CSR_SIREG || csrno =3D=3D CSR_VSIREG) {
> > +        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
> > +    } else if (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_VSIREG2) {
> > +        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
> > +    } else if (csrno =3D=3D CSR_SIREG3 || csrno =3D=3D CSR_VSIREG3) {
> > +        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
> > +    } else if (val) {
> > +        *val =3D 0;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  /*
> >   * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg=
6
> >   *
> > @@ -2607,11 +2753,13 @@ static int rmw_xireg_csrind(CPURISCVState *env,=
 int csrno,
> >                                target_ulong isel, target_ulong *val,
> >                                target_ulong new_val, target_ulong wr_ma=
sk)
> >  {
> > -    int ret =3D -EINVAL;
> >      bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;
> > +    int ret =3D -EINVAL;
> >
> >      if (xiselect_cd_range(isel)) {
> >          ret =3D rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> > +    } else if (xiselect_ctr_range(csrno, isel)) {
> > +        ret =3D rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask)=
;
> >      } else {
> >          /*
> >           * As per the specification, access to unimplented region is u=
ndefined
> > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > index 2b57aa4d1704b176f314dbe0b120cfcc943bf4f8..575b5692c7f68a5f6d37edb=
c17269e41f496f682 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -652,6 +652,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *c=
pu, Error **errp)
> >          return;
> >      }
> >
> > +    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
> > +        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
> > +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||
> > +            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {
> > +            error_setg(errp, "Smctr and Ssctr require S-mode and Sscsr=
ind");
> > +            return;
> > +        }
> > +        cpu->cfg.ext_smctr =3D false;
> > +        cpu->cfg.ext_ssctr =3D false;
> > +    }
> > +
> >      /*
> >       * Disable isa extensions based on priv spec after we
> >       * validated and set everything we need.
> >
> > --
> > 2.34.1
> >
> >

