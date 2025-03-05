Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6D6C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpl8K-0007kr-AU; Wed, 05 Mar 2025 04:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpl8I-0007kf-DK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:33:42 -0500
Received: from mail-mw2nam10on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2412::615]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tpl8F-0002vr-AE
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:33:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpzkBvxK5BW3NrHX6F2jy239RavPkKyyqlb0m2HF1knFKNv5YRUFa3vgSLcdSgw6/vpKNqTtZgAFNIzO+au0CYTq8ld/2YGjkxm/c+TTDE/a0FZOCPCJBJMYNsjVfEKuqsMXBLjNnCiOXGrYaoaAzEnSpVbT8RHmGBF21sDLqbGwNMRkWTsNMxwSiDg95cj3uJBMaB6hQ5/OIjULY7A8wJV5JEY1UA0ak1iXOxbkhKmjhsZzMFy8scbY9cg2btNBIgvr3gYWMCY1eqHhjJX7f8sbcig8OBZRX5wb+TRjn8I3Rvq7S1M6kDjp4T13E2F3Q8lM9UH7cCGLqGJNcH5LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHWhTVOhkeudfOyfcCHqYOdAz6AXfUgRp3TIiqceaII=;
 b=M+j3IuzvX/9qacd74d7KYC/MRNXo29y91YD0l7WJ/JZiLJ/NpwWarrQGeYcoQd8NDVsr3+yGKNQu4q8+c/WWVAMzefJB647CF8ToA4pKdH3wSEgaH+RQDVGW3jVqxYNW2nBPxkpZTt0Jbc1utnl06oUp3YE3KNtgipcT9RaqL3QsqgReosPBT/fELmFAjnXR4/MdY8CKG+Jusri9qTQNiBPwCDf7MkqBspdRDku+0uihsjCRE1xVziYYhZ4v+r5sTTE04rbeYXxkShY8tClt3xlTdKtz8q6IAUKrcVqb0sR7e3OEL/StjlhmKmoIQ6lgFgsdvM3EIiHDbnDK7Ng6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHWhTVOhkeudfOyfcCHqYOdAz6AXfUgRp3TIiqceaII=;
 b=Se0jhqot0OcstOKcba8+aO2hB4I/5j6PYz4aL8uPh/JjeQzuZzOq7RGqPWqCr60bHIUDK/Sy5m20rd05T9jenjwY7/oBQ/xYZEAgLvs5rkUBiTV1AKhX/083KXA84R0g7yY8ZQyPO1p2kq6QayFQPk/fZN96FdHA93SriKFHLx5Roe7IOVLquOjErKvAGRyT0hXq8p2vk8WF/P1mqRDcg7CcGH5hIW+lAl6y2LyBZynHin5964zhgk+90i8Ris6hMtY3JcEPM0cSudOmSMw/LqymN2Dr2kG/0yuxKv94hHoJ8cBlDGHeEEQtbCEhirElOT5vfE4iUwJcDlJDRbkBfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 09:33:31 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:33:31 +0000
Message-ID: <1d46d84d-aafd-4a6d-b982-ba930e1a532d@nvidia.com>
Date: Wed, 5 Mar 2025 11:33:22 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00/36=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::11) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 88052014-7623-46cf-66d9-08dd5bc8cab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmwyN0JiU3hIM2JOOTh2aGNiUzhnb2xNMWFPV1M3NysrZTNhOThWSmxwMTdE?=
 =?utf-8?B?N3piZTdNZUNxOENyNzhPR1Z3Rm5MZXB4d0Q0VGpaZENSanRDcGRnTWhOMW1O?=
 =?utf-8?B?dlBVbnN3Tk1XQXMvNjVGc095NkREOUlGTUxsTkp3c3A2eVpyVnJtd2JKRjcz?=
 =?utf-8?B?K3Y2ZDZpWnJyNDVJRlozNUJyWkIxTW9MM2M4TlUwVTJBRlpkR3ZQalM4VWZs?=
 =?utf-8?B?TTZHeHViQXZZem5BQTZRakhtTTcyck5VM2d6SzVmb1lLYld6ZlorWk5hZlNj?=
 =?utf-8?B?VUkxeDVhTFpxUFc1NkZoRGxDTUlWQ1VNZCt6V3VUOERtTEZSWDVYNkVPY2RL?=
 =?utf-8?B?aDVCWGl0M053K0FWUEhKQlVXODBkUVV6OXY4aHdYR1IrcTVZNmtiNjlGdy94?=
 =?utf-8?B?c29ET01MSk5yaE1uVGUyWTNCU1ZZcVdQQ2VwTzhBK1NNMlg3TzJUeEVmWTJw?=
 =?utf-8?B?T0FHejZzVWVtTWYxZ3hnWXNnSnNFZlFmV2JrQ0RaVlRkbGtyS1RsdXc1bHZp?=
 =?utf-8?B?VlhHVGo1SHV1bFBldjNia1NzTlFpK0JmR3lkaW5VM3c5M0hPTUhFSHMwVXF0?=
 =?utf-8?B?bSt6N0dZeHZtUVVqd1BhbHRkS0MzTHNwcUU3cTBYVmVrekJ6TUdFWWVCUVNX?=
 =?utf-8?B?TGlDZ3NLYkhlVUJ1aEE2d0FPLzN6eEpMM3A0NkNITzZYVmM4eFk0NlBBbG9G?=
 =?utf-8?B?WkIyRUVDZmE5aHlaNFJQRm5OTlhwYkdxcTNzZXNOeUdpMlcxbFJFSm8yOHIw?=
 =?utf-8?B?WGduNWRacFBrcDVQSUhSSEdXWHN6aTMvVjR6b0lUQjhqM1c4UXVwc01GaG0y?=
 =?utf-8?B?N1dmNTYzL0ZRNG1QdWF1OWVUZFJqU3A4alRwcG5PaEJKWmxWNWtaamFaLzBL?=
 =?utf-8?B?NE1DamhuOXJ3TWorWWVrbDJBclFLaUh0NkYweGxBZWFMaHF3ZkZiVURwTXBp?=
 =?utf-8?B?ZUluenhxSHphY1B2eWtJK2cyVTdzeXpJRTZsczVlN3djcTdRSWY0Y0R3QlZR?=
 =?utf-8?B?YnZNZFNXK3FGbEUzMDdpQjR0aWxMajVmVWJZQ1EzQ1ZHR1VXd3Y1Ulg3OXFv?=
 =?utf-8?B?L2hEUm1ONHU5UW5ROXhUYjB2U1FyNVpPOFB2TXhBYnNBT0g4UVBJVUxONFNh?=
 =?utf-8?B?Z3NTNWhLNXkwdk55eW0zQndSZzVqY0dWWHBWb2xBaDdJYkh5SFhVQ0c4SXBG?=
 =?utf-8?B?S2JuQkVFNTdKTE83QW9GMVhneDFheFVCWEJIOHJlbTY5NWhKR2lYUCtQcjE1?=
 =?utf-8?B?MTJQT09hYzEyZjh4cWdZTFVZY2llMTdQazRGbm9sbkFrK0VjcGlxaER6WFpW?=
 =?utf-8?B?T2tWUXQreUgyMEdQWXNYd0lwZUhkZDYwKzNUb1VBMlFqWkl2UmliSTVqdjhH?=
 =?utf-8?B?NGN3RnpaaXdxa1pVQ0ZHa0sraHloNzFBWEJSUDBVbE1yZ01YZWp0WGZEY1NT?=
 =?utf-8?B?eko1YzBtMWIxYjFtZmJUVzFCVFkyeDczNnlmMCtpMUs3Njl3TTQ3MEIydTVi?=
 =?utf-8?B?ZXE4SVdCeURGcEU1MFIrNmhsRExaUUgraVBCQjJFUVFYaWNtVVZIQTM1aHAw?=
 =?utf-8?B?SHU2OFBwSFd1eE56alV4Wml0RmdiSm1tUmNQRkc5Q1A3QUFnKzM1OEwyUEJ5?=
 =?utf-8?B?b09jcUFaWlc1cUVvTEQxTUxRb0ZFUkJBYllmcjdJdUEvaSt2dVdVYkpMWWxQ?=
 =?utf-8?B?SUc3emVHdTlCWWtPVC9hSXdwR0pjTVY5YXc2SEVLSFVwTGtXclh3blhLVWJB?=
 =?utf-8?B?Y3U3Z3ZIVTljT05GQWk0MHBlRlZYekozMVo5ckxTTVNuamFQaGk2S0dFMUxk?=
 =?utf-8?B?TEhlWXY1NjZnaEs1enRxRkN3Q25tTUtZRmdEdmlaRlduT2JxMUhHWndoT0JJ?=
 =?utf-8?Q?pXfupXqEK5SFT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRyMDRHZlNKZi9JMXBoeEhSd1BhcGN4VllaMnFwTkM0TEh5V3NrczZDTWJK?=
 =?utf-8?B?dllzUHJ4ZFFuRGhvRzhIL0xQdnBHS2pDamowcCs4U1owNFJJZmpSNnpUZmdi?=
 =?utf-8?B?UWpaVGE2WmRvWGRaZkZUUE1FdzR0V3JsQUtXeW1SSFJkWDFIMUJSb1VLUms5?=
 =?utf-8?B?T0FWbncyRFNXWUhyc2QxY09yRnBKYkxDZFVLYjBVVkJBZFV3c2x6eTRINGRW?=
 =?utf-8?B?QmFvOXdxS25HVnBFWWcwWU1MTDJGalNneUV0VldSK0VLT24zTmhHTUtOekM0?=
 =?utf-8?B?Sm9tT3NjclNXZ1RFZTRjZ1JrbU55cnRIWVp2WW1kYncvSENTT205VXgvWXk0?=
 =?utf-8?B?MXNFRlk4cEFQaElkK3JidDNjQnVFNTQ1N3AzdWYrMDZHZS80WXo0bSsrZlUy?=
 =?utf-8?B?cXQzVmdxZ2x6R2t1aUN1eUV3WVVvc3dvQitEZnJCRUFmNjNIbnBYK0twUDR1?=
 =?utf-8?B?a1pKa285TlJndUZubllpODloTW91a1QwbXE1cnNxeVV2T3o5NXRGN2JYSEVh?=
 =?utf-8?B?RzZ0UVFhVjUxdm9od1V0elNRa1NoU2xDdzZ0RlgwUmg4SEJMdHVzcnNQQjQ3?=
 =?utf-8?B?QTRkT0EzSW5TeVY5b0xMRXE5ait4dUl0Y1d0U0MvSjltVE85ZUxZcThOSUpO?=
 =?utf-8?B?SlZLWVNTSHZWNGVzVnhXY05WUThmWFo4RDEzYnpKWFZ1aE1yWDUyRVRWMWY0?=
 =?utf-8?B?OTE5bTRncXNhRDZ4V21HVnhnNk9MZ2o1clhNVHJzekdoKzR3clAvWEZNTUJF?=
 =?utf-8?B?VExOalN6d0lsRlRXbGVmM01rZWlBVFpac3FxZk1GWSszc0IrM2NMUitwY0RN?=
 =?utf-8?B?ZVY0Zm9aQVlNbW5idWYvRm9iZkpzOWVocFU2TFJ5UG5TTVhBTFA5cG4wdmFK?=
 =?utf-8?B?ZlMwQ1lHa2dteFY1anA1VXRwUDNHdkFYMXoySmcwZG5heW9QVi9SRytOd003?=
 =?utf-8?B?S2tFNVB5Y2Q3bmQ2RkFQYzJZTi9nS0ZLRkRWRW9ENEY3TGxaMmVWYnlZU1Fz?=
 =?utf-8?B?WStUSEROR2RtQjNtQ080SUlTVXNpcFlQMU5hNDBNSm9yc1dNWGo4U0Jjc1hv?=
 =?utf-8?B?ay9SUWtITW1CWTBlQTE2dWdvTXlLUmNwRkdpOHJFL0lLaDN6ZWYvVFZhMzFG?=
 =?utf-8?B?TTF3L3MrNkNmS3ArZEJmQWdOSEVRS0lhZGl4Rm42ZDVGM3lRMGVHTXA2bUE0?=
 =?utf-8?B?T05KNno3WXVxRG9BdVV5MEJPOU1KNU1zdmx0cnF2SWd3dW9kNndxY25zeFcy?=
 =?utf-8?B?K05PcUZrR3M0OHBIcytOaVpueHd5SDMwQzVFOW5Wb0xhMzZOODhDVkhCb2Fs?=
 =?utf-8?B?ZFhnWEVidkhsK1NuV2VDUmJBMzZDUGhqSHFQWUI0V1B3Tmh5TVh5QkduaDJN?=
 =?utf-8?B?RVZzT0FNVi94WGJiNmIvOHpuVHpZUmN6WVViV0t4QjhYVUV4Ly8xR1ZwZnpO?=
 =?utf-8?B?cDlxeldkeXB3WE4wS3h6SEdmdGdIUlRCbiswVmtyNHhwRVdDdHRzYStIaVVL?=
 =?utf-8?B?WkxTLzBCWWpuUy9RMGxBcFg0Zi9UOWVwVGlpNjhZVnNpN1J2K1pOU0NuSkhx?=
 =?utf-8?B?RUFmK2tTT2E4SDFSeTRyTWlKUmdkeU9BWG5jUFFaSW5EVXFjNnJCQWZkZXYy?=
 =?utf-8?B?cFJJdVY4bHJLT1pTYXRndUVpUVoyaFNMRFpOYTlzTUF4Mk5nYWVMOEJ1WVlv?=
 =?utf-8?B?Nk1KWjlRZlhNNFpJcUwvcGRpYXlTOGZZOExWUWdTb2VmbWVZaGdoWDBxcFp5?=
 =?utf-8?B?N3RqSXFpN1U5TElyUVZFUzJZLzZ4NHIvRWkwY2tQSXg5K2RuQlJKWnVYajlO?=
 =?utf-8?B?ZkFVYU9iWjRaRFR6QmUvN2d0TVdUTmtzb3piVzVUNy9TeFc1ZnB1c0dqQ1d4?=
 =?utf-8?B?UGdabEx0VkJEdkpBZ0FLNGFyVjMzdTFOdmlhbEd1STJ4OXpZYXBLTGhTZFlH?=
 =?utf-8?B?RUN5dWlEbk1aYzl0aFFQOHNWM0NwVGtTMGlCYlo2TU9rWXg1cllqNS9CZHBI?=
 =?utf-8?B?TFc1OTFhS3o0TzJYaGVLRlVGV0dpelhjYWlzb2U2MFlINFc3L0UrTzQzd2pz?=
 =?utf-8?B?bExLNENyTmJTWWFDM2xHZzkzZTdwbG1ncG53d1FzK1dlUFVKY3RQQjFaMU1C?=
 =?utf-8?Q?lOptVNHj6B/3WGm+iOk4OsaH8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88052014-7623-46cf-66d9-08dd5bc8cab9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 09:33:31.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbE4PJRgCrP6PoacI3IbC9MIkRljO7Kg1f825hzv/NtqCz6OgnvT2XYwikBjjYYG6wmaBUASj3fph0XnQMXoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
Received-SPF: softfail client-ip=2a01:111:f403:2412::615;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 05/03/2025 11:29, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello,
>
> On 3/4/25 23:03, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This is an updated v6 patch series of the v5 series located here:
>> https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/ 
>>
>>
>> What this patch set is about?
>> Current live migration device state transfer is done via the main 
>> (single)
>> migration channel, which reduces performance and severally impacts the
>> migration downtime for VMs having large device state that needs to be
>> transferred during the switchover phase.
>>
>> Example devices that have such large switchover phase device state 
>> are some
>> types of VFIO SmartNICs and GPUs.
>>
>> This patch set allows parallelizing this transfer by using multifd 
>> channels
>> for it.
>> It also introduces new load and save threads per VFIO device for 
>> decoupling
>> these operations from the main migration thread.
>> These threads run on newly introduced generic (non-AIO) thread pools,
>> instantiated by the core migration core.
>
> I think we are ready to apply 1-33. Avihai, please take a look !

Sure, will try to do it by EOW.

When were you planning to apply?

>
> 7,15 and 17 still need an Ack from Peter and/or Fabiano though.
>
> 34 can be reworked a bit before -rc0.
> 35 is for QEMU 10.1.
> 36 needs some massaging. I will do that.
>
> This can go through the vfio tree if everyone agrees.
>
> Thanks,
>
> C.
>
>
>
>
>> Changes from v5:
>> * Add bql_locked() assertion to migration_incoming_state_destroy() 
>> with a
>> comment describing why holding BQL there is necessary.
>>
>> * Add SPDX-License-Identifier to newly added files.
>>
>> * Move consistency of multfd transfer settings check to the patch adding
>> x-migration-multifd-transfer property.
>>
>> * Change packet->idx == UINT32_MAX message to the suggested one.
>>
>> * Use WITH_QEMU_LOCK_GUARD() in vfio_load_state_buffer().
>>
>> * Add vfio_load_bufs_thread_{start,end} trace events.
>>
>> * Invert "ret" value computation logic in vfio_load_bufs_thread() and
>>    vfio_multifd_save_complete_precopy_thread() - initialize "ret" to 
>> false
>>    at definition, remove "ret = false" at every failure/early exit 
>> block and
>>    add "ret = true" just before the early exit jump label.
>>
>> * Make vfio_load_bufs_thread_load_config() return a bool and take an
>>    "Error **" parameter.
>>
>> * Make vfio_multifd_setup() (previously called 
>> vfio_multifd_transfer_setup())
>>    allocate struct VFIOMultifd if requested by "alloc_multifd" 
>> parameter.
>>
>> * Add vfio_multifd_cleanup() call to vfio_save_cleanup() (for 
>> consistency
>>    with the load code), with a comment describing that it is 
>> currently a NOP
>>    there.
>>
>> * Move vfio_multifd_cleanup() to migration-multifd.c.
>>
>> * Move general multifd migration description in 
>> docs/devel/migration/vfio.rst
>>    from the top section to new "Multifd" section at the bottom.
>>
>> * Add comment describing why x-migration-multifd-transfer needs to be
>>    a custom property above the variable containing that custom 
>> property type
>>    in register_vfio_pci_dev_type().
>>
>> * Add object_class_property_set_description() description for all 3 
>> newly
>>    added parameters: x-migration-multifd-transfer,
>>    x-migration-load-config-after-iter and 
>> x-migration-max-queued-buffers.
>>
>> * Split out wiring vfio_multifd_setup() and vfio_multifd_cleanup() into
>>    general VFIO load/save setup and cleanup methods into a brand new
>>    patch/commit.
>>
>> * Squash the patch introducing VFIOStateBuffer(s) into the "received 
>> buffers
>>    queuing" commit to fix building the interim code form at the time 
>> of this
>>    patch with "-Werror".
>>
>> * Change device state packet "idstr" field to NULL-terminated and drop
>>    QEMU_NONSTRING marking from its definition.
>>
>> * Add vbasedev->name to VFIO error messages to know which device caused
>>    that error.
>>
>> * Move BQL lock ordering assert closer to the other lock in the lock 
>> order
>>    in vfio_load_state_buffer().
>>
>> * Drop orphan "QemuThread load_bufs_thread" VFIOMultifd member leftover
>>    from the days of the version 2 of this patch set.
>>
>> * Change "guint" into an "unsigned int" where it was present in this
>>    patch set.
>>
>> * Use g_autoptr() for QEMUFile also in 
>> vfio_load_bufs_thread_load_config().
>>
>> * Call multifd_abort_device_state_save_threads() if a migration error is
>>    already set in the save path to avoid needlessly waiting for the 
>> remaining
>>    threads to do all of their normal work.
>>
>> * Other minor changes that should not have functional impact, like:
>>    renamed functions/labels, moved code lines between patches contained
>>    in this patch set, added review tags, code formatting, rebased on top
>>    of the latest QEMU git master, etc.
>>
>> ========================================================================
>>
>> This patch set is targeting QEMU 10.0.
>>
>> It is also exported as a git tree:
>> https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio 
>>
>>
>> ========================================================================
>>
>> Maciej S. Szmigiero (35):
>>    migration: Clarify that {load,save}_cleanup handlers can run without
>>      setup
>>    thread-pool: Remove thread_pool_submit() function
>>    thread-pool: Rename AIO pool functions to *_aio() and data types to
>>      *Aio
>>    thread-pool: Implement generic (non-AIO) pool support
>>    migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>>    migration: Add qemu_loadvm_load_state_buffer() and its handler
>>    migration: postcopy_ram_listen_thread() should take BQL for some 
>> calls
>>    error: define g_autoptr() cleanup function for the Error type
>>    migration: Add thread pool of optional load threads
>>    migration/multifd: Split packet into header and RAM data
>>    migration/multifd: Device state transfer support - receive side
>>    migration/multifd: Make multifd_send() thread safe
>>    migration/multifd: Add an explicit MultiFDSendData destructor
>>    migration/multifd: Device state transfer support - send side
>>    migration/multifd: Add multifd_device_state_supported()
>>    migration: Add save_live_complete_precopy_thread handler
>>    vfio/migration: Add load_device_config_state_start trace event
>>    vfio/migration: Convert bytes_transferred counter to atomic
>>    vfio/migration: Add vfio_add_bytes_transferred()
>>    vfio/migration: Move migration channel flags to vfio-common.h header
>>      file
>>    vfio/migration: Multifd device state transfer support - basic types
>>    vfio/migration: Multifd device state transfer - add support checking
>>      function
>>    vfio/migration: Multifd setup/cleanup functions and associated
>>      VFIOMultifd
>>    vfio/migration: Setup and cleanup multifd transfer in these general
>>      methods
>>    vfio/migration: Multifd device state transfer support - received
>>      buffers queuing
>>    vfio/migration: Multifd device state transfer support - load thread
>>    migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>>    vfio/migration: Multifd device state transfer support - config 
>> loading
>>      support
>>    vfio/migration: Multifd device state transfer support - send side
>>    vfio/migration: Add x-migration-multifd-transfer VFIO property
>>    vfio/migration: Make x-migration-multifd-transfer VFIO property
>>      mutable
>>    hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
>>      property
>>    vfio/migration: Max in-flight VFIO device state buffer count limit
>>    vfio/migration: Add x-migration-load-config-after-iter VFIO property
>>    vfio/migration: Update VFIO migration documentation
>>
>> Peter Xu (1):
>>    migration/multifd: Make MultiFDSendData a struct
>>
>>   docs/devel/migration/vfio.rst      |  79 ++-
>>   hw/core/machine.c                  |   2 +
>>   hw/vfio/meson.build                |   1 +
>>   hw/vfio/migration-multifd.c        | 786 +++++++++++++++++++++++++++++
>>   hw/vfio/migration-multifd.h        |  37 ++
>>   hw/vfio/migration.c                | 111 ++--
>>   hw/vfio/pci.c                      |  40 ++
>>   hw/vfio/trace-events               |  13 +-
>>   include/block/aio.h                |   8 +-
>>   include/block/thread-pool.h        |  62 ++-
>>   include/hw/vfio/vfio-common.h      |  34 ++
>>   include/migration/client-options.h |   4 +
>>   include/migration/misc.h           |  25 +
>>   include/migration/register.h       |  52 +-
>>   include/qapi/error.h               |   2 +
>>   include/qemu/typedefs.h            |   5 +
>>   migration/colo.c                   |   3 +
>>   migration/meson.build              |   1 +
>>   migration/migration-hmp-cmds.c     |   2 +
>>   migration/migration.c              |  20 +-
>>   migration/migration.h              |   7 +
>>   migration/multifd-device-state.c   | 212 ++++++++
>>   migration/multifd-nocomp.c         |  30 +-
>>   migration/multifd.c                | 248 +++++++--
>>   migration/multifd.h                |  74 ++-
>>   migration/options.c                |   9 +
>>   migration/qemu-file.h              |   2 +
>>   migration/savevm.c                 | 201 +++++++-
>>   migration/savevm.h                 |   6 +-
>>   migration/trace-events             |   1 +
>>   scripts/analyze-migration.py       |  11 +
>>   tests/unit/test-thread-pool.c      |   6 +-
>>   util/async.c                       |   6 +-
>>   util/thread-pool.c                 | 184 +++++--
>>   util/trace-events                  |   6 +-
>>   35 files changed, 2125 insertions(+), 165 deletions(-)
>>   create mode 100644 hw/vfio/migration-multifd.c
>>   create mode 100644 hw/vfio/migration-multifd.h
>>   create mode 100644 migration/multifd-device-state.c
>>
>

