Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A16C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 21:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFJjr-0005vr-54; Wed, 14 May 2025 17:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uFJjp-0005vF-09
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:34:05 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uFJjn-00062D-BS
 for qemu-devel@nongnu.org; Wed, 14 May 2025 17:34:04 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-8792b6d756fso62007241.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747258442; x=1747863242; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0CKhmihup1Qwffg7785kc7S9/MLcRLKMAG1DNsHXFpw=;
 b=LTsDYIA5OcxoICNUP0IFcYn4xE/FHJqUsPXDq1okvekz55q8w1GvnjHabZpJKBEnb2
 JcM3UL+DgLjh6D5UKRj49ysRAIAcGG/xpz98KL8OmmD4yFIXFVfVrHtsrhBsXPYXZVBV
 diXNq1URFTDocaMZnmym/KvaaIl2XDinul/4xU/KxBAQQJQ5/cy9emCfzqOZR0fHkL/g
 BrwC+HrMOtvqa6kpJSqllEnwp82//esjwE/kthMCDDOSyslYwtimX8Ca1MZtVVHreNB5
 r7rDDD0ZwFTwreRoWDuMRWkCTGab6PVyU3xn5fcTYsMgdoX5a8WpduKd2z++1yW6gVjU
 0Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747258442; x=1747863242;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0CKhmihup1Qwffg7785kc7S9/MLcRLKMAG1DNsHXFpw=;
 b=Pq42pr0b1zB2I/cNbMk89rRqbuuZTZXOANfr5wEYfBG2NlKGjN27wzyP5LMabW951G
 1zw8qgrqWfl7vD7kwFzjox/Sz8c1J3CIUaVOqSOgRpKMMrCmB+Qjskm/+aWEa6w3xNM3
 THuMlWMjmbaywWXhyy72Y1P08n4tW8K/e2GiP9XXjhN5IV+oAbpQHEpKWU70BZuRWtUH
 xTfyJ+8vmp8x6HDZTpv0JaRbg4PFbaUu3+rv+nqvL395KyFlRrnGgndgJ99iYSA5rIRx
 EEbSK0UOnK4AA4sRLKKRTisCnhaH/bqwG/YmeFYBFIADyjJ9k83sbr64pc0ZONTEi0wJ
 5WTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5YlpN+Dj9slp9lIMXdcHVJ+ounK2DL1hHcU83kU+V/JSF4t46Ngg7nRL4og/xdRZQHl9hKrTRCjoi@nongnu.org
X-Gm-Message-State: AOJu0YzHcBBb/5/qTJxbGcaFI8mSZ6daVZb4wYQEms4gylSsXsBxLksp
 UYFHKVh3ClTDCq6n6SqkwhUWbR87PH9NxIgRGQRIuwo2BbI5q6xCdivbC7DlyLk=
X-Gm-Gg: ASbGncsvo9E10G+l43z4SiyPN4uSBLaut7jZD3vKzuoU9oRRBCtbVZB1PXOFeLpSeM7
 RFxU8zC+dkuSyDhN8y5h0KrUAz/JjYCaMY6wC+TgqNfU0PwcwEcuEYAX5juwR9gHylj4p6d/+Y8
 6s6EkP8wFGPFbPjtAd5zsPGYbvtNOOsDHXeSyaHlzcIor2zk2gyFMjODKFJi7zOT1xm9K+0zCyj
 E7tKP90nc7eE3yykMWVz/cI2GJw6efrTqhJdHKA4jLU6X1v3ztcFMGjrrWsu+fK141DEJya01uh
 gtDc+EeFQC0YE1i38idbDBKC9KcobmYNvJ0MaqjkvKXX4TmeC3mAUG8cjl0qdGvKEp8hL5bu4NN
 t
X-Google-Smtp-Source: AGHT+IEsmntuqiPCQELWVImqdxhiy+GKc7xaYngAHzB41ue/+g8E7pGci8OoKUkeepwdBWJteXcXGA==
X-Received: by 2002:a05:6102:2d09:b0:4de:1ab2:ac67 with SMTP id
 ada2fe7eead31-4df953f7c08mr102747137.2.1747258441793; 
 Wed, 14 May 2025 14:34:01 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52c5375fde5sm10467747e0c.27.2025.05.14.14.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 14:34:01 -0700 (PDT)
Message-ID: <b1b72b45-d1fe-4ff4-8649-cbfd32e5f8a8@ventanamicro.com>
Date: Wed, 14 May 2025 18:33:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250425152311.804338-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x936.google.com
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

Richard,

On 4/25/25 12:23 PM, Richard Henderson wrote:
> Do not examine a random host return address, but
> properly compute the next pc for the guest cpu.
> 
> Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a663f527a4..85f9b4c3d2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -30,6 +30,8 @@
>   #include "exec/icount.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
> +#include "tcg/insn-start-words.h"
> +#include "internals.h"
>   #include <stdbool.h>
>   
>   /* CSR function table public API */
> @@ -2099,6 +2101,19 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
>       return RISCV_EXCP_NONE;
>   }
>   
> +static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
> +{
> +    uint64_t data[TARGET_INSN_START_WORDS];

Isn't this 'INSN_START_WORDS'?  I'm seeing code in i386 that is similar
to what we're doing here and it's using INSN_START_WORDS:

====
static inline target_ulong get_memio_eip(CPUX86State *env)
{
#ifdef CONFIG_TCG
     uint64_t data[INSN_START_WORDS];
     CPUState *cs = env_cpu(env);

     if (!cpu_unwind_state_data(cs, cs->mem_io_pc, data)) {
         return env->eip;
     }

     /* Per x86_restore_state_to_opc. */
     if (tcg_cflags_has(cs, CF_PCREL)) {
         return (env->eip & TARGET_PAGE_MASK) | data[0];
     } else {
         return data[0] - env->segs[R_CS].base;
     }
#else
     qemu_build_not_reached();
#endif
}
====

I'm asking because the build in Alistair's branch is failing with this error:


../target/riscv/csr.c: In function ‘get_next_pc’:
../target/riscv/csr.c:2106:19: error: ‘TARGET_INSN_START_WORDS’ undeclared (first use in this function); did you mean ‘TCG_INSN_START_WORDS’?
  2106 |     uint64_t data[TARGET_INSN_START_WORDS];
       |                   ^~~~~~~~~~~~~~~~~~~~~~~
       |                   TCG_INSN_START_WORDS
../target/riscv/csr.c:2106:19: note: each undeclared identifier is reported only once for each function it appears in
../target/riscv/csr.c:2106:14: error: unused variable ‘data’ [-Werror=unused-variable]
  2106 |     uint64_t data[TARGET_INSN_START_WORDS];
       |              ^~~~
../target/riscv/csr.c:2115:1: error: control reaches end of non-void function [-Werror=return-type]
  2115 | }
       | ^
cc1: all warnings being treated as errors
[2206/3000] Compiling C object libqemu-riscv


Changing TARGET_INSN_START_WORDS to INSN_START_WORDS fixes the build issue.
Thanks,


Daniel

> +
> +    /* Outside of a running cpu, env contains the next pc. */
> +    if (ra == 0 || !cpu_unwind_state_data(env_cpu(env), ra, data)) {
> +        return env->pc;
> +    }
> +
> +    /* Within unwind data, [0] is pc and [1] is the opcode. */
> +    return data[0] + insn_len(data[1]);
> +}
> +
>   static RISCVException write_misa(CPURISCVState *env, int csrno,
>                                    target_ulong val, uintptr_t ra)
>   {
> @@ -2114,11 +2129,8 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>       /* Mask extensions that are not supported by this hart */
>       val &= env->misa_ext_mask;
>   
> -    /*
> -     * Suppress 'C' if next instruction is not aligned
> -     * TODO: this should check next_pc
> -     */
> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
> +    /* Suppress 'C' if next instruction is not aligned. */
> +    if ((val & RVC) && (get_next_pc(env, ra) & ~3) != 0) {
>           val &= ~RVC;
>       }
>   


