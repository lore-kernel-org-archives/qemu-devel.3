Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D90CE9D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 00:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdHPQ-0006xb-0A; Tue, 06 Jan 2026 19:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHPO-0006x8-SK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:28:18 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdHPM-0004yH-4B
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 19:28:18 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 868C8596A0A;
 Wed, 07 Jan 2026 01:28:12 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id H9uxIkK0gr32; Wed,  7 Jan 2026 01:28:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6D41D5969FD; Wed, 07 Jan 2026 01:28:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 676DC5969F6;
 Wed, 07 Jan 2026 01:28:10 +0100 (CET)
Date: Wed, 7 Jan 2026 01:28:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/9] ati-vga: Store DP_DATATYPE and DP_MIX fields
 independently
In-Reply-To: <20260106185700.2102742-2-chad@jablonski.xyz>
Message-ID: <4948bfc9-6dde-566b-d01a-84a9d439306e@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-2-chad@jablonski.xyz>
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
> DP_GUI_MASTER_CNTL accesses the same values as DP_DATATYPE and DP_MIX.
> This was not reflected in how we stored register state. This meant that
> you could easily end up with stale state in one or the other register.
>
> This stores each field directly instead of packing them into a field
> named after the register. The register handlers then shift bits around
> if needed. This not only keeps things in sync but means less shifting
> and masking when using these values internally.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      | 41 +++++++++++++++++++++++++++++++++--------
> hw/display/ati_2d.c   | 12 ++++++------
> hw/display/ati_int.h  | 10 ++++++++--
> hw/display/ati_regs.h | 33 +++++++++++++++++++++++++++++----
> 4 files changed, 76 insertions(+), 20 deletions(-)

If this made the code simpler I wouldn't be against it but this does not 
seem to save much as these values are either never used or not used often 
enough to store them separately but doing so makes the register 
read/writes more complex. It's easy enough to extract the needed fields 
from the regs into a local once at the beginning of a block where there 
are used and that way we at least store and return the unimplemented bits 
in the registers even if we do nothing with them yet without having to 
handle them separately. So I'm sorry it's causing you another rebase but I 
think we should drop this patch. I came to this conclusion after searching 
for the added uint8_t and bool fields after this series and most usages 
are in register read/write and the others that aren't often just compare 
to a constant that can be already shifted so maybe rop3 is the only one 
that might benefit but that can be stored in a local variable. As for 
which register to store them in as the authorative place I'd use the 
M6/RV100 register reference which lists DP_GUI_MASTER_CNTL fields as alias 
of other regs so maybe this patch only needs to fix the DP_GUI_MASTER_CNTL 
in mm_read to return the missing fields.

Regards,
BALATON Zoltan

> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index e9c3ad2cd1..0bbe8915f1 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -460,7 +460,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val = s->regs.dst_y;
>         break;
>     case DP_GUI_MASTER_CNTL:
> -        val = s->regs.dp_gui_master_cntl;
> +        val = s->regs.dp_gui_master_cntl |
> +              (s->regs.dp_brush_datatype << 4) |
> +              (s->regs.dp_dst_datatype << 8) |
> +              (s->regs.dp_src_datatype << 12) |
> +              (s->regs.byte_pix_order << 14) |
> +              (s->regs.conversion_temp << 15) |
> +              (s->regs.dp_rop3 << 16) |
> +              (s->regs.dp_src_source << 24);
>         break;
>     case SRC_OFFSET:
>         val = s->regs.src_offset;
> @@ -487,10 +494,15 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>         val = s->regs.dp_cntl;
>         break;
>     case DP_DATATYPE:
> -        val = s->regs.dp_datatype;
> +        val = (s->regs.dp_dst_datatype) |
> +              (s->regs.dp_brush_datatype << 8) |
> +              (s->regs.dp_src_datatype << 16) |
> +              (s->regs.host_big_endian_en << 29) |
> +              (s->regs.byte_pix_order << 30) |
> +              (s->regs.conversion_temp << 31);
>         break;
>     case DP_MIX:
> -        val = s->regs.dp_mix;
> +        val = (s->regs.dp_rop3 << 16) | (s->regs.dp_src_source << 8);
>         break;
>     case DP_WRITE_MASK:
>         val = s->regs.dp_write_mask;
> @@ -858,10 +870,17 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         ati_2d_blt(s);
>         break;
>     case DP_GUI_MASTER_CNTL:
> +        /* Mask out fields that are stored independently */
>         s->regs.dp_gui_master_cntl = data & 0xf800000f;
> -        s->regs.dp_datatype = (data & 0x0f00) >> 8 | (data & 0x30f0) << 4 |
> -                              (data & 0x4000) << 16;
> -        s->regs.dp_mix = (data & GMC_ROP3_MASK) | (data & 0x7000000) >> 16;
> +        /* DP_DATATYPE fields */
> +        s->regs.dp_brush_datatype = (data & GMC_BRUSH_DATATYPE_MASK) >> 4;
> +        s->regs.dp_dst_datatype = (data & GMC_DST_DATATYPE_MASK) >> 8;
> +        s->regs.dp_src_datatype = (data & GMC_SRC_DATATYPE_MASK) >> 12;
> +        s->regs.byte_pix_order = (data & GMC_BYTE_PIX_ORDER) >> 14;
> +        s->regs.conversion_temp = (data & GMC_CONVERSION_TEMP) >> 15;
> +        /* DP_MIX fields */
> +        s->regs.dp_rop3 = (data & GMC_ROP3_MASK) >> 16;
> +        s->regs.dp_src_source = (data & GMC_SRC_SOURCE_MASK) >> 24;
>         break;
>     case DST_WIDTH_X:
>         s->regs.dst_x = data & 0x3fff;
> @@ -910,10 +929,16 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         s->regs.dp_cntl = data;
>         break;
>     case DP_DATATYPE:
> -        s->regs.dp_datatype = data & 0xe0070f0f;
> +        s->regs.dp_dst_datatype = (data & DP_DATATYPE_DST_DATATYPE_MASK);
> +        s->regs.dp_brush_datatype = (data & DP_DATATYPE_BRUSH_DATATYPE_MASK) >> 8;
> +        s->regs.dp_src_datatype = (data & DP_DATATYPE_SRC_DATATYPE_MASK) >> 16;
> +        s->regs.host_big_endian_en = (data & DP_DATATYPE_HOST_BE_EN) >> 29;
> +        s->regs.byte_pix_order = (data & DP_DATATYPE_BYTE_PIX_ORDER) >> 30;
> +        s->regs.conversion_temp = (data & DP_DATATYPE_CONVERSION_TEMP) >> 31;
>         break;
>     case DP_MIX:
> -        s->regs.dp_mix = data & 0x00ff0700;
> +        s->regs.dp_src_source = (data & DP_MIX_SRC_SOURCE_MASK) >> 8;
> +        s->regs.dp_rop3 = (data & DP_MIX_ROP3_MASK) >> 16;
>         break;
>     case DP_WRITE_MASK:
>         s->regs.dp_write_mask = data;
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6..0531d1a526 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -26,7 +26,7 @@
>
> static int ati_bpp_from_datatype(ATIVGAState *s)
> {
> -    switch (s->regs.dp_datatype & 0xf) {
> +    switch (s->regs.dp_dst_datatype) {
>     case 2:
>         return 8;
>     case 3:
> @@ -38,7 +38,7 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>         return 32;
>     default:
>         qemu_log_mask(LOG_UNIMP, "Unknown dst datatype %d\n",
> -                      s->regs.dp_datatype & 0xf);
> +                      s->regs.dp_dst_datatype);
>         return 0;
>     }
> }
> @@ -53,7 +53,7 @@ void ati_2d_blt(ATIVGAState *s)
>     DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
>             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
>             surface_bits_per_pixel(ds),
> -            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +            (s->regs.dp_rop3));
>     unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                       s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
>     unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> @@ -89,7 +89,7 @@ void ati_2d_blt(ATIVGAState *s)
>             s->regs.dst_width, s->regs.dst_height,
>             (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? '>' : '<'),
>             (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? 'v' : '^'));
> -    switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +    switch (s->regs.dp_rop3) {
>     case ROP3_SRCCOPY:
>     {
>         bool fallback = false;
> @@ -191,7 +191,7 @@ void ati_2d_blt(ATIVGAState *s)
>     {
>         uint32_t filler = 0;
>
> -        switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> +        switch (s->regs.dp_rop3) {
>         case ROP3_PATCOPY:
>             filler = s->regs.dp_brush_frgd_clr;
>             break;
> @@ -239,6 +239,6 @@ void ati_2d_blt(ATIVGAState *s)
>     }
>     default:
>         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
> -                      (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +                      s->regs.dp_rop3);
>     }
> }
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..59a1812034 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -75,13 +75,19 @@ typedef struct ATIVGARegs {
>     uint32_t dp_src_frgd_clr;
>     uint32_t dp_src_bkgd_clr;
>     uint32_t dp_cntl;
> -    uint32_t dp_datatype;
> -    uint32_t dp_mix;
>     uint32_t dp_write_mask;
>     uint32_t default_offset;
>     uint32_t default_pitch;
>     uint32_t default_tile;
>     uint32_t default_sc_bottom_right;
> +    uint8_t dp_src_source;
> +    uint8_t dp_rop3;
> +    uint8_t dp_dst_datatype;
> +    uint8_t dp_brush_datatype;
> +    uint8_t dp_src_datatype;
> +    bool host_big_endian_en;
> +    bool byte_pix_order;
> +    bool conversion_temp;
> } ATIVGARegs;
>
> struct ATIVGAState {
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..fce9270635 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -381,6 +381,12 @@
> #define PM4_BUFFER_CNTL_NONPM4                  0x00000000
>
> /* DP_DATATYPE bit constants */
> +#define DP_DATATYPE_DST_DATATYPE_MASK           0x0000000f
> +#define DP_DATATYPE_BRUSH_DATATYPE_MASK         0x00000f00
> +#define DP_DATATYPE_SRC_DATATYPE_MASK           0x00030000
> +#define DP_DATATYPE_HOST_BE_EN                  0x20000000
> +#define DP_DATATYPE_BYTE_PIX_ORDER              0x40000000
> +#define DP_DATATYPE_CONVERSION_TEMP             0x80000000
> #define DST_8BPP                                0x00000002
> #define DST_15BPP                               0x00000003
> #define DST_16BPP                               0x00000004
> @@ -394,6 +400,11 @@
> #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
> #define GMC_SRC_CLIP_DEFAULT                    0x00000000
> #define GMC_DST_CLIP_DEFAULT                    0x00000000
> +#define GMC_BRUSH_DATATYPE_MASK                 0x000000f0
> +#define GMC_DST_DATATYPE_MASK                   0x00000f00
> +#define GMC_SRC_DATATYPE_MASK                   0x00003000
> +#define GMC_BYTE_PIX_ORDER                      0x00004000
> +#define GMC_CONVERSION_TEMP                     0x00008000
> #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
> #define GMC_SRC_DSTCOLOR                        0x00003000
> #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
> @@ -404,12 +415,24 @@
> #define GMC_WRITE_MASK_SET                      0x40000000
> #define GMC_DP_CONVERSION_TEMP_6500             0x00000000
>
> +/* DP_GUI_MASTER_CNTL DP_SRC_DATATYPE named constants */
> +#define GMC_SRC_DATATYPE_MASK                   0x00003000
> +#define GMC_SRC_DATATYPE_MONO_FRGD_BKGD         0
> +#define GMC_SRC_DATATYPE_MONO_FRGD              1
> +#define GMC_SRC_DATATYPE_COLOR                  3
> +
> +/* DP_GUI_MASTER_CNTL DP_SRC_SOURCE named constants */
> +#define GMC_SRC_SOURCE_MASK                     0x07000000
> +#define GMC_SRC_SOURCE_MEMORY                   2
> +#define GMC_SRC_SOURCE_HOST_DATA                3
> +#define GMC_SRC_SOURCE_HOST_DATA_ALIGNED        4
> +
> /* DP_GUI_MASTER_CNTL ROP3 named constants */
> #define GMC_ROP3_MASK                           0x00ff0000
> -#define ROP3_BLACKNESS                          0x00000000
> -#define ROP3_SRCCOPY                            0x00cc0000
> -#define ROP3_PATCOPY                            0x00f00000
> -#define ROP3_WHITENESS                          0x00ff0000
> +#define ROP3_BLACKNESS                          0
> +#define ROP3_SRCCOPY                            0xcc
> +#define ROP3_PATCOPY                            0xf0
> +#define ROP3_WHITENESS                          0xff
>
> #define SRC_DSTCOLOR                            0x00030000
>
> @@ -434,6 +457,8 @@
> #define DST_POLY_EDGE                           0x00040000
>
> /* DP_MIX bit constants */
> +#define DP_MIX_SRC_SOURCE_MASK                  0x00000700
> +#define DP_MIX_ROP3_MASK                        0x00ff0000
> #define DP_SRC_RECT                             0x00000200
> #define DP_SRC_HOST                             0x00000300
> #define DP_SRC_HOST_BYTEALIGN                   0x00000400
>

