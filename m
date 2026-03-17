Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D45EF3380A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Orq-0006dt-68; Tue, 17 Mar 2026 03:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w2OrZ-0006b7-5P; Tue, 17 Mar 2026 03:29:13 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w2OrV-0001DU-Ic; Tue, 17 Mar 2026 03:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773732531; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W+DyPI+TK1dz7NGSmxRAfepmecOK6T/0Q19STushHlSPF7IHIs06zuO19iMaY161Hz4e49aQXvqW1j6/4b72ufstPYEhf3/C9wdOG58ZXBkuxsATWxmD++172X2gxurOJ7RzuC0ocbryeNoGEzB/ZsxNkviBPerBSW9j+AcprOs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773732531;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ctGBz/mZo+EX0eZhP1zxdHoJeQiVjASwQXCYiN2OiZ4=; 
 b=mqNCdjX1TfjKLf9WGj3j+LcaRxAsLphS4GuwfJAG4hg4UIikQ7N1uP4Xn00m0OvzSXbtC0evKAEGEflYBoPYZjBPPJaxFoxl/QIE+vev5js9zpTGCI1TKj3xeNkxO/gwfLcH435Mka4rG+2k/ZUL/GKLLrt04aVptXM0XylDiDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773732531; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=ctGBz/mZo+EX0eZhP1zxdHoJeQiVjASwQXCYiN2OiZ4=;
 b=zOAAsV/80W6HYtVrs5SkNO+y7BBRM6cx+SByvypXCYYxTD7Mh0f2IJPCmrPMU+2I
 +77mkMhWW+ZXRBJbzVRHXlqVJtBQ6Ap7BmcQkHZdVE38C3vf4/Vd1OhuO0qrJquriBV
 vpPoDg+qpBVfp9lxMKA7eLL5920Asmj13zjxcHDg=
Received: by mx.zohomail.com with SMTPS id 1773732523854139.5036936920675;
 Tue, 17 Mar 2026 00:28:43 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:28:38 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 11/14] target/arm/mshv: add vCPU run loop
Message-ID: <20260317-crimson-pillbug-of-strength-daf7ea@anirudhrb>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-11-c31699b7bc1f@anirudhrb.com>
 <DBA9B933-08E0-4599-AF36-AED339598F75@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBA9B933-08E0-4599-AF36-AED339598F75@unpredictable.fr>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 04:58:28PM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 11. Mar 2026, at 16:15, Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com> wrote:
> > 
> > Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.
> > 
> > Handle MMIO exits by emulating the instruction using the syndrome
> > information from ESR_EL2.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> > include/hw/hyperv/hvgdk_mini.h |  44 +++++++++
> > target/arm/mshv/mshv-all.c     | 198 +++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 242 insertions(+)
> > 
> Hello,
> 
> GDK updates in separate patches from the rest please. Maybe even combine them together.

The header updates are closely related to what this patch is doing.

> 
> And more comments below...
> 
> > diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> > index d56be0d70f..84b3c6af5f 100644
> > --- a/include/hw/hyperv/hvgdk_mini.h
> > +++ b/include/hw/hyperv/hvgdk_mini.h
> > @@ -750,6 +750,50 @@ struct hv_x64_memory_intercept_message {
> >     uint8_t instruction_bytes[16];
> > };
> > 
> > +union hv_arm64_vp_execution_state {
> > +    uint16_t as_uint16;
> > +    struct {
> > +        uint16_t cpl:2;
> > +        uint16_t debug_active:1;
> > +        uint16_t interruption_pending:1;
> > +        uint16_t vtl:4;
> > +        uint16_t virtualization_fault_active:1;
> > +        uint16_t reserved:7;
> > +    };
> > +};
> > +
> > +struct hv_arm64_intercept_message_header {
> > +    uint32_t vp_index;
> > +    uint8_t instruction_length;
> > +    uint8_t intercept_access_type;
> > +    union hv_arm64_vp_execution_state execution_state;
> > +    uint64_t pc;
> > +    uint64_t cpsr;
> > +};
> > +
> > +union hv_arm64_memory_access_info {
> > +    uint8_t as_uint8;
> > +    struct {
> > +        uint8_t gva_valid:1;
> > +        uint8_t gva_gpa_valid:1;
> > +        uint8_t hypercall_output_pending:1;
> > +        uint8_t reserved:5;
> > +    };
> > +};
> > +
> > +struct hv_arm64_memory_intercept_message {
> > +    struct hv_arm64_intercept_message_header header;
> > +    uint32_t cache_type; /* enum hv_cache_type */
> > +    uint8_t instruction_byte_count;
> > +    union hv_arm64_memory_access_info memory_access_info;
> > +    uint16_t reserved1;
> > +    uint8_t instruction_bytes[4];
> > +    uint32_t reserved2;
> > +    uint64_t guest_virtual_address;
> > +    uint64_t guest_physical_address;
> > +    uint64_t syndrome;
> > +};
> > +
> > union hv_message_flags {
> >     uint8_t asu8;
> >     struct {
> > diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> > index 2b983845d3..b0649ba10b 100644
> > --- a/target/arm/mshv/mshv-all.c
> > +++ b/target/arm/mshv/mshv-all.c
> > @@ -166,8 +166,206 @@ int mshv_arch_put_registers(const CPUState *cpu)
> >     return 0;
> > }
> > 
> > +static int set_memory_info(const struct hyperv_message *msg,
> > +                           struct hv_arm64_memory_intercept_message *info)
> > +{
> > +    if (msg->header.message_type != HVMSG_GPA_INTERCEPT
> > +            && msg->header.message_type != HVMSG_UNMAPPED_GPA
> > +            && msg->header.message_type != HVMSG_UNACCEPTED_GPA) {
> > +        error_report("invalid message type");
> > +        return -1;
> > +    }
> > +    memcpy(info, msg->payload, sizeof(*info));
> > +
> > +    return 0;
> > +}
> > +
> > +typedef union {
> > +    uint64_t raw;
> > +    struct {
> > +        uint32_t iss:25;
> > +        uint32_t il:1;
> > +        uint32_t ec:6;
> > +        uint32_t iss2:5;
> > +        uint32_t _rsvd:27;
> > +    } QEMU_PACKED;
> > +} EsrEl2;
> > +
> > +typedef union {
> > +    uint32_t raw;
> > +    struct {
> > +        uint32_t dfsc:6;
> > +        uint32_t wnr:1;
> > +        uint32_t s1ptw:1;
> > +        uint32_t cm:1;
> > +        uint32_t ea:1;
> > +        uint32_t fnv:1;
> > +        uint32_t set:2;
> > +        uint32_t vncr:1;
> > +        uint32_t ar:1;
> > +        uint32_t sf:1;
> > +        uint32_t srt:5;
> > +        uint32_t sse:1;
> > +        uint32_t sas:2;
> > +        uint32_t isv:1;
> > +        uint32_t _unused:7;
> > +    } QEMU_PACKED;
> > +} IssDataAbort;
> Think this is better suited for common code somewhere...
> > +
> > +typedef enum {
> > +    data_abort_lower = 36,
> > +    data_abort = 37,
> > +} ExceptionClass;
> > +
> > +int mshv_store_regs(CPUState *cpu)
> > +{
> > +    int ret;
> > +
> > +    ret = set_standard_regs(cpu);
> > +    if (ret < 0) {
> > +        error_report("Failed to store standard registers");
> > +        return -1;
> > +    }
> > +
> > +    /* TODO: should store special registers? the equivalent hvf code doesn't */
> WHPX does handle this via state levels, but what HVF does via a separate function is also workable.

Yeah, we'll add more registers in a later series. I think I'll get rid of
this TODO.

> 
> > +    return 0;
> > +}
> > +
> > +static int emulate_with_syndrome(CPUState *cpu,
> > +                                 struct hv_arm64_memory_intercept_message *info)
> > +{
> > +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> > +    CPUARMState *env = &arm_cpu->env;
> > +    int ret;
> > +    EsrEl2 syndrome = { 0 };
> > +    IssDataAbort iss = { 0 };
> > +    uint64_t gpa = info->guest_physical_address;
> > +    uint64_t len, reg_index;
> > +    bool sign_extend;
> > +
> > +    syndrome.raw = info->syndrome;
> > +
> > +    if (!(syndrome.ec == data_abort_lower || syndrome.ec == data_abort)) {
> > +        error_report("Unknown exception class 0x%x", syndrome.ec);
> > +        return -1;
> > +    }
> > +
> > +    iss.raw = syndrome.iss;
> > +    if (!iss.isv) {
> > +        error_report("Invalid ESR EL2 ISV field");
> > +        return -1;
> > +    }
> > +
> > +    len = 1ULL << iss.sas;
> > +    sign_extend = iss.sse;
> > +    reg_index = iss.srt;
> > +
> > +    ret = mshv_load_regs(cpu);
> > +    if (ret < 0) {
> > +        error_report("Failed to load registers");
> > +        return -1;
> > +    }
> > +
> > +    if (iss.wnr) {
> > +        uint8_t data[8];
> > +        uint64_t val = reg_index < 31 ? env->xregs[reg_index] : 0ULL;
> > +
> > +        val = cpu_to_le64(val);
> > +
> > +        memcpy(data, &val, sizeof(val));
> > +        ret = mshv_guest_mem_write(gpa, data, len, false);
> > +        if (ret < 0) {
> > +            error_report("Failed to write guest memory");
> > +            return -1;
> > +        }
> > +    } else {
> > +        uint8_t data[8] = { 0 };
> > +
> > +        ret = mshv_guest_mem_read(gpa, data, len, false, false);
> > +        if (ret < 0) {
> > +            error_report("Failed to read guest memory");
> > +            return -1;
> > +        }
> > +
> > +        uint64_t val;
> > +        memcpy(&val, data, sizeof(val));
> > +
> > +        val = le64_to_cpu(val);
> > +
> > +        if (sign_extend) {
> > +            uint64_t shift = 64 - (len * 8);
> > +            val = (((int64_t)val << shift) >> shift);
> > +            if (!iss.sf) {
> > +                val &= 0xffffffff;
> > +            }
> > +        }
> > +
> > +        env->xregs[reg_index] = val;
> > +    }
> > +
> > +    env->pc += (syndrome.il == 1) ? 4 : 2;
> > +
> > +    ret = mshv_store_regs(cpu);
> > +    if (ret < 0) {
> > +        error_report("failed to store registers");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> 
> I think this deserves to go to common code somewhere at this point :)

Do you have any ideas as to where this code can go?

> 
> > +
> > +static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
> > +                               const struct hyperv_message *msg,
> > +                               MshvVmExit *exit_reason)
> > +{
> > +    struct hv_arm64_memory_intercept_message info = { 0 };
> > +    int ret;
> > +
> > +    ret = set_memory_info(msg, &info);
> > +    if (ret < 0) {
> > +        error_report("failed to convert message to memory info");
> > +        return -1;
> > +    }
> > +
> > +    ret = emulate_with_syndrome(cpu, &info);
> > +    if (ret < 0) {
> > +        error_report("Failed to emulate with syndrome");
> > +        return -1;
> > +    }
> > +
> > +    *exit_reason = MshvVmExitIgnore;
> > +
> > +    return 0;
> > +}
> > +
> > int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
> > {
> > +    int ret;
> > +    int cpu_fd = mshv_vcpufd(cpu);
> > +
> > +    ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
> > +    if (ret < 0) {
> > +        *exit = MshvVmExitShutdown;
> > +        return ret;
> > +    }
> > +
> > +    switch (msg->header.message_type) {
> > +    case HVMSG_UNRECOVERABLE_EXCEPTION:
> > +        *exit = MshvVmExitShutdown;
> > +        break;
> > +    case HVMSG_UNMAPPED_GPA:
> At least as observed on WHPX you also need to handle GpaIntercept the same way
> for EDK2 to be happy

Interesting, because Cloud Hypervisor doesn't handle GPA_INTERCEPT at
all for arm64 and still works fine with EDK2.

Anyway, I tried adding it but EDK2 still isn't happy. There seems to be
some other issue potentially related to the mshv driver in the kernel.

Thanks,
Anirudh.

> > 
> > 
> > +        ret = handle_unmapped_mem(vm_fd, cpu, msg, exit);
> > +        if (ret < 0) {
> > +            error_report("failed to handle mmio");
> > +            return -1;
> > +        }
> > +        break;
> > +    default:
> > +        error_report("Unhandled message type: 0x%x", msg->header.message_type);
> > +        return -1;
> > +    }
> > +
> >     return 0;
> > }
> > 
> > 
> > -- 
> > 2.43.0
> > 
> > 
> 
> 

