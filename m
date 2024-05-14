Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B36C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6tJI-00036t-Pc; Tue, 14 May 2024 10:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tJE-000354-Ii
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:39:16 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tJD-0004TL-0w
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:39:16 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9EE2161278;
 Tue, 14 May 2024 14:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21936C2BD10;
 Tue, 14 May 2024 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715697553;
 bh=TOy3jYJwidX0j6VkODIClSLAp8oHdtyeRaFbo+Ed6Tk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sGS4IoMBelESU0YbJbx8uCkXv4Av56B7CeAdcWHXDIptorq+09LmhiwF6C2XwizJJ
 7Iv13Z6l7FXfKcquFmkLOj7yuYTY6cdhMt1riZd4AFTNYFKtsoYX+mvHVIFYHtz38J
 dK0VMNkRfguORArLbEPRgBIq9Vs/+DJoPKH4P0Pz7Kz2ChcpHg/megff3qf/kVRPgB
 y61pG1V0OU9O1mIQLwkC1T6Tt4NSy4ca6eEWt/r8vfe/EdcVUIZ0ljEl99F/d4RiQk
 2lLa8DTIcgOrvDTrSgbkPob1uSMS6pigBaU/Qz0FLkZeA4DoOFReIGXHRfG7+RTg8U
 yjbMV7DHcTffw==
Date: Tue, 14 May 2024 16:39:09 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 09/45] target/hppa: Delay computation of IAQ_Next
Message-ID: <ZkN3jdnA2WCa-Z9N@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-10-richard.henderson@linaro.org>
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
> We no longer have to allocate a temp and perform an
> addition before translation of the rest of the insn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index f816b337ee..a9196050dc 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1806,6 +1806,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
>      if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
>          install_link(ctx, link, false);
>          ctx->iaoq_n = dest;
> +        ctx->iaoq_n_var = NULL;
>          if (is_n) {
>              ctx->null_cond.c = TCG_COND_ALWAYS;
>          }
> @@ -1862,11 +1863,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
>              ctx->null_lab = NULL;
>          }
>          nullify_set(ctx, n);
> -        if (ctx->iaoq_n == -1) {
> -            /* The temporary iaoq_n_var died at the branch above.
> -               Regenerate it here instead of saving it.  */
> -            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
> -        }
>          gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
>      }
>  
> @@ -4630,8 +4626,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
>      ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
>  #endif
> -    ctx->iaoq_n = -1;
> -    ctx->iaoq_n_var = NULL;
>  
>      ctx->zero = tcg_constant_i64(0);
>  
> @@ -4683,14 +4677,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>  
>          /* Set up the IA queue for the next insn.
>             This will be overwritten by a branch.  */
> -        if (ctx->iaoq_b == -1) {
> -            ctx->iaoq_n = -1;
> -            ctx->iaoq_n_var = tcg_temp_new_i64();
> -            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
> -        } else {
> -            ctx->iaoq_n = ctx->iaoq_b + 4;
> -            ctx->iaoq_n_var = NULL;
> -        }
> +        ctx->iaoq_n_var = NULL;
> +        ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
>  
>          if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
>              ctx->null_cond.c = TCG_COND_NEVER;
> @@ -4741,7 +4729,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>                                  ? DISAS_EXIT
>                                  : DISAS_IAQ_N_UPDATED);
>          } else if (ctx->iaoq_b == -1) {
> -            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
> +            if (ctx->iaoq_n_var) {
> +                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
> +            } else {
> +                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
> +                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
> +                                 gva_offset_mask(ctx->tb_flags));
> +            }
>          }
>          break;
>  
> -- 
> 2.34.1
> 

