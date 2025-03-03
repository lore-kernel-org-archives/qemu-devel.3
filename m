Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA91C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp4y9-0003wB-55; Mon, 03 Mar 2025 07:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp4xu-0003mX-5t
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:32:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp4xq-000097-69
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:32:09 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D02214E6010;
 Mon, 03 Mar 2025 13:32:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LKkezUbhSVLO; Mon,  3 Mar 2025 13:32:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E88324E6014; Mon, 03 Mar 2025 13:32:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E692074577C;
 Mon, 03 Mar 2025 13:32:00 +0100 (CET)
Date: Mon, 3 Mar 2025 13:32:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] hw/nvram/eeprom_at24c: Reorganise init to avoid
 overwriting values
In-Reply-To: <feff5b7e-0d56-4776-bec4-ffb745ae5120@linaro.org>
Message-ID: <5c7d100e-858f-52c3-e172-309529783663@eik.bme.hu>
References: <cover.1740839457.git.balaton@eik.bme.hu>
 <fd8e0478febd60d5f48c58bc77c60e043d1c3cdc.1740839457.git.balaton@eik.bme.hu>
 <feff5b7e-0d56-4776-bec4-ffb745ae5120@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-864554277-1741005120=:25847"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-864554277-1741005120=:25847
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Mar 2025, Philippe Mathieu-Daudé wrote:
> On 1/3/25 15:35, BALATON Zoltan wrote:
>> The init_rom can write values to the beginning of the memory but these
>> are overwritten by values from a backing file that covers the whole
>> memory. Do the init_rom handling only if it would not be overwritten.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/nvram/eeprom_at24c.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
>> index 78c81bea77..ff7a21eee7 100644
>> --- a/hw/nvram/eeprom_at24c.c
>> +++ b/hw/nvram/eeprom_at24c.c
>> @@ -191,10 +191,6 @@ static void at24c_eeprom_realize(DeviceState *dev, 
>> Error **errp)
>>         ee->mem = g_malloc0(ee->rsize);
>>   -    if (ee->init_rom) {
>> -        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
>> -    }
>> -
>>       if (ee->blk) {
>>           int ret = blk_pread(ee->blk, 0, ee->rsize, ee->mem, 0);
>>   @@ -204,6 +200,8 @@ static void at24c_eeprom_realize(DeviceState *dev, 
>> Error **errp)
>>               return;
>>           }
>>           DPRINTK("Reset read backing file\n");
>> +    } else if (ee->init_rom) {
>
> Don't you want to keep overwritting the init_rom[] buffer?
>
> IOW why not s/else//?

I've tried to explain that in the commit message. Current behaviour is to 
use backing file content overwriting init_rom content. Removing else here 
would change that and init_rom would overwrite data read from backing 
file. I think normally init_rom is used only if there's no backing file 
(provides default content) but should not overwrite backing file content 
(especially leaving the file unchanged and only change it in memory). So I 
don't see why would that be useful.

Regards,
BALATON Zoltan

>> +        memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
>>       }
>>         /*
>
>
--3866299591-864554277-1741005120=:25847--

