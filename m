Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFCCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfxp-0007qE-3U; Fri, 02 Oct 2026 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfww-0007hK-NE; Fri, 02 Oct 2026 12:17:34 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfwr-0004zx-Q2; Fri, 02 Oct 2026 12:17:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYXI1DkFCesb96SxBy7+ZKpjAt/ENumNQXAoDQgkN8bXEUCbvNFMoMha8Po98VJtgjgjBV/wdVCqgGD+cVEDpqDcRvCJpguBepkxQ6jYHuuLtsAE0j5/gBL7QAglHomJimXna/76gVtD7Pc+43Om7K5IooYGwPtdH7X6Fnf0ViIUCpr8JcI7ZcZlJAzSmvXonY1rGJDi1hAdx1r8U97NyYMrYVpPshJvn1LhA0aiJPAF7jV+O7LASGPpxT7dOevz5jxfLBjnOdbHSZhLyyfuNoliUCgxm1z4yr1hWVjtF0UR9/QcKd3UR2UyWxdaIp1+UKs9rLCBMnDg1J2dHn1J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVmXNLYjx4ld8pn/tNF/UOTGmn/XcMMEafv+5mL4R9Y=;
 b=BfEhHbrsApwf2g2uSW6+WIOCwUw6/8jqCpJ3AQqs3+gdC2Rs1Xu9S1Htc8HEBKtNwTkgb+6LcNhUIRdikvYOniXS4EuxaA2IpiaJQMQV2NDqd6M0VQxT+Q3K6UgKENHRpRvkFUyI/xGgqczH1zJkaQVu+LbiBVE2TLH9ClGgoioKyr3CC5rHcD4S3fDwPGUQQmvuLN4Ngw0wgZBUYP/45q8/YFkiPEOV7bK/lKs7mY4023Ji8XT3OCq2DzDkPg3XIeiNy+qxUIvbnYRBWdrItxwhiYJfC2stJ1wF4C0dLcA8SH3GDBRiv+iQ3Vfs1dM2Uy8L6DtymkyvnrsJC+uT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVmXNLYjx4ld8pn/tNF/UOTGmn/XcMMEafv+5mL4R9Y=;
 b=arm0diQFA8AkoxtawUasnLcc78u+gYQ4FC3x/73ei64CYg24rilHFTeIPhAO4wDXS2PDonvc2lnuxeKHbmlyv1yRuzIskz1mGXV+TxWW/fJ4+xS5eLyRi62Q68bzb9hyE9XYAXRJwm2a2LB/w2A7sZVTuiKiuO3/etlTvkODY1bc47mfRvyojkqLEF0J1T7wwmk31XYZMgsnxWCZEc4ZgBwps2nxfZG4bzLITUd6g9ng3Wax4g7F5q+GbfIhl4fQWLzVhYnCiOV7PTQ3AiHl8nn7gCaYK4BhJoThUm3LiFpCnQ0welFUgkZBIzW0iGwki2rMMKsaR4k1k9AJd+W7Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13) by DU2PR08MB9961.eurprd08.prod.outlook.com
 (2603:10a6:10:494::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:17:20 +0000
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d]) by GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d%5]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 16:17:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/13] block/preallocate: collect the state assignments
 in one place
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260930165000.303236-4-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-4-den@openvz.org>
Date: Fri, 02 Oct 2026 19:16:59 +0300
Message-Id: <179095781937.643598.6725272640077994371.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR08MB10667:EE_|DU2PR08MB9961:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9f8053-50e2-4ea6-1a62-08df20a09996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|23010399003|18002099003|10067099003|22082099003|38350700014|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: A1JVs5x5yH4WObzJaUFxsvLfFY0bn2udzTpB7zikhiok1o+O1cJ/E+9XxzK0Cw+BXVkB5ysxBlNAx0D+MzQRv5q3hm2Xq/XvEfNMfxWZTTDqGq9GI+q2TDZGTn1emQoFCUoBWAEHEvagOjCHUX60TarUAGVFeR64GJY7pu8ogFN6igMtS9xiA7tZyPwwdthFkLFXhmNxQLfYnfMuYLYBXvzi9Whsuvr1wWJPVyykdZ8nPcdOSHy3WJ7eCpZ8pxITC+QnClAp7SEu3QWQmG4iMVdYBnWaCD2exW2Nl2chc/CFXy7z3f9CL0mu4DIPNvevU/qV+3QjFzEy3WpBF9rwcc1F4Xe10jTs1aXvxwszUM53DCfG0qLqZ1Ev8GfUeU5LvViFhX3Q7c7PxECcVV7+nruR6Pyu1arHctikSYB0i/mG8c2oCkQXTIM/QSyI+91v0U1St8tRIXucPXI+UDpGaofucU+im9w5yAXfexIolB/kjo6Ld1BPRzYCLQX/4HW7d7oeU16qdkQfVPNUGJTVDNcBJThukbLYEwWs1WVFw1HcyzK34NlClnLK0XFlldZhnlBtSmSee3lw+u50O6Y8mG9B94rnnQoKDgscFxbQK+BI+abK3LgoxpwPcy6ysxJ7vCHLNQ9+KaNoe5Hlfj95L9ND8vka9GLA5eBjVgs5B7kPBx0Si9tpP6WDytu/Z1OW1BRnztevnkTAC2y2eWMvjZyD2Ti2ERQNkFXQGet6YeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR08MB10667.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(23010399003)(18002099003)(10067099003)(22082099003)(38350700014)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REM0KzA5Tk16TjN2NFRNUitXVVlZWHF1aDJCTitDNmg0Z3lvUlVkRjVVMDB4?=
 =?utf-8?B?NUFtRTRmRUhLVjJnUXJFMTZEb1dZQ0dhN2ptZDNRb0NyMlRqY2d2R1V3ekNv?=
 =?utf-8?B?UG91enc4SHdEVTZzUUdNNkRGNm1wbm4wMDgxbXB0V2k5SWxMb2tHTTY3MDBN?=
 =?utf-8?B?VURMVytqVm1GTUZBYmE0a0dqUzdVZ0ZKdTNEWjliczlYb0NOelh6VXBzVk52?=
 =?utf-8?B?djB0QnZDVWtJMk5NcmljMy9LUWpvcVJ3S1B6eW1zMnVQS1FBN3ZnWDQxMmJH?=
 =?utf-8?B?UXRDSUg5MWNqczZRUzNwa3BGaXkyYTV1WExpT3FuelFPR3Z3NDlRbmh3cUZV?=
 =?utf-8?B?bWNEZlFGVjU4MDBDaVpDMkZENlBXZVVTQ09WL1hRSW9QOTBMSUI3MGRZbGc0?=
 =?utf-8?B?N2xPZlJJUVh2Y2REbk8ycUdYYUtLWEptbHg5c1d5cEw2ZW44bXFrYmlGZmkx?=
 =?utf-8?B?RDFpeU1Qc2FxVDhMcG9NUk41dnVYUzlkWnFuR3d0M0xVOHRZclpucC9IbmxC?=
 =?utf-8?B?NU04TGhLZWZuV21TKzdPZGFwRVhVY0ZEU1dYQ1F4UmJpM1p1VDU4dFVuL2Er?=
 =?utf-8?B?c0lnUDlqV0ZYc3B5dERTVGlVUmo0SkRFOWd1eDN4ZVZXc1JVSnJrTWZDYlJ3?=
 =?utf-8?B?L0wxeDhZTXVJMndXemgxZmdsR3RhOXhvSXQyQnliWm1hb0dRVXZnTmhUbTZU?=
 =?utf-8?B?UUJ5Z2JKMmxBQnIvRlBKK0ExQTBVRmJlc3BYYmpxU3JGbjRPQWFMUFVDV09u?=
 =?utf-8?B?RkZhVTM2K00wWXBRQ1l1Sm9hd0xMZHZJRVZKTWpBenp3cjljL1paRW5ScmlB?=
 =?utf-8?B?aExIcGZudGRESHVTNHlmS2RaZkVCYkNEbnhIekpiZFZWNFI0MG1UNDZUbW4y?=
 =?utf-8?B?NTNueTA3K0Q2Zi90WjVDODNLU3ZQd1FGUmw5LzlBcjJYTTVYTFFIaSsrRWh1?=
 =?utf-8?B?VDJvNWNFYm1yMU1HN1gxbEU3bno4Y3ROZFh5blNJYWd4aUZiQXlrSGxTTjAr?=
 =?utf-8?B?SjFvR3FZRngxc0F2SWNGWHBuMHhvL1lTMjQ2QjNSR0hlSFNuS0FEMWFia2sx?=
 =?utf-8?B?Wk9JM2VrQkdVZHR0eTRLL0JsWTBuY3Q4cXlRZ1U2dnVhZm9sUFdTSksvT1Z6?=
 =?utf-8?B?V3lpRGJDeDdjeDB6NWY1Nld4QUM1WjFzeTJhV29IVjVhQXQrNzJOZlRldGZC?=
 =?utf-8?B?anpta0ZNUy93R3VEcmU3dGVtSEFxL2tYc09Dcnlta1U3R2Fldll5UjNtck9I?=
 =?utf-8?B?emlqQmRvd0IvaU9McUY3eFlSR0xVMnJzdTdiM3hIN2xVSkZ5MWRwak1JOGVF?=
 =?utf-8?B?Y3E2dE1vcFlOeFE0RW5oc0Q0Z2lac1FkN3ozSHZWM1lGOTVvbFhkUmJjVDdT?=
 =?utf-8?B?WnlQVVNCWjhmNG94YzZ1QVlxdXJnR0FYek1yK3RmSmE2Z1FybEREMUh4RnZI?=
 =?utf-8?B?b1dqMmxXZlM2Tng3TCtIaVAxR204VitWVkFNL3JsSWZUNlJLWXZWZHdsdW5w?=
 =?utf-8?B?cmpxeHV1TjZPOUVqZEZaR3JTbmdyVCtaaVExQ2xzalRGYllIODMwRlFrb2Y4?=
 =?utf-8?B?b0w3Y1JEWndkWXR5NUczYmVUemloQTUyMFZGeVJjZDBwS2svR05VZUFPZlJX?=
 =?utf-8?B?T3gxRkpKc3RjQ1pEMXJpZjZxM29PZEtnQ011dUFFV1AxY1BIdFhud1Fhd1hN?=
 =?utf-8?B?blk4d0l4U1oxYkRZRHdQT2txT0RkZzJNK1JEOUlOVEl3UHJ4bzVUZTY4aUFD?=
 =?utf-8?B?VFlwMTl2WWhhU3ZUb29NWGVNc0FLaDlMdlQ2d1RtVVNVLzhEVGVVTjdQc2F2?=
 =?utf-8?B?b3E3aXhCUFUvaElaZkltUkN3QzArSE9IN2xqWk9RNlIzUmJDNkxwMnlaSzVr?=
 =?utf-8?B?blpPa2pZUmlIUk0yaFdZREl5SlJoeFhBdmIvRjRVdGNBSFVXZk4ydW9DenZy?=
 =?utf-8?B?NVlmMGtadEZuaDRJNFZUSnhvV3JwaDdsQzAxdDFoZUhjQlk3aUVPZ3djM0Vx?=
 =?utf-8?B?L0JxS0NZeHVIUkRJR3MvU0JPY0FvNmVGNy94blFBWE8rNnBrbXMzNFRhaDFw?=
 =?utf-8?B?cjZEUGJqeThGNEwrV0ZpWTJuL2JJNzM1SDk4dkhwZWYyVm5lLzRTRWJvZlhS?=
 =?utf-8?B?bTRqNDJmT3IxdXBwQjRWNy9MeVdQME81UHdjNzZtT1A1dXVHL3N4NEZwZi9T?=
 =?utf-8?B?bVRVLzlzbUt1TzkwUDdUVW9UUFhyaVFFcjNIRXQ4T0h2bllUWGs1T0lPY0JM?=
 =?utf-8?B?dzV6V3RHMGR5bFVoak8vZkNlVWJWckRpRm82OXlvWUZMUmZNdkFqU0o2SDV6?=
 =?utf-8?B?ZmRHMkFhNHViU3hlcE9ZVTVLZDNJd3FsN2YvV3RjeDZsT0crT0V3dFpwQ3JC?=
 =?utf-8?Q?hgfydZmMMS5vUanQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9f8053-50e2-4ea6-1a62-08df20a09996
X-MS-Exchange-CrossTenant-AuthSource: GVXPR08MB10667.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:17:05.4929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/yufZCLSREkkDM50lzQgMupKe1LHPJEC/pgcFpkaRM4XA/tTV0X81DUsfkpDrFN+/sMQYifAMff/ew8RjLh5hTwMqXKD0gkCRyI0YCmpXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9961
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

The patch itself is trivial and LGTM.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

However see below.

> The filter invalidates or re-establishes data_end, zero_start and
> file_end together in six places, each spelling out the same chained
> assignment. Put them in one function, so that a change to what the
> state consists of is one edit rather than six.
> 
> No functional change.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 99bd6b1ae76..8cd98684f49 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -104,6 +104,11 @@ static QemuOptsList runtime_opts = {
>      },
>  };
>  
> +static void preallocate_set_state(BDRVPreallocateState *s, int64_t v)
> +{
> +    s->file_end = s->zero_start = s->data_end = v;
> +}
> +
>  static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
>                                      BlockDriverState *child_bs, Error **errp)
>  {
> @@ -149,7 +154,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
>       * s->data_end and friends should be initialized on permission update.
>       * For this to work, mark them invalid.
>       */
> -    s->file_end = s->zero_start = s->data_end = -EINVAL;
> +    preallocate_set_state(s, -EINVAL);
>      s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
>  
>      ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
> @@ -480,12 +485,12 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
>  
>      ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
>      if (ret < 0) {
> -        s->file_end = s->zero_start = s->data_end = ret;
> +        preallocate_set_state(s, ret);

This is preexisting and we aren't changing the logic here, but when
reading this code I got questions:

In most cases we determine filter's validity by checking the condition
data_end >= 0.

1. Why we set this field to -EINVAL specifically?  Why not just -1?
2. Why we set it to 'ret' here?  bdrv_co_truncate() as well as
bdrv_co_getlength() below might return other errors, e.g. -ENOMEDIUM,
-EACCES.  Is there a specific intention on using other errno values for
this state?
3. If there is such intention - does it have smth to do with the check
in preallocate_child_perm() - the only place where we compare
s->data_end != -EINVAL?

IMHO this looks error-prone.  If there's no solid logic behind those
values and it's just a legacy code - how about we use exclusively -1 to
indicate filter's invalidity?  And then:

  s->data_end >= 0 - state is valid;
  s->data_end  < 0 - state is invalid/uninitialized.

Thanks,
Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

