Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FBBEED609
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 14:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJNd-0000yf-4s; Thu, 01 Jan 2026 09:10:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJNZ-0000yG-2y
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:10:17 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJNT-0006rQ-6P
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:10:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8165D596A03;
 Thu, 01 Jan 2026 15:10:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wj4N4weuJHZw; Thu,  1 Jan 2026 15:10:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 800475969FA; Thu, 01 Jan 2026 15:10:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7E68F5969F6;
 Thu, 01 Jan 2026 15:10:05 +0100 (CET)
Date: Thu, 1 Jan 2026 15:10:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/7] ati-vga: Implement CCE/PM4 microcode register
 handling
In-Reply-To: <20260101035555.1300511-3-chad@jablonski.xyz>
Message-ID: <20a6233c-7214-01de-196d-117bf55d9563@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-3-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 31 Dec 2025, Chad Jablonski wrote:
> Implement registers used for loading and reading microcode for the CCE
> engine. Loading the microcode is the first step for any driver
> implementing CCE. Reading, while not used by drivers is very helpful for
> any reverse engineering and testing work. The microcode is currently
> stored but not used. This lays the groundwork for future RE work on the
> microcode.
>
> There's some quirky behavior around microcode reads that isn't
> documented elsewhere. There appear to be two internal pointers, one for
> reading and one for writing that can get out of sync. Comments in the
> code expand on this.
>
> Tested and validated against a Rage 128 Pro Ultra (PCI 1002:5446).
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c     | 47 ++++++++++++++++++++++++++++++++++++++++++++
> hw/display/ati_cce.h | 26 ++++++++++++++++++++++++
> hw/display/ati_int.h |  2 ++
> 3 files changed, 75 insertions(+)
> create mode 100644 hw/display/ati_cce.h
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 33f8e211dc..e291926470 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -510,6 +510,31 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case DEFAULT_SC_BOTTOM_RIGHT:
>         val = s->regs.default_sc_bottom_right;
>         break;
> +    case PM4_MICROCODE_ADDR:
> +        val = s->cce.microcode.addr;
> +        break;
> +    case PM4_MICROCODE_RADDR:
> +        val = 0;

Should this return s->cce.microcode.raddr? (More comments below.)

> +        break;
> +    case PM4_MICROCODE_DATAH:
> +        val = (s->cce.microcode.microcode[s->cce.microcode.raddr] >> 32) &
> +              0xffffffff;
> +        break;
> +    case PM4_MICROCODE_DATAL:
> +        val = s->cce.microcode.microcode[s->cce.microcode.raddr] & 0xffffffff;
> +        s->cce.microcode.addr += 1;
> +        /*
> +         * The write address (addr) is always copied into the
> +         * read address (raddr) after a DATAL read. This leads
> +         * to surprising behavior when the PM4_MICROCODE_ADDR
> +         * instead of the PM4_MICROCODE_RADDR register is set to
> +         * a value just before a read. The first read after this
> +         * will reflect the previous raddr before incrementing and
> +         * re-syncing with addr. This is expected and observed on
> +         * the hardware.
> +         */
> +        s->cce.microcode.raddr = s->cce.microcode.addr;
> +        break;
>     default:
>         break;
>     }
> @@ -932,6 +957,28 @@ void ati_reg_write(ATIVGAState *s, hwaddr addr,
>     case DEFAULT_SC_BOTTOM_RIGHT:
>         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
>         break;
> +    case PM4_MICROCODE_ADDR:
> +        s->cce.microcode.addr = data;
> +        break;
> +    case PM4_MICROCODE_RADDR:
> +        s->cce.microcode.raddr = data;
> +        s->cce.microcode.addr = data;
> +        break;
> +    case PM4_MICROCODE_DATAH: {
> +        uint64_t curr = s->cce.microcode.microcode[s->cce.microcode.addr];
> +        uint64_t low = curr & 0xffffffff;
> +        uint64_t high = (data & 0x1f) << 32;
> +        s->cce.microcode.microcode[s->cce.microcode.addr] = high | low;
> +        break;
> +    }
> +    case PM4_MICROCODE_DATAL: {
> +        uint64_t curr = s->cce.microcode.microcode[s->cce.microcode.addr];
> +        uint64_t low = data & 0xffffffff;
> +        uint64_t high = curr & (0xffffffffull << 32);
> +        s->cce.microcode.microcode[s->cce.microcode.addr] = high | low;
> +        s->cce.microcode.addr += 1;
> +        break;
> +    }
>     default:
>         break;
>     }
> diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
> new file mode 100644
> index 0000000000..f2ef1345de
> --- /dev/null
> +++ b/hw/display/ati_cce.h

I'm not sure this needs a separate header, we could just put everything in 
ati_int.h which is meant to be a common header for internal 
imlementation stuff but if you prefer it separate that's fine too.

Regards,
BALATON Zoltan

> @@ -0,0 +1,26 @@
> +/*
> + * QEMU ATI SVGA emulation
> + * CCE engine functions
> + *
> + * Copyright (c) 2025 Chad Jablonski
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ATI_CCE_H
> +#define ATI_CCE_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +
> +typedef struct ATIPM4MicrocodeState {
> +    uint8_t addr;
> +    uint8_t raddr;
> +    uint64_t microcode[256];
> +} ATIPM4MicrocodeState;
> +
> +typedef struct ATICCEState {
> +    ATIPM4MicrocodeState microcode;
> +} ATICCEState;
> +
> +#endif /* ATI_CCE_H */
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index ea1a8bceab..ed6307151b 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -14,6 +14,7 @@
> #include "hw/i2c/bitbang_i2c.h"
> #include "vga_int.h"
> #include "qom/object.h"
> +#include "ati_cce.h"
>
> /*#define DEBUG_ATI*/
>
> @@ -100,6 +101,7 @@ struct ATIVGAState {
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
> +    ATICCEState cce;
> };
>
> const char *ati_reg_name(int num);
>

