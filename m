Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE45AFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINUf-0006lc-Oz; Thu, 30 Apr 2026 05:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wINUe-0006lG-Bu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:15:36 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wINUc-0004l6-KX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:15:36 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id C14F020B7175; Thu, 30 Apr 2026 02:15:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C14F020B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777540533;
 bh=yDoPahrleWfkN7RarI/Isxu+lk4AcJ+ao1fJpw4jfew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UUawMWDcZEgRvUr+XOQPXzvW4otcfGyb+IR09w5mWc1BVkpB3dZYwwLUq+T6C5AWc
 fkcOxlooweTo1oF7UDpEhGPeZt0J3+n2OGAQjyl51W8CVJF8U5SvBT59sBjqeiwlEv
 znzHzgxYgK4ScP9YKEMl7a3bXQ9qBavGaR4rN5qE=
Date: Thu, 30 Apr 2026 02:15:33 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/14] target/arm/mshv: implement vcpu state
 operations for ARM64
Message-ID: <afMdtYRslv5xTURI@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-4-469f544778ba@linux.microsoft.com>
 <66a7a9ef-bdec-44a2-89e3-28cf77d6684b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a7a9ef-bdec-44a2-89e3-28cf77d6684b@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 23, 2026 at 11:31:15AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > Add support for reading and writing ARM64 CPU registers in the MSHV
> > accelerator. This includes functions to set and get registers,
> > initialize and destroy VCPU state, and manage register state
> > synchronization between QEMU and hypervisor.
> > 
> > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > ---
> >   include/hw/hyperv/hvgdk_mini.h |  42 +++++++++++++
> >   target/arm/mshv/mshv-all.c     | 138 +++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 180 insertions(+)
> > 
> > diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> > index cb52cc9de2..dfe94050f4 100644
> > --- a/include/hw/hyperv/hvgdk_mini.h
> > +++ b/include/hw/hyperv/hvgdk_mini.h
> > @@ -13,6 +13,46 @@ typedef enum hv_register_name {
> >       /* Pending Interruption Register */
> >       HV_REGISTER_PENDING_INTERRUPTION = 0x00010002,
> > +#if defined(__aarch64__)
> 
> Not ideal, having target/host-specific stuff in a global header.
> That said, you don't actually need the ifdefs at all.

These header definitions are imported directly from the hypervisor
headers to maintain parity with MSHV interface. We need to maintain
this layout. 

> > +static enum hv_register_name STANDARD_REGISTER_NAMES[32] = {
> 
> const.
>

Will fix.
 
> > +    HV_ARM64_REGISTER_X0,
> > +    HV_ARM64_REGISTER_X1,
> > +    HV_ARM64_REGISTER_X2,
> > +    HV_ARM64_REGISTER_X3,
> > +    HV_ARM64_REGISTER_X4,
> > +    HV_ARM64_REGISTER_X5,
> > +    HV_ARM64_REGISTER_X6,
> > +    HV_ARM64_REGISTER_X7,
> > +    HV_ARM64_REGISTER_X8,
> > +    HV_ARM64_REGISTER_X9,
> > +    HV_ARM64_REGISTER_X10,
> > +    HV_ARM64_REGISTER_X11,
> > +    HV_ARM64_REGISTER_X12,
> > +    HV_ARM64_REGISTER_X13,
> > +    HV_ARM64_REGISTER_X14,
> > +    HV_ARM64_REGISTER_X15,
> > +    HV_ARM64_REGISTER_X16,
> > +    HV_ARM64_REGISTER_X17,
> > +    HV_ARM64_REGISTER_X18,
> > +    HV_ARM64_REGISTER_X19,
> > +    HV_ARM64_REGISTER_X20,
> > +    HV_ARM64_REGISTER_X21,
> > +    HV_ARM64_REGISTER_X22,
> > +    HV_ARM64_REGISTER_X23,
> > +    HV_ARM64_REGISTER_X24,
> > +    HV_ARM64_REGISTER_X25,
> > +    HV_ARM64_REGISTER_X26,
> > +    HV_ARM64_REGISTER_X27,
> > +    HV_ARM64_REGISTER_X28,
> > +    HV_ARM64_REGISTER_FP,
> > +    HV_ARM64_REGISTER_LR,
> > +    HV_ARM64_REGISTER_PC,
> 
> Why are you placing PC at name[31], given that you have to special case it
> everywhere else below?

Again, this is same as the register layout used by the hypervisor.
 
> > +static int set_standard_regs(const CPUState *cpu)
> > +{
> > +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> > +    struct hv_register_assoc *assocs;
> > +    int ret;
> > +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> > +    CPUARMState *env = &arm_cpu->env;
> > +
> > +    assocs = g_new0(hv_register_assoc, n_regs);
> 
> This is small enough to allocate in the local stack frame.
> Same for get_standard_regs.

Will switch to stack allocation for both.

> > +static void populate_standard_regs(const hv_register_assoc *assocs,
> > +                                   CPUARMState *env)
> > +{
> > +    size_t n_regs = ARRAY_SIZE(STANDARD_REGISTER_NAMES);
> > +
> > +    for (size_t i = 0; i < n_regs - 1; i++) {
> > +        env->xregs[i] = assocs[i].value.reg64;
> > +    }
> > +
> > +    /* Last register is the program counter */
> > +    env->pc = assocs[n_regs - 1].value.reg64;
> > +}
> 
> Why is this separate from get_standard_regs?
> You don't have a similar split for set_standard_regs...

Right. Will inline populate_standard_regs into get_standard_regs.

> > +int mshv_get_standard_regs(CPUState *cpu)
> 
> I'll note that this isn't used outside of this file, and similarly for
> i386/mshv.  It doesn't need to be declared globally at all.

Sure, will make it static and drop declaration from mshv_int.h.

Thanks,
Aastha

