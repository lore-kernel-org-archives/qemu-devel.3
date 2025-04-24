Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA54C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tXr-0001GP-Jg; Thu, 24 Apr 2025 06:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tXp-0001G8-2n
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:11:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tXn-000535-2f
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:11:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O7YbrT024262;
 Thu, 24 Apr 2025 03:10:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OAMHyoglvieruq3FYn4qWbF6ATnPZcn/n8Zg6+0XQ
 to=; b=B9m0/5Jqqit5zz45tZ/7+zmlBSXjAzQwjm0XIOOpvh4sUcwMOEEGloezL
 ujkD545+VLzh20kWaZcUJmx3nnetk2hbI4SL3QOZ1KxySmzEldd+nstxwpsRzcJo
 n4BJFm5BeDVfl+ip2+OFKZBJonUWSA1iYtjbNvff3xHiWpActeHIgfXTOCXh/aQj
 +Mk2ktmKabZr2fTUzBjxVoEVD7tr0DyiL3FSyMdemDy6VynVXpwtAujUGjOKBI5v
 PipZFEri9a4mRHovYrIro1fJLBuKBmkHtAUE1bC8DSROwZccFbeWdrbAHmuv5ImT
 AnGB8ymahsrNuPUVcuezcQtfg1lsg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhvvacu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:10:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWsGSdAzC0lagoVQlO/YCHYM6WOFopVr1sp+tl/0bf8h4oxcsGaObaFargB49Ub/2kjNACi475GvXTsppKq8I4wOVtTugSHgPJjRvsWjBxDKYP6+/lgNd+6BWUN1zz/MQ/cQEnQ2OCRe3FSy9T0kdr8VdGF53llgdUxo6BrZulNQaehGPCtll/lJtI5CVPCThz2/t1Yyz+S7RSeO9aeDp+oLjUt0RExqkmvF92OAxJR6vSVdbXSj0FYLwoUddoFKrNUnBov0uSVcpF85vTai6pc8iA7kwE7pL/4zNTUWc0zP/DwOEWXRnR/i5S1bIuIEFIl6XHKV4s7uuP3fI6EOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAMHyoglvieruq3FYn4qWbF6ATnPZcn/n8Zg6+0XQto=;
 b=Nmwi+3gvMhidPT34zWBpwPiBzi52PVhy5XUdChTmgEb/1qfDha4wCQcqRL2SNz0IojfU6ImgPxdIAO/9sPrek9Bm+OJ4G53ROgNdz411JyIpNefnQxLXT6TZ01ADEJoOndIY2bhaIZvNJjTR+T/0riqe7Bt0nNF8ZIjbHNL9VzuoU+BbVH8P0qJgrK/gMKDwd2rswxrBziFMJMi/FZT7fZSd8/Oejubi9BHHQvwsthfL5DFQGS9cRnEJKR+J/RKLc3doZoeq5LjsRF7c5PE5QDiHL3/TSKEpxl+meC2/bm9ibc8GepbcA622UCDmRv2PQSZ9zVzFiwZRGDx4F8C1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAMHyoglvieruq3FYn4qWbF6ATnPZcn/n8Zg6+0XQto=;
 b=Abuhtu9xf6wtc8uNiicYGZq7DoBgeo3D5EYMN4CCdzPQ5VvfjQ3Rr+pX4L5d5oww//yfrZoURBRNOok3Tp47PI39P1lgDmgoTmJ/AagGYlz7HI5dMiqM6C+Q4lJCb6P4Rf5+3WoF+Ibrd0oCI3ZVeGLrmys66AQsSMd1A7TBJPNxsMvDv0a99MX8HOLHxWx3sm3HswhG7fpEH0ElP9P1hxHG0BNEFrUwCxBMiaH9rdilSj/yhf9x+MXINPPLyQkAoeH6C3nDbz4iZf1oHOpUj+x2lpJJszofoaiGovRGXttUgX2rVwtsoQvFM0eI0SXzDf77VXLvOv7ZS/a2SFHuUw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA2PR02MB7707.namprd02.prod.outlook.com (2603:10b6:806:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.8; Thu, 24 Apr
 2025 10:10:50 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:10:48 +0000
Message-ID: <9b6d59ae-71f8-4498-b3fa-4e6ea8a539b9@nutanix.com>
Date: Thu, 24 Apr 2025 11:10:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] accel/tcg: Correct list of included headers in
 tcg-stub.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-4-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::15) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA2PR02MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf6edac-13d0-4843-c5ff-08dd831848f7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmN6R2tZM0JYeStzNUFlbFZtMXVhcktERHJDeEo3NEdBZEdoUUgxYWp5Q3BD?=
 =?utf-8?B?R0VGVG5wRHV2T0xDRTljQXBOcTc2Z1VJN2tNelNGRXhBcXd6THZBeHNJak1Z?=
 =?utf-8?B?RGxyeHlTeHdYZGFVQU1CRXVyaEVERmFyUm42Y3c3aXhWeVp1TVVmRHpXU2s5?=
 =?utf-8?B?WU5XNkdPQXYyWVlpZTExU0g5RWlkeWN3VEFrdEp2dVpzVWlacmx4SnJMM3Fu?=
 =?utf-8?B?SjdPaXNMOWdxb0dDNVcvaG9FaUNmcktNOU9BdXFEd2ZsemJpQlJHR2R1d2Qw?=
 =?utf-8?B?RmQ2dDJmTmRmREdIV1hlMEZ1ZDZMdHV4cmdISDRhcjVFc0s5OU43bFI3ZDkx?=
 =?utf-8?B?YjRyL2ZRQTUvMGNaRWpzeGZIdFRwcHpqUnJndDRUVE9iV2UwYkdXSlBBdkJy?=
 =?utf-8?B?SDcyek94MWxVWVRIUTJRWDdJZmloU0FLaTZ1amlaaWhUZ1A0Qno4YWs3QTdv?=
 =?utf-8?B?YVJjMysxM1JUTlViOFpPTjZQclBHYWFGV0JTaldNTFRiRUxseDZJeFJJUENF?=
 =?utf-8?B?QWloVlZmMEtjcHE2MnpHWjdKNGVtdFRheGNjcDA5TG5INVp3d3I2ZkExWmZp?=
 =?utf-8?B?M2VuZTN4MEZ5Zm1iVUwxV3ZkSUl5TkVpZ3Yyb05YRTU4aVVXSklnWjF6THNk?=
 =?utf-8?B?T3ZFMnhBKzRNa3UrN21pa3d2R1RRNXNKZHVxM1JjcHBER3c1Z3A3Tm9XYmZ5?=
 =?utf-8?B?OGlkYXZsSUVvbENjM1BMS2dWSG40b29WUEI2WmttYWlFNjRDb2E0ZVJmTDNr?=
 =?utf-8?B?V1pZUlJ6N2xjcFJ5NEJ0dWNRTG1aK01nQkx5YWdpYkxOK0NwbEpsQzVkekRW?=
 =?utf-8?B?UmRwK21WYm1rN0lBWnN2dkQ2MGtMY1hvTkxpN1BvQXBieHNWZWQ0RWFEUkkw?=
 =?utf-8?B?dXBBbUxRNmxaVDJ2Z1FLSTA4bWZOV2V5djBkK25PWG43UkZsM1RHZmJMYUNK?=
 =?utf-8?B?cGZ1ZE5BZm1RQVBkdk1LSlJuTERPR2w2OWVVTjU1eVBjenNlT0owL1hsUlNG?=
 =?utf-8?B?MDFYajRnWTRteXBUemlHa0d6NzhlRm41aS9TUkgxdnI0RnVaYURwRGFKZHl6?=
 =?utf-8?B?VUV6NW5vYVNlTFhIUk96b3dtTloxKzAwZXMzMGp1VFEyQUR1M0UvQzV6T3ov?=
 =?utf-8?B?a1pBUUxnN2syRjBUVzFacGRZMHFiNThBazJoUG9STkRKNjJSZ2tURklwUEs1?=
 =?utf-8?B?NFQ5c3JuWmg4eklqRE9sSjlsc1RFeDhsUkZYcXlRVGZEQUJpdW53aDUvWGk5?=
 =?utf-8?B?UVVOTUN1bXJuKytlRTI4MGRnV0pzZUlFZWJLaUZLQWk0MnM3Skt0VTVhMm02?=
 =?utf-8?B?ZmlPUEE1YnpxVyt3dEI2M1g0bXBHR2daYnpjcHZjQzBWZXI5cDJQQ0ErbnND?=
 =?utf-8?B?eW1renJ3Wm9UemdIdVBqSzkrdGNCRTUrT1Mxbzl1MHZ1S3hUZjFmK1NMZnZq?=
 =?utf-8?B?TFNncjJoV2FyRDh2Zy9PRGR5OFF3a3V6TWhVOStoT2YreUltSVJNbWtRckdz?=
 =?utf-8?B?WG5hSmxYSHRIOHYwbnV1VXRHRnN6R2t4UkdzUGswbDZDRld6bUZMUzczTm5J?=
 =?utf-8?B?ZWJSNU1TSUdySzE5Z0p2ZmdkaWJabGtqelBuVWJsQUU2VjdpMm9IcHNkRG1Q?=
 =?utf-8?B?MHI0WmJaZlp1UHVyNlpKaUU5SDJVTGlob2FNVS9tbkZmWkxXNjRLa0w0QjJI?=
 =?utf-8?B?QXhyd3JOS2xZSDZvdVRaTTB4QWtkeko2cGVzQUpCbjRhcm12T0NsaVdzc3Y1?=
 =?utf-8?B?RGhMU0tlV01CaE05U09FSW9FQkR0UGFjU2M0Z3dYeTVhNG1jM3p6RHhEUjN2?=
 =?utf-8?B?bFp5b0cwZnFBNmJJL05OMTByR2hRSFJoK2E5clZKMURiNXhva25TSlI5KzlG?=
 =?utf-8?B?U21LUmtqc0VZdHhsQkZlS0dlSTNNdGU4VmttTTBvODFGWmErZlZTQ1h0dEo1?=
 =?utf-8?Q?NMXKx2lVXZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXFzL2pJdHNiTWR6NHR5VXdLSHJhWmNDbjhiUlM2c1UyRUwxSUlKV3dNY1F2?=
 =?utf-8?B?S1NScmFJazQzNnhjaHFONmJCL0VvM3RackRtRXllcWw3RjVTZk5HR0RrWDhs?=
 =?utf-8?B?dUpLZHdIekpyZjNwb2k2RzdIVjQxNFUzQit0dmdRUm1SQU8vd2F5Y1Q3Q0NB?=
 =?utf-8?B?WXpEeDEvRlNqcXEySXg5RUI2bzQ4aXNmMElHQTdYbmxzM29KcXVVTU9odFA3?=
 =?utf-8?B?eEwzZmU4NkhqRGZ1WmtTNHo0SFFnS2lsZmNQY3N3bmNGdS9wU1JGc3FZM1Nh?=
 =?utf-8?B?TjVMYmU2UnRZYjQ3VmFacGhxUXB6NW1USURoU3ZXWEtmeVdlRDQ1SlNRaXhu?=
 =?utf-8?B?U1ZOcU80bkpRVWFCdmlvT0tCMFV0emJTRmtDdThHbHFGbFlyd0J0c0J5ZXZO?=
 =?utf-8?B?V2ZXMHFVVEx3cGNrYXZISitZeFFNN1pYYmhxQ0VKNERPVWtock1OT0pkU3hv?=
 =?utf-8?B?TWEvZkt2bjI3aWJIQzRBekVBMWI3L2N2eUFsTGx5aXFWSE44VjUvdUhONWRO?=
 =?utf-8?B?MXBCWitGaGtKMENmSWw3ZDB6VngwNU5UdzdCcUVDemlacUpjNGtGQmsrQ0sv?=
 =?utf-8?B?eEkyMEJVZkZSTU1FR2crUWZISnBRZVJ5anpneFdCajRHV2xuRkI3MmwzcmZp?=
 =?utf-8?B?dW1GTVpyRkU0OHA3aGxMWDBQbHI5bHIyV3EwQXBQV1dXQjV3alJzb0xXMDZF?=
 =?utf-8?B?WHJDdlBYSEp6RlFBSnpwSU80L0x1T3hubWlnY2llanh5am9xdmhMVkVGNS83?=
 =?utf-8?B?M0Jod2lqZnNyQ1NPT043V0VVNXB2Z0h0Z3R0dkF1OVk4RmkyeXEwMVZEd2JV?=
 =?utf-8?B?TWhGZEM4Y3czUzNoN0ROR3BsallCSStyOG92OS8vV1d0dThyR1FDakFoczVl?=
 =?utf-8?B?VnlrdUt6OVdFb2ZWYXhQMm9ENFMxbFpod2ZFZU9vZG0rTUlXaWNwdTJmT2dF?=
 =?utf-8?B?Ri9BbnFVV2tPdEhQeUo5UGp2dDB6V01tenZJWUpZZGd6Qk9nR1pLdlN6ZEhh?=
 =?utf-8?B?RmRrRmxVNENlNDQwcmZTaUdrUys3WHNVUEJ5TzltbC9NQXM0b0lJcndJNi95?=
 =?utf-8?B?MTl2Tlk2NHNmeUl0V29id2k4UzR0UHUweVdvb0FqbHphTHZxM3F2YllvOW0v?=
 =?utf-8?B?cFlSdG5EbU16WllHMEdLYzdFelJ0NHVFV05zdE8xOC9ualVPZzFYbVRjcnRZ?=
 =?utf-8?B?blFrLytQVEMvMlZObTViZUEvbDkwamVyajEyVFZiWHo0OU85VldmWlZkZ2U4?=
 =?utf-8?B?ZDNQM0JwRG13ZUJGWWhNa09UUkhBRTdUTDNsYmRtVWk4NHB2VkhEdDlVM05j?=
 =?utf-8?B?aURJNU1oOUl4WTVhUGFIUGRLY0QwdGFsSkNnemwrQnVpSG1SUGNSa25OR2RD?=
 =?utf-8?B?MlBTVzd0cFZmaXNWU3VhcTA2akswOVdoMWlUbmVreVh5c3loaFlPbHhNWm5x?=
 =?utf-8?B?SWppVjVrMnFFNDRvVFIwQWE3ZUw4bFhIcmd4a0JzVnFTa0FVT0VuYU1iUmRt?=
 =?utf-8?B?YUNxbzhmUlZjWHFtMnY3bHFlL1pHTWVTTisvbHoxRXJrOGtJOTN0Ymt2Rk9o?=
 =?utf-8?B?RkVwd0VsaUFoUy9OQjRTN2tPVlB3ell3a05rOS9sU2ZyWndJbHUzN2hmSytL?=
 =?utf-8?B?Rm5OWDBCc0ZoeUtRa3U2bDBmdVdQMEdTcGwxZjdDeVkrbGhkcnkvdVN1R2Z6?=
 =?utf-8?B?cDYrbXlwa2dnQS9KZUJZZ1JncThGN1JQa0RvSjRncW54WE8wVG5WMTltWkQ5?=
 =?utf-8?B?QWtyQWQ1RTZGVG9zUHF5dS8zNkptZXp3ajVjVG5ONG8wems3cTNBMnlYTUVN?=
 =?utf-8?B?Z1pYNklaOSt3czlvSDBpVXBvY29BODdXRmp4ZWlqZTJoZDF1dDdNRVloWlla?=
 =?utf-8?B?dmVicjNIRmZhR3lmTk10UHpMNERTbStsOFpKdmhRNXk4QzIxSCtQZS9US1ZC?=
 =?utf-8?B?dU9ySU5zeXo5OUNDNEZMR0ZDeUdDbXRXVmV1RGd1UzIvQVhFa3k1dUF0YVQ5?=
 =?utf-8?B?d05Ia0kxbC91QlQ2eFFtSFM1V2FoTVVzMDRJS01NQUVvNndIQWxsT1MxdUtJ?=
 =?utf-8?B?M095Yi9XRGMxY0VIeGtVVXplQVRPOUI5ZHNweGVwQzR6ZHZrN25QTXdPVitN?=
 =?utf-8?B?ZDJFM3h0MHNQc1pDeENXL1NKVUt6VlNpUkt6L1BkTE4wOTUwb0tUcXovUjdz?=
 =?utf-8?B?ZE5rRktlMzBhSU5PRklJd2RwaGNlRXR3TXJBZnhZcnAwRUJyY3o0UTVqakhT?=
 =?utf-8?B?MENPTEFRWnhsSFlkejZaWmRqdFF3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf6edac-13d0-4843-c5ff-08dd831848f7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:10:48.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjZZQhmNkJsOSIZGrzOWYisV/W0nI/BZVM7WZl79Z9fhEWR6IbTHgTBeVXIzBmBNBU1N6MLIrnPy3FhjNUu4KWlvCiPKwEUEUS8/zw11xUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7707
X-Proofpoint-GUID: 8MXimUJ03tCJBfxjDUuK1o3ul7jl8spN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NyBTYWx0ZWRfX0KVUtAdhFatn
 Kb3SAviJ/hwZCycp3Hye3IQXZKPZf/88PSEPkjGLUOpblyq1J2WJZlxOUSlDA5csglj+n2uR/FZ
 O+9OuOfXGKjRAaY9fQkEuw71GTBLBgXIUKp01A/fO8Bn6qWF0cwxcwopeerEcNR94nsOeLyCQsD
 C1SU7qvEUZTmiTYIfzjYRrux/t+cTwDTJF6SNZomlFjPYkZkFKR5XjIR102CStXsH6EOVrOQ+m2
 ubo9lXpIzwXmFaICW0OWQaHEgz19tL9c+Vlmrfw0gJBOaC57HtADDu4FanDYBUl3aP8w/sjPYpt
 bfiJ96WiFTN47C3wDAHXL3jj6seI/nFo1TqHs6W+Lk250JA+EzvWbww03wArYh4XWhUqkA0h07A
 cNAO+rWJ0hVUyiKHQfjpsFnIjEXDwSYFkBY8R98wvlttAU6oX8v8GVfXmPtAWT2BJgw5UTdj
X-Authority-Analysis: v=2.4 cv=PNMP+eqC c=1 sm=1 tr=0 ts=680a0e30 cx=c_pps
 a=WlqDjRht0D+wB3AL0MAriA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=dIabXLhwAeMblNxl1_kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8MXimUJ03tCJBfxjDUuK1o3ul7jl8spN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

> In commit 3549118b498 we moved cpu_loop_exit*() declarations to
> "exec/cpu-common.h" but neglected to update tcg-stub.c. We missed
> it because "exec/cpu-common.h" is indirectly pulled in via
> "exec/exec-all.h" -> "exec/translation-block.h". Include it
> directly instead of the not necessary "exec/exec-all.h".
> 
> Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
> removed the need for "exec/tb-flush.h", so remote it too.
> 
> Fixes: 3549118b498 ("exec: Move cpu_loop_foo() functions to 'cpu-common.h'")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/stubs/tcg-stub.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index b2b9881bdfb..3b76b8b17c1 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -11,8 +11,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/tb-flush.h"
> -#include "exec/exec-all.h"
> +#include "exec/cpu-common.h"
>   
>   G_NORETURN void cpu_loop_exit(CPUState *cpu)
>   {

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


