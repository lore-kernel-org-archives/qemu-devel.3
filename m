Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1591CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE7k6-0000fW-Rj; Wed, 29 Oct 2025 11:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE7k2-0000f7-GL
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:05:38 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vE7jv-00057i-8S
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:05:38 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1FD2C597301;
 Wed, 29 Oct 2025 16:05:23 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id r6O-jtdoqWtS; Wed, 29 Oct 2025 16:05:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9879E597304; Wed, 29 Oct 2025 16:05:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96526597300;
 Wed, 29 Oct 2025 16:05:20 +0100 (CET)
Date: Wed, 29 Oct 2025 16:05:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ati-vga: Implement HOST_DATA transfers to enable X.org
 text rendering
In-Reply-To: <20251029140112.275456-1-chad@jablonski.xyz>
Message-ID: <e3e36622-94fc-b892-6283-280b3ec5292d@eik.bme.hu>
References: <20251029140112.275456-1-chad@jablonski.xyz>
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

Hello,

On Wed, 29 Oct 2025, Chad Jablonski wrote:
> HOST_DATA as a source for 2D blits (ROP3_SRCCOPY) was unimplemented,
> preventing X.org text rendering with 2D acceleration enabled. This
> implements monochrome HOST_DATA blits with color expansion, enabling
> xterm to render text correctly.

Great stuff, I meant to work on this but never got to it yet. Keep these 
coming! It's not likely we can polish it enough to be in next release but 
there's still a few days left, otherwise I take it as an RFC and here's a 
quick review.

> The blit itself has been implemented as a separate function to keep
> things focused. Future work could refactor this, and the existing
> blits, to use shared helpers for common patterns.
>
> Changes:
> - Add clipping register handlers (SC_TOP_LEFT, SC_BOTTOM_RIGHT,
>  SRC_SC_BOTTOM_RIGHT) and defaulting
> - Add DP_SRC_FRGD_CLR and DP_SRC_BKGD_CLR register write handlers to
>  enable color expansion
> - Implement expand_colors() to convert 1bpp monochrome data to 32bpp
>  color
> - Add ati_blt_mono_host_to_screen() for monochrome HOST_DATA blits

That's a lot of changes for a single patch. Could this be split into a 
series along the above lines to put each logical change into its own patch 
for easier review?

> The host data buffer has a fixed 4MiB size. This _should_ cover typical
> use cases and overflow is logged. Future work could implement dynamic
> allocation based on blit dimensions.
>
> Tested on Rage 128. From what I understand the R100 also shares these
> registers but that device has not been tested against Xorg. There
> seem to be other issues preventing Xorg from starting with the radeon
> driver.

I think the problem with R100 is that it needs CCE and that's the main 
issue with the driver, at least with Linux DRM and the Amiga like drivers 
I've checked, I don't know about older Linux framebuffer and Xorg drivers.

> Note: The xorg/xf86-video-r128 drivers support both CCE (DMA)
> and MMIO acceleration. This implements MMIO, which the driver
> uses when built with --disable-dri. CCE of course is another can of
> worms.

I know about two other uses of host data that this could be tested with:

Solaris also uses it and could reproduce it with sol-10-u11-ga-x86-dvd.iso 
I think it needs qemu-system-x86_64 -m 1G -cpu coreduo -device 
ati-vga,model=rv100 but it was a long time ago I've last tried.

MorphOS when rendering bitmap fonts as reported here: 
https://morph.zone/modules/newbb_plus/viewtopic.php?forum=3&topic_id=13912&post_id=160655&viewmode=flat&sortorder=0&showonepost=1
I could reproduce it with TVPaint under MorphOS.

If you don't have these or can't test it I can eventually try with these 
but just in case you need more test cases these are that I know of.

Some more comments below.

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati.c      |  78 ++++++++++++++++++++++++++++--
> hw/display/ati_2d.c   | 110 +++++++++++++++++++++++++++++++++++++++++-
> hw/display/ati_dbg.c  |   9 ++++
> hw/display/ati_int.h  |   6 +++
> hw/display/ati_regs.h |  28 ++++++++++-
> 5 files changed, 223 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f7c0006a87..1dfaa79202 100644
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
> @@ -804,9 +813,14 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         }
>         break;
>     case DST_WIDTH:
> +    {
> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>         s->regs.dst_width = data & 0x3fff;
> -        ati_2d_blt(s);
> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
> +            ati_2d_blt(s);
> +        }
>         break;
> +    }
>     case DST_HEIGHT:
>         s->regs.dst_height = data & 0x3fff;
>         break;
> @@ -853,21 +867,39 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         s->regs.dst_y = (data >> 16) & 0x3fff;
>         break;
>     case DST_HEIGHT_WIDTH:
> +    {
> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>         s->regs.dst_width = data & 0x3fff;
>         s->regs.dst_height = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
> +            ati_2d_blt(s);
> +        }
>         break;
> +    }
>     case DP_GUI_MASTER_CNTL:
> -        s->regs.dp_gui_master_cntl = data & 0xf800000f;
> +        s->regs.dp_gui_master_cntl = data & 0xff80000f;
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
>         break;
>     case DST_WIDTH_X:
> +    {
> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>         s->regs.dst_x = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
> +            ati_2d_blt(s);
> +        }
>         break;
> +    }
>     case SRC_X_Y:
>         s->regs.src_y = data & 0x3fff;
>         s->regs.src_x = (data >> 16) & 0x3fff;
> @@ -877,10 +909,15 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>         s->regs.dst_x = (data >> 16) & 0x3fff;
>         break;
>     case DST_WIDTH_HEIGHT:
> +    {
> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
>         s->regs.dst_height = data & 0x3fff;
>         s->regs.dst_width = (data >> 16) & 0x3fff;
> -        ati_2d_blt(s);
> +        if (src != GMC_SRC_SOURCE_HOST_DATA) {
> +            ati_2d_blt(s);
> +        }
>         break;
> +    }
>     case DST_HEIGHT_Y:
>         s->regs.dst_y = data & 0x3fff;
>         s->regs.dst_height = (data >> 16) & 0x3fff;
> @@ -909,6 +946,12 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>     case DP_CNTL:
>         s->regs.dp_cntl = data;
>         break;
> +    case DP_SRC_FRGD_CLR:
> +        s->regs.dp_src_frgd_clr = data;
> +        break;
> +    case DP_SRC_BKGD_CLR:
> +        s->regs.dp_src_bkgd_clr = data;
> +        break;
>     case DP_DATATYPE:
>         s->regs.dp_datatype = data & 0xe0070f0f;
>         break;
> @@ -937,6 +980,29 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
> +    case HOST_DATA0 ... HOST_DATA7:
> +    case HOST_DATA_LAST:
> +        if (s->host_data_pos + 4 > sizeof(s->host_data_buffer)) {
> +            qemu_log_mask(LOG_UNIMP, "HOST_DATA buffer overflow "
> +                         "(buffer size: %zu bytes)\n",
> +                          sizeof(s->host_data_buffer));
> +            return;
> +        }
> +        stn_he_p(&s->host_data_buffer[s->host_data_pos], 4, data);
> +        s->host_data_pos += 4;
> +        if (addr == HOST_DATA_LAST) {
> +            ati_2d_blt(s);
> +        }
> +        break;
>     default:
>         break;
>     }
> @@ -1018,6 +1084,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>     /* most interrupts are not yet emulated but MacOS needs at least VBlank */
>     dev->config[PCI_INTERRUPT_PIN] = 1;
>     timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, ati_vga_vblank_irq, s);
> +    s->host_data_pos = 0;

You probably don't need this line because device state is 0 init and reset 
will run after realize and overwrite it so it's enough to reset it in the 
reset method below.

> }
>
> static void ati_vga_reset(DeviceState *dev)
> @@ -1030,6 +1097,7 @@ static void ati_vga_reset(DeviceState *dev)
>     /* reset vga */
>     vga_common_reset(&s->vga);
>     s->mode = VGA_MODE;
> +    s->host_data_pos = 0;
> }
>
> static void ati_vga_exit(PCIDevice *dev)
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6..6b0b4775ff 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -24,6 +24,9 @@
>  * possible.
>  */
>
> +#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)

May need a better name? There are different defaults so not clear which 
one is this or is it used for all parameters?

> +#define EXPANDED_SRC_BPP 32
> +
> static int ati_bpp_from_datatype(ATIVGAState *s)
> {
>     switch (s->regs.dp_datatype & 0xf) {
> @@ -43,7 +46,106 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> -#define DEFAULT_CNTL (s->regs.dp_gui_master_cntl & GMC_DST_PITCH_OFFSET_CNTL)
> +/* Convert 1bpp monochrome data to 32bpp ARGB using color expansion */
> +static void expand_colors(uint8_t *color_dst, const uint8_t *mono_src,
> +                          uint32_t width, uint32_t height,
> +                          uint32_t fg_color, uint32_t bg_color,
> +                          bool lsb_to_msb)
> +{
> +    uint32_t byte, color;
> +    uint8_t *pixel;
> +    int i, j, bit;
> +    /* Rows are 32-bit aligned */
> +    int bytes_per_row = ((width + 31) / 32) * 4;
> +
> +    for (i = 0; i < height; i++) {
> +        for (j = 0; j < width; j++) {
> +            byte = mono_src[i * bytes_per_row + (j / 8)];
> +            bit = lsb_to_msb ? 7 - (j % 8) : j % 8;
> +            color = (byte >> bit) & 0x1 ? fg_color : bg_color;
> +            pixel = &color_dst[(i * width + j) * 4];
> +            memcpy(pixel, &color, sizeof(color));
> +        }
> +    }
> +}
> +
> +/* Blit color expanded HOST_DATA to the screen */
> +static void ati_blt_mono_host_to_screen(ATIVGAState *s)

Why do we need a separate function when we have a buffer with source data? 
Can't we use the same blit setting the source to the buffer? If only 
because of color expansion can that be done beforehand? It seems to have a 
separate pass over the image anyway and not doing it line by line but I 
think it could be done for one line in the main blit function too.

Regards,
BALATON Zoltan

> +{
> +    DisplaySurface *ds = qemu_console_surface(s->vga.con);
> +
> +    uint8_t *mono_data, *color_data, *dst_data;
> +    uint32_t dst_stride, dst_x, dst_y, bpp;
> +    uint32_t width = s->regs.dst_width;
> +    uint32_t height = s->regs.dst_height;
> +    uint32_t pixels = width * height;
> +    bool lsb_to_msb = s->regs.dp_gui_master_cntl & GMC_BYTE_ORDER_LSB_TO_MSB;
> +    uint32_t fg_clr = s->regs.dp_src_frgd_clr;
> +    uint32_t bg_clr = s->regs.dp_src_bkgd_clr;
> +
> +    /* Monochrome source is 1 bpp aligned to 32-bit rows */
> +    uint32_t mono_size = ((width + 31) / 32) * 4 * height;
> +    /* Color destination is 32 bpp */
> +    uint32_t clr_size = pixels * sizeof(uint32_t);
> +
> +    if (s->host_data_pos < mono_size) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "HOST_DATA blit requires %u bytes, buffer holds %u "
> +                      "(increase buffer size)\n",
> +                      mono_size, s->host_data_pos);
> +        return;
> +    }
> +
> +    mono_data = s->host_data_buffer;
> +    color_data = g_malloc(clr_size);
> +
> +    expand_colors(color_data, mono_data, width, height,
> +                  fg_clr, bg_clr, lsb_to_msb);
> +
> +    /* Rage 128 stores pitch as pixels * 8. We need pixels. */
> +    dst_stride = (DEFAULT_CNTL ?
> +                 s->regs.dst_pitch : s->regs.default_pitch) * 8;
> +    dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +            s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> +    dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +            s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    bpp = ati_bpp_from_datatype(s);
> +    dst_data = s->vga.vram_ptr + (DEFAULT_CNTL ?
> +               s->regs.dst_offset : s->regs.default_offset);
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        dst_data += s->regs.crtc_offset & 0x07ffffff;
> +    }
> +    /* And now we need stride in words to pass to pixman */
> +    dst_stride = (dst_stride * (bpp / 8)) / sizeof(uint32_t);
> +
> +    pixman_blt((uint32_t *)color_data, (uint32_t *)dst_data,
> +               width, dst_stride, EXPANDED_SRC_BPP, bpp,
> +               0, 0, dst_x, dst_y,
> +               width, height);
> +    DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
> +            color_data, dst_data, width, dst_stride, EXPANDED_SRC_BPP, bpp,
> +            0, 0, dst_x, dst_y,
> +            width, height);
> +
> +    g_free(color_data);
> +    s->host_data_pos = 0;
> +
> +    s->regs.dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> +                     dst_x + s->regs.dst_width : dst_x);
> +    s->regs.dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> +                     dst_y + s->regs.dst_height : dst_y);
> +
> +    if (dst_data >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> +        dst_data < s->vga.vram_ptr + s->vga.vbe_start_addr +
> +        s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> +            memory_region_set_dirty(
> +                &s->vga.vram, s->vga.vbe_start_addr +
> +                (DEFAULT_CNTL ? s->regs.dst_offset : s->regs.default_offset) +
> +                dst_y * surface_stride(ds),
> +                height * surface_stride(ds)
> +            );
> +    }
> +}
>
> void ati_2d_blt(ATIVGAState *s)
> {
> @@ -92,6 +194,12 @@ void ati_2d_blt(ATIVGAState *s)
>     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
>     case ROP3_SRCCOPY:
>     {
> +        uint32_t src = s->regs.dp_gui_master_cntl & GMC_SRC_SOURCE_MASK;
> +        if (src == GMC_SRC_SOURCE_HOST_DATA) {
> +            ati_blt_mono_host_to_screen(s);
> +            return;
> +        }
> +
>         bool fallback = false;
>         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
> index 3ffa7f35df..5c799d540a 100644
> --- a/hw/display/ati_dbg.c
> +++ b/hw/display/ati_dbg.c
> @@ -252,6 +252,15 @@ static struct ati_regdesc ati_reg_names[] = {
>     {"MC_SRC1_CNTL", 0x19D8},
>     {"TEX_CNTL", 0x1800},
>     {"RAGE128_MPP_TB_CONFIG", 0x01c0},
> +    {"HOST_DATA0", 0x17c0},
> +    {"HOST_DATA1", 0x17c4},
> +    {"HOST_DATA2", 0x17c8},
> +    {"HOST_DATA3", 0x17cc},
> +    {"HOST_DATA4", 0x17d0},
> +    {"HOST_DATA5", 0x17d4},
> +    {"HOST_DATA6", 0x17d8},
> +    {"HOST_DATA7", 0x17dc},
> +    {"HOST_DATA_LAST", 0x17e0},
>     {NULL, -1}
> };
>
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index f5a47b82b0..7973ce99bf 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -14,6 +14,7 @@
> #include "hw/i2c/bitbang_i2c.h"
> #include "vga_int.h"
> #include "qom/object.h"
> +#include "qemu/units.h"
>
> /*#define DEBUG_ATI*/
>
> @@ -82,6 +83,9 @@ typedef struct ATIVGARegs {
>     uint32_t default_pitch;
>     uint32_t default_tile;
>     uint32_t default_sc_bottom_right;
> +    uint32_t sc_top_left;
> +    uint32_t sc_bottom_right;
> +    uint32_t src_sc_bottom_right;
> } ATIVGARegs;
>
> struct ATIVGAState {
> @@ -100,6 +104,8 @@ struct ATIVGAState {
>     MemoryRegion io;
>     MemoryRegion mm;
>     ATIVGARegs regs;
> +    uint32_t host_data_pos;
> +    uint8_t host_data_buffer[4 * MiB];
> };
>
> const char *ati_reg_name(int num);
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index d7127748ff..4e9b4cc896 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -252,6 +252,15 @@
> #define DP_T12_CNTL                             0x178c
> #define DST_BRES_T1_LNTH                        0x1790
> #define DST_BRES_T2_LNTH                        0x1794
> +#define HOST_DATA0                              0x17c0
> +#define HOST_DATA1                              0x17c4
> +#define HOST_DATA2                              0x17c8
> +#define HOST_DATA3                              0x17cc
> +#define HOST_DATA4                              0x17d0
> +#define HOST_DATA5                              0x17d4
> +#define HOST_DATA6                              0x17d8
> +#define HOST_DATA7                              0x17dc
> +#define HOST_DATA_LAST                          0x17e0
> #define SCALE_SRC_HEIGHT_WIDTH                  0x1994
> #define SCALE_OFFSET_0                          0x1998
> #define SCALE_PITCH                             0x199c
> @@ -392,11 +401,10 @@
> /* DP_GUI_MASTER_CNTL bit constants */
> #define GMC_SRC_PITCH_OFFSET_CNTL               0x00000001
> #define GMC_DST_PITCH_OFFSET_CNTL               0x00000002
> -#define GMC_SRC_CLIP_DEFAULT                    0x00000000
> -#define GMC_DST_CLIP_DEFAULT                    0x00000000
> #define GMC_BRUSH_SOLIDCOLOR                    0x000000d0
> #define GMC_SRC_DSTCOLOR                        0x00003000
> #define GMC_BYTE_ORDER_MSB_TO_LSB               0x00000000
> +#define GMC_BYTE_ORDER_LSB_TO_MSB               0x00004000
> #define GMC_DP_SRC_RECT                         0x02000000
> #define GMC_3D_FCN_EN_CLR                       0x00000000
> #define GMC_AUX_CLIP_CLEAR                      0x20000000
> @@ -404,6 +412,22 @@
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
> +/* DP_GUI_MASTER_CNTL DP_SRC_SOURCE named constants */
> +#define GMC_SRC_SOURCE_MASK                     0x07000000
> +#define GMC_SRC_SOURCE_MEMORY                   0x02000000
> +#define GMC_SRC_SOURCE_HOST_DATA                0x03000000
> +#define GMC_SRC_SOURCE_HOST_DATA_ALIGNED        0x04000000
> +
> /* DP_GUI_MASTER_CNTL ROP3 named constants */
> #define GMC_ROP3_MASK                           0x00ff0000
> #define ROP3_BLACKNESS                          0x00000000
>

