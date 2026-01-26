Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820ACD19501
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPg6-0005TB-8B; Mon, 26 Jan 2026 11:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkPg2-0005Sp-3N
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:42:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkPfy-0005H5-Rk
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:42:57 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F09DF5969FA;
 Mon, 26 Jan 2026 17:42:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 3dnuk8Q1Qbwp; Mon, 26 Jan 2026 17:42:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C13C65969F3; Mon, 26 Jan 2026 17:42:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BF8D95969F0;
 Mon, 26 Jan 2026 17:42:45 +0100 (CET)
Date: Mon, 26 Jan 2026 17:42:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v5 05/12] ati-vga: Add scissor clipping register
 support
In-Reply-To: <20260116024258.1487173-6-chad@jablonski.xyz>
Message-ID: <a76030e2-61a4-929b-e7a1-ea81300ff8ca@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-6-chad@jablonski.xyz>
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

On Thu, 15 Jan 2026, Chad Jablonski wrote:
> Implement read and write operations on SC_TOP_LEFT, SC_BOTTOM_RIGHT,
> and SRC_SC_BOTTOM_RIGHT registers. These registers are also updated
> when the src and/or dst clipping fields on DP_GUI_MASTER_CNTL are set
> to default clipping.
>
> Scissor clipping is used when rendering text in X.org. The r128 driver
> sends host data much wider than is necessary to draw a glyph and cuts it
> down to size using clipping before rendering. The actual clipping
> implementation follows in a future patch.
>
> This also includes a very minor refactor of the combined
> default_sc_bottom_right field in the registers struct to
> default_sc_bottom and default_sc_right. This was done to
> stay consistent with the other scissor registers and prevent repeated
> masking and extraction.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> ---
>
> v5: Removed unused default_sc_bottom_right field
> ---
> hw/display/ati.c      | 70 +++++++++++++++++++++++++++++++++++++++++--
> hw/display/ati_int.h  |  9 +++++-
> hw/display/ati_regs.h |  2 ++
> 3 files changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 968ee4efca..21339d7e26 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -521,7 +521,32 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val |= s->regs.default_tile << 16;
>         break;
>     case DEFAULT_SC_BOTTOM_RIGHT:
> -        val = s->regs.default_sc_bottom_right;
> +        val = (s->regs.default_sc_bottom << 16) |
> +              s->regs.default_sc_right;
> +        break;
> +    case SC_TOP:
> +        val = s->regs.sc_top;
> +        break;
> +    case SC_LEFT:
> +        val = s->regs.sc_left;
> +        break;
> +    case SC_BOTTOM:
> +        val = s->regs.sc_bottom;
> +        break;
> +    case SC_RIGHT:
> +        val = s->regs.sc_right;
> +        break;
> +    case SRC_SC_BOTTOM:
> +        val = s->regs.src_sc_bottom;
> +        break;
> +    case SRC_SC_RIGHT:
> +        val = s->regs.src_sc_right;
> +        break;
> +    case SC_TOP_LEFT:
> +    case SC_BOTTOM_RIGHT:
> +    case SRC_SC_BOTTOM_RIGHT:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Read from write-only register 0x%x\n", (unsigned)addr);
>         break;
>     default:
>         break;
> @@ -884,6 +909,16 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>             s->regs.dst_offset = s->regs.default_offset;
>             s->regs.dst_pitch = s->regs.default_pitch;
>         }
> +        if (!(data & GMC_SRC_CLIPPING)) {
> +            s->regs.src_sc_right = s->regs.default_sc_right;
> +            s->regs.src_sc_bottom = s->regs.default_sc_bottom;
> +        }
> +        if (!(data & GMC_DST_CLIPPING)) {
> +            s->regs.sc_top = 0;
> +            s->regs.sc_left = 0;
> +            s->regs.sc_right = s->regs.default_sc_right;
> +            s->regs.sc_bottom = s->regs.default_sc_bottom;
> +        }
>         break;
>     case DST_WIDTH_X:
>         s->regs.dst_x = data & 0x3fff;
> @@ -963,7 +998,38 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         }
>         break;
>     case DEFAULT_SC_BOTTOM_RIGHT:
> -        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
> +        s->regs.default_sc_right = data & 0x3fff;
> +        s->regs.default_sc_bottom = (data >> 16) & 0x3fff;
> +        break;
> +    case SC_TOP_LEFT:
> +        s->regs.sc_left = data & 0x3fff;
> +        s->regs.sc_top = (data >> 16) & 0x3fff;
> +        break;
> +    case SC_LEFT:
> +        s->regs.sc_left = data & 0x3fff;
> +        break;
> +    case SC_TOP:
> +        s->regs.sc_top = data & 0x3fff;
> +        break;
> +    case SC_BOTTOM_RIGHT:
> +        s->regs.sc_right = data & 0x3fff;
> +        s->regs.sc_bottom = (data >> 16) & 0x3fff;
> +        break;
> +    case SC_RIGHT:
> +        s->regs.sc_right = data & 0x3fff;
> +        break;
> +    case SC_BOTTOM:
> +        s->regs.sc_bottom = data & 0x3fff;
> +        break;
> +    case SRC_SC_BOTTOM_RIGHT:
> +        s->regs.src_sc_right = data & 0x3fff;
> +        s->regs.src_sc_bottom = (data >> 16) & 0x3fff;
> +        break;
> +    case SRC_SC_RIGHT:
> +        s->regs.src_sc_right = data & 0x3fff;
> +        break;
> +    case SRC_SC_BOTTOM:
> +        s->regs.src_sc_bottom = data & 0x3fff;
>         break;
>     default:
>         break;
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..7cf0933fa1 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -81,7 +81,14 @@ typedef struct ATIVGARegs {
>     uint32_t default_offset;
>     uint32_t default_pitch;
>     uint32_t default_tile;
> -    uint32_t default_sc_bottom_right;
> +    uint16_t default_sc_bottom;
> +    uint16_t default_sc_right;
> +    uint16_t sc_top;
> +    uint16_t sc_left;
> +    uint16_t sc_bottom;
> +    uint16_t sc_right;
> +    uint16_t src_sc_bottom;
> +    uint16_t src_sc_right;

I've tried to sort these to match register offsers so these should be 
between dp_src_bkgd_clr and dp_cntl I think but second check that as I've 
only quickly checked.

Regards,
BALATON Zoltan

> } ATIVGARegs;
>
> struct ATIVGAState {
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 0a0825db04..3999edb9b7 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -397,6 +397,8 @@
> #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
> #define GMC_SRC_CLIP_DEFAULT                    0x00000000
> #define GMC_DST_CLIP_DEFAULT                    0x00000000
> +#define GMC_SRC_CLIPPING                        0x00000004
> +#define GMC_DST_CLIPPING                        0x00000008
> #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
> #define GMC_SRC_DSTCOLOR                        0x00003000
> #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
>

