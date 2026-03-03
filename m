Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBEBEC1451
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQFq-0000Q1-J2; Tue, 03 Mar 2026 08:57:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxQFn-0000PP-Ml
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:57:39 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxQFk-0005Jj-FS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:57:38 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso6907879d50.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 05:57:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772546255; cv=none;
 d=google.com; s=arc-20240605;
 b=IEQQaze18/fvmo49m+uChOhTETWnfQeeV8RWAPb5hvG57+1hRTizNXV1aP9rjTr6G2
 T2hWpX8vl7AVEFb3ClNAeW7ON/wC667pfnJ/NzN9NFfIydevYERX/2BWmE6iG8RaIhsj
 dGCzZNGBbhA9RTKBy/juB/A2P7YWc1PdUiZ5ysiCMECEJ/g2bIE8/4sg1V2QpMJhH9bi
 QeuVA3ysaLGZXEH6RMhRjds/JrAXJocefvlYakU1+yDwSleQaVxswOFna4RhHhm1nfVF
 b2dqbBr9CaHvDltFFx0tB7ko2/WoZA4PTTSMybPq+uDd7Gk2ghd0YOS0fmMR4/6Hemu/
 1jMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L5CZf2oL1MiU2X3Ag0zKKJzNUx8XH7gJcCiQo2n2hAg=;
 fh=yfmMxapyFjm2RuIWIYnzRl7D8T1C9U3JiLKe3I4J+SQ=;
 b=OyMIR0p+CBvdMSp3o1CckLiqVf5yLmwK8IpvrKx1vrrubZM8g3uahVYeuGs9zrr2tz
 Ufv+pK2lqojKX8ZE7MTX1Ih4c9uEaJl6RaCvNpn0XzG6sF9tY3u3Ed+Z7srRabcnDjtj
 6VrUS8BpILJPRBqmkfqXJEsRlFoFQgRKTTR/ZAvjXefBswCqv58pPohQ4q53EsnpmLgB
 tAW320Y8Rzr+HWYYoFmkuUglR4pWPh3k4pLff+8wUeqyEuNWEB86XyA62eiAkpF3Q+SG
 HWutvOulH5kfjCGoivVNmqhn3xiklarYsWy/G9hk+KlvVnj7eSvwXxo+J9xvRfY/asBZ
 a//Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772546255; x=1773151055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L5CZf2oL1MiU2X3Ag0zKKJzNUx8XH7gJcCiQo2n2hAg=;
 b=yMlwdxTadqOhgNy0ArV1VopXodhetzMZ2qIDqL8iL7vFFA0mmg/flpYCPCN8kctPnj
 5hdpLzAD1I8l4yjxoLURpi8539SKsUYZ2GqnCwe9wpdrO/6zCDtDRdErN1gQOZRt/9ap
 7Tr5kuNz6FYvIxYYiFGz/bgfpruxwYRZO0goToNtA4L8lpbz8uq49xaPqylDmvE7PyHd
 FLNYkTmVA2hej7TzU0DkNzOd2isSMwcbUAr29RutX/G3EVNdQz2p+25Ep7OjdZasNLvC
 nIEYchA0XittxTBAsq8b4HUKhLzgMIOsidqDvGFEMGzhF2TkDp6x5MFuy4xxp6uZX8Sz
 krSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772546255; x=1773151055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5CZf2oL1MiU2X3Ag0zKKJzNUx8XH7gJcCiQo2n2hAg=;
 b=G3xJ3ntc0nJqvs8QbYpadDURqk51aznbGYo+d7zYZqPt2nwkWh6eWmVNt8fAwt8KYb
 rbIUt3yhrlbFg/UpnvvDhCXL8967/vfGbnpTrLlUulh9/nsgJJ+EjmNy0VwX2uyOkn6d
 OBA84dbwRbYtgqTAeXjlNJGIIqTEMn658RycAnhMlltz+jdaiaeIjYkpwH/AP4uhm8L/
 9c2MnpZmh1eriV9hqr/6lUwv3cLzQSVVoqPz4+T6cuxxTCNS5hBstI/KRcJZuXzVh1SN
 fnAGOe+bcKbI4I0JZOHKbH6x/lYoiXIKurvJO1OGoGgzBf1vs8HkoV4CsPeKC26N5zcF
 P4hg==
X-Gm-Message-State: AOJu0YxoC77OIVDOkOfoSGD0DMJTBpjmqPHkOc2s+0S9Ot/iQE2nwQxA
 RjdCTIldBJSym5cRFRxOJ3hVFVqWxE1xlIQ+9E8Ti42Nj8Q6IDLJv2hECAwCv56nB6hm3mLJX0t
 hGxSXRgblAyNWPNP0QNJ29Aiea19HxKBmVG3cf2xNTw==
X-Gm-Gg: ATEYQzy7++2H1rCRvQw8/6gViMXAvlr7tJTu1ndZfj/lVEIGJD4eA+DTOpDbeoV0SiT
 Qywu2YRUhli+uhgavgeZx26R3BtpBHqhzviA/18ne98+KYGTnhyp7xMdD4A8ZBRplGYRn/DYOBT
 1vF8LYfINvU9Chp+9sd4tlL8kxLHOUbgjKkXRwL1E8pgA3i3Rdy1RA7yYz/5fmczzdbFipkgCLp
 A3G8WG0947Sr5srFWmlfLDvbLc+7o/4abqRJPJXziGq5tTg5chjU5iPWxsedQ5FawoR7UJdlr14
 J8+zAsAZU1PdtugU+CIMdW7iSE6+RSowS4si94Mn8X10hev38K/RHKNtzBK6b1b09NQ=
X-Received: by 2002:a05:690e:120d:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-64cedbecb46mr1657427d50.24.1772546254908; Tue, 03 Mar 2026
 05:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20260223165445.318433-1-1486344514@qq.com>
 <tencent_9903EBF42878B83D82A1EBAC1F4BB2755B07@qq.com>
In-Reply-To: <tencent_9903EBF42878B83D82A1EBAC1F4BB2755B07@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 13:57:23 +0000
X-Gm-Features: AaiRm52QNQnMfgq0AL-vzy1V09RnRB84UANuDs5oKp-25UYiif90JfFwmHgKqYw
Message-ID: <CAFEAcA8+dQ6i-Gyxy1XQq32STWftozFKa_UYiZmBbHB7oJfMDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: Implement i.MX6UL LCDIF model
To: Yucai Liu <1486344514@qq.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jcd@tribudubois.net
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Mon, 23 Feb 2026 at 16:54, Yucai Liu <1486344514@qq.com> wrote:
>
> Add a basic i.MX6UL LCDIF device model, hook it into the i.MX6UL SoC, and replace the previous unimplemented LCDIF stub. The model exposes MMIO registers, frame-done IRQ behavior, and framebuffer-backed display updates for RGB565/XRGB8888 formats.
>
> Signed-off-by: Yucai Liu <1486344514@qq.com>

Hi; thanks for sending this patch. I have some review
comments below.


> ---
>  MAINTAINERS                   |   2 +
>  hw/arm/fsl-imx6ul.c           |   9 +-
>  hw/arm/imx6ul_lcdif.c         | 409 ++++++++++++++++++++++++++++++++++
>  hw/arm/meson.build            |   5 +-
>  include/hw/arm/fsl-imx6ul.h   |   2 +-
>  include/hw/arm/imx6ul_lcdif.h |  37 +++
>  6 files changed, 460 insertions(+), 4 deletions(-)
>  create mode 100644 hw/arm/imx6ul_lcdif.c
>  create mode 100644 include/hw/arm/imx6ul_lcdif.h

We generally recommend splitting "implement the
new device" and "wire the new device into the board"
into separate patches.

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4918f41ec4..11c16ff387 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -895,8 +895,10 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/arm/mcimx6ul-evk.c
>  F: hw/arm/fsl-imx6ul.c
> +F: hw/arm/imx6ul_lcdif.c
>  F: hw/misc/imx6ul_ccm.c
>  F: include/hw/arm/fsl-imx6ul.h
> +F: include/hw/arm/imx6ul_lcdif.h
>  F: include/hw/misc/imx6ul_ccm.h
>  F: docs/system/arm/mcimx6ul-evk.rst
>
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 225e179126..419dba5b56 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -19,6 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/arm/fsl-imx6ul.h"
> +#include "hw/arm/imx6ul_lcdif.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/usb/imx-usb-phy.h"
>  #include "hw/core/boards.h"
> @@ -163,6 +164,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>      DeviceState *gic;
>      SysBusDevice *gicsbd;
>      DeviceState *cpu;
> +    DeviceState *lcdif;
>
>      if (ms->smp.cpus > 1) {
>          error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
> @@ -656,8 +658,11 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>      /*
>       * LCD
>       */
> -    create_unimplemented_device("lcdif", FSL_IMX6UL_LCDIF_ADDR,
> -                                FSL_IMX6UL_LCDIF_SIZE);
> +    lcdif = qdev_new(TYPE_IMX6UL_LCDIF);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(lcdif), &error_abort);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(lcdif), 0, FSL_IMX6UL_LCDIF_ADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(lcdif), 0,
> +                       qdev_get_gpio_in(gic, FSL_IMX6UL_LCDIF_IRQ));

Devices created by this SoC device should be done the way
the existing ones are -- you call object_initialize_child()
in the fsl_imx6ul_init() function to do the init stage, and
then sysbus_realize() and then map MMIO and connect the IRQ
in fsl_imx6ul_realize(). The qdev_new + sysbus_realize_and_unref
approach is generally only done in board level code.


>
>      /*
>       * CSU
> diff --git a/hw/arm/imx6ul_lcdif.c b/hw/arm/imx6ul_lcdif.c
> new file mode 100644
> index 0000000000..e2e42fbc26
> --- /dev/null
> +++ b/hw/arm/imx6ul_lcdif.c

This is a display device, so its source files should be in
hw/display/ and include/hw/display/. (hw/arm is only for
board code and SoC objects. Devices within the SoC go in
whichever subdirectory of hw/ fits best.)

> @@ -0,0 +1,409 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * i.MX6UL LCDIF controller
> + *
> + * Copyright (c) 2026

Copyright statements usually include who the copyright
owner is, not just the date.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/imx6ul_lcdif.h"
> +#include "hw/core/irq.h"
> +#include "hw/display/framebuffer.h"
> +#include "system/address-spaces.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "ui/pixel_ops.h"
> +
> +#define LCDIF_MMIO_SIZE             0x1000
> +
> +#define LCDC_CTRL                   0x00
> +#define LCDC_CTRL1                  0x10
> +#define LCDC_V4_TRANSFER_COUNT      0x30
> +#define LCDC_V4_CUR_BUF             0x40
> +#define LCDC_V4_NEXT_BUF            0x50
> +#define LCDC_AS_NEXT_BUF            0x230
> +
> +#define REG_SET                     0x4
> +#define REG_CLR                     0x8
> +#define REG_TOG                     0xc
> +
> +#define CTRL_RUN                    BIT(0)
> +#define CTRL_WORD_LENGTH_MASK       (0x3 << 8)
> +#define CTRL_WORD_LENGTH_16         (0x0 << 8)
> +#define CTRL_WORD_LENGTH_24         (0x3 << 8)
> +#define CTRL1_CUR_FRAME_DONE_IRQ_EN BIT(13)
> +#define CTRL1_CUR_FRAME_DONE_IRQ    BIT(9)

Prefer the FIELD() macro (in include/hw/core/registerfields.h)
for defining the layout fields and bits in registers, rather
than open-coding and using BIT().

> +#define FRAME_PERIOD_NS             (16 * 1000 * 1000ULL)
> +
> +static inline uint32_t imx6ul_lcdif_reg_idx(hwaddr offset)
> +{
> +    return (offset & ~0xf) >> 2;
> +}
> +
> +static inline uint32_t imx6ul_lcdif_reg_read(IMX6ULLCDIFState *s, hwaddr offset)
> +{
> +    return s->regs[imx6ul_lcdif_reg_idx(offset)];
> +}
> +
> +static inline void imx6ul_lcdif_reg_write(IMX6ULLCDIFState *s, hwaddr offset,
> +                                          uint32_t value)
> +{
> +    s->regs[imx6ul_lcdif_reg_idx(offset)] = value;
> +}
> +
> +static inline bool imx6ul_lcdif_is_running(IMX6ULLCDIFState *s)
> +{
> +    return imx6ul_lcdif_reg_read(s, LCDC_CTRL) & CTRL_RUN;
> +}
> +
> +static void imx6ul_lcdif_schedule_frame(IMX6ULLCDIFState *s)
> +{
> +    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    timer_mod(s->frame_timer, now + FRAME_PERIOD_NS);

We call this from the timer callback. Is it really necessary
to have a continuously running timer that fires every 16ms ?

> +}
> +
> +static void imx6ul_lcdif_update_irq(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, LCDC_CTRL1);
> +    bool level = (ctrl1 & CTRL1_CUR_FRAME_DONE_IRQ_EN) &&
> +                 (ctrl1 & CTRL1_CUR_FRAME_DONE_IRQ);
> +
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static void imx6ul_lcdif_frame_done(IMX6ULLCDIFState *s)
> +{
> +    uint32_t ctrl1 = imx6ul_lcdif_reg_read(s, LCDC_CTRL1);
> +
> +    imx6ul_lcdif_reg_write(s, LCDC_CTRL1, ctrl1 | CTRL1_CUR_FRAME_DONE_IRQ);
> +    imx6ul_lcdif_update_irq(s);
> +}
> +
> +static void imx6ul_lcdif_write_pixel(uint8_t **dst, uint8_t r,
> +                                     uint8_t g, uint8_t b, int dst_bpp)
> +{
> +    uint32_t rgb888;
> +
> +    switch (dst_bpp) {
> +    case 8:
> +        **dst = rgb_to_pixel8(r, g, b);
> +        *dst += 1;
> +        break;
> +    case 15:
> +        *(uint16_t *)*dst = rgb_to_pixel15(r, g, b);
> +        *dst += 2;
> +        break;
> +    case 16:
> +        *(uint16_t *)*dst = rgb_to_pixel16(r, g, b);
> +        *dst += 2;
> +        break;
> +    case 24:
> +        rgb888 = rgb_to_pixel24(r, g, b);
> +        (*dst)[0] = rgb888 & 0xff;
> +        (*dst)[1] = (rgb888 >> 8) & 0xff;
> +        (*dst)[2] = (rgb888 >> 16) & 0xff;
> +        *dst += 3;
> +        break;
> +    case 32:
> +        *(uint32_t *)*dst = rgb_to_pixel32(r, g, b);
> +        *dst += 4;
> +        break;
> +    default:
> +        break;
> +    }

This is overcomplicated, because we are always working on
the surface that we get from qemu_console_surface(). The UI
layer guarantees that the surface you get back from that is
32 bits per pixel (or 0 for not existing). So all this code
to handle writing to surfaces with other pixel widths is
dead code and can be dropped.

> +}
> +
> +static void imx6ul_lcdif_draw_line_rgb565(void *opaque, uint8_t *dst,
> +                                          const uint8_t *src, int width,
> +                                          int dststep)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +    uint16_t pixel;
> +    uint8_t r, g, b;
> +    int i;
> +
> +    for (i = 0; i < width; i++) {
> +        pixel = lduw_le_p((void *)src);

lduw_le_p() declares its argument as a void*, so you
don't need to explicitly cast it.

> +        r = ((pixel >> 11) & 0x1f) << 3;
> +        g = ((pixel >> 5) & 0x3f) << 2;
> +        b = (pixel & 0x1f) << 3;
> +        imx6ul_lcdif_write_pixel(&dst, r, g, b, s->dst_bpp);
> +        src += 2;
> +    }
> +}
> +
> +static void imx6ul_lcdif_draw_line_xrgb8888(void *opaque, uint8_t *dst,
> +                                            const uint8_t *src, int width,
> +                                            int dststep)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +    uint32_t pixel;
> +    uint8_t r, g, b;
> +    int i;
> +
> +    for (i = 0; i < width; i++) {
> +        pixel = ldl_le_p((void *)src);
> +        r = (pixel >> 16) & 0xff;
> +        g = (pixel >> 8) & 0xff;
> +        b = pixel & 0xff;
> +        imx6ul_lcdif_write_pixel(&dst, r, g, b, s->dst_bpp);
> +        src += 4;
> +    }
> +}
> +
> +static void imx6ul_lcdif_update_display(void *opaque)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +    DisplaySurface *surface = qemu_console_surface(s->con);
> +    uint32_t transfer_count = imx6ul_lcdif_reg_read(s, LCDC_V4_TRANSFER_COUNT);
> +    uint32_t width = transfer_count & 0xffff;
> +    uint32_t height = (transfer_count >> 16) & 0xffff;
> +    uint32_t ctrl = imx6ul_lcdif_reg_read(s, LCDC_CTRL);
> +    uint32_t frame_base = imx6ul_lcdif_reg_read(s, LCDC_V4_CUR_BUF);
> +    drawfn fn;
> +    int first = 0, last = 0;
> +    int src_width;
> +
> +    if (!imx6ul_lcdif_is_running(s) || width == 0 || height == 0) {
> +        return;
> +    }
> +
> +    s->dst_bpp = surface_bits_per_pixel(surface);
> +    if (s->dst_bpp == 0) {
> +        return;
> +    }
> +
> +    switch (ctrl & CTRL_WORD_LENGTH_MASK) {
> +    case CTRL_WORD_LENGTH_16:
> +        s->src_bpp = 2;
> +        fn = imx6ul_lcdif_draw_line_rgb565;
> +        break;
> +    case CTRL_WORD_LENGTH_24:
> +        s->src_bpp = 4;
> +        fn = imx6ul_lcdif_draw_line_xrgb8888;
> +        break;
> +    default:
> +        return;
> +    }
> +
> +    if (surface_width(surface) != width || surface_height(surface) != height) {
> +        qemu_console_resize(s->con, width, height);
> +        surface = qemu_console_surface(s->con);
> +        s->invalidate = true;
> +    }
> +
> +    src_width = width * s->src_bpp;
> +    if (s->invalidate || s->fb_base != frame_base ||
> +        s->src_width != src_width || s->rows != height) {
> +        framebuffer_update_memory_section(&s->fbsection, get_system_memory(),
> +                                          frame_base, height, src_width);
> +        s->fb_base = frame_base;
> +        s->src_width = src_width;
> +        s->rows = height;
> +    }
> +
> +    framebuffer_update_display(surface, &s->fbsection, width, height,
> +                               src_width, surface_stride(surface), 0,
> +                               s->invalidate, fn, s, &first, &last);
> +    if (first >= 0) {
> +        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
> +    }
> +
> +    s->invalidate = false;
> +}
> +
> +static void imx6ul_lcdif_invalidate_display(void *opaque)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +
> +    s->invalidate = true;
> +}
> +
> +static const GraphicHwOps imx6ul_lcdif_graphic_ops = {
> +    .invalidate = imx6ul_lcdif_invalidate_display,
> +    .gfx_update = imx6ul_lcdif_update_display,
> +};
> +
> +static void imx6ul_lcdif_frame_timer_cb(void *opaque)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +
> +    if (!imx6ul_lcdif_is_running(s)) {
> +        return;
> +    }
> +
> +    imx6ul_lcdif_frame_done(s);
> +    imx6ul_lcdif_schedule_frame(s);
> +}
> +
> +static uint64_t imx6ul_lcdif_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +    uint32_t idx;
> +
> +    if (size != 4 || (offset & 0x3) || offset >= LCDIF_MMIO_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad read offset=0x%" HWADDR_PRIx " size=%u\n",
> +                      TYPE_IMX6UL_LCDIF, offset, size);
> +        return 0;
> +    }
> +
> +    idx = imx6ul_lcdif_reg_idx(offset);
> +    return s->regs[idx];
> +}
> +
> +static void imx6ul_lcdif_write(void *opaque, hwaddr offset,
> +                               uint64_t value, unsigned size)
> +{
> +    IMX6ULLCDIFState *s = opaque;
> +    hwaddr reg = offset & ~0xf;
> +    uint32_t idx, oldv;
> +
> +    if (size != 4 || (offset & 0x3) || offset >= LCDIF_MMIO_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: bad write offset=0x%" HWADDR_PRIx " size=%u\n",
> +                      TYPE_IMX6UL_LCDIF, offset, size);
> +        return;

You can assert() this, rather than logging it, because
the MemoryRegionOps that you define will prevent us
from getting here with bad size and offset, regardless
of what the guest tries.

> +    }
> +
> +    idx = imx6ul_lcdif_reg_idx(reg);
> +    oldv = s->regs[idx];
> +
> +    switch (offset & 0xf) {
> +    case REG_SET:
> +        s->regs[idx] |= (uint32_t)value;
> +        break;
> +    case REG_CLR:
> +        s->regs[idx] &= ~(uint32_t)value;
> +        break;
> +    case REG_TOG:
> +        s->regs[idx] ^= (uint32_t)value;
> +        break;
> +    default:
> +        s->regs[idx] = (uint32_t)value;
> +        break;
> +    }
> +
> +    switch (reg) {
> +    case LCDC_CTRL:
> +        if (!(oldv & CTRL_RUN) && (s->regs[idx] & CTRL_RUN)) {
> +            imx6ul_lcdif_frame_done(s);
> +            imx6ul_lcdif_schedule_frame(s);
> +            s->invalidate = true;
> +            graphic_hw_invalidate(s->con);
> +            return;
> +        }
> +        if ((oldv & CTRL_RUN) && !(s->regs[idx] & CTRL_RUN)) {
> +            timer_del(s->frame_timer);
> +        }
> +        break;
> +    case LCDC_V4_TRANSFER_COUNT:
> +        s->invalidate = true;
> +        graphic_hw_invalidate(s->con);
> +        break;
> +    case LCDC_V4_CUR_BUF:
> +        s->invalidate = true;
> +        graphic_hw_invalidate(s->con);
> +        break;
> +    case LCDC_V4_NEXT_BUF:
> +        imx6ul_lcdif_reg_write(s, LCDC_V4_CUR_BUF, s->regs[idx]);
> +        imx6ul_lcdif_frame_done(s);
> +        if (imx6ul_lcdif_is_running(s)) {
> +            imx6ul_lcdif_schedule_frame(s);
> +        }
> +        s->invalidate = true;
> +        graphic_hw_invalidate(s->con);
> +        return;
> +    case LCDC_AS_NEXT_BUF:
> +        imx6ul_lcdif_frame_done(s);
> +        if (imx6ul_lcdif_is_running(s)) {
> +            imx6ul_lcdif_schedule_frame(s);
> +        }
> +        return;
> +    default:
> +        break;
> +    }
> +
> +    imx6ul_lcdif_update_irq(s);
> +}
> +
> +static const MemoryRegionOps imx6ul_lcdif_ops = {
> +    .read = imx6ul_lcdif_read,
> +    .write = imx6ul_lcdif_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +        .unaligned = false,
> +    },
> +};
> +
> +static void imx6ul_lcdif_reset(DeviceState *dev)
> +{
> +    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +    s->fb_base = 0;
> +    s->src_width = 0;
> +    s->rows = 0;
> +    s->src_bpp = 0;
> +    s->invalidate = true;
> +    timer_del(s->frame_timer);
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static void imx6ul_lcdif_realize(DeviceState *dev, Error **errp)
> +{
> +    IMX6ULLCDIFState *s = IMX6UL_LCDIF(dev);
> +
> +    s->frame_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> +                                  imx6ul_lcdif_frame_timer_cb, s);
> +    s->invalidate = true;
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &imx6ul_lcdif_ops, s,
> +                          TYPE_IMX6UL_LCDIF, LCDIF_MMIO_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
> +    s->con = graphic_console_init(dev, 0, &imx6ul_lcdif_graphic_ops, s);
> +}
> +
> +static void imx6ul_lcdif_finalize(Object *obj)
> +{
> +    IMX6ULLCDIFState *s = IMX6UL_LCDIF(obj);
> +
> +    if (s->fbsection.mr) {
> +        memory_region_set_log(s->fbsection.mr, false, DIRTY_MEMORY_VGA);
> +        memory_region_unref(s->fbsection.mr);
> +        s->fbsection.mr = NULL;
> +    }
> +    if (s->con) {
> +        graphic_console_close(s->con);
> +    }
> +    timer_free(s->frame_timer);
> +}
> +
> +static void imx6ul_lcdif_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = imx6ul_lcdif_realize;
> +    device_class_set_legacy_reset(dc, imx6ul_lcdif_reset);
> +    dc->desc = "i.MX6UL LCDIF";

This needs to also support migration by setting up a
vmstate struct.

> +}
> +
> +static const TypeInfo imx6ul_lcdif_info = {
> +    .name = TYPE_IMX6UL_LCDIF,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(IMX6ULLCDIFState),
> +    .instance_finalize = imx6ul_lcdif_finalize,
> +    .class_init = imx6ul_lcdif_class_init,
> +};
> +
> +static void imx6ul_lcdif_register_types(void)
> +{
> +    type_register_static(&imx6ul_lcdif_info);
> +}
> +
> +type_init(imx6ul_lcdif_register_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 47cdc51d13..afcaca55ba 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -87,7 +87,10 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>  arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
> -arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> +arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL',
> +                  if_true: files('fsl-imx6ul.c',
> +                                 'imx6ul_lcdif.c',
> +                                 'mcimx6ul-evk.c'))

You should give the new device a new Kconfig symbol, not
hang it off the SoC's config symbol. Look at for instance
how we handle hw/net/imx_fec.c: there's an IMX_FEC symbol
which is defined in hw/net/Kconfig and used to control
whether the file is compiled. Then when the device is added
to a particular SoC the "select IMX_FEC" line in that
SoC's Kconfig section says that when building the SoC we
also want to build that device.

>  arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>  arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
>    'xen-stubs.c',
> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
> index 4e3209b25b..cc41c2dbab 100644
> --- a/include/hw/arm/fsl-imx6ul.h
> +++ b/include/hw/arm/fsl-imx6ul.h
> @@ -143,7 +143,7 @@ enum FslIMX6ULMemoryMap {
>      FSL_IMX6UL_PXP_SIZE             = (16 * KiB),
>
>      FSL_IMX6UL_LCDIF_ADDR           = 0x021C8000,
> -    FSL_IMX6UL_LCDIF_SIZE           = 0x100,
> +    FSL_IMX6UL_LCDIF_SIZE           = 0x1000,
>
>      FSL_IMX6UL_CSI_ADDR             = 0x021C4000,
>      FSL_IMX6UL_CSI_SIZE             = 0x100,
> diff --git a/include/hw/arm/imx6ul_lcdif.h b/include/hw/arm/imx6ul_lcdif.h
> new file mode 100644
> index 0000000000..86da972d06
> --- /dev/null
> +++ b/include/hw/arm/imx6ul_lcdif.h
> @@ -0,0 +1,37 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * i.MX6UL LCDIF controller
> + *
> + * Copyright (c) 2026
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
> +    uint8_t dst_bpp;
> +    bool invalidate;
> +    uint32_t regs[0x1000 / sizeof(uint32_t)];
> +};
> +
> +#endif /* IMX6UL_LCDIF_H */
> --
> 2.53.0

thanks
-- PMM

