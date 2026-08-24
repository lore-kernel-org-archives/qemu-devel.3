Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0BC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUw9-0008Ox-OV; Mon, 24 Aug 2026 09:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyUvz-0008NO-LC; Mon, 24 Aug 2026 09:41:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyUvw-0004fI-5l; Mon, 24 Aug 2026 09:41:55 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD16lF2838219; Mon, 24 Aug 2026 06:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IzNc36vkSs+COq+EGzCkWDOqLWQ+ot1qC1VrN8q5q
 LQ=; b=vpf0Hi5ciV52366KSvY5hWnPXHiRQLGgZniEQqRMy+MIZhWDaqpcod7z9
 2L7IycaoiSd+OAaJqS8wT64ezrO1xNNwPYYQ4gATx9rz5Z9N/3qcANpBYbaA9Sto
 FlLeLrjSzTlX56TvbwOj4djcry5Gy0O+vqxd/qFjgbQtDidMveMHudrzZmzbk/ex
 2qwIxRYZLu5/SsgjzQvSoyPBbdQX1q5ENtJvOT8VGugzIBC+eTp7IUE0wCR+wr8h
 ubya3A2e/iYyTAHIN5k18HNFrVciGKYgs7bWMiS7hruo4K5htwayWsirB+GE9Um2
 Up9MynfBcYpedK/iZZiNicwDjJl0g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020139.outbound.protection.outlook.com [52.101.61.139])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qujpp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 06:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjwZRUtSLHkWO4XOERfaFIdmGs5YhjFqgjQavMwEs3qnZIyvmYNwKNetIhTMQ7micZrE8XwTfcveEZUbpFk7BWKK2fwYYczVG8zJCaqnLQvfGYXixLciAJ0NTrskyGseK+Ns/ta01XfQ8qnMF1Du7WPO0mCDplimcZb09gLDOdTkuW4hqJHDQVP3xmZAykF+z8WG4uv4bZIbEY4w7JYxADccpA8Z/2dzlT7p6cu6V4gXN7LvpGxGolm2Bd676H3UZuoqYEsNQhM6vD8VGIA57uxtiH1mQ081rU8jAIt4vVERBR9NPQYNgSSchUdJ/2aj5pG8RyCetaexMJjn6KVO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzNc36vkSs+COq+EGzCkWDOqLWQ+ot1qC1VrN8q5qLQ=;
 b=P69qLjdftIZ3SY0sPPiwhO4OXbwcyGQuknlHhgF+sgEkQbEW7l/HF6srS6CHYl9ZypAKYi/Kwpram6j8JjUOfXkLwHuYXIQiJvRYy52oEOyr6sqw9uyacbhSWz6WolbWZLryBFABQu/RosALlIc+pwelqkR/ALVvXoFO/Au8TicU2GPyoneaRHtwbomlc28nI0n88iw8yN4rBAhKQP3ndyRRDhM1E7UDWBHGAzUVgghK5nt949dbCOiPyOtBhb/mgFqbWQjGzQsICzS3+D+1st+8tAa9tVEdAypSnzxNctACZ1jJxHTZJc6FV6ScBGm25c+0ql2LqajJc52HRebUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzNc36vkSs+COq+EGzCkWDOqLWQ+ot1qC1VrN8q5qLQ=;
 b=KsTNWPtrHBocv0+eN1Qm9WL/Gcos0jffML2oVt43dliJ40X0tnUZBRHl7KqryypojSYK13zXucI2oHBE8l9MjjLJEICef5xE97NrG9GuRt9EwKae7y5LYoqC2iiallDJU/wkF1YemWy1n7l0pCHQdkXWEi6Wr09JRqk9inbNpA6L1wbELskmRGs0ijtNlpvs55BIFZy77YAmG9r9byy4PhdnOZWfSWExULQUmdFofjMpixn/YZA/pcoDL7Jxf41FHSEbQpB6qIPm5KY/+GK9jqBEfqZqwE/R3DAj5aGr2yZhlN56ILepOKkNQEi7pKqHU4G/0a8L6LJcP70w/E5clQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9470.namprd02.prod.outlook.com (2603:10b6:930:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:41:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:41:33 +0000
Message-ID: <0a56722b-9924-41c0-b9e5-906d5418a173@nutanix.com>
Date: Mon, 24 Aug 2026 14:41:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/16] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-12-mark.caveayland@nutanix.com>
 <aoxASVcLT03dVwCj@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aoxASVcLT03dVwCj@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a45c87-4539-49fe-1f3a-08df01e56908
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RUV6kKd0jN4l0/2FxTF4ZTAJkB/MEgPNb4/JMONArW7ArhGC5eczYzgPqVPjKcIGVCtHj6YcxlMt7/g0hsJMTb9lphGOoQCG3C0yzOOg6gpL4rL3ti4a1dCahfk7mNbho0+sm0UNvWgVsSad0q/t1nuCPKlGDAkpGcDzkwmoaU/vnewUkRrJhxy8Ip7LdKdJf+dLikuq4+3G6tjZumJqADsSKoG6w2CP1pAS/m/7UHgYQVDMybJPIIgWOzNPPfxQqhm4zuR5+5d9HQ+SBlS5Jy49+R9jmsNg7imF1YEMAXAu2a820IlSEGyZE+G3APqbF5ayYM5GzBbKceRCAbhYyW0le6AdoF0/aselYyS6qgboqWvpVqVczkluh1+dGLscEktl1So2mYmJS/oZ6GPm5E0xmjA5ZhZZuooJ8+FMkCqCY+q343K+ecIBH3tAON0BkWhHoy2ho3Y5PetWmyQodEOCJ3QnxYjan4R3YMi6B0pEK0UJWKILmIhHpgorhvgrmHXlAnFgIFMI/zkUJTYIs+prXDfU6lieVUzmiz4FRSfYk8fhn/RyZ2GRMhEaTEEJz3dFjfOYei1MFYcKBcWvDn7QNd2S02ZvAbJOf3h+fmBW6ajkyTDyjyAgOoU9852L/7TjKATrfLa92TFOfla/BIeajb4ZAWxQEA2imLqKZuY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzVveENWaTlMV1N1T2dieElPNDNiRjM4UmpURkU3Zi83d201UENDKy9wVVNO?=
 =?utf-8?B?VTVYYWc4S2lqUjJIZGF6VWo3ZThTaXJYSnJrWkVXb1FEM1hWU3BOUWIzYm5Q?=
 =?utf-8?B?em85a1hUYlY1Ym53cWZqNEdKWWxWZGhWcWp2RWtuRHlRRlpYWEs1RWQ2Z1Nv?=
 =?utf-8?B?RHkvNzRMZUU4cytMTDk5cks4Y3lGSC9nZ0VGcjhQR2UyVU02aU5sRVdGZUw1?=
 =?utf-8?B?VGhxY1o2bFl6TjdKQmhZdFVFQlkrWXByRUlxOGpZMFBaanA0cGpKeE04YXV4?=
 =?utf-8?B?Rmlxa0dzTjJvM1FGVXlsRjkwZ1F3WmFBbXYybkl0WitXRkVoVHZZSm8weDVv?=
 =?utf-8?B?YTlMbi9WV1Bud3hvcXJPNTNhZDI2QmhkTWVaTDVPc1NVWTFJMUNTb0RuS29H?=
 =?utf-8?B?VjBiTDZGcnR0U1NIMGIrbTIvV1BacnJ3YTQ2WkpFc05PT2FMaGR1S0x6bG1M?=
 =?utf-8?B?K3FaQlZUOUgzdTcvMlpJeXl0RDhadnRkVHV3K3ZONHQ5QW9nWnBtLzBjbDJU?=
 =?utf-8?B?c2JkK2tlcFVTaXRZZmFhUWJkQXVJQlI0U3VNT3lIZ2NHN2pNWVdRWGtZa3hn?=
 =?utf-8?B?NmFNb1BvaGk2NUliOWN0WG1odlVzNUdZTUJkeFNYbDg1ZmVoQUR3Y0YrMEFl?=
 =?utf-8?B?R1I4czBWYkdyZmZNVXpvY254ekxkVFd0MVZRNlJHZzkvK0VnaS9HMXc0YXJT?=
 =?utf-8?B?SC9MODAzWjV0UnZrcHBnVVdmRVlmS2hlNzNHRTJrcmxMRnhsaWNPRGxOVWZP?=
 =?utf-8?B?VFhIZXVNUWtweDk5YVptY2M2SERGZVE5MUxmZ3lyNmNMM3lOVzBod0VIM29P?=
 =?utf-8?B?Y1NvZktuM0g1MHovUFk5enFvZmllRjFZZmp0dnFaU2lScElnQ0lTSGZPV2ps?=
 =?utf-8?B?ZDVWREpXa0doUGxXblkwVzhacFRJZk95VDJoYm53Y3VodXlBeFlMWXliRDda?=
 =?utf-8?B?UFBBUE94ZXJ1QlBUMUNGYWY1a2pFazVWbXE2bVUzbU4zTXVUYzhjczErVXdB?=
 =?utf-8?B?QTVHbzIybzBtYnkzVERXQzYrRitET2V4bUpDRTJmcjh3ZGkwRVBSQUxWTVEz?=
 =?utf-8?B?QUZIV2pPVDlLTENrQUNPWjZwL3pkQXc4a1FwSXIxR3NaNHY2UjhvTGRlYVJy?=
 =?utf-8?B?blhoYmM2RnZVTlBLWGxOOVpMZDFnNW5tKzlsMkxaQ2xGSmowWHlZSmlCeWxT?=
 =?utf-8?B?VkMrSGdUUnRYK2dIWWlSQkw5b2pyZVozRHN3THhaTXBhcXdhOTJWNHcwK0FD?=
 =?utf-8?B?TExWbC8zMlg3VXZOaENwc1FBVHVTUGR1dXpSR0tTaTlwUUExak0vcGRJR1E3?=
 =?utf-8?B?czF6SE53cENLNTV5bW1OLytMUS8yRnYzQlF1aUJBekMxMzRZVlNoMUthZ093?=
 =?utf-8?B?cmRmaVJJYjR1cEU1clRNczQ3SDA0OHBVMGhNbnEwWWhHUS9Ub3NuMGJMbU9r?=
 =?utf-8?B?SlZyT0gzTkdGTk5CdWd3NCtVQkYzK1gvYWtDdzJVKzhLM0xKQVM2cVJpN3Bm?=
 =?utf-8?B?K3BCcml0REd0TWtIRytUSy84bGVMbmJoWHpvaTN3OVFsWVNsc2pDZ0ZVK3ht?=
 =?utf-8?B?U2Z6Q0VYMDM2WUMydUc1ei9WNnJrMDV4OEd5dVQyODZOVWxQRHZ6VkF3ZVdZ?=
 =?utf-8?B?bWdHKytoYmZrRU9xbFl6TW9uM2xwS0M1TzltbTdIM2pHQXBJWk05N3IvVHQ0?=
 =?utf-8?B?R0V6VUkvdURSRkVpam5zZEJYS2dQd1FtYnFrY3pDZUQ0K1VCQVd0Y1p4b2VN?=
 =?utf-8?B?NFVOWExvVFp1RUxQNGpjdUdEam5DUTJxVlV2M1M1RnF3aDduNlB1Ti95bzZ4?=
 =?utf-8?B?by9jelhCNE5YZ2lObGkxK2c2SG9QNVZ3RHAzRTJkcERZWms1NkJIdjBmcklZ?=
 =?utf-8?B?aWVsTy9hNlJVVVNKL1BTS3l1OWFGS2EvSnJVSDcyU0JBbHdGeU9LMTBuR3RZ?=
 =?utf-8?B?SktMTVN2bk5DUUhKc1VJUUdhZUxnc1AydWlQa3k4ZlNXTTVOSUdZQjN5TTVJ?=
 =?utf-8?B?ek5UUzFHcEFyNVFEaXhaMWVONVExVkxiOUVOZnZibUkvYUdZcm1LZCtXVjRH?=
 =?utf-8?B?S1JwWkRDQVplSnVWY0lyMDVCM0MycHh1NHcvWURWRUNORUxxcXRjdUpPaXBh?=
 =?utf-8?B?SzM2NWVvRjhEaGUvZ2VYMlRmWE82RURjYkpDbGVpd1l3Mk9YM1R6bDRsYVZU?=
 =?utf-8?B?RExadys3QVhscEhjblpxUWt4bXprNUJDaElUc2lRYWp3UTZVcHFsWWdQclFU?=
 =?utf-8?B?d2hONy80ZXA4OExTNGtDTDJjVWlsZGMyL29BcDdaYlpSVGtNWC9sbHVtWHhW?=
 =?utf-8?B?RVZQcVMzNDRtMTdSeW5PaGk4OFN1M0JIc3dKbHhNWWY4TkNWZUtXV29IdFNH?=
 =?utf-8?Q?wzfbbXCQI7GcisIQ=3D?=
X-Exchange-RoutingPolicyChecked: TiLng4cMqCp+O1dAsUqa4lWsrAQmAiWI6AnT0gLDcTk++zUeKX9+FvAZvPCyHRkAMBz6mzeHOkqCsUHzAsocNJacIlV6gg8kWczmIEQ9BuwRFpXTcGTvn6/IX3k6rz2t0cLza6ZyNYtvt4RlMMIwueJGmVMIYWjPrggobBizyumLeWSshV3fLZAmEHAxk4mvNayrebV6yrBZvSvA7ruswl8XiF1SClRyA3gTGtza7sWFNOgRCgEbe1R4fphClEg2LB/w0MMDLrgRraHGxGQZBhkLBPlkj/wcqv/4Rdl+knrnY2NMYotfYFT/5tK6Vncja6JzgscmmBjNTBcklQ2bLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a45c87-4539-49fe-1f3a-08df01e56908
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:41:33.2002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TftR1Fc/0a+Kp65POSzeh//j0m8LbvL09ySrWPhbmIVZ8D1EO9lvSfsEEr+mX7MVUYaBgjc5Fgcc7+DqPgp91WRsG6G2zVYttLXm8bknAVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9470
X-Proofpoint-GUID: HYOSSARMRIDGhtwfO4NO-OGRPzcpNiBN
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8c4a10 cx=c_pps
 a=zLxRk7/rSTrB1jskNZbxBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=o1Kt3cK5Jht2aF_rcFIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX+PVjbOqb/8a0
 sl+LbBU3EoPUZ8dbVSz/P+lD9VWUaW2rsQaNxqK1p6HVXyXrOnsIGOxgRufwXjnsLhI24Lo2MkE
 QevNkGPcUbGw8ZR6rowRyy71wTk6M+s=
X-Proofpoint-ORIG-GUID: HYOSSARMRIDGhtwfO4NO-OGRPzcpNiBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX/u//MzKdn71W
 w287jqT2O+ce+GwItBIo4Nsmd13SU4boV+/D3DsRhusbLpa99SIwPzrduAMYvI+V5PN3AhAm9Ep
 14GWqGlTrvTNhTvtU6oe8fplrNCoN6t1Wp6IJpvXsCekBjIF6AY0eE+AoAJkjwaSnJaoIcyKAao
 IoGQ/SM625Bq/43uNUxOsCMdO96rvzIMiUInOPCBZb8grExTfIKiHYyuVjOpXBHFUUWVfZH1Hme
 6xU7s4R+mHH9z/S6FfBpie/htZHIKDm4nvKwjlz8NgilTizuMinvqJ70DycDtPQQJEjJpjcGfLH
 tz8KhCqWJ+vDK++Ih+nQo1gz9lNzNKrhWLbcBVAfgDnikC04bRpzIZzO8tss3bjLue0h0gRSnPg
 SDXM3dmiQncTzWA4M1gH7rLy1lrpTX26M6R761nvyA9LS6lC8kVA7FQUjFFh/89Q1CvXTPHewiF
 /Y/TNzQeTgSiXgYhluQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
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

On 24/08/2026 13:59, Daniel P. Berrangé wrote:

> On Fri, Aug 21, 2026 at 12:14:23PM +0100, Mark Cave-Ayland wrote:
>> ACPI_PM_PROP_TCO_ENABLED, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE and x-keep-pci-slot-hpc
>> properties can be converted to use object_class_property_add_bool_ptr(). Remove
>> the now unused ich9_pm_add_properties() function.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/hw/acpi/ich9.h |   3 +-
>>   hw/acpi/ich9.c         | 111 ++++++++++++++++-------------------------
>>   hw/isa/lpc_ich9.c      |   3 +-
>>   3 files changed, 44 insertions(+), 73 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> but...
> 
> 
>> @@ -436,6 +368,47 @@ void ich9_pm_add_class_properties(ObjectClass *oc)
>>                                                   ACPI_PM_PROP_GPE0_BLK_LEN,
>>                                                   &gpe0_len,
>>                                                   OBJ_PROP_FLAG_READ);
> ...it'd read nicer with
> 
>    #define REG_FIELD(n) \
>      (pm_offset + offsetof(ICH9LPCPMRegs, n))

I don't feel strongly about it either way, but I'll try implementing it 
using a PM_REG_FIELD() macro as suggested above (I'm worried that 
REG_FIELD() is a generic enough name that it may end up clashing with 
something internally).
>> +    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
>> +                                         pm_offset +
>> +                                         offsetof(ICH9LPCPMRegs,
>> +                                                  pm_io_base),
>> +                                         OBJ_PROP_FLAG_READ);
> 
> 
> ....
> 
>      object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
>                                           REG_FIELD(pm_io_base),
>                                           OBJ_PROP_FLAG_READ);
> 
> ...
> 
>> +    object_class_property_add_link(oc, "bus",
>> +                                   TYPE_PCI_BUS,
>> +                                   pm_offset +
>> +                                   offsetof(ICH9LPCPMRegs,
>> +                                            acpi_pci_hotplug.root),
>> +                                   object_property_allow_set_link,
>> +                                   OBJ_PROP_LINK_STRONG);
>> +    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
>> +                              ich9_pm_get_gpe0_blk,
>> +                              NULL, NULL, NULL);
>> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
>> +                                        pm_offset +
>> +                                        offsetof(ICH9LPCPMRegs, disable_s3),
>> +                                        OBJ_PROP_FLAG_READWRITE);
>> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
>> +                                        pm_offset +
>> +                                        offsetof(ICH9LPCPMRegs, disable_s4),
>> +                                        OBJ_PROP_FLAG_READWRITE);
>> +    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
>> +                                        pm_offset +
>> +                                        offsetof(ICH9LPCPMRegs, s4_val),
>> +                                        OBJ_PROP_FLAG_READWRITE);
>> +    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_TCO_ENABLED,
>> +                                       pm_offset +
>> +                                       offsetof(ICH9LPCPMRegs, enable_tco),
>> +                                       OBJ_PROP_FLAG_READWRITE);
>> +    object_class_property_add_bool_ptr(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
>> +                               pm_offset +
>> +                               offsetof(ICH9LPCPMRegs,
>> +                                   acpi_pci_hotplug.use_acpi_hotplug_bridge),
>> +                               OBJ_PROP_FLAG_READWRITE);
>> +    object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
>> +                                       pm_offset +
>> +                                       offsetof(ICH9LPCPMRegs,
>> +                                                keep_pci_slot_hpc),
>> +                                       OBJ_PROP_FLAG_READWRITE);
> 
> ...
> 
>    #undef REG_FIELD
> 
>>   }
>>   
>>   void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>> index d3f1358887..b55b5136a3 100644
>> --- a/hw/isa/lpc_ich9.c
>> +++ b/hw/isa/lpc_ich9.c
>> @@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
>>                                IOAPIC_NUM_PINS);
>>   
>>       ich9_pm_reset_properties(&lpc->pm);
>> -    ich9_pm_add_properties(obj, &lpc->pm);
>>   }
>>   
>>   static void ich9_lpc_realize(PCIDevice *d, Error **errp)
>> @@ -920,7 +919,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
>>                                                  &acpi_disable_cmd,
>>                                                  OBJ_PROP_FLAG_READ);
>>   
>> -    ich9_pm_add_class_properties(klass);
>> +    ich9_pm_add_class_properties(klass, offsetof(ICH9LPCState, pm));
>>   }
>>   
>>   static const TypeInfo ich9_lpc_info = {
>> -- 
>> 2.43.0

ATB,

Mark.


