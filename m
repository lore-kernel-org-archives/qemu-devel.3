Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4925C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgbX-0000OX-Bm; Wed, 24 Jan 2024 11:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgbV-0000O2-VU
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:59:58 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgbU-000855-Di
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1AwhFcMNK+H+ByWYZA3Uwum0/Jr1fRDNvvPn8PR+E6k=; b=R20X0nSJt0H+qEgHLR5BhvFK3j
 NLf1VlA/zTAEfPIHAQghxE8J3uX21+NdnQtemxQGFEFTfLSmhrFpUiZA5b/CugvNryAXhAAMq8rml
 vOQQXwPrfi5jGx2LC5fM+AKtdB84U9YRc+i18Gp9bO9lp3qvTBor6rVb2kuJ9VBhblUk=;
Date: Wed, 24 Jan 2024 18:00:00 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 4/9] accel/tcg: Un-inline icount_exit_request() for clarity
Message-ID: <caeefclqspckadhulpnqdybq4cydukzmerolmxnukmczmkzzqn@7niz65r6yvoc>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-5-philmd@linaro.org>
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
> Convert packed logic to dumb icount_exit_request() helper.
> No functional change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 6b3f66930e..d61b285d5e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -791,6 +791,17 @@ static inline bool need_replay_interrupt(int interrupt_request)
>  }
>  #endif /* !CONFIG_USER_ONLY */
>  
> +static inline bool icount_exit_request(CPUState *cpu)
> +{
> +    if (!icount_enabled()) {
> +        return false;
> +    }
> +    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
> +        return false;
> +    }
> +    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
> +}
> +
>  static inline bool cpu_handle_interrupt(CPUState *cpu,
>                                          TranslationBlock **last_tb)
>  {
> @@ -896,10 +907,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      }
>  
>      /* Finally, check if we need to exit to the main loop.  */
> -    if (unlikely(qatomic_read(&cpu->exit_request))
> -        || (icount_enabled()
> -            && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
> -            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0)) {
> +    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
>          qatomic_set(&cpu->exit_request, 0);
>          if (cpu->exception_index == -1) {
>              cpu->exception_index = EXCP_INTERRUPT;
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

