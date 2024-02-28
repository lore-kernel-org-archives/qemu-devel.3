Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944D3C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 10:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHAL-00062c-M6; Wed, 28 Feb 2024 05:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfHAJ-0005xr-KL
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 05:27:55 -0500
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rfHAG-0004Dx-7T
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 05:27:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ppt8pLLccLFc0shhRDhClPrmvLdtpPAypSZD/TvATkFsD/2am8rLhlfYjPWAHxEniqbXdlLYq7iwFCVfU1N9W1//Er67lxY/qXlAGW+l4envTK3siQFWDxG5v6gBAJ42Yj/LmiWIS9pmFzBVH3u9T9kuhDc7Sgq912Nb8aGwdROAV8VWWuvHjm4j3dg8JbGaNlwkTagKr19dOI6zp6SyTve7Q+A1Z9qUew3rqlbTS7704mXeZ3POLsfbbEbzCft30dYhJUEgFNU1mdVPnONjqCe9kUhH6C65KRphJgLpTqB8/bW1VII6oJaPTwHCHKsAGVo9fNt0DobhO1eI0bm/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57TxMyJvb4GtlTywQzLAsooWcp2PJM7WObr3Sqxnn1w=;
 b=Hi/Dn6wsc4xlj8tq/3ezcTgEj684xi0MU0N+65sMFXympEn8IZz8kK/WK9VXZf1MkQzvmgxu4zDIM3adOHzbs4U7chaUg6Jg5XZZHdoWtG4k4hrdDEySHJIPe685Fh/HmGlEgyqkgA4QxblkdZOJB4zXpVofnvQkfkpmQV2yHfZf0nx7gtdhFqJ0Y3Y+e7Vpxg78JIBfddZBpMZQowCveoL0B9Wp69IIJLbGYfy3bI6Fagri0E/rRHk/hH9bLAu9TlpAiqqS8xlYICeqs+fIu/EW2gXshIzfPlcJfJECNBPXQb3Z+J7ElSxsD7Jh9cVUSqpPRjzYH91FCLRNUsdUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57TxMyJvb4GtlTywQzLAsooWcp2PJM7WObr3Sqxnn1w=;
 b=Ysq4FvVqjEOgbTL+4sEjJ/JNsbNSGoXBi8OcinK12OId39scv7sX71N+n4w4wxf1om6C/2WcyDK9lV/q+9IYRt21D+DhasKGuwJeuPrDORcu0UULjc3xvMGefQP/AtmAwmVxpXGnLbDkbO7FWl2yUt9yKKU0PprmHEQ6UhXMYqROkALiwD9LdEFjtdT9kKQ9ndQSBGmhzWSAbEJKCJNZSUEhYDaL7CzfcKWZ5dUuoABfMpDhN6VstG3e9p+/XY7VYy2lmB+gJAh5VKS96IDE769emJ+q5KrWuuFVNTWgBRdEq+G15pNW4H43Nb0tE0SnMFrvhSehUmFjZR+uRXY8xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 10:27:45 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::9994:4366:f59c:c903%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 10:27:45 +0000
Message-ID: <dec8b4a6-3bbc-4db7-aabf-7c85c43b47d5@nvidia.com>
Date: Wed, 28 Feb 2024 12:27:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20240222155627.14563-1-avihaih@nvidia.com> <Zd2SPGPVhW80b1Hu@x1n>
 <f7fb1999-4400-446b-812d-184fa502627f@nvidia.com>
 <Zd6iw9dBhW6wKNxx@x1n>
 <f882db98-10e3-4c95-9ff9-1ab9a0c145ba@nvidia.com> <Zd8IUJErmhDYIiXR@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zd8IUJErmhDYIiXR@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::21) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae2309b-4da0-4cea-be37-08dc3847e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEGvQMssfa2CrBXP4FScp/n3NuztkMqsc2Cc6j4yOjiKDnLCyoLzSS+LIVt0GRLFHGD6KDGP53kDYpp+lGPTQfj01k4YXckxNGIm35OIzemo4FjKvPUvZjH/bJ8T3OxKRVAsbRa3AeG+FtaPoL6dOECiarXN/loe3lQD+sjRARFkkXAAZb4/HvZFM9J/U1V9t46aXH4D58c8aroYJPOI5oRmL05UpUlU79ldnuGF9+2yByFNrQJjqx2ydPHxFzppx7UEpEFJ+tcnAfMvP+nrpqAB/hoQjUCE0M7sKRRG47w+3HAXCrCMELnNFpCCNPzBl5faew7TF79hlpYh1IV0SK7mDxms70xB2Wyz2vp4ncDOpqc0P12a0p1Uyxgmqz5klX5BQL9dRrJ+tq+Je1cEHCqKctY1lU5n/1u1DiXfb17SlaXOOSBGccGdabHJvrLqC8QULJNM9U9OK9VoZ11/nedPnbHMn1xqgWmlMWmiFZYPDPGx8xzgz5YUIf3ZjwCg1cNYUtyfBRmprFBG7B07Cae/t/aJrcDWCHlXWrpF61RGSQ5mesPrf3CL1x9kER3Z2voMNRsp53ntfD7rfTJ+MDgiJ0hrb6xu5H9/YRzeBxAM5wBJF555nwfni65+UXlj6nW3EPcfSAoDqRjiUBQFpa6uATENs7BPzU3LBS0m82s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNzRjJoV2dOVEFISjk5ZVBlbG1sdDhvNEhGK3FCQURRUWpGQXhOc3VQRmVU?=
 =?utf-8?B?QkVndzdObStxR05lbTY3Q0xzU2tVVFdNYzFoV3NhU3RTbVpQYmt4MFJ4WXQ0?=
 =?utf-8?B?cmF5SmFLUEVVZ25WVlFnNDZrbjNYS1cya0NHSGtlTnE2ZUdYRnF5RHNqcGo3?=
 =?utf-8?B?a29qeTlOdVR0ZDY1Ujl0eGhsWDh3L092T29kbGZOSGN4aFV1UmRIKzZ5d21Q?=
 =?utf-8?B?c2c0bDM1amszbEtmRUNsL0g2aG5uSXdaYnkrRjREbmFyU3JWV2EyVzQ1T0ZR?=
 =?utf-8?B?L1JTRWdvdmpSZlBwVVBLdmxDNXIwRVMvRWlmYTFMdFAzRU03U0NWdDRwVk9i?=
 =?utf-8?B?ZDlIWno3c3ZDeE1YSVpsTnJJZVZKeUdBTWF5bVZTTS85WndkK0FncEl5aGpM?=
 =?utf-8?B?WEREUlU5dVZHUDFkNlRoOFVDdUtGTFRtOXVFcmxnaGQwbUdYNXR2KzNacnZS?=
 =?utf-8?B?N2s0M2RHdjJTZVJYVHYwYk5VZEhkQ2paTTF2YWpSNDNicW9HRnhkU0ZhNUZx?=
 =?utf-8?B?eEM0STJaR2FadU1oOHdLWU5RZjdzN0YxeitpWnN3ZVBTM0ErbndnTFYySWZz?=
 =?utf-8?B?bmV2NFZ6TCtuK0orU0xJeTZQTTJEM3lpRVAvL0U4OHlnNmlzQVBTU2dpTWNM?=
 =?utf-8?B?OUw0S1VyOFphZmhja0RMeHZUVG9QY1FCZXBYb1U1VjY1WGNMMHNLU0laaXU2?=
 =?utf-8?B?Z2tYRUJpUy9nL3krZ3lTT3kzbG1zRlZTOXNBdUsvekYreUZML3M2RURmVk1m?=
 =?utf-8?B?ZUZWaGJhS1Y0bGVtSzJjREFuOW9iZ3drSnRFRFV1OWhxd0JNVTlOME1nSkx4?=
 =?utf-8?B?cFBJOTBDVnh5V25HT0QwcnNjd29IVitwczJaOFNET1R6d0g5V0RQMkdlcFpZ?=
 =?utf-8?B?Wi9zZ2YrREVVZVErSENqUlg0NTBDanNRcFBrOGhWMitnNEp3WGJaZ3lyR3Nt?=
 =?utf-8?B?bkloMGlXK0pBYXNwNzZab2lZSjhhV0tIdjF3Z3VFMUdObW9KbFgvT3pEa2Nn?=
 =?utf-8?B?dllVSmpNY0pBM3pKWVMweXM1WDcxejA5OG5rRDNaR0hNNEdXVDdaK0JQcmg2?=
 =?utf-8?B?U2d6U1Q0bUZPOWdtTkVZTVhQeURxTWt2bFJBejN6TW9lblM0bENmallpbUs4?=
 =?utf-8?B?bWFzanNBVzI3MjFNNWxSd2IxaHhSVnJXeUxsdzlyODFpSGNGRGFqaHFZK0Mr?=
 =?utf-8?B?eWFIRVpoTXdBNVR5K1BCdUg1KzZFUlg1czN1MldqMDdnK2F3RUc0K2NnaHFi?=
 =?utf-8?B?bFpmVGxBanFoVjhXWlpCdURTZS9NTnp6c0VjeXlvdFpTSlpQTWRoNGF1VXUr?=
 =?utf-8?B?QkF2alBpczRRYXFTN1F6MHdYMVZHSmw3cTJybEoxdVVQRjJJZ1dyMGFZYTVJ?=
 =?utf-8?B?MW9TaXd4Vm82cVpYbWExVHhseVFVNTNWbWpvUVFaN1Jia3JYSTVIUzlNYXFP?=
 =?utf-8?B?U21UMys5SjRQZHRMdmlnNGdDdHVMOTV1c1h6bldLS05YSXJQVlVTc1RSNVNE?=
 =?utf-8?B?b0tIdjZsL0diV2QvMFJMOXVyemVzZ3FOUkdncnFtaTJFQThVR1JBQUhUNWJy?=
 =?utf-8?B?cEZseDhQb0Fjb1JIb0RXWHpLMXN6Y1dBaXo1RWxHb0Q3eVZmY1dITlVVT01h?=
 =?utf-8?B?WTczQ1d3STRXbDhoTDJPM3JHczhmRFZsYlU3MmpoL2cwTEpkMFg2Qm5QRjlN?=
 =?utf-8?B?YWRyd2tOa2JyU29XYTIrNzRISzBEcWNIVDIzejdDTnJnNkZOWEJhMnpYeHFo?=
 =?utf-8?B?WHdMV3pBRW9pdmJYUXQzRTN0VFg3aTh5dXdpcjJ6bDJESEp1L3VxSjNnSUha?=
 =?utf-8?B?b3hURHJpMTE5U2h5TTBuMUdGUVpuUitwT3ZvUXR2NEZocGVSd3Faa1RrSldq?=
 =?utf-8?B?aStZaVpFL0hVYUFlMlc1Qk52cGplanhBOTRrS1lVMmhaWDNIOUpka1ZHYkc4?=
 =?utf-8?B?My90MmFSckFaSDdIUWVienZVVFp5V2E1ZFFKMC9FOUFQdzBhNHlsa3BhUFFj?=
 =?utf-8?B?czFpNXBkaU54RTJmVG1RSVk0ZGNISGdTOVVweGtOdzR4SHdHeHNydE5mVE9M?=
 =?utf-8?B?L2haTlRPZFN1b2lTV28zc3pRL2VPdDk0a2tBVUVMc3A5QjBweHd4Uk5jM1Rr?=
 =?utf-8?Q?otWNZj8cQGIT2AJ1btGmgWbda?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae2309b-4da0-4cea-be37-08dc3847e741
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 10:27:45.6180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OeVID4tdaFme5ogs6MLpdyRxmYrQarV4g5uCll20pOgpq6+7gnA4LvuHHn/nSXOzhiY+MGjlJk2J3m8vp7nlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
Received-SPF: softfail client-ip=2a01:111:f403:2412::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 28/02/2024 12:17, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 28, 2024 at 11:39:52AM +0200, Avihai Horon wrote:
>> On 28/02/2024 5:04, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Feb 28, 2024 at 02:00:26AM +0200, Avihai Horon wrote:
>>>> On 27/02/2024 9:41, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
>>>>>> Currently, migration code serializes device data sending during pre-copy
>>>>>> iterative phase. As noted in the code comment, this is done to prevent
>>>>>> faster changing device from sending its data over and over.
>>>>> Frankly speaking I don't understand the rational behind 90697be889 ("live
>>>>> migration: Serialize vmstate saving in stage 2").  I don't even think I
>>>>> noticed this logic before even if I worked on migration for a few years...
>>>>>
>>>>> I was thinking all devices should always get its chance to run for some
>>>>> period during iterations.  Do you know the reasoning behind?  And I must
>>>>> confess I also know little on block migration, which seems to be relevant
>>>>> to this change.  Anyway, I also copy Jan just in case he'll be able to chim
>>>>> in.
>>>> I am not 100% sure either, but I can guess:
>>>> This commit is pretty old (dates to 2009), so maybe back then the only
>>>> iterative devices were block devices and RAM.
>>>> Block devices didn't change as fast as RAM (and were probably much bigger
>>>> than RAM), so it made sense to send them first and only then send RAM, which
>>>> changed constantly.
>>> Makes sense.  For some reason I read it the other way round previously.
>>>
>>>>> If there is a fast changing device, even if we don't proceed with other
>>>>> device iterators and we stick with the current one, assuming it can finally
>>>>> finish dumping all data, but then we'll proceed with other devices and the
>>>>> fast changing device can again accumulate dirty information?
>>>> I guess this logic only makes sense for the case where we only have block
>>>> devices and a RAM device, because the block devices wouldn't change that
>>>> much?
>>>>
>>>>>> However, with switchover-ack capability enabled, this behavior can be
>>>>>> problematic and may prevent migration from converging. The problem lies
>>>>>> in the fact that an earlier device may never finish sending its data and
>>>>>> thus block other devices from sending theirs.
>>>>> Yes, this is a problem.
>>>>>
>>>>>> This bug was observed in several VFIO migration scenarios where some
>>>>>> workload on the VM prevented RAM from ever reaching a hard zero, not
>>>>>> allowing VFIO initial pre-copy data to be sent, and thus destination
>>>>>> could not ack switchover. Note that the same scenario, but without
>>>>>> switchover-ack, would converge.
>>>>>>
>>>>>> Fix it by not serializing device data sending during pre-copy iterative
>>>>>> phase if switchover was not acked yet.
>>>>> I am still not fully convinced that it's even legal that one device can
>>>>> consume all iterator's bandwidth, ignoring the rest..  Though again it's
>>>>> not about this patch, but about commit 90697be889.
>>>> Yes, I agree. As I wrote above, maybe this was valid back then when the only
>>>> iterative devices were block and RAM.
>>>>
>>>>> I'm thinking whether we should allow each device to have its own portion of
>>>>> chance to push data for each call to qemu_savevm_state_iterate(),
>>>>> irrelevant of vfio's switchover-ack capability.
>>>> I wasn't sure for 100% why we have this logic in the first place, so I wrote
>>>> my patch as little invasive as possible, keeping migration behavior as is
>>>> (except for switchover-ack).
>>>> But I tend to agree with you for three reasons:
>>>>
>>>> 1. I think block migration is deprecated (see commits 66db46ca83b8,
>>>> 40101f320d6b and 8846b5bfca76).
>>>> Instead, users are instructed to use blockdev-mirror and co. [1]. If I'm not
>>>> mistaken, this operates using a different infrastructure than migration.
>>>> So this logic is not relevant anymore.
>>>>
>>>> 2. As you pointed out earlier, the fast changing device can accumulate dirty
>>>> data over and over. VFIO devices come after RAM, so this logic doesn't
>>>> achieve its goal in this case (we may sync fast changing RAM over and over).
>>>>
>>>> 3. My fix in this patch won't solve a similar problem that could happen,
>>>> where a VFIO device with a lot of pre-copy data (not necessarily initial
>>>> data) may never be able to send it, thus not realizing the full potential of
>>>> pre-copy for VFIO.
>>>> (I personally have not encountered this problem yet, but maybe it can happen
>>>> with a vGPU).
>>> Thanks for a summary.
>>>
>>>> If you agree, I can send a v2 that simply removes this logic and gives every
>>>> device an equal chance to send its data (like Joao showed) with some
>>>> explanation why we do it.
>>> Let's see whether others have an opinion, but to me I think we can give it
>>> a shot.  In that case we can "break" in the previous "ret < 0" check
>>> already.
>> Sure.
>> So I will wait some more and may send v2 next week, if no special feedback
>> is received.
>>
>>> One more thing to mention is then I think we need to calculate the case of
>>> "all iterators returned 1" (aka, "all completes") scenario.  With the old
>>> check it is guaranteed if the loop iterates over all iterators then all
>>> iterators have completed.  Now we allow ret==0 to keep iterating, then the
>>> check needs to be done explicitly.
>>>
>>> In general, it could be something like:
>>>
>>>     all_done = 1;
>>>     loop {
>>>       ...
>>>       ret = se->ops->save_live_iterate(f, se->opaque);
>>>       if (ret < 0) {
>>>         /* error handling.. */
>>>         ...
>>>         break;
>>>       } else if (ret == 0) {
>>>         all_done = 0;
>>>       }
>>>     }
>>>     return all_done;
>> Yes, this looks good.
>>
>>>> We could also give RAM precedence over other devices only during the first
>>>> iteration of sending RAM (i.e., only until first dirty sync), but I don't
>>>> know how much benefit this would give.
>>> That sounds a bit tricky.  We can leave that for later until justified to
>>> be anything useful.
>> I agree.
>>
>>> Now when I checked VFIO code I found that VFIO still may have two issues:
>>>
>>> ====
>>> 1) VFIO doesn't yet respect migration_rate_exceeded()
>>>
>>> That's the knob we use to limit send throughput when user specified the bw
>>> to be something not zero, then throttling will apply.  Currently it seems
>>> VFIO always sends limited data per iteration - a little bit more than
>>> 1MB-ish?
>> Correct.
>>
>>>     I'm mostly only looking at VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE,
>>> which seems fine, because in qemu_savevm_state_iterate() there's one more
>>> migration_rate_exceeded() check anyway:
>>>
>>>           if (migration_rate_exceeded(f)) {
>>>               return 0;
>>>           }
>>>
>>> However it may be good that VFIO will also use migration_rate_exceeded()
>>> inside the iterator (before we can have some better way to do throttling..).
>> You mean that you want to add a migration_rate_exceeded() check inside
>> vfio_save_iterate() before we send any data?
>> E.g.:
>>
>> static int vfio_save_iterate(QEMUFile *f, void *opaque)
>> {
>>      VFIODevice *vbasedev = opaque;
>>      VFIOMigration *migration = vbasedev->migration;
>>      ssize_t data_size;
>>
>> +   if (migration_rate_exceeded()) {
>> +       // return early
>> +   }
>>
>>      data_size = vfio_save_block(f, migration);
>>      if (data_size < 0) {
>>          return data_size;
>>      }
>>
>> Or check migration_rate_exceeded() not only here, but also during sending of
>> the 1MB buffer (inside vfio_save_block())?
>>
>> Either way, I think this would only complicate things for no real benefit:
>> even if we do exceed BW, it would only be by 1MB max, and IMHO this
>> shouldn't make any real difference.
> So far with the ~1MB guard it shouldn't matter a huge deal indeed.  But
> please keep that in mind in case in the future VFIO can iterate much more
> than that, because the current 1MB limitation came from nowhere, afaict..
> so I won't be surprised either if someday someone thinks it's a good idea
> to send more than that, keep ignoring migration_rate_exceeded().
>
> If you think worthwhile, maybe we can add a comment in vfio_save_iterate()
> explaining why migration_rate_exceeded() is not necessary so far, so that
> anyone in the future will be aware of its existance.

Of course, I will add it.

Thanks.


