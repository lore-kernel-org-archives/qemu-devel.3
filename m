Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF20C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 09:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl4Hr-0005D1-Lz; Fri, 15 Mar 2024 05:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rl4Hp-0005Cb-BP; Fri, 15 Mar 2024 05:55:37 -0400
Received: from mail-db8eur05on2070b.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::70b]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rl4Hk-0000TV-1M; Fri, 15 Mar 2024 05:55:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BahDBdak47TG8P7HHgxPwfGnssL2MhN9FyU1w1invkRjUYYI8gRQCawwRWm7LZH1/+0Vrjrxs3c+7mejL6topraaLOE/5joKzYY3mPqfnZw6aplLAw/26YpssZf3tOpUAwnWTI10sX/3FZD1VQUiyL7hhbJif/KAyIExY+h8NM94kjkJDp2Fx5pSVHA8Vf6Be2yXYuJhQDuT5qDZ54nLA775z+0Fu04FOYCQc8P33lI5dYeEENJV8gsp86OQa01PRaWSsFoeDwPTWfHJHUmhrbC5RrfZ85JWQKkQuErhA+6O+e/D/PjzjDbYE1AAoKlFs7T7EHEnMQW61L8uyWkFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLnxjKQaBArr5Nd3ORcq3c7/aajX9CExwnaENPuWW94=;
 b=M0NlkYkQjaic8H0jABClq4iLdHM92T8FwIUCBmLCnQfX2G02qbxnlS48xXV/bhGCgAmfk7C8mlUJhkq25eoGKcgT+HiVcNU6qTeHYOux+pTI2wPZRHiPvqI+9B39wyaaCcbJrUq8uSa8ty7VY2dvQ9wFGT2vGY1ehME9FQ+KzJU4h96ps9WV59LSh43R7Udx88toHVOnNJtX815mqmpOAxCKnSLG5EMExyMjnpeRZfireY/GbfhVqNabHCTGxnbmnfaIChuG0w2IX5sQQajQ4zT38xebLS4jl8+YqLR+x3ghRbmlqXREnPsD+YnlqvaQQJufeOMGC2RuWogBUAW4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLnxjKQaBArr5Nd3ORcq3c7/aajX9CExwnaENPuWW94=;
 b=M5DqosxFvO7PbqJ5dMxJ6vmznBXs85vFB2m7WlZyU2T+CnhdhFDNLZGQhmxvnoUwe63q9NNbD7HD86KWdqddiv5qwp53S5NVsgrfhvK8aUHn3+qKhXOmfgn20RihGZoEYxotN9YDCHM3VYCNVoXOeBEfvdm6lDfpV9WTOk92p9AGMnQlcJflxN6Mpnvv9XsRJ4afBp9J0PCwoSKW/BodbCGbZH5/Z/V/kUrHo6CzDn5tb6OYVik61evKtMFs5zM5ep9Mijr0FJO6j2lo0Jhg80XLUiLOyezp20h9J87aeij+5UDwgCIXp6c0xcYXwf5JghuRJ029fpUz9/vWXW7OXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GV1PR08MB7332.eurprd08.prod.outlook.com
 (2603:10a6:150:1f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 09:55:15 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::c946:79b5:94bf:e8c4%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 09:55:15 +0000
Message-ID: <711cd053-df5d-47e5-8562-367c437ad44c@virtuozzo.com>
Date: Fri, 15 Mar 2024 10:55:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blockcommit: Reopen base image as RO after abort
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com
References: <20240130091440.2346274-1-alexander.ivanov@virtuozzo.com>
 <fd599353-5d83-46c7-938f-c5ff30c4b647@virtuozzo.com>
 <c9aa265d-9b3f-4504-a75b-31e08aef5c2f@yandex-team.ru>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <c9aa265d-9b3f-4504-a75b-31e08aef5c2f@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::11) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GV1PR08MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aab126-ec9c-45e0-3fc0-08dc44d60360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gw+Yst972mM3EcrrTcqBmZ8xmy0cAzCutoTdWuZFe9/0N29qxJP8Rkn2fDOrXRmcddih5585yz4SACwAKH6H6jgb1zIy0Iww+8ukUIYcPpf19pnKgAY2Aapdxl+iPn8ggP8NXCvI3ZaL5HTgLl5mBieYeKUzPBoWNkU6yHTYnsjE7o/EKazO07cninfOqP1AyFNj5KNxilYKTUIvXc9p3xfkTzEYLx9ZfoMMBf6VL6WCA0eHfp1HoQpLBMyBNgCj9Tu/Sa9xDGH4WHs8JTl0wZ7TJ7vAblu0GC5caK7M/VXeGSZouwMcHfVA2AnSGer3MUCSl+RSmAvOgOsVawTRcQ6kM3tlyL8OhCUTMLkBhzu9HCtt/YYqZ1SmRz2Eom4kRrqc89TXyWYL4QCQsBSMmS3gZ5/1uNh0vZZvmJ2g2F4wV1KbVX/KtmZn3ASJDArRj3Y+Jxhv0+Ft7o7izU94AMCZ5EWjUXSuF639hJiMYi9FpMDF7RQ5fsoxSUUCLFTswK1rMx0LZRRf6hRc6pgrK73bTP6yvMRFjOHFp6Y6iEeEl2pf4Af2MKJXiJjJnExPpl446LBLbHDq8JraBjfkTJL2tR1rrGaC/Jr1bbRk0jnDjuQgrae8xO80w3lfx+bVidMCkmL42rhUwQAai90ab/+NAdMeTxxynlG8F72f88Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZsTW5Sb01yOGpZTXFiaVRCUG1ucVRPUGlUV3lMSjJvSHFVOUdCbE5obHdh?=
 =?utf-8?B?WHVDa1E4QXZhbWI3ejNRcVdwYi9aNlAySmQrYThlbE1nQnlrYmd5cHpMdW1t?=
 =?utf-8?B?QmtPTkU0QVpuc0hYbjFBY0drdWZCRWRDdnJMd0dUSFZwRzhnMW9RVkw4RkdR?=
 =?utf-8?B?SEQ4aUZtRFN5Yk9wYmpBclpoS2dHQml6NzYxSTJteEl4QXFjMkFlb3EzbmNF?=
 =?utf-8?B?QTJ1aS9wWWhQTnF6cEJrNXh3dDNZQjJNeHRoWE9kUmg0U3c4VEZRWDVkSk5V?=
 =?utf-8?B?RHd3V01qc3dYdWpielI3RnJIVXNrK2FQQXJQcDJ0cSt4U2JDSURZdTU2dkF5?=
 =?utf-8?B?RmZHZUxyeFpsSmkwdlpnQVdyajhBSTZJQXBpRFhUMk8wK05kR1dFYUZoZUV4?=
 =?utf-8?B?djNHVXNnQkVnVERBWUZBaC9aR3FhaUc5TG5PU0NSbldDTHp0ZWRKQVBLRzda?=
 =?utf-8?B?MFhGeVFzZTdBYkdCOXp2b3NPNG5HYU16MDJGWDRrWTh5SDE1WHo4QWJ3UERW?=
 =?utf-8?B?R1U0Y09wRFN3QWpubkpBVTRkcXZsNEthUTAvS05vamNPRnYrbDY5UE9icHYx?=
 =?utf-8?B?MjZFWXJqTXAyUGEwaFhUN1NxalpLYXo1bnJuNG1jMnlYcE8zQW5FWUhyU2Y0?=
 =?utf-8?B?WWR1T0krUDRzQk1aMTFxcmNaa0FvcldGNVJ6QU5uazhDUnE0MkVNWHkwVlhs?=
 =?utf-8?B?dmNnalh6QlgzV2t6aEdNYldOM3hDeWw0bFRKWXEzMTF1M1VwblkzbkNENHhX?=
 =?utf-8?B?VGIzdFhua0ExN2tydFhXcmFFdnFSSlV2S0E5OUlDd1NqU1ZHM0NEUm9iK2R6?=
 =?utf-8?B?aTNDb3VYL293b3ZlR1dJaER1SzdqZWNEcTlCeFJad2ZpS2hDQXBDbkREZHN3?=
 =?utf-8?B?ZFFBcTMwdUJMc0t4dEdvZGFGUUg0L1pYbVZXVWVBRW9ib3JGaGYwbGpIdzBt?=
 =?utf-8?B?YUk4cGF3cnFLK3ZWN2wyRkE4emRXUitxTWFIaFVUdFphQWk4a3c2YjF4QXF2?=
 =?utf-8?B?bFlyUzRMNFpWL2EyRHkya0oxV2tzMjh2TndpYWVoM3R6a0UzcGUydjM1a3d2?=
 =?utf-8?B?dWFRVEwyUkdYU0JzT3dUeEIrck96ZVlQc0lQUis2ZnM0MUd2dGpQTldkVGZ3?=
 =?utf-8?B?QXBwcDNDdjBZZW4rbnRWbEgyU3FpZDZWY0MyeU9pcmN4QzhuNkVueW1BSlZj?=
 =?utf-8?B?aW5DUVhoeENOT0JuNm1HTjZ0a0Q0VlZNT1h1MnJsdktrbWgvNUxDQXF2WEl2?=
 =?utf-8?B?UGsxeGFnditRTGxDTk1DUTE0RlNIc3lVc0JzYUllYUtWRitvOThjN3NrZWJz?=
 =?utf-8?B?WnNLTzk4ZXR2dHFCYkRHNEJQK1MySXZmNzZwNExZNTJOREg3cFBpdVhGZzVp?=
 =?utf-8?B?WnZDOG1kVS80bXFIK0lpcUJwa0xqcVR4ZmVqRExkaU9OdnpjeUcrenR6ZHhY?=
 =?utf-8?B?a2t6T0FDbWdCTFE5b21aZCtVWWlhb3VVMlNxTjJLQUQ0WHBiK2o0a2NrNFFW?=
 =?utf-8?B?b2ZPbzUzSEZGUWppNklURkFHRzB0RXcwZ0NFVndkOU4vbUVjWWVWQ0o1bzFQ?=
 =?utf-8?B?bSt5N3FVRkxSQnJaU3pRQjFzTU00d2dEQnRvazVUWnA2VWxmdGdYa1ZsSm1y?=
 =?utf-8?B?UXdPUVlhZWdrMUFVTjBnelpweDBhQ0RVTUJDYmc2NEFLazVtTW5DQUw1bXJt?=
 =?utf-8?B?TUU3N0g5YUkrYTlUeDBNVm5lRzZkVVJwVU9iOUM5aEpRR0lGcTY4THFsdUZl?=
 =?utf-8?B?NXBBdkt6YUdTeTJlOFRqcnhMaG5HNktFaE4yREpFREtFUm9mN2hOY2FXOG16?=
 =?utf-8?B?T0cwTGJsV1QxcFFrckJmUnQ3U1ptTU5zSkNQMXl6TXJ5QVpnY0VpSnlmVlNH?=
 =?utf-8?B?RVREWTYyUk9jdFI2MHRNbk5hSmp0QUlQaklMSW9renJEUWY1T25jaURiYXRC?=
 =?utf-8?B?Y1JJcGNDS3hadVVIUnI5ZSs4MXhVUytRNWZleEVsb0VTdDlkb2tURnBsQWl1?=
 =?utf-8?B?VTkxMFBOQXVFb3k0VmcwREJGY0xzTGk2Z0JoV3VEb3RUYU1kdHF0TUdiMER3?=
 =?utf-8?B?VGVyYU4wMHo2Y1VJRW5oRjNoRWtoSFozVHRhT0xpTzVreVJPSDJxQi9Ld21R?=
 =?utf-8?B?RXZWSGp4UkhDZFVyYkZnM2NRSjJRaW5FeHVzSVdPdVcxMStiQlJSaktrRWpH?=
 =?utf-8?Q?2XeLxudEVnZ3OdcatyZWI3E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aab126-ec9c-45e0-3fc0-08dc44d60360
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:55:15.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhWGXOjgnbubwOhiqvDimGHoXA8L1BBNzqxsn+Av+rypiF03iStRZ2NvvGs/xjUCobF3d1Z7AuWGMnX1FD0Jc4wS6oFB0yS4tRMIDMsxbdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7332
Received-SPF: pass client-ip=2a01:111:f400:7e1a::70b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/28/24 17:48, Vladimir Sementsov-Ogievskiy wrote:
> On 09.02.24 15:29, Alexander Ivanov wrote:
>> Could you please review the patch?
>
> Sorry for long delay.
>
> Honestly, I don't like refcnt in block-driver. It violate 
> incapsulation, refcnt is interal thing of common block layer. And 
> actually, you can't make any assumptions from value of refcnt, as you 
> don't know which additional parents were created and why, and when 
> they are going unref their children.
Hmmm... Maybe I can just exclude refcnt check from the condition, can't 
I. If BDS will be removed it doesn't matter if we make it RO. What do 
you think?
>
> What was wrong with v2?
My bad, it seems, I didn't send v2 before I decided to change the patch.
>
>>
>> On 1/30/24 10:14, Alexander Ivanov wrote:
>>> If a blockcommit is aborted the base image remains in RW mode, that 
>>> leads
>>> to a fail of subsequent live migration.
>>>
>>> How to reproduce:
>>>    $ virsh snapshot-create-as vm snp1 --disk-only
>>>
>>>    *** write something to the disk inside the guest ***
>>>
>>>    $ virsh blockcommit vm vda --active --shallow && virsh blockjob 
>>> vm vda --abort
>>>    $ lsof /vzt/vm.qcow2
>>>    COMMAND      PID USER   FD   TYPE DEVICE   SIZE/OFF NODE NAME
>>>    qemu-syst 433203 root   45u   REG  253,0 1724776448  133 
>>> /vzt/vm.qcow2
>>>    $ cat /proc/433203/fdinfo/45
>>>    pos:    0
>>>    flags:  02140002 <==== The last 2 means RW mode
>>>
>>> If the base image is in RW mode at the end of blockcommit and was in RO
>>> mode before blockcommit, check if src BDS has refcnt > 1. If so, the 
>>> BDS
>>> will not be removed after blockcommit, and we should make the base 
>>> image
>>> RO. Otherwise check recursively if there is a parent BDS of src BDS and
>>> reopen the base BDS in RO in this case.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>   block/mirror.c | 38 ++++++++++++++++++++++++++++++++++++--
>>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 5145eb53e1..52a7fee75e 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -93,6 +93,7 @@ typedef struct MirrorBlockJob {
>>>       int64_t active_write_bytes_in_flight;
>>>       bool prepared;
>>>       bool in_drain;
>>> +    bool base_ro;
>>>   } MirrorBlockJob;
>>>   typedef struct MirrorBDSOpaque {
>>> @@ -652,6 +653,32 @@ static void coroutine_fn 
>>> mirror_wait_for_all_io(MirrorBlockJob *s)
>>>       }
>>>   }
>>> +/*
>>> + * Check recursively if there is a parent BDS referenced more than
>>> + * min_refcnt times. This argument is needed because at the first
>>> + * call there is a bds referenced in blockcommit.
>>> + */
>>> +static bool bdrv_chain_has_significant_parent(BlockDriverState *bs)
>>> +{
>>> +    BdrvChild *parent;
>>> +    BlockDriverState *parent_bs;
>>> +
>>> +    QLIST_FOREACH(parent, &bs->parents, next) {
>>> +        if (!(parent->klass->parent_is_bds)) {
>>> +            continue;
>>> +        }
>>> +        parent_bs = parent->opaque;
>>> +        if (parent_bs->drv && !parent_bs->drv->is_filter) {
>>> +            return true;
>>> +        }
>>> +        if (bdrv_chain_has_significant_parent(parent_bs)) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   /**
>>>    * mirror_exit_common: handle both abort() and prepare() cases.
>>>    * for .prepare, returns 0 on success and -errno on failure.
>>> @@ -793,6 +820,11 @@ static int mirror_exit_common(Job *job)
>>>       bdrv_drained_end(target_bs);
>>>       bdrv_unref(target_bs);
>>> +    if (s->base_ro && !bdrv_is_read_only(target_bs) &&
>>> +        (src->refcnt > 1 || bdrv_chain_has_significant_parent(src))) {
>>> +        bdrv_reopen_set_read_only(target_bs, true, NULL);
>>> +    }
>>> +
>>>       bs_opaque->job = NULL;
>>>       bdrv_drained_end(src);
>>> @@ -1715,6 +1747,7 @@ static BlockJob *mirror_start_job(
>>>                                bool is_none_mode, BlockDriverState 
>>> *base,
>>>                                bool auto_complete, const char 
>>> *filter_node_name,
>>>                                bool is_mirror, MirrorCopyMode 
>>> copy_mode,
>>> +                             bool base_ro,
>>>                                Error **errp)
>>>   {
>>>       MirrorBlockJob *s;
>>> @@ -1798,6 +1831,7 @@ static BlockJob *mirror_start_job(
>>>       bdrv_unref(mirror_top_bs);
>>>       s->mirror_top_bs = mirror_top_bs;
>>> +    s->base_ro = base_ro;
>>>       /* No resize for the target either; while the mirror is still 
>>> running, a
>>>        * consistent read isn't necessarily possible. We could 
>>> possibly allow
>>> @@ -2027,7 +2061,7 @@ void mirror_start(const char *job_id, 
>>> BlockDriverState *bs,
>>>                        speed, granularity, buf_size, backing_mode, 
>>> zero_target,
>>>                        on_source_error, on_target_error, unmap, 
>>> NULL, NULL,
>>>                        &mirror_job_driver, is_none_mode, base, false,
>>> -                     filter_node_name, true, copy_mode, errp);
>>> +                     filter_node_name, true, copy_mode, false, errp);
>>>   }
>>>   BlockJob *commit_active_start(const char *job_id, BlockDriverState 
>>> *bs,
>>> @@ -2056,7 +2090,7 @@ BlockJob *commit_active_start(const char 
>>> *job_id, BlockDriverState *bs,
>>>                        on_error, on_error, true, cb, opaque,
>>>                        &commit_active_job_driver, false, base, 
>>> auto_complete,
>>>                        filter_node_name, false, 
>>> MIRROR_COPY_MODE_BACKGROUND,
>>> -                     errp);
>>> +                     base_read_only, errp);
>>>       if (!job) {
>>>           goto error_restore_flags;
>>>       }
>>
>

-- 
Best regards,
Alexander Ivanov


