Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWJG-000703-V8; Mon, 26 May 2025 07:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uJWJ7-0006yF-Fm
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:47:54 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uJWJ4-0004i9-Pg
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:47:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86D5155BC03;
 Mon, 26 May 2025 13:47:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ja5b8t3KylsO; Mon, 26 May 2025 13:47:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4E36055BC02; Mon, 26 May 2025 13:47:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C8AE745682;
 Mon, 26 May 2025 13:47:43 +0200 (CEST)
Date: Mon, 26 May 2025 13:47:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, philmd@linaro.org, smarkusg@gmail.com
Subject: Re: Using parallel port on the Pegasos 2
In-Reply-To: <9F18409A-D9E4-45B3-8A82-BF605F9C56CE@gmail.com>
Message-ID: <b9326d88-0f4f-ff93-4943-89f9062b78c0@eik.bme.hu>
References: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
 <e8832eee-01fe-4cef-d6c4-31fb63677d5c@eik.bme.hu>
 <1d4bc5e4-54ee-84d4-6f5c-50e2d5dd2850@eik.bme.hu>
 <9F18409A-D9E4-45B3-8A82-BF605F9C56CE@gmail.com>
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

On Mon, 26 May 2025, Bernhard Beschow wrote:
> Am 25. Mai 2025 00:03:15 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sun, 28 Jul 2024, BALATON Zoltan wrote:
>>> On Sun, 28 Jul 2024, quan wrote:
>>>> I am playing around with the parallel port on the pegasos 2 and I noticed
>>>> the following issue:
>>>> The parallel port on startup is set to iobase 0x378, then later it gets
>>>> remapped to iobase 0x3bc.
>>>> When I tried writing to the 0x3bc location with
>>>> trace:memory_region_ops_write on, I get logs about writing to the location
>>>> 'parallel', so far so good, but the writes don't make it through (it never
>>>> calls parallel_ioport_write* functions)
>>>>
>>>> I traced it through where it calls portio_write, and inside the
>>>> portio_write code:
>>>> This line always fails for me:
>>>> const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
>>>> This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the list,
>>>> and the 'addr' in the code ranges from (0-15) (address relative to 0x3bc),
>>>> so it can never match the parallel io function to execute.
>>>>
>>>> This seems like a bug to me. I think there is some issue where the
>>>> portio_list is not getting updated properly after the remapping to 0x3bc.
>>>>
>>>> The other devices (Serial, RTC, PM, VGA) responds properly for me, so it is
>>>> only the parallel port that has this issue.
>>>
>>> Is this something that broke recently or can the same be reproduced with QEMU v8.2.0. The relocation of these devices was implemented around commit 35a6380b4ed27f (and the ones before that). Adding Bernhard to cc as well.
>>
>> This commit also seems to break display with some VGA ROMs as can be reproduced with:
>>
>> qemu-system-ppc -machine pegasos2 -bios pegasos2.rom -serial stdio -vga none -device ati-vga,romfile=ati-rage128progl16mb.VBI
>>
>> where the romfile is something from http://vgamuseum.info/index.php/companies/item/111-ati-rage-128-pro for example). Until commit 35a6380b4ed27f^ you get picture on emulated VGA but not after (although I have no idea what a VGA BIOS has to do with the parallel port). Any idea how to fix this?
>
> Here an observation: Executing `info mtree` reveals that the parallel 
> port gets mapped to 0x3bc - 0x3c3 which overlaps with some vga region 
> (0x3c0 - 0x3cf). So the commit seems to expose a firmware bug in 
> pegasos2.rom or in its default configuration. On real hardware both 
> devices might respond such that the bug might not materialize there like 
> in QEMU, but that's just a guess. Maybe one could work around that by 
> decreasing the priority of the parallel io ports.

Hmm, I haven't noticed that (only looked at the diff between working and 
non-working and saw it moved) but according to e.g. 
https://www.stanislavs.org/helppc/ports.html The original parallel 
interface had less ports so there was no overlap, maybe it's because we 
emulate EPP+ECP or other advanced features that the message from the Linux 
list mentions as not working at the default address on real machine 
either. So we may need to disable additional ports which probably do not 
exist on real machine unless enabled (which the firmware does not seem to 
do) or maybe changing priority as you say could help. Anybody wants to 
come up with a patch? I don't have time now and may forget later.

Regards,
BALATON Zoltan

