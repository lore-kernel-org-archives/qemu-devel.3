Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370CF513E7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 23:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyIaf-0007Yt-NN; Thu, 05 Mar 2026 18:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyIae-0007Y3-0I
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 18:58:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyIab-0002F5-UL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 18:58:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 232695969F6;
 Fri, 06 Mar 2026 00:58:40 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id o9pGJ3hIHYW5; Fri,  6 Mar 2026 00:58:37 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 69B225969F2; Fri, 06 Mar 2026 00:58:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65B485966F5;
 Fri, 06 Mar 2026 00:58:37 +0100 (CET)
Date: Fri, 6 Mar 2026 00:58:37 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Chad Jablonski <chad@jablonski.xyz>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: ati-vga patches for 11.0
Message-ID: <3f09f4c0-8584-73c2-55bc-e39df83b3866@eik.bme.hu>
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

On Wed, 4 Mar 2026, BALATON Zoltan wrote:
> On Mon, 2 Mar 2026, Chad Jablonski wrote:
>> Implement flushing the 128-bit HOST_DATA accumulator to VRAM to enable
>> text rendering in X. Supports all datatypes (monochrome frgd/bkgd,
>> monochrome frgd, and color), however monochrome frgd support is
>> partial and does not properly handle transparency/leave-alone.
>> 
>> The flush is broken up into two steps. First, if necessary, expansion of 
>> the
>> monochrome bits to the destination color depth. Then the expanded pixels
>> are sent to the ati_2d_do_blt one scanline at a time. ati_2d_do_blt then
>> clips and performs the blit.
>> 
>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Also tested that it works with MorphOS that was known to need it for some 
> font rendering so this fixes Xorg and MorphOS. It is now fully reviewed, but 
> I can't send pull requests so is there anybody collecting patches for 
> hw/display and will send a pull before the freeze? I may have one more patch 
> to send before the freeze but otherwise this series is all we would like to 
> include for ati-vga in the coming release.

Hello,

Sorry to bother you but is there anybody collecting patches for hw/display 
to make a pull request before the freeze? This used to be Gerd's area but 
he did not send pulls for quite a while. We have this series:

https://patchew.org/QEMU/20260303024730.1489136-1-chad@jablonski.xyz/

and this one patch already rebased on it:

https://patchew.org/QEMU/20260305233717.1D08F5969F6@zero.eik.bme.hu/

that we would like to include in the next release. Please let me know if 
somebody is taking care of this.

Thank you,
BALATON Zoltan

