Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDFC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdY0-0006bi-VE; Fri, 21 Mar 2025 10:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdXw-0006VF-C4
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:40:30 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdXu-0001lu-Th
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NgB6owUoLoea0lvUlOThUfm9c2hm+nriJ0fBcoKGBys=; b=s9C40c5+7C3Ga+7
 K6EF1exF7y4PJexfR9dgZXbkzWb1oIJM18yKt57Ene9lYWmPiUuAs7VJdv1Skr04bgHX/uOTHHogx
 HRE+X/RQuRlpYudyEvM3cckK6eovjQ+70Cluhss3nriSEjqhyFmcnUCp9m3Vj7hy19dbtJv+71g6J
 vI=;
Date: Fri, 21 Mar 2025 15:40:55 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-10.1 2/4] tcg: Simplify tcg_req_mo() macro
Message-ID: <xjpdx5lqp22kjt6qdc375m6dbwhdqzukyeyvnvivadoepz7dnj@k34hf2pksrme>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321125737.72839-3-philmd@linaro.org>
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
> Now that TCG_GUEST_DEFAULT_MO is always defined,
> simplify the tcg_req_mo() macro.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/internal-target.h | 9 +--------
>  accel/tcg/tcg-all.c         | 3 ---
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 2cdf11c905e..1cb35dba99e 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -50,17 +50,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
>   * memory ordering vs the host memory ordering.  A non-zero
>   * result indicates that some barrier is required.
>   *
> - * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
> - * guest requires strict ordering.
> - *
>   * This is a macro so that it's constant even without optimization.
>   */
> -#ifdef TCG_GUEST_DEFAULT_MO
> -# define tcg_req_mo(type) \
> +#define tcg_req_mo(type) \
>      ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
> -#else
> -# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
> -#endif
>  
>  /**
>   * cpu_req_mo:
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c1a30b01219..cb632cc8cc7 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
>          return false;
>      }
>  #ifdef TARGET_SUPPORTS_MTTCG
> -# ifndef TCG_GUEST_DEFAULT_MO
> -#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
> -# endif
>      return true;
>  #else
>      return false;
> -- 
> 2.47.1
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

