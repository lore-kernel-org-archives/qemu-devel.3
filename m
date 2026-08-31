Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90417C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1A6s-0004j7-Ce; Mon, 31 Aug 2026 18:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1A6q-0004in-RB; Mon, 31 Aug 2026 18:04:08 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1A6n-0005wA-PH; Mon, 31 Aug 2026 18:04:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCDgNoNh1qw3KgIBkTi8VYEUp+R+PUxUK+87tzfPk9jwsNy1jlZEH1ataZ50aYl59MbjbLUxBWYTTA9edtAXJexpsAyvMtJpDGtsOZVkIUrNmhuIGQ9y2ZWt2OMYP1Dg6ob+B9C7MVznzJye+sYhNIaBFKsRR74YPZVrhG5Hn78YbTkjS5bRIKUxCZ2kGIeKkp7UGmVQ/Bsrs1R/c8GoU0Er6L7VBTz4AHGxxwlKJZ2XoI/ljza7ZMVAGykPWbY0pdGKR0JdlvE1oz1HtssExG4G9r3dHeJabGQgl5nxLiEyPq7vgHr2kW+jm8Wpp0/EAhnnQRao7Art2nO5ApmQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl1ouzCyx4/Mo+sA8kMGYbl84rfyyVLZSET4H0Xss0o=;
 b=Qfckcj/av1U0fSh8xvN6xknkvEZOcqpgGOulWyzEaQwwKR6SRSP4GnI01e2NYwBPfKzyRLiuvhwDuIhpSMQUgs9a0iupKAXqPJYkghLTY7fybJRSseWSoWliGU6b5PIwWjU2D67Lt8pGeRpjni9krFO4uUazhiJQB4U73jvYbRrl2OwCY0dU3VDCwOSQXMmy24zMlttk+z8iUtAYFNNttB8wMyp9t9xhuT9YThQz9EQOhsnUiyM8vWLyPKsM6XEDoqiPqmzRhAz652PwUCmVeeVf6hscxz/u63uO15Uk5GnC+R2WZ++XCRHavq0PRjc35vXvNsmswkYAZAwBtTI95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl1ouzCyx4/Mo+sA8kMGYbl84rfyyVLZSET4H0Xss0o=;
 b=wClyD3PWEMFcR8E8a+jXFW3MMSZdIvMljjdET60iAY1MbCiHUAxWUfaxQBoGGFC4M7HPr5dR54qU3U3HUxXMCZafuW2hwjqePpi/8PdDQ/Zz0xc9LtbdotSqLiZvnO94LI6xn6n4vlNAp5qGa7HD7zKuv77TVZrGMZ5c7zICcK+nFz75AdKskKb+XnGx3kS0C3ULplfbbQKwSVg0dJlsAyqovjEtomLz1n6H8imZTlaeuzjQ1mPqIwpj1Ur16iS+6HpC3Kod4LjfMvS4/GBq2UxnmK07jLLfYX5xzspSGPaKMXTeN5XIgw/PsZVg8ZOtc6DU52aNpsRvdb1hsIEFRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by VI0PR08MB10760.eurprd08.prod.outlook.com (2603:10a6:800:20d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 22:03:59 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 22:03:59 +0000
Message-ID: <7ad0843e-63d2-401a-8ce3-fbdfe317826d@virtuozzo.com>
Date: Tue, 1 Sep 2026 00:03:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
From: "Denis V. Lunev" <den@virtuozzo.com>
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
 <8691b460-faa3-4562-9820-c63823041878@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <8691b460-faa3-4562-9820-c63823041878@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::40) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|VI0PR08MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cf1602-37e8-4dfb-c6bf-08df07abc27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|23010399003|10067099003|4143699003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5qChJhJX2QfbppHE6QotFfELPxa0LmMGt6SfTwSb0XnHL+jiqQUOaOtU2qIAY6u7RGLUWLKg7aNO8olmRHaE1K5c5a8EzgC5rso/iyEnXwrLFBSfrJE+FSiPQq/Z6CYNS3wLyDNzG5pU8AFUpgt5+YOAeghwmpr4V4hxfKyQQ9tCBzP2WOO6h1HUmh+CROeY1aYB/TPNvlbUtIFgAhAW0Hc2j747GWQ3BFGEJYWsNBRhvDUmW7HqRygoAnAHB8q5F8KUgqZAuv7tbk/CPaFz/vW4ivO4pbstJ9DM2AxPN99ahy7Jb87wvHbhIxGusBwZDS7ga0/QhmONU4f+zSqRsqXT5eWIV9ZR8+2MIG5UY6AnSpwj9LA3v7JwAQXAC2JyK9U6L/rIF9OKLCXMa1nNP7mmM7Q7uUiv14mX0hW53Wlt6e4Um9SYX5Hm8NoJNXEakmXSgpfPMBNpC19ScvpGhFOMWto7POGMebywA6rYGoAXRQjXVV2INeQT7m9gOKMKuE7/Ya/2v0v2oMIOUEiaUvpqM8+X5vEJwFqq46WvV9FF/IFLVNX+0fLxn200lN3MvTjrKCyUabdh+5kql8F+pjVFm1AUEaxJkZuMjx8H57xaKSqxklT1wJ55dyCAX5rjDg2aV3LNK/GJEVRTaxNzz2rTU2y5xP/yelLsElS/MMk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(23010399003)(10067099003)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFxaExRRUt3WUtZaDZWMVd5RVBockh1Y3g0Uy9abDhwb0FldTBrNzc2RnFi?=
 =?utf-8?B?SHhvcnowN25MTHZsOW8yd2dhK1NrZmpVZGttOE15SmhFM1NwZWpuWkJLbXhz?=
 =?utf-8?B?YUFvbXJRQks0VDg0K3hIYUwyY01qUE9qbGNEMlJPT3Q1UlUvOHY5anZ2YStE?=
 =?utf-8?B?M05EZUJKSHR1ZDhyOWREUE1QSlhiOEV1enV1dFJuRjZRaklEQk9sRmNPdDFL?=
 =?utf-8?B?dngvcXZQOFoyY1hZVU5jbEdlYS9ISG5SVGpMWU93MFZmbUZQTWRHQUFmVUc1?=
 =?utf-8?B?eThvOEd2ZWRyN0JiV29HWVpQcEM3K09hZG51NVYyaFBaU2l6Ly9maHlVbFZx?=
 =?utf-8?B?dVVWUFNudmg1OXV4ZjI2c0VBY09leFlCTm5KWnIvc3JXNTVtbm9WMzJycmlE?=
 =?utf-8?B?SnAwTXo2ZWtFT1l4eWx6V2xCOEttN3RYZVJMZk9FQ0p4VFc1SVFQK21oeGRR?=
 =?utf-8?B?bWF6aHR1cENncHNMbzdnR0llSnBCMWpkWExtU3YzaTZpdWc3RFNvRWQwWE9M?=
 =?utf-8?B?eDRUUHVncDEvTFRUaWZpNDhJZ0VIQXZURGhwUzZyY1BkTUF5a0Vrd1RlQ3Jo?=
 =?utf-8?B?OEdqQ1F1eUVHTGRoMFRkUnpzMVZHTmNSdFN5bGE3NURkL2Z0WUxjOXpkQm9K?=
 =?utf-8?B?ZUFDQnVOM0YrMCtkUThnRVFVSG9qODlxYmZLSWhoVzNSb2ZUUFdqVzRqWjNz?=
 =?utf-8?B?TTd3SUpkbndMVWtwOEc5NlJZWkxKSUNWbHdyaGJtSy9IMUx2Z1JvV2g3YUp1?=
 =?utf-8?B?YVN0RzU5OU1jekl3THJ2a3Exb1FISUsvNzBSRXl2TU9RR1AzUGxCZWVBQTl4?=
 =?utf-8?B?WFYyUDczVDhiZEJGUGJhN0FseERLV250ZlJIQ0tzbUhnY25wZ1BBdjZlM1cy?=
 =?utf-8?B?SXduODVWMm5xVEdZZHlyNDZJSG4yWkVJa1cwbWxTd2NYMnN4NGo4Y0ZPaHB6?=
 =?utf-8?B?bWNmU0ljSGRSSnRCNENuK3pwL1htWWRsU0ZBRWRSZlMzRjAzMGhXYWtIbXpY?=
 =?utf-8?B?anBCbWZjV212K2N6VWpYN2VNSWFzaVhrdEdMU3N6TUpFSk9nSmNwWmsydnA3?=
 =?utf-8?B?TGlkejBFRDJlQnhlVGZIMFlkNkgwdlViYXk2NGxHOTdueCtCaHRVaE9kb1hl?=
 =?utf-8?B?K05JVkd6TmhQdFAxNU9INlY5byt6aWJHYS9lckJJOXhjTnY2NUNHUEsrYlR2?=
 =?utf-8?B?OVZNMW1uZHN5YzBIVXBjay83WnNGZ3pNRUVJa0NvKzRNSXpJcFNNYys5M1B0?=
 =?utf-8?B?Rk5CQlJMNGkyelJ1N1pGUDhpM1JCTUdGR2RVV3hWRURHa1JEWDVVaHhZUEhI?=
 =?utf-8?B?TVlkZFpCb0pmMkIydjdmSmJERi9zampxNEh2SHVPU011NUlwTVlDVm9mM3BR?=
 =?utf-8?B?Q0cxZTJZZWxrV1FtcFYrNVFUNVRadUVYK1orbFd2WXlEenVlajZTVzZnYmxa?=
 =?utf-8?B?ZFpvczhoQnM2S2F3YkNqSklPR05ZVnVQc1l5R1gvNFZqTXVjZXJQMHpHYndh?=
 =?utf-8?B?ZmhFUm9aeWxjVmNpRHZrRGRJVnI0dXdhSTBpWkk3UTI5WHBVcmJuSnc4SzhF?=
 =?utf-8?B?TUtjeDYxSUFPRCt1NG9sQWhZaXR1a1QwaSswczhLQnh1Tm5NU2NLcFZLMk9n?=
 =?utf-8?B?QzVEQ201UnNnUlNDTzVXQUVVRlo0NXNXTFY0b0hVV3ArOWpub1d2cnJzOUQx?=
 =?utf-8?B?Z3M4RzVzK3ZDdzV1TTlMb2pkbSsvZ2Y4QkhTRjBYNXFtVnVReVB1cWVrTTE0?=
 =?utf-8?B?SXpMN1Y5a0w4L1FwNDlIbmJYamJSSCtFM0FNUHlGZmV3SURRajU5dUlvdnIw?=
 =?utf-8?B?K2syQlJycjd5MTZjZ01FT0dsQUQrN0NFZDJuUTR0d1JlMUFPdldheFVTeTFW?=
 =?utf-8?B?QUxKS2ZOeEJXK3hrb1lPbEpRVGRwWmQwd1FJaEV5QkZOQVgyN2tDY0xnckVL?=
 =?utf-8?B?UnBGU0FIbUVBbXZDd3k4RUhzaE9HNFRpSzZqRGJJUExRc2J2bWVmTmwrLzcz?=
 =?utf-8?B?Wjl2ZFpYaEpsNm9wTVlzUmQrbHJxeXluaDNmWitVem1qV0xVUmF6d292SERp?=
 =?utf-8?B?bGdseHpDWEZLMXI1aisxQlFwbUs2eSs3WmN3alZrNDlXNVAyQmlUSkRJMXlt?=
 =?utf-8?B?Z2VsMDdCVm94aUN2THZ5M3JTOXhxdE94R0JzNGhIOElycEhwM2VTYlU3VXVE?=
 =?utf-8?B?TS9qZHlFSDlac2NTMlhDb3ZlSXVQUm5RNFBKTVB2c2FJSDFkK2Y0aUJ5UjhV?=
 =?utf-8?B?QlpKN01OV1Z3aWxsSk9rL244NWV1TjhHbVFXRU0wcHlpRW9FYUk0Vjc0dTJH?=
 =?utf-8?B?SGFtc0htcE5ZMzU1NDNJSENFWTBaeVhWTHNhRXJibjUwNlJab0d4SjVrRUg0?=
 =?utf-8?Q?Ux2isrmAOhW3zuuotbKlvtkrtVpOvYOag6/NdymuQ5Oao?=
X-MS-Exchange-AntiSpam-MessageData-1: +nbZsU+rtJJtrw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cf1602-37e8-4dfb-c6bf-08df07abc27b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 22:03:59.7287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9oLa7PPvXqyZrUnH4cW11LdKqys4Udv8fDpKYe6VcocoPqZo0VZ5WjqjuYBKx7aW0qDx8rDMUB+cIfdLReI9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10760
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 8/31/26 21:01, Denis V. Lunev wrote:
> On 8/31/26 14:31, Markus Armbruster wrote:
>> "Denis V. Lunev" <den@virtuozzo.com> writes:
>>
>>> On 8/27/26 11:15, Markus Armbruster wrote:
>> [...]
>>
>>>> We must not (re)open a dirty image read/write without cleaning it,
>>>> because writing to risks corruption, i.e. data loss.
>>>>
>>>> When we open a dirty image read/write, we can clean it without
>>>> inconveniencing the guest, because the guest cannot access it until
>>>> after open completes and we connect the newly open image.  Correct?
>>> correct.
>>>
>>>> When we reopen a read/only dirty image read/write, cleaning it *can*
>>>> affect the guest, as discussed above.
>>>>
>>>> As far as I can tell, all the trouble discussed above ultimately comes
>>>> from letting the guest work with read-only dirty images.  Why is that
>>>> useful?
>>>>
>>>> What are the use cases for opening dirty images read-only?
>>> Read only images usually comes in image chains (snapshots, backing
>>> stores). How RO image becomes dirty is very good question. May
>>> be this was due to QEMU stop/node crash during running commit.
>>>
>>> Why this is needed? VM should continue to start with dirty
>>> RO image. Doing maintenance at start? That is also problematic.
>>> At this moment we can face shared lock on base image (so called
>>> golden image scenario).
>> We can "do maintenance" during initial open proactively, or during
>> reopen read/write as needed.
>>
>> In both cases, we risk delays that can make the guest hang.
>>
>> Cleaning as needed might avoid some delays.  It can also shift delays
>> from QEMU startup (sometimes bad) to guest operation (commonly worse).
>>
>> Cleaning as needed in its current state appears to violate
>> blockdev-reopen's contract: it breaks the transaction.  This feels like
>> a regression.
>>
>> I think cleaning as needed poses challenges to management applications.
>> I figure sophisticated ones can make a reasonable choice between "clean
>> offline before you pass to QEMU" and "don't, and manage the delay on
>> reopen".  For less sophisticated ones, and also human users, all this
>> feels like a trap.
>>
>> Have we considered dirty image open to require an "I'm sophisticated"
>> flag?
>>
>> Anyway, this is how far I can take this.  Now the block layer
>> maintainers need to chime in.
>>
>> [...]
> The problem is that we are opening RO and could not change the
> image. That is the worst part and not just by the fact that
> we opening RO (we can try to reopen RW) but by the fact that
> another QEMU has already opened that image and we could not
> take the lock. Reopen here may not happen ever.
>
> Both ways are weird, the question is what is worse? :-)
>
> Den
There are 2 additional note, which I would like to share.

1. Denying start of VM with dirty RO image is no-go for
any migration of such VM over shared storage. Nothing
could be done with such a VM once node would need to be
upgraded and thus to be moved. That would be real hell
for any operation.

2. Though this could be mitigated with an addition of
forced image check through QMP and that makes a lot of
sense. Fixing image integrity for alive VM even with
several seconds pause could be a real life saver. This
functionality smells useful.

Thus we could
* make a check of RO images on start and deny if the fix
could not be made for whatever reason
* and add qmp-image-check as a command for specific node
as command

This could be correct API wise.

Thanks,
    Den

