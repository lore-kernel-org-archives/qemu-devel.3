Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E2CCF0427
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHWF-0008Sp-8J; Tue, 08 Oct 2024 17:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syHWB-0008SW-6T
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:13:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syHW8-0008DX-VL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 17:13:18 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jtatm004859;
 Tue, 8 Oct 2024 21:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=c0viomWf8aQlDJkboIQIa0hoJxqJ+BSEWn6rnRNRhoQ=; b=
 C3+SnCYc3xuPdvUPvcjotvIznaWAJqmCAdt82NzQG3FlA6gnocj24ivy9Bbn7RYC
 56NFqnOQ40G1El7CqQW+M9bnLXnSCSgp9FowCBJN9Ppq9nYPsXAgYiPJ01UZV6Hi
 bJy7KeVTHyMFwJQdX19Gy8WgVm5qkpQzsQHzf6uCrzMODUHcpRbkX4o7bmPGKQSM
 Lg7Rt5lcalVHYSaZH+J+BSObGsIDMOvc7rHzK4kmL5WRq7EX0RdDSHtTN58j7lhF
 /5xyFv13iRKZK5LzT3mUwRs5Q/tM92N1exe4l6u2NLYg4GOvGZG4l+fGeSrsLqt9
 lawgAquOFy8amgkdpZtqLw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv6vqb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 21:13:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498KXF9F038236; Tue, 8 Oct 2024 21:13:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7suva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 21:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci+oPksfI944dIeLBJT9tFv3gqc1WxsxsxCfAjS0gDxZ6cNBYqWQh0HgHOo86JxVMiIkxC0rh8puN07kwBnHW5XvXP8u/cQb3O2tDSMedk2Fkvqh2lE3suvkutr8Suo878UXY4U7pkmvU0ap1yzs8DijEiZ597Os426oSmDAz0cAaWPLWtDSyMx3X/ChhNLDdJtR6Di5mRYu9rMIuoGICXPZi62U8OPipzF8kRPtDTNLwmzpXpVxu/S7k+ZZZ5sgJrQULj8+3Gy9FU/gF6g9UVSSzvUcRqQ79H4qFsAQznVU4JnaAk/LJ3bq/jb235T5Xk+Ir4kYg+lghHFSegcAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0viomWf8aQlDJkboIQIa0hoJxqJ+BSEWn6rnRNRhoQ=;
 b=ln9a5nZvIe8XToEz4L8qSZAxJc2vnuj7P4v904Wep0ksexpG5ytcF2ktyaGYCQZdksG2mmaNDLHFasOA6aw63vFxq4J9fWwkSuPhOTfVlAm0uPlaxgyUOy+6lFqvqmfG4spP5UF5qkrUjdQIiJ5L0ln6S1b2QbU6yRxEMrbkyV4WNkv36eJGU95tbBosd2UaHZn3ifpJoaFk0LQqvcGvIlhzhhAGoSjg+lel8DLdwj28Mvmy3SKp1eQkbITKJurfnllMO9Iyk/84qAdg/mQpYBp0Vrq9WkECFXqHpXAnYVEVheo4NE1LYzepaCdcud4a92HB0ABUHgrXHSpNB7kzfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0viomWf8aQlDJkboIQIa0hoJxqJ+BSEWn6rnRNRhoQ=;
 b=tTytjUMNSjrwI8yFerwnSkBMbr6LWetk0dpHb+Q63JKOnzLLKCCkulnokqSc1WdySNqLhEKCcolvYoITT/Ui6fTxofEKe6EXvl3GRSqMjaNDwD0Wj3uS6ZXZ2M4VTMRF60q+vWep8GiSnjmOFDjzajp4RxBXiyGjRIqzhPOhtzg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 21:13:10 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 21:13:10 +0000
Message-ID: <1ba068e9-6bc4-494e-87be-c252bd95ccac@oracle.com>
Date: Tue, 8 Oct 2024 17:13:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/13] Live update: cpr-transfer
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <6b8c47ca-4052-4018-8b5f-11b13b8f5395@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6b8c47ca-4052-4018-8b5f-11b13b8f5395@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: f802c567-b44b-4ea1-599f-08dce7de02fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXZxRDV3a3RySWFxM09CYkpEY1RtTjdwVS9GSnN4emYrRkU3cFdFUGlQQlkw?=
 =?utf-8?B?akZ6TDR2US9HVmd3M252OUp1L29ORCsxSm9oemkzNEZFdnVQWmlhUDNtZEtw?=
 =?utf-8?B?ek1BZ3Y5V2tUUG1XeDJNZ2VpNm04bnp5dDZ0aGlTTXNBNG9QVHZRMWhBT1B6?=
 =?utf-8?B?ZDVDTjZNTDRIVmtCT3V2RkdMYytkRjVaRytHemZXd25YcisvOTEvRGYwU3V0?=
 =?utf-8?B?Z2xISEFYVFMvUXc0Z3psd1RRa2poZEF6QnEvdzFLNG5YbDc1MUh0eEUxbk9m?=
 =?utf-8?B?aXN3TnMzcEdNMG1CZUNnTmo1ZUNyK05GRjZFOFNzdUJmMDdXUjQwQk5SQk1v?=
 =?utf-8?B?M0h4WGk5VzVkUG9vZUZXMnBwMDFzZ1VLM3dSdU8yWkJZQW96OVp1WGFjcHUy?=
 =?utf-8?B?TUlWNjBHWnFuM2M4TGs5T0M0LzllVUZBZDlJemhrcFJSeFhFMVhmeGJBYWk0?=
 =?utf-8?B?U0l4YTJrNHR6dVZrWXk1U2FrQnh2NU00eDRBQ1dHQlAxbVJ1TUZvdHNQYjJN?=
 =?utf-8?B?cHdhTi8wR1lZRVovcmJtUzZ1V0ZLL1RRa0xFVHNmS1Z2L1pSdEp6Y2hyeHND?=
 =?utf-8?B?NFUvQjNuQTBPcnZ5YmFZQjFuK3ZJYmpXUzRnSlVNQzFjbnhTRWNNVnpPRTli?=
 =?utf-8?B?UjJ3ZnRrbVJqNUhadWV0NnZWYm10Q2E1dDJOdTR4RzhxZkRFUjQ5cWNEUlp0?=
 =?utf-8?B?Y2YzencvTXpXUUYwaytneXFucXA2TStRQ3FnN1lvOUxqQ3VJcEd1Yk1rM3lw?=
 =?utf-8?B?eVpKa2txaFA3TFFkYjlySFV1UDVLazVCVTBtTmg5R2xGSVo5WWJEOUpuK0dD?=
 =?utf-8?B?NzR0YkczdUwveGdJSm5QdEVsUnhJR1h4ai9JSDE3U3NFdnBlVXZ0K2dnRnZr?=
 =?utf-8?B?dkdMQW1QdEpIdFhGczgxWXNKVVl3aXNDM292dnZYSlloRTlodWl2Nm1RaWU3?=
 =?utf-8?B?NjFvZCt0RllyZytOalFVamdXUWNqU0syZUpORFAwL1FvZnk0TDdSTElYd05O?=
 =?utf-8?B?djJoYVNTTGV1UGp4emxLc3o3WFM4cGk2aytMcUs1NDlicnV4eTNXSTE0THVF?=
 =?utf-8?B?NHdRdkk3THFEb05QYjlGZHR0VFB4bmswalNvdVp4eXJHQ21nUnp0d2lQbnNp?=
 =?utf-8?B?OUhLcDc2RHU5b1U0aDV2Wm1xckxaQnhiaDdTbHQyNUN0UHBhVXZ4alU3aXM4?=
 =?utf-8?B?OHE0OUdJTGFIUDJWZ0swdHdYRjdkZWJzV2ZteFVjT2diV3ZYL1FjM2VOK0o5?=
 =?utf-8?B?VXkzbHZvd3JSdGU4Ui9CUUd2L1pMUkNhclFWcEk4MUJHWlhrTkVNRnQ1T1hF?=
 =?utf-8?B?VDRFaU1pNnlJUzFDNDRWdDdiODZ0VXBnYkxYNU5ybXZNY2tWUlFHQlZvcVow?=
 =?utf-8?B?aEs5a0kvTS9BNm9PdFh6dXI2ZHhSaHE4Y3FzN3NPVFhtaG1tZUtUSzZNbTBa?=
 =?utf-8?B?OHlYNzBjMzVVQ0RZMmsraHd5ajh5cGgyWE5SWkdWdE52a1lvdC9obGE4Q2FO?=
 =?utf-8?B?UStoYkVEdm0zb0Nqc3VkMGRUeUVtUGlZZGlCS2ltWVhZUVhrMjRQWXBSL1Fr?=
 =?utf-8?B?cUVNcTVCUndJN0xTdzgyM291WUJpaXdTTnM0SlhFMDd3VmY5SjlCR0tCa05I?=
 =?utf-8?B?RHEwNkVPVitldTFhc3lCdGVLZWtRMnBiWlZITEsyKzhUTkNjWlpuWWUxcmwz?=
 =?utf-8?B?cGgreTV3TDhVWTdsNmlsR2wxTXpDckhoejV4QU5GZFpXVit6cnRpZ2xRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk5tNnViZGpBdUVDZDdFNFhDdjcydTVrYVBaVlZqSUNwcWU3Q3RyMmtYaTN1?=
 =?utf-8?B?bm9BSEk4TmQ1OFlSWFIvSlp3VTVobUtWU0Z6L1E4clJzVUd2YnR0WkJEM2dD?=
 =?utf-8?B?UythWncrcXdxR21DaVhpNDROSm9XdVJ3ZjRQcnFSdVMwLzZwVDIxTHBjT3Z6?=
 =?utf-8?B?YUUvQStHU0lMcnNyTEEralNrYzNwdkdMOElmdEhQRGRHdFdNTXJGTGZXTnQr?=
 =?utf-8?B?U1V0UzNCWFFmMFEwRFM3eTY4SzkwUjdnanMzalhzWmM0cFQrWVZmSTFvdURB?=
 =?utf-8?B?TlRIRnhqdjdsY3Z4RU0zVFBVNWI0UlRkWkxRTlVFNFUrUURJVG1DMDRSYTFx?=
 =?utf-8?B?TU1mem5laktFZHpwU1dJOTZHZCtvYmdkSnVVRDRFczlyQVczRzIzcjRpbEpr?=
 =?utf-8?B?eGxlM29UOGd4aTExN0svNUpSdFUrQU41cU0vSlgvc0Y1OFMzclhjL21LemFm?=
 =?utf-8?B?VlgzWHV4aE9DWm1kVWhEZjhXcEYvNDg5Zk9PT2dzemJHc2VJeXhKeXpzYksz?=
 =?utf-8?B?c01JVXUzYjJaNHZHYzllSVFRNm90bW9pb0huTU8wOXVyZ1pFd01Rb211Nk5i?=
 =?utf-8?B?aFR2RlFycE1xYlRReFZ4eGFvSEFRdEUvNGczTFNzUnJiOUpkT2ZyY1lLK3Nt?=
 =?utf-8?B?Um1CWmpjTUh3aHRmckVuc0tHVElXNEJGTE1GSnF6SVgvN21DRHRLbkRkeG53?=
 =?utf-8?B?T2ZjUmYvTEZpTjJhU1JmNVBOSjA0ZkpWWGZER0FZOHUzTVkrR1FXM085MUtO?=
 =?utf-8?B?TEJIQmJDU2llbmJlUGtVN0JQSlZQYXE2QzZ4SkZXOHJuRkUyYjljNVNKOVk3?=
 =?utf-8?B?amFCU3FQcGQzQkFSby9lZXBuWFBOSFh1WVVVejhERU9qdG95ekVjaVZkT2JN?=
 =?utf-8?B?MHpNTTRoUWd2aHlpaDNHNGhRQ0RMMjBkQ1R6a0xrbmhYczVJc3orS0hPMmxk?=
 =?utf-8?B?TG03YithMFJ2WUcwODVTb0pMNWJCTWRtbUVaNDFCUTBHY0t5UUQzTmhsUlkw?=
 =?utf-8?B?dEg1LzVWT09TNjQ4b0g0cnB1NVRFd2hZNGVTQTk1SE94RGJMbWxHOFZ5dTEw?=
 =?utf-8?B?WnhuTlJqYWRaemRlMUpiTXJUVXBwTDRralUrajAreGtjb1BmeHdiMGdmaXAw?=
 =?utf-8?B?SU9HazB4d2Q3NThRWUdmN3VoYU9JeEx3bnhxTjg4T0VCeE9YVVIxMWhJWDFU?=
 =?utf-8?B?T21ZVExlSUtJQzl2Z0lRRml5MU5mQ3NST1RJVVJsK2NXcEpCRWdXZ1I0Tm5l?=
 =?utf-8?B?ZkFoM2gyb2w2WWJvNUtEWmhPNUR3MWZBNm93V0tYcFNSWjBBbUdOWWQ2czlk?=
 =?utf-8?B?TTJTZjNLbGNRZG9ZMm50Z052WXlCVWg1NEJleXVkejNjWmVGcmROR0Z0RVBj?=
 =?utf-8?B?eWtCeHNMYTlkeFN0SU9IWUtWSk9hbnJLYjBaVEl2TFZFZUlzRWU2L2tOWXVN?=
 =?utf-8?B?RFRHMjgrSFpMeFlWU0hXRlNUbXoxaXBqYS8vU2p6aEV3Z0EyUFliVnJwOG91?=
 =?utf-8?B?RFFJR21iUmorNGtSK21xK0xJL0xkUk5rMHk0Z0dWZG4xUlF2a0VrcndmWTZ4?=
 =?utf-8?B?dTVqTXdLdDA1aVp5WWNhTmY2VTRjRVBoaXZqc0lnZFh3NnduUGZqUmRIZDIx?=
 =?utf-8?B?VFBXaTdkd0xhcHE0eS8rNXhtaFNSSWJWcVR5bHdMMkM4YWcrNjdGdXR0ZHcw?=
 =?utf-8?B?NlB3T3owaDJtb0l6MngvMEVoRHJyR25DS29NaHcvT1FVc1h6L1lVSTNBcWMy?=
 =?utf-8?B?akdsdEdMRzBJU0d4czJ2NEFidG1mdzdCVHZZdEZpNVFzaFdPREdnN3ZEbGFs?=
 =?utf-8?B?c0NBUzlVa3EvUzBxOFc2c0ova29JNDBCaG9Jdi9tdDZ3WnFtVlp0OWhUV0ZY?=
 =?utf-8?B?YlFGTTFDQ2NrdjFQQ2lCZEtwMjdXbFFTaGdpTFdmL0RGYUtONndhNGdCSS9C?=
 =?utf-8?B?UngwOTNKajFucjE5cnhOUXVTMitUQ0N5dmJWVWZDbWdpZWEzMXZGU295ajV0?=
 =?utf-8?B?L3h5MmNFelNiTUVUNGNZSWs1KzdYQUUxT2dZSGJUWUdjZzJicGZieXI0dnhq?=
 =?utf-8?B?dUo0WS9INENwUzJIYk11Y3J0V2swWjZyZ091L1NsTE5HenlteVd5VjlVcG1V?=
 =?utf-8?B?NmJDRXpkS2ZVMFBUN0NEZk93bmdQLzB0dHNsZnlnbEhzUWowWXVLMUJyb28z?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mtYtMUXHivGpECry5Q+uz61KqoGMWC1RXycOoOFWMa8VOdGRadR0+Cf7VtAQUQzRfW38WKTaBfoVzmQeiJV4+igiPtKfoQdC9wwg9sAo1YvpOciJ720owYTPc0zOE9fw3j4mCmlDHMmSN71wzO9CiJmL6f+EhIWYl1C/ZsGI2CNU4b7TDkkSuBWhEBN09/GrKA+OnxyZDZqegTP8UaSE0I61Y/BDZhZsp5yw29Pg2mrCltXPKizA9NATcpeFQ7QCvyIKuJhVevKWisqVSQ2QhMQg1tUFBw5OoJRIre9BZDDImLteKYh0RO9bZ0KO9OFWJzdQi54YbZ9YM2Eut4U5ibEw21wOlmxMAfbVEWBCImoJXlfZY0VYCDmnu8ZIulrEuTW/pmE2DH3dP0npTuG4rU6bKW4zYPkWaHYm/NWsjLNVCEKYGCzF8sK/bkkTnrPKBbYWuXZcez/SwxnD4+wsEp3kBDvUt8hmwDo7bf/LTLtfChfa6sZPPPLvnI+pD9VzCm4glA3kxlzaXyVSFsfeZ780fd35UN/2VfEGsoDQ17QKcTdMX8QfMLxcJo/H43pvfnMRHd02Pqs2tu4rv3KFndGVebqQSTLIBYAPJJ6B+Dk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f802c567-b44b-4ea1-599f-08dce7de02fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:13:10.0811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llWVRIIa1Bz5wmWs35ODKnQlpY2mSgFDQu3zDMfnH7FmpKU6eHZ+qbZb4b8rIt6m3JHyZxh5p3iBLzhVRG8Z7aL57c00nqGMpWZwj4l0qSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_21,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=759 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080137
X-Proofpoint-GUID: Y2g5DfAxXzqD0rZC8n9ISrzKwoGdkYSc
X-Proofpoint-ORIG-GUID: Y2g5DfAxXzqD0rZC8n9ISrzKwoGdkYSc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/8/2024 10:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 30.09.24 22:40, Steve Sistare wrote:
>> Some devices need new kernel software interfaces
>> to allow a descriptor to be used in a process that did not originally open it.
> 
> Hi Steve!
> 
> Could you please describe, which kernel version / features are required? I'm mostly interested in migration of tap and vhost-user devices.

For tap and vhost kernel, no special kernel features are required.  But in addition
to these cpr-transfer patches, you will need the "Live Update: tap and vhost" RFC
V1 that I posted, and it might not apply cleanly to this most recent cpr-transfer
series.  I will eventually update that series, but not immediately.

Also, I have never tried vhost-user, so not sure it will work without additional
changes in qemu.

- Steve


