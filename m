Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1B1C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6u01-0006YR-V4; Tue, 14 May 2024 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tzz-0006YI-RG
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:23:28 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tzw-000688-4T
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:23:26 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2D391CE128B;
 Tue, 14 May 2024 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4123C2BD10;
 Tue, 14 May 2024 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715700199;
 bh=QsLYuIkGu4+186Tvnw8DiJinTGJOfLfoUJcRJDN0iPE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjB32hz9Rk7/3hW7Ba4S/SDKC/5WKW2ylC157H8K3gfO6dPwk6Mc5JAlmqSWuMdDZ
 ehfXS8OBuE689fuBB5rtz9JfPe8B/+lsiz0TQdjk4eE/FLbvI28j6yorvsFmxN+rsr
 h0VDoEmci3M2jlVO/ff0XhzzhxxrS63FEQvIkLTLGtN9sbiGUjeL2Lw+Z+3zlvAzYH
 GsOiUCSRyd4u7j+JkNBDV8unChsbVJjIKNYyMeE+GCu6YWzwGhW7Kjl6c3UVX1j6jh
 yhOIwZj1d32SxrE0p5texDn9nwBYxMGUseaFTvi7Aolg68hpbIPZDL2KFyKaOZ/wRW
 ExV8lKxMhLzRw==
Date: Tue, 14 May 2024 17:23:14 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 12/45] target/hppa: Add IASQ entries to DisasContext
Message-ID: <ZkOB4hPnbI65MHer@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-13-richard.henderson@linaro.org>
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
> Add variable to track space changes to IAQ.  So far, no such changes
> are introduced, but the new checks vs ctx->iasq_b may eliminate an
> unnecessary copy to cpu_iasq_f with e.g. BLR.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 13a48d1b6c..d24220c60f 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -50,6 +50,13 @@ typedef struct DisasContext {
>      uint64_t iaoq_b;
>      uint64_t iaoq_n;
>      TCGv_i64 iaoq_n_var;
> +    /*
> +     * Null when IASQ_Back unchanged from IASQ_Front,
> +     * or cpu_iasq_b, when IASQ_Back has been changed.
> +     */
> +    TCGv_i64 iasq_b;
> +    /* Null when IASQ_Next unchanged from IASQ_Back, or set by branch. */
> +    TCGv_i64 iasq_n;
>  
>      DisasCond null_cond;
>      TCGLabel *null_lab;
> @@ -3916,12 +3923,12 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>      if (a->n && use_nullify_skip(ctx)) {
>          install_iaq_entries(ctx, -1, tmp, -1, NULL);
>          tcg_gen_mov_i64(cpu_iasq_f, new_spc);
> -        tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
> +        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
>          nullify_set(ctx, 0);
>      } else {
>          install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
> -        if (ctx->iaoq_b == -1) {
> -            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
> +        if (ctx->iasq_b) {
> +            tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
>          }
>          tcg_gen_mov_i64(cpu_iasq_b, new_spc);
>          nullify_set(ctx, a->n);
> @@ -4035,8 +4042,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
>  
>      install_link(ctx, a->l, false);
>      install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
> -    if (ctx->iaoq_b == -1) {
> -        tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
> +    if (ctx->iasq_b) {
> +        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
>      }
>      tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
>      nullify_set(ctx, a->n);
> @@ -4617,6 +4624,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      ctx->mmu_idx = MMU_USER_IDX;
>      ctx->iaoq_f = ctx->base.pc_first | ctx->privilege;
>      ctx->iaoq_b = ctx->base.tb->cs_base | ctx->privilege;
> +    ctx->iasq_b = NULL;
>      ctx->unalign = (ctx->tb_flags & TB_FLAG_UNALIGN ? MO_UNALN : MO_ALIGN);
>  #else
>      ctx->privilege = (ctx->tb_flags >> TB_FLAG_PRIV_SHIFT) & 3;
> @@ -4631,6 +4639,7 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  
>      ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
>      ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
> +    ctx->iasq_b = (diff ? NULL : cpu_iasq_b);
>  #endif
>  
>      ctx->zero = tcg_constant_i64(0);
> @@ -4683,6 +4692,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>  
>          /* Set up the IA queue for the next insn.
>             This will be overwritten by a branch.  */
> +        ctx->iasq_n = NULL;
>          ctx->iaoq_n_var = NULL;
>          ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
>  
> @@ -4705,7 +4715,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>          return;
>      }
>      /* Note this also detects a priority change. */
> -    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
> +    if (ctx->iaoq_b != ctx->iaoq_f + 4 || ctx->iasq_b) {
>          ctx->base.is_jmp = DISAS_IAQ_N_STALE;
>          return;
>      }
> @@ -4725,6 +4735,10 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
>                               gva_offset_mask(ctx->tb_flags));
>          }
>      }
> +    if (ctx->iasq_n) {
> +        tcg_gen_mov_i64(cpu_iasq_b, ctx->iasq_n);
> +        ctx->iasq_b = cpu_iasq_b;
> +    }
>  }
>  
>  static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
> @@ -4733,14 +4747,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>      DisasJumpType is_jmp = ctx->base.is_jmp;
>      uint64_t fi, bi;
>      TCGv_i64 fv, bv;
> -    TCGv_i64 fs;
> +    TCGv_i64 fs, bs;
>  
>      /* Assume the insn queue has not been advanced. */
>      fi = ctx->iaoq_b;
>      fv = cpu_iaoq_b;
> -    fs = fi == -1 ? cpu_iasq_b : NULL;
> +    fs = ctx->iasq_b;
>      bi = ctx->iaoq_n;
>      bv = ctx->iaoq_n_var;
> +    bs = ctx->iasq_n;
>  
>      switch (is_jmp) {
>      case DISAS_NORETURN:
> @@ -4749,12 +4764,15 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>          /* The insn queue has not been advanced. */
>          bi = fi;
>          bv = fv;
> +        bs = fs;
>          fi = ctx->iaoq_f;
>          fv = NULL;
>          fs = NULL;
>          /* FALLTHRU */
>      case DISAS_IAQ_N_STALE:
> -        if (use_goto_tb(ctx, fi, bi)
> +        if (fs == NULL
> +            && bs == NULL
> +            && use_goto_tb(ctx, fi, bi)
>              && (ctx->null_cond.c == TCG_COND_NEVER
>                  || ctx->null_cond.c == TCG_COND_ALWAYS)) {
>              nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
> @@ -4767,6 +4785,9 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>          if (fs) {
>              tcg_gen_mov_i64(cpu_iasq_f, fs);
>          }
> +        if (bs) {
> +            tcg_gen_mov_i64(cpu_iasq_b, bs);
> +        }
>          nullify_save(ctx);
>          if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
>              tcg_gen_exit_tb(NULL, 0);
> -- 
> 2.34.1
> 

