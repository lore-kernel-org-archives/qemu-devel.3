Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCF5C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxEc-0001qV-B1; Fri, 28 Feb 2025 05:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tnxEa-0001pH-Ro; Fri, 28 Feb 2025 05:04:44 -0500
Received: from mail-bn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62e]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tnxET-0008Mk-UM; Fri, 28 Feb 2025 05:04:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LU44vQ4UVnahIdO5SNjQxhYEO4oFdnfk/6f3XamPoyne+gCaMltqmLfF0nAqxScEYtvGvnooSvimeDlRLIyAg7IVMJE2HDFWAXik4eEO6F3JgBRLEhrny0wSGAFZnUPaTiprRbrrnyEgi8YO48fMFmPjNgweHuJrDq88zyrqkeycKbI0jxtYG1A2sSyDqvNcix8CUnCA/9F2uNBjMCWnbzPrBzWokRCIBOdyBTpbRp67ZIZOgdRud0m5CJNlr0iwWuwtBSbh3FZugeHOUIzPQniK/gsFVEFx7CGWbfwcuMHFYGgsyP5/0mZ5ojmLjDnJV0nvZmGXw8R82UgdRU/h7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxo9YIpUGteaeQSjX5nkYQF6Z9bcAy7RaNY/44PCKfE=;
 b=REh3UK+6KHoNPd9R3OSR4W5Q4Bo4Llxh7MN+t0JDLGp57YQhAaececR02pxdWle/Mh5250zk9Ejdid4SAdcgyPdg0H+uABFG6/a61udlAkiT6X4YDcrr2I9Nc/UmcIbunp9On/j6ORNIR8Z7FxKhHGD1n+DurBHngxDLafbnKxF2qg/CDg8NfUdxMLaXsRKMavEcqFKFZ9Yz1NiwHVmB4UWS0dhX58ihuEUNq2Tnb0dGctyBiXQlzrTa+TEcRv4kVOmB+5HfDQFvd29irx1AsDgR5rJ+V8tQFi+R0zL/NIZfYJuiYBKgmjWQGNbce3gn7rK+3jHX0pxKVbS2B7Rrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxo9YIpUGteaeQSjX5nkYQF6Z9bcAy7RaNY/44PCKfE=;
 b=0j3M9WPNBI8VyMJP2bzo2bT1NPFFAMC7XUym/YBrM2VKG1mTyANKiPQknbCIBAPYKIaRqFv4i5t792fms+Ewu+NHOlGdBZr4oX4aUnWdXZ2QjZb/ZawwNzlggGqVi6gWJYhlbu3QQCCVKuw+zu6hlrPVNH5MCAQH9nu0ZZ54IYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Fri, 28 Feb
 2025 10:04:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 10:04:27 +0000
Message-ID: <185d064b-6a2d-4ae6-926c-0f847e15cd61@amd.com>
Date: Fri, 28 Feb 2025 15:34:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Emulated AMD IOMMU cleanup and fixes
To: Michael Tokarev <mjt@tls.msk.ru>, Sairaj Kodilkar <sarunkod@amd.com>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, suravee.suthikulpanit@amd.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250207045354.27329-1-sarunkod@amd.com>
 <985611f9-e7f9-44d0-a8c0-95fb48370591@tls.msk.ru>
 <75adbcf1-0acd-40e7-b1ef-c699c07bf2fc@amd.com>
 <e021e4d9-fe04-4832-bdde-c394473283ca@tls.msk.ru>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e021e4d9-fe04-4832-bdde-c394473283ca@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f8dc5e-e178-46df-aa61-08dd57df4931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlVGMCtFNHhZdUM3bmVGcEFFUUVXZDExc3pOU3pQYmRTTjlXZUp6Qi9BdCts?=
 =?utf-8?B?V2xWYjhhZXJLaHphWTdwcFdHWEtpK2hJWjI2ZG0zc0lid3JvTGNtaGpYUFJL?=
 =?utf-8?B?dDFZd2pQeUZMTldEVmdvV000UjJLbThTTmhaTTFKTFl0Sng5V3oxS3lxZkFw?=
 =?utf-8?B?QUFlQ1ZIeUxWcTdmdFRYMU96L2xOeXpvekcvNGpzMk5aT20xYVZJZzROMVg4?=
 =?utf-8?B?eDdyUjd3M0laQk95azRDdXJPclB3ejd1aUc2d3piVVBOQWgxQm1hYWQ3dmFj?=
 =?utf-8?B?QUg3MHNLTDJ5d0hwV2dIQmZwdDhXblR1WXdOTStEYytITDhCeTNYWDZPVnJt?=
 =?utf-8?B?QUVUWEs3c1ZYd1pZaGx3amVOTWRNNjRmWnNNcVhXc01UOWhmU3VTMm5lUHJy?=
 =?utf-8?B?eWpoNUxiQ3MvVU9qMS8zMngwd3daU3pZRG9ZTG55U2xGL1k4N2RpUGE0K28z?=
 =?utf-8?B?Rk1RakxQcVhGTGY3ZmF3S042NW00dGtSVG42N21ITGRENzc1cnlUWkx5N25T?=
 =?utf-8?B?ditFZVR2RmhCTHYwZWRtTytwTXZtQThYQndrWkdEU0x4MFpuVWVHQWFRKzlQ?=
 =?utf-8?B?cTV4MkJnRVA4RE1FNHhGZzJ3RGRLOExDdjlFQVdHQTlURkwxaGVOQ0ZQN0pV?=
 =?utf-8?B?bExOUkRSVE5QeGpkT3BxSmJvQzZhVXQ1d21JTUZoL2lGY0g3ZUFUVUdVOVp5?=
 =?utf-8?B?Tmo1QW9JMkpBbFl4VnVweGRNNEgyblVOT2NNaE81cWlRei93ckVqOTdTN2xV?=
 =?utf-8?B?VUdlL2swdU9YK2ZKMkJuLy9rQnhLWEtBUUpBUDZPdUFoaFpPdWdsa0FlSHVp?=
 =?utf-8?B?RjIvMmFLMHhlcmxFT2tWSzRERHZOTEtzekFCSjQvL05aam9GL2h2bFFQWXNz?=
 =?utf-8?B?RHBEZGFVbnF1OUo3UDR1R3JtL1hubWNHQ2dtRjN6NjVrdzZJLzNBNERtWTV0?=
 =?utf-8?B?TS8vd2t5VXhKVC9GeWJTbmY3bytERXRwYUJGRFMxNUVkVW5CdHc4T1h4aGNH?=
 =?utf-8?B?a0RzRWVJY0NCNXBFelgrK0J6Y3lHZ0JxdzdaSFJCK2ZUanp3OC9sbVNUMVVy?=
 =?utf-8?B?bElkVlloT0V3NEFzcnBkcFVueVFvbnBXYVRmTzRXVXUrbFdwVG5IeGdLeDht?=
 =?utf-8?B?Z3l1cjFXWGc4SEpqa3JvRFFJL2Q5YnE3Kzg0aTRkdGZDQ05VaFBJdlpnUHF1?=
 =?utf-8?B?VWRvQ0Fmc1RBK2ZzNERLaEVjY1MvR3pqL045YmFxVHFvc3hheHFZSXNFanVE?=
 =?utf-8?B?TEJPWXpkcGNmT2Y4L25CZDl4ZysrTkRhRkhZbWw0TjdwTlk3M0RFbEZXT0JD?=
 =?utf-8?B?WGt6QWxnUjF1R2dGTVI0dS8zU0pYQ2NON21wenVnZTJQVUJhSkVGZGtsU3ZU?=
 =?utf-8?B?ZTlldW9pd3BNMkJVdUVnTnh1OFg4YVY3Vm5oaDd0bTN2cHBLRW5LZ1lNTUJq?=
 =?utf-8?B?WkhtM2E1ckxjRlJYWG1wZkdpdmxvcHVlTklxSmhDT0h1VWdXTXYwYm1aTFpw?=
 =?utf-8?B?VGhvQ2IyU3YzVUJrcEhzK3lMVStvK0R4T3kvWHNNNytYSHBHRlNCK3U3dFh4?=
 =?utf-8?B?WVRyNnZTQ0MzQ2dxN0t6dVpRU0NLZjZlNytwRGV3MURkNjI0OEZSTytpNTdt?=
 =?utf-8?B?akNBNjZvNUxTWlE3SFZCdjVMNWxsbllxWHNuNEQ4cjlCT3pVRGJaUlVmdm5p?=
 =?utf-8?B?b3gybUJLVk5aYytKOEdESWlDRjF1QWpjZXhkLzIweWtyVThlWFJZaW9nTkph?=
 =?utf-8?B?dUxnWmFwOFBCdC9NNXZROEErMnd3VVRzVHYwYkQ1ZThZVFpleTZaaCtXTEF3?=
 =?utf-8?B?dWx1Mmo5dXBLYkRvMlY1bzh1NE1DcDdBNUU0K1lmTFYyRFMwajZvbkUvQTV4?=
 =?utf-8?Q?shQvNpPaBUjVG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTF1THk1aGRPaDBxdDRNb3ZoWmJzOXdOWDFSb3h5MHMwYlB3ZHZGM2JwUk03?=
 =?utf-8?B?NHJyaW1HOVBVRit3bW15MHRIbjNMMU1iRkFmNkdIVU55VjlsN3pKOTZsenNz?=
 =?utf-8?B?cHZTZ0Y1R0hJTlJwWlBBbE16VkdoZTR0Z2hZV29NV1hROVZad01IdWN5MGFp?=
 =?utf-8?B?YTk1dEMvM210cVlWbE5MMzk1S2hTcDVRd3BHRVhLM1g0V0xJbTR1dDUwYzF5?=
 =?utf-8?B?N3BnK1R5bUdlcDBITGVyR09kU0hpUHZqUEpHM21xWkdLWEZZelZMeXdPOXJW?=
 =?utf-8?B?dEJmYnpOa2J1ekdMSEJqd3l2QWRoYlBZbVR2NVFqeTBIeVUwZDFVTi9US0o3?=
 =?utf-8?B?NUhyeERGR3BBRENIajNDbmhva1lHaGExZU1qQVZ2eFpuT1lkQXV3dGV5aHR6?=
 =?utf-8?B?TDBsYUlnMTNsYSs1MWRGWGhJKzcxRWt6SFYrRHI2V1dubGQ0OHp5d1NNNitF?=
 =?utf-8?B?WjdUamM4TGVKOVNHV1JnOThqUWFZQnV3VkYzR2plRU1vdXZTTnI5VnNTODl3?=
 =?utf-8?B?aVgxM0Q0emVrSVhVK25URWVkOHg4eU5STnNBQ3FMb0t4UXc4eFhUdWI2cVJI?=
 =?utf-8?B?aVM5SmtjVlZ6VVRvalM3S0Zzci9JL2gvZW9tTmVtSVRNUnk0Ym5WbFo1amg3?=
 =?utf-8?B?OSt0bmEvRUxHS3JBdFJPZlpyNmYza0xoQmRYRVFHQUxTVEt6R1ZGRlUwcEtU?=
 =?utf-8?B?UjFpSGFyeFFsazIvUGhDYTF3NVp6ZFFUa1dIRkV5MU5jcm1HNVJCR0RTWjlP?=
 =?utf-8?B?NHh1Y2xERCt0MVJvRm5sTWV3d0g1Tyt0VzRObDltaHI1TkUyM3R6QVBvKy9h?=
 =?utf-8?B?NThVeXF2bU16NnppRGFnTlJaSjJlVTVzQmVMSjFhNXVIZythSkV2QytOZTdC?=
 =?utf-8?B?eTNTaEl2YVphYU5wUmdFYU1Xd2dCSGNLblhZOVowc0MvQlRwaVVPbU52VnN1?=
 =?utf-8?B?OXJocWlEZGhhU2RsanVGc2U4ZXU5My93V015RURKTTVQczZ0L0pEdHFWMEJy?=
 =?utf-8?B?VVNnMmsrWjdQYjFCckZCVUlDaEJtQitGTVRmVENEbEt4THBRTXZtVTE1Y0VM?=
 =?utf-8?B?bnpORnVkbktKdk1qQlJUd1BwVXJYcjNjQ0FVTFVWYWl3d3BTWWUxK3JXRDNQ?=
 =?utf-8?B?VGxjMVlXSkFpMk1MelFmVW4ySnhMMy9zNHhTUmpnbU1JdGluZ0l3MnBxUldM?=
 =?utf-8?B?V2c5bitQbmt1TDFVQmxBaVlEa2hRKzVEWkd5SUMwMlhLbm14RFJ3ZEUxVk9M?=
 =?utf-8?B?UlJ3UmhTR2VDMUNUV085eGpOQ3M5NC9HS2Jtazg5bHJCMkV0UDhwYUNCM2kr?=
 =?utf-8?B?RWl0NHdYZHlLMytoZTlaem0wc3lYRkZoVmdtTm15bms1Z3dvNDVRS25FMmhE?=
 =?utf-8?B?RkE1T2lTZzJTYy93SnovSHhESGxZNVlvWVIwWXFSZlRrRGNDWXF6MmVXaUJT?=
 =?utf-8?B?ci9jdW5taVhsbWh3Q1BoK3ZNWWhacWtJQ2w5M3d0Uk1lMTRsSFJWUXlqQi9o?=
 =?utf-8?B?L3hNK09vRStCNHNRYUFSYU9vK2JMZTZINXV1ZXE4QVgyS3lXcERndTB2NTVU?=
 =?utf-8?B?VTBFczh2WmpuY2RuNTBNVll1K3ZjSW1odERIbzNMTHdwcURmY1c1KzRySUdZ?=
 =?utf-8?B?QW4rQWlXSjh3WXNsTEEzdjh5NS84dUhHeHY2RVBPODUyTnp0dlBMNTdQaVZi?=
 =?utf-8?B?YWFrT2ljYUtrTUZ5U0t4aUltZHNkTVVzbFh5b3ltRnhkQWVBSGwzcWFER0tQ?=
 =?utf-8?B?UEhqaFFCRXpCNE1UdzY2WnNTTGRIaGpOM3pndzMxUWpHWHB4a0pMZ1lUYXpm?=
 =?utf-8?B?WmNRamJKOVAzS3NRVVFFcVNwMTZ2VGthNTlWQWJEMks5ZFNhYXFaTmRaSEty?=
 =?utf-8?B?cjFCV1ZqTWI1ektkcGcxNzlWekJLRnpYUmFSQ0xUVFk1am9HYk9sQXBmYjJR?=
 =?utf-8?B?RUlhVzI0QldPUTU1QWN2NnhDOUI5cE9ZRThkbGhkamcyZ2JkVjE5K1VNaVhh?=
 =?utf-8?B?ckFwV2tZQVh6cmpHSmFDUlc5dXZsU1E0NXJUMC90K2xVTjd1Z2JVMTUvbVBP?=
 =?utf-8?B?bE9MdGV5eUhaY2lrMGhEM21sc2tDUlNLL1duYVhCZ1BzVjNUajNTV0ZhZlc1?=
 =?utf-8?Q?njXL06VmLpc+P/HbdnDueyd0B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f8dc5e-e178-46df-aa61-08dd57df4931
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:04:27.7111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO37Atj6uybFRpFLX81oktslgWCjZlFyYaYyIOfcbQTFIWOeESMvbUlqg/zOYsI/jtU/fzUEbOWxBps5JEm2rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
Received-SPF: permerror client-ip=2a01:111:f403:2407::62e;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi,


On 2/26/2025 8:52 PM, Michael Tokarev wrote:
> 26.02.2025 15:53, Vasant Hegde wrote:
>> Hi Michael,
> 
> Hi!
> 
>> On 2/25/2025 2:17 PM, Michael Tokarev wrote:
> ...>> Is this qemu-stable material (current series: 7.2, 8.2, 9.2)?
>>
>> Linux kernel doesn't use these changes. So its fine. But I believe we care for
>> other OS as well? if yes then better to backport.
> 
> Yes, we definitely care about other OSes.  There are numerous possible
> other questions though.  For example, how relevant these changes are
> for older 7.2.x series, where AMD IOMMU is in less current state (missing
> all further development) so might not be as relevant anymore.
> 
>>> 3684717b74 "amd_iommu: Use correct bitmask to set capability BAR" does
>>> not apply to 7.2, since v8.0.0-10-g6291a28645 "hw/i386/amd_iommu: Explicit
>>> use of AMDVI_BASE_ADDR in amdvi_init" in not in 7.2, but the change can be
>>> adjusted for 7.2 easily, or 6291a28645 can be picked up too.
>>
>> How is this works? You will pick it up -OR- you want us to backport and send it
>> to stable mailing list?
> 
> This is just a data point, nothing more.  Indicating that for 7.2, it needs some
> more work.  I picked it up for 7.2 already: https://gitlab.com/mjt0k/qemu/-/
> tree/staging-7.2

Thanks. Looks good.

> But this is more mechanical way, maybe you, who know this area much better than
> me, prefer other way, like picking up already mentioned commit 6291a28645.
> Or maybe it isn't worth the effort for 7.2 anyway, provided the issue isn't
> that important and it needs any additional work to back-port.
> 
> If you especially care about some older stable releases and think one or
> another change really needs to be there *and* needs some backporting work,
> you might do a backport yourself or give some notes for me to do that.
> 
> It's always a trade-off between "importance" of the change, age of the
> stable series, the amount of work needed for backporting, and possibility
> of breakage.  For less-important or less-used stuff, even thinking about
> this tradeoff is already too much work ;)

:-)

Thanks for detailed explanation. Next time, if its not applying cleanly we can
backport it and give it to you.

-Vasant


