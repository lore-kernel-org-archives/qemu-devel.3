Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFE3C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6tKG-0003jc-91; Tue, 14 May 2024 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tKF-0003ht-BJ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:40:19 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tKD-0004nG-Nk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:40:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 559ADCE1290;
 Tue, 14 May 2024 14:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A0C2BD10;
 Tue, 14 May 2024 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715697612;
 bh=UdRXETdLZBOXYJq1qO0i4UoDuCLL+FQJQQtp61Qifrg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PXSJLBEpxeMa46Up7TAYbVEykrlOTO+Rv9tTB1MQdBcfnYri7RGy1UaHQ4qTE63ob
 VbYuwLsppFWCl5RHM6ybHDwQTLqKBaSiE4TEBFDlfJHvz0cylN5ijOq+X/Nlj9CWcA
 Xv+coNCGowFjyWYow830EMHtTpcMXJVT4JZ5iWn5TRkvxCfe8gg8Hakqn6E7N43xLR
 lPDriM3sbm7hwKGslnQTkISBrlRkPYrljcx7WHS2UIKek06lJriz5LX/Gt63wH3K94
 DzYkwepR41OqeaLF/zIzZl/xxXaXmHp+maC1lO+GhOBNMGpn1H4JhWhePiH9fVXkg8
 Iu+TvZQce2Thg==
Date: Tue, 14 May 2024 16:40:08 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 10/45] target/hppa: Skip nullified insns in
 unconditional dbranch path
Message-ID: <ZkN3yGMFNhRHcn6u@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-11-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-11-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index a9196050dc..ca979f4137 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1805,11 +1805,17 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
>  
>      if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
>          install_link(ctx, link, false);
> -        ctx->iaoq_n = dest;
> -        ctx->iaoq_n_var = NULL;
>          if (is_n) {
> +            if (use_nullify_skip(ctx)) {
> +                nullify_set(ctx, 0);
> +                gen_goto_tb(ctx, 0, dest, dest + 4);
> +                ctx->base.is_jmp = DISAS_NORETURN;
> +                return true;
> +            }
>              ctx->null_cond.c = TCG_COND_ALWAYS;
>          }
> +        ctx->iaoq_n = dest;
> +        ctx->iaoq_n_var = NULL;
>      } else {
>          nullify_over(ctx);
>  
> -- 
> 2.34.1
> 

