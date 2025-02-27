Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95C1C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngwz-0000gy-Tp; Thu, 27 Feb 2025 11:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngwd-0000RD-VN; Thu, 27 Feb 2025 11:41:13 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tngwY-0006xE-Pp; Thu, 27 Feb 2025 11:41:06 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 093E14E6030;
 Thu, 27 Feb 2025 17:41:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3l8EWcw-fFBa; Thu, 27 Feb 2025 17:40:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 194B74E601A; Thu, 27 Feb 2025 17:40:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 16CF774577C;
 Thu, 27 Feb 2025 17:40:58 +0100 (CET)
Date: Thu, 27 Feb 2025 17:40:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/4] ppc/amigaone: Implement NVRAM emulation
In-Reply-To: <D832OVALUQAP.19HG8HTKN2EGJ@gmail.com>
Message-ID: <bbcac143-83ab-330e-389c-e7eaafccbef9@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <7fac3d50347adbb00bfcd1d1d0bfdf9e73515ebb.1740243918.git.balaton@eik.bme.hu>
 <D82TTAPY9JXE.3P3A8B5Y1GAB1@gmail.com>
 <5bd464bc-bcbf-d5ad-abef-3506d255d7e5@eik.bme.hu>
 <D832OVALUQAP.19HG8HTKN2EGJ@gmail.com>
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

On Thu, 27 Feb 2025, Nicholas Piggin wrote:
> On Thu Feb 27, 2025 at 11:48 AM AEST, BALATON Zoltan wrote:
>> On Thu, 27 Feb 2025, Nicholas Piggin wrote:
>>> On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
>>>> The board has a battery backed NVRAM where U-Boot environment is
>>>> stored which is also accessed by AmigaOS and e.g. C:NVGetVar command
>>>> crashes without it having at least a valid checksum.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>  hw/ppc/amigaone.c | 116 ++++++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 113 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>>> index 4290d58613..5273543460 100644
>>>> --- a/hw/ppc/amigaone.c
>>>> +++ b/hw/ppc/amigaone.c
>>>> @@ -21,10 +21,13 @@
>>>>  #include "hw/ide/pci.h"
>>>>  #include "hw/i2c/smbus_eeprom.h"
>>>>  #include "hw/ppc/ppc.h"
>>>> +#include "system/block-backend.h"
>>>>  #include "system/qtest.h"
>>>>  #include "system/reset.h"
>>>>  #include "kvm_ppc.h"
>>>>
>>>> +#include <zlib.h> /* for crc32 */
>>>> +
>>>>  #define BUS_FREQ_HZ 100000000
>>>>
>>>>  /*
>>>> @@ -46,6 +49,103 @@ static const char dummy_fw[] = {
>>>>      0x4e, 0x80, 0x00, 0x20, /* blr */
>>>>  };
>>>>
>>>> +#define NVRAM_ADDR 0xfd0e0000
>>>> +#define NVRAM_SIZE (4 * KiB)
>>>> +
>>>> +#define TYPE_A1_NVRAM "a1-nvram"
>>>> +OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>>> +
>>>> +struct A1NVRAMState {
>>>> +    SysBusDevice parent_obj;
>>>> +
>>>> +    MemoryRegion mr;
>>>> +    BlockBackend *blk;
>>>> +};
>>>> +
>>>> +/* read callback not used because of romd mode, only here just in case */
>>>
>>> Better make it g_assert_not_reached() then.
>>
>> There is a memory_region_rom_device_set_romd() function. It's not called
>> here so a read function should not be needed but it's also trivial and
>> would work if romd mode is turned off for some reason in the future so
>> adding it seems safer to me. The comment is just to note it's a romd
>> region so reads normally don't go through this function unless romd mode
>> is turned off.
>
> It's trivial to add back if you do turn it off. Adding dead code is no
> good. The memory API default won't get changed underneath you without
> proper code audit or deprecating the API so that's no problem.

OK, done in v2.

>>> Better make these addresses #defines at the top of the file with
>>> the NVRAM_ADDR?
>>
>> I don't have defines for these as these are single use constants to set up
>> memory map and with defines it's less obvious and has to be looked up
>> where these are while this way I can see it directly without having to
>> scroll up so I prefer this. I've added defines where the constant is used
>> more than once where it makes sense to keep consistency.
>
> But now you have to lok in two different places anyway because you have
> the NVRAM_ADDR etc defines at the top of the file. Seems like a good
> time to move all defines there so you can easily see the memory map in
> one place.

I don't think this makes it more readable at all but I've added a patch in 
v2 to add defines for these.

Regards,
BALATON Zoltan

