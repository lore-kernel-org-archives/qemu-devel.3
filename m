Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50E60A5BE5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=tIHqWF2g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsqd-00008M-QU; Fri, 13 Nov 2026 10:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRsqQ-0008Od-6D; Fri, 13 Nov 2026 10:05:38 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRsqM-0006PW-2u; Fri, 13 Nov 2026 10:05:37 -0500
Received: from linux.microsoft.com (unknown [52.174.182.198])
 by linux.microsoft.com (Postfix) with ESMTPSA id 426DE20B7166;
 Fri, 13 Nov 2026 07:05:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 426DE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794582327;
 bh=YFb00/saj5/G+/jT9p5VokqViB3F8EmPfcmmphZIjLs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tIHqWF2gdqH1n3IfH8paPC1jRm9YnkUzIZWRmylunm6v39cpp1GoE8+0YNBrTzJvn
 sONdApc9x1UTT2gEe7IGMCXfrcwhd8+tNTZt9KoCTH0DQSPaOlbZInUiQT/36qyfm2
 Pt33ph5JSKpluejQ2/PqsML8Gmzo9eOZpEx4nvco=
Date: Fri, 13 Nov 2026 17:05:21 +0200
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 05/14] target/arm/mshv: implement vcpu state
 operations for ARM64
Message-ID: <avcnMV0isGvRNhyE@linux.microsoft.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-5-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-5-aefe5e76a0e3@linux.microsoft.com>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:50AM +0000, Aastha Rawat wrote:
> Add support for reading and writing ARM64 CPU registers in the MSHV
> accelerator. This includes functions to set and get registers,
> initialize and destroy VCPU state, and manage register state
> synchronization between QEMU and hypervisor.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h |  42 +++++++++++++++
>  target/arm/mshv/mshv-all.c     | 119 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index a5527d49cf..b5bcea353a 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -32,6 +32,46 @@ typedef enum hv_register_name {
>      HV_REGISTER_PENDING_EVENT0       = 0x00010004,
>      HV_REGISTER_PENDING_EVENT1       = 0x00010005,
>  
> +#if defined(__aarch64__)
> +    HV_ARM64_REGISTER_XZR   = 0x0002FFFE,
> +    HV_ARM64_REGISTER_X0    = 0x00020000,
> +    HV_ARM64_REGISTER_X1    = 0x00020001,
> +    HV_ARM64_REGISTER_X2    = 0x00020002,
> +    HV_ARM64_REGISTER_X3    = 0x00020003,
> +    HV_ARM64_REGISTER_X4    = 0x00020004,
> +    HV_ARM64_REGISTER_X5    = 0x00020005,
> +    HV_ARM64_REGISTER_X6    = 0x00020006,
> +    HV_ARM64_REGISTER_X7    = 0x00020007,
> +    HV_ARM64_REGISTER_X8    = 0x00020008,
> +    HV_ARM64_REGISTER_X9    = 0x00020009,
> +    HV_ARM64_REGISTER_X10   = 0x0002000A,
> +    HV_ARM64_REGISTER_X11   = 0x0002000B,
> +    HV_ARM64_REGISTER_X12   = 0x0002000C,
> +    HV_ARM64_REGISTER_X13   = 0x0002000D,
> +    HV_ARM64_REGISTER_X14   = 0x0002000E,
> +    HV_ARM64_REGISTER_X15   = 0x0002000F,
> +    HV_ARM64_REGISTER_X16   = 0x00020010,
> +    HV_ARM64_REGISTER_X17   = 0x00020011,
> +    HV_ARM64_REGISTER_X18   = 0x00020012,
> +    HV_ARM64_REGISTER_X19   = 0x00020013,
> +    HV_ARM64_REGISTER_X20   = 0x00020014,
> +    HV_ARM64_REGISTER_X21   = 0x00020015,
> +    HV_ARM64_REGISTER_X22   = 0x00020016,
> +    HV_ARM64_REGISTER_X23   = 0x00020017,
> +    HV_ARM64_REGISTER_X24   = 0x00020018,
> +    HV_ARM64_REGISTER_X25   = 0x00020019,
> +    HV_ARM64_REGISTER_X26   = 0x0002001A,
> +    HV_ARM64_REGISTER_X27   = 0x0002001B,
> +    HV_ARM64_REGISTER_X28   = 0x0002001C,
> +    HV_ARM64_REGISTER_FP    = 0x0002001D,
> +    HV_ARM64_REGISTER_LR    = 0x0002001E,
> +    HV_ARM64_REGISTER_PC    = 0x00020022,
> +
> +    /* AArch64 System Register Descriptions: General system control registers */
> +    HV_ARM64_REGISTER_MIDR_EL1   = 0x00040051,
> +    HV_ARM64_REGISTER_MPIDR_EL1  = 0x00040001,
> +
> +#elif defined(__x86_64__)
>      /* X64 User-Mode Registers */
>      HV_X64_REGISTER_RAX     = 0x00020000,
>      HV_X64_REGISTER_RCX     = 0x00020001,
> @@ -188,6 +228,8 @@ typedef enum hv_register_name {
>      /* Other MSRs */
>      HV_X64_REGISTER_MSR_IA32_MISC_ENABLE = 0x000800A0,
>  
> +#endif
> +
>      /* Misc */
>      HV_X64_REGISTER_HYPERCALL       = 0x00090001,
>      HV_REGISTER_GUEST_OS_ID         = 0x00090002,
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> index 00c54f5d66..29dd45a123 100644
> --- a/target/arm/mshv/mshv-all.c
> +++ b/target/arm/mshv/mshv-all.c
> @@ -10,17 +10,128 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include <sys/ioctl.h>
> +
> +#include "qemu/error-report.h"
> +#include "qemu/memalign.h"
>  #include "hw/arm/virt.h"
> +
> +#include "system/cpus.h"
> +#include "target/arm/cpu.h"
> +
>  #include "system/mshv.h"
>  #include "system/mshv_int.h"
> +#include "hw/hyperv/hvgdk_mini.h"
> +
> +static const enum hv_register_name STANDARD_REGISTER_NAMES[32] = {
> +    HV_ARM64_REGISTER_X0,
> +    HV_ARM64_REGISTER_X1,
> +    HV_ARM64_REGISTER_X2,
> +    HV_ARM64_REGISTER_X3,
> +    HV_ARM64_REGISTER_X4,
> +    HV_ARM64_REGISTER_X5,
> +    HV_ARM64_REGISTER_X6,
> +    HV_ARM64_REGISTER_X7,
> +    HV_ARM64_REGISTER_X8,
> +    HV_ARM64_REGISTER_X9,
> +    HV_ARM64_REGISTER_X10,
> +    HV_ARM64_REGISTER_X11,
> +    HV_ARM64_REGISTER_X12,
> +    HV_ARM64_REGISTER_X13,
> +    HV_ARM64_REGISTER_X14,
> +    HV_ARM64_REGISTER_X15,
> +    HV_ARM64_REGISTER_X16,
> +    HV_ARM64_REGISTER_X17,
> +    HV_ARM64_REGISTER_X18,
> +    HV_ARM64_REGISTER_X19,
> +    HV_ARM64_REGISTER_X20,
> +    HV_ARM64_REGISTER_X21,
> +    HV_ARM64_REGISTER_X22,
> +    HV_ARM64_REGISTER_X23,
> +    HV_ARM64_REGISTER_X24,
> +    HV_ARM64_REGISTER_X25,
> +    HV_ARM64_REGISTER_X26,
> +    HV_ARM64_REGISTER_X27,
> +    HV_ARM64_REGISTER_X28,
> +    HV_ARM64_REGISTER_FP,
> +    HV_ARM64_REGISTER_LR,
> +    HV_ARM64_REGISTER_PC,
> +};
> +
> +static int set_standard_regs(const CPUState *cpu)
> +{
> +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> +    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)] = {};
> +    int ret;
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +
> +    for (size_t i = 0; i < n_regs - 1; i++) {
> +        assocs[i].name = STANDARD_REGISTER_NAMES[i];
> +        assocs[i].value.reg64 = env->xregs[i];
> +    }
> +
> +    /* Last register is the program counter */
> +    assocs[n_regs - 1].name = STANDARD_REGISTER_NAMES[n_regs - 1];
> +    assocs[n_regs - 1].value.reg64 = env->pc;
> +
> +    ret = mshv_set_generic_regs(cpu, assocs, n_regs);
> +    if (ret < 0) {
> +        error_report("failed to set standard registers");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int get_standard_regs(CPUState *cpu)
> +{
> +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> +    struct hv_register_assoc assocs[ARRAY_SIZE(STANDARD_REGISTER_NAMES)] = {};
> +    int ret;
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +
> +    for (size_t i = 0; i < n_regs; i++) {
> +        assocs[i].name = STANDARD_REGISTER_NAMES[i];
> +    }
> +    ret = mshv_get_generic_regs(cpu, assocs, n_regs);
> +    if (ret < 0) {
> +        error_report("failed to get standard registers");
> +        return -1;
> +    }
> +
> +    for (size_t i = 0; i < n_regs - 1; i++) {
> +        env->xregs[i] = assocs[i].value.reg64;
> +    }
> +    env->pc = assocs[n_regs - 1].value.reg64;
> +
> +    return 0;
> +}
>  
>  static int load_regs(CPUState *cpu)
>  {
> +    int ret;
> +
> +    ret = get_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to load standard registers");
> +        return -1;
> +    }
> +
>      return 0;
>  }
>  

I see that only these general purpose registers are synchronized after an exit,
reset or init.
At a glance, KVM also handles registers such as PSTATE and SP_EL0/SP_EL1.
Should this implementation handle those as well?

>  static int store_regs(const CPUState *cpu)
>  {
> +    int ret;
> +
> +    ret = set_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to store standard registers");
> +        return -1;
> +    }
> +
>      return 0;
>  }
>  
> @@ -41,12 +152,20 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>  
>  void mshv_arch_init_vcpu(CPUState *cpu)
>  {
> +    AccelCPUState *state = cpu->accel;
>  
> +    mshv_setup_hvcall_args(state);
>  }
>  
>  void mshv_arch_destroy_vcpu(CPUState *cpu)
>  {
> +    AccelCPUState *state = cpu->accel;
> +
> +    if (state->hvcall_args.base) {
> +        qemu_vfree(state->hvcall_args.base);
> +    }
>  
> +    state->hvcall_args = (MshvHvCallArgs){0};
>  }
>  
>  int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
> 
> -- 
> 2.45.4

