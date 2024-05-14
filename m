Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9A6C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6soy-0005TO-Ak; Tue, 14 May 2024 10:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6sow-0005So-Jp
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:07:58 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6sou-00063c-Uz
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:07:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DA93E6125E;
 Tue, 14 May 2024 14:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D81BC2BD10;
 Tue, 14 May 2024 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715695674;
 bh=RY+kvk+PzCiN/eDydmCz9IAww+JJLS0OlAlWX/l3Bb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VidVFakW1PqRW5fLsLwb0UKY+71NFB/hn8jUkVamczOz7FcUwRbSGqoO98eMhmFnO
 iEvvxtELMEuchxJopUW96r/xegbt5NUDiaIYm7z1HbLZKc3R4YxiACEU9wq3j5b4LY
 pa7QkBqr0r0LTBzMH1p6KrkbQQC4S9L3GpogKguNWsvDV9SG/u9hWY4oBGliFvbI34
 VDOCH62ykn/loIpt10D2ojQ6Pk0XtKcx8yTPlaXiAOwVV2cWCUW+SSgLh7vZXKBmz0
 bf8SZnYBGLxGc0ZfLhqsH1ebYx+1W6FX6egRpRv16Dyy3OBBl4UAYYdZam2g71rJpI
 hRWMb5VLb8jkQ==
Date: Tue, 14 May 2024 16:07:50 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 04/45] target/hppa: Pass displacement to do_dbranch
Message-ID: <ZkNwNqGwd9QK9hy6@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-5-richard.henderson@linaro.org>
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
> Pass a displacement instead of an absolute value.
> 
> In trans_be, remove the user-only do_dbranch case.  The branch we are
> attempting to optimize is to the zero page, which is perforce on a
> different page than the code currently executing, which means that
> we will *not* use a goto_tb.  Use a plain indirect branch instead,
> which is what we got out of the attempted direct branch anyway.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 398803981c..4c42b518c5 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1766,9 +1766,11 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
>  
>  /* Emit an unconditional branch to a direct target, which may or may not
>     have already had nullification handled.  */
> -static bool do_dbranch(DisasContext *ctx, uint64_t dest,
> +static bool do_dbranch(DisasContext *ctx, int64_t disp,
>                         unsigned link, bool is_n)
>  {
> +    uint64_t dest = iaoq_dest(ctx, disp);
> +
>      if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
>          if (link != 0) {
>              copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> @@ -1815,10 +1817,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
>  
>      /* Handle TRUE and NEVER as direct branches.  */
>      if (c == TCG_COND_ALWAYS) {
> -        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
> -    }
> -    if (c == TCG_COND_NEVER) {
> -        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
> +        return do_dbranch(ctx, disp, 0, is_n && disp >= 0);
>      }
>  
>      taken = gen_new_label();
> @@ -3914,22 +3913,6 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>  {
>      TCGv_i64 tmp;
>  
> -#ifdef CONFIG_USER_ONLY
> -    /* ??? It seems like there should be a good way of using
> -       "be disp(sr2, r0)", the canonical gateway entry mechanism
> -       to our advantage.  But that appears to be inconvenient to
> -       manage along side branch delay slots.  Therefore we handle
> -       entry into the gateway page via absolute address.  */
> -    /* Since we don't implement spaces, just branch.  Do notice the special
> -       case of "be disp(*,r0)" using a direct branch to disp, so that we can
> -       goto_tb to the TB containing the syscall.  */
> -    if (a->b == 0) {
> -        return do_dbranch(ctx, a->disp, a->l, a->n);
> -    }
> -#else
> -    nullify_over(ctx);
> -#endif
> -
>      tmp = tcg_temp_new_i64();
>      tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
>      tmp = do_ibranch_priv(ctx, tmp);
> @@ -3939,6 +3922,8 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>  #else
>      TCGv_i64 new_spc = tcg_temp_new_i64();
>  
> +    nullify_over(ctx);
> +
>      load_spr(ctx, new_spc, a->sp);
>      if (a->l) {
>          copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
> @@ -3968,7 +3953,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>  
>  static bool trans_bl(DisasContext *ctx, arg_bl *a)
>  {
> -    return do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
> +    return do_dbranch(ctx, a->disp, a->l, a->n);
>  }
>  
>  static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
> @@ -4022,7 +4007,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
>          save_gpr(ctx, a->l, tmp);
>      }
>  
> -    return do_dbranch(ctx, dest, 0, a->n);
> +    return do_dbranch(ctx, dest - iaoq_dest(ctx, 0), 0, a->n);
>  }
>  
>  static bool trans_blr(DisasContext *ctx, arg_blr *a)
> @@ -4035,7 +4020,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
>          return do_ibranch(ctx, tmp, a->l, a->n);
>      } else {
>          /* BLR R0,RX is a good way to load PC+8 into RX.  */
> -        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
> +        return do_dbranch(ctx, 0, a->l, a->n);
>      }
>  }
>  
> -- 
> 2.34.1
> 

