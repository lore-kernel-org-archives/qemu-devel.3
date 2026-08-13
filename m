Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F64C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuail-0003MZ-AP; Thu, 13 Aug 2026 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuai2-0003Cw-IR; Thu, 13 Aug 2026 15:03:24 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuai0-000176-MJ; Thu, 13 Aug 2026 15:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVNbRCuYzkQwM35qftOeY+1nJYeNu2vJzsf56TbqLgjkwL0Z8bCGZo6SBpu17c8fbjdzVJUlQhD0cvX+NMQTWDqSp6aECI9t16J1HcHS4/daVadCvVzOc9pd2c6ATL7m18PVM/+Y7xxcC3wAo3uLA722mGa4dFcdNd8T8cW6Q+ZkYhLa7IBOgYkKqFK8lYM/mVDuFZR/P5RPUUR5uoX3z7iKeaOVKakDLkICSDFWXYU0CkW1MJkzynuwwWXlrPEC6c3/CUwXi8d/n82mtWuE0SKyxj8Wd0cU5l15r5VL5SU2iYVksREAShQqLh6mCcyWVZzusPWAuie6s02exRB6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhVOMvXLbqcTxhgUOwu6KIezaQebzPVRigXiq3mHUso=;
 b=GYCD73/OhB25n45XXielEVeAHep2bkn7IcYIaY/+pC7EyYjW3x4C2cWvDYz2h3afv5T0gWnT/g0TsjFlIfVaizMMB+tdCKkrtaa8MBeJaMlpH7qirAVuk7QejQUJmbsoJK8ET/oVgh11Cp6O5xDR58oaw7qwfSuUyg4L+5Yk6BPk3eNlMM3Ctcc82lb/ZSZp//Pxpn7zXJNfklAMTj30iaGHOBRFJ+GRSPlDmGyD+pnfbmp4/Kwl01KiZauPDMusYKl4FHBspUzOr7CkUr9KxEmqS5VrOM9bMsQAGvireTKzlKsaNOuvqGRN9j62p9Y9zEaWxm8N/4NV9XMkj0+KBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhVOMvXLbqcTxhgUOwu6KIezaQebzPVRigXiq3mHUso=;
 b=j/uyYaqzL+lxVLmMAo4lPk40VuLqrmXMoX6KhC7Cl3t8ak/yimr/xUguyLCuWzXhSUBr5+jw4rjL4gnIQatnnUyBLYGJrmLbuU95Rr7XeV+4gEORP5srNl+c7qWQnjRwPDxD1m3CzCWMbAFKIBzxtZ7Nkl5Nm3pAoNy+LRMLJDh5jDrhaQ58v48mlL0ss844MkuGEejesCT2dmvi+w4glwDF1UVxg6MxZuCimj2nZ4PEfBd2dBEkzAP9r8/CBdxuNGyIAbwruUQg0/T0yeHGcBt74C0Oh1jva6SQUvXA0I68nNPKoaR314Z680/qW4Jz7kwZOk/3zWytB7qmslmqbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by MI9PR08MB664756.eurprd08.prod.outlook.com (2603:10a6:290:84::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 19:03:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 19:03:15 +0000
Message-ID: <7477733d-f51f-4ccc-8732-b03a395b635c@virtuozzo.com>
Date: Thu, 13 Aug 2026 21:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] block: reject persistent bitmaps a node can never
 store
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260716112242.3000035-1-den@openvz.org>
 <cb21314c-f664-444e-a446-f613a40b3151@virtuozzo.com>
 <148de3a9-6d9c-4511-80a0-2367e3b6b48d@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <148de3a9-6d9c-4511-80a0-2367e3b6b48d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0282.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::49) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|MI9PR08MB664756:EE_
X-MS-Office365-Filtering-Correlation-Id: 09060081-306d-45ec-52ef-08def96d879d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10070799003|22082099003|18002099003|56012099006|3023799007|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: jfnTfg2b0bPRhCJaW+W+Zl1IJ6gL+7fDRum/ycBMbZq75Rl7qP6xYmxNWEtcyBSopVPESGylmxQcflAl54SquyaQ5y4Xt4aSlBhbk0a9wuMgSfhbhMNp55xggSWIFHDRdLZdTJ+rX1O0O7ARSPs2tVaGjTCrztHmvHR5DABdXTP+XSpzinnMfIdJ8I/KcmKiUytKiDEEbo/hygR5hYpbVqdktZjS9lyiWoWfe5yY1ucMeVuBj6mgdsW6zzDXWO9hED4vA7aYwKHRunGb8S2LzhGhzRypzdymN+mii/pEYXRbh9EiG2dhPcdFFjr+dLBNruz39CTpwBjGLDPxYqzOJwZTe1AidchRx1P4rSqp4u+ijHdIwuTBjXaVjOsworUMa4bDCg5qKJieUax9U1EF3XdMfavHA+ksVYxUIRFtdvmJ0LGZz8II7bjai9UEuTwQs2U4kZ8BVt3Zsz74/q2hlFDK9y0oeVLuDHNR6yXDhl+WR2OfEmhlsev16/V8oQ6i3VUCWWdptMM7+2UzfB6lAryjJ3yRAf89gc+UcnVf6tSlIJlWJqXGL9zRmrWB5jL8paiu4HleWGGTsJgJ6ySyJZqOIpCMfNtZ7B1jlnXtiOo0Shz7+enL3ETo+iYs6itDF1rBNcSfyEKBzPIFmLwuIGYSb+tWNyvlfXrvkvhxRoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10070799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3l6ZDFUNzJxTkZ6blU4bTJqRlJLc3g0bldybmpNS1o0UkZLNXN2ZHNySW03?=
 =?utf-8?B?UkJwd3AwQ2t4VG9PenVYaDBRSEF4dysyWUdBd25KWGpYVDBrQlNkZCtoaXQ0?=
 =?utf-8?B?T1JRSklESnF5Q0Z0TlNoY09lZWhoTm1YS1BGZ2s0Vy9WU2FvcFp6UUt5ellH?=
 =?utf-8?B?aSs1UE04ZG43eHkvUjVVRzVoZVR5Q3d0Q29SWlZBMTRLaXRVRnVVK2d3TEFo?=
 =?utf-8?B?RHpzSFJ5eWxpRDVpcnZ0UVl0QWNSRndadTZNNDIwU1o3cDc0S0V0VlJtbFdJ?=
 =?utf-8?B?cEdxRmNwaVU3aDN4amhObDU4VkR5SC9OZ3JQYXM2WEdOM2xGWEx3Sk9YL3JD?=
 =?utf-8?B?bzJ4MEhRajhKajVpdWkvR2JwcDlKWjhrMmxRUTgxbWJmUDdGMGhhdGhEaGtk?=
 =?utf-8?B?WjhrK0ZBK3dlbS9xQ2plK0piS1Y3RHNBS1M3SnR3cS9aU2p6Z0l3ZHdvMm5h?=
 =?utf-8?B?SEhXaVdVQkY4TThsU0xabTRtN2FuT3pRS245Zm1nQmhyZ1pITUpJVmpmN21O?=
 =?utf-8?B?QnhuSmd6THp5Z3grcWFJNUJMUVJpU2lXNUtwZHZMTDR1Q0N5KzJhallHSTN4?=
 =?utf-8?B?eVE1akF0TTVJZXB6RFhtSk5lQ3FnNUxKMVJrY2d4dm9iMmFpaHN0RHg1NE1t?=
 =?utf-8?B?Z1BiTkU0ODh4Z053WFROa2svSWhUWFp1Y01hbUs3R203NDVHSCtXSGxOQVVq?=
 =?utf-8?B?VXlYT2VLbUlTRUhMckZnVjNub1p4dWVabE9YWHJVM1hsYUhNUjNHLzFNR0Vq?=
 =?utf-8?B?R1NXTlcvTm9rMWltSlZ2U3lSUlZTdnArUHVrRWl5U0VUNm50TzFCS01xSCt1?=
 =?utf-8?B?UnpwOTJXdThyQUFLdmQ3R0dXWXZuUS81WmVaVjRDTzJQQlorei9HTWFoRjNV?=
 =?utf-8?B?Wldxb1FxQ1J0THowWGx1Yk9tclgwU3QxeFlJTGpBYWNwM3lhdFZBYnFxT3dl?=
 =?utf-8?B?U2dhS09XOTFPSEJRNlhXbUtpUlhVL3FXTTU3MW04NHBtWjRSNlJEK3o4M2NQ?=
 =?utf-8?B?eFZ6MWNmbHFkbVk0aUtPdkh2SndwMy9UdFJCUzRzVlN3LytXTXduWkFUZVpY?=
 =?utf-8?B?R3ZRQTJMRWhpSHl1MzFVb1pDSDN5MEkvOXFpQjJJVXRnVm56dVdwRXZ3RTRY?=
 =?utf-8?B?YUx3Ris1azl6Q1VLY0NpamZZSTRSUEdNMVFvNVRrdERrWlQzRDc5YktOV1ZF?=
 =?utf-8?B?YjU4OFI4SFNxWWlGeGhsWlp6Um9Kc0hEV0pTQWU3M21xR2tqcjI4cUorM0VD?=
 =?utf-8?B?OUFaazNVb1JCWXdsMDRXWEZoV2pScngzNFRtSE9TYWI1a0hFN3dTc3RIOVdV?=
 =?utf-8?B?Z3dKOXNkdUdTQTBQWUg0OFJRSFE5UUwweUxuUFJJWnEwVkxidzJJWmFoK0Vp?=
 =?utf-8?B?YUZKdzkrdUthVjFmNkxiNTMxTXFzSmMxWjNaeU1QdElTYzV0ZDRYMUZ2elJn?=
 =?utf-8?B?a3FjeUJsS1FWMWlhODdDQ1dFOS9yY0c0QUNpOWdtb1dzUm13cXNHU2p3bC94?=
 =?utf-8?B?TC8ycy9vTzI3V1NLYUhVb09udlJpdmo1MkdXNFVkWVhaYitmTnd5azd6dG0v?=
 =?utf-8?B?VFVmdm5OeHMweXdMV240OWVKeEs3ZkY3d0RMa2ozeDEvR1ZxNEpRTmRCUjlr?=
 =?utf-8?B?Wm5yVzJCYkRJeEhFZzgvdnFNWEVLVjR6NzlXcXo5TTJPMTIwRlJ3ZXNlckdw?=
 =?utf-8?B?U2s3WXFERElyOFNSU0pDOWF0OEpNU290M1l0LzdJV0RTc0IrM1RjQmMzMHpy?=
 =?utf-8?B?NEJvTHpqQkVsUTdzN0t0QmN1NWVna3luTnBxcENXWG1zT29jYTBSU25HNHlh?=
 =?utf-8?B?YXNDSG91emphclhhUUlVMUFYMmFGSzM2NCt3NkEyU2JwdXY0Zkc1Q0pIMCsx?=
 =?utf-8?B?OFhMSEtub2pxdi9EMzBYNmc5MC9CT0tIL2o1a1BzMDFLNHYyUTFCaUhkQkNU?=
 =?utf-8?B?WExYWStwd1c1L0xhZnlKVDFmVTZEYUF1QlNSYVFFUDRlVWtQQ0NPSzdOZ09X?=
 =?utf-8?B?VEZocGRmRERPbEZGZDYrUFFDeElQOHhZMzBVWjR1UWV6QVlBRklsemR5dkNn?=
 =?utf-8?B?clV5TnQ1V2Jxa1NmdkhyZmtxZERJaXZQUFIzaytjRTZRKzI5WnFPWWhlTUFL?=
 =?utf-8?B?ZE1lT2tOTzRLVUhtejFLeEVHT1JmSlk5dGRYYjUzeEtQNXc2ZGpmU1pwSEJr?=
 =?utf-8?B?eEdBTFYrWUorQ0w0SHlBN3pkVDJ4cUFNV0w2SE9Mb1QzMnBJY2NLdk1yRVZo?=
 =?utf-8?B?b25UMUUrT1NadGlhMktBVzBkT2hFT0p0Z2poRVAvY1R0UEg2amtIZnVScDVu?=
 =?utf-8?B?WlAyaVQyZHBsWCtKbFBQNmxNR2RNbWsydE1SMXlnZHpyRG8yRUI3d3o0aXc3?=
 =?utf-8?Q?gOVczXnaQMx4xh0lbNjR1yIGGfOSWg/PJiKxKfmkq37Tn?=
X-MS-Exchange-AntiSpam-MessageData-1: gmzDn/a/q/W/9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09060081-306d-45ec-52ef-08def96d879d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:03:15.6972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrHw2bdlGpqPN0nkc4ZTS3nobrb50JyNYEY7NvD1aqnpl/7TAoGuX4TwR9y7ulfZ06ngTbrNwhfNq1eblGDwFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB664756
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

On 7/29/26 21:17, Vladimir Sementsov-Ogievskiy wrote:
> On 27.07.26 15:05, Denis V. Lunev wrote:
>> On 7/16/26 13:22, Denis V. Lunev wrote:
>>> This email originated from an IP that might not be authorized by the domain it was sent from.
>>> Do not click links or open attachments unless it is an email you expected to receive.
>>> qmp_block_dirty_bitmap_add() and the incoming-migration bitmap loader
>>> both create a persistent bitmap with bdrv_create_dirty_bitmap(), which
>>> always creates it writable, without checking whether the node can
>>> actually be written to. A persistent bitmap added to an already
>>> read-only or inactive node stays writable in memory on a node that
>>> can never store it, and the next global inactivation (migration
>>> completion, save, or any other bdrv_inactivate_all() caller) fails
>>> trying to flush it back:
>>>
>>>    Lost persistent bitmaps during inactivation of node '<node>': No write access
>>>    migration_block_inactivate: bdrv_inactivate_all() failed: -22
>>>
>>> Patch 1 rejects this at block-dirty-bitmap-add (and, wrapped in a
>>> transaction, denies the whole transaction). Patch 2 closes the same
>>> hole on the incoming-migration path. Patch 3 fixes a knock-on
>>> regression from patch 1's approach: a bitmap that was rejected from
>>> ever being written can still exist in memory read-only and must
>>> remain removable without requiring write access.
>>>
>>> v1 -> v2
>>> * approach changed to deny rather than adopt (Vladimir)
>>> * added patch to add permission check on migration path
>>> * added patch to change permissions check on bitmap drop to more natural
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> CC: Eric Blake <eblake@redhat.com>
>>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> CC: John Snow <jsnow@redhat.com>
>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>> Denis V. Lunev (3):
>>>    block/monitor: reject persistent bitmap add on a read-only node
>>>    migration/block-dirty-bitmap: reject bitmap load onto ro node
>>>    block/monitor: allow dropping a bitmap never stored on disk
>>>
>>>   block/monitor/bitmap-qmp-cmds.c               | 19 +++++++----
>>>   block/qcow2-bitmap.c                          |  9 +++++
>>>   migration/block-dirty-bitmap.c                | 22 +++++++++----
>>>   qapi/block-core.json                          |  4 ++-
>>>   tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
>>>   .../tests/migrate-bitmaps-test.out            |  4 +--
>>>   .../tests/remove-bitmap-from-backing          | 29 +++++++++++++++-
>>>   .../tests/remove-bitmap-from-backing.out      | 22 ++++++++++++-
>>>   8 files changed, 124 insertions(+), 18 deletions(-)
>>>
>> Hi, Vladimir!
>>
>> Will this go through your tree? It is looking like nobody else cares.
>>
> Yes, seems so. Thanks, applied to my block branch.
>
> There's still a chance to stop me within 2-3 weeks before 11.2 cycle opens.
>
Hmmm :-)

11.2 seems opened. Is it right time to push?

Thank you in advance,
    Den

