Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C05BCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 16:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8LLi-0004BC-1O; Mon, 13 Oct 2025 12:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8LLe-0004Aj-D6
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:24:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8LLZ-0004bJ-SU
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 12:24:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C6ED5972E5;
 Mon, 13 Oct 2025 18:24:19 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Xuf1FliQjIUW; Mon, 13 Oct 2025 18:24:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4702B5972E1; Mon, 13 Oct 2025 18:24:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4507359703F;
 Mon, 13 Oct 2025 18:24:17 +0200 (CEST)
Date: Mon, 13 Oct 2025 18:24:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
In-Reply-To: <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
Message-ID: <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
 <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
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

On Mon, 13 Oct 2025, Chad Jablonski wrote:
> Hi Balaton,
>
> Thanks for taking a look! I'll address all of these and send a v2.
>
>> The documentation does not mention 64MB alignment. It says apertures must
>> be on a 32MB boundary and src and dst offsets are 128 bit aligned but
>> maybe I don't have the right documentation for these chips or don't get
>> what it means.
>>
>
> Agreed, yeah the register docs do say there is a max of 32MB of framebuffer
> memory and a max of 32MB of AGP memory (register reference pg. 2-6)
> which implies 32MB alignment. And the software guide does explicitly say
> that apertures must be located on a 32MB boundary (software guide 2-19).
> It then goes on to describe how the aperture is split into 32MB for frame
> buffer space and 32MB for AGP/PCI space. Which implies that 64MB is needed
> for the full aperture. And from what I understand requesting 64MB will
> naturally lead to a 64MB alignment from PCI.
>
> Outside of what I observed on the real hardware another thing that lead me
> to believe that the 64MB alignment is correct was this line in the XOrg
> r128 driver: https://gitlab.freedesktop.org/xorg/driver/xf86-video-r128/-/blob/XORG-RELEASE-1/src/r128_driver.c#L855
> The driver is assuming a 64MB alignment by masking addresses with
> 0xfc000000 (2^26 = 64MB). When qemu requests 16MB or 32MB it breaks that assumption
> and the driver looks in the wrong memory area for the framebuffer.

I'm not saying the 64MB alignment is not correct (I don't know what is 
correct and assuming the Xorg driver was tested with real cards it's 
possible this assumption holds) but maybe it comes from having a 64MB VRAM 
BAR that contains twice the size of actual VRAM including the AGP window 
which also satisfies the 32MB alignment for VRAM, so the commit message 
may nees to be adjusted to say that instead of something not supported by 
documentation. Do you have any PCI cards? There were PCI versions of 
these. I wonder if they also have the same VRAM BAR. If not then no 
problem, we can go with what works for known drivers.

Regards,
BALATON Zoltan

>> Can you check what the CONFIG_APER_SIZE register contains on these cards?
>> Do all Rage 128 (and Pro) cards have 64MB and Radeon 7xxx/M6 have 128MB?
>> The documentation is again not clear on this because it lists default
>> value of 0x2000000 for CONFIG_APER_SIZE on Rage 128 Pro and nothing for
>> Radeon but in a figure it shows this should contain both VRAM and AGP
>> areas that suggests 64MB but it's possible that the documentation is
>> wrong.
>>
>
> I will take a look at this!
>
>>
>> This was changed in commit f7ecde051dd73 to be half the memory size
>> because at least a Radeon FCocde ROM seemed to detect VRAM size that way.
>> I should test that again but it needed OpenBIOS patches that were not
>> merged so I had to find those again as I don't have that setup any more.
>> Checking on real card may be the best source of what this should be but I
>> think this might break that FCode ROM which is from a PowerMac card. This
>> suggests it should be half the aper size.
>>
>
> Ah, great, this is important context. I'll look at this more
> closely and check the real hardware.
>
>>
>> Coding style says variables should be defined at the beginning of blocks
>> so in this case at the beginning of the funcion.
>>
>
> I'll also address all of the style comments.
>
> Thanks again,
> Chad
>
>

