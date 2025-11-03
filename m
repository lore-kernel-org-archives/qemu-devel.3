Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBEDCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuQU-0001lG-DL; Mon, 03 Nov 2025 08:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFuQR-0001kC-Qx
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:16:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFuQH-0000LL-K7
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:16:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 82FD75972E8;
 Mon, 03 Nov 2025 14:16:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wqqT2tAKcGpm; Mon,  3 Nov 2025 14:16:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5AA165972E3; Mon, 03 Nov 2025 14:16:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 592165972E2;
 Mon, 03 Nov 2025 14:16:28 +0100 (CET)
Date: Mon, 3 Nov 2025 14:16:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/7] ati-vga: Add scissor clipping register support
In-Reply-To: <20251103033608.120908-2-chad@jablonski.xyz>
Message-ID: <6e18e36d-fbaf-2f51-949a-666d48f14628@eik.bme.hu>
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-2-chad@jablonski.xyz>
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

On Sun, 2 Nov 2025, Chad Jablonski wrote:
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
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 26 ++++++++++++++++++++++++++
> hw/display/ati_int.h  |  3 +++
> hw/display/ati_regs.h | 12 ++++++++++--
> 3 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 0b4298d078..eb9b30672f 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -510,6 +510,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>     case DEFAULT_SC_BOTTOM_RIGHT:
>         val = s->regs.default_sc_bottom_right;
>         break;
> +    case SC_TOP_LEFT:
> +        val = s->regs.sc_top_left;
> +        break;
> +    case SC_BOTTOM_RIGHT:
> +        val = s->regs.sc_bottom_right;
> +        break;
> +    case SRC_SC_BOTTOM_RIGHT:
> +        val = s->regs.src_sc_bottom_right;
> +        break;
>     default:
>         break;
>     }
> @@ -862,6 +871,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
>                               (data & 0x4000) << 16;
>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
> +
> +        if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
> +            s->regs.src_sc_bottom_right = s->regs.default_sc_bottom_right;
> +        }
> +        if ((data & GMC_DST_CLIPPING_MASK) == GMC_DST_CLIP_DEFAULT) {
> +            s->regs.sc_top_left = 0;
> +            s->regs.sc_bottom_right = s->regs.default_sc_bottom_right;
> +        }

Or is this what you meant by style? Now I get that. I think the bits 
should not reset the regs just cause the operation to use the default 
values instead but if you can verify what actual hardware does that would 
be best.

Regards,
BALATON Zoltan

>         break;
>     case DST_WIDTH_X:
>         s->regs.dst_x = data & 0x3fff;
> @@ -937,6 +954,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DEFAULT_SC_BOTTOM_RIGHT:
>         s->regs.default_sc_bottom_right = data & 0x3fff3fff;
>         break;
> +    case SC_TOP_LEFT:
> +        s->regs.sc_top_left = data;
> +        break;
> +    case SC_BOTTOM_RIGHT:
> +        s->regs.sc_bottom_right = data;
> +        break;
> +    case SRC_SC_BOTTOM_RIGHT:
> +        s->regs.src_sc_bottom_right = data;
> +        break;
>     default:
>         break;
>     }
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index 708cc1dd3a..aab3cbf81a 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -86,6 +86,9 @@ typedef struct ATIVGARegs {
>     uint32_t default_pitch;
>     uint32_t default_tile;
>     uint32_t default_sc_bottom_right;
> +    uint32_t sc_top_left;
> +    uint32_t sc_bottom_right;
> +    uint32_t src_sc_bottom_right;
> } ATIVGARegs;
>
> struct ATIVGAState {
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..2b56b9fb66 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -392,8 +392,6 @@
> /* DP_GUI_MASTER_CNTL bit constants */
> #define GMC_SRC_PITCH_OFFSET_CNTL               0x00000001
> #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
> -#define GMC_SRC_CLIP_DEFAULT                    0x00000000
> -#define GMC_DST_CLIP_DEFAULT                    0x00000000
> #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
> #define GMC_SRC_DSTCOLOR                        0x00003000
> #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
> @@ -404,6 +402,16 @@
> #define GMC_WRITE_MASK_SET                      0x40000000
> #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
>
> +/* DP_GUI_MASTER_CNTL DP_SRC_CLIPPING named constants */
> +#define GMC_SRC_CLIPPING_MASK                   0x00000004
> +#define GMC_SRC_CLIP_DEFAULT                    0x00000000
> +#define GMC_SRC_CLIP_LEAVE_ALONE                0x00000004
> +
> +/* DP_GUI_MASTER_CNTL DP_DST_CLIPPING named constants */
> +#define GMC_DST_CLIPPING_MASK                   0x00000008
> +#define GMC_DST_CLIP_DEFAULT                    0x00000000
> +#define GMC_DST_CLIP_LEAVE_ALONE                0x00000008
> +
> /* DP_GUI_MASTER_CNTL ROP3 named constants */
> #define GMC_ROP3_MASK                           0x00ff0000
> #define ROP3_BLACKNESS                          0x00000000
>

