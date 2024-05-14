Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56DC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6st8-0008QC-DD; Tue, 14 May 2024 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6st7-0008Q3-O8
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:12:17 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6st5-00076v-Pv
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:12:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A8165CE1259;
 Tue, 14 May 2024 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEFBC2BD10;
 Tue, 14 May 2024 14:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715695929;
 bh=fpz/trujAnHomH6zQTxCiSQkskc+lc8u8AonreqeD5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K4I1JKReJGbf2NNaU/Tjcd8Oq+FHjQimcHTIFfxFiOjzxHGctkGzecSPgWLJjdFs8
 SryV21X3hyfZs5+wB/iAJLpg+phYxOpK/zwoTHVvzi/jinfJNs/LEEDuRLhS2htd6p
 vKAgnTIVA9eLphdRflSKhyuiWGrcKkzXsrWuUDtNa8xX7xFRZiuSEDSu+lvO+XbNcn
 D35OlEd/Q9RcwABDUxAJ5u8qliDGT/YI2Kf0jbcIfl9HH05Kpf4H+5MJYAfse6QBEj
 SxQFLk21Hi99mEz0JkYfIRI5dOxmCoVY1L7PBRtScPRIb7Y/Y03XrGS+uLXVHF4zZC
 13N4b1sBP/VNQ==
Date: Tue, 14 May 2024 16:12:05 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 06/45] target/hppa: Use CF_BP_PAGE instead of
 cpu_breakpoint_test
Message-ID: <ZkNxNYgdniCwu9-6@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-7-richard.henderson@linaro.org>
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
> The generic tcg driver will have already checked for breakpoints.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 140dfb747a..d272be0e6e 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -674,8 +674,9 @@ static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
>     executing a TB that merely branches to the next TB.  */
>  static bool use_nullify_skip(DisasContext *ctx)
>  {
> -    return (((ctx->iaoq_b ^ ctx->iaoq_f) & TARGET_PAGE_MASK) == 0
> -            && !cpu_breakpoint_test(ctx->cs, ctx->iaoq_b, BP_ANY));
> +    return (!(tb_cflags(ctx->base.tb) & CF_BP_PAGE)
> +            && ctx->iaoq_b != -1
> +            && is_same_page(&ctx->base, ctx->iaoq_b));
>  }
>  
>  static void gen_goto_tb(DisasContext *ctx, int which,
> -- 
> 2.34.1
> 

