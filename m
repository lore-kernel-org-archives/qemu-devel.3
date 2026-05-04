Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618ECD3423
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnPS-0007NY-N9; Mon, 04 May 2026 03:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wJnP8-0007N9-Gw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:07:49 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wJnP4-0006zz-Oa
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:07:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 3E43220B7168; Mon,  4 May 2026 00:07:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E43220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777878457;
 bh=jpIXOgf3bpwfJAMYQzt4TFGDvUO3D3Hfc+ulSbQYQ80=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hdK0z4PpqsyRjZAyO+MLuxAdU4qOASyHSow6iFPGINYNJuxz7ZFmreZjwvREUGya8
 b7LrYsIizvXqbhQ4i2hK9CB3vO7kfsdKrqvFdM3aUa/xxjduqHC7JtMC/vY9JXCRoN
 /mK2bLLu6Xg4f7qdqf4GkbvoMJYhdgKdEO22bvvw=
Date: Mon, 4 May 2026 00:07:37 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 05/14] target/arm/mshv: implement -cpu host for MSHV
Message-ID: <afhFuQrsr0CyosgY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-5-469f544778ba@linux.microsoft.com>
 <55515ca0-3185-4b5d-9bbb-5da1245b8cc3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55515ca0-3185-4b5d-9bbb-5da1245b8cc3@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Thu, Apr 23, 2026 at 11:48:12AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > This commit enables support for the `-cpu host` option with MSHV
> > accelerator on ARM64. The implementation queries the partition's CPU's
> > ID registers and features via hypervisor interface, allowing to pass all
> > CPU capabilities for the host CPU to the guest.
> > 
> > Replace preprocessor config checks with runtime calls to mshv_enabled(),
> > kvm_enabled(), etc. This ensures that the correct accelerator is
> > selected at runtime when both MSHV and KVM are enabled.
> > 
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> >   accel/mshv/mshv-all.c          |   3 +-
> >   hw/arm/virt.c                  |   3 +-
> >   include/hw/hyperv/hvgdk_mini.h |  17 ++++
> >   include/hw/hyperv/hvhdk.h      |  10 ++
> >   include/system/hw_accel.h      |   3 +-
> >   target/arm/cpu.c               |   6 +-
> >   target/arm/cpu64.c             |  24 +++--
> >   target/arm/mshv/mshv-all.c     | 204 +++++++++++++++++++++++++++++++++++++++++
> >   target/arm/mshv_arm.h          |  18 ++++
> >   9 files changed, 273 insertions(+), 15 deletions(-)
> > 
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index d4cc7f5371..44f35a1463 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -400,13 +400,14 @@ static int mshv_init_vcpu(CPUState *cpu)
> >       int ret;
> >       cpu->accel = g_new0(AccelCPUState, 1);
> > -    mshv_arch_init_vcpu(cpu);
> >       ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
> >       if (ret < 0) {
> >           return -1;
> >       }
> > +    mshv_arch_init_vcpu(cpu);
> > +
> >       cpu->accel->dirty = true;
> >       return 0;
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 7456614d05..34eb5248a9 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -50,6 +50,7 @@
> >   #include "system/kvm.h"
> >   #include "system/hvf.h"
> >   #include "system/whpx.h"
> > +#include "system/mshv.h"
> >   #include "system/qtest.h"
> >   #include "system/system.h"
> >   #include "hw/core/loader.h"
> > @@ -3450,7 +3451,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
> >       if (target_aarch64()) {
> >           g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
> >           g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a57")));
> > -        if (kvm_enabled() || hvf_enabled()) {
> > +        if (kvm_enabled() || hvf_enabled() || mshv_enabled()) {
> >               g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("host")));
> >           }
> >       }
> > diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> > index dfe94050f4..d56be0d70f 100644
> > --- a/include/hw/hyperv/hvgdk_mini.h
> > +++ b/include/hw/hyperv/hvgdk_mini.h
> > @@ -48,6 +48,20 @@ typedef enum hv_register_name {
> >       HV_ARM64_REGISTER_LR    = 0x0002001E,
> >       HV_ARM64_REGISTER_PC    = 0x00020022,
> > +    /* AArch64 System Register Descriptions: ID Registers */
> > +    HV_ARM64_REGISTER_ID_MIDR_EL1         = 0x00022000,
> > +    HV_ARM64_REGISTER_ID_MPIDR_EL1        = 0x00022005,
> > +    HV_ARM64_REGISTER_ID_AA64_PFR0_EL1    = 0x00022020,
> > +    HV_ARM64_REGISTER_ID_AA64_PFR1_EL1    = 0x00022021,
> > +    HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1   = 0x00022030,
> > +    HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1   = 0x00022031,
> > +    HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1   = 0x00022032,
> > +    HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1   = 0x00022038,
> > +    HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1   = 0x00022039,
> > +    HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1   = 0x0002203a,
> > +    HV_ARM64_REGISTER_ID_AA64_DFR0_EL1    = 0x00022028,
> > +    HV_ARM64_REGISTER_ID_AA64_DFR1_EL1    = 0x00022029,
> 
> Please use the actual name of the register and not add the extra _ after AA64.

These names are imported exactly as they’re defined in the hypervisor
headers, so we want to keep them as-is.

> > -#if defined(CONFIG_KVM)
> > -    kvm_arm_set_cpu_features_from_host(cpu);
> > -    aarch64_add_sve_properties(obj);
> > -#elif defined(CONFIG_HVF)
> > -    hvf_arm_set_cpu_features_from_host(cpu);
> > -#elif defined(CONFIG_WHPX)
> > -    whpx_arm_set_cpu_features_from_host(cpu);
> > -#else
> > -    g_assert_not_reached();
> > -#endif
> > +    if (mshv_enabled()) {
> > +        mshv_arm_set_cpu_features_from_host(cpu);
> > +    } else if (kvm_enabled()) {
> > +        kvm_arm_set_cpu_features_from_host(cpu);
> > +        aarch64_add_sve_properties(obj);
> > +    } else if (hvf_enabled()) {
> > +        hvf_arm_set_cpu_features_from_host(cpu);
> > +    } else if (whpx_enabled()) {
> > +        whpx_arm_set_cpu_features_from_host(cpu);
> > +    } else {
> > +        g_assert_not_reached();
> > +    }
> 
> If this is because both mshv and kvm can be enabled simultaneously, then
> this should be a separate patch to transform the ifdef ladder.

Right, sure.
 
> > +static void clamp_id_aa64mmfr0_parange_to_ipa_size(int mshv_fd,
> > +                                                   ARMISARegisters *isar)
> > +{
> > +    uint32_t ipa_size = mshv_arm_get_ipa_bit_size(mshv_fd);
> > +    uint64_t id_aa64mmfr0;
> > +
> > +    /* Clamp down the PARange to the IPA size the kernel supports. */
> > +    uint8_t index = round_down_to_parange_index(ipa_size);
> > +    id_aa64mmfr0 = GET_IDREG(isar, ID_AA64MMFR0);
> > +    id_aa64mmfr0 = (id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
> 
> id_aa64_mmfr0 = FIELD_DPREG64(id_aa64mmfr0, AA64MMFR0, PARANGE, index);

Ack.
 
> > +    args.in_ptr = (uintptr_t)(in_buffer);
> > +    args.out_sz = values_sz;
> > +    args.out_ptr = (uintptr_t)(out_buffer);
> 
> Drop unnecessary ().

Ack, will do.

> > +    args.reps =  (uint16_t) n_regs;
> 
> Unnecessary cast.

Ack, will remove.

> > +static bool mshv_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> > +{
> > +    int mshv_fd = mshv_state->fd;
> > +    int vm_fd = mshv_state->vm;
> > +    int i, ret;
> > +    bool success = true;
> > +    uint64_t pfr0, pfr1;
> > +    gchar *contents = NULL;
> > +
> > +    const struct {
> 
> static

Ack.

> > +        hv_register_name name;
> > +        int isar_idx;
> > +    } regs[] = {
> > +        { HV_ARM64_REGISTER_ID_AA64_PFR0_EL1,  ID_AA64PFR0_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_PFR1_EL1,  ID_AA64PFR1_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_ISAR0_EL1, ID_AA64ISAR0_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_ISAR1_EL1, ID_AA64ISAR1_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_ISAR2_EL1, ID_AA64ISAR2_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_MMFR0_EL1, ID_AA64MMFR0_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_MMFR1_EL1, ID_AA64MMFR1_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_MMFR2_EL1, ID_AA64MMFR2_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_DFR0_EL1,  ID_AA64DFR0_EL1_IDX },
> > +        { HV_ARM64_REGISTER_ID_AA64_DFR1_EL1,  ID_AA64DFR1_EL1_IDX },
> 
> Per above, if you use matching names, you can macroize to avoid typos:
> 
> #define R(X)  { HV_ARM64_REGISTER_##X, X##_IDX }
> 
>     R(ID_AA64PFR0_EL1),
>     R(ID_AA64PFR1_EL1),
>     ...
> 
> #undef R

The Hyper-V register names don’t match the ARM names exactly, so a
simple R(x) macro won’t work without renaming. Since we have to maintain
them as-is, we can’t do this.
 
> Also, there are a *lot* more id registers.
> Any chance all, or at least more, are defined by MSHV?
> 
> 
> r~

Yes, MSHV defines many more ID registers, but for now I’ve only included
the ones that are actually used. We can add more as needed in future
patches.

Thanks,
Aastha

