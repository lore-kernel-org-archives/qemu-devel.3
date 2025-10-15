Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BBCCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94kb-000460-Ro; Wed, 15 Oct 2025 12:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94kX-00045b-Qz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:53:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94kS-0001yl-Hm
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:53:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-471076f819bso5916625e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760547181; x=1761151981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vuaokkINEe0uweXWQSk2P+Q0S2/2us8QFhA180fxGs=;
 b=YoOFgLnTqcUrMWHwVxeHAKqQsmnpdrxogEfyFmM/LtSCVHj2EzO5Ey7Xh52n2Hxz4A
 IO1ocXpzu2Sk0D8s4k6Ln+Yo1snPisKf4oiXlO1WpFO392dUN3aXBccGnN093VQHxStp
 lQzEZv0LKGwcE8yE4Lp+IXLjN8ncl3V2bRhzWX7D9avLDzLRrgi5loZBRIfQtXYcTruo
 t8BkmT0vmjIUHa+pv84z7CRQgnaDgadFCtGtXNwhNuDfD3NtcZ2E2NK9acltvJtJ3UzN
 4dl/91aCs2QeSpaxGBqHnm4GLS2kVFsHt8n6KyNfIz4nwkZUo4rahZLHT3jq2eT42jUk
 FjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760547181; x=1761151981;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vuaokkINEe0uweXWQSk2P+Q0S2/2us8QFhA180fxGs=;
 b=e8K+vLNetOsIjv7e4m2itqzfyhShzn4hKH3J6n7UT847t/X3vcEMYDmXMka3qre//J
 NfCbN9qvch6zo1JyOlZDBD8k3UmcVO0QMX/u0zeFNs0rd4hySj4iTRZ8xlPQ1sCAGrUp
 TjZ9me+Qyjw63zRN5L85Qw/6Q7UX1SUjBvEf2wJRwOgtNPJCM0MWUNVT8rpU4rxLjnyd
 3+rLR3Sjm6cTtmMtEgDrtJ1qE5rG/S/k9UlC8LbyrGV4W86IYTJtyOMjlE0Xw0d+jpYu
 MI4dTYjm3ZFnAPpP/ZOH7vgbdF6v/CxAKHNHu+A1GJHRYAKjggZDgAw/aQVxQVqEKck/
 NCRg==
X-Gm-Message-State: AOJu0Ywh47go3aEioVpzKsWs7qjH6CUViDr9KvC0X/TUHxx6smOQw8HD
 ChAHHzRZ+rxCnIKx4mqTg0gurW79o/pb72/qIgwQ5yPtlcMjV12PNvcnBt9+d0ZuG1cAXKPkrr8
 dUjWctGlOXmPk
X-Gm-Gg: ASbGncvaP7Iyq1+pdn/On0KSF9YMr5ZxZLC1sZFqmVP7lwRV90wzjY881l45FBCmD2D
 tm/kDgX3cZM6VELNRiNlxooZ2Fxviwrhs/HZOet9HL9rCeNvJZVWkfm0FgTnEBu2LPlgNXUiKis
 wga2cTbk/VlgrevHoDZxvNvvPZrIvG8XqcbPsTF3mv0ZmpBz10j9nYKk7lE0Lpm2WnYBh1xzV2S
 GdHYmkRFV7V1Rxmfj/inbRCddOalfVWkgzYM/DVYYPqNyj+VufRCWSGajgy9e+SgbycnVPPpiJ7
 BL6C8W04lcgpKnUFlBaCULs+S2t4OL64hEaMsBB14BLWZqY8/mWZBwLlyex7nChIfV8BEJFfWgA
 jbKVtT3w2LbFf0ZHKVaWInf2xu328i61bOvgTrobapDXwtFuwOtzHNFLPeO5gZQxccMWVjpj6Wh
 Jp3zCvIbBuwY2k
X-Google-Smtp-Source: AGHT+IGaKKGyleA4R35J1O2C8FilDwGMXX4INzVkznlhFeipaL72FdOjp9Yc8tuc/GRqyc0Wgr4Wgw==
X-Received: by 2002:a05:600c:6095:b0:46f:b32e:52d9 with SMTP id
 5b1f17b1804b1-46fb3cbc5f8mr151538585e9.13.1760547180820; 
 Wed, 15 Oct 2025 09:53:00 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c209d8sm40511325e9.9.2025.10.15.09.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 09:52:59 -0700 (PDT)
Message-ID: <af51d46a-eac4-4881-b4ae-68f5faeacc6d@linaro.org>
Date: Wed, 15 Oct 2025 18:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Name gen_goto_tb()'s TB slot index as
 @tb_slot_idx
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251010031745.37528-1-philmd@linaro.org>
In-Reply-To: <20251010031745.37528-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

ping?

On 10/10/25 05:17, Philippe Mathieu-Daudé wrote:
> tcg_gen_goto_tb() takes an unsigned index to the TB slot (0 or 1).
> Declare the argument as unsigned and rename it as @tb_slot_idx
> (which is more descriptive than @n) on all targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/translate.c         | 8 ++++----
>   target/arm/tcg/translate-a64.c   | 8 ++++----
>   target/arm/tcg/translate.c       | 8 ++++----
>   target/avr/translate.c           | 7 ++++---
>   target/hexagon/translate.c       | 8 ++++----
>   target/loongarch/tcg/translate.c | 7 ++++---
>   target/microblaze/translate.c    | 7 ++++---
>   target/mips/tcg/translate.c      | 7 ++++---
>   target/ppc/translate.c           | 7 ++++---
>   target/riscv/translate.c         | 9 +++++----
>   target/rx/translate.c            | 7 ++++---
>   target/sh4/translate.c           | 7 ++++---
>   target/sparc/translate.c         | 6 +++---
>   target/tricore/translate.c       | 7 ++++---
>   14 files changed, 56 insertions(+), 47 deletions(-)
> 
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index f11b382438c..a492520075e 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -436,18 +436,18 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
>       return DISAS_NEXT;
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
>   {
>       if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
>           /* With PCREL, PC must always be up-to-date. */
>           if (ctx->pcrel) {
>               gen_pc_disp(ctx, cpu_pc, disp);
> -            tcg_gen_goto_tb(idx);
> +            tcg_gen_goto_tb(tb_slot_idx);
>           } else {
> -            tcg_gen_goto_tb(idx);
> +            tcg_gen_goto_tb(tb_slot_idx);
>               gen_pc_disp(ctx, cpu_pc, disp);
>           }
> -        tcg_gen_exit_tb(ctx->base.tb, idx);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           gen_pc_disp(ctx, cpu_pc, disp);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index a0e3300231f..20c2a5b4861 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -471,7 +471,7 @@ static inline bool use_goto_tb(DisasContext *s, uint64_t dest)
>       return translator_use_goto_tb(&s->base, dest);
>   }
>   
> -static void gen_goto_tb(DisasContext *s, int n, int64_t diff)
> +static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
>   {
>       if (use_goto_tb(s, s->pc_curr + diff)) {
>           /*
> @@ -484,12 +484,12 @@ static void gen_goto_tb(DisasContext *s, int n, int64_t diff)
>            */
>           if (tb_cflags(s->base.tb) & CF_PCREL) {
>               gen_a64_update_pc(s, diff);
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>           } else {
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>               gen_a64_update_pc(s, diff);
>           }
> -        tcg_gen_exit_tb(s->base.tb, n);
> +        tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
>           s->base.is_jmp = DISAS_NORETURN;
>       } else {
>           gen_a64_update_pc(s, diff);
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index e62dcc5d85d..51654b0b91d 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -1259,7 +1259,7 @@ static void gen_goto_ptr(void)
>    * cpu_loop_exec. Any live exit_requests will be processed as we
>    * enter the next TB.
>    */
> -static void gen_goto_tb(DisasContext *s, int n, target_long diff)
> +static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, target_long diff)
>   {
>       if (translator_use_goto_tb(&s->base, s->pc_curr + diff)) {
>           /*
> @@ -1272,12 +1272,12 @@ static void gen_goto_tb(DisasContext *s, int n, target_long diff)
>            */
>           if (tb_cflags(s->base.tb) & CF_PCREL) {
>               gen_update_pc(s, diff);
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>           } else {
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>               gen_update_pc(s, diff);
>           }
> -        tcg_gen_exit_tb(s->base.tb, n);
> +        tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
>       } else {
>           gen_update_pc(s, diff);
>           gen_goto_ptr();
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 804b0b21dbd..ef6f655a458 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -981,14 +981,15 @@ static void gen_pop_ret(DisasContext *ctx, TCGv ret)
>       }
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       const TranslationBlock *tb = ctx->base.tb;
>   
>       if (translator_use_goto_tb(&ctx->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_i32(cpu_pc, dest);
> -        tcg_gen_exit_tb(tb, n);
> +        tcg_gen_exit_tb(tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_i32(cpu_pc, dest);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 02fd40c160f..50766eafe27 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -133,15 +133,15 @@ static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>       return translator_use_goto_tb(&ctx->base, dest);
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int idx, target_ulong dest, bool
> -                        move_to_pc)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest, bool move_to_pc)
>   {
>       if (use_goto_tb(ctx, dest)) {
> -        tcg_gen_goto_tb(idx);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           if (move_to_pc) {
>               tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], dest);
>           }
> -        tcg_gen_exit_tb(ctx->base.tb, idx);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           if (move_to_pc) {
>               tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], dest);
> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
> index 53a0b4c3ce9..57c3b8c4bb2 100644
> --- a/target/loongarch/tcg/translate.c
> +++ b/target/loongarch/tcg/translate.c
> @@ -99,16 +99,17 @@ void generate_exception(DisasContext *ctx, int excp)
>       ctx->base.is_jmp = DISAS_NORETURN;
>   }
>   
> -static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (ctx->va32) {
>           dest = (uint32_t) dest;
>       }
>   
>       if (translator_use_goto_tb(&ctx->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_tl(cpu_pc, dest);
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_tl(cpu_pc, dest);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 5098a1db4dc..3dd74b021e8 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -116,12 +116,13 @@ static void gen_raise_hw_excp(DisasContext *dc, uint32_t esr_ec)
>       gen_raise_exception_sync(dc, EXCP_HW_EXCP);
>   }
>   
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (translator_use_goto_tb(&dc->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_i32(cpu_pc, dest);
> -        tcg_gen_exit_tb(dc->base.tb, n);
> +        tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_i32(cpu_pc, dest);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index d91d6efe02c..54849e9ff1a 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -4362,12 +4362,13 @@ static void gen_trap(DisasContext *ctx, uint32_t opc,
>       }
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (translator_use_goto_tb(&ctx->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           gen_save_pc(dest);
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           gen_save_pc(dest);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index d422789a1d0..17e6d07c8c2 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3668,16 +3668,17 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
>   }
>   
>   /***                                Branch                                 ***/
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (NARROW_MODE(ctx)) {
>           dest = (uint32_t) dest;
>       }
>       if (use_goto_tb(ctx, dest)) {
>           pmu_count_insns(ctx);
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_tl(cpu_nip, dest & ~3);
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_tl(cpu_nip, dest & ~3);
>           gen_lookup_and_goto_ptr(ctx);
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 6fc06c71f51..9a53aecbfe9 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -286,7 +286,8 @@ static void exit_tb(DisasContext *ctx)
>       tcg_gen_exit_tb(NULL, 0);
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_long diff)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_long diff)
>   {
>       target_ulong dest = ctx->base.pc_next + diff;
>   
> @@ -305,12 +306,12 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_long diff)
>            */
>           if (tb_cflags(ctx->base.tb) & CF_PCREL) {
>               gen_update_pc(ctx, diff);
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>           } else {
> -            tcg_gen_goto_tb(n);
> +            tcg_gen_goto_tb(tb_slot_idx);
>               gen_update_pc(ctx, diff);
>           }
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           gen_update_pc(ctx, diff);
>           lookup_and_goto_ptr(ctx);
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 19a9584a829..5fc589c706b 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -147,12 +147,13 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       }
>   }
>   
> -static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (translator_use_goto_tb(&dc->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_i32(cpu_pc, dest);
> -        tcg_gen_exit_tb(dc->base.tb, n);
> +        tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_i32(cpu_pc, dest);
>           tcg_gen_lookup_and_goto_ptr();
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 70fd13aa3f5..137b75a4fb2 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -231,12 +231,13 @@ static bool use_goto_tb(DisasContext *ctx, target_ulong dest)
>       return translator_use_goto_tb(&ctx->base, dest);
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
> +                        target_ulong dest)
>   {
>       if (use_goto_tb(ctx, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_i32(cpu_pc, dest);
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           tcg_gen_movi_i32(cpu_pc, dest);
>           if (use_exit_tb(ctx)) {
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 810e2491a61..d6b599b71fe 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -363,15 +363,15 @@ static bool use_goto_tb(DisasContext *s, target_ulong pc, target_ulong npc)
>              translator_use_goto_tb(&s->base, npc);
>   }
>   
> -static void gen_goto_tb(DisasContext *s, int tb_num,
> +static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx,
>                           target_ulong pc, target_ulong npc)
>   {
>       if (use_goto_tb(s, pc, npc))  {
>           /* jump to same page: we can use a direct jump */
> -        tcg_gen_goto_tb(tb_num);
> +        tcg_gen_goto_tb(tb_slot_idx);
>           tcg_gen_movi_tl(cpu_pc, pc);
>           tcg_gen_movi_tl(cpu_npc, npc);
> -        tcg_gen_exit_tb(s->base.tb, tb_num);
> +        tcg_gen_exit_tb(s->base.tb, tb_slot_idx);
>       } else {
>           /* jump to another page: we can use an indirect jump */
>           tcg_gen_movi_tl(cpu_pc, pc);
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 3d0e7a10bd8..7c6e3095971 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -2816,12 +2816,13 @@ static inline void gen_save_pc(target_ulong pc)
>       tcg_gen_movi_tl(cpu_PC, pc);
>   }
>   
> -static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index,
> +                        target_ulong dest)
>   {
>       if (translator_use_goto_tb(&ctx->base, dest)) {
> -        tcg_gen_goto_tb(n);
> +        tcg_gen_goto_tb(tb_slot_index);
>           gen_save_pc(dest);
> -        tcg_gen_exit_tb(ctx->base.tb, n);
> +        tcg_gen_exit_tb(ctx->base.tb, tb_slot_index);
>       } else {
>           gen_save_pc(dest);
>           tcg_gen_lookup_and_goto_ptr();


