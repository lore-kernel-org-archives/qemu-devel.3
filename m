Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52DFC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 20:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSjUQ-0003pT-DL; Wed, 24 Jan 2024 15:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjUO-0003os-QV
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:04:48 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSjUM-0005nj-TN
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 15:04:48 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce942efda5so4498350a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 12:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706126685; x=1706731485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TcvvEUmUOJhLGSOP0GKE13bG52dB7JqCEYHsc4HIS/o=;
 b=K8YcrkPeZPlS9frcA/K03oxmtCA0DRqOmjrZ792RlAY/ozKuy/VZ5YNOj+S+JRbzDg
 GeOfRU6B2V8pvj03nctp/KSo8o5x6xgCCTka7UYEpp/YhmFsUsjA2i1XVB0EO26KW6w6
 u181n6MSHdeZAAQYEoQQHd2HYZcTOXSIrEWJsoxlIvOWDe3ix2MMKrmycA9IcFw8hgtC
 8E4Pq9aMWXeO0AsYZGLYKzVJRb9p8M/cy/rB1l0HV/NLAmq1CnBJmWSoQsgxcVALqWxv
 SlvxizDAdmHw+W6Nd2Co1H4tVQCYQ7D1Uvm6CnGXcF60rJqHOJ2Aq1UBBrZzijSnG29c
 +VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706126685; x=1706731485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TcvvEUmUOJhLGSOP0GKE13bG52dB7JqCEYHsc4HIS/o=;
 b=SY7u2hvAIRyK4XnB7THkLA8vXz04alXkBBlqtC9k5At1JabcbP+8orwE3O/J7Mcg/L
 q/5A1fJN0Dp6PCi7Hvy5CKkktgS/12MDgZsfBZRqcJd70HksH/HLjC6tK580bi3kWdPN
 MKyE/HRoHcqN+zGofrX0hGreQElk3z0UcyYmxp4eGGJD24p4awtaJG1YBbMNJHoA7kVh
 qaMrktut30j1s7A7/kDH10mtjrQ3idAb6JAlE09Pdct7jpHF/3KZj5MtQknqHcDOzVJh
 PSN/gc9tnfS84p3plfJpFxE8GsDqUFGOyrm4ZFFVX2wuQnrKTckiWLg8DfoJRQcFTn8m
 pSrg==
X-Gm-Message-State: AOJu0YwWTqFQaultH3kufTjhJWfbe1ooaREIjzAjAlAyB83xVBEc5+9W
 SbmZ628TAqzY6zejhoQLSiIVdY8oqj/zOugoS+hMVUlaHUg0tNgRZiI6nHcU8ig=
X-Google-Smtp-Source: AGHT+IFBNH2JOb+HkKfQWimA0hg/iE5eAaf55qpqq22/PIAfGc5hvld2z/gHUyMOp8Ye4XFSyEp08w==
X-Received: by 2002:a05:6a20:5618:b0:19b:7ccb:2140 with SMTP id
 ir24-20020a056a20561800b0019b7ccb2140mr1363069pzc.105.1706126685443; 
 Wed, 24 Jan 2024 12:04:45 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 i192-20020a639dc9000000b005d6323da62esm14262pgd.84.2024.01.24.12.04.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 12:04:45 -0800 (PST)
Message-ID: <61d7fcf6-6b7a-4d19-a6f9-74713b31bc40@ventanamicro.com>
Date: Wed, 24 Jan 2024 17:04:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] target/riscv: use misa_mxl_max to populate isa
 string rather than TARGET_LONG_BITS
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, qemu-riscv@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Andrew Jones <ajones@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20240124-squatting-getup-a16a8499ad73@spud>
 <20240124-swear-monthly-56c281f809a6@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240124-swear-monthly-56c281f809a6@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
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



On 1/24/24 09:55, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A cpu may not have the same xlen as the compile time target, and
> misa_mxl_max is the source of truth for what the hart supports.
> 
> The conversion from misa_mxl_max to xlen already has one user, so
> introduce a helper and use that to populate the isa string.
> 
> Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d7@orel/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> I dropped the tags since I added the helper
> ---
>   target/riscv/cpu.c     | 9 ++++++++-
>   target/riscv/cpu.h     | 1 +
>   target/riscv/gdbstub.c | 2 +-
>   3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ad1df2318b..4aa4b2e988 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -307,6 +307,11 @@ void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL mxl, uint32_t ext)
>       env->misa_ext_mask = env->misa_ext = ext;
>   }
>   
> +int riscv_cpu_max_xlen(CPURISCVState env)
> +{
> +    return 16 << env.misa_mxl_max;
> +}
> +
>   #ifndef CONFIG_USER_ONLY
>   static uint8_t satp_mode_from_str(const char *satp_mode_str)
>   {
> @@ -2332,7 +2337,9 @@ char *riscv_isa_string(RISCVCPU *cpu)
>       int i;
>       const size_t maxlen = sizeof("rv128") + sizeof(riscv_single_letter_exts);
>       char *isa_str = g_new(char, maxlen);
> -    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
> +    int xlen = riscv_cpu_max_xlen(cpu->env);
> +    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
> +
>       for (i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
>           if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
>               *p++ = qemu_tolower(riscv_single_letter_exts[i]);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 05e83c4ac9..aacc031397 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -511,6 +511,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                           MMUAccessType access_type, int mmu_idx,
>                           bool probe, uintptr_t retaddr);
>   char *riscv_isa_string(RISCVCPU *cpu);
> +int riscv_cpu_max_xlen(CPURISCVState env);
>   bool riscv_cpu_option_set(const char *optname);
>   
>   #define cpu_mmu_index riscv_cpu_mmu_index
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 58b3ace0fe..f15980fdcf 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -218,7 +218,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
>       CPURISCVState *env = &cpu->env;
>       GString *s = g_string_new(NULL);
>       riscv_csr_predicate_fn predicate;
> -    int bitsize = 16 << env->misa_mxl_max;
> +    int bitsize = riscv_cpu_max_xlen(*env);
>       int i;
>   
>   #if !defined(CONFIG_USER_ONLY)

