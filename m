Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C8EE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaKM-0002MS-HV; Fri, 06 Dec 2024 10:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJaKK-0002MJ-60
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:33:08 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJaKI-0000Cn-DU
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:33:07 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa629402b53so257296066b.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733499184; x=1734103984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ce4XIU4Ue5j8OoV1Vi0A6IjOZL0/10xOBmhOpP5wcV8=;
 b=zs2h8WIuREhgw6CJltzwoNobCvH6R7+y3SMv3ZK1tRg+HoB0oo+WlwSC7dM3ut0K0t
 kcyjjfZJYJqIzYfoNNmvgF1DaPeDxy1fnVkSCPTOg3pcz77HFYAJBxnaIWP9yauCk2nh
 j8KYKJxv9swSB3FfXTUF3Nfix9itInUbFVrlVOObZaKqYQOHZUuM2eZcO7estzjH0UcI
 4VtZCdjMFqcL6V1zQUTzRAGWZBInHtbQn9KzLVffrFcqTzOPC4Y9wPu/D9y6hvPi4AIR
 YnouoaCnZF+Yps0t3Uw+OdS+3TTespewSoQtxf8ABl+Z1IOJqo2npHiDWXAZI/2Suz0S
 zewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499184; x=1734103984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ce4XIU4Ue5j8OoV1Vi0A6IjOZL0/10xOBmhOpP5wcV8=;
 b=sjZTdISIAviic5ULGTg469Rz12UgT8bfRBvdiyqWMNRN1JrdDtrieVF8n5F2EIU4Il
 OkXTJq+QIifympPe9zprjClVIPDBWSDSmzz/D6/n83zTrM8d5M73Exxz8tgP7E68rO7C
 JtSpJrS2dDGu+zjWbiF6+12iBPuPcaC6mdRaHQZ76BCTwdhmlTvsunVJP2wPf38nT62Q
 zvBZU+Ri5Th9+WuHIYdlQqwJDQmDWlKEDI9CQwbowWzuKaP/FDbpgFgAYZCHqfE2rCAj
 Pvk0Ffhh8V2+akNHJGTgK8rM1pe+ZooFi+U0OQyguwtbpIzzvPDcP84h5vW4NfTpUlSM
 IEYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0CHQgtNANl1mdLk4nq20xbdgsw73xyeIxQQ/xOV0nvCU2Mw2r2m5hZZLgefX/4+r/tg2CyEz/yRfK@nongnu.org
X-Gm-Message-State: AOJu0YyG6bwgwXccanq79cCeWsIM1z5XY+maU8tjKQjSIJFlxKTi47X6
 WFR+/uDLq+EzCSm/EjYUFytbo/vEqR5sDxr76sEirBCn+N4fvPZJanuGTCzMn7s=
X-Gm-Gg: ASbGncu3/ZelizdYvo0dXeOT6jT+0XPhNZtbeJJdPTeNoI9V2xsYuGvT68KVoy/cCA4
 l1HAyi2CHlNHjraUeg7yt0myRklOPcKt6oZE1LIgOaYSAj5qWnTRo9kRqWmU0csNTqXs+/N4yhg
 mAWVr4DkgmI/VgPDR+g4afawf0M9boVVjUmkoHf7fwuss/Tmxn46NEwq0MoTtoPFoNU/f7ITAAI
 VHtdgMtBWZvA7kteCEIbNoY7fHWOmbkVx7QwZ0ny5PeUgdM3rUEFg1WLeCbzw1ZjEe4zeMvJvIE
 0N2pz7CI0z/bn1k+
X-Google-Smtp-Source: AGHT+IGFivhaF866CMhJjEqhOoT3qKk8PEMKaMi/rY+vb4PoWPEblo7JeFYV/V1je7NCx56/208mYA==
X-Received: by 2002:a17:906:3151:b0:aa6:24ff:7ebc with SMTP id
 a640c23a62f3a-aa639fb1e7cmr202985166b.7.1733499184013; 
 Fri, 06 Dec 2024 07:33:04 -0800 (PST)
Received: from [192.168.224.213] (249.162.185.81.rev.sfr.net. [81.185.162.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625eebc91sm256258466b.88.2024.12.06.07.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 07:33:02 -0800 (PST)
Message-ID: <5cac57ef-7745-4486-bed2-2c20e160a9c4@linaro.org>
Date: Fri, 6 Dec 2024 16:32:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/9] fw_cfg: Refactor extra pci roots addition
To: Jiahui Cen <cenjiahui@huawei.com>, qemu-devel@nongnu.org
Cc: xieyingtai@huawei.com, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, miaoyubo@huawei.com,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, wu.wubin@huawei.com
References: <20201119014841.7298-1-cenjiahui@huawei.com>
 <20201119014841.7298-3-cenjiahui@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20201119014841.7298-3-cenjiahui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 19/11/20 02:48, Jiahui Cen wrote:
> Extract extra pci roots addition from pc machine, which could be used by
> other machines.
> 
> In order to make uefi get the extra roots, it is necessary to write extra
> roots into fw_cfg. And only if the uefi knows there are extra roots,
> the config spaces of devices behind the root could be obtained.
> 
> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
> Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
> ---
>   hw/i386/pc.c              | 18 +--------------
>   hw/nvram/fw_cfg.c         | 23 ++++++++++++++++++++
>   include/hw/nvram/fw_cfg.h |  9 ++++++++
>   3 files changed, 33 insertions(+), 17 deletions(-)


> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 08539a1aab..282ba93e2e 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -40,6 +40,7 @@
>   #include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "hw/acpi/aml-build.h"
> +#include "hw/pci/pci_bus.h"

Stumbling at this (now merged as commit 0abd38885ac), not
sure how we let PCI stuff mixed within this generic device.
We have TYPE_FW_CFG_DATA_GENERATOR_INTERFACE to avoid that.

>   #define FW_CFG_FILE_SLOTS_DFLT 0x20
>   
> @@ -1061,6 +1062,28 @@ bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
>       return true;
>   }
>   
> +void fw_cfg_add_extra_pci_roots(PCIBus *bus, FWCfgState *s)
> +{
> +    int extra_hosts = 0;
> +
> +    if (!bus) {
> +        return;
> +    }
> +
> +    QLIST_FOREACH(bus, &bus->child, sibling) {
> +        /* look for expander root buses */
> +        if (pci_bus_is_root(bus)) {
> +            extra_hosts++;
> +        }
> +    }
> +
> +    if (extra_hosts && s) {
> +        uint64_t *val = g_malloc(sizeof(*val));
> +        *val = cpu_to_le64(extra_hosts);
> +        fw_cfg_add_file(s, "etc/extra-pci-roots", val, sizeof(*val));
> +    }
> +}
> +
>   static void fw_cfg_machine_reset(void *opaque)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());

