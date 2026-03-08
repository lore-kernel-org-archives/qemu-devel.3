Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2CCFC9EC8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 14:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzEmy-0006s2-NJ; Sun, 08 Mar 2026 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzEmw-0006rm-SK
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 10:07:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzEmu-00034N-Ba
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 10:07:22 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 16D515969FD;
 Sun, 08 Mar 2026 15:07:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q3yn2rT9YNQJ; Sun,  8 Mar 2026 15:07:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 73D065969F2; Sun, 08 Mar 2026 15:07:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 720705969E4;
 Sun, 08 Mar 2026 15:07:14 +0100 (CET)
Date: Sun, 8 Mar 2026 15:07:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Chad Jablonski <chad@jablonski.xyz>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: ati-vga patches for 11.0
In-Reply-To: <3f09f4c0-8584-73c2-55bc-e39df83b3866@eik.bme.hu>
Message-ID: <7f1df452-05c2-efa3-fdce-a5d987cfdcc8@eik.bme.hu>
References: <3f09f4c0-8584-73c2-55bc-e39df83b3866@eik.bme.hu>
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

On Fri, 6 Mar 2026, BALATON Zoltan wrote:
> On Wed, 4 Mar 2026, BALATON Zoltan wrote:
>> On Mon, 2 Mar 2026, Chad Jablonski wrote:
>>> Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
>>> text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
>>> monochrome frgd, and color), however monochrome frgd support is
>>> partial and does not properly handle transparency/leave-alone.
>>> 
>>> The flush is broken up into two steps. First, if necessary, expansion of 
>>> the
>>> monochrome bits to the destination color depth. Then the expanded pixels
>>> are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
>>> clips and performs the blit.
>>> 
>>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>> 
>> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>> 
>> Also tested that it works with MorphOS that was known to need it for some 
>> font rendering so this fixes Xorg and MorphOS. It is now fully reviewed, 
>> but I can't send pull requests so is there anybody collecting patches for 
>> hw/display and will send a pull before the freeze? I may have one more 
>> patch to send before the freeze but otherwise this series is all we would 
>> like to include for ati-vga in the coming release.
>
> Hello,
>
> Sorry to bother you but is there anybody collecting patches for hw/display to 
> make a pull request before the freeze? This used to be Gerd's area but he did 
> not send pulls for quite a while. We have this series:
>
> https://patchew.org/QEMU/20260303024730.1489136-1-chad@jablonski.xyz/
>
> and this one patch already rebased on it:
>
> https://patchew.org/QEMU/20260305233717.1D08F5969F6@zero.eik.bme.hu/
>
> that we would like to include in the next release. Please let me know if 
> somebody is taking care of this.

I hope everybody kept silent so far not because nobody read this but 
because they hoped somebody else might take it. Now with the freeze coming 
I start to worry if there's anybody picking this up. If somebody plans to 
please reply. If nobody does, as ati-vga is used by a MIPS machine maybe 
Philippe could help? Note this: 
https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg06308.html
So for testing you'd have to change the APER_SIZE but otherwise this is 
something to fix in the machine not in ati-vga so we can't fix it there.

Chad was working on this since last year, it would be a pity to miss this 
release due to not having a maintainer.

Regards,
BALATON Zoltan

