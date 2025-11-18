Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D83CF2562
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 23:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLUyF-0005kl-19; Tue, 18 Nov 2025 18:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vLUyC-0005kV-AS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 18:18:44 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vLUy9-00065h-VM
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 18:18:44 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-657490df6f3so1353632eaf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763507920; x=1764112720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yXq1OOCjV4O4StIOrAKO6Pa4oVI3JQWDc619amsNK1Q=;
 b=VcQuYK3mBgIizEby8ikQj8YQ6zdC7J7i/8jeVL6C/KmCY93RMJKsARC3YyXSjFZ1Wp
 lbef1erjaYoJCjzanEj3SqKJiWXPdkiR2LJKc5mr7dGPm0Bo9hId6fHMqaUzdpWP84Ku
 UfoUf3xu7OsBNw89t/O/upe4pV+IcTAteVrtAAquaMjOAKYTokxSJpB8QIdAYh47QQ1g
 upbR4PJVLwP5qS/74hSnCVlQe48gzYwB4Nx1sDx2t+DY711PWwjzmauOBYbXJLesodhz
 FcxZd+kYssuk6ugsJ5UlWr/hM4Exij7bs0ADrhEf+y6rwtgp7dovTXcA32cFzrB1BI5T
 ZSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763507920; x=1764112720;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXq1OOCjV4O4StIOrAKO6Pa4oVI3JQWDc619amsNK1Q=;
 b=Kk/+x8U62k1js8rC/qsV75VgLIvHqEZih/cyrENkv/emgwcCN9tLCc64zsHCQW1WMQ
 wURN30XCAnuDX6BZ9m2iVzGYJC0s5yMuvXo4sjuQF3CmYJkyIk+atzeZc8xaeDa4Bdy+
 KH9pBJ/XxxUEIpQ9oX890fwEroQcN8uDySWqf/chpYim9mlR9SQhS0EbRknCCpWLlLoE
 A58osx03PtyxD2bgkazFQ9dHL5l+8soj8siO6vRnNQO79EFk18/JFVXWRqbStG9IM/OW
 /ADdeZHg6kPsDWO0NnaMuDy1qB6Q1dASsd1XwYP4za/gZFE9uU1MIXvFzgT+JjYDz9lC
 mg7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgeM54mGHK525o9K0jyxl5uxzEnJttbfrUMbhmF6PsJ7wMa/B746gC2I9+/UQB07JxE3ksksg262cV@nongnu.org
X-Gm-Message-State: AOJu0Yz0uGNNlRly/G3GN64sw2OPmlARLJgpZ8H+0M6G/T3DYo3JSaFh
 i8+l8lst4gQQIGHHzkHYGyJB9HNdwJZ9vTGPqHR7ePa5zupHrDxF4+rF0Zxy4HZcTN0=
X-Gm-Gg: ASbGncvPDT4HjW4eEz/yOwO2DYBt30kXbuC7KoX2dinHJqsnrLFl0n0dOV5GtSIfH9M
 Z7hlozMVmSMVreltCrFYv/J0QvUGBml0uULfIxt+WUi9Jkvxl9nXgmlYC9sOf92D9thCgSG7d7K
 pRyOELXrPgPCiYWLIwxwd+JuvJt2k+k/7eJ6M5exwOTY+jYPSdfMnfrMbwWpc8TaWy5lJZqvfN4
 yvXSoPQNCRfMHrlcwWc00IWzusCsKjiqkQ5KkY7dCoC1I80FDwuufOPus+QdcP9FQMoOCypF6NG
 xT+zsevzk8i/NdT28warc04aR4fZmyZDbfFcNIBfjd0xVMGBIs7QfErJGzbK8qfr5E/bocOgFi4
 8OwZ25R2VqY/i+aUaZF0HTaMUafQ4atyt9l7Mj5T/a0/Y/i1B5jMbFYjSgwsBraIAWyGworfv9Y
 oojKOcBLlJJiJ3qdFYXuv+PBOsP0NX1iuxFtHDeLm65Ch4ZQK8LFJMtlZj29FOcA23Gv22Ba+6c
 i0=
X-Google-Smtp-Source: AGHT+IFeKEMS9r6buX/vzjZ8/WtCmu6rnviXe73LWuppqQEtjVhNB8kDRNpL6FQom1yK9XRxyU6JDQ==
X-Received: by 2002:a05:6820:2d84:10b0:656:84a8:b691 with SMTP id
 006d021491bc7-65733cac1bdmr6132791eaf.3.1763507920082; 
 Tue, 18 Nov 2025 15:18:40 -0800 (PST)
Received: from ?IPV6:2804:7f0:b400:8262:2a66:6172:e55b:c94c?
 ([2804:7f0:b400:8262:2a66:6172:e55b:c94c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65751922d1csm2560146eaf.10.2025.11.18.15.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 15:18:39 -0800 (PST)
Message-ID: <8fd6caa2-c641-4901-9d1d-83282ae07c12@linaro.org>
Date: Tue, 18 Nov 2025 20:18:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] hw/misc/pvpanic: add PCI interface support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mihai Carabas <mihai.carabas@oracle.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: peter.maydell@linaro.org, yvugenfi@redhat.com, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <1611759570-3645-1-git-send-email-mihai.carabas@oracle.com>
 <1611759570-3645-3-git-send-email-mihai.carabas@oracle.com>
 <77d7afeb-3dbc-4fcf-976b-09fe01cf542e@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <77d7afeb-3dbc-4fcf-976b-09fe01cf542e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Phil,

On 11/18/25 11:16, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> (old patch merged as commit d097b3dcb62)
> 
> On 27/1/21 15:59, Mihai Carabas wrote:
>> Add PCI interface support for PVPANIC device. Create a new file pvpanic-pci.c
>> where the PCI specific routines reside and update the build system with the new
>> files and config structure.
>>
>> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
>> ---
>>   docs/specs/pci-ids.txt    |  1 +
>>   hw/misc/Kconfig           |  6 +++
>>   hw/misc/meson.build       |  1 +
>>   hw/misc/pvpanic-pci.c     | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/misc/pvpanic.h |  1 +
>>   include/hw/pci/pci.h      |  1 +
>>   6 files changed, 104 insertions(+)
>>   create mode 100644 hw/misc/pvpanic-pci.c
>>
>> diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
>> index abbdbca..5e407a6 100644
>> --- a/docs/specs/pci-ids.txt
>> +++ b/docs/specs/pci-ids.txt
>> @@ -64,6 +64,7 @@ PCI devices (other than virtio):
>>   1b36:000d  PCI xhci usb host adapter
>>   1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
>>   1b36:0010  PCIe NVMe device (-device nvme)
>> +1b36:0011  PCI PVPanic device (-device pvpanic-pci)
>>   All these devices are documented in docs/specs.
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 23bc978..19c216f 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -124,6 +124,12 @@ config IOTKIT_SYSINFO
>>   config PVPANIC_COMMON
>>       bool
>> +config PVPANIC_PCI
>> +    bool
>> +    default y if PCI_DEVICES
>> +    depends on PCI
>> +    select PVPANIC_COMMON
>> +
>>   config PVPANIC_ISA
>>       bool
>>       depends on ISA_BUS
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index edaaec2..6292839 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -100,6 +100,7 @@ softmmu_ss.add(when: 'CONFIG_ARMSSE_CPUID', if_true: files('armsse-cpuid.c'))
>>   softmmu_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
>>   softmmu_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
>> +softmmu_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
>>   softmmu_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
>>   softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_scu.c', 'aspeed_sdmc.c', 'aspeed_xdma.c'))
>>   softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-sysreg.c'))
>> diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
>> new file mode 100644
>> index 0000000..d629639
>> --- /dev/null
>> +++ b/hw/misc/pvpanic-pci.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * QEMU simulated PCI pvpanic device.
>> + *
>> + * Copyright (C) 2020 Oracle
>> + *
>> + * Authors:
>> + *     Mihai Carabas <mihai.carabas@oracle.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/module.h"
>> +#include "sysemu/runstate.h"
>> +
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "hw/qdev-properties.h"
>> +#include "migration/vmstate.h"
>> +#include "hw/misc/pvpanic.h"
>> +#include "qom/object.h"
>> +#include "hw/pci/pci.h"
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(PVPanicPCIState, PVPANIC_PCI_DEVICE)
>> +
>> +/*
>> + * PVPanicPCIState for PCI device
>> + */
>> +typedef struct PVPanicPCIState {
>> +    PCIDevice dev;
>> +    PVPanicState pvpanic;
>> +} PVPanicPCIState;
>> +
>> +static const VMStateDescription vmstate_pvpanic_pci = {
>> +    .name = "pvpanic-pci",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(dev, PVPanicPCIState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
>> +{
>> +    PVPanicPCIState *s = PVPANIC_PCI_DEVICE(dev);
>> +    PVPanicState *ps = &s->pvpanic;
>> +
>> +    pvpanic_setup_io(&s->pvpanic, DEVICE(s), 2);
> 
> Why registering 2-bytes of I/O when the underlying device is 1-byte
> wide? Is this to allow 16-bit I/O instructions?

TL;DR: I think that 2 should actually be 16 :)

First, IMO, pvpanic_setup_io() should be called pvpanic_setup_mmio() because
the registered memory region in question is of type PCI_BASE_ADDRESS_SPACE_MEMORY,
not of type PCI_BASE_ADDRESS_SPACE_IO, hence the BAR associated to
this memory region (ps->mr) will map a MMIO region, not an I/O region.

But I think I see why it looks confusing to me: QEMU puts both a Memory Space
and an I/O Space (PCI terms here) into pci_dev->io_regions[] (which is ok).
The former defines a MMIO region and the latter an I/O (x86 old-style) region.

I'm just saying that in case you were thinking of inb/outb/insw/outsw &
friends when you said "to allow 16-bit I/O instructions", which are mean
to work with PCI_BASE_ADDRESS_SPACE_IO, not with PCI_BASE_ADDRESS_SPACE_MEMORY
regions, where normal CPU load/store instructions (mov, ldr, str, ld, std, etc.)
should be used instead.

For such normal a CPU loads/stores the granularity would be, in general, 1 byte,
so CPU can load/store 1 byte or more on most PCI devices (in MMIO regions), hence:

       .impl = {
           .min_access_size = 1,
           .max_access_size = 1,
       },


looks correct to me.

That said, I understand that pvpanic_setup_io is defining a 2 bytes
PCI_BASE_ADDRESS_SPACE_MEMORY (Memory Space) and the minimum size of this
region should actually be 16 bytes, not 2 bytes.

If you take a look at the PCI spec 3.0, in section 6.2.5.1, "Address Maps",
it says, about "Base Address Register for Memory":

"A 32-bit register can be implemented to support a single memory size that
is a power of 2 from 16 bytes to 2 GB."

So the minimum size of a Memory Space is 16 bytes, because bits from 0 to 3
in the BAR are not used for address decoding purposes (they define the type
of the space, number of bits in the address space, etc.).

Also, in pci_register_bar() the size is used to set the wmask for the
BAR register:

wmask = ~(size - 1);

and with size = 2, if my math is right, gives 0xfffffffe, which is invalid
(it should be 0xfffffff0 for the minimum size: bits from 0 to 3 should
be zeroed (falgs) and bit 4 and upwards should be one. The first bit set as
1 starting from the least significant bit determines the size of the MMIO region,
and in 0xfffffff0 bit 4 is the first one that is 1, which kind tells us the
minimum size should really be 16 bytes for a MMIO region).

So that's my 2 cents on it :)


Cheers,
Gustavo

>> +
>> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &ps->mr);
>> +}
>> +
>> +static Property pvpanic_pci_properties[] = {
>> +    DEFINE_PROP_UINT8("events", PVPanicPCIState, pvpanic.events, PVPANIC_PANICKED | PVPANIC_CRASHLOADED),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pvpanic_pci_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
>> +
>> +    device_class_set_props(dc, pvpanic_pci_properties);
>> +
>> +    pc->realize = pvpanic_pci_realizefn;
>> +    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
>> +    pc->device_id = PCI_DEVICE_ID_REDHAT_PVPANIC;
>> +    pc->revision = 1;
>> +    pc->class_id = PCI_CLASS_SYSTEM_OTHER;
>> +    dc->vmsd = &vmstate_pvpanic_pci;
>> +
>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> +}
>> +
>> +static TypeInfo pvpanic_pci_info = {
>> +    .name          = TYPE_PVPANIC_PCI_DEVICE,
>> +    .parent        = TYPE_PCI_DEVICE,
>> +    .instance_size = sizeof(PVPanicPCIState),
>> +    .class_init    = pvpanic_pci_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pvpanic_register_types(void)
>> +{
>> +    type_register_static(&pvpanic_pci_info);
>> +}
>> +
>> +type_init(pvpanic_register_types);
>> diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
>> index abc9dde..ca3c5bb 100644
>> --- a/include/hw/misc/pvpanic.h
>> +++ b/include/hw/misc/pvpanic.h
>> @@ -18,6 +18,7 @@
>>   #include "qom/object.h"
>>   #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
>> +#define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
>>   #define PVPANIC_IOPORT_PROP "ioport"
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index 259f9c9..66db084 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -107,6 +107,7 @@ extern bool pci_available;
>>   #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
>>   #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
>>   #define PCI_DEVICE_ID_REDHAT_NVME        0x0010
>> +#define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
>>   #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>>   #define FMT_PCIBUS                      PRIx64
> 
> 


