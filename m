Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C911125865
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0OF4-0000oV-Ny; Wed, 11 Mar 2026 14:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0OF0-0000m5-Jg; Wed, 11 Mar 2026 14:25:06 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0OEy-00073y-V1; Wed, 11 Mar 2026 14:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3YVhuTtD6gu5KembS+1W+NDd7MVFRJ7uY8Mzabroob3jo0DBAZtPHYpkda7daFCl2aV+sLOPrltGjZoOIKe8M4aGDiRNjtLFv5LNptc4cPw2TknsCjOO69rT4D99xiJN/a7sdzlouTXB83rLXY0RrePOVhK5t7s3jCvo8AUJs7DRGjdWIAo1MjQEZPcdz4n6KPtvzikqwZBK5bJ2AW8pP4NvSPPWatH/aFsO0Mfjs2QtY4e8OVHDlVLMpsMEKEel373tZXaJwjQb6Hw+XoBcSeuAf+56GH0GIX/Bu/dpazwyrXSdonjZk+F7XWFQEwg6fFhvRMTTZ1/MiGVInTROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csX3f5jxmK1ErM7BBFC/e1f+ejLYseY/ZtZmzroTydU=;
 b=wBMNDWzrWSl4zSW09/eL/EK5RQ74r4qALTjX47DPGSGphBFjMOK9bmPdrg1X4quFIeoRhpurijLCij4OESOvEK0otxK3ZfKOjGFdgXvVQflqoNM8qRdbGc5Q1TimgbU6LEZZaHvHm++bK01zXeGm8lui+hDMYPmAbDO7nqEOD3RVxoxi5XXs7zUNAXj2fD40qjb5Lr6XxKXey13L/EdvU5IagdL+2zbgrxvdgzGU+oD+d7/1KyI87pyXajOM/Y8s2eSDNchElyWGFqZIRnz2JTuT2nf1iRql80Ig65xp7Ossn0v8clCC6irXgK48iaj3cPeFT41aq6gKGEQZ6TRyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csX3f5jxmK1ErM7BBFC/e1f+ejLYseY/ZtZmzroTydU=;
 b=mG7m/wWwaTvurddVfSNGN6GQebiuhfomhgFDSB9pxngLI7ANoHPIQnNmvsj9hJnXnzgus9OQlWyn7In+0p/c5hTqIXmao1DufbaintOllAqf97GmKtZa6YGquyoP70jAXAKfR5Z1p5L7IuelMIWAqaVsJn3v8iq7gs7/0zjoWUZD0odyRK7a4biP7iJcmXJ01S694vaw9aeN52/H5Zn4t5lO9lDhv3ep+h3AMFaBuwA/TB03tBGLpezWn71SVIQhQmbhrssx+6V6RA3+XluFQxOQkK9m8FgKApUG7ZTz+KCp+iUhu1H8UiiT6dd56pyZ3SD4Al2gof7oPi5yNox4HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 18:24:57 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 18:24:57 +0000
Message-ID: <480e5ab4-1574-4ef7-bfca-982bb0700423@nvidia.com>
Date: Wed, 11 Mar 2026 11:24:54 -0700
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
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <793c6796-177a-4e31-bda7-60bf2b9e1574@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 39274244-3128-428a-5fd4-08de7f9b7fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +VKen6tHdLDGY3FhSIlEc4HtBMr2EcipbVPDMN2JE32Uj1bOJAHzQv4Vi/hi7sdsEAvNnGDqRAanNNIAl8ada/TvJ7iAJSdwpQHW9k2amON2PziN7pzC4oGEp/cYpad+hbKXYTs7MZ5yEXE5QA1I0LH1N2MqB78g/4CytN4r4DBzJrNxYEM0kOLh1JoXsz7UMh8UF3KqQgAoMYxrtC2HhBxGf/bkOSt1aWLQzaNTY8F8woGzhL3x9aDR4toy3wC8tHF/Hf2oBOxv6CNTkBzqKagdohoq/MVhHGtlsP2cff+9vDA9anuO4JGsaBw3eHqHNNBSRtzXM5ULX7m8n8ubQDWqT10IAAAMk5IQcJt6/13RT3XTp2M+bwV0HIJKNFLkeQgwyVRIyjxhSJEuPwricJAF46xOv4/m4m07dDL49wAW5w07psqdUJE0dNsuU+jyxOaqqjRnOIgN6f059ejDk/2mrUVhvETjWoEIhu96ufkQ4UFlENcWWxA7pzThVQx0MDfnh8LlsCV8qa5btJFPrfsbFuXo76bWU/UKSCrhVIpda51uCMzPBA706MKyrt2Sp+Grrz6NGTXRs1soveMTyl+mYvKCP0Y1w4v4BPMrb8BXBbxOk5qVTZJxBDXeJu5DLzGNw3IUVUZdbTmy1VqtX7zKS9bQIOogRZpbNmJKhv8bNQS+UcJmvg6+5tIeYYx1rsD32CWDVJymelKUJb9Ovz7vrfCiSbsvTl8kH9ld3RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFppSnQyU2FkU0xLalMyc21tNXZjd1I3L3RYcnFaVGJwdGtrd2pYZXE2YldN?=
 =?utf-8?B?MHJ4ZjkxNWYxM2pIUEdSQnc4UXVqeDlyUERPRXRSemtZK3h4cVZKd2w5cU5i?=
 =?utf-8?B?RWJ4Q2lJRDRJQk1LNDNVM25tRVpYY0g1N1V2Q3JOQUxtVDlRMkpwT2J1UFor?=
 =?utf-8?B?UHlFYzZUU2hzdWRvaHBBQ2QxL1VkTTRlenF5ZU1uMjNKUGNaOTQ3aWc0RW5x?=
 =?utf-8?B?T29GVzZEYjhTK0R3akdwY20wYldqZVk3dEdiNUE3bkVMcFU3eko3VjNRdm9D?=
 =?utf-8?B?Z2RQMmNhSnhsTWVIamRwYzVxejd5cCttYWhHa3VFaStlS3RkNXVLMTVvYVE0?=
 =?utf-8?B?SmFzb0FrMTJ1VUNRYndoY1Z0d2VybkFsTDJKeXNjTktlaGIyRjVuNmRZWFJa?=
 =?utf-8?B?VU80VnhvMXRNdm5LVkVaT01wbXJxSy83aXV4d1Y3b0RwSkxhci96aERQaDR0?=
 =?utf-8?B?T2NGQW1rMUZMYnYzL0lwcHpnOHBwRStuVmYyZ3B6dTVlT0k4NUtvd2JBRGdn?=
 =?utf-8?B?QzJIcnJlNysvMzk1SDBIZlRXSm5QVG5oanFKUmlydmlEdk5NOHlpSkJIejdx?=
 =?utf-8?B?VjFtYzR5czlRaUpSbFZ0NTZRZXZlWWxVaUNaN1ZMNmpLdTNtd1pZRlJJQ1VK?=
 =?utf-8?B?ZFVxRkJCWFNtK0tKaHlQUUhZL1htUXpuUXFEUW5rR2liMEE5WDkveUlKSHB3?=
 =?utf-8?B?OUFCTnZhaUpkclM1T2w5TitIdzFUbEtKOGNjTmxKYkM0RXhZbGd3Y3RuQUV2?=
 =?utf-8?B?dXpHQy9JWGNZeFlrZXlORmozR1lrNjlHTUlpVlgzVHJKYmlwRWZnTFR6SVV2?=
 =?utf-8?B?Qkk1OWQyRFJMaHpnTkFPUGJKa0tKbHhvQ2hnTG1TS0RjT2pPd1htcEpudm9B?=
 =?utf-8?B?ZzY3eGtzUlFxMkhrb3AwcmEvSWk5d05MUmtBVnhjd0VHVjZkZ1crWllwSWxl?=
 =?utf-8?B?ZDFVK0JoYXFvVnpFbkFEd2FiblVlZFdNRW15VGo5RHd5S1BQMXoreFUzcXNF?=
 =?utf-8?B?ZU83UkRNS3p1dlBxMzU4WXhQcWk0N3dJOXN0SEw2OVZNWHlvRFJZSUxWVGpq?=
 =?utf-8?B?dkVIV1QyZ2FiM2VXMlNpV2Ztb0lRVGUvUUZhT2wyM3ViMVl6dCtNb0FwU0JN?=
 =?utf-8?B?MGdWa2JFd2JBaDREdk52SlZ4ZlE5ejB2QW93ZEdTcUptMU1TVEtMWXV0Nmgw?=
 =?utf-8?B?cnpHMFM1bTJucjZCa0MwNGl4c2FKajNBVWhUbWJia1VBZjFqbTdXRENObjUr?=
 =?utf-8?B?M0Z4clFSb3Bvdzd0RzRWUzZxZUc2L3dWaXY5eFg3dmVVKzJENWJNU0xDNU9Z?=
 =?utf-8?B?SDdWTWJMb1VQU2daakswQUsvVUNaSERGNUJvYXVVMDNhclo4cUVGM0xOWUVv?=
 =?utf-8?B?azNneW1UZVd1L2hHSE83WXZ6dEptOGpBcGRMMG4xR00vclpZZHU2ODNIUzhU?=
 =?utf-8?B?MWt3NmoydEJGOUE2OThJN3dMSFNPeWNkTUN6SklCMHFhRXp6alBCUm9IWkFm?=
 =?utf-8?B?SmxSSU4vTFVIK25PK0VqRnFSbG1iWkpwaG5mRURoZ1J2ckhMUCt1VTFpTHBu?=
 =?utf-8?B?ZXQyNFBPM1lBNzhmTnlGcExCU3pCZy9YeXE3VlVEYU9PK3hhd3E5akJZcmRr?=
 =?utf-8?B?R2MxRlRqQ1poT1NadjBxYTJwMFJvVENuQktrbjRNVFhkQlc3ZDk2UWJSVVNl?=
 =?utf-8?B?RTB6TmRZV25rRytoSXd2ZUZCSlV2QmRFK3NJZ1ZvNzdSZ2NFUndudnNVa2kr?=
 =?utf-8?B?QUl6NVNlSWx1anpTOU9qMWVsb1hSYXo3bXA3OVYyZi9Gc3VpaVpRRFlDZzM2?=
 =?utf-8?B?a09LcHMyN2dCdy8vU25YRUZ0dE9pRExGcGVEQm44K2hmM1VjNXJKdW1IQXM3?=
 =?utf-8?B?N2VJNVZyVEp3UGNyVUZuMll0WVY1TzZNS1p6R3B5K2ZIdCtJMTc1dnNXOFAr?=
 =?utf-8?B?d01oZk1HNkFDYVB1aE9wVm5xODA2M3p1RDJMUUZ0MVpsejR3TTNNQlpoVXEr?=
 =?utf-8?B?bU45eGZ1bnBSaG9maTRVeEJ1M2RKYnBjeWhrOStiVXZiVXVmZmtsWndjV3Ey?=
 =?utf-8?B?d2dvUm12NExITzJVWmV0Q08xemhPcnV0QXI4WG5hNXRRMEdlek5oVU1qMlJI?=
 =?utf-8?B?aWxaOGl0ZFlQZ0Nqc1g1MFZiZXRCeGNBZWE4OVU1V3kvYlhjZU9uY29Nenlr?=
 =?utf-8?B?UGY4OUYvYkE5WkZQRXdZUWVqNStmSU9lUVdXdFlyNTRQckVzMTZhbGNhUkVN?=
 =?utf-8?B?bjFldThyTUltZUJHaVg4YjJTdnNtLzhDcXBib3BVMFYyY2tBSkZKSHg1SGpl?=
 =?utf-8?B?Q1ZwZlhuS21sWFgwOWhUV1hFa0xjc1laWEtTYmpqUnR1TnZ3OFFxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39274244-3128-428a-5fd4-08de7f9b7fb3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 18:24:57.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/+QCK/opG8Io6auIiD2IN9PPayYDP4pIAOpOaLNhoMEg/agkLngVh7yXcIuWj4aERKC5maAowFVcmaA92ohKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

Hi Eric,

On 3/11/2026 11:20 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 3/9/26 8:21 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Introduce a new enum type property allowing to set an Output Address
>> Size. Values are auto, 44, and 48, where a value of N specifies an
>> N-bit OAS.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/core/qdev-properties-system.c         | 13 +++++++++++++
>>   include/hw/core/qdev-properties-system.h |  3 +++
>>   qapi/misc-arm.json                       | 16 ++++++++++++++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
>> index 4aca1d4326..a805ee2e1f 100644
>> --- a/hw/core/qdev-properties-system.c
>> +++ b/hw/core/qdev-properties-system.c
>> @@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
>>       .set_default_value = qdev_propinfo_set_default_value_enum,
>>   };
>>   
>> +/* --- OasMode --- */
>> +
>> +QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
>> +
>> +const PropertyInfo qdev_prop_oas_mode = {
>> +    .type = "OasMode",
>> +    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
>> +    .enum_table = &OasMode_lookup,
>> +    .get = qdev_propinfo_get_enum,
>> +    .set = qdev_propinfo_set_enum,
>> +    .set_default_value = qdev_propinfo_set_default_value_enum,
>> +};
>> +
>>   /* --- Reserved Region --- */
>>   
>>   /*
>> diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
>> index 4708885164..2cbea16d61 100644
>> --- a/include/hw/core/qdev-properties-system.h
>> +++ b/include/hw/core/qdev-properties-system.h
>> @@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
>>   extern const PropertyInfo qdev_prop_granule_mode;
>>   extern const PropertyInfo qdev_prop_zero_page_detection;
>>   extern const PropertyInfo qdev_prop_ssidsize_mode;
>> +extern const PropertyInfo qdev_prop_oas_mode;
>>   extern const PropertyInfo qdev_prop_losttickpolicy;
>>   extern const PropertyInfo qdev_prop_blockdev_on_error;
>>   extern const PropertyInfo qdev_prop_bios_chs_trans;
>> @@ -64,6 +65,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
>>                          ZeroPageDetection)
>>   #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
>> +#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
>>   #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
>>       DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
>>                           LostTickPolicy)
>> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
>> index b372a3661b..76b6965502 100644
>> --- a/qapi/misc-arm.json
>> +++ b/qapi/misc-arm.json
>> @@ -60,3 +60,19 @@
>>   { 'enum': 'SsidSizeMode',
>>     'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>>               '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ] }
>> +
>> +##
>> +# @OasMode:
>> +#
>> +# SMMUv3 Output Address Size configuration mode.
>> +#
>> +# @auto: derive from host IOMMU capabilities
>> +#
>> +# @44: 44-bit output address size
>> +#
>> +# @48: 48-bit output address size
>> +#
>> +# Since: 11.0
>> +##
>> +{ 'enum': 'OasMode',
>> +  'data': [ 'auto', '44', '48' ] }
> you also miss other enum values

I left out the other possible OAS values because only 44 and 48 are 
supported per the previous accel SMMUv3 series. Should we still include 
the other possible OAS values according to the SMMUv3 spec? If we do, we 
would end up hitting that check for 44 or 48 bit OAS when a different 
value is specified.

Thanks,
Nathan

