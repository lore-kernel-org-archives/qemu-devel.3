Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01228C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reb8w-0004k2-GU; Mon, 26 Feb 2024 08:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reb8s-0004hU-Po
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:35:38 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reb8p-00047v-PY
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:35:38 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso3765888a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708954533; x=1709559333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgRdx5XFUWeFtyLrWi6OkbcTQSyelaY8NMq8wBE9piY=;
 b=MLr38QTnBz0ku0s3bkjMr1A6xjj6yY23XaAHYzVJlvwUNrFWzsOClSRQyQYqAsD965
 7dWmtUSgj7fEHUde0uMO+U4QyLoBjSyLhBtyWlHayw0uTjLLHPtJgZ9zNJdbwmurRR6N
 Ru/t+UnW1ilvi2MOwAimI7DG1avIGC6WeZ23vW7nvD2OggzuVxIwSciKfYG6i8xjCk9H
 f/S5xnyTHAYt/gDtDKj/WziK84pFmbVNJIc8opHs+5Rrn+jWkF7MiXdn0+XbB++A0kjh
 4i9XogmYHyy9QD9rWMWCkUOtJBGhThk/GFDYGLHRY0gE+sSd2ENptC/BYf8tMsCaP+nZ
 sKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708954533; x=1709559333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgRdx5XFUWeFtyLrWi6OkbcTQSyelaY8NMq8wBE9piY=;
 b=UeO9ltoIa6LVq09EDV3zfxSf6YKAOQ3rmZUehBExT6RhXMBsmCwrbc51YWfkBen05u
 EB0KtxNpIrtCyIb6bMpru9x1cawM8XUk1izNe/6KZT82mLdTq4msXlS9jMWa5e4YE2n4
 RxFdwr8rtcuvN23g6247nQvozkVae2uhHUx9NFacanatkp8jBuGSfOb+b8OHb29ZJdYj
 7oG9d9uURBKKgrdragbi4JqH7hSb4hTREqlZkGNgdiM2b99eVWbNxHtzne0ROWgrNN9S
 Ylpclx2tCu8qCpxrkfjEpqa7RV2XjSIj7W3wiCElFthh7dKZGLefJKBe9XOD5m+upQPk
 /lIA==
X-Gm-Message-State: AOJu0Ywue9zDJjEv1bQMSieMWCyr6t90pdYj5FpdA6+KkFjysdwzAGoW
 xcJ2Fw42Z/dEZJURMmGJ6mT7wQzHAaAu0hoNGSTSIMqKcNm+9KyXUzR7/Am2uFk=
X-Google-Smtp-Source: AGHT+IHed0O4lQlozQNVB3oVJICUZvxzDwZOtm2eqKnzlAuLLGKFSSrnTVOi+CCpxSKb0Sf7QPPTHA==
X-Received: by 2002:aa7:d841:0:b0:566:f60:4fc4 with SMTP id
 f1-20020aa7d841000000b005660f604fc4mr1154178eds.37.1708954533511; 
 Mon, 26 Feb 2024 05:35:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 cf26-20020a0564020b9a00b0056613d536e8sm389850edb.23.2024.02.26.05.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:35:33 -0800 (PST)
Message-ID: <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
Date: Mon, 26 Feb 2024 14:35:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
Content-Language: en-US
To: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-12-sergey.kambalin@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226000259.2752893-12-sergey.kambalin@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/2/24 01:02, Sergey Kambalin wrote:
> This commit adds RPi4B device tree modifications:
> - disable pcie, rng200, thermal sensor and genet devices
>    (they're going to be re-enabled in the following commits)
> - create additional memory region in device tree
>    if RAM amount exceeds VC base address.

This patch really looks like a respin of
https://lore.kernel.org/qemu-devel/20201018205551.1537927-4-f4bug@amsat.org/

Keeping previous author S-o-b or adding a "based on work ..."
is usually welcomed.

> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/raspi.c                  |  5 +--
>   hw/arm/raspi4b.c                | 62 +++++++++++++++++++++++++++++++++
>   include/hw/arm/raspi_platform.h |  4 +++
>   3 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 8b1a046912..a7a662f40d 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -37,9 +37,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
>   #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default */
>   #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
>   
> -/* Registered machine type (matches RPi Foundation bootloader and U-Boot) */
> -#define MACH_TYPE_BCM2708   3138
> -
>   struct RaspiMachineState {
>       /*< private >*/
>       RaspiBaseMachineState parent_obj;
> @@ -75,7 +72,7 @@ static const struct {
>       [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
>   };
>   
> -static uint64_t board_ram_size(uint32_t board_rev)
> +uint64_t board_ram_size(uint32_t board_rev)
>   {
>       assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
>       return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
> diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> index 36a4593928..49dec6e53a 100644
> --- a/hw/arm/raspi4b.c
> +++ b/hw/arm/raspi4b.c
> @@ -21,6 +21,7 @@
>   #include "hw/arm/boot.h"
>   #include "qom/object.h"
>   #include "hw/arm/bcm2838.h"
> +#include <libfdt.h>
>   
>   #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-2g")
>   OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
> @@ -30,6 +31,66 @@ struct Raspi4bMachineState {
>       BCM2838State soc;
>   };
>   
> +/*
> + * Add second memory region if board RAM amount exceeds VC base address
> + * (see https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
> + * 1.2 Address Map)
> + */
> +static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
> +{
> +    int ret;
> +    uint32_t acells, scells;
> +    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
> +
> +    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
> +                                   NULL, &error_fatal);
> +    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
> +                                   NULL, &error_fatal);
> +    if (acells == 0 || scells == 0) {
> +        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
> +        ret = -1;
> +    } else {
> +        qemu_fdt_add_subnode(fdt, nodename);
> +        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> +        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> +                                           acells, mem_base,
> +                                           scells, mem_len);
> +    }
> +
> +    g_free(nodename);
> +    return ret;
> +}
> +
> +static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
> +{
> +    uint64_t ram_size;
> +
> +    /* Temporarily disable following devices until they are implemented */
> +    const char *nodes_to_remove[] = {
> +        "brcm,bcm2711-pcie",
> +        "brcm,bcm2711-rng200",
> +        "brcm,bcm2711-thermal",
> +        "brcm,bcm2711-genet-v5",
> +    };
> +
> +    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> +        const char *dev_str = nodes_to_remove[i];
> +
> +        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
> +        if (offset >= 0) {
> +            if (!fdt_nop_node(fdt, offset)) {

Peter, I remember a discussion where you wre not keen on altering DTB
for non-Virt machines.

Since these devices are all implemented at the end of the series, why
not add the devices then the raspi4 board at the end, so this patch is
not even required?

Regards,

Phil.

> +                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
> +            }
> +        }
> +    }
> +
> +    ram_size = board_ram_size(info->board_id);
> +
> +    if (info->ram_size > UPPER_RAM_BASE) {
> +        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
> +    }
> +}


