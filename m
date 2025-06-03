Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCCAC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMQEa-0007JF-He; Tue, 03 Jun 2025 07:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQEU-0007GD-K5
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:55:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMQEO-0000ZM-FN
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:55:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so60495425e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748951698; x=1749556498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qS1ed1eMIovnFpc6wYFIyUs34xxRKyDuRSSYIu06zpk=;
 b=WaqkjD18L748TpTB10uFwDci355hfVDb3Rm+xzW3SaHtBMgHaLW1Xx6kRSzPV6pS7H
 3ojGOA6N//6ixxvHP8Z4nfJ0VNptlqTjzik8bTnaRx5CjE8y288ghTCY+0+d+VKWILgu
 MdYQnVpIuHKpHyD3cqtb9XD+JtuFjNcPxHcxTkkAVrxruUuufA2AOu4AHl2d4X1mWMGT
 goonQ71HPLYAQ8bVe10fcptqj6J+RHXnBGiH/xyTrBc5VsNvNNSZk0Kt9WWSjMr394qh
 B3tU/W20N8npcvx56NQsSET+KzWLGGYVIDDHE/rh85XY6AI5lv3dU4irVsJJYMwkCajB
 TEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748951698; x=1749556498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qS1ed1eMIovnFpc6wYFIyUs34xxRKyDuRSSYIu06zpk=;
 b=Y4kT3eskkS+WusWJNDDay/t5n04oSHIIdaR6FLUZmqHzsXG/5no5ukz/JpJvAUFx/o
 JTkgMT/8+US2yGIbUSGTe+Jwv927OXvo4EAhc3s1Ky0+UJBkQDpxYizVL2Ou8EQmTAhR
 PbNCA3ExHAT+tZgOdiws05Co0x/4rQb2j9zM8URzbAXouCPwOODazanheLP8tB6LmOPk
 ZyxrbieNBSmkwFr7WvedGeToe1PR2fEHq8b8C3jVeJ/ZNqGnyaFXqakSTyKyjJMs1y4/
 qEWjs9GIYaH9GcZeCbMf7zxpgtU77YxDUeMg1QXJTDHKnIVRFZGre0lEkdZ2ttsU6BbQ
 8+oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXW8WUrCrd08Bj9YyQ7nJkjxbla/6NiUznY6mnGResN9GFf0fmIeZexTdiTXO0B+fw9mTCRBEKXpK@nongnu.org
X-Gm-Message-State: AOJu0Yy2sbqES+8ix/q6WmOffY17Yznaf748chv08+kyyKWcZUrekE/T
 zYvecDuij05Xxa1ibo7prhT9yo4h86hM2UjT4gZl+DYXly5Bz80bl9mj6Kb2yPUoADY=
X-Gm-Gg: ASbGncuTN9LqxXWDXevF6rXMLv3uC80zePcXZyySB+S6Zml6hub14YlAReMAhinY7/f
 W87tG3sRHT2eeYTFFlcq3tKKrewQWT7M1pMhqRpQOB6mMdIRm/witeQddzB+AKt6CezOGi09Hvj
 FuxNyaQRQ2+CJeg3mFTbF0IlxKtK9rmRvBjsvTdeSKkts0FmaRndUxy8Ju0xhxFMe+9IJQXz2ap
 ja8phwfu+EV434N7+qFz08diVAmLxG5rbpoFKzZVqDnQMbjOpBNtKAGRv+U3kbqlw9cUtXzJLrn
 Xk566pxEGQhfzv/NL4ho5un8HmroeF++rvXB6y1wEQALlBRaBy8k1RodFnc0+IP/unbPpjw2yBS
 5lS72W18vPeAFbys8WLrz3OY2
X-Google-Smtp-Source: AGHT+IFJFAI6EhVrzzeTTtlNtiZcPILo9cdDmDgPYcVxoziVoZD/GY0dqcUlG8QkozQ+UkKA1Y5M8A==
X-Received: by 2002:a05:600c:5251:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-451221a223emr90555925e9.25.1748951698584; 
 Tue, 03 Jun 2025 04:54:58 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450dc818f27sm141125475e9.18.2025.06.03.04.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:54:58 -0700 (PDT)
Message-ID: <bfd1359d-2a25-4c53-9eee-cec527197f8e@linaro.org>
Date: Tue, 3 Jun 2025 13:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] hw/pci-host/raven: Do not map regions in init method
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <1e85cddcd56f2431e349d21fcf6e539a663a64c3.1746374076.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1e85cddcd56f2431e349d21fcf6e539a663a64c3.1746374076.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 4/5/25 18:01, BALATON Zoltan wrote:
> Export memory regions as sysbus mmio regions and let the board code
> map them.
> 

Why? The mapping belong to the host bridge, not the board...

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 37 ++++++++++++-------------------------
>   hw/ppc/prep.c       | 11 +++++++++--
>   2 files changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 68d64e3a97..c9df3db401 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -49,8 +49,6 @@ struct PREPPCIState {
>       AddressSpace bm_as;
>   };
>   
> -#define PCI_IO_BASE_ADDR    0x80000000  /* Physical address on main bus */
> -
>   static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>   {
>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
> @@ -166,7 +164,7 @@ static void raven_change_gpio(void *opaque, int n, int level)
>       memory_region_set_enabled(&s->pci_discontiguous_io, !!level);
>   }
>   
> -static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
> +static void raven_pcihost_realize(DeviceState *d, Error **errp)
>   {
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
> @@ -176,7 +174,17 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> +    memory_region_init(&s->pci_io, o, "pci-io", 0x3f800000);
> +    memory_region_init_io(&s->pci_discontiguous_io, o,
> +                          &raven_io_ops, &s->pci_io,
> +                          "pci-discontiguous-io", 8 * MiB);
> +    memory_region_init(&s->pci_memory, o, "pci-memory", 0x3f000000);
> +
> +    sysbus_init_mmio(dev, &s->pci_io);
> +    sysbus_init_mmio(dev, &s->pci_discontiguous_io);
> +    sysbus_init_mmio(dev, &s->pci_memory);
>       sysbus_init_irq(dev, &s->irq);
> +
>       h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,
>                                      &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
>                                      TYPE_PCI_BUS);
> @@ -215,32 +223,12 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>   }
>   
> -static void raven_pcihost_initfn(Object *obj)
> -{
> -    PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
> -    MemoryRegion *address_space_mem = get_system_memory();
> -
> -    memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
> -    memory_region_init_io(&s->pci_discontiguous_io, obj,
> -                          &raven_io_ops, &s->pci_io,
> -                          "pci-discontiguous-io", 8 * MiB);
> -    memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
> -
> -    /* CPU address space */
> -    memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
> -                                &s->pci_io);
> -    memory_region_add_subregion_overlap(address_space_mem, PCI_IO_BASE_ADDR,
> -                                        &s->pci_discontiguous_io, 1);
> -    memory_region_set_enabled(&s->pci_discontiguous_io, false);
> -    memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> -}
> -
>   static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    dc->realize = raven_pcihost_realizefn;
> +    dc->realize = raven_pcihost_realize;
>       dc->fw_name = "pci";
>   }
>   
> @@ -274,7 +262,6 @@ static const TypeInfo raven_types[] = {
>           .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
>           .parent = TYPE_PCI_HOST_BRIDGE,
>           .instance_size = sizeof(PREPPCIState),
> -        .instance_init = raven_pcihost_initfn,
>           .class_init = raven_pcihost_class_init,
>       },
>       {
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index d3365414d2..23d0e1eeaa 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -53,8 +53,11 @@
>   
>   #define CFG_ADDR 0xf0000510
>   
> -#define KERNEL_LOAD_ADDR 0x01000000
> -#define INITRD_LOAD_ADDR 0x01800000
> +#define KERNEL_LOAD_ADDR  0x01000000
> +#define INITRD_LOAD_ADDR  0x01800000
> +
> +#define PCI_IO_BASE_ADDR  0x80000000
> +#define PCI_MEM_BASE_ADDR 0xc0000000
>   
>   #define BIOS_ADDR         0xfff00000
>   #define BIOS_SIZE         (1 * MiB)
> @@ -293,6 +296,10 @@ static void ibm_40p_init(MachineState *machine)
>       pcihost = SYS_BUS_DEVICE(dev);
>       object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
>       sysbus_realize_and_unref(pcihost, &error_fatal);
> +    sysbus_mmio_map(pcihost, 0, PCI_IO_BASE_ADDR);
> +    sysbus_mmio_map_overlap(pcihost, 1, PCI_IO_BASE_ADDR, 1);
> +    memory_region_set_enabled(sysbus_mmio_get_region(pcihost, 1), false);
> +    sysbus_mmio_map(pcihost, 2, PCI_MEM_BASE_ADDR);
>       pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
>       if (!pci_bus) {
>           error_report("could not create PCI host controller");


