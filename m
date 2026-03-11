Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F73C1125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OCJ-00080y-5A; Wed, 11 Mar 2026 14:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0OC8-00080R-E2; Wed, 11 Mar 2026 14:22:09 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0OC6-0006YG-Fq; Wed, 11 Mar 2026 14:22:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yib0PdJ52iVk4hmwygAAHolY5Q6GD6c+gbGH11nxPdeH+Wv+BiF13KU4HoaILaRLa7jGrcJbsP/orU7lEJ5KmfZsLfZmKtglCPi1mStzzG+itBnlYBajo/vpvwYv9QAkajcHc2Q91OSL9f4f2cVou8/+yBmYISyvjTuP2IcoPSpkgrmi77+Kd5zvuwfhoH5L9psEantJApERcTx1PrMIyW/NP76WLy5+d8NL8nXb27tRgG/qWvMSG9GV4gfS+dnit96kZVVvqbo1HtzOgrhbDyEJWRJbygSJ6Wf++kY8PpT23NtuvH5x5cMts3NMTfYQfqnuXhgXKQPrRQ4v9EC8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP/Axy+jts2BSlEsBXSSKZVJQmhwJRPi5j+3u7+GjOw=;
 b=oeBX60EPnLkWLc8wYlQUqutgC2LBCB+CGci7jOILsUNVHuYaNcASiHPZBO1+H18VaH7JZQYGcjiLoCe8L0UNGnaFD2SYumKZCCrv2Mi0613Lgucnafz98nHDBMsStb2Nw1H5XsowfEoou/ippsKwLSAk/XGyIGjrS3TPbI8CS/LRJD7zzbyYH3abjA8UWnOW+zxy+2YvgaXjeeYXRZZLXrRmOZDIMfwbUdS8qLCpeDkVTE2F/iao+4IKvuizBZqk7o+VlyaflxQejmOWI+qUoUIVUfRe6Y8ARF1oCloNbR035EtE8EhZlN/J5So5wF/pmdUvyiifCnKNULoz7/OMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP/Axy+jts2BSlEsBXSSKZVJQmhwJRPi5j+3u7+GjOw=;
 b=prd4oqkQSciGoI0c4sfRMELTHsNMoj+41eRNs0Zpm89WkXh/x4JcwCd5up8GbrZltiLVYo4K4YvCsTROe03pPSOkLmJhlf+hCHuz8CXBVHY1N/dgGo6EMSInTTJqZJVvEVJRI/mwvpk5BzlrfdJM2ALsxyOL5ToKqZF6nzQIFHdJuGfvGBxmqkm9ofWChAij07O/XER8bv1RR2ibLeMZjC/TZKFB308JU+VUw2jw3QLgN2S5xYnB6SXLmRFs23J0AbE95XtBhILJMGQopoQyf1HXpm4PLQ8TnHdCFIVcly5Ngbl1pnK7M/dBIaS1C9UmGrk9s9bzDXQPVgtrwYWi5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Wed, 11 Mar 2026 18:21:59 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 18:21:59 +0000
Message-ID: <8c43a00e-ca9e-46dd-a7c5-9f53061946b7@nvidia.com>
Date: Wed, 11 Mar 2026 11:21:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
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
 <20260309192119.870186-3-nathanc@nvidia.com>
 <ce715e79-ea70-46c1-80c7-6290ad0567f0@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <ce715e79-ea70-46c1-80c7-6290ad0567f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f66e2ef-37d0-4367-58e3-08de7f9b15d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: k2U6tVfkU3SNu72d02fvmSkXBRvqHpnk99uSkjqqx0eMcuU92p8gBo2WiGgB9u0UjTex7ItI/KBqFGdTUm0aH97Djs3cuqnY+xWPVGvMvxxPKeCqAVEznkvJtAqfORWa1lczY1WHctPSVN+3b/kXu+TQoKMEMFPFMugzfqG1cW35cDYFQjsTcS3o/9ZeHXlU+3l3mmoAQQKdQf+aM9I75ZatNeHDz/+vMynrEcKLQAN+sdVe3WWP/ckRDLf0iWgmpPuAWnnDCJfB9hT774H+qGsGv8dFNR3XAroM29coANIWTuDh+urjDRFnkTxPFMgXiDCFSeRTyGYAwM9xwjgXY4CGXFK2pGy0GtGM2FUEwxKPUeZs8YSc4HprNCBgsOXBTC+sgJP7KSz8PovCbx1YMNbbqqpvithrEy1O50h4HjWGUS+2DrYxAb1QmLfFwA6CxNS+9OxwXUtojvWvKvz9DKcNgdPAFdcw+DGQ1e97yuIEBa9fYE+/p4QLUKNw3BAH+7UHPZ9J24lzAXDlM4YjbMroBZ9nTBX6GvoEOnFNekObuLrhszQmEL47QQktchgfso+DzWbSOvjQPWOdlfSk814uNIXOH2PMAitDB8hZxZsSnsOftWxkXZ4x4AzvT0jNL4c/ModySRvRstu8unFrXzkFuiV5uFRtQUeZqsZS70DXGoBA3hXDIkmDSW295O9UVh3ufCy8fP7u5Y7ne0jrC4pzhruZXMC1v3iesmj8hxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MCtFWVRvYk5hWjJJQ3FOcE1uK2xTT2h2bWFtenpHU0RGRWxSY3U5QVo3R3FI?=
 =?utf-8?B?TVNoR0ozdXJUWDZ4QVRyVkJQSkJhQkpNdVhXR1c4WGRUaUZlL2VmMlkvcm9J?=
 =?utf-8?B?Nnl1VU5RR3VvRmJSUEZhVVJhTkZtblBPeXloaitFYTBsQnFUSTF6T1FSMHBW?=
 =?utf-8?B?L1FZY3NCb3luT1A1ckI0OCtINkI1T2tSd1ZPVkU2R2w5dnBFak5sM0ltRnl2?=
 =?utf-8?B?UmhpTlZ1a3NidXJaZTZKR2RveElyS2VIaWtic2ZQbitKdk5wOE14a2M1aG9k?=
 =?utf-8?B?NjFVM2hnN1BVQmRKWDRvK2grL3RKTGRhbkpuQXcyZG4yNERORHRGMDJuYWow?=
 =?utf-8?B?OWxIc01NQ2UvK09XZlZpOHYvOFpEOWJScURmTXhHbFpJMnpEdjVsenRJMEJX?=
 =?utf-8?B?VkMrKzVLaWJrYUpkTWQwTXNtSkQxb0FpQUJBOWZ5RmF2WVBHNzBLNW9iTjdi?=
 =?utf-8?B?ZytVcXBZVHRlcTRpWDduNmpvakxUYWpLalo3TnQ4UUxkMlZGR1NWaXd0RW5m?=
 =?utf-8?B?RkZ4TXZRMythRGVzTW50c3Z0Wmd5Y2YzQUl3V3NNY2Y2dERJeUV1azRFbXF2?=
 =?utf-8?B?aDY3QlkvRlROVVpQM0FMRTJOaDJWN1ZrY1dqdTFyQ2JPdW56L1pzbDBsMkZx?=
 =?utf-8?B?MGxNQUh5NHZnZ2VIbnFCcWFvUmdMbzBYMGdKQkZpWEVncnZLWDhkZXorZ3k2?=
 =?utf-8?B?ejM1TUIrOGdDVGd1K3ZBWjk4MnExMU94L3RJSkQ4aFdpaFZXcWIrYW5heTVB?=
 =?utf-8?B?Z1dpSnptR1dCVlZrc2FlSmY1UnZPUjVwQkd2MVM4d0h1NXN6OU4rclkzWFJW?=
 =?utf-8?B?eUdhdk1YcEdseEVlRHlwMWc4Zmw5dTdqN2QrWjNKb3VSd3RsUzRSeDZIcmRv?=
 =?utf-8?B?TitHVThSdnl0OG1ueWNnLzJsRGhJL0VoTW91SlZ2RWUwS2M0SU1RNUFJYlMz?=
 =?utf-8?B?L2JvUitYYlRVMXd2Z2xQMEUvRUEyRnJtU3pVMjcyYVkzd01odmd6K2J4Qitn?=
 =?utf-8?B?U1pHdmR3YURYRCtuU2ROLzNPSVpSOWx6c3dxemZzcnVmN1hZUmRNQnlNRHRw?=
 =?utf-8?B?R2wvblVRV1BZRGlKdFNwNjlIVm9ZUlFGK2dReERkVEcyRTEvTEZQeC9uL0pr?=
 =?utf-8?B?aXJ3RzRFRlI1VXJlSWZBVEszRlZVRE1WeWtIWDlYZzcra2o4dVZlS093am5F?=
 =?utf-8?B?cUh3dlhiZ00zajNZRWx1dEMzMkNnQnk4bGNOV0ZsaHFmUlEyM2VqckhaN0lw?=
 =?utf-8?B?eVhQYXdjcXJJZW1CRnJkcG4rbjZTNGFNZ3lDVE9jMjF0Z1g0YkorVzBKazN5?=
 =?utf-8?B?bzhIalU4MGs3WnBhbG1mbkhyc1E1cXhGZGJtbkZvMHJSeGhqYzJBVERESlVO?=
 =?utf-8?B?aUl0dm9qRW1zRmw5azhVMHpCemlVQ0tMVkw4dnN3U0E5NTBPQlNqUEdwNndk?=
 =?utf-8?B?eG1pTzVTY0ttZ2NyUnNXS1MvNkNPdXJtZ3hqc3o2Rms3dHR1L3hlNTEzdWlG?=
 =?utf-8?B?ZW5ZWVh4Ykx0YU4vM3BPSnZzM2xDUW12Q1EvWlJIRUF5UVRDSVFzK3k4Wk9I?=
 =?utf-8?B?RjZLdjByWEU3UXpES25sQ29OYUF5eUVXcll5YkR2N1Q1NjF2Y2cwODRoeEwx?=
 =?utf-8?B?T1hMQU0rSWUrdU0vd3ViQm9vdnR6VE1iZG53N1ZGODJMMWVMZTNxZUZ2c3k2?=
 =?utf-8?B?SzZhRHFENXAwcHV2T1cxTzY0RnluSUIxVmlsYlZSOG5zUXhEZ1ZyMXFkTkpC?=
 =?utf-8?B?eGlwZmFVN0xDTktQTFZCSEdPcEZ2L2pHY212UmlUa0NkSkhqYjUrUmt5SDVh?=
 =?utf-8?B?Vks5T1hmZld6UU5qU2ZvVDYrWlRYbm93bm9CNzJRejI2QXRZZVduQkJFdTZp?=
 =?utf-8?B?Sk9XNWdjdVV3T05ndkFFSldYZjFjNy81YUJSS0xHdi95Z1Y5aGIxZXpicGZl?=
 =?utf-8?B?Yjh3eFJkbmlHNTVTKzRnLzlxZ1dLeURyYmd1QUxvSnNCeldFY21LaXBaMnky?=
 =?utf-8?B?MkcwbGNidExKSVovaHB1NnFxdXZJL24rcW5vQWIvUWpSOTdSVzRuYy83WXFN?=
 =?utf-8?B?T2dZWThlVmFZZFF3WVNSZi9kZ0pOSVNVUHN6eFVtd2NtRTh3U3AvYU43RS9E?=
 =?utf-8?B?WnM3UHoxekNCTHVrSFBKa2RGOGd2OEdRUTllZTNmVGJhRUtzbmEvUGZDdzNj?=
 =?utf-8?B?cXRaQm40M2JidVFhNi9aNUcwMWJIQ1BwRnZjVmRpSS9IWDExZUpVVDd0b1Nz?=
 =?utf-8?B?VS9zcjNWMi9Kd3F0R3pHeHFKWDBJeno2MVc3Z3ZRaE1lTXM0MEZDWSs1ak8y?=
 =?utf-8?B?dmltUzJnaW1xNng0T2ZXeHRqeVY0OEUzeVpRZkFuZ0Zja0RpdW11UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66e2ef-37d0-4367-58e3-08de7f9b15d2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 18:21:59.7132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVRpOfjCY/jMNgDi5A1/+R2xWrGcWtkY+r/dWqKhnyGo4B2MP0onEcqSRQgEj/i+XNLycQrZE743C5tELxSdNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/11/2026 11:10 AM, Eric Auger wrote:
> On 3/9/26 8:21 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Set the default value of ATS to auto. The default for ATS support used
>> to be set to off, but we change it to match what the host IOMMU
>> properties report.
>>
>> Add a "ats-enabled" read-only property for smmuv3 to address an
>> expected bool for the "ats" property in iort_smmuv3_devices().
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>   hw/arm/smmuv3.c          | 12 ++++++++++--
>>   hw/arm/virt-acpi-build.c |  2 +-
>>   include/hw/arm/smmuv3.h  |  2 +-
>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 617629bacd..8fec335557 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>           return;
>>       }
>>   
>> +    /* Update ATS if auto from info */
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>           return false;
>>       }
>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>> +                   " Services");
>> +        return false;
>> +    }
> Shouldn't this chunk be a separate fix for previous accel SMMU series?
> 
Yes, I'll separate this out to be a separate commit in the next refresh.

>>   
>>       /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>   
>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>> +    /* Only override ATS if user explicitly set ON or OFF */
>> +    if (s->ats == ON_OFF_AUTO_ON) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>> +    }
>>   
>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>       if (s->oas == SMMU_OAS_48BIT) {
>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>> +
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 068108e49b..197ba7c77b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>       smmuv3_accel_idr_override(s);
>>   }
>>   
>> +static bool get_ats_enabled(Object *obj, Error **errp)
>> +{
>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>> +}
>> +
>>   static void smmuv3_reset(SMMUv3State *s)
>>   {
>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>> @@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "ril can only be disabled if accel=on");
>>               return false;
>>           }
>> -        if (s->ats) {
>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>               error_setg(errp, "ats can only be enabled if accel=on");
>>               return false;
>>           }
>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>       /* RIL can be turned off for accel cases */
>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>>       DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>>   };
>> @@ -2153,6 +2159,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>       dc->hotpluggable = false;
>>       dc->user_creatable = true;
>>   
>> +    object_class_property_add_bool(klass, "ats-enabled", get_ats_enabled, NULL);
>> +
>>       object_class_property_set_description(klass, "accel",
>>           "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>>           "configured in nested mode for vfio-pci dev assignment");
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 719d2f994e..6c77fc5f6a 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
>>   
>>       bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
>>       sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
>> -    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
>> +    sdev.ats = object_property_get_bool(obj, "ats-enabled", &error_abort);
> are we obliged to use a prop here.
> we can dynamic cast to the TYPE_ARM_SMMUV3 and use an exported helper, no?

I'll look into replacing this ats-enabled prop with a helper that 
accepts the dynamic casted TYPE_ARM_SMMUV3 object and determines whether 
ATS support is being advertised.

Thanks,
Nathan

