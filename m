Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18EAEC01DF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4eHb-0004UV-Iw; Mon, 23 Mar 2026 08:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eHZ-0004Ty-Ai
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:21:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eHV-0007ht-Uc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:21:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso24746985e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774268474; x=1774873274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4J4xJHh5+DbGOYkLNBJxyBaYba9M9wZbX58rjni5K6Y=;
 b=ysk2j3/07iqhtjyupIZvg6vVSJlmPYi/fwuJ+T8WePrpCIFkLWmamHBpLeIGD7VMjX
 ZaSIIoUpm0RBge9FTnw0mBk2ehXdOI1I5mDKvg9Ic5oHsIwe3q5TnF6cnWKGBhGp98+a
 DfmU2tRL7nGK5n+lqTa/OyfhD41ae77aZOX0IMBNRx6ywSkXzYSMK9zU7o+bTEkcLWfC
 JHR/TamF0Vjb+LfzdYFXRnhYkMBG6eLDiknQxm52pV7gPyKjJ0I3qZmXRzzCEqNb6z0x
 VcyTJBxKiFp50H6y+/O/kK6Krb32qEqYTnsBrgFJn0oueusphARqKXpRprGukz3kf9rV
 q+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774268474; x=1774873274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4J4xJHh5+DbGOYkLNBJxyBaYba9M9wZbX58rjni5K6Y=;
 b=ZiIpSEtHsd5igxMz+t7TXsMY0bj6pl0Q5XnHsiGxRBw4KSYanLJ1fbly98blCfDy/S
 0FeniNSqfndZBkEN8JKdvfa0rTvRW1wJDZDugPifSIKLe0t99ilxpBQH4lo4DO2JQKO1
 rplTGUU1O3fAtRKiqKAVFQCcVoF58F0LG1JgfHoSBwrEiioQ/C210RewWRMBIJLgo3I5
 UZ9PFUpFeBcDEeIyq5lT/Fx/jt3KENb8o2/iRDzGHxfoaHj9gfxVjF3BC/1m+VVK5o0m
 n66O/QM0th/Os6/iPGkIy2YmlOzV2gwjaGq/l1BYM7PNp3n1eKdUw36Yznr7fQF/NHAz
 4oLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKEdoJ75YcVOxYkQMzbbHu46+MRq/nWW2aD8f+6IKVb5w/tNTolzi0ai3wavwDbShr8hg/ejnLmrCq@nongnu.org
X-Gm-Message-State: AOJu0Yzq3j+WGypPnLPNKHRUpuwof13Fdi5cTPmLD4p8vPTTJVNk7eEy
 r8OLtXnURnu2LfMdnA4HDTidSNXuXNPOpcVbDtlohAND8ga1Fc7qim/myQx4T2pbWkI=
X-Gm-Gg: ATEYQzy4zYx5VfR9bq7l88X7JuqrwDY4FmkP2L5YWKjvDd5bJWRbN5s/Z6OG+rf15Ql
 WiyuxzuCS/2K832AOlVr2F8W9ju7VX+UWes5ZFE4Ydsf+wZpaFzlkJgEvj+LvDZ4UzKKWcSBGTc
 Wrqlq/VXDpJOerxLcYL8Vvg0p7gEg1OgtdDU300JDtQypM+6CCdlTIGKHm6c8JbF/0hYsnGUDwY
 aCpATI8CDuK98a2nGmbKxyLriD4A+X/yZJ6XEa+uz6+JP3LB8DUlJzh+Fr0cZW9DsYghZCvwL6S
 Yda2frJ0otqTuMeBcwLBnM2Yd5ARalOFId42MJDORZoDPOgnJizUMD71TDYQBP9lL4c/Q1LHheY
 7yn/cayDN9SwkPXf6CbXzv6nKNCVWkCZdpAfEu3zQTvvdC2B0TZssgbOwp+P2nNVMTZzbeGVxPS
 dTTy0PdX9oUZDzDTIkRMroxLs2d6RxsyYq1gCphI/cFwHKalTt3DU6htGTxpsPqwmKIg==
X-Received: by 2002:a05:600c:4714:b0:485:3bc7:a231 with SMTP id
 5b1f17b1804b1-486ff01f1d0mr173010195e9.29.1774268474367; 
 Mon, 23 Mar 2026 05:21:14 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe82ae69sm258790775e9.9.2026.03.23.05.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:21:13 -0700 (PDT)
Message-ID: <7bb33f6d-8ff8-48d0-bc96-cea8cbd165ae@linaro.org>
Date: Mon, 23 Mar 2026 13:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 21/3/26 17:30, BALATON Zoltan wrote:
> Rewrite reading of mouse pointer image. I am not sure this is entirely
> correct but appears to work at least on little endian host with PPC
> guests using little or big endian frame buffer (MorphOS and MacOS) but
> still produces broken pointer image with Linux where I am not sure if
> it is a guest driver bug or still missing something.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/ati.c | 53 ++++++++++++++++++++++--------------------------
>   1 file changed, 24 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index fba73a9956..e1616dc3b3 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -142,27 +142,24 @@ static void ati_vga_switch_mode(ATIVGAState *s)
>   /* Used by host side hardware cursor */
>   static void ati_cursor_define(ATIVGAState *s)
>   {
> -    uint8_t data[1024];
> +    uint64_t data[128];
>       uint32_t srcoff;
> -    int i, j, idx = 0;
>   
>       if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
>           return; /* Do not update cursor if locked or rendered by guest */
>       }
>       /* FIXME handle cur_hv_offs correctly */
> -    srcoff = s->regs.cur_offset -
> -        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
> -    for (i = 0; i < 64; i++) {
> -        for (j = 0; j < 8; j++, idx++) {
> -            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
> -            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
> -        }
> +    srcoff = s->regs.cur_offset - (s->regs.cur_hv_offs >> 16) -
> +             (s->regs.cur_hv_offs & 0xffff) * 16;
> +    for (int i = 0; i < 64; i++, srcoff += 16) {
> +        data[i] = ldq_le_p(&s->vga.vram_ptr[srcoff]);
> +        data[i + 64] = ldq_le_p(&s->vga.vram_ptr[srcoff + 8]);
>       }
>       if (!s->cursor) {
>           s->cursor = cursor_alloc(64, 64);
>       }
>       cursor_set_mono(s->cursor, s->regs.cur_color1, s->regs.cur_color0,
> -                    &data[512], 1, &data[0]);
> +                    (uint8_t *)&data[64], 1, (uint8_t *)&data[0]);
>       dpy_cursor_define(s->vga.con, s->cursor);
>   }
>   
> @@ -197,9 +194,9 @@ static void ati_cursor_invalidate(VGACommonState *vga)
>   static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>   {
>       ATIVGAState *s = container_of(vga, ATIVGAState, vga);
> -    uint32_t srcoff;
> +    uint32_t h, srcoff, color;
> +    uint64_t abits, xbits, mask;
>       uint32_t *dp = (uint32_t *)d;
> -    int i, j, h, idx = 0;
>   
>       if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
>           scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
> @@ -210,26 +207,24 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>       srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
>       dp = &dp[vga->hw_cursor_x];
>       h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
> -    for (i = 0; i < 8; i++) {
> -        uint32_t color;
> -        uint8_t abits = vga_read_byte(vga, srcoff + i);
> -        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
> -        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
> -            if (vga->hw_cursor_x + idx >= h) {
> -                return; /* end of screen, don't span to next line */
> -            }
> -            if (abits & BIT(7)) {
> -                if (xbits & BIT(7)) {
> -                    color = dp[idx] ^ 0xffffffff; /* complement */
> -                } else {
> -                    continue; /* transparent, no change */
> -                }
> +    abits = ldq_be_p(&vga->vram_ptr[srcoff]);
> +    xbits = ldq_be_p(&vga->vram_ptr[srcoff + 8]);
> +    mask = BIT(63);

This triggers:

In file included from include/qemu/timer.h:4,
                  from ../hw/display/ati_int.h:12,
                  from ../hw/display/ati.c:20:
../hw/display/ati.c: In function 'ati_cursor_draw_line':
include/qemu/bitops.h:24:38: error: left shift count >= width of type 
[-Werror=shift-count-overflow]
    24 | #define BIT(nr)                 (1UL << (nr))
       |                                      ^~
../hw/display/ati.c:217:12: note: in expansion of macro 'BIT'
   217 |     mask = BIT(63);
       |            ^~~

I suppose we want BIT_ULL() here, I'll test again.

> +    for (int i = 0; i < 64; i++, mask >>= 1) {
> +        if (vga->hw_cursor_x + i >= h) {
> +            return; /* end of screen, don't span to next line */
> +        }
> +        if (abits & mask) {
> +            if (xbits & mask) {
> +                color = dp[i] ^ 0xffffffff; /* complement */
>               } else {
> -                color = (xbits & BIT(7) ? s->regs.cur_color1 :
> -                                          s->regs.cur_color0) | 0xff000000;
> +                continue; /* transparent, no change */
>               }
> -            dp[idx] = color;
> +        } else {
> +            color = (xbits & mask ? s->regs.cur_color1 :
> +                                    s->regs.cur_color0) | 0xff000000;
>           }
> +        dp[i] = color;
>       }
>   }
>   


