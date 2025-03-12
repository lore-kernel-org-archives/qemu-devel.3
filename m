Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA90C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 04:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsDXf-00086S-Pj; Wed, 12 Mar 2025 00:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tsDXb-00085Z-2E
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 00:17:59 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com
 ([40.107.236.60] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1tsDXV-0000cq-Nd
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 00:17:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWh3hDcnwaKLo0JhqSGx560ZUbYppzg8akclVeDOWDSlnWQ2J8oOc5XozFUfbhZLAjmIMNGuRBPpWxu+R5uIZPpqq4rtQis6/CqncYQbnZaZ+7j0DDxURuXPnbJp5LvLDR+iDPt0PpnqjleOF1cIfmTUzYKylJA3JVNk5PlakhCXBuaVzadQCIltrjwPzgub+UkXFpEYwseBREHMWEqF+RXdO7zbr5rzFblb7OS5r36FH6HVw2esORK2BiA2711fgrTOttJ7ZB96R1FTcfW0pJuFMnjofzlPnjmr6ZGU4x+TDeeklLooZ4Wi0NqiMr12XyQ4t5DBdP6dZjOqOs67mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKGhHbbVNEHn+R+dyjAPC4hhpR2TEsaQgLLbIWOgJIA=;
 b=yez3HU5k0pmP3izAkZt5mlwxCz9FbZLTK27Vyk5yzx0b6nh14PaSiGLdrLGVYjd9aIvP0PY6p9Qgw+u73HME0xZVPHtavGp6GQaFo7AI+lH7LeUgYb9/7+jVWiPVUg26msmS+WW9NXEy+2qSuToxrpKBhOkB0wncpsJo8NwRqdWwKUbaFesnzpvSfJ4eskztvGcgg/8QiTRTaC6dffywg83sFSQxGNo75uJrQIk9zXVjqfFrN1elv7V+rKAVI8pyvNgb9qihEyBi8BbOZj1zxeFvVxP2xBEN2VR8gbYBt0lFyFbbrQBna5ssjwjoypAzBeCgJo+06sjokhjL4vMI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKGhHbbVNEHn+R+dyjAPC4hhpR2TEsaQgLLbIWOgJIA=;
 b=vx65G5n9K3+7GlLcxzkFaVFPfDtNvHy4ZVCb/E7feaPDVY/kMtd/bRpwRDoQw8gx5Mo5V+KfTqwQkxwYv0Jj0icXRgloIUJ6j5BYIw+AVilIeKxydeK2rMY7NEh7CRqLItnYcwLxslvSo7vpt4IARQtQ8eResWemCrSR/N442N0=
Received: from BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 04:12:42 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::d) by BYAPR08CA0072.outlook.office365.com
 (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 12 Mar 2025 04:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 04:12:42 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 23:12:38 -0500
Message-ID: <0be5765e-2ade-4743-a089-0846f60943dd@amd.com>
Date: Wed, 12 Mar 2025 09:42:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mst@redhat.com>, <mjt@tls.msk.ru>,
 <marcel.apfelbaum@gmail.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: "Arun Kodilkar, Sairaj" <sarunkod@amd.com>
In-Reply-To: <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b486e40-6859-449c-a07d-08dd611c22e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OURPTXZUMGM3V3NNNDBWaHJGRW1TL3FORkpsREkvUzVPdExRd08rek9DWUtv?=
 =?utf-8?B?S0dhbnc4ZHdTVkExUE12cFVwbndRWlF1QWJ0YnVubWtoc2YyendKSUg3QzBC?=
 =?utf-8?B?QzJ2aDk1QktRK25SQllzWHJudGdQNHpWUVNudzlRb25RRmc4R3NLQmpKRUhR?=
 =?utf-8?B?bk14TlgrakQ4Q0xQOVpKQU5RTmJFemhlUWREbGFDRElCdGwvTjRFeVl3dzhk?=
 =?utf-8?B?dW9VRGdzajhxN0UzNkZKa0NJcmc4Z0pSakVqMUlFMjRUdTMwZFV0bndXMmI2?=
 =?utf-8?B?WE9zOWsvUVU2VExsd0lYcUJTRXZaMUhXRHV3UksyU2RCd3NWSjZuY1Urb1dQ?=
 =?utf-8?B?c2k4VnZ1MlI5YkRtM0lqZHAyUjhrL3RxNkhrQ2VZcEh5UGZ5Yi9ISjNva3ZF?=
 =?utf-8?B?d05ibnhVR2lxeGE5c0U0bDBjaE5BTVpwNXZoWTFHb1ZQajZuSGdCalhoUGht?=
 =?utf-8?B?blArRXU5eU5OdVlLMXo4NnVubDNpUEczV1lKeWUyMTJhMWxDeGphMStjc0JG?=
 =?utf-8?B?amRKME9PT1E3Mlgrc2Q0WFFmeDV0dEo0U3JFb1RwM0lCOXBSZmNCeW9UaStQ?=
 =?utf-8?B?aENTc2ExS2JSVUVwWHJFWmZsOFdDek96ekh1WFo1RXdobUNyTkFqOFV4SnhO?=
 =?utf-8?B?dllMREpYaXhyTU5tazRiTjFIUXR0RWdVL3h4dXpyVm9CWXdwdXFYU0tiL0Q0?=
 =?utf-8?B?b2FEclJTMzFaaGRVODBZK25jbUZXdjNtblFiVnBRMFNlODZTUUFPTmZSNUk0?=
 =?utf-8?B?TnBzNFpvcURJa2VFOStPNHhtZHJMZTBXSDlhQnJUWHdkdStoR0V2VEhjUkhh?=
 =?utf-8?B?d0RuQUttOFJNVjdJZEMrMjJTZlBweklPQ0FxempPMGl4b3ZNNjJQbEFlUGRh?=
 =?utf-8?B?RFhmbWpNRnUrSnhyREZmMENDbjhsU1QzaW5VaDRXMmVkNjhRQ3RhSGprMXdK?=
 =?utf-8?B?eVlmZy9TR1JlTWdTcFpDd0Z0YTBNMzg1WU9EVURMbVF1a1l1QUpET2szMFls?=
 =?utf-8?B?ZVZFeEpueXJGOGhZdm1QR1hMSTdEcEJIbVB4azNsTzNiOGQvVitVVGxZUmdY?=
 =?utf-8?B?Wkd4WXpTM1hIN0lsMVlCL2pDN1F1MXZTNkM0MXZtVW1rTkhDam1teXk1ZThi?=
 =?utf-8?B?QUxZV0JqZ3FjeVZWTFpzV0E5SVlWUldlNStmMEdVKzR5ejBQYTFvQXUvOWls?=
 =?utf-8?B?bElnMlBUalZycUhiT3EvQkF1VjRQaUVTemJXc2hZK01XcVRQSG81OWxuNzh6?=
 =?utf-8?B?NVVMS1pVY1RVaHBVMG5sVEthelozQXBXQ3pxNDRyc1Zlak4xYUU0RmlmbUZF?=
 =?utf-8?B?bEhFS2t4NHk3MU8rdFFLOSsxS0hLaFJXTGhiVGprUUdyY2VNY1RVeVlGRVVG?=
 =?utf-8?B?MGtVU2svZ2w3OGZpd3FOd1lxRzAxeFFoWlBiVEROT2xFOFdPYlhWekRjWlJC?=
 =?utf-8?B?NTMydXhqRnJNbGg2WTl1cTNvaVluRUlrZ1JSdlhPS3NzaHNRRkhFN2t0cHYy?=
 =?utf-8?B?Wko3aGVxRG9kRmdDQXZPQnVOekMrWG1PdG0weWlVNUFPemhNb3lmaFFuMXNv?=
 =?utf-8?B?dmNieHJ0QmZ6aGpVTTZSbDRYZTVFS0hrWlRqamRWK1pPWWR6N2Z2Y29NRjE5?=
 =?utf-8?B?V0p0bzFsUDltRjNReXY2RmdRTW1LR296MmJlUVJpMllDZGpWcHZDa3A5WGlG?=
 =?utf-8?B?Ykcxb21MbVpjWG9GVEMwQ3ZpMG1pVzlnUm83bVpNeHBTUkVIMndYbzFTMHM5?=
 =?utf-8?B?U0xISEVVRWVsVWtqNVFvT0VMTVNicFBmOGRBTXdOY3ZFd2dybGVlQXozQkMy?=
 =?utf-8?B?dGlmQXRJYXNmRVpCNlJnSDVsVVNYelBpT1A5SVhwSC92d01helEvRjdRc1Jy?=
 =?utf-8?B?bm5UbjN4NGpubXJMTHJmTjMxWS9Zck16eVUxcUlFdzBrRW0xUjQrdGN2eWh3?=
 =?utf-8?B?QVZGRC9ublR2bXBOanBsNy90d1RSWTJXWFhlV29XUTRselFNQlBNcUpmbVU4?=
 =?utf-8?Q?B2psqsIjaF2Aadn8Lua4HZHrQK+rGI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 04:12:42.7499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b486e40-6859-449c-a07d-08dd611c22e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
Received-SPF: permerror client-ip=40.107.236.60;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alejandro,

On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The DTE validation method verifies that all bits in reserved DTE fields are
> unset. Update them according to the latest definition available in AMD I/O
> Virtualization Technology (IOMMU) Specification - Section 2.2.2.1 Device
> Table Entry Format. Remove the magic numbers and use a macro helper to
> generate bitmasks covering the specified ranges for better legibility.
> 
> Note that some reserved fields specify that events are generated when they
> contain non-zero bits, or checks are skipped under certain configurations.
> This change only updates the reserved masks, checks for special conditions
> are not yet implemented.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 7 ++++---
>   hw/i386/amd_iommu.h | 9 ++++++---
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 068eeb0cae..8b97abe28c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -848,9 +848,10 @@ static inline uint64_t amdvi_get_perms(uint64_t entry)
>   static bool amdvi_validate_dte(AMDVIState *s, uint16_t devid,
>                                  uint64_t *dte)
>   {
> -    if ((dte[0] & AMDVI_DTE_LOWER_QUAD_RESERVED)
> -        || (dte[1] & AMDVI_DTE_MIDDLE_QUAD_RESERVED)
> -        || (dte[2] & AMDVI_DTE_UPPER_QUAD_RESERVED) || dte[3]) {
> +    if ((dte[0] & AMDVI_DTE_QUAD0_RESERVED) ||
> +        (dte[1] & AMDVI_DTE_QUAD1_RESERVED) ||
> +        (dte[2] & AMDVI_DTE_QUAD2_RESERVED) ||
> +        (dte[3] & AMDVI_DTE_QUAD3_RESERVED)) {
>           amdvi_log_illegaldevtab_error(s, devid,
>                                         s->devtab +
>                                         devid * AMDVI_DEVTAB_ENTRY_SIZE, 0);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 4c708f8d74..8d5d882a06 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -25,6 +25,8 @@
>   #include "hw/i386/x86-iommu.h"
>   #include "qom/object.h"
>   
> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
> +

qemu provides the similar macro 'MAKE_64BIT_MASK' in file
'include/qemu/bitops.h', you can use this existing macro
instead of redefining.

>   /* Capability registers */
>   #define AMDVI_CAPAB_BAR_LOW           0x04
>   #define AMDVI_CAPAB_BAR_HIGH          0x08
> @@ -162,9 +164,10 @@
>   #define AMDVI_FEATURE_PC                  (1ULL << 9) /* Perf counters       */
>   
>   /* reserved DTE bits */
> -#define AMDVI_DTE_LOWER_QUAD_RESERVED  0x80300000000000fc
> -#define AMDVI_DTE_MIDDLE_QUAD_RESERVED 0x0000000000000100
> -#define AMDVI_DTE_UPPER_QUAD_RESERVED  0x08f0000000000000
> +#define AMDVI_DTE_QUAD0_RESERVED        (GENMASK64(6, 2) | GENMASK64(63, 63))
> +#define AMDVI_DTE_QUAD1_RESERVED        0
> +#define AMDVI_DTE_QUAD2_RESERVED        GENMASK64(53, 52)
> +#define AMDVI_DTE_QUAD3_RESERVED        (GENMASK64(14, 0) | GENMASK64(53, 48))
>   
>   /* AMDVI paging mode */
>   #define AMDVI_GATS_MODE                 (2ULL <<  12)

Regards
Sairaj Kodilkar

