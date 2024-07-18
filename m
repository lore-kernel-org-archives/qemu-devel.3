Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B5EC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 15:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTRB-0006Af-9H; Thu, 18 Jul 2024 11:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sUTRA-00065m-5o; Thu, 18 Jul 2024 11:52:56 -0400
Received: from mail-am6eur05on2072f.outbound.protection.outlook.com
 ([2a01:111:f403:2612::72f]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sUTR6-00088c-QL; Thu, 18 Jul 2024 11:52:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svfi/6uhAE5sIEVaqBFSWpH5G1MgIQW0kb6cgBc4DLRW3Oz9DbX/dfQ+92qMbHEQv+BqPGdDCM2AjLp4eTHUbZYatapMk7+fyt35dhaMOErOzzHZHEkHpi1TqcB68HcpFBJyTvmT7ZHIW2LlYja4K2PQVMDf2FxhYmJ7e5rcARYv2F2OpdXM8QpWFbJzUsJ9htG26+xYnOHMHKxkftJLfAlQrguunrfcSfcNsYkb313/ZeewZHC8ouRos2JN4qr2TE/b7xQmqLLz8t+iBBlNd+P8l5DiQeboMY4vuQxe6rXyVgdOp256Lj0w9yNkwgvm23SfyUWdNNsPsrv3isc9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tREA55+Ed9flLzZq9frSF1gQ9xzA9SJ1T5jsTnn2Fq4=;
 b=WdiR3L8EceuwP8coYr7z56uZeW4nZQOy4hLRak3DEdfhmnB2Q0D/hKnO4jD+j5cw2YGPYX8O90WKd09jRHmHGTjdjSXsqKNYmxQbntcCP85mzLOt2OekAIt0TQoqoP47w9fpvYFUcQB1194b18VEjgDJzpSx1ou7XfFO3f3md/gxgFmRuuyfj/1lNjVYXEThsbjljT77yKECEw5iwJdzNzYArDEyKvlPPtK4ATy5W6ZITEECSafX+ov+9utdOkGq4HNHtbuXw5UrGhCj9vI8hBJPrNBMpd8mIyHlfCqmxYo2+RUpKNo742r1TsgrALTnuOP4f4MaaK60PQIEVIHwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tREA55+Ed9flLzZq9frSF1gQ9xzA9SJ1T5jsTnn2Fq4=;
 b=mPxjcRIlZbpi2K/WgxZdbBMv9sdFjUBTGRJzTiN21bLNBXraGiVjcPznnjUtF7mNzGZqQacnd4LbAdw8C5SwfpptP7kC2+9GvuhTUz/CWwdJCWqFP03DaFtZrVa4SmenB8BnvdvQ7HN3wAVZN25Pqoyw4PAWizTvpQYcuuQoiz3Ei0l1nqgu4LVG5z8u6Z8+pYo894bQKBxAS9nkBXs5kYQR1B+/DufC63F4ldFObMBxW69UaQJMuiy9BCpGT57o7OTcv3eqM0+opz2/Co9KHqbVFUKxIZh5uhazkBRCttbIOAo5fi1kHYOS2KmWFlhUeJO+QTuvZPK4oz3MUW/55A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB8479.eurprd08.prod.outlook.com (2603:10a6:20b:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 15:52:47 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 15:52:40 +0000
Message-ID: <04f4f2bf-fa4a-408e-9dd8-9fdb034322c9@virtuozzo.com>
Date: Thu, 18 Jul 2024 17:52:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] block: zero data data corruption using
 prealloc-filter
To: Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-2-andrey.drobyshev@virtuozzo.com>
 <Zpk5-GDaqmD4c-EF@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <Zpk5-GDaqmD4c-EF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0157.eurprd09.prod.outlook.com
 (2603:10a6:800:120::11) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: fc95f4c1-ec5f-4846-fbe1-08dca741a78d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3hubnhUbit4UXZFYXFsdUVVaE9SOWp3RjVucWlGZzNYYk1CMnRFM21iSkdJ?=
 =?utf-8?B?a1l4eVQwT2dmVFBMVTZYZlk4ZnJpT0h2ampkM1lEakFwMWs5TUdqYk9KR3R4?=
 =?utf-8?B?ZWRpUFpWS0dxcWJoV1Q5N0tiY0VFelcrUnRjaVkxMHRKK1VMNXU5SVlsUWpQ?=
 =?utf-8?B?dldoTE5vOGQzbnloSkVGUVhaKzJXRE5jbVZVOHMxb3QyS3k3bWNCK1k3RERl?=
 =?utf-8?B?UU5uT3MrWXMwSTlaaWZyWWlDVmQ0cklsWFhzQXY2VUtTZjdCbGdYcnJ1OFBK?=
 =?utf-8?B?MHZPdnlwYzZuK1QxcS81VWVweFQrdHQ4TjdoL3dNQ1VvTlhtSnlDTVFEM2Ft?=
 =?utf-8?B?Vy9SUUNCdC9wU0JhcDBQV3F0VWpNK3kyeWFEQlhqaEgrRDE4RndJeUFrN3BD?=
 =?utf-8?B?UEVia2pLY2hjS29oRUM1ZElQQXZOUkxQUzl4Uy9oQ1pCbjdBRHhmeE55RVgw?=
 =?utf-8?B?eEV4NjhJMFNtd0sxOU5uQ3BsVEJvSFBDTHdYUDZUY2tqcjkveVppTytQSUJE?=
 =?utf-8?B?SDI0dU9lMmdCM0FSZmhyV3ZENXgybHZva1VOV2I5ODEwVGRCQm5YWnAycEx5?=
 =?utf-8?B?a2FPVmVpZ0RnUDRuYU54eGx6TGFXdWE4aDRLYWx2RHJ2K2cweU5pYlN3VjJz?=
 =?utf-8?B?V3g3aStaYThveUl2Z1ZqdHlUMjVEVzFZc0xpbmxLQnJKNVJpTDcwRGFPTnFm?=
 =?utf-8?B?VGpQTWMwOHVwZi9DQ2dyRjNtTGxDcGFlcVZKQUlSWVJYR0srT1ZnSWk0WUtl?=
 =?utf-8?B?MjFHQXQwZDNaMXY3RmRUbGxUbnZJRlBmVnNQaXQ2ZUdLZkM5alZIbGkyV1ND?=
 =?utf-8?B?R3Q3SEFveG5JbHZXdTJiRnRQYXNuSXMvVUsrSmt1S3BzVFRPRzRwRkJrcFhX?=
 =?utf-8?B?YkhKUDgrcUhTWUM3cnMzaXdFUHYwOUdGdHhpRVlPMHpCdnd1U0RGdzdWQU1M?=
 =?utf-8?B?dHdqZWwwVVhFbkZmZXVISlRwWitvaUtIMjJuNXFzd1RNWkVMaWl1c3NEdEpT?=
 =?utf-8?B?SjhPWHZxVkxOYk1zWDNqdDdHS3ZoR0UrVzZLVlErblFXOUwrbHRjd1BBcXVx?=
 =?utf-8?B?Zm1kalN2NFg4dS94bGN1dVVRUWcrNjVWWTdVS3RVVEZhalluZzMrdXJZemlV?=
 =?utf-8?B?RnR5aHd6RHM4S2hhN2xFODBZUVJGek5ieEppUUNiT0ZreGdieXVWc2RJM0NR?=
 =?utf-8?B?ZFlsS0lFRjF3REx2eFdBUDlMOUJGeHowWGRxWVNscmFnL1dvK2tyUW1zNGdB?=
 =?utf-8?B?T01Qa1Zic1hkUW54cCs5bFgvUEtqYmlxSVVjWW9ZQTRyQWZxTTJSMEVjODBx?=
 =?utf-8?B?dUJwY283N0crZThwS1NHTEQ1MHJOR3h6WUFyU2krZGJ1Z3l3ZmZqT3QvT0FB?=
 =?utf-8?B?dDE1dTNBMXprY3R4L2gxZyt4SnR5bDBFYjVEUWhjN2N6UFp6Ulk2VmVDNll5?=
 =?utf-8?B?RksrVmpSVUc2WWFGM3BZWEsvZVlTVUN4K01vMGRTRGM4VGthT1NLZ1k3aWtM?=
 =?utf-8?B?bTJ3RDIvRVY0V2hKQ1VCS090aFc2WitWYlRoa2d1b0p4NEs0N3ExSENKamxS?=
 =?utf-8?B?UFp4WGsrOUVEbkdtUlFtS242SmZwNG53czl0bGF5VkhwY3BlaW1QVzdCS1d3?=
 =?utf-8?B?K3MzRFo0RlJ3WHhUa0lTekdrUC9MK2l4VXVPVnl1QlZXbUJuUGUvaHZNQ3dH?=
 =?utf-8?B?eU5hZldqOHVHV0hab2MvZDdZNXpNb0NlZXFsYjFKSGhoUWFnWUhTUHA5enhX?=
 =?utf-8?B?ek4xUC8vNGZPaHUzcjBTdFpHWXhDU2ErNVlTMWxIVGF4OXBWenlrM1hyRUFC?=
 =?utf-8?B?emN3L1FVTVFSRWJVaEsvdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHpQeGN2M1RaaVJxdnY3Yk94a2ZweHpvcUFIWHpKMGM0alVjRnpSS3BIUVhS?=
 =?utf-8?B?YjdtRTJYb2NsVTJtMXZTMWZ3V1M2NmpseU96a2Q3NG9rRmZNU2d6VmxQMkg0?=
 =?utf-8?B?QXc4RUJaNDI4SHV4ZVQySWFubkdRRGJQZkJXY04xeldYSmhZNU1uUXJHM0wr?=
 =?utf-8?B?enZxOVJsK0FJYnpVSXhObnRuaThEaW41S0R1Y0tocXc3WmVLVElkNWdWK0VM?=
 =?utf-8?B?UDNmbGtTMmxqU3FzcGV5bzhQeGJ4OFhrRHMvYzN1LzJocGlROHUycXZwQ3Rm?=
 =?utf-8?B?K2J3NzBVNUw5QVRwOXd3Qkd6R3JUQnNFVW5TK2tjWUUxd3YvWDV2U3JFQ1M2?=
 =?utf-8?B?VGFwL05XUG40dmltaTk2NmNMcDUvZlNNTE9GODQvbEpudm5VM1lyNm5RNmtz?=
 =?utf-8?B?QWVRcElMZUxUbHdicmNhbEl5YUpKNW5vanlDY0lidi9HeEk0TE5jd3dqbElO?=
 =?utf-8?B?MUlQdDhhcnBEeGo4ZWhzVW9KOWxBUTdGNFVVR0hYaVFhNmFGdVJOUXZaTUM2?=
 =?utf-8?B?ZzllemNKMGFiS1NoNmp1TzBTcENUNy8xcDRlMFZYeTFnbjFIbEpnOVdwL3do?=
 =?utf-8?B?WUREVzNaMldQSVRDWkU0S0tRay83YTFkdVQ4ZnQvcjVJVkhCUE5jcXpHbC9X?=
 =?utf-8?B?QVJhV0JBek53VTNTUFR4OTRTUVRaNmxtSU1jTmxUd1VRM1R6ekdJc1MwVjd5?=
 =?utf-8?B?VmV2NzF5Z21MdVlkZVFoY0piSFlEU1ZweXhLTHI2aENiM1lRd1BESTRkK2Ru?=
 =?utf-8?B?TGtqbzRwbjF3eGF5NWFucTFxRGNpUFZRYTFRc1VsRDNqbzBMK0IzOHRoeHdE?=
 =?utf-8?B?clpCVGN4NnNEZURGOHlQMW5RaFVoYS9Wdyt1eU0yMC83MGpHL1VhM0hrMVE0?=
 =?utf-8?B?N3VIeXZQNGJKd2NZV215ZXJlS0VERWFQd1J0TDlEMGgrMk1FRHhFdkp3b2U3?=
 =?utf-8?B?QjdyMTIyUlhPWnZrNEhWaVl4NTFjRGNyeGMySU1mbFB1aHY0VW1WWCt0YURV?=
 =?utf-8?B?YVAxalFiUFlkUC9JcnFtK04xRWV3dTdnSXZXd0lIamFpQ3BzZTlweXRhSWF2?=
 =?utf-8?B?ZVUvN3pVckxuakJ0eklOMk11Z1c3TDE4N2N5QVdla0lrbGp5Yy9ESG01OUdK?=
 =?utf-8?B?dTQyVUt4T0o3K1BkRW1KeWpMRU1qV0paNFplWGpER1Y5b3k3ZmY2OXo0SUli?=
 =?utf-8?B?WlFoZVducklpRE1ZSmtOdnpJalZrZnBsb1NmL28vcTI3WkJPUnlIL0g1d1N1?=
 =?utf-8?B?bDU1ZVZVZWxKa3JDSzZFQVNvcXg2cXZjc1FjQktKM2VXM2sza0JCbmZjMS9O?=
 =?utf-8?B?blI1MnpueUIzOHllemR1R09vTHhtbTdDZmNvWVhPRnAvaHRROFN4QkR0bUFU?=
 =?utf-8?B?Y0lOYWFUeWx2RzdXRnVkNVVNam9rak5lbGNobUJmc3lDQVBxTzM1elZHT2hT?=
 =?utf-8?B?K051UEFyTGZVK2VDWFMyMTB1ZFlQKzdnUEpQWW9iMVdRWjV6elR5NVMxeXF0?=
 =?utf-8?B?SDRjWG1EUi82ZTNwcE1nZlhodEExaFRFMy9oSWo4T0FCcnpSSUltc3kyL1ZK?=
 =?utf-8?B?bWRIVnBqenBJR2R2TVN6WkRWV0pNSFhrK09xTXlHS2hFbEFnUjJSTjFkSHVh?=
 =?utf-8?B?VmFIWmk5cWdFaW0wMTVtMUxsNEF5aUFpdG5BdVFWTDR1K1BucnNUaUErblV1?=
 =?utf-8?B?Tzk2S0FNZTlxenl1bDlmMzE4eFRkZ3FpOGdudWNSUTd4L2FwZkZUc0ZURFUy?=
 =?utf-8?B?bGdFL2IzUys2WnVwNFZtaHhDKzI1S1VIdEJVMExwWmNxaC84K0hBTnZGN1NM?=
 =?utf-8?B?REYrSm1Lc0p0L09uS0N2R2xmNW14YnorN2l0ZC9TWVQ4UHhWUEUvUmwyZExy?=
 =?utf-8?B?RXhRTVJPNU5Id1lYSnRkSmYzY1NUMWxMRTg4MEVGL1hEYVZsMHJ0R2JFMmpo?=
 =?utf-8?B?L2NqRUZBOUNvVGNNUFJJZk1Jb0JTM2Nsd2s2dnlwajdOQURsTnFYVDB2SEgy?=
 =?utf-8?B?bXJyck5jck53QWhaYzBWUTg0bGVNNEFhZGJZeVB5cisvR3VkbU1iY2RDaUxR?=
 =?utf-8?B?RzNsWlg5eUJzejRSSzdKS2ZGZ0JXbklwWmNtVWZjMGVVVUpEWWFZUG56cGMy?=
 =?utf-8?Q?HXlYYRfb8WYMs3UxqNvUPqA43?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95f4c1-ec5f-4846-fbe1-08dca741a78d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 15:52:40.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Z9Llw3aNU7PRqDDjZ4s/FmMhXiPa3xe0P1+Ggu5rYKTEcX7APWQnr8o6wTBIkhOqP7iAv2QHdH7ZVA12IYCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8479
Received-SPF: pass client-ip=2a01:111:f403:2612::72f;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 7/18/24 17:51, Kevin Wolf wrote:
> Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> We have observed that some clusters in the QCOW2 files are zeroed
>> while preallocation filter is used.
>>
>> We are able to trace down the following sequence when prealloc-filter
>> is used:
>>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>      co=0x55e7cbed7680 handle_write()
>>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7fe500 do_fallocate()
>>
>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>> time to handle next coroutine, which
>>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>      co=0x55e7cbee91b0 handle_write()
>>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7deb00 do_fallocate()
>>
>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>> the same area. This means that if (once fallocate is started inside
>> 0x7f9edb7deb00) original fallocate could end and the real write will
>> be executed. In that case write() request is handled at the same time
>> as fallocate().
>>
>> The patch moves s->file_lock assignment before fallocate and that is
> s/file_lock/file_end/?
>
>> crucial. The idea is that all subsequent requests into the area
>> being preallocation will be issued as just writes without fallocate
>> to this area and they will not proceed thanks to overlapping
>> requests mechanics. If preallocation will fail, we will just switch
>> to the normal expand-by-write behavior and that is not a problem
>> except performance.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/preallocate.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> index d215bc5d6d..ecf0aa4baa 100644
>> --- a/block/preallocate.c
>> +++ b/block/preallocate.c
>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>   
>>       want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>   
>> +    /*
>> +     * Assign file_end before making actual preallocation. This will ensure
>> +     * that next request performed while preallocation is in progress will
>> +     * be passed without preallocation.
>> +     */
>> +    s->file_end = prealloc_end;
>> +
>>       ret = bdrv_co_pwrite_zeroes(
>>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>           return false;
>>       }
>>   
>> -    s->file_end = prealloc_end;
>>       return want_merge_zero;
>>   }
> Until bdrv_co_pwrite_zeroes() completes successfully, the file size is
> unchanged. In other words, if anything calls preallocate_co_getlength()
> in the meantime, don't we run into...
>
>      ret = bdrv_co_getlength(bs->file->bs);
>
>      if (has_prealloc_perms(bs)) {
>          s->file_end = s->zero_start = s->data_end = ret;
>      }
>
> ...and reset s->file_end back to the old value, re-enabling the bug
> you're trying to fix here?
>
> Or do we know that no such code path can be called concurrently for some
> reason?
>
> Kevin
>
Truly amazing catch!

Den

