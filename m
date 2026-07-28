Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2174C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woh9S-0007p6-VR; Tue, 28 Jul 2026 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1woh9O-0007om-OM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:43:14 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1woh9M-0005Jo-U6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:43:14 -0400
Received: from example.com (p5b3e8a57.dip0.t-ipconnect.de [91.62.138.87])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5974D20B7166;
 Tue, 28 Jul 2026 05:42:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5974D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785242574;
 bh=1HZIk+zCFxPKTu/sHqfQbEukmPiALzD4aocxayn3Xp0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CuDdvhH3fAgOFvP4x+A9CtoGLqjK/pRMSIQCGipxmOhm9LGlHt9KhpXeHSe9RMV+R
 B0NxvlHItpyBOUzmeb3zj7RcAtej9mEv0ljnqemNLsyHNSIoi5r7i0Uwj174QM01Bn
 eT3bibR8PSK7bhnuAazAr60koIm0csGjydAOyEdU=
Date: Tue, 28 Jul 2026 14:43:04 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 3/3] target/i386/mshv: support single-stepping
Message-ID: <amij2PMFQweUwS61@example.com>
References: <20260727142807.84269-1-dblanzeanu@linux.microsoft.com>
 <20260727142807.84269-4-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727142807.84269-4-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

On Mon, Jul 27, 2026 at 05:28:07PM +0300, Doru Blânzeanu wrote:
> Single-step by toggling RFLAGS.TF around the vCPU run, as WHPX does.
> TF is set only on the live register, never in env->eflags, so it is not read
> back and re-applied by a later register store.
> The resulting #DB is reported to gdb by mshv_handle_debug() whenever the vCPU
> is single-stepping.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 50 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2333d3304a..036b142113 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1974,17 +1974,67 @@ static int handle_debug(CPUState *cpu, hv_message *msg)
>      return 0;
>  }
>  
> +/*
> + * Flip RFLAGS.TF like WHPX. Set it only on the live register, not env->eflags,
> + * so a later store won't put it back.
> + */
> +static int arch_set_single_step(CPUState *cpu, bool enable)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    hv_register_assoc assoc = { .name = HV_X64_REGISTER_RFLAGS };
> +    uint64_t rflags;
> +    int ret;
> +
> +    if (env->regs_page && env->regs_page->isvalid != 0) {
> +        rflags = env->regs_page->rflags;
> +        rflags = enable ? (rflags | TF_MASK) : (rflags & ~TF_MASK);
> +        env->regs_page->rflags = rflags;
> +        env->regs_page->dirty |= (1u << HV_X64_REGISTER_CLASS_FLAGS);
> +        return 0;
> +    }
> +
> +    ret = mshv_get_generic_regs(cpu, &assoc, 1);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    rflags = assoc.value.reg64;
> +    rflags = enable ? (rflags | TF_MASK) : (rflags & ~TF_MASK);
> +    assoc.value.reg64 = rflags;
> +    return mshv_set_generic_regs(cpu, &assoc, 1);
> +}
> +
>  int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>  {
>      int ret;
>      enum MshvVmExit exit_reason;
>      int cpu_fd = mshv_vcpufd(cpu);
> +    bool single_step;
> +
> +    /* enable single stepping by flipping RFLAGS.TF */
> +    single_step = cpu_single_stepping(cpu);
> +    if (single_step) {
> +        ret = arch_set_single_step(cpu, true);
> +        if (ret < 0) {
> +            error_report("Failed to arm single-step (TF) on vcpu %d: %s",
> +                         cpu->cpu_index, strerror(-ret));
> +            *exit = MshvVmExitShutdown;
> +            return -1;
> +        }
> +    }
>  
>      ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
>      if (ret < 0) {
>          return MshvVmExitShutdown;
>      }
>  
> +    /* disable single stepping by flipping RFLAGS.TF */
> +    if (single_step && arch_set_single_step(cpu, false) < 0) {
> +        error_report("Failed to clear single-step (TF) on vcpu %d",
> +                     cpu->cpu_index);
> +        return -1;
> +    }
> +
>      switch (msg->header.message_type) {
>      case HVMSG_UNRECOVERABLE_EXCEPTION:
>          return MshvVmExitShutdown;
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

