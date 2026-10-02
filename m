Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FD5CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfxp-0007qf-3R; Fri, 02 Oct 2026 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx5-0007iA-1m; Fri, 02 Oct 2026 12:17:39 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx2-00050E-LT; Fri, 02 Oct 2026 12:17:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdD/EzPdINGbmdHypYN2dPu33rRYfndT3PN2ceFAdzSIrwDuzc3GiI7V/KRM+gXdd9LnvjlWcvwWfW2px8P32uH+jfI/YnFARaEcfFpYys56w0Wa9lg5qF3skpWfWHW0fZr16s38EkGDTn+hywW0J6ozBIBm7zBQpUcwKq+3IePTwfxPrsmgBz2VPxfJdKLt7xKMjwW6Asgojl/wQjju5sx5jCyGG8nd/TWEXFn8sPgJx2BNeDz25fe6p+qVYl4o74eIQ+pt/bDI8LPaWnbgOSYHBvt8bmbVV3tepJv7kz/PXIwbH8ljuncCKOIf3xYV6wKlw2tGukDIEVMyoNk/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyalyKqO98eMj9oxO7m+GSWD/w4XHp3fZqTjwQMuKrM=;
 b=jtwf6eOUVHpIJz33b0MAnvjGycgebMFi54RJPVpXntkihiCnUnP8AoGnreGN6zJBmV38LK+IYmYmODE1vAG3eKKhyY/EiOfq+d0Q0mH+VbYqCkAwc3qyHwJKo3kLJHl4nQocv6F/6AraHoH3Kw13EzZ+bK+TNsDY14/Ha5+Kybu5Em4y0+NrediqGaI1lUqbQw8wDMFx1oa1pr/3trc2E0Xxxc3cuma9hDCTtmP5UQaUkM0wkWKy9WdcvTBlOAc3ZmrDUgKGhvsbUqypoO2+C/EtZ3N3a6mQo0NcFSerwPSRD2JdGWNJbbSgM0PHGJY0FfVEIU3eKnmh9GZ5BVgVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyalyKqO98eMj9oxO7m+GSWD/w4XHp3fZqTjwQMuKrM=;
 b=xBHBm7C+3B9CnlCNozN63t9Rh22i/aOkDw6UB4oz2EbDx857NYsFlnTq1A/DlaG5IFnmxxCcirAOXQ8RkOQAIJaL36QDDZH3WLFdWyRkGMLrzCmkyENoaj+Fo7sHMUkQycYghNuPyAfGRNAS8/yalw6ZU8bcdCDD8pNfUOn9JM3/TJ8Xd+ULv4eeRKmtOflJsFNF9Rr0TXZLrWWO8BIkMPiYyy8Q94H5BI/kuL/kNuwjjqwA/J+qEGcegRY7FsyawtgUYM4sLNzsY9/fdn2Nr3dZwsMkXjpujVPcqe73a89UQY+A6VFcKFZcrEKuDk2JCg6pfHgDJYG4FiFdP60Djg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13) by PAXPR08MB7396.eurprd08.prod.outlook.com
 (2603:10a6:102:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:17:19 +0000
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d]) by GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d%5]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 16:17:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/13] block/preallocate: keep zero_start above written
 data
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260930165000.303236-3-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-3-den@openvz.org>
Date: Fri, 02 Oct 2026 19:16:59 +0300
Message-Id: <179095781937.643598.2197648215507275856.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR08MB10667:EE_|PAXPR08MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6d2c7a-a824-4d78-7bef-08df20a098fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|52116014|366016|376014|56012099006|38350700014|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: z94vmAxgGGd2eOMi7SX10vZ8w4aWyMnOgQWp8QmZAGHbg719xM2lRbvdX4KRWDnZDEHLXkfAnhZHJ4pChoxdoFsSlk74r1C+4uhICBHYRW2knDlwd8orHSTKLNXop9w87SwDhQnnsjlmX0qe5mpBke/d2uEEUjgQgFKhZ7w5PANCGVTve/jP9cgE7WLoX/hqvvjTkcL/W7pNa+oB8ArjNMCJqIt0tXbzEz6tPQOTE+ZSr1v8UMAyYkx/de/NAOi/wTTsCy0fzN5K8bo0cEocWUQpDuvPfIlajtrs9orLBXOS6BCCbI//PrDxbXXBZ1wGI2ItZORi8bDEdXWxX4+bdTL8pcPTLxx7Z6V6bF5K33xX002+T4stTYg/u1XV7cvAXiqbdCl6+crDmG/hPsSuJqzctDGIikjjOJhoznJlzJJj08BAkqlw+kt2KxVUOckLuKf/sL0iEwUrk5P22lK7NbXiUgMxkKDCOyXK4NPl6Q1PI4THWeYSQHl4gkSLv4a2biW9VbRXozcRpSfVjb5zDN7kcob2M5LthRVSuoqj4vrx5NyJnzOSUOzvQi3Eur3r+5Oj8TPFhzIgtjInP2jRcs0RCB6o1ln9v9O+K50AFasSx8+DNGcLJG8JNEky5Nj734vC8SVwXns0j6JV3SknB3DbIBXLI3fx17eJORm7Gx56JD74G9sTpvjOkV1Ika4V4TY+FkN3JfII7HlDVaVUgEIa6Z7hgDo/BxRGgHxETJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR08MB10667.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(52116014)(366016)(376014)(56012099006)(38350700014)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cENRRWZhREhSM0JjOURCWW4zbHNscmM3R0J2QlY4UGYwc2RtQWsvQ0JBSXdn?=
 =?utf-8?B?SzBSMEw1WjNRa0hTSVUvbUVMSDRURDZMbUR3MzlWN0tRMVhUMWJpZDBYbmZi?=
 =?utf-8?B?Mmd0TmtlM0Mvclc3dTUzaysySFFtWUpkMFVUZjNTUnJUdXowdGJ0WjhhU3R3?=
 =?utf-8?B?azBoT1VQTEFHUU1DUXlHLytkdWVETXViNW10SzdnemIxZEtaZ01iQnRYTWVl?=
 =?utf-8?B?VVdhR0VVQ1lmakJDenM5c0hWSVkxVVRSOFNWd1YwZzEvL2UyVnBBYVJqd09Q?=
 =?utf-8?B?RStqNVN2VWF3L0ljbUJES1lTWjd3b1FEbWFSM3ZCN2NKRmIwU28rVURISkU4?=
 =?utf-8?B?QnVyQ3JJeG95amN1Z1ROR09SU1lFRGhTRGJxYzhCWmNFZnl5VlorcGRBdUNt?=
 =?utf-8?B?RitlTDVOcS9PWk1HbVNXdE1OQ1FnVW92ZkduVzdVYkJaSi9KZDNRQTRUK05t?=
 =?utf-8?B?SlBUU0tocFF5NkpBcGxwbWVScnFPZ01jMlVLOGpYS0sxRDRabStRQlZSU3dQ?=
 =?utf-8?B?cXlkUC9DRXFBL2xDTzRJMVRSNStYay9oT210THFwWURwYnBGRW10ODBFRzRP?=
 =?utf-8?B?T0s0VHRDY3J0WlplQ1RLSnIzbzdxYVdZVGJNYnpEY3FOdlBSVHRiQjMvWlhI?=
 =?utf-8?B?eUhUcDJ2K0gxQlJheG55UUgrK3pValFWb29lRkpiL1V0bHAxQllSbG9TRXJn?=
 =?utf-8?B?OEtKU0c5TUZjUFVGVFVrYnJ1Q3phKzUyTmtHUXpYdFhRTU5DRG9xWmQraVkw?=
 =?utf-8?B?MnNOODdmakllbXRYcVMzWnJuR1gyQlgwQWF0ZjhnZjVsV2c0VUJMMVpweE9w?=
 =?utf-8?B?ZVoyUXB4cVAvQ3lac1BxdmhkUEY1Qi9rOUwvKzdJaTBKKzQvYlhLYTBnRnlJ?=
 =?utf-8?B?dUVybXZZcTY2eFV5QmJQS1hFUXVFRHhpY3NEOGdnNXhJbjNmTzhTZHZYWWkx?=
 =?utf-8?B?NFpZT1dmeUVhU2RHR1RRbEd0TzVmQ05TOS8vcllyK2pFZDlFTGtNTjh0U2tj?=
 =?utf-8?B?UEY1T2lxMmdXNHFXenlCcUJNY2hGOGp2K2xDUG9mZGhvUzE5aHBqS2drWEZ0?=
 =?utf-8?B?SVpSbjQxZUZTZEN2YU5rVUszZExRUDFQM3MzUVROdDJaUll5bGZkbzhXNktQ?=
 =?utf-8?B?WUJ5ZkR2Wkl6M0YxUU1vTEF0ZVcybGlZZWlwRHVyKzFvUlFWaGJNc2xEaTR3?=
 =?utf-8?B?eitRN1VnaWhyQWQ1RnpTY3NFamdnZmp2VGJpQU45NkZGaFU0OFQwemcwOGRB?=
 =?utf-8?B?RExCVElSTHBUeXpFTjNncWVwb29qTUFWa2owTWd2MEoySnd6dFNoWlprS21Y?=
 =?utf-8?B?alNBaW9wbkFZTUl0UU5Pc21yOVh1dzBrOE0vclM1dzVpb0ZOR2dRdGNDZCtD?=
 =?utf-8?B?ZkNZa1dza0M5SGlyRGlZc0tRN3lURWhvellsQTEyZHh2VGt1cHYwUFVkSGxW?=
 =?utf-8?B?RTB0MkxVNmFiK01Kc0JWRmJtMnZpT1lsL0pHYldNOENlbEdGR3I3dm1pQVRm?=
 =?utf-8?B?TCtOcDBPVCtZMXNHYys1UGNQblQ2VnJJMHYvWHVwWU5BRytxdU4wVFRqWjhE?=
 =?utf-8?B?dVBDNWpBdmZZRE9HeFRvSTNHVWJxMmtabWR3SGMwb0ZsdDdZTDZyT0Y0bVZn?=
 =?utf-8?B?ZHBFY0orSGlyK0lBTjBSVUttVXJOSGw3NGNhekNENFEvNURHdHkwREpETjhL?=
 =?utf-8?B?a3c4c2hkNWxaUkxqem9KdFIzd0JwMFVaczRaUUd1TzJ0RlUvaHFYT1lVU2tN?=
 =?utf-8?B?U3FXaTB2cDh2S0VpSWNCN002b3QxNHd6eG5IT0lJM0lQVUoyODNGOHYxdXBw?=
 =?utf-8?B?RHMvczF5MlhkM1FKRkZ4SHNOalFoL3luanlsWUNZK01rckRpdWpJZkFXT0pp?=
 =?utf-8?B?Vnp3a21JSjZJaEEwUlIySGlGMVdYbVp1VjZlclBHam1MMzFEeFQ5VVpXdzlo?=
 =?utf-8?B?QVJaRWRKckh4QlJob25xak9RdWk2RGRGc2Nnd2tZUDl2YnJnQ2FGT3kxUERN?=
 =?utf-8?B?WHFucE5MbnQyaXUwR1dELzVRM3VVZFBCTGthc1phK3RmazRpQU9aN2FKc0pU?=
 =?utf-8?B?eXZBT3NqakU5TnBtQVJuQ0pDOTRtbjVWdHRPSjgvanZCaFN5NDR0enlrVUk2?=
 =?utf-8?B?eGFTRHVqUkRzdEFHZnZGdW1oMEJDRGxFc0ZMYXNwSmdUZGtDTjNlUlA5WHZR?=
 =?utf-8?B?YUlldXVXejliT1hlT0xNMGVXRDVqdEx4eFRFcUpnYjZLWGxzSmxEY1RlUTlF?=
 =?utf-8?B?Zms1UUc3UnBCNlMyZDdHayttUCtzQWpBYWJDUWtoZUczZ21nMUY2Q2g3SjN6?=
 =?utf-8?B?UEVmUG5aS3R6dkxldHQ5QW5PY3NDTXBTRi9IR0N4SUlsS295RlNWM1QwT1p6?=
 =?utf-8?Q?muRqbYJ9IU8O+ddo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6d2c7a-a824-4d78-7bef-08df20a098fc
X-MS-Exchange-CrossTenant-AuthSource: GVXPR08MB10667.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:17:04.5180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAx+8m5TFqqbM/fFJ7mt4Y10mPewDFxAkvS3PTl4JrQWw95m6DfGem5w4G0X2w8mZ0ryB9LA6tgIop6GeHvARIUZsk8mzChwLW09EMonw74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7396
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

> The filter records where the trailing preallocated zeroes begin, and
> skips a write zeroes request that starts at or above that point,

Just "starts"?  Maybe "skips a write zeroes request which lies within
the preallocated zeroed area"?

> because the range is zero already. A plain write below data_end returns
> before that bookkeeping, so a write into the zero region leaves the
> mark behind it.

IMHO this is hard to comprehend.  Which mark?  The 'zero_start' mark,
I suppose?  And behind the written data?

So, If I follow correctly, by this point we have 'zero_start' pointing
not at the beginning of zeroes as it should, but at actual data - that
is the bug.

> The guest then loses an acknowledged write zeroes over the range: it is
> skipped as already zero, and the plain write's data stays. Reachable
> from qcow2 when a cluster is allocated again after a discard and the
> allocating write zeroes straddles data_end.

I guess this is covered in one of subsequent tests?  Maybe either name
the test/commit, or put the test triggering this bug directly after this
commit.

> Move the mark past any write that reaches into the region it covers and
> leaves data there. want_merge_zero is what the function already uses to
> tell those apart when the write extends the file: a request that writes
> zeroes leaves the region zero and the mark where it is.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/preallocate.c b/block/preallocate.c
> index d215bc5d6d0..99bd6b1ae76 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -347,6 +347,10 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
>          }
>      }
>  
> +    if (!want_merge_zero && s->zero_start >= 0 && end > s->zero_start) {
> +        s->zero_start = end;
> +    }

Maybe (0 <= s->zero_start && s->zero_start < end).  Cosmetic, for
readability only.

The actual code and the logic LGTM.  I'd only like to make this more
readable and easier to comprehend.

Thanks,
Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

