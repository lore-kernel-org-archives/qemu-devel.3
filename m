Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB0C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysro-00019v-4i; Tue, 25 Aug 2026 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysrm-00019d-1J
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:15:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysrk-00071k-6X
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:15:09 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbegs2320287; Tue, 25 Aug 2026 08:15:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rnrmLd5YdzrET2Tsuatdfw+Us8gXJHhIWpM5wUPyh
 vQ=; b=wMR1827pi1LOfNMtAajbrmBdf1BRJhHeP1lsEAFtKE/ljgVTYNqH66iJC
 uUq9ZV8whO42js8kZf5McK85t/PgYjePCI0m0a5huiTzx37VL1ZfeA0479KaGRj+
 8vtd1gO+tKjTFMJpID5KRnE1UvVBzX3hs3f8l98DVU5XtwvB3nBkqY6f0lh0qOBn
 mQX136Ho/Tta5LX/TjjnV/7iXJ00SdQ9eZQ5zaTlPQfFefW/IuRpnDVraO5tNU32
 YuP1bhVtw0U/FlfrtTFMDZserg9iku/fHad9Jdlktkyce75PApCCBiTfHN1y919R
 +AA2EBCZsyUosn+qhVqynIUOw9aBQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023131.outbound.protection.outlook.com
 [40.93.201.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7bavenqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPkgPNBPSqgUBTU2Wyw5fWM4VVoZ6gtvx1J7Z8VkvF/I8scx1H7IUg05PFH3w7pXjz6ZzKJXedhVVzR1dJXzOA0fTbdBRfqD04qjHDKLmdADqa3CO/1NZaIwLy7bl4TidRjzefsIgKEI9YqPVnHef5mVF6awRMB/dNXY9UX3pb34BHdAUZTIFRBC5cgECUmpl/XJsI0msUoi4RpO4lhiqk65pRMyeYOYll0XsLWwzXNNttVW5HSoebzkgav3L6RjUlp8vYATkLbvF5nYKZo4LdMI1erDUR6XVC3gLmzDDAEQkEQLRXvJD2JozApky4uqq810kEmZhTY8vWNDHACMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnrmLd5YdzrET2Tsuatdfw+Us8gXJHhIWpM5wUPyhvQ=;
 b=aEweT8+MFOLbxnwTHJgNwrgUm6v3sY4BOIUP0P/mdFXNCDIvFft/itk/SPRObW68hfwEIld2YsGI6Ca+eUBngQ6VNXvpxFF3l8nGo/ioaKH5hgJxpcZxBzcpp+I/tZd59aAFF0+9JXM5LalOti7+KZ3bDYvHgKOxmHYr/wGVfITMzc8SQFbxW8lqXGJMm1Ccw7osE1uwjpWnzRbC0CxeusAnTufj1azQ1NOesFwjXNmcRxnWGAOFyuUwOsQ4YX4ANOdynxFpjxrW11opw+lop//unwGXNKxHsJnlB7azFGLBniFdLM55+BKG/WEmSlYAuSTJKdy/fp/6MqzGfYe+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnrmLd5YdzrET2Tsuatdfw+Us8gXJHhIWpM5wUPyhvQ=;
 b=wocvdjs9HFNzM3PXrFjrpzN1zjqASk8NtpNS4EO5quXuWAhX+IcQ4bJvRwxlVWypIkkbmK2vWPuQ1JFAjlnliCFhU652ht1YwOyVUoTTw7YGGPlZjlizbg376Fu9ef293iqxRKV3i4vIizeYwyqnju6baCAh2xdz2p/k8HYdCdzI8jGYEl3uXl2qd9RqhenO39LTRosy6BPwsYn0Lu9MvnNV678CGmeA8Qxjlciq8ieI3OJ20yRrVkOWZvsDzLlxfulU8jAxKDodPZFmqqy5WUpLJ2nmohrHdyHbNghUp8HBR9SATrSq0JX0f9AoiNOtLASb/6I1ftqo2kFU7WYDSA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8136.namprd02.prod.outlook.com (2603:10b6:610:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:14:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:14:59 +0000
Message-ID: <995f2ed4-f718-4280-8ba3-dca81aeaefef@nutanix.com>
Date: Tue, 25 Aug 2026 16:14:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 38/74] target/i386: fix CPUID version properties
 typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-38-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-38-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:806:23::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1033060c-90b1-4b1b-33eb-08df02bba11b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GNFwdBAetgE8a7l+qTUxMVIv6UTchu8PQADMs3tCZTIcf2Ks20ZmOQLQd88WS8YJYH5tOF7f6v9Mod63beZdTejxHdwqNlrun5nCKxU3XgsmppMvM7YmQ+VP4bN40OG6BCYQe5GrbziKUniVVHdyz5TpD3X+jZmP4/WkhZR+HqFI1tyU+04Gk/ReRjEIfpEwfhsHXCNwKgmzAyOHMOPZrpcluRRZz0TDfqxlpxZS2VLLu5UluqJJjL8yQNjLia1eQvLqgYzLU56X7oQWzT4UVf5/q/B9Oi420lq7dwXABRtgpiNBSBX38SVpbFWA5aMXz9EJdaIMQKMcjqdULoveEvO2t3I4ivFOxvsSp1feH0CLC7GMstkBK2hjG93c4ZBBewSX051yW2JqsOQj+DOYjZ1kFO+4kBPLmhGkwMH0mO18ViaQIiqRlenVeXPaCzLAKNWyZIaFmH5pPKn3zDFPxTl4fmDrZi9raGNBuSsdhj+di135LQjMy4e5bDEFnBWFNCW8/E+lsHOfcZ2UFaTo7cLNbrvjrHQxXzZtvIhf6ktgYHJLAhq6PdYe1L8DnYL9z/bPafUUy4qeMdyuUcxo4uD+B+T6lM/v1+KY25yScrcxrgiQFKOJ++KwDxAN1737/lAY55lJo2aT29OUVZRGTELQTTLK8a+NUDumOGHK83I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHA3SXl0UTNnNGpSOVZXUDhCU04rV0lXczhSTytsaEY3TUN6Z2pJMlNFbndC?=
 =?utf-8?B?NWc3cytFVU1FNldEcUFLNzB6YUdaSExWdEhHa1lEbzhuUkNGTEt3Q0RtdFQv?=
 =?utf-8?B?cy9wVmJoQW1nVXo2cWI4WUtibnBDTVZ2UHNIL3FkOUh4c016ZnNIN1pCQ2Qr?=
 =?utf-8?B?ZW9nRy9BelpGL2ZQaGpLOVFLRForUXRwSEMyYllka25lQmp4R0lqSk9aNlhT?=
 =?utf-8?B?MnBpSXB0NVJROUc0UG9NTEl3UTg1aWxlWWczZ2doR2JEL1ozOTNGN29ZWVNU?=
 =?utf-8?B?Q1paamRwMDFSRkhuQkdCblhrQWVUYjNMbG1hVXIzTFBLRWpLYVlubldVZnlt?=
 =?utf-8?B?TG1xSHhTWlFxTXR5b0x4b2haVEpDNVJIUGdsWWdnVFg5cWJ4WTRkYTM1ZDNj?=
 =?utf-8?B?THJMcExNR1NvNkNpVk1jejdrUGttbjNqZk43cG5VNnp5d0F4ZHp3eWkrZ0V4?=
 =?utf-8?B?Yno4ell3c3BoMG5LVkVCeWhhdjkxSW1DOEllbjZnMTg1MUs5WkdReHU4b095?=
 =?utf-8?B?YXJkOUxBc2pQTXBBaVp2QVhFMEJqdDg2MlBxTldVOTZiOVNpczFycFpiZ0JG?=
 =?utf-8?B?cG1HTDVDU0R0SkQ3UTJ6WlNFTERmeFlKUGVKTm5OMXFDbFNMTFMwcVRsUGdJ?=
 =?utf-8?B?aWx2bk83cTNud3BycE1XL2RXTkhGY2lrVEVzWVU3aTk5QU1lWjVHVzRVOGZD?=
 =?utf-8?B?R2NaaHBNcExOamphQktwZnlZY3l3Wlp6aW11U2Mvcml5azhzNHhuTXAvYWpm?=
 =?utf-8?B?TTE1V3JzcDNuNFVkTWVtcVQyYlFaN1FUUkllSmFDbUpSRFFaWkZiSWhSRTFp?=
 =?utf-8?B?Rk9FcjVBVUk1a0JtY0RoU2FneWtob2pvM3RHLzdwMVFFWlk1YmVOWm1ZazJK?=
 =?utf-8?B?T3dyUnF3NTR2WnFEc0V4OFlMeFFRZzNsbzFjSWpwaTlzNkxPOTBYaFo5bWNO?=
 =?utf-8?B?dzBGaFlVZmJ5eHAvcGh1SDlFc0NnWURVR091NVVnakdHSzFtOFdjZnl0bjRN?=
 =?utf-8?B?K3FkZ1NZMUMxaHRmSmhFTmFtUURobm1MaEZEZ0QrN2RHRVZJY3k0bFdDNTB4?=
 =?utf-8?B?YUxZUlA2YWVQOUVZSHluUysrY05kUWVxZFJ2N0VYQi9Jd0dweGtiRU0yalEr?=
 =?utf-8?B?OTBDUmlUQXA3bFl1K0VZRzFKMy95Sjl6UkFzbVltUWZuM2d6V2p3L0Y4ZVYw?=
 =?utf-8?B?dDlxYjBEU0x6UUJFQUkvOEJjUHBiV3YzdEJTNEUzNzVGeHFQWW1QQ2VUWTBU?=
 =?utf-8?B?YUJad2dUZTNrSWFOSWRWK0xWT3BaSXpPc2UwdDk4TG9hRTYwMVFTclArVWZn?=
 =?utf-8?B?bUlLSUlGNXJ4cHpNQlluZWgweW9iZ0N0ek5JUG5uRUNVOGMwejZzeVh6eWl1?=
 =?utf-8?B?U2g3WjZkVXF2OVhRalpDUUR3L3A3S2FmWVZrOFh5NERCL0VrN1lKb1dyU3BP?=
 =?utf-8?B?UHI4b2ZqL0ozZnRUWVRTYmUyT0grVmtYaVY2eHdvMHQwa2gyaEI2amQvbUhZ?=
 =?utf-8?B?Yk9NUFNUQzk1M3JBVmUwRm9CZURVWTd2NkNhdTNMRmZqNjBDL3RFVkpWMFl6?=
 =?utf-8?B?MlhRQ2JWSi9zYWxxelBMTVllY0lOWWpKQitYNVczREVkcGNEU2x0TmNXUk9h?=
 =?utf-8?B?V2lDWHRFWmV5Q0djd0JVdmpoQWREZnA4aHRESGNWUVJuR0pXZ1pJUUxsVzJk?=
 =?utf-8?B?R1Q0UDJNTWFpWnlpVUo1VWtBTVkydFllYXlpVVpBQVZscG8ySHdDQ0Z4cDJY?=
 =?utf-8?B?M3BFQTl2ZUtZR00remcwc2tXaG1UbFhIS2Y4VUg1cklRTXRXNDZZZWh1Qm5u?=
 =?utf-8?B?RDd2enBsR1FFcTBGTisxQTNsRHRGaVhsMjlIdWh6OTBPVHBieG1seXJwMHZr?=
 =?utf-8?B?SzduZXZtdDIvS24wOW80OVVtSjY2SGJqeGtQQWVid3laTHh3cGwvbnBKaUdI?=
 =?utf-8?B?cEcxNUVkaWRTdEZhNDRXSzQ3aFVjeENzRThZNGM3Q2JQcUl2VVRkTnc0OHhw?=
 =?utf-8?B?TnBzZjRKMDNMKzJ5MktmZjg0N0NLWlVCd1FDNjFBZkNIK0N1andUTkxnYXR5?=
 =?utf-8?B?QXljL015TThnK083VTZkWDZ4alJpVGNETmREUHFVbzcxdWgwWHpJVXV0YlRT?=
 =?utf-8?B?dldxNzZPaXYybHRLME1aMkZwQm9iQmZhYThhZzFEc0J1WFlpbytXUnZ0VWJF?=
 =?utf-8?B?TUpsTGxieHhocU9TQnhxelg0Q0d0dWZPdkF0Ri9KcEcvODlYL1oyYlhIS1o0?=
 =?utf-8?B?dVRNb0R0Y0hNMTlWTmtrZ3diZEhxK3hBT2JVUjA4RVNtL0RTSDN1UnYyNEtX?=
 =?utf-8?B?bzlDMDAvYWNXbnVIQUd2ZXJFRHMwbEgzd2x1djFCUTZ6SnlDZDdJL0VwWXNt?=
 =?utf-8?Q?8lXEzWf85koqYItI=3D?=
X-Exchange-RoutingPolicyChecked: c39qQubgipHEO81SVCTZHTAVx7qK1dQbiB3uwyDPN07hSVjR27RpuXd4UxU/7EFA76BUQ+O00qbHaJN9tH+AzCyqemdKImSTGpaMEOkP6l8ui23VmHHQGG1xSWvqnDZ/zqhy9vcK9N0n7kYiywj7d4Zu4WsggwrKYzEaFOils9TCtuUvzg1ctY//QXnvjc8Hy73Dpv2ErMKnS5T4//0bk5orwLMWJ7qzzMqdILUbHLE4OFgSZlamGJqBdm0Vve+Sjo7izHncrRTwkXRoCaxVev/S+BKocft3maaZFAZG3YeBwEgWN2QrSbcS3eCVk19JvQQYghWfYFdK2rh5sIbpdA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1033060c-90b1-4b1b-33eb-08df02bba11b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:14:59.6347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSdbMygb516XRSEo06NaE/1RImQleNgcuRWjTuCdsCz1IHjTiEwc/Hs0Z0rCTTcS0RLUm5MkIH4IRcowdbTD/eUSTT9S89vX/Vybaupr7mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8136
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX/fEAoNm4nzys
 MYpTn88Iy34ocibqJwq2aAEOoXMFUt03SeWzjDstAyKilWXpmwa9etHMbokA5VyjDxqlFM+Ngwb
 X5u9zUaJjih7v0z5Sg5GiVa8QEmltpw=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8db175 cx=c_pps
 a=toaxmG8YyEc+6C1DZWrQ+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=_BW-VI6-JU7XRo9WEPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vgizjhroOKKOLzGYF9jK-eLXec9enJNy
X-Proofpoint-ORIG-GUID: vgizjhroOKKOLzGYF9jK-eLXec9enJNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX5gm2V3RhWoxu
 3khkUHvNRS4duP7lkAhfxfkEGkgsu4CsYbFxBr6kNImqZSZ4HfbY9Wa+T3enne/Jhksrsfahwy8
 E9i+plySIGq86Ww4JIOW66VuvuLNX98TgI3pqy7gv/zZ7pQUZER/Rrlhrh+8IG2JrsMU9tHLUzP
 OfeBhPnXIUqyIhRuQkx3P6C3U7KDIybcds2KKK43R/+D/Pvm3RVmSbd71t6bq1fiZX6DC0quaIW
 KVIsyi21/boS0WxHOS0n/YCEFt75SR37IkJJPSY6R6IUKVS7HBSqK8pFLoNaOE/uOUpTwwd8zCI
 j/U72ZR9qfBuKEQGiQyXibLuSmMui+ykuRYo9gS9WHcOu4oMxGVCGE0YzVLmrBuX/2Cx0yBgzi8
 WpRnd50Mko6Jf1gcnkZHLJ7+CRIYm1nXHZ8VXuTzadhddTlOmXlek2UUceZvtlT+IseSKSdaptd
 AFy/MRComWmTujUYzuw==
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_uint64, not visit_type_int.
> 
> Fixes: 3e0dceaf9450 ("i386: Register most CPU properties as class properties")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/cpu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3b30ded0cc02..567cbf04ca75 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10947,13 +10947,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
>   
>       dc->user_creatable = true;
>   
> -    object_class_property_add(oc, "family", "int",
> +    object_class_property_add(oc, "family", "uint64",
>                                 x86_cpuid_version_get_family,
>                                 x86_cpuid_version_set_family, NULL, NULL);
> -    object_class_property_add(oc, "model", "int",
> +    object_class_property_add(oc, "model", "uint64",
>                                 x86_cpuid_version_get_model,
>                                 x86_cpuid_version_set_model, NULL, NULL);
> -    object_class_property_add(oc, "stepping", "int",
> +    object_class_property_add(oc, "stepping", "uint64",
>                                 x86_cpuid_version_get_stepping,
>                                 x86_cpuid_version_set_stepping, NULL, NULL);
>       object_class_property_add_str(oc, "vendor",

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


