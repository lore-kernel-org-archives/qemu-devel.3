Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A574C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyt9E-0005kg-3i; Tue, 25 Aug 2026 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyt9B-0005kQ-K6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:33:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyt98-0002JQ-KM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:33:09 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbQLI537895; Tue, 25 Aug 2026 08:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QdvRzRQkmKmMT0lFQZVPVMaADzrYSIp5wXA+dKPx7
 3A=; b=iEpbejtdIp/vm66LdwOexarxN55B4fpNckkixvLQFTGKZcUNFSm+ZQLfQ
 JGwW55dDObSGbxvZekSgGJYHUSg6RSM8TZG7jGAWm5KMYr41jNfElp4jbG9NEKlL
 xxJ0mfXnTWP6rJyT7zjPxa0vucAO2vgNhoFX8QM9UiVVEmFoT+1jihMCizIOhyfp
 VQLltQ4qpiyFaoCS+50nh6vSuGb93l7x4InpsPdmMLI/Y4NNaazgi+GQFcRm1Lty
 dbhLrM/LAZjV5j0OPAwVr928varajU4fuxajyrx9SINWTSBc6/f7+XMgEpGwDHyR
 nHgK7/AEh/P4HokHnk3bd+5SNJR6g==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022094.outbound.protection.outlook.com
 [40.93.195.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as12yb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biKWBXuJTK/3IXp6xEee6Tsnqa1KESRvefFsExTiOzPwfHiUl3BAulX8VI1ZVlY9krwb5tbXGn6hmlK5o2HjJWsENLV/JGDJVzBqzi+Lhi1U+1F5y5sqKgpcx6MnrHDobcg1d+aSOqGROF8rWjx/venw+Y5Q+Ivgc0t8nUYcUGO8N5nMrj/MN5wL+/2ekMyBy/+Tc0QXTyGcnxMHdqK3l47aF/D+emMxsXYcoOb4mPOb+llHgEa/8N7a9wZc+m6jxAzpy2MrgCDSmIQeMN58jyMPD1IsVpEVJcLZBadGIZEo8bIC8lwCC/x5ulQ+Lzuf9GyLkdo/PZFNhophQpdExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdvRzRQkmKmMT0lFQZVPVMaADzrYSIp5wXA+dKPx73A=;
 b=k4y37pP6hV4GnQuWXdurjEIj/QlWP4J0sG+o/RlR8hoXHk8u1eYvtKOkCWsxW4d+k3RIYVwGdAHxAt9kqY15wWo8uVilFqDS9ioJeqyJAN0MhphxPyuSLCC9Fq1uxvZM/bUUxlhy1m//mwXC2egRg1HF44hG9WvFuJQb2OH93flAyf9RoF0cLzwH0vDQQCMlO5OfCA4P4SrFm2dwwZPGx1RQGbVPt9uwOv/252GPPYD04zXw9JAzbHIx+lbnoQDnVKJVh4M0vNWPocUsmFffoHKFb7XHkf+MPo1491r9Td7zVmTgTSOYX1AyTzye+BGxKO3bQoZOT2tzmFhGMoJ5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdvRzRQkmKmMT0lFQZVPVMaADzrYSIp5wXA+dKPx73A=;
 b=RlwcGAVeYFOxEGaVmit8FV/EfnxcYjTIqNQAaaMEiNWLHfvIWdq2m0PRQiFN6+J7J3gsc/NwkAg+Z2JVDv98zRgedRl0+r0mBgxjYUEWq08T9E+JTI8KJe0XKGNcb67X8lHdJeTWAv8zmfnHFQrGre4iv9X3QnHTM5tdPwXYRHpl/b3fZ486JmZz7L+1ktPVHNlXk9VfvAZ9wtg0jDujeBtjjCxWg+TfnKd90wClZAsgkfgzT67FM/Z2/i76YKNjC2KW7DZBT8Q8zjnzARl5hQhvwPt1iQeEZvopaz9hA3Il0MByp5fA1WsoDV0wpxBQcM8xwS3O0AuroSufDYXLlA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11818.namprd02.prod.outlook.com (2603:10b6:303:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:32:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:32:55 +0000
Message-ID: <ff0c0539-c24f-4c5f-91bb-38168d62a36b@nutanix.com>
Date: Tue, 25 Aug 2026 16:32:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/74] qom/qdev: associate properties with QAPI schema
 types
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11818:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af214f3-68d7-48e9-c8b7-08df02be2268
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|3023799007|4133799003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: cxqQFEBa3pZHOlCWwanv5gOwsZZ6nYvenHiIYJ02NBMDGYLqYgFoaszM0COCxC7TVRO9kLQFAYiCU268MeNwNniQCfmE0cvJzgYF2sy0uy/aPpSqtp3xuU5AIhvuxqh+1Mt9GX7wfEYvaq2EXf1OkGgogeP8mXEHtJboffQzoFmW4UuFLgOGtzZLaCPn6+epZAV7uhqlkOWytfvkRsAy6Fc57OhHSCKMSiaVD5x3+9S+fjVi2lGCevieY44XU7cwrpihfp9f2u5nV9ztwiWhsqtsCGFvW3+chJeQeofJ73L3QQVWr5MExC5vNaJm3K7l24qKDgkPnKfYocfxIXr3mTycq93qfsXdDAZecodmA2lP/khNYhg11l7g48SHbbGAWX93FCjwONZkBp6fVgnXgLaq8mwSra3Ljr4n6W95MUHK8K2Sgn2YNYSlVYaetwE02c4j3FZLMXDulHb/X36wpRwt9plLQnNCQqzgER8yMSSQmWN7BBlcwr78/bFsIqjOTvO9HsZWHHsMDoVu7OVsLcLsNqlcNnfrsF0csEtBfUTGzhrozNRC6WlCmYYYNTNW32Gz6ep/fJIBO/XtKSi1sNhKFmdjf2yQfuem21sA2jojmbtRWp+iRhgHobXVQ0FdlqwkpnzFTaK/tLmRkB8bWFskTYxsRzGsig/ABqIbXHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(4133799003)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a05LT0FvVzV4Z1pKMUpEeHJiYzRFWEVEckk3blRWMnh2ZWlEclZRSkhsbVpn?=
 =?utf-8?B?aWh4MkRKMlFSRnYrQVZBV0R5ZEg2MlY3c21BaHE2Y1ZxUHQ3bmd2SUx3cGZH?=
 =?utf-8?B?MEptN2ZFK0YzY2hPb0M5em10MWcwZWRCVzhiTjI2NSt5dld4SE5LRWNoRUVz?=
 =?utf-8?B?V0pvZnAwNkxrZmhZZHVidUlXdzRMTTVlVFJJeWdEVjNxMDUyUi9tbHlFcThx?=
 =?utf-8?B?OGJ6bmc4NGNtLytyNUFqcElmbkMvNkFDYjdrUkdNUnFWTGdIaFNSbm9ZUjAr?=
 =?utf-8?B?WWxaekFnWUFjeFBZdTdmUktUQ01sUWdGT2dFTEZNWjgvU29qQVRoUzBOd3Zt?=
 =?utf-8?B?NE5sUjB6Z2tDczFDMmdjL0EyamppamhYY0VVbWVYakplNGtjekNpcGgvSkxm?=
 =?utf-8?B?bndjNkl5c2ZkK05ONGh5VTZtRVJYUmNLSkwzSHBteHhXcWpGMFdVVXI3cndu?=
 =?utf-8?B?RDNUWWhjQlE2aUYvcTV6UFQ4M25WeVNBRVQ4ZEtWTmRJYzBrTUJHRkYvWjRO?=
 =?utf-8?B?RWFGOVBFVlcrQUF2U0FSRVp6UHhtdW95cTJXWEordWFySUlVTnJ6YzJ3WXZ2?=
 =?utf-8?B?MmYxY1VsU1JLbTlObTg2aDBWQ25CMG0zVnZOQUwxZXVqTDg3dlFTNWt6TmNu?=
 =?utf-8?B?RDFUT0J3Z1J5WWNDaURib0FEdEZ4Unh4UzJuQjMrckYxODZSSlVlNkRpZE9j?=
 =?utf-8?B?bDloSkFZbkVRcXMvSlIyMndHM0Y0dXVQSzhtVkVYM0FFTXpOU2pXUkwwSFFl?=
 =?utf-8?B?MFBtam9TQTdLbXhkYWsyWGNYUzJ4S0lIL1Jvd0MvbWg3RFdaMW1lcGdYWGpv?=
 =?utf-8?B?STBQY2FGL3cxaEhHQlFrV1RaSk4yd1FBNTRGMHliSE5rVGxFUWRyNHl3U3FN?=
 =?utf-8?B?TjVLRFBZSUlqQzNDV01HQzhtTXB3Q1VodmFnSDVVM0xQeW5oQnVTaUxJYXVF?=
 =?utf-8?B?dFRYa1BmRXhIbllwNEd1ZnZjSVlXS0pNMmxmcElVYlJkMmhRNFdOWUZyY3M4?=
 =?utf-8?B?OWcwRmxmdFIvOTJpemFtc0pBdmxuOVVkNDdmeVRabVFKd1pobXFnM2xNS1RZ?=
 =?utf-8?B?bDk2NmJmWkpaWVQ4MVZ3MEFGY1loQnZtT1Q4cFBHaXIveUJMZUFTTER4cVU0?=
 =?utf-8?B?aU5PZzJWYkdudkJGZzhYZndtdTdDT1ZtZzR4NjZzYTBBZXlpN1JOYmZ5SlBJ?=
 =?utf-8?B?b3JWc3gxUDBvMlBEcVpJQkV6cmJpc3FBcDV1b3pXaWNpeVZzWUdUVzJ6V2hn?=
 =?utf-8?B?ZDZCeWw3N0F1Wk15c2pZSzZiQjRLd3VMMTcrYnBmWkFUdGJKa0NuN0dnS3lX?=
 =?utf-8?B?bmY3UjhoVnhVRHhiRVF6Z1U5cFpvQzZQZld4ajd0MVFyUHZuMld2Mlg0bkFp?=
 =?utf-8?B?WWtKc3diQURFVDg5b0krcnNYc3RXNVF4c1NwYnNGeWwwQ2hQTEVSbU1vR0hq?=
 =?utf-8?B?S0xMYnZFZ0ZEbWd1VFVsRHhnVDJKK0hDQi81NkUwVkxxVkpiWGFMbVVFY0JJ?=
 =?utf-8?B?SUhOblVwdmI4OWM5Y3NYNGV2bWFDVXdEcThnQW9xNE9Dc0JTeGx4UTF1STNk?=
 =?utf-8?B?RjlHdTFVKzdDaldmaW1NWXNHVFRvam9VamF3OHQzdjlsa2ZjVWZqMGwrbFV2?=
 =?utf-8?B?SGJPUFZ1c00rWTdxUTEwSnVqbGM4eWM2Rk9IQVpaV2J5V1Jud1F1MlRlZENj?=
 =?utf-8?B?d1FmREcrL0dKUjc0eE1OU1hXQm43NDhWVFZJYktoS3NTNjg0VmFyTUd6WXIr?=
 =?utf-8?B?eFdiKzBQSEx2a1VDeDlaR3hWVi9WZVpyTC9JN3d1Wnp0VzB0UllwLzZGQThM?=
 =?utf-8?B?cFJNL1VvQmpFRCtmVG43V2JlanBlU3orMG9kTmtTdHJ0QVdPYlp5djMyOEFh?=
 =?utf-8?B?ZHNUaStLMjhnNTY3cTlYd0oxeWpiWVhYeHRlbnhrYjlUUE4rNkFyc0dOQVNx?=
 =?utf-8?B?UC9waG8vWUgyZUZDdXAyNkJnS1BRUVFKVUYrTGI3TGRHazhuTDJxd0FicFlp?=
 =?utf-8?B?NkdqU3ozdytIMVhQRVdqc2xCTFRxdUw3Z0VZcEJmcHozWnpqUU1VWHUrRnJO?=
 =?utf-8?B?UmZrUTdRTHMzTGg0SFQxOXZuR1F0RW1WNExpc3FJYXErOTdUaTB2a3l2SmxB?=
 =?utf-8?B?Z1Bsc3N6TzZ0TUlIcFRtbVRSZ2w2aDJKalFLanFBcUpOWWxDSmpzclY0amFB?=
 =?utf-8?B?c3pzdWpmMy96MWhOSEtqQXRpaktGdFJXd0pmSEw0MFpqK0VFd2p6am13Kzds?=
 =?utf-8?B?SFZJVnFKaUtOMkEzcW5GQ3c0NG9LVU84REVqOFVtOEg2aTJleU93bitobFpw?=
 =?utf-8?B?cXE0cGFOclEvRUU2cHVFTHlpSDJSMUVpQWwwdEhtQjdBTkJETVBWRDJpRHBG?=
 =?utf-8?Q?VMoV9lY8bOO5+1ho=3D?=
X-Exchange-RoutingPolicyChecked: QjXdD2tNDsHfJGt3JblD9yuS6/VkBBkZEJPoVMZa98T2uWPTe9cTBQiv8+k17VER7t0TTVr+l27k/D9wSoj2knIwhbJxhTXLAtz2LnsFvvmfYl/kLA42gVGf4Si5Abwasq5vNu1pMDuCyYX4pvyIPSULvwk2g6Rll5Hy+wPQ6eI/hNJNPfebR40wTvmhyvwsQb6TGtm2/9l4wJuVj0qPijuaLzCeglZ62trgbM0GNsz7SHkUfjq+Udg9FfHvKzHmzSpuly+BJJSZbO7w5SnKuehFedGg1IJ0zE8wqDmxoANpYwLj018+FRGEBlWDn4bEdGgALVTFNR6IVH9AGvDFlQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af214f3-68d7-48e9-c8b7-08df02be2268
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:32:55.5117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjW00pM/xG+ckjn1ewr8ND1wj+irV35pXNjjLm8bs7ubd3TPrSjmxdFS27xdjm19Wv6x4JrBkdMZbfZvnyTQaQsKWXArD8sGb5KkhkhG+Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11818
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8db5ac cx=c_pps
 a=rF5r1hn1HlY1CZmlW+R7dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=S56xvJB5AAAA:8 a=ImJQ1LXA3nOkvlGg6vUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMiBTYWx0ZWRfX8TQruuzGCxPu
 M5JWRKJCaayZGoWCn+nqk6Yf1kpInPQIi+1LT8e/BmB47hZHCSnHImLLYFz0znh6tp9K87LIlaP
 tgVpcKbRQ4lVlwCGqGOKLgzphaqtqYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMiBTYWx0ZWRfX0iscwMZRl07r
 z6lg+ABQkXx7NIwsCfnxqxqoX4r6rJZ+XEt2JkVfU8UUqrwOCV64f8R5eR5N9ChpNX/39Wx6UDC
 3cM0WXrOZuGCqdiUG4gyhJrAcIVO9xI7PQ/duCWGCv/xCPpojYhNVOqQ/91hSCkQA9M3a6pgK53
 EDjgmkJvPQgvZ/uZDW8GDEQNTtBvxQhvTyhr7wGqNQw8KbouWHIbomrguTGeHeYfO1WHHrf4jwU
 eFwhsm9pzjbiO/yE3VYuRhU3U+cxYGlHb1RmNnZ3cF8y+wQWTrH1Z1ZDREP9UDqv+BEhMKXNG8M
 b2mvs5dARMQkhUXzaDxr+8ZMo/IkJPEwFRoh3TAMH4DBY2p03Zc1uX1/XFzpmSZ6dftEAFBj+8t
 gMSxnfUn0tWgznGBqw9agdI2rrpi/LMVDw1PinM+YwXqFoLhXE3+N2cf1uvI/kKo6LSYtjYwhe1
 /yXSPqcRn1UFH9PItMQ==
X-Proofpoint-GUID: v_ABtH3DOxmzDyTP-BM3O2HSKggFqM8h
X-Proofpoint-ORIG-GUID: v_ABtH3DOxmzDyTP-BM3O2HSKggFqM8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> Hi,
> 
> This series connects QOM and qdev properties to the QAPI type system, so
> that management tools can discover the QAPI schema type of each object
> property.
> 
> Today, QOM properties carry a free-form "type" string ("bool", "uint32",
> "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
> query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
> on naming conventions to figure out how to interpret property values.
> 
> This series adds:
>    - A new QAPITypeInfo struct that pairs a property with its QAPI schema
>      type name, enum lookup table, and list-element type.
> 
>    - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>      instance for every schema-defined type, including the mapping
>      between internal C names and the schema name visible to clients.
> 
>    - A "qapi-type" field in the ObjectPropertyInfo and
>      ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>      when present giving clients a cross-reference into query-qmp-schema
>      output.
> 
>    - Conversion of all PropertyInfo definitions from the old
>      .type/.enum_table strings to the new .qapi_type pointer.
> 
>    - Replacement of the generic qdev_prop_array with typed per-element
>      array PropertyInfos, removing the arrayinfo/arrayfieldsize
>      indirection from struct Property.
> 
>    - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>      and of the old object_property_add_enum/add_tm APIs.
> 
> Along the way, a few pre-existing type mismatches in property
> definitions are fixed, the "struct tm" RTC property is replaced with a
> proper QAPI StructTm type etc. Introducing more specific types or a
> "typedef" to QAPI could help provide better associated type informations
> than plain "str" in many cases, for example.
> 
> Comments welcome!

Thanks for quite a substantial piece work: there is quite a lot to pick 
through in this series which makes review tricky. If you post a new 
version, it might be worth showing an example of the before/after JSON 
to help give some context around the changes: however it feels this is 
going in the right direction, since it works towards the goal of 
allowing a QMP client to introspect everything it needs to know about 
the QAPI type underlying a property.

I've started working through this with a few comments and reviews for 
the patches fixing up types: I wonder if the type fixups could be merged 
separately to help reduce the size of the series?

Question: is the eventual aim to deprecate the use of all the non-qapi 
object functions? Are there many instances left after this series at all?

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> Changes in v3:
> - QAPI analysis redesign (replacing the old "expose name map" from
> introspect)
> - all non-implicit QAPI types are now introspectable, including QOM-only
> types
> - QAPITypeInfo.schema_name -> masked_name
> - exposes integer signedness and width through query-qmp-schema
> - various extra property fixes
> - rebase, some patch split or merge
> 
> - Link to v2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_20260616-2Dqom-2Dqapi-2Dv2-2D0-2Dcc9396b9c18c-40redhat.com&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=LGtC1Otz03Nx6wZrdIv7LRRcAEAYfhyfKJ4dtNt7PCxy3ILcsWudQol0qR9l2c5a&s=Idir-fKu3uFkuRRHZW8ipF3e84xwMMhnVWVuat0zVXs&e=
> 
> Changes in v2:
> 
> - Added kernel-doc documentation for the QAPITypeInfo struct fields.
> - Dropped "qom: drop free-form property typename registration", it's
>    still needed for array of links to provide useful type names.
> - Added qdev_prop_link_list for array-of-links properties, with a
>    create function that generates "link<TYPE>List" type names matching the
>    existing "link<TYPE>" convention.
> - qdev_prop_link now uses &str_type_info instead of "link" (the full
>    "link<TYPE>" type name is set at property-add time)
> - Simplified DEFINE_PROP_LINK_ARRAY to use qdev_prop_link_list, dropping
>    the now-unnecessary _arraytype parameter.
> - rebased
> - Link to v1: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_qemu-2Ddevel_20260510-2Dqom-2Dqapi-2Dv1-2D0-2D48ba6a1a1fa5-40redhat.com&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=LGtC1Otz03Nx6wZrdIv7LRRcAEAYfhyfKJ4dtNt7PCxy3ILcsWudQol0qR9l2c5a&s=_KgQcnGFWRM8edu2HLa7HFwHHCkp2t6UyriBmPDNk8A&e=
> 
> To: qemu-devel@nongnu.org
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> ---
> Marc-André Lureau (74):
>        qapi: add QAPITypeInfo struct definition
>        qapi/gen: fix _module_basename for multi-dash 'what' parameters
>        qapi: factor out QAPISchemaUsedTypes from introspect visitor
>        qapi: register all introspectable types, not just QMP-reachable ones
>        qapi: add type-infos generator
>        meson: add qapi-type-infos-*.c/h to build
>        qom: add qapi_type field to ObjectProperty
>        qapi/qom: add qapi-type field to ObjectPropertyInfo
>        qom/qmp: populate qapi-type in QMP handlers
>        qom: add object_property_set_default_enum()
>        qom: add object_{class_}property_add_qapi
>        qom: add object_{class_}property_add_qapi_enum
>        tests: update check-qom-proplist for QAPI-aware property registration
>        qom: convert enum properties to QAPI-aware registration
>        qom: remove old enum property registration API
>        qom: convert struct properties to QAPI-aware registration
>        x86: convert OnOffAuto properties to QAPI-aware registration
>        microvm: convert OnOffAuto properties to QAPI-aware registration
>        pc: convert OnOffAuto vmport property to QAPI-aware registration
>        arm/virt: convert OnOffAuto acpi property to QAPI-aware registration
>        riscv/virt: convert OnOffAuto properties to QAPI-aware registration
>        loongarch/virt: convert OnOffAuto properties to QAPI-aware registration
>        hostmem-file: convert OnOffAuto rom property to QAPI-aware registration
>        sev: convert OnOffAuto legacy-vm-type property to QAPI-aware registration
>        whpx: convert OnOffAuto hyperv property to QAPI-aware registration
>        whpx: convert OnOffAuto arch properties to QAPI-aware registration
>        accel/kvm: convert OnOffSplit property to QAPI-aware registration
>        whpx: convert OnOffSplit property to QAPI-aware registration
>        ppc/spapr-caps: convert to QAPI-aware property registration
>        system/memory: fix "priority" property typename
>        backends/hostmem: fix property typenames
>        backends/hostmem-file: fix "align" property typename
>        accel/tcg: fix "tb-size" property typename
>        block/throttle-groups: fix throttle properties typename
>        event-loop-base: fix property typenames
>        iothread: fix poll properties typename
>        util/thread-context: fix property typenames
>        target/i386: fix CPUID version properties typename
>        ppc/pnv: fix phb-id and chip-id properties typename
>        backends/hostmem-memfd: fix "hugetlbsize" property typename
>        hw/acpi: fix "node" properties typename
>        net/colo-compare: fix compare_timeout setter visitor type
>        net/colo-compare: fix max_queue_size setter visitor type
>        hw/misc/xlnx-versal-trng: add missing getter for fips-fault-events
>        qom: convert scalar properties to QAPI-aware registration
>        i386/cpu: convert strList property to QAPI-aware registration
>        accel/hvf: convert OnOffSplit property to QAPI-aware registration
>        i386/x86: convert SgxEPCList property to QAPI-aware registration
>        virtio-balloon: convert guest-stats property to QAPI type
>        qom: replace object_property_add_tm with StructTm QAPI type
>        hw/nvdimm: convert UUID property to QAPI-aware registration
>        hw/s390-virtio-ccw: convert loadparm property to QAPI-aware registration
>        hw/ppc/spapr_drc: convert fdt property to QAPI-aware registration
>        spdm-socket: convert SpdmTransportType to QAPI enum
>        hw/gpio/pca955x: use QAPI enums for led and pin properties
>        include: add QEMU_REPEAT helper macro
>        hw/gpio/pca955x: convert pin/led property to QAPI-aware enum
>        hw/pci: change the busnr type to uint8
>        qdev: add qapi_type field to PropertyInfo with fallback registration
>        qdev: convert core PropertyInfo definitions to use qapi_type
>        qdev: adjust PciDevfn declared type
>        qdev: convert system PropertyInfo definitions to use qapi_type
>        hw: convert device-local PropertyInfo definitions to use qapi_type
>        target/riscv: fix incorrect QAPI types and u8 casting
>        target/riscv: convert PropertyInfo definitions to use qapi_type
>        qdev: convert PropertyInfo definitions to use qapi_type
>        qdev: introduce typed array PropertyInfos
>        qdev: simplify DEFINE_PROP_ARRAY and remove generic array PropertyInfo
>        qdev: remove deprecated PropertyInfo.type and .enum_table fields
>        memory: use object_property_add_link for container property
>        hw/i386: convert PCSouthBridgeOption to QAPI enum
>        qom: use QAPITypeInfo in object_property_get_enum
>        qapi: expose integer signedness and width in introspection
>        tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema
> 
>   accel/hvf/hvf-all.c                      |  29 ++--
>   accel/kvm/kvm-all.c                      |  31 ++--
>   accel/nitro/nitro-accel.c                |   3 +-
>   accel/tcg/tcg-all.c                      |   3 +-
>   accel/whpx/whpx-common.c                 |  58 +++----
>   authz/list.c                             |  14 +-
>   backends/cryptodev.c                     |   7 +-
>   backends/hostmem-file.c                  |  33 ++--
>   backends/hostmem-memfd.c                 |   3 +-
>   backends/hostmem.c                       |  20 +--
>   backends/spdm-socket.c                   |  25 +--
>   backends/tpm/tpm_util.c                  |   3 +-
>   block/throttle-groups.c                  |  10 +-
>   chardev/char-socket.c                    |   3 +-
>   crypto/secret_common.c                   |  12 +-
>   crypto/secret_keyring.c                  |   9 +-
>   crypto/tlscreds.c                        |  12 +-
>   docs/devel/qapi-code-gen.rst             | 123 +++++++++++++--
>   docs/interop/virtio-balloon-stats.rst    |  22 +--
>   event-loop-base.c                        |   7 +-
>   hw/acpi/ich9.c                           |   3 +-
>   hw/acpi/pci.c                            |   7 +-
>   hw/arm/virt.c                            |  31 ++--
>   hw/block/xen-block.c                     |   3 +-
>   hw/core/clock.c                          |   3 +-
>   hw/core/machine-qmp-cmds.c               |   3 +-
>   hw/core/machine.c                        |  13 +-
>   hw/core/qdev-prop-internal.h             |  20 +++
>   hw/core/qdev-properties-system.c         |  97 ++++++------
>   hw/core/qdev-properties.c                | 180 ++++++++++++++-------
>   hw/cpu/core.c                            |  10 +-
>   hw/cxl/cxl-host.c                        |   6 +-
>   hw/display/apple-gfx-mmio.m              |   2 +-
>   hw/display/apple-gfx-pci.m               |   2 +-
>   hw/display/apple-gfx.h                   |   1 +
>   hw/display/apple-gfx.m                   |   7 +-
>   hw/gpio/aspeed_gpio.c                    |   5 +-
>   hw/gpio/aspeed_sgpio.c                   |   3 +-
>   hw/gpio/pca9552.c                        | 261 ++++++++++++-------------------
>   hw/gpio/pca9554.c                        | 157 +++++++------------
>   hw/gpio/stm32l4x5_gpio.c                 |   5 +-
>   hw/i386/microvm.c                        |  80 ++++------
>   hw/i386/pc.c                             |  32 ++--
>   hw/i386/pc_piix.c                        |  61 +++-----
>   hw/i386/sgx-epc.c                        |   3 +-
>   hw/i386/x86.c                            | 113 ++++++-------
>   hw/ide/ide-dev.c                         |   3 +-
>   hw/input/stellaris_gamepad.c             |   2 +-
>   hw/intc/apic_common.c                    |   3 +-
>   hw/intc/arm_gicv3_common.c               |   2 +-
>   hw/intc/arm_gicv5_common.c               |   4 +-
>   hw/intc/rx_icu.c                         |   4 +-
>   hw/loongarch/virt.c                      |  87 +++++------
>   hw/mem/nvdimm.c                          |  11 +-
>   hw/mem/pc-dimm.c                         |   3 +-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  19 ++-
>   hw/misc/arm_sysctl.c                     |   4 +-
>   hw/misc/aspeed_lpc.c                     |  73 ++++++---
>   hw/misc/aspeed_sdmc.c                    |   3 +-
>   hw/misc/mps2-scc.c                       |   2 +-
>   hw/misc/npcm7xx_mft.c                    |   3 +-
>   hw/misc/tz-ppc.c                         |  19 +--
>   hw/misc/xlnx-versal-trng.c               |  15 +-
>   hw/net/ne2000-isa.c                      |   3 +-
>   hw/net/rocker/rocker.c                   |   2 +-
>   hw/net/virtio-net.c                      |   2 +-
>   hw/nvme/ctrl.c                           |  29 ++--
>   hw/nvme/nguid.c                          |   3 +-
>   hw/nvram/xlnx-bbram.c                    |   3 +-
>   hw/nvram/xlnx-efuse.c                    |   5 +-
>   hw/nvram/xlnx-versal-efuse-ctrl.c        |   2 +-
>   hw/pci-bridge/pci_expander_bridge.c      |   3 +-
>   hw/pci-host/i440fx.c                     |  29 ++--
>   hw/pci-host/pnv_phb3.c                   |   5 +-
>   hw/pci-host/pnv_phb4.c                   |   5 +-
>   hw/pci-host/q35.c                        |   9 +-
>   hw/pci/pci.c                             |   3 +-
>   hw/ppc/spapr_caps.c                      |  39 ++---
>   hw/ppc/spapr_drc.c                       |   5 +-
>   hw/ppc/spapr_rtc.c                       |  18 ++-
>   hw/remote/vfio-user-obj.c                |  22 +--
>   hw/riscv/microchip_pfsoc.c               |   3 +-
>   hw/riscv/riscv_hart.c                    |   6 +-
>   hw/riscv/virt.c                          |  52 +++---
>   hw/rtc/mc146818rtc.c                     |  16 +-
>   hw/s390x/ccw-device.c                    |   3 +-
>   hw/s390x/css.c                           |   5 +-
>   hw/s390x/s390-pci-bus.c                  |   3 +-
>   hw/s390x/s390-virtio-ccw.c               |   4 +-
>   hw/s390x/sclpcpi.c                       |   8 +-
>   hw/s390x/virtio-ccw-mem.c                |   3 +-
>   hw/sensor/adc128d818.c                   |  16 +-
>   hw/sensor/adm1266.c                      |   3 +-
>   hw/sensor/adm1272.c                      |   9 +-
>   hw/sensor/emc141x.c                      |   9 +-
>   hw/sensor/isl_pmbus_vr.c                 |  19 +--
>   hw/sensor/lsm303dlhc_mag.c               |   9 +-
>   hw/sensor/max34451.c                     |   5 +-
>   hw/sensor/tmp105.c                       |   3 +-
>   hw/sensor/tmp421.c                       |   9 +-
>   hw/usb/dev-storage-classic.c             |   3 +-
>   hw/vfio-user/pci.c                       |   5 +-
>   hw/vfio/pci-quirks.c                     |   3 +-
>   hw/virtio/virtio-balloon.c               |  87 ++++-------
>   hw/virtio/virtio-iommu-pci.c             |   2 +-
>   hw/virtio/virtio-mem-pci.c               |   3 +-
>   hw/virtio/virtio-mem.c                   |  18 ++-
>   hw/xen/xen-pvh-common.c                  |   9 +-
>   include/chardev/char.h                   |   8 -
>   include/hw/block/block.h                 |   2 +-
>   include/hw/core/qdev-properties-system.h |   2 +
>   include/hw/core/qdev-properties.h        |  40 +++--
>   include/hw/cxl/cxl_component.h           |   5 +-
>   include/hw/i386/pc.h                     |   4 +-
>   include/qapi/qapi-type-info.h            |  32 ++++
>   include/qemu/osdep.h                     |  33 ++++
>   include/qemu/uuid.h                      |   4 +
>   include/qom/object.h                     | 171 ++++++++++++--------
>   include/system/spdm-socket.h             |  28 ++--
>   iothread.c                               |   9 +-
>   meson.build                              |   2 +
>   migration/options.c                      |   4 +-
>   monitor/qmp.c                            |  12 +-
>   net/colo-compare.c                       |  15 +-
>   net/dump.c                               |   6 +-
>   net/filter-buffer.c                      |   3 +-
>   net/filter.c                             |  10 +-
>   qapi/common.json                         |  28 ++++
>   qapi/introspect.json                     |  20 ++-
>   qapi/machine.json                        | 152 ++++++++++++++++++
>   qapi/meson.build                         |   4 +
>   qapi/pragma.json                         |   1 +
>   qapi/qom.json                            |  10 ++
>   qapi/sockets.json                        |  20 +++
>   qga/meson.build                          |   2 +
>   qom/object.c                             | 236 +++++++++++++---------------
>   qom/qom-qmp-cmds.c                       |  32 ++--
>   scripts/qapi/backend.py                  |   9 +-
>   scripts/qapi/gen.py                      |   2 +-
>   scripts/qapi/introspect.py               | 107 ++++++-------
>   scripts/qapi/schema_analysis.py          | 149 ++++++++++++++++++
>   scripts/qapi/type_infos.py               | 178 +++++++++++++++++++++
>   system/bootdevice.c                      |   3 +-
>   system/memory.c                          |  40 +----
>   target/arm/cpu64.c                       |  11 +-
>   target/arm/kvm.c                         |   3 +-
>   target/arm/tcg/cpu64.c                   |   5 +-
>   target/i386/cpu.c                        |  26 +--
>   target/i386/kvm/kvm.c                    |  38 +++--
>   target/i386/kvm/tdx.c                    |   4 +-
>   target/i386/sev.c                        |  31 ++--
>   target/i386/whpx/whpx-all.c              | 101 ++++--------
>   target/ppc/compat.c                      |   3 +-
>   target/riscv/cpu.c                       |  50 +++---
>   target/riscv/kvm/kvm-cpu.c               |   7 +-
>   target/riscv/tcg/tcg-cpu.c               |  13 +-
>   target/s390x/cpu-system.c                |   4 +-
>   target/s390x/cpu_models.c                |   5 +-
>   target/sparc/cpu.c                       |   3 +-
>   tests/include/meson.build                |   2 +
>   tests/meson.build                        |   6 +
>   tests/qapi-schema/meson.build            |   1 +
>   tests/qtest/qmp-cmd-test.c               |  55 ++++++-
>   tests/unit/check-qom-proplist.c          |  99 +++++++++---
>   tests/unit/test-qdev-global-props.c      |  11 +-
>   tests/unit/test-qdev.c                   |   2 +-
>   ui/console-vc.c                          |   8 +-
>   ui/console.c                             |   3 +-
>   ui/dbus.c                                |  18 ++-
>   ui/input-linux.c                         |  11 +-
>   util/thread-context.c                    |   7 +-
>   util/uuid.c                              |   5 +
>   172 files changed, 2510 insertions(+), 1699 deletions(-)
> ---
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> change-id: 20260510-qom-qapi-fbe0f5060c3f
> 
> Best regards,
> --
> Marc-André Lureau <marcandre.lureau@redhat.com>

ATB,

Mark.


