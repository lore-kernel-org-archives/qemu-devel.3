Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AE5D6ACF4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGLmu-0001m4-RT; Wed, 27 Nov 2024 12:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tGLmt-0001kP-FE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:25:15 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tGLmr-0007yV-FK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 12:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=LR7opar0egR/IAAOFgxbIY8BMSl6v5RQsq3KfIztrZI=; b=wZD0sC2sEhqFrQ9
 szOt0pTsZoNwyP1urQkD3NNLFT8hB+1VPDWkE8DViwHiHj7LaJIJx1x5KlDfrzGLvV/BhSH3JtNhO
 IWWlrEqH1M5yRamcQ0Z8O4QhcAnAZDDmJF1+Cbl2lyr+MD+QvguSxjNzAoEchits1MmUTOiQFdwCm
 jY=;
Date: Wed, 27 Nov 2024 18:28:07 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH-for-10.0 6/6] accel/tcg: Allow tcg_exec_realizefn()
 initialize multiple frontends
Message-ID: <pfndwuswldc3bqu5p4uof53nu6wxuvoeuzsbo3c7uaqij7go3e@yypfckmjv4dc>
References: <20241127121658.88966-1-philmd@linaro.org>
 <20241127121658.88966-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127121658.88966-7-philmd@linaro.org>
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

On 27/11/24, Philippe Mathieu-Daudé wrote:
> Rather than initializing the first random target architecture
> and ignore the following ones when a global boolean is set,
> use a bitmask allowing different frontend targets to be
> initialized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ab77740c954..b37995f7d0c 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1070,16 +1070,17 @@ int cpu_exec(CPUState *cpu)
>  
>  bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
>  {
> +    static unsigned initialized_targets;
>      const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>  
> -    if (!tcg_target_initialized) {
> +    if (!(initialized_targets & tcg_ops->arch_id)) {
>          /* Check mandatory TCGCPUOps handlers */
>  #ifndef CONFIG_USER_ONLY
>          assert(tcg_ops->cpu_exec_halt);
>          assert(tcg_ops->cpu_exec_interrupt);
>  #endif /* !CONFIG_USER_ONLY */
>          tcg_ops->initialize_once();
> -        tcg_target_initialized = true;
> +        initialized_targets |= tcg_ops->arch_id;
>      }
>  
>      cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
> -- 
> 2.45.2
> 

Only suggestion would be to assert that arch_id is set, might save some
headache in the future.

Reviewed-by: Anton Johansson <anjo@rev.ng>

