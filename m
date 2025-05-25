Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FE9C54ED1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 00:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIypt-0002qx-HI; Sat, 24 May 2025 20:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uIypr-0002qB-Cx
 for qemu-devel@nongnu.org; Sat, 24 May 2025 20:03:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uIypo-0006iX-2B
 for qemu-devel@nongnu.org; Sat, 24 May 2025 20:03:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 00C6755BC03;
 Sun, 25 May 2025 02:03:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MptNcu10yg5D; Sun, 25 May 2025 02:03:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A606F55BC02; Sun, 25 May 2025 02:03:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A09AB745682;
 Sun, 25 May 2025 02:03:15 +0200 (CEST)
Date: Sun, 25 May 2025 02:03:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Bernhard Beschow <shentey@gmail.com>, philmd@linaro.org, 
 smarkusg@gmail.com
Subject: Re: Using parallel port on the Pegasos 2
In-Reply-To: <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
Message-ID: <1d4bc5e4-54ee-84d4-6f5c-50e2d5dd2850@eik.bme.hu>
References: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
 <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sun, 28 Jul 2024, BALATON Zoltan wrote:
> On Sun, 28 Jul 2024, quan wrote:
>> I am playing around with the parallel port on the pegasos 2 and I noticed
>> the following issue:
>> The parallel port on startup is set to iobase 0x378, then later it gets
>> remapped to iobase 0x3bc.
>> When I tried writing to the 0x3bc location with
>> trace:memory_region_ops_write on, I get logs about writing to the location
>> 'parallel', so far so good, but the writes don't make it through (it never
>> calls parallel_ioport_write* functions)
>> 
>> I traced it through where it calls portio_write, and inside the
>> portio_write code:
>> This line always fails for me:
>> const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
>> This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the list,
>> and the 'addr' in the code ranges from (0-15) (address relative to 0x3bc),
>> so it can never match the parallel io function to execute.
>> 
>> This seems like a bug to me. I think there is some issue where the
>> portio_list is not getting updated properly after the remapping to 0x3bc.
>> 
>> The other devices (Serial, RTC, PM, VGA) responds properly for me, so it is
>> only the parallel port that has this issue.
>
> Is this something that broke recently or can the same be reproduced with QEMU 
> v8.2.0. The relocation of these devices was implemented around commit 
> 35a6380b4ed27f (and the ones before that). Adding Bernhard to cc as well.

This commit also seems to break display with some VGA ROMs as can be 
reproduced with:

qemu-system-ppc -machine pegasos2 -bios pegasos2.rom -serial stdio -vga none -device ati-vga,romfile=ati-rage128progl16mb.VBI

where the romfile is something from 
http://vgamuseum.info/index.php/companies/item/111-ati-rage-128-pro for 
example). Until commit 35a6380b4ed27f^ you get picture on emulated VGA but 
not after (although I have no idea what a VGA BIOS has to do with the 
parallel port). Any idea how to fix this?

Regards,
BALATON Zoltan

