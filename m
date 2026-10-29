Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A76606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWiX-0004Zx-A0; Thu, 29 Oct 2026 16:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMWiV-0004Zd-Lm; Thu, 29 Oct 2026 16:27:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xMWiS-00056k-Q6; Thu, 29 Oct 2026 16:27:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3B52160C0DB;
 Thu, 29 Oct 2026 21:27:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Cs0-WzLLQQdo; Thu, 29 Oct 2026 21:27:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B0B6760C072; Thu, 29 Oct 2026 21:27:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AEEB313996F;
 Thu, 29 Oct 2026 21:27:10 +0100 (CET)
Date: Thu, 29 Oct 2026 21:27:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Tristan Madani <tristmd@gmail.com>
cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-stable@nongnu.org,
 pbonzini@redhat.com, kraxel@redhat.com, tristan@talencesecurity.com
Subject: Re: [PATCH v2] hw/display/ati: fix integer overflow in Rage128 2D
 blit bounds check
In-Reply-To: <20261029183452.1551287-1-tristmd@gmail.com>
Message-ID: <e156de71-e55f-af7b-4889-1e7738317884@eik.bme.hu>
References: <20261029183452.1551287-1-tristmd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1964166604-1793305630=:11364"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1964166604-1793305630=:11364
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 29 Oct 2026, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The VRAM bounds check in ati_2d_do_blt() computes
> (dst.y + dst.height) * dst_stride using signed 32-bit arithmetic.
> On Rage128, setup_2d_blt_ctx() multiplies dst_stride by bpp (up to
> 32), producing strides up to 524,256 bytes/row.  With large
> dst.y + dst.height values, the signed int multiplication overflows
> to a negative value, causing the bounds check to evaluate false
> when it should reject the operation.
>
> The subsequent blit loop uses unsigned arithmetic for the same index
> computation, producing large positive offsets that write past the
> VRAM allocation into host process memory.
>
> The same overflow affects the source bounds check in the SRCCOPY
> path, where (vis_src.y + vis_dst.height) * src_stride can also
> overflow when the guest sets large pitch values.
>
> Fix both by pre-computing the end offsets as uint64_t, which
> prevents the signed overflow while keeping the existing bounds
> check logic.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4646
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> v2:
>  - Actually use src_end for the source bounds check in the SRCCOPY path;
>    v1 declared it but never used it (Marc-André Lureau)
>  - Sent standalone; v1 was part of an 8-patch display series
> hw/display/ati_2d.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 7a4a115..cfa4947 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -157,6 +157,7 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
>     QemuRect vis_src, vis_dst;
>     unsigned int x, y, i, j, bypp = ctx->bpp / 8;
>     const uint8_t *vram_end = ctx->vga->vram_ptr + ctx->vga->vram_size;
> +    uint64_t dst_end;
>
>     if (!ctx->bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> @@ -166,9 +167,11 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
>         qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
>         return false;
>     }
> +    dst_end = (uint64_t)ctx->dst.x * bypp +
> +              (uint64_t)(ctx->dst.y + ctx->dst.height) * ctx->dst_stride;
>     if (ctx->dst.x > 0x3fff || ctx->dst.y > 0x3fff ||
> -        ctx->dst_bits >= vram_end - bypp || ctx->dst_bits + ctx->dst.x * bypp +
> -        (ctx->dst.y + ctx->dst.height) * ctx->dst_stride >= vram_end - bypp) {
> +        ctx->dst_bits >= vram_end - bypp ||
> +        ctx->dst_bits + dst_end >= vram_end - bypp) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return false;
>     }
> @@ -203,11 +206,12 @@ static bool ati_2d_do_blt(const ATI2DCtx *ctx, uint8_t use_pixman)
>             qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
>             return false;
>         }
> +        uint64_t src_end = (uint64_t)vis_src.x * bypp +

QEMU coding style says this has to be defined at the beginning of the 
function not here. Also I think it would be better to calculate the whole 
pointer as a const uint8_t * including {src,dst}_bits to match vram_end 
instead of using an uint64_t offset.

Regards,
BALATON Zoltan

> +            (uint64_t)(vis_src.y + vis_dst.height) * ctx->src_stride;
>         if (!ctx->host_data_active &&
>             (vis_src.x > 0x3fff || vis_src.y > 0x3fff ||
>             ctx->src_bits >= vram_end - bypp ||
> -            ctx->src_bits + vis_src.x * bypp + (vis_src.y + vis_dst.height) *
> -            ctx->src_stride >= vram_end - bypp)) {
> +            ctx->src_bits + src_end >= vram_end - bypp)) {
>             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>             return false;
>         }
>
--3866299591-1964166604-1793305630=:11364--

