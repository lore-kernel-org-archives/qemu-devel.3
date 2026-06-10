Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6233CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGqF-0007kY-UM; Wed, 10 Jun 2026 07:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wXGqA-0007kI-3z; Wed, 10 Jun 2026 07:11:23 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wXGq6-0001bD-Kn; Wed, 10 Jun 2026 07:11:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9c6l1vcIJUxguhF4rg3wpeWJ9GnUuMLpVZWjHt3tnfDyi7GNjt4FMxweT4Vs3oVKAJwvHM6wdfoYcMee3oyyc/J4JUYjh2AOH+U2TKJnmeSLxGnlpN1VcwwM4QJ/ta9h+yWlfWFz0dSE4qCmhNFUWYisJDPFs+sJQ/nCL1BmM1xMFobTKFiVjBIYiFcQ41g784+vR5OFjf8f8bOK8rEPjqc/37VwbxkyQQf93diaiyY8ZZi+EO4IUUc9N1bKEZNiF6LiM3tVbUTSogR67gIkOiIY6aHXnbDSow+PpbrFlR4OhbUpVCQJ6zwyC/lanytcDQwnqB7ozFe/ACmk54U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMlX0mNAJzYL8xBGufCYFgE5fJ2CqtyExZ3mu3IIFrI=;
 b=A9+ScSg4VPvlv4+YO4lSm6Fmx8SeR+AKFoUX1od0jjD2Pq6nqaqHnxr1ne0rm/F5kWXMx3M9G/u86v+ui50m6nq/m8l+yv3CCRjIdbkcN6wzWgEMsw6PuzZQ/T2xeF3m9VtkHM5WiZjvEoCkvYA0Z0ZANw0pa0DivD7TWZ00H5p5k+CKor2Eg/JwF/6KB22RcRpKtcilDmI0B7lwoq4JT94410SifBSDofsBo2QN5V5h6mSDpW9pZ0Sp7NIlOePOvXcltMC2C1nw++rzGOZ4H9x5ENOaDW47ZodL4r1iiT+R6RUbqKk1RXPGkN2SqlBN8Jxp0wL68ag6DEQf2PPUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMlX0mNAJzYL8xBGufCYFgE5fJ2CqtyExZ3mu3IIFrI=;
 b=oya+RSLYCxjb35CiOkEi4I6phxsxZL2SLl0XCJ4GUWk23Qt6wIPwnXwZHXpONQ/V3SPYm0fTSWDHok4WFcqN3pqqAErJemq9m5ZP+aYMsZkBFJyH8xXii7tS3wQMo76YTg74aNyeYuL5yp7w+LvNJ7gcHOXLhGsN0C13mlZAbSmVpkELpLF0GwyEJn4r9iQjfTU5rInGsyTIqJNMrBGF9GFbrIZQSlxPhyw1oNwGUuP2VcM7Xehsb5DtQOp3MAFLe7D8BmR/lSQhd01AnPOwkCMQN8DWhcHhqBzozZqJDPOIJ+lVMotaypck3zrqQBFvSkq3J5/b+McVl8xmrndzhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVXPR08MB11321.eurprd08.prod.outlook.com (2603:10a6:150:2c4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 11:11:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 11:11:12 +0000
Message-ID: <00589532-69eb-4dc0-b19d-cedda63b34dc@virtuozzo.com>
Date: Wed, 10 Jun 2026 13:11:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, stefanha@redhat.com
References: <20260520193849.467936-1-den@openvz.org>
 <20260520193849.467936-2-den@openvz.org> <ahmlab5emsQcYcr9@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ahmlab5emsQcYcr9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVXPR08MB11321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8def341f-90fa-4983-cd0f-08dec6e0fb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|10070799003|1800799024|6133799003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: KAH1U6hMjyX6HPwtJLs4eA2ALaCVEFga26w8rqX0PCkQnsNgG2qYTQ5p7z3PWtziMCWal8F/VZ4B/i9JumEoLdslfa2vC3Wp/huor7ulTDBKwnse2LuoO5scApEfOl/bfTUVMbvaA9e2gxVl+pDJtvtc9Oe8MA0vpiXOZY3cenVPfMTPa5IiX/rdxL5e0tX6ineXeAgjtLXYfcvIK/8m34WcezwCQmuArFtZjzHc0Fw2b6mXzS79MIFXSXOSz0KrnKUn8IEfCNk5abV6FCzJZDYiNRm2r7CzwC8fhYHL5+AT+Fcz8/wkXkblKq1i5C3h00vaXEZvn2Ol7tBiCgPp96TI06lmm5HXjNJ8986855ovENPz6j2X7kMs04J+FWSshzcLEeT2WSTY8wSexl/U8gYY2L0Dh4OfO2ptrK4ZZ7jkvkVT9b5Mb/A8axrbVcX+61BIbyH4EXTZaCZ2arJtLP0EfeLf1J/Cupt92Xyw7JWViNY4+wf2tGQuuYzcXqnI3bYTK4UxljdkQpmPPx3uturtMZHhhrMZCqrZ4DTfcFvMxnbB56/LZiCVEtbmapeL/mLzDpPk+Qcl/HEQd9UIDI+jFcOIGTx/Z5ThPWVTeco3px9PXI+vGpnkuf83fE1YQ76kp44/k9GmPIoCL6VrvOSD5dPL+sCzbXcJhVkI/gmBw9YU2aLevugztEG9z/C5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlA4OWo2OCt3dnFtaFVDTFpkUmZrb2FML0d5d2NhazE2UEZudUVOb1ZFM0Ur?=
 =?utf-8?B?R0Z3amVyZW9BbzhuWjlYYk1wVlZtdHVvOG03aXM0eHVBSUNHWW5Ec1NnQlBO?=
 =?utf-8?B?SzhzbjZLa3ZYaW9kdklHVlpXTElyc2YrRFVaMW4wbGVRR0xwNEhoUUduclZJ?=
 =?utf-8?B?NzdOM2d2RzU0TS9IMG5menZrTGxCUExqV0gxTEM0ajVSditFa1NPc1p5RlJC?=
 =?utf-8?B?b0ZDa2VLN053TzZwbjFWMEl4ek1oL0xzOUZPQzhoTTFMUU1tMXhWT3k1TjNW?=
 =?utf-8?B?YW5LdElXWFVqOVlHdHc2UEJxdzlsQmRWOEpJWHozYlRFN1Q5ekRwNk1uRnFm?=
 =?utf-8?B?Ujl4bURCQUFOSWZqRSs3VjJqRnhDRXhkSi9zYVhzMVUrK3o3WExaRGFDTlp5?=
 =?utf-8?B?YVRpQ0xFOSt4dzFSR1dkeTRXU3JtOSsxY0hmSkRFVUYvTzdMUVdOZ2Jsb2NR?=
 =?utf-8?B?eEtHd05uSDFFRlYyUUt2MEZuTWtwS29vSTY2UCs5K3NLU3M1ZnlwTS9uMEZ5?=
 =?utf-8?B?b0h5NVVBc1B5eXJpMjBzRGNvek1kNm1YYTRXVzZHOGVrUWI2ckVZME55Mms2?=
 =?utf-8?B?cVRWWmk5YnJQd2JOVDdEcjRKcWxobVV1QWVUdmp5dTlsWmoreno0WE1lalJv?=
 =?utf-8?B?MFArY2VQTHdaYThiSUNLNncxMklSRmtxWjdVZTE5OWNoMkdkVVJKbERoWitq?=
 =?utf-8?B?aW55cW9aZjFidVlCMnVBUlN3eXRLUlQ2Yi9wcTQ3bk9DUzJYOEU2MmNscVFG?=
 =?utf-8?B?cERidUlFRDFleTRqTFpTTFRVUld4S0E4RjJuYVpuaHlPMGZwMUQwOHEzTFg2?=
 =?utf-8?B?d3RVczdDUFJNcW5XZDRLcHBvall4d2I1NFN6TU1VUnBXTkFLRWc1ZmNnNzRw?=
 =?utf-8?B?MUYyNWFmOS96blgxazhBNklUbUx5MVIrdUo4ckVaVWQvVWowalFjU3lxWTQ3?=
 =?utf-8?B?eFNGNnBXNnBIekJNN1ZLaXBYdnBBU2E3Zk5VOTlhVmtOeWk2MUNPUkM3dGZ1?=
 =?utf-8?B?QUdOK1gvQWxrSVRDdllzNzV5TUduL2pTZFN3cTM4MnZBTWdDMHlBWGkxaFFG?=
 =?utf-8?B?R1U1YUo4dWwrSURtM0lUaThLYlQ5Wnk0SVNTbHc2dHVLdEc3NEw2NFpJVllr?=
 =?utf-8?B?OExCbGdXdllub3k2djNoYWU0d2VvMlNOZE96WU13MHRSczVpZnJtTU5EbDRu?=
 =?utf-8?B?UktrTUF5bFpzVjlTNEprVVROc0Q0OUdLdnM0WHMrL0REOXc0MTU5bmN1bUtM?=
 =?utf-8?B?YlNMbEU5ZEwrckhJczkzcDFYY29hZUEyY0dwM3JHY3RuYUVnNGZMOTNhVmVr?=
 =?utf-8?B?Vlgvb2hiZEtCUmZPYWVxUUxxU2ZFUkZzT3lCWnZEZTdyTWtlaEY5U3dQK2Ew?=
 =?utf-8?B?QVZENktXYVV1eEdGWmc0a0VPZkdER3d4NXBNZGJqWFhzanNicDJRYmJ4OEFH?=
 =?utf-8?B?YlA3Wm52WHJTYVpBRjlFRWo0a1oyUXRxS0Rrd2drTEwrK0JpV2s2TWZKdGh1?=
 =?utf-8?B?dldCRjI1cGdiTnhKZHdQbGQvcUNqaFBtUnNBT0FYNVhjTWlNQUloc2puLzRw?=
 =?utf-8?B?dUsydm80Zk9oVmdOb2Z2RUZUbDVXRlNLNFJuSnNzb25jSWtaVHRoMStYazNN?=
 =?utf-8?B?QVI4SE5xRFFDb2ZJQ2MzdnZhL20xWm9KeWp3dFJab1Z5eXRnT05ROUcxZ08y?=
 =?utf-8?B?cjU0YWxIelBtbHpQRGRtN2x2NVd2SXVmTE9vZEdCTW1WUWgrcGhNMi9IbDAx?=
 =?utf-8?B?T1h2MUZBOTJjY0M4cFZXNStxT1QyR2VHWDdCeWZscFBNMHg0UXNqeFpsWDE0?=
 =?utf-8?B?TXZKMW8raDNiUkpRQTA0WjZyN3NHbFJvR2lGa2lubXZWaEtBRnNuei9seXFS?=
 =?utf-8?B?ZEMrTkNQdDQwSWhuVkhwS1N4QnFKQU45Qy9LM3JnSWpXU1FuMk55YmNhSlZF?=
 =?utf-8?B?Zk1DOG9CYU5yZGRSdThQckdWaXQ2QjFEa3NoeUdVLzRJeEd6UDFuY01KSkZO?=
 =?utf-8?B?R2w0b21Eb2tpOGVhMDlWNDNFOVhJYkFlWUo0YkF5ekNLWHY0Y3dlanZNYWUz?=
 =?utf-8?B?VXp5QlQ2aDU2U01CNnVRd1BtR1pONUZqdzhFRVNJSHVFd3V1UndZRWNndE5F?=
 =?utf-8?B?YXNDSkVXL3JSTE5OTDMxWnhDK0QrRTdDNjN1UDliMXpoaDhSWHc3c2FRTnV1?=
 =?utf-8?B?TzZuT0kvcDkyTEtZbUtHaDhSTnRxM3JKVTFpVDU2Q0IwakJpajRCVDhrQXl1?=
 =?utf-8?B?WVNqV0hiUHExMmFNRWUzRDZ1MXRrek84R1MvaXUvOXFPN1E5blkvNTE0eWU4?=
 =?utf-8?B?SEJuazdkMjJKdVlFekxJNDFRVXNsNE9Ra1NldUJzSTc2MFU4MDl5ZHhTODUx?=
 =?utf-8?Q?fjmtOxDNT6ATwZ3K6XDRpwyzNUK2p4dLkBeg8oyBwKyp2?=
X-MS-Exchange-AntiSpam-MessageData-1: FUz4+vQnCCpoAQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8def341f-90fa-4983-cd0f-08dec6e0fb48
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:11:12.5818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+QSsZl0g6zK7RrwDFp2wGJ6JupZDPQtBVsKJpgxyzfAVYbJTMn7BNhv9bDhi8sXpnvRRWcXGGRWkSQ7hWTPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11321
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
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

On 5/29/26 16:40, Kevin Wolf wrote:
> Am 20.05.2026 um 21:38 hat Denis V. Lunev geschrieben:
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
>> cache_clean_timer_del_and_wait() then blocks on cache_clean_timer_exit
>> until the original 600 s expiry fires, and qcow2_close() holds BQL the
>> whole time so the VM stalls behind it.
>>
>> block_copy_kick() has the same shape. Fix the primitive once instead
>> of working around it in each caller.
>>
>> Use a tri-state for QemuCoSleep::to_wake:
>>
>>   NULL     - idle
>>   co       - sleeper parked
>>   PENDING  - wake delivered, no sleeper yet (sticky)
>>
>> qemu_co_sleep_wake() xchgs PENDING into to_wake: a real sleeper is
>> woken, NULL/PENDING is left untouched so the wake stays sticky.
>> qemu_co_sleep() consumes a sticky PENDING on entry; otherwise it
>> cmpxchg-publishes itself, and a wake racing in between is caught
>> because the cmpxchg observes PENDING and returns without yielding.
>> On normal resume qemu_co_sleep() clears the PENDING the waker left
>> behind so the next sleep starts clean.
>>
>> A double-fire (real wake plus timer callback) is harmless: the first
>> xchg returns the coroutine and wakes it; the second returns PENDING
>> and is a no-op. Cancellation latency through qemu_co_sleep_wake() is
>> now bounded by aio_co_wake() rather than by the sleep duration.
>>
>> Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Hanna Czenczek <hreitz@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  include/qemu/coroutine.h    | 17 ++++++++---
>>  util/qemu-coroutine-sleep.c | 60 +++++++++++++++++++++++++++----------
>>  2 files changed, 58 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
>> index e545bbf620..1c31de60f9 100644
>> --- a/include/qemu/coroutine.h
>> +++ b/include/qemu/coroutine.h
>> @@ -260,10 +260,19 @@ int coroutine_fn qemu_co_timeout(CoroutineEntry *entry, void *opaque,
>>                                   uint64_t timeout_ns, CleanupFunc clean);
>>  
>>  /**
>> - * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
>> - * deleted. @sleep_state must be the variable whose address was given to
>> - * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
>> - * qemu_co_sleep_wake().
>> + * Wake a coroutine sleeping in qemu_co_sleep() or qemu_co_sleep_ns_wakeable().
>> + * The timer set up by the latter is deleted on wakeup.
>> + *
>> + * The wake is sticky: if no sleeper is parked on @w at the time of the call,
>> + * the wake is recorded on @w and consumed by the next qemu_co_sleep() on the
>> + * same @w, which then returns without yielding. This closes the lost-wakeup
>> + * window between two sleeps and is the documented behavior callers should
>> + * rely on -- e.g. a cancellation signal raised between iterations of a
>> + * sleep/work loop will shorten the next sleep instead of being dropped.
>> + *
>> + * The state persists until consumed: if no further qemu_co_sleep() is ever
>> + * called on @w, the pending wake is harmlessly discarded when @w goes away.
>> + * Multiple wakes coalesce -- the next sleep consumes at most one.
>>   */
>>  void qemu_co_sleep_wake(QemuCoSleep *w);
>>  
>> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
>> index edef117284..a5734a8eb7 100644
>> --- a/util/qemu-coroutine-sleep.c
>> +++ b/util/qemu-coroutine-sleep.c
>> @@ -18,20 +18,29 @@
>>  
>>  static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
>>  
>> +/*
>> + * Sentinel stored in QemuCoSleep::to_wake by qemu_co_sleep_wake() when no
>> + * sleeper has parked yet. The next qemu_co_sleep() consumes it and returns
>> + * without yielding, so a wake that races the arming of a sleep is never
>> + * lost.
>> + */
>> +#define QEMU_CO_SLEEP_PENDING ((Coroutine *)(uintptr_t)1)
>> +
>>  void qemu_co_sleep_wake(QemuCoSleep *w)
>>  {
>>      Coroutine *co;
>>  
>> -    co = w->to_wake;
>> -    w->to_wake = NULL;
>> -    if (co) {
>> -        /* Write of schedule protected by barrier write in aio_co_schedule */
>> -        const char *scheduled = qatomic_cmpxchg(&co->scheduled,
>> -                                                qemu_co_sleep_ns__scheduled, NULL);
>> -
>> -        assert(scheduled == qemu_co_sleep_ns__scheduled);
>> -        aio_co_wake(co);
>> +    co = qatomic_xchg(&w->to_wake, QEMU_CO_SLEEP_PENDING);
>> +    if (co == NULL || co == QEMU_CO_SLEEP_PENDING) {
>> +        /* No sleeper, or a wake is already pending. */
>> +        return;
>>      }
>> +
>> +    /* Write of scheduled protected by barrier write in aio_co_schedule */
>> +    const char *scheduled = qatomic_cmpxchg(&co->scheduled,
>> +                                            qemu_co_sleep_ns__scheduled, NULL);
>> +    assert(scheduled == qemu_co_sleep_ns__scheduled);
>> +    aio_co_wake(co);
>>  }
>>  
>>  static void co_sleep_cb(void *opaque)
>> @@ -43,6 +52,14 @@ static void co_sleep_cb(void *opaque)
>>  void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>>  {
>>      Coroutine *co = qemu_coroutine_self();
>> +    Coroutine *prev;
>> +
>> +    /* Consume an already-delivered wake without yielding. */
>> +    prev = qatomic_cmpxchg(&w->to_wake, QEMU_CO_SLEEP_PENDING, NULL);
>> +    if (prev == QEMU_CO_SLEEP_PENDING) {
>> +        return;
>> +    }
>> +    assert(prev == NULL);
> I'm wondering if this check serves a purpose when...
>
>>      const char *scheduled = qatomic_cmpxchg(&co->scheduled, NULL,
>>                                              qemu_co_sleep_ns__scheduled);
>> @@ -53,11 +70,23 @@ void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>>          abort();
>>      }
>>  
>> -    w->to_wake = co;
>> +    /*
>> +     * Publish ourselves as the sleeper. If a wake raced in between the
>> +     * fast path above and now, the cmpxchg observes QEMU_CO_SLEEP_PENDING
>> +     * and we consume it without yielding.
>> +     */
>> +    prev = qatomic_cmpxchg(&w->to_wake, NULL, co);
>> +    if (prev == QEMU_CO_SLEEP_PENDING) {
> ...we essentially have to repeat it here anyway. Couldn't we always just
> use this second check?
good point. Will do.


>> +        qatomic_set(&w->to_wake, NULL);
>> +        qatomic_set(&co->scheduled, NULL);
>> +        return;
>> +    }
>> +    assert(prev == NULL);
>> +
>>      qemu_coroutine_yield();
>>  
>> -    /* w->to_wake is cleared before resuming this coroutine.  */
>> -    assert(w->to_wake == NULL);
>> +    /* The waker left QEMU_CO_SLEEP_PENDING; clear it for the next sleep. */
>> +    qatomic_set(&w->to_wake, NULL);
>>  }
>>  
>>  void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
>> @@ -70,9 +99,10 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
>>      timer_mod(&ts, qemu_clock_get_ns(type) + ns);
>>  
>>      /*
>> -     * The timer will fire in the current AiOContext, so the callback
>> -     * must happen after qemu_co_sleep yields and there is no race
>> -     * between timer_mod and qemu_co_sleep.
>> +     * A wake racing with the arming of the sleep -- including the timer
>> +     * we just armed firing in another AioContext before qemu_co_sleep()
>> +     * publishes itself -- is captured by the sticky PENDING state in
>> +     * qemu_co_sleep_wake() and consumed here without yielding.
>>       */
>>      qemu_co_sleep(w);
>>      timer_del(&ts);
> Overall this looks good to me. Some unit tests would be nice, though.
>
Invented, will be sent in v3.

Den

