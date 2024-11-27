Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1021D6ACEF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 16:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGKal-0002C7-Tp; Wed, 27 Nov 2024 11:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGKaj-00026F-Oq
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:08:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGKah-000567-Mj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 11:08:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3824709ee03so5055378f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 08:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732723713; x=1733328513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UV+6gAzfd8mCpCLEPYFJ8Olh2UYamIhOq1oCZybPIQA=;
 b=nDg9c/I0TV9PL86+juLBgTNvs6vcsL75Lo4GaU0aM0qxWHDpDCyTafWtC7Z10I6359
 r8rxMO5WMntuTy0fb4v6e5Qle7XJOSuOIN1ecZ3ZEjAjaHJRxbnlFrUopvRvzc7K2Ow8
 lIpHsLBiL4YXkwfppHxCR53nvJOYZyGySmj1O0MWIRltO3ZmSoFwvtXqcrVx5ecuJpwM
 OD/KA3rMt8dMeo2ckPbnHZD5cE4x6Rb67ZN6TYH/urRPGYyp6kvqdXVouvEgU4ed8DjX
 9afv1pSBOjxuJthD73h5xFSDMY2oSb9I5T7RH5SiJtSATcMzcGUnDYfEcoPTxePZ1faK
 CDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732723713; x=1733328513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UV+6gAzfd8mCpCLEPYFJ8Olh2UYamIhOq1oCZybPIQA=;
 b=SgaLz6nbz/POch+L2JILliMJuZx+sFkVVY43zu6gCIPzaIh8RRP5momyxxwmmBIHr+
 3R7s2YNNSTKWJHMCDJKUi3zPLWvnM6tAxBSUfyaJvwJV3WwhijXznvWsfR3GpNnV3BQ+
 jnjG5h+JeboEMIVCDlYGOoQk4jiMZkVH4QmjwFZTmPOFhG6Bqo7f9AGT4mHpXdJBV6yW
 V3kJts/+OqzgxotQGWIXbNP5g7X1FixVUFRx3mdgMnIzFjsCbfPTBC1oQYaQjPqSARgq
 /dqZs0FgXjtJc32boUyll0Zvels5Q5jYUs4rIoW1cGh8bOn1FmGq4Py+9Z0wIsSPGZn3
 DtBA==
X-Gm-Message-State: AOJu0Yzd3nUC5KaqQRUCBtV240fy946qvPKCtGKdP7+nqlATqlJTZSVA
 dslKbW2cvWRB26eZaAKt2KJNIDH6dQIv6w+lqD5PGi4cBtRSVodohvc7w4lKtAI=
X-Gm-Gg: ASbGnctOXMhP4jJzut+umQzKIUIHa2ePChC2ypwof+cJ+0N4JBtnWvXqYDDAbAgygSI
 4LAx26qH+cR6gNZmKlzFmui3nMJR62zK4+saAL1XZBiXvfzzDGwBKk8Ow//tjo9MAw1CIA6KreS
 qwvWfLFWthSkTgdLkn+RZ9KRCOAdYOmcuvhp2yDahmQjjwFGTWntlpveCFcWEfZEIJ5f8J+dxQZ
 G8fAIJbKdZ6uXTjpQRoHcXsK94D1T0XSKnSeO+oFptSxchA0Rg+p+JUFrUplD/yHKb2IuuoCAkE
 SsWWOQPn05sgEpGeiUDBGIw+hwI/rOvpBlbH
X-Google-Smtp-Source: AGHT+IGORJYJ5dXFPu04ama4dMmBTA9saMjvuKlHe+2b14skSaKzhNuuAct61BgtbrBeasEWo8CrIQ==
X-Received: by 2002:a5d:47cd:0:b0:382:2ba9:9d56 with SMTP id
 ffacd0b85a97d-385c6edc341mr3064808f8f.48.1732723712629; 
 Wed, 27 Nov 2024 08:08:32 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc4123sm17053193f8f.79.2024.11.27.08.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 08:08:32 -0800 (PST)
Message-ID: <c32ee498-4bc4-408a-bc28-ab21563bb2e3@linaro.org>
Date: Wed, 27 Nov 2024 17:08:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/2] generic-loader: Add a generic loader
To: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 Thomas Huth <thuth@redhat.com>
References: <cover.1475195078.git.alistair.francis@xilinx.com>
 <10f2a9dce5e5e11b6c6d959415b0ad6ee22bcba5.1475195078.git.alistair.francis@xilinx.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <10f2a9dce5e5e11b6c6d959415b0ad6ee22bcba5.1475195078.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi,

[very old patch merged as commit e481a1f63c93]

On 30/9/16 02:25, Alistair Francis wrote:
> Add a generic loader to QEMU which can be used to load images or set
> memory values.
> 
> Internally inside QEMU this is a device. It is a strange device that
> provides no hardware interface but allows QEMU to monkey patch memory
> specified when it is created. To be able to do this it has a reset
> callback that does the memory operations.
> 
> This device allows the user to monkey patch memory. To be able to do
> this it needs a backend to manage the datas, the same as other
> memory-related devices. In this case as the backend is so trivial we
> have merged it with the frontend instead of creating and maintaining a
> seperate backend.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---

> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> new file mode 100644
> index 0000000..79ab6df
> --- /dev/null
> +++ b/hw/core/generic-loader.c
> @@ -0,0 +1,211 @@
> +/*
> + * Generic Loader
> + *
> + * Copyright (C) 2014 Li Guang
> + * Copyright (C) 2016 Xilinx Inc.
> + * Written by Li Guang <lig.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + *
> + */
> +
> +/*
> + * Internally inside QEMU this is a device. It is a strange device that
> + * provides no hardware interface but allows QEMU to monkey patch memory
> + * specified when it is created. To be able to do this it has a reset
> + * callback that does the memory operations.
> +
> + * This device allows the user to monkey patch memory. To be able to do
> + * this it needs a backend to manage the datas, the same as other
> + * memory-related devices. In this case as the backend is so trivial we
> + * have merged it with the frontend instead of creating and maintaining a
> + * seperate backend.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/cpu.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/dma.h"
> +#include "hw/loader.h"
> +#include "qapi/error.h"
> +#include "hw/core/generic-loader.h"
> +
> +#define CPU_NONE 0xFFFFFFFF
> +
> +static void generic_loader_reset(void *opaque)
> +{
> +    GenericLoaderState *s = GENERIC_LOADER(opaque);
> +
> +    if (s->set_pc) {
> +        CPUClass *cc = CPU_GET_CLASS(s->cpu);
> +        cpu_reset(s->cpu);
> +        if (cc) {
> +            cc->set_pc(s->cpu, s->addr);
> +        }
> +    }
> +
> +    if (s->data_len) {
> +        assert(s->data_len < sizeof(s->data));
> +        dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len);
> +    }
> +}
> +
> +static void generic_loader_realize(DeviceState *dev, Error **errp)
> +{
> +    GenericLoaderState *s = GENERIC_LOADER(dev);
> +    hwaddr entry;
> +    int big_endian;
> +    int size = 0;
> +
> +    s->set_pc = false;
> +
> +    /* Perform some error checking on the user's options */
> +    if (s->data || s->data_len  || s->data_be) {
> +        /* User is loading memory values */
> +        if (s->file) {
> +            error_setg(errp, "Specifying a file is not supported when loading "
> +                       "memory values");
> +            return;
> +        } else if (s->force_raw) {
> +            error_setg(errp, "Specifying force-raw is not supported when "
> +                       "loading memory values");
> +            return;
> +        } else if (!s->data_len) {
> +            /* We cant' check for !data here as a value of 0 is still valid. */
> +            error_setg(errp, "Both data and data-len must be specified");
> +            return;
> +        } else if (s->data_len > 8) {
> +            error_setg(errp, "data-len cannot be greater then 8 bytes");

If s->data_len < 8 (like 4 or 2) ...

> +            return;
> +        }
> +    } else if (s->file || s->force_raw)  {
> +        /* User is loading an image */
> +        if (s->data || s->data_len || s->data_be) {
> +            error_setg(errp, "data can not be specified when loading an "
> +                       "image");
> +            return;
> +        }
> +        s->set_pc = true;
> +    } else if (s->addr) {
> +        /* User is setting the PC */
> +        if (s->data || s->data_len || s->data_be) {
> +            error_setg(errp, "data can not be specified when setting a "
> +                       "program counter");
> +            return;
> +        } else if (!s->cpu_num) {
> +            error_setg(errp, "cpu_num must be specified when setting a "
> +                       "program counter");
> +            return;
> +        }
> +        s->set_pc = true;
> +    } else {
> +        /* Did the user specify anything? */
> +        error_setg(errp, "please include valid arguments");
> +        return;
> +    }
> +
> +    qemu_register_reset(generic_loader_reset, dev);
> +
> +    if (s->cpu_num != CPU_NONE) {
> +        s->cpu = qemu_get_cpu(s->cpu_num);
> +        if (!s->cpu) {
> +            error_setg(errp, "Specified boot CPU#%d is nonexistent",
> +                       s->cpu_num);
> +            return;
> +        }
> +    } else {
> +        s->cpu = first_cpu;
> +    }
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    big_endian = 1;
> +#else
> +    big_endian = 0;
> +#endif
> +
> +    if (s->file) {
> +        if (!s->force_raw) {
> +            size = load_elf_as(s->file, NULL, NULL, &entry, NULL, NULL,
> +                               big_endian, 0, 0, 0, s->cpu->as);
> +
> +            if (size < 0) {
> +                size = load_uimage_as(s->file, &entry, NULL, NULL, NULL, NULL,
> +                                      s->cpu->as);
> +            }
> +        }
> +
> +        if (size < 0 || s->force_raw) {
> +            /* Default to the maximum size being the machine's ram size */
> +            size = load_image_targphys_as(s->file, s->addr, ram_size,
> +                                          s->cpu->as);
> +        } else {
> +            s->addr = entry;
> +        }
> +
> +        if (size < 0) {
> +            error_setg(errp, "Cannot load specified image %s", s->file);
> +            return;
> +        }
> +    }
> +
> +    /* Convert the data endiannes */
> +    if (s->data_be) {
> +        s->data = cpu_to_be64(s->data);
> +    } else {
> +        s->data = cpu_to_le64(s->data);

... and if we swap, we ignore the data-len and swap 64-bit
regardless, returning invalid data.

I.e. data=0x1122, data-len=2, once swapped we get data=0x0000.

Is that expected?

> +    }
> +}
> +
> +static void generic_loader_unrealize(DeviceState *dev, Error **errp)
> +{
> +    qemu_unregister_reset(generic_loader_reset, dev);
> +}
> +
> +static Property generic_loader_props[] = {
> +    DEFINE_PROP_UINT64("addr", GenericLoaderState, addr, 0),
> +    DEFINE_PROP_UINT64("data", GenericLoaderState, data, 0),
> +    DEFINE_PROP_UINT8("data-len", GenericLoaderState, data_len, 0),
> +    DEFINE_PROP_BOOL("data-be", GenericLoaderState, data_be, false),
> +    DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE),
> +    DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
> +    DEFINE_PROP_STRING("file", GenericLoaderState, file),
> +    DEFINE_PROP_END_OF_LIST(),
> +};


