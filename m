Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1480CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kF7-0007pp-6H; Thu, 25 Sep 2025 07:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDd-0006XR-N9; Thu, 25 Sep 2025 07:33:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDR-0008Lx-Sw; Thu, 25 Sep 2025 07:33:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P59w6N2261987; Thu, 25 Sep 2025 04:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JyFK1mgukFhmA5mJ1KRQ9kTE3p0abXgzVJNP7kHyO
 N0=; b=g3OfE72AxkUAL+A7yPQlKQPes1j0IX97shZuX5I7xI4E++DrkFJO9DkUU
 oYeBQyUNOE9OoIHoyROWPjQE4oI31Ae1XY/rudrbfPogBWzmwStnvQWnFuIqB6IU
 vztRKeqM+yJrzKSplUzu6T8YQYDaICILjNOmPfASjD31Kdv47U3E+g1KuYLMGmmA
 xoJpddNh9KapMmmActr0BWjOYOveMQCTXRkz356dykTMxsjegsRFiNyiE9tjvpz7
 cku/3dce+VrKMlfqenAqgUeSyYvZ/jCx9C0lsCGMEINslo46kMkrRdxZMl/RwrzB
 E6Ffvzdmqav67P5nwxxbJj2ReqGOw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021102.outbound.protection.outlook.com [52.101.62.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cm7ra7vw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzPSt8fWlkcgqFQDxPOdlyxRUVMXEVYrgrFbERELt5FHlH7Uqv3os21qvxaqS/ezIwq9ftK/CcNTAJCIaDTCVw2VccAXhPB7ah5cOt2R2IGt2NmB4seFaVYe21pRe/8s3CZcCPRppD+NrGwGvQF1UIkayJHsFpd00/zl4TNgz5pjfpjEgQflDs63aiCdhKOOsxaQB+9TvVYeC03l46rUVkXJvFAPiG3jS4aUPjjY4v3vJnknT2YEtEZa2uoahhfGIEsck52SP4PzgTc/Ejwa3YNXPpAmjrFC11Nf48SfYA1FgtTVNEWuvKnwPFNN0CbuPxxsOxKIzbB1PkAS7jOUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyFK1mgukFhmA5mJ1KRQ9kTE3p0abXgzVJNP7kHyON0=;
 b=JmPtNHEYjt/DXm0lznRB5gfksmW5LYfT4bVpQU6dIdvb+XpfwVcUUpRmXWyi6Jo7nQxKYa5Gh5lECAIlIh9R4L9Xi9nwDTtNKBhIXWlJTf9P0Lc7SpwgoYe6pM8L9tn5dg6Pt/OKOZP8L4s/AEu7wZDec+VPPi7p4nTSdn292Xt/DiVJYSun6Cu/uX2RduVic/rtYOPnVbTyk8zkydkQr5jmcnEU1w3QFZ4t0XI5K/VR8/tovabbiGhs4JsgLOhlPT291Mb0Ga6E6yjKVEZrq4F3cB4Tk+KTmWhI9Q2UaMoo8SF7gdu6lnZHTwwO4Oo8mRBVMRgIwqgJdGjfB+KJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyFK1mgukFhmA5mJ1KRQ9kTE3p0abXgzVJNP7kHyON0=;
 b=RZ+nQNh0azEgXVjl5rI3897NdzcNkxiXErQ175JU23GJrFWU4eQoZ0cGOzy1YaW8Tqbzq8yv23DI0BhQ45u9TW/diOIqTut6Ue8SBH/lKgAtqhZU5Rt2HWVRXkwxr3Iy0QKcGFXweqUorfXbPhAIGeXLziGGvMEvE4LdgFEr9T1E5k33JaGVOz1SxdsIlYsEB5qRbJD1VwHGn5iqyNWPfRDI3VUiLgZkTNyN4AilFbZC7ra5+XaeWejF31FbT0ePDQwi3n78CpLCDf5RgoJEjZ1XhwN/O7ThJSYdJBK6K9FRNFzOjgKFRUR0JNONPK8gKwk+C97Be1kJ5xXwTbwv6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:32:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:32:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 11/28] vfio/spapr.c: rename VFIOContainer bcontainer field
 to parent_obj
Date: Thu, 25 Sep 2025 12:31:19 +0100
Message-ID: <20250925113159.1760317-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0281.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 067f5c7b-0c93-4839-dc56-08ddfc273c77
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1HUHUwQWs1d2xqS1hQZGVPcEdYVG0yQXA1TTNReVczQjhUOTg3K09LYTNj?=
 =?utf-8?B?SWlzQzBNZjg3YzFidEZvNWxyd1NzcEVRaHBQME5RS2NwNHIrQ0pNRmJkcGhY?=
 =?utf-8?B?dm9OaXdlcXpoc1NOS1VRb2dYakJucXF6YmRUL3R2MnMxUEc5c0toOXVia2J2?=
 =?utf-8?B?cHRFYmI3R29FRlhMQ3F0Nmx5VjBYa3UzRmphQWltRUVHTGREYnRTR0hmS0tu?=
 =?utf-8?B?UzFQQ0M4dTFFTytSQnZiSGRFbVFNU01ZL0dDc1AvYzUzU3hWSis2QW9meWNC?=
 =?utf-8?B?c2hoVUxaUTNnemZRTjNUVTRvZUs0aUw1M1FtOERRaWw2K1p2UDlWMUh0RnV2?=
 =?utf-8?B?UVY1b1FMTWJ0VFc2Z0VjYlhSbGY1eTJTeG05VjJKLzFHRVJ4bTVOU3lYelFm?=
 =?utf-8?B?amRSa3I1TW9VMGoxbkxqSm4wN29tOXQzN1V4OU9OQkQ1bnNNTm1DSEdEajRL?=
 =?utf-8?B?MVZGbXo5RHI3OEtvZHlKZFJxVEluWEZWclNxMmFiVVZnRGNLd0R1bGhWTkcz?=
 =?utf-8?B?MDR3Zmc4TW83NUpkVGg0M2I0YnUyZFF3dm44cHA0MEYyV25MRkVCNm41LzZW?=
 =?utf-8?B?dFNJM0FkMlV5b2MxUU5OUDJOcEU2dTNaQU56TzlYRjB1aVpTZWZPaGlGTThv?=
 =?utf-8?B?ZzJVNHRtQ3BDajVjQmV1ZXN2dnFoQ2V3Z1RBT2dNUjRRL2VwV29lNGJHckIy?=
 =?utf-8?B?MFJjNWRTNHl2WTNDR1ZLT0Y5eE5JeXFlQzVQelU0b0p2QzJDWU4rSGVQYjJ1?=
 =?utf-8?B?VmUyUjRJSEVWMmsvb2NocldOakxkb0tWTVRIT0J5RCs3T25ZVmNtV20zc2c3?=
 =?utf-8?B?Q1VJenhrTnhZT1FzL0FqUW5OdFJWR21taDA2ZGtPK1g1eXFOV1oySDQxdnJj?=
 =?utf-8?B?akJCN09yV2RrUDQ0L2lXcGRORW51WTlYeVJMWUIxVzRvR050VThNaDRNb2t1?=
 =?utf-8?B?RWtGQ1B1YUNMWXgrTGozb0tnNVo5YXhCRlZJai9pdFpyMURJQm9NTVNQQWtx?=
 =?utf-8?B?OWlWdCtQTndqc2lJYUNqK0FOb29ObWxGNzNETVJTblpkYndFbVFNYlFOYjB0?=
 =?utf-8?B?SW5HNXRFZnB6cWhRSUNEWUUrcFN5OXkrR2VWdWhXUjMwWFpXclk1bnAvSTFz?=
 =?utf-8?B?QmVsMGZPSW56UEFhTy9xQmhXVzk3d01RNFZMbitnQUFJeE5TZThGc3lNWWlU?=
 =?utf-8?B?L3Y3VVdzTXh2NlpzSEpwc3p5UHBFbXpqVzczSVYxVHdJN1VHSzdWZ3NUeUox?=
 =?utf-8?B?azZDcXJxOEFKNUVGTzZYY29NaEVlbEt0QTJ2YWJQYkVHc3RGUWVlRG85MHJG?=
 =?utf-8?B?b1lYRFNaQnU5VTFJd2QvanZOYnE2cEdFZGM5TmNUZFl5TVVla3FWc3BvUjUr?=
 =?utf-8?B?ZEJmS1I0RmlWWlA1TGQ3MWg0TkxKNVVtWUtmSFpJb1NTeUlTbDAzMjVCSllK?=
 =?utf-8?B?ZGgrR0JrdWdVQVBiOUFES2RTaTFva0grUWtKQXdYN1huZWNBa3g1eVI0ZWRU?=
 =?utf-8?B?WGlwZ0dPWkMzNUo3Q0dleFJuK2thWVFLQ1VKSTNsOFpSWFBEbUxuU1FTSkNK?=
 =?utf-8?B?blZ1UTdJMU1SZnR5N1JZMEtBUnh5ZllxUWJTcExCVm13eWRacitDOEMzWkZD?=
 =?utf-8?B?RW93endWVmRNbUtLWGFRSVhHZUpieFJBSHgwVUN5R3B0VVAwQnBhVWRzTHBs?=
 =?utf-8?B?bTdidFJ6SzdybjJoUk5GOUlmOEgvL3ZzNGFJSkRoL3hWWXlXWHUrZDVjOEVP?=
 =?utf-8?B?ZHhhS3BpSjMyQzNaV2NCUnZ5TUVkL1VVdHh1UzFxMnJpOTAwTWc0UlFOVTBx?=
 =?utf-8?B?MStjTlMvWXBISDFHdlZhcm9FNmplVi9EQUhJSVBHRVdkdDJKeU9leTVsWmZB?=
 =?utf-8?B?RFFRSHdGTWVkbFI3WHRTVmF0ZGNnT1YzU2h3dDQwRVF2ZUp6Uklwa05seklz?=
 =?utf-8?B?S3ZzcHdzUlZQRHQ5OE1tNldBR29nc0lIdE55VE9EQXRzajFFWldvN3V4NXpH?=
 =?utf-8?Q?eaQPPOqexAhriWXvv8UUJjQoMgqo6I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2doOWV3SmhaQWxuR20yMllqWFJtUVYwellHb0pwQlNMaURJS0NlRy9pbVM5?=
 =?utf-8?B?RDR2SFhwS0MwMzlXVGY3bnNIVFloR2ZFZWtEeVU3dVRPQjZYMmhBcUF5QlNF?=
 =?utf-8?B?OHZGbWg4UGF2dUlKS2RlQzQ3OS9uWndSMjFVUFkrbzJEcU1NemowdVZ3Z0tX?=
 =?utf-8?B?VSsxOVN5TldzWXBpMFJNNkV3R3FLb3k2dUoyNDJlR2dFc2RBdzkwWEJLZU41?=
 =?utf-8?B?QjY2RzY4OEZUeXVLc2NLVnozMk43T3AyZVVPRU9yMTRoclBjQUdnWlVyRjI1?=
 =?utf-8?B?c3FNY3NVVzlOR2czTzRPbExUODFVSzEvTlgydmxkclFRT2NERjBhbHZ2SlBL?=
 =?utf-8?B?VkN5OURWaXJyVyszVjJQMzZNdXdHVi92OXI1Y0llQzhaTk12M3p6ZlRaTDlS?=
 =?utf-8?B?WE1oUjA4WjlDNGZPWTkrYWh6cEVyemVpZnNYNWNsRDh3N0VzNUZoTEo3SjNY?=
 =?utf-8?B?eWxTSzBGbk54T3JFRDE5UnFjTDZVZHhPK29kK09jRzBiMmNjbHhMTGlBaSs1?=
 =?utf-8?B?cy9aL2lZQ2xTelJpNi90TGpRMndlN2pSTlhBd3FnUG9EUmxGNW9JUXFXdjF3?=
 =?utf-8?B?K3Bra09vRE1TUkUzcThZM0t5aUpYT2tvV3ZQVFN4UGdTM3d0ck1pUkU0cUk1?=
 =?utf-8?B?dWJXRU55QTJTS21jVzJER1NTcTExdVI4ajQwRHh6bWplNmx5cGVnVTNQMUNL?=
 =?utf-8?B?a1E0UGlnMk54V0hjaUNnaE9VQk1BUmp1NzlsSFlPYXM5NGdCNnZLL1dtcWUr?=
 =?utf-8?B?U0UxNytPWnFRMmx5ZVkybXFVTm5pQTBhZnoxMy9BclB5ZUYrODdqL0YyTUdD?=
 =?utf-8?B?Wll0MlkvNTh1VU5LRHJvMy8zOHBIUi9zRHIxK3V5ZU1hRk1ma1pLUTBjQTN4?=
 =?utf-8?B?OHM3VmhFZ3Z0bS9rK0FBVTM1bEk1eVVHdFgzdlJSNk5uRHM0S1JYb3FGOXov?=
 =?utf-8?B?QUN1WUhnV0xEV0JUMnB4S3IvaUJWbHhsUlJ3Qzh4cUszUEx3R3NhU3dTb0kw?=
 =?utf-8?B?MzF3Vk1EUWM0cWthai92MGNIbEpNLzFnZjNPaDIyZmpBeHAvdGRjU2VGZmt0?=
 =?utf-8?B?U3pYdXpZR1RJNmtsZGNsMHhabmlvdUlFL3hhQ0JnY3ZGOTZaamR4Qi9IN2FU?=
 =?utf-8?B?UnRDTkF5NHpteGh3N2syVStrTFhuV2grbzZMdHhwdnRnMEFWR1NSdDFLM3A5?=
 =?utf-8?B?YUFGTW4wc1FqaTk3ekpYQzNZMHkxR1lnc3ZQQmFlSE4vc2czbERrMlpMdWRS?=
 =?utf-8?B?djZBcjlhRHcvTzNGRWRSRjk1MXlPNG1NcG41MlR0SmVqN1U3NDVScWpGRnZp?=
 =?utf-8?B?QWNnS3hxcFdtQzVKRDJHRWkzNHFVak5NMjN2U1FVbWlydjIvd2JJQ3ZvNHl3?=
 =?utf-8?B?aWtBaStxT3pSSzlkbzZSdC82R3hzVFlMdng2MEdCZjR1SDh5SkRaYkJkaksw?=
 =?utf-8?B?bytsamZsc2p3UDZTWXQzRm9sbzZtU2hlS2xGaXFZZEpXWlczQ2VMTUR5dzVN?=
 =?utf-8?B?cDBxV1ppTkg1Nm93d3JtN0hUeUF3L3hwVXhHUk5MRC8vMU4xZUxscVprQkph?=
 =?utf-8?B?ZkJBTXFFSU82bkhFZ1UvOTFDZ0d0M2xJQ0hNRlM5UytRVHJaV1dLVksxWEpy?=
 =?utf-8?B?ZUxVZUdGK3Y1K2lYbU1yVTlEcWxIQkhPYXhvaGE3T0xoRW1nY1N3ZDhMYzFV?=
 =?utf-8?B?VXdpODVQdzJnOEtZTEk0MnY3ZXlxYSt3K1M1aCtLMzJEYWEwanJiaVI3ZXU2?=
 =?utf-8?B?L216amtqNUJwNWFvRnlZVGlFVUFJZGVUUXRjOHNsNUFtbGdua2tVSFlTSU1k?=
 =?utf-8?B?VkZtdWZMTXNIVktJVmd3UHM5bHJsajZzbmsvaGpoeHg0MGs1Q2VCcW9jaXBi?=
 =?utf-8?B?emJNM3NJL1B2ZVdBcnZySGxHYjZjMDR2UzVpZERwcktXUFlEdlVSYm1XZlBo?=
 =?utf-8?B?RU05ZHl4MXhPVjcyYk5EblQzeWRYdGREb1NEYXk5cGJTKzFNWDhCbU1kdFJC?=
 =?utf-8?B?M2xPeXVleDVYb01VY25DR2tTMGxwK3RSV2JLQUZ1VzVma0k3eDBlb1pCc0ph?=
 =?utf-8?B?Wk54YUs5Vkhyd1N2a3MzdGJyaTFTN0tVVUlOR3dnUXhSQUxIb0NNdFRLaTBZ?=
 =?utf-8?B?cCtZR0Vxa093V3R2dXhUbW8zOUZJSkRIbGlGL2xpTnU3L0lTdXhDVXFlYzBk?=
 =?utf-8?B?Y3RkaUtEN0ZJcWRwK0lxQVd3bFl6dUJDZVhOTFlEUlF4dytBOGV2ZU9aNjVr?=
 =?utf-8?B?MDZCS2wyZDBaTjBCblk0MVhsME1nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067f5c7b-0c93-4839-dc56-08ddfc273c77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:32:41.0006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of25t07zKNCQF/W8kPIxgz14GoKc8BWM7u9RxR/CMo51ZCxGA6b6FzEmVL48g8C5Iq4J9ji05/aEBukeunOWWLimKq0EsNY5kpcQ5jev6wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Authority-Analysis: v=2.4 cv=NeXm13D4 c=1 sm=1 tr=0 ts=68d5285a cx=c_pps
 a=ZFdWVeMVgMUaj9i/bB0qbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=8L7MK6Kl4ER3plC8pQ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QUrepAA4EdDMfpd1OgZxi5BEK4CBG2lk
X-Proofpoint-ORIG-GUID: QUrepAA4EdDMfpd1OgZxi5BEK4CBG2lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX8XRM+1Fl22Tl
 0nlYetl+0vfyjJVFKixVc8IguyrvQEaSva9czjegRR6z3E7H8hgvrQaSIGJYgrMaNuEGs4vDkd5
 IQ2Sx5yxgtIVQWhROA9cbWMib/a4y8MneIpNxKS52dcKxUAxY/GY9Hn+iKh0XCMnutAxg3n9xLq
 jpPIXnCTnCDDDuzJN6o02xPJkLnUnsJ4ggfKrj0UrczBiEXcwiH5bXFyLaZxfAR3OZ9ghLU4je4
 CTwFTFhlDHXXw8fwjQmTrO6KEtHfoEvfF90NMBKmUDPwpj8vuZuJGqQqQF4yGyNixNi7wA+F4ww
 4LP63DGCbs+S8KvyaTxLjkesZ3rypmpG675MwCCXDGIu78VSjiQjOmx5/oFXYo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c883ba6da9..8d9d68da4e 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -30,12 +30,13 @@ typedef struct VFIOHostDMAWindow {
     QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
 } VFIOHostDMAWindow;
 
-typedef struct VFIOSpaprContainer {
-    VFIOLegacyContainer container;
+struct VFIOSpaprContainer {
+    VFIOLegacyContainer parent_obj;
+
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     unsigned int levels;
-} VFIOSpaprContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
 
-- 
2.43.0


