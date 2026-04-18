Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0DF99C63
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDt9i-0007uc-K2; Fri, 17 Apr 2026 20:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wDt9f-0007u9-8B
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:03:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wDt9c-0005LG-H7
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 20:03:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F2F159695A;
 Sat, 18 Apr 2026 02:03:17 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id lRqY68p_bdac; Sat, 18 Apr 2026 02:03:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A163D596958; Sat, 18 Apr 2026 02:03:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F699596954;
 Sat, 18 Apr 2026 02:03:14 +0200 (CEST)
Date: Sat, 18 Apr 2026 02:03:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <20260417205752.3932801-1-chad@jablonski.xyz>
Message-ID: <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
References: <20260417205752.3932801-1-chad@jablonski.xyz>
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

On Fri, 17 Apr 2026, Chad Jablonski wrote:
> When using a virtual desktop any amount of scrolling would cause
> ati_set_dirty to set the wrong region of memory as dirty and screen
> updates are missed. This is because the previous implementation

I guess this is to fix chars not appearing in xterm when a virtual desktop 
is panned that you noticed here?
https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00785.html

> used vga->vbe_start_addr in the dirty address calculation. It
> works when it's zero but as soon as the virtual desktop is involved
> it's often non-zero.
>
> The first issue is that vga->vbe_start_addr is a word offset and was
> being added to byte offsets. But regardless, the vbe_start_address affects
> the scan out and not the framebuffer. We shouldn't need to apply an
> offset for it at all when thinking about dirty tracking.

Obviously I don't quite understood how dirty tracking should work.

> The second is that a bounds check was also being performed to ensure
> that the dirty memory was within the visible screen. With the virtual
> desktop this isn't actually what we want. Updates can and will happen
> outside of the visible screen area. Those should be marked dirty.

But I still think only the visible area should need marking dirty because it 
is used to update display so marking non visible parts should have no 
effect. I'm not sure if it has any performance impact but just seems 
unnecessary so that's why this tried to limit it to visible area. I've 
added to cc some people who could maybe enlighten us on this.

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 16 +++++-----------
> 1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 504d1c5708..dc33b014eb 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -71,17 +71,11 @@ static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
>     DisplaySurface *ds = qemu_console_surface(vga->con);
>
>     (void)ds;
> -    DPRINTF("%p %u ds: %p %d %d rop: %x\n", vga->vram_ptr, vga->vbe_start_addr,
> -            surface_data(ds), surface_stride(ds), surface_bits_per_pixel(ds),
> -            ctx->rop3 >> 16);
> -    if (ctx->dst_bits >= vga->vram_ptr + vga->vbe_start_addr &&
> -        ctx->dst_bits < vga->vram_ptr + vga->vbe_start_addr +
> -        vga->vbe_regs[VBE_DISPI_INDEX_YRES] * vga->vbe_line_offset) {
> -        memory_region_set_dirty(&vga->vram,
> -                                vga->vbe_start_addr + ctx->dst_offset +
> -                                ctx->dst.y * ctx->dst_stride,
> -                                ctx->dst.height * ctx->dst_stride);
> -    }
> +    DPRINTF("%p ds: %p %d %d rop: %x\n", vga->vram_ptr, surface_data(ds),
> +            surface_stride(ds), surface_bits_per_pixel(ds), ctx->rop3 >> 16);
> +    memory_region_set_dirty(&vga->vram,
> +                            ctx->dst_offset + ctx->dst.y * ctx->dst_stride,
> +                            ctx->dst.height * ctx->dst_stride);
> }

If this is how it should be done and limiting dirty tracking to visible 
part does not save any work I wonder if we still need this funcion and 
couldn't just use memory_region_set_dirty directly? I'd like to avoid 
slowing updates down with unnecessarily marking off screen areas but I'm 
not sure that concern is valid.

Regards,
BALATON Zoltan

