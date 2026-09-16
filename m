Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE09FC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 19:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6va5-0008Sf-MQ; Wed, 16 Sep 2026 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6va3-0008S5-Tl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:46:07 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6va1-00033D-CE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 15:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X91/h6PElKU4GFshknbxRMzJQUmJS79EBxkE2i4JK20fq7p9e/RDy4LaIOAh+7c3UInzI0qoe22Z/RUCoJmwzvc65d39mEVUbrt0c+W434jDnJP2b6nu9wGWf74qVJFiVahTtd605T/Z7uyMreQ6J0wD0dyybtfK0KUciimoT/QNcU+nVilcCC9E3ysq49XjxISB6ooJEDyjxC2ijlIO0ZbcnCubtoToA4cPUHrAqckUGVjVUX1zMxkUL7x4ols+9WkrGqiJqiFHYr+UYKhlw5tPXsewv2CI8FYDxtx4UNo+t8LrgbgPl+dAFJ3gHYnmkiQJfQP+iP67ax8vuQInmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP1H/LSlkFgd+4H403/osLmPrVgkgCg/LcrYjCMEegc=;
 b=bnd1zalaSiY2B0aUBomftGn/iLyVau/DPXZjHs7nP4jmg8lhd1ooRqUu8Rfq+0L+Mib5sVN2lbwp33n7RN+J1nC/+YqRhzJmjKpKa0m5bTfCStiqrhasNIa3iMF7BOuwEK6P7V1eIYYTrSrdDaBqsALMpw17l5vLsa1zf3sHw4wgKH51z9+IQBqNip7NwGFoXtrv+F/hKPYHF5xJYO/LukPWfzUmmj5rfm9rauV217xzpLuIcTBH1ON3lR8A04OB19I0y29x3WZDi8Na9TUS6uJ9Wmz8My4RhsZseGCJ/wcvBIubzn0SZJAPppFBS29ixiC5qcXfHPQoSTqHbl80FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP1H/LSlkFgd+4H403/osLmPrVgkgCg/LcrYjCMEegc=;
 b=cMWfZxPSFOrfDvxmdn7ruuZdxogCNlhZZeFRKPW7sHXgqvNNrbwk9UY2lkplwGDzkRJmywerWuUJhTe5HZsHAkGPZGzGOL7p3lSw+kZ6ngbRdDtgrTJB/dhagrSFJRbwgxlSK/cGhfHfA/qiLuJpIbyYG2WimnsZVTmUaH0mBY1xtXZFHcCKEQ0vcunkXor+Jo1FT+/69JtKxcPU/klGFVxNXW8bdPqyivxVr+Wvyi0SZLNgpU0jdXiKVw6nsIIMNeMn5QLTfczvM4eAYYtFhAKCNH2VM+jA3VFnRHRLe+SDeBwOPtOvsaDslIng/nxMVajMgHIZk71bhXMTjhDIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV2PR08MB7955.eurprd08.prod.outlook.com (2603:10a6:150:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Wed, 16 Sep
 2026 19:45:58 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Wed, 16 Sep 2026
 19:45:57 +0000
Message-ID: <c7cef33d-5f23-493a-b437-e55a3b48736d@virtuozzo.com>
Date: Wed, 16 Sep 2026 21:45:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero"
 <maciej.szmigiero@oracle.com>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Steve Sistare <steven.sistare@oracle.com>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb> <87v785rpml.fsf@suse.de>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87v785rpml.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0311.eurprd07.prod.outlook.com
 (2603:10a6:800:130::39) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV2PR08MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f568ce-1823-43e3-273b-08df142b20c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|4143699003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dc4E1QTmd3U8WiObTgB2DT0P01TRxH0XQHcG10AIeasB3KeDCy1SjtwQXrSwmoWlghMBLQ2G9a3he42I9EbkpwMcrsKHxNPyf35Y7hov2xfmFVYYgEamL0DtD7E55hhpW1f3eGGrRLW+fpWuiC04QcX/JoPh0QOl5LPXZYXXMlLvRc/Mrm/gocF2pb7meINCCVN586rbygzzvZVi7xu1NPIzhfpo9QRbVJMM6kEVG2BOMZQ2voGD4a8dRPcIVVHQvTYOC6VNyFjqgNTpIXRoNRMVcVfktoU+kdoSTL9LX1DJj0LLyTtbtNjFlz1cInIxQEKHuXbO8m3N4l2CM9KkLxGOylSmcivfYJlSkQ5HJml1KRjGi/vK39QuWhVwH0Ch8lpp8gsmisftESffkJ/XHC62Ul7+L4OcopeqN+IF1UlSQFXFYVlAvq+8/9Wkw/EIW1iWzIJw4WxgwwfyqWAGRf7mWqTA6qA+tYwWMxPlRzBQXOWhUlrs9FohdN7L/iJjWtuNRqou0mR+goPu9gF1Ioq1EslgMJ6impwxa2dSOpPtuz4ZJDDvxOx4O7Wgmx0/H4CPZacAlyZhUZzqSPNY+9vNwGAIoK32sAjZUB2qzLe7iLSI3XKmK+uH8XTvZl00UyDNTBS+d4tXx9DzT9z4B6eKEBDEQvrnncSZU/1QT4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(4143699003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9ISk9peHdJVXhVdllUZjJvdDlJeFNtSklZYmpYWUFTZmN4cFBaVTNQQ0Nk?=
 =?utf-8?B?ZUtiMzl6aUgzcnZDTVArNnExZDBzWi9hQUt2Tjd6dnNzaTZhRFVYemR3ZTFB?=
 =?utf-8?B?dUh5RmNqZ0RFTi9MUFIvYWpFZzhzZ3lzZm0xWnVRNWlIb1hxWWwzTkkreEFJ?=
 =?utf-8?B?QVRrbCtiYlB5UllKTlBTdkpyYXVKTGFpdDNabmVjWTFWOU13V04rQ2VoR21Q?=
 =?utf-8?B?eHI2blZDZndjVjJWYWRSWndRNXVqNWkwU0pPZjJ1QWtlVEVMSE1HdEFMMXNL?=
 =?utf-8?B?bWRMZXhaUDE5QWVnWVNHOFZHM1VMU0hxQmhYR21TNDlHM0ltNzYxL3Y1akNV?=
 =?utf-8?B?TXZ1ajdIUzVibTY0NkJDUkxGS2Zvc3dOYUY0UTJWeVlRYnM1L0Zvcmx4VCtI?=
 =?utf-8?B?YmtyZDZqT2xyU09tZlVIZWhIMFBrMXR3bmkwaWQ4eVNRYmVyUmxNeXFOeGk4?=
 =?utf-8?B?bDU0UVBUeHFyM0NsRCs1U3p1b1orekErTk9Cc2lLYnk5a2JEd3oxeEpwUklZ?=
 =?utf-8?B?SHFZRnlaWVdXdHBxeVZnNFVuWWF2WEN6OCttbkNTcURiSkVYR1JxUDExb1Mx?=
 =?utf-8?B?SHU5R0lrd292UWd3TWR3L0VzbGYza3JxcTFwK0w2aGV2UnhwNktVUzI4RXF4?=
 =?utf-8?B?aHA3K0Q0ZjlUQzFrS21jeTFIWG9MNjNoZkpSbnp0ekszWVBqekU5VDk5TE5Q?=
 =?utf-8?B?YWc2N2wzbUtMN2cwaW9zOGZFY3AwTEdxNDc3d2p6T1c0Rkk4ZVZaT1JheXdG?=
 =?utf-8?B?MXcrOXkwQnR1NTBVWjVQUlFSdmFmT2VFYWFweDlLQjdoY29Jazc5TEFOczBQ?=
 =?utf-8?B?Qk9KU0RjTXg4Q0hHQkRreHl4NU5OWHFOTlp1N3lIdm9UYWlWdU54aUxjbUtS?=
 =?utf-8?B?U05LOEcrQk9CRnNmTlcrMlpwa29waTRIOWhRdmpXV0tNVEZDc1NIVGo2ZUlK?=
 =?utf-8?B?bTd3cWc3dGpOWXZRY0prZlFTUkFpSnlYUFdBcSsvUFdrRHFjMzN2R1NZejJs?=
 =?utf-8?B?N2ZwZGdZMEF2cUFaRVBLOEhrdDFkTmxOUmZHemd4STdmTHRBRTJsekM0Vy83?=
 =?utf-8?B?MDZpaW1zcXlsRWR0RGVIeDBJZ3NOenVVelhBUlVadklscEsvRE9UMWphaFpw?=
 =?utf-8?B?enlGNmJLWDBjN2JJZXRIMWlnT0Q4N2lvY2U0K3lJcU93Mnp4THBRLzg1MUJ1?=
 =?utf-8?B?TjYzMmkvL2cyRW42d3ViMmpwYTB5WWJXeGhLek40MmpyeWlzV0d4MFQ4eHYz?=
 =?utf-8?B?WUhLemZ5Z1IzWFRFRmhiM2lOMW1GYXdWdm5mRmkvdDF2bjh6cDBFSkliRnBl?=
 =?utf-8?B?MU1IRXd2NWQrTDFVbkZCNXlhRWhzZ1hram9rL1dyRTVydkp3ZnA0ck1OWHZM?=
 =?utf-8?B?UE00czBwbklybHZYNWZMWUxpeTNUUWQ1ZlQwRHlVVU9WMThKM0tZS09vamlZ?=
 =?utf-8?B?NW5jRFVmT1E0ZGFYWmpJakRScWV2dG5PdEZ1QzI2NkRBUU1nTUp4UWVIZUhF?=
 =?utf-8?B?TmZqbm0rRTFQZTJZZ3JNQnhCcWtzL3FoY1hWcExNd1FjNUtob0RYNVVOSWNJ?=
 =?utf-8?B?YWdUa2VTbnp6T2xoeWZNa1ZueVNueU1McUF6UlFHZzVpcGlqZjhSZmJGOFMw?=
 =?utf-8?B?d1Nlb1lRckpzYzhNa1FhT3FTZ0wwNXZzY3N5cE9UQXZWNkJjNTBmWDRSWHVN?=
 =?utf-8?B?ZTFKcm5aLy85Z0dNRkpHa2d0dE02OVd0T01GaytyUExJRzhqTy9aOHRZT0Np?=
 =?utf-8?B?dlpoeDUxb0J3dEJJcEZkeDlyeEZRZnNjOWFab2dLNkxIeERIWW9aT0FmY2lG?=
 =?utf-8?B?QXEwV1dDbjI1cWtFTFVHMDMyYVZhWVR0YThNb2VNdURpTlpXSVFpcVp0RjUr?=
 =?utf-8?B?MEZ0THh6SFRIQm1jRmZsTmZaREcwS0RqRW0vVG45a09aRktnUmZGRUFXWDBy?=
 =?utf-8?B?Tkc3OW1wL0ZkZjFqSElaZ0M3ZWFjMWVhSG9YdkZ0Ny9KbXc4Y2JLaTlUSDlO?=
 =?utf-8?B?eDR6WS9vOHdDRmFyTzVFZFpBd2hvSUh4YzBzNG5ZTnE4cXc4TEZNYjZGdmlG?=
 =?utf-8?B?aFVpUFplbG1zb05MUDQ1TEpJNDRqSmdSa29VZDdUUno5RjduNGpJZDd3R1R1?=
 =?utf-8?B?L3UwNUlpejd4Tlh3dkdPMVVPUkxTZkEvbHplM2J0Q2ovMFRLR1FZeEF0M3RF?=
 =?utf-8?B?azB2TGxocUlVYlNMaW1TeHBRS2o2SDFVMmFZWjh4dzRka25zeHRPelZnNU9N?=
 =?utf-8?B?aFZCZDBMNUVzYThaVnA4Z1RCUk9BWjRENkFmZDRTWUxRMVlEYmo0dnNSL09G?=
 =?utf-8?B?dU1vN2M2M3FVRWIxb0M5Q0pCS3VoZjNsaHBvaVQvckp4b2JqMTh0TXZteVJN?=
 =?utf-8?Q?JxFQ4XBcQkOLgolx9lOr53ath+7+UZKkVXcgl2S5/uDWW?=
X-MS-Exchange-AntiSpam-MessageData-1: XUGokYvmb4tDvQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f568ce-1823-43e3-273b-08df142b20c8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:45:57.7813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5u0EprcBTpP7FB3xMgBzo7X2uMAEdIGX3TcLGOFLe80NTZ0MAhYorcg+q1n4FEmPsncd6qWV/jsnPpY2as6Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7955
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
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

On 9/16/26 20:57, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
>
>> On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> The cpr state is a process wide registry of the resources that have to
>>> survive an exec. Entries are added and dropped from realize and teardown
>>> paths all over the tree, and a caller has no way to tell which thread the
>>> next caller will run in.
>>>
>>> The state carries no serialization of its own. It is safe today only
>>> because its callers happen to hold the BQL, and that is a property of
>>> where those callers live rather than anything the interface promises or
>>> checks. A caller that is correct within its own subsystem can therefore
>>> break this one from a distance: two that overlap corrupt the registry,
>>> and the next lookup walks an entry that has already been freed.
>>>
>>> Give the state a lock of its own instead of relying on that. Entries
>>> move when a device is realized, when a resource is handed over, and when
>>> a migration starts, so none of this is on a hot path and an uncontended
>>> mutex costs nothing.
>>>
>>> Take the lock in every accessor and across the save and load walks.
>>> Holding it over the walk callbacks is safe because none of them comes
>>> back through this interface. State that is not reached through these
>>> accessors, such as the VFIO device list that hw/vfio manipulates
>>> directly, stays outside it.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Fabiano Rosas <farosas@suse.de>
>>> Cc: Mark Kanda <mark.kanda@oracle.com>
>>> Cc: Ben Chaney <bchaney@akamai.com>
>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>> Is there a real problem anywhere?
>>
>> My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
>> creating a new device or so, which should normally need bql already.
>>
>> To ask in another way, shall we simply assert bql_locked()?
>>
>> Thanks,
> Fair questions, let's see what Denis says.
>
> From my point of view, if the work is already done to use a lock, I'd
> take it; one less place for us to bother when dealing with BQL issues.
>
> (on the other hand, I'm not doing any active use or testing of cpr aside
> from migration-test, so my opinion is the least important here)
The fair answer if the following.

1. Right now FD database is already accessed from main thread and
   from vCPU threads (MSIx handling). It is fortunately protected
   with BQL.

2. There is no real today problem right now. You are right. The
   problem is in downstream.

But the problem is real. We either should fix either contract
in written - just BQL or add the lock.

I do think that CPR have value for the project - devices will
come sooner or late and the database is to be protected.

This is fair statement for today.

Thank you for your time,
    Den

