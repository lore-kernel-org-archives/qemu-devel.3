Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBDFC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 15:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Dct-0000tT-Hf; Thu, 17 Sep 2026 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Dcp-0000t4-F5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:02:11 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Dcm-0007Ig-RI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 11:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqO8wMw09ujHIJ4qBK7dLJ9sfppdq3U2B6XALY3W0/RZQcXoSPUdnRw5+hv/CWSQ3WlAPouhwve2SnhmWUQVhhww1Ct+Y3QrsjKLQPoD7aLbzgcwy2mWUxzQ9aSqHrCQ2k1t4n6pnVhx29SFBO9r4OxObo2GwuxbxN38FzHWpYa70qoRbw7twlemmuZ2QgGA0BrV93GZXt2/QRGiIXEjUwQvx7xYsKC4y5m3asdwChpcmOPY5WSwh629fV4Iv8lVMQUtkLCuTFhwZWONQDIh2sI68KIF2aLHMxRaIPcsvFHnYTRvqKywR9HlUDdWy8s1/jEIHqxZd8mthLhf0nrN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBER8OtleAmxKRACfOAouxzXUeNVEwD2xWJcmG/H15Y=;
 b=wxGrhqEVN987MTWuEZemPQoKYxlFj4BApCIlIUSqMIhhAFachmhpy1l/Erw50hjVkdYoD/pvGiNlWxbsknlqb3Zl9RZ8c93+G/DE5+OOzXHb41+bH3ztstM7+qLq9GxvatMPX7I54gVJw9Kms22CuSmnn4c8XArPvGpHTvI27o+07bx2J2bM+GDDZS9+TczgtUfCEratRYjbIfjePD/LjAM1UCAfe4k3n02DAD+mBt6cxG1pfzvToi8wFmMJlGZCefUNHOkn3QZxD4O1YQs5NKruHFrqY2rNIkShMl5V/WCEjz4nd6Oy6GssaYyrLykFt+ZXafPgE+ZlnX6YcM88Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBER8OtleAmxKRACfOAouxzXUeNVEwD2xWJcmG/H15Y=;
 b=k2fWaAHFzARvaaW54b2mkRU7vH8fUi7IC1xtCAW0h6aCvhhc/LVfE9m39mLiTFXJ1pLA3/hhSKjRx7DQq9Q53rBcP8o91m62bvXYjnuObKfqwLbFogR9FgKpm6+nQoRbtPmRlw3abb7tfZ8VgK1HE8RrZ6CL7QrBi217MAcPGg44aJ14N1nr76utelFNax0GQmLwJw/nqLpYPxmIjfiepgUSRQIaCIoqU22uxqGNtCnLfME5cHeBGgsOtH/edGpZcJ4beZfO1twyDQ18UlHYwo5/9f9+Rx8BhMAkfke0wlAjA8X6y6Hi5OW1mgQoCyLBMgKtZBNxjRxRvfC2bonMrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8374.eurprd08.prod.outlook.com
 (2603:10a6:10:409::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 15:02:02 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 15:02:02 +0000
Message-ID: <9b81c730-b462-400e-baaf-8efca097f761@virtuozzo.com>
Date: Thu, 17 Sep 2026 18:02:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] migration/cpr: support vhost-vsock devices
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de,
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com,
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com,
 dongli.zhang@oracle.com, peterx@redhat.com
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <3e3ba3a6-1437-4b36-b1d6-8434c1005499@yandex-team.ru>
 <ed87c09d-f750-4ea1-abad-2777792564a8@virtuozzo.com>
 <77262e37-0466-466d-b7ac-f69306f2478e@yandex-team.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <77262e37-0466-466d-b7ac-f69306f2478e@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce9f04a-332f-4734-0b96-08df14cca125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N3apFd690a9PyEQ3yhtUXpsMgouBrC89hXOQj0XdS6VDA7JxlLffPkte3FbiCgKk8dUin7Jun6l5c2waKS4Pp5JzUqTaPYsGI0xcIZUYRImqJKiP/5AgKhl4k/i3kt1ggSD4DStH43BTCo6VEGLE9fgKOgOoH29fmJhKUcMWmMR/N3M5HE3XKst2/kwRr3Q41B4uGQ5lpFm3eLdR74t4j2SYSuJVemx0NA5vVFDRbUzrDiWu7pDYzl4CbwWfeAy+1TaR9L8eqoEFljRebKt4VGH0P/1cVCmT3Y+jvoqB7gBlXYj6Zg1hPF2aVAlgau7NCnPZd9vQPud4g4XJ8fvq19k7BPwcdfbdeCtOLs66OQIUK/7v54T+l56oirKuAkhVAOK4tOf9Xgi/w85ZyRwWys2M+d7Hv/Bf8SGq7K4ybv0TUsX83MGZOkAE9ouzCYWWOgmIMQgDAsuKRswM2YmJup9CnRgvaYh1EB0VdzoYx0kJXOd6YxZWpyLeN//cVqvLgdAu4kDurk2jMlJlx66hU1zAqPUBW1pIZFndE+DdBHZd6WRFx7tRvVgnVROL0cS0PW7KuqfPOjpcMAe1bWr5b32yjzS1GeCHDwhZoS3pUwC61FsV6nsLkx61VMERRJ293oXWXkO3Js41jjz3/BQ5TrhkklTi+VF+RI0WYK5MRIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0kwV1VYTVdlQ3JMT2RqZ1RSRTFlVG4weGZPa0s3Q2hCYUxseUZzWTNFOUdq?=
 =?utf-8?B?dXN1ajVrTVRxWHI3cDNsb1Z0Yk9kUzBhMGtnMVhjNll1ZjVUTkRLdWJiNmFQ?=
 =?utf-8?B?Zzk5Z28xOEE1Z3BvbnkxMUdiMU12OUU5OWtPTnlZTWZYR25vMG1xVlJDZUJJ?=
 =?utf-8?B?UFg3cXBwZkVQTmY3S09KUUorUXBET3ZIM01FZytmenc0bkJKV0RmUlYxV1Fx?=
 =?utf-8?B?ZlpJa083TlNXSWVPS09aUGRJa1F1bmZMdFY0TmdObkRvVU4rRU5WdnZ1RjV4?=
 =?utf-8?B?alhIczc0NDk4dG9sKzdGVVRaT0hCdlB2eGE2ZUw3bWZFWjVNSzhUZDVrTWxC?=
 =?utf-8?B?bFc2Wm1URkVJYy8wemd3cFdXczR5M1VwbE9aVUpiOXdmL2xjT1I2V3Jpd0JO?=
 =?utf-8?B?MytTQllGWlcrNUV1LzZRZmkwSmJlS0JLUS9PM2JUZ0RyTWRUNUl6ZkFsY0dC?=
 =?utf-8?B?WkRqOFhYeXdZelVVY0k2Qy9qMzc4OXpzSjNuYnRSZkhvR2lkZElyalczWW55?=
 =?utf-8?B?UjlBdGliSE5zQTd6MjVHOUlKa3ArR0xhTDhoanFyRzNHYlRaNWwvTnZ2UTM1?=
 =?utf-8?B?cWxscjh3U1Q3K2lFWlBGb24zTGhPU3duY2RwK0V1RXZYMlB6UklIWm81OFl4?=
 =?utf-8?B?bGoxNFNUMVFhNy94ckoyQWgvM1BqNTZCMmtDa1dXWVFiY2F5OHJlbzd6L3Fh?=
 =?utf-8?B?eFVzbVJVZUZVT1F4ajNZWUwyK3h0Q0duQm9jWlJ1WUczdkJIVE1lNFBTbnFM?=
 =?utf-8?B?Q3dWQ1VQc3A5N2VwNER1NEFrdVVVeklwNzhIYmVsRGlSOUdncnZ2RXU1YkdW?=
 =?utf-8?B?a2FQOTJuTENSamRYTG5Lb3loWlNkMjY5cGtCSVlqTUxQeVFIck9wa1kyUkNV?=
 =?utf-8?B?eW9mU05qYlJmSFZsYnNyTTQydVhDSWNYNG83YTM1dmVoczFrVW5pLzVkL1dv?=
 =?utf-8?B?Sm5sRGk2THRmdE5yQUtzSmhUbW5ncTNLRXRQVTQwUUZ5U1IwbkZjdS9pOTFU?=
 =?utf-8?B?SGJPV3IwQW0wcElhZkpJbk5sSW4wOFhtV3p0N0FEbVlsQy9OQ1Yra1NLNUI0?=
 =?utf-8?B?ZlJ4dFd2WXI5emNvaTd6UnhzNCs2MWcrOU5TTnRVcnowV3c5d2FlWUlIRllw?=
 =?utf-8?B?MkpYV0ZURVg0WFFQck9TakJHS0xSOEQzS1E2OGNoRG9LcnBDQ256ZisvU3Ro?=
 =?utf-8?B?RDBBTHdqdzdhZmZPQkdNL2U0L2ZWbjJkS0lobTVGMzFiaFY3UjJJUHF1YVVO?=
 =?utf-8?B?ZVQwVmJUbTN3em94Tyt5SnNnZE1MUHFsNitWZHNUTVJrY1J2aG43Y0RJaTNR?=
 =?utf-8?B?Nm8xVjVtOUlmMmZoV1JZWnB0aDAybHcvQk1JQVhxZlF1aXZ1MTlUV0JrZmVR?=
 =?utf-8?B?eXlXNFBWYllLS0dUZElkVjRranNNaUV5OG85akxTTXdJSU53MFVxeUpQNWRY?=
 =?utf-8?B?Y0RFSk5NR1hZRjUyTjlvZmRCUEZnbmMvL1NaRU1MUjlMTG1UTXNkVFdrM1li?=
 =?utf-8?B?TnpBR2JmWWtBYkVjYmM3ODZLdVdQcXR0M1hVOGhON1pXQzByQXVQakZndVFF?=
 =?utf-8?B?SHdVeTNhRHFKZ2hPemQwUTVhbklKQ3lqOTUyTG5QbUFYSGVPa3UyYUw1YzhL?=
 =?utf-8?B?OHdUU3plOWxhU0hoaUUwOXVhSUthdWZDT1JyNFF0K3BSUmgrSGxWZ0ZlUlln?=
 =?utf-8?B?VEw4YWpvc3RWTkxpUXhsL0VaTUlkV21DRWxtTXptaFI0U2hzR3hWT2NodTUw?=
 =?utf-8?B?OXVsSFVvOGJ1T3c4TGJEK1ArUlhGb1VKaGQ2WW1jK3dKUkFza3JmdEtLMEho?=
 =?utf-8?B?N3hzZkRTR0NXR1BDU094U25PKy9MT2RSUVBSajkza3hzVzRtLzNHU2N3TS8w?=
 =?utf-8?B?TkM5YUd2T0xsN2JwNXc2cDFsOVkrY1BIRldGT3NrTjdjakZWclVlNytaQmxv?=
 =?utf-8?B?SFJUcmtib1VzcklYUWtDRTQ1c0JubTlEaXVUKytPYTNiNFlTekN6WEN4VWla?=
 =?utf-8?B?SGFNZGhJN1NLYzVOMHZ0bEQ3em5iZWhBVEQyaVhCUFl4cGxPYWFJV3YrVUcx?=
 =?utf-8?B?ZDZ0QmIzY3Z5dkVwVlNQOW5zY01tWkk2dzRkaGJVdDdDaW4rZ092eG55NlRw?=
 =?utf-8?B?aUNOTnk4NFVqaHA3WFlsSGhSaTI3aFcyKzJscmR0TjNlOUZZRTRMUjNtY2F2?=
 =?utf-8?B?aktaaEJ6OHhGSzMwdzBzQjhMRkVPK3BkOWNCWmxYQ3JmWGJkdW42ejJmVGtJ?=
 =?utf-8?B?RTh0ck9HMDdCUUhueVBSbUZIVG1Hblk5V2FvMUFsNXJPSkF3WXBibGtVc2gw?=
 =?utf-8?B?cW9veUs2Sjd5WU9sWS9FVUgwM2VvaUcyb3pmVXNzUmlBTXIzMkU3b1lGcW1l?=
 =?utf-8?Q?FWQ5zJmOYJa8uz9M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce9f04a-332f-4734-0b96-08df14cca125
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:02:02.0847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fk6YffhJWL6UqxkPKf0qeeeqmOH9QRH4vdnzmrvERyWLoh1ekIXJacypS3jjn2cdt9msIib2j/wururUP8leHv2srfAbhS0LjPrg0H7Z9uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8374
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 9/17/26 4:06 PM, Vladimir Sementsov-Ogievskiy wrote:
> On 17.09.26 15:32, Andrey Drobyshev wrote:
>> On 9/17/26 9:03 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> On 15.09.26 23:59, Andrey Drobyshev wrote:
>>>> v5 -> v6:
>>>>
>>>>     * Patch 9:
>>>>       - use the device path (qdev_get_dev_path(), i.e. the device's
>>>>         address on the bus) + "vhost-vsock" suffix as the CPR key instead
>>>>         of the device ID;
>>>>       - drop the device ID requirement altogether;
>>>>       - introduce 'cpr_incoming' local here rather than in patch 14.
>>>>
>>>>     * Patch 14:
>>>>       - lift the CPR blocker entirely instead of keeping it for ID-less
>>>>         devices;
>>>>       - skip RESET_OWNER in .pre_save() if the ownership was already
>>>>         released by a previous failed CPR attempt;
>>>>       - reword commit message.
>>>>
>>>> v5: https://lore.kernel.org/qemu-devel/20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> Andrey Drobyshev (14):
>>>>         migration/cpr: forbid saving duplicate CprFds into hash table
>>>>         tests/unit: add test for duplicate keys in CPR FD table
>>>>         migration: forbid snapshots in CPR migration modes
>>>>         tests/qtest/migration: add test for snapshot rejection in CPR modes
>>>>         vhost-vsock: block CPR migration modes
>>>>         vhost: add vhost_reset_owner op
>>>>         vhost-vsock: don't reset connections during CPR
>>>>         vhost-vsock: fix FD leak in realize()
>>>>         vhost-vsock: preserve vhost FD during CPR
>>>>         vhost: factor out vhost_dev_init_backend()
>>>>         vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>>>         vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>>         vhost: add vhost_dev_is_initialized() helper
>>>>         vhost-vsock: hand off device ownership across CPR
>>>>
>>>>    backends/hostmem-memfd.c          |   5 +-
>>>>    backends/hostmem-shm.c            |   5 +-
>>>>    backends/iommufd.c                |   4 +-
>>>>    hw/vfio/container-legacy.c        |  17 ++--
>>>>    hw/vfio/cpr-legacy.c              |  10 +-
>>>>    hw/vfio/cpr.c                     |   6 +-
>>>>    hw/vfio/pci.c                     |   5 +-
>>>>    hw/virtio/vhost-kernel.c          |   6 ++
>>>>    hw/virtio/vhost-vsock.c           | 193 +++++++++++++++++++++++++++++++++++---
>>>>    hw/virtio/vhost.c                 |  57 ++++++++---
>>>>    include/hw/vfio/vfio-cpr.h        |   6 +-
>>>>    include/hw/virtio/vhost-backend.h |   2 +
>>>>    include/hw/virtio/vhost-vsock.h   |   1 +
>>>>    include/hw/virtio/vhost.h         |  61 ++++++++++++
>>>>    include/migration/cpr.h           |   2 +-
>>>>    migration/cpr.c                   |  55 +++++++----
>>>>    migration/options.c               |   7 ++
>>>>    system/physmem.c                  |   5 +-
>>>>    tests/qtest/migration/cpr-tests.c |  36 ++++++-
>>>>    tests/unit/meson.build            |   1 +
>>>>    tests/unit/test-cpr.c             |  98 +++++++++++++++++++
>>>>    21 files changed, 512 insertions(+), 70 deletions(-)
>>>> ---
>>>> base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
>>>> change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a
>>>>
>>>> Best regards,
>>>> --
>>>> Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>> Hi! Don't you add a test for new functionality?
>> Hi Vladimir,
>>
>> You're right, there's no dedicated tests yet.  Basically there're 2
>> levels of testing:
>>
>> 1) Launch QEMU without a guest, with the device in question, and perform
>> a CPR.  Here we just test that QEMU survives the CPR op, i.e. that FD
>> and device handling is fine from the QEMU side.
>>
>> 2) Actual test would be launching QEMU with a real guest, launch
>> host<->guest data transfer and perform CPR during that.  That's what
>> I've been testing when preparing this series.
>>
>> As for the guest, AFAICT there're some functional tests which launch
>> Fedora.  So this part should be doable.
> 
> If you want, look at my [PATCH 1/5] tests/functional: add test_tap_migration
> 
> https://lore.kernel.org/qemu-devel/20260914175351.393680-2-vsementsov@yandex-team.ru/
> 
> it does local migration with live guest.

Yes, your test indeed looks like I can derive a lot of things from it.
Thanks!
>>  However one requirement for
>> both tests to work is the host kernel having RESET_OWNER support -
>> that's added by our recent kernel series, which isn't yet merged to
>> kernel master as of now.  So whichever Linux distro you run on your host
>> now - it doesn't have this support and is not going to work.
>>
>> I'm not sure it makes sense adding a test which nobody else'd be able to
>> run unless they build their own kernel.  What do you think?
>>
> 
> But one day it (RESET_OWNER) will be merged, I assume? Would be good to
> have a test at the moment.
> 
> I don't insist. My (self-serving) idea is that if I have a test, it would
> be easier to experiment and try to bring a "local migration" interface
> here (like in the recently merged TAP series) :). Of course, not merged
> RESET_OWNER make such experiments less possible just now..
> 
> For you, the test is the only thing that protects your code from being
> broken by other changes. Even if you're the only one running this test,
> when it breaks, you can bisect the breaking commit and say,
> "Hey, you've broken the existing test with this commit.". Without the
> test — you have no guarantee and no weapon.

Sure we do already have RESET_OWNER in our downstream kernel, so I agree
with you that this functionality is non-trivial and adding a test to our
own downstream makes perfect sense.  I was just not sure that it's
meaningful to add it in the upstream where it's known to fail (at least
for now).  But now that I think of it - the feature itself is also not
fully working now with the lack of RESET_OWNER support, so we might as
well add the tests along with the actual feature implementation.

Thanks,
Andrey

