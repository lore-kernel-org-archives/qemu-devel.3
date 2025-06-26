Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF63DC7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 17:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUqmw-0006iW-4h; Thu, 26 Jun 2025 13:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUqms-0006hh-PF
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:53:26 -0400
Received: from mail-dm6nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUqmq-00044E-Cj
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 13:53:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzlzBNgSSXrOxF0jU/8JLD2V7Y9zaC8yJOATB7V4/BWe0QKuDWmXiWqlZeWj5YjB5ocEMAjy8GQDoGj2zSFR5+G+HwNhhM4/7qp4RcjayD74r6FxdLUxelI+XCxitULuuPcpAmGHswbLvxAFxKUx6Ops1q8wnM8MWC8IlHwDgYwxeM6HaS1vt3meuGtqL4cY7VC7nU+9yCxxzhMDRoKWTxoVfomlTkUtYG4ylMKoUU3GoCw/Xa6DxDMCGpyuBXD4v3+rO2fsjshROnskBRLZ++uHhZzm4jTZl1KPV0lsKu5Bbe0YNEg2YON27JZB+tLJI0gzgnzi3/HV/qCLCZ2kzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25vttU1EvvElR5nr89gLgX36/JLsKAg8wPjQjCVxgSA=;
 b=PyqvxblC74HxslFwu/IYQLUvB+z9tjXmeApzITYXmXGgy+hrA50iVbGGAHucnpJiKH4HjVVUUjXCsg8bHlIMfFzLYDzNhCPSpO4TmICrsTMZU3EuDhpiku/apHAYWVlHHoBivXIwooDar3PowS2qxmafl9Wv5SSyovEA3ZrTjOBipA0opdrE+jqnDKHjiqgcoNQq95r7Naa5YrHMYRmJB6iJcSrM3Uh2EYLsnB/+BkeK4ZL7nrXHVVY9JcsKdhIDP0Yw+D9N0AELYiS2012AMSba6Au8HFYEtSE4hrNCtXJ5nkhkEnts/JTv3IxjeNsSJ8hNNeoBV7ySMCk/UgFhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25vttU1EvvElR5nr89gLgX36/JLsKAg8wPjQjCVxgSA=;
 b=ZsaHJ/6wuqesAs8xoNDWHd1vhMvWmYr24ApEvqyOqnsxn/7JjL4s6+LxKJNWut3u/iiSMmb+B8vosXZagdWCQu9jchh3QdMJIgSiqLcOiHtg3LPfvqbghzTrm9Tew9xmUzsqJ/W8100hLHHt961nC6Wpq4hi/cTyjN/UzlJ0rgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Thu, 26 Jun 2025 17:53:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 17:53:18 +0000
Message-ID: <efd65188-5bd9-463e-af7d-6ec2fa6e1a9c@amd.com>
Date: Thu, 26 Jun 2025 23:23:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] amd_iommu: Fix Miscellaneous Information Register
 0 encoding
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, philmd@linaro.org
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
 <20250617150427.20585-2-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250617150427.20585-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: b036ce6b-1336-41f2-0337-08ddb4da551d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkFKT3o3eEV5UUJwZngvdVFhQ0ppV2Y5KzZDSnZrUUtWS3RZOVZ2NUdYbGZZ?=
 =?utf-8?B?QU0zMHFHUGNhOU5Id1lZdm56dWp5WjZWYUdFR20zZlhmYUkrZXFoVE1xa21k?=
 =?utf-8?B?cDlzTisvYnI2TEJXVEhrbHZSQmpZaFVSRXdYOXVIQ0tOWDBQMkw5ZDFFUCtD?=
 =?utf-8?B?MVkreGkzVlBpajREamhnaTlJT2FGY0pHaU9XVU9UaHZqMCtrVXVsTkU0VHE3?=
 =?utf-8?B?OUtwZ3JWTEt2ZTFsb2NmdmFnWi9IUkJaZEc2Mmo2M2c1cjdmVnJCcGVxckZz?=
 =?utf-8?B?WWNrOXdpcEh4OHFJYk9vaXN1d3hFUjB5SDRCZnR4YVpac04vUWs4QW8yd2x2?=
 =?utf-8?B?T2J1TzVEUlUxNVpSTEsxdXlBKzhsYXRKTmhtMllIb2xPeVp5ZnUzbkdPUW9i?=
 =?utf-8?B?UWhWeHRDdjFqd09NTmc5VWNRV1dYNUtsMlBKdHFtellyc3NYaEpEL3FjNTFE?=
 =?utf-8?B?cXY0WmdQOWpVeWR1Um1EMDRqZksxSkM2L0ozYk1XWFNFZDhoaEw1Wk41MXRG?=
 =?utf-8?B?cXZPaWRaT0NCSkpWM2FuaDI0UVZtUGZEM1lFQXd0TG1aMWZLSmVicVZSTGFo?=
 =?utf-8?B?QW5KajEyUzhpSytEaFV1K1dYcUM4Mk9ST2FpcUpNcm0wRTdzNXVvNjU2UU5V?=
 =?utf-8?B?ZjNUUXo5REI5SFhLRGpVSTJIa0V1a2Z1Z3RGa1lhVkNWakxRTEhXRE51WFU2?=
 =?utf-8?B?YlFheHN1eS8wckNMdmhiVW5aelN2S3VjSzFLS0luaXRHeHlGUlRzSE03Y3p1?=
 =?utf-8?B?QWxrdEJrQmp5Q3RmSHJ0Qjd2Tzl1Z2prUzZHenZKVm44dE1tSEdIbEluNTJ4?=
 =?utf-8?B?Y01nQ1ZNYkZVTFlIQWtRYVJuNjZYWlI2MEpvQS9FZE1hZWNEUWVHZkoxWnFF?=
 =?utf-8?B?NFJRUGVWSUc3NGFTVTgwRnBkbmo2NWV2NXNGbmZZNldveEQwT3lhYU90cWMr?=
 =?utf-8?B?YVFWdWVpQ04wWEMrcjZTQ3dPN3JJc3Y4YkZMaDh2cDdOZXcxZDhySHNvN0Jk?=
 =?utf-8?B?WXl2dzIzU2N4aGN5S0VEZE5OOFZGQzU0VUhhK1NXL3c4bnZoUE1qbWJwTUZZ?=
 =?utf-8?B?R0tIV0w3TVA3WXNCaVlkbVVLa1Bqbjh6eDd1QW03eXo3SjdGcGhhSHlrbmli?=
 =?utf-8?B?NFV6cHJjK291akpmQlJodEpwdmE1N3cydXN1QWM0aFlFb0xYVm0xanJxQkw5?=
 =?utf-8?B?YkNkcEtORWNiOFhzVmlRVDVIOWhnNGdXYk13ZnVyaVRESUZwa2dycFJjUEZO?=
 =?utf-8?B?NTJNTUxScUUybzMva080ZjFaL0lCaVlkTHlmMTNsalBOenhsbTRLa3lFN25z?=
 =?utf-8?B?bm1FaE1XdmR6WWRtNUpDa29oSWVydzU3dUcxQ2dIeUdtcGxLcFVsYmxONHpl?=
 =?utf-8?B?L2dWNTF1amYrZG5TZHR0WDZDUmxLdlkrM29MYmFXeDdkd1o5ckhNZ2NjSkNK?=
 =?utf-8?B?TExPYmZEUlRmNWlvTlEwcExpc1ZOUFdhbmR0QWJadzEzVFI3em1CK2pGUFZv?=
 =?utf-8?B?c2YwZDRZTDZSdllpL1JleDkwaXRCOC9TTWVaVlBWN2I1S3pzTlUveXVsZUIz?=
 =?utf-8?B?Q1h2aGtJdzBKR2l6cnlqcXQzeEhFWVcvUTNKdXJCeUdYQU5CNjVQbnFKOVQy?=
 =?utf-8?B?M0pRbXdkRVV4b2VlVjNTNm5TRll1ZWZtZGJaRXZsNEFlU2M5cFB5aW9pOHZi?=
 =?utf-8?B?MkhpWWxJT0tMbFEzQnN1anBReWlPZ0JLTEZ2TXpOcHdIMVNIdXh1WGVJWUtE?=
 =?utf-8?B?VVoyZkpUVVcyclFJV2pNVTdiQjdhMlM1d1Z2L0UyMUd4N1VzRUxvL3l5V043?=
 =?utf-8?B?OXZMcEhFaUUzUTQrdHdVaThYK2lETDcraDA4MEFWL0l4MldtYkNlSHdaWjVG?=
 =?utf-8?B?NDI2ZC85ZkRwSUZOdjdLWEhHY1Y4dytiOFFHK2hTS09yb3F0Tm5XVmR3Wksz?=
 =?utf-8?Q?s+wBChgaB70=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVBCaHhOMUF3eG1hUGwwSkIvMVR3ZGZKcUpoVmc4NncwVnhuYVVjU3pJM2Yx?=
 =?utf-8?B?eDh0YjN3RlNlQzlPM0NGbTFzd0NYVFpDZnF1dEo3SElVdHBoczhKdGYzS3cw?=
 =?utf-8?B?WkpWakI5c0luV3AwWEZ5UnpueW96MDM0bjR2SDc0VnJoVXNwTU1UZXJzN1d5?=
 =?utf-8?B?RW9mVjJmbW51dEFGYUVwbExSZld0cTdzalJ2RDRjeTU4NEFYNWE2TWsvdVFj?=
 =?utf-8?B?eGFuakh5VTBBSWZJb0xUejRmZVR6RXIyM3k2dU5BK3lXcHJzWnorV2M0Vk1n?=
 =?utf-8?B?eGM2Qk8xZmJ4MCtTenZ6Q0dxU3psTGpSMS9PeTc3VE00QzZKZDI5N2tESmpS?=
 =?utf-8?B?VmF2dWJseExLSktOcUc0WjE5djFrUWQvYzdCZTJZNkVBZW9aS3A3VkdSeXY4?=
 =?utf-8?B?YkdnWTRoby9UVGtYTVpzYXVEYU9zMWt4blRWZlhwTWJaNVpvWGpkcmdzdG1r?=
 =?utf-8?B?dVVqU1B3OWY1cURkYUg2VmJ3a2x1N016d0ZFbzFZdS82Mlk5em9FcVpHUnR5?=
 =?utf-8?B?ai9uYS91dVhXZTF3SFQyZmdteCtEZi93SkptYXd5V0doUEdERlR5VzA1MnBm?=
 =?utf-8?B?bGRsbWZXL0FhZUFHZnZEUXhhMjEzTHpCczQ3RjlIWWJpSmU1bUJ6YjBwQ2FX?=
 =?utf-8?B?ZUdzZUNhNEwxczhrdEszTkIrOVVHTU1MUHdTWk1XR0h4UEFneE5pSklZa3RI?=
 =?utf-8?B?SFhwK3lzNDg1SXhnK0JrKzRqOUU4UWNsQ2FoWVdIS3FPTmVDbWZjdWFnaFZD?=
 =?utf-8?B?cVJZZEk1SmdQbHBGTGswS3FsNHdsNURTbFlXQ2tXR0dMS0U2UC9tYUp4OXpa?=
 =?utf-8?B?YjNEZmIzTDUwNWZJYnNIc29ZMUZYMmNsRVVZT1U0VWJKU3VJUE9tOFhLcDVH?=
 =?utf-8?B?elVJNGM3SFpVZHhmK3U5aWE2SGF6VjkvTG40dXJvckdyWUYrQmx2NktWL1JC?=
 =?utf-8?B?ejNIcE9jMnNkc25lUThyRnk3QWxlTmhyMHloaTBvTzM0ZTc1MVp5M0V0VlFW?=
 =?utf-8?B?cjRhNlN6OW5tU2pLWmlWUHJXK3k4L29yS3RwVjZFSStrdktScjFyeUFBamFW?=
 =?utf-8?B?UmRUT1A3TTVlT3RhZzFiMEZsZHRYVTk3SEtQRGVWSm9pZ0pOZ1pSTk5kTVQ3?=
 =?utf-8?B?N3JKb3lBSVlZcGxmSzlvRGYwd0ZDZTRPWGhXa3dMUjAwdnd0R3Z0aDJwcjFM?=
 =?utf-8?B?SUVFSkcwSnNneTVPakFSRWtjRlkvYjh3emRrL0FGZ3RReVVXN2lkRHFHVzNV?=
 =?utf-8?B?ZnRuS1NkeGhrUHQrd0JDR0tkWENMcWY3ZW45VXhkNEwwMG1zSUphTHNmdlE0?=
 =?utf-8?B?S0g1T1NSSStEV2F5c0l5WlYwclZlWjNDTXVwNmJVSmV1aWdISmVkZkUwZjdh?=
 =?utf-8?B?ellVeWk5eDB4VmpFU3h1WlJGcFdrQjRyM0hPdFZ6T0toSGlGRDlNVUxJRkRm?=
 =?utf-8?B?bktESnZoUmcvT3FEdXc0UDBTK2xNdFQ5RFd2bFBqK2Z4QnZwR0lUWnBPN01N?=
 =?utf-8?B?dm45T1ZSMGFHMkZsY1NKY3NGbGJqL2dpSlNBWUIwNlBBa1RqZkZKRE01MEQ5?=
 =?utf-8?B?Rzl3Wk5mSVIxREdpK0VJSWhCbTNtdE11TWVMWXRIdHIwTlRTT1hvTDY5T0VE?=
 =?utf-8?B?azl5Rkd4S2phY05aTlhuSTJOeWF2SzNWSm5ac1pLV2F1SFp0OG85VDFGU2tU?=
 =?utf-8?B?dVJwOXBGQ2NKUEN0STFvQXJxN25GSkJtd3lZQ0MrT3F3Rmx1alRxaHc1VWpZ?=
 =?utf-8?B?TXVDKzFtL0pYZEdGTTdPYWMyY1dVZGN0R24zWjZxRGE5U3RDYnh5YW83b0Vh?=
 =?utf-8?B?UGp6UjAzc3AwNDlja3NxbU1PNkNKK0lzR2ZUcE1mdHNpK01YZ1BCMGNqWThx?=
 =?utf-8?B?VGk4TGd0Y1c1RnUvazF2bkNKd2ZYYmNDTnhHWFdjZUl3VWpPbE5XZzcrQzhz?=
 =?utf-8?B?VG9UZzNrRzRCTGNSbm9ZRkdoem54dWlwbGF4WldnMmZTNHp2Z2dCSGErbHZ5?=
 =?utf-8?B?ODBPcGJXTHJIL0NZV3VuNUphT3owTTVrVGE2S0dOc3N1dVloZ0M3TWFIZUVt?=
 =?utf-8?B?SjRsZkNvbW0wcjNZQ1NXWjlxVUZJd2RFK2Zaa0EyQkZIRFBVR0JTNjh3LzB1?=
 =?utf-8?Q?hvhzOy6Vary4TLGPzorotLpwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b036ce6b-1336-41f2-0337-08ddb4da551d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 17:53:18.3019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyDowR/KdJIH5XshmklFhSzBkPuU/pN9Ht2y0j87r1UZ9PbFYzozsw/nnoi+6CjqOMci0evNBzprHdJBOsZ5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
Received-SPF: permerror client-ip=2a01:111:f403:2415::62f;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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



On 6/17/2025 8:34 PM, Alejandro Jimenez wrote:
> The definitions encoding the maximum Virtual, Physical, and Guest Virtual
> Address sizes supported by the IOMMU are using incorrect offsets i.e. the
> VASize and GVASize offsets are switched. The value in the GVAsize field is
> also modified, since it was incorrectly encoded.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Co-developed-by: Ethan MILON <ethan.milon@eviden.com>
> Signed-off-by: Ethan MILON <ethan.milon@eviden.com>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


