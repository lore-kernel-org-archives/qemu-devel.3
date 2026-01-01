Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30227EED603
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 14:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbJmz-0007eh-48; Thu, 01 Jan 2026 09:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJmp-0007ci-Er
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:36:25 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbJmk-00053o-4U
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 09:36:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DD22C596A03;
 Thu, 01 Jan 2026 15:36:14 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NJh--qPSKq19; Thu,  1 Jan 2026 15:36:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DD82C5969FF; Thu, 01 Jan 2026 15:36:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC3125969F6;
 Thu, 01 Jan 2026 15:36:12 +0100 (CET)
Date: Thu, 1 Jan 2026 15:36:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/7] ati-vga: Implement PM4_STAT register and common
 flags
In-Reply-To: <20260101035555.1300511-8-chad@jablonski.xyz>
Message-ID: <466e96fb-f4ad-0d66-2473-4d7db5bab27c@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-8-chad@jablonski.xyz>
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
> The PM4_STAT register largely mirrors the flags of the GUI_STAT
> register. The exception is that the low bits of PM4_STAT reflect the
> remaining slots in the CCE FIFO instead of the GUI FIFO.
>
> This implements a very incomplete set of common flags
> (MICRO_BUSY and GUI_ACTIVE) and the PM4_STAT register.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 16 +++++++++++++++-
> hw/display/ati_cce.c  | 38 ++++++++++++++++++++++++++++++++++++++
> hw/display/ati_cce.h  |  3 +++
> hw/display/ati_regs.h |  1 +
> 4 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 9edde2b0bc..3f31a76b72 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -276,6 +276,16 @@ static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
>     }
> }
>
> +static uint32_t ati_common_stat(ATIVGAState *s)
> +{
> +    /* TODO: This is _very_ naive. It will evolve. */
> +    uint32_t micro_busy = ati_cce_micro_busy(&s->cce.cur_packet) ?
> +                          MICRO_BUSY : 0;
> +    /* GUI_ACTIVE is the OR of all other status flags */
> +    uint32_t gui_active = micro_busy ? GUI_ACTIVE : 0;
> +    return gui_active | micro_busy;
> +}
> +
> static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
> {
>     ATIVGAState *s = opaque;
> @@ -383,7 +393,7 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         break;
>     case RBBM_STATUS:
>     case GUI_STAT:
> -        val = 64; /* free CMDFIFO entries */
> +        val = ati_common_stat(s) | 64; /* free CMDFIFO entries */
>         break;
>     case CRTC_H_TOTAL_DISP:
>         val = s->regs.crtc_h_total_disp;
> @@ -543,6 +553,10 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case PM4_MICRO_CNTL:
>         val = s->cce.freerun ? PM4_MICRO_FREERUN : 0;
>         break;
> +    case PM4_STAT: {
> +        val = ati_common_stat(s) | ati_cce_fifo_cnt(&s->cce);
> +        break;
> +    }
>     default:
>         break;
>     }
> diff --git a/hw/display/ati_cce.c b/hw/display/ati_cce.c
> index 62a88a54df..3d35b0e857 100644
> --- a/hw/display/ati_cce.c
> +++ b/hw/display/ati_cce.c
> @@ -11,6 +11,24 @@
> #include "ati_int.h"
> #include "trace.h"
>
> +static uint32_t
> +ati_cce_fifo_max(uint8_t mode)
> +{
> +    switch (mode) {
> +    case PM4_BUFFER_CNTL_NONPM4...PM4_BUFFER_CNTL_192BM:

You could move this down before default: then no separate case is needed 
for it as this seems to be the default and other cases are real cases.

> +        return 192;
> +    case PM4_BUFFER_CNTL_128PIO_64INDBM...PM4_BUFFER_CNTL_128BM_64INDBM:
> +        return 128;
> +    case PM4_BUFFER_CNTL_64PIO_128INDBM...PM4_BUFFER_CNTL_64PIO_64VCBM_64INDBM:
> +        /* fall through */

Comment not needed here.

Sorry that I cannot give more advice than such small style comments but I 
don't know these GPUs that well and have no time to dig into it so I can 
only give generic ideas and try to review it. I still need to check the 
host data series. Thanks a lot for this great contribution, keep up the 
good work.

Regards,
BALATON Zoltan

> +    case PM4_BUFFER_CNTL_64PIO_64VCPIO_64INPIO:
> +        return 64;
> +    default:
> +        /* Undocumented but testing shows this returns 192 otherwise */
> +        return 192;
> +    }
> +}
> +
> static inline uint32_t
> ati_cce_data_packets_remaining(const ATIPM4PacketState *p)
> {
> @@ -154,3 +172,23 @@ ati_cce_receive_data(ATIVGAState *s, uint32_t data)
>     }
>     ati_cce_process_packet_data(s, data);
> }
> +
> +bool
> +ati_cce_micro_busy(const ATIPM4PacketState *p)
> +{
> +    uint32_t remaining = ati_cce_data_packets_remaining(p);
> +    if (remaining > 0) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +uint32_t
> +ati_cce_fifo_cnt(const ATICCEState *c)
> +{
> +    /*
> +     * This should return the available slots. Given that commands are
> +     * processed immediately this returns the fifo max for now.
> +     */
> +    return ati_cce_fifo_max(c->buffer_mode);
> +}
> diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
> index b6ad21f47e..12aede6ecc 100644
> --- a/hw/display/ati_cce.h
> +++ b/hw/display/ati_cce.h
> @@ -85,4 +85,7 @@ typedef struct ATICCEState {
> } ATICCEState;
>
> void ati_cce_receive_data(ATIVGAState *s, uint32_t data);
> +bool ati_cce_micro_busy(const ATIPM4PacketState *p);
> +uint32_t ati_cce_fifo_cnt(const ATICCEState *c);
> +
> #endif /* ATI_CCE_H */
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7118449f5..841019ac7b 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -280,6 +280,7 @@
>
> /* CONSTANTS */
> #define GUI_ACTIVE                              0x80000000
> +#define MICRO_BUSY                              0x00020000
> #define ENGINE_IDLE                             0x0
>
> #define PLL_WR_EN                               0x00000080
>

