Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CE1F99C88
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 14:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE75s-0002qK-A7; Sat, 18 Apr 2026 10:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wE75p-0002q6-SO
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 10:56:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wE75n-00081z-4V
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 10:56:21 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DA74C59695A;
 Sat, 18 Apr 2026 16:56:14 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hnCA4D5JcORX; Sat, 18 Apr 2026 16:56:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4CF92596958; Sat, 18 Apr 2026 16:56:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4AFAA596957;
 Sat, 18 Apr 2026 16:56:12 +0200 (CEST)
Date: Sat, 18 Apr 2026 16:56:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
In-Reply-To: <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
Message-ID: <ef33b737-1f62-032a-5e97-4fc0a371f202@eik.bme.hu>
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
 <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
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

On Sat, 18 Apr 2026, Chad Jablonski wrote:
>> I guess this is to fix chars not appearing in xterm when a virtual desktop
>> is panned that you noticed here?
>> https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg00785.html
>>
>
> Yep! I should have mentioned this.
>
>>> The second is that a bounds check was also being performed to ensure
>>> that the dirty memory was within the visible screen. With the virtual
>>> desktop this isn't actually what we want. Updates can and will happen
>>> outside of the visible screen area. Those should be marked dirty.
>>
>> But I still think only the visible area should need marking dirty because it
>> is used to update display so marking non visible parts should have no
>> effect. I'm not sure if it has any performance impact but just seems
>> unnecessary so that's why this tried to limit it to visible area. I've
>> added to cc some people who could maybe enlighten us on this.
>>
>
> After digging into this deeper I think you're right that the
> non-visible dirty marking isn't necessary. Looking at vga_draw_graphic
> in hw/display/vga.c it looks like anytime the screen pans, a full screen
> update is triggered. But from what I can tell the full screen update doesn't
> clear the dirty map. Only partial updates do that. So setting non-visible
> regions dirty could cause the non-visible regions to be updated later
> when it isn't necessary. Meaning the user could pan over the region, do
> an unrelated blit and the stale dirty regions would also be updated. I'm
> not sure what sort of perfomance implications this has though.
>
> I think if we want to avoid this the way to do it may be to just take
> the intersection of the currently visible screen area and the
> destination area and mark just that as dirty.

That could work but maybe we also have problems with calculating 
intersects. The ATI docs say SC values can be negative (Range -8192 to 
8191) but we don't seem to handle that correctly. I don't know if any 
drivers use negative values in scissor clipping, I've only noticed it when 
checking with different values so maybe that's not be a problem in common 
cases.

> Even fixing the unit issue
> the old bounds check would miss blits that began outside of the visible
> screen and continued onto the visible screen.

Maybe this is the real reason but I still don't see how a relatively small 
blit of one character in a fully visible xterm not even near the left of 
screen could be missed this way if the screen is panned so I'm still 
suspecting clipping might have something to do with this. Not marking out 
of screen updates also does not explain that so it's probably just wrong 
calculation of visible area. Or you meant that's just another way the 
current calculation could miss updates. Yes that's possible.

> Another thought, we could clear dirty bits on full screen updates. But
> that's a change with a much larger blast radius and I would be nervous to
> make it.

Can we invalidate dirty rect in ati_vga_set_offset to avoid changing vga?

Regards,
BALATON Zoltan

