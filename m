Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B6C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukj65-0006tA-2n; Sat, 09 Aug 2025 08:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj61-0006sA-FI
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:54:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj5z-0007gt-NS
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:54:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso3597642b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754744086; x=1755348886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OHSHVM4BX9gQuWGmG9I3g12PhV94dHriipTlEkZhR5Q=;
 b=B5taQEI4LOZcxeQQqQCovyF19A9NQIAHe5TVeDUFFlu1REdRjuhVvWrqBDVRmx86TN
 FctLdrlgKUDWUUL26t88sRDpUmnNFX/mU3Uh9vVwIiWUetS4qf74wZPRbxQwHVaY47va
 ms+jWWMoy6fkC014Nyt+tDIAujTElFw7qgK+VMXTkVPs6lQfgkFAk5wlo4ba+dB/wtPc
 rdko4u0hfA8RQT+pR/rAP353UqkPXqXmRzZFov5yPeiYEg+Nr7hKFNSO8rkzSuc120O3
 EbYVpqVva3X/3bqwjLPSJbqtYtn+uTuLCHjF9X7aU93GhGL9O4c9G+oK6iPp0B2lxlwp
 cLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754744086; x=1755348886;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OHSHVM4BX9gQuWGmG9I3g12PhV94dHriipTlEkZhR5Q=;
 b=OKEp293WbV0mPdq/3V5mNZCi613RR9gfBww/lSbHUrKFJzE5pUpG/JCrJGIs0kuylj
 /npO8VHW7v2LhkCmnrty+Fewef12cnrPGSXqTfVk7W6rxje5Yg3ZDzg8sCA9c7GC0Gai
 4UpX1oycdXLDxvOirwSi5K1U/kYw91EopdVau3TWxp2ivA/GzY+CzNM7xhT+7Z7kSVKF
 /6YR/HyLAMu0lZVt1oF8fcYErx96aBLkZy8Xgz3q5fOEFQCFfdIgLozOWpR9/YO6KQO1
 YW2DV1rvEd6HCeXfRWHrUt0gP+l3BJ3QzrWE26AKshD1D4Wqmf2+vOhaZ50PW2a+3rps
 I+SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs5/VMphoME621amcKgIKWPf1zXVxg9WUzvSfZkUFBvARPvk2P6jTnZuN47QQ1eQQhZP8b9vaYOfDW@nongnu.org
X-Gm-Message-State: AOJu0YyVbL/xDwExbZRqWHSajx10YEUWrKPWzJyEhY86clJyjqId/T+n
 zwRzpbqwfQSuUJz9lrPQiEjsVQFjYimqMvu8G+t0whEdQyNZPWGBsYmbwrfU6qeMxZw=
X-Gm-Gg: ASbGncvCC7dMB/0HeAzXgZUUYOD/GC1BPkGDmEh1vTGtRQVlVOP79oqftMUhnV7JRL0
 BEuk94/YP2bLHvw5ITCftK4odqF/ScOPD66W6NHAwOLWtdbqtJIOTBwkz+GMRx6MfM1HitYSQ8o
 8x98eMBjc0AiviPFS/PS6wmH3BQZJknbVtuecO38cBmYwxbOjytWeWu4kPf8/xY5e48CYNdG3W2
 rBOy5SC4J8FvCY+m9T4/5NTj3QfOeaNNgKR8rut3bE/XzL4EQKN6ve5DtVVTvLzQhRdg2lRbIKO
 WjcCmgO4Gw9dFv9/X4mv9gBfztDizq45aLGRdpQo8KAMyBiwugNgb2RiUM3fDw+8O8Gtzi5nVWI
 13cxLPI9W3KQtryQ2lR8/OYtTiRiG6/TRMDie3w==
X-Google-Smtp-Source: AGHT+IFLh67/O0uvgoe5wDv4EaEEgGedpQ6dbfyUJUMh2CBsS6ETO7HmA9utzuXalCMAnAaOilOmvQ==
X-Received: by 2002:a05:6a20:548d:b0:240:2421:b912 with SMTP id
 adf61e73a8af0-240551f3000mr9560591637.37.1754744086107; 
 Sat, 09 Aug 2025 05:54:46 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c61b958b0sm1534885b3a.44.2025.08.09.05.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:54:45 -0700 (PDT)
Message-ID: <15f7d1c4-50ce-4cc7-913c-f25947c1b735@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:54:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] target/riscv: Implement WorldGuard CSRs
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-11-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-11-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> The WG v0.4 specification adds 3 CSRs to configure S/U/HS/VS-mode WIDs
> of CPUs in the higher privileged modes.
> 
> The Smwg extension at least requires a RISC-V HART to have M/U-mode, and
> the Sswg/Smwgd extension at least requires a RISC-V HART to have
> M/S/U-mode.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c |   4 ++
>   target/riscv/cpu.h |   5 +++
>   target/riscv/csr.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 116 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a182e8c61f..1dbeac0509 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1141,6 +1141,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>           env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
>       }
>   
> +    if (riscv_cpu_cfg(env)->ext_smwg && env->wg_reset) {
> +        env->wg_reset(env);
> +    }
> +
>       if (kvm_enabled()) {
>           kvm_riscv_reset_vcpu(cpu);
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 6dfc260a07..7bffe62f70 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -501,6 +501,11 @@ struct CPUArchState {
>       uint64_t rnmi_irqvec;
>       uint64_t rnmi_excpvec;
>   
> +    /* RISC-V WorldGuard */
> +    target_ulong mlwid;
> +    target_ulong slwid;
> +    target_ulong mwiddeleg;
> +
>       /* machine specific WorldGuard callback */
>       void (*wg_reset)(CPURISCVState *env);
>       void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7948188356..614df37d00 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5388,6 +5388,109 @@ static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
>       return RISCV_EXCP_NONE;
>   }
>   
> +/* RISC-V Worldguard */
> +static RISCVException worldguard_umode(CPURISCVState *env, int csrno)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smwg) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return umode(env, csrno);
> +}
> +
> +static RISCVException worldguard_sumode(CPURISCVState *env, int csrno)
> +{
> +    RISCVException ret;
> +
> +    if (!riscv_cpu_cfg(env)->ext_sswg) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    ret = smode(env, csrno);
> +
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    return umode(env, csrno);
> +}
> +
> +static RISCVException rmw_mlwid(CPURISCVState *env, int csrno,
> +                                target_ulong *ret_val,
> +                                target_ulong new_val, target_ulong wr_mask)
> +{
> +    CPUState *cs = env_cpu(env);
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    target_ulong new_mlwid = (env->mlwid & ~wr_mask) | (new_val & wr_mask);
> +
> +    if (ret_val) {
> +        *ret_val = env->mlwid;
> +    }
> +
> +    g_assert(cpu->cfg.mwidlist);
> +    if (!(BIT(new_mlwid) & cpu->cfg.mwidlist)) {
> +        /* Set WID to lowest legal value if writing illegal value (WARL) */
> +        new_mlwid = find_first_bit((unsigned long *)&cpu->cfg.mwidlist, 32);
> +    }
> +
> +    if (env->mlwid != new_mlwid) {
> +        env->mlwid = new_mlwid;
> +        tlb_flush(cs);
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_slwid(CPURISCVState *env, int csrno,
> +                                target_ulong *ret_val,
> +                                target_ulong new_val, target_ulong wr_mask)
> +{
> +    target_ulong new_slwid = (env->slwid & ~wr_mask) | (new_val & wr_mask);
> +
> +    if (!env->mwiddeleg) {
> +        /*
> +         * When mwiddeleg CSR is zero, access to slwid raises an illegal
> +         * instruction exception.
> +         */
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    if (ret_val) {
> +        *ret_val = env->slwid;
> +    }
> +
> +    if (!(BIT(new_slwid) & env->mwiddeleg)) {
> +        /* Set WID to lowest legal value if writing illegal value (WARL) */
> +        new_slwid = find_first_bit(
> +            (unsigned long *)&env->mwiddeleg, TARGET_LONG_BITS);
> +    }
> +
> +    if (env->slwid != new_slwid) {
> +        env->slwid = new_slwid;
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException rmw_mwiddeleg(CPURISCVState *env, int csrno,
> +                                    target_ulong *ret_val,
> +                                    target_ulong new_val, target_ulong wr_mask)
> +{
> +    CPUState *cs = env_cpu(env);
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +
> +    if (ret_val) {
> +        *ret_val = env->mwiddeleg;
> +    }
> +
> +    env->mwiddeleg = (env->mwiddeleg & ~wr_mask) | (new_val & wr_mask);
> +
> +    /* Core wgMarker can only have WID value in mwidlist. */
> +    env->mwiddeleg &= cpu->cfg.mwidlist;
> +
> +    return RISCV_EXCP_NONE;
> +}
>   #endif
>   
>   /* Crypto Extension */
> @@ -6465,5 +6568,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
>                                .min_priv_ver = PRIV_VERSION_1_12_0 },
>   
> +    /* RISC-V WorldGuard */
> +    [CSR_MLWID]     = { "mlwid",     worldguard_umode,  NULL, NULL, rmw_mlwid },
> +    [CSR_SLWID]     = { "slwid",     worldguard_sumode, NULL, NULL, rmw_slwid },
> +    [CSR_MWIDDELEG] = { "mwiddeleg", worldguard_sumode, NULL, NULL, rmw_mwiddeleg },
>   #endif /* !CONFIG_USER_ONLY */
>   };


