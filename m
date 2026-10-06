Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7438DCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1v-0001En-68; Wed, 07 Oct 2026 04:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHkk-0006QP-O0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:05 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHkd-0004nr-RI
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:51:32 -0400
Received: from AS8PR08MB10271.eurprd08.prod.outlook.com (2603:10a6:20b:629::7)
 by MI9PR08MB529542.eurprd08.prod.outlook.com (2603:10a6:290:82::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 23:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls/0iHMwtJQnVmQjd0hRbn49D8OsgFkD9OFHHglqp+oezMXj/hR0tTcotuLRp/QuvlY+GSz5L/WVkY2wT2jJHmpZX7EnOrq9e+i+71UXhp7FMFNTZg+v4IBIZPVSaQ1NS59gImUYLwOi9e99Up6upf7kD4jdSKfcXRB2BqfFCQHbVLZ04ihfkqjhEjOoGBzf+4Dd6z4f0aQuT91wsNFX2pOh4IQY3RxfeY+d5I886mIYIUYlacgHfk8tl7scJcHGrMacon6NLTTWtGlW/HIFLZTP7ekYQK5BNfaft5I4aivWBQqTlYL94NRSmTzn/Ip6V1p7MN3zQboi5XpIyeA/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4baTRgPE9auMN6amL7rEG3A/Fd5e+bg7b9B88ofJqY=;
 b=hDM0/FmlGSskhFfsrzuPDnP+RJt6BcbojC5NXMd/A80LiPfXvyz7HUjlhStUgNI1uTSvOHzDVN0DB69DSo2mN1J1GNxR8H+ZneImEsdODSEVQq5fhcTuCAAPmjR7OLb9JbiTDhQGM3PxMrXp14MpOfTZYa+99UnbZQpwNo0QCTYq4a/GNuqp24j6rFL7Ihp08LEX1We9ouCfp4cx94O9UnoCmt16a3Ywm8d/XguCQJC0nTXTeOUGWI8fxVPTH1aYkAnMSZIenzQLrCYqfs6eBtt/Gz5aWhxaZmC6MUu986dp4sb4yYrEoD4EdzNRY1wCpHA1DKQdBHl6XUCBG0Gb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4baTRgPE9auMN6amL7rEG3A/Fd5e+bg7b9B88ofJqY=;
 b=fCVBOhnEGflHH1PLBQWL4MFutNeuIYak5UpyQ/2kzR13I1rQP8SozE3x+H/YuIpIMstYJECCoYiZPmWWYPaPmvNnBpLeZla56A40mBQWbdtGaYdgR0Ko6ejmXkjMhHh15PrbOdKKnTkrWrjHLJOixrDkiXhDkwVlQg0BQ1FoY7IyZnVPzFI4LQZYCOeboxvS0RfLFLYoC2EoPDlQGHx3E1hqbnvbR9cr1IVyAbfBBrD1vNGNRwk97y3/vvzJ0iAhiioWuTR4dgwhVVxVWGQNUFQ89KWUtHJtXY57cs05MH3jXwywj/Q94AbbhZoMzBZVoLYDq78JXQlsVJm50AdLjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10271.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 12:33:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 12:33:58 +0000
Message-ID: <820e6db0-204d-401c-adf9-ab6e4a8637b1@virtuozzo.com>
Date: Tue, 6 Oct 2026 15:33:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/21] migration: add incoming migration failure
 notifiers
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, mark.kanda@oracle.com,
 bchaney@akamai.com, mst@redhat.com, sgarzare@redhat.com, peterx@redhat.com,
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, den@openvz.org, dwmw2@infradead.org, farosas@suse.de
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
 <20261005-up-vsock-vhost-v5-v12-16-40162390c68a@virtuozzo.com>
 <c9e3523e-a2ca-4187-8274-225f2c667c53@rsg.ci.i.u-tokyo.ac.jp>
 <d4bed047-06c6-4b7b-a886-80dfd3223022@virtuozzo.com>
 <1f3bffbc-ca46-4f66-b23d-d40d5033666c@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <1f3bffbc-ca46-4f66-b23d-d40d5033666c@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10271:EE_|MI9PR08MB529542:EE_
X-MS-Office365-Filtering-Correlation-Id: 0935dfe3-9732-41d2-0026-08df23a617a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|10067099003|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: 4Wo/WcNTvgycE7V1haFj3v6L1LxUQoxKB8rv+PoiEs71TmuwCaRHUI4GHu8jFcDuy9z0rdHx0A2Eqi22k879ufchZCgkZitbvYnPLM5ovtDrL+g4bPrAf9eZDDs17O3GmVujEq+8gIRsN5W0VAD534Dn6y2JSM7CnnlLKl3ZbY+oKwR6N/SP3BaR9m7YabE30JDJydL9hDxdmysaGXhwF2LUKadI6tJ7pt7iu9F/Djix/khrPBH/zhndglB4GSCa8v++31hZNtQvBzd6Qfur9szFfxdF03viHBiC80ezxhGEhnqgmdurZCRB3hbn1VtOSHvh3+t8HGRIMj9v1DkkD1gWJkY+ajgcoRb+KORYkWDU4Iacmqk5HK2F3QcCBrIrA4ojTEhxj8vxcdwzt1Mw93X17S5biszjjTg3sXFsUskWF499qmxywY/mXW2USNTKxXbVDohO+VjosnvOfT5D97mvabyCwJgfhpr3NM9PzOE6DGfL9plloJMQALibxjqNvUKm4sKPtNsf31kBzqn6ZCe00W2KHDGnDNEaZvYOn1HN+Kgwc6rAEc5j/pJYUsuGIDS8VBI5oByd1XfTDwNKJo84x30mVz3nyHlSQwhwVokUzl4SDfHN7wIXKkL6DCUVDFt3+KIFCHoZyW+lm7Go7Fw6wKEFBBm5lb47ROlNRC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ErSnR6RlpNYmYrSGkwa2FRRWZ5anlSNGxvbFYyU2hHbStoS0VMZlZPZVlv?=
 =?utf-8?B?NlE0NUdpdkpuRm5FYVpJZmo1SWFVQ0Z4VkVPUVo2VkF1RW1peVpUMjVwY3Ex?=
 =?utf-8?B?QkZjbFkyN1RTWThDWE00ZDVRRVV4MFVMY1lwZk9GWXRMMjUyUUN4TnpRaXBy?=
 =?utf-8?B?UDlyNHN1Z3FZTCtOWlptcDFSeElRZ2VTdjgzcUhZQjZKcmM0K2VaSlI4RmFT?=
 =?utf-8?B?cVc4Y25kQXVBQXdDS1ZlaTVsdkZoWS9sK3Npc2hqQVdQUElydUx4UGVYWnpL?=
 =?utf-8?B?RkdoZy9RU3ZLNnE3ZUx1NVpNWDZUek9jMVFQblRlOUpXaVBwdkZJQ0JqTStn?=
 =?utf-8?B?U3p5allQU2RvT3c1ZC94MWhBZGVvUmZUVUVqYXc0YmRjMXpIVS9Pa056ZDNn?=
 =?utf-8?B?R0ZJQXBSV3BWYklRU25qOUNJT010SjJYU3VXR2hYSTZ0eWNYRmF6MGtLUXlF?=
 =?utf-8?B?L1d3M1JIckFLa1R4aWtRVk1sdUcvbnAxV2RIRFdmYjQyMndyZXpFRUNla1hu?=
 =?utf-8?B?VnlTUUsxdmY4TlczR201L2JwV1RtYm5ZR3IrenIrQUlGaHRuUnJMNm9DUXNh?=
 =?utf-8?B?T2FBaitENUkyUysyY1RRNlRyaXNMSnJlY09IVXo5bWlVK0lVd0toRUFIandO?=
 =?utf-8?B?cXlabVJDbkI1dDE0NnliV0ZkWkJNZGt6ck9MazJWbnFCdm9wM3hVRkRuWWVy?=
 =?utf-8?B?OU9LaEQzVk9kakx2S3BzWWcvMmRwZ3N6NzJEWVF0TUlpVzAySERpOFliNEVV?=
 =?utf-8?B?VEdkK1NHSDMrdG5NKzdyMHhsMHRsWDhIRDkwVGtscWswL21OQnJjSUsvYWZT?=
 =?utf-8?B?eHpXbCtwVzZVaWFhcE9PYzRIM0Q1Q2xidVlzN0liZlVtUkJIU0ZmRENmT2Fq?=
 =?utf-8?B?eG9xcDE5TDE4R3Zud0FLV0MxY1RRYUVYdEhHR3drU1ZyZzF3U3pBMCtUNGxO?=
 =?utf-8?B?TGEzaHllNVRPOWRpWi8rVzNKdW9vT0JYUmFUZ2p1TXpZVEN4NWFSbWFHckZX?=
 =?utf-8?B?MmRJc3Myc2YxRVMvRGxTM0prOTZESXkvcUhxeWtORzVZZVNpVzQyeXJFY21T?=
 =?utf-8?B?RktzeE9sU09RblM3VURLdHI3NS9rNGhmWHhhSVJvL1pJVVgxaDFSaDVjanZq?=
 =?utf-8?B?NkZOaW5BVDFyVCtUWjczYTJuTWYxRWtlVVc4ZXB3UEtjNG80djVaOFR3bUdH?=
 =?utf-8?B?UjlMcXhDU3lmZ2t2OThHcDlveFNOY1NvTmNPdkdVZUMzMXJaZFkzNFd4cWEz?=
 =?utf-8?B?OW04YkJiRnZTUXVUVmRhbUZpVklyZ2t2Tzd6V2Z0eXlVcEo4MGliZ0dWcmM5?=
 =?utf-8?B?c1V5SzdPci9JZUE2UUIzNUs3N1Q0akxRejNyckNadDE2clI5N3RqMkJZYS9I?=
 =?utf-8?B?bCtNd09Kb3gvS09wOTRlYVN4UDk3N2lPQjVFend0MDJEamhMKzhGVVFYb3BJ?=
 =?utf-8?B?TktQMkl1bW5QNXBnV2JzZUVyaHhLUGlvMW01NVZ4akpFcGxnbDRqZzdqRWQy?=
 =?utf-8?B?YXNpL205a2lVRTZqSjMwSEd0aHZZNWhhdXU1Q29Pa2lLc0ZSZHZzODd4Q2dN?=
 =?utf-8?B?dWxFYXpHa2FjRzhTUDFuN2dVV1hCRzlCdm5CWklyRlFob25vTVVoNU9mTFRl?=
 =?utf-8?B?cFkyUmt5citTMm5iVzA4SnZlUFRINVdPRzVSVlR3WWZPeWR3c0RlV1ZiNERw?=
 =?utf-8?B?MFhXc3IzT1cycWpEdTFJZWFPK05OMHFuTG56Ym5nSFY2RXJORG55OThzQnh4?=
 =?utf-8?B?djQ4ZXE3eDBoVEZGVHBQRy9qQ0UwMnppWFNMR3lKbkRISEVCTW1zamtVQmwz?=
 =?utf-8?B?VlZLeTBzRk1IVTJUUlZJRHQrYlkwQnVkQm5FQk0yNXpIV0NiSkFHZlo2QjlK?=
 =?utf-8?B?SDQ4V1REdHhkbkpYMGVnbVAxaXJMdWVGdlNYMDVQdE0rWHBoT21iMnF3czNM?=
 =?utf-8?B?YkcyQkFITVFZbW5WSFBLUkF1eDJRZlRBVC80cnlWcUtRVnp2UDJWSVQwMjlX?=
 =?utf-8?B?M29hamMzcTFpOUE0Q1pBcFBoQmw4R3NKajNld0RDb1ZKQnppSlNtU250WUxF?=
 =?utf-8?B?YlMxbnZ6NS82QWpDOWdoTThnQzRNOHdKejZ2MU96THJYbFJmWFJKRDdEa0Zv?=
 =?utf-8?B?Vlg4aE9GTWEwaGhyWDRER1dPVUhmWGtBZ2J6U3J6dXlEMnoreTRUWkR6QmlK?=
 =?utf-8?B?VGhnNWlZVWt6ek1BVURBdXNFbThBTEF2VU82c1l4UVJORSsyY1V6MmU5RGlE?=
 =?utf-8?B?ZkVaeDY5N0QybGMwOGN2UFVnc0s5bUxMQVhONmh3YVc4ZUZ2TDUrWERhTU96?=
 =?utf-8?B?Q1ZqR1hZV0RxY0kzTXVpSnB5VEVia1RycjZsVFlXZTJCd0c1SExLQklMYXpP?=
 =?utf-8?Q?B8CEfQX/9YNRx1tY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0935dfe3-9732-41d2-0026-08df23a617a9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:33:57.9582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bx+021P6ID64rRZXzxDg9JH+Y1Dk2tCUqv6Bweexh+Ky7zKYGBoqjWTEtalCEmx+tXVhz++XL9puAIhOpbHzySUesm8SfHcqXNQ2PTofJ6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10271
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 10/6/26 2:56 PM, Akihiko Odaki wrote:
> On 2026/10/06 19:28, Andrey Drobyshev wrote:
>> On 10/6/26 1:03 PM, Akihiko Odaki wrote:
>>> On 2026/10/06 0:00, Andrey Drobyshev wrote:
>>>> A device may take over a resource from the source in post_load(), e.g.
>>>> vhost-vsock acquires the device ownership on a CPR target.  If the
>>>> incoming migration fails afterwards, there's currently no way for the
>>>> device to give that resource back before the source is told about the
>>>> failure over the return path and resumes, or before the target exits.
>>>>
>>>> Add a notifier list for that, called from the failure path of
>>>> process_incoming_migration_co() before migration_incoming_state_destroy().
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>    include/migration/misc.h |  7 +++++++
>>>>    migration/migration.c    | 23 +++++++++++++++++++++++
>>>>    2 files changed, 30 insertions(+)
>>>>
>>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>>> index 019717f4cda..08d110750fc 100644
>>>> --- a/include/migration/misc.h
>>>> +++ b/include/migration/misc.h
>>>> @@ -112,6 +112,13 @@ void migration_add_notifier_modes(NotifierWithReturn *notify,
>>>>     */
>>>>    void migration_remove_notifier(NotifierWithReturn *notify);
>>>>    
>>>> +/*
>>>> + * Incoming side: @notify is called when an incoming migration fails,
>>>> + * before the target dies or before the source is told about the failure.
>>>> + */
>>>> +void migration_incoming_add_failure_notifier(Notifier *notify);
>>>> +void migration_incoming_remove_failure_notifier(Notifier *notify);
>>>> +
>>>>    void migration_file_set_error(int ret, Error *err);
>>>>    
>>>>    /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index fab7949fe11..55ea1e019fa 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -71,6 +71,8 @@
>>>>    #define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
>>>>    
>>>>    static GSList *migration_state_notifiers[MIG_MODE__MAX];
>>>> +static NotifierList incoming_failure_notifiers =
>>>> +    NOTIFIER_LIST_INITIALIZER(incoming_failure_notifiers);
>>>>    
>>>>    /* Messages sent on the return path from destination to source */
>>>>    enum mig_rp_message_type {
>>>> @@ -818,6 +820,17 @@ fail:
>>>>        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>>>>                          MIGRATION_STATUS_FAILED);
>>>>        migrate_error_propagate(s, local_err);
>>>> +
>>>> +    /*
>>>> +     * Allow the devices which have registered their callbacks for
>>>> +     * migration target failure to undo the changes they may have
>>>> +     * done in post_load().
>>>> +     *
>>>> +     * Do that before migration_incoming_state_destroy() reports the
>>>> +     * failure over the return path (if present) and before the exit()
>>>> +     * below.
>>>> +     */
>>>> +    notifier_list_notify(&incoming_failure_notifiers, NULL);
>>>
>>> This invokes the callbacks after migrate_set_state(...FAILED) emits the
>>> target’s QMP event. Without return-path enabled, the source can already
>>> be POSTMIGRATE, so a management application may react to that event can
>>> resume it before ownership is released, causing VHOST_SET_OWNER to fail
>>> with EBUSY. The callbacks may be invoked before publishing FAILED.
>>>
>>> Regards,
>>> Akihiko Odaki
>> Hmm, looks like you're right again.  Also looks that this gap can be
>> easily closed by just moving this notifier_list_notify(...) line right
>> before the migrate_set_state(FAILED) above.  Do you think it's going to
>> be sufficient?
> 
> Yes, I think so.
> 
> By the way, I found another scenario that may result in stranded ownership:
> 
> 1. Start the target with -S.
> 2. Perform the migration successfully. The target acquires ownership.
> (The failure notifier never runs since the migration succeeds).
> 3. Quit the target normally.
> (Note that devices won't be unrealized when QEMU quits).
> 4. Resume the source.
> 
> As I noted previously, there are a number of ways the QEMU process can 
> exit (via exit() calls and signals), and I'm not saying this particular 
> case needs to be specifically covered. I just wanted to bring it to your 
> attention.
> 
> Regards,
> Akihiko Odaki

Actually that scenario is the one which'd be covered by the exit()
notifier.  Maybe I've rushed a bit removing that patch.  So what if we:

1. Keep this patch, but move the notifier_list_notify() right before
migrate_set_state(FAILED);
2. Bring back the exit() notifier from the v11.

That way, in the cases we discussed previously (e.g. broken migration
stream) both notifiers will be called here.  However only 1st one will
fire actual RESET_OWNER, as it's still guarded by hdev->owner flag.

What do you think?

Thanks,
Andrey

