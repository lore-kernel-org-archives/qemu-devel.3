Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D2F9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg2r-0003Il-La; Tue, 14 Apr 2026 11:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCg2p-0003I0-S0; Tue, 14 Apr 2026 11:51:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCg2n-0007yj-Jl; Tue, 14 Apr 2026 11:51:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E5358596A3F;
 Tue, 14 Apr 2026 17:51:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id mou-zhZIPe6U; Tue, 14 Apr 2026 17:51:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CAFF4596A23; Tue, 14 Apr 2026 17:51:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8E8D5969EC;
 Tue, 14 Apr 2026 17:51:12 +0200 (CEST)
Date: Tue, 14 Apr 2026 17:51:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Junjie Cao <junjie.cao@intel.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Chad Jablonski <chad@jablonski.xyz>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 2/2] ati-vga: mask out lock bit from CUR_OFFSET in
 cursor offset calculation
In-Reply-To: <20260414213523.1125859-2-junjie.cao@intel.com>
Message-ID: <e864238f-3e8a-7131-40d4-56a01c7e3cb5@eik.bme.hu>
References: <20260414213523.1125859-1-junjie.cao@intel.com>
 <20260414213523.1125859-2-junjie.cao@intel.com>
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

On Wed, 15 Apr 2026, Junjie Cao wrote:
> Bit 31 of CUR_OFFSET is the cursor lock bit, not part of the actual
> cursor address (bits 26:4).  Although the callers already check for the
> lock bit and return early, mask it out with 0x07fffff0 when computing
> the cursor source offset so the calculation only uses the address bits.
>
> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> ---
> hw/display/ati.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 0489995d00..3a7d45a882 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -147,7 +147,7 @@ static void ati_cursor_define(ATIVGAState *s)
>         return; /* Do not update cursor if locked or rendered by guest */
>     }
>     /* FIXME handle cur_hv_offs correctly */
> -    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
> +    srcoff = (s->regs.cur_offset & 0x07fffff0) - (s->regs.cur_hv_offs >> 16) -
>              (s->regs.cur_hv_offs & 0xffff) * 16;
>     if (srcoff > s->vga.vram_size - 64 * 16) {
>         return;
> @@ -176,13 +176,15 @@ static void ati_cursor_invalidate(VGACommonState *vga)
>     if (s->cursor_size != size ||
>         vga->hw_cursor_x != s->regs.cur_hv_pos >> 16 ||
>         vga->hw_cursor_y != (s->regs.cur_hv_pos & 0xffff) ||
> -        s->cursor_offset != s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
> +        s->cursor_offset != (s->regs.cur_offset & 0x07fffff0) -
> +        (s->regs.cur_hv_offs >> 16) -
>         (s->regs.cur_hv_offs & 0xffff) * 16) {
>         /* Remove old cursor then update and show new one if needed */
>         vga_invalidate_scanlines(vga, vga->hw_cursor_y, vga->hw_cursor_y + 63);
>         vga->hw_cursor_x = s->regs.cur_hv_pos >> 16;
>         vga->hw_cursor_y = s->regs.cur_hv_pos & 0xffff;
> -        s->cursor_offset = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
> +        s->cursor_offset = (s->regs.cur_offset & 0x07fffff0) -
> +                           (s->regs.cur_hv_offs >> 16) -
>                            (s->regs.cur_hv_offs & 0xffff) * 16;
>         s->cursor_size = size;
>         if (size) {
>

