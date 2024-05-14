Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCADCC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6snV-0004XC-Eo; Tue, 14 May 2024 10:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6snT-0004Va-Ku
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:06:27 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6snQ-0005q2-VF
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:06:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7BF2CCE1259;
 Tue, 14 May 2024 14:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8194C2BD10;
 Tue, 14 May 2024 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715695576;
 bh=750cEwjvMo1qnPoAy5ka+j3sUk0wzlI37XmFKm+rG7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=njmrbZmeQM5aoYjZ/vhch2HNETyxsfW28ys37nvDgH6UFHk2T1nwbNMilGxannxSU
 mkpgIFVxsLmpoiqeBgyX3qe3Qz2Q5hID23rQaFxyA57Eh2K7mucRe5tv/UrcXz/+VW
 MKITZCfxH5sdeltEb9eoJavVD0qzcuBTlm8CthzX5JkbQKwQwwf7JWr0/uqqv1RwkT
 TOCDYfsqwLfhdTLbjChXIO7T2xh8NWADqerZBAaMcJqX0p20IQ5QIjj6sbt4WV0YW4
 E4AXcqrDxxQR12YSfQgRuJ9du1PPKZQ0h1lIzv5h2VMwQCzM2YgnV4EhIr3d5+xS9b
 +66FmgjpA1uIA==
Date: Tue, 14 May 2024 16:06:12 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 03/45] target/hppa: Move constant destination check
 into use_goto_tb
Message-ID: <ZkNv1LjoIu1tFCff@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> Share this check between gen_goto_tb and hppa_tr_translate_insn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 6d45611888..398803981c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -662,9 +662,10 @@ static bool gen_illegal(DisasContext *ctx)
>      } while (0)
>  #endif
>  
> -static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
> +static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
>  {
> -    return translator_use_goto_tb(&ctx->base, dest);
> +    return (bofs != -1 && nofs != -1 &&
> +            translator_use_goto_tb(&ctx->base, bofs));
>  }
>  
>  /* If the next insn is to be nullified, and it's on the same page,
> @@ -678,16 +679,16 @@ static bool use_nullify_skip(DisasContext *ctx)
>  }
>  
>  static void gen_goto_tb(DisasContext *ctx, int which,
> -                        uint64_t f, uint64_t b)
> +                        uint64_t b, uint64_t n)
>  {
> -    if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
> +    if (use_goto_tb(ctx, b, n)) {
>          tcg_gen_goto_tb(which);
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, f, NULL);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, b, NULL);
> +        copy_iaoq_entry(ctx, cpu_iaoq_f, b, NULL);
> +        copy_iaoq_entry(ctx, cpu_iaoq_b, n, NULL);
>          tcg_gen_exit_tb(ctx->base.tb, which);
>      } else {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, f, cpu_iaoq_b);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, b, ctx->iaoq_n_var);
> +        copy_iaoq_entry(ctx, cpu_iaoq_f, b, cpu_iaoq_b);
> +        copy_iaoq_entry(ctx, cpu_iaoq_b, n, ctx->iaoq_n_var);
>          tcg_gen_lookup_and_goto_ptr();
>      }
>  }
> @@ -4744,8 +4745,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>      /* Advance the insn queue.  Note that this check also detects
>         a priority change within the instruction queue.  */
>      if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
> -        if (ctx->iaoq_b != -1 && ctx->iaoq_n != -1
> -            && use_goto_tb(ctx, ctx->iaoq_b)
> +        if (use_goto_tb(ctx, ctx->iaoq_b, ctx->iaoq_n)
>              && (ctx->null_cond.c == TCG_COND_NEVER
>                  || ctx->null_cond.c == TCG_COND_ALWAYS)) {
>              nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
> -- 
> 2.34.1
> 

