Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F45E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJjx-0003z3-JG; Thu, 19 Dec 2024 11:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOJjw-0003yq-JK
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:51:08 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOJju-0001QP-QG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:51:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so544552f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734627065; x=1735231865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bPt9RD/n21L80mrsXqcoiJ/QMHctQ7VEza37YY1LWvs=;
 b=TlEGR9krYgW9CckEo7xQhAqV1OQ83TIVgqZw1SmnYr8hwSqghFjKSpqzaOe9xCg6VF
 zuG2JRYiR78cu4wmqkXm81TPVdqc7wFFTzHEc0ANrMUE3UIcnOCQPNXjsfV9MX79/lm2
 kq6HHVo22sEqugN6JPtkDo3Tfk4GtkmboKG6ItbHywfObNgSCESOuyb4n7ulggfSYw1w
 1pAS/wx+K+mP3+1LNvSKT5Z8YJ3+MCiaVQ9r288BQRQNdOyGsgsctlbR2x5BDP40vVQN
 2Na53swtLLcQdTZqO2ZLFggxvUXaGsdXgtKh3ispLK1OWyaMz6babLa0m1pzzxtWIrN/
 jZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734627065; x=1735231865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPt9RD/n21L80mrsXqcoiJ/QMHctQ7VEza37YY1LWvs=;
 b=LW+DWHmqqu9z2IOArtg04okwzqoSxcrz7TUW64RvlhveszNCMfuj9YFKmjRw6qqImD
 0vtsCSQW7+tDq8rzRmdhonkkVS4P77GSiidzxB+woXBzXktSxgSymCZlDO8KbvThRvtu
 8n0ap4rwD9p8CckMkCiTpbM1mtQ2JYKPe+tQi9WfAywWYATwif6Z8AVTYLIUfiV8KO+6
 NOWaZdXsUMFoxnbpHgUGmTh3L46S92OvZCApzxldjEoVxsXsEr+H5XAXQ9N+xs7OhRHK
 q507H6v0sBplziZzEfdl4ndVm+QTL8Vc7X4r5z9BNLSshFOrazp012CtldOjW7BIHZe6
 PAyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEB0w8b/sc2kl+8Bvp44N9+ibAfSI/+Xo8W9W1Fegw93HgkEjsxwcfPSLzmMAOw67DO6EgUX/ALGL5@nongnu.org
X-Gm-Message-State: AOJu0Ywt9dHa1QMIwDiWkS9OYWkhRKpfB9pMarVsaj/0FhbMcn1XW+lg
 1BuaU1FEPxtxTgAcR9Ll/88PSw9DqGVrJvudZQ4AGb7dPGCkHd0wp82ha1S4t1o=
X-Gm-Gg: ASbGncvKz2DqOPA/o1fHgP1oU68XnsGGOPlU6H0EHGd423+T+paK7fdxfAOEVkZ3P6U
 JmACKmD40wq/gjCaUvKToP7IYdOpBeOHyqnVgH6Usv21PPwkV6oxrnwVQVv1gkRCxWHNnenNxHv
 UE5DWbzyMHUdDjq3Xm3ne2r4cj9VKVXQ2JHkxAUJI9nJdHOSa+i+N82vQ4UhLcTmxOE5zVIY77O
 /KBbeNxm2s1l9FCoJfnrorGhqmpeND+0nhgGfShHNoPJra2tMIe1ZkvrY6SQDQ/MKa3le8=
X-Google-Smtp-Source: AGHT+IHY+DkwlwNi8isfynOXubpL6W9QVsf2PW8IteFPicM4n0GIZLyuhqTYM8R5FKqTEQBpm1u8hA==
X-Received: by 2002:adf:9582:0:b0:38a:19a4:ca9e with SMTP id
 ffacd0b85a97d-38a19a4caacmr2899765f8f.29.1734627065194; 
 Thu, 19 Dec 2024 08:51:05 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4d7sm22464755e9.34.2024.12.19.08.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 08:51:04 -0800 (PST)
Message-ID: <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
Date: Thu, 19 Dec 2024 17:51:03 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 19/12/24 17:16, Ani Sinha wrote:
> 
> 
> On Thu, 19 Dec, 2024, 9:22 pm Philippe Mathieu-Daudé, <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 16/12/24 12:48, Ani Sinha wrote:
> 
>      > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>      > index d02d96e403..4c5bdb0de2 100644
>      > --- a/hw/misc/meson.build
>      > +++ b/hw/misc/meson.build
>      > @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA',
>     if_true: files('mac_via.c'))
>      >   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true:
>     files('mips_cmgcr.c', 'mips_cpc.c'))
>      >   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true:
>     files('mips_itu.c'))
>      >
>      > +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true:
>     files('vmfwupdate.c'))
> 
>     FW_CFG_DMA is offered by multiple targets ...:
> 
>     $ git grep -w FW_CFG_DMA
>     hw/arm/Kconfig:19:    select FW_CFG_DMA
>     hw/i386/Kconfig:82:    select FW_CFG_DMA
>     hw/i386/Kconfig:113:    select FW_CFG_DMA
>     hw/loongarch/Kconfig:22:    select FW_CFG_DMA
>     hw/riscv/Kconfig:59:    select FW_CFG_DMA
> 
>      > diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
>      > new file mode 100644
>      > index 0000000000..1e29a610c0
>      > --- /dev/null
>      > +++ b/hw/misc/vmfwupdate.c
>      > @@ -0,0 +1,157 @@
>      > +/*
>      > + * Guest driven VM boot component update device
>      > + * For details and specification, please look at docs/specs/
>     vmfwupdate.rst.
>      > + *
>      > + * Copyright (C) 2024 Red Hat, Inc.
>      > + *
>      > + * Authors: Ani Sinha <anisinha@redhat.com
>     <mailto:anisinha@redhat.com>>
>      > + *
>      > + * This work is licensed under the terms of the GNU GPL, version
>     2 or later.
>      > + * See the COPYING file in the top-level directory.
>      > + *
>      > + */
>      > +
>      > +#include "qemu/osdep.h"
>      > +#include "qapi/error.h"
>      > +#include "qemu/module.h"
>      > +#include "sysemu/reset.h"
>      > +#include "hw/nvram/fw_cfg.h"
>      > +#include "hw/i386/pc.h"
> 
>     ... however ...
> 
>      > +#include "hw/qdev-properties.h"
>      > +#include "hw/misc/vmfwupdate.h"
>      > +#include "qemu/error-report.h"
>      > +
>      > +static void fw_update_reset(void *dev)
>      > +{
>      > +    /* a NOOP at present */
>      > +    return;
>      > +}
>      > +
>      > +
>      > +static uint64_t get_max_fw_size(void)
>      > +{
>      > +    Object *m_obj = qdev_get_machine();
>      > +    PCMachineState *pcms = PC_MACHINE(m_obj);
>      > +
>      > +    if (pcms) {
>      > +        return pcms->max_fw_size;
> 
>     ... this code depends on x86/PC.
> 
>     Could it be wiser to add a new VM_FWUPDATE Kconfig
>     symbol, having it depending on FW_CFG_DMA && I386?
> 
> 
> There is no reason why vmfwupdate would be limited to x86 only. There is 
> minimal support needed from hypervisor side for this mechanism. That 
> mechanism has little dependency on specific platform.

OK, then please remove that PCMachineState use.

What about the FW_CFG_DMA dependency?


