Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAB3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 07:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEN9j-00038u-MV; Mon, 12 May 2025 03:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN9h-00038e-EN
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:00:53 -0400
Received: from mail-bn8nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2414::615]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN9d-0005Oo-9E
 for qemu-devel@nongnu.org; Mon, 12 May 2025 03:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edz+A7jLKqKPZA/pMzVki6irTMfrq0C+J1MQ3FhHOIqmm6jLr6QsVAHxPGrLnXFhPxoaqjrMb9EkHBN+nD8HkjWnMJxb4t3zaK8BsAZNui52VDgyMYSoNjpId6BikRQgP/suXpnb4vmIpHtneGETQuEkIwu/ZJD7GP9UC38J1Oyx9fKh+BJW5AZyAx+yPoDdqDCRiywtqPi94veLCd+vp7h6+B9I+ERhzYNcQ9Rhqd8BdfXuXZlarfHrho/5veImhqCRmCm3N2TEN9Dbnomg724JC4CQ8g+aCj+wbCdCQMGATm6prrcsYJFAcbMGZomcD0XWPEJlK879wnJULL5xRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK0GMrTmwCrv4WXB3p/ba30yPByWeNVaTH/x8LR0zQ4=;
 b=LY6bxaWMtJ5yAnjpH1WguCTfO3lI3qt9P5Kgcm3UKl6TqR0v+lcEgLLLBmIDU5co3oLjaaW5SDC5/eiAT061evHSubIP9cvuMt0CM75MbEltUMTpHKXyPeevnDQ21byLCz/erVmLBb7muVgeDBpf9OaslaZTSGs10NsbB1YFBdrl3cR08cxs4hT5ZqtbTnU8QCrvy8Xg2voT/noWXq+5mxXcVrjaLscQ/bRCaBlJaoz5lrgaRwmktlQv9gy/gaVmYQf/5YFSNaOZWJx+qHSMGik3jeMhODNFRbPbmbx8WBa6TqN9TQfSFKBKCk8kJC/RbXh2mBaOnVA43t+1wIMXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK0GMrTmwCrv4WXB3p/ba30yPByWeNVaTH/x8LR0zQ4=;
 b=ccrIicmcpJzm4RCKQJ+D8rIqZyoieo33tTd+cGNHgQcVK7bCf/gU50U8O6NmOjGSIQCAYErc07jPgWCrjLz//EezeAwSWyLWkZVuPl0q26gCkiwIkLbg8gsvyIWbBaxbQZ3kd3mru0kWq81bcThC73BluQMDRboL2zNfWZVqm6Q=
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 07:00:39 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c2) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 07:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 07:00:38 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 02:00:32 -0500
Message-ID: <8cc41515-73d4-4d7b-b908-679e3fe2e923@amd.com>
Date: Mon, 12 May 2025 12:30:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] amd_iommu: Do not assume passthrough translation
 when DTE[TV]=0
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
 <20250502021605.1795985-20-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-20-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: d89f05cd-7593-4afe-1c4c-08dd9122b3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGc3V2xmSEUwR3dKMG4xa3g0cHhFTmtkMnBtVTBjbEsrcEVhZy9TQkVlQzdo?=
 =?utf-8?B?cWU2L3lmdDRGYXBUNU15TlpRc3hCMjJ5YU45cGdmZy9jczZjTlFJVjZBcFNZ?=
 =?utf-8?B?Y05xL1lSZWNwaWNDVDkxUlhzVEhZMFJObk01R0F3N0sxSXNqdWxic0lOT1pZ?=
 =?utf-8?B?akdqSnE2QWtheVFFdWlPQ0VFQm5qR2QwalpRL1ptTHFodGUvOHJMY2lkVHlh?=
 =?utf-8?B?b00yUXVNSHJMNXlmWGpzTDVxQ0FOTGFtMkRwdkpXS2UrWkpzNVdlVTd4ZlRv?=
 =?utf-8?B?aHl2OE1pUnkzMVFVQmdBUUxjcGIzeDZvOTh3dDVDZDJXVXZZRkxNUDVsRWRN?=
 =?utf-8?B?NHhoMVlFKzhtNWE0RExnTnVjSEpmM2ZvaGZDTW5QNElxY2h1K200cFN6bUlP?=
 =?utf-8?B?V0VlMkNVdmlMeEZZeVp2cC9ycVpGQllZS3hucmQxREN5YnBpckE0THNnWTdw?=
 =?utf-8?B?K2hGR1FCVVIxY3FzRXlkTXMrUjJOeWsvR0lZemlaemcwWDdtbS93WUtHS2dD?=
 =?utf-8?B?OGtrU2ZENGhERUlxaVlJalVjdEo3MzE2NWF4QTUvajF2NzFoMlp4OUxOV3Ex?=
 =?utf-8?B?ZlJCRVRrSWYyQnE2bkc4Y1o5RVVuZHFCR0F2Q0JpTERIY1BkNjFkQkVuQ1ZO?=
 =?utf-8?B?QzJaM0g0SVV5WjAxREpDeGZPa1hsVjVaUFppUDZveE02RFo1NmhHdFhsSnIv?=
 =?utf-8?B?Q21qYm12bVQzbEpFdUhwd2cxaktUOEh2UlFtdmdCR0poQ0FLYmZxYmNYWHpP?=
 =?utf-8?B?cjIvNXZrS0duanliRGV6UCtVSm5RWk5oTk03RFpRei8rSGxVbkpRaXhqdVRU?=
 =?utf-8?B?eVU1UFkza05iT0NyWDBsaldsTHluaERRd1FVRTBXVGRFSDRiR1VsNTg5SXJU?=
 =?utf-8?B?bzlQRU82YjlDUEF5WkNwejhveCtDNDhhVjZJMHQ2bkJFaEhxT3diUFJDY0Fm?=
 =?utf-8?B?cEhyWGcxTW5PWDlzQmkrNmhLUFZxSVcxOVBMcTJ1OXZJc3BZOUJJVnpFZjRq?=
 =?utf-8?B?aG5CRU9WUGV6Q3dabHNxTUtYd1ZkU0RvVEMrVDM5MVNDOU1WdDVYTUdFek5i?=
 =?utf-8?B?RlZlS1RKTG5zTFkveEpZM2h1dERuWXVqVy9CTmRkVTVwUUdIb3ZFMlVLWUNX?=
 =?utf-8?B?TVlYYmwxeGJjVkd2Y3hjaVpLT1dzMEl0MmlpWjVseEwrWTlJa3RMUlY5Skxj?=
 =?utf-8?B?Zm8wd0hnN0hwdStrZ29aR3dXRUVja3dreHUzRTYyUlJueDJ5SkNiYUh2REwv?=
 =?utf-8?B?T2ZlZnYwRzFxMHFkYUtFTVk4ZkZyejZMbG5zcE1yYXc2WEVDOU9BbnhjUzRn?=
 =?utf-8?B?dzEzeGgvdEhMV1RTSWVQeExHWXlZY3lzWlN2QWI3QnZHOHAzYjFPdUhrMHdp?=
 =?utf-8?B?U3ZwQnNGYWtCaFlnOHhuSHVSMEdXU2tEenlDSVRXWFZsUGgzeGlPRlVsMVgx?=
 =?utf-8?B?MlhBWW9kZFYvcnZhMCtBMER5MzBzejNqZy83S0lQcmdvYUdoSjhXUFBmRnpW?=
 =?utf-8?B?RnZDNDMwUEpYb1lyZFJJMzMzUm50eHp0V05GdzlxMVhLR1FZQ1Q0K0x1czVP?=
 =?utf-8?B?MjZtcHFUenJGR1hSc2lVYTlka25OQzZrTFBJeDB4R25wUUh6QTFSQTdhQS9p?=
 =?utf-8?B?SlhCZTdPTlVDS2RKU2d6azdIdjRoZUN1SHRFYllTNnViSFk2Z3F4SHZ2N25O?=
 =?utf-8?B?N3RtUXJPVFpXQzFsWW9HRTdZbjBHWStld3lYaGNCL2RTVDlmTE5PeUNtRlRR?=
 =?utf-8?B?Q2UrS0lzb2htVWpTWFdRbXZEUFN5TitOR2xKZG9CaU44cU4xdm84aEZ0UmxU?=
 =?utf-8?B?dzViK1poVDdCMUppMXNDRldXZjB0aHpWbFVjRHFZL3ZsWjdCWWdjRTFIUmdB?=
 =?utf-8?B?N1hUYzVrWFBxdE13dWsvMnhod0gwZzlGSkhoY1pNZHdYbVZEOGtWb0RXQ3VJ?=
 =?utf-8?B?TGE0UHY1MUdCcWt0NGhRRktyeGo3dGVXUUtIcUVXRHJISVgyRWlIY1ZDNE1B?=
 =?utf-8?B?bXBJWThrNzUrbjRYWGlxYWFJSjdHNTdrU0lwYlZaSnBsV3ljN2pDYTRUMnFE?=
 =?utf-8?Q?W8C9al?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:00:38.9754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d89f05cd-7593-4afe-1c4c-08dd9122b3fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214
Received-SPF: permerror client-ip=2a01:111:f403:2414::615;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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



On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
> The AMD I/O Virtualization Technology (IOMMU) Specification (see Table
> 8: V, TV, and GV Fields in Device Table Entry), specifies that a DTE
> with V=1, TV=0 does not contain a valid address translation information.
> If a request requires a table walk, the walk is terminated when this
> condition is encountered.
> 
> Do not assume that addresses for a device with DTE[TV]=0 are passed
> through (i.e. not remapped) and instead terminate the page table walk
> early.
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 87 +++++++++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 75a92067f35f..6d1e7cc65f83 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1612,51 +1612,60 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>       uint64_t pte = dte[0], pte_addr, page_mask;
>   
>       /* make sure the DTE has TV = 1 */
> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
> -        level = get_pte_translation_mode(pte);
> -        if (level >= 7) {
> -            trace_amdvi_mode_invalid(level, addr);
> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
> +        /*
> +         * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
> +         * An IOMMU processing a request that requires a table walk terminates
> +         * the walk when it encounters this condition. Do the same and return
> +         * instead of assuming that the address is forwarded without translation
> +         * i.e. the passthrough case, as it is done for the case where DTE[V]=0.
> +         */
> +        return;
> +    }

Above change seems redundant since caller of the amdvi_page_walk(),
amdvi_do_translate() checks the return value of amdvi_as_to_dte().
amdvi_do_translate() returns when it encounters -AMDVI_FR_DTE_TV and
does not call amdvi_page_walk().

Regards
Sairaj Kodilkar




