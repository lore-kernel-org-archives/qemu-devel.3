Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1oh-0001YQ-2d; Mon, 18 May 2026 13:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wP1oe-0001Vu-Kj; Mon, 18 May 2026 13:31:44 -0400
Received: from mail-westeuropeazon11020110.outbound.protection.outlook.com
 ([52.101.69.110] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wP1oc-00079V-6o; Mon, 18 May 2026 13:31:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwBO5oyflOgDCA5VLvT9gMs41tUwZPIi+TjnftZbLc/4a+OhRNmBk15Yje2CeZ+8jNeLR7w5YPz+cPfzJ5sDEmO3EhDMxFzSJ5V7cnX4Q/n9iw6DONCR2sFmZ6b8UNCwrXQCVmmWKs9SWHzwhm1+jVQhHs4xcdtOpGPJjunx7xxpBQEdXRzCjxa62uzqdrLEVexp5ErbwKKIoNG9FRi6yR6tdD7JUynCTjhq5hycsgzxxncsGFyVUxi003PC/N3XTduOzjnVuwXNlpLUrqg0Jztznz+6qxU2g7z2qsP8XLVj6jvydPlQEt+D6w6u2DgezAyd//ffvhHc/xlduot1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV9IxN9Zpc93G8ARcCofFjtl8HO979SVfTnPJLd5xEA=;
 b=LAD3POigZyshZ9cn9OibpbT1nnUHHpx1tntVXDX/bhlwjedt449ZmOmHitCjlt4IfUqq2jwnMq/9LeXpPg0Dkh92AcqyXEq4m9cx4OqCDfbR7ESK79LZRqKbstJ4YBsWZNYXi4zyzEOYvoLKEnuPonDawHFbLc0E30gcF3MtviUKWM9b3p5tsBXioq2tkFjXbOOL66IjR9nXbeWq7JqG9SSeiM6FiKRyz1gV2sur0RLmhgT7Gcbps9qZ1JwM4fkqQ21prf33hkpP4u0TO6E4U/uo0tq5e4CXL8GQHPodY71cv/RIC92f74xge8ZjfSg1Be97MDKPuqx7JEZwPlGbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV9IxN9Zpc93G8ARcCofFjtl8HO979SVfTnPJLd5xEA=;
 b=0cH37h/Xm0fl2nr/dEMyU6z1oQ/+pZB4e+1ruaQrvuv//tHmGu40ppdQqpHF3Dx9dd0k96SyS5sBbkKrdBAo2otSIhcsvpLqpuDLq4voqVcIeglrAMu5ihtx4Iwurc5YfJIgDWY/uw+wtzkXu3TnzdEPgJJcWt0HruNyn30/eInzhtZqFRzcfJmWLMvtV5nMXZGF7/1FKKHzu2iCFrIWFQ7wzS1kDZNT2eWU7aCRczqe5OxU9Sb20Km1J1pY55iFc5VuT0ySm+kNZYI0cdM1myB70JAipwLWS2xfz7DKrIz70IiXF6LaldQW74EfykbMO6CsmTM1a+vCZaOgTZ8FsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by VE1PR08MB5581.eurprd08.prod.outlook.com (2603:10a6:800:1a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 17:26:32 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 17:26:32 +0000
Message-ID: <e9a08b56-8efb-45c2-97f2-2ce7913cc362@virtuozzo.com>
Date: Mon, 18 May 2026 19:26:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/qcow2: fix hangup in cache_clean_timer
 cancellation
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
References: <20260424103917.248668-1-den@openvz.org>
 <20260424103917.248668-3-den@openvz.org> <agcYkmTWud8euTds@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <agcYkmTWud8euTds@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::16) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|VE1PR08MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: c33d9b96-13c6-49d0-7bef-08deb5029ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: cOsxqH9xqKJ7Z5xKNDHXvAGTaLXANMruoOxupio6Kp3TQjfxgFzfQbFDfalJvv4E8XbVs+5KlJV2jHgx+u+PY4B1z9yeXslwEEit6kO4NLm/yCsXQIturh5/0DhR0wbNAZ96uO328CUNNC3K/ktiWhQUK6rWn2WRcDkYk0zqHUOTzEnMOs4hFEPIDkAMirSD/tGiJAfOIwBlbWs5jLc4Oabl0qC6MGygq4tXHTIHS/5pRmbdrLvBTuwCKhRe9ucRjqBCKpkCtLQmJ3gqcxWi2GjMjkV2Y0ovbW+9M8mtcnF0CKBS/J9ZBTbgbveL/XRZ3NkjoqqGDDoaWWKjjtdenAZmVGjiZvJr1AkNk7vo+SE3qPgI0i0RtqN8ibsMamcXJDn4jrg7eblkI3oH4kw5a+ZI0XBl+x9YLCD9ATDbbv50XxPnsAWm5QVlxhNoRYL5LeBVwzhJte2pCF7o18VrxyhRF7PwQ3aToVYl1U5Ak7/bh+mme8kyxLc0Tjs7OKildwUjQhKRGn1SZ6481owIj8C5ywiAAE+HInzGgJv5elGFMpwBbx9OlGbkqgoDunffQXUyi8F913U4IQHRasXYajrFYW6dj9sMphnx7kNoC2F/sVjfHJQId7ycsYwPAikIeAogsApSwTJLbna/UO/MUVrQsH8g4X36kQmwAWDr2//dw0tr0W4l0Lmaa5c5BshL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFWUzB2UlVocDFpWVRVWU9tVC9ITVdJaHdYVDkrdUxTTXlOdlo0ekFHRnhO?=
 =?utf-8?B?bVJkNllNN3JqdlNsdHVHdzNPeXlrdC8rWE51YjBNTEFFeTh0bGhaaUJoaUt2?=
 =?utf-8?B?R0pKTXFhUFIxaGtsc0JMdGVFcCt3S3Ftbk1oby9ocWZjZVFpR1BlZ1BFVGdN?=
 =?utf-8?B?bjI1MSt3d2JTU001b0ZKdDdob3NPZ3JHalNWVEhPcVNENVgzZkJ6MERpUEN2?=
 =?utf-8?B?L2gyWFRJRzhLYWVLYmJzQUFobCs4UVhSbXMzb0J0WE91a0JObHJVUjVNRExm?=
 =?utf-8?B?QjR2NFFZYm5IVWhiN0FYZGZqNHJFK3haZjlIZUN1bmhqQ3ZveDk3U2M4ZG9I?=
 =?utf-8?B?S3dhZmp0a3hsSXdmWXlxZXUwNDE5MFE3eUZWMzA5dHE2US9mV25vVUJPbjht?=
 =?utf-8?B?Z3ROM3FGVFpRS3VpbCtGaWFzZ2wvNVZ0L2E5QlN3SVdRakw3Y2FVZkxDOHBt?=
 =?utf-8?B?WVQwN0F4UGx3bSsxTm5pRk9DcFZ2Qi9xcHRscWFUazNWb3VnOUliSHZuSEdw?=
 =?utf-8?B?dTVQKzRYRDA5M2VESmd2NHJHcmhPcks0VEpxVEI1b3RWZ21YSEJSMFV1a2F4?=
 =?utf-8?B?MXJsb2IzUm44dUdodXpiVlk0eWlYTFF0aXNrbG1YSk8xOXhQUTZ6aTIrdkpM?=
 =?utf-8?B?T3hRdDNqWlc0YTFBeTN6TWlna2JNVWJWSDVlQy8xUzRaa1I4Nlg1bTFkMHNz?=
 =?utf-8?B?NXRvQkllbEJudUJwRDg4QTQ4WVV4emtlK0FPaW85YmVrdlI4ck5HM1VPUjlJ?=
 =?utf-8?B?aFhUYnM0ZFMveVAxRnFzTGdyVkFzOVE0TloySWdMaFhCQ21jdmVIRTNsL01L?=
 =?utf-8?B?QTRjL0FFbE93d1RaeU9ncHIwYzZENkRVQ3ZiSUpvd0VBcjJEV0RRUWxyL2VK?=
 =?utf-8?B?ZXdYcDU2UHJiQ2hWK3oxQktpSHV4eElNYkU5M21nSTVHdHkwc2F0WUhDK292?=
 =?utf-8?B?bkRPa2U3MlV0RTlQV0NDbWJGN1JSMERUQVR6NS93dVN4RCtKWHNjZ3VGK0cx?=
 =?utf-8?B?eHA3VUtxNC9xd1FlajVaOXBETHgrQWR3dVFVdktSb3M1b0xsbENnRlpwWkFI?=
 =?utf-8?B?R2xSc3crajNvZVRQaFp5Wk0rNmd4cysyOUp6TnpxbUlqZzV3QkRsT01xcXc4?=
 =?utf-8?B?TkR6c1ZUMUM1KzlJTndhdjV0RmhDQ3dWUlVlN0xJK1oxR3I1c3hXVTIxZk1k?=
 =?utf-8?B?V3lUb1RlUzg5OXF2alRwSVJrVVVPVENDbFhwVnVETk9OL0RUSUIrUFdoQlZQ?=
 =?utf-8?B?ZngvTExMWis3REo3M3JzdjEycHRmcXVLZk5NTkd4ci8yckNBTUl2R0pXcFNv?=
 =?utf-8?B?TGhpNFBPMVJSTzloT0FEcHFPcGxPRytoVTFOU0Jyc2QzaHhLRjJBaEpWcG5G?=
 =?utf-8?B?ejFtZ1JlRU1DRnJRd2dKMytVaWNNMW1WY3JGOVlLWDRobTlyM2dETTlzNFgz?=
 =?utf-8?B?MVZMaTRDY1NkZEFod1dRZTcySThhUlIrYnBRVDJFUEZuZHJmczFiczVJOGJz?=
 =?utf-8?B?ckFTdjA3c0NVN1lNa05ISWcrNlpZM1h1MjJEb0lZU2oySHpRdFhneHJTaXEw?=
 =?utf-8?B?VUZqR0Q5RVZTZ0xPd0ZsQVorV3lVRmR6WGtZUWZGQzBxNGFlbDBpSjdZVjFl?=
 =?utf-8?B?QU55dWVuemRwOUNhM2lMREFhYjIwcytCdEM2Ni85U1NtN3lLVy83NTRtTHMx?=
 =?utf-8?B?M3JvTzlYQXZuWWIwNGlDMlhWMGRuZXV0WGFDWUFJUWFVS1pQdzhYdmpCbWY3?=
 =?utf-8?B?d0hxT3EzanJlYUwrTzJybU90UmUvc0FSdU83bjFYdXNqMHBYaHcwUDZuODlo?=
 =?utf-8?B?cmRRQTNaN0E1cHJaRHA5Y0dIakFsM1dqS1lUL2F4UXFqN2lIM0Q3ajdZRG1n?=
 =?utf-8?B?aTZiNkt1WHlVTE5nUmdoV1o1eDF3NW54UStkR2ZBZStPeVJFaVNnbmVETTZ3?=
 =?utf-8?B?NXFOV0pWc0laUmpob2tSUTFWVDAzZlFZUWF1dTRyejBsUXBybklNUkVOa0d2?=
 =?utf-8?B?dGZIQzJ0YWFMWlNMSWt0TUQrb2x4cEREZndxb0luSFNpUGlvelFMRUZBelNS?=
 =?utf-8?B?YTFSVnhYZWFIM2NmY3hocHRMbXkwVFI0T3NvdXlqUDFEaW5HMlQ5SGdZVGtV?=
 =?utf-8?B?SEFBVDY3SVpObWVzNWJONnpSZi9URDJjOXJOUkJ6ZnZKbVRnNE1xaVhRRUUv?=
 =?utf-8?B?aVlWcUJrK3VUTHFobE0ra0VkN2RVUGtGajZSVEorWU9CSWVFMmM1RzNvbDF3?=
 =?utf-8?B?ais2Mm1ndThZWDhMbjQwNGZQS3JHdFV0eGUvbFRIUHU0bXhkd05YOTZFZEI2?=
 =?utf-8?B?ckJ5YUlDSld6TDZZZDFWMUdqREtpKzMvWFVaaVJjUE5uWDlVbWx4bnVMY0ps?=
 =?utf-8?Q?rZho/xBFpuQNu7UMeqDrHKQxgmL/eGGs3PA7ajQpL4OTe?=
X-MS-Exchange-AntiSpam-MessageData-1: tl5mA3fKL0p98Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d9b96-13c6-49d0-7bef-08deb5029ab8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:26:32.6745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjK2XlPyQgHHlX1ZJLXxYpSYcO1PiJ8C53el16Xn5YaTGZiBomEkeO43d4HsjUKTlEHGMpFTyP2q5vSMWcvPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5581
Received-SPF: pass client-ip=52.101.69.110; envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 5/15/26 14:58, Kevin Wolf wrote:
> Am 24.04.2026 um 12:39 hat Denis V. Lunev geschrieben:
>> cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
>> by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
>> to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
>> fire-and-forget: it reads w->to_wake and silently returns when it is
>> NULL. A sleeper that is between two iterations -- has just released
>> s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
>> the wake:
>>
>>   iothread0 timer coroutine           main thread (qcow2 close)
>>   -------------------------           -------------------------
>>   while-body (holding s->lock):
>>     read interval = 600
>>     wait_ns = 600 * NS
>>     release s->lock
>>                                       take s->lock
>>                                       interval = 0
>>                                       qemu_co_sleep_wake(w):
>>                                         w->to_wake == NULL -> skip
>>                                         return
>>                                       qemu_co_queue_wait(exit, s->lock):
>>                                         release s->lock
>>                                         yield
>>   qemu_co_sleep_ns_wakeable:
>>     aio_timer_init(+600 s)
>>     qemu_co_sleep:
>>       cas scheduled NULL -> "qsns"
>>       w->to_wake = co
>>       yield  [sleeps 600 s]
>>
>> cache_clean_timer_del_and_wait() is now stuck waiting for
>> cache_clean_timer_exit; the timer will not signal it until its
>> original 600 s expiry fires. qcow2_close() is on the main thread
>> holding BQL, so RCU, VCPUs and every iothread path that needs BQL
>> stall behind it.
>>
>> qemu_co_sleep_wake() has always been a hint: it has no way to
>> rendezvous with a sleeper still arming. Rather than mutate it (which
>> would change semantics for every other user -- mirror, stream,
>> backup), fix the caller.
> Would changing it be a problem for any caller?
>
> I don't see the calls in mirror and stream, but for the backup job it
> seems to be two cases: Cancelling the block job and updating the speed.
> Cancelling is essentially the exact same case as closing qcow2, so
> changing it fixes an unwanted delay. If updating the speed should always
> wake up the job is more debatable, but once we've taken the decision
> that it should do so, doing that always (even under the race condition)
> doesn't seem like a problem either.
>
> I'm asking because the workaround in this patch both makes the qcow2
> code more complicated and still doesn't fully solve the problem - you
> still get a delay, it's just shortened to what we think is acceptable.
> If we fixed the qemu_co_sleep_wake() interface, the wakeup would be
> instantaneous and the code in the callers would be simpler. (And I don't
> think it would be much worse in the implementation either.)
>
>> Split the sleep in cache_clean_timer() into steps of at most one
>> second and move the s->cache_clean_interval check to the top of the
>> loop so it is re-evaluated under s->lock between steps. The
>> loop/wait structure itself is unchanged. The stop decision is now
>> made under the same lock that the teardown caller holds to set
>> cache_clean_interval = 0, so it cannot be missed.
>> qemu_co_sleep_wake() is still called opportunistically to cut short
>> the current step; if it misses, the next 1 s tick catches the change.
>> Worst-case cancellation latency is bounded at 1 s, independent of
>> cache_clean_interval.
>>
>> Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Hanna Czenczek <hreitz@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
> Kevin
>
ok. Let me try to write this.

Den

