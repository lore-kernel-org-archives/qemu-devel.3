Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E43CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzW7z-00051K-4K; Fri, 19 Sep 2025 04:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7x-0004zY-Nj
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uzW7v-0006y2-GW
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 04:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758269154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=22Rwj6pH8qbOgqPnxbP5er9ISnFTjMBIrJnh6Ys8sc0=;
 b=IBNQ3lvBNWowjZ8/DJdE5UXoeHtT5iw09tJxmTE2fnrWBKl9Yl1Er06WGiYjM4HpUxfCuT
 cTrwiCwe9656NU8x0mub2qORhfeiPhIeJuXvhgF3/KfLRRI2icdzLKs91QgL1bqvZckkCY
 yqqQdBnf6e9y2Yk+vTckyH1t6JMhAco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-q-pcHAV2PZWtnjsF_6kPuQ-1; Fri, 19 Sep 2025 04:05:52 -0400
X-MC-Unique: q-pcHAV2PZWtnjsF_6kPuQ-1
X-Mimecast-MFC-AGG-ID: q-pcHAV2PZWtnjsF_6kPuQ_1758269151
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45cb612d362so9620645e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 01:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758269151; x=1758873951;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22Rwj6pH8qbOgqPnxbP5er9ISnFTjMBIrJnh6Ys8sc0=;
 b=lL+WjJ4ntptVwk0LCp2Qvj8q3+7i22sDDVRDoyRfEDwn9woqPWBfSZu9BuaMOveyY3
 6yaPhHOlv9Gd5vcwJFP46NWHkrzH59PpwoLorwjNVZgsGJHAnKToJF2VAKU3S6l4zeb2
 1MDG045NOUZdHYa2s7x1gpaD+EAXpG/R88hpc5uQABwSwjQjXmqZDVNQJZJW3eWbnx7+
 FDmXOzBy2mEJLlLxWbes04Y5NZH7OxetRJOc4P4IaqSTJcI+NdHwOAngy7hDKoCERIQT
 Ogri/56zCB/kwsTTp5TYrkxSrNF3D9BOzr+UmDXiVAl3ZF7OQfqjyx/GKNgRJ4YNGPVl
 KV7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6KCpsuwlljeafT1ytQk27PTo4upwNNYeeza4YK2brSaI0QlxE+r1HYGBigLAv3dZbDNvbSX1S/3s3@nongnu.org
X-Gm-Message-State: AOJu0YzmWAX8gYXNX5AP3s2fn+2EX1omice17lZVALHkTzuI+1Onpxib
 bX5/jEML9Ex4fStC9W4AgO67CiOzn4ybcc00uan3llzFXkiJvqfJMiXL4mNB9+I2yvWVg3ZhAhH
 8v6qpzDgPSp7xELvL6oXMf95ofDiMLtsf74WmF4ajEEjopm0plzlTIcYS
X-Gm-Gg: ASbGncsbvmm0JuC98RejQQnrQeAa9jIjXspt3iTJ5l3Fsszfzp1Ae+vcSf0KWbdZ/m7
 JXRE1cOpBzPgdrIxdIwi5bpDtsQK2TzxZXO1sFgLROSpFhGkYB1NXI08oAZ9MmbvRj7OngAUw9u
 9HqOFRTgZs+RGuG6EXp+ZsfuVNNTGYCFqRacBtAUAZKTl25hbDuK/cgJMcWM4JENYi2DJzqVcZH
 2jxQ0jvG/k4Tb6stKjIY2+7yAp7VJJPX8R9kENe9j+2Ta5mxjwYcWy9OwjSUpyKNUYW2hEod3BH
 Ioa5HGlZSszOUTsv7j03ypROBiPWUEIW2cSbRTAWjAis/uahubIdJonf7yXtBTzfpJDtUvSNv9T
 gKhw=
X-Received: by 2002:a05:600c:1f8e:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-467ead675eemr15599885e9.2.1758269151019; 
 Fri, 19 Sep 2025 01:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkIxAqHduSISasl24KmhUIDtMO+cR7hSpmCeodxpkvH5G0LiaDXvvQUEn4pMXRWNJRWuxAqg==
X-Received: by 2002:a05:600c:1f8e:b0:45b:8a0e:cda9 with SMTP id
 5b1f17b1804b1-467ead675eemr15599615e9.2.1758269150567; 
 Fri, 19 Sep 2025 01:05:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7284sm6790274f8f.33.2025.09.19.01.05.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 01:05:50 -0700 (PDT)
Message-ID: <bc2493e8-0e83-43a9-82de-bf85e5576d7c@redhat.com>
Date: Fri, 19 Sep 2025 10:05:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v4 08/14] hw/arm/aspeed_ast2600: Add PCIe RC
 support (RC_H only)
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
References: <20250919032431.3316764-1-jamin_lin@aspeedtech.com>
 <20250919032431.3316764-9-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250919032431.3316764-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/19/25 05:24, Jamin Lin wrote:
> Wire up the PCIe Root Complex in the AST2600 SoC model.
> 
> According to the AST2600 firmware driver, only the RC_H controller is
> supported. RC_H uses PCIe PHY1 at 0x1e6ed200 and the PCIe config (H2X)
> register block at 0x1e770000. The RC_H MMIO window is mapped at
> 0x70000000–0x80000000. RC_L is not modeled. The RC_H interrupt is
> wired to IRQ 168. Only RC_H is realized and connected to the SoC
> interrupt controller.
> 
> The SoC integration initializes PCIe PHY1, instantiates a single RC
> instance, wires its MMIO regions, and connects its interrupt. An alias
> region is added to map the RC MMIO space into the guest physical address
> space.
> 
> This provides enough functionality for firmware and guest drivers to
> discover and use the AST2600 RC_H Root Complex while leaving RC_L
> unimplemented.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/arm/aspeed_soc.h |  1 +
>   hw/arm/aspeed_ast2600.c     | 74 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 79fe353f83..a0cf433775 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -62,6 +62,7 @@ struct AspeedSoCState {
>       MemoryRegion spi_boot_container;
>       MemoryRegion spi_boot;
>       MemoryRegion vbootrom;
> +    MemoryRegion pcie_mmio_alias[ASPEED_PCIE_NUM];
>       AddressSpace dram_as;
>       AspeedRtcState rtc;
>       AspeedTimerCtrlState timerctrl;
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index d12707f0ab..17c3ae8bb0 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -48,11 +48,13 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_XDMA]      = 0x1E6E7000,
>       [ASPEED_DEV_ADC]       = 0x1E6E9000,
>       [ASPEED_DEV_DP]        = 0x1E6EB000,
> +    [ASPEED_DEV_PCIE_PHY1] = 0x1E6ED200,
>       [ASPEED_DEV_SBC]       = 0x1E6F2000,
>       [ASPEED_DEV_EMMC_BC]   = 0x1E6f5000,
>       [ASPEED_DEV_VIDEO]     = 0x1E700000,
>       [ASPEED_DEV_SDHCI]     = 0x1E740000,
>       [ASPEED_DEV_EMMC]      = 0x1E750000,
> +    [ASPEED_DEV_PCIE0]     = 0x1E770000,
>       [ASPEED_DEV_GPIO]      = 0x1E780000,
>       [ASPEED_DEV_GPIO_1_8V] = 0x1E780800,
>       [ASPEED_DEV_RTC]       = 0x1E781000,
> @@ -79,6 +81,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_FSI1]      = 0x1E79B000,
>       [ASPEED_DEV_FSI2]      = 0x1E79B100,
>       [ASPEED_DEV_I3C]       = 0x1E7A0000,
> +    [ASPEED_DEV_PCIE_MMIO1] = 0x70000000,
>       [ASPEED_DEV_SDRAM]     = 0x80000000,
>   };
>   
> @@ -127,6 +130,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_LPC]       = 35,
>       [ASPEED_DEV_IBT]       = 143,
>       [ASPEED_DEV_I2C]       = 110,   /* 110 -> 125 */
> +    [ASPEED_DEV_PCIE0]     = 168,
>       [ASPEED_DEV_PECI]      = 38,
>       [ASPEED_DEV_ETH1]      = 2,
>       [ASPEED_DEV_ETH2]      = 3,
> @@ -191,6 +195,10 @@ static void aspeed_soc_ast2600_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
>       object_initialize_child(obj, "i2c", &s->i2c, typename);
>   
> +    object_initialize_child(obj, "pcie-cfg", &s->pcie[0], TYPE_ASPEED_PCIE_CFG);
> +    object_initialize_child(obj, "pcie-phy[*]", &s->pcie_phy[0],
> +                            TYPE_ASPEED_PCIE_PHY);
> +
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   
>       snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
> @@ -285,6 +293,67 @@ static uint64_t aspeed_calc_affinity(int cpu)
>       return (0xf << ARM_AFF1_SHIFT) | cpu;
>   }
>   
> +/*
> + * PCIe Root Complex (RC)
> + *
> + * H2X register space (single block 0x00-0xFF):
> + *   0x00-0x7F : shared by RC_L (PCIe0) and RC_H (PCIe1)
> + *   0x80-0xBF : RC_L only
> + *   0xC0-0xFF : RC_H only
> + *
> + * Model scope / limitations:
> + *   - Firmware supports RC_H only; this QEMU model does not support RC_L.
> + *   - RC_H uses PHY1 and the MMIO window [0x70000000, 0x80000000]
> + *     (aka MMIO1).
> + *
> + * Indexing convention (this model):
> + *   - Expose a single logical instance at index 0.
> + *   - pcie[0] -> hardware RC_H (PCIe1)
> + *   - phy[0]  -> hardware PHY1
> + *   - mmio.0 -> guest address range MMIO1: 0x70000000-0x80000000
> + *   - RC_L / PCIe0 is not created and mapped.
> + */
> +static bool aspeed_soc_ast2600_pcie_realize(DeviceState *dev, Error **errp)
> +{
> +    Aspeed2600SoCState *a = ASPEED2600_SOC(dev);
> +    AspeedSoCState *s = ASPEED_SOC(dev);
> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> +    MemoryRegion *mmio_mr = NULL;
> +    qemu_irq irq;
> +
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy[0]), errp)) {
> +        return false;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie_phy[0]), 0,
> +                    sc->memmap[ASPEED_DEV_PCIE_PHY1]);
> +
> +    object_property_set_int(OBJECT(&s->pcie[0]), "dram-base",
> +                            sc->memmap[ASPEED_DEV_SDRAM],
> +                            &error_abort);
> +    object_property_set_link(OBJECT(&s->pcie[0]), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie[0]), errp)) {
> +        return false;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->pcie[0]), 0,
> +                    sc->memmap[ASPEED_DEV_PCIE0]);
> +
> +    irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
> +                           sc->irqmap[ASPEED_DEV_PCIE0]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie[0].rc), 0, irq);
> +
> +    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie[0].rc), 1);
> +    memory_region_init_alias(&s->pcie_mmio_alias[0], OBJECT(&s->pcie[0].rc),
> +                             "aspeed.pcie-mmio", mmio_mr,
> +                             sc->memmap[ASPEED_DEV_PCIE_MMIO1],
> +                             0x10000000);
> +    memory_region_add_subregion(s->memory,
> +                                sc->memmap[ASPEED_DEV_PCIE_MMIO1],
> +                                &s->pcie_mmio_alias[0]);
> +
> +    return true;
> +}
> +
>   static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>   {
>       int i;
> @@ -438,6 +507,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
>                          aspeed_soc_get_irq(s, ASPEED_DEV_PECI));
>   
> +    /* PCIe Root Complex (RC) */
> +    if (!aspeed_soc_ast2600_pcie_realize(dev, errp)) {
> +        return;
> +    }
> +
>       /* FMC, The number of CS is set at the board level */
>       object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
>                                &error_abort);


