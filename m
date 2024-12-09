Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D8E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjYw-0008BZ-Fe; Mon, 09 Dec 2024 14:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tKjYv-0008BF-KK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:36:57 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tKjYr-0005B1-VX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 14:36:57 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so1024104b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733773012; x=1734377812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O071emEBkhymSTwQwgNUzOA0daDkOAUFM00uITsn2oo=;
 b=oI92gg6pB0XVJ6PUR45emJgndOBX1rx0FAHmVCnsPMae/A1t5be6k3jbU4VPfgBBuh
 CE11lDJ6qEHcvVYxOU/z5V3ysxYi/J3rJXagFYSMeigC8yzIdq272BVjyOU/12prSzri
 T1Uqs1Qz8KdcCvvw02s9y9mGwBD67ZJBSCs62i5J7uJAm8+BbFSdAMieE2D1DP0KfnAW
 YkkVInY8TpW7wCJeIYNdc4J9J6dp+nc+DglY0xljQvgkgyaKI9cIL5kaYyORYHQeSQCk
 ng5mkLjV5If0MO6kQEwJZtzs2Bqye+/q7BwldW5pEBOYpfVIh17GQk++AvVKZEnJFVFW
 Y40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733773012; x=1734377812;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O071emEBkhymSTwQwgNUzOA0daDkOAUFM00uITsn2oo=;
 b=eX4CvdMV3CxJ7TW20lFmvxkruQw7X7bh95oW5a4/1qcyB5toOhz5oWAr8wWdniLkUc
 7y4qtskBH9/bQzuLFsghbkeSKqi3tbuyD1dOwe4UubGFMAxzahFxQREHoMayKo+Zx7UW
 WPSMMUfgLqnlSLNfDCwfI7QzsOytdcrSXYMLpse55RHO2j8lPybLiQiWqJfQ1p8trdbv
 Vdt7IIn1jAZjCRFLNV8ZcrqcE20xrJulUD0twExqjJT7f73aZBIgMSSOxFbhjCB6pH/N
 4q++hRzbbUwWJf+NrTprHHCCDi2u+4LvLavojoIdOtwucAgNkHTnAPGdG78ta6ZfKtCV
 Dxgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdf4VIZiIwoX63UwzcVhLlBpZJJU4/q+a0GtQgbxaM+V1amr9IfzJsRAbsk2DfA5CVW4cVxUrgZRnc@nongnu.org
X-Gm-Message-State: AOJu0YxRBCIfk5MAloFK2i/DdtziMz2eUNcbd4gr8BqgPxGVM1E7jLd5
 vlK4t/M3e8X9MJWeJgJMASbq1k0XE9gGb79U8OXnuLb3dCvrqlJ8ggJ4mcMn4Fo=
X-Gm-Gg: ASbGncu6YUM9qC68V10kwsfUk+7v1LIkV730E9iyXYKvHGXD2z0U3+MqOvL3AiX8zgJ
 g1EXB+0n6wI3yD+4/NIdZRf4OMcMus72oFa8erUFzLRxrxsI454wedDipqQTiyGEJ0EcmA9IJD6
 Me7+UUUdUQc6z86TIaOhO/lnu8xbLMmRul1i0sx9yRsElAebbHJEE0TFGVekj+DsV5D2dVrYPcy
 CaTxohQ2/FBI0o3n9VHANFGK7nPLCtiPLt/Z5EYq2RfC02MBQZCuFxBOp85Xu5wJN8qp7kGFZma
 v+NRO1lBoBPDDdfjzwPTDQhXgF0aWnpC
X-Google-Smtp-Source: AGHT+IFDSesADjOyrDdmUyCbFYR57QbJr4ApZL/uq+IPMEo0NglGq35AKvWc0Ppcbj++L6VcwZd6Ng==
X-Received: by 2002:a05:6a00:810:b0:725:9afd:e195 with SMTP id
 d2e1a72fcca58-7273c8e8568mr2282619b3a.1.1733773011184; 
 Mon, 09 Dec 2024 11:36:51 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:5756:767e:ee4e:f9a8:ee18?
 ([2804:7f0:bcc0:5756:767e:ee4e:f9a8:ee18])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725d8e5393csm4270701b3a.48.2024.12.09.11.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 11:36:50 -0800 (PST)
Message-ID: <364ab1a2-2be1-4054-a8cf-d674b1538da6@ventanamicro.com>
Date: Mon, 9 Dec 2024 16:36:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] target/riscv: Add Ssdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org,
 Frank Chang <frank.chang@sifive.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
 <20241128141230.284320-3-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241128141230.284320-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/28/24 11:12 AM, Clément Léger wrote:
> Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
> {H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
> presence of the Ssdbltrp ISA extension.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.h        |  1 +
>   target/riscv/cpu_bits.h   |  6 ++++
>   target/riscv/cpu_cfg.h    |  1 +
>   target/riscv/cpu_helper.c | 17 +++++++++
>   target/riscv/csr.c        | 72 ++++++++++++++++++++++++++++++++-------
>   5 files changed, 84 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8dc5b4d002..02e502768e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -569,6 +569,7 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
>   bool cpu_get_fcfien(CPURISCVState *env);
>   bool cpu_get_bcfien(CPURISCVState *env);
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
>   G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                  MMUAccessType access_type,
>                                                  int mmu_idx, uintptr_t retaddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f31735d15b..dcf63b7f32 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -562,6 +562,7 @@
>   #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>   #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>   #define MSTATUS_SPELP       0x00800000 /* zicfilp */
> +#define MSTATUS_SDT         0x01000000
>   #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>   #define MSTATUS_GVA         0x4000000000ULL
>   #define MSTATUS_MPV         0x8000000000ULL
> @@ -594,6 +595,7 @@ typedef enum {
>   #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>   #define SSTATUS_MXR         0x00080000
>   #define SSTATUS_SPELP       MSTATUS_SPELP   /* zicfilp */
> +#define SSTATUS_SDT         MSTATUS_SDT
>   
>   #define SSTATUS64_UXL       0x0000000300000000ULL
>   
> @@ -791,11 +793,13 @@ typedef enum RISCVException {
>   #define MENVCFG_CBIE                       (3UL << 4)
>   #define MENVCFG_CBCFE                      BIT(6)
>   #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_DTE                        (1ULL << 59)
>   #define MENVCFG_ADUE                       (1ULL << 61)
>   #define MENVCFG_PBMTE                      (1ULL << 62)
>   #define MENVCFG_STCE                       (1ULL << 63)
>   
>   /* For RV32 */
> +#define MENVCFGH_DTE                       BIT(27)
>   #define MENVCFGH_ADUE                      BIT(29)
>   #define MENVCFGH_PBMTE                     BIT(30)
>   #define MENVCFGH_STCE                      BIT(31)
> @@ -813,11 +817,13 @@ typedef enum RISCVException {
>   #define HENVCFG_CBIE                       MENVCFG_CBIE
>   #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_DTE                        MENVCFG_DTE
>   #define HENVCFG_ADUE                       MENVCFG_ADUE
>   #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>   #define HENVCFG_STCE                       MENVCFG_STCE
>   
>   /* For RV32 */
> +#define HENVCFGH_DTE                        MENVCFGH_DTE
>   #define HENVCFGH_ADUE                       MENVCFGH_ADUE
>   #define HENVCFGH_PBMTE                      MENVCFGH_PBMTE
>   #define HENVCFGH_STCE                       MENVCFGH_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 321f64fd72..1194dfd3bc 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -79,6 +79,7 @@ struct RISCVCPUConfig {
>       bool ext_smstateen;
>       bool ext_sstc;
>       bool ext_smcntrpmf;
> +    bool ext_ssdbltrp;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d53ddc384f..3fabd3379c 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -120,6 +120,19 @@ bool cpu_get_bcfien(CPURISCVState *env)
>       }
>   }
>   
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return false;
> +#else
> +    if (virt) {
> +        return (env->henvcfg & HENVCFG_DTE) != 0;
> +    } else {
> +        return (env->menvcfg & MENVCFG_DTE) != 0;
> +    }
> +#endif
> +}
> +
>   void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>                             uint64_t *cs_base, uint32_t *pflags)
>   {
> @@ -642,6 +655,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
>   
>       g_assert(riscv_has_ext(env, RVH));
>   
> +    if (riscv_env_smode_dbltrp_enabled(env, current_virt)) {
> +        mstatus_mask |= MSTATUS_SDT;
> +    }
> +
>       if (current_virt) {
>           /* Current V=1 and we are about to change to V=0 */
>           env->vsstatus = env->mstatus & mstatus_mask;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 98c683df60..611f44e044 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -559,6 +559,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
>       return hmode32(env, csrno);
>   }
>   
> +static RISCVException dbltrp_hmode(CPURISCVState *env, int csrno)
> +{
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>   static RISCVException pmp(CPURISCVState *env, int csrno)
>   {
>       if (riscv_cpu_cfg(env)->pmp) {
> @@ -1633,6 +1642,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           mask |= MSTATUS_VS;
>       }
>   
> +    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
> +        mask |= MSTATUS_SDT;
> +        if ((val & MSTATUS_SDT) != 0) {
> +            val &= ~MSTATUS_SIE;
> +        }
> +    }
> +
>       if (xl != MXL_RV32 || env->debugger) {
>           if (riscv_has_ext(env, RVH)) {
>               mask |= MSTATUS_MPV | MSTATUS_GVA;
> @@ -2394,7 +2410,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>   
>           if (env_archcpu(env)->cfg.ext_zicfilp) {
>               mask |= MENVCFG_LPE;
> @@ -2403,6 +2420,10 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>           if (env_archcpu(env)->cfg.ext_zicfiss) {
>               mask |= MENVCFG_SSE;
>           }
> +
> +        if ((val & MENVCFG_DTE) == 0) {
> +            env->mstatus &= ~MSTATUS_SDT;
> +        }
>       }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>       write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> @@ -2425,9 +2446,14 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>   
> +    if ((valh & MENVCFG_DTE) == 0) {
> +        env->mstatus &= ~MSTATUS_SDT;
> +    }
> +
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
>       write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
>   
> @@ -2488,9 +2514,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
>        * henvcfg.pbmte is read_only 0 when menvcfg.pbmte = 0
>        * henvcfg.stce is read_only 0 when menvcfg.stce = 0
>        * henvcfg.adue is read_only 0 when menvcfg.adue = 0
> +     * henvcfg.dte is read_only 0 when menvcfg.dte = 0
>        */
> -    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
> -                           env->menvcfg);
> +    *val = env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
> +                             HENVCFG_DTE) | env->menvcfg);
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -2506,7 +2533,8 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>       }
>   
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
> +        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
> +                                HENVCFG_DTE);
>   
>           if (env_archcpu(env)->cfg.ext_zicfilp) {
>               mask |= HENVCFG_LPE;
> @@ -2520,6 +2548,9 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>       }
>   
>       env->henvcfg = val & mask;
> +    if ((env->henvcfg & HENVCFG_DTE) == 0) {
> +        env->vsstatus &= ~MSTATUS_SDT;
> +    }
>   
>       return RISCV_EXCP_NONE;
>   }
> @@ -2534,8 +2565,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
>           return ret;
>       }
>   
> -    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) |
> -                            env->menvcfg)) >> 32;
> +    *val = (env->henvcfg & (~(HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
> +                              HENVCFG_DTE) | env->menvcfg)) >> 32;
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -2543,7 +2574,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>                                        target_ulong val)
>   {
>       uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +                                    HENVCFG_ADUE | HENVCFG_DTE);
>       uint64_t valh = (uint64_t)val << 32;
>       RISCVException ret;
>   
> @@ -2551,8 +2582,10 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>       if (ret != RISCV_EXCP_NONE) {
>           return ret;
>       }
> -
>       env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
> +    if ((env->henvcfg & HENVCFG_DTE) == 0) {
> +        env->vsstatus &= ~MSTATUS_SDT;
> +    }
>       return RISCV_EXCP_NONE;
>   }
>   
> @@ -2980,6 +3013,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>       if (env->xl != MXL_RV32 || env->debugger) {
>           mask |= SSTATUS64_UXL;
>       }
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |= SSTATUS_SDT;
> +    }
>   
>       if (env_archcpu(env)->cfg.ext_zicfilp) {
>           mask |= SSTATUS_SPELP;
> @@ -2996,11 +3032,12 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
>       if (env->xl != MXL_RV32 || env->debugger) {
>           mask |= SSTATUS64_UXL;
>       }
> -
>       if (env_archcpu(env)->cfg.ext_zicfilp) {
>           mask |= SSTATUS_SPELP;
>       }
> -
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |= SSTATUS_SDT;
> +    }
>       /* TODO: Use SXL not MXL. */
>       *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
>       return RISCV_EXCP_NONE;
> @@ -3020,7 +3057,9 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
>       if (env_archcpu(env)->cfg.ext_zicfilp) {
>           mask |= SSTATUS_SPELP;
>       }
> -
> +    if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        mask |= SSTATUS_SDT;
> +    }
>       target_ulong newval = (env->mstatus & ~mask) | (val & mask);
>       return write_mstatus(env, CSR_MSTATUS, newval);
>   }
> @@ -4126,6 +4165,13 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
>       if ((val & VSSTATUS64_UXL) == 0) {
>           mask &= ~VSSTATUS64_UXL;
>       }
> +    if ((env->henvcfg & HENVCFG_DTE)) {
> +        if ((val & SSTATUS_SDT) != 0) {
> +            val &= ~SSTATUS_SIE;
> +        }
> +    } else {
> +        val &= ~SSTATUS_SDT;
> +    }
>       env->vsstatus = (env->vsstatus & ~mask) | (uint64_t)val;
>       return RISCV_EXCP_NONE;
>   }
> @@ -5336,7 +5382,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },
>   
> -    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
> +    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },
>       [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },


