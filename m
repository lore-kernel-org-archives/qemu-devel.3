Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54152C54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbrC-00083Q-FF; Fri, 23 Feb 2024 15:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdbee-00007M-Nq
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:56:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rdbeY-0000it-Af
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:56:16 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3720D4E602C;
 Fri, 23 Feb 2024 20:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SyPAy-nHsocc; Fri, 23 Feb 2024 20:56:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 412704E6004; Fri, 23 Feb 2024 20:56:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3F95A745708;
 Fri, 23 Feb 2024 20:56:07 +0100 (CET)
Date: Fri, 23 Feb 2024 20:56:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 philmd@linaro.org
Subject: Re: [PATCH 05/10] hppa: do not require CONFIG_USB
In-Reply-To: <50972788-77b0-4494-b956-367e227575b6@redhat.com>
Message-ID: <ab8ce4b2-d0c4-867e-44cf-44137e91a610@eik.bme.hu>
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-6-pbonzini@redhat.com>
 <50972788-77b0-4494-b956-367e227575b6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-226990619-1708718167=:36853"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-226990619-1708718167=:36853
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 23 Feb 2024, Thomas Huth wrote:
> On 23/02/2024 13.44, Paolo Bonzini wrote:
>> With --without-default-devices it is possible to build a binary that
>> does not include any USB host controller and therefore that does not
>> include the code guarded by CONFIG_USB.  While the simpler creation
>> functions such as usb_create_simple can be inlined, this is not true
>> of usb_bus_find().  Remove it, replacing it with a search of the single
>> USB bus on the machine.
>> 
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/hppa/machine.c | 7 ++++---
>>   hw/hppa/Kconfig   | 2 +-
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 5fcaf5884be..11982d5776c 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -396,10 +396,11 @@ static void machine_HP_common_init_tail(MachineState 
>> *machine, PCIBus *pci_bus,
>>       }
>>         /* create USB OHCI controller for USB keyboard & mouse on Astro 
>> machines */
>> -    if (!lasi_dev && machine->enable_graphics) {
>> +    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
>
> Do we need the defaults_enabled() here? Isn't enable_graphics already 
> disabled if defaults_enabled() is not set?

Isn't enable_graphics controlled by -nographic and defaults_enabled 
controlled by -nodefaults? I think they are independent but maybe that 
does not answer the question if it's needed or not.

Regards,
BALATON Zoltan

> Thomas
>
>
>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
>> -        usb_create_simple(usb_bus_find(-1), "usb-mouse");
>> +        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, 
>> &error_abort);
>> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
>> +        usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
>>       }
>
>
>
--3866299591-226990619-1708718167=:36853--

