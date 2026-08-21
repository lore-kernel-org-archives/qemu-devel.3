Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9CEC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNEe-0006jw-Cy; Fri, 21 Aug 2026 07:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEd-0006jg-7M; Fri, 21 Aug 2026 07:16:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEb-0002EW-J5; Fri, 21 Aug 2026 07:16:30 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9PWMr2036036; Fri, 21 Aug 2026 04:16:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wWAdwuw8myoOpbp6KHteaYqsPIx9LPl/n2J31Ycjp
 hI=; b=rBY0kEocrlS1UZuK/HOHu6yRqDRCVwsanGOBrCsesIt77Er3/MlUrokPV
 ijeifSfzTeGFdkYi1pApN2iCVRIHrd+H2P8jVXwgSPCsyJ4CLwmhSp1k9dJljoYA
 MCWESoCCnhFbQqdylHXM9hCeNtPEoBQnCQTtRjy0NCpa55MoEPbj6yNwNKwMOJ6H
 jVBuC6zpAt7XQHmHZTd0EYXk5s074jVeEKWfXio5Z81m5GdLn7DwVbSBTcAVCU14
 u1xVuX7RXQVi1g8V/DOyQ2lGVO1I4uLvgrDn20yJaTg50kpm9yDohO1HSTZXMJaN
 MPjC2lF14zsMPKTyvBxM7gFE0GOdA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020076.outbound.protection.outlook.com [52.101.85.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4vnf86xm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhgkL6ibuuiF3xyyEDiZrT2gMLBrN7/dgqJVMY2PxhezODpuuiqs08+BHblDLrq2FuE8ELga0gWw5a4JexagTgUt6gF1OtWAYJRS4YAEW1yBUxw3SDlbK+j3DbVb5wuAYTFoNvtwISEXY0Ytup+vpOHDPbVYrxAPRwjF93k27C0TwbL0CsahkdJQ+XHN7OT/Vez8lgfSZtfAveRdH1DzYe5vJLsDlNI9BBWR6QgFA/38N1S0RhDsjPQPgCIszw0j1y0ZQyRbEZUQC8uK3F8XKiIdAcqhH3W7eyH9R5lo1Ick4C+ehLpfnKFJZIKEU8qTllX/YDuT5jo3AeE+fW0p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWAdwuw8myoOpbp6KHteaYqsPIx9LPl/n2J31YcjphI=;
 b=Uqm7QIIrCUxDhuIY/udepBJllTjTXkPMWAZJNEyfgzqui2JBlOGDCMlrb6EjrqLFlT1BxIkVKSU1k6l6MdJcEhrNy1Zdyg6sCtJsyX7ebRgwkYdcyeAErk4ZVIjoJ91ad7wpGIE2FjLPBb55ZzFWvM62GNvK5htdYYDf+zu5ZnzQq/aX2lRadfMm55RfqAf8V3wJnRNqaIeYx/coli3YA9zuGvC9Ve3B9oJVhIOu3Et52DxCk7yPChZvQzcJjdPBbXFbPuAAFfYom/e8GnZqDzdgkOlzEqHh6Id7h68fn1YmwzYyKy75Sg7+MJQLH6obodesKIZApYOFt8vujSS0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWAdwuw8myoOpbp6KHteaYqsPIx9LPl/n2J31YcjphI=;
 b=I82KmAFr8TVmcYFGdT9uGSuJdU6iXM/sj8YKJrrqW/Y+TjIoKKFqHEHXptgIj3PdqRJ5Kdp9sNaEWTEsVYHRvVGN3kZOoUURXCwtDVxBCp1htNawI8sigmtoV5Tlqccc4wWg+4gvvc2cPAhvit5pGFQIbsIqzT4bAXaRmImZWX4p833ai64xtp/fmDQYm3QiTXO7LFUfPxoHyHJ7eG1Yr5wbnAMYqHJ2gBOVladxvPlzGQ5oWGjf4XgCob4tAfqAQqEAb/c1NhfrO/c94Y1tVXp9nsp51IxUkYKxrYeum7yzqOkCnCi6a63E7puhNtsmy1uhKQspXc6kQwBbd7rUMQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:17 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:16 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 07/16] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque
 for ACPI_PM_PROP_GPE0_BLK prop
Date: Fri, 21 Aug 2026 12:14:19 +0100
Message-ID: <20260821111550.276011-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f95c0d-d195-4880-a210-08deff759e72
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: OiyFLfHnaXEnriu1REVplA+cfuGpaZVfHVIPvMQt/icFbHaspMsH3a4LR3im77aPQ7Ie73/TUNHfvMn7PzHPT1NcHVgryOwQg2XwPh3ZmPF1C/cJX+fJOQeTe5LFwYv6ZLe9+QOXRLGRMx5QNaWXmtXmHIAv37bck2uePSFxyRr4+yUBTAaYHDcyOS+dWiPh6Ubz8jTY1XSUMQl41uiYUbthkfNTVj6f+vkIiZhXCqmvJV+R3D8+oKSPo9m4WsjHm5Kp6k/huEegzebGa6DjvwpKkJ/+tV00woPeoYjwTnw8a8wIiu9ln8p1v1ZgHFmc+0Xd81tXOWkNENzrDijJ5xAu6eoFZHEFJc2uwVH17KLJi27f2BL/AYsC95mfR2G0RgWRmwyghupPD0N6EMXiI42BvGId/tBUJMfVTkBRu+aTdFj4q1tT0jtzI0xkjY6F8c7aS1MtRAxfcEaTUqGmnDVniRdJ3GIyU+1a7ea6SWVVGFFpdJHejdoIED/nIA2Op9FPET/ZEB0cT7kRZMWMbzZTUe4Ytj6BOjK+gIym1aF23MOSX/gLh7vY3jm+ZBHUcy2XP25CwUd+LLHXhDmtGMJezCfXYvSOPZtMziZ4IZHav3L3ml8LR2e90nqc2IWP9MW8dreWqyY/y8IMgmJdIyH1aPkZuqbG9zZ9RZmdy8L1ywpOpVik8/Ppi8ztUncqo8Ft9pAce/Zg4A33+K+MqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRlR01LOFpNZElINU9BRHlIMUNyU1VvYWQrL3VnRmlZcnNSa0dxMHZ6MHlP?=
 =?utf-8?B?QTBPZnFldzFCazYrSWg4QjdxakVUTGFyVkJTSklBTVh0bXlBR1lNMXo0SE91?=
 =?utf-8?B?OGF0SG1yazN2T1FKbFdKc3QzQWl6Z2lVYXl6VDNKYSs1cnp1ckthNFlRaDc3?=
 =?utf-8?B?bnp5Y2JTV1IxS2FTVW41Z2g3UnhmRXlBYm1rTEpjNGthWVgxL0NlTlJLS1hJ?=
 =?utf-8?B?UXFqSXN0Z2xpV3I1YlRVU3ExQ2xFQkJ4ZFZoK1phUXVnNEl1TFEvMnVHL2VF?=
 =?utf-8?B?SDJGdmxlR0RZcFJ5WUk1VWlUbXY1Y3k4YWFVNVN2SnB1Y051cXVmRGVTb1lz?=
 =?utf-8?B?TU5zVDNCOGZscUJ5dUo4YlFWRzZobEN2QVJ4THJPeTRRK0l4K1BEeVp4N1BT?=
 =?utf-8?B?am5MaVp4dndKUlNDNDVJL3hqVGxneHl6c3pWcWcvMk40OUo1eENhMlBQYit0?=
 =?utf-8?B?NzRIZ1JlaWdJUzBRUlNZTE1zeGdBN3dRK0E2eVZWSjNzWGFOOEVaTDcxV21V?=
 =?utf-8?B?MWtNVVY2eEdKdFpEbHhFZVFlUFhpdWkrMWRDVTVXVFZ3cElLeElLUkhJT2Vt?=
 =?utf-8?B?L0xydU5HakdqaWpxbDRGOEcwQWx6MUxCZ1pURStFQXlKcUdOcE95eEFYV1Qw?=
 =?utf-8?B?dVpNZ1Q5L0JnRDBkRWdxMEZBd0N5K2J6UStxc2U5NmZNbTA1Mm01Zko1MHUv?=
 =?utf-8?B?STNHS0RqK0dRTTJpYmVBTlMveHZDZWUzd2lETnQ2RXczWTd5cVpVUStqSHNq?=
 =?utf-8?B?NHE3S281Y3RqU25xaHRXVHllUjJWeUo4UGRCVGgySUFuYUhEUkxiMVR5dDRj?=
 =?utf-8?B?TzRlY2lwYnhsTEJEZkxuc1JoNkIzVWdmbUk0aDRZa3oyRjJqRFlMbTVDYldZ?=
 =?utf-8?B?cFNINWVYOXorQThqSTJaRnZvRzk1aW1ZYnJQa29rMFczVEJVNCtFeFUwaG9h?=
 =?utf-8?B?ZnI5ZThJN2xrSnJRWU5OSG1uZkZzL3h1V2lWdEJFV0hVVi91SlllbFZBK2Jm?=
 =?utf-8?B?VnJXZVVrY1RzZXMrWlRCU1AwK3dydzZJZnUxUDd2R2d2aW1uYTlramwwN1dt?=
 =?utf-8?B?VCtzZXdNRC9QeGY5QUtrYXJqdDVYU1luaGpZdnVpYWZWY0cwdmJQaExNeXAx?=
 =?utf-8?B?TEpxcnBlZzNKOGpEWllrV0l6NDA5UEEvNlBjbFRFVEMvQ01KcnJ2Nmc4Vkt0?=
 =?utf-8?B?Nmp2T3JQZ090dzI2ajJGY05GTXBacm5YSmZXTFVhbWJpSEFMU3VubTUzYzR0?=
 =?utf-8?B?c1hGSzlMOUFwVGxObGxFMjdGQWtuUnkyZFlqUkMrby9JblJEMkl6QSt6WGxh?=
 =?utf-8?B?cXU2UzdxVG05aGJSV2dOdWNhOE9ZSHF6N2U2dzZ6Mis1S3lYZ2JCZ20vSVZw?=
 =?utf-8?B?OTYvVm1NMFo4Qi9aK0ttQzdtU3VYeVhVVEVHSDVQa2VaNG9HR2tQWU1pZXRO?=
 =?utf-8?B?VU5kVjNYTVFIZ2wxZ3VKSVhlMS9kWEdMQTJDL3VWUkNoK2ZsR0tZemZ0N1RR?=
 =?utf-8?B?OFB1bDErSEg4cjJ4SlRkbFV4MW9ybWE2MFJlNFpaQVJSeUNaVEcyUExtdXJy?=
 =?utf-8?B?SW5IZ2FuSnh0QUxCZnl3RW1OcGlwa0R5VGlZNExRSnRGSDVmTkNkcEIvK1pV?=
 =?utf-8?B?ZVA3NHVxNkw1dTN6a1VxdDBXSEtGUTdIV3p6TCtzaGFoR1lBaHdvazcydGYr?=
 =?utf-8?B?QWNuRWUrRWRIV0prd3J4VjRIRVcrTk9jdng0QTZKNDZSL0tZa2hvZUlkTmRy?=
 =?utf-8?B?SDRERGpPZzdHVTVDNC82Y1Fac3BIeGRMaG15M3M3TTJzUFVtYjBSaWs1MHA5?=
 =?utf-8?B?MjVwcHhtb3RPaHMzSW9lai90M0x1eW9JUmFmY2Y3bTdSZjQzdXdRRFpUUExS?=
 =?utf-8?B?MURBajdWKzhiSEY0dlR0ajhFbTAxL2hBSVRHcytqLzRuMHU2N3htZ2Y2cEVU?=
 =?utf-8?B?djRuTURPMThtZzVBbFQvVldoa1hBOFFUdGE2R0FIbXBYWmFreGRublNGK1lH?=
 =?utf-8?B?Y1diRHlEbG9vUEQvUkgvY1hOM05JRlYxSUN6OEQ1cE5VOTRBU1pscjZHb0RU?=
 =?utf-8?B?OG5reGJsTVVsQXg4VzZPT0VZR25TVUpaNmx6cUdVbVlYZmdEdHMrY0JzN3oz?=
 =?utf-8?B?K2VrVnpFVW5KdU5UY2RscWk3SFU2WEVSeTd3WGJLeTZPYVIwT3JFYmYxUHpZ?=
 =?utf-8?B?c0hMeGtzY1lYdVV2WWlJSlpmSWtUKy8zMWZkb3ZwTlVDcGd4aEwwdE96SmtJ?=
 =?utf-8?B?UCtOR2gvdmZSc3NWMW1Oc00yQnBqY1h2VjRLK1N0ejQ4UnpyejI0M2RiNVF3?=
 =?utf-8?B?WTY2SXAxeEcwOW0vOWw0YjVEUFdWQU56bXNxV010aHVFbkpNZ2Mvb2k3TDA5?=
 =?utf-8?Q?JpxADdtLL4etTS7k=3D?=
X-Exchange-RoutingPolicyChecked: OEIF8eyFriqJRKbj+mK/mmyCUylcj8741c5/ZJAAFtXlT97AsIqzrrbUB95Hr1h94m0R/HYX+ka3lvdjnSjDruRv50OPZOnnT9HvA0GM0nplznjLgeAjDv+IqfBFQ+abqjc7XIYojJV8KkyEZYknzbKheQisSLqHmfmK3wWMmo3RfK7LeDvH7IrdoRu1NKwfkVOmWCf8Dw0RvTM0wzM8H+JJG0zJf4+FcCIWro0Ody9/3PLAYG8dOhgpSXeEaTAq69aQDTtiRq8knaDZStMOvUAQwrF5sjk5vZ8XtNuXzQlJHoQ9j78aUafyvkzaGIzGZWrSyA6txklhsI4cICjW1w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f95c0d-d195-4880-a210-08deff759e72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:16.9280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjBQxs9njxSqXtWWw23ickS+rTgflBiyCrDANYeFdUNqACwI4BbtGS2OIM5UeheaSt8dVvmI0kS9XLyhw0k01ULHcg37wGtInD1M8fYmO+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-ORIG-GUID: IEZYd9PeHRAYdSpsVlQynczWYMOhSLf0
X-Authority-Analysis: v=2.4 cv=OZGoyBTY c=1 sm=1 tr=0 ts=6a883381 cx=c_pps
 a=PU2v30DqrLDYHXTVxoobRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IEZYd9PeHRAYdSpsVlQynczWYMOhSLf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfXxey2x2VnJ7Sx
 fEH+t9OZOL0Er3ko+OtEndn/0+LRFoCGFkOF+2fk1HQOUdo9/SS93RtEFxBu72fEj+L+2CKwTXn
 mwAEJHY1qalseQ2HqtjRD/49p+Z1u6GVOoKc9cDcBsNNh6KlsuyMCagHJkBGuUgFFdcRxBBlYNH
 AgQrddZgPlaghQ7V3yBA4TrCXFA4cYPbotz3S5hRjwPEOniqUnug4RsIw2PCXiduuLsSbIHawum
 2G8UAc1200WO1lwPwu/IHRzFai1bY7oCn4Vt+ekZE/c1jblv5n6sFX4A472UdnkiMFRLd2COidT
 wH1H6q4ZV5AiScxM9Sf4qa0RvHwg/s7F6PQUu27EpllB3I9Yxyo7Zmsf/zJiIKWi6oTWBWde8ay
 0zMOLtt/hu24j5niZriMrcZiGIYvot3fsvTRjjLOjU/+2QwH6tZdRyFqMQKYgKsqOTxtDFMwLRj
 gs/gv+vhl66gSykG+Qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfXyeoPxQcr63f7
 gDrVsQdIZt46EGR3547Xrlud3y0DWaRSLC0H7yUE6lMpvSC+QxaQNTlazs5QGgL2cK2aFLGxqCP
 T163zqCqg184kNYcK10A5+IPCfFCy4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

In order to convert to a class property, the ICH9LPCPMRegs instance must be
resolved by the getter/setter instead of being passed directly as an opaque.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/ich9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eaf..ac3f452dc3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -342,7 +342,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    ICH9LPCPMRegs *pm = opaque;
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
     visit_type_uint32(v, name, &value, errp);
@@ -411,7 +412,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm);
+                        NULL, NULL, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-- 
2.43.0


