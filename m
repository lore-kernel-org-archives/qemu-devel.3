Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91644C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDXI-00079y-L3; Thu, 06 Mar 2025 10:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tqDWV-0006Zi-5c
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:52:38 -0500
Received: from mail-dbaeur03on20725.outbound.protection.outlook.com
 ([2a01:111:f403:260d::725]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tqDWS-0006r6-0u
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:52:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpk/XdTaR2HG+nSgmH4uus0rRgOuadChb1IcVYFCQKe9dcv5TnmQ4UShw6kqx35xVi2CKZ2FtTAfMVZOdkoQHqf+aeDJJyvN+rT5t+A799Ofh/lVsKgejmoc/btvVqYw+2DekQVYNvr2DYDfd7eU/vHPgwQlXRzxoyXiI3r0nTTcUcxoSYtFuR5mu/XwqkLiNu5FW03hvVEJqT/Ot6JYhTm6/ULXUbUiyRv7yvMGsMr8ecGp3UTlg0sladt1KQyHly2cbPApoZNPBEzePWvdAOpWatj9ro/aXDp+f4AapeV9+F7wBiTmuIJL5lQgQ8406vCHFBJLctcnfSbdmWyk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyAK0Xkg4mVeuykwi3AH8EhtOUbTdQggZkDwLilOYLY=;
 b=G/v57+Lu1/3qQ4hy+3fdXRpYSyCB1aZrdZi9cuN96DFlO2cP83pOen2J+ngHKbm6XEMF4bAHr+kO2wbX+q1eW+KUvuiua39yWOWo/kSEylGgjcJUxy4f5F2nkzc5M53gGknnQY0D1KGnW7vXqoy4OAQzAshLuZR3zcFL0TsfApI6JQo3izyo8O/HCHkfnIReYkeoGUugWcUHJsXJIub8bznAEX4msNHOwJZMk1yp+T+GvOP9I964CajQvYLBv9Fuiamj3gcT5c49ZF52y1rUm6EO+W9vZC8GXIsg0DE3Ui46ST2Tdh2iLHzSt1KrARl1V23QVGTKVwrTY0xNdMAczQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyAK0Xkg4mVeuykwi3AH8EhtOUbTdQggZkDwLilOYLY=;
 b=azBlzvG4TA3/Efw9sHRpGmCHr+ocfC81eJcIQDCeGvYxfOut8GR+ot3TQyG6f0rY49BjzCgzfL1F+XWO3msy5Avp8mURpv/jci3s5h1T7G71F+avrtTSFOg6Idpbj2b7+q1/u6UdLjD7yO38PojtpMNAMQxMuJoU7HDjBdl26CyCTVYrnFrQ/k9cQIWFsaVJAqPPwmoJMexBW6Vt2YRSum6xSnvMWwpI2IXLz2xnxP+nw1vX7D+HzdWhfnphZY4AG3OP32+7lMBacaG0zxJpnqPunLnTVQQKxtQEdGfoUk8bZEpWp3mNH1sJZiN+gkd9LPj/eGDxrFeSKZu0s/cfkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB3PR08MB9900.eurprd08.prod.outlook.com (2603:10a6:10:43e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:52:25 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 15:52:25 +0000
Message-ID: <24677eb1-dbe6-4e0a-980b-9c38d4decde8@virtuozzo.com>
Date: Thu, 6 Mar 2025 16:52:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
 <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
 <9f3fe262-fdab-4c01-9117-e9795444fe20@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <9f3fe262-fdab-4c01-9117-e9795444fe20@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0070.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::47) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB3PR08MB9900:EE_
X-MS-Office365-Filtering-Correlation-Id: abf0c4d4-1e6c-45ee-c2b4-08dd5cc6e3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3RoRnN0V3QxVDhFQ1NJbU5UNDc2RkZzcFpzQ0RNMnlFU0xqUldjQVA2Wml5?=
 =?utf-8?B?T3R3ZDQvT2I2R0Zyd3E0OUk0R2x1N3VIMWxGdlRZU0Y2TFJyV0xPRjRsMkgw?=
 =?utf-8?B?S3dYY2Q3TkNTL1FZZUpZOWhOc3htak4yb3lHeEdWMjk2M0JEdEZZODF3QWVX?=
 =?utf-8?B?NTliZy9GdEhuRTlTSFpGeTNCSkNwUmMvb2JaRkh0OXZkb3hibkJzcmNPekE2?=
 =?utf-8?B?d2diV2hqcGRBYU5lNzVVa24rTC8rdWJ6V0MraXovKzZRMWJkT0hoRnRIL3N6?=
 =?utf-8?B?c2JSdzBYVmM4YmZNY2xURjRwbzNxNC9NK0dYNHduT2VNYlJiVTFhMWFzeGRm?=
 =?utf-8?B?cXdSUlhpbjNrRHNSNXZiNC8wejZWTkx5aVBzbFkvZ3RkandTY0dDMjRyUGt5?=
 =?utf-8?B?NUpaeFdFZjQ5SFlMOEdINUNmRTNMRVBiQ28waUFVTUJCU3g0NkR4dXhQQTRS?=
 =?utf-8?B?Wit6REhsU3RHMzZIWlRFblUrS09HOERwTUs0czJkRUZhT2xCWFU2eWhpWVlM?=
 =?utf-8?B?TExacnZBd3ZlQ2U5V01tSSs2c2o3bXBmcGoyUXVDNG1JSEFDekNsWUpXY3Zp?=
 =?utf-8?B?eVkzN0dzYVl2VnlxQzlWdEJPZW4rdm9YWHVQYlhoeHNmcG5rWkVIa1ArM3ln?=
 =?utf-8?B?U3cwM1Q1dFNOZTRxZGhaRHBVRWdjbExpb1M2R1d0cTU2dW94SHpCajdVSGdj?=
 =?utf-8?B?ZncvSVplYndnS0x0d01wVi8wR3VNMHZFSlRXR1hVQmhKYmg4TGE1eWoxeFZI?=
 =?utf-8?B?TURMMlJpWEo4VEUycElCSXZNZ3ZlYVJWKytFOEUrVWxXS0lIZjl1NU1pK1I0?=
 =?utf-8?B?clkyK0NqMGZpa1RSOVJDam0wV1hYYnowajNlRHJBTDVoeW1WbVE5S0pJTTcv?=
 =?utf-8?B?NVBCMEVoNnFWM3VDUzhXcmJvSmFnei8vQXV2M0dGcml1VEFMd0dvZ0RTcTk2?=
 =?utf-8?B?YWQwUWRDWjZyNnBwcktWN1E3dWNWdGx0N2d2M1hBR0dKdTJUSFdFeFRYNzVq?=
 =?utf-8?B?YmlaeGlxQUZkYmJLNTNkK3M5aHdMdGNmRmJHdmtUV0RCQnlOSXVoOE44WE5k?=
 =?utf-8?B?UCtjM2VqNEppc2t4Nk5CVTNtamtwVEtRVmFXSzZSazJkV1EyRzd5dWdGT1ZI?=
 =?utf-8?B?c2grREhlTmJZMFRmZHVXRDcwOCtnUW5yL3VaUnI2SFRBS1VmenBWN2wzR04z?=
 =?utf-8?B?dWUrNHpxaUVuUGZUNXdKYXhuNng3WUlScXhPVGpISjluMktpUHhyNVRDb1Yw?=
 =?utf-8?B?YlhZSVRhYjFGUXdyUXhiQ3lwSFViU1dPeEVOVlZNN0gxY3gydEF3aS9MekhW?=
 =?utf-8?B?TmZoRXdFVUxrenlZRG0xMERlWTBZL1pVZFcweFFrMEM4NS80aGl0UnJkcFMw?=
 =?utf-8?B?amRTa2k4MzVKMWxoR291MHhaUUhNMjVIM2k2Vk8zN09jMkJOZ0h5VXlGbTJy?=
 =?utf-8?B?RU1WWkRnZzlIZExNblRZYndTQ3g2Qks0RU1vRHQvaFRoUFYrMVcwOWQ4TjZF?=
 =?utf-8?B?Z2NWczE1VHVFSkpwcDdtb0R0cm5NR3lteFBycjIybXhTM0VVeDRRRHU4aEFO?=
 =?utf-8?B?OUxLZXZwYVcwcUM0REFBSzNiV1FQRVFyRDZ1am9heG0zNzFPOGRWZjVDOHRI?=
 =?utf-8?B?WTR6ZlpBdFkrbUJOZmZua1N5TU1zQXZwaFdyczRQbzlQSmNnTXlvdnVkZFQw?=
 =?utf-8?B?YXJEN0FISk1janlYa1FGWHhueGxDVnVnRWZnK2c0ejh5UUpHWk5WNUg0dVM3?=
 =?utf-8?B?dVoxaEVCV29NdlBVamVPRGd1TE1NTzE1N3dCUDBFcWRoTW1hcDhMT1JkL0Rz?=
 =?utf-8?B?NVAwQ0g2ZE1mZnZjZGRhdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUxjdS84WHJEN2FTN2FnZ01nM0k4T3o3RDMrR28yUHlIUzBDSUlKWUJ1TDVq?=
 =?utf-8?B?SnU1bXNZV2tkdmp0TFhHb08rbHdFV09la0prK2VydnArbml5SmFUYW5VREZy?=
 =?utf-8?B?VCsxWTgrYnd4aVd3YWFqM3R5UUVEN0FoZEhDUFFvd2sxeWZiWVVpNlF5YVM3?=
 =?utf-8?B?ZENvZlZPblZXL1N5YnVGS2JVVEdjRVJ4N3NXMVZBSDJOVlRGZ3dnNW5haVVC?=
 =?utf-8?B?bkhkdlcwUUIyS1hBZ3lJRXMwVFpKSE5UQWNLaE9udmRQZUpJUFFyYVdJbEZ6?=
 =?utf-8?B?WG9YaWZZOW9qNEVGdVhZQTRFYTdaVDNiT3F5NkwzdGdndDFBS1FDWHl3QVRF?=
 =?utf-8?B?ME8xaGZ3MnQ0OGczOFB1VmtLY1RmbWsxWFN2MnNhdldCRFB5L2pDako5Wi9v?=
 =?utf-8?B?UzRUZS81NndmMjA4bm1mdE9OMHhrZjVOTGVXU2xhZTN5K3BTNFk2bjVrcTBW?=
 =?utf-8?B?ZW1DVmlZdWZkNVJTakFvZHFHVzErV1BiMUlwa3d5MmhIV3U0TkU4cVhxeUxX?=
 =?utf-8?B?N09rbmRHM29zOTZURkZKcmdYTkhSSzQrOTBqUnplTkhrNGhJR2pSeUdvVXMy?=
 =?utf-8?B?aStOZmpBdlR1VDZqMHNoQWdoZC9Cczk2SjNvbGk0eVBReVkybUJJWFZKRWZt?=
 =?utf-8?B?THRXU2N4ejdMQkN6SEk2Sk1qS0UxYVgySW1FVi9hdWFhR21mVkZVYnVjVUZi?=
 =?utf-8?B?UGR5MXk3SlAvMjBZWjNmeGFJaURuUTNrdG9ra29IemdMdEcrcFNiUjh5NGhX?=
 =?utf-8?B?cXkzM09mS1hOUzJtMlM4SDFXU1JOc013MUU2SGNIMlNCZG5weXBEWncwRk42?=
 =?utf-8?B?czhTSHJDcFg0QlM5S0puRjlqRWJ4eGVialN4MS8rVFFsNERVRmE2Z2ZmQ2lP?=
 =?utf-8?B?VFVtMUN1MjZMYW1ZSUlObmk1Qk94U0hQV0p0UDJwYzd2S0pvdklmMExUUmRi?=
 =?utf-8?B?cTJpVzF3c0dja1Z5YlhFMjNsUFBxdlhjUGFMdW1HQzUwZDBFR2FkN0FwVVVY?=
 =?utf-8?B?MGVNS1BpUDZYQjVqY05Icm1zTmRycklyT1h6dmVWbi96RWJrSFVHczBWVkx3?=
 =?utf-8?B?dTlEZDVVWlR5RmdOVXBIUmRXc0M5anlnM0k0SUFxbXJmVlBiY2FPeElqOGVw?=
 =?utf-8?B?S2NNYzZqMDVaV2czNlh4UFo4VittUHNZSXBoTHp2Q1M3OFprM2hSMzFDVFdz?=
 =?utf-8?B?dEgzU2MyK1dnQUd0NVZ6MnM0S0N1TWpscldxbDF4Z0dteUJMbEs0KzQ4WUtF?=
 =?utf-8?B?U1ZLNVZ3MXRTeUxDWStteUtWK0FmQ3JWa2U1K242YlJrcVY3U1lpamNlOEF0?=
 =?utf-8?B?ZUF2TlFHeG03SVVlM242RUd1KzlLcFRpbFpNOVF4RVJTallFc2oyWnJQZmV5?=
 =?utf-8?B?NVhrVVNRanlTK2QyOWpoSTkreVlCVUFUZFZ2L0UrbU5wY1pXNk9tUnI4VDZz?=
 =?utf-8?B?d3U0TnltblhNbHVZdS9iK0VyT0Ivc1M3aGtteTBDMmJxdGYwWDFXUDlZYzhB?=
 =?utf-8?B?eGhQVVpzZkd1WTUyS29aUzJ0ZzJ3TXk2enl5THhDdkxHTzR0N3lKVWdha0cw?=
 =?utf-8?B?M2VIeXVwc0hLdmhXUVRNbjFvTXFaM0pEcWNUN0xxZEhha0UvZlc3cXdPbTF0?=
 =?utf-8?B?d2YrT1JkVkM3R0h2aTdCUStFYjdld3JPVkxFTzVhYXRHcHFSY0pJamdndDVs?=
 =?utf-8?B?UVUxWjNINlNsaHlzb25tcjJIZVpoMGJORjBPN2xwWEkyODNBZ2xmeDdtTmJT?=
 =?utf-8?B?eTdUOThXSFZEYSswcm5FQzlmR05vY1E3a0NDYVJmWHVubUtzUlhqYTBVVXli?=
 =?utf-8?B?NmlobG12S1llZTdUN2hTcGVTYmxjWE5XUXgvY0taNUhUUU1IQkRMWFAzbUNy?=
 =?utf-8?B?ZEhSWGZENi9uaDV0dmdWTEVrMC8vQ0IxZ3oyYWlHd1d6aFRpMnZGeml3UldF?=
 =?utf-8?B?MSt4UHYxRGxRd3ZVV3JsYzMrMTlDM1Qwa3BQcEx4SXpLVmlZSDlpTVNjbnVw?=
 =?utf-8?B?Tmx1Mm1RVVhsWVRrWmRBdnVCeWxLeUVVd2p2UlY0U056ZVFFZmhTOW01UC9F?=
 =?utf-8?B?TUs3TzA4TC80Vjd6L0JYUmFUdXl4L0tqeklZd3RpRjhpcitSTWpJVldoaVBN?=
 =?utf-8?Q?PMgXP7/dxX79IabtvrgEN0rMx?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf0c4d4-1e6c-45ee-c2b4-08dd5cc6e3dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 15:52:25.4551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rJtnjvlOOlCh3XxPkObFgP9kqu5tKMghoU2ZKr98LrQBrLoUfKafZbJ1eDySpcjXTLtwFn0nTsiX+ZBcfz3Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9900
Received-SPF: pass client-ip=2a01:111:f403:260d::725;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 3/6/25 16:16, Andrey Drobyshev wrote:
> On 3/5/25 11:19 PM, Steven Sistare wrote:
>> On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
>>> On 3/4/25 9:05 PM, Steven Sistare wrote:
>>>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>>>> and
>>>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>>>
>>>>>>>>> Run migration source:
>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>
>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>         -machine q35 \
>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>> dev/shm/
>>>>>>>>>> ram0,share=on\
>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>         -nographic \
>>>>>>>>>>         -device qxl-vga
>>>>>>>>> Run migration target:
>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>         -machine q35 \
>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>> dev/shm/
>>>>>>>>>> ram0,share=on\
>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>         -nographic \
>>>>>>>>>>         -device qxl-vga \
>>>>>>>>>>         -incoming tcp:0:44444 \
>>>>>>>>>>         -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>>>
>>>>>>>>> Launch the migration:
>>>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>
>>>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>>>         migrate-set-parameters mode=cpr-transfer
>>>>>>>>>>         migrate channels=[{"channel-type":"main","addr":
>>>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>>>> dst.sock"}}]
>>>>>>>>>> EOF
>>>>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>>>>> following messages:
>>>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>>>> 0x00000001)
>>>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>>>>> allocate VRAM BO
>>>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>>>> min_halo@163.com/T/
>>>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>>>
>>>>>>>>> (the latter discussion contains that reproduce script which
>>>>>>>>> speeds up
>>>>>>>>> the crash in the guest):
>>>>>>>>>> #!/bin/bash
>>>>>>>>>>
>>>>>>>>>> chvt 3
>>>>>>>>>>
>>>>>>>>>> for j in $(seq 80); do
>>>>>>>>>>             echo "$(date) starting round $j"
>>>>>>>>>>             if [ "$(journalctl --boot | grep "failed to allocate
>>>>>>>>>> VRAM
>>>>>>>>>> BO")" != "" ]; then
>>>>>>>>>>                     echo "bug was reproduced after $j tries"
>>>>>>>>>>                     exit 1
>>>>>>>>>>             fi
>>>>>>>>>>             for i in $(seq 100); do
>>>>>>>>>>                     dmesg > /dev/tty3
>>>>>>>>>>             done
>>>>>>>>>> done
>>>>>>>>>>
>>>>>>>>>> echo "bug could not be reproduced"
>>>>>>>>>> exit 0
>>>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>>>> that
>>>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>>>> lead to
>>>>>>>>> crash on the source VM.
>>>>>>>>>
>>>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest
>>>>>>>>> memory, but
>>>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>>>> corruption so far.
>>>>>>>>>
>>>>>>>>> Could somebody help the investigation and take a look into
>>>>>>>>> this?  Any
>>>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>>>> Try adding these traces to see what is preserved:
>>>>>>>>
>>>>>>>> -trace enable='*cpr*'
>>>>>>>> -trace enable='*ram_alloc*'
>>>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>>>      https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>>>> email-
>>>>>>> steven.sistare@oracle.com/
>>>>>>>
>>>>>>> - Steve
>>>>>>>
>>>>>> With the traces enabled + the "migration: ram block cpr blockers"
>>>>>> patch
>>>>>> applied:
>>>>>>
>>>>>> Source:
>>>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>>>> 0x7fec18e00000
>>>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>>>> 0x7fec18c00000
>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>> fd 27 host 0x7fec18800000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>> fd 34 host 0x7fec18600000
>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>> fd 36 host 0x7feb8b600000
>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>> 37 host 0x7feb8b400000
>>>>>>>
>>>>>>> cpr_state_save cpr-transfer mode
>>>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>>> Target:
>>>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>>>> cpr_state_load cpr-transfer mode
>>>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>>>> 0x7fcdc9800000
>>>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>>>> 0x7fcdc9600000
>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>> fd 16 host 0x7fcdc9200000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>> fd 14 host 0x7fcdc8800000
>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>> fd 11 host 0x7fcdc8200000
>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>> 10 host 0x7fcd3be00000
>>>>>> Looks like both vga.vram and qxl.vram are being preserved (with the
>>>>>> same
>>>>>> addresses), and no incompatible ram blocks are found during migration.
>>>>> Sorry, addressed are not the same, of course.  However corresponding
>>>>> ram
>>>>> blocks do seem to be preserved and initialized.
>>>> So far, I have not reproduced the guest driver failure.
>>>>
>>>> However, I have isolated places where new QEMU improperly writes to
>>>> the qxl memory regions prior to starting the guest, by mmap'ing them
>>>> readonly after cpr:
>>>>
>>>>     qemu_ram_alloc_internal()
>>>>       if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>>>           ram_flags |= RAM_READONLY;
>>>>       new_block = qemu_ram_alloc_from_fd(...)
>>>>
>>>> I have attached a draft fix; try it and let me know.
>>>> My console window looks fine before and after cpr, using
>>>> -vnc $hostip:0 -vga qxl
>>>>
>>>> - Steve
>>> Regarding the reproduce: when I launch the buggy version with the same
>>> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
>>> my VNC client silently hangs on the target after a while.  Could it
>>> happen on your stand as well?
>> cpr does not preserve the vnc connection and session.  To test, I specify
>> port 0 for the source VM and port 1 for the dest.  When the src vnc goes
>> dormant the dest vnc becomes active.
>>
> Sure, I meant that VNC on the dest (on the port 1) works for a while
> after the migration and then hangs, apparently after the guest QXL crash.
>
>>> Could you try launching VM with
>>> "-nographic -device qxl-vga"?  That way VM's serial console is given you
>>> directly in the shell, so when qxl driver crashes you're still able to
>>> inspect the kernel messages.
>> I have been running like that, but have not reproduced the qxl driver
>> crash,
>> and I suspect my guest image+kernel is too old.
> Yes, that's probably the case.  But the crash occurs on my Fedora 41
> guest with the 6.11.5-300.fc41.x86_64 kernel, so newer kernels seem to
> be buggy.
>
>
>> However, once I realized the
>> issue was post-cpr modification of qxl memory, I switched my attention
>> to the
>> fix.
>>
>>> As for your patch, I can report that it doesn't resolve the issue as it
>>> is.  But I was able to track down another possible memory corruption
>>> using your approach with readonly mmap'ing:
>>>
>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>>>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>>>> (gdb) bt
>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70,
>>>> errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>>>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70,
>>>> errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>>>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70,
>>>> errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>>>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70,
>>>> value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>>>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70,
>>>> v=0x5638996f3770, name=0x56389759b141 "realized",
>>>> opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>>>       at ../qom/object.c:2374
>>>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70,
>>>> name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>>>       at ../qom/object.c:1449
>>>> #7  0x00005638970f8586 in object_property_set_qobject
>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized",
>>>> value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>>>       at ../qom/qom-qobject.c:28
>>>> #8  0x00005638970f3d8d in object_property_set_bool
>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true,
>>>> errp=0x7ffd3c2b84e0)
>>>>       at ../qom/object.c:1519
>>>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70,
>>>> bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>>>> #10 0x0000563896dba675 in qdev_device_add_from_qdict
>>>> (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../
>>>> system/qdev-monitor.c:714
>>>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150,
>>>> errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>>>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0,
>>>> opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/
>>>> vl.c:1207
>>>> #13 0x000056389737a6cc in qemu_opts_foreach
>>>>       (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca
>>>> <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>>>       at ../util/qemu-option.c:1135
>>>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/
>>>> vl.c:2745
>>>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40
>>>> <error_fatal>) at ../system/vl.c:2806
>>>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948)
>>>> at ../system/vl.c:3838
>>>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../
>>>> system/main.c:72
>>> So the attached adjusted version of your patch does seem to help.  At
>>> least I can't reproduce the crash on my stand.
>> Thanks for the stack trace; the calls to SPICE_RING_INIT in init_qxl_ram
>> are
>> definitely harmful.  Try V2 of the patch, attached, which skips the lines
>> of init_qxl_ram that modify guest memory.
>>
> Thanks, your v2 patch does seem to prevent the crash.  Would you re-send
> it to the list as a proper fix?
>
>>> I'm wondering, could it be useful to explicitly mark all the reused
>>> memory regions readonly upon cpr-transfer, and then make them writable
>>> back again after the migration is done?  That way we will be segfaulting
>>> early on instead of debugging tricky memory corruptions.
>> It's a useful debugging technique, but changing protection on a large
>> memory region
>> can be too expensive for production due to TLB shootdowns.
>>
>> Also, there are cases where writes are performed but the value is
>> guaranteed to
>> be the same:
>>    qxl_post_load()
>>      qxl_set_mode()
>>        d->rom->mode = cpu_to_le32(modenr);
>> The value is the same because mode and shadow_rom.mode were passed in
>> vmstate
>> from old qemu.
>>
> There're also cases where devices' ROM might be re-initialized.  E.g.
> this segfault occures upon further exploration of RO mapped RAM blocks:
>
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>> 664             rep     movsb
>> [Current thread is 1 (Thread 0x7f6e7d08b480 (LWP 310379))]
>> (gdb) bt
>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>> #1  0x000055aa1d030ecd in rom_set_mr (rom=0x55aa200ba380, owner=0x55aa2019ac10, name=0x7fffb8272bc0 "/rom@etc/acpi/tables", ro=true)
>>      at ../hw/core/loader.c:1032
>> #2  0x000055aa1d031577 in rom_add_blob
>>      (name=0x55aa1da51f13 "etc/acpi/tables", blob=0x55aa208a1070, len=131072, max_len=2097152, addr=18446744073709551615, fw_file_name=0x55aa1da51f13 "etc/acpi/tables", fw_callback=0x55aa1d441f59 <acpi_build_update>, callback_opaque=0x55aa20ff0010, as=0x0, read_only=true) at ../hw/core/loader.c:1147
>> #3  0x000055aa1cfd788d in acpi_add_rom_blob
>>      (update=0x55aa1d441f59 <acpi_build_update>, opaque=0x55aa20ff0010, blob=0x55aa1fc9aa00, name=0x55aa1da51f13 "etc/acpi/tables") at ../hw/acpi/utils.c:46
>> #4  0x000055aa1d44213f in acpi_setup () at ../hw/i386/acpi-build.c:2720
>> #5  0x000055aa1d434199 in pc_machine_done (notifier=0x55aa1ff15050, data=0x0) at ../hw/i386/pc.c:638
>> #6  0x000055aa1d876845 in notifier_list_notify (list=0x55aa1ea25c10 <machine_init_done_notifiers>, data=0x0) at ../util/notify.c:39
>> #7  0x000055aa1d039ee5 in qdev_machine_creation_done () at ../hw/core/machine.c:1749
>> #8  0x000055aa1d2c7b3e in qemu_machine_creation_done (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2779
>> #9  0x000055aa1d2c7c7d in qmp_x_exit_preconfig (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2807
>> #10 0x000055aa1d2ca64f in qemu_init (argc=35, argv=0x7fffb82730e8) at ../system/vl.c:3838
>> #11 0x000055aa1d79638c in main (argc=35, argv=0x7fffb82730e8) at ../system/main.c:72
> I'm not sure whether ACPI tables ROM in particular is rewritten with the
> same content, but there might be cases where ROM can be read from file
> system upon initialization.  That is undesirable as guest kernel
> certainly won't be too happy about sudden change of the device's ROM
> content.
>
> So the issue we're dealing with here is any unwanted memory related
> device initialization upon cpr.
>
> For now the only thing that comes to my mind is to make a test where we
> put as many devices as we can into a VM, make ram blocks RO upon cpr
> (and remap them as RW later after migration is done, if needed), and
> catch any unwanted memory violations.  As Den suggested, we might
> consider adding that behaviour as a separate non-default option (or
> "migrate" command flag specific to cpr-transfer), which would only be
> used in the testing.
>
> Andrey
No way. ACPI with the source must be used in the same way as BIOSes
and optional ROMs.

Den

