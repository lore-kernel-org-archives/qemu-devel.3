Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF42C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 17:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgu1-0003y6-9Y; Wed, 24 Jan 2024 12:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgty-0003xB-Hf
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:19:02 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgtx-0005WX-29
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 12:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZG9/IHvWTBtfARPaCksNQb3rbaDMsnVKBJpokbptlv8=; b=B3U0jAQd3nml7+smKTs3MsTKAX
 XyT3/Nu93KlbLG91/OPkZDSgrF1kduUieoIZo4KEKdi3uTOiAuzH+puUQbZz62QKeRP7+YHUG3SfE
 JWw+IPMMydJ/Q3IYWnRgDdQKNq0/uYJZQb71TjlbFzC9kPXYKLsos9uFTwgpQuivY0uc=;
Date: Wed, 24 Jan 2024 18:19:08 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 8/9] accel/tcg: Introduce TCGCPUOps::cpu_exec_halt()
 handler
Message-ID: <q2vl2qst4xwb3bv6d4lnp6htroqq2thqbzq4mwvmayfqb73mh3@qjkgfah4s2nk>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-9-philmd@linaro.org>
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
> introduce the cpu_exec_halt() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/tcg-cpu-ops.h | 2 ++
>  accel/tcg/cpu-exec.c          | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
> index 2fae3ac70f..3307338c80 100644
> --- a/include/hw/core/tcg-cpu-ops.h
> +++ b/include/hw/core/tcg-cpu-ops.h
> @@ -114,6 +114,8 @@ struct TCGCPUOps {
>      void (*record_sigbus)(CPUState *cpu, vaddr addr,
>                            MMUAccessType access_type, uintptr_t ra);
>  #else
> +    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
> +    void (*cpu_exec_halt)(CPUState *cpu);
>      /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
>      /**
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 5a978a9e72..390a9644da 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -681,6 +681,9 @@ static inline bool cpu_handle_halt(CPUClass *cc, CPUState *cpu)
>              bql_unlock();
>          }
>  #endif /* TARGET_I386 */
> +        if (cc->tcg_ops->cpu_exec_halt) {
> +            cc->tcg_ops->cpu_exec_halt(cpu);
> +        }
>          if (!cpu_has_work(cpu)) {
>              return true;
>          }
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

