Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB80CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 23:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8oPI-0003BL-J3; Tue, 14 Oct 2025 19:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8oPG-00039X-6l
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:26:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v8oPD-0006yw-KY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 19:26:13 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91ACC5972E9;
 Wed, 15 Oct 2025 01:26:06 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ilPt3kyKudRn; Wed, 15 Oct 2025 01:26:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 866795972E3; Wed, 15 Oct 2025 01:26:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 847D95972DE;
 Wed, 15 Oct 2025 01:26:04 +0200 (CEST)
Date: Wed, 15 Oct 2025 01:26:04 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
In-Reply-To: <DDHGPB02664A.3C0GAHH5K41QT@jablonski.xyz>
Message-ID: <fee6d690-8302-d3bb-fdec-52e59662f97a@eik.bme.hu>
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
 <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
 <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
 <DDHGPB02664A.3C0GAHH5K41QT@jablonski.xyz>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1409901461-1760484364=:24569"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1409901461-1760484364=:24569
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 13 Oct 2025, Chad Jablonski wrote:
>> I'm not saying the 64MB alignment is not correct (I don't know what is
>> correct and assuming the Xorg driver was tested with real cards it's
>> possible this assumption holds) but maybe it comes from having a 64MB VRAM
>> BAR that contains twice the size of actual VRAM including the AGP window
>> which also satisfies the 32MB alignment for VRAM, so the commit message
>> may nees to be adjusted to say that instead of something not supported by
>> documentation. Do you have any PCI cards? There were PCI versions of
>> these. I wonder if they also have the same VRAM BAR. If not then no
>> problem, we can go with what works for known drivers.
>>
>
> Unfortunately I don't have a PCI Rage 128. They actually seem to be somewhat
> rare compared to the AGP versions!
>
> Testing results from two Rage 128 AGP cards:
>
> Card                      VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
> -----------------------   ----    --------   --------------  ----------------  ---------------
> Rage 128 Pro Ultra TF     32MB    64MB       0x02000000      0x02000000        0x02000000
> Rage 128 RF/SG AGP        16MB    64MB       0x01000000      0x02000000        0x02000000
>
>
> * PCI BAR0 (Region 0) is fixed at 64MB for both cards, regardless of actual
>  VRAM size.
>
> * CONFIG_MEMSIZE correctly reports actual VRAM size (32MB and 16MB).
>
> * CONFIG_APER_SIZE is fixed at 32MB (0x02000000) on both cards, regardless
>  of:
>   - Actual VRAM size
>   - AGP enabled/disabled status
>   - AGP_APER_SIZE configuration (tested with 8MB AGP enabled)
>
>   This directly contradicts the Rage 128 Pro Register Reference Guide
>   (pg. 3-202) which states: "Size of linear apertures (both 0 and 1).
>   This includes both the frame buffer image and the AGP system memory
>   image area."
>
> * AGP_APER_OFFSET is also fixed at 32MB (0x02000000) on both cards. On the
>  16MB card, this creates a 16MB gap between the end of framebuffer and the
>  start of the AGP window.

This matches the docs in which a figure shows area after CONFIG_MEMSIZE as 
VRAM extension area so 32MB is reserved for VRAM even if there's less on 
the card and the AGP window starts after that.

> So for Rage 128, CONFIG_APER_SIZE should be set to a fixed 32MB value, not
> dynamically calculated from CONFIG_MEMSIZE + AGP space as the documentation
> suggests and as was previously implemented by me 😬.
>
> I'm less sure about the Radeon and your additional context around the Radeon
> on PowerPC makes me very nervous to change it right now. Especially given I
> have a single example of that card and it's for a PC. I think it makes more
> sense to leave the behavior of CONFIG_APER_SIZE for that card unchanged.

Question is if Radeon has BAR0 matching VRAM size because in that case if 
Rage128 has fixed 64MB and Radeon has size of VRAM for BAR0 then 
CONFIG_APER_SIZE can be half of BAR0 which would work for both. But if 
Radeon also has a fixed size BAR0 larger than actual VRAM (mathching max 
supported VRAM instead then current calculation is needed using VRAM size 
for radeon according to the FCode ROM I've tested. Changing 
CONFIG_APER_SIZE only for Rage128 should not break anything as I did not 
see anything using that so that would also work if we can't find out what 
Radeon has.

Regards,
BALATON Zoltan

> I will send a v2 patch that:
>  * Sets Rage 128 CONFIG_APER_SIZE to 32MB
>  * Updates the commit message to reflect that
>  * Leaves Radeon unchanged (half of the vram_size)
>  * Addresses the style issues
>
>
--3866299591-1409901461-1760484364=:24569--

