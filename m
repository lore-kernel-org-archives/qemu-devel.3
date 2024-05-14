Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA57C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6sr4-0006wJ-NG; Tue, 14 May 2024 10:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6sr2-0006vw-Tb
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:10:08 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6sr0-0006H3-Nq
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:10:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6321BCE1259;
 Tue, 14 May 2024 14:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D60C32781;
 Tue, 14 May 2024 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715695801;
 bh=65zaQbh4dR1VfiNCHvFVtTEdgTZHlZVkK+sJMu5eeOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PZ094RnDZE9gn7MeDfalSXYEJjhUx/WonG38Z3c1ga4M0nH8IVDLJVgflFNi19TCq
 maezmpvAKtGoKwNVSs4d1in93XCuHCJ3e17JVQP5TF7sIjjLCwUecbTnKyNIAxbc7e
 /ZrRKpmaQvcFU+yHKcyV68/k7TN1iK85TB5iy3YuR06qXXwl0OCKcNgGT0MsNCQy2d
 ozBWacG+8Sux/Mg0GukgpyMCkhvUnh8jhnlHS2ZdKqGMal1xOJO7TA3xV02MUrUVqr
 0tETBCOf3+NFFCF/kaCIDv72KLSQc+5Z3fpdcKKkqDdHefxMzZpLKMKEvgGWVrgRkl
 TzDnv7i59talQ==
Date: Tue, 14 May 2024 16:09:57 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 05/45] target/hppa: Allow prior nullification in
 do_ibranch
Message-ID: <ZkNwtdPU9RgueW7q@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
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
> Simplify the function by not attempting a conditional move
> on the branch destination -- just use nullify_over normally.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 73 +++++++++++------------------------------
>  1 file changed, 20 insertions(+), 53 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 4c42b518c5..140dfb747a 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1871,17 +1871,15 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
>  static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>                         unsigned link, bool is_n)
>  {
> -    TCGv_i64 a0, a1, next, tmp;
> -    TCGCond c;
> +    TCGv_i64 next;
>  
> -    assert(ctx->null_lab == NULL);
> +    if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
> +        next = tcg_temp_new_i64();
> +        tcg_gen_mov_i64(next, dest);
>  
> -    if (ctx->null_cond.c == TCG_COND_NEVER) {
>          if (link != 0) {
>              copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
>          }
> -        next = tcg_temp_new_i64();
> -        tcg_gen_mov_i64(next, dest);
>          if (is_n) {
>              if (use_nullify_skip(ctx)) {
>                  copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
> @@ -1895,60 +1893,29 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>          }
>          ctx->iaoq_n = -1;
>          ctx->iaoq_n_var = next;
> -    } else if (is_n && use_nullify_skip(ctx)) {
> -        /* The (conditional) branch, B, nullifies the next insn, N,
> -           and we're allowed to skip execution N (no single-step or
> -           tracepoint in effect).  Since the goto_ptr that we must use
> -           for the indirect branch consumes no special resources, we
> -           can (conditionally) skip B and continue execution.  */
> -        /* The use_nullify_skip test implies we have a known control path.  */
> -        tcg_debug_assert(ctx->iaoq_b != -1);
> -        tcg_debug_assert(ctx->iaoq_n != -1);
> +        return true;
> +    }
>  
> -        /* We do have to handle the non-local temporary, DEST, before
> -           branching.  Since IOAQ_F is not really live at this point, we
> -           can simply store DEST optimistically.  Similarly with IAOQ_B.  */
> +    nullify_over(ctx);
> +
> +    if (is_n && use_nullify_skip(ctx)) {
>          copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
>          next = tcg_temp_new_i64();
>          tcg_gen_addi_i64(next, dest, 4);
>          copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
> -
> -        nullify_over(ctx);
> -        if (link != 0) {
> -            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> -        }
> -        tcg_gen_lookup_and_goto_ptr();
> -        return nullify_end(ctx);
> +        nullify_set(ctx, 0);
>      } else {
> -        c = ctx->null_cond.c;
> -        a0 = ctx->null_cond.a0;
> -        a1 = ctx->null_cond.a1;
> -
> -        tmp = tcg_temp_new_i64();
> -        next = tcg_temp_new_i64();
> -
> -        copy_iaoq_entry(ctx, tmp, ctx->iaoq_n, ctx->iaoq_n_var);
> -        tcg_gen_movcond_i64(c, next, a0, a1, tmp, dest);
> -        ctx->iaoq_n = -1;
> -        ctx->iaoq_n_var = next;
> -
> -        if (link != 0) {
> -            tcg_gen_movcond_i64(c, cpu_gr[link], a0, a1, cpu_gr[link], tmp);
> -        }
> -
> -        if (is_n) {
> -            /* The branch nullifies the next insn, which means the state of N
> -               after the branch is the inverse of the state of N that applied
> -               to the branch.  */
> -            tcg_gen_setcond_i64(tcg_invert_cond(c), cpu_psw_n, a0, a1);
> -            cond_free(&ctx->null_cond);
> -            ctx->null_cond = cond_make_n();
> -            ctx->psw_n_nonzero = true;
> -        } else {
> -            cond_free(&ctx->null_cond);
> -        }
> +        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> +        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
> +        nullify_set(ctx, is_n);
>      }
> -    return true;
> +    if (link != 0) {
> +        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> +    }
> +
> +    tcg_gen_lookup_and_goto_ptr();
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return nullify_end(ctx);
>  }
>  
>  /* Implement
> -- 
> 2.34.1
> 

