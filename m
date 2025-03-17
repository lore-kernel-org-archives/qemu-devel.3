Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8151AC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9hq-0002WY-Ai; Mon, 17 Mar 2025 08:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9hd-0002Vz-CQ
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:36:22 -0400
Received: from mail-dm3nam02on20617.outbound.protection.outlook.com
 ([2a01:111:f403:2405::617]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9ha-0005wp-UA
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:36:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUK2Ba71pNkwPfilTxhQT/Ie3Ks0VfU/uj8xehRO8su9Y9ebV09emf9JvZ1cIIOp0BjeiACKiBFa81vrhADHxZBlz4yU85yDE93GW5VKY5hVbGmMEKMPixYUz3qKxIwTmlQcOqQaNdICkBALluf9Syc/iKdfSsUm1t6AW9MmF1nwDLpb1HnfutoYChQ/5K9rq91Yhc8CYqUB8gbkIc5FuMkWzHiYcXF/G+zNfeBaiflyqJCsrB3nJj4I8C+vFu9oxePbAiPDWRc0W2m5cWiPFSozwvkjh/NvA+0cDeYJew6ib4OJ65RDXcMQ+FrNb5umNfMN+wBQTh18ybbGB9nQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En7nwZ0XX14I5FFgI2WZbSc5s0ciM5f+K/XbUwubk7E=;
 b=Tc9MbSnVvGFiAsEmPON1Kwf7ehAkPfTPqlDWc+mZKn8mKVAbCOgiPgaLQMReOkp/gRSW5HoT1vtCm3JZ18+YvGArW0bwQj54sDz1l3zAWdPQ1WhDZSvpAqZJ3G1bEUiRCcxeC/h/KGbE/hQ4JRFrh7+ykVv//zs8Qz8xzjpn0p65+A3APkTDXoWhjA+oVmAIM98+ZOEWdP73uGOKnl9Avkw6UiM7grzOpoCjUEfE60G/YsWw7IzAJ826ysa2bzXWDB+5KvyiOdiYZiN8ApWpqnSwlMhehbPJzmMmAeIlIupqHAyUcJKeMUBYae92eEBg4/K0oHKdIZVGLaT8/7WiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En7nwZ0XX14I5FFgI2WZbSc5s0ciM5f+K/XbUwubk7E=;
 b=zhLYnDlifqgQwKPF5SA8ha0tu24KgA/nMTIRAgHoJKGWXiscckyTHqHWlRLXnpTYDwH+7WywOrBGcgxp2MLGAo+3s1rNvTd/52xCre4zLPwnTOMK6IEO9IZ0qQ1kX6Xe2E8kjmt/g7Gf4ge5uM++YGM9UlzEaxTZGiHptCH2vNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:36:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:36:11 +0000
Message-ID: <ff224392-47f3-4afa-b854-fd80dd22cf47@amd.com>
Date: Mon, 17 Mar 2025 18:06:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] amd_iommu: Update bitmasks representing DTE reserved
 fields
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Arun Kodilkar, Sairaj" <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-4-alejandro.j.jimenez@oracle.com>
 <0be5765e-2ade-4743-a089-0846f60943dd@amd.com>
 <0e4993c5-33d8-4dfc-8089-0efa50881f8e@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <0e4993c5-33d8-4dfc-8089-0efa50881f8e@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: ace11393-f686-43cc-f286-08dd65504c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2ludEJtaWdYbHhRYkFQa1hPTDlLRkRRVkEwSEJpcTB4SkxnenpsRk1QVmpK?=
 =?utf-8?B?YUF5VjFTdkhwa2V2Rk51RjN1VndFS0VwMm8vNzFMRGUrY090Vzl4OGVxZ3Ns?=
 =?utf-8?B?a2YwWkVNRnpDbG9UbER6ZmlUYXJidzhxTlZZVGJvd3JkSXVHUWtocnFrWkR6?=
 =?utf-8?B?WXVvdVNJWk1ZM0JoQmYvSnZNaTBvcDZmdnNVamxjZWRKTUFuYjd2Z0UvZlJq?=
 =?utf-8?B?dnI2bEdyamZSaTRvUlVxbkI2WHE1T2o5Y2Q5VHpaY1ozUlNmYkNVYjVuRm1Z?=
 =?utf-8?B?QitxalBDUW1FamxoT3pqaFBkSTY3SUt1dmNnZm5tZmcreWczTjZTeUNiR00r?=
 =?utf-8?B?M2Y0eVQveitsTDBTSDI1S1NKK3J4YlZYdU5zbGFnR3NWQTIzVkJ6d1dXeHd0?=
 =?utf-8?B?NTEzT040ZTBuenI4V1J3ZUYvaCtzN1NNY2ZPdWhGOW1RZTVYcysyY1BITFlo?=
 =?utf-8?B?Nkd2VjhJK0k0RUplZGZERE5IMlpyVU9YNDhTQkhTVCsraGF5VVV5VlZhSlBa?=
 =?utf-8?B?aks4NjFWRWwwcnVtUjRiVnJGdzBHbGtwSy96cmU0dWJVVk5GalV5eWV3ZU9Y?=
 =?utf-8?B?a1NTaml3c1IvTktJbmRjUVk1MWJFemJlc0NyQXpVR3Z5YmNWMytJQWxSWEt0?=
 =?utf-8?B?bGpFS1FUTEgxMU84SklFRkhTaUJuZmo2Znp5OTMzeTR2Nkw3eVREalBuL0cz?=
 =?utf-8?B?d01FTzhjbndHSTRUd05PUDZTeUxWMC9GdUg3OGxkS2J0VE83TWxQbktySVoz?=
 =?utf-8?B?K0FLbEtBT2pDcmpWT24rYlYvL2NhSkh1QVozWjVncWR0OGQ2eDJDUlNWTG1z?=
 =?utf-8?B?YjVDQTZ4amJ6YzR4WWJtdmhCekY1cklrQVkwZm1YZTk4QW9FQXBQWHNyQVYv?=
 =?utf-8?B?Z3E0Q0h0YVlrQXI1bGdMb1laZGRWZU5zOTFiNUl1M3hVazQrZExtZUt0Y0hU?=
 =?utf-8?B?amF1RmRSYVNnUkw4TnRQNTRxc1JkblNGRVl1a0ZaKzBnWU1CMklGc1k2Z01t?=
 =?utf-8?B?TFQ1QzZacEZTYm5talpwUTEzZW5FUDVuYVlMUm9kaHQ0eHZuY2R0Qk50VVkw?=
 =?utf-8?B?bDdLUTNEVytVYlVjUW84L3BIMzI4aDdCcjQzcGIwZWVsZDNCNTgyMnBRbkJk?=
 =?utf-8?B?akt2bGVUaGNabFVOU3dYVktRbFpKbkNDUkdhTEJhaHhTL0Rtb3JtZndjMjhZ?=
 =?utf-8?B?ZlFSbDVNQXZBU2dETThMVTAwOHRMMWw1REYveVV4TlIrN1dlN0Z2b2s1STYx?=
 =?utf-8?B?QkVtaGw3NFZIOTJvK2JONGpZQ3BYU3R2OVRiY0xYeUM2YXJWbk9PRElnUzc2?=
 =?utf-8?B?MFVZOERBcGFsY01tbmIrcjEycTBISzE5b3lLSzhPQXFWMzZ0V09zblpXalhj?=
 =?utf-8?B?YzkvbENCTTRjRitwTEsxTE5XUnZpVnBOV2h5dG9sTXZ4bUFycXVsWHQrNTcz?=
 =?utf-8?B?RThTejVlS2VNMVo1REhiYk1wTkdyeG8zcVpFaHpRWmR0Sm9mUXNNU0xMalY4?=
 =?utf-8?B?NTFsVm00SEFxaEltT280NklZT1MxaFVoOGluVEc4eEx0MVc3MkRTV0xvNWlq?=
 =?utf-8?B?VFhGQVRCSUtGRTZXVnBPZ3U5dXY0ZWpnak80emdqRFlGQ2V3d3c4ZGsrVTRP?=
 =?utf-8?B?ZmN4U3lrbFVVZHJrNlR3L0U1cFl2VUtTaWFBS2t0TlcvQVJSUHNFaExRdGRN?=
 =?utf-8?B?bzE5S2xRN3ZRYndTUHgxbGNjRnU0VzRZVDQzeWxuNnFCMUtVaUdsL1VEVHYy?=
 =?utf-8?B?V0c4Vk9WdGRlMnJnQ0liTHQ5ZVlWWTJGK1FpdlBSdENlQ1ErQzhxY1d6S3Z0?=
 =?utf-8?B?cXF5SEhIOFQ3MndScTFOOTg5MVZtaGJBZFJuTFJudy9iOFpDUUpXVE0rUi9Y?=
 =?utf-8?Q?2tDNRjvqi2OA/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FvNjNCSUNsU2l1UXRXUFliUFZ6ak5IQWtXN2UzUmZab0cwSldJcjREZFBS?=
 =?utf-8?B?cmdyZkx5NHlkVmI0RVhZRUlveU8zekFxV3lPRnVpMUw3UTAxdjBJKzBVN3F3?=
 =?utf-8?B?QStpdlI1aUVuc3RVSXhlTTl1N0p6ZUU5K3ExR01DOTVWSS9Nbnh1dGg4KzhW?=
 =?utf-8?B?UmQvUEsxT2tyWGN0b0NQVXVnQTdRTmdJdCtGRThBVG5xS1dDRlRxNUxXY3do?=
 =?utf-8?B?R1ZZd3BlVlc3RzQvQnAvTldNQ2VSbEdwQW1zNGNteDJicUtUcW5DR29GL2FG?=
 =?utf-8?B?aFRGUnVaUkNqM1JQNW1SY1gvVlFJa1hQeDN6N3NJSE8ybXBnaGNSMlJLdUtE?=
 =?utf-8?B?WkFldHB0UDNTRzM0WTMwNVFKUmc2R25pcXVXR05GSy9qODBMK2xLKzM5K0pw?=
 =?utf-8?B?R2FPZ05zcEJPYXRtQ2Q5UEFUbnFuL3hLTlJCMUFYYzIrNDFVWVZTVklOTlVz?=
 =?utf-8?B?ZWZ4RnZua216bmpQbWQzOElXNk1uRzYxczRYOWxoWTUvcERrUnRQQnBrRVA1?=
 =?utf-8?B?RDdZRmdsWTc0OG1WZis4ZXdQakFTalFGSWd1SVRKcjVISE1OcVdaem1wVG5V?=
 =?utf-8?B?YlZzWTJDcHZXMG12N2lveUpscDA3V1k5OG4xTWR3TTVTQmVaTk43cCtyRmdh?=
 =?utf-8?B?a2V3VVNadGhyekpYR2xibTZDL0QzdlNueXlOUVovMFhZVEJSUTdPQTBOUUxz?=
 =?utf-8?B?SnNyQzNWMEMwa29uUjc3OUZKL3ZzMkt4ZmpPZFRBbWIrZ1kwRk9FWGo0a21L?=
 =?utf-8?B?MW9yNjAwbW5TVmdCd055VFYwbS9Fd21OQlFzeWR4ZzJEQ3A2R3hjUUMrcG1U?=
 =?utf-8?B?K2R6UTVLZHZEbXpJdHlzUU5Pb2ZkaGtSQUhSdEkzUUhCbDl2ZkRFZ0pka3RQ?=
 =?utf-8?B?amR5VUdjenRITWpvZlZWanZuUHkrYkpXWG5xQkY1d2wzTndtMW8wMVJNTHox?=
 =?utf-8?B?K3dLOEFQS0ZRazgrSVJOR0Q0RVpJMThGdGFrK25pYkdJR2MrRGd3WGFmVGs0?=
 =?utf-8?B?ejBLL2d5enpnRk9SWjljdjViRW1MOVQ2WHFDb1loeUpCcVE0dUNuQWxHWG80?=
 =?utf-8?B?SU4zV3FhUTErODdQUHVYS3hDQ1JxdFlyVklOTjVJN3QyUHVtb0VLTzZrc3Js?=
 =?utf-8?B?QXQ1ZG9RVDJ0eGtNamQxVHFRQWhjS3BNeUR1LzhhV2t3VHM3Ykc3VW1uaFpG?=
 =?utf-8?B?OGQ2bFh0MkFaUkFpSEcrZUdaZ01tc1dRQm15aVlFaWwvZVdYdGlxL241R3ZW?=
 =?utf-8?B?aXpHOHE2TCtPbjhHT1J5VXA0RkY1NW5EM2pncHJrUklsTFJMb2d4RGhSOHd1?=
 =?utf-8?B?YWxjRHA3R215NkxxZ1J6K0Iwc3VQcW9jVTZMaFo2dkhBY2FMa2orUUhLLzBK?=
 =?utf-8?B?a3BvY1JoNUlYRjAzMGM1d2ZsYmswM3E1NEprbmluaEp1dC8wOU5GMnVKN3l6?=
 =?utf-8?B?WGx3dXhWZHZzQ2xvaXlwdllxMGQ0dWhGSXNVNGdOaWhBbWdoR1N4cnd4dkhM?=
 =?utf-8?B?M0paOXFiYldJYzhnd1NqRWdhUTh2YjE4NFhiN3ZtWjJNUHNoRXkzUVVyV3pz?=
 =?utf-8?B?YTFTVWQ3M0QwR3B3NTJ2ZGdsekFuMldXa00rdVpZS0FJbnl4dEE2ODIreDAw?=
 =?utf-8?B?Z2NnYTRVZ0FOOE83V1BPcTN5SjZaYUtoVHhMUmNMbXcwWWxBVzRSbjVHNldE?=
 =?utf-8?B?UThVZGVGZW1hNElid0NHNkZoR0NheEwxTC9JUFZFU2ZNemNuWVVsUkpjNHZr?=
 =?utf-8?B?YVl4S0VUaVhHckkrbjVWZ3Y1TW1ZUFR4YkVXZi9jNlhqSm5TbnY2bG5Ba0pM?=
 =?utf-8?B?bHNDdjRKeDZDWHBZVmFGZmNJb090SzhpaGUwVDFHbVZGWW5qWDl6OFBaZnhI?=
 =?utf-8?B?UU1jcUY1dFJuZGFDZXNYOW9TWHB0RjJCbFNTM3N5aGthdzFYZnQzLzQ1Ykwr?=
 =?utf-8?B?Z0NNTWRzdGFqaXZ4U0NlcllzWVVBOGRZK3BCd3hOTHBqZVkrR081M3piN3FN?=
 =?utf-8?B?Q2txM2F1d3F0NVJWSDQzTzRDZUNTYnVIYkFMMjJQdjVXem9uazRTc3ZHdExO?=
 =?utf-8?B?Z2didWRGNkdZMlVvL04xdzZPZmgrNHl6bnltSzNxa3lHempPWEJVSVNVNWUv?=
 =?utf-8?Q?aNuodQ5YC1oit5cjnB6URoOrX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace11393-f686-43cc-f286-08dd65504c8e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:36:11.6040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwBoYPLMDTFva8KAYlNfXGUATyxfpUJOLsO9DHHJcfOr75i1m0w55nCGslPfGZEAdsbKWQpeeC3D/LaEMHBjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
Received-SPF: permerror client-ip=2a01:111:f403:2405::617;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

Hi ,


On 3/13/2025 7:53 PM, Alejandro Jimenez wrote:
> 
> 
> On 3/12/25 12:12 AM, Arun Kodilkar, Sairaj wrote:
>> Hi Alejandro,
>>
>> On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> 
> [...]
> 
>>> --- a/hw/i386/amd_iommu.h
>>> +++ b/hw/i386/amd_iommu.h
>>> @@ -25,6 +25,8 @@
>>>   #include "hw/i386/x86-iommu.h"
>>>   #include "qom/object.h"
>>> +#define GENMASK64(h, l)  (((~0ULL) >> (63 - (h) + (l))) << (l))
>>> +
>>
>> qemu provides the similar macro 'MAKE_64BIT_MASK' in file
>> 'include/qemu/bitops.h', you can use this existing macro
>> instead of redefining.
> 
> Hi Sairaj,
> 
> I became aware of MAKE_64BIT_MASK() because you used it in your recent patch,
> but as you mentioned they are similar but not the same. I personally find that
> using bit indexes is less prone to errors since that is the same format the spec
> uses to define the fields.
> So translating a RSVD[6:2] field from the spec becomes:
> 
> GENMASK64(6, 2);
> vs
> MAKE_64BIT_MASK(6, 5);
> 
> The latter is more prone to off-by-one errors in my opinion, specially when you
> are defining lots of masks. Perhaps more importantly, I'd like to progressively
> convert the amd_iommu definitions to use GENMASK() and the code that retrieves
> bit fields to use FIELD_GET().
> 
> I am planning on later porting the generic GENMASK* definitions (from the kernel
> into "qemu/bitops.h", since the RISC-V IOMMU is also a consumer of GENMASK, but
> I am trying to keep the focus on the AMD vIOMMU for this series.

I like GENMASK. Its easy to read.

RISCV has GENMASK_ULL. As you said, we can consider consolidating them later.

-Vasant



