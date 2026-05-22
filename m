Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD398CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPmU-0001J0-Ov; Fri, 22 May 2026 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wQPmQ-0001Ia-0x
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:19:10 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wQPmO-0000Uh-FQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 09:19:09 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id A74A220B7167;
 Fri, 22 May 2026 06:18:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A74A220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779455939;
 bh=bn5jfQ7KJGMfnsZncxijNteAj84OGWlRAPXdwozMFMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L7IoJP8CPoOsVRm9C9pOZmwOVFC8HwKM46EQb7oM2Frrpw9Q17el2L/VjH7ujq8rC
 1w+BuBp2NQJfKZ5e7QewMKP3HOeQ478evbreM/EIfQ07xAp7Zz3ZVQtFBQaIL8pg4g
 42amISSGXljPJ+YJ+6q6WX6DTkOxkhAkVvRVHvy0=
Date: Fri, 22 May 2026 16:18:50 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, aastharawat@microsoft.com,
 Aastha Rawat <aastharawat@linux.microsoft.com>,
 magnuskulke@microsoft.com, Anirudh.Rayabharam@microsoft.com,
 liuwe@microsoft.com, doru.blanzeanu@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/mshv: mitigate early boot vcpu exit race
Message-ID: <ahBXutceaaM0TS0W@linux.microsoft.com>
References: <20260521133433.48463-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521133433.48463-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 21, 2026 at 03:34:33PM +0200, Magnus Kulke wrote:
> When using the mshv accelerator, there is a high likelihood in early
> boot for a QMP execute::quit command to return w/o the QEMU process
> terminating.
> 
> The race is between SIG_IPI delivery and the vcpu thread's exec loop.
> qemu_cpu_kick() relies on SIG_IPI to make MSHV_RUN_VP return -EINTR so
> the vcpu thread can observe cpu->stop. During early boot, there are many
> PIO intercept exit produce MshvVmExitIgnore. That means the inner loop
> in mshv_cpu_exec() spins through RUN_VP ioctl -> handler -> RUN_VP
> ioctl, without being able to consult cpu->exit_request of cpu->stop.
> 
> The qemu_cpu_kick_self() in sa_ipi_handler() was practically a no-op,
> since it calls cpus_kick_thread() which itsself issues a SIG_IPI, in the
> handler for that signal. Hence it has been removed a made a practial
> noop. Once we have a facility in MSHV to signal immediate_exit to the
> kernel it should be used in this handler.
> 
> To mitigate we register a custom kick_vcpu_thread() impl for mshv, that
> will set cpu->exit_request before calling the generic kick_vcpu_thread()
> implement that will raise SIG_IPI.
> 
> We then observe cpu->exit request in the mshv_cpu_exec() inner loop and
> break with EXCP_INTERRUPT when set.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 58af674bd9..a3593c67db 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -502,6 +502,18 @@ static int mshv_cpu_exec(CPUState *cpu)
>      cpu_exec_start(cpu);
>  
>      do {
> +        /*
> +         * We consider a pending exit_request before re-entering the guest.
> +         * This condition is set by mshv_kick_vcpu_thread(), so we unset
> +         * thread_kicked to allow future kicks to interrupt the guest.
> +         */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
> +            qatomic_set(&cpu->exit_request, false);
> +            qatomic_set_mb(&cpu->thread_kicked, false);
> +            ret = EXCP_INTERRUPT;
> +            break;
> +        }
> +
>          if (cpu->accel->dirty) {
>              ret = mshv_arch_put_registers(cpu);
>              if (ret) {
> @@ -540,17 +552,17 @@ static int mshv_cpu_exec(CPUState *cpu)
>  }
>  
>  /*
> - * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
> - * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
> - * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
> - * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
> - * will shut down. For other cases, the system will continue running.
> + * SIG_IPI handler for the vCPU thread. It's a noop currently. A decision to
> + * leave the guest is communicated via cpu->exit_request, which is set by
> + * mshv_kick_vcpu_thread() before it raises a SIG_IPI.
> + *
> + * Note: MSHV currently lacks an immediate_exit equivalent to KVM, there
> + * remains a theoretical race window between userspace check and ioctl entry
> + * in the vcpu loop. Once MSHV supports immediate_exit semantics, we should
> + * invoke it here.
>   */
>  static void sa_ipi_handler(int sig)
>  {
> -    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
> -
> -    qemu_cpu_kick_self();
>  }
>  
>  static void init_signal(CPUState *cpu)
> @@ -605,6 +617,19 @@ cleanup:
>      return NULL;
>  }
>  
> +/*
> + * mshv-custom kick implementation:
> + *
> + * We set cpu->exit_request before the SIG_IPI is delivered to the vcpu
> + * thread (as part of cpus_kick_thread()). It is consumed in the
> + * mshv_cpu_exec loop.
> + */
> +static void mshv_kick_vcpu_thread(CPUState *cpu)
> +{
> +    qatomic_set_mb(&cpu->exit_request, true);
> +    cpus_kick_thread(cpu);
> +}
> +
>  static void mshv_start_vcpu_thread(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
> @@ -719,6 +744,7 @@ static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>  
>      ops->create_vcpu_thread = mshv_start_vcpu_thread;
> +    ops->kick_vcpu_thread = mshv_kick_vcpu_thread;
>      ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
>      ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
>      ops->synchronize_state = mshv_cpu_synchronize;
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

