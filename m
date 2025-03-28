Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43115C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 14:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyAW4-00069X-CK; Fri, 28 Mar 2025 10:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyAVl-00068j-Ex
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 10:16:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyAVi-0006hO-Am
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 10:16:41 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 170764E6010;
 Fri, 28 Mar 2025 15:16:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id eyBOEj-bIvYW; Fri, 28 Mar 2025 15:16:31 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C49B64E6001; Fri, 28 Mar 2025 15:16:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C2C0974577D;
 Fri, 28 Mar 2025 15:16:31 +0100 (CET)
Date: Fri, 28 Mar 2025 15:16:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: rakeshj <rakeshjb010@gmail.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@redhat.com, philmd@linaro.org, thuth@redhat.com
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
In-Reply-To: <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
Message-ID: <971ac7f1-618d-c94a-93db-9ba887bdc997@eik.bme.hu>
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
 <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-438291374-1743171391=:17461"
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

--3866299591-438291374-1743171391=:17461
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 28 Mar 2025, Paolo Bonzini wrote:
> On 3/27/25 21:50, BALATON Zoltan wrote:
>> On Thu, 27 Mar 2025, rakeshj wrote:
>>> The GT-64120 PCI controller requires special handling where:
>>> 1. Host bridge (device 0) must use native endianness
>>> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>>> 
>>> Previous implementation accidentally swapped all accesses, breaking
>>> host bridge detection (lspci -d 11ab:4620). This fix:
>>> 
>>> - Adds device filtering via (phb->config_reg & 0x00FFF800)
>>> - Preserves native endianness for host bridge
>>> - Maintains swapping for other devices in big-endian mode
>>> 
>>> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE 
>>> MemoryRegionOps")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>>> Signed-off-by: rakeshj <rakeshjb010@gmail.com>
>>> ---
>>> hw/pci-host/gt64120.c | 37 ++++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 36 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>>> index d5c13a89b6..098f8e5988 100644
>>> --- a/hw/pci-host/gt64120.c
>>> +++ b/hw/pci-host/gt64120.c
>>> @@ -320,11 +320,46 @@ static void gt64120_isd_mapping(GT64120State *s)
>>>     memory_region_transaction_commit();
>>> }
>>> 
>>> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned 
>>> size)
>>> +{
>>> +    GT64120State *s = opaque;
>>> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>>> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
>>> +
>>> +    /* Only swap for non-bridge devices in big-endian mode */
>>> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
>>> +        val = bswap32(val);
>> 
>> I don't know if this is the best way to fix this issue as I don't know what 
>> the issue is in the first place (isn't PCI usually little endian?) 
>
> Yes but this particular PCI host bridge is the exception, as it is the only 
> user of pci_host_data_be_ops.
>
>> but I think you can't just use bswap here because it also needs to take 
>> into account the endianness of the host QEMU is running on.
>
> It should be fine.  You should take into account:
>
> - the endianness produced by pci_data_read/pci_data_write (always little 
> endian)
>
> - the endianness expected by the guest (big endian under the conditions in 
> the patch)
>
> - the endianness expected by memory.c (always little endian, as specified in 
> gt64120_pci_data_ops)
>
> Because there is either zero or one mismatch, bswap32 is fine.

This may worth a comment but I'm still not convinced this works on big 
endian host because I think pci_data_read returns val in host endianness 
and if you want big endian then you only need to bswap on LE host not on 
BE host. Was this tested on BE host and confirmed it works?

Regards,
BALATON Zoltan

> *However*, there is some extra complication that is unnecessary after this 
> patch:
>
> - right now the !(s->regs[GT_PCI0_CMD] & 1) that you have added is dead code: 
> if it was ever 1, gt64120_update_pci_cfgdata_mapping() would pick 
> pci_host_data_ops[1] and gt64120_pci_data_read/write would not run at all!
>
> - but alternatively you could keep that conditional, and get rid completely 
> of gt64120_update_pci_cfgdata_mapping().  Just keep the initialization code
>
>    memory_region_init_io(&phb->data_mem, OBJECT(phb),
>                          &gt64120_pci_data_ops,
>                          s, "pci-conf-data", 4);
>    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
>                                        &phb->data_mem, 1);
>
> at the end of gt64120_realize() where the sister region phb->conf_mem is 
> already being initialized.  This would actually make me happy.
>
> Either way, pci_host_data_be_ops is dead after this patch and you can remove 
> it; and since you are at it, you may also want to remove the wrong comment
>
>    /*
>     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
>     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
>     */
>
> in include/hw/pci-host/dino.h: DINO emulation has *never* used 
> pci_host_data_be_ops.
>
> This has snowballed a bit, but it should not be a problem. :)
>
> Paolo
>
>
--3866299591-438291374-1743171391=:17461--

