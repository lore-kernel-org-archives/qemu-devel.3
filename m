Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3935C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNJE-0007EO-9O; Mon, 13 Jul 2026 16:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wjNJC-0007Dq-5v; Mon, 13 Jul 2026 16:31:22 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wjNJA-0002WC-Cb; Mon, 13 Jul 2026 16:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5bwzL4OhmqMvQJQ0AOxsPMF3BSTHpR8DtVpCXl6/DFFK9yfVt0mX4+/R3H5aZIKHUckcpL5RpycQ89fnNsYcLT89gTSPs4dHV08u5XZLYMiJfQN6m8Bh0LLA8jmAXEUeDheZerMZWGFe2GfWpsm2YhNo7J5dwRGJqKWFb4PQxcTVBvWRVsFR16eqtNPt7pLfnD7kUSvmGOiZtitQpvppf6jB366iLV89r4/lMNdny1B2N3BEEc2C4htymSj9rKqq6tZOg41LoNAVc7X97CXF6IgiugUzAFkqRqkHAdtIvbPHnmPJ/1lknd4zE70+Ex04gart70FbCVdMXNS9aZpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThAvqUquaqJcKGdiw9oH2TnSlP65qd8/3psGnGii79U=;
 b=pU6LJpkKqdSWFOac6jHnw269jgL5IMaDHw3EdALC4vc6aeRkbX2yxWE4RYtj5emQIpXqxbdnANc7HZZvwaaas2vrJhdDdeoU55tV8g3BylLyBUq6vuG5zp0WB877RKS9u+OoWoIsXVEywPFSteROBAKPr2kDdUan/osKSekHBiB2n++z8gqFjvqiHy37/zJq+LVeD7sqgrlyaFry0qp/4HyIX/rkR3dwGSqlISccNc7zfpUb3G28L3kQvuy8Jb/yxIvkyed9DRDLmPDt4FGXuqtL8pStKLBci3sRe8I9cWKYprn3IR7N4VNQ24OP7q5x85BkzeQcSMOnwCNkxmc0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThAvqUquaqJcKGdiw9oH2TnSlP65qd8/3psGnGii79U=;
 b=WfS+phoDZO3rB+NyIBdR9Z2UVHDQpmtOqVKAgkZlksnSzn44BK6Ujd/FtqTapFeeBbzgNZgq2voqOBrdH/uKQ03HoX6EzxRSVuFOLs38/M83kof8FR1yC973U85Ci3UY5ddBaf5q9USobqxOq/0XoVC2+n9358Il2WtAroofjKNAk7/bJH3JvKuX1jZO/yCRKCqTdtAzZunQOfC+HfEchxDtW+cW5TtaHUyPMaeE4OTNrvRXEv5i/rvv5lREKQAUSrqx9QGqwTG7bHnPanSyrOBQ66OyZA1kp5O01fhC587xN+JId5NhMCDlNso8OWY+pr2s4v8t2Jt3Kx2dkkC9hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6128.eurprd08.prod.outlook.com (2603:10a6:102:f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 20:31:11 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:31:11 +0000
Message-ID: <9aa79971-c895-4c2c-9f68-89b1c544c16c@virtuozzo.com>
Date: Mon, 13 Jul 2026 22:31:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block/monitor: force read-only on live-added
 persistent bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
References: <20260706161645.515304-1-den@openvz.org>
 <4dda6b28-d4e1-48c4-98f4-b574746fdc71@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <4dda6b28-d4e1-48c4-98f4-b574746fdc71@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:802:2::49) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 5195aa58-872d-4590-381a-08dee11dad29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|23010399003|18002099003|22082099003|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: GS5o+yYeo3xjwONaJfeVWsYoOJ3Hd4o0HJ7WW9r6qxIQ6XB0bhQfL2tPZsOuGeGFcSE0VFjXhu2Go4tKw83olPks6+b6h/YkTRXX/5CCehUFg5s390/X/kV25FbbbBrTTAfBi7rr8LsWWQ0jEZbxj623/kyVAVLxm45qfobWSgCShz73DP6xPlXbnRWAH3mLEl3xBkcLcBeTnLrV5vR8jvq3nf11R3q+a9Rpd+daXc05jCynAPXmSIPAnmNSgP8CJ42BSJBykIXOLGV10KEJ7z8SHYEwyM+Kdaqkf5oHbd3s04CCMcP0SK8RU64Xh/wgw+PHemi+oufSq0ki1mL8EHC9hxAtYAKku2u/1K+upHX5n2nWJgkazfeshhrXomGI3/ZNSE8LzfOFIi74pR+zc4XVYAzJRKaYvC5Yfq+VMWQTYD+LyGiyU9dg2BMEaoH/Ob+O+oP8tgTKVRipuWBEq4vFmI3MAS+/0evSX3iOVqjet3CpqjgOmMhIpINs8YjFcVlhjeJNqI/ANjWBhzG7xDEvYhYkExpGiK6xEgRUa5VsDiDq1cAc6igkm0SinGMMbenH0VN9ytluKizmDtjzZllip10jXlNbpj18o1jBVCk8Bjd7LD+uATYfmDOezykV301gpXu1dnvRf3+YZX0HN04sjujmYVbAn4aupiO2Kc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alF0endFaE5OYWJ1aEhCTG9QRGtaTm8yczVIaEJPZktXR2ZxakhvV3dhL1Bv?=
 =?utf-8?B?ditERUtsRmpvWkdOY2xrQXY0WUwrN2JBclhlYjhvREhVMCtNZ2RjdmVvU2Y4?=
 =?utf-8?B?b25KNkt3RkRSc1pvaGFUcm55UTdsWUNiWEJvSlNldDlVbktsdHJRSWQ4Wk85?=
 =?utf-8?B?QTQ3RXc4UWI2ai9uT0U4ZjFFQ1N6cXptbVFFMnJxRXlITVY5WGhKNDU1OFMz?=
 =?utf-8?B?OFk2U3lVaElPd3ltVFZxSTErblQxdmxFc2hXUFl2QWgyUFdNU1lMaXZZMHo1?=
 =?utf-8?B?azdBY3lJNzNRM1Q5bm5jNHh4TUVicyt6YnVrWDlBL201dUVJYXVMc3c1OTlT?=
 =?utf-8?B?WC8rTk44TU8ya0tBdmgwM1JVSk1XQzZEanZ0eEZYQWpBZW1UK3YvN0hEN090?=
 =?utf-8?B?cHJRZHhKMW5WWXROeEtTV0hUSHFvUytrSXQwWVRvNk1JblZFVFI1VGlNUTBW?=
 =?utf-8?B?UnRwdnVZdU5qWlFRL1lsSHBnMnBJc2QxSldtU2YyTmhvbEhKZHFNbENFeUNH?=
 =?utf-8?B?OTJKakVQZHR6V0dqR3NFM0RuNVBrZEU1aTZQYUNla2xHdXdHVVpWVkZwSllF?=
 =?utf-8?B?RDd5TWU2YWxxWk16d3h0UFdCSDJHaGZrT1lscUl3U1UyS2RUUTdYdERBbFF3?=
 =?utf-8?B?TDNERXY1dXNxMS80dmF4S0dVTnFET1plVThTR0xFaHlYRjBGTldUTnJGYVFD?=
 =?utf-8?B?TU91NFFsUm9QaFdkUUlPUG05SDdxY1dKZ2hCaE1saXdJK1NGRUdiclhMQ3NL?=
 =?utf-8?B?d3NWb0tFSjRSOEtJQmE2WkNFejVRZVEzZTViV1ZhY0lka1M1VDhwVFpuRVR6?=
 =?utf-8?B?clVEdm5oaElEMUhqZlg1MGJmTmxVUDdONEN6c0NGa0cvOTB4WUJVbk5pVldI?=
 =?utf-8?B?MHdOanY3aFZnYlhMNk15a1UrMWw5VVJzaWJBSGw3aGwwN3F3azRjRjh4L0xz?=
 =?utf-8?B?cjRnU1pvSHRDSE9wakxJNUJKUDk2REF0amU5SHlJNzd3alBZdXNsbG8yZ09i?=
 =?utf-8?B?SktkUmMyOHJ2bjRrYm03M20zZEFpS04ydE54S1ZsVVZuQ1RONFNsalkvaWM1?=
 =?utf-8?B?ZTVtY21wY0xHOHI2dk44eEtseGRCOEtJeCtMY2hLRjAwcmYvSnRPQjk0RTkx?=
 =?utf-8?B?NzFPSGFUblFaeW4wbUNpcTJnWWlHdHN2ZkkvNFNPT1F3bXN5Z3NmaFZmTHla?=
 =?utf-8?B?dkRTajlTVC9wL1dTQ2FOampvS2JHTjJLWUZvSmtoZUhCRzZJbGQrNWN0emRI?=
 =?utf-8?B?WXpjVkpwMlEwVjJMdzRVeXF5eWVWc05QZWVOd3Y5N09NMWFOdlYrMHZhL2l6?=
 =?utf-8?B?SkhITHltcnc4TEVyb3JzNkxEWi9RVk0vOE9EaUNwWnpISlJtc3YyZUVtREll?=
 =?utf-8?B?RUdyVmEydW1OeSt2RlBHdnBvanFURmR1WXlMbjA0N1RQN1NaRmRtV3VLRXM4?=
 =?utf-8?B?NFJ1bVdSYmhDUjhLa0t2NitzR2VtTkhDckdGellPeXBtUDY1eWw0N3VrT1A0?=
 =?utf-8?B?SjdkOFFDamxwTG5ZWmxsVEtiVkpRQWlNNEphNVdSQU9KVWRieW5FREVOTm9G?=
 =?utf-8?B?dTlwNmRQODJJUDRRRW54OG1yVWxaR2tWQTVzK2w4RjFOMGV0bDJaNEJLdUVo?=
 =?utf-8?B?Ym1RUjVwS2Jrb3ZIdjlWeXM0U3pkTkJJczVnVVg3NWMyeU5zR1ZEWGdFT3Rl?=
 =?utf-8?B?emV0djZYaHVkUkhwTnd1SURIMnlBeW91VVlmVE1ZNGdNUktudCtuSFpPRHp3?=
 =?utf-8?B?Z0o5WXlaV1ZPRmI2cmhVRXRvU0dvUThNdmNxR3JCMm8wYUdIZS9adUM0Sng1?=
 =?utf-8?B?WXo0a1pzK29DcGx0S0FyZmVIRHVVaWg3ZWRHWG4ycmdGRkFWM0EwZ2k3SjVV?=
 =?utf-8?B?VHdNcHZwWTQyZ2s0eWo0L3doWkxmaHpjU3doOHprVW9VOFhYVEhTL2ZCd1Mx?=
 =?utf-8?B?YW5lMUhyZ3NZWUZxYjFDOWMzNFhEeEpvVy92ZVlHZk0raWFkWHJmekNKSWpo?=
 =?utf-8?B?NW5pck9jTVJXRVVrTWllSzJzajBCYlR3KzM3UEREY3JDZ1YyallFQmVMajBn?=
 =?utf-8?B?VTRSSk5hU2FvS1FnbUlZMy84TUFzUisrL2VMaThVYytFSUh6SXdRMkVoR2ZD?=
 =?utf-8?B?NmJRRUpBTWhnWFhWSkhJd0NtMmppSVBVd20vYThRMEIxam1rSEVCR0w5Mk5n?=
 =?utf-8?B?TTR5UDJhSTRGTlFMNXhFbUZaeUlWMkxZQmFwaEdtTXdCT3I5SmRIU1RxK1Bv?=
 =?utf-8?B?WXJGYzR1ZGFIK0s3d2xCdGpDVExOd21VMVJkeDk2dy9HakFJKy9LbklFM0JV?=
 =?utf-8?B?czBpelRUOU9JSnlnVzllK2plSXIyN295ajVJRDQ3OGdvbWJIdzhYQ3kvemhx?=
 =?utf-8?Q?o/ldIdFEGiuTg9SWxI44xBul61qSYhBzK+0CytRg1hnAa?=
X-MS-Exchange-AntiSpam-MessageData-1: rnYxvkD4i55pSw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5195aa58-872d-4590-381a-08dee11dad29
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:31:11.0282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNUNjSH4UYNaHaydkiQzRxaXv6sbDF05n0OUwv3Wp936T9yssYLAtBzgty8a/9Gf4j/FFMYWFAdKpZ5p561wOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6128
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 7/7/26 16:04, Vladimir Sementsov-Ogievskiy wrote:
> On 06.07.26 19:16, Denis V. Lunev wrote:
>> qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
>> checking write access to its node. bdrv_create_dirty_bitmap() always
>> creates bitmaps writable, so a persistent bitmap added live to an
>> already read-only node stays writable in memory on a node that can
>> never store it. The next global inactivation (migration completion,
>> save, or any other bdrv_inactivate_all() caller) then fails trying to
>> flush it back:
>>
>>    Lost persistent bitmaps during inactivation of node '<node>': No write access
>>    migration_block_inactivate: bdrv_inactivate_all() failed: -22
>>
>> qcow2_load_dirty_bitmaps()
>
> Hm, but qcow2_load_dirty_bitmaps() and qmp_block_dirty_bitmap_add() are different:
>
> In qcow2_load_dirty_bitmaps(), we load bitmap from the image, so we are sure,
> that the bitmap is already stored. And if image is readonly, we mark bitmap
> readonly as well. So, on exit, we assume, that bitmap is already stored,
> and don't produce "Lost bitmaps" error.
>
> In qmp_block_dirty_bitmap_add(), we create a new bitmap, that not yet stored.
> So, even if we don't modify it, the error "Lost bitmap" would be correct on
> exit, as bitmap is not stored at all.
>
> ---
>
> Also, this patch breaks the scenario of create and than merge some bitmap
> into created one. That's a breaking change, and would need a deprecation
> period.
>
> ---
>
> Still. Maybe better be more strict, and simply forbid creating persistent
> bitmaps in read-only images at all? (this will need a deprecation period
> anyway).

this was also an option. We will need a couple of additional
tweaks but the approach is ok.

I'll followup with new series.

Den

