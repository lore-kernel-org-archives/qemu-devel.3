Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D2C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 06:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsoU-0000so-2T; Thu, 25 Jan 2024 01:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rSsoM-0000mD-BK
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:02:03 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rSsoC-0007SY-Rh
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 01:02:01 -0500
Received: from [192.168.55.37] (unknown [85.249.19.23])
 by mail.ispras.ru (Postfix) with ESMTPSA id 905324076B5F;
 Thu, 25 Jan 2024 06:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 905324076B5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1706162481;
 bh=hqQstllsny1gNLQpMOwvWkCYEf5IruhRrOzFwmkusoE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o0VN5zi8GjHTUBYcS7jA11R+1g5M7nndMPP0tMbb6i8t8Ra+sWedrDY4bcPG4UHGA
 49ejjF9OyHHN/BQ2//+Oo1jJAQlB+xjNRnLba/FN5PH00IJ44GmCaxBT+qwGL6qu1j
 VgNRsXgn3vZjG+eJQK16SivkKZjeHIPyWoednkBg=
Message-ID: <24c52b15-2c7d-48af-b73c-152bc36679e2@ispras.ru>
Date: Thu, 25 Jan 2024 09:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] target/i386: Extract x86_need_replay_interrupt() from
 accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-8-philmd@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240124101639.30056-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL=0.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 24.01.2024 13:16, Philippe Mathieu-Daudé wrote:
> Move this x86-specific code out of the generic accel/tcg/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/tcg/helper-tcg.h        |  1 +
>   accel/tcg/cpu-exec.c                |  9 ---------
>   target/i386/tcg/sysemu/seg_helper.c | 10 ++++++++++
>   target/i386/tcg/tcg-cpu.c           |  1 +
>   4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index ce34b737bb..253b1f561e 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -39,6 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
>    */
>   void x86_cpu_do_interrupt(CPUState *cpu);
>   #ifndef CONFIG_USER_ONLY
> +bool x86_need_replay_interrupt(int interrupt_request);
>   bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
>   #endif
>   
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 4ab7d6c896..5a978a9e72 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -768,21 +768,12 @@ static inline bool cpu_handle_exception(CPUClass *cc, CPUState *cpu, int *ret)
>   }
>   
>   #ifndef CONFIG_USER_ONLY
> -/*
> - * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
> - * "real" interrupt event later. It does not need to be recorded for
> - * replay purposes.
> - */
>   static inline bool need_replay_interrupt(CPUClass *cc, int interrupt_request)
>   {
> -#if defined(TARGET_I386)
> -    return !(interrupt_request & CPU_INTERRUPT_POLL);
> -#else
>       if (!cc->tcg_ops->need_replay_interrupt) {
>           return true;
>       }
>       return cc->tcg_ops->need_replay_interrupt(interrupt_request);
> -#endif
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
> index 1cb5a0db45..e6f42282bb 100644
> --- a/target/i386/tcg/sysemu/seg_helper.c
> +++ b/target/i386/tcg/sysemu/seg_helper.c
> @@ -127,6 +127,16 @@ void x86_cpu_do_interrupt(CPUState *cs)
>       }
>   }
>   
> +bool x86_need_replay_interrupt(int interrupt_request)
> +{
> +    /*
> +     * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
> +     * "real" interrupt event later. It does not need to be recorded for
> +     * replay purposes.
> +     */
> +    return !(interrupt_request & CPU_INTERRUPT_POLL);
> +}
> +
>   bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
>       X86CPU *cpu = X86_CPU(cs);
> diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
> index e1405b7be9..255d56d4c3 100644
> --- a/target/i386/tcg/tcg-cpu.c
> +++ b/target/i386/tcg/tcg-cpu.c
> @@ -123,6 +123,7 @@ static const struct TCGCPUOps x86_tcg_ops = {
>       .do_unaligned_access = x86_cpu_do_unaligned_access,
>       .debug_excp_handler = breakpoint_handler,
>       .debug_check_breakpoint = x86_debug_check_breakpoint,
> +    .need_replay_interrupt = x86_need_replay_interrupt,
>   #endif /* !CONFIG_USER_ONLY */
>   };
>   


