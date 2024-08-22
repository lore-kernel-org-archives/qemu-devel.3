Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10D8C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 00:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgvv6-00016z-7s; Wed, 21 Aug 2024 20:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgvv4-00012w-4y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:43:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgvv2-0004mQ-ER
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 20:43:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-201e52ca0caso1900235ad.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724287394; x=1724892194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQiMoHHhKEqPj7MZTMSKCVIWXSKzuAPQnwLAMpCrhjc=;
 b=QoBh9cr5UHaGM5xiWXW3k0kXj0vL5wquNL57xV9fJ3KtGE0kEoqGase4csWvpdSPhV
 cwju4zOiXx5q06YxPopGeQjo+1AqWxQ6b0zPMoEyKqz3xnQMXUpIpvngw16eR7CsSdga
 OwFo5n5Gu52YAO18Q6dJ/oOmfcT2BY3YESebie7dQooI0C98poM1bA8AY+geQQAJq3mX
 QPLk2eGwZkqISduk0+3DhdP7l+zQJwtMcORGVOgGU2zkxwEXHnWZJ4mwJWu2Ee4Mf0fe
 8tgOFwma8+RXMkR0TlIQuQubZxewJwkbLVSsjVKVHcqc26auqxsHfA+gwM4K2lfaYEWG
 E5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724287394; x=1724892194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQiMoHHhKEqPj7MZTMSKCVIWXSKzuAPQnwLAMpCrhjc=;
 b=ICck/HGpx+b7MGQS40wUAP/womU2ZRW1IwoISDBMqLJIIgTIC6xfCbtQ1gaKp6JUYW
 nvuzYs3bz52VImXlaVrWa1KmKgsYjoRPFic9nJZyScQyrP0rMK9eIWW3DXQ2f0w8zunU
 mq6AWSqrm62X1j+Esd17L1G7IdWcsgdNN18VCE03TvyLy014ZpZg/y9F2I6dxgsx70Gv
 jixEKGt4aUaRHVt2SdVFNyiv6ruaj0a1SyXMW4hGcubQ0fnFMHcPeO3ShbqORdKCaPaG
 KyajAQ/FLB0vTgT+q3yBmmNqy/9vaVPOCSqVN1X/wvJmL21lB6IOVGV202Tdn7Ox84DD
 JpHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUVMN66eVZ3syC/B5/sXe0c2QnD/Oz+i/TiUSzWdig6hEwq2spBPsofWZzG7aZdL7g6V9sRtNWKYkV@nongnu.org
X-Gm-Message-State: AOJu0YwAJkErb7wmADGPxeNSweVYJqI4t49TZsW5csMaOA0cU3GUma+Y
 4OuBVvRRSA72rvehsmkgLHwXLv8ki3suQav1+TSi56Vxg1p5RJuFm1lIZJGat3M=
X-Google-Smtp-Source: AGHT+IHOXJCwPyCIqhCyyYPOAXMY7yiQyIGX5RcZKETtrDu7GFbpWgg3+KGr0V05vRyCHzerqLl/Qw==
X-Received: by 2002:a17:903:247:b0:1fb:8cab:ccc9 with SMTP id
 d9443c01a7336-203681e3d0fmr52737615ad.45.1724287393976; 
 Wed, 21 Aug 2024 17:43:13 -0700 (PDT)
Received: from [192.168.98.227] (60-242-98-186.static.tpgi.com.au.
 [60.242.98.186]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385594057sm1818795ad.119.2024.08.21.17.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 17:43:13 -0700 (PDT)
Message-ID: <fbe42e3d-0622-46b4-93eb-ddb13bd4814f@linaro.org>
Date: Thu, 22 Aug 2024 10:43:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] target/riscv: AMO operations always raise
 store/AMO fault
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240821215014.3859190-1-debug@rivosinc.com>
 <20240821215014.3859190-13-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240821215014.3859190-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/22/24 07:50, Deepak Gupta wrote:
> @@ -1779,13 +1780,25 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               env->pc += 4;
>               return;
>           case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
> +            if (always_storeamo) {
> +                cause = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
> +            }
> +            goto load_store_fault;
>           case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>           case RISCV_EXCP_LOAD_ADDR_MIS:
>           case RISCV_EXCP_STORE_AMO_ADDR_MIS:
>           case RISCV_EXCP_LOAD_ACCESS_FAULT:
> +            if (always_storeamo) {
> +                cause = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +            }
> +            goto load_store_fault;
>           case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
>           case RISCV_EXCP_LOAD_PAGE_FAULT:
>           case RISCV_EXCP_STORE_PAGE_FAULT:
> +            if (always_storeamo) {
> +                cause = RISCV_EXCP_STORE_PAGE_FAULT;
> +            }
> +        load_store_fault:

These case labels need to be re-sorted; you're mising load/store when you're intending to 
check for load alone.  I expect LOAD_ADDR_MIS needs adjustment as well?

> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d44103a273..8961dda244 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -121,6 +121,7 @@ typedef struct DisasContext {
>       bool fcfi_lp_expected;
>       /* zicfiss extension, if shadow stack was enabled during TB gen */
>       bool bcfi_enabled;
> +    target_ulong excp_uw2;
>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -144,6 +145,9 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>   #define get_address_xl(ctx)    ((ctx)->address_xl)
>   #endif
>   
> +#define SET_INSTR_ALWAYS_STORE_AMO(ctx) \
> +    (ctx->excp_uw2 |= RISCV_UW2_ALWAYS_STORE_AMO)
> +
>   /* The word size for this machine mode. */
>   static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
>   {
> @@ -214,6 +218,12 @@ static void decode_save_opc(DisasContext *ctx)
>       assert(!ctx->insn_start_updated);
>       ctx->insn_start_updated = true;
>       tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
> +
> +    if (ctx->excp_uw2) {
> +        tcg_set_insn_start_param(ctx->base.insn_start, 2,
> +                                 ctx->excp_uw2);
> +        ctx->excp_uw2 = 0;
> +    }

I really don't think having data on the side like this...

>   }
>   
>   static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
> @@ -1096,6 +1106,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
>           mop |= MO_ALIGN;
>       }
>   
> +    SET_INSTR_ALWAYS_STORE_AMO(ctx);
>       decode_save_opc(ctx);

... or the requirement for ordering of two function calls is a good interface.

I did say perhaps add another helper, but what I expected was

     decode_save_opc_set_amo_store(ctx);

where decode_save_opc and decode_save_opc_set_amo_store call into a common helper.
But perhaps in the end maybe just decode_save_opc(ctx, uw2) is better.

I expect gen_cmpxchg also needs updating, though I don't have Zacas to hand.


r~

