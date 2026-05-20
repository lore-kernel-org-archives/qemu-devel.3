Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E6DCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 20:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPnGJ-0004RZ-AX; Wed, 20 May 2026 16:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPnGG-0004Qy-TX; Wed, 20 May 2026 16:11:24 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wPnGE-0000PG-Dj; Wed, 20 May 2026 16:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=up32d4OOn0eTXI2NjDAxjr/F7xUb57+y6+zHpkOxC2kizAm5OtpY+N9tVfQh0ZpZjQ2+24PFJn6XPP2o6IRjefR4PQ8Lsav7Gzx7S2l79avb10Wnnn5XuGfmqlQzENvQ9rpT1WvMNrlQlnkmAMIzx5QFTP9v8Pg/nJZL9kU08HRRSgf5pHEfWKAfTpbif74h4z6cJ+FfTPsAHaLjASqYA5Uv5JmyWqdRdD0rpTYxSy7GOz6qdyVEs9EbuZdjlVtyovCYBDahbpt94UFJyeGA6V72BQ5U12G0g1cxFAlanGxtBtVmrfpcsgkQ4yCwtNDAEAZfpg1r/vqgcRpxPMhbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nRDMjJYk1ZAB2q8N0AZhiWQ9maOIaG0z1GVWBLu4vU=;
 b=Z+GZ8tSfYdA9Z2HRS7h/IZh0utys730F0emmAAVqMLvY2RX1mwATyvRB8o2e066/ii3QRqjQPPZHVuYnFP8nQrVXQbncHkphdrAl13Dx2F6LFNtrp+cUKkTHkawDrbVgJCY07TNf3X43MxHPzBBujVootRtmECmfd4ltwOdLB8nev5lB2LJP0ZzocjjFZl1/AFMLTIYOhtC9noDJDBE15DOX2L33+tilYvG8o73HlL2JTJH0vbp/KYFMgw3RksEbDeejWuVhnKpR6QRq7yHKAxWfyUtp/6wFkWy6tT7svzZlCEHkkARPjGuNNjl09WB1NMLjxT6ChmispD+vqPs+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nRDMjJYk1ZAB2q8N0AZhiWQ9maOIaG0z1GVWBLu4vU=;
 b=Rb+t2KMtZtIIIGfNoWkYA+sfBwTo9jpwjAgxh5KHjz35he52lbkF9kb6gmkvUk3ubt/RCLRo00TysyPHweqSykXL5WQsA5nOHkAUkJVnMPfYYixjvw8cW7FDjNg7dVHdwyTyQ6SW0cKKX00K0p/h3wXbI497NUd4uzCmpF7v9w4f9O7ZYqB3NH4KEGfWSVzdCKTpmTX+FkyQPBhyekm9iYFb06VqxuE7mKIj3WjlEigr7fMOh3yxHCR2yzzwWLY0lzm19nepsa0gMjuMSGUiZSvPjdl6Gu+yyj33bX6ctFp04i/MzT+PoeRd1HahkFvnrYoeP+GJKsV7SWPW4Hccjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBAPR08MB5575.eurprd08.prod.outlook.com (2603:10a6:10:1a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Wed, 20 May
 2026 20:11:17 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 20:11:17 +0000
Message-ID: <98afd158-b155-4f57-ab43-235d77aed6ad@virtuozzo.com>
Date: Wed, 20 May 2026 22:11:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: Michael Tokarev <mjt@tls.msk.ru>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com
References: <20260520193849.467936-1-den@openvz.org>
 <410459b5-ff3d-4d88-8b4e-ad226c7e5e49@tls.msk.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <410459b5-ff3d-4d88-8b4e-ad226c7e5e49@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIZP296CA0020.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBAPR08MB5575:EE_
X-MS-Office365-Filtering-Correlation-Id: 51924e95-9668-4d9c-4021-08deb6abf335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kIfdL7GEcphQtaVTDtHlo/Vgk6tHYjd+OioM8iU8WZjuRxMnu0nD4xl0kGdpyG2dnl6QSAFuz6756TubqNIYVLEOFclu0nW5wDr6/in93Ky3Zt8xirE6RcE6VQI08IXyGOUNYmFSz59tyKlpr7mqcQagCOcScJRHpsIGT4hgveN3DBRPniFYWuzwt56bokb2Gi7mhy2k9B/hqpD6pnf4GRW+Ey/6e7lNZmSE1nTSCzI68ra4dA8De6bGTYOHo2m7p24xQqJIahZS/loaTOxxzcWrGpqvQmW7zvEuCciV7AqYg1Wk1hI+5c8AbeTrO8VLuC6QOLPUpYr4bEoPigFlLQ9ms3QcHTa1iYXnN5IpFBNl27hcsYCI/eBXs8gOQMOVNnh8M0r4NavusuPxjlKv1TcZMro6UzsIeuGL0nkhWpRx3SxNJOMffPmS1cJ6GfQQRJt2IVEE7jHBx+xV30H6uYddr1iTtsQ4+gF1Xhom8xI/QyrbZVo7r7nBw4i5bMKfOkpNUbWv7mfLPcZpxB9Kn5X7N8qzd+zWllwvQp5wj+qJuLm4gQFo9byCL0Skfi5HEHuL5P4NCIYKqR8w5j1GYV5HvndM7Rvy57RLKnPE8ro+Yj8mo6CF8snaXKlh/IpJvJHwJpqYX6L+2ezuS8RWtM3tLc88sbpzKwfbQf5eRt9ok+cybgV8t7tamXYo5zaK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01sUGl4dnVZaTJxWWlTUjgvdU1mWVdDUENRNW41Zk8zY1FXYlZhUlg1dm5F?=
 =?utf-8?B?bWRCb09hTGY1K1NSMzd5UWVZZDM2cGgxaWpsTWpqUWQySXVjQVdvSFphcHZL?=
 =?utf-8?B?M1BmVnc5dkFiaElkOFRLRzgwVFpPQWN3YmZxT00vZCt3TDFHMWxTcVpGbDRp?=
 =?utf-8?B?MEZmWTcvMEtraVM5Nk5ZTW52SFI4dXZreWlDRFFGWkU4SXhkd3ZLMFd5emF4?=
 =?utf-8?B?THpJN2hkK0hCN3p4OUlJanV4L0x5SWQ1dmJySmcrMVpyWjFOWGljbDdnWkpr?=
 =?utf-8?B?eDJFVVJLVjlVaTlSSGl2ck5zdTFnaXBFMlNEL1orQUpEeGxsUGF4V2FvRFJ3?=
 =?utf-8?B?M3JzY3ovSjZpNUdNL1JvTno5TWdGTEYyQWxIWDlOQ0VmV2c4elpkdXVCMUlY?=
 =?utf-8?B?cXZBUXhvRlY0ajNzSURiS0dtMXBpK0dsQW1hWitCSzhZRE54L0VrM1hyL096?=
 =?utf-8?B?R3cxZkRnZWhYUkZVY3FNaHhxblVkaTZQeEM3RDJUbDZGeGlNNDZORVhhVXBi?=
 =?utf-8?B?bWJlTjBSeUtWbjUxU3FRSnhDV1prQ3dMc1Y1T1Zkd2VncDlIRm1RWWo4ZDkz?=
 =?utf-8?B?cDdsNDdTWVJoZldmSXBhYjJkVENjaDM3QUlPako1Nms5aDVMUjZKY3N4SG5p?=
 =?utf-8?B?L1RFRG9sTDZsaEovaTFvcVV0Tkw2Wit3ZkYvb3NiQ0ZoVkd2NzM1RXBxa0lm?=
 =?utf-8?B?R2hucG5wRXhxV0dRQ3g5VVd4YlVFM1VLK1UzODFIZ29pY0oydTFJS3Q0aEdZ?=
 =?utf-8?B?RzlaZjdkOWsyNGJ1SzY2RzFaWWtSeWt1djBFOHpEVUM1VHZmczJuRFNOMkgw?=
 =?utf-8?B?Z3FYMG9UMVpyTTZDSWxieGEyS25OTTFJZkVtQWMyRGdnS2N1M0pLZFY5VFZN?=
 =?utf-8?B?TC9KR2E0UEFCcHNzRVRaQ1hLejNTajhCaEZYajRsKzB5M1BMeUJ1UkN6TEN6?=
 =?utf-8?B?cTdqMGVEMStjbTVodmVsM3gyTmt4bHcrbEJKS2dyeWtSRmZNdm80dFl3UVpi?=
 =?utf-8?B?bEhDZjhiUXpEdnROSUpkTUdmVHowck1MR1MrM2RPZWRlTXZjQXIwakhpQmlo?=
 =?utf-8?B?N0xtREZYdFRWMUVkM2h5MUNpaFJqakk2eHRsNS82bUtVK21MaGNTOHVnWXhI?=
 =?utf-8?B?M1V1YmY4VGxpejFQOFY2bW9rMFUvQ0czeVZyQ0FDazltSFN1ZGpmT1A0bkVp?=
 =?utf-8?B?eHQ2VmpTdkl3VE1GbFphNWlrMGl4cERGaEhhWmFZVmovOFJjSkY5Vll6QUZ4?=
 =?utf-8?B?RlVsM0FqWHlQck1YU1BqUVVrRE8rSXRrUEQrd1VPU2pEVnl2ejNqRHAwOG1r?=
 =?utf-8?B?cXl0ODRKZnhzQitrczNuY1d4TDE3Ny9TSUhMaWVYOUUvMXFrakk1WTg1ZjJs?=
 =?utf-8?B?djRxYjlIeGhtelRaOVB0aTk4eVF2MnlwSkc3NWsrcVlCZjUwTXkzSWFaOXFD?=
 =?utf-8?B?RmErcEMxSlFxd0ZJUjNXenJxTnY4R3AzbXJMeVVDZ1ZLeTFvWGRMRjA1RFh5?=
 =?utf-8?B?WXFhL3NSeWhCZW02b3pVMlhjSHR3WjVjeVByQlBHOS9qVmFZYUpTU3BIVVps?=
 =?utf-8?B?MmRVTThRWlpZMjVYUzl6SWdvU0ZocjYwWFhCUDROVkNvam9QaXJMdVprU0c5?=
 =?utf-8?B?OG9paVA4TTBDTVBnY3BSdHNGVitMaXZCTlh5ZnJiTXZnRUlBNHFjU1dHMEw2?=
 =?utf-8?B?UEJQWGRXT2VkTUpva0liTHF2ZG5rY25XZ2d2SklRakVyV0dLVlZQa2FhalBX?=
 =?utf-8?B?elAxSm04UE1Ka1lWT2wyK2xTays0UVRSeEhodXpGKzFZcGhpaE9scE1rRk1m?=
 =?utf-8?B?SkhQZXhzVS9ObExmN0FKdkgxR1I0ZE5hVHFmbnVUckxKdStrQ0duQVhDOHdC?=
 =?utf-8?B?WDFTcFN2NHIwU0t2T0RjWURNRHNEVXZHSW4yeGg5anl4Mk11c0xiL0RnTDVm?=
 =?utf-8?B?eTJFZ3ZRTHJFTzd6UjZJNGhNdTRxcFY3SHFUTkF6UlBaRzNvb0tzcGV4VmdU?=
 =?utf-8?B?VWEwNUdqYW1meUpGcDNQRCt2RERWemxVK2FjVWZJT0R6SitWMHFOVlBFQ2xk?=
 =?utf-8?B?bU1ucWRaU0NyYzZmOXVuTjlwZ1Z5c0Y4ejNmaW5mNVNYMjRGd3FIZ2w0a3Rw?=
 =?utf-8?B?WW9nNTdqcUZyOXZlR1lydHpuUmkyUS9wd3VUcVU1S3IxOGFacnhMR0plNzdh?=
 =?utf-8?B?SDFNd0lFT21uK2psRkVrdkZSTXRtd0l6NTRwM2Y5cWgxQlRndlRBeUVybldN?=
 =?utf-8?B?dytWVUJZcXpEdzUxY0MzYnJSa25CdXBZeTdJMUZrVmFJczdUdGxwMmtVSFk3?=
 =?utf-8?B?STdoZDFEdFRCNEtmNFVGUUxMSkNxaGxjTTNDenlvcGlBSkVwNmdKcUFNdXJz?=
 =?utf-8?Q?jeS/grXIIK+uto4sgnlGQj8jnw8dmSaBfbyPDxyHUlCul?=
X-MS-Exchange-AntiSpam-MessageData-1: f9R7OU30hxap1A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51924e95-9668-4d9c-4021-08deb6abf335
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:11:17.0468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMVgzjAq5QAJVZs2kkkmRTrJJDxgP+6dDGnNM1Qha+0joAUF4IBv5Xo1DPV/+yfLHQ1PIsalglz/9rAJTcj/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5575
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/26 21:57, Michael Tokarev wrote:
> On 20.05.2026 22:38, Denis V. Lunev via wrote:
>> Changes since v1
>> ----------------
>>
>> v1 was a two-patch series tracking two independent missed-wakeup
>> races on the qemu shutdown path.
> Um.  The v1 has already been applied to the master branch, see commit
> e3082ab3b3.
>
> And I already picked it up for stable, but not for 10.0.x
>
> So I guess the next step is to send a follow-up on top of v1, or
> to revert v1 and have this v2 instead.
>
> Fun stuff ;)
>
> /mjt
>
It seems that I have written things wrong in description.

v1 consists of 2 patches which were fixed very similar
but different patterns - 2 distinct hangs on cleanup:
* one in bdrv_graph_co_rdunlock() [1]
* and one in cache_clean_timer_del_and_wait() [2]

Patch [1] has been applied by Kevin to master.
Patch [2] has been reviewed with a proposal to revise
the approach.

This submission contains Patch [2] in a way proposed
by Kevin. Patch [1] is independent and stays merged.

Sorry one if this causes some problems.

Thank you in advance,
    Den

