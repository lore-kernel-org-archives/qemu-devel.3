Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82930C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TES-0004L7-IT; Thu, 17 Apr 2025 13:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TED-00042v-AC
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:40:53 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5TEB-0003HZ-4Y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:40:45 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7376e311086so1476817b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911641; x=1745516441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cHypbY80hmRvwtG7XqGarUt2c9QpSinQHCrHUXsz3o=;
 b=lmJR+vAWoQbHqitDkQ43Agr/MCVEsB4L+zF3jUIko6gvmilq7PH289+Bx3XooYxWiE
 b9xFoKD59afOIAxHDYQuFAM+2ZKueYFBE0uFQYx4S3myzidR5c9mQaiv2Vp5PrZtzJUN
 ZL1lu/VZoN/41f1xgG7mvAQWhCTSrBosIW5Cbx5wCsVqXBXpYvO43cRjG0XP+Zmi+o39
 mfdER2xODjIuSxn7txih9mGrHwORYaKfqCGngr04QtbOspAkgNhJhKPUijcamNDIQ/+M
 BaZFjhu4qGrRP0YkZvlmvfRZBWrHbEyjfwbiR85SD99D9Xqb/8jb7aOmOnPrf7nhiZFx
 iiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911641; x=1745516441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cHypbY80hmRvwtG7XqGarUt2c9QpSinQHCrHUXsz3o=;
 b=uHT3R7Dil0qaKr3oItdOac1iCKLQifcrtRtP1MNePjAEZ18yOVQSCBlfVi1lwK5a9C
 pfmDyAYUOC5XvBAJTh6/0iCD40jPk3P6Himdu6A6aXQGatONA7U0mNy4TiwVf4C8sPlv
 41vec5qq/+QCfvSob57YKw3xo6diUkswxQCqimFgcDPgh49B3XbREYRlpV9lp0vo2144
 TY29MfKipR0TkXBF/oT0Krcav8/pN2NybhJWFlHSdAQL+ByCNWUEsNoQjZV6KNtQxYqS
 6wbtMNz5J3u4m1LRdf/iISHp+gKsGrh8Xg0e7S5L/mpDVH3FkursvLq04bGUqm2+XKvN
 6Wsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5I+8AeS33zPF8vEw4NmqPn/tnREGTakQl2yAzNKWifQqWD+V0y1kd52o6ecUglxvxskGijbNf9b/D@nongnu.org
X-Gm-Message-State: AOJu0YyD3apgzOBE0+vKxOKtwixpUTAOPG6SYE5APbFbOwOrymSl1Ixr
 fTLQs1WOOdV1iD/DjiqkWEkigm0F74FDQcRRh51EU3A5mq+AxEVfV4zGDxCTU8k=
X-Gm-Gg: ASbGncuOBxNCfC7ihtjmdgkrUlQZByGVuPWmGkRPwimLGg0JV678D1ZqfeTuIs8HUtC
 c2HX3aGeQXiIjLViUPVXbL+sc/hSZQlEaqFTteNNCywaCP5hDmEt765njgXYviTskurAkpxhjyw
 IAiie7Ualv9E7ceDsXVA3HiomS9GuK1BbuhVsrrDFQF7iZQhjRzeSvY2B9AgJWK53Jio6WXjQ7C
 HL5+yPFdm8mO8JebUDkQUyPXmmZFvcFfNQgieCUt933kC6+S6zUYiTeHsty+XT6LOnQPlA+lxBF
 3hS1F4ZbH8sZ9fiRoPZpJUoOa01l776KdUjLT3BBXEosb3i/W8/q
X-Google-Smtp-Source: AGHT+IFFAUI6R0yyziFiLX16v/tqBDI4UAT5DecIv6jyazK58aZqLxDmhjFwy6wmGoZhdnk02SdEfA==
X-Received: by 2002:a05:6a20:9c8b:b0:1f3:2c55:8d8a with SMTP id
 adf61e73a8af0-203b3e90354mr9381259637.12.1744911641581; 
 Thu, 17 Apr 2025 10:40:41 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a7549sm157506a12.26.2025.04.17.10.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:40:41 -0700 (PDT)
Message-ID: <8d1087a0-a1e7-4979-a230-ece87cc7093d@linaro.org>
Date: Thu, 17 Apr 2025 14:40:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411204133.2955-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42a.google.com
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


Hi Annie,

Some additional comments I forgot :)

On 4/11/25 17:41, Annie Li wrote:
> The GPE event is triggered to notify x86 guest to suppend

nit                                                 ^ suspend

But I prefer to stick with "sleep" here instead.


> itself. The function acpi_send_sleep_event will also
> trigger GED events on HW-reduced systems where ACPI GED
> sleep event is supported.

The title for this patch is a bit misleading because no
x86 code is actually touched. Also, we are not generating
the AML code and field for wake up (SBW) in patch 1/13,
hence, remove "wakeup" from the title as well?


Cheers,
Gustavo

> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/acpi/core.c                       | 10 ++++++++++
>   include/hw/acpi/acpi.h               |  1 +
>   include/hw/acpi/acpi_dev_interface.h |  1 +
>   3 files changed, 12 insertions(+)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 58f8964e13..00a9d226f0 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>       return -1;
>   }
>   
> +void acpi_send_sleep_event(void)
> +{
> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
> +
> +    if (obj) {
> +        /* Send sleep event */
> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
> +    }
> +}
> +
>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>   {
>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index d1a4fa2af8..64d3ff78ed 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
>   
>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                            AcpiEventStatusBits status);
> +void acpi_send_sleep_event(void);
>   
>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>   
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50..1cb050cd3a 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>       ACPI_VMGENID_CHANGE_STATUS = 32,
>       ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_SLEEP_STATUS = 128,
>   } AcpiEventStatusBits;
>   
>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"


