Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F006EED612
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 14:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJfD-0005J0-Hg; Thu, 01 Jan 2026 09:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJf9-0005If-IM
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:28:27 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJf7-0002XS-TT
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:28:27 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 547FF5969FF;
 Thu, 01 Jan 2026 15:28:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BQYjX_c9A9d0; Thu,  1 Jan 2026 15:28:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4280E5969FA; Thu, 01 Jan 2026 15:28:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D3E05969F6;
 Thu, 01 Jan 2026 15:28:22 +0100 (CET)
Date: Thu, 1 Jan 2026 15:28:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 6/7] ati-vga: Process Type-0/1/2 CCE packets via PIO
In-Reply-To: <20260101035555.1300511-7-chad@jablonski.xyz>
Message-ID: <2f8b13ea-4ea6-679a-398e-25b485171272@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-7-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 31 Dec 2025, Chad Jablonski wrote:
> While drivers use bus mastering modes, PIO is the simplest place to start.
> This implements the PM4_FIFO_DATA_EVEN/ODD registers. Writing to these
> registers in sequence places packets into the CCE FIFO directly without
> need for a ring buffer. This enables testing of the CCE packet processing
> itself. Ring buffer registers will follow in a future patch.
>
> Type-0 and Type-1 packets write to registers. Type-2 packets are NOPs.
> Type-3 packet headers are parsed but only logged as of now.
>
> Hardware testing and poking at the microcode suggests that Type-0/1/2
> packets may be implemented in hardware and not the microcode. Type-3,
> however, definitely depends on the microcode.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c        |  10 +++
> hw/display/ati_cce.c    | 156 ++++++++++++++++++++++++++++++++++++++++
> hw/display/ati_cce.h    |  56 +++++++++++++++
> hw/display/meson.build  |   2 +-
> hw/display/trace-events |   9 +++
> 5 files changed, 232 insertions(+), 1 deletion(-)
> create mode 100644 hw/display/ati_cce.c
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 29a89b3f80..9edde2b0bc 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -997,6 +997,16 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
>         s->cce.freerun = data & PM4_MICRO_FREERUN;
>         break;
>     }
> +    case PM4_FIFO_DATA_EVEN:
> +        /* fall through */

Fall through comment is not needed when cases follow each other without 
anything inbetween so you can drop it here.

> +    case PM4_FIFO_DATA_ODD:
> +        /*
> +         * Real hardware does seem to behave differently when the even/odd
> +         * sequence is not strictly adhered to but it's difficult to determine
> +         * exactly what is happenning. So for now we treat them the same.
> +         */
> +        ati_cce_receive_data(s, data);
> +        break;
>     default:
>         break;
>     }
> diff --git a/hw/display/ati_cce.c b/hw/display/ati_cce.c
> new file mode 100644
> index 0000000000..62a88a54df
> --- /dev/null
> +++ b/hw/display/ati_cce.c
> @@ -0,0 +1,156 @@
> +/*
> + * QEMU ATI SVGA emulation
> + * CCE engine functions
> + *
> + * Copyright (c) 2025 Chad Jablonski
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "ati_regs.h"
> +#include "ati_int.h"
> +#include "trace.h"
> +
> +static inline uint32_t
> +ati_cce_data_packets_remaining(const ATIPM4PacketState *p)
> +{
> +    switch (p->type) {
> +    case ATI_CCE_TYPE0:
> +        return p->t0.count - p->dwords_processed;
> +    case ATI_CCE_TYPE1:
> +        return 2 - p->dwords_processed;
> +    case ATI_CCE_TYPE2:
> +        return 0;
> +    case ATI_CCE_TYPE3:
> +        return p->t3.count - p->dwords_processed;
> +    default:
> +        /* This should never happen, type is 2-bits wide */

g_assert_not_reached() then?

> +        return 0;
> +    }
> +}

