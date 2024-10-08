Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832BCEF172
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syBTl-0001Q1-Mj; Tue, 08 Oct 2024 10:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBTW-0001Ol-P2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:46:11 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBTT-0003ht-M1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:46:10 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso7751666a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728398765; x=1729003565; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j5MphECLD4P0U/jqbmbESSvAYHMevQyba1bA/1qjbuA=;
 b=xYHqge3vS/rOjQM1krEHZJ9ZCyZfkovFrflTWBr6FN5/WuE6RAH5ar5eMmhByXyVOY
 Sn7+BIY/hE+3lh7Q596YDaT46H5Q9q7b8waDmtRwj1QrAUwC+dNXbFBiIuKT14LbQ8pu
 dpKIAdxYPQll4GkJeSF5emEoJ5WV6nFr8/6ZazI/w8QEaTBfT+AmBeuBPlPqv2NRl6g8
 OE8ecgpfKXd9rjFgxysAHqui094Edivu3g+yeGS/cQImj6+vFYh0ao0WnYJPM9eaeZQA
 jdYd1vL8cYqLwrc44oFP2W+zTHRPWqagbKQNt25Ab8HLfY1OD2eEUY661Uo95EOExFli
 pwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728398765; x=1729003565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5MphECLD4P0U/jqbmbESSvAYHMevQyba1bA/1qjbuA=;
 b=NL4ekN0tTSpoJNtMGSAWhoDi7KaAdcthnrIXc106PlsSGFg84jBNXCTlmDWNOe8P/7
 Sbpkg7yNXyN1Jj3a9SYZrPqEGtau8dgmhBCMLxehNfbRpbyNtOVWPz4+mio5mNOP2y3k
 YuVQAY3dTA4yuorxgAR1PlTdpdOnKD39ztKYC6uf5tsEV8AWTzJWAPTBEwrHss3oc7BD
 6QLaKva7G9EIjqLNwAT5dYJ3LfN0WONOU0rIrKuwskwvD+Y5rgne4KWhKUgvJyHsFL4R
 oy8ZLQy9XE9YrTJ0Ntl/ffTeGy2t/mE8gF3cSgQ9/UD+2BF27zRdktyd95Z7iYwPemiS
 bC3Q==
X-Gm-Message-State: AOJu0Yzb7ripMt/OcU9t/PnArHi2Wc3Jo9nPChvOBu/OULrVo21ip8wl
 Xgu8JNHVijCKqqVCg45Am8brtppXhg1JCo5YqkbOcJm77oW5OUb0Qk+/IcJ7k1wuibV9K509EcH
 8htVQgEE4mkbzlfqVcvIWdaEIcR/gfBrWOcehpQ==
X-Google-Smtp-Source: AGHT+IGbbRXahkkw9UahWbFZHSA6zRVWmmssrHeW2g12mO5Ut8YunOTSsC5XXWpGwl8aN5g3vofSKPBmJRKe9gpczlc=
X-Received: by 2002:a05:6402:50d0:b0:5c8:a92b:b0a with SMTP id
 4fb4d7f45d1cf-5c8d2e1efd5mr13576867a12.1.1728398765144; Tue, 08 Oct 2024
 07:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-14-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:45:53 +0100
Message-ID: <CAFEAcA_jXTuB6c8oVcXmi66zcXn5-PYM7W9z1wf7-fzXg7_Oiw@mail.gmail.com>
Subject: Re: [PATCH v2 13/21] target/arm: Pass MemOp to get_phys_addr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Zero is the safe do-nothing value for callers to use.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h      | 3 ++-
>  target/arm/ptw.c            | 2 +-
>  target/arm/tcg/m_helper.c   | 8 ++++----
>  target/arm/tcg/tlb_helper.c | 2 +-
>  4 files changed, 8 insertions(+), 7 deletions(-)

> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 23d7f73035..f7354f3c6e 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -222,7 +222,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
>      int exc;
>      bool exc_secure;
>
> -    if (get_phys_addr(env, addr, MMU_DATA_STORE, mmu_idx, &res, &fi)) {
> +    if (get_phys_addr(env, addr, MMU_DATA_STORE, 0, mmu_idx, &res, &fi)) {
>          /* MPU/SAU lookup failed */
>          if (fi.type == ARMFault_QEMU_SFault) {
>              if (mode == STACK_LAZYFP) {
> @@ -311,7 +311,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
>      bool exc_secure;
>      uint32_t value;
>
> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
>          /* MPU/SAU lookup failed */
>          if (fi.type == ARMFault_QEMU_SFault) {
>              qemu_log_mask(CPU_LOG_INT,

We do actually know what kind of memory operation we're doing here:
it's a 4-byte access. (It should never be unaligned because an M-profile
SP can't ever be un-4-aligned, though I forget whether our implementation
really enforces that.)

> @@ -2009,7 +2009,7 @@ static bool v7m_read_half_insn(ARMCPU *cpu, ARMMMUIdx mmu_idx, bool secure,
>                        "...really SecureFault with SFSR.INVEP\n");
>          return false;
>      }
> -    if (get_phys_addr(env, addr, MMU_INST_FETCH, mmu_idx, &res, &fi)) {
> +    if (get_phys_addr(env, addr, MMU_INST_FETCH, 0, mmu_idx, &res, &fi)) {
>          /* the MPU lookup failed */
>          env->v7m.cfsr[env->v7m.secure] |= R_V7M_CFSR_IACCVIOL_MASK;
>          armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_MEM, env->v7m.secure);

Similarly this is a 16-bit load that in theory should never
be possible to be unaligned.

> @@ -2045,7 +2045,7 @@ static bool v7m_read_sg_stack_word(ARMCPU *cpu, ARMMMUIdx mmu_idx,
>      ARMMMUFaultInfo fi = {};
>      uint32_t value;
>
> -    if (get_phys_addr(env, addr, MMU_DATA_LOAD, mmu_idx, &res, &fi)) {
> +    if (get_phys_addr(env, addr, MMU_DATA_LOAD, 0, mmu_idx, &res, &fi)) {
>          /* MPU/SAU lookup failed */
>          if (fi.type == ARMFault_QEMU_SFault) {
>              qemu_log_mask(CPU_LOG_INT,

and this is another 4-byte load via sp.

> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 885bf4ec14..1d8b7bcaa2 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -344,7 +344,7 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
>       * register format, and signal the fault.
>       */
> -    ret = get_phys_addr(&cpu->env, address, access_type,
> +    ret = get_phys_addr(&cpu->env, address, access_type, 0,
>                          core_to_arm_mmu_idx(&cpu->env, mmu_idx),
>                          &res, fi);
>      if (likely(!ret)) {

thanks
-- PMM

