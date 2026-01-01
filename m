Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF221EEB57B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Jan 2026 22:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbRAR-00036n-Pa; Thu, 01 Jan 2026 17:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRAQ-00036H-MO
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:29:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vbRAP-0005Rj-5C
 for qemu-devel@nongnu.org; Thu, 01 Jan 2026 17:29:14 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 112505969FF;
 Thu, 01 Jan 2026 23:29:12 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GVULF-V6Dnw9; Thu,  1 Jan 2026 23:29:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0276E5969FA; Thu, 01 Jan 2026 23:29:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F17975969F6;
 Thu, 01 Jan 2026 23:29:09 +0100 (CET)
Date: Thu, 1 Jan 2026 23:29:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/11] ati-vga: Create 2d_blt destination setup helper
In-Reply-To: <20251118154812.57861-9-chad@jablonski.xyz>
Message-ID: <628e4746-7eb5-0788-ea91-9f0ae1b12372@eik.bme.hu>
References: <20251118154812.57861-1-chad@jablonski.xyz>
 <20251118154812.57861-9-chad@jablonski.xyz>
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
> A large amount of the common setup involved in a blit deals with the
> destination. This moves that setup to a helper function returning a
> struct (ATIBlitDest) holding all of that state. The idea here is that
> this setup will be shared between blits from memory as well as from
> HOST_DATA and maybe others in the future.
>
> The next patch refactors ati_2d_blt to use this new helper.

Maybe better to squash in next patch to make it easier to see code 
movement.

Regards,
BALATON Zoltan

> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> ---
> hw/display/ati_2d.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 54 insertions(+)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 9c96ee155f..f2e01e28e9 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -67,6 +67,60 @@ static QemuRect sc_rect(ATIVGAState *s)
>     return sc;
> }
>
> +typedef struct {
> +    QemuRect rect;
> +    QemuRect visible;
> +    uint32_t src_left_offset;
> +    uint32_t src_top_offset;
> +    int bpp;
> +    int stride;
> +    bool top_to_bottom;
> +    bool left_to_right;
> +    bool valid;
> +    uint8_t *bits;
> +} ATIBlitDest;
> +
> +static ATIBlitDest setup_2d_blt_dst(ATIVGAState *s)
> +{
> +    ATIBlitDest dst = { .valid = false };
> +    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> +    QemuRect scissor = sc_rect(s);
> +
> +    dst.rect = dst_rect(s);
> +    if (!qemu_rect_intersect(&dst.rect, &scissor, &dst.visible)) {
> +        /* Destination is completely clipped, nothing to draw */
> +        return dst;
> +    }
> +    dst.bpp = ati_bpp_from_datatype(s);
> +    if (!dst.bpp) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> +        return dst;
> +    }
> +    dst.stride = s->regs.dst_pitch;
> +    if (!dst.stride) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
> +        return dst;
> +    }
> +    dst.bits = s->vga.vram_ptr + s->regs.dst_offset;
> +    if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +        dst.bits += s->regs.crtc_offset & 0x07ffffff;
> +        dst.stride *= dst.bpp;
> +    }
> +    if (dst.visible.x > 0x3fff || dst.visible.y > 0x3fff || dst.bits >= end
> +        || dst.bits + dst.visible.x
> +         + (dst.visible.y + dst.visible.height) * dst.stride >= end) {
> +        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +        return dst;
> +    }
> +    dst.src_left_offset = dst.visible.x - dst.rect.x;
> +    dst.src_top_offset = dst.visible.y - dst.rect.y;
> +    dst.left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
> +    dst.top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> +    dst.valid = true;
> +
> +    return dst;
> +}
> +
> void ati_2d_blt(ATIVGAState *s)
> {
>     /* FIXME it is probably more complex than this and may need to be */
>

