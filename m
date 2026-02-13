Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9413EF99C5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 19:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqyXH-0005VP-O2; Fri, 13 Feb 2026 14:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqyXE-0005Uw-KA
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 14:09:01 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqyXB-000153-Hy
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 14:09:00 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 82798596A29;
 Fri, 13 Feb 2026 20:08:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hzXm7Cw8M90E; Fri, 13 Feb 2026 20:08:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6A60F596A0B; Fri, 13 Feb 2026 20:08:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 689F55969F0;
 Fri, 13 Feb 2026 20:08:50 +0100 (CET)
Date: Fri, 13 Feb 2026 20:08:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v8 16/18] ati-vga: Implement scissor rectangle clipping
 for 2D operations
In-Reply-To: <DGE0C8NL49YI.6X4RHY1DXKLB@jablonski.xyz>
Message-ID: <394adb8f-9367-6892-d7f2-ca3d9c9e7139@eik.bme.hu>
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-17-chad@jablonski.xyz>
 <00aade99-9ce2-3679-5171-8899d8fbb524@eik.bme.hu>
 <DGE0C8NL49YI.6X4RHY1DXKLB@jablonski.xyz>
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

On Fri, 13 Feb 2026, Chad Jablonski wrote:
>>> The src also needs to be offset if clipped on the top and/or
>>> left sides to ensure that src data is read correctly and appears
>>> clipped when drawn rather than shifted.
>>
>> This is true for top to bottom left to right but what happens for other
>> direction blits?
>>
>
>>> +    /*
>>> +     * The src must be offset if clipping is applied to the dst.
>>> +     * This is so that when the source is blit to a dst clipped
>>> +     * on the top or left the src image is not shifted into the
>>> +     * clipped region but actually clipped.
>>> +     */
>>> +    vis_src.x = ctx->src.x + (vis_dst.x - ctx->dst.x);
>>> +    vis_src.y = ctx->src.y + (vis_dst.y - ctx->dst.y);
>>> +    vis_src.width = vis_dst.width;
>>> +    vis_src.height = vis_dst.height;
>>
>> These may also need to be calculated differently.
>>
>
> ctx->dst.x and ctx->dst.y are normalized to the top left corner of the
> blit in setup_2d_blt_ctx (lines 102-105). So this is able to
> do the calculations uniformly for all blit direction combinations.
>
>>> +    ctx->scissor.width = s->regs.sc_right - s->regs.sc_left + 1;
>>> +    ctx->scissor.height = s->regs.sc_bottom - s->regs.sc_top + 1;
>>> +    ctx->scissor.x = s->regs.sc_left;
>>> +    ctx->scissor.y = s->regs.sc_top;
>>
>> Does this need to be computed as src and dst coordinates when not top to
>> bottom left to right?
>>
>
> The scissor rectangle is always in screen coordinates. It isn't affected
> by blit direction at all.
>
> Both good questions though. I was a little bit nervous I had missed
> something here. So I went ahead and wrote tests that cover clipping

I wasn't sure either so that's why I asked if you considered this case.

> on all sides (including combinations) for both memory and host_data blits.
> All tests pass (match framebuffer dumps from r128 hardware). I'll clean
> them up and attach an updated test link to v9.

That's even better if this is also confirmed by tests now that it will 
work for all cases. Sorry if this caused additional work but it's not 
for nothing as it made sure we don't have bugs.

>>>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
>>>                 ctx->src_bits, ctx->dst_bits, src_stride_words,
>>> -                dst_stride_words, ctx->bpp, ctx->bpp, ctx->src.x, ctx->src.y,
>>> -                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height);
>>> +                dst_stride_words, ctx->bpp, ctx->bpp, vis_src.x, vis_src.y,
>>> +                vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);
>>
>> Maybe log visible rect in addition of src and dst not replacing it here so
>> we can debug if clipping was correctly done.
>>
>> If you don't want to consider different directions than top to bottom left
>> to right that's OK but then we probably need a check and a LOG_UNIMP in
>> that case and keep using unclipped  dst and src (just copying to vis rects
>> I guess) in that case.
>>
>
> As written right now this logs exactly what is being passed into
> pixman_blt(). Definitely agree it might be useful to see the raw src and
> dst though too. Do you see it as a second log line before/after this
> one?

You could either add more coordinates to this log line to log all data 
related to a blit at one place or add a separate debug log that only logs 
clipping inputs and result and keep this to log only the pixman_blt call. 
I don't have a preference on this and either would work. I just want to 
see what valies the guest passed then how did we arrive to the blt call so 
we can verify it if the results aren't what expected on screen. As this is 
debug log it would not be seen normally so whatever makes more sense for 
debugging. Maybe a separate line near where clipping is done might work as 
that then could also be commented out separately when not needed.

Regards,
BALATON Zoltan

