Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C08AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txuBy-0000Sw-6M; Thu, 27 Mar 2025 16:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1txuBw-0000Sd-67
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 16:51:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1txuBs-0006J7-Uc
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 16:51:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CFBEA4E6000;
 Thu, 27 Mar 2025 21:50:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id knUN5aiZpAcn; Thu, 27 Mar 2025 21:50:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9765A4E601D; Thu, 27 Mar 2025 21:50:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 953C274577C;
 Thu, 27 Mar 2025 21:50:56 +0100 (CET)
Date: Thu, 27 Mar 2025 21:50:56 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: rakeshj <rakeshjb010@gmail.com>
cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org, 
 thuth@redhat.com
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
In-Reply-To: <20250327153627.307040-1-rakeshjb010@gmail.com>
Message-ID: <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
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

On Thu, 27 Mar 2025, rakeshj wrote:
> The GT-64120 PCI controller requires special handling where:
> 1. Host bridge (device 0) must use native endianness
> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>
> Previous implementation accidentally swapped all accesses, breaking
> host bridge detection (lspci -d 11ab:4620). This fix:
>
> - Adds device filtering via (phb->config_reg & 0x00FFF800)
> - Preserves native endianness for host bridge
> - Maintains swapping for other devices in big-endian mode
>
> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
> Signed-off-by: rakeshj <rakeshjb010@gmail.com>
> ---
> hw/pci-host/gt64120.c | 37 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
> index d5c13a89b6..098f8e5988 100644
> --- a/hw/pci-host/gt64120.c
> +++ b/hw/pci-host/gt64120.c
> @@ -320,11 +320,46 @@ static void gt64120_isd_mapping(GT64120State *s)
>     memory_region_transaction_commit();
> }
>
> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    GT64120State *s = opaque;
> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
> +
> +    /* Only swap for non-bridge devices in big-endian mode */
> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
> +        val = bswap32(val);

I don't know if this is the best way to fix this issue as I don't know 
what the issue is in the first place (isn't PCI usually little endian?) 
but I think you can't just use bswap here because it also needs to take 
into account the endianness of the host QEMU is running on. So most likely 
you need le32_to_cpu or be32_to_cpu or similar here as you're converting a 
value with known endianness to a variable that is in host endian and the 
*_to_cpu functions are for that. But I could be wrong, these endianness 
issues are quite confusing. It's best if you can test on both LE and BE 
host.

Regards,
BALATON Zoltan

> +    }
> +    return val;
> +}
> +
> +static void gt64120_pci_data_write(void *opaque, hwaddr addr,
> +    uint64_t val, unsigned size)
> +{
> +    GT64120State *s = opaque;
> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
> +        val = bswap32(val);
> +    }
> +    if (phb->config_reg & (1u << 31))
> +        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
> +}
> +
> +static const MemoryRegionOps gt64120_pci_data_ops = {
> +    .read = gt64120_pci_data_read,
> +    .write = gt64120_pci_data_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
> {
>     /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 0xc00 */
>     static const MemoryRegionOps *pci_host_data_ops[] = {
> -        &pci_host_data_be_ops, &pci_host_data_le_ops
> +        &gt64120_pci_data_ops, &pci_host_data_le_ops
>     };
>     PCIHostState *phb = PCI_HOST_BRIDGE(s);
>
>

