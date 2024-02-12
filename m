Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB8C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRud-0002pF-OD; Mon, 12 Feb 2024 03:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZRub-0002oz-Md
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:43:37 -0500
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZRuZ-0005hb-UX
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:43:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3p7YzvMk578lJD9+kY6+wGKFXV3FT+Ik5pe11XRhbCc2ozxpwBxeOxjszo8MiXRR9iAUoqwNjPcVfy3DJItp/owSWvTA3NAQWcR5XHUOvxlsd3TlfUqhwqyhV3LtgHe4vTmOEVZGQXnneEoTFcNekE7yUnSRy6KBrh0dn9+Rxmd1hxYk8FL1p3BETHtY4kkLx01ftevuOaPDrGMMfuZ0vrcN5ie6cYljUvtmfOittCsWrdHAGCka568rKCYl/MopzGaJKqVAQEYukxwwMB/rHZduvVIkgCbrOIb5F6CZX/vSTSGJD9uSMicuLVpCYPIcN9+JNLMhMnq2IOxghRkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG789Whs8PavrORrhynMX6NEmGDF05sperUTnXBLrW0=;
 b=FCid8lJetr9VUTOg+6HGOmeQzJhF/+F4uc80ROLZkxBO0mRQ67Mc3zP4ZN3DBMlL7nnbqtTU8TZWREZJbvT09RkMSoraMzh6PgPIgD7lDlJtAU/GJ2kXErKvnVKvWYbWSLceSBAjvWAeqMnwG4K592N0VDlPKXDY/3v+uMVjLrakKjv4VtcCXTOn8Fx/oUUWzW1WadOJikdvkxXV1VvCqmypQKeMB643ID1lGL/eYnV3S5MaE6QW9fjC3h3qIJm5OVMezU5mX6OFI3rFZrwfEuyMeiIfwZ9tlHga0Yr0k+t+TW74AL6AhkH4VmIsHsZ5Ts46B0idEBwS367iQ44ZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG789Whs8PavrORrhynMX6NEmGDF05sperUTnXBLrW0=;
 b=dTeQuCXL1f5S1NwtVvT1KV2m31zstdgPCRGZCn+9NHRyApEIzkId5pIu0LLXoHCNplFU9VCw4j/r6TdRGx/pyR7QiSK7jNNC3PTYULFcWkvZEopKFMGu3osfgy9iT+fnOLBT/8u59kl8ZDXQLEuV/0ETHV0kIyo/CHXQpqLQyLEvxK3EUWQAjGLN/IZNSikXCSQ7AvG8L2QbP2r/24f6gftDId4SvdvjiQ9/WAbLMpmQW88foOdbYKpZuTyBjfPpxgfeWvJ5J94Ba1gvJWqku0Fh1ykQV9tC31z0BRSjG76KKXnUeU3JgXdXiiGBU2+ZzhCLE9Vw2I3MlBBh+fWN4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 12 Feb
 2024 08:43:31 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 08:43:31 +0000
Message-ID: <8343df56-d6a4-42e7-9140-9610fd140e9d@nvidia.com>
Date: Mon, 12 Feb 2024 10:43:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] memory: Add Error** argument to .log_global*()
 handlers
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-4-clg@redhat.com> <ZcRrJIrInupeanqB@x1n>
 <c9c45081-4874-4c89-b283-1b19d21ee670@redhat.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <c9c45081-4874-4c89-b283-1b19d21ee670@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0453.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ae1007-8790-48ef-c4af-08dc2ba6b109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WS1G7N4HyY30sHy+6uWcM7wxb0x6fM0ZXoK+cOT4dZh9OQ+YbvzPWNKx4KojQDC4p4DFEf6Gbuzmdbx7DPMHnieFDLNTOhJDdPer+m+/mSQS5EWfbTbJXup4yPFIv9QjQ3uAyz4oM44ieFS8P/YcKQB+SWni0shmARNknzysgfQKDCbGSQ/UivdS4+hjWFVLhpx8WoeEv5M3/4uivX0xmGee02muRCFBDC1WhpCQzrgVe5u1WI4px+0AHJoO/d8xGmzGiAD5cKi4V3BdKQwAuZb65tZxfHiLSoOeyCl/6bB01d5CeX3D/ZrC2nzpE356jS/+UF23eoOrvPNSub5XSq51if8REvPTEqdi1aRNFZHDTmyzmGF2x/zaW42u7T222wG8CG01GPs2qt1ErjJlpEa68M0ifqso8b1l4Qgnfd6pNcW1WusRaf4Oj+6ZGd4CdP+KwgoziFJrr2aIoGzNQhLsgTEX89TEJmWjkrWOV+tbhu8lQpNmFhkrVhjr4PI+wc3wkXFAfJiM8fx1y/aa+94rDlitqBEqfjaHHxk8yJOwhFuvQw9N+wZpiaCXfP8J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(31686004)(36756003)(6486002)(2906002)(478600001)(53546011)(4326008)(66476007)(66574015)(8676002)(7416002)(2616005)(41300700001)(31696002)(6512007)(26005)(66946007)(54906003)(316002)(8936002)(6666004)(66556008)(6506007)(83380400001)(38100700002)(5660300002)(86362001)(110136005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nllyd1NRWlNENlc2Zy9HNmhXS1RuTE9sRVpxM3ZkVUx3NHgvMDdBOTR4RlJv?=
 =?utf-8?B?WHNBMUV1Q3hDM2ZsTFVSa1ZnWFBxM0c2dEY1ODREYXBwdGtzWitmZXZoeFU1?=
 =?utf-8?B?OURPZTcvWE5wZUNWTlhuWmxWeVFFcUFqVlFYakplbkN4WHlrWTJwVUVLQytB?=
 =?utf-8?B?Z1NFVjQzUWlLNCtPaC9PVjVEck1qK2R4aWRxOWNoSWdIZVQzckp2aEkxTzFr?=
 =?utf-8?B?OHZBUHZqMklMWTJtS1lPaEc2SDF2MHBpRW42R1YzcDhocXBwc1IyS0treitB?=
 =?utf-8?B?NW9RUmh2L3lKbThOZmJVL09aUEl4bzdMeFlWK1FtOTY1QW9ORWErcWM4OE51?=
 =?utf-8?B?TVdyUnh6RnZCRUlwL3haQk9WdHRaWDBaYVM4cUhTYjg5NEFFQjRQSVR2a3lP?=
 =?utf-8?B?cGVpVW1PKzhPZGNzVzVQKzRqS2JLLzV1UVZQS0JYQi9ueENOUFJOdFNCRDUv?=
 =?utf-8?B?U1kxTHZ4aXlzcTFsNW5nZ2UxeTJTZzZFVFllREdkSSswdUhLNzZvR3h0Mkt0?=
 =?utf-8?B?cGlyYzFHRzYzbTNiTTljZm1XcjQ3WW9SSm9ZbVh3VDEwUExyalBBcG9RdTEv?=
 =?utf-8?B?RkJJclR0MmN2VDJCN0wvQkp4ZFJ6Y0o2VzN1TXEzdzU0N0RlN1NnSi9USWVJ?=
 =?utf-8?B?VUlGZ3dweURtMDNKRExMbnBneGF4WmNNejNZNjhHZnNKVm4weTR3SkhJeWRi?=
 =?utf-8?B?TWdsWmxNbEFFb2hHb2tzemc0cHljNE1idjlqT1NRcTcyOTVnTmJhWkpNcWlt?=
 =?utf-8?B?TUZwanFrTWMxYWxMZ1dQS3RwdzJyWSsxc0xFWmhsQW9IQXRvQnMvdWZXRkkv?=
 =?utf-8?B?ZEEwa3pDNk02Unl6WmpjNXovRWdRVlV0NzRzOEdHTG8yZ3RJQmV3MVZOOUZK?=
 =?utf-8?B?RkVkVnRIRkVkeVVOaW5lYVRxSTV5M3VhYXd3WmxZZU9sZjFBRXJ5c3VIZEQr?=
 =?utf-8?B?TGxyV3p2dFdLemVwOSt0N0hwczhHRTFUN1d2ZEhTL1RkMmVBdk5Fc29oMG5Q?=
 =?utf-8?B?ajgvV1ZXR2pUaFAxTzZpdERuTEJZMDRoT0cwbzZrQlA3Zm1qY3FnTWQ4aHp3?=
 =?utf-8?B?NG9Ca3QyOTJQVnJEcG5WendJWXpMMjI1amFOV1dIa1lzZTdhVHVjdS9RdXFW?=
 =?utf-8?B?YWZGVVc5MDlycmV1NER5UG5yQnhicGxTT2c2RC9RSitJQXQzRUpKdkVvOTRn?=
 =?utf-8?B?QTJZWG03eDMyQ2ZKSjNvRlBBb0lBQTlyZEl0eG1ZOUlYSHF3c2Z4N1Y3N3Iw?=
 =?utf-8?B?QkNLdXlEcjFORTl5VGdyV215VTJmaDY5K0hHWFcvSFNkdTVBaGNJckgwN1Bn?=
 =?utf-8?B?ZTl5cWVKOXRKN2lWblhiM3I4WnRETTFxNUxNSDVrcHpsQUlnUFVyM0Z6Q3lw?=
 =?utf-8?B?c2swam1jVDFZSytleXB4N3YwbWRhRlR0SmQ2WTlERmZaN3BzaFBYZE5UekdY?=
 =?utf-8?B?VVcwaHJGTnZXSjNrb3VUcURXZFQxYitmQXRzZFBIcE1nNFB3ZzI4TXpxYjdU?=
 =?utf-8?B?M015V2t1ME1sUFJabHY2K0c4U1lZQnJ6ZFpXaXJDTmNuZ21YT28vYzNBOVJH?=
 =?utf-8?B?NGF3N29jYXZzWWNGcGJJUDJCa1p6a3NMeWY1UFhYMHo0VDVkOSttbCtjTDdz?=
 =?utf-8?B?SjY4ODBqckROY2dXSlNwVEpoclFwRS8yYW5zY1FxZ0F0akpoUzZLZ1RhM3NL?=
 =?utf-8?B?TnR3N3R5YlI4RU9Celp1Y0RFcjJhT3RDQkJlc3pCamRBWHA1UHYzQmtwT3U2?=
 =?utf-8?B?eUNMOWhzSFpoNmRmWFppWmZtd2Y4MGlsZVNKRkVOSkZ2dXYzRHJncVpoV1dV?=
 =?utf-8?B?U3ZIQVNIWXZvR3dZY21Ma25hbFp0bVIzZTRlT0VtNTBxOWc2aHRJVDVJOHU2?=
 =?utf-8?B?WjRyTFpXUzk5dFg2ZEkrVFgwb1g5R05nVXpwZTRMaVZ4K0RhL2duT0daNzJ0?=
 =?utf-8?B?RWxjdUkySmc2SGIvTnAzM1R3ZnNaWmduWm1nZ0dHWVRvRk00RWk5RmsxOFpx?=
 =?utf-8?B?OXRPbnFnS2k5aUFncEJMVjFIb2RHUTZxSHlNaXprak9tdHJFdm90Tk8zSnEr?=
 =?utf-8?B?c0dFdXlzZlEvUEd1WE5zeUN1OGtMQjZFS1FheU45L0J5bUtGa1M5SWI4MVN0?=
 =?utf-8?Q?5qnQwjwQRPp9qrR0GPqzCN84j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ae1007-8790-48ef-c4af-08dc2ba6b109
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 08:43:31.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQz8CGJf38Bmsk/AJl5oJJ+HXlIAMkjaSafmZRcII2i8dqnXuuz1qwvywAwNeQD8YK0U55RtIgJjQtJVC9V3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
Received-SPF: softfail client-ip=2a01:111:f403:240a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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

Hi Cedric,

On 09/02/2024 12:14, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/8/24 06:48, Peter Xu wrote:
>> On Wed, Feb 07, 2024 at 02:33:36PM +0100, Cédric Le Goater wrote:
>>> @@ -2936,14 +2940,14 @@ void memory_global_dirty_log_start(unsigned 
>>> int flags)
>>>       trace_global_dirty_changed(global_dirty_tracking);
>>>
>>>       if (!old_flags) {
>>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward, errp);
>>>           memory_region_transaction_begin();
>>>           memory_region_update_pending = true;
>>>           memory_region_transaction_commit();
>>>       }
>>>   }
>>>
>>> -static void memory_global_dirty_log_do_stop(unsigned int flags)
>>> +static void memory_global_dirty_log_do_stop(unsigned int flags, 
>>> Error **errp)
>>>   {
>>>       assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>>>       assert((global_dirty_tracking & flags) == flags);
>>> @@ -2955,7 +2959,7 @@ static void 
>>> memory_global_dirty_log_do_stop(unsigned int flags)
>>>           memory_region_transaction_begin();
>>>           memory_region_update_pending = true;
>>>           memory_region_transaction_commit();
>>> -        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
>>> +        MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse, errp);
>>>       }
>>>   }
>>
>> I'm a little bit surprised to see that MEMORY_LISTENER_CALL_GLOBAL()
>> already allows >2 args, with the ability to conditionally pass over errp
>> with such oneliner change; even if all callers were only using 2 args
>> before this patch..
> yes. The proposal takes the easy path.
>
> Should we change all memory listener global handlers :
>
>   begin
>   commit
>   log_global_after_sync
>   log_global_start
>   log_global_stop
>
> to take an extra Error **errp argument ?
>
> I think we should distinguish begin + commit handlers from the 
> log_global_*
> with a new macro. In which case, we could also change the handler to 
> return
> a bool and fail at the first error in MEMORY_LISTENER_CALL_GLOBAL(...).

I think we must fail at first error in any case. Otherwise, if two 
handlers error and call error_setg() with errp, the second handler will 
assert IIUC.


