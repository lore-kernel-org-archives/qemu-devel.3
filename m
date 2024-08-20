Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B22C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXQJ-0006Ul-2E; Tue, 20 Aug 2024 18:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXQB-0006Tj-Ci
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:33:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgXQ5-0007Tp-KY
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:33:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71423273c62so179394b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724193219; x=1724798019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v0GvZX6BPCZYoUBN0LIhyJf0EJ18ewbTqRXITRJVhO4=;
 b=lO+ug/V0Q7LkA0B5Kv2q5AcIwteE0eQLvBIkf8sGEjoN4hvjzr6GT3cId80IaQCe/9
 TRaUOJbWK8KLeCFRhZxA+pNl4G2DtP8+xdW60vnbKDbAsas8c9ih+X8XwrYGsu/V37Ir
 PDVpzngLgctxLmq60JZJx4AyZuHDnqdEeY4HzX/aEAe+AVJ7rMii8/MqH7Y3N2S2xkip
 Zo/uZsHVxJ5zCdGKXIjBwDM/7bZSG2f/NDQFCgnFanjNz6gqRJXLLYHiWQKppzsexzhp
 ulSy9WRnjPja5dfvPIqtVlCdExkHOGMFvGWuOsm0r2wF8zLASYFFfyGtB/Q4YIF0vUUH
 cucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724193219; x=1724798019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0GvZX6BPCZYoUBN0LIhyJf0EJ18ewbTqRXITRJVhO4=;
 b=MNJ9E6ZxYdITthT0mvIEo29+iScHOIWeV4gwd0Pc4gySDUHNg/uF358Jdzwq+4QP52
 Gftlv0a6sM/AfKKYfhc6YMHNi6P9huVptfsVQUwbJhbXiYhM2aJ4mSsIB4qoz15BjDKI
 J0xCHYET8WlIMBGpTIcCMfQfbK+qjRRwvXzLsL9rcPFQJLnuAZDzC4sRhNrQjKIu6A0C
 qLHZ9la6DMPb5MpJlNedS+YckrJGrO/g+gXjAZ9CLXea8NS90Ff6APxoWUSdD4dit1lH
 Gll+lMGauLYV++iWsG9o6mgIU/zDLF706bb0850/ni7337e24Gw2HafB4X4mHh1rFsQf
 yOaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqAWDrr2DZ8AinNEDcMEsbvQKhM9RJUkC0ud9l8FGx+OqQ8yHlHgsTSt0RT1Ec9XnZRA0jX3HRGoyh@nongnu.org
X-Gm-Message-State: AOJu0YzupHaXr3y4aH7smOQKRQKITgG0kCO9dxJUAkQZBZMjxEgyAMQX
 NbfbX17dkwkDTsnH5sFV03WzgPDZgsxK/PG4FrL9cZoC/VpCcngnmaJGvbVOOqM=
X-Google-Smtp-Source: AGHT+IGOxl2NHjnbffxcEdvSdB6KhxB5t7Xi8KY9XOo78ST976TNva01CUCa2pvUWlXT6w/vDBsorw==
X-Received: by 2002:a05:6a21:3983:b0:1c0:e1a5:9583 with SMTP id
 adf61e73a8af0-1cad810c8b2mr944495637.17.1724193218672; 
 Tue, 20 Aug 2024 15:33:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebbd9d72sm130257a91.49.2024.08.20.15.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 15:33:38 -0700 (PDT)
Message-ID: <9376bb6b-0d07-4f00-8004-6df1b0a8ef84@linaro.org>
Date: Wed, 21 Aug 2024 08:33:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240820000129.3522346-1-debug@rivosinc.com>
 <20240820000129.3522346-12-debug@rivosinc.com>
 <ZsRHPDG/GkyhdrQi@debug.ba.rivosinc.com>
 <c0afdd87-71c1-4b02-a2fb-5c9349205d8f@linaro.org>
 <ZsTmibCvaZJpEAPO@debug.ba.rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZsTmibCvaZJpEAPO@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On 8/21/24 04:55, Deepak Gupta wrote:
> Something on the below lines? I've one question as well for you in comment.
> 
> """"
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fee31b8037..b4e04fe849 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -46,8 +46,14 @@ typedef struct CPUArchState CPURISCVState;
>   /*
>    * RISC-V-specific extra insn start words:
>    * 1: Original instruction opcode
> + * 2: more information about instruction
>    */
> -#define TARGET_INSN_START_EXTRA_WORDS 1
> +#define TARGET_INSN_START_EXTRA_WORDS 2
> +
> +/*
> + * b0: Whether a shadow stack operation/instruction or not.
> + */
> +#define RISCV_INSN_START_WORD2_SS_OP 1

Ah, here: not shadow-stack specific.  Set for any insn which should always generate 
STORE_AMO, including the actual AMO instructions.  It's a current emulation error, IIRC.

> @@ -226,6 +232,7 @@ struct CPUArchState {
>       bool      elp;
>       /* shadow stack register for zicfiss extension */
>       target_ulong ssp;
> +    bool      ss_op;

For generality, maybe just store the whole word as excp_uw2?

>       if (!async) {
> +        /* shadow stack op, promote load page fault to store page fault */
> +        if (env->ss_op && cause == RISCV_EXCP_LOAD_PAGE_FAULT) {
> +            cause = RISCV_EXCP_STORE_PAGE_FAULT;
> +        }
>           /* set tval to badaddr for traps with address information */
>           switch (cause) {
>           case RISCV_EXCP_SEMIHOST:

     case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         if (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO) {
             cause = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         }
         goto load_store_fault;
     case RISCV_EXCP_LOAD_ACCESS_FAULT:
         ...
     case RISCV_EXCP_LOAD_PAGE_FAULT:
         ...
     case RISCV_EXCP_STORE_PAGE_FAULT:
     load_store_fault:

> @@ -1301,6 +1301,14 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, 
> CPUState *cpu)
>           ctx->base.is_jmp = DISAS_NORETURN;
>       }
> 
> +    /* shadow stack index means shadow stack instruction is translated */
> +    if (ctx->mem_idx & MMU_IDX_SS_WRITE) {
> +        /* Is this needed to set true? */
> +        ctx->insn_start_updated = true;
> +        tcg_set_insn_start_param(ctx->base.insn_start, 2,
> +                                 RISCV_INSN_START_WORD2_SS_OP);
> +    }

No, SS_WRITE is never part of mem_idx, and setting insn_start_updated here would break things.

You'll want to change decode_save_opcode() to take the second parameter (or introduce a 
new helper for the second parameter, leaving decode_save_opcode alone).  But you do have 
to handle the update on a per-insn basis.


r~

