Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0054DC982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BVL-0004In-7e; Thu, 17 Sep 2026 08:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BV5-0004GM-0H
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:46:04 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7BV3-0002qA-4K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:46:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp0ynufGjst2pwJ52kVdGXd28YwsNM+8ikccm+ke8hprlGn7pbHwqFQ1a7TIU8ViJ1fioGjpz5ipx3uTUctMYr1fu8XQPG3Wk5rm3bE0lolUJVYRML91KF2/Tq180qvvRglOXbmyh9GvBSGa+tBt+YEwLsERwAuQtkQTj6wAoFm7c4y3GhdNA5DCXKty5yZ069zOdaD22QrKxSKoNOmEIsGpZW8JThEdio76QUqvjJl6qS1oanmmh5RYTfdVndUUt5UU1b3D/YlUF1L91DKx4HSwyCXsD1WrvBAmBiCLImE6UcJ4eMddbK+aRCtetY9gUS0H0oi6t0R25sxno+1yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKbiyPg6GGcv2zZot2qn+k2x0+wuzBEguD3KGAl5CdU=;
 b=o8q/Dj2+F52eRGmGbxsNDjWTXPY3EZSpajei9iy1Gg2V1lQn5x8wS9BCnoB6vU8PSQhyEOejIJ2twA8ur89aldflwsHId77H2ToTx+rLL2khAQ0nM5QqUtC4+e2qzSNYkyR3sVFIOaZAj3i/xWvmI/GH89AOKUI/sMJaFUZhQtw2ZYTkJZA3ulo39vCOy3PgVD8atSMB9enM++pRc3ZekiveYDy1pErGVG5nemayc3LOiRunZ1Qjk+Scb18BQR/l6f7GaXBTB1ZiVwH/5tUwiaaT+c1IuqCMEExLQVM3yrvvu+peC2lAwUaqFc8kzHN0xEE3tg6p8MSxgwMYiNEk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKbiyPg6GGcv2zZot2qn+k2x0+wuzBEguD3KGAl5CdU=;
 b=g+m8QLFPnumZs8PZgV6Iv5FD9w2wDoHmWnGJTl4e2IW116isGa7U4OVt/d4SP8VaGsTMM0q7PDLzIZVjH/S0njEzAtW3nrUgkcguI7ypJYOvcOK+zCw1T0c0CLzbfHgMvC5ikb9dc0ZQcoerbjpGY8YfNuiRc3qI7ruPbSfWcWaPKT9SHlvXlwieZP5ZoX5/LnX5p1eHpMVZWLwXhyuuIEIx6FqeJs++FsOtH5bX0uxIBEsOGQRaEKXgU2V9jQW0uC8b8oEhgYqRTRtyZ2jNZaBBZyztKf6Et2b62v8X2gBCmo8vdjHIvZjtZ+mkPqogaxvK9i9B0e7k50Z5VIMoHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB9749.eurprd08.prod.outlook.com
 (2603:10a6:10:447::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 12:45:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 12:45:53 +0000
Message-ID: <34444e5c-3468-4287-9fbc-b0a9693817eb@virtuozzo.com>
Date: Thu, 17 Sep 2026 15:45:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/14] vhost-vsock: hand off device ownership across CPR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, mark.kanda@oracle.com,
 farosas@suse.de, den@openvz.org, clg@redhat.com, philmd@oss.qualcomm.com,
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-14-4d31b2dc6afd@virtuozzo.com>
 <aqrDcFrLWGBF_-pg@sgarzare-redhat>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <aqrDcFrLWGBF_-pg@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cca78f-b818-4f4f-0d29-08df14b99c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JbJ2WODd1bducR5vSD7Up1ScVvPaYARGHoOAxiaVND6UqlW/paOU1Bw40Zl3d65vwhAHMxLWtbFvc/UkRgxxL6WJ4Pr1eUV9sQ9t5hC4EZKB6kGv5/THKBL/qvy+RMo+9WYqanpfUiaRPGGhxEUZhs5/WXg83M44KbK7hD3cQ74gO43hIbB+PBAbNtOqGLk9MsqXaBdiNTlGYrr+c3/AEcbejiLvN3ISAh2pJqfGWBqGvOUOknfrSvvSITFNugPkUFUYvcKmXOzRo3zfxl4KOS6qcXw8JUIV9nRVQ1N2zAxepK0Xh+MO9xcaxasbDJno3ZflGOI6v+0L5COkTgJcRZDW+vG479Es9q70f2Tm0YHlzTJqF6l3GWDMOp1UvPnE/PmBw4oU/UFIt6Zl/CXQy5B6GoH9ReHPAEK22F5ka75kUI65883cY505AnRZYIA7WHFD1zbdON+oPpAEVU+Wt4FIHTUHaS2ybS1YrXpiW79SEmXyH5dYwr/sZQ38lgwsyux7Fn9NP25/r5raKvTZM98h0Ha8Laz8NDqPgur4N2z/95mEQySW3WTo0VXw3pC7P/bZxs4P0HFOx97/dYfuPfwBrZfupJwlfIN8L+nJit0aVvORV+POCWHK4B6flFwvxmKEMe1RSTTyolIQSeQcZQsRRJGi9BrvimNAHU4KdEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNEWmFNa3M1d1REV0xrWnIxcytzM09IdmlLRUdRWkRDay8xOGNaNGVWQU5k?=
 =?utf-8?B?Lzlrd1pWcGpZSU9kcEJpSitiMGNxTGVSdUtqSlFSdDFLMlNsMUdxRHorU1Fs?=
 =?utf-8?B?bk1YNEFUMms1M1krTnp6T0pPbldxTFNNVlJYNkhMUEtrV0V1eWRtZEZDRnVk?=
 =?utf-8?B?eGY0YitEaVR4bUpiRWNlQ1VrNDlIejJiNlVrQmtPSjBITEFTemxZM1paY3I2?=
 =?utf-8?B?dGZvdFBHR3QzRDFGK2VDV1ZpVStmY3J5cmhTRHVmUDd6WEY5T3lhOUVBc1k1?=
 =?utf-8?B?L0g4cGtidTFUc1UrWlZPMy94Ti9FSTdxUlhFbFFIQWRRd2c3dXFiOTNoeXVo?=
 =?utf-8?B?YVRrcDFrOTlVaGZLVDNKY1poOGc1M3VHdmNvRHNCWGNIMTRkUWJLOW14a3Ri?=
 =?utf-8?B?VzFIZnNKMmYwQ2txekZJSlRaVVlBaGVJOUcwb2NUZnRaNVRyYXdwZDVueWpZ?=
 =?utf-8?B?RitadE5VdDJEa0pYRGwzUEFjOTFWNGtySkMwb0lmZkdDUjIzOWE0N0N2QTZs?=
 =?utf-8?B?dXNhb1Jib2N1TVNBeGJTd21YT2VONS85MlZmdkFMYzJFeVBLU3d3ZEM1SG1y?=
 =?utf-8?B?NDRTWXRZNWpoS1hYK0Z6eldnTGN3dDdrRUdweUE4RDRRdFA5K2d6OHprV2Jp?=
 =?utf-8?B?bmlhN0ttem1SR0dLbzVrd0wxV1VkNm15bEg2WStNdFRVNnNaaDFkVjJoMDVr?=
 =?utf-8?B?bllGbzREMU9yZjI3SERRMTdrVHBpU0F4aEg3YVdNREdOMXpyZnMwU2l0R1k5?=
 =?utf-8?B?b0ZQdVdqZjZvdVZSVUpHQkduSFpFQXhsem5reVdRdS9BM0h0aHJmOVFpcHhF?=
 =?utf-8?B?OFBjTFJzbytNUkNoK0V4Y0N0L3ovbHRrNENuY29wSlNmNzRnU0lma3duVFVT?=
 =?utf-8?B?T1FIdnhzNlBpb3l6TEVkNlJvQndZVjJRS3BDemRCRWVUM2ozOHIyNUc0OVE1?=
 =?utf-8?B?L3FZK0dReWdVd1pDQzdFZk15dTdvVXR3bmxoKzlqZkJWSmJsRkZtaTlYTjRH?=
 =?utf-8?B?RlpXOUtWM0E2OCthYjR1Y0I5OWUxaGRtTm5SUDZXbXFlM3JWRzhXQnVlUVhN?=
 =?utf-8?B?aXZ6cE9nRU9oaUF5d3FUcjU0V0V0UjVhbWVmWTR3L0JkSXJ3RDZBY1ZPUENx?=
 =?utf-8?B?QVpWdWJ4R0h1T3ZhTkZVUWgyR2ZldTlhL29mbGw5SDYyMENsUU1na0UxRmdP?=
 =?utf-8?B?TTZYeGRYTHJaZUQ1R1hvdlFUNGZCNDJJSUl6bHRqa3o3K1pMY0Jpb1R3WmxT?=
 =?utf-8?B?ck1xN3Z2dW1GM2lVSFA2cy9zMjBIc1IwZVlrejR3NFJJc1JicWZDWWNUeGhM?=
 =?utf-8?B?S0hFb0x2MksxR203TGZjRXFxejhMN25vT3pjaFBUeVpxV3BUZzBGNmI3NGs0?=
 =?utf-8?B?YTFrbWZ5dC9TRUwrWWFKZUhHMVdXSWhVd3daRTNFZlV2OStqYURYRnkrelNK?=
 =?utf-8?B?ZjFVb25PNXhtSzFLTlNpbmErYVBia3JTbjJqaWttd3lLNngzSjVjb3h4OXE2?=
 =?utf-8?B?YkM3LzRDU3hGVGVxQlJZcXFodENqRndiQzNQaEh2M1ZrUXpPV1RwOFMrdVIx?=
 =?utf-8?B?R1NTWEhLZGpjNjJ1VEJ5WWloTm81akh4WlRLV0pQb1NJSHhoV2lGY2FUSHp3?=
 =?utf-8?B?WHhWT0wwazFjZXRrNnY5c0RwT2Y1QU5EbVJHYWVBS01MeEozVWZyRng1eFB5?=
 =?utf-8?B?dHpxcTFlYmQwc3I3WXNQSzNFMUt0aklNYVNOeXNNTnNJNDN1TmlNTEtxTkNo?=
 =?utf-8?B?b0dFdUc5eVRld2hicWd3WVJ3UW15MkRZdmY1WkRZL1FZZFpmN1FaSDlUdXZn?=
 =?utf-8?B?clY5VmhialZXRnVxdUFsdDMwS3lCOW1LakxZR1h5dTA4bElNaGluUWQzY0xR?=
 =?utf-8?B?VHBlQitjUUhFTUcwNjVJalRURkFpbnp0WEt2M1dqSjJFSWhrSDVIaTlMc2lF?=
 =?utf-8?B?dDBnMzBnVmVNT0VmVzRUUmJPVWhZVlNmLzMxTUNwK0NHNzBFeVozS0x2L1JY?=
 =?utf-8?B?Umx4alZvbWd6TGw0VEFRcGR3d3hSNll0M2pEME9jTEtSTmRrT3FqVEMybkoy?=
 =?utf-8?B?NG12TWJHT0UyQngxUGN3TnJKSjZ6ZGdtT3RxMHJRenpOUDhMNzZKZVZURytk?=
 =?utf-8?B?dFVFRTljZFNlMU9kS3UzMXZ5WCtNU3lSd2Q1a0NBYnlINU96MjN1WVM0dlV1?=
 =?utf-8?B?aHA1MitaeG1nSmpwb3pwTVJ5R1lPS2x0L1NLcHIzSzBMbUVma25zZUJxbCt6?=
 =?utf-8?B?dzBmVENkakNsbU1UaVExMDBLckhSVnRTek5mQ05YYnp4WWdaRUlabGhKV3U3?=
 =?utf-8?B?d0RJNmo5Z2p4YlpkUVBMU3BKS25nYkdSTFUxVzJacjhvWWxSYUtOMDg3N0Jw?=
 =?utf-8?Q?JYsTz7v21hPyVWP8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cca78f-b818-4f4f-0d29-08df14b99c29
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:45:53.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/Efw7d5P3nP8333LiFzRbU7HKUUROWXLWLyIC7mCKCsiy9NfATbu5loFffa18kXnRWMdLPXFzcVO43Jb1WXISxOS5f1uf5Mc4fZhlY4pJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9749
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

On 9/16/26 7:33 PM, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 11:59:50PM +0300, Andrey Drobyshev wrote:
>> The previous patches reuse the source vhost FD on the destination,
>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>> in realize().  For cpr-transfer the destination realizes while the source
>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>> handed over explicitly.
>>
>> Do this through the device's CPR vmstate hooks.  Namely, release device
>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>
>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>    cpr-exec).
>>
>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>    queries the backend features by calling vhost_dev_init_backend().
>>    It doesn't take device ownership and doesn't touch the VQs which
>>    still-running source might use.  The full init is deferred to
>>    .post_load().
>>
>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>    the device is started at vm_start.
>>
>>  - .set_status() refuses to start a device whose init hasn't completed
>>    yet (incoming CPR before post_load).
>>
>>  - .set_status() re-acquires ownership before starting the device if
>>    pre_save released it and this QEMU is about to run the guest again:
>>    the migration failed, or it completed and the management resumed the
>>    source (e.g. cpr-transfer target died).
>>
>> With the handoff in place, lift the CPR blocker.
>>
>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>
>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>> hw/virtio/vhost-vsock.c         | 162 +++++++++++++++++++++++++++++++++-------
>> include/hw/virtio/vhost-vsock.h |   2 +-
>> 2 files changed, 134 insertions(+), 30 deletions(-)
> 
> This LGTM and also fixes the issues in patch 9 IIUC, so IMHO it's better 
> to squash them. What is the advantage of having patch 9 changes in 
> another patch?
> 
> Thanks,
> Stefano

IMHO having them separate is still better for a potential
reader/reviewer to understand what's going on.  #9 only does the FD
preservation + cleaning up the entry whenever it's closed.  And then #14
is purely the ownership handoff.  I'd keep them separate, with
amendments you pointed out to in #9, IYDM.

Thanks,
Andrey

