Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C395D43369
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 06:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTwSn-0003u6-K0; Fri, 12 Dec 2025 01:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTwSU-0003sJ-RM
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:17:03 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTwSS-0000j1-2g
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:16:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso402194f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 22:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765520209; x=1766125009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYwJNV8tIACMXVsMEi1PaBSq5ICUFqY3BKSFbm+GhYU=;
 b=F7I3+g76ldRYhZRB+ut8jhUndX60JSFInRDD1Zhf7zaf7rAKjm0iUs2RTRMCdJAzni
 qidyM6LgivbFPYscH8rTnrAUH6iF0xd1QP+Q5mLFuTs5DtNia8afNp2wNHfzlAhBfxMw
 CJDqGMXydtk0KpDnHxH1zAqV35Cug08FdUZTFc9IlAEnr3gYp0PitIr/Hj4QyV1D1+N3
 +M6B/J+r8SmbzE1gKN2s8IfISAdx2gdo4K6Qjc+JTU8l9Oj/iff6KRmXhca5Xx6Bo3ik
 hvKMfQ29XaiaaKH4OcVu57Dab6lMI2C5KgdwrydKYInYEyxdGidJCIuaQaq0piZVA4HD
 ckxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765520209; x=1766125009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYwJNV8tIACMXVsMEi1PaBSq5ICUFqY3BKSFbm+GhYU=;
 b=HlnlbFYA6pXbP6Zyggqf0FTnGUH8BidQ1IEjlojeMsfpucAeY+/d0UgIoc27DOErmX
 YR8ppDxrZpPdEiGmqmJEImlqMD2ncO7NfQJTmz7DEs29YxcPac/Dg2zly/F6I5iR2M8c
 tN+vVQAlVmH+aKxErrh9X5/Bdo4xMk2//Kn9dNkG9C0wzyZzWPYO4gO10642ihKscsZ5
 mfri+p0UVmDMoOdlLmv6NcwEsJmbHdbtlDvLfajqMk9jHI6ajiYIZw5ofAb+tYB1DPI+
 C/x5++Hn420sOJjRSZV3Mog7H9k3sGQEgP0FvteWOos1lttWZgbSsACDpN3I7/vMm01Z
 w5Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1LKehfeRs3r7xb1OJuNZEGbY1Dq0zNeXJuhe8FoEAzsjcpLNH2r0l1gUALQRs8oGFPLuiDxsrKBgP@nongnu.org
X-Gm-Message-State: AOJu0Yzdj05LfWthLpRv32WQAGDmAOvc/16lN3YuXYqI41zsaDvQhz2Q
 KwBgMyWHPkjZ9ZB3lMeQhUo65C0geFZUDZOH3ZfSPTVskaE3F+6RyKzhN+hrPT85/4Y=
X-Gm-Gg: AY/fxX4PsZnI9VHpI9xeXSgIvVJwYE8D7fkp5q05wXrWknOsAL/3U9U2jpKzbRCr012
 cevp1904PxiFX/OaUZBKR/LFD6c7rifZjJL9EaBPFBPfoSXiwu3W+wJP0xE9gJAAyqd1gGlt1Dr
 W1ZEadtQjtnUxvdBOIUxSRsLM9bfZPVLpWBMeWzX/zHbbUTSzpsoqiEQT1QNgsYo+Gd3n3fegGw
 /DsbRGJdRD2oKLEJdBtFR4QafFKL1v62xlQEMeXnENTVnFdy/qPMVlmlZQyRhc6LgEm5czGPhfs
 UCQnH1fxXZMAG7hFhk2b9ObyiwKBbid8INxfS6EfBjFHRj3Ub0TM4cf8z4tLuvLIMEAt+R9OmmO
 McJqTgpoBthgArCQGEDIi9WbRPR3OZKGOtwFPV0dIUtqpzI9CElYL80a1FxQwHdS1iFN7klNdbZ
 DQO6TXrnD04gkQwQ2dodCzlQmqqwfLPreJREFvnnOmq8yu58fQMn3HTg==
X-Google-Smtp-Source: AGHT+IF8833O4uEPjxPUCvfTgZ6G4VtEMSxeE5/T1NlQexRjTxduAqfgcjvtrr/9/xKBxEl+BrJjPg==
X-Received: by 2002:a05:6000:268a:b0:429:b9bc:e826 with SMTP id
 ffacd0b85a97d-42fb48e59c9mr870389f8f.53.1765520208742; 
 Thu, 11 Dec 2025 22:16:48 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85d1esm9790685f8f.26.2025.12.11.22.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 22:16:48 -0800 (PST)
Message-ID: <87a479e9-21eb-4c4c-8e64-32744eea1f96@linaro.org>
Date: Fri, 12 Dec 2025 07:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmu: add memory regions as property for an SMMU
 instance
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 tangtao1634@phytium.com.cn, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>
References: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251211221715.2206662-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi Pierrick,

On 11/12/25 23:17, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.

Sorry yesterday it was late for me and I forgot to post the similar
patch :/

> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 24 ++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 51 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index a6bdb67a983..0f08ae080c9 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -227,6 +227,10 @@ struct SMMUState {
>       uint8_t bus_num;
>       PCIBus *primary_bus;
>       bool smmu_per_bus; /* SMMU is specific to the primary_bus */
> +    MemoryRegion *memory;
> +    AddressSpace as_memory;
> +    MemoryRegion *secure_memory;
> +    AddressSpace as_secure_memory;

Has SMMU concept of "secure memory"? My understanding is just a
different memory to access GPT, so I'd name it "gpt_memory".

>   };
>   
>   struct SMMUBaseClass {
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 45d2e3e946d..840b1a216f4 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -616,7 +616,9 @@ static void create_xhci(const SBSAMachineState *sms)
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
>   }
>   
> -static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
> +static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
>       int irq =  sbsa_ref_irqmap[SBSA_SMMU];
> @@ -628,6 +630,10 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -636,7 +642,9 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>       }
>   }
>   
> -static void create_pcie(SBSAMachineState *sms)
> +static void create_pcie(SBSAMachineState *sms,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
>       hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
> @@ -692,7 +700,7 @@ static void create_pcie(SBSAMachineState *sms)
>   
>       pci_create_simple(pci->bus, -1, "bochs-display");
>   
> -    create_smmu(sms, pci->bus);
> +    create_smmu(sms, pci->bus, sysmem, secure_sysmem);

As a preliminary cleanup create_pcie() returns the PCI bus, so the
machine_init() can call create_smmu() itself. I'll post later.

>   }
>   
>   static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> @@ -831,7 +839,7 @@ static void sbsa_ref_init(MachineState *machine)
>   
>       create_xhci(sms);
>   
> -    create_pcie(sms);
> +    create_pcie(sms, sysmem, secure_sysmem);
>   
>       create_secure_ec(secure_sysmem);
>   
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 66367adc2a4..5fbfe825fd0 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -1171,6 +1171,12 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    g_assert(s->memory);
> +    address_space_init(&s->as_memory, s->memory, "memory");
> +    if (s->secure_memory) {
> +        address_space_init(&s->as_secure_memory, s->secure_memory, "secure-memory");
> +    }

Allocating AddressSpaces on the heap:

        else {
            s->as_secure_memory = s->as_memory;
        }

>       /*
>        * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
>        * root complexes to be associated with SMMU.
> @@ -1235,10 +1241,28 @@ static void smmu_base_class_init(ObjectClass *klass, const void *data)
>       rc->phases.exit = smmu_base_reset_exit;
>   }
>   
> +static void smmu_base_instance_init(Object *obj)
> +{
> +    SMMUState *s = ARM_SMMU(obj);
> +
> +    object_property_add_link(obj, "memory",
> +                             TYPE_MEMORY_REGION,
> +                             (Object **)&s->memory,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG);
> +
> +    object_property_add_link(obj, "secure-memory",
> +                             TYPE_MEMORY_REGION,
> +                             (Object **)&s->secure_memory,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG);
> +}
> +
>   static const TypeInfo smmu_base_info = {
>       .name          = TYPE_ARM_SMMU,
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(SMMUState),
> +    .instance_init = smmu_base_instance_init,
>       .class_data    = NULL,
>       .class_size    = sizeof(SMMUBaseClass),
>       .class_init    = smmu_base_class_init,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5d205eff3a1..d446c3349e9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1514,8 +1514,9 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms,
>                              0x0, vms->iommu_phandle, 0x0, 0x10000);
>   }
>   
> -static void create_smmu(const VirtMachineState *vms,
> -                        PCIBus *bus)
> +static void create_smmu(const VirtMachineState *vms, PCIBus *bus,
> +                        MemoryRegion *sysmem,
> +                        MemoryRegion *secure_sysmem)
>   {
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>       int irq =  vms->irqmap[VIRT_SMMU];
> @@ -1549,6 +1550,10 @@ static void create_smmu(const VirtMachineState *vms,
>       object_property_set_str(OBJECT(dev), "stage", stage, &error_fatal);
>       object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
>                                &error_abort);
> +    object_property_set_link(OBJECT(dev), "memory", OBJECT(sysmem),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
> +                             &error_abort);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>       for (i = 0; i < NUM_SMMU_IRQS; i++) {
> @@ -1587,7 +1592,8 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>       }
>   }
>   
> -static void create_pcie(VirtMachineState *vms)
> +static void create_pcie(VirtMachineState *vms,
> +                        MemoryRegion *sysmem, MemoryRegion *secure_sysmem)
>   {
>       hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
>       hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
> @@ -1706,7 +1712,7 @@ static void create_pcie(VirtMachineState *vms)
>   
>           switch (vms->iommu) {
>           case VIRT_IOMMU_SMMUV3:
> -            create_smmu(vms, vms->bus);
> +            create_smmu(vms, vms->bus, sysmem, secure_sysmem);
>               if (!vms->default_bus_bypass_iommu) {
>                   qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
>                                          0x0, vms->iommu_phandle, 0x0, 0x10000);
> @@ -2520,7 +2526,7 @@ static void machvirt_init(MachineState *machine)
>   
>       create_rtc(vms);
>   
> -    create_pcie(vms);
> +    create_pcie(vms, sysmem, secure_sysmem);
>       create_cxl_host_reg_region(vms);
>   
>       if (aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {


