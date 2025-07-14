Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D91C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubM0R-0002Xg-IW; Mon, 14 Jul 2025 12:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1ubL42-0003TJ-JH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:25:58 -0400
Received: from mail-dm6nam04on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2409::60e]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1ubL3z-0003Yp-A4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LL9S5axfsUOj0k6dAvrkD1UfAWd7F4V77K/z3YX/zvFr4sY9O0Pq60WP1LkeHafWy5qw2eF4ZVN2SdHSS1h5MesKYfXco1ybY1KuwOR2WRlDPxPp9rgBZgVn+P04Z6oN5RBlim16oY7atgebEcwd9RRZbFHLZAnpNaN/R2KX/6CX41RGEBA2l7sXUN0Q1UkixSthbSqa/euc02YWNc3RkHu+DphhxIsB73b+gRGGzD9a4Cq0caF26mqYNgqLg4vIx/QKQ3CD00Jdp3fyZZS2cY0j36tm4lhFxbfjSLyZxdgpOBZairBhiU7kJr8eWJ+7wxS991FxeI+VE4ODuX7z4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=josiSr6V42lXxn8qvYWI3mE+tkLBIXIE4U7o2JAcgtE=;
 b=sD03Lb111it8sFcgZIilb7jfCcLADMCOjS5GnfsxMjgfJEzGXN70ahB7Bm7wH+mN9Jtg8XpHiGmBZ/5PfQtSPWq3dQV9pUjkhkdc27XQwmFyYVtWQw0HVEgwDlOEthNsAQoOkFf5HUBz12AXMX+q4dW2k6IYiM8/ioxQUih1yRb+haWBA56dZh0isGsE8xhO2qzXlXGVdYRiz0GekKr//n9Vi9qljOwW0XiuOVqIGuoKZ5Ng3pGk2odDchgCO1M8frenaWrnePpo5W5YUsQiSeomB0uMUlbsJTBwW6Nw9r9J9+g4K/x+QDlnzvukPPOVT1Hhb26+m/A+4F145yfRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=josiSr6V42lXxn8qvYWI3mE+tkLBIXIE4U7o2JAcgtE=;
 b=nkIPJELSvqSUBeX15/xUpt30T5STHfLw6wuybB/Gw4OTaueZhxEDXn3zLeKNDPndCB4i0tKZlbiRNS0x4msBEnFElPO+GELYWhE/UAF1zJaHA7HMnxDdSeh9P/VsCS+3JJjbrfhOrDQqE2SNWX2PTbK3/l651ZYyLK4Zt2K+c3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 15:25:49 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:25:49 +0000
Message-ID: <913eb1c6-3422-4ac7-8cdb-2e2bc026ba2d@amd.com>
Date: Mon, 14 Jul 2025 10:25:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-8-zhao1.liu@intel.com>
 <d19082cc-6662-4299-89c6-94657ce672f7@amd.com> <aHUlHjzYWUM/ryQy@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <aHUlHjzYWUM/ryQy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c109d7-4de6-4df4-2ccb-08ddc2eab680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlVtbUsrVExYaWdpTjhhOEtEZXBlS0FPQi9PTko5K0NjNGhLOTNFcVdkbm5N?=
 =?utf-8?B?eStZcjE4RGN6S3RRMWhqajY4UFcyb3F6SXlwQXRVd0Ntb3hFWWhVM0hmaGJJ?=
 =?utf-8?B?TGc1VkZXMExHS3grZ1pHeGtiWHJVKzYyN2RxQ1ZSMnErOVY3ZjRMbUsyc0ww?=
 =?utf-8?B?OEgvalZ5aFM0V1NEK1lXSnJ6R2xUT2krN3hBM1BHVkcwTkowVmhPRkx0UlFX?=
 =?utf-8?B?OEdWTnhRbHhlRy9YOXhHZnpMQTRBTzNvVWtzRWZrRnpoajZpR2dlY25UUnVW?=
 =?utf-8?B?cmk4YkoyVnhrZUtjWWdYM3FCcXJYUmxWaU51V0EvQTBlT1p5YmZ1STR6ekpG?=
 =?utf-8?B?WWRMSmw3Y3NyL1FVNHo3MUYwNXFzZ0E5cm5TMzJpSUV5cjNZUy9zampORGFW?=
 =?utf-8?B?S0Qza25EdmtTWHFheVNobnhWQ1JyZG9qQUxZeGJ2MWJlQmFnT2hERWsyN2NU?=
 =?utf-8?B?Sy9yazRxa0l5dmE1L2Z2elJSNDgvRWtLNi9ZUWdiL1B1bFNtcVk3eUJ2L0k4?=
 =?utf-8?B?bTYrM1RGNm1kVHhpbmw2T3c0WklrekNUK1pBQ2tUcVNXK1lQbXdoa203T08x?=
 =?utf-8?B?aGZnZE91OWlndlRuVjhwcGhLZUFYNTZzaHZEa3E2am5mYk51SDE3bWZLTlNQ?=
 =?utf-8?B?VC81bUFIVzhqYjB6OEg1NW5HNW8zVnRqb1plRTFISEJ1MjFwYWE5ekwvOEEx?=
 =?utf-8?B?bG9YR2RjMktFc1ZZdkIwdTBKT1EzY0tweW9BTi9XU1FUUUNyamQ4RVFJOTM2?=
 =?utf-8?B?NXY3K1B1VEJrNTAxT2RESjkydFYrV1o4b0h6R2Z1cEFnYmw2MlpoaExqckdJ?=
 =?utf-8?B?R2lWWjJhdFhjYTNseW9BZnZWZDgvQXVoU25RcDl3UEFZSUJ4aDQ2ZVdYRlc1?=
 =?utf-8?B?cjVFTjRjdGtkZzFsV1N5OVFWTnYyYTM3QVI4eUFrWlJETDJIMVN3K1FVZE8z?=
 =?utf-8?B?UEwzTEJtOFVsOWpwYk5hcXFUM3owZks3S2xRZ3BqQzM1eUJWbU5UcThRZFVJ?=
 =?utf-8?B?M1JwUTg5TDU0WXpjTnhRQU9DSThBak8yRzcvMVpJV0FqUjBmd1RuZmJmNG1a?=
 =?utf-8?B?Y0JqcUsxMFE5bzJUY0JLcEMxZzlTR2NHb2ZYbDd3bFNORUpJT2YwMnFBS0xk?=
 =?utf-8?B?V0YwTkJRQVZ0ZHE4cjJIY0FsTHZTV2MwazdaWEkyT3QrQW80NldHKys2bXRw?=
 =?utf-8?B?QWRWeHdhR3Q0SWhIQUg3SWoyUVBydHI5SFBIMUxIVDlYbjV4am5xU3IyVTA5?=
 =?utf-8?B?akZQOEE5VnhZbmxNdHZpOHZCaU4rN3B5Q3EyZHZML3I4Q0lneFcyY3M1WGZR?=
 =?utf-8?B?ZjkyOWNmdFNmK1Z0anRheTU4VHlON1pFelFsMWIraUpVczQyOEpyem9Ydk1i?=
 =?utf-8?B?aXBCRmFkY2pXNVV5OWg0M0svQjZ0YXdRQWFldjlrRm5YRHMvRk1pcW1Fd3Y1?=
 =?utf-8?B?VVZtRUJ6R3NKWkRpVU5QVE1jM3FDNGdIZ3Zmam5PZWIvd0IwRi9aZlFiTjM5?=
 =?utf-8?B?cE1ORWkrK0N5aERVUk9TWC8yRkxWNXNXWXlIR2ZlVW11MDFkVDVJTHNzN1BR?=
 =?utf-8?B?bmx4cytoQXBOQUxxdmFiL0hOb01oU3lxckFwODhjdEhIY1A4UVFSZEJzb2xK?=
 =?utf-8?B?VTFwVHR4L0NSUllUYzZhQTRNTTFsV3NoTDlRMHM2Ulp5R0hRSXh1MUdEeFFi?=
 =?utf-8?B?UlRXNjh4RkU5ajNyNGhud016TG9jeHh6MGJjNlFLcTNZUW5YMUdFK0s1ZG03?=
 =?utf-8?B?SlU4Vmt3ZEE4OFo4OTc4a1ZZU3NJaGlnZ0xONGV0cGp0OGIvcWltdjRrem5i?=
 =?utf-8?B?RTlIbExYbmFLTERMdFZYWWMwc0t0dXpGc2RmZmJtdG9VV3dGdUVNbnJCMkk4?=
 =?utf-8?B?Q21JTkRUeFZ4Z0tpcC9BQ2IrTjdsNGJVa1N5MWdyMTZMelV6RnVJMkdQOERo?=
 =?utf-8?Q?q3Boi5bMyWs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZDbTlOcnJmczB2aVN3aFExMlA0MEtQZVNkdUsvbVEybVJndUd2eTZ0Ky9q?=
 =?utf-8?B?c3VVT1o0dEo3TWhZV0FSWjZQSVhBNVFRcFlLRldJclhBemhXeUI4azJqdStZ?=
 =?utf-8?B?ZzY0UUV1MzMrb0d5UG9nOVVqaE9ObjNqWndJQlViTnE3ekFHelhXOXZZMVRK?=
 =?utf-8?B?aVl4aGVVZ2dueHR4UHNHQ3hYNjhLWEpObkpObVdDSDd6dHpOc01tOHRyVWJz?=
 =?utf-8?B?cEJLRG1LV3ZaNW15ZllERmsvVEJnWFhUOTIrS28wY1pSWklsU3ZaOHo0Q1px?=
 =?utf-8?B?ZHpvV1I1RkxadlRKeWMyRG9lRUdHY2FBSmdYTjZYT0UvT1BWcDl1UWdLWEJr?=
 =?utf-8?B?Qlh5TnM0REp4UXJlbWNzazVNNU9BdVVsT1dYcjNLdUR2dXlnTnVUaE1kN09m?=
 =?utf-8?B?TlE1ZmhBcVo3VWFieHVqeDdsSkxUSDIwVDlNdUh5ZmFNeW05ck4vMG93OG9q?=
 =?utf-8?B?MElvcHhjYnRoZlUyV3ZtRlNtWHptWHlFU2RkazduYm9uZFk1Q2YxSzJrRnZ4?=
 =?utf-8?B?dXBpKzNjcit5YjF4M0ZsK0dkTlRGcVdqelEzNDdNbUpzVGFzRitsQVRGMUtZ?=
 =?utf-8?B?eEZnR1I5NVozODNnYVdzcWtNTXhrdStma0FFajdFU3hpOVRjcEVROWlkU2k3?=
 =?utf-8?B?ZC84cUc1OGoyRnhBUmprb1ZmTCtJNVpadHhidVYwMzdYeURRVWtyaGtDWDBM?=
 =?utf-8?B?VXhZZHNRa0xNUGNnaEhmUW44T2RUMzVzbDdHTUNwSTNQTG9Hb3pGcGEraDho?=
 =?utf-8?B?MDdHOC9waEEyVWZsM2JTZUNLNkdSdEgrbnBUa0ZycUhMczBGbndOckRVd3Jw?=
 =?utf-8?B?V29IS0g2ZisvOWRUaHlzbE9JWHJoMmVGZVBqR1hZaWdIRjdwK043cXU4VUhT?=
 =?utf-8?B?aE9zcS85UHN6aTI2SS9PRjJyVU5xNFRHbFhpRm5sYUhJdWtGK0JuUGR5ZzdM?=
 =?utf-8?B?dis5L1pnWjdHRTZlcVhtUUJ4bGt0QWZBK0dMNWpZd0xWRm9CSmZ4cXA1TGZa?=
 =?utf-8?B?WVZCN01tVDhhRFhpbFlKRTdLM1Q3amdLQ3ppaW41SjA4SHhISkZiOVppOFZZ?=
 =?utf-8?B?M1JpKy9ZYmgxVEdueTFJWUl6bE5DYXd4RjNMckRqWjdUUUhxWVcyZk8wcGtS?=
 =?utf-8?B?Nlg1T01qdnFXSjc2Wi9XTWVWMXl4UzBJNVVmem1jT1RCcSs5QlM5OEpFTDZT?=
 =?utf-8?B?L1JEcG1KT092RXF3ekRFZHV3a2pVcWxqRW1mTEFqU1lDYkhvWmJJaUNZWEZK?=
 =?utf-8?B?NCt0Rnk2Z21NWGQwS3pzYTBtTElEMkdMSVFtQXBkNkFZKzZZYjZySExDSUt5?=
 =?utf-8?B?alM5TXVrK0dlSEE2Q1JLbWw2a3NldnhDbUQ5LzBIUkxyckJtWGxkSkV5VC9u?=
 =?utf-8?B?aXZhNTRDc1lOQU1ENVRXVkM2Zlh2aklod2xPZlVGY1J4b2dTa3hTbzcwQVFH?=
 =?utf-8?B?QmdwOVJCWHBuSjM4Wk9VSWVYcmVXTjVsZXl4WHZhanJWS05qN01aT3g5Ti9s?=
 =?utf-8?B?V0k0a3J1aEJGZTlOVURtQTkzQ2c5S1dvT0hLaVV3b0g0a1AxTXRLeC9vVkpZ?=
 =?utf-8?B?TnA1VFNGMmZvNS9NYWlkZEVCSTNZRlEvL1R3YUxpN084dEtTa1pGS0ZueWRo?=
 =?utf-8?B?bWMyOGg5N2ViR0JOTUZjTjNuZWUxSDBNcEhpNng4VEhIWUtZYm4rb2NvNDlT?=
 =?utf-8?B?Sm1pWEh6K3hCNE9leVA4WWNyNkQwV1g5ZU1OS0lWVmFoY2tsQnJTY2tCVWVz?=
 =?utf-8?B?empDTm54bzZjMVNMTnBrdGUwd0U1ZDJ1YWxYbEJldU80T1pTaGRQNXdUMTZO?=
 =?utf-8?B?T29zQUdDMnhtcmM3U3VrWktMdk1OcFJvUTk4VE5JUWxHUVBZaDd2ZkVpdWdh?=
 =?utf-8?B?VDE3NTNEUjhUWWRLWHRNVFVJRHVyRVAvMlRqQ092M25Ib29vZFRDSkM4VkF5?=
 =?utf-8?B?Z0dpQWdwZ21lOGtLSmRRUkxMMUwwcjVoYWRkbVhVTXZicEpmdi9qREpDcW1C?=
 =?utf-8?B?NFd1dUNRc3ZXNFpnK25qb3NMVVppR2NjWWkxZk5VR2pZU25zRTd0b3dZVjB5?=
 =?utf-8?B?TzBMY1RDYVBnU0ZYay9NTEhrQjZmbkxDbU5WclEvOFpZdUFScXRTMVV5dW5y?=
 =?utf-8?Q?KIVk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c109d7-4de6-4df4-2ccb-08ddc2eab680
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:25:49.8166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDCpgNKsJuKH3ulMOSKPCTDrIXaL2vk2Ks9EjTp2k15frZb7vISX/sP+a7/t2KaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830
Received-SPF: permerror client-ip=2a01:111:f403:2409::60e;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/14/25 10:41, Zhao Liu wrote:
> On Mon, Jul 14, 2025 at 09:51:25AM -0500, Moger, Babu wrote:
>> Date: Mon, 14 Jul 2025 09:51:25 -0500
>> From: "Moger, Babu" <babu.moger@amd.com>
>> Subject: Re: [PATCH v2 7/7] i386/cpu: Honor maximum value for
>>  CPUID.8000001DH.EAX[25:14]
>>
>> Hi Zhao,
>>
>> On 7/14/25 03:08, Zhao Liu wrote:
>>> CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
>>> logical processors sharing this cache is the value of this field
>>> incremented by 1. Because of its width limitation, the maximum value
>>> currently supported is 4095.
>>>
>>> Though at present Q35 supports up to 4096 CPUs, by constructing a
>>> specific topology, the width of the APIC ID can be extended beyond 12
>>> bits. For example, using `-smp threads=33,cores=9,modules=9` results in
>>> a die level offset of 6 + 4 + 4 = 14 bits, which can also cause
>>> overflow. Check and honor the maximum value as CPUID.04H did.
>>>
>>> Cc: Babu Moger <babu.moger@amd.com>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

>>> ---
>>> Changes Since RFC v1 [*]:
>>>  * Correct the RFC's description, now there's the overflow case. Provide
>>>    an overflow example.
>>>
>>> RFC:
>>>  * Although there are currently no overflow cases, to avoid any
>>>    potential issue, add the overflow check, just as I did for Intel.
>>>
>>> [*]: https://lore.kernel.org/qemu-devel/20250227062523.124601-5-zhao1.liu@intel.com/
>>> ---
>>>  target/i386/cpu.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index fedeeea151ee..eceda9865b8f 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -558,7 +558,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>  
>>>      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
>>>                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
>>> -    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
>>> +    /* Bits 25:14 - NumSharingCache: maximum 4095. */
>>> +    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;
>>
>> Will this be more meaningful?
>>
>> *eax |=
>>  max_thread_ids_for_cache(topo_info, cache->share_level) & 0xFFF << 14
> 
> Hi Babu, thank you for your feedback! This approach depends on truncation,
> which might lead to more erroneous conclusions. Currently, such cases
> shouldn't exist on actual hardware; it's only QEMU that supports so many
> CPUs and custom topologies.
> 
> Previously, when Intel handled similar cases (where the topology space
> wasn't large enough), it would encode the maximum value rather than
> truncate, as I'm doing now (you can refer to the description of 0x1 in
> patch 5, and similar fixes in Intel's 0x4 leaf in patch 6). In the
> future, if actual hardware CPUs reach such numbers and has special
> behavior, we can update accordingly. I think at least for now, this
> avoids overflow caused by special topology in QEMU emulation.
> 

Sure. Sounds good to me.

-- 
Thanks
Babu Moger

