Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D213C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wumKB-0007Mf-8w; Fri, 14 Aug 2026 03:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumK3-0007Dx-Mm
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:27:23 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumJz-0007az-Nu
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:27:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-836d2861a39so8894827b3.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 00:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786692413; cv=none;
 d=google.com; s=arc-20260327;
 b=Id5B0IxExzalI/OldPNBqPeuKjbDYDBFt/opl6xBwdLP8N58yiP39Xy3+2H5SlQZAk
 F4CSvezbYYmsAIapuRd9aig0O2+dN2/dhP/VNaUjnAP3e7tyTYD14oT2z+Bb5v96ichY
 7b3mc++PQqc8YdDUsIcfA1OooLacPts2kPCg2Jyy7ZwttKR+08x/V6rjpOk/2LPwMwI1
 C2xMbSVFGmwS4XRakgiVNxOJUQjC22G7bqRa4wuPXFXoP6RpRHmSY1Q9pobic5fxuOto
 FDILII1txGK5cpHYAZ9C2SSvh/0v+MG9cb2WbhX6o1dYCA7XG8kOtKA6jXdNmGpjM89a
 UH5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WF3Drc9kIdYRs62WQMrpxOYSbCfPtnH5ltBAYPRgpfU=;
 fh=HQ1EXcXDn9Z+gPFhfegHkm9nul1yTEUa3QqRcdtNge0=;
 b=r4wpHSfoqpHRl5da/hOSbn79gg/U0qXiGcRzynXmxf5HzH7IhAXO8HTTbbhh7gvUtC
 gQMWTzlWjUU8pi+4s9Edsaq/77eVYncq2C91ax3GlX3eg2oIi0IjzznZfY82DsoAFGhE
 TYSy93Uu3NCKENIm/j0zCiDH9U2oEuky802lwQVCgJiPyOr7Tm4TsxZ72vEckZ/Od86t
 ZslY1AkcDeQcc+e2yMq7JOLsiQ8PdCezmlqUBnDlEwmGZHjl4oc4ZXnYLCG9pUVJC8im
 uku2pFjolSOCjMuneEmKuD/5AZS2NPD0ngRIwvmD2Cg8xtgIh7v6PEx1zr0Hh1V8ekd6
 9Q1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786692413; x=1787297213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WF3Drc9kIdYRs62WQMrpxOYSbCfPtnH5ltBAYPRgpfU=;
 b=p8d4UrUbVoZRp2zrPqdZxX4238iSU7YB3khCCNgyA9xL8aNPhh7iH6Za1yeZuvJOvZ
 Kz1+hq76nimq3XR4UAok3Nvd0OIKccMCjuYA9yLmOAVWLVJ7tTf5YqLspmavej52BYvv
 OltjCvTa2iTS8yJgnLmmt1nXa1yaKRexVEA+awOv87r1TH6vCFEqWwxYHU9ZVDSiftXu
 yTVFJcColqRYa9Q6pvdYx8Z2E+zdanpn6B8vfjMQyGZW32oKavsCUSjbXFsRKthzHQBA
 jUeSag05607yrfvoobqlkfkBm/MWzOIiyifCyz7X4ZcJ09pPE5egM7EgMwRGIqrCgYqI
 bHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786692413; x=1787297213;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WF3Drc9kIdYRs62WQMrpxOYSbCfPtnH5ltBAYPRgpfU=;
 b=sBIUEZcd3CfuchWkxBb3F3e8za716uM+jlO8HvKhLXzt/dJZHaptcoFD5W9kCXBUiR
 hK+034Ruqj8b6megvsd/TowfA+KPqMRnVsT5ePYYsKHVEuO2sUhUGkW7J+cJYiH4jjEt
 ZJ8OrDDdoxpWRwRqsUWeNQnlSaAaM1uTtEkYIEL4NSetBN9oZBtX0nw0LUaJUpiLHbqe
 2F3SlfqKEUf7aYkNyD2mk5ML46/+PVLjbrLB+zkqiFH4MO0PJCxEjY1fqXuPG+5CS+dC
 LqGu0e0Jw1ItqsgdNOiFmYcoxEezh5R4GjSs2kXYHyoXUQ06t+ri7vYwgREXFyTKN+Ot
 iKfA==
X-Gm-Message-State: AOJu0YybCQF8KmqrWx+ktf7VSeoEpOXEaDmPTdo7c2moomQVmWaBOFd0
 fGkPOIFUHUFSMaETlF0ndowbd1RmLettODXF3j9l1Z18sWPyu4jtj94nyuCwoCA6EbIaaRyH8oj
 ma5BKoLSBn7I6hkdHPh9K+xmTVlTIXzU=
X-Gm-Gg: AR+sD13AdPv6f27/+1zPVDXo3LjMNaM+Kd5R/9LFWtiUgUKiPf6ouAez1/6z3f291pp
 xf088mEGMzNJt/A67zelk5POMrIc3vCW0B/OCeBFRuCYl7HOp6O4YiuPsPCPGssyC8oTkgL+U62
 dgs4I6yiO7AR1zpduYtmdxludB/cFbfT+MnskQSTaaLVmQHiFH8pVxZea+lb3CsohWDduVlRYUo
 j9bhbkoS3tFEPrB78qI7GUIdaAAthth9ny/JW+dyXwsYj4kSeBnwW3nRk61V4XOSZCQ24abrhgN
 +DhnIzytGgs6803ngsp0IKNvK0QfnFvfil1HtDHQmKN0
X-Received: by 2002:a05:690c:ec5:b0:814:585f:73c8 with SMTP id
 00721157ae682-83708aaec72mr15400477b3.0.1786692413049; Fri, 14 Aug 2026
 00:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_EF996EEB2215272639C89FAE1491CEF43908@qq.com>
 <be7afd5c-55dd-4af1-b828-9a2f401e3bfc@smtp-relay.sendinblue.com>
In-Reply-To: <be7afd5c-55dd-4af1-b828-9a2f401e3bfc@smtp-relay.sendinblue.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 15:26:41 +0800
X-Gm-Features: AUfX_mzTeDKBzCaGMVJxvkWtwLKr1wfUN7N-vn2NGgTW2ItqZOaZmANziMtNMi0
Message-ID: <CAEUhbmWjR3cc4jkdBAqpXcmt9z3ExHWsPzCthX7d+G1wgqTbTQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] hw/gpio: add K230 GPIO controller model
To: guochun wang <guochun.wang@foxmail.com>
Cc: qemu-devel@nongnu.org, chao.liu@processmission.com, pbonzini@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Aug 10, 2026 at 4:02=E2=80=AFAM guochun wang <guochun.wang@foxmail.=
com> wrote:
>
>
> Implement a K230 SoC APB GPIO controller model for QEMU, derived from
> the Synopsys DesignWare APB GPIO (the Linux gpio-k230 driver is based
> on gpio-dwapb.c and shares the same register layout), with a
> Canaan-specific compatible ("canaan,k230-apb-gpio") and hardlock
> integration. The model is capable of running the Linux gpio-k230 driver
> and driving external input/output lines. Behaviour follows the K230
> Technical Reference Manual v0.3.1.

Please split the k230_gpio model into 2 separate models:

- One is generic Synopsys DesignWare GPIO IP model
- Optional Canann K230 specific wrapper glue model to the dw-gpio IP
(if the generic Synopsys DesignWare GPIO IP model, or plus some unimp
region, is good enough to make the software happy, no need to create
this one)

>
> Implemented:
>   - Port A registers: SWPORTA_DR/DDR/CTL, EXT_PORTA, INTEN, INTMASK,
>     INTTYPE_LEVEL, INT_POLARITY, INTSTATUS, RAW_INTSTATUS, DEBOUNCE,
>     LS_SYNC, INT_BOTHEDGE, PORTA_EOI, ID_CODE, VER_ID_CODE,
>     CONFIG_REG1/2
>   - Software control mode: DR drives output pad, DDR selects direction,
>     EXT_PORTA multiplexes external input vs. DR by DDR
>   - Per-pin IRQ output lines (single interrupt scheme), 32 per group
>   - Edge detection: rising / falling / both-edge via INT_BOTHEDGE
>   - Level-sensitive interrupts: active-high / active-low
>   - PORTA_EOI clears edge interrupts only; level interrupts cleared by
>     source removal or INTMASK
>   - INTMASK masking and INTEN gating
>   - DDR/CTL mode switching: no new interrupts while output/hardware mode,
>     pending interrupts preserved; on switch back to input/software mode,
>     level interrupts re-evaluated against current ext level, edge left
>     untouched, per TRM v0.3.1
>   - Three-phase Resettable API (enter/hold); VMState migration
>
> Not implemented (no observable effect under QEMU):
>   - Hardware control mode (aux_porta_out/en/in signals, single-ctl params=
)
>   - Debounce logic (dbclk, glitch filtering, both-edge debounce timing)
>   - Combined interrupt output (gpio_intr_flag OR of all lines)
>   - Clock-domain synchronization (pclk_intr, ls_sync metastability
>     registers, gpio_intrclk_en output)
>   - Config-time parameters GPIO_PA_SYNC_EXT_DATA / GPIO_PA_SYNC_INTERRUPT=
S
>     / GPIO_INT_BOTH_EDGE / GPIO_PORTX_SINGLE_CTL
>
> Two controllers are instantiated in the K230 SoC (gpio0 at 0x9140B000,
> gpio1 at 0x9140C000), replacing the previous unimplemented-device
> placeholders. Each controller exposes 32 per-pin IRQ lines connected
> to the PLIC:
>   - GPIO0: PLIC sources 32..63
>   - GPIO1: PLIC sources 64..95

Please split the integration of the GPIO device to the K230 machine
out of this patch.

>
> Signed-off-by: guochun wang <guochun.wang@foxmail.com>
> ---
>  MAINTAINERS                 |   2 +
>  hw/gpio/Kconfig             |   3 +
>  hw/gpio/k230_gpio.c         | 362 ++++++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build         |   1 +
>  hw/riscv/Kconfig            |   1 +
>  hw/riscv/k230.c             |  27 ++-
>  include/hw/gpio/k230_gpio.h |  71 +++++++
>  include/hw/riscv/k230.h     |   5 +
>  8 files changed, 466 insertions(+), 6 deletions(-)
>  create mode 100644 hw/gpio/k230_gpio.c
>  create mode 100644 include/hw/gpio/k230_gpio.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..4301d29f7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1827,8 +1827,10 @@ M: Chao Liu <chao.liu@processmission.com>
>  L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: docs/system/riscv/k230.rst
> +F: hw/gpio/k230_gpio.c
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
> +F: include/hw/gpio/k230_gpio.h
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
>  F: tests/functional/riscv64/test_k230.py
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index a209294c20..2d37a8bb6f 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -16,6 +16,9 @@ config SIFIVE_GPIO
>  config STM32L4X5_GPIO
>      bool
>
> +config K230_GPIO
> +    bool
> +
>  config PCA9552
>      bool
>      depends on I2C
> diff --git a/hw/gpio/k230_gpio.c b/hw/gpio/k230_gpio.c
> new file mode 100644
> index 0000000000..9d27f0bbfd
> --- /dev/null
> +++ b/hw/gpio/k230_gpio.c
> @@ -0,0 +1,362 @@
> +/*
> + * QEMU K230 GPIO Controller
> + *
> + * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPI=
O
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_T=
echnical_Reference_Manual_V0.3.1_20241118.pdf
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/gpio/k230_gpio.h"
> +#include "hw/core/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +
> +static void k230_gpio_update_int(K230GPIOState *s)
> +{
> +    uint32_t masked_status =3D s->raw_intstatus & ~s->intmask & s->inten=
;
> +    for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        if (s->irq[i]) {
> +            qemu_set_irq(s->irq[i], extract32(masked_status, i, 1));
> +        }
> +    }
> +}
> +
> +static void k230_gpio_set_int_line(K230GPIOState *s, int line, int level=
)
> +{
> +    if (line >=3D K230_GPIO_PINS_PER_GROUP) {
> +        return;
> +    }
> +
> +    uint32_t prev_level =3D extract32(s->ext_porta, line, 1);
> +    uint32_t curr_level =3D level;
> +
> +    s->ext_porta =3D deposit32(s->ext_porta, line, 1, curr_level);
> +
> +    if (extract32(s->swporta_ddr, line, 1)) {
> +        return;
> +    }
> +
> +    if (extract32(s->swporta_ctl, line, 1)) {
> +        return;
> +    }
> +
> +    uint32_t pol =3D extract32(s->int_polarity, line, 1);
> +    uint32_t both =3D extract32(s->int_bothedge, line, 1);
> +    uint32_t is_level =3D !extract32(s->inttype_level, line, 1);
> +
> +    if (both) {
> +        if (prev_level !=3D curr_level) {
> +            s->raw_intstatus |=3D (1U << line);
> +        }
> +    } else if (is_level) {
> +        if (curr_level =3D=3D pol) {
> +            s->raw_intstatus |=3D (1U << line);
> +        } else {
> +            s->raw_intstatus &=3D ~(1U << line);
> +        }
> +    } else {
> +        if (prev_level !=3D curr_level && curr_level =3D=3D pol) {
> +            s->raw_intstatus |=3D (1U << line);
> +        }
> +    }
> +}
> +
> +static void k230_gpio_set(void *opaque, int line, int level)
> +{
> +    K230GPIOState *s =3D K230_GPIO(opaque);
> +
> +    k230_gpio_set_int_line(s, line, level);
> +    k230_gpio_update_int(s);
> +}
> +
> +static void k230_gpio_set_all_output_lines(K230GPIOState *s)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        if (extract32(s->swporta_ddr, i, 1) && s->output[i]) {

This should check the CTL bit too, like:
if (extract32(s->swporta_ddr, i, 1) && !extract32(s->swporta_ctl, i,
1) && s->output[i])

> +            qemu_set_irq(s->output[i], extract32(s->swporta_dr, i, 1));
> +        }
> +    }
> +}
> +
> +static uint64_t k230_gpio_read(void *opaque, hwaddr offset, unsigned siz=
e)
> +{
> +    K230GPIOState *s =3D K230_GPIO(opaque);
> +
> +    switch (offset) {
> +    case K230_GPIO_SWPORTA_DR:
> +        return s->swporta_dr;
> +    case K230_GPIO_SWPORTA_DDR:
> +        return s->swporta_ddr;
> +    case K230_GPIO_SWPORTA_CTL:
> +        return s->swporta_ctl;
> +    case K230_GPIO_INTEN:
> +        return s->inten;
> +    case K230_GPIO_INTMASK:
> +        return s->intmask;
> +    case K230_GPIO_INTTYPE_LEVEL:
> +        return s->inttype_level;
> +    case K230_GPIO_INT_POLARITY:
> +        return s->int_polarity;
> +    case K230_GPIO_INTSTATUS:
> +        return s->raw_intstatus & ~s->intmask;
> +    case K230_GPIO_RAW_INTSTATUS:
> +        return s->raw_intstatus;
> +    case K230_GPIO_DEBOUNCE:
> +        return s->debounce;
> +    case K230_GPIO_EXT_PORTA:
> +        return (s->ext_porta & ~s->swporta_ddr) |
> +               (s->swporta_dr & s->swporta_ddr);
> +    case K230_GPIO_LS_SYNC:
> +        return s->ls_sync;

Bits 1:31 are reserved and should read as zero.

> +    case K230_GPIO_ID_CODE:
> +        return s->id_code;
> +    case K230_GPIO_INT_BOTHEDGE:
> +        return s->int_bothedge;
> +    case K230_GPIO_VER_ID_CODE:
> +        return s->ver_id_code;
> +    case K230_GPIO_CONFIG_REG2:
> +        return s->config_reg2;
> +    case K230_GPIO_CONFIG_REG1:
> +        return s->config_reg1;
> +    case K230_GPIO_PORTA_EOI:
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0=
x%"
> +                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset=
);
> +        return 0;
> +    }
> +}
> +
> +static void k230_gpio_write(void *opaque, hwaddr offset, uint64_t value,
> +                            unsigned size)
> +{
> +    K230GPIOState *s =3D K230_GPIO(opaque);
> +    uint32_t curr_level, pol;
> +
> +    switch (offset) {
> +    case K230_GPIO_SWPORTA_DR:
> +        s->swporta_dr =3D value;
> +        k230_gpio_set_all_output_lines(s);
> +        break;
> +    case K230_GPIO_SWPORTA_DDR: {
> +        uint32_t prev_ddr =3D s->swporta_ddr;
> +        s->swporta_ddr =3D value;
> +        k230_gpio_set_all_output_lines(s);
> +        for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            /* Skip pins whose direction did not change */
> +            if (extract32(prev_ddr, i, 1) =3D=3D extract32(s->swporta_dd=
r, i, 1)) {
> +                continue;
> +            }
> +            /*
> +             * When switching back to input mode (and still in software
> +             * control), re-evaluate level-sensitive interrupts. Edge
> +             * interrupts are left untouched, matching the manual TRM v0=
.3.1.
> +             */
> +            if (extract32(s->swporta_ddr, i, 1) ||
> +                extract32(s->swporta_ctl, i, 1) ||
> +                extract32(s->inttype_level, i, 1)) {

Should we test s->int_bothedge here? e.g.:
(extract32(s->inttype_level, i, 1) || extract32(s->int_bothedge, i, 1))

> +                continue;
> +            }
> +
> +            curr_level =3D extract32(s->ext_porta, i, 1);
> +            pol =3D extract32(s->int_polarity, i, 1);
> +            if (curr_level =3D=3D pol) {
> +                s->raw_intstatus |=3D (1U << i);
> +            } else {
> +                s->raw_intstatus &=3D ~(1U << i);
> +            }
> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    }
> +    case K230_GPIO_SWPORTA_CTL: {
> +        uint32_t prev_ctl =3D s->swporta_ctl;
> +        s->swporta_ctl =3D value;
> +        for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            /* Skip pins whose control mode did not change */
> +            if (extract32(prev_ctl, i, 1) =3D=3D extract32(s->swporta_ct=
l, i, 1)) {
> +                continue;
> +            }
> +            /*
> +             * When switching back from hardware to software control (an=
d DDR
> +             * is input), re-evaluate level-sensitive interrupts. Edge
> +             * interrupts are left untouched, matching the manual TRM v0=
.3.1.
> +             */
> +            if (extract32(s->swporta_ddr, i, 1) ||
> +                extract32(s->swporta_ctl, i, 1) ||
> +                extract32(s->inttype_level, i, 1)) {

Should we test s->int_bothedge here? e.g.:
(extract32(s->inttype_level, i, 1) || extract32(s->int_bothedge, i, 1))

> +                continue;
> +            }
> +
> +            curr_level =3D extract32(s->ext_porta, i, 1);
> +            pol =3D extract32(s->int_polarity, i, 1);
> +            if (curr_level =3D=3D pol) {
> +                s->raw_intstatus |=3D (1U << i);
> +            } else {
> +                s->raw_intstatus &=3D ~(1U << i);
> +            }
> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    }
> +    case K230_GPIO_INTEN:
> +        s->inten =3D value;
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_INTMASK:
> +        s->intmask =3D value;
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_INTTYPE_LEVEL:
> +        s->inttype_level =3D value;
> +        break;
> +    case K230_GPIO_INT_POLARITY:
> +        s->int_polarity =3D value;
> +        break;
> +    case K230_GPIO_DEBOUNCE:
> +        s->debounce =3D value;
> +        break;
> +    case K230_GPIO_PORTA_EOI:
> +        for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +            if (extract32(value, i, 1) && extract32(s->inttype_level, i,=
 1)) {

Should we test s->int_bothedge here? e.g.:
(extract32(s->inttype_level, i, 1) || extract32(s->int_bothedge, i, 1))

> +                s->raw_intstatus =3D deposit32(s->raw_intstatus, i, 1, 0=
);
> +            }
> +        }
> +        k230_gpio_update_int(s);
> +        break;
> +    case K230_GPIO_LS_SYNC:
> +        s->ls_sync =3D value;

Only bit 0 is writable.

> +        break;
> +    case K230_GPIO_ID_CODE:
> +        break;
> +    case K230_GPIO_INT_BOTHEDGE:
> +        s->int_bothedge =3D value;
> +        break;
> +    case K230_GPIO_VER_ID_CODE:
> +        break;
> +    case K230_GPIO_CONFIG_REG2:
> +        break;
> +    case K230_GPIO_CONFIG_REG1:
> +        break;
> +    case K230_GPIO_INTSTATUS:
> +        break;
> +    case K230_GPIO_RAW_INTSTATUS:
> +        break;
> +    case K230_GPIO_EXT_PORTA:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad register at offset 0=
x%"
> +                      HWADDR_PRIx "\n", TYPE_K230_GPIO, __func__, offset=
);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps k230_gpio_ops =3D {
> +    .read =3D k230_gpio_read,
> +    .write =3D k230_gpio_write,
> +    .valid.min_access_size =3D 4,
> +    .valid.max_access_size =3D 4,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static const VMStateDescription vmstate_k230_gpio =3D {
> +    .name =3D TYPE_K230_GPIO,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32(swporta_dr, K230GPIOState),
> +        VMSTATE_UINT32(swporta_ddr, K230GPIOState),
> +        VMSTATE_UINT32(swporta_ctl, K230GPIOState),
> +        VMSTATE_UINT32(inten, K230GPIOState),
> +        VMSTATE_UINT32(intmask, K230GPIOState),
> +        VMSTATE_UINT32(inttype_level, K230GPIOState),
> +        VMSTATE_UINT32(int_polarity, K230GPIOState),
> +        VMSTATE_UINT32(raw_intstatus, K230GPIOState),
> +        VMSTATE_UINT32(debounce, K230GPIOState),
> +        VMSTATE_UINT32(ext_porta, K230GPIOState),
> +        VMSTATE_UINT32(ls_sync, K230GPIOState),
> +        VMSTATE_UINT32(int_bothedge, K230GPIOState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void k230_gpio_enter_reset(Object *obj, ResetType type)
> +{
> +    K230GPIOState *s =3D K230_GPIO(obj);
> +
> +    s->swporta_dr =3D 0;
> +    s->swporta_ddr =3D 0;
> +    s->swporta_ctl =3D 0;
> +    s->inten =3D 0;
> +    s->intmask =3D 0;
> +    s->inttype_level =3D 0;
> +    s->int_polarity =3D 0;
> +    s->raw_intstatus =3D 0;
> +    s->debounce =3D 0;
> +    s->porta_eoi =3D 0;
> +    s->ext_porta =3D 0;
> +    s->ls_sync =3D 0;
> +    s->id_code =3D 0;
> +    s->int_bothedge =3D 0;
> +    s->ver_id_code =3D 0;
> +    s->config_reg2 =3D 0;
> +    s->config_reg1 =3D 0;
> +}
> +
> +static void k230_gpio_hold_reset(Object *obj, ResetType type)
> +{
> +    K230GPIOState *s =3D K230_GPIO(obj);
> +
> +    k230_gpio_update_int(s);
> +}
> +
> +static void k230_gpio_realize(DeviceState *dev, Error **errp)
> +{
> +    K230GPIOState *s =3D K230_GPIO(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    int i;
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &k230_gpio_ops, s,
> +                          TYPE_K230_GPIO, K230_GPIO_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +
> +    qdev_init_gpio_in(DEVICE(s), k230_gpio_set, K230_GPIO_PINS_PER_GROUP=
);
> +    qdev_init_gpio_out(DEVICE(s), s->output, K230_GPIO_PINS_PER_GROUP);
> +
> +    for (i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +    }
> +}
> +
> +static void k230_gpio_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->realize =3D k230_gpio_realize;
> +    rc->phases.enter =3D k230_gpio_enter_reset;
> +    rc->phases.hold =3D k230_gpio_hold_reset;
> +    dc->vmsd =3D &vmstate_k230_gpio;
> +    dc->desc =3D "K230 GPIO controller";
> +}
> +
> +static const TypeInfo k230_gpio_info =3D {
> +    .name =3D TYPE_K230_GPIO,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(K230GPIOState),
> +    .class_init =3D k230_gpio_class_init,
> +};
> +
> +static void k230_gpio_register_types(void)
> +{
> +    type_register_static(&k230_gpio_info);
> +}
> +
> +type_init(k230_gpio_register_types)
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> index 6a67ee958f..94b5d9e2fa 100644
> --- a/hw/gpio/meson.build
> +++ b/hw/gpio/meson.build
> @@ -19,3 +19,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files=
('aspeed_gpio.c'))
>  system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'=
))
>  system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'=
))
>  system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
> +system_ss.add(when: 'CONFIG_K230_GPIO', if_true: files('k230_gpio.c'))
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..410877425c 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>      select SERIAL_MM
>      select UNIMP
>      select K230_WDT
> +    select K230_GPIO
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..62967a67d0 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,8 @@ static void k230_soc_init(Object *obj)
>      object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY=
);
>      object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT)=
;
>      object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT)=
;
> +    object_initialize_child(obj, "k230-gpio0", &s->gpio[0], TYPE_K230_GP=
IO);
> +    object_initialize_child(obj, "k230-gpio1", &s->gpio[1], TYPE_K230_GP=
IO);
>
>      qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>      qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_=
C908);
> @@ -206,6 +208,25 @@ static void k230_soc_realize(DeviceState *dev, Error=
 **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[1]), 0,
>                         qdev_get_gpio_in(DEVICE(s->c908_plic), K230_WDT1_=
IRQ));
>
> +    /* GPIO */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[0]), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[0]), 0,
> +                    memmap[K230_DEV_GPIO0].base);
> +    for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[0]), i,
> +                           qdev_get_gpio_in(DEVICE(s->c908_plic),
> +                                            K230_GPIO0_IRQ_BASE + i));
> +    }
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gpio[1]), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[1]), 0,
> +                    memmap[K230_DEV_GPIO1].base);
> +    for (int i =3D 0; i < K230_GPIO_PINS_PER_GROUP; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[1]), i,
> +                           qdev_get_gpio_in(DEVICE(s->c908_plic),
> +                                            K230_GPIO1_IRQ_BASE + i));
> +    }
> +
>      /* unimplemented devices */
>      create_unimplemented_device("kpu.l2-cache",
>                                  memmap[K230_DEV_KPU_L2_CACHE].base,
> @@ -322,12 +343,6 @@ static void k230_soc_realize(DeviceState *dev, Error=
 **errp)
>      create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
>                                  memmap[K230_DEV_PWM].size);
>
> -    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
> -                                memmap[K230_DEV_GPIO0].size);
> -
> -    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
> -                                memmap[K230_DEV_GPIO1].size);
> -
>      create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
>                                  memmap[K230_DEV_ADC].size);
>
> diff --git a/include/hw/gpio/k230_gpio.h b/include/hw/gpio/k230_gpio.h
> new file mode 100644
> index 0000000000..32005815d2
> --- /dev/null
> +++ b/include/hw/gpio/k230_gpio.h
> @@ -0,0 +1,71 @@
> +/*
> + * QEMU K230 GPIO Controller
> + *
> + * Copyright (c) 2025 Wang Guochun <wdasn99@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * K230 Technical Reference Manual V0.3.1 (2024-11-18), section 12.5 GPI=
O
> + * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_T=
echnical_Reference_Manual_V0.3.1_20241118.pdf
> + */
> +
> +#ifndef HW_K230_GPIO_H
> +#define HW_K230_GPIO_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_GPIO "k230.gpio"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230GPIOState, K230_GPIO)
> +
> +#define K230_GPIO_MEM_SIZE 0x1000
> +
> +#define K230_GPIO_SWPORTA_DR      0x00
> +#define K230_GPIO_SWPORTA_DDR     0x04
> +#define K230_GPIO_SWPORTA_CTL     0x08
> +#define K230_GPIO_INTEN           0x30
> +#define K230_GPIO_INTMASK         0x34
> +#define K230_GPIO_INTTYPE_LEVEL   0x38
> +#define K230_GPIO_INT_POLARITY    0x3c
> +#define K230_GPIO_INTSTATUS       0x40
> +#define K230_GPIO_RAW_INTSTATUS   0x44
> +#define K230_GPIO_DEBOUNCE        0x48
> +#define K230_GPIO_PORTA_EOI       0x4c
> +#define K230_GPIO_EXT_PORTA       0x50
> +#define K230_GPIO_LS_SYNC         0x60
> +#define K230_GPIO_ID_CODE         0x64
> +#define K230_GPIO_INT_BOTHEDGE    0x68
> +#define K230_GPIO_VER_ID_CODE     0x6c
> +#define K230_GPIO_CONFIG_REG2     0x70
> +#define K230_GPIO_CONFIG_REG1     0x74
> +
> +#define K230_GPIO_PINS_PER_GROUP 32
> +
> +struct K230GPIOState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +
> +    uint32_t swporta_dr;
> +    uint32_t swporta_ddr;
> +    uint32_t swporta_ctl;
> +    uint32_t inten;
> +    uint32_t intmask;
> +    uint32_t inttype_level;
> +    uint32_t int_polarity;
> +    uint32_t raw_intstatus;
> +    uint32_t debounce;
> +    uint32_t porta_eoi;

This member seems not to be used anywhere. Drop it.

> +    uint32_t ext_porta;
> +    uint32_t ls_sync;
> +    uint32_t id_code;
> +    uint32_t int_bothedge;
> +    uint32_t ver_id_code;
> +    uint32_t config_reg2;
> +    uint32_t config_reg1;
> +
> +    qemu_irq irq[K230_GPIO_PINS_PER_GROUP];
> +    qemu_irq output[K230_GPIO_PINS_PER_GROUP];
> +};
> +
> +#endif
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..5fccea7fd5 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/watchdog/k230_wdt.h"
> +#include "hw/gpio/k230_gpio.h"
>
>  #define C908_CPU_HARTID   (0)
>
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>      RISCVHartArrayState c908_cpu; /* Small core */
>
>      K230WdtState wdt[2];
> +    K230GPIOState gpio[2];
>      MemoryRegion sram;
>      MemoryRegion bootrom;
>
> @@ -127,8 +129,11 @@ enum {
>      K230_UART2_IRQ  =3D 18,
>      K230_UART3_IRQ  =3D 19,
>      K230_UART4_IRQ  =3D 20,
> +    K230_GPIO0_IRQ_BASE  =3D 32,
> +    K230_GPIO1_IRQ_BASE  =3D 64,
>      K230_WDT0_IRQ   =3D 107,
>      K230_WDT1_IRQ   =3D 108,
> +

Remove this blank line.

>  };
>
>  #define K230_UART_COUNT 5

Regards,
Bin

