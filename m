Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091F9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjNp-0003Q5-D3; Tue, 30 Jul 2024 05:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sYjNn-0002uB-1M; Tue, 30 Jul 2024 05:43:03 -0400
Received: from mail-am0eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f403:2606::704]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sYjNj-00012T-Vv; Tue, 30 Jul 2024 05:43:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upDuC0HN/6blGaaKEhoZxBg1vUh4f/gomG2JGjLxNjAT3/TsfK/X96pVwfdEh4fJxQbZ/vAxJfP4KbP8xwCaGSYyxzsY+jtvVZlGcUQu91jqGneAJ6RDRcg2JGSIrNu5T+UAKFi2OwwcivymJRXAietDAu1G/HXGr6xrwPw9EVACNGOw8Rk7LQTF4Po73reqzBJgg9RvLlmR/z1jFgzvRIGuJvt+5S71okh/zVIHwgnDCi9GXSlp8SNyPqdBeJ2JNdVbn/ZOM+RfQxZuFXRzmFjyXBNDf9q0bsh/xfSXGISVmYA+a0y+dh7TQh+ZVA5WRnOHOuDAd1L6dhjbU9Dclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4O6bsIQc9U4IAmhl4AxUmrXLlkFrA0kaL+AHxnu7ts=;
 b=Y/KLjETcO0amY+r2VOh33prBHCZJZDsGKFyx754mLPhwbWgXBf0wgdcY0Jlq3/xHY6y2x9V9i8cMHqhGA6rs7SRrY6RTuZ0BRnfCU0oBGprHBPQME/WEWo+A3vUGx9sgbkc89YFkoGKQw81/TUDs3kU/DRf3eowh/TBDK6B3PxhfWRvZG8oYTMDOGGaWLXUeUmezPB1/ahgF6Zc7mzmehEJVXIBQHe2GZ0AknbrL2Pm4X8LwTmOfZVzOUorTKfR1mAfaw9NfMVYEjT7dsU0CEHOQbjbwE8UIjUkWk0i/E19zTn3lJNYuipgysLtsAabICUdwnU0H2vKSdPaBaN9GFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4O6bsIQc9U4IAmhl4AxUmrXLlkFrA0kaL+AHxnu7ts=;
 b=uZ3XrkTRqx+AN/yH40n3VotzKd49AiTPjkTt0pE5Uwikb4cjpYs/NJ7NgeBxxPgFXorp/fChBTsS1UdmYQGhXTiDuo/XTx6/1JHJoLXygyORfOTpwKWgW/uB7CIYGSepLNhAWOEhp16Kvi4bKPELDYsJwPOAhxAptWqfl6EWmxeLVYz8aCBTLDtnZJaJlelJ81Co0pdtEk7w374vnzBS5S4IW587MwDe7a/k6qivVpPgVo2ViBId7zy5wXHRWh1lYYsgqci8qFV4plWTlGu2uRYBKTM7fvA4pmyrTM7QhbcJZQk11COJmNbHFsI5NV5Fb+PJndEzfsCrgueycnTqrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB7682.eurprd08.prod.outlook.com
 (2603:10a6:150:61::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:42:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:42:50 +0000
Message-ID: <f5e8d3da-eba8-4217-adb2-6f11836e2f67@virtuozzo.com>
Date: Tue, 30 Jul 2024 12:43:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/27] iotests/{024, 271}: add testcases for qemu-img rebase
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231031185918.346940-1-kwolf@redhat.com>
 <20231031185918.346940-7-kwolf@redhat.com>
 <7757bd81-b74f-4862-b6f5-f9628410d84c@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <7757bd81-b74f-4862-b6f5-f9628410d84c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: efcb13b2-725a-4a05-c5db-08dcb07bfa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3psaTFOeFhkcDAya2h1TFloeERTbXFhbDFwdERqSFJ2bHVQQ3FxcVc5SUVk?=
 =?utf-8?B?UUxpa1BJVGhQZGlKUEZYZS9JUUtMenpvd1hWSERMTmd0NWFFSGs0NEpNMXVC?=
 =?utf-8?B?NkpUcm5nSTgrRnNRZ3hiNEg1NDd5KzE3MHlRdUthY000RnN4SExwOG9rOWI1?=
 =?utf-8?B?Z2NnTElURWgwVHlpTEE2ejU2SEtoNjNxZzNNRHpQdTJMRG1wbFMrZHg0ZmR2?=
 =?utf-8?B?Wm1TOEhLUXBUcG5CTUdhb1llMy9TM0xraWFQWXl2bHhTdWIwYkoza3haa3J3?=
 =?utf-8?B?cXg1MnVlQlIrNHNNaXYzNEpSRWxIQk5nenFKZ0VjTE5vbUYxOTYybWxDK1ls?=
 =?utf-8?B?WGxpMVpGMXJ5UTRrczJTTGtQQVlGMEx1WWZGWW02dXNZZGd5bWNKU2xaSkVw?=
 =?utf-8?B?bUUweGRydWdVSk0zMWR2U1JoWjkxNmQ4aS9Wc1FxS3NJZmtBVE5nSDJDWWxi?=
 =?utf-8?B?UFB0ZmJ5WVY1dHhvMFh1d1ZtTXZEMXZZTlNKQzBqQzg3UmRiMFgrZU5hN0dS?=
 =?utf-8?B?bis1V0hLdVY3VlBhTVFOYzdzcjNOTXBZTzR5b0Q5WVFzUnI1eTBZZDJqS0pw?=
 =?utf-8?B?WlVtVEFRYnhTWW95RWlER0o0RjN1OE8xSkFGS21tRlJKaHBBaFBIUjhSbXQ3?=
 =?utf-8?B?TXVXdXhYNnF5QzJ6UlhKRkd1RTJEV1o0S25lRktFZkJTSVFxMVMwV3J1M3BE?=
 =?utf-8?B?WVNhZkowVUJlaG9GRzVDSGdsOUVnVjFzcXEzTzF5UXFDL2hXZG5kY3MvZlJN?=
 =?utf-8?B?QW5tVkpVdTlrTmRUZ09ZQ0I2dnFCNHFDc1gvSjl0OElUQlFyTjNmTkVzNGhW?=
 =?utf-8?B?VmFiUFE4WS95eGFEbVp1NUhzSzRGWGV6V0QxTGNGZVJKbVh0RjFmZ0NzODVw?=
 =?utf-8?B?M2I2aHRGZERieWRYa0V5emVVVWVxdHRmNERsUUhDd251a3lWdThCNTBuQVZh?=
 =?utf-8?B?M1lBcXVHQS9VRzNMWGNpamczWlBSdmNRWW5NVWJ5Rm90ZXIydVdvWFE3M09E?=
 =?utf-8?B?TjFVVVNkRzlLZ1AzSGRNdmhLTFlEZzRLVEJCcDJsVlRiYjJCKzVERm9IOWtL?=
 =?utf-8?B?ZW0wcVhwY1RwVVJ6ZmY3TWM5VFpCanlHRUs0c2dFU3hhVlJ6ejU2U1hwd2Fv?=
 =?utf-8?B?MUpVa3k2bTg4UVpDZkhEdnh0RUNuMFArSHJpNm4yWVc3d1VMamhMWS9wSFV3?=
 =?utf-8?B?KzY1RTVoOVR2WW02SldwQTRpekNtbkV4bWp3cGZ3bGdraTFZUXJyR1U2eXN5?=
 =?utf-8?B?ZHRjeE9EQUNZaEtUdWhBa3VrSFZNQ2VnMHFBMDdZNGlpR2hFbGFGRVRkMThQ?=
 =?utf-8?B?b3A5SnlQN2pPRDhWZkNvcXJWWVBJYngwYm0zYUFleXNsTXZDVVJCUi9rNm0z?=
 =?utf-8?B?bWtUUE9RZGxycG40aUFrVEpYd1BKOEtUSWl2ekxoYSs4QlZDdzl2Vkg5b2Yx?=
 =?utf-8?B?RzUwYTJHd3JtVnoxWk1HWmJHbHlOVGM1cUdtZERJdWMxR1UzTmpvWndiZjZy?=
 =?utf-8?B?c1gwSUltUlgvM0JpdWlYS2NyZWlPMUtiYmxqWUI4aW11MVVvSXVaaGx1Rm9n?=
 =?utf-8?B?WGhISlRQWUN0bmJwY2pMcHlEa2poV0Z3WUl2K1QwZER5elZYR0E1Z2Z2Vm15?=
 =?utf-8?B?bmdodHFvZTRBOWdab3ZOQVR6TFRSa292RThXellXYlYyYUFqY2dNR0svNDlq?=
 =?utf-8?B?dGVkQ01pd2xWZW9RVkl5RXEvODFIOXJ1Y0R1SnZrQnlUcGdPWmVFMTZCRllD?=
 =?utf-8?B?VjZFa1NrYXY5YXlEZU5CUTB0TXFhRlFHQU90Z0Qra285clJ0MWNsdU5ISU5w?=
 =?utf-8?B?cXhrZDZqM0dScGZXNmpnUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBuNTlUUy9TSjQ0N1d6T1ZxalJLUm1GbU1WTmUvTUphMnJ6SU0vYUVxTUJ0?=
 =?utf-8?B?UXBxY25PRC81RXdCNzd1RjhZWVVLRlY3QjFjbGJ1U0huT2U1VVFPUXZPYTBP?=
 =?utf-8?B?aHhOMDdKUnlvem1tWGVvZDNkSjNHNGJPMy8zZkg2NU1ESG9pQUJXMzhwWTJm?=
 =?utf-8?B?VENQUkFHcmRNZmxGVUJEV1FhM0o1aFdsdVdZV1ErSit0elFhQi9FRkUxVnVv?=
 =?utf-8?B?NTlOemZBZm90UlNYMDYwMDV1c013eTlpK01Cdm5Xd0EvWG41dysrNjI2SXNh?=
 =?utf-8?B?WEpjTWlPYU1vU25wUUpKcml4ekhlOThTR2UzNlZ6MFloZGZLUXpTei9OUUYv?=
 =?utf-8?B?dGc2UFR0Rnh1bzNBWUxNNnJId1lxbWFtNGFpVytreUZhVmtWMklqVk4zVHNN?=
 =?utf-8?B?RWFFZFZ2dk1HZ2I3QVhjZ1BwWjJOUHE1c3pkTnYxYktiM2ZGZm05RHlSM1JC?=
 =?utf-8?B?QVhVYzhjOXdSZ3lRSmRiazhtM3J1eTk2RldZVFdTZWI5Zy9PRDMyNlBlM3Zk?=
 =?utf-8?B?aElKbGJyNWEyem5WQnFhZy9PVE84TENFcnQ1MGd5cUhBRjhSTUdpczhWWmpE?=
 =?utf-8?B?S2svMEJBUCtIWUp0b2ljQTAvZDhQSzlCQ09Tc1dBVFU1anhKWGgrRzR6Q1NO?=
 =?utf-8?B?UGtoN0FUTVcrdFU4SXlsUHR3U1VkMUxHUWRrbGlmNWpoY1VMK1BLRThGaGdJ?=
 =?utf-8?B?VXhOVzJWZXZZSDlFSWpINk90UFpZY3FMMmVub0pTUHJLajNaUFhpRG10NWFL?=
 =?utf-8?B?amJpWlM0VkVRRmxFVUdTR2d5U3EyM2tYTWljbWtoUzdzLzhwVXFxdmZQeVk4?=
 =?utf-8?B?L1pKdjZVS290QVZZcjlrL09Qb2VRdGdlWVZkbXBYdGV4am9RdS9lUWF1cVhE?=
 =?utf-8?B?MGN6N215cGp4WmsxZHl0bXorcmg5cFBTVEQxRituVkVydThIL2dMN1NhWFF4?=
 =?utf-8?B?dS9ndUF2VzlqWTMycW9BYkU0UnFYdHFhd1RLcFZQZlFha0p4MTNZS2MzcDZP?=
 =?utf-8?B?V1RKaHB3akk1U1RiaW5QVFY2UllsN3JtM1JySHBWbEdwYXVYc1kvOWZTZnFp?=
 =?utf-8?B?TDNjc2VFL0NJNmEyR3g0cGozTjNBNVo2VG1MWXpLWVJtT1ErWEhWQzdwcVZv?=
 =?utf-8?B?bXJTUGY1dWNrZEVDNHBLVitEREx1QTl0UWVOcTAraEpLcWJVM1dWd2Rkencv?=
 =?utf-8?B?WDZnR2psWDI2R0h6V3I4OG4xTzhDZmlTbjVZM0NuandwSE1rVzRWOGVhS1RK?=
 =?utf-8?B?Rmx4cFM2c1FIeEZkblYvWkZ2YjZOa2theUhSc2wzbSs4VWdOWU9pc2p4eGEx?=
 =?utf-8?B?cW45L2dNT3lPUUtuRTRnT1dSU0F2bkhUWWs2bG8wT2U0QjVEUEYwMGVEOXlQ?=
 =?utf-8?B?bHpvRSs2aXIyYjdIZ1FYRzh4TEVJV3pvajIrZG9Jell1bmJZWnR0NmxuOVNY?=
 =?utf-8?B?aUwvNjJYazJxcXBNRlRRbzdJc3EzQ3FHaTRjU3Nna2lnS2srSW1DVDZLZEdJ?=
 =?utf-8?B?Zkx6RC9RMUZaUUFGVHBFNHlNNU9jZGVIbDNyWnFRZy9qM2tFRVpMZ2ZrRC9F?=
 =?utf-8?B?eWlOdjJTV2x6eHBPdnlKSWpaSEEvd091V0dRQkxHYUMzN3A2MnIzV0ZpWWdY?=
 =?utf-8?B?cjNkM2hpemxySGZXYzFRM3UrbVlscjA5dzQxVm1aMXB3T3Q5MlRrR2NUZU5K?=
 =?utf-8?B?MlpoSVY4aEkyYzJONVNVZ0d6YVNDOUdDcUNmVjhjMWZWL3JGd0VyYVA5eWZO?=
 =?utf-8?B?aFFJNk5sU2M0Mis5Q3N5UFdMWXVJcjl0cmVaTzJYMGpMWTdMVFI2S2dMQzRQ?=
 =?utf-8?B?MFE2d2dRbWlOMG8vMXBROG9ORVlPcms4dTR4K1U5aVpvOUpWZ3NDVkdWM0Qx?=
 =?utf-8?B?d2hsY2tVMGRVUFdQOHd1cVFuOVlNSXZIMG1xY1hqek4waGIzTXI1WHpudy82?=
 =?utf-8?B?US82d2lxbWp0TGxYaHErckdEamV6SUZiTlpreURxSHAwbWY4VmtJR0ZQb0Rr?=
 =?utf-8?B?VC9UR0ZRUE5LQ0hRMytjTVJzZWpGbjJ2alhiWG82ckcwMDdtRHZrd0pXdWpU?=
 =?utf-8?B?eUlXN0o5NVRQUkg3dWRZZWIzTEhzS1lTVHRYazVCZ0ZmYi90QjBVYVZoV243?=
 =?utf-8?B?bFJ1RDhqK3VnbmNjMmJSSmZNaHN2UnJ3L0R3MFBYUEtOWUtsdzdWdUk3ZjZv?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb13b2-725a-4a05-c5db-08dcb07bfa5e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:42:50.8986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnsRI1/6OmjR/etWtc+OGrUo4CNWaHDDEDsT1L2fm0z1BkK17TD8t7FVi4KGQNIhu8277ROcwBgz8C1SkzGm/j9EtmxVOxiwqWkSUlyRv9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
Received-SPF: pass client-ip=2a01:111:f403:2606::704;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/22/24 10:18 AM, Thomas Huth wrote:
> [Вы нечасто получаете письма от thuth@redhat.com. Узнайте, почему это
> важно, по адресу https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 31/10/2023 19.58, Kevin Wolf wrote:
>> From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>
>> As the previous commit changes the logic of "qemu-img rebase" (it's using
>> write alignment now), let's add a couple more test cases which would
>> ensure it works correctly.  In particular, the following scenarios:
>>
>> 024: add test case for rebase within one backing chain when the overlay
>>       cluster size > backings cluster size;
>> 271: add test case for rebase images that contain subclusters.  Check
>>       that no extra allocations are being made.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>> Message-ID: <20230919165804.439110-7-andrey.drobyshev@virtuozzo.com>
>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   tests/qemu-iotests/024     | 60 ++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/024.out | 43 +++++++++++++++++++++++++
>>   tests/qemu-iotests/271     | 66 ++++++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/271.out | 42 ++++++++++++++++++++++++
>>   4 files changed, 211 insertions(+)
> 
>  Hi!
> 
> Seems like this patch now breaks the iotests when running with -qed :
> 
> $ ./check -qed 024
> QEMU          -- ".../qemu-build/qemu-system-x86_64" -nodefaults -display
> none -accel qtest
> QEMU_IMG      -- ".../qemu-build/qemu-img"
> QEMU_IO       -- ".../qemu-build/qemu-io" --cache writeback --aio
> threads -f qed
> QEMU_NBD      -- ".../qemu-build/qemu-nbd"
> IMGFMT        -- qed
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth-p1g4 6.9.9-200.fc40.x86_64
> TEST_DIR      -- .../qemu-build/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/qemu-iotests-b84qth8b
> GDB_OPTIONS   --
> VALGRIND_QEMU --
> PRINT_QEMU_OUTPUT --
> 
> 024   fail       [09:14:06] [09:14:09]   2.9s                 output
> mismatch (see
> .../qemu-build/tests/qemu-iotests/scratch/qed-file-024/024.out.bad)
> --- .../qemu/tests/qemu-iotests/024.out
> +++ .../qemu-build/tests/qemu-iotests/scratch/qed-file-024/024.out.bad
> @@ -214,7 +214,6 @@
>  virtual size: 384 KiB (393216 bytes)
>  cluster_size: 131072
>  backing file: TEST_DIR/subdir/t.IMGFMT.base_old
> -backing file format: IMGFMT
> 
>  Fill backing files with data
> 
> Failures: 024
> Failed 1 of 1 iotests
> 
> Could you please have a look at it?
> 
>  Thanks,
>   Thomas
> 

Hi Thomas,

Thanks for the catch.  That seems to be a minor issue, apparently
'qemu-img info' doesn't report the backing file format field for qed (as
it does for qcow2):

# qemu-img create -f qed base.qed 1M && qemu-img create -f qed -b
base.qed -F qed top.qed 1M
# qemu-img create -f qcow2 base.qcow2 1M && qemu-img create -f qcow2 -b
base.qcow2 -F qcow2 top.qcow2 1M
# qemu-img info top.qed | grep 'backing file format'
# qemu-img info top.qcow2 | grep 'backing file format'
backing file format: qcow2

I think we can just filter the field out and remove it from the expected
output.

Andrey

