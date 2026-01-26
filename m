Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A43D19503
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQ95-0004bM-UC; Mon, 26 Jan 2026 12:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkQ8p-0004Y7-Vg; Mon, 26 Jan 2026 12:12:44 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vkQ8n-00020X-Fm; Mon, 26 Jan 2026 12:12:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 37F195969F3;
 Mon, 26 Jan 2026 18:12:38 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id aE8DFleSEu1w; Mon, 26 Jan 2026 18:12:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 263DE5969F2; Mon, 26 Jan 2026 18:12:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 24B185969F0;
 Mon, 26 Jan 2026 18:12:36 +0100 (CET)
Date: Mon, 26 Jan 2026 18:12:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
In-Reply-To: <DFYMJNMCJGVU.1VNVU1PXZZWQR@jablonski.xyz>
Message-ID: <0b2a14f1-d274-21b4-d5c5-4671ace85b2d@eik.bme.hu>
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-7-chad@jablonski.xyz>
 <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
 <DFYMJNMCJGVU.1VNVU1PXZZWQR@jablonski.xyz>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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
>>> -static int ati_bpp_from_datatype(ATIVGAState *s)
>>> +typedef struct {
>>> +    QemuRect rect;
>>> +    int bpp;
>>> +    int stride;
>>> +    bool top_to_bottom;
>>> +    bool left_to_right;
>>> +    uint8_t *bits;
>>> +} ATIBltDst;
>>
>> I'll need to look at this and further patches in more detail but I wonder
>> if we need separate types for BltDst and BltSrc or could we use a single
>> type for both maybe not using some fields for Src. But if that would not
>> simplify things then these can be separate too.
>>
>
> I do think that we would end up with unused fields in some cases. To me
> this mapped well conceptually to the ROP3 operations. For example the
> fill operations won't use src at all. It's possible we would even end up
> with ATIBltBrush or similar in the future. But definitely open to
> changing it if you feel strongly after looking at it in more detail!

I don't feel strongly about it but I though it might be simpler to reuse 
the same type instead of adding a new struct for everything. I wonder if 
something like

typedef {
     QemuRect rect;
     int bpp;
     int stride;
     uint8_t *bits;
} ATIBltRect;

ati_2d_do_blt(ATIBltRect src, ATIBltRect dst, bool top_to_bottom, bool left_to_right)

or similar could work (even if you don't use src.rect.width/height) and be 
simpler or if you still have ATIVGAState as parameter to ati_2d_do_blt 
then you don't even need to pass the bools as those could be get from the 
device state which should not change during host data blits (or if they do 
real hardware may also change what it does).

Or maybe ati_2d_do_blt really only needs a copy of the relevant registers 
(e.g. from dst_offset to dp_write_mask copied to an ATI2DCtx or similar 
struct) and work from that instead of ATIVGAState directly so the host 
data route can pass it's own copy with modified register contents and can 
update these without affecting the registers.

But if this does not make sense to you and you think having separate 
structs are clearer I'm OK with that too, these could be modified later as 
well. I think I'll wait for the next version before going into the details 
of the end of the series as I don't expect to need any more major rewrite 
so it will probably already be close to be good enough and only need maybe 
one more revision but this next version may change some these patches so 
the next version may look a bit different from the current version.

>>> +    ATIBltDst _dst; /* TEMP: avoid churn in future patches */
>>> +    ATIBltDst *dst = &_dst;
>>
>> These will be removed but names beginning with _ are reserved and should
>> not be used so maybe this (and _src in next patch) should be dst_ or
>> something else? Can the churn be avoided by reorganising changes or moving
>> converting to pointer in a separate patch? This patch is quite long and
>> mixes pointer conversion with other refactoring so separating those may
>> help in review.
>
> Ah, yep, renaming the _dst and _src makes sense! As far as the churn, as I
> look at this again I think it's primarily because there's an inconsistency
> in how the register values are accessed and this is attempting to unify that.
> The local variables become struct members (e.g. bpp becomes dst->bpp) and so
> do the direct register references (e.g. s->regs.dst_pitch becomes dst->stride).
> Whether dst is a pointer or a local struct doesn't change that.
>
> I was thinking we could initialize the dst struct and then assign the locals to
> those values to avoid churn (e.g. unsigned dst_x = dst->rect.x) and anything
> using those locals wouldn't need to be updated. But then the problem still
> remains with the direct register references.
>
> Another thought is that we could first create local variables for each of these,
> even those that are currently direct register references, and do the replacement
> in the function. Then in a separate patch assign the locals to the struct
> members. The locals could then either stick around indefinitely or be replaced
> themselves with direct references to the struct in another patch.
>
> Do you have any preference, or maybe even other ideas about which might be
> clearer?

The only point is that try not to mix other changes with reorganisation. 
It's OK to change the function to use different parameters or locals even 
if that changes a lot of it but try do that in separate patch that only 
does that and nothing else so it's easy to see no other change was made. 
It may even help to split that reorganisation into more patches for each 
new parameter and convert them in separate patch (like you had separate 
patch for Src already). Generally patches should be doing one thing only 
or only contain very simple additional changes such as changing a comment 
or fixing up some style but something that changes multiple lines 
throughout a function should be in its own patch if possible separate from 
other changes as much as possible.

Regards,
BALATON Zoltan

