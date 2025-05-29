Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8798C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 04:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKUtH-0007aJ-5M; Thu, 29 May 2025 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKUtF-0007a1-Ks
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:29:13 -0400
Received: from mail-bn1nam02on20602.outbound.protection.outlook.com
 ([2a01:111:f403:2407::602]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKUtA-0002zQ-1j
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:29:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ4va22NNN3Nf2pO9fmDQGXN1AMiVTsmacxJ4xp1iul6Y2B40sM9iVEjSVUiocNF4OUsARgEi/O5QebrnGC4skx0GXz0UgjxGP+tf56C5nLVa70S8wxcw1cNUBWhyhlMrM5CwHJY3QNX5C+EWKThMWuooYj+h1tVw2pWOM1xiXfYbpwbeOcB4VGSTntGJwe0n2Q8zJGXQttcjRzi7MTbux6nx6w0UidAgSaMAeNVvZrKp8C/nvQog4E7aQkRggFD7r3CwdZGrRq4ytzXz5eQfJMEiAU38fOT4m94+H9y6ZzCJF+/wbVeRTy0w1fjAAAaaEt0em6VYA8S8saLRU+zrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpSmaXyXtTznlw1x2HIUkOSgkhaYv/6D3upObTOAp0c=;
 b=kHLsSRNQRGqjyxYxIbxbpd3cJ9FucHkroRanHSNz9JjtG+YkEIw4KPwxawOlmLhEkSluVrK0RNvWH2KY/4UA2hdI6gI2bUhmGdl8WcB8hQPPEj2dqXGCuq1v0KlzRZQeqbz+/jrmLMJ+4sLtrq1x7oB1e0voFe0MLJ5L4YbL/hF5wk4mW7z24naBGGamByudCredPzqf0bHJplheUTbDXWYeeiM7Cjegst1aKvYX0Hd0265pzY0JfhoNH7/N6ReXCin0X+kJ/xjg6BxMBbGkM/Yc0lZiJ1/WDG1aVXCfLF0Ntmde+LF7DFQBKLNpkfD42wo4NudjXCq/lvuSg+i+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpSmaXyXtTznlw1x2HIUkOSgkhaYv/6D3upObTOAp0c=;
 b=yn+xUzFP9c5vkzdtQrIiuGN4kRlMYn0Th8Sl+YgmI/3IytaEwkglOCAC3U5/H5Ed+S9s+/qQzN3NIoq9qsjQ3PcXpfZhaA9t4fPGS/bbxIsTko0GLG0gDgtoCSpwNxxGtYLGlYX/Nhzak/u1b9rs//tKhxKRnbZX+xr8EwQG/qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 04:28:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 04:28:57 +0000
Message-ID: <6fedd32a-b8b6-4124-ad33-27c9986991d1@amd.com>
Date: Thu, 29 May 2025 09:58:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] amd_iommu: Fix mask to retrive Interrupt Table
 Root Pointer from DTE
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
 <20250528221725.3554040-7-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250528221725.3554040-7-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0129.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef55a7b-c551-454f-3e49-08dd9e6953af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0xxbjIyd0YrTWdXakZIM3lyZnBVaSswUTJXMGdjbDAyUWxvMG0wbzdncnAw?=
 =?utf-8?B?clN1SXMvSWEvQ1ByU1pCQVcrWVBtajN0TW9BSjRReU40b1VYcndhbENIYWQv?=
 =?utf-8?B?dUU5OTExdkk4cFlHMTlUNGdsMW54ZUc0VDBDbElUM04wbDExV3hnTzFJQmxE?=
 =?utf-8?B?bzF5SytyTC92Q1Z1NnpVNzJjSEpkM0YzdFBTeDM0WTRGZ0tONzh6VExxU254?=
 =?utf-8?B?Y293M2VCV1paZ3RmU3p0dkpUV3Y4K3lPRTRoU0E2a2dZN1RBeXdtUDIvY3lw?=
 =?utf-8?B?cXh4UVZtcEZtVThBRGg0Ny94bm0vTWlzd3R6d3FLWFROd0ZrMVNPa3V4b2dp?=
 =?utf-8?B?S2ljTlJXWDRpQk1YRGxJZkZuV282dGl1bGphWG5BVjVYbkRINmpyOUlISWhM?=
 =?utf-8?B?RkdXSjBXUGNnNEVDQjFxdHV1US9XNFVBRGFwTDdpenY0ajlvWjBJTWk3SmNj?=
 =?utf-8?B?d2FqZXpBMXNUd2oyVTRpQThPZGZVcXNuSDM2YVdqRGw4Y09YNGxSV01weWsv?=
 =?utf-8?B?YlJwZ2hrNDY1cjB4cEZDK2dsczNGcUJMdzQxL01TR2JIa2dzSzBQdFNEcVdG?=
 =?utf-8?B?OWZtVXhBR3V1NkVZdFRqYWQ5Yi9TRHdMVnFoK3hQUit0MjdNUGt0cStianho?=
 =?utf-8?B?am1jb0llRUVqY1R5OVkyRWZXUGpoTG83Qy94MFp5cCs1bS9KSjRobWVUbXgy?=
 =?utf-8?B?Q3ltaGZWeEtlVHJlQUZCdVFyeUg2RUdESXIvcGJQNTlrb1RsSHFtQ2Q2OHkx?=
 =?utf-8?B?R1JGTHdLQ2Vtb0thdmFEUlozRTJVb0FUZGJwYUhjMzFNOEdPMUtmUDlRNk9X?=
 =?utf-8?B?eGdHbW05TmYxRHg3RWZtdmVOYmlScFQ1YUIxOWQ1aWVTb1EwamluOEFlQ2ts?=
 =?utf-8?B?M0ltMnMrOXhybXpXSHJPZkFZWlF1SjBJYnRZRnZTTHR0OUhheG0xb0lVOUc2?=
 =?utf-8?B?cWQzZmUxbS84MFJIUEpOKzNCZDJJNEs3QS94QnJaR1ZJRWFwUEJVdjBEN2NJ?=
 =?utf-8?B?ZGt0L1NBYjU2UVFDcFNtWFd5VG9RSTJEWHVoME5oL0pwUy8xTlBzTlIybDhS?=
 =?utf-8?B?OFErOXgvUFdJdzRCS0QxOXUrMzN1Z0JPQWFoNkRVV21GZExmWmhJWFd1cVlJ?=
 =?utf-8?B?T1JBdGZzK3lzRzBGT0NNekFSTEFkYUN5b1pVVEJ4RzZmRjJiNFFWY0RCRnRq?=
 =?utf-8?B?MXdWbFEzcEVZUUlvNWQzQUp1eUhseVdUeW1jL1dkc2JjYW1MYzdySlhuclJK?=
 =?utf-8?B?cDVHaTh2S2QvZXhvclZDVlBBWk9OQWRyazRFMHdtaWlJQjVmdmdLRVR4S0R2?=
 =?utf-8?B?bW52dW5wblNZTFU2OE5HK0M2TlE1K0tzc2dMeXFXdFgzTGlCRi85SndRdUlU?=
 =?utf-8?B?SlFrSEJuU3lpS1d2WWd5TU16SU01RXBQVkQ1WVF1bWxEdERzSFNMVHl2SklK?=
 =?utf-8?B?TStkcG5BY1RTbU93WWJBZ25yMk5HdVEzTXRFeEUzYmdtNE9vOWpETFhzVytv?=
 =?utf-8?B?WjlhcjVmK29YK1QwOEZEYnh2WkZYRWU4N3BWKzFJOHArblgvaTN5TEczeEVm?=
 =?utf-8?B?bHZDVk5KMXloemN0WTV2VUdydVpsS0ErcUEva1ZYUUluc0JMYmhJQVQ2SURF?=
 =?utf-8?B?MVdiak1mTEdRbVR0S3BVcFJoTnBBZU9XNzVCNk1jeDh4UUtyclkyMTBPUlRR?=
 =?utf-8?B?cndaNnZ6d0xVd0lHT2VmeEprb1AxbVkzejlGM24xV2hYZytLbVZMRkNGUlUw?=
 =?utf-8?B?Y0l2ZTM4cXBMMFpQSEVscy9JRnRKMzlNZWl4UjYvcElZR1RlOWZSQ1EvN3VP?=
 =?utf-8?B?azBIMm1OVVpiQVNiWTBaMVdWWFl3eWoxNFEvdlJ4V2NkMU5QVndVeFdZWmtZ?=
 =?utf-8?B?YzZuVnN6d2w1Vm9rVHF1V1BtSXNZL1pKSDZFVE5pL2RaMkNYT1VuU3BNa0dB?=
 =?utf-8?Q?C2iBaCnj2eo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0lKUkk2UmxWcVNicmg3bDEvS2YwQmdyMWUyZ3oyeWs2TndaUkZoNm9JSEt4?=
 =?utf-8?B?eThrVlo1MkRaQm9GUFlDTnpIL0dpWGtnemMzQWtHdTdQMytyZjJTWXBUZFZ2?=
 =?utf-8?B?ZGV2Vkc5bmprTGI1anJBYnc0ZGU3L1pSVVZVeTNaM09QZFpEaUNLZmdYdzd6?=
 =?utf-8?B?NDVtMzZmbWN0WkpId0s2N0V5U0RSc3I0L3IxVzF5VktBS254N1QxcC8rTlZK?=
 =?utf-8?B?ajZSYVlRMDRZbW1oM2RlQkhXQUQ2dEdnSC82SmZ3UVVmZ2xpZGJNUk9ZVUpn?=
 =?utf-8?B?WWlOdXE2RzZVTVVseHFFdGNCN2FadVIzdXJXTFUyVll0dFROVW96ejlYOWF2?=
 =?utf-8?B?eFoxdWIvMlRKcFZQODM4aC9YY2JqVnFBRlVEWEp6a0FzR252ZGRRWWg4SEY0?=
 =?utf-8?B?Qk9NOWxKQ3ljM2NuVnRZU2orckZpKyt5Q1Mzekd2Rk5jRUtHRW5TVDFLRjNq?=
 =?utf-8?B?ekNpeEN1Z3NDY0Q4R0RTWTE3VEM2bVJwMHBLaGNiTklSVnY0eWlYQVl3b01I?=
 =?utf-8?B?MDc3QllmMHhhMmYyOGY0bFlrQjQrcUFjY0dsVUlHbitsVHVwR2Z5ZytGZnIr?=
 =?utf-8?B?dXpCQ1JIUDRvWVk0Ymg2b3Q5bUN0cjhmTTY5SEQrUkdRaERJb2IrNC9kaDJR?=
 =?utf-8?B?SEYvK255V3JZc2hhS0VMWk9oei9BUXYxZ244bDhQZVYzSCtENjJhSm8ydDZk?=
 =?utf-8?B?dURCQUVQK01oaWJCaTFOK1U2Y2xjcVFxbG9vMjFhMTN5ZVZZMjdQVG8wVmwv?=
 =?utf-8?B?THRmRzlXY3loQkNLc1JiZ1BHZlBaeHZyVjRaSjlNSHhWOERVL2k1THl5S25v?=
 =?utf-8?B?YzVLR1d4WU9sa3B4Qlc0ZEVBcUd2UmVuMlNpcDRWQ3E1NDY4WFYwZys0NWRw?=
 =?utf-8?B?a3FwY2cvbkxKb0YrckNHL0o5YWU5bUcvcEpZd0h2aFRJL3c2Mlpya3lqd29i?=
 =?utf-8?B?b2E0bEZEeWdzQTlxS0tiaitDdEJNNWlUR1BaUnh0eFQraTZ5ZUE1Ym8xaXhE?=
 =?utf-8?B?cm5ObVprMnlIYnBlQThIMWVHZnpXZDhEblEwVC9RK1VpLzVVNjVRQlZVTUNF?=
 =?utf-8?B?MFA1YjB1d3VrbEE2MllXcFBMMkE4Uk1DRk1hWmZGRXpjVjdURlk3cE84Ujdk?=
 =?utf-8?B?Rlg0RjNnMWlIa2p0ekEyUHNHV2daRGlXeThDeG5QZEhoZkdESlczWjVrczlT?=
 =?utf-8?B?clRyZkZjdXdGTitVVHhiNlJSRHg2N2lsRzRkSmFaM2VnNlpkbWRJK0l2M3dl?=
 =?utf-8?B?ZjZZTkwzeVVFL2MvWWMxRmpjcksvajhwSlkvakhBMFAwMzg4bk83VHVueGN6?=
 =?utf-8?B?dFZZemZUekptbG1OWWoyOG8wdWt5eFJrMFdUck1hK3VTa3M2cTErSXhlbEc3?=
 =?utf-8?B?S2lDaWlSNTVEL3JuNzJKcHlOZlV6aTRORHlBdmpjaWFScC96QWlTTkU1MUdx?=
 =?utf-8?B?Nkt3NDFZaE93emhVNVBPeTlydmJicjg2OTlteFdZVWNpTisxQWIwTlRTWDRG?=
 =?utf-8?B?RkJrZUUwWEZ4c3Y4TTFKaUFDSEJUeWtJZGU4MzhLTlVJSmV0MHlHVW9ob05q?=
 =?utf-8?B?UlIvVzdONFBKc0lIeVdNNDBmNHp5cjYxVzdVbGFKWFo4MjUxczAyS0h6YUtU?=
 =?utf-8?B?TVJCODRhdnVvNDZUT1h2dWltWldxUHppNEptbExvc0krcnI5c1lINTJqb1Zn?=
 =?utf-8?B?ZGFFaFFnaFhGbXZDSDMva0p3VHRjbW5RVkt4RFgxZGx6TDhlcGRtN3lOdXVr?=
 =?utf-8?B?bHJGL3U0QnZ3VmVyc3B4TTFpb0d6WFBsKzRiNTM3emRqclNsVHFjcTdiNGNI?=
 =?utf-8?B?ck5DRkxmTHBTTjQ1R3JOd1I4WDF2Y3R0RGxFdDJNMmdiMjhEME5VaktlZWt5?=
 =?utf-8?B?QUd1L3lRZTBJT25mdWZIbENtaXF1WW1JdCtTWEVMajI1d1VmRVl6cm9lUUtC?=
 =?utf-8?B?ZCtzL0pjQ1RkelEwbnRObzlxakM2YWxsZFlWcUlQa1ZCSTVzbkxpRGR6bnhw?=
 =?utf-8?B?WWZhUm0yZmppc1pHZ1drWnpHMXFSUDhPdktQWENlTytXbGNWWkprbjYvZGRX?=
 =?utf-8?B?MXl3OTNIZjJhVnYwc0VEcHM4RE1zeis5TzlIdUo5bTRFNjUySEpDYU8weHo5?=
 =?utf-8?Q?tXkKKphptiHyLnApfjWxKv+Nr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef55a7b-c551-454f-3e49-08dd9e6953af
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 04:28:57.3126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEV5CSdw6UFlF+XTZK34j1GUSw2w2r00cUwH1yPTgFVksEwbKlQ1bvz5/il6KB1aQTv0nLCJ81IKFQQ1Z28RXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
Received-SPF: permerror client-ip=2a01:111:f403:2407::602;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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



On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
> Fix an off-by-one error in the definition of AMDVI_IR_PHYS_ADDR_MASK. The
> current definition masks off the most significant bit of the Interrupt Table
> Root ptr i.e. it only generates a mask with bits [50:6] set. See the AMD I/O
> Virtualization Technology (IOMMU) Specification for the Interrupt Table
> Root Pointer[51:6] field in the Device Table Entry format.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

I found this issue last week when I was going through the code!Thanks for fixing.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


