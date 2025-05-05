Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B83FC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBvBM-0006FI-IL; Mon, 05 May 2025 08:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uBvBK-0006Em-IT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:44:26 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uBvBI-0005OC-Fb
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:44:26 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54998f865b8so4752021e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746449062; x=1747053862; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkArFAX47YrnU0WufzF54Ebol4mlAFUCNpwoFP8kd+8=;
 b=ULb93sJvT9EEcu6A+zP7ql4frTD6wPbvBLeUx5sEWAD1wK1YcSh1wUL8qCZWSigkbE
 VKR33IlsuOGAuE5TLZ6kEtwjY6I70IhB9tCT3zYKI32U4B882UROhefdaXXRq7b568MT
 1g2ZDEdwjuX8/WC8z2a9DNYsfLmLOTydt02MJ6KNl8KczlegbXLlt6oSMD98ErBQOnDu
 dPc4dLj36mwnlJvvbdL2pMa/rNO4oRYJnkPObB77ahM3LGeNXkPfEPr+tywb3jvLeuY5
 K9Wg2+ryz/WoR5sqUFmcmbVZ17NZySlEmYrXr7LeaY6KA3Sz6SwLIXvHjSK5EsK/qvy6
 +SPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746449062; x=1747053862;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkArFAX47YrnU0WufzF54Ebol4mlAFUCNpwoFP8kd+8=;
 b=bzn3LNUYE1ZPBVqD9QQE62mcU6X2XeLCssiERyPrMr8Rlmi8LHdCh4O26ia9ipnJeJ
 KmyOSAoOnJ2PlKYNGBJ309SqmYVnqj2oQ7zknx9uPqu+CVr+N/zF7ZQJ0lyaGpKHjWNx
 AKesuKXknSts1rHoAuTd7VDI3Zt/rE9VuD98SCDN93TZm928fGjXchJd4pa45KPPQ8ZE
 R7F459giKQuc7/K5/unIYbz6Of1kCHz62R7oEqwp3++zsjhIyDmhUxApPkGxndhLwTzu
 xYHkzl3vJBUfxSoa3J7PEXpfTPxl4mLHkT7wIQj/mUrxfHe2TQvz5isVYIyfeOTMxaMp
 Z7yw==
X-Gm-Message-State: AOJu0YzTyU5i9As0b067t0mkHrMM6EBPKYeL+0pSfc6VBxaQD/hkcgfT
 8CXfEg7F7yoiP5iYtwKHq9XBHOSzKsrZoem300kROvIrfFRnKzU1
X-Gm-Gg: ASbGncvoLHiE2ZAyGQuBlMzD7SwMaT5Up0rmVjitZL9qBfbiOHtEDpKE98qTQsCU8jj
 YCqu85LjnK7WRObo8wAIUugzshXMBptUzOzTNpwm1ySRZMpx7bT1XMA3PLL+D2iJDfFhRPi9IRE
 GqVutAWt3V6TIpwSGOfNitZCcFV6faK6mkLU+eLWptivM+0f34fH2UevNn2FsRup2NLQnKE/7Hk
 iAZDb1cH+L0OrL8vLj+UtSLKopaj2WxJSHKyXEQ2TZoy37SogHzDUcGzC2GikPm2wnbXh1Vd3CH
 pe45loIzFRnX0mwuY1B17uaRQl52QPkVBxjJoy2XbI7csCgTSmMxiHqwZd0SwORS2aXVidn3bw7
 l0Bcw9vuRSgSPx6yzuibK3Ms=
X-Google-Smtp-Source: AGHT+IEfSEN1rzF+r9QAAFlLeEnGC5EFXm801GmW6xmj6jlaP2k/E2clBiKAWDZ11sQiOim0L1tuXw==
X-Received: by 2002:a05:6512:b0b:b0:545:16a5:10f5 with SMTP id
 2adb3069b0e04-54eb243945amr2122819e87.30.1746449061639; 
 Mon, 05 May 2025 05:44:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea94f2043sm1684902e87.179.2025.05.05.05.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 05:44:20 -0700 (PDT)
Date: Mon, 5 May 2025 13:34:57 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, foss@percivaleng.com,
 Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 03/12] target: Use cpu_pointer_wrap_uint32 for 32-bit
 targets
Message-ID: <aBiiYUzBe33JIa6d@zapote>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504205714.3432096-4-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, May 04, 2025 at 01:57:04PM -0700, Richard Henderson wrote:
> M68K, MicroBlaze, OpenRISC, RX, TriCore and Xtensa are
> all 32-bit targets.  AVR is more complicated, but using
> a 32-bit wrap preserves current behaviour.
> 
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  include/accel/tcg/cpu-ops.h | 1 +
>  accel/tcg/cputlb.c          | 6 ++++++
>  target/avr/cpu.c            | 6 ++++++
>  target/m68k/cpu.c           | 1 +
>  target/microblaze/cpu.c     | 1 +
>  target/openrisc/cpu.c       | 1 +
>  target/rx/cpu.c             | 1 +
>  target/tricore/cpu.c        | 1 +
>  target/xtensa/cpu.c         | 1 +
>  9 files changed, 19 insertions(+)
> 
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index 4f3b4fd3bc..dd8ea30016 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -326,6 +326,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
>   * Common pointer_wrap implementations.
>   */
>  vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
> +vaddr cpu_pointer_wrap_uint32(CPUState *, int, vaddr, vaddr);
>  
>  #endif
>  
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 75cd875948..022d555f48 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2945,3 +2945,9 @@ vaddr cpu_pointer_wrap_notreached(CPUState *cs, int idx, vaddr res, vaddr base)
>  {
>      g_assert_not_reached();
>  }
> +
> +/* To be used for strict 32-bit targets. */
> +vaddr cpu_pointer_wrap_uint32(CPUState *cs, int idx, vaddr res, vaddr base)
> +{
> +    return (uint32_t)res;
> +}
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 250241541b..6995de6a12 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -250,6 +250,12 @@ static const TCGCPUOps avr_tcg_ops = {
>      .cpu_exec_reset = cpu_reset,
>      .tlb_fill = avr_cpu_tlb_fill,
>      .do_interrupt = avr_cpu_do_interrupt,
> +    /*
> +     * TODO: code and data wrapping are different, but for the most part
> +     * AVR only references bytes or aligned code fetches.  But we use
> +     * non-aligned MO_16 accesses for stack push/pop.
> +     */
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>  };
>  
>  static void avr_cpu_class_init(ObjectClass *oc, const void *data)
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index c5196a612e..6a09db3a6f 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -619,6 +619,7 @@ static const TCGCPUOps m68k_tcg_ops = {
>  
>  #ifndef CONFIG_USER_ONLY
>      .tlb_fill = m68k_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>      .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
>      .cpu_exec_halt = m68k_cpu_has_work,
>      .cpu_exec_reset = cpu_reset,
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index d069e40e70..5eff1610c2 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -449,6 +449,7 @@ static const TCGCPUOps mb_tcg_ops = {
>  
>  #ifndef CONFIG_USER_ONLY
>      .tlb_fill = mb_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>      .cpu_exec_interrupt = mb_cpu_exec_interrupt,
>      .cpu_exec_halt = mb_cpu_has_work,
>      .cpu_exec_reset = cpu_reset,
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index 054ad33360..dfbb2df643 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -265,6 +265,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
>  
>  #ifndef CONFIG_USER_ONLY
>      .tlb_fill = openrisc_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>      .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
>      .cpu_exec_halt = openrisc_cpu_has_work,
>      .cpu_exec_reset = cpu_reset,
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index 36eba75545..c6dd5d6f83 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -225,6 +225,7 @@ static const TCGCPUOps rx_tcg_ops = {
>      .restore_state_to_opc = rx_restore_state_to_opc,
>      .mmu_index = rx_cpu_mmu_index,
>      .tlb_fill = rx_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>  
>      .cpu_exec_interrupt = rx_cpu_exec_interrupt,
>      .cpu_exec_halt = rx_cpu_has_work,
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index e56f90fde9..4f035b6f76 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -190,6 +190,7 @@ static const TCGCPUOps tricore_tcg_ops = {
>      .restore_state_to_opc = tricore_restore_state_to_opc,
>      .mmu_index = tricore_cpu_mmu_index,
>      .tlb_fill = tricore_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>      .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
>      .cpu_exec_halt = tricore_cpu_has_work,
>      .cpu_exec_reset = cpu_reset,
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 91b71b6caa..ea9b6df3aa 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -318,6 +318,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
>  
>  #ifndef CONFIG_USER_ONLY
>      .tlb_fill = xtensa_cpu_tlb_fill,
> +    .pointer_wrap = cpu_pointer_wrap_uint32,
>      .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
>      .cpu_exec_halt = xtensa_cpu_has_work,
>      .cpu_exec_reset = cpu_reset,
> -- 
> 2.43.0
> 

