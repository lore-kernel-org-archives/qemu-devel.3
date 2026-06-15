Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04620CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7Nq-0006q1-NN; Mon, 15 Jun 2026 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZ7No-0006pN-Md; Mon, 15 Jun 2026 09:29:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZ7Nm-0006WD-Kj; Mon, 15 Jun 2026 09:29:44 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FCagLM3629213; Mon, 15 Jun 2026 06:29:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wsEA4l+QgM47YpDTykc8s97YxZP+S9fMdJb7GU0B1
 UQ=; b=dROMtFz4YFVT9NQLkkhhZHK2f+Cnbjh4NrHI1SG+ng397w7QJBKABLwR3
 xhi7EzCu+WHas/czKPukjZ5v8lIv5DeE4y0E1jQtDF5nJuHDGeV7vsGx8T50TA+/
 X0faT95ovT5JHrRfmHgaWoNYGqRbwnp9CASLrEsv7Mb7xL0JM3dXyRSrUGJq3XXB
 HDDQdYl8QKBVpoNsmASh3M0POoVygMvtxZxCjRbu1JX90+pFBcR2ElEI4bbbvCL0
 rGwdpe/E1vJLr+Ym2G7+y3K8MWK3pm8wuSNjd9x2zRSgRm39x864gIB4sr/71GE4
 eoL7HSVW+sKtvjAFpkv7+t5/Y1R5Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023122.outbound.protection.outlook.com
 [40.107.201.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4es6qxbu0g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 06:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TggMkrz4DMWvzcnV9B38uMrZ4lZMQmRmcWkR1ou1iA3tuES/WjPPqQiJINbmfx/ud2vjcAsxnqvXa6INSqYLSUKLb6Y58f+ziiUXNuLUQnAmmYEK7x/64FQGrfEc7GSTL+xRdOnf+9MXsGpjnNzP5ksZ3O63OYTheIXwHnz1HPzJBSqSZmn8sH2Oeoc2WtssvbAcnf8GQWYeo0oO0ecDKrMC9LcCrmi+x68LbEbD278RkqGnHFwpDQ3p8HFLcmge9Ia1rcQLgycyR/JPfbwja0L6f/S2OeQyZGSCgAMql2kP1KADUk03jbGIiyP7HBxMeJmJD6fwG+IP64aLgQC//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsEA4l+QgM47YpDTykc8s97YxZP+S9fMdJb7GU0B1UQ=;
 b=BKFCQCO6CggTMkebtTB8TqGQ8gKQhV38AZ3DFuyc/Nvc6hdF5YU3I/l8SokDzU7PY/T9RB668XyP2RvBr/g2XZ+q/jdzboNjNTqT4/upQce9INEYqL4V4c6C1enQf/vC0EmVo1IvxfvASCEFF2h7bGAEcv5But+LnxiUQuGGGyQuWMyX2xbR8fZPzsOa4PZCRpkDc/NmuQz1Y9IFYYSPi6k8Mfie4ehf1w4PJq61rK50kvVoth6jn7UAVsOQc0rLfF1uD27EX57rdAUSNlkRbxgOEP2m0NDbcBeTsuCgURdaX0muM+CgDN7ZzelYiAYFXn5o5rKo1r1rvSBsP3I+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsEA4l+QgM47YpDTykc8s97YxZP+S9fMdJb7GU0B1UQ=;
 b=JyUwqVq47JTRL0yIQPIL4So80+A1AvgqTRHt1M24FtQyYf73Uic3wTPuGCbPjTgXHETRC0yR23IGixMRrQCgBTl1pCb1427PL8DVJ634uQDO0sVF/HFRmjv1fSpZ/rnS9VMpoHkeXo0XTFVH19f+4iiOE2NL3xdwUoH/3pxEuT2+ueNwUOzH6odyUYXwDQPAxKvYZ8pQL07/rNILwGdsmndOzRFGuAQwwnU9PopPMp8E9yPP6aLx59OupqpEPQX7SV/0HPdzSqMOKMbJZR229/9TVWRybEwTplua5sqh5BZHw910uZNcQ4WBXhiOmZoEI4qf5rjFPQ/Hw+IZ071lbw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6704.namprd02.prod.outlook.com (2603:10b6:208:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Mon, 15 Jun
 2026 13:29:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:29:27 +0000
Message-ID: <bd504e97-ae62-4a09-9c9a-cd7d0c86d88d@nutanix.com>
Date: Mon, 15 Jun 2026 14:29:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ai-z14dMCK33_pis@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:930:a0::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 518e03a7-94b3-4ac4-3f9d-08decae21f8e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VmZ77c8FNw8K15ei+Jxa1oi+qZQ2hpv5RA0L2ki3l7lIiExTzHp1KKPUa3xvxblyRHuP5xs8zedijtcKy2dCRUjsz60STcpg5QkLqqUAABl1w9Iav1M5ZBIRyiU7ODmOHaIqf3wX7QbSUXUgQBSpVFZQrTia4aiWRxi9xN9fIM5PoIyfZjUk/sX7cuPSTSefVShREhBo+AcHcoccf0hAe0AE/oT7iRfd29fRtQ2pPYcyzVvCztc+Nw2eiRuWjT1iOo0bplSnSZm4pTBYBotUcKiaGKbFzi4dkoAiGocyC6elqPfL6NLlVrSiqEYma6eb0mn4bci881nGBWuKlQYbJkQZeZv6RpidWMXOd4KB4hiZFMUlAau0S1TXXi4K/xEW7QuErWLplUf9apG2sikPmNZpEyYAp6wWDXThVyt5OMpCglIGpO7kaig5nwt9A/AdpxsRsiuOFcJnL/bQgKU5bYHtV/7ZzUnti3j8PQrMphu0rbnUlwRj3edlEnN3lx6cMBOEOMFwnLf+gdo8WrX+2jXa4nXOk0rpFwTs1r0HjOSg0Iid1TtjsNrlJ/rAN/4gFrR7SgExGJAeLry1s+kgi9eJoecW9pp0XwDAzXBKdpd/rd78CaIhaCTF+KDV0K38V90+PS5A1wB/m/XolEGY+AcGqWnBEO39CjZ4bRkK19Xl6e8tFoLIBmTltq0lHAmj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRqVndUUDRIUVArUEpML1NvcmdNTE5nTDh0OGFTTGhKQWc3S2FTYU5nY1Fp?=
 =?utf-8?B?SHJCdWRGaW5tWklSUGxQY25pTS9IZXdwQ1R3a0N3L2x3Tk1GWHZoS01MSEov?=
 =?utf-8?B?bGtqaUhPS1lobnlFUzZLMkZFV0tQaFI5bWFvVTE0dU43dFlQVHNqdy9oYWxw?=
 =?utf-8?B?QjFxbU84ZEJJclV5SnNiV1ZoMENsQ2RtY1RHVWVFbHpROEdldjFxNmpZY2tl?=
 =?utf-8?B?T1NpVVMxd1ViTG94VVJCR2F3THhTb3hCMXBZYVFZNVk2UmVJRTVmOWJEZDgz?=
 =?utf-8?B?RjhBRG9EMThLY0NqaG10WjRjbXpaN1Z4QlVrOXlpYTIzbjhVZWVxejRDY0RC?=
 =?utf-8?B?c2xYQkRQRFAvMlA1YkdLOXBYSldpOUdKR2J6aVpBNGJ3M3NUdHdjKy9LTEVN?=
 =?utf-8?B?dkxlZ0FSUm42THV2Q0JBMlVuZXJvVkZjVDdMNnFOb0hWZ091Sk9BeExYdVhM?=
 =?utf-8?B?THNCNUpMaTM2c09qMEtpKzl5TklPazc5MG9MMUZzZWdQSlFIVUthWXphY0xl?=
 =?utf-8?B?eXljYnUxZWtwTmJyc21ZYStjM3p2M0VJOXY0UFZBdFJQNFdSNFRJcEZCVjVB?=
 =?utf-8?B?UmRvWit4SlUwRlU2Z3VvOHZYUmNBUmZjaFhTOG5FYktZdFI0VXJ6dGdVVU9X?=
 =?utf-8?B?T2N3K1FOaHZXdVBnaUR3SW1YKzFXNzBvcktsams1Y1JzQ1kwdVBJWXNGbTZX?=
 =?utf-8?B?bjVxVGlmMjFpaG5tTWJ2WDYrMkZTbFBUVjZYbzBaY0VtLytwWEV3TVZBOHdQ?=
 =?utf-8?B?YzYzWXMwVHM4a2dUZ2FCRXNTQ1p0aW9wY083S1Z0S1VhR0FVaHdvd3pwMHUr?=
 =?utf-8?B?QTJLWkRZSE5wSndhTG8xTklydzA3RS9YNkx2ZDdiVnFvMEc3NVhDVkJCQ2h6?=
 =?utf-8?B?dzMxV1BBZjRJbXR3Zm54SExNenBSTG1KOFoyK1BUcjdiWUVmcUdwU3BneXF6?=
 =?utf-8?B?T0I3ZjJyRDZPRGFWbFMwSDJmZHAvaVBwcWJuU1N0ZmlyVksySGNVQ3d0WkJY?=
 =?utf-8?B?SjN4dnBQM1I1RlhyTkE5VzNsM24xWHlyWHdsbndGdHBiakVNRUhHOUVuRjQv?=
 =?utf-8?B?TU1iRmk4TkJ2REd1dEEzbzV4b05vSjVreEpKZ0JrWWE2ZWdua2VDZHBqWi9n?=
 =?utf-8?B?NmNHaVlNV0l3UmNRWTUxWG1PKzlmVFZ4QjlHWUQyOVZyTldOVU5xVWZLZlY5?=
 =?utf-8?B?T2tMU3M2MllsSVFWM2FacFlYc2dpb3FySmFNWUxwNUFjT1F0MGk0SVg5aVF2?=
 =?utf-8?B?MTZ2RlA2YjZSSnhKTEJJOG1POTdRNllLblZNVzFmUy9LWUJuNGtRODFzaU15?=
 =?utf-8?B?SnM1VldONWlVZG9nYmVuaHQ1RSt2YzJiZFFsUDBvbWU3TVdCUmNyZjdBdDNC?=
 =?utf-8?B?UFhnNThMaXE2dUNzalMzR0Z1LzBuVlRiaWxGZlQ4OG9JdzZ5UThYQmRoeG8z?=
 =?utf-8?B?My9CQ2pDQnNhamhBZzRWZkZ1OEJlbjd0eDl2YnBsWHM2Mzg0K0g4ZjI5RVE0?=
 =?utf-8?B?T0tSUjNaTjZJSXdJS1kyZDVmdkVTTnNaTUN3MkEwakNReURva1JjQ25KRzgv?=
 =?utf-8?B?UmVPQU9RM21DcVlJckw1SGhFNG1nd2JXL3ZIcUNMNUMvT004Ny8yWkIzMWgr?=
 =?utf-8?B?b3FuT3FiZWtxeHZhaTgwQVBvR1RvaUF3eGdjV0V4L3M0UnZRMlFkWFdYQlMx?=
 =?utf-8?B?UjFRSHpYeWVML2x0WE83MzVPaXhhN0RhZ1ZPVTVLMWJpd0hWd01pSjkvMmg4?=
 =?utf-8?B?MGFrMyt0RXpDTGNVUUYxdlRsaGd0eklVOXh6R0xVZTV6aHBVMjlCZzcrK0t6?=
 =?utf-8?B?TEdZbFArVHRnbm5lZmlSSUpadS96MTR6UEtVbDFSYnBLcnMyRlVSU0IxMTc2?=
 =?utf-8?B?TFBKUWNmd0prSFg0bXNtS2NUSWRVWkFnTERlUFNkUWVwd3NzMXVmbnVPc3ZR?=
 =?utf-8?B?Myt4dUZmaXNwa3loR1ZhcGVaakx4VDdJeXFnQndJY0NvZ0E3YWYzdXladTRm?=
 =?utf-8?B?S0g3aVgzUnNxa1J6dWM3elJ2NWNZRWlUNDdpU2VBdzZYQWhzRUxGajA2NjU4?=
 =?utf-8?B?WHoxZVZ4OFJFZnlNS2taUEtKUmFpY01PbW8wdnBLMEtRQ0h0bkVsTnh5Qnpk?=
 =?utf-8?B?L0trNmpEWGltTW1qcUQ0Mk1jOGpNMmVja3RWbjlGS2JTZFo0ZThSKzJXc1Bp?=
 =?utf-8?B?Qk90UUNyMEc4N3k4dW9pZitKNTk2M0RPN0FrWU44U0VLeklSQnFMSmRkUmpx?=
 =?utf-8?B?MzRZeUJkb080anVRZndsN1BHUmxMR1BLWlptM0hyemdTSVo3ODVkQ0kvWGJu?=
 =?utf-8?B?TkRtMW40am9PRURKcCs5SUU4Y1NTcmRmdE1lMldCZHRGL3lIbVlzdWNha21o?=
 =?utf-8?Q?fJgHmePAe1RjVQSs=3D?=
X-Exchange-RoutingPolicyChecked: LQfa4JiNIXRRhEKguGU19qbfFww26kXgTGhEwuyLwAh98SoPWo/PfQbAQOkqgyU7eOJXDAgFdrHm1VLkZ8E1rCEKw2H5o9U774ReXX1UA9E7BuMLcMEQ/Rs7pPaAX5RbROL/aAtiCrFftmXF2DiBO+0MasHDRWH8i1nQAxtJYWOajRpA90iQYFanvSvJ0u/lJV506uK0rCJAyCcZqr1OXiaEnDX4aQXXGPRuPvpt5sTAh1iLMkcd0pK6AJM7Acl2bDdsQ/PYVaHQULuM7snsPB5ihNlDjfeFTFLbUcEfKEsKisY3qQ5dqwdiasAp2vn/W69STgNKwVeH7ZuWrGPwLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518e03a7-94b3-4ac4-3f9d-08decae21f8e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:29:27.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDW/7+MbVPMy1x4HuVqOxUJUpM4eTBb6ChljBnUo8N45wKRYOaE4G7Xvb4lKZTEKvc1ACwJuAhmj9BgHTNOrCh5c/JBfr/IUihc2si5SwKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6704
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE0MiBTYWx0ZWRfX6butL0TOyf1z
 yi6CroF+TiHGuq9ZWk0iSSm7+xiVGxROr4nQP2QzPq6iWTBb+esGtGjAwT+IMC8kx8IHK+3KPkx
 mUU8fIOLnwpkJleBXId4qW0A1nYtpks=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE0MiBTYWx0ZWRfX6zV1W8wJ11RS
 +p3bJQxrsNbb5HuiiPriwpwmtoEHvNMY1SCSZFgD6Fl4H3zOzwFNHVX/7rDUueVLA3VRdkMi9hN
 9u0uTSLjkbiHaD+3ADzoIN7B2ucJjBwEejeHwYFWr7B56jawir2ZUS5/9ZYhyYou0IjLU2uSJPM
 z+tRoCtFZNc8OZRsX59N7BxE6MaM/TM7mbIxhU+pgxW13vO4o+yG/Fg/RIyWpfRpfgXd7NmVX5p
 n6wsAC65EoI8E9AZWiKjz1jMc0vl8s4BGnNxFpP2ZlsX7vX2Qcg5tQMhE9Jvvd42Rn6j0H8IhDr
 9+7sLl7LPmIO6YR2nfnmdmxn4C/HdFDNPiR2hJyZXrzgcKSU5CwY5R3ODhrOYdKJC/m9sfz3GId
 HXkQi5cuh6fzq5LAQmY5EPUs6phzcv2etV49NElNvgy9848Zvyj9V9TN4wMWmKvyhVl5f5z6u/v
 Se3pmBpoCU15naTknbA==
X-Authority-Analysis: v=2.4 cv=HZYkiCE8 c=1 sm=1 tr=0 ts=6a2ffe39 cx=c_pps
 a=1IaZlVIhgsmdv03QAtF1KQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=2uj18sb9yCjxTXyHI4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qjHJA1tNOmf2szr6rjtKA03snWNa-hYf
X-Proofpoint-GUID: qjHJA1tNOmf2szr6rjtKA03snWNa-hYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 15/06/2026 09:12, Daniel P. Berrangé wrote:

> On Mon, Jun 15, 2026 at 01:11:07PM +0900, Akihiko Odaki wrote:
>> Problem
>> =======
>>
>> The Rust wrapper for object_ref() is marked unsafe and has:
>>> The object must not be embedded in another unless the outer
>>> object is guaranteed to have a longer lifetime.
>>
>> In other words, object_ref() does not work for embedded objects and
>> does not keep embedded objects alive. MemoryRegion has its own
>> memory_region_ref() helper to call object_ref() on its owner for this
>> reason.
>>
>> However, this is insufficient to avoid calling object_ref() for all
>> embedded objects. For example, consider an embedded Device that has a
>> MemoryRegion. When referencing a MemoryRegion for guest memory access,
>> QEMU automatically references the owning Device to keep the MemoryRegion
>> alive. However, that reference is ineffective if the Device itself is
>> embedded, because object_ref() does not keep the containing storage
>> alive.
> 
> Do we know how many examples we have of embedding objects inside
> another ?
> 
> I would much prefer if we forbid the embedding of objects. It is
> horrible design practice to have some QOM objects which can be
> freed via reference count and some which cannot.

This is something I've been discussing with a few other people for some 
time now: shouldn't we deprecate object_initialize_child() and use 
references for everything instead? Not only would this help solve a lot 
of lifecycle problems, but it would help reviewers because at the moment 
we have too many different ways of doing the same thing.


ATB,

Mark.


