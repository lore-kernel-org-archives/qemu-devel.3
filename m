Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E11E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGt-0004G4-50; Thu, 19 Dec 2024 11:21:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIpU-0006fS-Kj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:52:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIpS-0007BS-W9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:52:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso9745025e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734623565; x=1735228365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPXeRSGyjZ0gYXKU9wNEYO46Esb50lQRGDHAWVN/JVM=;
 b=RnpGpsLlFSo9+/NBAOFpIBOQHHieFqGhZRzjbS6q+SvGYtWg5onQOdn3wAXejqWFhz
 19HjbXazKSHGGmpq8n+eEvJii3yU0K8pxSVqTxekAND7ZhAZ5duZszJNBIECuFogkpMi
 zxV7UnyjNktu6NeHu3woZneW1oK92EU05dgl7SP/MOXQF1xlW1GAig0z7X/Vf5cmvYBy
 VSpKfEp4BvVWWCz3mn8DIOI5vQYqfiH6+gCPYt7hqEhKCucov68NYI4uOQwMxdeQC/2H
 nCWL+75oJE9yLL70X80RWgR/qGphRDxMinphJhk1Yj3Ihp7/MhlgMCUAVOhr0yvO1C4/
 psZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734623565; x=1735228365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GPXeRSGyjZ0gYXKU9wNEYO46Esb50lQRGDHAWVN/JVM=;
 b=EcDrfSQ6+DTz1H/0H8AURyirA5iBp0vs4CVezO5p2DJd5yqqmjfYqMqcbfIvgZ1klZ
 qd3n53SX7jEjw8s2nZrc9e3Zha5Xy9pdkvQXFX91xCGifVPJdLZLfwEUsmirOQyc3QTl
 HUHmmVtxpn64LbUuGLlmSvVn8vVt8YtxAu/W8L4CKmCDHu4yWksUPO2mzUWKIDlpjlj8
 OFOtwa/RdpZoqDbCp1g7vaNY4eaQVM7pa0rq7zrH4Fsnlm30xpwwj/w25FVnsc2GMjgR
 iAlDtfhM2pkpWP229uXur6DREjgD7s96IfD6sadqmBf+x0EEdhdkaoGD/Sw0FCikbun1
 3lrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5daHPa1ue2IgrGBqjNr9dKLIPRSNlxixch2oGMl1hqoWbm6nCugZdxw4hhsysHf5hZaPyMWMggfXY@nongnu.org
X-Gm-Message-State: AOJu0YwJvrvl3jY3ROM0IElaLhK033fNlK5gBH/7/nikN9KJjaFUQTi5
 Z0FYAzTZCJ05OqZTOf5gD6+MQpByp8QRbDU6W3PV+JRcF0+LC6xA0mKoEwHkPSU=
X-Gm-Gg: ASbGnctAsfAIeXGeUTzCwEMVwUD3/eCwfLST3k9YnbcHQz2eArPcr6y0phgOOv/7UYo
 wPnDfV76eZZBnq2Z2uO65vRUb7Ecw756+0Hqqz8mGznWRWqK33P2tiiu/irOzV0HPTemZNqjKak
 goKzAIHQapFxG3qpWk1fZQviT7lX0Lm7Aow9Zw0E49wNNhFADE3wn5XhVacrf5UcpT2TE6Tmr5v
 qaYgl4ADMInKEcMQM3onODI9GYfzdfFzND185wHxxemO2Oy7dFQtpqahAn+FQ2ciUspdGI=
X-Google-Smtp-Source: AGHT+IHrtY2I9vntk9kX4h4+kZhDiu/0kSPInps6pMvOK2W0P1GqY/NTTtDGfQKMK1JnWaMS9DtksA==
X-Received: by 2002:a05:6000:2a4:b0:385:fb2c:6034 with SMTP id
 ffacd0b85a97d-388e4d91e80mr6888157f8f.47.1734623565376; 
 Thu, 19 Dec 2024 07:52:45 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm22017145e9.5.2024.12.19.07.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 07:52:44 -0800 (PST)
Message-ID: <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
Date: Thu, 19 Dec 2024 16:52:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 16/12/24 12:48, Ani Sinha wrote:

> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index d02d96e403..4c5bdb0de2 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>   
> +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdate.c'))

FW_CFG_DMA is offered by multiple targets ...:

$ git grep -w FW_CFG_DMA
hw/arm/Kconfig:19:    select FW_CFG_DMA
hw/i386/Kconfig:82:    select FW_CFG_DMA
hw/i386/Kconfig:113:    select FW_CFG_DMA
hw/loongarch/Kconfig:22:    select FW_CFG_DMA
hw/riscv/Kconfig:59:    select FW_CFG_DMA

> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> new file mode 100644
> index 0000000000..1e29a610c0
> --- /dev/null
> +++ b/hw/misc/vmfwupdate.c
> @@ -0,0 +1,157 @@
> +/*
> + * Guest driven VM boot component update device
> + * For details and specification, please look at docs/specs/vmfwupdate.rst.
> + *
> + * Copyright (C) 2024 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "sysemu/reset.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/i386/pc.h"

... however ...

> +#include "hw/qdev-properties.h"
> +#include "hw/misc/vmfwupdate.h"
> +#include "qemu/error-report.h"
> +
> +static void fw_update_reset(void *dev)
> +{
> +    /* a NOOP at present */
> +    return;
> +}
> +
> +
> +static uint64_t get_max_fw_size(void)
> +{
> +    Object *m_obj = qdev_get_machine();
> +    PCMachineState *pcms = PC_MACHINE(m_obj);
> +
> +    if (pcms) {
> +        return pcms->max_fw_size;

... this code depends on x86/PC.

Could it be wiser to add a new VM_FWUPDATE Kconfig
symbol, having it depending on FW_CFG_DMA && I386?

> +    } else {
> +        return 0;
> +    }
> +}


