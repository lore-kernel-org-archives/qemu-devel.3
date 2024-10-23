Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E7BCDDE5D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Yk4-0002ff-QZ; Wed, 23 Oct 2024 06:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t3Yk3-0002fW-T7
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:37:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t3Yk1-0003Cn-N4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:37:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1BF874E600F;
 Wed, 23 Oct 2024 12:37:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id zBgYgQU6oW7p; Wed, 23 Oct 2024 12:37:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0FFF04E6004; Wed, 23 Oct 2024 12:37:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E299746F60;
 Wed, 23 Oct 2024 12:37:17 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:37:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: huth@tuxfamily.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 26/36] next-cube: don't use rtc phase value of -1
In-Reply-To: <20241023085852.1061031-27-mark.cave-ayland@ilande.co.uk>
Message-ID: <c604eddc-f8d8-88b1-8130-291433e3ac94@eik.bme.hu>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-27-mark.cave-ayland@ilande.co.uk>
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

On Wed, 23 Oct 2024, Mark Cave-Ayland wrote:
> The rtc phase value of -1 is directly equivalent to using a phase value of 0 so
> simplify the logic to use an initial rtc phase of 0.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> hw/m68k/next-cube.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 43b2c775c0..e4d0083eb0 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -265,9 +265,6 @@ static void next_scr2_rtc_update(NeXTPC *s)
>
>     if (scr2_2 & 0x1) {
>         /* DPRINTF("RTC %x phase %i\n", scr2_2, rtc->phase); */
> -        if (rtc->phase == -1) {
> -            rtc->phase = 0;
> -        }
>         /* If we are in going down clock... do something */
>         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
>                 ((scr2_2 & SCR2_RTCLK) == 0)) {
> @@ -282,7 +279,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
>         }
>     } else {
>         /* else end or abort */
> -        rtc->phase = -1;
> +        rtc->phase = 0;
>         rtc->command = 0;
>         rtc->value = 0;
>     }

Additionally, maybe it would be simpler to invert the if condition and 
move this else branch up there to the beginning so you can return early 
after this reset (the deposit at the end does nothing after the else case 
as it's just storing back the unmodified value) and then you can deindent 
the big if where most of the functionality is now.

Regards,
BALATON Zoltan

