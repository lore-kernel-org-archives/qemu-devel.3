Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3FC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYVk-0005dW-BI; Thu, 13 Aug 2026 12:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuYVf-0005d4-SV; Thu, 13 Aug 2026 12:42:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuYVe-0005Tu-5l; Thu, 13 Aug 2026 12:42:27 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFUXZW3467664; Thu, 13 Aug 2026 09:42:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uuGhE44ldBnmCMCfVCEiG9Tl7coleImnUQy+hBGC9
 dE=; b=oDot7Jze0fN29AINGtMSEG+KUPHJnR/oj6Rdgy9Lx8H7hB9t8DOGLAyVV
 xpo9xXnO/RUfguyPugEhy3BCi9o5yAXKa8jjMfbOlpUq3Dbd0pGdm8DitEl2soK9
 /7gADe1csEBfO8nIWiac+VFCGoZSyHx5Q6gvm+OzNEqmr7hN7ro4bPs+fj5/C4fa
 O3vwBaAahGCA/nRYpO47JFI8al9gokDAykx5YtBbhu7rsB/F2JJ6RK4ioUdTZUHp
 RWpAk5nv3WaQAV8d0wdmbVvVctMWY6keAFXrB7ZjC4lO64MqCAyWhiWszl7Q4OI8
 L7ow2qDRfsWbnIwCelc0k35Lj94rw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023103.outbound.protection.outlook.com
 [40.93.201.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g0bquwb9q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 09:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMxMi1FqtX4QaeGQ8Y7cbcSEkip7+f9dY6hMr6vVn9GgkOJn0c3fK0iB/aWIQKA+71+WgPJQmk6miKygpsVbWGxBpyFNNXRXBSx4m0oaId+XTNQ6qJfd2UugGB9LQFI1e6N6XkNqmnW8wEFK8oavv4qRPI58tgLlHzmvTM/Sf6LQfudKkProDrpg467fHa2XPAKjheMs6NlaafT7WEcrBcfT0Sb58uqutwqecYkicQm/arDuJsKYJjuCyutqNEHtsfnyz9CxpSIw1u/LS6VfDUaJpF8B+lEHA6exsVz/3qpI+6Nz5ScaSeXqhAUIyJ8qtVmVmmSv9rAdupAL6xJkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuGhE44ldBnmCMCfVCEiG9Tl7coleImnUQy+hBGC9dE=;
 b=SKfXbup7jQL7hHt6FgXCNnYEKUOj02FAjF3ktgiuXdBwH2n/tDXovoU3Jmq4Yfup5fNa/2J+ra4y/7rAQST4qPJVkIfloTmDtnkR+LjwRamkc02/zPzA4Y2KyTRylIxOXUAR7V1Tou41hEGB3CARGWtlPulmq13h+yA3QS+YC8NAtuzQnJ8M8J3Z7vOxxGcMTh8rcmlEyWGdbtYyAxM6KFHu4nJhGfJTUqejAxFKvRbyKmFGeuKS6KjYfmlfENPsgMoSskrR13+F8lxIxu7yAFaj5BChQ620JXYVkEDUfpeDKeM/hV1tp3XHEf/DSL/w78XJKl19q8i3k6ZWGXqXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuGhE44ldBnmCMCfVCEiG9Tl7coleImnUQy+hBGC9dE=;
 b=loF0D5HwwhmtOvBv9tl2kiRnCCEykgLFT2pv1Y2IU8pN2CbpZ7ycHd47y4S8COqZPsKdQYturCqsRF8fjLQox1C8jibYpx57jxAvTleVN0ZTRVREo4Kgry78gPbt28tFm0ALptkE+CwEzyC99vDhw5l9s+XPLckGrsGYQQ9XoBT9YqA5FjSk72QOew079V/AxwwlOI0ZJZY4S5WPriysGCIjDZOhU/g3Bp71shzXyiI8CxSPTHhY40n4kR65F+0DGd4xsTBJ/O5LbFhplzB7jyDWJB4y2c3sW17dm3DI2fCaTI2Td7JdfP3tg/TVHyjVBAM/Qx6oDdke6eWHkRqpZw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV2PR02MB11107.namprd02.prod.outlook.com (2603:10b6:408:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:42:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:42:15 +0000
Message-ID: <1e3fe188-2406-4ab4-9555-bf04b6d1498e@nutanix.com>
Date: Thu, 13 Aug 2026 17:42:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] qom: tidy-ups and preparation for class property
 conversion
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
 <an2epcdoZPrz1T9Y@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <an2epcdoZPrz1T9Y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV2PR02MB11107:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a96ceb-7d41-4c34-bfa2-08def959d4c0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4Jw7n6PW2lW6vLTC8W6kkv6qeYZ8bc6e3VuRPdriq0LAjjTwUDAgPhSqmEO6kIO4tFM39g5IOGw+vJA7L2BR/C5hfHZxJTwhnm6nplrubXtt+/QnUGPicJhoI+hCs/lzsUNx+30w1QEQQibm+zgdtPoEkL7y+MOBBMVvqMzvPtI13U9RSWJZHeukOOIpbJxXxvdaLjRMY/Cb7/r6hpY0LREQYuBTajJ3HNVzkWf4fyOb/A54Vy9vo/fSSZ4xDbQo+3v7LXfkwDoruii/wlPjzsECeHEa1soVfZy1P1pG1NiG4ha4szT9fuvWxe3FerN2+zyrpxDM4rP79wpib2q+/Gw4zZcVCnINhVAIR2PwP0MUfrH1JloAvBq563nessBXf46L9teZgwI8WxKXUfXOcDVki+MitbhshZxMox+CgkiaQDFm/f2ouE9Rv0gyBhIy12fWYl3xlyfQUi2gz4KDbnwBCQhJqYW9MPxpY94uTRZnbPjct7qnO4y1fYEUWIKQ/uB3AgTee3SLTcvfpnf0uwdYCt8ZyVxVEtvqtFCTtl7TZ8k2az7EIJ1eNHoX/yeiaKqO7Re37Qa2wI4JKmzuEKmchC6YJwbLyvUB3f+PdSzo4asUTJgDUisLFqWzOkhhM9AcoOaUBPivwW96A7B3vHvkb+jPsCtTa+jHPYYq41Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RobFhZSGhqMkZGbS9BeFNhZ2p0b0F4M3llbGNscENoR2czcFNxaldJMFBq?=
 =?utf-8?B?WmRqbmoxeGNsNlBCTnd2QWNOWlVOVWQxakxuc1NMaSswbTYzN0NvRDBOYlcx?=
 =?utf-8?B?WG1zbi9tQTh0ZUNKdk9JY3d0L21uUWFQcWRCTEg3RVBTOG9MUkJBMHoxWXpR?=
 =?utf-8?B?L2hrd25BdFlhN2s1VmRyZHFWc0VWcWlTOU1hVE1kWmhjaTF2cjNZZlY3YjFj?=
 =?utf-8?B?eDQ3TkRvSHlscmVUSDlQbTlaTG5pK2NMQWtQMGcwR1NuckovYkZrdW1yUzBk?=
 =?utf-8?B?UGQwbERnRUh4WGdwSzNFWVdVNkx6cWl2SHlLZE5ZUmptZm05TDhPK3RPTmwz?=
 =?utf-8?B?TEtKR1IzYU1TVE0vNWx4bmc1aXRGaGdxa1lublVENCsrdkVjRXA3amplNU5z?=
 =?utf-8?B?RldmS0R2bjFDWk9vbWFJaUNrY1JzU2VSeWtWR2xYTFRha2t3MkZ0QTc4Z21N?=
 =?utf-8?B?TjJYKzN5YjZZa2VFQUVGTThvTDdKU3JoTC9tTE5QZnBUWnR0dFFPRnBVTjlq?=
 =?utf-8?B?Q0lZZUExREtHL05rVTRrM2FPcG9BMDRvODZGQkRLa2xpNkF0TTJPcmY3MUtW?=
 =?utf-8?B?OVcwTVg1VWpEZGM5VlREc0xEUDJWb28zM0xxcDcxWVdsdlZBalN4VTJ2QmtR?=
 =?utf-8?B?N2JzRFRicFlJbG5UVDZ2UlY1MThybE9DeEs5aGJScCs1VTMyTDNNN09PWURH?=
 =?utf-8?B?T2pSa1A2akJPT0EyWDRKNkUzR0hqK2UvbGFVd3hLSnFUMFBJZGxmRmtudU42?=
 =?utf-8?B?MTc3S2JyWVAwWkJBRWVJbDZPd1Q0ZVNQK2VjOE5xUm4vOVl2WXJYSkRHcGZM?=
 =?utf-8?B?UHNkMEgxMDd5RklkRy8wTmpjUUhncmhQVzlkcEFWUlZ5WGJTM09tMVVjM2pM?=
 =?utf-8?B?M0MyaVpZZ0FUWHZ5aGRKcHJMZEtEVnZJNGxyRGRra1VuREJMZUVjTEJlZFVr?=
 =?utf-8?B?MFpXc3o1cVVuQnRNdHRWRnk0akg0RUIxbmxCMEt0aVN1WVdJaEcvZzNPeE9r?=
 =?utf-8?B?YkgvMm16Nks0WWJxV0pPSlRNbjFCZXVwVnFtQU9QSDJUZENLbkJSUm40QjlD?=
 =?utf-8?B?S0hNWGR1TkZmZnEyN2FpdFhxNDlQOFFncVRjNG9VTGoxbEJmbFNwOEdZL0NZ?=
 =?utf-8?B?L0dQSUtyTUViUlZBUmRmQS9KZ1pHZDB4WU14Sm5zWnZCamVYVk5iMUpUVmY3?=
 =?utf-8?B?NThvVE16V1dEb0VYMG5wSGIyRktOdVZ4TVpFNXZkdjBCSU8za094bkx2SWs3?=
 =?utf-8?B?bmFhWVRMeGpwb292cWNRaVZSeU81WUhRMU1aQ1NjRDZUM2hzR3VGa3k1SWhZ?=
 =?utf-8?B?OFQ1OGhXNWZjS3o5MWtoRVhlUzNkYnBrZUZuckg5ZlBBS25XODFtN3NYTWNx?=
 =?utf-8?B?VGVzSjFPT2M2amxNRE1oTWFLekNhbDFPMzR0cDZLWG1JWTJYaUk2RVRBYVUw?=
 =?utf-8?B?aWhJMWJYYTZwUU9xd0xsT0t3U3F6ZmlYMk1HRjZJZm41aW9ZZTFSZ1ZiOHVM?=
 =?utf-8?B?UjUwSXFwcE95dThQOGNadlNFZzkvajNPTUNRNUwzMFRrUk9xT244c1pWOTVm?=
 =?utf-8?B?M25xTGhWL0twQVZyVk4vNEZyRDhkZkFjYXBvMTVrK3hENlljWkQrSGFTWnN0?=
 =?utf-8?B?Ujd3TGRUSnZKSDlnNDhkMkZabi9wT0JKZEtuVk8wd2tFQ09hdTZLcXRJc05E?=
 =?utf-8?B?b3ZIR0VGdWZQMnlvamxzVGNKSmRYMGVmL05xdWtyZmx2R3VFejhldnNVQVFV?=
 =?utf-8?B?VFZ3a3lzSDd4dGNXdEI4QkcyUzJCYW42Y1BhUUp4Qk9Uc0dOcGRQNXJZeHE4?=
 =?utf-8?B?cUpMY2huSHAyMHhlbVpIRk02dTVBbWp2aFdCdlNvbk9UV2x4Wkt4TktDZkw3?=
 =?utf-8?B?Snh5ZnZ5ajVKOGlhUEpmaXpURTVRcm53dzdJK21yN25ML1FTdzZicytjdXRi?=
 =?utf-8?B?YURvSXAxWk83N3BoeEdtRkl6UXJYeXVna3lycDZnV3E3WEVNRis5TnIybUtW?=
 =?utf-8?B?MDhWS3QwNStsQlRxaVlWRWZtNlVPOEU1djFYeTg3Y2hDRDFFOXlGazNjUWxs?=
 =?utf-8?B?V0lJR0Jmb0RpMEpNQk82UHo0cTNBSjB3SUw1bG9xWkJybHdBWlhZNWhmUy9p?=
 =?utf-8?B?eEJldW1DS0JZNFptVTRQRkNrbHE2VnROWXNESUd0Y1d2SlRld3dzeGRvaVZM?=
 =?utf-8?B?a2paREpmYlJwTmxSV2N1VEtvcGNUTHh2ZUZnbC84cWNhZVNZc3BxdGFkUElC?=
 =?utf-8?B?SDZpN0p1UlNxYzY1OUVid2J6Z01uMVdYdmQ3aU1PVGNMeUhLT3ZHWk53YkxY?=
 =?utf-8?B?Y0c5d1VzTnRKeHRGYlFWUzE2K3BOb2NRQThvR3JtSHNzcHFZZkFIQzYxdXJ3?=
 =?utf-8?Q?Vf8UU6M2TsoqBhEA=3D?=
X-Exchange-RoutingPolicyChecked: tEP+pTcfErr2i24sFvRlK56knR/S7AgWcAlaMr7gvzdBxNEfqumbuQvdH9WZfOEm+qPzCXGxm3fVKSSjym76P8hOZhGURKeacr1jA+VnaEaQl8p2MnwY+zY8PIN+mUrqjBYKQFOONIAyhm/oJGOU3ruz3U0HbU7NqCOOZvYACui6qUIJ4cEbajo7G77BtFz/vSpWHK8yAhh116pIj7bXAx4TqJR3KIWYl9apx5tUf8rhSv6xhSym2tGTMQhLdaqR4N1qmnDM0p02rEw0layjDgqT3rbGnW4aQrOP8KMy3wGYuOhBKyy/zzyx4mV9fmj5WctEXBpcUmKaIken2oUHrw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a96ceb-7d41-4c34-bfa2-08def959d4c0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:42:15.0847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLHn/iEDNmUGeDOQxFO9bIommrpTS0ohsfj2L1PDZuK8pg8n2Pueqra+TOxaQxxg4cccBzEyLi4tmS9AWQaj+xkPDT9rV1mv4QHx5LWM6cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEyMCBTYWx0ZWRfXx+hlKRn22Di0
 xvW6+Gph2GtJPdJOwgfSlP6owSQ/9+1gPgB9iRvlKe/ztoFrCMOPi4m4AdhSZ6Ls73bcEUeNBa8
 led+voYjQ2tshxYl9aclTdmh0kvC5zfV32qyW2baX7XuQF+6T9qAzF77y2YoXGqNYwSypWJE77M
 KAzwUKJEbBhYYu4krf0a+fVOKnqdvtnOEeI9WEogU21dsPBAPwhRD1+WjGeE6U/oJXG2N31TdfQ
 FciW0YwGEm8vnhLvaFywAVIo/IcrXaWiU93MQYwwp6fP6tjB4WS/sr6+zA2SVXI7oZpCmqdPhpm
 JPu1RNrIaXkBdgY+5ybaDpWq4MJAuaP6b7scPIiXoyHTQi3EhtCPHbk+7fmLmjeAs6NH/0qPyzV
 VriQwrwuWogLa6/DjFFUW4FP5ht/DKwMlJ4wP/0ohH0TWwB/U9cAlSvpEUDEvSSMlV6/XX+RlED
 DgNcT9VL+HKZZu6wVyQ==
X-Authority-Analysis: v=2.4 cv=A/1c+aWG c=1 sm=1 tr=0 ts=6a7df3e8 cx=c_pps
 a=LTO8sOO1GI8jlEj1snnPtQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=yXaJjgPDKeVZs5nOfP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEyMCBTYWx0ZWRfX0rMpSzDozOiM
 fOAWhg8v6fhLvQr9BGeccB3idW4k4ySUbzu9Y1J6LkSJeizDJMmZhnLhZP5xxcI7t8WylQ0OBr0
 70X4zPE10B+L2thNZnYkIzFkDTywC9c=
X-Proofpoint-ORIG-GUID: WWk-ZJKMwm8FJNo9KleQWM5YSTRiJdSy
X-Proofpoint-GUID: WWk-ZJKMwm8FJNo9KleQWM5YSTRiJdSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On 13/08/2026 11:38, Daniel P. Berrangé wrote:

> On Fri, Jul 17, 2026 at 02:51:40PM +0100, Mark Cave-Ayland wrote:
>> Based upon feedback from my existing efforts to start converting from object
>> properties to class properties, here is an initial preparation series which
>> I hope can be applied soon after 11.1 is released.
> 
> IMHO this version is suitable for merge and could be include as part of a
> general tree-wide PULL that does a broader set of class property conversions,
> unless Paolo really wants to queue it in a dedicated QOM series.
Thanks Daniel. In theory I could send a PR for this, however I'm unsure 
as to how to handle that my current signed GPG key is for a different 
email address from my work email address which is where the series 
originated.

Does anyone in a similar situation have an idea as to how best to handle 
this?


ATB,

Mark.


