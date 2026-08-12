Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDEDC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuA2g-0007oY-JP; Wed, 12 Aug 2026 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuA2f-0007o1-3U; Wed, 12 Aug 2026 10:34:53 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wuA2c-0001ic-Vt; Wed, 12 Aug 2026 10:34:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6lFVOXN2sbpXFVQBXx+G4pjQ9ZDLgV0sl7+v088648T07zIrtyWPTxoCaGhOwZwaRJSu5qq+77xfMJbSdddaqS7N5JNyGMF4qOZ/R6GuoGX/nvlPcGr3PTTgvVsiXAKGJlCaEzxCKcJOOrGOGt/iRYy71DSwew2VrENw+gzW8ObtJwybUBHVoRORptq8LLqn1+SqzHj97U+jd6zhJFTtUvot/aVaCOGJlsemhi2RN/lC2YPv/3foa55WFpPjdBrzeVecbyCHtZmKHjJzM3/pcFmL4rUMoc24mqIhf0+dkwVsO+bWHidlX7+GPpp1WkOOmwe9RNC5L2TCNwEVCjHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gckJSZWBbXEzIJJOvsaJBkzZpeXcDLZOdFGFar2O4js=;
 b=t11ZoQjiYVvN2tJH39GfNBtbViPRHi7q3mnZJ5GWJmmYDQ0RinQdxX94LuK2yctBo96+D97UOKQecnGGOf/DPybxC9jEoTCa7LSkm3NJ+ooNwsQcc8S58YykQK8sNWlplPdjYpXErraZ/v2d+O/nOaBXwBTfzG5VxOZvY0iWjeoUpv6psFUHw2dm8hHekntfRnz1vCfpeUQ7vWHACmv8RwZxYPXbmRd69DArtYSSm2wHG6fveSL0LMC3EeaFgVmYajXE8WkBL2h00hDrpvrSqOH0jiI1ilwbM3i+MwxSFW8uVDoEGrwFZPcxen/xc75qZdPLG+yS4MZU2SIn5+jJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gckJSZWBbXEzIJJOvsaJBkzZpeXcDLZOdFGFar2O4js=;
 b=CpNAQGl0sIg6eibBcr8RpPNVM7XZmHJFqJGPccGphADG20kDNAQDfnJ8oLxTur2uBzSbydJDsEUsaWl7UPbsa9hI8V7SKjJ0PKTYF2WHm6q1YVIuJWIxpLi3htZrmODWoM8KZn9L3ASRKZ3oFfw0+nbq60TmvhCG1GtnKEFtVEcGVVxPUguxwp2IdgHOfCY8/nwb603lYzCr5pXSL6vkCtkISwPUAjBnDoszvBbr2JUECU4N/bsRmmHJl18SFIIw/6bnVVdGtm3cU0neltangdEQMRyRims48g5WHWqwSkPigVV26A+km6ffaHWBj5OD/Ii+HfFnwVrr5JnNPT03pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by ZR6PR08MB397649.eurprd08.prod.outlook.com (2603:10a6:910:da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 14:34:46 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 14:34:46 +0000
Message-ID: <37b06e38-1fe7-42b0-91bf-6e048046e20e@virtuozzo.com>
Date: Wed, 12 Aug 2026 16:34:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/7] IDE patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260804170015.3128363-1-den@openvz.org>
 <20260805005513.GA582272@fedora>
 <72361406-f846-42ac-a3bf-a09985794bf1@virtuozzo.com>
 <20260812143254.GD244786@fedora>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812143254.GD244786@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0095.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::15) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|ZR6PR08MB397649:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f7a54b-fe67-4508-798f-08def87edb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|10070799003|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: vEdv0VRTwF8P1Fv+yp0iW5JKRxYuvWIyCpzRjd0rxhs8mpxBamA54vmKCCftzAGtBL5VmJKXqAJpmOxfzdBPwi8EZtQ2dpAeV4hjinvNj60WrVnoBerX7yIdXNWizyY/RJ8YucMm/Y9Sd1+LhtfyVNT55PPjB6VvdHiMc7pQLjtfCwLrNgTFckMJNQZE3VRhIRC6Gpu863fYlR2Fg/16CI99ZsDMKpK0QPpmB6maW8xYrIsxsKTDsvUVDZvlWIV4te4byYxkZd6zCFxrRea0cptZTEujRgWR7fxG87MvJ3Djoh85sPkuurtUl92F4dZSacjNNhQwL12eI9oYdfw1ZahH+cgaKKJev9FEFnY8c9XUcdAG9RnkIyfaHCWad3ykFo1Uy9/dxCYzOVTYuaVlphuWTNyqHTRDUVkETK6myS9nsTHJxlNOA4oJx2vvEVhkJ6Qtkm+iUIrQgtIahVAJbN2mR2pK494pbomKsBk0KWlOLtDUzvFigVm8EIT9mXpdPXK3BLkOcgt39O+iwUmuhT56mqdIZlIlYRQlo0wjhwDVKLSVwHZfWVhFVy22ZQTRmTVVq9I9EphX6k2SPHAukdJh4XHXZenYckQL6jSiLzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFmU2kzMDJmVkZRd2pFTnVMOFR1bFoyc3FzcVpzNmJBQlV1eWhLRGVDdVhq?=
 =?utf-8?B?SmkxaHJqaUZXanNERG1JZUcvVmE2cGplQUpvVWxya1hnWjNyUTlneHVCdy9P?=
 =?utf-8?B?TTVPVDJGUTYxV0l0aVkrQ3FSQlRxaGdGb3d2TUZLSVdLdSsvQ3ZYbGwycjdT?=
 =?utf-8?B?eFJZemV6Y3M3bTFkcm1HTGN1SmV0Vm1qdC9OWm85eW5EVDk5T2w4d0ZxcXlo?=
 =?utf-8?B?Qm4vVFhjdGIxMkZNSFEwcUxaUDUyUjFpd1ZuN1d3V3pzaVJJdGRabW1rb3d6?=
 =?utf-8?B?TTIrSlEvSEw3RHdOV0F6VERtbDVxWDVOMjhMVTB3ajNmRmlDdDhQRnhCY2I3?=
 =?utf-8?B?cktONmZVNkZkaitDUXQ1MWdpREdiVnhyOUNUUnd0UUNhZnJmdzk3bGNDc3k5?=
 =?utf-8?B?ck1nTzFPSUYrN0gwKzRwdXhFWjQwUHRBaXVVbHZjTms4YUxuUjNuZGpaUG9q?=
 =?utf-8?B?ZTBXamRadTVSKzJVcHBhaTg1S0VSWW83NTVLMDBZQTIvNHdmRDRZeVkwSlVY?=
 =?utf-8?B?RTUzdXUzZzRING5mUmx4aUlUclZyQXN1L2lSSTdHVm1hOUt5QmU5cVVROHJs?=
 =?utf-8?B?QmpSZ1k3ME1ibzRKNk5zSVlYeTNlOTNyL2NHN3NnQVkrVjl6ZzRzR09uUnV5?=
 =?utf-8?B?VEFVeDRUdGttZVlQV0lZN2pMQUJoZ2RueUlISXQvRXVEZWt3ajI4UGFQWmN3?=
 =?utf-8?B?TlgzWXd1TWRRTityOWVhS3R3Q0ZkS2FoZkZkbEtrNUJwalRuV2pYYkFGTFNC?=
 =?utf-8?B?N3NVYUE5SnN0K0t0SjE2YUlVVU1qSTFuVEFESzh5M29Cc2lGSWUzUnc1TjJ4?=
 =?utf-8?B?cm41am1zZGxlNnlnL0dwMmRpMEVpUkFxTHU0OFJLR3VKVnVoSmlZNVlFVTBL?=
 =?utf-8?B?cHhCbHhWN2lJbkpZV1VNMFJjSGlodWMxWHRQaTZEWXNtNFRjS3R4cWFQSjFZ?=
 =?utf-8?B?OWQweHk3MlQvSTIzTHpKQ01TekNqdEswOEJ5RmRhZ0VyK2Y2aCtQajVVb29C?=
 =?utf-8?B?VjNLd3BxbUk0YnpXcWI2Ukd6ZXkyekc1SUpqNkJFdmorRHFocHpEVFIwckM1?=
 =?utf-8?B?WERBZWFaOVRlVzhsVlRDdHl2cHJXUGdpcmdDRTdDcHFWSUtvRkdNZ1lPUE9U?=
 =?utf-8?B?b1JsQVBlMUtFNVJjWUxScFF4ZUJlcEhiZGxvM00rMXo4Um5HZzN4N3RXbUh5?=
 =?utf-8?B?dUhJRVJmVVd2WFNBeFdQeTBrclZLU1IzZE90VkJINVhkRHRhcTJpaitRT2pu?=
 =?utf-8?B?V3ZSSnVqMTkwSGtxVlFNUUg3bDlSWmZJK2NsMVV2NkdydDVTS2VDN2QyaVdL?=
 =?utf-8?B?V0pVVzRaWStWUDQ5L0ZMWk9aTE1FRUoyeThCVmRqb0xoQWs2b2Q4UWp1VU1N?=
 =?utf-8?B?NUF4L0lqOFB1amtFRmlzdEk2WWVZSnFMZEg1c05uTDQ0WkxSeUdBcmdCTzVE?=
 =?utf-8?B?R0piR0xzMEtPY0hTVmQ0RkgvR2xqdGkrS2xsemJoNXFqVmMxTzdNZHRZbGRy?=
 =?utf-8?B?dDlIaWtvT0YyZ29uTk5Yc2tYRE51RUJxdzNOVVRicFQ3NTVKWnVkdTl4RDRB?=
 =?utf-8?B?R2RCZDgvTlJZb3dobmhCZUthS2htMlJVOEdkaC9tVGFDZXlSYWtIOHBobFIy?=
 =?utf-8?B?Wm5QaG0xZ09sY0VCTzZsVm5CSE5adGhNTVVYQkJscG1MSmNYU2c2NlNOVjZR?=
 =?utf-8?B?YldPclFBQUsyNHZuU2hzSzdoMVNycnhSQ1F6YU1yT21Xc1RkV2F5S3p0SEt6?=
 =?utf-8?B?S1NjU3N3eVhoRy9JV3BVaS9kOTQ5b0kwWlo3SlZ1VnJ3UnVWQXVNZTRVRTJM?=
 =?utf-8?B?V29rL21EVmx2d2x3VmMwbGk3azg3cER5a3VUa0ZtQWtDNTFydk5WNHhwWVVW?=
 =?utf-8?B?VjRkYXJET2JPSzJ4N2x2OFdXVG9aU3Evc3ZzSDNHcXAyd21kd09Uck5CTnJn?=
 =?utf-8?B?MG1ZYWRpdDcyRlIwcjgvbTBHK2pNUWF0OE4rSXBMN2NzL1hIT0FyOGdaeTFm?=
 =?utf-8?B?clU5Q1AyOU9tajRPVlMzc2dlUUhpQSsvRFh1VndRbGlnME05SC8zQW9DYVdQ?=
 =?utf-8?B?c2kxYXhROC9mMDg3dXNxRWFaMTlKT3JKWWQrWW1oRGw0K2JsYlI5a2EwU2pz?=
 =?utf-8?B?MG85dVZMQlQ1ZU1UNGE1bTVzVy9Ja2Z0MzhBN25HM1BEMWJZSTloRWZFRkZ0?=
 =?utf-8?B?ZHIxL2lTNU51eFA0N1k2dlZaaGcwVElQY1NtTWtjcnVTV25KVnFvT2kxY01p?=
 =?utf-8?B?ZEJGazZ5UzBOVDBXakpZKysvSXVmU0VtajZWVVVSd1pCSDFvVk14MWUrSWdO?=
 =?utf-8?B?cWlNMEEySzJkT3orRExxUGYvbXdGQW5zM2djbmx3OW1UMDVZdWpnOW9PU0Fo?=
 =?utf-8?Q?7igxy0+f0W1a3RpMnfql4fhyW8txNyh6VK5HGsALGD5Yp?=
X-MS-Exchange-AntiSpam-MessageData-1: ZLS2iPUsMfu0zg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f7a54b-fe67-4508-798f-08def87edb62
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 14:34:46.4599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1CI5xUINhOwfyJQ9hTAgncgCfcg0XLBkICCT8x/Xie6QXqlntEcf55e7NzbFFQZShIoBqxMT+xTB5M2lwHacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB397649
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
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

On 8/12/26 16:32, Stefan Hajnoczi wrote:
> On Wed, Aug 12, 2026 at 02:48:45PM +0200, Denis V. Lunev wrote:
>> On 8/5/26 02:55, Stefan Hajnoczi wrote:
>>> Applied, thanks.
>>>
>>> Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.
>> Hi, Stefan!
>>
>> It is kinda strange but I do not see this series neither
>> in master, no in staging today.
>>
>> The head for me is
>>
>> commit e8d693e12af9cbb89d724baadfcc08559669e279 (upstream/staging,
>> upstream/master, upstream/HEAD)
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Tue Aug 11 14:31:44 2026 -0400
>>
>> I see only this patch merged:
>>
>> athena ~/src/qemu $ git log --author openvz.org hw/ide/
>> commit d9f78431d8ebdc2d03ad74461138c1c9eb076aa5
>> Author: Denis V. Lunev <den@openvz.org>
>> Date:   Fri Jun 19 13:21:49 2026 +0200
>>
>>     hw/ide/ahci: cancel in-flight buffered reads on command engine restart
>>
>> Does something missed/goes wrong?
> I see the same thing. Sorry, I must have messed up when building the
> staging tree and dropped your series.
>
> Richard Henderson is handling qemu.git pull requests for the 11.2
> release and I've asked him to merge your series.
>
> Stefan
Thanks a lot!

Den

