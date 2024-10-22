Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34B0D1CDCA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BQU-0008N4-7k; Tue, 22 Oct 2024 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3BQR-0008C1-CI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:43:39 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com
 ([40.107.236.60] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t3BQP-0001H4-ES
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:43:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx6kisjsT+NV664mRMqneCJLjnWio7gUEkpML4okurj40nKOaOtPtoOaugNhV3I8GE9BlVZMADs8GDTxCKaAllXuqpxIMCb6/4U8YnOchKFWN0KYUBYLtyH/WtQdB6aTM6IhOSGluWmMKJWpKT8527d8xH7kcp6Ig8j8AxaMN3rnktUE03p8AI6n04a3whSA3FJG2XuZsTd24KWjDTumJ7YCE/rg15jY44XZ3Feu24bSxy7VQ0yrCkSag6HXTAFn++r+7iOTt3inRrYU1pRhYDOo+5rLXngY1W5U3VA8NsbHFrAypQYW92/Mpg8IW5zdUEPfld/CcGWNxbZOhJWTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxJN8BEMkIqs4VRH/xdm8eZvkIas86IRbDdGAeUJNz8=;
 b=OkYz1wPsx37VQGHvhaJQ7B+64aXeiT0PLdXfdIhDRxIoK71dWVlx1/vvoiygM+M+V2q3uZw9dCwvvKQcQuCbB2pGscNNaC6jnke4E8vUhftnUiXD+xOngcOMdRtKJpzeHDebfEXzr09B9Ff/SGd281BX6Sxc9L2mfzppQPBG5sim7S62j6htncemoatzVYhyET7N9KsowyZPUJtD70Ah8Ij9gKntA15xYDlPkTObDzUbfJkhT/IK5Rs04th0HEZozNzvQPWuHDlhEfpGJzkzoDcaUTS1BYyi7FPyq0Y79Re/phwuCXDsjafjjQe6oGGensOUDqS7hFWHjdkscNAALg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 09:38:29 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 09:38:28 +0000
Message-ID: <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
Date: Tue, 22 Oct 2024 12:38:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com> <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com> <ZxaHPo7GRPuby5ky@x1n>
Content-Language: en-US
In-Reply-To: <ZxaHPo7GRPuby5ky@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::26) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 7daafff3-e196-4dea-7f6d-08dcf27d48c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2wxQ2ZsVGI5MEJZRzNSdG5vME5SZnZSTUtra2JEYndoU3NHRHh5TlhRZERF?=
 =?utf-8?B?dHczWnZqeXcraTRRYkFJR00vQjhaME0rUUhOSFUwR0psTEs2NlRkQVZHV2FS?=
 =?utf-8?B?cG1NSEdLTTZHVHlBMUpiRGhuVTh2S1FXcmlNejZ2MWdHN0J0Q2NPRFVuWEpo?=
 =?utf-8?B?ZFE4REYwVS9NWThnb0dWZmEvYytiYWRMZTJsSk1sbFhyYlF5V2NNYVV6b2hW?=
 =?utf-8?B?dXZpZmxPTzhGZmt4Q3MzSWRscHlBaG5tUjFwd1pQdHJ6K200QkhmUmtmMWkv?=
 =?utf-8?B?dE5iNjJOUkVXK3c0U1FEdWdocUZWTUFva2NEcVE4V1BuSnlFNllrMlYwNXpH?=
 =?utf-8?B?QUdWcm90RlhIUDBSZkhiM0JjcjdKWG5BL3M1U1U5WE4zVGQ2WVcwL3pOamI0?=
 =?utf-8?B?cTFyYlp0bEt2M3lOS0lmZHFINEZJMndkNmpPT0pUQkh2VjdEa0djMkV3MDFN?=
 =?utf-8?B?NVlPMDlZR2hZNy8wczNxQXpIZkJGb3o4OGxtQnUvKy9CV0hpS0VudG42LzU3?=
 =?utf-8?B?aklHVE1VdkVPcnJzOUdZdE12SE5KdXkxdlMxNnZpTVJpQ0tnVTBOejlrenlB?=
 =?utf-8?B?K0FmWkxxTjIxVGtaZytVSGtFcDFsa0crSjNKTkRuMG42K1BoVkNxa1FQQUNT?=
 =?utf-8?B?eDR6WUNDdSsxS2FPMGtVQzV1ZlNaWXlrb0FlVDVDZkFodE1lb0lHK3Ntc255?=
 =?utf-8?B?eGUzUEhCWHAxZldvQURwbUxVaUUvdXVHUVdJM29FeEtKcW5yTm0zT2hPbW4y?=
 =?utf-8?B?akg0U3lPRXh1YmtwNFVMQmlWdHdzVWUrcG5QUEdtWE4vTEx0REIyUytxUDBS?=
 =?utf-8?B?WFkwU2NvbnRCSHFIQlpRVS9nRGRBb3JReXhNbUZPUHVOUVYrN1ZtdGFKMUkz?=
 =?utf-8?B?YTJxODIvUm0rVFJCQzVSbFU4L25iWnV0b2N2bkMrV2tjY0hBNzNSSGsyNzM4?=
 =?utf-8?B?R2RYWFRiVUNJQVRIRVlJMis5Mmk5QmNiNGZvR0puUDU3cy8wOUM0L2VUbmdo?=
 =?utf-8?B?MWsyVTJLK1IrSk9BSzFpWW10U2d5UXRwM1loZDhSa2ZzQ0FONStrb0ZEdEl4?=
 =?utf-8?B?bTZPMllDVHVxbCtLS2oyNGRNcyswcklPTXBjZ205WnJIbHdUcEs1bXlLdHpP?=
 =?utf-8?B?YVVNYXA4RlEvMlFTaFlOcC9zdisyMU9RTWxTQWQ4a011NGlWOFpxYld3V0I0?=
 =?utf-8?B?bG9hYXo4ekVFV2hhaTNHeHhnTk9paUdyWWYyb09BVmFzN1I2THFlUWNTQ0hD?=
 =?utf-8?B?UWhIbnN6WHFlUlkzMWFGbWxTNUhvNVh0a1lrWVlXN0F4Y3htdDNpcUY0QjlW?=
 =?utf-8?B?YmI2S3hVQnNlMVNBbkNJSlAwaWhjZHBEUWhsWEhXbXFXV3VURE9vdG9PL1B4?=
 =?utf-8?B?WTBEK2JpNDNoemp2TUVSdDA4b2RvbzNBOG9SVCtJZUUrZXZqaGFrK0NJSWVM?=
 =?utf-8?B?a3NkYkt0ZDVTNGdUMHh2MjBJUm9TWmRZUUhzWmJmbkdMMnN4S1BDWExoKzRS?=
 =?utf-8?B?WGZ0YXZYanhGZVhYTWtpblJBclg0QWMwaWVrbm1pTFVsWEUwd0t4RC9NSzIy?=
 =?utf-8?B?WUx4UG95OG9nM3pBcExIMmF4VkdxRXpXclFYVTBHNmdDL2t1WktySDRFMERI?=
 =?utf-8?B?c0doaS9lMzhva3cvZm4vZklIMmt4Sk9EMGRRdXNVUW9iS01EeExGcHcrUGth?=
 =?utf-8?B?U0EvSXRGWDZnS3BYSTNMdENUd0FqR0VLOUV0KzVOdGVhM2pSSk5yM2JodTU0?=
 =?utf-8?Q?sDIG9G2o0FNfDVoqnWoxnclLFWbFDsNaC3uvFRB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTdCY3RqRkNERm1nN0o3WG9hNW04UnVNTE5ZMWVkRVJhZUtGTkRsTktXQkx6?=
 =?utf-8?B?YUxQRnhmcG41YU9jV3lLclpsNmd4eGNQMnBvVy9LWThhZExzTmVVUTJQUDhr?=
 =?utf-8?B?ZVZEcGY4OUMvTUVpcmVpZS80UC83d3ZFZ3VWNmVZWlNkZmtiVFJjYXdhOU5S?=
 =?utf-8?B?SGFBaHhjR2pBRkZVZ0pvNFlTQ3JxUVozYm9uR1RrR3FYVmlabVplY2RxZmg1?=
 =?utf-8?B?ZzJQTm9pbmFBemJnVnVLL3U1RTJKajNYemhWQzMrZC9KQm9ITWtza3VraVRH?=
 =?utf-8?B?enYzRmhVR3F1WEJhMWoyVGhDZ1F6L09YTnNxemczOWlQZGlGd0R6QmhhMDhk?=
 =?utf-8?B?MXBMVWNFbkVzVTM0WDBvQVJCZ0FNVGVQS0lmU0FxSktJd3FFZExoZ1A0MkFO?=
 =?utf-8?B?blZZazZGQmdKSjRFc3ByRVFYWC8rak5qaHVLNmdGVks1WjNzdDM1U0FPS3RT?=
 =?utf-8?B?dU9vSEdVK2hqd0pqWUJ4UVNwN1NyaGwwUVYyRW5lSVNNUm5YUHkyb0s2ditT?=
 =?utf-8?B?UnJQbVIyUW9yWThMY00ySGRjMnZsQjhGNkZhbVNQcDFXQUpnUjdyd0E5Q2RJ?=
 =?utf-8?B?ZVJQc1czUGpiU3lKMExWbUJ3R284WTgvRnVYcXRmQ1lnVWh2U0ZrR2tGbldR?=
 =?utf-8?B?NHkyNXQ5VjdTVk56Yms4dTZuVzFEanhJNnJTSkZhMmh1bFRUTkx1cS9xdzcr?=
 =?utf-8?B?RXdqeVdONUZGSXBHUGZ3b2RNZTd4Zy9BVityZ3NYRUFMSTczV0lQZmMzb3lJ?=
 =?utf-8?B?bURDYkRGTHl1QVlnZWxOem9UMW43TUJ1c3JsVUM1NW5OcisxWjU5eVk2My8z?=
 =?utf-8?B?T0dCY0N5WUM3a3dLTm9ELzhKMWpFTzlvdENwTWxHc0M3bWUwVDBrOGJLYTRN?=
 =?utf-8?B?YzRVUjNrL3BRTktxVy85clVKb1NSL3VYMTd2MW9ZZFg0VnFTcG9ZbVBpTnlU?=
 =?utf-8?B?cE1NeVRkVCthZmdaWDZydEo4NkZZMnEwVm8rTmp6RVpZZndZTTloYXVLMjNj?=
 =?utf-8?B?R0VzZ245VURGR1c0MENQWGRVMjFrS1NuMjJaVkxENzlkT0xkLzlVQUFTUG5h?=
 =?utf-8?B?RmlmTkZ1S052S3o1LytKeC9MNEErQWFPUFlzeVl5RWVsUzIvK2dPbTRzZ3Fu?=
 =?utf-8?B?ay93VTA4bkt4RlBwTy92aU9kaUdMY2hYZTlsQVNzTTl1Ujg2OVNKN3YrbzQ3?=
 =?utf-8?B?Vi9VRlp3NngzVWtIdEc3anNEVWYrWkdBMyt0Qm5OM2J2MzBPV1VoMjdjTEZ4?=
 =?utf-8?B?dlJNMnFWSUhDZ2dxVExMSlRBSW90Z0xtejFjNzR1V1pHQ2l0Y0ZNN1BZWkJy?=
 =?utf-8?B?SkVKOWJkNllUQUNXbW5JWkpqNVNjdjFtb0tIQUhTVlpxc1M1ZW41WWl6dkly?=
 =?utf-8?B?VmVpZngrWGFRMXpZSmdleEo3VFRmLzZkRzBrZVJ6UmQ0SVBScHJIZ1BQQmRy?=
 =?utf-8?B?emdCS3B4NlYvbFhkajhpeWJQNFJDWlFrR1lGK3lzSnNMbE93dFdxNXFYQm4x?=
 =?utf-8?B?ZlFVUU9nWTE0T01ZOEhnb2xPcTZpMjZyZ0M0bjdXcTZCOVpYQjhHZTlXSGtu?=
 =?utf-8?B?cFA2SnMxU0RpTzNXeEJKWFZhdHNqNUYzQmtDWkZkOVJMQmFTRVRtOHZCM3F2?=
 =?utf-8?B?NnVDSkV6VWNzeUxuTGg1dzRkY0NPbmJ3aHhyOXRuWnoyaEpqUmo4VDNVayth?=
 =?utf-8?B?Ri9hbWtDWG82MzloYTVTL25UcGVwMFE5UmJESFA0eU50STJSSWc3aTNGc1Vp?=
 =?utf-8?B?dGJhek5zMER1VDJVMytDdC9mRm9pcnI3N0NJUTVsc0ZGRmZiZTNzSUlxSkNR?=
 =?utf-8?B?MVdFS2Vqa0JpdHNtelIrVm5tdG03akdjazBsTnBzTG1UeHRFTi9JQ0ZibHJ6?=
 =?utf-8?B?L1JkMkdXa01jalRZSk0zQi9rL3JSUWZiUFNHZmRPRUxYa295Q0pBRUJwUitE?=
 =?utf-8?B?TXRWY3dNc2RReGxCSVprTGpmNnlTcEg1MnRaYzV1eXNXNFBUenRrV1R5V2h4?=
 =?utf-8?B?dkI4RzluSFhNRjZhallWVEdNR1gyMk5ZbEh5NUMydlFXcWd2bzNnSW9VeHJT?=
 =?utf-8?B?eXNqYlloL0JaMllqVnRVL1VQNFFHb2gvK3p4cy9RcEg0bGVRVVBZc2d5RzI2?=
 =?utf-8?Q?fnyd4mC0HWg7i1UJC9qsArIuc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7daafff3-e196-4dea-7f6d-08dcf27d48c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 09:38:28.7679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgVoUzABjyMddr0VmCmJzusnin/DKPROlZrzc9Ffdo+AWuL4yVsFCV/l6JIX7mxmzQjtXYYOUf71IDShXPpXwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
Received-SPF: softfail client-ip=40.107.236.60;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Avihai Horon <avihaih@nvidia.com>
From:  Avihai Horon via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 21/10/2024 19:54, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
>> Hello,
>>
>>> IIUC the migration thread should always see valid migration object, as it
>>> takes one refcount at the entrance of migration_thread():
>>>
>>>       object_ref(OBJECT(s));
>> Could the migration have failed before ? in migrate_fd_connect()
> I just noticed it's a vm state change notifier..

Yep.
I stumbled upon this bug by accident when running on a buggy machine.
Migration wasn't involved, I just started the VM, shut it down and got 
the assert (as my VFIO device was faulty and errored on RUNNING->STOP 
state change).

You can repro it by forcefully triggering an error on *->STOP transition:

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 17199b73ae..d41cb7c634 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -831,7 +831,9 @@ static void vfio_vmstate_change(void *opaque, bool 
running, RunState state)
      }

      ret = vfio_migration_set_state_or_reset(vbasedev, new_state, 
&local_err);
-    if (ret) {
+    if (ret || new_state == VFIO_DEVICE_STATE_STOP) {
+        ret = -1;
+        error_setg(&local_err, "%s: forced error", vbasedev->name);
          /*
           * Migration should be aborted in this case, but vm_state_notify()
           * currently does not support reporting failures.

>
> If so, maybe VFIO could refer to its internal states showing that it's
> during a migration first (so as to guarantee the migration object is valid;
> e.g., only after save_setup() but before save_cleanup() hooks are invoked).

It's an option, but I think it's a bit awkward as we'd need to check 
that VFIOMigration->data_buffer is set or add a new flag.
Besides that, as Cedric pointed out, VFIO code calls 
migration_is_setup_or_active() which can also be unsafe, as it might be 
invoked after migration object has been freed.

Maybe a simpler solution would be to extend the the migration object 
lifetime?
Looking at commit history, you can see that commit 1f8956041ad3 
("migration: finalize current_migration object") added migration object 
finalization at the very end of qemu cleanup.
Then came commit 892ae715b6bc ("migration: Cleanup during exit") and 
moved the migration object finalization to the beginning of qemu cleanup 
(before stopping the VM etc.).

If so, the fix could be something like the below?

-------------8<-------------
diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613b..5eb099349a 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -52,6 +52,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);

  /* migration/migration.c */
  void migration_object_init(void);
+void migration_object_finalize(void);
  void migration_shutdown(void);
  bool migration_is_idle(void);
  bool migration_is_active(void);
diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..9eaa7947bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -265,6 +265,11 @@ void migration_object_init(void)
      dirty_bitmap_mig_init();
  }

+void migration_object_finalize(void)
+{
+    object_unref(OBJECT(current_migration));
+}
+
  typedef struct {
      QEMUBH *bh;
      QEMUBHFunc *cb;
@@ -330,7 +335,6 @@ void migration_shutdown(void)
       * stop the migration using this structure
       */
      migration_cancel(NULL);
-    object_unref(OBJECT(current_migration));

      /*
       * Cancel outgoing migration of dirty bitmaps. It should
diff --git a/system/runstate.c b/system/runstate.c
index c2c9afa905..fa823f5e72 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -930,5 +930,6 @@ void qemu_cleanup(int status)
      monitor_cleanup();
      qemu_chr_cleanup();
      user_creatable_cleanup();
+    migration_object_finalize();
      /* TODO: unref root container, check all devices are ok */
  }
-------------8<-------------

Thanks.


