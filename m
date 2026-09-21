Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E867EC982F1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jsb-0000ex-5g; Mon, 21 Sep 2026 15:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jsZ-0000a1-Cq; Mon, 21 Sep 2026 15:40:43 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jsW-0000RD-V5; Mon, 21 Sep 2026 15:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM5am6dCNNFWvwRtgOIzHN2OXPo1Gf+/9SBuq50OR7Xmtwc6XRzJ3CuPIntK1LuduAI11UMd7182ytkT1fHDdc1iVWdr6b6UtPciuyLg3+AwEBqVJKaR/GNmUIUgEdk4/f0B4UZ4eQogJSk2baRB5RPhzoV2uiYohlYECdBQ3/qePBBo5hz1dxg+m5P4+30L0rvTttXqJhvu/cyHp4wY+qzNzsi/q0NKxXWzJavoWaBT/Qpbcq0WhKWwcBSq8drcWyLEvQ0XEHxgCxLN9E7gdPPsgkV8/FaWWtnFGIJl59A+b8ZujQPdQ5b2i2p5iMUKitAxSlysZtFfo0YGnUXF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfE5PcHBY+g5DHB2mWJ6XpZ1C8tuR+D8HNNgdf3MhQY=;
 b=QQX3Xb2P++o4UuqPDJaNIlLEeX2S6sRJnEQjI5rHPQLe1ps6QRg1I0QwNipWSVIb397smMATrVO191HDAF5+6oPrWP5r/TAaur2mCUX3Tk4en3CooRhoc+6zL4WBhf7OZrL3x1mSBCLNYyuzlHFlxy2jsaHs9s18GL4sOOSBkUrk5w7rrqlq0NE7XUsvMxSz39CkjxFr027Ikl9WtmsORlxgXN5UrH4Hxe+eYANew0FRe9940icEup0wEjhjMkRB6wgqiNztXQcDFBK8/rlHdpHYFARjV6lcwIiVfRlzDfoWVd+haMhMjdcCF8te4jekIs39P/jkIrXpFekQTiDP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfE5PcHBY+g5DHB2mWJ6XpZ1C8tuR+D8HNNgdf3MhQY=;
 b=gbmxAwYZHR0ZKU6bFM2bn2Z/3ZYjnvkB+DmkX1G8d5vcwd/9WdqIFCovPEnn2LHnnh8TXibhpTxWkiRZC8vNA1oT8aSe56NRqmBj6mDDS6Njw/lrcqp+nnWrT22Et+evc5BoatS9l+D8TALnu4GofAYZBn+JRkFNToDovqtnNnwt0SF5/Ktf8xq1dSzDV3FaA2+yNkSa8LoezEP4i5bWe5UbLkQ6D7jKEBVDBKd1PWAVbJ1BRwjrBlqouH5WxN2byhRiYqXHZpP2+MyR5yhyp8tKgapPqpC3Pwxs9urVw812SHjxIDO+pifWBFbKhoubdP6kkq4dxtvHS9M2wAaUOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV1PR08MB8571.eurprd08.prod.outlook.com (2603:10a6:150:83::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 19:40:31 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 19:40:31 +0000
Message-ID: <9f399ad4-889a-4083-a9b0-b83907db3092@virtuozzo.com>
Date: Mon, 21 Sep 2026 21:40:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] block/throttle-groups: fix a NULL token crash on
 group creation
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>
References: <20260908145554.3215221-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260908145554.3215221-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV1PR08MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 354ff74d-448a-45d3-8f2c-08df181831c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|23010399003|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3qf7bHXXJEGr2c4OYYfvFLcQ8w/FzJLx0Kyl1Al4plNO3v8Bh0J/c2APtZPSW0KyIxMJQF34gnHWMwjhO1HJC4UsMDA2qyaPmwe0iQbBaMyrg7hpw5RVwypRP+aaa3cB1wrJHUUceHDkDFBcn1Zun6oAhd9zf6CnRcULoG6V7+F8mbQTdhYt74cfyWqGcWmt1avyI0+9dTkPrY/LXV5KMlcS2z8+B5mDRm/c7qHN1uJTQV6LTyR0v968I+97oqnsyt5rxAIa4PulqPxsBQmvVPhLGoNe9IlpeqE2+8pQK49IJVgsq7Vw8alKlG3tQsYurX03Rbx5fW7aJ3JBZ92vI8R2HD8RfratpNlGjzNTHrGTXk2ChHdL/o/x1Uctu+nIu32vo5arGTfbvyil7IPctqos1m1xgTUlXg9mwOPM5G3745twnuwLUBUuWS8akl0012XmqMoEzQOyXgRID+P2qepQlkh3cpfdv/kXVI0/S6kmAbg5JNZ3wnVoAiHfuE9NPtCLTY6tyYi8hJ6RR0huxv6BhgI1+Zt9QEMhQLUI8zmHGqg5kkPfHobt6MXcX1pNpRfsfALsd125Nezm8NdGwpwt1u0on1JE8o/1FFwseqzzmK1KgILK+JXj8/kqyJSaGKwmOIUWG6vk0jGf3tq2VNeqhJWSFdTSP8R7lJHyrPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmcyWFlJSHVJd0V0RENMWU95WDd4MnRPUTl2NzJTclNZL28wTTR2UVpybjho?=
 =?utf-8?B?dEx6WDNLNDVFYS9yL3Nlcmx5STZ5RWVnMjF2ZmR0QUNFQXFJbzlTQWVXUElP?=
 =?utf-8?B?MG9uV3hqNDZtcWpZTjZzNnc1elFLZVJqSkhydWY0NHVMVVVJL1ZUdWRIeGtG?=
 =?utf-8?B?T0trd1NqZGlZdTAvV2VON0NjNEpFZVo0NGlTMWM2L1FhZVNjWFJQSTd0QVZT?=
 =?utf-8?B?QUVtRjZjd0w0cWFYdWpzWmttZFlySWdKWkZOQmpYMnpkUHdZa2VOVkY2K0pq?=
 =?utf-8?B?RkZIRzhxL2s3U1A5eEJkdkJQSWExZlVhMUkyTEo1ZmtHVkVjV1puMFJhYkE1?=
 =?utf-8?B?enM1cGVnU25FYkZ2eXpTWHJoUWZDRDlzOTlJQXFqSXBJbTl2NCtWTXgya0s4?=
 =?utf-8?B?YXBZUXZPSW8ySGRrQjJvSWlBNXN4Snpwa1FtK2NFSXN6ZzBzTzI5OWROZGcr?=
 =?utf-8?B?bVNnZnZVd2hZTDhHQWRUa3IxVUFQRnJpK1BpYTF5eUNPMnRtWjNJTVBCcU9y?=
 =?utf-8?B?R2ZEV2tBQk5nZlh6QzNUaW93WDdUZnJtSFNsYzk2S3cyd0Y1aW53amlrNnhH?=
 =?utf-8?B?TU5Ic3hEQU9ZdnAxakNRT0dFY2hxb2J3SGIvd01KTVZuMko1Y082WG10a1BH?=
 =?utf-8?B?UVorV1RMTmxGOUtoUkxhR0x0bUNDbVZqUEF3eVNDeFpOUk1EYUlRQjk3eW84?=
 =?utf-8?B?RmpqeDU2MzFkSkRreXBlWlRHWUN6V3dFejlkVXlpOWFHbGpWVnpTQXEzVnZL?=
 =?utf-8?B?OG5DSUFJNHBEOUJLTnhpalNmV1BxYlJQbXJ6Wm9rQ3RmNGYyV085WFQvMmpu?=
 =?utf-8?B?SXcrSzVKd1RxanRwaUgvWVpDYkttNDA3bDJETllSajlLdUdPZ3pzZmlvNmVn?=
 =?utf-8?B?NlJ5ZS8rdHpwMUxyYkV2d0RYNU1wNVZWQkw0K1MrbDh5enhuVU84bnBtQTRw?=
 =?utf-8?B?aGxvNmcxY29NOXg4U28zQXJQR2loREVvQWRGVmNYZWV4ZVpFODZvNTByOFhK?=
 =?utf-8?B?bUdsZDBkRmVyRE5zMWRMb2ZNTzUwWE9aU0tuaFNKeG00aFBMVmR4b0c5QVBu?=
 =?utf-8?B?SnBOV0FRQUZWUUhmcWJDSnNNNm82WXIrTS9waE93UUx0SnlGUzJVVGN1bXBH?=
 =?utf-8?B?WnUvMTlRekN1M0E2ajJuTVpVbFpGMEpiUjd2VUk2bnZXcmptOXNOWHh1eXBl?=
 =?utf-8?B?RFZ2YTFDT0FoME5mTnc4ZDRKbVlXcEoxRHF0ZlJ2KzVEM0lPMFVDd1lRblZ2?=
 =?utf-8?B?WlgxUEtrMy9GM1QyYnVtZGxxWEdlK21QY01MRDJmMGdQRWtBQ1BGalI4Njlz?=
 =?utf-8?B?WUdjejQyTGFGYUtQOTZRSXBraDZGNkJ3OEJ2NnQ3UWs5eHVOblIyZFpnK0h1?=
 =?utf-8?B?NmN1ZTNnbEQ1QmhxeXIvR0JLa3ZVakQxRTJ1UGFCQ2FuRTNockJKaUc0L1lk?=
 =?utf-8?B?MzJyMDFacGE5dlZ0YnBJM2ZsT01GM0RnMUw1Z2dFRnh4Q0hTR1ZRV0QwV0ls?=
 =?utf-8?B?MVduU01leCtiT0dJTmFYWE4xV3lMS0F4USszS0JCelpxbWUrWGR2SzRPZ3NR?=
 =?utf-8?B?d01JUTRLK0pENUppQ2pZNTZiTlhsTzJEU0FITmpQZ3ZOaFJvTFZHK0U5NnN2?=
 =?utf-8?B?QU9zSUc0aTl6Y0NqUE5wZzJYY25maFpwck9nREpsMENFMTFGME55b1lpUStn?=
 =?utf-8?B?d2VXVnQ2WkxLOW1OQ2Qwc2FYK1cxOE5zMnlFQmRJQXEyTEEwWXYyRHVGeGJG?=
 =?utf-8?B?QlU5d1pvcW9zMnlDVTk2RWYrOHhSMEFsbytUeUxqU3cxZExFM1ZoZlRmSkVB?=
 =?utf-8?B?VGRjbWU1T3V2bzl3SGM1L0hkZndNVFVaRXo4SEZ1QXZzWjVxOThBUkZLTmZn?=
 =?utf-8?B?RVVWOEVuenR3RmdGYmdsYUVUbFJOaXJWVUhGZzl1ejNRVkF3RW94YjNkb0xy?=
 =?utf-8?B?WmcySHBIamtTV1Vxd2tveHIvdkp5bHRNQVovc0FibmpjY3FzZ1BxRVhhZ2kx?=
 =?utf-8?B?Y2hiU3UwcDBUWXFjVHFwSkY0NE1LL240a3NkakkzakZUcnR1Yi9obFBKbkpk?=
 =?utf-8?B?UDl6NSt6NXdzbXh5M2h6UFd5UEZzalJYN2xkVGFsL1FlM0lNM0tHbE0rOHZ1?=
 =?utf-8?B?SlA4UVhlemIvcGZwSDcvMzJhRThmSjQ4NnlRTVQ0T3hPclB6MnVoMHNhdEI4?=
 =?utf-8?B?WkFYSzNMKzl2QkVmMkNteXB4YXhHTmxTMVdBYW1GeHVoZldXSFoxeUw4Sjcw?=
 =?utf-8?B?VkVTMXRlR3R1akxwbjc1Q3JUSS9DMVh4cW16TXpwQStFcVI0eEZmWHJRbGli?=
 =?utf-8?B?Wm1kS2xCMGVmSVcyUnE4T3BHRTVPdjFUaWJ6eklVdXhXU2drUC82NXplNURJ?=
 =?utf-8?Q?OksOGOiBpslN6lZ3W71YgRsYJuT34XOuocVXAbmIgUlfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: owI58er41Byerw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ff74d-448a-45d3-8f2c-08df181831c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:40:31.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46DTQceufNjDbYQWtldPOHKTCSl37l6n6F0I77ZKbxLUXP02eWQkf+ULgwj4absMiqcC1sYIhdxdEe4y6ao2eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8571
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 9/8/26 16:55, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Applying I/O limits to a disk that is already serving requests from an
> iothread can kill QEMU:
>
>   #0  throttle_group_next_tgm (tgm=0x0) at block/throttle-groups.c:185
>   #1  next_throttle_token (tgm=..., direction=THROTTLE_READ)
>   #2  throttle_group_co_io_limits_intercept (bytes=8192, ...)
>   #3  blk_co_do_preadv_part (blk=..., bytes=8192, ...)
>   #4  blk_aio_read_entry (opaque=...)
>   #5  coroutine_trampoline (i0=..., i1=...)
>
> throttle_group_register_tgm() publishes tgm->throttle_state before it
> takes tg->lock, and the group it points at is only filled in afterwards.
> A request that samples the pointer in between and wins tg->lock finds
> tg->tokens[] still NULL. The ordering is as old as the throttle group
> code, 76f4afb40f ("throttle: Add throttle group support").
>
> This was found from a production core. The group in it was brand new -
> name matching the disk, refcount 1, empty member list, both tokens NULL,
> a zeroed config because throttle_group_config() had not run yet, and
> tg->lock owned by the crashing iothread while the main thread sat
> blocked on the same lock inside throttle_group_register_tgm(). The
> trigger was libvirt applying blkdeviotune right after attaching a
> volume, while the guest was probing the new disk.
>
> The window is a couple of instructions wide. To see the bug on demand,
> widen it by hand:
>
>     --- a/block/throttle-groups.c
>     +++ b/block/throttle-groups.c
>     @@ -584,6 +584,7 @@ void throttle_group_register_tgm(...)
>          tgm->throttle_state = ts;
>          tgm->aio_context = ctx;
>          qatomic_set(&tgm->restart_pending, 0);
>
>     +    g_usleep(1000);
>          QEMU_LOCK_GUARD(&tg->lock);
>
> With that in place, any I/O against the disk during a
> block_set_io_throttle that creates the group crashes at once, and the
> patch below makes it stop.
>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
>
> Denis V. Lunev (1):
>   block/throttle-groups: fix crash when enabling I/O limits on a busy
>     disk
>
>  block/block-backend.c   | 12 ++++++------
>  block/throttle-groups.c |  4 +++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
ping

