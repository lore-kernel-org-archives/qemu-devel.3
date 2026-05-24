Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C53CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 21:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRGfM-0003Iw-JO; Sun, 24 May 2026 17:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRGfK-0003IV-T2; Sun, 24 May 2026 17:47:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRGfI-0000Gt-E5; Sun, 24 May 2026 17:47:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C1268596944;
 Sun, 24 May 2026 23:47:15 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id S4gIvqvrdRBD; Sun, 24 May 2026 23:47:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B3B42596942; Sun, 24 May 2026 23:47:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B202F596946;
 Sun, 24 May 2026 23:47:13 +0200 (CEST)
Date: Sun, 24 May 2026 23:47:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, qemu-devel-bounces+chad=jablonski.xyz@nongnu.org
Subject: Re: [PATCH v2 3/7] ati-vga: Implement PM4_BUFFER_CNTL register
In-Reply-To: <DIR5UHUDHR6Y.1XFA4FB32DHMQ@jablonski.xyz>
Message-ID: <b89f3562-7233-fd38-b02f-f3420a62cda8@eik.bme.hu>
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-4-chad@jablonski.xyz>
 <06149317-8f88-7424-ebe9-c226cee1f711@eik.bme.hu>
 <DIR5UHUDHR6Y.1XFA4FB32DHMQ@jablonski.xyz>
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

On Sun, 24 May 2026, Chad Jablonski wrote:
>>> The PM4_BUFFER_CNTL register is used to set up the CCE FIFO. These are
>>> straightforward reads and writes. Future CCE patches make use of this
>>> state.
>>
>> This register does not seem to be documented in Rage 128 Pro register
>> reference and the ATI M6/RV100 seems to have different bits. Since the CCE
>> is mostly used by Radeon drivers and there seem to be differences I wonder
>> if it's worth implementing CCE for Rage 128 when it's not the same as the
>> Radeon one and should we insted target Radeon CCE instead? I only know
>> about the MacOS driver that uses CCE with Rage128 (maybe some Windows and
>> more advanced Linux drivers exist) but all almost all Radeon drivers use
>> CCE so that seems more important to me. What do you think? Did you
>> consider the differences between Radeon CCE?
>>
>
> Yeah, this register isn't documented in the register reference. This was based
> on the Rage128 Software Development Guide (Starting the CCE Microengine), as
> well as the linux r128 driver (r128_cce.c). It seems to roughly correspond to
> CP_RB_CNTL in the M6 Register Reference but you're right, the bits are
> different.
>
> The Linux r128 driver does use CCE by default. In fact in order to use
> that driver under QEMU I've had to recompile it with CCE disabled.
>
> I don't have a great sense for just how different CCE setup for the two would
> end up. We do have places already where we conditionally change behavior
> based on the chip. It makes me a bit nervous that things will get out of hand
> if there are large differences. But this may be a larger issue that we
> need to tackle as we understand the differences a bit more.
>
> My thinking was that r128 is likely to be simpler and has a documented process
> for initializing CCE. It would create a framework for CCE work on Radeon to
> follow.

That makes sense and if there aren't huge differences it could work. I 
just thought most people would be more interested in working Radeon 
emulation (and extending that towards later Radeons eventually) than r128 
so targeting that could attract more contributors and it's the direction 
we're going so skipping the r128 might be less work. But if doing r128 
gives some understanding and provides a base rather than ending up being a 
dead end then it's worth doing that first as it might be simpler. I was 
just not sure how similar these are and if the Radeon turns out to be too 
dissimilar the work put in r128 may be less useful. I'd at least try to 
also keep looking at how different Radeon would be while working on r128 
so we also get understanding of that.

> I'm not totally opposed to jumping to Radeon if it makes more sense though. Are
> there specific OSes/targets that you're thinking of for Radeon?

I'm mostly interested in Amiga like OSes which have Radeon drivers that 
use quite a lot of features of these chips but no or very simple R128 
driver that only use it as simple frame buffer with some 2D. (I now wrote 
a simple Radeon driver for AmigaOS that can use the incomplete emulation 
in QEMU so I can test it.) I added the R128 emulation so I can get some 
output early with the simpler R128 driver to test it before having to 
implement all of the Radeon stuff and also because the G4 Macintosh 
emulated by QEMU has the R128Pro as the default GPU on board so it might 
be useful for that (but I mostly lost interest in Mac emulation).

I think these GPU emulations are mostly interesting for retro computing 
and Radeon is the more capable and more widespread so focusing on that may 
make more sense in the longer term but starting with r128 and 
understanding the differences is also a good approach and if these turn 
out to be similar enough then both could be done as we did for other 
features. Radeon started as Rage 6 then was renamed and R128Pro was the 
last generation of the previous chips so these might be close with later 
Radeons could be more different but I don't know these so I can't tell.

Regards,
BALATON Zoltan

