Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2704DCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsQo-0000yz-FH; Tue, 26 May 2026 10:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsQk-0000yL-Or
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:06:51 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsQi-00028s-Bb
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:06:50 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-65db820588aso8641684d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804407; cv=none;
 d=google.com; s=arc-20240605;
 b=Y5WIGDS+mZUmCSoEdU6EYMitQlVt6z4P4F+9EgZwQgCCsoKRSfC1HzbEjnTovybCZJ
 OM0xQPZpEX6yF+5rCDVWVXHORImaVsGuIywbOBon5/gcHqRa7kuhExn6rDNarMtr8FHE
 zfigqqJjani4UQEyTqbPK98pP0RRFQ1rPKIFT9upEOFJV1UwQZ9ch+n0sAnBUmNMQQXX
 iIEJmMWSf0sSz1ogy8acUho4l7X5aFtOTE6hPHLZ0U0GUuO6q6EyPvQaBuoQLjlkgtPR
 5R2FWa0ySJyf9PZ4B4UkqXDTkS5CXuwUaecXPpNUGsaeo30iUn7fR6SZX2t1LWnCGvrp
 O5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oJIXEHLOG94+gKFQayaNzHb5vZnp7h6xGvRAnhkbxOg=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=OymU4xXGkVrrqSBJfAtRJEg0AOUYUNFlJRy7Od5zsvK2j68qdn1rOJgrU3gIMb9LPD
 /bPwssmn7agWGI/JCW35p3G/8cWo7Tlws9XMDvcAbtjsaX2MNLTvMliKjTjf6Q4dkrK4
 sd3azO5O3jF+HN1hOHA9MBt9yyyUoEmDCeEvMP7UK/mbFHTTECWx/pfnqtSI26jeeDQy
 Df0SWz3xtCAZb5M0qZ0sFhVRSMD8cEFbWm4/613qwClZemA+7Q9TsOA3sRzRPo4leGDZ
 hcS5LtdbH9MR7q64HbhbXEoXLlU8Pi3frv66WpogyTmlBSixNtoNtrVKSoJ3DO1ljtiM
 0hWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804407; x=1780409207; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oJIXEHLOG94+gKFQayaNzHb5vZnp7h6xGvRAnhkbxOg=;
 b=mz/K/gmVJqmntKk2f38WgqrM6c8yLwbtFYAG1ddWj3R37oEZP7VJAL9bXiuEuwVx1F
 Vb61dSQpaRNrOX7W9DLd6WcPtmvnV5YRCpjUpLuuYD/eW0XAHIsZECfXa8dpErzHu3Kj
 eCDsdyt+S5GzzErBMmHuekpgAG85neO9MC8W5tHemzIMSj9LPIS8A+iL1CZq+z8qPtum
 JKjn2SCESXaA3eq4MWRAHE7bfjSnJTLaDjz3Y7mRC7sXw9hPbuW12lwtAGglQzzDBy5j
 LmUVESzkST3ZBt5/BEguKjytAwmCU8EPnarxWHXcWdRyYSSC9jcM9cjzbIxfJ03vvMWh
 iB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804407; x=1780409207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJIXEHLOG94+gKFQayaNzHb5vZnp7h6xGvRAnhkbxOg=;
 b=CGShCmYWi1dG2QooyegrngJp/ekKlYEgcL0r/AohWsG+ET4HtiIjbFw74zvbW6Up6a
 eIOW9KOzHtXYQuxKHNBpgpOIkDcspni9B8UcocWQ5xSjiIfZLSR2/JT8MjtHwr9sP1Y4
 hdNzlGtesmmEgf8jEjP9k2flH6wZHnVu/z9T83FlMziahTYjrjV4kiFwjqGDB0fs2Jfg
 5mP+Seni1PimueRU4xd6G0UodJuN39dsEIV8mkuiE5IL1Kz8gGpjA8FJFyONGP414Ra3
 WxqVS2/kUiHyw/8MwnYTNyhsv3odQlRULTd6Qt9/ovkdbOa9eMgJwyXsRys4438q7rI0
 u23w==
X-Gm-Message-State: AOJu0YwJDLbqAnEXQHoTd26qMo9tFDUA5umwHps6Jb6JeXwz95kqV+SM
 F0u1SoYRXRq23iUvWhfJ4+MOfsypv4XREwShgLdY6hQj3XxF7IZ4nswEbn7xlT77audRmEk2ysZ
 qE3P/nKDiThVQWwD81y8Qk1bBDt4oQDK1/slXyADVVg==
X-Gm-Gg: Acq92OFxr5zOj2f2B/dmgG7Pffc97EVpnr8UiUpycAJ/aeB77UeIiP1YCVpp6oCCJrh
 FXITFjDi08VdSwgAmTstJiLgA6L+bCbJbQ9Kyek56XCjGPHoZvTWRp7t2hCL7b6hwiq+9EfFznR
 zsmiGsnlvZneX7klT77WtENjUY9vPm9zxRSg/R7/7ItDFSLQgG5XQs7K4dOpcm+UECvUpT7Yqm7
 /DGcml+sq0NEumyW25QF6ZW4OGL+BuRtOYxUaO8HH5KXM1hzWpKIh6xNzLMlU0lC6PLdmWT6mLt
 uxswqznDAr6+0Mjg8ejZte7gAahh7NLtBNC5C6THTabxsk70mPqiL9iguqrfCDaa5lQ=
X-Received: by 2002:a05:690e:d05:b0:65e:a7cb:509d with SMTP id
 956f58d0204a3-65ec99cfd09mr19409165d50.55.1779804406714; Tue, 26 May 2026
 07:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-2-kchiu@axiado.com>
In-Reply-To: <20260430091832.1846637-2-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 15:06:35 +0100
X-Gm-Features: AVHnY4JOy-fwD9Cc_6j0ImvbTAgbs_XW9ewLeLhs3V6YaMnSolADsHfU1UJMHxw
Message-ID: <CAFEAcA8dRq+hqCZ+eSHdafwEccd4coqHZ12nxWAkyDOG3GEkgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/arm: Add Axiado SoC AX3000
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch adds new model for Axiado SoC AX3000 which supports
>     4 Cortex-A53 ARM64 CPUs
>     Arm Generic Interrupt Controller v3
>     4 Cadence UARTs
>     1 SDHCI controller with eMMC PHY
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  MAINTAINERS                  |   9 ++
>  hw/arm/Kconfig               |   8 ++
>  hw/arm/ax3000-soc.c          | 232 +++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build           |   3 +
>  hw/sd/Kconfig                |   4 +
>  hw/sd/axiado_sdhci.c         | 100 +++++++++++++++

Adding the new SDHCI controller should be its own patch.

>  hw/sd/meson.build            |   1 +
>  include/hw/arm/ax3000-soc.h  |  78 ++++++++++++
>  include/hw/sd/axiado_sdhci.h |  21 ++++
>  9 files changed, 456 insertions(+)
>  create mode 100644 hw/arm/ax3000-soc.c
>  create mode 100644 hw/sd/axiado_sdhci.c
>  create mode 100644 include/hw/arm/ax3000-soc.h
>  create mode 100644 include/hw/sd/axiado_sdhci.h



> +static uint64_t pll_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    switch (offset) {
> +    case CLKRST_CPU_PLL_POSTDIV_OFFSET:
> +        return 0x20891b;
> +    case CLKRST_CPU_PLL_STS_OFFSET:
> +        return 0x01;
> +    default:
> +        return 0x00;
> +    }
> +}
> +
> +static void pll_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    /* TBD */
> +}
> +
> +static const MemoryRegionOps pll_ops = {
> +    .read = pll_read,
> +    .write = pll_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

MemoryRegionOps should always explicitly specify a set
of .impl and .valid fields to say what the min_access_size
and max_access_size are. (.valid is what the hardware
permits; .impl is what the functions handle; the memory
system core code can somewhat bridge the gap if your
implementation handles a more restrictive set of sizes
than the guest is allowed to use.) e.g. if the hardware
is "must always be 32 bit accesses then set all of
.valid.min_access_size, .valid.max_access_size,
.impl.min_access_size, .impl.max_access_size to 4.

> +};

This looks like it should be its own device in its own
file, not a free-standing set of MemoryRegionOps and
MemoryRegion in this file.

> +static void ax3000_init(Object *obj)
> +{
> +    Ax3000SoCState *s = AX3000_SOC(obj);
> +    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
> +    int i;

These days we tend to favour declaring the variable
inside the for loop:
  for (int i = 0; ... ; ...)


> +
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
> +        object_initialize_child(obj, name, &s->cpu[i],
> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
> +    }
> +
> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> +
> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
> +        g_autofree char *name = g_strdup_printf("uart%d", i);
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
> +    }
> +
> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
> +}
> +
> +static void ax3000_realize(DeviceState *dev, Error **errp)
> +{
> +    Ax3000SoCState *s = AX3000_SOC(dev);
> +    Ax3000SoCClass *sc = AX3000_SOC_GET_CLASS(s);
> +    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
> +    DeviceState *gic_dev = DEVICE(&s->gic);
> +    QList *redist_region_count;
> +    SysBusDevice *sdhci0_sbd;
> +    DeviceState *card;
> +    int i;
> +
> +    /* CPUs */
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 8000000,
> +                                &error_abort);
> +
> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3")) {
> +            object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3",
> +                                     false, &error_abort);
> +        }
> +
> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
> +    /* GIC */
> +    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
> +    qdev_prop_set_uint32(gic_dev, "num-irq",
> +                         AX3000_NUM_IRQS + GIC_INTERNAL);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, sc->num_cpus);
> +    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
> +
> +    if (!sysbus_realize(gic_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(gic_sbd, 0, AX3000_GIC_DIST_BASE);
> +    sysbus_mmio_map(gic_sbd, 1, AX3000_GIC_REDIST_BASE);
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (i = 0; i < sc->num_cpus; i++) {
> +        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
> +        int intidbase = AX3000_NUM_IRQS + i * GIC_INTERNAL;
> +        qemu_irq irq;
> +
> +        /*
> +         * Mapping from the output timer irq lines from the CPU to the
> +         * GIC PPI inputs.
> +         */
> +        static const int timer_irqs[] = {
> +            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
> +        };
> +
> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
> +            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
> +            qdev_connect_gpio_out(cpu_dev, j, irq);
> +        }
> +
> +        irq = qdev_get_gpio_in(gic_dev, intidbase + ARCH_GIC_MAINT_IRQ);
> +        qdev_connect_gpio_out_named(cpu_dev, "gicv3-maintenance-interrupt",
> +                                        0, irq);
> +
> +        sysbus_connect_irq(gic_sbd, i,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
> +    }
> +
> +    /* DRAM */
> +    for (i = 0; i < AX3000_NUM_BANKS; i++) {
> +        struct {
> +            hwaddr addr;
> +            size_t size;
> +            const char *name;
> +        } dram_table[] = {
> +            { AX3000_DRAM0_BASE, AX3000_DRAM0_SIZE, "dram0" },
> +            { AX3000_DRAM1_BASE, AX3000_DRAM1_SIZE, "dram1" }
> +        };
> +
> +        memory_region_init_ram(&s->dram[i], OBJECT(s), dram_table[i].name,
> +                               dram_table[i].size, &error_fatal);
> +        memory_region_add_subregion(get_system_memory(), dram_table[i].addr,
> +                                    &s->dram[i]);
> +    }
> +
> +    /* UARTs */
> +    for (i = 0; i < AX3000_NUM_UARTS; i++) {
> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } serial_table[] = {
> +            { AX3000_UART0_BASE, AX3000_UART0_IRQ },
> +            { AX3000_UART1_BASE, AX3000_UART1_IRQ },
> +            { AX3000_UART2_BASE, AX3000_UART2_IRQ },
> +            { AX3000_UART3_BASE, AX3000_UART3_IRQ }
> +        };
> +
> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> +                           qdev_get_gpio_in(gic_dev, serial_table[i].irq));
> +    }
> +
> +    /* Timer control */
> +    create_unimplemented_device("ax3000.timerctrl", AX3000_TIMER_CTRL, 32);
> +
> +    /* PLL control */
> +    memory_region_init_io(&s->pll_ctrl, OBJECT(s), &pll_ops, s,
> +                          "ax3000.pllctrl", 32);
> +    memory_region_add_subregion(get_system_memory(), AX3000_PLL_BASE,
> +                                &s->pll_ctrl);
> +
> +    /* SDHCI */
> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
> +    sysbus_connect_irq(sdhci0_sbd, 0,
> +                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
> +
> +    card = qdev_new(TYPE_SD_CARD);
> +    qdev_prop_set_drive_err(card, "drive",
> +                            blk_by_legacy_dinfo((drive_get(IF_SD, 0, 0))),
> +                            &error_fatal);
> +    qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
> +}
> +
> +static void ax3000_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
> +
> +    dc->desc = "Axiado SoC AX3000";
> +    dc->realize = ax3000_realize;
> +    sc->num_cpus = AX3000_NUM_CPUS;
> +}
> +
> +static const TypeInfo axiado_soc_types[] = {
> +    {
> +        .name           = TYPE_AX3000_SOC,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(Ax3000SoCState),
> +        .instance_init  = ax3000_init,
> +        .class_init     = ax3000_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(axiado_soc_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index b187b946f0..e32f5eb0c7 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -105,6 +105,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>
> +arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
> +  'ax3000-soc.c'))
> +
>  arm_common_ss.add(files('boot.c'))
>
>  hw_arch += {'arm': arm_ss}
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index 633b9afec9..c69bf24f8d 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -23,3 +23,7 @@ config SDHCI_PCI
>  config CADENCE_SDHCI
>      bool
>      select SDHCI
> +
> +config AXIADO_SDHCI
> +    bool
> +    select SDHCI
> diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
> new file mode 100644
> index 0000000000..219d49079e
> --- /dev/null
> +++ b/hw/sd/axiado_sdhci.c
> @@ -0,0 +1,100 @@
> +/*
> + * Axiado SD Host Controller
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/sd/axiado_sdhci.h"
> +#include "sdhci-internal.h"
> +#include "qapi/error.h"
> +#include "hw/core/qdev-properties.h"
> +
> +#define EMMC_PHY_ID     0x00
> +#define EMMC_PHY_STATUS 0x50
> +
> +static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint32_t val = 0x00;
> +
> +    switch (offset) {
> +    case EMMC_PHY_ID:
> +        val = 0x3dff6870;
> +        break;
> +    case EMMC_PHY_STATUS:
> +        /* Make DLL_RDY | CAL_DONE */
> +        val =  (1u << 0) | (1u << 6);

If this comment is trying to say what these bits are, better to
define symbolic constants for the bits and use those.

> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
> +                            unsigned size)
> +{
> +    /* TBD */

Don't leave bare TBD/TODO comments in the code. It's OK not to
necessarily implement everything at the start, but the
comment should explain what is missing. In six months
time, will somebody other than you be able to look at the
file and know what is still to do ?

> +}
> +
> +static const MemoryRegionOps emmc_phy_ops = {
> +    .read = emmc_phy_read,
> +    .write = emmc_phy_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,

This should specify access sizes too.

> +};
> +
> +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sdhci_sbd;
> +
> +    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
> +                            TYPE_SYSBUS_SDHCI);

Generally devices should do the object_initialize_child for
child-objects in their instance_init function, and
realize in their realize function. (Occasionally there's a
reason this isn't possible.)

> +
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
> +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
> +
> +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
> +    sysbus_realize(sdhci_sbd, errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
> +
> +    /* Propagate IRQ from SDHCI and SD bus  */
> +    sysbus_pass_irq(sbd, sdhci_sbd);
> +    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
> +
> +    /* Initialize eMMC PHY MMIO */
> +    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
> +                          "axiado.emmc-phy", 0x1000);
> +
> +    sysbus_init_mmio(sbd, &s->emmc_phy);
> +}
> +
> +static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = axiado_sdhci_realize;
> +    dc->desc = "Axiado SD Host Controller with eMMC PHY";
> +}
> +
> +static const TypeInfo axiado_sdhci_info = {
> +    .name          = TYPE_AXIADO_SDHCI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AxiadoSDHCIState),
> +    .class_init    = axiado_sdhci_class_init,
> +};
> +
> +static void axiado_sdhci_register_types(void)
> +{
> +    type_register_static(&axiado_sdhci_info);
> +}
> +
> +type_init(axiado_sdhci_register_types);

thanks
-- PMM

