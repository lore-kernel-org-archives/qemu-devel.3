Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7082DD79773
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 15:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmCf2-0005XO-Bz; Sat, 31 Jan 2026 10:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vmCer-0005Wz-Cr
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 10:13:10 -0500
Received: from out-183.mta1.migadu.com ([95.215.58.183])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1vmCeo-0003Z2-9t
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 10:13:09 -0500
Message-ID: <92a63a78-2ab8-481a-8b78-3a86fa130fe8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1769872381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nqitm0bP7TAMKoIoe3qotBuPZzBazxOlPp+ap/keNKA=;
 b=xKIWeMAvVw/PGMnRla+iS9kFWC/PkxJcO2v6zsL8Bt6Z9+IB1xl/9RbB5lzhjATfFHLN9A
 CY7eJTiZinW0XiR55chC8/iDicZWrWJBonQsMJA7Pa6LTFftRiCrfCkRa1uwtMSmbNpOjd
 Oxup0M/zPd4SfTOJtweUVZa/aTk31h4=
Date: Sat, 31 Jan 2026 23:12:53 +0800
MIME-Version: 1.0
Subject: Re: [PULL 20/30] accel/hvf: Implement WFI without using pselect()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
 <20260116111807.36053-21-philmd@linaro.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20260116111807.36053-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.183; envelope-from=zenghui.yu@linux.dev;
 helo=out-183.mta1.migadu.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/16/26 7:17 PM, Philippe Mathieu-Daudé wrote:
> Return to the main loop where we'll be waken again.
> This avoid a tricky race with signals introduced in
> commit 219c101fa7f ("Add HVF WFI handler").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Message-ID: <20260112103034.65310-14-philmd@linaro.org>
> ---
>  include/system/hvf_int.h  |  1 -
>  accel/hvf/hvf-accel-ops.c |  2 --
>  target/arm/hvf/hvf.c      | 74 +++------------------------------------
>  3 files changed, 5 insertions(+), 72 deletions(-)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index d842d4b2b99..c8e407a1463 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -47,7 +47,6 @@ struct AccelCPUState {
>  #ifdef __aarch64__
>      hv_vcpu_exit_t *exit;
>      bool vtimer_masked;
> -    sigset_t unblock_ipi_mask;
>      bool guest_debug_enabled;
>  #endif
>  };
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index d931412975c..ffcfe9663b5 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -135,8 +135,6 @@ static int hvf_init_vcpu(CPUState *cpu)
>      sigaction(SIG_IPI, &sigact, NULL);
>  
>  #ifdef __aarch64__
> -    pthread_sigmask(SIG_BLOCK, NULL, &cpu->accel->unblock_ipi_mask);
> -    sigdelset(&cpu->accel->unblock_ipi_mask, SIG_IPI);
>      cpu->accel->guest_debug_enabled = false;
>  
>      r = hv_vcpu_create(&cpu->accel->fd,
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index d74703a3d55..b936098d257 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -301,7 +301,7 @@ void hvf_arm_init_debug(void)
>  #define TMR_CTL_IMASK   (1 << 1)
>  #define TMR_CTL_ISTATUS (1 << 2)
>  
> -static void hvf_wfi(CPUState *cpu);
> +static int hvf_wfi(CPUState *cpu);
>  
>  static uint32_t chosen_ipa_bit_size;
>  
> @@ -1703,81 +1703,17 @@ static uint64_t hvf_vtimer_val_raw(void)
>      return mach_absolute_time() - hvf_state->vtimer_offset;
>  }
>  
> -static uint64_t hvf_vtimer_val(void)
> +static int hvf_wfi(CPUState *cpu)
>  {
> -    if (!runstate_is_running()) {
> -        /* VM is paused, the vtimer value is in vtimer.vtimer_val */
> -        return vtimer.vtimer_val;
> -    }
> -
> -    return hvf_vtimer_val_raw();
> -}
> -
> -static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
> -{
> -    /*
> -     * Use pselect to sleep so that other threads can IPI us while we're
> -     * sleeping.
> -     */
> -    qatomic_set_mb(&cpu->thread_kicked, false);
> -    bql_unlock();
> -    pselect(0, 0, 0, 0, ts, &cpu->accel->unblock_ipi_mask);
> -    bql_lock();
> -}
> -
> -static void hvf_wfi(CPUState *cpu)
> -{
> -    ARMCPU *arm_cpu = ARM_CPU(cpu);
> -    struct timespec ts;
> -    hv_return_t r;
> -    uint64_t ctl;
> -    uint64_t cval;
> -    int64_t ticks_to_sleep;
> -    uint64_t seconds;
> -    uint64_t nanos;
> -    uint32_t cntfrq;
> -
>      if (cpu_has_work(cpu)) {
>          /*
>           * Don't bother to go into our "low power state" if
>           * we would just wake up immediately.
>           */
> -        return;
> +        return 0;
>      }
>  
> -    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &ctl);
> -    assert_hvf_ok(r);
> -
> -    if (!(ctl & 1) || (ctl & 2)) {
> -        /* Timer disabled or masked, just wait for an IPI. */
> -        hvf_wait_for_ipi(cpu, NULL);
> -        return;
> -    }
> -
> -    r = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &cval);
> -    assert_hvf_ok(r);
> -
> -    ticks_to_sleep = cval - hvf_vtimer_val();
> -    if (ticks_to_sleep < 0) {
> -        return;
> -    }
> -
> -    cntfrq = gt_cntfrq_period_ns(arm_cpu);
> -    seconds = muldiv64(ticks_to_sleep, cntfrq, NANOSECONDS_PER_SECOND);
> -    ticks_to_sleep -= muldiv64(seconds, NANOSECONDS_PER_SECOND, cntfrq);
> -    nanos = ticks_to_sleep * cntfrq;
> -
> -    /*
> -     * Don't sleep for less than the time a context switch would take,
> -     * so that we can satisfy fast timer requests on the same CPU.
> -     * Measurements on M1 show the sweet spot to be ~2ms.
> -     */
> -    if (!seconds && nanos < (2 * SCALE_MS)) {
> -        return;
> -    }
> -
> -    ts = (struct timespec) { seconds, nanos };
> -    hvf_wait_for_ipi(cpu, &ts);
> +    return EXCP_HLT;
>  }
>  
>  /* Must be called by the owning thread */
> @@ -1967,7 +1903,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>      case EC_WFX_TRAP:
>          advance_pc = true;
>          if (!(syndrome & WFX_IS_WFE)) {
> -            hvf_wfi(cpu);
> +            ret = hvf_wfi(cpu);
>          }
>          break;
>      case EC_AA64_HVC:

Running a Linux guest on M1 (macOS Sequoia 15.7.2) results in a high CPU
utilization - from host's perspective. The guest itself is almost idle.

I traced hvf_wfi() and noticed that the frequency of WFI traps is
extremely high. I *guess* that the vcpus are being woken up frequently,
which is unnecessary most of the time.

I'm not sure if this is expected.

Thanks,
Zenghui

