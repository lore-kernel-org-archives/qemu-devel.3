Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFDDCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbrZ-0007PN-T6; Thu, 28 May 2026 10:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSbrX-0007OF-G9
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wSbrT-00043N-Iu
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779979041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds9ttEKj2xzKrTvEKxprrQ+Q6jkK0OdbfVZ16DgyZ6I=;
 b=abz50JKNA3ha3O46VtNiaJjiMWEm/BkeWEnUsgpNzSaqB3oPkMz47mujkL2Cc6iDrmiui0
 QeNMThcxHE41JdkDFYIqLqxQ7ZIrX87ZZpDVCfvX7LnKduqDdbcwtjtAhBAsXZz2NTkNlc
 F+s3KKi2PCSKCI99IyqvqP2n0wIOJAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-9xurlTbgMh29o-cTabNYDA-1; Thu, 28 May 2026 10:37:18 -0400
X-MC-Unique: 9xurlTbgMh29o-cTabNYDA-1
X-Mimecast-MFC-AGG-ID: 9xurlTbgMh29o-cTabNYDA_1779979037
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fdacf2616so67944075e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779979037; x=1780583837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds9ttEKj2xzKrTvEKxprrQ+Q6jkK0OdbfVZ16DgyZ6I=;
 b=CJBmU9rudaVt27IAu6l+aOi4sLeFA6ApLkVRhwBZVGu1SyZehVoWUTN8Wg3gJiq4n/
 2DFxs0CgbKntCJE/ByEjBImi44yS/PpcCMTATTHd9YWaDr/7yR2YSIaa62gqADj7S1xv
 wihlVMFjokGn2rxviuZqol7ZUO8Rk4Q5FC/zpbLwsa6n/M9rfzEs5IaHjIu/3jWn6Ws7
 mO3qK00BhYfdcXxGX9SHHCMNpEiDuXEOuYIlUbNQwmyUgKvTD1Idw1dFiAuoTxT2anLE
 avUn4FsEmpZjGFNzfII8p29Z7TJzpxjinFT1XjUBj0/NKfAuZWvvB/V/g/IgNAk7sD63
 GmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979037; x=1780583837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ds9ttEKj2xzKrTvEKxprrQ+Q6jkK0OdbfVZ16DgyZ6I=;
 b=exNO6WyUlPRlPNPpccZrzwfm96A5lHDa3YI/t7LYSpecTF5FbK9yg1qQsP9ceIoUzT
 ikPvMpVLIBUWlmHfRuWXoNwTi66seWaGlfekGnqlBf4lpDSAiPUiCbOr6l8oFRnbpwqD
 IESXF4axLnScFDRG31awDHvqEzEmoPUesEwDuZXlZxOD1x4vrAPt9fwoBRsIY7s5jLWM
 gaKfYvbH+TVorhJ/6OufrEO3WzF9c3ti/WF2AD2HZW01lMd+TvyGadiLWj8ljCxSM8Je
 cnjlVWYKfvlteHSpLat8BZaOJ3pPSUHijPndaeGN5opAuIAknMOqVjgBMOCO0Rz0SOl3
 unfQ==
X-Gm-Message-State: AOJu0Yya/6tcKxNH7rh/uHM4hSWh2hyO9tG5lX1lMxV5dUQOtuXVI5Jn
 t0To3X3kjgOeYqAxVGFxRk1k5icuZi3b2WANwg/RTnFv8GHHNmSggmb6oCsY3tmEJ697mq4dGWn
 03MOdczAKZ/cRjGO8aHDTGm2/VrBUJY/BsHwsv1Qb5mF62Dc6BelyNVeM
X-Gm-Gg: Acq92OH5eD3po1uYhxHRs64egBR2M8zFToKYUPfeY7mwUdUUygXwiY5iwFPeOpNtci4
 W02uuaAKf0+3iRIl7Ol5wapW4vhuUG+jF0raXT7LhcJ5xNe+ynYha/6kAj0JiAVU+nydu/t8sqf
 yAjqZ3MiMgzLI7NVWndoMuCK2Lntc524Ys8lWdF5LAmAU3dNdEXl6U5xRWIw6AV75NnbDKhlRlO
 wtyQkeX0VNSkdD74KG2qyI/lKiXg5nwsz98zl1Dru14qyurJmDYd4FN2xJQSPTMiZfczD/UkhiJ
 F1QKMNbHq2/41xHPoFYGxqVaoXd6kTgTR5n7WN7d9fzF8/+mCaxa1Wc8u7IaAIv7ez1Udq98Fgg
 oBar5FijOxKumg1ZK
X-Received: by 2002:a05:600c:5548:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-490424b0854mr297297035e9.9.1779979037129; 
 Thu, 28 May 2026 07:37:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5548:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-490424b0854mr297296655e9.9.1779979036636; 
 Thu, 28 May 2026 07:37:16 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909284586bsm43762495e9.8.2026.05.28.07.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:37:16 -0700 (PDT)
Date: Thu, 28 May 2026 16:37:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v2 09/21] arm: virt: create sbsa_gwdt watchdog
Message-ID: <20260528163714.7efb851e@imammedo>
In-Reply-To: <b6895403-e294-44de-b77d-511cddadb567@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-10-imammedo@redhat.com>
 <4cdd38f4-4efc-48c5-a236-a40449ad8e85@redhat.com>
 <20260527144955.64eff309@imammedo>
 <affe914f-157f-4125-93c5-abb94df3ab5b@redhat.com>
 <b6895403-e294-44de-b77d-511cddadb567@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 28 May 2026 11:59:06 +0200
Eric Auger <eauger@redhat.com> wrote:

> Hi,
> 
> On 5/28/26 11:04 AM, Eric Auger wrote:
> > Hi Igor,
> > 
> > On 5/27/26 2:49 PM, Igor Mammedov wrote:  
> >> On Tue, 26 May 2026 15:58:08 +0200
> >> Eric Auger <eauger@redhat.com> wrote:
> >>  
> >>> Hi Igor,
> >>>
> >>> On 3/3/26 10:25 AM, Igor Mammedov wrote:  
> >>>> Allow to use SBSA generic watchdog with virt machine type.
> >>>> (includes conditional generation of corresponding FDT and
> >>>> ACPI GTDT descriptors)
> >>>>
> >>>> Use '-device sbsa_gwdt' to command line to enable it.    
> >>> I thank that in general Peter is not a big fan of dynamic instantiation
> >>> of sysbus devices. Don't you have means to instantiate it statically in
> >>> arm virt memory map?  

On Peter's part, there weren't any objection to the idea using -device.
(neither in v1 nor in this revision).


> >> /me neither
> >>
> >> in previous version there was a machine option to enable the feature
> >> to that was rejected in favor of device.
> >>
> >> in this case for platform  -device of sysbus based device, I don't think
> >> we can do better that dynamic sysbus.   
> > 
> > sorry I may have missed some previous discussion details. As far as I
> > can read, I understand you could instantiate the wdt in a free MMIO
> > slot, unconfitionnaly just as it is done in hw/arm/sbsa-ref.c. Maybe add
> > a compat to avoid having it by default on older machine types. Then
> > about the type of the integration gtdt or wat, can't you have a device
> > compat?  
> After further reading of the previous version thread, I wonder if you
> shouldn't always instantiate the watchdog in the machine instead.
> 
> Add a device property allowing to switch between GWDT or WDAT version.
> 
> In arm virt,
> 
> 1) if you discover the GWDT version is selected (default) you generate
> both dt and GTDT ACPI table
> 2) if you discover the WDAT version is selected, you only generate WDAT
> ACPI description and you output an error in case of DT boot.
> 
> You may add a machine no_wdt flag to handle compats for older machine
> types if needed.

rereading v1 thread it seems that there weren't much objection to adding
a dedicated virt machine property to enable 'wdat' [1] /like what is done to q35/.

problem was in conflating too generic whatchdog=none/auto/native/acpi into
one knob and discussion quickly went down rabbit hole of semantics.

For Q35, we don't really have a choice as it's already builtin device,
but for arm/virt we can do better than a bunch of compats and proxy
properties. (as Markus noted in v1 review, we've done that/still do
but it doesn't scale well)

I can go old route and revert to simplified v1 that would:
  * make gwdt builtin device on arm/virt board
    (i.e. default to SBSA native watchdog with GTDT ACPI table
     and relevant FDT entries)
  * add a machine.gwdt-wdat=on|off property
     1. that will make gwdt to use 1KHz frequency
     2. enable WDAT ACPI table
     3. disable GTDT ACPI table and relevant FDT entries
        as they are mutually exclusive with #1 point 
  * add a compat knob to disable gwdt on old machine types.

Re-spinning that wouldn't take much effort, all the code already exist,
just needs mostly reshuffling. 

1) I think Daniel was ok having something like gwdt-wdat=on|off
   from libvirt pov.

That said,
Having watchdog as an optional -device is much cleaner compared to
adding knobs to machine (both internal compats and external to enable
specific watchdog).

Good (well bad actualy) example of compats/props is set of
ITS ones, one eventually can untangle what depends on what
and how that works together, but I'd rather avoid doing that. 

Perhaps I went overboard with move to -device.
Anyways, all I can do is suggest in my opinion a better way,
but it's upto arm folks to pick a preferred approach.

> Would that make sense?
> 
> Otherwise, can you point me the msgid where the -device was prefered?
Sorry, rereading v1 thread, -device was just an idea to try
(but by no means a preferred/consensus one).

> 
> Thanks
> 
> Eric
> > 
> > Thanks
> > 
> > Eric
> >   
> >>
> >>    
> >>>
> >>> Eric  
> >>>>
> >>>> Tested with Fedora 43:
> >>>>   FDT: -M virt,acpi=off -device sbsa_gwdt
> >>>>   ACPI: -M virt -device sbsa_gwdt
> >>>>
> >>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>> ---
> >>>>  hw/arm/Kconfig           |  1 +
> >>>>  hw/arm/virt-acpi-build.c | 33 +++++++++++++++++++++++++++++++--
> >>>>  hw/arm/virt.c            |  2 ++
> >>>>  hw/core/sysbus-fdt.c     | 32 ++++++++++++++++++++++++++++++++
> >>>>  hw/watchdog/sbsa_gwdt.c  |  1 +
> >>>>  5 files changed, 67 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> >>>> index c66c452737..1222efadd1 100644
> >>>> --- a/hw/arm/Kconfig
> >>>> +++ b/hw/arm/Kconfig
> >>>> @@ -36,6 +36,7 @@ config ARM_VIRT
> >>>>      select VIRTIO_MEM_SUPPORTED
> >>>>      select ACPI_CXL
> >>>>      select ACPI_HMAT
> >>>> +    select WDT_SBSA
> >>>>  
> >>>>  config CUBIEBOARD
> >>>>      bool
> >>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >>>> index 719d2f994e..9c14b1d4d5 100644
> >>>> --- a/hw/arm/virt-acpi-build.c
> >>>> +++ b/hw/arm/virt-acpi-build.c
> >>>> @@ -64,6 +64,7 @@
> >>>>  #include "hw/virtio/virtio-acpi.h"
> >>>>  #include "target/arm/cpu.h"
> >>>>  #include "target/arm/multiprocessing.h"
> >>>> +#include "hw/watchdog/sbsa_gwdt.h"
> >>>>  
> >>>>  #define ARM_SPI_BASE 32
> >>>>  
> >>>> @@ -863,6 +864,8 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>>>      const uint32_t irqflags = 0;  /* Interrupt is Level triggered  */
> >>>>      AcpiTable table = { .sig = "GTDT", .rev = 3, .oem_id = vms->oem_id,
> >>>>                          .oem_table_id = vms->oem_table_id };
> >>>> +    uint32_t gtdt_start = table_data->len;
> >>>> +    Object *wdt = object_resolve_type_unambiguous(TYPE_WDT_SBSA, NULL);
> >>>>  
> >>>>      acpi_table_begin(&table, table_data);
> >>>>  
> >>>> @@ -893,10 +896,15 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>>>      build_append_int_noprefix(table_data, irqflags, 4);
> >>>>      /* CntReadBase Physical address */
> >>>>      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
> >>>> +
> >>>>      /* Platform Timer Count */
> >>>> -    build_append_int_noprefix(table_data, 0, 4);
> >>>> +    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
> >>>>      /* Platform Timer Offset */
> >>>> -    build_append_int_noprefix(table_data, 0, 4);
> >>>> +    build_append_int_noprefix(table_data,
> >>>> +        wdt ? (table_data->len - gtdt_start) +
> >>>> +              4 + 4 + 4 /* len of this & following 2 fields to skip */
> >>>> +            : 0, 4);
> >>>> +
> >>>>      if (vms->ns_el2_virt_timer_irq) {
> >>>>          /* Virtual EL2 Timer GSIV */
> >>>>          build_append_int_noprefix(table_data, ARCH_TIMER_NS_EL2_VIRT_IRQ, 4);
> >>>> @@ -906,6 +914,27 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >>>>          build_append_int_noprefix(table_data, 0, 4);
> >>>>          build_append_int_noprefix(table_data, 0, 4);
> >>>>      }
> >>>> +
> >>>> +    /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5-124) */
> >>>> +    if (wdt) {
> >>>> +        PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
> >>>> +        SysBusDevice *sd = SYS_BUS_DEVICE(wdt);
> >>>> +        hwaddr mmio_base = vms->memmap[VIRT_PLATFORM_BUS].base;
> >>>> +        hwaddr rbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> >>>> +        hwaddr cbase = mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> >>>> +        int irq = ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> >>>> +                  platform_bus_get_irqn(pbus, sd, 0);
> >>>> +
> >>>> +        build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT */, 1);
> >>>> +        build_append_int_noprefix(table_data, 28 /* Length */, 2);
> >>>> +        build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> >>>> +        /* RefreshFrame Physical Address */
> >>>> +        build_append_int_noprefix(table_data, rbase, 8);
> >>>> +        /* WatchdogControlFrame Physical Address */
> >>>> +        build_append_int_noprefix(table_data, cbase, 8);
> >>>> +        build_append_int_noprefix(table_data, irq, 4); /* Watchdog Timer GSIV */
> >>>> +        build_append_int_noprefix(table_data, 0, 4); /* Watchdog Timer Flags */
> >>>> +    }
> >>>>      acpi_table_end(linker, &table);
> >>>>  }
> >>>>  
> >>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>>> index cab2e21e8a..a87991b591 100644
> >>>> --- a/hw/arm/virt.c
> >>>> +++ b/hw/arm/virt.c
> >>>> @@ -95,6 +95,7 @@
> >>>>  #include "hw/cxl/cxl.h"
> >>>>  #include "hw/cxl/cxl_host.h"
> >>>>  #include "qemu/guest-random.h"
> >>>> +#include "hw/watchdog/sbsa_gwdt.h"
> >>>>  
> >>>>  static GlobalProperty arm_virt_compat_defaults[] = {
> >>>>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> >>>> @@ -3474,6 +3475,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
> >>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> >>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
> >>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ARM_SMMUV3);
> >>>> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_WDT_SBSA);
> >>>>  #ifdef CONFIG_TPM
> >>>>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
> >>>>  #endif
> >>>> diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
> >>>> index 89d0c46445..76aa1bc579 100644
> >>>> --- a/hw/core/sysbus-fdt.c
> >>>> +++ b/hw/core/sysbus-fdt.c
> >>>> @@ -36,6 +36,7 @@
> >>>>  #include "hw/display/ramfb.h"
> >>>>  #include "hw/uefi/var-service-api.h"
> >>>>  #include "hw/arm/fdt.h"
> >>>> +#include "hw/watchdog/sbsa_gwdt.h"
> >>>>  
> >>>>  /*
> >>>>   * internal struct that contains the information to create dynamic
> >>>> @@ -118,6 +119,36 @@ static int add_uefi_vars_node(SysBusDevice *sbdev, void *opaque)
> >>>>      return 0;
> >>>>  }
> >>>>  
> >>>> +static int add_sbsa_gwdt_node(SysBusDevice *sbdev, void *opaque)
> >>>> +{
> >>>> +    PlatformBusFDTData *data = opaque;
> >>>> +    PlatformBusDevice *pbus = data->pbus;
> >>>> +    const char *parent_node = data->pbus_node_name;
> >>>> +    void *fdt = data->fdt;
> >>>> +    uint64_t cbase, rbase;
> >>>> +    char *nodename;
> >>>> +    int irq;
> >>>> +
> >>>> +    cbase = platform_bus_get_mmio_addr(pbus, sbdev, 1);  /* control frame */
> >>>> +    rbase = platform_bus_get_mmio_addr(pbus, sbdev, 0);  /* refresh frame */
> >>>> +    irq = platform_bus_get_irqn(pbus, sbdev, 0);
> >>>> +
> >>>> +    nodename = g_strdup_printf("%s/watchdog@%" PRIx64, parent_node, cbase);
> >>>> +    qemu_fdt_add_subnode(fdt, nodename);
> >>>> +
> >>>> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "arm,sbsa-gwdt");
> >>>> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> >>>> +                           cbase, SBSA_GWDT_CMMIO_SIZE,
> >>>> +                           rbase, SBSA_GWDT_RMMIO_SIZE);
> >>>> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
> >>>> +                           GIC_FDT_IRQ_TYPE_SPI, data->irq_start + irq,
> >>>> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> >>>> +    qemu_fdt_setprop_cell(fdt, nodename, "timeout-sec", 30);
> >>>> +
> >>>> +    g_free(nodename);
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>>  static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
> >>>>  {
> >>>>      return 0;
> >>>> @@ -140,6 +171,7 @@ static const BindingEntry bindings[] = {
> >>>>      TYPE_BINDING(TYPE_ARM_SMMUV3, no_fdt_node),
> >>>>      TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
> >>>>      TYPE_BINDING(TYPE_UEFI_VARS_SYSBUS, add_uefi_vars_node),
> >>>> +    TYPE_BINDING(TYPE_WDT_SBSA, add_sbsa_gwdt_node),
> >>>>      TYPE_BINDING("", NULL), /* last element */
> >>>>  };
> >>>>  
> >>>> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> >>>> index acb970e8b3..c4dd8005b7 100644
> >>>> --- a/hw/watchdog/sbsa_gwdt.c
> >>>> +++ b/hw/watchdog/sbsa_gwdt.c
> >>>> @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
> >>>>      dc->realize = wdt_sbsa_gwdt_realize;
> >>>>      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
> >>>>      dc->hotpluggable = false;
> >>>> +    dc->user_creatable = true;
> >>>>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
> >>>>      dc->vmsd = &vmstate_sbsa_gwdt;
> >>>>      dc->desc = "SBSA-compliant generic watchdog device";    
> >>>  
> >>  
> >   
> 


