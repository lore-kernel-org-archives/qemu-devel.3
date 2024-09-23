Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB5ACF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 10:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssgTD-0003Jb-O3; Mon, 23 Sep 2024 06:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgT1-0003Fn-Vd; Mon, 23 Sep 2024 06:38:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ssgSy-0006Jd-Gr; Mon, 23 Sep 2024 06:38:55 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 854A34E6027;
 Mon, 23 Sep 2024 12:38:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id twtEvmMSHPg9; Mon, 23 Sep 2024 12:38:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 89E324E601B; Mon, 23 Sep 2024 12:38:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 87CD3746F60;
 Mon, 23 Sep 2024 12:38:46 +0200 (CEST)
Date: Mon, 23 Sep 2024 12:38:46 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 07/23] hw/ppc/e500: Extract ppce500_ccsr.c
In-Reply-To: <20240923093016.66437-8-shentey@gmail.com>
Message-ID: <001e172d-4046-66cc-4758-a7a206fda931@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-8-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> The device model already has a header file. Also extract its implementation into
> an accompanying source file like other e500 devices.
>
> This commit is also a preparation for the next commit.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> MAINTAINERS           |  2 +-
> hw/ppc/e500-ccsr.h    |  2 ++
> hw/ppc/e500.c         | 17 -----------------
> hw/ppc/ppce500_ccsr.c | 38 ++++++++++++++++++++++++++++++++++++++

Maybe you could call it e500_ccsr.c and also rename the header to 
e500_ccsr.h (underscore instead of dash) to match them. Or if you want to 
match ppce500_spin.c then maybe move contents of e500-ccsr.h to e500.h?
(More below...)

> hw/ppc/meson.build    |  1 +
> 5 files changed, 42 insertions(+), 18 deletions(-)
> create mode 100644 hw/ppc/ppce500_ccsr.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffacd60f40..b7c8b7ae72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1433,7 +1433,7 @@ e500
> L: qemu-ppc@nongnu.org
> S: Orphan
> F: hw/ppc/e500*
> -F: hw/ppc/ppce500_spin.c
> +F: hw/ppc/ppce500_*.c
> F: hw/gpio/mpc8xxx.c
> F: hw/i2c/mpc_i2c.c
> F: hw/net/fsl_etsec/
> diff --git a/hw/ppc/e500-ccsr.h b/hw/ppc/e500-ccsr.h
> index 249c17be3b..3ab7e72568 100644
> --- a/hw/ppc/e500-ccsr.h
> +++ b/hw/ppc/e500-ccsr.h
> @@ -4,6 +4,8 @@
> #include "hw/sysbus.h"
> #include "qom/object.h"
>
> +#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
> +
> struct PPCE500CCSRState {
>     /*< private >*/
>     SysBusDevice parent;
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 2225533e33..4ee4304a8a 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -61,7 +61,6 @@
> #define RAM_SIZES_ALIGN            (64 * MiB)
>
> /* TODO: parameterize */
> -#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
> #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
> #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
> #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
> @@ -1264,21 +1263,6 @@ void ppce500_init(MachineState *machine)
>     pms->boot_info.dt_size = dt_size;
> }
>
> -static void e500_ccsr_initfn(Object *obj)
> -{
> -    PPCE500CCSRState *ccsr = CCSR(obj);
> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
> -                       MPC8544_CCSRBAR_SIZE);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
> -}
> -
> -static const TypeInfo e500_ccsr_info = {
> -    .name          = TYPE_CCSR,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(PPCE500CCSRState),
> -    .instance_init = e500_ccsr_initfn,
> -};
> -
> static const TypeInfo ppce500_info = {
>     .name          = TYPE_PPCE500_MACHINE,
>     .parent        = TYPE_MACHINE,
> @@ -1289,7 +1273,6 @@ static const TypeInfo ppce500_info = {
>
> static void e500_register_types(void)
> {
> -    type_register_static(&e500_ccsr_info);
>     type_register_static(&ppce500_info);
> }
>
> diff --git a/hw/ppc/ppce500_ccsr.c b/hw/ppc/ppce500_ccsr.c
> new file mode 100644
> index 0000000000..191a9ceec3
> --- /dev/null
> +++ b/hw/ppc/ppce500_ccsr.c
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU PowerPC E500 embedded processors CCSR space emulation
> + *
> + * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * Author: Yu Liu,     <yu.liu@freescale.com>
> + *
> + * This file is derived from hw/ppc440_bamboo.c,
> + * the copyright for that material belongs to the original owners.

I think CCSR is a Freescale thing so likely this has nothing to do with 
ppc440_bamboo so this sentence was for other parts of e500.c not 
applicable to this part.

> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of  the GNU General  Public License as published by
> + * the Free Software Foundation;  either version 2 of the  License, or
> + * (at your option) any later version.
> + */

SPDX-License-Identifier seems to be preferred by some nowadays, I don't 
have an opinion on that so just mentioning it for consideration but I'm OK 
with this one too although it seems a bit long.

Regards,
BALATON Zoltan

> +
> +#include "qemu/osdep.h"
> +#include "e500-ccsr.h"
> +
> +static void e500_ccsr_init(Object *obj)
> +{
> +    PPCE500CCSRState *ccsr = CCSR(obj);
> +
> +    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
> +                       MPC8544_CCSRBAR_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
> +}
> +
> +static const TypeInfo types[] = {
> +    {
> +        .name          = TYPE_CCSR,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(PPCE500CCSRState),
> +        .instance_init = e500_ccsr_init,
> +    },
> +};
> +
> +DEFINE_TYPES(types)
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 7cd9189869..43c746795a 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -81,6 +81,7 @@ ppc_ss.add(when: 'CONFIG_MPC8544DS', if_true: files('mpc8544ds.c'))
> ppc_ss.add(when: 'CONFIG_E500', if_true: files(
>   'e500.c',
>   'mpc8544_guts.c',
> +  'ppce500_ccsr.c',
>   'ppce500_spin.c'
> ))
> # PowerPC 440 Xilinx ML507 reference board.
>

