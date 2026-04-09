Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6F4F31E21
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqhw-0001FT-4B; Thu, 09 Apr 2026 10:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAqhu-0001El-Do
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:50:10 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAqhr-0004NY-K0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:50:09 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-650221149e2so1080182d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775746206; cv=none;
 d=google.com; s=arc-20240605;
 b=ROaASn28b2dnmnOWRJaWYvBzQHR0UkltbhpqoU2qPZUHbNXeYlW+825BWyS7OP8D4U
 /1ARzxR7S//gamTGhqS3csE947gLEcVS2JqVUOK0Js3Nlqsw6GlLUFuFXSDH5Jwhh3Be
 aZ5kmZGx7Lh7aZn8YfiARskT3h4dY4p5DVfiUEDutH7VOVmlvKfZuLAjt8OQ6RL3Dxlc
 0jdcv++g5sMLI/SHkpLhTJ2mqcSZ5z8KDmDB3EwEPgxfbzZmEwo0djvnnRMuuLPTO5d6
 fLyB4L0wzGEBz+wA/3olTtH4pQbzkKAL2LMcg04tKNkUCDeOZ7uiI0I0tMmGC8Cc1GNf
 WqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3Bh84hvQZDD90RDJE9/3XkBnbkUOOlExoDxsPNBRaKk=;
 fh=kzk51/YeQmI4YTCijVk5rTapTide1tT1Df99nxdLXdY=;
 b=VTJlSsMpaHmL6wgRNtKimsk5c1o6U8jAJUzPX3TnjGyIB1ax2+BWSCsThJR61eAY+b
 tyWp13avX0b02plpmslxbOhU4RtxW22NbAcwHvp2Rnclo8PZ5KcWIztcmk/190sHpCI8
 ESxAJVZ2IcCVnU41hgULJVZaajHyrHFGp99VFp0xNwb/0xnxHmpMqkEAiMwBFOutKBOz
 6UvBm8/V8AG1F/ht1sVm6/ERMnrkgYhY8R4yS0YIGYP0HGVp7q3FjhqKuH5x6LFXE3zQ
 HwcmooDieV0ezTgRq1SOV8zlIje7V+TnEeFZcAtWwmyZ6pCYVlTsYW0d1OFAiotSyvNN
 YQqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775746206; x=1776351006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Bh84hvQZDD90RDJE9/3XkBnbkUOOlExoDxsPNBRaKk=;
 b=INeYXairDMrl9izVtJ1BcOF7T6pFjTq9QifxMQEY2ssCRC8nTtYHl12hyJhdfH4hfU
 4YkGzf1h8CUKgexdIbQaNf9VbCKqDW/5fG6KXQ5JHbTUM3curaTxSzgIDdtNF+8RbeN8
 jJqI2aTc0Gh0EIaxSxUi5wr0Va4+ENe0KGjB7bNAUMPhx2j6QwRNLUhN/FqDGDPjkv57
 pGyYzVTCa29f227BQLVxqi5VgVUClkWWE01n9IajzWraL3tH039qqMBC3UskwFMVACIQ
 SMLiVVm+nP5jhvsClY/gNgTsxmhJ/CW8ik6B/wGqivhaHdkpCEdsKC/uWS79tJghX3xP
 xwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746206; x=1776351006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Bh84hvQZDD90RDJE9/3XkBnbkUOOlExoDxsPNBRaKk=;
 b=ELwRNJ11gUqB0xnPxnypTz3aOpFcPk+kcqX8YisUJKsjmvRTzkYLyApDqMnSdTgzpZ
 KOzrycKTjjoyl5sZhuWW5Fs7HUeqwi5gCtO5bwep7xygAHszwo57UaFUw4J6SYeASsd5
 dqWvbL+YPLgU8mEjyCp0On5XV8ac5FhdBvtMyGuB2Z+RQAGywqFevzTLDWnavafggrOl
 1cOFLl3O6Gd7hRwjnlhbWBlmbdNpEoJ7bNVoTb304QQPNH8X6vP8KZbumImvWjAuB2UG
 TwaAHQeqZoTK0CL41kAOCzFT7p/61JlizZmdZ5qaLp3PpV2JOBokoVzIwVrohvhEq+Rl
 1Ihw==
X-Gm-Message-State: AOJu0YwwNUzeLzhCLGkG6FHPOR8WsnJb731XWye3XdzbKqN1tqpTqB0k
 u7V1zbsQmkzA3M2De/0zwcn4bbuEhYDksHsYnWmHKVMKeiN1FVmpr53+upEdLrfeEAY+53wMEiB
 +IcHrKKtkE9r8Lk4r57CqdWuI68eAre+TGNUsc5mcqQ==
X-Gm-Gg: AeBDieteq36beChfa2PQ/36gs1j/gsdHqyaJgj6YLhOsf4hd8oK6QYFurok2cJF+tOK
 9mctAQml3HiSf8/cK4LdCFiOESLvIOH3ucMb1VCd/Hqe0F8DQRfFQ4rNcLEKj5vD3+22VxSLGN6
 e43EK8E5j6ogRZ0dVYqZ61h1D8PnafYT7xdgYqMDIpSMq39mReM8eh9zOMZ1qH4KS1EjPE5EcDy
 KmrmRsaR/SD4FxR7GxyL+ZrN3Wf9on1ItE2DHcdxyS3yZkp9X84PpkAfwgcLOORG45N/SPsK+kt
 7RbxD3/OwqGWHC9QMpMOt4u5tP1w0IQ3EC1ubX8RAVw90QVrMJKn6/tH285uRS/NblY=
X-Received: by 2002:a53:e018:0:b0:650:1c44:cce1 with SMTP id
 956f58d0204a3-6504873f20cmr17378826d50.25.1775746205653; Thu, 09 Apr 2026
 07:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260303143157.80437-1-1486344514@qq.com>
 <tencent_541F0EB26A5B5A6BDF2823380282EDEBEC07@qq.com>
In-Reply-To: <tencent_541F0EB26A5B5A6BDF2823380282EDEBEC07@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 15:49:52 +0100
X-Gm-Features: AQROBzCbi-flSf6hL5SX71pEJwTg5sglqhcVuQJmAD_7b_Mq4uZZMLw6pea5u2Y
Message-ID: <CAFEAcA_UkrVZFzsN=ROKJLP9w+59+_1+A1vT84xs9N7QVQdPbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/display: Add i.MX6UL LCDIF device model
To: Yucai Liu <1486344514@qq.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jcd@tribudubois.net, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Tue, 3 Mar 2026 at 14:32, Yucai Liu <1486344514@qq.com> wrote:
>
> Implement a basic i.MX6UL LCDIF controller model with MMIO\nregisters, fr=
ame-done interrupt behavior, and framebuffer-backed\ndisplay updates for RG=
B565 and XRGB8888 inputs.\n\nModel the register fields using registerfields=
.h helpers, provide\nmigration support via vmstate, and place the device un=
der hw/display/\nas a standalone display device.

Something odd seems to have happened to your commit
message -- looks like it's ended up with literal "\n"
instead of newlines ?


> Signed-off-by: Yucai Liu <1486344514@qq.com>
> ---
>  MAINTAINERS                       |   2 +
>  hw/display/imx6ul_lcdif.c         | 435 ++++++++++++++++++++++++++++++
>  include/hw/display/imx6ul_lcdif.h |  36 +++
>  3 files changed, 473 insertions(+)
>  create mode 100644 hw/display/imx6ul_lcdif.c
>  create mode 100644 include/hw/display/imx6ul_lcdif.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4918f41ec4..b58022eb28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -895,8 +895,10 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/mcimx6ul-evk.c
>  F: hw/arm/fsl-imx6ul.c
> +F: hw/display/imx6ul_lcdif.c
>  F: hw/misc/imx6ul_ccm.c
>  F: include/hw/arm/fsl-imx6ul.h
> +F: include/hw/display/imx6ul_lcdif.h
>  F: include/hw/misc/imx6ul_ccm.h
>  F: docs/system/arm/mcimx6ul-evk.rst
>
> diff --git a/hw/display/imx6ul_lcdif.c b/hw/display/imx6ul_lcdif.c
> new file mode 100644
> index 0000000000..b84084a33e
> --- /dev/null
> +++ b/hw/display/imx6ul_lcdif.c
> @@ -0,0 +1,435 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * i.MX6UL LCDIF controller
> + *
> + * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/display/imx6ul_lcdif.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/display/framebuffer.h"
> +#include "migration/vmstate.h"
> +#include "system/address-spaces.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "ui/pixel_ops.h"
> +
> +#define LCDIF_MMIO_SIZE             0x1000

Where do we get this size from ? The datasheet I have
suggests the block for the LCDIF in the memory map
is 16K, and on the other hand the last register is
at offset 0x290.

> +
> +REG32(CTRL, 0x00)
> +    FIELD(CTRL, RUN, 0, 1)
> +    FIELD(CTRL, WORD_LENGTH, 8, 2)
> +REG32(CTRL1, 0x10)
> +    FIELD(CTRL1, CUR_FRAME_DONE_IRQ, 9, 1)
> +    FIELD(CTRL1, CUR_FRAME_DONE_IRQ_EN, 13, 1)
> +REG32(V4_TRANSFER_COUNT, 0x30)
> +    FIELD(V4_TRANSFER_COUNT, H_COUNT, 0, 16)
> +    FIELD(V4_TRANSFER_COUNT, V_COUNT, 16, 16)
> +REG32(V4_CUR_BUF, 0x40)
> +REG32(V4_NEXT_BUF, 0x50)
> +REG32(AS_NEXT_BUF, 0x230)
> +
> +#define REG_SET                     0x4
> +#define REG_CLR                     0x8
> +#define REG_TOG                     0xc
> +
> +#define CTRL_WORD_LENGTH_16         0
> +#define CTRL_WORD_LENGTH_24         3
> +
> +#define FRAME_PERIOD_NS             (16 * 1000 * 1000ULL)
> +
> +static inline uint32_t imx6ul_lcdif_reg_idx(hwaddr offset)
> +{
> +    return (offset & ~0xf) >> 2;

Why >> 2 ? The device seems to have registers at address offsets
0x00, 0x10, etc, with in some cases also pseudo-regs for set/clear/toggle
at 0x4, 0x8, 0xc, so I see why & ~0xf. But if we only shift by 2
then we get indexes 0, 4, 8, etc and we're not using all the
array elements.

> +}
> +
> +static inline uint32_t imx6ul_lcdif_reg_read(IMX6ULLCDIFState *s, hwaddr=
 offset)
> +{
> +    return s->regs[imx6ul_lcdif_reg_idx(offset)];
> +}
> +
> +static inline void imx6ul_lcdif_reg_write(IMX6ULLCDIFState *s, hwaddr of=
fset,
> +                                          uint32_t value)
> +{
> +    s->regs[imx6ul_lcdif_reg_idx(offset)] =3D value;
> +}
> +
> +static inline bool imx6ul_lcdif_is_running(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl =3D imx6ul_lcdif_reg_read(s, A_CTRL);

Consider following how the imx6ul_ccm device handles its
registers (it seems to be the other one we have that has some
of this SET/CLR/TOG stuff). Then you could write
    return FIELD_EX32(s->regs[LCDIF_RL], CTRL, RUN);

and save some of the extra wrapper function stuff.

> +
> +    return FIELD_EX32(ctrl, CTRL, RUN);
> +}
> +
> +static inline bool imx6ul_lcdif_frame_done_pending(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl1 =3D imx6ul_lcdif_reg_read(s, A_CTRL1);
> +
> +    return FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
> +}
> +
> +static void imx6ul_lcdif_schedule_frame(IMX6ULLCDIFState *s)
> +{
> +    int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    timer_mod(s->frame_timer, now + FRAME_PERIOD_NS);
> +}
> +
> +static void imx6ul_lcdif_maybe_schedule_frame(IMX6ULLCDIFState *s)
> +{
> +    if (imx6ul_lcdif_is_running(s) && !imx6ul_lcdif_frame_done_pending(s=
)) {
> +        imx6ul_lcdif_schedule_frame(s);
> +    } else {
> +        timer_del(s->frame_timer);
> +    }
> +}
> +
> +static void imx6ul_lcdif_update_irq(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl1 =3D imx6ul_lcdif_reg_read(s, A_CTRL1);
> +    bool level =3D FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ_EN) &&
> +                 FIELD_EX32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ);
> +
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static void imx6ul_lcdif_frame_done(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl1 =3D imx6ul_lcdif_reg_read(s, A_CTRL1);
> +
> +    ctrl1 =3D FIELD_DP32(ctrl1, CTRL1, CUR_FRAME_DONE_IRQ, 1);
> +    imx6ul_lcdif_reg_write(s, A_CTRL1, ctrl1);
> +    imx6ul_lcdif_update_irq(s);
> +}
> +
> +static void imx6ul_lcdif_draw_line_rgb565(void *opaque, uint8_t *dst,
> +                                          const uint8_t *src, int width,
> +                                          int dststep)
> +{
> +    uint32_t *dst32 =3D (uint32_t *)dst;
> +    int i;
> +
> +    (void)opaque;
> +    (void)dststep;

You don't need to use this to mark arguments as not used;
QEMU's build system does not get the compilers to complain
about unused arguments.

> +
> +    for (i =3D 0; i < width; i++) {
> +        uint16_t pixel =3D lduw_le_p(src);
> +        uint8_t r =3D ((pixel >> 11) & 0x1f) << 3;
> +        uint8_t g =3D ((pixel >> 5) & 0x3f) << 2;
> +        uint8_t b =3D (pixel & 0x1f) << 3;
> +
> +        *dst32++ =3D rgb_to_pixel32(r, g, b);
> +        src +=3D 2;
> +    }
> +}
> +
> +static void imx6ul_lcdif_draw_line_xrgb8888(void *opaque, uint8_t *dst,
> +                                            const uint8_t *src, int widt=
h,
> +                                            int dststep)
> +{
> +    uint32_t *dst32 =3D (uint32_t *)dst;
> +    int i;
> +
> +    (void)opaque;
> +    (void)dststep;
> +
> +    for (i =3D 0; i < width; i++) {
> +        uint32_t pixel =3D ldl_le_p(src);
> +        uint8_t r =3D (pixel >> 16) & 0xff;
> +        uint8_t g =3D (pixel >> 8) & 0xff;
> +        uint8_t b =3D pixel & 0xff;
> +
> +        *dst32++ =3D rgb_to_pixel32(r, g, b);
> +        src +=3D 4;
> +    }
> +}
> +
> +static void imx6ul_lcdif_update_display(void *opaque)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +    DisplaySurface *surface =3D qemu_console_surface(s->con);
> +    uint32_t transfer_count =3D imx6ul_lcdif_reg_read(s, A_V4_TRANSFER_C=
OUNT);
> +    uint32_t width =3D FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, H_C=
OUNT);
> +    uint32_t height =3D FIELD_EX32(transfer_count, V4_TRANSFER_COUNT, V_=
COUNT);
> +    uint32_t ctrl =3D imx6ul_lcdif_reg_read(s, A_CTRL);
> +    uint32_t frame_base =3D imx6ul_lcdif_reg_read(s, A_V4_CUR_BUF);
> +    drawfn fn;
> +    int first =3D 0;
> +    int last =3D 0;
> +    int src_width;
> +
> +    if (!imx6ul_lcdif_is_running(s) || width =3D=3D 0 || height =3D=3D 0=
) {
> +        return;
> +    }
> +
> +    if (surface_bits_per_pixel(surface) !=3D 32) {
> +        return;
> +    }
> +
> +    switch (FIELD_EX32(ctrl, CTRL, WORD_LENGTH)) {
> +    case CTRL_WORD_LENGTH_16:
> +        s->src_bpp =3D 2;
> +        fn =3D imx6ul_lcdif_draw_line_rgb565;
> +        break;
> +    case CTRL_WORD_LENGTH_24:
> +        s->src_bpp =3D 4;
> +        fn =3D imx6ul_lcdif_draw_line_xrgb8888;
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    if (surface_width(surface) !=3D width || surface_height(surface) !=
=3D height) {
> +        qemu_console_resize(s->con, width, height);
> +        surface =3D qemu_console_surface(s->con);
> +        s->invalidate =3D true;
> +    }
> +
> +    src_width =3D width * s->src_bpp;
> +    if (s->invalidate || s->fb_base !=3D frame_base ||
> +        s->src_width !=3D src_width || s->rows !=3D height) {
> +        framebuffer_update_memory_section(&s->fbsection, get_system_memo=
ry(),
> +                                          frame_base, height, src_width)=
;
> +        s->fb_base =3D frame_base;
> +        s->src_width =3D src_width;
> +        s->rows =3D height;
> +    }
> +
> +    framebuffer_update_display(surface, &s->fbsection, width, height,
> +                               src_width, surface_stride(surface), 0,
> +                               s->invalidate, fn, s, &first, &last);
> +    if (first >=3D 0) {
> +        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
> +    }
> +
> +    s->invalidate =3D false;
> +}
> +
> +static void imx6ul_lcdif_invalidate_display(void *opaque)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +
> +    s->invalidate =3D true;
> +}
> +
> +static const GraphicHwOps imx6ul_lcdif_graphic_ops =3D {
> +    .invalidate =3D imx6ul_lcdif_invalidate_display,
> +    .gfx_update =3D imx6ul_lcdif_update_display,
> +};
> +
> +static void imx6ul_lcdif_frame_timer_cb(void *opaque)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +
> +    if (!imx6ul_lcdif_is_running(s) || imx6ul_lcdif_frame_done_pending(s=
)) {
> +        return;
> +    }
> +
> +    imx6ul_lcdif_frame_done(s);
> +}
> +
> +static uint64_t imx6ul_lcdif_read(void *opaque, hwaddr offset, unsigned =
size)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +
> +    assert(size =3D=3D 4);
> +    assert(!(offset & 0x3));
> +    assert(offset < LCDIF_MMIO_SIZE);
> +
> +    return s->regs[imx6ul_lcdif_reg_idx(offset)];
> +}
> +
> +static void imx6ul_lcdif_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +    hwaddr reg =3D offset & ~0xf;
> +    uint32_t idx;
> +    uint32_t oldv;
> +
> +    assert(size =3D=3D 4);
> +    assert(!(offset & 0x3));
> +    assert(offset < LCDIF_MMIO_SIZE);
> +
> +    idx =3D imx6ul_lcdif_reg_idx(reg);
> +    oldv =3D s->regs[idx];
> +
> +    switch (offset & 0xf) {
> +    case REG_SET:
> +        s->regs[idx] |=3D (uint32_t)value;
> +        break;
> +    case REG_CLR:
> +        s->regs[idx] &=3D ~(uint32_t)value;
> +        break;
> +    case REG_TOG:
> +        s->regs[idx] ^=3D (uint32_t)value;
> +        break;
> +    default:
> +        s->regs[idx] =3D (uint32_t)value;
> +        break;

Not every register has the SET/CLR/TOG extra registers.

> +    }
> +
> +    switch (reg) {
> +    case A_CTRL:
> +        if (!FIELD_EX32(oldv, CTRL, RUN) &&
> +            FIELD_EX32(s->regs[idx], CTRL, RUN)) {
> +            s->invalidate =3D true;
> +            graphic_hw_invalidate(s->con);
> +            imx6ul_lcdif_maybe_schedule_frame(s);
> +            break;
> +        }
> +        if (FIELD_EX32(oldv, CTRL, RUN) &&
> +            !FIELD_EX32(s->regs[idx], CTRL, RUN)) {
> +            timer_del(s->frame_timer);
> +        }
> +        break;
> +    case A_CTRL1:
> +        if (FIELD_EX32(oldv, CTRL1, CUR_FRAME_DONE_IRQ) &&
> +            !FIELD_EX32(s->regs[idx], CTRL1, CUR_FRAME_DONE_IRQ)) {
> +            imx6ul_lcdif_maybe_schedule_frame(s);
> +        }
> +        break;
> +    case A_V4_TRANSFER_COUNT:
> +        s->invalidate =3D true;
> +        graphic_hw_invalidate(s->con);
> +        break;
> +    case A_V4_CUR_BUF:
> +        s->invalidate =3D true;
> +        graphic_hw_invalidate(s->con);
> +        break;
> +    case A_V4_NEXT_BUF:
> +        imx6ul_lcdif_reg_write(s, A_V4_CUR_BUF, s->regs[idx]);
> +        imx6ul_lcdif_frame_done(s);
> +        s->invalidate =3D true;
> +        graphic_hw_invalidate(s->con);
> +        imx6ul_lcdif_maybe_schedule_frame(s);
> +        return;
> +    case A_AS_NEXT_BUF:
> +        imx6ul_lcdif_frame_done(s);
> +        imx6ul_lcdif_maybe_schedule_frame(s);
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    imx6ul_lcdif_update_irq(s);
> +}
> +
> +static const MemoryRegionOps imx6ul_lcdif_ops =3D {
> +    .read =3D imx6ul_lcdif_read,
> +    .write =3D imx6ul_lcdif_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +static void imx6ul_lcdif_reset(DeviceState *dev)
> +{
> +    IMX6ULLCDIFState *s =3D IMX6UL_LCDIF(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));

The datasheet defines some registers as having non-zero
reset values, notably CTRL1.

> +    s->fb_base =3D 0;
> +    s->src_width =3D 0;
> +    s->rows =3D 0;
> +    s->src_bpp =3D 0;
> +    s->invalidate =3D true;
> +    timer_del(s->frame_timer);
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static int imx6ul_lcdif_post_load(void *opaque, int version_id)
> +{
> +    IMX6ULLCDIFState *s =3D opaque;
> +
> +    s->fb_base =3D 0;
> +    s->src_width =3D 0;
> +    s->rows =3D 0;
> +    s->src_bpp =3D 0;
> +    s->invalidate =3D true;
> +
> +    imx6ul_lcdif_update_irq(s);
> +    if (imx6ul_lcdif_is_running(s) &&
> +        !imx6ul_lcdif_frame_done_pending(s) &&
> +        !timer_pending(s->frame_timer)) {
> +        imx6ul_lcdif_schedule_frame(s);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_imx6ul_lcdif =3D {
> +    .name =3D TYPE_IMX6UL_LCDIF,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D imx6ul_lcdif_post_load,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(regs, IMX6ULLCDIFState,
> +                             LCDIF_MMIO_SIZE / sizeof(uint32_t)),
> +        VMSTATE_TIMER_PTR(frame_timer, IMX6ULLCDIFState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void imx6ul_lcdif_realize(DeviceState *dev, Error **errp)
> +{
> +    IMX6ULLCDIFState *s =3D IMX6UL_LCDIF(dev);
> +
> +    s->frame_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                  imx6ul_lcdif_frame_timer_cb, s);
> +    s->invalidate =3D true;
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &imx6ul_lcdif_ops, s,
> +                          TYPE_IMX6UL_LCDIF, LCDIF_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +    s->con =3D graphic_console_init(dev, 0, &imx6ul_lcdif_graphic_ops, s=
);
> +
> +    if (surface_bits_per_pixel(qemu_console_surface(s->con)) !=3D 32) {

This is always true, you don't need to test it.

> +        error_setg(errp, "%s requires a 32bpp host surface", TYPE_IMX6UL=
_LCDIF);
> +    }
> +}
> +
> +static void imx6ul_lcdif_finalize(Object *obj)
> +{
> +    IMX6ULLCDIFState *s =3D IMX6UL_LCDIF(obj);
> +
> +    if (s->fbsection.mr) {
> +        memory_region_set_log(s->fbsection.mr, false, DIRTY_MEMORY_VGA);

No other display device seems to be doing this -- why do we need to ?

> +        memory_region_unref(s->fbsection.mr);
> +        s->fbsection.mr =3D NULL;
> +    }
> +    if (s->con) {
> +        graphic_console_close(s->con);
> +    }
> +    timer_free(s->frame_timer);

Cleanup of things done in realize should go in unrealize. (instance_finaliz=
e
pairs with instance_init).

> +}
> +
> +static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data=
)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D imx6ul_lcdif_realize;
> +    dc->vmsd =3D &vmstate_imx6ul_lcdif;
> +    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
> +    dc->desc =3D "i.MX6UL LCDIF";
> +}
> +
> +static const TypeInfo imx6ul_lcdif_info =3D {
> +    .name =3D TYPE_IMX6UL_LCDIF,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(IMX6ULLCDIFState),
> +    .instance_finalize =3D imx6ul_lcdif_finalize,
> +    .class_init =3D imx6ul_lcdif_class_init,
> +};
> +
> +static void imx6ul_lcdif_register_types(void)
> +{
> +    type_register_static(&imx6ul_lcdif_info);
> +}
> +
> +type_init(imx6ul_lcdif_register_types)
> diff --git a/include/hw/display/imx6ul_lcdif.h b/include/hw/display/imx6u=
l_lcdif.h
> new file mode 100644
> index 0000000000..0b24b64e68
> --- /dev/null
> +++ b/include/hw/display/imx6ul_lcdif.h
> @@ -0,0 +1,36 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * i.MX6UL LCDIF controller
> + *
> + * Copyright (c) 2026 Yucai Liu <1486344514@qq.com>
> + */
> +
> +#ifndef IMX6UL_LCDIF_H
> +#define IMX6UL_LCDIF_H
> +
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "qemu/timer.h"
> +#include "ui/console.h"
> +
> +#define TYPE_IMX6UL_LCDIF "imx6ul-lcdif"
> +OBJECT_DECLARE_SIMPLE_TYPE(IMX6ULLCDIFState, IMX6UL_LCDIF)
> +
> +struct IMX6ULLCDIFState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion iomem;
> +    MemoryRegionSection fbsection;
> +    qemu_irq irq;
> +    QemuConsole *con;
> +    QEMUTimer *frame_timer;
> +    uint32_t fb_base;
> +    uint32_t src_width;
> +    uint32_t rows;
> +    uint8_t src_bpp;
> +    bool invalidate;
> +    uint32_t regs[0x1000 / sizeof(uint32_t)];

This is much more space than you actually need; see earlier remarks.

> +};

thanks
-- PMM

