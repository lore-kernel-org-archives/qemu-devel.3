Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58094606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=o6V/AjHP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRqDb-0005gm-PR; Fri, 13 Nov 2026 07:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRqDa-0005gX-CE
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:17:22 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1xRqDY-0006cJ-Ef
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:17:22 -0500
Received: from linux.microsoft.com (unknown [40.69.22.128])
 by linux.microsoft.com (Postfix) with ESMTPSA id 2DD7B20B7167;
 Fri, 13 Nov 2026 04:17:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DD7B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794572233;
 bh=YkNzjKR1BA5nzC2c1ExkNxTDcxawX7KtWdtDrfIz6uU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o6V/AjHPrtRHjtEmhWk/vdjx63wcn7RCzM1g85QHWR798FY97KhVWPOacYw9DT4CI
 TlXuALRe6vZUQTOCMMRy6Grdu3W4jQYHGNel7JrrdHWXHAlJ+CZv6rkA4jwM9hyNkb
 lPxWw3demuacXL/fX2nynADKa0/YB0SU/Oev8x1I=
Date: Fri, 13 Nov 2026 14:17:06 +0200
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: Re: [PATCH] target/i386/mshv: add MshvPutState for vcpu writes
Message-ID: <avb_wn207UPYU6uX@linux.microsoft.com>
References: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109123949.724711-1-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 01:39:49PM +0100, Magnus Kulke wrote:
> Currently QEMU marks a vcpu state as dirty also on merely inspectional
> reads, e.g. via "info registers", which triggers a writeback to the
> hypervisor. For MSRs that cause a side-effect when written to this is
> undesired.
> 
> We introduce an MshvPutState flag into the writeback logic to differentiate
> "runtime" from "full" and "reset" writebacks that should occur e.g. after
> a migration or startup.
> 
> Discrete side-effectful MSRs are excluded in runtime writebacks. So far
> we only mark one MSR as not runtime-safe, but probably more will be
> added eventually.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 10 +++++-----
>  include/system/mshv_int.h   | 13 +++++++++++--
>  target/i386/mshv/mshv-cpu.c | 10 ++++++++--
>  target/i386/mshv/msr.c      | 21 ++++++++++++++++++++-
>  4 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index d820a67b95..d64599e2e2 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -759,10 +759,10 @@ static int mshv_cpu_exec(CPUState *cpu)
>  
>      do {
>          if (cpu->vcpu_dirty) {
> -            ret = mshv_arch_store_vcpu_state(cpu);
> +            ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_RUNTIME_STATE);
>              if (ret) {
> -                error_report("Failed to put registers after init: %s",
> -                              strerror(-ret));
> +                error_report("Failed to put registers at runtime: %s",
> +                             strerror(-ret));
>                  ret = -1;
>                  break;
>              }
> @@ -890,7 +890,7 @@ static void mshv_start_vcpu_thread(CPUState *cpu)
>  static void do_mshv_cpu_synchronize_post_init(CPUState *cpu,
>                                                run_on_cpu_data arg)
>  {
> -    int ret = mshv_arch_store_vcpu_state(cpu);
> +    int ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_FULL_STATE);
>      if (ret < 0) {
>          error_report("Failed to put registers after init: %s", strerror(-ret));
>          abort();
> @@ -906,7 +906,7 @@ static void mshv_cpu_synchronize_post_init(CPUState *cpu)
>  
>  static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
>  {
> -    int ret = mshv_arch_store_vcpu_state(cpu);
> +    int ret = mshv_arch_store_vcpu_state(cpu, MSHV_PUT_RESET_STATE);
>      if (ret) {
>          error_report("Failed to put registers after reset: %s",
>                       strerror(-ret));
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 1f77ffd152..b7b7c56443 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -98,6 +98,15 @@ typedef enum MshvVmExit {
>      MshvVmExitDebug    = 3,
>  } MshvVmExit;
>  
> +typedef enum MshvPutState {
> +    /* state subset only touched by the VCPU itself during runtime */
> +    MSHV_PUT_RUNTIME_STATE = 1,
> +    /* state subset modified during VCPU reset */
> +    MSHV_PUT_RESET_STATE = 2,
> +    /* full state set, modified during initialization or on vmload */
> +    MSHV_PUT_FULL_STATE = 3,
> +} MshvPutState;
> +
>  void mshv_init_mmio_emu(void);
>  int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
>  void mshv_remove_vcpu(int vm_fd, int cpu_fd);
> @@ -107,7 +116,7 @@ int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
>                            size_t n_regs);
>  int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
>                            size_t n_regs);
> -int mshv_arch_store_vcpu_state(const CPUState *cpu);
> +int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState state);
>  int mshv_arch_load_vcpu_state(CPUState *cpu);
>  int mshv_arch_set_partition_msrs(const CPUState *cpu);
>  int mshv_arch_set_mp_state(const CPUState *cpu);
> @@ -152,7 +161,7 @@ void mshv_log_global_stop(MemoryListener *listener);
>  /* msr */
>  int mshv_init_msrs(const CPUState *cpu);
>  int mshv_get_msrs(CPUState *cpu);
> -int mshv_set_msrs(const CPUState *cpu);
> +int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state);
>  
>  /* synic */
>  int mshv_get_simp(int cpu_fd, uint8_t *page);
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 4df73bb497..72ef01a597 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1511,7 +1511,13 @@ static int set_synic_state(const CPUState *cpu)
>      return 0;
>  }
>  
> -int mshv_arch_store_vcpu_state(const CPUState *cpu)
> +/*
> + * The put_state param is passed to decide whether we need a full restoration
> + * of all registers (e.g. after a migration ) or just a subset during runtime
> + * (e.g after "info registers"). The latter should avoid writing registers that
> + * cause a side-effect.
> + */
> +int mshv_arch_store_vcpu_state(const CPUState *cpu, MshvPutState put_state)
>  {
>      int ret;
>  
> @@ -1541,7 +1547,7 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
>          return ret;
>      }
>  
> -    ret = mshv_set_msrs(cpu);
> +    ret = mshv_set_msrs(cpu, put_state);
>      if (ret < 0) {
>          return ret;
>      }
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index 96bd552916..a06844cc99 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -324,6 +324,20 @@ static bool msr_supported(uint32_t name)
>      return true;
>  }
>  
> +static bool msr_is_runtime_safe(uint32_t name)
> +{
> +    switch (name) {
> +    /*
> +     * HV_X64_REGISTER_TSC will invalidate the guest's tsc_page if written to
> +     * while the guest's timer is not frozen.
> +     */
> +    case HV_X64_REGISTER_TSC:
> +        return false;
> +    default:
> +        return true;
> +    }
> +}
> +
>  int mshv_get_msrs(CPUState *cpu)
>  {
>      int ret = 0;
> @@ -406,13 +420,14 @@ static void load_from_env(const CPUState *cpu, struct hv_register_assoc *assocs,
>      load_from_env_mtrr_phys(cpu, &assocs[mtrr_offset], MSHV_MTRR_MSR_COUNT);
>  }
>  
> -int mshv_set_msrs(const CPUState *cpu)
> +int mshv_set_msrs(const CPUState *cpu, MshvPutState put_state)
>  {
>      size_t n_assocs = MSHV_MSR_TOTAL_COUNT;
>      struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT] = { 0 };
>      int ret;
>      size_t i, j;
>      X86CPU *x86cpu = X86_CPU(cpu);
> +    bool runtime = (put_state <= MSHV_PUT_RUNTIME_STATE);
>  
>      load_from_env(cpu, assocs, n_assocs);
>  
> @@ -432,6 +447,10 @@ int mshv_set_msrs(const CPUState *cpu)
>              continue;
>          }
>  
> +        if (runtime && !msr_is_runtime_safe(name)) {
> +            continue;
> +        }
> +
>          if (j != i) {
>              assocs[j] = assocs[i];
>          }
> -- 
> 2.34.1

Tested-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

