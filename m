Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524A7106ACC9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ixY-0007xU-Bp; Thu, 12 Mar 2026 12:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0ixW-0007wV-5s; Thu, 12 Mar 2026 12:32:26 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0ixU-0007tz-9W; Thu, 12 Mar 2026 12:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtreDOELDFh4l7RY4OY8ki9N/4jrsLJo8eeRESKuNO94za/iRabYZxxCYQElerujDpObDOFhKgOQyS1EyddxqdohvysINUfcsG8Cm4yLzc+EstcivBF80pCdiREL/ASV0iwTUS0/8675AXDRaeRxuHc2UDZqatYeyEwt1EWfD2rUvIuynRbMXnc08GfC3NQXPYtnw8R4GdlFpriBnza7wYaRp3sGufteOPekLZzSzDvBwJxnknE28Av2caP1Cn1vzYufojTqXE1YVAdTnbFBkPWu1AY+/Rk2lEQnWyaekhNYobvQ/TmOH7SypPnQZmXahPm0xdV12Rale6YyD/o5WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHW3P6lY+6Bd1scAu9FHpxiLrFSSlzk3D1Tyalznv/k=;
 b=Cf4+Effr4bM72JUB0dF0Ds4JIBntiBtprWR1xEZPVAdXefguheydFZWH3n3PILxq2sDd6J7Vc0mUdbParQpZ9dr5ZjAOhCC5bEijJph14u2pqcjvqLqF7+5/VcH/XGu/rT9AaA5bshaRhI3s0ebyDkeRT9bOLMT/ZQ7FhwXYbhT5BEb/gBA5OlqG5k6IQ6/z0aHOjId5psMeQgO7tCjxuCegi9IpXmwWlN8mSm/nvFR8dktyzwB1VIN7nixL1XUsakzuqScgEh3eGfh2dB8OKcQKlrr2ZOtzyC02806V0pWhIoLVduYru8QdeGATRZEJSCy5Gf5nVCZ7di185j1yDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHW3P6lY+6Bd1scAu9FHpxiLrFSSlzk3D1Tyalznv/k=;
 b=YLNra9Si7K0gnHnmiUAAN3xO05zWH/Ufj54Fx73OHSkv56Pm4er5m8yQh/6z6gyJv+A5W7sYzPZ11OimK7zvzh/D1vVncImi9/G95xCaGIaug1uYsdeAPypnE5DYsL/C8SUJB24uOdlul/7MOzL4pbXIibbsr2KFlX6LiJ5KTBDysyFtqx4g/lp6/ZCPei2hdf/QcXKfETnZIJgyNeNVszvKouqPXNirzm4n5BGRvOqKAtb75KKQIlMUK2j65onAzVIQbvc14vnqSk0ykI0BNQ+JNNoGjVsYfoeNuu5iNFUXoMlOWJxOR26L0MkX9076wowLBoPck6CVNdJVteHXlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 16:32:14 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 16:32:14 +0000
Message-ID: <0095c90a-1e54-4be2-a5ec-ebfdb9600839@nvidia.com>
Date: Thu, 12 Mar 2026 09:32:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] qdev: Add an OasMode property
To: eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-8-nathanc@nvidia.com>
 <793c6796-177a-4e31-bda7-60bf2b9e1574@redhat.com>
 <480e5ab4-1574-4ef7-bfca-982bb0700423@nvidia.com>
 <96fe828c-bd2f-4f84-a9db-71dfcc5d1756@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <96fe828c-bd2f-4f84-a9db-71dfcc5d1756@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 81321c93-0aa5-4e95-1391-08de8054eb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LI5/O5K8qB+tJXNrdUkDHc1BzcQPYl9D/pyFKl/Vqyv66iRqDLJZyGZc6rHirSvcOJWwXpMxz1LUc8XsyaNf47cR5IdruCATeVHVuC76SulhJrcQmQM7subSnrL/xRCGjEYx2pb91hBkfBT8a7s8H5KOPC4+yK5Ozn1P0RFVo2tjlMpQDzcMWdZn+taiwgX7Vr9VXBxrFslXr0WAB2f3UAfXBJRmrAmytCUv+xUFdkCIbCfXIzI3ZB1sozn/FIb6p46r5n9NG2cPPQihuNppqOgnytPlqX9GJPa0NcSGF05baO2M2+yES8dHQCr9aAbrm7hjS2Z8itJyCiIiZOQPuFDV1nQpCGAedD2LmAZ8XngXJ7Juk+CWuLsjRKAM6APhiiCw2IY5L4uJjyCPLvhq6RM0yMkW9PDsOHuahpR8TgiHWAj5so0JrHpYgXWOfOzg2oh9kwcmyNq3PVzDwl3QzIUndkuT3lMpGs9bP6ge6Os504oOAyGM0Eo/x1sCNsmVX0hVecIP+VwS6xI2/DbJvz7ioG7tzR0chGzHYFP95iZDrXT6a6pvd7TA0tKg32WkFf8kp9biBBmMBeaeR4PgGXrq1vG+iABVOtzCQeyKwcf8fQzZhkj88PW4niW+iH8ZoWg6GBiVucxM/uiO+Fpvgs1eio2EWxykYdUWWvl3qOmCSwvl1GcnwVZvwAbVCDA4eGgaVViMhfYELQpqUK5N4iH98IATKLKip1wVtdaXU98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW94bERZbDVvN1FGSjRzT281M2FNT1IvWG93MC96cEY3MFhUV3owb2hoQnlF?=
 =?utf-8?B?UU5RMVpaVGtKcWU4U1ZUYVdPNkhFM3lxRzJiVmhySGVlSkFsTzZzdFdKaTBM?=
 =?utf-8?B?VTNsOG9lcGo4T2lDRnA1c2tMMjA2WTVJRy9pN2lRWFNhanpXUjdpemFmNDRl?=
 =?utf-8?B?bkZubDIrUVk4VlZqMEFiVzF5L1BGZGFTcEl5V29sR2txcCtFWGM1SnhXT0hs?=
 =?utf-8?B?Mk9hTTQ4c2dwVzB1d2NNZDhzLzN5UEl3ckFRd3QzdmwrVXA0TjBXZ1NncWd5?=
 =?utf-8?B?L2JjK09zVkt0TmlDMXdNWnNNZThRTzdCWXJxZGRqSkh3Sk9vVEhsUU9MTUZT?=
 =?utf-8?B?cFM5ZFZObTByT01KZ0lRK01FWWlkZVJOdmt2YnFwNE5ZMnJ5MzBpWFcxdWJw?=
 =?utf-8?B?ZGZnM3hINDNsdlA0M05XV0JZQ29xSjc1MXhRVUJkc1Iya0pnUURRSkJkMWFT?=
 =?utf-8?B?dVVGeU5xQUo3L1hGdkprcVlVQlcxRkZVQW44cXFHTWRGVk5wcmp3aDg2cDlV?=
 =?utf-8?B?L1hoTHYvZUZCcS9WMXgzL1lTN0U5QWZsWlNHTEhVbXpYclRkV2VvaTVBZHdu?=
 =?utf-8?B?dWdRMmI1dURFcW5YMUFPYVBIL3JPbWxkMldVZHlucHRPQURrWmRMbmNxZld1?=
 =?utf-8?B?REErcHhhS3h5dHVQbEw5TmoyQStHcS9uSkFYMlVyTU1FZkxWU0J6TU96Vklp?=
 =?utf-8?B?U2NSOGJ1N0ozQktHa1c0allDRnFsTGJaaGtCMTZlbnRPVEJtaW01bnZxUjVp?=
 =?utf-8?B?RThQa3JKS3FJTXA0UlBXcVNXTzlmQkVyaFhXWTlmWkJmZnQ4ZU1kSk9vQWhZ?=
 =?utf-8?B?SnpYR2NyeWd3OUVYazdRdnNyckUyQnVTMnA5NW5Lc1pXL1hKQUlpY0VlT08r?=
 =?utf-8?B?NlNTVWJ6MVR1RFNDQVJienZOU3FVdE9YaENMek1QVVJDeTdwSzhtYUhBV3lQ?=
 =?utf-8?B?K0w3aWFFY042czhEVktBY0E3V2FDQjNUNEM1NGs0U01uM3pPZ0ExYlBobFpl?=
 =?utf-8?B?dUNHby9GRWZnV0o0MG1Eb3ZjendGdytMbjRtQlRmTk52ajk5NnFNYVRHZk5j?=
 =?utf-8?B?RWJLTkcrMjhVL01iUS9ERk5pT2MvbDRzeVhEcjUyRmNkdmV4WVFoaVVsNTBD?=
 =?utf-8?B?MmM0VDNSTlc1UXQ1Y2hISWxyMFdWTUxDTUdMeHp5cEZpL21BZjZnMGpxaEdu?=
 =?utf-8?B?cER5QWtBYVdrbUlNZkkzVmkzRFRFQUVVT0xNYUNVY2tCbWM1dHpLK0lPT1VM?=
 =?utf-8?B?WjRyZzBVU1lHNks5RzRBcTRQdzhKUzhCM1JydkEvdWswTW5SRElUcVNtUVlD?=
 =?utf-8?B?cFUxQUNBZnIzN1Ruckl1SUlyTk9PQ0pJNVRrNXNlR0EwdVFoZm5IWlhXS1pB?=
 =?utf-8?B?SGFFQ0U4QjVzT0Z0a0pRZDBWb2xpVGw5VkVIZHNzSDNIQjhPTDE2dDhERE1k?=
 =?utf-8?B?dXh0TjBEMVhaN3VFMEx5eFZsMDdQVmtFUDF6T3FKbVZuRWNPYlVDMGRhV2Nm?=
 =?utf-8?B?Z1lWOTN5Zll5MWtMRW1tVFdTNWQwTzRJeTFvRzcvQzFpZ1lNNHRnU1BuK0VX?=
 =?utf-8?B?azZzd1F6MmYzVTBXK3ZsNGRjQXEyWDY2SjB4TU9FaVUyZEV4TUMzM3BRM2xH?=
 =?utf-8?B?VWpEbW92eEpLcVVJTGlqZVNYUldpbDM2ZTlxQ2tsNm5FZnIvS1lWNFA5Vjh6?=
 =?utf-8?B?Tjc5RFF2ZkhnUzdZeDdTNEtwNFJIU1FTbWFKYmZUY2l1ejNrRCtnU3c5V2k1?=
 =?utf-8?B?enV0c1dZaUpEMm9SYVZ6cW41dlpOZHZBb3VMUWlrRmdxcDZkdzZaVVRLVmNV?=
 =?utf-8?B?UFhmT3BjWHlUa1JRUUQ2M2tjUWNydGJ6UTNTektxZGZDNW5WNE5kWUlGVDQ4?=
 =?utf-8?B?M25DR1BseC9VcU5ZYytuTjdWRFZtV01qVnAwaFMrZldPZzlkaCtES2lYaXE5?=
 =?utf-8?B?N3cxS0ZDbFljakJtMWZZUmxjZXJvbHpzYXIvaEVhMVpQKytwNkdVeGZtbGdo?=
 =?utf-8?B?YW9HeE9UTFJvMHRxcE5tRVpDSkdqMmZDZEZtNHJuU2VMVEh4MHd0S3pCN0xh?=
 =?utf-8?B?eXM4MCtpbWtDcDBMa3NJWlJZamxnVUF5KzE1WThHS2E3N0F2YVR1bHlMRUN5?=
 =?utf-8?B?SWVLUDVjREJ4c3ZSeXBuNWVZQlBVNXZQc050NnpLMjJNY2wzWW5ZS3hxemdX?=
 =?utf-8?B?MEhYWFFaRFJzTUVsS0xDVi93ZUtpemRzM0xyVEZSMVZEVUs4S1FicWM3OVo4?=
 =?utf-8?B?d1ZHRnJsbHdMV25RWkgzZGRkNm9CS0VwVkxxMk9BbWdWaHhvUUhrcElOTFZv?=
 =?utf-8?B?T1FubUdDZEUxcXVrTm1xQlpyYTZRK1VHc0tvSDFMZTB2VUtxdUFQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81321c93-0aa5-4e95-1391-08de8054eb11
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:32:14.3724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBEegUBmpfVCdPg0FkSokoHPNM/gSd61dvBAuSyEIe4tguhgOHNroJaMPcCBhoiERBxae3N4+ZGCOtd/VOgKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 3/12/2026 2:29 AM, Eric Auger wrote:
> 
> On 3/11/26 7:24 PM, Nathan Chen wrote:
>> Hi Eric,
>>
>> On 3/11/2026 11:20 AM, Eric Auger wrote:
>>> Hi Nathan,
>>>
>>> On 3/9/26 8:21 PM, Nathan Chen wrote:
>>>> From: Nathan Chen<nathanc@nvidia.com>
>>>>
>>>> Introduce a new enum type property allowing to set an Output Address
>>>> Size. Values are auto, 44, and 48, where a value of N specifies an
>>>> N-bit OAS.
>>>>
>>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>>>> ---
>>>>    hw/core/qdev-properties-system.c         | 13 +++++++++++++
>>>>    include/hw/core/qdev-properties-system.h |  3 +++
>>>>    qapi/misc-arm.json                       | 16 ++++++++++++++++
>>>>    3 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/hw/core/qdev-properties-system.c
>>>> b/hw/core/qdev-properties-system.c
>>>> index 4aca1d4326..a805ee2e1f 100644
>>>> --- a/hw/core/qdev-properties-system.c
>>>> +++ b/hw/core/qdev-properties-system.c
>>>> @@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
>>>>        .set_default_value = qdev_propinfo_set_default_value_enum,
>>>>    };
>>>>    +/* --- OasMode --- */
>>>> +
>>>> +QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
>>>> +
>>>> +const PropertyInfo qdev_prop_oas_mode = {
>>>> +    .type = "OasMode",
>>>> +    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
>>>> +    .enum_table = &OasMode_lookup,
>>>> +    .get = qdev_propinfo_get_enum,
>>>> +    .set = qdev_propinfo_set_enum,
>>>> +    .set_default_value = qdev_propinfo_set_default_value_enum,
>>>> +};
>>>> +
>>>>    /* --- Reserved Region --- */
>>>>      /*
>>>> diff --git a/include/hw/core/qdev-properties-system.h
>>>> b/include/hw/core/qdev-properties-system.h
>>>> index 4708885164..2cbea16d61 100644
>>>> --- a/include/hw/core/qdev-properties-system.h
>>>> +++ b/include/hw/core/qdev-properties-system.h
>>>> @@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
>>>>    extern const PropertyInfo qdev_prop_granule_mode;
>>>>    extern const PropertyInfo qdev_prop_zero_page_detection;
>>>>    extern const PropertyInfo qdev_prop_ssidsize_mode;
>>>> +extern const PropertyInfo qdev_prop_oas_mode;
>>>>    extern const PropertyInfo qdev_prop_losttickpolicy;
>>>>    extern const PropertyInfo qdev_prop_blockdev_on_error;
>>>>    extern const PropertyInfo qdev_prop_bios_chs_trans;
>>>> @@ -64,6 +65,8 @@ extern const PropertyInfo
>>>> qdev_prop_virtio_gpu_output_list;
>>>>                           ZeroPageDetection)
>>>>    #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
>>>>        DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode,
>>>> SsidSizeMode)
>>>> +#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
>>>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
>>>>    #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>>>>        DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>>>>                            LostTickPolicy)
>>>> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
>>>> index b372a3661b..76b6965502 100644
>>>> --- a/qapi/misc-arm.json
>>>> +++ b/qapi/misc-arm.json
>>>> @@ -60,3 +60,19 @@
>>>>    { 'enum': 'SsidSizeMode',
>>>>      'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>>>>                '10', '11', '12', '13', '14', '15', '16', '17', '18',
>>>> '19', '20' ] }
>>>> +
>>>> +##
>>>> +# @OasMode:
>>>> +#
>>>> +# SMMUv3 Output Address Size configuration mode.
>>>> +#
>>>> +# @auto: derive from host IOMMU capabilities
>>>> +#
>>>> +# @44: 44-bit output address size
>>>> +#
>>>> +# @48: 48-bit output address size
>>>> +#
>>>> +# Since: 11.0
>>>> +##
>>>> +{ 'enum': 'OasMode',
>>>> +  'data': [ 'auto', '44', '48' ] }
>>> you also miss other enum values
>> I left out the other possible OAS values because only 44 and 48 are
>> supported per the previous accel SMMUv3 series. Should we still
>> include the other possible OAS values according to the SMMUv3 spec? If
>> we do, we would end up hitting that check for 44 or 48 bit OAS when a
>> different value is specified.
> I think we want to want to provision for all values supported by the
> SMMUv3 spec

Ok, I will include all the values in the next refresh.

Thanks,
Nathan

