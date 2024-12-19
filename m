Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24F3E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK8C-0002N7-5B; Thu, 19 Dec 2024 12:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK8B-0002Ly-43
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:16:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK88-0006VQ-5z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:16:10 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43618283dedso10379105e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628566; x=1735233366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wo3u0A0BS3E5gQ4LYgtO0QOrEsZE9LANmSBbKRQ7o14=;
 b=eX7f7uMoChz+R0rO7syI4jmcxwddX/rYOcWqMRynT1x+bMqbClK1of3Vf+UB4fOBad
 xBpdEcCLedPUXTHfAnWGYCvHg5K7mLGzGxis2gUqbnfBwhpi3WquRFN0A55hw6ZSGbL+
 3v9bpY1ERbFv6loruPqoBMuYzRJANfDWymC/rZB3UsHARYkzl94jMXeJhpCoj/VdSb2o
 QkLI7tByL4J3vcKRHzfcocTjRtKPjLaR25SLKyd/FLQ/KsDD9xqTtSv0wpDWGCHUouet
 8yhviWYnNdcYoHBPd+JOs/UtUi7WnwVfbIrlsyp7B8Hcst6UH3srSs5N5AIgBmcR1/DH
 rXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628566; x=1735233366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wo3u0A0BS3E5gQ4LYgtO0QOrEsZE9LANmSBbKRQ7o14=;
 b=f4WG0DB20DPNU2U92dLlI0ecBkt/NrBNBJ4Cmmwr02DBpxGKRGxo8jgiyQI+56au8J
 1pdh/Z90Mrg5NxLYdphSK6dePaS8nGxMrz4g2ewMVYWSSvKtWaZtsleUWo/U0qVI73P+
 LpLxrxBDYIaUwe+YE3iVki+3ovHOysTrG/fUZfMUFW/E4vLEBQJLv5X8sRZrAaByG5vx
 CoAfzJPxOOmddnpG6zjhYy4mOQLpjbWsmoZG0ZNm6fKQCLH+6whCZYbUxRk1R9nIRXaE
 LVDrXBVcejPI+wQyCrgBxgQ0sIG4Mr6ixyggHCGpNg364M0AAKJWcje0lXe5ufQscjRL
 RKtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqczWdvshbtb9wayq+5/g/6EuobCSIThj/Dtft6mTq1WHA+b92umajmzgfQizqBpXqhRp2gQGLJGmu@nongnu.org
X-Gm-Message-State: AOJu0YxXkSPPPZvpORKPbilJID74R9vpj8TYUZHOR/eSPn7wgIsvQKZA
 /+L68rkC9/tsjQWYgASNFgj7qt2C4RDwpaTcEntzqeej96/QOg3+cR1MctkaAVs=
X-Gm-Gg: ASbGncu4yf3HvnT7Lzez2tWgc5/mojIL5nu4wZ1lwbS+WxKayFC1UuxdgnX/3RL8uOB
 7GybTsKf1Tg/MAKFSLFRPO0Rt4h5goWrgHQ4u771rx6y9sfFiWMHQYrdsaq5z/Op4U9mnEB4dez
 GQnwqw5p46NGXCmWjK59TVZ+EbStl7Pf61HyFNW6fLfEcU4VD7BVfPVI86gU59SXgUTb7Hz2yJk
 jZSYMlf6kdp3SvLJzua/HgRbotmX/Iy7dRA5CCM+LnCA0r+cyCPZCInfmpUetXYupyPx3Q=
X-Google-Smtp-Source: AGHT+IGpiqefMop0ORZkMAwC5rNF84+3w9zFQN8FGc7skKq93b3/Aw2aVI5iSBQrnFxWuWEPVqOmYA==
X-Received: by 2002:a05:600c:190e:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-436664ac50bmr101275e9.24.1734628566318; 
 Thu, 19 Dec 2024 09:16:06 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8292f4sm2032965f8f.3.2024.12.19.09.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:16:05 -0800 (PST)
Message-ID: <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
Date: Thu, 19 Dec 2024 18:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 19/12/24 18:08, Ani Sinha wrote:
> 
> 
> On Thu, 19 Dec, 2024, 10:21 pm Philippe Mathieu-Daudé, 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     On 19/12/24 17:16, Ani Sinha wrote:
>      >
>      >
>      > On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daudé,
>     <philmd@linaro.org <mailto:philmd@linaro.org>
>      > <mailto:philmd@linaro.org <mailto:philmd@linaro.org>>> wrote:
>      >
>      >     On 16/12/24 12:48, Ani Sinha wrote:
>      >
>      >      > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>      >      > index d02d96e403..4c5bdb0de2 100644
>      >      > --- a/hw/misc/meson.build
>      >      > +++ b/hw/misc/meson.build
>      >      > @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA',
>      >     if_true: files('mac_via.c'))
>      >      >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
>      >     files('mips_cmgcr.c', 'mips_cpc.c'))
>      >      >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true:
>      >     files('mips_itu.c'))
>      >      >
>      >      > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true:
>      >     files('vmfwupdate.c'))
>      >
>      >     FW_CFG_DMA is offered by multiple targets ...:
>      >
>      >     $ git grep -w FW_CFG_DMA
>      >     hw/arm/Kconfig:19:    select FW_CFG_DMA
>      >     hw/i386/Kconfig:82:    select FW_CFG_DMA
>      >     hw/i386/Kconfig:113:    select FW_CFG_DMA
>      >     hw/loongarch/Kconfig:22:    select FW_CFG_DMA
>      >     hw/riscv/Kconfig:59:    select FW_CFG_DMA
>      >
>      >      > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
>      >      > new file mode 100644
>      >      > index 0000000000..1e29a610c0
>      >      > --- /dev/null
>      >      > +++ b/hw/misc/vmfwupdate.c
>      >      > @@ -0,0 +1,157 @@
>      >      > +/*
>      >      > + * Guest driven VM boot component update device
>      >      > + * For details and specification, please look at docs/specs/
>      >     vmfwupdate.rst.
>      >      > + *
>      >      > + * Copyright (C) 2024 Red Hat, Inc.
>      >      > + *
>      >      > + * Authors: Ani Sinha <anisinha@redhat.com
>     <mailto:anisinha@redhat.com>
>      >     <mailto:anisinha@redhat.com <mailto:anisinha@redhat.com>>>
>      >      > + *
>      >      > + * This work is licensed under the terms of the GNU GPL,
>     version
>      >     2 or later.
>      >      > + * See the COPYING file in the top-level directory.
>      >      > + *
>      >      > + */
>      >      > +
>      >      > +#include "qemu/osdep.h"
>      >      > +#include "qapi/error.h"
>      >      > +#include "qemu/module.h"
>      >      > +#include "sysemu/reset.h"
>      >      > +#include "hw/nvram/fw_cfg.h"
>      >      > +#include "hw/i386/pc.h"
>      >
>      >     ... however ...
>      >
>      >      > +#include "hw/qdev-properties.h"
>      >      > +#include "hw/misc/vmfwupdate.h"
>      >      > +#include "qemu/error-report.h"
>      >      > +
>      >      > +static void fw_update_reset(void *dev)
>      >      > +{
>      >      > +    /* a NOOP at present */
>      >      > +    return;
>      >      > +}
>      >      > +
>      >      > +
>      >      > +static uint64_t get_max_fw_size(void)
>      >      > +{
>      >      > +    Object *m_obj = qdev_get_machine();
>      >      > +    PCMachineState *pcms = PC_MACHINE(m_obj);
>      >      > +
>      >      > +    if (pcms) {
>      >      > +        return pcms->max_fw_size;
>      >
>      >     ... this code depends on x86/PC.
>      >
>      >     Could it be wiser to add a new VM_FWUPDATE Kconfig
>      >     symbol, having it depending on FW_CFG_DMA && I386?
>      >
>      >
>      > There is no reason why vmfwupdate would be limited to x86 only.
>     There is
>      > minimal support needed from hypervisor side for this mechanism. That
>      > mechanism has little dependency on specific platform.
> 
>     OK, then please remove that PCMachineState use
> 
> 
> That is used because the max_fw_size property only exists for pc 
> machines. Do you have a better idea to get this value in a platform 
> agnostic way? Like I said in the previous reply I do not know how to get 
> this value reliably for all machines. If anyone has better ideas, I'm 
> all ears.

Either add the I386 dependency or don't use PC_MACHINE, because on
non-x86 targets PC_MACHINE(qdev_get_machine()) will crash.

>     What about the FW_CFG_DMA dependency?
> 

I wasted enough time on this so I'll stop reviewing this work.

Regards,

Phil.

