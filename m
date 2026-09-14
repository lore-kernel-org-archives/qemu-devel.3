Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12877C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x67PR-0003SN-Nl; Mon, 14 Sep 2026 10:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x67PF-0003Rz-MS; Mon, 14 Sep 2026 10:11:39 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x67PC-0006N7-1n; Mon, 14 Sep 2026 10:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaoiwFfwM3YXhrR9Zjo3bZjoHQnmJoH99tvPDv+2/Nj2KmWnolAXtE2Z+uK/VHJOsnjqnSm5XyR+PF2HdSkDQ5b0ln65w4nVdBZs+JdFw+I/HIXQC7EyqIPacCNxZkB898mu4RdUuBbPKZ8ZFOOfALdZJYe8DhVpn9r/wTNMCd5aLYYWmfvZi23R/zN5KGk0YfYeTrLY0TFqmzAaAl5P2goFZF/UKRZZ0BxNWbinllzD+7GNog1I9WyjI4oiodev1bi46JulSun4XDT/9qCD/WsNLRCpZ46vzwcvikqnveTuAgzNd3B1SKRC7lPJ9q578Q6ILpHdv3q0l8qf9QQdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vn1mfTnR6hsnJbUiW9WNL5EQmlW10OKTpRLXFp30IY=;
 b=A2+IUEJUMjoXYKr3o9nFGQWHG2eJ8GsLj5Bv7vt+6RFPAF+Q3jkxQxUzfAhHBByx0CKgc2a4dSvIiUDniUQ0zsYTolsmchK54HygdoEXZqhIQM9XLaiK7xV2cA3KtNadok2naUzwyrk6+LELkDbsH0ZqzfPm0F4VNnhwx48K838AqoJ7N0JyXOS1tDndWGIhfNBP5ab0ELPhrPmSUqLiSjqjt403hAUyn3nCF7hFMtR5pZDIhc6mfWN6lKEaU3e3de8IRjF4gN2m16ThKPE10udrhPLpPnYHQeMzrEbt11Husw8iz6/Ksh5eksTpt10X77giZrRIqXCC4kt0MAmk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Vn1mfTnR6hsnJbUiW9WNL5EQmlW10OKTpRLXFp30IY=;
 b=dgg+7mPzIidKwygXvjciKPZmIVfFXpD+nSrh4j3rPq+G05Nyt6JjLZhpbetjdFycNuJ8Tt/EIFc/c631FFSRPFYo5r8Z9Xgk6RWXt3BU8DsT+gfkRpGLSO7bYfIaby7jHkD8nbqrGRUCTFHm4Hg3FMEWc1TBibM0X4g48e6Iv2YHnk3o3Uul6i8RLAzgB8ABt4GSfKYEVrXC70hKSF5pNHo6jYLn3uqTYUrRAE4ATWt9jKKCHfW4cXcB8d3lx97QIZeFDqrsADiZKjyfq/0wTZM72OthLQ+15+pXSGytaq6HzfeUhVFx4aTWJxYtdgeYfIBAL6rWq+ojOTVm1SK1UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by VI0PR08MB11750.eurprd08.prod.outlook.com
 (2603:10a6:800:324::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Mon, 14 Sep
 2026 14:11:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 14:11:27 +0000
Message-ID: <f0ac9978-d7e5-4bfc-a612-8aa74a8ca47e@virtuozzo.com>
Date: Mon, 14 Sep 2026 17:11:26 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest
 addresses in qxl_post_load
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
 <320463c3-973e-47cb-aa9f-153816a1b4c8@tls.msk.ru>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <320463c3-973e-47cb-aa9f-153816a1b4c8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|VI0PR08MB11750:EE_
X-MS-Office365-Filtering-Correlation-Id: a423f25f-e65a-4110-d487-08df126a110d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|3023799007|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: SNYGpmikWHoik2nkgZBqPs8bg2H4A17Run3VNSU/KHrw7LrWxb/6nFGb8JcByuvZIA85/b88lLldwFyZFg9VJP6lDD04qmtUpnY7J0ItiRF078ylLOWkP3hjd9/dZoZwB4DLhQgo3ZpGasbzi6E5ZDgYH6i9zKE3PAtolLaivOvoaG0UW5O2YwZFYtLuzIruHk9udE3S1bvmvZTRh36/cpcRenlr3n0PQRx7uElEGfwZXFv0/tNqkf0epov6xwl86PHRTRggHji9v/4ijRJ8Fzz3mIYjfYI4BWJUUwwPOaNx9R0SJZrSbJPDSFb17oNH0xdbQZiAjfJ1juBcO+NdvkbNn5emxbutA9mZQ3QwFfVCkJBCHMCO6LAeeZv9GmQrXIaC5fQWPYgYmMCgRbTxLuvrJZm9TC5Sj8rQl3tFILgOQWjvYtpDVrP8Y6sCu4rECD3XmHAEvRqg+gC3RnQ0r6XhuhIceyJ7EarqgOhGS0H5KQQAYPtcs47a6XNX5UwvJIYSktLLjaJd9DSx2nQbn7rPRpoSVC1IFz3K6KEgFx+EUYbw/G0jvNc2f4V4ChNNnUetVUITVR81jRKFhMdYQXBa9Z+KAancQy6EhUMjtm55bA4Vs/FP3DDQ0WwsNriG9ljQPkE6qr+PyaxejrjjFc0SUKmkGMfEaJanre2Xaq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVR2WEVuaXR6RGVsdkkrUHFWdXFRTjdjbUUyYjM4NDVwdzQzbzhRYXViVHZl?=
 =?utf-8?B?aUtkTkd2a3AyWk92Q3hyVDF6eXZjVWpFZjZOSmQwK0k4VjZ3MEQyVENoVytv?=
 =?utf-8?B?YXZJMDFnSkkzTkw0MFl3aC92VnQrYVNqOTV3RWk1SFhWN2NhWG5UWmFhcjg1?=
 =?utf-8?B?QlVuUXFDc1R5WHA1VXJzVXFYTTc3L3I1dmpzN1J1SzdNQmQxTGxFRGVuUnpZ?=
 =?utf-8?B?U0g3M0xoWGNyUm1CQTRtSGJBK3RycUdHVGd6N2pqakRDSkFTRys3YVZId2Jy?=
 =?utf-8?B?Y1Z4ZFRsY3JnbVFFN3kvUmdOUXBKWFBGSUM2Y1RVVjFOL1Vpamhrcy9xRGU1?=
 =?utf-8?B?UWx1R0RqRlJDN1pVUlpvNHluOVJiVFBMOStoM0szd09SLy9EWUVqdXFEOG5x?=
 =?utf-8?B?T0JFUmtiM2ptbC9DZjRxUk5yL042TUlXL2hjZ2Y4blR6QzUvVSs0ZW4yZnpo?=
 =?utf-8?B?WHluQ3UrQ0xmVCthTVlaYzR3Vyttck0xTWU4bWl3WUNQSUxaYmRFTG9oQ21q?=
 =?utf-8?B?VzVqL1AwVjYyeWorQzZlWjVrcytuYzBTeTJOa3ZJdHFQNTNtZkdSTzdHTzJL?=
 =?utf-8?B?Z0lZNGxYNE9jbkYwQkNTZkNRdWlxMGd6bG9KemY5eDdKYnFBSS8rUjZ2Tlk0?=
 =?utf-8?B?U2JXYzRQRFZsakxGZ3JodEFGVmF1ZFdsaDBDQ0t5bUM3Y0xMNUQxUDl6dWNE?=
 =?utf-8?B?cEhuZ2dPTmltT2FnMlRnMFpDMW1acDFTTDRFT0VjWTFOWEdlTU44bVYzems4?=
 =?utf-8?B?b2s0QzhqMDRaRG4wT08vcTZETm1UamdnTm9LRFkvMDNJTExPaEdLSko4Vmpx?=
 =?utf-8?B?TXl5Nkt0N3g0amt0M1JoQzBOSEc4ZU16WnFsTWdPSFZ3VzYwWC9uWHoxYi9O?=
 =?utf-8?B?ckNHczFSdG5la2RZaHhkVnBnMll6UVZMNkIxcU5wWTJ3TmdHeDJDMm05UTRO?=
 =?utf-8?B?ZHREOUJYVjBUSFU0TGZqL2J4NmtGYTJBMXc4TEkwMGg0bVlkbTUyVWVVK0R6?=
 =?utf-8?B?MU00OXpkTFhoZjVzVkQxcjJHL3RVZWpiNFlqVFdQWGdYaVJTS0g2NGVueTBN?=
 =?utf-8?B?SmZWM1YvVFBmbEpaT3VvczNkRVFXazB3V2tGVjdCeFpobmJZY0s1VXdDVmFZ?=
 =?utf-8?B?YU1VWXU4cm9talFjbWhKY3Y5alN6Tm1jUnBEUlhaYzFPODFhOWt5TEJLenh5?=
 =?utf-8?B?RkVDeUxrcTI4bWF5V0JCNm5xOHFuOEFuRHZ6ZFhUcFVvK0ZSbVNEQUJQb3hQ?=
 =?utf-8?B?NUNYbno4TWVRbXdEVThReEJNbUdMRHp4OGtFVlJHem5YR0RmS0pmMTlGd2pN?=
 =?utf-8?B?bzdieVU1T09uSXdmN1JxRVNIZ3N3R0EzZStwY05aamxYcEJ6b0VQazhROTdw?=
 =?utf-8?B?cHo5SE9hOGNUQ0ViVVU5aSt6eXJVUlQ5ZUQxY3g3dGU5Q3hybjR4RDFPSXhR?=
 =?utf-8?B?ZkJOUjhpMzhZMnlEeFE5TmNZVkkvTEI4MldRc2cwVDM5MVlwMmJmN3p2Wmlr?=
 =?utf-8?B?Q05NV2VPaVRHNWdJelUyRWRRYkhJR3NSdkZqcUZPOW9mUWU2K0xzb0YyNXFW?=
 =?utf-8?B?RmsrbTl3aXlWTGpqZXJPdFNXZlZQdDlRTmtQKzZ1UGp4L25zS21sZVFKR0Zm?=
 =?utf-8?B?M25ObjQrZTFmNE1ERDlyNTBsNUVHK1c4aTZCd0lrS3FvWVFPSWtnQzUwS2pm?=
 =?utf-8?B?cjlDUDFSV3NHWUdQU0ZrK2RmTWFvbWZaNDVheWk0bkcyNFN2Z3UzWmhmWWtP?=
 =?utf-8?B?RFBXUkYva3Q5M1B2cmNjc1BRNDRmaUVicjluazdjR2QyQmFQR0tLK2x2aVRu?=
 =?utf-8?B?Tkhldmg4Y0t4cE1EZ2xnNmxyb3Q5a1NEQ0xJbmZLZ1NWQ2t1bG5QS0lFRVht?=
 =?utf-8?B?anQ4eXI5cWJ2WlAzV09kNklFWThyZEpHZ3k0bzI5a3A0eVlPWk15U2tFbDFU?=
 =?utf-8?B?UU9ZQmxSOUlYZlNweDk0VFM5WGhnSTVNcEZmc3dzZjRNMDAwbGpxMi9NYXdh?=
 =?utf-8?B?cHQ1bjQyNy9GMGx2Zm1icWY0ZythOGFqZEpPeVRWMkd2RlFsT3VqOWpybktM?=
 =?utf-8?B?cVJZOWVleThSY2hrV2t2dy9lQVpqWTlER2V2ZFNwUTRYdXM5c1ZyTDBuQ3Js?=
 =?utf-8?B?ZGdub0IxZUplbG9ybG9WRlBsZlp6Q2d6VE5JaVVHaUF5bk0wNXVpcGZMZHl5?=
 =?utf-8?B?SlZGeEdBVkNpYUk2S2FJSFdiNkpKTEFCdFdMR1RhNFphb1ZoaTQrRlRER3lC?=
 =?utf-8?B?aUNIQ0x4cTl4ZmQrQkFpZ05INE1Pbk1ZMXVzM1NLak9QRFdGV1BrMjVWY2lB?=
 =?utf-8?B?VEJvV3daZzNRS1pocXJRUXdjM2UwYnNhS1RXOUpZdE5OTGpLTktzOUJDVGFE?=
 =?utf-8?Q?Rf5upb7/4UQAXhwQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a423f25f-e65a-4110-d487-08df126a110d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:11:27.3157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USYOycL2CW7jRB5bZi8N4EzYQoa9bH1Al1s7WM33oSdRVsuM8r7AWLZvx+juJ9RLUJ4kx7aJGjf94wJQXAHH4sivvKN6nEX8MCNzIUXJvyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11750
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 9/14/26 4:57 PM, Michael Tokarev wrote:
> On 8/25/26 20:20, Andrey Drobyshev wrote:
>> We've experienced crashes when spice-server aborts on migration target
>> when processing an invalid/stale guest address pointer.  While those are
>> hard to reproduce, it seems they can be fairly easily avoided by simply
>> skipping commands with invalid addresses in qxl_post_load.
>>
>> Andrey Drobyshev (3):
>>    hw/display/qxl: factor out qxl_guest_phys2virt()
>>    hw/display/qxl: validate replayed commands in qxl_post_load
>>    hw/display/qxl: trace skipped stale loadvm commands
>>
>>   hw/display/qxl.c        | 132 +++++++++++++++++++++++++++++-----------
>>   hw/display/trace-events |   1 +
>>   2 files changed, 97 insertions(+), 36 deletions(-)
> Hi!
> 
> Is this a qemu-stable material?  Or there's no need to bother?
> 
> Thanks,
> 
> /mjt

IMHO it's not necessarily a qemu-stable material as the crash itself is
hard to reproduce and I haven't seen other people complaining about it.
Still, feel free to pull it.

Andrey

