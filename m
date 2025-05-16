Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18007C3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFsZP-0000Q1-Jb; Fri, 16 May 2025 06:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFsZM-0000Lx-Jc
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:45:36 -0400
Received: from mail-bn1nam02on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61b]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFsZJ-0002oG-Ad
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:45:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIO/hHwoVz67nSVYxaGHkk+p1zFQzbx7mLamicXlpIgWvyxAfSui41N/N02nCa2aikOenZ/058MAsDxujNgZgmWJH2+ondyPDD9fHge0x4FVTNLaGC57DdyYaMcGdHeQYTM2RrloKDgYCCW1zUgfcynGvbssQgkYBrHpr+UxT18Yj7r0eRVEqF7rEx+ATrNvb8sQKYjsRgz2RO5ffVY+rvjMpigVTNSILPxehG8y/wCP191trpHkj+NKif2IAwkGHQi9FUKgnQP4iwSNB696pRgU1hL41DOI5YTeoXwGAqqh6hyNz44h3z1LovFlbUhtswc+gdtIF26gQF4AD79aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dOn/ujDDcMIdFH8RNd1rlyX7XgvBpl9Husa3nYS2dk=;
 b=YQqbd20XucW5eMxh06vyu+26ykh/EUcnHOqs8wyeH9dyEfqMTR3XAdkARINH9inMNi/RrepDT8y4dvWSmqrHvYlVBvjGqv1rQoldycVjvuU8M+8rhck/xHTvrFOrUlR7/7427qmxIczRxWE7fASs1VD+nviP7MltCgE/8tChxjQhkSNX0xZsz5yaSgEOg6+UEMenkjOIWFhAYx3qf5FTmij525hH5i+1JATx+mO6LDJOrRAHQ+GQpKfoywo+obNiRY1HA41HC7E7cIR2aqiKEOkvieWfBqAs6ttZHp+WAoj9xE8/rCF3gJw+vJJqF1mACyy2djhN43xFIqkykTD4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dOn/ujDDcMIdFH8RNd1rlyX7XgvBpl9Husa3nYS2dk=;
 b=hraiD/4rfuvfwvvwfnEdRcrCPlAX3Pk64y4MvZaMg6O7KDX0QVOJ4BYVV492aSzRBeC8kSAwFXrmuUMYu1PguPx/13Jfixrm40FDGmS/UdfhF/yK856onGL7xOE/jRnmlchEILCOomQMFDyqzHI/4H+elluND7aEYF40hDfSFg8=
Received: from BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) by
 SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 10:45:26 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::a9) by BL0PR0102CA0035.outlook.office365.com
 (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 16 May 2025 10:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:45:25 +0000
Received: from [10.136.37.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:45:23 -0500
Message-ID: <20140492-6040-4010-9b85-da160f06dbca@amd.com>
Date: Fri, 16 May 2025 16:15:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] amd_iommu: Fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <marcel.apfelbaum@gmail.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>
References: <20250516100535.4980-1-sarunkod@amd.com>
 <20250516063605-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250516063605-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff2fb61-20d9-4dd2-490f-08dd9466c479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW1NTnVCYkp3WkwxcFFCeEZXUTEwTmhmUEp0WllyRzVOOEw4ZEs4RjhidzdZ?=
 =?utf-8?B?NVZPL0JHZ1NtczVlaTNxTzZiQk0xNm5VSUp4UkdYdFdtTG9jTFdCcC9saUtR?=
 =?utf-8?B?Z0Zsc3N0MTd2RWFtRXllL0ZRaEc5c0VXWFZmSDcrUCtBTXdsU0RiM2o5ME9v?=
 =?utf-8?B?eTZ2dG13ekdTUzVPVmVsTVhYWTRvUEFVOGVrT2RpYlZIU1A4TmYycTV4dFJu?=
 =?utf-8?B?Y0RTdzByODNSOVpjV2JlY3JvZ2xScHhDTmlkUzJSc0laMG5WNlQySWFCVE9u?=
 =?utf-8?B?VWY0RWgrWVNUZUpTY0ZsdkFFK1J0VFp3YzFJV01FWG1XUE8vQmNDb1JYOFd6?=
 =?utf-8?B?WHd5K3BKNUh1dndWTzMwdzMzdnhYWXZFWE16ZDF3VFVpdTlMTi9TRXhnNjls?=
 =?utf-8?B?a3pjN2M1aXZiNkJHNFFjdis5NnNLdUMyQ2NyMHAyVlBYWW04alJLVHdwdXB5?=
 =?utf-8?B?WXRuTEg1QmN1YTgwNmN5WWtGcFhQYmd1UVJDZWE1R0NWVDlEREFSSDRGNXJV?=
 =?utf-8?B?bGxockJxZG16WWViT2FPdW5yeHRNUktldEhPZEVWZlpFekVhRFlCOExpM0tB?=
 =?utf-8?B?VmcraWR0UC9qb3ZuUjRvVDVPcHN1MFVlazhDMXZ1TlZxbXRVRktFMkM1Wnk1?=
 =?utf-8?B?U2hvMmV1ODUwaEFpbm9seEhKNkZvNFlzUVRlVC8wcG1MWDV6Tm1GNExqL2xa?=
 =?utf-8?B?VFJtZmROOGprYkhDTkpCR0hOeDVWU2hvWEw5NW5xR3hOb29LenBYRStsTHd2?=
 =?utf-8?B?T3IxVHZZTStJZWIrTGd1NGF5Yk1UdHRnOWJDbTEvSjY4eWkxeHdFVXJOS2VO?=
 =?utf-8?B?SU92UzNablhZQ0lvQTU4WnRLNE5QaUtlOEt3RTBzRDhQQW1yRzNTdGUwaU1k?=
 =?utf-8?B?L0w5M0RITzhicGZSaVhTMDVyUitOYnAwVDF6NmJ0b3hCWkdNTlA2ZmlwWlQ3?=
 =?utf-8?B?T2ZzaW5BTjRDZUJSd05udVRDWENRR2xHWlpxcDF0MDhLSkYzU2dKWm5ZcVd6?=
 =?utf-8?B?M1ZuSHB4aEJDVml5ZXBYVHE0elN5bW91a29KdkQ4a3JrbEpuVEt0WmtHK1ZR?=
 =?utf-8?B?VVZzbFN5bkdVdjQvSit5Zzl1cGU4cFVMNUhDV21vNVEyUW1acVZUNTJkV2Jj?=
 =?utf-8?B?UmxLZUYxUWhmb3VneW52VDRvMWNzRUEyVlJtbyt5SGpRV3ZsWEM0aDN1Rnpv?=
 =?utf-8?B?MGZJTWFLZkZjWVFRZjR5OGg4OWtURnBNUHJKby91VXhaVHJWUGJPb3lYOUVN?=
 =?utf-8?B?d3pUSlNkUFV2NjgvRGtuSFZDVVBYdUJBQXFxTm4rQW5MdmVWck15QTVtTUkv?=
 =?utf-8?B?UW5EcDRybzAvbWF5UDF5WFpYUDRkNTJaeHRXR1NZbTMzWkhRWURWZ3RuN2t4?=
 =?utf-8?B?YWlRQUkrc1RtL25RZTBObVNBa2lRVzNOWTdYMHdnNHp4Z1hCNWZmS1dVUnh3?=
 =?utf-8?B?dlVqQlliSmNMa1NocVhWL290MmZJbGh2ajhRSFdKKytWUTlRNEhXRE9aOEgw?=
 =?utf-8?B?NmJFNkFPMnVoQ3hpa2J6U2pOaUF1bWJhcnNiYUttb0ttS2wwQ2pNOWtYb3U4?=
 =?utf-8?B?Uk4yUHNlYURWd2VoYmZKTk5pR2dJOUorVDhvenRPLzFnT3hVRnNEMDBNd3pt?=
 =?utf-8?B?RUpMMk1aakdzQXN6UEw1TkRFMnBHYkZFdXZyMi8wNU1VNFVHQStaRHNRWHYr?=
 =?utf-8?B?V1hlOVJUTG9UNldLOEJrV3NWR0hrT0tEMTR2UXFvZkV4WHg1Q0NWcjc2YUlM?=
 =?utf-8?B?YVlmUzRwRGZxMVZrc0J2enB5cXE5RmRrakUvckV5UWRid2x1dXVnZ1A5V2FK?=
 =?utf-8?B?N1Nma0RLQjVFUlpuQlI5OFNWL1FUZU0rTDNzNzFBeFpYUjZYM01xNnFCc2xu?=
 =?utf-8?B?c2l1V0pUN3hwTEU1b3hSNXFOVlp1cmlBUUJNOGZXemFEOEpkcmdubVRjcjFq?=
 =?utf-8?B?dGxhQ3lDNmNsajE0WVQ3M0VNS3NWSTQrY1hVdVgyRUdURHRxRG5yU3kvR1Fz?=
 =?utf-8?B?UllQbm9mSmsyQ1ZaSWszamZDYW5pVFhTQThRc1lQL0VHRWFaTXlxeERGajRi?=
 =?utf-8?B?dEUwdFVqR3B5aW1leEIzYVdaTTc4dkFtU01Idz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:45:25.9898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2fb61-20d9-4dd2-490f-08dd9466c479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
Received-SPF: permerror client-ip=2a01:111:f403:2407::61b;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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



On 5/16/2025 4:06 PM, Michael S. Tsirkin wrote:
> On Fri, May 16, 2025 at 03:35:33PM +0530, Sairaj Kodilkar wrote:
>> Fix following two issues in the amd viommu
>> 1. The guest fails to setup the passthrough device when for following setup
>>     because amd iommu enables the no DMA memory region even when guest is
>>     using DMA remapping mode.
>>
>>      -device amd-iommu,intremap=on,xtsup=on,pt=on \
>>      -device vfio-pci,host=<DEVID> \
>>
>>      and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
>>
>>      which will cause failures from QEMU:
>>
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>      qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>>      qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>>
>>
>> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
>>     does not enable x2apic mode.
>>
>> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
>>
>> Sairaj Kodilkar (1):
>>    hw/i386/amd_iommu: Fix device setup failure when PT is on.
>>
>> Vasant Hegde (1):
>>    hw/i386/amd_iommu: Fix xtsup when vcpus < 255
>>
>>   hw/i386/amd_iommu.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> changelog?
> 

Sorry I forgot to update the cover-letter (Rookie mistake).

Changes Since v2:
Patch 1: Updated commit message [mst]
Patch 2: Updated commit message [mst]
v2: 
https://lore.kernel.org/qemu-devel/20250509064526.15500-1-sarunkod@amd.com/

Changes Since v1:
Patch 1: Updated commit message [Alejandro]
Patch 2: None
v1: 
https://lore.kernel.org/qemu-devel/20250410064447.29583-1-sarunkod@amd.com/

Regards
Sairaj Kodilkar
>> -- 
>> 2.34.1
> 


