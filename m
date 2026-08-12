Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E45C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAy0-00061a-DS; Wed, 12 Aug 2026 11:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAxu-0005sc-Q8; Wed, 12 Aug 2026 11:34:04 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAxE-00046H-BH; Wed, 12 Aug 2026 11:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0rocIgiM0wghiKmEQGgO4UwkT4R1FPB63/xU10lLilKSVybaeV6ohSieisgbFBFVKz/ilSZj23nsfvTOTZn5e+tJn6BhTFUMNfMXlKLEFWh9UfzvxBy9bq5ot1cIHX6gwvUKQFmz3Or+ovHzq2tLzvUBNyfcUxL3Kv8EfmuRx7yn45Cqip1gOk3mhL+8NgobJb5ZdXw4pdWJxIRQrjpyGQasx4bAoMl8VWLGp51wCR7GpPMmEmhBtpC5TK8fdMA7h1mOGQpjlV/BbqGlKVovge+7E7eBCgRC7eXMX130zPBy7MlkEzOfAizI71zJD5+vCRKBMOLZ6cr3GIjrOwLmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnrpbIxjpIPSOaGfFc01RsmvMjYAX3DDp2V9YseCXPo=;
 b=uNG9BgbiVOqzijxSGR2Kr/iXGWXrqWhwGukJJC3f0eEZM4rpkLrueeWq00AxVFm3GNAVlTryNbnqlb4TVYqlsgLwpBhu4YP9JlNGRvlKuqDDNZ83zFmcZn7OoeBTMZtr+/GfVYrfECrHhBC5rsfSclkiz+8Gj0KGO+Os0z+k8fTOiwqXlqRlfQnRxzxAbMw0P+OWij4nGwmJU6tsvQzmN8h3gsJFhqeeynT/Nw5WX9/xw3jKL2LoGBW54tOKlc4LbGJGt+nfxtDerqZ3KGGvVUg2njj3bwHpW7yTfOGyOUKHiTU+P3O3VPXtA5zNF17rFSTDYuzIoEKbX3XmG9lRGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnrpbIxjpIPSOaGfFc01RsmvMjYAX3DDp2V9YseCXPo=;
 b=MSzHybpLw5L8I0Q5jYpiGv24BBvYBswJZNw3a1kHk65a3ngfSYgl7t9VL2ZAINmEXzsXBJaUqu5XYlAnXS6oAcikG03tmx7Aie/WV5VJWjI71QXc8aQZhQPlPJbN/QlmDvfET4ssLRk86HKnRSGA8XZTbdV2M10HApLmeW4OoG2b7t0dL9U+6HVtQtPXrCXcjVIgY+l1Z7+mw/36aYyEgobeKUq11Ah7C6M8Tv3b+RETQw2aqdVlQDZ2zWsESiPcnZgYnNDVPxgtUPt0lVnSaNmJkhmIE5/oCku0PrrOAclEMDBvdeGx6TOI3YqC+O3bWVfvsli1ilWZFMQ5Q1volQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB11558.eurprd08.prod.outlook.com (2603:10a6:102:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:32:50 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 15:32:50 +0000
Message-ID: <e73e71d0-3938-4962-b3fa-0f502a40fb39@virtuozzo.com>
Date: Wed, 12 Aug 2026 18:32:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] block: remember the writability a reopen starts
 from
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20260811154213.184947-1-den@openvz.org>
 <20260811154213.184947-4-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260811154213.184947-4-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: a98078c0-815b-4004-2a60-08def886f7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: v+Gggzg3JSzui1dwzzpO642JaBS02FIkTakGJuE9fioSxDIiuZFw7NMFB6rZrA7dJ1z3SuiT6vEf0hmA5ZDeay7Vur4eT15hBtYS7hjGXr8Rxr9OX1LWVANTXMSto+dIJul7CbKKbxZNtjTx1+MyTWbZAUeHzLJUVH/m/ryfKkdtH8JNO89LFcXzq3v80ETrTA0sDh6V2uDOaFU1BbV/HrnOXad5VT18RgD7tcvjnOizoRMXJ+z03tOrv+jTaGrOC6/1k6c6+ZLmyVvczwBmdZsjDL1GKd/Zh1HUSx3xrcHsks8wFDnYkeZZ1V530JIbYk4w1u00QF6SGeVWKpi9vq6ZoDRgD8+YnrMVSprT3Ms3irFSO5fNGZbZMXyVD8oaloDRkFxz+I/f/prT6KPCHm/Z0Oo/hw8/LTSwKolnKO6jLccN/zxFGB56oJCuLBz0PPwGun+KyIzofTcHBry3FEKxfMx9HfRPm71OkRB129e+f33zWp1X3b5VjWp4njHgWzSMqlJzaG5q8cq+d2oKEeXVCkJtWDTeEf/gqHJB5YgZKWbnPq2YfOZ3EY2D2BJ0MxZjEDDQqoAn26gF7Xl0O1ME+Xe4ksxDIvHHjHK2AwADXH/j2czQTLrN/TNUopU0gTf/WLSHMrNeCPUcuCspvX0Dsdw38NZc/ek1+f21C7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVp6bm1ZMUd3eGE0dmYzQ1V4ZEVTc2tiN2Q3Zm9LS1RDZEtyWHRxRDNQRkV5?=
 =?utf-8?B?UXZNVjIrdjM3L0U0SzAvQU1BQVdzWEZBNzNITko1alVLVUhhL1pyRVpuZG1F?=
 =?utf-8?B?REdwU0JYVjVMTjlSNkhaN21VNzc4QlAza3NwbStrMmZtZHpXMUlCL3hMR01O?=
 =?utf-8?B?VmFOaTg4QjZFSnhoVDJDOURlUUZ3U2JXazVtZzJWUklodVIwRDFqR0sxSll2?=
 =?utf-8?B?RXdsVnVhUHRaUnlHODQvcmFYaGozdzNpdVBWVGZGdFVnK2M5TGhDdldFSEVL?=
 =?utf-8?B?SWtTWnlFUUpYTlZ4N1UvQjlPZEYrRU5nd1BMR25PcjUrNDBCUis5b0NQM3NE?=
 =?utf-8?B?RFlnbmtxcExKT2UwUHVmWTRNT3BZK2RiM3IrWFJKZ0NuTkFZMFA1Z2Z5SThs?=
 =?utf-8?B?cTkwdFlMdVU1WVpOa3Z6aXdIS0hIcnZ6UDN0Zit3VDZ6ZXlac0YvOTdxNThO?=
 =?utf-8?B?SFNhUEw4N1NuelFNT251WVNleHdyQjhyOUptMlpGV20yTC9IRms5YWIyeE9x?=
 =?utf-8?B?UDBMZUl6UWFmNll1QWxsaElqUUxVQ1ZmWmIxeEV4bEIwY1pDMFkxNVR6WHJ2?=
 =?utf-8?B?U0xzV3NCSldoenYxNENySGZ4eVplYlNHMnowVDhrRTlESEcycW9iVVl2VjBR?=
 =?utf-8?B?U3hTU2RDT25DNkFxOExoUlMycnEzeHo3MzExNmZXeW02N092YVkzc3FGeVhH?=
 =?utf-8?B?NDRDWW45dVFkZk44Y3hDaUtMRTkvQUlURE5GejFQQlRBWHdrb3U3d0dqMFVG?=
 =?utf-8?B?MHFQZ2N4M1NSdkVsUUg4TERRS1pIOTlJaXVoekk4dTlERTBaNm9vZ0JWSExD?=
 =?utf-8?B?cGJlQk1sQ3c2bzRYQTlBdjlPRk5jRHZaWXR5NnI4RTQ5RHo0T01YdTlHK3ZI?=
 =?utf-8?B?SEVTYndtV3UxRTZtQkdQY3hPUktvWThNd2ZHcC9DVzhqdiswd0lTc251VmhM?=
 =?utf-8?B?TW9heVc3Z1JibG9EZDU4d0NQcGtRaW9QTUpZaHVKSUlwckhuSURWRnB1blFr?=
 =?utf-8?B?TUdYRytsOG9Nak9UYWZPeEZCT0ZmdkJlZ3A2MHdVeTRONjMyMG5kRWtsa01L?=
 =?utf-8?B?bm80eVRoVWJOWnVzdlc3N2d4RFM3RXBYQ0QvMmtmZUZNM1BvUkNRNGdKVzNT?=
 =?utf-8?B?SkpWM0lpY3MrM2lJM05mOUFmd3ZMK3JSQnhCNUIySngyT1ZKekVXcDhpMTls?=
 =?utf-8?B?MVM1ZU5tQzhLaVFmZXhPeFoxMUorLytRbkJsVTVFbE1WL0RscWk0Zy9PWFFy?=
 =?utf-8?B?ZDgvODJsK0VQYWRrTHdZaGQ4QTFWbHk0a1pkVDNBLzJ5UzRjN0ZjczZXVUJZ?=
 =?utf-8?B?dlo4RUFydjYrbkFQMThieEdudkRNTGNxNmI2ZjBsWi9nQWNsRDBKazY1YVBv?=
 =?utf-8?B?UmRTb1lSaUl4a1EwZnpoR3AzTHRrT3JVNlF0blB5bmVESEZ6QUwxbjNFSTVX?=
 =?utf-8?B?TWNkdUlaUlpHaHJGMGx6V2FBM2FKcElTTlNzeFRaQy8wL1gzSU1wTEszTk9L?=
 =?utf-8?B?UnNuL0VWU0MxWEtpQkZDeGx1Zm1URTFaaEhWMVhaYndDbDVuOXpTZGdwdmJZ?=
 =?utf-8?B?UDdsUXpZeExFbFFCeU10QU02RXRkemdOS1JQKzVwS1J5WE1rYktuRlpxV2Zm?=
 =?utf-8?B?ZjJjR2RyRzlMT2x6c2c3TE1VYzdUenk1Q1EwaWdRSXF5VklkLzkxc04zMVEy?=
 =?utf-8?B?bFZXbDBpNkdnTXNzMWtzc1h4RWZnVE9VNWpyVXc3WDhrQnVQeUJGckhTeVVh?=
 =?utf-8?B?eW5FcE9GWVQrQ25oNUNQVEp6UG9oTUkwM1V3cDQxbWxKcDhZcWlMdUZ0VXI5?=
 =?utf-8?B?eUplcE5HdkFwVjNvWThFT1BlWHF3dzIybmdhTC85cmpWbzUzL0IzZXp4QmFv?=
 =?utf-8?B?RElndEsyR3dlM05hUHBubjhWWlNaajVBZldBSzEvY3BnaHZvTFcwaEtWVUJK?=
 =?utf-8?B?dE52bmQ4aTNYdEFPZXE5YXJjNHlTTGZ6UVNmV3V2cm5hZFU1dEhKT0xNd0tT?=
 =?utf-8?B?MHVBUG55MG9mMWJRUzd2YjRSVjZFYW9wV1lWa3hCUXhKSVpSRjdDZFdMRWIv?=
 =?utf-8?B?WTJkejlOanZQN3ZOMW12TWhWR1gxZzhOa3RuWXY4L093MWYya3ZCOUZLaS9Q?=
 =?utf-8?B?cmhSZ3lKZVEyazVud0xaMU5wOWtIalEyUG11MjlKc3psejltbnVNNTVCWEJx?=
 =?utf-8?B?eE4yVEtRbWszQmRjb1A0NXA1V1NlYjFqL29lNnpSQWFkR2d2cm5lTVpYc0lp?=
 =?utf-8?B?aGNJRXhGV2lnSkRIbHBSUXRHWTRIOHVnRmhDRmo3emV3SituRld2MEFxRitY?=
 =?utf-8?B?WjFXaGRRSTVsWDcyNm1pS1lzOTJpSThrbmM2NXR4QUNWMGlTRFlDZ05HQWpZ?=
 =?utf-8?Q?vmIJczXsNyEwkYjw=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98078c0-815b-4004-2a60-08def886f7b8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:32:49.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKIsxbF+hsJJhgW4dikmrVIep1oGEgFx7g1ZE2xKx2cFMa3sznu7KWGbCcDjcN2tmNtIBZQg22xZR6wP17/jpslIOnL/dKmQw56BZCs05To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11558
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 8/11/26 6:42 PM, Denis V. Lunev wrote:
> bdrv_reopen_commit() updates bs->open_flags, so by the time
> .bdrv_reopen_commit_post() runs a driver can no longer tell whether
> the node has just become writable or was writable all along. Only the
> transition is worth reacting to.
> 
> Record the value while the queue is built, next to the other
> pre-reopen state BDRVReopenState already keeps.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org
> ---
>  block.c                      | 1 +
>  include/block/block-common.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 99ed06f8ca..c50d9474fc 100644
> --- a/block.c
> +++ b/block.c
> @@ -4473,6 +4473,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
>      bs_entry->state.options = options;
>      bs_entry->state.explicit_options = explicit_options;
>      bs_entry->state.flags = flags;
> +    bs_entry->state.was_writable = bdrv_is_writable(bs);
>  
>      /*
>       * If keep_old_opts is false then it means that unspecified
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index 895ea17541..f64b2d6f35 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -360,6 +360,7 @@ typedef struct BDRVReopenState {
>      int flags;
>      BlockdevDetectZeroesOptions detect_zeroes;
>      bool backing_missing;
> +    bool was_writable; /* bs->open_flags is updated on commit */
>      BlockDriverState *old_backing_bs; /* keep pointer for permissions update */
>      BlockDriverState *old_file_bs; /* keep pointer for permissions update */
>      QDict *options;

If we start tracking pre-reopen flags state, wouldn't it be better to
just save 'int old_flags'?  Otherwise, once we have an urge to track
smth else besides writeability - we'll need to waste another struct field.

Andrey

