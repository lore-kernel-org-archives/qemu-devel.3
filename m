Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB82DC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysk7-0005UM-1A; Tue, 25 Aug 2026 11:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysk5-0005UE-A9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysk3-0005Vp-Hs
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbevI1956839; Tue, 25 Aug 2026 08:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/3M9v+zgGTB8PR6J1aEAa9oqU5mE0FWY16wTkOvzF
 mU=; b=F0WV7HqEVhyXrY2+047AI4NIrH13PQBIdc53chEOoSYwCNzyhYMPQDiYN
 c1m/O3Ce/4ucZ2QDfgGAQrk+4XMEetAd++nYU5rkVXG5vm6Zp4y8/Y+xUdmRYZ5I
 t1RoCZ/l8qbbPuVdqnYtFgN/loR8eFybOTsWoUTiQ8WREZnptp+nQQHHj3GGe4f4
 JWqw/UgRVrps1E2QigTpOTNDPPzbzJNObzzSx0hz1hEVVXnvFlgh+lUGl87FwiI9
 9EsM9j4HQnflYEpYaG+KAw4bJT2XttSt5W51PaCvAGFPHVEOiO6s2aRF9BWcxw+f
 jmd173Drfu2XoUgbJgxsCkLl9Gsxg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022126.outbound.protection.outlook.com
 [40.93.195.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qxsmd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkeyRLpdDGSvGs5nn4fOH+BZe/3Qp10GvyHCygDHKTOulCAF7dZ5binm1+2UAMWqdqbPDGUAlQF692P/UmukCEcqFYWciclnbbzhlcpv0FULcThY1gXVijuLY7DE9XNn7AgBLd0vtPRLUjcVOxYh+is1J0QgQhlef0VwJCQt+doWj3ujB/GOjPULMu8i16/VY15L4tLdWcLj5zOZnG9L7WIByAAQqb1oGX1tVLftCUrBpIu5soIp0jO5l6C9f1NAMZ3uxraoRFYw7O5k7d4aK6woI42gyOB7qNIZ02tvP0pV0Uiz4dAxn4+B/CdsKntt1caFjmGsHUSk6WuXQ4AhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3M9v+zgGTB8PR6J1aEAa9oqU5mE0FWY16wTkOvzFmU=;
 b=CYubxnv+ucZ4Jy8EYtOwLueWy46KnFDDTicpNf2DS0LldcF91e2BqvaN5tJZ0n9v6lcX6zCp6uHgIMh5J2TFSwaHbvJ31Gr0W+X8Ol6uH8zBROZyU2omwHj1pHJeD3dM4Bhd50JszFmI86kdvB1AOruQ6i+J8HniwYYWkLVakMLIviVwNtT1a3uBmUyVvgVamklkYXo1vqGyY9mtlxfhClWfWtYQti2Nc00E5yIFSMQ9BaVds++lv+cXqoDs2c76CsxmFVjvleyMKIylgpTt3Pk29tg1d4Bfrf9BKSOWXWehCy1rA+HNAlhpiWp0B7PnnaS2O0/ZJIhERceWaz3nzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3M9v+zgGTB8PR6J1aEAa9oqU5mE0FWY16wTkOvzFmU=;
 b=SPGWHyfXLW7cmyiz3iuvKVxTMYyB5w9THP8HWwG0M6qFe/DifiKDWiV+r7eYhqwMTX8Kcjd2vSWgEbiH4rhaVxWY5fBpBHrQb9A8tisq4wlB9XxXsk7a4mkEalLD4GawTyAsqkPxFqYn/RI3niu4NmgoP0OfIWgFUbrStzsmTepx/pmZovXsx+pLeR+CSlIr4BTGJLGk64mC+WKlbK1uH7wi5sBv1zbueHtJs9LoBM3hpKlbkJEoNsibnfn0hd2YxMF622GSIWS/fORNxcGzRasgoewYKmFVh+eKBrpyLy0b4TrJ0GQIv6tW7VdroyEgSICJwQdy3i//3uLk9CZ+ZQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8136.namprd02.prod.outlook.com (2603:10b6:610:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:06:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:06:55 +0000
Message-ID: <2a4be3a0-c413-4170-8aca-8d59717fa8f3@nutanix.com>
Date: Tue, 25 Aug 2026 16:06:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/74] backends/hostmem-file: fix "align" property
 typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-32-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-32-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: d89d4600-2ecf-4bcd-1c6f-08df02ba8052
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pQWts+H2PYYxLfhbSdN/eXKC0Dwz4bM9a0JYQDULmnVIHZ5Wt8sZfTUb1nLaabY3GJ3RPq57/muhBVVgw8r4qAUJ/7NT2nPBx/wqST1X3jRDU8O8g7+NvxzspuErcPDxDGjh9/8Kq4kVN30kwShVlV/PiL0aWrVa4/A0sasKW5XN4E4rhj5sr3Ff4dFtntbbQdgczQwnzoriPr7Ry1+mAxacA3vmoj53eKl9r2TKdtPBk4r8liKUoMoqYMHJnhykhUPWHnm5X1JBku8sRZOxshBkTqY9lnKT6fah6Y8LBxO8m/z256LAwYQDF9fDR/0VVKAeX7DkvsiRIyIYi8G9PQe4ZneIYmI2aFW7sDb+O3jQDmSp6jOfPPvQmw/0JKyvGRVbss+HtTSLZKTZK8oyi1i4ARgYqQMArTz2hSxU6HcGE6OTlzYh2LVGgRKO4iAZn4hyV4mhGACLQDPmqni+J4nz/4pu5qRUPDWsgdI1AOaKTQQ1yODOvQ0QZtuBvtqDgeT0DNoYNAg5yw+b5cFN1Af1DjtXHsAmfh/Jr3NmlKbJPLCGwbSvJgSnPIiwyXBCS9DNBxnoGQwr0z+rc2lOcoJDhGbI9orUKDgOWocya63OyaxVHML2IzxyrHipFh6lw9N8sucu/qFbl4VZxS6u9YhigVys/v3ONrSwMCKqgc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnB0eGRwMDV5TDl4bm5yeERMOGpFa2wzcUlFRWd2RFBaRWpiWmxsSmlzdWNU?=
 =?utf-8?B?c1ZXaGVIZEYwRjJLOTQ2ZlhZaVo3QUZFT1VKSTlFRks2ZE1QNE40aHR3R0ZM?=
 =?utf-8?B?UUpNb1NQUjh2RHQyQWtpU0wrYmszdThqanNOaTh2aW1SUnc4c3padHlwUm9C?=
 =?utf-8?B?S09jR0l2RzlXRDJDekdkNjFyOHVGeWVHQ1BnVFJQWDBTbXhwa1gzSmswRWxT?=
 =?utf-8?B?R2VyV0ZOVWkyZ2U5SGZVRVZXYTM3Z0dna0lQOS82MWF1WmVXNUNwaTVoY0Yx?=
 =?utf-8?B?Q3RlKzU0dllhL2FzY2JEbDFJU09CQTFxc3Z4RVMyOUpCTXk2M1BmVVh0d1lP?=
 =?utf-8?B?cXorVmt0Ym1XTEtXa0d3UCtuS3pSa3cyUldlM0RFemhnRkF2NEhlWUlaY3pa?=
 =?utf-8?B?YldoUVVtWmF5Sm9ZV2hkeDFiTk5ERFNjclo2SjVJMGRVc2VmaWI0c2puZjQw?=
 =?utf-8?B?d25jMWFzUHNKaENTcXpCL3JYdEJpa2JMbkFpU0lsTFFZRVU0M3dMcTM4YmU4?=
 =?utf-8?B?QjZiR2Y4NHhNZ2FaeGE3SThha3FEU0diUHFZS3ZNcU1taGhJa1hXM3B4Ulhh?=
 =?utf-8?B?VFpOaWRpMEh5ODA5TURjaXhZV3lpZXVmWDRzNXZqdzcxSFVDV0NXNHF0UG9k?=
 =?utf-8?B?RGtLNXBQM0xEYlJOYkg1Z1h2eHlRZ1RKVkNLU1ZjQ3hzUWxYTnd6cDFJNXUw?=
 =?utf-8?B?L01FdHUzUEdYcmpjaW83MWpObGF6YVpIZlZKcFM3eVgyQ095di9tQm9qVEps?=
 =?utf-8?B?QjRXVFJyUnZIVnErb1pzSzVMY2I3RGgxU1QvUElWeHRaWkFJRXFEc3R0VGI5?=
 =?utf-8?B?b3lQN2lWY0lvWGlQN29sRXF6RjBhczZEZlFQd3VwdlE2SjlHOUVFaFQyVS92?=
 =?utf-8?B?MGdDVE9zUHBmZkJpTjZ2dmF0KzRLZ2ZkUWd2cVdvMXUvQzhnMmEwMFI4Y3l6?=
 =?utf-8?B?MWhEVnJBWUpwbWQ5OHBjYVZZdWEvTmFKQmxjZ2ZWWkk0UGp5dmdSZ3hOQjNG?=
 =?utf-8?B?SlUyS1pGRjZvOEhhTFJZUWpMQjFVZkxycExxRmRUckZETjVqdlZxYkxYRndT?=
 =?utf-8?B?S000UU1naEE5K08rZ1FLWFlJQ21ZbzBmYXRTRlB6RVhEcjRZZXFycytHd1Yz?=
 =?utf-8?B?KytDOS9tcHdhZFlaUE81RkxkUThKOFpZQmc1UW5QZy93OTlXblhOWjRyUTlh?=
 =?utf-8?B?ZWN1QnB6WjlBMzdXcVEzd2dUSkVKMFdybmRnTi9EQjRxRHpVMlFyMEpHYm1u?=
 =?utf-8?B?dWl4QTlqT2xMTGlrUlZRWGRjYjVSMzJkUktHV2NGVkEydkttL3d1MFV4aVZS?=
 =?utf-8?B?UGlUS1ZWU01CT3FSMlFtMkhwQUNlQUZBWGZwTXlWY2lhVmd5VWhTdzExZm1G?=
 =?utf-8?B?c1JFVFJ0VEpYUjBMSjcyQlQrK3kvY3AvVE83Y3AxcjZTOEgvQ3RZcWdRblRJ?=
 =?utf-8?B?S0Zaa1pIVzNXRngyUklwVnRoOVVSb0tJaWFmK0RGbUhvOHg0OWNMdE5YOWtE?=
 =?utf-8?B?Y1NGS3BTeHpYUkZVOG1ZeXo1djhDWW5TL2luU0h3b0JvVktLUFNFQWRjNzVH?=
 =?utf-8?B?cXhQeWlsdlRVaGhXR3RCcVM1Z1hZVjZvWFNSTm90bHhkYjRHaFNPZGRmZnpw?=
 =?utf-8?B?Y0xKMzlRY1VYcjRJdlhOM3VZZ291T09oMnZJWjAzZnVMVVVoNWlvNVNtd2FF?=
 =?utf-8?B?cm1rSGR3QWVtZkNNeEpsYkpMSXJ5NlNpS2xNNjAwMnNOalRObC9EQnM3eGpr?=
 =?utf-8?B?RGpyNVVoRFJCOVltbUdPelNTK0Z4aURFcXFod28wYmFWcWJ4bGw5bUR5akRh?=
 =?utf-8?B?OE5uemRJNFNiYWZpc3k5TWh6RXYrbXk1a2dSWkU0aHdDSnprTnlDRTdFR09L?=
 =?utf-8?B?TThXWmN5bllHR2xuamwzaGdkeXZEUEo4aDJoZ1p5Z1ViL3dYbEVaMzF3VzFx?=
 =?utf-8?B?L052Q1NvZE9DVHZycnYzTzJESEpVc0pZdngrbldjQ2NBU25jZ2hySEFNZ0tL?=
 =?utf-8?B?eXBaeWRBVm5vc0UwUW0yVlo1blpBck1Fc3NCbFpnZytxa3dqTnUxd1Vlejla?=
 =?utf-8?B?NDRnL0Jnc3BKUWtpU3QrdUFNWnN2cDFBYzVDNVYzeS90czRPVEtNMHc5UVRZ?=
 =?utf-8?B?d3pJWEdqS3VoVWpIK3prMjlRZHU2YUpjd3ZKMHE3aEJqY1lLT2plVGxzZDY3?=
 =?utf-8?B?V3EzY1h2NmNlQ0FhNHZUVERUMDI5d0FiVC9wMVpHSS9ETjhML3JJNlc1K3hE?=
 =?utf-8?B?UVhUMXlOM1RUVFhZbDEzMHJ3azRlMFllcDQxZGM1dG1Fc0xZOG8rbXBwMWJI?=
 =?utf-8?B?L3JsZ0swaUZneXVsZFM5eFhJaHExMTBHanZNWEtDV2M3UUhmcEVVYlJMbkZ6?=
 =?utf-8?Q?TsrtcuFvJwiQWNo0=3D?=
X-Exchange-RoutingPolicyChecked: OYVqgXGQ7e4M4azusFYN6BpildZZuZyUnaRo0Oe8mepnt9nwnS6wMxhgMahTAoCxNzb/MMxeiBpSjwrV0gRQfCeNR3G+dQdAF1UHQGq3h3Vk+p4lR6w6UuAyjH4yNvjiqIJY0qMyBydycbs41MljB1X39I15I7oih/IjefJIeCvXb+Az1ULiSmSvX8be5FuVnyAxVSz65SQsuzG91e9Y/NfV/pmi6Rqc0HMIV4Wk+ldCEkACVVAfG029u8esxjPUBrh7Djm8pE2eFMZKBH99G/Z0JY5iAn61dfWO7Ai0BU+DBR9FMKinv9x3pr3TpFz89digbS6zffV7UT5bS6YFmw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d4600-2ecf-4bcd-1c6f-08df02ba8052
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:06:55.0873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnysgLQC/VTwKxVBhFEUvjHyKhQDxvrNXAREiPwky3CepbDzOgGGdKU4MlbnKEMqgDfwNGdIFd5Lfj1P5GD/NYdfnHp8Ug1bP/cYaiAUWBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8136
X-Proofpoint-GUID: _ZUOEcs-FMkHGOA7zcGq39H2LLiQb8P-
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8daf92 cx=c_pps
 a=uymmTM4Y+3Yl+2F0nrhS0g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=TzC1Z_doR7fMe7tOHAAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfXxk3HHfWfZbAC
 +u4EvqFukr1OC+95sjYzewxSFN5p7vnKxxkt6vQNN12gsy4B3F6WIoxM0ckbs8Ih7oaBfLtjiD5
 o1BPIa4gzL5XExuSbRSVYcugVhzPEoU=
X-Proofpoint-ORIG-GUID: _ZUOEcs-FMkHGOA7zcGq39H2LLiQb8P-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX8ZJY4yUgLtY0
 6HTP9gUUMqoQG8Ca0T7RhB+ucvgnJ283X0zQxzeEIO9XSne9U38/b7sg+0FTiJiyBPeAeTO6bvx
 HtAg6ts7GkoawyWBOuFqukKScFkVp9wjQyyOMZncO8p9+4QygBHU8lO0mzoEmxraYzf8B2SrwVK
 MWqMRj6O1uLm3SfmSH96YqIpQ5XF/IYOFv7x9bVK78c4/5YYW9Q7LAf37oCHQXYomIyVqWbVKsY
 uNBm2uUOHmyOY+wHlInPCy+38SjhwpyB8QQPe13F9U1FgILM/261vY4e9gwu3vY0OeX7WIOBT4E
 u8+JSUwtcaQOowntBBszHMDXahcMc8Fw30+fCpBmMEs3atFOlGFtGjVWqLHYwHR/Vb2RpdLIXEe
 xJIA3LzJFttsDfeEuG1qnXWkzgXB7nYyQ10sR7aadoUUS/3LBKsgvUMT71pbrzRNLuWA8z9fCwg
 78yKNivTmONgJL/75+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

> The getter and setter use visit_type_size, not visit_type_int.
> 
> Fixes: 983768431676 ("hostmem-file: add "align" option")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/hostmem-file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 52b62f715334..39a46d353839 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -275,7 +275,7 @@ file_backend_class_init(ObjectClass *oc, const void *data)
>           file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
>       object_class_property_add_str(oc, "mem-path",
>           get_mem_path, set_mem_path);
> -    object_class_property_add(oc, "align", "int",
> +    object_class_property_add(oc, "align", "size",
>           file_memory_backend_get_align,
>           file_memory_backend_set_align,
>           NULL, NULL);

This looks right, however I also notice that both 
file_memory_backend_get_align() and file_memory_backend_set_align() 
assign the value to uint64_t - is it worth fixing at the same time?

Anyhow:
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


