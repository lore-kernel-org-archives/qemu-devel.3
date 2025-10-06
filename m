Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB516CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 06:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5eUB-00042P-5e; Mon, 06 Oct 2025 02:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v5eTv-0003wX-Fv
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:14:00 -0400
Received: from mail-centralusazon11011006.outbound.protection.outlook.com
 ([52.101.62.6] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v5eTs-0002Qp-Vs
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 02:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skVG7khyEs9FQGEgg95boXzzs18JEvo7GAmziaAXt15MDYae5nFJ2chi2qf4S72FlDHg1d7DYDw5Mlf3MH++HFB7bvo8ecL0l4ustN/2OhQ6eZTGR0rYg5kTmp9H+B+YSY6H9UuNXhb+yjJnmnSXjGWRO+X0xMuGOMs4Qgmlzq5wbeo8YHXCwRWFDlBnAlf4W5zV/zSidGDipopJMxAqrRNUAO8yjViW+3t5/iBoWu8qwQ82/UvDmxUJwKZFLbnkZs25LJTvDfKHMmifNFgs0u1Db5WnJTBqhbeHEhSDjvZSPQOOiPAT96zI7WJIA+B8YHFe1EDs3I5x1+m+avasmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5+oExVuS4mlI0YEUCnUtqGMgtFxu7X3JjqDScuxN8o=;
 b=loUFJgjmGnn+HrYMuhOvo85IEqn4NBxjYqY+seDhqzgkrfIODDqbwa8sTCGuJYp7dFDTSpwzGUAvknUyIcyJ2zTtAxSh+FRrRuMXsnVJqOWItFVxmP+IRpvNc2V66iieVbT+E8domJFLieS4sGDjJ7ySOHwhKKO54gcUDCGDwl6JqV7hUZ/4fZB1i4XupO/FewRqhwwlVBE0pkGMR9MxlptsSw1+6XY07fjkuyTCRkaBA5AoDmsmjYpGg1Y7Yp43TsnWfIW0Bt0m6w0KHeKm+rVFHsUp+fAiwxREwutEQ4+yngLCsluww8jkPYHYzDMJuEYl0TmHKU+rGPo7hr4vLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5+oExVuS4mlI0YEUCnUtqGMgtFxu7X3JjqDScuxN8o=;
 b=dBX+b4M5XXA3lwASdSb/ftvkrPVuf6I8+jkL+j7g6OB1f79w8M30IImXXPAB5FNg9jjrZVcbW+CbF96XoGsUFYqb89PAbSsctRyRlvCha42QzQ30i6+TF281mEZfoBXCOm8qFHBntLmttCZLyMWaOS+guHBxH+eXI6cTM80QNgk=
Received: from SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::7)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 06:08:44 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::5f) by SA1P222CA0055.outlook.office365.com
 (2603:10b6:806:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 06:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 06:08:44 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 5 Oct
 2025 23:08:37 -0700
Message-ID: <4856d645-ad17-4660-8012-3d315e56a463@amd.com>
Date: Mon, 6 Oct 2025 11:38:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/22] amd_iommu: Toggle address translation mode on
 devtab entry invalidation
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <peterx@redhat.com>, <david@redhat.com>, <philmd@linaro.org>,
 <marcel.apfelbaum@gmail.com>, <alex.williamson@redhat.com>,
 <imammedo@redhat.com>, <anisinha@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <Ankit.Soni@amd.com>, <ethan.milon@eviden.com>,
 <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
 <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 05751d0d-214f-4862-ee44-08de049ece3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3kzQU1JM0hFVWkrYlNsdUpCVVAzTk1ReW1FSjNtbUFNS08vOHI2aHRHYWg2?=
 =?utf-8?B?REpIQ01TcjdiMWMwS2JzeXZ3UEJ2Rk92U1R6QXd1UWZnOWpIWXljUGwyM0lM?=
 =?utf-8?B?MHhSeVhFVDl0UkRrY1VBd09HWGI0cUhwVVNQUlMxakZZemlnWVdrVHlTZ25Z?=
 =?utf-8?B?djVIQ2RkeTRnQzc1TVkrYVkyRVJBQTE4WWw2dlJXc0FvUzlvVDRhTkM4WWNm?=
 =?utf-8?B?NlhkbUUzcHg1NlpoSGVaQ3RsTjRlTm9uUUtsZ1lYb3FXbXlWVU50T1NDdmJO?=
 =?utf-8?B?UmJneXlSYjlzNGgrRzBsK1pzZ0Q4bkJMQTg1ZytiYWNIVUdKUWROWGttTWxX?=
 =?utf-8?B?NCtEbFJEUEplczB2dTVsNkZsbk5LdkM4dnF3c1E3MUVMOEFHb09ncTVjR3c2?=
 =?utf-8?B?U3Zzb0VZV29XSDlvVS92SHExSVRsRDJTN3M5eUpMaEFmRkk0N3lZbzlUNDh1?=
 =?utf-8?B?QjZDMFg3WElJbHJjMnVEYXpaa3phYVpZZWFmTWw3aVhSM0liUTNiVVQ0c09y?=
 =?utf-8?B?UGpIN24xR1I0UzVZazF5YjBZS3BGVDlkRlR3bjB6S3g2VHljVWVtazF1b0g0?=
 =?utf-8?B?QUVxZFhvR0ZJaDBMWFRnL09DL3RJUGVIQUNzY0MvZThFdE45MSt1dS9PVDBy?=
 =?utf-8?B?blJrQzdCbzlDMkdHa0YwaHJ1eFFzNk9wSTVRSFRTY2VYZlQvTmF5U2g4R3h6?=
 =?utf-8?B?QktMcFdRZGR2RDl0QmN3MkQzL1hxVkVvaHlOcmNBOUZvc2FmZmFZbXpHS2Vn?=
 =?utf-8?B?cUlpZGcvMU9ibXdKWkxtdGVWUFNyOW1kWmJXRWFlVjhyQm1GTUp2Ry94YW14?=
 =?utf-8?B?RlIrRmViZ2RhV3BHOUtNcGFHV3l1RUdpNTZZV3FIeVJJUHgxWUp2NmxkVnZl?=
 =?utf-8?B?Szd3Y0Z6RzVuMW15NlIrVUFVZWk4dWsyS3hxejVCQTdiaXRKMUF2bTRRUGNj?=
 =?utf-8?B?NW5mZk1aS0RZdVU0dHFpRS9LT2tOeGpOdXpZTWhwQ2tUL2xVMmtCUVByMDlL?=
 =?utf-8?B?MldIZTA4RnZzRUt5U3d0RG1SSlBlalVtTHI1dUlLckNuVTJEWktidFJsZXpn?=
 =?utf-8?B?SXpRK29LTy9IdDRUbi9WK2hPZ1kxTzFhVFUxSzk0R3BQa3d1VUt5cUUrWkly?=
 =?utf-8?B?dGRxY0lWcjRldW5vZk1GUjlHU2FMaFNkMWV5TllNV1Y2UGZkdW5NUVJaMFZP?=
 =?utf-8?B?bFowUG9TSVhDN1lFaTNKV1IxeEdwL3lFSkFwelJteCtDalBpVlhnQkhyOVc3?=
 =?utf-8?B?eFM1dU1vOXA5WEZ2a3Q2YjUyejZsZnErU3Zhd2JzblZlZkUvWDBJTHlNLzcv?=
 =?utf-8?B?MGkzL1hwOXNJbUQ4QW9idkZrbjdORERZQlBMUk1Nd0k3WXdLQ295YVNHOFVT?=
 =?utf-8?B?V2l0Vm5TeWJYemxNT0ZzM0NHSFR1ODFtYlRmVG1xQWUzZDI3TUFYZjVRckZS?=
 =?utf-8?B?ZEZwZDZwdmptb21HNng3VDNzYUVBWVc0WkEwbzRwZ0w0RFFDZTUrNXZla3Yr?=
 =?utf-8?B?RDVoWjJMQ3E4TkR6QWx5YUZ1TnZsNllZMWVwSEE4WCtKcHRjQ1JXTlpxWWZr?=
 =?utf-8?B?elFkZ2I1VFhCN3VTYU5xWUJZSEZNNG8zTkRCUzBvbFRSNVVhZUtybjN1R1JD?=
 =?utf-8?B?NmlXVDluY3lzdGRHcHo1K2M2c1g2eTJDc0tZa0VmSS9ISlVHQlhmdUxacEJr?=
 =?utf-8?B?ZFZqRXJtenpaZ1dWS2w4QitrM1AyOWdpc1BKOFozYUdrVjFiVDRFTGpxWmtV?=
 =?utf-8?B?NUFSRmhyWlVZaU9rclRXbEdNVmJheDc5WjJWUVUxQnYzbUJydld5bGltYTJt?=
 =?utf-8?B?aXhoUmxYNDZzaW1ZWkZLT0twTjhHUWRTTkN2d2VCazZiMFJ3bUhRbStiUlQ2?=
 =?utf-8?B?bDRWYlF1S2pFc1NXU3RHNENtSWxGczFmMVA3YzVLUmVmNVorZURGMmM3OTBn?=
 =?utf-8?B?c3Q3cmp0eTVCM0lYTU1RM1Azb3piSUl4UWIzYnJUUDZsQTUxbCtUNFVmSnd4?=
 =?utf-8?B?aFpnMVR6TndoWkNDWDFsVFlkamxMZDVlUE9zZUlHS1MzTjRLVU42eFgrNlEv?=
 =?utf-8?B?NFo5SmVpK2laVWJodXp5RkNPZ3A5VnIwa2IxRlRXNW1ha0ZHSlFVNlB1akEz?=
 =?utf-8?Q?kGws=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 06:08:44.3986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05751d0d-214f-4862-ee44-08de049ece3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
Received-SPF: permerror client-ip=52.101.62.6;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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



On 9/20/2025 3:05 AM, Alejandro Jimenez wrote:
> A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
> Device Table entry (DTE) e.g. after attaching a device and setting up its
> DTE. When intercepting this event, determine if the DTE has been configured
> for paging or not, and toggle the appropriate memory regions to allow DMA
> address translation for the address space if needed. Requires dma-remap=on.
>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 120 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index ce5d4c36624fd..e916dcb2be381 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1032,18 +1032,136 @@ static void amdvi_reset_address_translation_all(AMDVIState *s)
>       }
>   }
>   
> +static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
> +{
> +    /*
> +     * When enabling DMA mode for the purpose of isolating guest devices on
> +     * a failure to retrieve or invalid DTE, all existing mappings must be
> +     * dropped.
> +     */
> +    if (inval_current) {
> +        IOMMUNotifier *n;
> +        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
> +            amdvi_address_space_unmap(as, n);
> +        }
> +    }
> +
> +    if (as->addr_translation) {
> +        return;
> +    }
> +
> +    /* Installing DTE enabling translation, activate region */
> +    as->addr_translation = true;
> +    amdvi_switch_address_space(as);
> +    /* Sync shadow page tables */
> +    amdvi_address_space_sync(as);
Hi Alejandro,
I think we can skip amdvi_address_space_sync, because 
amdvi_switch_address_space will trigger
amdvi_iommu_replay. this replay should unmap all the old mappings and 
sync shadow page table.

Thanks
Sairaj

