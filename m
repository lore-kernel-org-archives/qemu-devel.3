Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3586ACAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXkj-0002eo-IQ; Fri, 19 Sep 2025 05:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXkZ-0002b4-Ub
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzXkR-0003Wl-Tt
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758275384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Kj3CDlJWv+ULGO9qpclBJ6W3ZkNIDp9SSzAtkDx9LfM=;
 b=gb4iW6L9Pw309qwDw9x/44HGBAR204MdZXOP7HSq51sZ48e634Cu2Lc7rxz6RYaC/w+JnA
 WIdmk5JDKuoE8BvM717hjXbZHnq9KkfZ1pm278+lKXLp6LiuaX29JRp8PgWtI1M37q/6+b
 Emyw3ULnUXQeYCrVp/SHKi5UqVyJSds=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-yktIvE_uN_ukJoflT9X25w-1; Fri, 19 Sep 2025 05:49:42 -0400
X-MC-Unique: yktIvE_uN_ukJoflT9X25w-1
X-Mimecast-MFC-AGG-ID: yktIvE_uN_ukJoflT9X25w_1758275381
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45dd9a66cfbso15281375e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758275381; x=1758880181;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kj3CDlJWv+ULGO9qpclBJ6W3ZkNIDp9SSzAtkDx9LfM=;
 b=OBqAgoClNtB8qJWl3IlSbesgQqHnLujf9ys+VBp4zODeRlWodndT6HGILPfLr02bwh
 LCNTkt57iZeGDqNrmvNLJVLQGNH/2DL0uf67d9AHeLNMepe7uxiufP9Uuptx1SNhAcbe
 DBO2qdjfcXxo1seFQTOdPeswQAjrrXutNMF1euBgPmDUCMYfD0Dtjd1uwE07nIS2mIUz
 By3zYkkCUv9mP4JJUw+WAGvnKNctmzAFjjTeDDJwxou2tqYhFvB6q/bCjhTCQgrIn2af
 vzv+HSSLCLeTwM9z+KqU36fL74Of1ZGxgLrh9lPRl/MWy0gkgxxqNh4Jxc8O/1pySUfU
 ISKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx8BzvEcoYvktWGcpoge4mFEbD7EElMKszNtfiMHUWm8JfJRc8oVJ9nVP/vcsocf7G/FYboZCChD/M@nongnu.org
X-Gm-Message-State: AOJu0YyheOzjHTdiDgiWWoqOXjftePZbYFls6qQN5gZh+IXDQEqU9riz
 aEx/iFQqFUKGpWBXpbAYY5FtrEnV8DITBK9kkDF62gh4ZUbFx45Gsys4CUTU6G637jnWXvwNKQp
 W89YV9p9vuP6IBRybm6a0uGoNZSQn0w8gEpoF8o5PIX0icjgIJ6+p+n+S
X-Gm-Gg: ASbGncv/ezRRqX3LsJU2oNYECJaBnq9PVaX1aMzIV6LcXxgxU+zFjpbM5j6l+MV/uqC
 f0H6KP+EOZrOAiyF2/T1vmnOCaX2Nh/T01aSxqxetzBJK5GyF2Vj7XYcpx1KG0HIxPFlB7b4q+v
 TwE205On4Q6mKCsDGFKXWOvqgSrzjd9m6ekOorfdFZPQ5qrlWSnrxd1n7jfYH4KSvJRrm7eZvYL
 0UHCBBeMIrn7teRBdoyZLQSy4W3DX0q/T/bwbz+HjEmcUnjqP4vxim9Bar19S/l8FdwoDWOHJyZ
 mocCPIlytzTS7RONtXseOU0w2MgA7dy5g9HR+BXhkMHonRBtXhh+UXGYruHeq+LTFjH4EMtRR+z
 S8x0=
X-Received: by 2002:a05:600c:6288:b0:45f:2843:e76b with SMTP id
 5b1f17b1804b1-467ec36a36cmr19439445e9.2.1758275381463; 
 Fri, 19 Sep 2025 02:49:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmCdi9lWjGlTzWv+uZZ2QSU13I4J0CDdwOc5N2NI3brMhnE6JuYFgQtSESAOoe44W2hOH8Sg==
X-Received: by 2002:a05:600c:6288:b0:45f:2843:e76b with SMTP id
 5b1f17b1804b1-467ec36a36cmr19439095e9.2.1758275380953; 
 Fri, 19 Sep 2025 02:49:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f4f9f4e4sm89230795e9.13.2025.09.19.02.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:49:40 -0700 (PDT)
Message-ID: <2b844152-7db6-4706-ab1d-4d8176c67985@redhat.com>
Date: Fri, 19 Sep 2025 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v5 12/14] hw/arm/aspeed_ast27x0: Introduce 3 PCIe
 RCs for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250919093017.338309-1-jamin_lin@aspeedtech.com>
 <20250919093017.338309-13-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919093017.338309-13-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
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

On 9/19/25 11:30, Jamin Lin wrote:
> Add PCIe Root Complex support to the AST2700 SoC model.
> 
> The AST2700 A1 silicon revision provides three PCIe Root Complexes:
> 
> PCIe0 with its PHY at 0x12C15000, config (H2X) block at 0x120E0000,
> MMIO window at 0x60000000, and GIC IRQ 56.
> 
> PCIe1 with its PHY at 0x12C15800, config (H2X) block at 0x120F0000,
> MMIO window at 0x80000000, and GIC IRQ 57.
> 
> PCIe2 with its PHY at 0x14C1C000, config (H2X) block at 0x140D0000,
> MMIO window at 0xA0000000, and IRQ routed through INTC4 bit 31
> mapped to GIC IRQ 196.
> 
> Each RC instantiates a PHY device, a PCIe config (H2X) bridge, and an MMIO
> alias region. The per-RC MMIO alias size is 0x20000000. The AST2700 A0
> silicon revision does not support PCIe Root Complexes, so pcie_num is set
> to 0 in that variant.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h |  1 +
>   hw/arm/aspeed_ast27x0.c     | 74 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index a0cf433775..aaf518d179 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -186,6 +186,7 @@ struct AspeedSoCClass {
>       uint32_t silicon_rev;
>       uint64_t sram_size;
>       uint64_t secsram_size;
> +    int pcie_num;
>       int spis_num;
>       int ehcis_num;
>       int wdts_num;
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 6aa3841b69..853339119f 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -38,6 +38,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_EHCI2]     =  0x12063000,
>       [ASPEED_DEV_HACE]      =  0x12070000,
>       [ASPEED_DEV_EMMC]      =  0x12090000,
> +    [ASPEED_DEV_PCIE0]     =  0x120E0000,
> +    [ASPEED_DEV_PCIE1]     =  0x120F0000,
>       [ASPEED_DEV_INTC]      =  0x12100000,
>       [ASPEED_GIC_DIST]      =  0x12200000,
>       [ASPEED_GIC_REDIST]    =  0x12280000,
> @@ -45,6 +47,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_SCU]       =  0x12C02000,
>       [ASPEED_DEV_RTC]       =  0x12C0F000,
>       [ASPEED_DEV_TIMER1]    =  0x12C10000,
> +    [ASPEED_DEV_PCIE_PHY0] =  0x12C15000,
> +    [ASPEED_DEV_PCIE_PHY1] =  0x12C15800,
>       [ASPEED_DEV_SLI]       =  0x12C17000,
>       [ASPEED_DEV_UART4]     =  0x12C1A000,
>       [ASPEED_DEV_IOMEM1]    =  0x14000000,
> @@ -59,6 +63,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_ETH2]      =  0x14060000,
>       [ASPEED_DEV_ETH3]      =  0x14070000,
>       [ASPEED_DEV_SDHCI]     =  0x14080000,
> +    [ASPEED_DEV_PCIE2]     =  0x140D0000,
>       [ASPEED_DEV_EHCI3]     =  0x14121000,
>       [ASPEED_DEV_EHCI4]     =  0x14123000,
>       [ASPEED_DEV_ADC]       =  0x14C00000,
> @@ -66,6 +71,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_GPIO]      =  0x14C0B000,
>       [ASPEED_DEV_I2C]       =  0x14C0F000,
>       [ASPEED_DEV_INTCIO]    =  0x14C18000,
> +    [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
>       [ASPEED_DEV_SLIIO]     =  0x14C1E000,
>       [ASPEED_DEV_VUART]     =  0x14C30000,
>       [ASPEED_DEV_UART0]     =  0x14C33000,
> @@ -81,6 +87,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_UART11]    =  0x14C33A00,
>       [ASPEED_DEV_UART12]    =  0x14C33B00,
>       [ASPEED_DEV_WDT]       =  0x14C37000,
> +    [ASPEED_DEV_PCIE_MMIO0] = 0x60000000,
> +    [ASPEED_DEV_PCIE_MMIO1] = 0x80000000,
> +    [ASPEED_DEV_PCIE_MMIO2] = 0xA0000000,
>       [ASPEED_DEV_SPI_BOOT]  =  0x100000000,
>       [ASPEED_DEV_LTPI]      =  0x300000000,
>       [ASPEED_DEV_SDRAM]     =  0x400000000,
> @@ -156,6 +165,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_DP]        = 28,
>       [ASPEED_DEV_EHCI1]     = 33,
>       [ASPEED_DEV_EHCI2]     = 37,
> +    [ASPEED_DEV_PCIE0]     = 56,
> +    [ASPEED_DEV_PCIE1]     = 57,
>       [ASPEED_DEV_LPC]       = 192,
>       [ASPEED_DEV_IBT]       = 192,
>       [ASPEED_DEV_KCS]       = 192,
> @@ -166,6 +177,7 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_WDT]       = 195,
>       [ASPEED_DEV_PWM]       = 195,
>       [ASPEED_DEV_I3C]       = 195,
> +    [ASPEED_DEV_PCIE2]     = 196,
>       [ASPEED_DEV_UART0]     = 196,
>       [ASPEED_DEV_UART1]     = 196,
>       [ASPEED_DEV_UART2]     = 196,
> @@ -233,6 +245,7 @@ static const int ast2700_gic132_gic196_intcmap[] = {
>       [ASPEED_DEV_UART12]    = 18,
>       [ASPEED_DEV_EHCI3]     = 28,
>       [ASPEED_DEV_EHCI4]     = 29,
> +    [ASPEED_DEV_PCIE2]     = 31,
>   };
>   
>   /* GICINT 133 */
> @@ -519,6 +532,17 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
>       object_initialize_child(obj, "hace", &s->hace, typename);
> +
> +    for (i = 0; i < sc->pcie_num; i++) {
> +        snprintf(typename, sizeof(typename), "aspeed.pcie-phy-%s", socname);
> +        object_initialize_child(obj, "pcie-phy[*]", &s->pcie_phy[i], typename);
> +        object_property_set_int(OBJECT(&s->pcie_phy[i]), "id", i, &error_abort);
> +
> +        snprintf(typename, sizeof(typename), "aspeed.pcie-cfg-%s", socname);
> +        object_initialize_child(obj, "pcie-cfg[*]", &s->pcie[i], typename);
> +        object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abort);
> +    }
> +
>       object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                               TYPE_UNIMPLEMENTED_DEVICE);
>       object_initialize_child(obj, "ltpi", &s->ltpi,
> @@ -610,6 +634,49 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
>       return true;
>   }
>   
> +static bool aspeed_soc_ast2700_pcie_realize(DeviceState *dev, Error **errp)
> +{
> +    AspeedSoCState *s = ASPEED_SOC(dev);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    MemoryRegion *mmio_mr = NULL;
> +    char name[64];
> +    qemu_irq irq;
> +    int i;
> +
> +    for (i = 0; i < sc->pcie_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[i]), errp)) {
> +            return false;
> +        }
> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[i]), 0,
> +                        sc->memmap[ASPEED_DEV_PCIE_PHY0 + i]);
> +
> +        object_property_set_int(OBJECT(&s->pcie[i]), "dram-base",
> +                                sc->memmap[ASPEED_DEV_SDRAM],
> +                                &error_abort);
> +        object_property_set_link(OBJECT(&s->pcie[i]), "dram",
> +                                 OBJECT(s->dram_mr), &error_abort);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[i]), errp)) {
> +            return false;
> +        }
> +        aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[i]), 0,
> +                        sc->memmap[ASPEED_DEV_PCIE0 + i]);
> +        irq = aspeed_soc_get_irq(s, ASPEED_DEV_PCIE0 + i);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[i].rc), 0, irq);
> +
> +        mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[i].rc), 1);
> +        snprintf(name, sizeof(name), "aspeed.pcie-mmio.%d", i);
> +        memory_region_init_alias(&s->pcie_mmio_alias[i], OBJECT(&s->pcie[i].rc),
> +                                 name, mmio_mr,
> +                                 sc->memmap[ASPEED_DEV_PCIE_MMIO0 + i],
> +                                 0x20000000);
> +        memory_region_add_subregion(s->memory,
> +                                    sc->memmap[ASPEED_DEV_PCIE_MMIO0 + i],
> +                                    &s->pcie_mmio_alias[i]);
> +    }
> +
> +    return true;
> +}
> +
>   static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
> @@ -936,6 +1003,11 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
>   
> +    /* PCIe Root Complex (RC) */
> +    if (!aspeed_soc_ast2700_pcie_realize(dev, errp)) {
> +        return;
> +    }
> +
>       aspeed_mmio_map_unimplemented(s, SYS_BUS_DEVICE(&s->dpmcu),
>                                     "aspeed.dpmcu",
>                                     sc->memmap[ASPEED_DEV_DPMCU],
> @@ -974,6 +1046,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->silicon_rev  = AST2700_A0_SILICON_REV;
>       sc->sram_size    = 0x20000;
> +    sc->pcie_num     = 0;
>       sc->spis_num     = 3;
>       sc->ehcis_num    = 2;
>       sc->wdts_num     = 8;
> @@ -1002,6 +1075,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->silicon_rev  = AST2700_A1_SILICON_REV;
>       sc->sram_size    = 0x20000;
> +    sc->pcie_num     = 3;
>       sc->spis_num     = 3;
>       sc->ehcis_num    = 4;
>       sc->wdts_num     = 8;


