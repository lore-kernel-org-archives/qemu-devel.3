Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E53C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Xr-00071Q-Rv; Tue, 07 Jul 2026 09:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh5Xk-0006zt-D2; Tue, 07 Jul 2026 09:08:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wh5Xh-0008TK-40; Tue, 07 Jul 2026 09:08:56 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667CAash2378216; Tue, 7 Jul 2026 06:08:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=H7oxrNHAgMKhzXmpDNkYxfp2hJl1v5wk9nilA0xXe
 SI=; b=PxjxlPW/AxRtQr85q6OC9/arLpwp/QvKkMSF3JNnoWg8SHjTFmPCuezz8
 NzJaKfD7pTu4hXSY0tA5uWD5u/VbFfVQ5Zq6V0F26GFUEe0iX9vnmYqLn34VNH/s
 Vp4/dEX67NAqQLGJd+orAfQJNrrMo3OxHtght18+Os4wDokhMfzUux6srM7xRIFQ
 nAptV1klD6/9WHmOX2apgex2Cl1AS3GdsO3XCagNg82xkhnf+mCF3UgSg/JcN9kW
 RVc6V3hEXr6mM4ICku6ApQeILLsukI3rM6HHgFUZASqSisReGowoGF5I0ZcK9oLn
 K02HAARWOZ1dbptIsWTBTpMo+x+gA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021133.outbound.protection.outlook.com [52.101.52.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6x376n34-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 06:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbdYcpMfx3bmh3h6i28xTDEVkukqvFl5bg5LI/IJXR25wmzVFNo2OW2iaBBtAkXrxKf267TSGRrlkyfCZurgbwHq/lZrtJ4uGHDNNa3CeeRfxhI3sWeTfHFoW/k68l+JRiYqcl2nzcMl2vqX8J7fTC7mHhyk9zemBoaYba0xiEYtkPo1/SeTZvPc7bpuBVl64xJPxTbE6Tnq8wVKZqa5/OoL8z+zVWUj0tj5jjO5U22JqSR7Y+7FTZVuT2sazXowUDRNazOmzoO6O2IMbbj30GuOzmN+zfho/hXfQxWqPB5VyzpatbRxTlPCBxJiBsjM673vd4lmHpXo2P/QcxEbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7oxrNHAgMKhzXmpDNkYxfp2hJl1v5wk9nilA0xXeSI=;
 b=RsAm3DC6bIwk8kCjS74HnoB84wOtO0AWLJGG0z4gCh4iRMjIGsesv70AhnF7ZxhHjuGyEDzmQ707gx/2HTgyk6zDe3bKJ6ZukJvNOfTsc/HEfSbURkYdOrknASVJKrw4F02sko3Ele3VB/AzVi+Zt+TCAiZGRnGvVGW8/XXkobDckvlZB2PrC68W/dRmocArKpCc7aEO6ziSYu5i5mww0ScaN645NqqeXWYd3pO+iN5lquvNwVSutTOpDkdmdOwIHf4IKMDe04mH73E9yU8RlLblOUlAmQ3joYbvHoBJOPK1RyXrzRinJUtP5KJ788xSvtHYPN7POY+7NmE915iM6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7oxrNHAgMKhzXmpDNkYxfp2hJl1v5wk9nilA0xXeSI=;
 b=GjkRKI1P4hVyorcBrkcnZ2iVW9XmXU11gIiaXSr3gcnTyrR1de7QCkkaf7pjIZumRhOA0Sb0eS9zIueX7RiAom7oMtL4F2siecdlmVjQQk0AAac0rUmO8gR5wQjuOhYNs2twbWJgN5E8ycBzBX82w9zvgwOlQUFvfTWfGGA2aTMl+00ugXI4/Be2CADUZH8+s+gMMXXbN58j1Bt4ik4aJIfLc1x7/wiLpTKLYpQTvuk3ADlmqbNkhvLo1Y8NE422i726irwpSe3lSEE4O1Wyok4ugtz+EDod6lhePUXIbHe0yQQ+feAoU8ZM6gccGjldKVLmp8E6PHmGCQhoufd7nQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7333.namprd02.prod.outlook.com (2603:10b6:510:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 13:08:32 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 13:08:30 +0000
Message-ID: <40fcfa42-ff8a-49a7-bc69-6a3c2ae03e38@nutanix.com>
Date: Tue, 7 Jul 2026 14:08:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] qom/object.c: rename
 object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
 <20260703135512.3213964-2-mark.caveayland@nutanix.com>
 <akzrbOKbBwZAKK8D@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <akzrbOKbBwZAKK8D@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b950752-f797-4ce2-3ae1-08dedc28d76a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OLT6aWTd6U1Zd81rj+iiLsr5mHj19/fEYQTxlb9NW3es9B/0ZSmhmgERJ/VaqbkBv0ZN3NhqD8WlB8D//PNEpNZJcXEisVtCTpMVaACLxjIYzdSCn84l1yUnbFNHkOTfgTovjB6FpU3MoKwgvX260sknw2MKBuKelebux8uDawW0ik3H6cuMe8+9a3T9siq8PY6vS/YEMdPr67rrQnbJ1QVVh6HrEGp7h481SSKUE6NMwcAouxFNS0yj4pAncYP80tBWd9wooTHmC+YYYnUobmJiZABqaNPqG9l3vtJnVG6l9rmnNlXO1FMu51RShFbyRpIEVWl24XCnDWR8Jfp637nCrNC3/DTANI6FAClqLMwHMcw2Zipc8bEUuZHHtk1FfVRpXjBtwU1WXrEGskB3Wf43JByQ60TAZgGHjs9ULCAWfH95F2N/C1iEzYuz4phG4CRr0TG3twjT2AAHIsLvNAcolPUgAFHtnTbYNzJvoICrteJ4dxgt23y9QcSDz/TfBfxsvGIP3JF7NfDkF9Ut8gEF9b0Caax6+xnzR355LeR0ioTLE5pkXqf8OOwuSH3vp3ykoekGX+x+FThctYgx8+DSyw4UftyaXYPPW5vvTp99dAGnp/B3mPpw8bVNO7bbQlquw7Xa2b8NKj5jNh4tycLcgsCIr/r0wRRPKJi22/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzlLdTlDeFZEL3BnemowdGxINU1EN1UxZisxMGtXOWNQS1ZLTC9ZYlV1QUQ4?=
 =?utf-8?B?bmg5R0RybmRuQVY2TGkrSGpHZHR0UWIwT1pwK09tUTlnMEFQSmtmUTRvWjZL?=
 =?utf-8?B?MVRrcE1NUjFDUDZUQWJkTjZQOG1ZT09sYUdOS1ZLa3BUdjBiQjZxdlYxbTl4?=
 =?utf-8?B?azYzSUxLR2dkSHUvakF6QVA4UHpBWnBQL1pwZUZXV1JMaURva2ZtNkRJYUdr?=
 =?utf-8?B?K3NaQXNEOXJKMGx2S2Z5S3pqTzEvZThaOUFNSkgwZ1JMM0M2Y055WGE5Rldm?=
 =?utf-8?B?Q1lNV0JZMEtubmZRb2RpYVRSa1RKaEdjVkpveXc1aVNhRDJwZVFQZHo1VUVV?=
 =?utf-8?B?OXNDUjBvd2c5QWFQSmN4Y01IL3M5ai9ITC9WeFdETTZROXEvRjl1UkNYaDlC?=
 =?utf-8?B?N3NpTStKRzdpWVJSZlVtZ3hNQUFhSEVjTjBpZ2w1SFpuUDRTNDFrVHJ1dDA5?=
 =?utf-8?B?b20rcmxCVkR1S3RQVVZCWmNmR1ZxVjB2OFNITWdyUXZXcGhFNzcxdlR1Rjh2?=
 =?utf-8?B?a3JmUng2OEN1c0RQZytOa25ZQ0tJVkRMczNIYTB4SzRHSDRwTkJ0bDhlZlk1?=
 =?utf-8?B?cU9FOFhOUlp6UUpVSkVQLzdiL01QMzJXWUQ2SmJ0VTg5R3BLK2FNaldYckpr?=
 =?utf-8?B?RlJjd0RFM0w2UGljRElxaWNIb2Z6YXlrN2RjWnkzRjkveCtXRUdVUzBXbUlP?=
 =?utf-8?B?cEdKbEwwR3FQRnVTZFppZWdhck9lcGoyKzRBMVRwdXlWWnIxOHJKOHhBQ2Fp?=
 =?utf-8?B?bld0bVB2YnUvZmh5Y1NvcTZmdFhvNm1KUjN5VkhheXplVFl2bldzYlJMQ0J1?=
 =?utf-8?B?Zk5rQS9KZUdoQjR6WnllU2pBNWVITnhGRzVwaTBReDB3QkRuVlJmMzNHcmJr?=
 =?utf-8?B?SnhrekFCaWgxRFZ5QnUvMERGN3JRTHBaK0lRTGp5RzZKSmthZUQxZmdUaGFE?=
 =?utf-8?B?ZVRqeDZIOEM2VHQ1K3lGcWY1QTk0cjRSbVZZNjJFcVNsbnVDdUVOcTY4OUM4?=
 =?utf-8?B?SGdLT0p2NmR3R3JUNjFmNnY1WFA1UFZsRk9KVHZDZGU0RUUyRFZTZllCZW9W?=
 =?utf-8?B?c250bzVmUmczR1BWajVuSi9qQWswQm1EWTJ6U2lOaG9YblF2NkMvRVVSZjhS?=
 =?utf-8?B?OVJwRjlUUDRuSHd6MnQxWkx3aHFQUDRYR1FISlY4RnYxMjE1VEx1UnBvMWJT?=
 =?utf-8?B?dGVYanlRNnhobXF5clhLV1U4dmNaV0k5ZWVEaFgzbG96cUN1aW5HVlhHaWZh?=
 =?utf-8?B?ajNIR0lUOU4xcHJubHIyRkZQU0wwZS9KSDdJOVpralRNTEEzc0ovZC9QaGZ0?=
 =?utf-8?B?S2F5alVhcDlMc2IvRlpPR0owV0NsRjRCZ1ovUzhEdlZsdHVBZldRM25zaU05?=
 =?utf-8?B?VG1lUmxEb1pqSHkwaURpQzBJcVZqeW1rbkhJMFRBTWhvTVJEWnhrajFuNHlz?=
 =?utf-8?B?MGdXRFdwZ0NTM3I1QTRTTzJzZDVPSmtsV0tZaXNXTW9ON0FmWE1oc3R5YTRJ?=
 =?utf-8?B?eTFnUkZsekRvRjdDWjRpMWg4emRxUjVIb2JTK3J1dmZLVDJmdVhnZVcvWldY?=
 =?utf-8?B?c3ptYVdadWxrRkQ5bTg1VmdCUHY3Y3JvUGRoZVZPakhuYTJzRDFNWW1VMXJ1?=
 =?utf-8?B?QTMyN3pMQ3hjMGQ2ZkxlcjUyTUZCVmlQMncrdXhXWTJTd0VFSjhOZVhzbE1z?=
 =?utf-8?B?Y0JnYmszM2w4cXlYRE1EMlovK2JqY2RaWDZoNEczSVYxbE96UHUrN2dWYnNs?=
 =?utf-8?B?MGNiWXI1a3Y3VGxPUkowRTlaVndGSFFETGptUXVtQ2lqRHdWSnZKeDRscmMx?=
 =?utf-8?B?aTJwSzEyT1ZZeUxGMWpVTjJTN2Y5a3ZXeTN2dngxWDNEaUpVYmVQTmpYNXNk?=
 =?utf-8?B?Q2JRRFRVVFZsM0hRMno1N1BuRGpaRUY3RGM0TkxvdlhHTU9KL1Z2V3p1VkpU?=
 =?utf-8?B?WE12RDBtY1E2UnF5RzFYQklWOW9pTEYzN2kram1iSm9vYWozcllhbU5CbW1i?=
 =?utf-8?B?WkVlekc3UnpUMzhhM0pvTTlNOXhIYzVnbzM0eVhnTFVpb1JPcm9FSzlXZUk5?=
 =?utf-8?B?WVNBMTBxeFBMS2NJT05KZGRCRjY5N3VrMTNVaVNDbDYyd21aVExjVE8zK0U2?=
 =?utf-8?B?dExzWVdrVjlMM21YUzlURTNPL0JGcGFiRDI1VEJSNUhKS2R6UnBlR1lYckFr?=
 =?utf-8?B?TXRmMHVQSDBTOS9zWXYwa0YyUzlJMkZJb1dYSFBETUZHYkFnNVYwZEtYRTNy?=
 =?utf-8?B?VVg1akJ6YUQ0eEZ0ZzhaQ2N4ZGh0cndJcVcvZzc3TGZ0akJIcEt3VXlFYllD?=
 =?utf-8?B?TURldVN3T0phRHdRU3hsOEhVYS8vdDdTSVlHdHhIQmNzemUwckUvL1Z3bEhZ?=
 =?utf-8?Q?aaTHHwglzdnA/4PE=3D?=
X-Exchange-RoutingPolicyChecked: XxNj9HT9b0n2YLOLnOkEW/Ih072N1hPqRWYEy1iLIEhOav0Zer7c/EnsKnBkJoqLjjv08SIjr8HvxvwwLNGZM5hu5e5eArJ7dQEk1Y6oa9lTLKwpeMUfaf7PADD6+JZaXXS63syqkfH38H6M2fNqlYA+LpvOIBkOchzAC8TEpXkMp5Xhy469NWPmJdWh+gm0rfRIxYkPwYryBI/DDlCW6+RqNijSxdF7nSmLgAOSFpRp8Rr+ar1rJlI87AB6A0i3FUVASV3n3bqXcumXg7/j+gqrPrRHcSh69DvPpzgPrOjWPjuuI9qVlqQbbYQl1ewZh+Tg4YyhZSU+TdYP0h2gmw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b950752-f797-4ce2-3ae1-08dedc28d76a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:08:30.7755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os5HgplC7ds5kr9K16Rfo4yeYTy91jmE7Mcors5YmV1cHlX75hSbMY3Y35Rx0ZWaoW9lu+CMCE9Kx4fPz1peq9a6ZD5szQEYP9bQp+7bb/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7333
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX92wZcSummkVT
 1hNiU5tAh0FYHN6/MoWSkHEdV+gC+knURoJYYFTwLLyHCKIwZcFMLi9NneHAocy9fD9CTR6hYPk
 UnpdfCM8rdFF+tstkxQWSNF6oI8ds/xLoJdMgvpK4HUKFrfLUvfAVhZE68vtazXpr7bED78GJxA
 iU7KJGWwIggCmeCew08kJwqXkP1moHKRMnHDBByOWr+9QuXuMdoJet6xdJgyeUs9wxObz3A8bwV
 yKylXtSso4nFz2XrGtqpNl1klnzsJfAXJ+Mf3xLT8vaZUifpVnreMd9JLlxLt+gwFQoNHHqfchq
 Hlnd5QUwW0bMo8aD3DvofoXqH7BRCQVaEcRubMQaSN+PMd9fk9+eP11N2B88Q+hoEq3qWIchb2Q
 dpCI9MH7wTBu8SEjbBrqpNE9ZlFEzZYP+pL9YSUb0arb9UNO6buvjTYEwG3uctyxpeN/q3dQ5zx
 e8yDJRQe8hAr1FmJ3EA==
X-Proofpoint-GUID: dVR_8oBSEhiHSehtJKKoyfmDb816YngN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOCBTYWx0ZWRfX/DpHbgaCIZgF
 PVLrPQ6w6ExOgL+JdaCvg66M5xhVpHOQo/p7r5VfYmNXKY8kjkhy9+gZHP+c0FCmELAPnM5WGvL
 eNHtexYX06wgRL3rmbN+MToSnMfLax4=
X-Proofpoint-ORIG-GUID: dVR_8oBSEhiHSehtJKKoyfmDb816YngN
X-Authority-Analysis: v=2.4 cv=B4CJFutM c=1 sm=1 tr=0 ts=6a4cfa52 cx=c_pps
 a=zQVrRFDx79pk1Kc/J51lMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=6NNHhst8lbh8x8lmJTMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 07/07/2026 13:05, Daniel P. Berrangé wrote:

> On Fri, Jul 03, 2026 at 02:53:03PM +0100, Mark Cave-Ayland wrote:
>> This more accurately reflects that these properties are held within the class and
>> not the object.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/qom/object.h |  8 ++++----
>>   hw/riscv/spike.c     |  5 +++--
>>   qom/object.c         | 28 ++++++++++++++++------------
>>   3 files changed, 23 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 11f55613fc..89c23d45ab 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1956,7 +1956,7 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
>>                                                 const uint8_t *v,
>>                                                 ObjectPropertyFlags flags);
>>   
>> -ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
>>                                            const char *name,
>>                                            const uint8_t *v,
>>                                            ObjectPropertyFlags flags);
>> @@ -1977,7 +1977,7 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
>>                                       const uint16_t *v,
>>                                       ObjectPropertyFlags flags);
>>   
>> -ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint16_t *v,
>>                                             ObjectPropertyFlags flags);
>> @@ -1998,7 +1998,7 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
>>                                       const uint32_t *v,
>>                                       ObjectPropertyFlags flags);
>>   
>> -ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint32_t *v,
>>                                             ObjectPropertyFlags flags);
>> @@ -2019,7 +2019,7 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
>>                                       const uint64_t *v,
>>                                       ObjectPropertyFlags flags);
>>   
>> -ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
>> +ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
>>                                             const char *name,
>>                                             const uint64_t *v,
>>                                             ObjectPropertyFlags flags);
>> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> index 9fde0faf39..630b65f569 100644
>> --- a/hw/riscv/spike.c
>> +++ b/hw/riscv/spike.c
>> @@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>>       object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
>>       object_class_property_set_description(oc, "signature",
>>                                             "File to write ACT test signature");
>> -    object_class_property_add_uint8_ptr(oc, "signature-granularity",
>> -                                        &line_size, OBJ_PROP_FLAG_WRITE);
>> +    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
>> +                                               &line_size,
>> +                                               OBJ_PROP_FLAG_WRITE);
> 
> When we have just one use of these "static property" API in the code base,
> I wonder if we genuinely need these APIs ?

There are actually more uses in hw/acpi later on in the series: see 
patches 7, 9 and 12.

> I wonder why "line_size" isn't merely a field in the machine class ?
> External code ought to be able to fetch the current machine and read
> a line_size struct field, surely ?

It certainly looks odd from here: one of things I wanted to discuss on 
the call was how to approach the conversion.

My current thinking is that the aim should be simply to convert 
everything as-is, and avoid attempting any refactorings or converting to 
a device class prop via device_class_set_props() if possible. Otherwise 
anyone attempting conversions will get stuck in the details of the 
individual devices, which I would argue is more the remit of maintainers.


ATB,

Mark.


