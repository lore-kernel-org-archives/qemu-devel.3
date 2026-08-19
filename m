Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C663FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwi81-0005H9-SF; Wed, 19 Aug 2026 11:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwi7z-0005H1-Oa
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:22:55 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wwi7x-0005JC-MO
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 11:22:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxW3sijeMqT/XbDVu6sP6K8TClNM2WcGMUSServ6pojhDMzRJQd3DCBgQHTSD3gGWEP1EQH6ZhFzbVu4VoJV/yykZW6fCui3hHgjqnqOfOCRqg0MjNXMRVCbbct5h7yLptKHf8kN5wfc0AqFi2AyRRH2HD1yaAYVysueQKRvMQzL4r3EyaSpJ7bLJQHJ0EhX2rUvf3JPE7iAQzbRemomf/ySV+cjl7Edu1zlOkcp/syCpxgeSio9f+t19dFObI6nrd+AXFUyDnehgeit7PLAAjnJZ5FKtTi4ejz+sxZLHvU50XFhqts0elmhv0ok1MhpnYf5jQlEpqfMfXxwk3hCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmTGE/pT5jpM8bru+aAySfW+5HJTkVTmRfnqDlGTNgw=;
 b=uUGJfxLnHG9dU/Cj2sUrbfLdxjWijeDB1BVeGDwPjgbYTjVmuGdhY5fISKhHn1AKo2epKsMg3dlv/sjGk9UdEadAPo5QNVJOXTtl1GyRJSkmaYb9h+FqblCte1/eyCDDzHySbIqB74k4Yo0+MXoJWyENOpgZan8jxrgmZLz3jQ/XFfXlL0pGIKDiS3hUh8L5IzKXFXT7Da1d2v8evUal1zq1gtwOlNxvTFUyx2B/E4YwaV7QTIBqUNo8EhR0HpfqKfinATXvt0ntEvR7mH/iA2ImkY0IHDjXwkXIHPP480pNwYBiKmRJpcd0BcRUaDty36KVU3utgrkWXZ72qmRjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmTGE/pT5jpM8bru+aAySfW+5HJTkVTmRfnqDlGTNgw=;
 b=UN0icU9h48HYbhkelptcVJsnGxvrQ+v5OJ66DAhK7YrBOVv2KWI8X+bugok2xuvmUmP52m+ySJtbAf2WOeeWB0AlKq09J3GXx/JHOCUMsiB4urTEuQnzX+NAE+xT8IJoEXsELC7U60FNHBA5SZnfSoIN+ywV6gxeuKGpam6tGQ+DfzDhdUtsaTxFQyIVN4KDSENAs/whWO+Nm+bCkaaE6bfYhGr8ohtcrs+WzxZqaa7H6zhGJguXj+OGd83lNGMwStM5D8muvGG/tvVOuL/guRifWaiFlQEoICAwniIU7DcOQlsc+yP0TRDXsGhf4/4+LgIHZB9IW3tKRF9OcnLg8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AS2PR08MB8926.eurprd08.prod.outlook.com (2603:10a6:20b:5f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:22:49 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:22:49 +0000
Message-ID: <dc56f46b-08c0-4a51-b5e9-5d17c3bdab17@virtuozzo.com>
Date: Wed, 19 Aug 2026 18:22:47 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com,
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
 <aoRyAqduT4FRj9NV@sgarzare-redhat>
 <bc812e7c-a30b-43f4-9803-26259bb3a65b@virtuozzo.com>
 <20260819111110-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260819111110-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0209.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::26) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AS2PR08MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 397fd78d-53a7-4075-5ea8-08defe05baa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|10067099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: bjKk3G4wo3kZMJoxRvzuhEgItpDWEtqr38/+MNmKdA+ExOO+hp8dgZww08nCqdbLIz1XCaZajBwn73tZm9MUsg8zNlqvxYz+V9Dt68RbdVzNAxc+eXEwrSsxFmE+jIJB5wpt90M4S4AK/go4Z9f6N+xccAA8f+U4LKytCm5twxVbbfWb6nv/DlLvZsj6JysaooGKkH4F0LqDPgU9hYfLCS6ROUF+Izn8pztZmHhLmoJgXnEwNysso8I3+oiIdbYuGzlP0J085/CGybVQvsbwEmWc+/tFcnygW6ZIQ/Q2vG7incjlBrsIQTD0TC54RzUAm60wMIovdKK7L87rro1iX8gRJkwCY5AmLX7w32Qg49IAamzVcItiJYtLykGGaPUdAQY1ueX3FxUrYy3pUzj/5ClpxaPxonwXJprGoGgKlUb1vZpZUvOLqFKket7pdAPxrYScJDYULmg0X4fckc9mCAekw7oeJdX4iQPTqSVl5Pxt9Wc47ATiZkf+dYZPLMrJAStubp+qXslEp/2oBfbTM9sDRvx/dDcFDgNewlJrvZEF7Twtcp0l/mP/no5b2Vt3KV/aFYTCNs4oBZOwFrhpow2WGhEp2w0dAw5IgcHban3ShUgESuHbQY4LzEgH/3F2IdZi/+0yX12uvNIsVRDFDfrqUoX/LjI9/bGf3khWu90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWhrWWxGYUc2T2gzL0NyYmFDSnZCaklPWHp5Vm5OVEtXYU51TUFnbndoaWpQ?=
 =?utf-8?B?NlBrM3FBb2t0Nld1MndsaTV1dXpaRnJGVmNReFVPallSeDBJK2EvK1V2cmdQ?=
 =?utf-8?B?cm1uUm1scFphM3k3YmYramtZZUt0R3BxemtSZXpuaGJDVWhuNmVuZ25SMzdT?=
 =?utf-8?B?Zi9ETFI0VzNYYnZqNHZ5WDdSZWMzditNVVpvdXRRNU8ra1c4bE11TDlObUht?=
 =?utf-8?B?QXAraEFTRks5NEs2ZElGdlhNQ3RWb3haWmV5Tms5RjhLRm1RL3pvQW43ZXdR?=
 =?utf-8?B?QVQrakI0R1RzbGhsbkJtV01FQUdnWlc3NjZRVk5rekhSSW1nV3NaZUFjME5t?=
 =?utf-8?B?QzlTVnNQQ0hQUXZKOG5JcE4xeWs0Y1kyNDlxdEFQMy9ia0VVb2pjSWVmU1dz?=
 =?utf-8?B?OVZ1TmdwWERseWJad0pLRktkcHdVZVI2alFzdzhEUGxGSU5aT092cmNyVndO?=
 =?utf-8?B?M0tuQWFVdWtGQTdPOW9UYlpJNTh1RHFHdThLbGNrN044TllMR2xPbTJwblg1?=
 =?utf-8?B?bHA1NWU5bmxBRml0ck5wekdyaGY3NHNnNXczaUpiSmN4eEdydkZRRmh2TW5s?=
 =?utf-8?B?OFZxSFpYUXF6b2FlN1pOd1pJOUZmMGpTcVlRTHJYc3cydlZqWlNxNTlVaU4x?=
 =?utf-8?B?eUt0ZWllZEMxQS9Jekp0OW1CTk5vbEpJWWYvd0RacUZkU2tDeHUvZ0ZCMkFi?=
 =?utf-8?B?UXpCRituTnRYbTM2Wk9BZkNjT1AzU2FlOHV5YkJFTjJsQmp1RWxlM3FBV29o?=
 =?utf-8?B?WXQ2WnBQVjBQUHRrRHdDaVBTWW9kVXRGMnVWNWJtRnltN1MvTGI0VllOcVNW?=
 =?utf-8?B?d0lySm5HUUh2aFJyaUFtV0NnRVI5aUN6Z1pDMHhMcnQ4eUZXUzMvVWtpRUNY?=
 =?utf-8?B?bG1BN1NXRE5qbEZEWFJocW5VRXdnb2s1cmVNZHZZQzhpZGNmQ3hlOU8vdUJY?=
 =?utf-8?B?WDd2S0lpdnpHTS9PMlNZUjRBczVNU091NC9aclVUZURPSzkxUlNuVzd4Ui96?=
 =?utf-8?B?Uk9WS1pBc0RZb2hrd0dOZUxBZXZvL3lhS25DZ2FFbGhGTTVhVDdha2J4RTVs?=
 =?utf-8?B?aTVraU41REhva1VZSlRtam14dW1oMitRcHhlVWR0LzVOVVM5Vm81STBNRU5H?=
 =?utf-8?B?YnYrYXBMZEtJOExEY05vY1NremFCL3F6YXd1SkFuclpEdmpLWEFBRTE4dFBS?=
 =?utf-8?B?L1A0Z0pHQTlJaTh0YWZhSDlnVkxDejdQWnlwUzR2bVViTlFVTzRlbEFRV0NF?=
 =?utf-8?B?TGVReFRxRWZnYWlGa1JWbk1wT3IvcVd5SWlzTXpxTDlxZWFwMjN4SmNXa1Uz?=
 =?utf-8?B?MUhNa3drVnB1UFY3VzNFcnJJOHdJekdqdTdrM0J2NDJ2QlFSWkJJcytQa2VW?=
 =?utf-8?B?d3M5NXJRQjRRZzdYT2dxRm5mdWpKWWhZN0g1dGh1U0pOdGJyUlYzSFNQTzVZ?=
 =?utf-8?B?aEhycXFQd3NlVEVlcE5mQUZUMFJUWmRpSVVFMGZ6R2NHWnBDMnlXZXR3TFlt?=
 =?utf-8?B?dW9mYTc2VVFUSjVMOUh3c3pNcU9OWjdhbWJMOGYvcDFqV0hTZE1xRE5URXp4?=
 =?utf-8?B?TGNZRUR1dmVOWWZEN0txQzNSVnJPTXJLWnYycEoyaHlqU3J1eUNwWERwbjg0?=
 =?utf-8?B?OXRXS1NQVDR1WW44U3FtV1Z5aHhaeDNrQkI2c3NpS3NPQmxhOEdHcDB1SXVU?=
 =?utf-8?B?TllPdWNtUnhBTkF6b2hReVhFeWFpNXlpTURnWm91T3VkbkJSRUxKM0JkeHBv?=
 =?utf-8?B?UkdNU29rSURiQlBMbjBtUE9DQXBVUWlVQXgzL0p0UkFncUNBUE5uWDQ2MGpV?=
 =?utf-8?B?VDd3VnhEa2k2cWhxU1Z0ZkZZTkx6d0sxVzNyR0Nrakt1cktlS1lQa0JBdDhT?=
 =?utf-8?B?RDhmZmxJKzliQUVDRHAwck80aTlIVnJvQ2FZWjJZcHRIUy9DNzVyYmlDOWtP?=
 =?utf-8?B?aUpJaVlJUzNaZVB1MVdSbUlsU3JrUER1eFRueTRwR2toZVpwWkFSZVh0RW1j?=
 =?utf-8?B?ZjVGTHc2YXNBOFFsV2V4Q1ZHTFdqVFBOWUtvSk1RdjNRZUpRdGZNcFg2Z0lq?=
 =?utf-8?B?NHpseXRjZGx6K2x6VEY2c3FsRnVLS0V6Vmt2MjUxY1o2OFRsZVRIN2xnZTVi?=
 =?utf-8?B?ZVNVSVZYSGJWTjBMMk5CK0tNYmFiM0VRUWI2Ym55ZzZqQ20zOTJ5czRRYjFy?=
 =?utf-8?B?R09ZVVBqZ0ZROUJ4cVUwSGp6Mmk2Mm9sVkJJd0JnR0NidkpWWjMxWWg0RU5i?=
 =?utf-8?B?dzVXd2FVVmVyZTBEUUlRL0poS2hYMVFQSFhrYm1pakhsTkdnTnBZWGswbDBF?=
 =?utf-8?B?WjhtbGx1Q2NrZVlBbExpQ0dOQ05xclRSWDNIMC9HdnlhSjZaQ0tCZ20xRnR5?=
 =?utf-8?Q?Bs81GT0mCT7/oaaQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397fd78d-53a7-4075-5ea8-08defe05baa2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:22:49.3732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcfWcjeVTTLYTwHnC5FDJysH6y6T1QTl5FHZxOY2gyvTQ65UgM5QxjQlt3DR75MuGQzZVKR6Z4bcGr3ytlHaPdOiDghI4oZJgpruZPuaNgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8926
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

On 8/19/26 6:11 PM, Michael S. Tsirkin wrote:
> On Wed, Aug 19, 2026 at 05:38:46PM +0300, Andrey Drobyshev wrote:
>> On 8/18/26 6:29 PM, Stefano Garzarella wrote:
>>> On Fri, Jun 26, 2026 at 07:46:40PM +0300, Andrey Drobyshev wrote:
>>>> During CPR (checkpoint-restore) migration the guest keeps running on the
>>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>>>> we should reuse the FD from the source.  The FD is saved in the CPR
>>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>>>> target via cpr_find_fd().
>>>>
>>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>>>> Rather than make it mandatory for every vhost-vsock device, we add CPR
>>>> migration blocker which only fires once we attempt CPR with ID-less
>>>> vhost-vsock.
>>>>
>>>> vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>>>> Deferring the ownership handoff to pre_save/post_load is done in a
>>>> following patch.
>>>
>>> So will this patch be bisectabale?
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>> The issue is that cpr-exec already is broken on the current master
>> branch (i.e. before the series is applied).  The only difference is
>> which exact error we fail with: -EBUSY or -EADDRINUSE.
>>
>> In this case I don't think it's feasible to make each and every commit
>> bisectable - it only becomes fully working after the last one applied.
> 
> Surely just bypassing cpr things until the last commit
> is feasible?
>

Sure, that's what I meant suggesting the migration blocker.  Currently
we add the blocker only on 'if (!proxy->id)' condition.  I suggest
adding an unconditional blocker for CPR_TRANSFER|CPR_EXEC before the
series (new patch 1), and then only make it conditional in the last
patch.  That way each patch of the series would fail early on that
blocker instead of crashing QEMU.
>> If you want, I can prepend the series with a migration blocker which
>> would fail early and gracefully instead of crashing, and lift it after
>> it's working.
>>
>> Andrey
>>
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>> hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
>>>> include/hw/virtio/vhost-vsock.h |  1 +
>>>> 2 files changed, 47 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>>>> index fd7ffa88990..7eacb608d07 100644
>>>> --- a/hw/virtio/vhost-vsock.c
>>>> +++ b/hw/virtio/vhost-vsock.c
>>>> @@ -21,6 +21,8 @@
>>>> #include "hw/virtio/vhost-vsock.h"
>>>> #include "monitor/monitor.h"
>>>> #include "migration/cpr.h"
>>>> +#include "migration/blocker.h"
>>>> +#include "migration/misc.h"
>>>>
>>>> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
>>>> {
>>>> @@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>>     VHostVSock *vsock = VHOST_VSOCK(dev);
>>>> +    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>>>>     int vhostfd;
>>>>     int ret;
>>>>
>>>> @@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>         return;
>>>>     }
>>>>
>>>> -    if (vsock->conf.vhostfd) {
>>>> +    /*
>>>> +     * Having a unique ID is mandatory for FD preservation during CPR
>>>> +     * migration, thus we add migration blockers for CPR modes.
>>>> +     */
>>>> +    if (!proxy->id) {
>>>> +        error_setg(&vsock->migration_blocker,
>>>> +                   "vhost-vsock: device ID is required for CPR migration");
>>>> +        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>>>> +                                      BIT(MIG_MODE_CPR_TRANSFER) |
>>>> +                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>>>> +            return;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    if (cpr_is_incoming()) {
>>>> +        /* Reuse the fd handed over from the source QEMU. */
>>>> +        if (!proxy->id) {
>>>> +            error_setg(errp, "vhost-vsock: device ID is required for "
>>>> +                       "CPR migration");
>>>> +            goto err_blocker;
>>>> +        }
>>>> +        vhostfd = cpr_find_fd(proxy->id, 0);
>>>> +        if (vhostfd < 0) {
>>>> +            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>>>> +            goto err_blocker;
>>>> +        }
>>>> +    } else if (vsock->conf.vhostfd) {
>>>>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>>>>         if (vhostfd == -1) {
>>>>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>>>> -            return;
>>>> +            goto err_blocker;
>>>>         }
>>>>     } else {
>>>>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
>>>>         if (vhostfd < 0) {
>>>>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>>>> -            return;
>>>> +            goto err_blocker;
>>>>         }
>>>>     }
>>>>
>>>>     if (!qemu_set_blocking(vhostfd, false, errp)) {
>>>>         close(vhostfd);
>>>> -        return;
>>>> +        goto err_blocker;
>>>>     }
>>>>
>>>>     vhost_vsock_common_realize(vdev);
>>>> @@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>>>>         goto err_vhost_dev;
>>>>     }
>>>>
>>>> +    /* Register the fd for a future CPR after a fully successful realize */
>>>> +    if (proxy->id) {
>>>> +        cpr_save_fd(proxy->id, 0, vhostfd);
>>>> +    }
>>>> +
>>>>     return;
>>>>
>>>> err_vhost_dev:
>>>> @@ -199,16 +233,24 @@ err_vhost_dev:
>>>>     vhost_dev_cleanup(&vvc->vhost_dev);
>>>> err_virtio:
>>>>     vhost_vsock_common_unrealize(vdev);
>>>> +err_blocker:
>>>> +    migrate_del_blocker(&vsock->migration_blocker);
>>>> }
>>>>
>>>> static void vhost_vsock_device_unrealize(DeviceState *dev)
>>>> {
>>>>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>>>>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>> +    VHostVSock *vsock = VHOST_VSOCK(dev);
>>>> +    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>>>>
>>>>     /* This will stop vhost backend if appropriate. */
>>>>     vhost_vsock_set_status(vdev, 0);
>>>>
>>>> +    if (proxy->id) {
>>>> +        cpr_delete_fd(proxy->id, 0);
>>>> +    }
>>>> +    migrate_del_blocker(&vsock->migration_blocker);
>>>>     vhost_dev_cleanup(&vvc->vhost_dev);
>>>>     vhost_vsock_common_unrealize(vdev);
>>>> }
>>>> diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>>>> index 84f4e727c70..5ebc63afc5a 100644
>>>> --- a/include/hw/virtio/vhost-vsock.h
>>>> +++ b/include/hw/virtio/vhost-vsock.h
>>>> @@ -29,6 +29,7 @@ struct VHostVSock {
>>>>     /*< private >*/
>>>>     VHostVSockCommon parent;
>>>>     VHostVSockConf conf;
>>>> +    Error *migration_blocker;   /* set when the device has no ID */
>>>>
>>>>     /*< public >*/
>>>> };
>>>> -- 
>>>> 2.47.1
>>>>
>>>
> 


