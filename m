Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D0CCA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 10:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upP4G-0006cj-CK; Fri, 22 Aug 2025 06:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upP4E-0006cL-Fn
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 06:32:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upP4A-0002Gc-RP
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 06:32:17 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M7AWqM674503; Fri, 22 Aug 2025 03:32:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=C52t7T9VwNDJ9xw+v+WzMjDNIhE8QhRtJiwxWAn7D
 IY=; b=LYsE74VenVTZ+mnGDxATZKApBpvdTnfZub4lrZOynaCQOAC0CopF7a5V7
 fuMzFL3tZ2GIRt7Sddx0gxJM9Y2Jl9qIIFXTl8gJ7HlfhEN2vq5MruYIl3XxTgzW
 XC/79+NuT2Wr5l+ppaGq9K+XdOUFU+Ovhod+eaJn7rsFx9TOnkdEQMKXBr2YcyOA
 Xr9BH52NqPnfXpSaFOnbsaCX/PcTFOlfNFNBQ9+L/6Y9FhoCmrO1HLtjSD13HZJ7
 RnbEkI0+T93TzUeC6Q/8laP/tQFQYZMJSYG2m38VyL9Hb5FFmI09QcVSiO875hss
 8hswPZ0ioU9uCy8CA2wkQriby2g3Q==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2101.outbound.protection.outlook.com [40.107.243.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye5q8y5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 03:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX8oDX4j7s7K7DvPPBcot59Df/9w6Ckbap9/CcCJZAd8QcyyXSvhd3mdH7sFgytGzHyyMig2g+xgSGuFBlb1Wfdp5JIXF7nxzOALpsdvyh2wLjrzo6Ayib3jPfRyFWCug6g1F6LECpC4Z+Ycs9E1989Vtkz2rrIwg1OZt7XvEPYfoJDaquC+jwpF+ltibu3x55V0uZ+gCyYwaOTFTy5gnJBhH7jGDF8mLlsLMTrwbSmvnfWKb5HuKONmYKNdv8Wafp2bORJc2xpFByyZX5Y/dkLdu6Xs9MNKR40cSkkoHA9iR0J5vzya3bAOs+WgczgBoJlsb/m4kZEkZh2RMrjzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C52t7T9VwNDJ9xw+v+WzMjDNIhE8QhRtJiwxWAn7DIY=;
 b=AyhoAgafbhdMJHDzHEbqPrJV2IsH1NjmwD7bWuOandvipIKkEeTdQEWcajvyLNZC/hZGAVXLHUIuh//jgPB9aiPQymtvoeTJBePSOBHXfh/G/D6z7uOjG132TooNDL4srTombOu66LARcBr1OJPx1uaFTQQtOzfY0vOCqUiVWnV1zFXdIwqXik9AyMxxcp+O6scqxGZWlU1gYcMfnYj2KX1eL+XqRHIODwNE/pq/5wS2iRDHZKEs/JciACG5MQ/yGAKcCYrGI6Z7Rra5pHUQhwnLbKVcuKJdy1diffOzVRSUbmw24O9PvXtBntbM7KPZkeJ46bfeq0M2hdPs21cLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C52t7T9VwNDJ9xw+v+WzMjDNIhE8QhRtJiwxWAn7DIY=;
 b=mcYno1pqp3xF6d16eNYKFGJ5jCjQTki3KWrINwnBvW0PTUOe6ZzbXi/HO9skoiouN4YpTghdtraWqz68RuADaNvfnyQMGjpnbDTuEwA1soQy1AsuifkMPEuJPdPt2vPECU8JGHh2BfT98lVskTUL7BLPWmtJrhxZgzBLOuub2y/FcDWqDl6Tvb59mYgNernYlcs2PJMlkGs2HfDE5E44yV8mzIJpsbVHN78jnPAOyf9ZWF6zIN0BqtttAR/B97eAot/Bbmm1p3OA99YFMFQQliF1SIXdBwp2gWp9PT74EjM4dodE6vRrrkVFxFXzSLA8b9pKTEdHJ0aH+GriylRAlw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9624.namprd02.prod.outlook.com (2603:10b6:930:6c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 10:32:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:32:03 +0000
Message-ID: <a830e020-c107-450c-822d-29e47a1c0494@nutanix.com>
Date: Fri, 22 Aug 2025 11:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci()
 into pc_xen_hvm_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-4-mark.caveayland@nutanix.com>
 <4c6ba00b-a90f-42a4-b4ce-1efdc87b7e03@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <4c6ba00b-a90f-42a4-b4ce-1efdc87b7e03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b00edbe-5ee4-4d03-5c5f-08dde1672232
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFBJYmRSTjlYZHpQc1dXUXFkdm94TVY3dDFtWWdHQmhyUklOWFpFU0ZVcjZU?=
 =?utf-8?B?NWZHY0M4VGFKRDJ6eEd3SGRVdFJFbm5rU2ZEbTVaUENOUENFZHJqOFYvYmJW?=
 =?utf-8?B?QTc4dTBuQ2NwWVBLcjJBbXRzTTl5ZTZQZENmYjVyY3NlMExrQnBZd0JWWlJI?=
 =?utf-8?B?dWE3Mkp1dXArVU5IQ3BOMTdJTmZJZ09TaHFNNWN3THhkSHdpbmtDakRkdytG?=
 =?utf-8?B?MVpTaloxNzBKbnJhbHVlc2Fycit4ZzRXa1pCOTVYSXdvcHdwZWIrcThiYlNk?=
 =?utf-8?B?K3R0ems0S3lUaWFuaHJnNDhFL0hhSnFXRzI3d2xBRmhiVTkwY3B1TG1ISU9j?=
 =?utf-8?B?bTJoNmlXMlNVbUxMZlZRY1JPSExnK1grOHRVWk02ZTNiZ1NRTlVPVHQzWE1C?=
 =?utf-8?B?TFBIbFhYRkNWSGhkblg5NGV6MElOMTdGY0dEaTRoY3lwdEFQdmRQbnprNDFR?=
 =?utf-8?B?R2xqV2tZRlIxbm5iOE5HUEdrV0lkZEg4OVlhVXAxOTBBYTJGVWZSREIrSUQz?=
 =?utf-8?B?SG5DVUN0WWNCNWpPdklaRk5CNUdZMWJhWURweW1zSkZmbU42by9CeHA1NjdO?=
 =?utf-8?B?WUlvOW1zUzVOdmZnWVNQNFJ0NllSNGZ2RGRiY0p6ME5BV210N3FxSXE2aTkr?=
 =?utf-8?B?bjU5QkpqcllNYzFnOEVZSnJucUo3Nm1iK1ZlRWIzUnRsdEdxdm41ME5HWm0v?=
 =?utf-8?B?cEhzbFhKclBnME94WHJML0ZrR3FqbkRNWGVzQmNjd1BGRVpLMmJ3U1BMSXU1?=
 =?utf-8?B?ejhaNDZFUUZGY0VlQXdQQUZmT1RORVI2aGhTd3RjZ2FqMTI2c3pzQXRzc1ZG?=
 =?utf-8?B?bitJK0g3T1kwa2R4MDhTYmgyNU1XV2EreVBCdjhTVW9UUGVCSm1QRkI2aU1Z?=
 =?utf-8?B?cUwwSFNGaGJwMmxUV0hsSnZ4Zk5rQVR1aHRUa01NNnJLeUI3LzBZbUp3NmRi?=
 =?utf-8?B?U3NIVWpDS1Yra1g5MEVleG1FNDBtamtydXdtQzVqOU56K3NmemNhNkdtcnBJ?=
 =?utf-8?B?bGJ1NzlPbXFCeTh1L1BIWENsTTJ3ekR4WW16ZkVYLzZYTWYvRDIvYjBqM1Zi?=
 =?utf-8?B?T1JCVXN1V3dOSS9zaVpwb05Fb213VHNncWRZYVdjQnpCd2h4bUgyME4rbUV3?=
 =?utf-8?B?NkVSQUhNeXBLOWtZM0ZOcmNWdDB5cUcxa2ZnQnBIUFRPN3AwZHplQ3dTbkd0?=
 =?utf-8?B?UnEzVzBHRFdnM2xxQWhHaStwTitnSGpscm5ES3pUMHQ3eWZQWmxIZ0VyUi9F?=
 =?utf-8?B?bDVjTUNZcS9QRkRYbWcrUlo5ZEJYYm1vd0hlVWlNL1VNMHYrMTVpODMvVzUy?=
 =?utf-8?B?Rmt4YW9SeFY2R3h5NmVSZmVxbXZ0L0VhK1RqUGhaUFIyOFZOQU4zZ1JJdFdr?=
 =?utf-8?B?MG5HQkQ2VjYzQWlabTlRblV3SHVCRE9sZFY4SzF5aXpHZVhZTHJ1NmpYRUha?=
 =?utf-8?B?dG5hWCsxV2oyOG56WUZGdE5ENU1WNTdZd0I1aHNtSGhSSUxGczBwM1kvaDBE?=
 =?utf-8?B?WkdoUW9iek82MlFHdVBnbnBHbmtOa1hwUHVBaDJYdnVmdVNwVlE2Q0M3L1Fn?=
 =?utf-8?B?cnQ5cWxEdnN2VUZTNzh5Z0RvdnY0S2EvR3RhZStTdFRORnhxN1pJK3FIdmRP?=
 =?utf-8?B?MzlpZmVPejdCNDBGV0xpUzdzTWZBM0R1Snd5TGdVaGJMeGtyUTNCYmVBaGlu?=
 =?utf-8?B?czdkbUJ5Uy94QmVhNHRXaTVZZDhOcWdwM3JaRTcwSEswbjRWNFZuV1NZcWtZ?=
 =?utf-8?B?bWNiM2JZcTNIYmxuZ05NUmFhSEljVGlIazBQb2Z5TG4rT3ZDVk5WWjhBeWFU?=
 =?utf-8?Q?21WvffT49xnVQf+rZxJXHsxSnkVN9jTOKlG/c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmdJS3U0UVFibmh0TjVNR1AxMnpaZWlZUDlZOG9reHkxNmVHQmVXenJGcTJx?=
 =?utf-8?B?MTFpQmdwOFlwZUFOZVROeUxzS1RzMHB3dGZPOGpVbzVHUVZFS3ZGbkNHSHI1?=
 =?utf-8?B?VkYwR2ZZQlk4aitrL1lRTlFjeS9PKzY4S2xlWTZIWVpYTCtmSTlMOHNnM3hl?=
 =?utf-8?B?QndTZGdnUXh3ZDMyZ2RNbFQyMVVyRHNmQXZ0SitEZmVDTGxCOUtGdGttbnZw?=
 =?utf-8?B?bi9Nbmx4UXdpRU9yQWNuNWlUZXFSbDBlOHNBU2dFQ05NV3hCZWM5ZGtjWWRX?=
 =?utf-8?B?dUNqRTJIQ3JqVXM0NlErM3p2YXRtRXUzMCtDSTVPUURoY04wek5iRmpMa3RG?=
 =?utf-8?B?andqUVlmN0lpeHBYdlUrVW9mZTlRS2V0YWgrWTV2S21wbXcrTUJhTEhFS0lV?=
 =?utf-8?B?SjFBUjM0VjBqYXZNVUdIR1VLdEZMbnVsSUpEckFuWU9wTkxCbVlvTWo4NnFV?=
 =?utf-8?B?NkhJWHJDSDJXOHR6dnBTUlYveTNhMS9sNVM1RWhQcE5jaFd3cHFnbFlUa2Rw?=
 =?utf-8?B?M01IOHRZd3FQU3phNk9ZTE9BcWNlM0NBRWg5dy9xWUU5MU90d0hQdHFyV251?=
 =?utf-8?B?QTF5Y0RGK1pBemZFOGtGck50L2VsN3NLV0NSbmc0dkNYSUM4citXMW9nUXNM?=
 =?utf-8?B?Mm4vODNZWVk4U0dESkVramxtaytOd1B1QUR1dHhBajZEL1lPeEJqWFllajRL?=
 =?utf-8?B?QmgvYUQ3VFEwTjB4RDQyN2pMYnhyTHF1bGdhZ3U5cDBwMlJ0SFpBeTEzMXl0?=
 =?utf-8?B?Wm9vSTU1NXJsWk9kbE1OZk96T1FYRHNodlBqcHFaUm4vcWxJUW1jR3hydU05?=
 =?utf-8?B?b3poNzdqNkVHQzlHZFpQNzFxWWpFYWxyamVmbEJpUEd0cStCVU9GbUpvZThm?=
 =?utf-8?B?Umx0a3NVWFJMbkUvbkdxRnQ0TjVhLzVYaFlHbHBFMm45aHZkMHNoVEF3eFcy?=
 =?utf-8?B?TEVhcTI2OXkwNmxCb0FhbjZUY243K0NtcGxnUU1yOURGQ0VOWGl5TXdJeHNF?=
 =?utf-8?B?WGNlQnhyZUZYRjdtM2J6RGViZytPcnRvcS82ZmE0M1N3aWRtQk5QLzdHYlB1?=
 =?utf-8?B?Z29vQjU2VDArTjk0SkRRbjgyRlhvTFhIbG9VZlVWTk5STElWZVpJNHNWNU1V?=
 =?utf-8?B?NHR2Z0tFMzVmM25ZSW1qZnBKV244cnRrRmkzU1J4RW9JN3JJa2tyaWlFWEsr?=
 =?utf-8?B?ZXNKMWRQaDdCQm9iNlg2ckFkUFI1L0dybHY2U0Z3NFhEMUQ1RkRRQW9tMXB5?=
 =?utf-8?B?WllDWUJka1M3MjRPbU4xMTBPTFd4VkQzaTJBRFp0QzUxUEVwQi9iQ1FPdDhp?=
 =?utf-8?B?V0xLM3ZVUzREcGtoaXZTSEJReVZpQ2g4NGJSUTlub0U0c21yd28xUDJPbDRB?=
 =?utf-8?B?Q3hIUDcrWFVUUUpCTGtIK1lhYXU1eWx4V3hpdTh2ZVgzVnJxNDFrelNDWHha?=
 =?utf-8?B?RmhIU3k5cWNsNGVGMm95VmE2SkJLKzdnV21uSjErSVBhNkhxT09TczdidTVG?=
 =?utf-8?B?VTIwMXIrZkJkZ0wzQlcyQ01hMDdSelYvak8xT0J2Yk54bUF2RGl6bkkwREI3?=
 =?utf-8?B?ZVYxTE5HV2NZam9OYStzRWNzNFk1Y1pvQjZzMUltVWRibnA5YS93RlRiZ3pL?=
 =?utf-8?B?a2V2bmd3dUV3VGpEUVRrYnQ5bFNqMGwrT0p5ZDV6WjVoakxCT3p5VXBqYk5Y?=
 =?utf-8?B?eUl4cnJwL29pZVJULzA1OVRTWGJUSU1qR1VMd283YlRjcWxDazY5dWNmc2xh?=
 =?utf-8?B?SDBkRy9WUk1UelQyV3Zwd3lRTXJJaHpVTmIrUTdjYmpkK3VqWnByeVpjamZ2?=
 =?utf-8?B?YTVoc1plUUp4czFSZWt0am5INUo1MU1YSU9CaDNrUGFiVFBYTWg4NUI3ME81?=
 =?utf-8?B?UnVuYmVZc1ZLcDZOUnlBU1VNbWZCWW54UWowSDQ3STZWd2w0YUhXVm5SSXFz?=
 =?utf-8?B?eEdydGlRYzRCUnk3SE53cDZRS1liVWt6TGZTc3NRRWxhWTdQSGFOdGZiRm9m?=
 =?utf-8?B?MlB2dzkxdWhDMUE2djlwUnlxcjRmTHY0RU1wVGJvd3VvZTBlYWFDS2ludDlv?=
 =?utf-8?B?YUZrSGY5d0FWV3RmYm5XNnNaVGJGV0RIVzhxYXdJekx3VlAxTjJGTjdjTzlK?=
 =?utf-8?B?clp6S1dtaW5pUFNOYVBxTGkrc2RURW1wVGR2SHhkRWtIRjhkZzkreXZZdGJ2?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b00edbe-5ee4-4d03-5c5f-08dde1672232
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 10:32:03.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA4wFBo6yC3k7u/AVylLS1MeNE/GW2lNBWQQ6jjUFr6MGFl9VIZKYspjKbS/oT573zBOmj+7NRNYbsTHAykdfBvLDrrXM8wxG3hX6QcrX2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDA5OSBTYWx0ZWRfX2jjs/40pEGEu
 lW1B1VkIn0XZ2Nn0ioeNuQmouItl2pEOEb/nvOInvZFgDc//ueJ//+QOT742H5fEfMVKG4gWGYh
 +6gdal354dEIQeXMGTNTrtvjFE370dP5/bNVuDxiCjg7rE2VsPBr2iklsacDxrKkFO/auwP9bAT
 xl9YGfv7DoIM2wDMu7r7y3APTtK/GtUD6G5o1CPV0/xssesW0iN+oCNiKyou2HpOnbAC89AVwyd
 ogTjotznLzZFZ3+ES6jGU69EQ7wfjuiZlz/4v9Pwah8WYkALW4Dis0uGc9aZxPQo7Ojn1sGGUYX
 0yhYN822hkXW+GKOs2gwwk4eLEGr36929Vlxuae7TCpgbuK3nd9RbpbO+MOkQmofe3/KVbi/jcV
 dWgqji4EPj+FkMTQSTXi9rN9av3SmA==
X-Proofpoint-GUID: K84bg82or3ziDhcbjSp2Sybg7YLujG0Q
X-Proofpoint-ORIG-GUID: K84bg82or3ziDhcbjSp2Sybg7YLujG0Q
X-Authority-Analysis: v=2.4 cv=bt4VxEai c=1 sm=1 tr=0 ts=68a84725 cx=c_pps
 a=JSo9Bu03w5K1EWcm171O7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=RpNjiQI2AAAA:8 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XQdooxrpn0B43DIfQ9QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/07/2025 11:31, Philippe Mathieu-Daudé wrote:

> On 11/7/25 11:57, Mark Cave-Ayland wrote:
>> This helps to simplify the initialisation of the Xen hvm machine.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> or S-o-b per https://urldefense.proofpoint.com/v2/url? 
> u=https-3A__lore.kernel.org_qemu-2Ddevel_3ebf1793-2D6d55-2D4e07-2Da2b6-2Dcb738d8634fb-40linaro.org_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=Pl3V4I4Al1u6DFkjXsQnXZESBoBZ7B0YGifdAZ4_WBJ4MTAzniEcysfiwfJtiEbM&s=ZGdmwJU07OvV-JmnkU7z7i2D6SaAeQ7Wo1n1wIefjOQ&e= ;) I don't mind.
> 
>> ---
>>   hw/i386/pc_piix.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)

Thanks! I'll use a S-o-b for v6 in recognition of your efforts :)


ATB,

Mark.


