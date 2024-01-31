Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A31C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV80w-0007cF-6P; Wed, 31 Jan 2024 05:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rV80s-0007Zr-MJ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:40:15 -0500
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2405::601]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rV80o-0006sK-VT
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:40:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGrtaHug/iP4sjgd/vQjcLj3vf16Vk8lsQPfL3HQVjgkN3ayzU+Jt5N0SI/Utj1k1yKovL7gZ21AZ50ksCJPSkPzQXH+WUMBwVeojeD9Z8+phM9ahhls1VbMMyNOwDzA9+O2StWKdgJV0BwETAPNKXonveeGPUtlptQ/5OD6h1W2EyH97xzo8kIgEjmUPnQTizQsVRgx3fmO7QSQw1rstyb8chnlJh26mfdjULcIMLluCuN7IraR21gKMW1LuObyuv+GyZlc2fWDhH5xkLyBMTeh2Q9BRg+g33FhmY3a7ZEwvyNlEFaqY6ZIknR8Dj1U13wNM0kuAUTOpOlowoppDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d5hjce8az2fCjI9v9D2zCXZ3tOBGY7bFIdh1LAvOjE=;
 b=DlQR1kPNs+mmc9vTq1YAMVBGYS03vk7NshORBte7t0kmp3Y+AObwoeoc/glzs56UgF0zUnF9xNDGpvDFhpUBDZclPvzXX+iGvgQFeuE9KPbUL1dy0Xn/DnYyZXqw3FMshnfLQUILtXio5D9+nVTp55XigkAJC34zkjLlmtYBS7jJpRDExbZaTlzxZ6DhoLPyGfq8ZFt7i1Rm6kcTYUo+l6LTkFkM6cr/xlH90BL+FzQOW/ImnFmzwGCCcl7kgZjelY4DAA5/OgAwiun9L2qyCCWExfF35EM/XpUl+c8ZKS0FOkZ17KnSHaXl0hJ8WNmRoauxmyjYvj/bK//vBjSMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d5hjce8az2fCjI9v9D2zCXZ3tOBGY7bFIdh1LAvOjE=;
 b=oqhnZiirxLtGk8mCoqeXQsBQeKeOuHSKWSH10X4hULqFL6O/vnh/RnfaF2avv5V84D8qjhg9zFR3AgSwIh++mSkoGdBA4CqOxr5Bholi868OScBb2M+fW88GvzbVcn7zGB9Rev+KMGmZVWxz7V5evr56wDEEefqFjB5qVJmVVip3ga9IjQ9FT7SQiDl9pnxmQAQSxhNTVx7d4EYtip4bPzVluYzoGsnwLpB2r3oKRl6gjIicvJQKJG2pejv1OVnVcWN5F+aI3R3coKS7xxy7SU+BycR5zTrCTrCoWUT5cxPg5LE47oFfSc250uj9faSzZScBMOsRVcI3HPXF0aSMyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:40:04 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 10:40:04 +0000
Message-ID: <1174a9b1-babf-4588-9196-ad56c8eea59b@nvidia.com>
Date: Wed, 31 Jan 2024 12:39:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] migration/multifd: Wait for multifd channels
 creation before proceeding
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-6-avihaih@nvidia.com> <87cytkdx7z.fsf@suse.de>
 <a54d5dec-6103-4e10-b732-2156573c4ad8@nvidia.com> <87v87abj8a.fsf@suse.de>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87v87abj8a.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::9) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 1838caff-3935-4422-f07f-08dc2248fc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRRJz7VPxt82uTBveDuK9ou1Tsz5yZHcMNzE9sSPz5dEnEeetqJuKWR4Gf5uJipSogPGrYb95uWRiUaQuY/OklE4r79CX6iVg3XTdVZNoWTFENXWg63hvi9La0ye0Q6Uyjn+j/LMLUMVgRS8QkOtCVmP+LKKSqZLRnL70eUTfiab/W+dze05jiJIEq/rof9VgcwY93qdm2hGk1WWorQEV5STO0QrCa3LpVa0n213e0/4OhxfzunLyI5s/fft1WSY5mft+umvlDd+aU/0AhlUKiN4h7ZOOVro0hywSmOtvmP2RVjmNf7bUcr76zpe2HrOxnElcRQ8RPlMBkHjqio6FkYE5mJ41WZZ/ugPf8AP3UKV+Pw7PfBxLXNE5GJtEbNEGxB4hXe4RrDuJxRGfIq1MO6mfz54bb3KRzuQ/ux88W1V3HdcSZbT5z28y39720i57c/Nu4sqkon0Bh1v+8UP1g9RfdJxelHOBv0gwVZql5L7fVwKiNi5AL4SCUr4sHxTi+rdAjHPQNUfpCgUX3PG1GajP3Kh9F9Mw48jfzRuVxFq70KA/SWWHlw/uVWQrrCcLVDj3Gx7d1yCtYcAZyW4VrAhzy//H2nrzW1jVMKzOqrups0xN5UqEuB9MbAWhoJ3hHGdY29iMh7ESI0HSoj72LHBq92XEvpe5bSbF60pyxlOcJR3ioSJBHEcTkjOnspt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(83380400001)(2616005)(26005)(38100700002)(6512007)(8936002)(8676002)(4326008)(5660300002)(30864003)(2906002)(478600001)(966005)(6486002)(6506007)(53546011)(6666004)(66476007)(66556008)(66946007)(316002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2tVcEVTTlFTQWRySVZCU2VXUzNFNSttSW5QLzAyWWxsd3FHc2N2SmE2TWRw?=
 =?utf-8?B?eXFZYUZBYnBpLy9sTG8xdXJZS2lOZm05U05GVVlLMXh5ak56Z2dTd0pXNnZ0?=
 =?utf-8?B?ZGdUVWlSQldrT2lqZGpvc2hjd1VYem1TQVVTZUY2Wit5SnNtcG4vVUJEQjdS?=
 =?utf-8?B?LzhQZDIzUTZ6dldRMjJaenFQeE5pWXI5RURTbEs2S0l1WWNmY1gydUNsTFY2?=
 =?utf-8?B?RzRQQWYxMWhlNmROVXJmVnkyeE1jUHRkMTcyT0dYZkxkcUpJK0IwL2xmcmIy?=
 =?utf-8?B?LzYrTVZobE9uYURiek15ckdGTUhQVGFTdVNnMzBXQ1FUem0vYTE0MHAxSUsr?=
 =?utf-8?B?dm1POU5jWWhNMDliM0dOVzdiR2U3TVdjbnFWYXAwMnJpZHNHRzZOcVN6UUlO?=
 =?utf-8?B?SWxHQ0xkTlZ2UXcvdy8wOWlFdE9vZk1ITWdlMjNPZGs3eUs0Rm1uSUdaLzZX?=
 =?utf-8?B?dFlhS2RiN2RPU1YxYTkyVmhyM1pGS09zeW9VVVRFYjF5K3lKanJBTG90RERs?=
 =?utf-8?B?VWVUQWpMaGpHeXhSS2ZjMDB3ZFVvcEJOM2lhcTF3QTlvdXFmbGN5QS9WbDhk?=
 =?utf-8?B?RHMwL2w0M1dCWGovbC92djZyU3FtTUkzMlY1ejE0bFMyME1Mb01nTlliNERj?=
 =?utf-8?B?d2UwazV6Zm1kQ0tiSXVoRkdJWnNMVmJFdEU3ZGh3a1J5WEd4TFh2STRkckZF?=
 =?utf-8?B?Q3JjYmdSNno2NW9kbE4xeVYzOGNjN1NXaUR2SnpSM2E3VG9WSGRJN2pFbjBw?=
 =?utf-8?B?bUlsZFVlYjJOYnZadkNYVzJMQ29jQ0xuRlVhK3NTZFNsV3lvdzBPKzgxajRO?=
 =?utf-8?B?WDQyZTRkU3ZpTXhHajlEVzVNR3FLdG9oUXpUbEh2Q2xQVTBjWjBuN3BWM3Rm?=
 =?utf-8?B?NE1QbkhJT0Nwb0MvcHY5ZDUxdzJiekJxLzV1VzhSZWhVdjRNUmNWWVc1VjFs?=
 =?utf-8?B?SDZ3enUzazcxVlJCNVBtYk9Eb2NqbTRsN3Ayd0hqbmV1Y3NSS2E2WEJsMmhP?=
 =?utf-8?B?bkp4NjVaTzQwNTJDd0NSSU1kREdaSXBETGtIWm10YTNZVG9lOGxGc1A2Wnpm?=
 =?utf-8?B?TUpoNmZJNGJJMTBSc1oxUlY5K05TMXo0Q3hWMkhrTDZDTlNwQ1dsYzlrbFNX?=
 =?utf-8?B?aTFQY0g4Vm5oaDZ5ZktOcHFuMG82R1ZsSUZhWThDZXZsQkVhWmtRTmtoWGVF?=
 =?utf-8?B?YWFDb01NWHFnMWhnZU1uVWQ3WUN6STFTSEp5bXowdTN5NjR5VU5LQ1hpb0p5?=
 =?utf-8?B?WXNLSkxLbjA4cnlpYkNzWHhyeG81VU9UdkhCUmlTcHpuSHRpaEl2OEdJTG5v?=
 =?utf-8?B?elphVlVHWWVGUjJERk1MaVlZbEdabmk3R3lUWmtBZEQ3RDR2WWdqZk9kVXpJ?=
 =?utf-8?B?R3c2cDBLWTA4WVFzN1JMc1pjWUR3U3VzYjN4N0l2QmJ2Sk4yUkxGTWREWExR?=
 =?utf-8?B?bWdJYmF2OW5oWVFPNU5BMzdyVGNFTkVqdXVZOFNTYmEzaUxrcFVETGlZNjNN?=
 =?utf-8?B?YWE0YjJSRWcydG4zNnZYWkRIaUJiaFdTK1JESVNsU3duNUdINUpQalNWdC9K?=
 =?utf-8?B?SmNDaGlaUElXSW0vRWFJbjZuQXhOWVQydTRjUnBJd21UWnFUZlB6dU1MQ2hT?=
 =?utf-8?B?dkRtQTc2bjh6WmhIRURLNEdpVU5VNW1YNlRzR1kzZU5vdWNWYmVQTkw4aGww?=
 =?utf-8?B?QWRsVUNJb2pqNmxWS2NRTWVsY0t5STUyWEFiWWRNdHhjU29uT3ZtOTFKMUVL?=
 =?utf-8?B?Qnl2WlRSN3dXdG1oTnY2c0xKcG9SNkxaNUtvZ3o1Z1FJbWN6S3hKWGp6ZWxz?=
 =?utf-8?B?ZDVZL0x4VkVwSWoxWDV3UzdsLzYxcEpUNWtZV0o3US83SWtYZ21XbUNqOHp2?=
 =?utf-8?B?cUNqRWMvSjk5K0RtRG5vdEYySXZpNGNZUHR6NG1LU3NicUgyRHZveUl1R1pV?=
 =?utf-8?B?bWV6aXMwYzloTlFPRmVENGZnQitRS2hBNTNKNldmQXlnUW9saC9pZTYzVTdI?=
 =?utf-8?B?THhiZ0Y2Nzh0VmhtTHorc1BVbzdpeEhPMDhZc1l5NTJ4WUg5bXppTU55YVp1?=
 =?utf-8?B?eDdGZTVBUmcxYVJBKzFpY3VkS1FxeDkydVVtaURRblpCbnlTaGxoK1lvdEV1?=
 =?utf-8?Q?hUh4GCL/AJg/QvmzFljvIEPdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1838caff-3935-4422-f07f-08dc2248fc09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:40:04.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxO0JPoGlCuHlBF8BwXovLcro971d6XMI6tpjkLRdnnHsTGxxO4RYjKF1rxxjMSplNnScqV0B/za+55QXXVnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
Received-SPF: softfail client-ip=2a01:111:f403:2405::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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


On 30/01/2024 23:32, Fabiano Rosas wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 29/01/2024 16:34, Fabiano Rosas wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> Currently, multifd channels are created asynchronously without waiting
>>>> for their creation -- migration simply proceeds and may wait in
>>>> multifd_send_sync_main(), which is called by ram_save_setup(). This
>>>> hides in it some race conditions which can cause an unexpected behavior
>>>> if some channels creation fail.
>>>>
>>>> For example, the following scenario of multifd migration with two
>>>> channels, where the first channel creation fails, will end in a
>>>> segmentation fault (time advances from top to bottom):
>>> Is this reproducible? Or just observable at least.
>> Yes, though I had to engineer it a bit:
>> 1. Run migration with two multifd channels and fail creation of the two
>> channels (e.g., by changing the address they are connecting to).
>> 2. Add sleep(3) in multifd_send_sync_main() before we loop through the
>> channels and check p->quit.
>> 3. Add sleep(5) only for the second multifd channel connect thread so
>> its connection is delayed and runs last.
> Ok, well, that's something at least. I'll try to reproduce it so we can
> keep track of it.
>
>>> I acknowledge the situation you describe, but with multifd there's
>>> usually an issue in cleanup paths. Let's make sure we flushed those out
>>> before adding this new semaphore.
>> Indeed, I was not keen on adding yet another semaphore either.
>> I think there are multiple bugs here, some of them overlap and some don't.
>> There is also your and Peter's previous work that I was not aware of to
>> fix those and to clean up the code.
>>
>> Maybe we can take it one step at a time, pushing your series first,
>> cleaning the code and fixing some bugs.
>> Then we can see what bugs are left (if any) and fix them. It might even
>> be easier to fix after the cleanups.
>>
>>> This is similar to an issue Peter was addressing where we missed calling
>>> multifd_send_termiante_threads() in the multifd_channel_connect() path:
>>>
>>> patch 4 in this
>>> https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
>> What issue are you referring here? Can you elaborate?
> Oh, I just realised that series doesn't address any particular bug. But
> my point is that including a call to multifd_send_terminate_threads() at
> new_send_channel_cleanup might be all that's needed because that has
> code to cause the channels and the migration thread to end.

Yes, that's good and it solves the other bug I see where migration hangs.

>> The main issue I am trying to fix in my patch is that we don't wait for
>> all multifd channels to be created/error out before tearing down
>> multifd resources in mulitfd_save_cleanup().
> Ok, let me take a step back and ask why is this not solved by
> multifd_save_cleanup() -> qemu_thread_join()?

Because when we get to multifd_save_cleanup() there is no guarantee that 
the other threads have either successfully been established or errored out.
So we can have multifd_1 error out, triggering multifd_save_cleanup() 
which destroys all resources, and only then multifd_2 will get to 
multifd_new_send_channel_async() but by this time resources have already 
been destroyed.
qemu_thread_join() for multifd_2 in this case is simply "skipped".

Actually, while testing Peter's patch I encountered such error with less 
"engineering", I only caused the multifd threads to fail by changing 
their connect address.
Maybe now the error flow takes more time so this bug is more observable. 
It doesn't repro constantly though.

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555bbc6c2 in multifd_send_terminate_threads 
(err=0x7ffea8001310) at ../migration/multifd.c:485
485         if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
(gdb) bt
#0  0x0000555555bbc6c2 in multifd_send_terminate_threads 
(err=0x7ffea8001310) at ../migration/multifd.c:485
#1  0x0000555555bbd6d0 in multifd_new_send_channel_async 
(task=0x555557f19730, opaque=0x5555571e0a38) at ../migration/multifd.c:862
#2  0x0000555555e6f010 in qio_task_complete (task=0x555557f19730) at 
../io/task.c:197
#3  0x0000555555e6eca3 in qio_task_thread_result (opaque=0x555557f19730) 
at ../io/task.c:112
#4  0x00007ffff780145b in g_idle_dispatch () at /lib64/libglib-2.0.so.0
#5  0x00007ffff780578f in g_main_context_dispatch () at 
/lib64/libglib-2.0.so.0
#6  0x0000555556138d30 in glib_pollfds_poll () at ../util/main-loop.c:287
#7  0x0000555556138daa in os_host_main_loop_wait (timeout=0) at 
../util/main-loop.c:310
#8  0x0000555556138eaf in main_loop_wait (nonblocking=0) at 
../util/main-loop.c:589
#9  0x0000555555b88129 in qemu_main_loop () at ../system/runstate.c:783
#10 0x0000555555e48e97 in qemu_default_main () at ../system/main.c:37
#11 0x0000555555e48ed2 in main (argc=20, argv=0x7fffffffe218) at 
../system/main.c:48
(gdb) print multifd_send_state
$1 = (struct {...} *) 0x0

> I see you moved
> p->running=true to *after* the thread creation in patch 4. That will
> always leave a gap where p->running == false but the thread is already
> running.

Yes, Patch #4 addressed a specific bug with TLS where we can get a segfault.
It didn't try to solve this gap.

>
>>>> Thread           | Code execution
>>>> ------------------------------------------------------------------------
>>>> Multifd 1        |
>>>>                    | multifd_new_send_channel_async (errors and quits)
>>>>                    |   multifd_new_send_channel_cleanup
>>>>                    |
>>>> Migration thread |
>>>>                    | qemu_savevm_state_setup
>>>>                    |   ram_save_setup
>>>>                    |     multifd_send_sync_main
>>>>                    |     (detects Multifd 1 error and quits)
>>>>                    | [...]
>>>>                    | migration_iteration_finish
>>>>                    |   migrate_fd_cleanup_schedule
>>>>                    |
>>>> Main thread      |
>>>>                    | migrate_fd_cleanup
>>>>                    |   multifd_save_cleanup (destroys Multifd 2 resources)
>>>>                    |
>>>> Multifd 2        |
>>>>                    | multifd_new_send_channel_async
>>>>                    | (accesses destroyed resources, segfault)
>>>>
>>>> In another scenario, migration can hang indefinitely:
>>>> 1. Main migration thread reaches multifd_send_sync_main() and waits on
>>>>      the semaphores.
>>>> 2. Then, all multifd channels creation fails, so they post the
>>>>      semaphores and quit.
>>>> 3. Main migration channel will not identify the error, proceed to send
>>>>      pages and will hang.
>>>>
>>>> Fix it by waiting for all multifd channels to be created before
>>>> proceeding with migration.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    migration/multifd.h   |  3 +++
>>>>    migration/migration.c |  1 +
>>>>    migration/multifd.c   | 34 +++++++++++++++++++++++++++++++---
>>>>    migration/ram.c       |  7 +++++++
>>>>    4 files changed, 42 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/migration/multifd.h b/migration/multifd.h
>>>> index 35d11f103c..87a64e0a87 100644
>>>> --- a/migration/multifd.h
>>>> +++ b/migration/multifd.h
>>>> @@ -23,6 +23,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>>>    void multifd_recv_sync_main(void);
>>>>    int multifd_send_sync_main(void);
>>>>    int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>>>> +int multifd_send_channels_created(void);
>>>>
>>>>    /* Multifd Compression flags */
>>>>    #define MULTIFD_FLAG_SYNC (1 << 0)
>>>> @@ -86,6 +87,8 @@ typedef struct {
>>>>        /* multifd flags for sending ram */
>>>>        int write_flags;
>>>>
>>>> +    /* Syncs channel creation and migration thread */
>>>> +    QemuSemaphore create_sem;
>>>>        /* sem where to wait for more work */
>>>>        QemuSemaphore sem;
>>>>        /* syncs main thread and channels */
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 9c769a1ecd..d81d96eaa5 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -3621,6 +3621,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>>>            error_report_err(local_err);
>>>>            migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>>>                              MIGRATION_STATUS_FAILED);
>>>> +        multifd_send_channels_created();
>>>>            migrate_fd_cleanup(s);
>>>>            return;
>>>>        }
>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>> index 564e911b6c..f0c216f4f9 100644
>>>> --- a/migration/multifd.c
>>>> +++ b/migration/multifd.c
>>>> @@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
>>>>            multifd_send_channel_destroy(p->c);
>>>>            p->c = NULL;
>>>>            qemu_mutex_destroy(&p->mutex);
>>>> +        qemu_sem_destroy(&p->create_sem);
>>>>            qemu_sem_destroy(&p->sem);
>>>>            qemu_sem_destroy(&p->sem_sync);
>>>>            g_free(p->name);
>>>> @@ -766,6 +767,29 @@ out:
>>>>        return NULL;
>>>>    }
>>>>
>>>> +int multifd_send_channels_created(void)
>>>> +{
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!migrate_multifd()) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    for (int i = 0; i < migrate_multifd_channels(); i++) {
>>>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>>>> +
>>>> +        qemu_sem_wait(&p->create_sem);
>>>> +        WITH_QEMU_LOCK_GUARD(&p->mutex) {
>>>> +            if (p->quit) {
>>>> +                error_report("%s: channel %d has already quit", __func__, i);
>>>> +                ret = -1;
>>>> +            }
>>>> +        }
>>> There are races here when a channel fails at
>>> multifd_send_initial_packet(). If p->quit can be set after post to
>>> create_sem, then this function could always return true and we'd run
>>> into a broken channel. Possibly even the same bug you're trying to fix.
>>>
>>> I think that's one of the reasons we have channels_ready.
>> I am not sure exactly what bug you are describing here, can you elaborate?
>>
> This looks like it could be a preexisting issue actually, but in the
> current code, what stops the multifd channel from running ahead is
> p->sem. Except that the channel does some work at
> multifd_send_initial_packet() before checking p->sem and that work could
> fail.
>
> This means that right after checking for p->quit above, the multifd
> thread could already be exiting due to an error and
> multifd_send_channels_created() would miss it.

And it's fine, because the purpose of multifd_send_channels_created() is 
only to make sure that when it returns, all multifd channels have either 
been established or errored out (so we don't have left over threads 
running after multifd_save_cleanup()).
Maybe adding this p->quit check is confusing and redundant.

Thinking about it again, maybe the location of 
multifd_send_channels_created() inside ram_save_setup() is not the best 
-- if a fast migrate_cancel happens or some other .save_setup() handler 
errors before ram_save_setup(), multifd_send_channels_created() will be 
skipped and we could end up in the same situation.

Putting multifd_send_channels_created() at the beginning of 
multifd_save_cleanup() will also cover the above cases.

> So there's still a chance
> that this function effectively behaves just like the previous code.
>
> Thread           | Code execution
> ------------------------------------------------------------------------
> Migration        |
>                   | ram_save_setup()
>                   |   multifd_send_channels_created()
>                   |     qemu_sem_wait(&p->create_sem);
> Main             |
>                   | multifd_channel_connect()
>                   |   qemu_thread_create()
>                   |   qemu_sem_post(&p->create_sem)
> Multifd 1        |
>                   | multifd_send_initial_packet() *errors*
>                   | goto out
>                   | multifd_send_terminate_threads()
> Migration        |
>                   | still at multifd_send_channels_created
>                   |     qemu_mutex_lock(&p->mutex);
>                   |     p->quit == false      <--- !!!
>                   |     qemu_mutex_unlock(&p->mutex);
>                   | return true from multifd_send_channels_created()
>
>  From here onwards, it's the same as not having checked
> multifd_send_channels_created() at all. One way this could go is:
>
>                   | runs unimpeded until multifd_send_sync_main()
>                   | multifd_send_pages()
>                   | *misses the exiting flag*
>                   | qemu_sem_wait(&multifd_send_state->channels_ready);
> Multifd 1        |
>                   | still at multifd_send_terminate_threads
>                   |   qemu_mutex_lock(&p->mutex);
>                   |   p->quit = true;
>                   |   qemu_mutex_unlock(&p->mutex);
>                   | qemu_sem_post(&p->sem_sync);
>                   | qemu_sem_post(&multifd_send_state->channels_ready);
> Migration        |
>                   | qemu_mutex_lock(&p->mutex);
>                   | p->quit == true;  <--- correct now
>                   | qemu_mutex_unlock(&p->mutex);
>                   | return -1;
>                   | *all good again*
>
> It seems that in order to avoid this kind of race we'd need the
> synchronization point to be at the multifd thread instead. But then,
> that's what channels_ready does.
>
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    static bool multifd_channel_connect(MultiFDSendParams *p,
>>>>                                        QIOChannel *ioc,
>>>>                                        Error **errp);
>>>> @@ -794,6 +818,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>>>>        p->quit = true;
>>>>        qemu_sem_post(&multifd_send_state->channels_ready);
>>>>        qemu_sem_post(&p->sem_sync);
>>>> +    qemu_sem_post(&p->create_sem);
>>>>        error_free(err);
>>>>    }
>>>>
>>>> @@ -857,6 +882,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>>>>        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
>>>>                           QEMU_THREAD_JOINABLE);
>>>>        p->running = true;
>>>> +    qemu_sem_post(&p->create_sem);
>>>>        return true;
>>>>    }
>>>>
>>>> @@ -864,15 +890,16 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>>>>                                                 QIOChannel *ioc, Error *err)
>>>>    {
>>>>         migrate_set_error(migrate_get_current(), err);
>>>> -     /* Error happen, we need to tell who pay attention to me */
>>>> -     qemu_sem_post(&multifd_send_state->channels_ready);
>>>> -     qemu_sem_post(&p->sem_sync);
>>>>         /*
>>>> +      * Error happen, we need to tell who pay attention to me.
>>>>          * Although multifd_send_thread is not created, but main migration
>>>>          * thread need to judge whether it is running, so we need to mark
>>>>          * its status.
>>>>          */
>>>>         p->quit = true;
>>>> +     qemu_sem_post(&multifd_send_state->channels_ready);
>>>> +     qemu_sem_post(&p->sem_sync);
>>>> +     qemu_sem_post(&p->create_sem);
>>> Do we still need channels_ready and sem_sync here? The migration thread
>>> shouldn't have gone past create_sem at this point.
>> I think you are right, we can drop channels_ready and sem_sync here.
>>
>>>>         object_unref(OBJECT(ioc));
>>>>         error_free(err);
>>>>    }
>>>> @@ -921,6 +948,7 @@ int multifd_save_setup(Error **errp)
>>>>            MultiFDSendParams *p = &multifd_send_state->params[i];
>>>>
>>>>            qemu_mutex_init(&p->mutex);
>>>> +        qemu_sem_init(&p->create_sem, 0);
>>>>            qemu_sem_init(&p->sem, 0);
>>>>            qemu_sem_init(&p->sem_sync, 0);
>>>>            p->quit = false;
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index c0cdcccb75..b3e864a22b 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -2937,6 +2937,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>>>        RAMBlock *block;
>>>>        int ret;
>>>>
>>>> +    bql_unlock();
>>>> +    ret = multifd_send_channels_created();
>>>> +    bql_lock();
>>>> +    if (ret < 0) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>        if (compress_threads_save_setup()) {
>>>>            return -1;
>>>>        }

