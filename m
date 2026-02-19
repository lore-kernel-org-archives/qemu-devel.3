Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60D0E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2yv-0005ZR-L9; Thu, 19 Feb 2026 07:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt2yu-0005ZG-Kb
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vt2yr-0003CU-FH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771503479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgR6LZFtlESyTZT3ZwtaGPyLi6CG71IZgDFRW6wMycI=;
 b=Z6DFr+2jUhRxjkJNFVNhPboqrtjbd6OoQXu5OzdmChPevMUNfkjMRutfNg1TegrqZG2diB
 3XR9eRQDvl6spWxHtBtBqPZuBD1cBeqONMbQzPBH1LNb+xlajg4iHf96r5K+V0cNu9IgvY
 9CPogNviQtl+fBQSAr6oZmEtuNvVse0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-yUJXBDMQN3SZEeW8yx28EQ-1; Thu, 19 Feb 2026 07:17:58 -0500
X-MC-Unique: yUJXBDMQN3SZEeW8yx28EQ-1
X-Mimecast-MFC-AGG-ID: yUJXBDMQN3SZEeW8yx28EQ_1771503477
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59e6b4b5f35so620236e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 04:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771503476; x=1772108276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgR6LZFtlESyTZT3ZwtaGPyLi6CG71IZgDFRW6wMycI=;
 b=HhZz3jUqS7gQ9pUibVGuvnH7s/FDzQ6D4WPi826jaJ/mN/JVSu71A5rmDyUJ7J7nad
 drzHz7x/PuZvRyJhp1xINfkZmN+R2K1Vb4EIYAhG4LQ9Qq5VahZECVqsSRCcGnduRker
 hlwMhJzaJq2eEXm+2nNcdizi5RBcf72K+/r/CDSvIK5jc3oEw56raLALueL+KMt3RWli
 22SP/ICMi9j/zNh+XekhFNtGXsf9oXUyKkWaxifWZ9eFZWPdgfYtVX1arX6gOQ2nII4Y
 j7eyAN3qIz2UUEJqgxxlGR4KxvYcgkesfpy4QrmSjbEsd8p+r7gCLFaAYR/Uue+BxM8R
 ObFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771503476; x=1772108276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BgR6LZFtlESyTZT3ZwtaGPyLi6CG71IZgDFRW6wMycI=;
 b=LCak+FAvE8nlFXcOrebwmNLz5GQVxrad+TS7NE7TekUrKjiG5VTBoOGk+0O1l68ApK
 AcvCGDIExV373DUwjf++ZvRSLhQ7kktl4Ca5lc1l0vuUoA3nJm2s99oud1Rl/zVVj4vu
 9qToTokFPij2aKTd84raPIqSENWrn7PLNPe9MOFxtTJf65MTU6fQuzGpCSFH2APVKW2a
 dP5EKfesHUtT9aU0chRPsK2OrAqaO6+3w0cKUgWQfboqGvhJ+ZfKWXhmfUlhui4oh3Gz
 Yib/+EP0p642OjuKD9gHntKaWLQ0QrpjimfkndoIA47hEjrIPBl7eNa86CPXAVz5Qfqq
 ii0g==
X-Gm-Message-State: AOJu0Ywnt5DeNqBeOPLYMDzv8FFjn9K7PUiR2Xdt/sCobTEH0zSuVXVL
 7lZQuWUc6qvSu7nyTavS3w00m/2iqRWHIT/J1HEottF2d1jHQM6/rnKt+/sXjfF+lXR9htywviO
 XFF0dUTEpVnlA5Rd7LG0AHcDjD1dBsA6uqw2ro0kgCWuBiKQUEg8oXudC
X-Gm-Gg: AZuq6aLj6hKrP0T4xa67g9uFEUQVRHVcCjROiDBJO54nLnszYBzgnR3R6pIVsZpls7J
 ii8n2ciF9qAuAjkefX8QSPLAI+NeMRpxcAQk3CrezU43YHIe+2+1NzOEKe01B4QFu+2BxfOV2Zg
 MYVL9txca45B3vPjPfCxpNqVNv8xw5lsICSJ5s6iNkWjmejCxqsOn1nFrx6vQ0A6NRt5KPeQp1O
 RP0E+hqG5cjCgFbKoWra8btDda6X1ae+6Kna7kUCdkMT2h1wL+EGpwBp/qa8xstC0rCYSYzcCKM
 WifnMAShoQVgQLr3dg2Vq/scTcQ+C2uXwFBSCsi5jEMFQHdhhDcJICW4dgWLjFlLFWS7PPUBVsB
 gGxYXPw==
X-Received: by 2002:a05:6512:3da1:b0:59e:3c74:82e8 with SMTP id
 2adb3069b0e04-59f8975f3admr968356e87.31.1771503476147; 
 Thu, 19 Feb 2026 04:17:56 -0800 (PST)
X-Received: by 2002:a05:6512:3da1:b0:59e:3c74:82e8 with SMTP id
 2adb3069b0e04-59f8975f3admr968337e87.31.1771503475514; 
 Thu, 19 Feb 2026 04:17:55 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e5f5635afsm5451281e87.7.2026.02.19.04.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 04:17:54 -0800 (PST)
Date: Thu, 19 Feb 2026 13:17:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260219131751.4e4e4e0e@imammedo>
In-Reply-To: <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 18 Feb 2026 19:08:36 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 6 Feb 2026 at 13:15, Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Add SBSA generic watchdog to virt machine type with
> > all necessary wiring for ACPI watchdog. Which includes
> > setting its frequency to 1KHz (max that WDAT is able to handle).
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---  
> 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 390845c503..caf5700ed2 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -93,6 +93,7 @@
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_host.h"
> >  #include "qemu/guest-random.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> >
> >  static GlobalProperty arm_virt_compat[] = {
> >      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> > @@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] = {
> >      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
> >      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> >      [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
> > +    [VIRT_GWDT_REFRESH] =       { 0x090d0000, 0x00001000 },
> > +    [VIRT_GWDT_CONTROL] =       { 0x090d1000, 0x00001000 },
> >      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
> >      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> > @@ -245,12 +248,32 @@ static const int a15irqmap[] = {
> >      [VIRT_GPIO] = 7,
> >      [VIRT_UART1] = 8,
> >      [VIRT_ACPI_GED] = 9,
> > +    [VIRT_GWDT_WS0] = 10,
> >      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
> >      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> >      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> >      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
> >  };
> >
> > +static void create_wdt(const VirtMachineState *vms)
> > +{
> > +    hwaddr rbase = vms->memmap[VIRT_GWDT_REFRESH].base;
> > +    hwaddr cbase = vms->memmap[VIRT_GWDT_CONTROL].base;
> > +    int irq = vms->irqmap[VIRT_GWDT_WS0];
> > +    DeviceState *dev = qdev_new(TYPE_WDT_SBSA);
> > +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> > +
> > +    /*
> > +     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
> > +     * is able to handle.
> > +     */
> > +    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz */);
> > +    sysbus_realize_and_unref(s, &error_fatal);
> > +    sysbus_mmio_map(s, 0, rbase);
> > +    sysbus_mmio_map(s, 1, cbase);
> > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> > +}  
> 
> Please can you also add support for exposing this device
> in the device tree ?

It's possible,
but we probably should not enable it if acpi variant was requested,
to avoid confusion on guest side.

For Windows it doesn't really mater, for linux it does.
on x86 linux guest uses a quirk to disable native iTCO watchdog
in favor of WDAT one if later is present.
I assume quirk is not desirable so we should expose only a preferred
variant.

> 
> > +
> >  static void create_randomness(MachineState *ms, const char *node)
> >  {
> >      struct {
> > @@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *machine)
> >      vms->highmem_ecam &= (!firmware_loaded || aarch64);
> >
> >      create_rtc(vms);
> > +    if (machine->acpi_watchdog) {
> > +        create_wdt(vms);
> > +    }  
> 
> Can we have a command line option name that isn't ACPI
> specific, please? There's nothing inherent to ACPI about
> "I would like a watchdog device".

that is specifically asking for ACPI flavor being used/configured.
acpi specific option conflates 2 things:
   1. watchdog device creation (of the board choice) with properties tuned for WDAT usage
   2. how to expose it on firmware level (in this case ACPI WDAT table)

other option, I've considered was
 -device some_wd[,fw=dt|acpi|none]
but then 'fw' is not exactly device property but rather a machine one
(we can 'abuse' it/use as a proxy of cause).
However it doesn't work for boards that have builtin watchdog.

I've used device property for x86 Q35 TCO watchdog and
then using -global to enable it as workaround in previous version.
Ugly but doable workaround. It puts a burden on users to learn how
to configure it for each support watchdog/board combo.
It's nightmare to discover/maintain though.

Hence in this version, I've used a generic machine property approach
that exposes feature in uniform way across boards.

enum might work, but ...
  machine.watchdog = [acpi | what else could we put here???]

I'm not married to a way how we expose/configure it and will rewrite
it to something that works for majority.

> thanks
> -- PMM
> 


