Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A5AEDEBFF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxb7R-000371-4f; Tue, 03 Mar 2026 20:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxb7P-00036M-9J; Tue, 03 Mar 2026 20:33:43 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxb7L-0007Ew-OS; Tue, 03 Mar 2026 20:33:42 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8FB585969FA;
 Wed, 04 Mar 2026 02:33:36 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hhwOqD2WwtvA; Wed,  4 Mar 2026 02:33:34 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 777025969F2; Wed, 04 Mar 2026 02:33:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7574C5969F0;
 Wed, 04 Mar 2026 02:33:34 +0100 (CET)
Date: Wed, 4 Mar 2026 02:33:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 11/13] hw/char/serial: Keep MemoryRegionOps private
In-Reply-To: <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
Message-ID: <d77f00da-83b9-4499-5458-305eaf9f1470@eik.bme.hu>
References: <20260303222143.142741-1-shentey@gmail.com>
 <20260303222143.142741-12-shentey@gmail.com>
 <8a363801-914d-7870-3b1b-a4c9182ba4cc@eik.bme.hu>
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

On Tue, 3 Mar 2026, BALATON Zoltan wrote:
> On Tue, 3 Mar 2026, Bernhard Beschow wrote:
>> Rather than requiring users of TYPE_SERIAL to initialize the MMIO region
>> themselves, make it generic enough to be configured via properties. This
>> makes TYPE_SERIAL more self-contained and prepares it for being turned
>> into a SysBusDevice.
>> 
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>> include/hw/char/serial-mm.h |  3 --
>> include/hw/char/serial.h    |  4 +-
>> hw/char/diva-gsp.c          |  5 ---
>> hw/char/serial-isa.c        |  1 -
>> hw/char/serial-mm.c         | 51 -------------------------
>> hw/char/serial-pci-multi.c  |  5 ---
>> hw/char/serial-pci.c        |  1 -
>> hw/char/serial.c            | 76 ++++++++++++++++++++++++++++++-------
>> 8 files changed, 66 insertions(+), 80 deletions(-)
>> 
>> diff --git a/include/hw/char/serial-mm.h b/include/hw/char/serial-mm.h
>> index 0076bdc061..4c18e2a609 100644
>> --- a/include/hw/char/serial-mm.h
>> +++ b/include/hw/char/serial-mm.h
>> @@ -39,9 +39,6 @@ struct SerialMM {
>>     SysBusDevice parent;
>>
>>     SerialState serial;
>> -
>> -    uint8_t regshift;
>> -    uint8_t endianness;
>> };
>
> This effectively makes TYPE_SERIAL the same as TYPE_SERIAL_MM so you could 
> just merge the two and have everything embed a SERIAL_MM device. But the idea 
> here is to make TYPE_SERIAL a superclass of all serial devices and SERIAL_MM 
> is the memory mapped version. Memory mapped devices are usually SysBusDevices 
> but others are not so this seems to be trying to model things in the wrong 
> way. Maybe you could just add accessor functions to TYPE_SERIAL to get the 
> memory regions and use that from subclasses to avoid poking in the state 
> struct and not try to reuse SysBusDevice for this.

Or instead of TYPE_SERIAL exporting memory regions it could export ops or 
functions for it (like PCI IDE or PCI does) and let subclasses implement 
the regions that call these exported functions with the register layout 
they need?

Regards,
BALATON Zoltan

