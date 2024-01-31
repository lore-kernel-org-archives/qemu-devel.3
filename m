Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08845C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 18:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVFhq-0002vJ-Fp; Wed, 31 Jan 2024 13:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVFhl-0002t3-KN
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:53:01 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVFhh-0007Nv-Hm
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 13:53:00 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso131272a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 10:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706727175; x=1707331975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97wavAqT0rueOYMNlP5/i+lJVRTHTL6X6btc+QkPCQQ=;
 b=MPcikENF3tafMKCz3/bIw6/V7CLhSPaPp0dA1yHjOUkU4zz/IHzare5JMasvTJg8nS
 9/vu9EAqwgu/8tl0ChoUZOQVFAQWkMlFlDdTHJy09eobuXoaI3NXEGAQeTV7EEsRb+M6
 upvxxLnDozkGxFNsNR5/r7dbfKHWxnIRN18bjtWAEfCD/5UY4Q4tj6lux6CHk+vw2zLb
 CpxOqpyD6pjPhmvCorIQFlyeenuhFpT/1YBDac+4GBKPqjng0lBV4IOrOyhnL9j9ZxcD
 7cD+J7+FTuEVzudMwtnoQT65wkJH0e9dNy7/1G/Lth7oK79hCiupINLWFFLi+YVsFx8x
 XvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706727175; x=1707331975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97wavAqT0rueOYMNlP5/i+lJVRTHTL6X6btc+QkPCQQ=;
 b=R8k72JuraN6AqVy/znBjblYXgA1Ixa7T4ARY0KRt1E/R6kbgIldRof2yqn2qnxWI6P
 OnHGd0g0gcqHGo6QspH0RG4GRrxHMjKDp2YPIbg3eJz/bJrmmyYMFMrl0cz9+pqirn5n
 KmpBKBBY+soQAG92e5LRTlXgm5P6vyUStOLSEMrcl1c22jiuAlr45Ext/6NukNPG7930
 75RKmlQOKxH2YG483HT6axEgoroo+vqalMTonS7mdpDTTSJeyaPkxdxGQmsonV8tHad7
 WZODrW0Cp/ZkxjFW3Os05aPc19v37IZuCY4gB8jZK74T+WvVBVpd2ZHhCjNURXLXokuu
 +kXA==
X-Gm-Message-State: AOJu0YyYcSeukwJkw3BIQGGbnHPstMjkEnbQd8lN/uW2l4ote1dY04dO
 uAsX/QTWsdZQZ2ahskKypCIvqyA7x+Kyhx8qAgkAW4Pzf9ShGYr1lNcgR9MSmAU=
X-Google-Smtp-Source: AGHT+IEqxXsOUEyS8PAekEg1Xwo1JXcbrcbl3uYXj7lD1rEgfjf2C5Dsib0OsPvvvzQRBrLwU303xw==
X-Received: by 2002:a05:6a20:2a15:b0:19e:2d02:56c3 with SMTP id
 e21-20020a056a202a1500b0019e2d0256c3mr2298375pzh.6.1706727174591; 
 Wed, 31 Jan 2024 10:52:54 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a056a0023c400b006dbc5569599sm10538626pfc.10.2024.01.31.10.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 10:52:54 -0800 (PST)
Message-ID: <417547b8-3149-4667-b8d3-bd761c09b406@ventanamicro.com>
Date: Wed, 31 Jan 2024 15:52:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use RISCVException as return type for all
 csr ops
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, philmd@linaro.org
References: <20240130110844.437-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240130110844.437-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/30/24 08:08, LIU Zhiwei wrote:
> The real return value type has been converted to RISCVException,
> but some function declarations still not. This patch makes all
> csr operation declarations use RISCVExcetion.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

There's a trivial conflict down there due to the vlen->vlenb changes that
got merged recently in riscv-to-apply.next.

As for the patch:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 117 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 74 insertions(+), 43 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 674ea075a4..ac9a856cc5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -242,7 +242,7 @@ static RISCVException any32(CPURISCVState *env, int csrno)
>   
>   }
>   
> -static int aia_any(CPURISCVState *env, int csrno)
> +static RISCVException aia_any(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_smaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -251,7 +251,7 @@ static int aia_any(CPURISCVState *env, int csrno)
>       return any(env, csrno);
>   }
>   
> -static int aia_any32(CPURISCVState *env, int csrno)
> +static RISCVException aia_any32(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_smaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -269,7 +269,7 @@ static RISCVException smode(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> -static int smode32(CPURISCVState *env, int csrno)
> +static RISCVException smode32(CPURISCVState *env, int csrno)
>   {
>       if (riscv_cpu_mxl(env) != MXL_RV32) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -278,7 +278,7 @@ static int smode32(CPURISCVState *env, int csrno)
>       return smode(env, csrno);
>   }
>   
> -static int aia_smode(CPURISCVState *env, int csrno)
> +static RISCVException aia_smode(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -287,7 +287,7 @@ static int aia_smode(CPURISCVState *env, int csrno)
>       return smode(env, csrno);
>   }
>   
> -static int aia_smode32(CPURISCVState *env, int csrno)
> +static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -496,7 +496,7 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
>       return RISCV_EXCP_ILLEGAL_INST;
>   }
>   
> -static int aia_hmode(CPURISCVState *env, int csrno)
> +static RISCVException aia_hmode(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -505,7 +505,7 @@ static int aia_hmode(CPURISCVState *env, int csrno)
>        return hmode(env, csrno);
>   }
>   
> -static int aia_hmode32(CPURISCVState *env, int csrno)
> +static RISCVException aia_hmode32(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia) {
>           return RISCV_EXCP_ILLEGAL_INST;
> @@ -681,7 +681,8 @@ static RISCVException read_vl(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_vlenb(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vlenb(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>   {
>       *val = riscv_cpu_cfg(env)->vlen >> 3;
>       return RISCV_EXCP_NONE;
> @@ -742,13 +743,15 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_vcsr(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vcsr(CPURISCVState *env, int csrno,
> +                                target_ulong *val)
>   {
>       *val = (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_SHIFT);
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_vcsr(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_vcsr(CPURISCVState *env, int csrno,
> +                                 target_ulong val)
>   {
>   #if !defined(CONFIG_USER_ONLY)
>       env->mstatus |= MSTATUS_VS;
> @@ -798,13 +801,15 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>   {
>       *val = get_ticks(false);
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
>   {
>       *val = get_ticks(true);
>       return RISCV_EXCP_NONE;
> @@ -812,7 +817,8 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
>   
>   #else /* CONFIG_USER_ONLY */
>   
> -static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>   {
>       int evt_index = csrno - CSR_MCOUNTINHIBIT;
>   
> @@ -821,7 +827,8 @@ static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>   {
>       int evt_index = csrno - CSR_MCOUNTINHIBIT;
>       uint64_t mhpmevt_val = val;
> @@ -837,7 +844,8 @@ static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_mhpmeventh(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>   {
>       int evt_index = csrno - CSR_MHPMEVENT3H + 3;
>   
> @@ -846,7 +854,8 @@ static int read_mhpmeventh(CPURISCVState *env, int csrno, target_ulong *val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
> +                                       target_ulong val)
>   {
>       int evt_index = csrno - CSR_MHPMEVENT3H + 3;
>       uint64_t mhpmevth_val = val;
> @@ -860,7 +869,8 @@ static int write_mhpmeventh(CPURISCVState *env, int csrno, target_ulong val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
> +                                        target_ulong val)
>   {
>       int ctr_idx = csrno - CSR_MCYCLE;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> @@ -885,7 +895,8 @@ static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
> +                                         target_ulong val)
>   {
>       int ctr_idx = csrno - CSR_MCYCLEH;
>       PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
> @@ -945,7 +956,8 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
>   {
>       uint16_t ctr_index;
>   
> @@ -960,7 +972,8 @@ static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
>       return riscv_pmu_read_ctr(env, val, false, ctr_index);
>   }
>   
> -static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
>   {
>       uint16_t ctr_index;
>   
> @@ -975,7 +988,8 @@ static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
>       return riscv_pmu_read_ctr(env, val, true, ctr_index);
>   }
>   
> -static int read_scountovf(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_scountovf(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>   {
>       int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
>       int i;
> @@ -1638,7 +1652,8 @@ static RISCVException rmw_mvienh(CPURISCVState *env, int csrno,
>       return ret;
>   }
>   
> -static int read_mtopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_mtopi(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>   {
>       int irq;
>       uint8_t iprio;
> @@ -1678,8 +1693,9 @@ static int aia_xlate_vs_csrno(CPURISCVState *env, int csrno)
>       };
>   }
>   
> -static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
> -                        target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
> +                                   target_ulong *val, target_ulong new_val,
> +                                   target_ulong wr_mask)
>   {
>       target_ulong *iselect;
>   
> @@ -1758,8 +1774,9 @@ static int rmw_iprio(target_ulong xlen,
>       return 0;
>   }
>   
> -static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
> -                     target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> +                                target_ulong *val, target_ulong new_val,
> +                                target_ulong wr_mask)
>   {
>       bool virt, isel_reserved;
>       uint8_t *iprio;
> @@ -1833,8 +1850,9 @@ done:
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int rmw_xtopei(CPURISCVState *env, int csrno, target_ulong *val,
> -                      target_ulong new_val, target_ulong wr_mask)
> +static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
> +                                 target_ulong *val, target_ulong new_val,
> +                                 target_ulong wr_mask)
>   {
>       bool virt;
>       int ret = -EINVAL;
> @@ -3031,7 +3049,8 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vstopi(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>   {
>       int irq, ret;
>       target_ulong topei;
> @@ -3120,7 +3139,8 @@ static int read_vstopi(CPURISCVState *env, int csrno, target_ulong *val)
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_stopi(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_stopi(CPURISCVState *env, int csrno,
> +                                 target_ulong *val)
>   {
>       int irq;
>       uint8_t iprio;
> @@ -3576,19 +3596,21 @@ static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hvictl(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hvictl(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>   {
>       *val = env->hvictl;
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_hvictl(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hvictl(CPURISCVState *env, int csrno,
> +                                   target_ulong val)
>   {
>       env->hvictl = val & HVICTL_VALID_MASK;
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hvipriox(CPURISCVState *env, int first_index,
> +static RISCVException read_hvipriox(CPURISCVState *env, int first_index,
>                            uint8_t *iprio, target_ulong *val)
>   {
>       int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
> @@ -3614,7 +3636,7 @@ static int read_hvipriox(CPURISCVState *env, int first_index,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int write_hvipriox(CPURISCVState *env, int first_index,
> +static RISCVException write_hvipriox(CPURISCVState *env, int first_index,
>                             uint8_t *iprio, target_ulong val)
>   {
>       int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
> @@ -3640,42 +3662,50 @@ static int write_hvipriox(CPURISCVState *env, int first_index,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_hviprio1(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hviprio1(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
>   {
>       return read_hvipriox(env, 0, env->hviprio, val);
>   }
>   
> -static int write_hviprio1(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
>   {
>       return write_hvipriox(env, 0, env->hviprio, val);
>   }
>   
> -static int read_hviprio1h(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hviprio1h(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>   {
>       return read_hvipriox(env, 4, env->hviprio, val);
>   }
>   
> -static int write_hviprio1h(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>   {
>       return write_hvipriox(env, 4, env->hviprio, val);
>   }
>   
> -static int read_hviprio2(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hviprio2(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
>   {
>       return read_hvipriox(env, 8, env->hviprio, val);
>   }
>   
> -static int write_hviprio2(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
> +                                     target_ulong val)
>   {
>       return write_hvipriox(env, 8, env->hviprio, val);
>   }
>   
> -static int read_hviprio2h(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_hviprio2h(CPURISCVState *env, int csrno,
> +                                     target_ulong *val)
>   {
>       return read_hvipriox(env, 12, env->hviprio, val);
>   }
>   
> -static int write_hviprio2h(CPURISCVState *env, int csrno, target_ulong val)
> +static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
> +                                      target_ulong val)
>   {
>       return write_hvipriox(env, 12, env->hviprio, val);
>   }
> @@ -3699,7 +3729,8 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> -static int read_vstvec(CPURISCVState *env, int csrno, target_ulong *val)
> +static RISCVException read_vstvec(CPURISCVState *env, int csrno,
> +                                  target_ulong *val)
>   {
>       *val = env->vstvec;
>       return RISCV_EXCP_NONE;

