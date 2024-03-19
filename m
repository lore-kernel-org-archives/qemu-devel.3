Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1601BC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeO3-0000Hh-Rm; Tue, 19 Mar 2024 14:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmeO2-0000HG-69
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:40:34 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmeNw-0005sL-52
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:40:33 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JI7xHi008831; Tue, 19 Mar 2024 11:40:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=XAhY106BvYhd
 zx83ufyHFROmbQzuYlHqcCA/273YyMI=; b=GpNlfRhwnm6epErOzbf3BPLW1ZPQ
 WkQsVsO5X/ffiPGkhDv07xJ18+9fjwMTuUONcHl7jU6wb9TJDBqA19kP24Qp2azt
 qV/Jj+wLCGV2tMHbN9msWHhwOaDuYQYW8p9E8j9e5jurJb8z5HK1vFDliduSuy6v
 jM8za5Xd6xPjMfpfa1NB1Toe7utsGurpDF6ilkWKGsp/B7iDkjCxTeSe9ncobCrd
 2dVilYP18BcTt6IDMq3eVfvg0ybwNozSsPcvgun5Ve6h1Yox6QB+uYXaywW8D2Ph
 WLcTKCsxztzvkqc7VRkp7JVZLUFkYEUjmp67FZnsYJTgBvjs7vCZ1k7Lig==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wwayy6mqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 11:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+pgpfSsTmYdWfijJXEjqK9CLaKnc4vrjPQytexIxlOO10W0RLR3FYmGhptviorxvrnvsmvof+Ebf3LdoJt4NVzZs9rVwEz6dWSuGdY0SWseVnidQhcGS4j2mDimNZfFXirge0OdXyJdcNqgckplzTwYl96ev4I5N0OXvBy0xlQiYEv6ZhoqnIqBi6iyspDC5AYcu/wcb6G83KMZmXNEqQ93sE4HdX3ESN5jb9Vc0+idA1ny+Y6fR4azqSGM2fxw3VlAEGJHnbqpsnDrK5qogUql27Qi/ElOBX/RWDS37byDLi4KbYOhljhVe7gXlz9lHJGtghliKQtwHwAOEB/Vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAhY106BvYhdzx83ufyHFROmbQzuYlHqcCA/273YyMI=;
 b=B3rEk0CzBz11/64gZDavGBxEH5vtQGEVYNBrnE1pmZ43cMOos3BXuOlzxMtRlJMraMm0ReeuVVsWTOzKc+7pMHbTCemsJiiHBOmJvzF9PzP2/+YY9hjycN0o7rs5nW3kZRb8wrAf54fyqwP6YuQ3iv5RdZlsj2vFnEfmAK2mguSoHwwdgE1MzCiuYJ1yGHbJqWyklYkN/OxnHV/js3KCHkMQn950VPBKnpT/Ga0KJIz54qlUv08ylZR25NK0zh7XaD5f15FE+FTF/FJ5TOdZi/JJrj/Wxgs5ln4Ra8vHyZZ+jly/wkCxueqPTCuoGZ1qbqrwsEbSNVC0yCzlMoJgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAhY106BvYhdzx83ufyHFROmbQzuYlHqcCA/273YyMI=;
 b=STRR6fGjYbwz6290z9MtmEhUSKJ2/xu5WuuqXYFKSFuab7OXLOdxwwk30cR3Qm0z28nvNqQsP6EDs3GV460HKt9qWOhpbEIWiKQ6h1gnyC1vtUWTPcuicztwyP43qXb0e+Sdph6Y1MQ6ON2FzaOKAaec1bcT9lydc5DEiT1fWczM9y38rooT7IG9BBXzgrBROvGO1kZk65YEQp8N4LKsi65g0+80+OPRSGlQbJFt7skXSGHF2FlDWOtbPxQv8OvG+yn91+TkD+0d4f6KsLWRo+LKIGJmG/1GaiEnnbDaF+rvqYP1FC+J1eKHUDy1zFCifzjV8xrqvguXdpuOHGxQxg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6838.namprd02.prod.outlook.com (2603:10b6:610:79::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 18:40:19 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:40:19 +0000
Content-Type: multipart/alternative;
 boundary="------------7odHvQkUSfuYO0O8TecD0F0r"
Message-ID: <32c4cf1d-91d0-48ed-84a9-e21ad7bcc254@nutanix.com>
Date: Wed, 20 Mar 2024 00:10:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com> <871q8b8xeg.fsf@suse.de>
 <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com> <87bk7baamp.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87bk7baamp.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: cbaa5f96-e42a-40ac-98d2-08dc484406b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjIgAK+1mxYa9gDVLw6pBMgjnWDcBAOXXU6PKdye89jadv0Rmr4OJAUjMKPYzsbXlzu3Cp1BF9r6OtLCoKTt3YHe/OeMj13Oh/YDDHDIg352aKrzHh+bMwVOUyE8a03u51LIuWCGsCYzmawqj9NFTS1oaJrVCWORBs8trKAeS/NMcyHPFKk5Fc+lGW1LGR01X5EXMo6wH4/4BQWwH6gQLgq4YUn78De8qkyWVkf6zg9o1289R5FRJAqmmgLfj5wSa5Y11qEhbwvF//+XK6AKvkOsQraEJtUAUSf/KUZ+J/NULrUmfdsF/u4C0hVNAukYDo5LZiCb5GhAO9+AJUA0eTksYpXs1qHxZlguG3r0TRWipwtgkUHTam7C46zqehFWOft47XtSkzirSgePf63/fEuwRvPrYA1ShS3KoPG86fGwjUx/nkNioxyNlznCk5X4zJdhWlwPNl/I8/pZmzXYWrI1VkQlgD2MtR8OUPi0Nck1rkWNdUUBVbJOJHOTqv2gTvnQ1iVJcrt49nYNs8wMuhyhwA8bRmKV3LhUQ7avq6y6zI4mvJGrRH7KyHan0wZiqLSZ1YQGcEWjCekmU5frigjvmNRF9C/amnFCZX8oqQ620ZItF9xbSwB+pKRw5U+9x4ySJlV5fhuMHrzg58AVCyQqIfjO2wLF0PyaPMIiejU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QytrK0JHVU4ya3RubHpNREFKWEtzZnAybjAwckdyYUVIL0w1VGtGY21hNWRW?=
 =?utf-8?B?STR6cEM0a2JvM1RBYm9ud1JYN3dCY0F4V2Z6Q05MTlJaV2RiUDhhVmJMTGIw?=
 =?utf-8?B?RmYrWldaRmR4YmkrYXFBQXVINEt3SzQyeXZNN09BRFk5eWpHZlR5aURXbVdZ?=
 =?utf-8?B?NlJJZGVVbFlJZDl4UGIxb01JVGtXMzlYZjMxa0JYanZsVEFaV1Y2YURlb29o?=
 =?utf-8?B?YlBsVW5UbXBQOWNtVEFHaEdrUkc5cVExUjJ0emI4TXRRTGJIWm96YjhUbXRS?=
 =?utf-8?B?UHRiSWdaQ1R1T1N3TUoxS0hYcnVZZHlyTWY5WUV1ajlzZFYrVWlVZFl0b2Ji?=
 =?utf-8?B?c3VLVG9jV29qK2tFNjcxMnBYMnlwbWpFTTdUSi9zZmFDYkRuc2c3d2pWTWVC?=
 =?utf-8?B?UWxXQVk1TXI5elR3Tk1tYURIWE1FNExaMXNHNDA0cUJiU08wcTRlTFJEU3pG?=
 =?utf-8?B?cXUzbkJnSm9WVmFZWnBVOW9nOHdwRGJtbktYWU5uelVBMGlrV0FjMWRwZW5h?=
 =?utf-8?B?aktLbUZocUI3d2dQbzlsMVRob2JkbG9FOE5aYVBrd2NUZVpCZk0yUGlvYnN2?=
 =?utf-8?B?cWR1VmlpT3ZjdW9va2J5NTJWblBwM1BWNHJ0R3hkNW1VSHhlSVo1NXFzbnBT?=
 =?utf-8?B?RHRiNnpJSGJmNS9sUm93T1pyeWZTeFlrOStrS2x1UlJmMTZuQ1RENjFnMjNN?=
 =?utf-8?B?aG9QbE9ZWGk0Y3Y0ZktiR2VEckRuelQyK0hXWHFKKzFMV0lnLzBWVWZPNjFl?=
 =?utf-8?B?OHNmSXVmNHZWNW83SmIvaC96VGZzbE9jYUNYb2xtR3ZXOVN0ejhXRHFLa0lq?=
 =?utf-8?B?MEJWRnlvTkVWZDg0VUVXSElJSkJuSktPZHZqbVkzNzh4UThYbFVLNC8yRFYr?=
 =?utf-8?B?SHZpZlJtVzg4aFFDSUZzNm9lNm1UUjlKODllOTNxdTBHRkdPZkRkaVhYVUdG?=
 =?utf-8?B?TWxya2JUb2tpU3B6RGhRSnNqU1FPZWZDVzdqb2VkckRZSjIxbkZUWHgzWHBE?=
 =?utf-8?B?blJpTVBEakdrb1VUNElLTDUvQ0pLcVRIZVY0aUJOVmdtSS8veForN05SZUIw?=
 =?utf-8?B?ZE9ScWUrTnoxN1M5L0U0NFhSVXMvNmIvRHRHS09aeDBQYWJhelF3bmIzdUhl?=
 =?utf-8?B?MEdnZTBsajJNbGFIaWROMkl1c3lkWjFPbTNPLzBnWWJ2VTArV2kyQUdUSk5K?=
 =?utf-8?B?eldpQ2NzcmtKZDJ3Y3dkWHZtVC9ObEpCQTR2a3Q0VE5sVkhsWlRreWo1N2do?=
 =?utf-8?B?TkZuNEpTVWYySUZNNmgrU3IwRldnWUVxUFBrWWFpNzk4RUJkdUdVNHdzWmwv?=
 =?utf-8?B?djlFWUdZTnU3L25XR1U2MjBEVElrSHdzaVJJWlE3R240cWhJM3VNZEpBd1ZY?=
 =?utf-8?B?eG9Ma1VSTmp1WE00WTBGNHVEWEdpTXVyNWpXREtOR0Qrd013TWJuVkMyT05J?=
 =?utf-8?B?REl4bDJBVDFHZE9aYUM0d29jaS9XOXo4SXQ0eS9vK2ExMFJ1V21SYmpsQzNB?=
 =?utf-8?B?R0NDT085L2EraHdZMnlHaCtLWHR0NjFVbEpIR3NJUE05U1V1UUtQRHloaUFB?=
 =?utf-8?B?RGcrR3RWT2JxSjJRR1ZoR0REdmE2SWhoOC9uSUVMa29SVmg5TUtvSkd6Q3cr?=
 =?utf-8?B?TEppZWFiaG5ZSTRtK2Y5UlhRMno1SGo1ZDJ2cDFteWtKSXhERlJ6QnE3d0h6?=
 =?utf-8?B?UHdwdHhYZTFDSXdDNEl4RnNQQXMxTlRTTit0bjUzNU1LZ2JqM0l4QWZRZnZs?=
 =?utf-8?B?MkhLQnArSnRMeDFtUkJ0bGNEbEMzTDRsT2FIZjkzcHBVZjlSdEpWS1NsdnU3?=
 =?utf-8?B?eFFENkVrb28wZllZVFlFNUhYREprQ3JEOGVDWStBREZvYU14WU1Qek85dmRx?=
 =?utf-8?B?UW5lZDlON01oa3lUWDR2N2NMd0dKK0M0bm9OS1Z0YnJvR2l1bkJsemthTmhu?=
 =?utf-8?B?cHNMK29GNE5EckFPY2QzalppUy81L2tPejk2RTJ3VGowb2txMnNtd24vRS9r?=
 =?utf-8?B?MVJVYlF1TXhVWTdvcGZ5cFVkMjJCbG0ya3VzZU9UQ3F0a2haSklKNGdDcW56?=
 =?utf-8?B?VWpEK1JrMllGVDR1bG1uTmZhUkRWek1xTy85aEp4N1FHbllLM3F2MzRuZXVS?=
 =?utf-8?Q?lUYtuflUvwJZNXIOiAeoMA1Eh?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbaa5f96-e42a-40ac-98d2-08dc484406b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:40:19.0688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6eHkbFpdla57DDVleT64Z6OosSp4cAueJy5amLzSIi/0f+Typ5gLV29pHz2C6f+QkNaEc72qx83sAUACG19dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6838
X-Proofpoint-ORIG-GUID: NWzewptRcHz1iZkrEvFZF74htGtz4ITA
X-Proofpoint-GUID: NWzewptRcHz1iZkrEvFZF74htGtz4ITA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--------------7odHvQkUSfuYO0O8TecD0F0r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18/03/24 7:46 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 15/03/24 6:28 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>   writes:
>>>
>>>> Refactor migrate_get_socket_address to internally utilize 'socket-address'
>>>> parameter, reducing redundancy in the function definition.
>>>>
>>>> migrate_get_socket_address implicitly converts SocketAddress into str.
>>>> Move migrate_get_socket_address inside migrate_get_connect_uri which
>>>> should return the uri string instead.
>>>>
>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>>>> ---
>>>>    tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
>>>>    1 file changed, 19 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>>> index 3e8c19c4de..8806dc841e 100644
>>>> --- a/tests/qtest/migration-helpers.c
>>>> +++ b/tests/qtest/migration-helpers.c
>>>> @@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>>>>        }
>>>>    }
>>>>    
>>>> -static char *
>>>> -migrate_get_socket_address(QTestState *who, const char *parameter)
>>>> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>>    {
>>>>        QDict *rsp;
>>>> -    char *result;
>>>>        SocketAddressList *addrs;
>>>> +    SocketAddress *addr;
>>>>        Visitor *iv = NULL;
>>>>        QObject *object;
>>>>    
>>>>        rsp = migrate_query(who);
>>>> -    object = qdict_get(rsp, parameter);
>>>> +    object = qdict_get(rsp, "socket-address");
>>> Just a heads up, none of what I'm about to say applies to current
>>> master.
>>>
>>> This can return NULL if there is no socket-address, such as with a file
>>> migration. Then the visitor code below just barfs. It would be nice if
>>> we touched this up eventually.
>> Yes. I agree this is not full proof solution and covers for all the cases.
>> It would only for 'socket-address'. Could you elaborate on what other than
>> socket-address the QObject can have ?
> I can just not have the socket-address, AFAICS. We'd just need to not
> crash if that's the case.

value: {
     "status": "setup",
     "socket-address": [
         {
             "port": "46213",
             "ipv4": true,
             "host": "127.0.0.1",
             "type": "inet"
         }
     ]
}

Okay, I understood your ask here. This is what gets printed from the QDict.
Let me raise a patch to return with a message if the QDict does not have key
with 'socket-address'. This would prevent the crash later on.

I wanted to know what other than "socket-address" key can he QDict give us
because, if that's the case, for other than socket migration, then we can
make this function more generic rather than having it as 
'migrate_get_socket_address'
>>> I only noticed this because I was fiddling with the file migration API
>>> and this series helped me a lot to test my changes. So thanks for that,
>>> Het.
>>>
>>> Another point is: we really need to encourage people to write tests
>>> using the new channels API. I added the FileMigrationArgs with the
>>> 'offset' as a required parameter, not even knowing optional parameters
>>> were a thing. So it's obviously not enough to write support for the new
>>> API if no tests ever touch it.
>> Yes, definitely we need more tests with the new channels API to test other
>> than just tcp connection. I could give a try for vsock and unix with the
>> new QAPI syntax, and add some tests.
>>
>> I also wanted to bring in attention that, this solution I what i feel is
>> also
>> not complete. If we are using new channel syntax for migrate_qmp, then the
>> same syntax should also be used for migrate_qmp_incoming. But we haven't
>> touch that, and it still prints the old syntax. We might need a lot changes
>> in design maybe to incorporate that too in new tests totally with the new
>> syntax.
> Adding migrate_qmp_incoming support should be relatively simple. You had
> patches for that in another version, no?
No Fabiano, what I meant was, in migration-test.c, change in 
migrate_incoming_qmp
would need to change the callback function and ultimately change all the 
callback
handlers ? In that sense, it would require a big change ?
Inside the migrate_incoming_qmp function, adding implementation for 
channels is
same as other migrate_* function.
>> Another thing that you also noted down while discussing on the patches that
>> we should have a standard pattern on how to define the migration tests. Even
>> that would be helpful for the users, on how to add new tests, where to add
>> new tests in the file, and which test is needed to run if a specific change
>> needs to be tested.
>>
>>>>    
>>>>        iv = qobject_input_visitor_new(object);
>>>>        visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>>>> +    addr = addrs->value;
>>>>        visit_free(iv);
>>>>    
>>>> -    /* we are only using a single address */
>>>> -    result = SocketAddress_to_str(addrs->value);
>>>> -
>>>> -    qapi_free_SocketAddressList(addrs);
>>>>        qobject_unref(rsp);
>>>> -    return result;
>>>> +    return addr;
>>>> +}
>>>> +
>>>> +static char *
>>>> +migrate_get_connect_uri(QTestState *who)
>>>> +{
>>>> +    SocketAddress *addrs;
>>>> +    char *connect_uri;
>>>> +
>>>> +    addrs = migrate_get_socket_address(who);
>>>> +    connect_uri = SocketAddress_to_str(addrs);
>>>> +
>>>> +    qapi_free_SocketAddress(addrs);
>>>> +    return connect_uri;
>>>>    }
>>>>    
>>>>    bool migrate_watch_for_events(QTestState *who, const char *name,
>>>> @@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>>    
>>>>        g_assert(!qdict_haskey(args, "uri"));
>>>>        if (!uri) {
>>>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>>>> +        connect_uri = migrate_get_connect_uri(to);
>>>>        }
>>>>        qdict_put_str(args, "uri", uri ? uri : connect_uri);
>> Regards,
>> Het Gala
Regards,
Het Gala
--------------7odHvQkUSfuYO0O8TecD0F0r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18/03/24 7:46 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87bk7baamp.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 15/03/24 6:28 pm, Fabiano Rosas wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>  writes:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Refactor migrate_get_socket_address to internally utilize 'socket-address'
parameter, reducing redundancy in the function definition.

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

Signed-off-by: Het Gala<a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Suggested-by: Fabiano Rosas<a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Reviewed-by: Fabiano Rosas<a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
---
  tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
  1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3e8c19c4de..8806dc841e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
      }
  }
  
-static char *
-migrate_get_socket_address(QTestState *who, const char *parameter)
+static SocketAddress *migrate_get_socket_address(QTestState *who)
  {
      QDict *rsp;
-    char *result;
      SocketAddressList *addrs;
+    SocketAddress *addr;
      Visitor *iv = NULL;
      QObject *object;
  
      rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
+    object = qdict_get(rsp, &quot;socket-address&quot;);
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Just a heads up, none of what I'm about to say applies to current
master.

This can return NULL if there is no socket-address, such as with a file
migration. Then the visitor code below just barfs. It would be nice if
we touched this up eventually.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Yes. I agree this is not full proof solution and covers for all the cases.
It would only for 'socket-address'. Could you elaborate on what other than
socket-address the QObject can have ?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I can just not have the socket-address, AFAICS. We'd just need to not
crash if that's the case.</pre>
    </blockquote>
    <p><font face="monospace">value: {<br>
        &nbsp;&nbsp;&nbsp; &quot;status&quot;: &quot;setup&quot;,<br>
        &nbsp;&nbsp;&nbsp; &quot;socket-address&quot;: [<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;port&quot;: &quot;46213&quot;,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ipv4&quot;: true,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;host&quot;: &quot;127.0.0.1&quot;,<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;type&quot;: &quot;inet&quot;<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
        &nbsp;&nbsp;&nbsp; ]<br>
        }<br>
      </font></p>
    <p><font face="monospace">Okay, I understood your ask here. This is
        what gets printed from the QDict.<br>
        Let me raise a patch to return with a message </font><font face="monospace">if the QDict does not have key<br>
        with 'socket-address'. This would prevent the </font><font face="monospace">crash later on.<br>
      </font></p>
    <font face="monospace">I wanted to know what other than
      &quot;socket-address&quot; key can he QDict give us<br>
      because, if that's the case, for other than socket migration, then
      we can<br>
      make this function more generic rather than having it as
      'migrate_get_socket_address'</font><span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87bk7baamp.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">I only noticed this because I was fiddling with the file migration API
and this series helped me a lot to test my changes. So thanks for that,
Het.

Another point is: we really need to encourage people to write tests
using the new channels API. I added the FileMigrationArgs with the
'offset' as a required parameter, not even knowing optional parameters
were a thing. So it's obviously not enough to write support for the new
API if no tests ever touch it.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Yes, definitely we need more tests with the new channels API to test other
than just tcp connection. I could give a try for vsock and unix with the
new QAPI syntax, and add some tests.

I also wanted to bring in attention that, this solution I what i feel is 
also
not complete. If we are using new channel syntax for migrate_qmp, then the
same syntax should also be used for migrate_qmp_incoming. But we haven't
touch that, and it still prints the old syntax. We might need a lot changes
in design maybe to incorporate that too in new tests totally with the new
syntax.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Adding migrate_qmp_incoming support should be relatively simple. You had
patches for that in another version, no?</pre>
    </blockquote>
    <font face="monospace">No Fabiano, what I meant was, in
      migration-test.c, change in migrate_incoming_qmp<br>
      would need to change the callback function and ultimately change
      all the callback<br>
      handlers ? In that sense, it would require a big change ?<br>
      Inside the </font><font face="monospace">migrate_incoming_qmp
      function, adding implementation for channels is<br>
      same as other migrate_* function.</font><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87bk7baamp.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Another thing that you also noted down while discussing on the patches that
we should have a standard pattern on how to define the migration tests. Even
that would be helpful for the users, on how to add new tests, where to add
new tests in the file, and which test is needed to run if a specific change
needs to be tested.

</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">  
      iv = qobject_input_visitor_new(object);
      visit_type_SocketAddressList(iv, NULL, &amp;addrs, &amp;error_abort);
+    addr = addrs-&gt;value;
      visit_free(iv);
  
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs-&gt;value);
-
-    qapi_free_SocketAddressList(addrs);
      qobject_unref(rsp);
-    return result;
+    return addr;
+}
+
+static char *
+migrate_get_connect_uri(QTestState *who)
+{
+    SocketAddress *addrs;
+    char *connect_uri;
+
+    addrs = migrate_get_socket_address(who);
+    connect_uri = SocketAddress_to_str(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_uri;
  }
  
  bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
  
      g_assert(!qdict_haskey(args, &quot;uri&quot;));
      if (!uri) {
-        connect_uri = migrate_get_socket_address(to, &quot;socket-address&quot;);
+        connect_uri = migrate_get_connect_uri(to);
      }
      qdict_put_str(args, &quot;uri&quot;, uri ? uri : connect_uri);
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Regards,
Het Gala</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------7odHvQkUSfuYO0O8TecD0F0r--

