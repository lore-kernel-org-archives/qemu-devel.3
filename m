Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7FBE65D15
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 01:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEIga-0004cJ-7C; Thu, 21 Nov 2024 20:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tEIgY-0004bc-8T; Thu, 21 Nov 2024 20:42:14 -0500
Received: from mail-mw2nam04on20629.outbound.protection.outlook.com
 ([2a01:111:f403:240a::629]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tEIgW-0001qI-22; Thu, 21 Nov 2024 20:42:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvO88ClSsqc5ccaHrhTBZfwip4Jgf01+CQQbSZpCpSYFT5ktdkgtKexzEgKavMPHdRPGDPmds0d1CXraWZFeRkgY9uXy3rhb2dWr7d1R5C8ztTX9TSG3kodowKfEm1YIKbiXbB2/L5ixFj3/KoZ2Q5UeMma7FRcIHujxO9tVJ8oQ0u3uMSmPGPIno0GZbq4//A2ipmyQqE4AIns9rHu27YwMS49pNXIdMQpcxVBab+kTI0TuVO2MbHLEltO0RiJ8We7ySo3iqAFhaCXl1gdgyrj82fnc8AtuAqg3hKq0oSIsMG3ByBF2pEmlTBaww5EsmW+KprnpmH5V8IfwmGMTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT7x+15HQImx7wAyRn3ATvp6eQO0NtyoBZkBUfInvOs=;
 b=iBfl9ZehDMw8rC4jnM64rzJfAp9JorVCNKhTTsdthjNxKMSQlwoPsS4d8EZ8Mt3098qrjrs4ckXcEJQb8LfuYWUdjhWG0n0CVd5ILSVN686ercznfUWHT5JBREhX5tQd8mvv25YTV8ym1RBOxQV4QVrEhh+SNb0DznIj1Dm5ka3eGXM3u2y1YabvAPUCJhmV1CVSrF7yPsT131mdgVPBbdiRTfLmI+k2VCJLPLM6CA+MIm4AnxzZAMGFSVLExhwAX7ZXL1LjIeQ4y9RiV7Rymzw6OnnWILACq4lfwEwmzL4xc8beAiSsrfAaDORhdfZyu1lbgP7LuccdDiU3im+Fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT7x+15HQImx7wAyRn3ATvp6eQO0NtyoBZkBUfInvOs=;
 b=EIoj32V9jC7aLovsH0EQtxRU+Nq8rwO3jCHM8ivx9lpes6wAIAPXkvh3kn2Jmx+MAVtfsw11E45+z1g5R1Wr8u/q01YGlml2Own52jmd1p9a8P/PjDPqW0SJsjCRH4/n6d70SR4W1ipFMDXQbDC0gWp0h1a46R+d/NpNvlhhd7jHlkgMjmoY4+qffPapSqGiXrQoKgkin8RmRz2zpPOcc9P/EQJYwkwO2Gj4BqB7OI0f26ne7EJ/gE9E+ARtuZyGOs21aVDrsoVJc43CRHQ+VAbE76xWRKYnc+J6e/cXDERk174blTMpWXKgE2icRGpshooOhzhWm0+p9BLLSn5Xig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 01:42:02 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%4]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 01:42:02 +0000
Message-ID: <d2bc4fdb-3188-4063-8ead-f2ccefec9c81@nvidia.com>
Date: Thu, 21 Nov 2024 17:41:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 2353ff28-9657-4782-0d6d-08dd0a96dcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1pTa3RWQUlVaXViQUNDOFc5UmJ0WUFsdXIwYy9DMituNVl6YTVQYVRJa1dE?=
 =?utf-8?B?SVBJb3M2Sld0UEdrMmZnSEJYeEJsb1pibnpwbGUxbzNRSHdvdEpSUC9XM3JQ?=
 =?utf-8?B?K1UzT2RNWWhhMUpLbHEwN0NicnBvdmJ0Wi85NVhuZUJFWXFybXhuMTkrK3RW?=
 =?utf-8?B?ajZsYUg0ZE02RklZbjJWajJtNlI5OFNMUkJLeEFvSlMrc2pHZThNYkRCa3M0?=
 =?utf-8?B?S3h3U21TQ2dOVU1aNFgzTGJrZ01PVzI1L0Joc2RFWGpxejV6ZW9oTHRWd0Fi?=
 =?utf-8?B?R1N2ZVd0Vm1VZmQydmhDY1E2UjY4OU16VXovekRYcDk1djZQMUE0Y0MrVGV1?=
 =?utf-8?B?YUpMZitZRG9reTJDR21XdVB0M3VYZ0ZQVVp5VjVvYjV6NHphV0oxaHBjcG9Y?=
 =?utf-8?B?RDlMcDJlcVNRQ0ttTUZpaXZpaXlZZmhtZkwxUVRyUFQzY0R5R2FJSC9tVHM2?=
 =?utf-8?B?d1dIbzhScnpJdW5PUHBZbTE5VHo4Z1F4eTRHTTU4aUNVK0hpNkdiK2Y0OWlr?=
 =?utf-8?B?bzRNd2JId0EzUnNuODN6dEJkeXU5WnNnM2pMbHlQVHJlalltNGNlMm1LUklu?=
 =?utf-8?B?WktRVmt5WElnM2prMmY2enhSRGkreUR5aU5Kc21mYnNQWUJMTk94c3ExZk1Z?=
 =?utf-8?B?V1BxWjU5NUlGQitzVWV6MmFNSzUySnhPcFZkNkIwUVh1YzA5NVdSbWFEekNu?=
 =?utf-8?B?VjhuTkhvYTkxTFRnTnlOTEltdkhITk9Ud09WWkVFVFUwdlZuRGdCbHJuWXht?=
 =?utf-8?B?UFZhblUvbm5wSjNxV2RDTmJYZjB1dG96aHREelVXcElUL3pocC9tUVN1NFND?=
 =?utf-8?B?MnJ1TXhQdmpZbFNVN1YzZXQwZDU2OFBlTXdZUnN3aGlFREpxNkYvekZwMmZC?=
 =?utf-8?B?WFFXb25GSVdsMHZQaFJXRE1CWGNOeHhuZWJELzVQNzlkc05xaHFEb2t0ekFj?=
 =?utf-8?B?V1VrTkdnR1NrUkl2Q1dTcWZqM3YvM01DQ1VYRlFNRUZ5RTFVdFRZTmRNQ0x4?=
 =?utf-8?B?MVRTZVJRNDF2bGRkWHhjMUJUcFJNWE5IbUZacVRGUnB5N2ZCbi9BRXNqa1RV?=
 =?utf-8?B?SVl2Mmg0UGUwOTdQbkVkdTIrcjlhOTZVUzl2c3hvMjRYOFErbVg1bVVtcXYz?=
 =?utf-8?B?Tm1jZC9iOFJ4Y2VxSmJxVDlBc29hdTlKcVlYdkRQcDkxVXBraGMxU3h6d2Fi?=
 =?utf-8?B?RGRNYWNpaXppYVNlR3I1VUNiK3NnMC80Q2hpMjExWHpEVzhVZFhPVklHK2ZX?=
 =?utf-8?B?SDViK0tYeFBYaDdtMm5vODJjRERxNHlFcjVyRWhkblBGU1lzTHptcDEvMUlv?=
 =?utf-8?B?THcxOXZlMGUxV0JEbG4yMFVrd1N4MCtHOUhvN0puQkdWSkRZVGxES3BjeHlx?=
 =?utf-8?B?Y0Ztd3AvZnYxaVJTZ29pWGNHRlpRZ0FVSTE2d3cyOXBtL1NiL2NwbUQrVDk3?=
 =?utf-8?B?WDF0NFhaMFR5b1VjY2tidGExbUJZZ29UVEpDVEgzY0hoWmNBREpxNHZZL3No?=
 =?utf-8?B?MmZMdUlUNk4ySVgvTTVxNXFQbVlvVXdnS251dFprR2NEQWFUbDRYK2RiTHRX?=
 =?utf-8?B?d0FnZnYybkhZdjZXNzR6NnZKMStjbFNNTWhZazRZM2dUa1dhYWw5NUZFb0Ev?=
 =?utf-8?B?QmRQNzJ4ZTRicHVvMlVhKzk2ZnlQMHJGdTlHdWFIN0cvL0hRZUJITTNYY29P?=
 =?utf-8?B?cnNxM25PcmhndDdCa0dwNW4wdkVhQWpZWHIvVE43dGY2eVlPcjN1WjhNZm9H?=
 =?utf-8?Q?/CfNfzkkim9Vs6sJng=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUo0eElHOGUrWjFQVERLM2RqL1M3THhTNHpQWTZnT0VvTDNndnd0ZWlVMkYx?=
 =?utf-8?B?THg5NmNDbklGWkVJdDZ1SSt2dExGUXB5OGZ2K1FWNE5UdVVWNjlRL2hYdTBs?=
 =?utf-8?B?NGREQ3NQZ1RjajhzTGhLazJQcTF3RlM4TjZLdEFJTDliZlhJYjZ2UDF6djV1?=
 =?utf-8?B?MSsvbjhrQUREeS9PL1FxU2xtbFFwQm4xbmtKWWZYejRVZU1qVFdJaEFuV1Bj?=
 =?utf-8?B?eEp4aFBQckJTYTlDeWtjMlBGa080NjljNnI4M0gweXpjb2ljQVFPeTBjSUhL?=
 =?utf-8?B?RkF6S0UwVjEvYURUZFBTRXVieVlVZDE2MWRrczI5bmE4cFFETkxUQjZDRWVn?=
 =?utf-8?B?K3V6d0I2S2FSYTZkUHpNZWk4Nzl5dHlVUDIzYTJnVSswcEZCRDNZdkRXVFNz?=
 =?utf-8?B?Q2VIbEYrb0thdGs0N1praDNHeDRPdEQwc2lRMjRYZVFFU3VwVGFCUkE5R3l5?=
 =?utf-8?B?N3FYYWxUWWVBbDJuelNCNzdlaC84Wk9LcW1YTnZab1E0ZisvaHV1c2pPVi9K?=
 =?utf-8?B?N0xGVzFzSzFnOGJ6bW9xdHhucDNEUDBRRllvWCtGd29CVi8xNTZrQVNLelFN?=
 =?utf-8?B?blhqaXpORE9mME5sUkNKOWhFdnRzZHNuUTY3dVZTMXRTS3pzZGhERkJPajY4?=
 =?utf-8?B?OFAxRzFqYk5aSTRRYS9MSHQzcWJXNWxVMTJJQ2ovVHlGdkFnRmpsQnBwbXBJ?=
 =?utf-8?B?QUljVEtUWkpEbHBaL3FLWEx5L05GWHJPZGdSdmZMeWF2enI0TUw4UHFmV3JD?=
 =?utf-8?B?U3IrTUNBM2pmVzhxY3VTYUdkMlUzWkd4VUNRTHlPaTkwRHU0Q3VNZ2FUQTlO?=
 =?utf-8?B?aE9nYkwwTVhqV3dGNjVzcVl0THpjQUY4U0ZDYkRKeFZtTWp0K0JGYjJRYURU?=
 =?utf-8?B?OEs5amNaZTNvMUh3UmRWT0p2b2dkek94U3NqN1BxbnBkNWFLMGlnSFJxSkM2?=
 =?utf-8?B?YTUzUHN5NkVtOG9Wd2NqRGI1YmZmdGd1UU12VE4vaEFaVkJqOW4wZXdRTDVt?=
 =?utf-8?B?ekN4dU85QjNzTVY3RHZRb1hIM24rRW5ueVMyV2hNeUFObHdQSEkvQUtJdzBv?=
 =?utf-8?B?TUpPc0s2WHovUVk3b2Z1aHYxV2tvc0Y5NlVyQ1JKcGlHMjdtTHJueDZtd28z?=
 =?utf-8?B?U0hDZzkzcmp0V0hDbnVtZ2kvOFJKT2VGYmhVOFJXcHdEbFBMOGFJWm42NzlG?=
 =?utf-8?B?Sjlnb1phYk1mK083eXgza3VQNVB5K3NPQWFDUFZiNjRrWFA4U1dIMEFwMlor?=
 =?utf-8?B?eGJkUjlNSENlcC9wV3BPUHJHVnZGM0RyRjh5VlRuSU1DL0pMZ0FvNGFwYmpx?=
 =?utf-8?B?Zzh3RTVPaW1iYmlmaVpZVXpwRENNbWxUYmdrbVVUUDBPR3NuZ1prRUM0d3Q0?=
 =?utf-8?B?NzBhYlFkWmx4SjhIbkQrM01zUVd4UDJNTDZaYmxjaHZRVDNNb1BaaTVCeC9p?=
 =?utf-8?B?OVhCU0tqV0pTZ1N3NzRPV1UrbHFUZHVZR1gzRkl6V2pRNHNqRXpWKzdkMnAv?=
 =?utf-8?B?c0hMSDhBOHNPdHJFOXU3V0FLN3dsUkFUMFc2NTNpOGI4T3VmTnJ1d0wzTEk0?=
 =?utf-8?B?YkJ6K3htVDVNdWhPYWtvZjJMek1vQnFnN09YZXdQR1lYdHRKZHVRd0xJODJF?=
 =?utf-8?B?dXVscGZQM0l5M2xpZXJEckRqRjkyYkJTR0FoQUh5MWVhSSt1Rmt0c3RvaDFw?=
 =?utf-8?B?anM4SHozT3cwblY3UDZ2eTI2UUFRVmlaL25ocnJ6OGRzT1h2Q0lDOWVIN2g5?=
 =?utf-8?B?NWlBOG5lRkdYU2t5d093aU1LTHl4V1c2aVJScm5icmpXSmMrQkE1OTNKNnN1?=
 =?utf-8?B?WnhoM2FBTy8yZWFUcU1rK0NDY0JWeWJocTlKcmFKakt2YzFDenhPV3pUdGJp?=
 =?utf-8?B?VXNUTUZSbE8vM3YvUXM1Y0t1OFBoVEk0MlNJOE5aTFpEV1k2eUpENlpSV1Ru?=
 =?utf-8?B?LzNyTTg1cEVoZm5EK3ZjN09MSS9EVmFpWG4xcXVHSEhYWXNuVlhYbEs3eW9I?=
 =?utf-8?B?MXQ2YzNpS0tGNkNyM3NpQlgveVY0WWxHOVZtc1pHZWtNMGZwSEpLbTYveDdz?=
 =?utf-8?B?aUNzMnNGa1dOckx0bGliYWdJUDlIaTRBTmE5ZjZXcDZJdUFrdWxERG1yZEJX?=
 =?utf-8?Q?BN1VzYKCLFJm1VAIoVAS/V3+u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353ff28-9657-4782-0d6d-08dd0a96dcc6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 01:42:02.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A0uBCzCgvYIONzmFTKP/HlfSFe0hRz2AWKVfYmM2ZadnMBUlec8uhnCZCZ8MDKsk/oDJSHhc+qFGx+VmtDaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
Received-SPF: softfail client-ip=2a01:111:f403:240a::629;
 envelope-from=nathanc@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 >> Also as a heads up, I've added support for auto-inserting PCIe switch
 >> between the PXB and GPUs in libvirt to attach multiple devices to a SMMU
 >> node per libvirt's documentation - "If you intend to plug multiple
 >> devices into a pcie-expander-bus, you must connect a
 >> pcie-switch-upstream-port to the pcie-root-port that is plugged into the
 >> pcie-expander-bus, and multiple pcie-switch-downstream-ports to the
 >> pcie-switch-upstream-port". Future unit-tests should follow this
 >> topology configuration.
 >
 > Ok. Could you please give me an example Qemu equivalent command option,
 > if possible, for the above case. I am not that familiar with libvirt 
and I would
 > also like to test the above scenario.

You can use "-device x3130-upstream" for the upstream switch port, and
"-device xio3130-downstream" for the downstream port:

  -device pxb-pcie,bus_nr=250,id=pci.1,bus=pcie.0,addr=0x1 \
  -device pcie-root-port,id=pci.2,bus=pci.1,addr=0x0 \
  -device x3130-upstream,id=pci.3,bus=pci.2,addr=0x0 \
  -device xio3130-downstream,id=pci.4,bus=pci.3,addr=0x0,chassis=17,port=1 \
  -device vfio-pci,host=0009:01:00.0,id=hostdev0,bus=pci.4,addr=0x0 \
  -device arm-smmuv3-nested,pci-bus=pci.1

-Nathan

