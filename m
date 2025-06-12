Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27490C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 11:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPg6h-0004tq-JH; Thu, 12 Jun 2025 07:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uPg6a-0004sM-Lq
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 07:28:25 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com
 ([40.107.220.57] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uPg6U-0007US-Hh
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 07:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJDXROLILVrOLOs4s7VbrKgpj76PHrOZrTwFJs3tmYAjkxq0y+BYNejtsnsGasmbWH62ytpbT7+78HR11Vig2uggfmGKc/6v+PLHwXrXmLen+DbF0rAqNAyFwffWWXQnE1Bwj/l6urt/n+901nQ7JzjDIgRSPXqSmB0GciacHxC3c3+IEOcwcdyd1S/PBtmL6kQbzVaRRnzApD6pkMts3ocEsFPcGEWo5G3nEn7/+NSUTltu108yigxjJ3PrdiAuvgEbxRdBINIypepq4KUGvbbnAyAq97OaMU9jKFVh48lmeAJz/MmRSdIrO30Hw0fMgxVzIpIk5lQFBq0Y6wB0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0X5jNqnfEUCEvWmMZ18GewnfCZlx8qD8EMZj5j/l38=;
 b=xQCsoW4AcrsIxb3vtOU9FWEByorEmbEgraoev7q84cFQ8hYuHBz/RDlfwZZNWJo3l8nVfKCZNy2UeB8Xb2B8gy0ByxhLpWfbDuGzuYRMI9PZnMi1NVnHhxp7Lb/qes8TnSGtD1AnZfO4dXFAibtWE27UA+akOuxVpJDm8pzU6HOomZ9IbgIGFx7XEVnZOyfEnaNZpP4OsQZFfhsDdwSXIXKCSIrZ+kDJFNaIFMKquQ0v18FFk9Xxf6X65aHZzz+TKPXk83sIDnnwOyiD9okC3L1SVRuwm0/8Gs0jInDHT7blZQwOqP4jC5J2iZiLy/110Ac4Kvecr9JXEtLCEDHpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eviden.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0X5jNqnfEUCEvWmMZ18GewnfCZlx8qD8EMZj5j/l38=;
 b=1mlv+fsw37pdf9DcDxUfvH4U7W4smkPpIq9wumLZuCDfVOTKP/Crpp1O6MT+WNohKxJ0uWn6220mrIq6IdVutfwhyV5itbDMBWcW0uUX66amkdO+GSbeNuypJpbhUDDjVcYwdqmmgI2VmANIrv60MlGqN+OW9w40Kks2I428v2U=
Received: from MN2PR05CA0064.namprd05.prod.outlook.com (2603:10b6:208:236::33)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Thu, 12 Jun
 2025 11:23:09 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::ac) by MN2PR05CA0064.outlook.office365.com
 (2603:10b6:208:236::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 11:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 11:23:09 +0000
Received: from [10.85.38.70] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Jun
 2025 06:23:04 -0500
Message-ID: <9fc055e7-aa69-4c14-a8ba-5d555da42033@amd.com>
Date: Thu, 12 Jun 2025 16:53:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
To: Ethan MILON <ethan.milon@eviden.com>, Alejandro Jimenez
 <alejandro.j.jimenez@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Wei.Huang2@amd.com"
 <Wei.Huang2@amd.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "boris.ostrovsky@oracle.com"
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-19-alejandro.j.jimenez@oracle.com>
 <5fedf606-dd01-4a0a-af67-077e9ef9d0fd@eviden.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <5fedf606-dd01-4a0a-af67-077e9ef9d0fd@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: f85246e2-c44c-4e12-192c-08dda9a382c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHJQRWpDNWxZMnkwS2F2SElleXRvditEdThRend2VTR2Y1R6bVpJSHl3QmFG?=
 =?utf-8?B?UjBOZGNML2ZBcjdORUJweGZMdlZVSEsyMEpCL3pWOFVjdS82SW1QT2lLZGo4?=
 =?utf-8?B?R3N5alJqSGRoTVFhVHhzOW43Q05mbnpZK2RhN0h4OG45ZDNocGtBZzlsZEUv?=
 =?utf-8?B?RDRwRmtlM0NqbG9DSmZyaUFpSFZtdkFIYjUxUDBwQitvOFBJeGhDM2Jpa2dn?=
 =?utf-8?B?eVpZbjZucTRPRjRoZm94bEkzYW9IV2xLcHVObzliYVZQcTg5T2xmeWorNUMz?=
 =?utf-8?B?T0R2VzJTQTlVc3NyRmRmZjhtSVpGS1NTakxKcFc4c3d0NURva3RTWFN2Q29t?=
 =?utf-8?B?SlpiZU1EbFBhUWZydEhKSEpSdVNONGZLb2VLczBRS2FwWDBYYmxGeXEwa3BG?=
 =?utf-8?B?cWdxdXlCcWU4UGJLc2Q5MjlMQTVnS0Raay9LVXJKeWhpVWdQck1DY050U0Jq?=
 =?utf-8?B?TElVRGlIVksrN1BHV2llbzB4d0s0U28rTlgzdTk5QjVEZWk2NHZRV2tRVFNS?=
 =?utf-8?B?Rk1JQk05TENFUkY1MkFxbVhaTTl5SVBZSUZNZXRQVlFzbUNnMVZCbms4QVZ1?=
 =?utf-8?B?UkV6eUc1RkFuSjJZWEhKdk0rOUs4Yys1cUQwNUNrZ3B1QndjNzFPdmtMRzhU?=
 =?utf-8?B?YnNCQ2tZenB0OGMrRTNTMWJpSFFUZ005VERlbktZQVN4ZlMzUUZYV2dGMEM5?=
 =?utf-8?B?RkdQMWRyVGRPNTY5QnhITFdmWDRaeGh6eVZiN2F1a1dxY09wRVkrTkI2Qlpu?=
 =?utf-8?B?ZVN0YjlmWFQyUXlxSmRGZmR6VFJGSFVpcTFjNkh0YlIxa1NybUIyRUhwUkMy?=
 =?utf-8?B?azBVM0hpampkZk85RnE1ZGdIYXFyZTZMNFZjVVBHMFl1WUlxQVRMR1N0eEdN?=
 =?utf-8?B?YW4yWFdMZlNMM09FeXhWV3h5OGx2VTNxRFpFMFBuOWJoTjBrL2huWHRDUFBC?=
 =?utf-8?B?UFR2eUZyd3dCbEJZdWFWb29kRmdyRUIxY2FmSy8rNzViMGRqR3M5V2RVWmZp?=
 =?utf-8?B?NXg2WnFwL0JJQnNvMmxPZ2dmSmR6L0RIbllnK2NZZDhsNG5EMnoyM2pNMHcv?=
 =?utf-8?B?eXBzdU1nbExvc2NWQ0NUOTQ3bjU1NVBJWVVPUEtObnN3VXhCWjNrT1Y1bHkw?=
 =?utf-8?B?UXMxRzNYRXZNVVFsUldnNVFudFNCWWlCOGtjN1ZtbTJ1cUVHMUJmRHNQc2p5?=
 =?utf-8?B?UVBYNFBzV09CNFoxUkc2cUV5a2k4a0FHOHBXK0RRa1RBTWpqSHJYalVHNnp4?=
 =?utf-8?B?WXJTcVZOTk1ETmVxVGlaQlV6NGZrUXFuRGJtM3ZuMURhOW9rL0pSaGRrdHNB?=
 =?utf-8?B?MThueDNqTjJhWDI0eTFqdEk3TXhINzhyRWJ6MWZRYmlocTF3WEtGeDQxTE1G?=
 =?utf-8?B?cVppT1VadS9PTHhwS2ovR1VvaFZmZ0hyVkpsVUo4aTNCaU1wQWlxVUlHL1pK?=
 =?utf-8?B?Q3QvUjBpTDBGYzI4VVo3OWpQdWJIWU9rTlFMSTdOT2R2TnRTcGNGc1JMV0sw?=
 =?utf-8?B?c2VnajAxc3pIN3pSVXg1ME5SUVk3WlJucXBoV2RZdGR3ajRqQ0xLMzJ0ZURr?=
 =?utf-8?B?YTN3VXVHd09yV2hsa1N4Ni9FVUs1blM5WlZ0RmpFWTdlZUVkN08vV2VzOUVH?=
 =?utf-8?B?Vkg2ditmQkZuRExpNnhSeTVhUnZ5Zk5nUDN6ZkMwbkhRSFhNZllvQXB4VWcr?=
 =?utf-8?B?cTVKamt4clU1NUlFMm1wZ2VaVVFBYnJ1bTg4Z0Y0TVUybkhITXdyV0VIeWlG?=
 =?utf-8?B?TjVaNU4rZEpmM3Mra2s0TzZiK2Vla0Q0UmJndUw1UXIvdGE3bTFRVzJxZjFy?=
 =?utf-8?B?Qll5alkrbnpqN1ZiYnlZRGJsdDJMNkZIVXh0elJjU1dGOVRzdWc3NGtNMDJt?=
 =?utf-8?B?a0duSUx3SjdxTzFJT3dyMGpsdlJmeVplKzNxaCsrKy9ORXVZWFEwV0tsSW10?=
 =?utf-8?B?ZVZtVHQ1R2FkajJFMU5mZDJCVDAxTjlMSFRsb05jZXdiaGhsVlFuYnZkc1dm?=
 =?utf-8?B?Y0E5L1g2SkFrWXk4ZlNRL2FobDRvTU1oVHdibGUvaXcremhhMk1MWC8xc1Bx?=
 =?utf-8?Q?aVUfna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 11:23:09.4953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85246e2-c44c-4e12-192c-08dda9a382c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
Received-SPF: permerror client-ip=40.107.220.57;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/12/2025 1:57 PM, Ethan MILON wrote:
> Hi,
> 
> On 5/2/25 4:16 AM, Alejandro Jimenez wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
>> Device Table entry (DTE) e.g. after attaching a device and setting up its
>> DTE. When intercepting this event, determine if the DTE has been configured
>> for paging or not, and toggle the appropriate memory regions to allow DMA
>> address translation for the address space if needed. Requires dma-remap=on.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 78 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 76 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index a2df73062bf7..75a92067f35f 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -991,18 +991,92 @@ static void amdvi_switch_address_space_all(AMDVIState *s)
>>       }
>>   }
>>
>> +/*
>> + * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
>> + * after changing a Device Table entry. We can use this fact to detect when a
>> + * Device Table entry is created for a device attached to a paging domain and
>> + * enable the corresponding IOMMU memory region to allow for DMA translation if
>> + * appropriate.
>> + */
>> +static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
>> +{
>> +    uint8_t bus_num, devfn, dte_mode;
>> +    AMDVIAddressSpace *as;
>> +    uint64_t dte[4] = { 0 };
>> +    IOMMUNotifier *n;
>> +    int ret;
>> +
>> +    /*
>> +     * Convert the devid encoded in the command to a bus and devfn in
>> +     * order to retrieve the corresponding address space.
>> +     */
>> +    bus_num = PCI_BUS_NUM(devid);
>> +    devfn = devid & 0xff;
>> +
>> +    /*
>> +     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
>> +     * been allocated within AMDVIState, but must be careful to not access
>> +     * unallocated devfn.
>> +     */
>> +    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
>> +        return;
>> +    }
>> +    as = s->address_spaces[bus_num][devfn];
>> +
>> +    ret = amdvi_as_to_dte(as, dte);
>> +
>> +    if (!ret) {
>> +        dte_mode = (dte[0] >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
>> +    }
>> +
>> +    if ((ret < 0) || (!ret && !dte_mode)) {
>> +        /*
>> +         * The DTE could not be retrieved, it is not valid, or it is not setup
>> +         * for paging. In either case, ensure that if paging was previously in
>> +         * use then invalidate all existing mappings and then switch to use the
>> +         * no_dma memory region.
>> +         */
> 
> If the DTE is malformed or could not be retrieved, wouldn't it be safer
> to default to the DMA region rather than falling back to direct access?
> Or am I missing something?
> 

Hi Ethan

I also agree with you.
I think right way should be keep the IOMMU DMA region if error codes are
AMDVI_FR_DTE_RTR_ERR and AMDVI_FR_DTE_TV. Otherwise when error code is
AMDVI_FR_DTE_V, switch to direct access.

@vasant what do you think ?

Thanks
Sairaj

