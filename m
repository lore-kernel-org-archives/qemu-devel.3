Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF20C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 05:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYfBC-0006HG-8u; Tue, 30 Jul 2024 01:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYfBA-0006Cu-6F; Tue, 30 Jul 2024 01:13:44 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sYfB7-0005YV-EJ; Tue, 30 Jul 2024 01:13:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 46659CE0E83;
 Tue, 30 Jul 2024 05:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D1BC32782;
 Tue, 30 Jul 2024 05:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722316416;
 bh=PQJFs7gjyhFWEMZiRmJiA0Z37OpC0Ojvb6+jE9X5Pog=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tqHBDCq310djAi++Ewo9maQ/VNgqX66At3Yh8sG3vIxc0/p65dSLG1xc2mRpcG2Qm
 jgnVnPnbbmCBDrhw6/a8E3EeL7fjFVZv/nCbbcvQ4zvdnGW3QhyAzl6hAoczPRDBEg
 WjM8FshXqcJCcfV2uXbOMOY5jcRJd7VXbOmhqtx6R4o+cJvld+qcwsKpOBOUerZ3WS
 XfnQisOT09MkkXz/oZriuOtbjgSx9bypVx3PF1eBMTbfxKqWHjX/qrASsa8ZQx3YGd
 nvy+oKL0AM9chTUlBdRPKPvWVB9i40SRWRWp8p9V6PWZf0pmkbGWTmTsAb+pXAjKVN
 Nmoa6m/za+bBg==
Date: Tue, 30 Jul 2024 07:13:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Yanan
 Wang" <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240730071330.4835e943@foz.lan>
In-Reply-To: <20240729170840.00004763@Huawei.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
 <20240729170840.00004763@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Mon, 29 Jul 2024 17:08:40 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Mon, 29 Jul 2024 15:21:06 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Creates a Generic Event Device (GED) as specified at  
> 
> I wrote this a while back and wasn't aware of the naming
> mess around GED in the ACPI spec.  This one is just
> referred to as 'error device' whereas there is also
> a Generic Event Device.
> 
> Linux solved this clash by going with Hardware Error Device
> I think we should do the same here.

I opted to do it a little bit different to stay closer to ACPI 6.5
18.3.2.7.2. - Event Notification For Generic Error Sources.

There, it is actually talking about a General Purpose Event (GPE).
Current ACPI spec doesn't mention "GED", so maybe such term was fixed
on some previous ACPI spec revision.

Basically, it currently mentions:
	- error device
	- GPE / General Purpose Event
	- Generic Hardware Error Source Structure 

I guess Linux crafted the term Hardware Error device by mixing
those.

As we don't need to really preserve such names here, as this appears
only at the patch description, I opted to rewrite the patch description
to:

    arm/virt: Wire up GPIO error source for ACPI / GHES
    
    Creates a hardware event device to support General Purpose
    Event (GPE) as specified at ACPI 6.5 specification at 18.3.2.7.2:
    https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
    using HID PNP0C33.
    
    The PNP0C33 device is used to report hardware errors to
    the bios via ACPI APEI Generic Hardware Error Source (GHES).
    
    It is aligned with Linux Kernel patch:
    https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
    
    [mchehab: use a define for the generic event pin number and do some cleanups]
    Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Clearly associating "hardware event device" with ACPI GPE. That sounds
good enough to be stored at the git description associated with such
change.

> > ACPI 6.5 specification at 18.3.2.7.2:
> > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > with HID PNP0C33.
> > 
> > The PNP0C33 device is used to report hardware errors to
> > the bios via ACPI APEI Generic Hardware Error Source (GHES).
> > 
> > It is aligned with Linux Kernel patch:
> > https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> > 
> > [mchehab: use a define for the generic event pin number and do some cleanups]
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> > ---
> >  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
> >  hw/arm/virt.c            | 14 ++++++++++++--
> >  include/hw/arm/virt.h    |  1 +
> >  include/hw/boards.h      |  1 +
> >  4 files changed, 40 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index f76fb117adff..c502ccf40909 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -63,6 +63,7 @@
> >  
> >  #define ARM_SPI_BASE 32
> >  
> > +#define ACPI_GENERIC_EVENT_DEVICE "GEDD"  
> 
> Ah. My mistake. This is the confusing named GENERIC_ERROR_DEVICE
> or HARDWARE_ERROR_DEVICE (which is what Linux called it because
> in the ACPI Spec it is just (all lower case) error device).

I opted to use a different name there, using just error device,
together with the name of the PNP device. So:

	#define PNP0C33_ERROR_DEVICE "GEDD"

This is clear enough for people just looking at the driver, and
even clearer for people familiar with session 18.3.2.7.2 of the
ACPI spec.

> 
> >  #define ACPI_BUILD_TABLE_SIZE             0x20000  
> 
> >  /* DSDT */
> >  static void
> >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > @@ -841,10 +863,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >                        HOTPLUG_HANDLER(vms->acpi_dev),
> >                        irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
> >                        memmap[VIRT_ACPI_GED].base);
> > -    } else {
> > -        acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> > -                           (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
> >      }
> > +    acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
> > +                       (irqmap[VIRT_GPIO] + ARM_SPI_BASE));  
> 
> Arguably excess brackets, but obviously this is just a code move
> so fine to keep it the same.

I'll drop the extra brackets.

> >  
> >      if (vms->acpi_dev) {
> >          uint32_t event = object_property_get_uint(OBJECT(vms->acpi_dev),
> > @@ -858,6 +879,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      }
> >  
> >      acpi_dsdt_add_power_button(scope);

> > +    acpi_dsdt_add_generic_event_device(scope);

I'm also renaming this function/function call to run away from GED,
calling it as:

	 acpi_dsdt_add_error_device(scope);

> >  #ifdef CONFIG_TPM
> >      acpi_dsdt_add_tpm(scope, vms);
> >  #endif  
> 

Thanks,
Mauro

