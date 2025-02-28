Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C08C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 11:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnyLJ-00089v-VB; Fri, 28 Feb 2025 06:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tnyLH-0007yR-MX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:15:43 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tnyLE-00019O-HZ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 06:15:42 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2234e4b079cso36658315ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 03:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740741339; x=1741346139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L16fcBbyZG+Y6ckrTzBypDNcXWSmq/MVMYwi2coni2s=;
 b=hFISyfmJaRaFVBkEGxKqZE9RLrjOD3CdJ2qXUHeNWSpPnGd9LxeDrA/EN4F0TQ7kkE
 H2SxlrpgjvuVMUTD3Xxg1n9bEgWeNF1/YOKlwEnPNZcjJ7aA5U6tsD+MlMPG57NMiqTv
 /vrlG3nKTLV3RB4PBTkpCqRrhKO+lnwQDoSEH9rR0o6m+nFUeE09IVMGi2MVRGL5+tkC
 mWEA+3CkCTmYymXMwzHu8EwIlSEP/WsT2ooJZWc1EbgBxFTtcW5MsO2Cn2JHZz5ue0lC
 jn/+hlqbPsmpdZ0Rqu0AIC8IhIs3twGkM1qhB3ES1q/GRanQgPQTA2H2GYj4PH3Dl3C5
 0GEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740741339; x=1741346139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L16fcBbyZG+Y6ckrTzBypDNcXWSmq/MVMYwi2coni2s=;
 b=jFzuIv8JWIo+AePkTe5v6J7gHdOIRGHOJRGJ+5R7i+KmLvAS+UrRZxCsR1K64klWFC
 5UT4ajhFSqgziFgjVJAYuEfzyKjtHXjOJY5882NGEuy5ef+cBZGDm0XN2OKcmH9Rm6sW
 CDWrfIvQoHWon+dP4F/sBLJadd5PeQGiaxmQlEIIdkGcqwO4mvI34KnB044uvrYAA0vO
 B6uhMACLWaSxc37hUuTLuON7RIavjaj2RoxtRADja0v/lkYY6pcdhIHMpPdYU5ygGwBt
 KvuAS5iZ5cAa4IaVhJ4kDJ/y5YMI7kO+dYwvXhMh3sQvp3HJ/QejztMrBP1NwCEhWhIC
 2o7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbx+cnly7XTjl5/YygfJor+X+b7nI5rSntKXJjEwRzQPllLTqLDKkyG1QhENnk9OngU+vO6HAMInzB@nongnu.org
X-Gm-Message-State: AOJu0Yy9DjOJC1YV9xROT1lG4lNM2O16xaaedsVv5uvtupT2YsKS5Zew
 HRVisHtIv8BaV5DtVtygL8e6xUAcNmm+lPs5hfpNAUwGxSGmFCrSuqdgchQHwZc=
X-Gm-Gg: ASbGnct+2I/TkKIn4L+b1UFGHa2b5xLhc1p5NmagJ7mx/ZlZh9oReUnQE6cjVMuK2fb
 mAwaMUhbQO4hSAOx1Q8Az94JuVa4BMuuNY0f8/P3zKXAhzft549+4AiKozX86D/Tdi+AzDIY1Y0
 A0eIh98uYT1q5yRNlwu1IHtfUS94QjUHXN9Db4bp9BjdG8xLb/6hCrajsxLCc7AhoL7csSzg3cT
 fKSJ+qqX+gyoh+dyVp5uP0nMQynemiP3VxJVSk+x+AMSyttU2ShFxtcSmc7ZA/rg0HZhJX9vSYP
 Vm7MsBjIDD3yvUGU8CdMX9mu5SsCgCeKTAQRQ3kY5fXB6f9UcOLuAKAIoNrCgFzgNIwa3JwpjxE
 sg1ta
X-Google-Smtp-Source: AGHT+IGrFztTcFcO4rprxzE1CDaaeTy+B6CgwA/kBWXxf2wSAqQgYIJXRo+fx5vwS7bMkAfKoXHvRA==
X-Received: by 2002:a17:902:cec1:b0:21f:801a:9be1 with SMTP id
 d9443c01a7336-2236920baa4mr47490565ad.33.1740741338882; 
 Fri, 28 Feb 2025 03:15:38 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:8aab:3274:6ac1:70e0:b96f?
 ([2804:7f0:bcc0:8aab:3274:6ac1:70e0:b96f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d5247sm30549165ad.26.2025.02.28.03.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 03:15:38 -0800 (PST)
Message-ID: <005b2087-278b-48e1-abc6-56b9f222af5c@ventanamicro.com>
Date: Fri, 28 Feb 2025 08:15:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Add scontext CSR handling
To: Florian Lugou <florian.lugou@provenrun.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20250226143914.769112-1-florian.lugou@provenrun.com>
 <20250226143914.769112-2-florian.lugou@provenrun.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250226143914.769112-2-florian.lugou@provenrun.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 2/26/25 11:39 AM, Florian Lugou wrote:
> scontext size is 16 bits on RV32 and 32 bits on RV64, as recommended by
> version 1.0 2025-02-21 of the debug specification.
> 
> When the Smstateen extension is implemented, accessibility to the
> scontext CSR is controlled by bit 57 of the [mh]stateen0 CSRs.
> 
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> ---

Can you please rebase these patches on top of the maintainer's tree:

https://github.com/alistair23/qemu/tree/riscv-to-apply.next

This patch will have a conflict on cpu_bits.h in that tree.


Looks good otherwise. Thanks,

Daniel


>   target/riscv/cpu.h      |  1 +
>   target/riscv/cpu_bits.h |  5 +++++
>   target/riscv/csr.c      | 36 ++++++++++++++++++++++++++++++++++++
>   target/riscv/debug.c    |  1 +
>   4 files changed, 43 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97713681cb..e47200f409 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -430,6 +430,7 @@ struct CPUArchState {
>       target_ulong tdata2[RV_MAX_TRIGGERS];
>       target_ulong tdata3[RV_MAX_TRIGGERS];
>       target_ulong mcontext;
> +    target_ulong scontext;
>       struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>       struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
>       QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f97c48a394..add0bb9d0e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -247,6 +247,9 @@
>   #define CSR_SIEH            0x114
>   #define CSR_SIPH            0x154
>   
> +/* Supervisor-Level Sdtrig CSRs (debug) */
> +#define CSR_SCONTEXT        0x5a8
> +
>   /* Hpervisor CSRs */
>   #define CSR_HSTATUS         0x600
>   #define CSR_HEDELEG         0x602
> @@ -959,4 +962,6 @@ typedef enum RISCVException {
>   #define MCONTEXT64                         0x0000000000001FFFULL
>   #define MCONTEXT32_HCONTEXT                0x0000007F
>   #define MCONTEXT64_HCONTEXT                0x0000000000003FFFULL
> +#define SCONTEXT32                         0x0000FFFF
> +#define SCONTEXT64                         0x00000000FFFFFFFFULL
>   #endif
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f07..1c1ac8ed67 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3221,6 +3221,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_P1P13;
>       }
>   
> +    if (riscv_cpu_cfg(env)->debug) {
> +        wr_mask |= SMSTATEEN0_HSCONTXT;
> +    }
> +
>       if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
>           wr_mask |= SMSTATEEN0_SVSLCT;
>       }
> @@ -5053,6 +5057,35 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static RISCVException read_scontext(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    *val = env->scontext;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_scontext(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
> +{
> +    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
> +
> +    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Spec suggest 16-bit for RV32 and 34-bit for RV64 */
> +    target_ulong mask = rv32 ? SCONTEXT32 : SCONTEXT64;
> +
> +    env->scontext = val & mask;
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
>                                        target_ulong *val)
>   {
> @@ -5705,6 +5738,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SIEH]       = { "sieh",   aia_smode32, NULL, NULL, rmw_sieh },
>       [CSR_SIPH]       = { "siph",   aia_smode32, NULL, NULL, rmw_siph },
>   
> +    /* Supervisor-Level Sdtrig CSRs (debug) */
> +    [CSR_SCONTEXT]   = { "scontext", debug, read_scontext, write_scontext },
> +
>       [CSR_HSTATUS]     = { "hstatus",     hmode,   read_hstatus, write_hstatus,
>                             .min_priv_ver = PRIV_VERSION_1_12_0                },
>       [CSR_HEDELEG]     = { "hedeleg",     hmode,   read_hedeleg, write_hedeleg,
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index f6241a80be..914a9ce0f8 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -1086,4 +1086,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
>       }
>   
>       env->mcontext = 0;
> +    env->scontext = 0;
>   }


