Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEA9CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIIN-0004IF-BL; Tue, 04 Nov 2025 09:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGIIL-0004Hu-FX; Tue, 04 Nov 2025 09:46:01 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vGIIJ-0001XU-2E; Tue, 04 Nov 2025 09:46:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbvRRenkNn13T7eMyGOAwxZFD0hVWR5xhPJGwNI9mpYTSOhq3kfLL4mZ8f3GF3kybbqW57IXH9X75YS8cz2iQ2HHo2H2+eBhkds4dCFUlMiO/sZJG3LV8UmJ7AZ4Cv84M3syTTOXkV3Po4HMHHLTuLJmkQc1JXFkDLopN07RmknzaEoCm/aJjKSyJ2PiZ+Uspg5oKFNNEhXxPQKS6wUoxpX+d9uPOytHPAYNTJ727BCeH7n3K7LvaaFJTK2L9BXkXMw9R3pzi64kGiQR1dfv1tR7vFNMGX7JGFCwNu81JR+INcDvnTmZdpm6UC2by8NuDpU5sJdvnvMutfkfbTaKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OK5n4jGM5jqMykq+beiaTDts47aBk5iOXAuiR1hH+c=;
 b=j1vdcwTkdCEn0n8pmxyH6ePSbTTXJmUUQwfRON+vtxXHAG5l5cqjwanCm/qqgBxmCsWpuNZv/hOfikTg1Lrc2HeXm5LpuwYBpdDwWTo9033zNcLIYzyjlDAL853FWIS0Ox5EDZ4DFZr/MBM4Fb7CMScplFmZ+AGWqGBIvswwuSEWU/aN+HtlMrlWqXB852GsJ1PJWDKjVxZXqQ2IZwcf8wc+sEuZtM6W5UTmSeKxHDIdM4aOgHpLNKrEzfAj3eFHuTQr1/0msVQYeAwVvrRMRTwvpYRcReyVp4HJlML2TyOqSLi+yxs5KDpjYhtM4sCQy7coHW4+Lb741uRONQhK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OK5n4jGM5jqMykq+beiaTDts47aBk5iOXAuiR1hH+c=;
 b=THbjYYQ59iyc0hopN2lXyPvaIAa43RscnXwODl+pb6zIUQh2IU1ecP/edUiJhD4fzv0aKN9HWHP4YWj4ttL8qTQ9Sy758DYOV19NbApm9dg8X+G/IRVKrZhVohvyRJA6kyMk/1dmVfMtmLw3CzR1Y5eyuQwgnn0A2A8X+LVV0Ch543E/TXQjjxYDFaJheHTOT3YxwvbTGVK9zq6BbuT1LXo9hDD1uZApDyhmJeWsfLItsLMtkDwI6n/9/eC4Zs/V6IVvmC3Al2zpt/gG/babVRf5sWGRDuvDQVbzV8PU94+V2gvYojs38d3COHQzBQWq/1nEPHI6PDRrjbg2PsawAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:45:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 14:45:52 +0000
Message-ID: <eecefa8e-44ae-45ff-85d0-3f9b786948e0@siemens.com>
Date: Tue, 4 Nov 2025 15:45:50 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6.1 5/6] scripts: Add helper script to generate eMMC block
 device images
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <60f265e0b2bea18fe6ef41742600a7e933e3c47f.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: c90e66e9-d346-48ff-f5e9-08de1bb0da04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEMvTmZVTisyUmVNYjNabnA5YjJRWW9FMHpSTy9DdWFmeHZ4bmlQcXFvV3d0?=
 =?utf-8?B?Qk81RytWOEVNR0wyRlkzb0ZKeGRyM2ZuK0lxL0R1eU83S09QdWp4ODFnd1dr?=
 =?utf-8?B?VzV1blU0VDN1SE8yTmRDbDZxMWZHQnBTczM5THlKZnhKdkNZQmEzemxhUFRn?=
 =?utf-8?B?QVduTjhydVl0T0F5c1dNQ2Zua2l2Y2hnNHh5UlRGTlpCM0lVc2NUVDhLN3I1?=
 =?utf-8?B?dGx4THdmYjBqMnZvV1c2NDhXNVJoTVk5OUluMnFFbklvTkdkbjB5L0QrN3FS?=
 =?utf-8?B?OTVLeCtUUGxsanc4V3lESEpaUkZoYzhPRVdwOXFDNDN4RGxwdlNUUnZ1eUps?=
 =?utf-8?B?MzhRUElkNmR2bE5MS20zSyt0eFFNdjQyZjNHbUw0aFFwOGhUQWpxa3h1OVRN?=
 =?utf-8?B?SUpURUtnT3hWTUxLRnNqT01RT21qcTViOHhYc2hOWGNxU3dHaHdxOEliRTRD?=
 =?utf-8?B?aVkzRnRxNHhta2ltUnZjTTRleGo2YXlYUkxRcldtS2F1bUpPWXlMTHdrOC9z?=
 =?utf-8?B?NUhLZm8wN20rTXJFU1dYUlpYS040QXdCMW1NUlJmQWRRK2MzUlNic3M5WkxQ?=
 =?utf-8?B?VlJ4eElOc2I4cG1xWG1rQTllNnhIM2oxRU9sbDMwbzNvZ29KMFZWUnEwdHZC?=
 =?utf-8?B?dVZrNjJGQzk4ampMeE1nRnEzZ2I2TXpSZ3FPRDdYbEFlNjFMbWsxTnpQR2tw?=
 =?utf-8?B?bTNhT2ZHa1BzczJlS1RKalp0ZmhTKzErcXMxYzIyWWk0aVFwNkZlRklPenM0?=
 =?utf-8?B?czNObkhETFRZZnF6d25EV1U0U0M3YVI1ZjdxT1Rvc1JVR240MlBYRjFZK1dB?=
 =?utf-8?B?amhxTTVJUUY4SDJFY1RqeWVBbU53SmI0V1FEK3I2MElQenhNdStMVXRNTlhR?=
 =?utf-8?B?WjVSZUVrcXBrdjgzRmhnc003SmFZMHBDdzNRaFJmN2w2bU9TY0NZdCtDaG1G?=
 =?utf-8?B?Y01DYUVYZExWVUxPQ2lrNmpJWTQ2aXlML1N5eTVBNW1QTzQ3SWxpTkY4djBM?=
 =?utf-8?B?RzhjU2xtTmYxY2lvZmlJNmlmYzZaNzdnVEwzcU5BRk5JZUMzMlRrajRadkZQ?=
 =?utf-8?B?YkRWNU9lNzRkZXprZ3RVMUZFOTQwOGFvNXV4bVBlaFR4UmhLQXcvMVBxL1VE?=
 =?utf-8?B?ekEzWWNNUGN2UlJSckdLSFd5Ukh2Q083VE1selQvQmNUajhIcVFoK3I5eUs2?=
 =?utf-8?B?V3Y5cnFaanpjZHlmdG1jVnBZaStsTHRMclJHNzBZNFI0RitYSlJZVncvdi96?=
 =?utf-8?B?Y1ZsWFZWdXQySXJRU045RGEwczF4U09KR2dTMkJtM1BXWmhJb2Vhd3VuYndQ?=
 =?utf-8?B?ZkFkWkZCNzBGMnY0Y0xKWEFsSmg3djlKNFlxMFRla3ZSUUNuY29iMS9OM3BU?=
 =?utf-8?B?Y2Z5b3J0azdpRmwwQmRYOHI4dkI2elJkVGEyV3YxSi9mODgrKzNxMHd6L1lK?=
 =?utf-8?B?WkRyTDVRWGsyQ3VyU0o3UG9KbnVHS0ZKUEFUUnA2S0ZkaU8xVUdXcTJ4amx6?=
 =?utf-8?B?UGdHVjMyR21COUlENnI5Q2hlcjNWTzRHUEc1VWM0Q0srcFFuU2hrang5WHdm?=
 =?utf-8?B?T04yQ3diMit6NERwZkJrMis4OFF4NlYrVXI5TTVYSVpWenk3YjBBaXQwNmFm?=
 =?utf-8?B?N1VYajZJL2pVM0ROKzVnQVZINlZUVytTVUthUGo0Y1ZvWXRzOHhCSTJiUUtM?=
 =?utf-8?B?YlpGNFArbmpiVWo2K243Z2hDTmZ6ZkNVOXZQeDFRcjZDUndUbysxQlRDZWhx?=
 =?utf-8?B?bDd6Wkg0dDQ0Z2JaUCtNRkE3Ukx2WjRhVmJSSkRKNmloRnIzTGtkNTU3MHRl?=
 =?utf-8?B?UW1ZWDZrZDFRbk5LNExsNStyV3pWYzdlVGVpOTNzd3NnNVlkUGdVUmNlSkI0?=
 =?utf-8?B?bjBaVGU1SXFpYjJkemo2N05Fdk9iRi8xZlEvYXZ0THJpakNvSnArY3V5cDlO?=
 =?utf-8?Q?GiMhh0xfwYa8HgzKlqZCmhVmrIRibCHK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFRsWXZ4L2lySDMxdzMrZEVkNHl6bVhoSTJnSzlvTndyWDBoRjM0R0pRQ0Uz?=
 =?utf-8?B?QmRDRXNkK0VIemFjL1ZEZDFON25LdHZYWE0xeXRDNTkxd005cmlRaGJDZTBk?=
 =?utf-8?B?OUJMWVBUSWc5dkxORS9aaEY5REhOTTkzZ3R5dE5lTnhydUs2Zmh2b2oyUUVW?=
 =?utf-8?B?T0NXUVJNY2ErUWFQQ2JudkdUWlFidXZKVDJLZ05kUG8vRVd4SFVFVWdDWDV3?=
 =?utf-8?B?WW04ZXE0QUhUeVR1OURBZ2hNdEhSbWRJamR5ZkZzeDBUWlZwVHZVYmRIOTBs?=
 =?utf-8?B?RzJqSGRoaGZDbm00Z0p3di91WEd6M1VtREI4RGxmeWFaWWdueUl0MHA2YVdp?=
 =?utf-8?B?L283T09aRzNBY1hzcG12UHVPekVGUXVMSVQ2ZWp1Y3VzYSt6Q0Z3ZG5sU3Rv?=
 =?utf-8?B?R001TnNKMFc5MmhSajJyc0pSL0NIbmtZajYxbzdGT1VFR1Q4VVQvVjAxYWo3?=
 =?utf-8?B?cWhiQlN2eXU4SWtqODNjQmJmcWN4V0VISWsrdHVXNWExNk1Qa2dOYjA2QkRk?=
 =?utf-8?B?elFsV2NvMkhwbFdkTzN3Rm1HWDE4UTVBNnR3M2pkQTJNeWdVZ3hLWnRUZ0pH?=
 =?utf-8?B?c1pOamdmY29XOTRqa0xmMmVPd2F4dDEwbWZXQ2VDTGtRS0Z1WWpQUzFMQkJX?=
 =?utf-8?B?SWRnaUZUTzZsYjNDeWpRaWZvaytuR0loN3NIZ1hNV0c5ejhKZHVMZG1rVGt3?=
 =?utf-8?B?ZVNCNDJ5cyt2MlJPK1RUQTNhM1F4dHlORzJZbTQvZXNCNU55Yjdabkd5QzVK?=
 =?utf-8?B?MEtYQnJhQUgxN1FhdjUwNi9yWnBNSXNQTHpoS1ZoTDd2cUowcWxjRi9JbGlP?=
 =?utf-8?B?Y0hoQVZqS3pJeVcyOTlBZnBOeStKNkJIVWtGV3I5MDZFalN6VGkvNWF3MXFz?=
 =?utf-8?B?YUI3bXBLcUZtcU9EYnlxOVBQY1RaR2tSYlRzUlNLMVRsaVR5VXpWd3Y2WGF2?=
 =?utf-8?B?ZGVxalNyN0NaeXdxeU13NmZKUFNLbFo0ZnJLS2xnZm1SUG5DUitFbGxWTnFZ?=
 =?utf-8?B?WkwvQ1JHUHNuRktsOXZPNm5yczNSTmpzcDZvWnlBdFlFRWRUUVFlSUl6SFdu?=
 =?utf-8?B?aVJYTWZqQUlWK2xIbDRNamh0TURVYjBSWktCdUltbmYvSHprUk1XcG5zU2lQ?=
 =?utf-8?B?V0tQWVJzSW5vekVPK2ZrUndVNEU3Nnc0d2xMeWVhTFNLSTNmNm51OTRBNDFM?=
 =?utf-8?B?VWJqV3NjMnVQLzhNZ1JncnFxdHpSd1d6QkFFa3g1TTZrZ2Y3QXFQT3N1cmdo?=
 =?utf-8?B?dXM0UTNsNlFaYjlNY04yV1dqem1ZNFpKbFRBdmZHWk9qKzBNaDNDdGRyREx2?=
 =?utf-8?B?ekRqaFppVnQ4ZUVsWUgwU29HeHc3ZjRqZUhWeEZwVWFBU01Gcm1Eay82cFl6?=
 =?utf-8?B?MEp1VkZUbUZIWU8zNUF0NlF1eWMzMjN0MGFra3NCdmZWVStYM0xJc04yUmsx?=
 =?utf-8?B?L0x1eXRyc00xSFVJNGo1c3hHT1Q5UmFQM0hSRm81VWpJMlo0OEc1VDVua3Z0?=
 =?utf-8?B?S21xTDBCd2dFcGRVcFJ6VE8rS05xUXdrK1BkQmpSQmpDb1RrQStza25zZTNV?=
 =?utf-8?B?SDhpOVgrTXRXeUI2d2RSSy8xV0dzN3FObEtIY3FyaXl1VnVBUFFEOVFHaWlB?=
 =?utf-8?B?SzdXbnA3RkJnWDdjQnRqMjZlNVljQlpRSjFIT1RYQk5hT25MVk00L3FoVUdF?=
 =?utf-8?B?RTduVUk3cnJzTW9WU1dXRitYa29wV08ySXpsWHRWc1lZcjhxaXVCaEh4S0lZ?=
 =?utf-8?B?SDBkanhmNTNZZGlPc3RTUzRIYU1xTVdaTG1qR21qSit4d2prOUNWVUVxUllr?=
 =?utf-8?B?dFN2SitvRy9hbWhzRHArSGxNQjdqUGtkd3JZVWlxRVd6YzFJTSszcU5kMGww?=
 =?utf-8?B?cjBoZ2V1clk5OWptQ0pFWnRHVS9BZzhPQ2pDbktMRkdKSHZXMEQ0aXhBWWJO?=
 =?utf-8?B?SkxWWWxkYTZSNDVQNWxLbmFqWWhrWFhsSzNINnNEUzlTYlBXYVZVZks5aGxX?=
 =?utf-8?B?Q0JyY3dLQTZQczV1TGt6ZUVKbjBhWHV1UXZrdXM1d1QxTkN0ZGg0dnFoN0Rx?=
 =?utf-8?B?RXMweEM4YkZzc2ZOQ0IvZ2toRnNGNG41TmJQQTZyUkowNVp0Tlp3UFlaR1NR?=
 =?utf-8?B?RmFrb2FPVEF6NU90ck9xckF2UVBxSWxtc05EUk1SdjR5cEs5WldsNEhWVi9w?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90e66e9-d346-48ff-f5e9-08de1bb0da04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:45:52.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK+dxaKcX9tTmxs3tYUKo7ilHWLUEz3FEvswhitjF21CmblOot8owJxsLr4cM5WtCKKTwcTHC5K/SkmZfJnaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9508
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

As an eMMC block device image may consist of more than just the user
data partition, provide a helper script that can compose the image from
boot partitions, an RPMB partition and the user data image. The script
also does the required size validation and/or rounding.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v6.1:
 - address BSD shell portability issue of stat -c

 scripts/mkemmc.sh | 219 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100755 scripts/mkemmc.sh

diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh
new file mode 100755
index 0000000000..45dc3f08fa
--- /dev/null
+++ b/scripts/mkemmc.sh
@@ -0,0 +1,219 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Create eMMC block device image from boot, RPMB and user data images
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# This work is licensed under the terms of the GNU GPL version 2.
+# See the COPYING file in the top-level directory.
+#
+
+usage() {
+    echo "$0 [OPTIONS] USER_IMG[:SIZE] OUTPUT_IMG"
+    echo ""
+    echo "SIZE must be a power of 2 up to 2G and multiples of 512 byte from there on."
+    echo "If no SIZE is specified, the size of USER_ING will be used (rounded up)."
+    echo ""
+    echo "Supported options:"
+    echo "  -b BOOT1_IMG[:SIZE]   Add boot partitions. SIZE must be multiples of 128K. If"
+    echo "                          no SIZE is specified, the size of BOOT1_IMG will be"
+    echo "                          used (rounded up). BOOT1_IMG will be stored in boot"
+    echo "                          partition 1, and a boot partition 2 of the same size"
+    echo "                          will be created as empty (all zeros) unless -B is"
+    echo "                          specified as well."
+    echo "  -B BOOT2_IMG          Fill boot partition 2 with BOOT2_IMG. Must be combined"
+    echo "                          with -b which is also defining the partition size."
+    echo "  -r RPMB_IMG[:SIZE]    Add RPMB partition. SIZE must be multiples of 128K. If"
+    echo "                          no SIZE is specified, the size of RPMB_IMG will be"
+    echo "                          used (rounded up)."
+    echo "  -h, --help            This help"
+    echo ""
+    echo "All SIZE parameters support the units K, M, G. If SIZE is smaller than the"
+    echo "associated image, it will be truncated in the output image."
+    exit "$1"
+}
+
+process_size() {
+    name=$1
+    image_file=$2
+    alignment=$3
+    image_arg=$4
+    if [ "${image_arg#*:}" = "$image_arg"  ]; then
+        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
+            echo "Missing $name image '$image_file'." >&2
+            exit 1
+        fi
+        if [ "$alignment" = 128 ]; then
+            size=$(( (size + 128 * 1024 - 1) & ~(128 * 1024 - 1) ))
+        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
+            size=$(( (size + 511) & ~511 ))
+        elif [ $(( size & (size - 1) )) -gt 0 ]; then
+            n=0
+            while [ "$size" -gt 0 ]; do
+                size=$((size >> 1))
+                n=$((n + 1))
+            done
+            size=$((1 << n))
+        fi
+    else
+        value="${image_arg#*:}"
+        if [ "${value%K}" != "$value" ]; then
+            size=${value%K}
+            multiplier=1024
+        elif [ "${value%M}" != "$value" ]; then
+            size=${value%M}
+            multiplier=$((1024 * 1024))
+        elif [ "${value%G}" != "$value" ]; then
+            size=${value%G}
+            multiplier=$((1024 * 1024 * 1024))
+        else
+            size=$value
+            multiplier=1
+        fi
+        # check if "$size" is a valid integer by doing a self-comparison
+        if [ "$size" -eq "$size" ] 2>/dev/null; then
+            size=$((size * multiplier))
+        else
+            echo "Invalid value '$value' specified for $image_file image size." >&2
+            exit 1
+        fi
+        if [ "$alignment" = 128 ]; then
+            if [ $(( size & (128 * 1024 - 1) )) -ne 0 ]; then
+                echo "The $name image size must be multiples of 128K." >&2
+                exit 1
+            fi
+        elif [ $size -gt $((2 * 1024 * 1024 * 1024)) ]; then
+            if [ $(( size & 511)) -ne 0 ]; then
+                echo "The $name image size must be multiples of 512 (if >2G)." >&2
+                exit 1
+            fi
+        elif [ $(( size & (size - 1) )) -gt 0 ]; then
+            echo "The $name image size must be power of 2 (up to 2G)." >&2
+            exit 1
+        fi
+    fi
+    echo $size
+}
+
+check_truncation() {
+    image_file=$1
+    output_size=$2
+    if [ "$image_file" = "/dev/zero" ]; then
+        return
+    fi
+    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
+        echo "Missing image '$image_file'." >&2
+        exit 1
+    fi
+    if [ "$actual_size" -gt "$output_size" ]; then
+        echo "Warning: image '$image_file' will be truncated on output."
+    fi
+}
+
+userimg=
+outimg=
+bootimg1=
+bootimg2=/dev/zero
+bootsz=0
+rpmbimg=
+rpmbsz=0
+
+while [ $# -gt 0 ]; do
+    case "$1" in
+        -b)
+            shift
+            [ $# -ge 1 ] || usage 1
+            bootimg1=${1%%:*}
+            bootsz=$(process_size boot "$bootimg1" 128 "$1")
+            shift
+            ;;
+        -B)
+            shift
+            [ $# -ge 1 ] || usage 1
+            bootimg2=$1
+            shift
+            ;;
+        -r)
+            shift
+            [ $# -ge 1 ] || usage 1
+            rpmbimg=${1%%:*}
+            rpmbsz=$(process_size RPMB "$rpmbimg" 128 "$1")
+            shift
+            ;;
+        -h|--help)
+            usage 0
+            ;;
+        *)
+            if [ -z "$userimg" ]; then
+                userimg=${1%%:*}
+                usersz=$(process_size user "$userimg" U "$1")
+            elif [ -z "$outimg" ]; then
+                outimg=$1
+            else
+                usage 1
+            fi
+            shift
+            ;;
+    esac
+done
+
+[ -n "$outimg" ] || usage 1
+
+if [ "$bootsz" -gt $((32640 * 1024)) ]; then
+    echo "Boot image size is larger than 32640K." >&2
+    exit 1
+fi
+if [ "$rpmbsz" -gt $((16384 * 1024)) ]; then
+    echo "RPMB image size is larger than 16384K." >&2
+    exit 1
+fi
+
+echo "Creating eMMC image"
+
+truncate -s 0 "$outimg"
+pos=0
+
+if [ "$bootsz" -gt 0 ]; then
+    echo "  Boot partition 1 and 2:   $((bootsz / 1024))K each"
+    blocks=$(( bootsz / (128 * 1024) ))
+    check_truncation "$bootimg1" "$bootsz"
+    dd if="$bootimg1" of="$outimg" conv=sparse bs=128K count=$blocks \
+        status=none
+    check_truncation "$bootimg2" "$bootsz"
+    dd if="$bootimg2" of="$outimg" conv=sparse bs=128K count=$blocks \
+        seek=$blocks status=none
+    pos=$((2 * bootsz))
+fi
+
+if [ "$rpmbsz" -gt 0 ]; then
+    echo "  RPMB partition:           $((rpmbsz / 1024))K"
+    blocks=$(( rpmbsz / (128 * 1024) ))
+    check_truncation "$rpmbimg" "$rpmbsz"
+    dd if="$rpmbimg" of="$outimg" conv=sparse bs=128K count=$blocks \
+        seek=$(( pos / (128 * 1024) )) status=none
+    pos=$((pos + rpmbsz))
+fi
+
+if [ "$usersz" -lt 1024 ]; then
+    echo "  User data:                $usersz bytes"
+elif [ "$usersz" -lt $((1024 * 1024)) ]; then
+    echo "  User data:                $(( (usersz + 1023) / 1024 ))K ($usersz)"
+elif [ "$usersz" -lt $((1024 * 1024 * 1024)) ]; then
+    echo "  User data:                $(( (usersz + 1048575) / 1048576))M ($usersz)"
+else
+    echo "  User data:                $(( (usersz + 1073741823) / 1073741824))G ($usersz)"
+fi
+check_truncation "$userimg" "$usersz"
+dd if="$userimg" of="$outimg" conv=sparse bs=128K seek=$(( pos / (128 * 1024) )) \
+    count=$(( (usersz + 128 * 1024 - 1) / (128 * 1024) )) status=none
+pos=$((pos + usersz))
+truncate -s $pos "$outimg"
+
+echo ""
+echo "Instantiate by appending to the qemu command line:"
+echo "  -drive file=$outimg,if=none,format=raw,id=emmc-img"
+echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"
-- 
2.51.0


