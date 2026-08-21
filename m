Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C008C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEk-0006m1-Uz; Fri, 21 Aug 2026 07:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEi-0006l6-L4; Fri, 21 Aug 2026 07:16:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEg-0002FG-Uv; Fri, 21 Aug 2026 07:16:36 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Mll31901672; Fri, 21 Aug 2026 04:16:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O2KP8BBCd5oZBaoEyj1F30gnHj3pT1KcaLaGU74FT
 Cs=; b=OIy1C6zcRCV2s378PJNlWVfze8EhnuBCUd1qHs91EGQWFXKzC6RLNawgE
 SK55zz3RsSwp7fEDBSMknioGl2JfO5MQ5IlI/xVsvKOI00KATWitqpIzk2m1hYqS
 Q/OZTzIoaMrvEA+WULSh2mezmbo/2XfK+qMcsGGokjvIC9HZXt/fJpkozL5KNH9r
 X6HXAiBJWecPSWoPSYdwIWx2Ehug5nQf6BJzx/I2BG5yWiq4Txm9JtyocfCe1Q3S
 kZA7Li3Dx9JQDfnxhr+RkSRmJURGnAgj2A81xUjxriCOM98vMUqmvxVOOLWqpnR4
 WyQbsj40hNjBKIMb5WEKZAPtZm6tg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021130.outbound.protection.outlook.com [40.107.208.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0ts-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HivgsGNRohud5fHm5QrvErJ6um4pOcdJ/9B4L7pyd4ZSlVJKVFjnsQY7BgeWTPmQouuhRyVYFXWPVCxjmHXQPS3+v0+eZZx3Uapov25SBgOv3/D9lok/TD3/HA/TRY88wns560MoIVuAmYVXdIMkGKKL1PGpNObT2EgN1TbH9UFQA8FL4tqbp/Ec4bYTbdRFvcfK/z+ZGo/Vucs0TSXcnj5lHYjqqcQ9gcAiRNeyPZTuXXT2l3QLwl2ovS97ecRBgnJ++b2YTX5kZDpXvykPxgGqGU0mrcRkZbyPJ1QrRrx7DrehmL2oSfd58+TMqcWSDlKoT7Qo5fyUVm5UZhXG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2KP8BBCd5oZBaoEyj1F30gnHj3pT1KcaLaGU74FTCs=;
 b=NJpyP4LFYx0ViY6s/BqhUdarhrPpdUMeuKm0SQE9Wg/2KBVC7e+1z893ny0UiU18aM5IRW0nWnijIaRTdulD4/fZomOz1qHQvojRIzBspsCnTQFYpGKpWNPSKsfjpYoiyK5d6D1YAdllBmOzpK//TObKDa6vmfnfC54WUkDSYA2/RULfG7IkzUY8ndsOLc00SAJqw06tfQyX2wkzI2UvdpjkQFCYrxlrfaJUYjQisjqA6SJzzBLyLiz/58stn3+vskBHnWCpSWCaUgbBlK4ol59ITx76fAyB5hOohN/h8FT3haHsXfLtWOxRbJCU2oZOY/eX7LHYCIrw4AJwm1I5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2KP8BBCd5oZBaoEyj1F30gnHj3pT1KcaLaGU74FTCs=;
 b=qDYYG9wCJPUGfxLoHyzvg12jKdO/gJsoSm6JBt2csfS12qzO9Ppr5XQwOZgCaPcaDadggASfZE7Yfmjmj5ab7Q7fwtyi5ahdmY5flPwpmqh8HFFckzT2qkFkOawxSHtahkWpWftT5K9Agw6PM//uNnc3EM+ZFo/LLLViEhn1/kDjdkEoHCEG17o0FRsMaWZTDyUCOIoFfNaspF7BjsU35Zi2NiGGYQhLP7FdtaI2bdNVF5mUxutfH1a+Vapmakxne3pTDJKFxFoWZq425PRuZb7dEZyxfzRYE8SRTA2fp7iWA8k6N9MJ6MgebJnhZIAoxyRpQ+iYcukTBz/9lnREJQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 09/16] hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to
 a static class property
Date: Fri, 21 Aug 2026 12:14:21 +0100
Message-ID: <20260821111550.276011-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0132.namprd11.prod.outlook.com
 (2603:10b6:806:131::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8796bc-5b8e-45f2-0889-08deff75a227
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: /NHdOYA3zHoLmbOviY+XBtN98MobXy7z8RvMLjRQUeiHcCySRVQqNBVP9gOKUaPF5NzlNbhetqJRnHS/4UVj2NMi9rjR864+x74pFfrehYTn0PHOh2U4V5Lv1KV5HlWGhbKHOgbE2hEXCQxn7XKnfRfZc3Je7O2tRKyJRHIAZPpNYyR5aOoApbbqpF1zTpp+eNPZS6mqZxfEuhDU1Zl7LpghzdG4Kx00GKlmOoi69veLlfrici4iKbFyk475xbC5RfLbsgHOfrloQWnqkwlWiGY4QF5yF8WxMGOfrIrXyXmAV6J/77Fc9boirsvdS+lVR1IhFsRnc5WeIH0s5U0EcxB7E8u7Lz6EHoKI2r5Lf+638WRtb5XL6CPyuPCdnxAXySRHQFITqcmhYkFCcRcp+sDgBQFZwnF6sQhjns9YZ/yXj+T/yo5LmVnG2NbZcyeJyeHny6spqWT7XIPVVENgmaKT011E2X4ZcqY8p9AoBQmjn9UwCNl5OIn2Fbtm8FXFZe12XBhSlXHo5OkT0399ZFQpGjWu583pS2LgJLvVbPQlgAX+BtQ3gKw3B3bh0v9N/3pq8AyeOnRwNRqGTnUbSTTpANiSotzTB8vBNpXl+jXt2z+/MZNvZQaORt7vpWRs+4oOhLUspNRWoP5Gy09L5Li+h6nN+ndgoxSPBdvCMi70cS9J3KzdlTjY1SgZWAB+EiW8a7XDuoBvZPMvzfU1fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0N6bVZPRXlrakZ0RkJ0cmM1TG15OEp4YmhKaDI4cnhkVzV2K3Vna0lIWklo?=
 =?utf-8?B?MkVFSWpoMDdXbkM4Q1V3b3hUYzJSTXhUb01PV0dpU25BRHFpRjBjY1FCTlF6?=
 =?utf-8?B?RTFHaWpyY1h4ckwvUGFSMXZMSVR4NjFkdjRwTzBBMXNXUXRzcXd5dENlZUtl?=
 =?utf-8?B?SEhrNmJWZXd6K3ZHUTMySnVoMFovejlWenFPVW9mKzdyL2tuVlVqMS9qR2Rp?=
 =?utf-8?B?L1dTRU1la21ZdlFVdTZlN1NQR2N6WHZaNnB4b29oS2VhNllmSzBiNHQ5b3NK?=
 =?utf-8?B?SHU3VitTQXFMVHVzSWVkSGNpMzdWRlBoRUpBTXBqNG01K3Q3bDcyVForaUtE?=
 =?utf-8?B?SXdDSng1YVBadUdubW96SGlULzdHVUdoVUZnb29sWWV2b2trWk8rQzN3Y1Zj?=
 =?utf-8?B?YTl0QWNrdEJyWkViQXROSmlaWEY4SGVtVUF2M0U3elRQNHN5R2YxUG43Y0Fa?=
 =?utf-8?B?SkFSWFdXZVBhbEhDQmZleXA5RzRzbmQ4MGEwbm1JdmNlck4xcUx4MjlMREJV?=
 =?utf-8?B?eGVkVXFuREVrNkF3cllUQ0lBdXBxR3ZJVlBLUHZTTEZHZG5TOW9JTy9ZLzRB?=
 =?utf-8?B?cEl1Um4xWC9aamdCU2R1K1JEN3lucERsUytuWmN3dW91bk5VM2hBdzhWNzZk?=
 =?utf-8?B?K0NqajJSOGROaEhaSkNnZmR5Yml1QWdSVWlBSEJJSzRicXJ1aW8zSGI0L0pX?=
 =?utf-8?B?ZSsyM3FZYnFKZW4vRzU1RCt1S0FhTE5wQ1BWc09hd2wvUE1wUXJLb0pJVnhk?=
 =?utf-8?B?NGdvcGx6Z2grdStuMnRWQUc4dE5kOFF0U0JYNUtWcXcreDNqWndmeVVQVGVG?=
 =?utf-8?B?VlhJQkREdU5EbmxwS05WSXRJeERnVXdYQVlCSXBKaVpCUzBzV0lMUEhVYThI?=
 =?utf-8?B?UXB5MnhVOGVzZHZXYnFyeGlncWRjVUJrdFNSUEZIamN5eUdvK0o4U290bTNk?=
 =?utf-8?B?Smc4YkE5QVNEYklRRGd3MDJjMmx2VW05Y1FzYVhLQ0pmU2h3MGVNVXoyZW0r?=
 =?utf-8?B?QXVsV2Rnazh1cUQyaUErWVYySG1LS3doWmQwbm1vQ3VZbklFTVdEV2w2M1V5?=
 =?utf-8?B?SE9tN2pkSHdGMkhRZ21RNXJMUDJFNDlCak43ei9uMFJhOWJLc2tnK0NaYVlt?=
 =?utf-8?B?aW9wbEFSd2MwR1lqQlFObWlUOUd1ZFVxUGVYQVVXR09IRzh0MUhMNHFHcXVv?=
 =?utf-8?B?SGlpUXc3VU52aUNUbUkxNTVSWm5UZUpScXFMUUxWMXg4UVF5WEJIN0FudzVq?=
 =?utf-8?B?bSs0MHlCU1dESStRbXU2UG4vd2xZUmExamhmL1FnTXJGVTQ2a2l0czNIMTFJ?=
 =?utf-8?B?eWpaWi83OWpJSEk2SC9NK2JDYjl1V1IzNmVZUWppU1dGYjg3U3FIWUs4dXVC?=
 =?utf-8?B?UHprWEd2cGdQZHV5bVhVazlWbU1YaHoxRmtia1ZQTkd5L1BYZ1lObHVXOVVa?=
 =?utf-8?B?WkEreVNhc0RPbnMvNnlNNjg5aG1ET1RqU0VsNzFQazQwMmlUQVlhdDZBZEhF?=
 =?utf-8?B?bkxzaWZCVDNtbzlzbElzTE1mUkg5dUwyUWkwOExwU2ptcnp5T1RSOGo3eDgw?=
 =?utf-8?B?SzFtZ1JZQ0hrZlhia3VMeXpvMlh5T0hJbWdIS3IraFdDRXI5N0ZHbmhSdUxK?=
 =?utf-8?B?TlVFdm5iY2pubG9JL0hLNmorUTRNR21rUFhGcHorQi8rWXZFODNoWUlmNSs1?=
 =?utf-8?B?MjNOemhjT2Vua2dMWStvYTBUdDdmOUhpL2Z3ZjBKa2xSaU1UNzVSdm90UGw3?=
 =?utf-8?B?cnNZNFhLbGpMSjVka293VWlEc3hqSEVUQ2RoY3FEQTJyZFhGMlJacmhvTGxX?=
 =?utf-8?B?OWViSjU2eXYyRGxQK3FRT3hhMzB5TFBPOXBONGtGL1RGV25NN0JOdlZqT29z?=
 =?utf-8?B?dzJMVXEzdWpIMzk4cnZNUDEzSGxEQXU0RytMbHZwdlZrZENITGo2ak5yeUh3?=
 =?utf-8?B?Z3dPZHJueHZqTEk3VXp5bXlQV3lDTTgwcnBqUnVwbXh5UjI2RXpteHVEanVO?=
 =?utf-8?B?dlV5RjUyM3lMeWRxRFlPOE84UC8yMmZ1WUFVNUpVSmZDV00ydVNIOVlDS0p2?=
 =?utf-8?B?bHVPMmJFbFZRVEhzL0dqWTBrMU5QSnNId01LUExWTlRGOE9yWXo4YjBFZmRJ?=
 =?utf-8?B?MTZHeXdPREEyYk1XN0lhRXVHS3B6ZjNaSUtDeG9MZVdsdEcrL04weEFTTzUy?=
 =?utf-8?B?NlJzeStyTG1qenZaK0l1QjJ6RThib0lWZ3Bnd3dMZnNwUVUxVlBMRGRVbFFt?=
 =?utf-8?B?T1REVVhmSVo2c1dqVDd5WkxrMzQ3NXF0SmVhTWtQeldiZ1loNzYyaU5FTENN?=
 =?utf-8?B?Ty9Ha2FWUTRlQklBOEhneWMyNUtUdFE5UFdrcEZLTHNkZU1Vczh6cS9uNDZo?=
 =?utf-8?Q?JOPWvejp1r/hCnTE=3D?=
X-Exchange-RoutingPolicyChecked: YEa7U2kqK8w1LswnqoOEyF7ettRx699GumIvm1vaUiYJbEfGHYLYRrj3EnKkNdYIdmg1zSfx5bGYKD8CdNrPT6lrg807dHX04zneFkgfWOHmR69aBrjjOkU9EpETzfRtZAVyI2U3HsD9Upezp8Tb38TBAwyn0EmCUIUDYcod1VNv4yv9Xht/eVNAqzYpL4DvbsW73WOlCwCWcVA91KONG/5WZFKmI6XTpG0fVEOl0lMgP+yj1SMwRb5d0rSVMcy1h1VI9/YohQgBqlg2e3FdE50PS55EIKL3wVGdTUXUM++wnuYVEVQ/N1H7LFoi3rkdJIkjp2XNAcaSFcTVB2fY3w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8796bc-5b8e-45f2-0889-08deff75a227
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:23.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec1r9g1iNLbdsicPsaB1t3EmQArbM4GUgyqvoInsGmXMaXPv6fjlKIltYHzG2ylk+4VkCRneiHLrmsteVIvZRC6dMsU37Qn5eIEelByv7JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: GbdjIoYF_h9B3tS-Jjm2NrjPOQ7eEFD4
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a883389 cx=c_pps
 a=81r77geWhBIZzI7tvg4+jA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_dIhvDIfpQVvNhxktcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GbdjIoYF_h9B3tS-Jjm2NrjPOQ7eEFD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX88qlAcZKrEO1
 88lFtm0YOE46HrYTV7xQPGbbB4i7leoYv84KohddHvPWulrEmQ5ke0EBriPre1xA34rRNkYD5ou
 vVQ46+2EsNUAzX3SvDsZGKj1Za1BCx9Ocbo7fcgx91wolIYcvAB8G1asSLeYLZUGSB4v76EPnMq
 CjGdOOvgFHnM0Kg+dPXtBsyniSXXS+qGGPaoaznPs79BY6tPQ+8Z378FIMkUFtYUvyZn9VgwlLC
 v6rBMQ0L5gSSvFBT47FamtPAmW2Y6vIOdLhYC6w1EgDUyQaJumU2XDYl+QM3VOGERYtI5//Z0ok
 4W+XvUM6q0MkrtAUu3xIsnCWA4frfxPIW2Un73IZHcBco2Q2mBT5UbE1LW3YO4/s4IVmZdV6qUD
 Wpwgahi+u9SuwoOKam7A4KEvKBliLd41b6rskwf4LyeGTOofH9Rtr3fRU3bhA6V1IkI6uPWVGhM
 0zMzhhSwuU3Z2nSLNPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX5hHr/LqE5k4U
 dwupobM/XTBWoSJ7WGmIFnBw2PE/ioD7j637J1gnzDxp1Shvt8lCg6Y+O5G/XGSHA8HYAGcTlRG
 GVltIWhX2UvSJdPtzASvJWNYo9kNgVc=
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

The ACPI_PM_PROP_GPE0_BLK_LEN property is assigned to a static variable and so
can be converted to a static class property. Introduce
ich9_pm_add_class_properties() to hold the ACPI_PM_PROP_GPE0_BLK_LEN property
and soon all other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/acpi/ich9.h |  1 +
 hw/acpi/ich9.c         | 14 ++++++++++----
 hw/isa/lpc_ich9.c      |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3fb993bb9e 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -84,6 +84,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..774b34195f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -402,8 +402,6 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
-
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
     object_property_add_link(obj, "bus", TYPE_PCI_BUS,
@@ -413,8 +411,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -432,6 +428,16 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              ich9_pm_set_keep_pci_slot_hpc);
 }
 
+void ich9_pm_add_class_properties(ObjectClass *oc)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
+
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_len,
+                                                OBJ_PROP_FLAG_READ);
+}
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 07c9509cf4..d3f1358887 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -919,6 +919,8 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
+
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


