Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B8AC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxQ2-0006bU-Qp; Tue, 27 May 2025 12:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJxPz-0006aa-7t
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:44:48 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJxPu-0003aH-OZ
 for qemu-devel@nongnu.org; Tue, 27 May 2025 12:44:46 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4c34dcdaf88so1119081137.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748364279; x=1748969079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fWACtrWaalwAXArq6dkgQ4lC7sW9OgiHvzv/SihIMIE=;
 b=ntpYMT20o1kXVGs/Ds+o0g00O7SGMY33dZu+oKSbE20Bq1JRs9j1RHpLGA/cm9xZos
 ZOt4Fm/47JyV0PUXdCGlon+4luq8gKqBjrXY6ujISHQrzpMyTYKBb5QyIQXOe/V7mGd3
 bvERWXG77pRVnDQlhMOmNzvuP7Tyitg8faP4jP+Q2MuZYCYr1tgonOnPXsOnM8FUHYMc
 1Tfb4P+dU0EkYh+2ie+GAP8LNDOBmiOR1NR6Uh8pZvgPmYc9+nLpZ4RC0yOJmDWkhwFb
 yrcTfBEYc7IF+FfpiVNH6gTsjyjmTcTWgoj2yShYlHmH0m2YRxVyWig+iGJtnWqugPjf
 1sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748364279; x=1748969079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWACtrWaalwAXArq6dkgQ4lC7sW9OgiHvzv/SihIMIE=;
 b=AMGFEvYDv/nrZn1I0hMoiQtakDmZO320STpgWsMFfGaSy8Fvst/BS3zmyW/ZqbLSsB
 udIxSCIBMmMj1YHtzJP4sLDl+knKBnkXRZdYyp8KNir1vSAldtXy2s6HpvVVLWC0biaP
 aXQs2eM1sTRQoCA1hZJ50FQkZ1QQGKafewGsp5Bi10BWo0Tn8rrexnCjm6iTvkUriQub
 +kFUs6C3xbcuzEERJnD/IyHVvgluweecAb2Q6Or9AaKWTktXihGURmfgP9yQuGdvq3Gq
 m7L6f8R5qrUYRtxoAKvJN7t/GKwLaL4jorpQYzXrC3PUbRnceMx1rBphMtmwq5lP/cae
 udZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqtqIbb8KUCxFEf+9goiyZ4OkrpmcLnTI+hLcmbIiBSxturAe09+dqWpDS+QqKw2FYNgplVGhmLtzP@nongnu.org
X-Gm-Message-State: AOJu0YyrzPKr4BUuAwDM+XTIYNTXXk1sgSCMaD6yhknuf7zJwhtjQ2Fy
 nssap6UMy22S2ilva5keylpOfSqu5MRQcotAnj9TFn01tmkaXT8QUYhfwZwDar3Ew3A=
X-Gm-Gg: ASbGnctDs2Y2BJz97iN994InffiKQ5/KLD0mKSxelFPSkEna+TH/07jDg5AsP1TOf56
 Olf+EhzZSGxiJc+dX/8m1O2AL5KXfW1GpCRXz4gFIf1Cl/TnwzfiC/mfVGIsfgtMINdazcmszvW
 73TzYeZL+hp0KQ7+mOxpOju0jlKSPJJj+P+DImhUmiu/hcDRnyqVI55qh+Bb+CreLGEEjMGVMQT
 mHDZpyOykzMfSSSiTsS5kANI66w2mJlkIWWmRel/tHX2wnSy8kj2HqYpLQ+0o+bnsnuq1W4Xkfo
 tfAf4rISOiJLpZxQ3eEJ/66bM5xS9s48e1H7UABerEc9DH9fay9p/wpMQgBGQaURWasey9tRR+q
 EFhs3l1DvQSDtUyZysRLdz2rvNHz5iw==
X-Google-Smtp-Source: AGHT+IH/aVe/baAiP+S78+Cd+i2KH+a20RigpR3mjwak07uFiW1Gk2M7EbR3eKXViU9xroP7ZJpCAw==
X-Received: by 2002:a05:6102:3f06:b0:4e2:bacd:9f02 with SMTP id
 ada2fe7eead31-4e4241609f7mr10014108137.16.1748364279113; 
 Tue, 27 May 2025 09:44:39 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:2066:dacd:9134:8586?
 ([2804:7f0:b402:6ba2:2066:dacd:9134:8586])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4e459aa1ca7sm2938271137.24.2025.05.27.09.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 09:44:38 -0700 (PDT)
Message-ID: <363b7862-84b3-4bd1-85d6-781eb9ecf161@linaro.org>
Date: Tue, 27 May 2025 13:44:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/25] hw/arm/virt: Let virt support pci hotplug/unplug
 GED event
To: Igor Mammedov <imammedo@redhat.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, Jonathan.Cameron@huawei.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-23-eric.auger@redhat.com>
 <20250527175649.5d276bc8@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250527175649.5d276bc8@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi folks,

On 5/27/25 12:56, Igor Mammedov wrote:
> On Tue, 27 May 2025 09:40:24 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> Set up the IO registers used to communicate between QEMU
>> and ACPI.
> 
> 
> 
>> Move the create_pcie() call after the creation of the acpi
>> ged device since hotplug callbacks will soon be called on gpex
>> realize and will require the acpi pcihp state to be initialized.
>>
>> The hacky thing is the root bus has not yet been created on
>> acpi_pcihp_init() call so it is set later after the gpex realize.
> 
> can you elaborate on this, preferably with call expected call flows?

The way I'm understanding it is: because the GED and GPEX are created
in virt.c, so at the machine "level" (and so a machine hotplug handler is
used instead of a device hotplug handler, like it's done in PIIX4 and ICH9
controller in the x86 machines), and they need to be created in that
order because of dependecy of GPEX of GED, the flow is:

1) create_acpi_ged() -> calls acpi_pcihp_init(), which by its turn will inspect the root bus to generate the ACPI code
2) create_pcie() -> just in realize the root bus will be created

and the sequence has to be 1 -> 2, because GED will be used in the GPEX callbacks on hotplug.

So here we're following a different design from the current one in x86,
which handles the hotplug at the PCI controller "level".


Cheers,
Gustavo

>> How to fix this chicken & egg issue?
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - use ACPI_PCIHP_REGION_NAME
>> ---
>>   include/hw/arm/virt.h    |  1 +
>>   hw/arm/virt-acpi-build.c |  1 +
>>   hw/arm/virt.c            | 42 +++++++++++++++++++++++++++++++++++-----
>>   3 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index 1b2e2e1284..a4c4e3a67a 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -35,6 +35,7 @@
>>   #include "hw/boards.h"
>>   #include "hw/arm/boot.h"
>>   #include "hw/arm/bsa.h"
>> +#include "hw/acpi/pcihp.h"
>>   #include "hw/block/flash.h"
>>   #include "system/kvm.h"
>>   #include "hw/intc/arm_gicv3_common.h"
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 9d88ffc318..cd49f67d60 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -44,6 +44,7 @@
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "hw/acpi/tpm.h"
>>   #include "hw/acpi/hmat.h"
>> +#include "hw/acpi/pcihp.h"
>>   #include "hw/pci/pcie_host.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pci_bus.h"
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 4aa40c8e8b..cdcff0a984 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -682,6 +682,8 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>   {
>>       DeviceState *dev;
>>       MachineState *ms = MACHINE(vms);
>> +    SysBusDevice *sbdev;
>> +
>>       int irq = vms->irqmap[VIRT_ACPI_GED];
>>       uint32_t event = ACPI_GED_PWR_DOWN_EVT;
>>   
>> @@ -693,12 +695,28 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>>           event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
>>       }
>>   
>> +    if (vms->acpi_pcihp) {
>> +        event |= ACPI_GED_PCI_HOTPLUG_EVT;
>> +    }
>> +
>>       dev = qdev_new(TYPE_ACPI_GED);
>>       qdev_prop_set_uint32(dev, "ged-event", event);
>> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +    sbdev = SYS_BUS_DEVICE(dev);
>> +    sysbus_realize_and_unref(sbdev, &error_fatal);
>>   
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
>> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
>> +    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
>> +    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> 
> 
> Perhaps move out sbdev renaming into a separate patch, as it's not really related.
> 
>> +    if (vms->acpi_pcihp) {
>> +        AcpiGedState *acpi_ged_state = ACPI_GED(dev);
>> +        int i;
>> +
>> +        i = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
>> +                                 vms->memmap[VIRT_ACPI_PCIHP].base);
> 
> I don't like mix of old way (index based) above and new name based mapping,
> can we use the same, please?
> 
>> +        assert(i >= 0);
> g_assert(sysbus_mmio_map_name...) to get more meaning-full crash
> that is not compiled out.
> 
>> +        acpi_pcihp_init(OBJECT(dev), &acpi_ged_state->pcihp_state,
>> +                        vms->bus, sysbus_mmio_get_region(sbdev, i), 0);
> 
> hmm, looks broken..
>   region mapping must happen after acpi_pcihp_init().
> 
> if we after making sysbus_mmio_map() sane and easier to use
> (which is a bit on tangent to this series).
> We could feed sysbus owner device a memory map (ex: name based),
> and then use [pre_]plug handlers on sysbus to map children
> automatically.
> That will alleviate need to do all mapping manually in every board.
> (frankly speaking it deserves its own series, with tree wide cleanup).
> 
> As it is I'd use old index based approach like the rest.
> (unless you feel adventurous about sysbus refactoring)
> 
> 
>> +        acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge = true;
>> +    }
>>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
>>   
>>       return dev;
>> @@ -1758,6 +1776,13 @@ void virt_machine_done(Notifier *notifier, void *data)
>>       pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
>>                                          &error_abort);
> 
> 
>> +
>> +    if (vms->acpi_pcihp) {
>> +        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
>> +
>> +        acpi_pcihp_reset(&acpi_ged_state->pcihp_state);
>> +    }
>> +
>>       virt_acpi_setup(vms);
>>       virt_build_smbios(vms);
>>   }
>> @@ -2395,8 +2420,6 @@ static void machvirt_init(MachineState *machine)
>>   
>>       create_rtc(vms);
>>   
>> -    create_pcie(vms);
>> -
>>       if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>>           vms->acpi_pcihp &= !vmc->no_acpi_pcihp;
>>           vms->acpi_dev = create_acpi_ged(vms);
>> @@ -2405,6 +2428,15 @@ static void machvirt_init(MachineState *machine)
>>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>>       }
>>   
>> +    create_pcie(vms);
>> +
>> +    if (vms->acpi_dev) {
>> +        AcpiGedState *acpi_ged_state = ACPI_GED(vms->acpi_dev);
>> +
>> +        acpi_ged_state = ACPI_GED(vms->acpi_dev);
>> +        acpi_ged_state->pcihp_state.root = vms->bus;
>> +    }
>> +
>>       if (vms->secure && !vmc->no_secure_gpio) {
>>           create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
>>       }
> 
> I don't like pulling acpi_pcihp_init()/reset (and issues it causes) into board code,
> on x86 it's a part of host bridge device model.
> The same should apply to GED device.
> 
> The only thing board has to do is map regions into IO space like we do
> everywhere else.
> 
> with current code, may be add link<pci_bus> property to GED,
> and set it before GED realize in create_acpi_ged(),
> then just follow existing sysbus_mmio_map() pattern.
> 


