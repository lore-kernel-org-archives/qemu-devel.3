Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF0C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkiG-0005aN-Cj; Wed, 07 Feb 2024 11:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rXkiE-0005Zx-De; Wed, 07 Feb 2024 11:23:50 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rXkiB-0003D0-CU; Wed, 07 Feb 2024 11:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707323026; x=1738859026;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=r9x3/ipm1R1qJ0uy4DsMp3s3ZBjq5BTt+ZSrQxABzOE=;
 b=bm8zKZ/n0VTd96sClgYa3krh7CmhjNy7cKRYnjeg8u4Ul/u/Z2nkgEVW
 jiK+KIAptcJyutUu8spe3LO5zsgbO00E3LyvNSPU4gPMeK1hfTukkgg0v
 PR7PKkyF/iVL5pjCZDvbr6zBtDM0vZLbLZYKgVz3r8k30dHueN155n9nA
 +digHtphdwZv3URFNSWfM2kxzELvlAuiUQWZQvjNvKPz2ETpw03MStJe8
 mOPiRsD4PVPHqtJUmGnwPXn3wOrWcdGoCvol6ZHo4UsNqktahKJwnxozS
 Ga4WYT9UfgjoeHFs8YOtQNvX1HAMUszi7TAcYT3rmcSM90g4Rdi5QS0zF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="26467514"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; d="scan'208";a="26467514"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2024 08:23:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="5991661"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 07 Feb 2024 08:23:39 -0800
Date: Thu, 8 Feb 2024 00:37:12 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/intc: Handle the error of IOAPICCommonClass.realize()
Message-ID: <ZcOxuELwO3KLUeuH@intel.com>
References: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
 <cdb1c6cd-0095-4787-a740-17b42e061548@linaro.org>
 <ZbsPRB4OM027fbMA@intel.com> <875xz0ojg7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xz0ojg7.fsf@pond.sub.org>
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Markus,

On Wed, Feb 07, 2024 at 07:51:52AM +0100, Markus Armbruster wrote:
> Date: Wed, 07 Feb 2024 07:51:52 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH] hw/intc: Handle the error of
>  IOAPICCommonClass.realize()
> 
> Zhao Liu <zhao1.liu@linux.intel.com> writes:
> 
> > Hi Philippe,
> >
> > On Wed, Jan 31, 2024 at 05:48:24PM +0100, Philippe Mathieu-Daudé wrote:
> >> Date: Wed, 31 Jan 2024 17:48:24 +0100
> >> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Subject: Re: [PATCH] hw/intc: Handle the error of  IOAPICCommonClass.realize()
> >> 
> >> Hi Zhao,
> >> 
> >> On 31/1/24 15:29, Zhao Liu wrote:
> >> > From: Zhao Liu <zhao1.liu@intel.com>
> >> > 
> >> > IOAPICCommonClass implements its own private realize(), and this private
> >> > realize() allows error.
> >> > 
> >> > Therefore, return directly if IOAPICCommonClass.realize() meets error.
> >> > 
> >> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >> > ---
> >> >   hw/intc/ioapic_common.c | 3 +++
> >> >   1 file changed, 3 insertions(+)
> >> > 
> >> > diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> >> > index cb9bf6214608..3772863377c2 100644
> >> > --- a/hw/intc/ioapic_common.c
> >> > +++ b/hw/intc/ioapic_common.c
> >> > @@ -162,6 +162,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
> >> >      info = IOAPIC_COMMON_GET_CLASS(s);
> >> >      info->realize(dev, errp);
> >> > +    if (*errp) {
> >> > +        return;
> >> > +    }
> 
> This is wrong, although it'll work in practice.
> 
> It's wrong, because dereferencing @errp requires ERRP_GUARD().
> qapi/error.h:
> 
>  * = Why, when and how to use ERRP_GUARD() =
>  *
>  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>  * - It must not be dereferenced, because it may be null.
>  * - It should not be passed to error_prepend() or
>  *   error_append_hint(), because that doesn't work with &error_fatal.
>  * ERRP_GUARD() lifts these restrictions.
>  *
>  * To use ERRP_GUARD(), add it right at the beginning of the function.
>  * @errp can then be used without worrying about the argument being
>  * NULL or &error_fatal.
>  *
>  * Using it when it's not needed is safe, but please avoid cluttering
>  * the source with useless code.
> 
> It'll work anyway, because the caller never passes null.
> 
> Obvious fix:
> 
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index cb9bf62146..280404cba5 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int version_id)
>  
>  static void ioapic_common_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      IOAPICCommonState *s = IOAPIC_COMMON(dev);
>      IOAPICCommonClass *info;

Thanks for explaining and educating me!

>  
> >> Could be clearer to deviate from DeviceRealize and let the
> >> handler return a boolean:
> >> 
> >> -- >8 --
> >> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
> >> index 37b8565539..9664bb3e00 100644
> >> --- a/hw/intc/ioapic_internal.h
> >> +++ b/hw/intc/ioapic_internal.h
> >> @@ -92,3 +92,3 @@ struct IOAPICCommonClass {
> >> 
> >> -    DeviceRealize realize;
> >> +    bool (*realize)(DeviceState *dev, Error **errp);
> 
> qapi.error.h advises:
> 
>  * - Whenever practical, also return a value that indicates success /
>  *   failure.  This can make the error checking more concise, and can
>  *   avoid useless error object creation and destruction.  Note that
>  *   we still have many functions returning void.  We recommend
>  *   • bool-valued functions return true on success / false on failure,
>  *   • pointer-valued functions return non-null / null pointer, and
>  *   • integer-valued functions return non-negative / negative.
> 
> The patch then becomes
> 
>           info = IOAPIC_COMMON_GET_CLASS(s);
>      -    info->realize(dev, errp);
>      +    if (!info->realize(dev, errp) {
>      +        return;
>      +    }
> 
> DeviceClass and BusClass callbacks realize, unrealize ignore this
> advice: they return void.  Why?
> 
> Following the advice makes calls easier to read, but the callees have to
> do a tiny bit of extra work: return something.  Good trade when we have
> at least as many callers as callees.
> 
> But these callbacks have many more callees: many devices implement them,
> but only a few places call.  Changing them to return something looked
> like more trouble than it's worth, so we didn't.

Thanks! Got it.

> 
> > What about I change the name of this interface?
> >
> > Maybe ioapic_realize(), to distinguish it from DeviceClass.realize().
> 
> I wouldn't bother.

;-)

> 
> >>      DeviceUnrealize unrealize;
> >
> > Additionally, if I change the pattern of realize(), should I also avoid
> > the DeviceUnrealize macro for symmetry's sake and just declare a similar
> > function pointer as you said?
> >
> > Further, do you think it's necessary to introduce InternalRealize and
> > InternalUnrealize macros for qdev
> 
> You mean typedefs?

Yes!

> 
> >                          for qdev to wrap these special realize/unrealize
> > to differentiate them from normal DeviceRealize/DeviceUnrealize?
> >
> > Because I found that this pattern of realize() (i.e. registering the
> > realize() of the child class in the parent class instead of DeviceClass,
> > and then calling the registered realize() in parent realize()) is also
> > widely used in many cases:
> >
> > * xen_block_realize()
> > * virtser_port_device_realize()
> > * x86_iommu_realize()
> > * virtio_input_device_realize()
> > * apic_common_realize()
> > * pc_dimm_realize()
> > * virtio_device_realize()
> > ...
> 
> Yes.
> 
> When a subtype overrides a supertype's method, it often makes sense to
> have the subtype's method call the supertype's method.

Thanks! I can consider a simple RFC to introduce a new typedef.

> 
> > I'm not quite sure if this is a generic way to use it, although it looks
> > like it could easily be confused with DeviceClass.realize().
> 
> Did I answer your question?  I'm not sure :)

Of course you did. :-)

> 
> >> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> >> index 409d0c8c76..96747ef2b8 100644
> >> --- a/hw/i386/kvm/ioapic.c
> >> +++ b/hw/i386/kvm/ioapic.c
> >> @@ -121,3 +121,3 @@ static void kvm_ioapic_set_irq(void *opaque, int irq,
> >> int level)
> >> 
> >> -static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
> >> +static bool kvm_ioapic_realize(DeviceState *dev, Error **errp)
> >>  {
> >> @@ -133,2 +133,4 @@ static void kvm_ioapic_realize(DeviceState *dev, Error
> >> **errp)
> >>      qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
> >> +
> >> +    return true;
> >>  }
> >> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> >> index cb9bf62146..beab65be04 100644
> >> --- a/hw/intc/ioapic_common.c
> >> +++ b/hw/intc/ioapic_common.c
> >> @@ -163,3 +163,5 @@ static void ioapic_common_realize(DeviceState *dev,
> >> Error **errp)
> >>      info = IOAPIC_COMMON_GET_CLASS(s);
> >> -    info->realize(dev, errp);
> >> +    if (!info->realize(dev, errp)) {
> >> +        return;
> >> +    }
> >> 
> >> ---
> >> 
> >> What do you think?
> >
> > I'm OK with the change here, but not sure if the return of private
> > realize() should be changed elsewhere as well.
> 
> I think I'd add the missing ERRP_GUARD() and call it a day.
> 

Okay, let me add the missing ERRP_GUARD(). I'll also check and clean up
other place where the ERRP_GUARD() is also missing.

Regards,
Zhao


