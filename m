Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB59E7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 21:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJfaz-0000PR-Et; Fri, 06 Dec 2024 16:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJfay-0000PB-Nw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:10:40 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJfaw-0000PO-Pa
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:10:40 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7258cf2975fso2268689b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733519437; x=1734124237; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ph5Uo+FcRJ7jlF3RXjf5zIBx5JWmJ6KlSj4XcZI40Bw=;
 b=AE80y2+HvGPywiswgfZz7bspC9TSyIJc3nRvzZuPRK7QQvyt1VkgJ7V8dxlcM2Yfxs
 6gOeVYyNkg+ldCL/QHWjT40CCLL5IOCdjeQueHnKi4Zl5UpjNqpcJcLSKYdO7m3Pk/Ot
 n3oPlLVim1+RwR6cGxBllEx9wB28Hd1rx2z4t4siJ0blSz7ceA1xi37YqQwEl+h0r8xS
 u4qZToQRk3Y8XfUT7w6KZb58o8djpRcNDIeTeKXznztaBAPhhEVoOcOcNHOEJZfq/cel
 wJw7PVEIlRhmqnLyd5Lam4yDP8+9ES0BoLMu/9n+saJfDGyQa3V49Q++TlW2FEVOhXec
 wZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733519437; x=1734124237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ph5Uo+FcRJ7jlF3RXjf5zIBx5JWmJ6KlSj4XcZI40Bw=;
 b=pOeAiHSIrkxWNGX/Tn5sCNmZhUiiQWxDTSjypFZaglM3AbJISwoVoCFcjSvana6sjY
 HQAlQJ0cMk5uKRzkekpvX/ncqi9EesfkR9LHAjjINfTWh29mmCXpI+ekvbcU/I3s5Ntu
 ppHBQreZshXXS7Q+Mom2CT0fs0Y3Da5/ZzH5Nx9ZA4PXy921d2WFCjqLs7RzoxfVmgCz
 GmJcFN1a5hRKJg8jpfZoLvFgcT/pOwmAnYbZpSciZekasa+YT3pdHTIJ1uEgyc3impu/
 4fN3lnFEZEv3qPYAXrOlKlDiGt0eWg9P69gdqn4TMdgsfncVx3CcLXqHWu7+PYVxnJYE
 4Yjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWonOXspvC4XEzmtmydRBjC5wlYZaspRmsxYYt5+HIKJKpC/vpmoTDG3NrAh+5tw2FEbLc+8k68UbGE@nongnu.org
X-Gm-Message-State: AOJu0YxpOw63FwZFF7drKNWsEuD/2n193d1UeNjNSP4isiMbTYl0uftZ
 SyL8aivHr8PjJFzZqKvuNxoU+s9j3PAxP1ZueRASDSd/JRWSodxU8b+RHph7/mY=
X-Gm-Gg: ASbGncur0iIV9SEzxbqM5XiLZ6b9M8MtzRDqcDV4UDLwggO7UqV+HEurOPS8UgIeuEN
 iQncHtEdiE8XzEHJXRU0uvBoYH3mChHWG01nZSjLqhOvKLMYiHniinwxKXsZkS6MRPs5mwbUqu7
 kjNa1NKWNH10jgBDiX9kbUP19BKNvxaVkmYfom7fE57PhCEXYLC+SWv7vTasolLPzixN50gA1II
 7y9I4dDYeZB7Hyb9Y9SEwJvl3fKuvHdlvx+m6GWG5Ol3uK6dKr5AIyFNlUB/nK24+jUE1m66Pcs
 Pi0qTzq/K8Fsm2CVkCHh4Ek=
X-Google-Smtp-Source: AGHT+IEo7jkKCoyFYGoksXrUCwXbDgIIjNxhieXFEXcu7wtI4XWcPytFGM7JUjdvOz4MyKtTQZhlCw==
X-Received: by 2002:a17:903:249:b0:205:4721:19c with SMTP id
 d9443c01a7336-21614dcda61mr67960975ad.37.1733519436808; 
 Fri, 06 Dec 2024 13:10:36 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:b984:11b:9da2:696:f7f6?
 ([2804:7f0:bcc0:b984:11b:9da2:696:f7f6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21618e6a605sm15491925ad.26.2024.12.06.13.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 13:10:36 -0800 (PST)
Message-ID: <305daac0-7f4a-44fe-a657-d1c02a95367c@ventanamicro.com>
Date: Fri, 6 Dec 2024 18:10:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/7] target/riscv: Add new CSR fields for S{sn, mn,
 m}pm extensions as part of Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-3-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241205112304.593204-3-baturo.alexey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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



On 12/5/24 8:22 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.h      |  8 ++++++++
>   target/riscv/cpu_bits.h |  4 ++++
>   target/riscv/cpu_cfg.h  |  3 +++
>   target/riscv/csr.c      | 31 ++++++++++++++++++++++++++++++-
>   target/riscv/pmp.c      | 14 +++++++++++---
>   target/riscv/pmp.h      |  1 +
>   6 files changed, 57 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e11264231d..417ff45544 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -128,6 +128,14 @@ typedef enum {
>       EXT_STATUS_DIRTY,
>   } RISCVExtStatus;
>   
> +/* Enum holds PMM field values for Zjpm v1.0 extension */
> +typedef enum {
> +    PMM_FIELD_DISABLED = 0,
> +    PMM_FIELD_RESERVED = 1,
> +    PMM_FIELD_PMLEN7   = 2,
> +    PMM_FIELD_PMLEN16  = 3,
> +} RISCVPmPmm;
> +
>   typedef struct riscv_cpu_implied_exts_rule {
>   #ifndef CONFIG_USER_ONLY
>       /*
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 2a6aff63ed..d8f9bc68e3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -574,6 +574,7 @@ typedef enum {
>   #define HSTATUS_VTW          0x00200000
>   #define HSTATUS_VTSR         0x00400000
>   #define HSTATUS_VSXL         0x300000000
> +#define HSTATUS_HUPMM        0x3000000000000
>   
>   #define HSTATUS32_WPRI       0xFF8FF87E
>   #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
> @@ -734,6 +735,7 @@ typedef enum RISCVException {
>   #define MENVCFG_CBIE                       (3UL << 4)
>   #define MENVCFG_CBCFE                      BIT(6)
>   #define MENVCFG_CBZE                       BIT(7)
> +#define MENVCFG_PMM                        (3ULL << 32)
>   #define MENVCFG_ADUE                       (1ULL << 61)
>   #define MENVCFG_PBMTE                      (1ULL << 62)
>   #define MENVCFG_STCE                       (1ULL << 63)
> @@ -749,6 +751,7 @@ typedef enum RISCVException {
>   #define SENVCFG_CBIE                       MENVCFG_CBIE
>   #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_PMM                        MENVCFG_PMM
>   
>   #define HENVCFG_FIOM                       MENVCFG_FIOM
>   #define HENVCFG_LPE                        MENVCFG_LPE
> @@ -756,6 +759,7 @@ typedef enum RISCVException {
>   #define HENVCFG_CBIE                       MENVCFG_CBIE
>   #define HENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define HENVCFG_CBZE                       MENVCFG_CBZE
> +#define HENVCFG_PMM                        MENVCFG_PMM
>   #define HENVCFG_ADUE                       MENVCFG_ADUE
>   #define HENVCFG_PBMTE                      MENVCFG_PBMTE
>   #define HENVCFG_STCE                       MENVCFG_STCE
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d..79a114eb07 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -128,6 +128,9 @@ struct RISCVCPUConfig {
>       bool ext_ssaia;
>       bool ext_sscofpmf;
>       bool ext_smepmp;
> +    bool ext_ssnpm;
> +    bool ext_smnpm;
> +    bool ext_smmpm;
>       bool rvv_ta_all_1s;
>       bool rvv_ma_all_1s;
>       bool rvv_vl_half_avl;
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 941c9691da..5389ccb983 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -575,6 +575,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>       if (riscv_cpu_cfg(env)->ext_zkr) {
>           return RISCV_EXCP_NONE;
>       }
> +    if (riscv_cpu_cfg(env)->ext_smmpm) {
> +        return RISCV_EXCP_NONE;
> +    }
>   
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
> @@ -2379,6 +2382,12 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>           if (env_archcpu(env)->cfg.ext_zicfiss) {
>               mask |= MENVCFG_SSE;
>           }
> +
> +        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +        if (env_archcpu(env)->cfg.ext_smnpm &&
> +            get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
> +            mask |= MENVCFG_PMM;
> +        }
>       }
>       env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
>   
> @@ -2425,6 +2434,12 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
>   {
>       uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
>       RISCVException ret;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +    if (env_archcpu(env)->cfg.ext_ssnpm &&
> +        riscv_cpu_mxl(env) == MXL_RV64 &&
> +        get_field(val, SENVCFG_PMM) != PMM_FIELD_RESERVED) {
> +        mask |= SENVCFG_PMM;
> +    }
>   
>       ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
>       if (ret != RISCV_EXCP_NONE) {
> @@ -2489,6 +2504,12 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>               get_field(env->menvcfg, MENVCFG_SSE)) {
>               mask |= HENVCFG_SSE;
>           }
> +
> +        /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +        if (env_archcpu(env)->cfg.ext_ssnpm &&
> +            get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {
> +            mask |= HENVCFG_PMM;
> +        }
>       }
>   
>       env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
> @@ -3525,7 +3546,15 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
>   static RISCVException write_hstatus(CPURISCVState *env, int csrno,
>                                       target_ulong val)
>   {
> -    env->hstatus = val;
> +    uint64_t mask = (target_ulong)-1;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +    if (!env_archcpu(env)->cfg.ext_ssnpm ||
> +        riscv_cpu_mxl(env) != MXL_RV64 ||
> +        get_field(val, HSTATUS_HUPMM) == PMM_FIELD_RESERVED) {
> +        mask &= ~HSTATUS_HUPMM;
> +    }
> +    env->hstatus = (env->hstatus & ~mask) | (val & mask);
> +
>       if (riscv_cpu_mxl(env) != MXL_RV32 && get_field(val, HSTATUS_VSXL) != 2) {
>           qemu_log_mask(LOG_UNIMP,
>                         "QEMU does not support mixed HSXLEN options.");
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a1b36664fc..a185c246d6 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -575,6 +575,13 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>   void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   {
>       int i;
> +    uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
> +    /* Update PMM field only if the value is valid according to Zjpm v1.0 */
> +    if (riscv_cpu_cfg(env)->ext_smmpm &&
> +        riscv_cpu_mxl(env) == MXL_RV64 &&
> +        get_field(val, MSECCFG_PMM) != PMM_FIELD_RESERVED) {
> +        mask |= MSECCFG_PMM;
> +    }
>   
>       trace_mseccfg_csr_write(env->mhartid, val);
>   
> @@ -590,12 +597,13 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
>   
>       if (riscv_cpu_cfg(env)->ext_smepmp) {
>           /* Sticky bits */
> -        val |= (env->mseccfg & (MSECCFG_MMWP | MSECCFG_MML));
> -        if ((val ^ env->mseccfg) & (MSECCFG_MMWP | MSECCFG_MML)) {
> +        val |= (env->mseccfg & mask);
> +        if ((val ^ env->mseccfg) & mask) {
>               tlb_flush(env_cpu(env));
>           }
>       } else {
> -        val &= ~(MSECCFG_MMWP | MSECCFG_MML | MSECCFG_RLB);
> +        mask |= MSECCFG_RLB;
> +        val &= ~(mask);
>       }
>   
>       /* M-mode forward cfi to be enabled if cfi extension is implemented */
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index e0530a17a3..271cf24169 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -46,6 +46,7 @@ typedef enum {
>       MSECCFG_USEED = 1 << 8,
>       MSECCFG_SSEED = 1 << 9,
>       MSECCFG_MLPE =  1 << 10,
> +    MSECCFG_PMM = 3ULL << 32,
>   } mseccfg_field_t;
>   
>   typedef struct {


