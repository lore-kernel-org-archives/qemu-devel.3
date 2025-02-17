Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4ABC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 05:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjtjc-0000eq-2d; Mon, 17 Feb 2025 00:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtd2-0000Cz-9l; Mon, 17 Feb 2025 00:25:12 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtcy-0007go-Ee; Mon, 17 Feb 2025 00:25:11 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-86911fd168dso407157241.1; 
 Sun, 16 Feb 2025 21:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739769905; x=1740374705; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybGjhKVO8jLHez9KvnvAEX14Ag8r2Fq2+HZ5TbS1VKg=;
 b=BtuRNP0ruv4r701Xq3GdrDUNuVX6Q7a9VBg1xGk+3MPfrG6z8/2ZxZ4/FQKvbSu+z2
 FnxiH60Nhh89jTAAR8+m/lYxJvVy8wSrZxgirZrRE02YZ8d6lT23ZM+BrhA2nVleKmu+
 H5wWIUMP/CXGX7XyLb7S1VaX0UgIZumzhExdsPAPmnZlv3p+NwFGfBAs3VWXe4B1z2+f
 elLRcVpoLA4B9255Mx8JC6pr9Bp7IsnKI8E4EXsl/YeR2yL1nu8Sjz3SLLXktJ3BnuTB
 htXaYQPYWQjyfsYQmx385vMs+pj/tUDCTBMBFy3WgwCbk7t1/LDOriTnUmVRPq0xkqMY
 fkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739769905; x=1740374705;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ybGjhKVO8jLHez9KvnvAEX14Ag8r2Fq2+HZ5TbS1VKg=;
 b=a0xFls/XGVLobwP54AYZGm7KolU2h4tqeKodEHgiD4Ju/jhaDwlW3Z7v3argr+1fPa
 lQuN9MdZcPOAACnNtMkYoaTssY7DtL03jlmQCYWbwPI6Y2gDtDxqksfuJ4oy3uLHU6iT
 bwytfeJwbSAx0IdC9JRwEhw9u6IZuruQ8pv7iX8ImbupSGSH6L5XRNM5tNcz/iyaiufU
 l8vXOZLVldwlRxGEPm+SmL9ShS7hLVb5Z4XzE8ZcWdMZhvXtJ0po56JsZUr/sGk80VQA
 5VNvKXTRrS3Ax/ZRIb3hc5t0VNWzUnBaZ+bKUwoUVbUjDPDKw9TVwAPvGgTSUcASFzgl
 re0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/w/lUQh45K/VN3SEGj1jAZlbFq4qz+xGGjpS3OQaB3qgXqe5XdNdJMOdVDmh0jprehRgwt25WreAE@nongnu.org
X-Gm-Message-State: AOJu0YzWXZURB4DKHk7DhrR7s/CHvNdpjERftvJcX9MzYJzWu3tf2kq1
 gc4WmfcM699X+RtZznhq0Tt12y4+Y3bgnnITZsghk367Ornd/4ekkVT89H1Z6bu0X4v9YLkCnrx
 6qvEaDYWSkMFdXSmdpb9MtUv/ru+1sMKL
X-Gm-Gg: ASbGncub0ntY64rfWKBMOtJfGgWFMJbUN8a+vPxR740PRmCCRUeWKH0u0sBOSzUhnyK
 tCPKdT7u7rtC8otTPwLyjVq8eAcszupCBWSCZO1LNHufbGoI8hKPfmVXyqlWWE03oMh2I60sQpn
 LJZC+/f7j0vHoYwnNPG+H3v0O7BA==
X-Google-Smtp-Source: AGHT+IFvq1WaJLtwb7OhWJ/pedYiVx9+NPKbNckYt/EcFMTQenoEDnppOmv5ChgO/zGDQ9qsrun+zst2QJEUU7nUYWk=
X-Received: by 2002:a05:6102:4b0d:b0:4ba:eb24:fb02 with SMTP id
 ada2fe7eead31-4bd3fc818c2mr4698953137.3.1739769904591; Sun, 16 Feb 2025
 21:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20250212-b4-ctr_upstream_v6-v7-1-4e8159ea33bf@rivosinc.com>
In-Reply-To: <20250212-b4-ctr_upstream_v6-v7-1-4e8159ea33bf@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Feb 2025 15:24:38 +1000
X-Gm-Features: AWEUYZm_jyQXmjwG-ikwyYHtf_pBjH6hKGyUErH-ZDqShKShMQtxobJQPPa9hH0
Message-ID: <CAKmqyKP82mMut92UMPTgsOZMFbKmND2+yK6ABVhTjTXZnD1rig@mail.gmail.com>
Subject: Re: [PATCH v7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com, 
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Feb 12, 2025 at 8:20=E2=80=AFPM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> CTR entries are accessed using ctrsource, ctrtarget and ctrdata
> registers using smcsrind/sscsrind extension. This commits extends
> the csrind extension to support CTR registers.
>
> ctrsource is accessible through xireg CSR, ctrtarget is accessible
> through xireg1 and ctrdata is accessible through xireg2 CSR.
>
> CTR supports maximum depth of 256 entries which are accessed using
> xiselect range 0x200 to 0x2ff.
>
> This commits also adds properties to enable CTR extension. CTR can be
> enabled using smctr=3Dtrue and ssctr=3Dtrue now.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> This series enables Control Transfer Records extension support on riscv
> platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been ratified and this series is based on v1.0 [0]
>
> CTR extension depends on both the implementation of S-mode and Sscsrind
> extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs u=
sing
> sscsrind extension.
>
> The series is based on Smcdeleg/Ssccfg counter delegation extension [2]
> patches [3]. CTR itself doesn't depend on counter delegation support. Thi=
s
> rebase is basically to include the Smcsrind patches.
>
> Here is the link to a quick start guide [4] to setup and run a basic perf=
 demo
> on Linux to use CTR Ext.
>
> Qemu patches can be found here:
> https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v7
>
> Opensbi patch can be found here:
> https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2
>
> Linux kernel patches can be found here:
> https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2
>
> [0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag=
/v1.0
> [1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/t=
ag/v1.0.0
> [2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v=
1.0.0
> [3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-0-=
c12a89baed86@rivosinc.com/
> [4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-=
on-QEMU-RISC%E2%80%90V-Virt-machine
> ---
> Changes in v7:
> v7: Rebased on latest riscv-to-apply.next. Given 6 out of 7 patches
>     are already in riscv-to-apply.next, this version only contains the
>     last patch which failed to apply.
>
> v6: Rebased on latest riscv-to-apply.for-upstream.
>   - https://lore.kernel.org/qemu-devel/20250205-b4-ctr_upstream_v6-v6-0-4=
39d8e06c8ef@rivosinc.com
>
> v5: Improvements based on Richard Henderson's feedback.
>   - Fixed code gen logic to use gen_update_pc() instead of
>     tcg_constant_tl().
>   - Some function renaming.
>   - Rebased onto v4 of counter delegation series.
>   - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0-6=
0b993aa567d@rivosinc.com/
>
> v4: Improvements based on Richard Henderson's feedback.
>   - Refactored CTR related code generation to move more code into
>     translation side and avoid unnecessary code execution in generated
>     code.
>   - Added missing code in machine.c to migrate the new state.
>   - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef94=
32@rivosinc.com
>
> v3: Improvements based on Jason Chien and Frank Chang's feedback.
>   - Created single set of MACROs for CTR CSRs in cpu_bit.h
>   - Some fixes in riscv_ctr_add_entry.
>   - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.
>   - Improved extension dependency check.
>   - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.
>   - Added implied rules for Smctr and Ssctr.
>   - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write ops=
.
>   - Some more cosmetic changes.
>   - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0-3=
2fd3c48205f@rivosinc.com/
>
> v2: Lots of improvements based on Jason Chien's feedback including:
>   - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.
>   - Fixed and added more CTR extension enable checks.
>   - Fixed CTR CSR predicate functions.
>   - Fixed external trap xTE bit checks.
>   - One fix in freeze function for VS-mode.
>   - Lots of minor code improvements.
>   - Added checks in sctrclr instruction helper.
>   - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@ri=
vosinc.com/
>
> v1:
>   - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@ri=
vosinc.com/
> ---
>  target/riscv/cpu.c         |  26 +++++++-
>  target/riscv/csr.c         | 150 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  target/riscv/tcg/tcg-cpu.c |  11 ++++
>  3 files changed, 185 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8264c81e889424dfd491cec0ef95eeffc8fcc5b6..522d6584e4c3be7070e5a59f7=
0f5948be8196a77 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -216,6 +216,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> @@ -1599,6 +1601,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>      MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>      MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
>      MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
> @@ -2863,6 +2867,26 @@ static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule SMCTR_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_smctr),
> +    .implied_misa_exts =3D RVS,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_sscsrind),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_ssctr),
> +    .implied_misa_exts =3D RVS,
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_sscsrind),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2881,7 +2905,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> -    &SUPM_IMPLIED, &SSPM_IMPLIED,
> +    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
>      NULL
>  };
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a62c50f057f487753a79393306641d3e50085ee5..d0068ce98c156abd67b7d08f9=
4f29edb957143bd 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2431,6 +2431,13 @@ static bool xiselect_cd_range(target_ulong isel)
>      return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);
>  }
>
> +static bool xiselect_ctr_range(int csrno, target_ulong isel)
> +{
> +    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
> +    return CTR_ENTRIES_FIRST <=3D isel && isel <=3D CTR_ENTRIES_LAST &&
> +           csrno < CSR_MIREG;
> +}
> +
>  static int rmw_iprio(target_ulong xlen,
>                       target_ulong iselect, uint8_t *iprio,
>                       target_ulong *val, target_ulong new_val,
> @@ -2476,6 +2483,124 @@ static int rmw_iprio(target_ulong xlen,
>      return 0;
>  }
>
> +static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val=
,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * TOS                                 H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_src[idx];
> +    }
> +
> +    env->ctr_src[idx] =3D (env->ctr_src[idx] & ~wr_mask) | (new_val & wr=
_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val=
,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_dst[idx];
> +    }
> +
> +    env->ctr_dst[idx] =3D (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr=
_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points =
to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Give=
n entry
> +     * 0 is always the latest one, traversal is a bit different here. Se=
e the
> +     * below example.
> +     *
> +     * Depth =3D 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E=
] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8=
   7
> +     */
> +    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;
> +    const uint64_t mask =3D wr_mask & CTRDATA_MASK;
> +    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_M=
ASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >=3D depth) {
> +        if (val) {
> +            *val =3D 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx =3D (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val =3D env->ctr_data[idx];
> +    }
> +
> +    env->ctr_data[idx] =3D (env->ctr_data[idx] & ~mask) | (new_val & mas=
k);
> +
> +    return 0;
> +}
> +
>  static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                           target_ulong isel, target_ulong *val,
>                           target_ulong new_val, target_ulong wr_mask)
> @@ -2628,6 +2753,27 @@ done:
>      return ret;
>  }
>
> +static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr=
) {
> +        return -EINVAL;
> +    }
> +
> +    if (csrno =3D=3D CSR_SIREG || csrno =3D=3D CSR_VSIREG) {
> +        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
> +    } else if (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_VSIREG2) {
> +        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
> +    } else if (csrno =3D=3D CSR_SIREG3 || csrno =3D=3D CSR_VSIREG3) {
> +        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
> +    } else if (val) {
> +        *val =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
>  /*
>   * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
>   *
> @@ -2639,11 +2785,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, i=
nt csrno,
>                                target_ulong isel, target_ulong *val,
>                                target_ulong new_val, target_ulong wr_mask=
)
>  {
> -    int ret =3D -EINVAL;
>      bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;
> +    int ret =3D -EINVAL;
>
>      if (xiselect_cd_range(isel)) {
>          ret =3D rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (xiselect_ctr_range(csrno, isel)) {
> +        ret =3D rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
>      } else {
>          /*
>           * As per the specification, access to unimplented region is und=
efined
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 027b0324136961c61efb3fcca7a8dc13920d5e4d..29f6a3a72901abd9d56744834=
c6b0c28ae8cf685 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -681,6 +681,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
> +        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
> +        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||
> +            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {
> +            error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrin=
d");
> +            return;
> +        }
> +        cpu->cfg.ext_smctr =3D false;
> +        cpu->cfg.ext_ssctr =3D false;
> +    }
> +
>      /*
>       * Disable isa extensions based on priv spec after we
>       * validated and set everything we need.
>
> ---
> base-commit: 485adaaf6657dd5070dbefed593b2923a397a63f
> change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee
>
> Best regards,
> --
> Rajnesh Kanwal
>
>

