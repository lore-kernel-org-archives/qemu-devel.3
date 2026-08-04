Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED58AC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr7O6-0003Gg-2n; Tue, 04 Aug 2026 01:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wr7O3-0003GY-6o
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:08:23 -0400
Received: from mail-westcentralusazon11010043.outbound.protection.outlook.com
 ([40.93.198.43] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wr7O0-0004KY-H6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5KZn6EvYIcf1fpW+1fq2/A1nc5sXMd+PttvJZ8tl853nrP44EH4TvPUDPbpG+ooPbQAfmLGRrVkig1koomREH4k8qlLb+CVgM58vEOgr3KR331G+wXjDvF/kFmV9lIBBTzdk2Tv3YcSEpSS92rMYjcI9QEgx8k/ygwiDYLTXwpiX45vMJwsOy6tg3yQo/orObztY8UR3WdTkv4CpOmrkIWDbj7w3XAyZiSgS8b8X7mQO4I+D2AwJfE29asVzCs7OsSh0a5oqhHwwdLXvuOCKywACLzNwmLMDXt6O11h7EaZkI0oQ0sEK6g/w0L+Uu/vOhndPHHaxlbxg6tkYuVk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/OCBKs9I8RnDruiQ8nyr1/giXnH/9kR4gq5hUPQ9DZ4=;
 b=iBsEDi4euV2E0ydjl4M7/lkMxlOizVBd8gGfyM562a0LT+SYBPGOmgwVPy15pABxORdA9vQKAOCZi+FcSw0U5Kjf6iavFSNiOh7dkvi7MPzgOm7mb/rcWeneCzugwyaWqOBIvrmPY4X2YA01b7/eEoYg/sSgIVAy2VV+97sOr0qO60uTMpvn+mzy9L0R8Y6suT/YFzdJ9siG6diEn2KC7fcinzcxHMMdEZlbN8hZ3dI94p1IZ/cXzluww9UVT70SUAV16KY9WOP41zpBBf/Sl2wAFSvR6NInevrFDPeuVzkHRF5KB4fe2wWyFet3QdEz732dy5PnjaqvgrPvn1EpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/OCBKs9I8RnDruiQ8nyr1/giXnH/9kR4gq5hUPQ9DZ4=;
 b=bsg0CVLOOH/gvHER5Ma2Q3jcrI/JjhIu4Q3KhqbQlyk74tZvIzMjdH4jimUU1DbZxmXNn9EBQ9aJSY9O1wfGV/++gwjX1MhkUdoI48xjXEfnS51ZpZmnJxAGcHAUyHLhYE0uGkKpB+TDldVh8/w36yOw8PRLGvWjcLKWnS7I/DA=
Received: from MN0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::14)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 05:03:11 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::72) by MN0P221CA0026.outlook.office365.com
 (2603:10b6:208:52a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 05:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 05:03:09 +0000
Received: from [10.136.32.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 00:01:59 -0500
Message-ID: <6249e88d-3e8c-41b8-b388-973899f5b58b@amd.com>
Date: Tue, 4 Aug 2026 10:31:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ec162a-86dd-4ea8-0326-08def1e5adbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: zwmIfRYBH8xz0XmJ8L0VQpv2kdmr6gf3n9P5IVBj+IzutxmS91EZL/BW2z0J/1QoLcJRWBRSZ/7KXC5rnMGull5DIDRXUJbW721U990SlIlTriWzCtYBxVTZ8Sxc2sWKHPIt5PgedZQUxgjyx+CyIbPcRMfb25Z3vaM3UnQriyIf+tPELE8E1PvwKkjuZKW4hrMsE/L/5QQ8wR1gL+vSXm7SQH41jdE/LrnFl6h5VpW7ketmIr4Eh42m5kC0XJa49PEPqGD207su+3KwxRl6sRJWj9lecWufxPm5WwOilsQDrH50uEPgpguwbsjMn9criafpini8+rAK5ToGhaDjeLj7Itw2gFZZ/c9GxAZ6+lwndWVW09c1+hTwxihaInxbm/HEJOY3B3hndzfsYs7qfjXlTP4GCs4TCf2MOeeWhAqlm/H6OjLjWQL4/teDM9a+YZJEbJASqfqLV1nVdxfv2n8nleOaVb3z5gXaShamW0vZXxKuX6VXG1nEuMHqaOXKyJyypFA7ZNo9OsHP98ibWOHa4ZCOhlYLEbddhUNsFtd8RSavLgzx/tw7bazBY6QRezqeLS0hgJm24uL6vsNRO7unPUDVj8Noai/gibE9RfJaCzhcxgIOZk15EKnMnZ5TxkqSXOFhq0mJyG1VBTj64C3XwE9xUA7uOliZVxo4uJ2UxhScdFgdEWiaV+VtlgZv+ZlO7H66c7cnVTZ3i0nRoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IFJnO0173u/VB413Nlt0qoXWEK7eF738LRIM6xCefwgFaqbpqvm9zWXvRyI8Bekd4WgPUWXNitbAylq6v8Ay7ZrcyTD9atoXGxp4keqeFBqpF+SsjHdmdxEeiZOk0QyhzXQ/Pu0L2W69HSifZ/7cBRD6Xxx7BlIPTztzoQo6HzR1eqVuw5d5OyprTW4dYEDPkb6F0UwhSgSzQOehtNR0dft5cuE9RlNYPqvg7iTOo2tfeaGogHCd4Ntw3Ehct8/AurYp50NwEORieEyD2M5ZeCuVBDpeegaCxPA8fE0skxARuMlrOJwj+sWfKoECIeS6DnmQFeS2Z5Zw0pNd5guMusGAzDaqoBMhgStzwrEzp5+7AyVf3xCYUXkKWxJDcDwC+9ejR5xioKjHFxWeG88InjJ2fzCWxNAH7PUA7IerNFc4ilVgHcfb0uyZVBlFkQPq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:03:09.7405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ec162a-86dd-4ea8-0326-08def1e5adbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
Received-SPF: permerror client-ip=40.93.198.43; envelope-from=Sairaj.K@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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



On 8/1/2026 3:17 AM, Alejandro Jimenez wrote:
> 
> On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
>> On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote: > On Mon, May 11, 2026 at
>> 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >> Currently, build_amd_iommu()
>> uses "addr" property to build the device ID for >> IOMMU device and
>> advertise it
>>
>>
>> On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
>>> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>>>> Currently, build_amd_iommu() uses "addr" property to build the device ID for
>>>> IOMMU device and advertise it throught IVRS. But this property does not encode
>>>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
>>>> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>
>>> But is this called after firmware has enumerated the pci bus?
>>> And I guess OS better not change that bus number eh?
> 
> The above line sounds fairly threatening :) so I dug a bit more into the
> details.
> Short story: I tested placing the IOMMU behind a PCI bridge, which the
> implementation currently allows, and the guest can (easily) change the bus
> number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS becomes
> incorrect.
> 
> The spec doesn't forbid the above scenario, but "strongly recommends":
> 
> • An IOMMU should be a root-complex device (i.e., appear directly on the
> bus at the top of the PCI tree hierarchy).
> • Some system software may prohibit an IOMMU from appearing under a
> PCI-to-PCI bridge.
> 
> (from Section 4.5 Software and Platform Firmware Implementation Issues)
> 
> While I don't know if that is the case in all HW implementations, my
> Genoa/Zen4 system does follow the recommended topology i.e. it exposes all
> of its 8 IOMMU functions directly on a PCI root bus, with no bridges.
> 
> So I think a reasonable choice is to enforce that an AMDVI-PCI device must
> always be directly attached to a PCI root bus. There is precedent for this
> in the virtio-iommu implementation already, the code change would be
> basically the same in amdvi_pci_realize(), see:
> 
> e72cfabf4ef2 ("hw/virtio/virtio-iommu-pci: Enforce the device is plugged on
> the root bus")
> 
> MST: does this address your concern?
> 
> Sairaj: Am I missing anything, perhaps from your unpublished patches, that
> makes this approach non-viable?

Hi Alejandro,

The Aim of this cleanup is to allow devices and IOMMU isolation under
PCI-PXB and PCI-ROOT-PORT in future patches. Please see patches at [1]
for more information.

Examples
--------
Example1, For below PCI configuration AMD IOMMU 1 will serve all the
devices under pxb-pci1 and AMD IOMMU 2 will serve all the devices under
pxb-pci2.

pcie.0 -+- pxb-pci1 -+- pcie-root-port1.1 --- AMD IOMMU 1
        |            +- pcie-root-port1.2 --- Device1
        |            \- pcie-root-port1.3 --- Device2
        \- pxb-pci2 -+- pcie-root-port2.1 --- AMD IOMMU 2
                     +- pcie-root-port2.2 --- Device3
                     \- pcie-root-port2.3 --- Device4

Example2, For below PCI configuration, AMD IOMMU 3 will only serve
Device5 and Device6 and devices under pxb-pci buses will be served by
IOMMUs of respective buses.

pcie.0 -+- pxb-pci1 -+- pcie-root-port1.1 --- AMD IOMMU 1
        |            +- pcie-root-port1.2 --- Device1
        |            \- pcie-root-port1.3 --- Device2
        +- pxb-pci2 -+- pcie-root-port2.1 --- AMD IOMMU 2
        |            +- pcie-root-port2.2 --- Device3
        |            \- pcie-root-port2.3 --- Device4
        +--- AMD IOMMU 3
        +--- Device5
        \--- Device6

Example3, The below PCI configuration is invalid since both IOMMUs share
same root bus i.e. pxb-pci1.

pcie.0 -+- pxb-pci1 -+- pcie-root-port1 --- AMD IOMMU 1
                     +- pcie-root-port2 --- AMD IOMMU 2
                     +- pcie-root-port3 --- Device2
                     \- pcie-root-port4 --- Device3
----

Hardware vIOMMU requires this isolation since it does not support
emulated devices (due to accelerated MMIO region). Enforcing IOMMU on
pcie.0 will not work for vIOMMU.

Furthurmore, we need multiple hw-vIOMMUs when vfio devices do not share
host IOMMUs (one hw-vIOMMU device for each host IOMMU)

Considering above facts, we cannot enforce pcie.0 for the IOMMU, but
future patches ensure that IOMMU is attached to a PCI root port.

Also, Outline for vIOMMU developement will be as follow
1. IVRS cleanup
2. IOMMU PCI bus isolation support
3. Multiple vIOMMU support
4. New vIOMMU model (-device amd-viommu)

@Alejandro, does this answer your question ? or let me know if you need
an overview of upcoming changes to evaluate this

[1] https://github.com/AMDESE/qemu-iommu/tree/wip/amd-viommu_20260728

Thanks
Sairaj

> 
> Thank you,
> Alejandro
> 
>>
>> Hi Michael
>>
>> Yes, the ACPI function is called two times -- during qemu initialization
>> and firmware writes. During first call, bus numbers are 0 and during
>> second call, IVRS is created with bus number. This second IVRS
>> overwrites the first one.
>>
>> Thanks
>> Sairaj
>>
>>>> ---
>>>>  hw/i386/acpi-build.c | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>> index e4ad01eec037..718e3f546b18 100644
>>>> --- a/hw/i386/acpi-build.c
>>>> +++ b/hw/i386/acpi-build.c
>>>> @@ -1752,10 +1752,13 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>>>                  const char *oem_table_id)
>>>>  {
>>>>      AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
>>>> +    PCIDevice *iommu_dev = &(s->pci->dev);
>>>>      GArray *ivhd_blob = g_array_new(false, true, 1);
>>>>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>>>>                          .oem_table_id = oem_table_id };
>>>>      uint64_t feature_report;
>>>> +    int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
>>>> +    uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
>>>>  
>>>>      acpi_table_begin(&table, table_data);
>>>>      /* IVinfo - IO virtualization information common to all
>>>> @@ -1816,9 +1819,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>>>      /* IVHD length */
>>>>      build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>>>>      /* DeviceID */
>>>> -    build_append_int_noprefix(table_data,
>>>> -                              object_property_get_int(OBJECT(s->pci), "addr",
>>>> -                                                      &error_abort), 2);
>>>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>>>      /* Capability offset */
>>>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>>>      /* IOMMU base address */
>>>> @@ -1850,10 +1851,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>>>  
>>>>      /* IVHD length */
>>>>      build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>>>> +
>>>>      /* DeviceID */
>>>> -    build_append_int_noprefix(table_data,
>>>> -                              object_property_get_int(OBJECT(s->pci), "addr",
>>>> -                                                      &error_abort), 2);
>>>> +    build_append_int_noprefix(table_data, iommu_devid, 2);
>>>>      /* Capability offset */
>>>>      build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>>>>      /* IOMMU base address */
>>>> -- 
>>>> 2.34.1
>>>
>>
> 


