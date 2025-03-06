Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26212C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCyq-0001Wq-Sa; Thu, 06 Mar 2025 10:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tqCym-0001WC-9E
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:17:44 -0500
Received: from mail-am7eur03on20723.outbound.protection.outlook.com
 ([2a01:111:f403:260e::723]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tqCyi-0002ag-N6
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:17:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsVpk9LAl46uyYEBVIzws8PoWFKUaDmOevoRU6Da/GSZpw3iSGzf5oY3YFuJRK8qv1DpO3LyZawRQi8UVjJPZnRff+dQz3r511MbVKuh9nRCAZQPlXXLF1y4Qh1StOxVe9AkGvxVz4ZvKAdFm6c//htyDQGfWl5jKVcsRfVvChXrIlHC30+6On4agsXZpybH65HkzhA+yNLdEJypEmHMsGF6G+8tign3K5ysvPFwEa+p1xkFWIDOlYO5jXxfic8vjGUGWwKa0RHPDOVU2YxmW5LF61dxWy0fmjX/8tjb7JeLG6kvHCZiaAurveD44bD8SUSXhZ4v+u6J658uoiONGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hlna0wy++OS2ecbkZ7qD629m6HJvGAacyG3vySWNdU=;
 b=sI0R0MJnrkxWbvAXIVosXDtJKf+KvVK1pQ1dH8p6s+VvyawjB32LPSFv5Qe0HdewsflPgB6VjOqOSrEhpHLOmUygL3o/JCPWT2xWAsHNai28xtdeyAM0+vSCqJxatjdA6jl8vVb9D4dYmXJSS8Mvv8xDlyE73qSvvyl60BYvtuKKSyCM/f9JezU3o0rd+UEnd1T5lvNL9CPvEF7uPDQKgpZw1wRYfqhdsivxkVmJydpUOiasnWmVHtyeLxkafIP7ehoc10T+3FvfMeoVT0spT0yJHDg2ckTB/HAsdUsOKOnD1Hl7yEOkyIwZmQFZXNVg1LN9rFAbm4ktFSVNzDHRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hlna0wy++OS2ecbkZ7qD629m6HJvGAacyG3vySWNdU=;
 b=Ebn/PBDXHBkjEToJD7us01BascA+tMacoeks7jwBCTasrB0HARLOmgaKZ0B18/vyCBxI0jhPz1Y6a6+y4VzN/x56RHcbNwQQYsJ1GhQPLIYz5tcLchqwskjqSY7I7xpBsu925qRdflnZDynUy52K8Ue+MHVw+spw1soeL7melOl5b6bVHwRxqhYZag2jnGqJFPFPBLDjPdOzIwcAUT9SM4MyQVmsnUmdbDeuhwVU9eDc3YVyMp4sAmrMOSCabuKmHDWGzjnt4M0S0VIVHY5ANaHhXmBmSTZmsv5DybbhJVLVA7NQcSf6vZaZsHDjk5+I7md47T3/O578FddQHF+Lqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU5PR08MB10437.eurprd08.prod.outlook.com
 (2603:10a6:10:524::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 15:17:34 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:17:34 +0000
Message-ID: <9f3fe262-fdab-4c01-9117-e9795444fe20@virtuozzo.com>
Date: Thu, 6 Mar 2025 17:16:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
 <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU5PR08MB10437:EE_
X-MS-Office365-Filtering-Correlation-Id: d73419a3-a89f-40d6-e3a4-08dd5cc2054c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUVsdzEwZjVyWjJhUkNXdG41c3NNWmNhS2QzRi8wWlNzOUh3Y1RhVDJqbFlx?=
 =?utf-8?B?b0RLMEJxaXVEZjBscXhuY3NpNGt6b3pQVGlPRTVmWXBCYy9wRmdwUnAyeEZB?=
 =?utf-8?B?TDM3NWpwVGIwcE8xQUt1enVMRmRrSW9QOWFnbkZ2VTh6TUFxNnBLZ250S0hP?=
 =?utf-8?B?OVlnby8vb3VlTDh4M0l4a0tQZEdIbjV6ZHc3SDk5UmVGM2hFQ0cyd3NzY2U4?=
 =?utf-8?B?c21rNVk4cEdCNmZNRmd2Y0JOT0RPWUk2VWcrYXV6c0xlNEZkUG1XVmJXNWNi?=
 =?utf-8?B?T01wbi9NVUExNHg0K25UWkc4WDZ5WkMrQXkrbkZTM2dVek5haDQvV2E3Ti94?=
 =?utf-8?B?b2NGMFR3ZEQ5ZHUwM1BPYk9QdURiQmZHN2hIWldwcXY0Q0JITFkxUTBKb3Jr?=
 =?utf-8?B?K1dkcjM5dndFcFlhbmFhNktEM1lTNmtsTDJmOGRHcGtiekpWT0dpdmdFd0Nh?=
 =?utf-8?B?ejh6cXlORzQ2cG9sb3haeUxMMHNZaERBanJ3dmRjVDZXMHNjQ0wxQ2VxcENz?=
 =?utf-8?B?RHBuMlFHUmZtYXphRzhvK2tERHlOUmpqdGlxcEVQOGNxZEZ2TWxaSkZrSUE1?=
 =?utf-8?B?T0k5RlFOSjR2U21tL0F5NTRDWnBNWkUwWUQyMTQvMVM1cFgxdm5HdVdmOWI2?=
 =?utf-8?B?N0lBMHZTUmcxcGZMcHJvVGF3bUN3QWVRbytJRER4VXhleVF1akVIbzBxeUc2?=
 =?utf-8?B?eHY4V0V0Y28zUWF6aTliME5UV3ZvSzFCOHVJcFhacmc2eld6dGJqb3VYRlYx?=
 =?utf-8?B?TE9PcWJleDh1TzhOcW92eE01cUYzM2xxOEZMeHJvV3ZONXRwMWhWUHhySmhG?=
 =?utf-8?B?emUwVmVQQlJ4SGgrdGZ2MzIzRXBEN3pCRTBZUS9SZm9Oa2toQ1BqZzZoTVR0?=
 =?utf-8?B?ckF6NFVsVjVXK0RoMkRSUTFEVnpnQktrQ01YTGtSTFVYMEdFcEs4bFQzY2Y1?=
 =?utf-8?B?UGVXcmJPbW9oQkpXL0l4MkllUVhiZmFzL292eTJjQzgwQ3I1Y1g0Tld1ZTV5?=
 =?utf-8?B?VGhFRXBQZkU0RHN0UFJCd0ZSRndBMXZTOTEzeUVTYUhyQmlhZUpxTWJjT3pT?=
 =?utf-8?B?OGo0ZmVaQ2hQQkpJMWRnNGM1d2FwckR4MkpTZjdOTTQ3WEtTWUI0dy9MVUs5?=
 =?utf-8?B?K2ZtN3c0bTdyYXZHZ2JqSzh3RVc3cGp1SzJZeEFNZmtxVm1LUWxoS3luTC9t?=
 =?utf-8?B?VGd5dlo5VGl1VUNGcVczT0tkTm1laGxmZFRKOHcxT0pXZ3FUMWlYVXJYRDJG?=
 =?utf-8?B?OHM1MkZiMjVtejl4UERVcHZtU0FvVFphT1AvTW9MVG8rZnljT0piUGFuV2Fn?=
 =?utf-8?B?TWQ4bHczeHh6LzFET3VONExTVjBSSnJTTXY3bWVUbjdYUjQrMnhnRnZKTm5n?=
 =?utf-8?B?WlYzNnpreEowaW1sbzg1MjR2bUNROEk0YnRHQ1dEcSs5ODBKZys3dUZlbjRF?=
 =?utf-8?B?VUs5NUNXNEk2b0pBMURIUUpjRXhxZkM3VCtUQ2dCb0tKUUtianRRVjJiWkd6?=
 =?utf-8?B?WkpUOXFWbFNCd1BSU0E3QXJ0UkNXdkJFS0ZnMTM2NkNYNjE4U0hsd0l4UjZo?=
 =?utf-8?B?Z3VyYTEremI1R1JEaXV3cWxYR0trdllYWWMvQUsxTDYyYnhhdDFMbWhPUDVa?=
 =?utf-8?B?eGd3Q3JneGI2UTVTc2JWNXM1WVBtV205VURnbUdMVXQ4WDh2cS9yeC83RGp4?=
 =?utf-8?B?d0N0Wnh5YlVEVktMOTFUMy9sWWsvL211UURJYUFvZEVHMVlWRWR6VWVJMVpI?=
 =?utf-8?B?Qll3bCtqQlBMcHZxeGp1WjdoM21QY1FCeHRSd3lDVzRiUjBKYUlpSDdvSXRQ?=
 =?utf-8?B?NXBYTUtQN3VDalpDRzVZUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktIOS83SFE3UEdOUFFrS1JKZ2JEcnBLS3RVUDd5OExtcG1IOXc2ZXVaOGFn?=
 =?utf-8?B?VmdzQVRmTlJXd0x2QVRWSW9qVFVkSVN4SXB6djVDd2plaDVNdG83RjVqcTU2?=
 =?utf-8?B?OWF2RzVmaEhsMGFBYmxxV1F0Z0NhQSttb0lIcjhBU3VOa0hqYWEyVmVBMHNQ?=
 =?utf-8?B?dnUwaGp2Nlh2aEpYT3BPMXJUdSs4VFh3THlSeVhTVUFISEZaUGxTNFdiQUJo?=
 =?utf-8?B?cUxWSEhnaU9qRDJDQ2xLMTc4TkhRanJ0S2J4bW1iaG9zYklvWmI1bFBwdm1t?=
 =?utf-8?B?anJkRVplOVpsd1ppbG1aTUVMVUc3YWJZZm1Cdk1uenpsMDlVYVEzb3k1T2RD?=
 =?utf-8?B?NUdEQVRPemZtSHNPVnJUWndsY1pGT1VOUFdEY0F4TmEweXN3bDg3WjNyeE1y?=
 =?utf-8?B?cTl6bmkwbE9pTitnVElobVc0MVpGLzRhS1pvZ2dqRWtINkpsQkp2WjdVeDZB?=
 =?utf-8?B?bDRMbEgrejJhOGhyTC81L0dzYXJpVEtibk0wa0F1b214bE5LZzNaSmd2RnVU?=
 =?utf-8?B?SFRYYUtJQjUrWEp6R29tQlMrY3Z6S0tTR0VEaWM1V3piVTNsVzEwU2Z3OFIw?=
 =?utf-8?B?ZU52UmtJSlArZmtGaWo4ZmZsOFY0ZXVQL1Z3RmVzNDRqdCtlbVpUM3FlL01n?=
 =?utf-8?B?NEhzbjhUZzg5eHlBS2thd2JiTC9WMlpUdXY5RkhiaFY5Lzl1ai9HRzVnbTkz?=
 =?utf-8?B?OGV4UE5SaCtxQld3aFg1NDlSa2E0ckdXQlNaR3Q5MzRxZG93VmNzWDhzM29x?=
 =?utf-8?B?eWU1Q0Zoazk4VUNCalp4V1FqZ001NWsyMDdzcHllYnIvVXhvN3lQUHRJbDJx?=
 =?utf-8?B?UjZHZ291RFIrYTZabFhNcnFNUHlsRFRvMFlCQTZSQzh2VmRTSGltWm9qSXR3?=
 =?utf-8?B?dERjZnBBZzM4NDdOTGt3YUhGQVBXR2tQeWQ5SW1mK2xGdXYyZnJiektBeHhB?=
 =?utf-8?B?MjZlTXNIalRpd1E1dGtYc1pRck5HWEV6WFkyNjkzUGdkTCtnTWJkNE1DSnRl?=
 =?utf-8?B?Z3V4cjRJbzZtZXBSbmVPZnkyM05Xd2tuOWNlS2NOck9QM0ZieDV6eWxWdUJN?=
 =?utf-8?B?TnptOFZ4eXhZall4SllqR1hPTTcrOUZHcEc1dHg2REFLbVhoNDQzcy9xMlZr?=
 =?utf-8?B?WmJudFhJTmF1RzlKQjdmVnpnWU5jM0s4NEY3NHluZlBweUFpWmxNQWtzenEr?=
 =?utf-8?B?dTB6VWtDSExMRFdxc2s4SXhBMm8raGFvcUJYdUtSaTlrTDVkdmJEVDVIbUI5?=
 =?utf-8?B?Rm12b2djOGdybk1ZTUlkZUNUT3BpMlo1WmEvL3pnVkp6S2NpY2x6WkxaY2p1?=
 =?utf-8?B?R3JsTk1LdlJxcWVVMkd3aCtvRjFmeTVqTWZRMjF0L1FTeUxEek15U2FKSXlm?=
 =?utf-8?B?OEJCV2dIbHpxc1NZSjFhNUJybFJtUnBPVXkrZ0FvcldPU2sxeWRacGJ6d3BT?=
 =?utf-8?B?eVpoSE1pZlRCczRkMEhnL3RlZmx6c081R3M5WXJsRnFMa0Z1cWNvSE5lVzNX?=
 =?utf-8?B?dC9ZNmNrZUdRMkROOXp2Myt1eFNsRVlRRllnVm8wZyt2Wm5BaVVPajlUdGFV?=
 =?utf-8?B?WmRXRWdEZmJEY1BOQ2d0d0lycTNQVkZuNHNPWk9aeUZ1U2QxVldzYlRqNWhO?=
 =?utf-8?B?cnl3b0d2YkJoeHRIL0o2SDBuODA0eFFGVTVGR1FkK2hPaU5kV2wxSHgrZ0ZS?=
 =?utf-8?B?ZWQ4MzdodUdmQ011eW5CTGNsZThMQ3dBKy9zK0dVVEo5aXNLMmxUZzlBZDhW?=
 =?utf-8?B?UVM4N3VSaVMzcHBkeHA0TTE2NXFHTVA4bXZXNUpDbGNXL2xianBjZ09SaUlI?=
 =?utf-8?B?bVZwcE5NZnRzZldNRStCNm1HNGFNTE4zNS9iTlh2VEgvZEVBSFVia1MyelJM?=
 =?utf-8?B?MHBZVkdjajZzeUdaUWxoMlFkQ0pqT1NqNERqcVB0aG1VOXJHQWJnOWVuTmRW?=
 =?utf-8?B?WHFnL2tBZVYvdHpmcjB1LzNRZTRjbTgzWWQ1MUJmQ2xGQ2NTZE8rM1p4ZmVz?=
 =?utf-8?B?NVcrYnZodnptMlc4enZraUtRUW5rS2RocjZKcUxRM2kreS84Q2pLVGdyUXJl?=
 =?utf-8?B?M3BNMElnNWxBMzdhWHlBZjNlZlZodFN1QjBKNy9oYkwvMWFFcXczQ0RSSytK?=
 =?utf-8?B?RFk4enhJdnZwMDZtaWxYY1hLeVlNRG9EVVAwZ2g3Q0xkMU80bkNuNmJLYVc5?=
 =?utf-8?Q?ug0JC251uHxH4t5Gy+JY3jk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73419a3-a89f-40d6-e3a4-08dd5cc2054c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:17:34.1494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBik3bqIuN6x4sP2uo/V1Xo4XDF5yZy3f3BsYSLGG+iitQpRzAhG77zbbd2ukgXZq9KPu2CIIb/7dzLR/GYCf76Os67VSjmP7wawYhgTIOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10437
Received-SPF: pass client-ip=2a01:111:f403:260e::723;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

On 3/5/25 11:19 PM, Steven Sistare wrote:
> On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
>> On 3/4/25 9:05 PM, Steven Sistare wrote:
>>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>>> and
>>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>>
>>>>>>>> Run migration source:
>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>
>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>        -machine q35 \
>>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>>        -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>> dev/shm/
>>>>>>>>> ram0,share=on\
>>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>        -nographic \
>>>>>>>>>        -device qxl-vga
>>>>>>>>
>>>>>>>> Run migration target:
>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>        -machine q35 \
>>>>>>>>>        -cpu host -smp 2 -m 2G \
>>>>>>>>>        -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>> dev/shm/
>>>>>>>>> ram0,share=on\
>>>>>>>>>        -machine memory-backend=ram0 \
>>>>>>>>>        -machine aux-ram-share=on \
>>>>>>>>>        -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>        -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>        -nographic \
>>>>>>>>>        -device qxl-vga \
>>>>>>>>>        -incoming tcp:0:44444 \
>>>>>>>>>        -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>>
>>>>>>>>
>>>>>>>> Launch the migration:
>>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>
>>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>>        migrate-set-parameters mode=cpr-transfer
>>>>>>>>>        migrate channels=[{"channel-type":"main","addr":
>>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>>> dst.sock"}}]
>>>>>>>>> EOF
>>>>>>>>
>>>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>>>> following messages:
>>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>>> 0x00000001)
>>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>>>> allocate VRAM BO
>>>>>>>>
>>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>>> min_halo@163.com/T/
>>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>>
>>>>>>>> (the latter discussion contains that reproduce script which
>>>>>>>> speeds up
>>>>>>>> the crash in the guest):
>>>>>>>>> #!/bin/bash
>>>>>>>>>
>>>>>>>>> chvt 3
>>>>>>>>>
>>>>>>>>> for j in $(seq 80); do
>>>>>>>>>            echo "$(date) starting round $j"
>>>>>>>>>            if [ "$(journalctl --boot | grep "failed to allocate
>>>>>>>>> VRAM
>>>>>>>>> BO")" != "" ]; then
>>>>>>>>>                    echo "bug was reproduced after $j tries"
>>>>>>>>>                    exit 1
>>>>>>>>>            fi
>>>>>>>>>            for i in $(seq 100); do
>>>>>>>>>                    dmesg > /dev/tty3
>>>>>>>>>            done
>>>>>>>>> done
>>>>>>>>>
>>>>>>>>> echo "bug could not be reproduced"
>>>>>>>>> exit 0
>>>>>>>>
>>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>>> that
>>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>>> lead to
>>>>>>>> crash on the source VM.
>>>>>>>>
>>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest
>>>>>>>> memory, but
>>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>>> corruption so far.
>>>>>>>>
>>>>>>>> Could somebody help the investigation and take a look into
>>>>>>>> this?  Any
>>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>>
>>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>>> Try adding these traces to see what is preserved:
>>>>>>>
>>>>>>> -trace enable='*cpr*'
>>>>>>> -trace enable='*ram_alloc*'
>>>>>>
>>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>>     https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>>> email-
>>>>>> steven.sistare@oracle.com/
>>>>>>
>>>>>> - Steve
>>>>>>
>>>>>
>>>>> With the traces enabled + the "migration: ram block cpr blockers"
>>>>> patch
>>>>> applied:
>>>>>
>>>>> Source:
>>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>>> 0x7fec18e00000
>>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>>> 0x7fec18c00000
>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>> fd 27 host 0x7fec18800000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>> fd 34 host 0x7fec18600000
>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>> fd 36 host 0x7feb8b600000
>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>> 37 host 0x7feb8b400000
>>>>>>
>>>>>> cpr_state_save cpr-transfer mode
>>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>>
>>>>> Target:
>>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>>> cpr_state_load cpr-transfer mode
>>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>>> 0x7fcdc9800000
>>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>>> 0x7fcdc9600000
>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>> fd 16 host 0x7fcdc9200000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>> fd 14 host 0x7fcdc8800000
>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>> fd 11 host 0x7fcdc8200000
>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>> 10 host 0x7fcd3be00000
>>>>>
>>>>> Looks like both vga.vram and qxl.vram are being preserved (with the
>>>>> same
>>>>> addresses), and no incompatible ram blocks are found during migration.
>>>>
>>>> Sorry, addressed are not the same, of course.  However corresponding
>>>> ram
>>>> blocks do seem to be preserved and initialized.
>>>
>>> So far, I have not reproduced the guest driver failure.
>>>
>>> However, I have isolated places where new QEMU improperly writes to
>>> the qxl memory regions prior to starting the guest, by mmap'ing them
>>> readonly after cpr:
>>>
>>>    qemu_ram_alloc_internal()
>>>      if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>>          ram_flags |= RAM_READONLY;
>>>      new_block = qemu_ram_alloc_from_fd(...)
>>>
>>> I have attached a draft fix; try it and let me know.
>>> My console window looks fine before and after cpr, using
>>> -vnc $hostip:0 -vga qxl
>>>
>>> - Steve
>>
>> Regarding the reproduce: when I launch the buggy version with the same
>> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
>> my VNC client silently hangs on the target after a while.  Could it
>> happen on your stand as well?  
> 
> cpr does not preserve the vnc connection and session.  To test, I specify
> port 0 for the source VM and port 1 for the dest.  When the src vnc goes
> dormant the dest vnc becomes active.
>

Sure, I meant that VNC on the dest (on the port 1) works for a while
after the migration and then hangs, apparently after the guest QXL crash.

>> Could you try launching VM with
>> "-nographic -device qxl-vga"?  That way VM's serial console is given you
>> directly in the shell, so when qxl driver crashes you're still able to
>> inspect the kernel messages.
> 
> I have been running like that, but have not reproduced the qxl driver
> crash,
> and I suspect my guest image+kernel is too old.

Yes, that's probably the case.  But the crash occurs on my Fedora 41
guest with the 6.11.5-300.fc41.x86_64 kernel, so newer kernels seem to
be buggy.


> However, once I realized the
> issue was post-cpr modification of qxl memory, I switched my attention
> to the
> fix.
> 
>> As for your patch, I can report that it doesn't resolve the issue as it
>> is.  But I was able to track down another possible memory corruption
>> using your approach with readonly mmap'ing:
>>
>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>>> (gdb) bt
>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70,
>>> errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70,
>>> errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70,
>>> errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70,
>>> value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70,
>>> v=0x5638996f3770, name=0x56389759b141 "realized",
>>> opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:2374
>>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70,
>>> name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:1449
>>> #7  0x00005638970f8586 in object_property_set_qobject
>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized",
>>> value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>>      at ../qom/qom-qobject.c:28
>>> #8  0x00005638970f3d8d in object_property_set_bool
>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true,
>>> errp=0x7ffd3c2b84e0)
>>>      at ../qom/object.c:1519
>>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70,
>>> bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>>> #10 0x0000563896dba675 in qdev_device_add_from_qdict
>>> (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../
>>> system/qdev-monitor.c:714
>>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150,
>>> errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0,
>>> opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/
>>> vl.c:1207
>>> #13 0x000056389737a6cc in qemu_opts_foreach
>>>      (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca
>>> <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>>      at ../util/qemu-option.c:1135
>>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/
>>> vl.c:2745
>>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40
>>> <error_fatal>) at ../system/vl.c:2806
>>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948)
>>> at ../system/vl.c:3838
>>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../
>>> system/main.c:72
>>
>> So the attached adjusted version of your patch does seem to help.  At
>> least I can't reproduce the crash on my stand.
> 
> Thanks for the stack trace; the calls to SPICE_RING_INIT in init_qxl_ram
> are
> definitely harmful.  Try V2 of the patch, attached, which skips the lines
> of init_qxl_ram that modify guest memory.
>

Thanks, your v2 patch does seem to prevent the crash.  Would you re-send
it to the list as a proper fix?

>> I'm wondering, could it be useful to explicitly mark all the reused
>> memory regions readonly upon cpr-transfer, and then make them writable
>> back again after the migration is done?  That way we will be segfaulting
>> early on instead of debugging tricky memory corruptions.
> 
> It's a useful debugging technique, but changing protection on a large
> memory region
> can be too expensive for production due to TLB shootdowns.
> 
> Also, there are cases where writes are performed but the value is
> guaranteed to
> be the same:
>   qxl_post_load()
>     qxl_set_mode()
>       d->rom->mode = cpu_to_le32(modenr);
> The value is the same because mode and shadow_rom.mode were passed in
> vmstate
> from old qemu.
>

There're also cases where devices' ROM might be re-initialized.  E.g.
this segfault occures upon further exploration of RO mapped RAM blocks:

> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
> 664             rep     movsb
> [Current thread is 1 (Thread 0x7f6e7d08b480 (LWP 310379))]
> (gdb) bt
> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
> #1  0x000055aa1d030ecd in rom_set_mr (rom=0x55aa200ba380, owner=0x55aa2019ac10, name=0x7fffb8272bc0 "/rom@etc/acpi/tables", ro=true)
>     at ../hw/core/loader.c:1032
> #2  0x000055aa1d031577 in rom_add_blob
>     (name=0x55aa1da51f13 "etc/acpi/tables", blob=0x55aa208a1070, len=131072, max_len=2097152, addr=18446744073709551615, fw_file_name=0x55aa1da51f13 "etc/acpi/tables", fw_callback=0x55aa1d441f59 <acpi_build_update>, callback_opaque=0x55aa20ff0010, as=0x0, read_only=true) at ../hw/core/loader.c:1147
> #3  0x000055aa1cfd788d in acpi_add_rom_blob
>     (update=0x55aa1d441f59 <acpi_build_update>, opaque=0x55aa20ff0010, blob=0x55aa1fc9aa00, name=0x55aa1da51f13 "etc/acpi/tables") at ../hw/acpi/utils.c:46
> #4  0x000055aa1d44213f in acpi_setup () at ../hw/i386/acpi-build.c:2720
> #5  0x000055aa1d434199 in pc_machine_done (notifier=0x55aa1ff15050, data=0x0) at ../hw/i386/pc.c:638
> #6  0x000055aa1d876845 in notifier_list_notify (list=0x55aa1ea25c10 <machine_init_done_notifiers>, data=0x0) at ../util/notify.c:39
> #7  0x000055aa1d039ee5 in qdev_machine_creation_done () at ../hw/core/machine.c:1749
> #8  0x000055aa1d2c7b3e in qemu_machine_creation_done (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2779
> #9  0x000055aa1d2c7c7d in qmp_x_exit_preconfig (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2807
> #10 0x000055aa1d2ca64f in qemu_init (argc=35, argv=0x7fffb82730e8) at ../system/vl.c:3838
> #11 0x000055aa1d79638c in main (argc=35, argv=0x7fffb82730e8) at ../system/main.c:72

I'm not sure whether ACPI tables ROM in particular is rewritten with the
same content, but there might be cases where ROM can be read from file
system upon initialization.  That is undesirable as guest kernel
certainly won't be too happy about sudden change of the device's ROM
content.

So the issue we're dealing with here is any unwanted memory related
device initialization upon cpr.

For now the only thing that comes to my mind is to make a test where we
put as many devices as we can into a VM, make ram blocks RO upon cpr
(and remap them as RW later after migration is done, if needed), and
catch any unwanted memory violations.  As Den suggested, we might
consider adding that behaviour as a separate non-default option (or
"migrate" command flag specific to cpr-transfer), which would only be
used in the testing.

Andrey

