Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84964D2F004
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhah-0007u0-3T; Tue, 27 Jan 2026 06:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkhae-0007sL-I5; Tue, 27 Jan 2026 06:50:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkhac-0004vR-7r; Tue, 27 Jan 2026 06:50:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E3EB0596A10;
 Tue, 27 Jan 2026 12:50:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Zqj9Z7RsK-of; Tue, 27 Jan 2026 12:50:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D73045969F3; Tue, 27 Jan 2026 12:50:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D1DE95969F0;
 Tue, 27 Jan 2026 12:50:29 +0100 (CET)
Date: Tue, 27 Jan 2026 12:50:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
In-Reply-To: <DFZ07VSHIHN3.DQF2CGTUHQSM@jablonski.xyz>
Message-ID: <515b3e0b-f46d-43fb-76db-53347cf22088@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-7-chad@jablonski.xyz>
 <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
 <DFYMJNMCJGVU.1VNVU1PXZZWQR@jablonski.xyz>
 <0b2a14f1-d274-21b4-d5c5-4671ace85b2d@eik.bme.hu>
 <DFZ07VSHIHN3.DQF2CGTUHQSM@jablonski.xyz>
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

On Mon, 26 Jan 2026, Chad Jablonski wrote:
>> I don't feel strongly about it but I though it might be simpler to reuse
>> the same type instead of adding a new struct for everything. I wonder if
>> something like
>>
>> typedef {
>>      QemuRect rect;
>>      int bpp;
>>      int stride;
>>      uint8_t *bits;
>> } ATIBltRect;
>>
>> ati_2d_do_blt(ATIBltRect src, ATIBltRect dst, bool top_to_bottom, bool left_to_right)
>>
>> or similar could work (even if you don't use src.rect.width/height) and be
>> simpler or if you still have ATIVGAState as parameter to ati_2d_do_blt
>> then you don't even need to pass the bools as those could be get from the
>> device state which should not change during host data blits (or if they do
>> real hardware may also change what it does).
>>
>> Or maybe ati_2d_do_blt really only needs a copy of the relevant registers
>> (e.g. from dst_offset to dp_write_mask copied to an ATI2DCtx or similar
>> struct) and work from that instead of ATIVGAState directly so the host
>> data route can pass it's own copy with modified register contents and can
>> update these without affecting the registers.
>>
>> But if this does not make sense to you and you think having separate
>> structs are clearer I'm OK with that too, these could be modified later as
>> well. I think I'll wait for the next version before going into the details
>> of the end of the series as I don't expect to need any more major rewrite
>> so it will probably already be close to be good enough and only need maybe
>> one more revision but this next version may change some these patches so
>> the next version may look a bit different from the current version.
>>
>
> I see. That makes a lot of sense. And now that you mention the potential
> ATI2DCtx solution I do like that it removes direct dependency on the registers
> inside of the blit function. I wonder if we could go a step even further and
> store the actual derived values in the struct instead of a copy of raw register
> values. Something like:
>
> typedef struct {
>  /* src */
>  uint8_t *src_bits;
>  int src_x, src_y;
>  int src_stride;
>
>  /* dst */
>  uint8_t *dst_bits;
>  QemuRect dst_rect;
>  int dst_stride;
>  int bpp;
>
>  QemuRect scissor;
>  uint32_t rop3;
>  bool left_to_right;
>  bool top_to_bottom;
>  uint32_t frgd_clr;
>  uint32_t bkgd_clr;
> } ATI2DCtx;

That would work. For consistency I'd rather either go with dst_x dst_y 
dst_w, etc. and likewise for scissor (which could be abbreviated sc) or 
also use QemuRect src even if w and h are never used just so all usage 
will be uniform and you don't have to remember why src is special.

> We would still need to pass VGACommonState in to access a few things (vram and
> the palette) and use_pixman but we wouldn't need the full device at that point.
> So the function signature would look like:
>
> static void ati_2d_do_blt(VGACommonState *vga, ATI2DCtx *ctx, bool use_pixman)

The use_pixman may need to be an int and mirror the x-pixman property and 
used like the property now so we can control different operations 
separately instead of just on or off for all.

> A blt ctx setup function could then fill this struct in the most common case (memory)
> and the host_data flush could easily modify it without needing any of the register access
> details.
>
> One downside of course is that if we discover we need to mutate registers
> during the blit we will need to rethink this a bit. But so far it isn't looking
> like that is necessary.

Maybe if any changes to regs are needed those can be done in whatever 
calls ati_2d_do_blt so hopefully this won't be a problem. But we may need 
to add more values to ctx in the future but that should be OK.

Regards,
BALATON Zoltan

