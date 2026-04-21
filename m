Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320F4F94CB4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 22:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJDx-0000GB-1M; Tue, 21 Apr 2026 18:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJDt-0000Fv-Cq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:05:39 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJDq-0003Vl-4d
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 18:05:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so3951943f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 15:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776809132; x=1777413932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gkpsAIulqbgPPMzrQyDI5fyUTTUwuUJAvACIgetKr9M=;
 b=TiQxZYl8sAKyMrW5AO2PntOFNVeBp6hcud0htBHCWUaVNddLRU8w/Uei944L4TC83h
 +aKCaXColRJIhpsgpyrIVdCAf4cSDwaE+EeFTJopsCO4un7uWGGfEv/0Sm+YDPYMnGJN
 sf9CbttSZrjfn7j0FXWL0e16+WxtKWtp36sfTqKGrdducThcKPhXtjtqTthpPuwkfd6q
 QID6eeOdJujksIU5nJ4V1Gdb4MRyqwbMRF1eclj8jf/DVzpM2tylBVxFLqbzfpsEbh7D
 30CM5oc8JdgH8k2UawHp2tl3WVCeIkignzSACZDh+2MvtzD7abElKbcOO6qnQhzpyTc4
 S2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776809132; x=1777413932;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkpsAIulqbgPPMzrQyDI5fyUTTUwuUJAvACIgetKr9M=;
 b=TVPlecVYbEG5+AzTI/Wjkw++hEk7cy6SZQpeN+T4BEgreuj8FqWLhiPZjHBQw4tly/
 bBJDhsQY2QauSdWqhg9DxgDlRrjUacuxb9b1zJRzS8AuMz+lCA/H8zizvbeRk2ghwRhl
 Ixz5PMy0JnK6qdP+98DF4QRGG8dlxDf1X0u4U3FYf7c/hZYCqv4xPobrH7filS4jI13Y
 ri/Izg+/AN0L5w6qX0JSFxjvh/hoAWgPBNb3UAYl9y0jpZTqgYTqSE25bqu8VgWO9EXx
 iYr6kQOLFCOovMRRV3n3xioX66D6S/PPhjVqJzooXRCnEgvLCUzV+JEKPiTHPP3C8Zwy
 AnYQ==
X-Gm-Message-State: AOJu0Yw47Hv5XiVKstY4r7YG8wmf700CebLkM7fGIxwKIvAKvk3dMzY0
 FbmnZ0UXpSaaP2F6jNif9yGc1DhJj5Es1voJXHuyrmWQJMZywMMNgS1juZEnH0EwxE0=
X-Gm-Gg: AeBDies2y5a0crowOMHNyAQ0yefIsFwOvjtxBn5+Y+p7Dq5OZ3Wj3xSu+pTbBYcuk7l
 5iaU8FGNZ7aEHggf+T+yHg8PxQ1b+DqEt045ZF+tcxBACqg/p8DM/PpQKfieypzV1QXBuMi/dKA
 V8HZ82nkYqe20j3Im5wO3A+oeCL0IkoAr3PEUoUuGwRIbbordZajw0v5Lq1wNV7fBC36WTBbGHA
 RwrBIR29Q/CActNg3QVywhrorR067YyIXE3dfEfFvT2Ffov3jnLjLKH0AcYGzszC1x8j3pGqjK/
 NfZaCB4r7PKzWyohHLrpnlte8VKrDTloPyxE4HeaESjEBuftaK1/GGRaTJA3qCFb1GpWnOAnysC
 cOfBLA14eHUe6JDW1nak+oAfzQSHh7QMsXJsFsmnfRMZlFqxeUXdnGE+baJu8s7XvB4RTCkISy/
 DYS0GfSQ2EWpS49mbMLLUjg0LuZ2IIs1Ct6Khwgk0/25nL1cBUCiRjPtum4R6Msi++N021csiLg
 bfhKWyMR8WM6cA=
X-Received: by 2002:a05:6000:1a8d:b0:43c:f28b:8863 with SMTP id
 ffacd0b85a97d-43fe3dc7998mr31156349f8f.13.1776809131505; 
 Tue, 21 Apr 2026 15:05:31 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm45074923f8f.37.2026.04.21.15.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 15:05:30 -0700 (PDT)
Message-ID: <3a88f4f4-01c5-4db4-ac0e-0d9b76fa86b9@linaro.org>
Date: Wed, 22 Apr 2026 00:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] hw/hexagon: Define hexagon "virt" machine
Content-Language: en-US
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, bcain@quicinc.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org
References: <20260416210305.2255579-9-brian.cain@oss.qualcomm.com>
 <20260420145536.1198387-1-matheus.bernardino@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260420145536.1198387-1-matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 20/4/26 16:55, Matheus Tavares Bernardino wrote:
> On Thu, 16 Apr 2026 14:03:04 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
>> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
>> new file mode 100644
>> index 00000000000..ff93b5221ba
>> --- /dev/null
>> +++ b/hw/hexagon/virt.c
>> @@ -0,0 +1,456 @@
>> +/*
>> + * Hexagon virt emulation
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/hexagon/virt.h"
>> +#include "elf.h"
>> +#include "hw/char/pl011.h"
>> +#include "hw/core/clock.h"
>> +#include "hw/core/sysbus-fdt.h"
>> +#include "hw/hexagon/hexagon.h"
>> +#include "hw/hexagon/hexagon_globalreg.h"
>> +#include "hw/hexagon/hexagon_tlb.h"
>> +#include "hw/core/loader.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/core/qdev-clock.h"
>> +#include "hw/core/register.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/guest-random.h"
>> +#include "qemu/units.h"
>> +#include "elf.h"
> 
> nit: elf.h was already included above
> 
>> +#include "machine_cfg_v68n_1024.h.inc"
>> +#include "system/address-spaces.h"
>> +#include "system/device_tree.h"
>> +#include "system/reset.h"
>> +#include "system/system.h"
>> +#include <libfdt.h>
>> +
> [...]
>> +static void fdt_add_hvx(HexagonVirtMachineState *vms,
>> +                        const struct hexagon_machine_config *m_cfg,
>> +                        Error **errp)
>> +{
>> +    const MachineState *ms = MACHINE(vms);
>> +    uint32_t vtcm_size_bytes = m_cfg->cfgtable.vtcm_size_kb * 1024;
>> +    if (vtcm_size_bytes > 0) {
>> +        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_bytes,
>> +                               errp);
> 
> I was going to ask whether we should handle errp here and abort earlier, but
> fdt_add_hvx is always called with error_fatal, so that's fine. (I wonder, though,
> should we remove "Error **errp" from the function signature and use error_abort
> here directly, for clarity and future-proof?)

The current "unchecked &errp because single use in function" isn't
great because we could easily add a 2nd use (like another
memory_region_init_ram call) and overwrite the first &errp, ignoring
errors. So with that in mind your suggestion is better IMO.

> 
>> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base << 16,
>> +                                    &vms->vtcm);
>> +
>> +        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
>> +        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
>> +                                "qcom,hexagon_vtcm");
>> +
>> +        assert(sizeof(m_cfg->cfgtable.vtcm_base) == sizeof(uint32_t));
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
>> +                               m_cfg->cfgtable.vtcm_base << 16,
>> +                               vtcm_size_bytes);
>> +    }
>> +
>> +    if (m_cfg->cfgtable.ext_contexts > 0) {
>> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
>> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
>> +                                "qcom,hexagon-hvx");
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts",
>> +                               m_cfg->cfgtable.ext_contexts);
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
>> +                               m_cfg->cfgtable.hvx_vec_log_length);
>> +    }
>> +}


