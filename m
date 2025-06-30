Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C4C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDGm-0006kl-HO; Mon, 30 Jun 2025 08:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDGQ-0006gL-1W
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:05:34 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWDGK-0001Wo-Nb
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:05:33 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6facf4d8ea8so24580656d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751285127; x=1751889927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVEGlBVz15aZocQhIP02vT7tkofTR5VSjqCT1Kk9Di8=;
 b=YGzns9PaDiFPiKlTc3Mmx80VkTnXZBppT3nmhPWlKwvom5fJrqsSWVf2drKe50Qn+U
 RABcCH9TxpaFUUKhvfhZiqjVLRhgpwNmI5zUqz87sPEpcLchgE1JHwgASOwFIWl7y4Gx
 ce3pmx/Xi1cHLMWjk6m5pn2/5JuLWK/E/kZfK8bX0W24el4OvGeXHkvpbCNJsnY9jFVt
 zwrAS1SlKN081skM+82LrZqXMUwRp9wNB/I1DdysO+0zAwsksAbWyI0ne8J7u+x5utj/
 0YqRzYPcbOHMciJe/vFl2GQ/jSzEIlF2LoCHwcnnBeIHOG26FTxDoTLAOLCY2RRU7Rk3
 twEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751285127; x=1751889927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVEGlBVz15aZocQhIP02vT7tkofTR5VSjqCT1Kk9Di8=;
 b=FtAx8ZErcFg4fs4DmUt0+gbgqprhccoFAuAtnPSnrShCR5Yt8+eXRz86m2k54f1ZQQ
 TvryzXVbFTLyENALH7tZlb/v9mhu8o+XOKwvHgzzO4xyYkurmJ6prPzAdsfKya/SGafX
 uo2HfB+SAOZdbOOJioFFOXWP5PR0cvFVk/bCkVkBvBfwCX51GxjkcgRoahxaCdnHNLPk
 vhZCBXYAfqWemk5nZ53LRKCzI4YMwQ5HIfv1nAFMyihaHuWHMjRfaxgJ6NpmFrd4RWWx
 m5BsI5XSDgO3BNivItnC88i8cdAiIFkFgSl0uWo1mY6/9LsHAnSwiD6D+RcyzVLyfnam
 sm/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiPUhyKcbftrFPrrNqRrQ1RX0s0M0tWNKbmGEDOINNCnzQs7+/gJCmywqhUSPJQrE2Wn6vTX5V7qI8@nongnu.org
X-Gm-Message-State: AOJu0YwRqfLSgb6Zz8ABFA0lksYrql0womPYrjo4sXzGuzkKkj7+Cg7R
 U+EkxOFAkHqxAM9uRzok+OqMoEmz6U3hr9pdfKJFC7oVOB3Mf1udyAYt5wzAT5GIDOI=
X-Gm-Gg: ASbGncsyELgwD007X45dw+SrGiqxmHHwQHFK5gQRtcKLrKUffE8M8FIKGqHApMom0QD
 A15QDdgMNwGbfePcl7HEriBQecB+F6FyyHJKMcaXx1sQRQz1TLtbXsTZLCo3yCaWe+u9b5H3dPx
 s3s/Zm/HIK7AghflWS3BOPoos1fiorhoELJ+WuiW/9iYkk1WCWkO/0/MTm+YcIbI0lf8NQuPpCG
 0082RGktccBTvyBRKIF0LJz0amSEQvI5PwOGv2wYBBRHsb1Gd0sz+3QyKn2ikEAN98wCLf+IP5h
 q3ohY3brW9WdEhxFubDLbJrN9HPK2sfGPkHCyUS5JPU43d0kicjazvI9las2bBsr87zhFmpfx+M
 =
X-Google-Smtp-Source: AGHT+IHszGCpaahm4F+9+dp4XBowcc4lFK7sNaEs8WhqddNczLD3cTc0ZzIJBz8GAztFd6ZGbQcO6A==
X-Received: by 2002:a05:6214:ca6:b0:6fb:4b54:ebb with SMTP id
 6a1803df08f44-700026284d9mr229299496d6.14.1751285126343; 
 Mon, 30 Jun 2025 05:05:26 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7718eae0sm66854406d6.20.2025.06.30.05.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 05:05:25 -0700 (PDT)
Message-ID: <d14e78d9-6b7b-401b-a16b-9401b077b470@ventanamicro.com>
Date: Mon, 30 Jun 2025 09:05:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] hw/riscv: Add support for MIPS Boston-aia board
 model
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-10-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-10-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf31.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Ex: Use 4 cores and 2 threads with each core to
> have 8 smp cpus as follows.
>    qemu-system-riscv64 -cpu mips-p8700 \
>    -m 2G -M boston-aia \
>    -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
>    -drive file=rootfs.ext2,format=raw -serial stdio
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   configs/devices/riscv64-softmmu/default.mak |   1 +
>   docs/system/riscv/mips.rst                  |  25 +
>   docs/system/target-riscv.rst                |   1 +
>   hw/riscv/Kconfig                            |   6 +
>   hw/riscv/boston-aia.c                       | 484 ++++++++++++++++++++
>   hw/riscv/cps.c                              | 187 ++++++++
>   hw/riscv/meson.build                        |   1 +
>   include/hw/riscv/cps.h                      |  75 +++
>   8 files changed, 780 insertions(+)
>   create mode 100644 docs/system/riscv/mips.rst
>   create mode 100644 hw/riscv/boston-aia.c
>   create mode 100644 hw/riscv/cps.c
>   create mode 100644 include/hw/riscv/cps.h
> 
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
> index 39ed3a0061..2f4f92b978 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -11,3 +11,4 @@
>   # CONFIG_RISCV_VIRT=n
>   # CONFIG_MICROCHIP_PFSOC=n
>   # CONFIG_SHAKTI_C=n
> +# CONFIG_MIPS_BOSTON_AIA=n
> diff --git a/docs/system/riscv/mips.rst b/docs/system/riscv/mips.rst
> new file mode 100644
> index 0000000000..c05c6f19d6
> --- /dev/null
> +++ b/docs/system/riscv/mips.rst
> @@ -0,0 +1,25 @@
> +Boards for RISC-V Processors by MIPS
> +====================================
> +
> +RISC-V processors developed by MIPS support Boston-aia board model. The board
> +model supports up to 64 harts with MIPS CPS, MIPS GCR, MIPS CPC, AIA plic,
> +and AIA clint devices. The model can create boot code, if there is no
> +```-bios``` parameter. Also, we can specify ```-smp x,cores=y,thread=z```.
> +
> +Enable Boston-aia
> +-----------------
> +
> +To build qemu with support for ``Boston-aia`` set ```CONFIG_MIPS_BOSTON_AIA=y``.
> +
> +Running Linux kernel
> +--------------------
> +
> +For example, to use 4 cores and 2 threads with each core to have 8 smp cpus,
> +that runs on the ```mips-p8700``` CPU, run qemu as follows:
> +
> +.. code-block:: bash
> +
> +   qemu-system-riscv64 -cpu mips-p8700 \
> +         -m 2G -M boston-aia \
> +         -smp 8,cores=4,threads=2 -kernel fw_payload.bin \
> +         -drive file=rootfs.ext2,format=raw -serial stdio
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 95457af130..9e11bb25c9 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
>   
>      riscv/microblaze-v-generic
>      riscv/microchip-icicle-kit
> +   riscv/mips
>      riscv/shakti-c
>      riscv/sifive_u
>      riscv/virt
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index e6a0ac1fa1..047c6d8ae7 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -119,3 +119,9 @@ config SPIKE
>       select HTIF
>       select RISCV_ACLINT
>       select SIFIVE_PLIC
> +
> +config MIPS_BOSTON_AIA
> +    bool
> +    default y
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_XILINX
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> new file mode 100644
> index 0000000000..6ed5c636cc
> --- /dev/null
> +++ b/hw/riscv/boston-aia.c
> @@ -0,0 +1,484 @@
> +/*
> + * MIPS Boston-aia development board emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> +*/
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +
> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/loader.h"
> +#include "hw/riscv/cps.h"
> +#include "hw/pci-host/xilinx-pcie.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "chardev/char.h"
> +#include "system/address-spaces.h"
> +#include "system/device_tree.h"
> +#include "system/system.h"
> +#include "system/qtest.h"
> +#include "system/runstate.h"
> +
> +#include <libfdt.h>
> +#include "qom/object.h"
> +
> +#define TYPE_MIPS_BOSTON_AIA "mips-boston-aia"
> +typedef struct BostonState BostonState;
> +DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
> +                         TYPE_MIPS_BOSTON_AIA)
> +
> +enum {
> +    BOSTON_PCIE2,
> +    BOSTON_PCIE2_MMIO,
> +    BOSTON_PLATREG,
> +    BOSTON_UART,
> +    BOSTON_LCD,
> +    BOSTON_FLASH,
> +    BOSTON_HIGHDDR,
> +};
> +
> +static const MemMapEntry boston_memmap[] = {
> +    [BOSTON_PCIE2] =      { 0x14000000,     0x2000000 },
> +    [BOSTON_PCIE2_MMIO] = { 0x16000000,      0x100000 },
> +    [BOSTON_PLATREG] =    { 0x17ffd000,        0x1000 },
> +    [BOSTON_UART] =       { 0x17ffe000,          0x20 },
> +    [BOSTON_LCD] =        { 0x17fff000,           0x8 },
> +    [BOSTON_FLASH] =      { 0x18000000,     0x8000000 },
> +    [BOSTON_HIGHDDR] =    { 0x80000000,           0x0 },
> +};
> +
> +/* Interrupt numbers for APLIC. */
> +#define UART_INT 4
> +#define PCIE2_INT 7
> +
> +struct BostonState {
> +    SysBusDevice parent_obj;
> +
> +    MachineState *mach;
> +    RISCVCPSState cps;
> +    SerialMM *uart;
> +
> +    CharBackend lcd_display;
> +    char lcd_content[8];
> +    bool lcd_inited;
> +};
> +
> +enum boston_plat_reg {
> +    PLAT_FPGA_BUILD     = 0x00,
> +    PLAT_CORE_CL        = 0x04,
> +    PLAT_WRAPPER_CL     = 0x08,
> +    PLAT_SYSCLK_STATUS  = 0x0c,
> +    PLAT_SOFTRST_CTL    = 0x10,
> +#define PLAT_SOFTRST_CTL_SYSRESET       (1 << 4)
> +    PLAT_DDR3_STATUS    = 0x14,
> +#define PLAT_DDR3_STATUS_LOCKED         (1 << 0)
> +#define PLAT_DDR3_STATUS_CALIBRATED     (1 << 2)
> +#define PLAT_DDR3_INTERFACE_RESET       (1 << 3)
> +    PLAT_PCIE_STATUS    = 0x18,
> +#define PLAT_PCIE_STATUS_PCIE0_LOCKED   (1 << 0)
> +#define PLAT_PCIE_STATUS_PCIE1_LOCKED   (1 << 8)
> +#define PLAT_PCIE_STATUS_PCIE2_LOCKED   (1 << 16)
> +    PLAT_FLASH_CTL      = 0x1c,
> +    PLAT_SPARE0         = 0x20,
> +    PLAT_SPARE1         = 0x24,
> +    PLAT_SPARE2         = 0x28,
> +    PLAT_SPARE3         = 0x2c,
> +    PLAT_MMCM_DIV       = 0x30,
> +#define PLAT_MMCM_DIV_CLK0DIV_SHIFT     0
> +#define PLAT_MMCM_DIV_INPUT_SHIFT       8
> +#define PLAT_MMCM_DIV_MUL_SHIFT         16
> +#define PLAT_MMCM_DIV_CLK1DIV_SHIFT     24
> +    PLAT_BUILD_CFG      = 0x34,
> +#define PLAT_BUILD_CFG_IOCU_EN          (1 << 0)
> +#define PLAT_BUILD_CFG_PCIE0_EN         (1 << 1)
> +#define PLAT_BUILD_CFG_PCIE1_EN         (1 << 2)
> +#define PLAT_BUILD_CFG_PCIE2_EN         (1 << 3)
> +    PLAT_DDR_CFG        = 0x38,
> +#define PLAT_DDR_CFG_SIZE               (0xf << 0)
> +#define PLAT_DDR_CFG_MHZ                (0xfff << 4)
> +    PLAT_NOC_PCIE0_ADDR = 0x3c,
> +    PLAT_NOC_PCIE1_ADDR = 0x40,
> +    PLAT_NOC_PCIE2_ADDR = 0x44,
> +    PLAT_SYS_CTL        = 0x48,
> +};
> +
> +static void boston_lcd_event(void *opaque, QEMUChrEvent event)
> +{
> +    BostonState *s = opaque;
> +    if (event == CHR_EVENT_OPENED && !s->lcd_inited) {
> +        qemu_chr_fe_printf(&s->lcd_display, "        ");
> +        s->lcd_inited = true;
> +    }
> +}
> +
> +static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
> +                                unsigned size)
> +{
> +    BostonState *s = opaque;
> +    uint64_t val = 0;
> +
> +    switch (size) {
> +    case 8:
> +        val |= (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
> +        val |= (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
> +        val |= (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
> +        val |= (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
> +        /* fall through */
> +    case 4:
> +        val |= (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
> +        val |= (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
> +        /* fall through */
> +    case 2:
> +        val |= (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
> +        /* fall through */
> +    case 1:
> +        val |= (uint64_t)s->lcd_content[(addr + 0) & 0x7];
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void boston_lcd_write(void *opaque, hwaddr addr,
> +                             uint64_t val, unsigned size)
> +{
> +    BostonState *s = opaque;
> +
> +    switch (size) {
> +    case 8:
> +        s->lcd_content[(addr + 7) & 0x7] = val >> 56;
> +        s->lcd_content[(addr + 6) & 0x7] = val >> 48;
> +        s->lcd_content[(addr + 5) & 0x7] = val >> 40;
> +        s->lcd_content[(addr + 4) & 0x7] = val >> 32;
> +        /* fall through */
> +    case 4:
> +        s->lcd_content[(addr + 3) & 0x7] = val >> 24;
> +        s->lcd_content[(addr + 2) & 0x7] = val >> 16;
> +        /* fall through */
> +    case 2:
> +        s->lcd_content[(addr + 1) & 0x7] = val >> 8;
> +        /* fall through */
> +    case 1:
> +        s->lcd_content[(addr + 0) & 0x7] = val;
> +        break;
> +    }
> +
> +    qemu_chr_fe_printf(&s->lcd_display,
> +                       "\r%-8.8s", s->lcd_content);
> +}
> +
> +static const MemoryRegionOps boston_lcd_ops = {
> +    .read = boston_lcd_read,
> +    .write = boston_lcd_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
> +                                    unsigned size)
> +{
> +    BostonState *s = opaque;
> +    uint32_t gic_freq, val;
> +
> +    if (size != 4) {
> +        qemu_log_mask(LOG_UNIMP, "%uB platform register read\n", size);
> +        return 0;
> +    }
> +
> +    switch (addr & 0xffff) {
> +    case PLAT_FPGA_BUILD:
> +    case PLAT_CORE_CL:
> +    case PLAT_WRAPPER_CL:
> +        return 0;
> +    case PLAT_DDR3_STATUS:
> +        return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED
> +               | PLAT_DDR3_INTERFACE_RESET;
> +    case PLAT_MMCM_DIV:
> +        gic_freq = 25000000 / 1000000;
> +        val = gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
> +        val |= 1 << PLAT_MMCM_DIV_MUL_SHIFT;
> +        val |= 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
> +        val |= 1 << PLAT_MMCM_DIV_CLK1DIV_SHIFT;
> +        return val;
> +    case PLAT_BUILD_CFG:
> +        val = PLAT_BUILD_CFG_PCIE0_EN;
> +        val |= PLAT_BUILD_CFG_PCIE1_EN;
> +        val |= PLAT_BUILD_CFG_PCIE2_EN;
> +        return val;
> +    case PLAT_DDR_CFG:
> +        val = s->mach->ram_size / GiB;
> +        assert(!(val & ~PLAT_DDR_CFG_SIZE));
> +        val |= PLAT_DDR_CFG_MHZ;
> +        return val;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx "\n",
> +                      addr & 0xffff);
> +        return 0;
> +    }
> +}
> +
> +static void boston_platreg_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    if (size != 4) {
> +        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
> +        return;
> +    }
> +
> +    switch (addr & 0xffff) {
> +    case PLAT_FPGA_BUILD:
> +    case PLAT_CORE_CL:
> +    case PLAT_WRAPPER_CL:
> +    case PLAT_DDR3_STATUS:
> +    case PLAT_PCIE_STATUS:
> +    case PLAT_MMCM_DIV:
> +    case PLAT_BUILD_CFG:
> +    case PLAT_DDR_CFG:
> +        /* read only */
> +        break;
> +    case PLAT_SOFTRST_CTL:
> +        if (val & PLAT_SOFTRST_CTL_SYSRESET) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
> +                      " = 0x%" PRIx64 "\n", addr & 0xffff, val);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps boston_platreg_ops = {
> +    .read = boston_platreg_read,
> +    .write = boston_platreg_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static const TypeInfo boston_device = {
> +    .name          = TYPE_MIPS_BOSTON_AIA,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(BostonState),
> +};
> +
> +static void boston_register_types(void)
> +{
> +    type_register_static(&boston_device);
> +}
> +type_init(boston_register_types)
> +
> +#define NUM_INSNS 6
> +static void gen_firmware(uint32_t *p)
> +{
> +    int i;
> +    uint32_t reset_vec[NUM_INSNS] = {
> +           /* CM relocate */
> +           0x1fb802b7,     /* li   t0,0x1fb80000   */
> +           0x16100337,     /* li   t1,0x16100000   */
> +           0x0062b423,     /* sd   t1,8(t0)        */
> +           /* Jump to 0x80000000 */
> +           0x00100293,     /* li   t0,1            */
> +           0x01f29293,     /* slli t0,t0,1f        */
> +           0x00028067      /* jr   t0              */
> +    };
> +
> +    for (i = 0; i < NUM_INSNS; i++) {
> +        *p++ = reset_vec[i];
> +    }
> +}
> +
> +static inline XilinxPCIEHost *
> +xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
> +                 hwaddr cfg_base, uint64_t cfg_size,
> +                 hwaddr mmio_base, uint64_t mmio_size,
> +                 qemu_irq irq)
> +{
> +    DeviceState *dev;
> +    MemoryRegion *cfg, *mmio;
> +
> +    dev = qdev_new(TYPE_XILINX_PCIE_HOST);
> +
> +    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
> +    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
> +    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
> +    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
> +    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
> +
> +    mmio = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
> +
> +    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
> +
> +    return XILINX_PCIE_HOST(dev);
> +}
> +
> +static void boston_mach_init(MachineState *machine)
> +{
> +    DeviceState *dev;
> +    BostonState *s;
> +    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
> +    MemoryRegion *sys_mem = get_system_memory();
> +    XilinxPCIEHost *pcie2;
> +    PCIDevice *pdev;
> +    AHCIPCIState *ich9;
> +    DriveInfo *hd[6];
> +    Chardev *chr;
> +    int fw_size;
> +
> +    if ((machine->ram_size % GiB) ||
> +        (machine->ram_size > (4 * GiB))) {
> +        error_report("Memory size must be 1GB, 2GB, 3GB, or 4GB");
> +        exit(1);
> +    }
> +
> +    if (machine->smp.cpus / machine->smp.cores / machine->smp.threads > 1) {
> +        error_report("Invalid -smp x,cores=y,threads=z. The max number of clusters "
> +                     "supported is 1");
> +        exit(1);
> +    }
> +
> +    dev = qdev_new(TYPE_MIPS_BOSTON_AIA);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    s = BOSTON(dev);
> +    s->mach = machine;
> +
> +    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_RISCV_CPS);
> +    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type,
> +                            &error_fatal);
> +    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
> +                             &error_fatal);
> +    object_property_set_uint(OBJECT(&s->cps), "num-hart", machine->smp.threads,
> +                             &error_fatal);
> +    object_property_set_uint(OBJECT(&s->cps), "num-core", machine->smp.cores,
> +                             &error_fatal);
> +    object_property_set_uint(OBJECT(&s->cps), "gcr-base", GCR_BASE_ADDR,
> +                             &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
> +
> +    flash =  g_new(MemoryRegion, 1);
> +    memory_region_init_rom(flash, NULL, "boston.flash",
> +                           boston_memmap[BOSTON_FLASH].size, &error_fatal);
> +    memory_region_add_subregion_overlap(sys_mem,
> +                                        boston_memmap[BOSTON_FLASH].base,
> +                                        flash, 0);
> +
> +    memory_region_add_subregion_overlap(sys_mem,
> +                                        boston_memmap[BOSTON_HIGHDDR].base,
> +                                        machine->ram, 0);
> +
> +    ddr_low_alias = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
> +                             machine->ram, 0,
> +                             MIN(machine->ram_size, (256 * MiB)));
> +    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
> +
> +    pcie2 = xilinx_pcie_init(sys_mem, 2,
> +                             boston_memmap[BOSTON_PCIE2].base,
> +                             boston_memmap[BOSTON_PCIE2].size,
> +                             boston_memmap[BOSTON_PCIE2_MMIO].base,
> +                             boston_memmap[BOSTON_PCIE2_MMIO].size,
> +                             qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
> +
> +    platreg = g_new(MemoryRegion, 1);
> +    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
> +                          "boston-platregs",
> +                          boston_memmap[BOSTON_PLATREG].size);
> +    memory_region_add_subregion_overlap(sys_mem,
> +                          boston_memmap[BOSTON_PLATREG].base, platreg, 0);
> +
> +    s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
> +                             qdev_get_gpio_in(s->cps.aplic, UART_INT), 10000000,
> +                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
> +
> +    lcd = g_new(MemoryRegion, 1);
> +    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
> +    memory_region_add_subregion_overlap(sys_mem,
> +                                        boston_memmap[BOSTON_LCD].base, lcd, 0);
> +
> +    chr = qemu_chr_new("lcd", "vc:320x240", NULL);
> +    qemu_chr_fe_init(&s->lcd_display, chr, NULL);
> +    qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
> +                             boston_lcd_event, NULL, s, NULL, true);
> +
> +    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
> +                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
> +    ich9 = ICH9_AHCI(pdev);
> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
> +    ide_drive_get(hd, ich9->ahci.ports);
> +    ahci_ide_create_devs(&ich9->ahci, hd);
> +
> +    if (machine->firmware) {
> +        fw_size = load_image_targphys(machine->firmware,
> +                                      0x1fc00000, 4 * MiB);
> +        if (fw_size == -1) {
> +            error_report("unable to load firmware image '%s'",
> +                          machine->firmware);
> +            exit(1);
> +        }
> +        if (machine->kernel_filename) {
> +                fw_size = load_image_targphys(machine->kernel_filename,
> +                                              0x80000000, 64 * MiB);
> +                if (fw_size == -1) {
> +                    error_report("unable to load kernel image '%s'",
> +                                  machine->kernel_filename);
> +                    exit(1);
> +                }
> +        }
> +    } else if (machine->kernel_filename) {
> +        fw_size = load_image_targphys(machine->kernel_filename,
> +                                      0x80000000, 64 * MiB);
> +        if (fw_size == -1) {
> +            error_report("unable to load kernel image '%s'",
> +                          machine->kernel_filename);
> +            exit(1);
> +        }
> +
> +        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000);
> +    } else if (!qtest_enabled()) {
> +        error_report("Please provide either a -kernel or -bios argument");
> +        exit(1);
> +    }
> +}
> +
> +static void boston_mach_class_init(MachineClass *mc)
> +{
> +    mc->desc = "MIPS Boston-aia";
> +    mc->init = boston_mach_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->default_ram_size = 2 * GiB;
> +    mc->default_ram_id = "boston.ddr";
> +    mc->max_cpus = MAX_HARTS;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
> +}
> +
> +DEFINE_MACHINE("boston-aia", boston_mach_class_init)
> diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
> new file mode 100644
> index 0000000000..ab4c27c7ee
> --- /dev/null
> +++ b/hw/riscv/cps.c
> @@ -0,0 +1,187 @@
> +/*
> + * Coherent Processing System emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/riscv/cps.h"
> +#include "hw/qdev-properties.h"
> +#include "system/reset.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "hw/pci/msi.h"
> +
> +static void riscv_cps_init(Object *obj)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RISCVCPSState *s = RISCV_CPS(obj);
> +
> +    /*
> +     * Cover entire address space as there do not seem to be any
> +     * constraints for the base address of CPC .
> +     */
> +    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MAX);
> +    sysbus_init_mmio(sbd, &s->container);
> +}
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    RISCVCPU *cpu = opaque;
> +    CPUState *cs = CPU(cpu);
> +
> +    cpu_reset(cs);
> +}
> +
> +static void riscv_cps_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVCPSState *s = RISCV_CPS(dev);
> +    RISCVCPU *cpu;
> +    int i;
> +
> +    /* Set up cpu_index and mhartid for avaiable CPUs. */
> +    int harts_in_cluster = s->num_hart * s->num_core;
> +    int num_of_clusters = s->num_vp / harts_in_cluster;
> +    for (i = 0; i < s->num_vp; i++) {
> +        cpu = RISCV_CPU(object_new(s->cpu_type));
> +
> +        /* All VPs are halted on reset. Leave powering up to CPC. */
> +        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
> +                                 &error_abort);
> +
> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
> +            return;
> +        }
> +
> +        /* Set up mhartid */
> +        int cluster_id = i / harts_in_cluster;
> +        int hart_id = (i % harts_in_cluster) % s->num_hart;
> +        int core_id = (i % harts_in_cluster) / s->num_hart;
> +        int mhartid = (cluster_id << MHARTID_CLUSTER_SHIFT) +
> +                      (core_id << MHARTID_CORE_SHIFT) +
> +                      (hart_id << MHARTID_HART_SHIFT);
> +        cpu->env.mhartid = mhartid;
> +        qemu_register_reset(main_cpu_reset, cpu);
> +    }
> +
> +    /* Cluster Power Controller */
> +    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
> +    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
> +                            &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->container, 0,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc), 0));
> +
> +    /* Global Configuration Registers */
> +    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
> +    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
> +                            &error_abort);
> +    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
> +                            &error_abort);
> +    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&s->container, s->gcr_base,
> +                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
> +
> +    for (i = 0; i < num_of_clusters; i++) {
> +        uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
> +        uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
> +        s->aplic = riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
> +                                      AIA_PLIC_M_SIZE,
> +                                      hartid_base, /* hartid_base */
> +                                      MAX_HARTS, /* num_harts */
> +                                      APLIC_NUM_SOURCES,
> +                                      APLIC_NUM_PRIO_BITS,
> +                                      false, true, NULL);
> +        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
> +                           AIA_PLIC_S_SIZE,
> +                           hartid_base, /* hartid_base */
> +                           MAX_HARTS, /* num_harts */
> +                           APLIC_NUM_SOURCES,
> +                           APLIC_NUM_PRIO_BITS,
> +                           false, false, s->aplic);
> +        /* PLIC changes msi_nonbroken to ture. We revert the change. */
> +        msi_nonbroken = false;
> +        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
> +                                hartid_base, MAX_HARTS, false);
> +        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
> +                                   RISCV_ACLINT_SWI_SIZE,
> +                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                                   hartid_base,
> +                                   MAX_HARTS,
> +                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
> +                                   RISCV_ACLINT_DEFAULT_MTIME,
> +                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
> +    }
> +}
> +
> +static const Property riscv_cps_properties[] = {
> +    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
> +    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
> +    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
> +    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR),
> +    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
> +};
> +
> +static void riscv_cps_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = riscv_cps_realize;
> +    device_class_set_props(dc, riscv_cps_properties);
> +}
> +
> +static const TypeInfo riscv_cps_info = {
> +    .name = TYPE_RISCV_CPS,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(RISCVCPSState),
> +    .instance_init = riscv_cps_init,
> +    .class_init = riscv_cps_class_init,
> +};
> +
> +static void riscv_cps_register_types(void)
> +{
> +    type_register_static(&riscv_cps_info);
> +}
> +
> +type_init(riscv_cps_register_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index c22f3a7216..76a038f60e 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -13,5 +13,6 @@ riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
>   riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
>   	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
>   riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
> +riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c', 'cps.c'))
>   
>   hw_arch += {'riscv': riscv_ss}
> diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
> new file mode 100644
> index 0000000000..dfc45f5797
> --- /dev/null
> +++ b/include/hw/riscv/cps.h
> @@ -0,0 +1,75 @@
> +/*
> + * Coherent Processing System emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#ifndef RISCV_CPS_H
> +#define RISCV_CPS_H
> +
> +#include "hw/sysbus.h"
> +#include "hw/misc/riscv_cmgcr.h"
> +#include "hw/misc/riscv_cpc.h"
> +#include "target/riscv/cpu.h"
> +#include "qom/object.h"
> +
> +#define TYPE_RISCV_CPS "riscv-cps"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
> +
> +/* The model supports up to 64 harts. */
> +#define MAX_HARTS 64
> +
> +/* The global CM base for the boston-aia model. */
> +#define GLOBAL_CM_BASE 0x16100000
> +/* The CM block is 512 KiB. */
> +#define CM_SIZE (1 << 19)
> +
> +/* The mhartid bits has cluster at bit 16, core at bit 4, and hart at
> +   bit 0. */
> +#define MHARTID_CLUSTER_SHIFT 16
> +#define MHARTID_CORE_SHIFT 4
> +#define MHARTID_HART_SHIFT 0
> +
> +#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. */
> +#define APLIC_NUM_PRIO_BITS 3
> +#define AIA_PLIC_M_OFFSET 0x40000
> +#define AIA_PLIC_M_SIZE 0x8000
> +#define AIA_PLIC_S_OFFSET 0x60000
> +#define AIA_PLIC_S_SIZE 0x8000
> +#define AIA_CLINT_OFFSET 0x50000
> +
> +typedef struct RISCVCPSState {
> +    SysBusDevice parent_obj;
> +
> +    uint32_t num_vp;
> +    uint32_t num_hart;
> +    uint32_t num_core;
> +    uint64_t gcr_base;
> +    char *cpu_type;
> +
> +    MemoryRegion container;
> +    RISCVGCRState gcr;
> +    RISCVCPCState cpc;
> +
> +    DeviceState *aplic;
> +} RISCVCPSState;
> +
> +#endif


