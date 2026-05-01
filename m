Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2605FFF8864
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 04:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIfCM-00087X-MJ; Fri, 01 May 2026 00:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIfCK-00086t-UW
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:09:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIfCG-0006kn-EL
 for qemu-devel@nongnu.org; Fri, 01 May 2026 00:09:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so275890666b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777608587; cv=none;
 d=google.com; s=arc-20240605;
 b=VE2WiXFRxkCf9q8bTbx5MVuF9HFJk66X32LzSXkh5yzacWuNRy7ovEi8HYvr9xzSxE
 yyqR9DapjBDfLQxHBRCzwlHvm0dISfTdp/TZ2vzN1oGyVek1a2PnL+qdIdzpDTke5EQo
 i7Yg6KIOLZr9w1JzeZRoR4l4gJj74/IqIktP8ondx1GnpZ17BLDMJdc34sJB1nr/Cxyt
 MPga+NWDY4/Sx8zhLZrTnvDmanWVOIweRil/1oiRm//168fYF+07WOXtqMMpZGvxFNSg
 L22RQSg3VBUDFAR4PpeZlnOIOnUhQOs7eJ6uk17uIfI/aWtK5ROX6HDixLGAJvcX3tJC
 2Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IPUl3ciOOaB+ouNVTfg5ojp/isCxcfgRYN/ij/rDtx8=;
 fh=5TOsydJs8bPqkcjNrtoB3qudCbBGJvQ6S+UUKdOVvn4=;
 b=RieqgyMC40V15hvV3B6IUcWGb+G9u8Tw5XfHCxCEGz7WG8wmZddyuKR6MQWk8vIdGb
 HduU10TWQxmgYoTrRsk4oUJNKl+6aiFGeIz2AR8Iyh47HtnRjij8+l1AzEWc2L5A77Vu
 ii5EDG6ZlB3UFD1hOFxGIn7P5ze2i4qFjWcsQQafc9uJhrWZoKp75a5Qum5RPQ8Uil1o
 WnlTCZGolzaM6h7zaXndOy++FUh68UhTtr1GKneBXm4wOJPQtKL5qfGqAcQCk2vtKep4
 Emsrw8j0S7klUl3Y1LqwWsdorCvNgzAzFKb9cVgK6FkX+hpwaMI6nJ6ArfNS9+6l6ptj
 MeSQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777608587; x=1778213387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPUl3ciOOaB+ouNVTfg5ojp/isCxcfgRYN/ij/rDtx8=;
 b=am9NF2RxIHLfJyEC9XezYvKkeB6e1hiAhOE33zJMH0nd2kvntouOb21mJgIRJPMaZF
 sN5PV6Jb0Zo4ZXFsnzUSybHG81qYu3lxN1ZtbxjH6ZlX+mX4gSBr6saNvjcDGc9fAllV
 wNq/pDBIdh0q+wBKGcu84OLHmJbWv3GwHg+tekvUsuMcWp3GkFm5GLe9xRB9XnHOffgn
 uhVPyOL3rcBncKIlXzE7UAfhn0Ivgkf5gmYENzKaCLNHt4Ee/GeFsLPb/Udkb96QCvGM
 urR0k6a64rUuF0d6WHvE6NkaFN/3BJYWz5rRdAD9j3HGRqcvSqfV0Aq4OmseRUynASwE
 3b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777608587; x=1778213387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPUl3ciOOaB+ouNVTfg5ojp/isCxcfgRYN/ij/rDtx8=;
 b=hXb23+pcSm2hwBOEdlIzG2KUHHs2nBd4RkSfLeqts6XJXEUp+NUX886mcF/1JnEW/+
 Jv/KKxLXjZYxJErUByyU/HXH6JUl5xz+PBPEYYprXLl3tS60tDkim6V+a/P7l+q5LcNd
 DLJ88u/kvHB9pr1Vurf9aSK9axJXOSGmSt3qPW66EV51suH2TDB7DMsi7sOpS84GyRV7
 +VnfyMErNhwCUFALWAaaPlpNoQlV6kP6Jxyyk7HiRN3f9l6B7RERTo/RtX1xTpckGxxW
 0gwOv/T5vQ7xz7L/08hHO2HvrvjwfUKwMagEZdQFv3Rkrl0VyOSZhWA21ovtrWg5PvMf
 t5cQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VxT9/1dy9AEaVjr80p0NtNlU8uJyg/3LFJ7k0nEhfXuAg/Z9cqKvrbBDLKY2ejupcFslKifLwbMsL@nongnu.org
X-Gm-Message-State: AOJu0Yz7CtZmmsFe0PiQY1swPiGG8LCz45VDhw8bC8rUhk1MrAsAGCCs
 PDj0yEzi/SJtUe9L5BSrCtfTdqQcbXylukeRYvLDhQctFfFSe4PiurQ0pc1ABDu6xb86ZtVyy9C
 oCShLpXo9kmM6BHNVUglNyWFXn9Q9PN8=
X-Gm-Gg: AeBDievh0GbidaMzRVcXqufBNiBL7xTwT4eZGRnQg+cqmUwsmFvBv+9NmfWf9hnGDyk
 tsSGaO7rpQ9f6rlnNK27S6aME3cB8SH5s5EhJvnPIituBY98y2D1XHGfSW3xavuwY1eXU6FilP5
 AlnOXnvFwNuJyQJldgaayM5htR8dPj/V/ouM9OC7owa9zsdpWxkoq6+n7+Y9jVoc38EJL8NtREx
 aW+x0RKMUYUHvENKncEZPMohSx5bpmD8QjPcgzjvOacaXFKS8XP2KrPPUoxIwakUq0zKtuF13ay
 +0L2SAaN2Q4CkumticAD0rHW57qkuL1Q9L2s+KkJrvd2Zw6I
X-Received: by 2002:a17:907:928d:b0:ba4:e5e5:58b4 with SMTP id
 a640c23a62f3a-bbac67c2706mr383679866b.20.1777608586632; Thu, 30 Apr 2026
 21:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <a4a985723ca53660e72f7a825fb53299adba5570.1776438369.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <a4a985723ca53660e72f7a825fb53299adba5570.1776438369.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 14:09:19 +1000
X-Gm-Features: AVHnY4J1YFNmX0HG1QMpFlDtvOEluHoHMHrXPz3InJ4R21ZT03JwFAyxitcrUbg
Message-ID: <CAKmqyKM48DLLdWi46a8QkkJcwvAM_y3EE-xPDH9L5DDGwxCxJA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] hw/riscv: add k230 board initial support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peng Jiang <3160104094@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Apr 18, 2026 at 1:13=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> From: Chao Liu <chao.liu@zevorn.cn>
>
> K230 Board Compatible with kendryte K230 SDK.
>
> Preliminarily supports the C908 small core, which can
> run the U-Boot and Linux kernel compiled by the K230 SDK.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reported-by: Peng Jiang <3160104094@zju.edu.cn>

A Signed-off-by or Tested-by would be better here, as it isn't a bug fix pa=
tch

> ---
>  MAINTAINERS             |   8 +-
>  hw/riscv/Kconfig        |  10 +
>  hw/riscv/k230.c         | 484 ++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build    |   2 +-
>  include/hw/riscv/k230.h | 150 +++++++++++++
>  5 files changed, 652 insertions(+), 2 deletions(-)
>  create mode 100644 hw/riscv/k230.c
>  create mode 100644 include/hw/riscv/k230.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa4267b158..c429c63961 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1773,6 +1773,12 @@ F: docs/system/riscv/xiangshan-kunminghu.rst
>  F: hw/riscv/xiangshan_kmh.c
>  F: include/hw/riscv/xiangshan_kmh.h
>
> +K230 Machines
> +M: Chao Liu <chao.liu.zevorn@gmail.com>
> +S: Maintained
> +F: hw/riscv/k230.c
> +F: include/hw/riscv/k230.h

I think we generally include the RISC-V mailing list here as well,
just to be clear it's RISC-V

> +
>  RX Machines
>  -----------
>  rx-gdbsim
> @@ -3620,7 +3626,7 @@ M: Alexander Bulekov <alxndr@bu.edu>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  R: Stefan Hajnoczi <stefanha@redhat.com>
>  R: Fabiano Rosas <farosas@suse.de>
> -R: Darren Kenny <darren.kenny@oracle.com>
> +R: Darren Kenny <darren.kenny@oracle.com>

This doesn't need to be changed

>  R: Qiuhao Li <Qiuhao.Li@outlook.com>
>  S: Maintained
>  F: tests/qtest/fuzz/
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0222c93f87..b1a7357866 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -134,3 +134,13 @@ config MIPS_BOSTON_AIA
>      default y
>      select PCI_EXPRESS
>      select PCI_EXPRESS_XILINX
> +
> +config K230
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select SERIAL_MM
> +    select UNIMP
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> new file mode 100644
> index 0000000000..2537023a05
> --- /dev/null
> +++ b/hw/riscv/k230.c
> @@ -0,0 +1,484 @@
> +/*
> + * QEMU RISC-V Virt Board Compatible with Kendryte K230 SDK
> + *
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the Kendryte K230 SDK
> + *
> + * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

Can you link to the manual

> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu-qom.h"
> +#include "qemu/cutils.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "system/system.h"
> +#include "system/memory.h"
> +#include "target/riscv/cpu.h"
> +#include "chardev/char.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/riscv/k230.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/sifive_plic.h"
> +#include "hw/char/serial-mm.h"
> +#include "hw/misc/unimp.h"
> +
> +static const MemMapEntry memmap[] =3D {
> +    [K230_DEV_DDRC] =3D         { 0x00000000,  0x80000000 },
> +    [K230_DEV_KPU_L2_CACHE] =3D { 0x80000000,  0x00200000 },
> +    [K230_DEV_SRAM] =3D         { 0x80200000,  0x00200000 },
> +    [K230_DEV_KPU_CFG] =3D      { 0x80400000,  0x00000800 },
> +    [K230_DEV_FFT] =3D          { 0x80400800,  0x00000400 },
> +    [K230_DEV_AI_2D_ENGINE] =3D { 0x80400C00,  0x00000800 },
> +    [K230_DEV_GSDMA] =3D        { 0x80800000,  0x00004000 },
> +    [K230_DEV_DMA] =3D          { 0x80804000,  0x00004000 },
> +    [K230_DEV_DECOMP_GZIP] =3D  { 0x80808000,  0x00004000 },
> +    [K230_DEV_NON_AI_2D] =3D    { 0x8080C000,  0x00004000 },
> +    [K230_DEV_ISP] =3D          { 0x90000000,  0x00008000 },
> +    [K230_DEV_DEWARP] =3D       { 0x90008000,  0x00001000 },
> +    [K230_DEV_RX_CSI] =3D       { 0x90009000,  0x00002000 },
> +    [K230_DEV_H264] =3D         { 0x90400000,  0x00010000 },
> +    [K230_DEV_2P5D] =3D         { 0x90800000,  0x00040000 },
> +    [K230_DEV_VO] =3D           { 0x90840000,  0x00010000 },
> +    [K230_DEV_VO_CFG] =3D       { 0x90850000,  0x00001000 },
> +    [K230_DEV_3D_ENGINE] =3D    { 0x90A00000,  0x00000800 },
> +    [K230_DEV_PMU] =3D          { 0x91000000,  0x00000C00 },
> +    [K230_DEV_RTC] =3D          { 0x91000C00,  0x00000400 },
> +    [K230_DEV_CMU] =3D          { 0x91100000,  0x00001000 },
> +    [K230_DEV_RMU] =3D          { 0x91101000,  0x00001000 },
> +    [K230_DEV_BOOT] =3D         { 0x91102000,  0x00001000 },
> +    [K230_DEV_PWR] =3D          { 0x91103000,  0x00001000 },
> +    [K230_DEV_MAILBOX] =3D      { 0x91104000,  0x00001000 },
> +    [K230_DEV_IOMUX] =3D        { 0x91105000,  0x00000800 },
> +    [K230_DEV_TIMER] =3D        { 0x91105800,  0x00000800 },
> +    [K230_DEV_WDT0] =3D         { 0x91106000,  0x00000800 },
> +    [K230_DEV_WDT1] =3D         { 0x91106800,  0x00000800 },
> +    [K230_DEV_TS] =3D           { 0x91107000,  0x00000800 },
> +    [K230_DEV_HDI] =3D          { 0x91107800,  0x00000800 },
> +    [K230_DEV_STC] =3D          { 0x91108000,  0x00000800 },
> +    [K230_DEV_BOOTROM] =3D      { 0x91200000,  0x00010000 },
> +    [K230_DEV_SECURITY] =3D     { 0x91210000,  0x00008000 },
> +    [K230_DEV_UART0] =3D        { 0x91400000,  0x00001000 },
> +    [K230_DEV_UART1] =3D        { 0x91401000,  0x00001000 },
> +    [K230_DEV_UART2] =3D        { 0x91402000,  0x00001000 },
> +    [K230_DEV_UART3] =3D        { 0x91403000,  0x00001000 },
> +    [K230_DEV_UART4] =3D        { 0x91404000,  0x00001000 },
> +    [K230_DEV_I2C0] =3D         { 0x91405000,  0x00001000 },
> +    [K230_DEV_I2C1] =3D         { 0x91406000,  0x00001000 },
> +    [K230_DEV_I2C2] =3D         { 0x91407000,  0x00001000 },
> +    [K230_DEV_I2C3] =3D         { 0x91408000,  0x00001000 },
> +    [K230_DEV_I2C4] =3D         { 0x91409000,  0x00001000 },
> +    [K230_DEV_PWM] =3D          { 0x9140A000,  0x00001000 },
> +    [K230_DEV_GPIO0] =3D        { 0x9140B000,  0x00001000 },
> +    [K230_DEV_GPIO1] =3D        { 0x9140C000,  0x00001000 },
> +    [K230_DEV_ADC] =3D          { 0x9140D000,  0x00001000 },
> +    [K230_DEV_CODEC] =3D        { 0x9140E000,  0x00001000 },
> +    [K230_DEV_I2S] =3D          { 0x9140F000,  0x00001000 },
> +    [K230_DEV_USB0] =3D         { 0x91500000,  0x00010000 },
> +    [K230_DEV_USB1] =3D         { 0x91540000,  0x00010000 },
> +    [K230_DEV_SD0] =3D          { 0x91580000,  0x00001000 },
> +    [K230_DEV_SD1] =3D          { 0x91581000,  0x00001000 },
> +    [K230_DEV_QSPI0] =3D        { 0x91582000,  0x00001000 },
> +    [K230_DEV_QSPI1] =3D        { 0x91583000,  0x00001000 },
> +    [K230_DEV_SPI] =3D          { 0x91584000,  0x00001000 },
> +    [K230_DEV_HI_SYS_CFG] =3D   { 0x91585000,  0x00000400 },
> +    [K230_DEV_DDRC_CFG] =3D     { 0x98000000,  0x02000000 },
> +    [K230_DEV_FLASH] =3D        { 0xC0000000,  0x08000000 },
> +    [K230_DEV_PLIC] =3D         { 0xF00000000, 0x00400000 },
> +    [K230_DEV_CLINT] =3D        { 0xF04000000, 0x00400000 },
> +};
> +
> +static void k230_soc_init(Object *obj)
> +{
> +    K230SoCState *s =3D RISCV_K230_SOC(obj);
> +    RISCVHartArrayState *cpu0 =3D &s->c908_cpu;
> +
> +    object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY=
);
> +    qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_=
C908);
> +    qdev_prop_set_uint64(DEVICE(cpu0), "resetvec",
> +                         memmap[K230_DEV_BOOTROM].base);
> +}
> +
> +static DeviceState *k230_create_plic(int base_hartid, int hartid_count)
> +{
> +    g_autofree char *plic_hart_config =3D NULL;
> +
> +    /* Per-socket PLIC hart topology configuration string */
> +    plic_hart_config =3D riscv_plic_hart_config_string(hartid_count);
> +
> +    /* Per-socket PLIC */
> +    return sifive_plic_create(memmap[K230_DEV_PLIC].base,
> +                              plic_hart_config, hartid_count, base_harti=
d,
> +                              K230_PLIC_NUM_SOURCES,
> +                              K230_PLIC_NUM_PRIORITIES,
> +                              K230_PLIC_PRIORITY_BASE, K230_PLIC_PENDING=
_BASE,
> +                              K230_PLIC_ENABLE_BASE, K230_PLIC_ENABLE_ST=
RIDE,
> +                              K230_PLIC_CONTEXT_BASE,
> +                              K230_PLIC_CONTEXT_STRIDE,
> +                              memmap[K230_DEV_PLIC].size);
> +}
> +
> +static void k230_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    K230SoCState *s =3D RISCV_K230_SOC(dev);
> +    MemoryRegion *sys_mem =3D get_system_memory();
> +    int c908_cpus;
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->c908_cpu), &error_fatal);
> +
> +    c908_cpus =3D s->c908_cpu.num_harts;
> +
> +    /* SRAM */
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "sram",
> +                           memmap[K230_DEV_SRAM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_SRAM].base,
> +                                &s->sram);
> +
> +    /* BootROM */
> +    memory_region_init_rom(&s->bootrom, OBJECT(dev), "bootrom",
> +                           memmap[K230_DEV_BOOTROM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_BOOTROM].base,
> +                                &s->bootrom);
> +
> +    /* PLIC */
> +    s->c908_plic =3D k230_create_plic(C908_CPU_HARTID, c908_cpus);
> +
> +    /* CLINT */
> +    riscv_aclint_swi_create(memmap[K230_DEV_CLINT].base,
> +                            C908_CPU_HARTID, c908_cpus, false);
> +    riscv_aclint_mtimer_create(memmap[K230_DEV_CLINT].base + 0x4000,
> +                               RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
> +                               C908_CPU_HARTID, c908_cpus,
> +                               RISCV_ACLINT_DEFAULT_MTIMECMP,
> +                               RISCV_ACLINT_DEFAULT_MTIME,
> +                               RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true)=
;
> +
> +    /* UART */
> +    serial_mm_init(sys_mem, memmap[K230_DEV_UART0].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART0_IRQ=
),
> +                   399193, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +    serial_mm_init(sys_mem, memmap[K230_DEV_UART1].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART1_IRQ=
),
> +                   399193, serial_hd(1), DEVICE_LITTLE_ENDIAN);
> +    serial_mm_init(sys_mem, memmap[K230_DEV_UART2].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART2_IRQ=
),
> +                   399193, serial_hd(2), DEVICE_LITTLE_ENDIAN);
> +    serial_mm_init(sys_mem, memmap[K230_DEV_UART3].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART3_IRQ=
),
> +                   399193, serial_hd(3), DEVICE_LITTLE_ENDIAN);
> +    serial_mm_init(sys_mem, memmap[K230_DEV_UART4].base, 2,
> +                   qdev_get_gpio_in(DEVICE(s->c908_plic), K230_UART4_IRQ=
),
> +                   399193, serial_hd(4), DEVICE_LITTLE_ENDIAN);
> +
> +    /* unimplemented devices */
> +    create_unimplemented_device("kpu.l2-cache",
> +                                memmap[K230_DEV_KPU_L2_CACHE].base,
> +                                memmap[K230_DEV_KPU_L2_CACHE].size);
> +
> +    create_unimplemented_device("kpu_cfg", memmap[K230_DEV_KPU_CFG].base=
,
> +                                memmap[K230_DEV_KPU_CFG].size);
> +
> +    create_unimplemented_device("fft", memmap[K230_DEV_FFT].base,
> +                                memmap[K230_DEV_FFT].size);
> +
> +    create_unimplemented_device("2d-engine.ai",
> +                                memmap[K230_DEV_AI_2D_ENGINE].base,
> +                                memmap[K230_DEV_AI_2D_ENGINE].size);
> +
> +    create_unimplemented_device("gsdma", memmap[K230_DEV_GSDMA].base,
> +                                memmap[K230_DEV_GSDMA].size);
> +
> +    create_unimplemented_device("dma", memmap[K230_DEV_DMA].base,
> +                                memmap[K230_DEV_DMA].size);
> +
> +    create_unimplemented_device("decomp-gzip",
> +                                memmap[K230_DEV_DECOMP_GZIP].base,
> +                                memmap[K230_DEV_DECOMP_GZIP].size);
> +
> +    create_unimplemented_device("2d-engine.non-ai",
> +                                memmap[K230_DEV_NON_AI_2D].base,
> +                                memmap[K230_DEV_NON_AI_2D].size);
> +
> +    create_unimplemented_device("isp", memmap[K230_DEV_ISP].base,
> +                                memmap[K230_DEV_ISP].size);
> +
> +    create_unimplemented_device("dewarp", memmap[K230_DEV_DEWARP].base,
> +                                memmap[K230_DEV_DEWARP].size);
> +
> +    create_unimplemented_device("rx-csi", memmap[K230_DEV_RX_CSI].base,
> +                                memmap[K230_DEV_RX_CSI].size);
> +
> +    create_unimplemented_device("vpu", memmap[K230_DEV_H264].base,
> +                                memmap[K230_DEV_H264].size);
> +
> +    create_unimplemented_device("gpu", memmap[K230_DEV_2P5D].base,
> +                                memmap[K230_DEV_2P5D].size);
> +
> +    create_unimplemented_device("vo", memmap[K230_DEV_VO].base,
> +                                memmap[K230_DEV_VO].size);
> +
> +    create_unimplemented_device("vo_cfg", memmap[K230_DEV_VO_CFG].base,
> +                                memmap[K230_DEV_VO_CFG].size);
> +
> +    create_unimplemented_device("3d-engine", memmap[K230_DEV_3D_ENGINE].=
base,
> +                                memmap[K230_DEV_3D_ENGINE].size);
> +
> +    create_unimplemented_device("pmu", memmap[K230_DEV_PMU].base,
> +                                memmap[K230_DEV_PMU].size);
> +
> +    create_unimplemented_device("rtc", memmap[K230_DEV_RTC].base,
> +                                memmap[K230_DEV_RTC].size);
> +
> +    create_unimplemented_device("cmu", memmap[K230_DEV_CMU].base,
> +                                memmap[K230_DEV_CMU].size);
> +
> +    create_unimplemented_device("rmu", memmap[K230_DEV_RMU].base,
> +                                memmap[K230_DEV_RMU].size);
> +
> +    create_unimplemented_device("boot", memmap[K230_DEV_BOOT].base,
> +                                memmap[K230_DEV_BOOT].size);
> +
> +    create_unimplemented_device("pwr", memmap[K230_DEV_PWR].base,
> +                                memmap[K230_DEV_PWR].size);
> +
> +    create_unimplemented_device("ipcm", memmap[K230_DEV_MAILBOX].base,
> +                                memmap[K230_DEV_MAILBOX].size);
> +
> +    create_unimplemented_device("iomux", memmap[K230_DEV_IOMUX].base,
> +                                memmap[K230_DEV_IOMUX].size);
> +
> +    create_unimplemented_device("timer", memmap[K230_DEV_TIMER].base,
> +                                memmap[K230_DEV_TIMER].size);
> +
> +    create_unimplemented_device("wdt0", memmap[K230_DEV_WDT0].base,
> +                                memmap[K230_DEV_WDT0].size);
> +
> +    create_unimplemented_device("wdt1", memmap[K230_DEV_WDT1].base,
> +                                memmap[K230_DEV_WDT1].size);
> +
> +    create_unimplemented_device("ts", memmap[K230_DEV_TS].base,
> +                                memmap[K230_DEV_TS].size);
> +
> +    create_unimplemented_device("hdi", memmap[K230_DEV_HDI].base,
> +                                memmap[K230_DEV_HDI].size);
> +
> +    create_unimplemented_device("stc", memmap[K230_DEV_STC].base,
> +                                memmap[K230_DEV_STC].size);
> +
> +    create_unimplemented_device("security", memmap[K230_DEV_SECURITY].ba=
se,
> +                                memmap[K230_DEV_SECURITY].size);
> +
> +    create_unimplemented_device("i2c0", memmap[K230_DEV_I2C0].base,
> +                                memmap[K230_DEV_I2C0].size);
> +
> +    create_unimplemented_device("i2c1", memmap[K230_DEV_I2C1].base,
> +                                memmap[K230_DEV_I2C1].size);
> +
> +    create_unimplemented_device("i2c2", memmap[K230_DEV_I2C2].base,
> +                                memmap[K230_DEV_I2C2].size);
> +
> +    create_unimplemented_device("i2c3", memmap[K230_DEV_I2C3].base,
> +                                memmap[K230_DEV_I2C3].size);
> +
> +    create_unimplemented_device("i2c4", memmap[K230_DEV_I2C4].base,
> +                                memmap[K230_DEV_I2C4].size);
> +
> +    create_unimplemented_device("pwm", memmap[K230_DEV_PWM].base,
> +                                memmap[K230_DEV_PWM].size);
> +
> +    create_unimplemented_device("gpio0", memmap[K230_DEV_GPIO0].base,
> +                                memmap[K230_DEV_GPIO0].size);
> +
> +    create_unimplemented_device("gpio1", memmap[K230_DEV_GPIO1].base,
> +                                memmap[K230_DEV_GPIO1].size);
> +
> +    create_unimplemented_device("adc", memmap[K230_DEV_ADC].base,
> +                                memmap[K230_DEV_ADC].size);
> +
> +    create_unimplemented_device("codec", memmap[K230_DEV_CODEC].base,
> +                                memmap[K230_DEV_CODEC].size);
> +
> +    create_unimplemented_device("i2s", memmap[K230_DEV_I2S].base,
> +                                memmap[K230_DEV_I2S].size);
> +
> +    create_unimplemented_device("usb0", memmap[K230_DEV_USB0].base,
> +                                memmap[K230_DEV_USB0].size);
> +
> +    create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
> +                                memmap[K230_DEV_USB1].size);
> +
> +    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
> +                                memmap[K230_DEV_SD0].size);
> +
> +    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
> +                                memmap[K230_DEV_SD1].size);
> +
> +    create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
> +                                memmap[K230_DEV_QSPI0].size);
> +
> +    create_unimplemented_device("qspi1", memmap[K230_DEV_QSPI1].base,
> +                                memmap[K230_DEV_QSPI1].size);
> +
> +    create_unimplemented_device("spi", memmap[K230_DEV_SPI].base,
> +                                memmap[K230_DEV_SPI].size);
> +
> +    create_unimplemented_device("hi_sys_cfg", memmap[K230_DEV_HI_SYS_CFG=
].base,
> +                                memmap[K230_DEV_HI_SYS_CFG].size);
> +
> +    create_unimplemented_device("ddrc_cfg", memmap[K230_DEV_DDRC_CFG].ba=
se,
> +                                memmap[K230_DEV_DDRC_CFG].size);
> +
> +    create_unimplemented_device("flash", memmap[K230_DEV_FLASH].base,
> +                                memmap[K230_DEV_FLASH].size);
> +}
> +
> +static void k230_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D k230_soc_realize;
> +}
> +
> +static const TypeInfo k230_soc_type_info =3D {
> +    .name =3D TYPE_RISCV_K230_SOC,
> +    .parent =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(K230SoCState),
> +    .instance_init =3D k230_soc_init,
> +    .class_init =3D k230_soc_class_init,
> +};
> +
> +static void k230_soc_register_types(void)
> +{
> +    type_register_static(&k230_soc_type_info);
> +}
> +
> +type_init(k230_soc_register_types)
> +
> +static void k230_machine_done(Notifier *notifier, void *data)
> +{
> +    K230MachineState *s =3D container_of(notifier, K230MachineState,
> +                                     machine_done);
> +    MachineState *machine =3D MACHINE(s);
> +    hwaddr start_addr =3D memmap[K230_DEV_DDRC].base;
> +    target_ulong firmware_end_addr, kernel_start_addr;
> +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc.c9=
08_cpu);
> +    uint64_t kernel_entry =3D 0;
> +    RISCVBootInfo boot_info;
> +
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> +                                                     &start_addr, NULL);
> +
> +    /* Mask ROM reset vector */
> +    uint32_t reset_vec[] =3D {
> +        /* 0x91200000: auipc  t0, 0x0              */ 0x00000297,
> +        /* 0x91200004: addi   t0, t0, 36 # <trap>  */ 0x03028293,
> +        /* 0x91200008: csrw   mtvec, t0            */ 0x30529073,
> +        /* 0x9120000C: csrr   a0, misa             */ 0x301012F3,
> +        /* 0x91200010: lui    t0, 0x1              */ 0x000012B7,
> +        /* 0x91200014: slli   t0, t0, 1            */ 0x00129293,
> +        /* 0x91200018: and    t0, a0, t0           */ 0x005572B3,
> +        /* 0x9120001C: bnez   t0, loop             */ 0x00511063,
> +        /* entry:                                  */
> +        /* 0x91200020: addiw  t0, zero, 1          */ 0x0010029b,
> +        /* 0x91200024: slli   t0, t0, 0x1b         */ 0x01b29293,
> +        /* 0x91200028: jr     t0 # uboot 0x8000000 */ 0x00028067,
> +        /* loop:                                   */
> +        /* 0x9120002C: j      0x9120002C # <loop>  */ 0x0000006f,
> +        /* trap:                                   */
> +        /* 0x91200030: j      0x91200030 # <trap>  */ 0x0000006f,
> +    };

Why do we need a custom reset vector?

Can we at least comment why we need this and what it's doing

Alistair

> +
> +    /* copy in the reset vector in little_endian byte order */
> +    for (int i =3D 0; i < sizeof(reset_vec) >> 2; i++) {
> +        reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
> +    }
> +    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> +                          memmap[K230_DEV_BOOTROM].base, &address_space_=
memory);
> +
> +    riscv_boot_info_init(&boot_info, &s->soc.c908_cpu);
> +
> +    if (machine->kernel_filename && !kernel_entry) {
> +        kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
> +                                                         firmware_end_ad=
dr);
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr,
> +                          true, NULL);
> +        kernel_entry =3D boot_info.image_low_addr;
> +    }
> +}
> +
> +static void k230_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +
> +    K230MachineState *s =3D RISCV_K230_MACHINE(machine);
> +    MemoryRegion *sys_mem =3D get_system_memory();
> +
> +    if (machine->ram_size < mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_RISCV_K230_SOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
> +
> +    /* Data Memory */
> +    memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
> +                                machine->ram);
> +
> +    s->machine_done.notify =3D k230_machine_done;
> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> +}
> +
> +static void k230_machine_instance_init(Object *obj)
> +{
> +}
> +
> +static void k230_machine_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "RISC-V Board compatible with Kendryte K230 SDK";
> +    mc->init =3D k230_machine_init;
> +    mc->default_cpus =3D 2;
> +    mc->default_ram_id =3D "riscv.K230.ram"; /* DDR */
> +    mc->default_ram_size =3D memmap[K230_DEV_DDRC].size;
> +}
> +
> +static const TypeInfo k230_machine_typeinfo =3D {
> +    .name       =3D TYPE_RISCV_K230_MACHINE,
> +    .parent     =3D TYPE_MACHINE,
> +    .class_init =3D k230_machine_class_init,
> +    .instance_init =3D k230_machine_instance_init,
> +    .instance_size =3D sizeof(K230MachineState),
> +};
> +
> +static void k230_machine_init_register_types(void)
> +{
> +    type_register_static(&k230_machine_typeinfo);
> +}
> +
> +type_init(k230_machine_init_register_types)
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22a..09cf855984 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -14,8 +14,8 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files=
(
>         'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv=
-iommu-hpm.c'))
>  riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-g=
eneric.c'))
>  riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangsh=
an_kmh.c'))
> -
>  riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
>  riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.=
c'))
> +riscv_ss.add(when: 'CONFIG_K230', if_true: files('k230.c'))
>
>  hw_arch +=3D {'riscv': riscv_ss}
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> new file mode 100644
> index 0000000000..830175b756
> --- /dev/null
> +++ b/include/hw/riscv/k230.h
> @@ -0,0 +1,150 @@
> +/*
> + * QEMU RISC-V Virt Board Compatible with kendryte K230 SDK
> + *
> + * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Provides a board compatible with the kendryte K230 SDK
> + *
> + * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
> + *
> + * For more information, see <https://www.kendryte.com/en/proDetail/230>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef HW_K230_H
> +#define HW_K230_H
> +
> +#include "hw/core/boards.h"
> +#include "hw/riscv/riscv_hart.h"
> +
> +#define C908_CPU_HARTID   (0)
> +
> +#define TYPE_RISCV_K230_SOC "riscv.k230.soc"
> +#define RISCV_K230_SOC(obj) \
> +    OBJECT_CHECK(K230SoCState, (obj), TYPE_RISCV_K230_SOC)
> +
> +typedef struct K230SoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    RISCVHartArrayState c908_cpu; /* Small core */
> +
> +    MemoryRegion sram;
> +    MemoryRegion bootrom;
> +
> +    DeviceState *c908_plic;
> +} K230SoCState;
> +
> +#define TYPE_RISCV_K230_MACHINE MACHINE_TYPE_NAME("k230")
> +#define RISCV_K230_MACHINE(obj) \
> +    OBJECT_CHECK(K230MachineState, (obj), TYPE_RISCV_K230_MACHINE)
> +
> +typedef struct K230MachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    K230SoCState soc;
> +    Notifier machine_done;
> +} K230MachineState;
> +
> +enum {
> +    K230_DEV_DDRC,
> +    K230_DEV_KPU_L2_CACHE,
> +    K230_DEV_SRAM,
> +    K230_DEV_KPU_CFG,
> +    K230_DEV_FFT,
> +    K230_DEV_AI_2D_ENGINE,
> +    K230_DEV_GSDMA,
> +    K230_DEV_DMA,
> +    K230_DEV_DECOMP_GZIP,
> +    K230_DEV_NON_AI_2D,
> +    K230_DEV_ISP,
> +    K230_DEV_DEWARP,
> +    K230_DEV_RX_CSI,
> +    K230_DEV_H264,
> +    K230_DEV_2P5D,
> +    K230_DEV_VO,
> +    K230_DEV_VO_CFG,
> +    K230_DEV_3D_ENGINE,
> +    K230_DEV_PMU,
> +    K230_DEV_RTC,
> +    K230_DEV_CMU,
> +    K230_DEV_RMU,
> +    K230_DEV_BOOT,
> +    K230_DEV_PWR,
> +    K230_DEV_MAILBOX,
> +    K230_DEV_IOMUX,
> +    K230_DEV_TIMER,
> +    K230_DEV_WDT0,
> +    K230_DEV_WDT1,
> +    K230_DEV_TS,
> +    K230_DEV_HDI,
> +    K230_DEV_STC,
> +    K230_DEV_BOOTROM,
> +    K230_DEV_SECURITY,
> +    K230_DEV_UART0,
> +    K230_DEV_UART1,
> +    K230_DEV_UART2,
> +    K230_DEV_UART3,
> +    K230_DEV_UART4,
> +    K230_DEV_I2C0,
> +    K230_DEV_I2C1,
> +    K230_DEV_I2C2,
> +    K230_DEV_I2C3,
> +    K230_DEV_I2C4,
> +    K230_DEV_PWM,
> +    K230_DEV_GPIO0,
> +    K230_DEV_GPIO1,
> +    K230_DEV_ADC,
> +    K230_DEV_CODEC,
> +    K230_DEV_I2S,
> +    K230_DEV_USB0,
> +    K230_DEV_USB1,
> +    K230_DEV_SD0,
> +    K230_DEV_SD1,
> +    K230_DEV_QSPI0,
> +    K230_DEV_QSPI1,
> +    K230_DEV_SPI,
> +    K230_DEV_HI_SYS_CFG,
> +    K230_DEV_DDRC_CFG,
> +    K230_DEV_FLASH,
> +    K230_DEV_PLIC,
> +    K230_DEV_CLINT,
> +};
> +
> +enum {
> +    K230_UART0_IRQ  =3D 16,
> +    K230_UART1_IRQ  =3D 17,
> +    K230_UART2_IRQ  =3D 18,
> +    K230_UART3_IRQ  =3D 19,
> +    K230_UART4_IRQ  =3D 20,
> +};
> +
> +/*
> + * Integrates with the interrupt controller (PLIC),
> + * which can process 208 interrupt external sources
> + */
> +#define K230_PLIC_NUM_SOURCES 208
> +#define K230_PLIC_NUM_PRIORITIES 7
> +#define K230_PLIC_PRIORITY_BASE 0x00
> +#define K230_PLIC_PENDING_BASE 0x1000
> +#define K230_PLIC_ENABLE_BASE 0x2000
> +#define K230_PLIC_ENABLE_STRIDE 0x80
> +#define K230_PLIC_CONTEXT_BASE 0x200000
> +#define K230_PLIC_CONTEXT_STRIDE 0x1000
> +
> +#endif
> --
> 2.53.0
>
>

