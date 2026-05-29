Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB18DCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT6FB-00029W-8U; Fri, 29 May 2026 19:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6F8-00028N-Sa; Fri, 29 May 2026 19:03:54 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6F7-0007QT-6t; Fri, 29 May 2026 19:03:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA/VXEolSsDZCHXKKblwUEwchaaO5PedPmSJLxd17rmyFQpqgcpPJxfRCg8t+V2BJ/AQxkzMicTAujHriMScAFFjUhxv3hIftperPcXOd0BSt022Ob9sUM2LlHBspFL0m78dFThipU+imfNymRsmu0EPAeTkSqF62jM9bsWS7hqgM/vh1Q7Ewt1e6167MdrEGF2BM0/w6VmMr+VHtiESgY7PPlzPbA8Rrd8m0X+zP8igCgrIBRUhQvkROtfWifYR3HElMriUNrrQ1IbSCFHFJJKFt7EjPLx0n+LjPJy7gG/4Suql/CU57z3pUB0KzWBxZ4Z1wkCp7E8LkSoojhm/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR7Rda5B8ZBWdzzCOwnPZYek/SAMfoCxoSFWzfscdtI=;
 b=ZM3hNWUJwwHDto49dUbtuo35tOWkG34xBLd0o48ioos07bbiH09COftH2BCQW2IE8mWlwZntPQ6fTOUAMsBrbXCvb6NkQ5tnJfsjEp7Qomaz09AP3838L7T208w/UmalXleyAXSzXfWCWVHDGoHVeEEnJsKxxKDh9cEgtAoi+8QBVmTJl07DHo7R6TUkaAMY8MkFf+cvVHMm2XfBPQWJ4VXs9PnZS8VoPB++R0xtrs0A7hFBO45RTYUfQvCROJwbjmXwqoUQJtAfT+ux4OfBIlm48xLVJT6jNDTMBIZVjupQFHyGmutuUU9IarCltK0Oq9h6ku1YnYTbpZmn9dg0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR7Rda5B8ZBWdzzCOwnPZYek/SAMfoCxoSFWzfscdtI=;
 b=gICFhOBtZ+Tml6QTCtoK6yqgJH9hRwh8PbXIhbb9M4YNAAjsvL0n4A9EzO6STWr+lmYwHKQUswoXhuKCn1pnJpdyjq7quiRPpAvpCmG7Oj2DJgo8yQ8R9V1R7qo0KtbdiRVXbStjZ47u+brhXHbkYNZVsF2uK3P2sx6HPkb1OB68OJ/m8q+pZFymiKszLrLtRbkuJQBF1jpG48npWzzt6jGnjPwURVV/LvSXzWgsIPxkphim7zD1aIf55rRPrbAOSijr5NiCpDB3jIbQswSLu0InxsFFmvZ2Yg3UhQFHvp2sPby3d2xHGMXmUBECPZnmxYegCUx6Vw7dFQxzFkf9sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:03:45 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 23:03:45 +0000
Message-ID: <a8f59a3c-d5be-4c9a-b840-07bac60caf5a@nvidia.com>
Date: Fri, 29 May 2026 16:03:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-2-nathanc@nvidia.com>
 <f4d57564-12e3-4f04-aa1c-4b828049dd15@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <f4d57564-12e3-4f04-aa1c-4b828049dd15@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: f9052d80-33cc-44c4-2a11-08debdd6892f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 4ktBHGt5kMsSpOWHi7LuUaOXKTHRKdg+7KQ6Ndv35TUwIvQ9U2lSUtSV+F9aFNZ6s5EClBxicD9UY1vHPJWFevZXcyiBUdx80SGkyzNsW0IzxQO7C6TDCeLVWDb9GMMuNqn2tebnvHcb/lrXft9S+kEcLaGOmIq96k4fQDxThXMhiHlCsrAHQoHan9luxbUwKPeEqh/SPL6ol2kHFNWpPOKKwW5Zld1uEf51csblzevuaQzgMivA7SvyEdwzd9lfltV5d8qEo1x7ea1JOcAXObY9VTxX+EUJAuW5mC9ufmDBxC2OAge7JwU8RcS9HqZIopqXAf6MgED9Y92e5Rs0S9VFavG/U0ocEgllQrW/Oa36yQ8lnMMXe3H4nCV/lh8SUvlvG1dt/QnD6oM/iv4nETk8y+uNn4o7ClRZk6b1pTs5nqNCkRBwDRW80B78UpR6EAMssaP6V2rzoIpCWvd/2tazxFqD4W9hx52diwx/snedMk9CVnWmpSu6vxonq3EuKBmT9NYzkXswQ2Lgs9KKL68Y0veIoaXYQaDk7NWZ2VfyaUNCyhdBsiHTrPEvS0eCD6nJSi7VAkXaHiXwKPtd9OfJdPnl2XtkCmHmAGgLJXxKLX3L3rTUE4hXYuUSIC1fKA0LUL+79NoVS+68Yk43oiTbV3zg89M9dj4SuQxJcyiEMABGIDnFijOjvX4xhQA7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1E1V3lndnRURFFVQm5BSXIrNHEzRmd6ZlVFMUZST0dRZWtrdmtIeUFKTHBF?=
 =?utf-8?B?SUppUE1TRUhORXdZSGRaZXFYYTRKMVMxZUVITnVqNW8vWmkvYTR2UldwN3E1?=
 =?utf-8?B?UXljU2hhcVNyVCt5VG5qRzhMS09WdHgvR3EzT2xycmY0dWJUV2VkVG1DKzNv?=
 =?utf-8?B?YnNQeWhvVnF4MG9lWlpEUlNTaThhdG1talRmeW5YWXQ1YWxrY3RDZmllK1FV?=
 =?utf-8?B?UHNyZUFZZkZlRTF6eWVIaHdmOEpva01pb2c0K0hJV3VWbUJ5T2hHeDA1ZVY4?=
 =?utf-8?B?NXNEaVFBaE9MT0EyZTYvOEwrcGo4cWQ5RmJjcmdyd0k2c3ZxeExaZkg0ZkJh?=
 =?utf-8?B?R1doclcwZFUraHdYRGU5dGpOQ0p3aG02b2syMHJadE02dzlaTkxvTlRKNTlS?=
 =?utf-8?B?a1k2WkZxVklDS0x5a3UwZTdmeDdmMGhvYnExYVlodlNHODEzb0FCRHgvdVJG?=
 =?utf-8?B?c2dyaDRsa0t5c3hTWHovZEY3SjFaRVI3THNGaE5tVVJGTDFUaDh4cXhyMXI1?=
 =?utf-8?B?eWhqTFZqdVM0amhwcmdqaEtjdE5ZWjE4MDhkUUlBRFYvN3hvanc1WTFIbVU0?=
 =?utf-8?B?N1BGeHBpT3FFclZOS0x5VmFwWi9nVWhvRTd2UE5CWFA0Vk1wbDZ3WVVoU00r?=
 =?utf-8?B?aVVRZUpJS0V3aXhqdE9lRWhDY2NDMFA1NGUvMWw0cnA3Nmx6QVdDdW9xb1dp?=
 =?utf-8?B?amhZLzBGOGRFaHZoTnNBUXY5eVpqRHhwNFNsLy9icWVTLzErbGJtYkdOcXF3?=
 =?utf-8?B?NEt4cWtqRGxWUm1OV3BCbnFndUdGNnJUY3FIOHAvVWl4SnVjeWU5THhKM285?=
 =?utf-8?B?bHlyd2lVVkNDNXBFak9jTlFLK0NlWW8wOTR4MDRpNXZOeXdsYThkMEhINHpn?=
 =?utf-8?B?M3lSdk9SUnZZZ1M2WjBiYklLVW1JWGtEWFZneEJWMWs2WVcrR3ZsRHNyRXpm?=
 =?utf-8?B?TTlUVjdFTkcza3RIUmRidmlUV2tjQUpyKzVvNTVyUm1jclUyL2pjMmhYRTE5?=
 =?utf-8?B?UFVLblpKbVRKWGhtZGp4Y291dC85RUFadHJUak5vVG56WVhHRVRRMnJOSTJK?=
 =?utf-8?B?bkwvNHV6Y1FuTCtlaENLU1ZFZTMxK1htdUVQS21CWWpNV3lwRVJEcmNybi93?=
 =?utf-8?B?dTRvWFU3WURySmp5RFdsS09LZTR5Mk5VVTF2Kzc2R2NDT0ZNbThpUWFXdkQr?=
 =?utf-8?B?b2NpOXhyaDBNZjVEUTFscW9VNUxpZ0RXTld2TlgvdXozOXJQK1pBQzYrS2sv?=
 =?utf-8?B?ZGZ6L0tweVFQbXduZDNhZ2lFem1LSjRmMnlGV2E5anZJSnZYZVcvazJua0dU?=
 =?utf-8?B?djI0WnJNRE9jRm0ycEJ1enFUeCtnUGhTOVpNVVk1MDZGRzZzeW9UdnlObE1o?=
 =?utf-8?B?dXFtaFpWd0I2UzFuMHVLWXRIei9FbEFFVlBVOTJST3ZQK3hZd0lreC9vOGtR?=
 =?utf-8?B?NUFMTXM4VDJNKzUwdm9NYmxweUVMM292eUlmdDc3V3Axb0d1REprczdnTXpi?=
 =?utf-8?B?Q3pjSTlHMTR6R3JjU1VhVGZyRmxzMmxHeHN6ZWdvc2ExRzVKQjlXS0hodHR4?=
 =?utf-8?B?bGt3MmE1MXVNcjFtajFBRmVpemdnV2VoT0lJeDBSelFBRzA4UFpoQzlTKytF?=
 =?utf-8?B?MUk1dUxPc1IxU0tUeTZsQzBLb2FldjdSYSswS1dqZUNyd1A4RTNCTHVwVHpM?=
 =?utf-8?B?ZDFPTjlxbzhiNzB0QkptR3JIVzVyMDdxbVd2b2FaSlMvWFV0M1dkL3Y4Y213?=
 =?utf-8?B?Tmh1S3ZYTlBDLzVFTWxZZ2xFQWlvOEs2cFZjOHFpRFFoLzJLSUovSldTM2l1?=
 =?utf-8?B?a2hPWlNpc085Q2llay9OdWlYallOdXV4SU9WRVlVUHVoR3gvNDFsVjJvU1RH?=
 =?utf-8?B?VFI4aHcrQVl2RFdTSHhmMk9HNjlVeVdvNW5HbjVEakltKzZmRjR6clk2VkNJ?=
 =?utf-8?B?TlRaL3A5Smd5eTVjUWNKZ3hWeTZwTlkyaDg5THUvY21EYzQ3TDg2MDJ4eHQ0?=
 =?utf-8?B?WW9DdWZyNElEeUJpTlZ2MkZLYi9xUTdTV2hPU3J3d2dUcDkxbXIxNHZXeWpt?=
 =?utf-8?B?Z0NRTnNqM09UN3I4NHdZMUdoZFR1MjV4QklnQmRUN2NjVUorOUFCbzdCanNK?=
 =?utf-8?B?VjBWKy9XclpIdnRGdThSc3owd0d4Um4vRTdXRWdqd0czYUYwVThQQ1Q5dnJT?=
 =?utf-8?B?bW5pODYvMFpHQ2doaXZQS2VIK2hSWi9Qc0pPdktQL1RleXRBZHNKTmtNTjJl?=
 =?utf-8?B?MkpsUkhVZ1N0aHQ1bHc4ZEZBYytGc2RoNHJ1WWpqUXVBNlR2VE1KTTVNUjZW?=
 =?utf-8?B?dkpYVW13U3N2N0xiSGR2bmhIQ1NpVlpFR3kvWUoxc1kzODFwNHJidz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9052d80-33cc-44c4-2a11-08debdd6892f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:03:45.7182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AIdh6/M1/GykTgpWkzS+gNGzS5gsRIKzOT2ON8CUmyGdcxDIB4gclIlDplRvREU28JLrXHx5d+UzqJRxfOhfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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



On 5/28/2026 1:35 AM, Eric Auger wrote:
> On 5/28/26 12:16 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
>> guest when handling an ATC invalidation command, as setting the ATS
>> property value to 'auto' will resolve to ATS being detected as
>> enabled in the ATC invalidation check otherwise.
>>
>> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
> nit: Reported-by whould have been more suited
I see, I will change the tag here.

Thanks,
Nathan

>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 5c2855c377..0c65dc8c91 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1528,7 +1528,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Error **errp)
>>           {
>>               SMMUDevice *sdev = smmu_find_sdev(bs, CMD_SID(&cmd));
>>   
>> -            if (!sdev || !s->ats) {
>> +            if (!sdev || !smmuv3_ats_enabled(s)) {
>>                   trace_smmuv3_unhandled_cmd(type);
>>                   break;
>>               }
> Reviewed-by: Eric Auger<eric.auger@redhat.com>
> 
> Eric


