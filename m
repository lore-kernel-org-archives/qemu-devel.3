Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF2DC021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 02:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnTTq-00046l-9h; Wed, 26 Feb 2025 21:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnTTj-00046K-VS; Wed, 26 Feb 2025 21:18:24 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tnTTh-0003IP-B0; Wed, 26 Feb 2025 21:18:23 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8FE24E602B;
 Thu, 27 Feb 2025 03:18:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id i7-gY2ht20Eu; Thu, 27 Feb 2025 03:18:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 072F04E6027; Thu, 27 Feb 2025 03:18:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 04E5B74577C;
 Thu, 27 Feb 2025 03:18:15 +0100 (CET)
Date: Thu, 27 Feb 2025 03:18:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 3/4] ppc/amigaone: Add default environment
In-Reply-To: <D82U15TLWUH7.2HKA1PQKQGVMM@gmail.com>
Message-ID: <3a522e6f-5800-c530-e59f-a602c11a0fea@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <f1b53e0822111c6c557797adcc75f8d2c7eed17f.1740243918.git.balaton@eik.bme.hu>
 <D82U15TLWUH7.2HKA1PQKQGVMM@gmail.com>
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

On Thu, 27 Feb 2025, Nicholas Piggin wrote:
> On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
>> Initialise empty NVRAM with default values. This also enables IDE UDMA
>> mode in AmigaOS that is faster but has to be enabled in environment
>> due to problems with real hardware but that does not affect emulation
>> so we can use faster defaults here.
>
> So this overwrites a blank NVRAM file. Okay I suppose if that works.

We're emulating what U-Boot does. If it does not find a valid environment 
it will overwrite with defaults. These defaults are to get the same 
behaviour and additionally to enable UDMA for IDE driver that until now 
had to be done manually to get the same speed as with pegasos2 where this 
is enabled by default. (That's because these VIA VT82C686B chips had some 
issues with DMA even in PCs but the emulated devices work so can be 
enabled and that's faster on QEMU too.)

> You could have a property to supply the default environment
> alternatively.

U-Boot has the defaults hard coded. I set and use it from the same file so 
I don't see the need to send this through a property. (Properties are also 
listed in QEMU Monitor with info qtree and I don't know how a long string 
with embedded zeros would look there so I don't think that's a good idea.)

> Anywhere to document this behaviour for users?

I've added docs in the cover letter that I hope would end up in the 
changelog and I have a separate page for this which I'll update at 
qmiga.codeberg.page (Haven't done that yet but would do it by the 
release once this is merged.)

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>> index 5273543460..35e4075cc3 100644
>> --- a/hw/ppc/amigaone.c
>> +++ b/hw/ppc/amigaone.c
>> @@ -52,6 +52,28 @@ static const char dummy_fw[] = {
>>  #define NVRAM_ADDR 0xfd0e0000
>>  #define NVRAM_SIZE (4 * KiB)
>>
>> +static char default_env[] =
>> +    "baudrate=115200\0"
>> +    "stdout=vga\0"
>> +    "stdin=ps2kbd\0"
>> +    "bootcmd=boota; menu; run menuboot_cmd\0"
>> +    "boot1=ide\0"
>> +    "boot2=cdrom\0"
>> +    "boota_timeout=3\0"
>> +    "ide_doreset=on\0"
>> +    "pci_irqa=9\0"
>> +    "pci_irqa_select=level\0"
>> +    "pci_irqb=10\0"
>> +    "pci_irqb_select=level\0"
>> +    "pci_irqc=11\0"
>> +    "pci_irqc_select=level\0"
>> +    "pci_irqd=7\0"
>> +    "pci_irqd_select=level\0"
>> +    "a1ide_irq=1111\0"
>> +    "a1ide_xfer=FFFF\0";
>> +#define CRC32_DEFAULT_ENV 0xb5548481
>> +#define CRC32_ALL_ZEROS   0x603b0489
>> +
>>  #define TYPE_A1_NVRAM "a1-nvram"
>>  OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>
>> @@ -97,7 +119,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>>  {
>>      A1NVRAMState *s = A1_NVRAM(dev);
>>      void *p;
>> -    uint32_t *c;
>> +    uint32_t crc, *c;
>>
>>      memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
>>                                    NVRAM_SIZE, &error_fatal);
>> @@ -116,12 +138,25 @@ static void nvram_realize(DeviceState *dev, Error **errp)
>>              return;
>>          }
>>      }
>> +    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>> +    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
>> +        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
>> +        /* Also copies terminating \0 as env is terminated by \0\0 */
>> +        memcpy(p + 4, default_env, sizeof(default_env));
>> +        if (s->blk) {
>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
>> +        }
>> +        return;
>> +    }
>>      if (*c == 0) {
>>          *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>          if (s->blk) {
>>              blk_pwrite(s->blk, 0, 4, p, 0);
>>          }
>>      }
>> +    if (be32_to_cpu(*c) != crc) {
>> +        warn_report("NVRAM checksum mismatch");
>> +    }
>
> Maybe the default environment should be set if there is no CRC? If there
> is a CRC already then that seems to indicate a valid rom file was
> supplied and user wanted it blank.

The idea is to allow supplying an environment via the backing file or let 
users edit it and clear the checksum in which case it will take the 
supplied data and only fix the checksum. Unlike U-Boot it will only 
replace empty backing file with defaults. (This is kind of undocumented 
for advanced users only but that's why the above code looks like that.) 
Having an empty NVRAM does not make much sense as U-Boot always has some 
values there so it's never empty. If it finds empty NVRAM then installs 
default env which is to help new users so they only need to create an 
empty file to get started. It also works without backing file in which 
case we want to use defaults and keep it persistent only for the session.

> This can also be rewritten:
>
>    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
>    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
>        /* Also copies terminating \0 as env is terminated by \0\0 */
>        memcpy(p + 4, default_env, sizeof(default_env));
>        crc = CRC32_DEFAULT_ENV;
>    }
>    if (*c == 0) {
>        *c = cpu_to_be32(crc);
>        if (s->blk) {
>            blk_pwrite(s->blk, 0, 4, p, 0);
>        }
>    } else if (be32_to_cpu(*c) != crc) {
>        warn_report("NVRAM checksum mismatch");
>    }

I have the checksum check in separate if to warn if there is a checksum 
but it's wrong because I only want it to fix checksum if it's zero but not 
touch it otherwise. Basically it will only overwrite zero values but leave 
nonzero values there. (Might be useful for testing what does the guest do 
if the checksum is wrong, although on real machine U-Boot would have 
replaced the env with default in that case so this would only happen if 
the NVRAM is changed during runtime without updating the checksum.)

Regards,
BALATON Zoltan

