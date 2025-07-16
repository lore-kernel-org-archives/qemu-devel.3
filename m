Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2666C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 00:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubqP9-0003px-SH; Tue, 15 Jul 2025 20:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ubqNd-0002kb-1t; Tue, 15 Jul 2025 20:52:17 -0400
Received: from [115.124.28.3] (helo=out28-3.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangzhijie@bosc.ac.cn>)
 id 1ubqNZ-0007h1-Ut; Tue, 15 Jul 2025 20:52:16 -0400
Received: from 172.38.29.107(mailfrom:zhangzhijie@bosc.ac.cn
 fp:SMTPD_---.dntdz11_1752626868 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 16 Jul 2025 08:47:49 +0800
Message-ID: <b8cbd539-998b-4faf-90d8-b6af9ecdb148@bosc.ac.cn>
Date: Wed, 16 Jul 2025 08:47:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: zhangzhijie <zhangzhijie@bosc.ac.cn>
Subject: Re: [PATCH v1] hw/pci-host/designware: Support 64Bit resource for
 DesignwarePCIEHost
To: Peter Maydell <peter.maydell@linaro.org>
Cc: wangran@bosc.ac.cn, zhangjian@bosc.ac.cn, andrew.smirnov@gmail.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250715073251.2376473-1-zhangzhijie@bosc.ac.cn>
 <CAFEAcA_Vfrc7Riz-GguzdRHXaeNYBW6_MM3UQp9S6-TWNqgEhA@mail.gmail.com>
In-Reply-To: <CAFEAcA_Vfrc7Riz-GguzdRHXaeNYBW6_MM3UQp9S6-TWNqgEhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.3 (deferred)
Received-SPF: pass client-ip=115.124.28.3; envelope-from=zhangzhijie@bosc.ac.cn;
 helo=out28-3.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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



在 2025/7/15 16:57, Peter Maydell 写道:
> On Tue, 15 Jul 2025 at 08:33, zhangzhijie <zhangzhijie@bosc.ac.cn> wrote:
>>
>> 0. DW pcie support 64bit resource
>> 1. DW version type using Linux kernel
>>
>> Signed-off-by: zhangzhijie <zhangzhijie@bosc.ac.cn>
>> ---
>>   hw/pci-host/designware.c         | 12 +++++++++---
>>   include/hw/pci-host/designware.h |  2 +-
>>   2 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index f6e49ce9b8..99d791c0a7 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -41,6 +41,8 @@
>>   #define DESIGNWARE_PCIE_MSI_INTR0_ENABLE           0x828
>>   #define DESIGNWARE_PCIE_MSI_INTR0_MASK             0x82C
>>   #define DESIGNWARE_PCIE_MSI_INTR0_STATUS           0x830
>> +#define PCIE_VERSION_NUMBER                        0x8F8
>> +#define PCIE_VERSION_TYPE                          0x8FC
>>   #define DESIGNWARE_PCIE_ATU_VIEWPORT               0x900
>>   #define DESIGNWARE_PCIE_ATU_REGION_INBOUND         BIT(31)
>>   #define DESIGNWARE_PCIE_ATU_CR1                    0x904
>> @@ -144,6 +146,10 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
>>       uint32_t val;
>>
>>       switch (address) {
>> +    case PCIE_VERSION_NUMBER:
>> +    case PCIE_VERSION_TYPE:
>> +        val = 0x3534302a;
> 
> What is this magic number ?
> 

Fount this magic number at Linux Kernel Driver:
	drivers/pci/controller/dwc/pcie-designware.h

Using thismagic number will allow Linux driver using larger than 
u32_max(4GB) resources . But I am not take tests for imx.6/imx.7
>> +        break;
>>       case DESIGNWARE_PCIE_PORT_LINK_CONTROL:
>>           /*
>>            * Linux guest uses this register only to configure number of
>> @@ -427,7 +433,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = true;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = UINT64_MAX;
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>
>>           source      = &host->pci.address_space_root;
>> @@ -451,7 +457,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>>           viewport->inbound = false;
>>           viewport->base    = 0x0000000000000000ULL;
>>           viewport->target  = 0x0000000000000000ULL;
>> -        viewport->limit   = UINT32_MAX;
>> +        viewport->limit   = UINT64_MAX;
>>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>>
>>           destination = &host->pci.memory;
>> @@ -558,7 +564,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT64(base, DesignwarePCIEViewport),
>>           VMSTATE_UINT64(target, DesignwarePCIEViewport),
>> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
>> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),
>>           VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>>           VMSTATE_END_OF_LIST()
>>       }
> 
> This breaks migration compatibility. Depending on which boards
> use this you might either need to just bump the version numbers,
> or else do something more elaborate to ensure migration compat.
> 
could I found that if the Uint64 type is used, it can be compatible with 
scenarios where uint32 was originally used?
>> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
>> index a35a3bd06c..6e06f54801 100644
>> --- a/include/hw/pci-host/designware.h
>> +++ b/include/hw/pci-host/designware.h
>> @@ -46,7 +46,7 @@ typedef struct DesignwarePCIEViewport {
>>
>>       uint64_t base;
>>       uint64_t target;
>> -    uint32_t limit;
>> +    uint64_t limit;
>>       uint32_t cr[2];
> 
> Last time that something related to this pci controller
> and the size of this limit came up, this appeared to be
> something that differed between different versions of the
> hardware. See discussions on the thread in
> 
> https://lore.kernel.org/qemu-devel/CAFEAcA_x4CyQ0wF7-x-4oq4OUYsuJcbL3xLrz3D0cmWYmfs75w@mail.gmail.com/
> 
> Maybe we need to model both, with a device property to
> select which one?
> 
Could understand to "set magic-number and using magic number to select 
VMStateDescription_u32 or VMStateDescription_u64  "  ?
> thanks
> -- PMM

Best Regards.
ZhiJie

