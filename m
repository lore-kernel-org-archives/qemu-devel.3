Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C37C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdWH-0005AC-Sv; Fri, 21 Mar 2025 10:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdWF-00059N-0B
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:38:43 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdWB-00008U-Qk
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9sStlq0EZGMEMQMstPehaz6QAHeBtjG7+rm2N7/Ka00=; b=HFimjtdIwiXjN+l
 ++gz+LnFw7jUP0RUacMVE0yaEMJ3hucaz1/M0E/YdF/KWM70ZWlrZdeeDHAFCVFEsPBQzcq63kHR/
 q1FOEJIXKExdh61FYED5wbeRzf205fkCbUU1tsN+8tcOweJJF1eD9YSU0dEEg0h9lPZHSFCWgrQBk
 3A=;
Date: Fri, 21 Mar 2025 15:39:07 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH-for-10.1 3/4] tcg: Have tcg_req_mo() use runtime
 TCGContext::guest_mo
Message-ID: <obxwsiulhaid5f5rpjdgaclzzbay4dgs4jko2wxyojk5lwjmm5@7gctc6ef5n7s>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321125737.72839-4-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 21/03/25, Philippe Mathieu-Daudé wrote:
> In order to use TCG with multiple targets, replace the
> compile time use of TCG_GUEST_DEFAULT_MO by a runtime
> access to tcg_ctx->guest_mo.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/internal-target.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 1cb35dba99e..014ee756f9d 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -49,11 +49,9 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
>   * Filter @type to the barrier that is required for the guest
>   * memory ordering vs the host memory ordering.  A non-zero
>   * result indicates that some barrier is required.
> - *
> - * This is a macro so that it's constant even without optimization.
>   */
>  #define tcg_req_mo(type) \
> -    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
> +    ((type) & tcg_ctx->guest_mo & ~TCG_TARGET_DEFAULT_MO)
>  
>  /**
>   * cpu_req_mo:
> -- 
> 2.47.1
> 

I'll parrot some older feedback by Richard

  https://lore.kernel.org/all/92cc9335-10bf-4a74-9eb4-249de5545dc5@linaro.org/

but tcg_ctx->guest_mo can be undefined or bogus here. Could we not
take cpu and access cpu->cc->tcg_ops->guest_default_memory_order
directly instead?

