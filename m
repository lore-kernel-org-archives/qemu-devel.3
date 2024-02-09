Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC1C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWq2-0005AF-Ub; Fri, 09 Feb 2024 14:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rYWpw-00054P-9W; Fri, 09 Feb 2024 14:47:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rYWpu-0004rh-20; Fri, 09 Feb 2024 14:47:00 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A7A34E604C;
 Fri,  9 Feb 2024 20:46:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id p2e2W0kO7G4H; Fri,  9 Feb 2024 20:46:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6BBDB4E6005; Fri,  9 Feb 2024 20:46:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 698C47456B4;
 Fri,  9 Feb 2024 20:46:48 +0100 (CET)
Date: Fri, 9 Feb 2024 20:46:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@gmx.de>
cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/hppa/Kconfig: Fix building with "configure
 --without-default-devices"
In-Reply-To: <41399ad8-006d-4480-919e-d64395c5cfe9@gmx.de>
Message-ID: <e92171bc-1677-6132-abcb-d0699e6267b6@eik.bme.hu>
References: <20240209185506.248001-1-thuth@redhat.com>
 <41399ad8-006d-4480-919e-d64395c5cfe9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 9 Feb 2024, Helge Deller wrote:
> On 2/9/24 19:55, Thomas Huth wrote:
>> When running "configure" with "--without-default-devices", building
>> of qemu-system-hppa currently fails with:
>>
>>   /usr/bin/ld: libqemu-hppa-softmmu.fa.p/hw_hppa_machine.c.o: in function 
>> `machine_HP_common_init_tail':
>>   hw/hppa/machine.c:399: undefined reference to `usb_bus_find'
>>   /usr/bin/ld: hw/hppa/machine.c:399: undefined reference to 
>> `usb_create_simple'
>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to `usb_bus_find'
>>   /usr/bin/ld: hw/hppa/machine.c:400: undefined reference to 
>> `usb_create_simple'
>>   collect2: error: ld returned 1 exit status
>>   ninja: build stopped: subcommand failed.
>>   make: *** [Makefile:162: run-ninja] Error 1
>> 
>> And after fixing this, the qemu-system-hppa binary refuses to run
>> due to the missing 'pci-ohci' and 'pci-serial' devices. Let's add
>> the right config switches to fix these problems.
>> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/hppa/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
>> index ff8528aaa8..124d5e9e47 100644
>> --- a/hw/hppa/Kconfig
>> +++ b/hw/hppa/Kconfig
>> @@ -6,7 +6,7 @@ config HPPA_B160L
>>       select ASTRO
>>       select DINO
>>       select LASI
>> -    select SERIAL
>> +    select SERIAL_PCI
>
> I think the "SERIAL" is needed too for the B160L machine.

SERIAL_PCI selects SERIAL so I think it should be pulled in without 
listing it separately but not sure what's the policy for these configs.

Regards,
BALATON Zoltan

> Other than that,
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Thank you!
> Helge
>
>>       select ISA_BUS
>>       select I8259
>>       select IDE_CMD646
>> @@ -16,3 +16,4 @@ config HPPA_B160L
>>       select LASIPS2
>>       select PARALLEL
>>       select ARTIST
>> +    select USB_OHCI_PCI
>
>
>

