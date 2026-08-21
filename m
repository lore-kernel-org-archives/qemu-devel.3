Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE16C5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNFQ-00075l-S5; Fri, 21 Aug 2026 07:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNFF-0006x3-K1; Fri, 21 Aug 2026 07:17:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNFD-0002Qn-Ss; Fri, 21 Aug 2026 07:17:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9Q3Bt2037556; Fri, 21 Aug 2026 04:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0bVE3vrpjkYB/5AN4Z+m51zwesQU0zoER3SMdqMBC
 iY=; b=ch3dbgPjMxf/G4xDmzLHAhOy005Pv27BC1wTwDw1xyXgaj/kB+auy5nq2
 Nzg3PspLHjxUDgKNyOSYHsmQlUTramVb/jwW0XydMdMYmKpyZJtPnnN/tUI2ykyj
 Si0gQ4fQxcHin9XRFDNyM0R+QKozcsD0CD8QbFMtlGzgn0PJTHrXd8Yy11RCZTqD
 fV3fLsjAfYi+wVja3yAQNhgAual4XzovaIv5uAD/rKhPBcORCQpb/37sXp2+Jgz0
 C0Mrs4V2ccWmJ6iQRgG2WThbPeoVb6qnEdQu+C03Ed3AvD3QjCyhMGVpu4kNi4Vo
 KvAprfF8mAODXLkLYJI02EDxjjJ8A==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020140.outbound.protection.outlook.com [52.101.85.140])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4vnf86ys-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZoBeEvv485Wq7BjsqatZZ0T9EjQPWYK7PzsMe4znGyA7PRZkBQroAvvq7/2DvlInbZ75Fe9krPfLues/sPbkDMBtUuqOyAXA6GCiJ6M0aSr+TRS5hPnb7+qBFi4ghzrTZf3NNqJ8LCh2jRYzfP9GalkOHP8y4qqoInt+Ot62f3X5jAmAwkHZIG+HomfU9ykXhxutoy2xYmNQxX8qC8EdSRV3PWk9R3nD2JDnaoYnNKnc2WbeAKB3hv6Aa8HSd53ibn+DdJrzfOMKwgTwCaXNDlzp89DfWAE6o2iuOsFaDL+CVYv+ZncvltBjMcVZXdkojVtlyhtCL56shWLhb5iTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bVE3vrpjkYB/5AN4Z+m51zwesQU0zoER3SMdqMBCiY=;
 b=VeFX5LbvBr6Pm3t/A+L2OFVWTeQV5yYaoP6z64yA8FCIkJHKrRM6IgY4w52ro26c2P61EoGvmr4jWviKcg4XzRomp3Lb88u7pv8QdizSWxsuxqrVPuQayDWd8hADoEeG38mgXty/P6i7VzB8U+590lyAvminlk4SVKhXw5PAkqFTxzW2QQwTayJueDuyShsq29pNwcGDdHpLQrefYW4iTbhRbXKrIRBrle15xzly1SniAwYzGans8KM0WGL4CbJ16zGj5q88Klwr3DJU35Chf8lADqFNJBlGng8geupbJPLCubdnnHo4R7d+upI3loHwrK5DonpLlmcpF3SncOo3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bVE3vrpjkYB/5AN4Z+m51zwesQU0zoER3SMdqMBCiY=;
 b=TGl/U/BNOkzFZyY8VSrLGVNcLSaentvKkqCHeANbof36YNUYETJ6e1pMy9addtK0b0yIxunY3CFPqIoOztQpWIAwRwdo0j1nPMjdw6D0ZA2bTbNbsPe/mkHmFW4bylHLLwrAgtuCZOYjd5YzdkXqldMcQo3EoOYjOQcn7KQqnJq34Jt5WKyN03D9OUGXIbihhQM6f1bbcEwyw0PD+lqLzDXmZJOrd2ZxqpJzlfmTM7ClYkWtqV8XVDv4iO7uPSnjoLTqv8r2Dm19+8J2nx5DLAH4QczeN91zmBDxjQfYmK+bDj2oVA/u+nGZKWb4cqF6eVLqhUesijgCwEzhmQHKIg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 11:16:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 16/16] hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to
 a class prop
Date: Fri, 21 Aug 2026 12:14:28 +0100
Message-ID: <20260821111550.276011-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: afc78cf5-d2f2-4433-8d60-08deff75b415
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: D11Y1+1f7ZhTR7MUB1k0FQc6LfV9Pr58EtqatB26m2akRXiwtvrZor13+TsFFJTU8RW1hGgsNNgYpVILIZ2jbNlAsQrzN9lo0ygw4L/774DnpOTqWHr5uxImfuSehOqPf4kef3m/xvldsefy2q3K5+CAbbiWghiehEjNkfqv1h07AMAOrs/TLJ7Bb43TYtfmfx0cOAJWNlPV5+bS2oLI+Rw900CaeNABJxrPXFRvGxRDuJRtZupCRGCuERBhs6O78e4ChrWVT59roNXbC7j1EMz0Cf4lKv+beOf0va+xgMTvEJ5/VMeZ+cXf1Ix0/XApAbROqvK8JENW+wg/M5juwEDJOvFCMtAPxX6xM9E/DeQtwzxJ55uSodun4BBiH3Y1fDYDC8L2dmAlLK7BfBR3zaabOZriRPe3wf0wpVlG9ME6qwpYIVG2IEsAU6bRjCshJVLpJ3R5s4WC1ChPy24DGog9x6k6vmVUn2wjMBnYrFreuwPDEBKJfDHBYllUmoWpfMNL40uaLUSOIvo75yUrBm1Ob3wMmmX3xTW2bgkDckstjEf0ujcLh3tGa12XAmKiSCD+vcI40aeQePBGmsvvoQxkzaIi150C6Jot3XtRJbeGi5oB1XOetGfGDAp8R79SM8PkinSuZlMCeX2JcXE9RfPWMzYO+X95FYx4xpEryIYgm8VQMoeAb2YgARzf3/5lSHfIWWl+ZEHGPlqp3nsIKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEpXTE5ScmhXTFBDdnBVamthWndDVlpXWTNXL1NEbk45NXBZNm84VXRrMSt2?=
 =?utf-8?B?aHF0NWFBMXZyY3orc1dQbWxSc3FNZjJiVmFwUVhSMkI3R0xqODNpL1EwVFR0?=
 =?utf-8?B?eTd6b29pVmZWWTRJZlZlRVh3SW9vWElZaVh4VExqM2I4SldTa0pUYjBoYko3?=
 =?utf-8?B?Vzd1NzNwZ0M1NGpRanlhMER3OHFBVU90N2kxVjlpT0ZRR0JZam5ZVEV1Q2dF?=
 =?utf-8?B?ZHAySnBpSWdqeG05ZEFoclVMMnA4bDFlcjhYVlc4T2ZXVDVRZG0rcnBJSitK?=
 =?utf-8?B?SnRiMEJqK01FYjlOQ1I4SGVydEpUTjlZLy9qeG1NTTlHQjk4K2ZONy9ieTlI?=
 =?utf-8?B?ZHpSZStMbS9XQ1EyQnlTcGQxdWxOK2dqVUdGL3VjaXp3c0dSSEJaQ1Q1b0FX?=
 =?utf-8?B?dnAyNWdMWXJuMDI3cXRYOFZKK3ZremNuSGJYWitDbURhOVFzZk53VUpuZTN3?=
 =?utf-8?B?QU1uSVNWczlYL2VnZmMrNFhRTkZCREFpclVMSFFxejFsbDQxTkx0TWxMRk5G?=
 =?utf-8?B?Wis3OXFPM1o3aW83bThvM3ljUFI1NlFLakZzSXI0Z0pJSDBPY3A1cjZtbEVI?=
 =?utf-8?B?d3U1NFhUaE44dmszcmZvbUw3REdyQmtEcjd1K0tKcHZWOUU5WTNrOGlhK3ps?=
 =?utf-8?B?TUl0U0MySElsbC8rb29zdWtvdHcvTFVnRlNtUFp0ZWZNN05taXBFeWRsbE9h?=
 =?utf-8?B?TzU2eWJEMFE1eXFta2pUZnQ2SHZJM25EUnRla01mOU1rUzkvUUc4TmZYZkdo?=
 =?utf-8?B?WGtZcGFuSGl4aUd1YW1oSzd3L201NklNNkVLMnRRc1BnRjUzQ2t6RjU2ZzV6?=
 =?utf-8?B?TXBlM3hmK1Zxcjk3RVR1VmZKbFJtMDJIUTBROG1ZVnpmMUttWFBVN0xxbVor?=
 =?utf-8?B?SHh1QS92dzlacVNCMndUcml2VzlFczR3SjlxRGU5aFc3aFlzRXNaR2VJNjN5?=
 =?utf-8?B?V2JNOHd3QUdPakYyRnRFd25Fb1NTRGtIVjkwZ21Vc2FrUzZkaGwxNjh2N3J2?=
 =?utf-8?B?aWlTT3Y3akJkcEFpaDNtSDA4VkhzeFYzNFV5MXlPc040UTFrQ3FXY2pSdmNS?=
 =?utf-8?B?WkdzbUdaMlN2Q3dWbk1kb3IyaElqS2dadDFCaWN5WTAxa0JsSXo0Vy9BblRM?=
 =?utf-8?B?N0ZQV21tbjFDNVNwK1pHb1J6STB1ZXZpaHNZbDFwSnVCOWU5eFhkTGxGamNl?=
 =?utf-8?B?VysyVkxvcW9pTXZJSExOVDdpWGphdytHMjd0cVhNUnB2ZHgzMmNLRStqeXox?=
 =?utf-8?B?Q09Fb2FRYVpsSU9tdUZjQW55dlBEOGNlQVcvcUZvcEthamxKSzlNQkxiNnVo?=
 =?utf-8?B?Z1dZazdZUjBiL2F1Q05XZGRNOXhRODloTDBmc1NoaTJUckxyNEFjT1FTRU9U?=
 =?utf-8?B?U1d3K0h0TGkvMm5kckFBVjNBd1V5UTNxWGtvTUJyYTdiUDVUTDYyeTFmampO?=
 =?utf-8?B?SXFoOUhsTitRcXRMZjU2dGROYUgvYytlRVczekRvRU9laXgzcWNHMmNYYTBR?=
 =?utf-8?B?MGlZL1BUbnZOOFh6eFRoNTVOZENCdmM0cFM1RElvamZpNDlGWGNKcEVKdURO?=
 =?utf-8?B?RHE5SlBpb3p4TVh4ei9Ya2pDMkFaS3A4WlBhYVdBSWtiS0VwZUxXaUEzREZm?=
 =?utf-8?B?SGFwZzlILzVQU3ZrL0ZXL1A2M3B5U0t3TjQ5R0FBTnJJbGh5elhsN1dIRzZp?=
 =?utf-8?B?OSt0ZmlkSUZwYXhGdXdBQm9YYjZVaTNRZTlQUmRLMkpjdm5UTkVoRWRma2JL?=
 =?utf-8?B?MUgwZGJRakJYUjl4Y3FEK1pvMU1uT1NMRVVMY1lVVzR0bjk0YkhZVFUrRGhy?=
 =?utf-8?B?L1Q5VU9KOGVwNXVDcGYxKzl6dkdsR1JsNU5YNFdWRlFadWhKSCt3dkhGY2h5?=
 =?utf-8?B?Z255eWx0anRrTDR1R0MwS0EyNUt1ZSs1czREQVJCbHkvbDhoSnI3MEh1Zitl?=
 =?utf-8?B?K29TenFTYWVSM3NYVG1iWi9NbXBTY1RhQWdDNDFSRElzTU11TDZ1eWwxTXZx?=
 =?utf-8?B?WHlBWDhCQmdiU0FmQXpuQ2h1cDZMUDcrR0lzdXNaaTBlazYxRS9yWTF4RUIx?=
 =?utf-8?B?Vk1wS05WemM1U3JYc1NkZS9mYjVsY1dOblpuUGdUZ2g4azBxYlNSY3ArWVls?=
 =?utf-8?B?aklWcCtYNVErUlN4OTFaamR0RjJzMHA1WUM0alFCRnJ1dzlqSmRRMEtCSCtK?=
 =?utf-8?B?ZEdNUm5qSmtiQVpCQnI3QmNaNjNvYWhmTTZsdGZCVmxoM2RvRnhrR3ZhT0xj?=
 =?utf-8?B?TVlVVkZTQVFKSHlhOGQvVkZZNEZGR09OdFd0QmRvYmJ4SW5sVjF4cEN6ajRt?=
 =?utf-8?B?MmNZSXhJNzI4SVRLc3ZNRlAyeXZySE91Qmc0VnVtV0c3blVMamhSdEdhaTRx?=
 =?utf-8?Q?Qa2k9syfjpa+3rSs=3D?=
X-Exchange-RoutingPolicyChecked: FkImkaLnNWo1WNtaHUfmlqshTKyDxHHLrpwHjvnVrhQzKBC5/DXrKK5S6XFMj7XSvuDEJfahcVoT4rze26974MnlpEeLc2tFRpbs0zu9EXqDikR/YXgquzuxqA5oDGDkEEZ7RcbMwD/xUnxkuxi8l33hWvCayN3w7W35PraT98hFPhEAoTQFTZLZCzBmARxMClRBEc8fQAwt2lLgGPFtGBRXdxHeaUNa7xYInk4Yvp5Z6K3zSR0omFa/hlMmhB+2rrer3AcxgYeRxzPUIrEiwHJInbizbvPvGwpj7SdCBN4TuBpXE6Ao6BgphQk5nDpxJtPXbOFaa9WmmQeT7qHq5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc78cf5-d2f2-4433-8d60-08deff75b415
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:53.1555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNJkggTSMIQzXpN5z9ROqkF75l6qL2WWYzzrNQJZfoDdJLLy8jwM/fgHwmlqikOpaR/UPWXfWEcgBkGH4GPf/d8ny//y24FI5dJCLW6kwvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8991
X-Proofpoint-ORIG-GUID: trY_EHOq5lSUfgg4GqADtFjbSVN2fZ5h
X-Authority-Analysis: v=2.4 cv=OZGoyBTY c=1 sm=1 tr=0 ts=6a8833a6 cx=c_pps
 a=qT2ADiACooojDGKohgXUBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=i3SjWmbloiJ2BglgP1YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: trY_EHOq5lSUfgg4GqADtFjbSVN2fZ5h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX2s4fGiQgpqUQ
 LgWeB9qOSbqmPBruOUTbSJ8L/J9tkBAIEEPuQ3A6fR2JLh8fe+nD84J1tglBZAqiZNsix29X2ic
 xkQPQ+FxrOF7NTOPSHvYb0SnuK5uWFdZrC8en6IS8ioJ/FFBgg7dHLESzeTe7lN9MtGVo/HfU4c
 Xyi+eY5MPi28sx8t/2Hstk8NAFwNK57/ATCTMevz1sMA8dNsOWhybxu/dC/peeOhrRbk+PmHAmt
 Q7M1bCpjLYK1MaxBY6hWAbQZhg9ewLH9+TFl8MDxpxLsGToL1zh801z+Hk7Y8rCqqX7G5597OVV
 Qe5QTgUVDSh9NnUlUk4Nw2AR9ZRmzmdCvA8g+qoqk4Hx/iZ6pxqxN5cqVFAmZlsDnuV2WKhjgNq
 T8LnebTqvUSi5OZ4xbRxnfiTMyEDLLzYMu7CVZtn9v3dUbnBITN5tZZCQWO7y+VkIRu54SSd5Ku
 g7smPh059g/5osUfG5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX3oJUp/XrDAiB
 l5/e/Hh9w2YaeB6gtneWTYRjYsmhIJ1tdbbyhAKyo+XMe1vgx9QIdqOWOnKoGtMKUgJM88jbBoy
 ZPhoqPioAClQEFf/hu4u7i0ub+7rTFE=
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

ACPI_PM_PROP_PM_IO_BASE can be converted to use object_class_property_add_uint32_ptr().
Remove the now unused piix4_pm_add_properties() function.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/acpi/piix4.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6462ba970c..52bd61667f 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -405,12 +405,6 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
         (memory_region_present(io_as, 0x2f8) ? 0x90 : 0);
 }
 
-static void piix4_pm_add_properties(PIIX4PMState *s)
-{
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                   &s->io_base, OBJ_PROP_FLAG_READ);
-}
-
 static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
@@ -439,6 +433,10 @@ static void piix4_pm_add_class_properties(ObjectClass *oc)
                                                 ACPI_PM_PROP_SCI_INT,
                                                 &sci_int,
                                                 OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint32_ptr(oc,
+                                         ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(PIIX4PMState, io_base),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -494,8 +492,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error **errp)
 
     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
                                    pci_get_bus(dev), s);
-
-    piix4_pm_add_properties(s);
 }
 
 static void piix4_pm_init(Object *obj)
-- 
2.43.0


