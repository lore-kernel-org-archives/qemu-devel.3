Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C5CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRNq-0006BU-BS; Tue, 19 May 2026 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRNo-0006B6-J0; Tue, 19 May 2026 16:49:44 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRNm-0005nM-TU; Tue, 19 May 2026 16:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcztZ9RqewOe+zxm8eV+l6bNVfli7Xli1Ak9ZywB5KeYBsgPfkPtj+7PvoJ9vWpxl/bwQVWI9Vohgq5qCtcW9K3J/uRg5B65oR5Q8759/mmfdAYhsFLAhK4yc00+01afFaiXyHfiBF8Zy/wTD+YDYmVbDdFM07X8a9DK+5fqhSVa9QhI4Qz0/82B2Sit0KYTQO4LZ2nSUJp6EVPi2Q6kUrXKvGuKQ8kiQ1a3K9k2kwrSMumwKIYeFSvvoP1Aacd0MJN4gm2p/hV/hZDolTi8eAUtsQpC4N4Cg+DmIw2Dm8jHALJpThFdedReExBH6vGYjyin+P34t8xq0nvFkHpEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b00CgtHoJm+Jwtht/O3H6X3gNggz22ZEOoUJptiz8YM=;
 b=l/9fpZ7poLUtQ8AJPrWP5tX7L2qSuQDBKnZN5BJzwIyqDous1ENW1D24PT8WZoDxLs/2qe6o8tsDUkyP55UDwQnMp/8xd8ExPnP2kyhZg6KPs2Pzv9wCOYKNHjBGTpFGhH7G6H+ZvkCMmE8iT2hldHF1yIot1+gP0av3GKZ0awi0Ht8QKptkKg9dmc489eQ4GmsnHD7fwLaYxUX50qmTitNz+ZEUcOLzAFGRn3xX8jw/Iu35bgM/hoKoNlYEkC0+ayAVEaA5PVRvueZBVSwQIg1gcrj0pSVS4KEkgvZvTS4ZEs3oy0QW8/ZWpzo50q2fmYvJL1RdyIlFCDF1B0h2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b00CgtHoJm+Jwtht/O3H6X3gNggz22ZEOoUJptiz8YM=;
 b=AWnEZJld7LZtwKyrIMGkL3fMCjlyZ9jmxKiNJYdiaq485vkbXE3ccBhfLCnzZIZp07d6JDfMWGhzhBBh3GjTUEhd3QfpQMn1UQNZeWIpUZt9Yrpa8l2tyq2hruJ+5InrpUZjHyriMGT2uxq4CYMnnNDQtx4jHBaVRqpgus9JaVUdaXbGsqZbrfb1AiC2DhD0Jbz/+4Xx81gXQFcEKJXaisrn/CWi+oBgbds1qz19QkgW0ZpG4z1IIsW0oqnGO03z8NdSdbIKI17v41668I3Tb1Rt4o2dw4aHeKtyw8Qv+48r1z4OMymaV1OEtPHIdJIoVYKrjWWLuifzmVdmh0XF6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 20:49:35 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 20:49:35 +0000
Message-ID: <1cbb2859-6f38-4eda-b56d-4e077ac81b26@nvidia.com>
Date: Tue, 19 May 2026 13:49:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
To: eric.auger@redhat.com, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-3-nathanc@nvidia.com>
 <CH3PR12MB75488C9306659D939ACEE203AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
 <cb3f2ace-be0d-4b5a-ad3e-9de541a2444a@nvidia.com>
 <CH3PR12MB75482526F3E2B515168A1E16AB042@CH3PR12MB7548.namprd12.prod.outlook.com>
 <13629ab2-f89c-42d9-9be1-8341e8146835@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <13629ab2-f89c-42d9-9be1-8341e8146835@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b4caeb-160c-43fc-7bb0-08deb5e8229b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|3023799007|11063799006|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jmA6c0aPXnH8e2QkudBYnyIcb/Kba0Aj5J9fSXpLBRlah3ZEYim0ZGJHdfw1e3TzUhjZPinx3EoxR/f8KfDsbrZw3dVmtd2NId/WhoWxFW2Rgv7qzNisNPiSClG/rN0B/SpaK/dtWzkj2hlgevpGU4WLiFfOVA2cMQKgoMjwKN/JQZCRCB5XcWS3zd4uDglrYZ8Eg8vX5gWDnrwnp2HiVlzP8HnHc9ZoLgERqFk5z+baUVP+xl4m3dtAclXvpLHiTdzlKaA3X+Mq7OsMBV1i1/gcy92tZuvBwIhQZKoanchS2flHt8n0iEMxqFGnERE7QTt5KKt/7XklKwIj+BemdWnhJOoPcxphQMyGaruH0YIWsH2VOajzUhFXlJd8QoASh7IV25MmQC4rfqP4Ht89eBZQXapm8AVMHPi+nDNQFl7laHnk2SvFCW7QQJEEW9F/EfuvOQRDOJtSJXFZsfYG1IeOLSIgZM0SfU3AiKZNvlEUGGGJHjxGHXtc8VRQJO1KMDXdPp27vPf2sAzqohWVPtkF0Ig7u5k7Njg1xPKj458QTWbgJUnORIx59V+MBlaLMdw0N9OlouFyL12Kn6izoEUmLtUyae+LhdSX2HSGOEk8MK3RhRenixaTpou22JMXmse4s7NpNxFGMhdVx9G0rxr7hxYe8vyXFwimAE397EvJWfGX8rLWqsUpOTbJV+/a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(3023799007)(11063799006)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2FUVHpWN0IyK0c0U09NS1JJMlFuY0FWMk5taTllSlVSaWZ1ZkRTMHlxZXpZ?=
 =?utf-8?B?Mld5SVNyRWFnam9TUE11WEdtalp6V1BBNVpHY0k3aERKbk5KN1p1c1JibnNK?=
 =?utf-8?B?emlxOFJqMndzanhZVXVhQzB3enI2U1BTMEpneUVDNUZuRGxWNjBXRDlEVkFN?=
 =?utf-8?B?a2lEVGJIYjJObFBsNmxRNHViK3lEV3hxUUZSM01aZGNkeEZmdk12c2RLOWpN?=
 =?utf-8?B?MmEyOFlDUllBL3NVMC9qTW45Q29Vb0h5blpOdDV1blhYbnZXR1pIRU13eTlv?=
 =?utf-8?B?eFpPTFZEcVkvSG5ZMmtNZmpxazMrUFJnR1RMTXRBVjlUT043dzUvWWZUSzFY?=
 =?utf-8?B?Z2xzajFkcFd6RlI5NERMT3FGaFZ0ZXVoV0lpODFvbFBlUExrSlVNaUpqcTht?=
 =?utf-8?B?Nk9kUnErWXQxL3U3aGp2Z1oxd2Q5c2V3cDRZME81MDVVSXphRDZXYWlVeDVp?=
 =?utf-8?B?SUwzQlhkNlYrSFVhRVNiUzJ4TXhQMUxwQXV2MExGeDg1MXJzZENya2JJVE8v?=
 =?utf-8?B?dXZxSG15azBTeFJYVTBpYi9BZ0I2R0NwNWd6WGFVNm5QNVE0U3FoaHM0cmoz?=
 =?utf-8?B?NzYzQ2NpZlFjVkVFazh5NE1uV3BkMHRIRjI4RUphamVVRUNIY01ON0hhbkg4?=
 =?utf-8?B?L3ZXd1BTamhBUnpjWVg1bmw5RlZkMXNrdVFhR01UL2FxS2J3MDc5ejFTdmVP?=
 =?utf-8?B?cVZ0djIzN0hvL291N0lNOU9lZE03eFh5V2dHMGpnTHlKUlI2dnBhcFNMMXRn?=
 =?utf-8?B?ZVkzTHhiNGtYdmlZc21CUkk4RUdlZGc1Z0tqOW95TWZNTkNLVG1WRmF1V09i?=
 =?utf-8?B?MU1DYlErd05DNURYQ2JDSkZPQlorV05jQ0RBVVFDMWdzWmVDS2JKTUxvVVpX?=
 =?utf-8?B?RFhKZFJaOFlNTzVXelcwd2tianZOcWtxamkzczc0ZzJYbUtocG5xNW1UdFRE?=
 =?utf-8?B?TWNMTFZLWE5YSDQ2c2JmS29hbnUzeFFTL2kzdWFHVHZWWEhXYkRrMFV5OUJ0?=
 =?utf-8?B?d2docVdnZ3hhV2svL3Vhd25vdWhHWXl1bkNoTmluRk1tbnJDdnp0N0Y5RG5l?=
 =?utf-8?B?eDM2NlNMRjZOYUIwczJNZXQwNkFaSklWdzd3SVBoeks1Q2dPWUg3eW5HRnVz?=
 =?utf-8?B?b0Ywalh1aVNsNWFDa05UeXphZVhLUmorNFF5cjlES3Q4ckZrUzcvTThvMDVG?=
 =?utf-8?B?eWNQUE1xbkNyb09qRU1zdVY2SDl5bElyUUZ5R1ZNdU5rL05CN2VwRUVVcjJm?=
 =?utf-8?B?RmkxUmdoeUZJYkZQUVM3UWtWTEExak5IdkhrMnRNY1U2Z1BZdEVET2daTmxn?=
 =?utf-8?B?SklINXNxRjJnTjZvZktWTm9WcDlvcGt3cFVKM0ZGWHhCU1lQVU1SNGNyNFd0?=
 =?utf-8?B?WDNmZFFKelozZkJKMUdVZnRSeWJrWCsrbUwzMzFZZkx3OVBTS2RCblZQQmVR?=
 =?utf-8?B?OXlhVXRjQzRpa3Bva3dUVVhWcWRGeTlZNFFEb1YySjgxRXJ0TUVVbjJ6a0N5?=
 =?utf-8?B?ZjYxNUlQWEJWQ296ci8rL1hta25ybitsbHltT0hhWUcyQ2dqR3hQUHEramJr?=
 =?utf-8?B?dGtCSzgrdytUMStFRHM2S0grcGFFSjFWaDJTY2FzTnVnVW53RlhocnB4QSsv?=
 =?utf-8?B?MmRQb1BmbCtSclVFWkdvaE5uS2pZbU95S251dFNXcjhubEtMWHNMMlRFdGti?=
 =?utf-8?B?MEVyOHFBZGtsTkJJOFYyRG11YlpmMFp6ajhmS1RWT2hjbURLSm1zMGpJZ0Fk?=
 =?utf-8?B?UVVmaXVsdDFnWDBEZHlCWjkzSVp6VUR5cGFrWkc4cmYyVFZ4c0h6bkRrQ3V6?=
 =?utf-8?B?NUR2SDFPRkF0RUdWWTQwSlNwcHB1YXFPMkE4ZHdJSDFDZzhIVHJaeTRzM045?=
 =?utf-8?B?WXUxTHhoOVA4endwalVDN3ZXbTFxWkJSK2lxR3RKQkxtamhoRzhhQmJwMkxm?=
 =?utf-8?B?bVloY21wMVo1Mzl0SlJBK2o5L1lRQ0pDL0k5RHhxWmVJdWU4K1lPeTZxVUVp?=
 =?utf-8?B?c1J6NGdzb0lmNXRPQk1leTJqY2dnUFJUOGNpK1poVy9uQU5uR2xLTEU5VG9E?=
 =?utf-8?B?dndjZXA2bnE2RzlUOXNpcmZrbE9uMExZMkxSWXE0QkxYNGF0QkdLUmtXRHVU?=
 =?utf-8?B?MFlLRmczRStjRkFMeWFVbnR3bEtjSjBtUmJIZm5ZYjd5TklVQzJWdEJERmJ1?=
 =?utf-8?B?amo3RzVlR0ZDZDExeEtRME5hdjV4UXQ2aUNYekxUQmFvd1B5U0xlWm1hSlFu?=
 =?utf-8?B?eDI1eU9kZnl0QlpWK2g1blp4Tk8rMjdJNmZCdjJLVzJSVU5pS0Irb1oycVZX?=
 =?utf-8?B?L2xSOW9CN0VKU2t3czJrTGJLazNCSFFuS2tLRVFHYUJ6UzJET3VJQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b4caeb-160c-43fc-7bb0-08deb5e8229b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 20:49:35.2323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6jSn4BCmadghQZ2mBZVY1OMmjAQ0wG+kWZ5FKvCcsqnhKsXH4j8WUjivnxp0bkxSH40Mp5zFa4uYpFce4adBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nathanc@nvidia.com;
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



On 5/19/2026 8:30 AM, Eric Auger wrote:
> 
> On 5/15/26 9:55 AM, Shameer Kolothum Thodi wrote:
>>> -----Original Message-----
>>> From: Nathan Chen<nathanc@nvidia.com>
>>> Sent: 14 May 2026 21:07
>>> To: Shameer Kolothum Thodi<skolothumtho@nvidia.com>; qemu-
>>> arm@nongnu.org;qemu-devel@nongnu.org
>>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé<philmd@linaro.org>;
>>> Zhao Liu<zhao1.liu@intel.com>; Matt Ochs<mochs@nvidia.com>; Nicolin
>>> Chen<nicolinc@nvidia.com>
>>> Subject: Re: [PATCH v3 2/7] hw/arm/smmuv3-accel: Implement "auto" value
>>> for "ats"
>> [...]
>>   
>>>>>        object_class_property_set_description(klass, "oas",
>>>>>            "Specify Output Address Size (for accel=on). Supported values "
>>>>>            "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
>>>> In smmuv3.c we have;
>>>>
>>>> case SMMU_CMD_ATC_INV:
>>>>           {
>>>>               SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
>>>>
>>>>               if (!sdev || !s->ats) {
>>>>                   trace_smmuv3_unhandled_cmd(type);
>>>>                   break;
>>>>               }
>>>>
>>>>               if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
>>>>                   cmd_error = SMMU_CERROR_ILL;
>>>>                   break;
>>>>               }
>>>>               break;
>>>>           }
>>>>
>>>> The above !s->ats will be true for AUTO case, right? I think
>>>> we should change the above check with smmuv3_ats_enabled().
>>>>
>>>> Also, since we modified the ats to OnOffAuto in the previous
>>>> series, I am not sure the above should be a fix patch or not.
>>> I see, I will use smmuv3_ats_enabled() here to account for the AUTO
>>> case. I am not sure if it should have the Fixes tag either but let's see
>>> if we can get any guidance on that point.
>> The default ats with previous series is ON_OFF_AUTO_OFF(=2). So even
>> if ats is not visible to guest, a malicious guest issuing ats may end up
>> getting forwarded to host. So, I think we should fix it.
> good catch. Effectively you may add a preamble commit fixing this in
> this series with the corresponding Fixes tag. Even can be Stable to
> apply on previous 11.0. version

Ok, I will add a preamble commit to fix this with the Stable ML CC'd on 
the next refresh.

Thanks,
Nathan

