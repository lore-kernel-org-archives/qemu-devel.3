Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2168AC47258
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 03:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVNVG-0003M9-5C; Wed, 31 Jan 2024 22:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVNVD-0003LK-22; Wed, 31 Jan 2024 22:12:35 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rVNVA-0002S1-OF; Wed, 31 Jan 2024 22:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706757152; x=1738293152;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IcvDNDWkxs1PQ7ynL6ZrqSwTC0F13wtCNCDET+7lDmk=;
 b=OQKj84/KCBMUnWBDp7tONUMwta1L6eKuZicHA3yZlBnKC+/U5EqDpqUC
 Pm+j6ilk76ZrHRS029jTRz3PY5Qv1WKZp1u9oSFRLv2OkmUfxdhdH2P7/
 G8qZqyaV+Q7QJhlu893pyNEzoikJ109BcaLsLBjBI3quLCcv9RzglmnqK
 hZvGMvhVAh9oiT5TGmZWS3PsGOEVyfSveSUYmfYhu+xWE5g7OM0Q2CbzB
 /b39/r5KUqkfYNlWSuInwyRysLLkj3WI9JVQ0k/E0/3lxg62epj59ME7u
 SQlHuJkuNfGVw7PRig/UnphAvVt5nSOkXgKrXfO/kvIdPNXrXInvwOcwb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403410887"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="403410887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 19:12:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822797350"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="822797350"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 31 Jan 2024 19:12:26 -0800
Date: Thu, 1 Feb 2024 11:25:56 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] hw/intc: Handle the error of IOAPICCommonClass.realize()
Message-ID: <ZbsPRB4OM027fbMA@intel.com>
References: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
 <cdb1c6cd-0095-4787-a740-17b42e061548@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdb1c6cd-0095-4787-a740-17b42e061548@linaro.org>
Received-SPF: none client-ip=192.55.52.115;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Wed, Jan 31, 2024 at 05:48:24PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 31 Jan 2024 17:48:24 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] hw/intc: Handle the error of
>  IOAPICCommonClass.realize()
> 
> Hi Zhao,
> 
> On 31/1/24 15:29, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > IOAPICCommonClass implements its own private realize(), and this private
> > realize() allows error.
> > 
> > Therefore, return directly if IOAPICCommonClass.realize() meets error.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/intc/ioapic_common.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> > index cb9bf6214608..3772863377c2 100644
> > --- a/hw/intc/ioapic_common.c
> > +++ b/hw/intc/ioapic_common.c
> > @@ -162,6 +162,9 @@ static void ioapic_common_realize(DeviceState *dev, Error **errp)
> >       info = IOAPIC_COMMON_GET_CLASS(s);
> >       info->realize(dev, errp);
> > +    if (*errp) {
> > +        return;
> > +    }
> 
> Could be clearer to deviate from DeviceRealize and let the
> handler return a boolean:
> 
> -- >8 --
> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
> index 37b8565539..9664bb3e00 100644
> --- a/hw/intc/ioapic_internal.h
> +++ b/hw/intc/ioapic_internal.h
> @@ -92,3 +92,3 @@ struct IOAPICCommonClass {
> 
> -    DeviceRealize realize;
> +    bool (*realize)(DeviceState *dev, Error **errp);

What about I change the name of this interface?

Maybe ioapic_realize(), to distinguish it from DeviceClass.realize().

>      DeviceUnrealize unrealize;

Additionally, if I change the pattern of realize(), should I also avoid
the DeviceUnrealize macro for symmetry's sake and just declare a similar
function pointer as you said?

Further, do you think it's necessary to introduce InternalRealize and
InternalUnrealize macros for qdev to wrap these special realize/unrealize
to differentiate them from normal DeviceRealize/DeviceUnrealize?

Because I found that this pattern of realize() (i.e. registering the
realize() of the child class in the parent class instead of DeviceClass,
and then calling the registered realize() in parent realize()) is also
widely used in many cases:

* xen_block_realize()
* virtser_port_device_realize()
* x86_iommu_realize()
* virtio_input_device_realize()
* apic_common_realize()
* pc_dimm_realize()
* virtio_device_realize()
...

I'm not quite sure if this is a generic way to use it, although it looks
like it could easily be confused with DeviceClass.realize().

> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> index 409d0c8c76..96747ef2b8 100644
> --- a/hw/i386/kvm/ioapic.c
> +++ b/hw/i386/kvm/ioapic.c
> @@ -121,3 +121,3 @@ static void kvm_ioapic_set_irq(void *opaque, int irq,
> int level)
> 
> -static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
> +static bool kvm_ioapic_realize(DeviceState *dev, Error **errp)
>  {
> @@ -133,2 +133,4 @@ static void kvm_ioapic_realize(DeviceState *dev, Error
> **errp)
>      qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
> +
> +    return true;
>  }
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index cb9bf62146..beab65be04 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -163,3 +163,5 @@ static void ioapic_common_realize(DeviceState *dev,
> Error **errp)
>      info = IOAPIC_COMMON_GET_CLASS(s);
> -    info->realize(dev, errp);
> +    if (!info->realize(dev, errp)) {
> +        return;
> +    }
> 
> ---
> 
> What do you think?

I'm OK with the change here, but not sure if the return of private
realize() should be changed elsewhere as well.

Thanks,
Zhao


