Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBB1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 06:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7TRE-0007T7-Iz; Wed, 23 Apr 2025 02:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TRC-0007S7-SO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:18:26 -0400
Received: from mail-dm6nam04on20608.outbound.protection.outlook.com
 ([2a01:111:f403:2409::608]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u7TR9-0001tX-Sr
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 02:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmlkLEoKjlEKtQqM4VaekUAQ375Rn+GU8WkqQBwOf+bKSXcyT/NVv1FOrTKt46JmbtHfwAQTdxkCvJl/V3Yed60J69i/J+5geHbcKeY6bkttUN+vZ4QuD18yBqo3vCncGLf6cRHvKNTyba15AEC2zcZgrAoo9lBrjyTX7RpKd/h6Sy0I5CbVu6Oo7G+TtTW6f7JEXAp/5HfZ7hUZZF59J5NRpOCa/2e/XpZ7xnCDSFgsBlhVAWIxtn6sYUwFosPd5UwqbCXnLgt1z95B1EKdnS/02MXucngcC4oG05YIR4pKQXJFv+1uqr+ihpLaH+flgVJTNTL2zVzB6aCEPjiGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isx4/WMoaBPoJ+Mr7dGNVOI/1BBhhB9cNEqxReL1Iqo=;
 b=QiIUvo2VK0XI+H2Nl7HH19xelxGYdApI43GAFWbDswwxHygddPimj9VI4F0d3/L3nBrW0zcd8WgApSgP6kTThosWQKX4upIG2OxG8Oc7FEwEXRebpDIkH9ZX/CL+3zBi9n1bYpW+25Q2t2FapFTn//8mUJvBwtlKDgUPlmjB78GbnBKKMhoofIyVkT1i87aJlsIyb/twu/hFWgvqX0XD8ASnP4DPojG6geekptOWseMJwwLSkHE6M252y8XJc4dhUQJVDEYeYN4XifIlgoYcxVram+LKSDasCzdKsJK+lwYy4nGazEEudxzbCAOKracNCvJLVhPzfS/9OsQYjGHVnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isx4/WMoaBPoJ+Mr7dGNVOI/1BBhhB9cNEqxReL1Iqo=;
 b=ljxFYYm8e9teg5u40bp1rM6vdMV3PUi4XDzwdQggsi2XmFBMrpIkXR4qYX+3dGuuMgoNkJubOiBoszL1ovwo15x8SNNeWraIuW77mKao1faoeyi5S+kdPM9Y0/9uysdvVRZlkXb38Y5hdbYa8e9Vo+YccGYLRc6Wuyi96xzK47Q=
Received: from BL1PR13CA0342.namprd13.prod.outlook.com (2603:10b6:208:2c6::17)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 06:18:14 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e4) by BL1PR13CA0342.outlook.office365.com
 (2603:10b6:208:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Wed,
 23 Apr 2025 06:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:18:14 +0000
Received: from [10.85.41.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:18:07 -0500
Message-ID: <688f2f65-6ebf-408c-8cde-47d9c462177d@amd.com>
Date: Wed, 23 Apr 2025 11:48:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] amd_iommu: Do not emit I/O page fault events during
 replay()
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-19-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250414020253.443831-19-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2503b7a5-e385-46e4-0ae2-08dd822ea172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2I3ZzBWSzdXcDVVdVB6UE54aXlJRFE5Ri8vQkFQbGtidk41SE1BTGVsMTFH?=
 =?utf-8?B?RE9Oa0QxMnU1eGNFenpuR3JMamROdnM5ank2Q1BTTHJneHNxV1RvajVvRTJN?=
 =?utf-8?B?K2E1V1NuZUZTNVZhOG5CWDVlMGdySGxiMFRCVDk2OGxmNlR2N2hQWmFremwr?=
 =?utf-8?B?cmdRS2RadGtzL0hhalJ6SThtaG5RN0ZtdzJOK2dpdXlmdEloN2NnYnkwcHRm?=
 =?utf-8?B?OXYvejdxWm5vRWNsblc3UVgwVGN2YzBoczVKeWRDdGlXYVJ3ZlQvdTJ2SThR?=
 =?utf-8?B?UkMwRE8zMXJma3pEdGxJME1YZU5WYmNPTUVreDRaUUtWSkdNWlQzTDRxVzA4?=
 =?utf-8?B?dHN2bzlWNEFaWGRpcUJvSllUMU9Dem1SaVpSbTNoOUhieWtYVU9tRDNHMitZ?=
 =?utf-8?B?S3NqNGdxMEcxV1dwaTk2aFFHWmpMU05xSWdtSjNhVUpvY0JGaU93QzYwNkQ0?=
 =?utf-8?B?QVVPQURPYzBndDRlTTNGa3JGYjdyRHhWeGNmNXZWV2NDVG9TQ3dVN0ptRmRO?=
 =?utf-8?B?NGx2dm9UajJhNWhJMm9Hcm5pSTFJaDh2OHRSOUZpczZsbFFKSldiZ1dtMmFT?=
 =?utf-8?B?OE1DY0FPdFErZC95NStiZkVJR1NvNmw5SGx6SndCdm5pN095QjhZa1JjcXVs?=
 =?utf-8?B?TE1ZMm93SytramxnQjhoKzcyMWlMMW94V1FZVDRxQTFpV3BIN1l6cHpaU3VO?=
 =?utf-8?B?YUJxZW8wM1pNY3F6Z2RkYjJWTG5IcU04M3owNytMamtKUWNLVVl5VVNZQmgx?=
 =?utf-8?B?WmF1SFVlV1lGaHpMVkNUc3FHL24zNUdHbnNrMXNNWWl3Sk4yVFZjd1NZNFMx?=
 =?utf-8?B?NnpReFBwUEFSbzZ6b25sRTFxeDhnWjlmTDF6eDA4eUZqL21sU0c0WEUyankw?=
 =?utf-8?B?Um82NEdya0k4RlFoNUM5Ry9lUkROMTBKMEVBYTdScWdKdWpqN0YwTlByTFBN?=
 =?utf-8?B?NFZ1YWZkWnlDRlBTekw5SkpPdWFlaWM1bE5XNDNNQ2wzZndieHdGTGtaekoy?=
 =?utf-8?B?djloN2xqNVJ3bG9uNnpvTXBZekRqUU1LemN1TU1USTJqQjhzWUh6WHdHTVpF?=
 =?utf-8?B?Y3lHV25nNjdIdm9qUnBycG1xQnBIMzI0Z2lwdlQzVG1PZkNOVzhiZXd3Kzcw?=
 =?utf-8?B?czJCcUtGN2xVZDNnd0dJN2cvUEVIZlVkWUdxVGc5R2R1S2V5SHJ3SlVsV0x0?=
 =?utf-8?B?eDhPaVh6dnBMeUl1YVdBcTVINXdRdjBaR3Yvc2dOVFlENDhzZ1l2dEVqanY4?=
 =?utf-8?B?bFVkeGliYU02dmhCcnU4WDh4YXV4Q3lwZTFOaURPSmpIaGF3NHVQSkZKMnBi?=
 =?utf-8?B?Ry9iSzJBTGM4RE4vbG5RTlBka0hRVjdzczdHZ1RDTTBQNGJ3eUg3ajhXT2JW?=
 =?utf-8?B?VFd2SDJyVURPbHE0ZmhvZmsvOURJOUF6M2xtajhTeXZmdkwvd1UwalNGOTRW?=
 =?utf-8?B?cDN5ZkRwU20zNUFuMGo3TFd5WnlZL1ZKREdvVzlEOXg2WktiL3paWXFSTUpE?=
 =?utf-8?B?OGNERFdzS2dWN2x0WG9FaUFmWHJkTGRYREthRDljQmhteGFYRHprTVZJSkVI?=
 =?utf-8?B?REYwckszNGl5cEVnc2NEb1lSa3REMS92bVJyT0xRcmlsbTdXNE9GQXpTa0Ix?=
 =?utf-8?B?UkFsTEtrSFQrWVJrK2xrVHR6TjY2d2l0ZFpnajRMbDhsd3ZKUVZhdU9xWjlM?=
 =?utf-8?B?Sy94ZGoyWVhIaWlndExRSUtkOUk2YWFzVnNZdncyN2xCazNJeTh5MWVTOFlE?=
 =?utf-8?B?U3hIQUpxMzlSZFVYbmpORFhPWHhmRTFxdzR5dm44dGp1THN6dXh0YUFqN01U?=
 =?utf-8?B?RXREdXhxcXZRWkc4U0FsZHZXeng5bEJaeFhLYnJUbGhQT2RHam9TYlRLMHI0?=
 =?utf-8?B?d2dPWUxlYllVM2o0R0lDT2NuWFR4L0U3cUVQazdWS3l3aG9RQTA4d1ZGTnE0?=
 =?utf-8?B?Wk5TcTJoYTFYODFrMW5xeGd0NUZEMEsrTGl3aGpHTFNqUG1UL3ZNRmRXL0NI?=
 =?utf-8?B?N01oTXpyazVTMmphcGNQVk55bDgyRGhVSDFHem52R3pNb01SOGFuS2FSVEdJ?=
 =?utf-8?Q?ZFPjxf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:18:14.4721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503b7a5-e385-46e4-0ae2-08dd822ea172
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
Received-SPF: permerror client-ip=2a01:111:f403:2409::608;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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



On 4/14/2025 7:32 AM, Alejandro Jimenez wrote:
> Do not emit an I/O page fault on amdvi_page_walk() when a valid mapping
> is not found. The current role of amdvi_page_walk() is to be a helper
> for the translate() method and ultimately the IOMMU replay()
> functionality. These operations might be executed while the guest is
> running, but do not necessarily correspond 1:1 with guest-initiated page
> walks.
> 
> One example of such scenario is when VFIO code calls
> memory_region_iommu_replay() (which ends up calling amdvi_walk_page())

I dont think memory_region_iommu_replay() will call amdvi_walk_page()
after your changes. Since you have added a replay callback
memory_region_iommu_replay should return after calling
amdvi_iommu_replay() because of following lines --->

if (imrc->replay) {
	imrc->replay(iommu_mr,n);
	return;
}

Having said that, I am not sure if there are paths (other than emulated
device write) that calls translate(). So lets keep this patch but remove
or change the example.

Regards
Sairaj Kodilkar

> to sync the dirty bitmap, or after registering a new notifier. The guest
> would get IO_PAGE_FAULT events for all the regions where a mapping
> doesn't currently exist, which is not correct.
> 
> Note that after this change there are no users of amdvi_page_fault(),
> but since the IO page fault handling will be addressed in upcoming work,
> I am choosing to mark it as unused rather than deleting it.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dc29a52bd845..ac7000dbafc7 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -263,8 +263,8 @@ static void amdvi_encode_event(uint64_t *evt, uint16_t devid, uint64_t addr,
>    *
>    * @addr: virtual address in translation request
>    */
> -static void amdvi_page_fault(AMDVIState *s, uint16_t devid,
> -                             hwaddr addr, uint16_t info)
> +static void __attribute__((unused))
> +amdvi_page_fault(AMDVIState *s, uint16_t devid, hwaddr addr, uint16_t info)
>   {
>       uint64_t evt[2];
>   
> @@ -1254,9 +1254,6 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>        */
>       if ((pte == (uint64_t)-1) || (pte == (uint64_t)-2) ||
>           !IOMMU_PTE_PRESENT(pte) || perms != (perms & amdvi_get_perms(pte))) {
> -
> -        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> -        trace_amdvi_page_fault(addr);
>           return;
>       }
>   


