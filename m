Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D93606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=CvrCPqPc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQgj-0001Wp-0b; Fri, 20 Nov 2026 10:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUQgh-0001WC-CS; Fri, 20 Nov 2026 10:38:07 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUQge-00078I-Tb; Fri, 20 Nov 2026 10:38:07 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8740420B7166;
 Fri, 20 Nov 2026 07:37:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8740420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795189080;
 bh=Tof0b1vLnQk/pO0V9aZ0KxTcdUX4iFf4/+87iPJnCDE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CvrCPqPchBe5obwzpZ2ubCZOPnWGAVE+vgB31Fl1ownTQHiDqzG+LyZe4BRjZUzB4
 ytb8BjhlogZJTfsIQ8oFJzisqnQngyvxAKvb7hyd2m/B9HJGcGTVNIOfOacHDbR2bY
 RrLv8KvHUAFGdNgX5Ao3UxhelVDQ0P1ECH0UQ2us=
Date: Fri, 20 Nov 2026 16:37:57 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v6 11/14] target/arm/mshv: add vCPU run loop
Message-ID: <awBpVDVdwuMg4CD3@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-11-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-11-aefe5e76a0e3@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

On Thu, Oct 01, 2026 at 10:52:56AM +0000, Aastha Rawat wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.
> 
> Handle MMIO exits by emulating the instruction using the syndrome
> information from ESR_EL2.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h |  44 +++++++++++++++++
>  target/arm/mshv/mshv-all.c     | 107 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index 33c9e4f3e0..53dc58813e 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -896,6 +896,50 @@ struct hv_x64_memory_intercept_message {
>      uint8_t instruction_bytes[16];
>  } QEMU_PACKED;
>  
> +union hv_arm64_vp_execution_state {
> +    uint16_t as_uint16;
> +    struct {
> +        uint16_t cpl:2;
> +        uint16_t debug_active:1;
> +        uint16_t interruption_pending:1;
> +        uint16_t vtl:4;
> +        uint16_t virtualization_fault_active:1;
> +        uint16_t reserved:7;
> +    };
> +};
> +
> +struct hv_arm64_intercept_message_header {
> +    uint32_t vp_index;
> +    uint8_t instruction_length;
> +    uint8_t intercept_access_type;
> +    union hv_arm64_vp_execution_state execution_state;
> +    uint64_t pc;
> +    uint64_t cpsr;
> +};
> +
> +union hv_arm64_memory_access_info {
> +    uint8_t as_uint8;
> +    struct {
> +        uint8_t gva_valid:1;
> +        uint8_t gva_gpa_valid:1;
> +        uint8_t hypercall_output_pending:1;
> +        uint8_t reserved:5;
> +    };
> +};
> +
> +struct hv_arm64_memory_intercept_message {
> +    struct hv_arm64_intercept_message_header header;
> +    uint32_t cache_type; /* enum hv_cache_type */
> +    uint8_t instruction_byte_count;
> +    union hv_arm64_memory_access_info memory_access_info;
> +    uint16_t reserved1;
> +    uint8_t instruction_bytes[4];
> +    uint32_t reserved2;
> +    uint64_t guest_virtual_address;
> +    uint64_t guest_physical_address;
> +    uint64_t syndrome;
> +};
> +
>  union hv_message_flags {
>      uint8_t asu8;
>      struct {
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> index d835614fd5..786d815312 100644
> --- a/target/arm/mshv/mshv-all.c
> +++ b/target/arm/mshv/mshv-all.c
> @@ -20,6 +20,7 @@
>  #include "target/arm/cpu.h"
>  #include "target/arm/internals.h"
>  #include "target/arm/mshv_arm.h"
> +#include "target/arm/helper.h"
>  
>  #include "system/mshv.h"
>  #include "system/mshv_int.h"
> @@ -158,8 +159,114 @@ int mshv_arch_store_vcpu_state(const CPUState *cpu)
>      return store_regs(cpu);
>  }
>  
> +static int set_memory_info(const struct hyperv_message *msg,
> +                           struct hv_arm64_memory_intercept_message *info)
> +{
> +    if (msg->header.message_type != HVMSG_GPA_INTERCEPT
> +            && msg->header.message_type != HVMSG_UNMAPPED_GPA
> +            && msg->header.message_type != HVMSG_UNACCEPTED_GPA) {
> +        error_report("invalid message type");
> +        return -1;
> +    }
> +    memcpy(info, msg->payload, sizeof(*info));
> +
> +    return 0;
> +}
> +
> +static uint64_t mshv_mmio_get_reg(CPUState *cpu, int reg_index)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +    return reg_index < 31 ? env->xregs[reg_index] : 0ULL;
> +}
> +
> +static void mshv_mmio_set_reg(CPUState *cpu, int reg_index, uint64_t val)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +    if (reg_index < 31) {
> +        env->xregs[reg_index] = val;
> +    }
> +}
> +
> +static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
> +                               const struct hyperv_message *msg,
> +                               MshvVmExit *exit_reason)
> +{
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +    struct hv_arm64_memory_intercept_message info = { 0 };
> +    int ret;
> +    EsrEl2 syndrome;
> +
> +    ret = set_memory_info(msg, &info);
> +    if (ret < 0) {
> +        error_report("failed to convert message to memory info");
> +        return -1;
> +    }
> +
> +    syndrome.raw = info.syndrome;
> +
> +    ret = load_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to load registers");
> +        return -1;
> +    }
> +
> +    static const struct arm_emul_ops mshv_arm_emul_ops = {
> +        .get_reg = mshv_mmio_get_reg,
> +        .set_reg = mshv_mmio_set_reg,
> +    };
> +
> +    ret = arm_emulate_mmio(cpu, syndrome, info.guest_physical_address,
> +                           &mshv_arm_emul_ops);
> +    if (ret < 0) {
> +        error_report("Failed to emulate with syndrome");
> +        return -1;
> +    }
> +
> +    /* Advance PC past the faulting instruction */
> +    env->pc += (syndrome.il == 1) ? 4 : 2;
> +
> +    ret = store_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to store registers");
> +        return -1;
> +    }
> +
> +    *exit_reason = MshvVmExitIgnore;
> +
> +    return 0;
> +}
> +
>  int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>  {
> +    int ret;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
> +    if (ret < 0) {

the ioctl can return EINTR after a userland kick, for x86 on master we
handle this with a special exit:

    if (ret < 0) {
        if (errno == EINTR) {
            *exit = MshvVmExitSpecial;
            return 0;
        }

> +        *exit = MshvVmExitShutdown;
> +        return ret;
> +    }
> +
> +    switch (msg->header.message_type) {
> +    case HVMSG_UNRECOVERABLE_EXCEPTION:
> +        *exit = MshvVmExitShutdown;
> +        break;
> +    case HVMSG_GPA_INTERCEPT:
> +    case HVMSG_UNMAPPED_GPA:

the whpx code handles a cache maintainance exit, do we need the same
here?

	advance_pc = true;

	if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
		error_report("WHPX: cached access to unmapped memory"
		"Pc = 0x%llx Gva = 0x%llx Gpa = 0x%llx",
		vcpu->exit_ctx.MemoryAccess.Header.Pc,
		vcpu->exit_ctx.MemoryAccess.Gpa,
		vcpu->exit_ctx.MemoryAccess.Gva);
		break;
	}


> +        ret = handle_unmapped_mem(vm_fd, cpu, msg, exit);
> +        if (ret < 0) {
> +            error_report("failed to handle mmio");
> +            return -1;
> +        }
> +        break;
> +    default:
> +        error_report("Unhandled message type: 0x%x", msg->header.message_type);
> +        return -1;
> +    }
> +
>      return 0;
>  }
>  
> 
> -- 
> 2.45.4

