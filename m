Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB385CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhfH-0005Kl-BK; Fri, 16 Oct 2026 09:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHhf7-0005EG-2K
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:07:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHhf1-0006NT-LA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:07:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAANRf2995849; Fri, 16 Oct 2026 06:07:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ToSK9fdOQ5eSLWIwKwp0xT3zxhUFu3DGIqcugMdrY
 7w=; b=zBcqxDHKgwPRAioZemhXaOMvoXOGvBj6QCs58e3Iy3p6iIKzAInXcZcWY
 P62voA4aVPVGkhmAN2SNplKmoD0a4wWAizGQaV7b7Xvf6yWvF/dAY7cUimazKSAR
 NIMAgvonn9pPYZ8kLjOVb8wgnhuu3inEFkaaK48tWIE87nlydXiIGHjC4nhAX4eC
 Tn9+TZqbfiBeE7sul1GVG6sUYPzVRCfcmhH7XEucUt6zP7RC8ARQ8NrQ0342L1S8
 reTyjuFttggTV0moKX2d4uUHMCJwI2Lo1arB1EFw92TNnS6EfWJoRLW8+0zMskVp
 G0meathtzowoYIBOMxKpwyEaGGHDA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020116.outbound.protection.outlook.com
 [40.93.198.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hbg268m0c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 06:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYLo6C5nQzD4aH8qMWkS0PaQfcMtx27JWvN8AUkgLHAjBmBRb0rJxjAJKLsX3mjAYU5X6nuhgJSJtFPhvP1HrTIng5j74zS6KDaLDAcz7oq1D7ah0ZPuWShM+5eybXSgEwWcQez+ed0yKW/BCT1mko7BpiAs2QZzxL+Jd2y6olqYRuWW+vmcjMe0fCnyk3SsandNvNARMyHJfWWSsw0hAMpwJwU8yVJ09d5I55mMyYs7PAFqFFMjntmvbBnAuHzdLuidkxCu5ln0hhP1dQzVtkWjCLE7X/otEaV9ma10uq9quspWA9gAFrFPuY56Xtst3pTbAncl25oWoi+ZmH+iYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToSK9fdOQ5eSLWIwKwp0xT3zxhUFu3DGIqcugMdrY7w=;
 b=grOQCJGjvl4M0cPrwtbWoFmIceowuKEaw9X2q1tUp3DfYIgScqxEpxxA9A94I5Wp2aSlqhEFFk7shV4nAJn0ugGUH5dqfpSO/kqADJLDdiHue8b6C1FT2cLekbkh12lCzJBkKcgNNeJrTBjBVuMtOq8yYI8dQNfprJOiffmOoxi2JE+74rur4cBABu+HU69A39YFa+La37PRk4x4X+2xYGviWLJ5uibQ6aIz6YvnvkeXoZIAreQRFREyRPT2pJjGA5zGPf5MWb2+/w8FaLSC3/Xx6SFKqbjOy8Y4CTkxCBlsLswElJp0ZqQzXMkTN1Ch5zQf1HCcFHRja+Uvqm7U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToSK9fdOQ5eSLWIwKwp0xT3zxhUFu3DGIqcugMdrY7w=;
 b=K27PoZL/9W5RlUGAOGk3TirXKJArmU6fsrdMlAB2HnEWgwjk0X0Rt+39CoQzTKJ94i4gWcN1O/YwAR3HJ5kc4JQPM5hDmY2Ube/1BPzHIe8cHbGScuXYJ0gvkEddALi4p7nERzN8gXIUIVE4q2bvBiuzk8W7ruppHpINgowztbE8tClx8cm5VpIv+eXo2VsmRqj5GKkxIMDV74Wc36L40IwlyO1VXDP0PWdT8vA4wSkpyk5d4SuobuSBnxuGHZDyLYkxrj2sQ2zo6saRb7iR1XG2Vw17CzcBAQe5V7TO/P4P+HlKPAw6bAIQizOybnUTWmuLlwehQqcqQ0dvm0JzJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10964.namprd02.prod.outlook.com (2603:10b6:8:258::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:07:39 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 13:07:39 +0000
Message-ID: <94665f6c-2f4b-46f2-a6d1-54c92cfe8470@nutanix.com>
Date: Fri, 16 Oct 2026 14:07:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com> <atHu0kCSQTD9E34p@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <atHu0kCSQTD9E34p@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed81dd2-07d3-4ef5-9628-08df2b86745f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 3D9+fCdLa5BPVQA3tLyQq171mSzuV7YDNauizeVb4aqALtgcnYkJEiY3gf6SkpcU8zXPzHVkaGsDSJTC9PRybfCiHcxHgyuVeohS37PDLgfOyy2TJitCC5AvB8dPfYFUVis6pjts3UqZdB4Uo/fi0B4artKsGv1jGk4p1jH12hGCcwUV4Df56ht05r+B7xa1E21T5Ysb7/yturNiUXTFkT36e75FIX8g9aU4jpX3HuMEot+t1vKUfU6jIjCHPlKB1VV5+BpmNZLJLmNZSdaZYzQ2HIFkX1uQZripG9zoHAl9vsw6Ab5XoG+Pp4+1vzbwvZChWrx8rAxXdkghOnuJjkSpfse82FTkKtw8CAqIkgBJUHHBxz5o9DERVMgqHU/PU9hh7yU/Y2mweTCedWSJ+g9n7nazUpw094fkG+yDxOM6Z4OGZHq8cicBPP4UuF0b82LAIgaW23v6s1Zd1zmDomGMi1k5AeMX+bVGeXBB3kERxbeWkQ9gEkzfOZmZ7vc905S9uEAmI5uvF7nMUKwVeaDYJR7VJ7EwQXsYgYyWq3YR0Y4GTFEzOVzgOeHipW7MCexmwhlvPKv3cBqOVw1zFtXLERmL+rnJ4f3HnzmYE4C4ylZByllyv6mhJvwsna8CCPV77Qrx8NX31GaMvQGM3HPunoPbKTtaZyUPpvXp4cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(5023799004)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBoam00eFIrelRzSURoWWxqVDNJcnJ4ejFQb0RDazBJdzdkMjk3KzVZeG9k?=
 =?utf-8?B?WDh4YWlObGxqN1BpanhITzVuQUN4bi96R3cxT0pFV1A1enpRclZVZXBSTGpW?=
 =?utf-8?B?Sm9ER29VWjZjUHdTdlBXQlZPN1Q3aGFiUEFDNlZDc2l4TUR5YnVQeW9haVJ0?=
 =?utf-8?B?RUs0SEc2ZHBoTUJHUmJGRVRxRGF1T3prL3VZckRmS1o4OFVObkJ2N3h6eDdD?=
 =?utf-8?B?dExDaVJwNkhvRUEwV0RUdGNoN0RkWjgxK01KbHZHZ0hrZlRQaFBhOHlqUndI?=
 =?utf-8?B?U2lLYmdrc1k0dGM1cTV6Q2ZJS3ZtRGU1aHZaRkh3N2dXNHY4ZmxoWVV5NFN3?=
 =?utf-8?B?V0VGbFV6OHBzdjhHT2FpN0kycXFsMS9EbW0rckc4aVJVdk8wYU9oYlAzZWZI?=
 =?utf-8?B?bjgvaGxGd0ZuclNhNG5rSWxkdDhYR3NrQ1hGOFc3ZTlXWDR4UE5UaEtFeWNZ?=
 =?utf-8?B?c1d0RXBRMWRXQXVFZ2szRUtzTFdMYUhWRktidDArWVRFZnBxWDVlcG1zeXlU?=
 =?utf-8?B?K3l4RUk5Y1V2azROMU1zMVdRQmtFQXBTUTR2SzRZK0lKMThrVjAzNUhoNXYv?=
 =?utf-8?B?UWZKck9LOGg4RzhZbVR0MGdQL1dOYjMxQUxaQ2dwYWJDLzNPYWlRVGRJZkJv?=
 =?utf-8?B?Z1RsNWR3TXpVSkpCVDRZbGtUQjN5UzlrT0RJWWp3bXcyRG9MZ1hSS1VhSm5I?=
 =?utf-8?B?dHlGWlR4eXljTkp0RVIzelB4Y1RuRUtoc294QjdwakVBNTZDU3k4aHd3QW9o?=
 =?utf-8?B?ME1XRzhXbU5FTG9BNHRqZ1U0bDZhTXphMFJBZDNHUHB5ekdPWjJ3YU84eDVu?=
 =?utf-8?B?YmVmR3dMMldpcFNRV1FJc3dDRzdldTlRbnZXVFd4TzNBb09UcTN3V0xlLzNn?=
 =?utf-8?B?T0Q3b2p2Q1ZJYVNvVnJJbVBWN3l6QXRmVmxabHNIbm1HallPUEZ3VTdkaUxZ?=
 =?utf-8?B?QnpCd2ozMFVMSzN5REpueGxaMDY3TWhhZWg2K2w4TVBDVThEV1ZwTkpsYUla?=
 =?utf-8?B?eEdja1hOVU5KV3Z0WDNBU2JPa2U1a25xTFBkaTdFeFZ0am9sR0QwSVI5WDk0?=
 =?utf-8?B?aUllRnhRWmVBWmRvbmZMejBNKzF4ZDdRM2p0RjdzNnBYNGZURW91MW02OThl?=
 =?utf-8?B?SnBGY0NvOElIY293STNPdUJwbHFUL2VKWkY5QUlpVS9pVWF5R0Y1eUNicTVx?=
 =?utf-8?B?QlFDWGh3ZnNqaDVjY3NyU0FWS0hRdmhVOHpFL0pkOWsrR2ZGT1g5SktVRDZG?=
 =?utf-8?B?c3JUUFo3S3JlYUlQNTc4ay9CeHArQnVTSG5BbDJxM29DMGRZZUl4SmNlMFhJ?=
 =?utf-8?B?TTVkYnN3YVZQVldYeis0akhBMVR4eTU0OUUwZTFGNklWV2VrQURHS1B5SldT?=
 =?utf-8?B?aVpMaVV5TFNPTHU5d1RyQ2VjOXpGOTFOV21RZHJxY2ZGYWhLeEtLOGkwSzlh?=
 =?utf-8?B?RTFVUEp4VmJPTDc5MDQxZkwrZlo2YWMybkRZT202aEUyNHFpSG9RZ0ZuVkZV?=
 =?utf-8?B?ZVA5Unhva2t6RzkzWHRORENhNldlQ081dC9XWWVnUnp5Sy9UdHZwb0NvNCtC?=
 =?utf-8?B?eGlFdWdhK3FTdVhDRHRUQVRVcEx0dmVwSUZPZkFqTXNiZDhTZGxXS2p4RVpS?=
 =?utf-8?B?bjRKa0FPUkNSM3AxL1hiY2x6cTN4YlZCVERteVRjc0U0b0krVzFodnBUeWcv?=
 =?utf-8?B?a2NBYS9GdlN4T0RmT0hmYTRBaitPeUwvb210K012ZGpwZHJYWmR6WUdkT0FP?=
 =?utf-8?B?NEFEK2xXM1g3RkN1akluTUR1MHlwejBaRGd5SFUrdzNLK0VERGNxQnI3ZHRp?=
 =?utf-8?B?RWxmMjd0YUtqd2ZuUU5KcDZqL1RyOUYrMExieElOamVjTnlDNlkyQ3lkeFBz?=
 =?utf-8?B?TFU1L0VSSXYzaHVhcHBMbEp0cFZvQmcwL1VXa3RyV2hOUitXNndZZjdFNUdU?=
 =?utf-8?B?VGdQc3FIK01mcHNIYzg2UlVDUTJBVngrcEpQckFnUlc1WEpBNnMvSzBELzRj?=
 =?utf-8?B?ckhDLy8rTFk2dFczR3ZRbmNxWVZlemJTc3VyeVNxaFU5R24veFo3TkN4TGJy?=
 =?utf-8?B?NVpNbUJKQTZob1doN3loSnluM3N6aW9HQUdiR1BINTJmWjJuaW5TZlBvMzVx?=
 =?utf-8?B?dXJIY29xUThwaXJGbzNLbVJlbmlFTGx3MjdXRkdYTzRIMjNLb2NGUTN1V2Uw?=
 =?utf-8?B?R284LzJ2aVc1Z3pReEhaQ202S1phN0cwdVZqSkpHenBmZ0lHcWVSSExlQU11?=
 =?utf-8?B?eHhwL1NpV2pIMkRlSkRLeVRpZ2t0eFE1ODZFWDRwMXFXWEZZWGNZWUNvd3ZC?=
 =?utf-8?B?Y09ReE04WDZybzZMeEcvQnNBMm02Y3pBSVhuZjhWWEJNVXF1U3dqakNLVlRX?=
 =?utf-8?Q?BndgVtZ5gWyR5UlQ=3D?=
X-Exchange-RoutingPolicyChecked: ZGpzitGteSbNyOJ3BjURHo6l4W+xl+xcED/1M3r/0XD6M0w/9lI6mlF9MMAeTWeCcRcUZwp9xtvSGj7DfDAPLmTr3HYhPFYGZW1UMkd8Jc5laP2OLHXbcm2J9F5+NZ2T7RrsV8uY4OW7P8Kx+JMm/6/Otba/2bDWwKOfCrbQYgUz0gGZAS0uTfEY5K3BbIOQhBDcVP3Vh4WJVS/mvXn4Ltyd294V6PTr4cy5is78nmU+K60zL0OqYDo5jzln0fdfSjoVV8r9n6SKRF5+ktMhbvqObpPKxvYrvktTciiGZTVodU29I4Km26FZVS4ekXDcV3XY438oieXSxND4zyCFOw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed81dd2-07d3-4ef5-9628-08df2b86745f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:07:38.9593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hEr2XvGNrPBAhCU5JKoOSP4DAF4pGdqOZmEpX6FDoFd+Tnt611HSl4VSgvppdljZ6YsrUMX/5/33kxtnQ48QR9yKZFBTuq3GdMQIZbKAxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10964
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX53nJ62bsGYVI
 kh7EbNdGd926w0OLKvi5cHbjuv8htUo8IW4+o7SRpupaatjNdFpmkBdsBza//taqyYba7zH67Mg
 zlskKE6sVKbNHf/Mla40twbvNjJ+U3c=
X-Proofpoint-GUID: yk5JelWQLv4leu5M_ljkM9D17A28ssQD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX49sIHXNZ70gP
 T3Z0oTLG9u4kd0zE7g58kUrRasr2OFfmxehCqwD0WZlYQc56E4LyoGSCG++wgZ1XwdNVZ9GFTnC
 UAlBWzebjM819qruyzq0J3OnrssnnxeKrXZzZMsyhph9C6XAnA966ezM3nLvcKtNcVaE/AWV+VK
 EAQGTWXACCtyktX4tUaXzS+MXegbCRtShELT/XMJo0gK2CB9R3ICrIhiO1u89GbLNYUAsY3iP6a
 yUg9sIKRNKHPPJ4E6stioHovivwfwrhWFXgcixyxY7lGFqfn/qMVOps7SD0KpLfwKpqc7+a8UEM
 rrNMZWCaNgSIWZEIHkXmlH88nhT76McfY1EtOUJ8ngvuGjMU16GDeuzxs6nZ2vRyWY7sKdjvvwG
 YB8ixzagxYLMZ94+DDo+0EjiCSM5NSdEphv0dit/65KQIA4Z60wSF2/rXI4BfmV6qx9we96oVI/
 wN8N+hq+ottNervoDmw==
X-Authority-Analysis: v=2.4 cv=G5OJgNk5 c=1 sm=1 tr=0 ts=6ad2219d cx=c_pps
 a=r0Opn4K694hZap5IejKoFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=i_znpONGLEDHroXPIJEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yk5JelWQLv4leu5M_ljkM9D17A28ssQD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On 16/10/2026 10:30, Daniel P. Berrangé wrote:

> 
> On Fri, Oct 16, 2026 at 10:15:01AM +0100, Daniel P. Berrangé wrote:
>> On Thu, Oct 15, 2026 at 07:16:58PM +0100, Peter Maydell wrote:
>>> On Thu, 15 Oct 2026 at 17:44, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Thu, Oct 15, 2026 at 05:33:52PM +0100, Peter Maydell wrote:
>>>>> The documentation for device_class_set_parent_realize() suggests that
>>>>> the parent realize function pointer is "usually in the instance
>>>>> structure".  This is definitely wrong, because the function pointer
>>>>> is a class thing, and should live in a class struct, not an instance
>>>>> struct.  Update the documentation to correct this, instead
>>>>> recommending that it should be placed in the class struct for the
>>>>> child class.
>>>>>
>>>>> At time of writing, of the 75 or so uses of this function, about 50
>>>>> put the parent_realize pointer in the child class struct, and about
>>>>> 25 in the parent class struct.  We recommend the former both because
>>>>> it is the more common choice, and also because it makes more logical
>>>>> sense: it's the child that knows (a) that it exists at all and that
>>>>> (b) it wants to have a realize method that will mean it needs to
>>>>> chain back to the parent, and we shouldn't need to edit the parent's
>>>>> class struct because we want to add a child class that chains to its
>>>>> realize method.
>>>>
>>>> I'm confused why we need to store a copy of the parent's
>>>> realize method at all, when we can just reference it from
>>>> the parent class struct ?
>>>>
>>>> Taking one example
>>>>
>>>>    static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>>>>    {
>>>>        PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
>>>>        PL050KbdState *s = PL050_KBD_DEVICE(dev);
>>>>        PL050State *ps = PL050(dev);
>>>>
>>>>        if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
>>>>            return;
>>>>        }
>>>>
>>>>        ps->ps2dev = PS2_DEVICE(&s->kbd);
>>>>        pdc->parent_realize(dev, errp);
>>>>    }
>>>>
>>>> why wouldn't we rewrite that as
>>>>
>>>>    static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>>>>    {
>>>>        PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
>>>>        DeviceClass *parent = DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(pdc)));
>>>>        PL050KbdState *s = PL050_KBD_DEVICE(dev);
>>>>        PL050State *ps = PL050(dev);
>>>>
>>>>        if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
>>>>            return;
>>>>        }
>>>>
>>>>        ps->ps2dev = PS2_DEVICE(&s->kbd);
>>>>        parent->realize(dev, errp);
>>>>    }
>>>>
>>>> am I missing a reason we need to store the parent's
>>>> realize method pointer ?
>>>
>>> Because the parent class's struct doesn't have a pointer to
>>> its realize method. pl050_class_init() does this to set
>>> up its realize method:
>>>
>>>      DeviceClass *dc = DEVICE_CLASS(oc);
>>>
>>>      dc->realize = pl050_realize;
>>>
>>> and that's the only place where pl050_realize is pointed to.
>>>
>>> To put the child class's realize method into place we need
>>> to overwrite the DeviceClass::realize field, which means we
>>> need somewhere to put the old value.
>>
>> We're overwriting the DeviceClass::realize field in the class
>> struct instance for "pl050_keyboard". We still have the completely
>> independent class struct instance for "pl050" (which is what
>> object_class_get_parent() returns) that contains the 'realize'
>> field value set by the parent class.
>>
>> eg if I put a break on pl050_kbd_realize():
>>
>>    (gdb) print pdc->parent_class->parent_class->parent_class->type->name
>>    $5 = 0x555557de40a0 "pl050_keyboard"
>>    (gdb) print pdc->parent_class->parent_class->realize
>>    $6 = (DeviceRealize) 0x55555585db67 <pl050_kbd_realize>
>>
>> and separately
>>
>>    (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->parent_class->type->name
>>    $7 = 0x555557de3ee0 "pl050"
>>    (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->realize
>>    $8 = (DeviceRealize) 0x55555585daf4 <pl050_realize>
>>
>>> We could alternatively solve this by saying:
>>>   (a) every class struct must have a "realize" field,
>>>       and the class init sets both DeviceClass::realize and
>>>       MyClass::realize (perhaps restrict this to only "every
>>>       class that has or might need to have subclasses")
>>>   (b) to chain to the superclass realize, get the MyParentClass
>>>       class pointer and call MyParentClass::realize
>>>
>>> The support (or lack thereof) in QOM for methods like realize,
>>> unrealize and reset which should pretty much always chain to
>>> their parent class implementation is pretty terrible, so if
>>> we can come up with something more ergonomic I'd be happy to
>>> throw out the hacks we have today.
>>
>> AFAICT, we can already do everything we need with the parent class
>> to chain up parent virtual methods without having  to keep extra
>> pointers around.
> 
> We can make it a little less ugly in the callers with a macro in
> qdev.h thus:
> 
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index 8e91e2fcb08..18e85850c31 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -461,6 +461,9 @@ static inline bool qdev_is_realized(const DeviceState *dev)
>    */
>   bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
>   
> +#define qdev_realize_chain_parent(dev, dc, errp) \
> +    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize(dev, errp)
> +
>   /**
>    * qdev_realize_and_unref: Realize @dev and drop a reference
>    * @dev: device to realize
> 
> 
> which would be used thus:
> 
> 
> diff --git a/hw/input/pl050.c b/hw/input/pl050.c
> index 48df2734e26..abe939171f2 100644
> --- a/hw/input/pl050.c
> +++ b/hw/input/pl050.c
> @@ -168,7 +168,7 @@ static void pl050_kbd_realize(DeviceState *dev, Error **errp)
>       }
>   
>       ps->ps2dev = PS2_DEVICE(&s->kbd);
> -    pdc->parent_realize(dev, errp);
> +    qdev_realize_chain_parent(dev, pdc, errp);
>   }
>   
>   static void pl050_kbd_init(Object *obj)
> @@ -191,7 +191,8 @@ static void pl050_mouse_realize(DeviceState *dev, Error **errp)
>       }
>   
>       ps->ps2dev = PS2_DEVICE(&s->mouse);
> -    pdc->parent_realize(dev, errp);
> +
> +    qdev_realize_chain_parent(dev, pdc, errp);
>   }
>   
>   static void pl050_mouse_init(Object *obj)
> @@ -206,10 +207,8 @@ static void pl050_mouse_init(Object *obj)
>   static void pl050_kbd_class_init(ObjectClass *oc, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> -    PL050DeviceClass *pdc = PL050_CLASS(oc);
>   
> -    device_class_set_parent_realize(dc, pl050_kbd_realize,
> -                                    &pdc->parent_realize);
> +    dc->realize = pl050_kbd_realize;
>   }
>   
>   static const TypeInfo pl050_kbd_info = {
> @@ -223,10 +222,8 @@ static const TypeInfo pl050_kbd_info = {
>   static void pl050_mouse_class_init(ObjectClass *oc, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(oc);
> -    PL050DeviceClass *pdc = PL050_CLASS(oc);
>   
> -    device_class_set_parent_realize(dc, pl050_mouse_realize,
> -                                    &pdc->parent_realize);
> +    dc->realize = pl050_mouse_realize;
>   }
>   
>   static const TypeInfo pl050_mouse_info = {
> diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
> index 2cdfa74f73c..7169afc151f 100644
> --- a/include/hw/input/pl050.h
> +++ b/include/hw/input/pl050.h
> @@ -17,8 +17,6 @@
>   
>   struct PL050DeviceClass {
>       SysBusDeviceClass parent_class;
> -
> -    DeviceRealize parent_realize;
>   };
>   
>   #define TYPE_PL050 "pl050"
Oh that's nice! I think we could come up with something better regarding 
the name (maybe just qdev_parent_realize()?), but this approach makes 
things considerably easier :)


ATB,

Mark.


