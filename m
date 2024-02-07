Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73774C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXhms-0005q3-P2; Wed, 07 Feb 2024 08:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhmW-0005lb-JR
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:16:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rXhmU-0004BA-Nt
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:16:04 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 60FFA4E609B;
 Wed,  7 Feb 2024 14:16:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Gx1w9_n3uZpu; Wed,  7 Feb 2024 14:15:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26F974E6096; Wed,  7 Feb 2024 14:15:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 255A27456B4;
 Wed,  7 Feb 2024 14:15:59 +0100 (CET)
Date: Wed, 7 Feb 2024 14:15:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, shentey@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
In-Reply-To: <20240207111411.115040-8-pbonzini@redhat.com>
Message-ID: <187c8163-3bc4-747f-e165-badc086449c3@eik.bme.hu>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 7 Feb 2024, Paolo Bonzini wrote:
> itc_reconfigure() is referenced from TCG, provide a stub if needed.
> This makes it possible to build a QEMU binary that only includes
> boards without a CPS device (only Malta and Boston create one).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
> hw/mips/meson.build     |  1 +
> 2 files changed, 27 insertions(+)
> create mode 100644 hw/mips/mips_itu-stub.c
>
> diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
> new file mode 100644
> index 00000000000..4cc82b8461f
> --- /dev/null
> +++ b/hw/mips/mips_itu-stub.c
> @@ -0,0 +1,26 @@
> +/*
> + * Inter-Thread Communication Unit emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
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
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/mips_itu.h"
> +
> +void itc_reconfigure(MIPSITUState *tag)
> +{
> +    abort();

Isn't g_assert_not_reached() preferred now for it giving better 
dignostics? But I don't know, just asking.

Regards,
BALATON Zoltan

> +}
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index f06d88f3430..2b1b96147a6 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -4,6 +4,7 @@ mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
> mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
> mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
> mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
> +mips_ss.add(when: 'CONFIG_MIPS_ITU', if_false: files('mips_itu-stub.c'))
>
> if 'CONFIG_TCG' in config_all_accel
> mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
>

