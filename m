Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B99EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM96W-0005mt-Lr; Fri, 13 Dec 2024 12:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM96V-0005mj-B1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:05:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tM96S-0003yA-Sb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:05:27 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDDjnVW005823;
 Fri, 13 Dec 2024 17:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=ILa7E4fs/bKZQohwkYVOqBCWuNqZq4SqSmY8RUjaqys=; b=
 i9wQEd6IHmQ1b8Dp/GyL29XwLUCOlMLIMJtK0Av6WA8y1jocskNzksJ5O92KArmg
 kxW2Ju8AcAqg4vPygWF/ijgaxWejPF6gtYaaEtL7mNuKJ0BPVNpmq5OM6VJ/vXvL
 0LW+sKhll60ogqqtxzp9liAfItuck4vCeqKnVrIvMYVTrPnhT3bzmPYBUHiV3EB4
 hhF9bd9DgkmfJVoFR1fhLKh4YW/u3GrOZx13FzlwFWaqGhgYehbashKCPqsi4D4d
 x56IezXNWN5EIs11otUqfUh8gk1EEn3kvCQYiaBaRLXbiJqT9JLVuKRYPqEfUNmy
 qM0hilpIhK973wSls+m0sw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9aww28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 17:05:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BDH0Uib035682; Fri, 13 Dec 2024 17:05:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctcy9q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 17:05:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWDJQF87zpbN2+roIWf5+HUi2DBu7cwT1hKGkVBfbV2ewQUvM+3A055X7aFElNvijGrnzPjdGmyiucUduWW66u4qx3EuqH+xQBrcWfaxPg4/ehhWDhBKXsjJbnr3nJtgHyqzj4FDofmZGbyBiQmwuN9YNrhISNsLZITkDhkMulhQCTMLxaxBlbmfUJ9HwzlGHkqUJOEw9LpGnRmpcbcWHEM8TD9xFiBKl3e6z2SrkrYBsqVy1mmLpo92+2VtZQIClGtxEzyFgTv477+yRKo3BMO437Bq0kxJp0KPdibMP9RXMYAS/dm/LLhV0HcZhPVeo6iq5OfYmP+iJFZeD8u+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILa7E4fs/bKZQohwkYVOqBCWuNqZq4SqSmY8RUjaqys=;
 b=b2R5TVD0UQwuT3b3BXlC//hH5d6Xc2clKqIjmH362zPy6o/Y2VG+iy+tWdNeumOtqQgM10tbg8JuSIgsWW9ue+rr/RgxiW4BGLc5DEyXq9PF5e06ebrYwath0+zjkIsI2xxncz5Y4Op75EGZsehKw1ougr3HrtOgInogAafqMFVCiTCosuncoHaHci7XePt0tNoqncozCHoreOJ2RRPWR20E95tlzfhmOgu7seYRqnpYFhDHF9Tw63TM/m5EoLCCFxaS6yJT7fhVTid3dx6atCzeWhRHCwxSN9m2WOC8ckMK7Yat/kw7hJ9QmoohcQ+uGImqdCXN2ZnrpfeDtPMGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILa7E4fs/bKZQohwkYVOqBCWuNqZq4SqSmY8RUjaqys=;
 b=Foe9ueuISbybyqY5Oc5mKpOJm3nDk6q153mhLlA8cDtl4Js1R6ksoTRELVtjbOWhH5DhbywirdbI5KRYdoAQsg0ViuAs87Zgm/DJ7Fmeo1c6+zw2j8sCanTBtGE3T9hWiQSi10pEnbrVnSRRA2T4QsN0OqV6Tir/mqynP0jNLq4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7248.namprd10.prod.outlook.com (2603:10b6:8:fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:05:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:05:16 +0000
Message-ID: <55199817-b92b-4f3f-b4f5-d3dbc9478dc5@oracle.com>
Date: Fri, 13 Dec 2024 12:05:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n> <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
 <Z1tUBUcpf1XcVRhG@x1n> <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
Content-Language: en-US
In-Reply-To: <bf0e7550-54a0-42ff-a281-6a65cb1ba7b5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 3667c482-4fde-41e7-2697-08dd1b9850fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjJxb3lKOUorclZnRHl5cXdRMWt3Z0ZjY3g4U1pJNU1IcDlHZFJjV0JXZDZX?=
 =?utf-8?B?WUc5a2JsRW9lY3JFWmtET3dLbVpQTFUzN28rTlRVM3c4eUl6RGJYbWs4citw?=
 =?utf-8?B?QnV0WW5iSDVRa3NmZXFlOUR5dmpWNnkxR0FZdldFMW5MZjUrT0FibmpZVFBT?=
 =?utf-8?B?c2dpSG91N3JodWRFMlhyRVp1QzhvcWhzZFZjdGhLNTNxdWxjOGdIdjRMNksr?=
 =?utf-8?B?WSszM1hPS0E2ODBlUldjbWtnekVJQk5scS91UWxTaVdBYTV4RjRLdy9tN2VE?=
 =?utf-8?B?QkVFMGRZYXFYSEMxV1J5ZmlzK25TVHlTVndsbUJqUGtydHNqNlNlTGRONDlK?=
 =?utf-8?B?bEJYOVZTd3o2eDRPek82bzVUak9ScDRFbnB5Kzg4aUhtNVR1djZDQWRRcHNE?=
 =?utf-8?B?dVI2clIzZnRXVHIzL0dNUm83WElnOGVZUzdPeFJIZzdvdXFZb0tpZlNEd0Vv?=
 =?utf-8?B?dk10TWZBWDUweVNqR3I5N2JuWUJ1aURia1ZabU50eU5IRndJa1Y4aDJKY1JL?=
 =?utf-8?B?TzJZQk9BYUtJejhvemtleTBsbnYxV0FKbS8yUlFVaU5VRklvQUlUNUJ1dXc4?=
 =?utf-8?B?aUpFVUtKVGsvWTc2RkErYWR2ay9qck1wQ2ZCclphM1RobTV1MnVlM2I1WEFz?=
 =?utf-8?B?ZVBTMmFUdlFNSXpTbm0vb285aEJrZk1VU0NGOEd0dVlGRk5yb25LcDR1OVdW?=
 =?utf-8?B?b2c2dTlGNUNFM1ZHdzJPVGRBSzVMdUF4TS8vZTVKZnkwcFA4YS91TDY0eEc3?=
 =?utf-8?B?OXZDemREM2hWcktpTElFdkxKTm1HWHMvc2RSditTMDhjSGZkekZZSXlEMENu?=
 =?utf-8?B?VlAzYXBwaC9KQkRNZm14c01mTTNteGFIUXY0VmpYaHR0ejIzMTNBSE9pS01X?=
 =?utf-8?B?MkJwREQxQjFBWFlyb1A3Qm1qTmtkT0xKZldsWTZBWjNKOFBYd0dENWgydWJo?=
 =?utf-8?B?RTVaTHB1NkQ0ZGZaMVdDNlgzVFdSQlA0N0l0UENDa0xrbVQ3Z3FmeGtwbjJx?=
 =?utf-8?B?Zytsak9LNWJ5WVBTK2xpZHo2QlNyY1d3V0VvT0lPQlVHR3BUNlVIREZVZDVH?=
 =?utf-8?B?Q1p2aTVCNkxZemNSRTkwKzdhS295c2tKQWVZMDAyR3UzaUQweFUvYzA1UzBW?=
 =?utf-8?B?ZFNnTzArMUJ0UGhBclFmdkRTY082OW14bE4zSWtkMzBqM1VzancyenNxZDR4?=
 =?utf-8?B?K3JyRTY2L2VweDdkOEQwdWJWUmNJQy9zMVBid25JYmExOVhrczdRLzZSN0RK?=
 =?utf-8?B?cVl0enRKV2lxTjFYOHdtYWtUT0kwdHByM2N1eWptQ0dIdERTNDZOTmsyUWdD?=
 =?utf-8?B?WUE3aEY3Y0wxb0phOGE3RVNBRmhSQ1djcVlsS0JFWkRVSGtMS211aEliRnNW?=
 =?utf-8?B?ZDJrcllLRTZaVWFESVcxbDIzeWJ1amhmVUdBTnBpOThsNFJuY2ZhRVo4YUtn?=
 =?utf-8?B?MnJtWmc4aUdWZGVCUjBETnMvVmFYU3NRRG84Zkc3aXE1VmVPbTM3VUp3TGQ0?=
 =?utf-8?B?VHVqVSthdXo5eXFLbk5PMmFiRTdqS0ZONW9PWDlseHNDbTNubUhFakJjb2ly?=
 =?utf-8?B?anBQL3k0a21qeDRoWVR1ZkNyZkpQbUJuRkhkQXBCU1ZoYzZZc3lvaUFMZVRG?=
 =?utf-8?B?TjJVWHk2UDVsZm5UaVdwbEpDbS8reTByTnZWdTRCcXFjeGNVQUNNMnBvYUk1?=
 =?utf-8?B?MjFoRkRvZTJ5cElZV1Y4Sjd0OHliTlAvTk1jZlNSY2tPWUNpT21QVHZZT3dN?=
 =?utf-8?B?VjVVZ0lYaVFaeG9GdnRXN3Rqd2V5RlBvdnFEdy9pUzQ4VlAyTkEvT0l6Umdm?=
 =?utf-8?B?ZmMxL2dqdGh2YzdHNG9xZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndzQTBkbmRncmJFcmdsbVJhQ1ZYdXJJZHpHZ293Mk9OVjVhc1RNaEo4OEhF?=
 =?utf-8?B?Vk1BaVB5bnJFaE9IN2hDT2loU2FCZm5CYzIyYVZRRkJzMFBtYUtHWnJ4MzlD?=
 =?utf-8?B?K3V0a3dvam9UN1NjTHMwQWFLY3RPN21RbzJxRUJmLy9pUThhNnAwbWpsRjNH?=
 =?utf-8?B?UG5QdytQR0ZwQUVrb1l5amhSN0h5YVJqTjF2eTMwelViL1d3Q3phekVVNlox?=
 =?utf-8?B?dGw1NS9WSGg5TUVIYmgyTC9FQm00dy9lcWI5T0ladmtyL1VOaUZjYWw4RzZY?=
 =?utf-8?B?WWdIaHRLeGp4SDlBZHY3UU80WnNZNzM0QlNUSnZpcEE3bUhCSS9naTdYcDJz?=
 =?utf-8?B?aEYwRnZ5U0xrQW9oQlBtVStFL1RRNk5qbXV0Mm41OGY0aHhOaFo2eUloQ2dL?=
 =?utf-8?B?M25RYnBhZ0dsN1VYMmVVM2t1RWpxOTlSNjVNd2t3REl4N2M0VDFSb2xyeWw0?=
 =?utf-8?B?bXNwUWZkT3V3OEwxOCtpbUhpU0w5VFdpQXppZFVLU2xYb1dSZTRQWmEzVE1p?=
 =?utf-8?B?aHpvSE5RSnlyeUE0OGltOWxwUEs2ZlB1NXJWdllYRTdZbmhveDVEdUxmemUx?=
 =?utf-8?B?ei9qcWptS2lpMDk2ZUxud3hiWWF1OU8zMDc0RE5Qa2lGK0dPczY5RmcwdWxz?=
 =?utf-8?B?Z1pDbWtQbmxscUxsamFlWHlHL1VwK000VkZFN1gvdXlOOVY5ZTJCT3FvZ3dM?=
 =?utf-8?B?cEhaWlNrdGtKdlJoQmh1QjNPbVcrSWlxbWV0MDhJT3BJS0w4cWxaYnoyNkFN?=
 =?utf-8?B?NWFUbUp6TEN2THF3clFlU2VlbEYxZUtsVDE0eUh5ZE9qZFhjajlvZjhkOEtO?=
 =?utf-8?B?RytXZG45SXp6RkFnS3RHc0NYMFYxZ1FESVdpSlJZN3djZW1zZGhtV0N0S0gr?=
 =?utf-8?B?VVVraGV2WENUYStLQmV0NkdnS3RCclMzcDlWREhOTiszamQrRVpQM20yWE53?=
 =?utf-8?B?VGFtZjJ2MHpTbW9ZTUNqaFltVnIvSkFqQ3BKaDV4L0Q4bGUvdTlEWURCUHdr?=
 =?utf-8?B?dXl1THdCUU51bGxqbWdCNFBWUU9uWnZ6by9SbzJUOU1DdEV0aHJZKzhUZzFR?=
 =?utf-8?B?REFzbDJaa3RhTmJPUjdEdkgzalhjYXhVWTVOcWROTDlhNG05clVLR0VnMnNH?=
 =?utf-8?B?UjBJVnByVXJFdlFQV0l6YSsxVnhveHdzeE92cXBBMDRYNUFsNWlKdmZsdndM?=
 =?utf-8?B?MEdBVmUvOFhucDRQb2VWWEVabC91cG9tSVZMSnkyeHExVjcvSGg4TWRaUlkz?=
 =?utf-8?B?TUFDcC8zVXVpVis2UnJuSzZybGdia2JSa1hWNENPcHM4RWtWQ3NzNVI2VVl4?=
 =?utf-8?B?ZUpsb0tZc3BZV29KNUF2Rlhhei91Vk5GUTk3T1FienVQZmc5RTZoTDNjdzV0?=
 =?utf-8?B?RjlvRnplbUpYVUszYWpqZlFWMnovb2NJRDZ2UkxjRlBROHdjbFNmUGt0dERS?=
 =?utf-8?B?VVlPRmp6aFBIWGk2K3hVYWltQUFRVHY5WXFpeUZiemNvN2cyd2o3SCt3RSts?=
 =?utf-8?B?emVJSm5yWGdzSU9sSlFwSVhEbFFlM1FFYmt1NDRzays4WnhwQjF4WDVvNmNx?=
 =?utf-8?B?OFhqbmJhR05oYlcvTzNzeW1SUkRMVjFpWkpwdGp3UEEzd1EzWVZDTjM2TGs0?=
 =?utf-8?B?N284LzNJZFovdklkbkhCdlNMY0x1T3dTdkJHWVR4TmdnY0ZrL0RyTHFQMGY1?=
 =?utf-8?B?Q2xyb1hPUFJ6UU5mTHFVR20wZGE1YVpVdTlLSXBxeGpsMHhkUnFSSk5IbG5s?=
 =?utf-8?B?NG52d2R3S2lxTGkvUjVjMjFhTWRYQWp1TDcySnpEaW5xdnVTUjl1RnU1aXJO?=
 =?utf-8?B?M0U5YUtaQXlpem5mZnJ2Rm9GeG5RajZqcjQxc2poY3JXUndnMDhWek85UUdZ?=
 =?utf-8?B?SGJ6YWdVbGlXNE9tYWN4UXdSbXphOXFtb3VjVGJzV0d0RE81aFdSTmpsMXQ5?=
 =?utf-8?B?UEFlUldjVE8wK2U2dHRqeWNSMmxoREpUUXUwL1pNTmJ6L3Mwd3Jnbit4Y0c1?=
 =?utf-8?B?TmNXYnFZUUcxdXZCOGk0ZnIrc2lSWGxnLzRmZzY1YU5EK1R2d09jdk00Y1J2?=
 =?utf-8?B?MjZGNHYwNmVrQlA2UkowTlY2YzdHQTJGd01DM2NUMzRXZnRnMFFYRldaVGxE?=
 =?utf-8?B?RGlLbnZHTG40ME1YNlFiYzJGWWE4ZWpPbG1NSng5M0oxOWNGNTBaTktUWWJD?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uaiqfrovETECDM+R1R+wgYWSiJ77MRbjJvRIzIVrhuyvql45MHYjWbr/oZzWNTrZ6wbt/3RtkwgzNpEQ088TvppvKuLMKUyVcqZkawW3vJ4BhmIqRL43R5GtJiaynzUdOhynUqTvBBnVy8DQ0+STEHmZDE/zt2e2E+RTlWdg/hWZUzvsbEdyvWmFratcYLwqw9f31q9NOwa1IC9nnskHCCpdCbPThcGAY+eNnEjqXwg69xoP1gDl/C986vsUjg8OhHdRlNgN0uxZaUuVCO3cd0CVKdTpnjb5JB+2K2MWBDckyfYkEw8Y1UqfOs/Tv8yOU4QJedhtfEIhe6vRA+eoKhf6DXQphsH7/4CO1mvMWZq4qSk9XswajstDphV4l98ckxVZanfchdyiWNCNEsoeIFyDakPuoeH1xEHWDUIFp5jZv9Vp+pHwz1o2UTAZLChyYsQeoP77eB2Cm1t71OXEv/2L2hzOusYgkM2DXfcZZjBF80mRAJqh1TRYxYtptMi/1ce5t4hirzX4fMajhV5hV+bsvJKbDsTZYzRMN94XHawxdK62daBqNKfz/16Hd3LUhy2NiDTEI6e5M1NBQrfsJWW0JvgzbXaem6YPzlRZOrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3667c482-4fde-41e7-2697-08dd1b9850fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:05:16.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7l5+Ngtj4N1SUUit261bt9N1yUbhxcBqtjWvGd+t2tAIFfyk2IlGswKSRoZWmf4mo0VGtxYnBQYqjXlHKRPCtlEfSznbE2rDOU65dDQXFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_07,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130120
X-Proofpoint-GUID: OHZ-ey_9wEFG97vYnKWrarhliKjfrS_v
X-Proofpoint-ORIG-GUID: OHZ-ey_9wEFG97vYnKWrarhliKjfrS_v
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 12/13/2024 11:41 AM, Steven Sistare wrote:
> On 12/12/2024 4:22 PM, Peter Xu wrote:
>> On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
>>> On 12/9/2024 2:42 PM, Peter Xu wrote:
>>>> On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
>>>>> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>>>>        new_block->page_size = qemu_real_host_page_size();
>>>>>        new_block->host = host;
>>>>>        new_block->flags = ram_flags;
>>>>> +
>>>>> +    if (!host && !xen_enabled()) {
>>>>
>>>> Adding one more xen check is unnecessary.  This patch needed it could mean
>>>> that the patch can be refactored.. because we have xen checks in both
>>>> ram_block_add() and also in the fd allocation path.
>>>>
>>>> At the meantime, see:
>>>>
>>>> qemu_ram_alloc_from_fd():
>>>>       if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>>           error_setg(errp,
>>>>                      "host lacks kvm mmu notifiers, -mem-path unsupported");
>>>>           return NULL;
>>>>       }
>>>>
>>>> I don't think any decent kernel could hit this, but that could be another
>>>> sign that this patch duplicated some file allocations.
>>>>
>>>>> +        if ((new_block->flags & RAM_SHARED) &&
>>>>> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
>>>>> +            goto err;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>>        ram_block_add(new_block, &local_err);
>>>>> -    if (local_err) {
>>>>> -        g_free(new_block);
>>>>> -        error_propagate(errp, local_err);
>>>>> -        return NULL;
>>>>> +    if (!local_err) {
>>>>> +        return new_block;
>>>>>        }
>>>>> -    return new_block;
>>>>> +
>>>>> +err:
>>>>> +    g_free(new_block);
>>>>> +    error_propagate(errp, local_err);
>>>>> +    return NULL;
>>>>>    }
>>>>
>>>> IIUC we only need to conditionally convert an anon-allocation into an
>>>> fd-allocation, and then we don't need to mostly duplicate
>>>> qemu_ram_alloc_from_fd(), instead we reuse it.
>>>>
>>>> I do have a few other comments elsewhere, but when I was trying to comment.
>>>> E.g., we either shouldn't need to bother caching qemu_memfd_check()
>>>> results, or do it in qemu_memfd_check() directly.. and some more.
>>>
>>> Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
>>> and qemu_memfd_check will be called more often.  I'll cache the result inside
>>> qemu_memfd_check for the special case of flags=0.
>>
>> OK.
>>
>>>
>>>> Then I think it's easier I provide a patch, and also show that it can be
>>>> also smaller changes to do the same thing, with everything fixed up
>>>> (e.g. addressing above mmu notifier missing issue).  What do you think as
>>>> below?
>>>
>>> The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
>>> which buys the xen and kvm checks for free.  Sounds good, I will do that in the
>>> context of my patch.
>>>
>>> Here are some other changes in your patch, and my responses:
>>>
>>> I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
>>>
>>> However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
>>
>> I guess no huge deal on these, however since we're talking..  Is that
>> QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
>>
>> A quick dig tells me that it was used to be for anon THPs..
>>
>>      commit 36b586284e678da28df3af9fd0907d2b16f9311c
>>      Author: Avi Kivity <avi@redhat.com>
>>      Date:   Mon Sep 5 11:07:05 2011 +0300
>>
>>      qemu_vmalloc: align properly for transparent hugepages and KVM
>>
>> And I'm guessing if at that time was also majorly for guest ram.
>>
>> Considering that this path won't make an effect until the new aux mem
>> option is on, I'd think it better to stick without anything special like
>> QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
>> to explicitly mention this in that commit message:
>>
>>      Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
>>      to avoid fragmentation.
>>
>> And this is exactly mostly small regions when it's AUX.. probably except
>> VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
>> it'll be totally different things.
>>
>> So I won't worry on that 2M alignment, and I will try to not carry over
>> that, because then trying to remove it will be harder.. even when we want.
> 
> Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
> qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
> no performance regression, as some of them are larger than 2M and would
> benefit from using huge pages.  The VA fragmentation is trivial for this small
> number of aux blocks in a 64-bit address space, and is no different than it was
> for qemu_anon_ram_alloc.
> 
>> For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?
> 
> qemu sets cloexec for all descriptors it opens to prevent them from accidentally
> being leaked to another process via fork+exec.
> 
>> For 3rd, tracepoint would definitely be fine whenever you feel necessary.
>>
>>> Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
>>> and not fall back, because something unexpected went wrong.  David said the same.
>>
>> Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
>> In that case, Xen fails there and fallback to xen_ram_alloc() inside the
>> later call to ram_block_add(), no?
> 
> Why -- because something went wrong that should have worked, and we should report the
> first fault so its cause can be fixed and cpr can be used.
> 
> However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
> fails because of xen or kvm, I would need to return different error codes from
> qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
> qemu_ram_alloc_from_fd.
> 
> And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
> to modify the call site in the patch accordingly.

And qemu_ram_alloc_from_fd does not accept RAM_RESIZEABLE. More tweaking required.

- Steve

> Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
> is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
> kvm_has_sync_mmu checks in qemu_ram_alloc_internal.
> 
> - Steve



