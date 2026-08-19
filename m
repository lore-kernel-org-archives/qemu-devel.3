Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AEFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhue-0000dm-Ch; Wed, 19 Aug 2026 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwhuc-0000dH-Ow; Wed, 19 Aug 2026 11:09:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwhub-0002bZ-1G; Wed, 19 Aug 2026 11:09:06 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEhffd573547; Wed, 19 Aug 2026 08:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=t22+scPtb/Bt94uBwc6Td15ExJw+zInh5aHoyvez5
 HM=; b=eW9YA0uc414q5j6bYiBUnqaxslGCCpwzpH5b6YZmHj2aAStSmJF19krGO
 wLy4K+XwQEMiT1xQJ8lsEQqpgUE/o4lhezcKccF3l1B4X5HS627tT0U6rtMpKUED
 LXnpSciQ5mfHbv8vL7nWKVt+ZUcyZpi0v+iG9MnPQiU8IIhReKHzTc/lKHvVai36
 Vqt/sv4xP6I9CsRuvbAxfNpEuKcEzMm1XdIQHnAZgfXVi57Texb8/fIkEiKgE69n
 v8u+sXe5hJr2ftop4r5PHMPsXfUEPjycZkMKKoNCV/hdmbWjCAYQ6fwHtXRxRs6B
 scrYmj+DpIzFK2sH3IDAKQmwpzo5g==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020111.outbound.protection.outlook.com
 [40.93.198.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g54kf1nnu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 08:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKaAUXSxg/LO0mhF8OwcrA/BZRhnnobLYh0Ckhqj2X1quEBNHS/aVTG9ajhAAsRF72SPBarXnPwr2AE2ysEyV8CCABlyNnztqRtGeddy6iRi0q2lanekEtt9EhKK4H7+OC13/Mfdx4xBedTy3euz5B51irIEZiEbbs/xQy46NXNv68gQ0nPgFM6vZmCzlVnPLqRtq51WMJhig5M9PY38wP7XCha0Ohi3iisjJCFeiPttX693laCMeXaYOjft/CpHXfgCvTZqbI5jgoRaXxKmW1DOmus7qyt5riQGvLpWUyqUqPli6TeAY6O6g1nSY7srYCwuQo/xRsFY9pYUEr0qKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t22+scPtb/Bt94uBwc6Td15ExJw+zInh5aHoyvez5HM=;
 b=yhDt6zIo82zIPLXjVPHa2jUBwY7Zrkkkfqom2yrhMETrpy9TB2UWyFfcME6uoZNDzmWOJ0mZd/jcmqgIGE7KNSdYy7yYxs8XJMCCFbcWGujcytAiKoecyrj6LzbGtLcxr/ebEYQWns4Xys7zw+7mn3cktcW3BpCOEDPcjCZyHnP38/07ws8rKHEQQ8XNcHwx+2yL7QMedMDnhk/qSx9sNoBFcNGeR20/OfhGjUdk0sNyvdSWbUsNiO39zrFAeT9TBJXf+1qsskHBtbvE5FDoKoR4glq9ho+uQyR6cRdk3e12ZzTcx9mkM6B0Qp1nDLtmyV3gSTYaQx7RdJObpQiWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t22+scPtb/Bt94uBwc6Td15ExJw+zInh5aHoyvez5HM=;
 b=gWaC2Sp9GmxUn7vSkaotMIb42DvTqTrJHGOPOfb18LjBhKRfBwgjePGLAAsOwlWrTfarkE07btDZVzSEWLGvKPDl1BfRGVo4fEwHItVgqfGqeYvCcoWYm+I4dQ1gPgfTJNBAQHIdfhDsM5JmxJYhhTwCYv5R9sh7npMo9Z2aMtYv4Oe4kzudM/pVf1kGMGvXRNPQiHHgMiXxorJy5eGjd5mqMJdel2x7cZ3WsI3JHX1XdVbQWuCqJcqBoIkk+VkwHWnJWRpfVJSt/Md4anU1LYnuSmjHds+yEQ37w7mtvN3zx/fvhTS9lPcsrIsrG6JMOfQAOLeZoVXKiHovHbpsFw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS6PR02MB764449.namprd02.prod.outlook.com (2603:10b6:8:4a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Wed, 19 Aug
 2026 15:08:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:08:45 +0000
Message-ID: <217e6706-c289-4488-aae8-08227f2633f2@nutanix.com>
Date: Wed, 19 Aug 2026 16:08:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn()
 object props to class props
To: marcandre.lureau@redhat.com
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-6-mark.caveayland@nutanix.com>
 <178715015699.1965216.5908963098435249264.b4-review@b4>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <178715015699.1965216.5908963098435249264.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0158.namprd04.prod.outlook.com
 (2603:10b6:806:125::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS6PR02MB764449:EE_
X-MS-Office365-Filtering-Correlation-Id: 45660885-1b51-4c5a-5d35-08defe03c3a0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: N3x8vLoVbFGSi62QeOlT1/GsyHxWzS5CIREIElGFcg2H/Rehj01W3CLZAUp+BbPOl1BLBNQPUfFDxUlZPxTykUGCVqMgggiw8UA5CRT2dBil+7YXLmrrPCa+T2AJXKdaAx/WpFcvRgBWkLHrA1XaJLawBPT/TmMAx55SHNTETYQwSn9Tf8B/PvMmK7FIjJ6lZv5QOHDpZOtP2xot2yFf6IshJkhOVbZaCkYB+HbkmFf3ZygCnLLq/Qdk39uidOFbO6gjtXU5gPZJ2nPR/mfV4JtF/OQ6x3kmbEmkqoAOSlqLp2ZqSZrIcSV/hbO98z+MzNVHFxmy72ySja2FR+ZAFY9rOKttciwj0Z4y2KX6Bek8w8l7MrVuvHP2jCHA/T6KNhVuI5TQE0ZE/0QIPPDKpS4Sn57MhiYF1AqoQTm4gUR0neD+t+oT83fQ5qb8RczNE1sYgbdsPz9/pDNZvo7UyISGTh2mWvuXC5hEWqRprtBT/goSwVZ34YTNqviz2aNIoMaCMjtvDzlqNFUJTJD6lG4yDysSL5ZZghmf9K1GKEHj/K5S7IFeLxPzzRAjk9FWn/LSm7vjreGNjLfqGFpyVw/F/anhKfNX+AhJ23KpipCKLhpMgcPlsfw8zO8zyKf/qaIzirGX1/5xUbNjOl3meiuZ7fywGgMv7TQNszV8rFM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1E0R3VSZndQMjYwZ2RQTjdoSUhvQ0ZxcXFHTERLcDM0RXByUFdZWnRIQTdJ?=
 =?utf-8?B?ZkRKUWw2ZmRNTzI5NXcxdm5nVWhTc0pvNVdnRUlOSlBvV3p3L2NoVDlYenlw?=
 =?utf-8?B?MVhlejg1UzhuOFN0TVlhU0V1YmVwaEZLY3prMXcwclNGdkZCZFQ4TnlZSU5l?=
 =?utf-8?B?YzlJck1zcm42Z1NQYWR3SC9mY2QrQUNhZVY1c2xJRlM0RVFLZnBhZVNSOU1H?=
 =?utf-8?B?eTdOTlY5enRVa254NkJTdHJubzVhVWJ4by9PQzRWbENEVytPMWRoN3pTaDIr?=
 =?utf-8?B?SDdHRUNnZWkzeSt1d2I0UjZScCs4eU5nWGY4ZFJxYUNteTFZQnAzeGRCZ3Aw?=
 =?utf-8?B?VUwwQ2dMaDcyL3JMa2VUWk12QTdmRnRYaEVOaDNNSm54TU56N3Zqdk9QV3FB?=
 =?utf-8?B?TkUyUGR2cjNDaUgxYnkzUHpvTGdaN1VPWVF6NmhDUW5odmE3WFhXbk9ud01I?=
 =?utf-8?B?eFc1bHBGbFBwcnBzWjJOc1R2aTIxYTJRNVBEWG1FdFF1a3Y0UW9tNnZOV2lC?=
 =?utf-8?B?a3A0Q1k2Rk51S2MxOUdwdi82RkZydXpPbkEyeEtYZ0FGMGJ5K3ZlYUpRUnN6?=
 =?utf-8?B?YVRtd3pBMmF4REdRd1dBTjQ3NnBWMWE0TE93UU1kSngxOU02d09wSjhMWmth?=
 =?utf-8?B?cWZUcUdXcGRPSjN2bjVpY0QreHJDcW4xNVZ1akF4WnlUVW1FNVU3NURvajcv?=
 =?utf-8?B?aDlkYTRNKzdiaWJ3MVBEVjBFdUl0ZHYrc0RGNnhnS2hHbTRJWDhCa3AwaWha?=
 =?utf-8?B?NDcvMEhzcURmeXhyNS9rWlB1VlRFTW5MM2VpejM4NU9tR0lDaTN2czE3VHlE?=
 =?utf-8?B?MXVYNFZEMkZIWnhHRDl1RFpVMVFNczJOS2FoS1VPQzFCaURjNUhwN2pvc2dH?=
 =?utf-8?B?aXkwWXRsQW10ejhVWm1GeUtHWDhpaWFCdGUrQ3lmWGZTaWwrNEkxK0g2dFF1?=
 =?utf-8?B?YW8rVm9Jbnl2MitoaTBodXpic3BqSFlhZzRyMkY0dDlIcVE0bFZaQkpuY3pK?=
 =?utf-8?B?bHJrdU1xOWxBdFJ4S2FsYTdkZ0lRM2Vjck9nTGtsRnZSeFgxQVh2OUFiUGI0?=
 =?utf-8?B?WjcyNlRvMlI1UW5NM2xvWXEyOTI5OGZ2SE9UNU4yQjFzRUk5ZjBOcGNFb1FT?=
 =?utf-8?B?YnJ6Q3d4ZWR3Y3VINzhSSkt0UTB3S2cxT1YwNVJKV0hVWjdNem0rVkJXRm52?=
 =?utf-8?B?bE1lUmdGekY4bjdjYlNzcUtNSFVKaXlwdHo4Tlg4MTZWSW9FUEhtT0svbit1?=
 =?utf-8?B?czNPejk0WHdNV1BWTzgxUVZzbUZpMkxyZlFCaGgwSmlQTjh3Y2hBQUJnN25B?=
 =?utf-8?B?c2FndkozOU03Mmhtb3ZuYVJHWVNwL25CT2F2R0tZZmRRdUR6TERWM2laMENv?=
 =?utf-8?B?Wkt5eWMvWTVpSEhLVU9OY3lXMzdpSlhVdzJ6K1dQenlUKy9oaWxra2t5NjVi?=
 =?utf-8?B?VEJ1aVBNTVU5NFJPb3A3Mi9wZ1EyNWRabUN6WFRvVkRQeG1GSFU5VDhVbDQ1?=
 =?utf-8?B?aFBiajlLbmpTeXphNHhaTlBTTTlFR2hucnQ1bjY0K1RWK1RETWpiTnJUcGI1?=
 =?utf-8?B?YWN6dUhJRnF4RmxPOC9JSTRXZnRlVzBQSjJES2pPMDJzeXg3MUV5eGFOd0NY?=
 =?utf-8?B?WnloNEFFeUp6Nm82NC9DcU9IMEdtbExYQkErdVZPelJ6SStaWDE3d3hVeVRa?=
 =?utf-8?B?UnU2amFMTTFvWmhvckxZTCtZSG96Qlk5bURvWHZZQ0JLZTREZzhSdFZpd3hB?=
 =?utf-8?B?Yk5wVE9mc29UcUNPVHV5NENTMEczL2I2bTVzaXhHaFlHMmhVUFdETlV2Si9o?=
 =?utf-8?B?TEVTQ241UUc3d0g3MkRRR1VETzNhNEY2TEgwRDVMVXJhSjFWU3E0RWZOQlJr?=
 =?utf-8?B?SHFJRjFuYVlQTTF2b2prQ0R2cE9rN0VRdHNNN1NYVUxFMm81VjVrRlpWMkJh?=
 =?utf-8?B?NllzNnVrWG5BTTBVcTFTUlBWSUxiZXFKTFhSSDhSWHk4Sjl5ZytjL3pZVHNV?=
 =?utf-8?B?Z0lDTzBwaG1pRTZCU24waE1ydjZSeTY0RFhxQ1A0UEJKSnpUMW9vemthRWJM?=
 =?utf-8?B?K1dlTmhtMDhuWGNMclAxb1doSjZZQ2NXVGwveG45SHFSMDVUeFl6ZUtmbUVn?=
 =?utf-8?B?aXBrcFFQU2tLQ2lDcTcxR2RWRS9vOUd0WVQvbXZsRXQ1MFAwd2FDaXAyOElS?=
 =?utf-8?B?VnhycGpQRG1ZOFBveXRwV3FnOGoraG1FeDhUUVJSNjlrVHg1cEFoOTgybW9Y?=
 =?utf-8?B?cEJtTHRCWEMvZnY0TXBRdDlWWXpYWTBBeGlYSktOdjBvd3NubjJ4ZlRBSjBJ?=
 =?utf-8?B?eVVTbWtITmVIanFod2lGTCtUb2hDWUtUQmVjanJsUHR5aWJFbkVndjJaN092?=
 =?utf-8?Q?m3H1sPAG1WdTnabE=3D?=
X-Exchange-RoutingPolicyChecked: TXZ6mi0x6uMYVMx9cLEg3rTRSZKsjUwse5dRuuOrOlNLwzKAKsx9aNv4fLOhrDKnRGpFy0G1qMJhh9pmc5ag5fjXePY0wdGreWit0Wdhs0duAFN3CLNgQ+PKrnQqclvoYGmq/T3SZSNeSV6VH5Dr+j9awEb5feJR+HaxZlQNzw0GmrFRlCFU4BdzFu9hwPvfDOXmyeDf0syFhG1b8tvh+S0f1EkiDGWvuw/T6GM6I1VxzGaLdiJC3SzoHYJNybie44h4RW0YzsPqHB7ncgzIjeJtqyK000b0gYbAAnWwORINMt/bG1IXnV6Bha7UaRwO6kd4Sljf6lsWiAbJjDyF9w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45660885-1b51-4c5a-5d35-08defe03c3a0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:08:45.5055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q64aelYMR2aCvDzG7XUGtvGzpGwk3HCCEAgJcku9MmLlR330/NxGJom22FYAXGS+/RYVwpKuBVLJx62fjXzeuzq7jC+kAc65MyFFhIO5cSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR02MB764449
X-Proofpoint-GUID: xCvFeYO289VgZLrCNdgU49R4scYvb_GF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX3zfEPZy1h+PY
 MDy5R+L3P3lK/QV92ekZBNjP7gO4crVVpD8m93OE2zP/pp8kCSYeOTaTIxUU2+XIHIf1QI2GsdG
 EDrPzahQ0fvqap8VR3T+DiR/Dbo4nK0=
X-Proofpoint-ORIG-GUID: xCvFeYO289VgZLrCNdgU49R4scYvb_GF
X-Authority-Analysis: v=2.4 cv=AfSB2XXG c=1 sm=1 tr=0 ts=6a85c6ff cx=c_pps
 a=Lghs/6261MT82QrUgbBUQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=QuxfxsMmV9refsBu_F0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX3JJBb10/BNz0
 MlRwv7uPgvTJsr/6/DFkw/OqiVb4a/R+cCT//0UkcmBzfglFyIgsmg0lWq+cUVqolW32LwO9mvn
 GiakDlJgX+HnI/bApUGS0bBqhZppSCK341fDY+aSGv1WoKowvxQkIHoSYfx5ZiBWnRE8sXRtmZn
 vohTKw2OCPA8PQx354xpR1JrRkpY8KLPPztP9X5reFQS82jCYb64KbQnvqOMnC0EBaDJV4horqt
 sNyaFuAmF37UcZQpKBmQLx+FAhj/21MyHgLeUwtZwRYQeOD8kA1hfPwnKVjTeXMHAyCGFEBgAB+
 pKiQno2Shq+djyxCYNvVSD8M9AvMX+EWQwtlNTwWvR/8SjclOav0TFaw/IcGEccsQigSK1bwGYx
 lyWdpswggLQ9iBBGr/imguc8rbHlo+YTaetqIHlEuHqCRLCYSu4ffVPLkTEu5OVc7FRtqWp34Vm
 HCjYLi80kYhyCMUm7Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
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

On 19/08/2026 15:35, marcandre.lureau@redhat.com wrote:

>> ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be promoted to a Property since it uses
>> standard uint64 getter and setter functions.
> 
> But it was read-only before
> otherwise, lgtm

Ooops indeed. I'll revert the Property promotion in v4 so that existing 
behaviour is maintained.


ATB,

Mark.


