Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA72E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 21:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJfYX-00080Y-3b; Fri, 06 Dec 2024 16:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJfYV-000805-J4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:08:07 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJfYT-0008BT-S8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:08:07 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-72590a998b4so2910056b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733519284; x=1734124084; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yx+UghVBfC0qS4Zvk62bDBjDv9ksqhxMyUgZnBB8r64=;
 b=gkoo2G+vx/SXoYy8XJbHgdF9uHMJID53IcuV8/voTGuUgud32DgNfroJ/aK6Gwnm8j
 XNQCOlSH80cepnQZ3jZF15+/2+asSBEkGBzhLhso2KKFGQ9QH2f60oCB2EZq8/yqOpQ4
 i6q/M6/Gcp3phCFRAf5Lo4SFMqy2+Q20scynebbgV5cgLkhD2240uUsR1c5JGq5HOCVK
 WCmSkchwJAqg99oC69zcD7ICnvRH+3lHZvecn2PLlyM/lXMhxTt6n2a2YsiOcm6lM8FS
 u0FHo0Rm2nj25DBGf+wF7WkERwj7CmaCFkTy63zUoe2bTkZXNgeAZ4jUQrlwNuChJKtL
 hgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733519284; x=1734124084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yx+UghVBfC0qS4Zvk62bDBjDv9ksqhxMyUgZnBB8r64=;
 b=oc/FEv16uC+BSE3IrvQXKVTtvfW5cQ4ae5xXv/y+5C2e3vQvsMdtFxhNz00wW3o/LH
 gIDUDjgfd8FliwKKMJVATAdGSjTAwu7TvfpNtugDzMrw9Vts3FbJ5n9M0BEwLX00v/bV
 f3/cWl084sKr1UKSq32aXJFuc7CIRYBbcWE47hi3r0my2zeiVxTHIe4W9SL7rK7hxWFE
 DcAp2mVimpyIcVGmRUYoeE86IRfED1HchgJqSj7N1tm7C2UcJfnH/ok3teM03IfNAty3
 jMHh2KCq+zT6uljpM788uRFohIASN2XEK1pcbx3IQ/fIrps+IxwUHt4PtornJzIvHjr+
 a4/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3etXm38/HHuh/vL9Q7AZFwXboD42H/JvrstU8FUHg5Mdsd2onAVj+IkunwJPAQYhzN7R8wSnqOYo9@nongnu.org
X-Gm-Message-State: AOJu0YzIy9MRY3YWWiueONvXpzB8BvFhBt3w4omgS8Jac51r4VBspS2S
 C7XRMLkVcV+s6lweisLxq0gMye9mBUAaJfXTvga19ObqC4aGrS7u10PzgwRMLYHwJxB0LC65tIY
 Q
X-Gm-Gg: ASbGncv0FtOHNqhR8HwVBe0WvsA17IxDsAdqFbUYrCkph4663nAwRIUJrTWoaXBFNxg
 Y9JGtEDGnMuvNoTLUP9XIOsBo/A8ZrDe8MkOKyLsfapuvqBFyGGNR+LUf58QfJmPCSZdnQzEX5o
 xUw79NjecL+uFSt9vITpwU6vzyMWVXEsG7bkjV5M9smupKx6J23OnK/Cl/u/S2zc3UjDHhEl7Bk
 rJ2WY1fflHgwyBCkhCpk7T08iVqk6O3E1D9+w1Q5EOwvPW+Fl9lqWobT90SAsC3/nOEYFwIC3jz
 SxZjz1hhpxQw3d16xZlqnEs=
X-Google-Smtp-Source: AGHT+IGdTHZQT9j0f6dWLesK8zOwxAPuJEdpt2b+gGDOH0dqMuG/QvRm/60q/0xbHBdREimvPtRN0A==
X-Received: by 2002:a17:903:18b:b0:215:b18d:ca with SMTP id
 d9443c01a7336-215f3ce4f1cmr142930475ad.18.1733519283924; 
 Fri, 06 Dec 2024 13:08:03 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:b984:11b:9da2:696:f7f6?
 ([2804:7f0:bcc0:b984:11b:9da2:696:f7f6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f0922fsm32054545ad.205.2024.12.06.13.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 13:08:03 -0800 (PST)
Message-ID: <9f616eaf-11fd-4772-9e7f-2404059419bb@ventanamicro.com>
Date: Fri, 6 Dec 2024 18:07:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
 <20241205112304.593204-4-baturo.alexey@gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241205112304.593204-4-baturo.alexey@gmail.com>
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



On 12/5/24 8:23 AM, baturo.alexey@gmail.com wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
> 
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
> ---
>   target/riscv/cpu.h        |  5 +++
>   target/riscv/cpu_helper.c | 74 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 79 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 417ff45544..74d7076f5a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>   
>   bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>   
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm);
> +
>   RISCVException riscv_csrr(CPURISCVState *env, int csrno,
>                             target_ulong *ret_value);
> +
>   RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
>                              target_ulong *ret_value,
>                              target_ulong new_value, target_ulong write_mask);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dba04851d5..2558f869f2 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -214,6 +214,80 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       *pflags = flags;
>   }
>   
> +RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
> +{
> +    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
> +#ifndef CONFIG_USER_ONLY
> +    if (get_field(env->mstatus, MSTATUS_MPRV) &&
> +        get_field(env->mstatus, MSTATUS_MXR)) {
> +        return pmm;
> +    }
> +    int priv_mode = cpu_address_mode(env);
> +    /* Get current PMM field */
> +    switch (priv_mode) {
> +    case PRV_M:
> +        if (riscv_cpu_cfg(env)->ext_smmpm) {
> +            pmm = get_field(env->mseccfg, MSECCFG_PMM);
> +        }
> +        break;
> +    case PRV_S:
> +        if (riscv_cpu_cfg(env)->ext_smnpm) {
> +            if (get_field(env->mstatus, MSTATUS_MPV)) {
> +                pmm = get_field(env->henvcfg, HENVCFG_PMM);
> +            } else {
> +                pmm = get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    case PRV_U:
> +        if (riscv_has_ext(env, RVS)) {
> +            if (riscv_cpu_cfg(env)->ext_ssnpm) {
> +                pmm = get_field(env->senvcfg, SENVCFG_PMM);
> +            }
> +        } else {
> +            if (riscv_cpu_cfg(env)->ext_smnpm) {
> +                pmm = get_field(env->menvcfg, MENVCFG_PMM);
> +            }
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +#endif
> +    return pmm;
> +}
> +
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +{
> +    bool virt_mem_en = false;
> +#ifndef CONFIG_USER_ONLY
> +    int satp_mode = 0;
> +    int priv_mode = cpu_address_mode(env);
> +    if (riscv_cpu_mxl(env) == MXL_RV32) {
> +        satp_mode = get_field(env->satp, SATP32_MODE);
> +    } else {
> +        satp_mode = get_field(env->satp, SATP64_MODE);
> +    }
> +    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
> +#endif
> +    return virt_mem_en;
> +}
> +
> +int riscv_pm_get_pmlen(RISCVPmPmm pmm)
> +{
> +    switch (pmm) {
> +    case PMM_FIELD_DISABLED:
> +        return 0;
> +    case PMM_FIELD_PMLEN7:
> +        return 7;
> +    case PMM_FIELD_PMLEN16:
> +        return 16;
> +    default:
> +        g_assert_not_reached();
> +    }
> +    return -1;

You don't need a 'return -1' here since all possible return values are already
covered in the 'switch' and the default label is using g_assert_not_reached(),
i.e. you'll never return -1. The compiler will be fine with it - we use this
kind of pattern all the time (cpu_get_fcfien() does this in this same file).

You can remove the -1 return and even turn the helper to uint32_t. That way
the caller knows that there's no need to handle negative values.


Thanks,

Daniel


> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   
>   /*


