Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D5C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpmar-0003mg-1c; Fri, 31 Jul 2026 08:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpmam-0003iK-G2
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:44:00 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpmak-0001r9-4Y
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 08:44:00 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-80814edb536so13266107b3.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 05:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501837; cv=none;
 d=google.com; s=arc-20260327;
 b=ryh6hYXFKn87lrCw9SBtlWnKeTf8++Noi2u5ZQaXRY0ZuC6uXqY9U4Sa0blrl17yTS
 TxKyBt2wcQ6tD8mPn13sV5grpEkdAVrBe7q+0/682jzS2Ivu836oz22kkXbIEwRfkTGq
 wrtts3buGIO1Af4fK2zqS0Z5A4Cr7aa4c1MiV4DR8xZVCBno0nfWzq+NCn/Gp6tSSoSj
 Te7sSHXi+JJhTBXHtNtdashuvZVQakNpeg7XVUtDUMq4Bd7zpF4wMWmhP2d5wlvygA01
 X0ysuuy6mruciU92ngVjU8/3HsDxrjO2SNDpXqJzKlm9yALj0vX/uU5RbfUJKUYCo0MH
 iXfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YKhRKnx/CGTVrAkbUXVVin8hQ9T4iVdlRQoQ0Sii65k=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=OhyQfIHkrKNCbfSFbFDWxkxRH/VYDEjklR5oXeWDbylYaukicpb4FqRxd8C+MQcsA+
 rYK/qDlnnq1JU3nZm1e6I+NQsHbWFn6HQuveSeXQmFlPMHjMW8appONnNBYzpzjFhDeD
 GVRWcSVkNNAtMrNBwmQ+bBNm/+kAzY6zaj8xMe1PQSHiKWu0ULD/NJidTodHtt2F7w8t
 SxTsr4JZtNW8ApDDFGIgGLaioadi60ngV/gkzwhGovCfH/rl7EEJlcm5IIuBaBmSlV+J
 l+N0evMssjkcG7an4xIqJsTb7nxTeF5wViRcqfkRLDTbB26TURyoXR3NS+/WZvou1X3y
 Jn9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785501837; x=1786106637; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YKhRKnx/CGTVrAkbUXVVin8hQ9T4iVdlRQoQ0Sii65k=;
 b=uDHPgUXnNjQpr/14AbTkfP75UxrR0CjuzRiKM826ombpUlTnyNAfMWr6omb8fkMaWM
 UK5neBqq9jkmIBzuvsarH3arwzyExILE0V4MMkQ+qAt+3bYMF8YLuEjUiWAgkjJQCc3U
 4zvEArl/kp/PJK6dirfBsyELISkABylLUPC4bRdLLfNB7pJfjQPqQBRpUM0dc2Zuz9h3
 mDGgwqdl5b0XWTsS0+eFWDJc4CTkSmlOhjUk6WguRi3d/9Rh/C6HjaoDDcCjPAWxnmI9
 c//qNK9u5yHgbjdUuF5b8g3y+mU5wp0V1CzsGmw53q4IBTD0q4IcAZnFLW9rBaeoB79D
 KAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501837; x=1786106637;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YKhRKnx/CGTVrAkbUXVVin8hQ9T4iVdlRQoQ0Sii65k=;
 b=PzDHfBQIPTZKdwp65rGthJwTrW4hxkziBGMQvYWr70czRbYn2oVx0eyUOxlfM2Qyio
 f5+aCslp7sYRBPmEvRhTIhE+Go8F3elLaSbVGIG/V1Toz2FMkAwDsgvorhBmc/r44bXC
 xT/sglvi8tRuSwzXE9ekW8E00Sk/AjzpEexCl6tQ9L0EQykD/v+32CudZugh0j2wp1XN
 Rh9HXwFEy0V7MSsMvmyVY4d+m4aOFOzSKeYRNa8edhoAq6IRql2/DPHCcgtLzpo6TDK0
 +jrYVojwjHt98s4BXGPALlXISqFyXGZJIaD1fbWxSxThYhsfp14PMEbhr+exZ+7/Vzwr
 uA2w==
X-Gm-Message-State: AOJu0YzBI0CVeNy6USphtOsoRxqSTdVvzVYSI3wOkgnndDTXIwNWJaKa
 OOdORMbb3Er86UahQDpah+W4h7bJa3HH4YohglYp/5rrgrUOUsQ+le/AInjVmfHnDssc6wznuMj
 u25055uTyoZsD8Zf2VYkxBWWSi9TYGqg9GdCg38TKyA==
X-Gm-Gg: AR+sD13WtLh2hK5JqlMEHvr6BegK2uK/dnIjHDQo+2iIuRFOoz0afN25crTvHeV1hS/
 XFwNZM9bz/wVWeO60F1436tTyBOJa8dfXoGxq87EGxGe48F1iVjNv/8p9I+TEoQVqOB8MmkJi8Y
 R0E8SER06m2Cy+EEioeS7JMyp1T3cVBHaK7L9ddIDPUdxdXHIo/NbuvqhdcMfNuOnqwPu6zwSqL
 y/4mguZSYv21URLg70sve2wT0/snZK2hYH4GfmhAxuwrfJ7rM50pt4L/cZRpnxG049wLiaWEiTx
 sh06dPCzMPnzlvS6a+qVDq6r+0y5Ku0ljDvkFPIOJrpCsX4BUQQabPkTbOl70kYkLDoJpMHDjKx
 XTM4udlkMw6/6XWE3iJ2eV8TszjsARuGsOF3+mzk=
X-Received: by 2002:a05:690c:d84:b0:81d:489e:8847 with SMTP id
 00721157ae682-81fcb970bf4mr16975837b3.2.1785501836554; Fri, 31 Jul 2026
 05:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260723233605.805-1-simonxhy0404@gmail.com>
 <20260723233605.805-5-simonxhy0404@gmail.com>
In-Reply-To: <20260723233605.805-5-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 13:43:44 +0100
X-Gm-Features: AUfX_myPhI4xlDgRLkatTZ5tru0a5ALAhaVCVPHpB8Lrx7xYNrTBMTiQDjpgVrI
Message-ID: <CAFEAcA8_VTfU-7xvR=Nii8nC_SEPvv0VtZEVQD6zdg=bJFnHTA@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm/mps2-tz.c: add new mps3-an555 board
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 24 Jul 2026 at 00:36, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add mps3-an555 board modeled after the existing mps3-an547 board.
> - Add additional AHB PPC EXP 1. Add unimplemented timing adapters for SSE-310.
> - Include documentation for SSE-310 and mps3-an555.
>
> Arm mps3-an555 TRM: https://developer.arm.com/documentation/107642/latest/
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
>  docs/system/arm/mps2.rst |   6 +-
>  hw/arm/mps2-tz.c         | 143 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 144 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
> index a305935cc4..489a8b0fa7 100644
> --- a/docs/system/arm/mps2.rst
> +++ b/docs/system/arm/mps2.rst
> @@ -1,5 +1,5 @@
> -Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an536``, ``mps3-an547``)
> -=========================================================================================================================================================================
> +Arm MPS2 and MPS3 boards (``mps2-an385``, ``mps2-an386``, ``mps2-an500``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``, ``mps3-an524``, ``mps3-an536``, ``mps3-an547``, ``mps3-an555``)
> +=========================================================================================================================================================================================
>
>  These board models use Arm M-profile or R-profile CPUs.
>
> @@ -31,6 +31,8 @@ FPGA images using M-profile CPUs:
>    Dual Cortex-M33 on an MPS3, as documented in Arm Application Note AN524
>  ``mps3-an547``
>    Cortex-M55 on an MPS3, as documented in Arm Application Note AN547
> +``mps3-an555``
> +  Cortex-M85 on an MPS3, as documented in Arm Application Note AN555
>
>  FPGA images using R-profile CPUs:
>
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index f101c1b7c3..04a2b37fd8 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -1,5 +1,5 @@
>  /*
> - * ARM V2M MPS2 board emulation, trustzone aware FPGA images
> + * Arm V2M MPS2 and MPS3 board emulation, trustzone aware FPGA images
>   *
>   * Copyright (c) 2017 Linaro Limited
>   * Written by Peter Maydell
> @@ -18,12 +18,13 @@
>   *  "mps2-an521" -- Dual Cortex-M33 as documented in Application Note AN521
>   *  "mps2-an524" -- Dual Cortex-M33 as documented in Application Note AN524
>   *  "mps2-an547" -- Single Cortex-M55 as documented in Application Note AN547
> + *  "mps3-an555" -- Single Cortex-M85 as documented in Application Note AN555
>   *
>   * Links to the TRM for the board itself and to the various Application
>   * Notes which document the FPGA images can be found here:
>   * https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/mps2
>   *
> - * Board TRM:
> + * MPS2 and MPS2+ Board TRM:
>   * https://developer.arm.com/documentation/100112/latest/
>   * Application Note AN505:
>   * https://developer.arm.com/documentation/dai0505/latest/
> @@ -31,8 +32,12 @@
>   * https://developer.arm.com/documentation/dai0521/latest/
>   * Application Note AN524:
>   * https://developer.arm.com/documentation/dai0524/latest/
> + * MPS3 Board TRM:
> + * https://developer.arm.com/documentation/100765/latest/

I think we should put the MPS3 board TRM link after the MPS2
board TRM link, and before all the application note links.

>   * Application Note AN547:
>   * https://developer.arm.com/documentation/dai0547/latest/
> + * Application Note AN555:
> + * https://developer.arm.com/documentation/107642/latest/
>   *
>   * The AN505 defers to the Cortex-M33 processor ARMv8M IoT Kit FVP User Guide
>   * (ARM ECM0601256) for the details of some of the device layout:
> @@ -42,6 +47,8 @@
>   *  https://developer.arm.com/documentation/101104/latest/
>   * and the AN547 uses the SSE-300, whose layout is in the SSE-300 TRM:
>   *  https://developer.arm.com/documentation/101773/latest/
> + * and the AN555 uses the SSE-310, whose layout is in the SSE-310 TRM:
> + *  https://developer.arm.com/documentation/102778/latest/
>   */
>
>  #include "qemu/osdep.h"
> @@ -77,7 +84,7 @@
>  #include "qom/object.h"
>  #include "hw/core/irq.h"
>
> -#define MPS2TZ_NUMIRQ_MAX 96
> +#define MPS2TZ_NUMIRQ_MAX 100

Why did you need to update this? The AN555 appnote documents that
interrupts go from 0 to 127; 0..31 are the ones in the SSE, and 32..127
are the "external" ones. NUMIRQ for this code is the number of external
interrupts, so 127 - 31 == 96. Like the AN547, the highest interrupt
is 127, from UART5. So I think that 96 should be the right value for
AN555 also.

> @@ -1103,6 +1121,72 @@ static void mps2tz_common_init(MachineState *machine)
>          },
>      };
>
> +    const PPCInfo an555_ppcs[] = { {
> +            .name = "apb_ppcexp0",
> +            .ports = {
> +                { "ssram-mpc", make_mpc, &mms->mpc[0], 0x57000000, 0x1000 },
> +                { "qspi-mpc", make_mpc, &mms->mpc[1], 0x57001000, 0x1000 },
> +                { "ddr-mpc", make_mpc, &mms->mpc[2], 0x57002000, 0x1000 },

The 555 appnote says that APB PPC EXP0 has the timing adapters in
it, not the MPCs. (Table 6-3.)

(We seem to get this differently wrong for SSE-300, where the MPCs
should be on ports 13, 14, 15, not 0, 1, 2.)

> +            },
> +        }, {
> +            .name = "apb_ppcexp1",
> +            .ports = {
> +                { "i2c0", make_i2c, &mms->i2c[0], 0x49200000, 0x1000, {},
> +                  { .i2c_internal = true /* touchscreen */ } },
> +                { "i2c1", make_i2c, &mms->i2c[1], 0x49201000, 0x1000, {},
> +                  { .i2c_internal = true /* audio conf */ } },
> +                { "spi0", make_spi, &mms->spi[0], 0x49202000, 0x1000, { 53 } },
> +                { "spi1", make_spi, &mms->spi[1], 0x49203000, 0x1000, { 54 } },
> +                { "spi2", make_spi, &mms->spi[2], 0x49204000, 0x1000, { 55 } },
> +                { "i2c2", make_i2c, &mms->i2c[2], 0x49205000, 0x1000, {},
> +                  { .i2c_internal = false /* shield 0 */ } },
> +                { "i2c3", make_i2c, &mms->i2c[3], 0x49206000, 0x1000, {},
> +                  { .i2c_internal = false /* shield 1 */ } },
> +                { /* port 7 reserved */ },
> +                { "i2c4", make_i2c, &mms->i2c[4], 0x49208000, 0x1000, {},
> +                  { .i2c_internal = true /* DDR4 EEPROM */ } },
> +            },
> +        }, {
> +            .name = "apb_ppcexp2",
> +            .ports = {
> +                { "scc", make_scc, &mms->scc, 0x49300000, 0x1000 },
> +                { "i2s-audio", make_unimp_dev, &mms->i2s_audio, 0x49301000, 0x1000 },
> +                { "fpgaio", make_fpgaio, &mms->fpgaio, 0x49302000, 0x1000 },
> +                { "uart0", make_uart, &mms->uart[0], 0x49303000, 0x1000, { 33, 34, 43 } },
> +                { "uart1", make_uart, &mms->uart[1], 0x49304000, 0x1000, { 35, 36, 44 } },
> +                { "uart2", make_uart, &mms->uart[2], 0x49305000, 0x1000, { 37, 38, 45 } },
> +                { "uart3", make_uart, &mms->uart[3], 0x49306000, 0x1000, { 39, 40, 46 } },
> +                { "uart4", make_uart, &mms->uart[4], 0x49307000, 0x1000, { 41, 42, 47 } },
> +                { "uart5", make_uart, &mms->uart[5], 0x49308000, 0x1000, { 125, 126, 127 } },
> +
> +                { /* port 9 reserved */ },
> +                { "clcd", make_unimp_dev, &mms->cldc, 0x4930a000, 0x1000 },
> +                { "rtc", make_rtc, &mms->rtc, 0x4930b000, 0x1000 },
> +            },
> +        }, {
> +            .name = "ahb_ppcexp0",
> +            .ports = {
> +                { "gpio0", make_unimp_dev, &mms->gpio[0], 0x41100000, 0x1000 },
> +                { "gpio1", make_unimp_dev, &mms->gpio[1], 0x41101000, 0x1000 },
> +                { "gpio2", make_unimp_dev, &mms->gpio[2], 0x41102000, 0x1000 },
> +                { "gpio3", make_unimp_dev, &mms->gpio[3], 0x41103000, 0x1000 },
> +                { /* port 4 USER AHB interface 0 */ },
> +                { /* port 5 USER AHB interface 1 */ },
> +                { /* port 6 USER AHB interface 2 */ },
> +                { /* port 7 USER AHB interface 3 */ },
> +                { "eth-usb", make_eth_usb, NULL, 0x41400000, 0x200000, { 49 } },

13..15 are QSPI read/write controllers; we should have make_unimp_dev
lines for them,
I think.

> +            },
> +        }, {
> +            .name = "ahb_ppcexp1",
> +            .ports = {
> +                { "dma0", make_dma, &mms->dma[0], 0x41200000, 0x1000, { 59, 57, 58 } },
> +                { "dma1", make_dma, &mms->dma[1], 0x41201000, 0x1000, { 62, 60, 61 } },
> +                { "dma2", make_dma, &mms->dma[2], 0x41202000, 0x1000, { 65, 63, 64 } },
> +                { "dma3", make_dma, &mms->dma[3], 0x41203000, 0x1000, { 68, 66, 67 } },

(It looks like we get this wrong on the AN547 -- it also has an AHB PPCEXP1,
which has DMA1, 2, 3 in it (but not 0).)

> +            },
> +        },
> +    };
> +
>      switch (mmc->fpga_type) {
>      case FPGA_AN505:
>      case FPGA_AN521:
> @@ -1117,6 +1201,10 @@ static void mps2tz_common_init(MachineState *machine)
>          ppcs = an547_ppcs;
>          num_ppcs = ARRAY_SIZE(an547_ppcs);
>          break;
> +    case FPGA_AN555:
> +        ppcs = an555_ppcs;
> +        num_ppcs = ARRAY_SIZE(an555_ppcs);
> +        break;
>      default:
>          g_assert_not_reached();
>      }
> @@ -1200,6 +1288,12 @@ static void mps2tz_common_init(MachineState *machine)
>          create_unimplemented_device("U55 timing adapter 1", 0x48103000, 0x1000);
>      }
>
> +    if (mmc->fpga_type == FPGA_AN555) {
> +        create_unimplemented_device("FPGA SRAM timing adapter", 0x41700000, 0x1000);
> +        create_unimplemented_device("QSPI timing adapter", 0x41701000, 0x1000);
> +        create_unimplemented_device("DDR4 timing adapter", 0x41702000, 0x1000);
> +    }

As noted above, these seem to be behind one of the PPCs, so we should
create those via the PPC data tables, and create the MPCs in code here.

> +
>      create_non_mpc_ram(mms);
>
>      if (mmc->fpga_type == FPGA_AN524) {
> @@ -1447,6 +1541,41 @@ static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
>      mps2tz_set_default_ram_info(mmc);
>  }
>
> +static void mps3tz_an555_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-m85"),
> +        NULL
> +    };
> +
> +    mc->desc = "ARM MPS3 with AN555 FPGA image for Cortex-M85";
> +    mc->default_cpus = 1;
> +    mc->min_cpus = mc->default_cpus;
> +    mc->max_cpus = mc->default_cpus;
> +    mmc->fpga_type = FPGA_AN555;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m85");
> +    mc->valid_cpu_types = valid_cpu_types;
> +    mmc->scc_id = 0x41055551;
> +    mmc->sysclk_frq = 25 * 1000 * 1000; /* 25MHz */
> +    mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
> +    mmc->oscclk = an555_oscclk;
> +    mmc->len_oscclk = ARRAY_SIZE(an555_oscclk);
> +    mmc->fpgaio_num_leds = 10;
> +    mmc->fpgaio_has_switches = true;
> +    mmc->fpgaio_has_dbgctrl = true;

These fpgaio tweaks are all correct, but the AN555 FPGAIO
block has an extra register, GPIOALT2 at 0xc. Ideally we should
implement that to at least be "reads as written, LOG_UNIMP
for writes". (The register technically exists on AN547 but
only as "all bits reserved".)

thanks
-- PMM

