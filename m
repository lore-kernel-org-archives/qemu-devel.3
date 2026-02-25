Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B27BFD3767
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGgQ-0007o6-Dw; Wed, 25 Feb 2026 10:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvGgO-0007mp-Oo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:20:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvGgM-00031l-Q5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 10:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772032809;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Az+riaC/VH6n3RtnoJo1WZLfnynDIMNpzKr5EZ7PtZQ=;
 b=by1NsLbnyYkEbxExBQWElCJK1VLxO1vEJGhyGo+LBhOMJhwtKcLzVno1nwNNw2mFNcSDY1
 J8YgcOGjT3VCde4TYG8KPQjrqHG+v059HTXWV4tmchhOW4Jg+JvoF42DfhJ021b1HL/kxJ
 C3spo933BXJu9cWIM8dkxMqxjoA8p/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-XKdxygqOOG-mpLP8RBfMbA-1; Wed,
 25 Feb 2026 10:20:05 -0500
X-MC-Unique: XKdxygqOOG-mpLP8RBfMbA-1
X-Mimecast-MFC-AGG-ID: XKdxygqOOG-mpLP8RBfMbA_1772032804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDCD51956057; Wed, 25 Feb 2026 15:20:03 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46B741955F43; Wed, 25 Feb 2026 15:20:00 +0000 (UTC)
Date: Wed, 25 Feb 2026 15:19:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, philmd@linaro.org, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <aZ8THMubft44Q3E-@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219131751.4e4e4e0e@imammedo>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 19, 2026 at 01:17:51PM +0100, Igor Mammedov wrote:
> On Wed, 18 Feb 2026 19:08:36 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Fri, 6 Feb 2026 at 13:15, Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > Add SBSA generic watchdog to virt machine type with
> > > all necessary wiring for ACPI watchdog. Which includes
> > > setting its frequency to 1KHz (max that WDAT is able to handle).
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---  
> > 
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 390845c503..caf5700ed2 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -93,6 +93,7 @@
> > >  #include "hw/cxl/cxl.h"
> > >  #include "hw/cxl/cxl_host.h"
> > >  #include "qemu/guest-random.h"
> > > +#include "hw/watchdog/sbsa_gwdt.h"
> > >
> > >  static GlobalProperty arm_virt_compat[] = {
> > >      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> > > @@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] = {
> > >      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
> > >      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> > >      [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
> > > +    [VIRT_GWDT_REFRESH] =       { 0x090d0000, 0x00001000 },
> > > +    [VIRT_GWDT_CONTROL] =       { 0x090d1000, 0x00001000 },
> > >      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> > >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
> > >      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> > > @@ -245,12 +248,32 @@ static const int a15irqmap[] = {
> > >      [VIRT_GPIO] = 7,
> > >      [VIRT_UART1] = 8,
> > >      [VIRT_ACPI_GED] = 9,
> > > +    [VIRT_GWDT_WS0] = 10,
> > >      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
> > >      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> > >      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> > >      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
> > >  };
> > >
> > > +static void create_wdt(const VirtMachineState *vms)
> > > +{
> > > +    hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
> > > +    hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
> > > +    int irq = vms->irqmap[VIRT_GWDT_WS0];
> > > +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
> > > +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> > > +
> > > +    /*
> > > +     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
> > > +     * is able to handle.
> > > +     */
> > > +    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz */);
> > > +    sysbus_realize_and_unref(s, &error_fatal);
> > > +    sysbus_mmio_map(s, 0, rbase);
> > > +    sysbus_mmio_map(s, 1, cbase);
> > > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> > > +}  
> > 
> > Please can you also add support for exposing this device
> > in the device tree ?
> 
> It's possible,
> but we probably should not enable it if acpi variant was requested,
> to avoid confusion on guest side.
> 
> For Windows it doesn't really mater, for linux it does.
> on x86 linux guest uses a quirk to disable native iTCO watchdog
> in favor of WDAT one if later is present.
> I assume quirk is not desirable so we should expose only a preferred
> variant.
> 
> > 
> > > +
> > >  static void create_randomness(MachineState *ms, const char *node)
> > >  {
> > >      struct {
> > > @@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *machine)
> > >      vms->highmem_ecam &= (!firmware_loaded || aarch64);
> > >
> > >      create_rtc(vms);
> > > +    if (machine->acpi_watchdog) {
> > > +        create_wdt(vms);
> > > +    }  
> > 
> > Can we have a command line option name that isn't ACPI
> > specific, please? There's nothing inherent to ACPI about
> > "I would like a watchdog device".
> 
> that is specifically asking for ACPI flavor being used/configured.
> acpi specific option conflates 2 things:
>    1. watchdog device creation (of the board choice) with properties tuned for WDAT usage
>    2. how to expose it on firmware level (in this case ACPI WDAT table)
> 
> other option, I've considered was
>  -device some_wd[,fw=dt|acpi|none]
> but then 'fw' is not exactly device property but rather a machine one
> (we can 'abuse' it/use as a proxy of cause).
> However it doesn't work for boards that have builtin watchdog.

Right, if there was a case where we were already using -device to
create the watchdog, then I would suggest having a simple
'wadt=on|off' property as standard for any watchdog wanting that
ACPI abstraction wrapper.

That could (hypothetically) be the case if we had chosen to add
WADT suport backed by i6300esb, eg -device i6300esb,wadt=on|off

For cases built-in to the machine type, I'd suggest <type>-wadt=on|off

eg for Q35,  "-machine q35,itco-wadt=on|off"

for virt, '-machine virt,gwdt-wadt=on|off'

Q35 is easier as we rely on the guest quirks to disable direct
access via both paths.

With GWDT we need to decide if gwdt-wadt=on should imply DTB
disabled, or if we just expose both & rely on a guest quirk
or worst case, need a separate property to toggle DTB too.

> I've used device property for x86 Q35 TCO watchdog and
> then using -global to enable it as workaround in previous version.
> Ugly but doable workaround. It puts a burden on users to learn how
> to configure it for each support watchdog/board combo.
> It's nightmare to discover/maintain though.
> 
> Hence in this version, I've used a generic machine property approach
> that exposes feature in uniform way across boards.
> 
> enum might work, but ...
>   machine.watchdog = [acpi | what else could we put here???]
> 
> I'm not married to a way how we expose/configure it and will rewrite
> it to something that works for majority.
> 
> > thanks
> > -- PMM
> > 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


