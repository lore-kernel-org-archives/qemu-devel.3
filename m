Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2087D1AD38
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 09:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t10WI-0008HU-28; Wed, 16 Oct 2024 05:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t10WE-0008GW-Uq; Wed, 16 Oct 2024 05:40:39 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t10WB-0003qF-Gy; Wed, 16 Oct 2024 05:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729071622; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=L/9BepXgg8FK+oaCHRxAAyovIr3rd5a4/hNairMCdZI=;
 b=lvNwHSQqMjoO6Y2Ax5fhC1CmmeJQqbtiOut00LUScuWRvJTSc+WBoeRQwQ07ifheXwXEUp0ryl7mNkc7lp/MFH382pncyM/161oBRusqROn9NSULU332L5M3g2C763Aps7QsiJjzQhZwlBhPo2u8c6fgGZtaB7OyDE+a1I5R4yA=
Received: from 30.166.64.81(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHGyT-N_1729071618 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 16 Oct 2024 17:40:19 +0800
Message-ID: <f4ae3ad2-bd3e-4b9e-9013-b890e561df0a@linux.alibaba.com>
Date: Wed, 16 Oct 2024 17:40:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] target/riscv: Add Ssdbltrp CSRs handling
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
References: <20241014112225.90297-1-cleger@rivosinc.com>
 <20241014112225.90297-2-cleger@rivosinc.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241014112225.90297-2-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/10/14 19:22, Clément Léger wrote:
> Add ext_ssdbltrp in RISCVCPUConfig and implement MSTATUS.SDT,
> {H|M}ENVCFG.DTE and modify the availability of MTVAL2 based on the
> presence of the Ssdbltrp ISA extension.
>
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h        |  1 +
>   target/riscv/cpu_bits.h   |  6 ++++++
>   target/riscv/cpu_cfg.h    |  1 +
>   target/riscv/cpu_helper.c | 20 +++++++++++++++++
>   target/riscv/csr.c        | 45 ++++++++++++++++++++++++++++++---------
>   5 files changed, 63 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a84e719d3f..ee984bf270 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -553,6 +553,7 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen);
>   bool riscv_cpu_vector_enabled(CPURISCVState *env);
>   void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt);
>   G_NORETURN void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>                                                  MMUAccessType access_type,
>                                                  int mmu_idx, uintptr_t retaddr);
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index da1723496c..3a5588d4df 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -558,6 +558,7 @@
>   #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
>   #define MSTATUS_TW          0x00200000 /* since: priv-1.10 */
>   #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
> +#define MSTATUS_SDT         0x01000000
>   #define MSTATUS_GVA         0x4000000000ULL
>   #define MSTATUS_MPV         0x8000000000ULL
>   
> @@ -588,6 +589,7 @@ typedef enum {
>   #define SSTATUS_XS          0x00018000
>   #define SSTATUS_SUM         0x00040000 /* since: priv-1.10 */
>   #define SSTATUS_MXR         0x00080000
> +#define SSTATUS_SDT         0x01000000
>   
>   #define SSTATUS64_UXL       0x0000000300000000ULL
>   
> @@ -777,11 +779,13 @@ typedef enum RISCVException {
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
> @@ -795,11 +799,13 @@ typedef enum RISCVException {
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
> index ae2a945b5f..dd804f95d4 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -77,6 +77,7 @@ struct RISCVCPUConfig {
>       bool ext_smstateen;
>       bool ext_sstc;
>       bool ext_smcntrpmf;
> +    bool ext_ssdbltrp;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9d0400035f..77e7736d8a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -63,6 +63,22 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   #endif
>   }
>   
> +bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return false;
> +#else
> +    if (!riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +        return false;
> +    }

As we have guard the write to henvcfg and menvcfg by ext_ssdbltrp, I 
think it is enough only check henvcfg or menvcfg.

The only miss is we don't guard the writhe to henvcfgh. I think we can 
add the guard there.

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
> @@ -562,6 +578,10 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
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
> index e5de72453c..d8280ec956 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -540,6 +540,15 @@ static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
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
> @@ -1402,7 +1411,7 @@ static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
>         (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
>   static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>       SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
> -    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
> +    SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS | SSTATUS_SDT;
This breaks  the v_1_10 constraint, as it is not part of 1.10 specification.
>   
>   /*
>    * Spec allows for bits 13:63 to be either read-only or writable.
> @@ -1600,6 +1609,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           mask |= MSTATUS_VS;
>       }
>   
> +    if (riscv_env_smode_dbltrp_enabled(env, env->virt_enabled)) {
> +        mask |= MSTATUS_SDT;
> +        if ((val & MSTATUS_SDT) != 0) {
> +            mstatus &= ~MSTATUS_SIE;
No need to clean it, if MSTATUS_SIE will be cleaned in val.
> +            val &= ~MSTATUS_SIE;
> +        }
> +    }
> +
I think we should also consider vsstatus for SIE field, as 
write_vsstatus doesn't fall through to write_mstatus.
>       if (xl != MXL_RV32 || env->debugger) {
>           if (riscv_has_ext(env, RVH)) {
>               mask |= MSTATUS_MPV | MSTATUS_GVA;
> @@ -2354,7 +2371,8 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>       }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>   
> @@ -2374,7 +2392,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
>       const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
>       uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                       (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> -                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> +                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
> +                    (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>       uint64_t valh = (uint64_t)val << 32;
>   
>       env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
> @@ -2425,9 +2444,10 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
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
> @@ -2435,6 +2455,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
>       uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
> +    uint64_t menvcfg_mask;
>       RISCVException ret;
>   
>       ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> @@ -2443,7 +2464,11 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>       }
>   
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
> -        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
> +        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> +        if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
> +            menvcfg_mask |= HENVCFG_DTE;
> +        }
> +        mask |= env->menvcfg & menvcfg_mask;
>       }
>   
>       env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
> @@ -2461,8 +2486,8 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
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
> @@ -2470,7 +2495,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
>                                        target_ulong val)
>   {
>       uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
> -                                    HENVCFG_ADUE);
> +                                    HENVCFG_ADUE | HENVCFG_DTE);

Add the ssdbltrp guard here.

Thanks,
Zhiwei

>       uint64_t valh = (uint64_t)val << 32;
>       RISCVException ret;
>   
> @@ -5246,7 +5271,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_VSATP]       = { "vsatp",       hmode,   read_vsatp,    write_vsatp,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },
>   
> -    [CSR_MTVAL2]      = { "mtval2",      hmode,   read_mtval2,   write_mtval2,
> +    [CSR_MTVAL2]      = { "mtval2", dbltrp_hmode, read_mtval2, write_mtval2,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },
>       [CSR_MTINST]      = { "mtinst",      hmode,   read_mtinst,   write_mtinst,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },

