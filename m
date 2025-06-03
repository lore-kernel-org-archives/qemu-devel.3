Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8982AC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS06-0008Ab-36; Tue, 03 Jun 2025 09:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMS05-0008AD-1z
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:48:21 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMRzx-0003Ef-Ga
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:48:20 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id AB00BA0136; Tue,  3 Jun 2025 15:41:00 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:41:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 03/16] hw/pci-host/raven: Simplify PCI facing part
In-Reply-To: <100a010f-43ef-4680-bd74-6d3144c05313@linaro.org>
Message-ID: <alpine.LMD.2.03.2506031539470.13449@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <3a588b74c994521a4e4a608a129a13bf9200030d.1746374076.git.balaton@eik.bme.hu>
 <100a010f-43ef-4680-bd74-6d3144c05313@linaro.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-1485817025-1748958060=:13449"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--1117279078-1485817025-1748958060=:13449
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,
>
> On 4/5/25 18:01, BALATON Zoltan wrote:
>> The raven PCI device does not need a state struct as it has no data to
>> store there any more so we can remove that to simplify code.
>>=20
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c | 30 +-----------------------------
>>   1 file changed, 1 insertion(+), 29 deletions(-)
>>=20
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index f8c0be5d21..172f01694c 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -31,7 +31,6 @@
>>   #include "hw/pci/pci_bus.h"
>>   #include "hw/pci/pci_host.h"
>>   #include "hw/qdev-properties.h"
>> -#include "migration/vmstate.h"
>>   #include "hw/intc/i8259.h"
>>   #include "hw/irq.h"
>>   #include "hw/or-irq.h"
>> @@ -40,12 +39,6 @@
>>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>>   -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
>> -
>> -struct RavenPCIState {
>> -    PCIDevice dev;
>> -};
>> -
>>   typedef struct PRePPCIState PREPPCIState;
>>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
>> @@ -65,7 +58,6 @@ struct PRePPCIState {
>>       MemoryRegion bm_ram_alias;
>>       MemoryRegion bm_pci_memory_alias;
>>       AddressSpace bm_as;
>> -    RavenPCIState pci_dev;
>
> I'd rather the PF0 be reachable from PHB:
>
>       PCIDevice *func0;
>
>>         int contiguous_map;
>>   };
>> @@ -268,8 +260,7 @@ static void raven_pcihost_realizefn(DeviceState *d,=
=20
>> Error **errp)
>>                             "pci-intack", 1);
>>       memory_region_add_subregion(address_space_mem, 0xbffffff0,=20
>> &s->pci_intack);
>>   -    /* TODO Remove once realize propagates to child devices. */
>> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
>
>   func0 =3D
>
>> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0),=20
>> TYPE_RAVEN_PCI_DEVICE);
>>   }

This would be a variable set but not used. Why do we store a value that we=
=20
don't need and easy to look up when needed?

Regards,
BALATON Zoltan

> If you don't object, I can amend if queuing; otherwise:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
--1117279078-1485817025-1748958060=:13449--

