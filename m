Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DD9C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x17LB-0003MJ-AR; Mon, 31 Aug 2026 15:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x17L8-0003Ld-Sw; Mon, 31 Aug 2026 15:06:43 -0400
Received: from mail-westeuropeazon11021111.outbound.protection.outlook.com
 ([52.101.70.111] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x17L6-0001mV-DW; Mon, 31 Aug 2026 15:06:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEyCf5UxqNNG40SK6KAqE3pW9sfhYJzVjHYCxC9NQ1qK3iIL4mJt+f22Z+hCDv4kAoa37kYhZPjImkpGUwOroZhWAMG/4I1l4Gf+USdlx+PNoBI7pMC9dXVyHWFS0LHXA0nWCFiuHlWb7WtUf93P5t6iIZcPJaeYYwEOttViZwRFMYvsVIeak6R9mIw+ZiUGBIXjJkYMAgvftuVxJfXEGV9xqR6wUkAssVXOP6Q3jBUo71d4Giz7N8/KVHkp93QTGp5aqtDHW5k3QjY3clx0wwfP8RKkMaV+dedwX2DDQ9IfpHUkuyBJMrPROuBt+WYm4zw1HPijhbhKamYdDr1NnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdR6aw4oXEfnACTeWyf/AFmAMPlPR/LBS0h1wPozXFQ=;
 b=sZf392HFpEUBkQjUZr93gJuS6nEKZS9V62cIDesektxpoAblwANx/M1Q4SA0KaA0I6NE/yZkNdnT+oFNgQb1cuFHzbEunZFFV6T2PSqAU2wIreYy9ipKhO9EOAz246UqBrJ0vXHC23vQ26uCralkiYLZ2pd9EoVPeWnn8DhVzhm3SRJ5+qtgmwYQPPPl+hYsjHnTtCD3OyJAbyX70yD+1MoyteEqyVlMmXw8/OzcSeYO0rAOH6PlZFOwGqToaOzksPZdVJibSUAXkixLQ5qJtlL6DHqHKpreeMMCsZ8GXOZPBUO2abOOQ4uEJZvR1jtc1FZCISI3hp1640bi0ENGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdR6aw4oXEfnACTeWyf/AFmAMPlPR/LBS0h1wPozXFQ=;
 b=ixzagZtZXTamirwBV9FJJTyleA/Ed7VDZtWzdLBZqFzp7G35IoAz/dhw+WK2i01miKAMt/PXKDBzb8eacNe2J2g5OTbjh6ZNPJU95jhav1ly6/IgYT87Ojy+1gJmAW7mE0FBHRrS3VrxwWUUzKYKSQeyPFDKFXxMV51Uh9/lwKn4OXgZdsgIQQJ7bgqh5XQazNHKXH9l9k6DI7XKnr++BnpBKHtK737GjZOLdCcONiBik9p+1XU5iYCXlycSK8rXN2L2R/jRdtP0/J8/N6loJABXnpexdVWeuOW1tldZp9dJV+7v6og8bQrkaOZW402Fp6NvLfYSn7ophdcnNaBKOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by BR0PR08MB111552.eurprd08.prod.outlook.com (2603:10a6:2c8:60::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 19:01:34 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 19:01:34 +0000
Message-ID: <8691b460-faa3-4562-9820-c63823041878@virtuozzo.com>
Date: Mon, 31 Aug 2026 21:01:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org> <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
 <8733w0j45n.fsf@pond.sub.org>
 <0880ebd0-d548-496a-9832-eb4e58c46594@virtuozzo.com>
 <87fqzzgc13.fsf@pond.sub.org>
 <aacf393c-2688-47b4-a507-18119dc6d199@virtuozzo.com>
 <87ik4qfp3r.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87ik4qfp3r.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0262.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::35) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|BR0PR08MB111552:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b3071d-3d11-481e-b1f3-08df0792466f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10070799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bNaf0xBn42Fn7TlzE51aWoj2AiG0yAU0x7jNeXdrhjiKR1yM3j6LnpI/EcAhKlNOfVG67xDZVkUZrfPJCSgNWqtcV22Cf0fYiJQr38L3kAv336a0RTLYhPgKuWCwYSPn3ql/mXs/XVvQiontut2XzTlJWMc4KEVAaOu9F57OItxI7270i1q5GmFdlxkszyWDsK+FZsGbK6kj1h+COF+xqedY6txWP7EsJrPC4vPtl37GdXt9mD5Bd4S9HlNUrFQAkYxV8o6sd2YxjRqTQdtOQKbVTY+zQS7aIkWvSC/ava+OdQVgFfW4EL9MYhvGOQFsZOBslVbAVpG/57wehmhxYEJRsbW3pd+1n6g0Rd4dG5aA9UXDv6NOzCE0/3WztI25jv1QtHiztmi2r1pp6gttc42o4y8VYYKSwBJ/oxCs5KDBlJjjBAx5D0ctiBYh9fDMv9Kywj0mFOLSKAm4db1pdzMswg2LZ/xZW59gbdgWZ3E3xYiE8HeMBUr5UOI6lvdHEAZBCA9E+xG0x7YsHdRl0YSKa9CvOLDVi4Q0dJ3g+ADELT/m71QTT6lftwIEpLU5inae1XNSY8ba1PztN4dy82fwTpdNmMEdj3T1arvc5y4Qki1sbSmDj0SG6XijgabFZEuRf6LWf9SnGwP9rgUHUnbrQ97QodBIHKfq8yK+2Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3E1Mk02VkpORWt1Q2lac0Y2TUJEMjRnWEtRU01yMWo5SG1EZWFEam5ESVJY?=
 =?utf-8?B?Nk1NY3FmSlBYUXhuNEJTZzIrT3dKd29kTDhGUkg5Uyt0bmF3LzVxVnZtdCt4?=
 =?utf-8?B?dkJUeHBQZnMwNmRtb0dDck1QczNEUUJrcnJrQ1V5cEZ6QWxYaUF3RmlwUG9H?=
 =?utf-8?B?MGtWVnFWVlR6RnZjems5WEc1c2pNZlQydHhCdklJaW9tRXF5YmZVUUtlTmIv?=
 =?utf-8?B?NlMxNURvemI2Kzl5aTUxd2tCYWxzK1lHN2lCc1lBd2NMUnlhL3dvSERZckpx?=
 =?utf-8?B?NGJuOUhPOHFMOHhKWWJOTyttYnc5d1MxNXhsZDk3RjFvR28ybEs5azVON25X?=
 =?utf-8?B?U0RlKzZscmdmYmRzY1VwMEJUcWJqWVh6VlphejJ3b1ZpQkdtKzE1c3ZqU3Bs?=
 =?utf-8?B?UmczU1lLSDFuakVwWGI4RE9VR3RLUE9FZmZEMjZYampEMEFZcWVmV0YxRkZK?=
 =?utf-8?B?b1NxQitzTlpBUlptL0NXL00xUUUzQ0NtbjRmRjBUcjJSamRjaldRYXQzMmhj?=
 =?utf-8?B?VlJGT2FBWTQrdlNVUkhsRzJPZDVQa2JXSzZ2TDIwa0Y5WDU4WDFJTHVsT0JD?=
 =?utf-8?B?K2NKRWdKUzZkZkIzaEpWUGpIUkE0ZGFKK3JpSytzdVpPelN6RU56V1ZPMEk5?=
 =?utf-8?B?L0dnK21lbE5STVNhTFdMSTRxNkh6aWJkSnJPSjN0TktmQy9qMmg0WDNuUlpF?=
 =?utf-8?B?eFRJbnM4Y09SSER4K09mTXFacXNjNFVZRGpHV0E4MXQrMVFlQ2NvQlNiQ3dD?=
 =?utf-8?B?QnlRVnh6YXYyejJYY2x6Q0hqT2RMN0JMKzVmRjBQRWRjb3ZFbG1qaC9XaGU1?=
 =?utf-8?B?RnlGelliK0FIRHE4S1JQTmVJVk0weUZFQS9iUzRtVkVWWHRJVXRtMVpwY1Np?=
 =?utf-8?B?enNQVjVnRng1K3VtbFlBbCtHVEJBOXlEY3FOUXNMMi90MldXd3lQYXRkMVVu?=
 =?utf-8?B?RTYxK1JUR0N4aEhDcC9hazlNaXd2czVveUdMcFF4d20vOW9BTlFzZDNzTWN2?=
 =?utf-8?B?YnQ2WEpidGo4SDU2b3J3WFJwcXM2UFl4WGIra0VvSWtsY2EzUythOThYaDJo?=
 =?utf-8?B?QUk3SGVOL1V4WitsNUg4SENmRnZYY2ZlcFVzaXZWWExBMXJsQXhwdCtHUWpa?=
 =?utf-8?B?UzdMRWliQ0pUcmg1WVRZb3N5UUlRdW85QlQ5MlpNZlozcVZydnU5RDNWakVl?=
 =?utf-8?B?U0ZsL1AvUkhMS3dPRktDSUtWbHRRRkNEaVF6Qi8vSXVNb21CZmNwdUFxelc1?=
 =?utf-8?B?TmMxcVhYcCs3MHFsVSt0MmoyeEtRZG1qd2tkcGRCait6eHZuMXRvMzZTQkRE?=
 =?utf-8?B?LzhVQXJzdHpYejErY3I3QVFiWktScFBGZ2pad09PU3RCZzJ5R0k4VEJoU0w0?=
 =?utf-8?B?VUxScVdEMmdFRjFDQWovUUxBS2liUHNaV1J0MzM5NHU3UW5udU9ERDVvM04r?=
 =?utf-8?B?Q1NMZXdDWGwvU3NRRVhyZlZrM2FaV3Q3c1NCTnhKR2xrb0NvRDkycGVrbjJK?=
 =?utf-8?B?RFFqMGFzOU83eXNjNGV1eHExWDdBbGIrUVVKUUdxS0huZjI2dzJkYmtpNWdY?=
 =?utf-8?B?WUVhYkRKV01WL3lJVWtGL0JnOFI5QlpWK3NyQU10REkyY09va3h3Y1NuREdX?=
 =?utf-8?B?Vy9pRnRhbytwSGpVZ01MeTJzU2dnb3VFb2xneXNWRVZGYjhTWEFFb1hDcWRk?=
 =?utf-8?B?VDNWM2t6UFRMaEc3Q2RGOVREUjk1RXROQzBJU0VzZXZHaC9mQ3BYbFk1dlFN?=
 =?utf-8?B?S1hoUVFmcUVkUEo5dFFrTkRpTzJTN015QWFQeFpIb2M1eWxtYWw3azNQYjRm?=
 =?utf-8?B?TnRHbmt5SXlJYnBvU0VxQmplaXlUQmViRGVrUFRmbG9nV3lNNlVPUjZyb3Jt?=
 =?utf-8?B?aWp0MmhsWUNod3ZPT1dFbGZDR2dzcHBYQWhYbE5NRjY4Z2c3NHB2Q2pCc0wz?=
 =?utf-8?B?SXZHNVhkVkRZZ2pWL1FicVRJSlJXT0NpczE3QXY5Tkdic0hOVjVBeGx1Vzhw?=
 =?utf-8?B?Uy9hZEdNd1pXdmExV1lLN0RjNnhJNWhyczN2b2l1VnlVZC9BWXZvU2h3cTRQ?=
 =?utf-8?B?cm9jcFJneGxPdHh3RWFnNDFTY3l6blhIdkZmbHJYSlJCdERDSERibCtjNE5r?=
 =?utf-8?B?dnJXL1hpTFVMMHpuK1JZWVdrZHZSV2NhVTJ1WEI1b0ppZUNiZmx6d1hBTENt?=
 =?utf-8?B?VEdQRzJUd1dMditvbHNhb3JSaVdReVJXYkYvN3IxaEJjQS9hTUJRbnUrV2xQ?=
 =?utf-8?B?Zm9QRlBmOXB1SjJBZG9OelNYTjEya1ZNYnVvNytjYXpvTjVGUVdEZlovOGVt?=
 =?utf-8?B?MXhxQWdOck9IL3JYaDMrYnZXa0srYnlqcmJ4b095S0Z0aEk1Nytjalpod0Z0?=
 =?utf-8?Q?feppROkTvlOMQb97WEjBVDeXtM58Z3l2epffSB5kyrl7k?=
X-MS-Exchange-AntiSpam-MessageData-1: ZWY8PD9BaKhqTg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b3071d-3d11-481e-b1f3-08df0792466f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:01:34.0209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG0t8aKkswPMU3QzSxV+L/N9IXoSS+cvl7q5EYLtBaQrZwNr6gaU2V0wliul7HfdYQU9I4O8s33gucznGXdeUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB111552
Received-SPF: pass client-ip=52.101.70.111; envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 8/31/26 14:31, Markus Armbruster wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
>
>> On 8/27/26 11:15, Markus Armbruster wrote:
> [...]
>
>>> We must not (re)open a dirty image read/write without cleaning it,
>>> because writing to risks corruption, i.e. data loss.
>>>
>>> When we open a dirty image read/write, we can clean it without
>>> inconveniencing the guest, because the guest cannot access it until
>>> after open completes and we connect the newly open image.  Correct?
>> correct.
>>
>>> When we reopen a read/only dirty image read/write, cleaning it *can*
>>> affect the guest, as discussed above.
>>>
>>> As far as I can tell, all the trouble discussed above ultimately comes
>>> from letting the guest work with read-only dirty images.  Why is that
>>> useful?
>>>
>>> What are the use cases for opening dirty images read-only?
>> Read only images usually comes in image chains (snapshots, backing
>> stores). How RO image becomes dirty is very good question. May
>> be this was due to QEMU stop/node crash during running commit.
>>
>> Why this is needed? VM should continue to start with dirty
>> RO image. Doing maintenance at start? That is also problematic.
>> At this moment we can face shared lock on base image (so called
>> golden image scenario).
> We can "do maintenance" during initial open proactively, or during
> reopen read/write as needed.
>
> In both cases, we risk delays that can make the guest hang.
>
> Cleaning as needed might avoid some delays.  It can also shift delays
> from QEMU startup (sometimes bad) to guest operation (commonly worse).
>
> Cleaning as needed in its current state appears to violate
> blockdev-reopen's contract: it breaks the transaction.  This feels like
> a regression.
>
> I think cleaning as needed poses challenges to management applications.
> I figure sophisticated ones can make a reasonable choice between "clean
> offline before you pass to QEMU" and "don't, and manage the delay on
> reopen".  For less sophisticated ones, and also human users, all this
> feels like a trap.
>
> Have we considered dirty image open to require an "I'm sophisticated"
> flag?
>
> Anyway, this is how far I can take this.  Now the block layer
> maintainers need to chime in.
>
> [...]
The problem is that we are opening RO and could not change the
image. That is the worst part and not just by the fact that
we opening RO (we can try to reopen RW) but by the fact that
another QEMU has already opened that image and we could not
take the lock. Reopen here may not happen ever.

Both ways are weird, the question is what is worse? :-)

Den

