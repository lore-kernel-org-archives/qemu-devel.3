Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691DED26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 17:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veG1m-0000Td-E1; Fri, 09 Jan 2026 12:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veG1j-0000Sr-Vs; Fri, 09 Jan 2026 12:11:56 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1veG1h-00045D-FI; Fri, 09 Jan 2026 12:11:55 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BE25E596AC0;
 Fri, 09 Jan 2026 18:11:49 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id zwdozPsjLeif; Fri,  9 Jan 2026 18:11:47 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67E58596ABD; Fri, 09 Jan 2026 18:11:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6695A5969E4;
 Fri, 09 Jan 2026 18:11:47 +0100 (CET)
Date: Fri, 9 Jan 2026 18:11:47 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [RFC PATCH] ati-vga: Refactor ati_2d_blt to accept src and dst
 parameters
In-Reply-To: <DFK51FL5XBP1.4FSMIWGTP9Z2@jablonski.xyz>
Message-ID: <d3938061-3dd8-e305-0d33-3f091b66f023@eik.bme.hu>
References: <20260109045035.2931091-1-chad@jablonski.xyz>
 <3fb14280-960b-d923-dd5d-3748450acc70@eik.bme.hu>
 <DFK51FL5XBP1.4FSMIWGTP9Z2@jablonski.xyz>
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

On Fri, 9 Jan 2026, Chad Jablonski wrote:
>> https://en.wikipedia.org/wiki/Eastern_name_order#Hungary
>> That's what capitalisation is meant to show but not many seem to know
>> about that convention. No worries though not many got it at first.
>>
>
> Ah, thanks for the explanation, I had no idea! Should I call you Zoltan?

I think that's what you meant in the first place so yes Zoltan is my 
"first" name.

>>> +    ATIBlitDst dst = {
>>> +        .valid = false,
>>> +        .bpp = ati_bpp_from_datatype(s),
>>> +        .stride = DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_pitch,
>>> +        .left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT,
>>> +        .top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM,
>>> +        .bits = s->vga.vram_ptr + (DEFAULT_CNTL ?
>>> +                s->regs.dst_offset : s->regs.default_offset),
>>> +    };
>>> +    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
>>> +    unsigned dst_x = (dst.left_to_right ?
>>> +                     s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
>>> +    unsigned dst_y = (dst.top_to_bottom ?
>>> +                     s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
>>> +    qemu_rect_init(&dst.rect, dst_x, dst_y,
>>> +                   s->regs.dst_width, s->regs.dst_height);
>>> +
>>> +    if (!dst.bpp) {
>>>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>>> -        return;
>>> +        return dst;
>>
>> Does this work? I think you can't return a pointer to a local so this
>> might need to take an ATIBlitDst * and init the struct passed to it by
>> that then it could return bool and remove the valid field from the struct
>> which seems to be confusing and may be better returned directly.
>>
>
> This is returning by value, so it should. But point taken, accepting a
> pointer and returning a bool avoids the valid field. I'll go that route.

Indeed, you are right but maybe less confusing with allocating the struct 
in caller and returning bool from the init+check function. I'll wait for a 
v2 with the changes so far or the next version of the whole series with 
that v2 to look into the rest in detail but I think this goes in the 
direction I imagined. The point is to try to keep the checks for 
overflowing the vram area and using pixmap with fallback at one place to 
avoid duplicating that part and having to check that we got it right at 
multiple places. It's hard enough to do it right once so better reuse that 
everywhere. So try to do this first with just calling this extracted 
do_blt function at every host data flush and see how that works.

If this turns out to have performance issues we can think about how to 
optimise that later. One possibility could be not flushing every 128 bits 
but coalesce one display line but that may not be needed if we just add a 
parameter to the do_blt function to control if it uses pixman and call it 
to use the fallback loop for small blits to avoid the calling overhead of 
pixman. Coalescing may be more difficult for drivers that don't write LAST 
as we don't know when to do the final flush but we may know which is the 
last line so we could revert to not calesce on the last line or something 
like that. But these get too complex so just forget about it now and go 
with the naive way first and see if we need more after that.

Regards,
BALATON Zoltan

