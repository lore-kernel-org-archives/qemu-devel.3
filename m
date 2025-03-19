Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3922C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuyM-0003DA-AJ; Wed, 19 Mar 2025 11:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tuuy4-0003AQ-9Y
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:04:28 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tuuxw-0000Bl-N0
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:04:25 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso4548504a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1742396657; x=1743001457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P6SR2DZxoKbkuCDWrwn/UiRFCMww89FlVIVgP8rvAnU=;
 b=bh2eImTpbQFd192pjF3Zf6o000DpXKTNA7A78Bl24kXxUvt385Ba5PdG6yLWU2as6i
 DTBYd1jBYYFChHhsVApxkAZkrJxBCoMSrmO0kYpe42HndDWeZNWMLKLBHcUaVX9OmLdo
 KR5PM5ANwx8GKHcvsr7rXEK9HxSNy4u9+zHVaUv2/V4PUfOuzkjFctFDeNeUdUM/C4E6
 Wi8aW8drGUm+A5saK+Q5GZf3o9+yg7f3zo5FE26KT5bjJEHpnKFUHJ39QhZc+XG5geXw
 KUuIh3Ac0g4ClxvqKRxXMoUpTwBW/FVKsY+ICfv+yhlFKaHrHYIjeMiHAiLgemR0o1x3
 trFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396657; x=1743001457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P6SR2DZxoKbkuCDWrwn/UiRFCMww89FlVIVgP8rvAnU=;
 b=Qp5zdsBNT853Qyl5ERq7rLOYEmKaX4ND4CIRPWOhTAhgBbp7dZDX5dvizUv6QUfC2J
 EaggzVWttnhG6JFvQNnDE1BUhXUig5+E/gjTiny5VdwwnCe8TdaP2rP8sdMqpUaV5qSY
 zoPXKbzohV/uWbrUY/sqYJeSwqsLpb687qO/Epyn+IkI22hjlV9uGGJ5cT7DcHd8mItw
 a/m8NPUQ0YIM+UCQGYitEWdNu81jXpah/4WKiVkHpTtj/2DzyeQhqKW7lsjcEUKSuo5b
 TP1aS0ZScHpna388bw/ES5UcSo1iyDlAMKrr1B9/Hz6LytcR5rtnPfYCEZOT7nogDYvE
 Mzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03TiCMvxRIIvpFWEZYi0S79kjHarxz4XiolWfblJhzZhPqO2dhJnOGWuY+53kKLv3HEcno3ednju7@nongnu.org
X-Gm-Message-State: AOJu0Yyeu2cMH2rsI0p4cBSyqwMwI9E5twT8dLNyGOZMDUK7cqeKbWBw
 Ec7ZrRvr5c8SkCTVCkw7avCEIF30sKfhNLMwyMLa2Y0pLJpdN0zR6Wz9vcKybto=
X-Gm-Gg: ASbGnctDYQB4MdUwoXK6JwIcPAacnPCQanCC8I9cCPwyrDB6L3Y44IPcq+XPCJolSoj
 6lWUmTWVSNLRklIUPp95eggFTLey/t2SK9MOlGBvXf/36GaOPTbKWA4LsA9ANOeMbOKW/DMvw9C
 xVSCBc4ofrqarmNxJf4wqIQQWEDq7Nd7WI0dByrXKFFfqJWXCXIWwZlf2sTxa6oCYlI+/fUZJX5
 ReZLmIlRAvxyN5jLpfktH+g/lvELsif76eKZ24vNTGDKCtTnY0Fogx5jHKAOtDiCztlkFNe9/mR
 RO9kZOT6KvzpegEg8lm36FKZrw0HGb2w7iVdNdcuKx2D1iB8+BZ8wecxc88=
X-Google-Smtp-Source: AGHT+IFom6ww010xi6iwaZFX8PcNbPd8AlcrdD+abDzMsanCtLhGqSZ+ALguQ4cDLruZTtWQFfEEmw==
X-Received: by 2002:a17:90b:538c:b0:2fe:b470:dde4 with SMTP id
 98e67ed59e1d1-301bde59c52mr6585992a91.12.1742396657024; 
 Wed, 19 Mar 2025 08:04:17 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.117.79])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5b7cdcsm1841076a91.34.2025.03.19.08.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 08:04:16 -0700 (PDT)
Message-ID: <9bc5f892-889d-4fdd-9c33-4734851babc3@ventanamicro.com>
Date: Wed, 19 Mar 2025 12:04:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] hw/uefi-vars-sysbus: allow for riscv virt
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250319141159.1461621-1-kraxel@redhat.com>
 <20250319141159.1461621-5-kraxel@redhat.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250319141159.1461621-5-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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



On 3/19/25 11:11 AM, Gerd Hoffmann wrote:
> Allow the device being added to riscv virt VMs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 2 ++
>   hw/uefi/Kconfig | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dae46f4733cd..e517002fdfc7 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -57,6 +57,7 @@
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> +#include "hw/uefi/var-service-api.h"
>   
>   /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
>   static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
> @@ -1935,6 +1936,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       hc->plug = virt_machine_device_plug_cb;
>   
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>   #ifdef CONFIG_TPM
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>   #endif
> diff --git a/hw/uefi/Kconfig b/hw/uefi/Kconfig
> index ca6c2bc46a96..f139008b632b 100644
> --- a/hw/uefi/Kconfig
> +++ b/hw/uefi/Kconfig
> @@ -1,3 +1,3 @@
>   config UEFI_VARS
>   	bool
> -        default y if X86_64 || AARCH64
> +        default y if X86_64 || AARCH64 || RISCV64


