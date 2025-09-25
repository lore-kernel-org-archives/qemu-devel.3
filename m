Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6DDCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1o2A-0008ND-CH; Thu, 25 Sep 2025 11:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1o1y-0008LF-Ly
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:37:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1o1q-0003zK-0E
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:37:14 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P9BYcF1809594; Thu, 25 Sep 2025 08:36:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Z4FTULiTtrzGAvM04wTsAX+e9TVe7U9TZ7LHiSyjs
 Ws=; b=snsMM4hm0QYfAWo2Mg53GF/LtVz+ks9q5wgWzHp+YCP9jwDtoutFZ5XGd
 IwG+OwPVznvyPCX/iE6dXL0Xh1hbNuYV9BLfe8ZK+opopst++igr8o1PsktFs4sc
 VggjXq6T7oqixpAIxRLcl10QfOYWUgY3aDFXDCZ6M2W68253bEWRg6yWNr64nRvD
 dpXCBd6lNt7Aj4plq71yz/Y2mEn7roNTiYd47r2la1ju/FPlEYuHQVQPKW61URsp
 ETH6+wwE7rirKRQGUooHmjB9yqGamypqqeXkLdl73ef7KmgbHyZbeEbViqfAlYA/
 RAd1qZUmF0m9aeRPuvOX9onfxXhEQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022128.outbound.protection.outlook.com [52.101.53.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgtjbemq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 08:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0T3nBr0O+Ads2+cW62IHmNh+D3hmMOB3bmfhOPvF5UvoeLwNQB9gXYt+AX2RZ5KPrp1YhD7zzTH6CO8EXilSv/iv6tgs6zxF6GTvSRs+AVWtHxrd4mhjViKNsvSRtyhc1dirJH8MbOrzJW/WT5XeACdXO/Ydga9+sTemYF7zj7vJbxtVIKAo32W4RsZlEOQ5slbJsi5w0ihHkFaTmR5+0rTPt3bQ9elbbKhhD3TvUDhh7IREhf5qxY/+MmwjZwdx6KIfScvVCe0iud2W+vmNI/pMd/a4AqIVblPQgwdV1RVMHbRr/k8VTClaX+Yb8eMLHgej7Pal1z6DAiA+cqscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4FTULiTtrzGAvM04wTsAX+e9TVe7U9TZ7LHiSyjsWs=;
 b=a2pIHXUzdypB6ve+fhFzRrh8oNLX5zqiZe5C2bRzBzmG34t4o1jF136FhKYnrOf2hrBwa8hqJCfU/nV8l+BpuTrz3n6PzhjRTropvNb/HT0wfFuwMItT8TEdEkrFgSHCYlNpq98P3Z80UCSU1Hqef2TAiTaq4hzu85Q6pppylNLa+MvdI3GErNvK34IyOFyfkIi5E2fGgRI0YEnqrTTlt27eZYM33v4cumsqfgTboGAo9uwdyA/9OfytIFs79CANuTtdsSjZSNpqcEnSmtLGYBuiSHVr1Nzzkw6A+BExE2O8DAjVM8Uuhgdaqf+0fIqUcxcaJmLK05DS7n/w6JGC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4FTULiTtrzGAvM04wTsAX+e9TVe7U9TZ7LHiSyjsWs=;
 b=BJA7HbtqljXA/+Q6xQu0LVTMeEeOzj0gGCZrGs9MztN4qaVO4eJLgZAngi6LZ4gCLf56P2a52o7vg0idGIamV9NkPsWOINqXswOi601AMVeZKZ8p87LlaO6UEr74q8s+pfXyHa308GJACFBOndPu2RXpZAPzLlq4Z8CttS7SdsHJhWrPm1R1xnSM8HvXCUCKI8t6UjJDtqYzRkddr4dI1ihniDOqg3cU9eGT1h1fL0r4sAHoJU3mK/qtmGWT8nVXmljp2lqQDKm+gkRma0iedp1+oRy2f8CGiJc2iwrg44xpIvLGePlbB4BRJ1kM4ehdiHVV/aG6HXTnJlx50uIfMg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7917.namprd02.prod.outlook.com (2603:10b6:408:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 15:36:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 15:36:51 +0000
Message-ID: <367bc034-67c0-4d4f-b4be-f76c22472a80@nutanix.com>
Date: Thu, 25 Sep 2025 16:36:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc.c: remove support for -cpu host and -cpu max
To: Markus Armbruster <armbru@redhat.com>
Cc: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20250924124653.1395094-1-mark.caveayland@nutanix.com>
 <87qzvvxikj.fsf@pond.sub.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <87qzvvxikj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 16df8fdd-5231-481c-a222-08ddfc4958a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmYydFR5L0NyTEJKUTJOUGRPUjdySXVnWjAxSEMzV2hIaTR0R1lhNFZWNk01?=
 =?utf-8?B?TnJETERMZXNGa3dtcGR4RjNLU3NPWitkZEpYd2QrWVVJTXB6RHRnYmdXL0ZL?=
 =?utf-8?B?K1VzcS9wcExCdnFvc0x3TE5qOUpSYlZ3TTJhUzEweXNVdHRsRGdXNFNoWHlS?=
 =?utf-8?B?UU9VakxKbXQxbEVYR05Rb3RuKy9tMWpHMjdQa0tqbDJBajgvRjZKRlk2aXVM?=
 =?utf-8?B?NXc2TEhpMHVTYzVkNlg3UWFxcUFSK0FBdDYwbGhPSFZIZWpjRnl5Y1pVajQv?=
 =?utf-8?B?UTMyS1ppK3FPeHFJSkVwRFc4S2FnMFFwMTcxZDBaMnR2S1EydVZDZmU1SnJE?=
 =?utf-8?B?MGR4RHY2Z1JvQi9lcCtsY2ltMnc2Ulg0SklKdmtqdzZRQkZrUWhJeDRsb1la?=
 =?utf-8?B?ckZJR0VtalpneFJxSys2UEUrSGROMnkzYUNxK0pSTlR3UWhCdGJQaTYzVDQw?=
 =?utf-8?B?czQxVDZJa1labUJqYVEvSnJ1ZmJsdzdpVjl2WGRTQ2RXc0hYcElDZDNxdkov?=
 =?utf-8?B?T3EvQUcyU295L215WDZoSEF2emZtdDNySk12RnJEaUpGcWQ5SUxZcWRqOWFo?=
 =?utf-8?B?YktzTWZBRTFCaDZuY29zaUdveUk2OVhYSzg3OHZ0dnBiSytkaG1BUDBBUzFS?=
 =?utf-8?B?bldiOE5jQS9UMHBQd3dERTlINitZTG1ocWkyMzhvc1UrcHNyTHpZcHVtWnNx?=
 =?utf-8?B?SnVybTVxak9BVTBRb3RsaEk1M0VtZnYyTjdXRlluT1g3M095clYzNjB5Qmlh?=
 =?utf-8?B?d1FaZ0k1NTE1ZTJlRDhvWFpsaVRDVm5iWThjNGk4ZWtmdG9TdEVkcElEQWI5?=
 =?utf-8?B?Uzg3NFhXV3EvRzBWeUlpNkVYQitNVkpka2xEbjhtZW5MYm5pblpLQW8rU2dS?=
 =?utf-8?B?bEdYQlByR2F0cFNLZFV5bmxwZmZycDhkRW5lbm9HbUxKU3FJQkxsYXVyVFZn?=
 =?utf-8?B?YkpDblZmQUNpY3ZnNnE3NFRNUmlpbjFqUStwQVUwQlFXWDlkM0Uwcko5Qkpr?=
 =?utf-8?B?NU1LNVJjeDBIQThTY203TXRxN2FsdkhLbFUyVmNTeHRQMVQxSXdKZHU2a1Mr?=
 =?utf-8?B?eHN6N2pHREpPZzhHK3hVL29KeEIyak1JeGdKcDh5M1RGby9nRllCdkUvUWpZ?=
 =?utf-8?B?YnFtRnpLQncvVUNOVGtQYzh0bHRlSyswSkh2clVFa0UzbHB3Tm9zbTE4dUNV?=
 =?utf-8?B?N295eVZLZEwzSVM1Vk9nN2NoSDFwUk85TFBlUEt2ZUxtSmZHUFBRU1pIMVhB?=
 =?utf-8?B?VzY3dEZOVjZUdVpyMDJUcnpBK3VGcHd2RnltRHM1MWV5MEo2WmhjVHFxZFo1?=
 =?utf-8?B?Vk5wTER4cFhPMmtXd0Y4RHkzbDhmc1M1RlRWSWdYdlZKOGRDMk9PSzJiY0Qx?=
 =?utf-8?B?ZSs2VEtCNkR3bk0vNU1DRmhyU2dhS3RHY3ZRMUttVHMyV05xM2dPUlYwMnNH?=
 =?utf-8?B?aDlPeW4rMmhSNVdyZ1JEWGV4ZDBuenI4ckN5and2dWxPUUE2T2pQWE5Ga1JW?=
 =?utf-8?B?aDZOQTlYeHVZTUlkNWJwMCtwTS9NcTRBT21Yd2xjeHpMbnVpT1Vveng4M0NJ?=
 =?utf-8?B?bkNqRnhnOVVQclhHaWo0UWlTNjZPaWNCb3F0OUQzZFVjRHVzUEJlVkVLbVZy?=
 =?utf-8?B?aFRFWXVRYnhTKzJVV2pwM3lSMW9RbHBVOTlOeGhUR3ZpeUNIaW92WTZHOGJB?=
 =?utf-8?B?ZmFOUzZjaEdtSE1GeXlkWFN1Mk1rL2VwSlIxV3ptdFlpdFRENW93aG4xNjdZ?=
 =?utf-8?B?ZTVnWURQcHFzTnpQTDFYSUh6Z3p3d3dmVGRsVlhQSDRVSlpFSS9aUklRRVlP?=
 =?utf-8?B?WnRXMnlKMUNqOVM3SjlOZ3JPelh3cFRCOTBidTBzTEhQNGpiTDZPYzA3NXkz?=
 =?utf-8?B?b29ZS3VwcFlPVDJZS3NDOHAzSFlQZTByNVhJWkhEQWFQOWRjbHkrQU4wK0dp?=
 =?utf-8?Q?9sSKgAZwGSkqq4oCQP9ADE2oEGzwFkAQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVCTEF3a2xtelF1ZW9KaXplcEVwL2phUHdCcWl0ZUphSGhKUWdwUmxyTXFO?=
 =?utf-8?B?aTJsREpIMU9NMzl2dGdRZHlhdWdncSswOVdCOTBONDRnZktLSzJaa2h3WU00?=
 =?utf-8?B?ejRLN0o1bzB0YVZIRndYbjJNY1dOOWgyZzl5SUgrNWRzclFldGdJTzZpblZl?=
 =?utf-8?B?Y0xBeGFGcm1mQ0xyOHlVaXBmbmlITGZsaHZmL3EyRW9FR2Vuc2NYMlFMbXNz?=
 =?utf-8?B?Y2QzUFp2N3JoTTRrN05IeDVHKzU1QnBBZk5mQmlEcjV6a0JaM0ZCQitxSHdN?=
 =?utf-8?B?QlIreXdTY1prWFVzL2Q2aU8rYUttZTJvSkJoVU1FbjVPaU5Wek1BdWFwYkZx?=
 =?utf-8?B?N25HMkxVdUJLTG14aHFYUHMvZ0RlRktNWkYwMFRyK25kQ0NRRmUycmZGMWJW?=
 =?utf-8?B?cGMwRzJvYlpxekREVHRKdDdGVHQrUnlKWnJCZGZQNWllQlBQVm5lYnpxUTdF?=
 =?utf-8?B?UWFNdFlpR3F5VzJhZUZIdDJYbklvVGhEZjEvSjF4ZVV1c0lONlZPTHlaWEkz?=
 =?utf-8?B?OC82dTI0c0RVY2FTSzM1QnpwV0lnQy9hRkg1dFU2V3JtaGxnMVcrWHhIVGJP?=
 =?utf-8?B?eHZMV21oYU1WR1h2V0RPeWQ3NSt1SGJ6dWszeCttb1VDd2FNWEtZbTBxSUpo?=
 =?utf-8?B?YzdhcXlMekFZVmdFSXF6RXc0TVBhOXdXNGhxL25BUHNDdTN6MlRtSTdCTVVW?=
 =?utf-8?B?TzNWc0dMdG15djVocVlrbGN0S01ZaXY5UUJUaFpERVZtTE9SSGJBUW5jc3dZ?=
 =?utf-8?B?NUdRVjh1TWluTWI5dnFWeVcyUDloS21WSndmc0lSMWNGZGNiRGdDTFB0K1l4?=
 =?utf-8?B?YkNUQUV0RFc2aDJlMS9hY1dYNU5xb1lVYzArOUlYV0RRZkVHaHhlZVM1UE9r?=
 =?utf-8?B?TjlYVDc4cFRJd1pNM2ltYWNZMlBPVkJTVXVtb01IZS9SeXBRbkE0Z3A3TUJk?=
 =?utf-8?B?a0lFVjFQekluS3oreE5HZG42NkRuQUl3ZXppN3A2cDNPUVhOZlZ1NnRDTVRY?=
 =?utf-8?B?dDAzWFlMRTJuanladWkxakZPbmtKckRLMHhKVVFPbWRzVW5nM3NWSGI3VUtj?=
 =?utf-8?B?R3lvcWM2UGRwTUlENU1tanhHdVZ4M2VPcm1YQmxZTDlTUGJQQmUzbWRUUGtm?=
 =?utf-8?B?TmEyWjdWUVpsb2UxdFBVRktHNStTbzhycTBWYVVPRTNESVpBQ3YrdmJGcEpK?=
 =?utf-8?B?d0lKN3JVaGlKcDRRcUhXa3NadVpXV1NHVC9RR1dRRHUyRDJNVnZMQWhPVEdP?=
 =?utf-8?B?YjVyc043dGJ3SVRleklmb0w4Y3lsR01vVENkUGI4a2hxNmUyS3dHS1dEeFF2?=
 =?utf-8?B?R2lQUTdycEN2TjZXbXI3cmxEODhTbmVyVUFnNHlYK0U5NGxtZkt6bVdpL25y?=
 =?utf-8?B?RmV0azBhMjk2LzMrRDUzTEI4OUtJY0JvQzE4S0RWcWxNd0dKbFpaRFp3cFlh?=
 =?utf-8?B?WFhpclFVVVRTaGFhRlF0VjBjMWE3ZGhUa1VrZDRNV0ZPT1dFTUM4NklkRWF0?=
 =?utf-8?B?eUZDbGFLT1FCZ3VmWEt3WGZRVWVLQ01nSjlkQk5ZL2FCVHVTVEVPbXlGNDVx?=
 =?utf-8?B?WjBGTHRnVkp0UEczbkhiRzlVejkyWklQQW05VXlJcUIwcDVwV1kybjdQRkZP?=
 =?utf-8?B?SW80cUpSR0JtNDZDZ0kzTFBkMWJwU3NLbXlhc1k5eDcyMU1HNDN2UlBQUVFT?=
 =?utf-8?B?YXpFVkxYY05hWG9EdjY4L0paWEFQc3ZZYndYYzZZMUM4VDd3cFREL2J0V2oy?=
 =?utf-8?B?Snp3RHo5STlCZU1oNVFNMkZDV2swakpDZ2xWWEtKRUtZS1JZanhZZGFsMVhx?=
 =?utf-8?B?YkJkQVJWYjh6dXI1eTkwNHF0THVzdEVBSnk4MVNKWnU5d0EwcktnNVVpOUIv?=
 =?utf-8?B?UkVwQXZha2RmLzUvRHlsNkxQM0trcS9Hd0s3SzV2OUtLdGFSb3VLcXFtMkhQ?=
 =?utf-8?B?b3ZyNWhqNjBtQ21OZGlPdGwyaDF1WUdkREpDcTZKSGZ5WWZFc25ReHBzUExs?=
 =?utf-8?B?SWtZdzNMUDVUVjBWMVFBRU00WEZmb1JRU0ZhY0lsK2o5YXZpVkhrc0pIcnBx?=
 =?utf-8?B?bVdOSysxVkJKVVp5ZnZrRkhVQTg4YWxGYkJvdHBoUjlzeldXK3JIYkRCcDhP?=
 =?utf-8?B?TVNPR2x0bzhXRG43cjh5QnhZRGU4TTBDTk9pVzRwNUc1dkVwakdvMEduRWtk?=
 =?utf-8?B?RXhVKzVEYit1bytUR3VndGk3YXUwUURMZ3U0N1J6U0VlOWNzbXpRUmlhYWR0?=
 =?utf-8?B?Zk05Q1g1SzJZYjBPYWM0Y3ArZ3BnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16df8fdd-5231-481c-a222-08ddfc4958a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:36:50.8124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpVX5ymj31wCSBZbHlru1xzSFUpG/L6OIGKMM3OYsL9aPdvAyM9gi6YIQzHZDx0jtpOidngkqw/PiiZ+5HmOduXFhSjsc6O3PHgsQLT+8aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7917
X-Proofpoint-GUID: JytWB5tn8MyLp4hlayI5QwfpfvWiZ_R1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE0NiBTYWx0ZWRfX4X7OKZPvxQIS
 ZX3YrB4LIBmWNWoBtvMYNXXlbc22RXmcemIUBMnWHlhCS+Os+g+jiihwPQUElIZKycTOfYyEiPt
 jagQWtMpkm1zO/pkjgx4HT4QM3myd2MpmMJpdyz+L5x8oSE+do0tE9zVq9Kmi7WKu4inPax4lb9
 UcLd9oM/TAaSO9AyWDLfb4F9w/h8ja8QnGBPnCJQYXd4XOsOHMRMjgK4sGpnzdpXtdTOF3rDpwJ
 XSdcGxbfgHY9R8SdR6AX+e+ar8m9Aqx/xZK8C9qCdTk6BfuANrPft31QXNteoBDSDygXc3Lp4Tn
 Ss1VfCyrFVlLl4P+uWntDT9TalywiSXeACqU4qwWRyoT1n6sG+xvoJxvzYbfFk=
X-Proofpoint-ORIG-GUID: JytWB5tn8MyLp4hlayI5QwfpfvWiZ_R1
X-Authority-Analysis: v=2.4 cv=MoVS63ae c=1 sm=1 tr=0 ts=68d56195 cx=c_pps
 a=wiAqGZatgNl135eAsGeZeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=7FUNUJXsqVPv99SB9CgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 25/09/2025 05:27, Markus Armbruster wrote:

> Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:
> 
>> Following recent discussions on the mailing list, it has been decided
>> that instead of mapping -cpu host and -cpu max to a suitable 32-bit x86 CPU,
>> it is preferable to disallow them and use the existing valid_cpu_types
>> validation logic so that an error is returned to the user instead.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Do we need to note this in docs/about/removed-features.rst and/or
> release notes?

Good point, I think this (and the previously added 32-bit CPU 
restriction) is worth mentioning in the "Backwards compatibility" 
section. I'll see what I can come up with and send a v2 along with a 
documentation change.


ATB,

Mark.


