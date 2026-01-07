Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96C5CF6BE2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 04:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdKxW-000809-2X; Tue, 06 Jan 2026 23:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdKxL-0007t7-Ts; Tue, 06 Jan 2026 23:15:35 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vdKxJ-0006Ed-Le; Tue, 06 Jan 2026 23:15:35 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 39DA95969FD;
 Wed, 07 Jan 2026 05:15:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ylxzH9K2T50N; Wed,  7 Jan 2026 05:15:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 36523596A0A; Wed, 07 Jan 2026 05:15:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34AFA5969F6;
 Wed, 07 Jan 2026 05:15:27 +0100 (CET)
Date: Wed, 7 Jan 2026 05:15:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v4 9/9] ati-vga: Implement HOST_DATA flush to VRAM
In-Reply-To: <DFHZZ37UW2LJ.6K5XDSBLC354@jablonski.xyz>
Message-ID: <45b2b112-ce4d-2cfa-1e48-1b30b4a09589@eik.bme.hu>
References: <20260106185700.2102742-1-chad@jablonski.xyz>
 <20260106185700.2102742-10-chad@jablonski.xyz>
 <246c8b76-7a62-7dc0-1f5e-52402e2ef53d@eik.bme.hu>
 <DFHZZ37UW2LJ.6K5XDSBLC354@jablonski.xyz>
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

On Tue, 6 Jan 2026, Chad Jablonski wrote:
>> I wonder if we could reuse the existing blt function here and keep pixman
>> optimisations and avoid duplicating code by filling a src buffer with the
>> expanded data after we accumulated the 128 bits and we need to flush and
>> then call ati_2d_blt with that as src and dst modified to match where it
>> should go instead of the full blit area that the registers describe. That
>> needs to split ati_2d_blt or it should take a blit state instead of
>> ATIVGAState that can either be filled from regs for a regular blit or for
>> a smaller part for a host data blit so that way host data is just split
>> into smaller 128 bit blits which I think is how the actual GPU works as
>> well. Does that make sense? Do you think that could work?
>>
>
> I considered this. I initially rolled this back into the standard ati_2d_blt
> function but when I discovered the accumulator behavior it changed things a
> bit. The thing that seemed off to me was that you can end up with "jagged"
> blits from the accumulator. Meaning if you have a host_data blit with a width
> of 100px and you flush the accumulator you don't end up with a rectangular
> region to blit with pixman. You have a 100px line and then a 28px line that
> you need to initiate two separate blits via pixman for. My gut told me that
> the overhead of breaking things up and potentially making multiple calls to
> pixman per flush would make it not worth it. But I admit I never tested it!

We have fallbacks in the ati_2d_blt function so if pixman does not help 
it's easy to call the function with parameters that make it use the fall 
back. I just think it would be better to have the part that writes to the 
frame buffer at one place so the checks for writing outside the valid 
memory and doing all the pixel combining is not duplicated. So even if we 
don't use pixman it may be better to do the actual blit with the same 
function that does normal blits. I did not consider combining flushes just 
calling the same function for each line when flushing and if pixman proves 
to be an overhead we can use the fallback instead.

> Another thing that isn't a problem in this patch but will complicate things
> in the future is transparency (bg pixel leave alone). I get the impression

Isn't that some ROP which we need to implement for blits using 
transparency anyway? I think the host data gets either straight pixels 
that we need to copy or some bitmask that need to be extended either with 
fg bg or fg over existing image. The latter could be implemented by not 
starting with empty row buffer but getting the row from the frame buffer 
then masking and ORing or whatever combining is needed. But if we have a 
ROP for that even for normal blits we'll need that anyway in the blit 
function.

> there may be some way to handle this with pixman using masks to avoid breaking
> blits up even more but I haven't fully investigated that. Actually as I type
> this I wonder if that same sort of masking could be used to avoid multiple
> calls in the current implementation.

This could be investigated later as possible optimisation but maybe not 
needed at first.

> I may be totally off on how we could do this with pixman though too. I'm new to
> it so I may not be aware of everything it can do.

Pixman has no documentation so the only info is looking at the source. But 
maybe we don't need to change anything if the host data flush prepares the 
source buffer by either using the data for datatype 3, adding bg/fg for 
mono extract and either copying the dest row first into the buffer then do 
the fg with transparency from host data bits then finally in all 3 cases 
just call ati_2d_blt with the prepared source buffer. That way no changes 
to ati_2d_blt is needed other than allowing it to take a state with the 
source and dest data rather than getting it from registers. The part that 
gets data from regs can be split out then what's left is what we need for 
host data. I haven't thought through it in detail but I think it could 
work and avoid duplicating the part that writes pixels to frame buffer.

Regards,
BALATON Zoltan

