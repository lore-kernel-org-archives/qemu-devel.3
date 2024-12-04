Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62E0E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 14:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIqP5-0003tR-Id; Wed, 04 Dec 2024 09:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIqP4-0003t3-1V
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 09:30:58 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIqP2-0007Jh-8N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 09:30:57 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3e786167712so3372642b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733322655; x=1733927455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vc1vupWmoIw50sU6oPaQXGisQqNX0DnNMjmPK4ovF8s=;
 b=d0+o5TNj3WTH1206V0N4g/vYiL8AcJ0YcxjrtpWneb8SIpFvHfqPnzzBZeBnpy4ZCD
 tYLBff3wCvKhRVxn7dPF1tiFokDA5jTblNotE8TKdTkWUftV0upbpSpS4O7bQO24FCT3
 vt66+sFPgQ9gCud7y3TGrxnnJIPunFwH0GTNgH5iWt2hNXB9/ukqxu3IdpyC4UKkyh8X
 JYk8zOOsrBOW3fV54F9/Un68SiX28n7wp7Kh28+nyLROltDMAetoILhcTjEKSTc1xOlv
 VJaqSMv8xdT1LpWNOfn/AEM5/HYV0l2G3prs3ltFHl7IvsALTfl7prM/Xq49ljo5Y0B2
 Ef+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733322655; x=1733927455;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vc1vupWmoIw50sU6oPaQXGisQqNX0DnNMjmPK4ovF8s=;
 b=oHv42dBOOokBajeIZLVlev4iw87PUutUOfGoJZs40WZXff2QXDdCR7Bqd/AF26D8Ef
 Y4VwjOq+ozRQMbhYBqcKUO90VsxHdOJernTVIioSGgpP8xT1W+e3evwMVVMxa1snWHbY
 Uw37D19aIJTRGToqWRLE5+jMHULHt/si2k4KScM7KrZkT4maPlGCU3klDss2FH/vkqM8
 1/pZdZrMHrH/06zvKOKMc5Ak9MC72SJcBUxbTGja1M2UZt9QuEq06hwS+R1ibAORr6cU
 FMd4OTURB1sdVLEQ/QNSAOXFqbULVK2vWyOJcVD4zBxAAE9Ws+J4DJ/mwyL7mUkkSvRB
 +Pbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj/Gx1R1Va1KwcMx3jAErq8+3QNfadD1NfkynJX23OvOT587Rzki2EDPrQTiM/PLIujmvWBBXV9Ihm@nongnu.org
X-Gm-Message-State: AOJu0Ywsfmdn113IRQSkAVB7q8VvmW/MPue7+DdpyageLKeiSmSZ8d+t
 QUt3A6tZz58csZFdiF6cIcZZBTyc08L4J5TWaKpwVXikd4E6tiHbvkd1RmAt3SQ=
X-Gm-Gg: ASbGncskg68UtT/0e5jGANvT45I6ej3R9RjG95+OaoU/2F91FNSmS00ToEWk3Kg+j9C
 Li+7bnXrXPfhRXHanQsZpTFalW0Zs/AHFDYV5YLR5gbNGtj2o2x2CLk+xzx5oVERvclcI2iwdqC
 vPUUfYkXjYmunIDiR+GboLFfLyGSOE6jMyf0EKh2E6/Z/or8Nk+tOskrHPf7R1AroSu5VJgeayU
 LZWhk60Fe/n6S7K6+F2JW8w5SSE0V7tTVciCwCh+vdqPZSMdL7L/LbksQH2El2bMVmzsgchijC+
 HdevXPVQQrcwh7IRyzsvDUVzJp2+
X-Google-Smtp-Source: AGHT+IEtRt9G7CBCL9ngnj5UUYHUAl70ZgLGK6nd8ddrPji+BPhngFjbTgv8rRt5MjHtiNwXhXrN9A==
X-Received: by 2002:a05:6808:399b:b0:3e7:eda5:6b06 with SMTP id
 5614622812f47-3eae50c51efmr5283641b6e.35.1733322654675; 
 Wed, 04 Dec 2024 06:30:54 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eaa953fd1dsm2636951b6e.25.2024.12.04.06.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 06:30:54 -0800 (PST)
Message-ID: <625bbb08-aac1-42c7-84b1-572fe48093d6@linaro.org>
Date: Wed, 4 Dec 2024 08:30:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] target/riscv: Add support to record CTR entries.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
 <20241204-b4-ctr_upstream_v3-v4-4-d3ce6bef9432@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-4-d3ce6bef9432@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

On 12/4/24 06:56, Rajnesh Kanwal wrote:
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 0bdfa9a0ed3313223ce9032fb24484c3887cddf9..a5c2410cfa0779b1a928e7b89bd2ee5bb24216e4 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -78,9 +78,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       if (has_ext(ctx, RVS)) {
> +        TCGv src = tcg_constant_tl(ctx->base.pc_next);

This is incorrect.
You need to use gen_pc_plus_diff(src, ctx, 0).

Alternately, for here in sret and mret, instead of adding an extra parameter, use 
gen_update_pc(ctx, 0) to update env->pc



> @@ -95,9 +96,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
>   static bool trans_mret(DisasContext *ctx, arg_mret *a)
>   {
>   #ifndef CONFIG_USER_ONLY
> +    TCGv src = tcg_constant_tl(ctx->base.pc_next);

Likewise.


> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index 96c218a9d7875c6419287ac3aa9746251be3f442..fc182e7b18a289e13ad212f10a3233aca25fae41 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -93,6 +93,50 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
>       return true;
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +/*
> + * Indirect calls
> + * - jalr x1, rs where rs != x5;
> + * - jalr x5, rs where rs != x1;
> + * - c.jalr rs1 where rs1 != x5;
> + *
> + * Indirect jumps
> + * - jalr x0, rs where rs != x1 and rs != x5;
> + * - c.jr rs1 where rs1 != x1 and rs1 != x5.
> + *
> + * Returns
> + * - jalr rd, rs where (rs == x1 or rs == x5) and rd != x1 and rd != x5;
> + * - c.jr rs1 where rs1 == x1 or rs1 == x5.
> + *
> + * Co-routine swap
> + * - jalr x1, x5;
> + * - jalr x5, x1;
> + * - c.jalr x5.
> + *
> + * Other indirect jumps
> + * - jalr rd, rs where rs != x1, rs != x5, rd != x0, rd != x1 and rd != x5.
> + */
> +static void helper_ctr_jalr(DisasContext *ctx, arg_jalr *a)

Generally "helper_*" are out-of-line functions, whereas this is generating inline code. 
Better as "gen_ctr_jalr".

> +{
> +    TCGv src = tcg_constant_tl(ctx->base.pc_next);

gen_pc_plus_diff

> @@ -219,6 +269,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
>       TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
>       TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
>       target_ulong orig_pc_save = ctx->pc_save;
> +#ifndef CONFIG_USER_ONLY
> +    TCGv src = tcg_constant_tl(ctx->base.pc_next);
> +#endif

gen_pc_plus_diff, though perhaps delay until used.

>   
>       if (get_xl(ctx) == MXL_RV128) {
>           TCGv src1h = get_gprh(ctx, a->rs1);
> @@ -231,6 +284,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
>       } else {
>           tcg_gen_brcond_tl(cond, src1, src2, l);
>       }
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        TCGv type = tcg_constant_tl(CTRDATA_TYPE_NONTAKEN_BRANCH);
> +        TCGv dest = tcg_constant_tl(ctx->base.pc_next + ctx->cur_insn_len);

gen_pc_plus_diff

> +        gen_helper_ctr_add_entry(tcg_env, src, dest, type);
> +    }
> +#endif
> +
>       gen_goto_tb(ctx, 1, ctx->cur_insn_len);
>       ctx->pc_save = orig_pc_save;
>   
> @@ -243,6 +305,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
>           gen_pc_plus_diff(target_pc, ctx, a->imm);
>           gen_exception_inst_addr_mis(ctx, target_pc);
>       } else {
> +#ifndef CONFIG_USER_ONLY
> +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +            TCGv type = tcg_constant_tl(CTRDATA_TYPE_TAKEN_BRANCH);
> +            TCGv dest = tcg_constant_tl(ctx->base.pc_next + a->imm);

gen_pc_plus_diff.

> diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
> index cd234ad960724c936b92afb6fd1f3c7c2a37cb80..07b51d9f4d847c4411165b422a843fea65c86d45 100644
> --- a/target/riscv/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzce.c.inc
> @@ -204,6 +204,13 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
>       if (ret) {
>           TCGv ret_addr = get_gpr(ctx, xRA, EXT_SIGN);
>           tcg_gen_mov_tl(cpu_pc, ret_addr);
> +#ifndef CONFIG_USER_ONLY
> +        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +            TCGv src = tcg_constant_tl(ctx->base.pc_next);

gen_pc_plus_diff, and it will need to be done *before* the assignment to cpu_pc.

> @@ -309,6 +316,21 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
>           gen_set_gpr(ctx, xRA, succ_pc);
>       }
>   
> +#ifndef CONFIG_USER_ONLY
> +    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
> +        TCGv src = tcg_constant_tl(ctx->base.pc_next);

Here, we have updated cpu_pc to current (see the start of the function), so you can just 
use that instead of src.

> +void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
> +                          target_ulong dest, target_ulong type)
> +{
> +    riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
> +                            env->priv, env->virt_enabled);

Indent to line up after (.

> +static void helper_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)

gen_ctr_jal.

> +{
> +    TCGv dest = tcg_constant_tl(ctx->base.pc_next + imm);
> +    TCGv src = tcg_constant_tl(ctx->base.pc_next);

gen_pc_plus_diff.


r~

