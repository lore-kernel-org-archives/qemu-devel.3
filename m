Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5A7C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 14:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbLXM-0000Na-Pp; Tue, 06 Aug 2024 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLXK-0000KI-AP
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:51:42 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbLXH-0001CS-Hn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 10:51:42 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-530ad969360so1086572e87.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722955897; x=1723560697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iXESy4XjNfOB5fDZVIQB6FXyT4kJ4xMiItE1SCk6V2A=;
 b=PXpo9TEc1Z7wQCZBdGo99itsW4mG56qbVJjHGe0ADnmM93p9GTWsQttaju1w7R4g+C
 cGoQCQykRATyFUJV21bModez1lIxaa9HVtGy9FC26DkPU0uzKP9dcLwjybNtA61LYlcy
 saN9oihSXUJ1+XfORxj4aVu3b6VwsCQMNFP1m0ckUUb1DZRp6YqW+4+VbTyuaIJnbQo+
 oduRBuMGuscSwW9PP85F3fnhrs6cB6BUj4lpXagHVkuxZvjwUHnKtDaqL4rsz4Xwgleh
 B3cNqlcvoAAUHyJbL1C64pGmwxBTmO1fIuX/ReChfGQY/62PBNqJV6aW33xECZlaT+YZ
 rGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722955897; x=1723560697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iXESy4XjNfOB5fDZVIQB6FXyT4kJ4xMiItE1SCk6V2A=;
 b=GppoXiTogymHUWkJdWrIMq/kraeHkp5Bo7yu+lqE/Qzhsdy8SAqI8uneXn+ng2kS+q
 VpVc0bQbLTgKGLwWg4xOTjjFF0DGhUcEpMMEKx/IKTHdcVNODQgvaL3mxNDS+8feipP8
 en5+CkQawWW+brQTacZYGm5uyoWkZkbfD6tF8P8iIM5DyL9Fb5blt54vk61OLy+tyXdU
 le5Icdm+cARkRb9y5CEn8oamLUx2vDwDmP9EcG2qpKCBO89UrIA5o9P72pbIQExxCKva
 u9aXrkO7CelB95VP5TEwF/s2oJODkyk0KK0QjdemJrRKAcPAlC4MPhZSDweCDD9loabT
 WZDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRzwVULsjwnwvdv6iVqPRsNi+8QMY4utm5rCiZ/0UDyBS5HTMjPDsoFcepBYn5wVeMFNZOlcx0eSD6cG4GVBCJMFbswg=
X-Gm-Message-State: AOJu0Yyhi595HT3JLrxEXOJ9vS1CCwbtnKqlZNczfbB4n1lux8bPmDUq
 F4FAiDW3UtbHCPEV+QpPpA0tmdgy1S+bYfniiFnR2ETIeDRz5ppdYKoYDZvUrrs=
X-Google-Smtp-Source: AGHT+IGSw/bY6cCR7X9UuHUO1HoWRwm1HQO3qraDU7xKg640AteB+QezKCbASF/jZrGlCWb8Up6q5w==
X-Received: by 2002:a05:6512:131e:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-530bb4d6d4fmr10164447e87.55.1722955897220; 
 Tue, 06 Aug 2024 07:51:37 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec7173sm550750666b.204.2024.08.06.07.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 07:51:36 -0700 (PDT)
Message-ID: <a37a5291-5917-45e6-8697-08defb97ac29@linaro.org>
Date: Tue, 6 Aug 2024 16:51:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/23] hw/arm: add basic support for the RT500 SoC
To: Octavian Purdila <tavip@google.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-23-tavip@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240805201719.2345596-23-tavip@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

Hi Octavian,

Few comments inlined.

On 5/8/24 22:17, Octavian Purdila wrote:
> Add basic support for the RT500 SoC. It supports enough peripherals to
> run the NXP's microXpresso SDK hello world example.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>   hw/arm/Kconfig         |   8 +
>   hw/arm/meson.build     |   1 +
>   hw/arm/rt500.c         | 348 +++++++++++++++++++++++++++++++++++++++++
>   hw/arm/svd/meson.build |   6 +
>   include/hw/arm/rt500.h |  49 ++++++
>   5 files changed, 412 insertions(+)
>   create mode 100644 hw/arm/rt500.c
>   create mode 100644 include/hw/arm/rt500.h

If possible please setup scripts/git.orderfile, it help to
review.

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1ad60da7aa..7ffece3dec 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -712,3 +712,11 @@ config ARMSSE
>       select UNIMP
>       select SSE_COUNTER
>       select SSE_TIMER
> +
> +config RT500
> +    bool
> +    select FLEXCOMM
> +    select RT500_CLKCTL0
> +    select RT500_CLKCTL1
> +    select FLEXSPI
> +    select RT500_RSTCTL
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index eb604d00cf..7d827d512c 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -59,6 +59,7 @@ arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>   arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>   arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>   arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
> +arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
>   
>   system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
>   system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
> diff --git a/hw/arm/rt500.c b/hw/arm/rt500.c
> new file mode 100644
> index 0000000000..0866ef3ef6
> --- /dev/null
> +++ b/hw/arm/rt500.c
> @@ -0,0 +1,348 @@
> +/*
> + * i.MX RT500 platforms.
> + *
> + * Copyright (c) 2024 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/arm/boot.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "qemu/log.h"
> +#include "qemu/datadir.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/arm/armv7m.h"
> +#include "hw/loader.h"
> +#include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/arm/rt500.h"
> +#include "hw/arm/svd/rt500.h"
> +
> +#define MMAP_SRAM_CODE_BASE   (0x0)
> +#define MMAP_SRAM_DATA_BASE   (0x20000000)
> +#define MMAP_SRAM_SIZE        (5 * MiB)
> +#define MMAP_BOOT_ROM_BASE    (0x03000000)
> +#define MMAP_BOOT_ROM_SIZE    (192 * KiB)
> +#define MMAP_SDMA_RAM_BASE    (0x24100000)
> +#define MMAP_SDMA_RAM_SIZE    (32 * KiB)
> +#define MMAP_FLEXSPI0_BASE    (0x08000000)
> +#define MMAP_FLEXSPI0_SIZE    (128 * MiB)
> +#define MMAP_FLEXSPI1_BASE    (0x28000000)
> +#define MMAP_FLEXSPI1_SIZE    (128 * MiB)
> +
> +#define SECURE_OFFSET    (0x10000000)
> +
> +typedef enum MemInfoType {
> +    MEM_RAM,
> +    MEM_ROM,
> +    MEM_ALIAS
> +} MemInfoType;
> +
> +static void do_sys_reset(void *opaque, int n, int level)
> +{
> +    if (level) {
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +    }
> +}
> +
> +static void rt500_init(Object *obj)
> +{
> +    RT500State *s = RT500(obj);
> +    int i;
> +
> +    /* Add ARMv7-M device */
> +    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
> +
> +    for (i = 0; i < RT500_FLEXCOMM_NUM; i++) {
> +        char id[] = "flexcommXX";
> +
> +        snprintf(id, sizeof(id), "flexcomm%d", i);
> +        object_initialize_child(obj, id, &s->flexcomm[i], TYPE_FLEXCOMM);
> +        DEVICE(&s->flexcomm[i])->id = g_strdup(id);

Directly g_strdup_printf().

> +    }
> +
> +    object_initialize_child(obj, "clkctl0", &s->clkctl0, TYPE_RT500_CLKCTL0);
> +    object_initialize_child(obj, "clkctl1", &s->clkctl1, TYPE_RT500_CLKCTL1);
> +
> +    /* Initialize clocks */
> +    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> +    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
> +
> +    for (i = 0; i < RT500_FLEXSPI_NUM; i++) {
> +        char id[] = "flexspiXX";
> +
> +        snprintf(id, sizeof(id), "flexspi%d", i);
> +        object_initialize_child(obj, id, &s->flexspi[i], TYPE_FLEXSPI);
> +        DEVICE(&s->flexspi[i])->id = g_strdup(id);
> +    }
> +
> +    for (i = 0; i < RT500_RSTCTL_NUM; i++) {
> +        char id[] = "rstctlX";
> +
> +        snprintf(id, sizeof(id), "rstctl%d", i);
> +        object_initialize_child(obj, id, &s->rstctl[i],
> +                                TYPE_RT500_RSTCTL);
> +        DEVICE(&s->rstctl[i])->id = g_strdup(id);
> +    }
> +}
> +
> +static void rt500_realize_memory(RT500State *s, Error **errp)
> +{

static

> +    const struct {
> +        const char *name;
> +        hwaddr base;
> +        size_t size;
> +        MemInfoType type;
> +        int alias_for;
> +    } mem_info[] = {
> +        {
> +            .name = "SRAM (code bus)",
> +            .base = MMAP_SRAM_CODE_BASE,
> +            .size = MMAP_SRAM_SIZE,
> +            .type = MEM_RAM,
> +        },
> +        {
> +            .name = "BOOT-ROM",
> +            .base = MMAP_BOOT_ROM_BASE,
> +            .size = MMAP_BOOT_ROM_SIZE,
> +            .type = MEM_ROM,
> +        },
> +        {
> +            .name = "Smart DMA RAM",
> +            .base = MMAP_SDMA_RAM_BASE,
> +            .size = MMAP_SDMA_RAM_SIZE,
> +            .type = MEM_RAM,
> +        },
> +        {
> +            .name = "SRAM (data bus)",
> +            .base = MMAP_SRAM_DATA_BASE,
> +            .size = MMAP_SRAM_SIZE,
> +            .type = MEM_ALIAS,
> +            .alias_for = 0
> +        },
> +    };
> +    int i;
> +
> +    s->mem = g_malloc_n(2 * ARRAY_SIZE(mem_info), sizeof(MemoryRegion));
> +    for (i = 0; i < ARRAY_SIZE(mem_info); i++) {
> +        const char *name = mem_info[i].name;
> +        int size = mem_info[i].size;
> +        int type = mem_info[i].type;
> +        int alias_for = mem_info[i].alias_for;
> +        MemoryRegion *mem = &s->mem[i];
> +        uint32_t base = mem_info[i].base;
> +        MemoryRegion *sec_mem;
> +        char sec_name[256];
> +
> +        switch (type) {
> +        case MEM_RAM:
> +            memory_region_init_ram(mem, OBJECT(s), name, size, errp);
> +            break;
> +        case MEM_ROM:
> +            memory_region_init_rom(mem, OBJECT(s), name, size, errp);
> +            break;
> +        case MEM_ALIAS:
> +        {
> +            MemoryRegion *orig = &s->mem[alias_for];
> +
> +            memory_region_init_alias(mem, OBJECT(s), name, orig, 0, size);
> +            break;
> +        }
> +        default:
> +            g_assert_not_reached();
> +        }
> +
> +        memory_region_add_subregion(get_system_memory(), base, mem);
> +
> +        /* create secure alias */
> +        snprintf(sec_name, sizeof(sec_name), "SECURE %s", name);
> +        sec_mem = &s->mem[ARRAY_SIZE(mem_info) + i];
> +        if (type == MEM_ALIAS) {
> +            mem = &s->mem[alias_for];
> +        }
> +        memory_region_init_alias(sec_mem, OBJECT(s), sec_name, mem, 0, size);
> +        memory_region_add_subregion(get_system_memory(), base + SECURE_OFFSET,
> +                                    sec_mem);
> +
> +        if (mem_info[i].type == MEM_ROM) {
> +            char *fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, "rt500.rom");
> +
> +            if (fname) {
> +                int fsize = get_image_size(fname);
> +                int ret;
> +
> +                if (fsize > size) {
> +                    error_setg(errp, "rom file too big: %d > %d", fsize, size);
> +                } else {
> +                    ret = load_image_targphys(fname, base, size);
> +                    if (ret < 0) {
> +                        error_setg(errp, "could not load rom: %s", fname);
> +                    }
> +                }
> +            }
> +            g_free(fname);
> +        }
> +    }
> +}
> +
> +static void rt500_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    RT500State *s = RT500(dev);
> +    int i;

Preferably reduce iterator variables scope.

> +
> +    rt500_realize_memory(s, errp);
> +
> +    /* Setup ARMv7M CPU */
> +    qdev_prop_set_uint32(DEVICE(&s->armv7m), "num-irq",
> +                         RT500_FLEXCOMM16_IRQn + 1);

Preferably a definition:

#define RT500_NUM_IRQ (RT500_FLEXCOMM16_IRQn + 1)

> +    qdev_prop_set_uint8(DEVICE(&s->armv7m), "num-prio-bits", 3);
> +    qdev_prop_set_string(DEVICE(&s->armv7m), "cpu-type", ms->cpu_type);

Do you plan to add RT500 machines not based on the Cortex-M33?
Otherwise simpler to hardcode the CPU type here.

> +    object_property_set_link(OBJECT(&s->armv7m), "memory",
> +                             OBJECT(get_system_memory()), &error_abort);
> +    if (!ms->kernel_filename) {
> +        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-nsvtor",
> +                             MMAP_BOOT_ROM_BASE);
> +        qdev_prop_set_uint32(DEVICE(&s->armv7m), "init-svtor",
> +                             MMAP_BOOT_ROM_BASE + SECURE_OFFSET);
> +    }
> +
> +    qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
> +    qdev_connect_clock_in(DEVICE(&s->armv7m), "refclk",
> +                     qdev_get_clock_out(DEVICE(&s->clkctl0), "systick_clk"));
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->armv7m), errp);
> +    qdev_connect_gpio_out_named(DEVICE(&s->armv7m), "SYSRESETREQ", 0,
> +                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
> +
> +    /* Setup FLEXCOMM */
> +    for (i = 0; i < RT500_FLEXCOMM_NUM; i++) {
> +        const uint32_t addr[] = {

static

> +            RT500_FLEXCOMM0_BASE, RT500_FLEXCOMM1_BASE, RT500_FLEXCOMM2_BASE,
> +            RT500_FLEXCOMM3_BASE, RT500_FLEXCOMM4_BASE, RT500_FLEXCOMM5_BASE,
> +            RT500_FLEXCOMM6_BASE, RT500_FLEXCOMM7_BASE, RT500_FLEXCOMM8_BASE,
> +            RT500_FLEXCOMM8_BASE, RT500_FLEXCOMM10_BASE, RT500_FLEXCOMM11_BASE,
> +            RT500_FLEXCOMM12_BASE, RT500_FLEXCOMM13_BASE, RT500_FLEXCOMM14_BASE,
> +            RT500_FLEXCOMM15_BASE, RT500_FLEXCOMM16_BASE
> +        };
> +        const int irq[] = {
> +            RT500_FLEXCOMM0_IRQn, RT500_FLEXCOMM1_IRQn, RT500_FLEXCOMM2_IRQn,
> +            RT500_FLEXCOMM3_IRQn, RT500_FLEXCOMM4_IRQn, RT500_FLEXCOMM5_IRQn,
> +            RT500_FLEXCOMM6_IRQn, RT500_FLEXCOMM7_IRQn, RT500_FLEXCOMM8_IRQn,
> +            RT500_FLEXCOMM9_IRQn, RT500_FLEXCOMM10_IRQn, RT500_FLEXCOMM11_IRQn,
> +            RT500_FLEXCOMM12_IRQn, RT500_FLEXCOMM13_IRQn, RT500_FLEXCOMM14_IRQn,
> +            RT500_FLEXCOMM15_IRQn, RT500_FLEXCOMM16_IRQn
> +        };
> +        const int functions[] = {
> +            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
> +            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
> +            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
> +            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_FULL,
> +            FLEXCOMM_FULL, FLEXCOMM_FULL, FLEXCOMM_HSSPI,
> +            FLEXCOMM_PMICI2C, FLEXCOMM_HSSPI
> +        };
> +        DeviceState *ds = DEVICE(&s->flexcomm[i]);
> +        char id[] = "flexcommXX";
> +
> +        snprintf(id, sizeof(id), "flexcomm%d", i);
> +        qdev_prop_set_uint32(ds, "functions", functions[i]);
> +        qdev_prop_set_chr(ds, "chardev", qemu_chr_find(id));
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(ds), 0,
> +                           qdev_get_gpio_in(DEVICE(&s->armv7m), irq[i]));
> +    }
> +
> +    /* Setup CTLCTL0 */
> +    qdev_connect_clock_in(DEVICE(&s->clkctl0), "sysclk", s->sysclk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl0)), 0, RT500_CLKCTL0_BASE);
> +
> +    /* Setup CTLCTL1 */
> +    qdev_connect_clock_in(DEVICE(&s->clkctl1), "sysclk", s->sysclk);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(DEVICE(&s->clkctl1)), 0, RT500_CLKCTL1_BASE);
> +
> +    /* Setup FlexSPI */
> +    for (i = 0; i < RT500_FLEXSPI_NUM; i++) {
> +        const uint32_t addr[] = {

static

> +            RT500_FLEXSPI0_BASE, RT500_FLEXSPI1_BASE
> +        };
> +        const uint32_t mmap_base[] = {
> +            MMAP_FLEXSPI0_BASE, MMAP_FLEXSPI1_BASE
> +        };
> +        const uint32_t mmap_size[] = {
> +            MMAP_FLEXSPI0_SIZE, MMAP_FLEXSPI1_SIZE,
> +        };
> +        DeviceState *ds = DEVICE(&s->flexspi[i]);
> +
> +        qdev_prop_set_uint32(ds, "mmap_base", mmap_base[i]);
> +        qdev_prop_set_uint32(ds, "mmap_size", mmap_size[i]);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
> +    }
> +
> +    /* Setup reset controllers */
> +    for (i = 0; i < RT500_RSTCTL_NUM; i++) {
> +        DeviceState *ds = DEVICE(&s->rstctl[i]);
> +
> +        const uint32_t addr[] = {

static

> +            RT500_RSTCTL0_BASE, RT500_RSTCTL1_BASE
> +        };
> +
> +        qdev_prop_set_uint32(ds, "num", i);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(ds), errp);
> +        sysbus_mmio_map(SYS_BUS_DEVICE(ds), 0, addr[i]);
> +    }
> +}
> +
> +static void rt500_finalize(Object *obj)
> +{
> +    RT500State *s = RT500(obj);
> +
> +    g_free(s->mem);

Allocated via rt500_realize() -> rt500_realize_memory() so
to be released in a DeviceUnrealize() handler.

> +}
> +
> +static void rt500_reset(DeviceState *ds)
> +{
> +}
> +
> +static Property rt500_properties[] = {

To be filled later?

> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void rt500_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    device_class_set_props(dc, rt500_properties);
> +    dc->realize = rt500_realize;
> +    dc->desc = "RT500 (ARM Cortex-M33)";
> +    dc->reset = rt500_reset;
> +}
> +
> +static const TypeInfo rt500_type_info = {
> +    .name = TYPE_RT500,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RT500State),
> +    .instance_init = rt500_init,
> +    .instance_finalize = rt500_finalize,
> +    .class_init = rt500_class_init,
> +};
> +
> +static void rt500_register_types(void)
> +{
> +    type_register_static(&rt500_type_info);

Preferably use the DEFINE_TYPES() macro.

> +}
> +
> +type_init(rt500_register_types)
> diff --git a/hw/arm/svd/meson.build b/hw/arm/svd/meson.build
> index 72a7421c6f..930a8b7343 100644
> --- a/hw/arm/svd/meson.build
> +++ b/hw/arm/svd/meson.build
> @@ -34,3 +34,9 @@ genh += custom_target('rt500_rstctl1.h',
>                         output: 'rt500_rstctl1.h',
>                         input: 'MIMXRT595S_cm33.xml',
>                         command: [ svd_gen_header, '-i', '@INPUT@', '-o', '@OUTPUT@', '-p', 'RSTCTL1', '-t', 'RT500_RSTCTL1'])
> +genh += custom_target('rt500.h',
> +                      output: 'rt500.h',
> +                      input: 'MIMXRT595S_cm33.xml',
> +                      command: [ svd_gen_header,'-i', '@INPUT@', '-o', '@OUTPUT@', '-s', 'RT500',
> +		                 '-p', 'FLEXCOMM0', '-p', 'CLKCTL0', '-p', 'CLKCTL1',
> +				 '-p', 'FLEXSPI0', '-p', 'FLEXSPI1', '-p', 'RSTCTL0', '-p', 'RSTCTL1'])
> diff --git a/include/hw/arm/rt500.h b/include/hw/arm/rt500.h
> new file mode 100644
> index 0000000000..8ca7972f8a
> --- /dev/null
> +++ b/include/hw/arm/rt500.h
> @@ -0,0 +1,49 @@
> +/*
> + * i.MX RT500 platforms.
> + *
> + * Copyright (c) 2024 Google LLC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#ifndef HW_ARM_RT500_H
> +#define HW_ARM_RT500_H
> +
> +#include "qemu/osdep.h"

No osdep.h in header.

> +#include "qemu/units.h"

Not used (move to source).

> +#include "hw/arm/boot.h"

Not used.

> +#include "hw/arm/armv7m.h"
> +#include "hw/misc/flexcomm.h"
> +#include "hw/misc/rt500_clkctl0.h"
> +#include "hw/misc/rt500_clkctl1.h"
> +#include "hw/ssi/flexspi.h"
> +#include "hw/misc/rt500_rstctl.h"
> +
> +#define TYPE_RT500 "rt500"
> +#define RT500(obj) OBJECT_CHECK(RT500State, (obj), TYPE_RT500)
> +
> +#define RT500_FLEXCOMM_NUM (17)
> +#define RT500_FLEXSPI_NUM (2)
> +#define RT500_RSTCTL_NUM (2)
> +
> +typedef struct RT500State {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +
> +    /*< public >*/

Please drop private/public comments.

> +    ARMv7MState armv7m;
> +    MemoryRegion *mem;
> +    FlexcommState flexcomm[RT500_FLEXCOMM_NUM];
> +    RT500ClkCtl0State clkctl0;
> +    RT500ClkCtl1State clkctl1;
> +    FlexSpiState flexspi[RT500_FLEXSPI_NUM];
> +    RT500RstCtlState rstctl[RT500_RSTCTL_NUM];
> +
> +    Clock *sysclk;
> +    Clock *refclk;
> +} RT500State;
> +
> +#endif /* HW_ARM_RT500_H */

LGTM,

Phil.


