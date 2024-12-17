Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C035AE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNfXA-0007RN-TV; Tue, 17 Dec 2024 16:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNfX8-0007Qo-99
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:55:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tNfWy-0000G4-9A
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:55:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHKtidw012958;
 Tue, 17 Dec 2024 21:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=wPfyR3vtFJOENdoVCiUVvkOXv+1vaiu9THaX1++FLX0=; b=
 Qv+kQSCt2IgH/G8uvbkRMlE1eWGKW8c4eTzZqwpZr8f5w5k4OzQK1gNu4Y5JNkQ1
 w7yzPqoLgV+QmtriE8cEzJSkwq8SbsxNm3bIf3MtUPvvK+jR9wRdK/R57/2kQB9p
 6bMH7KVOXhOu6f0D7azjt/FqYcN5+k2t0DDPC5Tm5n55yU/xY5DFq4cIDOIBanl5
 gtxOYXiGt0fR+/MZMje4eD6mvsWkV4sMwCStWiw18Hqq00xlDhJAIwUL9+IYLBwN
 ymrhGT2ZLkNmD0BCSFw3YLsXF6NtgOH4IwSGFsrCAV5S57I/4QKdGsSUx7Mxxhti
 YTLpg+C8LwC0diJyFcHMuQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9f5dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 21:54:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BHLZ6df032770; Tue, 17 Dec 2024 21:54:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0ff916f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 21:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtITVabB7SWPUgPfzSUPUV89AOzHys0qSftbgDXG/3Ifs8LDtVPQ4CXr929Ccs/n7M5pC1JNSCEbX9UOLhQ7SARVb6k0A5Rr14sFht46Spy0FAevrJ+b+3TyrfIP7GAA5eB97aRFkK2uqgXceluphGyDDg2Dq65BAqJs8scl+CERiHueConUDbH4Zjv+gZyrhjIldkZd/xHYS1rbxfK/Z6EHKjkkLDztawhF7UIa/J+Y/GxiPzEuZwSBrqmZktV/OC8KQHQZ9A+5C8oHE27FUqjOV8LptTqD3FiKLmUptQIwJajy3Xm2AlFqimu+99IHQ7WU1qItaKeDjv9zTqZXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPfyR3vtFJOENdoVCiUVvkOXv+1vaiu9THaX1++FLX0=;
 b=S59M2nb8lou5PG5NgjuH35XTJVAX2riDFJ0ySCpfxLmh4yaI5pEbQsj9p0JE3rtOGQP7gn09P8sTpfPGCtTKZFLOk/XZyGx7fInBlwP9Osb0/K0zqH9dvkub3HiQ2BSKczqCNPMj9JYPpsZegun8yljjCbHesrc0s5bcbNakoTYG116fhagD0HraDBDOsWuuVAE4mrbdiwI5bgE6P5H3J+UdlvX3zzGvm34cIDEnuc9yWnhodoKWksT/jWUVQcXU58nGQhWt9kOQAc6+KBeknipAK0mq84ak9p6PD6frBtBhohD8UwD8mHU1fHH3vFfxM3Qq39KgpYF78+aVlKzFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPfyR3vtFJOENdoVCiUVvkOXv+1vaiu9THaX1++FLX0=;
 b=pGVdJOZoBhwUwVaaaN3Gv5zt50eAekpwYebdQFm2KeH/IQ8K9hsBx/Fkd17Y++3mKZBPGRD2ocE1ahXAVhgWlO4cv1XF4CPEHPoChQGkoG8uUIRS6tZuncEaQdIgHVGswkCQP2MIaNWASzHqlAi5UnCBaN+TmXVMEq6eA+kFG/0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8020.namprd10.prod.outlook.com (2603:10b6:208:50d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 21:54:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 21:54:51 +0000
Message-ID: <7acde39b-9448-408d-894c-6fd96eb2324e@oracle.com>
Date: Tue, 17 Dec 2024 16:54:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
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
 <Z2BvNs1zTz42Tpqx@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2BvNs1zTz42Tpqx@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a36653-58b4-46ac-b293-08dd1ee56ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJyV2JzNHRjc3N6OWU3QnVHSUkwemVrSnNLcHFWNUpTZ1JGa3VySmpZZU1Q?=
 =?utf-8?B?bjN4ME1jUnhEd1FwMVlicU5hUVA4K2wvUVRQdEFkditsY1Q4L3NaRUl1N3NT?=
 =?utf-8?B?QWdBeDdVQzR5dDkrVlAxZmNpSGJ3NXFweDRsR2FCTXZ0NnE5dHNDMEFCcVNz?=
 =?utf-8?B?TjBHRFhmNHhQV01tY3BDcU9TMVVLL2NRaUVjNmpzTmdxYVY4SXE5NHpNTkVE?=
 =?utf-8?B?dWo1TUhiaHN1alkvenh1THRvVGJvQ3p4QzBudG53cXRWTDlNbEYrNk1HdHFW?=
 =?utf-8?B?UUVYQ0VlZU1MNmc0Z3IxaEZyWE5Gb1p0TnlPdkhnZGNOWDMvU0lJVVpKcE9I?=
 =?utf-8?B?Z3c0NDcyWlp3N0YwOHNYeXkxOGZOZHZoUEVTNUEzUXM3MmZicmExRFI5cEUx?=
 =?utf-8?B?UXZLOTF2OVVud3Yrak5wRXV3TlZUeEQxMTI4WUhoTWl0ZURndFRIdG9hZkg4?=
 =?utf-8?B?K3AxK0o1WmZxeHhNTVRSK041UEpFUGhGemlUVS9VS2lPSndPM0JMVUlCVFZR?=
 =?utf-8?B?Um1acTlxMytHeHcyamRGYjFwdVo3alhMUFhCSVFTaU1BOGVhOUdEL1pEUzZ2?=
 =?utf-8?B?Y0FjbUtkK3NGUEtmem52Qit1Q2JiRmNxL1ZOMDBFQmNKdk9CVitRVjVqWG5k?=
 =?utf-8?B?b2l3TFhBQlJSQ0Q5WXRVM3hNRGJBZ2JRaVRKS04yM3N2cGJOaVhUY0VkcFdL?=
 =?utf-8?B?U3krVm95bG15UXBVa0ZLSTVzOWNMdmo3UGtCcm14WFdZVEFRYUt0VXNmd09L?=
 =?utf-8?B?MUtyejQyMUg1VVJ5OTRSZEhmaEZKQmVnTkZWbWZhRUJGNDdNcjcrTjk5Nkli?=
 =?utf-8?B?VzFRT0IzdHlYcXF2a0hFdVM2NzhYSHZKbDNNR0o2b3FLRHRGY3A0ZFU4bjZX?=
 =?utf-8?B?K0t1c2RGZGNRaTNWMVQ4MWs5SThDdHRFREIzMnN0WEVLZ0ZqTzlncWNVVVY2?=
 =?utf-8?B?TWxwTmNBVmdTWUNTR3J1dk9IWGZTSmRtazZvSVlNSWVOaXdHUy8yN1R2ZU4y?=
 =?utf-8?B?N3VZby9FWWVOQi9UUmRnL084UCt1a2YvSVgrbE8ySmNHSkh6OXdPWGpyOWkz?=
 =?utf-8?B?c084SWNsZi81ZkxVTVpSM0VJbGxxaVdidDV1bU1IdG04RUNYUlhyb1V6eG5M?=
 =?utf-8?B?WVdOU1BXTDJVMlJWcU9PQnRZOElBdmRMWUFxOVJ1MTkyNGZOUmR2RmRjcy9Z?=
 =?utf-8?B?NzJ3b0U4OG5mTG9vZVh0STlJTjdBWEQzY1FQeGs1dmtyQWM0a0YxZGJ6R0lB?=
 =?utf-8?B?VWZ4TVBWU2NzU3JMckFoRC9KKytEZnJqemRGNjV0ZVcrVFlvNkFmUzRDWW9n?=
 =?utf-8?B?V2hXVHNlYXZNZi9FM0JuaGh0ZGVxcHl4OXZDNjZtRmJOYXV1MGNBVHNWOWFN?=
 =?utf-8?B?aXhJVk5JRlJrc2lCcXpOSjNucmZObHlEU3ZrQldsMzYwalRhRlNoa3lLbVZi?=
 =?utf-8?B?QzBVUzJSMGxRSXFseSs4SGYzMFVMenkxaVdpRUk3R09pRUFGZWpabi9GRmVC?=
 =?utf-8?B?V1dYcTFPaW5XRFYxcjcxbC9SMng5Y0F2YWdxeVJJL1Q5SFAxWUIyMkFyanlE?=
 =?utf-8?B?MzZBQ1lNdEFMR0p1UGk1YXdMbmtJZ1pBT0h2QlQvbFhqS2ltWUdaeFMxaW9l?=
 =?utf-8?B?NXhzRGp1dkh0d1VFY1BuNVZ5amdhbWFRMW9NRDZNQ3ZpRUl1MEZDSnI5THN4?=
 =?utf-8?B?clhCdmJSQnZsMTkrT0l2ZFBCWHVaYi94amVDd25wWmtkcEpFS3VkUGlrQWVq?=
 =?utf-8?B?ZXd6Q1ZaS2xkYzhGeGJha0VZZG5ocjJGYkFiN2pSbjIzN2puUHVDdVZuWEZ3?=
 =?utf-8?B?Qm5uMU5FMFZTQ090Rm9zZkgybmNjbVMrUUI3YWpNaDNKVzIwWjhDaWwybUE5?=
 =?utf-8?Q?9aalTA2rBSHiY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBvNHJTMEhtUklDZ1RsVURvRGdsL2Rza1ZFb3FEVE9jNEx1K1hwUDFHWitE?=
 =?utf-8?B?T0dIbm9VMnVSODdUTVd3TUNxeWFnYk00b29jQ1ZjSVdCVXhSanl6aXBybDlI?=
 =?utf-8?B?TWg2aXJLbEJxTndHTG90c2oxRm9XNXA0MVlxNkY0MlNtYm90bWppdzdmV01r?=
 =?utf-8?B?elo1MGg1NCs3RTJFU2ZiQ0p5VFRIcHZpZlpYZkZHN2NWOUlPRitkZC9jVkFM?=
 =?utf-8?B?QTBPWXRyUkZWM0VKd1hPaG5JMFRCTUJUejFDU20zbEhHanE3R2hpK1JaZzZK?=
 =?utf-8?B?VkptMFNDZTBIejFwSjh6Y1I0QmN6cWJCa1IraDJRWTZwdjNTbG1LTnFDZVlN?=
 =?utf-8?B?ckNCWkhEL3R5SjdqVURYelRrZkxDbmZMdGxCZUJxSnpuMXkwS0wrM3l1d1Js?=
 =?utf-8?B?QmdjYmRiQTRsQTdjdTVrM3hMRjUrMXU5RGxQanpkL0JiQ2hUbTVLTG9TaDh0?=
 =?utf-8?B?bGEzeFZ5czN3SE5YSWdHN3BxQVkxK1orSEI3QTk2elJ6ci9pSk5KTXcrUzdC?=
 =?utf-8?B?blNJMnlOV2w2bHpVcVlBK2ZkTml6MlNHYTF0YzQ4V0hvVklFbkR0ZkJqNmVO?=
 =?utf-8?B?OFQvZmhxM05nY2lOaGRBQ0R2MG1ScHBudVNiSWh0QjZSUWxRR3lLZGRHWWZP?=
 =?utf-8?B?N29FdEU3TWh6a2lpV2JzTjJHN0lIa2IvaFlYZG1NQ293SHBGbStBaTE1UzBn?=
 =?utf-8?B?alBJVk1oMEdnVHVpS29FQUZBQ0lNeGdLUmFWVllZWHdwVktCRFZ1eFV6aWVL?=
 =?utf-8?B?T2JoV1NTSGtYbTJkdkZpYi91T0ZTTDJHMitYSFlScTBCS1ZqMlRUK3dVM3Bi?=
 =?utf-8?B?SUlMRGdvdHg5b1hTZHM2dDJyZkR4N3drdmIzVzFmSU1EUlpSamhNTjVYd3pW?=
 =?utf-8?B?d2tTK0hzQ0ZmL01FaXhJR2NFLzROdnlYZGJwVW5MeEEwd3hwMlVXMGkrSFl5?=
 =?utf-8?B?aWVsSGM1V0txTnJ5Mit2TEdBVGNTeDFZcjhPZE9EcDVSbVlPZGpZUDZVTWFC?=
 =?utf-8?B?cjNCSSt6NzBqMlBZbFNTRGJSNTdINTBWU0hsRWUwNUFqanRhNkZwSThXQnYw?=
 =?utf-8?B?UVlmTnZPNk8zczVBYktEUEFRZzIyMDkzSWdnaDZXL2ZIeUJjMDBPS09rMVgz?=
 =?utf-8?B?SVdoZVRMT3U2OG5BQWNoZXpqVGFWSGpjNkpCUWVOZzR3cXgvV0lpNElHTWdk?=
 =?utf-8?B?UVM1dndqQXRmVnZ5aHhvYjdYVDlOMG13SFlZdFpGYnlHRUFhdUdNNnRFSjF2?=
 =?utf-8?B?L3FBNGZZbndBTzVDeDBPZlE5ZXNxaGxlbHBzMWxKMGdscXhmVkFweFpVYmU1?=
 =?utf-8?B?aHU1aDczNkI2Smg4TFAweDVHNEZpQytKZDVnUkJVZTZFOFdRenpsOWsxUG85?=
 =?utf-8?B?b0xLOThoemRLMnFmeXJ3UTA0ZFFDclJkdUIvbjlqNytTV1cyQTdoM21GaUVQ?=
 =?utf-8?B?Zm84OEZobk9rQTlJeTMyVGZ0cG5NaHIzdU95OTh2b05zWm1IMkJJNFBsam43?=
 =?utf-8?B?T3drc2NjMjgwOFI0K2FpbHJFajMxdGVMMGs1RGNPQXhZWW1vdlVYN0VOcVRx?=
 =?utf-8?B?elpNdmE5cTNxOWkvLzNtNHFaSzlNUGVSL1ltc2dJaVJQOWZnNFFTQjN5R1pC?=
 =?utf-8?B?dHJZWCtKWUJJRFFEWDhDaTd5Ykcxd0Z5akZHUWhjNXk3cWRoUlJBMnlJUHQz?=
 =?utf-8?B?R3dlOWowZ3l6SFg4NU1oVG4yT0dkWERqYnkzdkZKNjZtZi9rTk9GNHEvTzkw?=
 =?utf-8?B?NDd4QlZxOFM1RnhWUUFNVEVQYWJTdnhDWUpRYkR6R3c2OEZlaU1FYkJwT3JU?=
 =?utf-8?B?VEg4aXN2dy9vWXJrQWIwWE81UEdUZmpzZnpndnBvcjdFQTZjaVpVY0lNREZv?=
 =?utf-8?B?V2RMVml4WVZ3SnRiS2xDR1NteXZlbERpRWJGQWtOTWkyQ2N0ZCtVNDU0enZQ?=
 =?utf-8?B?YzFrRzVLSTVsT3MxTVV3bERBS3hHWWxZMDVMNmhYc1lid3o4d3JLak9rcXY1?=
 =?utf-8?B?dEhldFBweit2M3JKaURxQ0IvVlhIdzAzampwQVlFUm03ZnhHY3B0Z216dW9x?=
 =?utf-8?B?SGtlODAvM3k1YkVRRGo5bDFMdk1vLzFuSWdDUlB1NmJxc2dOY0wzYVBnYUk2?=
 =?utf-8?B?T2dIcHkyV2VXRTh6SUx0dUlheWlRLzd5YTVCclZkSlRTZU1KbWVJT2JxZjd2?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: deMBXUuOkhoC8w99QHqNCivRKpTJX2SG7wIYMT6G0yQfgmocWE4khWg1WnmSAW8fQq0mqPK+sdi4H5dDhu5BDVnZ6lKevXKl/Y+Ys6TO0H3rZ2OGXCn3ZO9/HE24b6qRsVyuaJmxdviQB9p/fUHh+HWSCKT4bKbBDxmoPzR9hSOHi3SGiaEzQEYn7PGeXnbXhWNBR1CQZEgbSWy+Nedbuu3dU9lh+GW9Z748xjAkR9xn5IM2+onS+L1UFVxOvSclOLIUpts8PR0xiM8X6mlptv8qITL4taQKHSe1p9DbdnpxDIhJ3qneqJ3hPitDof0f9RPQx9f7NVKAEU4pIG6u1CIT0ajOyvxFpCRBFxwtz8TPaQ3vuXYBRFyldvrpXPUNnZ8k+Q6cGRw8UXc4xw4zGB07rg+tOUe4TLEom5vyuGajUzf7OHjpCzlLV3M58apTAZFZCS1OsVtT8B4xfq0QaoUItEZp2bsaCw/nBcMw1pgXMfBIlNKI0jSOZPRLIQAt+B4zgigVybVTYi/VAPlYMU2RjA0wFBN1aT6vTUdlUhrqfC5AxkKulPBYUGB8J7CQWhDBcO5z8YvIFSRg5OIEsKbw4oEIXg6YLwPic7QXrq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a36653-58b4-46ac-b293-08dd1ee56ea0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:54:51.0815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4e+3XOiDIaeKYja+jug0jwtLZ64LZfeBsV0Y1G1hZ+Eg4C5eIv/CKVkCY1sgvGaPeJkp4TMk8CfGKpdqijkPsMfCqy6Nh+e0SxV8XGnEiEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_11,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170165
X-Proofpoint-GUID: V5sIVcmdJzwulR8gQzDFqQuuarLJPzs6
X-Proofpoint-ORIG-GUID: V5sIVcmdJzwulR8gQzDFqQuuarLJPzs6
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 12/16/2024 1:19 PM, Peter Xu wrote:
> On Fri, Dec 13, 2024 at 11:41:45AM -0500, Steven Sistare wrote:
>> On 12/12/2024 4:22 PM, Peter Xu wrote:
>>> On Thu, Dec 12, 2024 at 03:38:00PM -0500, Steven Sistare wrote:
>>>> On 12/9/2024 2:42 PM, Peter Xu wrote:
>>>>> On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
>>>>>> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>>>>>         new_block->page_size = qemu_real_host_page_size();
>>>>>>         new_block->host = host;
>>>>>>         new_block->flags = ram_flags;
>>>>>> +
>>>>>> +    if (!host && !xen_enabled()) {
>>>>>
>>>>> Adding one more xen check is unnecessary.  This patch needed it could mean
>>>>> that the patch can be refactored.. because we have xen checks in both
>>>>> ram_block_add() and also in the fd allocation path.
>>>>>
>>>>> At the meantime, see:
>>>>>
>>>>> qemu_ram_alloc_from_fd():
>>>>>        if (kvm_enabled() && !kvm_has_sync_mmu()) {
>>>>>            error_setg(errp,
>>>>>                       "host lacks kvm mmu notifiers, -mem-path unsupported");
>>>>>            return NULL;
>>>>>        }
>>>>>
>>>>> I don't think any decent kernel could hit this, but that could be another
>>>>> sign that this patch duplicated some file allocations.
>>>>>
>>>>>> +        if ((new_block->flags & RAM_SHARED) &&
>>>>>> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
>>>>>> +            goto err;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>>         ram_block_add(new_block, &local_err);
>>>>>> -    if (local_err) {
>>>>>> -        g_free(new_block);
>>>>>> -        error_propagate(errp, local_err);
>>>>>> -        return NULL;
>>>>>> +    if (!local_err) {
>>>>>> +        return new_block;
>>>>>>         }
>>>>>> -    return new_block;
>>>>>> +
>>>>>> +err:
>>>>>> +    g_free(new_block);
>>>>>> +    error_propagate(errp, local_err);
>>>>>> +    return NULL;
>>>>>>     }
>>>>>
>>>>> IIUC we only need to conditionally convert an anon-allocation into an
>>>>> fd-allocation, and then we don't need to mostly duplicate
>>>>> qemu_ram_alloc_from_fd(), instead we reuse it.
>>>>>
>>>>> I do have a few other comments elsewhere, but when I was trying to comment.
>>>>> E.g., we either shouldn't need to bother caching qemu_memfd_check()
>>>>> results, or do it in qemu_memfd_check() directly.. and some more.
>>>>
>>>> Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
>>>> and qemu_memfd_check will be called more often.  I'll cache the result inside
>>>> qemu_memfd_check for the special case of flags=0.
>>>
>>> OK.
>>>
>>>>
>>>>> Then I think it's easier I provide a patch, and also show that it can be
>>>>> also smaller changes to do the same thing, with everything fixed up
>>>>> (e.g. addressing above mmu notifier missing issue).  What do you think as
>>>>> below?
>>>>
>>>> The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
>>>> which buys the xen and kvm checks for free.  Sounds good, I will do that in the
>>>> context of my patch.
>>>>
>>>> Here are some other changes in your patch, and my responses:
>>>>
>>>> I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.
>>>>
>>>> However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.
>>>
>>> I guess no huge deal on these, however since we're talking..  Is that
>>> QEMU_VMALLOC_ALIGN from qemu_anon_ram_alloc()?
>>>
>>> A quick dig tells me that it was used to be for anon THPs..
>>>
>>>       commit 36b586284e678da28df3af9fd0907d2b16f9311c
>>>       Author: Avi Kivity <avi@redhat.com>
>>>       Date:   Mon Sep 5 11:07:05 2011 +0300
>>>
>>>       qemu_vmalloc: align properly for transparent hugepages and KVM
>>>
>>> And I'm guessing if at that time was also majorly for guest ram.
>>>
>>> Considering that this path won't make an effect until the new aux mem
>>> option is on, I'd think it better to stick without anything special like
>>> QEMU_VMALLOC_ALIGN, until it's justified to be worthwhile.  E.g., Avi used
>>> to explicitly mention this in that commit message:
>>>
>>>       Adjust qemu_vmalloc() to honor that requirement.  Ignore it for small regions
>>>       to avoid fragmentation.
>>>
>>> And this is exactly mostly small regions when it's AUX.. probably except
>>> VGA, but it'll be SHARED on top of shmem not PRIVATE on anon anyway... so
>>> it'll be totally different things.
>>>
>>> So I won't worry on that 2M alignment, and I will try to not carry over
>>> that, because then trying to remove it will be harder.. even when we want.
>>
>> Yes, currently the aux allocations get QEMU_VMALLOC_ALIGN alignment in
>> qemu_anon_ram_alloc.  I do the same for the shared fd mappings to guarantee
>> no performance regression,
> 
> I don't know how we could guarantee that at all - anon and shmem uses
> different knobs to enable/disable THPs after all.. For example:
> 
>    $ ls /sys/kernel/mm/transparent_hugepage/*enabled
>    /sys/kernel/mm/transparent_hugepage/enabled
>    /sys/kernel/mm/transparent_hugepage/shmem_enabled

Yes, but at least shmem_enabled is something the end user can fix.  If
we bake a poor alignment into qemu, the user has no recourse.  By setting
it to QEMU_VMALLOC_ALIGN, I eliminate alignment as a potential performance
issue. There is no practical downside.  We should just do it, especially if
you believe "no huge deal on these" as written above :)

> And their default values normally differ too... it means after switching to
> fd based we do face the possibility that thp can be gone at least on the
> 1st 2mb.
> 
> When I was suggesting it, I was hoping thp doesn't really matter that lot
> on aux mem, even for VGA.
> 
> Btw, I don't even think the alignment will affect THP allocations for the
> whole vma, anyway?  I mean, it's only about the initial 2MB portion.. IOW,
> when not aligned, I think the worst case is we have <2MB at start address
> that is not using THP, but later on when it starts to align with 2MB, THPs
> will be allocated again.

It depends on the kernel version/implementation.  In 6.13, it is not that
clever for memfd_create + mmap.  An unaligned start means no huge pages anywhere
in the allocation, as shown by the page-types utility.  Add QEMU_VMALLOC_ALIGN,
and I get huge pages.

> The challenge is more on the "fd-based" side, where shmem on most distros
> will disable THP completely.
> 
>> as some of them are larger than 2M and would
>> benefit from using huge pages.  The VA fragmentation is trivial for this small
>> number of aux blocks in a 64-bit address space, and is no different than it was
>> for qemu_anon_ram_alloc.
>>
>>> For the 2nd.. Any quick answer on why explicit qemu_set_cloexec() needed?
>>
>> qemu sets cloexec for all descriptors it opens to prevent them from accidentally
>> being leaked to another process via fork+exec.
> 
> But my question is why this is special?  For example, we don't do that for
> "-object memory-backend-memfd", am I right?

We should, the backends also need to set cloexec when they use a cpr fd.
I'll delete the call here and push it into cpr_find_fd.

>>> For 3rd, tracepoint would definitely be fine whenever you feel necessary.
>>>
>>>> Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
>>>> and not fall back, because something unexpected went wrong.  David said the same.
>>>
>>> Why?  I was trying to rely on such fallback to make it work on e.g. Xen.
>>> In that case, Xen fails there and fallback to xen_ram_alloc() inside the
>>> later call to ram_block_add(), no?
>>
>> Why -- because something went wrong that should have worked, and we should report the
>> first fault so its cause can be fixed and cpr can be used.
> 
> Ahh so it's only about the corner cases where CPR could raise an error?
> Can we rely on the failure later on "migrate" command to tell which
> ramblock doesn't support it, so the user could be aware as well?

The ramblock migration blocker will indeed tell us which block is a problem.

But, we are throwing away potentially useful information by dropping the
first error message on the floor. We should only fall back for expected
failures.  Unexpected failures mean there is something to fix.

I can compromise and fail on errors from these:
   qemu_memfd_create(name, 0, 0, 0, 0, errp);
   qemu_shm_alloc(0, errp);

but ignore errors from the subsequent call to qemu_ram_alloc_from_fd,
and fall back. That keeps the code simple.

>> However, to do the above, but still quietly fallback if qemu_ram_alloc_from_fd
>> fails because of xen or kvm, I would need to return different error codes from
>> qemu_ram_alloc_from_fd.  Doable, but requires tweaks to all occurrences of
>> qemu_ram_alloc_from_fd.
>>
>> And BTW, qemu_ram_alloc_from_fd is defined for CONFIG_POSIX only.  I need
>> to modify the call site in the patch accordingly.
> 
> Yep, I was thinking maybe qemu_ram_alloc_from_fd() had a stub function,
> indeed looks not..  "allocating the fd" part definitely has, which I
> remember I checked..
> 
>> Overall, I am not convinced that using qemu_ram_alloc_from_fd in this patch
>> is better/simpler than my V4 patch using file_ram_alloc, plus adding xen and
>> kvm_has_sync_mmu checks in qemu_ram_alloc_internal.
> 
> As long as you don't need to duplicate these two checks (or duplicate any
> such check..) I'm ok.
> 
> Reusing qemu_ram_alloc_from_fd() still sounds like the easiest to go.  Yes
> we'll need to teach it about resize(), used_length etc. to it, but they all
> look sane to me.  We didn't have those simply because we don't have use of
> them, now we want to have resizable fd-based mem, that's the right thing to
> do to support that on fd allocations.
> 
> OTOH, duplicating xen/mmu checks isn't sane to me.. :( It will make the
> code harder to maintain because the 3rd qemu_ram_alloc_from_fd() in the
> future will need to duplicate it once more (or worse, forget it again until
> xen / old kernels reports a failure)..

I'll make the necessary changes to use qemu_ram_alloc_from_fd.

- Steve


