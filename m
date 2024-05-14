Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B0C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6t4N-0005cM-Da; Tue, 14 May 2024 10:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6t4L-0005bb-AQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:23:53 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6t4J-000186-9J
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:23:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E67796126A;
 Tue, 14 May 2024 14:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD88C4AF0A;
 Tue, 14 May 2024 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715696628;
 bh=zL17vCeCvWbun8VPutiQYP0L73hN/oGFOlym9kuT8Fg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O3Ba8ppy0dYAQceK+AevqECN6jthKxoFDfeaFi7JuXV6RAtTtOWfloinxq7ockuL1
 dJ0eeW6ZqLAWFnxH+pVE1z4P9gtYUS6weQOBlfPIAMmET87Ja5SggJ3OicAbRgFilk
 Aw07EGo4Nqq1TQwZgC8MBExNiJoaR9kDaQcepY2A+VgM3kd7hT4an8XohEiizTbKEK
 7rTooOXToDWNpagfPKjLNYcwEPIH68iL8NhC5d8CecmS4hqIhMMfiHbl48lMcxw706
 YI4zVEi09oX/qOld7hAO0MwJb/Wjd7YMUclBzappyy+MZZ2m2abYsvasciCUw7CNBT
 5KNZPMtsiHRdw==
Date: Tue, 14 May 2024 16:23:44 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 07/45] target/hppa: Add install_iaq_entries
Message-ID: <ZkNz8PDdBBV77kB7@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-8-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
> Instead of two separate cpu_iaoq_entry calls, use one call to update
> both IAQ_Front and IAQ_Back.  Simplify with an argument combination
> that automatically handles a simple increment from Front to Back.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 64 +++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index d272be0e6e..08d5e2a4bc 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -617,6 +617,23 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
>      }
>  }
>  
> +static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
> +                                uint64_t ni, TCGv_i64 nv)
> +{
> +    copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
> +
> +    /* Allow ni variable, with nv null, to indicate a trivial advance. */
> +    if (ni != -1 || nv) {
> +        copy_iaoq_entry(ctx, cpu_iaoq_b, ni, nv);
> +    } else if (bi != -1) {
> +        copy_iaoq_entry(ctx, cpu_iaoq_b, bi + 4, NULL);
> +    } else {
> +        tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_f, 4);
> +        tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
> +                         gva_offset_mask(ctx->tb_flags));
> +    }
> +}
> +
>  static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
>  {
>      return ctx->iaoq_f + disp + 8;
> @@ -629,8 +646,7 @@ static void gen_excp_1(int exception)
>  
>  static void gen_excp(DisasContext *ctx, int exception)
>  {
> -    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
> -    copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
> +    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
>      nullify_save(ctx);
>      gen_excp_1(exception);
>      ctx->base.is_jmp = DISAS_NORETURN;
> @@ -684,12 +700,10 @@ static void gen_goto_tb(DisasContext *ctx, int which,
>  {
>      if (use_goto_tb(ctx, b, n)) {
>          tcg_gen_goto_tb(which);
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, b, NULL);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, n, NULL);
> +        install_iaq_entries(ctx, b, NULL, n, NULL);
>          tcg_gen_exit_tb(ctx->base.tb, which);
>      } else {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, b, cpu_iaoq_b);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, n, ctx->iaoq_n_var);
> +        install_iaq_entries(ctx, b, cpu_iaoq_b, n, ctx->iaoq_n_var);
>          tcg_gen_lookup_and_goto_ptr();
>      }
>  }
> @@ -1883,9 +1897,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>          }
>          if (is_n) {
>              if (use_nullify_skip(ctx)) {
> -                copy_iaoq_entry(ctx, cpu_iaoq_f, -1, next);
> -                tcg_gen_addi_i64(next, next, 4);
> -                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
> +                install_iaq_entries(ctx, -1, next, -1, NULL);
>                  nullify_set(ctx, 0);
>                  ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
>                  return true;
> @@ -1900,14 +1912,10 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>      nullify_over(ctx);
>  
>      if (is_n && use_nullify_skip(ctx)) {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, dest);
> -        next = tcg_temp_new_i64();
> -        tcg_gen_addi_i64(next, dest, 4);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, next);
> +        install_iaq_entries(ctx, -1, dest, -1, NULL);
>          nullify_set(ctx, 0);
>      } else {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
> +        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
>          nullify_set(ctx, is_n);
>      }
>      if (link != 0) {
> @@ -1998,9 +2006,7 @@ static void do_page_zero(DisasContext *ctx)
>          tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
>          tmp = tcg_temp_new_i64();
>          tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
> -        tcg_gen_addi_i64(tmp, tmp, 4);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
> +        install_iaq_entries(ctx, -1, tmp, -1, NULL);
>          ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
>          break;
>  
> @@ -2744,8 +2750,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
>              nullify_over(ctx);
>  
>              /* Advance the instruction queue.  */
> -            copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> -            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
> +            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
> +                                ctx->iaoq_n, ctx->iaoq_n_var);
>              nullify_set(ctx, 0);
>  
>              /* Tell the qemu main loop to halt until this cpu has work.  */
> @@ -3898,18 +3904,15 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>          tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
>      }
>      if (a->n && use_nullify_skip(ctx)) {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, -1, tmp);
> -        tcg_gen_addi_i64(tmp, tmp, 4);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
> +        install_iaq_entries(ctx, -1, tmp, -1, NULL);
>          tcg_gen_mov_i64(cpu_iasq_f, new_spc);
>          tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
>          nullify_set(ctx, 0);
>      } else {
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> +        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
>          if (ctx->iaoq_b == -1) {
>              tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
>          }
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>          tcg_gen_mov_i64(cpu_iasq_b, new_spc);
>          nullify_set(ctx, a->n);
>      }
> @@ -4018,11 +4021,10 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
>      nullify_over(ctx);
>      dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
>  
> -    copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> +    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
>      if (ctx->iaoq_b == -1) {
>          tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
>      }
> -    copy_iaoq_entry(ctx, cpu_iaoq_b, -1, dest);
>      tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
>      if (a->l) {
>          copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
> @@ -4721,8 +4723,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>      case DISAS_IAQ_N_STALE:
>      case DISAS_IAQ_N_STALE_EXIT:
>          if (ctx->iaoq_f == -1) {
> -            copy_iaoq_entry(ctx, cpu_iaoq_f, -1, cpu_iaoq_b);
> -            copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_n, ctx->iaoq_n_var);
> +            install_iaq_entries(ctx, -1, cpu_iaoq_b,
> +                                ctx->iaoq_n, ctx->iaoq_n_var);
>  #ifndef CONFIG_USER_ONLY
>              tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
>  #endif
> @@ -4751,8 +4753,8 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>      case DISAS_TOO_MANY:
>      case DISAS_IAQ_N_STALE:
>      case DISAS_IAQ_N_STALE_EXIT:
> -        copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
> -        copy_iaoq_entry(ctx, cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
> +        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
> +                            ctx->iaoq_b, cpu_iaoq_b);
>          nullify_save(ctx);
>          /* FALLTHRU */
>      case DISAS_IAQ_N_UPDATED:
> -- 
> 2.34.1
> 

