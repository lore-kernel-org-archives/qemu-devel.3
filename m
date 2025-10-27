Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D61CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOOT-0005Va-Ec; Mon, 27 Oct 2025 10:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDOO9-0005PA-7l
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:40:01 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDONq-0007ex-OI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:39:51 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63bcfcb800aso5320892d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761575978; x=1762180778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8r60OYjkD09bXSru1IKURSEzxTgyDH/aBjKroqNXzR4=;
 b=Vs4Mw5DoqGbXcMMXRbeKzA1BuhmThXFi1hrkD3KPInOPCPXan5Gn9CYthonJybf1UU
 I39fCbJgKh2v9QGJPjOvfVvkHTmC5o9Oa7abNbuRjrywJhrOK3D3KzLd3iNT4yud1GC7
 FLUz0VV6fZ2H99xfKcqJ7SWaFtzMGARdjpjjLjBLti1pFa8MnMPhMBDzFJSE8yTBk7iZ
 GJsKf1pSkzsrZRx+73oLcdqZtp+qyi/JRlCYqjgNn2BKDNw4lkPRo0Rz1UsVkSrCr7PG
 bQQi8brXTX6Qp0/9D305Uh3NnPEdXDKpZaqHU63JwUAfAaaXhI2B0GR56d0Tq9+O3wjf
 0R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575978; x=1762180778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8r60OYjkD09bXSru1IKURSEzxTgyDH/aBjKroqNXzR4=;
 b=pcERPYNb8ehx0dgzah+xXSPWn1Pz4jmxDf0JeTtws+egmjEAFzr1he/1Q6v4RxECi2
 uxKvs8fxv5BPTTFyLJNt0beJF548d+mQCVnIOa2LMECclqWEmCD95Q21N2mk4xTyEvEX
 ylTk5RuKHpTpoZhYBCLIy1Gr/54/YUPuCAcgENWKZkN8K5WZa3NcwOOsbCn69zv/DTrM
 2pTQQlEUwKMnvQaN4auClrk7SmmNU/G73sQORaqGC+GYqB43IfeV6LHqTqtG66ggSo/6
 mY3hLTP3//5exY6/J+oTljjJYFueUy7ZbhNkfJOTHgFtC17S9LQAs2v2icZqWGvsi0Ws
 0niA==
X-Gm-Message-State: AOJu0YymwNZ80qOdWVHMiOeXi6tFy8lTJijYWLCkgNfEWBsQNmQO/1Qe
 4gOkwF77IAQkYfjjfKkB2hsUT61dbkkwSQkSedv2Iub32m3E2ogyoo8vJoMGo3mCwGP4ZXOGq3W
 BUDLVall6Rxb4OkPYSBdpny/EAMCyLihkJDamGXXjHJt6jF1UxvZl
X-Gm-Gg: ASbGncvoxfFwcm/11y6yRdhEiOxu//YYsKjEXWdZZfJp1KcP7DSbrGfEeZwir3aFese
 lkfpRs8/8r+rdB/+mXGvL3c7UUv6j737C+Xf1NX9X8F8HdC2WPSsdDLFtnAr4YdnDNMNZY5ZhpU
 Sp3GJ/+9aGwfjVRu1LlOk9BO9856swWG85Lb33W7ZiTn/byHlWXt9uYJtHKfJLUFV1P6h4b0Nuq
 ej+KI1B+AppJY8dxYA2UPdZijMzWlSDQgxLw4sDtYUYcNPVL7PNNzkwuam99g==
X-Google-Smtp-Source: AGHT+IGPRNQC8IiXbOPaslTuy/EfKr+wbPAuxB/4HPJnA5qjqky30kkC2x8W8P2P/JIH/6+HVZR7ANGJ9IEuWeJsku0=
X-Received: by 2002:a05:690e:15da:b0:63e:3211:9397 with SMTP id
 956f58d0204a3-63f6b9d2b0cmr222144d50.23.1761575977591; Mon, 27 Oct 2025
 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
 <20251026105320.5591-4-fanyihao@rt-thread.org>
In-Reply-To: <20251026105320.5591-4-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 14:39:25 +0000
X-Gm-Features: AWmQ_bkQ7rZs5fTeWnudJIsbvVpRu_NHjD5gt97xRhCT5yNW16QUvaYSBBVmlRY
Message-ID: <CAFEAcA_yA3r7gMEMm51gfQyU-8nGOkY10Qin-eq1OMsXgrwwvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/arm/stm32f407: Add PWR device to stm32f407 SoC
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Sun, 26 Oct 2025 at 10:53, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> Add the Power supply configuration device to the stm32f407 SoC.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>

Please put "implement new device" and "add new
device to SoC model" in separate patches.

> --- /dev/null
> +++ b/hw/misc/stm32f4xx_pwr.c
> @@ -0,0 +1,111 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * Copyright (c) liang yan <yanl1229@rt-thread.org>
> + * Copyright (c) Yihao Fan <fanyihao@rt-thread.org>
> + * The reference used is the STMicroElectronics RM0090 Reference manual
> + * https://www.st.com/en/microcontrollers-microprocessors/stm32f407-417/documentation.html
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/misc/stm32f4xx_pwr.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/module.h"
> +#include "migration/vmstate.h"
> +#include "qemu/module.h"
> +
> +#ifndef STM32F4XX_PWR_DEBUG
> +#define STM32F4XX_PWR_DEBUG 0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (STM32F4XX_PWR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt, __func__, ## args); \
> +    } \
> +} while (0);
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)

No debug print macros in new code, please. Use tracepoints
or qemu_log* calls as appropriate.

> +
> +static uint64_t stm32f4xx_pwr_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    STM32F4XXPwrState *s = opaque;
> +
> +    switch (offset) {
> +    case PWR_CR:
> +        return s->pwr_cr;
> +    case PWR_CSR:
> +        return s->pwr_csr;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "STM32F4XX PWR: Bad read offset 0x%lx\n", offset);
> +        return 0;
> +    }
> +}
> +
> +static void stm32f4xx_pwr_write(void *opaque, hwaddr offset, uint64_t value, unsigned size)
> +{
> +    STM32F4XXPwrState *s = opaque;
> +
> +    switch (offset) {
> +    case PWR_CR:
> +        s->pwr_cr = value;
> +        if (value & PWR_CR_ODEN)
> +            s->pwr_csr |= PWR_CSR_ODRDY;

QEMU coding style requires braces on all if() bodies,
even one-line ones.

> +        if (value & PWR_CR_ODSWEN)
> +            s->pwr_csr |= PWR_CSR_ODSWRDY;

The reference manual says that the ODEN and ODSWEN
bits in PWRCR are only there for STM32F42xxx and
STM32F43xxx. I thought this model was for the STM32F407xx ?

> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "STM32F4XX PWR: Bad write offset 0x%lx\n", offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps stm32f4xx_pwr_ops = {
> +    .read = stm32f4xx_pwr_read,
> +    .write = stm32f4xx_pwr_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void stm32f4xx_pwr_init(Object *obj)
> +{
> +    STM32F4XXPwrState *s = STM32F4XX_PWR(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &stm32f4xx_pwr_ops, s, TYPE_STM32F4XX_PWR, 0x400);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static void stm32f4xx_pwr_reset(DeviceState *dev)
> +{
> +    STM32F4XXPwrState *s = STM32F4XX_PWR(dev);
> +
> +    s->pwr_cr  = 0x0000;
> +    s->pwr_csr = 0x0000;

Just "0" will do.

The reference manual says the reset value for
PWR_CR.VOS is 1.

> +}
> +
> +static void stm32f4xx_pwr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_legacy_reset(dc, stm32f4xx_pwr_reset);

This is missing a VMStateInfo for migration support.

> +}
> +
> +static const TypeInfo stm32f4xx_pwr_info = {
> +    .name          = TYPE_STM32F4XX_PWR,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(STM32F4XXPwrState),
> +    .instance_init = stm32f4xx_pwr_init,
> +    .class_init    = stm32f4xx_pwr_class_init,
> +};
> +
> +static void stm32f4xx_pwr_register_types(void)
> +{
> +    type_register_static(&stm32f4xx_pwr_info);
> +}

thanks
-- PMM

