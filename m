Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BA0FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnYh-0001Rm-Kg; Mon, 04 May 2026 03:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wJnYQ-0001RG-Bw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:17:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wJnYO-0001Jh-62
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:17:21 -0400
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 8D86D20B7168; Mon,  4 May 2026 00:17:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D86D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777879037;
 bh=Itym/PmA/kss/uAMC3eG7egg0g2dGKMNPqj7XetWvWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NKh5ik4iB6MWOVMcVGA0j1DdhHkDzXza1J7s65a51f5wZB5eSne+fWy/HIxEV66CG
 HfsflLHwPGR7nC6vVHCip183JzV60NpHD7wpGHAfILi14TJxK8NEmI2R03VWRpG74z
 e87TR9gntlOTH5fkBMndDHPJA5fK+WhuTvTG/cqw=
Date: Mon, 4 May 2026 00:17:17 -0700
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 06/14] accel/mshv: add arch-specific accelerator init
 hook
Message-ID: <afhH/Ztt+iPctWcY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-6-469f544778ba@linux.microsoft.com>
 <8e4483bb-852d-41aa-bcff-26a460d24762@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4483bb-852d-41aa-bcff-26a460d24762@linaro.org>
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

On Thu, Apr 23, 2026 at 11:51:17AM +1000, Richard Henderson wrote:
> On 4/21/26 15:21, Aastha Rawat wrote:
> > From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> > 
> > Introduce mshv_arch_accel_init() as an arch-specific hook called early
> > in mshv_init(), before VM creation. This allows each architecture to
> > perform platform-specific initialization at accelerator init time.
> > 
> > For arm64, the hook queries the hypervisor for the supported IPA bit
> > size and validates it against the guest memory map via the machine's
> > get_physical_address_range callback, following the same pattern used by
> > HVF and WHPX. This also populates the memory map which comes in handy
> > later when retreiving the vGIC layout.
> > 
> > For x86, the hook calls mshv_init_mmio_emu() which was previously called
> > directly from the common init path. Also move set_unimplemented_msr_action()
> > and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
> > they are not vCPU-specific.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >   accel/mshv/mshv-all.c        |  5 ++-
> >   include/system/mshv_int.h    |  1 +
> >   target/arm/mshv/mshv-all.c   | 25 ++++++++++----
> >   target/i386/mshv/meson.build |  1 +
> >   target/i386/mshv/mshv-all.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
> >   target/i386/mshv/mshv-cpu.c  | 40 ----------------------
> >   6 files changed, 105 insertions(+), 47 deletions(-)
> > 
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index 44f35a1463..6940ad9989 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -434,7 +434,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
> >           return -1;
> >       }
> > -    mshv_init_mmio_emu();
> > +    ret = mshv_arch_accel_init(as, ms, mshv_fd);
> > +    if (ret < 0) {
> > +        return -1;
> > +    }
> >       mshv_init_msicontrol();
> > diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> > index ff3ab957b5..c72c91cd23 100644
> > --- a/include/system/mshv_int.h
> > +++ b/include/system/mshv_int.h
> > @@ -96,6 +96,7 @@ void mshv_arch_init_vcpu(CPUState *cpu);
> >   void mshv_arch_destroy_vcpu(CPUState *cpu);
> >   void mshv_arch_amend_proc_features(
> >       union hv_partition_synthetic_processor_features *features);
> > +int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
> >   int mshv_arch_post_init_vm(int vm_fd);
> >   void mshv_setup_hvcall_args(AccelCPUState *state);
> > diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> > index db1174b444..8d16971c0d 100644
> > --- a/target/arm/mshv/mshv-all.c
> > +++ b/target/arm/mshv/mshv-all.c
> > @@ -9,12 +9,13 @@
> >    * SPDX-License-Identifier: GPL-2.0-or-later
> >    */
> > -
> >   #include "qemu/osdep.h"
> >   #include <sys/ioctl.h>
> >   #include "qemu/error-report.h"
> >   #include "qemu/memalign.h"
> > +#include "hw/arm/bsa.h"
> > +#include "hw/arm/virt.h"
> >   #include "system/cpus.h"
> >   #include "target/arm/cpu.h"
> > @@ -188,11 +189,6 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
> >       state->hvcall_args = (MshvHvCallArgs){0};
> >   }
> > -void mshv_init_mmio_emu(void)
> > -{
> > -
> > -}
> 
> It would be nice to introduce the mshv_arch_accel_init hook earlier in the
> series, so that you don't have to add and then remove this function.
> 
> 
> r~

Makes sense, will reorder the series in v4.

Thanks,
Aastha 

