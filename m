Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2175C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7Z-0004IM-BM; Tue, 22 Sep 2026 06:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7W-0004I4-P1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:53:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7U-0004cb-WC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:53:06 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03Uw42448167
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:53:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l5AUnmGHXioqzC/18cmcMMO4T+FnLNiOyToGLlSC6
 OE=; b=c/jx32DN3cAc25cElXL3JBZI7q7r4A+LFiCWyHQ9KlJbI/QOFA3Q9vzoF
 b1rumhn/8d10wGZy5oGoir2aGs4KmDyRPVbAwjZUcLV8saLG7qakot+tgaKOQZKk
 e82OboOQ+/hxeR55cmFwXtuoG50BrUN9oFwdERp8OzS7zntxT33Ys7m5gv8cjlXU
 PUHyEtBuyduTwAvYVMNHYxwj4N87PNgz/zXUrTeg3PIeeEkjxHR8elA7nXV2CRNs
 0OvzN5Hh7yuyP1wdWmyCURiuPb9PS+ZZskm1HNql+vvKGUCS2oglLByxXHJuNDYe
 s2rjoePeU8PmNk/J3QmwJpW0KXOxQ==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021108.outbound.protection.outlook.com [52.101.57.108])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5u1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIlHPznsKrHMivX5IscDmmT2avxvAjyuhNMvK/lNYhC0lDVBbnPYTYnlr7f5BcXtMsRA6e9b8wwMM/O3LfD1yb/z9mkkdLWLD7+WFVCusdeA28Po9KNb5j7sWGSbDJhXwI7yxscsGnV7w/9pvmwJ1xTKXA1n2adpqKIgMe5M/vlNWz+A+81wPiORH8GA0xa9UMribhF7okoHFFZtGgjZA64taJDURCN7Upiia/V8523B/W1RYdazLMduX4ahmW9+HrEoOOLaR/SFzX4k8E6OFwWEbtV4uK7L440RMKDMKydgtB8QHWAKWAeOJ0EuCZqIQwiz++lvJltIpNP1cbonkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5AUnmGHXioqzC/18cmcMMO4T+FnLNiOyToGLlSC6OE=;
 b=EKUp402YECl0WLmPOYAU0FrJHwV631GKNhmKukzM96urOK7rG/gWpM+/wzuvJwmqZWEO0IvxRY3D8vJbFRUnTaCqzTXkgpOPuD/VqZKh+IY9sFzkVlhdPLi3hyMCVf5LAselcygNdHYBnA180YDR4AbeNYIzrYIvgOCdlbA+COMZBmnaUGXBf/DMCAINphDGziEFAL4FEzs0XCMqi0OK6POoAUKzh54XQCKe1mrn60efIOjCsNJ9tryQUJ4G2fWoy95QbbrtVxgMUg1wv8BEd7WJtfPdPqkETZGkV7Q45I1eC27mvD5W94QtEiWy88/s2hQGniOvyUgwZj71upNbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5AUnmGHXioqzC/18cmcMMO4T+FnLNiOyToGLlSC6OE=;
 b=NoM99qWkriRMyTUcTqp1W10NuyPon5x8HTn2CxX4KwNsxmZA4MpuOAEsRCFMJ8pyb1WSli1Uvk5o1GhqCLp/08yF0xZpriOcNMvK7YK05DKNPI/XoJZFcs3jaYC5FlEIp+D51IRfbBOrvw54iJCuIjYUOv7xxJwvLp6IKJnNXJq8LsESMYeLoKxSFj88S3Y6vy1Qi5iR5m4n6u3AnEtM7e9nceLhKA0hogxDbUkTEYBUjEH2q+HCyMPPzALGCI+Hwx+gBkDqnKvbHBJXH2j4JrQibzwc9gGsqFsk9RG4/s8MQtY74vNnLw87d+JS7u/qac8sqFPUO4v2pklv/lkzEQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:53:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:53:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop
 to class prop
Date: Tue, 22 Sep 2026 11:51:38 +0100
Message-ID: <20260922105223.1607725-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7137aaff-86ee-40ff-2ed4-08df1897ac4e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0Ex8IhU8qbvb09WlAzhV2AjqdHHIFk0u0Uu2XKyX2Yg9lNDfIru2fX1SZ9SkYtcvdx9pFI6Fz3W+O/56Svzw2rF8zbI3GrPodvTkJiq1ca28pmp94cNGZz3GXMjLLkMquSbKGWMWTBw5yvk4K1kMA4L1ptZatUeY2UxbL5G1pyNZnU+JDmYFwgSZ59X3ViGNkgpN8MnFrRFgw9F/ehBOHMZ0x/QphdfQ3mrlgzp7Xz1DiOefEL+K3Qi2ZtN+i0PQ4LgTaQmdhUJbEMczKSYvPT8TB45eu3ZfyBu3yatYgQfuYR8kI7w4BgX1ovHd8IngPfR90mW0oZR9WJb55d6a9M495YhY60VhH/81Nq3PeaAerDw3aa19sqL5h+paKjIckJEaZRf9p/CceDj4QHmRSLUaOUC/2v+ZKOJlWlARYQp6EBN5yXEl97d3j1sRqbpnZOZV2z+njW7/5n5vpHixJ39E2Two0MxAHqEuyvmBBIwGfYB/FmMws8vYs3LggjERQZQcT365HgeOGoED1VNwoO7nmEXvkxL1+cYIKSeXhrh/Dk2kLPzRQTlolxpx0G6pVb+XA6kxFA2CmfW9fgMTV0OhvZY5XxOEorx8/GYJopiIL+IYJ2szmOcQc8x0X35nwHIfOURKamKmyEOAoKKpJ25qjaar4IbxMX2d9k7yIbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXU5U3lUYUQrckpOUXpiYitrL3djNTNRRW9xaFlyeXNjN0pxMVoyc3Fsd2JS?=
 =?utf-8?B?MGYwcXF1dzJCTXFYZkE1WmkwSjBKay9XekdLaU0vSTlrWTFlZUw3YVVsZ0l0?=
 =?utf-8?B?RXVwc2xrYi9nTEpmc3NwOVZKTEowK1FJcTFpZkIvRUNzVmhHSm1hTUR5WjEz?=
 =?utf-8?B?c0lqRXFyZG9WY3lKdDdiN2FtY1IvZGRsK2FJb3pNdEhEa0tmeEZMZDVDTXU2?=
 =?utf-8?B?b1cwYVpGTXIyM2lXYzk1MERmTEdjNWR0cE4velExNWxUVUdNVWlwaUR4bzQz?=
 =?utf-8?B?bVpzUmJ1a0paSkZoNTJFaFh2Y3Y4ZktNdjZQOHJ1UlZSZDFSN3c2c3RtSUw2?=
 =?utf-8?B?WUtSbXZNTzRoaXkza2FTUEJJMklNNkRJcm0zM2hLZW1KTjVDb1V2UjgzRUkz?=
 =?utf-8?B?ams3RWlJNHdnSGgxZnhxZk96MHBYNFNRa3JLTDYxbkt5UDM1bVg2VGZsN2po?=
 =?utf-8?B?d2N3LzErbUdpdml3ajUwdEk3NmkyVHJvR1pSWFp5Q1U5bWs5dzFRdDJ3THJr?=
 =?utf-8?B?cnpVZEN4ajM2bG9uMFVHdy82WERaOGtOLzlrNWU0SFJVMjZoOUZTVVVCSkww?=
 =?utf-8?B?YS9aYm5sSUlHRjhSZzdqSWxxSzB0TUNRQ1VqbDZOeTlBZUR0c3ZkSUVQZVlB?=
 =?utf-8?B?R011anlTUVAxKzlTRkttNU5LM0w1WE9tR0d2UjZXd05hU2NveCtqbnVNSkVN?=
 =?utf-8?B?MjN6YXVwbWtFcHg0Z0ZKQzVYVUtveHdwZVdpc3E1bncrdHA0Wk5ZTlBmQjZu?=
 =?utf-8?B?YVFFajlBUERDbCtlOEt2eTlkakJwcVpSRVhYNnp1aXVtWkRWNUYzUmJXMHI4?=
 =?utf-8?B?L21vWm0vYnp5RUhjR1czSGtlK3BZY1hzTHlFUEhoQ0c5TG9BZ1oybVJsRm9Y?=
 =?utf-8?B?WGthd1pma1RUcGZ2NzRVL0VTamJaMG5NSHovU0MvbHNGSnlqbEZFdTJFVXNn?=
 =?utf-8?B?V0J3aEhOUnlDMmhZVkg2TWxVMEI3V0FSUTNNL254bGlLb2c5VFIrQmV6dWNw?=
 =?utf-8?B?NjBBaXU3MExkZTVQSHVtc2dESUNlZmdOVHhKMGRsOHFUeTRJcFlpaWFCWFpY?=
 =?utf-8?B?dUFRMzBHQ3ZXODVhamRLT2NRNVZFdm1ZTlU2eEEzS2JZVUtmYWUxa1YvR3lJ?=
 =?utf-8?B?SUpSMmFhSXlrSVdqNGZ4d1k1ZElEQXZNUytQZnJDTmUrVDU4SWNGb0htSHpK?=
 =?utf-8?B?b2hNOTBrbFhOeHFZTEJGaGU1SUFDQjJEaWI1Q1RQbXo3RDFNMnJFMm0rZUhs?=
 =?utf-8?B?aWJMVVVYS0tyalVWVHQ4UlFCKzZlbHIvSk5XVEVndUwvbno4amZzSkJKSTRK?=
 =?utf-8?B?QkpUOHhwWXBJQUlZVzc2UlpBUUg2UVc1blZyRDVCTHNLOXBNdEFqUjBxd2pC?=
 =?utf-8?B?ZXBSdFBSdnRKQnJqd1BqOFZPd2V5VnNKa1N2ZXRiN0pUMCtNZDBlUVA3N05i?=
 =?utf-8?B?dGVQWTV4RUZ0TWRWMFRLcGZaZDhDNXUrdHNQZWRCMmxILzFlKzYycTJySkUr?=
 =?utf-8?B?UnhvM3FRY0VoV210VEVUeUlrRTRYY2JnMitLVnBKSG1rMlNUQW9XWnE4NXBh?=
 =?utf-8?B?ckZXVXdWZ2k1RGtZTFMvZXpnVHhiY3ErSTRiOWpnVFErWUpjejA0S1RBeWdI?=
 =?utf-8?B?NGhjNzNRS3k0M1dyU29xd21EZnR2bEUvREdGdk1TZWI0K1FhSXpCQ1V2OGtO?=
 =?utf-8?B?c2JJUUN1aHZES3VXa0w5d0JYT1ZzMmpITm1LSmVjcVNqM1lHQUZWclYwaU8r?=
 =?utf-8?B?TTlrejg0dUNBMEZJc1RvMDJ6Q2hUeHJPL1ZMYjhoN2VialdCWEwxem9adDFT?=
 =?utf-8?B?VHZqMGhjeDQ1YXRZdVdoYUZ0SENhdDBvUDgzVTczSVFMTnlkcG1IUHNXSWNU?=
 =?utf-8?B?b1lia24xT0dSQ1Yya3FBSGhwaHBvN0RYWjhsVEJTa0p3RitFeCtzdHk2VEpj?=
 =?utf-8?B?aUY3QW9zbWZBRWpBZTI5UGlvNm5SM3IwcCtObVhtU01wbEZYYTRCTXR3T1Fz?=
 =?utf-8?B?bWZWcXVrUXJOWXZLUUw5dEtTVmJMZXhpM0h5SkRSZzczVHc3SHhqT3JMOUl2?=
 =?utf-8?B?Vll6SDRJVTFOS1J4bHBhRFdURTdWaWV2NitGdkdqbHlIZGF4aE8ydXNrVU5F?=
 =?utf-8?B?UHA5SGtXZmNzVVZ6eDNjamk1bEVLOW50N01tR1VvcXE0Zk1jWFNpdzR3YWNw?=
 =?utf-8?B?ZnFVU0E2VzYzS2F6OUJvSnBLRTZEd2JqbE51WkFFZytNaEtWSHRxMmlMRlov?=
 =?utf-8?B?Mkd5T0hreDczeXZlREUzMld2cXU4VVYzRjRwQ3BpdEorRnAxV2tQWUZRM2tP?=
 =?utf-8?B?R1BhOGo0RndWMGt0WUJrSzNWNG8xblRaS1I5NjNmeXpJZzI3Snprdms4bkto?=
 =?utf-8?Q?8+wlAkWX2qUcNgo0=3D?=
X-Exchange-RoutingPolicyChecked: XusVR0YFJXDfv2mBjMs/lUi4IkmQ6c2mlfMxKY3Bv1RV481erapYOG66/Z5zm3cM+7QwseBm6s2UrOezSt3R2OlMl6Uhh8pwTOE5xDHfeHedGxAcQfCjj0KYEaz+KiBnQT1JLtlsG249bgOAaUHcGyHnujjQchgnT/cRSYCVO0Xqq0Gynkamwgwf4lSRh8P90coT4evPrp8sX1aJTYmyz1aFjaJGWWa/9bDvtjXwn/iNjWaBo8qMGJFx5+7XStv8FCl2xlvo/OlzZQbSuAUVCfIuVSHLjLdcPn8mznCiamokzHyQNTByjJelLX7/Zl0yfW0jv+0x3XWLIA7OL+gNKQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7137aaff-86ee-40ff-2ed4-08df1897ac4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:53:02.1137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hxmp/qWO9Esr8INONj8SwqtW4y1sFjYKh51BvxPJxOQ2JTA19xtzf7snL69k7TbKitVF1yTjrd4bmsVvqnSU4P/mNnEOHmBJAMcljSB4T3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfXzSZCvvgX790z
 A7yPagOaxNPhHL2mIdC59xh/EZGiXBbgsXtXJMsYAxI8MyPYL/2Objb809S5di2onDFwXLpvE4N
 dACBH4pK8UYkdUJlAKW1si7YXs2MbvMaPZotmN9mRukdRpWKKUfsLA4FRmxI4XFQMbbAYG6YO4M
 Ndrrh67v14PBfMoT2InfP/2/ben6173gGupiWkxO57KzAb/3okgO2yaObk7xKKNTe0Nqwe6fxdi
 r2aYk3Hxj9S2iZkt26f534jAW4tJ3M2dDDzJiOeiOchX512EgEkXjnfzIxes1QkuZQpEnpzFYFo
 CHY7YzL0vAyr8WtIK7YnWIMnMjJil0B1v8cnON9i+HuTfrYpxskqcaKvK+BjEfjtvPywFEUg/AW
 WwBmjOePk0vdp4kFplSqTEyw/mC0B30RQCpXnYZS1bxSuYts1l6kkOGoR5PWNRacbEQ/eKsAeHp
 tr5iXlIvLm6lMqQrW/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX8K5oxa1lHDyi
 lA7Cb+QN82UNuKS/XFpKfaZOuVjtyvzj+yhtjmXwOO6mzv+GHTBQtygoA8nmeC2DgoVvD2rwN6Z
 6U1mDl8UiblzuzgpPLL4dSkCQ69xT7I=
X-Proofpoint-GUID: af2rvU1b5MevLZFb-3FUfQz1GaHlgCX1
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25e0f cx=c_pps
 a=/gzcr7A8fs5QGI99pdRdNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tlSEsSRgIMY7PNDPInsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: af2rvU1b5MevLZFb-3FUfQz1GaHlgCX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
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

Remove sgx_epc_init() since it is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260921113559.1299740-10-mark.caveayland@nutanix.com>
---
 hw/i386/sgx-epc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c..29cda843c9 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -41,12 +41,6 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void sgx_epc_init(Object *obj)
-{
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
-                        NULL, NULL, NULL);
-}
-
 static void sgx_epc_realize(DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
@@ -164,13 +158,17 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_plugged_size = sgx_epc_md_get_plugged_size;
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
+
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              sgx_epc_get_size,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo sgx_epc_info = {
     .name          = TYPE_SGX_EPC,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SGXEPCDevice),
-    .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


