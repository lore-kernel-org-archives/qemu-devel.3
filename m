Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE18FEEEC1C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbQuM-0006dy-BQ; Thu, 01 Jan 2026 17:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQuL-0006dp-En
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:12:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbQuJ-00037I-4q
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:12:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AE66A5969FF;
 Thu, 01 Jan 2026 23:12:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id nt9O_xcvfSQD; Thu,  1 Jan 2026 23:12:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AD02E5969FA; Thu, 01 Jan 2026 23:12:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AB8515969F6;
 Thu, 01 Jan 2026 23:12:29 +0100 (CET)
Date: Thu, 1 Jan 2026 23:12:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/11] ati-vga: Latch src and dst pitch and offset on
 master_cntl default
In-Reply-To: <20251118154812.57861-5-chad@jablonski.xyz>
Message-ID: <f74367c4-b130-b209-1b69-3166e168f611@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-5-chad@jablonski.xyz>
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

On Tue, 18 Nov 2025, Chad Jablonski wrote:
> Hardware testing on the Rage 128 confirms that (SRC/DST)_OFFSET,
> and (SRC/DST)_PITCH are latched when (SRC/DST)_PITCH_OFFSET_CNTL bits
> in DP_GUI_MASTER_CNTL are set to "default".
>
> The earlier approach looked at the state of the (SRC/DST)_PITCH_OFFSET_CNTL
> bits when offset and pitch registers were used. This meant that when
> (SRC/DST)_PITCH_OFFSET_CNTL was reset to "leave alone" the old values
> stored in the registers would return. This is not how the real hardware
> works.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      |  8 ++++++++
> hw/display/ati_2d.c   | 13 ++++---------
> hw/display/ati_regs.h | 10 ++++++++++
> 3 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index a2c0302e42..d0fa51f773 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -888,6 +888,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>                               (data & 0x4000) << 16;
>         s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
>
> +        if ((data & GMC_SRC_PITCH_OFFSET_CNTL_MASK) == GMC_SRC_PITCH_OFFSET_DEFAULT) {
> +            s->regs.src_offset = s->regs.default_offset;
> +            s->regs.src_pitch = s->regs.default_pitch;
> +        }
> +        if ((data & GMC_DST_PITCH_OFFSET_CNTL_MASK) == GMC_DST_PITCH_OFFSET_DEFAULT) {
> +            s->regs.dst_offset = s->regs.default_offset;
> +            s->regs.dst_pitch = s->regs.default_pitch;
> +        }
>         if ((data & GMC_SRC_CLIPPING_MASK) == GMC_SRC_CLIP_DEFAULT) {
>             s->regs.src_sc_right = s->regs.default_sc_right;
>             s->regs.src_sc_bottom = s->regs.default_sc_bottom;
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6..a8c4c534b9 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -43,8 +43,6 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> -#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
> -
> void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
> @@ -63,13 +61,12 @@ void ati_2d_blt(ATIVGAState *s)
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>         return;
>     }
> -    int dst_stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch;
> +    int dst_stride = s->regs.dst_pitch;
>     if (!dst_stride) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
>         return;
>     }
> -    uint8_t *dst_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> -                        s->regs.dst_offset : s->regs.default_offset);
> +    uint8_t *dst_bits = s->vga.vram_ptr + s->regs.dst_offset;
>
>     if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
>         dst_bits += s->regs.crtc_offset & 0x07ffffff;
> @@ -97,14 +94,12 @@ void ati_2d_blt(ATIVGAState *s)
>                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
>         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
>                        s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
> -        int src_stride = DEFAULT_CNTL ?
> -                         s->regs.src_pitch : s->regs.default_pitch;
> +        int src_stride = s->regs.src_pitch;
>         if (!src_stride) {
>             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
>             return;
>         }
> -        uint8_t *src_bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
> -                            s->regs.src_offset : s->regs.default_offset);
> +        uint8_t *src_bits = s->vga.vram_ptr + s->regs.src_offset;
>
>         if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
>             src_bits += s->regs.crtc_offset & 0x07ffffff;
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 2b56b9fb66..02025eef36 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -402,6 +402,16 @@
> #define GMC_WRITE_MASK_SET                      0x40000000
> #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
>
> +/* DP_GUI_MASTER_CNTL DP_SRC_PITCH_OFFSET named constants */
> +#define GMC_SRC_PITCH_OFFSET_CNTL_MASK          0x00000001
> +#define GMC_SRC_PITCH_OFFSET_DEFAULT            0x00000000
> +#define GMC_SRC_PITCH_OFFSET_LEAVE_ALONE        0x00000001
> +
> +/* DP_GUI_MASTER_CNTL DP_DST_PITCH_OFFSET named constants */
> +#define GMC_DST_PITCH_OFFSET_CNTL_MASK          0x00000002
> +#define GMC_DST_PITCH_OFFSET_DEFAULT            0x00000000
> +#define GMC_DST_PITCH_OFFSET_LEAVE_ALONE        0x00000002
> +

If you're adding these you could remove GMC_SRC_PITCH_OFFSET_CNTL and 
GMC_DST_PITCH_OFFSET_CNTL but I think it's simpler to keep those and 
not add these long new defines and just test for the bit as was in 
DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL) or 
because the zero value is actually what matters as
!(s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL) (or == 0 instead 
of ! if you think that's more explicit).

Along the same lines in patch 2 you can just add GMC_SRC_CLIPPING and 
GMC_DST_CLIPPING as 4 and 8 replacing the unuseful 
GMC_{SRC,DST}_CLIP_DEFAULT values and use that the same way instead of the 
3 detailed new defines of which only 2 are used.

Regards,
BALATON Zoltan

> /* DP_GUI_MASTER_CNTL DP_SRC_CLIPPING named constants */
> #define GMC_SRC_CLIPPING_MASK                   0x00000004
> #define GMC_SRC_CLIP_DEFAULT                    0x00000000
>

