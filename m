Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2806FC47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgrJ-000151-6p; Wed, 24 Jan 2024 12:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgrH-00014U-OY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:16:15 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgrG-00058c-Bd
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7c0RD537cBmM5SkRZ2B9bepydxHuTZG8KLrAk0JW6Ns=; b=JNBUUbWGk4/1WmwKK+NGtv9BbG
 4ElRc3VzgM8d/KO5X4RgWhLIUEen+c5QYCnOYQtXEb88GFFbzzNLz9bt3dHbJvOnm/0az6tc9y4Mn
 L6mCODj5DW3fLBCdVw3Rc/HyMBSDKcwVZRUXpVgxsacSW5hfMLd52vRvbv5WGkwYJ/zU=;
Date: Wed, 24 Jan 2024 18:16:21 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 6/9] accel/tcg: Introduce
 TCGCPUOps::need_replay_interrupt() handler
Message-ID: <vfxf6pjg4rzoqyrdcurl2nrsslxm4nnnawoummr4xa2qaesd5p@27zzk5w4fzjx>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-7-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/01/24, Philippe Mathieu-Daudé wrote:
> In order to make accel/tcg/ target agnostic,
> introduce the need_replay_interrupt() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/tcg-cpu-ops.h | 5 +++++
>  accel/tcg/cpu-exec.c          | 5 ++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index 479713a36e..2fae3ac70f 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -170,6 +170,11 @@ struct TCGCPUOps {
>       */
>      bool (*io_recompile_replay_branch)(CPUState *cpu,
>                                         const TranslationBlock *tb);
> +    /**
> +     * @need_replay_interrupt: Return %true if @interrupt_request
> +     * needs to be recorded for replay purposes.
> +     */
> +    bool (*need_replay_interrupt)(int interrupt_request);
>  #endif /* !CONFIG_USER_ONLY */
>  #endif /* NEED_CPU_H */
>  
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index b10472cbc7..4ab7d6c896 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -778,7 +778,10 @@ static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
>  #if defined(TARGET_I386)
>      return !(interrupt_request & CPU_INTERRUPT_POLL);
>  #else
> -    return true;
> +    if (!cc->tcg_ops->need_replay_interrupt) {
> +        return true;
> +    }
> +    return cc->tcg_ops->need_replay_interrupt(interrupt_request);
>  #endif
>  }
>  #endif /* !CONFIG_USER_ONLY */
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

