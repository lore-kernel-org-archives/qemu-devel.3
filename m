Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3E8CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 06:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR2nv-0003LL-9d; Sun, 24 May 2026 02:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2nq-0003L4-BN
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:59:15 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wR2nn-0000C9-R0
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYsDpk6Ze+Va5TEVM7PfkHMy1AOsp1L2j6u8CdtFa7JHw5+mRHjPZKdUTi7M9bMYjud1qXSFJSmay5JvmWnQaT4/x70SO5K4DOur1YA45MJsf108STy29i5t1i2TQ87gyqBu5G/M1TsvMrGCjmD2G5NyvjAklC8gUYx46IGCK68RaJMnmrLCuKn9NYAFTHjpqEgQy7UOeugQF/X+Kc3YBZHRgawEAVnFCtr6gwGxtU/PtV33St4OOKiMVsmCctc4dvfg8Exe/WA3gLVRJndUvqI/L+ZQmiEuW/EXVpE8ooo5kSIwnKTSqo6q9TBmXv9Uvd/fXAJMaEdQgBcbKRaKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4tc3qHGEHhJIXLKedEEBhR4hkMFNQMIhrxOQ4Q/cWg=;
 b=kO9/jdEnfiLzSLdfJ73UYfKwnaNRorINKXCCuPFzU0FkB6gK9IFzbj8Y9LYaorQSPf7Y17naKyQK3/+Vr3otBdqsXMhhpPtLpy6bP5/FbOMkzMYZ+MXQqBM6Q1xA9C/xLVa81HINihtachLkl0y1z5b2THP+u75A9kPnkUjSrxgontNtURjOEhZB/ASRbFIIblI+e4LinqodwsrVzRezEXNSDRZNh9LKV5EYM4c/GTeK4ObgP9GlyeUmImBce9Q3qWtmEmEvPlP29lNan6xrnYYUtpmARbNd3eP594OSUslBQ+cvOcCK2yl1BKikvwyVTIBcx+h0FROucTtejgnWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4tc3qHGEHhJIXLKedEEBhR4hkMFNQMIhrxOQ4Q/cWg=;
 b=GTN/ckAi2BcvjBtKgadtYpCkYhG5WRw1t11uHU81MKejsWU5tYhA4lFnJsqjj8ZB4tPC/KwxwPOVIWIkyVxabzgMt0HtAMrOE9kq/43yupi57tsNVzDEXpQ31i2UHG/Z+qo901pEnEvuHmlER8GrKipqvWCgKY1o0NijyyT/yTHldO13KnGmJYfwbmftU7MnEeta+Jckl5ZQ8wxA7c8teKJOtpfYxRe0yMPF1//WevuTkFJADEO6gTZW9ISkbH9t5Xj6XYCIpllc8SiOCujNzU31RLcuou0gDt1XWm/RZANry7CLKnHLoCRmaFUvz9N5roIT+CZDOu1A3Q5Mnnc7EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 06:59:03 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 06:59:03 +0000
Message-ID: <2756b13a-498a-4e2d-a218-10b756e0bf5b@nvidia.com>
Date: Sun, 24 May 2026 09:58:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <agzDdH5vClAqwjAs@x1.local> <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
 <ag8iwiwMz5IapU5i@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ag8iwiwMz5IapU5i@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6e78d9-4695-4a47-df23-08deb961f08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: Yt0KdjS1aYo5Pz5hL/y1FmzEAHm79ZhEITJ2YTc9RX153sbRrMx9TKEbo+k2SgiB6mzdeZJ1OE8IWdGgWCJbdq27y8TiyE9GIVtkMlJo/yxmmHpD5SOjq8YMHOSgvs39rMqnErCAk2m8qkLcKi8NwgFUoaDHFpJx4YFv4LlLQxGC7Il6vQ9g+vSF7DWZZNk6IIZhf6P4Xv2maqavuT1ARkNqtk58jndE7Og1ipQJ8Db5MCtQsZ5Lfp4wISRnmqWbkbJTKX1utIrzSf64ODpIIC/ulR03HgwBaR6alde9SdhMdPLtMn8b9/Tfx9STfU9sOyU4IxDb2BP9RAEG1Fsud6wTebfINLd7bAZrQCjhURbU3QEyvhKAWt/DYr6zn+dhQ9EuUCJca/3eteK5c/+X02EiqgV7nUl5j3e4HbZaWdsU28fsqnDqUvSZpXDE0ZabN7zfiHwXMKTW4N58rtEZTzmGENyKACd34uryEKcDviaXBl/2l324DTjWOuqSYtJ9KsD36/+clLwt1D3Zlg8hhaYjre8TxoH3JOYojI4KyjXYl0dY/UjlGIRVAzPb4P09dJGq+A+kSPqYqJQnG1ad39UopReyXtqsma6ANkQFjoLIKf82cfN1q1nzg1nBX97lg9LfmvFgnqkGp7OvryNiC/6+iva3m8L1JLwCQVu7hrRWJGzHTEznqoaO7uGn8h/p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2t2NGczUVAvdDlKTHh3cjlNcnBRQmZ5MmVpU1kySkFMNGpXYmZCYWtOclBK?=
 =?utf-8?B?VnFVS3MwNHBpY2ladTk2RUI0TzRkckdGYm80QlpuakIrdWtyQkVrN3ZBaFBT?=
 =?utf-8?B?RkVFajVPbVIxVkNadjJUS1VabS9EQlFERXg3SWhJV2ZLNHpCb2JxUDlIVVFw?=
 =?utf-8?B?NFE1S1VvbFJKNGNENFlsZzFYRlJsYUQrOGtodEE5ZWhkb3FTUFhmeGh3d3FD?=
 =?utf-8?B?WDNzSXc1enYzNDNiL0JJV0U0SXRVdC85ZEFTS0o4bGdraXpEcFVPTjVqaGFn?=
 =?utf-8?B?SUV3cTBIWDh0R0FQV2p1RFcrV0dGODNwUVVsaGloRHBSU1NXSVkrYU9FRE14?=
 =?utf-8?B?T1pBTW40ajlrQmJqUXAwZ3NUeDB0NWtsN1NUTUU1cHlSTnZDaUhUL0tydEdh?=
 =?utf-8?B?ekIwbkJTbEVEWGVnTHVXS2xDRXRPVEhxV0ZOYkxVT0psYWVrQ0JqZmVIK2R3?=
 =?utf-8?B?RjVaNHZVbHBMS013OVBDYWVIMkUwdTBqd3k5Nmg3Qm5sQkdyNzNMVHV1ak1N?=
 =?utf-8?B?ai8zMGVickdmNUU0V1MxMThXWkYvTnlsdys5Q1VaWHEvUVFxU2JvV0V5ZXht?=
 =?utf-8?B?NWFpaVIzaU0ybjRxMlZidFA1TTRXNWFJY2l1RnVjK3Jmc2J0MENOZC9DMVdt?=
 =?utf-8?B?VWJEWGlpSDRxNnFPVzJER0ROOHg2WGdJbWVYcGtpd0UveDUvQmZtTWJvM0o4?=
 =?utf-8?B?QzZWWitFVmtjbWtNaEt6akdvVHkyMFZBTkJETnVGOVZEcVVFTW56V2JER21I?=
 =?utf-8?B?TTE0MFlUWUd6bDNRaUF2bW5mY3pER1FQeTRiZ1dZWFlJdXdKRWNnV0JZS0tO?=
 =?utf-8?B?N3ZVYjVibmNGeGZCMkltZjVoNHBieEdJR1RKSjY0dW1Ub3VFK0x0c05RWS9P?=
 =?utf-8?B?WnBOeUd0TGNWOTlaTCt1N2xsOWtzMjVDdi9XT3VOTWdia3EvU0hJbTNPY1lY?=
 =?utf-8?B?Mk9HSk5EZjZRMG1DbzF6SHhYQlIwbFlFVmRXLzVTZGVNeTVtSUpsNzgvVkh0?=
 =?utf-8?B?bDdNbkNaa3I0dTJNTnlRcDROanIydUVlaUZNMW9Bb21sazZOMURLMFl6R1pu?=
 =?utf-8?B?bGNmYVZjZ280bktUbWNqaWY3QlJCNnRCVUIrak1hOWozSzhBbng3VExjbmdH?=
 =?utf-8?B?OUI0SFhHWnM1STFlM251YmVmTDhOdzA1djBQcjJEN2J0Uy81eEg0bVlwdDFV?=
 =?utf-8?B?ZVRtR0x3Mmx0MkNWbjRSdDRCNlR2OHJzTHRRUTNYL0xUZE9HblJSZHNKUnhJ?=
 =?utf-8?B?akFhS05RNFZjTFd6NXNIbFJWK0dHdVo4UXNYTXBtVFVGcTAwRyt3VHhNNmU4?=
 =?utf-8?B?dGQvMVpjb2NBaWROeUZ1V1R4MUoxaUJJSEJHOVRpMzRRTWVRb1l1ZmV0V042?=
 =?utf-8?B?OTVCblhvdGpXUzdVOE1EajBPQzJQS1VaZG9MdlQ4TzBIV3diNEhtL0RCcTFx?=
 =?utf-8?B?Z05VRWlQcW1GU0R0V3MyZ0FhSzRUbDZHUXRHRHNEZzA1U1h3MVp4U3lqSlZ2?=
 =?utf-8?B?WS9oYUpxYWkwaFNSWWpaUkRtUERDUWxIUkRqTWZZVnlTbEJ2bXpHTzZISS84?=
 =?utf-8?B?OFhneEs5SVQxZzhYdDJYakZrZGpCZGxPcGFLSmgzMzdhcDNXMjNNMzdsMlNn?=
 =?utf-8?B?enBNUWluS00rTVZhanFYNmZQL0JXSlZOU2JWNEFYMUtMYWl1aThOeTcxOWlD?=
 =?utf-8?B?RXloYTIvZGVLU2hZVUlCUGs2RUVVRHRna2xWRTJ3T2VmYmp2cms5NmZGZTFu?=
 =?utf-8?B?UEQrUXlmakRXOFBNQXBuVkUxR0FnamYvZ094eWladXpFNXFOUkhFNjlUQ2tt?=
 =?utf-8?B?QVJ6clZsKzQyNUFLZGMvNjhoRGExN1U4YTF2VjBuTmhYdEJ6UGc2ZTU3aWFq?=
 =?utf-8?B?cjlDcWtVejVrTFBmUTh6YUxuR1dKc2gxd2d2OVBqbzJHNUhheE16a2FmclJN?=
 =?utf-8?B?TGpHeUx5SEVNQ3ZoeUpGVVp5aEc4Q0VDeHlyek9NcG1XK01ZVC9GK0FJay9q?=
 =?utf-8?B?Y1pndVBrUkt3a3JBV2xjVFBLalZNd0VyL2hqdWNyeXdLcWF3Ym84SDZ0VU45?=
 =?utf-8?B?YXVsUTgzWDB1ZExCVUdJYS84c2lPZEtqM3RHd1RlN05vWWFES3REaDM1eGM5?=
 =?utf-8?B?UTR1OGxrZnFQR1F1ckF6RnIrZWFvbHFJNFNDYkg5MytEVGlkRkJPWVZJb2Fq?=
 =?utf-8?B?QmUySzZ4Ly92WFZzZ1JYbnE2bHhPMlNJR2NXc05ya1ZxaHI3Q2c4RmlRTFo2?=
 =?utf-8?B?TDdaaUJJbDVMbjQ5SkFxcG9USENSYWpMTlVQNGtsM0lJdy9mV3ZQVTFqK3pm?=
 =?utf-8?B?ejE5OFpxTGRLRjFzMFAvQXNiMEQ1eDZ0WWVjZGhCV1c1bFAwSWRHZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6e78d9-4695-4a47-df23-08deb961f08a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 06:59:03.4333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJK7GaI9pHdcQ9MmtUuTyWvWQchE5uMudPNFgfehT63pf2uXyVHPngLUJdR6EAbcjdkdYskpa1EnNTgv47Z2vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=avihaih@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/21/2026 6:20 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 21, 2026 at 04:53:54PM +0300, Avihai Horon wrote:
>> On 5/19/2026 11:09 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
>>>> Performance tests were done by migrating a single VM with:
>>>> * 8 GB RAM
>>>> * 4 mlx5 VFIO devices:
>>>>     - One device with 1GB of device data (stopcopy data) that runs
>>>>       workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
>>>>       (generate new initial_bytes chunks during precopy).
>>> Could you elaborate a bit more on what workload is executed, and how that
>>> will affect REINIT reportings (e.g. is only one REINIT generated, or it
>>> keeps generating)?
>> Basically, I create and destroy RDMA resources (MRs, QPs, CQs, etc.) on the
>> VFIO device in a loop for several iterations.
>> This generates several REINITs.
>>
>>> Can I understand it in this way: without REINIT, device is forced to put
>>> those data into stopcopy size; then with REINIT, some stopcopy size is
>>> essentially moved back to precopy phase?
>> Almost:
>> Without REINIT, the device is forced to put this data in precopy
>> dirty_bytes.
>> With REINIT, this data can be put in precopy init_bytes (and do the
>> switchover-ack dance again).
> Hmm, then I don't understand why moving some chunk of data from
> precopy_bytes to init_bytes helps downtime.
>
> Essentially, QEMU makes the switchover decision based on the math of:
>
>     init+dirty+stop
>     --------------- <= downtime_limit
>           bw
>
> The possible min of above is:
>
>          stop
>     ---------------
>           bw
>
> Here whether some data would be in init or precopy portion shouldn't matter
> for a min downtime, since both portions are allowed to be moved during
> precopy phase.
>
> OTOH, if stop_bytes unchanged, min downtime is still the same before /
> after supporting REINIT, if we try harder.
>
> Say, with below testing results:
>
> With VFIO_PRECOPY_INFO_REINIT:
>    1335ms total (~520ms from the VFIO device running the workload).
>
> Without VFIO_PRECOPY_INFO_REINIT:
>    2352ms total (~1600ms from the VFIO device running the workload).
>
> What is the downtime_limit you specified for both cases?  Have you tried to
> specify lower downtime_limit than what you specified, so that both results
> will become even closer (until they become, statistically, identical)?
>
> In general, I can understand the REINIT will stop converging too early, but
> it'll be the same IIUC just to turn the downtime_limit smaller..  IOW, I
> may still miss some important piece of info that how this REINIT feature
> helps downtime..

The init_bytes are special in the sense that it's crucial that they are 
transferred before switching over. Otherwise, VFIO precopy may not have 
full effect which could make VFIO migration slower.
Accordingly, their contribution to downtime may not be just the time it 
takes to transfer them.

Specifically for mlx5, init_bytes hold a small portion of metadata used 
for time consuming pre-allocations on destination side. So, we may have 
10MB of init_bytes which would take a fraction of a second to transfer, 
but once reached destination, it could take even a few seconds to load them.

When moving this data from dirty_bytes to init_bytes along with 
switchover-ack, we guarantee that this long pre-allocation doesn't 
happen during downtime. This is the time difference you see in the test 
results.

Thanks.


