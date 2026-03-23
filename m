Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7686EC01CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4eLc-0005gP-Je; Mon, 23 Mar 2026 08:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eLZ-0005g6-GO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:25:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4eLW-000083-GD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:25:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fb439299so32798185e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774268725; x=1774873525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JbSB6GMulnagVycJfUF8W/f8ilnxplIqZE5Xzykxggs=;
 b=folYF0SeGmD6cPYa+irV41pL17xiM4h+aZ190CosBNg4l54RcHJIoiT/OTaAeZ8AIY
 2NxFIhIvFfDSkRZYi1n5hx+Un1UyLd6y56LONTLiY4yW7BmlUzVvGuAuCzFBDwPcPGU7
 cJubfWjC6b4Xko44GIkn0+BD1PLX4VRpCl9Vb6CHO+BDXuW74TJIxlYBvassA7wGPSBN
 Ow7tviMXLtIaJng8G/MomyESnU9dwIghnHRaP7/BZYM2JeWpL8SMy7bl1k1V0LZM9YFH
 uHGzXr+gfxr8g4zZo/qUltc5xkg7cw2FfU+Y4M0JrH1dx2/ZLYyvS54lq84tMaRhX12m
 8bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774268725; x=1774873525;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JbSB6GMulnagVycJfUF8W/f8ilnxplIqZE5Xzykxggs=;
 b=ECAOYvJlBf6iZ/OfzO/ncY9hpKOSMaOovhE80RJjg4ggEPHzdHChdLeX7nXYb6L+WD
 RTnv9zjokkYwl516+0J5q8yDPsyI1FXsbdOM20oFXEq4KzPHLeLpawW6bg32/pYyAaVK
 Gpr34V+OLPwKv0fBflavpCTMYuUGTnMOyfi7NrfJYknKbx1JFQj7V/xkCvwv5EZOWwDY
 P/gvippbplH+fCfNZn0iyH0SjHRSt33SNNVcqO8UTBNM3mGkxkIiLWTcznM8/iYhC13l
 ySVJK0aKMyd+krGqmif3cDnB1PKhanacVERkztRc0Ul6BMFCUns+VpkHW63KdVYCL37d
 NJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxfoHEJlwO3wMusxM/yJv/bMOr8g3MuDGo8E8wF5RETmMNuw1zy3AR7U8qTcoZkTHNiOesC0Et/Miu@nongnu.org
X-Gm-Message-State: AOJu0YwcnDFMzzYabBF0B3ywWidgE+AMCmbkyiOhIU1FryHGE/EBnjug
 xCPjK1QiAVcE8ySzhVPVb99J/XtCYVMU18N2ARdqHhQWS9tpZabCF5lGX5NIsggeGI8=
X-Gm-Gg: ATEYQzzHwuXHcaI8hkG6K85o4wViOv5ycbRKawIXPhqVwK7+EW366jjwS8GhbKKJC1O
 MBxyDFaAiptOkJ50BpQE9z5BkOS5MWHPZZJ7zDkFLBnY739Q++POBoeY4G0t7HQ+t/hOwneekin
 bE6cjqj7fsyGEvPNYymYxq6WO5KuvjZAoj+fW05nSFefaq5NPRfojf7V9+6XXlYpE84Mtm+mH8A
 UL3ScNLxJF+gW2sfMgjtQubeua3woTFgpU//3Ar/JMIB1JiZ6hASURhfobQxZnusgSspt1ocSuL
 eSV0RAe8zvAoB0hHzezTWWoUv04RQ4+znZnsk+CA2UIMuAaun5l8dY4Ol/xlA0ERNmr+0a4Xlt1
 gunn/qXqAiEGXlMQYLaAQxrpfb1Rgmz368SFAsUqb6Q3VQrBR9sbsTBQp22Se+zWydMhaHO1dmo
 NDxhx7gDmL7SXqCWH1txzM5TpppX4G9ZhhNLxCYl99eL5Q6l2evrq2ZxKRITjnywsfsQ==
X-Received: by 2002:a05:600c:4214:b0:487:76c:5c97 with SMTP id
 5b1f17b1804b1-487076c5d9fmr36080945e9.32.1774268724800; 
 Mon, 23 Mar 2026 05:25:24 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm534477625e9.7.2026.03.23.05.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 05:25:24 -0700 (PDT)
Message-ID: <b2895a1f-237e-4f9d-92dc-efa2ea747913@linaro.org>
Date: Mon, 23 Mar 2026 13:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, marcandre.lureau@redhat.com,
 Chad Jablonski <chad@jablonski.xyz>
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
 <7bb33f6d-8ff8-48d0-bc96-cea8cbd165ae@linaro.org>
In-Reply-To: <7bb33f6d-8ff8-48d0-bc96-cea8cbd165ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 23/3/26 13:21, Philippe Mathieu-Daudé wrote:
> On 21/3/26 17:30, BALATON Zoltan wrote:
>> Rewrite reading of mouse pointer image. I am not sure this is entirely
>> correct but appears to work at least on little endian host with PPC
>> guests using little or big endian frame buffer (MorphOS and MacOS) but
>> still produces broken pointer image with Linux where I am not sure if
>> it is a guest driver bug or still missing something.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/display/ati.c | 53 ++++++++++++++++++++++--------------------------
>>   1 file changed, 24 insertions(+), 29 deletions(-)


>> @@ -197,9 +194,9 @@ static void ati_cursor_invalidate(VGACommonState 
>> *vga)
>>   static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, 
>> int scr_y)
>>   {
>>       ATIVGAState *s = container_of(vga, ATIVGAState, vga);
>> -    uint32_t srcoff;
>> +    uint32_t h, srcoff, color;
>> +    uint64_t abits, xbits, mask;
>>       uint32_t *dp = (uint32_t *)d;
>> -    int i, j, h, idx = 0;
>>       if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
>>           scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
>> @@ -210,26 +207,24 @@ static void ati_cursor_draw_line(VGACommonState 
>> *vga, uint8_t *d, int scr_y)
>>       srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
>>       dp = &dp[vga->hw_cursor_x];
>>       h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
>> -    for (i = 0; i < 8; i++) {
>> -        uint32_t color;
>> -        uint8_t abits = vga_read_byte(vga, srcoff + i);
>> -        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
>> -        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
>> -            if (vga->hw_cursor_x + idx >= h) {
>> -                return; /* end of screen, don't span to next line */
>> -            }
>> -            if (abits & BIT(7)) {
>> -                if (xbits & BIT(7)) {
>> -                    color = dp[idx] ^ 0xffffffff; /* complement */
>> -                } else {
>> -                    continue; /* transparent, no change */
>> -                }
>> +    abits = ldq_be_p(&vga->vram_ptr[srcoff]);
>> +    xbits = ldq_be_p(&vga->vram_ptr[srcoff + 8]);
>> +    mask = BIT(63);
> 
> This triggers:
> 
> In file included from include/qemu/timer.h:4,
>                   from ../hw/display/ati_int.h:12,
>                   from ../hw/display/ati.c:20:
> ../hw/display/ati.c: In function 'ati_cursor_draw_line':
> include/qemu/bitops.h:24:38: error: left shift count >= width of type [- 
> Werror=shift-count-overflow]
>     24 | #define BIT(nr)                 (1UL << (nr))
>        |                                      ^~
> ../hw/display/ati.c:217:12: note: in expansion of macro 'BIT'
>    217 |     mask = BIT(63);
>        |            ^~~

BTW you can check that yourself by running our CI jobs on GitLab
(https://www.qemu.org/docs/master/devel/testing/ci.html).

This is the output of the 'cross-win64-system' job:
https://gitlab.com/philmd/qemu/-/jobs/13605781786

