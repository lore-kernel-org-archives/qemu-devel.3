Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2B3CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwrA-0002JS-QF; Wed, 14 Oct 2026 07:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwrA-0002JG-1W
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:09:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwr8-0003MY-3u
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:09:11 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E8Mm3M3222478; Wed, 14 Oct 2026 04:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ceUQZb/+uXyAFG6dehWJW59UQ6BGwcQSh+PNJeRoX
 Ok=; b=ylr4m+KzGyp5utofvPE19Lr/Nl302DEWXnGKlBXC0wXaEbSb5U3f8XsE5
 3UrXv3iZKNjIR0PlEs7v/fZYbLFhcIh+xMN2rneN+EF5dmunkRpQuC0px396/Jhx
 EJRDonToHcTWTJ2zsDEmb/XvTKiqWbfr5Vd++eByJr4PAfwQIUFIAUcOdG4r3gRn
 0PAT2AFmcRiwq+1Fy8vjNY1aCsDRVdbLJn8GKm+7ofF40V/8lkTBerEruYsLAiak
 unHPgZ4H9w4/NWA5MtMtrhGnf6fzPfHfm0J/uwXyHWDd3diqEJHcMn/c8BKAgEUO
 hDpwDt6z0rXawNmFjAX4kxwqDs+zg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022094.outbound.protection.outlook.com [52.101.43.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9qsxth28-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 04:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRCYMtkI2WQae9s7qEjNjDDL++K95zWEmMuBCzwqq2Hb1YpS2gycrfhh7E0Wevqh4D/nYN6LRYHhuF5AEErduPgW37aY0td0QnCjPtZ8uHz2YZ1bPGbjdIEl5mhcpDyQp1t2Fc23ebk/qveaR3bcOAhG/mdbC5njeq3NNAE4dYqi1xDvE9zePsIeV8I8/rIwZq/szAMPKgABwLNPj31rSguH5A1dQU7mBdA0SwoJqjyLF4d/Msazx97Dc7A3dVCaQl6iPw21ylXaSh17LCzJaFBMTD85ZgiHAXNS4ntfND5svZ197yFpcPFJV81IKp/JH7/qKuyl1+Sh9ge/hhpIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceUQZb/+uXyAFG6dehWJW59UQ6BGwcQSh+PNJeRoXOk=;
 b=Ayg5++xZJ7Y82Stbj4a6kuYLzQaDPK5Us/mCQNC/0q3M1xjh6nY7IXDnYIuQEFFUfb0ymzxo9QQD+O5fYLbMAbeiSqufLgVMf7fGKAYOFKEoJOPHvkd2uyaWN0PlNWkFPGXLJzSQK/Xbg7r0bQc4vdHRPVm+Hs0MsA3z0UfbZDAoMV9i+xvHlBbyJ3ylsN09nNonZ3LSRB3XjgjCcOKN8ZFkX6ATfpn4XzS5+CKoy65O4cCy6DOyC2ExXOWcXbcdIFZ0duZptDYfWwFyuMkAQFMOTnbqnl/98oIj9n+xrIWgmgekvXRO71mr6PzsNzonMtuTPW79j0x+i0aXtGPjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceUQZb/+uXyAFG6dehWJW59UQ6BGwcQSh+PNJeRoXOk=;
 b=vfAeEfxkjEdLL5PcSk8wTtQfz1u0TdaRwhmSOGWd08vjHfK3jZNoX6F6akujDSGINchpZytdmGiisgDTWJERPYXZHWeLRzwbm8xcRPjFIbbfwx2w6rd4vYLCHptwC/ISZYhIpjoA+/dZKA8qcuqfyOwa8m4PCoBcDz10TfTUI8VjpFHYopL8JwETYd5Ws64bZNaJcxWirXxgqDjDE/u+MmVrjVt/DosdElmCpYEpFCQ/a/8pXW9/zIU48L1rX17S3nXWCrG9w2nndVdrYVS63D+7KCxArt4oapjIpnQEZgavNSjQUWLb2xP9ASb+TmouBQmQDJNJE/9rp3fOF8Ybmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8672.namprd02.prod.outlook.com (2603:10b6:806:1ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:09:00 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:09:00 +0000
Message-ID: <c444a8ed-eb83-4a69-87e5-57c71f3a6d01@nutanix.com>
Date: Wed, 14 Oct 2026 12:08:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] i8259.c: introduce TYPE_I8259_PIC device
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-14-mark.caveayland@nutanix.com>
 <CAFEAcA-FFiWEs3ZLztVwZ72_TGLuhEBbfKnaZ3NFJJ1W-Wd33A@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-FFiWEs3ZLztVwZ72_TGLuhEBbfKnaZ3NFJJ1W-Wd33A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8672:EE_
X-MS-Office365-Filtering-Correlation-Id: f66841c3-b061-417a-0567-08df29e38c6e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: HjLh7jhzegQVsBLL20qCabp9QDW52mQPzl6qfFqadYGIw3SVglsTU+pj6VSfsWQgqMZXiXVrq22jsx8dkQdrj62EyViw3mneLz1rdcpBKBcyWHZ818oSH48s3xJVmnDE56tcmNlVoSbPN0dtWbzSGWtdp4tCfV3x5Kv+oC5YXEa2WTtt0Ka1itNDHGR+70vt2zi9vZfDIDlLZpRwINpiuGPbpbxODtoS/zsthQXWjU3qsx+8tlkzBciD8d4dUMjEhrHsJKAPgIMgh84R8/wfeJEdMnVGOtS1IiNni9A1fNDQSxeNuvR6e00K/0tQDvra8qw0DJYsOA7EBvNzunnxMHCUy0yGGY8fmFwTRFavo1CBhaQJyHy1XaB1oU6ltY3PnCtZ0p68l5WC0fsdYiRNcOtfVOEU2k9EoCiU40NLrk9taK6UBTEYJ2FvmXeCO+36SJ7fyglU3piu8gYeqI8SWlVgFs3gLT6zMkAp/n+VPE3tpHKdaF2wSWQpaKS6DRUFEw8q2RPHZsx3JsS5Fbl3Yc4tYXxjb3vPgoU6rxiB2AF1i4yb55GoglMOKgs3ZZylDTuj9mz0lA3YEse/WYtDZE5fdu6i3oAl6Q+g+29qH1xm3YdeH3aq9qz5nsI8J17awu2gpYp53jBMF2os6xLh2HTtq0odaLuj1PnwoFUDBjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktYVU1nbXAvUDdPYmxyNmhzZ1BiUmJ1bHdDQ2Evc09JY3JpR0dhVHhzKzY3?=
 =?utf-8?B?aEx2QTNoWDBUeXFaUVpucXI2ZUdLNC9DdkpXOFYyYzR4S0s1M2VnZndtenVS?=
 =?utf-8?B?M2M3U2dOdVVKbjB1WHBKc0tYdUVXNjBRWnRpdjBBMTBjQ0tLNWdERTk1UWJ3?=
 =?utf-8?B?K2pMdkQvTjMxYVI2MHp6V2RpNXFPZWE0T2JOTDRibzZ6VmZTMFcwYzBmRzFF?=
 =?utf-8?B?Z1RIa1Jqa2I5NFZCN0NxYUF1OWZuT3JUM2wvc29IU0orTlhhWjNCUFJRSFRZ?=
 =?utf-8?B?Y1JJM2hRMy9JeElraWREdjgyNUMxM2ZCalZzYTJrV3kzYXJOLzVaK3pSNldG?=
 =?utf-8?B?bkwzd21jNW1QVTZXQWVJbnJobHg2dlNTbnlRMVRtQWwxVnpYTWlDVk04Wmd3?=
 =?utf-8?B?THdOb0ZqZ2RQRDd6cHFsY2FZU2UxSS8zODlxTUl2SzNqQUFGLzM4aVlSckJB?=
 =?utf-8?B?Qnh3ZFpBamdiUjVVbXZpK0FvTnZvVUpqbUZhVzh2MDF4RlJGMzhrcGRFUXkr?=
 =?utf-8?B?Sk1WalRpVWJ2ZUpjemdtOGlxS3BOK0grdU9NOU5MV1hoamRCbHNSQmZ3RFdu?=
 =?utf-8?B?NEcxQTdKSTZnWnkveFNBRE5PWUwwa2tkWnRqdktXamQvS0hPYXE1Q2RxMW54?=
 =?utf-8?B?MG5SSG9RSVVhN1U4ODFKc0t1YkExTkVFSWs5WUNHcFpZYllHdXRIbmNZMUds?=
 =?utf-8?B?MWo1djc2LzVUcDRxQTdjV0s3dXh2bHRLd2szVTVxek8wK2FWZGtjaEliZkVo?=
 =?utf-8?B?cFUvVitmVE5uRENqWDhNVFdHdVl2emExTyt4SDdSY0FRL0w2TStwVndOWW5i?=
 =?utf-8?B?b0tyK1RYSzZkNGladjNnaUhyTzdMZ0o2MXVLS3F2L05FYVhQaGdQeW12VDBK?=
 =?utf-8?B?UExoRzRoaUQxME1WT3pYRHJIczFzNjA4eWhCQ1FiczZlZ1hXZkFZcG01a1hH?=
 =?utf-8?B?bnZUckN0YUFjR2NsM2ZOOElKZVlsakV4SVhQVHlFRU0rcnBFS0ZRV2tHWGNw?=
 =?utf-8?B?bVJTTkIzUlVLaTM5dmRwTUdyMkNodjdVSDhxV1FzaXNHZlVXVU1ud2xPVzVv?=
 =?utf-8?B?K1dMcWg0amRMa2V5YWlqZ3VPWGJiTGM2dDBmdnpVRytFYWt4UUo5dUxwd0JB?=
 =?utf-8?B?VEcwTjR1ZDN6UG9uN0gwWlZWS2E0WUJTZEJPeWg2RXdqT2ttdCtxYzRsOHRX?=
 =?utf-8?B?SjVBaGM3NngvRVpWSkMwaU9kS1hKeGZrcjBSRW1kTlhUbmpuMTgvS21PbFVi?=
 =?utf-8?B?T05yQ0VYaTIwOWZ4RGw3aU5yV1lDWk1yU0VTS29mQlU3R3RYS215SDdPYy9i?=
 =?utf-8?B?d0xKQjFOVDVodmhBdm01NlNzaERsZHNMbEJwandLdGlwREhMRTlmR2l2TnVm?=
 =?utf-8?B?eWpza3VndEJyS0s5YzZkemFpc1F0RzBWQTl4YVNaQXBTbHp3WUtoTlJnYzF4?=
 =?utf-8?B?L2ZzblhRQ1VZelUyYit5U21Eb216a2x6Kzh3dGc4cHlYRXpkUGpST0ZHUXJn?=
 =?utf-8?B?dE91WDhnMGtlQjE5YUEycHZmY0RYZEtVUEhXYSs0Q01vT3FtdTQxN3EvSjBp?=
 =?utf-8?B?cDhKaThpMGdMVTd0VWp5OWdYZnpHYnNOeC8wK3ZMUEdRbmhHQ0tVYkZTK3Rm?=
 =?utf-8?B?cmxBU3hQK3pCVmdrQWErZ1p3ZVFPZU52UTBHbXZjenF5djYzYVlWSFBvUWNw?=
 =?utf-8?B?OHBqV3llYTZFY2xvSFlBYm5ETjc3WE16OUV6YmZ1b0srMW1iMVBxaVpqaEs0?=
 =?utf-8?B?YlBNVFJTdzBPV1c0NVpqUHhZTW5PendnV3hDVi92cHdaZDVwY3hnTWxZL1Iv?=
 =?utf-8?B?KzFFUWRIWURKamhQcjhDajhBcUIwWi9iaXdlQkRwcFZyTU8zRHBsQUx6bFlQ?=
 =?utf-8?B?U3o0Wm56SWpRcDVEdXlEMWNTSW9ka284NTlUNDdPSnJBTXl6a3dSNTRJdkt5?=
 =?utf-8?B?bG02QkNjaUc3TnRZUFRWNnJkYXpCVFdoQ3V5QlMyclhsNnZTMUtsOE9BRG1s?=
 =?utf-8?B?QzlyaWZrUDNIQXhMZHNmTGFRZ0FIMUNSeGtYb0o2RWJKZGVIZjZXMnc5REdQ?=
 =?utf-8?B?TWwxMkhMZ0RxcHBrQjVPZThTdXJybllsTmpNNW01Q2ZLN0tGckcrclFGUlNq?=
 =?utf-8?B?RWkzK1d0N1VLNVVweUVDUFpoSkdXU2ticGVRS0JDYTJwVWFqQWg0N0Nma3hE?=
 =?utf-8?B?VTVpT01rWThtejFjWkdiazVFTWVHblpxY01ENDdhOVV6VkUxaXI2akRYRWtq?=
 =?utf-8?B?T0RzNjh0TTc2KzBEQTgvRndBZnIzWlFiZDA5TjFCcC9GQXBTWW4ydkRjaS8z?=
 =?utf-8?B?ZWYvdWNDMnllZm5QNjd4OUpPYWR4YWo4MXVUTzN5NnA3aEphUnhkRXp6MnRI?=
 =?utf-8?Q?iXuNHn4dQi6bwG8g=3D?=
X-Exchange-RoutingPolicyChecked: QFHEPuem7pTLVYjV66CSzeAKEdAjeEtAixGAZC/uHlQCf+fbxtykyzlLEx5PlkBeMbKBuBy9m5FQCWvzwjkxe00Hd0FrwHue6k/SqwLjSUJUZY/RdghttKG2dNvqAqalLNYd+T0tkwNVOW1zy5i1xTR4OnnNcBXxAbPYVZu8wlSr/7DS0VxwXgaYFeVUbs0NQdYBuoYm9GMrmis/yttC2TAx41Ihko/5iAnFUcefHGe3+W5jpfksDN5m0E8A1YGjO8wh0rEhv1mUU/VVihLTmrbRr8GdRd/MYGouXSEdU2rwCyga8FYHds4k7rF2YTzIMbhQlRyZxUD52JM87LZGww==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66841c3-b061-417a-0567-08df29e38c6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:09:00.2340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db4D5J+ml4jt604Mx//K2UXYPcjeEbtZ7IOMh4cpD3fbPS2CsC+ISM8gBAVNpaD1ynoWE91jYE8+alDaWCA8bXpjlLzbvSE0vnj6+pQLKMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8672
X-Proofpoint-GUID: 8xa-p4iMcHw0axHyTo0eEvtH_V9ZlgPS
X-Authority-Analysis: v=2.4 cv=OeYNnRTY c=1 sm=1 tr=0 ts=6acf62ce cx=c_pps
 a=13WRnYNq68uQF2pe1ZmaJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=aSKH6cZiDhi615JTPwYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8xa-p4iMcHw0axHyTo0eEvtH_V9ZlgPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0NCBTYWx0ZWRfX6wNEDceETEl/
 aNAxfKNBxtDexxKEJkqlVhPFblYmUtm0yEvZUhIwq0rb/HhyLI7cMmZiPAT+Bqm33kBvWcXSyvb
 1kG78wlBU1v2TzYSKHGPeu81cRNBIm/pMsUQ9Qg+RiEkNOrTFKMSx7U2wGKwTCn9fkiVCh8Lb5L
 4mRcTFDac5FLri4Tzsx1G9oNcsnNjweYSsP8z8xwJ/j8kYbl038lsnidqhps7dQxKQsZFpVR9RG
 GLCzHjhYV67ypwMQgrPfzTHGhjQ1X9RmXhhRIyJcGxqDWIIy4es+rdErvg49RNj+AiS1aIeFDQP
 62F59uEPDCT3RXEkisQiUq2HTmQSrGKW5WU4PvW0FWsofrnBWnUXv2u5okVXhtVUYUdOYUBm0Vu
 6npTH+ZIQrVEd0FilzIIKLOkt+EARAD9geYKPkNqvkZgjEUgTrkx7jcNC+1bvmAIgwp5CwJXP2G
 o3NxpgrArQk2tz72PTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0NCBTYWx0ZWRfX0E2wFliSYCXS
 wGJnEscOYPLlDBH6678XaCzUZ4BL8mE+swJn25Uq2VKaj7j++L2QtVpI1dLbrzcLcjTBfAafHo/
 2SVmq3DYqSjrAY1180CRyzDPrpIm5v0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 13/10/2026 17:17, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> This device represents a PIC for an x86 machine consisting of 2 cascaded i8259
>> devices wired accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/intc/i8259.c | 133 ++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 118 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
>> index af33b71591..fcc94e12f8 100644
>> --- a/hw/intc/i8259.c
>> +++ b/hw/intc/i8259.c
>> @@ -25,7 +25,9 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/intc/i8259.h"
>>   #include "hw/core/irq.h"
>> +#include "hw/core/qdev-properties.h"
>>   #include "hw/isa/isa.h"
>> +#include "qapi/error.h"
>>   #include "qemu/timer.h"
>>   #include "qemu/log.h"
>>   #include "hw/isa/i8259_internal.h"
>> @@ -36,6 +38,22 @@
>>
>>   #define TYPE_I8259 "isa-i8259"
>>
>> +#define TYPE_I8259_PIC "isa-i8259-pic"
>> +
>> +struct I8259PICState {
>> +    DeviceState parent_obj;
>> +
>> +    qemu_irq pic_out_irq;
>> +    qemu_irq pass_irqs[ISA_NUM_IRQS];
>> +
>> +    ISABus *isabus;
>> +    IRQState i8259_primary_out_irq;
>> +    I8259CommonState i8259[2];
> 
> This allocates only enough space for the common base class's
> instance struct, but later we do an object_initialize_child()
> of the child class. If the child class's state struct is
> ever bigger than the common class, this will break.

That's true. In theory this should be something like I8259State, however 
I didn't think it was worth adding a specific 
OBJECT_DECLARE_SIMPLE_TYPE() if there were no extra fields. I did 
quickly check that if this happens, then the assert() in 
object_initialize() fires so if this did happen then we'd find out 
really quickly.

>>   static const TypeInfo i8259_type_infos[] = {
>>       {
>>           .name       = TYPE_I8259,
>>           .parent     = TYPE_I8259_COMMON,
>>           .class_init = i8259_class_init,
>>       },
>> +    {
>> +        .name          = TYPE_I8259_PIC,
>> +        .parent        = TYPE_DEVICE,
> 
> Devices that directly inherit from TYPE_DEVICE are awkward,
> because they never get reset. Conviently this device doesn't
> currently need a reset method, but still, is this a good idea?

In this case I think it's correct, because the PIC device in this case 
is a container for 2 cascaded i8259s which are connected separately to 
the ISA bus. Therefore each i8259 will have its reset triggered via a 
reset of the ISA bus.

The container itself can't exist on the ISA bus because it would then 
appear as a separate device which doesn't make sense in this case.

>> +        .class_init    = i8259_pic_class_init,
>> +        .instance_init = i8259_pic_init,
>> +        .instance_size = sizeof(I8259PICState),
>> +    },
>>   };
>>
>>   DEFINE_TYPES(i8259_type_infos)
> 
> -- PMM


ATB,

Mark.


