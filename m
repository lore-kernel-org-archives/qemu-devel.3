Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C78EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjzuW-0007zt-0U; Mon, 17 Feb 2025 07:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tjzuG-0007xw-3i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:07:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tjzu4-0004BF-DQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:07:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43962f7b0e4so25408465e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739794029; x=1740398829;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tA6ckBKeD8mV+dH/0u+FXrxAWlgUxUC8aVSrcnER3gM=;
 b=d5Wjkhh7mhdJk1VJfrCzYA0ERLuTu0kFpraevZTuQWqBxcEI+OsQY3XmW537sp888U
 ykOzhW4bOArK02H1+OeMmaiQY62AT02eF2XX3XQpNAMbT+1i4dV+qqb3LkUVNA93oIBf
 /IajsDr2ALLNSmyXvGNZB6pCnWhg4yodY9dUJHcMRPeQEtJFEhTm928AqVW0sb0npUeE
 3vMEht8DEToIWGsXZwVvTgcZEnT8kaHrAA2IlcgxsN+c/w98+D4h3SvUd9wgqVop0ow/
 8M7BSVK5ty4GrtIQHKRNcbdoZmhFOOpkWWKl5vm8Sv/0tvl+s24euwxRdksYfUX8OOzo
 e9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739794029; x=1740398829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tA6ckBKeD8mV+dH/0u+FXrxAWlgUxUC8aVSrcnER3gM=;
 b=W37V4uUj/YC7QFA0w8bgYZyZQAuHnDm6lymqHnp5Yl7Jfjg+U2ZzzJ6F0zklmAq+M8
 cpaPI1In75VfPsGiCAyIl9nWIX5ZvZ3VPF05qId4RH98zYMNVtuge95N70Lq31GgF3EU
 O3xUhYbFY1Awr1wOknzVEsU/S7FndbYpgkhKkeIgEDWGq9Ha5YyykSJwordikQYBHZrd
 z10qZRwNTG2Ilz9J/pwbgbulXj26vWSJlSRp+Zin7WHRrujcFMJkkp32CvdvVbSN3+Nu
 +9BKRpga2a5WZn2BSC+j4z3FEf8FqbrJ+uf+o5nrly0O4NPQDHYD9OnxmvpzwNoKQt0Z
 cjKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpSTxS93KvWd+2jAqCZgzG1+v5vUo4rIGc8rO7nEruh7YOcEpe1PkKCDtaDDWIa18JaoL5pQ0j8nDj@nongnu.org
X-Gm-Message-State: AOJu0Yz+A8xkzfFl+jlmWEVmHdEY8bTyQZsoQb9p1hWPWfwa9y7HLhih
 U3XgsJ7h5nNOz4f6RIBE6PSRUtPiX1axot1tqQkpmvMpxjj4rFMncjKQ+WamAAzThO7ycqhyEd5
 No8ZN6XMEuVRiLRcyx5beY06qmDRZobFR0sjGIQ==
X-Gm-Gg: ASbGncub4vSW+qXN5SdXGfTOZ4mJXRrC4UlL4SQFBdDLVJFTXonN0LmMbitKyGATYI3
 FE+VfsDX078ILAcDKDDPqqZHu1cw9ccNBrmbj22aIl9Rd0DQPG0/BP2Q9mBsRSAQ4dBrwGrY=
X-Google-Smtp-Source: AGHT+IEj3fqCoX4XL/kSa1HG54PRnLr/pQ/TjCIEBHAKDXZBzY4FBjGGOOW0kzFgYdiW6ldeHXq7tit45syIEbr2g+E=
X-Received: by 2002:a05:6000:188c:b0:38d:d7a4:d447 with SMTP id
 ffacd0b85a97d-38f33f52ee9mr10380023f8f.34.1739794029234; Mon, 17 Feb 2025
 04:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20250212-b4-ctr_upstream_v6-v7-1-4e8159ea33bf@rivosinc.com>
 <CAKmqyKP82mMut92UMPTgsOZMFbKmND2+yK6ABVhTjTXZnD1rig@mail.gmail.com>
In-Reply-To: <CAKmqyKP82mMut92UMPTgsOZMFbKmND2+yK6ABVhTjTXZnD1rig@mail.gmail.com>
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
Date: Mon, 17 Feb 2025 12:06:58 +0000
X-Gm-Features: AWEUYZmRAv9DuCsz1BMPBJwwysoa9iDRKno4Tk1uiW_ktoc_GLYMAVL4NcF7m8E
Message-ID: <CAECbVCsmMgpwwk8mPqszGnBZwHmoWNbovdCGpmyEDzDKPJh5JA@mail.gmail.com>
Subject: Re: [PATCH v7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x329.google.com
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

On Mon, Feb 17, 2025 at 5:25=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Wed, Feb 12, 2025 at 8:20=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.=
com> wrote:
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
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
>
> Thanks!
>
> Applied to riscv-to-apply.next
>
> Alistair
>

Thanks.

> > ---
> > This series enables Control Transfer Records extension support on riscv
> > platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> > The Extension has been ratified and this series is based on v1.0 [0]
> >
> > CTR extension depends on both the implementation of S-mode and Sscsrind
> > extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs=
 using
> > sscsrind extension.
> >
> > The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
> > patches [3]. CTR itself doesn't depend on counter delegation support. T=
his
> > rebase is basically to include the Smcsrind patches.
> >
> > Here is the link to a quick start guide [4] to setup and run a basic pe=
rf demo
> > on Linux to use CTR Ext.
> >
> > Qemu patches can be found here:
> > https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v7
> >
> > Opensbi patch can be found here:
> > https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
> >
> > Linux kernel patches can be found here:
> > https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
> >
> > [0]: https://github.com/riscv/riscv-control-transfer-records/releases/t=
ag/v1.0
> > [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases=
/tag/v1.0.0
> > [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag=
/v1.0.0
> > [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-=
0-c12a89baed86@rivosinc.com/
> > [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-dem=
o-on-QEMU-RISC%E2%80%90V-Virt-machine
> > ---
> > Changes in v7:
> > v7: Rebased on latest riscv-to-apply.next. Given 6 out of 7 patches
> >     are already in riscv-to-apply.next, this version only contains the
> >     last patch which failed to apply.
> >
> > v6: Rebased on latest riscv-to-apply.for-upstream.
> >   - https://lore.kernel.org/qemu-devel/20250205-b4-ctr_upstream_v6-v6-0=
-439d8e06c8ef@rivosinc.com
> >
> > v5: Improvements based on Richard Henderson's feedback.
> >   - Fixed code gen logic to use gen_update_pc() instead of
> >     tcg_constant_tl().
> >   - Some function renaming.
> >   - Rebased onto v4 of counter delegation series.
> >   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0=
-60b993aa567d@rivosinc.com/
> >
> > v4: Improvements based on Richard Henderson's feedback.
> >   - Refactored CTR related code generation to move more code into
> >     translation side and avoid unnecessary code execution in generated
> >     code.
> >   - Added missing code in machine.c to migrate the new state.
> >   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef=
9432@rivosinc.com
> >
> > v3: Improvements based on Jason Chien and Frank Chang's feedback.
> >   - Created single set of MACROs for CTR CSRs in cpu_bit.h
> >   - Some fixes in riscv_ctr_add_entry.
> >   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
> >   - Improved extension dependency check.
> >   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
> >   - Added implied rules for Smctr and Ssctr.
> >   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write o=
ps.
> >   - Some more cosmetic changes.
> >   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0=
-32fd3c48205f@rivosinc.com/
> >
> > v2: Lots of improvements based on Jason Chien's feedback including:
> >   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
> >   - Fixed and added more CTR extension enable checks.
> >   - Fixed CTR CSR predicate functions.
> >   - Fixed external trap xTE bit checks.
> >   - One fix in freeze function for VS-mode.
> >   - Lots of minor code improvements.
> >   - Added checks in sctrclr instruction helper.
> >   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@=
rivosinc.com/
> >
> > v1:
> >   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@=
rivosinc.com/
> > ---
> >  target/riscv/cpu.c         |  26 +++++++-
> >  target/riscv/csr.c         | 150 +++++++++++++++++++++++++++++++++++++=
+++++++-
> >  target/riscv/tcg/tcg-cpu.c |  11 ++++
> >  3 files changed, 185 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 8264c81e889424dfd491cec0ef95eeffc8fcc5b6..522d6584e4c3be7070e5a59=
f70f5948be8196a77 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -216,6 +216,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
> >      ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
> >      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
> >      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> > +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> > +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
> >      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> >      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
> >      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> > @@ -1599,6 +1601,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions=
[] =3D {
> >      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
> >      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
> >      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> > +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> > +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
> >      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
> >      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
> >      MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> > @@ -2863,6 +2867,26 @@ static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D =
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
> > @@ -2881,7 +2905,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_=
rules[] =3D {
> >      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> >      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> >      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> > -    &SUPM_IMPLIED, &SSPM_IMPLIED,
> > +    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
> >      NULL
> >  };
> >
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index a62c50f057f487753a79393306641d3e50085ee5..d0068ce98c156abd67b7d08=
f94f29edb957143bd 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -2431,6 +2431,13 @@ static bool xiselect_cd_range(target_ulong isel)
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
> > @@ -2476,6 +2483,124 @@ static int rmw_iprio(target_ulong xlen,
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
> > @@ -2628,6 +2753,27 @@ done:
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
> > @@ -2639,11 +2785,13 @@ static int rmw_xireg_csrind(CPURISCVState *env,=
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
> > index 027b0324136961c61efb3fcca7a8dc13920d5e4d..29f6a3a72901abd9d567448=
34c6b0c28ae8cf685 100644
> > --- a/target/riscv/tcg/tcg-cpu.c
> > +++ b/target/riscv/tcg/tcg-cpu.c
> > @@ -681,6 +681,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *c=
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
> > ---
> > base-commit: 485adaaf6657dd5070dbefed593b2923a397a63f
> > change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
> >
> > Best regards,
> > --
> > Rajnesh Kanwal
> >
> >

