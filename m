Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D565C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tmR-0001fj-CA; Thu, 24 Apr 2025 06:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tmQ-0001eg-5a
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:26:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tmN-0006yQ-Jg
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:26:05 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O9SsDP025275;
 Thu, 24 Apr 2025 03:25:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=72CfBrnIkrZ2V7HWN+MTFg+kBUNZAFUmsIAzO+mHm
 /c=; b=zCU8I0hg6m1I2LAMRxPY5Y/Exh3GGG+y+EU57pWBTwjASFQHK22QN9KN5
 qT3YKVjK3UfRxuk01+UtgqKugtnCtyy0bXFfrGmNiErr0+NNMdDZLVvY3pdV/eS9
 gN5tPvCqk4YNwxB7RhpdTB5SS2RIuAzoeR06S3FHbXCqHXtKUwp4TJkk0NtUCedo
 /wdxUDmYu/z9BBqdVSFwZhoUp2KfpCdx7NNGbVqebRBGAO/82CQPdsSgPEKeDwTk
 kwNpXeJRA3LMv0ol+6G6Jo7aEN18JDnjVNsTluDXsdJ+nyfFZt08jsjO2IPbu6D6
 NgRZ2bJl03EBymmMZ6Il5X7BqzEZQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvm4vg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t08QpImJdp8onnWRBhuAxK6C5c23bp0GrxSrNxAeqxXNOBCepBFbbALGue73Mw75ILbEJ7KsZcBAfnkkFqENpFHPlyWkPCIvqj8CkDZYNnNhMKPUKBp7ck7CvpkwpUdCh1UrXwmqzR9wIEhNOsZoMPaWKOoU53teHn04Bfcn0/Mzt5s7rQs2DLBQgWOZf1DACuEA2pflxTL4p3ceM7kar/YhIk3iyiOeTp2TCyDPguZpKTm25+HI1IlHGncXXuaHHniv2I5/TNDweY6TqczvRHmO1q21awAAG/TLYZeH6Zm1mbBYvAZ4DnUwwiQeR98kVn6F8v3JlCP14zZrzDO1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72CfBrnIkrZ2V7HWN+MTFg+kBUNZAFUmsIAzO+mHm/c=;
 b=E+fp/x9R6LOKpvm/n9E1PNDd817NHkrTMGQdngtru7w6+8TaigCkcFvr6jNXfSo60kaR+WQWMtEHla1tM8r9xjqSehU6NKdFej1rTVo97G94p27WBsacSmC/Um8ySYH5l2e3KqFGl/xmoTRDYOIK/r4qVpWjD8HtazMYx7FVu7qXw9kMuDyuzLi/T2wwiu3+Kw19NIZQ6meXhbC1PVYEGq/Q50kz4l8OFVu9CFQlO+rbyruhMwUJeeLdPNbJsR4A2Uva7FCqjbfYKzJVOfpTKhCNxDX3DV5aYnGWsuLrSfcSflvRhoDe/IbURMP49UI0YFiVjsmnx28AUOu/80HxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72CfBrnIkrZ2V7HWN+MTFg+kBUNZAFUmsIAzO+mHm/c=;
 b=YPQATf09oGUSY8bqs7ebK1ngIVfHLnS5N+y9wgFChLqVX0ALyqGhuBNF+91E0aq6W0P6JVEaC8PXODgeVs9lEVehuHshzbL4kms8HHVz2X5eRxlo9UL083Upxe4cLvh8ZP+6L1WpoIlkOqZRob/Qw7OhfUKLuX601FayGymNbDTs517rtL3txhXEZn4tJzvL/YP7y0fAMRwkVH3+hx/E4OVeCsIblsFVYi4/ZBshjEfQUWDruu/3vw2LyZWeGGrlF4ro2P8JPxMnttP848C6gqA7JGQ4CwhzQXjpSxcKo5MhXwf/A3ho5RGnngVnC4uhT7GwdGtC6/lidFFxUdVGrg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 DS0PR02MB9175.namprd02.prod.outlook.com (2603:10b6:8:13f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.9; Thu, 24 Apr 2025 10:25:57 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:25:57 +0000
Message-ID: <48c9de38-a132-4b9e-8683-c24b485e0d6d@nutanix.com>
Date: Thu, 24 Apr 2025 11:25:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] physmem: Restrict TCG IOMMU code to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-12-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0002.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::7) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|DS0PR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dbed27-892d-4892-9a12-08dd831a669d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVRZb1d0NWoxQitBaXl1MXdVRHVERlVsR2p5ZUdxYjZFVHVZQmJHVUNueWZU?=
 =?utf-8?B?a3pQL201dUNpZWc1UWJKV0plMWZWM1dZZXhNVHF5WnZrOWhzdUg0M0VYN2Iw?=
 =?utf-8?B?azVURjFXRFJBOWhHcldKS0JlWDlWRG5UWEViVHdZT2dhYlA1czdvZ2RYWjlX?=
 =?utf-8?B?MGx4SGN0UkN4YXFBYnJyUWNTRnRUdS9TVGhxNVZPQ0wzOEdhc1FxMlRHR3lR?=
 =?utf-8?B?aE9yQnc5dFZPeWQ0UmpMMUNlUExjQXgzYXQ4Q1F1MUVYc2ZNbTIrVDZVK01a?=
 =?utf-8?B?N2VEMk9BS1lzQnN4UW1DUitzTStRbjdVUVAzakc0d3NqR3lyRUNaR0x4NFdS?=
 =?utf-8?B?c2syQXRyeUxuTGNvWENHZTVSUUZySzBvVkdxWVlZVXBYRG5EOUh5MUNvK1Jh?=
 =?utf-8?B?WlgyNURNblhvdk9yOWppVnY4aXlEOHJtdXhhWjZPZ1NYYW1ienFoYTRSdmd2?=
 =?utf-8?B?c04wYzZycGVKUmRYNXBNTldibWtKc1lQL2h1a3NENDB0b1A0anF1UVRNSlN0?=
 =?utf-8?B?ZWJQbnNjTmxtbTZwcEQ1dEk3MkZ3c0U4aW8wMlJ4bVo1OUpQUW15MzB5TXR5?=
 =?utf-8?B?eU4wK25LeUZoNE9Mb3d3K2hlbnpXem1tNGJTQ09DUXFpeFRPTzVXSGtlZnQ1?=
 =?utf-8?B?ZnRIMmRRUTRsYzJjbVkxUmxGZnc1RDBqVjRQbVp5eElxc2hJVTgzUC9BVUE0?=
 =?utf-8?B?SmJrSWNTTldRTEFHeUVCeEs4aTZENm4yOUVraWVrcnRob3R1TXN3QkpCemFq?=
 =?utf-8?B?eG81V1RGUjN2SkRIV3NKa0Z6bTBNdUlrQ1ozZ2h1Zkp1WnB6RUNQNUdSa2xy?=
 =?utf-8?B?MFZySmJrL01jd0J0K2ZvMkh2c3grSE1GMUFIZ0ZEV1BCeWxheXR2eVpJWEw3?=
 =?utf-8?B?YU5CUlZmOEJpWEd4SG9YS0swK0lNSzhMN0dCTk1TMjA3OW90K0VtYVZSZGRO?=
 =?utf-8?B?cVhBeWxDdVhFbW8xanUwdUViUUJUdzV5cTlhTjJGZCszc1FuZm8wVms1Rkg2?=
 =?utf-8?B?M2FtTWoxTXZNQ2hJWGZHb25nNm5nNTJJM0RmVTBta2R0UTRGR0RSU0ZiS1U0?=
 =?utf-8?B?MktXNkZ2SVJJWnp5eG1KbEs1OGJ6bEdRWnMyWnpZVUU4dkZTZ0g0aEtGZk1u?=
 =?utf-8?B?VCt2ZWw4UVZHUDl0MHByRUw5UUdCbkRuMGRIdzRpR3M1VnR6Z2lrd1d0OTNG?=
 =?utf-8?B?dGFBVkhaaUM3QzZBRHZxU01vVXcra0YyRXJuVytFSldDVVdkOG9GY2ZQNUhw?=
 =?utf-8?B?WVZnWmlTQVpJTmlHbnNld2hFSERlbVQ2MmF5RW0vSXlTckpTY2JGd0x3Skwx?=
 =?utf-8?B?NGY2M3NIRVJucXFIMzYxak95QUdxYTFUK0lYZlIvYlMrY2ZJZndtR1JjYnZJ?=
 =?utf-8?B?ZEhWM3F2TEtlM3g1Q3pZc0cwSVFDY2QweXBVOUxFSDZMSmRvdWs3TFdNc2dR?=
 =?utf-8?B?SXBWMXBGdlZEZTd6UjhaYnY4cnNNWFQzVWIvR3UwcEdVU1ZseHNyYy9kRlNS?=
 =?utf-8?B?NGRrYmtkZDNxRlRlWHI2N0s0WnJ4OTFWYkIyUGRqcGwzNVlKa2xlRDF1L2d4?=
 =?utf-8?B?NTlRbHpNeWZQUFRjVSsxV01BUkxYV3JRMHRGR3JYbTUrb2UyVkprSHo4VnV6?=
 =?utf-8?B?blRLc0wxVGVXUUdkQjBsUzg0Y01OalZUZDhKQmF0QWNFU05jUC85SjFXTm1D?=
 =?utf-8?B?bFhzZXFQTEdTaSswd0NoYkNHNkdoNWZFT3RlQ1ZoSGNFd2xsaEx2UW1RN05D?=
 =?utf-8?B?WUJXQ1ZNQ01ObGZuNXhsZGxSZGl5OTB5S0Jyb2I1Y0YvMkE1UXBrZ29WaVFm?=
 =?utf-8?B?cGlaY0tPNVA1YVY3T0FMK2ljemgxb0NvRHBzZlVJWTFSRVBuZEphTkE0ZXZZ?=
 =?utf-8?B?WVJTOTl0WXFhYWZmb2hIS0xVNjBhN2RsSm80Yzd2b1dVUnd1eXloSktvbFlH?=
 =?utf-8?Q?hlcy5eBYYpM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnc0aDFmREVxMXBoSXFWVlJSRythWmlXM1k2VXBtandCZ1hMRTd1c3kzdVJC?=
 =?utf-8?B?emxjRXc1K2FrZWt3Q21vOTYwNVBvTWo2a1lPUzNiWGVHSVp3SHpFR0JNc2Va?=
 =?utf-8?B?QVVtVW55V2JZblJIZTRkVndzMldtTG0xR1dRSHcrMVpaNlpqb29CNkQxQThH?=
 =?utf-8?B?VDhBdUpYK1FhY2FZOGxoU295RE5DQm5ZOXM3VFFaMTdwUzNwMnpYWFJjNGdY?=
 =?utf-8?B?ZlcxWXdic2R0SXZtRDFQbFlnckhSdmNQT1NCQUNwU0J6c3ppVmVUbFR1QjJq?=
 =?utf-8?B?RitWZGlWejA0b3h0WjMvOTJBVDFoTi9tRGozVDcxK25OWllIQlp0NFRBNEli?=
 =?utf-8?B?UEhFeStjSEZEbEljQlVBcHk4NVA5N3BoMG8vQ0tNWkNneGRYaDVVL3pxeG1n?=
 =?utf-8?B?SVc4NS9mRVZJQ1Y4R2lMOC8wanVIb3pLM3NtYm1yaEFqV3dyaU8zenZOMFBL?=
 =?utf-8?B?a0w1SDRQOGZpWXhGT0llQ0VBeXBKNU9LOFJwNS9xa2xXRW9BVm8rYVVNSWlB?=
 =?utf-8?B?eWdxTDNqd05DMjRIVi9qRXhKaHRMMVVEUE56UTFYMnV6OU92YU12Y1ZMTTlq?=
 =?utf-8?B?aVpvalJjbXNaRkNRdXB1K2ZCMElrTGhvN2RicnRRQnZacitLbWlNMmUyR3hC?=
 =?utf-8?B?dHVENEpnamxTYlNrREU1TURUOXgzTUJIa2dWcFRkL1VpcktqSjdEUzlyQTRT?=
 =?utf-8?B?M2crcUw0VUJ1U21EVUMyNGNZZHFUZVBzSVhORi9MMjNzVW15N1RubVo2UzYr?=
 =?utf-8?B?di9VYWg0cUd3U0M5TDlHbGZtcHRWZ1N5dVA4SVBkMDdhb1dYL05BQlNrOXVn?=
 =?utf-8?B?SmJuOEVpWDRuT1I3WkZsVHNXcDBkaithTUI3TnJVR0tDRUtMQzBuUjZ4c2tX?=
 =?utf-8?B?U0hqb2ZkNXNJZ08wSG80ekJUc3JHMkV2VXZIOERNNlBnY2hEYlVkMU9obWNX?=
 =?utf-8?B?NWsyenhRMG5xZEx6V1VsVUVyYTBlRzVPM29KZzRzNHZaWk1qYTdVT3IzdEtq?=
 =?utf-8?B?cUhzWFY0ekp2bkNRcHBvRzVqUVA3MEtmakZkSUEzV3k1NmRQUGphZHR3MFNu?=
 =?utf-8?B?ZVFXT0VFbVlKeHBkR1BULzFzeXlndU5DYnl0NmlYSGZSVEhrbXFsdkd2VldI?=
 =?utf-8?B?UkJUTVoxYnhOb01mL2lQbVgyMHkxRDBNS1o2b2JjcG1Lb1dHSmdIcVdDK1F4?=
 =?utf-8?B?M3N4SVBacFVNNmwranJpZ2EwR0pHdXhyaW9lemN3RTljMHlENXZsa0h5cyto?=
 =?utf-8?B?c0M3VVRHMWpjTWVsc3VHbHNBdk1PUjdyZy9ncHdRWDRTYnVnR0xMNEtSaElw?=
 =?utf-8?B?YXg0Wk1lNlRISWJrR2xPbmtybEtMUmZjVVhicUk5YXh5aDJjbmsyVE01dkZr?=
 =?utf-8?B?WWR6REJiam9GNHFGdFEzTEo0UFZCR0ZCQUI0SXNPSkxQSmZMOUYrdnIrV29J?=
 =?utf-8?B?ZElqUlk3ekdaSUdLbGlwNGh0cFdpaFhjMTcxRnB5L2JCTDNlUEtZdHB4Ylln?=
 =?utf-8?B?eGswNUViVTlmNmhpQWxlQndBMFRVQTFVNTY4ZWd5TXVVTWs0VjRBOFVJSXEw?=
 =?utf-8?B?VThya05KSnJ5ckp6TkovUFdkSk9ZQm8xemQ4cVcySytyTmZJMEpnaVpTUkNl?=
 =?utf-8?B?YUZEZ1hJVWpXdElxU1ZUWXVydndvUXlqeVZxZ2FlQ1g2TlJYSkRQeU5TYlpy?=
 =?utf-8?B?aXJseXdCR0hJYTdJcWFtb3RJcUZoYmZTVEErSFlmeXdxL0NKaVRNb0RTZEEw?=
 =?utf-8?B?VEsvUGpxRGRVZHQ5SHQxUzloMFZnN2hMMHVYU1ppU3E0R1Y2TEJlYlhPSlNu?=
 =?utf-8?B?MmVKUlVmK0xhNFlTZldxNVJ2WmtlSi80WnVzN0tOcjVCSE5Fa25FYmt6VEVy?=
 =?utf-8?B?dWZmbDVCZklnVFJ3dWVRdG0zSEIyeTN2Y0w0blN0b3NVaU5Nak1FSE1YT1Nw?=
 =?utf-8?B?MFg0RDhBU3R2LzlVdUxhcXlmSlRvQ1VhNjFlZUpqcWx5RVZYT0l5bSs2R05O?=
 =?utf-8?B?akRHY3lEd1J3WTFWY3ptK1QwL2kyS1JGSnVIT1lIRVBxVUFwWnBTeDZFZzhU?=
 =?utf-8?B?TkpiVG1XNm9KL1JPak1QYWVFR2lraklFdVRsdnNKdFlhNlZod2dwcXhYNUFl?=
 =?utf-8?B?QzkybXFsTitoUGpwbzVENUI2T1JvM2cxTURLNStqNjFxbHRmV29WUldJakhG?=
 =?utf-8?B?Nkc0MVpPZ0tVSWpKZnhFbkdramVkZjJ3ZTZWRnRWekxjeEZpR0FtcWsrNFVr?=
 =?utf-8?B?QVR0andvb0VkRTM5NU9hNGRnNW9RPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dbed27-892d-4892-9a12-08dd831a669d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:25:57.2624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKdth4aImQZyoYq7vV0q5qDRDpy3iVAg4MBEJpsq0VGydLHXtgz1Ckv7oYkOXYePI6zzzEcZfvJgxJ6cFfnAqasMZWnibEQkBYLGv3XXUFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9175
X-Proofpoint-ORIG-GUID: h8pZn0Mnv-8xgc6mkhpigwBuJh1Zkb5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OSBTYWx0ZWRfX2blZdFWpCWjr
 hBofXNQLFkcWUgySf3uJqPQEATrCx9ilUS/Wf/pasA5DSG0uYTtbNM8cgM6t6YFLCpRMcUMdPr/
 t50Z7UZZjqm8hrzuu365midi7W8upqp/z18aB/3iYt8eJzhPTaosKzqTvbb4EaVPMrOZOQnHPh2
 QDpc7KeI4i1/Mv0v2EJOmq4lLHlSX2dk6dEFXmaipDUxDlj6Hv09ad8GEm4ugzM3trQQd8V95sK
 EPnYnh5yVcRiboZWsEGOArVsMTXwFnlAu+FnNNvvL8YXWXgjk7cpz9mfnQcEZE6KM3L/+cfwtwG
 37rv+ejCr1/IXhXl0+uuxr3H0En0RNmt+61IL1uUa0j1u+9FqGTcCPir3MQJ7/pmW0E67O2cvpa
 ZKSjTxZ+cNcJykNzchgfHKLB1t07Q3V8HLh/2hjFp+uAAYSh4W1gL5EiOWe/Ha71yRQnqZE7
X-Authority-Analysis: v=2.4 cv=U52SDfru c=1 sm=1 tr=0 ts=680a11b7 cx=c_pps
 a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=VEwmlMsxND1QNdhebc0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: h8pZn0Mnv-8xgc6mkhpigwBuJh1Zkb5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:

> Restrict iotlb_to_section(), address_space_translate_for_iotlb()
> and memory_region_section_get_iotlb() to TCG. Declare them in
> the new "accel/tcg/iommu.h" header. Declare iotlb_to_section()
> using the MemoryRegionSection typedef.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS               |  2 +-
>   include/accel/tcg/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++
>   include/exec/exec-all.h   | 26 -------------------------
>   accel/tcg/cputlb.c        |  1 +
>   system/physmem.c          |  5 +++++
>   5 files changed, 48 insertions(+), 27 deletions(-)
>   create mode 100644 include/accel/tcg/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 661a47db5ac..3a37cc73af7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -168,7 +168,7 @@ F: include/exec/helper*.h.inc
>   F: include/exec/helper-info.c.inc
>   F: include/exec/page-protection.h
>   F: include/system/tcg.h
> -F: include/accel/tcg/cpu-ops.h
> +F: include/accel/tcg/
>   F: host/include/*/host/cpuinfo.h
>   F: util/cpuinfo-*.c
>   F: include/tcg/
> diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> new file mode 100644
> index 00000000000..90cfd6c0ed1
> --- /dev/null
> +++ b/include/accel/tcg/iommu.h
> @@ -0,0 +1,41 @@
> +/*
> + * TCG IOMMU translations.
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef ACCEL_TCG_IOMMU_H
> +#define ACCEL_TCG_IOMMU_H
> +
> +#ifdef CONFIG_USER_ONLY
> +#error Cannot include accel/tcg/iommu.h from user emulation
> +#endif
> +
> +#include "exec/hwaddr.h"
> +#include "exec/memattrs.h"
> +
> +/**
> + * iotlb_to_section:
> + * @cpu: CPU performing the access
> + * @index: TCG CPU IOTLB entry
> + *
> + * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> + * it refers to. @index will have been initially created and returned
> + * by memory_region_section_get_iotlb().
> + */
> +MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> +                                      hwaddr index, MemTxAttrs attrs);
> +
> +MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
> +                                                       int asidx,
> +                                                       hwaddr addr,
> +                                                       hwaddr *xlat,
> +                                                       hwaddr *plen,
> +                                                       MemTxAttrs attrs,
> +                                                       int *prot);
> +
> +hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> +                                       MemoryRegionSection *section);
> +
> +#endif
> +
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 816274bf905..b9eb9bc4b63 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -21,7 +21,6 @@
>   #define EXEC_ALL_H
>   
>   #include "exec/hwaddr.h"
> -#include "exec/memattrs.h"
>   #include "exec/mmu-access-type.h"
>   #include "exec/vaddr.h"
>   
> @@ -121,29 +120,4 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* CONFIG_TCG */
>   
> -#if !defined(CONFIG_USER_ONLY)
> -
> -/**
> - * iotlb_to_section:
> - * @cpu: CPU performing the access
> - * @index: TCG CPU IOTLB entry
> - *
> - * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
> - * it refers to. @index will have been initially created and returned
> - * by memory_region_section_get_iotlb().
> - */
> -struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                             hwaddr index, MemTxAttrs attrs);
> -#endif
> -
> -#if !defined(CONFIG_USER_ONLY)
> -
> -MemoryRegionSection *
> -address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
> -                                  hwaddr *xlat, hwaddr *plen,
> -                                  MemTxAttrs attrs, int *prot);
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section);
> -#endif
> -
>   #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ca69128232c..d11989f5674 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
>   #include "accel/tcg/cpu-ops.h"
> +#include "accel/tcg/iommu.h"
>   #include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "system/memory.h"
> diff --git a/system/physmem.c b/system/physmem.c
> index ccbeae241c4..f1ec0902c78 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -29,6 +29,7 @@
>   
>   #ifdef CONFIG_TCG
>   #include "accel/tcg/cpu-ops.h"
> +#include "accel/tcg/iommu.h"
>   #endif /* CONFIG_TCG */
>   
>   #include "exec/exec-all.h"
> @@ -587,6 +588,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
>       return mr;
>   }
>   
> +#ifdef CONFIG_TCG
> +
>   typedef struct TCGIOMMUNotifier {
>       IOMMUNotifier n;
>       MemoryRegion *mr;
> @@ -771,6 +774,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>       return section - d->map.sections;
>   }
>   
> +#endif /* CONFIG_TCG */
> +
>   void cpu_address_space_init(CPUState *cpu, int asidx,
>                               const char *prefix, MemoryRegion *mr)
>   {

Following on from my comment on the previous patch, it looks like this 
is still IOTLB as opposed to IOMMU?


ATB,

Mark.


