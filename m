Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BBAC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6tNr-00051w-Kv; Tue, 14 May 2024 10:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tNm-00051c-J7
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:43:59 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tNk-0005mI-5r
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:43:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4732ACE128C;
 Tue, 14 May 2024 14:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE88C32781;
 Tue, 14 May 2024 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715697831;
 bh=9f7S9gMqPXEeAbd4uDxGgx7EFtl4cYRAY/5pFLraHc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t3vPrE53uIwT1tGaapqTKpX8h4+hojOFFbMXdrEL8iHly57HJanc0v8JV+SZevG0z
 OcJljmLJg9LgJ9FdqsmdtbB5o5yXsg6liCDAtCD+j9bDeOgrR8VFed+7K4UxAoTWo2
 lXcuLy/D6SNvyd0wD4kZGYQ64ldyxrquZgwgajTnfjJV6iOLdsXDheX8m/7kiUjGNi
 BIrCITqY+fQt9IpmpFs/IQPSg7iXW2AJN5qb+vKyvU9TmsxfXG5KsAzHPYMKA9Xkwd
 Nm5km/MfgUKgFEajyJxMr4QZ7rGTAq4Sky1GNNXRt9Mn7rpmuKwFuTVyFkyatfIk3R
 9W5gVXNc0Vujg==
Date: Tue, 14 May 2024 16:43:47 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 11/45] target/hppa: Simplify TB end
Message-ID: <ZkN4o4U0diWdFs8u@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-12-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-12-richard.henderson@linaro.org>
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
> Minimize the amount of code in hppa_tr_translate_insn advancing the
> insn queue for the next insn.  Move the goto_tb path to hppa_tr_tb_stop.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 109 +++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 52 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index ca979f4137..13a48d1b6c 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -4699,54 +4699,31 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>          }
>      }
>  
> -    /* Advance the insn queue.  Note that this check also detects
> -       a priority change within the instruction queue.  */
> -    if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
> -        if (use_goto_tb(ctx, ctx->iaoq_b, ctx->iaoq_n)
> -            && (ctx->null_cond.c == TCG_COND_NEVER
> -                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
> -            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
> -            gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
> -            ctx->base.is_jmp = ret = DISAS_NORETURN;
> -        } else {
> -            ctx->base.is_jmp = ret = DISAS_IAQ_N_STALE;
> -        }
> +    /* If the TranslationBlock must end, do so. */
> +    ctx->base.pc_next += 4;
> +    if (ret != DISAS_NEXT) {
> +        return;
>      }
> +    /* Note this also detects a priority change. */
> +    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
> +        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
> +        return;
> +    }
> +
> +    /*
> +     * Advance the insn queue.
> +     * The only exit now is DISAS_TOO_MANY from the translator loop.
> +     */
>      ctx->iaoq_f = ctx->iaoq_b;
>      ctx->iaoq_b = ctx->iaoq_n;
> -    ctx->base.pc_next += 4;
> -
> -    switch (ret) {
> -    case DISAS_NORETURN:
> -    case DISAS_IAQ_N_UPDATED:
> -        break;
> -
> -    case DISAS_NEXT:
> -    case DISAS_IAQ_N_STALE:
> -    case DISAS_IAQ_N_STALE_EXIT:
> -        if (ctx->iaoq_f == -1) {
> -            install_iaq_entries(ctx, -1, cpu_iaoq_b,
> -                                ctx->iaoq_n, ctx->iaoq_n_var);
> -#ifndef CONFIG_USER_ONLY
> -            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
> -#endif
> -            nullify_save(ctx);
> -            ctx->base.is_jmp = (ret == DISAS_IAQ_N_STALE_EXIT
> -                                ? DISAS_EXIT
> -                                : DISAS_IAQ_N_UPDATED);
> -        } else if (ctx->iaoq_b == -1) {
> -            if (ctx->iaoq_n_var) {
> -                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
> -            } else {
> -                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
> -                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
> -                                 gva_offset_mask(ctx->tb_flags));
> -            }
> +    if (ctx->iaoq_b == -1) {
> +        if (ctx->iaoq_n_var) {
> +            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
> +        } else {
> +            tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
> +            tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
> +                             gva_offset_mask(ctx->tb_flags));
>          }
> -        break;
> -
> -    default:
> -        g_assert_not_reached();
>      }
>  }
>  
> @@ -4754,23 +4731,51 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      DisasJumpType is_jmp = ctx->base.is_jmp;
> +    uint64_t fi, bi;
> +    TCGv_i64 fv, bv;
> +    TCGv_i64 fs;
> +
> +    /* Assume the insn queue has not been advanced. */
> +    fi = ctx->iaoq_b;
> +    fv = cpu_iaoq_b;
> +    fs = fi == -1 ? cpu_iasq_b : NULL;
> +    bi = ctx->iaoq_n;
> +    bv = ctx->iaoq_n_var;
>  
>      switch (is_jmp) {
>      case DISAS_NORETURN:
>          break;
>      case DISAS_TOO_MANY:
> -    case DISAS_IAQ_N_STALE:
> -    case DISAS_IAQ_N_STALE_EXIT:
> -        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
> -                            ctx->iaoq_b, cpu_iaoq_b);
> -        nullify_save(ctx);
> +        /* The insn queue has not been advanced. */
> +        bi = fi;
> +        bv = fv;
> +        fi = ctx->iaoq_f;
> +        fv = NULL;
> +        fs = NULL;
>          /* FALLTHRU */
> -    case DISAS_IAQ_N_UPDATED:
> -        if (is_jmp != DISAS_IAQ_N_STALE_EXIT) {
> -            tcg_gen_lookup_and_goto_ptr();
> +    case DISAS_IAQ_N_STALE:
> +        if (use_goto_tb(ctx, fi, bi)
> +            && (ctx->null_cond.c == TCG_COND_NEVER
> +                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
> +            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
> +            gen_goto_tb(ctx, 0, fi, bi);
>              break;
>          }
>          /* FALLTHRU */
> +    case DISAS_IAQ_N_STALE_EXIT:
> +        install_iaq_entries(ctx, fi, fv, bi, bv);
> +        if (fs) {
> +            tcg_gen_mov_i64(cpu_iasq_f, fs);
> +        }
> +        nullify_save(ctx);
> +        if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
> +            tcg_gen_exit_tb(NULL, 0);
> +            break;
> +        }
> +        /* FALLTHRU */
> +    case DISAS_IAQ_N_UPDATED:
> +        tcg_gen_lookup_and_goto_ptr();
> +        break;
>      case DISAS_EXIT:
>          tcg_gen_exit_tb(NULL, 0);
>          break;
> -- 
> 2.34.1
> 

