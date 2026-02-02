Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD7CE7FDF8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3go-0000MN-Ul; Mon, 02 Feb 2026 18:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn3gh-0000LY-3v
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:50:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vn3gf-0006As-2C
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:50:34 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 963CB596A42;
 Tue, 03 Feb 2026 00:50:30 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id qUbGZUE6MMTo; Tue,  3 Feb 2026 00:50:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5EB1E596A0A; Tue, 03 Feb 2026 00:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5CF7A596A41;
 Tue, 03 Feb 2026 00:50:28 +0100 (CET)
Date: Tue, 3 Feb 2026 00:50:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 08/19] ati-vga: Consolidate dirty region tracking in
 ati_2d_blt
In-Reply-To: <20260202204738.3080092-9-chad@jablonski.xyz>
Message-ID: <7e2672e6-5e7b-47d2-1070-ccc71060513e@eik.bme.hu>
References: <20260202204738.3080092-1-chad@jablonski.xyz>
 <20260202204738.3080092-9-chad@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Mon, 2 Feb 2026, Chad Jablonski wrote:
> Both supported ROPs follow the same memory set dirty logic.
> This consolidates that logic to remove the duplication.
>
> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 44 +++++++++++++++++++++++---------------------
> 1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index cfc7bf9789..5d24d11d7a 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -43,15 +43,29 @@ static int ati_bpp_from_datatype(ATIVGAState *s)
>     }
> }
>
> +static void ati_set_dirty(ATIVGAState *s, const uint8_t *dst_bits,
> +                          unsigned dst_y, unsigned dst_height, unsigned rop3)
> +{
> +    VGACommonState *vga = &s->vga;
> +    DisplaySurface *ds = qemu_console_surface(vga->con);
> +    unsigned dst_offset = dst_bits - vga->vram_ptr;

Code style suggests an empty line here.

Are you sure dst_offset calculation this way is correct? Also if 
s->regs.crtc_offset is not 0 as that seems to be added to dst_bits for 
Rage128Pro. This may be replaced with correct value from ctx later but 
then you could just keep the original here to make sure it's not broken.

> +    DPRINTF("%p %u ds: %p %d %d rop: %x\n",
> +            vga->vram_ptr, vga->vbe_start_addr,
> +            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
> +            rop3 >> 16);
> +    if (dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
> +        dst_bits < vga->vram_ptr + vga->vbe_start_addr +
> +        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
> +        memory_region_set_dirty(&vga->vram, vga->vbe_start_addr +
> +                                dst_offset + dst_y * surface_stride(ds),
> +                                dst_height * surface_stride(ds));
> +    }
> +}
> +
> void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>     /* rewritten but for now as a start just to get some output: */
> -    DisplaySurface *ds = qemu_console_surface(s->vga.con);
> -    DPRINTF("%p %u ds: %p %d %d rop: %x\n", s->vga.vram_ptr,
> -            s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
> -            surface_bits_per_pixel(ds),
> -            (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
>     unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                       s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
>     unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> @@ -166,14 +180,6 @@ void ati_2d_blt(ATIVGAState *s)
>                 memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
>             }
>         }
> -        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> -            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> -            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> -            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> -                                    s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> -        }
>         break;
>     }
>     case ROP3_PATCOPY:
> @@ -216,18 +222,14 @@ void ati_2d_blt(ATIVGAState *s)
>                 }
>             }
>         }
> -        if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
> -            dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> -            s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
> -            memory_region_set_dirty(&s->vga.vram, s->vga.vbe_start_addr +
> -                                    s->regs.dst_offset +
> -                                    dst_y * surface_stride(ds),
> -                                    s->regs.dst_height * surface_stride(ds));
> -        }
>         break;
>     }
>     default:
>         qemu_log_mask(LOG_UNIMP, "Unimplemented ati_2d blt op %x\n",
>                       (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> +        return;
>     }
> +
> +    ati_set_dirty(s, dst_bits, dst_y, s->regs.dst_height,
> +                  (s->regs.dp_mix & GMC_ROP3_MASK));
> }

Last two parameters (dst_height and rop3) are not needed because they can 
be get from s. This is changed later but also removed there so maybe don't 
add it here in the first place just use values from state as copied from 
the original lines.

Regards,
BALATON Zoltan

