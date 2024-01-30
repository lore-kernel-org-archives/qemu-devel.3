Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35742C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 18:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUt6E-0003fE-UP; Tue, 30 Jan 2024 13:44:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUt68-0003eY-Ab
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:44:41 -0500
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUt63-00054c-9I
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 13:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYPSjvsRaX3J+2SQABk1LUmofD9jqJozGHv7fpeVKPX7o++L1yoAsaXvt0AFVh3hSN/gPYHjEGn/n7G1dGTgVaizKPFL62sF/iGH0hNItw6zKFY8Z9/ZoR/okOUcsCFPk7UiFIpQqB3zgvN0OaJa/E72lmbOH1y0ggz+bDmzY/ind8uMWUDv5iotvYZ+HeNvJEdyf3rR303HkHqmujG/LTTJcSVEgo+ad/b8iZbcG9cHxRQYLK3T+yk9fTNpovRutbC5cVQudGqDZ+nFcN/aXIR5AoNJIIkq43YTkRceImrJxt4Jhs1RTtFZTTYnEsVXfpkmastkQsxucinh3BnY3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNiQ8hmoSzdMbDWHY+FRgTYUtaHrOe7vGLNRMwnz91g=;
 b=IsnOc+R1pFkbglm01NvGcX9headQZ4OYYMBEhNnFVfMgjhPC3xHEg/DENvJw6kgqYN9UhV8B+Fs8YSabFFIb9aJGd/qcyIomJHyb2WXkric8Cvv9tOyRbVqcUxIS7sucsOteHIsvPB2qfmHdLmtGQDz5NCF1I47DqOc6BUTU1qtRJOwD2qAtIsjLUIeuAPapqPjrea963jOXzjVJdUkn8qFJCfIJihz1iR3MevDqmA/G62MmD4WFMtIWRbKJOS/ZYrMvIU4E6/MxMgQvYMYW2okedPiL7ParLpccgwqAJ8ppHeaTqdy6/USsjtll5qKgXaU2EY+x4FWd7kC4pF1ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNiQ8hmoSzdMbDWHY+FRgTYUtaHrOe7vGLNRMwnz91g=;
 b=cMX7ZZE0he0CKuzynewFNHGZM3tDqf7rYqUt7dsEEUkIxeMIX9vg1g6df6iYTz680QvRXVaa3CWwbf5ZrH/9UBmiDwhZXNXvEgCabmyo6rgN9JyQYelsbUM/LnMz1aDsO6Qnvr50w6m4J+HfqvmSzDlaYNb+0fpWAwwMWPiAHeX0+96uGx+4xoafMj91PB0vaRiqlDDO1LXjOs1zYsS7TsYc9xUk71/u3Er4uGgIOFHWFACg41ZWm9z8F7aIUThWIPLfB7jm+KHreehuQZbGT4PeEW8yVlRQOHldIb9DEaB06gI1C+WE5Zd5MAbqxhOxSDi72TvdHd7DUxO9PmsTLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 18:44:24 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:44:24 +0000
Message-ID: <113f4fe5-30d4-4aff-9f60-91b2a0c103e5@nvidia.com>
Date: Tue, 30 Jan 2024 20:44:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com> <Zbcm1nXzQ_r0eGG0@x1n>
 <0f75090d-bbe1-43cb-b649-a0880bc413c4@nvidia.com> <ZbiP1Ayqxj9BLdY7@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZbiP1Ayqxj9BLdY7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab36810-40ca-49fe-8731-08dc21c37af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoOlaye/1I0A89xw/GxIcuJ4d+OmlQSXvM2gNpj8eJqf+ZiePSjCvTgx4oolXh5MhCYvnOGr4sK5ong5KFwPYN9IZkzPKJBf4AGS3TomRJ6vHKaiuRIlzb49UlK5nC04TYSDFKBTPvCSMpMRrzWihan37qrhiFf3S7wgQ9rBmGlvUIsQG7vIHg3byxSo3i1XfS5TZvN+t5StJtGB+/Ao/i2SLxwH+taBbURxMu72xjKI2IK4b+qDkyyauI+AXwD7PSMXU2GwVSqu/IHbkCL6wIDVdY4C52s65zlZ343eVjKoe1RdpeNynF+dPnDideC72PkW/Qb/lJ1SKz2iErbEbHZvjH0v7ca4RJXOsVtKNc1X8VEaczQhM7mEvDp2LDm4yKhK4S9V9q90rRbn+mVlBUEug0WGoTJfaL+HcWMIzXUCfBdcAzRQi0IqRpEdPPFtQUzTAlSrgEEiXB+wvDyQvTtTvhjTkTSIbk+VEG37XUWF9jSxMRl/Xm3zQ3cqcszKJM4erOSjxGPtL4Ib8HAt18RzGNyY4GUvWRUbkuHTIrGRafW+aocoPGVNfSXMci7f85eVi5RareBa5oZEGuO36v6tHAoOzwatAAkOzAflSXl4lwi6dLXtvL2VkQk7minpfLfiEZyg58x4ZjXeS3H4Z9v57M1+s2Tv68pN2YpDbgVrnXke7SkFkc2DI1Y/mNOJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(66899024)(5660300002)(2906002)(36756003)(6916009)(83380400001)(6486002)(66946007)(66556008)(66476007)(86362001)(31696002)(316002)(966005)(6666004)(478600001)(53546011)(6512007)(4326008)(6506007)(8676002)(8936002)(38100700002)(26005)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRMZGdaN0NmUnVSM2x5NDMwZmJlOTkrR1g2RldadVE4Rk1QUXgxUU1oMmV6?=
 =?utf-8?B?VU1uSnBFSGQ4MkRBVlM1K0J6Q2s4M3NMYVJITDlmaTNNNFI3OVFabXFlRmIv?=
 =?utf-8?B?SWNvekdkT1NiT1ZraWl5aUhuMGtoRVdEUVR3WTVVY01LY3BYRmUyRjJ5STVv?=
 =?utf-8?B?YWh3enJ2THhtTlowcTNqODltL2JlYTR3MzRpM29odVZDY3dwdjlDN3dQaUJK?=
 =?utf-8?B?V1BsbUM4RlJqaGlyekYzN2UreEhRN0lxR1pMaUtsVk92Y2pwMlozL2JpUXRY?=
 =?utf-8?B?NXJKRk9aOFlNTkdaZHE1ZzhadGtjcnVDWEswUXR1b2ZwNTl6RDNHRmdMVkNB?=
 =?utf-8?B?c2NDUk5VTmhKL3Z4UndXQWtSTStGSXdNeEh2WExUVU12RklLdUQ2REZWTnhL?=
 =?utf-8?B?cnRDS1lQUStPdkNXS1AwVXMxYmhLMVd0WkxpQmJzS2gyR1ZmQ0xsTDZ4YjBX?=
 =?utf-8?B?ZWVBYnA5Q0RyNkZsWm45R2FiNzM5RE84VGFOUlZNYjFlTjluRyt1T2QwdkRp?=
 =?utf-8?B?RXF6Wnd4RWlOZHZwTnFRam95NHR6TU9QcTJGUElDN1UxZU1yTk9HWVBzcjNR?=
 =?utf-8?B?SWZxaDJEZ2VGMzNFU0ZLUDFvOGJLSENiR3FPNC8xTjhtMitSeTB4WnZCalQ5?=
 =?utf-8?B?Zk85TWgrdjVVT0ltVFk1dGNBd3JSVk1oMXBRYVpZVjkrSTgrR2JPTmhGUnQy?=
 =?utf-8?B?Vy92djl5dDMwT0VaRXZkY0pGMGN2ZGViVEl2SW1NYkFNcmpUVHQ2TTgyR0tS?=
 =?utf-8?B?Sk1iRmpaSWZ4cytzQmJPUFpvN0hvTHl6V3ozR0VpQ0lndU5SQk9taXVUY2Z5?=
 =?utf-8?B?T3gxK29iaDgrNGxlUDM0WWZ4MnMwM3o2M1dQTytxVE1lUjZlS1hqUUZUN0E3?=
 =?utf-8?B?MlRFUzdjS3M5cUU0Y0swOUxoZE5IMVJ6OEhNMzdwZXV1dVM0dGs4S2JBUlAv?=
 =?utf-8?B?RUpxZ25wM3BLbUlVNmxEWDBybzZKK2JvOEhCaVd2Vno0Vm9GdStOOTZpa2pV?=
 =?utf-8?B?clhqU1Q3d3pucEJ5TnNwa1hmVHR4NkFPWWhyMmR1bHlLY1BYNzd0bjN3QXgv?=
 =?utf-8?B?QXRDeUp2ZE5GWDg0VWd6TVNFVUVXY0xCc1UvZEJBeFVLT1RzenpZZzhMYmRp?=
 =?utf-8?B?ZWhnZ3FkY3Z1ZngwVmwvNVRKR2VtclpVd1hoN3h6LzBUQnVzYVE3N1IvaSt4?=
 =?utf-8?B?VkN5aWFPTUpCbHNEZXZoTnBtMnhXL29mTDFVeTVyOHNsS201YjdocXA2dG5B?=
 =?utf-8?B?MVIvb2kwYjhwNldieEdaYnZSajdLQmptNFAvVVU1b1FqRzc1bnlYNVovZEtI?=
 =?utf-8?B?dENOSFBrUFhRbEUzMUZMVUpUaFBmK2VIQWg4Z3FhMFJwRkVUS3RZU3AzNVNT?=
 =?utf-8?B?ZE1XRXNyL0h3OTFBaVFCZ0ZQcDBReXRkSDY2UGZ4TFViWGhSWDZwaUxRTGNo?=
 =?utf-8?B?QWJqT3poc2NQKzZPQkxwN3NwSXRUZk9VcWIwUVlJWkkxc3pPNWYrZ00zdUw0?=
 =?utf-8?B?MGFDcFNmWURpM290Zzh6NXozd0hMWGJaZUxtZlFtK1pDeHA1bmgvWHcyQUtT?=
 =?utf-8?B?M0cyVzZ5R21oMHFpWDNMYUIzcVZSSVo5S3dpWkhnWm81dnU4M2NiaHloYkR2?=
 =?utf-8?B?bzcrNFpTVmRNNXU0TFl4ZnN2b0tXZnRWS1JaNjk4ZGVuTHZJdXJuemtyZUEz?=
 =?utf-8?B?UEF5Sk5nZEgrUnhHaEZ1ZUo2L0Fpa1poNjZ1eXhUa0dDTFdORWRoS3FMeVA2?=
 =?utf-8?B?NjJhN2FrZGlxamhhWUhmeFVGZUY5dXh6WFdTenRYczB3QUpXYUlJR3VuR3Az?=
 =?utf-8?B?NThxTHR5N3NMRnNkczEwZ2FKZGpHQ1FWcHhDTmtPSmlrYk53UlNUNnNMbVlS?=
 =?utf-8?B?ZkF6VVZROWNNdDZhN1VXNHh1N01majBCeHRrRXhMUDAyMkVGcldIc0Nhd1VO?=
 =?utf-8?B?d2J1aGl4dHFwSGNpYURoY1FUL2dJSElmd3o3eTdVTmQxa2RzbTdlU0xsM3lM?=
 =?utf-8?B?Mnp4WFdUVUpXVkdQMVJnQ0d4MFJkY1R4UTdmMU5ISWdYdkZ6Y0tRbklnS2ky?=
 =?utf-8?B?WTFTQnFpaXp0TkpFeXoxYTA4blJaMzVoQkMyTWdoZHVqU1V6aEo0ZkQzTFll?=
 =?utf-8?Q?5vzIRzTLU4IWNGRvQrw6NjOgL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab36810-40ca-49fe-8731-08dc21c37af5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:44:24.6977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oR50ikppLNKEbkfYkjN6YUy+z5VYMDPMdvWsoVHK8Q110QWkrSGwkIoebA77KLU5kTeTt6nLw+lAnoFQbGHjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


On 30/01/2024 7:57, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jan 29, 2024 at 02:20:35PM +0200, Avihai Horon wrote:
>> On 29/01/2024 6:17, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
>>>> On 25/01/2024 22:57, Fabiano Rosas wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>>>
>>>>>> The commit in the fixes line moved multifd thread creation to a
>>>>>> different location, but forgot to move the p->running = true assignment
>>>>>> as well. Thus, p->running is set to true before multifd thread is
>>>>>> actually created.
>>>>>>
>>>>>> p->running is used in multifd_save_cleanup() to decide whether to join
>>>>>> the multifd thread or not.
>>>>>>
>>>>>> With TLS, an error in multifd_tls_channel_connect() can lead to a
>>>>>> segmentation fault because p->running is true but p->thread is never
>>>>>> initialized, so multifd_save_cleanup() tries to join an uninitialized
>>>>>> thread.
>>>>>>
>>>>>> Fix it by moving p->running = true assignment right after multifd thread
>>>>>> creation. Also move qio_channel_set_delay() to there, as this is where
>>>>>> it used to be originally.
>>>>>>
>>>>>> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> Just for context, I haven't looked at this patch yet, but we were
>>>>> planning to remove p->running altogether:
>>>>>
>>>>> https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
>>>> Thanks for putting me in the picture.
>>>> I see that there has been a discussion about the multifd creation/treadown
>>>> flow.
>>>> In light of this discussion, I can already see a few problems in my series
>>>> that I didn't notice before (such as the TLS handshake thread leak).
>>>> The thread you mentioned here and some of my patches point out some problems
>>>> in multifd creation/treardown. I guess we can discuss it and see what's the
>>>> best way to solve them.
>>>>
>>>> Regarding this patch, your solution indeed solves the bug that this patch
>>>> addresses, so maybe this could be dropped (or only noted in your patch).
>>>>
>>>> Maybe I should also put you (and Peter) in context for this whole series --
>>>> I am writing it as preparation for adding a separate migration channel for
>>>> VFIO device migration, so VFIO devices could be migrated in parallel.
>>>> So this series tries to lay down some foundations to facilitate it.
>>> Avihai, is the throughput the only reason that VFIO would like to have a
>>> separate channel?
>> Actually, the main reason is to be able to send and load multiple VFIO
>> devices data in parallel.
>> For example, today if we have three VFIO devices, they are migrated
>> sequentially one after another.
>> This particularly hurts during the complete pre-copy phase (downtime), as
>> loading the VFIO data in destination involves FW interaction and resource
>> allocation, which takes time and simply blocks the other devices from
>> sending and loading their data.
>> Providing a separate channel and thread for each VIFO device solves this
>> problem and ideally reduces the VFIO contribution to downtime from sum{VFIO
>> device #1, ..., VFIO device #N} to max{VFIO device #1, ..., VFIO device #N}.
> I see.
>
>>> I'm wondering if we can also use multifd threads to send vfio data at some
>>> point.  Now multifd indeed is closely bound to ram pages but maybe it'll
>>> change in the near future to take any load?
>>>
>>> Multifd is for solving the throughput issue already. If vfio has the same
>>> goal, IMHO it'll be good to keep them using the same thread model, instead
>>> of managing different threads in different places.  With that, any user
>>> setting (for example, multifd-n-threads) will naturally apply to all
>>> components, rather than relying on yet-another vfio-migration-threads-num
>>> parameter.
>> Frankly, I didn't really put much attention to the throughput factor, and my
>> plan is to introduce only a single thread per device.
>> VFIO devices may have many GBs of data to migrate (e.g., vGPUs) and even
>> mlx5 VFs can have a few GBs of data.
>> So what you are saying here is interesting, although I didn't test such
>> scenario to see the actual benefit.
>>
>> I am trying to think if/how this could work and I have a few concerns:
>> 1. RAM is made of fixed-positioned pages that can be randomly read/written,
>> so sending these pages over multiple channels and loading them in the
>> destination can work pretty naturally without much overhead.
>>     VFIO device data, on the other hand, is just an opaque stream of bytes
>> from QEMU point of view. This means that if we break this data to "packets"
>> and send them over multiple channels, we must preserve the order by which
>> this data was
>>     originally read from the device and write the data in the same order to
>> the destination device.
>>     I am wondering if the overhead of maintaining such order may hurt
>> performance, making it not worthwhile.
> Indeed, it seems to me VFIO migration is based on a streaming model where
> there's no easy way to index a chunk of data.

Yes, you can see it here as well: 
https://elixir.bootlin.com/linux/v6.8-rc2/source/include/uapi/linux/vfio.h#L1039

>
> Is there any background on how that kernel interface was designed?  It
> seems pretty unfriendly to concurrency already: even if multiple devices
> can migrate concurrently, each single device can already contain GBs of
> data as you said, which is pretty common here.  I'm a bit surprised to see
> that the kernel interface is designed in this way for such a device.

Not that I know of. There has been a pretty big discussion about the 
uAPI back then when it was introduced, but not something formal.
However, I don't think having a few GBs of device data is the common 
case for VFIO devices, I just pointed out the extreme cases.

> I was wondering the possibility of whether VFIO can provide data chunks
> with indexes just like RAM (which is represented in ramblock offsets).

I am not sure this would be feasible, as it will involve major changes 
to the uAPI and for the devices.
But if that's something you wish to explore I can ask around and see if 
it's a hard no go.

>> 2. As I mentioned above, the main motivation for separate VFIO migration
>> channel/thread, as I see today, is to allow parallel migration of VFIO
>> devices.
>>     AFAIU multifd, as it is today, doesn't provide such parallelism (i.e., in
>> the complete pre-copy phase each device, be it RAM or VFIO, will fully send
>> its data over the multifd threads and only after finishing will the next
>> device send its data).
> Indeed. That's actually an issue not only to VFIO but also to migration in
> general: we can't migrate device states concurrently, and multifd is out of
> the picture here so far, but maybe there's chance.
>
> Consider huge VMs where there can be already ~500 vCPUs, each need their
> own get()/put() of CPU states from/to KVM.  It'll be nice if we can do this
> in concurrent threads too.  Here VFIO is one of the devices that will also
> benefit from such a design, and greatly.

Interesting, do you know how much time migrating these vCPUs take?

> I added a todo in our wiki for this, which I see it a general improvement,
> and hopefully someone can look into this:
>
> https://wiki.qemu.org/ToDo/LiveMigration#Device_state_concurrency
>
> I hope VFIO can consider resolving this as a generic issue, rather than
> providing its own solution.
>
>> This is just what came to mind. Maybe we can think this more thoroughly and
>> see if it could work somehow, now or in the future.
>> However, I think making the multifd threads generic so they can send any
>> kind of data is a good thing in general, regardless of VFIO.
> Right.
>
> In general, having a VFIO separate channel may solve the immediate issue,
> but it may still won't solve all, meanwhile it may introduce the first
> example of using completely separate channel that migration won't easily
> manage itself, which IMHO can cause migration much harder to maintain in
> the future.
>
> It may also in the future become some technical debt that VFIO will need to
> take even if such a solution merged, because VFIO could have its own model
> of handling a few similar problems that migration has.
>
> I hope there's some way out that we can work together to improve the
> framework, providing a clean approach and consider for the long terms.

I understand your concern, and I hope as well we can work together 
towards a proper and maintainable solution.
Even if we don't get VFIO to use the multifd framework directly, maybe 
adding common APIs would be good enough.
For example, take this series of adding a common API to create migration 
channels.
I also saw you and Fabiano have been talking about a thread-pool model 
to replace the multifd threads. Maybe we can use such scheme also for 
VFIO and even for the vCPUs case you mentioned above, each component 
stating how many threads it needs and creating a big pool for all 
migration clients.


