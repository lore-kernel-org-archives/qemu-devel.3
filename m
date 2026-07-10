Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F0FC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5o9-00013M-N8; Fri, 10 Jul 2026 03:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wi5o7-00012P-Ej; Fri, 10 Jul 2026 03:37:59 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wi5o5-0007km-Lk; Fri, 10 Jul 2026 03:37:59 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A3B140336;
 Fri, 10 Jul 2026 07:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7191F000E9;
 Fri, 10 Jul 2026 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783669076;
 bh=sO4JbAuoMHHDfXYAV3OqvEzK+SH4DRXfZJ8SmtSpxWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aiMRSLSBPAl+lNwonpGe4KXsFqweRJHWHmdxIRcnXNdkJsffH+IEnc952a3AeU26z
 m2vFKcJGDL4BP6kcaRMmE+eZ/jLxg76EQHwNGPzf4WeZA+eoNztY44+dUt806yRoL2
 Yq7gZYbC+hEylLR+1JT+iMUGJctnW8Cp4GH/HtLTuagjNW5Aw0cJjvu7jASCjCh9ZP
 e4XHsMwDs9gvj8Ged20Npian8mPzHBHqGVM87j1oTvnfa8K9CUmPM//71MdaikV3Iy
 /mu+FBRVFoi38QNEQ/YI6+6YOzE0yZhqPRCjb46WipG9iOCAiDAfXnj8lODJwHiFpN
 SyZU7QC00rbcA==
Date: Fri, 10 Jul 2026 09:37:50 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 jpb@kernel.org, lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial
 Address space
Message-ID: <alChTvF5k4sOOqcJ@lpieralisi>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-10-mathieu.poirier@linaro.org>
 <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 09:44:11AM +1000, Gavin Shan wrote:
> Hi Mathieu,
> 
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Initialise the Realm's initial physical address space based on
> > the VM's configuration.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/arm/boot.c         |  4 ++++
> >   target/arm/kvm-rme.c  | 18 ++++++++++++++++++
> >   target/arm/kvm-stub.c |  4 ++++
> >   target/arm/kvm_arm.h  | 10 ++++++++++
> >   4 files changed, 36 insertions(+)
> > 
> 
> Thanks for the posting.
> 
> If RmeGuest::init_ram isn't needed in the future, this patch can be dropped.
> There is no API exposed from (v14) host series to initialize RIPAS for the
> specified IPA range, as we did in the earlier revisions. So this patch was
> added for the earlier host serieses, not for (v14) host series any more?

Yes, as this series stands this patch looks like a leftover.

Thanks,
Lorenzo

> Thanks,
> Gavin
> 
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index 9b7553dde5e1..bcab21d349b4 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -32,6 +32,7 @@
> >   #include "qemu/option.h"
> >   #include "qemu/units.h"
> >   #include "qemu/bswap.h"
> > +#include "kvm_arm.h"
> >   /* Kernel boot protocol is specified in the kernel docs
> >    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> > @@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
> >       /* We assume the CPU passed as argument is the primary CPU.  */
> >       info->primary_cpu = cpu;
> > +    /* Mark all Realm memory as RAM */
> > +    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
> > +
> >       /* Load the kernel.  */
> >       if (!info->kernel_filename || info->firmware_loaded) {
> >           arm_setup_firmware_boot(cpu, info);
> > diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> > index f763d5ed6199..697e7d507f0d 100644
> > --- a/target/arm/kvm-rme.c
> > +++ b/target/arm/kvm-rme.c
> > @@ -22,8 +22,16 @@
> >   #define TYPE_RME_GUEST "rme-guest"
> >   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> > +#define RME_PAGE_SIZE qemu_real_host_page_size()
> > +
> > +typedef struct {
> > +    hwaddr base;
> > +    hwaddr size;
> > +} RmeRamRegion;
> > +
> >   struct RmeGuest {
> >       ConfidentialGuestSupport parent_obj;
> > +    RmeRamRegion init_ram;
> >   };
> >   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> > @@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> >       return 0;
> >   }
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> > +{
> > +    if (!rme_guest) {
> > +        return;
> > +    }
> > +
> > +    rme_guest->init_ram.base = base;
> > +    rme_guest->init_ram.size = size;
> > +}
> > +
> >   void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> >   {
> >       if (!rme_guest) {
> > diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> > index 6d52f172c5df..790e1940fd8a 100644
> > --- a/target/arm/kvm-stub.c
> > +++ b/target/arm/kvm-stub.c
> > @@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
> >       return false;
> >   }
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> > +{
> > +}
> > +
> >   /*
> >    * These functions should never actually be called without KVM support.
> >    */
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 65ec1b970606..c7dc45595159 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> >    */
> >   int kvm_arm_rme_vm_type(void);
> > +/*
> > + * kvm_arm_rme_init_guest_ram
> > + * @base: base address of RAM
> > + * @size: size of RAM
> > + *
> > + * If the user requested a Realm, set the base and size of guest RAM, in order
> > + * to initialize the Realm IPA space.
> > + */
> > +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
> > +
> >   #endif
> 

