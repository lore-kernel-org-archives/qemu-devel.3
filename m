Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269EDCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNt9L-0003xq-59; Fri, 15 May 2026 10:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNt9J-0003xh-3N
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:04:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNt9G-0001PR-0c
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:04:20 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9aSbU1809953; Fri, 15 May 2026 07:04:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+7iN5ZzYEcTCT8dUgfkOnw+53dsvI47ZbAuB72Wt+
 hs=; b=CcZXVduFsEAJKoDQeoQPMPJwfOW3XgdzwTC9sZW2zYMTozE74Zy8AVVyr
 sidR12s0VVyBRAk6PxPK4lzoqoSkpPYL1DZt2kYlXwgMwo+H31BGCEZeOGqRbBux
 Eb23EKbUIsHUtKmGQVwkNSfnuv7t0OA6v5V9z2lEOnlPtI9Qnyj1CddoQyMkyMrO
 Fvwj4vxjQRNnxZLh54UsTFRmQcJSj9QZC4jZ60BsYm68CLfmenf7qMSGI6Wh9lMI
 c58apGdX7IbwiSJFSVO70GEISOz+vjSUfZwUaA3dj8R8EFG0tChgClZKYzw36uol
 TAejvmvumg3o7rh1Iv4obVsay5zqw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021088.outbound.protection.outlook.com [52.101.52.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m20a5f3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 07:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKZiLdq/0NM535XfgYc/sC+/LehxJoVaag3U/nKCuib+Cc/5Ox2rHFzTJ0FjQN06xxl4/IpwaEQAjM2xSLdiBeLcUnTptytriag5pbFSV7hQlM1oONkWJ5QOXT6EUYXu4qXGBwjVNZiDI1UzxjwcUKs9ONUbVSqd+GjB5qt+zlBT+x9mIyfkISfs+38MuoATBKsn37cfDaRUm+tQbS7ZnrmMJAJ4RvNU+pFZobrqNwglCRDH8Uun8UbEINjCZWxMynys91aD+cS1p/vob05v81BZuORCcme0zRGXFSX5Fs3axIu/iT+A8ihzZ8o/vdaMADENE1l/D06gt4X4HfLvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7iN5ZzYEcTCT8dUgfkOnw+53dsvI47ZbAuB72Wt+hs=;
 b=G80S1CzSW+CuQvUoBpZ8uW6ecMFVMgZMkt5i1h3QMNMvusC3480BlCCVNoWIqv9s8VzUBjMD3sylwcUuo8P8i1l1YrPWG0ib00G4AuoPFmqqNtrqh+B0kDuciPUhwxbNhrtpyxJ3X7QboVYdwtkpUJSp8VyEjMjWSAniAPY7YCU77zDLQB+AqnlVpgvTxQqSDtdC/GWAMejEuklxQigEsyWI5OH11E+EaNNCQP3fUBOLxPtitYED6wRMn1dZWbC2vlEcPDsJxL0gJXCAn+xFX2g/e2ugX5awUjeGVRdDjpkoy9wos3q1fi9MRtbAtHCzwgcK9X36qth91Bm9lFzhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7iN5ZzYEcTCT8dUgfkOnw+53dsvI47ZbAuB72Wt+hs=;
 b=K5ACZScYOgIteYOtbPkn66YterBc9wgD8AQXXPK6emTNkpjsnuS5y8M7I2TbMQsCG1NmUgtlcQ30OKz3ZFpvoBnwlZ9/PvLH7wdI3WIm8vtol3ys83t8G3aGCJLVp57tl3Jh6P131bvjhqWkm6MW2ZCFg7zdjWUg5Fl3y59sGwszlEUh1/BxCYdulGcojXdtNTT+dWypZC1j2L72BUUHL7A8y/LCAIAecOneWHQ3sgJnlQNyLUu5rtxN7hpb3YStjYrDj9rBlVAuSacb6e1mA8H9wnjRlPQJtomlUcwk9U4foT48P4gPDieSiMFP4sJ+NYAFDMUVMzqauwRaJQa3hA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9209.namprd02.prod.outlook.com (2603:10b6:610:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 14:04:13 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 14:04:12 +0000
Message-ID: <34b5dc1f-4066-448e-af00-02d06930cf52@nutanix.com>
Date: Fri, 15 May 2026 15:04:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] hw/acpi/aml-build.c: add aml_irq() representing
 the 3-byte IRQ descriptor
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-2-mark.caveayland@nutanix.com>
 <20260514153324.7ff20b8e@imammedo>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260514153324.7ff20b8e@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:930:4d::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c23820-1acf-4277-7e69-08deb28ad70f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: okBdbZ1p5t4vSjj38/shbcanqlKc7MqdsF82+5hgAgsaVz/uLi2cSqX5wVaNOfnptyNBAhZfRv7WzVOIqtz7EEUPEJwOuqOXkuUGL+LP+S3kLHmXC4pooeJDU0WWrfJtU12yCxF7xXmqqvt+xm2hGASr7vJXH80y1o26akRD5TKVyOBmuQFg7I1ITGsMh/sIVxv/n9F1aPhgn1i7yMPjOlCuUucV0vS4RY+/cSVjKkEhy676enXS4gPkfOsgLUB4FJoMrSI594zO5cy9grJ4v+0NmfZgt98LH33Hhc4dVOQ66wThxNNPm6l8h7Dm+wTBF3EwjYiUMa7NaCA1QQbO2URwF5AXpORusrHI5qbymSTe+SRTIO9zHYcChH4OoewA9hAbFqCGw0jZTVCwfy8yZiVTm6veS4gO3CWjt1GdQL5RSS9JnYxLrGx2GkM+mB7Z9YBgqHs352MnQekqnBaE1Zzw/BXzKTQeVJZIKqZ7R0tt5L9yTSDHrATyp3bc+94NQSKGmCtFLIhH0Ck//uwvLlb2yGRTmrPlT6KMK14ct2Ea8Sf6NAazUkplKIPCi8/5gRClAT4fCJ+KJ7E7QIoen0t86+UAOnqQWUfer9c1CdQwzjzj1kDXtJVV9anKDbYESuWxNjeVNNVib/dAYCOcZkdhoc0v3bzP5WxPLT4HnkfHa/Ld6bS+bXs3C5tiktS4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJIcDJqN2xqa054SnY2YmZIYXpxdDB3ekJ6b2lLTkx5VmRwUlBURjBpNk1J?=
 =?utf-8?B?MER2TDVRTHl5MDJad21WTjFRZmRPNEExUnB0WDd3T0hSNnBDK1F2M3hOUFho?=
 =?utf-8?B?Qk1DMWdIWEVkL0M5b1hFekdyTlNDTTRvT3BSZ1k0Tnp5SXNiVEtxdEplaVA5?=
 =?utf-8?B?b1Z1ZjEyajNpeWlwL1JRWjVRSlVNaytSeDkvTVRSeFBGcHdaSFJrTHRXMGl6?=
 =?utf-8?B?SVFVcnFscnpHUEVWZGYrbFZlYkVFNWpVb0l4c09QZmY4M1ZCUm5ZYWd3QzND?=
 =?utf-8?B?OWFCalcycDdtNzRqQnRUcWVMdmV5K24wSm9VNWNXbjJZUjVKOEhsYkRrTm1p?=
 =?utf-8?B?LzRjMnhCVE83ME1xZG41RVlISHcwcW8rcFBFZGpsT3J2TFVXMk9od3JrYUE4?=
 =?utf-8?B?ZEZkVTdkaGk2b29VTE1lTHlkUlJ3SDR3ZWd4YUI2anlDZmt1aHNRaVdsenli?=
 =?utf-8?B?NWJ6SXNXUFlOVEZRb3JtVk1kVWV2Z3FFMDZUNDhsQmthYkFCQUJJSWZMakN4?=
 =?utf-8?B?UXN6NEFaVWVKTlkyc1BmRVppVXJnZUpSNDVScmdxUWlSMFJOc0NjVy9pY1Mz?=
 =?utf-8?B?RlgvTFNjN2pucXRqOTNnTm4wZyt3bC95NENCSVBrN0J1OGRNOFZoaWJxZlhy?=
 =?utf-8?B?VEg4ZW5Jb0MyWTc1ek5Yb1pIU3Z2QXVoVWFGc2JWMUtySUFkdEI0a1NuRStU?=
 =?utf-8?B?YzB1c3p5ZzFNRDFkY0hvdFp2a3h5WlkwcWVELzhNMk4vZXROTkZEbzZqL2RI?=
 =?utf-8?B?UFRvS3pRWFVZcDZESCtuNTNmam9OYjd5UFNFbk1TN1VkM3RQTDJRUlp2bE5t?=
 =?utf-8?B?dFMvaktBVExSSDhFRStEZHIxdzJpSzJzYk9jRmhqbmxVT3RYTEc0c1oraEo2?=
 =?utf-8?B?azNndjZzU3oxWHZvaUt6TllGWTN4UHJ2QitjZUhteDAvZ1VMdHhiNUx0dzZy?=
 =?utf-8?B?bTA5U0JueU5xL1Y3NkRoZE9sNlNLWGxRUFFDNVBwSWtpRTBrNi82ejM2NDVJ?=
 =?utf-8?B?bkJyMVdIMXdmcEJFeUlIWmpldExEbUpJbXM4V3BaL054c3pQUG5jNlpwQTIy?=
 =?utf-8?B?dmJ1c1Y1Nlg1bThZeUxKZ1dBV21Valk2dDVmSlNSMS9sdDZVWmpWSDU1RmxR?=
 =?utf-8?B?WmZ3Qmw4SzBHSVl1dXYxNHBDZEZuTjRvMkZxOExnRGxoRGlXSkZacU4xb2dm?=
 =?utf-8?B?YmYrRnN0cTgzcW1keU9UMmNsWEt3bm1XMExIaHg5dytrS1Y0bUVYZ2U2NUtv?=
 =?utf-8?B?YXp2amEzMlA4OFpSKzY5TGZNUmx3ME1DY0ZZaUExWGU0anNKZjUwZkNtSm1p?=
 =?utf-8?B?Lzg3SGxTV0tocWhnbnBxcTluMC9PZ0JMMWtFSnpDNjhwTVc1alRGWlJsTmhu?=
 =?utf-8?B?dmJGREQxMi94M2JJaTVyMHhNUU9LeFA1ZDBVdXNQVS9SSnN2MWtKMmk3ZlJr?=
 =?utf-8?B?NWNTQnVMVVg2L0dHZnBoT3FLZ00zTTQ4NmZBeFUvQzVEbUpiT0NUSzRxU3c0?=
 =?utf-8?B?V1VEODFjL2JxVnpoeWlJSTd3WVp4cTNHYklFdFBueWxmSlhrcnhkM1BQUVRP?=
 =?utf-8?B?emJkQzkvMmJFeDJoeC82c3kzVUI3REdJS0wwbHJEVGtWNEdRdWQzaDZYT29j?=
 =?utf-8?B?ZlVlcGRUL0p5dTZjYjlHUUJUeWlsSjRuRW1pSExCcTkyOStGRFVVNGdKSks0?=
 =?utf-8?B?RjZhY3FPU3pMSGw0YXI0V2hVWDh6QTZxNCtZOS9GRkxablljTS9LcUNlSXNY?=
 =?utf-8?B?bW9ucGE4ZzNuejlaU3ZaTTc1ajFjRndFS2ErN3VwaHRRZ2RjYnJGQXBhc2Fz?=
 =?utf-8?B?bVpPUGk1a2Q3TE1ldkVDdm1UNUNQZEhnbzQzblZ4Z0pDRXNPcjNDaDV6SEI5?=
 =?utf-8?B?MFFyc1o0Vmh2Y1E1MTd3Zjd1aUhkQlM4NVFZM29QRVNQajdRVXk4dmtuUE0y?=
 =?utf-8?B?Q3Q0SUs0U2tVNVZwbFRLZzJ3VHM2N0d6VGNTV2lPV3NhRDE1MjVWSXdCeU5H?=
 =?utf-8?B?blNBWFJnRHJzWEdKeU05NHRoYWdmOW4raG0ycFdQMHUyUVNKZERVYTNOQm9m?=
 =?utf-8?B?NCtDTEhtVjVOQlVqL2R3NGViQ1pvZTVpQlp6MC9Yb1NsQ3R2S0hHOEVMVXZy?=
 =?utf-8?B?WmRvQWtBeFBPVWlHMHhpcDh5T2h5K0xzbksvZlc1YUM1NjcwelJPRnZXNmQ0?=
 =?utf-8?B?MVJEdHdVZTNHMlZLUzVmeFlaU3VSNXJyWTdhOU1MbUtKR3l4SVJLZGhTY2tB?=
 =?utf-8?B?SFREQ25iNC9waDBxTjFWVHZBV0hvN3pVaDM1UU9BNXBRb0FhUS9qanVjZmhw?=
 =?utf-8?B?cWVKdGZkWnJpdEM0RjRXa25samRNSzNlOUlzMTZweThRMm9nbkpTdDBQSlNh?=
 =?utf-8?Q?wBUzUDl9rWNsls4M=3D?=
X-Exchange-RoutingPolicyChecked: KY32qkpxaWl7NGm1iNbV7tgcQ392fM9GtiagmkYEz/BevmWOb3I2fokQZAnWAiAkJLpOdzhil55j/WdA4ucNDLW1be5wqpYUVMZQUBoX50Q9c3cq9dDT+QKz4llz18QSe/p/dhQDQ0PYNBzoQBKEksNExmnomvRFmEjUE5xecv8HThc/db3PuxhWlqPoeTNKixB0RRlS6lze5dDSNEUwwcLIk5Ikz4CBZBi/Eko2z8FTraV0/cmklFImwIvEBG2i2OZV7dD3ml1FJJzaK2BwP6hjW7PNsjm+1cqH9vmrq3kXetdPBdA0BbLpb1XF4NCukFzlXTehJk/Ir29X9YknFA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c23820-1acf-4277-7e69-08deb28ad70f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 14:04:12.3464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7a5JajrgZMGUQxHU62TgLl4S6rJUJ+ok0KjlCLhknVOvpO1HRBs04WezLPIfG3Na7/gYYxgfP54zsS5JeMNIbQEVcrxnD2Tz8cFjfBxV9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9209
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MiBTYWx0ZWRfXxTFBwlMsxbJG
 jhyFgMMkVpORrR0TeeIWYNq9N9ufjJe4KKWiAbEDCJHYi1Yc6JPogTq+d42FFtD3XYgTUbzT8cI
 0W2M6EdwoKW1ScnAjSyJf8H3khHof1hr/e4Ny209imhJc91jwNcAUWiagFJU+EAaHOXRbcoKO0P
 Lqrmxr8UaOKlatxNHrMnN99yCHh5dHraepvf5DnfmL35doeDo5p/kdZPPQMpTRRFeTUDxO8OpHu
 1yj+AzZchy6tLCwQ/KvlFtFWYHZqzS5Lv94q06+gZPDiyOR14V85x5CFEpQ0beQKMwyKSiuiZxN
 hGWZQg+kJ/KXr8B0lwKGPB1kc/x6lbHepwnzcmnnUIVmgxC5+MUvjk1UxnlrrSjrdgmyVvCVFLO
 dpOJk9ctvy/+NpmJLr6rn7p9qMFjS9cQP1OCVk9s2xksFdoSNC7pbFy8bdkQqnBDoL1yJDQib+C
 XzsMGm++eVepJJ1vCYg==
X-Proofpoint-GUID: SzlDOHJcVAqLkeh1IQs7FybDHtSxRzVl
X-Proofpoint-ORIG-GUID: SzlDOHJcVAqLkeh1IQs7FybDHtSxRzVl
X-Authority-Analysis: v=2.4 cv=Ed34hvmC c=1 sm=1 tr=0 ts=6a0727de cx=c_pps
 a=iWUa97dvZcywjWCZh5/f9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=wmPCxT7FhHDjnsia3PMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
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

On 14/05/2026 14:33, Igor Mammedov wrote:

> On Fri,  8 May 2026 11:17:40 +0100
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>> The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
>> the interrupt information, however newer Windows will only parse the
>> standard IRQ Descriptor when enumerating ISA serial ports.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> with nit below fixed:
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
>> ---
>>   include/hw/acpi/aml-build.h |  2 ++
>>   hw/acpi/aml-build-stub.c    |  6 ++++++
>>   hw/acpi/aml-build.c         | 25 +++++++++++++++++++++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index e70e0643b1..eaff025d26 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
>>   Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
>>                             Aml *offset, uint32_t len);
>>   Aml *aml_irq_no_flags(uint8_t irq);
>> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
>> +             AmlActiveHighAndLow high_and_low, AmlShared shared);
>>   Aml *aml_named_field(const char *name, unsigned length);
>>   Aml *aml_reserved_field(unsigned length);
>>   Aml *aml_local(int num);
>> diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
>> index 89a8fec4af..3180c7c962 100644
>> --- a/hw/acpi/aml-build-stub.c
>> +++ b/hw/acpi/aml-build-stub.c
>> @@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
>>       return NULL;
>>   }
>>   
>> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
>> +             AmlActiveHighAndLow high_and_low, AmlShared shared)
>> +{
>> +    return NULL;
>> +}
>> +
>>   Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
>>                      AmlLevelAndEdge level_and_edge,
>>                      AmlActiveHighAndLow high_and_low, AmlShared shared,
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 7edc8aed42..3aaf96c2a7 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1061,6 +1061,31 @@ Aml *aml_irq_no_flags(uint8_t irq)
>>       return var;
>>   }
>>   
>> +/*
>> + * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
>> + *
>> + * More verbose description at:
>> + * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
>> + *           6.4.2.1 IRQ Descriptor
>> + */
>> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
>> +             AmlActiveHighAndLow high_and_low, AmlShared shared)
>> +{
>> +    uint16_t irq_mask;
>> +    Aml *var = aml_alloc();
>> +    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
>> +                        (shared << 4);
> 
> I'd add here an assert for invalid level_and_edge/high_and_low

I was in the process of testing v4 locally with your suggestion when I 
realised I hadn't done the full port removal and redetection test on 
Windows 8.1 - and whilst it detected all the ports, it marked them all 
as in conflict again :(

The only other combination available other than Active-High-Edge used 
for v3 is Active-Low-Level so I gave it a try, and it worked for both 
Windows 8.1 and Windows 11 again.

My guess is that rather than reflect how the PIC would be programmed as 
Active-High-Edge, all Windows cares about is the note at the end of 
section 6.4.2.1 which states "Note: Low true, level sensitive interrupts 
may be electrically shared, but the process of how this might work is 
beyond the scope of this specification." i.e. any shared interrupt that 
*isn't* Active-Low-Level should be considered invalid.

I think this is fine for our purposes since all we want to do is 
indicate to Windows that IRQs 3 and 4 can be shared, since anything 
using the legacy ISA serial ports will almost certainly have these 
well-known values hard-coded regardless.

I'll do a bit more testing and send a v4 later if everything looks good.

>> +
>> +    assert(irq < 16);
>> +    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
>> +
>> +    irq_mask = 1U << irq;
>> +    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
>> +    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
>> +    build_append_byte(var->buf, irq_flags); /* IRQ flags */
>> +    return var;
>> +}
>> +
>>   /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
>>   Aml *aml_lnot(Aml *arg)
>>   {


ATB,

Mark.


