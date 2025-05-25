Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8350C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDN6-0004eU-CD; Sun, 25 May 2025 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDN1-0004du-Tz
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:34:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDN0-0000AM-28
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:34:39 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso11050835e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748187276; x=1748792076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFrHVZJc/szkYeHSnu+6TOGCF3V52dhST6WvOMUXBB4=;
 b=RKX8FhdMFjydjcWlVescIak+qUJuAoQ+vhGPLZqiefJbh5kofSRacsXWGJZWBKFEiX
 LyPzxYjvKLjgTt3MIYhUcneyZsqEcTsvn10zqc3HUt16bNb587xmUct6SrYoJPr82bAI
 9kBrkjKKZdanyPLooPwo+rAQgNMS65zl1byoOJ8gQ8hC34HQ8/Wwl94YC3NjHyoFEPs0
 egQv+wmdNBUStEdRaqAgr20n0jBo3GHNxAKT9moUV8tUGndiuUETmQ3sIJqC6Nn77z+X
 vihF+sUnoZtDZf8CjXMXLvgf3o1XlYAWDUL51MG+jUwJuPaWQ4wy1mdZ/8clu+KtY3Xi
 Hymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748187276; x=1748792076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFrHVZJc/szkYeHSnu+6TOGCF3V52dhST6WvOMUXBB4=;
 b=X/s8cx5K19z2eVF0a/ILwEZR7w8dD9kFuRzzMrleGTzKFpjE6TcF5pXo/AvdfF2nCX
 BE2IvB1cI7Upr0LHnsgxwHOVu80UqYc1zu/cvjcb6x9SKGTDPy5yPwFXG9fUWwkxBbWY
 oG9tO8YMcPNHD+t1cYvwkHA7G1dQfaiuYD7rDkzd13lzrVru+ZKVd1/XkeNJcW0DR4pe
 +5uHKR9zK/Opkw2YJuwtbTnWGsuaeXPAO2zkNNjBuCc/+6a78BXRA5av4TFm0KuMzHfz
 avMS7/o4NuyF5AzuO+jkiAIkIcn5SDJldzCGxhsRY2Q5RJ/5WuXOCRREd+p2yqpdXiiB
 Qs+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8vjkQvotbUrYld0WktbzItw0SBHI8+ThQAuf3R9RxBRbI5oJgVPpCQqoJyjJanBIzxg4gr19CZN05@nongnu.org
X-Gm-Message-State: AOJu0YxRJuE3ghI8pse/V20M+cNwKhn2aZclDXIsCD+OopbSdr/a2Vdo
 yWwTvwUPr3C7mpwKkIcfBgh4oAnYAZJdxOQVVHDPiBIWgY5uZ9JSrkP4R6dkh7pQTPc=
X-Gm-Gg: ASbGncuGTvk+BEfBO1oXNHSwxkEopECtPi2SefOcgFvSobzn0CkLabO0zMYb6DC83XP
 ikW8jPUUMqfHUB4+hXilmx340GxcSUn/rL1/Cnlz+Fa8GrSdDGxITtzpVc0eDz8R+esIHTGdhvm
 2aYQG4euVVSzRuCLxv5D76hdFZT0B4aSWQWN6zYkNtiwq91C2bdXsHboe2MZ8olliLMtbWZAp0I
 T04lzd+YtQL6XDY3kqC/IogZ+G1Jq/ZOs5AxRUVqPWj2PmGE2ImvOSLXbJyQNbAT/nMUfD6b2pp
 olHUZWWsHrR0WaKuVdEwE9hnoD8S18Oan7Ep3M5AS8tVinwphlcPEHuy3SITsfmYvmaC9+cHcFM
 B0aQzURyT7aHq6Fqkj/mkeAvx7jA=
X-Google-Smtp-Source: AGHT+IFzbQ/TEygTK9F1zdeNJHfklbqgEIK7kroLcZd9xgTelU4OwcEZ1++z5WjyFXRRWkyAK5/BIw==
X-Received: by 2002:a05:600c:1d84:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-44c939c11bdmr58760895e9.18.1748187276289; 
 Sun, 25 May 2025 08:34:36 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfe80sm207012625e9.20.2025.05.25.08.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:34:35 -0700 (PDT)
Message-ID: <f73674b2-74b2-4140-9d3b-5037ad25baf6@linaro.org>
Date: Sun, 25 May 2025 17:34:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/22] hw/acpi/ged: Prepare the device to react to PCI
 hotplug events
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-17-eric.auger@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250514170431.2786231-17-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Eric,

On 14/5/25 18:01, Eric Auger wrote:
> QEMU will notify the OS about PCI hotplug/hotunplug events through
> GED interrupts. Let the GED device handle a new PCI hotplug event.
> On its occurrence it calls the \\_SB.PCI0.PCNT method with the BLCK
> mutex held.
> 
> The GED device uses a dedicated MMIO region that will be mapped
> by the machine code.
> 
> At this point the GED still does not support PCI device hotplug in
> its TYPE_HOTPLUG_HANDLER implementation. This will come in a
> subsequent patch.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/generic_event_device.h |  5 +++++
>   include/hw/acpi/pcihp.h                |  2 ++
>   hw/acpi/generic_event_device.c         | 15 +++++++++++++++
>   hw/acpi/pcihp.c                        |  1 -
>   4 files changed, 22 insertions(+), 1 deletion(-)


> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index bc31dbff39..bda5ea24b5 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -38,6 +38,8 @@
>   #define ACPI_PCIHP_SEJ_BASE 0x8
>   #define ACPI_PCIHP_BNMR_BASE 0x10
>   
> +#define ACPI_PCIHP_SIZE 0x0018
> +
>   typedef struct AcpiPciHpPciStatus {
>       uint32_t up;
>       uint32_t down;
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 7a62f8d5bc..dc3620553d 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -12,6 +12,7 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/irq.h"
>   #include "hw/mem/pc-dimm.h"
> @@ -26,6 +27,7 @@ static const uint32_t ged_supported_events[] = {
>       ACPI_GED_PWR_DOWN_EVT,
>       ACPI_GED_NVDIMM_HOTPLUG_EVT,
>       ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_PCI_HOTPLUG_EVT,
>   };
>   
>   /*
> @@ -121,6 +123,12 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                              aml_notify(aml_name("\\_SB.NVDR"),
>                                         aml_int(0x80)));
>                   break;
> +            case ACPI_GED_PCI_HOTPLUG_EVT:
> +                aml_append(if_ctx,
> +                           aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> +                aml_append(if_ctx, aml_call0("\\_SB.PCI0.PCNT"));
> +                aml_append(if_ctx, aml_release(aml_name("\\_SB.PCI0.BLCK")));
> +                break;
>               default:
>                   /*
>                    * Please make sure all the events in ged_supported_events[]
> @@ -299,6 +307,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>           sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>       } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
>           sel = ACPI_GED_CPU_HOTPLUG_EVT;
> +    } else if (ev & ACPI_PCI_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_PCI_HOTPLUG_EVT;
>       } else {
>           /* Unknown event. Return without generating interrupt. */
>           warn_report("GED: Unsupported event %d. No irq injected", ev);
> @@ -428,6 +438,11 @@ static void acpi_ged_realize(DeviceState *dev, Error **errp)
>               cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>                                   &s->cpuhp_state, 0);
>               break;
> +        case ACPI_GED_PCI_HOTPLUG_EVT:
> +            memory_region_init(&s->container_pcihp, OBJECT(dev),
> +                                "pcihp container",

Since "pcihp container" isn't just a description anymore, can
we have a ACPI_PCIHP_REGION_NAME definition?

> +                                ACPI_PCIHP_SIZE);
> +            sysbus_init_mmio(sbd, &s->container_pcihp);
>           }
>           ged_events--;
>       }
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 57fe8938b1..e87846a1fa 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -44,7 +44,6 @@
>   #include "qobject/qnum.h"
>   #include "trace.h"
>   
> -#define ACPI_PCIHP_SIZE 0x0018
>   #define PCI_UP_BASE 0x0000
>   #define PCI_DOWN_BASE 0x0004
>   #define PCI_EJ_BASE 0x0008


