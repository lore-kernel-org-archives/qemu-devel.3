Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402DCCCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 06:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5efi-0007rA-Tz; Mon, 06 Oct 2025 02:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v5eff-0007q1-3h
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:26:07 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v5efd-0003vg-02
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbiMKxY18e966mJ4FqXa7IyMx0QPI9zF4e9G5gQ6m+LS6gi7bYYD6syamH0p+3R5AF/LolaU95Xw4EAcGXCEy5M4NcHKUdXI7eiUQxipVyMA0eLBwsqY0te4r9gZSTlacmfnDAikAi+Xxgw3vkDsvDcQRaJeHhoEuJfI4UJ+S4g+qNCuO1WwJXtGY2A4/iy9IX3452tEeGyUeN224j8Y5Q+XjoJcoZxTdx83TXaxCs/+Ikayi/1tb7HfTrXlTuonywjEb7BAj6Fhc6h5W5w75PWYsyEI6NacP5G1Sc/XpXSDgMNrnUQApGhyk/Q2pmjSKUh62ysDHdVpsdv3TfDc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up1xMGI65DrR05TBoZY9V+V/O2T/VlNtJOdCvSaKgZ8=;
 b=CegAYhhrQOni8qoWMBeDag51YcRkhbsPzlvqf4mC445hdVPiYyWGT+l5VY7PBAjW7EXbIf3xqcss+IRTuTrY93b+2Hxh7/tD7Y2k7dd5PYUcrpklkG5mvoqm6GKn/if1eafn+W9T7PQVCMBl7gpmSExmWp1tGapxwmmb1QNim+clxnrGM0uhywFLAfk1O6vpapjhhSI6ZNPvecz5Jt5SpsO+qZWuW6LXp8sBwPuDoHRjyiigg4cctCCqlFAk38BgMgtWdADRb6QPfaTttWN5Ll8NuR9e8JEcgbBI2ioRw7K95V35e3bPawocO4jVavukMBilC6SXXaXov4P9qehDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up1xMGI65DrR05TBoZY9V+V/O2T/VlNtJOdCvSaKgZ8=;
 b=CTf4EmsPPgk2HQCyaEEAd5aYODKg5zD+cRAO7qVnhTKO33yTQoeZZte90osOrdije42txPpPb0ci1+Cu08/U0dR2Ol2uebnHUTlvfRNNoiq9rh0VxJhLxqkdxYsjita2hBemI+NHwxp+zs2hM0K1fCj3ObBH9b06rxxpKJ4bJAk=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 06:25:53 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::87) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 06:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 06:25:53 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 5 Oct
 2025 23:25:44 -0700
Message-ID: <37ebf4e6-5127-4e59-a990-905ac3342c3b@amd.com>
Date: Mon, 6 Oct 2025 11:55:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/22] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 <qemu-devel@nongnu.org>, <clement.mathieu--drif@eviden.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <peterx@redhat.com>, <david@redhat.com>, <philmd@linaro.org>,
 <marcel.apfelbaum@gmail.com>, <alex.williamson@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <Ankit.Soni@amd.com>, <ethan.milon@eviden.com>,
 <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
 <4856d645-ad17-4660-8012-3d315e56a463@amd.com>
 <20251006021525-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251006021525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc61f50-6487-48d1-642c-08de04a1335f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Szk3a3JmcytGSzc3Sk0vZ05ySGZXWE1WQk9GaEtOS2R0SGhSRzBWMmMxYk1u?=
 =?utf-8?B?Q1dnZFFMdWVQRDhmSFRrWjc1L2tZODIrS2t2ZUxRYzVGWEk3WmhtbUhSczV6?=
 =?utf-8?B?NXdTbHJZRURpb2FUU0J6bDQ3Q2U3dGhkRmZ3VEVLd0ZOeDMxcW5VRjBSQzBk?=
 =?utf-8?B?UEV2L0hNM0N1cklRWTBUL3RoSlRlMm1xQnEvTU5KQnY5UXRJS002WTcrOWRJ?=
 =?utf-8?B?QzZ4bVYxMlVBNXZER05aWkVTM2V5dk5tWnc0bCthR2ZuUERVbXF5a3hqb2JB?=
 =?utf-8?B?YjE3eE1kRXBLaXpFQ3RKUmczaUc3czBvTklWWFpZUnlDRlpMYUkrOFB1a2dl?=
 =?utf-8?B?eEdzZVpFTXBlTUxiQmZ1NlQ0cDZWZVZvR0NqV1dRNUpTK3Z6L3l6UFh5UmdJ?=
 =?utf-8?B?UFh5MXd6U3dsVzFibTQwY0ViVXhWOWN6c2MyNGRUc3hkajdPQnRnU25HNlph?=
 =?utf-8?B?NVdWQzMvdTEvK3lXdjRmSTJpRXZ4WkdDT2MwVGx4RWxvdTFGd3BPMkZFN0I0?=
 =?utf-8?B?QlNVdXBySkF2RFBydWVDOHFrK0pTMDdzL1hqVlRLMHByZFdQaGZ3MG1XS09r?=
 =?utf-8?B?eTdwQlI1RzM1amluc1pWRnBJaUMvWTZOQjd4c2FsRWNkMnQ1RnhzR1RTNGQw?=
 =?utf-8?B?VnJtY3BVZWNJS0UrYkt1MFRaSVZIV3RueFgwd3NwZ0pvMkpWTUpjd09IWk51?=
 =?utf-8?B?S1ZMazFqdGF4N2x5MnZMYUs1akFlU2ZIcEF3K29HMFc4VXpuYlFNYTdVVVdj?=
 =?utf-8?B?dWMrdjlLdDduNVlZTkNNSXRXSG00TGtOM2sxZVJsYzlqUlpuT0J6b0VNdzNw?=
 =?utf-8?B?TEtjWEhRcG8rTUxOZkMxeG1ETFk5UDBielF5NU55c1N1cXFuSW9GKzlJR0JE?=
 =?utf-8?B?TXM3NmVSZmw4U21nU0lkUEVHUnl5OWY0QTRCNVJGaEV0ZVVkQjdzU1hQdEth?=
 =?utf-8?B?YVRZY0RQblVLM0RrblFMWGJGVkhXYWxlVHAzMk1DL1dic3AwVlc0SUNGaW1i?=
 =?utf-8?B?YkJnMmEyN3pmWWtwTG9SZnBhQkFrUCtPOXVzdmxDSlpZMjRyazBTRitIM0Nt?=
 =?utf-8?B?L2I2NXZmalpzTmc3b2tkRDV3VWc2bmdLRTB6VmFvY1ZqdjRNOEhxY2NXdHZt?=
 =?utf-8?B?Qmg0bzdhTFNKODcxcDFkQmRyWVV6TC9PUUNhRmtnSC95TVNPODFhQTJqby9o?=
 =?utf-8?B?YVcwY1VPTmxOd0VJYitIL3lpSTZ4OXBheDFLblljYXF2QUZnYTBtdThMM0g0?=
 =?utf-8?B?Vm1wZ2NVZ1VnUnpybVBNc3F6bkREcktia2RwWHRCS3JNZ3dKZ2V0SnR3Y2pL?=
 =?utf-8?B?bm9maGFnRThZMVM2V0FGMlZVRk5oV2VyMFZKSnk2S0cySnVVTzhiTXpKVEo1?=
 =?utf-8?B?NnJERHhhYU5XaEpmYVU2MWEvc2VKUXBTalQ1SWQ2OHQzTDBSb0I3ckg1bCsy?=
 =?utf-8?B?K05NMHV2WDk0ZHdVTE1tTFBpSjJ0Z0hwMHd5M0FYeDdGNDI4a1FrMFlsbG5B?=
 =?utf-8?B?VGEzczMyWW5kc0NvdjJMWFNtemVkMmFRYWVkUXRpTnQxRzBUYkEyZFB4R29H?=
 =?utf-8?B?WlpmbXg0YmVJLzZHL0NyYUMycFJLVzdXQXpGdHpTTkFkbDgwOFhta0JMVXN1?=
 =?utf-8?B?VlZDNlBTd2pxUmY5ekF4bGt3U2dDQXYwTDhEK3ZPSko1OGRhbUtJZlREUTNZ?=
 =?utf-8?B?UkdNdmlsMExEZTF1SzJLUzN5Tm9xVHo3a1NvZ1ZWWmtnQndhOVpySWhUcXhG?=
 =?utf-8?B?dlhDenR4RGVNMTFOVnI5bmw3VUdIMjJpVURKYzBzR2o4a3NURWpxc0s3SGhQ?=
 =?utf-8?B?MHNBamFRRmwvZzVOL0RXTUdUVFJZM1M5SlVldi9teERlMkZ2bzNlMEVtQ1BG?=
 =?utf-8?B?bE5BU0szdGRDd1RlbDVmMHI4c3JaNDRvdFlKZ0Z2eVJlNmU3dTIrUVp6dkFX?=
 =?utf-8?B?dkdDdUtERUV4emJiWS9NSktNbWVmZ1RYaHpxL1V3S3BnRXl3L0hUd1p3RXV5?=
 =?utf-8?B?ZDYxY29GN0k0d2EwcDRSZG5QWDhLNXVkVkdIaFV4QjNqVGNMS2xLdnF0eXA1?=
 =?utf-8?B?YVBXQmRHK1lqbjNIa0d2aHc4MmQxM2xpUzV6Z05QYlpIbUJCRzRNU3VNZjJL?=
 =?utf-8?Q?fsMk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 06:25:53.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc61f50-6487-48d1-642c-08de04a1335f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/6/2025 11:45 AM, Michael S. Tsirkin wrote:
> On Mon, Oct 06, 2025 at 11:38:28AM +0530, Sairaj Kodilkar wrote:
>>
>> On 9/20/2025 3:05 AM, Alejandro Jimenez wrote:
>>> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
>>> Device Table entry (DTE) e.g. after attaching a device and setting up its
>>> DTE. When intercepting this event, determine if the DTE has been configured
>>> for paging or not, and toggle the appropriate memory regions to allow DMA
>>> address translation for the address space if needed. Requires dma-remap=on.
>>>
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>    hw/i386/amd_iommu.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 120 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index ce5d4c36624fd..e916dcb2be381 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -1032,18 +1032,136 @@ static void amdvi_reset_address_translation_all(AMDVIState *s)
>>>        }
>>>    }
>>> +static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
>>> +{
>>> +    /*
>>> +     * When enabling DMA mode for the purpose of isolating guest devices on
>>> +     * a failure to retrieve or invalid DTE, all existing mappings must be
>>> +     * dropped.
>>> +     */
>>> +    if (inval_current) {
>>> +        IOMMUNotifier *n;
>>> +        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
>>> +            amdvi_address_space_unmap(as, n);
>>> +        }
>>> +    }
>>> +
>>> +    if (as->addr_translation) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* Installing DTE enabling translation, activate region */
>>> +    as->addr_translation = true;
>>> +    amdvi_switch_address_space(as);
>>> +    /* Sync shadow page tables */
>>> +    amdvi_address_space_sync(as);
>> Hi Alejandro,
>> I think we can skip amdvi_address_space_sync, because
>> amdvi_switch_address_space will trigger
>> amdvi_iommu_replay. this replay should unmap all the old mappings and sync
>> shadow page table.
>>
>> Thanks
>> Sairaj
> Well I queued this but this speedup can be done on top.
Sorry for the delay in reviewing, I was on vacation for 2 weeks.
I have reviewed all the patches.

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>Thanks Sairaj

