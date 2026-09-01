Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E76C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ofy-0000HS-4k; Tue, 01 Sep 2026 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofx-0000H2-Cb; Tue, 01 Sep 2026 09:37:21 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofv-0004If-Ok; Tue, 01 Sep 2026 09:37:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIDQVO86C85NQpFww2bhguCpLsej0OOz7bIECO+nqlegMapMz0hZ2MD377CKl1mP6KWSPCEdVa007hsyNQDaOEzIfmcRmYhOblB1WZmuN8wPVY2KPD9ueQk8LuwsKgYLKEFAHZ0mDpJRhKAWihT//+5mmh74JnRdlL5oMU2115fO6vO3t/UMiWXXFvIBGq9FgkQ6JhK3TDcKkzfMyRLOrVUOYjw4G/Itzw1RxgAWVGR2GjnCR+6FiczFoyQ/1aDjgnqG0geIWue1pKclKq6Pa/voClsTQHeOBjYpng5dTaRCv9M5J4dvqFulZyBVbZgt+OoEAoH4QWAkGnlrVGP5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNDB5M/8GYiCBfc8N0TsPmckETkceAMzf9wW066XTnE=;
 b=LtC3LapymdmXCgCtQkePwCUtH+NBPwuY2wH1WA+9s6VRCEsfWVvgy4Yn+P05tc0Ai1gbSQ9c67KkkxB3QEXCm7dUFjfOiepURkwE90EsAdObjm2JxnNMmWLJ8VVW9fioVhn92LoQVt3jmUGvUvYiAWc199uNJ6kB76+6mvU4oRZQnSuS4lqXL/otlqBuDrgn//CvrDo13kEMwZetDf034obmvJ5J4XeSS07gDJt8jZ7GgZslF6eULqk4TdEnMnQfBwRTGTk/jCZriIPUnu3m7T84wL/0Hpu/jlxcDkf6doEPs6PW3H4SOwjkkWOsdqm0TgnMWjPLW7Kfvocyj7JXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNDB5M/8GYiCBfc8N0TsPmckETkceAMzf9wW066XTnE=;
 b=S4ZrVPZbm2Dkkd+jdsO0mQIJBHnbx7d+thpgwIcX8yu0DO0P2BEt2NvWs41/QPbsMLbVTd5+4A2d/YvQeKiOVbJ//gEZFYhOkVowvJAl3Ozw3NvQZ/6Cy9B4bd7jvUMxfMxzbyudM851oGYeqVLqX2eD4Jqylv+bXZseZGFpeRh/uEAJCkzvSXBOdeUDkibnlH3YqnDwhdxIrJpr6xXMLppHWQuv3dXoGIJmkHiH3dkry859wlVcuTSqfniP2Z8KI+kMyGCmCzja6p+EuljCzokFJABvxrvGiCJG8mA/gTD6RKQMps69NyHeTShZfu0bm8ygf2O6k47sKty4UzBZIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/9] block/commit: batch block-status queries
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-4-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-4-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982593.73810.14391247684526942566.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 48609493-338e-44d7-8623-08df082e1f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|3023799007|38350700014|10067099003|4143699003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: LqwGCIJ0Wajuc/R6nrdV8rTMuRGtgjNYEjQvDJsefgz6qOU5mwqzAYuNVCm2G6Zn64JsBPHSSA7eRtkawBRQyl4GlXeSjGLw1LikWgSYvEHczv7Go8Dt5kQw+j1TL9CqmQWijSegoPujOg2+bi6DqIqxswrufzJUNcETUDGmxexdp0FNZyyEuHmItO6s5O1iqdPRhKhXx7na2yvioZ14XAPynIubbP/t6TcsZcSzDBDMHdozlrtwbbJWLFsE9bb0BmzlBiwPLxeE8wWQ8MM8foqBqqADoZGon599ZKXJj2JDtZAcS0GEFntfKnZmG56gtFRx/zTpxZypBu+fr3I0xAqPJPFkn3//Nltr267A3h5E+xhjeOxMZdyONlZZNJ/vF7mgvKb6BEKd6Q7m+A0DoAqP/hSOFgaA7aM1gy5L/ObVela/O3HJ3JYuf7/t2WuP5U/DGD08RS7HZYONRsMq8BzatcY69hJcY+wzA7j2ssEcZMhf2yXtYMh58i908/IFCVkOymjKrQW1mOPMnrXXi4FQ+3Rmx36kQoyFZDvDn/xg0mTUPPTk6sUnQY9my3pVBWOu24VsVr4oq9KktEVC36pbsIsJYTEdACpkAjYzFZ6BBXdmzstsd1fdmr6yGHa2Nt4gLd339kzc9AYw7cIQJ4tC+bRf5JN3xTlbwVf7Ca7T6E7fUxnEP9uFvHe0tFBjlCU1d0lNVVLTPvSLXq6DTLRrzgRvfLTDlUsaBX3YA8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(3023799007)(38350700014)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldJVlp4ZmVSMkhCNEtlbjVHQ1E0dVYvbjBsQVpuNkZPQzJQcnROUXlwRVRw?=
 =?utf-8?B?eXVxZ3hwVnJuUGY2NFFpVnpDTzNSMUJiZ0lQbEtXTzV3N1hKREVVRVhNcE9N?=
 =?utf-8?B?OUZQSUVkd2l6M2RrR0JYWXRlby9IUmZnYm5jd0dRUXNLZEpnVW5uMVpWeHcy?=
 =?utf-8?B?Q3dFcnUwSEVna1RZNzR4NXhaYjlKWlpJY3NwT0hFRlFFRElOaCt3K3oweDRE?=
 =?utf-8?B?WWovZzZSSDdTaVVwSnYwUFFaQmZGeG04TnA5eDJyOGZOUHJUVDdaSXZqK3JQ?=
 =?utf-8?B?a2x4b0EwM0NnWlRnTXViVTJmSDVhL1cwYUhSeXpaalhGT2VrRmJIL29kOGQy?=
 =?utf-8?B?YVZER1Q0U3ZBc0ljNTFwbmVKbHhTRWlLNWhRYXhTV3hpanBBVmxCU1VhTVVv?=
 =?utf-8?B?bGZwTVZPM210bFNmUEZPa240SmE5blFhdUREUEVVNFFHbFJTT0hnU2tNTXFI?=
 =?utf-8?B?Y0FpVjdxSnErbitCTjhYbVBKUTg0bHNSMk8wdlVoaElCU3QzUFZucTdacVJH?=
 =?utf-8?B?TVRSYldDVU9ubjdLMFczSElLaXNRVFo2TWpYaTFmcjE4Q2lmVEltVTZZZ3dq?=
 =?utf-8?B?cmtGRUFYK0RvL0twS29ySy9XQS9pNFNGeGJNek1tcks4MHpJbVFJQkRqOTNv?=
 =?utf-8?B?aWhiSVRiUG1MR2ZSZXkwSS9WZG93Q2FEM3pYOWNWYjFiNUdkVHdnWXU3eUVu?=
 =?utf-8?B?RFFVVEtQQlIwWElQNXJHMTFSKzlOVnBaMW05azRCYVJ1ZFBSR3BEZVdZM2lG?=
 =?utf-8?B?MkRLK2N2K0lweGJob05XQ1NmL1hybmV6ZnpoenF5UjVhdVA1ZTFrMGlrR1hp?=
 =?utf-8?B?YnZwYXVDTXhGbklwZndEOXdtVmZtamE5SFBpRncweWY5S0hTYzFtbUd5clNJ?=
 =?utf-8?B?alhsenJFNlFhMUtMS25DazRSZlNYT0xEbjlaMnJuZjdvcm95SlBCM3c3UjBp?=
 =?utf-8?B?VE9ORHJPZml1VkhEOVRXdEU2L3FnaHYvMWdrWVM0TE0vK3hJV093OXZHakxx?=
 =?utf-8?B?MlhIT2ZjU2hHSGVKTW5uRHhvb3ZEMWJOcnRURFVmSG83cXpQd2NubW85djFS?=
 =?utf-8?B?OFlPVTd2ZnZ6c2NGcEZodmUxdHdVZ1FyTU5EWjJqbnZTekRsaUVRbi9sOEpN?=
 =?utf-8?B?SG5TK3J0ZmNEVDN6eWJPRktyZDBJVFdJbVdacEV3RWJpWnJ4OE9lbmFSa2RT?=
 =?utf-8?B?akF0bDBQQ2p2anVjY2kzM2lyc1RubmNwdFdRYjRFR0tHZm9JeUVibTFkK09u?=
 =?utf-8?B?MHlZNEViUWc0Q0V1dkZvY1kzS1BOQXA3cEtVU3ByVXhqd3F4K2xMZWJpUnor?=
 =?utf-8?B?VDBDNWMxVVBaVWNCVjl5OXpWTU8zS01BVGduWnpEOUh5azZjSU5iK1Bad0xr?=
 =?utf-8?B?R2tnaE96WDhiVEZyRmNvakEyQTVjd0dUbVJHZW00VXVHTUxSM3ZDa2piOTd3?=
 =?utf-8?B?VHkxWlRoUWovUGVDRG1haVE5d0FIelIxZ0tyWUNDRHh5R1V0Yk5FdW80S2Nm?=
 =?utf-8?B?dE1SQmpWeC9xNTNZWGFyQ0ZDTk9oaWxUTXNHK2tvQ2JBK3ZzZEo4bi9iTlZ2?=
 =?utf-8?B?eDZSdWlyNUozbi9DajNES1gwM0NyeVY5eGNMTndUS0RHT1djK3pCY0c3WXE5?=
 =?utf-8?B?Rm1pNmlZangxNFFqc0lwWEFXYmxFTTlJTVhlVlZUckJZcjF1d3A4bUtVUSth?=
 =?utf-8?B?TVhwdEp3dUxXcWZQMFQwOFpuOHN1Y3ZlM1VsN0d5Q3F1akdBNmJQMXhzakVV?=
 =?utf-8?B?UExrVkV0RzVzQzlPeHpEZTRrQmZxdGZmMFdVLzNZeTJwZTZEcHZaeWhsaVd4?=
 =?utf-8?B?eDZHL2hlUGt6V3E0ZjU4MkNleEhKUWRxSHRsand2U1pFUmhnOVB1aVBwbFY0?=
 =?utf-8?B?WGdjQWV3aFgzK2JwTUlCY0lESm5NYVRBWkFlZ0E2NWsrNUxPdHFhdTlra09Y?=
 =?utf-8?B?SDk2NmhaczEyWmxXVjVwNWU1eGRPUWNYV0lOMnlrd2FBbHg0dWxsQWg5Mlg0?=
 =?utf-8?B?ZXlOeGtUVmd4c3Ewa0NsY1d0ZUNsRVZ3eHBBN3N2TEJjeFg1M3dRK3NZNVdn?=
 =?utf-8?B?WkxwRjEyWUFFQTM5STJDMDN5ejlmekJaWTZsK20yZGlYMDVpOWtPY2lIME1u?=
 =?utf-8?B?bEpIYWh1RU45Z1ZLQVRkQnhTVXJZNmptZHVWTWdDNlBidHFSVHAzN3pBaERj?=
 =?utf-8?B?V05Cd29VaFA0WENEaVg1aU5HdHZJZ3Z4UVl3b2lyd0tMVnBEUnh4S1JqYVpN?=
 =?utf-8?B?LzFIYnB5OHhHMmo1Ny8zdjJEblJUOUJQbktVcFJ2TGxTUHdqa3N3a0Jha3Fi?=
 =?utf-8?B?NVNkWHNIRUxxL2F2ZGQzZXcwbVV0TGFmMWVYeUdVdTA1ZnBvZmROc1kxbGNu?=
 =?utf-8?Q?ks7INWI7MiZ9wLxE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48609493-338e-44d7-8623-08df082e1f75
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:10.0266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yodLoFCvjRjyUEYL3szThXByZGa+SpQXkBeIiYtEdPaJ9e5FDmHFrv41rbWF7rwjOnvIMTB/wwljFFam324VLa/UQbnxB1LTpgididYfDM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

> commit_iteration() asks for block status COMMIT_BUFFER_SIZE (512K) at a
> time, so a long run above base pays one query per 512K for an answer
> the whole run shares.
> 
> Query the remainder of the image instead and keep the answer in a
> CommitStatus owned by commit_run(). Nothing can write top above
> base_overlay while the job runs: BLK_PERM_CONSISTENT_READ is shared
> only from filtered_base downwards, and the job writes below
> base_overlay.
> 
> Copying is still bounded by the read buffer. Zeroes need no buffer, so
> COMMIT_ZERO_CHUNK bounds them, keeping a cancel from waiting on a huge
> write-zeroes, and an unallocated span is crossed in one step.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/commit.c b/block/commit.c
> index 4e0b0f9029b..5aa3df31e1c 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -31,8 +31,17 @@ enum {
>       * contiguous regions of the image is efficient.
>       */
>      COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
> +    COMMIT_ZERO_CHUNK = 256 * 1024 * 1024, /* in bytes */

Comment above was targeting the COMMIT_BUFFER_SIZE only, now it seems to
be applied to both constants, which is misleading.  Also why exactly
256M?  It isn't explained neither in here nor in the commit message.

>  };
>  
> +/* Last block-status answer, covering [offset, end). Empty when equal. */
> +typedef struct CommitStatus {
> +    int64_t len;
> +    int64_t offset;
> +    int64_t end;
> +    int ret;
> +} CommitStatus;
> +
>  typedef struct CommitBlockJob {
>      BlockJob common;
>      BlockDriverState *commit_top_bs;
> @@ -130,26 +139,43 @@ static void commit_clean(Job *job)
>  
>  static int coroutine_fn
>  commit_iteration(CommitBlockJob *s, int64_t offset,
> -                 int64_t *requested_bytes, void *buf)
> +                 int64_t *requested_bytes, void *buf, CommitStatus *st)
>  {
>      BlockErrorAction action;
> -    int64_t bytes = *requested_bytes;
> +    int64_t bytes;
>      int ret = 0;
>      bool error_in_source = true;
>  
> -    /* Copy if allocated above the base */
> -    WITH_GRAPH_RDLOCK_GUARD() {
> -        ret = bdrv_co_common_block_status_above(blk_bs(s->top),
> -            s->base_overlay, true, BDRV_WANT_PRECISE, offset,
> -            COMMIT_BUFFER_SIZE, &bytes, NULL, NULL, NULL);
> +    if (offset < st->offset || offset >= st->end) {

If I understand the code correctly the (offset < st->offset) part of this
condition is never true.  commit_run() is the only caller, and offset
monotonically non-decreases in the for loop.  Then st->offset is only ever
set to values which 'offset' did hold at some point.  So we should strip
this condition from if statement, and I'd even add assert(offset >=
st->offset) check at the function preamble.

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

