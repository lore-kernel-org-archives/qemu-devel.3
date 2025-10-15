Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C884CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 23:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9BHN-0003bJ-9b; Wed, 15 Oct 2025 19:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9BHL-0003bA-Oc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:51:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1v9BHE-00049j-4N
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 19:51:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9F435972E7;
 Thu, 16 Oct 2025 01:51:21 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Dk56i5OKkSUE; Thu, 16 Oct 2025 01:51:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0F8825972E3; Thu, 16 Oct 2025 01:51:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D6B85972E8;
 Thu, 16 Oct 2025 01:51:19 +0200 (CEST)
Date: Thu, 16 Oct 2025 01:51:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Chad Jablonski <chad@jablonski.xyz>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using hardware-correct
 aperture sizes
In-Reply-To: <DDIYXXF8C8O3.BGW7D8I6VZTW@jablonski.xyz>
Message-ID: <93a93652-0203-47f0-6179-edfa543990fa@eik.bme.hu>
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
 <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
 <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
 <DDHGPB02664A.3C0GAHH5K41QT@jablonski.xyz>
 <fee6d690-8302-d3bb-fdec-52e59662f97a@eik.bme.hu>
 <DDIYXXF8C8O3.BGW7D8I6VZTW@jablonski.xyz>
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

On Wed, 15 Oct 2025, Chad Jablonski wrote:
>> Question is if Radeon has BAR0 matching VRAM size because in that case if
>> Rage128 has fixed 64MB and Radeon has size of VRAM for BAR0 then
>> CONFIG_APER_SIZE can be half of BAR0 which would work for both. But if
>> Radeon also has a fixed size BAR0 larger than actual VRAM (mathching max
>> supported VRAM instead then current calculation is needed using VRAM size
>> for radeon according to the FCode ROM I've tested. Changing
>> CONFIG_APER_SIZE only for Rage128 should not break anything as I did not
>> see anything using that so that would also work if we can't find out what
>> Radeon has.
>>
>
> Card                          VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APER_SIZE  AGP_APER_OFFSET
> -----------------------       ----    --------   --------------  ----------------  ---------------
> Rage 128 Pro Ultra TF         32MB     64MB       0x02000000      0x02000000        0x02000000
> Rage 128 RF/SG AGP            16MB     64MB       0x01000000      0x02000000        0x02000000
> Radeon R100 QD [Radeon 7200]  64MB    128MB       0x04000000      0x04000000        N/A

For this R100 card APER_SIZE matches MEMSIZE but the BAR length is twice 
that. Maybe the other card you get will shed some light on what's going on 
with Radeon. I've looked up what the FCode ROM I've tested was doing. This 
is from a Card#109-85500-00 Rom#113-85501-226 according to the IDs it sets 
in the device tree, probably from a PowerMac but I don't have the card 
just found this ROM. The detokenized part of this Radeon 7000/RV100 ROM 
that accesses CONFIG_APER_SIZE looks like this:

   7321: const_REG_CONFIG_APER_SIZE
   7323: ati-reg-l@
   7325: dup
   7326: b(to) var_aper_size
   7329: 2*
   7330: b(to) var_ram_size
   7333: const_REG_CONFIG_REG_APER_SIZE
   7335: ati-reg-l@
   7337: 2*
   7338: b(to) var_mmio_size

The variable names were invented by me so it's possible that it actually 
means vram and mmio BAR size but it does 2* for both the VRAM and REG 
APERS and this is the size it then uses for map-in and map-out calls so 
this suggests these registers are half of the BAR size at least for this 
card.

> Looking at the linux source it appears the R100 doesn't have an
> AGP_APER_OFFSET register. The register at that offset according to the
> linux driver is something else entirely. This suggests that
> the R100 doesn't map AGP memory space into BAR0 in the way that the
> Rage 128 does. It makes sense that the R128's BAR0 would be twice the
> max memory for the architecture given that it also has to do this AGP
> mapping. But if the R100 _doesn't_ then it wouldn't need to make room
> for AGP and it may just be that the BAR0 is the size of the max memory.
> I don't have documentation for the R100 though so it's tough to know for sure.
>
> But to answer your question about the BAR0 matching VRAM on the R100.
> At least for this card it does not. The VRAM is half of the BAR0. I have a
> 32MB Radeon arriving soon so I'll be able to test that to see if it also
> follows that pattern or if BAR0 is still 128MB. From what I'm seeing there
> may have been some 128MB R100's, it's not entirely clear to me. So it's
> possible that the 128MB is the max VRAM.

I only have a Rage Mobility M6 Design Guide (M6 is another name for RV100) 
that talks about memory size and it says that it's minimum 8MB maximum 
64MB but could be R100 supported more. It's still possible that the BAR 
size is twice the VRAM size for some reason but we don't have enough 
evidence for that.

Regards,
BALATON Zoltan

