Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD34C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 14:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjfIL-0000Hj-16; Sun, 16 Feb 2025 09:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjfII-0000HG-QX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 09:06:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjfIG-0001zU-Tu
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 09:06:50 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439685e14f1so13945025e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739714807; x=1740319607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQrC5z24yGMnmTKX++/C9e4myUSCLYL/6Grg+lbS6pg=;
 b=CNN+0QAMHKEVpiTD4T35hu6I0uVgZfr1zYAXBxGaJhILfH2c/l3MRyR4Km/ZKeLQka
 tLFemjKz1q2bVposyf4nh/JnrcSeYZNJEXCRWqo4hXdjat/eKVwLMO3qkfX3w3kHXRR7
 /NjQehRVpMaXCrnA7LpvgfK47RkCaDRHVGe5kt//bMaugrg7zQdCuEbDxstofT3J3qSi
 dUIsDnNflxc6jWuGaOmdh4I8Y7wEtMC9+w0udYpzExloIu/mysrXu0JTgAVVwi8fzRyg
 sPHpdPCW8lrS2b+rP16IgYPSAXu7fFOJMsQOJJAmhi/rTxX5iIHNT17mtgVrYbb5t7xv
 9cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739714807; x=1740319607;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQrC5z24yGMnmTKX++/C9e4myUSCLYL/6Grg+lbS6pg=;
 b=romJeQSsXmOyceCfVqi07C2KcMX8qkZpfiu86ekHT8FE+D9fsF4egjzwAKsuJ9dkFv
 wJQj9LEh+untmJnJfJYlKiu4vrl3/RJue8m4/v45DCAH+OyW/I2vXxlBS0V5ZHWdGJJ1
 d+ogcqW5zeV2wpCvGRHjhvsoTk1EpaA/GaEo/SQw30rOgtK8y1h9zibLSeRIKN1Sx98E
 g3TZLH1lz3bECbvWBqteueiqNt1ZxswkiGFpWjpqv7Vr70iXP6M6Z6BRmC64nyj6M7RO
 iXvW/SOUao7zhmXXLkIed9AMYtoHIKAHb5z2+XV+vtg7rXuMvACLmGM17R0ytrcRo1Oi
 zAQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq8nz7YBx6oXDtrx57sul8FVryFjpfnJnhcptkvKuMZbE7Cj2DI3LHpNJ7RRyMiLKOLZEb9eKzrWTU@nongnu.org
X-Gm-Message-State: AOJu0YwBiWpIFx8bdepP/V/zDR/pPhBekcaE8J2OsRanY9pOhjAGIA1J
 /QlxAGspBpwY8zLcLGnpFwod8OHZkaCVYxjxr1UmRvGzvrMEvJBGHlZ49/5wqE8=
X-Gm-Gg: ASbGnctjP9i/+3VDjapok58vJCQO2/EDgU1HxrvOKpl4yte3+pfnF4MV8fLof+C9y/u
 8yRewU5MxJDs3brjRC3Ov6YM9unn1OSJqesexH1AsVle6dcq8z8Jps2lGNMeqE6fEbOU5CXtHRk
 R3L3/fXxRQE/ytgFWtIrDtY+Dm2QecVgs1MvM2wNfcXP+j0PVR/RfFFSRFROnXsm8U+blLX1QIf
 VvkXpxpo+NFj3Zgzv9bky55I5MrHio6WxBd8Jt19bZtOuxTQl7MRQ/9q2wLQrwiwkpy3ksKknte
 Vf5HUbHxgdpOey0xZ15R7a/bIcjZunREep85kAMfnODKrsWi2e6bRiwR6g==
X-Google-Smtp-Source: AGHT+IGs6NAo1qUHd3aG3FriREJxbZ5xNjs4fVHgbRTMX0GZeGd2JmnTohhAGo5/sWIhUfWCL/EQlQ==
X-Received: by 2002:a05:600c:470e:b0:439:6741:ed98 with SMTP id
 5b1f17b1804b1-4396e5bbc88mr74656375e9.0.1739714807155; 
 Sun, 16 Feb 2025 06:06:47 -0800 (PST)
Received: from [10.223.46.213] (108.170.88.92.rev.sfr.net. [92.88.170.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618264a3sm94530395e9.23.2025.02.16.06.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 06:06:45 -0800 (PST)
Message-ID: <04b7f67c-6926-41d5-b887-2f988c4f54c0@linaro.org>
Date: Sun, 16 Feb 2025 15:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/riscv: Configurable MPFS CLINT timebase freq
To: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250214062443.9936-6-sebastian.huber@embedded-brains.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250214062443.9936-6-sebastian.huber@embedded-brains.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 14/2/25 07:24, Sebastian Huber wrote:
> This property enables the setting of the CLINT timebase frequency
> through the command line, for example:
> 
>    -machine microchip-icicle-kit,clint-timebase-frequency=10000000
> 
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>   hw/riscv/microchip_pfsoc.c         | 49 +++++++++++++++++++++++++++---
>   include/hw/riscv/microchip_pfsoc.h |  1 +
>   2 files changed, 46 insertions(+), 4 deletions(-)

OK, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Although few comments related to pre-existing code inlined.

> 
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 76a2c56419..c83d588962 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -39,6 +39,7 @@
>   #include "qemu/units.h"
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
> +#include "qapi/visitor.h"
>   #include "hw/boards.h"
>   #include "hw/loader.h"
>   #include "hw/sysbus.h"
> @@ -61,9 +62,6 @@
>   #define BIOS_FILENAME   "hss.bin"
>   #define RESET_VECTOR    0x20220000
>   
> -/* CLINT timebase frequency */
> -#define CLINT_TIMEBASE_FREQ 1000000
> -
>   /* GEM version */
>   #define GEM_REVISION    0x0107010c
>   
> @@ -193,6 +191,7 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>   static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
> +    MicrochipIcicleKitState *iks = MICROCHIP_ICICLE_KIT_MACHINE(ms);
>       MicrochipPFSoCState *s = MICROCHIP_PFSOC(dev);
>       const MemMapEntry *memmap = microchip_pfsoc_memmap;
>       MemoryRegion *system_memory = get_system_memory();
> @@ -253,7 +252,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>           memmap[MICROCHIP_PFSOC_CLINT].base + RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> -        CLINT_TIMEBASE_FREQ, false);
> +        iks->clint_timebase_freq, false);

1/ Ideally TYPE_RISCV_ACLINT_MTIMER should take a Clock input.

>   
>       /* L2 cache controller */
>       create_unimplemented_device("microchip.pfsoc.l2cc",
> @@ -665,6 +664,40 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>       }
>   }
>   
> +static void microchip_icicle_kit_set_clint_timebase_freq(Object *obj,
> +                                                         Visitor *v,
> +                                                         const char *name,
> +                                                         void *opaque,
> +                                                         Error **errp)
> +{
> +    MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {

2/ Could we use qemu_strtosz_metric() here?

Better would be to implement visit_type_frequency(), similar
to visit_type_size(), to parse a 'Hz' suffix.

> +        return;
> +    }
> +
> +    s->clint_timebase_freq = value;
> +}
> +
> +static void microchip_icicle_kit_get_clint_timebase_freq(Object *obj,
> +                                                         Visitor *v,
> +                                                         const char *name,
> +                                                         void *opaque,
> +                                                         Error **errp)
> +{
> +    MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    uint32_t value = s->clint_timebase_freq;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void microchip_icicle_kit_machine_instance_init(Object *obj)
> +{
> +    MicrochipIcicleKitState *m = MICROCHIP_ICICLE_KIT_MACHINE(obj);
> +    m->clint_timebase_freq = 1000000;
> +}

3/ If MachineState were inheriting QDev, we could use qdev-properties.h
API. I'm not sure why we have to use duplicated QOM boiler plate code
here.

Peter, Paolo, Markus, do you have views on this?

Thanks,

Phil.

>   static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
> @@ -685,12 +718,20 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
>        * See memory_tests() in mss_ddr.c in the HSS source code.
>        */
>       mc->default_ram_size = 1537 * MiB;
> +
> +    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
> +                              microchip_icicle_kit_get_clint_timebase_freq,
> +                              microchip_icicle_kit_set_clint_timebase_freq,
> +                              NULL, NULL);
> +    object_class_property_set_description(oc, "clint-timebase-frequency",
> +                                  "Set CLINT timebase frequency in Hz.");
>   }
>   
>   static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
>       .name       = MACHINE_TYPE_NAME("microchip-icicle-kit"),
>       .parent     = TYPE_MACHINE,
>       .class_init = microchip_icicle_kit_machine_class_init,
> +    .instance_init = microchip_icicle_kit_machine_instance_init,
>       .instance_size = sizeof(MicrochipIcicleKitState),
>   };
>   
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index daef086da6..7ca9b976c1 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -67,6 +67,7 @@ typedef struct MicrochipIcicleKitState {
>       MachineState parent_obj;
>   
>       /*< public >*/
> +    uint32_t clint_timebase_freq;
>       MicrochipPFSoCState soc;
>   } MicrochipIcicleKitState;
>   


