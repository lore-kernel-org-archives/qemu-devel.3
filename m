Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D19C5DF89
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFE-0006sG-MH; Fri, 21 Aug 2026 07:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEv-0006oK-Np; Fri, 21 Aug 2026 07:16:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEp-0002Gr-60; Fri, 21 Aug 2026 07:16:48 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Nkwt1903316; Fri, 21 Aug 2026 04:16:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=P2oDmJnretmwzj3tbHM8acppmiBsrtqaTEQ7Mq3ca
 zE=; b=C1BuyzQc0T41a0XrFCElWKfYaj7uBYiJAzO6OaLivm/FSWx3xlcGsBGCY
 g9gkkM0nvBmTKqEKftChcZuDH+bVDPxhwHB3wbbpnLwYsCEYMU7sCiniWXkg57fy
 1GKTFWzbSnZQ7XkNb8t7uTUmgMuiRiuqyk+/Zkz0z3fnH6nzF/infq708H1MmSD2
 Ww8cXv+7LWl8w2UYWxqsr1RA+hIgi5VsjT3/RXB0iKXiVJFm+JwPqAYy4KQaXty1
 dOfpNZ4e3GIhjCWt4IeV/mi41bnp9S/cdpvz8phwkx+/ontYM4bLtznMsCiTocNw
 zyLCP3phYhUFWw2N+GlbhP9vwD15A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021073.outbound.protection.outlook.com [40.107.208.73])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0u5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVRYEL1zsolwu+evkN/+/NOa6QqQ7cqUrBcLjD0W99Qsi+pvnDk9GF5Jw6HjkBpPyVqDMDTSP2ixh9Gu9HOvg5IWG6E1HPP6350QkGQq8bhuIISLOP1860Uz8B0iY+MxZZudU7ZMIXEOoiMa+w9GdcrqB37One794vGuhw4dywcu/ynBFx2WAHinTJPG3BOUfWUWY1IskFRLMwuEKOBT7HD6ao5Ib1RMh7hMEsIY6bPmfEMw+sNP/9NJH0hp8155aFZGgaD+XJClsgcfTzCg07h54fDgN+QIWMIAkIJCb9aKjzqU+YoMALscD1w+DY8zmxjF6bdTlEZjPip7FjzR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2oDmJnretmwzj3tbHM8acppmiBsrtqaTEQ7Mq3cazE=;
 b=mG+96GKxdZ0z3d2PTyQ2gjGgZWynUNXNc0B2G6iOS2UFUGPmgWjMFPgUXqcqwpzOS5G8gBofyQ0a/udGX9IgBRhVkD57KZzR9XeN4/PQVu/cE2DvLZHBXMN8oq5K6sfoAfMM7Wrtw+Knf6tdwZFINLdAmuS1bCeKh347dg+SY/Ng8jAdjaXbsf8pNcZ3OO4SJX24m1aECU3JjtO3LZ2rVJA0QneQ7egV62zwBtF1hD9Q2M2RS6pyZv+0JKx5iYEYas9rfUZQ9FUWFzB+xDOiSMraJsG9jwRfLjcHp4ygcw6mMsaYRocXJ2CN4GOo3zFazwaIamX17ZQNbg4F2i1BLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2oDmJnretmwzj3tbHM8acppmiBsrtqaTEQ7Mq3cazE=;
 b=OIO8zOwyrsow7OiFJjd+XJxPw38aRrlPIq1Nkr6+o8WwX6vHlUoO8E4cThEk6//Wr10VT1Uxl6e+JxrAjNkxiN/6Q9G7OEjD96rpF8syEYqxnhfNx5eJq/G+L7R8tobPBcEhrXKm9C4GB2proH52urflbkZX2QY8Zd2MP35X7mgM17qa2v96Ub0i4JgV/iy+UL5QvZhWmy8AhRGuFbw4Jf1CtNcqRTr5ftO28AhXXrZgrb3hNE6sjHEP+xMp8PfwJ2i5IE4KA8zzRlTtQQn0Un8ytC0RUC2esQbn33Gk5Czlgp57bcCoWrRgpG0rjZ5U1hYWBXl6/RY4cZEtid31IA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 10/16] qom/object.c: add
 object_class_property_add_bool_ptr()
Date: Fri, 21 Aug 2026 12:14:22 +0100
Message-ID: <20260821111550.276011-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: ef45ea15-4f7a-4256-c009-08deff75a404
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 6PxyrdgnbXjy2gVARfxWMuQuZNvlez1G4Ano7VirT0bRzs+fcLZwTwqKRXVNX06aTp4Csyjdi33G955+C8ZR8onVrGcDNjyTlyIBcZoeb7823jRWTF7hBepSsogGl8APT3oZtgJdQBw1rL10UtxXSw57aqF/xenQ+HpcHFb1RPhpfL8Eb/oG57X1MlXraGA+UuNbrjiN4LcABFC7dBc1C0x5LOh4/VchIABXtYuuQrOo0kcmz1eAsfjpoG7wyQpCN8amOCQHmQks1MCUnxaEO1PEJsjNvXt6yQiqefoeDYticcMAFLobXUHWLIcXl1bXMq07Eopy/7wmbiJWSbyn/uSXhpI91uEHQ/dbAOu2xfSk5EX6xTPMBqog/bGs+Od8Qwc8weTCUyEDjwZl8cXOULLAuiPbSJK5C42P5AiqwsPSpeZME6KnJdo7zMYtyqEbDRvUN0wfQgXyH+FVBmk70HQ0amZ64GxjvrcmMoJ1z/AFg+A66bpaiUo6J9osq+VLL10pSvNJ4tCPc2jL2/YMgv0txLXYa1/V7+bm3B5Er2qwiLubahqZRJALcv4YYDKENi40dDsVyCtXy+iiGYrHmo2gBRYKAf4KPBFiTaJ0tUO0i9yhi0Oby70NfePUCoFffCFa5fH5lPNDHuGiCwt2h8K3+Ec/i786W9S1kt9bbrrm7q+43FRLmJekf3VA82aG8acowfL0wGO4q4oB+zy1Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNodEh5SkYwbE1oZnhESmtZKzM5TDJxb0JOQzhkVUZGWVdwNWpVVWFYOW1V?=
 =?utf-8?B?ejVCYkxxeGRLMDZleGZqMm1NR3lZNERVVWxjd05wRU14NFZsck9kVEUrdWIz?=
 =?utf-8?B?S0tDcmVyV3pZZlFONHJEb2Nhc1p3bWRuY094b1piV2V6TTVEdVg2dEVhY3Ew?=
 =?utf-8?B?TGVkdExpKzFNWFY0SktKNUpZbWRmWnJaZkNTbWVXV0R1VjlYa2ZvNWdZc0V2?=
 =?utf-8?B?VFdqenlXSXUxNlhLeGJma291b2VhSzVMb3JWeUowZDNGc1N1Q3hvS1ZpUWdK?=
 =?utf-8?B?MkxZbjh5WDdjM1BWd3NidE81cnBQcXZFaXN4c29JU0xXSDRDTk9DY0g1Ym85?=
 =?utf-8?B?YUVSSHp0b2NhVVFUVFlpM1NSUTJ3SGRKRTlMd2QxMUpKdFBxdUg1REdzMGlE?=
 =?utf-8?B?VG4zeGRhYVpKVDRaWmVIVnFiaDdRYVFUVDB5UklGU1d1MUJaU2tYemtxdFpj?=
 =?utf-8?B?ZWE5ZXArcm4zRjhhWHRBS3FhOGNBcS81YVhaL1hJTDZoQ0paLy9ORU9aWkcv?=
 =?utf-8?B?elZnd2tJVFFQVTAyVlAzUStNZlVSWnBDTVBmZlhLY3luT1RWZlpFbTR2TGtU?=
 =?utf-8?B?bjhCZWd1UDIrNEVoQmFoNHdzeGU4MXRIZWhVRXM1WjBwTWF5OVl4WmJWdGpi?=
 =?utf-8?B?T1M3QUI4R0o0RUVTM1UzbENYc1MyZU5Ed3JuSG9NWk5pSmJ0QVN2Q2ZYMnFR?=
 =?utf-8?B?bUQ3MjlHVUpWQnNnOTJTRWYxUmpBanlkUFhSMEhhVFBBQXhvVThVQ0tTYWJM?=
 =?utf-8?B?U3ZrN2I4K3RRMmZqMWwvQTRka1d5bmRPb2RZRHZkZ2c3RXpkaDBIMWZFUmpq?=
 =?utf-8?B?V0VEUUt1bDUvdlNNb2ZrMlR0ajBCb1NrSFFvRkpaN3hXNUhDWGwxSkxaUnZ2?=
 =?utf-8?B?SjdXUy9mRDZRWWhrNjEzL2lROWdrdHJ5VktKM3ZZYkRTM3hyZ0dCelpKcERB?=
 =?utf-8?B?Y0ErY2hlajNsSTlHY1JZYURYQWsrc1RnTHIwbXZrbVpsSzR2VndqaGVQVlNW?=
 =?utf-8?B?OVJoeGhDU1ZINm5CdTNLODFaSnQ0SGdjS0tpdjNZdU8wQzZKQVFHTll4cm1k?=
 =?utf-8?B?amV4RDNQNEZvU2N5ZHFWWTlBbWsxZitLMEVsVzZKNk54MGFBS3NheTF5YnFN?=
 =?utf-8?B?V3p5WjA5dWc3TmJKYmgzMld2YzZzYkdUajdpUlh5TUVvNnJ0SmNDMWxLRzNG?=
 =?utf-8?B?UzJrRkVheURpZFVHSlJxeDUvVWlMK3drd0ZWMkFmNGxQYy81RTMyK2RxNFQv?=
 =?utf-8?B?c3RjdDV0Wm5GMktQWUJkTWZvclFuRnZNOTRnNmlhUG1RWWMwazVRRm1sb1Jz?=
 =?utf-8?B?MlE1cjNhOC9FRE5JOFdPa2c2a1pVUXJXTGtQdm5NcnRyZ3ZiM1kvN0lCR3Rs?=
 =?utf-8?B?Q1ZpTEZqZDFjS1ZiVTFaL2Z0VUs5K0R6V1NKeE8zZXVYa1B4VERYRlZoRDVv?=
 =?utf-8?B?SElMWTdPTnN5cFptQ0JycDdpSXNYak82bThNSFBGSVBINkpGaFhjbUkzTUlw?=
 =?utf-8?B?bVkwdHU4dExObEVJYnhYK0F3ck93NGl3MzI0Um12cTk1bEY3M0swbmZsanZK?=
 =?utf-8?B?dzBMcjhFOTIxZzJDSFBRQnZJb0FFSEdTbmZ6cWgvbTFrSE9jK2NFRE1XQk85?=
 =?utf-8?B?WWh5TGgvaG9VLzJGU3NVcjhWTjRsSXpJMGQ1UkI0ZlU3ZzVHTzdrbFRjOTVn?=
 =?utf-8?B?RHhtUll2bU9ydFZFcFNDOUMrZkFrSzF2SllYV3duSFVlbGtMVVM5SS9YWUN6?=
 =?utf-8?B?M05ZMGp2d0xhQk8wdldxcnBnNjVQbHdJUjA2NUIxYjRyQWRKeTloRVkyTWFz?=
 =?utf-8?B?RDdZMDg2d0dPT1ZpSHptV2RpejJEcnJaQ0s1RWpmTHBoQlNNcEw0RmJMVzA0?=
 =?utf-8?B?R3RVM0RIbGdVY201ZVVhbEsxNDZUdldXdXZMa0RhdEIxb2h3RlVhbG9PMzNl?=
 =?utf-8?B?UWRWaXVjUWtlM3VVY0Q0eW1qTGUyOW5hWFNyUjdNbndZTTZOVE0wRXFhNkpK?=
 =?utf-8?B?OG1NMGgxeDBaQnB1WGxaampyb04xWVVTekJjRS9nc0kreUROd2xUZjR4YjBF?=
 =?utf-8?B?MHkySVBxVkJ5bXhSMTVmaWNSR0JJUlBXK0kvcE83Z3FHUy9hOXgvTnZuZDJ5?=
 =?utf-8?B?TjdxR09WTTIyak9YSE81cTBGS0gvVDVwMU1Qcmg0SlZIRGR0T21WV3lKYnpu?=
 =?utf-8?B?ODBZWWROQVBnYTR3VVJmMnpQNFl4SkJtbmlmVy92UzRqcWpFL3IrSGFqMnc4?=
 =?utf-8?B?LzBSU05iTWJvYWVTYVRuS3dmMUh2OVBWalhnbWE5cWpRMjI1NzVYMEJYaU9y?=
 =?utf-8?B?THBvbEJEd1pGY3ZmSzVYZTRrVWk2WUpqckg0SHNDdlViMWUvblFrWjBUenls?=
 =?utf-8?Q?+pNuf+AsVCaPNhaU=3D?=
X-Exchange-RoutingPolicyChecked: iy+cLZf+E7EHc1Nfpk/aDr04tAnTL1JP0Ims5f1qAjPUT5DZTLv7FEH0wzxoG2ImC02QHmdEBKQAZ3Vgr4urKj3gj4xNL+LUY65jU1uNurObjOTVfW6ayyF411U3uicc2uJohu+iNrs0XIltTYm5A7iI2s0sxoLmwO/rNxBPB1rQlf1cDvWCYfD90fcHmB1fCiftOlrRriXcvL7HshZ4Ab+EUqgZWCrixtlirXkfCCgz4Yun6i4cv7EBS3E07bX7eGq3Dwhx5H/o1fYY2mG3hJDArgHH3Ep2mKhyAA/p4s+MGsFhxyaitu0nJbIBWD1rzYOTNzZFIFA/oJjJpvYx4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef45ea15-4f7a-4256-c009-08deff75a404
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:26.4738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgLpx01UOWy+mK9BeYZ8vc2Mdq7hRPU+arMtOc9x96I8Ei9JbYTf6o8ymj2QHtMoNmW/E68Y8E9UobiXRhJ82u3oNtzRgjljTOav/p/Ltbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: XVvU5xhIl9cNkrt0kli43EKy-NKGMd3-
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a883390 cx=c_pps
 a=f2HnxUUJxMzVcYZpCdj5LQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=kDmwn9SJQQ73BrzAQp4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XVvU5xhIl9cNkrt0kli43EKy-NKGMd3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX1SQ/gx5C+Zlb
 qUrOs9XHxnQAvcKnCqrEad+D5ReXGSzjJH6WkXxZ5CafYCaLvBpN3mo1l7qQ1e4cALziZtjkuEM
 Tsav992pWRDK8XYYbxywb7LuYXUk7jcuJhcDGTS+XGp1vLsZF7+PSeeAhwC2EoRr6Tj+CxuZCg5
 el8OCN6MY7slo9A/+jwVsKSBERsUkPm0yPxZD9rXnqSrBpEy+s42l1EZFxN+4OogRUC5JyT08pe
 3kYueU4mj5eqPlKMljFWlfuFhv6aI+JJ0DAy9U60tk21eXzactKu/eSCzlZpyQ/Nz1IbXvjOyA0
 Koi2AY+PJc/fDdVKf+TWS+k5a8bUa5nOrxeKJQHPeFxrxXsRvGUE8XZpNlLWS73lulx/FWGSkvx
 v9s52oCK2xucnO1AKDE87uvOfpXc2/j/QebwA7V20ITGEWksyMuXZQ0Us/jhD3AorIkEv5BOZ0U
 ZA5NgkdcyTIpcS2yVIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX8UCxcaqe0X7Z
 DN5rmqmA12+2WF8C6/B2UFgHlDgaAPgnoZi3PzZb+PS3BQu6GxsjD7hf8BPMhYI/vj1v1Y/94GR
 QAh6pHZ19RfkdRe+dDeV6Fs/Rdh5kog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This adds a class property that references a bool within the object instance
and is intended to be used as a replacement for object_class_property_add_bool()
where possible.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 8dead29284..de37016ba8 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2017,6 +2017,24 @@ typedef enum {
     OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
 } ObjectPropertyFlags;
 
+/**
+ * object_class_property_add_bool_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the bool value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an boolean property in memory.  This function will add a
+ * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_bool_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_property_add_uint8_ptr:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index f91764aaa7..635eeeac77 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2750,6 +2750,49 @@ DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
+static void property_class_get_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool value = *(bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void property_class_set_bool_ptr(Object *obj, Visitor *v,
+                                        const char *name,
+                                        void *opaque, Error **errp)
+{
+    bool *field = (bool *)object_class_prop_ptr(obj, (ptrdiff_t)opaque);
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    *field = value;
+}
+
+ObjectProperty *
+object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
+                                   ptrdiff_t offset,
+                                   ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_bool_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_bool_ptr;
+    }
+
+    return object_class_property_add(klass, name, "bool",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


