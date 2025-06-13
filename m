Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E05C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 08:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ03m-0007i0-Ul; Fri, 13 Jun 2025 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uQ03i-0007hZ-OB
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:46:47 -0400
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com
 ([2a01:111:f403:200a::613]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uQ03g-0007hw-Az
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 04:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL10om2eNkWSlE/z7BO6/74QJ/lL8F+fs4IqCxe+f6fgVZti8yy0lN7mxebTkRXR5+x4/s4i2zzdgAauhu3QwgHn8PlRCOS/3SjqvTZB2t69zKIDKwh3k4dx23rg58g7524onufXcsFw+GngkDFJFCLp3oXB2UypjDoE1WfLx6f/sY0Mo+ydghfk9vERHyt3Gvg+XyO4bulreDv0u9Rj+ROn/NEEeXgw9yDrcg/w5GWPCiVz7vrMv9FoMZDHk6fz9fhH5iKlKjTOuxtzqCbbHEoTqKpvN7dxK7e+zyoSTn7xbdC+FYJOj1DBEXxzxUSUsnGgLclz+a6p34uIzyugrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48UAdqdQ4IuhF1Ja2y3DD8xyZyCAbiIdUPOFhhODc1k=;
 b=WqbILoM9tuA8PuL3zreIizKzn9VlSyD7Ykt35i5DaLX63MnWzlesFMGlLLIqzvM6nfjAG6oY30coepYHlDCmDV3vMoTGkexr3nga6LKS7CaRJozae/R6wBZ0zkY9PfTRBUXHUxu/HXAGH+eGX89nF1HgoPTZDpJPAD8U6ISJh06XiEo5u/4Dxl7QaX/8eFrDgPXBd6KJaibfI3NmUmVp17LwVsDQkGmwxpfNFJSPO+ni1AVGWyP7hMCF/SGbDyoUt8UunEZQYGL9BYP9CNnPQW7F+krnbZfAcMagwGfDww9bmmE2F391D1Y9Vz5oS0LF0yMXm7uvG0MjLqcJzbZONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48UAdqdQ4IuhF1Ja2y3DD8xyZyCAbiIdUPOFhhODc1k=;
 b=L3JYcFAnjsuI8PFeN3TRbi0joVlftCKhYJuBdTuKlkPlY9IR3pwaNpsEDN+j9Znd61ZfOjseeC9PR3IPVVuUmK403+J7WJ1J7P7/jq3aT+C1PgxXaZtL3L/8LrR6p7aC6TUsaIy6Ehna6tmFd6zvOgDvsIll6OSW17Pk0MABMY8=
Received: from DM6PR07CA0130.namprd07.prod.outlook.com (2603:10b6:5:330::22)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 08:46:33 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:330:cafe::54) by DM6PR07CA0130.outlook.office365.com
 (2603:10b6:5:330::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Fri,
 13 Jun 2025 08:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Fri, 13 Jun 2025 08:46:33 +0000
Received: from [10.136.43.217] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 03:46:28 -0500
Message-ID: <f1575acb-31ad-40c8-bf64-e5296812d362@amd.com>
Date: Fri, 13 Jun 2025 14:16:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] amd_iommu: Set all address spaces to default
 translation mode on reset
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-17-alejandro.j.jimenez@oracle.com>
 <6cfb9c54-d7ac-4e4d-9370-b62175f861bc@amd.com>
 <18ca629c-0ac5-4a0f-a88f-92a3afa328ab@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <18ca629c-0ac5-4a0f-a88f-92a3afa328ab@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec57054-2be2-4220-b6c0-08ddaa56cc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01UUnNKWGpvalNjV3Z3TWJubkFuZ2JJRTBhSHMzcmEySytPTnVyNkZaM0Q5?=
 =?utf-8?B?UE5YYS95SHNoR2pPc3VZV1VhUzlqN2QxMGxKOWF3Y3ZpNkpJd28zKzkvc2wr?=
 =?utf-8?B?bmZwMzZRWjdhZ2c4ejdZVjBKc0xLazRtd0kxZzJXWXZEVVNwTTE0YXd3ZU5j?=
 =?utf-8?B?dDkxUDFGdTFMR3AzRHMwQ3VpWThCaHR0V0E2amJHQjdYYkVRSEY3NW1tRnh3?=
 =?utf-8?B?QTZleS83U3Q3aG5rOEtSbjdsdXR5ZVZJWDNPYVZaUWRXK1ROWVFiRmJKeWh5?=
 =?utf-8?B?elpudndDbmNSVTcrMEc5K214dnRMaXYvOXVRVzFtckkvaFNWM2lmVUtneks1?=
 =?utf-8?B?cjJIbWZ4MWZPR25Cek5XQUN6VDhzaStMZGE3cDJHMlcvcnNGMnJYNFFxa2gy?=
 =?utf-8?B?WXhLc3N1M0tIam1Hd2ZDcWtyNlJDeW9BUjVESEl0Tm9XenBrZVk3MTJHRFVF?=
 =?utf-8?B?dlJUSklHZUs1ZExSb2FwVlh5UGJOeGR1T1kveGJwdldxdXBEZ3FwK1VFMEVi?=
 =?utf-8?B?S0FBVzJPVGpsVU1PWmJSNkRTOFZmRHJQNmk5ekJjcyt5UHhOVVFVTyt3c0JK?=
 =?utf-8?B?QXM0ZjhnMjFDc3VPNERTNXYvaXRWcnhsVVAwZnZOWHBhMzJUeWdXaWhJTkl1?=
 =?utf-8?B?bUhQQ2JyUGNITVMrUFBldFgrTWpyNG1seUh0NmFkMlllWnRnZHVZd3BYTjZw?=
 =?utf-8?B?WUEwOFUrRjh0MU05K2V5dnVxY0NXYWRZREdnZVJrWVEzMjNRcDc1OXd1bEJR?=
 =?utf-8?B?TEpLaGV4RzNuVzBObjZwTThlM2o5elpJcnFPUE1RRy9JV2pmMFRPMVNqUHB3?=
 =?utf-8?B?ZS90b0xKMmpFenQ2RkR1MGk2S2xCYzU5SG15bXFDMnk4ejVPT2RaQjZFSUVk?=
 =?utf-8?B?NUJjMVluT3dyVU5BK1c5QmMxVW5ueEVJZ1VZa29NMXVodnE1RThoWmtuZWNp?=
 =?utf-8?B?UEZVNm9Qb2NobkgvcnV2MElOWkdGRHIyWmtxbmpvcmpSeWhndktZMnBUTmhF?=
 =?utf-8?B?NDhKMThhOGg5VVNaZ1pmT0UrR2x3UnhCL2FMa2pyOXZIUTNPS0g1eDlWNmR0?=
 =?utf-8?B?UDdsVERySEhreWROaDQ3ZHBSSVdhS2xMT2lhK2FGbmNBSzhpQ3oxSlphaXNj?=
 =?utf-8?B?ZGV2dU13ZGlsUFRIZFdMK0c2K0VoRXREc3RZSlZxWU9GRXA5MlErZWEzdWMw?=
 =?utf-8?B?MjIzZ25Wak8yM3I1b3pxaE9pdGt4aU5UaHlsdTVRcGlXQmlOYkxyNmhKUXgr?=
 =?utf-8?B?RmJQc0xUNTJxRytjZ25rcFpkM096SkIrRU8zalJaREhGSzR5emdRZmlWUXBq?=
 =?utf-8?B?M0NhM3FHcTVCMGlXZGpxRWtHRmRNM2N3YzBKV3FzeGU4WktMNXREc3hnRXVw?=
 =?utf-8?B?dGgvcG9lQ3VMVTdTckkzbnRnbnVZTmRFWFFKbzE5M1RBWHhRWjVOZHFkVUl4?=
 =?utf-8?B?SWRScXhWWlN1MWFjeEp6UDRLeXNER3EvelFUamN0cEF1ZHg4ZzdCZHhoclVj?=
 =?utf-8?B?V1V5Tk9WTGJ0aG1iSEhmUkx0YVdJelBSQitLb2JuOEFqSjNUOGpKT1I1c0Fo?=
 =?utf-8?B?WmdOaVZIMFNoei80bDJNelVvdW5LYkdVTGo1WDF6VitVUVBZR2U3UlpyRWRp?=
 =?utf-8?B?TXhHY3B0ajhxWHZWVHQ1ZGw5U21LcG1iTVRacjRBMHNHdzFjYk1CRGhmZTRO?=
 =?utf-8?B?ZXlKWVdvUG5qUzBWTExwSnBTeHJhdm9kWXBmQXYwZTdxeWNDZklnWFFCRDZw?=
 =?utf-8?B?blQrNnFnbm1mYlRLV3BaM0VWbXU5bWVaejhzc0xFRVNtZmU3SHg0cEFSTllz?=
 =?utf-8?B?a2J5bjVvY1d4bEFPejBhS1labjRqRmNIK2VFdDhZWUI1eFJ0aXM2OUFQamNS?=
 =?utf-8?B?WmMvQ2kvQnRYME5BQzg1TklZYnlIWXBXNnVRMUExenAxL08xUTFKQmp2Qytu?=
 =?utf-8?B?R0JIcTR5VjU3aUJWM0ZuYjJsNm1XZ1ZqakdyZ3MzNktEbVpDZm5iN3BJbnlW?=
 =?utf-8?B?WXRBTjNTbW12MHE4NDYyOHFnZGpvcnpZa00wai9ROTl2QWlhenFFWUlmbHlC?=
 =?utf-8?Q?gSUjO1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 08:46:33.0357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec57054-2be2-4220-b6c0-08ddaa56cc79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
Received-SPF: permerror client-ip=2a01:111:f403:200a::613;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 5/31/2025 3:00 AM, Alejandro Jimenez wrote:
> Hey Sairaj,
> 
> On 5/29/25 2:16 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
>>> On reset, restore the default address translation mode for all the
>>> address spaces managed by the vIOMMU.
>>>
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>   hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 71018d70dd10..90491367594b 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -962,6 +962,33 @@ static void 
>>> amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>>>       }
>>>   }
>>> +/*
>>> + * For all existing address spaces managed by the IOMMU, enable/ 
>>> disable the
>>> + * corresponding memory regions depending on the address translation 
>>> mode
>>> + * as determined by the global and individual address space settings.
>>> + */
>>> +static void amdvi_switch_address_space_all(AMDVIState *s)
>>> +{
>>> +    AMDVIAddressSpace **iommu_as;
>>> +
>>> +    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
>>> +
>>> +        /* Nothing to do if there are no devices on the current bus */
>>> +        if (!s->address_spaces[bus_num]) {
>>> +            continue;
>>> +        }
>>> +        iommu_as = s->address_spaces[bus_num];
>>> +
>>> +        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
>>> +
>>> +            if (!iommu_as[devfn]) {
>>> +                continue;
>>> +            }
>>> +            amdvi_switch_address_space(iommu_as[devfn]);
>>> +        }
>>> +    }
>>> +}
>>> +
>>>   /* log error without aborting since linux seems to be using 
>>> reserved bits */
>>>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>>>   {
>>> @@ -2199,6 +2226,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>>>       /* Discard all mappings on device reset */
>>>       amdvi_address_space_unmap_all(s);
>>> +    amdvi_switch_address_space_all(s);
>>
>> Hi Alejandro
>>
>> I think amdvi_sysbus_reset should set iommu_as->addr_translation flag to
>> "false" before switching all the address spaces. Without this, the
>> devices will keep using IOMMU address space.
>>
> My first impulse is to agree with you, from the standpoint of 
> considering the no_dma mode as the "default mode", and a reset should 
> bring us back to default. But I wonder that is necessarily the 
> architectural behavior...
> 
> After a reset, in order for any device transactions to be processed, a 
> guest driver must reinitialize the IOMMU data structures, including the 
> Device Table and specifically the table entry for the device. That must 
> trigger a INVAL_DEVTAB_ENTRY that will be intercepted and as- 
>  >addr_translation will be set correctly. If the guest driver doesn't do 
> these operations, then a device won't be able to use the IOMMU because 
> it doesn't have a valid DTE, right? The earlier mappings were already 
> dropped, so it doesn't affect the host.
> 
> Again, I see your point, and making this change is likely the right 
> thing to do, which is why I'll make the change for v3. Just wondering if 
> implementing such behavior is actually architecturally accurate or just 
> the "common sense" approach...
> 
> Thank you for your attention to detail and all the valuable feedback. I 
> will be out next week, and will send v3 once I am back online.
> 
> Alejandro
>

Hey

I tested current patches on OVMF and reboot crashes with IO_PAGE_FAULT
logs on _host_. But setting "addr_translation=false" fixes this crash.

I think the reason is that, kernel does not reset DTE while shutting
down the system. This keeps the stale mappings (IOVA->SPA) still in the
IOMMU and OVMF initiates some DMA operations on device before guest
reboots and sets up the new mappings.

Thanks
Sairaj

>> Regards
>> Sairaj Kodilkar
>>>   }
>>>   static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>>
> 


