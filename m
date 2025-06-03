Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31911C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRxn-0006ju-I2; Tue, 03 Jun 2025 09:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMRxd-0006hy-TC; Tue, 03 Jun 2025 09:45:50 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1uMRxb-0002sV-UY; Tue, 03 Jun 2025 09:45:49 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 89423A014A; Tue,  3 Jun 2025 15:45:43 +0200 (CEST)
Date: Tue, 3 Jun 2025 15:45:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 11/16] hw/pci-host/raven: Do not use parent object for
 mmcfg region
In-Reply-To: <fb178d96-ee28-414c-a320-2b5b0ceee5e6@linaro.org>
Message-ID: <alpine.LMD.2.03.2506031543570.13449@eik.bme.hu>
References: <cover.1746374076.git.balaton@eik.bme.hu>
 <104976fab9e144328dd9c73efceeb75a759a83f7.1746374076.git.balaton@eik.bme.hu>
 <fb178d96-ee28-414c-a320-2b5b0ceee5e6@linaro.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-264855107-1748958343=:13449"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--1117279078-264855107-1748958343=:13449
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/5/25 18:01, BALATON Zoltan wrote:
>> The mmcfg field in PCIHostState is only used by raven for the PCI
>> config direct access but is not actually needed as the memory region
>> lifetime can be managed by the object given during init so use that
>> and remove the unused field from PCIHostState.
>>=20
>
> Well, this is the recommended way to avoid leaking MemoryRegions.
>
> If QOM object allocates something, it should keep a reference to it,
> allowing simpler eventual implementation of DeviceUnrealize handler.

MemoryRegions are already tracked by owner object so no need to free them=
=20
in unrealize or embed them in stat struct to avoid leaking them. I'd only=
=20
store things in state that are really needed.

Regards,
BALATON Zoltan

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/pci-host/raven.c       | 7 ++++---
>>   include/hw/pci/pci_host.h | 1 -
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
>> index c39e95b45f..7550c291c6 100644
>> --- a/hw/pci-host/raven.c
>> +++ b/hw/pci-host/raven.c
>> @@ -212,7 +212,7 @@ static void raven_pcihost_realizefn(DeviceState *d,=
=20
>> Error **errp)
>>       SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
>>       PCIHostState *h =3D PCI_HOST_BRIDGE(dev);
>>       PREPPCIState *s =3D RAVEN_PCI_HOST_BRIDGE(dev);
>> -    MemoryRegion *address_space_mem =3D get_system_memory();
>> +    MemoryRegion *mr, *address_space_mem =3D get_system_memory();
>>         qdev_init_gpio_in(d, raven_change_gpio, 1);
>>   @@ -229,9 +229,10 @@ static void raven_pcihost_realizefn(DeviceState *=
d,=20
>> Error **errp)
>>                             "pci-conf-data", 4);
>>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>>   -    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops,=20
>> h->bus,
>> +    mr =3D g_new0(MemoryRegion, 1);
>> +    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
>>                             "pci-mmcfg", 0x00400000);
>> -    memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcf=
g);
>> +    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
>>         memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_o=
ps,=20
>> s,
>>                             "pci-intack", 1);
>> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
>> index e52d8ec2cd..7c0285e2ff 100644
>> --- a/include/hw/pci/pci_host.h
>> +++ b/include/hw/pci/pci_host.h
>> @@ -41,7 +41,6 @@ struct PCIHostState {
>>         MemoryRegion conf_mem;
>>       MemoryRegion data_mem;
>> -    MemoryRegion mmcfg;
>>       uint32_t config_reg;
>>       bool mig_enabled;
>>       PCIBus *bus;
>
>
--1117279078-264855107-1748958343=:13449--

