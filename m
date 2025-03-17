Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3697C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9m4-0004Lk-IT; Mon, 17 Mar 2025 08:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9m3-0004Kq-2n
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:40:55 -0400
Received: from mail-dm6nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2413::60d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9lz-0006ig-CV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:40:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aim9wW8htFcDN4D+FhdaLlU8o8fQDSmZdMTYk0Yf/Kk5eRqghOa8hVja7KHNyhrj9cZKEOOpKCesEerOvCKnn7VHevy8GsQDv0DmJGdgq2m3HJElnbKUlyaOMpDDhXpgWt0oRkWVajofv4TEYsKDR3qLfEjepNJSZedzyTDy4IPVDPlaB2gBzmG8YBna7JwTEIGhSMf3zPYXJkbn67zixH2om6aVJwWKWDGPxMPpl6rJqDBPiDhKVQdccF6BCgcfVAt768U01i9oqqG9qNny+d0O451IyJR5TylrALmOLj1LcoSlqxTWp90UHDJY1SlgU7C2nE1kkL4XpYNihvNtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+pBKmGMdLGkWkpZC2F1d+R0JXW9Bj9iHvtld40s84I=;
 b=GLED35zeiuEibpTX2RlWKCmuWIdc4/IhmlIDK1OTfA3PDeDd4su7aBFWAPJIE5TGH82yvuMCjl62q3s4OB53hl8kOCq92VvakkD8UQNw1MIsm10rUm7EqpJl0imTlald9f6Gu4ORaRCwu4bG17um1yrBRiycZOp47rzOus/vaTJl6Tq3iV8jxY6S7aJSqpKJw9eNiK3+EimIbbL6cYoubYlG72TfOEmdcBTv7GTRD+6XsYgzc3g29HRw27P215j028vjzkrSVazws0Oovwa2Ij8sZRw95FOd+N6SK1Nlglrddg/DESpA8IqTGPdJ6mhC2QxUcHYFNy2RSEDeGUp/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+pBKmGMdLGkWkpZC2F1d+R0JXW9Bj9iHvtld40s84I=;
 b=vefKvPky0oyrXpbIjg1o/EmHvhHQZqgPWqaOQcpwGcKAgYWLHElSC+ea0yO6WbrrI2E3JbCaxrZt8yoAGquc9OChWlXw4tM1IoAQPHaGb/dirQjXYJbDqgpOd0sf4hlx++psyUSsCZZC8VV7N28Lpp1zlYfCxWqLITC8fPUu1fU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:40:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:40:45 +0000
Message-ID: <272bc708-484d-4904-84e3-4c44b535eda1@amd.com>
Date: Mon, 17 Mar 2025 18:10:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] amd_iommu: Fix Device ID decoding for
 INVALIDATE_IOTLB_PAGES command
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-3-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-3-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: e9587061-24a2-410f-23f6-08dd6550efa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bit3dHh4aHRyK2RZcGJRQVkrS01ZeVNoWWNqQzRSbzY2S05ockpJZlZSb3pD?=
 =?utf-8?B?V2pnQnZGYUk4eGt0a3lneEF3MERKR1AySnZhTWVOZThjamhuTU8vQ0ZvVFVy?=
 =?utf-8?B?S2YwbENwVmpHbE8wS3E1MTZKQy81dzQ3ZUxCaTV5UDBZRGpBZm9SQ1E0SGtP?=
 =?utf-8?B?RnEwNWtDb1B3WElITkttNUp3b0N6eFA5cWZKQTdxS1UvTlp6YngxVVIwTHI1?=
 =?utf-8?B?OFplbFNldmhhM3ZJVUdwNjdSZElzMEQyaTZkcFJnUEVVeVBXY3hDdy92WUQ2?=
 =?utf-8?B?a1Y2aEVHeEl5bElYYjlRejFNaWM3SnVyT2hkUXpHVXNwZTBmeGUzaWorS055?=
 =?utf-8?B?cTQwa0RsY2hpWE5uSEVyTlVldTBnVWN0dlBHNlplaDNSaXJKNVNTZ003UGRS?=
 =?utf-8?B?TG9FclFrMnpUN05rMGl0d3psWDZFMWhQOURGS2E2dnVpOGE0d01XWUxld013?=
 =?utf-8?B?Q0IxWE9ybEs4SnN0c2N0Qm5ZZjBZSVZ2NUFYUkJydkNna25qSFZDb1Z5eDlq?=
 =?utf-8?B?Wnd1U0xTdlViR2IvZTA2dXFxaG43Z0thUEhBSHVXTjNQYVlvWGMxMHVPVDhh?=
 =?utf-8?B?WXBGTGpGcTdRd2Joakp4QlV2Y095K29GSWZ0bUpoRG1haU4yY25KVGJqL2Vv?=
 =?utf-8?B?VEpXOTNMYmc2Q0VvZjVHclNwbkRLczAvNlNGQkc2WEI3V3NJVjRHNERIM3JQ?=
 =?utf-8?B?Vit6amorYmFHMElvbG5wL0plMnNZTDRJNUJzT2IwSjcyc1hUZk5TRitWU0JE?=
 =?utf-8?B?YnJ4d3hZd1lXcEtWTEg5ejNPb0ZhR3R5cjRJRktTbU1oWmZzZkRTK0dtZ1Mz?=
 =?utf-8?B?SHNYZy9id1k5eXZPb2NreXZ5VnN4cWdxZzBFSDM1ZktEdU1oYW5DWXhFdG1B?=
 =?utf-8?B?MHpaS1ZuYWVXbTFJUzQ2SU5mTnVtTmtQTnRVT2VsQXN2Sk9aUXNYdjFXeWxE?=
 =?utf-8?B?Vit5U3hGaU11UHdEbWFIcFBMdURqN2ozS1BVbW9SbHhEaGJvQ0JrMjZwaUtG?=
 =?utf-8?B?NGxCOStnbVVlWkdxZ0pXaEhlZWpNS1VVZEQ2amJ6aGFZUW1OaEg2UlhyRElh?=
 =?utf-8?B?N0xzREZjaG5zUjBobzVRWG90cWpGRW5CZ0pldWZiSG1Nd21oSEpoZEppN2xZ?=
 =?utf-8?B?OStHQlBxVHh3bkxpWk5MQVdNeW1PNldXb2JMR0liNmVNUThHZXVjNjZDUVEz?=
 =?utf-8?B?RDB3TnVLRVZvcGNKb1N2a0d6KzdKbDhaV1dUZFZwNE9PM2pYQS9tWVowWmdT?=
 =?utf-8?B?MUplb2w0MzdpMzgyc0U5U0todDJTZ3VZM2tqNzJoN3o3M00wNHVsdElJc0xY?=
 =?utf-8?B?TzFNREg5WU1NdXg5MWRvYk9JV2d3aGl3OVZkUjJ1V2VGR0ljYmM4YUh1S2Jk?=
 =?utf-8?B?L1FJQUt2dVE2Z3ZtUHRHK0RnNUJtYWRva293NDZRYWJrOG9tT0gzZ3F5RS94?=
 =?utf-8?B?bnZFSVZxQTZKWXAvMFZwb09pUkg5TmMrVU1QemUxaHZnRnlmbFpzVG9tdU5z?=
 =?utf-8?B?cWM0RFErL1JycWhhdFF6ZlJZYlRpek5Kc0VvbmpFWHcwUXdiVytRSU1rM3VB?=
 =?utf-8?B?K1EzQ1hHb1lXVVg3aHhxenVieDhLeDl3N2thOVJhRU43bktsZ3BXbmlVczVI?=
 =?utf-8?B?NXJvMHJ0dXJSYUFrUXcwYzRYdkg3VFZIWVRoYkEwcGF6MUIrTm56NGEzUmRN?=
 =?utf-8?B?VXk0QzRsL0RkemlCc0IraFJtV0NCTU55SktRQlU2M3hTTGRKcVgzNUkxYVdj?=
 =?utf-8?B?bUZZWloyUExTdmNjcGh1Y1orc0tDQm04ZGVRb1ptUjlUcmI1MW90bytkcW1L?=
 =?utf-8?B?R01CU3k4LzF6MlJ2Rm01Q3QzQkJsNmpHbFVaTGRqQUNUSTI5YXo0R1FFWTNU?=
 =?utf-8?Q?02gK9qMsAdBdq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTAvcjBmWDNCckdHc1o0KzRMdW8wbUl5U3pLMWVBRXlwZUZEMmtpeUNUTFMz?=
 =?utf-8?B?RElxenJBaUNLcWhPbmd5dk45M0Q2ODFBdGdWWXdKVHo1QWQ1V0ZhMzBNUWh5?=
 =?utf-8?B?ck1teThGdlZySVZ5UE5TRWY2MEoxNHBFSk1RTzhwRGUrQzF4MzVCMDVac0RB?=
 =?utf-8?B?ZU8wQVcvK3N1U2JtZjNSdlRXUStZMDhRNnpUOVcrbXNlMElRTDlSUHMvTGJs?=
 =?utf-8?B?WURQcmp0TWlGSUY3MFIwRU9yTnhIV3E4cy9qVVVGZlVQTzNraStZWTNSQldj?=
 =?utf-8?B?clpIU0NFbzh4NTI4UGMyWXBzQ0psNittdE5EOEFHTHo0RjR6bGRXSDRLWVph?=
 =?utf-8?B?MHowc1YvV3diL3U2dG4rbXVXeUJOZlhqTkxkSmtPWUhFSmFTZmJqcFNnME44?=
 =?utf-8?B?Z2Q3bTA2SzBwNUtZVkI5eEJaZS9GNG9sSjhzbnNqWnhkQUlRNWREYVc1QmQy?=
 =?utf-8?B?cTdJcWxtSVpsc2kxemlGSWw3azB2YUFMb0lpangzRTVYdHRwUDhsOE1FNG9S?=
 =?utf-8?B?STVZcXU1Tk1haVZKbm5jczFHSS9BS21LNHpIUGtiVGN3S0ZGdlBJalZoeHlq?=
 =?utf-8?B?Um5RWFR5SmJHd0pzVkpiK2Vtdll5QnNORFNJVHB2MHlJSCtVVkdlVXoyYlNH?=
 =?utf-8?B?NUFpamhBdDhqVUViWUt1MStpS3FwWjBqR3NxQWxHRHBvWTdRSjFqRHduc3Jw?=
 =?utf-8?B?b2h5Zjh3TGdFQjRPeldLRkg4OUIyaytDWkI0Z21KakR2THRwSVNWRkVtaHM5?=
 =?utf-8?B?RkhJenpjNEdFejZtTXd6K1JZUXArbG90Vi9uVkRGMkViVUZmWTRUVTlYdTNS?=
 =?utf-8?B?ZkNxYTBWMm9YMzdKWVVoQ1VxTTExcXk0QWViK3NsTVd2SjB5d3I0T2hOb29y?=
 =?utf-8?B?V3N6UFdmM2p4bSs2ZS9kRW1wRFlGTTB3SCtLc0NXUi9hWUhUYmgveEJKNlV2?=
 =?utf-8?B?cXFFdWZuRFRsUE9UNTkyanc1ZlBrOTR0UnVxbWludDUxNlVESkpXaHRzNEht?=
 =?utf-8?B?NFhkWWoyNG5UUWdBdE5ET3Z3d005QU12aVR3V3NVTjJ6K0N2NUIyQXZqdTZw?=
 =?utf-8?B?dG5mK0hZUzYvbWtQU2pBL1NFTVBvQzVsL0ZibXVlMW9ER01EcUZzRUtqWTJY?=
 =?utf-8?B?VHBMeUIyMlVQWE5mRnUvU0lyNU9IbTVFZWtObG40ajFhQ1VkZFBVb0ZaN3lD?=
 =?utf-8?B?dU11elRkSnR3VisvK3grQmd2NlBESldFQzZmSHI3Tnp1Z2F0bFNmazZWckFX?=
 =?utf-8?B?L2J3dkVvQU5MR0dUUys2ekhSQXNIN2JMam50TTNMa3ZxVExIODdKMWJCNjRZ?=
 =?utf-8?B?NjY2WVhjWFhGb05PZlZHV3JaS0wwREhLNFRiNEZnbktoUUcyV1N1OWkxUVU1?=
 =?utf-8?B?SyszQmFKUlM3SzBTU0M2V1ZVWFkvaWU5dmVqTEpCNnlpamVzRGo2MXJvYUJx?=
 =?utf-8?B?ajYxNDlacGNXZVpSNFdhVGxpMXJ4K2QvUlY5c1VDQXVueW15TXB5eEJmN1ht?=
 =?utf-8?B?bFBOYjJLZmt0SFRLazduSTVBcm5RYlZUcXEvRVZLMk8ycVZKRWFvZUhNdXdq?=
 =?utf-8?B?S3NpdWVlQmZGNGVGajZSL1BBV0ZEOHBTbTRGOXVtajdvWTJWVXcxSnJrQUlX?=
 =?utf-8?B?azN2K0RiZGE1Tnd0azZsTkk2RGRuUzJkQjA0QTIzZ2xkUE42SUlueEhTblM0?=
 =?utf-8?B?RXVHZmRRdXJ3SjNDeTZBSVgvcE9rVm1UY0dkd0Y0ZmphNk1ucGswdDRuclps?=
 =?utf-8?B?UW5RN2Z6QWdJOWtLZHpaall4WHZqYnp0ZGJpNFZMMEFZTklhMmZEU0NJNlBw?=
 =?utf-8?B?dXRFT2xQY0FNNGNlamNEb1B4TlROTWxCb2tYbXo4N3k4WmtnU2JhKzZ6eVVW?=
 =?utf-8?B?aWxWL24rTk9vSE5FTHp0Yi9wQmZVNHBPM3cyNFpwZCtoYjFuQ2d5ODhzSlJ3?=
 =?utf-8?B?SXFhMmFtVlFUYjNGT1hXbzZiYXBzZnUwOVVyNUVEbVVmUjZ3cVNyNWZZd09O?=
 =?utf-8?B?TFFwQjM1QTBnbU9ZMk1lU0RzUERlVVVVei9NWjJkcHVmSE9iZndvT21mL2ZX?=
 =?utf-8?B?N1cxWFhJQ0Vtb0Y1OHp3YW1Ta0F2NDlqTmZ2OGdnTEhJTnpTZjRSNUhEdHR6?=
 =?utf-8?Q?xPBGdKfl5Fn8h+tnMPFL2XH0Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9587061-24a2-410f-23f6-08dd6550efa3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:40:45.1868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1+GAbtyG+6T2maPeOqBOcNNiEc25Al4AlScBHlPyjjWFRnF+WlML2LX6r59f7GxTcLBZDfxDnkIMzVLo1G+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
Received-SPF: permerror client-ip=2a01:111:f403:2413::60d;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Alejandro,

On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The DeviceID bits are extracted using an incorrect offset in the call to
> amdvi_iotlb_remove_page(). This field is read (correctly) earlier, so use
> the value already retrieved for devid.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Fix looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

FYI. I think we need to reconsider IOTLB invalidation stuff. Its suppose to
invalidate the device side TLB, not IOMMU one. Before that we need to fix the
way we generate hash it. Ideally we should switch to domain ID and fix the size
as well. We are looking into this.

-Vasant


> ---
>  hw/i386/amd_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 5b21cf134a..068eeb0cae 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -508,7 +508,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
>  static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
>  {
>  
> -    uint16_t devid = extract64(cmd[0], 0, 16);
> +    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
>      if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
>          extract64(cmd[1], 6, 6)) {
>          amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
> @@ -521,7 +521,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
>                                      &devid);
>      } else {
>          amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
> -                                cpu_to_le16(extract64(cmd[1], 0, 16)));
> +                                devid);
>      }
>      trace_amdvi_iotlb_inval();
>  }


