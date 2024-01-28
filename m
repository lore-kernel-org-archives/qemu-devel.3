Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F009BC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU7P9-0002dh-O4; Sun, 28 Jan 2024 10:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rU7P8-0002dZ-9F
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 10:49:06 -0500
Received: from mail-dm3nam02on2053.outbound.protection.outlook.com
 ([40.107.95.53] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rU7P6-0004Im-2j
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 10:49:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv7tT1FPM4N33eXzCAuH0qxUZfuQQU5Itpwz9xmLFWKWt3cvIXJ7jpu3n+BG9YW/aF11Et7TlWSADvEhayV3vhBxlOocPnDWUIR4YvSwekFOgOQs2R/etxeNEVizeTvOUuwSoDhgxf3MSTrjXs3qQQA8gqkmVbE5D0C7Yk/gStrFF8DpIC+osmTmUlQ+eOx4WRNSZRW96e8EmdADnR1Gd13ZNMu41NbNBnnFTPhYtCUAWchKmP0jS6F8Q4ZfKd4vQKh/y+f3PGxVDLHiOe9e770+H+5gmOJ+WYUtsRRE36g7fDjqH754CNhwB8chvstuYfm3qJs22zwM8nSa5B+kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv0f0cpegR2r7S9RCUQEsqz6kpJaOHmBGMqtANkw5C4=;
 b=V5a3GNun1eJJv1NMtAsQeaH4s5j01FXoIMxgs1FqIXqaMWCImUFcskZ/ITwUrFRvexTLvAuzeR3BMaW7c/r7sCGqdFtJsyzFbGhxPfgqoBMMd7eYAhcgU/m4WpwgTfcZRBgrq35MfmjotYUSpvzJuNiCZyx0TcLHirEtwdXJck6frX2OATK0p5oTfrKGHvEn16pUfmbVFXApa6oftMNF6sP/eztTUDo/UIXyWvtSzD+zyGuBjePIFg/2Xh+S8r4heoWGP38kurG1xIYbY4DwKs+O1X7mxAcFRdabPTpj4gRU6Iu29EccF7Hz1OQG+tUNxLMNYZ9zJ01QZGyZ9FWq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv0f0cpegR2r7S9RCUQEsqz6kpJaOHmBGMqtANkw5C4=;
 b=Amapv3A0Hy+XAWyhF3DmX4sreHKihzyCJg86kaEhPUe12O+eEifDUdcQOLiVE/MWgDTrfnjNcfEckajcCdmzPZ0NrtcolCqZxsvZH8CpCCC983BVpg1dNl4m5Qyn63iTiQY+zbhimXjntZeCq1jZLJrwdCraj0Dk0wkICzVhzhWh2r0UmJ3CVMDYmbW4820KOUqh7ESeHPYkLpP7F8Pl9JmGDkI2bqKSOa1zZPeVLQ585e63GZcrP2Brdoc9ht8y/UQIyE75H2i+76EaqIN8KXOI6ooA0I9W5jBKCKn5gMRbd3njn6OEKBTcUgKubAhh0KT6FwYo76UatjNe65tyow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 15:43:57 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 15:43:57 +0000
Message-ID: <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com>
Date: Sun, 28 Jan 2024 17:43:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87a5otw2ps.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3890e384-254d-4905-b86f-08dc2017f066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzRN24aqZOOujL28PPQzF0ifskrNr9YktDvAG05rkDD7XEYFXJM94AuryUxqD6My0izkVf2YQq22PHTUMb/7QVCrdaBZJSOet3RtrivtsTRugaVdJRhaz+xr5Z3zStwMumeCp9DlkLRXtp8fzF4iP2g7YlWMSZpPpXWX/bMZHWfA5fXoFbvQXdtyu/fYWOtLK0ByUHnMdUIub2AyJMMAwLE0rxPv2Toqsily2to/jdZdvcAIHExRsZv2IlAkCL7AK+bgWuG4PjzzRb2RcxJY+AF8Yc3K2JX16x/vZ3Bntvhi5tJiAn50fl2mi41KFZIkkTRTDJLDFAlr5C1oodV0wq5y/VgLHkWqflWMh/CA7oVIoqG2Z+Qa/wygUmjvz9lInaQvOPIr0Kinq/duh1GZk/tcnZQ9ptVK38fMon987+5ZtzrEhd58qVwD633/0cG4WI8ESgcJ2WZNA1N7sQZoUuZ5jAiVt2tVHMchKVyG0UD+f/0DK5j0zmkcxtfzCnVINjD1RBWB7G5PdVi2rjh8//h5LXJVp6HngOTJu4j4D84dis7cdaEud4YABANx4qmNSjzDHb7Aw9hXfL0b3k2wZbUFZ3WD1aid/2nhfOnEpLIpq7Vrte2GVeAf3NXfuGKfnshh+h2pF/lXyEVijicXUQc2VVUeUvMjcWi4fHxfC2yQJFa6n+6a/e6qNB4MOUqV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6512007)(2616005)(38100700002)(26005)(8676002)(8936002)(5660300002)(4326008)(2906002)(478600001)(966005)(6486002)(6506007)(53546011)(66476007)(66556008)(66946007)(6666004)(316002)(41300700001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1iSDI3Uk5Ddzdxc0ZrR0Vpcnpzd3d5OXJGZktzNHdTV2xWZlBWazM1bjMv?=
 =?utf-8?B?WlBtcFBIa09TaU1uR0ZWZUNwQkw3UjRDNlBtdFJuSWtjSEZveVVHVWRxdjhJ?=
 =?utf-8?B?OWtrZzR5NWtQYjdKNFBjYU9JTmVQRVZPZ0MxUmJJN3dxU1RINFNGUTNVSDlM?=
 =?utf-8?B?MFVsbEZlYU5UQnEwOExldGhsa2psaVVubngweEJocnZCNFo3K0dOajhDYWhz?=
 =?utf-8?B?bExjZW1CQUdENjRIRStIeWFqWlA3Vi9KQWZ2VW9EeS93WmxYR2R0aE5CSnc3?=
 =?utf-8?B?b2RTV09UTTl5d2hEcWp0T3VWelNpcU5iTjhvSnlkNnk4dHhvSGtNOUhPRzhN?=
 =?utf-8?B?R3lPd1RBR1NDaEFBVnZsRXpUS3k2dXMxK0NreHorV0tycmNPQzB6V0xJVUJQ?=
 =?utf-8?B?eFgzdFpUZE1FZzlkN21YZThNTkdkQkNWZk12dVdkeE5pdzdOdlJyQ2dTRWZ1?=
 =?utf-8?B?czVoMFk1ajlld09ES05haWplQnZmVzd3OVk0aGZpQktKYkYzbkJic2czbC8x?=
 =?utf-8?B?dWdqTGQwSXFWWUYzOExRbVJUUThpVjYzWU1PVlF2VEpCc1NWb0hpQlJMWW5Z?=
 =?utf-8?B?QUppU0lWOGxBNCtDc3RpTWVZdkJWV0kvaEpUZ2R0MURDRnM5cWJUN0hVTm1t?=
 =?utf-8?B?VktzdldNQ0RrVzMyLzVwQ0Y3YWc3Yk9iMGRUdzVIMlJQQVJodnZlQ3liWUs4?=
 =?utf-8?B?VnhIWTY4dy84L1oySHFQL3NPQVpmbWpLdFIrbGFkcHpaTkZGRVl6N1Zpd2J0?=
 =?utf-8?B?dzIzWU5pNnpUclFVZllXeGFnOGtyVHhzYmZaQVVTQ0RUMmpkZ3NNU29VTkFQ?=
 =?utf-8?B?OWsyLzdLZnc0RXhjTlhzTWI2cGoxOUttRzViSHkzYkJBdUZWQ0IraXYyVXYw?=
 =?utf-8?B?NDNGWW5vWnBDSXQ2b0JUdmFHMDRVUEZDN3J1NDNvRGY1RVlvNXZZNjllWTNL?=
 =?utf-8?B?bVRuMFpuOExGQkE0UHROVk0wUGpyZ1N5YW1qOFRDNExldVZ0U3JtYlI2eURn?=
 =?utf-8?B?cU1XMzMwQ3VVYXNkMWRkY0tLMEU3SGJZb29mNm52aHBCbWZxWDVTYmRRU2VQ?=
 =?utf-8?B?RWRTRTB6cHRFNDNFYlI0Vm1CMGZOTzBtZVhML3UyNkpnSnc0cW9oUTVTZEk3?=
 =?utf-8?B?ZGIxS3Z1L3d4QUtjQUgvdCtUWWpvU0dYSkl1MndDNzhkRGU0dXFyeGpqOVJ4?=
 =?utf-8?B?dlRNMS9KcUZaNGp5REk1NCsyZ01BcXlvZUNKVWh2SFBPeUI2SVdvUDF2dHFv?=
 =?utf-8?B?c0grazdxcXF5YnFncTdoRHp2T0hzOExqTG5LUWFMNFAzYlJDV1UvbDA1ZERD?=
 =?utf-8?B?UHVjS2pFdFNhV3psYW1xZFloQThyc2hTLzJybFcvdVFjc2FLVFN1VUdpTk9w?=
 =?utf-8?B?OTdOcndsZmRud1V0NXJCVzJFNGM5bFJGSFA4YjZ2dEF2VmJ1R1FYcEF3ZWg3?=
 =?utf-8?B?aXdadW4yNFV0ZjhyTFpRaUNoaFZXUzBWWmM4UUloU3ZKMkYyQ2xDZ3IrNTFF?=
 =?utf-8?B?djBON2NFbGg5M1VXWU53b0ZoVmpmNjh6Q3Z2UmZWYW5NcndSTzVxRk5hb20z?=
 =?utf-8?B?QnczTkZ3MFc0SGE2N0x5ZklVbkladEdFMVpnVzJzbEx2TnhVNTFnZ1ZlTE5F?=
 =?utf-8?B?TzF5ckFwRkRoYmdKVmNJV2NkQm4rVitSZCs0M3hlZVBMVmhTcEljNTk2ai9i?=
 =?utf-8?B?Zk5ucDNxaXdWYzlGUDRjNUZwdmgxQWVSVmxpYUFWcndvVXorNVVYdTFZWFgy?=
 =?utf-8?B?Y3lZRDB4ek1hcjUyTzBLeFdaZlU1Y0NnUzViWjN2OWhCWVZRWDIwVDRYcXhj?=
 =?utf-8?B?bzU3Y1dZRlJDQS9UdXFGMTNMSmVlWktyaVZ5Qnhyc0MzdlBzNk5xVktRdzE4?=
 =?utf-8?B?b3NodlJ2cTc1N240NXFhOURZWmxKckUzTkI4Q05RWFVoMUZla0dVdzB6RlJV?=
 =?utf-8?B?RTVOMGVWRWNhZVFvNVpEd3ZnekM5T2wwUlFrSFJRdW1RYksrdkxuRzVDTW1D?=
 =?utf-8?B?RnFOZjJFL2hsVUNRNkJTdnBZVUZ5UlNYVXdINmhhTGN5SkZmbDN2dmVScE9Q?=
 =?utf-8?B?Sm5tUWxLcllZWHljYkZMV25xUXU5dFI5L3c1UUUyY2lKZGFueVZOc0owaytl?=
 =?utf-8?Q?3RqBf3tvYafgoLELXLZyta1br?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3890e384-254d-4905-b86f-08dc2017f066
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 15:43:57.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9OJbfyBUlowNLM1GWgokRK0HomDOpaSI03z8jBB0CkptYWQjrVrJNtM6rfz4g6hEm6PPJa+jVahDIgKEQqMqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
Received-SPF: softfail client-ip=40.107.95.53; envelope-from=avihaih@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 25/01/2024 22:57, Fabiano Rosas wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> The commit in the fixes line moved multifd thread creation to a
>> different location, but forgot to move the p->running = true assignment
>> as well. Thus, p->running is set to true before multifd thread is
>> actually created.
>>
>> p->running is used in multifd_save_cleanup() to decide whether to join
>> the multifd thread or not.
>>
>> With TLS, an error in multifd_tls_channel_connect() can lead to a
>> segmentation fault because p->running is true but p->thread is never
>> initialized, so multifd_save_cleanup() tries to join an uninitialized
>> thread.
>>
>> Fix it by moving p->running = true assignment right after multifd thread
>> creation. Also move qio_channel_set_delay() to there, as this is where
>> it used to be originally.
>>
>> Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Just for context, I haven't looked at this patch yet, but we were
> planning to remove p->running altogether:
>
> https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de

Thanks for putting me in the picture.
I see that there has been a discussion about the multifd 
creation/treadown flow.
In light of this discussion, I can already see a few problems in my 
series that I didn't notice before (such as the TLS handshake thread leak).
The thread you mentioned here and some of my patches point out some 
problems in multifd creation/treardown. I guess we can discuss it and 
see what's the best way to solve them.

Regarding this patch, your solution indeed solves the bug that this 
patch addresses, so maybe this could be dropped (or only noted in your 
patch).

Maybe I should also put you (and Peter) in context for this whole series 
-- I am writing it as preparation for adding a separate migration 
channel for VFIO device migration, so VFIO devices could be migrated in 
parallel.
So this series tries to lay down some foundations to facilitate it.


