Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38345C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 18:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSAh-0007Qp-8k; Tue, 20 May 2025 14:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAb-0007PX-4u
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:34 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHSAY-0006th-VC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 14:58:32 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-87bfe95866fso957717241.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 11:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747767507; x=1748372307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9rTivP8jDdK7RJ74edePZCyMdvPAUiRIA4dxTeTZtPg=;
 b=xx1on8Yk7ptHruD7rDi8SYcrfNPZrs2fu6PWNGR0JpC2xPm1laenMRsWMDxJ4Hv+3M
 4Es9IfrcPmHZZVUEJleCIqRWBb0DjE99cAcOrHexLTNo562kKrms9UlXRcb8H/DAi2bI
 F/dZxViOd6HX1Ldk+STF6n4ZDTBx2X1Ri5AWwomUCLi9Fi+P3XkvuD82+pFY7pjLIHEX
 jqz1tMEJU/LgL9wmceQgRdNFuLSeMG71AHUVlVRvmJkpmqmfIh4+AP5geQEKOwBNq82s
 5xdHLiRXFwazwk4DgDDWnTRe3JjxWsNkcD97IrNLoORyaqhZLQJZvy5YfniCSrUZFGhG
 OMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747767507; x=1748372307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rTivP8jDdK7RJ74edePZCyMdvPAUiRIA4dxTeTZtPg=;
 b=sLLimf3fLKyOPKFc9mUKqmCDIV7YhvoUguhtH8k/T/4xOoSsidM2AZkJHOGurXLMXE
 Ll3YMuOL0INuJvjTBsfkxy7SEZe2HK7eZy872s2R3Gk4ZjWjdZUJwxRxrsuDGbvYQ/Ja
 Mx7jWp4FkZKJrSGO9UbLXOAcsryZTQWs2QEUpObuzVhOgxRKrHFPdLMB6IWS+qDqTE4m
 U8CM0DYcxIM++ztjccCv4lDs26wn9OsxvczozIajL4YIB6N9OF2kyaWaOzLIbi5kOOde
 1mxugl1w65UZA6b2d/2pcTm3r4Gwow5ypfOmthiyoVC5kvNos4cNlaKcpgkjyJfg6bJv
 2geQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh4o9APN2NtZuD5JtzCmNQRQMDYtI6UkiHvRhRHQ11sf0Umq4mbgYWq55HmzHHcIZgNDj0o1TzXeui@nongnu.org
X-Gm-Message-State: AOJu0Yz73PrzlcP1AoQkyZjdXNBfellKYIOEhqbbMPbg4KrRrvxIunD8
 H7AtD16GaTeCcNS3kn/Wdvcx7Sb1cEDqctL9ez/M7r6AW+Yv8muSURVrVaL9Bjoju1E=
X-Gm-Gg: ASbGncuTXzEyi5rUAx4jFHSNdF8V/eip0wMuENcfoaMfxVv/dhHxq20MZwBxflnMYjH
 ljEZSUq/9iC1ebjxeQFP2i69MVA+uT66LL/NkzA6X9WMVBKIiu3G8B0qvsXTC5qHx6whyb9yCdN
 sXrYg9l3sq1xqpVZNyCMbkVrUzvr94vfLcynDqYElqwUpFnkgCZCZvHy9vwtxPT7BTxV5w6L8uf
 QMJ4g1ysk7H0IcEx2QAQ8EWuZwzciXsfB4LsR8gihaoVy27F6e8NHtA6CfFgD6w0In7PE8uvJcU
 xBiVl+SUKKbaqZt9OrjPf4Cj2oxPo7IAvLS4xMJh1Yiy2pv1Dj+46KmbVOIThFSk4UhI7s+GwSU
 DSIrw8iPGVu6X7XaVi/SXVhJ8T4YTFw==
X-Google-Smtp-Source: AGHT+IFlOcqqcG8xJJLiw3siECvplhLL2ZKGmjHS6uLijoQ1TqOfqhAHCsoC7XTivIZZV+BKmfZISQ==
X-Received: by 2002:a05:6102:3054:b0:4df:8f09:7d8f with SMTP id
 ada2fe7eead31-4dfa6c10808mr17835232137.17.1747767507361; 
 Tue, 20 May 2025 11:58:27 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec22768fsm7864458241.30.2025.05.20.11.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 11:58:26 -0700 (PDT)
Message-ID: <4e851e3b-169d-4119-b344-b570cb562fb8@linaro.org>
Date: Tue, 20 May 2025 15:58:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] hw/acpi/pcihp: Add an AmlRegionSpace arg to
 build_acpi_pci_hotplug
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-11-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-11-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ua1-x931.google.com
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> On ARM we will put the operation regions in AML_SYSTEM_MEMORY.
> So let's allow this configuration.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pcihp.h | 3 ++-
>   hw/acpi/pcihp.c         | 8 ++++----
>   hw/i386/acpi-build.c    | 4 ++--
>   3 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ec9b010e4a..525e61a2a9 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -28,6 +28,7 @@
>   #define HW_ACPI_PCIHP_H
>   
>   #include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/hotplug.h"
>   
>   #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
> @@ -73,7 +74,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                            AcpiPciHpState *s, DeviceState *dev,
>                                            Error **errp);
>   
> -void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
> +void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
>   void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
>   void build_append_pcihp_resources(Aml *table,
>                                     uint64_t io_addr, uint64_t io_len);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index fb54c31f77..310a5c54bd 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -629,7 +629,7 @@ static Aml *aml_pci_pdsm(void)
>       return method;
>   }
>   
> -void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
> +void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr)
>   {
>       Aml *scope;
>       Aml *field;
> @@ -638,21 +638,21 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>       scope =  aml_scope("_SB.PCI0");
>   
>       aml_append(scope,
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
> +        aml_operation_region("PCST", rs, aml_int(pcihp_addr), 0x08));
>       field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>       aml_append(field, aml_named_field("PCIU", 32));
>       aml_append(field, aml_named_field("PCID", 32));
>       aml_append(scope, field);
>   
>       aml_append(scope,
> -        aml_operation_region("SEJ", AML_SYSTEM_IO,
> +        aml_operation_region("SEJ", rs,
>                                aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
>       field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>       aml_append(field, aml_named_field("B0EJ", 32));
>       aml_append(scope, field);
>   
>       aml_append(scope,
> -        aml_operation_region("BNMR", AML_SYSTEM_IO,
> +        aml_operation_region("BNMR", rs,
>                                aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
>       field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>       aml_append(field, aml_named_field("BNUM", 32));
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index ca59185aac..87bb3d5cee 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1172,7 +1172,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> -            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
>           }
>           build_piix4_pci0_int(dsdt);
>       } else if (q35) {
> @@ -1216,7 +1216,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           aml_append(dsdt, sb_scope);
>   
>           if (pm->pcihp_bridge_en) {
> -            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
> +            build_acpi_pci_hotplug(dsdt, AML_SYSTEM_IO, pm->pcihp_io_base);
>           }
>           build_q35_pci0_int(dsdt);
>       }


