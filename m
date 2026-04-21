Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C41F94CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJIg-0001pu-OW; Tue, 21 Apr 2026 18:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJIe-0001pd-Uj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:10:32 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJId-0004o5-3P
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:10:32 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3259519f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776809429; x=1777414229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hBfp111kzpsEJBN7X1qv7RTDfkwE+yPkYWE/nlf8OXs=;
 b=TEXpB1mSHcxFghajkC3v/YXA6OOskzOGtgWkET76AXYpqSxBCQ+2SNzYveK/iLQCDR
 Fi6SbpIEi4+mvgIM/5UI4+SOpPU2njcIvAxSlLkPTyEtY0xfAhdL+Caj0IhoM5DeJueP
 CS1a4TgTW9e4EZgXvkG8pW/CNrkTUskYxD3bfyl0kC2mLtYlSU9etghik8hFaYKYOlI3
 97o2Fy1ZWlqDl+4OL19mm4cV88VUz0UDjyKxSFuLVNEZ27X/AFvoUQUk/7/lXPO0UFTo
 sr9+Zk2xkTzujYkaIZ0JvRSk30lyPmYfwiImxXkXpD3PQSyEJUv3fKn8GTLLg6dny7FS
 qJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809429; x=1777414229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBfp111kzpsEJBN7X1qv7RTDfkwE+yPkYWE/nlf8OXs=;
 b=smQFHf5jeDp4zCQMxDbaUeuMkjd8uxfp2oSePqO3C1nKrNz+5DVbj/xaefjpxjwV6F
 EmiVxM4wnubAt7qJfOJp8uVsybmKaRNKPHbZ7HlPDARhYTJilawAow67/ULbZIyRBQqB
 HzdzF8Xy2Zz/FHq8XsN4tFnCLd1HPTeY1BsOlngzD9Qf55dm/ZguTs+XDPy9UsNQU+DB
 lutNtNyj0AfOJuceSGDzu4zo4hqxb7vRqBgLI69MmkZy2I6bFLbpAO0BzQAf0NfA7viP
 hBGJjgY2TkFaKl5wj9tIEI0JrW6LDBr9xez6dBLYB4S98tIjNdk6QnEFTv4JRI/+9c4T
 AncQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MXDmNv1GpzKHUS79rbO9imjPCqO1Ps+FodZAQW6h04tOSO2Xi0W9va9QXjHrqwyalyYSL0qNLOeQA@nongnu.org
X-Gm-Message-State: AOJu0YyQTqqcYHu0LxIWJ7j+A9WHGhWNMSCeKeBGhj63C70OqL2MQNGL
 xIze4HwHRR9FJeJvg3sIU9z5e9m3lTsk/p0p1MMJzxdD35G7wDPnDhNYi3EALR26W4M=
X-Gm-Gg: AeBDiesdkLtrLxFb2QRwJDJdDJVRbLAProvP4PU7LK6U5538nAEJyPyJZ7ZH057idR3
 s/Ith7v8mIJKOOtOqcdR8c61gcqCkqEmkjAeOQSzXkPyrI09YPqPmUKh4bQ6vjpI30elYZBZmI8
 TJoBwBzjbX9d2CNeM5fCym8tdK2YYlZlc9LOiGMJAmtefgjuFEJD2yUSKEX85bbfaNEJOxOOjJ/
 fmrG32/NSyTqMO+KRaoB7DQDuWsPsw1X+HIPhA5Rsyc0eY6ULXgD7N/0nLjmuss0ZyEQx5Oua9h
 wS/2CUmyeh+SHTZfJWjo9cti2b6ecepPpT9MnNmYtBpIxkEH1xlpC2xrZvQXtt5tPNDoieuV6Z9
 wHbWU6Lm7KLRgsXg0zALAoVKBMuw8eCZiFBjuz/pF6qT7Ca+3lvKwmzd5Ojg/SwB6ft0Z8ufIXv
 fnIHh98Hspuul5BpEWbfLl2h0oIse0212emjILE6ALUlgX3wwiBvmvh3hjIaC9l4Pyw+sht9bTM
 P1Z
X-Received: by 2002:a05:6000:2883:b0:441:23d2:5aa9 with SMTP id
 ffacd0b85a97d-44123d25b20mr2174169f8f.8.1776809429303; 
 Tue, 21 Apr 2026 15:10:29 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm11321010f8f.1.2026.04.21.15.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
Message-ID: <62ff0065-b504-4f2c-93ef-745d00326e52@linaro.org>
Date: Wed, 22 Apr 2026 00:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/hexagon: Define hexagon "virt" machine
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 23:03, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   configs/devices/hexagon-softmmu/default.mak |   1 +
>   configs/targets/hexagon-softmmu.mak         |   1 +
>   include/hw/hexagon/virt.h                   |  43 ++
>   hw/hexagon/virt.c                           | 456 ++++++++++++++++++++
>   target/hexagon/cpu.c                        |   2 +
>   hw/hexagon/Kconfig                          |  10 +
>   hw/hexagon/meson.build                      |   2 +
>   tests/qemu-iotests/testenv.py               |   1 +
>   8 files changed, 516 insertions(+)
>   create mode 100644 include/hw/hexagon/virt.h
>   create mode 100644 hw/hexagon/virt.c


> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
> new file mode 100644
> index 00000000000..a54eac5cf00
> --- /dev/null
> +++ b/include/hw/hexagon/virt.h
> @@ -0,0 +1,43 @@
> +/*
> + * Definitions for hexagon virt board.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGONVIRT_H
> +#define HW_HEXAGONVIRT_H
> +
> +#include "hw/core/boards.h"
> +#include "target/hexagon/cpu.h"
> +
> +struct HexagonVirtMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    int fdt_size;
> +    MemoryRegion *sys;
> +    MemoryRegion cfgtable;
> +    MemoryRegion ram;
> +    MemoryRegion tcm;
> +    MemoryRegion vtcm;
> +    MemoryRegion bios;
> +    DeviceState *l2vic;
> +    Clock *apb_clk;
> +};


> +#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)
> +
> +#endif /* HW_HEXAGONVIRT_H */
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> new file mode 100644
> index 00000000000..ff93b5221ba
> --- /dev/null
> +++ b/hw/hexagon/virt.c


> +static int32_t irq_hvm_ic_phandle = -1;

Why not store in HexagonVirtMachineState?

> +static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
> +                                 const struct hexagon_machine_config *m_cfg)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    irq_hvm_ic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
> +                          irq_hvm_ic_phandle);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#address-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#interrupt-cells", 2);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller", "compatible",
> +                            "qcom,h2-pic,hvm-pic");
> +    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
> +                     "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandle",
> +                          irq_hvm_ic_phandle);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +}

