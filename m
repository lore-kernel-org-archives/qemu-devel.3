Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B30CED7B94
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCa6B-0004ca-Me; Tue, 14 Apr 2026 05:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCa66-0004aY-DP; Tue, 14 Apr 2026 05:30:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wCa5r-00058t-1g; Tue, 14 Apr 2026 05:30:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EDFC596A3F;
 Tue, 14 Apr 2026 11:29:56 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id CPoE8eDoo1Po; Tue, 14 Apr 2026 11:29:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 676B0596A2E; Tue, 14 Apr 2026 11:29:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65997596A23;
 Tue, 14 Apr 2026 11:29:54 +0200 (CEST)
Date: Tue, 14 Apr 2026 11:29:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Junjie Cao <junjie.cao@intel.com>
cc: qemu-devel@nongnu.org, Chad Jablonski <chad@jablonski.xyz>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-stable@nongnu.org
Subject: Re: [PATCH] ati-vga: fix unsigned integer overflow in cursor bounds
 checks
In-Reply-To: <20260414141458.1076014-1-junjie.cao@intel.com>
Message-ID: <da61bc75-3c2e-a5d1-1448-2386b12c84a6@eik.bme.hu>
References: <20260414141458.1076014-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 14 Apr 2026, Junjie Cao wrote:
> The cursor bounds checks compare (srcoff + N) against vram_size, but
> both sides are uint32_t so the addition can wrap past UINT32_MAX when
> srcoff underflows from the cur_hv_offs subtraction, causing the check
> to be bypassed.
>
> Rewrite the checks as (srcoff > vram_size - N) to avoid the
> overflow-prone addition, matching the style already used in
> ati_mm_read() and ati_mm_write().
>
> Fixes: 2f1fbe6ee9b5 ("ati-vga: Make sure hardware cursor data is within vram")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
> Found while running local QEMU fuzz testing.
>
> hw/display/ati.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 88a5bbbf07..0489995d00 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -149,7 +149,7 @@ static void ati_cursor_define(ATIVGAState *s)
>     /* FIXME handle cur_hv_offs correctly */
>     srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
>              (s->regs.cur_hv_offs & 0xffff) * 16;
> -    if (srcoff + 64 * 16 > s->vga.vram_size) {
> +    if (srcoff > s->vga.vram_size - 64 * 16) {
>         return;
>     }
>     for (int i = 0; i < 64; i++, srcoff += 16) {
> @@ -206,7 +206,7 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>     }
>     /* FIXME handle cur_hv_offs correctly */
>     srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
> -    if (srcoff + 16 > s->vga.vram_size) {
> +    if (srcoff > s->vga.vram_size - 16) {
>         return;
>     }
>     dp = &dp[vga->hw_cursor_x];

Considering that actual cursor offset is in bits 0-26 this should not 
happen but bit 31 is the lock bit that erroneously counted into offset 
here. So additionally we should also mask that out using 
(s->regs.cur_offset & 0x07fffff0) in calculation of scroff. There's one 
more similar usage in ati_cursor_invalidate. Otherwise,

Reviewed-by; BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

