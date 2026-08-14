Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B00AC5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wumWc-0001MS-E7; Fri, 14 Aug 2026 03:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumWa-0001Lk-Lp
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:40:20 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumWY-0000zK-8F
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:40:20 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81ff017d420so24266397b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 00:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786693217; cv=none;
 d=google.com; s=arc-20260327;
 b=aPB1+shAJCvF40lqv/molZp11Qj1YMNf6gB2WWhXhNItRRf0UiUZ26Drx3/rrMGHaI
 7CkcDHP2krii6S4XW4iNcF9XqmaPLtiwNr7y8TPMJ+mco/aq8Z7l2TkQz2Tngv57QW0Z
 7nRvOiaioWWdNHxmrkvBxPHvp6NyU9rnHg0Fn45z5mGjsJbG0+sDmIfUbxuTX5vM3Wab
 v4PK2wRZWPp0U65ylYDHnfRVfkrQoJRYZaLxmsaqbZB8x5kzfKt5F0ZUopFqlb2xo1Gb
 vQ7BQH08tPsuCqziwBAiZvc9qFd2rur3TNAor+OST2R/qJhTdxClIbMnBlMSca66Dclh
 HcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aZWBHKhtgV65dJXsui6AHDLIruEy5Lq1PxccoXE3Ik0=;
 fh=DvywU1YRUhG1v1NPt1cQxypEN9Sw7skuH1UPJUFElts=;
 b=PCE2C+ggjEVv3wWzmae+Famlq13v5HsmHurkMzsAy9XY5NXXWobwc0CxhN0b7t7vvt
 Pn1Y6smDvXpGPu/Mc0tYClFKeyOYl5HSOvwy0T5ot2Pz8cjOeTJ+zNKNjeBXnB8vxL2q
 ScQAI1qpxpbSEStwOvD3lbSEV8Z0pWqQqDkcWQ9232tpYxivQm+X2eKowiJ6+4Ti+N4w
 8FsSrkEXGO+R/yQPNLDAAOqd829s/JkqYGWH0A5MlfM76ZutbT5XZK96VF88r8v/8qTc
 ndmGKxD6rgdn0rjmZNEfvWBS5lm5T5xJUy5KtL+7GBbvDgdAfCNKPzQEcmdBydNlHeIH
 xehw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786693217; x=1787298017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aZWBHKhtgV65dJXsui6AHDLIruEy5Lq1PxccoXE3Ik0=;
 b=pdsLYSWjgBq9gIB5raRdLzMRn3pyXzzOZP8QlUoF9dpLKzz+vV3sGtnMfI+297IMNl
 q8sx4yF39x2IPX9qtndk9q8tloDVujmv5XCtJtQxPirI144YWxnZUTrG9V2MuZG44V4B
 T1PizC5cT2oTgGL7G5TA+w/wiDpPFKswVJErJsUvPeH/Ma+3Sd/TkVy4Fshvk487Xs3L
 C8osA6+4uyFDp6E4C0cNyqeD1VyjDXaJIJ4ibJRxrgI/ig+9Dn0YqedSHruMn2a9w4/k
 BCdW+9NOMuQx+JM+TAQIdx72ATS4d5b9gBWu9Szv2+Mfj/+elCzrboP+HK8Atf2OEVcQ
 Rnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786693217; x=1787298017;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aZWBHKhtgV65dJXsui6AHDLIruEy5Lq1PxccoXE3Ik0=;
 b=CpaIzwunaVm+mcELE9KzI5LE/2rU41ELoBCzgAdKRK0ejL4QDvjY2voRqI50pXudIn
 jLLwkMdhcMlvQlHZU3LVgs5Kl1YAruSF2oxDPTx5Ehc2q6y4ew7jJ0D0Fxh8L+lRBlau
 zGW+UevepepjWrBB03pwPwRVKGuaZodPGJ5TmedvJUGEL2UoGhDOUWfFoBjSEkX5l9Jn
 JeBobmHt3ukqUFy+Fact1hlSyCj7zq0kArxUPaUPQFUzxYOYz6FTWl6EGtEzyc001OK7
 O1xsCLESMLz1/jthUSAPVZsBVtN4yrgUqot7ytfdOFV4NAE0F6SEZn/KMEOpLd7hAKdc
 w2Iw==
X-Gm-Message-State: AOJu0Yy3wz7FQotrre+EDeS5eeIS+t2CsIkQiibBBZo99+6umzUXRiUq
 OsTg2zLC+/0V7CIXkoF9SAbM+MXBrgLsAT2zpCMdwOkbDEJQ4mJ8AOkbINzRC4QeOCaU+GRgKXT
 F4yF+/rP9fhw/KC1l/ImwnnXT+UWAcW8=
X-Gm-Gg: AR+sD12BQvvFkjaazipIpY/ULVQCFbURWdmXW6gM+K8HpT5gz3rO68KL3pdmGG89vT9
 uuPGLCK1zp+DvpUQhsxenr4BPJqrCZDIr/VqZxI2Eaf74uZpOwA4KvbVIKZyRTPP/hDdu/UCzLw
 zryZGbEI6auV9sVTTnj2KU42HJRMUyntRnMM71HV8V03Cy9Bfeh3iC0ynt3WMKeHvEUvd4Qz3K+
 /CoYxcttwg4fGM7w+FYPzzERpK7eTrWs1DfaUbedQ+Gu0RaXNrnq8K9AUyjhF7d6/55J0DWXTA+
 CC1zwSpfzVwGpt+WjQeeErTY1BjA4NJqUg2730p4v7PJFtsLrDIFw8g=
X-Received: by 2002:a05:690c:6e0c:b0:81e:d001:e0ca with SMTP id
 00721157ae682-83713d3a594mr18432687b3.17.1786693216681; Fri, 14 Aug 2026
 00:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260813133643.20380-1-rao232328@gmail.com>
 <20260813133643.20380-2-rao232328@gmail.com>
In-Reply-To: <20260813133643.20380-2-rao232328@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 15:40:05 +0800
X-Gm-Features: AUfX_mxHHG_igjtCRdWZdG9xsTuQXCVGNsuyKUo7Hv5FMfqDjFBDT_6lpmzUZqI
Message-ID: <CAEUhbmW=TSD2duo6260kvj=t=+GmA31KVEHCJVppya3h8v7pSw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] hw/timer: add DesignWare APB timer model
To: raoyi <rao232328@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 philmd@oss.qualcomm.com, pbonzini@redhat.com, lvivier@redhat.com, 
 farosas@suse.de, caojunze424@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Aug 13, 2026 at 9:37=E2=80=AFPM raoyi <rao232328@gmail.com> wrote:
>
> Add generic DesignWare APB timer device model. The number
> of timer channels is configurable via the num-timers property.
>
> Add timer files to MAINTAINERS.
>
> Signed-off-by: raoyi <rao232328@gmail.com>
> ---
>  MAINTAINERS                     |   2 +
>  hw/timer/Kconfig                |   4 +
>  hw/timer/dw-apb-timer.c         | 376 ++++++++++++++++++++++++++++++++
>  hw/timer/meson.build            |   1 +
>  hw/timer/trace-events           |   8 +
>  include/hw/timer/dw-apb-timer.h |  40 ++++
>  6 files changed, 431 insertions(+)
>  create mode 100644 hw/timer/dw-apb-timer.c
>  create mode 100644 include/hw/timer/dw-apb-timer.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..cf689433ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,8 +1826,10 @@ S: Maintained
>  F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
> +F: hw/timer/dw-apb-timer.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: include/hw/timer/dw-apb-timer.h
>  F: tests/qtest/k230-wdt-test.c
>
>  RX Machines
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index b3d823ce2c..b533cf1ba9 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -65,3 +65,7 @@ config STELLARIS_GPTM
>
>  config AVR_TIMER16
>      bool
> +
> +config DW_APB_TIMER
> +    bool
> +    select PTIMER
> diff --git a/hw/timer/dw-apb-timer.c b/hw/timer/dw-apb-timer.c
> new file mode 100644
> index 0000000000..0b994e1570
> --- /dev/null
> +++ b/hw/timer/dw-apb-timer.c
> @@ -0,0 +1,376 @@
> +/*
> + * Synopsys DesignWare APB timer
> + *
> + * Copyright (c) 2026 raoyi <rao232328@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "migration/vmstate.h"
> +#include "hw/core/ptimer.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/timer/dw-apb-timer.h"
> +#include "trace.h"
> +
> +#define DW_APB_TIMER_STRIDE       0x14
> +#define DW_APB_TIMER_MMIO_SIZE    0x100
> +
> +/* Per-timer register offsets */
> +#define DW_APB_TIMER_N_LOAD_COUNT    0x00
> +#define DW_APB_TIMER_N_CURRENT_VALUE 0x04
> +#define DW_APB_TIMER_N_CONTROL       0x08
> +#define DW_APB_TIMER_N_EOI           0x0c
> +#define DW_APB_TIMER_N_INT_STATUS    0x10
> +/* Global register offsets */
> +#define DW_APB_TIMER_INT_STATUS        0xa0
> +#define DW_APB_TIMER_EOI               0xa4
> +#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
> +#define DW_APB_TIMER_COMP_VERSION      0xac
> +
> +/* Control register bits */
> +#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
> +/* 1: periodic, 0: free running. */
> +#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
> +#define DW_APB_TIMER_CONTROL_INT           BIT(2)

The macro name is misleading, better to name it as:
DW_APB_TIMER_CONTROL_INT_MASK

> +#define DW_APB_TIMER_CONTROL_RW_MASK       0x7
> +
> +/*
> + * Component version of the DW_apb_timers IP, fixed in silicon.
> + * Decodes as the ASCII string "211*" (2.11a series); the model reports
> + * the version integrated in K230. Linux does not read this register.
> + */
> +#define DW_APB_TIMER_COMP_VERSION_VAL 0x3231312A
> +
> +static void dw_apb_timer_update_irq(DWAPBTimerChannel *t)
> +{
> +    qemu_set_irq(t->irq, t->int_status &&
> +                 !(t->control & DW_APB_TIMER_CONTROL_INT));
> +}
> +
> +static void dw_apb_timer_clk_update(void *opaque, ClockEvent event)
> +{
> +    DWAPBTimerChannel *t =3D opaque;
> +
> +    if (!t->ptimer) {
> +        return;
> +    }
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_set_period_from_clock(t->ptimer, t->clk, 1);
> +    ptimer_transaction_commit(t->ptimer);
> +}
> +
> +static void dw_apb_timer_enable(DWAPBTimerChannel *t)
> +{
> +    trace_dw_apb_timer_enable(t->id, t->load);
> +
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_set_limit(t->ptimer, t->load ? t->load : 1, 1);
> +    ptimer_run(t->ptimer, 1);
> +    ptimer_transaction_commit(t->ptimer);
> +}
> +
> +static void dw_apb_timer_disable(DWAPBTimerChannel *t)
> +{
> +    trace_dw_apb_timer_disable(t->id);
> +
> +    ptimer_transaction_begin(t->ptimer);
> +    ptimer_stop(t->ptimer);
> +    ptimer_transaction_commit(t->ptimer);
> +
> +    t->int_status =3D 0;
> +    dw_apb_timer_update_irq(t);
> +}
> +
> +static void dw_apb_timer_tick(void *opaque)
> +{
> +    DWAPBTimerChannel *t =3D opaque;
> +    uint32_t reload;
> +
> +    trace_dw_apb_timer_tick(t->id);
> +
> +    t->int_status =3D 1;
> +    dw_apb_timer_update_irq(t);
> +
> +    if (t->control & DW_APB_TIMER_CONTROL_MODE_PERIODIC) {
> +        reload =3D t->load ? t->load : 1;
> +    } else {
> +        reload =3D UINT32_MAX;
> +    }
> +
> +    ptimer_set_limit(t->ptimer, reload, 1);
> +    ptimer_run(t->ptimer, 1);
> +}
> +
> +static uint64_t dw_apb_timer_read(void *opaque, hwaddr addr,
> +                                  unsigned int size)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(opaque);
> +    uint32_t value =3D 0;
> +
> +    if (addr < DW_APB_TIMER_INT_STATUS) {
> +        unsigned int idx =3D addr / DW_APB_TIMER_STRIDE;
> +        hwaddr reg =3D addr % DW_APB_TIMER_STRIDE;
> +
> +        if (idx < s->num_timers) {
> +            DWAPBTimerChannel *t =3D &s->timers[idx];
> +
> +            switch (reg) {
> +            case DW_APB_TIMER_N_LOAD_COUNT:
> +                value =3D t->load;
> +                break;
> +            case DW_APB_TIMER_N_CURRENT_VALUE:
> +                if (t->control & DW_APB_TIMER_CONTROL_ENABLE) {
> +                    value =3D ptimer_get_count(t->ptimer);
> +                }
> +                break;
> +            case DW_APB_TIMER_N_CONTROL:
> +                value =3D t->control;
> +                break;
> +            case DW_APB_TIMER_N_EOI:
> +                t->int_status =3D 0;
> +                dw_apb_timer_update_irq(t);
> +                trace_dw_apb_timer_irq_clear(t->id);
> +                break;
> +            case DW_APB_TIMER_N_INT_STATUS:
> +                value =3D t->int_status &&
> +                        !(t->control & DW_APB_TIMER_CONTROL_INT);
> +                break;
> +            default:
> +                break;
> +            }
> +        }
> +    } else {
> +        switch (addr) {
> +        case DW_APB_TIMER_INT_STATUS:
> +            for (int i =3D 0; i < s->num_timers; i++) {
> +                DWAPBTimerChannel *t =3D &s->timers[i];
> +
> +                value |=3D (t->int_status &&
> +                          !(t->control & DW_APB_TIMER_CONTROL_INT)) << i=
;
> +            }
> +            break;
> +        case DW_APB_TIMER_EOI:
> +            for (int i =3D 0; i < s->num_timers; i++) {
> +                DWAPBTimerChannel *t =3D &s->timers[i];
> +
> +                t->int_status =3D 0;
> +                dw_apb_timer_update_irq(t);
> +            }
> +            break;
> +        case DW_APB_TIMER_RAW_INT_STATUS:
> +            for (int i =3D 0; i < s->num_timers; i++) {
> +                value |=3D s->timers[i].int_status << i;
> +            }
> +            break;
> +        case DW_APB_TIMER_COMP_VERSION:
> +            value =3D DW_APB_TIMER_COMP_VERSION_VAL;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    trace_dw_apb_timer_read(addr, value);
> +    return value;
> +}
> +
> +static void dw_apb_timer_write(void *opaque, hwaddr addr,
> +                               uint64_t value, unsigned int size)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(opaque);
> +
> +    if (addr < DW_APB_TIMER_INT_STATUS) {
> +        unsigned int idx =3D addr / DW_APB_TIMER_STRIDE;
> +        hwaddr reg =3D addr % DW_APB_TIMER_STRIDE;
> +
> +        if (idx < s->num_timers) {
> +            DWAPBTimerChannel *t =3D &s->timers[idx];
> +
> +            switch (reg) {
> +            case DW_APB_TIMER_N_LOAD_COUNT:
> +                t->load =3D value;
> +                break;
> +            case DW_APB_TIMER_N_CONTROL: {
> +                uint32_t old_control =3D t->control;
> +                uint32_t new_control =3D value & DW_APB_TIMER_CONTROL_RW=
_MASK;
> +
> +                t->control =3D new_control;
> +                if ((new_control ^ old_control) &
> +                    DW_APB_TIMER_CONTROL_ENABLE) {
> +                    if (new_control & DW_APB_TIMER_CONTROL_ENABLE) {
> +                        dw_apb_timer_enable(t);
> +                    } else {
> +                        dw_apb_timer_disable(t);
> +                    }
> +                }
> +                if ((new_control ^ old_control) &
> +                    DW_APB_TIMER_CONTROL_INT) {
> +                    dw_apb_timer_update_irq(t);
> +                }
> +                break;
> +            }
> +            default:
> +                break;
> +            }
> +        }
> +    }
> +
> +    trace_dw_apb_timer_write(addr, value);
> +}
> +
> +static const MemoryRegionOps dw_apb_timer_ops =3D {
> +    .read =3D dw_apb_timer_read,
> +    .write =3D dw_apb_timer_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +static void dw_apb_timer_reset_hold(Object *obj, ResetType type)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(obj);
> +
> +    for (int i =3D 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t =3D &s->timers[i];
> +
> +        ptimer_transaction_begin(t->ptimer);
> +        ptimer_stop(t->ptimer);
> +        ptimer_transaction_commit(t->ptimer);
> +
> +        t->load =3D 0;
> +        t->control =3D 0;
> +        t->int_status =3D 0;
> +        dw_apb_timer_update_irq(t);
> +    }
> +}
> +
> +static const VMStateDescription vmstate_dw_apb_timer_channel =3D {
> +    .name =3D "dw-apb-timer-channel",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_PTIMER(ptimer, DWAPBTimerChannel),
> +        VMSTATE_CLOCK(clk, DWAPBTimerChannel),
> +        VMSTATE_UINT32(load, DWAPBTimerChannel),
> +        VMSTATE_UINT32(control, DWAPBTimerChannel),
> +        VMSTATE_UINT32(int_status, DWAPBTimerChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_dw_apb_timer =3D {
> +    .name =3D "dw-apb-timer",
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_STRUCT_VARRAY_UINT32(timers, DWAPBTimerState,
> +                                     num_timers, 0,
> +                                     vmstate_dw_apb_timer_channel,
> +                                     DWAPBTimerChannel),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const Property dw_apb_timer_properties[] =3D {
> +    DEFINE_PROP_UINT32("num-timers", DWAPBTimerState, num_timers, 1),
> +};
> +
> +static void dw_apb_timer_init(Object *obj)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(obj);
> +
> +    for (int i =3D 0; i < DW_APB_TIMER_MAX_TIMERS; i++) {
> +        DWAPBTimerChannel *t =3D &s->timers[i];
> +        g_autofree char *name =3D g_strdup_printf("timer[%d]", i);
> +
> +        t->id =3D i;
> +        t->clk =3D qdev_init_clock_in(DEVICE(obj), name,
> +                                    dw_apb_timer_clk_update, t,
> +                                    ClockUpdate);
> +    }
> +}
> +
> +static void dw_apb_timer_realize(DeviceState *dev, Error **errp)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +
> +    if (s->num_timers =3D=3D 0 || s->num_timers > DW_APB_TIMER_MAX_TIMER=
S) {
> +        error_setg(errp, "dw-apb-timer: num-timers must be between 1 and=
 %u",
> +                   DW_APB_TIMER_MAX_TIMERS);
> +        return;
> +    }
> +
> +    for (int i =3D 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t =3D &s->timers[i];
> +
> +        if (!clock_has_source(t->clk)) {
> +            error_setg(errp, "dw-apb-timer: timer[%u] clock must be conn=
ected",
> +                       i);
> +            return;
> +        }
> +    }
> +
> +    for (int i =3D 0; i < s->num_timers; i++) {
> +        DWAPBTimerChannel *t =3D &s->timers[i];
> +
> +        t->ptimer =3D ptimer_init(dw_apb_timer_tick, t,
> +            PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
> +            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
> +            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
> +        ptimer_transaction_begin(t->ptimer);
> +        ptimer_set_limit(t->ptimer, UINT32_MAX, 1);
> +        ptimer_transaction_commit(t->ptimer);
> +        sysbus_init_irq(sbd, &t->irq);
> +
> +        /* The source may have been connected before the ptimer existed.=
 */
> +        dw_apb_timer_clk_update(t, ClockUpdate);
> +    }
> +
> +    memory_region_init_io(&s->mmio, OBJECT(dev), &dw_apb_timer_ops,
> +                          s, TYPE_DW_APB_TIMER, DW_APB_TIMER_MMIO_SIZE);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +}
> +
> +static void dw_apb_timer_unrealize(DeviceState *dev)
> +{
> +    DWAPBTimerState *s =3D DW_APB_TIMER(dev);
> +
> +    for (int i =3D 0; i < s->num_timers; i++) {
> +        ptimer_free(s->timers[i].ptimer);
> +    }
> +}
> +
> +static void dw_apb_timer_class_init(ObjectClass *klass, const void *data=
)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    dc->realize =3D dw_apb_timer_realize;
> +    dc->unrealize =3D dw_apb_timer_unrealize;
> +    dc->vmsd =3D &vmstate_dw_apb_timer;
> +    dc->desc =3D "Synopsys DesignWare APB timer";
> +    rc->phases.hold =3D dw_apb_timer_reset_hold;
> +    device_class_set_props(dc, dw_apb_timer_properties);
> +}
> +
> +static const TypeInfo dw_apb_timer_info =3D {
> +    .name          =3D TYPE_DW_APB_TIMER,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(DWAPBTimerState),
> +    .instance_init =3D dw_apb_timer_init,
> +    .class_init    =3D dw_apb_timer_class_init,
> +};
> +
> +static void dw_apb_timer_register_type(void)
> +{
> +    type_register_static(&dw_apb_timer_info);
> +}
> +
> +type_init(dw_apb_timer_register_type)
> diff --git a/hw/timer/meson.build b/hw/timer/meson.build
> index 201b5d8316..fccc36540c 100644
> --- a/hw/timer/meson.build
> +++ b/hw/timer/meson.build
> @@ -34,3 +34,4 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ib=
ex_timer.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
>
>  system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'=
))
> +system_ss.add(when: 'CONFIG_DW_APB_TIMER', if_true: files('dw-apb-timer.=
c'))
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 634ba1da27..7f592a96c8 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -1,5 +1,13 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>
> +# dw-apb-timer.c
> +dw_apb_timer_read(uint64_t addr, uint32_t val) "DW APB timer read: [0x%"=
 PRIx64 "] -> 0x%" PRIx32
> +dw_apb_timer_write(uint64_t addr, uint64_t val) "DW APB timer write: [0x=
%" PRIx64 "] <- 0x%" PRIx64
> +dw_apb_timer_tick(int idx) "DW APB timer %d tick"
> +dw_apb_timer_irq_clear(int idx) "DW APB timer %d IRQ cleared"
> +dw_apb_timer_enable(int idx, uint32_t load) "DW APB timer %d enabled loa=
d=3D0x%" PRIx32
> +dw_apb_timer_disable(int idx) "DW APB timer %d disabled"
> +
>  # slavio_timer.c
>  slavio_timer_get_out(uint64_t limit, uint32_t counthigh, uint32_t count)=
 "limit 0x%"PRIx64" count 0x%x0x%08x"
>  slavio_timer_irq(uint32_t counthigh, uint32_t count) "callback: count 0x=
%x0x%08x"
> diff --git a/include/hw/timer/dw-apb-timer.h b/include/hw/timer/dw-apb-ti=
mer.h
> new file mode 100644
> index 0000000000..f6b83ae5ca
> --- /dev/null
> +++ b/include/hw/timer/dw-apb-timer.h
> @@ -0,0 +1,40 @@
> +/*
> + * Synopsys DesignWare APB timer
> + *
> + * Copyright (c) 2026 raoyi <rao232328@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef DW_APB_TIMER_H
> +#define DW_APB_TIMER_H
> +
> +#include "hw/core/sysbus.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/clock.h"
> +#include "qom/object.h"
> +
> +#define TYPE_DW_APB_TIMER "dw-apb-timer"
> +OBJECT_DECLARE_SIMPLE_TYPE(DWAPBTimerState, DW_APB_TIMER)
> +
> +#define DW_APB_TIMER_MAX_TIMERS   8
> +
> +typedef struct DWAPBTimerChannel {
> +    struct ptimer_state *ptimer;
> +    Clock *clk;
> +    qemu_irq irq;
> +    unsigned int id;
> +    uint32_t load;
> +    uint32_t control;
> +    uint32_t int_status;
> +} DWAPBTimerChannel;
> +
> +struct DWAPBTimerState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t num_timers;
> +    DWAPBTimerChannel timers[DW_APB_TIMER_MAX_TIMERS];
> +};
> +
> +#endif
> --

Other than that,

Reviewed-by: Bin Meng <bin.meng@processmission.com>

