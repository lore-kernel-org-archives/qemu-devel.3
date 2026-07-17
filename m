Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE8AC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdhi-000617-4D; Fri, 17 Jul 2026 04:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wkdhg-00060m-I3; Fri, 17 Jul 2026 04:13:52 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wkdhe-00086r-AL; Fri, 17 Jul 2026 04:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvj7XT35T8qswpmXMuPys8E5fEXBXB+Ue3oe+IhL5CbxRBG/63B9Sj7zLUjBAhHgd1RkNxqBmmgtdN9uAhlQS9t0i5iUfuZQd2yqBp4emXHqjoUIie+s5yEi9Wj8cffxgi1+AjzaLIAPdZMMreB3LqsZCwrPQhGjMlj3k7bxHbHZH6cS7VwACvHktirKckoVmZPyjNCgdTmPZtT8IgwhoNyppam095SRC91MrpWfSPhEBf/jLn+peoTZa0j6h1MkpCXTmNNdJBNEpiFO7X+bGctnhkFcKMhj3dvllavjpx3umfK48oLIR+um4OBlAlv2krS5h5OhjvOxegB0/XOqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDNWyOXejXKEUDaklInk7fZ598P3DBh9oYLYO+O0AUk=;
 b=ru6/Jc5Pj5D2kwPzoUIZes7YS66UTd5GbI9fcqVHACFXiMUDWUJx6I9MXxXF3Y24nZBpTg6k7ToymIi8gOrkwnHJ8zNsGC5Cjvs2FT6CzqLJll/ltVeoDEiA1hHuL3eUrRW4eM5LCHk6JsipF278k0OPhvVlamCBjwhINPvp5NgQ45gkyiVq6UoYbQ8iZc7gWsdJ4xLKTSFcpFfR+zVh1bvg1w4bBN0iPLOiJCc5BgJ5xzJuVkaPt8kG4DpATbZ6H6TpVfNVi0mCnGZzlZWswfs33xdN+tOc7O6CM3EFfQb1nbbtH/JbE7qHVkiX2baJxT/v2rduw8K6Y4+1W6AzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDNWyOXejXKEUDaklInk7fZ598P3DBh9oYLYO+O0AUk=;
 b=W7QYWf3KqHryAgzGkn8xR5iD2ht56Ffv6cdZ3AxkV9/2p6ghGd/nXWIhGa5M8yx1no6hSiEJRBF/UuPHWxJfOi/2ZNLjpuQhaFXChvaPZ8FcVEbeD44+ghJdApOsfOisvOQpGVgX5xdT4AVY/qLnJbD0XgNSe51i94vOzRqWVJTHhPUUIxfNAuJbrgKVlC9HtDH+DXl4kwqMNwGTR4VF1rsxr7hQzMLeHZqIiJPzXnQ/a4Q44j0md5fn1/noVG893+yajFBflwjdu84t3T4MWOPM+ZPuYiUf3pBbNwcNKQLx3sdzuPran06TNbh3yFELAho23BVetVWOXWZjzfjKpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB6454.eurprd08.prod.outlook.com (2603:10a6:20b:33a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 08:13:46 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 08:13:45 +0000
Message-ID: <4091b725-1f93-41a9-b5f5-7de962626b1d@virtuozzo.com>
Date: Fri, 17 Jul 2026 10:13:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] block/monitor: reject persistent bitmap add on a
 read-only node
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <20260716112242.3000035-2-den@openvz.org>
 <3a6ba8c2-99d8-4567-aefe-6945adf7c15f@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <3a6ba8c2-99d8-4567-aefe-6945adf7c15f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0065.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f5254a-c755-46b9-e55c-08dee3db52ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: ev5FHJiaj2DGmg8qtuThRfVl9iaRsVFK8dgL7A3mcMAKhdx2ebHQgJrAEVrHcbEF4TcWFUWVD4CyoXVSQAAIAnFPFp8dxwJayYBb5RTAVcyufv9XXhf55xssJ0XiA47W2MnS+Xe1d2DVZ3E8rwGZo/OWjp9fyLCBFWqf0R/bjZ5jUHDCnevZ+/RPxpesGLlavKDeDZFZbL56WLjlAKLYvb9UkiT+ZgtPYG+QNZUkZoVJTFw9rlrYocjpsNhgwwrE/CR7ZUFi5us1WhMATmfVql/w+pgfx1wSvWnS0q3dHcI+Odrq2u91T7SNaQgWyMoQ1qE90rkOS461uSTIObrBnTULIiJKJe0SiGWrG0S70rLzgDvh5Y/rKU6oGGbSbJixh0BLmfbZn+V1UaSK6DKNa2CSxA6QXVY8O2OU+DQVDX6V6HU55zqCMQFPx5vaStOSy8zX1UbaR07r1DSe2wjUV23A0GzaeIa0NMBy0GRYIl3LabU0pkMAdeG9MDKEtY5TC1vIED6LuHTyf94wIw5zmIAyvlmSQey7WM0XZQT8RvoobN4t15KSfbvUk9QQmGkIdYw7cpedcfJ1MHgLErtjQ/JEmpqCAVFLNwPeVNhXADThYJiIgIdCfPLT6fSzrP4nM6bMunKwecx0afbCoSnZ18qQUBnYDFWq40PlV+U4ICw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRHWW9vNmlESkw2Tm5lS2xHSm5sbXRLK3hWZFlpRXc1MjZBU1pPbGk2MDMx?=
 =?utf-8?B?NkozSU5kT2xzckVmRDFOdjRzVDNNRWpwdVo0blQyRFNBa1FudHlSNGpXZ2xB?=
 =?utf-8?B?OGVyczd4QnVHTENKc2xRRkdIN0xLQnBHRjBPT1lDN21BL3J1WEV1U0lZK2I0?=
 =?utf-8?B?Z2NuWWs4NWM0NjZIRGxIbVVqc1YxSjQyNitVK0UvNjFjMzcvNFBvVW9CYTZh?=
 =?utf-8?B?a09SZEM0cGZDVTJlSWJaVCtndE9WUFJIZC9ydS9iZDd0Vm9vdFFGY0FScnhw?=
 =?utf-8?B?NlZTMkFDVzB1dWhadE5YY2hNdzF5WEhWSVZJUU0yYTMvSFkwZnhxQS9GUStm?=
 =?utf-8?B?WU5OV1A0eW4xYU1ia05FY1JvdEwyVGZWN2FPNUlpWlZmWHZITjB6Y29TSWc2?=
 =?utf-8?B?aHh5UjJ5UmFLWUU0UHZXY0xVQjRFYTlkbm5LOGpSYWVuMVkvOXRjaEdNbUhM?=
 =?utf-8?B?YXNhb0xTSUVzT3VMQVQvN2dNQUNuUFFhR1FDdFRyWHJaRzZ6d1JyYzdNVW8y?=
 =?utf-8?B?VWc0K1pIYXUwZXB3S0gvT1VCQVg4Q3FoemdTbFhLeE5FVmJGZkZTekdrWFlE?=
 =?utf-8?B?UWJIdmVyZ0dwa3dPRWUwazNvaS80QzRYMEY2S1RtclJBcCtyUCtodHJuTlEr?=
 =?utf-8?B?UTNDNUFhZjg2ZEgzN1Q3UmZ2VnN3RTk5R2FScGpZMUZCOUp3YVZoOGhaWUl6?=
 =?utf-8?B?Z2xLV1IwcDJzUytCUCs4d2RYcy9sVXhCMXIrZjRiVGZnaWxaY0k2MFBWUVJ2?=
 =?utf-8?B?R2hKSEl0ZUg0V1VtZFRiNTBRMlZKMW9yNk9BYS92VjdPWWhIWkhEc3ZWcFhQ?=
 =?utf-8?B?ZzRBZ3R4Vk5CeDhTQlZvdncyS09IcGgyVHFrV2c5TUxXeGQxNytrMjVxRnhI?=
 =?utf-8?B?RjdYUDlGT1RGdmVOaExqMjRqcjZzRlAwd2VFQ04vUzhwcEQ5L1E0dU9ocEJs?=
 =?utf-8?B?TEQyUTBrdlhNZ1pqcFV3SGdETHRwUWVENUNDL21aOFBVRU1vYU5lVUk4ZHhY?=
 =?utf-8?B?YUxzQkE4a0l6a2N3OFFJZU1RdjVucEhUNmY1YnZCdU9uLzcyOUZrdzEvQzd1?=
 =?utf-8?B?cVpROUNoamh3ZnRQME4wMTRhd1Y3Y0JkOEZ3QUphSjlLLzUwKzFBRUYxcWJn?=
 =?utf-8?B?aUhGZHduK05aNm5xK2gwd1haejZNWGNNRHlMZUE0a1l2aHZJVUtqNkxyZ1dQ?=
 =?utf-8?B?TjJaeXdUY3EzejBMVW9JUW80VUFTbGVLVXFNQjU2bGF0ZFk0emRlRzYyOER0?=
 =?utf-8?B?NEFEbm16VGJiTHRzZDVzUG9FVTJ1Q2MxR21zU2FQNTN5MWhVdCtCYnBzSW5p?=
 =?utf-8?B?V3p2ckhXOE9UVTRLcUpLSUxQTzJPbXpXbWhmQmRYLzUvWnltTXdyUXpxNXFt?=
 =?utf-8?B?V2ZIVWRwV2tKTGFiait2VmpPMzFjaE9Cam5KemdjQzJzL3ZoRFFqOCtqR1px?=
 =?utf-8?B?MkZwejdNenp5T0tBUjIxWEg1eEdrVWZRTHBLNVRjb0o5WHYyOWhlRWxqekxY?=
 =?utf-8?B?MUp0ZHkxaVJoNkRucXh5UGxaMk5MbGFqenBiRnhBbkhYcjJVVkYrRDZPV2VP?=
 =?utf-8?B?NEl4TUMwS3IrRkpETTcyaHo2aCtWNUJUdjQrYWNEeTF3Tm1lRzRpVjlsbkln?=
 =?utf-8?B?MGhaZ3ZmaUhjTGlTbG9pYlZMMVZCRzZkWmt2TzBJSDloeEJQU29VckJyQTJu?=
 =?utf-8?B?VlNEM2F2TU5nQ0dXQ2N1akNsMnVBRitaL0d6aVA3citwb214em1UR0xUb1p6?=
 =?utf-8?B?RC9qeUIrakZubEd6K0h0K0dGQzZaTGo2dm9kOXMrWWo3K09FSEZ1WGcreVlT?=
 =?utf-8?B?V1lSYmMybDFzejdRdGI3NFFOR05mdEp4WUYxdGZCYUJ5clJoa3JqdjczcVB1?=
 =?utf-8?B?NGladzRId3M4QWozL2xBR3lOMEMzODludjZuWWFhb2diSmozY0Fxd2ZSakh3?=
 =?utf-8?B?S1JvRWVWTU51QmtKZ2ZhbEdtOW1lS1BqYlRWSVBmOHMvQ2JyUjhXUHdubXVG?=
 =?utf-8?B?YmEzZmNpbE44cEt4aHVuZkl4OXdzdHVxSmRxOTlvQXpmeEdLT1h0NHRyRHF4?=
 =?utf-8?B?U2ZaSzBJa3BzcmtyNThqWUcyVlNOT0tkQnRZdVFmUU95TFd1eVpoUDdvbm0v?=
 =?utf-8?B?czU4cDdGczdvcngwdmpqZ001WFp3d3V1K0F1YitxMFYrbHYzMTEwMVRkM1da?=
 =?utf-8?B?WGxnRTVSV3I0MjI1WFJtZzl0RzFLRUtIdGZLeHlwR2xaSXFpYld3TE9uL0Qx?=
 =?utf-8?B?QzZ0VmFuRDhOTThGc3hNKzc2U3JhQWt1aHlWbk9qU1JuTGhjMVZ4am5Dc3FW?=
 =?utf-8?B?V0dCTjlnNjYxWGk2T3F2SEExSnQ1T0s0MHFwaVVZOWI3bVdiYXFTRkE3OGF4?=
 =?utf-8?Q?UmdXfbW5k5mWd8CMA22buTXEXw4MXATs3kxonIUVeD1TR?=
X-MS-Exchange-AntiSpam-MessageData-1: B2m1K2NWtz829A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f5254a-c755-46b9-e55c-08dee3db52ab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 08:13:45.9209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZVDU0GyVJ2IT9PGfXas0BbltnYKxUf+EVlo70rhqsHznGk88iI2ox7q8m/MYp6OfXwVhYqWaHy1a4v0QZURRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6454
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

On 7/17/26 08:14, Vladimir Sementsov-Ogievskiy wrote:
> On 16.07.26 14:22, Denis V. Lunev wrote:
>> qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
>> checking write access to its node. bdrv_create_dirty_bitmap() always
>> creates bitmaps writable, so a persistent bitmap added to an
>> already read-only node stays writable in memory on a node that can
>> never store it, and the next global inactivation fails:
>>
>>    Lost persistent bitmaps during inactivation of node '<node>': No write access
>>    migration_block_inactivate: bdrv_inactivate_all() failed: -22
>>
>> Forcing it read-only instead does not help: it was never stored,
>> so it stays unpromotable on the next reopen to read-write and can
>> trip bdrv_set_dirty()'s readonly assert on the first write. Reject
>> the add instead, for both read-only and inactive nodes -- an
>> already-inactive node skips qcow2_inactivate() on close, so a
>> bitmap added during that window would never get stored either.
>> Wrapped in a transaction, this denies the whole transaction, since
>> qmp_transaction() is already all-or-none.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: John Snow <jsnow@redhat.com>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> Could it be a scenario, when user intentionally create bitmap in
> read-only image, and expect, that it would become writeable soon?
> For example before block-commit.
>
> I don't think that useful.
>
> For usual backup scenario, user will just move bitmaps from top to
> base, no need to make a bitmap, dirtied by the block-commit operation
> itself.
>
> If, for some reason we don't have bitmap in top image, but have in
> base (top is a kind of temporary snapshot), bitmaps in base would
> become writeable and accept new dirty bits as expected.
>
> Creating a new bitmap, to become actually a block-status bitmap of
> merged top base seems a strange case.. A kind of combination of
> snapshot-based and backup-based backup processes?
>
> Anyway, I think, it's quite correct immediately store an empty
> bitmap to the qcow2 image when creating it with persistent=true,
> which of course fails if image is read-only. So, I think the change
> is correct:
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
>
FYI: in reality this was faced by once once VMs are started
to be migrated and are unable to due to CBT over CDROM.
Strangely enough from time to time we do have CDROMs over
qcow2 images which leads us to this.

Den

