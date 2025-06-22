Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD1C7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 20:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTRCS-00066B-EM; Sun, 22 Jun 2025 16:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTRCN-00065t-IG
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:21:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTRCL-0004LF-IW
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 16:21:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234f17910d8so30144605ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750623711; x=1751228511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SepVEJg/UWFRK00ynHSmYrbuCfUFceQiAVIeij6fXXk=;
 b=O8Jn3LQIJXZUXesTCztvBB5vTYLF3x8FCF0YukxVni4DkDIUJu6WZJSQz9r0hA85qa
 3vYxarsb2uthjbAAg7ShGUSNcMD+h0Im/n2XFq/nK1VIGtcwd7RdLsoNVrLk+Adtr/d1
 uNaA1xmkcQqiFanDWCrecYhGk2uARXSyPX8O9Q2Woyqk2O0fmQsh1980edxLZtXhQ63U
 +RCHmcBNo+FpQe2lEG12OZw9pgmPhkkQS0U2j2I3cy6qG5WJsiHcH/FD/CdWamYH9VMu
 EE/bVZkYNINGUdNfNE4lD+nBb5usH+S2Wy5GCdtYl3LitPTil0q6oYo36Y38Piq9aaev
 qraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750623711; x=1751228511;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SepVEJg/UWFRK00ynHSmYrbuCfUFceQiAVIeij6fXXk=;
 b=WFOny5kiDinPpeeUefv/v9oli6OZywI8hLfsMGjGE4HVQBq9fMxP4VqJMGEFeWTr0I
 ou8g7nu4SGuXvUBmR2L7j1cRB7VnDVxgW437Y9y8gNMsMF78U9TEGEdl7g6GfsKc0utU
 I1xOQASGFeilf6GSbNxOx86y36FFJ2b3CQRJD0QOdmgUJdQ+S/yWk8GwuBfMuevAPsT8
 PbxB5YOm8HRk9bNJ4XjA31YNc8JsOUvuwrB5tEhR0SBSVNRw4yQk9Ic1DQXeoID4AGqg
 pYEe1bOzMt7qYmm+9RJjov0XilK/IorhTnu4VhVa9TpOcEZX+GsNbNXhU8HROe4MvmI+
 nDqw==
X-Gm-Message-State: AOJu0YyvHBN3Jh/BUJgYEUquc/zyiEx3ew20wJNgeGj9GduNju1EHHur
 kB03vvhgfIZCod/qgT0ZE7zUBuL5qSdskIOUkVgcz1n4dDYyAfY15pDR9z3i3ik8iTMP5m25XS/
 gVCEjYEc=
X-Gm-Gg: ASbGncv7jQOv4w3hiu/0kBnrVIaFnc140smuHmjHr4L1+h5hjv3/T8bjce9nkCn5jaR
 mQaj40I9AEHNrfNJjZRUo15s+h538CJ01CkoOTzo0K7GdbAj5vLqNn7UoefwhFfOu7RgYwVVlch
 BJmE0TVVIWlEtJ41V8RE3EGRrsUYHTASZHWsJbeVLXrTQq/jcwbXvmBO8TaaxNNFtV/Bih/gMgd
 dPRLvHZ5JuqNab+/X37Rw869XnyNDEvoxFzgSzRIidM/LIyAshnN2I3ZM+wC7wuUajedIRahw42
 vafYonCtUpc/F6WT6kfTBXHy7G8GiNd6OOWlOuERuv5E9FYvzDI9rfoVKLNdviEFhxfxa7Wa/GS
 yR7Fkh9J7qYQjARhZxcjQn8tVho9I
X-Google-Smtp-Source: AGHT+IHhL/WlJsyi7Zn4SL+255+0QN/Jw5oel9pUnmCX6rxgKXC0fK67b39rjxiKEBwi4TXJEVa2rg==
X-Received: by 2002:a17:902:d509:b0:237:cc75:77a4 with SMTP id
 d9443c01a7336-237d9a65d54mr144707005ad.42.1750623710574; 
 Sun, 22 Jun 2025 13:21:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860b8c9sm65357835ad.131.2025.06.22.13.21.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 13:21:50 -0700 (PDT)
Message-ID: <2bb2b1c3-b02d-4ad8-94f0-f0f6a5670091@linaro.org>
Date: Sun, 22 Jun 2025 13:21:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 017/101] target/arm: Add zt0_excp_el to DisasContext
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-18-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/21/25 16:49, Richard Henderson wrote:
> Pipe the value through from SMCR_ELx through hflags
> and into the disassembly context.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               |  2 ++
>   target/arm/tcg/translate.h     |  1 +
>   target/arm/cpu.c               |  3 +++
>   target/arm/tcg/hflags.c        | 34 +++++++++++++++++++++++++++++++++-
>   target/arm/tcg/translate-a64.c |  1 +
>   5 files changed, 40 insertions(+), 1 deletion(-)

Missing update to smcr_write to enable the EZT0 bit.


r~

> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 465fc188d0..fae253e567 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1497,6 +1497,7 @@ FIELD(SVCR, ZA, 1, 1)
>   
>   /* Fields for SMCR_ELx. */
>   FIELD(SMCR, LEN, 0, 4)
> +FIELD(SMCR, EZT0, 30, 1)
>   FIELD(SMCR, FA64, 31, 1)
>   
>   /* Write a new value to v7m.exception, thus transitioning into or out
> @@ -3067,6 +3068,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
>   FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
>   FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
>   FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
> +FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
>   
>   /*
>    * Helpers for using the above. Note that only the A64 accessors use
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 1bfdb0fb9b..5153824a49 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -70,6 +70,7 @@ typedef struct DisasContext {
>       int fp_excp_el; /* FP exception EL or 0 if enabled */
>       int sve_excp_el; /* SVE exception EL or 0 if enabled */
>       int sme_excp_el; /* SME exception EL or 0 if enabled */
> +    int zt0_excp_el; /* ZT0 exception EL or 0 if enabled */
>       int vl;          /* current vector length in bytes */
>       int svl;         /* current streaming vector length in bytes */
>       bool vfp_enabled; /* FP enabled via FPSCR.EN */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f7cbdd6814..3ceb8d87f4 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -635,6 +635,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
>                   env->cp15.cptr_el[3] |= R_CPTR_EL3_ESM_MASK;
>                   env->cp15.scr_el3 |= SCR_ENTP2;
>                   env->vfp.smcr_el[3] = 0xf;
> +                if (cpu_isar_feature(aa64_sme2, cpu)) {
> +                    env->vfp.smcr_el[3] |= R_SMCR_EZT0_MASK;
> +                }
>               }
>               if (cpu_isar_feature(aa64_hcx, cpu)) {
>                   env->cp15.scr_el3 |= SCR_HXEN;
> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 1ccec63bbd..59ab526375 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -214,6 +214,31 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
>       return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
>   }
>   
> +/*
> + * Return the exception level to which exceptions should be taken for ZT0.
> + * C.f. the ARM pseudocode function CheckSMEZT0Enabled, after the ZA check.
> + */
> +static int zt0_exception_el(CPUARMState *env, int el)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    if (el <= 1
> +        && !el_is_in_host(env, el)
> +        && !FIELD_EX64(env->vfp.smcr_el[1], SMCR, EZT0)) {
> +        return 1;
> +    }
> +    if (el <= 2
> +        && arm_is_el2_enabled(env)
> +        && !FIELD_EX64(env->vfp.smcr_el[2], SMCR, EZT0)) {
> +        return 2;
> +    }
> +    if (arm_feature(env, ARM_FEATURE_EL3)
> +        && !FIELD_EX64(env->vfp.smcr_el[3], SMCR, EZT0)) {
> +        return 3;
> +    }
> +#endif
> +    return 0;
> +}
> +
>   static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                                           ARMMMUIdx mmu_idx)
>   {
> @@ -269,7 +294,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>               DP_TBFLAG_A64(flags, PSTATE_SM, 1);
>               DP_TBFLAG_A64(flags, SME_TRAP_NONSTREAMING, !sme_fa64(env, el));
>           }
> -        DP_TBFLAG_A64(flags, PSTATE_ZA, FIELD_EX64(env->svcr, SVCR, ZA));
> +
> +        if (FIELD_EX64(env->svcr, SVCR, ZA)) {
> +            DP_TBFLAG_A64(flags, PSTATE_ZA, 1);
> +            if (cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
> +                int zt0_el = zt0_exception_el(env, el);
> +                DP_TBFLAG_A64(flags, ZT0EXC_EL, zt0_el);
> +            }
> +        }
>       }
>   
>       sctlr = regime_sctlr(env, stage1);
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index ac80f572a2..f7737f5d86 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10128,6 +10128,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
>       dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
>       dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
>       dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
> +    dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
>       dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
>       dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
>       dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);


