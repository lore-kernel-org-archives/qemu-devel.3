Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC4CC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQd8-0001sw-RP; Mon, 29 Jan 2024 07:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUQd6-0001sZ-EV
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:20:48 -0500
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rUQd3-00059v-Ts
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:20:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6GrA5CV3bwNk9ebaOH3jl0G9NU0yy58rNRjGyTh9gljlY//QQPICsI+zlce7EjrydtF/6P+GLbCl5nXQSx9RbcRvZC9DWc2GPW1ocV5FvOidrav5FJFySkp1AugEDtVdtWjtjL8VVSDkxVezlcd8zs9NyKNsF0aGrGUZNOCRQQEEa8mWRB+N3fl46nazQKxqike1AUQR4doHMQfWYabgelqTqHTRSHJ397UwvOmw/1jcn6uifK1O3DuW2vYK6rnhsmuYn5rApC2zNx1lNG8d04KTmn6hp0aKI0dyJPoxCHyMsjgAJ2s51A49BjK7kzrAHxZ7IGdGrlR0qITzlLDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m92aVtRmE9spPV14nqSks7oNnesAqcLwdXeYsZyJw3Q=;
 b=ckgkRKFnWuCzTSt4/P2KEDtBaHxI8QisCNS76O0oWo+QktBsJKyr9+iX4DnS6/vq37Anwt/MrwuR4XMRltD97/sYkzRd1RkLSNu+nIxEKtzjS9EhqHwpWGs9Xek3p4wjMDwYxqTAYd7ZqZQVBMttYclg7+e42a2tUTQN5zI/EmdNzHKGXZEIdtK1+o4pbhW3ONc5i7hz581B03Vo4ifrx9mlahcwwxw7VAcLUpB1sixopzin6m2xNhtcRmi/RiHxM9h8eYUmTx6uwvyCYoD7EQaKd4LpkTDFbA7O50OYVKjZO8xibPpZRPIcOlH+1oQ7fFEIswBX7WgqNEjYwuHW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m92aVtRmE9spPV14nqSks7oNnesAqcLwdXeYsZyJw3Q=;
 b=gI5xZP8ZZxuRJfEPMIY8KSebbwP/suUN3YUXfvpp/pMNQRUWeDaytES8NoV1WI3uci05TkNxoRGlAgFXsJ5utuemWFcJiWhjH+CiZAibY6x1z6GfHnYZrjhEKty8HRekXpdlNAIfYs0WcGdcBcTV+Nokw29xs5Lz0IdUBJoDVpRReae7pLeTK1s//EIjnRUbFZ8cH/0yLfan7MsbprX9GdxiHJtrVIymINBRkm6Ualkizj+05tFTkke7Ybfon18Xok+cDxH3gyFEVXpVkkb+GovJ2CPXPMaEX99ntGN4uZFmsMZCqNYzJpIExFBKJ6YaD+fu5qjXhhujMIoIRcxAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:20:41 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:20:41 +0000
Message-ID: <0f75090d-bbe1-43cb-b649-a0880bc413c4@nvidia.com>
Date: Mon, 29 Jan 2024 14:20:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com> <Zbcm1nXzQ_r0eGG0@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zbcm1nXzQ_r0eGG0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: ead2779e-ec73-4af6-2991-08dc20c4b59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjGaPbwdvdgX6fjZa7grRpcRIo2sIR5VSrucXq8y5P3fa2HNzPB4O5ouUVG6nAllmOB1mhgvR17eGhPpLzcafdXnXTMPkw+rwhrUBR/RSTxJF4wH6d8/TN+ZyDlBBdgeomuE9aD0su7APoIXd7Qf4EqIb1ldO3tIwIKiK97Y6BHdUpyNRLdfaLFOBqQvmrKBNkNObvYTRtTyBLPZL4+I+aEMMcRtEl2OV77D0zn966w/p4/zf9A8+xEcro8B4+GuqhwDvHwB4lfAfb/k8BTAEw9ZvNq0B1IaEeBvBTYwiKT2BF3bAPWuf36Vr9Phg3SmHTJdk5pUvru6AmvIo7o68h5mTNXhamnBi+1AtCEWKVtlFc8f70e5H2f4lj8qG600gsvv2FNrUgYhS+kO9rxWBpi10pDv4G9uBS8TreEduVB8JDDn53XxH1AzFvnr1fbBGULELezadXXeTi+xxJealC6l3IM7yhKJwF8Ef8CTq9oEMknETmeAdL1SN4heOECzDCKq99T9XigzFWLgjwKkJ731W/uyx859t/tmf8jVfEu//ufNaPryCEzP21xWq1kWU16h0o3E27eZQ8SZVg8/zaxSYcp0H3RlG5TCHVbjV4R9V+mNZ9R7fKP9coUKodVAh2ZYMob7TF/VGLhfL4Cl0vYJwXTSne4xoP5FvxFdyz5imu4R+9JeF/WNb8ZYfJX8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(8676002)(66476007)(66946007)(66556008)(6916009)(4326008)(8936002)(316002)(83380400001)(26005)(31686004)(478600001)(6666004)(31696002)(38100700002)(6486002)(86362001)(2906002)(5660300002)(966005)(6506007)(6512007)(2616005)(53546011)(36756003)(41300700001)(66899024)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDljbzEzZVV3UmNUcE1mbjFQUXVrTlVaUVN2UzRWNHhXREZ0OHVqbXNSZlN4?=
 =?utf-8?B?ak90RmtlazM0Z1NzQXFpTVZmSHpjTTdyMzFqYVQ1Zk43bmFUQVNXRFJqY3py?=
 =?utf-8?B?Q0ZPVE1hc1VoNlU1RUd5Y3o2dXJMT2tVdlRNUnlMc085eXN1NzlFTjhCVk5i?=
 =?utf-8?B?aWU0WGxZbnZWbm9xeHVHQ1pnckZYYWs0NXFXVUN5MS9jK0lpcFRGZnRoeWxL?=
 =?utf-8?B?WGJSSmJ5bUxnRU9MRUtaRlV5ZkVzbi9JRGhHdDNoRURieTA2KytPNUNDNWxS?=
 =?utf-8?B?ajJlWFpwb25qOURvWGtDdWF5N242V1VSZ0xmOThDZ0pQNzVtNUE1SzVpd3Bh?=
 =?utf-8?B?cnBob3pwSVJ2OWl3bkdIQmY3V1pYaVAyajROb29Sd2pqMHBvZlY0QkhJTHJD?=
 =?utf-8?B?eTlaRGkza1VvNEh6YkxlRTFTR0RuSkdpUXh2ampEcjlyWll1WEk3ZFJWRkFW?=
 =?utf-8?B?UkpWN2Z5VlpPZW80WkZPUEd3bXl2d2ZlcGl0ZzRWUi9vMjhkNUQzeVpJT1My?=
 =?utf-8?B?SGhPVzhRRnIvNU5BWHRaMWplVkhBN0NxWHhkN1NMQWsyOE9EZTJMWmJXcnBM?=
 =?utf-8?B?ZytLbkx4YU9UVEVGWDRjdHdYOVNYOWhRZDRnNEMzdStWOEdIOXNhSnhBRmwv?=
 =?utf-8?B?ODgxYUpSdHJYWjc0TXpzVWE5UUpqc1BGbXFKdGwxSGs1L25YYW54OHdQVkxV?=
 =?utf-8?B?WUFTRUlNbG9zSmt5N0FZK3VLS3pqNU5tdXVJS3F1NDh6aHNyTkFoQVBpOXZP?=
 =?utf-8?B?Wm9naGUxZTdXM3ZuVHhsRVZqVFU3K2N5emcwQmRjNUdCa0QvTDFCY0F4WFJJ?=
 =?utf-8?B?UStrSkpSZmxzMEtKWDVoZkRqZy9uTHE5MHpTdk9zZUxvS1JkdGVjUWRuN1N5?=
 =?utf-8?B?YjNMWThiNVpOVlRwWVFMbEFIc0ZiRm1PL3MzbEpoNFh4ZjViMU5OUlRTeFAv?=
 =?utf-8?B?UmZONHRacjNuMXJKT2E1RnBlZ29zcFZQZjJaUks3aGhYMC9lamhmSEZJSWl4?=
 =?utf-8?B?QnJqNE9nb0hTakh2Wi9TMHBHMGlYVGNHUUJDR2NnVVpsZjN3SkxaNHJZM0p1?=
 =?utf-8?B?Q1JFNzdra1RWRFQ4aWoxemR4bEF6ZEZpc012SGlMcVVlYThCUDZPWXRodFRm?=
 =?utf-8?B?ZElDRHVEd0JNdDhzd2F5ZGMxejIzdEdMVGQzUVhaMTduQXRkYXpDbjQ5VHdC?=
 =?utf-8?B?MlVWQTN4WjJEUkJrYWczSzFhRksyV2J1V2lZbVFnamFVOGVXY0pSOU0wQ0cz?=
 =?utf-8?B?Mk1ZMUVEYm8vWlVuMDhOejlaNE1vcVJOR0l5dHdpRzEzUUpUaFZvczg5T1hN?=
 =?utf-8?B?OXVlVXNFTGVhdGFXTU0vRXdPa09LemdDRnh0RDRJaUxFSGlhM2lUUThNckZI?=
 =?utf-8?B?R1B1OHVobDlCQWlKd0RXT3p0ZHg4VWF2UFNMdVpWbkVBcUIyZzBCLy91NTVR?=
 =?utf-8?B?TGl5cnUxQUNBSmhwUUhZMWxuc1JQb2hXOEtYc2xRQkpMOCt3SC9BL3J2MDJG?=
 =?utf-8?B?ZDE0S2c1N05wa1ZLZnlkejlkWE5MTzg0Z2lZUXFmaWJyL2lhenhYcHFYRkhv?=
 =?utf-8?B?a2dCQU9rUUREQnNDQUo3YXFnbDNldlFYdTZKOEZYcml1bnFVREllWkFsT3JM?=
 =?utf-8?B?aEp4c3VxV2ZzTFVXb1VHMXEvOVF3RDk3NU9BL3RzZVNPSTJJL3hXa3lUSmdP?=
 =?utf-8?B?WGxrblhGa1NlUW4zb002Y3FpejdJdDBYMTRYZ1hnZUhJMHZIU1k2TElkZVhn?=
 =?utf-8?B?ZmplSnZocnRnRGhMU2dRTWhBSkpWVVBnbFk0N0ltK2trWDI2UVVvRnh6K3N2?=
 =?utf-8?B?ZGZZQ0xDa2E1cTI3a1k4MHpHdW1LcWszSXcrTG1hVWU1eFFJRGN6TTlhRFF3?=
 =?utf-8?B?NTQrZCtDRGVyQ1JtRE1GMjg0UFY3dWRsV1hxcFh5STJRenA1UXFSMTRBRmN6?=
 =?utf-8?B?MlVMSzR2SWFCY0VQdHpVMVF2TzVON1BzTitmZ1hrWkJoalhMVUhQYnZBWEdR?=
 =?utf-8?B?VVZvNGdIVEZZRnpPcExaNkYrZkw5VHFlQXZwZUFXNFVvdkNma2xiQnhudkhJ?=
 =?utf-8?B?RXhPT1BkbGVoeFFaSmkybmtuS3JXWDA4SEgreGpoNHNvTGpMZkZkOW8rNWt5?=
 =?utf-8?Q?5MIbGyT5afxzZO1mEV0Q85g/Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead2779e-ec73-4af6-2991-08dc20c4b59c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:20:41.4530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbFScsjyiMrFV4iTejF9J8iNL1Sz49woy9x9MQZ1sqi/gWQ1ayXGWMpMJTUu74BmdvDOTlI4BUfziHhLmMfg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
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


On 29/01/2024 6:17, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
>> On 25/01/2024 22:57, Fabiano Rosas wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Avihai Horon <avihaih@nvidia.com> writes:
>>>
>>>> The commit in the fixes line moved multifd thread creation to a
>>>> different location, but forgot to move the p->running = true assignment
>>>> as well. Thus, p->running is set to true before multifd thread is
>>>> actually created.
>>>>
>>>> p->running is used in multifd_save_cleanup() to decide whether to join
>>>> the multifd thread or not.
>>>>
>>>> With TLS, an error in multifd_tls_channel_connect() can lead to a
>>>> segmentation fault because p->running is true but p->thread is never
>>>> initialized, so multifd_save_cleanup() tries to join an uninitialized
>>>> thread.
>>>>
>>>> Fix it by moving p->running = true assignment right after multifd thread
>>>> creation. Also move qio_channel_set_delay() to there, as this is where
>>>> it used to be originally.
>>>>
>>>> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Just for context, I haven't looked at this patch yet, but we were
>>> planning to remove p->running altogether:
>>>
>>> https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
>> Thanks for putting me in the picture.
>> I see that there has been a discussion about the multifd creation/treadown
>> flow.
>> In light of this discussion, I can already see a few problems in my series
>> that I didn't notice before (such as the TLS handshake thread leak).
>> The thread you mentioned here and some of my patches point out some problems
>> in multifd creation/treardown. I guess we can discuss it and see what's the
>> best way to solve them.
>>
>> Regarding this patch, your solution indeed solves the bug that this patch
>> addresses, so maybe this could be dropped (or only noted in your patch).
>>
>> Maybe I should also put you (and Peter) in context for this whole series --
>> I am writing it as preparation for adding a separate migration channel for
>> VFIO device migration, so VFIO devices could be migrated in parallel.
>> So this series tries to lay down some foundations to facilitate it.
> Avihai, is the throughput the only reason that VFIO would like to have a
> separate channel?

Actually, the main reason is to be able to send and load multiple VFIO 
devices data in parallel.
For example, today if we have three VFIO devices, they are migrated 
sequentially one after another.
This particularly hurts during the complete pre-copy phase (downtime), 
as loading the VFIO data in destination involves FW interaction and 
resource allocation, which takes time and simply blocks the other 
devices from sending and loading their data.
Providing a separate channel and thread for each VIFO device solves this 
problem and ideally reduces the VFIO contribution to downtime from 
sum{VFIO device #1, ..., VFIO device #N} to max{VFIO device #1, ..., 
VFIO device #N}.

>
> I'm wondering if we can also use multifd threads to send vfio data at some
> point.  Now multifd indeed is closely bound to ram pages but maybe it'll
> change in the near future to take any load?
>
> Multifd is for solving the throughput issue already. If vfio has the same
> goal, IMHO it'll be good to keep them using the same thread model, instead
> of managing different threads in different places.  With that, any user
> setting (for example, multifd-n-threads) will naturally apply to all
> components, rather than relying on yet-another vfio-migration-threads-num
> parameter.

Frankly, I didn't really put much attention to the throughput factor, 
and my plan is to introduce only a single thread per device.
VFIO devices may have many GBs of data to migrate (e.g., vGPUs) and even 
mlx5 VFs can have a few GBs of data.
So what you are saying here is interesting, although I didn't test such 
scenario to see the actual benefit.

I am trying to think if/how this could work and I have a few concerns:
1. RAM is made of fixed-positioned pages that can be randomly 
read/written, so sending these pages over multiple channels and loading 
them in the destination can work pretty naturally without much overhead.
    VFIO device data, on the other hand, is just an opaque stream of 
bytes from QEMU point of view. This means that if we break this data to 
"packets" and send them over multiple channels, we must preserve the 
order by which this data was
    originally read from the device and write the data in the same order 
to the destination device.
    I am wondering if the overhead of maintaining such order may hurt 
performance, making it not worthwhile.

2. As I mentioned above, the main motivation for separate VFIO migration 
channel/thread, as I see today, is to allow parallel migration of VFIO 
devices.
    AFAIU multifd, as it is today, doesn't provide such parallelism 
(i.e., in the complete pre-copy phase each device, be it RAM or VFIO, 
will fully send its data over the multifd threads and only after 
finishing will the next device send its data).

This is just what came to mind. Maybe we can think this more thoroughly 
and see if it could work somehow, now or in the future.
However, I think making the multifd threads generic so they can send any 
kind of data is a good thing in general, regardless of VFIO.


