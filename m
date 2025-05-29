Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519F4C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 06:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKWeK-0003pI-2A; Thu, 29 May 2025 02:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uKWeH-0003p1-PK
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:21:53 -0400
Received: from mail-dm6nam04on2062.outbound.protection.outlook.com
 ([40.107.102.62] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uKWeC-0007Bk-TN
 for qemu-devel@nongnu.org; Thu, 29 May 2025 02:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMgb6hcybf76BeLwvh+XEco4ALXkepTm5x4rhd33jZRiub12RJOWIwvIjExWTfNl6dKU2wRvtmfZFPndiV/S1HLPj/7C9HFi5mQa2j1tFvtd4Bj0RCH0qCtbJYphYX2NF6V02CUjF20ZDcAOKiCh7tVQ1hs4X8wxNyAtbWJWSlzU5VexZKtEzPysngxgrUgtcExvjXAI7x4Fd5LIwBRszBOnk6hJNzVtN1d/3w2eNvT9F3oG567BVhiVl8UV3MdYMNXLffEAxyV9Es1XopBBwmFkKo0l/OVBDdJeCMEui+cycUOyLHzURSlK63tLK5u3jWx0kuaXyW/mj/DepQin/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJCKSmc6SvilUEmNY7dKIdhuSJ/+MlRBln+58maJJjE=;
 b=Nq8YeQXehwzPFW/obKZ1eDJeorvba3GLj7GVYErhiruDlgHaqd2HikXr0GO/NixiLdVYdppkDFltN3oHpgoEsvvkkaJR0uxfJYI1PEgC5yt8nYnGgEGeuoSnnu4aslFbBzgHMSrJZMfbI+pbxmSbxkW+xMMNGz7HHzEXorMjEQSeVjwqaxz7InnGsi203v5gZWiVXplpHCFYe9roxjXKPLR+hB+Hwr7AJU+B7EGUqlWjJkNjaj4ERzNJ91HXjlMzW2ppoKUxPdrVtZCiDOET72D2TFWZM80Gh1KopxcnR1aGsObqNS8xxdzrQvAEdBRsgkXqaxsZfsYzRVEpuMfTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJCKSmc6SvilUEmNY7dKIdhuSJ/+MlRBln+58maJJjE=;
 b=SeizIx1IiRkZ6xNA2ALPBbe3RN0Eq+YYOu7o8Tfwa+A0Phy/oTnH0cceLPi36/ShHY8RtlaZykOjT2sqkTkBXWiQcUpvoSiUnudI+vlwJ0qYN6ZsaUi4/pozHU0EqLeN7wNUdIHivzDEC9kATJbjKb2qUdowK+MYhWjBTpGrAKw=
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 06:16:35 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::24) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Thu,
 29 May 2025 06:16:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 06:16:35 +0000
Received: from [10.85.46.61] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 01:16:29 -0500
Message-ID: <6cfb9c54-d7ac-4e4d-9370-b62175f861bc@amd.com>
Date: Thu, 29 May 2025 11:46:27 +0530
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
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-17-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 69805dbd-3835-42c0-60f5-08dd9e785d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXVxVUMwb25NV1dJMVZIenBXL3hpRU9vQTBGTnhFQ2Jxd0FLK2xoTVNqSXpp?=
 =?utf-8?B?WSsyWkJUM0xQdE5Rdmh0L2Q4dWtPMmZOQ3R5VnJvSm1RYllET24vVzlNUjN4?=
 =?utf-8?B?M2Y4c1FlVVhxMU0zam9NVml2S0J5eHA4cEUvVXBHYnYrWGw4OFllWmhxWERa?=
 =?utf-8?B?UFZLa2h4emlCaVJQc1JyOUF3ZHZOZU5ORlNXSHgyNkwraHgxNFQ2TDU2K0wy?=
 =?utf-8?B?L2hXODJDczVHR05JRTlBNUVnZUJCcjEwbnlvYk5OOW9NU0s5UlZJTnN4M3JC?=
 =?utf-8?B?d2VmNUFSbkk4aWhQR1NDWERDaDFCaExtL0pTNkFpN1p5emtQbGdRZ2NVYUxq?=
 =?utf-8?B?QnpFSlBkb2ZlRVdrYjJ1U3ZyNHhuU0tpTytmdlV1aWtSaG1DZk5vQ2g2VTBH?=
 =?utf-8?B?bVJiRmJMZzl0S290dmRXa0RycE4wOTMxNmtUeCtEVzlYRkVST21SZmZPOEV1?=
 =?utf-8?B?WStORW9FeWlSNUIydlVoWXMyUXM1b1ptU0FMdzNzdE5WaStqU0xIb1haSkRl?=
 =?utf-8?B?YnNPc3M1SXd1MlNnYXNnZ0t1U1hCZk5xbE82T0JkakQ0YmhzeVYzNmpDMGpC?=
 =?utf-8?B?ZGp0a256VjFBZ1lHZzVBOVpmaHdLL2pyKzhUSENFbXBWZkNObnhqNWU2NUs4?=
 =?utf-8?B?eDZuRUlsOUsrRFI1eWlzR20wY25sRERvVnV2M1FOWG5PMTNoTGpXOUNvd011?=
 =?utf-8?B?NFNySlMwc2tlR050R1RXbXJ0MUMzcndncDB6VWlMUGE2blU5ZWcyNUplVmFD?=
 =?utf-8?B?eFdGWGdVUUZONmh0R2hqK1JzUkVjbEQ2ZjNtQTIzZ0hXUDF6V3VrbXJEejRK?=
 =?utf-8?B?ZExicFYxaHk2NWwrbERheGtGKzBTTmQrc1V6dlQ5STFWNmZBV3ZxSWR3QjA4?=
 =?utf-8?B?bVFnRms3bUovZFlGa2tWSTZ3ek5oR0JROStYUU5VbE9rMndCa0VjTVBSUXFo?=
 =?utf-8?B?U2c1bVVLN2NWNTAvNXlKY2NTbVJ4U1k1U0ViRk1abk1CN0N4RmtBa3dnUlFs?=
 =?utf-8?B?N09qMldWcFJMcENrbytkM0xvWDhoRGYyOE4zMHFYckRFN0R2cCt1UFh5UUNr?=
 =?utf-8?B?MHZLMEJVd29YckxXeEI3d0xpWnZIMGtabCtuTXVzMDBZNnRmTlZ5YlV3Q25S?=
 =?utf-8?B?OTEveFByWWxXUG9LalY3MGZIM2UxOGJ4eGhkeDhGckswaVFFOVV5TFI0RmlF?=
 =?utf-8?B?K25BRFp0Q1ZxYVVFeSsvNDJJcHlzaVJFdWxzQmhFQlNGY2kzSHZZTGc4Wnd2?=
 =?utf-8?B?dzJuYmJYZkRJd28vN0doU3hVRmxMM0VjT3VPRkR3bHRsQ3VvTTJRV0dUMlBk?=
 =?utf-8?B?TldJb3pkK2RBSHBRaVJtRXRxaWlnM3BhYStHd2tIalNIY3V6ZFBGdDk3enh0?=
 =?utf-8?B?ZHNpMC84c3U0UThadEpQcWQ3YW4xTjR6bElxUDRVZjVKdFpnWUFqVncxaUg1?=
 =?utf-8?B?WDRocWR6cWZQVEl2NmliaS8zd2VsWXdVK0JDY2N0ZzhHK0oyVm1WUDhIRHN4?=
 =?utf-8?B?VkNqOVY0S3ZJdTRtUStmc3RNbUdQUFRrRHhLYS9sOEZxS0hGWEc0ZldCME9F?=
 =?utf-8?B?UDZUTmg2Mmw4NjNGN3Q0SzR3cmh4eGt1a3NxTm91TWxKRU9CZ2h5eXV2NFk5?=
 =?utf-8?B?dUI1a1pIVGNYTmsrcHUxTVNBWi9BTTh1dXNybWFJaXprdmh3RkhreFNNaGta?=
 =?utf-8?B?dTdRRG1oL04rNG1LLzZ5ZSt4MExrNllvTERPRExXQTZzbXNYcmZlaThQVjg3?=
 =?utf-8?B?Z285N3VlL1JTMHl4WVh2NDVwU2loWURZVFR4TVkvQTFkZHFRZGtNclExc3dN?=
 =?utf-8?B?Z0oybUtEZWc1cnRla2c2VkQ1UkN6ajg5UTNtRE9HcnEwamEyYzdWVnNXZThx?=
 =?utf-8?B?c3AzdjNRMlQyR0UvZDJvblkxbEE0amllY09CSSt1ZlE2Sm92YU8vN2lRcjN3?=
 =?utf-8?B?MlJYQmZKdVFqOERwSFd4SFp2Q3cyV3ppQ3JPbGR1eFJ3Y2JOb0ROVWlrdkkz?=
 =?utf-8?B?NEtiRitmbFZWVGZDS1RzcUVZZ29uS2pUWlRodUFCalZDbmVLQ2QxV2s5aE1y?=
 =?utf-8?Q?m5RfLg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 06:16:35.4255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69805dbd-3835-42c0-60f5-08dd9e785d55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
Received-SPF: permerror client-ip=40.107.102.62;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
> On reset, restore the default address translation mode for all the
> address spaces managed by the vIOMMU.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 71018d70dd10..90491367594b 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -962,6 +962,33 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>       }
>   }
>   
> +/*
> + * For all existing address spaces managed by the IOMMU, enable/disable the
> + * corresponding memory regions depending on the address translation mode
> + * as determined by the global and individual address space settings.
> + */
> +static void amdvi_switch_address_space_all(AMDVIState *s)
> +{
> +    AMDVIAddressSpace **iommu_as;
> +
> +    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
> +
> +        /* Nothing to do if there are no devices on the current bus */
> +        if (!s->address_spaces[bus_num]) {
> +            continue;
> +        }
> +        iommu_as = s->address_spaces[bus_num];
> +
> +        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
> +
> +            if (!iommu_as[devfn]) {
> +                continue;
> +            }
> +            amdvi_switch_address_space(iommu_as[devfn]);
> +        }
> +    }
> +}
> +
>   /* log error without aborting since linux seems to be using reserved bits */
>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>   {
> @@ -2199,6 +2226,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>   
>       /* Discard all mappings on device reset */
>       amdvi_address_space_unmap_all(s);
> +    amdvi_switch_address_space_all(s);

Hi Alejandro

I think amdvi_sysbus_reset should set iommu_as->addr_translation flag to
"false" before switching all the address spaces. Without this, the
devices will keep using IOMMU address space.

Regards
Sairaj Kodilkar
>   }
>   
>   static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)


